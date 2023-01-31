unit frmSalesOrderPrn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmSalesPrnBase, DB, ActnList, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, Shader, StdCtrls, ExtCtrls, DNMPanel, DNMSpeedButton, Grids,
  Wwdbigrd, Wwdbgrid, ComCtrls, BusObjSales, kbmMemTable, 
  ProgressDialog, wwDialog, Wwlocate, PrintDAT, Buttons, wwdbdatetimepicker,
  wwdblook, AdvOfficeStatusBar, UserLockObj, DAScript, MyScript, wwcheckbox,
  CustomInputBox;

type
  TSalesOrderPrnGUI = class(TSalesPrnBaseGUI)
    btnChangeStatus: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    chkProductFilter1: TCheckBox;
    chkproductfilter2: TCheckBox;
    qryMainSaleStatus: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnChangeStatusClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkProductFilter1Click(Sender: TObject);
    procedure chkproductfilter2Click(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
  private
    InvalidRecordselected:Boolean;
    NewStatus:String;
    UserLock: TUserLock;
    ChangeStatusSQL:TStringList;
    function getNewStatus: String;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);Override;
    function getReportType: String;Override;
    function getDocumentName: string;Override;
    function getSalesObj: TSales;Override;
    function GetReportTypeID: integer;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;

  public
    procedure RefreshQuery;Override;
  end;


implementation

uses Commonlib,systemlib, AppEnvironment, tcConst, CommonDbLib, frmSimpleTypes,
  tcDataUtils, FastFuncs;


{$R *.dfm}

procedure TSalesOrderPrnGUI.btnChangeStatusClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  DisableForm;
  try
    if grdMain.SelectedList.Count < 1 then begin
        CommonLib.MessageDlgXP_Vista(
                'You must at least pick one sales order before changing the status.  Hold down the Ctrl Key and left click with your mouse to choose orders',
                mtInformation, [mbOK], 0);
        Exit;
    end;

    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnChangeSalesOrderStatus')>2  then begin{1: full access / 2:full access with no delete}
      CommonLib.MessageDlgXP_Vista('You don''t have access to change the Sales Order Status' , mtWarning, [mbok],0);
      exit;
    end;

    IterateProcNo := 3;
    InvalidRecordselected := False;
    IterateselectedRecordsReverse(true, WaitMsg);
    if grdMain.SelectedList.Count < 1 then begin
      if InvalidRecordselected then MessageDlgXP_Vista('Sales Orders Selected were all converted.  It is not possible to change the status of converted Sales Orders', mtWarning, [mbOK], 0);
      exit;
    end;
    s:= '';
    if InvalidRecordselected then s:= 'Converted Sales Orders are Removed from the selection as status of the Converted Sales Orders cannot be changed.'+chr(13)+chr(13);
    if CommonLib.MessageDlgXP_Vista(s+ 'Are you sure you want to change the status of all selected Sales Order(s)?',mtInformation, [mbYes,mbNo], 0) = mrNo then Exit;

    InvalidRecordselected:= False;

    NewStatus:= getNewStatus;
    if NewStatus = '' then exit;

    if (SameText(newStatus ,'Approved')) then
      if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanApproveSalesOrder') <> 1 then begin
        CommonLib.MessageDlgXP_Vista( 'You don''t have Access to Approve Sales Order', mtWarning, [mbok], 0);
        Exit;
      end;

    if (SameText(NewStatus ,'Delivered')) then
      if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanDeliverSalesOrder') <> 1 then begin
        CommonLib.MessageDlgXP_Vista( 'You don''t have Access to Deliver Sales Order', mtWarning, [mbok], 0);
        Exit;
      end;

    IterateProcNo := 4;
    UserLock := TUserLock.Create(Self);
    try
      ChangeStatusSQL:= TStringlist.create;
      try
        IterateselectedRecords(true, WaitMsg);
        if changeStatusSQL.count >0 then begin
          ExecuteSQL(ChangeStatusSQl.text);
        end;
      finally
        FreeandNil(ChangeSTatusSQL);
      end;
    finally
      Userlock.Unlock(Self.Caption);
      FreeandNil(UserLock);
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderPrnGUI.btnImportClick(Sender: TObject);
begin
  inherited;
//  DoImportListJson;
end;

procedure TSalesOrderPrnGUI.chkProductFilter1Click(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TSalesOrderPrnGUI.chkproductfilter2Click(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TSalesOrderPrnGUI.FormCreate(Sender: TObject);
begin
  inherited;
  continuousreportname := 'Sales Order Continuous';
end;

procedure TSalesOrderPrnGUI.FormShow(Sender: TObject);
begin
  inherited;
  chkProductFilter1.visible := Appenv.companyprefs.InsurancereportOrderbyProductNameStartswith1 <> '';
  chkProductFilter1.Caption := '  Sales with Products Starting' + #13#10 +'  with ' +Quotedstr(Appenv.companyprefs.InsurancereportOrderbyProductNameStartswith1);
  chkProductFilter2.visible := Appenv.companyprefs.InsurancereportOrderbyProductNameStartswith2 <> '';
  chkProductFilter2.Caption := '  Sales with Products Starting' + #13#10 +'  with ' +Quotedstr(Appenv.companyprefs.InsurancereportOrderbyProductNameStartswith2);
end;

function TSalesOrderPrnGUI.getDocumentName: string;
begin
  Result := TSalesOrder.Classname;
end;

function TSalesOrderPrnGUI.getNewStatus: String;
begin
  result := GetSimpleType(TfmSimpleTypes.DoSimpleTypesSelect('LeadStatusType'));
end;

function TSalesOrderPrnGUI.getReportType: String;
begin
  REsult := 'SalesOrder';
end;

function TSalesOrderPrnGUI.getSalesObj: TSales;
begin
  Result := TSalesOrder.create(Self);
end;
procedure TSalesOrderPrnGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);
begin
    {Validate for conversion }
    if IterateProcNo = 3 then begin
      if QrymainConverted.asBoolean then begin
        InvalidRecordselected:= True;
        grdmain.UnselectRecord;
      end;
    end else if IterateProcNo = 4 then begin
      if UserLock.Lock('tblsales', qrymainSaleId.asInteger, Self.Caption) then
          ChangeStatusSQL.add('update tblSales Set QuoteStatus = ' +quotedstr(NewStatus)+' where SaleId = ' +inttostr(QrymainSaleId.asInteger)+';');
    end;
end;

procedure TSalesOrderPrnGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('ExtrafilterOptions') then begin
      chkProductFilter1.checked  := StrToboolean(GuiPrefs.Node['ExtrafilterOptions.Productstartswith1'].AsString);
      chkProductFilter2.checked  := StrToboolean(GuiPrefs.Node['ExtrafilterOptions.Productstartswith2'].AsString);
  end;
end;

procedure TSalesOrderPrnGUI.RefreshQuery;
begin
  if chkProductFilter1.checked = False then begin
    Qrymain.Params.Parambyname('ProductnamefilterOption1').asInteger :=0;
  end else begin
    Qrymain.Params.Parambyname('ProductnamefilterOption1').asInteger :=1;
    Qrymain.Params.Parambyname('ProductnamefilterProductName1').asString := Appenv.companyprefs.InsurancereportOrderbyProductNameStartswith1;
  end;
  if chkProductFilter2.checked = False then begin
    Qrymain.Params.Parambyname('ProductnamefilterOption2').asInteger :=0;
  end else begin
    Qrymain.Params.Parambyname('ProductnamefilterOption2').asInteger :=1;
    Qrymain.Params.Parambyname('ProductnamefilterProductName2').asString := Appenv.companyprefs.InsurancereportOrderbyProductNameStartswith2;
  end;
  inherited;
end;

procedure TSalesOrderPrnGUI.WriteGuiPrefExtra;
begin
  inherited;
    GuiPrefs.Node['ExtrafilterOptions.Productstartswith1'].AsString        := BooleanToStr(chkProductFilter1.checked);
    GuiPrefs.Node['ExtrafilterOptions.Productstartswith2'].AsString        := BooleanToStr(chkProductFilter2.checked);
end;

function TSalesOrderPrnGUI.GetReportTypeID: integer;
begin
  Result := 25;
end;
initialization
  RegisterClassOnce(TSalesOrderPrnGUI);
end.
