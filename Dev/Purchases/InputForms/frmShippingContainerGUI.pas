{can be opened using its own connection or setting a connection from another form}
{This form uses lookup fields from purchaselines but editing of these fields was requested
 so had to use a pop up which edits PO.Lines via an object using Locking etc}

unit frmShippingContainerGUI;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, wwcheckbox,
  DNMSpeedButton, Shader, DNMPanel, wwdblook, wwdbdatetimepicker, Mask,
  wwdbedit, MemDS,BusObjShippingContainer, ActnList,BusObjBase, Grids,
  Wwdbigrd, Wwdbgrid, Buttons, DBCtrls,BusObjOrders,BusObjShipContainerDetails,
  ImgList, ComCtrls, ProgressDialog;

type
  TfrmShipContainer = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    DSShippingContainer: TDataSource;
    qryShippingContainer: TERPQuery;
    qrySimpleTypes: TERPQuery;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actNew: TAction;
    qryShippingContainerShippingContainerID: TIntegerField;
    qryShippingContainerContainerName: TWideStringField;
    qryShippingContainerETDeparture: TDateField;
    qryShippingContainerShippingContainerStatus: TWideStringField;
    qryShippingContainerDeparturePoint: TWideStringField;
    qryShippingContainerVesselName: TWideStringField;
    qryShippingContainerETA: TDateField;
    qryShippingContainerArrivalPoint: TWideStringField;
    qryShippingContainerActive: TWideStringField;
    qrySimpleTypesname: TWideStringField;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    edName: TwwDBEdit;
    Label7: TLabel;
    dtETD: TwwDBDateTimePicker;
    Label2: TLabel;
    dtETA: TwwDBDateTimePicker;
    Label5: TLabel;
    edVessel: TwwDBEdit;
    Label3: TLabel;
    cboStatus: TwwDBLookupCombo;
    Label4: TLabel;
    edDeparture: TwwDBEdit;
    Label6: TLabel;
    edArrival: TwwDBEdit;
    qryShipContainerDetails: TERPQuery;
    DSShipContainerDetails: TDataSource;
    ContainerNotes: TDBMemo;
    Label8: TLabel;
    qryShippingContainerContainerNotes: TWideMemoField;
    DNMPanel2: TDNMPanel;
    cmdIncudeLandeCost: TDNMSpeedButton;
    btnAdd: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    edTotalImportCosts: TwwDBEdit;
    Bevel1: TBevel;
    btnRecieve: TDNMSpeedButton;
    qryShippingContainerGlobalRef: TWideStringField;
    btnApply: TDNMSpeedButton;
    actApply: TAction;
    cmdEmail: TDNMSpeedButton;
    pnlgrid: TDNMPanel;
    grdDetails: TwwDBGrid;
    grdDetailsIButton: TwwIButton;
    ProgressBar: TProgressBar;
    qryShippingContainerContainerNumber: TWideStringField;
    qryShippingContainerContainerSize: TWideStringField;
    qryShippingContainermsUpdateSiteCode: TWideStringField;
    Label9: TLabel;
    edtContainerNumber: TwwDBEdit;
    edtContainerSize: TwwDBEdit;
    Label10: TLabel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlChooseRpt: TDNMPanel;
    lblChooseRpt: TLabel;
    chkChooseRpt: TCheckBox;
    lblMsg: TLabel;
    grdbusobj: TwwDBGrid;
    wwIButton1: TwwIButton;
    qryShipContainerDetailsShipContainerDetailID: TIntegerField;
    qryShipContainerDetailsShippingContainerID: TIntegerField;
    qryShipContainerDetailsGLOBALREF: TWideStringField;
    qryShipContainerDetailsCommercialInvNo: TWideStringField;
    qryShipContainerDetailsSupplierWorkOrderNo: TWideStringField;
    qryShipContainerDetailsmsTimeStamp: TDateTimeField;
    qryShipContainerDetailsPurchaseLineID: TIntegerField;
    qryShipContainerDetailsTotalAuxilaryCosts: TFloatField;
    qryShipContainerDetailsAuxilaryCostsPercentage: TFloatField;
    qryShipContainerDetailsAuxilaryCostsPerItem: TFloatField;
    qryShipContainerDetailsmsUpdateSiteCode: TWideStringField;
    qryShipContainerDetailsforGrid: TERPQuery;
    qryShipContainerDetailsforGridPurchaseLineID: TIntegerField;
    qryShipContainerDetailsforGridCommercialInvNo: TWideStringField;
    qryShipContainerDetailsforGridSupplierWorkOrderNo: TWideStringField;
    qryShipContainerDetailsforGridProductName: TWideStringField;
    qryShipContainerDetailsforGridTotalAmountInc: TFloatField;
    qryShipContainerDetailsforGridUnitOfMeasureQtySold: TFloatField;
    qryShipContainerDetailsforGridDepartment: TWideStringField;
    qryShipContainerDetailsforGridProductDescription: TWideStringField;
    qryShipContainerDetailsforGridShipContainerDetailID: TIntegerField;
    qryShipContainerDetailsforGridShippingContainerID: TIntegerField;
    qryShipContainerDetailsforGridGLOBALREF: TWideStringField;
    qryShipContainerDetailsforGridSupplier: TWideStringField;
    qryShipContainerDetailsforGridCustomerJob: TWideStringField;
    qryShipContainerDetailsforGridPurchaseOrderID: TIntegerField;
    qryShipContainerDetailsforGridUnits: TWideStringField;
    qryShipContainerDetailsforGridforeignAmountInc: TFloatField;
    qryShipContainerDetailsforGridForeignExchangeCode: TWideStringField;
    qryShipContainerDetailsforGridforeignAmountStr: TWideStringField;
    qryShipContainerDetailsforGridLandedCostsTotal: TFloatField;
    qryShipContainerDetailsforGridLandedCostsPercentage: TFloatField;
    qryShipContainerDetailsforGridLandedCostsPerItem: TFloatField;
    qryShipContainerDetailsforGridTotalAuxilaryCosts: TFloatField;
    qryShipContainerDetailsforGridAuxilaryCostsPercentage: TFloatField;
    qryShipContainerDetailsforGridAuxilaryCostsPerItem: TFloatField;
    qryShipContainerDetailsforGridQtySold: TFloatField;
    qryShipContainerDetailsforGridTotalLineLandedCosts: TFloatField;
    qryShipContainerDetailsforGridBaseLineNo: TIntegerField;
    qryShipContainerDetailsforGridReceivedQty: TFloatField;
    qryShipContainerDetailsforGridInvoiceNumber: TWideStringField;
    dsShipContainerDetailsforGrid: TDataSource;
    qryShipContainerDetailsforGridorderdate: TDateTimeField;
    qryShipContainerDetailsforGridInvoiceDate: TDateField;
    qryShipContainerDetailsPurchaseOrderID: TIntegerField;
    imgPopup: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure grdDetailsIButtonClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure grdDetailsDblClick(Sender: TObject);
    procedure cboStatusNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure cmdIncudeLandeCostClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnRecieveClick(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdEmailClick(Sender: TObject);
    procedure qryShipContainerDetailsForGridAfterScroll(DataSet: TDataSet);
    procedure actApplyUpdate(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure grdDetailsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdDetailsCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
  private
    ShipContainer:TShippingContainer;
    fConnection:TERPConnection;
    fTotalImportedCosts:double;
    PO:TPurchaseOrder;
    fsSortColumnName: string;
    fsColumnOrderMode: string;
    fBaseIndexfields: string;
    //ffmt: String;
    synching:boolean;
    procedure RefreshTotals;
    function ApplyAuxilaryCosts: boolean;
    procedure ReCalc;
    procedure UpdatePerItem;
    //procedure SetForeignFieldDisplayFormat;
    function SaveData: boolean;
    procedure DoContainerChangeEvent(const Sender: TShipContainerDetails; const EventType, Value: string);
    procedure HandleContainerErrors;
    procedure AddAnyPartialBackOrders;
    Procedure SetGridColumns;
    function ConfirmApply: boolean;
    function SavePurchaseOrder(aPO: TPurchaseOrder): boolean;
    function EmailReportToAllClients: Boolean;
    function EmailToAllClients: Boolean;
    function SMSToAllClients: Boolean;
    procedure ShowOutstandingBackOrders;
    procedure PopulateSubstitutionList(SL: TStringList);
    Function Choosereport:String;
    procedure synchRecords(Ds1, Ds2: TDataset);
    (*function ShipContainerDetailsforGridSQL: String;*)
    procedure InitFormHints;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function GetReportTypeID: integer; override;
  public
    property Connection :TERPConnection read fConnection write fConnection;
  end;

implementation

{$R *.dfm}

uses
  DNMExceptions,BusObjConst,CommonLib,FormFactory,//BusObjShipContainerDetails,
  frmShipContainerPopUpGUI,frmPurchaseOrders,tcDataUtils,frmSimpleTypes,//ImportCostForm,
  tcconst,FastFuncs,frmSalesOrder,BusObjCurrency,AppEnvironment,
  frmShipBillSelectorGUI,CommonDBLib, BusObjTrans,DecimalRounding,PrintTemplateObj,
  BusObjOrderBase,frmShipLandedCostPercentGUI, IntegerListObj,
  SalesBackOrderList, EmailUtils, SMSUtils, CorrespondenceObj, EmailExtraUtils;

procedure Tfrmshipcontainer.InitFormHints;
begin
    grdDetailsIButton.Hint  := 'This will commit all the changes'; grdDetailsIButton.showhint := true; grdDetailsIButton.ParentShowHint := False;
    btnAdd.Hint             := 'This will commit all the changes'; btnAdd.showhint            := true; btnAdd.ParentShowHint            := False;
    btnRecieve.Hint         := 'This will commit all the changes'; btnRecieve.showhint        := true; btnRecieve.ParentShowHint        := False;
    cmdIncudeLandeCost.Hint := 'This will commit all the changes'; cmdIncudeLandeCost.showhint:= true; cmdIncudeLandeCost.ParentShowHint:= False;
end;
procedure TfrmShipContainer.FormCreate(Sender: TObject);
begin
  initformhints;
  grdbusobj.Visible := devmode;
  synching := false;
  AllowCustomiseGrid := True;
  if not(Devmode) then ExcludeGridfromcustomize(grdbusobj);
  inherited;
  ShipContainer:= TShippingContainer.Create(self);
  ShipContainer.Connection := TMyDacDataConnection.Create(ShipContainer);
  ShipContainer.Connection.MyDacConnection := MyConnection;
  ShipContainer.BusObjEvent := DoBusinessObjectEvent;

  PO := TPurchaseOrder.Create(nil);
  PO.Connection := TMyDacDataConnection.Create(PO);
  TMyDacDataConnection(PO.Connection).MydacConnection  := Self.MyConnection;
  PO.SilentMode:= true;
  GuiPrefs.Active := True;
end;


procedure TfrmShipContainer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  RollbackTransaction;   
  Action := caFree;
  inherited;
end;

procedure TfrmShipContainer.FormShow(Sender: TObject);
var
  fld: TField;
  ffmtPerc: String;
begin
  DisableForm;
  try
    try
      inherited;
      RollbackTransaction;
      // Put our Database Connection into transaction mode.
      BeginTransaction;

      qrySimpleTypes.Open;
      //qryPurchaseLineLookup.Open;
      if KeyID = 0 then begin
        ShipContainer.New;
        ShipContainer.ContainerDetails;
      end else begin
        ShipContainer.Load(KeyId);
        ShipContainer.ContainerDetails;
        ShipContainer.ContainerDetails.OnContainerChange := DoContainerChangeEvent;
        //need to add partial backorders if missing
        AddAnyPartialBackOrders;
      end;
      //SetForeignFieldDisplayFormat;

      ffmtPerc := '##0.00 %;(''##0.00 %)';
      if qryShipContainerDetails.Active then begin
        fld:= qryShipContainerDetails.FindField('LandedCostsPercentage');
        if Assigned(fld) then TFloatField(fld).DisplayFormat:= ffmtPerc;
      end;
      RefreshTotals;
      SetGridColumns;
      ShipContainer.PostDb;
      Closedb(qryShipContainerDetailsforGrid);
      qryShipContainerDetailsforGrid.ParamByName('xShippingContainerID').AsInteger :=ShipContainer.Id;
      openQueries;

      GuiPrefs.DbGridElement[grdDetails].RemoveFields('ShippingContainerID,ShipContainerDetailId,Globalref,foreignAmountStr');
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmShipContainer.AddAnyPartialBackOrders;
begin 
(*var
  strSQL:String;
  qry:TERPQuery;
begin
  strSQL:='Select POnew.BaseNo ,PLnew.PurchaseOrderID,PLnew.PurchaseLineID,PLnew.BaseLineNo' +
          ' From  tblpurchaselines PL' +
          ' INNER JOIN tblpurchaseorders PO ON PL.purchaseorderID = PO.purchaseOrderID' +
          ' inner join tblpurchaselines PLNew on ' +
              ' (PL.PurchaseLineID = PLNew.Baselineno  or PL.Baselineno  = PLNew.Baselineno ) ' +
              ' and (PL.PurchaseLineID <> PLNew.PurchaselineId) and ' +
              ' (PL.PurchaseOrderId <> PLNew.PurchaseOrderID)' +
          ' inner join tblshipcontainerdetails SCD  on PL.PurchaseLineID = SCD.PurchaseLineID' +
          ' Inner JOIN tblpurchaseorders PONew ON PLnew.purchaseorderID = PONew.purchaseOrderID' +
          ' where SCD.ShippingContainerID =  ' + IntToStr(KeyID)+
          ' and ifnull(PLnew.Shipped , 0)<>0';


    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Self.MyConnection;
      qry.SQL.add(strSQL);
      qry.open;
      Iteraterecords(qry , Createcontainerlines);
    finally
      FreeAndNil(qry);
     end*)

(*var
  qry:TERPQuery;
  bm: TBookmark;
  lineList: TIntegerList;
begin     {todo maybe progress pop up here}
  lineList:= TIntegerList.Create;
  bm := qryShipContainerDetails.GetBookmark;
  qryShipContainerDetails.DisableControls;
  try
    //CreateListOfBasePurchaseLineIDs
    qryShipContainerDetails.First;    {todo  disablecontrols bookmark}
    while not qryShipContainerDetails.Eof do begin
      if qryShipContainerDetails.FieldByName('BaseLineNo').AsInteger = 0 then
      lineList.Add(qryShipContainerDetails.FieldByName('PurchaseLineID').AsInteger);
      qryShipContainerDetails.Next;
    end;
    //CreateListOfAssociated PurchaseOrderLineIDs
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Self.MyConnection;

      qry.SQL.Add('select PO.BaseNo ,PL.PurchaseOrderID,PL.PurchaseLineID,PL.BaseLineNo');
      qry.SQL.Add('from tblpurchaselines PL');
      qry.SQL.Add('INNER JOIN tblpurchaseOrders PO on PL.PurchaseOrderID = PO.PurchaseOrderID');
      qry.SQL.Add('where PL.PurchaseLineID in (' + lineList.CommaText + ')');
      qry.Open;
      while not qry.eof do begin
        if not lineList.InList(qry.fieldByName('PurchaseLineID').asInteger) then begin
          lineList.Add(qry.fieldByName('PurchaseLineID').asInteger);
          ShipContainer.ContainerDetails.New;
          ShipContainer.ContainerDetails.PurchaseLineID := qry.fieldByName('PurchaseLineID').asInteger;
          ShipContainer.ContainerDetails.Save;
        end;
        qry.Next;
      end;
    finally
      FreeAndNil(qry);
     end
  finally
    lineList.Free;
    qryShipContainerDetails.GotoBookmark(bm);
    qryShipContainerDetails.FreeBookmark(bm);
    qryShipContainerDetails.EnableControls;
  end;*)
end;


procedure TfrmShipContainer.DoBusinessObjectEvent(  const Sender: TDatasetBusObj; const EventType, Value: string);
var
  msg: string;
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
         if Sender is TShippingContainer    then TShippingContainer(Sender).DataSet   := qryShippingContainer
    else if Sender is TShipContainerDetails then TShipContainerDetails(Sender).DataSet:= qryShipContainerDetails;
  end else if  (Eventtype = BusobjEvent_Event) and (Value = BusObjEventVal_Deleted) and (Sender is TShipContainerDetails) then begin
    stepProgressbar;
(*  end else if  (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost) then begin
    if  (Sender is TShipContainerDetails) or  (Sender is TShippingContainer)  then
*)
  end else  if  (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) and (Sender is TShipContainerDetails) then begin
    synchRecords(qryShipContainerDetails    , qryShipContainerDetailsforGrid);
  end
  else if (Sender is TPurchaseOrder) and (Eventtype = BusobjEvent_Event) and (Value = BusobjEventVal_FailedPOValidateData) then begin
    if TPurchaseOrder(Sender).ResultStatus.HasCode(BOR_Order_Warn_Landedcost) then begin
      { laned costs don't total 100 % }
        Msg := 'You Have Allocated ' + FloatToStrF(TPurchaseOrder(Sender).PercentageUseImportCost, ffNumber, 15, 2) +
               '% Of the Landed Costs to Order No ' + IntToStr(TPurchaseOrder(Sender).ID) + ' for ' + TPurchaseOrder(Sender).SupplierName +
               ', 100% should be the Maximum Allocated.' + #13#10 + #13#10 +
               'Do you wish the Landed costs for all lines on the Purchase Order to be Re-Calculated to Match the Total Landed Cost?';

       if CommonLib.MessageDlgXP_Vista(msg,  mtInformation, [mbYes, mbNo], 0) = mrYes then begin
         TPurchaseOrder(Sender).ReDistributeLineLandedCost;
       end;
    end;
  end;

  if sender is TShippingContainer then BusObjProgressbarEvent(Sender,EventType, Value);
end;

procedure TfrmShipContainer.DoContainerChangeEvent(
  const Sender: TShipContainerDetails; const EventType, Value: string);
begin
  if EventType = 'Percentage ReCalc' then begin
    ReCalc;
  end;
  if EventType = 'LandedCostPerItemChanged' then begin
    UpdatePerItem;
  end;
end;

function TfrmShipContainer.SaveData: boolean;
begin
  PostDB(qryShippingContainer);
  result := ShipContainer.Save;
  if not result then HandleContainerErrors
  else ShipContainer.Dirty:= false;
end;

procedure TfrmShipContainer.actSaveExecute(Sender: TObject);
var
  headerChanged: Boolean;
  DlgResult: integer;
  CustButtons: string;
begin
  DisableForm;
  try
    inherited;
    if not SaveData then exit;
    ShipContainer.updatePOLinesETA;
    headerChanged:= ShipContainer.headerChanged;
    ShipContainer.Connection.CommitTransaction;
    KeyId :=  qryShippingContainerShippingContainerID.AsInteger;

    if headerChanged then begin
      CustButtons := 'Cancel,Email';
      if AppEnv.CompanyPrefs.SMSEnabled and AppEnv.CompanyPrefs.EnablShipContainerChangeSMS then begin
        CustButtons := CustButtons  + ',SMS,Both';
      end;
      DlgResult := MessageDlgXP_Vista('Estimated Time or the Status Changed. Do You Wish To Send a Message to the Customers?',
        mtConfirmation,[],0,nil,'','',false,nil,CustButtons);
      case DlgResult of
        100:; {do nothing}
        101:  { Email }
          begin
            if AppEnv.CompanyPrefs.EnableShipContainerChangeEmail then begin
              if not self.EmailToAllClients then begin
                MessageDlgXP_Vista('Emailing Failed.' , mtWarning, [mbok],0);
                ShipContainer.Connection.BeginTransaction;
                exit;
              end;
            end
            else begin
              if not EmailReportToAllClients then begin
                MessageDlgXP_Vista('Emailing the report Failed.' , mtWarning, [mbok],0);
                ShipContainer.Connection.BeginTransaction;
                exit;
              end;
            end;

          end;
        102:
          begin  { SMS }
            if not SMSToAllClients then begin
              MessageDlgXP_Vista('Sending SMS message Failed.' , mtWarning, [mbok],0);
              ShipContainer.Connection.BeginTransaction;
              exit;
            end;
          end;
        103:  { Both }
          begin
            if AppEnv.CompanyPrefs.EnableShipContainerChangeEmail then begin
              if not self.EmailToAllClients then begin
                MessageDlgXP_Vista('Emailing Failed.' , mtWarning, [mbok],0);
                ShipContainer.Connection.BeginTransaction;
                exit;
              end;
            end
            else begin
              if not EmailReportToAllClients then begin
                MessageDlgXP_Vista('Emailing the report Failed.' , mtWarning, [mbok],0);
                ShipContainer.Connection.BeginTransaction;
                exit;
              end;
            end;
            if not SMSToAllClients then begin
              MessageDlgXP_Vista('Sending SMS message Failed.' , mtWarning, [mbok],0);
              ShipContainer.Connection.BeginTransaction;
              exit;
            end;
          end;
      end;
    end;
    Notify;
    ShipContainer.UserLock.Unlock(ShipContainer.LockGroupName);
    Close;
  finally
    EnableForm;
  end;
end;


procedure TfrmShipContainer.actSaveUpdate(Sender: TObject);
begin
  inherited;
  actSave.Enabled:= self.ShipContainer.Dirty;
end;

procedure TfrmShipContainer.actApplyUpdate(Sender: TObject);
begin
  inherited;
  actApply.Enabled:= self.ShipContainer.Dirty;
end;

procedure TfrmShipContainer.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmShipContainer.actNewExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if qryShippingContainer.State in [dsInsert, dsEdit] then
      qryShippingContainer.post;
    if ShipContainer.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if not SaveData then Exit;
            if Self.Connection = nil then self.CommitTransaction;
          end;
        mrNo:
          begin

          end;
        mrCancel:
          begin
            Exit;
          end;
      end;
    end;

    KeyID := 0;
    FormShow(nil);
    ShipContainer.Dirty := false;
  finally
    EnableForm;
  end;  
end;

procedure TfrmShipContainer.HandleContainerErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := ShipContainer.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_No_Ship_Container_Status :  begin
                                   SetControlFocus(cboStatus);
                                   exit;
                                 end;
      BOR_No_Ship_ContainerName    :  begin
                                   SetControlFocus(edName);
                                   exit;
                                 end;
    end;
  end;
end;



procedure TfrmShipContainer.PopulateSubstitutionList(SL: TStringList);
begin
  SL.Values['#ContainerName#'] := ShipContainer.ContainerName;
  SL.Values['#VesselName#'] := ShipContainer.VesselName;
  SL.Values['#DeparturePoint#'] := ShipContainer.DeparturePoint;
  SL.Values['#ArrivalPoint#'] := ShipContainer.ArrivalPoint;
  SL.Values['#EstTimeDeparture#'] := DateToStr(ShipContainer.ETDeparture);
  SL.Values['#EstTimeArrival#'] := DateToStr(ShipContainer.ETA);
  SL.Values['#Status#'] := ShipContainer.ShippingContainerStatus;
end;

procedure TfrmShipContainer.grdDetailsIButtonClick(Sender: TObject);
var
  msgOption:Word;
begin
  inherited;
  msgOption:= MessageDlgXP_Vista('Do You Wish To Delete This Line or Delete all Lines?', mtConfirmation,[] , 0 ,nil , '' , '' , False, nil , 'This Line,All Lines,Cancel' );
  ShipContainer.ContainerDetails.dataset.disableControls;
  try
    (*qryPurchaseLineLookUp.disableControls;
    try*)
      ShipContainer.ContainerDetails.DoFieldChangewhenDisabled := True;
      if msgOption = 102 then Exit;
      closedb(qryShipContainerDetailsforGrid);
      try
        if msgOption = 100 then begin
            stepProgressbar;
            ShipContainer.ContainerDetails.Delete;
            ShipContainer.ContainerDetails.Dirty := True;
        end else if msgOption = 101 then begin
            showProgressbar(WAITMSG , ShipContainer.ContainerDetails.count);
            try
              stepProgressbar;
              ShipContainer.ContainerDetails.DeleteAll;
              ShipContainer.ContainerDetails.Dirty := True;
            finally
              HideProgressbar;
            end;
        end;
      finally
        (*openDB(qryShipContainerDetailsforGrid);*)
        btnApply.Click;
        synchRecords(qryShipContainerDetails , qryShipContainerDetailsforGrid);
      end;
(*    finally
      qryPurchaseLineLookUp.EnableControls;
    end;*)
  finally
    ShipContainer.ContainerDetails.dataset.EnableControls;
  end;
end;

procedure TfrmShipContainer.grdDetailsTitleButtonClick(Sender: TObject;
  AFieldName: string);
var
  tmpIndex: string;
  slColumnSortOrder: TStringList;

  function IsFieldNameInBaseFieldIndexes(const sFieldIndexPattern: string; const slColumnSortOrder: TStringList): boolean;
  var
    iX: integer;
  begin
    Result := false;
    for iX := 0 to slColumnSortOrder.Count - 1 do begin
      if FastFuncs.PosEx(sFieldIndexPattern, slColumnSortOrder.Strings[iX]) <> 0 then begin
        Result := True;
        exit;
      end;
    end;
  end;

  function BuildBaseIndexes(const slColumnSortOrder: TStringList): string;
  var
    iX: integer;
  begin
    Result := '';
    for iX := 0 to slColumnSortOrder.Count - 1 do begin
      if iX = 0 then Result := slColumnSortOrder.Strings[0]
      else Result := Result + '; ' + slColumnSortOrder.Strings[iX];
    end;
  end;

  procedure ChangeFieldSortOrder(const sFieldName, sNewOrder: string; const slColumnSortOrder: TStringList);
  var
    iX: integer;
    Buffer: array [0 .. 255] of char;
    Field: array [0 .. 255] of char;
  begin
    StrPCopy(Field, sFieldName);
    StrLower(Field);
    for iX := 0 to slColumnSortOrder.Count - 1 do begin
      StrPCopy(Buffer, slColumnSortOrder.Strings[iX]);
      StrLower(Buffer);
      if FastFuncs.PosEx(string(Field), string(Buffer)) <> 0 then begin
        // We do this twice to ensure no matter what it is it will update
        // to the new requested search order.
        slColumnSortOrder.Strings[iX] := StringReplace(slColumnSortOrder.Strings[iX], ' ASC ', sNewOrder, [rfReplaceAll, rfIgnoreCase]);
        slColumnSortOrder.Strings[iX] := StringReplace(slColumnSortOrder.Strings[iX], ' DESC ', sNewOrder, [rfReplaceAll, rfIgnoreCase]);
        exit;
      end;
    end;
  end;

  Procedure AddBasEindexfields(var Indexfields:String);
  begin
    if fBaseIndexfields <> '' then
      if (SameText(Indexfields ,Quotedstr(fBaseIndexfields))) or  (pos(uppercase(Quotedstr(fBaseIndexfields)) ,uppercase(Indexfields))=1) then
      else if Indexfields <> '' then
        Indexfields := fBaseIndexfields +',' + Indexfields
      else Indexfields := fBaseIndexfields;
  end;

begin
  Processingcursor(True);
  try
    slColumnSortOrder := TStringList.Create;
    slColumnSortOrder.Clear;
    if fsSortColumnName <> AFieldName then begin
      qryShipContainerDetailsforGrid.IndexFieldNames := 'PurchaseOrderID';//'CustomerJob'; //BaseIndexFieldNames;
      fsColumnOrderMode := 'ASC';
    end;

    if qryShipContainerDetailsforGrid.IndexFieldNames <> '' then begin
      ExtractStrings([';'], [' '], PChar(qryShipContainerDetailsforGrid.IndexFieldNames), slColumnSortOrder);
    end;

    if qryShipContainerDetailsforGrid.FindField(AFieldName) <> nil then begin
      if (qryShipContainerDetailsforGrid.FieldByName(AFieldName).fieldKind <> fkLookup) and (qryShipContainerDetailsforGrid.FieldByName(AFieldName).fieldKind <> fkCalculated) and (qryShipContainerDetailsforGrid.FieldByName(AFieldName).DataType <> ftWideMemo) and
        (qryShipContainerDetailsforGrid.FieldByName(AFieldName).DataType <> ftMemo) then begin
        qryShipContainerDetailsforGrid.DisableControls;

        if (IsFieldNameInBaseFieldIndexes(QuotedStr(AFieldName) + ' ASC CIS', slColumnSortOrder)) or (IsFieldNameInBaseFieldIndexes(AFieldName + ' ASC CIS', slColumnSortOrder)) then begin
          ChangeFieldSortOrder(AFieldName, ' DESC ', slColumnSortOrder);
          if (slColumnSortOrder.Count > 0) then begin
            if not(IsFieldNameInBaseFieldIndexes(AFieldName, slColumnSortOrder)) then begin
//              if not SwapBaseIndexFieldPriority then begin
                tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + BuildBaseIndexes(slColumnSortOrder) + ';';
//              end else begin
//                tmpIndex := BuildBaseIndexes(slColumnSortOrder) + '; ' + QuotedStr(AFieldName) + ' DESC CIS;';
//              end;
            end else begin
              tmpIndex := BuildBaseIndexes(slColumnSortOrder) + ';';
            end;
          end else begin
//            if not empty(SecondaryIndexFieldNames) then begin
//              tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + SecondaryIndexFieldNames + ' DESC CIS;';
//            end else begin
//              tmpIndex := QuotedStr(AFieldName) + ' DESC CIS;';
//            end;
          end;

          fsColumnOrderMode := 'DESC';
          fsSortColumnName := AFieldName;

          try
            qryShipContainerDetailsforGrid.IndexFieldNames := '';
            Application.ProcessMessages;
            addbaseindexfields(tmpIndex);
            qryShipContainerDetailsforGrid.IndexFieldNames := tmpIndex;
//            DoQrymainafteropen;
          except
          end;
        end else begin
          if (fsColumnOrderMode = '') or (fsColumnOrderMode = 'ASC') then begin
            if (slColumnSortOrder.Count > 0) then begin
              if not(IsFieldNameInBaseFieldIndexes(AFieldName, slColumnSortOrder)) then begin
//                if not SwapBaseIndexFieldPriority then begin
                  tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + BuildBaseIndexes(slColumnSortOrder) + ';';
//                end else begin
//                  tmpIndex := BuildBaseIndexes(slColumnSortOrder) + '; ' + QuotedStr(AFieldName) + ' DESC CIS;';
//                end;
              end else begin
                ChangeFieldSortOrder(AFieldName, ' DESC ', slColumnSortOrder);
                tmpIndex := BuildBaseIndexes(slColumnSortOrder) + ';';
              end;
            end else begin
//              if not empty(SecondaryIndexFieldNames) then begin
//                tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + SecondaryIndexFieldNames + ' DESC CIS;';
//              end else begin
//                tmpIndex := QuotedStr(AFieldName) + ' DESC CIS;';
//              end;
            end;
            fsColumnOrderMode := 'DESC';
          end else begin
            if (fsColumnOrderMode = 'DESC') then begin
              if (slColumnSortOrder.Count > 0) then begin
                if not(IsFieldNameInBaseFieldIndexes(AFieldName, slColumnSortOrder)) then begin
//                  if not SwapBaseIndexFieldPriority then begin
                    tmpIndex := QuotedStr(AFieldName) + ' ASC CIS; ' + BuildBaseIndexes(slColumnSortOrder) + ';';
//                  end else begin
//                    tmpIndex := BuildBaseIndexes(slColumnSortOrder) + '; ' + QuotedStr(AFieldName) + ' ASC CIS;';
//                  end;
                end else begin
                  ChangeFieldSortOrder(AFieldName, ' ASC ', slColumnSortOrder);
                  tmpIndex := BuildBaseIndexes(slColumnSortOrder) + ';';
                end;
              end else begin
//                if not empty(SecondaryIndexFieldNames) then begin
//                  tmpIndex := QuotedStr(AFieldName) + ' ASC CIS; ' + SecondaryIndexFieldNames + ' ASC CIS;';
//                end else begin
//                  tmpIndex := QuotedStr(AFieldName) + ' ASC CIS;';
//                end;
              end;
              fsColumnOrderMode := 'ASC';
            end;
          end;

          fsSortColumnName := AFieldName;

          try
            qryShipContainerDetailsforGrid.IndexFieldNames := '';
            Application.ProcessMessages;
            addbaseindexfields(tmpIndex);
            qryShipContainerDetailsforGrid.IndexFieldNames := tmpIndex;
//            DoQrymainafteropen;
          except
          end;
        end;

        qryShipContainerDetailsforGrid.Enablecontrols;
      end;
    end;

  finally
    // Release our used objects.
    if Assigned(slColumnSortOrder) then FreeandNil(slColumnSortOrder);
    // Restore previous screen cursor.
    Processingcursor(False);
  end;
end;

procedure TfrmShipContainer.btnAddClick(Sender: TObject);
var
  frm:TComponent;
begin
  DisableForm;
  try
    inherited;
    if ShipContainer.Dataset.RecordCount > 0 then begin
      if not SaveData then begin
        HandleContainerErrors;
        Exit;
      end;
    end;

    closeDB(qryShipContainerDetailsforGrid);
    try
      ShipContainer.ContainerDetails.dataset.disableControls;
      try
        ShipContainer.ContainerDetails.DoFieldChangewhenDisabled := True;
              frm := GetComponentByClassName('TfrmShipContainerPopUp');
              if Assigned(Frm) then begin
                with TfrmShipContainerPopUp(Frm) do begin
                  SubShip := ShipContainer;  //set the ShipContainer to the object pointer on the pop up form
                  qryPOs.Connection := Self.MyConnection;
                  if ShowModal = mrOk then begin
                    RefreshTotals;
                  end;
                end;
              end;
      finally
        ShipContainer.ContainerDetails.dataset.EnableControls;
      end;
    finally
      closeDB(qryShipContainerDetailsforGrid);
      opendb(qryShipContainerDetailsforGrid);
      btnApply.Click;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmShipContainer.grdDetailsCalcTitleImage(Sender: TObject;
  Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
begin
  if not Assigned(Field) then exit; { just in case user switches off all fields in gui prefs }
  if (FastFuncs.PosEx(QuotedStr(Field.fieldname) + ' ASC CIS;', qryShipContainerDetailsforGrid.IndexFieldNames) > 0) or (FastFuncs.PosEx(Field.fieldname + ' ASC CIS;', qryShipContainerDetailsforGrid.IndexFieldNames) > 0) then begin
    TitleImageAttributes.ImageIndex := 3;
  end
  else if (FastFuncs.PosEx(QuotedStr(Field.fieldname) + ' DESC CIS;', qryShipContainerDetailsforGrid.IndexFieldNames) > 0) or (FastFuncs.PosEx(Field.fieldname + ' DESC CIS;', qryShipContainerDetailsforGrid.IndexFieldNames) > 0) then begin
    TitleImageAttributes.ImageIndex := 4;
  end else begin
    TitleImageAttributes.ImageIndex := -1;
  end;
end;

procedure TfrmShipContainer.grdDetailsDblClick(Sender: TObject);
var
  frm:TComponent;
begin
  inherited;
  if ShipContainer.ContainerDetails.count = 0 then exit;
  ProcessingCursor;
  try
    if (Sysutils.SameText('CustomerJob',grdDetails.getActiveField.FieldName))
      and (qryShipContainerDetailsforGrid.FieldByName('CustomerJob').AsString <> '') then begin
      frm := GetComponentByClassName('TSalesOrderGUI');
      if Assigned(Frm) then begin
        with TSalesOrderGUI(Frm) do begin
          TSalesOrderGUI(Frm).KeyID := tcDataUtils.getSaleIDLinkedToPurchase(ShipContainer.ContainerDetails.PurchaseLineID);
          TSalesOrderGUI(Frm).OpenedFromShipContainer := True;
          TSalesOrderGUI(Frm).ShipContainerSaleLineID := tcDataUtils.GetSaleLineIDLinkedToPurchase(ShipContainer.ContainerDetails.PurchaseLineID);
          ShowModal;
        end;
      end;
    end else if (Sysutils.SameText('LandedCostsPercentage',grdDetails.getActiveField.FieldName))
      or (Sysutils.SameText('LandedCostsPerItem',grdDetails.getActiveField.FieldName)) then begin
      frm := GetComponentByClassName('TfrmShipLandedCostPercent');
      if Assigned(Frm) then begin
        with TfrmShipLandedCostPercent(Frm) do begin
          SubShip := ShipContainer;  //set the ShipContainer to the object pointer on the pop up form
          DSShip.DataSet := qryShipContainerDetails;
          TfrmShipLandedCostPercent(Frm).KeyID := tcDataUtils.getPurchaseOrderID(ShipContainer.ContainerDetails.PurchaseLineID);
          ShowModal;
        end;
      end;
    end else begin
      if not ConfirmApply then exit;
      CommitTransaction;
      BeginTransaction;
      if ShipContainer.ContainerDetails.PurchaseLineID = 0 then exit;
      frm := GetComponentByClassName('TPurchaseGUI');
      if Assigned(Frm) then begin
        try
          TPurchaseGUI(Frm).KeyID := tcDataUtils.getPurchaseOrderID(ShipContainer.ContainerDetails.PurchaseLineID);
                 //GetBackOrderID(ShipContainer.ContainerDetails.PurchaseLineID);
          TForm(frm).ShowModal;
        finally
            FreeandNil(frm);
        end;
      end;
    end;
  finally
    ProcessingCursor(False);
  end;
end;


procedure TfrmShipContainer.cboStatusNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
//  inherited;
  Accept := False;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_ShippingContainerStatusType,NewValue) then begin
      Accept:= true;
      LookupTable.Refresh;
    end;
  end;  
end;

function TfrmShipContainer.Choosereport: String;
begin
          LoadReportTypes;
          if dlgReportSelect.Execute then begin
            REsult := dlgReportSelect.SelectedItems.Text;
            inherited;
          end;
end;

procedure TfrmShipContainer.RefreshTotals;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= qryShipContainerDetails.Connection;
    qry.SQL.Add('select sum(tblpurchaselines.LineCostInc * tblpurchaselines.qtysold) as TotalAmount,');
    qry.SQL.Add('sum(tblpurchaselines.ForeignCurrencyLineCost * tblpurchaselines.qtysold) as TotalForeign');
    qry.SQL.Add('from tblshipcontainerdetails, tblpurchaselines');
    qry.SQL.Add('where ShippingContainerID = ' + IntToStr(ShipContainer.ID));
    qry.SQL.Add('and tblshipcontainerdetails.PurchaseLineID = tblpurchaselines.PurchaseLineID');
    qry.Open;
    grdDetails.ColumnByName('TotalAmountInc').FooterValue       := FloatToStrF(qry.FieldByName('TotalAmount').AsFloat,ffCurrency, 15, CurrencyRoundPlaces);
    grdDetails.ColumnByName(self.qryShipContainerDetailsforGridforeignAmountInc.FieldName).FooterValue     := FormatFloat('#,##0.00;(#,##0.00)',qry.FieldByName('TotalForeign').AsFloat );
    grdDetails.ColumnByName('TotalLineLandedCosts').FooterValue := FloatToStrF(qryShipContainerDetailsTotalAuxilaryCosts.AsFloat,ffCurrency, 15, CurrencyRoundPlaces);
  finally
    qry.Free;
  end;
end;



procedure TfrmShipContainer.cmdEmailClick(Sender: TObject);
var
  CustButtons: string;
  DlgResult: integer;
begin
  DisableForm;
  try
    if not SaveData then exit;
    ShipContainer.Connection.CommitTransaction;

    CustButtons := 'Cancel,Email';
    if AppEnv.CompanyPrefs.SMSEnabled and AppEnv.CompanyPrefs.EnablShipContainerChangeSMS then begin
      CustButtons := CustButtons  + ',SMS,Both';
    end;
    DlgResult := MessageDlgXP_Vista('Send message to all Customers?',
      mtConfirmation,[],0,nil,'','',false,nil,CustButtons);
    case DlgResult of
      100:; {do nothing}
      101:  { Email }
        begin
          if AppEnv.CompanyPrefs.EnableShipContainerChangeEmail then begin
            if not self.EmailToAllClients then begin
              MessageDlgXP_Vista('Emailing Failed.' , mtWarning, [mbok],0);
              ShipContainer.Connection.BeginTransaction;
              exit;
            end;
          end
          else begin
            if not EmailReportToAllClients then begin
              MessageDlgXP_Vista('Emailing the report Failed.' , mtWarning, [mbok],0);
              ShipContainer.Connection.BeginTransaction;
              exit;
            end;
          end;

        end;
      102:
        begin  { SMS }
          if not SMSToAllClients then begin
            MessageDlgXP_Vista('Sending SMS message Failed.' , mtWarning, [mbok],0);
            ShipContainer.Connection.BeginTransaction;
            exit;
          end;
        end;
      103:  { Both }
        begin
          if AppEnv.CompanyPrefs.EnableShipContainerChangeEmail then begin
            if not self.EmailToAllClients then begin
              MessageDlgXP_Vista('Emailing Failed.' , mtWarning, [mbok],0);
              ShipContainer.Connection.BeginTransaction;
              exit;
            end;
          end
          else begin
            if not EmailReportToAllClients then begin
              MessageDlgXP_Vista('Emailing the report Failed.' , mtWarning, [mbok],0);
              ShipContainer.Connection.BeginTransaction;
              exit;
            end;
          end;
          if not SMSToAllClients then begin
            MessageDlgXP_Vista('Sending SMS message Failed.' , mtWarning, [mbok],0);
            ShipContainer.Connection.BeginTransaction;
            exit;
          end;
        end;
    end;

    Self.Close;
  finally
    EnableForm;
  end;
end;

Function TfrmShipContainer.EmailReportToAllClients:Boolean;
var
  ReportSQL:String;
  s:String;
  qry : TERPQuery;
  lCount : integer;
  lSilent, lSecret : boolean;
  intResult: integer;
  strResult: string;
begin
  inherited;
  result := False;
  try
    if chkChooseRpt.Checked  then
          ReportToPrint := Choosereport
    else  ReportToPrint := 'Shipping Container Email';
    if ReportToPrint = '' then exit;
    s:= ' Select distinct ifnull(P.ClientID, C.ClientID) as ClientID, ifnull(P.Company,C.Company) as Company , group_Concat(C.ClientID) as ClientIDs,'+
              ' ifnull(C.Email, p.Email) as Email from ' +
            ' tblshipcontainerdetails SCD ' +
            ' inner join tblpurchaselines PL on PL.PurchaseLineID = SCD.PurchaseLineID ' +
            ' inner join tblclients C on C.ClientID = PL.CustomerJobID ' +
            ' Left join tblClients P on P.ClientID = C.parentClientId ' +
            ' Where  SCD.ShippingContainerID = ' + inttostr( ShipContainer.ID)+
            ' Group by ifnull(P.ClientID, C.ClientID) ';
    qry := TERPQuery(Shipcontainer.getnewdataset(s, true));
//    With Shipcontainer.getnewdataset(s, true) do try
    try
      if qry.recordcount =0 then
        exit;

      lCount := CheckEmailAddresses(qry, 'Client', 'Company', 'Email');
      if lCount = 0 then
        exit;

      if not EmailSilentSecret(lCount, false, lSilent, lSecret) then
        exit;
      intResult := CommonLib.MessageDlgXP_Vista('You are about to Email Shipping Container Details to ' +
        inttostr(lCount)+ ' Clients.' + #13 + #10 + #13 + #10 +
        'Would you like to specify a subject for this email?' + #13 + #10 + #13 + #10 +
        'Please select Yes to enter new email subject line. No to use standard subject line.', mtConfirmation,
        [mbYes, mbNo, mbCancel], 0);
      strResult := TMailUtils.SubstituteText(AppEnv.CompanyPrefs.ShipContainerChangeSMSText, PopulateSubstitutionList);
        if intResult = mrYes then begin
          strResult := InputBox('SUBJECT DECLARATION','Please specify subject for this email', strResult);
        end else if intResult = mrNo then begin
        end else begin
          Exit;
        end;

      qry.First;
      Progressbar.Min:= 1;
      Progressbar.Max:= lCount + 1; // qry.recordcount+1;
      Progressbar.Position:= 1;
      Progressbar.Step:= 1;
      Progressbar.visible:=true;
      Try
        Progressbar.StepIt;
        Progressbar.REfresh;
        while not qry.eof do
        begin
          if qry.FieldByName('Email').AsString <> '' then
          begin
            ReportSQL:= '~|||~Where C.ClientId in (' + qry.Fieldbyname('ClientIDs').asString+') and S.ShippingContainerID= ' + inttostr(Shipcontainer.ID)+'  order by company';
            EmailReport(ShipContainer.ID                    , {RecID}
                        qry.Fieldbyname('Company').asString ,{CustomerName}
                        qry.Fieldbyname('Email').asString   ,{RecipientAddress}
                        'Shipping Container'                ,{reportType}
                        ReportToPrint                       ,{sreportName}
                        ReportSQL                           ,{sSQL}
                        False                               ,{ReportSQLSupplied}
                        true                                ,{EmailforemptyAddress}
                        true                                ,{ConfirmEmailforempty}
                        lSilent                             ,{aSilent}
                        lSecret                             ,{aSecret}
                        nil                                 ,{AddAttachment}
                        strResult                           {EmailSubject});
            Application.Processmessages;
            Progressbar.StepIt;
            Progressbar.REfresh;
          end;
          qry.Next;
        end;
      Finally
        Progressbar.visible:= False;
      End;
    finally
      if qry.active then qry.close;
      qry.Free;
    end;
    result := true;
  except
    result := False;
  end;
end;

function TfrmShipContainer.EmailToAllClients: Boolean;
var
  s: string;
begin
  result := true;
  s:=
    'Select distinct ifnull(P.ClientID, C.ClientID) as ClientID,' +
    ' ifnull(P.Company,C.Company) as Company,' +
    ' ifnull(C.Email, p.Email) as Email,' +
    ' ifnull(C.Mobile, p.Mobile) as Mobile' +
    ' from  tblshipcontainerdetails SCD' +
    ' inner join tblpurchaselines PL on PL.PurchaseLineID = SCD.PurchaseLineID' +
    ' inner join tblclients C on C.ClientID = PL.CustomerJobID' +
    ' Left join tblClients P on P.ClientID = C.parentClientId' +
    ' Where  SCD.ShippingContainerID = ' + inttostr( ShipContainer.ID)+
    ' Group by ifnull(P.ClientID, C.ClientID)';
  with Shipcontainer.getnewdataset(s, true) do try
    if RecordCount = 0 then exit;
    while not EOF do begin
      if FieldByName('Mobile').AsString = '' then begin

        if not TCorrespondenceGui.EmailCustomer(FieldByName('Email').AsString,
          TMailUtils.SubstituteText(AppEnv.CompanyPrefs.ShipContainerChangeEmailSubject, PopulateSubstitutionList),
          TMailUtils.SubstituteText(AppEnv.CompanyPrefs.ShipContainerChangeEmailText, PopulateSubstitutionList),
          FieldByName('ClientID').AsInteger, true) then
          result := false;

      end;
      Next;
    end;
  finally
    Free;
  end;
end;

function TfrmShipContainer.SMSToAllClients: Boolean;
var
  s: string;
begin
  result := true;
  s:=
    'Select distinct ifnull(P.ClientID, C.ClientID) as ClientID,' +
    ' ifnull(P.Company,C.Company) as Company,' +
    ' ifnull(C.Email, p.Email) as Email,' +
    ' ifnull(C.Mobile, p.Mobile) as Mobile' +
    ' from  tblshipcontainerdetails SCD' +
    ' inner join tblpurchaselines PL on PL.PurchaseLineID = SCD.PurchaseLineID' +
    ' inner join tblclients C on C.ClientID = PL.CustomerJobID' +
    ' Left join tblClients P on P.ClientID = C.parentClientId' +
    ' Where  SCD.ShippingContainerID = ' + inttostr( ShipContainer.ID)+
    ' Group by ifnull(P.ClientID, C.ClientID)';
  with Shipcontainer.getnewdataset(s, true) do try
    if RecordCount = 0 then exit;
    while not EOF do begin
      if FieldByName('Mobile').AsString = '' then begin
        if not TCorrespondenceGui.SMSCustomer(FieldByName('Mobile').AsString,
          TMailUtils.SubstituteText(AppEnv.CompanyPrefs.ShipContainerChangeSMSText, PopulateSubstitutionList),
          FieldByName('ClientID').AsInteger, true) then
          result := false;
      end;
      Next;
    end;

  finally
    Free;
  end;
  AppEnv.UtilsClient.TriggerSMSSend;
end;


procedure TfrmShipContainer.cmdIncudeLandeCostClick(Sender: TObject);
var
  frm:TComponent;
  PONumber: string;

  function POHasNonShippingImportCosts:Boolean;
  var
    qry:TERPQuery;
    //bm: TBookMark;
    //ProgressDialog: TProgressDialog;
  begin
    Result := False;    {todo disablecontrols/ bookmark }
    qry := TERPQuery.Create(nil);
    try
      ShipContainer.PostDb;
      qry.Connection :=  MyConnection;
      qry.SQL.Add('select distinct tblPurchaseOrders.PurchaseOrderID, tblPurchaseOrders.PurchaseOrderNumber');
      qry.SQL.Add('from tblshipcontainerdetails, tblPurchaseOrders, tblPurchaseLines, tblPurchaseLines as BillLines');
      qry.SQL.Add('where shippingcontainerid = ' + IntToStr(ShipContainer.ID));
      qry.SQL.Add('and tblshipcontainerdetails.PurchaseLineID = tblPurchaseLines.PurchaseLineID');
      qry.SQL.Add('and tblPurchaseLines.PurchaseOrderID = tblPurchaseOrders.PurchaseOrderID');
      qry.SQL.Add('and BillLines.RelatedPOID = tblPurchaseOrders.PurchaseOrderID');
      qry.Open;
      if qry.RecordCount > 0 then begin
        result := true;
        PONumber := qry.FieldByName('PurchaseOrderNumber').AsString;
      end;
    finally
      qry.Free;
    end;

//    qry := TERPQuery.Create(nil);
//    ShipContainer.ContainerDetails.Dataset.DisableControls;
//    bm:= ShipContainer.ContainerDetails.Dataset.GetBookmark;
//    ProgressDialog:= TProgressDialog.Create(nil);
//    try
//      ProgressDialog.Caption:= 'Checking Container';
//      ProgressDialog.Message:= 'Please wait ...';
//      ProgressDialog.MaxValue:= ShipContainer.ContainerDetails.Dataset.RecordCount;
//      ProgressDialog.Step:= 1;
//      ProgressDialog.Execute;
//      qry.Connection := Self.MyConnection;
//      qry.SQL.Add('SELECT RelatedShipContainerIDUsed,LandedCostsTotal,PurchaseOrderNumber FROM tblpurchaselines, tblPurchaseOrders');
//      qry.SQL.Add('where tblPurchaseOrders.PurchaseOrderID = tblpurchaselines.PurchaseOrderID');
//      qry.SQL.Add('and PurchaseLineID = :xPurchaseLineID');
//
//      ShipContainer.ContainerDetails.First;
//      while not ShipContainer.ContainerDetails.EOF do begin
//        if qry.Active then qry.Active := False;
//        qry.Params.ParamByName('xPurchaseLineID').asInteger := ShipContainer.ContainerDetails.PurchaseLineID;
//        qry.Open;
//        if not qry.FieldByName('RelatedShipContainerIDUsed').AsBoolean then
//          if qry.FieldByName('LandedCostsTotal').AsFloat > 0 then begin
//            PONumber := qry.FieldByName('PurchaseOrderNumber').AsString;
//            Result := True;
//            break;
//          end;
//        ShipContainer.ContainerDetails.Next;
//        ProgressDialog.StepIt;
//      end;
//    finally
//      FreeAndNil(qry);
//      ShipContainer.ContainerDetails.Dataset.GotoBookmark(bm);
//      ShipContainer.ContainerDetails.Dataset.FreeBookmark(bm);
//      ShipContainer.ContainerDetails.Dataset.EnableControls;
//      ProgressDialog.Free;
//    end;
  end;

begin
  inherited;
  //if po already has "Import Costs" assigned with no shipping container
  if POHasNonShippingImportCosts then begin
    (*CommonLib.MessageDlgXP_Vista('This Purchase order (' + PONumber + ') already has import costs independent of Shipping Containers.' //+  #13 + #10 +
     // 'You can not assign import costs from here, use the Purchase Order screen.'
    , mtInformation,
    [mbOK], 0);*)
    TimerMsg(lblMsg ,'This Purchase order (' + PONumber + ') already has import costs independent of Shipping Containers.'  );
  end;

  fTotalImportedCosts := 0;
  ShipContainer.ContainerDetails.AuxilaryBillIDList.Clear;
  try
    if FormStillOpen('TfrmShipBillSelector') then
        TfrmShipBillSelector(FindExistingComponent('TfrmShipBillSelector')).Close;
    frm := GetComponentByClassName('TfrmShipBillSelector');
    if Assigned(frm) then begin
      with TfrmShipBillSelector(frm) do begin
        if qryBills.Active then qryBills.Close;
        qryBills.Params.ParamByName('xShippingContainerID').AsString := IntToStr(Self.KeyID);
        qryBills.Open;
        SubShip := ShipContainer;  //set the ShipContainer to the object pointer on the pop up form
        if ShowModal = mrOk then begin
//          CommitTransaction; {so if import fails they don't loose all their other inputing}
//          BeginTransaction;
          ShipContainer.Connection.BeginNestedTransaction;
          if ApplyAuxilaryCosts then
            ShipContainer.Connection.CommitNestedTransaction
          else
            ShipContainer.Connection.RollbackNestedTransaction;
          btnApply.Click;
        end else begin
          Exit;
        end;
      end;
    end;
  finally

  end;
end;

procedure TfrmShipContainer.UpdatePerItem;
var                      {used when manually edited to whatever the client decides}
  iCurrentPOID:integer;
begin
  ShipContainer.Connection.BeginNestedTransaction;
  try
    qryShipContainerDetails.Close;
    qryShipContainerDetails.Open;
    qryShipContainerDetails.DisableControls;
    ProcessingCursor;
    try
      qryShipContainerDetails.First;
      iCurrentPOID := 0;
      while not qryShipContainerDetails.Eof do begin
        if iCurrentPOID <> qryShipContainerDetails.FieldByName('PurchaseLineID').AsInteger then begin
          if PO.ID > 0 then begin
            PO.ResultStatus.Clear;
            if SavePurchaseOrder(PO) then begin
              ShipContainer.Connection.RollbackNestedTransaction;
              Exit;
            end;
            //PO.UnLock;
          end;
          iCurrentPOID := tcDataUtils.getPurchaseOrderID(qryShipContainerDetails.FieldByName('PurchaseLineID').AsInteger);
          PO.Load(iCurrentPOID);
          if not ShipContainer.UserLock.Lock('tblpurchaseorders' , PO.ID,  ShipContainer.LockGroupName) then begin
            CommonLib.MessageDlgXP_Vista(ReplaceStr(PO.userlock.LockMessage, 'this record' , 'Purchase Line' ),
             mtWarning, [mbOK], 0);

            ShipContainer.Connection.RollbackNestedTransaction;
            Exit;
          end;
        end;
        if PO.Lines.Dataset.Locate('PurchaseLineID',ShipContainer.ContainerDetails.PurchaseLineID,[]) = True then begin
          PO.Lines.UnitLandedCost := qryShipContainerDetails.FieldByName('AuxilaryCostsPerItem').AsFloat;
          PO.Lines.TotalLineLandedCostPerc := qryShipContainerDetails.FieldByName('AuxilaryCostsPercentage').AsFloat;
          //PO.Lines.PostDb;
          PO.ResultStatus.Clear;
          if SavePurchaseOrder(PO) then begin
            ShipContainer.Connection.RollbackNestedTransaction;
            Exit;
          end;
        end;
        qryShipContainerDetails.Next;
      end;

      (*qryPurchaseLineLookup.Close;
      qryPurchaseLineLookup.Open;*)
      grdDetails.DataSource.DataSet.Close;
      grdDetails.DataSource.DataSet.Open;
    finally
      qryShipContainerDetails.EnableControls;
      ProcessingCursor(False);
    end;
  finally
    //if PO.IsLocked then PO.UnLock;
  end;
  ShipContainer.Connection.CommitNestedTransaction;
end;

procedure TfrmShipContainer.ReCalc;
var
  iCurrentPOID:integer;
begin
  ShipContainer.Connection.BeginNestedTransaction;
  try
    qryShipContainerDetails.DisableControls;
    ProcessingCursor;
    try
      qryShipContainerDetails.First;
      iCurrentPOID := 0;
      while not qryShipContainerDetails.Eof do begin
        if iCurrentPOID <> qryShipContainerDetails.FieldByName('PurchaseLineID').AsInteger then begin
          iCurrentPOID := tcDataUtils.getPurchaseOrderID(qryShipContainerDetails.FieldByName('PurchaseLineID').AsInteger);
          PO.Load(iCurrentPOID);
          if not ShipContainer.UserLock.Lock('tblpurchaseorders' , PO.ID,  ShipContainer.LockGroupName) then begin
            CommonLib.MessageDlgXP_Vista(ReplaceStr(PO.userlock.LockMessage, 'this record' , 'Purchase Line' ),
             mtWarning, [mbOK], 0);

            ShipContainer.Connection.RollbackNestedTransaction;
            Exit;
          end;
        end;
        if PO.Lines.Dataset.Locate('PurchaseLineID',ShipContainer.ContainerDetails.PurchaseLineID,[]) = True then begin
          PO.Lines.TotalLineLandedCostPerc := qryShipContainerDetails.FieldByName('AuxilaryCostsPercentage').AsFloat;

          PO.ResultStatus.Clear;
          if SavePurchaseOrder(PO) then begin

            ShipContainer.Connection.RollbackNestedTransaction;
            Exit;
          end;

          {write new value to ship}
          qryShipContainerDetails.Edit;
          qryShipContainerDetails.FieldByName('AuxilaryCostsPerItem').AsFloat := PO.Lines.UnitLandedCost;
          qryShipContainerDetails.Post;
        end;

        qryShipContainerDetails.Next;
      end;

(*      qryPurchaseLineLookup.Close;
      qryPurchaseLineLookup.Open;*)
      grdDetails.DataSource.DataSet.Close;
      grdDetails.DataSource.DataSet.Open;
    finally
      qryShipContainerDetails.EnableControls;
      ProcessingCursor(FAlse);
    end;
  finally
    if PO.IsLocked then PO.UnLock;
  end;
  ShipContainer.Connection.CommitNestedTransaction;
end;

function TfrmShipContainer.ApplyAuxilaryCosts: boolean;
var
  iCurrentPOID:integer;
  dTotalLinesAmount:double;
  ProgressDialog: TProgressDialog;
begin
  result:= true;
//  if ShipContainer.TotalAuxilaryCosts = 0 then exit;
  ProgressDialog := TProgressDialog.Create(nil);
  try
    qryShipContainerDetails.DisableControls;
    ProcessingCursor;
    ProgressDialog.Caption  := 'Applying Auxilary Costs';
    ProgressDialog.Message:= 'Calculating totals ...';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := qryShipContainerDetails.RecordCount;
    ProgressDialog.Step     := 1;
    ProgressDialog.Execute;
    try
      {Get Total}
      qryShipContainerDetails.First;
      dTotalLinesAmount := 0;
      iCurrentPOID := qryShipContainerDetailsforGrid.fieldByName('PurchaseOrderID').AsInteger;
      PO.Load(iCurrentPOID);
      {calculating total cost of all PO-Lines selected}
      while not qryShipContainerDetailsforGrid.Eof do begin
        if iCurrentPOID <> qryShipContainerDetailsforGrid.fieldByName('PurchaseOrderID').AsInteger then begin
          iCurrentPOID := qryShipContainerDetailsforGrid.fieldByName('PurchaseOrderID').AsInteger;
          PO.Load(iCurrentPOID);
        end;
        if PO.Lines.Dataset.Locate('PurchaseLineID',qryShipContainerDetailsforGrid.fieldByName('PurchaseLineID').AsInteger,[]) = True then begin
          dTotalLinesAmount := dTotalLinesAmount +  (PO.Lines.LineCostInc * PO.Lines.QtySold);
        end;
        qryShipContainerDetailsforGrid.Next;
        ProgressDialog.StepIt;
      end;

      {Calc Auxilary costs }
      qryShipContainerDetailsforGrid.First;
      iCurrentPOID := 0;
      ProgressDialog.CloseDialog;
      ProgressDialog.Value:= 0;
      ProgressDialog.Message:= 'Applying costs ...';
      ProgressDialog.Execute;
      synching := True;
      try
        while not qryShipContainerDetailsforGrid.Eof do begin
          if iCurrentPOID <> qryShipContainerDetailsforGrid.FieldByName('PurchaseOrderID').AsInteger then begin
            if PO.ID > 0 then begin
              if PO.Dirty then
                if not SavePurchaseOrder(PO) then begin
                  result:= false;
                  //PO.UnLock;
                  exit;
                end;
              //PO.UnLock;
            end;
            iCurrentPOID := qryShipContainerDetailsforGrid.FieldByName('PurchaseOrderID').AsInteger;
            PO.Load(iCurrentPOID);
            if not ShipContainer.UserLock.Lock('tblpurchaseorders' , PO.ID,  ShipContainer.LockGroupName) then begin
              CommonLib.MessageDlgXP_Vista(ReplaceStr(PO.userlock.LockMessage, 'this record' , 'Purchase Line' ),
               mtWarning, [mbOK], 0);

              result:= false;
              Exit;
            end;
          end;
          if qryShipContainerDetails.Locate('ShipContainerDetailID' , qryShipContainerDetailsforGridShipContainerDetailID.asInteger , []) then begin
            if PO.Lines.Dataset.Locate('PurchaseLineID',ShipContainer.ContainerDetails.PurchaseLineID,[]) = True then begin
              qryShipContainerDetails.Edit;
              qryShipContainerDetails.FieldByName('TotalAuxilaryCosts').AsFloat := ShipContainer.TotalAuxilaryCosts;
              if ShipContainer.TotalAuxilaryCosts <> 0 then
                qryShipContainerDetails.FieldByName('AuxilaryCostsPercentage').AsFloat :=
                  Round(Divzer(PO.Lines.LineCostInc,dTotalLinesAmount) * 100 * PO.Lines.QtySold, CurrencyRoundPlaces)
              else
                qryShipContainerDetails.FieldByName('AuxilaryCostsPercentage').AsFloat := 0;

              {Add Auxilary costs to PO landed costs}
              PO.Lines.TotalOrderLandedCost := ShipContainer.TotalAuxilaryCosts;
              {The percentage breakup will be the same as auxilaryCostsPercentage}
              {dofield will do calcs in BusObjOrders}
              PO.Lines.TotalLineLandedCostPerc := qryShipContainerDetails.FieldByName('AuxilaryCostsPercentage').AsFloat;
              {dofieldchangeevent will ReCalc LineLandedCost based on percentage of TotalLineLandedCost}
                    {LineLandedCost is LandedCostsPerItem}
              //Now add the purchase cost to the import costs

              EditDB(qryShipContainerDetails);
              qryShipContainerDetails.FieldByName('AuxilaryCostsPerItem').AsFloat := PO.Lines.UnitLandedCost;
              PostDB(qryShipContainerDetails);
            end;
          end;
          qryShipContainerDetailsforGrid.Next;
          ProgressDialog.StepIt;
        end;
      finally
        synching:= False;
        synchRecords(qryShipContainerDetails , qryShipContainerDetailsforGrid);
      end;
      if PO.Dirty then

//        if not PO.ValidateData then
//          self.DoBusinessObjectEvent(PO, BusobjEvent_Event, BusobjEventVal_FailedPOValidateData);

        if not SavePurchaseOrder(PO) then begin
          result:= false;
          exit;
        end;
(*      qryPurchaseLineLookup.Close;
      qryPurchaseLineLookup.Open;*)
      grdDetails.DataSource.DataSet.Close;
      grdDetails.DataSource.DataSet.Open;
      ProgressDialog.CloseDialog;
    finally
      qryShipContainerDetailsforGrid.EnableControls;
      ProcessingCursor(FAlse);
    end;
  finally
    ProgressDialog.Free;
  end;
end;

procedure TfrmShipContainer.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(PO);
end;

(*procedure TfrmShipContainer.SetForeignFieldDisplayFormat;
var
  CurrencySymbol: string;
  fld: TField;
begin
  CurrencySymbol:= TCurrency.CurrencySymbolForCode(qryShipContainerDetails.FieldByName('ForeignExchangeCode').asString, MyConnection);
  ffmt:= CurrencySymbol + '#,##0.00;(' + CurrencySymbol + '#,##0.00)';
  fld:= qryShipContainerDetails.FindField('foreignAmountInc');
  if Assigned(fld) then TFloatField(fld).DisplayFormat:= ffmt;


//  qryShipContainerDetails.DisableControls;
//  try
//    qryShipContainerDetails.First;
//    while not qryShipContainerDetails.Eof do begin
//      CurrencySymbol:= TCurrency.CurrencySymbolForCode(qryShipContainerDetails.FieldByName('ForeignExchangeCode').asString, MyConnection);
//      if CurrencySymbol = AppEnv.RegionalOptions.CurrencySymbol then
//        qryShipContainerDetails.Next
//      else break;
//    end;
//
//    ffmt:= CurrencySymbol + '#,##0.00;(' + CurrencySymbol + '#,##0.00)';
//    if qryShipContainerDetails.Active then begin
//      fld:= qryShipContainerDetails.FindField('foreignAmountInc');
//      if Assigned(fld) then TFloatField(fld).DisplayFormat:= ffmt;
//    end;
//  finally
//    qryShipContainerDetails.First;
//    qryShipContainerDetails.EnableControls;
//  end;
end;*)


procedure TfrmShipContainer.btnPrintClick(Sender: TObject);
var
  ReportName, StrWhere: string;
begin
  DisableForm;
  try
    if not ConfirmApply then exit;
    CommitTransaction;
    BeginTransaction;
    if chkChooseRpt.Checked then
         ReportName := ChooseReport
    else ReportName:= tcdatautils.GetDefaultReport(GetReportTypeID);
    StrWhere:= ' ~|||~WHERE S.Shippingcontainerid = ' + IntToStr(KeyId) +
    ' ORDER BY PO.SupplierName';
    PrintTemplateReport(ReportName,StrWhere,false,1);
  finally
    EnableForm;
  end;    
end;

procedure TfrmShipContainer.btnRecieveClick(Sender: TObject);
var
  msg:String;
begin
    if CommonLib.MessageDlgXP_Vista('This will receive all the Purchase Orders in this container. Do you wish to continue? ', mtConfirmation, mbYesNoCancel, 0) = mrno then exit;

    if not savedata then Exit;

    ShipContainer.ContainerDetails.dataset.disableControls;
    try
      closeDB(qryShipContainerDetailsforGrid);
      try
            ShipContainer.Connection.BeginNestedTransaction;
            try
              if not ShipContainer.ReceiveAll(msg) then begin
                if msg <> '' then CommonLib.MessageDlgXP_Vista('''Receive All'' Failed. ' +chr(13) +  msg , mtWarning , [mbOk] , 0);
                ShipContainer.Connection.RollbackNestedTransaction;
                exit;
              end else begin
                if msg <> '' then begin
                  CommonLib.MessageDlgXP_Vista('Receive All Failed. ' +chr(13) +  msg , mtInformation, [mbOk] , 0);
                  ShipContainer.Connection.RollbackNestedTransaction;
                  exit;
                end else begin
                  ShipContainer.Connection.CommitNestedTransaction;
                  ShowOutstandingBackOrders;
                end;
              end;
            Except
                on E:Exception do begin
                  CommonLib.MessageDlgXP_Vista('Receive All Failed. ' +chr(13) +  E.Message , mtWarning , [mbOk] , 0);
                  try ShipContainer.Connection.RollbackNestedTransaction; except end;
                end;
            end;
            ShipContainer.Dirty := true;
            btnApply.Click;
      finally
        opendb(qryShipContainerDetailsforGrid);
      end;
    finally
      ShipContainer.ContainerDetails.dataset.EnableControls;
    end;
end;

procedure TfrmShipContainer.ShowOutstandingBackOrders;
var
  qry: TERPQuery;
  PO: TPurchaseOrder;
  sFilter, s: string;
  BackOrdersList: TComponent;
begin
  sFilter := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := self.MyConnection;
    qry.SQL.Add('select distinct pl.PurchaseOrderID as PurchaseOrderId');
    qry.SQL.Add('from tblshipcontainerdetails cd, tblPurchaseLines pl');
    qry.SQL.Add('where cd.ShippingContainerId = ' + IntToStr(ShipContainer.Id));
    qry.SQL.Add('and cd.PurchaseLineId = pl.PurchaseLineId');
    qry.Open;
    if not qry.IsEmpty then begin
      PO:= TPurchaseOrder.create(nil);
      try
        PO.connection := ShipContainer.Connection;
        PO.SilentMode := true;

        while not qry.Eof do begin
          PO.Load(qry.FieldByName('PurchaseOrderId').AsInteger);
          s := PO.BuildBackOrderFilter;
          if s <> '' then begin
            if sFilter <> '' then
              sFilter := sFilter + ' or ' + s
            else
              sFilter := s;
          end;
          qry.Next;
        end;
      finally
        PO.Free;
      end;
    end;
  finally
    qry.Free;
  end;
  if sFilter <> '' then begin
    if CommonLib.MessageDlgXP_Vista('Do you want to view Outstanding Back Orders for the goods received on these Purchase Order(s)?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      BackOrdersList := GetComponentByClassName('TSalesBackOrderListGUI');
      If assigned(BackOrdersList) then begin
        //TSalesBackOrderListGUI(BackOrdersList).FilterString := sFilter;
        TSalesBackOrderListGUI(BackOrdersList).containerfilter := sFilter;
        TSalesBackOrderListGUI(BackOrdersList).formstyle    := fsMDIChild;
        TSalesBackOrderListGUI(BackOrdersList).bringtoFront;
      end;
    end;
  end;
end;

procedure TfrmShipContainer.SetGridColumns;
begin
//    grdDetails.RemoveField('ShippingContainerID');
//    GuiPrefs.DbGridElement[grdDetails].HideField('ShippingContainerID');
//
//    grdDetails.RemoveField('ShipContainerDetailId');
//    GuiPrefs.DbGridElement[grdDetails].HideField('ShipContainerDetailId');
//
//    grdDetails.RemoveField('Globalref');
//    GuiPrefs.DbGridElement[grdDetails].HideField('Globalref');
//
//    grdDetails.RemoveField('');
//    GuiPrefs.DbGridElement[grdDetails].HideField('');


end;

function TfrmShipContainer.GetReportTypeID: integer;
begin
  result:= GetReportTypeIDForTypeName('Shipping Container');
end;

procedure TfrmShipContainer.actApplyExecute(Sender: TObject);
var
  headerChanged:Boolean;
begin
  inherited;
  headerChanged:= ShipContainer.headerChanged;
  if SaveData then begin
    closedb(qryShipContainerDetailsforGrid);
    CommitTransaction;
    BeginTransaction;
    opendb(qryShipContainerDetailsforGrid);
  end;
  if headerChanged then
    ShipContainer.dirty := true;
end;

function TfrmShipContainer.ConfirmApply: boolean;
begin
  result:= true;
  if self.ShipContainer.Dirty then begin
    if CommonLib.MessageDlgXP_Vista('Changes must be saved first, do you want to Save them?', mtInformation, [mbYes, mbNo], 0) = mrYes then begin
      if not SaveData then
        result:= false;
    end
    else begin
      result:= false;
    end;
  end;
end;

procedure TfrmShipContainer.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if ShipContainer.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do you wish to keep these changes you have made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            self.CommitTransaction;
            CanClose:= true;
          end
          else begin
            CanClose:= false;
          end;
        end;
      mrNo:
        begin
          self.RollbackTransaction;
          CanClose:= true;
        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;
end;

function TfrmShipContainer.SavePurchaseOrder(aPO: TPurchaseOrder): boolean;
var
  POSilent: boolean;
begin
  result:= true;
  POSilent := aPO.SilentMode;
  try
    aPO.SilentMode := true;
    aPO.ResultStatus.Clear;

    if not PO.ValidateData then begin
      self.DoBusinessObjectEvent(PO, BusobjEvent_Event, BusobjEventVal_FailedPOValidateData);
      aPO.ResultStatus.Clear;
    end;

    if (not aPO.Save) then begin
      CommonLib.MessageDlgXP_Vista('Could not Save purchase order: ' +
        IntToStr(aPO.ID) + ' for ' + aPO.ClientName + ' ' +
        FormatDateTime((*'dd/mm/yy'*)FormatSettings.shortdateformat,aPO.OrderDate) + ' with message:' + #13#10 + #13#10 +
        PO.ResultStatus.Messages, mtWarning, [mbOK], 0);
      result:= false;
    end;

//     if (not aPO.Save) then begin
//      if aPO.ResultStatus.HasCode(BOR_Order_Warn_Landedcost) then begin
//            Msg := 'PO: ' + IntToStr(aPO.ID) + ' for ' + aPO.ClientName + '.' + #13#10 +
//              'You Have Allocated ' + FloatToStrF(aPO.PercentageUseImportCost, ffNumber, 15, 2) +
//              '% Of the Landed Costs, 100% should be the Maximum Allocated.' + #13#10 + #13#10 +
//              'Do you wish the Landed costs for all lines on the Purchase Order to be re-calculated to match the total Landed Cost?';
//
//           if CommonLib.MessageDlgXP_Vista(msg,  mtInformation, [mbYes, mbNo], 0) = mrYes then begin
//             aPO.ReDistributeLineLandedCost;
//             aPO.ResultStatus.Clear;
//             result := aPO.Save;
//             if result then exit;
//           end;
//      end;
//
//      CommonLib.MessageDlgXP_Vista('Could not Save purchase order: ' +
//        IntToStr(aPO.ID) + ' for ' + aPO.ClientName + ' ' +
//        FormatDateTime((*'dd/mm/yy'*)FormatSettings.shortdateformat,aPO.OrderDate) + ' with message:' + #13#10 + #13#10 +
//        PO.ResultStatus.Messages, mtWarning, [mbOK], 0);
//      result:= false;
//    end;
  finally
    aPO.SilentMode := POSilent;
  end;
end;

(*Function  TfrmShipContainer.ShipContainerDetailsforGridSQL:String;
begin
REsult := ' SELECT '+
          ' SD.*, '+
          ' POL.SaleLineID, '+
          ' SL.SaleID, '+
          ' POL.ForeignCurrencyLineCost * POL.qtySold as ForeignCurrencyLineCost, '+
          ' POL.BaseLineNo, '+
          ' SDPOL.ProductName, '+
          ' SDPOL.PurchaseLineID, '+
          ' SDPO.orderdate, '+
          ' SDPOL.LandedCostsPercentage, '+
          ' SDPOL.LandedCostsTotal, '+
          ' SDPOL.LandedCostsPerItem, '+
          ' SDPOL.UnitOfMeasureShipped as ReceivedQty, '+
          ' SDPOL.LineCostInc *SDPOL.qtysold as TotalAmountInc, '+
          ' SDPOL.BaseLineNo, '+
          ' SDPOL.class, '+
          ' SDPOL.UnitOfMeasureQtySold, '+
          ' SDPOL.Product_Description, '+
          ' SDPO.SupplierName, '+
          ' SDPOL.CustomerJob, '+
          ' SDPO.PurchaseOrderID, '+
          ' SDPOL.UnitOfMeasurePOLines, '+
          ' SDPOL.ForeignCurrencyLineCost * SDPOL.qtysold as ForeignCurrencyLIneCost, '+
          ' SDPO.ForeignExchangeCode as FXCode, '+
          ' SDPOL.QtySold, '+
          ' SDPO.InvoiceNumber , '+
          ' SDPO.InvoiceDate, '+
          ' SDPOL.QtySold*SDPOL.LandedCostsPerItem as TotalLineLandedCosts '+
          ' FROM tblshipcontainerdetails SD '+
          ' INNER JOIN tblshippingcontainer SC ON SC.ShippingContainerID = SD.ShippingContainerID '+
          ' INNER JOIN tblpurchaselines POL ON (SD.PurchaseLineID = POL.PurchaseLineID OR SD.PurchaseLineID=POL.BaseLineNo) '+
          ' LEFT JOIN tblsalesLines SL ON POL.SaleLineID= SL.SaleLineID '+
          ' Left join (tblpurchaselines SDPOL INNER JOIN tblpurchaseorders SDPO ON SDPOL.purchaseorderID = SDPO.purchaseOrderID) on SD.PurchaseLineID = SDPOL.PurchaseLineID '+
          ' WHERE SC.Active = "T" '+
          ' AND SC.ShippingContainerID =  '+ inttostr(ShipContainer.ID) +
          ' ORDER BY PurchaseOrderID';

end;*)
procedure TfrmShipContainer.qryShipContainerDetailsForGridAfterScroll(DataSet: TDataSet);begin  inherited;  synchRecords(qryShipContainerDetailsforGrid , qryShipContainerDetails   );end;

procedure TfrmShipContainer.synchRecords(Ds1, Ds2:TDataset);
begin
  inherited;
  if synching then exit;
  if not(Ds1.Active) or not(ds2.Active) then exit;
  synching := True;
  try
    Ds2.Locate('ShipContainerDetailID' , ds1.fieldbyname('ShipContainerDetailID').AsInteger , []);
  finally
    synching := False;
  end;
end;


initialization
  RegisterClassOnce(TfrmShipContainer);
  FormFact.RegisterMe(TfrmShipContainer, 'TfrmShippingContainerList_*=ShippingContainerId');
  FormFact.RegisterMe(TfrmShipContainer, 'TShippingContainerListDetailsGUI_*=ShippingContainerId');
  FormFact.RegisterMe(TfrmShipContainer, 'TSalesOrderReportGUI_ContainerName_*=ShippingContainerId');
  FormFact.RegisterMe(TfrmShipContainer, 'TSalesOrderReportGUI_ContainerETD_*=ShippingContainerId');
  FormFact.RegisterMe(TfrmShipContainer, 'TSalesOrderReportGUI_ContainerETA_*=ShippingContainerId');

end.
