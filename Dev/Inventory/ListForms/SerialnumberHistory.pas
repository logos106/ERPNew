unit SerialnumberHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseInputForm, DAScript,
  MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSerialNumberHistoryGUI = class(TBaseListingGUI)
    qryMainSerialnumber : TWideStringField;
    qryMaintransDate    : TDateTimeField;
    qryMaintranstype    : TWideStringField;
    qryMainbinLocation  : TWideStringField;
    qryMainbinnumber    : TWideStringField;
    qryMainBatchno      : TWideStringField;
    qryMainexpirydate   : TDateTimeField;
    qryMainTRansactionNo: TLargeintField;
    qryMainFormName     : TWideStringField;
    qryMainStockmovementEntryglobalref: TWideStringField;
    qryMainStockmovementEntryType: TWideStringField;
    qryMainClassname: TWideStringField;
    qryMainalloctype: TWideStringField;
    qryMainInstockQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMainuom: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fsSerialnumber  : string;
    fiPartsId       : integer;
    fsTablename :String;
    procedure setSerialNumber(const Value: string);
    procedure setPartsID(const Value: integer);
    Procedure makeQrymain;
    Procedure PopulateData;
  Protected
    Procedure AssignKeyId(Popupform :TBaseInputGUI);  override;
    Procedure SetGridColumns;override;
  public
    Property Serialnumber :string   Read fsSerialnumber Write setSerialNumber;
    Property PartsID      :integer  REad fiPartsId      Write setPartsID;
    Procedure RefreshQuery; override;
  end;

implementation

uses CommonLib, DateUtils, BusobjStockAdjustEntry, busobjstockTransferentry ,
  tcConst, tcDataUtils, PQALib, LogLib, CommonDbLib, MySQLConst;
                                                         {$R *.dfm}

{ TBaseListingGUI1 }

procedure TSerialNumberHistoryGUI.RefreshQuery;
begin
  (*Qrymain.Parambyname('Datefrom').asDatetime := FilterDateFrom;
  Qrymain.Parambyname('DateTo').asDatetime := FilterDateto;*)
  PopulateData;
  inherited;
  Qrymain.FieldByname('transDate').DisplayLabel     := 'Date';
  Qrymain.FieldByname('transtype').DisplayLabel     := 'Trans Type';
  Qrymain.FieldByname('binLocation').DisplayLabel   := 'Bin Location';
  Qrymain.FieldByname('binnumber').DisplayLabel     := 'Bin Number';
  Qrymain.FieldByname('Batchno').DisplayLabel       := 'Batch No';
  Qrymain.FieldByname('expirydate').DisplayLabel    := 'Expiry Date';
  Qrymain.FieldByname('TRansactionNo').DisplayLabel := 'Transaction No';
end;

procedure TSerialNumberHistoryGUI.setPartsID(const Value: Integer);
begin
  if fiPartsId <> Value then begin
    fiPartsId := Value;
    RefreshQuery;
  end;
  (*qrymain.DisableControls;
  try
    if qrymain.Active then qrymain.close;
    qrymain.Params.ParamByName('PartsID').asInteger := Value ;
  finally
      qrymain.EnableControls;
  end;*)
end;

procedure TSerialNumberHistoryGUI.setSerialNumber(const Value: string);
begin
  if fsSerialnumber <> Value then begin
    fsSerialnumber := Value;
    RefreshQuery;
  end;
  (*qrymain.DisableControls;
  try
    if qrymain.Active then qrymain.close;
    qrymain.Params.ParamByName('Serialnumber').asString := Value ;
    TitleLabel.Caption := {'Serial Number history :' + }Value;
  finally
      qrymain.EnableControls;
  end;*)
end;
procedure TSerialNumberHistoryGUI.FormCreate(Sender: TObject);
begin
  makeQrymain;
(*  Qrymain.sql.text := replacestr(replacestr(Qrymain.sql.text , '0.0 as InstockQty'  , pqalib.SQL4QtyField(tInStock  , 'PQA','if(ifnull(PQASN.pqadetailID,0)<>0 , PQASN.qty , if(ifnull(PQABins.pqadetailID,0)<>0 , PQABins.qty ,if(ifnull(PQAbatch.pqadetailID,0)<>0 , PQAbatch.qty ,pqa.qty ) ))'  ) +' as InstockQty') ,
                                                               '0.0 as AvailableQty', pqalib.SQL4QtyField(tAvailable  ,'PQA', 'if(ifnull(PQASN.pqadetailID,0)<>0 , PQASN.qty , if(ifnull(PQABins.pqadetailID,0)<>0 , PQABins.qty ,if(ifnull(PQAbatch.pqadetailID,0)<>0 , PQAbatch.qty ,pqa.qty ) ))') +' as AvailableQty');
  clog(Qrymain.SQL.text);*)
  inherited;
end;

procedure TSerialNumberHistoryGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;
end;

procedure TSerialNumberHistoryGUI.grdMainDblClick(Sender: TObject);
begin
       if qryMainStockmovementEntryType.AsString = StockAdjustEntryType   then SubsequentID := Chr(95) + AdjustType(TStockAdjustEntry.IDToggle(qryMainStockmovementEntryglobalref.asString))     +  qryMainStockmovementEntryType.AsString
  else if qryMainStockmovementEntryType.AsString = StockTransferEntryType then SubsequentID := Chr(95) + TransferType(TStockTransferEntry.IDToggle(qryMainStockmovementEntryglobalref.asString)) +  qryMainStockmovementEntryType.AsString
  else SubsequentID := Chr(95) + qryMainStockmovementEntryType.AsString;

  inherited;

end;

procedure TSerialNumberHistoryGUI.makeQrymain;
begin
  fsTablename := CommonDbLib.GetUserTemporaryTableName('snh' );
  Qrymain.sql.clear;
  Qrymain.sql.add('select');
  Qrymain.sql.add('*');
  Qrymain.sql.add('from '+ fstablename);
end;

procedure TSerialNumberHistoryGUI.PopulateData;
function SNQtyfieldname:String;
begin
  result := 'if(ifnull(PQASN.pqadetailID,0)<>0 , PQASN.qty , if(ifnull(PQABins.pqadetailID,0)<>0 , PQABins.qty ,if(ifnull(PQAbatch.pqadetailID,0)<>0 , PQAbatch.qty ,pqa.qty ) ))';
end;
begin
  With scriptmain do begin
    SQL.clear;
    SQL.add('drop table if exists '+ fstablename+';');
    SQL.add('CREATE TABLE  '+ fstablename+' ( '+
				    ' ID                          INT(11)       NOT NULL AUTO_INCREMENT, '+
				    ' Serialnumber                VARCHAR(100)      NULL DEFAULT NULL, '+
				    ' transDate                   DATETIME          NULL DEFAULT NULL, '+
				    ' uom                         VARCHAR(255)      NULL DEFAULT NULL, '+
				    ' binLocation                 VARCHAR(255)      NULL DEFAULT "", '+
				    ' binnumber                   VARCHAR(30)       NULL DEFAULT "", '+
				    ' Batchno                     VARCHAR(255)      NULL DEFAULT NULL, '+
				    ' expirydate                  DATETIME          NULL DEFAULT NULL, '+
				    ' TRansactionNo               INT(11) UNSIGNED  NULL DEFAULT NULL, '+
				    ' transtype                   VARCHAR(255)      NULL DEFAULT NULL, '+
				    ' InstockQty                  DOUBLE            NULL DEFAULT "0", '+
				    ' AvailableQty                DOUBLE            NULL DEFAULT "0", '+
				    ' formName                    VARCHAR(255)      NULL DEFAULT NULL, '+
				    ' StockmovementEntryglobalref VARCHAR(255)      NULL DEFAULT NULL, '+
				    ' StockmovementEntryType      VARCHAR(255)      NULL DEFAULT NULL, '+
				    ' Classname                   VARCHAR(255)      NULL DEFAULT "", '+
				    ' alloctype                   VARCHAR(10)       NULL DEFAULT NULL, '+
				    ' PRIMARY KEY (ID) ) COLLATE="utf8_general_ci" ENGINE=MyISAM ;');

    SQL.add('insert ignore into   '+ fstablename+
            ' ( Serialnumber,transDate ,uom ,binLocation ,binnumber ,Batchno ,expirydate ,TRansactionNo ,transtype , '+
				    '   InstockQty ,AvailableQty ,formName ,StockmovementEntryglobalref ,StockmovementEntryType ,Classname ,alloctype ) '+
				    ' Select '+
				    ' PQASN.Value as Serialnumber, '+
				    ' PQA.transDate as transDate, '+
				    ' concat(PQA.uom,"(" , PQA.uommultiplier , ")") as uom, '+
				    ' PBin.binLocation as binLocation , '+
				    ' PBin.binnumber as binnumber, '+
				    ' PQABatch.Value as Batchno, '+
				    ' PQABatch.expirydate as expirydate, '+
				    ' PQA.TransID as TRansactionNo, '+
				    ' if( StockmovementEntryType= "StockTransferEntry" , "Stock Transfer" , if( StockmovementEntryType= "StockAdjustEntry" , "Stock Adjustment" , TT.Description)) as transtype  , '+
				    pqalib.SQL4QtyField(tInStock  , 'PQA',SNQtyfieldname) +' as InstockQty , ' +
				    pqalib.SQL4QtyField(tAvailable,'PQA', SNQtyfieldname) +' as AvailableQty,'+
				    ' TT.formName as formName, '+
				    ' SM.StockmovementEntryglobalref as StockmovementEntryglobalref, '+
				    ' StockmovementEntryType as StockmovementEntryType, '+
				    ' C.Classname as Classname , '+
				    ' if(PQA.TransType = "TStockMovementLines" and alloctype ="IN" and pqasn.qty<0 , "OUT" , PQA.Alloctype) as alloctype '+
				    ' from tblPQADetails PQASN '+
				    ' Left join tblPQADetails PQABins on PQABins.PQAType = "BIN" and PQABins.globalref = PQASN.PArentref '+
				    ' Left join  tblPQADetails as PQABatch on PQABatch.PQAType = "Batch" and  ((PQABatch.globalref = PQASn.ParentRef) or (PQABatch.Globalref = PQABins.ParentRef)) '+
				    ' Left join tblProductbin as PBin on PBin.BinId = PQABins.Value '+
				    ' inner join tblPQA as PQA on PQASN.PQAID = PQA.PQAID '+
				    ' Left join tblstockmovement SM on SM.StockmovementID = PQA.TransID and PQA.TransType = "TStockMovementLines" '+
				    ' inner join tblpqatranstypes as TT on TT.Transtype = PQA.Transtype '+
				    ' inner join tblclass C on PQA.DepartmentId = C.ClassID '+
				    ' where PQASN.PQAType = "SN" and PQASN.Value =  '+quotedstr(fsSerialnumber)+
				    ' and PQA.TransDate Between '+ quotedStr(FormatDateTime(MysqlDateFormat , Filterdatefrom))+ ' and  ' + quotedStr(FormatDateTime(MysqlDateFormat , FilterDateto)) +
				    ' and PQA.ProductID =  '+ inttostr(fiPartsId)+
				    ' having InstockQty <> 0 or AvailableQty <>0 '+
				    ' Order by PQA.TransDate;');
    clog(SQL.text);
    ExecutewithProgress(False);
  end;

end;

procedure TSerialNumberHistoryGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMaintransDate.displayformat := FormatSettings.shortDateformat +' hh:nn:ss am/pm';
end;

procedure TSerialNumberHistoryGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  if qryMainStockmovementEntryType.AsString = StockAdjustEntryType then begin
      Popupform.KeyId := TStockAdjustEntry.IDToggle(qryMainStockmovementEntryglobalref.asString);
  end else if qryMainStockmovementEntryType.AsString = StockTransferEntrytype then begin
    Popupform.KeyId := TStockTransferEntry.IDToggle(qryMainStockmovementEntryglobalref.asString);
  end else
    inherited;

end;

procedure TSerialNumberHistoryGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Formname');
  RemoveFieldfromGrid('StockMovementEntryglobalref');
  RemoveFieldfromGrid('StockMovementEntrytype');
end;

initialization
    RegisterClassOnce(TSerialNumberHistoryGUI);

end.
