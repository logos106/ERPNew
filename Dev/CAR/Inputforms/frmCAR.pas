unit frmCAR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, ComCtrls, wwdblook, ERPDbLookupCombo, wwdbdatetimepicker, Mask, wwdbedit, BusobjCAR, Grids, Wwdbigrd, Wwdbgrid, wwcheckbox, Busobjcustomfields, Buttons;

type
  TfmCAR = class(TBaseInputGUI)
    qryCAR: TERPQuery;
    dsCAR: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Box20: TBevel;
    cmdok: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryCARAction: TERPQuery;
    dsCARAction: TDataSource;
    QryCARPrevMeasures: TERPQuery;
    dsCARPrevMeasures: TDataSource;
    qryCAROutcomeReview: TERPQuery;
    dsCAROutcomeReview: TDataSource;
    qryCARReview: TERPQuery;
    dsCARReview: TDataSource;
    qryCARActionID: TIntegerField;
    qryCARActionGlobalRef: TWideStringField;
    qryCARActionCARID: TIntegerField;
    qryCARActionSeqno: TIntegerField;
    qryCARActionActionRequired: TWideStringField;
    qryCARActionImmediateDetails: TWideStringField;
    qryCARActionRepID: TIntegerField;
    qryCARActionRep: TWideStringField;
    qryCARActionActionDate: TDateTimeField;
    qryCARActionmsTimeStamp: TDateTimeField;
    qryCARActionmsUpdateSiteCode: TWideStringField;
    QryCARPrevMeasuresID: TIntegerField;
    QryCARPrevMeasuresGlobalRef: TWideStringField;
    QryCARPrevMeasuresCARID: TIntegerField;
    QryCARPrevMeasuresSeqno: TIntegerField;
    QryCARPrevMeasuresPreventiveActioncomments: TWideStringField;
    QryCARPrevMeasuresPreventiveDetails: TWideStringField;
    QryCARPrevMeasuresRepID: TIntegerField;
    QryCARPrevMeasuresRep: TWideStringField;
    QryCARPrevMeasuresActionDate: TDateTimeField;
    QryCARPrevMeasuresmsTimeStamp: TDateTimeField;
    QryCARPrevMeasuresmsUpdateSiteCode: TWideStringField;
    qryCAROutcomeReviewID: TIntegerField;
    qryCAROutcomeReviewGlobalRef: TWideStringField;
    qryCAROutcomeReviewCARID: TIntegerField;
    qryCAROutcomeReviewSeqno: TIntegerField;
    qryCAROutcomeReviewActionorOutCome: TWideStringField;
    qryCAROutcomeReviewRepID: TIntegerField;
    qryCAROutcomeReviewRep: TWideStringField;
    qryCAROutcomeReviewClosedouton: TDateTimeField;
    qryCAROutcomeReviewmsTimeStamp: TDateTimeField;
    qryCAROutcomeReviewmsUpdateSiteCode: TWideStringField;
    qryCARReviewID: TIntegerField;
    qryCARReviewGlobalRef: TWideStringField;
    qryCARReviewCARID: TIntegerField;
    qryCARReviewSeqno: TIntegerField;
    qryCARReviewReviewComments: TWideStringField;
    qryCARReviewRepID: TIntegerField;
    qryCARReviewRep: TWideStringField;
    qryCARReviewReviewdon: TDateTimeField;
    qryCARReviewmsTimeStamp: TDateTimeField;
    qryCARReviewmsUpdateSiteCode: TWideStringField;
    TabCtl20: TPageControl;
    tabMain: TTabSheet;
    tabAction: TTabSheet;
    tabMeasure: TTabSheet;
    tabOutcome: TTabSheet;
    tabReview: TTabSheet;
    QryProcessType: TERPQuery;
    pnlMain: TDNMPanel;
    Label1: TLabel;
    pnlAction: TDNMPanel;
    pnlMeasure: TDNMPanel;
    pnlOutcome: TDNMPanel;
    pnlReview: TDNMPanel;
    cboProductQry: TERPQuery;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryPARTSID: TIntegerField;
    Label2: TLabel;
    Label3: TLabel;
    DBMemo1: TDBMemo;
    QryRep: TERPQuery;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    qrycontacts: TERPQuery;
    qrycontactscontactID: TIntegerField;
    qrycontactsname: TWideStringField;
    Label8: TLabel;
    Label9: TLabel;
    QryProductionbuild: TERPQuery;
    Label10: TLabel;
    Label11: TLabel;
    DBMemo2: TDBMemo;
    Label12: TLabel;
    Label14: TLabel;
    btnSelectSale: TDNMSpeedButton;
    btnSelectPO: TDNMSpeedButton;
    QryProductionbuildid: TIntegerField;
    QryProductionbuildTypecode: TWideStringField;
    QryProductionbuildname: TWideStringField;
    Label13: TLabel;
    Label15: TLabel;
    DBMemo3: TDBMemo;
    Label16: TLabel;
    Label17: TLabel;
    QryActionRequired: TERPQuery;
    Label19: TLabel;
    DBMemo4: TDBMemo;
    QryPreventiveActions: TERPQuery;
    QryActionedBy: TERPQuery;
    QryReviewedby: TERPQuery;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    DBMemo5: TDBMemo;
    QryOutComeReviewBy: TERPQuery;
    Label35: TLabel;
    DBMemo6: TDBMemo;
    Label36: TLabel;
    Label37: TLabel;
    QryManagementReviewBy: TERPQuery;
    cmdPrint: TDNMSpeedButton;
    LblChooseTemplate: TLabel;
    ChkChooseRpt: TCheckBox;
    qryCARID: TIntegerField;
    qryCARGlobalRef: TWideStringField;
    qryCARComplaintfromID: TIntegerField;
    qryCARComplaintFrom: TWideStringField;
    qryCARContactID: TIntegerField;
    qryCARcontactName: TWideStringField;
    qryCARComplaintType: TWideStringField;
    qryCARProductID: TIntegerField;
    qryCARProductName: TWideStringField;
    qryCAREnteredByID: TIntegerField;
    qryCAREnteredBy: TWideStringField;
    qryCARReportedDate: TDateTimeField;
    qryCARSalesID: TIntegerField;
    qryCARSalesLineID: TIntegerField;
    qryCARProductionBuild: TWideStringField;
    qryCARProductionBuildDesc: TWideStringField;
    qryCARSupplierID: TIntegerField;
    qryCARSupplierName: TWideStringField;
    qryCARPOID: TIntegerField;
    qryCARPOLineID: TIntegerField;
    qryCARDescriptionofProblem: TWideStringField;
    qryCARImprovementSuggestion: TWideStringField;
    qryCARRepID: TIntegerField;
    qryCARRep: TWideStringField;
    qryCARmstimestamp: TDateTimeField;
    qryCARmsUpdateSiteCode: TWideStringField;
    cmdNew: TDNMSpeedButton;
    btnNewImmAction: TDNMSpeedButton;
    btnNewPrevMeasure: TDNMSpeedButton;
    btnNewOutcomeReview: TDNMSpeedButton;
    btnNewMgmtReview: TDNMSpeedButton;
    Label38: TLabel;
    txtCustomID: TDBEdit;
    dsProduct: TDataSource;
    QrySupcontact: TERPQuery;
    IntegerField2: TIntegerField;
    WideStringField2: TWideStringField;
    Label39: TLabel;
    qryCARsupcontactID: TIntegerField;
    qryCARsupcontactName: TWideStringField;
    Label40: TLabel;
    Label41: TLabel;
    cboProductQryPARTSDESCRIPTION: TWideStringField;
    qryCARPARTSDESCRIPTION: TStringField;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;

    cboProcesstype: TwwDBLookupCombo;
    cboEmployee: TwwDBLookupCombo;
    cbocontact: TwwDBLookupCombo;
    cboProductionBuild: TwwDBLookupCombo;
    cboActionRequired: TwwDBLookupCombo;
    cboActionBy: TwwDBLookupCombo;
    cboPreventiveAction: TwwDBLookupCombo;
    cboPreventiveACtionreviewBy: TwwDBLookupCombo;
    cboOutcomeReviewedBy: TwwDBLookupCombo;
    cboMgmtReviewdBy: TwwDBLookupCombo;
    cboSupcontact: TwwDBLookupCombo;

    cboProductR: TwwDBEdit;
    edtcustomer: TwwDBEdit;
    edtSales: TwwDBEdit;
    edtSupplier: TwwDBEdit;
    edtProductionBuildDesc: TwwDBEdit;
    edtPOId: TwwDBEdit;
    edtEnteredBy: TwwDBEdit;
    edtProductDescription: TwwDBEdit;

    dtReportedDate: TwwDBDateTimePicker;
    dtImmActionDate: TwwDBDateTimePicker;
    dtPrevMeasReviewDate: TwwDBDateTimePicker;
    dtOutcomeReviewDate: TwwDBDateTimePicker;
    dtMgmtreviewDate: TwwDBDateTimePicker;

    grdTransactions: TwwDBGrid;
    grdPrevMeasures: TwwDBGrid;
    grdOutcomeReview: TwwDBGrid;
    grdMgmtReview: TwwDBGrid;
    Custom_Fields: TTabSheet;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    pnlcustomfieldList: TDNMPanel;
    grdTransactionsIButton: TwwIButton;
    grdPrevMeasuresIButton: TwwIButton;
    grdMgmtReviewIButton: TwwIButton;
    grdOutcomeReviewIButton: TwwIButton;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdokClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSalesClick(Sender: TObject);
    procedure btnSelectPOClick(Sender: TObject);
    procedure HightLightselectSale(Sender: TObject);
    procedure HightLightselectPO(Sender: TObject);
    procedure HideHighLight(Sender: TObject);
    procedure qrycontactsBeforeOpen(DataSet: TDataSet);
    procedure cbocontactEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure cboProductionBuildNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboActionRequiredNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboProcesstypeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboProcesstypeDblClick(Sender: TObject);
    procedure cboProductionBuildDblClick(Sender: TObject);
    procedure cboActionRequiredDblClick(Sender: TObject);
    procedure cboPreventiveActionDblClick(Sender: TObject);
    procedure cboPreventiveActionNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnNewImmActionClick(Sender: TObject);
    procedure btnNewPrevMeasureClick(Sender: TObject);
    procedure btnNewOutcomeReviewClick(Sender: TObject);
    procedure btnNewMgmtReviewClick(Sender: TObject);
    procedure Label40Click(Sender: TObject);
    procedure Label41Click(Sender: TObject);
    procedure qryCARCalcFields(DataSet: TDataSet);
    procedure QrySupcontactBeforeOpen(DataSet: TDataSet);
    procedure closenOpenLookuptable(Sender: TObject);
    procedure grdTransactionsIButtonClick(Sender: TObject);
    procedure grdPrevMeasuresIButtonClick(Sender: TObject);
    procedure grdMgmtReviewIButtonClick(Sender: TObject);
    procedure grdOutcomeReviewIButtonClick(Sender: TObject);
    procedure TabCtl20Changing(Sender: TObject; var AllowChange: Boolean);
  private
    CARObj: TCorrectiveActionReports;
    NewSimpletypeValue:String;
    function SaveRecord: Boolean;
    procedure ApplySelectedSale(Sender: TWWDBGrid);
    procedure beforeshowSaleslist(Sender: TObject);
    procedure ApplySelectedPO(Sender: TWWDBGrid);
    procedure beforeshowPOlist(Sender: TObject);
    function NewSimpletypeValueCreated: String;
    procedure simpletypenotInlist(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean; Simpletype: String);
    procedure ReadnApplyGuiPrefExtra;
    Procedure WriteGuiPrefExtra;
    procedure initForm;
  Protected
    function GetReportTypeID: integer; Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Function CustomFieldExtenderListtype:TListType; Override;
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil); override;
  end;


implementation

uses CommonLib, BusObjConst, frmSimpleTypes, AppEnvironment, tcconst, frmPartsFrm, CommonFormLib, Productsaleslist, ProductPurchaselist, DNMLib, ProductQtyLib,  FormFactory,
  tcDataUtils;

{$R *.dfm}



procedure TfmCAR.cbocontactEnter(Sender: TObject);
begin
  inherited;
  if (qrycontacts.parambyname('ClientID').AsInteger <> CARObj.ComplaintfromID) or (Qrycontacts.Active=False) then begin
    Closedb(qrycontacts);
    qrycontacts.parambyname('ClientID').AsInteger := CARObj.ComplaintfromID;
    Opendb(qrycontacts);
  end;
end;


procedure TfmCAR.Label40Click(Sender: TObject);
begin
  inherited;
  CARObj.SalesID      := 0;
  CARObj.SaleslineID  := 0;
  CARObj.ProductName  := CarObj.POLine.ProductName;
end;

procedure TfmCAR.Label41Click(Sender: TObject);
begin
  inherited;
  CARObj.POID           := 0;
  CARObj.POLineID       := 0;
  CARObj.ProductName  := CarObj.SaleLine.ProductName;
end;

procedure TfmCAR.qryCARCalcFields(DataSet: TDataSet);
begin
  inherited;
  if CarObj.ProductName ='' then
    qryCARPARTSDESCRIPTION.AsString := ''
  else begin
    opendb(cboProductQry);
    if cboProductQry.Locate('Partname' , CarObj.ProductName , []) then
      qryCARPARTSDESCRIPTION.AsString :=cboProductQryPARTSDESCRIPTION.AsString
    else  qryCARPARTSDESCRIPTION.AsString := '';
  end;
end;

procedure TfmCAR.qrycontactsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrycontacts.parambyname('ClientID').AsInteger := CARObj.ComplaintfromID;
end;

procedure TfmCAR.HightLightselectPO(Sender: TObject);
begin
  inherited;
  HighlightControl(btnSelectPO);
end;

procedure TfmCAR.HightLightselectSale(Sender: TObject);
begin
  inherited;
  HighlightControl(btnSelectSale);
end;

procedure TfmCAR.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmCAR.SaveRecord :Boolean;
begin
  result:= False;
  CARObj.PostDB;
  if not(CARObj.Save) then exit;
  CARObj.Dirty := False;
  Result:= True;
  KeyId :=CARObj.ID;
end;

procedure TfmCAR.HideHighLight(Sender: TObject);
begin
  inherited;
   HideHighlightControl;
end;
function TfmCAR.NewSimpletypeValueCreated:String;
begin
  result:= '';
  if fLastComboAccessed = nil then Exit;
  closenopendb(fLastComboAccessed.LookupTable);
  if fLastComboAccessed.LookupTable.Locate('Name', NewSimpletypeValue, []) then
   REsult:= NewSimpletypeValue;
end;
procedure TfmCAR.UpdateMe(const Cancelled: Boolean; const aObject: TObject);
begin
  inherited;
  if Cancelled then begin
  end else begin
    if (Assigned(aObject) and (aObject is TBaseInputGUI) and Assigned(fLastComboAccessed)) then begin

      if fLastComboAccessed = cboProcesstype then begin
          CARObj.ComplaintType:= NewSimpletypeValueCreated;
          CARObj.PostDB;
      end else if fLastComboAccessed =cboProductionBuild then begin
          CARObj.ProductionBuild:= NewSimpletypeValueCreated;
          CARObj.PostDB;
      end else if fLastComboAccessed =cboActionRequired then begin
          CARObj.CARAction.ActionRequired := NewSimpletypeValueCreated;
          CARObj.CARAction.PostDB;
      end else if fLastComboAccessed = cboPreventiveAction then begin
          CARObj.CARPrevMeasures.PreventiveActioncomments := NewSimpletypeValueCreated;
          CARObj.CARPrevMeasures.PostDB;
      end;
    end;
  end;
end;




procedure TfmCAR.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.Print.chooseTemplate'].asBoolean   := ChkChooseRpt.checked ;
end;

procedure TfmCAR.closenOpenLookuptable(Sender: TObject);
begin
  inherited;
  if Sender is TwwDBlookupcombo then
    if TwwDBlookupcombo(Sender).LookupTable<>nil then begin
      closedb(TwwDBlookupcombo(Sender).LookupTable);
      opendb(TwwDBlookupcombo(Sender).LookupTable);
      TwwDBlookupcombo(Sender).LookupTable.Locate(TwwDBlookupcombo(Sender).LookupField , TwwDBlookupcombo(Sender).Text , []);
    end;
end;

procedure TfmCAR.cmdokClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  CARObj.Connection.CommitTransaction;
  Self.Close;
end;
procedure TfmCAR.cmdNewClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  CARObj.Connection.CommitTransaction;
  KeyId := 0;
  initForm;

end;

procedure TfmCAR.cmdPrintClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  CARObj.Connection.CommitTransaction;

  REportToPrint:= '';
  if chkChooseRpt.Checked then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then
      ReportToPrint := dlgReportSelect.SelectedItems.Text
    else
      exit;
  end else begin
    REportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
  end;
  if REportToPrint = '' then exit;
  PrintTemplateReport(ReportToPrint,
                      '~|||~where Id = ' + inttostr(CarObj.ID) +
                      '~|||~where CarId = ' + inttostr(CarObj.ID) +' Order by Seqno'+
                      '~|||~where CarId = ' + inttostr(CarObj.ID) +' Order by Seqno'+
                      '~|||~where CarId = ' + inttostr(CarObj.ID) +' Order by Seqno'+
                      '~|||~where CarId = ' + inttostr(CarObj.ID) +' Order by Seqno'+
                      '~|||~where ORO.MasterID = ' + inttostr(CarObj.ID) +' ',
                      not(Devmode) and not(Appenv.Employee.ShowPreview), 1);
  Self.Close;
end;

function TfmCAR.CustomFieldExtenderListtype: TListType;
begin
  Result := ltCAR;
end;



procedure TfmCAR.btnSalesClick   (Sender: TObject);begin  inherited;  OpenERPListFormSingleselectModal('TProductsaleslistsGUI'  , ApplySelectedSale , beforeshowSaleslist);end;
procedure TfmCAR.btnSelectPOClick(Sender: TObject);begin  inherited;  OpenERPListFormSingleselectModal('TProductPurchaseListGUI', ApplySelectedPO   , beforeshowPOlist)   ;end;
procedure TfmCAR.ApplySelectedSale(Sender: TWWDBGrid);
begin
  try
    With Sender.Datasource.dataset do begin
      CARObj.Complaintfrom:= FieldByname('CustomerName').asString;
      CARObj.SalesID      := FieldByname('SaleID').asInteger;
      CARObj.SaleslineID  := FieldByname('SalelineID').asInteger;
      CARObj.ProductName  := FieldByname('ProductName').AsString;
      CarObj.contactName  := FieldByname('ContactName').AsString;
      CARObj.PostDB;
    end;
    CARObj.ValidatePO(True);
  Except
    On E:Exception do begin
      if devmode then MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TfmCAR.ApplySelectedPO(Sender: TWWDBGrid);
begin
  try
    With Sender.Datasource.dataset do begin
      CARObj.SupplierName   := FieldByname('SupplierName').asString;
      CARObj.POID           := FieldByname('PurchaseOrderID').asInteger;
      CARObj.POLineID       := FieldByname('PurchaseLineID').asInteger;
      CARObj.ProductName    := FieldByname('ProductName').AsString;
      CarObj.SupcontactName := FieldByname('ContactName').AsString;
      CARObj.PostDB;
    end;
    CARObj.ValidateSales(True);
  Except
    On E:Exception do begin
      if devmode then MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TfmCAR.beforeshowSaleslist(Sender: TObject);
begin
  if not(Sender is TProductsaleslistsGUI) then exit;
  TProductsaleslistsGUI(Sender).productId := CARObj.productId;
  TProductsaleslistsGUI(Sender).clientId := CARObj.ComplaintfromID;
end;
procedure TfmCAR.beforeshowPOlist(Sender: TObject);
begin
  if not(Sender is TProductPurchaseListGUI) then exit;
  TProductPurchaseListGUI(Sender).productId := CARObj.productId;
  TProductPurchaseListGUI(Sender).clientId := CARObj.SupplierID;
end;

procedure TfmCAR.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TCorrectiveActionReports then TCorrectiveActionReports(Sender).Dataset  := qryCAR
        else if Sender is TCARReview then TCARReview(Sender).Dataset  := qryCARReview
        else if Sender is TCARPrevMeasures then TCARPrevMeasures(Sender).Dataset  := QryCARPrevMeasures
        else if Sender is TCAROutComeReview then TCAROutComeReview(Sender).Dataset  := qryCAROutcomeReview
        else if Sender is TCARAction then TCARAction(Sender).Dataset  :=qryCARAction;
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_CustomerChanged ) then begin
        closedb(qrycontacts);
        qrycontacts.ParamByName('clientID').AsInteger := CARObj.ComplaintfromID;
        opendb(qrycontacts);
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_ProductChanged) then begin
        cboProductQry.Locate('Partname' , CarObj.ProductName , []);
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_CustomerChanged) then begin
        closedb(qrycontacts);
        OpenDB(qrycontacts);
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_SupplierChanged) then begin
        closedb(QrySupcontact);
        OpenDB(QrySupcontact);
     end;
end;

procedure TfmCAR.QrySupcontactBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QrySupcontact.parambyname('ClientID').AsInteger := CARObj.supplierId;
end;

procedure TfmCAR.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.active = False then GuiPrefs.Active := True;
  if GuiPrefs.Node.Exists('Options.Print') then begin
    ChkChooseRpt.checked :=GuiPrefs.Node['Options.Print.chooseTemplate'].asBoolean;
  end;
end;

procedure TfmCAR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  WriteGuiPrefExtra;
  action := caFree;
end;

procedure TfmCAR.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if ErrorOccurred then Exit;

  CanClose := false;
  if CARObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          RollbackTransaction;
          CARObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmCAR.FormCreate(Sender: TObject);
begin
  inherited;
  CARObj := TCorrectiveActionReports.CreateWithNewConn(Self);
  CARObj.Connection.connection := Self.MyConnection;
  CARObj.BusObjEvent := DoBusinessObjectEvent;
end;
procedure TfmCAR.FormShow(Sender: TObject);
begin
  try
    inherited;
    initForm;
    ReadnApplyGuiPrefExtra;
    openQueries;
  finally
    RealignTabControl(tabctl20, 1);
  end;
end;
procedure TfmCAR.initForm;
begin
    CARObj.Load(KeyID);
    CARObj.connection.BeginTransaction;
    if CARObj.count=0 then CARObj.new;
    CARObj.CARReview;
    CARObj.CARPrevMeasures;
    CARObj.CAROutComeReview;
    CARObj.CARAction;
    tabctl20.ActivePage := tabMain;
    SetcontrolFocus(cboProcesstype);
end;

function TfmCAR.GetReportTypeID: integer;
begin
  Result := 121;
end;


procedure TfmCAR.simpletypenotInlist(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean; Simpletype:String);
begin
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  NewSimpletypeValue := TwwDBLookupcombo(Sender).Text;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes then begin
    TfmSimpleTypes.DoSimpleTypesEdit(Simpletype, NewValue, Self);
  end;
  Accept := False;
end;
procedure TfmCAR.TabCtl20Changing(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  AllowChange := SaveRecord ;
end;

procedure TfmCAR.cboActionRequiredNotInList  (Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);begin  inherited;  simpletypenotInlist(Sender, Lookuptable, newValue,accept ,simpletypes_CAR_ActionRequired);end;
procedure TfmCAR.cboProductionBuildNotInList (Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);begin  inherited;  simpletypenotInlist(Sender, Lookuptable, newValue,accept ,simpletypes_CAR_ProductionBuild);end;
procedure TfmCAR.cboProcesstypeNotInList     (Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);begin  inherited;  simpletypenotInlist(Sender, Lookuptable, newValue,accept ,simpletypes_CAR_Actiontype);end;
procedure TfmCAR.cboPreventiveActionNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);begin  inherited;  simpletypenotInlist(Sender, Lookuptable, newValue,accept ,simpletypes_CAR_PreventiveActionComments);end;

procedure TfmCAR.cboProcesstypeDblClick     (Sender: TObject);begin  inherited;  TfmSimpleTypes.DoSimpleTypesEdit(simpletypes_CAR_Actiontype              , CARObj.ComplaintType            );end;
procedure TfmCAR.cboProductionBuildDblClick (Sender: TObject);begin  inherited;  TfmSimpleTypes.DoSimpleTypesEdit(simpletypes_CAR_Productionbuild         , CARObj.ComplaintType            );end;
procedure TfmCAR.cboActionRequiredDblClick  (Sender: TObject);begin  inherited;  TfmSimpleTypes.DoSimpleTypesEdit(simpletypes_CAR_ActionRequired          , CARObj.CARAction.ActionRequired );end;
procedure TfmCAR.cboPreventiveActionDblClick(Sender: TObject);begin  inherited;  TfmSimpleTypes.DoSimpleTypesEdit(simpletypes_CAR_PreventiveActionComments, CARObj.CARPrevMeasures.PreventiveActioncomments);end;

procedure TfmCAR.btnNewImmActionClick     (Sender: TObject);begin  inherited;  if not CArObj.CARAction.Validatedata         then exit;  CArObj.CARAction.PostDb       ;  CArObj.CARAction.New       ;end;
procedure TfmCAR.btnNewPrevMeasureClick   (Sender: TObject);begin  inherited;  if not CArObj.CARPrevMeasures.Validatedata   then exit;  CArObj.CARPrevMeasures.PostDb ;  CArObj.CARPrevMeasures.New ;end;
procedure TfmCAR.btnNewOutcomeReviewClick (Sender: TObject);begin  inherited;  if not CArObj.CAROutComeReview.Validatedata  then exit;  CArObj.CAROutComeReview.PostDb;  CArObj.CAROutComeReview.New;end;
procedure TfmCAR.btnNewMgmtReviewClick    (Sender: TObject);begin  inherited;  if not CArObj.CARReview.Validatedata         then exit;  CArObj.CARReview.PostDb       ;  CArObj.CARReview.New       ;end;

procedure TfmCAR.grdMgmtReviewIButtonClick    (Sender: TObject);begin  inherited;  CarObj.CARReview.Delete        ;end;
procedure TfmCAR.grdOutcomeReviewIButtonClick (Sender: TObject);begin  inherited;  CarObj.CAROutComeReview.Delete ;end;
procedure TfmCAR.grdPrevMeasuresIButtonClick  (Sender: TObject);begin  inherited;  CarObj.CARPrevMeasures.Delete  ;end;
procedure TfmCAR.grdTransactionsIButtonClick  (Sender: TObject);begin  inherited;  CArObj.CARAction.Delete        ;end;

initialization
  RegisterClassOnce(TfmCAR);
  with FormFact do begin
    RegisterMe(TfmCAR, 'TCarListGUI_*=ID');
  end;
end.

