 unit UnallocatedQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TUnAllocatedQtyGUI = class(TBaseListingGUI)
    qryMainPARTNAME: TWideStringField;
    QrymainPArtsID :TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainBin: TWideStringField;
    qryMainBatch: TWideStringField;
    qryMainmultipleBins: TWideStringField;
    qryMainSNTracking: TWideStringField;
    qryMainUOMqty: TFloatField;
    qryMainUOMBQty: TFloatField;
    qryMainUOMSNQty: TFloatField;
    qryMainDiff1: TFloatField;
    qryMainDiff2: TFloatField;
    cmdAdjustAllocationall: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmdAdjustAllocationallClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    tablename:String;
  protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses pqalib, CommonDbLib, BusobjStockAdjustEntry, StockAdjustEntryList, CommonLib,
  tcConst, ProductQtyLib, LogLib;

{$R *.dfm}

{ TUnAllocatedQtyGUI }

procedure TUnAllocatedQtyGUI.cmdAdjustAllocationallClick(Sender: TObject);
begin

(*var
  SAOriginalno:string;
  form :Tcomponent;
begin
  DisableForm;
  try
      SAOriginalno := TStockAdjustEntry.AutoAdjustBin;
      if SAOriginalno <> '' then begin
          MessageDlgXP_Vista( 'Unallocated bin Quantity is allocated to the Default Bin.' +
                                  chr(13)+chr(13)+'The Original no of the Stock Adjustment(s): ' +SAOriginalno +
                                  chr(13) +Chr(13) +'Please make sure the stock adjustment(s) are processed.', mtInformation, [mbok], 0);
          form := GetComponentByClassName('TStockAdjustEntryListGUI');
          if assigned(Form) then begin
              TStockAdjustEntryListGUI(Form).FormStyle := fsMDIChild;
              TStockAdjustEntryListGUI(Form).qryMain.Filter := 'Originalno = ' +QuotedStr(SAOriginalno);
              TStockAdjustEntryListGUI(Form).qryMain.Filtered := True;
              TStockAdjustEntryListGUI(Form).BringToFront;
              Self.Close;
          end;
      end;
  finally
    EnableForm;
  end;*)
end;
procedure TUnAllocatedQtyGUI.grdMainCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);
begin
  inherited;
       if (QrymainBatch.asBoolean        =False) and Sametext(Field.fieldname , qrymainUOMqty.fieldname)   then DoGrayoutCell(AFont, ABrush)
  else if (QrymainMultipleBins.asBoolean =False) and Sametext(Field.fieldname , qrymainUOMbqty.fieldname)  then DoGrayoutCell(AFont, ABrush)
  else if (Qrymainsntracking.asBoolean   =False) and Sametext(Field.fieldname , qrymainUOMsnqty.fieldname) then DoGrayoutCell(AFont, ABrush);

  if (Qrymaindiff1.asFloat <> 0) and (QrymainBatch.asBoolean ) then
    if sametext(Field.fieldname, qrymaindiff1.fieldname) or
       sametext(Field.fieldname, qrymainuomqty.fieldname) or
       (QrymainMultipleBins.asBoolean and sametext(Field.fieldname, qrymainuombqty.fieldname)) or
       (not(QrymainMultipleBins.asBoolean) and Qrymainsntracking.asBoolean and sametext(Field.fieldname, qrymainuomsnqty.fieldname)) then Doredhighlight(Afont, ABrush);

  if (Qrymaindiff2.asFloat <> 0) and QrymainMultipleBins.asBoolean  then
    if sametext(Field.fieldname, qrymaindiff2.fieldname) or
       sametext(Field.fieldname, qrymainuombqty.fieldname) or
       sametext(Field.fieldname, qrymainuomsnqty.fieldname) then Doredhighlight(Afont, ABrush)

end;
procedure TUnAllocatedQtyGUI.FormCreate(Sender: TObject);
begin
  TableName := GetUserTemporaryTableName('budgetactuals');
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add('P.PartsId        as PartsId,');
  Qrymain.SQL.add('P.PARTNAME       as Partname,');
  Qrymain.SQL.add('C.ClassName      as classname,');
  Qrymain.SQL.add('concat(UOM.UnitName , " (" , UOM.Multiplier , ")") as UOM , ');
  Qrymain.SQL.add('concat(PB.BinLocation , "-" , PB.BinNumber) as Bin ,');
  Qrymain.SQL.add('T.Batch          as Batch, ');
  Qrymain.SQL.add('T.multipleBins   as multipleBins, ');
  Qrymain.SQL.add('T.SNTracking     as SNTracking, ');
  Qrymain.SQL.add('T.UOMqty         as UOMqty, ');
  Qrymain.SQL.add('T.UOMBQty        as UOMBQty,');
  Qrymain.SQL.add('T.UOMSNQty       as UOMSNQty,');
  Qrymain.SQL.add('T.Diff1          as Diff1,');
  Qrymain.SQL.add('T.Diff2          as Diff2');
  Qrymain.SQL.add('from '+tablename +' T');
  Qrymain.SQL.add('inner join tblParts P on P.PARTSID = T.ProductId');
  Qrymain.SQL.add('inner join tblclass C on C.ClassID= T.departmentId');
  Qrymain.SQL.add('inner join tblunitsofmeasure UOM on UOM.UnitID = T.uomid');
  Qrymain.SQL.add('left join tblproductbin PB on PB.BinID = T.DefaultbinId');
  Qrymain.SQL.add('order by Partname , classname');
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TUnAllocatedQtyGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;
end;



procedure TUnAllocatedQtyGUI.RefreshQuery;
begin
  With scriptmain do begin
      SQL.clear;
      SQL.add(' Drop table if exists '+ TABLENAME +'1;');
      SQL.add(' CREATE TABLE '+ TABLENAME +'1 ( '+
          ' ProductId     INT(11) DEFAULT NULL, '+
          ' departmentId  INT(11) DEFAULT NULL, '+
          ' uomid         INT(11) DEFAULT NULL, '+
          ' uom           VARCHAR(255) DEFAULT NULL, '+
          ' DefaultbinId  INT(11) DEFAULT NULL, '+
          ' Batch         ENUM("F","T") CHARACTER SET latin1 NOT NULL DEFAULT "F", '+
          ' multipleBins  ENUM("T","F") CHARACTER SET latin1 NOT NULL DEFAULT "F", '+
          ' SNTracking    ENUM("T","F") CHARACTER SET latin1 NOT NULL DEFAULT "F", '+
          ' Qty           DOUBLE DEFAULT NULL, '+
          ' UOMqty        DOUBLE DEFAULT NULL, '+
          ' BQty          DOUBLE DEFAULT NULL, '+
          ' UOMBQty       DOUBLE DEFAULT NULL ,'+
          ' SNQty         DOUBLE DEFAULT NULL, '+
          ' UOMSNQty      DOUBLE DEFAULT NULL '+
          ' ) ENGINE=MyISAM DEFAULT CHARSET=UTF8;');

      SQL.add(' insert into '+ TABLENAME +'1 ' + NL+
                    ' select ProductId, departmentId, uomid, uom ,DefaultbinId , P.Batch, P.multipleBins , P.SNTracking ,  ' + NL+
                    ' Sum(Qty) Qty, sum(UOMQty) UOMqty, ' + NL+
                    ' sum(BQty) BQty , sum(UOMBQty) UOMBQty,' + NL+
                    ' sum(SNQty) SNQty , sum(UOMSNQty) UOMSNQty  ' + NL+
                    ' FROM ( ' + NL+
                            ' select PQA.PQAID, PQA.ProductID, PQA.ProductName, PQA.UOM, PQA.UOMID, pqa.DepartmentID, ' +
                            SQL4QtyField(tinstock , 'PQA' , 'PQAba.Qty' ) + ' as Qty, '+
                            SQL4QtyField(tinstock , 'PQA' , 'PQAba.UOMQTY') + ' as UOMQty, '+
                            ' null as BQty, null as UOMBQty, '+
                            ' null as SNQty, null as UOMSNQty, '+
                            ' null as DefaultbinId ' +NL +
                            ' from tblPQA PQA ' +NL +
                            ' inner join tblPQAdetails PQAba  on PQa.PQAID = PQABa.PQAID  and PQABa.PQAType = "Batch" ' +NL +
                            ' Inner Join tblproductclasses AS PC  ' +
                            ' ON PQA.ProductID = PC.ProductID AND PQA.DepartmentID = PC.ClassID ' +NL +
                            ' group by PQA.PQAID) as A2 ' +NL +
                    ' inner join tblParts P on P.PartsId = A2.ProductID   ' +
                    ' and ifnull(P.multipleBins,"F") = "T" '+
                ' group by ProductId, departmentId, uomid;' );
      SQL.add(' insert ignore into ' + tablename +  '1 '+
                    ' select ProductId, departmentId, uomid, uom ,DefaultbinId , P.Batch, P.multipleBins , P.SNTracking,' +
                    ' Sum(Qty) Qty, sum(UOMQty) UOMqty, ' +
                    ' sum(BQty) BQty , sum(UOMBQty) UOMBQty, ' +
                    ' sum(SNQty) SNQty , sum(UOMSNQty) UOMSNQty ' +
                    ' from ('  +NL +
                          ' select PQA.PQAID, PQA.ProductID, PQA.ProductName, PQA.UOM, PQA.UOMID, pqa.DepartmentID, ' +
                          ' null as Qty, null as uomqty, '+
                          SQL4Qty(tinstock , 'PQA' , 'PQABi.Qty') + ' as BQty, '+
                          SQL4Qty(tinstock , 'PQA' , 'PQABi.UOMQty') + ' as UOMBQty, '+
                          ' null as SNQty, null as UOMSNQty, '+
                          ' PC.DefaultbinId ' +NL +
                          ' from tblPQA PQA ' +NL +
                          ' inner join tblPQAdetails pqabi  on PQa.PQAID = pqabi.PQAID  and pqabi.PQAType = "Bin" ' +NL +
                          ' Inner Join tblproductclasses AS PC  ' +
                          ' ON PQA.ProductID = PC.ProductID AND PQA.DepartmentID = PC.ClassID ' +NL +
                          ' group by PQA.PQAID) as A2 ' +NL +
                    ' inner join tblParts P on P.PartsId = A2.ProductID   ' +
                    ' and ifnull(P.multipleBins,"F") = "T" '+
                    ' group by ProductId, departmentId, uomid; ' );

      SQL.add(' insert ignore into ' + tablename +  '1 '+
                    ' select ProductId, departmentId, uomid, uom ,DefaultbinId , P.Batch, P.multipleBins ,P.SNTracking, ' +
                    ' Sum(Qty) Qty, sum(UOMQty) UOMqty, ' +
                    ' sum(BQty) BQty , sum(UOMBQty) UOMBQty, ' +
                    ' sum(SNQty) SNQty , sum(UOMSNQty) UOMSNQty ' +
                    ' from ('  +NL +
                          ' select PQA.PQAID, PQA.ProductID, PQA.ProductName, PQA.UOM, PQA.UOMID, pqa.DepartmentID, ' +
                          ' null as Qty, null as uomqty, '+
                          ' null as BQty, null as UOMBQty, '+
                          SQL4Qty(tinstock , 'PQA' , 'PQASN.Qty') + ' as SNQty, '+
                          SQL4Qty(tinstock , 'PQA' , 'PQASN.UOMQty') + ' as UOMSNQty, '+
                          ' PC.DefaultbinId ' +NL +
                          ' from tblPQA PQA ' +NL +
                          ' inner join tblPQAdetails pqasn  on PQa.PQAID = pqasn.PQAID  and pqasn.PQAType = "SN" ' +NL +
                          ' Inner Join tblproductclasses AS PC  ' +
                          ' ON PQA.ProductID = PC.ProductID AND PQA.DepartmentID = PC.ClassID ' +NL +
                          ' group by PQA.PQAID) as A2 ' +NL +
                    ' inner join tblParts P on P.PartsId = A2.ProductID   ' +
                    ' and ifnull(P.SNTracking,"F") = "T" '+
                    ' group by ProductId, departmentId, uomid; ' );
      SQL.add('Drop table if exists '+ TABLENAME +'2;');
      SQL.add(' CREATE TABLE '+ TABLENAME +'2 ( '+
          ' ProductId     INT(11) DEFAULT NULL, '+
          ' departmentId  INT(11) DEFAULT NULL, '+
          ' uomid         INT(11) DEFAULT NULL, '+
          ' uom           VARCHAR(50) DEFAULT NULL, '+
          ' DefaultbinId  INT(11) DEFAULT NULL, '+
          ' Batch         ENUM("F","T") CHARACTER SET latin1 NOT NULL DEFAULT "F", '+
          ' multipleBins  ENUM("T","F") CHARACTER SET latin1 NOT NULL DEFAULT "F", '+
          ' SNTracking    ENUM("T","F") CHARACTER SET latin1 NOT NULL DEFAULT "F", '+
          ' Qty           DOUBLE DEFAULT NULL, '+
          ' UOMqty        DOUBLE DEFAULT NULL, '+
          ' BQty          DOUBLE DEFAULT NULL, '+
          ' UOMBQty       DOUBLE DEFAULT NULL ,'+
          ' SNQty         DOUBLE DEFAULT NULL, '+
          ' UOMSNQty      DOUBLE DEFAULT NULL '+
          ' ) ENGINE=MyISAM DEFAULT CHARSET=UTF8;  ');

      SQL.add(' INSERT INTO '+ TABLENAME +'2   ' +
                ' select ProductId, departmentId, uomid, uom ,DefaultbinId , Batch, multipleBins , SNTracking , ' +
                ' Sum(Qty) Qty, sum(UOMQty) UOMqty, ' +
                ' sum(BQty) BQty , sum(UOMBQty) UOMBQty ,' +
                ' sum(SNQty) SNQty , sum(UOMSNQty) UOMSNQty ' +
                ' from ( Select * from ' +Tablename + '1 ) as aaaa group by ProductId, departmentId, uomid;');

      SQL.add('Drop table if exists '+ TABLENAME +' ;');
      SQL.add(' CREATE TABLE '+ TABLENAME +' (  '+
          ' id            INT(11) NOT NULL AUTO_INCREMENT, '+
          ' ProductId     INT(11) DEFAULT NULL, '+
          ' departmentId  INT(11) DEFAULT NULL, '+
          ' uomid         INT(11) DEFAULT NULL, '+
          ' uom           VARCHAR(50) DEFAULT NULL, '+
          ' DefaultbinId  INT(11)  DEFAULT NULL, '+
          ' Batch         ENUM("F","T") CHARACTER SET latin1 NOT NULL DEFAULT "F", '+
          ' multipleBins  ENUM("T","F") CHARACTER SET latin1 NOT NULL DEFAULT "F", '+
          ' SNTracking    ENUM("T","F") CHARACTER SET latin1 NOT NULL DEFAULT "F", '+
          ' Qty           DOUBLE DEFAULT NULL, '+
          ' UOMqty        DOUBLE DEFAULT NULL, '+
          ' BQty          DOUBLE DEFAULT NULL, '+
          ' UOMBQty       DOUBLE DEFAULT NULL, '+
          ' SNQty         DOUBLE DEFAULT NULL, '+
          ' UOMSNQty      DOUBLE DEFAULT NULL, '+
          ' Diff1         DOUBLE DEFAULT NULL, '+
          ' Diff2         DOUBLE DEFAULT NULL, '+
          ' PRIMARY KEY (id) '+
          ' ) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=UTF8;');

      SQL.add(' INSERT IGNORE INTO '+ TABLENAME +' (  ProductId ,  departmentId ,  uomid ,  uom ,  DefaultbinId ,  Batch ,  multipleBins ,  SNTracking ,  Qty ,  UOMqty ,  BQty ,  UOMBQty,  SNQty ,  UOMSNQty ) '+
          'Select * ' +
              ' from ( select * from ' +Tablename + '2 ) as A1'+NL +
                ' where abs(ifnull(Qty,0))- abs(ifnull(BQty,0))>0.01 or abs(ifnull(UOMQty,0))- abs(ifnull(UOMBQty,0))>0.01 or '+
                'abs(ifnull(Qty,0))- abs(ifnull(SNQty,0))>0.01 or abs(ifnull(UOMQty,0))- abs(ifnull(UOMSNQty,0))>0.01 or '+
                'abs(ifnull(bQty,0))- abs(ifnull(SNQty,0))>0.01 or abs(ifnull(UOMbQty,0))- abs(ifnull(UOMSNQty,0))>0.01;');

      SQL.add('ALTER TABLE '+ tablename +'    ADD INDEX ProductID (ProductID),  '+
            ' ADD INDEX DepartmentID (DepartmentID),  '+
            ' ADD INDEX UOMID (UOMID),  '+
            ' ADD INDEX DefaultBinID (DefaultbinId);');
      SQL.add('Delete from  '+ TABLENAME +' where  Batch="F" and multipleBins = "F" and SNTracking ="F";');
      SQL.add('update  '+ TABLENAME +' Set  Diff1 =  ifnull(UOMqty,0)- ifnull(UOMBQty,0) where  Batch="T" and multipleBins = "T";');
      SQL.add('update  '+ TABLENAME +' Set  Diff1 =  ifnull(UOMqty,0)- ifnull(UOMBQty,0) where  Batch="T" and multipleBins = "F" and SNTracking ="T";');

      SQL.add('update  '+ TABLENAME +' Set  Diff2 =  ifnull(UOMBQty,0) - ifnull(UOMSNQty,0) where  multipleBins = "T" and SNTracking ="T";');
      SQL.add('Delete from  '+ TABLENAME +' where  ifnull(diff1,0)=0 and ifnull(Diff2,0)=0;');

      clog(SQL.text);
      Execute;
  end;
  inherited;
end;
procedure TUnAllocatedQtyGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainpartsID.fieldname);
end;

initialization
  RegisterClassOnce(TUnAllocatedQtyGUI);

end.

