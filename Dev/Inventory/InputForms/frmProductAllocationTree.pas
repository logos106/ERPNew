unit frmProductAllocationTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BusobjStock, BaseTreeView, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, Shader, StdCtrls,
  wwdbdatetimepicker, VirtualTrees, DNMSpeedButton, ExtCtrls, DNMPanel,
  MemDS, ImgList, ProgressDialog;

type
  TfmProductAllocationTree = class(TBaseTreeViewGUI)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    fiProductId: Integer;
    fProduct :TProduct;
    fiClassID: Integer;
    qbatch, qbins,qsn :TERPQuery;
    Fixedcols:Integer;
    Datacols :Integer;
    Batchcols:Integer;
    Batchbincols:Integer;

    Function getFixedcols:Integer;
    Function getBatchcols:Integer;
    Function getBatchbincols:Integer;
    function getProduct: TProduct;
    Procedure RefreshBatch(const ParentNode:PVirtualNode);
    Procedure RefreshBins(const ParentNode:PVirtualNode; const UOM:String=''; const batchno :STring='';  const expiryDate:TDateTime=0);
    Procedure RefreshSN(const ParentNode:PVirtualNode; const UOM:String=''; const batchno :STring='';  const expiryDate:TDateTime=0; const binlocation:STring = ''; const Binnumber :String = '');
    Procedure DisplayDetails(const Data:TNodeData; const qry:TERPQuery; const topLevel:Boolean =True);
    Function GetBatchNo:String;
    Function GetExpiryDate:TDateTime;
    Function GetBinLocation:String;
    Function GetBinNumber:String;
    Function GetSerialnumber:String;
    Function GetUOM:String;
    Function GetInstockQty:Double;
    Function GetAvailableQty:Double;
    Function GetSOQty:Double;
    procedure InitHiddencol(Data: TNodeData; Qry: TERPQuery);
    function GuiPrefcolumnWidth(const colname: String): Integer;
    function cBatchno:Integer;
    function cExpiryDate:Integer;
    function cBinLocation:Integer;
    function cBinNumber:Integer;
    function cSerialNumber:Integer;
    function cUOM:Integer;
    function cInstockQty:Integer;
    function cAvailableQty:Integer;
    function cSOQty:Integer;
  Protected
    Procedure WriteGuiPref; Overload; Override;
  public
    Property ProductId :Integer read fiProductId  write fiProductId;
    Property ClassID   :Integer Read fiClassID    Write fiClassID;
    Property Product :TProduct Read getProduct;
    procedure RefreshTree; override;
    Property BatchNo      :String     read getBatchno;
    Property ExpiryDate   :TDateTime  read getExpiryDate;
    Property BinLocation  :String     read getbinlocation;
    Property BinNumber    :String     read GetBinNumber;
    Property Serialnumber :String     read getserialnumber;
    Property UOM          :String     read getuom;
    Property InstockQty   :Double     read getInstockQty;
    Property AvailableQty   :Double     read getAvailableQty;
    Property SOQty        :Double     read getSOQty;

  end;

implementation

uses BusObjBase, BaseInputForm, FastFuncs, CommonLib,
  BusObjSales, ProductQtyLib, MySQLConst, tcConst, PQALib, LogLib;

{$R *.dfm}

procedure TfmProductAllocationTree.FormCreate(Sender: TObject);
begin
  //Self.fbIgnoreAccessLevels := true;
  inherited;


  // turn on full row selection
  Tree.TreeOptions.SelectionOptions := Tree.TreeOptions.SelectionOptions + [toFullRowSelect];

  Self.Columns.HeaderColor := pnlTop.Color;

end;

function TfmProductAllocationTree.getProduct: TProduct;
begin
  if not Assigned(fProduct) then begin
    fProduct := TProduct.Create(nil);
    fProduct.Connection := TMydacdataconnection.create(fProduct);
    fProduct.connection.connection := Self.MyConnection;
    fProduct.Load(ProductID)
  end else   if fProduct.ID <> ProductID then fProduct.Load(ProductID);
  result := fProduct;
end;
Function TfmProductAllocationTree.GuiPrefcolumnWidth(const colname:String):Integer;
var
  s:String;
begin
  result := 100;
  s:= ReadGuipref(colname);
  if (s<> '') and (ISInteger(s)) then
    result := strtoInt(s);
end;

procedure TfmProductAllocationTree.RefreshBatch(const ParentNode:PVirtualNode);
var
  Rec: PNodeRec;
  Node: PVirtualNode;
begin
    if qbatch.active = False then qbatch.Open;
    if qbatch.recordcount = 0 then Exit;
    qbatch.First;
    while qbatch.Eof = False do begin
      if (Round(qbatch.FieldByname('UOMQty').asFloat , GeneralRoundPlaces)   <> 0) or (round(qbatch.FieldByname('SOUOMQty').asFloat,GeneralRoundPlaces)   <> 0 ) or (round(qbatch.FieldByname('InstockUOMQty').asFloat,GeneralRoundPlaces)   <> 0 ) then begin
        Node :=Tree.AddChild(ParentNode);
        Rec := Tree.GetNodeData(Node);
        Rec^.Data := TNodeData.Create(Self.Columns);
        InitHiddencol(Rec^.Data ,QBatch);
        Rec^.Data.CellData[cBatchno].Value := QBatch.FieldByname('BatchNumber').asString;
        if QBatch.FieldByname('BatchExpiryDate').asDatetime <> 0 then
          Rec^.Data.CellData[cExpiryDate].Value := FormatDateTime(FormatSettings.ShortDateformat , QBatch.FieldByname('BatchExpiryDate').asDateTime);
        DisplayDetails(Rec^.Data,QBatch);
        if Product.multiplebins then RefreshBins(Node,QBatch.FieldByname('UOM').asString,QBatch.FieldByname('BatchNumber').asString , QBatch.FieldByname('BatchExpiryDate').asDatetime )
        else if Product.snTracking then RefreshSN(Node,QBatch.FieldByname('UOM').asString,QBatch.FieldByname('BatchNumber').asString , QBatch.FieldByname('BatchExpiryDate').asDatetime);
      end;
      QBatch.next;
    end;
end;

procedure TfmProductAllocationTree.RefreshBins(const ParentNode: PVirtualNode;const UOM:String='';const batchno: STring=''; const expiryDate: TDateTime=0);
var
  Rec: PNodeRec;
  Node: PVirtualNode;
  fsfilter :STring;
begin

  if batchno <> '' then begin
    fsfilter := 'BatchNumber =' +quotedStr(batchno) ;
    if expiryDate <> 0 then fsfilter := fsfilter + ' and BatchExpiryDate = ' +
      QuotedStr(FormatDateTime(MysqlDateFormat , expiryDate));
    if uom <> '' then fsfilter := fsfilter + ' and UOM = ' +quotedStr(UOM);
    if fsFilter <> '' then qbins.filter := fsfilter;
    qbins.filtered := fsfilter <> '';
  end;
  if qbins.active = False then qbins.Open;
  if qbins.recordcount = 0 then Exit;
  qbins.First;
  while qbins.Eof = False do begin
    if (Round(qbins.FieldByname('UOMQty').asFloat , GeneralRoundPlaces)   <> 0) or (round(qbins.FieldByname('SOUOMQty').asFloat,GeneralRoundPlaces)   <> 0 ) or (round(qbins.FieldByname('InstockUOMQty').asFloat,GeneralRoundPlaces)   <> 0 ) then begin
      Node :=Tree.AddChild(ParentNode);
      Rec := Tree.GetNodeData(Node);
      Rec^.Data := TNodeData.Create(Self.Columns);
      InitHiddencol(Rec^.Data ,QBins);
      Rec^.Data.CellData[cbinlocation].Value := qbins.FieldByname('BinLocation').asString;
      Rec^.Data.CellData[cBinnumber].Value := qbins.FieldByname('Binnumber').asString;
      DisplayDetails(Rec^.Data,qbins, (batchno=''));
      if Product.snTracking then RefreshSN(Node,qbins.FieldByname('UOM').asString,batchno, expirydate, qbins.FieldByname('BinLocation').asString , qbins.FieldByname('Binnumber').asString);
    end;
    qbins.next;
  end;
end;

procedure TfmProductAllocationTree.RefreshSN(const ParentNode: PVirtualNode; const UOM:String=''; const batchno: STring=''; const expiryDate: TDateTime=0; const binlocation:String=''; const Binnumber: String='');
var
  Rec: PNodeRec;
  Node: PVirtualNode;
  fsfilter :String;
begin

  fsfilter := 'Serialnumber <> ''''  and Qty>0';
  if binlocation <> '' then begin
    fsfilter :=fsfilter + ' and binlocation =' +quotedStr(binlocation) +' and binnumber = ' +QuotedStr(binnumber);
  end;
  if batchno <> '' then begin
    fsfilter := fsfilter + ' and BatchNumber =' +quotedStr(batchno) ;
    if expiryDate <> 0 then fsfilter := fsfilter + ' and BatchExpiryDate = ' +FormatDateTime(MysqlDateFormat , expiryDate);
  end;
  if uom <> '' then fsfilter := fsfilter + ' and UOM = ' +quotedStr(UOM);

  if fsfilter <> '' then qsn.filter := fsfilter;
  qsn.filtered := fsfilter <> '';
  if qsn.active = False then qsn.Open;
  if qsn.recordcount = 0 then Exit;
  qsn.First;
  while qsn.Eof = False do begin
    if (Round(qsn.FieldByname('UOMQty').asFloat , GeneralRoundPlaces)   <> 0) or (round(qsn.FieldByname('SOUOMQty').asFloat,GeneralRoundPlaces)   <> 0 ) or (round(qsn.FieldByname('InstockUOMQty').asFloat,GeneralRoundPlaces)   <> 0 )then begin
      Node :=Tree.AddChild(ParentNode);
      Rec := Tree.GetNodeData(Node);
      Rec^.Data := TNodeData.Create(Self.Columns);
      InitHiddencol(Rec^.Data ,Qsn);
      Rec^.Data.CellData[cSerialnumber].Value := qsn.FieldByname('Serialnumber').asString;
      DisplayDetails(Rec^.Data,qsn, ((batchno='') and (binlocation='')));
    end;
    qsn.next;
  end;
end;

procedure TfmProductAllocationTree.InitHiddencol(Data: TNodedata; Qry:TERPQuery);
begin
  if Qry.FindField('BatchNumber')     <> nil then Data.CellData[Datacols+ +1].Value := Qry.FieldByname('BatchNumber').asString;
  if Qry.FindField('BatchExpiryDate')  <> nil then if Qry.FieldByname('BatchExpiryDate').asDatetime <> 0 then Data.CellData[Datacols+ +2].Value := FormatDateTime(FormatSettings.ShortDateformat , Qry.FieldByname('BatchExpiryDate').asDateTime);
  if Qry.FindField('BinLocation') <> nil then Data.CellData[Datacols+ +3].Value := qry.FieldByname('BinLocation').asString;
  if Qry.FindField('Binnumber')   <> nil then Data.CellData[Datacols+ +4].Value := qry.FieldByname('Binnumber').asString;
  if Qry.FindField('Serialnumber')<> nil then Data.CellData[Datacols+ +5].Value := Qry.FieldByname('Serialnumber').asString;
  if Qry.FindField('UOM')         <> nil then Data.CellData[Datacols+ +6].Value := Qry.FieldByname('UOM').asString;
end;

procedure TfmProductAllocationTree.RefreshTree;
var
  SQLList:TStringList;
  ParentNode(*, Node*): PVirtualNode;
(*  Rec: PNodeRec;*)
begin
  inherited;
  if Product.count = 0 then Exit;
  SQLList := TStringList.Create;
  qbatch  := TERPQuery.Create(Self);
  qbins   := TERPQuery.Create(Self);
  qsn     := TERPQuery.Create(Self);
  qbatch.connection := MyConnection;
  qbins.connection  := MyConnection;
  qsn.connection    := MyConnection;

  try
    if Product.Batch then begin
      {SQLList.Clear;
      SQLList.add('SELECT PQA.UOM,PQABatch.Value as Batchno, PQABatch.Expirydate ,');
      SQLList.add(ProductQtyLib.SQL4Qty(tAvailable, 'PQA' , (*'if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.UOMQty ,0 )'*) 'PQABatch.UOMQty' ) +' as UOMAvailableQty,');
      SQLList.add(ProductQtyLib.SQL4Qty(tAvailable, 'PQA' , (*'if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.Qty    ,0 )'*) 'PQABatch.Qty'    ) +' as AvailableQty,');
      SQLList.add(ProductQtyLib.SQL4Qty(tinstock  , 'PQA' , (*'if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.UOMQty ,0 )'*) 'PQABatch.UOMQty' ) +' as UOMInstockQty,');
      SQLList.add(ProductQtyLib.SQL4Qty(tinstock  , 'PQA' , (*'if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.Qty    ,0 )'*) 'PQABatch.Qty'    ) +' as InstockQty,');
      SQLList.add(ProductQtyLib.SQL4Qty(tSO       , 'PQA' , (*'if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.UOMQty ,0 )'*) 'PQABatch.UOMQty' ) +' as SOUOMQty,');
      SQLList.add(ProductQtyLib.SQL4Qty(tSO       , 'PQA' , (*'if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.Qty    ,0 )'*) 'PQABatch.Qty'    ) +' as SOQty');
      SQLList.add('FROM tblParts as P');
      SQLList.add('inner join tblPQA as PQA on PQA.ProductID = P.PartsID  and PQA.ISBO="F" and (PQA.active ="T"  or  PQA.TransType = "TProcTreePart")');
      SQLList.add('and PQA.ProductID =' + IntToStr(ProductID));
      SQLList.add('and PQA.DepartmentID =' + IntToStr(ClassID));
      SQLList.add('left join tblPqaDetails PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"  and (PQA.active ="T"  or  PQA.TransType = "TProcTreePart")');
      SQLList.add('Where ifnull(PQABatch.Qty,0)<>0 ');
      SQLList.add('group by PQA.UOM,PQABatch.Value , PQABatch.Expirydate  order by batchno , Expirydate, uom');
      qbatch.SQL.clear; qbatch.SQL.add(SQLList.Text); }
      qbatch.SQL.text := ProductQtyLib.StockQtyDetails(True , ProductID, ClassID , 0 , true ) ;

    end;

    if Product.Multiplebins then begin
      {SQLList.Clear;
      SQLList.add('SELECT PQA.UOM,PQABatch.Value as Batchno, PQABatch.Expirydate , PBin.binLocation, PBin.Binnumber, ');
      SQLList.add(ProductQtyLib.SQL4Qty(tAvailable,'PQA' , (*'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.UOMQty , if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.UOMQty   ,0 ))'*)'PQABins.UOMQty'  ) +' as UOMAvailableQty,');
      SQLList.add(ProductQtyLib.SQL4Qty(tAvailable,'PQA' , (*'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.Qty    , if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.Qty      ,0 ))'*)'PQABins.Qty'     ) +' as AvailableQty,');
      SQLList.add(ProductQtyLib.SQL4Qty(tInstock  ,'PQA' , (*'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.UOMQty , if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.UOMQty   ,0 ))'*)'PQABins.UOMQty'  ) +' as UOMInstockQty,');
      SQLList.add(ProductQtyLib.SQL4Qty(tInstock  ,'PQA' , (*'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.Qty    , if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.Qty      ,0 ))'*)'PQABins.Qty'     ) +' as InstockQty,');
      SQLList.add(ProductQtyLib.SQL4Qty(tSO       ,'PQA' , (*'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.UOMQty , if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.UOMQty   ,0 ))'*)'PQABins.UOMQty'  ) +' as SOUOMQty,');
      SQLList.add(ProductQtyLib.SQL4Qty(tSO       ,'PQA' , (*'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.Qty    , if(ifnull(PQABatch.PQAdetailID,0) <> 0 , PQABatch.Qty      ,0 ))'*)'PQABins.Qty'     ) +' as SOQty');
      SQLList.add('FROM tblParts as P');
      SQLList.add('inner join tblPQA as PQA on PQA.ProductID = P.PartsID  and PQA.ISBO="F" and (PQA.active ="T"  or  PQA.TransType = "TProcTreePart")');
      SQLList.add('and PQA.ProductID =' + IntToStr(ProductID));
      SQLList.add('and PQA.DepartmentID =' + IntToStr(ClassID));
      SQLList.add('left join tblPqaDetails PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T"');
      SQLList.add('left join tblPqaDetails PQABins     on PQABins.PQAId 	= PQA.PQAID and PQABins.PQAType = "Bin" and PQABins.Active = "T" ');
      SQLList.add('and  ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T" and P.multiplebins = "T") or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T"))');
      SQLList.add('Left join tblProductBin as PBin      on PBin.binId 		= PQABins.Value');
      SQLList.add('Where  ifnull(PQABins.Qty,0) <> 0');
      SQLList.add('group by PQA.UOM,PQABatch.Value , PQABatch.Expirydate ,PBin.binLocation, PBin.Binnumber order by batchno , Expirydate, binLocation, Binnumber , uom');
      qbins.SQL.clear;
      qbins.SQL.add(SQLList.Text);    }
      qbins.SQL.text := ProductQtyLib.StockQtyExtraDetails(True , ProductID, ClassID , 0 , true ) ;
    end;
    if product.SNTracking then begin
      {SQLList.Clear;
      SQLList.add('SELECT PQA.UOM,PQABatch.Value as Batchno  , PQABatch.ExpiryDate ,');
      SQLList.add('tblProductBin.binlocation , tblProductBin.binnumber,');
      SQLList.add('PQASN.Value as Serialnumber, if(PQA.Alloctype = "IN",1,0) as UOMAvailableQty, ');
      SQLList.add('if(PQA.TransType = '+QuotedStr(TSalesOrderLine.classname)+' , 1,0) as SOUOMQty,');
      SQLList.add('if(PQA.TransType = '+QuotedStr(TSalesOrderLine.classname)+' , 0,1) as UOMInstockQty');
      SQLList.add('from tblPQADetails PQASN inner join tblPQA PQA on PQA.PQAID = PQASN.PQAID');
      SQLList.add('and PQA.ProductID =' + IntToStr(ProductID));
      SQLList.add('and PQA.DepartmentID =' + IntToStr(ClassID));
      SQLList.add('inner join tblParts P on P.PartsID = PQA.ProductID');
      SQLList.add('Left join tblPQADetails PQABins on PQA.PQAID = PQABins.PQAID');
      SQLList.add('and PQABins.globalref = PQASN.ParentRef and PQABins.PQAtype = "Bin"');
      SQLList.add('Left join tblPQADetails PQABatch on PQA.PQAID = PQABatch.PQAID and');
      SQLList.add('PQABatch.pqatype = "Batch" and ( PQABatch.globalref = PQASN.ParentRef');
      SQLList.add('or PQABatch.globalref = PQABins.ParentRef )');
      SQLList.add('Left join tblProductBin on tblProductBin.binId = PQABins.Value');
      SQLList.add('where PQASN.PQAType = "SN" ');
      SQLList.add('and (PQA.Alloctype = "IN"  or PQA.TransType = '+QuotedStr(TSalesOrderLine.classname)+' )');
      SQLList.add('and (PQA.active ="T"  or  PQA.TransType = "TProcTreePart")');
      SQLList.add('and  ifnull(PQASN.Qty,0)<>0');
      SQLList.add('and transDate = ');
      SQLList.add('(Select maxpqa.transDate  ');
      SQLList.add('from tblPQADetails maxpqad ');
      SQLList.add('inner join tblPQA maxpqa on maxpqa.PQAID = maxpqad.PQAID');
      SQLList.add('where maxpqad.PQAType = "SN" and (MaxPQA.active ="T"  or  MAxPQA.TransType = "TProcTreePart") and ');
      SQLList.add('maxpqad.value =PQASN.value order by maxpqa.transDate desc limit 1);');
      qsn.SQL.clear; qsn.SQL.add(SQLList.Text); }
      qsn.SQL.text := ProductQtyLib.StockQtyDetailswithSno(True , ProductID, ClassID , 0 , true ) ;
    end;
    clog(qbatch.SQL.Text);
    logtext(qbins.SQL.Text);
    logtext(qsn.SQL.Text);
    Tree.Clear;
    Columns.Clear;


    if Product.Batch then begin
      AddColumn('Batch No', vtString, GuiPrefcolumnWidth('Options.Batchno.displayWidth'));
      AddColumn('ExpiryDate', vtString, GuiPrefcolumnWidth('Options.ExpiryDate.displayWidth'));
    end;
    if Product.Multiplebins then begin
      AddColumn('Bin Location', vtString, GuiPrefcolumnWidth('Options.Binlocation.displayWidth'));
      AddColumn('Bin Number', vtString, GuiPrefcolumnWidth('Options.Binnumber.displayWidth'));
    end;
    if Product.SnTracking then begin
        AddColumn('Serial number', vtString, GuiPrefcolumnWidth('Options.Serialnumber.displayWidth'));
    end;
    AddColumn('UOM'          , vtString, GuiPrefcolumnWidth('Options.UOM.displayWidth'));
    AddColumn('Instock Quantity'     , vtFloat , GuiPrefcolumnWidth('Options.InstockQty.displayWidth'));
    AddColumn('Available Quantity'     , vtFloat , GuiPrefcolumnWidth('Options.AvailableQty.displayWidth'));
    AddColumn('Sales Order Quantity'  , vtFloat , GuiPrefcolumnWidth('Options.SOQty.displayWidth'));

    Columns.Header.Background := pnlTop.Color;
    ParentNode := nil;
    Fixedcols:=getFixedcols;
    Datacols :=Fixedcols+3;
    Batchcols:=getBatchcols;
    Batchbincols:=getBatchbincols;

    AddColumn('hid_BatchNo', vtString, 0);
    AddColumn('hid_ExpiryDate', vtString, 0);
    AddColumn('hid_BinLocation', vtString, 0);
    AddColumn('hid_BinNumber', vtString, 0);
    AddColumn('hid_Serialnumber', vtString, 0);
    AddColumn('hid_UOM', vtString, 0);

    Hidecolumn(Datacols+ 1); // hidd_batchno
    Hidecolumn(Datacols+ 2); // hid_expirydate
    Hidecolumn(Datacols+ 3); // hid_binlocation
    Hidecolumn(Datacols+ 4); // hid_binnumber
    Hidecolumn(Datacols+ 5); // hid_serialnumber
    Hidecolumn(Datacols+ 6); // hid_uom


    If Product.Batch then refreshBatch(ParentNode)
    else if Product.MultipleBins then RefreshBins(ParentNode)
    else if Product.SNTracking then RefreshSN(ParentNode);
  Finally
      Self.LoadExpandedState;
     ExpandContractTree(true);
      FreeandNil(SQLList);
      FreeandNil(qbatch);
      FreeandNil(qbins);
      FreeandNil(qsn);
  end;
end;
procedure TfmProductAllocationTree.WriteGuiPref;
begin
  if Tree.Header.Columns.Count = 0 then exit;
  if Product.Batch then begin
    WriteGuiPref('Options.Batchno.displayWidth'     ,inttostr(Tree.Header.columns[cBatchno].Width));
    WriteGuiPref('Options.ExpiryDate.displayWidth'  ,inttostr(Tree.Header.columns[cExpiryDate].Width));
  end;
  if Product.Multiplebins then begin
    WriteGuiPref('Options.Binlocation.displayWidth' ,inttostr(Tree.Header.columns[cbinLocation].Width));
    WriteGuiPref('Options.Binnumber.displayWidth'   ,inttostr(Tree.Header.columns[cBinNumber].Width));
  end;
  if Product.SnTracking then begin
    WriteGuiPref('Options.Serialnumber.displayWidth',inttostr(Tree.Header.columns[cSerialnumber].Width));
  end;
  WriteGuiPref('Options.UOM.displayWidth'           ,inttostr(Tree.Header.columns[cUOM].Width));
  WriteGuiPref('Options.InstockQty.displayWidth'    ,inttostr(Tree.Header.columns[cInstockQty].Width));
  WriteGuiPref('Options.AvailableQty.displayWidth'    ,inttostr(Tree.Header.columns[cAvailableQty].Width));
  WriteGuiPref('Options.SOQty.displayWidth'         ,inttostr(Tree.Header.columns[cSOQty].Width));
  GuiPrefs.SavePrefs;
end;

procedure TfmProductAllocationTree.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if Self.Parent is TDnMPanel then begin
      Columns.HeaderColor       := TDnMPanel(Self.Parent).color;
      Columns.Header.Background := TDnMPanel(Self.Parent).color;
      pnlTop.Visible            := False;
      pnlBottom.Visible      := False;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfmProductAllocationTree.FormDestroy(Sender: TObject);
begin
  FreeandNil(fProduct);
  inherited;
end;

procedure TfmProductAllocationTree.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
 {$IFDEF DevMode}
  inherited
  {$ENDIF}
  else  inherited;

end;

procedure TfmProductAllocationTree.DisplayDetails(const Data: TNodeData; const qry: TERPQuery; const topLevel:Boolean =True);
begin
  if Round(Qry.FieldByname('InstockUOMQty').asFloat , GeneralRoundPlaces)     <> 0 then Data.CellData[cInstockQty].Value   := Formatfloat(FloatFieldDisplayFormat , round(Qry.FieldByname('InstockUOMQty').asFloat  ,GeneralRoundPlaces));
  if Round(Qry.FieldByname('UOMQty').asFloat , GeneralRoundPlaces)   <> 0 then Data.CellData[cAvailableQty].Value := Formatfloat(FloatFieldDisplayFormat , round(Qry.FieldByname('UOMQty').asFloat  ,GeneralRoundPlaces));
  if round(Qry.FieldByname('SOUOMQty').asFloat,GeneralRoundPlaces)            <> 0 then Data.CellData[cSOQty].Value        := Formatfloat(FloatFieldDisplayFormat , Round(Qry.FieldByname('SOUOMQty').asFloat,GeneralRoundPlaces));
  if topLevel then Data.CellData[cUOM].Value := Qry.FieldByname('UOM').asString;
end;


procedure TfmProductAllocationTree.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;
function TfmProductAllocationTree.GetBatchNo        : String    ;begin Result := Columnbyname['hid_BatchNo']     ;end;
function TfmProductAllocationTree.GetBinLocation    : String    ;begin Result := Columnbyname['hid_BinLocation'] ;end;
function TfmProductAllocationTree.GetBinNumber      : String    ;begin Result := Columnbyname['hid_BinNumber']   ;end;
function TfmProductAllocationTree.GetSerialnumber   : String    ;begin Result := Columnbyname['hid_Serialnumber'];end;
function TfmProductAllocationTree.GetUOM            : String    ;begin Result := Columnbyname['hid_UOM']     ;end;
function TfmProductAllocationTree.GetExpiryDate     : TDateTime ;Var  Value:String; begin  Value:= Columnbyname['hid_ExpiryDate']       ;  if value = '' then result :=0  else result := strToDate(Value) ; end;
function TfmProductAllocationTree.GetInstockQty     : Double    ;Var  Value:String; begin  Value:= Columnbyname['Instock Quantity']     ;  if value = '' then result :=0  else result := StrTofloat(Value); end;
function TfmProductAllocationTree.GetAvailableQty     : Double    ;Var  Value:String; begin  Value:= Columnbyname['Available Quantity']     ;  if value = '' then result :=0  else result := StrTofloat(Value); end;
function TfmProductAllocationTree.GetSOQty          : Double    ;var  Value:String; begin  Value:= Columnbyname['Sales Order Quantity'] ;  if value = '' then result :=0  else result := StrTofloat(Value); end;

function TfmProductAllocationTree.getBatchcols: Integer   ;begin  result := 0;  if Product.Batch then result := 2;end;
function TfmProductAllocationTree.getBatchbincols: Integer;begin  result := getBatchcols    ;if Product.Multiplebins  then result := result+ 2;end;
function TfmProductAllocationTree.getFixedcols: Integer   ;begin  result := getBatchbincols ;if Product.SnTracking    then result := result+ 1;end;

function TfmProductAllocationTree.cBatchno:Integer      ; begin result := 0           ;end;
function TfmProductAllocationTree.cExpiryDate:Integer   ; begin result := 1           ;end;
function TfmProductAllocationTree.cBinLocation:Integer  ; begin result := Batchcols   ;end;
function TfmProductAllocationTree.cBinNumber:Integer    ; begin result := batchcols+1 ;end;

function TfmProductAllocationTree.cSerialNumber:Integer ; begin result := batchbincols;end;
function TfmProductAllocationTree.cUOM:Integer          ; begin result := fixedcols   ;end;
function TfmProductAllocationTree.cInstockQty:Integer   ; begin result := fixedcols+1 ;end;
function TfmProductAllocationTree.cAvailableQty:Integer ; begin result := fixedcols+2 ;end;
function TfmProductAllocationTree.cSOQty:Integer        ; begin result := fixedcols+3;end;

initialization
  RegisterClassOnce(TfmProductAllocationTree);
end.

