unit ProcessPartsFormExtender;

interface

uses
  BaseInputFormExtender, Classes, ComCtrls,AdvOfficeStatusBar, BusObjStock, DB,
  TreeFrame, DNMSpeedButton, SysUtils, Forms, BusObjProcess, ProgressDialog;

type

  TProcessPartsFormExtender = class(TBaseInputFormExtender)
  private
    fProductDataSet: TDataSet;
    function GetProductDataSet: TDataSet;
    function SaveAndUpdateCosts: boolean;
    Procedure AuditTrialTree;
    procedure RecalculatecostnPrice;
  private
    PageControl: TPageControl;
    Button: TDNMSpeedButton;
    fProduct: TProduct;
    SavedOnChangeHandler: TNotifyEvent;
    SavedSaveOnClickHandler: TNotifyEvent;
    SavedNewOnClickHandler: TNotifyEvent;
    SavedOnResizeHandler: TNotifyEvent;
    SavedCopyOnClickHandler: TNotifyEvent;
    SavedPartnameOnEnter :TNotifyEvent;
    SavedPartnameOnExit :TNotifyEvent;
    SavedPrintnameOnEnter :TNotifyEvent;
    SavedPrintnameOnExit :TNotifyEvent;
    SavedSaleDescOnExit: TNotifyEvent;
    SavedAfterCommit: TNotifyEvent;


    SavedOnChangingHandler:TTabChangingEvent;
    fTreeFrame: TframeTree;
    DialogVerifyChecked: boolean;
    ProductPrice1, Productcost1 :Double;
    CleanProductName:String;
    CleanPrintName:String;
    DoingSaveAndUpdateCosts: boolean;
    CleanAllInfo, CleanSelectedInfo:String;
    CleanTreeEditVersion: integer;
    Dialog: TProgressDialog;
    procedure DoPageControlOnChange(Sender: TObject);
    procedure DoPageControlOnChanging(Sender: TObject;var AllowChange: Boolean);
    procedure DoSaveOnClick(Sender: TObject);
    procedure DoNewOnClick(Sender: TObject);
    procedure DoPageControlOnResize(Sender: TObject);
    function GetProduct: TProduct;
    procedure DoCopyOnClick(Sender: TObject);
    procedure DoPartnameOnEnter(Sender: TObject);
    procedure DoPartnameOnExit(Sender: TObject);
    procedure DoPrintnameOnEnter(Sender: TObject);
    procedure DoPrintnameOnExit(Sender: TObject);
    procedure DoSaleDescOnExit(Sender: TObject);
    procedure DoAfterCommit(Sender: TObject);

    procedure InitVisualTree;
    function GetProcTree: TProcTreeNode;
    function CheckTree: boolean;
    procedure RecalculateMargins;
    procedure CalcBOMCostnPrice(Sender: TObject);
    procedure UpdateProductDescriptionFromTreeInfo;
    procedure AutoAllocateProcessForTreeRoot;
    (* procedure OnDialogVerifyClick(Sender: TObject; Checked: boolean); *)
    property ProductDataSet: TDataSet read GetProductDataSet;

    Procedure ShowPricecostCalcHint(const Msg:String);
    procedure DoOnAfterSaveProduct(Sender: TObject);
    Procedure DoCheckForCostnPricechange;
    procedure CheckAndUpdateTreesWhereUsed;
    procedure DoOnUpdate(Sender: TObject);
  protected
    property Product: TProduct read GetProduct;
    property ProcTree: TProcTreeNode read GetProcTree;
    procedure DoFormClose(Sender: TObject); override;
    procedure DoFormCloseQuery(Sender: TObject; var CanClose: Boolean); override;
    Function ReadGuipref(Const Prefname:String):String; overload;Override;
    Procedure WriteGuiPref(Const Prefname:String;Value:String); overload;Override;
    Procedure ReadGuipref; reintroduce; overload;
    Procedure WriteGuiPref; reintroduce; overload;
    procedure GeneralHandler(const Sender: TObject; const Event: string; const Data: Pointer);overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;



implementation

uses
  Dialogs, Controls,
  BusObjNDSBase, Commonlib,systemlib, ClassExtenderListObj, BusObjProcPrefs,
  Vista_MessageDlg, ProcessDataUtils, tcConst, frmPartsFrm,  MyAccess,
  ERPdbComponents, DbSharedObjectsObj,
  FastFuncs, Math, BusObjBase, wwdbedit, GlobalEventsObj, CommonDbLib, DBCtrls,
  ProcProcessSubAssemblyUpdateObj, BusObjProcessPartNDS;

  { TProcessPartsFormExtender }

constructor TProcessPartsFormExtender.Create(AOwner: TComponent);
var
  edtPartname:TwwDBEdit;
  edtProductPrintName:TwwDBEdit;
  txtProductDescriptionSale: TDBMemo;
begin
  inherited;
  CleanTreeEditVersion := 0;
  CleanAllInfo:= '';
  CleanSelectedInfo:='';
  DoingSaveAndUpdateCosts := false;
  CleanProductName := '';
  CleanPrintName := '';
  If not Assigned(Form) then Exit;
  { we are interested in the OnChange event of the parts form page control }

  PageControl := TPageControl(FindChildComponent(Form,'pageControl'));

  if Assigned(PageControl) then begin
    SavedOnChangeHandler := PageControl.OnChange;
    PageControl.OnChange := DoPageControlOnChange;
    SavedOnResizeHandler := PageControl.OnResize;
    PageControl.OnResize := DoPageControlOnResize;
    SavedOnChangingHandler := PageControl.onChanging;
    PageControl.OnChanging := DoPageControlOnChanging;
  end;
  GlobalEvents.RegisterNameHandler(Self, '', '', GEVENT_EXTENDER_PARENT_AFTERSAVE, GeneralHandler);

  Button := TDNMSpeedButton(FindChildComponent(Form,'btnCompleted'));
  if Assigned(Button) then begin
    SavedSaveOnClickHandler := Button.OnClick;
    Button.OnClick := DoSaveOnClick;
  end;

  Button := TDNMSpeedButton(FindChildComponent(Form,'cmdNew'));
  if Assigned(Button) then begin
    SavedNewOnClickHandler := Button.OnClick;
    Button.OnClick := DoNewOnClick;
  end;

  Button := TDNMSpeedButton(FindChildComponent(Form,'btnCopy'));
  if Assigned(Button) then begin
    SavedCopyOnClickHandler := Button.OnClick;
    Button.OnClick := DoCopyOnClick;
  end;

  edtPartname := TwwDBEdit(FindChildComponent(Form,'edtPart'));
  if Assigned(edtPartname) then begin
    SavedPartnameOnEnter := edtPartname.OnEnter;
    SavedPartnameOnExit := edtPartname.OnExit;

    edtPartname.OnEnter:= DoPartnameOnEnter;
    edtPartname.OnExit := DoPartnameOnExit;
  end;

  edtProductPrintName := TwwDBEdit(FindChildComponent(Form,'edtProductPrintName'));
  if Assigned(edtProductPrintName) then begin
    SavedPrintnameOnEnter := edtProductPrintName.OnEnter;
    SavedPrintnameOnExit := edtProductPrintName.OnExit;

    edtProductPrintName.OnEnter:= DoPrintnameOnEnter;
    edtProductPrintName.OnExit := DoPrintnameOnExit;
  end;


  txtProductDescriptionSale := TDBMemo(FindChildComponent(Form,'txtProductDescriptionSale'));
  if Assigned(txtProductDescriptionSale) then begin
    SavedSaleDescOnExit := txtProductDescriptionSale.OnExit;
    txtProductDescriptionSale.OnExit := DoSaleDescOnExit;
  end;

  SavedAfterCommit := Form.MyConnection.AfterCommit;
  Form.MyConnection.AfterCommit := DoAfterCommit;

  if form is TfrmParts then
    TfrmParts(form).OnAfterSaveProduct := self.DoOnAfterSaveProduct;

  fTreeFrame := nil;
  ProductPrice1:=0;
  Productcost1 :=0;
end;

destructor TProcessPartsFormExtender.Destroy;
begin
  { if parts form is being Destroyed ... probably don't need to re-assign handlers }
//  if Assigned(PageControl) then begin
//    PageControl.OnChange := SavedOnChangeHandler;
//    PageControl.OnResize := SavedOnResizeHandler;
//  end;
//
//  if Assigned(Button) then
//    Button.OnClick := SavedSaveOnClickHandler;

  inherited;
end;
 Procedure TProcessPartsFormExtender.CalcBOMCostnPrice(Sender:TObject);
 var
  costChanged, PriceChanged:Boolean;
 begin
  costChanged:= false;
  PriceChanged:= false;

          {Cost}
          if not(Samevalue(ProductDataset.FieldByName('Cost1').AsFloat,  fTreeFrame.TreeNodeRoot.Cost )) then begin
            EditDB(ProductDataset);
            ProductDataset.FieldByName('Cost1').AsFloat:= fTreeFrame.TreeNodeRoot.Cost;
            Productcost1:= fTreeFrame.TreeNodeRoot.Cost;
            costChanged:=true;
            ProductDataset.FieldByName('BOMCostCalculatedFromTree').asBoolean := True;
          end;

         (* {Price}
          if not(sameValue(ProductPrice1,fTreeFrame.TreeNodeRoot.Price)) then begin
            EditDB(ProductDataset);
            ProductDataset.FieldByName('PRICE1').AsFloat:= fTreeFrame.TreeNodeRoot.Price;
            ProductPrice1:= fTreeFrame.TreeNodeRoot.Price;
            PriceChanged:=True;
            ProductDataset.FieldByName('BOMPriceCalculatedfromTree').asBoolean := True;
          end;*)

    if (PriceChanged) or (costChanged) then RecalculateMargins;
    PostDB(ProductDataset);
    if Assigned(fTreeFrame) then
      fTreeFrame.ShowPricecostCalc(CalcBOMCostnPrice , (*not(ProductDataset.FieldByName('BOMCostCalculatedFromTree').asBoolean) or not(ProductDataset.FieldByName('BOMPriceCalculatedFromTree').asBoolean)*)False, '');
 end;
 Procedure TProcessPartsFormExtender.RecalculatecostnPrice;
 var
  s:String;
  Flag:Boolean;
 begin
  Flag:=False;
  if not(Assigned(fTreeFrame)) then exit;
    fTreeFrame.RootNodeData.CalcPrice();
    if (fTreeFrame.TreeNodeRoot<> nil) and (not (Math.SameValue(fTreeFrame.TreeNodeRoot.Cost ,Productcost1, 0.0000001)))(*Productcost1 <>fTreeFrame.TreeNodeRoot.Cost*) then begin
      if not Math.SameValue(fTreeFrame.TreeNodeRoot.Cost , ProductDataset.FieldByName('Cost1').AsFloat) then begin
          s:= 'Product''s Cost :' +  FloatToStrF(ProductDataset.FieldByName('Cost1').AsFloat , ffCurrency, 15,CurrencyRoundPlaces) +chr(13);
          if ProductDataset.FieldByName('BOMCostCalculatedFromTree').asBoolean = False then s:= s + '(Manually entered - not calculated from BOM) :' +chr(13);

          s:= s + chr(13) + 'Cost Calculated From The Tree :' +FloatToStrF(fTreeFrame.TreeNodeRoot.Cost , ffCurrency, 15,CurrencyRoundPlaces);
        editDb(ProductDataset);
        ProductDataset.FieldByName('BOMCostCalculatedFromTree').asBoolean := False;
        Flag:=True;
      end;
    end;
    if (fTreeFrame.TreeNodeRoot<> nil) and (not (Math.SameValue(fTreeFrame.TreeNodeRoot.Price ,ProductPrice1, 0.0000001)))(*ProductPrice1<>fTreeFrame.TreeNodeRoot.Price*) then begin
      if not Math.SameValue(fTreeFrame.TreeNodeRoot.Price ,ProductDataset.FieldByName('PRICE1').AsFloat, 0.0000001) then begin
          s:= s + chr(13) + 'Product''s Price :' +FloatToStrF(ProductDataset.FieldByName('PRICE1').AsFloat , ffCurrency, 15,CurrencyRoundPlaces) +chr(13);
          if ProductDataset.FieldByName('BOMPriceCalculatedfromTree').asBoolean = False then s:= s +'(Manually entered - not calculated from BOM) :' +chr(13) ;

          s := s + chr(13) + 'Price Calculated From The Tree :' +FloatToStrF(fTreeFrame.TreeNodeRoot.Price , ffCurrency, 15,CurrencyRoundPlaces);
        editDb(ProductDataset);
        ProductDataset.FieldByName('BOMPriceCalculatedfromTree').asBoolean := False;
        Flag:=True;
      end;
    end;
    if Flag then
      ShowPricecostCalcHint(s);
  end;
Procedure TProcessPartsFormExtender.RecalculateMargins;
begin
      if ProductDataset.FieldByname('GrossMarginMode').asString = 'F' then begin{markup}
        ProductDataset.FieldByname('Sell_Cost_Percentage').asFloat :=CommonLib.Round(TProduct.CalcGrossMarginPerc( ProductDataset.FieldByname('cost1').asFloat,ProductDataset.FieldByname('PRICE1').AsFloat), tcConst.GeneralRoundPlaces);
      end else begin{gross}
        ProductDataset.FieldByname('Sell_Cost_Percentage').asFloat :=CommonLib.Round(TProduct.calcMarkupPercent( ProductDataset.FieldByname('cost1').asFloat,ProductDataset.FieldByname('PRICE1').AsFloat), tcConst.GeneralRoundPlaces);
      end;
end;
procedure TProcessPartsFormExtender.AutoAllocateProcessForTreeRoot;
var
  PP: TProcessPartNDS;
begin
          if ProcPrefs.AutoAllocateProcessForTreeRoot then begin
            if fTreeFrame.RootNodeData <> nil then begin
              if fTreeFrame.RootNodeData.ProcessStepList.Count =0 then begin
                pp:= fTreeFrame.RootNodeData.ProcessStepList.AddProcessPart;
                pp.PartId                := fTreeFrame.RootNodeData.PArtsId;
                pp.ProcessStepID         := ProcPrefs.DefaultProcessforTreeID;
                pp.ProcessStepSeq        := 10;
                pp.ProcTreeId            := fTreeFrame.RootNodeData.ID;
                pp.IsTemplate            := True;
                pp.MakeCoupons           := False;
                pp.Duration := ProcPrefs.DefaultTreeProcessDuration;
                fTreeFrame.TimerMsg(SecondstoTime(trunc(ProcPrefs.DefaultTreeProcessDuration)) +' ' + ProcPrefs.DefaultProcessforTree +' is Added to the Tree as DEfault Based on the Preference.');
              end;
            end;
          end;
end;
procedure TProcessPartsFormExtender.DoPageControlOnChange(Sender: TObject);
begin
  { call the saved event first }
  if Assigned(TNotifyEvent(SavedOnChangeHandler)) then
    TNotifyEvent(SavedOnChangeHandler)(Sender);

  if PageControl.ActivePage.Name = 'NewManufacture' then begin
    if Assigned(ProcTree) {and (Product.Id > 0)} then begin
      if ProcTree.PartsId <> Product.Id then begin
        if (CommonLib.MessageDlgXP_Vista('Do you wish to create a new bill of materials tree for this product?',
          mtConfirmation,[mbNo,mbYes],0) = mrYes) then begin
          { user wants to create a new tree for this product }
          CleanTreeEditVersion := 0;
          if not Assigned(fTreeFrame) then begin
            InitVisualTree;
            ProcTree.PartsId := Product.Id;
            ProcTree.MasterType := mtProduct;
            ProcTree.MasterID := Product.Id;
//            ProcTree.Caption:= Product.ProductName;
//            ProcTree.Description := Product.SalesDescription;
            ProcTree.Caption:= ProductDataset.FieldByName('PartName').AsString;
            ProcTree.Description := ProductDataset.FieldByName('PartsDescription').AsString;
            ProcTree.TreePartUOMQuantity(*Quantity*) := 1;
            ProcTree.IsTemplate := True;
            fTreeFrame.ProcessTreeID := 0;
            fTreeFrame.RootNodeData:= ProcTree;
            fTreeFrame.RootNodeData.CalcPrice();
            if fTreeFrame.TreeNodeRoot <> nil then begin
              ProductPrice1:= fTreeFrame.TreeNodeRoot.Price;
              ProductCost1:= fTreeFrame.TreeNodeRoot.Cost;
            end else begin
              ProductPrice1:= 0;
              ProductCost1:= 0;
            end;
          end;
          fTreeFrame.ProductPrice := ProductDataset.FieldByName('Price1').AsFloat;
          fTreeFrame.Productcost := ProductDataset.FieldByName('Cost1').AsFloat;

          AutoAllocateProcessForTreeRoot;
        end;
      end
      else begin
        { tree exists, display if not already }
        if not Assigned(fTreeFrame) then begin
//          Log('start display tree','Info');
          InitVisualTree;
          fTreeFrame.TreeNodeRoot := ProcTree;
          fTreeFrame.ClearAndLoad := False;
          fTreeFrame.ProcessTreeID := ProcTree.ProcTreeID;
          ProductPrice1:= fTreeFrame.TreeNodeRoot.Price;
          ProductCost1:= fTreeFrame.TreeNodeRoot.Cost;
        end;
        if Assigned(fTreeFrame) then begin
          RecalculateCostnPrice;
//          Log('end display tree','Info');
        end
        else begin
          if fTreeFrame.RootNodeData.Description = '' then
            fTreeFrame.RootNodeData.Description:=
              ProductDataset.FieldByName('PartsDescription').AsString;
        end;
        CleanTreeEditVersion := ProcTree.EditVersion;
      end;
    end;
    if assigned(Proctree) then begin
      CleanAllInfo:= Proctree.AllInfos;
      CleanSelectedInfo:=Proctree.SelectedInfos;
    end;

  end;
end;

procedure TProcessPartsFormExtender.GeneralHandler(const Sender: TObject;
  const Event: string; const Data: Pointer);
begin
  if (Event = GEVENT_EXTENDER_PARENT_AFTERSAVE)  then begin
        AuditTrialTree;
    end;
end;

function TProcessPartsFormExtender.GetProcTree: TProcTreeNode;
begin
  result:= TProductProcTree(Product.Container.ItemByClass(TProductProcTree));
end;

procedure TProcessPartsFormExtender.DoPageControlOnResize(Sender: TObject);
begin

end;

procedure TProcessPartsFormExtender.DoPartnameOnEnter(Sender: TObject);
begin
  if Assigned(SavedPartnameOnEnter) then
    SavedPartnameOnEnter(Sender);
  CleanProductName:= TwwDBEdit(Sender).text;
end;

procedure TProcessPartsFormExtender.DoPartnameOnExit(Sender: TObject);
begin
  if Assigned(SavedPartnameOnExit) then
    SavedPartnameOnExit(Sender);
  (*if CleanProductName <> '' then
    if not(SameText(CleanProductName, TwwDBEdit(Sender).text)) then begin
      if assigned(ProcTree) then begin
        ProcTree.Caption :=TwwDBEdit(Sender).text;
        ProcTree.SaveNoCheck;
      end;
    end;*)
    if ProcTree.Caption <> TwwDBEdit(Sender).text then begin
      ProcTree.Caption :=TwwDBEdit(Sender).text;
      ProcTree.SaveNoCheck;
    end;
end;
procedure TProcessPartsFormExtender.DoPrintnameOnEnter(Sender: TObject);
begin
  if Assigned(SavedPrintnameOnEnter) then
    SavedPrintnameOnEnter(Sender);
  CleanPrintName:= TwwDBEdit(Sender).text;
end;

procedure TProcessPartsFormExtender.DoPrintnameOnExit(Sender: TObject);
begin
  if Assigned(SavedPrintnameOnExit) then
    SavedPrintnameOnExit(Sender);
    if ProcTree.Caption <> TwwDBEdit(Sender).text then begin
      ProcTree.Caption :=TwwDBEdit(Sender).text;
      ProcTree.SaveNoCheck;
    end;
end;

Procedure TProcessPartsFormExtender.AuditTrialTree;
begin
  if fTreeFrame = nil then exit; // Tree is not accessed at all.
  ProcTree.CompareTrees;
end;

Procedure TProcessPartsFormExtender.UpdateProductDescriptionFromTreeInfo;
begin
    if sametext(Trim(CleanAllInfo),Trim(Proctree.AllInfos)) and SameText(Trim(CleanSelectedInfo),Trim(Proctree.SelectedInfos)) then exit;

    if Assigned(Form) then
      if Form is Tfrmparts then begin
        if (Tfrmparts(Form).qryProductDescription.AsString <> '') and (Tfrmparts(Form).qryProductPURCHASEDESC.AsString <> '') then begin
          if CommonLib.MessageDlgXP_Vista('Add Manufacturing Info to Product Card Purchase and Sales Description?', mtConfirmation,[mbYes,mbNo],0) = mrYes then
            Tfrmparts(Form).UpdateProductDescriptionFromTreeInfo(CleanSelectedInfo , trim(ProcTree.SelectedInfos) , CleanAllInfo , trim(ProcTree.AllInfos));
        end
        else begin
          if CommonLib.MessageDlgXP_Vista('Update Product Card Purchase and Sales Description with Manufacturing Info?', mtConfirmation,[mbYes,mbNo],0) = mrYes then
            Tfrmparts(Form).UpdateProductDescriptionFromTreeInfo(CleanSelectedInfo , trim(ProcTree.SelectedInfos) , CleanAllInfo , trim(ProcTree.AllInfos));
        end;
      end;
end;

function TProcessPartsFormExtender.SaveAndUpdateCosts: boolean;
begin
  result:= true;
  if DoingSaveAndUpdateCosts then exit;
  DoingSaveAndUpdateCosts := true;
  try
    { Product dataset is not linked to parts form dataset
      (this was causing event problems) so update tree product info from
      form query }
    if fTreeFrame = nil then exit; // Tree is not accessed at all.
    if ProcTree.Children.Count > 0 then begin
      ProcTree.Caption:= ProductDataset.FieldByName('PartName').AsString;
      ProcTree.Description:= ProductDataset.FieldByName('PartsDescription').AsString;
      if (not CheckTree) or (not ProcTree.ValidateData) then
        result:= false
      else begin
          ProcTree.SaveNoCheck;

      UpdateProductDescriptionFromTreeInfo;

        if    (not (Math.SameValue(ProcTree.CostincLabour ,ProductDataset.FieldByName('MancostWithLabour').AsFloat, 0.0000001))) then begin
          EditDB(ProductDataset);
          ProductDataset.FieldByName('MancostWithLabour').AsFloat:= ProcTree.CostincLabour;
        end;
        if ProductDataset.State in [dsEdit,dsInsert] then ProductDataset.Post;
        (*RecalculatecostnPrice;*)
      end;
    end;
  finally
    DoingSaveAndUpdateCosts := false;
  end;
end;

procedure TProcessPartsFormExtender.ShowPricecostCalcHint(const Msg:String);
begin
  if Assigned(Form) then
    if Form is Tfrmparts then
      Tfrmparts(Form).ShowPricecostCalcHint;

  if Assigned(fTreeFrame) then
    fTreeFrame.ShowPricecostCalc(CalcBOMCostnPrice , not(ProductDataset.FieldByName('BOMCostCalculatedFromTree').asBoolean) or not(ProductDataset.FieldByName('BOMPriceCalculatedFromTree').asBoolean), Msg);
  //UpdateProductDescriptionFromTreeInfo;
end;

procedure TProcessPartsFormExtender.DoSaleDescOnExit(Sender: TObject);
var
  qry: TERPQuery;
begin
  if ProcTree.Description <> TDBMemo(Sender).Text then begin
    ProcTree.Description := TDBMemo(Sender).Text;
    if not Assigned(fTreeFrame) then begin
      { we need to update the proc tree description };
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := TERPConnection(FindChildComponent(Form,'MyConnection'));
        qry.SQL.Text := 'update tblproctree set Description = ' + QuotedStr(ProcTree.Description) +
          ' where ProcTreeId = ' + IntToStr(ProcTree.Id);
        qry.Execute;
      finally
        qry.Free;
      end;
    end;
  end;
end;

procedure TProcessPartsFormExtender.DoSaveOnClick(Sender: TObject);
begin
  if not SaveAndUpdateCosts then
    exit;
  if Assigned(SavedSaveOnClickHandler) then
    SavedSaveOnClickHandler(Sender);
end;

procedure TProcessPartsFormExtender.DoFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  { don't Save if user has canceled or bOnSave set (already saved in DoSaveOnClick) }
  if (sender is TfrmParts) and ((TForm(Sender).ModalResult = mrCancel) or (TfrmParts(Sender).bOnSave)) then
    exit;

  CanClose:= SaveAndUpdateCosts;
end;

procedure TProcessPartsFormExtender.DoAfterCommit(Sender: TObject);
begin
  if Assigned(SavedAfterCommit) then
    SavedAfterCommit(Sender);
  if (CleanTreeEditVersion > 0) and  Assigned(ProcTree) and (ProcTree.EditVersion <> CleanTreeEditVersion) then begin
    { user has changed the tree, we need to see if this tree is used anywhere else }
    CheckAndUpdateTreesWhereUsed;


  end;
end;

procedure TProcessPartsFormExtender.DoCheckForCostnPricechange;
begin
  RecalculatecostnPrice;
end;

procedure TProcessPartsFormExtender.DoCopyOnClick(Sender: TObject);
var
  CurrentTreeId: integer;
begin
  CurrentTreeId:= ProcTree.Id;

  if not SaveAndUpdateCosts then
    exit;

  if Assigned(SavedCopyOnClickHandler) then
    SavedCopyOnClickHandler(Sender);
  FreeAndNil(fProduct);  
  if (CurrentTreeId <> 0) then begin  // and (CurrentTreeId <> ProcTree.Id) then begin
    ProcTree.Load(CurrentTreeId);
    ProcTree.ClearIds;
    ProcTree.PartsId := Product.Id;
    ProcTree.MasterID := Product.Id;
    ProcTree.Caption := Product.Productname;
    ProcTree.description:= Product.Productname;
    ProcTree.SaveNoCheck;
  end;
end;

function TProcessPartsFormExtender.GetProduct: TProduct;
begin
  result:= nil;
  If not Assigned(Form) then Exit;
  if not Assigned(fProduct) then begin
    fProduct := TProduct.Create(Self);
    fProduct.connection := TMyDacDataConnection.create(Fproduct);
    fProduct.connection.connection :=TERPConnection(FindChildComponent(Form,'MyConnection'));
    fProduct.Load(TERPQuery(FindChildComponent(Form,'qryProduct')).fieldByname('PartsID').asInteger);
    (*fProduct:= TProduct(FindChildComponent(Form,'Product'));*)
  end;
  result:= fProduct;
end;
procedure TProcessPartsFormExtender.InitVisualTree;
begin
//  Log('InitVisualTree - Start','Info');
  fTreeFrame := TframeTree.Create(Form);
  fTreeFrame.pnlOptions.Parent := PageControl.ActivePage;
  fTreeFrame.pnlFooter.Parent := PageControl.ActivePage;
  fTreeFrame.vstProcessPart.Parent := PageControl.ActivePage;
  fTreeFrame.TreeMode:= tmTemplate;
  fTreeFrame.vstProcessPart.Visible:= true;
  fTreeFrame.DoCheckForCostnPricechange :=DoCheckForCostnPricechange ;
  fTreeFrame.ResetCaptions;
  Application.ProcessMessages;
  fTreeFrame.vstProcessPart.Refresh;
  Form.Update;

  ReadGuipref;
  SetObjectProperty(form,'PartHasTree' , True);
//  Log('InitVisualTree - End','Info');
end;


procedure TProcessPartsFormExtender.CheckAndUpdateTreesWhereUsed;
var
  Updater: TSubAssemblyUpdater;
begin
  Updater := TSubAssemblyUpdater.Create;
  try
    Updater.OnUpdate := DoOnUpdate;
    Updater.SubAssemblyProcTreeID := ProcTree.Id;
    if Updater.SubAssemblyUsedCount > 0 then begin
      if CommonLib.MessageDlgXP_Vista('There are ' + IntToStr(Updater.SubAssemblyUsedCount) +
        ' Manufactured Products that use Sub-Assembly ' +
        ProcTree.Caption + '. ' + #13#10 + #13#10 +
        'Do you wish to Updated these Products?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
          exit;
      Dialog := TProgressDialog.Create(nil);
      try
        Dialog.Caption := 'Updating Products ..';
        Dialog.ShowPercent := true;
        Dialog.MaxValue := Updater.SubAssemblyUsedCount;
        Dialog.Value := 0;
        Dialog.Execute;
        Updater.Execute;
      finally
        FreeAndNil(Dialog);
      end;
      CommonLib.MessageDlgXP_Vista('Update Finished.',mtInformation,[mbOk],0);
    end;
  finally
    Updater.Free;
  end;
end;

function TProcessPartsFormExtender.CheckTree: boolean;
var
  list: string;
begin
  result:= true;
  if not ProcTreeIsCustom(ProcTree) then begin
    if ProcPrefs.WarnTemplateProcessesNotDefined then begin
      DialogVerifyChecked:= true;
      if not ProcessDataUtils.ProcTreeHasProcesses(ProcTree) and
        (not TreeHasAddToSaleNodes(ProcTree)) then begin
        (* if MessageDlgXP_Vista('There are no process steps defined for "' +
          ProcTree.Caption + '", do you wish to Save anyway?',
          mtInformation,[mbYes, mbNo],0,nil,'',
          'Show this message next time.',true,OnDialogVerifyClick) = mrNo then
          result:= false; *)
        MessageDlgXP_Vista('There are no process steps defined for "' +ProcTree.Caption + '".' +NL+NL+'Tree Cannot be saved without any process Steps.',mtInformation,[mbok],0);
        result:= false;
      end;
      ProcPrefs.WarnTemplateProcessesNotDefined:= DialogVerifyChecked;
    end;
    if result and ProcPrefs.WarnTemplateOptionDefaultNotDefined then begin
      DialogVerifyChecked:= true;
      if ProcessDataUtils.ProcTreeOptionsWithotDefaults(ProcTree, list) then begin
//        if MessageDlgXP_Vista('The following option (choice) items defined for "' +
//          ProcTree.Caption + '"' +
//          ' do not have default values selected:' + CRLF + list + CRLF + 'Do you wish to Save anyway?',
//          mtInformation,[mbYes, mbNo],0,nil,'',
//          'Show this message next time.',true,OnDialogVerifyClick) = mrNo then
//          result:= false;
        MessageDlgXP_Vista('The following option (choice) items defined for "' +
          ProcTree.Caption + '"' +
          ' do not have default values selected:' + CRLF + list  + CRLF + 'Please select one.',
          mtInformation,[mbOk],0);
        result:= false;
      end;
      ProcPrefs.WarnTemplateOptionDefaultNotDefined:= DialogVerifyChecked;
    end;
  end;  
  if ProcPrefs.Dirty then
    ProcPrefs.Save;
end;

(* procedure TProcessPartsFormExtender.OnDialogVerifyClick(Sender: TObject;
  Checked: boolean);
begin
  DialogVerifyChecked:= Checked;
end; *)

procedure TProcessPartsFormExtender.DoFormClose(Sender: TObject);
begin
  inherited;
  WriteGuiPref;  
  if Assigned(fTreeFrame) then
    FreeAndNil(fTreeFrame);
end;

function TProcessPartsFormExtender.GetProductDataSet: TDataSet;
begin
  result:= nil;
  If not Assigned(Form) then Exit;
  if not Assigned(fProductDataset) then begin
    fProductDataSet:= TDataSet(FindChildComponent(Form,'qryProduct'));
(*    ProductPrice1:=ProductDataset.FieldByName('PRICE1').AsFloat;
    Productcost1 :=ProductDataset.FieldByName('Cost1').AsFloat;*)
  end;
  result:= fProductDataSet;
end;

procedure TProcessPartsFormExtender.DoNewOnClick(Sender: TObject);
begin
  if not SaveAndUpdateCosts then
    exit;

  try
    WriteGuiPref;
    FreeAndNil(fTreeFrame);
    FreeAndNil(fProduct);
  except
  end;

  if Assigned(SavedNewOnClickHandler) then
    SavedNewOnClickHandler(Sender);
end;


procedure TProcessPartsFormExtender.DoOnAfterSaveProduct(Sender: TObject);
begin
  SaveAndUpdateCosts;
end;

procedure TProcessPartsFormExtender.DoOnUpdate(Sender: TObject);
begin
  if TSubAssemblyUpdater(Sender).ErrMsg <> '' then
    CommonLib.MessageDlgXP_Vista(TSubAssemblyUpdater(Sender).ErrMsg,mtWarning,[mbOK],0);
  Dialog.StepIt;
end;

procedure TProcessPartsFormExtender.DoPageControlOnChanging(
  Sender: TObject; var AllowChange: Boolean);
begin
  if Assigned(SavedOnChangingHandler) then
    SavedOnChangingHandler(Sender , Allowchange);
  if PageControl.ActivePage.Name = 'NewManufacture' then begin
    if not Allowchange then exit;
    RecalculatecostnPrice;
    UpdateProductDescriptionFromTreeInfo;
  end;

end;

procedure TProcessPartsFormExtender.ReadGuipref;
begin
  if Assigned(fTreeFrame) then begin
    fTreeFrame.HideQtyPer  := StrToBoolean(ReadGuipref('HideQtyPer'));
    fTreeFrame.HideFormulacolumns  := StrToBoolean(ReadGuipref('HideFormulacolumns'));
  end;
end;

procedure TProcessPartsFormExtender.WriteGuiPref;
begin
  if Assigned(fTreeFrame) then begin
    WriteGuiPref('HideQtyPer' , BooleanToStr(fTreeFrame.HideQtyPer ));
    WriteGuiPref('HideFormulacolumns' , BooleanToStr(fTreeFrame.HideFormulacolumns ));
  end;
end;

function TProcessPartsFormExtender.ReadGuipref(const Prefname: String): String;
begin
  result := inherited ReadGuipref(Prefname);
end;

procedure TProcessPartsFormExtender.WriteGuiPref(const Prefname: String;Value: String);
begin
  inherited WriteGuiPref(Prefname , Value);
end;

initialization

  RegisterClassOnce(TProcessPartsFormExtender);
  ClassExtenderList.AddExtender('TfrmParts','TProcessPartsFormExtender');

end.
