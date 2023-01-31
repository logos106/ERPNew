unit DataSnapshotObj;

interface

uses
  MyAccess, DB, kbmMemTable, DNMLib, SysUtils;

type
  TDataSnapshotObj = class(TObject)

  private
    qryTemp: TMyQuery;
    fmemSnapShotSuburbs: TkbmMemTable;
    fmemSnapShotProduct: TkbmMemTable;
    fmemSnapShotProductCombos: TkbmMemTable;
    procedure MemTableStartDefaultSetting(MemTable: TkbmMemTable);
    procedure MemTableReadyToUseDefaultSetting(MemTable: TkbmMemTable);
    procedure MakeProductSalesCombosSQL;
  public
    constructor Create;
    destructor Destroy; override;
    class procedure Instance;
    procedure PopulateMe(SSType: TSnapShotType);
    property SnapShotSuburbs: TkbmMemTable read fmemSnapShotSuburbs write fmemSnapShotSuburbs;
    property SnapShotProduct: TkbmMemTable read fmemSnapShotProduct write fmemSnapShotProduct;
    property SnapShotProductCombos: TkbmMemTable read fmemSnapShotProductCombos write fmemSnapShotProductCombos;
  end;

var
  DataSnapshot: TDataSnapshotObj;

implementation

uses
  Forms, CommonDbLib, ProgressDialog, AppEnvironment,
  FastFuncs, ProductQtyLib;

constructor TDataSnapshotObj.Create;
begin
  Inherited;
  if not Assigned(fmemSnapShotSuburbs) then begin
    fmemSnapShotSuburbs := TkbmMemTable.Create(nil);
    MemTableStartDefaultSetting(fmemSnapShotSuburbs);
  end;

  if not Assigned(fmemSnapShotProductCombos) then begin
    fmemSnapShotProductCombos := TkbmMemTable.Create(nil);
    MemTableStartDefaultSetting(fmemSnapShotProductCombos);
  end;
end;

procedure TDataSnapshotObj.MemTableStartDefaultSetting(MemTable: TkbmMemTable);
begin
  MemTable.Close;
  MemTable.Standalone := true;
  MemTable.DesignActivation := true;
  MemTable.AttachedAutoRefresh := true;
  MemTable.EmptyTable;
  MemTable.Performance := mtpfFast;
  MemTable.DisableControls;
  MemTable.EnableIndexes := false;
end;

procedure TDataSnapshotObj.MemTableReadyToUseDefaultSetting(MemTable: TkbmMemTable);
begin
  MemTable.Open;  
  MemTable.AutoAddIndexes := true;
  MemTable.AutoReposition := true;
  MemTable.EnableIndexes := true;
  MemTable.UpdateIndexes;
  MemTable.EnableControls;
  MemTable.SortOn(MemTable.SortFields, []);
end;

destructor TDataSnapshotObj.Destroy;
begin
  FreeAndNil(fmemSnapShotSuburbs);
  FreeAndNil(fmemSnapShotProductCombos);
  inherited Destroy;
end;

class procedure TDataSnapshotObj.Instance;
begin
  if not Assigned(DataSnapshot) then begin
    DataSnapshot := TDataSnapshotObj.Create;
  end;
end;

procedure TDataSnapshotObj.PopulateMe(SSType: TSnapShotType);
var
  TotalRecords, RecordCounter: integer;
  MemTable: TkbmMemTable;
  ProgressDialog: TProgressDialog;
begin
  ProgressDialog := TProgressDialog.Create(nil);
  if not Assigned(qryTemp) then begin
    qryTemp := TMyQuery.Create(nil);
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  end;
  TotalRecords := 0;
  MemTable := nil;
  try
    ProgressDialog.Caption  := 'Please Wait .......   Loading Snapshot of ' + SnapShotDesc[SSType];
    ProgressDialog.MinValue := 0;
    ProgressDialog.Step     := 1;
    ///////////////////////////
    //Setup MemTable Fields
    if (SSType = stSuburbs) then begin
      MemTable := fmemSnapShotSuburbs;
    end else if (SSType = stProductListCombos) then begin
      MemTable := fmemSnapShotProductCombos;
    end;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('FLUSH QUERY CACHE;');
    qryTemp.Execute; {win2k Error on This}
    qryTemp.Sql.Clear;

    if (SSType = stProductListCombos) then begin
      MakeProductSalesCombosSQL;
      qryTemp.Sql.Add(' Limit 0 ;');
    end else begin
      qryTemp.Sql.Add('SELECT * FROM ' + SnapShotFromTableName[SSType] + ' Limit 0 ;');
    end;
    qryTemp.Active := true;
    MemTable.LoadFromDataSet(qryTemp, [mtcpoStructure, mtcpoProperties]);
    ///////////////////////
    //Count Total Records
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('FLUSH QUERY CACHE;');
    qryTemp.Execute; {win2k Error on This}
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT Count(' + SnapShotFromTablePrimaryKey[SSType] + ') as RecordCount FROM ' +
      SnapShotFromTableName[SSType]);
    if (SSType = stSuburbs) then
      qryTemp.Sql.Add('Where RegionID='+FastFuncs.IntToStr(AppEnv.RegionalOptions.RegionID));
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      TotalRecords := qryTemp.FieldByName('RecordCount').AsInteger;
    end;

    ProgressDialog.MaxValue := Trunc(TotalRecords / Trunc(StrValue(SnapShotGetBatchSize[SSType]))) + 1;
    ProgressDialog.Execute;
    /////////////////////////////
    //Load Records Into MemTable
    RecordCounter := 0;
    while TotalRecords > RecordCounter do begin
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('FLUSH QUERY CACHE;');
      qryTemp.Execute; {win2k Error on This}
      qryTemp.Sql.Clear;

      if (SSType = stProductListCombos) then begin
        MakeProductSalesCombosSQL;
      end else begin
        qryTemp.Sql.Add('SELECT * FROM ' + SnapShotFromTableName[SSType]);
      end;

      if (SSType = stSuburbs) then
        qryTemp.Sql.Add('Where RegionID='+FastFuncs.IntToStr(AppEnv.RegionalOptions.RegionID));

      qryTemp.Sql.Add(' LIMIT ' + FastFuncs.IntToStr(RecordCounter) + ',' + SnapShotGetBatchSize[SSType] + ';');
      qryTemp.Active := true;
      if not qryTemp.IsEmpty then begin
        MemTable.LoadFromDataSet(qryTemp, [mtcpoAppend]);
        RecordCounter := RecordCounter + Trunc(StrValue(SnapShotGetBatchSize[SSType]));
        ProgressDialog.Stepit;
        Application.ProcessMessages;
      end else begin
        Break;
      end;
    end;
    MemTable.SortFields := SnapShotOrderBy[SSType];
    MemTableReadyToUseDefaultSetting(Memtable);
  finally
    FreeAndNil(qryTemp);
    FreeAndNil(ProgressDialog);
    qryTemp := nil;
  end;
end;

procedure TDataSnapshotObj.MakeProductSalesCombosSQL;
begin
  with qryTemp.SQL do begin
(*    Add('Select SUBSTRING_INDEX( Concat_WS("^",PRODUCTGROUP,"") ,"^",1) AS "Dept", ');
    Add('MID(SUBSTRING_INDEX( Concat_WS("^",PRODUCTGROUP,"") ,"^",2),  ');
    Add('Length(SUBSTRING_INDEX( Concat_WS("^",PRODUCTGROUP,"") ,"^",1))+2, ');
    Add('Length(SUBSTRING_INDEX( Concat_WS("^",PRODUCTGROUP,"") ,"^",2))- ');
    Add('Length(SUBSTRING_INDEX( Concat_WS("^",PRODUCTGROUP,"") ,"^",1))) AS "Type", ');
    Add('MID(SUBSTRING_INDEX( Concat_WS("^",PRODUCTGROUP,"") ,"^",3), ');
    Add('Length(SUBSTRING_INDEX( Concat_WS("^",PRODUCTGROUP,"") ,"^",2))+2, ');
    Add('Length(SUBSTRING_INDEX( Concat_WS("^",PRODUCTGROUP,"") ,"^",3))-  ');
    Add('Length(SUBSTRING_INDEX( Concat_WS("^",PRODUCTGROUP,"") ,"^",2))) AS "Manuf",  ');*)
    Add('Select ' +firstColumn('tblParts') + ' AS "Dept", ');
    Add(firstColumn('tblParts') + ' AS "Type", ');
    Add(firstColumn('tblParts') + ' AS "Manuf",  ');
    Add('PARTSID,PARTTYPE, PRODUCTGROUP, PARTNAME,PARTSDESCRIPTION, INCOMEACCNT,  ');
    Add('ASSETACCNT, COGSACCNT, BARCODE, PRODUCTCODE,TAXCODE,SpecialDiscount,  ');
    Add('SNTracking,  BuyQTY1, BuyQTY2,BuyQTY3, COST1, COST2, COST3, SellQTY1,  ');
    Add('SellQTY2, SellQTY3,PRICE1, PRICE2, PRICE3, WHOLESALEPRICE, Active, EditedFlag,  ');
    Add('AvgCost, Attrib1Sale, Attrib2Sale, Attrib1SaleRate,Batch,AutoBatch, MultipleBins,  ');
    Add('Attrib1Purchase, Attrib2Purchase, Attrib1PurchaseRate,PurchaseDesc,PurchTaxCode,PreferedSupp, ');
    Add('LatestCost, LatestCostDate ');
    Add('FROM tblparts Where Active ="T" ');
  end;
end;

initialization
  //  TDataSnapshotObj.Instance;       -- Go in frmLogonFrm

finalization
  if DataSnapshot <> nil then begin
    FreeAndNil(DataSnapshot);
  end;
end.
