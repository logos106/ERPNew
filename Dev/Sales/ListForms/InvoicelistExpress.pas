unit InvoicelistExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SaleslistExpress, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TInvoicelistExpressGUI = class(TSaleslistExpressGUI)
    btnBOlist: TDNMSpeedButton;
    qryMainBORef: TWideStringField;
    btnPrintMatrix: TDNMSpeedButton;
    qryMainHasSignature: TWideStringField;
    qryMainTransDate: TDateField;
    qryMainTransTime: TTimeField;
    qryMainQuoteGlobalRef: TWideStringField;
    qryMainSalesOrderGlobalRef: TWideStringField;
    qryMainRepairGlobalRef: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);override;
    procedure cmdNewClick(Sender: TObject);
    procedure btnBOlistClick(Sender: TObject);
    procedure btnPrintMatrixClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    Function ExpressDetailListName:String;Override;
    Function ListType:String;Override;
    procedure SetGridColumns; Override;
    function GetReportTypeID: integer; Override;
    Function LoadReportTypesconditions:String;Override;
    Function DefaultAllClasses :Integer;Override;
    function ExtraFields: String;Override;
  public
    Procedure RefreshQuery;override;
  end;

implementation

uses CommonLib, CommonFormLib, BackOrderInvoiceExpress, MatrixObj, SystemLib,
  AppEnvironment, BaseListingForm;

{$R *.dfm}

{ TInvoicelistExpressGUI }

procedure TInvoicelistExpressGUI.btnBOlistClick(Sender: TObject);
var
  BackOrdersList: TComponent;
begin
  DisableForm;
  try
    inherited;
    BackOrdersList := GetComponentByClassName('TbackorderInvoiceExpressGUI');
    if Assigned(BackOrdersList) then begin
      TbackorderInvoiceExpressGUI(BackOrdersList).FormStyle := fsMDIChild;
      TbackorderInvoiceExpressGUI(BackOrdersList).BringToFront;
      Self.Close;
    end;
  finally
    EnableForm;
  end;
end;

function TInvoicelistExpressGUI.GetReportTypeID: integer;
begin
    Result := 11;
end;
function TInvoicelistExpressGUI.LoadReportTypesconditions: String;
begin
  REsult := ' and (TemplName like ' + Quotedstr('%(Matrix-Y)%') +'  or TemplName like ' + Quotedstr('%(Matrix-X)%')+')';
end;

procedure TInvoicelistExpressGUI.RefreshQuery;
begin
  inherited;
end;

procedure TInvoicelistExpressGUI.btnPrintMatrixClick(Sender: TObject);
var
  strSQL:String;
  fsReport:String;
begin
  inherited;
  ChkChooseRpt.Checked := True;
  try
      fsReport:= ReportName;
      if fsReport = '' then exit;
      if  (Stringcontains(fsReport,'(Matrix-Y)')) or (Stringcontains(fsReport,'(Matrix-X)')) then begin
        with TMatrixsale.Create(Self) do try
          SaleID := QrymainSaleID.asInteger;
          MakeMatrixTable(Stringcontains(fsReport,'(Matrix-Y)'));
          strSQL :=  SalesMatrixReportSQL(True, Stringcontains(fsReport,'(BOM)'));
          ReportSQLSupplied := True;
          PrintTemplateReport(fsReport, strSQL, False, 1 , SaleaMtrixMasterDetailLink(Stringcontains(fsReport,'(BOM)')));
        finally
          free;
        end;
      end;
  finally
    ChkChooseRpt.Checked := False;
  end;
end;

procedure TInvoicelistExpressGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TInvoiceGUI' , 0);
end;

function TInvoicelistExpressGUI.DefaultAllClasses: Integer;
begin
  result := inherited DefaultAllClasses;
  if result <0 then
    if not Appenv.CompanyPrefs.InvoiceClassDefaultAll then result := 2 ;
end;

function TInvoicelistExpressGUI.ExpressDetailListName: String;
begin
  REsult := 'TInvoiceListGUI';
end;

function TInvoicelistExpressGUI.ExtraFields: String;
var
  st:TStringlist;
begin
  st:= tStringlist.create;
  try
    st.Add('S.QuoteGlobalRef as  QuoteGlobalRef  ,');
    st.Add('S.SalesOrderGlobalRef as  SalesOrderGlobalRef  ,');
    st.Add('S.RepairGlobalRef as  RepairGlobalRef  ,');
    Result := st.Text
  finally
    Freeandnil(st);
  end;
end;

procedure TInvoicelistExpressGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if Appenv.CompanyPrefs.InvoiceClassDefaultAll  then SelectionOption := soClass;
end;

procedure TInvoicelistExpressGUI.FormShow(Sender: TObject);
begin
  inherited;
  if AppEnv.CompanyPrefs.InvoiceClassDefaultAll then
    //TimerMsg(FilterLabel , 'The list shows Invoices of all ' + Appenv.DefaultClass.ClassHeading+'s based on the preference')
  else if Appenv.Employee.DefaultClassID =0 then
    TimerMsg(FilterLabel , 'The list shows Invoices of your Default ' + Appenv.DefaultClass.ClassHeading+' based on the preference. Your Default ' + Appenv.DefaultClass.ClassHeading+' is not selected')
  else
    TimerMsg(FilterLabel , 'The list shows Invoices of your Default ' + Appenv.DefaultClass.ClassHeading+' - '+ quotedstr(Appenv.Employee.DefaultClassName)+' based on the preference');

end;

procedure TInvoicelistExpressGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainType.AsString;
  inherited;
end;

function TInvoicelistExpressGUI.ListType: String;
begin
  REsult := 'Invoice';
end;
procedure TInvoicelistExpressGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainConverted.Fieldname);
    RemoveFieldfromGrid(qryMainFutureSo.Fieldname);
    RemoveFieldfromGrid(qryMaindone.Fieldname);
end;


initialization
  RegisterClassOnce(TInvoicelistExpressGUI);
end.

