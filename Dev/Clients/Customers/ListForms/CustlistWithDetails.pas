unit CustlistWithDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox;

type
  TCustlistWithDetailsGUI = class(TBaseListingGUI)
    qryMainclientId: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainActive: TWideStringField;
    pnlHistory: TDNMPanel;
    grpHistory: TRadioGroup;
    Horizontal1: TSplitter;
    qryMainIsJob: TWideStringField;
    qryMainJobname: TWideStringField;
    timrefreshsub: TTimer;
    btnNewRepair: TDNMSpeedButton;
    btnNewSo: TDNMSpeedButton;
    btnNewAddress: TDNMSpeedButton;
    btnNewsupportLog: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject); Override;
    procedure grpHistoryClick(Sender: TObject);
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure timrefreshsubTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnNewRepairClick(Sender: TObject);
    procedure btnNewSoClick(Sender: TObject);
    procedure btnNewAddressClick(Sender: TObject);
    procedure btnNewsupportLogClick(Sender: TObject);
  private
    fNotesAuditTrailList:TBaseListingGUI;
    fSalesorderListExpress:TBaseListingGUI;
    fRepairExpressList :TBaseListingGUI;
    fShipAddressList:TBaseListingGUI;
    fClientPhoneList:TBaseListingGUI;
    fPhoneSupportLogListExpress:TBaseListingGUI;

    IDchangedAt:TDAtetime;
    Procedure NotesAuditTrailList;
    Procedure SalesorderListExpress;
    Procedure RepairExpressList;
    Procedure ShipAddressList;
    Procedure ClientPhoneList;
    Procedure PhoneSupportLogListExpress;


    procedure ReadnApplyHistoryPref;
    procedure WriteHistoryPref;
    procedure beforeShowHistoryList(sender: TObject);
    procedure ClearPanel;
    procedure InitCustforNew(sender: TObject);
    function Customertype: String;
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
  public
    procedure UpdateMe; Override;
  end;


implementation

uses CommonLib, NotesAuditTrailList,DateUtils , RepairListExpress,
  SalesorderListExpress, ShipAddressListForm, ClientPhoneList,
  PhoneSupportLogListExpress, CommonFormLib, frmRepairs, frmSalesOrder,
  ShipAddressForm, frmPhSupportLog;

{$R *.dfm}

procedure TCustlistWithDetailsGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainIsJob.AsString;
  inherited;
end;

procedure TCustlistWithDetailsGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:GroupFilterString := 'Active = '+Quotedstr('T');
    1:GroupFilterString := 'Active = '+Quotedstr('F');
  end;
  inherited;
end;

procedure TCustlistWithDetailsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  grpHistoryclick(grpHistory);
end;

procedure TCustlistWithDetailsGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  try
    timRefreshSub.Enabled := True;
  finally
    IDchangedAt:=Now;
  end;
end;

Procedure TCustlistWithDetailsGUI.beforeShowHistoryList(sender:TObject);
begin
       if (Sender is TNotesAuditTrailListGUI)         then   TNotesAuditTrailListGUI(Sender).CustomerId         :=QrymainClientID.asInteger
  else if (Sender is TSalesorderListExpressGUI)       then   TSalesorderListExpressGUI(Sender).CustomerId       :=QrymainClientID.asInteger
  else if (Sender is TShipAddressListGUI)             then   TShipAddressListGUI(Sender).CustomerId             :=QrymainClientID.asInteger
  else if (Sender is TClientPhoneListGUI)             then   TClientPhoneListGUI(Sender).CustomerId             :=QrymainClientID.asInteger
  else if (Sender is TPhoneSupportLogListExpressGUI)  then   TPhoneSupportLogListExpressGUI(Sender).CustomerId  :=QrymainClientID.asInteger
  else if (Sender is TRepairListExpressGUI)           then   TRepairListExpressGUI(Sender).CustomerId           :=QrymainClientID.asInteger;
end;
procedure TCustlistWithDetailsGUI.InitCustforNew(sender:TObject);
begin
  if Sender is TRepairsGUI     then begin
    TRepairsGUI(Sender).CustomerID     :=QrymainclientID.asInteger;
    if Assigned(fRepairExpressList) then TRepairsGUI(Sender).AttachObserver(fRepairExpressList);
  end else if sender is TSalesOrderGUI  then begin
    TSalesOrderGUI(Sender).CustomerId  :=QrymainclientID.asInteger;
    TSalesOrderGUI(Sender).InitialiseStartup := True;
    if Assigned(fSalesorderListExpress) then TSalesOrderGUI(Sender).AttachObserver(fSalesorderListExpress);
  end else if Sender is TShipAddressGUI then begin
    TShipAddressGUI(Sender).ClientID   := QrymainclientID.asInteger;
    TShipAddressGUI(Sender).ClientName := Qrymaincompany.asString;
    if Assigned(fShipAddressList) then TShipAddressGUI(Sender).AttachObserver(fShipAddressList);
  end else if Sender is TPhSupportLogGUI then begin
    if Assigned(fPhoneSupportLogListExpress) then TPhSupportLogGUI(Sender).AttachObserver(fPhoneSupportLogListExpress);
  end;
end;

procedure TCustlistWithDetailsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  ReadnApplyHistoryPref;
end;
procedure TCustlistWithDetailsGUI.ReadnApplyHistoryPref;
begin
  grpHistory.ItemIndex := GuiPrefs.Node['History.OptionIndex'].asInteger;
  if GuiPrefs.Node['History.PanelHeight'].asInteger <> 0 then pnlHistory.Height := GuiPrefs.Node['History.PanelHeight'].asInteger;
end;

procedure TCustlistWithDetailsGUI.WriteGuiPrefExtra;
begin
  inherited;
  if WindowState = wsMaximized then WindowState := wsNormal;
  WriteHistoryPref;
end;
procedure TCustlistWithDetailsGUI.WriteHistoryPref;
begin
  GuiPrefs.Node['History.OptionIndex'].AsInteger := grpHistory.ItemIndex;
  GuiPrefs.Node['History.PanelHeight'].asInteger := pnlHistory.Height;
end;
procedure TCustlistWithDetailsGUI.timrefreshsubTimer(Sender: TObject);
begin
  inherited;
  if MilliSecondsBetween(IDchangedAt,Now)<1 then exit;
  if Screen.Activecontrol <> grdmain then exit;
  grpHistoryclick(grpHistory);
  timrefreshsub.enabled := False;
end;

procedure TCustlistWithDetailsGUI.UpdateMe;
begin
  inherited;

end;

procedure TCustlistWithDetailsGUI.FormDestroy(Sender: TObject);
begin
  ClearPanel;
  if Assigned(fRepairExpressList) then freeandnil(fRepairExpressList);
  if Assigned(fNotesAuditTrailList) then    freeandnil(fNotesAuditTrailList);
  if Assigned(fShipAddressList) then    freeandnil(fShipAddressList);
  if Assigned(fSalesorderListExpress) then    freeandnil(fSalesorderListExpress);
  if Assigned(fClientPhoneList) then    freeandnil(fClientPhoneList);
  if Assigned(fPhoneSupportLogListExpress) then    freeandnil(fPhoneSupportLogListExpress);
  inherited;
end;

procedure TCustlistWithDetailsGUI.FormResize(Sender: TObject);
begin
  inherited;
  if (grdmain.height <=0) or (pnlHistory.height <=0) or (pnlHistory.height >=Panel1.height) then begin
    pnlHistory.height := Panel1.height -150;
  end;
end;

procedure TCustlistWithDetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpHistory.color := pnlHistory.color;
end;
procedure TCustlistWithDetailsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  openerpform('TfrmCustomer' , 0);
end;

procedure TCustlistWithDetailsGUI.btnNewAddressClick(Sender: TObject);
begin
  inherited;
  if QrymainclientID.asInteger =0 then exit;
  if qryMainActive.asBoolean =False then  begin
    MessageDlgXP_Vista(Qrymaincompany.asString +' is an inactive ' + Customertype + '.' +chr(13) + chr(13) + 'Please select an Active record', mtWarning, [mbOK], 0);
    Exit;
  end;
  grpHistory.itemindex := 0;
  openErpform('TShipAddressGUI' , 0 , nil, InitCustforNew);
end;
procedure TCustlistWithDetailsGUI.btnNewSoClick(Sender: TObject);
begin
  inherited;
  if QrymainclientID.asInteger =0 then exit;
  if qryMainActive.asBoolean =False then  begin
    MessageDlgXP_Vista(Qrymaincompany.asString +' is an inactive ' + Customertype + '.' +chr(13) + chr(13) + 'Please select an Active record', mtWarning, [mbOK], 0);
    Exit;
  end;
  grpHistory.itemindex := 4;
  openErpform('TSalesOrderGUI' , 0 , nil, InitCustforNew);
end;
procedure TCustlistWithDetailsGUI.btnNewsupportLogClick(Sender: TObject);
begin
  inherited;
  if QrymainclientID.asInteger =0 then exit;
  if qryMainActive.asBoolean =False then  begin
    MessageDlgXP_Vista(Qrymaincompany.asString +' is an inactive ' + Customertype + '.' +chr(13) + chr(13) + 'Please select an Active record', mtWarning, [mbOK], 0);
    Exit;
  end;
  grpHistory.itemindex := 5;
  openErpform('TPhSupportLogGUI' , 0-QrymainClientId.asInteger , nil , InitCustforNew ); // -ive KeyId is converted to clientId for phone supportLog
end;
procedure TCustlistWithDetailsGUI.btnNewRepairClick(Sender: TObject);
begin
  inherited;
  if QrymainclientID.asInteger =0 then exit;
  if qryMainActive.asBoolean =False then  begin
    MessageDlgXP_Vista(Qrymaincompany.asString +' is an inactive ' + Customertype + '.' +chr(13) + chr(13) + 'Please select an Active record', mtWarning, [mbOK], 0);
    Exit;
  end;
  grpHistory.itemindex := 3;
  openErpform('TRepairsGUI' , 0 , nil, InitCustforNew);
end;
function TCustlistWithDetailsGUI.Customertype:String;
begin
  if Qrymainisjob.asboolean then Result := 'Job' else Result  := 'Customer';
end;

procedure TCustlistWithDetailsGUI.grpHistoryClick(Sender: TObject);
begin
  inherited;
  if (qrymain.active=false) or (qrymain.recordcount=0) or (QrymainclientID.asInteger =0) then exit;
  ClearPanel;
  case grpHistory.ItemIndex of
    0: ShipAddressList;
    1: NotesAuditTrailList;
    2: ClientPhoneList;
    3: RepairExpressList;
    4: SalesorderListExpress;
    5: PhoneSupportLogListExpress;
  end;
end;
procedure TCustlistWithDetailsGUI.ClearPanel;
begin
  if Assigned(fNotesAuditTrailList) and (fNotesAuditTrailList.grdmain.parent = pnlhistory) then fNotesAuditTrailList.grdmain.parent := fNotesAuditTrailList.Panel1;
  if Assigned(fRepairExpressList) and (fRepairExpressList.grdmain.parent = pnlhistory) then fRepairExpressList.grdmain.parent := fRepairExpressList.Panel1;
  if Assigned(fSalesorderListExpress) and (fSalesorderListExpress.grdmain.parent = pnlhistory) then fSalesorderListExpress.grdmain.parent := fSalesorderListExpress.Panel1;
  if Assigned(fShipAddressList) and (fShipAddressList.grdmain.parent = pnlhistory) then fShipAddressList.grdmain.parent := fShipAddressList.Panel1;
  if Assigned(fClientPhoneList) and (fClientPhoneList.grdmain.parent = pnlhistory) then fClientPhoneList.grdmain.parent := fClientPhoneList.Panel1;
  if Assigned(fPhoneSupportLogListExpress) and (fPhoneSupportLogListExpress.grdmain.parent = pnlhistory) then fPhoneSupportLogListExpress.grdmain.parent := fPhoneSupportLogListExpress.Panel1;
end;
Procedure TCustlistWithDetailsGUI.RepairExpressList;
begin
  if fRepairExpressList = nil then fRepairExpressList:= TRepairListExpressGUI(Getcomponentbyclassname('TRepairListExpressGUI' , False , nil , False));
  fRepairExpressList.GrdmainForPanel(pnlHistory , beforeShowHistoryList);
end;
Procedure TCustlistWithDetailsGUI.NotesAuditTrailList;
begin
  if fNotesAuditTrailList = nil then fNotesAuditTrailList:= TNotesAuditTrailListGUI(Getcomponentbyclassname('TNotesAuditTrailListGUI' , False , nil , False));
  fNotesAuditTrailList.GrdmainForPanel(pnlHistory , beforeShowHistoryList);
end;
Procedure TCustlistWithDetailsGUI.PhoneSupportLogListExpress;
begin
  if fPhoneSupportLogListExpress = nil then fPhoneSupportLogListExpress:= TPhoneSupportLogListExpressGUI(Getcomponentbyclassname('TPhoneSupportLogListExpressGUI' , False , nil , False));
  fPhoneSupportLogListExpress.GrdmainForPanel(pnlHistory , beforeShowHistoryList);
end;
Procedure TCustlistWithDetailsGUI.ClientPhoneList;
begin
  if fClientPhoneList = nil then fClientPhoneList:= TClientPhoneListGUI(Getcomponentbyclassname('TClientPhoneListGUI' , False , nil , False));
  fClientPhoneList.GrdmainForPanel(pnlHistory , beforeShowHistoryList);
end;
Procedure TCustlistWithDetailsGUI.ShipAddressList;
begin
  if fShipAddressList = nil then fShipAddressList:= TShipAddressListGUI(Getcomponentbyclassname('TShipAddressListGUI' , False , nil , False));
  fShipAddressList.GrdmainForPanel(pnlHistory , beforeShowHistoryList);
end;
Procedure TCustlistWithDetailsGUI.SalesorderListExpress;
begin
  if fSalesorderListExpress = nil then fSalesorderListExpress:= TSalesorderListExpressGUI(Getcomponentbyclassname('TSalesorderListExpressGUI' , False , nil , False));
  fSalesorderListExpress.GrdmainForPanel(pnlHistory , beforeShowHistoryList);
end;

procedure TCustlistWithDetailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ClientId');
end;

initialization
  RegisterClassOnce(TCustlistWithDetailsGUI);

end.

