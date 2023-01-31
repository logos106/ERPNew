unit ProcessSalesFormExtender;

interface

uses
  BaseInputFormExtender, Classes, ComCtrls,AdvOfficeStatusBar,
  wwDbGrid, wwdblook, Db, BusObjSales, BusObjProcess,
  Menus, AdvMenus, Controls, SysUtils, ExtCtrls;

type

  TProcessSalesFormExtender = class(TBaseInputFormExtender)
  private
    fSales: TSales;
    SavedOnCloseUp: TNotifyCloseUpEvent;
    SavedOnPopup: TNotifyEvent;
    SavedLineDelete: TNotifyEvent;
    SavedCopyToInvoice: TNotifyEvent;
    fTimer: TTimer;
    function GetProcTree: TProcTreeNode;
    function GetSales: TSales;
    procedure DisplayProcTreeEdit(AutoPopup:boolean; Highlightcolumn :Integer = -1; HighlightcolumnMsg :String = '');
//    procedure DoProductCloseUp(Sender: TObject; LookupTable: TDataSet; FillTable: TDataSet; Modified: Boolean);
    procedure DoMenuPopup(Sender: TObject);
    procedure DoMenuItemProcessTreeClick(Sender: TObject);
    procedure DoMenuItemResourceCapcityClick(Sender: TObject);

    Procedure DoBOMSalesProgressReport(Sender: TObject);
    Procedure DoMenuItemProductionSchedulingClick(Sender: TObject);
    Procedure DoMenuItemPrintJobDetailsClick(Sender: TObject);
    Procedure DoMenuItemCapacityPlannerClick(Sender: TObject);
    procedure initCapacityplanner(Sender: TObject);
    procedure initBOMPLanner(Sender: TObject);
    Procedure DoManufactureSummaryClick(Sender: TObject);
    Procedure DoManufactureEditQtyClick(Sender: TObject);
    Procedure DoMenuItemFinaliseTreeClick(Sender: TObject);
    Procedure DoMenuItemProcessTreeHiddenClick(Sender: TObject);
    Procedure DoMenuItemRecalcClick(Sender: TObject);
    procedure DoMenuItemPurchaseOrdersClick(Sender: TObject);
    Procedure DoMenuItemSmartOrdersClick(Sender: TObject);
    Procedure BeforeShowSalesSmartOrderList(Sender: TObject);
    Procedure BeforeShowSalesPurchaseOrderList(Sender: TObject);
    procedure DoLineDeleteClick(Sender: TObject);
    procedure DoCopyToInvoiceClick(Sender: TObject);
    procedure GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
    procedure DoProductSelect(sender: TObject);
    function FirstSaleProcessPart: TDateTime;
    procedure doProcessTree(Sender: TObject; Highlightcolumn: Integer; HighlightcolumnMsg :String);
    (*Procedure DoProcessSchedulesClick(Sender: TObject);
    procedure BeforeShowTBOMSaleProcessSchedule(Sender: TObject);*)
  protected
    property ProcTree: TProcTreeNode read GetProcTree;
    property Sales: TSales read GetSales;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  Dialogs, Commonlib,systemlib, ClassExtenderListObj, BusobjSaleBase, frmProcTreeEdit,
  TreeFrame, wwdbigrd, BusObjProcessPartNDS, ProcessDataUtils, Contnrs,
  BusObjBase, DNMSpeedButton, LogUtils, GlobalEventsObj, CommonFormLib,
  SalesSmartOrderList, SalesPurchaseOrderList, BusObjNDSBase, frmSalesOrder,
  ERPdbComponents,AppEnvironment, BusObjConst, frmsaleslineManufactureSummary , Progressdialog,
  frmProcCapacityPlanning, Sales, tcConst, tcDataUtils,
  frmsaleslineManufactureTotalQtyEdit, BOMSalesProgressReport,
  BOMSaleResourceCheck;

{ TProcessSalesFormExtender }

type

  TSaleLineAddRecType = (artAdd, artDelete);

  TSaleLineAddRec = class(TObject)
  public
    AddRemoveType: TSaleLineAddRecType;
    NodeId: integer;
    NodeQty: double;
    NodePartsId: integer;
    SalesLineId: integer;
  end;

  TSaleLineAddList = class(TObject)
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItem(const index: integer): TSaleLineAddRec;
  public
    SalesLineId: integer;
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[const index: integer]: TSaleLineAddRec read GetItem; default;
    procedure Add(const AddType: TSaleLineAddRecType; const aNodeId: integer; const aNodeQty: double;
      const aNodePartsId: integer; const aSalesLineId: integer = 0);
    procedure Clear;
    class procedure UpdateSaleFromTree(const aLine: TSalesLineBase);
  end;
procedure TProcessSalesFormExtender.BeforeShowSalesSmartOrderList(Sender: TObject);
begin
  if not(Sender is TSalesSmartOrderListGUI) then exit;
  TSalesSmartOrderListGUI(Sender).SaleLineId :=sales.Lines.ID;
end;

Procedure TProcessSalesFormExtender.BeforeShowSalesPurchaseOrderList(Sender: TObject);
begin
  if sender is TSalesPurchaseOrderListGUI then begin
    TSalesPurchaseOrderListGUI(Sender).SaleLineId :=sales.Lines.ID;
  end else if sender is TBOMSalesProgressReportGUI then begin
    TBOMSalesProgressReportGUI(Sender).SaleLineId :=sales.Lines.ID;
  end else if sender is TBOMSaleResourceCheckGUI then begin
    TBOMSaleResourceCheckGUI(Sender).saleId :=sales.ID;
  end;
end;

constructor TProcessSalesFormExtender.Create(AOwner: TComponent);
var
  MenuItem: TMenuItem;
  ProdCombo: TwwDbLookupCombo;
  PopupMenu: TAdvPopupMenu;
  LineDeleteButton: TwwIButton;
  CopyToInvoiceButton: TDNMSpeedButton;
begin
  inherited;
  fTimer:= TTimer.Create(self);
  fTimer.Enabled:= false;
  If not Assigned(Form) then Exit;
  ProdCombo := TwwDbLookupCombo(FindChildComponent(Form, 'cboProductR'));
  SavedOnCloseUp := ProdCombo.OnCloseUp;
//  ProdCombo.OnCloseUp := DoProductCloseUp;
  PopupMenu := TAdvPopupMenu(FindChildComponent(Form, 'mnuDiscountTotal'));
  SavedOnPopup := PopupMenu.OnPopup;
  PopupMenu.OnPopup := DoMenuPopup;
  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := '-';
  PopupMenu.Items.Insert(0,MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Purchase Orders';
  MenuItem.OnClick := DoMenuItemPurchaseOrdersClick;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Smart Orders';
  MenuItem.OnClick := DoMenuItemSmartOrdersClick;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);
  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Recalculate Price From Tree';
  MenuItem.OnClick := DoMenuItemRecalcClick;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);

//  if ProcPrefs.WastageCalculationEnabled then begin
    MenuItem := TMenuItem.Create(PopupMenu);
    MenuItem.Caption := 'Finalise for Production';
    MenuItem.OnClick := DoMenuItemFinaliseTreeClick;
    MenuItem.Enabled := False;
    PopupMenu.Items.Insert(0,MenuItem);
//  end;

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Process Tree';
  MenuItem.OnClick := DoMenuItemProcessTreeClick;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Resource Capacity';
  MenuItem.OnClick := DoMenuItemResourceCapcityClick;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);


  (*  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Schedule List';
  MenuItem.OnClick := DoProcessSchedulesClick;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);*)

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'BOM Sales Progress Report';
  MenuItem.OnClick := DoBOMSalesProgressReport;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Process Tree Hidden';
  MenuItem.OnClick := DoMenuItemProcessTreeHiddenClick;
  MenuItem.Enabled := False;
  MenuItem.Visible := False;
  PopupMenu.Items.Insert(0,MenuItem);


  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Production Scheduling';
  MenuItem.OnClick := DoMenuItemProductionSchedulingClick;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Print Job Details';
  MenuItem.OnClick := DoMenuItemPrintJobDetailsClick;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Capacity Planner';
  MenuItem.OnClick := DoMenuItemCapacityPlannerClick;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);



  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Manufacture Summary';
  MenuItem.OnClick := DoManufactureSummaryClick;
  MenuItem.Enabled := False;
  PopupMenu.Items.Insert(0,MenuItem);

  if devmode then begin
      MenuItem := TMenuItem.Create(PopupMenu);
      MenuItem.Caption := 'Edit Manufacture Quantity';
      MenuItem.OnClick := DoManufactureEditQtyClick;
      MenuItem.Enabled := False;
      PopupMenu.Items.Insert(0,MenuItem);
  end;

  LineDeleteButton:= TwwIButton(FindChildComponent(Form, 'btnDelete'));
  if Assigned(LineDeleteButton) then begin
    SavedLineDelete:= LineDeleteButton.OnClick;
    LineDeleteButton.OnClick:= DoLineDeleteClick;
  end
  else
    raise Exception.Create('TProcessSalesFormExtender - Could not find btnDelete on SalesOrder form');

  CopyToInvoiceButton:= TDNMSpeedButton(FindChildComponent(Form,'btninv'));
  if Assigned (CopyToInvoiceButton) then begin
    SavedCopyToInvoice:= CopyToInvoiceButton.OnClick;
    CopyToInvoiceButton.OnClick:= DoCopyToInvoiceClick;
  end;
  GlobalEvents.RegisterHandler(Self, '','','', GEVENT_OnSelectProduct, GlobalEventHandler);
end;

procedure TProcessSalesFormExtender.DisplayProcTreeEdit(AutoPopup:boolean; Highlightcolumn :Integer = -1; HighlightcolumnMsg:String = '');
var
  TreeForm: TfmProcTreeEdit;
  oldSmartOrderID:Integer;
  fiALL:Integer;
  fdCleanPrice :double;
begin
  fiALL:= 1;
  try
    if ProcTree = nil then exit;
    if (not(AutoPopup) (*and (not(AppEnv.CompanyPrefs.ConfirmQtysOnfinalise))*) ) or
       ((Appenv.Companyprefs.OpenTreeFromSalesOrder) and (Appenv.Employee.OpenTreeFromSalesOrder) (*and (not(AppEnv.CompanyPrefs.ConfirmQtysOnfinalise))*) ) or
       (Autopopup and ( IsOtfProduct(ProcTree.PartsId))) then begin
      if Assigned(Form) and (form is TSalesOrderGUI) then begin
        fiALL:= Form.accesslevel;
        if TSalesOrderGUI(Form).ProcessAlreadyStarted then form.accesslevel := 1;
        TSalesOrderGUI(Form).btnCompleted.Enabled := True;
      end;
      TreeForm := TfmProcTreeEdit.Create(nil);
      try
        (*If Assigned(Form) then
          TreeForm.AccessLevel:= Form.AccessLevel;*)
        TreeForm.AutoPopup:= AutoPopup;
        TreeForm.Tree.TreeNodeRoot := ProcTree;
        TreeForm.Tree.ClearAndLoad := False;
        TreeForm.Tree.ProcessTreeID := ProcTree.ProcTreeID;
        TreeForm.Tree.TreeMode := tmInput;
        TreeForm.Tree.TreeNodeRoot.Dirty := False;
        TreeForm.Tree.GenericStr := Sales.DocNumber;
        TreeForm.Tree.Highlightcolumn :=Highlightcolumn;
        TreeForm.Tree.HighlightcolumnMsg :=HighlightcolumnMsg;
        TreeForm.Tree.TransConnection :=  TSalesOrderGUI(form).myconnection;
        if Sales.IsPaid  then begin
          TreeForm.AccessLevel:= 5; {read only}
          TreeForm.ReadonlyMsg :='Already Paid';
        end else if  (ProcTree.Complete) then begin
          TreeForm.AccessLevel:= 5; {read only}
          TreeForm.ReadonlyMsg :='Production Completed';
        end else if  ProcTree is TSalesLineProcTree then
          if (TSalesLineProcTree(Proctree).BomgroupedLine =True) then begin
            TreeForm.AccessLevel:= 5; {read only}
            TreeForm.ReadonlyMsg :='This Product is Grouped';
          end;

        TreeForm.Tree.vstProcessPart.Visible:= true;
        (*TreeForm.Tree.TreeReadOnly:= ProcTree.Complete;*)
        if ProductionSchedOrStarted(TreeForm.Tree.RootNodeData) then begin
          (*TreeForm.Tree.TreeReadOnly:= true;
          TreeForm.AccessLevel:= 5;
          TreeForm.ReadonlyMsg :='Read Only : Production Scheduled or Started';*)
          TreeForm.ReadonlyMsg :='Production Scheduled or Started';
        end;

        TreeForm.KeyID:= 1; { stops "read-only" dialog pop-up if form is read only }
        TreeForm.TRee.HideFormulacolumns  := StrToBoolean(ReadGuipref('HideFormulacolumns'));
        if Autopopup and ( IsOtfProduct(TreeForm.Tree.TreeNodeRoot.PartsId)) then begin
          //if MessageDlgXP_Vista(Quotedstr(Sales.Lines.Productname) +' is an OTF Product.'+NL+'Do you Wish to Delete the Tree from the Sale?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
            TreeForm.Tree.DeleteTree;
            TreeForm.ShowProductselection := True;
            //MessageDlgXP_Vista(TreeForm.Tree.TreeNodeRoot.caption + ' is an OTF product. Please Choose the Items Required.' , mtInformation, [mbOK], 0);
          //end;
        end;
        if assigned(Proctree) then fdCleanPrice := Proctree.Price
        else fdCleanPrice := 0;
        if TreeForm.ShowModal = mrOK then begin
          DoShowProgressbar(7 , 'Please wait ' ,'Saving Tree Changes', true);
          try
            WriteGuiPref('HideFormulacolumns' , BooleanToStr(TreeForm.TRee.HideFormulacolumns ));
            if Sales.Lines.isTreeItem  then begin
              DoStepProgressbar('Updating sales Record');             TSaleLineAddList.UpdateSaleFromTree(Sales.Lines);
              //DoStepProgressbar(pb, 'Recalculating Price');          ProcTree.CalcPrice     ;
              DoStepProgressbar( 'Build Tree details');                ProcTree.BuildDetails  ;
              DoStepProgressbar( 'Track Smart Order');                 OldSmartOrderID:=TSalesLineProcTree(ProcTree).SmartOrderID;
              DoStepProgressbar( 'Save Changes');                      ProcTree.SaveNoCheck   ;
              if fdCleanPrice <> Proctree.price then begin
(*                Sales.Lines.OriginalLinePrice:= Round(DivZer(Proctree.Price,Proctree.ManufactureQty),GeneralRoundPlaces);
                Sales.Lines.LinePrice        := Round(DivZer(Proctree.Price,Proctree.ManufactureQty),GeneralRoundPlaces);
                Sales.Lines.CalcLineTotals;*)
                Sales.Lines.DoBaseLinePricecalc;
              end;

              if (TSalesLineProcTree(ProcTree).SmartOrderID<>0) and (OldSmartOrderID=0) then
                  MessageDlgXP_Vista('Smart Order # ' +inttostr(TSalesLineProcTree(ProcTree).SmartOrderID) + ' is created for Production of '+ Sales.Lines.productname + ' of Sales Order # ' +inttostr(Sales.ID) , mtInformation, [mbOK], 0);
              //Sales.Lines.UOMQtyShipped := Sales.Lines.UOMQtyShipped;{to fire the do field on change as the tree is populated foe single qty when partsource is changed }

              if appenv.Companyprefs.CopyTreeInfotoSalesDesc then
                Sales.Lines.Product_Description := trim(TSalesLineProcTree(ProcTree).Info)
              else if appenv.Companyprefs.UpdateSalesDescriptionFromTreeInfo then
                Sales.Lines.Product_Description := trim(TSalesLineProcTree(ProcTree).SelectedInfos);

            end else begin
              DoHideProgressbar;
              MessageDlgXP_Vista('Please Note that There is No Tree Associated with this Product ' + quotedstr(Sales.Lines.ProductName)+'.'+NL+
                                        'Delete the item and add again to Make the Tree.', mtInformation, [mbOK], 0);
            end;

          finally
            DoHideProgressbar;
          end;
      end;
      finally
        TreeForm.Release;
      end;
    end;
  finally
    if Assigned(Form) and (form is TSalesOrderGUI) then
      Form.accesslevel:= fiALl;
  end;
end;

procedure TProcessSalesFormExtender.DoMenuItemSmartOrdersClick(Sender: TObject);
begin
  if Assigned(fSales) then fSales.ResultStatus.Clear;
  openERPListform('TSalesSmartOrderListGUI' , BeforeShowSalesSmartOrderList);
end;
Procedure TProcessSalesFormExtender.DoManufactureSummaryClick(Sender: TObject);
begin
  if Assigned(fSales) then fSales.ResultStatus.Clear;
  if assigned(ProcTree) then begin
    if ProcTree.accesslevel = 1 then begin
      ProcTree.CalcPrice;
      ProcTree.SaveNoCheck;
    end;
    if TfmsaleslineManufactureSummary.ShowSaleslineManufactureSummary(TERPConnection(fSales.Lines.Connection.Connection) , fSales.Lines.ID, false ) = mrOk then
      DoMenuItemProcessTreeClick(Sender);
  end;
end;
Procedure TProcessSalesFormExtender.DoManufactureEditQtyClick(Sender: TObject);
begin
  if Assigned(fSales) then fSales.ResultStatus.Clear;
  if assigned(ProcTree) then begin
    if ProcTree.accesslevel = 1 then begin
      ProcTree.CalcPrice;
      ProcTree.SaveNoCheck;
    end;
    TfmsaleslineManufactureTotalQtyEdit.EditsaleslineManufactureTotalQty(TERPConnection(fSales.Lines.Connection.Connection) , fSales.Lines.ID, ProcTree);
  end;
end;

Procedure TProcessSalesFormExtender.DoMenuItemCapacityPlannerClick(Sender: TObject);
begin

  if Assigned(Form) and (form is TBaseSaleGUI) then begin
    if MessageDlgXP_Vista('This will save and close the transaction record before opening the capacity planner.'+NL+NL+'Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
      if not TBaseSaleGUI(form).SaveSalesRecord then exit;
      openERPForm('TfmProcCapacityPlanning' , 0, nil, initCapacityplanner);
      TBaseSaleGUI(form).btnCompleted.Click; // close the form so that the capacity planner can update the sales record
  end;
end;
Function TProcessSalesFormExtender.FirstSaleProcessPart :TDateTime;
begin
  with Sales.GetNewDataSet('Select '+
                           ' min(pp.timestart) as timestart '+
                           ' from tblSaleslines SL '+
                           ' inner join tblprocTree PT on SL.SaleLineId	= PT.masterID and 	PT.Mastertype <> "mtProduct" '+
                           ' inner join tblProcessPart PP on PP.ProcTreeId = PT.ProcTreeId and   (PP.timestart > "1899-12-30 00:00:00" or PP.timeend > "1899-12-30 00:00:00") '+
                           ' inner join tblProcessTime PCT on PCT.ProcessPartId = PP.ID  and not(PCT.timestart = "1899-12-30 00:00:00" and PCT.timeend = "1899-12-30 00:00:00" and PCT.duration =0) '+
                           ' where SL.SaleId = '+ inttostr(Sales.ID), true) do try
    REsult :=  fieldbyname('timestart').asDatetime;

  finally
      if active then close;
      free;
  end;

end;
procedure TProcessSalesFormExtender.initCapacityplanner(Sender: TObject);
begin
  if not(Sender is   TfmProcCapacityPlanning) then exit;
  TfmProcCapacityPlanning(Sender).CapacityPlannerDateFrom := FirstSaleProcessPart;
  TfmProcCapacityPlanning(Sender).chkShowFinalised.checked := True;// include the completed as well in the list
  TfmProcCapacityPlanning(Sender).SalesOrderId := Sales.id;
end;
procedure TProcessSalesFormExtender.initBOMPLanner(Sender: TObject);
begin
  //
end;
procedure TProcessSalesFormExtender.DoMenuItemResourceCapcityClick(Sender: TObject);
begin
  openERPListform('TBOMSaleResourceCheckGUI' , BeforeShowSalesPurchaseOrderList);
end;
procedure TProcessSalesFormExtender.DoMenuItemProcessTreeClick(Sender: TObject);
begin
  doProcessTree(Sender , -1 , '');
end;
Procedure TProcessSalesFormExtender.DoBOMSalesProgressReport(Sender: TObject);
begin
  openERPListform('TBOMSalesProgressReportGUI' , BeforeShowSalesPurchaseOrderList);
end;
(*Procedure TProcessSalesFormExtender.DoProcessSchedulesClick(Sender: TObject);
begin
  openERPListform('TBOMSaleProcessScheduleGUI' , BeforeShowTBOMSaleProcessSchedule);
end;
Procedure TProcessSalesFormExtender.BeforeShowTBOMSaleProcessSchedule(Sender :TObject);
begin
  if sender is  TBOMSaleProcessScheduleGUI then
    TBOMSaleProcessScheduleGUI(Sender).saleId := sales.ID;
end;*)
Procedure TProcessSalesFormExtender.DoMenuItemProcessTreeHiddenClick(Sender: TObject);
begin
  doProcessTree(Sender , cQtyColumn , 'Please Change the Quantity Column if required');
end;
procedure TProcessSalesFormExtender.doProcessTree(Sender: TObject; Highlightcolumn:Integer ; HighlightcolumnMsg :String);
begin
  if Assigned(fSales) then fSales.ResultStatus.Clear;
  PerformPaints;
  DisplayProcTreeEdit(False , Highlightcolumn , HighlightcolumnMsg);
end;

Procedure TProcessSalesFormExtender.DoMenuItemProductionSchedulingClick(Sender: TObject);
begin
  if Assigned(Form) and (form is TBaseSaleGUI) then begin
    if MessageDlgXP_Vista('This will save and close the transaction record before opening the capacity planner.'+NL+NL+'Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
      if not TBaseSaleGUI(form).SaveSalesRecord then exit;
      openERPForm('TfmBOMPlanner' , 0, nil, initBOMPLanner);
      TBaseSaleGUI(form).btnCompleted.Click; // close the form so that the capacity planner can update the sales record
  end;
end;

Procedure TProcessSalesFormExtender.DoMenuItemPrintJobDetailsClick(Sender: TObject);
begin
  if Assigned(Form) and (form is TSalesOrderGUI) then begin
    TSalesOrderGUI(form).PrintJobDetailsofLine;
    (*if MessageDlgXP_Vista('This will save and close the transaction record before opening the capacity planner.'+NL+NL+'Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
      if not TBaseSaleGUI(form).SaveSalesRecord then exit;
      TBaseSaleGUI(form).CommitTransaction;
      try
        TSalesOrderGUI(form).PrintJobDetails;
      finally
        TBaseSaleGUI(form).BeginTransaction;
      end;*)
  end;

end;
Procedure TProcessSalesFormExtender.DoMenuItemFinaliseTreeClick(Sender: TObject);
begin
  if Assigned(fSales) then fSales.ResultStatus.Clear;
  if Assigned(fSales) then
    if MessageDlgXP_Vista('If you finalise, wastage report for ' + FSales.lines.Productname +' will be caculated on basis of the finalised Sales order. Are you sure to finalise it?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
      fSales.Lines.FinaliseTree;
      if MessageDlgXP_Vista(fSales.Lines.Productname +' is being finalised. Do you wish to recalculate the Price/cost based on the current selection?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
        fSales.Lines.CalcTreePrice;
    end;
end;
procedure TProcessSalesFormExtender.DoMenuItemPurchaseOrdersClick(
  Sender: TObject);
begin
  if Assigned(fSales) then fSales.ResultStatus.Clear;
  openERPListform('TSalesPurchaseOrderListGUI' , BeforeShowSalesPurchaseOrderList);
end;

procedure TProcessSalesFormExtender.DoMenuItemRecalcClick(Sender: TObject);
begin
  if Assigned(fSales) then fSales.ResultStatus.Clear;
  if Assigned(fSales) then begin
    fSales.Lines.CalcTreePrice;
  end;
end;

procedure TProcessSalesFormExtender.DoMenuPopup(Sender: TObject);
var
  MenuItem: TMenuItem;
  function IsProctreeActive:Boolean;
  begin
    result := (not(ProcTree is TSalesLineProcTree) or TSalesLineProcTree(ProcTree).BOMGroupedLine=False or TSalesLineProcTree(ProcTree).BOMProductionLine =True);
  end;
  function isSalesfinalised:Boolean;
  begin
    result := False;
    if assigned(fSales) then
      result := fSales.converted;
  end;
begin
  if Assigned(fSales) then fSales.ResultStatus.Clear;
  if Sender is TAdvPopupMenu then begin
    if Assigned(SavedOnPopup) then
      SavedOnPopup(Sender);

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Process Tree');
    if Assigned(MenuItem) then begin
      MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '');
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '');
    end;

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Resource Capacity');
    if Assigned(MenuItem) then begin
      MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '') and not(fSales.converted);
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '');
    end;

    (*MenuItem := TAdvPopupMenu(Sender).Items.Find('Schedule List');
    if Assigned(MenuItem) then begin
      MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '');
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '');
    end;*)

    MenuItem := TAdvPopupMenu(Sender).Items.Find('BOM Sales Progress Report');
    if Assigned(MenuItem) then begin
      MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '');
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '');
    end;

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Production Scheduling');
    if Assigned(MenuItem) then begin
      MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '');
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '');
    end;

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Print Job Details');
    if Assigned(MenuItem) then begin
      MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '');
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '');
    end;

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Capacity Planner');
    if Assigned(MenuItem) then begin
      MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '');
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '');
    end;

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Manufacture Summary');
    if Assigned(MenuItem) then begin
      MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '');
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '');
    end;

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Edit Manufacture Quantity');
    if Assigned(MenuItem) then begin
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '')  and (ProcTree.mastertype = mtsalesorder) and IsProctreeActive and not(isSalesfinalised);
      MenuItem.Enabled := MenuItem.Visible;
    end;

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Finalise for Production');
    if Assigned(MenuItem) then begin
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '')  and (ProcTree.mastertype = mtsalesorder) and IsProctreeActive and not(isSalesfinalised);
      MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '') and (ProcTree.mastertype = mtsalesorder) and (assigned(Form)) and (Form.AccessLevel =1) and IsProctreeActive;
    end;

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Recalculate Price From Tree');
    if Assigned(MenuItem) then begin
      MenuItem.Visible := (ProcTree <> nil) and (ProcTree.Caption <> '')  and (ProcTree.mastertype = mtsalesorder) and IsProctreeActive;
      MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '')  and (ProcTree.mastertype = mtsalesorder) and (assigned(Form)) and (Form.AccessLevel =1) and IsProctreeActive;
    end;

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Smart Orders');
    if Assigned(MenuItem) then begin
        MenuItem.visible := (ProcTree <> nil) and (ProcTree.Caption <> '') and (ProcTree.mastertype = mtsalesorder) and IsProctreeActive;
        MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '') and (ProcTree.mastertype = mtsalesorder)and IsProctreeActive;
    end;

    MenuItem := TAdvPopupMenu(Sender).Items.Find('Purchase Orders');
    if Assigned(MenuItem) then begin
        MenuItem.visible := (ProcTree <> nil) and (ProcTree.Caption <> '') and (ProcTree.mastertype = mtsalesorder) and IsProctreeActive;
        MenuItem.Enabled := (ProcTree <> nil) and (ProcTree.Caption <> '') and (ProcTree.mastertype = mtsalesorder) and IsProctreeActive;
    end;
  end;
end;

//procedure TProcessSalesFormExtender.DoProductCloseUp(Sender: TObject; LookupTable,
//  FillTable: TDataSet; Modified: Boolean);
//var
//  BusObjEvnt: TBusObjEvent;
//begin
//  LogD('TProcessSalesFormExtender.DoProductCloseUp',lbBegin);
//  try
//    { call saved forms handler first }
//    if Assigned(SavedOnCloseUp) then
//      SavedOnCloseUp(Sender,LookupTable,FillTable,Modified);
//
//    if not Modified then
//      exit;
//
//    if Assigned(ProcTree) and (ProcTree.Children.Count > 0) then begin
//      if Sales.Lines.QtyShipped = 0 then begin
//        BusObjEvnt:= Sales.BusObjEvent;
//        try
//          { Stop the on change events of qty from poping up the pqa batch/bin/sn
//            form }
//          Sales.BusObjEvent:= nil;
//          Sales.InternalQuantityChange:= true;
//          try
//            if Sales.Lines.QtySold = 0 then
//              Sales.Lines.QtySold:= 1;
//            Sales.Lines.QtyShipped:= Sales.Lines.QtySold;
//          finally
//              Sales.InternalQuantityChange:= False;
//          end;
//        finally
//          Sales.BusObjEvent:= BusObjEvnt;
//        end;
//      end;
//      if (ProcTreeHasOptions(ProcTree)) or (ProcTreeHasCustoms(ProcTree)) then
//        DisplayProcTreeEdit;
//    end;
//  finally
//    LogD('',lbEnd);
//  end;
//end;

procedure TProcessSalesFormExtender.DoLineDeleteClick(
  Sender: TObject);
//var
//  Status: TProcessPartStatusList;
begin
  { allow delete regardless of status! }
  SavedLineDelete(Sender);

//  if (Sales.IsSalesOrder) and (ProcTree.Children.Count > 0) then begin
//    Status:= [];
//    ProcTree.ProcessStatus(Status);
//    if psScheduled in Status then
//      CommonLib.MessageDlgXP_Vista('Can not delete line as production has been scheduled for this item.',mtInformation,[mbOk],0)
//    else if psStarted in Status then
//      CommonLib.MessageDlgXP_Vista('Can not delete line as production has started for this item.',mtInformation,[mbOk],0)
//    else if psComplete in Status then
//      CommonLib.MessageDlgXP_Vista('Can not delete line as production has been completed for this item.',mtInformation,[mbOk],0)
//    else
//      SavedLineDelete(Sender);
//  end
//  else begin
//    SavedLineDelete(Sender);
//  end;
end;

procedure TProcessSalesFormExtender.DoCopyToInvoiceClick(Sender: TObject);
begin
  if SaleContainsManufacturing(Sales.Id, Form.MyConnection) then begin
    CommonLib.MessageDlgXP_Vista('Can not convert to Invoice as this sale contains production items.',mtInformation,[mbOk],0)
  end
  else
    SavedCopyToInvoice(Sender);
end;

function TProcessSalesFormExtender.GetProcTree: TProcTreeNode;
begin
  result := nil;
  if Sales.Lines.isTreeItem = False then exit;
  if Sales.Lines is TSalesLine then TSalesLine(Sales.Lines).InstantiateTree;
  result:= TSalesLineProcTree(Sales.Lines.Container.ItemByClass(TSalesLineProcTree));
end;

function TProcessSalesFormExtender.GetSales: TSales;
begin
  if not Assigned(fSales) then begin
    fSales:= TSales(FindChildComponent(Form, 'QuoteObj'));
  if not Assigned(fSales) then
    fSales:= TSales(FindChildComponent(Form, 'SalesOrderObj'));
  if not Assigned(fSales) then
    fSales:= TSales(FindChildComponent(Form, 'InvoiceObj'));
  end;
  result:= fSales;
end;

procedure TProcessSalesFormExtender.GlobalEventHandler(const Sender: TObject;
  const Event: string; const Data: Pointer);
begin
  if Sender = Sales.Lines then  begin
    fTimer.Enabled:= false;
    fTimer.OnTimer:= DoProductSelect;
    fTimer.Interval:= 20;
    fTimer.Enabled:= true;
  end;
end;

procedure TProcessSalesFormExtender.DoProductSelect(sender: TObject);
var
  BusObjEvnt: TBusObjEvent;
begin
  TTimer(Sender).Enabled:= false;
  if Assigned(ProcTree) and (ProcTree.Children.Count > 0) then begin
    if Sales.Lines.QtyShipped = 0 then begin
      BusObjEvnt:= Sales.BusObjEvent;
      try
        { Stop the on change events of qty from poping up the pqa batch/bin/sn
          form }
        Sales.BusObjEvent:= nil;
        Sales.InternalQuantityChange:= true;
        try
          if Sales.Lines.QtySold = 0 then begin
            if Sales.Lines.QtySold<> 1 then Sales.Lines.QtySold:= 1;
            if Sales.Lines.QtyShipped<> Sales.Lines.QtySold then Sales.Lines.QtyShipped:= Sales.Lines.QtySold;
          end;
          Sales.Lines.updaterelatedPartsQty;
          Sales.Lines.DoProductSelect;
        finally
            Sales.InternalQuantityChange:= False;
        end;
      finally
        Sales.BusObjEvent:= BusObjEvnt;
        Sales.Sendevent(BusObjEvent_Change, BusObjEvent_OnCalcOrderTotals, Sales.Lines);
        Sales.Sendevent(BusObjEvent_Change, BusObjEvent_OnTreeCreated, Sales.Lines)
      end;
    end;
    //if (ProcTreeHasOptions(ProcTree)) or (ProcTreeHasCustoms(ProcTree)) then
      DisplayProcTreeEdit(True);
  end;
end;

{ TSaleLineAddList }

constructor TSaleLineAddList.Create;
begin
  inherited Create;
  fList:= TObjectList.Create(true);
end;

destructor TSaleLineAddList.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TSaleLineAddList.Add(const AddType: TSaleLineAddRecType;
  const aNodeId: integer; const aNodeQty: double; const aNodePartsId: integer; const aSalesLineId: integer);
var
  newrec: TSaleLineAddRec;
begin
  newrec:= TSaleLineAddRec.Create;
  newRec.AddRemoveType:= AddType;
  newrec.NodeId:= aNodeId;
  newRec.NodeQty:= aNodeQty;
  newRec.NodePartsId:= aNodePartsId;
  newrec.SalesLineId:= aSalesLineId;
  fList.Add(newrec);
end;

function TSaleLineAddList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TSaleLineAddList.GetItem(const index: integer): TSaleLineAddRec;
begin
  result:= TSaleLineAddRec(fList[index]);
end;

procedure TSaleLineAddList.Clear;
begin
  fList.Clear;
end;
class procedure TSaleLineAddList.UpdateSaleFromTree(const aLine: TSalesLineBase);
var
  al: TSaleLineAddList;
  y: integer;
  aTree: TSalesLineProcTree;
  currNode: TProcTreeNode;

  procedure CheckNode(const subNode: TProcTreeNode);
  var x: integer;
  begin
    if subNode.AddToSale or (subNode.IsOptionItem and subNode.ParentNode.AddToSale) then begin
      if subNode.IsOptionItem then begin
        if subNode.Selected and (subNode.LinkedLineId = 0) then
          { an item to be added/updated to sale}
          al.Add(artAdd,subNode.Id,subNode.Quantity,subNode.PartsId,subNode.LinkedLineId)
        else if (not subNode.Selected) and (subNode.LinkedLineId <> 0) then
          { line to be deleted }
          al.Add(artDelete,subNode.Id,subNode.Quantity,subNode.PartsId,subNode.LinkedLineId);
      end
      else if subNode.InputType <> itOption then begin
        if (subNode.LinkedLineId = 0) then
          { an item to be added/updated to sale}
          al.Add(artAdd,subNode.Id,subNode.Quantity,subNode.PartsId,subNode.LinkedLineId);
      end;
    end;
    for x:= 0 to subNode.Children.Count -1 do
      CheckNode(TProcTreeNode(subnode.Children[x]));
  end;

begin
  aTree:= TSalesLineProcTree(aLine.Container.ItemByClass(TSalesLineProcTree));

  if not TreeHasAddToSaleNodes(aTree) then exit;
  aTree.SaveNoCheck;
  al:= TSaleLineAddList.Create;
  try
    al.SalesLineId:= aLine.Id;
    CheckNode(aTree);
    if al.Count > 0 then begin
      {first update the sales lines}
      for y:= 0 to al.Count -1 do begin
        if al[y].AddRemoveType = artDelete then begin
          if aLine.Dataset.Locate('SaleLineId',al[y].SalesLineId,[]) then begin
            aLine.Deleted:= True;
            aLine.PostDb;
            al[y].SalesLineId:= 0;
          end;
        end
        else if (al[y].AddRemoveType = artAdd) and (al[y].NodePartsId > 0) then begin
          aLine.New;
          aLine.ProductId:= al[y].NodePartsId;
          aLine.UOMQtySold := al[y].NodeQty;
          aLine.UOMQtyShipped := al[y].NodeQty;
          aLine.PostDB;
          al[y].SalesLineId:= aLine.Id;
        end;
      end;
      { now reposition dataset back to trees line and update the tree }
      if aLine.Dataset.Locate('SaleLineId',al.SalesLineId,[]) then begin
        aTree:= TSalesLineProcTree(aLine.Container.ItemByClass(TSalesLineProcTree));
        for y:= 0 to al.Count -1 do begin
          currNode:= TProcTreeNode(aTree.NodeById(al[y].NodeId));
          if Assigned(currNode) then
            currNode.LinkedLineId:= al[y].SalesLineId;
        end;
      end;
    end;
  finally
    al.Free;
  end;
end;

initialization

  RegisterClassOnce(TProcessSalesFormExtender);
  ClassExtenderList.AddExtender('TQuoteGUI','TProcessSalesFormExtender');
  ClassExtenderList.AddExtender('TSalesOrderGUI','TProcessSalesFormExtender');
  //ClassExtenderList.AddExtender('TInvoiceGUI','TProcessSalesFormExtender');

end.
