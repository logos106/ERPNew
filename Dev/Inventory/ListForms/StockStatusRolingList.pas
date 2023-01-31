unit StockStatusRolingList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, wwcheckbox, BaseInputForm,
  DAScript, MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TStockStatusRoling = class(TBaseListingGUI)
    qryMainTotalCost: TFloatField;
    qryMainRunningQty: TFloatField;
    qryMainLevelno: TIntegerField;
    qryMainTransDate: TDateTimeField;
    qryMainActualTransDate: TDateTimeField;
    qryMainclassName: TWideStringField;
    qryMaintransType: TWideStringField;
    qryMainTransactionno: TIntegerField;
    qryMainFormName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainFirstcolumn: TWideStringField;
    qryMainSecondcolumn: TWideStringField;
    qryMainThirdcolumn: TWideStringField;
    qryMainQty: TFloatField;
    qryMainOQ: TFloatField;
    qryMainRQ: TFloatField;
    qryMainAvgcost: TFloatField;
    qryMainLinecost: TFloatField;
    qryMaincTransID: TIntegerField;
    qryMaincTranstype: TWideStringField;
    qryMainAvgTotalCost: TFloatField;
    lblREfreshInfo: TLabel;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    chkAging: TCheckBox;
    chkExcludeSo: TCheckBox;
    DNMPanel3: TDNMPanel;
    chkHideRunningQty: TCheckBox;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure dtToCloseup(Sender: TObject);
    procedure dtFromCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkAgingClick(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure chkExcludeSoClick(Sender: TObject);
    procedure dtToChange(Sender: TObject);
  private
    procedure MakeQrymain;
  public
    class function PopulateData(fstablename :String; ExcludeSO:Boolean;ClassId :Integer; ProductID:Integer; Datefieldtofilter:String; dtFrom ,dtto:TDateTime; Filterindex:Integer; HideRunningQty :Boolean): String;
  Protected
    fsTablename :String;
    procedure RefreshQuery; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
    Procedure SetGridColumns;override;
    procedure RefreshTotals; override;
    procedure CalcFooter; override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure RefreshAll;Override;
    procedure CalcnShowFooter;Override;
  end;

(*var
  StockStatusRoling: TStockStatusRoling;*)

implementation

uses pqalib, ProductQtyLib,  FastFuncs, Dateutils, AppEnvironment, Commonlib,systemlib,
  MySQLConst, busobjStockMovement, BusobjStockAdjustEntry,
  busobjstockTransferentry, CommonDbLib,  tcConst, tcDataUtils, LogLib;

{$R *.dfm}

procedure TStockStatusRoling.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryMainLevelno.asInteger = 1 then
    qryMainRunningQty.asfloat := qryMainQty.asfloat + qryMainOQ.asFloat
  else qryMainRunningQty.asfloat := qryMainRQ.asFloat;
  //qryMainTotalCost.asFloat := qryMainQty.asFloat * qryMainAvgcost.asfloat;
  if qryMainLevelno.asInteger = 3 then begin
    qryMainTotalCost.asFloat := qryMainQty.asFloat * qryMainlinecost.asfloat;
    qryMainAvgTotalCost.asFloat := qryMainQty.asFloat * qryMainAvgCost.asfloat;
  end else begin
    qryMainTotalCost.asFloat := 0;
    qryMainAvgTotalCost.asFloat := 0;
  end;

 (*  if Sysutils.SameText(qryMaintransType.asString , 'Stock movement') then begin
    qryMaincTransID.asInteger := TStockMovement.TransactionID(qryMainTransactionno.asInteger);
    qryMaincTransType.asString :=TStockMovement.TransactionType(qryMainTransactionno.asInteger);
  end else begin
      qryMaincTransType.asString := qryMaintransType.asString;
      qryMaincTransID.asInteger := qryMainTransactionno.asInteger;
  end; *)
end;

Class Function TStockStatusRoling.PopulateData(fstablename :String; ExcludeSO:Boolean;ClassId :Integer;ProductID:Integer;  Datefieldtofilter:String; dtFrom ,dtto:TDateTime; filterIndex :Integer; HideRunningQty :Boolean):String;
var
  st:TstringList;
begin
  st:=TstringList.Create;
  try
      ST.add('/*1*/truncate ' + fstablename + ';');
      ST.add('/*2*/Drop table if exists ' + fstablename + '_PQA;');
      ST.add('/*3*/Create table  ' + fstablename + '_PQA like tblpqa;');
      ST.add('/*3.1*/ALTER TABLE  ' + fstablename + '_PQA 	ENGINE=MyISAM;');
      ST.add('/*3.2*/ALTER TABLE  ' + fstablename + '_PQA ROW_FORMAT=Fixed;');
      ST.add('/*3.3*/ALTER TABLE  ' + fstablename + '_PQA 	ADD INDEX `TransLineID_TransType` (`TransLineID`, `TransType`);');
      ST.add('/*3.4*/ALTER TABLE ' + fstablename + '_PQA ADD INDEX `ProductID` (`ProductID`),    	ADD INDEX `DepartmentID` (`DepartmentID`);');
      ST.add('/*4*/insert ignore into  ' + fstablename + '_PQA select * from tblpqa '+
                  ' where TransDate between ' + quotedstr(FormatDateTime(MysqlDatetimeFormat ,dtFrom))+' and   ' + quotedstr(FormatDateTime(MysqlDatetimeFormat ,dtto))+
                  iif(classId <> 0 , ' and departmentID = ' +IntToStr(classID), '') +
                  iif(ProductID <> 0 , ' and ProductID = ' +IntToStr(ProductID), '') +
                  '  and ifnull(Qty,0)<> 0  ;');
      ST.add('/*5*/Alter table ' + fstablename + '_PQA  ADD COLUMN `ActualTransDate` DATETIME NULL DEFAULT NULL ;');
      ST.add('/*5.1*/ALTER TABLE ' + fstablename + '_PQA ADD INDEX ActualTransdate (ActualTransdate);');
      ST.add('/*6*/update ' + fstablename +'_PQA PQA ' +
                ' inner Join tblpurchaselines       AS POL ON PQA.TransLineID = POL.PurchaseLineID       and PQA.TRanstype in (' +POTranstypes      +')  ' +
                ' inner join tblpurchaseOrders PO on POL.purchaseOrderId = PO.purchaseorderID   ' +
                ' Set PQA.ActualTransDate = PO.OrderDate;');
      ST.add('/*7*/update ' + fstablename +'_PQA PQA  ' +
                ' inner Join tblsaleslines          AS SL  ON PQA.TransLineID = Sl.SalelineID            and PQA.TRanstype in (' +SalesTransTypes   +')   ' +
                ' inner join tblsales S on Sl.saleid = s.saleId  ' +
                ' Set PQA.ActualTransdate  = s.SaleDateTime;');
      ST.add('/*8*/update ' + fstablename +'_PQA PQA  ' +
                ' inner Join tblstockmovementlines  AS SML ON PQA.TransLineID = SML.StockmovementLinesID and PQA.TRanstype in (' +StockMovementtypes+')   ' +
                ' Set PQA.ActualTransdate = PQA.transdate;');
      ST.add('/*9*/update ' + fstablename +'_PQA PQA  ' +
                ' inner Join tblproctreepart        AS PTP ON PQA.TransLineID = PTP.ProcTreePartId       and PQA.TRanstype in (' +ManufactureTypes  +')  ' +
                ' inner join tblproctree PT on PTP.proctreeId = PT.proctreeID  ' +
                ' inner join tblsaleslines SL on SL.saleLineID = PT.masterId  ' +
                ' inner join tblsales S on S.saleId = SL.saleID ' +
                ' Set PQA.actualTransdate = s.saleDate;');
       ST.add('/*10*/update ' + fstablename +'_PQA PQA Set PQA.actualTransdate = PQA.transDate where ifnull(actualTransdate,0)=0;' );
       ST.add('/*10.1*/update ' + fstablename +'_PQA PQA Set PQA.active ="T" where Transtype in ("TPRocProgressIN" , "TPRocProgressOUT");' );


      ST.add('/*11*/insert into ' + fstablename + '(Levelno,TransDate,Actualtransdate, className,transType,Transactionno,FormName,ProductName,Firstcolumn,Secondcolumn,Thirdcolumn,Qty,OQ,RQ,Avgcost)');
      ST.add('Select ');
      ST.add('1 as Levelno,');
      ST.add('null as TransDate, ');
      ST.add('null as Actualtransdate, ');
      ST.add('C.className, ');
      ST.add('"" as transType,  ');
      ST.add('0 as Transactionno, ');
      ST.add('"" as FormName, ');
      ST.add('PQA.ProductName,');
      ST.add(Firstcolumn + ' AS Firstcolumn,');
      ST.add(Secondcolumn + ' AS Secondcolumn,');
      ST.add(Thirdcolumn +' AS Thirdcolumn,');
      if ExcludeSO then
        ST.add(SQL4Qty(tInStock(*tActStock*)) + ' as Qty,')
      else
        ST.add(SQL4Qty(tInStockMovement) + ' as Qty,');
      if HideRunningQty = False then begin
        if ExcludeSO then begin
          ST.add('(Select ' + SQL4Qty(tInStock(*tActStock*) , 'OQPQA' , 'OQPQA.qty') + ' from ' + fstablename +'_PQA as OQPQA ');
                ST.add('where  OQPQA.ProductID = PQA.ProductID ');
                ST.add('and OQPQA.departmentID = PQA.DepartmentID ');
                if classId <> 0 then ST.add('and OQPQA.departmentID = ' +IntToStr(classID));
                if ProductId <> 0 then ST.add('and OQPQA.ProductId = ' +IntToStr(ProductId));
                ST.add('and OQPQA.' + Datefieldtofilter +' < ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtFrom)) + ') as OQ,');
        end else begin
          ST.add('(Select ' + SQL4Qty(tInStockMovement , 'OQPQA' , 'OQPQA.qty') + ' from ' + fstablename +'_PQA as OQPQA ');
                ST.add('where  OQPQA.ProductID = PQA.ProductID ');
                ST.add('and OQPQA.departmentID = PQA.DepartmentID ');
                if classId <> 0 then ST.add('and OQPQA.departmentID = ' +IntToStr(classID));
                if ProductId <> 0 then ST.add('and OQPQA.ProductId = ' +IntToStr(ProductId));
                ST.add('and OQPQA.' + Datefieldtofilter +' < ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtFrom)) + ') as OQ,');
        end;
      end else begin
        ST.add('0.0 as OQ,');
      end;
      ST.add('0.0 as RQ,');
      ST.add('P.Avgcost');
      ST.add('FROM ' + replacestr(ProductTables(tsummary), ' `tblPQA` ' , ' ' + fstablename +'_PQA '));
      ST.add('Where PQA.' + Datefieldtofilter +' between  ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtFrom)) );
      ST.add(' and  ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtTo)) );
      if classId <> 0 then ST.add('and PQA.departmentID = ' +IntToStr(classID));
      if ProductId <> 0 then ST.add('and PQA.ProductId = ' +IntToStr(ProductId));
      ST.add(' and PQA.Active = "T"');
      ST.add('group by PQA.ProductID, PQA.DepartmentID');
      ST.add('order by className,ProductName,' + Datefieldtofilter +', Transtype , Transactionno;');
      if Filterindex = 1 then begin
        ST.add('/*12*/insert into ' + fstablename + '(Levelno,TransDate,Actualtransdate,className,transType,Transactionno,FormName,ProductName,Firstcolumn,Secondcolumn,Thirdcolumn,Qty,OQ,RQ,Avgcost)');
        ST.add('Select 2 as Levelno, PQA.TransDate, PQA.actualtransdate, C.className,TT.Description  Transtype, 0 as Transactionno, ');
        ST.add('"" , PQA.ProductName,');
        ST.add(Firstcolumn + ' AS Firstcolumn,');
        ST.add(Secondcolumn + ' AS Secondcolumn,');
        ST.add(Thirdcolumn +' AS Thirdcolumn,');
        if ExcludeSO then
          ST.add(SQL4Qty(tInStock) + ' as Qty,')
        else
          ST.add(SQL4Qty(tInStockMovement) + ' as Qty,');
        ST.add('0 as OQ,');
        if HideRunningQty = False then begin
          if ExcludeSO then begin
            ST.add('(Select ' + SQL4Qty(tInStock(*tActStock*) , 'OQPQA' , 'OQPQA.qty') + ' from ' + fstablename +'_PQA as OQPQA ');
                  ST.add('where  OQPQA.ProductID = PQA.ProductID ');
                  ST.add('and OQPQA.departmentID = PQA.DepartmentID ');
                  if classId <> 0 then ST.add('and OQPQA.departmentID = ' +IntToStr(classID));
                  if ProductId <> 0 then ST.add('and OQPQA.ProductId = ' +IntToStr(ProductId));
                  ST.add('and OQPQA.' + Datefieldtofilter +' >= ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtFrom)) );
                  ST.add('and OQPQA.' + Datefieldtofilter +'<= PQA.' + Datefieldtofilter +' ) as RQ,');
          end else begin
            ST.add('(Select ' + SQL4Qty(tInStockMovement , 'OQPQA' , 'OQPQA.qty') + ' from ' + fstablename +'_PQA as OQPQA ');
                  ST.add('where  OQPQA.ProductID = PQA.ProductID ');
                  ST.add('and OQPQA.departmentID = PQA.DepartmentID ');
                  if classId <> 0 then ST.add('and OQPQA.departmentID = ' +IntToStr(classID));
                  if ProductId <> 0 then ST.add('and OQPQA.ProductId = ' +IntToStr(ProductId));
                  ST.add('and OQPQA.' + Datefieldtofilter +' >= ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtFrom)) );
                  ST.add('and OQPQA.' + Datefieldtofilter +'<= PQA.' + Datefieldtofilter +' ) as RQ,');
          end;
        end else begin
           ST.add('0.0 as RQ,');
        end;
        ST.add('P.Avgcost');
        ST.add('FROM ' + replacestr(ProductTables(tsummary, false, true), ' `tblPQA` ' , ' ' + fstablename +'_PQA '));
        ST.add('Where PQA.' + Datefieldtofilter +' between  ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtFrom)) );
        ST.add(' and  ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtTo)) );
        if classId <> 0 then ST.add('and PQA.departmentID = ' +IntToStr(classID));
        if ProductId <> 0 then ST.add('and PQA.ProductId = ' +IntToStr(ProductId));
        ST.add(' and PQA.Active = "T"  and PQA.ISBo="F"');
        //if chkExcludeSo.chedked then ST.add(' and PQA.transtype <> "TSalesOrderline"');
        if classId <> 0 then ST.add('and PQA.departmentID = ' +IntToStr(classId));
        if ProductId <> 0 then ST.add('and PQA.ProductId = ' +IntToStr(ProductId));
        ST.add('group by PQA.ProductID, PQA.DepartmentID, TT.Description');
        ST.add('order by className,ProductName,' + Datefieldtofilter +', Transtype , Transactionno;');
      end else if Filterindex = 2 then begin
        ST.add('/*13*/insert into ' + fstablename + '(Levelno,TransDate,ActualTransdate,className,transType,PQATranstype,PQATranslineID ,  Transactionno,FormName,ProductName,Firstcolumn,Secondcolumn,Thirdcolumn,Qty,OQ,RQ,Avgcost)');
        ST.add('Select 3 as Levelno,PQA.transdate, PQA.actualtransdate, C.className,TT.Description  ,PQA.Transtype, PQa.transLineId , PQA.TransID as Transactionno, ');
        ST.add('TT.formname,  PQA.ProductName,');
        ST.add(Firstcolumn + ' AS Firstcolumn,');
        ST.add(Secondcolumn + ' AS Secondcolumn,');
        ST.add(Thirdcolumn +' AS Thirdcolumn,');
        if ExcludeSO then
          ST.add(SQL4Qty(tInStock(*tActStock*)) + ' as Qty,')
        else
          ST.add(SQL4Qty(tInStockMovement) + ' as Qty,');
        ST.add('0 as OQ,');
        if HideRunningQty = False then begin
          if ExcludeSO then begin
            ST.add('(Select ' + SQL4Qty(tInStock(*tActStock*) , 'OQPQA' , 'OQPQA.qty') + ' from ' + fstablename +'_PQA as OQPQA ');
                  ST.add('where  OQPQA.ProductID = PQA.ProductID ');
                  ST.add('and OQPQA.departmentID = PQA.DepartmentID ');
                  if classId <> 0 then ST.add('and OQPQA.departmentID = ' +IntToStr(classID));
                  if ProductId <> 0 then ST.add('and OQPQA.ProductId = ' +IntToStr(ProductId));
                  ST.add('and OQPQA.' + Datefieldtofilter +' >= ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtFrom)));
                  ST.add('and OQPQA.' + Datefieldtofilter +'<= PQA.' + Datefieldtofilter +' ) as RQ,');
          end else begin
            ST.add('(Select ' + SQL4Qty(tInStockMovement , 'OQPQA' , 'OQPQA.qty') + ' from ' + fstablename +'_PQA as OQPQA ');
                  ST.add('where  OQPQA.ProductID = PQA.ProductID ');
                  ST.add('and OQPQA.departmentID = PQA.DepartmentID ');
                  if classId <> 0 then ST.add('and OQPQA.departmentID = ' +IntToStr(classID));
                  if ProductId <> 0 then ST.add('and OQPQA.ProductId = ' +IntToStr(ProductId));
                  ST.add('and OQPQA.' + Datefieldtofilter +' >= ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtFrom)));
                  ST.add('and OQPQA.' + Datefieldtofilter +'<= PQA.' + Datefieldtofilter +' ) as RQ,');
          end;
        end else begin
          ST.add('0.0 as RQ,');
        end;
        ST.add('P.Avgcost');
        ST.add('FROM ' + replacestr(ProductTables(tsummary, false, true), ' `tblPQA` ' , ' ' + fstablename +'_PQA '));
        ST.add('Where PQA.' + Datefieldtofilter +' between  ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtFrom)) );
        ST.add(' and  ' + quotedStr(FormatDateTime(MysqlDatetimeFormat , dtTo)) );
        ST.add(' and PQA.Active = "T" and PQA.ISBo="F"');
        if classId <> 0 then ST.add('and PQA.departmentID = ' +IntToStr(classId));
        if ProductId <> 0 then ST.add('and PQA.ProductId = ' +IntToStr(ProductId));
        ST.add('group by PQA.PQAID/*ProductID, PQA.DepartmentID, TT.Description , PQA.TransID*/');
        ST.add('order by className,ProductName,' + Datefieldtofilter +', Transtype , Transactionno;');

            {purchase order's total cost is used instead of qtyxcost to avoid round issue }
        ST.add('/*14*/update ' + fstablename +' T inner Join tblpurchaselines       AS POL ON T.PQATransLineID = POL.PurchaseLineID       and T.PQATRanstype in (' +POTranstypes      +')  Set T.Linecost = POL.Linecost, T.totalLinecost = POL.TotalLineAmount where T.levelno = 3;');
        ST.add('/*15*/update ' + fstablename +' T inner Join tblsaleslines          AS SL  ON T.PQATransLineID = Sl.SalelineID            and T.PQATRanstype in (' +SalesTransTypes   +')  Set T.Linecost = SL.Linecost  where T.levelno = 3;');
        ST.add('/*16*/update ' + fstablename +' T inner Join tblstockmovementlines  AS SML ON T.PQATransLineID = SML.StockmovementLinesID and T.PQATRanstype in (' +StockMovementtypes+')  Set T.Linecost = SML.cost    where T.levelno = 3;');
        ST.add('/*17*/update ' + fstablename +' T inner Join tblproctreepart        AS PTP ON T.PQATransLineID = PTP.ProcTreePartId       and T.PQATRanstype in (' +ManufactureTypes  +') inner join tblproctree PT on PTP.proctreeId = PT.proctreeID  ' + ' Set T.Linecost = (PT.cost/if(PT.TreeRootID = PT.ProctreeId , PT.totalQty,PT.Quantity)) where T.levelno = 3;');
        ST.add('/*17.1*/update '+fstablename +' T inner join tblprocprogress        As PP  ON T.PQATransLineID = PP.ProcProgressID        and T.PQATRanstype in ("TProcProgressIn" , "TProcProgressOUT") ' +
                        ' inner Join tblproctreepart AS PTP ON PP.ProcTreePartID = PTP.ProcTreePartId ' +
                        ' inner join tblproctree PT on PTP.proctreeId = PT.proctreeID ' +
                        ' set T.linecost = (PT.cost/if(PT.TreeRootID = PT.ProctreeId , PT.totalQty,PT.Quantity)) ' +
                        ' where T.levelno = 3;');
      end;
      ST.add('/*18*/update ' + fstablename +' T  Set cTranstype = Transtype, cTransId = transactionno where transType <> "Stock movement" ;');
      ST.add('/*19*/update ' + fstablename +' T  '+
              ' inner join tblstockMovement SM on SM.StockmovementId = T.Transactionno '+
              ' inner join tblstockadjustentry SA on SM.StockmovementEntryglobalref = SA.GlobalRef and SM.StockmovementEntryType = "StockAdjustEntry" '+
              'Set cTransID = SA.StockAdjustEntryID, cTranstype =SM.StockmovementEntryType where T.transType = "Stock movement";');

      ST.add('/*20*/update ' + fstablename +' T  '+
              ' inner join tblstockMovement SM on SM.StockmovementId = T.Transactionno '+
              ' inner join tblstocktransferentry ST on SM.StockmovementEntryglobalref = ST.GlobalRef and SM.StockmovementEntryType = "StockTransferEntry" ' +
              'Set cTransID = ST.TransferEntryID, cTranstype =SM.StockmovementEntryType where T.transType = "Stock movement";');
      result:= st.text;
      clog(result);
  finally
    Freeandnil(st);
  end;

end;

procedure TStockStatusRoling.RefreshQuery;
begin
  if qrymain.active = false then
    inherited;
  lblREfreshInfo.visible := True;
end;
procedure TStockStatusRoling.RefreshAll;
var
  curSym: string;

  Function Datefieldtofilter: string;
  begin
    if chkAging.Checked then result := 'ActualTransdate' else result := 'TransDate';
  end;

begin
    if self.visible = false then exit;
(*    if (SelectedClassId=0) and (SelectedProductId =0) and (chkIgnoreDates.checked) then
      if MessageDlgXP_vista('This Report Can Take long time to run for all departments and all Products.'+NL+NL+
                            'Do you wish to continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then Exit;*)
    With ScriptMain do begin
      //Connection := qryMain.Connection;
      SQL.clear;
      SQL.Add(Populatedata(fsTablename , chkExcludeSO.checked , SelectedClassId, SelectedProductID,  Datefieldtofilter, filterdateFrom, filterdateto, grpFilters.itemindex, chkHideRunningQty.checked));

      SQL.text := ChangeQuery(SQL.text);
      (*showProgressbar(WAITMSG , 7);
      try
        clog(SQL.text);
        LogTime('Before :');
        try
        Execute;
        finally
          LogTime('After :');
        end;
      finally
        HideProgressbar;
      end;*)
      ExecutewithProgress(False);
    end;
    qryMain.FieldByName('OQ').DisplayLabel    := 'Opening';
    QryMain.FieldByName('RQ').DisplayLabel    := 'Running';
    qryMain.FieldByName('Qty').DisplayLabel   := 'Current';
    qryMaincTransID.DisplayLabel              := 'Transaction No';
    qryMaincTransType.DisplayLabel            := 'Transaction Type';
    inherited RefreshQuery;
    curSym:= AppEnv.RegionalOptions.CurrencySymbol;
    TFloatField(qryMain.FieldByName('TotalCost')).DisplayFormat     := curSym+'#,###,##0.00;-'+curSym+'#,###,##0.00';
    TFloatField(qryMain.FieldByName('AvgTotalCost')).DisplayFormat  := curSym+'#,###,##0.00;-'+curSym+'#,###,##0.00';
    TDateTimeField(qryMain.FieldByName('TransDate')).DisplayFormat  := FormatSettings.ShortDateformat;
    TDateTimeField(qryMain.FieldByName(Datefieldtofilter)).DisplayFormat  := FormatSettings.ShortDateformat;
    qryMainAvgcost.DisplayFormat              := curSym+'#,###,##0.00000;-'+curSym+'#,###,##0.00000';
    lblREfreshInfo.visible := False;
end;

procedure TStockStatusRoling.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;
procedure TStockStatusRoling.CalcnShowFooter;
begin
  inherited;
end;

procedure TStockStatusRoling.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }

  if qrymain.FieldByName('Levelno').asInteger = 1 then
    grdMain.Canvas.Font.Style := grdMain.Canvas.Font.Style + [fsBold];

  if qrymain.FieldByName('Levelno').asInteger <= 1 then
    if Sysutils.SameText(field.Fieldname , 'cTransId') then
      if field.Value = 0 then Afont.color := ABrush.color;

  {line cost and the total cost calculated on basis of the linecosts are only applicable for the extra details as otherwise its grouped }
  if qrymain.FieldByName('Levelno').asInteger <= 2 then
    if (Sametext(field.fieldname, 'linecost'))  or (Sametext(field.fieldname, 'Totalcost'))  or (Sametext(field.fieldname, 'AvgTotalCost'))  then
      Afont.color := abrush.color;
end;
procedure TStockStatusRoling.grpFiltersClick(Sender: TObject);
begin
//  inherited;
  RefreshQuery;
end;

procedure TStockStatusRoling.FormShow(Sender: TObject);
begin
  GrdMain.UseTFields := True;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('transType,RQ,Transactionno');
  inherited;
  Refreshall;
end;

procedure TStockStatusRoling.actRefreshQryExecute(Sender: TObject);
begin
//  inherited;
  RefreshAll;
end;

procedure TStockStatusRoling.AssignKeyId(Popupform: TBaseInputGUI);
begin
    Popupform.KeyId := 0;
  if (Sysutils.SameText(qryMaincTransType.asString , TStockTransferEntry.Transtype)) or
            (Sysutils.SameText(qryMaincTransType.asString , TStockAdjustEntry.Transtype))  then begin
     Popupform.KeyId := qryMaincTransID.asInteger;
  end;
  if Popupform.KeyId = 0 then inherited;
end;

procedure TStockStatusRoling.grdMainDblClick(Sender: TObject);
begin
  SubsequentID:= '';

  if qryMainLevelno.asinteger = 3 then begin
           if (Sysutils.SameText(qryMaincTransType.asString , TStockAdjustEntry.Transtype))   then SubsequentID := Chr(95) + AdjustType(qryMaincTransID.asInteger)  + qryMaincTransType.asString
      else if (Sysutils.SameText(qryMaincTransType.asString , TStockTransferEntry.Transtype)) then SubsequentID := Chr(95) + TransferType(qryMaincTransID.asInteger)+ qryMaincTransType.asString;
  end else SubsequentID := '_' + QrymainCTranstype.AsString;

  inherited;

end;

procedure TStockStatusRoling.chkAgingClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkAging then
    RefreshQuery;
end;

procedure TStockStatusRoling.chkExcludeSoClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TStockStatusRoling.CalcFooter;
begin
  if (* ((QrymainLevelno.asInteger =1) and (grpFilters.itemindex =0)) or
     ((QrymainLevelno.asInteger =2) and (grpFilters.itemindex =1)) or *)
     ((QrymainLevelno.asInteger =3) and (grpFilters.itemindex =2)) then
  inherited;
end;

procedure TStockStatusRoling.dtToChange(Sender: TObject);
begin
  dtFrom.Date :=0;
  inherited;
end;

procedure TStockStatusRoling.dtToCloseup(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TStockStatusRoling.dtFromCloseUp(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;
Procedure TStockStatusRoling.MakeQrymain;
begin
    Qrymain.sql.clear;
    Qrymain.sql.add('Select');
    Qrymain.sql.add('Levelno          as Levelno,');
    Qrymain.sql.add('TransDate        as TransDate,');
    Qrymain.sql.add('ActualTransDate  as ActualTransDate,');
    Qrymain.sql.add('className        as className,');
    Qrymain.sql.add('transType        as transType,');
    Qrymain.sql.add('Transactionno    as Transactionno,');
    Qrymain.sql.add('FormName         as FormName,');
    Qrymain.sql.add('ProductName      as ProductName,');
    Qrymain.sql.add('Firstcolumn      as Firstcolumn,');
    Qrymain.sql.add('Secondcolumn     as Secondcolumn,');
    Qrymain.sql.add('Thirdcolumn      as Thirdcolumn,');
    Qrymain.sql.add('Qty              as Qty,');
    Qrymain.sql.add('OQ               as OQ,');
    Qrymain.sql.add('RQ               as RQ,');
    Qrymain.sql.add('Avgcost          as Avgcost,');
    Qrymain.sql.add('Linecost         as Linecost,');
    Qrymain.sql.add('linecostinc      as linecostinc,');
    Qrymain.sql.add('cTransID         as cTransID,');
    Qrymain.sql.add('cTranstype       as cTranstype');
    Qrymain.sql.add('from '+fstablename);
    Qrymain.sql.add('ORDER By className,ProductName,Transdate, Transtype , Transactionno');
end;
procedure TStockStatusRoling.FormCreate(Sender: TObject);
begin
  HaveOnlyToDate['As On '] := true;
  dtFrom.Date :=0;
  fsTablename := CommonDbLib.CreateUserTemporaryTable('tmp_ssrr' );
  MakeQrymain;
  inherited;
  SelectionOption :=soClassnProduct;
  AddCalcColumn('TotalCost', true);
  AddCalcColumn('AvgTotalCost', true);
end;

procedure TStockStatusRoling.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TStockStatusRoling.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Formname');
  RemoveFieldfromGrid('Levelno');
  RemoveFieldfromGrid('Opening');
  RemoveFieldfromGrid('PQATransType');
  RemoveFieldfromGrid('PQALtransLineID');
end;

procedure TStockStatusRoling.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('General') then begin
      chkExcludeSO.checked      := GuiPrefs.Node['General.ExcludeSO'].asBoolean ;
      chkAging.checked          := GuiPrefs.Node['General.AgingonTransDate'].asBoolean ;
      chkHideRunningQty.checked := GuiPrefs.Node['General.HideRunningQty'].asBoolean  or devmode;
  end;
(*  if (selectedProductID=0) and (Selectedclassid =0) then
    selectedClassID := ClassLookupform.FirstRecID;*)
    selectedProductID := ProductLookupform.FirstRecID;
end;
procedure TStockStatusRoling.WriteGuiPrefExtra;
begin
  inherited;
    GuiPrefs.Node['General.ExcludeSO'].asBoolean         := chkExcludeSO.checked;
    GuiPrefs.Node['General.AgingonTransDate'].asBoolean  := chkAging.checked;
    GuiPrefs.Node['General.HideRunningQty'].asBoolean    := chkHideRunningQty.checked;
end;

initialization
  RegisterClassOnce(TStockStatusRoling);

end.
