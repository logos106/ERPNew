unit frmAutoReorder;
{ Date     Version Who What
 -------- -------- --- ------------------------------------------------------
 30/05/05  1.00.01 BJ  The cost plan was not considered for the generation of
                        Smart orders. The correct cost was being moved into the
                        LinePrice Field, but  not into the CostEx.
                        Here the cost according to the plan is used to get the
                        CostEx and using the costEx the, costinc is calculated.
 28/07/05  1.00.02 IJB Modified to set smart order line to Base Unit for product.
 03/08/05  1.00.03 IJB Rolled back the above changes.
 19/10/05  1.00.04 DLS  Added RegisterClass
 26/04/06  1.00.05  AL  Changed ReorderPoint to PreferredLevel in btnStartClick
 }



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,   StdCtrls, wwdblook, Buttons, DNMSpeedButton,
  ExtCtrls, ComCtrls,AdvOfficeStatusBar, Mask, wwdbedit, Wwdotdot, Wwdbcomb, SelectionDialog,
  DNMPanel, DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, Shader, busobjbase,
  ImgList, ProgressDialog, wwDbGrid, BusObjProductForecast, AdvSpin , Integerlistobj;

type
  TAutoReorderGUI = class(TBaseInputGUI)
    qryClass: TERPQuery;
    qrySupplier: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    btnProductForecastFormula: TDNMSpeedButton;
    btnStart: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    btnReorderLevels: TDNMSpeedButton;
    btnHowTo: TDNMSpeedButton;
    lblMsg: TLabel;
    mnuOptBaseson: TPopupMenu;
    OpenList1: TMenuItem;
    DNMPanel2: TDNMPanel;
    DNMPanel4: TDNMPanel;
    chkShowOrder: TCheckBox;
    OptBaseson: TRadioGroup;
    DNMPanel5: TDNMPanel;
    Label3: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    cboClass: TwwDBLookupCombo;
    cboSupplier: TwwDBLookupCombo;
    chkAllClasses: TCheckBox;
    ChkALLSupp: TCheckBox;
    DNMPanel7: TDNMPanel;
    Label6: TLabel;
    chkCreateInternalSO: TCheckBox;
    Label4: TLabel;
    Shape1: TShape;
    Shape6: TShape;
    Label1: TLabel;
    chkallProducts: TCheckBox;
    btnProdList: TDNMSpeedButton;
    chkCreateSmartOrder: TCheckBox;
    edtNoinSalesOrder: TAdvSpinEdit;
    edtNoinSmartorder: TAdvSpinEdit;
    Shape2: TShape;
    lblInProgress: TLabel;
    lblwarningSOProducts: TLabel;
    Shape3: TShape;
    lblNoOfProducts: TLabel;
    Shape4: TShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ChkALLSuppClick(Sender: TObject);
    procedure chkAllClassesClick(Sender: TObject);
    procedure btnProductForecastFormulaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkallProductsClick(Sender: TObject);
    procedure btnProdListClick(Sender: TObject);
    procedure btnReorderLevelsClick(Sender: TObject);
    procedure btnHowToClick(Sender: TObject);
    procedure OptBasesonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OpenList1Click(Sender: TObject);
    procedure edtNoinSalesOrderChange(Sender: TObject);
  private

    TempTableName: string;
    SmartOrderIds:TIntegerList;
    SalesOrderIds:TIntegerList;
    procedure CreateTempTable;
    Procedure CreateSmartOrder;
    procedure ProductGridDataSelect(Sender: TwwDbGrid);
    procedure DoOnProductListShow(Sender: TObject);
    procedure explain;
    procedure intProductForecast(Sender: TObject);
    Procedure MakeQryParts(QryParts:TERPQuery);
    procedure initAutoReorderQtyList(Sender: TObject);
    procedure ReadnApplyGuiPref;
    Procedure WriteGuiPref;
    procedure MakeSmartOrder(QryPArts: TERPQuery);
    function NoinSmartorder: Integer;
    function NoinSalesOrder: Integer;
    function OrderDesc: String;
    procedure MakeSalesOrder(QryPArts: TERPQuery);
    procedure ShowInProgress( lblvisible:Boolean ; const lblCaption :String = '');
    procedure ShowOrdersCreated;
    function WorkshopCustomerId: Integer;
    procedure initOrderslist(Sender: TObject);
    function SelectedProductIDs: String;
    procedure setProductIDs(const Value: String);
    procedure initReorderLevels(Sender: TObject);
    Property ProductIDs :String read SelectedProductIDs write setProductIDs;

  protected
    procedure ProductSelectedInForecast(Sender : TObject);
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  frmSmartOrderFrm, DNMExceptions,
  CommonDbLib, CommonLib, tcDataUtils,
  AppEnvironment, FastFuncs, DateTimeUtils, DateUtils,
  BusObjSmartOrder, BusObjStock, ProductQtyLib,  TempTableUtils,
  CommonFormLib, BaseListingForm, PQALib, frmProductForecast, DocReaderObj,
  tcConst, DbSharedObjectsObj, LogLib, ReorderLib, AutoReorderQtyList,
  BusObjClient, BusObjSales, MainformLib, SmartOrderListForm,
  SalesorderListExpress, SalesConst, frmReorderLevels;

procedure TAutoReorderGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TAutoReorderGUI.FormCreate(Sender: TObject);
begin
  TempTableName := GetUserTemporaryTableName('SelectedProducts');
  CreateTempTable;
  inherited;
  showControlhint(OptBaseson,
    '1: Instock Qty = Purchase - (Sales +Allocated BO +Allocated SO)+On Order ' + NL+
    '2: Available Qty = Purchase - (Sales +Allocated BO +Allocated SO+ On Build Qty)+ Building Qty +On Order(POBO) ' + NL+
    '3: Available Qty - SOBO = Purchase - (Sales +Allocated BO +Allocated SO+ On Build Qty)- SOBO  ' + NL+
    '4: Include SOBO = Purchase - (Sales +Allocated BO +Allocated SO+ On Build Qty + Allocated SO BO )+ Building Qty+On Order '+NL+
    '5: Available Qty + Internal SO = Purchase - (Sales +Allocated BO +Allocated SO+ On Build Qty)+ Internal SO  '+NL+
    NL+'Right-Click to View List to be Ordered as Per Selection'+NL);
end;

procedure TAutoReorderGUI.FormDestroy(Sender: TObject);
begin
  commondblib.DestroyUserTemporaryTable(TempTableName);
  inherited;
end;

procedure TAutoReorderGUI.btnStartClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    Processingcursor(True);
    try
        CreateSmartOrder;
        Self.close;
    finally
      Processingcursor(False);
    end;
  finally
    EnableForm;
  end;
end;

procedure TAutoReorderGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      if AccessLevel <> 1 then AccessLevel := 6;
      inherited;
      OpenQueries;
      qryClass.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive, loPartialKey]);
      cboClass.LookupValue := qryClass.FieldByName('ClassName').AsString;
      explain;
      ReadnApplyGuiPref;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;  

procedure TAutoReorderGUI.OpenList1Click(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TAutoReorderQtyListGUI' , nil , initAutoReorderQtyList);
end;
procedure TAutoReorderGUI.initAutoReorderQtyList(Sender: TObject);
begin
  if not (Sender is TAutoReorderQtyListGUI) then exit;
  TAutoReorderQtyListGUI(Sender).TempTablename    := iif(not(chkallProducts.checked) , TempTablename , '') ;
  TAutoReorderQtyListGUI(Sender).classId          := iif(chkAllClasses.Checked ,0 , qryClass.FieldByName('ClassID').AsInteger);
  TAutoReorderQtyListGUI(Sender).PreferredSupp    := iif(ChkALLSupp.Checked  , '' , qrySupplier.FieldByName('Company').AsString);
  TAutoReorderQtyListGUI(Sender).SearchMode       := smFullList;
  TAutoReorderQtyListGUI(Sender).BasesonitemIndex := OptBaseson.itemindex;
end;
procedure TAutoReorderGUI.OptBasesonClick(Sender: TObject);
begin
  inherited;
  explain;
end;

procedure TAutoReorderGUI.edtNoinSalesOrderChange(Sender: TObject);
begin
  inherited;
  if NoinSalesOrder <=20 then lblwarningSOProducts.visible := False
  else lblwarningSOProducts.visible := TRue;
  lblNoOfProducts.visible := not (lblwarningSOProducts.visible);
  //timerMsg(lblwarningSOProducts , lblwarningSOProducts.caption , 30);
end;

procedure TAutoReorderGUI.explain;
var
  s: string;
begin
//  lblMsg.caption := 'Selecting ''Start'' will Create Smart Order /Internal Sales Order for Products in the '+ NL +
//                    'Selection which has the ' +quotedstr(iif(OptBaseson.itemindex =0  , 'In-Stock Qty' , iif(OptBaseson.itemindex =1  , 'Available Qty' , iif(OptBaseson.itemindex =2  , 'Available Qty - SOBO Qty' , 'In-Stock Qty + Internal SOBO Qty'))))  +
//                    ' < It''s ''Preferred Level Qty''';
  s :=
    'Selecting ''Start'' will Create Smart Order /Internal Sales Order for Products in the '+ NL +
    'Selection which has the ';
  case OptBaseson.ItemIndex of
    0: s := s + 'In-Stock Qty';
    1: s := s + 'Available Qty';
    2: s := s + 'Available Qty - SOBO Qty';
    3: s := s + 'In-Stock Qty + Internal SOBO Qty';
    4: s := s + 'Available Qty + Internal SO Qty';
  end;
  s := s + ' < It''s ''Preferred Level Qty''';
  lblMsg.caption := s;
end;


procedure TAutoReorderGUI.ProductSelectedInForecast(Sender: TObject);
begin
  chkallProducts.checked := True;
end;

procedure TAutoReorderGUI.btnCloseClick(Sender: TObject);
begin
  Self.close;
end;


procedure TAutoReorderGUI.ChkALLSuppClick     (Sender: TObject);begin  inherited;  cboSupplier.Enabled := not(ChkALLSupp.Checked)     ;end;
procedure TAutoReorderGUI.chkAllClassesClick  (Sender: TObject);begin  inherited;  cboClass.Enabled    := not(chkAllClasses.Checked)  ;end;
procedure TAutoReorderGUI.chkallProductsClick (Sender: TObject);begin  inherited;  btnProdList.Enabled := not(chkallProducts.checked) ;end;

procedure TAutoReorderGUI.btnHowToClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Auto Reorder');
end;

procedure TAutoReorderGUI.btnProdListClick(Sender: TObject);
begin
  inherited;
  CommonFormLib.OpenERPListFormultiselectModal('TProductListExpressGUI',DoOnProductListShow , ProductGridDataSelect);
end;
procedure TAutoReorderGUI.DoOnProductListShow(Sender: TObject);
begin
  TBaseListingGUI(Sender).FilterString := 'PARTTYPE = "INV" and Discontinued = "F" and Active = "T"';
  TBaseListingGUI(Sender).SearchMode := smFullList;
  TBaseListingGUI(Sender).Selectrecordsfieldname := 'PartsId';
  TBaseListingGUI(Sender).SelectrecordsValues := ProductIDs;
end;
procedure TAutoReorderGUI.ProductGridDataSelect(Sender: TwwDbGrid);
begin
  ProductIds := SelectedIDs(Sender , 'PartsId');
end;
procedure TAutoReorderGUI.btnProductForecastFormulaClick(Sender: TObject);
begin
  OpenERPFormModal('TProductForecastGUI' , 0 , intProductForecast)
end;
procedure TAutoReorderGUI.intProductForecast(Sender: TObject);
begin
  if sender is TProductForecastGUI then begin
    //CreateTempTable;
    if TProductForecastGUI(Sender).TempTableName = '' then TProductForecastGUI(Sender).TempTableName := TempTableName;
    TProductForecastGUI(Sender).OnSelectProduct := ProductSelectedInForecast;
    TProductForecastGUI(Sender).AutoReorder := true;
    if not chkAllClasses.Checked then TProductForecastGUI(Sender).InitProduct(0, qryClass.FieldByName('ClassId').AsInteger, true);
  end;
end;

procedure TAutoReorderGUI.MakeQryParts(QryParts: TERPQuery);
begin
  ReorderLib.MakeQryParts( QryParts ,
                iif(not(chkallProducts.checked) , TempTablename , '') ,
                OptBaseson.itemIndex ,
                iif(chkAllClasses.Checked ,0 , qryClass.FieldByName('ClassID').AsInteger),
                iif(ChkALLSupp.Checked  , '' , qrySupplier.FieldByName('Company').AsString));
  QryParts.sql.Text := replacestr(QryParts.sql.Text  , ' as Qty1' , ' as InstockQty');
  QryParts.sql.Text := replacestr(QryParts.sql.Text  , ' as Qty2' , ' as InstockQty');
  QryParts.sql.Text := replacestr(QryParts.sql.Text  , ' as Qty3' , ' as InstockQty');
  QryParts.sql.Text := replacestr(QryParts.sql.Text  , ' as Qty4' , ' as InstockQty');
  QryParts.sql.Text := replacestr(QryParts.sql.Text  , ' as Qty5' , ' as InstockQty');
  qryParts.sQl.add(' Having ifnull(InstockQty,0)< if(ifnull(reorderpoint,0)>ifnull(PreferredLevel,0) , reorderpoint , PreferredLevel)');
  qryParts.sQl.add(' Order by classId, ProductId ' );
end;

procedure TAutoReorderGUI.btnReorderLevelsClick(Sender: TObject);
begin
  OpenERPListForm('TfmReorderLevels' , initReorderLevels);
  Self.close;
end;
Procedure TAutoReorderGUI.initReorderLevels(Sender :TObject);
begin
   if sender is TfmReorderLevels then begin
     TfmReorderLevels(Sender).productIds := ProductIDs ;
   end;
end;
Function TAutoReorderGUI.NoinSmartorder:Integer; begin result := edtNoinSmartorder.value;end;
Function TAutoReorderGUI.NoinSalesOrder:Integer; begin result := edtNoinSalesOrder.value;end;
Function TAutoReorderGUI.OrderDesc :String;
begin
          Result := 'Auto Re-Order';
               if OptBaseson.itemIndex =0 then Result :=  REsult +'( Based on Instock + On order Qty)'
          else if OptBaseson.itemIndex =1 then Result :=  REsult +'( Based on Available + On order Qty)'
          else if OptBaseson.itemIndex =2 then Result :=  REsult +'( Based on Available - SOBO + On order Qty)'
          else if OptBaseson.itemIndex =3 then Result :=  REsult +'( Based on Instock + Internal SO BO )'
          else if OptBaseson.itemIndex =4 then Result :=  REsult +'( Based on Available + Internal SO )';
          Result :=  Result +' on :' + FormatdateTime(FormatSettings.shortdateformat + ' HH:NN AM/PM' , now);
end;
function TAutoReorderGUI.WorkshopCustomerId:Integer;
var
  Client : TClient;
begin

  Client := TClient.CreateWithNewConn(Self);
  try
    Client.loadselect('company = "Workshop"');
    Client.connection.beginTransaction;
    try
      if Client.count =0 then begin
        Client.New;
        Client.firstname :='Workshop';
        Client.clientname :='Workshop';
        Client.Postdb;
      end;
      if Client.IsCustomer =False then begin
        Client.IsCustomer := True;
        Client.PostDB;
      end;
      Client.connection.CommitTransaction;
    Except
      on E:Exception do begin
        Client.connection.RollbackTransaction;
      end;
    end;
    result := Client.ID;
  finally
    Freeandnil(Client);
  end;
end;

Procedure TAutoReorderGUI.MakeSalesOrder(QryPArts:TERPQuery);
var
  fiWorkshopCustomerId:Integer;

  LinesProcessed :Integer;
  SalesOrder:TSalesOrder;
  ReorderAmount :Double;
  RequiredQty :Double;
  PreferredLevel,ReorderPoint : Double;
  fbManufacturePartSourceStock:boolean;
  fbEnforceAllocationValidation:boolean;
  Function  SaveSalesOrder:Boolean;
  begin
    if (SalesOrder <> nil)  and (SalesOrder.Lines.count >0) then begin
      if not SalesOrder.save then begin
        REsult := False;
        Exit;
      end;
      SalesOrder.connection.commitnestedTransaction;
      SalesOrderIds.Add(SalesOrder.ID);
      FreeandNil(SalesOrder);
      REsult := True;
    end else if (SalesOrder <> nil)   and (SalesOrder.Lines.count =0)  then begin
      SalesOrder.connection.RollbacknestedTransaction;
      REsult := true;
    end else begin
      Result := True;
    end;
  end;
  Function  NewSalesOrder:Boolean;
  begin
    result :=SaveSalesOrder;
    if not result then exit;
    SalesOrder := TSalesOrder.Create(Self);
    SalesOrder.connection := TMyDacDataconnection.Create(SalesOrder);
    SalesOrder.connection.connection := MyConnection;
    SalesOrder.connection.BeginnestedTransaction;
    SalesOrder.silentMode:=  True;
    SalesOrder.Load(0);
    SalesOrder.New;
    SalesOrder.customerId := fiWorkshopCustomerId;
    SalesOrder.SaleDate := date;
    SalesOrder.comments := OrderDesc;
    SalesOrder.SaleClassId  := qryParts.FieldByName('ClassID').AsInteger;
    SalesOrder.IsInternalOrder := True;

    SalesOrder.PostDB;
    LinesProcessed := 0;
  end;
begin

  if chkCreateInternalSO.checked = false then exit;

  SalesOrder := nil;
  try
      QryParts.Filter := 'IsBOM =' +Quotedstr('T');
      QryParts.Filtered := True;
      if QryParts.recordcount =0 then Exit;

      fiWorkshopCustomerId:= WorkshopCustomerId;

      fbManufacturePartSourceStock := AppEnv.CompanyPrefs.ManufacturePartSourceStock;
      fbEnforceAllocationValidation := AppEnv.CompanyPrefs.EnforceAllocationValidation;

      AppEnv.CompanyPrefs.ManufacturePartSourceStock := True;
      AppEnv.CompanyPrefs.EnforceAllocationValidation := False;
      try

          if QryParts.recordcount >0 then begin
            QryParts.First;

            NewSalesOrder;
            While (QryParts.eof = False)  do begin
              doStepProgressbar;
              if ((*(chklimitrecordinSalesOrder.checked) and *) (NoinSalesOrder >0) and  (LinesProcessed >=NoinSalesOrder)) or
              ((SalesOrder <> nil) and (SalesOrder.SaleClassId  <>qryParts.FieldByName('ClassID').AsInteger) ) then begin
                if not NewSalesOrder then exit;
              end;
              ReorderAmount  := qryParts.FieldByName('ReorderAmount').AsFloat;
              PreferredLevel := qryParts.FieldByName('PreferredLevel').AsFloat;
              ReorderPoint   := qryParts.FieldByName('ReorderPoint').asFloat;
              if ((ReorderPoint >= qryParts.FieldByName('InstockQty').asFloat) or (qryParts.FieldByName('InstockQty').asFloat = 0)) then begin

                RequiredQty  := PreferredLevel - qryParts.FieldByName('InstockQty').AsFloat;
                if RequiredQty < 0 then RequiredQty := 0;
                if (ReorderAmount <> 0) and (RequiredQty > 0) then begin  // Create lines only if we are to order    -- we are here if userHasSelectedProducts, but ReorderPoint < Instockqty
                    if RequiredQty < ReorderAmount then RequiredQty := ReorderAmount
                    else if trunc(RequiredQty/ ReorderAmount) = RequiredQty/ ReorderAmount then
                    else RequiredQty            := (trunc(RequiredQty/ ReorderAmount)+1)* ReorderAmount;

                  SalesOrder.Lines.New;
                  SalesOrder.Lines.ProductId      := qryParts.FieldByName('ProductID').AsInteger;
                  SalesOrder.Lines.Qtysold        := RequiredQty;
                  SalesOrder.Lines.Qtyshipped     := RequiredQty;
                  //SalesOrder.Lines.DoContainerEvent(SalesOrder.Lines, evSalesLinePartsourceChange); // to force repopulating the tree
                  SalesOrder.Lines.PostDB;
                  LinesProcessed := LinesProcessed +1;
                end;
              end;
              QryParts.next;
            end;

            if not SaveSalesOrder then exit;

          end;
      finally
        AppEnv.CompanyPrefs.ManufacturePartSourceStock := fbManufacturePartSourceStock;
        AppEnv.CompanyPrefs.EnforceAllocationValidation := fbEnforceAllocationValidation;
      end;
  finally
    Freeandnil(SalesOrder);
  end;
end;

Procedure TAutoReorderGUI.MakeSmartOrder(QryPArts:TERPQuery);
var
  LinesProcessed :Integer;
  smartOrder:TSmartOrder;
  ReorderAmount :Double;
  RequiredQty :Double;
  PreferredLevel,ReorderPoint : Double;

  Function  SaveSmartOrder:Boolean;
  begin
    if (SmartOrder <> nil)  and (SmartOrder.Lines.count >0) then begin
      if not SmartOrder.save then begin
        REsult := False;
        Exit;
      end;
      SmartOrder.connection.commitnestedTransaction;
      SmartOrderIds.Add(SmartOrder.ID);
      FreeandNil(SmartOrder);
      Result := True;
    end else if (SmartOrder <> nil)   and (SmartOrder.Lines.count =0)  then begin
      SmartOrder.connection.RollbacknestedTransaction;
      REsult := true;
    end else begin
      Result := True;
    end;
  end;

  Function  NewSmartOrder:Boolean;
  begin
    result :=SaveSmartOrder;
    if not result then exit;
    SmartOrder := TSmartOrder.Create(Self);
    SmartOrder.connection := TMyDacDataconnection.Create(SmartOrder);
    SmartOrder.connection.connection := MyConnection;
    SmartOrder.connection.BeginnestedTransaction;
    SmartOrder.silentMode:=  True;
    SmartOrder.Load(0);
    SmartOrder.New;
    SmartOrder.SmartOrderDesc := OrderDesc;
    SmartOrder.PostDB;
    LinesProcessed := 0;
  end;

begin
      if chkCreateSmartOrder.checked = false then exit;

      SmartOrder:= nil;
      try
          if chkCreateInternalSO.checked then begin
             QryParts.Filter := 'IsBOM =' +Quotedstr('F');
             QryParts.Filtered := True;
          end;

          if QryParts.recordcount >0 then begin
            QryParts.First;

            NewSmartOrder;
            While (QryParts.eof = False)  do begin
              doStepProgressbar;
              if (*(chklimitrecordinSmartOrder.checked) and  *)(NoinSmartorder >0) and  (LinesProcessed >=NoinSmartorder) then begin
                if not NewSmartOrder then exit;
              end;
              ReorderAmount  := qryParts.FieldByName('ReorderAmount').AsFloat;
              PreferredLevel := qryParts.FieldByName('PreferredLevel').AsFloat;
              ReorderPoint   := qryParts.FieldByName('ReorderPoint').asFloat;
              if ((ReorderPoint >= qryParts.FieldByName('InstockQty').asFloat) or (qryParts.FieldByName('InstockQty').asFloat = 0)) then begin

                RequiredQty  := PreferredLevel - qryParts.FieldByName('InstockQty').AsFloat;
                if RequiredQty < 0 then RequiredQty := 0;
                if (ReorderAmount <> 0) and (RequiredQty > 0) then begin  // Create lines only if we are to order    -- we are here if userHasSelectedProducts, but ReorderPoint < Instockqty
                    if RequiredQty < ReorderAmount then RequiredQty := ReorderAmount
                    else if trunc(RequiredQty/ ReorderAmount) = RequiredQty/ ReorderAmount then
                    else RequiredQty            := (trunc(RequiredQty/ ReorderAmount)+1)* ReorderAmount;

                  SmartOrder.Lines.New;
                  SmartOrder.Lines.PARTSID        := qryParts.FieldByName('ProductID').AsInteger;
                  SmartOrder.Lines.SupplierName   := qryParts.FieldByName('PREFEREDSUPP').AsString;
                  SmartOrder.Lines.ClassId        := qryParts.FieldByName('ClassID').AsInteger;
                  SmartOrder.Lines.ToPurchaseQtyexWastagePercentage:= RequiredQty;
                  SmartOrder.Lines.PostDB;
                  LinesProcessed := LinesProcessed +1;
                end;
              end;
              QryParts.next;
            end;

            if not SaveSmartOrder then exit;

          end;
      finally
        Freeandnil(SmartOrder);
      end;
end;

Procedure TAutoReorderGUI.ShowInProgress( lblvisible:Boolean ; const lblCaption :String = '');
begin
   lblInProgress.caption :=  lblCaption;
   lblInProgress.visible :=  lblvisible;
end;
Procedure TAutoReorderGUI.ShowOrdersCreated;
var
  ctr:Integer;
  msgOption :Word;
  Function OrdersDetails:String;
  begin
     if SmartOrderIds.count > 0 then result := inttostr(SmartOrderIds.count) +' Smart Order(s)';
     if SalesOrderIds.count > 0 then result := result + NL +inttostr(SalesOrderIds.count) +' Sales Order(s)';
     result := trim(Result);
     result := replacestr(result , NL  , ' and ' );
  end;
begin
  ShowInProgress(true);
  try
    if chkShowOrder.checked then begin
      msgOption := MessageDlgXP_Vista('You have selected to View the Order.' + NL + 'There are ' + OrdersDetails +' Created.' + NL + NL+'Continue Viewing Orders Or Open List of Orders Created?', mtConfirmation, [mbCancel], 0  , nil , '' , '', False , nil , 'View Orders,List of Orders');
      if msgOption = mrCancel then exit;
      if msgOption = 100 then begin
        if SmartOrderIds.count >0 then begin
          for ctr:= 0 to SmartOrderIds.count-1 do begin
            ShowInProgress(True, 'Smart Order # ' + inttostr(SmartOrderIds[ctr] )+' ( ' + inttostr(ctr+1)+' of ' + inttostr(SmartOrderIds.Count )+')')  ;
            MainformMsg('Smart Order # ' + inttostr(SmartOrderIds[ctr] )+' ( ' + inttostr(ctr+1)+' of ' + inttostr(SmartOrderIds.Count )+')');
            OpenERPFormModal('TSmartOrderGUI' , SmartOrderIds[ctr] );
          end;
        end;

        if SalesOrderIds.count >0 then begin
          for ctr:= 0 to SalesOrderIds.count-1 do begin
            ShowInProgress(True, 'Sales Order # ' + inttostr(SalesOrderIds[ctr] )+' ( ' + inttostr(ctr+1)+' of ' + inttostr(SalesOrderIds.Count )+')')  ;
            MainformMsg('Sales Order # ' + inttostr(SalesOrderIds[ctr] )+' ( ' + inttostr(ctr+1)+' of ' + inttostr(SalesOrderIds.Count )+')');
            OpenERPFormModal('TSalesOrderGUI' , SalesOrderIds[ctr] );
          end;
        end;
      end else if msgOption = 101 then begin
          if SmartOrderIds.count >0 then begin
            OpenERPListForm('TSmartOrderListGUI' , initOrderslist, nil , False);
          end;
          if SalesOrderIds.count >0 then begin
            OpenERPListForm('TSalesorderListExpressGUI' , initOrderslist, nil , False);
          end;
      end;
    end;
  finally
    ShowInProgress(False);
  end;
end;

Procedure TAutoReorderGUI.initOrderslist(Sender: TObject);
begin
  if sender is  TSmartOrderListGUI then begin
    TSmartOrderListGUI(Sender).FilterString := 'SmartOrderID =' + replacestr(SmartOrderIds.CommaText , ',' , ' or SmartOrderID =');
    TSmartOrderListGUI(Sender).chkignoredates.Checked := True;
    TSmartOrderListGUI(Sender).ListTimerMsg('List of Smart Orders Created from Auto Rorder' , nil , 20);
    TSmartOrderListGUI(Sender).searchmode := smFulllist;
    TSmartOrderListGUI(Sender).Left := TSmartOrderListGUI(Sender).left - 10;
  end else if sender is  TSalesorderListExpressGUI then begin
    TSalesorderListExpressGUI(Sender).FilterString := 'SaleId =' + replacestr(SalesOrderIds.CommaText , ',' , ' or SaleId =');
    TSalesorderListExpressGUI(Sender).chkignoredates.Checked := True;
    TSalesorderListExpressGUI(Sender).ListTimerMsg('List of Sales Orders Created from Auto Rorder', nil , 20);
    TSalesorderListExpressGUI(Sender).searchmode := smFulllist;
    TSmartOrderListGUI(Sender).Left := TSmartOrderListGUI(Sender).left + 10;
  end;
end;

Procedure TAutoReorderGUI.CreateSmartOrder;
var
  qryParts: TERPQuery;
begin
    qryParts := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      doShowProgressbar(4 , WAITMSG);
      try
        MakeQryParts(QryParts);        doStepProgressbar;
        qryParts.Open;        doStepProgressbar;
      finally
        dohideProgressbar;
      end;

      if QryParts.Recordcount = 0 then begin
        MessageDlgXP_Vista('No Product for the Selection Require reorder', mtInformation, [mbOK], 0);
        Exit;
      end;
      Myconnection.StartTransaction;
      try
        doShowProgressbar(QryParts.recordcount+2 , WAITMSG);
        try
          SmartOrderIds:= TIntegerList.Create;
          SalesOrderIds:= TIntegerList.Create;
          try
            MakeSmartOrder(QryParts);
            MakeSalesOrder(QryParts);
            if (SmartOrderIds.Count >0) or (SalesOrderIds.Count >0) then begin
              Myconnection.Commit;
              showOrdersCreated;
            end;
          finally
            FreeandNil(SmartOrderIds);
            FreeandNil(SalesOrderIds);
          end;
        finally
          dohideProgressbar;
        end;
      Except
        on E:Exception do begin
          if Myconnection.intransaction then Myconnection.Rollback;
        end;
      end;
    finally
      DbSharedObj.ReleaseObj(Qryparts);
    end;
end;

procedure TAutoReorderGUI.CreateTempTable;
begin
  if TempTableName = '' then exit;
  ExecuteSQL('Drop table if exists ' + TempTableName+';'+
            ' Create Table ' + TempTableName + ' (PartsId int(11), Done ENUM("T","F") DEFAULT "F",'+
            ' unique key Part(PartsId)) ENGINE=MyISAM;');
end;

procedure TAutoReorderGUI.ReadnApplyGuiPref;
begin
  if not GuiPrefs.active then GuiPrefs.active := True;

  if GuiPrefs.Node.Exists('Options.ClassId')        then if qryClass.Locate   ('classid'  , GuiPrefs.Node['Options.classId'].asInteger , []) then cboClass.Text    := qryClass.FieldByName   ('ClassName').AsString;
  if GuiPrefs.Node.Exists('Options.ClientID')       then if qrySupplier.Locate('ClientID' , GuiPrefs.Node['Options.ClientID'].asInteger, []) then cboSupplier.Text := qrySupplier.FieldByName('company').AsString;
  if GuiPrefs.Node.Exists('Options.AllClasses')     then chkAllClasses.Checked  :=  GuiPrefs.Node['Options.AllClasses'].asBoolean;
  if GuiPrefs.Node.Exists('Options.ALLSupp')        then chkALLSupp.Checked     :=  GuiPrefs.Node['Options.ALLSupp'].asBoolean;
  ProductIDs :=GuiPrefs.Node['Options.ProductIDs'].asString;
  if GuiPrefs.Node['Options.ProductIDs'].asString ='' then chkAllProducts.Checked :=  True
  else if GuiPrefs.Node.Exists('Options.AllProducts')    then chkAllProducts.Checked :=  GuiPrefs.Node['Options.AllProducts'].asBoolean
  else chkAllProducts.Checked :=  True;
  if GuiPrefs.Node.Exists('Options.Baseson')        then OptBaseson.ItemIndex   :=  GuiPrefs.Node['Options.Baseson'].asInteger;
  if GuiPrefs.Node.Exists('Options.NoinSalesOrder') then edtNoinSalesOrder.Value:=  GuiPrefs.Node['Options.NoinSalesOrder'].asInteger;
  if GuiPrefs.Node.Exists('Options.NoinSmartOrder') then edtNoinSmartOrder.Value:=  GuiPrefs.Node['Options.NoinSmartOrder'].asInteger;
  //if GuiPrefs.Node.Exists('Options.limitrecordinSalesOrder') then chklimitrecordinSalesOrder.Checked  := GuiPrefs.Node['Options.limitrecordinSalesOrder'].asBoolean;
  //if GuiPrefs.Node.Exists('Options.limitrecordinSmartOrder') then chklimitrecordinSmartOrder.Checked  := GuiPrefs.Node['Options.limitrecordinSmartOrder'].asBoolean;
  if GuiPrefs.Node.Exists('Options.CreateInternalSO')        then chkCreateInternalSO.Checked  := GuiPrefs.Node['Options.CreateInternalSO'].asBoolean;
  if GuiPrefs.Node.Exists('Options.CreateSmartOrder')        then chkCreateSmartOrder.Checked  := GuiPrefs.Node['Options.CreateSmartOrder'].asBoolean;


  lblwarningSOProducts.caption := '>20 Products in the BOM Sales Order is not Reccomented.' +NL+'It can Cause ''Out of Memory'''+NL;
  lblNoOfProducts.Caption := 'Define the Maximum Number of Products in Each Transaction. This is to Avoid Loading Too Many Products into a Transaction Which can Cause ''Out of Memory''';
  lblwarningSOProducts.width := 175;
  lblNoOfProducts.Width :=175;
  lblwarningSOProducts.REfresh;
  lblNoOfProducts.REfresh;
end;

procedure TAutoReorderGUI.WriteGuiPref;
begin
 GuiPrefs.Node['Options.classId'].asInteger     := qryClass.FieldByName   ('ClassID').AsInteger;
 GuiPrefs.Node['Options.ClientID'].asInteger    := qrySupplier.FieldByName('ClientID').AsInteger;
 GuiPrefs.Node['Options.AllClasses'].asBoolean  := chkAllClasses.Checked;
 GuiPrefs.Node['Options.ALLSupp'].asBoolean     := chkALLSupp.Checked;
 GuiPrefs.Node['Options.AllProducts'].asBoolean := chkAllProducts.Checked;
 GuiPrefs.Node['Options.Baseson'].asInteger     := OptBaseson.ItemIndex;
 GuiPrefs.Node['Options.NoinSalesOrder'].asInteger := edtNoinSalesOrder.Value;
 GuiPrefs.Node['Options.NoinSmartOrder'].asInteger := edtNoinSmartOrder.Value;
 //GuiPrefs.Node['Options.limitrecordinSalesOrder'].asBoolean := chklimitrecordinSalesOrder.Checked;
 //GuiPrefs.Node['Options.limitrecordinSmartOrder'].asBoolean := chklimitrecordinSmartOrder.Checked;
 GuiPrefs.Node['Options.CreateInternalSO'].asBoolean        := chkCreateInternalSO.Checked;
 GuiPrefs.Node['Options.CreateSmartOrder'].asBoolean        := chkCreateSmartOrder.Checked;
 GuiPrefs.Node['Options.ProductIDs'].asString := ProductIDs;
 fbIsLocalPrefChanged := True;
end;

function TAutoReorderGUI.SelectedProductIDs: String;
begin
  result := '';
  if chkallProducts.checked  then exit;
  Result := allIds('Select * from ' + TempTableName  , 'PartsID');
end;

procedure TAutoReorderGUI.setProductIDs(const Value: String);
var
    scr :TERPScript;
begin

    scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
    try
      scr.SQL.Clear;
      scr.SQL.add( 'truncate ' + TempTableName +' ;');
      if Value <> '' then scr.SQL.add( 'insert ignore into ' + TempTableName +' (PartsId) Select PartsId from tblparts where PartsId in (' + Value +')');
      scr.Execute;
    finally
      DbSharedObj.ReleaseObj(scr);
    end;
end;

initialization
  RegisterClassOnce(TAutoReorderGUI);
end.
