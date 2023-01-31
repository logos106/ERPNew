unit ProcessProgressAllocSQL;

interface
uses
  classes, ReportBaseObj, Types;

type

  TProcessProgressAllocReport = class(TReportWithDateRangeBase)
  private
(*    fDateFrom: TDateTime;
    fDateTo: TDateTime;*)
    fSaleID: integer;
    fSaleLineID: integer;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
//    property TempTableName: string read GetTempTableName;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
(*    property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;*)
    property SaleID: integer read fSaleID write fSaleID;
    property SaleLineID: integer read fSaleLineID write fSaleLineID;
  end;

implementation

uses
  SysUtils, ProductQtyLib;

{ TProcessProgressAllocReport }

constructor TProcessProgressAllocReport.Create;
begin
  inherited;
  fSaleID := 0;
  fSaleLineID := 0;
  DateFrom := 0;
  DateTo := MaxDateTime;
  IgnoreDates := true;
end;

destructor TProcessProgressAllocReport.Destroy;
begin

  inherited;
end;

function TProcessProgressAllocReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
var
  s: string;
begin
  inherited;
  result := true;
  SQL.Clear;
  SQL.add('Select');
  SQL.add('SL.SaleLineID,');
  SQL.add('convert(@salelineNo:=if(@salelineID <> Sl.salelineID,  @salelineNo:= 1 ,  @salelineNo+1), unsigned) as SaleLineNo,');
  SQL.add(' @salelineID := Sl.salelineID,');
  SQL.add(' convert(@PPInNo:=if(@PPInID <> PPIN.ProcProgressID,  @PPcolorno:= if(@PPcolorno=1 ,2,1) , @PPcolorno), unsigned) as PPColorNo,');
  SQL.add('convert(@PPInNo:=if(@PPInID <> PPIN.ProcProgressID,  @PPInNo:= 1 ,  @PPInNo+1), unsigned) as PPInNo,');
  SQL.add(' @PPInID := PPIN.ProcProgressID,');
  SQL.add('Sl.saleId      as SaleID,');
  SQL.add('SL.ProductName as ProductName,');
  SQL.add('Concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")" )  as UOM ,');
  SQL.add('Convert(TreeNodeCaption(PT.Level, PT.caption ),char(255)) as Caption  ,');
  SQL.add('Concat(PPIN.uom , "(" , PPIN.uomMultiplier , ")" )                           as UOMMult ,');
  SQL.add('if(PPIN.buildstatus ="W", "Wastage" , if(PPIN.buildstatus ="D", "Done" ,"On Hold" )) as BuildStatus,');
  SQL.add('PPIN.Progressdate      as BuildDate,');
  SQL.add('PPIN.uomqty            as InQty,');
  SQL.add('PPout.uomqty           as OutQty, ');
  SQL.add('Pin.partname           as PartNameIn, ');
  SQL.add('Pout.partname          as PartNameOut, ');
  SQL.add('PQABatchin.Value       as BatchNoIn ,');
  SQL.add('PQABatchin.UOMQty      as BatchQtyIn,');
  SQL.add('PQABatchin.ExpiryDate  as ExpiryDateIn,');
  SQL.add('PBInIn.binlocation     as BinLocationIn,');
  SQL.add('PBInIn.Binnumber       as BinNumberIn,');
  SQL.add('PQAbinsin.UOMQty       as BinQtyIn,');
  SQL.add('PQASNin.value          as SerialNumberIn,');
  SQL.add('PQAsnin.UOMQty         as SNQtyIn,');
  SQL.add('PQABatchout.Value      as BatchNoOut ,');
  SQL.add('PQABatchout.ExpiryDate as ExpiryDateOut,');
  SQL.add('PQABatchout.UOMQty     as BatchQtyOut,');
  SQL.add('PBInout.binlocation    as BinLocationOut,');
  SQL.add('PBInout.Binnumber      as BinNumberOut,');
  SQL.add('PQAbinsout.UOMQty      as BinQtyOut,');
  SQL.add('PQASNout.value         as SerialNumberOut,');
  SQL.add('PQAsnout.UOMQty        as SNQtyOut');
  SQL.add('from  ');
  SQL.add('(SELECT @PPInNo:=0) t1,  ');
  SQL.add('(SELECT @PPInID:=0) t2,  ');
  SQL.add('(SELECT @salelineNo:=0) t3 ,  ');
  SQL.add('(SELECT @salelineID:=0) t4,   ');
  SQL.add('(Select @PPcolorno := 0) as t5,  ');
  SQL.add('tblsales S inner join tblsaleslines SL on S.saleId = sl.saleId ' +
                  ' inner join tblproctree PT on PT.MasterId = SL.SaleLineID and PT.mastertype <> "mtProduct"');

  SQL.add('Left join tblprocProgress PPIN on PT.ProcTreeId = PPIN.ProcTreeId ');
  SQL.add(StringReplace(StringReplace(TransTables(tDetailswithSno  , 'PPIN' , 'SaleId' , 'ProcProgressID' , QuotedStr('TProcProgressIn' ),'In'),'PPIN.SaleID', 'SL.saleID',[rfReplaceAll,rfIgnoreCase]), 'inner join ' , 'Left join ',[rfReplaceAll,rfIgnoreCase]));
  SQL.add('Left join tblprocProgress PPOUT  on PPIN.ProcProgressID = PPOUT.InProcProgressId' );
  SQL.add(StringReplace(StringReplace(TransTables(tDetailswithSno , 'PPout' , 'SaleId' , 'ProcProgressID' , QuotedStr('TProcProgressOUT'), 'Out'),'PPout.SaleID', 'SL.saleID',[rfReplaceAll,rfIgnoreCase]), 'inner join ' , 'Left join ',[rfReplaceAll,rfIgnoreCase]));
  s := '';
  if SaleID > 0 then s := 'where S.SaleID = ' + IntToStr(SaleID);
  if SaleLineID > 0 then begin
    if s = '' then s := 'where'
    else s := s + ' and';
    s := s + ' Sl.saleLineId = ' + IntToStr(SaleLineID);
  end;
  (*if (DateFrom > 0) or (DateTo < MaxDateTime) then begin
    if s = '' then s := 'where'
    else s := s + ' and';
    s := s + ' S.saleDate Between "' + FormatDateTime('yyyy-mm-dd',DateFrom) + '" and "' + FormatDateTime('yyyy-mm-dd',DateTo) + '"';
  end;
  if s <> '' then
    SQL.Add(s);*)
    SQL.Add(' S.saleDate Between ' + DAteFromSQL + ' and ' + DAteToSQL ) ;
//  SQL.add(' where ((S.saleId      = :SaleId     or :SaleId     =0) ' +
//                  ' and    (Sl.saleLineId = :SaleLineId or :SaleLineId =0)   ' +
//                  ' and    (:IgnoreDates ="T" Or S.saleDate Between :Datefrom and :DateTo    ))');
  SQL.add(' Order by s.SaleId, sl.saleLineId , PT.TreeRootId , PPIN.Progressdate  , PPIN.ProcProgressID');

  if APIMode then begin
    SQL.Insert(0,
      'select ' +
      'SaleLineID,' +
      'SaleLineNo,' +
      'PPColorNo,' +
      'PPInNo,' +
      'SaleID,' +
      'ProductName,' +
      'UOM,' +
      'UOMMult,' +
      'BuildStatus,' +
      'BuildDate,' +
      'InQty,' +
      'OutQty,' +
      'PartNameIn,' +
      'PartNameOut,' +
      'BatchNoIn,' +
      'BatchQtyIn,' +
      'ExpiryDateIn,' +
      'BinLocationIn,' +
      'BinNumberIn,' +
      'BinQtyIn,' +
      'SerialNumberIn,' +
      'SNQtyIn,' +
      'BatchNoOut,' +
      'ExpiryDateOut,' +
      'BatchQtyOut,' +
      'BinLocationOut,' +
      'BinNumberOut,' +
      'BinQtyOut,' +
      'SerialNumberOut,' +
      'SNQtyOut from ('
     );
    SQL.Add(') as T');
  end;

end;

initialization
  RegisterClass(TProcessProgressAllocReport);

end.
