unit ProductionPartsStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  BusObjPublicHolidays, StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  IntegerListObj, DAScript, MyScript, DNMAction , BomreportBase, wwcheckbox, CustomInputBox;

type
  TProductionPartStatusGUI = class(TBomreportBaseGUI)
    qryMainCriticalOrderDate: TDateField;
    qryMainPartsId: TIntegerField;
    qryMainId: TIntegerField;
    qryMainSaleCustomerName: TWideStringField;
    qryMainPartname: TWideStringField;
    qryMainPartsDescription: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainQuantity: TFloatField;
    qryMainTotalQty: TFloatField;
    qryMainSaleID: TIntegerField;
    qryMainSaleDocNumber: TWideStringField;
    qryMainSaleClassId: TIntegerField;
    qryMainSaleShipDate: TDateField;
    qryMainSaleLineID: TIntegerField;
    qryMainLineProductName: TWideStringField;
    qryMainLineProductDescription: TWideStringField;
    qryMainLineQty: TFloatField;
    qryMainLineShipDate: TDateTimeField;
    qryMainProcTreeId: TIntegerField;
    qryMainStatus: TWideStringField;
    qryMainTotalScheduled: TFloatField;
    qryMainProcessstart: TDateTimeField;
    qryMainNormalDeliveryTime: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainAllocationWarningDays: TIntegerField;
    qryMainParentID: TIntegerField;
    qryMainSelected: TWideStringField;
    qryMainPROJECTEDQTY: TFloatField;
    qryMaincStatus: TWideStringField;
    btnPickingSlip: TDNMSpeedButton;
    qryMainSoqty: TFloatField;
    qryMainPOQty: TFloatField;
    qryMainPOReceivedQty: TFloatField;
    qryMainSOID: TIntegerField;
    qryMainPOID: TIntegerField;
    qryMainPOLineId: TIntegerField;
    btnfromStock: TDNMSpeedButton;
    qryMainUseStock: TWideStringField;
    ChkShowOrderList: TCheckBox;
    qryMainAvailableQty: TFloatField;
    qryMainETA: TDateTimeField;
    qryMainSaleDate: TDateTimeField;
    btnSelectAll: TDNMSpeedButton;
    actSelectAll: TDNMAction;
    qryMainOnOrderQty: TFloatField;
    ProquctQty: TERPQuery;
    ProquctQtyReorderAmount: TFloatField;
    ProquctQtyPreferredLevel: TFloatField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainTreefromStockQty: TFloatField;
    qryMainTreeManufactureQty: TFloatField;
    qryMainTreeOnOrderQty: TFloatField;
    qryMainSOIds: TIntegerField;
    qryMainPOIds: TIntegerField;
    qryMainPOLineIds: TIntegerField;
    btnSmartOrder: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPickingSlipClick(Sender: TObject);
    procedure btnSmartOrderClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure ChkShowOrderListClick(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    (* procedure btnfromStockClick(Sender: TObject); *)
    procedure actSelectAllExecute(Sender: TObject);
    procedure actSelectAllUpdate(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);


  private
    Holidays: TPublicHolidays;
    Tablename :string;
    OrderListFilter:String;
    SmartOrderoption:String;
    procedure setSmartOrderIds(const Value: String);
    Function UpdateSmartOrder:String;
    procedure BeforeShowPurchaseOrderList(Sender: TObject);
    procedure beforeshowSmartOrderList(Sender: TObject);
    procedure BeforeshoeSmartOrder(Sender: TObject);
    procedure beforeshowPurchase(Sender: TObject);
    Property SmartOrderIds:String write setSmartOrderIds;
    procedure ScriptBeforeExecute(Sender: TObject; var SQL: String;var Omit: Boolean);
    function CreateSmartOrder: integer;
    Procedure CreateTempTable;
    (*Procedure RemoveSmartOrdered;*)
    (* function FlagtoUseStock:String; *)
    function smartOrderQtyOption:Integer;
  Protected
    Procedure SetGridColumns;Override;
    (*Procedure IterateselectedRecordsCallback(Var abort:Boolean);Override;*)
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses pqalib, FastFuncs, ProductQtyLib, tcConst, BusObjProcPrefs, CommonLib,
  BusObjBase, CommonDbLib, frmProcCapacityPlanningPick,
  BaseInputForm, BusObjSmartOrder, CommonFormLib, tcDataUtils,  ProcessUtils,
  frmProductionPartSOOption, AppContextObj, ProductMovementList, UserLockObj,
  SmartOrderListForm, POList, frmPurchaseOrders, frmSmartOrderFrm,
  AppEnvironment;

{$R *.dfm}
procedure TProductionPartStatusGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  if grpfilters.Itemindex =1 then
      GroupFilterString := ' Processstart <> 0';
  if OrderListFilter <>'' then begin
    if GroupFilterString <> '' then GroupFilterString := GroupFilterString +' and ';
      GroupFilterString := GroupFilterString+ OrderListFilter;
  end;
  inherited;
end;

procedure TProductionPartStatusGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Sysutils.SameText(Field.fieldname , 'ProcessStart') then begin
    if Field.AsdateTime = 0 then Afont.Color := ABrush.color;
  end else if Sysutils.SameText(Field.fieldname , 'FromstockQty') or
    Sysutils.SameText(Field.fieldname , 'TreeManufactureQty') or
    Sysutils.SameText(Field.fieldname , 'TreeOnOrderQty') then begin
    if Field.asFloat= 0 then Afont.Color := ABrush.color;
  end;
  if qryMainCriticalOrderDate.asDateTime <> 0 then
    AFont.Color := clRed;
end;

procedure TProductionPartStatusGUI.RefreshQuery;
begin

  if Holidays = nil then begin
    Holidays:= TPublicHolidays.create(Self);
    Holidays.connection := TmydacDataconnection.create(Holidays);
    Holidays.connection.connection :=GetNewMyDacConnection(Holidays);
    Holidays.Load;
  end;
  Qrymain.Params.Parambyname('DateFrom').asdatetime := FilterDateFrom;
  Qrymain.Params.Parambyname('DateTo').asdatetime := FilterDateTo;
  ChkShowOrderListClick(ChkShowOrderList);
  inherited;
  TDateTimefield(qryMainProcessstart).DisplayFormat := FormatSettings.ShortDateformat;
end;

procedure TProductionPartStatusGUI.qryMainCalcFields(DataSet: TDataSet);
var
  dt:TDatetime;
begin
  inherited;
  if qryMainProcessstart.asDateTime <> 0 then begin
    dt:= qryMainProcessstart.asDateTime - QrymainNormalDeliveryTime.asInteger - QrymainAllocationWarningDays.asInteger;
    while (DayOfWeek(dt) in [1,7]) or Holidays.IsHoliday(dt) do
      dt:= dt -1;
    qryMainCriticalOrderDate.asDateTime := dt;
  end;
end;

procedure TProductionPartStatusGUI.FormCreate(Sender: TObject);
begin
  Holidays := nil;
  CreateTempTable;
  Qrymain.Disablecontrols;
  try
    CloseDB(Qrymain);
    Qrymain.SQL.clear;
    Qrymain.SQL.add('Select * ');
    Qrymain.SQL.add('from ' + Tablename );
    Qrymain.SQL.add('where selected = "T" and ifnull(PartsId,0)<> 0 /*and PArentID<> 0*/ and SaleShipDate between :DateFrom and :DateTo');
    Qrymain.SQL.add('Order by saleId desc ');
  finally
      Qrymain.enablecontrols;
  end;
  inherited;
end;

procedure TProductionPartStatusGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('AllocationwarningDays');
  RemoveFieldfromGrid('ID');
  RemoveFieldfromGrid('LineQty');
  RemoveFieldfromGrid('ProcTreeId');
  RemoveFieldfromGrid('Quantity');
  RemoveFieldfromGrid('SaleclassId');
  RemoveFieldfromGrid('SaleID');
  RemoveFieldfromGrid('SaleLineId');
  RemoveFieldfromGrid('Status');
  RemoveFieldfromGrid('SOID');
  RemoveFieldfromGrid('POID');
  RemoveFieldfromGrid('POLineId');
  RemoveFieldfromGrid('SOIDs');
  RemoveFieldfromGrid('POIDs');
  RemoveFieldfromGrid('POLineIds');
  RemoveFieldfromGrid('UseStock');
end;

procedure TProductionPartStatusGUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Holidays);
  inherited;

end;

procedure TProductionPartStatusGUI.ScriptBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  inherited;
  if Assigned(ProgressDialogInst) then
    if copy(Sql, 1, 2) = '/*' then ProgressDialogInst.Message:= StringReplace(StringReplace(SQL, '/*' ,'', []), '*/' , '', []);
  DoStepProgressbar;
end;

procedure TProductionPartStatusGUI.btnPickingSlipClick(Sender: TObject);
var strSQL:String;
begin
  strSQL:= SelectedIDs('ProcTreeId', true);
  if strsql = '' then exit;
  PrintTemplateReport('Production Parts Picking Slip' , '~|||~Where PT.ProcTreeId in (' + strSQL +')'+
                                                        '~|||~Where S.saleID in (' + SelectedIDs('SaleID', true)+')'+
                                                        '~|||~ and PartsId in ('+SelectedIDs('PartsID', true) +')'+
                                                        '~|||~Where SL.saleLineID in ('+SelectedIDs('SaleLineID', true) +')' ,False ,1) ;
  CreateTempTable;
  RefreshQuery;
{var
  form: TfmProcCapacityPlanningPick;
begin
  inherited;
  form:= TfmProcCapacityPlanningPick.Create(nil);
  try
    form.DateFrom:= self.dtFrom.DateTime;
    form.DateTo:= self.dtTo.DateTime;
    form.SelectAllProcessSteps;

    form.ShowModal;
  finally
    form.Release;
  end;}
end;

procedure TProductionPartStatusGUI.btnSmartOrderClick(Sender: TObject);
var
  SmartOrderId: integer;
  Form: TBaseInputGUI;
begin
    inherited;
    if grdMain.SelectedList.Count > 0 then begin
        SmartOrderId:= CreateSmartOrder;
        if SmartOrderId > 0 then begin
            Form := TBaseInputGUI(GetComponentByClassName('TSmartOrderGUI'));
            if Assigned(Form) then begin
                Form.AttachObserver(Self);
                Form.KeyID := SmartOrderID;
                Form.FormStyle := fsMDIChild;
                Form.BringToFront;
            end;
        end;
    end else begin
      CommonLib.MessageDlgXP_Vista('No lines selected',mtInformation,[mbOk],0);
    end;
end;

function TProductionPartStatusGUI.CreateSmartOrder: integer;
var
  x: integer;
  SmartOrd: TSmartOrder;
  MsgOption :integer;
  SOQty:double;
  Procedure openProquctQty ;
  begin
     closeDB(ProquctQty);
     ProquctQty.Parambyname('ProductID').asInteger := qryMainPartsId.asInteger;
     ProquctQty.Parambyname('classId').asInteger := qryMainSaleClassid.asInteger;
     openDB(ProquctQty);
  end;
  function Qtybasedon(const Qtyoption:Integer):double;
  var
    Qty:double;
    i:Integer;
    ROAmount:double;
  begin
     Qty :=0;
     try
       if Qtyoption = 1 then Qty := qryMainAvailableQty.asFloat
       else if Qtyoption = 2 then Qty := qryMainPROJECTEDQTY.asFloat
       else if Qtyoption = 3 then Qty := qryMainAvailableQty.asFloat + QrymainOnOrderQty.asFloat //qryMainPOQty.asFloat
       else if Qtyoption = 4 then Qty := qryMainPROJECTEDQTY.asFloat + QrymainOnOrderQty.asFloat;//qryMainPOQty.asFloat;

       if Qty<> 0 then begin
          if Qty > ProquctQtyPreferredLevel.asfloat then Qty :=0
          else begin
            Qty := ProquctQtyPreferredLevel.asfloat - Qty;
            ROAmount :=ProquctQtyReorderAmount.asfloat;
            if ROAmount = 0 then ROAmount := 1;
              i := trunc(qty/ROAmount);
              if i*ROAmount = Qty then else Qty := (i+1)*ROAmount;
          end;
       end;
     finally
      result := qty;
     end;
  end;
begin
  result:= 0;
  if grdMain.SelectedList.Count > 0 then begin
    MsgOption := smartOrderqtyOption;

    if MsgOption = -1 then begin
      exit;
    end;

      grdMain.DataSource.DataSet.DisableControls;
      SmartOrd:= TSmartOrder.Create(nil);
      try
        SmartOrd.Connection           := TMyDacDataConnection.Create(SmartOrd);
        SmartOrd.Connection.Connection:= CommonDbLib.GetNewMyDacConnection(SmartOrd);
        SmartOrd.Connection.BeginTransaction;
        SmartOrd.Load(0);
        SmartOrd.New;
        SmartOrd.SmartOrderDesc:= 'Production Requirements';
        SmartOrd.PostDb;
        for x:= 0 to grdMain.SelectedList.Count -1 do begin
          grdMain.DataSource.DataSet.GotoBookmark(grdMain.SelectedList[x]);
          SOQty := 0;
          if MsgOption = 0 then
             SOQty := qryMainTotalQty.asFloat
          else begin
            openProquctQty;
                 if MsgOption = 1 then SOQty          := Qtybasedon(1)
            else if MsgOption = 2 then SOQty          := Qtybasedon(2)
            else if MsgOption = 3 then SOQty          := Qtybasedon(3)
            else if MsgOption = 4 then SOQty          := Qtybasedon(4);
          end;
          if SOQty > 0 then begin
            SmartOrd.Lines.New;
            SmartOrd.Lines.PARTSID      := qryMainPartsId.asInteger;
            SmartOrd.Lines.CusJobName   := qryMainSaleCustomerName.asString;
            SmartOrd.Lines.ProcTreeId   := qryMainProcTreeId.asInteger;
            SmartOrd.Lines.SaleLineID   := qryMainSaleLineID.asInteger;
            SmartOrd.Lines.ClassID      := qryMainSaleClassId.asInteger;
            SmartOrd.Lines.ToPurchaseQtyexWastagePercentage(*ToPurchaseQty*):= SOQty;
            SmartOrd.Lines.PostDb;
          end;
        end;
        if SmartOrd.Lines.count = 0 then begin
          result:= 0;
          CommonLib.MessageDlgXP_Vista('Nothing is to Be Ordered For The Selected Transactions As Per The Selected '+
                                      'Smart Order Option  :' + chr(13) +QuotedStr(SmartOrderoption) + '.',mtInformation,[mbOk],0);

        end else
          if SmartOrd.ValidateData and SmartOrd.Save then begin
            result:= SmartOrd.Id;
            SmartOrd.Connection.CommitTransaction;
          end;
      finally
        SmartOrd.Connection.RollbackTransaction;
        freeandnil(SmartOrd);
        grdMain.DataSource.DataSet.EnableControls;
      end;
  end;


end;

procedure TProductionPartStatusGUI.CreateTempTable;
var
  MaxLevel:Integer;
  i:Integer;
begin
  Tablename := CommonDbLib.CreateUserTemporaryTable('tmp_ProductionPartList');
  (*Holidays := nil;*)
  With CommonDbLib.TempMyQuery do try
    SQL.add('select Max(Level) Level from tblProcTree where Complete ="F"');
    Open;
    MaxLevel := fieldByname('Level').asInteger;
  Finally
      if active then close;
      Free;
  end;
  with CommonDbLib.TempMyScript do try
    SQL.clear;
    SQL.add('/*Create Temporary Table*/;');
    SQL.add('truncate ' + tablename +' ;');
    SQL.add('  /*Populate Temporary Table*/;');
    SQL.add('insert into ' + tablename +''+
           '  (PartsId,Id,SaleCustomerName,Partname,PartsDescription,Description,'+
           '  Quantity,TotalQty,'+
           '  TreefromStockQty,TreeManufactureQty,TreeOnOrderQty,'+
           '  SaleID,SaleDocNumber,SaleClassId,SaleDate, SaleShipDate,SaleLineID,LineProductName,'+
           '  LineProductDescription,LineQty,LineShipDate,ProcTreeId,Status,TotalScheduled,Processstart,NormalDeliveryTime,'+
           '  UOM,AllocationWarningDays,ParentID, '+
           '  Selected)'+
           '  SELECT '+
           '  pt.PartsId,PP.Id, s.CustomerName AS SaleCustomerName,'+
           '  P.PARTNAME AS Partname, P.PARTSDESCRIPTION AS PartsDescription,'+
           '  PS.Description, pt.Quantity*ifnull(PTP.UnitOfMeasureMultiplier,1), '+
           '  pt.TotalQty*ifnull(PTP.UnitOfMeasureMultiplier,1), '+
           ' PT.FromStockQty , PT.ManufactureQty , PT.OnOrderQty,'+
           ' s.SaleID,s.InvoiceDocNumber AS SaleDocNumber,'+
           '  s.ClassID AS SaleClassId,s.Saledate, s.ShipDate AS SaleShipDate,sl.SaleLineID,'+
           '  sl.ProductName AS LineProductName,sl.Product_Description AS LineProductDescription,'+
           '  sl.UnitofMeasureShipped AS LineQty,sl.ShipDate AS LineShipDate,'+
           '  pt.ProcTreeId,PP.Status,Sum(PTM.Duration) TotalScheduled,'+
           '  min(PTM.TimeStart) Processstart,P.NormalDeliveryTime, '+
           'ifnull(PTP.UnitOfMeasure,'+QuotedStr(AppEnv.DefaultClass.DefaultUOM)+') as UOM,' +
           IntToStr(ProcPrefs.AllocationWarningDays)+ ' as AllocationWarningDays,'+
           ' PT.ParentID,  '+
           '   "T" as Selected  '+
           '  FROM'+
           '  tblSales s'+
           '  inner join  tblSalesLines sl on sl.SaleId = s.SaleId'+
           '  inner join  tblProcTree pt on pt.MasterId = sl.SaleLineId and pt.MasterType = "mtSalesOrder"'+
           ' Left join tblproctreepart PTP on PTP.ProcTreeId = PT.ProcTreeId' +
           '  Left   join  tblParts  P on P.PartsId  = pt.PartsId'+
           '  Left  JOIN tblProcessPart PP on PP.ProcTreeId = PT.ProcTreeId'+
           '  Left Join tblprocessstep PS ON PP.ProcessStepID = PS.ID'+
           '  Left join tblProcesstime PTM on PTM.ProcessPartId = PP.ID'+
           '  where  PT.Complete ="F" and S.converted ="F"'+
           '  and (SL.BOMProductionLine ="T" or SL.BOMGroupedLine="F")'+
           '  group by Pt.ProctreeId;');


           SQL.add('  /*Smart Order Quantity*/;');
    SQL.add('Drop table if exists ' +tablename +'_1;');
    SQL.add('  /*Smart Orders*/;');
    SQL.add('CREATE TABLE ' +tablename +'_1 ('+
           '    ProcTreeId      int(11) NOT NULL default 0,'+
           '    SmartOrderLineID  int(11) default NULL,'+
           '    PurchaseLineId  int(11) default NULL,'+
           '    SOID            int(11) default NULL,'+
           '    SOQty           double  NOT NULL default 0,'+
           '    POID            int(11) NOT NULL default 0,'+
           '    POLIneID        int(11) NOT NULL default 0,'+
           '    POQty           double NOT NULL default 0,'+
           '    ETA             DateTime NULL DEfault 0,'+
           '    POReceivedQty   double NOT NULL default 0'+
           '  ) ENGINE=MyIsam ;');
           
    SQL.add('insert into ' +tablename +'_1 (ProcTreeId , SmartOrderLineID , SOID , SOQty)  '+
           ' SELECT T.ProcTreeId , SmartOrderLinesID, '+
           '  SOL.SmartOrderID , SOL.UnitofMeasureQty '+
           '  FROM tblsmartorderlines AS SOL '+
           '  inner join ' +tablename +' T on SOL.ProcTreeId =T.ProcTreeId;');

    SQL.add('update ' +tablename +'_1 T inner join tblpurchaselines '+
           ' PL On PL.SmartOrderLineID = T.SmartOrderLineID Set T.PurchaseLineId = PL.PurchaseLineId;');

    SQL.add('  /*Purchase Order Quantity*/;');
    SQL.add('update ' +tablename +'_1 T  set T.POQty =ifnull(('+
           ' Select PL.UnitofMeasureQtySold '+
           ' from   tblpurchaselines '+
           ' PL where  PL.PurchaseLineId = ifnull(T.PurchaseLineId,0) ),0);');
    SQL.add('  /*Purchase Order Quantity*/;');
    SQL.add('update ' +tablename +'_1 T  set T.POreceivedQty =ifnull(( Select Sum(PL.UnitofMeasureShipped)  from   tblpurchaselines PL where  (PL.PurchaseLineId = ifnull(T.PurchaseLineId,0)) or (ifnull(PL.baselineno,0) = ifnull(T.PurchaseLineId,0) and ifnull(PL.baselineno,0) <> 0) ),0);');
    SQL.add('update ' +tablename +'_1 T  set T.ETA =( Select Max(ifnull(PL.ETADate,0))  from   tblpurchaselines PL where  (PL.PurchaseLineId = ifnull(T.PurchaseLineId,0)) or (ifnull(PL.baselineno,0) = ifnull(T.PurchaseLineId,0) and ifnull(PL.baselineno,0) <> 0) );');
    SQL.add('  /*Purchase Orders*/;');
    SQL.add('update ' +tablename +'_1 t inner join  tblpurchaselines PL on PL.PurchaseLineId = ifnull(T.PurchaseLineId,0) set T.POId = PL.PurchaseOrderId, T.POLineId = PL.PurchaseLineId;');
    SQL.add('  /*Quantity updates*/;');
    SQL.add('update ' +tablename +' T Set T.Soqty         = (select Sum(TT.Soqty)          from ' +tablename +'_1 TT where  T.ProcTreeId = TT.ProcTreeId );');
    SQL.add('update ' +tablename +' T Set T.POQty         = (Select sum(TT.POQty)          from ' +tablename +'_1 TT where  T.ProcTreeId = TT.ProcTreeId );');
    SQL.add('update ' +tablename +' T Set T.POReceivedQty = (Select Sum(TT.POReceivedQty)  from ' +tablename +'_1 TT where  T.ProcTreeId = TT.ProcTreeId );');
    SQL.add('update ' +tablename +' T inner join ' +tablename +'_1 TT on T.ProcTreeId = TT.ProcTreeId Set T.SOID = TT.SOID;');
    SQL.add('update ' +tablename +' T inner join ' +tablename +'_1 TT on T.ProcTreeId = TT.ProcTreeId Set T.POID = TT.POID;');
    SQL.add('update ' +tablename +' T inner join ' +tablename +'_1 TT on T.ProcTreeId = TT.ProcTreeId Set T.POLineID = TT.POLineID;');
    SQL.add('update ' +tablename +' T Set T.SOIDs     = (select Count(TT.SOID)      from ' +tablename +'_1 TT where  T.ProcTreeId = TT.ProcTreeId );');
    SQL.add('update ' +tablename +' T Set T.POIDs     = (select Count(TT.POID)      from ' +tablename +'_1 TT where  T.ProcTreeId = TT.ProcTreeId );');
    SQL.add('update ' +tablename +' T Set T.POLineIDs = (select count(TT.POLineID)  from ' +tablename +'_1 TT where  T.ProcTreeId = TT.ProcTreeId );');
    //SQL.add('update ' +tablename +' T inner join ' +tablename +'_1 TT on T.ProcTreeId = TT.ProcTreeId Set T.Soqty = TT.Soqty;');
    SQL.add('update ' +tablename +' T inner join ' +tablename +'_1 TT on T.ProcTreeId = TT.ProcTreeId Set T.ETA = TT.ETA;');
    (* SQL.add('  /*Use Stock Search*/;');
    SQL.add('update ' +tablename +' T inner join tblproctreepart PTP   '+
              ' on PTP.ProcTreeId =  T.ProcTreeId  '+
              ' Set T.UseStock = if(ifnull(T.SOID,0) <>0  and ifnull(PTP.UseStock,"F") = "F", "F" , PTP.UseStock)  ;'); *)

    SQL.add('/*Calculate Projected Quantity*/;');
    SQL.add('drop table if exists ' +tablename +'_1;');
    SQL.add('create table ' + tablename +'_1  ' +
              ' Select distinct PQA.ProductId, PQA.DepartmentId, ' + SQL4Qty(tInstock)+' as Qty '+
               ' from tblPQa PQA  Where ProductId in (Select PartsId from ' +tablename + ' T )'+
              ' group by PQA.ProductId, PQA.DepartmentId;');
    SQL.add('update ' + tablename +'  T  '+
              ' inner join ' + tablename +'_1  T1 on T1.ProductId = T.PartsId and T.SaleClassId = T1.DepartmentID'+
           '  Set T.ProjectedQty = T1.Qty;');

    SQL.add('/*Calculate Available Quantity*/;');
    SQL.add('drop table if exists ' +tablename +'_1;');
    SQL.add('create table ' + tablename +'_1  ' +
              ' Select PQA.ProductId, PQA.DepartmentId, ' + SQL4Qty(tAvailable)+' as Qty '+
              ' from tblPQa PQA  Where ProductId in (Select PartsId from ' +tablename + ' T )'+
              ' group by PQA.ProductId, PQA.DepartmentId;');
    SQL.add('update ' + tablename +'  T  '+
              ' inner join ' + tablename +'_1  T1 on T1.ProductId = T.PartsId and T.SaleClassId = T1.DepartmentID'+
           '  Set T.AvailableQty = T1.Qty;');

    SQL.add('/*Calculate On-Order Quantity*/;');
    SQL.add('drop table if exists ' +tablename +'_1;');
    SQL.add('create table ' + tablename +'_1  ' +
              ' Select PQA.ProductId, PQA.DepartmentId, ' + SQL4Qty(tPOBO)+' as Qty '+
              ' from tblPQa PQA  Where ProductId in (Select PartsId from ' +tablename + ' T )'+
              ' group by PQA.ProductId, PQA.DepartmentId;');
    SQL.add('update ' + tablename +'  T  '+
              ' inner join ' + tablename +'_1  T1 on T1.ProductId = T.PartsId and T.SaleClassId = T1.DepartmentID'+
           '  Set T.OnOrderQty = T1.Qty;');

    SQL.add('drop table if exists ' +tablename +'_1;');
    SQL.add('/*Search for Details of Option Items*/;');
    SQL.add('update'+
           '  tblProcTree PT'+
           '  inner join  tblProcTree PTP on PTP.ProcTreeId = PT.ParentId and PTP.InputType = "itOption"'+
           '  inner join ' + Tablename +'  T on T.ProcTreeId = PT.ProcTreeID'+
           '  Set T.Selected ="F"'+
           '  where PT.selected = "F";');
     for i := 1 to MaxLevel do begin
        SQL.add('update'+
               '  ' + Tablename +'  Parent'+
               '  inner join ' + Tablename +'  as child on Parent.ProcTreeId = child.ParentId'+
               '  Set child.selected = "F" where Parent.Selected = "F";');
     end;
     for i := 1 to MaxLevel do begin
      SQL.add('update'+
             '  ' + Tablename +'  child'+
             '  inner join ' + Tablename +'  as Parent on Parent.ProcTreeId = child.ParentId'+
             '  Set child.status = Parent.status  '+
             '  where child.Selected = "T" '+
             '  and ifnull(child.Status ,"") = ""  '+
             '  and ifnull(Parent.Status ,"") <> "" ; ');
      SQL.add('update'+
             '  ' + Tablename +'  child'+
             '  inner join ' + Tablename +'  as Parent on Parent.ProcTreeId = child.ParentId'+
             '  Set child.Processstart = Parent.Processstart  '+
             '  where child.Selected = "T" '+
             '  and ifnull(child.Processstart ,"") = ""  '+
             '  and ifnull(Parent.Processstart ,"") <> "" ; ');
      SQL.add('update'+
             '  ' + Tablename +'  child'+
             '  inner join ' + Tablename +'  as Parent on Parent.ProcTreeId = child.ParentId'+
             '  Set child.Description = Parent.Description  '+
             '  where child.Selected = "T" '+
             '  and ifnull(child.Description ,"") = ""  '+
             '  and ifnull(Parent.Description ,"") <> "" ; ');
     end;
     showProgressbar(WAITMSG , SQL.count);
     try
      beforeExecute := ScriptBeforeexecute;
      Execute ;
     finally
         HideProgressbar;
     end;

  finally
      Free;
  end;

end;
function TProductionPartStatusGUI.UpdateSmartOrder:String;
var
  ProctreIDs:String;
  s:String;
  SaleID:Integer;
  SmartOrd: TSmartOrder;
  solocked:Boolean;
  fUserLock: TUserLock;
begin
  Result := '';
  ProctreIDs := SelectedIds('ProctreeID');
  if ProctreIDs = '' then exit;
  s:= 'Select ' +
        ' S.SAleID, S.globalref, Sl.SaleLineID, PT.ProctreeId, PT.OnOrderUOMQty, PT.OnOrderQty, PT.PartsId, S.ClassID , PT.TreePartUOMID' +
        ' from tblProctree PT inner join tblSaleslines SL on Sl.saleLineId = PT.MasterId inner join tblsales S on S.SaleId = SL.SaleID ' +
        ' where PT.ProctreeId in (' + ProctreIDs+') ' +
        ' and ifnull(PT.OnOrderQty,0)<> 0 ' +
        ' order by saleID, SaleLineId';
  With TempMyQuery do try
    SQL.add(s);
    Open;
    if recordcount =0 then exit;
    fUserLock:= TUserLock.Create(self);
    SmartOrd:= TSmartOrder.create(Self);
    try
      fuserLock.enabled:= True;
      SmartOrd.Connection           := TMyDacDataConnection.Create(SmartOrd);
      SmartOrd.Connection.Connection:= CommonDbLib.GetNewMyDacConnection(SmartOrd);
      SmartOrd.Connection.BeginTransaction;
      SmartOrd.Load(0);
      try
        First;
        SaleId := 0;
        solocked:= False;
        while Eof = False do begin
          if SaleID <> FieldByname('SAleID').asInteger then begin
            if (solocked) and (SmartOrd.Lines.count>0) then begin
              SmartOrd.save;
              if result <> '' then result := result +',';
              result := result + inttostr(SmartOrd.ID);
            end;
            SaleID :=  FieldByname('SAleID').asInteger;
            SmartOrd.LoadSelect('SaleOrderID = ' + inttoStr(saleID) +' and SalesGlobalref = ' +quotedstr(Fieldbyname('Globalref').asString));
            solocked:= fUserLock.Lock(SmartOrd.BusObjectTableName,SmartOrd.Id, SmartOrd.BusObjectTypeDescription);
          end;
          if solocked then begin
            SmartOrd.connection.BeginNestedTransaction;
            try
              if SmartOrd.count=0 then begin
                SmartOrd.New;
                SmartOrd.SaleOrderID    := SaleID;
                SmartOrd.SalesGlobalref := Fieldbyname('Globalref').asString;
                SmartOrd.SmartOrderDesc :='Production Requirements';
                SmartOrd.PostDB;
              end;
              if not(SmartOrd.Lines.Locate('SaleLineId;ProctreeId' , varArrayof([Fieldbyname('SaleLineId').asInteger,FieldByname('ProctreeId').asInteger]) , [])) then begin
                SmartOrd.Lines.New;
                SmartOrd.Lines.SaleLineID   := Fieldbyname('SaleLineId').asInteger;
                SmartOrd.Lines.ProcTreeId   := Fieldbyname('ProctreeID').asInteger;
              end;
              SmartOrd.Lines.PARTSID          := Fieldbyname('PartsID').asInteger;
              SmartOrd.Lines.UnitOfMeasureID  := Fieldbyname('TreePartUOMID').asInteger;
              SmartOrd.Lines.ClassID          := Fieldbyname('ClassID').asInteger;
              SmartOrd.Lines.ToPurchaseQtyexWastagePercentage(*ToPurchaseQty*)    := Fieldbyname('OnOrderQty').asFloat;
              SmartOrd.Lines.PostDb;
              SmartOrd.connection.CommitNestedTransaction ;
            Except
             on E:Exception do SmartOrd.connection.RollbackTransaction
            end;
          end;
          Next;
        end;
        if (solocked) and (SmartOrd.Lines.count>0) then begin
          SmartOrd.save;
          if result <> '' then result := result +',';
          result := result + inttostr(SmartOrd.ID);
        end;
        SmartOrd.Connection.CommitTransaction;
        fUserLock.Unlock;
      Except
        on E:Exception do begin
          SmartOrd.Connection.RollbackTransaction;
        end;
      end;
    finally
      Freeandnil(SmartOrd);
      Freeandnil(fUserLock);
    end;
  finally
    ClosenFree;
  end;

end;
procedure TProductionPartStatusGUI.DNMSpeedButton1Click(Sender: TObject);
begin
    inherited;
    if grdMain.SelectedList.Count > 0 then begin
        SmartOrderIds:= UpdateSmartOrder;
    end else begin
      CommonLib.MessageDlgXP_Vista('No lines selected',mtInformation,[mbOk],0);
    end;
end;
procedure TProductionPartStatusGUI.beforeshowSmartOrderList(Sender: TObject);
begin
  if not(Sender is TSmartOrderListGUI) then exit;
  TSmartOrderListGUI(Sender).ProctreeId := QrymainproctreeID.asInteger;
end;
procedure TProductionPartStatusGUI.BeforeShowPurchaseOrderList(Sender: TObject);
begin
  if not(Sender is TPOListGUI) then exit;
  TPOListGUI(Sender).ProctreeId := QrymainproctreeID.asInteger;
end;
procedure TProductionPartStatusGUI.BeforeshoeSmartOrder(Sender: TObject);
begin
  if not(Sender is TSmartOrderGUI) then exit;
  TSmartOrderGUI(Sender).ProctreeId := QrymainproctreeID.asInteger;
end;
procedure TProductionPartStatusGUI.beforeshowPurchase(Sender: TObject);
begin
  if not(Sender is TPurchaseGUI) then exit;
  TPurchaseGUI(Sender).ProctreeId := QrymainproctreeID.asInteger;
end;

procedure TProductionPartStatusGUI.grdMainDblClick(Sender: TObject);
begin
  if TField(grdMain.GetActiveField).FieldName = 'OnOrderQty' then begin
    SubsequentID := Chr(95) + 'OnOrderRequest';
      AppContext['PartDrillInfo'].IntVar['Department'] := qryMainSaleClassId.asInteger;
  end else if TField(grdMain.GetActiveField).FieldName = 'PROJECTEDQTY' then begin
    SubsequentID := Chr(95) + 'OnOrderRequest';
  end else if TField(grdMain.GetActiveField).FieldName = 'AvailableQty' then begin
      TProductMovementForm.showList(Self, qryMainPartsId.asInteger, 0);
      Exit;
  end else if (sameText(Grdmain.GetActiveField.fieldName , 'SOQty')) and (QrymainSOIDs.ASInteger>1) then begin
    OpenERPListForm('TSmartOrderListGUI' , beforeshowSmartOrderList);
    Exit;
  end else if (sameText(Grdmain.GetActiveField.fieldName , 'SOQty')) and (QrymainSOID.ASInteger<>0) then begin
    OpenERPForm('TSmartOrderGUI' , QrymainSOID.ASInteger, nil, BeforeshoeSmartOrder );
      Exit;
  end else if ((sameText(Grdmain.GetActiveField.fieldName , 'POQty')) or (sameText(Grdmain.GetActiveField.fieldName , 'POReceivedQty')) ) and (QrymainPOIDs.ASInteger>1) then begin
     OpenERPListForm('TPOListGUI' , BeforeShowPurchaseOrderList);
    Exit;
  end else if ((sameText(Grdmain.GetActiveField.fieldName , 'POQty')) or (sameText(Grdmain.GetActiveField.fieldName , 'POReceivedQty')) ) and (QrymainPOID.ASInteger<>0) then begin
    OpenERPForm('TPurchaseGUI' , QrymainPOID.ASInteger, nil, beforeshowPurchase);
      Exit;
  end else if (sameText(Grdmain.GetActiveField.fieldName , 'saleId')) and (QrymainSaleID.ASInteger<>0) then begin
         if IsSaleinvoice(QrymainSaleID.asInteger) then OpenERPForm('TInvoiceGUI' , QrymainSaleID.ASInteger )
    else if IsSaleSO(QrymainSaleID.asInteger)      then OpenERPForm('TSalesOrderGUI' , QrymainSaleID.ASInteger );
      Exit;
  end else if (sameText(Grdmain.GetActiveField.fieldName , 'Partname')) or (sameText(Grdmain.GetActiveField.fieldName , 'Partsdescription')) then begin
    OpenERPForm('TfrmParts' , qryMainPartsId.asInteger);
      Exit;
  end else if (sameText(Grdmain.GetActiveField.fieldName , 'LineProductname')) or (sameText(Grdmain.GetActiveField.fieldName , 'LineProductDescription')) then begin
    OpenERPForm('TfrmParts' , tcdatautils.getProduct(qryMainLineProductName.asString));
      Exit;
  end;
    inherited;
end;

(*procedure TProductionPartStatusGUI.RemoveSmartOrdered;
begin
  IterateProcNo:= 1;
  IterateRecords(true);
end;
*)
(*procedure TProductionPartStatusGUI.IterateselectedRecordsCallback(
  var abort: Boolean);
begin
  inherited;
  if IterateProcNo=1 then
    if (qryMainSOID.asinteger <> 0) {or (QrymainuseStock.asBoolean)} then
      grdmain.UnselectRecord;
end;*)

procedure TProductionPartStatusGUI.ChkShowOrderListClick(Sender: TObject);
begin
  inherited;
  OrderListFilter := '';
  if ChkShowOrderList.checked then
    OrderListFilter := (* 'UseStock = "F"'; *)'TreeOnOrderQty<>0';
  grpFiltersClick(grpFilters);
end;

procedure TProductionPartStatusGUI.actRefreshQryExecute(Sender: TObject);
begin
  CreateTempTable;
  inherited;
end;

(* function TProductionPartStatusGUI.FlagtoUseStock: String;
var
  strSQL:String;
begin
  inherited;
  Result := '';
  {if grdmain.SelectedList.Count = 0 then exit;
  RemoveSmartOrdered;
  if grdmain.SelectedList.Count = 0 then begin
    CommonLib.MessageDlgXP_Vista('Smart Order is already created for these Items. Its not Possible to Flag them for "Use Stock" or "Print Picking slip"' , mtInformation, [mbok],0);
    exit;
  end;}
  result:= SelectedIDs('ProcTreeId', true);
  if result= '' then exit;
  if CommonLib.MessageDlgXP_Vista('Do You Wish To Flag the Selected Products to Use the Stock?' , mtConfirmation, [mbyes,mbNo],0) = mrNo then begin
    {REsult := '';}
    exit;
  end;
  strSQL := 'update tblproctreepart Set   UseStock ="T" where   ProcTreeId in (' + result+')';
  try
    CommonDbLib.ExecuteSQL(strSQL);
  except
      //kill exception if lock wait time out occurs
  end;
end; *)

(* procedure TProductionPartStatusGUI.btnfromStockClick(Sender: TObject);
begin
  inherited;
  FlagtoUseStock;
  CreateTempTable;
  RefreshQuery;
end; *)

procedure TProductionPartStatusGUI.actSelectAllExecute(Sender: TObject);
begin
  inherited;
  if Sysutils.SameText(actSelectAll.caption , 'Select All') then begin
    Grdmain.SelectAll;
  end else begin
    Grdmain.UnselectAll;
  end;
end;

procedure TProductionPartStatusGUI.actSelectAllUpdate(Sender: TObject);
begin
  inherited;
  if grdMain.SelectedList.Count = qrymain.RecordCount then
    actSelectAll.Caption := 'Unselect All'
  else actSelectAll.Caption := 'Select All';
  btnSelectAll.Caption :=actSelectAll.Caption;
end;

procedure TProductionPartStatusGUI.setSmartOrderIds(const Value: String);
var
    IDList :TStringlist;
    tmpComponent:TComponent;
    x:Integer;
begin
    if Value = '' then Exit;
    IDList := TStringList.Create;
    try
        FastFuncs.Split(value , ',' , IDList);
        for x := 0 to IDList.count-1 do begin
                tmpComponent    := GetComponentByClassName('TSmartOrderGUI', false);
                if assigned(tmpComponent) then begin
                    with TBaseInputGUI(tmpComponent) do begin
                        TBaseInputGUI(tmpComponent).KeyID     := FastFuncs.StrToInt(IDList[x]);
                        TBaseInputGUI(tmpComponent).FormStyle := fsMDIChild;
                        TBaseInputGUI(tmpComponent).BringToFront;
                        TBaseInputGUI(tmpComponent).Update;
                        While FormStillOpen('TSmartOrderGUI',TForm(tmpComponent)) do Begin
                            Application.ProcessMessages;
                            Sleep(100);
                        end;
                    end;
                end;
        end;
    Finally
        FreeandNil(IDList);
    end;
end;

function TProductionPartStatusGUI.smartOrderQtyOption: Integer;
begin
  result := Appenv.CompanyPrefs.SmartOrderbasedOn;
(*var
  form:TComponent;
begin
  REsult := -1;
  Form := GetComponentByClassName('TfmProductionPartSOOption');
  if not Assigned(Form) then exit;
  Try
    TfmProductionPartSOOption(Form).showModal;
    if TfmProductionPartSOOption(Form).Modalresult = mrOk then begin
      result := TfmProductionPartSOOption(Form).Msgoption;
      SmartOrderoption := TfmProductionPartSOOption(Form).rgoption.Items[TfmProductionPartSOOption(Form).rgoption.Itemindex];
    end;
   finally
      Freeandnil(Form);
   end;*)

end;

initialization
  RegisterClassOnce(TProductionPartStatusGUI);
end.


