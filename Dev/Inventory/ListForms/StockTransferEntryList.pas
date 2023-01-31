unit StockTransferEntryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TStockTransferEntryListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainTransferEntryID: TIntegerField;
    qryMainTransferFromClassID: TIntegerField;
    qryMainTransferFromClassName: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainCreationDate: TDateField;
    qryMainNotes: TWideMemoField;
    qryMainProcessed: TWideStringField;
    qryMainDateTransferred: TDateField;
    qryMainAccountname: TWideStringField;
    qryMaindescription: TWideStringField;
    qryMainsalesref: TWideStringField;
    btnDeleteall: TDNMSpeedButton;
    qryMainTransferToClassID: TIntegerField;
    qryMainTransferToClassName: TWideStringField;
    grpExtraOptions: TRadioGroup;
    qryMainCost: TFloatField;
    qryMainDetails: TLargeintField;
    qryMainStockMovementGlobalref: TWideStringField;
    qryMainAccountID: TIntegerField;
    qryMainbatch: TWideStringField;
    qryMainMultipleBins: TWideStringField;
    qryMainSNTracking: TWideStringField;
    qryMainBatchnumber: TWideStringField;
    qryMainExpiryDate: TDateTimeField;
    qryMainbatchqty: TFloatField;
    qryMainbinlocation: TWideStringField;
    qryMainBinnumber: TWideStringField;
    qryMainBinQty: TFloatField;
    qryMainSerialnumber: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainTransfertype: TWideStringField;
    qryMainHasAllocation: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnDeleteallClick(Sender: TObject);
    procedure grdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdMainKeyPress(Sender: TObject; var Key: Char);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    Inputformname:String;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);override;
    procedure SetGridColumns; Override;
    procedure RefreshTotals;override;
    Procedure MakeQrymain; virtual;
  public
    Procedure RefreshQuery; override;
  end;

implementation

uses CommonLib, frmStockTransferEntry, dAteUtils, AppEnvironment, CommonFormLib, tcDataUtils, busobjstockTransferentry,
  LogLib;

{$R *.dfm}

procedure TStockTransferEntryListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (grpExtraOptions.itemindex = 2) then begin

      if (qrymaindetails.asInteger = 2) and  qryMainHasAllocation.asBoolean then
        AFont.style :=  AFont.style  +[fsbold];

      if (qrymaindetails.asInteger = 2) then
        if sametext(Field.Fieldname ,qryMainTransferFromClassName.fieldname) Or
           sametext(Field.Fieldname ,qryMainTransferToClassName.fieldname) then AFont.color := ABrush.color;

      if (qrymaindetails.asInteger = 3) then begin
        if sametext(Field.Fieldname ,qryMainTransferFromClassName.fieldname) Or
           sametext(Field.Fieldname ,qryMainTransferToClassName.fieldname) Or
           sametext(Field.Fieldname ,qryMainBatchnumber.fieldname) Or
           sametext(Field.Fieldname ,qryMainExpiryDate.fieldname) Or
           sametext(Field.Fieldname ,qryMainbatchqty.fieldname) Or
           sametext(Field.Fieldname ,qryMainbinlocation.fieldname) Or
           sametext(Field.Fieldname ,qryMainBinnumber.fieldname) Or
           sametext(Field.Fieldname ,qryMainBinQty.fieldname) Or
           sametext(Field.Fieldname ,qryMainSerialnumber.fieldname) Or
           sametext(Field.Fieldname ,qryMainProductname.fieldname) Or
           sametext(Field.Fieldname ,qryMainTransfertype.fieldname) Or
           sametext(Field.Fieldname ,qryMainHasAllocation.fieldname) then else AFont.color := ABrush.color;

      if sametext(qryMainTransfertype.asString , 'IN')  and sametext(qryMainTransferFromClassName.fieldname , field.fieldname ) then AFont.color := ABrush.color
          else if sametext(qryMainTransfertype.asString , 'OUT')  and sametext(qryMainTransferToClassName.fieldname , field.fieldname ) then AFont.color := ABrush.color;
    end;

  end;
end;

procedure TStockTransferEntryListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + TransferType(qryMainTransferEntryID.asInteger) ;
  inherited;

end;

procedure TStockTransferEntryListGUI.grdMainKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
//
end;

procedure TStockTransferEntryListGUI.grdMainKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
//
end;

procedure TStockTransferEntryListGUI.grpFiltersClick(Sender: TObject);
begin

       if grpExtraOptions.ItemIndex = 0 then GroupFilterString := 'Details =1 '
  else if grpExtraOptions.ItemIndex = 1 then GroupFilterString := 'Details =2 '
  else GroupFilterString := '(Details =3 or Details =2)';
       if grpFilters.ItemIndex = 0 then GroupFilterString := GroupFilterString  +' and Deleted =' +Quotedstr('T')
  else if grpFilters.ItemIndex = 1 then GroupFilterString := GroupFilterString  +' and Processed <>' +Quotedstr('T')+' and Deleted = '+QuotedStr('F')
  else if grpFilters.ItemIndex = 2 then GroupFilterString := GroupFilterString  +' and Processed =' +Quotedstr('T');
  //if grpFilters.ItemIndex = 3 then GroupFilterString := '';
  FooterCalcfields[0].Total := 0;
  inherited;
  CalcnShowFooter;
end;

procedure TStockTransferEntryListGUI.RefreshQuery;
begin
  Qrymain.Params.ParamByName('FromDate').asDatetime := FilterDateFrom;
  Qrymain.Params.ParamByName('TOdate').asDatetime   := FilterdateTo;
  FooterCalcfields[0].Total := 0;
  inherited;
  CalcnShowFooter;
end;
procedure TStockTransferEntryListGUI.RefreshTotals;
begin
  inherited;
  FooterCalcfields[0].Total := 0;
  CalcnShowFooter;
end;

procedure TStockTransferEntryListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymaindetails.fieldname);
  RemoveFieldfromGrid(qryMainTransferToClassID.fieldname);
  RemoveFieldfromGrid(qryMainTransferFromClassID.fieldname);
  RemoveFieldfromGrid(qryMainEmployeeID.fieldname);
  RemoveFieldfromGrid(qryMainTransfertype.fieldname);
  RemoveFieldfromGrid(qryMainHasAllocation.fieldname);
  if Self.classnameis('TStockTransferEntryListSNGUI')  or Self.classnameis('TStockTransferEntryListBinGUI')   or Self.classnameis('TStockTransferEntryListBAtchGUI') then begin
    RemoveFieldfromGrid(qryMainbatch.fieldname);
    RemoveFieldfromGrid(qryMainMultipleBins.fieldname);
    RemoveFieldfromGrid(qryMainSNTracking.fieldname);
  end;
  if Self.classnameis('TStockTransferEntryListSNGUI')  or Self.classnameis('TStockTransferEntryListBinGUI')   then begin
    RemoveFieldfromGrid(qryMainBatchnumber.fieldname);
    RemoveFieldfromGrid(qryMainExpiryDate.fieldname);
    RemoveFieldfromGrid(qryMainbatchqty.fieldname);
  end;
  if Self.classnameis('TStockTransferEntryListSNGUI')  or Self.classnameis('TStockTransferEntryListBAtchGUI') then begin
    RemoveFieldfromGrid(qryMainbinlocation.fieldname);
    RemoveFieldfromGrid(qryMainBinnumber.fieldname);
    RemoveFieldfromGrid(qryMainBinQty.fieldname);
  end;
  if Self.classnameis('TStockTransferEntryListBinGUI')   or Self.classnameis('TStockTransferEntryListBAtchGUI') then begin
    RemoveFieldfromGrid(qryMainSerialnumber.fieldname);
  end;





end;

procedure TStockTransferEntryListGUI.btnDeleteallClick(Sender: TObject);
begin
  inherited;
  IterateProcno := 1;
  IterateRecords(true);
end;
procedure TStockTransferEntryListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  StockTransfer :TStockTransferEntry;
  begin
  inherited;
  if IterateProcNo=1 then begin
    //OpenERPForm('TfmStockAdjustEntry' ,qryMainStockAdjustEntryID.AsInteger , flagtodelete)
    StockTransfer :=TStockTransferEntry.CreateWithNewConn(Self);
    try
      StockTransfer.Load(qryMainTransferEntryID.AsInteger);
      StockTransfer.Connection.BeginNestedTransaction;
      try
        StockTransfer.Deleted := true;
        StockTransfer.Save;
        StockTransfer.Connection.CommitTransaction;
      Except
        on E:Exception do begin
          StockTransfer.Connection.RollbackTransaction;
        end;
      end;
    finally
      Freeandnil(StockTransfer);
    end;

  end;
end;


procedure TStockTransferEntryListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm(Inputformname , 0);
end;

procedure TStockTransferEntryListGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  UseSortinSearch         := false;
  DisableSortoncolumtitleclick:= TRue;
  Addcalccolumn('Cost', true);
  self.fbEnableWebSearch:= true;
  inputformName := 'TfmStockTransferEntryTree';
end;
procedure TStockTransferEntryListGUI.MakeQrymain;
begin
  closedb(Qrymain);
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('SELECT ');
  Qrymain.SQL.add('distinct 1 as Details, ');
  Qrymain.SQL.add('ST.TransferEntryID as TransferEntryID, ');
  Qrymain.SQL.add('ST.StockMovementGlobalref as StockMovementGlobalref, ');
  Qrymain.SQL.add('ST.TransferFromClassID as TransferFromClassID, ');
  Qrymain.SQL.add('ST.TransferFromClassName as TransferFromClassName, ');
  Qrymain.SQL.add('null as Productname , ');
  Qrymain.SQL.add('null as TransferEntryLinesID , ');
  Qrymain.SQL.add('NULL as TransferToClassID, ');
  Qrymain.SQL.add('NULL as  TransferToClassName, ');
  Qrymain.SQL.add('ST.EmployeeID as EmployeeID, ');
  Qrymain.SQL.add('ST.GlobalRef as GlobalRef, ');
  Qrymain.SQL.add('ST.EmployeeName as EmployeeName, ');
  Qrymain.SQL.add('Date(ST.DateTransferred) as DateTransferred, ');
  Qrymain.SQL.add('ST.Deleted as Deleted, ');
  Qrymain.SQL.add('ST.CreationDate as CreationDate, ');
  Qrymain.SQL.add('ST.Notes as Notes, ');
  Qrymain.SQL.add('ST.Processed as Processed, ');
  Qrymain.SQL.add('ST.AccountID as AccountID, ');
  Qrymain.SQL.add('ST.Accountname as Accountname , ');
  Qrymain.SQL.add('ST.description as description, ');
  Qrymain.SQL.add('ST.salesref as salesref,           ');
  Qrymain.SQL.add('Round(sum(STL.AssetValue * STL.TransferQty), 2) as Cost , ');
  Qrymain.SQL.add('P.batch as batch, ');
  Qrymain.SQL.add('P.MultipleBins as MultipleBins, ');
  Qrymain.SQL.add('P.SNTracking as SNTracking, ');
  Qrymain.SQL.add('Null as HasAllocation, ');
  Qrymain.SQL.add('CONVERT(NULL , CHAR(255)) as Batchnumber,  ');
  Qrymain.SQL.add('CONVERT(NULL , DATETIME) as ExpiryDate,  ');
  Qrymain.SQL.add('CONVERT(NULL , DECIMAL) as batchqty, ');
  Qrymain.SQL.add('CONVERT(NULL , CHAR(255))  as binlocation, ');
  Qrymain.SQL.add('CONVERT(NULL , CHAR(255))  as Binnumber, ');
  Qrymain.SQL.add('CONVERT(NULL , DECIMAL) as BinQty  , ');
  Qrymain.SQL.add('CONVERT(NULL , CHAR(255))  as Serialnumber ,');
  Qrymain.SQL.add('Null as Transfertype');
  Qrymain.SQL.add('from tblStockTransferEntry ST ');
  Qrymain.SQL.add('inner join tblstocktransferentrylines STL on ST.TransferEntryID = STL.TransferEntryID ');
  Qrymain.SQL.add('inner join tblparts P on P.partsId = STL.productID ');

  Qrymain.SQL.add('Where datetransferred between  :FromDate and   :TOdate ');
       if Self.classnameis('TStockTransferEntryListSNGUI')    then Qrymain.SQL.add('and TransferType =''SN''')
  else if Self.classnameis('TStockTransferEntryListBinGUI')   then Qrymain.SQL.add('and TransferType =''Bin''')
  else if Self.classnameis('TStockTransferEntryListBAtchGUI') then Qrymain.SQL.add('and TransferType =''Batch''');

  Qrymain.SQL.add('group by TransferEntryId ');

  Qrymain.SQL.add('union all ');

  Qrymain.SQL.add('SELECT ');
  Qrymain.SQL.add('Distinct 2 as Details, ');
  Qrymain.SQL.add('ST.TransferEntryID as TransferEntryID, ');
  Qrymain.SQL.add('ST.StockMovementGlobalref as StockMovementGlobalref, ');
  Qrymain.SQL.add('ST.TransferFromClassID as TransferFromClassID, ');
  Qrymain.SQL.add('ST.TransferFromClassName as TransferFromClassName, ');
  Qrymain.SQL.add('STL.Productname as Productname , ');
  Qrymain.SQL.add('STL.TransferEntryLinesID as TransferEntryLinesID , ');
  Qrymain.SQL.add('STL.ClassIDTo  as TransferToClassID,                   ');
  Qrymain.SQL.add('STL.ClassNameTo as  TransferToClassName, ');
  Qrymain.SQL.add('ST.EmployeeID as EmployeeID, ');
  Qrymain.SQL.add('ST.GlobalRef as GlobalRef, ');
  Qrymain.SQL.add('ST.EmployeeName as EmployeeName, ');
  Qrymain.SQL.add('Date(ST.DateTransferred) as DateTransferred, ');
  Qrymain.SQL.add('ST.Deleted as Deleted, ');
  Qrymain.SQL.add('ST.CreationDate as CreationDate, ');
  Qrymain.SQL.add('ST.Notes as Notes, ');
  Qrymain.SQL.add('ST.Processed as Processed, ');
  Qrymain.SQL.add('ST.AccountID as AccountID, ');
  Qrymain.SQL.add('ST.Accountname as Accountname , ');
  Qrymain.SQL.add('ST.description as description, ');
  Qrymain.SQL.add('ST.salesref as salesref, ');
  Qrymain.SQL.add('Round((STL.AssetValue * STL.TransferQty), 2) as Cost , ');
  Qrymain.SQL.add('P.batch as batch, ');
  Qrymain.SQL.add('P.MultipleBins as MultipleBins, ');
  Qrymain.SQL.add('P.SNTracking as SNTracking, ');
  Qrymain.SQL.add('if(ifnull(PQAD.PQADetailID,0) =0, "F" , "T") as HasAllocation, ');
  Qrymain.SQL.add('CONVERT(NULL , CHAR(255)) as Batchnumber,  ');
  Qrymain.SQL.add('CONVERT(NULL , DATETIME) as ExpiryDate,  ');
  Qrymain.SQL.add('CONVERT(NULL , DECIMAL) as batchqty, ');
  Qrymain.SQL.add('CONVERT(NULL , CHAR(255))  as binlocation, ');
  Qrymain.SQL.add('CONVERT(NULL , CHAR(255))  as Binnumber, ');
  Qrymain.SQL.add('CONVERT(NULL , DECIMAL) as BinQty  , ');
  Qrymain.SQL.add('CONVERT(NULL , CHAR(255))  as Serialnumber ,');
  Qrymain.SQL.add('Null as Transfertype');
  Qrymain.SQL.add('from tblStockTransferEntry ST ');
  Qrymain.SQL.add('inner join tblstocktransferentrylines STL on ST.TransferEntryID = STL.TransferEntryID ');
  Qrymain.SQL.add('Left join `tblstocktransferentrypqa` as PQA on PQA.TransLineID = STL.TransferEntryLinesID and PQA.TransType in ("TSTELinesTree",  "TSTELinesTreeIn") ');
  Qrymain.SQL.add('left join `tblstocktransferentrypqadetails` PQAD on PQAD.PQAId 	= PQA.PQAID  ');
  Qrymain.SQL.add('inner join tblparts P on P.partsId = STL.productID ');

  Qrymain.SQL.add('Where datetransferred between  :FromDate and   :TOdate ');
       if Self.classnameis('TStockTransferEntryListSNGUI')    then Qrymain.SQL.add('and TransferType =''SN''')
  else if Self.classnameis('TStockTransferEntryListBinGUI')   then Qrymain.SQL.add('and TransferType =''Bin''')
  else if Self.classnameis('TStockTransferEntryListBAtchGUI') then Qrymain.SQL.add('and TransferType =''Batch''');

  Qrymain.SQL.add('Union All ');

  Qrymain.SQL.add('SELECT ');
  Qrymain.SQL.add('3 as Details, ');
  Qrymain.SQL.add('ST.TransferEntryID as TransferEntryID, ');
  Qrymain.SQL.add('ST.StockMovementGlobalref as StockMovementGlobalref, ');
  Qrymain.SQL.add('ST.TransferFromClassID as TransferFromClassID, ');
  Qrymain.SQL.add('ST.TransferFromClassName as TransferFromClassName, ');
  Qrymain.SQL.add('STL.Productname as Productname , ');
  Qrymain.SQL.add('STL.TransferEntryLinesID as TransferEntryLinesID , ');
  Qrymain.SQL.add('STL.ClassIDTo  as TransferToClassID, ');
  Qrymain.SQL.add('STL.ClassNameTo as  TransferToClassName, ');
  Qrymain.SQL.add('ST.EmployeeID as EmployeeID, ');
  Qrymain.SQL.add('ST.GlobalRef as GlobalRef, ');
  Qrymain.SQL.add('ST.EmployeeName as EmployeeName, ');
  Qrymain.SQL.add('Date(ST.DateTransferred) as DateTransferred, ');
  Qrymain.SQL.add('ST.Deleted as Deleted, ');
  Qrymain.SQL.add('ST.CreationDate as CreationDate, ');
  Qrymain.SQL.add('ST.Notes as Notes, ');
  Qrymain.SQL.add('ST.Processed as Processed, ');
  Qrymain.SQL.add('ST.AccountID as AccountID, ');
  Qrymain.SQL.add('ST.Accountname as Accountname , ');
  Qrymain.SQL.add('ST.description as description, ');
  Qrymain.SQL.add('ST.salesref as salesref, ');
  Qrymain.SQL.add('Round((STL.AssetValue * STL.TransferQty), 2) as Cost , ');
  Qrymain.SQL.add('P.batch, ');
  Qrymain.SQL.add('P.MultipleBins , ');
  Qrymain.SQL.add('P.SNTracking, ');
  Qrymain.SQL.add('Null as HasAllocation, ');
  if  Self.classnameis('TStockTransferEntryListGUI')   or Self.classnameis('TStockTransferEntryListBAtchGUI')   then begin
    Qrymain.SQL.add('PQABatch.Value as Batchnumber, ');
    Qrymain.SQL.add('PQABatch.ExpiryDate as ExpiryDate, ');
    Qrymain.SQL.add('PQABatch.UOMQty as batchqty, ');
  end else begin
    Qrymain.SQL.add('CONVERT(NULL , CHAR(255)) as Batchnumber,  ');
    Qrymain.SQL.add('CONVERT(NULL , DATETIME) as ExpiryDate,  ');
    Qrymain.SQL.add('CONVERT(NULL , DECIMAL) as batchqty, ');
  end;
  if  Self.classnameis('TStockTransferEntryListGUI')   or Self.classnameis('TStockTransferEntryListBinGUI')   then begin
      Qrymain.SQL.add('PBin.binlocation as binlocation, ');
      Qrymain.SQL.add('PBin.Binnumber as Binnumber, ');
      Qrymain.SQL.add('PQABins.UOMQty as BinQty , ');
  end else begin
      Qrymain.SQL.add('CONVERT(NULL , CHAR(255))  as binlocation, ');
      Qrymain.SQL.add('CONVERT(NULL , CHAR(255))  as Binnumber, ');
      Qrymain.SQL.add('CONVERT(NULL , DECIMAL) as BinQty  , ');
  end;
  if  Self.classnameis('TStockTransferEntryListGUI')   or Self.classnameis('TStockTransferEntryListSNGUI')   then begin
    Qrymain.SQL.add('PQASN.Value as Serialnumber ,');
  end else begin
    Qrymain.SQL.add('CONVERT(NULL , CHAR(255))  as Serialnumber ,');
  end;
  Qrymain.SQL.add('if(PQA.TransType ="TSTELinesTree" , "OUT" , "IN") as Transfertype');
  Qrymain.SQL.add('from tblStockTransferEntry ST ');
  Qrymain.SQL.add('inner join tblstocktransferentrylines STL on ST.TransferEntryID = STL.TransferEntryID ');
  Qrymain.SQL.add('inner join tblparts P on P.partsId = STL.productID ');
  Qrymain.SQL.add('inner join `tblstocktransferentrypqa` as PQA on PQA.TransLineID = STL.TransferEntryLinesID and PQA.TransType in ("TSTELinesTree",  "TSTELinesTreeIn")  and PQAID in (Select PQAID from tblstocktransferentrypqadetails) ');

  {batches}
  if  Self.classnameis('TStockTransferEntryListGUI')   or Self.classnameis('TStockTransferEntryListBAtchGUI')   then begin
    Qrymain.SQL.add('  left join `tblstocktransferentrypqadetails` PQABatch on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"   ');
  end;


  {bins}
  if  Self.classnameis('TStockTransferEntryListGUI')   then begin
      Qrymain.SQL.add('  left join `tblstocktransferentrypqadetails` PQABins on PQABins.PQAId 	= PQA.PQAID  ' +
                                        ' and PQABins.PQAType = "Bin" and   ' +
                                        ' ((PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T" and P.multiplebins = "T")   ' +
                                        '  or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T"))   ' +
                                        ' 	Left join `tblProductBin` PBin    on PBin.binId 	= PQABins.BinID ');

  end else if  Self.classnameis('TStockTransferEntryListBinGUI')   then begin
      Qrymain.SQL.add('  left join `tblstocktransferentrypqadetails` PQABins on PQABins.PQAId 	= PQA.PQAID  ' +
                                        ' and PQABins.PQAType = "Bin" and   ' +
                                        '  (ifnull(PQABins.Parentref ,"") = "" and P.multiplebins = "T")   ' +
                                        ' 	Left join `tblProductBin` PBin    on PBin.binId 	= PQABins.BinID ');
  end;

  {Serial numebrs}
  if  Self.classnameis('TStockTransferEntryListGUI')   then begin
      Qrymain.SQL.add('  left join `tblstocktransferentrypqadetails` PQASN   on (PQASN.PQAId 	= PQA.PQAID and PQASN.PQAType = "SN"   and PQASN.Qty <> 0   ' +
                                        ' and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T")   ' +
                                        ' or (PQABins.Globalref = IFNULL(PQASN.ParentRef,"") and P.Multiplebins = "T" and P.SNTracking = "T")   ' +
                                        ' or ((ifnull(PQASN.Parentref ,"") = "") and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T"))) ');
  end else if  Self.classnameis('TStockTransferEntryListSNGUI')   then begin
      Qrymain.SQL.add('  left join `tblstocktransferentrypqadetails` PQASN   on PQASN.PQAId 	= PQA.PQAID and PQASN.PQAType = "SN"   and PQASN.Qty <> 0   ' +
                                        ' and  ((ifnull(PQASN.Parentref ,"") = "") and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T") ');
  end;

  Qrymain.SQL.add('Where datetransferred between  :FromDate and   :TOdate ');
       if Self.classnameis('TStockTransferEntryListSNGUI')    then Qrymain.SQL.add('and TransferType =''SN''')
  else if Self.classnameis('TStockTransferEntryListBinGUI')   then Qrymain.SQL.add('and TransferType =''Bin''')
  else if Self.classnameis('TStockTransferEntryListBAtchGUI') then Qrymain.SQL.add('and TransferType =''Batch''');

  Qrymain.SQL.add('order by datetransferred  Desc , TransferEntryId desc  , TransferEntryLinesID , details, Transfertype desc ');
  logtext(classname );
  logtext(Qrymain.SQL.text);

end;

initialization
  RegisterClassOnce(TStockTransferEntryListGUI);

end.
