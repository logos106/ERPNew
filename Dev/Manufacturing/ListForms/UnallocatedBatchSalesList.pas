unit UnallocatedBatchSalesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup , JSONObject, GIFImg;

type
  TUnallocatedBatchSalesListGUI = class(TBaseListingGUI)
    rgDetail: TwwRAdioGroup;
    btnAllocate: TDNMSpeedButton;
    rddatefilterOptions: TwwRAdioGroup;
    qryMainGrossWeight: TFloatField;
    qryMainID: TIntegerField;
    qryMainDetailType: TIntegerField;
    qryMainPONumber: TWideStringField;
    qryMainpqadetailsId: TIntegerField;
    qryMainpqaid: TIntegerField;
    qryMainProductId: TIntegerField;
    qryMainSaleLineID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateTimeField;
    qryMainSaleType: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainAllocationdate: TDateTimeField;
    qryMainBatchQty: TFloatField;
    qryMainBOBatchQty: TFloatField;
    qryMainCUSTFLD1: TIntegerField;
    qryMainCUSTFLD4: TIntegerField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainBatchNumber: TWideStringField;
    qryMainNettWeight: TFloatField;
    qryMainTareWeight: TFloatField;
    qryMainAllocated: TWideStringField;
    grpreportType: TwwRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgDetailClick(Sender: TObject);
    procedure btnAllocateClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure grpreportTypeClick(Sender: TObject);
  private
    fsTablename :String;
  protected
    procedure AdjustDisplayLabels; Override;
    procedure RefreshQuery; override;
    procedure SetGridColumns; override;
    function GetReportTypeID: integer; override;
    procedure MakeTemplateSQL;Override;
    function ReportJson: TJsonObject;Override;
    Procedure FreeReportJson; Override;
    procedure AdjustDisplayLabels(tmpField :TField; Var s:String);Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
  end;

implementation

uses
  PQALib, ProductQtyLib, BaseInputForm, CommonLib, BusObjSales,
  (*frmBatchNoCreateAndPrint*)frmBatchNoCreate, BusObjSaleBase, CommonFormLib, AppEnvironment,
  tcConst, TemplateReportsLib, tcDataUtils, CommonDbLib, MySQLConst, LogLib,
  saleslib;

{$R *.dfm}

procedure TUnallocatedBatchSalesListGUI.AdjustDisplayLabels;
begin
  inherited;
end;

procedure TUnallocatedBatchSalesListGUI.AdjustDisplayLabels(tmpField: TField;  var s: String);
begin
  inherited;
  if sametext(tmpField.fieldname,qryMainCUSTFLD1.fieldname)   then s:= AppEnv.Companyprefs.PQADEtailsCUSTFLD1;
  if sametext(tmpField.fieldname,qryMainCUSTFLD4.fieldname)   then s:= AppEnv.Companyprefs.PQADEtailsCUSTFLD4;
  if sametext(tmpField.fieldname,qryMainCUSTFLD5.fieldname)   then s:= 'Pallet No';
  //if sametext(tmpField.fieldname,qrymainExpirydate.fieldname) then s:= AppEnv.DefaultClass.AllocationExpiryDateName;
end;

procedure TUnallocatedBatchSalesListGUI.btnAllocateClick(Sender: TObject);
var
  Sale: TSalesBase;
begin
  inherited;
  if qryMainAllocated.AsBoolean then begin
    CommonLib.MessageDlgXP_Vista('This line has allready been fully allocated.', mtInformation, [mbOk],0);
    exit;
  end;
  if SameText(qryMainSaleType.AsString,'Sales Order') then begin
    Sale := TSalesOrder.CreateWithNewConn(nil);
  end
  else if SameText(qryMainSaleType.AsString,'Invoice') then begin
    Sale := TInvoice.CreateWithNewConn(nil);
  end
  else begin
    CommonLib.MessageDlgXP_Vista('Can not process this sales type: ' + qryMainSaleType.AsString, mtInformation, [mbOk],0);
    exit;
  end;
  try
    Sale.Load(qryMainSaleID.AsInteger);
    if Sale.Lock then begin
      try
        Sale.Lines.LocateId(qryMainSaleLineID.AsInteger);

        Sale.Connection.BeginTransaction;
        Sale.Lines.PQA.PQABatch.RefreshTotals;
        if Sale.Lines.UOMQtyShipped <> Sale.Lines.PQA.PQABatch.TotalUOMQty then begin
          case CommonLib.MessageDlgXP_Vista('Do you wish to update the Line Qty to match the Total Batch Allocation?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
            mrYes:
              begin
//                if Sale.Lines is TSalesLine then
//                  TSalesLine(Sale.Lines).Tree.QtyVariation := TSalesLine(Sale.Lines).Tree.QtyVariation +
//                    (Sale.Lines.UOMQtyShipped - Sale.Lines.PQA.PQABatch.TotalUOMQty);
                if Sale.Lines.PQA.PQABatch.TotalUOMQty > Sale.Lines.UOMQtyShipped then begin
//                  if Sale.Lines is TSalesLine then
//                    TSalesLine(Sale.Lines).Tree.QtyVariation := TSalesLine(Sale.Lines).Tree.QtyVariation +
//                      (Sale.Lines.UOMQtyShipped - Sale.Lines.PQA.PQABatch.TotalUOMQty);
                  Sale.Lines.UOMOrderQty := Sale.Lines.PQA.PQABatch.TotalUOMQty;
                  Sale.Lines.UOMQtyShipped := Sale.Lines.PQA.PQABatch.TotalUOMQty;
                end
                else begin
                  if Sale.Lines is TSalesLine then
                    TSalesLine(Sale.Lines).Tree.QtyVariation := TSalesLine(Sale.Lines).Tree.QtyVariation +
                      (Sale.Lines.PQA.PQABatch.TotalUOMQty - Sale.Lines.UOMQtyShipped);
                  Sale.Lines.UOMQtyShipped := Sale.Lines.PQA.PQABatch.TotalUOMQty;
                  Sale.Lines.UOMOrderQty := Sale.Lines.PQA.PQABatch.TotalUOMQty;
                end;
              end;
            mrNo,
            mrCancel: exit;{ do nothing }
          end;
        end;
        Sale.Lines.BatchAllocated := true;
        Sale.Lines.PostDb;
        if Sale.Save then begin
          Sale.Connection.CommitTransaction;
          Sale.Dirty := false;
          qryMain.Refresh;
        end
        else begin
          Sale.Connection.RollbackTransaction;
          exit;
        end;


      finally
        if Sale.Connection.InTransaction then
          Sale.Connection.RollbackTransaction;
        Sale.UnLock;
      end;
    end
    else begin
      CommonLib.MessageDlgXP_Vista('Can not lock the sale to update it: ' + Sale.UserLock.LockMessage, mtInformation, [mbOk],0);
    end;

  finally
    Sale.Free;
  end;
end;

procedure TUnallocatedBatchSalesListGUI.cmdNewClick(Sender: TObject);
var
  SalesOrder: TSalesOrder;
  Dofinalise :Boolean;
  DoNew :Boolean;
begin
  Dofinalise :=  False;
  DoNew :=  False;
  inherited;
  if qryMain.RecordCount > 0 then begin
    if SameText(qryMainSaleType.AsString,'Sales Order') then begin
      SalesOrder := TSalesOrder.CreateWithNewConn(nil);
      try
        SalesOrder.Load(qryMainSaleID.AsInteger);
        SalesOrder.Lines.LocateId(qryMainSaleLineID.AsInteger);
        if SalesOrder.Lines.BatchAllocated then begin
          CommonLib.MessageDlgXP_Vista('Batch Allocation has Already Been Completed for This Line.',mtInformation,[mbOk],0);
          exit;
        end;
        if SalesOrder.Lock then begin
          try
            SalesOrder.Connection.BeginTransaction;
            case DoBatch(0,SalesOrder.Lines, TERPConnection(SalesOrder.Connection.Connection ) , true,true) of
                mrOk: begin
                        SalesOrder.Connection.CommitTransaction;
                        RefreshQuery;
                        Qrymain.Locate('SaleId' , SalesOrder.ID , []);
                      end;
                mrYesToAll : begin
                            SalesOrder.Connection.CommitTransaction;
                            RefreshQuery;
                            if Qrymain.Locate('SaleId' , SalesOrder.ID , [])  then Dofinalise :=  True;
                          end;
                mrYes : begin
                            SalesOrder.Connection.CommitTransaction;
                            RefreshQuery;
                            if Qrymain.Locate('SaleId' , SalesOrder.ID , [])  then DoNew :=  True;
                          end;
                else SalesOrder.Connection.RollbackTransaction;
            end;
          finally
            SalesOrder.UnLock;
            if Dofinalise then btnAllocate.click
            else if DoNew then cmdNew.click;
          end;

        end
        else begin
          CommonLib.MessageDlgXP_Vista('Can''t edit the Sales Order at this time as it is in use: ' + SalesOrder.UserLock.LockMessage,mtInformation,[mbOk],0);
        end;
      finally
        Freeandnil(SalesOrder);
      end;
    end;
  end else begin
    MessageDlgXP_vista('Please Choose a Sale', mtInformation, [mbOK], 0);
  end;
end;


procedure TUnallocatedBatchSalesListGUI.FormCreate(Sender: TObject);
begin
  fsTablename := GetUserTemporaryTableName('uabsl');
  Qrymain.sql.clear;
  Qrymain.sql.add('Select');
  Qrymain.sql.add('*');
  Qrymain.sql.add('from '+ fstablename);
  if devmode then Qrymain.sql.add('order by SaleID desc,CustomerName,  SaleLineID')
  else Qrymain.sql.add('order by CustomerName, SaleID, SaleLineID');
  inherited;
  //rddatefilterOptions.items[1]:= AppEnv.DefaultClass.AllocationExpiryDateName;
end;

procedure TUnallocatedBatchSalesListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fstablename);
  inherited;

end;

procedure TUnallocatedBatchSalesListGUI.FormShow(Sender: TObject);
begin
  inherited;
  //rddatefilterOptions.itemindex := 0;
  //GuiPrefs.DbGridElement[grdMain].RemoveFields('SaleID,DetailType');
end;

function TUnallocatedBatchSalesListGUI.GetReportTypeID: integer;
begin
  if grpreportType.itemindex = 0 then result := 174 else Result := 172;
end;

procedure TUnallocatedBatchSalesListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if grpfilters.itemindex = 2 then
    if QrymainAllocated.asBoolean then
      DoGreenhighlight(AFont,ABrush);

  if (rgDetail.itemindex =0) and (sametext(field.fieldname , qrymaincustfld5.fieldname)) then
    DoHide(Field,State,AFont,ABrush);

end;

procedure TUnallocatedBatchSalesListGUI.grdMainDblClick(Sender: TObject);
begin
  if SalesLineRootNodeId(qrymainsalelineID.asInteger) >0 then
       SubsequentID := Chr(95) + 'BOM Sales Order'
  else SubsequentID := Chr(95) + 'Sales Order';

  if Assigned(grdMain.SelectedField) and
    ((grdMain.SelectedField = qryMainSaleID) or (grdMain.SelectedField = qryMainCustomerName) or (grdMain.SelectedField = qryMainSaleDate)) then begin
    OpenERPForm('TSalesOrderGUI' ,qryMainSaleId.AsInteger );
  end else begin
    inherited;
  end;
end;

procedure TUnallocatedBatchSalesListGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  if IsFormshown then RefreshQuery;
end;

procedure TUnallocatedBatchSalesListGUI.grpreportTypeClick(Sender: TObject);
begin
  inherited;
  if (grpreportType.itemindex = 0) and (rgDetail.itemindex =0) then begin
    MessageDlgXP_Vista('Please Choose "Details" to Print "Pallet Lable"', mtInformation, [mbOK], 0);
    grpreportType.itemindex := 1;
    Setcontrolfocus( rgDetail);
  end;
end;

procedure TUnallocatedBatchSalesListGUI.MakeTemplateSQL;
begin
  inherited;
  TemplateSQL := UnAllocatedBatchByPalletSQL(QrymainsaleId.asInteger , QrymainsalelineId.asInteger , qryMainProductId.asInteger , grpreportType.itemindex , qryMainCUSTFLD5.asString);
  clog( TemplateSQL);
  ReportSQLSupplied := True;
end;
function TUnallocatedBatchSalesListGUI.ReportJson: TJsonObject;
begin
  Json:= JO;
  Json.O['0'].S['master']:= 'Batchnos';
  Json.O['0'].S['detail']:= 'SalesRelatedProducts';
  Json.O['0'].S['masterfields']:='PQADetailID';
  Json.O['0'].S['detailfields']:= 'salesPQAdetailsID';

  Json.O['1'].S['master']:= 'Batchnos';
  Json.O['1'].S['detail']:= 'ProductRelatedProducts';
  Json.O['1'].S['masterfields']:='ProductId';
  Json.O['1'].S['detailfields']:= 'ParentId';

  Result :=Json;
end;

procedure TUnallocatedBatchSalesListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  QrymainCUSTFLD1.displaylabel   := AppEnv.Companyprefs.PQADEtailsCUSTFLD1;
  QrymainCUSTFLD4.displaylabel   := AppEnv.Companyprefs.PQADEtailsCUSTFLD4;
end;

procedure TUnallocatedBatchSalesListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainGrossWeight.asFloat := qryMainNettWeight.asfloat +
                                qryMainTareWeight.asfloat;
end;

procedure TUnallocatedBatchSalesListGUI.RefreshQuery;
begin
  with scriptmain do begin
    SQL.clear;
    SQL.add('drop table if exists ' + fstablename +';');
    SQL.add('CREATE TABLE ' + fstablename +' ( '+
             ' ID                   INT(11)       NOT NULL AUTO_INCREMENT, '+
             ' DetailType           INT(11)           NULL DEFAULT 0 , '+
             ' PONumber             VARCHAR(255)      NULL DEFAULT "", '+
             ' pqadetailsId         INT(11)           NULL DEFAULT 0 , '+
             ' pqaid                INT(11)           NULL DEFAULT 0 , '+
             ' ProductId            INT(11)           NULL DEFAULT 0 , '+
             ' SaleLineID           INT(11)           NULL DEFAULT 0 , '+
             ' SaleID               INT(11)           NULL DEFAULT 0 , '+
             ' CustomerName         VARCHAR(255)      NULL DEFAULT "", '+
             ' SaleDate             DATETIME          NULL DEFAULT NULL, '+
             ' SaleType             VARCHAR(255)      NULL DEFAULT "", '+
             ' ProductName          VARCHAR(255)      NULL DEFAULT "", '+
             ' ProductPrintName     VARCHAR(255)      NULL DEFAULT "", '+
             ' uom                  VARCHAR(255)      NULL DEFAULT "", '+
             ' UnitofMeasureQtySold DOUBLE            NULL DEFAULT 0 , '+
             ' UnitofMeasureShipped DOUBLE            NULL DEFAULT 0 , '+
             ' UnitofMeasureBackorder DOUBLE          NULL DEFAULT 0 , '+
             ' Allocationdate       DATETIME          NULL DEFAULT NULL, '+
             ' BatchQty             DOUBLE            NULL DEFAULT 0, '+
             ' BOBatchQty           DOUBLE            NULL DEFAULT 0, '+
             ' CUSTFLD1             INT(11)           NULL DEFAULT 0, '+
             ' CUSTFLD4             INT(11)           NULL DEFAULT 0, '+
             ' CUSTFLD5             VARCHAR(255)      NULL DEFAULT "", '+
             ' BatchNumber          VARCHAR(255)      NULL DEFAULT "", '+
//             ' ExpiryDate           DATETIME          NULL DEFAULT NULL, '+
             ' NettWeight           DOUBLE            NULL DEFAULT 0, '+
             ' TareWeight           DOUBLE            NULL DEFAULT 0, '+
             ' Allocated            ENUM("T","F")          DEFAULT "F",'+
             ' PRIMARY KEY (ID)) ENGINE=Myisam DEFAULT CHARSET=utf8;');

SQL.add('INSERT IGNORE INTO ' + fstablename +' (DetailType,PONumber,pqadetailsId, pqaid,ProductId,SaleLineID,SaleID,CustomerName,SaleDate,SaleType,ProductName,UOM,'+
                                               'UnitofMeasureQtySold,UnitofMeasureShipped,UnitofMeasureBackorder,Allocationdate,BatchQty,BOBatchQty,'+
                                               'CUSTFLD1,CUSTFLD4,CUSTFLD5,BatchNumber,NettWeight,TareWeight,Allocated)'+
              ' select 1 as DetailType, '+
              ' S.PONumber as PONumber, '+
              ' pqad.PQADetailID,'+
              ' pqa.pqaid,'+
              ' SL.ProductId as ProductId, '+
              ' SL.SaleLineID as SaleLineID, '+
              ' S.SaleID as SaleID, '+
              ' S.CustomerName as CustomerName, '+
              ' S.SaleDate as SaleDate, '+
              ProductQtyLib.Saletype('S')+' as SaleType, '+
              ' SL.ProductName as ProductName, '+
              ' concat(sl.UnitofMeasureSaleLines , "(" , sl.UnitofMeasureMultiplier , ")") uom,  '+
              ' SL.UnitofMeasureQtySold as UnitofMeasureQtySold, '+
              ' SL.UnitofMeasureShipped as UnitofMeasureShipped, '+
              ' SL.UnitofMeasureBackorder as UnitofMeasureBackorder, '+
              ' Date(pqad.MstimeStamp) as Allocationdate, '+
              ' pqad.UOMQty as BatchQty, '+
              ' pqad.BOUOMQty as BOBatchQty, '+
              ' convert((pqad.CUSTFLD1) , UNSIGNED) as CUSTFLD1, '+
              ' convert((pqad.CUSTFLD4) , UNSIGNED) as CUSTFLD4, '+
              ' pqad.CUSTFLD5 as CUSTFLD5, '+
              ' pqad.Value as BatchNumber, '+
              //' Cast(pqad.expirydate as Date) as ExpiryDate, '+
              ' UOM.Weight* ifnull(pqad.UOMQty,0) as NettWeight, '+
              ' SB.RelatedProductQty * SBUOM.weight  as Totalweight, '+
              ' SL.BatchAllocated as Allocated '+
              ' from tblsales S '+
              ' inner join tblsaleslines SL on S.SaleID = SL.SaleID '+
              ' inner join tblparts P on P.PARTSID = SL.ProductID and P.batch = "T" '+
              ' inner join tblpqa pqa on SL.SaleLineID = pqa.TransLineID and pqa.TransType in ('+SalesTransTypes+') '+
              ' inner join tblunitsofmeasure UOM on pqa.UOMID = UOM.UnitID '+
              ' left join tblpqadetails pqad on pqad.PQAID = pqa.PQAID and pqad.PQAType = "Batch" '+
              ' left join tblsalesbatches SB  on SB.SalesPQADetailsID = pqad.PQADetailId '+
              ' Left join tblunitsofmeasure SBUOM on SBUOM.unitId = SB.uomid '+
              ' where  S.Converted="F" and S.IsSalesOrder ="T" '+
              ' and ' + iif(rddatefilterOptions.itemindex<=0,  ' S.SaleDate ',' pqad.msTimeStamp ')+
                      ' between ' + quotedstr(formatdatetime(mysqldatetimeformat , FilterdateFrom))+' and  ' + quotedstr(formatdatetime(mysqldatetimeformat , FilterdateTo))+
              iif(grpFilters.ItemIndex <=0 , ' and SL.BatchAllocated = "F"' , '')+
              iif(grpFilters.ItemIndex =1 , ' and SL.BatchAllocated = "T"' , '') +
              ' order by CustomerName, SaleID, SaleLineID;');
      SQL.add('drop table if exists '+fstablename+'_1;');
      SQL.add('create table '+fstablename+'_1 like '+fstablename+';');
      SQL.add('insert ignore into  '+fstablename+'_1 (PONumber,pqadetailsId, pqaid,ProductId,SaleLineID,SaleID,CustomerName,SaleDate,SaleType,ProductName,UOM,'+
                                                     ' UnitofMeasureQtySold,UnitofMeasureShipped,UnitofMeasureBackorder,Allocationdate,BatchQty,BOBatchQty,'+
                                                     ' CUSTFLD1,CUSTFLD4,CUSTFLD5,BatchNumber,NettWeight,TareWeight,Allocated) '+
                                            ' Select PONumber,pqadetailsId, pqaid,ProductId,SaleLineID,SaleID,CustomerName,SaleDate,SaleType,ProductName,UOM,'+
                                                     ' UnitofMeasureQtySold,UnitofMeasureShipped,UnitofMeasureBackorder,Allocationdate,BatchQty,BOBatchQty,'+
                                                     ' CUSTFLD1,CUSTFLD4,CUSTFLD5,BatchNumber,NettWeight,sum(TareWeight),Allocated'+
                                            ' from '+fstablename+
                                            ' group by saleId, salelineId, pqaid, pqadetailsId ;');
      SQL.add('truncate '+fstablename+';');
      SQL.add('insert ignore into '+fstablename+' select * from '+fstablename+'_1;');
      if rgDetail.ItemIndex = 0 then begin
        SQL.add('drop table if exists '+fstablename+'_1;');
        SQL.add('create table '+fstablename+'_1 like '+fstablename+';');
        SQL.add('insert ignore into  '+fstablename+'_1 (PONumber,pqadetailsId, pqaid,ProductId,SaleLineID,SaleID,CustomerName,SaleDate,SaleType,ProductName,UOM,'+
                                                       ' UnitofMeasureQtySold,UnitofMeasureShipped,UnitofMeasureBackorder,Allocationdate,BatchQty,BOBatchQty,'+
                                                       ' CUSTFLD1,CUSTFLD4,CUSTFLD5,BatchNumber,NettWeight,TareWeight,Allocated) '+
                                              ' Select PONumber,pqadetailsId, pqaid,ProductId,SaleLineID,SaleID,CustomerName,SaleDate,SaleType,ProductName,UOM,'+
                                                       ' UnitofMeasureQtySold,UnitofMeasureShipped,UnitofMeasureBackorder,Allocationdate,sum(BatchQty) as BatchQty,sum(BOBatchQty) as BOBatchQty,'+
                                                       ' CUSTFLD1,CUSTFLD4,CUSTFLD5,null as BatchNumber,sum(NettWeight),sum(TareWeight),Allocated'+
                                              ' from '+fstablename+
                                              ' group by saleId, salelineId, pqaid ;');
        SQL.add('truncate '+fstablename+';');
        SQL.add('insert ignore into '+fstablename+' select * from '+fstablename+'_1;');
        SQL.add('drop table if exists '+fstablename+'_1;');
      end;
      SQL.add('update '+fstablename+' T inner join tblsaleslines SL on T.SaleLineID = SL.SaleLineID Set T.ProductPrintName = SL.ProductPrintName;');
      Doshowprogressbar(SQL.count , WAITMSG );
      try
        clog(SQL.text);
        Execute;
      finally
        DoHideProgressbar;
      end;
  end;
(*  qryMain.SQL.Add('select 1 as DetailType, ');
  qryMain.SQL.Add('tblpqadetails.PQADetailID as PQADetailID,');
  qryMain.SQL.Add('tblsales.PONumber as PONumber,');
  qryMain.SQL.Add('tblsaleslines.ProductId as ProductId, ');
  qryMain.SQL.Add('tblsaleslines.SaleLineID as SaleLineID, ');
  qryMain.SQL.Add('tblsales.SaleID as SaleID, ');
  qryMain.SQL.Add('tblsales.CustomerName as CustomerName, ');
  qryMain.SQL.Add('tblsales.SaleDate as SaleDate,');
  qryMain.SQL.Add(ProductQtyLib.SaleType('tblsales') + ' as SaleType,');
  qryMain.SQL.Add('tblsaleslines.ProductName as ProductName, ');
  qryMain.SQL.Add('tblsaleslines.UnitofMeasureQtySold as UnitofMeasureQtySold, ');
  qryMain.SQL.Add('tblsaleslines.UnitofMeasureShipped as UnitofMeasureShipped,');
  qryMain.SQL.Add('Date(tblpqadetails.MstimeStamp) as Allocationdate,');
  if rgDetail.ItemIndex = 0 then begin
    { summary }
    qryMain.SQL.Add('sum(tblpqadetails.UOMQty) as BatchQty,');
    qryMain.SQL.Add('sum(tblpqadetails.BOUOMQty) as BOBatchQty,');
    qryMain.SQL.Add('convert(sum(tblpqadetails.CUSTFLD1) , UNSIGNED) as CUSTFLD1,');
    qryMain.SQL.Add('convert(sum(tblpqadetails.CUSTFLD4) , UNSIGNED) as CUSTFLD4,');
    qryMain.SQL.Add('null as CUSTFLD5,');
    qryMain.SQL.Add('null as BatchNumber,');
    qryMain.SQL.Add('Cast(null as Date) as ExpiryDate,');
    qryMain.SQL.Add('Sum(UOM.Weight* ifnull(tblpqadetails.UOMQty,0)) as NettWeight,');
    qryMain.SQL.Add('(Select sum(SB.RelatedProductQty * UOM.weight ) from tblsalesbatches SB inner join tblunitsofmeasure UOM on SB.UOMID = UOM.UnitID where SB.SalesPQADetailsID = tblpqadetails.PQADetailId ) as  TareWeight, ');
  end
  else begin
   { Detail }
    qryMain.SQL.Add('tblpqadetails.UOMQty as BatchQty,');
    qryMain.SQL.Add('tblpqadetails.BOUOMQty as BOBatchQty,');
    qryMain.SQL.Add('convert(tblpqadetails.CUSTFLD1 , UNSIGNED) as CUSTFLD1,');
    qryMain.SQL.Add('convert(tblpqadetails.CUSTFLD4 , UNSIGNED) as CUSTFLD4,');
    qryMain.SQL.Add('tblpqadetails.CUSTFLD5 as CUSTFLD5,');
    qryMain.SQL.Add('tblpqadetails.Value as BatchNumber,');
    qryMain.SQL.Add('tblpqadetails.ExpiryDate as ExpiryDate,');
    qryMain.SQL.Add('UOM.Weight* tblpqadetails.UOMQty as NettWeight,');
    qryMain.SQL.Add('(Select sum(SB.RelatedProductQty * UOM.weight ) from tblsalesbatches SB inner join tblunitsofmeasure UOM on SB.UOMID = UOM.UnitID where SB.SalesPQADetailsID = tblpqadetails.PQADetailID) as  TareWeight,');
  end;
  qryMain.SQL.Add('tblsaleslines.BatchAllocated as Allocated');
  qryMain.SQL.Add('from tblsales');
  qryMain.SQL.Add('inner join tblsaleslines on tblsales.SaleID = tblsaleslines.SaleID');
  qryMain.SQL.Add('inner join tblparts on tblparts.PARTSID = tblsaleslines.ProductID and tblparts.batch = "T"');
  qryMain.SQL.Add('inner join tblpqa on tblsaleslines.SaleLineID = tblpqa.TransLineID and tblpqa.TransType in ('+SalesTransTypes+')');
  qryMain.SQL.Add('inner join tblunitsofmeasure UOM on tblpqa.UOMID = UOM.UnitID');
  {It can be a normal sale as well}
  //qryMain.SQL.Add('inner join tblproctree on tblproctree.SaleLineID = tblsaleslines.SaleLineID');
  qryMain.SQL.Add('left join tblpqadetails on tblpqadetails.PQAID = tblpqa.PQAID and tblpqadetails.PQAType = "Batch"');
  qryMain.SQL.Add('where  tblsales.Converted="F" and tblsales.IsSalesOrder ="T" ');
//  qryMain.SQL.Add('where tblsales.IsSalesOrder ="T" ');
  if rddatefilterOptions.itemindex<=0 then qryMain.SQL.Add('and tblsales.SaleDate between :dtFrom and :dtTo')
  else qryMain.SQL.Add('and tblpqadetails.ExpiryDate between :dtFrom and :dtTo');
  qryMain.SQL.Add('and ((:Allocation = "Unallocated" and tblsaleslines.BatchAllocated = "F")');
  qryMain.SQL.Add('or (:Allocation = "Allocated" and tblsaleslines.BatchAllocated = "T")');
  qryMain.SQL.Add('or (:Allocation = "Both" or :Allocation = ""))');
  if rgDetail.ItemIndex = 0 then begin
    { summary }
    qryMain.SQL.Add('group by tblsaleslines.SaleLineID');
  end else begin
   { Detail }
  end;
  qryMain.SQL.Add('order by tblsales.CustomerName, tblsales.SaleID, tblsaleslines.SaleLineID');*)


(*  self.RefreshOrignalSQL();
  qryMain.ParamByName('dtFrom').AsDateTime := FilterDateFrom;
  qryMain.ParamByName('dtTo').AsDateTime := FilterDateTo;
  case grpFilters.ItemIndex of
    -1,0: qryMain.ParamByName('Allocation').AsString := 'Unallocated';
    1: qryMain.ParamByName('Allocation').AsString := 'Allocated';
    2: qryMain.ParamByName('Allocation').AsString := 'Both';
  end;
  end;*)
  inherited;
end;

procedure TUnallocatedBatchSalesListGUI.FreeReportJson;
begin
  inherited;
  try
    if Assigned(Json) then  Json.Free;
  Except
    // kill the exception
  end;
end;

procedure TUnallocatedBatchSalesListGUI.rgDetailClick(Sender: TObject);
begin
  inherited;
  if IsFormshown then begin
    grpreportType.itemindex := 1;
    self.RefreshQuery;
  end;
end;

procedure TUnallocatedBatchSalesListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('DetailType');
  if not AppEnv.Companyprefs.EnablePQADEtailsCUSTFLD1 then RemoveFieldfromGrid(QrymainCUSTFLD1.fieldname);
  if not AppEnv.Companyprefs.EnablePQADEtailsCUSTFLD4 then RemoveFieldfromGrid(QrymainCUSTFLD4.fieldname);
  RemoveFieldfromGrid(qryMainProductId.fieldname);
  RemoveFieldfromGrid(qryMainId.fieldname);
  RemoveFieldfromGrid(qryMainpqadetailsId.fieldname);
  RemoveFieldfromGrid(qryMainpqaId.fieldname);
  RemoveFieldfromGrid(qryMainSaleLineID.fieldname);
end;
procedure TUnallocatedBatchSalesListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.rgDetail')             then rgDetail.ItemIndex            :=  GuiPrefs.Node['Options.rgDetail'].asInteger;
  if GuiPrefs.Node.Exists('Options.grpreportType')        then grpreportType.ItemIndex       :=  GuiPrefs.Node['Options.grpreportType'].asInteger;
  if GuiPrefs.Node.Exists('Options.rddatefilterOptions')  then rddatefilterOptions.ItemIndex :=  GuiPrefs.Node['Options.rddatefilterOptions'].asInteger;
end;
Procedure TUnallocatedBatchSalesListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.rgDetail'].asInteger           := rgDetail.ItemIndex ;
  GuiPrefs.Node['Options.grpreportType'].asInteger      := grpreportType.ItemIndex ;
  GuiPrefs.Node['Options.rddatefilterOptions'].asInteger:= rddatefilterOptions.ItemIndex ;
end;


initialization
  RegisterClass(TUnallocatedBatchSalesListGUI);

end.
