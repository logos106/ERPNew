unit OrdersFromStock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, IntegerListObj,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup;

type
  TOrdersFromStockGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainProduct_Description: TWideStringField;
    qryMainProduct_Description_Memo: TWideMemoField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainUnitofMeasureSaleLines: TWideStringField;
    qryMainUnitofMeasureMultiplier: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainIsSalesOrder: TWideStringField;
    qryMainIsInvoice: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainProductId: TIntegerField;
    qryMainUnitOfMeasureID: TIntegerField;
    qryMainSaleLineId: TIntegerField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainDetails: TIntegerField;
    qryMainclassId: TIntegerField;
    qryMaininstock: TIntegerField;
    qryMainAvailable: TIntegerField;
    qryMainClassName: TWideStringField;
    btnfinalise: TDNMSpeedButton;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure btnfinaliseClick(Sender: TObject);
  private
    fsTablename :String;
    allLinesOk:Boolean;
    IdList: TIntegerList;
    Procedure PrintProductionWorkSheet(const SaleIDs:String);
  Protected
    Procedure SetGridColumns;override;
    procedure IterateselectedRecordsCallback(Var abort:Boolean;SelIndex:Integer);override;
    Procedure IterateselectedRecords(UseProgressbar:Boolean=False;Progressbarcaption:String='');override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses pqalib, FastFuncs, tcConst, CommonLib, BusObjSales, BusObjBase, CommonDbLib,
  DateUtils, frmSalesOrder, ProductQtyLib, ProcessDataUtils,
  frmProcCapacityPlanningWork, ProcCapacityPlanningObj, UserLockObj,
  AppEnvironment;

{$R *.dfm}

procedure TOrdersFromStockGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if Sysutils.SameText(qryMainUnitofMeasureSaleLines.asString , AppEnv.DefaultClass.DefaultUOM) then qryMainUOM.asString := AppEnv.DefaultClass.DefaultUOM
  else if qryMainUnitofMeasureMultiplier.asfloat = 1 then qryMainUOM.asString := qryMainUnitofMeasureSaleLines.asString
  else qryMainUOM.asString := qryMainUnitofMeasureSaleLines.asString+ '(' + FloatToStr(qryMainUnitofMeasureMultiplier.asfloat)  + ' of ' + AppEnv.DefaultClass.DefaultUOM+')';
end;

procedure TOrdersFromStockGUI.grdMainDblClick(Sender: TObject);
begin
    IF qryMainIsInvoice.AsBoolean then     SubsequentID := Chr(95) + 'Invoice'
    else IF qryMainIsSalesOrder.AsBoolean then     SubsequentID := Chr(95) + 'Sales Order';
    inherited;
end;

procedure TOrdersFromStockGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('IsInvoice');
  RemoveFieldfromGrid('IsSalesOrder');
  RemoveFieldfromGrid('UnitofMeasureSaleLines');
  RemoveFieldfromGrid('UnitofMeasureMultiplier');
  RemoveFieldfromGrid('ClientID');
  RemoveFieldfromGrid('ProductId');
  RemoveFieldfromGrid('UnitOfMeasureID');
  RemoveFieldfromGrid('SaleLineId');
  RemoveFieldfromGrid('ClassId');
  RemoveFieldfromGrid('Details');
end;

procedure TOrdersFromStockGUI.IterateselectedRecordsCallback(Var abort:Boolean;SelIndex:Integer);
var
  SO:TSalesOrder;
begin
  if IterateProcNo = 2 then begin
      IDList.Add(QrymainSaleId.AsInteger);
  end else begin
      allLinesOk := true;
      SO:= TSalesOrder.create(Self);
      try
        SO.connection := TMyDacDataConnection.create(SO);
        So.connection.Connection := GetNewMyDacConnection(Self);
        SO.Load(QrymainSaleId.asInteger);
        if SO is TSales then TSales(SO).InstantiateAllTrees; // load the trees to copy
        SO.SilentMode:= true;
        //TODO lock the sales before update
        So.connection.BeginTransaction;
        SO.ChangePartSourceToManufacture(qryMainSaleLineId.asInteger);
        SO.PostDB;
        SO.Save;
        So.connection.CommitTransaction;
      finally
        Freeandnil(SO);
      end;
  end;
end;

procedure TOrdersFromStockGUI.DNMSpeedButton1Click(
  Sender: TObject);
Var
  SaleIDs:String;
begin
  inherited;
    IterateProcNo := 3;
    IterateselectedRecords(True , 'Updating Sales Orders to Manufacture');
    SaleIDs := selectedIds('SaleId' ,True);
    if CommonLib.MessageDlgXP_Vista('Do You Wish To Autoschedule and Print the Production Worksheet for Sale # ' +SaleIDs+'?' , mtconfirmation , [mbYes,mbNo],0 ) = mrYes then
      PrintProductionWorkSheet(SaleIDs);
    RefreshQuery;
end;

procedure TOrdersFromStockGUI.FormCreate(Sender: TObject);
begin
  inherited;
  BaseIndexfields:= 'ProductId, ClassId, UnitOfMeasureID, details';
  fsTablename := GetUserTemporaryTableName('OrdersFromStock');
  closeDb(Qrymain);
  Qrymain.SQL.clear;

  Qrymain.SQL.add('Select T.*, C.ClassName from ' +fsTablename +' T inner join tblClass C on C.classId = T.ClassId order by ProductId, ClassId, UnitOfMeasureID, details');
  RefreshOrignalSQL;
end;

procedure TOrdersFromStockGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if QrymainDetails.asInteger = 1 then begin
        AFont.Style := AFont.Style + [fsBold];
    if (SameText(Field.Fieldname ,'CustomerName')) or
       (SameText(Field.Fieldname ,'saleId')) or
       (SameText(Field.Fieldname ,'TotalAmountInc')) (*or
       (SameText(Field.Fieldname ,'UnitofMeasureQtySold')) or
       (SameText(Field.Fieldname ,'UnitofMeasureShipped')) or
       (SameText(Field.Fieldname ,'UnitofMeasureBackorder'))*) then begin
        Afont.Color := ABrush.color;
    end;
  end else begin
    if (SameText(Field.Fieldname ,'instock')) or
       (SameText(Field.Fieldname ,'Available')) then begin
       Afont.Color := ABrush.color;
    end;
  end;
end;

procedure TOrdersFromStockGUI.grdMainMultiSelectRecord(
  Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if selecting then
    Accept := QrymainDetails.asInteger <> 1; 
end;

procedure TOrdersFromStockGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;

end;

procedure TOrdersFromStockGUI.IterateselectedRecords(
  UseProgressbar: Boolean; Progressbarcaption: String);
var
  s:String;
begin
  if IterateProcNo = 3 then allLinesOk := False;
  inherited;
  if IterateProcNo = 3 then begin
    if allLinesOk then s:='Update Sales Orders to Manufacture is Finished'
    else s:= 'No Sales Order Found To Be Updated to Manufacture';
    MessageDlgXP_Vista(s , mtinformation , [mbok] , 0);
  end;
end;

procedure TOrdersFromStockGUI.RefreshQuery;
begin
 with CommonDbLib.TempMyScript do try
    SQL.add('drop table if Exists ' + fstablename +';' );
    SQL.add('Create table '+ fstablename  );
    SQL.add('SELECT  distinct 2 as Details,"T" hasTree, S.classId, `S`.`SaleID`,');
    SQL.add('`S`.`CustomerName`,');
    SQL.add('`S`.`TotalAmountInc`,');
    SQL.add('`SL`.`ProductName`,');
    SQL.add('SL.ProductId,');
    SQL.add('Sl.SaleLineId,');
    SQL.add('`SL`.`Product_Description`,');
    SQL.add('`SL`.`Product_Description_Memo`,');
    SQL.add('`SL`.`UnitofMeasureQtySold`,');
    SQL.add('`SL`.`UnitofMeasureShipped`,');
    SQL.add('`SL`.`UnitofMeasureBackorder`,');
    SQL.add('`SL`.`UnitofMeasureSaleLines`,');
    SQL.add('`SL`.`UnitofMeasureMultiplier`,');
    SQL.add('S.IsSalesOrder, S.IsInvoice, `S`.`ClientID`, `SL`.`UnitOfMeasureID`, ');
    SQL.add('0 as instock, 0 as Available');
    SQL.add('FROM');
    SQL.add('`tblsales` AS `S`');
    SQL.add('Inner Join `tblsaleslines` AS `SL` ON `S`.`SaleID` = `SL`.`SaleID`');
    SQL.add('Inner Join `tblproctree` AS `P` ON `P`.`MasterId` = `SL`.`SaleLineID` and P.mastertype<> "mtProduct" ');
    SQL.add('AND /*P.PartSource = "psStock"*/ ifnull(P.FromStockQty,0) >0  and P.ProcTreeId in (Select PArentId from tblproctree where masterId = P.MasterId)');
    SQL.add('where ifnull(S.IsInternalOrder,"F") = "F"');
    SQL.add('and ifnull(S.Converted,"F") = "F" and `SL`.`UnitofMeasureShipped` <> 0');
    SQL.add('and S.isQuote="F" and S.ISInvoice ="F"');
    SQL.add(' Order by SaleID;');

    SQL.add('insert into  '+ fstablename  );
    SQL.add(' SELECT  distinct 2 as Details, "F" hasTree, S.classId, `S`.`SaleID`,');
    SQL.add(' `S`.`CustomerName`,');
    SQL.add(' `S`.`TotalAmountInc`,');
    SQL.add(' `SL`.`ProductName`,');
    SQL.add(' SL.ProductId,');
    SQL.add(' Sl.SaleLineId,');
    SQL.add(' `SL`.`Product_Description`,');
    SQL.add(' `SL`.`Product_Description_Memo`,');
    SQL.add(' `SL`.`UnitofMeasureQtySold`,');
    SQL.add(' `SL`.`UnitofMeasureShipped`,');
    SQL.add(' `SL`.`UnitofMeasureBackorder`,');
    SQL.add(' `SL`.`UnitofMeasureSaleLines`,');
    SQL.add(' `SL`.`UnitofMeasureMultiplier`,');
    SQL.add(' S.IsSalesOrder, S.IsInvoice, `S`.`ClientID`, `SL`.`UnitOfMeasureID`,');
    SQL.add(' 0 as instock, 0 as Available');
    SQL.add(' FROM');
    SQL.add(' `tblsales` AS `S`');
    SQL.add(' Inner Join `tblsaleslines` AS `SL` ON `S`.`SaleID` = `SL`.`SaleID`');
    SQL.add(' inner join tblparts P on P.partsId = SL.productId');
    SQL.add(' inner join tblproctree PTP on P.partsId = PTP.MasterId and mastertype ="mtProduct"');
    SQL.add(' LEft Join `tblproctree` AS `PT` ON PT.`MasterId` = `SL`.`SaleLineID`   and PT.MasterType <> "mtProduct"');
    SQL.add(' where ifnull(S.IsInternalOrder,"F") = "F"');
    SQL.add(' and ifnull(S.Converted,"F") = "F" and `SL`.`UnitofMeasureShipped` <> 0');
    SQL.add(' and S.isQuote="F" and S.ISInvoice ="F" and ifnull(PT.proctreeId,0)=0');
    SQL.add(' Order by SaleID;');

    SQL.add('insert into  '+ fstablename  );
    SQL.add('select');
    SQL.add('1 as Details,T.hasTree , ');
    SQL.add('PQA.DepartmentId as classId,');
    SQL.add('0 as `SaleID`,');
    SQL.add('"" as `CustomerName`,');
    SQL.add('0 as `TotalAmountInc`,');
    SQL.add('`PQA`.`ProductName`,');
    SQL.add('PQA.ProductId,');
    SQL.add('0 as SaleLineId,');
    SQL.add('"" as `Product_Description`,');
    SQL.add('"" as `Product_Description_Memo`,');
    SQL.add('0 as `UnitofMeasureQtySold`,');
    SQL.add('0 as `UnitofMeasureShipped`,');
    SQL.add('0 as `UnitofMeasureBackorder`,');
    SQL.add('PQA.UOM as  `UnitofMeasureSaleLines`,');
    SQL.add('PQA.UOMMultiplier as `UnitofMeasureMultiplier`,');
    SQL.add('"F" as IsSalesOrder, "F" as IsInvoice, 0 as `ClientID`, PQA.UOMID as UnitOfMeasureID,');
    SQL.add(SQL4Qty(tInStock , 'PQA' , 'PQA.UOMQty')+ ' as instock, ');
    SQL.add(SQL4Qty(tAvailable , 'PQA' , 'PQA.UOMQty')+' as Available');
    SQL.add('from tblPQA PQA inner join '+fsTablename +' T on T.ProductId = PQa.ProductID and T.classId = PQA.DepartmentId and T.UnitOfMeasureID = PQa.UOMID');
    SQL.add('where T.Details <> 1');
    SQL.add('group by PQA.ProductID, PQa.DepartmentId , PQA.UOMID;');

    SQL.add('drop table if exists '+fsTablename+'_1;');

    SQL.add('create table '+fstablename +'_1');
    SQL.add('Select ProductId ,ClassId ,UnitOfMeasureID,');
    SQL.add('Sum(UnitofMeasureQtySold) as UnitofMeasureQtySold,');
    SQL.add('Sum(UnitofMeasureShipped) as UnitofMeasureShipped,');
    SQL.add('Sum(UnitofMeasureBackorder)as UnitofMeasureBackorder');
    SQL.add('from '+fstablename );
    SQL.add('where Details = 2');
    SQL.add('group by ProductId ,ClassId ,UnitOfMeasureID;');

    SQL.add('update ' +fsTablename +' T inner join '+fsTablename +'_1 as TT on T.ProductId = TT.ProductId and TT.ClassId = T.ClassId and TT.UnitOfMeasureID = T.UnitOfMeasureID');
    SQL.add('Set T.UnitofMeasureQtySold = TT.UnitofMeasureQtySold , T.UnitofMeasureShipped = TT.UnitofMeasureShipped ,  T.UnitofMeasureBackorder = TT.UnitofMeasureBackorder  where T.DEtails = 1;');

    SQL.add('drop table if exists '+fsTablename+'_1;');

    Execute;
  finally
      Free;
  end;
  CloseDb(Qrymain);
  inherited;

end;

procedure TOrdersFromStockGUI.btnfinaliseClick(Sender: TObject);
var
  DoRefreshQuery:Boolean;
  msg: string;
begin
  inherited;
  DoRefreshQuery := False;
  try
    if grdmain.Selected.Count = 0 then exit;

    IterateProcNo := 2;
    IDList:= TIntegerlist.Create;
    try
      IterateselectedRecords;
      if IDList.count > 0 then
         if DoconvertSO(IDList) then
          DoRefreshQuery := true;
    finally
      if DoRefreshQuery then begin
        if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
      end else if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtWarning,[mbOk],0);
      IDList.Free;
    end;
  finally
      if DoRefreshQuery then
        self.RefreshQuery;
  end;

end;

procedure TOrdersFromStockGUI.PrintProductionWorkSheet(
  const SaleIDs:String);
var
  ProcCapacityPlanningWorkForm: TfmProcCapacityPlanningWork;
  ADatefrom ,ADateTo :TDateTime;
var
  Msg:String;
  Stepcount :Integer;
  conn :TERPConnection;
  UserLock: TUserLock;
begin
  StepCount := 0;
  conn := CommonDbLib.GetNewMyDacConnection(Self);
  Try
    conn.StartTransaction;
    Try
      UserLock:= TUserLock.create(Self);
      try
        Userlock.enabled := True;
        AutoScheduleProduction(Msg , StepCount , conn, Userlock);
      finally
        UserLock.Unlock(Copy(ClassName, 2, FastFuncs.Strlength(ClassName)));
        UserLock.Unlock(Self.Caption);
      end;
      if StepCount > 0 then conn.Commit
      else conn.Rollback;
    Except
          conn.Rollback;
    end;
  finally
      Freeandnil(conn);
  end;

  if StepCount = 0 then exit;

  ProcCapacityPlanningWorkForm:= TfmProcCapacityPlanningWork.Create(nil);
  try
    ProcCapacityPlanningWorkForm.CallingFormname := Self.classname;
    With CommonDbLib.TempMyQuery do try
    SQL.add('Select TimeStart, TimeEnd , ppd.ProcessStepID ' +
              ' from ' +
              ' tblSales s ' +
              ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId ' +
              ' inner join tblProcTree pt on pt.MasterId = sl.SaleLineId and PT.ParentId = 0 and pt.MasterType = "mtSalesOrder" ' +
              ' Inner JOIN tblProcessPart PPd on PPd.ProcTreeId = PT.ProcTreeId ' +
              ' where  ppd.status = "psScheduled" and pt.MasterType = "mtSalesOrder" ' +
              ' and S.SaleId in( '+SaleIDs+')');
    Open;
    if recordcount = 0 then begin
      MessageDlgXP_Vista('None Of The Selected Jobs are Scheduled.  Production Worksheet Can Only Be Printed for Scheduled Jobs' , mtInformation , [mbok], 0);
      exit;
    end;
    First;
    ADatefrom :=Fieldbyname('timestart').asDAtetime ;
    ADateTo := DAte;
    if ADateTo< ADatefrom then ADateTo := ADatefrom;
    while Eof = False do begin
        if Fieldbyname('timestart').asDAtetime < ADatefrom  then aDatefrom := Fieldbyname('timestart').asDatetime ;
        if Fieldbyname('TimeEnd').asDAtetime   > ADateto    then aDateto   := Fieldbyname('timeend').asDatetime ;
        ProcCapacityPlanningWorkForm.ProcesstepIdList.AddIfNotInList(FieldByname('ProcessStepID').asInteger);
        Next;
    end;
  finally
      if active then close;
      Free;
  end;
  if ProcCapacityPlanningWorkForm.ProcesstepIdList.IsEmpty then begin
    ProcCapacityPlanningWorkForm.Free;
  end
  else begin
    ProcCapacityPlanningWorkForm.DateFrom := aDateFrom;
    ProcCapacityPlanningWorkForm.DateTo   := aDateTo;
    ProcCapacityPlanningWorkForm.ShowModal;
  end;
  finally
     Freeandnil(ProcCapacityPlanningWorkForm);
  end;
end;

initialization
  RegisterClassOnce(TOrdersFromStockGUI);
end.
