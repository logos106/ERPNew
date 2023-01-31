unit frmEdiOrderAmazonList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmEdiOrderList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, ComCtrls, AdvProgr;

type
  TfmEdiOrderAmazonList = class(TfmEdiOrderList)
    qryMainShipStatus: TStringField;
    qryShipLookup: TERPQuery;
    qryMainShipStatusMessage: TStringField;
    btnConfirmShipment: TDNMSpeedButton;
    chkshowSynchLog: TCheckBox;
    qryMainEDIClient: TWideStringField;
    qryMainSOComments: TWideMemoField;
    btnhelp: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSynchOrdersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure btnShipOrdersClick(Sender: TObject);
    procedure btnConfirmShipmentClick(Sender: TObject);
    procedure RequeryTimerTimer(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure lblcheckPrefClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnhelpClick(Sender: TObject);
  private
    ElapsedSeconds: integer;
    RequeryTime: TDateTime;
  protected
    procedure ApplyQueryFilter; override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    { Public declarations }
  end;

implementation

uses
  EdiGuiUtilsObj, AppEnvironment, CommonFormLib, Preferences, CommonLib,
  SystemLib, ShellAPI, Clipbrd, tcConst, FilesLib, DocReaderObj, ButtonsLib;

  const
    RequerySeconds = 60 * 10;
    ErrorStatus = 'Check EDI Log for Errors';


{$R *.dfm}

procedure TfmEdiOrderAmazonList.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {New SO}
        GroupFilterString := '(InvoiceID is NULL)';
      end;
    1:
      begin {Shipped}
        GroupFilterString := '(ShipStatus = "Shipped")';
      end;
    2:
      begin {Invoiced}
        GroupFilterString := '((InvoiceID is not NULL) and (ShipStatus <> "Shipped"))';
      end;
    3:
      begin {All}
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TfmEdiOrderAmazonList.btnConfirmShipmentClick(Sender: TObject);
begin
  inherited;
  RequeryTimer.Enabled := false;
  try
    TEdiGuiUtils.ConfirmShipment('Amazon',''); //, chkshowSynchLog.Checked);
    RefreshQuery;
  finally
    if AppEnv.CompanyPrefs.AmazonConfig.Active and AppEnv.CompanyPrefs.AmazonConfig.AutoCheckForOrders then
      RequeryTimer.Enabled := true;
  end;
end;

procedure TfmEdiOrderAmazonList.btnhelpClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Amazon Orders');
end;

procedure TfmEdiOrderAmazonList.btnShipOrdersClick(Sender: TObject);
var
  InvoiceIdList: string;
begin
  inherited;
  RequeryTimer.Enabled := false;
  try
    InvoiceIdList := SelectedIDs('InvoiceID');
    TEdiGuiUtils.ConfirmShipment('Amazon',InvoiceIdList); //, chkshowSynchLog.Checked);
    RefreshQuery;
  finally
    if AppEnv.CompanyPrefs.AmazonConfig.Active and AppEnv.CompanyPrefs.AmazonConfig.AutoCheckForOrders then
      RequeryTimer.Enabled := true;
  end;
end;

procedure TfmEdiOrderAmazonList.btnSynchOrdersClick(Sender: TObject);
begin
  inherited;
  RequeryTimer.Enabled := false;
  try
    TEdiGuiUtils.CheckForOrders('Amazon'); //, chkshowSynchLog.Checked);
    RefreshQuery;
  finally
    if AppEnv.CompanyPrefs.AmazonConfig.Active and AppEnv.CompanyPrefs.AmazonConfig.AutoCheckForOrders then
      RequeryTimer.Enabled := true;
  end;
end;

procedure TfmEdiOrderAmazonList.FormCreate(Sender: TObject);
begin
  inherited;
  EDIParty := 'Amazon';
  RequeryTime := 0;
  FormatBtnHelp(btnhelp);
end;

procedure TfmEdiOrderAmazonList.FormShow(Sender: TObject);
begin
  inherited;
//  pnlRequerytmr.Width := grpFilters.Width;
//  pbRequery.align := altop;
//  tmrAutocheckforOrdersinList.Enabled := True;
  EnableMultiSelect('');
  if AppEnv.CompanyPrefs.AmazonConfig.Active and AppEnv.CompanyPrefs.AmazonConfig.AutoCheckForOrders then begin
    ElapsedSeconds := 0;
    pnlRequerytmr.Visible := true;
    pbRequery.align := altop;
    RequeryTimer.Enabled := true;
    pbRequery.Min := 0;
    pbRequery.Max := 100;
    lblhint.Caption := '';
  end
  else begin
    pnlRequerytmr.Visible := false;
  end;
end;

procedure TfmEdiOrderAmazonList.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Sametext(Field.fieldname , qryMainShipStatus.fieldname) or
     Sametext(Field.fieldname , qryMainShipStatusMessage.fieldname) then
    if sametext(qryMainShipStatus.asString , ErrorStatus) then
        RedFont(AFont);
end;

procedure TfmEdiOrderAmazonList.grdMainDblClick(Sender: TObject);
  var
    fs:String;
    fsLogFilename:String;
  function LastEDILogfile:String;
  begin
    fsLogFilename :=  Searchfile('Bin\log\TrueERP_Mod_EDI_*.Log' , 'Last');
    if fsLogFilename <> '' then  fsLogFilename := exedir+'Bin\log\'+fsLogFilename;
    Result :=fsLogFilename;
  end;
begin
  if ((grdMain.SelectedField = qryMainInvoiceID) or
      (grdMain.SelectedField = qryMainInvoiceGlobalRef)) and (qryMainInvoiceID.AsInteger > 0) then begin
    OpenERPForm('TInvoiceGUI', qryMainInvoiceID.AsInteger);
  end
  else if (grdMain.SelectedField <> qryMainSOComments) and (qryMainSalesOrderID.AsInteger > 0) then begin
    OpenERPForm('TSalesOrderGUI', qryMainSalesOrderID.AsInteger);
  end else if sametext(qryMainShipStatus.asString ,ErrorStatus) and (LastEDILogfile <> '' ) then begin
    fs := '(Order Ref: ' + trim(QrymainDocumentRef.asString)+')' ;
    case MessageDlgXP_Vista('ERP Order is not Created for this Order from Amazon. '+NL+NL+
                       'For Details/Errors , Search for '+NL+fs+NL+' in the EDI Log.'+NL+NL+
                       'Log Files can be found in ' + Quotedstr(exedir +'Bin\log') , mtInformation, [mbOK], 0,nil, '', '', false,nil,'Open Log folder,Open Latest Log File' ) of
          101:begin Clipboard.asText := fs;
                    ShellExecute(Handle, 'Open', PChar(fsLogFilename) , '', '', SW_SHOWNORMAL);
              end;
          100: begin
                    ShellExecute(Handle, 'open',PChar(exedir +'Bin\log'),nil, nil, SW_SHOW);
              end;
    end;

  end else begin
    inherited;
  end;
end;

procedure TfmEdiOrderAmazonList.lblcheckPrefClick(Sender: TObject);
begin
  inherited;
  OpenPrefform('EDI and Integration' ,  'chkAutoCheckForOrders', 0 , True, 'Amazon' , 'pnlAmazonConfig' ,
                    'Changes made here will not take affect unless the Application is Restarted.');
end;

procedure TfmEdiOrderAmazonList.qryMainCalcFields(DataSet: TDataSet);
var
  status, statusMessage: string;
begin
  inherited;
  statusMessage := '';
  status := '';
  if (qryMainInvoiceID.AsInteger > 0) or (QrymainSalesOrderId.asInteger<>0) then begin
    qryShipLookup.Close;
    qryShipLookup.ParamByName('SaleID').AsInteger := qryMainInvoiceID.AsInteger;
    qryShipLookup.Open;
    status := '';
    while not qryShipLookup.Eof do begin
      if status = '' then begin
        status := qryShipLookup.FieldByName('Status').AsString;
        statusMessage := qryShipLookup.FieldByName('StatusMessage').AsString;
      end
      else if status <> 'Shipped' then begin
        status := qryShipLookup.FieldByName('Status').AsString;
        statusMessage := qryShipLookup.FieldByName('StatusMessage').AsString;
      end;
      qryShipLookup.Next;
    end;

    if status ='' then status :=qrymainstatus.asString;
    if statusMessage ='' then statusMessage :=qrymainstatus.asString;

    qryMainShipStatus.AsString := status;
    qryMainShipStatusMessage.AsString := statusMessage;
  end
  else begin
    qryMainShipStatus.AsString := ErrorStatus;
    qryMainShipStatusMessage.AsString := ErrorStatus + ' for (Order Ref: ' + trim(QrymainDocumentRef.asString)+')';
  end;
end;

procedure TfmEdiOrderAmazonList.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.showSynchLog') then
      chkshowSynchLog.checked :=  GuiPrefs.Node['Options.showSynchLog'].asBoolean;
end;

procedure TfmEdiOrderAmazonList.RequeryTimerTimer(Sender: TObject);
var
  percent: integer;
  RequeryMins: integer;
begin
  inherited;
  Inc(ElapsedSeconds);
  RequeryTimer.Enabled := false;
  RequeryMins := System.Round((RequerySeconds - ElapsedSeconds) / 60);
  try
    if ElapsedSeconds >= RequerySeconds then begin
      RequeryTime := now;
      lblhint.Caption := 'Checking for new orders ..';
      lblhint.Refresh;
      TEdiGuiUtils.CheckForOrders('Amazon'); //, chkshowSynchLog.Checked);
      RefreshQuery;
      ElapsedSeconds := 0;
      pbRequery.Position := 0;
      ShowControlHint(pbRequery , 'Last Synch ' + quotedstr(formatDateTime('hh:nn am/pm', RequeryTime))
        +'. ' +   'Next in ' + inttostr(RequeryMins) +' Mins');
      lblhint.caption := pbRequery.hint;
      lblhint.refresh;
    end
    else begin
      percent := system.Round((ElapsedSeconds / RequerySeconds) * 100);
      pbRequery.Position := percent;
      if RequeryTime > 0 then begin
        ShowControlHint(pbRequery , 'Last Synch ' + quotedstr(formatDateTime('hh:nn am/pm', RequeryTime))
          +'. ' +   'Next in ' + inttostr(RequeryMins) +' Mins');
      end
      else begin
        ShowControlHint(pbRequery , 'Next check in ' + inttostr(RequeryMins) +' Mins');
      end;
      lblhint.caption := pbRequery.hint;
      lblhint.refresh;
    end;
  finally
    RequeryTimer.Enabled := true;
  end;
end;

procedure TfmEdiOrderAmazonList.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.showSynchLog'].asBoolean := chkshowSynchLog.checked;
end;

initialization
  RegisterClassOnce(TfmEdiOrderAmazonList);

end.
