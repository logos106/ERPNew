unit busobjPartsPriceMatrix;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  09/02/11  1.00.00  BJ  Initial Version.
  }


interface

uses BusObjBase, DB, Classes, XMLIntf, ERPdbComponents, IntegerListObj;

const
  MatrixRefreshed = 'MatrixRefreshed';
  CreateAttribCombo = 'CreateAttribCombo';
  ValuesRefreshed = 'ValuesRefreshed';
type
  TPriceAttrib  = record
    FieldName:String;
    Displaylabel:String;
    EntryValueID:Integer;
  end;

  TMatrixItem  = record
    Identifier:String;
    Value:String;
    Itemtype:String;
  end;
  TMatrixItemDet  = record
    IdentifierID:Integer;
    ValueID:Integer;
    Identifier:String;
    Value:Double;
    Itemtype:String;
  end;

  TMatrixItemObj = class(TComponent)
    Private
      MatrixItem :TMatrixItem;
      sdata:String;
      fconnection: TERPConnection;
      fQuery:TERPQuery;
      fiProductId: Integer;
      procedure setDescData(const Value: String);
      procedure setRefData(const Value: String);
      procedure Splitdata(const Value: String);
      function GetDescData: String;
      function GetRefData: String;

      function GetEntryID(const entryname:String):Integer;
      (*function GetValueID(const entryID:Integer; Valuename:String):Integer;*)

      function GetEntryName(const entryID:String):String;
      function GetValueName(const entryID:Integer; ValueID:String):String;

      function GetConnection: TERPConnection;
      procedure SetConnection(const Value: TERPConnection);
      Function Query:TERpQuery ;
      procedure setItemtype(const Value: String);

    Public
      Constructor Create(AOwner:TComponent); override;
      Property RefData :String read getRefData Write setRefData;
      Property DescData :String read getDescData Write setDescData;
      Property ProductId :Integer read fiProductId write fiProductId;
      Property Itemtype :String Write setItemtype;
      Function MatrixItemref:String;
      Function MatrixItemDesc:String;
      Property connection :TERPConnection read getconnection Write Setconnection;
      function MAtrixQty:Double;
      Function ItemValue(const Itemname:String):String;
  end;

  TMatrixEntry = class(TComponent)
    Private
      fsValueREf: String;

      fiProductId: Integer;
      procedure SetValueREf(const Value: String);
      function getValueREf: String;
      function getEntryName(EntryID:Integer):String;
      function getEntryValue(ValueID:Integer):Double;
    Public
      MatrixItems :Array of TMatrixItemDet;
      Constructor Create(AOwner: TComponent; fProductID: Integer); reintroduce;
      Property ValueREf :String read getValueREf Write SetValueREf;
      Property ProductId :Integer read fiProductId write fiProductId;
      Function EntryValue(const EntryName:String):Double;

  end;
  TPartsPriceMethod = class;
  TPartsPriceMethodValues = class(TMSBusObj)
  private
    SalesDefaultId:Integer;
    PurchaseDefaultID:Integer;
    function GetPriceMethodID          : Integer   ;
    function GetPriceEntryID           : Integer   ;
    function GetValue                  : string    ;
    function getSalesDefault              : boolean;
    procedure SetPriceMethodID          (const Value: Integer   );
    procedure SetPriceEntryID           (const Value: Integer   );
    procedure SetValue                  (const Value: string    );
    Procedure SetSalesDefault              (Const Value: Boolean );
    function getPurchaseDefault: Boolean;
    procedure SetPurchaseDefault(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Procedure DefaultAssigned(Const Sender: TBusObj; var Abort: boolean);
    Procedure PurcahseDefaultAssigned(Const Sender: TBusObj; var Abort: boolean);
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;

  published
    property PriceMethodID           :Integer     read GetPriceMethodID         write SetPriceMethodID      ;
    property PriceEntryID            :Integer     read GetPriceEntryID          write SetPriceEntryID       ;
    property Value                   :string      read GetValue                 write SetValue              ;
    Property SalesDefault               :Boolean     read getSalesDefault             write setSalesDefault;
    Property PurchaseDefault         :Boolean     read getPurchaseDefault       write SetPurchaseDefault;
  end;
  TPartsPriceMethodEntries = class(TMSBusObj)
  private
    function GetPriceMethodID          : Integer   ;
    function GetEntryName                   : string    ;
    function GetEntryOption            : String;
    procedure SetPriceMethodID          (const Value: Integer   );
    procedure SetEntryName                   (const Value: string    );
    procedure SetEntryOption            (const Value: String );
    function Getpricemethodvalues: TPartsPriceMethodValues;
    Procedure AssignXnY(Const Sender: TBusObj; var Abort: boolean);


  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;          override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property pricemethodvalues :TPartsPriceMethodValues Read Getpricemethodvalues;
  published
    property PriceMethodID           :Integer     read GetPriceMethodID         write SetPriceMethodID      ;
    property EntryName                    :string      read GetEntryName                  write SetEntryName               ;
    property EntryOption             :String read GetEntryOption           write SetEntryOption        ;
  end;

(*  TPartsPriceEntries = class(TMSBusObj)
  private
    function GetProductID            : Integer   ;
    function GetPricemethodID        : Integer   ;
    function GetPriceEntryID         : Integer   ;
    function GetPriceValueID         : Integer   ;
    function GeTPartsPriceEntryID    : Integer   ;
    procedure SetProductID            (const Value: Integer   );
    procedure SetPricemethodID        (const Value: Integer   );
    procedure SetPriceEntryID         (const Value: Integer   );
    procedure SetPriceValueID         (const Value: Integer   );
    procedure SeTPartsPriceEntryID    (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ProductID             :Integer     read GetProductID           write SetProductID        ;
    property PricemethodID         :Integer     read GetPricemethodID       write SetPricemethodID    ;
    property PriceEntryID          :Integer     read GetPriceEntryID        write SetPriceEntryID     ;
    property PriceValueID          :Integer     read GetPriceValueID        write SetPriceValueID     ;
    property PartsPriceentryID     :Integer     read GeTPartsPriceEntryID   write SeTPartsPriceEntryID;
  end;*)
  TPartsPriceEntry = class(TMSBusObj)
  private
    Matrixentry :TMatrixentry;
    fsQtyformula:string;
    function GetProductID              : Integer   ;
    function GetPriceMethodID           : Integer   ;
    function GetPrice                  : Double    ;
    function GetSurchargePercentage    : Double    ;
    procedure SetProductID              (const Value: Integer   );
    procedure SetPriceMethodID           (const Value: Integer   );
    procedure SetPrice                  (const Value: Double    );
    procedure SetSurchargePercentage    (const Value: Double    );
    (*function getPriceentries: TPartsPriceEntries;*)
    function getEntrynValueRef: String;
    procedure setDetials(const Value: String);
    function getTPartsPriceMethod: TPartsPriceMethod;
    Function QtyFromformula:Double;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
    Procedure QtyformulaCallback(const Sender: TBusObj; var Abort: boolean);
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function Locate(const KeyFields: string; const KeyValues: variant;Options: TLocateOptions): boolean; Override;
    Function Qtyformula:Double;
    Property PartsPriceMethod :TPartsPriceMethod Read getTPartsPriceMethod;
  published
    property ProductID               :Integer     read GetProductID             write SetProductID          ;
    property PriceMethodID            :Integer     read GetPriceMethodID          write SetPriceMethodID       ;
    property Price                   :Double      read GetPrice                 write SetPrice              ;
    property SurchargePercentage     :Double      read GetSurchargePercentage   write SetSurchargePercentage;
    Property EntrynValueRef                 :String      read getEntrynValueRef               Write setDetials;
  end;

  TPartsPriceMethod = class(TMSBusObj)
  private
    fsTablename :String;
    fields:Integer;
    Matrixstr:String;
    Ids:TIntegerList;
    entryfound:boolean;
    tempEntryname:String;

    function GetProductId              : Integer   ;
    function GetXAxisID                : Integer   ;
    function GetUOMID                 : Integer   ;
    function GetYAxisID                : Integer   ;
    function GetXAxis                  : String;
    function GetUOM                    : String;
    function GetYAxis                  : String ;
    function GetQtyformula             : string    ;
    procedure SetProductID              (const Value: Integer   );
    procedure SetXAxisID                (const Value: Integer   );
    procedure SetUOMID                  (const Value: Integer   );
    procedure SetYAxisID                (const Value: Integer   );
    procedure SetXAxis                  (const Value: String);
    procedure SetUOM                    (const Value: String);
    procedure SetYAxis                  (const Value: String);
    procedure SetQtyformula             (const Value: string    );
    function GetPriceMethodEntries: TPartsPriceMethodEntries;
    function getXAxisvalues: TPartsPriceMethodValues;
    function getYAxisvalues: TPartsPriceMethodValues;
    Procedure YAxisMatrixStr(Const Sender: TBusObj; var Abort: boolean);
    Procedure XAxisMatrixStr(Const Sender: TBusObj; var Abort: boolean);
    (*function geTPartsPriceEntries: TPartsPriceEntry;*)
    function getPartsPriceEntrys: TPartsPriceEntry;
    function getMatrixrefs: TStringlist; Overload;
    function getMatrixrefs(SelectedValueIDs:TIntegerList): TStringlist;Overload;
    function XnYAxisIDs:TIntegerList;
    Procedure XnYAxisIDsCallback(Const Sender: TBusObj; var Abort: boolean);
    procedure DoGetParserVariableCallback(const Sender: TBusObj;
      var Abort: boolean);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    procedure DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: boolean);
  public

    PriceAttribs :Array of TPriceAttrib;

    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property PartsPriceEntrys : TPartsPriceEntry Read getPartsPriceEntrys;
    Property pricemethodentries :TPartsPriceMethodEntries Read GetPriceMethodEntries;
    Property XAxisvalues : TPartsPriceMethodValues read getXAxisvalues;
    Property YAxisvalues : TPartsPriceMethodValues read getYAxisvalues;
    //Property PartsPriceEntries:  TPartsPriceEntry Read geTPartsPriceEntries;
    Property Tablename :String read fsTablename; // write fsTablename;
    Procedure CreateMatrix;

    Property Matrixrefs :TStringlist read getMatrixrefs;
    Function MatrixRefsforSelection(SelectedIds:TIntegerlist):TStringList;
    Function FormulaValid:Boolean;





  published
    property ProductId               :Integer     read GetProductId             write SetProductID          ;
    property XAxisID                 :Integer     read GetXAxisID               write SetXAxisID            ;
    property UOMID                   :Integer     read GetUOMID                 write SetUOMID              ;
    property YAxisID                 :Integer     read GetYAxisID               write SetYAxisID            ;
    property XAxis                   :String      read GetXAxis                 write SetXAxis            ;
    property UOM                     :String      read GetUOM                   write SetUOM              ;
    property YAxis                   :String      read GetYAxis                 write SetYAxis              ;
    property Qtyformula              :string      read GetQtyformula            write SetQtyformula         ;
  end;



implementation


uses tcDataUtils, CommonLib, sysutils, CommonDbLib, BusObjConst,
  ParserObj, types, strutils;



  {TPartsPriceMethod}

constructor TPartsPriceMethod.Create(AOwner: TComponent);
begin
//  fsTablename := CommonDbLib.GetUserTemporaryTableName('PriceMatrix',Connection.Connection);
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'partspricemethod';
  fSQL := 'SELECT * FROM tblpartspricemethod';
end;


procedure TPartsPriceMethod.CreateMatrix;
var
  st:TStringList;
begin
  SetLength(PriceAttribs , 1);
  fields := 0;
  st:=TStringList.create;
  try
    fsTablename := CommonDbLib.GetUserTemporaryTableName('PriceMatrix',TERPConnection(Connection.Connection));
//    st.Add('DROP TABLE IF EXISTS ' + fsTablename +';');
    ST.add('CREATE TABLE ' +  fstablename);
    ST.add('(  ID INT(10) NOT NULL AUTO_INCREMENT,  ');
    (*ST.add('ExtraRef VARCHAR(255) NULL DEFAULT "",');*)
    ST.add('xRef VARCHAR(255) NOT NULL DEFAULT "",');
    ST.add('xID INT(11) NOT NULL DEFAULT 0,');
    Matrixstr:='';
    if YAxisvalues.count = 0 then begin
      Matrixstr :='F0 DOUBLE NULL,';
      PriceAttribs[0].fieldName := 'fo';
      PriceAttribs[0].displaylabel := '';
      PriceAttribs[0].entryValueID:= 0;
      fields:= fields+1;
    end else begin
      fields := 0;
      YAxisvalues.Iteraterecords(YAxisMatrixStr);
    end;
    ST.add(Matrixstr);
    ST.add('PRIMARY KEY (ID), UNIQUE INDEX xref_xid (xref, xid) ) ENGINE=Innodb;');
    Matrixstr:='';
    XAxisvalues.Iteraterecords(XAxisMatrixStr);
    if Matrixstr <> '' then ST.add(Matrixstr);

(*  refs :=Matrixrefs;
    try
      for ctr := 0 to refs.count-1 do begin
          Matrixstr := Matrixstr + ' Insert into ' +fsTablename +' (ExtraRef) Values (' +QuotedStr(refs[ctr])+';'+chr(13);
      end;
    finally
      Freeandnil(refs);
    end;*)

    ExecuteSQL(st,False);
    SendEvent(BusobjEvent_ToDo, MatrixRefreshed, self);
  finally
    Freeandnil(st);
  end;

end;

destructor TPartsPriceMethod.Destroy;
begin
  inherited;
end;


procedure TPartsPriceMethod.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ID');
  SetPropertyFromNode(node,'ProductId');
  SetPropertyFromNode(node,'XAxisID');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'YAxisID');
  SetPropertyFromNode(node,'XAxis');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'YAxis');
  SetPropertyFromNode(node,'Qtyformula');
end;


function TPartsPriceMethod.MatrixRefsforSelection(SelectedIds:TIntegerlist):TStringList;
var
  ctr:Integer;
  XnY:TIntegerlist;
begin
  xnY:= XnYAxisIDs;
  try
    for ctr := 0 to SelectedIds.count-1 do
      xnY.add(SelectedIds[ctr]);
    result := getMatrixrefs(XnY);
  finally
    Freeandnil(xnY);
  end;
end;

procedure TPartsPriceMethod.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ID' ,ID);
  AddXMLNode(node,'ProductId' ,ProductId);
  AddXMLNode(node,'XAxisID' ,XAxisID);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'YAxisID' ,YAxisID);
  AddXMLNode(node,'XAxis' ,XAxis);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'YAxis' ,YAxis  );
  AddXMLNode(node,'Qtyformula' ,Qtyformula);
end;


function TPartsPriceMethod.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if (pricemethodentries.count =0)   then begin
    Delete;
    REsult := True;
    Exit;
  end;
  if ProductId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Product should not be blank' , True );
    Exit;
  end;
  if XAxisID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'X-Axis should not be blank' , True );
    Exit;
  end;
  if pricemethodentries.count =0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Price Methods should not be blank' , True );
    Exit;
  end;
  if XAxisvalues.count =0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'X-Axis should not be blank' , True );
    Exit;
  end;
  if (YAxisID<>0) and (YAxisvalues.count =0) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Y-Axis should not be blank' , True );
    Exit;
  end;
  if not FormulaValid then begin
    Exit;
  end;
  Result := True;
end;


function TPartsPriceMethod.XnYAxisIDs: TIntegerList;
begin
  Ids:= TIntegerList.create;
  try
    XAxisvalues.Iteraterecords(XnYAxisIDsCallback);
    YAxisvalues.Iteraterecords(XnYAxisIDsCallback);
    Result := Ids;
  finally
    Ids:= nil;
  end;
end;

procedure TPartsPriceMethod.XnYAxisIDsCallback(const Sender: TBusObj;var Abort: boolean);
begin
   Ids.add(sender.ID);
end;


procedure TPartsPriceMethod.XAxisMatrixStr(const Sender: TBusObj;
  var Abort: boolean);
begin
  Matrixstr := Matrixstr + ' Insert into ' +fsTablename +' (xRef ,xID) Values (' +QuotedStr(TPartsPriceMethodValues(Sender).Value) +',' +inttostr(TPartsPriceMethodValues(Sender).ID)+');'+chr(13);
end;


procedure TPartsPriceMethod.YAxisMatrixStr(const Sender: TBusObj;  var Abort: boolean);
var
  fsfieldname :String;
begin
  fsfieldname := 'f'+ intToStr(Sender.Id);
  Matrixstr := Matrixstr +fsfieldname+' DOUBLE NULL,';
  SetLength(PriceAttribs , fields+1);
  PriceAttribs[fields].fieldName := fsfieldname;
  PriceAttribs[fields].displaylabel := TPartsPriceMethodValues(Sender).Value;
  PriceAttribs[fields].entryValueID:= Sender.Id;
  fields:= fields+1;
end;

function TPartsPriceMethod.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPartsPriceMethod.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if id>0 then pricemethodentries;
end;




function TPartsPriceMethod.getMatrixrefs: TStringlist;
begin
   result := getMatrixrefs(nil);
end;

function TPartsPriceMethod.getMatrixrefs(SelectedValueIDs:TIntegerList): TStringlist;
var
  EntryIds:TIntegerList;
  (*ctr:Integer;*)
  Procedure EntrynValueRef(Prefix:String; Entryno:Integer);
  var
    s:String;
  begin
    s:='Select ID from tblpartspricemethodvalues where PriceEntryID = ' +inttostr(EntryIds[entryno]);
    if (SelectedValueIDs <> nil) and (SelectedValueIDs.CommaText<> '') then
      s:= s+ ' and Id in (' + SelectedValueIDs.CommaText+')';
    With GetNewDataset(s ) do try
      if recordcount =0 then exit; // this should not happen
      first;
      while eof = False do begin
        if Entryno = EntryIds.count-1 then begin
          REsult.add(prefix +'[' + inttostr(EntryIds[entryno]) +':' +inttostr(fieldByname('ID').asInteger)+']');
        end else begin
          EntrynValueRef(prefix +'[' + inttostr(EntryIds[entryno]) +':' +inttostr(fieldByname('ID').asInteger)+'],' , Entryno+1);
        end;
        Next;
      end;
    finally
      if active then close;
      Free;
    end;
  end;
begin
  With getnewDataset('Select Id from tblpartspricemethodentries where PriceMethodID = 1 order by ID') do try
    if recordcount > 0 then begin
      First;
      EntryIds:= TIntegerList.create;
      result:=TStringList.create;
      try
        while Eof = False do begin
          EntryIds.add(Fieldbyname('ID').asInteger);
          Next;
        end;
        EntrynValueRef('', 0);
      finally
        Freeandnil(EntryIDs);
      end;
    end;
  finally
    if active then close;
    Free;
  end;
end;

(*function TPartsPriceMethod.geTPartsPriceEntries: TPartsPriceEntry;
begin
  REsult := TPartsPriceEntry(getContainerComponent(TPartsPriceEntry , 'PricemethodID = ' +inttostr(ID)));
end;*)

function TPartsPriceMethod.getPartsPriceEntrys: TPartsPriceEntry;
begin
  REsult := TPartsPriceEntry(getContainerComponent(TPartsPriceEntry , 'PriceMethodID = ' +inttostr(ID)));
end;

procedure TPartsPriceMethod.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


procedure TPartsPriceMethod.DoGetParserVariable(Sender: TObject;
  const VarName: string; var Value: extended; var FieldFound: boolean);
begin
  entryfound:=False;
  tempEntryname:=VarName;
  pricemethodentries.Iteraterecords(DoGetParserVariableCallback);
  FieldFound:= entryfound;
(*var
    ds1:TDataset;
    tmpVarName, strSQL :String;
begin
    tmpVarName := ReplaceStr(ReplaceStr(VarName , '[' , '') , ']' , '');
    strSQL:='Select ID from tblpartspricemethodentries where Name = ' + Quotedstr(tmpVarName);
    ds1 :=getNewDataset(strSQL , True);
    try
        FieldFound := ds1.Recordcount =1;
    finally
        ds1.close;
        freeandNil(ds1);
    end;*)
end;
procedure TPartsPriceMethod.DoGetParserVariableCallback(const Sender: TBusObj; var Abort: boolean);
begin
  if not (Sender is TPartsPriceMethodEntries) then exit;
  if sameText(TPartsPriceMethodEntries(Sender).entryname , tempEntryname) then begin
    entryfound:= True;
    Abort:= True;
  end;
end;

function TPartsPriceMethod.FormulaValid: Boolean;
var
  Parser : TMathParser;
begin
  if   QtyFormula = '' then begin
    REsult := True;
    Exit;
  end;
    Parser := TMathParser.Create(self);
    Try
        Parser.OnGetVar := DoGetParserVariable;
        Parser.ParseString := QtyFormula;
        Parser.Parse;
        if Parser.ParseError then begin
            ResultStatus.AddItem(False , rssWarning , 0 , 'Quantity Formula :' + Parser.ErrorMessage, true);
            Result := False;
            Exit;
        End;
    Result := True;
    finally
        FreeandNil(Parser);
    end;
end;

function TPartsPriceMethod.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPartsPriceMethod.GetIDField: string;
begin
  Result := 'id'
end;


class function TPartsPriceMethod.GetBusObjectTablename: string;
begin
  Result:= 'tblpartspricemethod';
end;


function TPartsPriceMethod.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  SendEvent(BusObjEvent_Dataset, BusObjEvent_AfterInsert, self);
end;

function TPartsPriceMethod.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  pricemethodentries;
end;

function TPartsPriceMethod.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
end;

function TPartsPriceMethod.GetPriceMethodEntries: TPartsPriceMethodEntries;
begin
  REsult := TPartsPriceMethodEntries(getContainerComponent(TPartsPriceMethodEntries , 'PriceMethodID = ' +inttostr(ID)))
end;


{Property Functions}
function  TPartsPriceMethod.GetProductId          : Integer   ; begin Result := GetIntegerField('ProductId');end;
function  TPartsPriceMethod.GetXAxisID            : Integer   ; begin Result := GetIntegerField('XAxisID');end;
function  TPartsPriceMethod.GetUOMID            : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TPartsPriceMethod.GetYAxisID            : Integer   ; begin Result := GetIntegerField('YAxisID');end;
function  TPartsPriceMethod.GetXAxis              : String   ; begin Result := GetStringField('XAxis');end;
function  TPartsPriceMethod.GetUOM              : String   ; begin Result := GetStringField('UOM');end;
function  TPartsPriceMethod.GetYAxis              : String   ; begin Result := GetStringField('YAxis');end;
function TPartsPriceMethod.getXAxisvalues: TPartsPriceMethodValues;
begin
  REsult := TPartsPriceMethodValues(getContainerComponent(TPartsPriceMethodValues , 'PriceMethodID = ' +inttostr(ID)+' and PriceEntryID = ' +inttostr(XAxisID)));
end;


function TPartsPriceMethod.getYAxisvalues: TPartsPriceMethodValues;
begin
  REsult := TPartsPriceMethodValues(getContainerComponent(TPartsPriceMethodValues , 'PriceMethodID = ' +inttostr(ID)+' and PriceEntryID = ' +inttostr(YAxisID)));
end;

function  TPartsPriceMethod.GetQtyformula         : string    ; begin Result := GetStringField('Qtyformula');end;
procedure TPartsPriceMethod.SetProductID          (const Value: Integer   ); begin SetIntegerField('ProductId'           , Value);end;
procedure TPartsPriceMethod.SetXAxisID            (const Value: Integer   );
begin
  if Value = yaxisId then exit;
  SetIntegerField('XAxisID',Value);
end;
procedure TPartsPriceMethod.SetUOMID            (const Value: Integer   );begin  SetIntegerField('UOMID',Value);end;
procedure TPartsPriceMethod.SetYAxisID            (const Value: Integer   );
begin
    if Value = xaxisId then exit;
  SetIntegerField('YAxisID',Value);
end;
procedure TPartsPriceMethod.SetXAxis            (const Value: String);
begin
  if Value = yaxis then exit;
  SetStringField('XAxis',Value);
end;
procedure TPartsPriceMethod.SetUOM            (const Value: String);begin  SetStringField('UOM',Value);end;
procedure TPartsPriceMethod.SetYAxis              (const Value: String);
begin
    if Value = xaxis then exit;
    SetStringField('YAxis',Value);
end;
procedure TPartsPriceMethod.SetQtyformula
  (const Value: string    ); begin SetStringField('Qtyformula'          , Value);end;


  {TPartsPriceMethodEntries}

procedure TPartsPriceMethodEntries.AssignXnY(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not(Sender is  TPartsPriceMethodEntries) then exit;
  with TPartsPriceMethodEntries(Sender) do begin
      if (TPartsPriceMethod(Owner).xaxisId =0) and
          ( TPartsPriceMethod(Owner).YaxisId <> sender.id) then begin
            TPartsPriceMethod(Owner).xaxisId  := sender.ID;
            TPartsPriceMethod(Owner).xaxis  := TPartsPriceMethodEntries(Sender).Entryname;
            TPartsPriceMethod(Owner).PostDB;
      end else if (TPartsPriceMethod(Owner).yaxisId =0) and
          ( TPartsPriceMethod(Owner).xaxisId <> Sender.id) then begin
            TPartsPriceMethod(Owner).yaxisId  := Sender.ID;
            TPartsPriceMethod(Owner).yaxis  := TPartsPriceMethodEntries(Sender).Entryname;
            TPartsPriceMethod(Owner).PostDB;
      end;
  end;
  abort := (TPartsPriceMethod(Owner).xaxisId <> 0) and ( TPartsPriceMethod(Owner).yaxisId<>0);
end;

constructor TPartsPriceMethodEntries.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'partspricemethodentries';
  fSQL := 'SELECT * FROM tblpartspricemethodentries';
  fSQLOrder:= 'ID';
end;


destructor TPartsPriceMethodEntries.Destroy;
begin
  inherited;
end;


procedure TPartsPriceMethodEntries.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ID');
  SetPropertyFromNode(node,'PriceMethodID');
  SetPropertyFromNode(node,'EntryName');
  SetPropertyFromNode(node,'EntryOption');
end;


procedure TPartsPriceMethodEntries.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ID' ,ID);
  AddXMLNode(node,'PriceMethodID' ,PriceMethodID);
  AddXMLNode(node,'EntryName' ,EntryName);
  AddXMLNode(node,'EntryOption' ,EntryOption);
end;


function TPartsPriceMethodEntries.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if PriceMethodID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PriceMethodID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TPartsPriceMethodEntries.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPartsPriceMethodEntries.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if pricemethodvalues = nil then exit;
  SendEvent(BusobjEvent_ToDo, ValuesRefreshed, pricemethodvalues);
end;


procedure TPartsPriceMethodEntries.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPartsPriceMethodEntries.GetSQL: string;
begin
  Result := inherited GetSQL;
end;



class function TPartsPriceMethodEntries.GetIDField: string;
begin
  Result := 'ID'
end;


class function TPartsPriceMethodEntries.GetBusObjectTablename: string;
begin
  Result:= 'tblpartspricemethodentries';
end;


function TPartsPriceMethodEntries.DoAfterInsert(
  Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Self.Owner) then
    if self.owner is TPartsPriceMethod then begin
       PriceMethodID := TPartsPriceMethod(Self.Owner).Id;
    end;
end;

function TPartsPriceMethodEntries.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  //pricemethodvalues;
  if Assigned(Self.Owner) then
    if Self.Owner is TPartsPriceMethod then
      if ((TPartsPriceMethod(Self.Owner).yaxisId =0) or (TPartsPriceMethod(Self.Owner).xaxisId =0)) then begin
        Iteraterecords(AssignXnY);
      end;
end;


function TPartsPriceMethodEntries.DoBeforeInsert(
  Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not result then exit;
  if assigned(Self.Owner) then
    if self.Owner is  TPartsPriceMethod then
      if TPartsPriceMethod(Self.Owner).PartsPriceEntrys.count >0 then begin
        result := False;
        abort;
      end;
end;

function TPartsPriceMethodEntries.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
  if EntryName = '' then begin
    Canceldb;
    abort;
  end;

end;

{Property Functions}

function  TPartsPriceMethodEntries.GetPriceMethodID      : Integer   ; begin Result := GetIntegerField('PriceMethodID');end;
function TPartsPriceMethodEntries.Getpricemethodvalues: TPartsPriceMethodValues;
var
  s:STring;
begin
  result := nil;
  if EntryName = '' then Exit;
  s:= 'PriceMethodID = ' +inttostr(PriceMethodID);
  s:= s +' and PriceEntryID = ' +inttostr(ID);
  Result := TPartsPriceMethodValues(getContainerComponent(TPartsPriceMethodValues , s))
end;

function  TPartsPriceMethodEntries.GetEntryName               : string    ; begin Result := GetStringField('Name');end;
function  TPartsPriceMethodEntries.GetEntryOption        : String; begin Result := GetStringField('EntryOption');end;
procedure TPartsPriceMethodEntries.SetPriceMethodID      (const Value: Integer   ); begin SetIntegerField('PriceMethodID'       , Value);end;
procedure TPartsPriceMethodEntries.SetEntryName               (const Value: string    ); begin SetStringField('Name'                , Value);end;
procedure TPartsPriceMethodEntries.SetEntryOption        (const Value: String); begin SetStringField('EntryOption'         , Value);end;


  {TPartsPriceMethodValues}

constructor TPartsPriceMethodValues.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'partspricemethodvalues';
  fSQL := 'SELECT * FROM tblpartspricemethodvalues';
  SalesDefaultId:=0;
  PurchaseDefaultID:=0;
end;


procedure TPartsPriceMethodValues.DefaultAssigned(const Sender: TBusObj;
  var Abort: boolean);
begin
 if not (Sender is   TPartsPriceMethodValues) then exit;
 if TPartsPriceMethodValues(Sender).Id <> SalesDefaultId then begin
  TPartsPriceMethodValues(Sender).SalesDefault := False;
  TPartsPriceMethodValues(Sender).PostDB;
 end;
end;

destructor TPartsPriceMethodValues.Destroy;
begin
  inherited;
end;


procedure TPartsPriceMethodValues.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ID');
  SetPropertyFromNode(node,'PriceMethodID');
  SetPropertyFromNode(node,'PriceEntryID');
  SetPropertyFromNode(node,'Value');
  SetBooleanPropertyFromnode(node,'SalesDefault');
  SetBooleanPropertyFromnode(node,'PurchaseDefault');
end;


procedure TPartsPriceMethodValues.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ID' ,ID);
  AddXMLNode(node,'PriceMethodID' ,PriceMethodID);
  AddXMLNode(node,'PriceEntryID' ,PriceEntryID);
  AddXMLNode(node,'Value' ,Value);
  AddXMLNode(node,'SalesDefault' ,SalesDefault);
  AddXMLNode(node,'PurchaseDefault' ,PurchaseDefault);
end;


function TPartsPriceMethodValues.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if PriceMethodID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PriceMethodID should not be 0' , False );
    Exit;
  end;
  if PriceEntryID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PriceEntryID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TPartsPriceMethodValues.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPartsPriceMethodValues.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPartsPriceMethodValues.PurcahseDefaultAssigned(const Sender: TBusObj;
  var Abort: boolean);
begin
 if not (Sender is   TPartsPriceMethodValues) then exit;
 if TPartsPriceMethodValues(Sender).Id <> PurchaseDefaultID then begin
  TPartsPriceMethodValues(Sender).PurchaseDefault := False;
  TPartsPriceMethodValues(Sender).PostDB;
 end;

end;

procedure TPartsPriceMethodValues.DoFieldOnChange(Sender: TField);
begin
  inherited;
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
    inherited;
    if (Sysutils.SameText(Sender.FieldName , 'Value'))  then begin
      if count = 0 then SalesDefault := True;
      if count = 0 then PurchaseDefault := True;
    end else if (Sysutils.SameText(Sender.FieldName , 'SalesDefault'))  then begin
      if SalesDefault then begin
        postDB;
        SalesDefaultId:= ID;
        Iteraterecords(DefaultAssigned);
      end;
    end else if (Sysutils.SameText(Sender.FieldName , 'PurchaseDefault'))  then begin
      if PurchaseDefault then begin
        postDB;
        PurchaseDefaultID:= ID;
        Iteraterecords(PurcahseDefaultAssigned);
      end;
    end;

end;


function TPartsPriceMethodValues.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPartsPriceMethodValues.GetIDField: string;
begin
  Result := 'id'
end;


class function TPartsPriceMethodValues.GetBusObjectTablename: string;
begin
  Result:= 'tblpartspricemethodvalues';
end;


function TPartsPriceMethodValues.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Self.Owner) then
    if self.owner is TPartsPriceMethodEntries then begin
       PriceMethodID := TPartsPriceMethodEntries(Self.Owner).PriceMethodID;
       PriceEntryID  := TPartsPriceMethodEntries(Self.Owner).ID;
    end;
end;

function TPartsPriceMethodValues.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TPartsPriceMethodValues.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
  if Value  ='' then begin
      Canceldb;
      abort;
  end;
end;

{Property Functions}
function  TPartsPriceMethodValues.GetPriceMethodID      : Integer   ; begin Result := GetIntegerField('PriceMethodID');end;
function TPartsPriceMethodValues.getPurchaseDefault: Boolean;
begin
  result := getBooleanField('PurchaseDefault');
end;

function  TPartsPriceMethodValues.GetPriceEntryID       : Integer   ; begin Result := GetIntegerField('PriceEntryID');end;
function  TPartsPriceMethodValues.GetValue              : string    ; begin Result := GetStringField('Value');end;
function  TPartsPriceMethodValues.GetSalesDefault          : Boolean   ; begin Result := GetBooleanField('SalesDefault');end;
procedure TPartsPriceMethodValues.SetPriceMethodID      (const Value: Integer   ); begin SetIntegerField('PriceMethodID'       , Value);end;
procedure TPartsPriceMethodValues.SetPurchaseDefault(const Value: Boolean);
begin
  Setbooleanfield('PurchaseDefault' , value);
end;

procedure TPartsPriceMethodValues.SetPriceEntryID       (const Value: Integer   ); begin SetIntegerField('PriceEntryID'        , Value);end;
procedure TPartsPriceMethodValues.SetValue              (const Value: string    ); begin SetStringField('Value'               , Value);end;
procedure TPartsPriceMethodValues.SetSalesDefault          (const Value: Boolean   ); begin SetbooleanField('SalesDefault' , Value);end;


(*  {TPartsPriceEntries}

constructor TPartsPriceEntries.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'partspriceentries';
  fSQL := 'SELECT * FROM tblpartspriceentries';
end;


destructor TPartsPriceEntries.Destroy;
begin
  inherited;
end;


procedure TPartsPriceEntries.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ID');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'PricemethodID');
  SetPropertyFromNode(node,'PriceEntryID');
  SetPropertyFromNode(node,'PriceValueID');
  SetPropertyFromNode(node,'PartsPriceentryID');
end;


procedure TPartsPriceEntries.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ID' ,ID);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'PricemethodID' ,PricemethodID);
  AddXMLNode(node,'PriceEntryID' ,PriceEntryID);
  AddXMLNode(node,'PriceValueID' ,PriceValueID);
  AddXMLNode(node,'PartsPriceentryID' ,PartsPriceentryID);
end;


function TPartsPriceEntries.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ProductID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProductID should not be 0' , False );
    Exit;
  end;
  if PricemethodID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PricemethodID should not be 0' , False );
    Exit;
  end;
  if PriceEntryID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PriceEntryID should not be 0' , False );
    Exit;
  end;
  if PriceValueID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PriceValueID should not be 0' , False );
    Exit;
  end;
  if PartsPriceentryID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PartsPriceentryID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TPartsPriceEntries.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPartsPriceEntries.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPartsPriceEntries.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPartsPriceEntries.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPartsPriceEntries.GetIDField: string;
begin
  Result := 'id'
end;


class function TPartsPriceEntries.GetBusObjectTablename: string;
begin
  Result:= 'tblpartspriceentries';
end;


function TPartsPriceEntries.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TPartsPriceEntries.GetProductID        : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TPartsPriceEntries.GetPricemethodID    : Integer   ; begin Result := GetIntegerField('PricemethodID');end;
function  TPartsPriceEntries.GetPriceEntryID     : Integer   ; begin Result := GetIntegerField('PriceEntryID');end;
function  TPartsPriceEntries.GetPriceValueID     : Integer   ; begin Result := GetIntegerField('PriceValueID');end;
function  TPartsPriceEntries.GeTPartsPriceEntryID: Integer   ; begin Result := GetIntegerField('PartsPriceentryID');end;
procedure TPartsPriceEntries.SetProductID        (const Value: Integer   ); begin SetIntegerField('ProductID'         , Value);end;
procedure TPartsPriceEntries.SetPricemethodID    (const Value: Integer   ); begin SetIntegerField('PricemethodID'     , Value);end;
procedure TPartsPriceEntries.SetPriceEntryID     (const Value: Integer   ); begin SetIntegerField('PriceEntryID'      , Value);end;
procedure TPartsPriceEntries.SetPriceValueID     (const Value: Integer   ); begin SetIntegerField('PriceValueID'      , Value);end;
procedure TPartsPriceEntries.SeTPartsPriceEntryID(const Value: Integer   ); begin SetIntegerField('PartsPriceentryID' , Value);end;*)


  {TPartsPriceEntry}

constructor TPartsPriceEntry.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'partspriceentry';
  fSQL := 'SELECT * FROM tblpartspriceentry';
end;


(*function TPartsPriceEntry.DesctoRef(const Desc: String): String;
var
  st:TStringList;
  s:String;
  ctr:Integer;
begin
    st:=TStringList.create;
      try
        Split( DEsc, ',' , st); //first line is fieldnames
        if st.count =0 then exit;
        s:= '';
        for ctr := 0 to st.count-1 do begin

          st[ctr]

        end;
        s:=  'Select ' +idfieldname +'  from ' + BusObjectTableName +' where ' +s;
        with getNewDataset(s , true) do try
            result := inherited Locate(IDFieldname , fieldbyname(idfieldname).asInteger , []);
        finally
            if active then close;
            Free;
        end;
      finally
        Freeandnil(st);
      end;
end;*)

destructor TPartsPriceEntry.Destroy;
begin
  inherited;
end;


procedure TPartsPriceEntry.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ID');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'PriceMethodID');
  SetPropertyFromNode(node,'Price');
  SetPropertyFromNode(node,'SurchargePercentage');
end;


function TPartsPriceEntry.Locate(const KeyFields: string;  const KeyValues: variant; Options: TLocateOptions): boolean;
Var
  strArray: TStringDynArray;
  ctr:Integer;
  s:String;
begin
  Result := inherited Locate(Keyfields, KeyValues, Options);
  if not result then
    {EntrynvalueRef is populated in ascending order of the entryId. the data should be populated in that order.
    just incase if not, check for the individual [entryID:ValueId] combination}
    if (SameText(Keyfields, 'EntryValueRef')) or (SameText(Keyfields, 'EntryValueRef')) then begin
      strArray:= SplitString(KeyValues, ',');
      if High(strArray) = 0 then exit;

      s:= '';
      for ctr := Low(strArray) to High(strArray) do begin
        if s<> '' then s:= s +' and ';
        s:= s + 'EntryValueRef like ' +Quotedstr('%' + strArray[ctr] +'%');
      end;
      s:=  'Select ' +idfieldname +'  from ' + BusObjectTableName +' where ' +s;
      with getNewDataset(s , true) do try
          result := inherited Locate(IDFieldname , fieldbyname(idfieldname).asInteger , []);
      finally
          if active then close;
          Free;
      end;
    end;
end;

procedure TPartsPriceEntry.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ID' ,ID);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'PriceMethodID' ,PriceMethodID);
  AddXMLNode(node,'Price' ,Price);
  AddXMLNode(node,'SurchargePercentage' ,SurchargePercentage);
end;


procedure TPartsPriceEntry.setDetials(const Value: String);
begin
  SetStringField('EntryValueRef' , Value);
end;

function TPartsPriceEntry.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ProductID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProductID should not be 0' , False );
    Exit;
  end;
  if PriceMethodID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PriceMethodID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TPartsPriceEntry.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPartsPriceEntry.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TPartsPriceEntry.QtyFromformula:Double;
var
    Parser : TMathParser;
begin
    result:= 0;
    if (fsQtyformula <> '')  then begin
        Parser := TMathParser.Create(self);
        Try
            Parser.ParseString := fsQtyformula;
            Try
                Parser.Parse;
                result := Parser.ParseValue;
            except
                On E:Exception do begin
                    REsultStatus.AddItem(False , rssWarning , 0 , E.message );
                end;
                // kill the exception
                // parser can create mathmatical exceptions like devide by 0 etc, when the field is wrong value
            end;
        Finally
            FreeandNil(Parser);
        end;
    end;
end;

function TPartsPriceEntry.Qtyformula: Double;
begin
  result:= 0;
  fsQtyformula:= PartsPriceMethod.Qtyformula;
  if fsQtyformula= '' then exit;
  Matrixentry := TMatrixentry.create(Self, ProductID);
  try
    Matrixentry.ValueRef :=  EntrynValueRef;
    PartsPriceMethod.pricemethodentries.Iteraterecords(QtyformulaCallback);
    result := QtyFromformula;
  finally

  end;
end;

procedure TPartsPriceEntry.QtyformulaCallback(const Sender: TBusObj;var Abort: boolean);

begin
  if not(Sender is TPartsPriceMethodEntries) then exit;
  fsQtyformula := replaceStr(fsQtyformula , '[' +TPartsPriceMethodEntries(sender).EntryName+']' ,FloatToStr(Matrixentry.EntryValue(TPartsPriceMethodEntries(sender).EntryName)));
end;

(*function TPartsPriceEntry.ReftoDesc(const REf: String): String;
begin

end;*)

procedure TPartsPriceEntry.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPartsPriceEntry.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPartsPriceEntry.GetIDField: string;
begin
  Result := 'id'
end;


class function TPartsPriceEntry.GetBusObjectTablename: string;
begin
  Result:= 'tblpartspriceentry';
end;


function TPartsPriceEntry.getEntrynValueRef: String;
begin
  Result := getStringField('EntryValueRef');
end;

function TPartsPriceEntry.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Self.Owner) then
    if self.owner is TPartsPriceMethod then begin
       ProductId      :=TPartsPriceMethod(Self.Owner).ProductId;
       PriceMethodID  :=TPartsPriceMethod(Self.Owner).ID;
    end;
end;

function TPartsPriceEntry.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;


{Property Functions}
function  TPartsPriceEntry.GetProductID          : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TPartsPriceEntry.GetPriceMethodID      : Integer   ; begin Result := GetIntegerField('PriceMethodID');end;
function  TPartsPriceEntry.GetPrice              : Double    ; begin Result := GetFloatField('Price');end;
(*function TPartsPriceEntry.getPriceentries: TPartsPriceEntries;
begin
      REsult := TPartsPriceEntries(getcontainercomponent(TPartsPriceMethodEntries , 'PartsPriceentryID = ' +inttostr(ID)));
end;*)

function  TPartsPriceEntry.GetSurchargePercentage: Double    ; begin Result := GetFloatField('SurchargePercentage');end;
function TPartsPriceEntry.getTPartsPriceMethod: TPartsPriceMethod;
begin
  REsult := TPartsPriceMethod(Getcontainercomponent(TPartsPriceMethod ,'ID= ' + IntToStr(PriceMethodID) ));
end;

procedure TPartsPriceEntry.SetProductID          (const Value: Integer   ); begin SetIntegerField('ProductID'           , Value);end;
procedure TPartsPriceEntry.SetPriceMethodID      (const Value: Integer   ); begin SetIntegerField('PriceMethodID'        , Value);end;
procedure TPartsPriceEntry.SetPrice              (const Value: Double    ); begin SetFloatField('Price'               , Value);end;
procedure TPartsPriceEntry.SetSurchargePercentage(const Value: Double    ); begin SetFloatField('SurchargePercentage' , Value);end;


{ TMatrixItemObj }

constructor TMatrixItemObj.Create(AOwner: TComponent);
begin
  inherited;
  MatrixItem.Identifier:= '';
  MatrixItem.Value:='';
  MatrixItem.Itemtype := '';
  fconnection := nil;
  fQuery:= nil;
  fiProductId := 0;
end;

function TMatrixItemObj.getconnection: TERPConnection;
begin
  if not(Assigned(fconnection)) then
    fconnection := GetSharedMyDacConnection;
  Result := fconnection;
end;

function TMatrixItemObj.getDescData: String;
begin
  Result := MatrixItemDesc;
end;

function TMatrixItemObj.getEntryID(const entryname: String): Integer;
begin
  with Query do begin
    if active then close;
    SQL.clear;
    SQL.add('select PEE.ID from tblpartspricemethodentries PEE '+
              ' inner join tblpartspricemethod PE On PEE.PriceMethodID = PE.ID  '+
              ' where PE.ProductID = ' +inttostr(ProductID) + ' and name = '+ Quotedstr(entryname));
    open;
    REsult := fieldbyname('ID').AsInteger;
  end;
end;

function TMatrixItemObj.getEntryName(const entryID: String): String;
begin
  with Query do begin
    if active then close;
    SQL.clear;
    SQL.add('select PEE.NAme from tblpartspricemethodentries PEE '+
              ' inner join tblpartspricemethod PE On PEE.PriceMethodID = PE.ID  '+
              ' where PE.ProductID = ' +inttostr(ProductID) + ' and PEE.ID = '+ EntryID);
    open;
    Result := fieldbyname('Name').asString;
  end;
end;

function TMatrixItemObj.getRefData: String;
begin
  result := MatrixItemref;
end;

(*function TMatrixItemObj.getValueID(const entryID:Integer; Valuename: String): Integer;
begin
  With Query do begin
    if active then close;
    SQL.clear;
    SQL.add('SELECT ID FROM tblpartspricemethodvalues where PriceEntryId = ' +inttostr(EntryID) + ' and Value = ' +quotedstr(ValueNAme));
    open;
    result := Fieldbyname('ID').asInteger;
  end;
end;*)

function TMatrixItemObj.getValueName(const entryID:Integer; ValueID: String): String;
begin
  With Query do begin
    if active then close;
    SQL.clear;
    SQL.add('SELECT Value FROM tblpartspricemethodvalues where PriceEntryId = ' +inttostr(EntryID) + ' and  ID = ' +ValueID);
    open;
    result := Fieldbyname('Value').asString;
  end;
end;

function TMatrixItemObj.ItemValue(const Itemname: String): String;
begin

end;

function TMatrixItemObj.MatrixItemDesc: String;
begin
   if MatrixItem.Itemtype ='D' then result := sdata
   else begin
    Result := '[' + getEntryName(MatrixItem.Identifier) +':' + getValueName(strtOInt(MatrixItem.Identifier)  , MatrixItem.Value)+']';
   end;
end;

function TMatrixItemObj.MatrixItemref: String;
var
  fid:Integer;
begin
   if MatrixItem.Itemtype ='R' then result := sdata
   else begin
    fid:= getEntryID(MatrixItem.Identifier);
    Result := '[' + inttostr(fid) +':' + getValueName(fid , MatrixItem.Value)+']';
   end;
end;

function TMatrixItemObj.MAtrixQty: Double;
var
  S:String;
begin
  result:= 0;
  s:=MatrixItemDesc;


end;

function TMatrixItemObj.Query: TERpQuery;
begin
  if not(Assigned(fQuery)) then begin
    fQuery :=TempMyQuery;
    if assigned(fconnection) then fQuery.connection := fConnection;
  end;
  result := fQuery;
end;

procedure TMatrixItemObj.Setconnection(const Value: TERPConnection);
begin
  fconnection := Value;
end;

procedure TMatrixItemObj.Splitdata(const Value: String);
var
  s:String;
  ctr:Integer;
begin
  sdata := Value;
  s:= replaceStr(replaceStr(Value , '[' , '') , ']','');
    MatrixItem.Identifier := '';
  for ctr:= 1 to char_Length(s) do
    if s[ctr]<> ':' then MatrixItem.Identifier := MatrixItem.Identifier+ s[ctr]
    else begin
      MatrixItem.Value:= copy(s , ctr+1 , char_Length(s));
      break;
    end;
end;
procedure TMatrixItemObj.setDescData(const Value: String);
begin
    Splitdata(Value);
    MatrixItem.Itemtype := 'D';
end;

procedure TMatrixItemObj.setItemtype(const Value: String);
begin
  MatrixItem.Itemtype := Value;
end;

procedure TMatrixItemObj.setRefData(const Value: String);
begin
    Splitdata(Value);
    MatrixItem.Itemtype := 'R';
end;

{ TMatrixentry }

constructor TMatrixentry.Create(AOwner: TComponent; fProductID: Integer);
begin
  inherited Create(AOwner);
  ProductId := fProductID;
end;

function TMatrixentry.EntryValue(const EntryName: String): Double;
var
  ctr:Integer;
begin
  result:= 0;
  for ctr:= low(MatrixItems) to high(MatrixItems) do
    if sametext(MatrixItems[ctr].Identifier , EntryName) then begin
      result :=MatrixItems[ctr].Value;
      break;
    end;
end;

function TMatrixentry.getEntryName(EntryID: Integer): String;
begin
  With TempMyQuery do try
    SQL.add('select name from tblpartspricemethodentries where id = ' +inttostr(EntryID));
    open;
    result := fieldbyname('Name').asString;
  finally
    if active then close;
  end;
end;

function TMatrixentry.getEntryValue(ValueID: Integer): Double;
begin
  With TempMyQuery do try
    SQL.add('select Value from tblpartspricemethodvalues where id = ' +inttostr(ValueID));
    open;
    result := fieldbyname('Value').asFloat;
  finally
    if active then close;
  end;

end;

function TMatrixentry.getValueREf: String;
begin
  result := fsValueREf;
end;

procedure TMatrixentry.SetValueREf(const Value: String);
var
  ctr:Integer;
  st:TStringList;
  s:String;
  x:Integer;
  sIdentifier:String;
  sValue:String;
begin
  fsValueREf := Value;
  st:= tStringList.create;
  Try
    st.commatext := Value;
    if st.count =0 then exit;
      SetLength(MatrixItems,0);
    for ctr := 0 to st.count-1 do begin
      SetLength(MatrixItems,ctr+1);

      s:= replaceStr(replaceStr(st[ctr] , '[' , '') , ']','');
      sIdentifier:='';
      sValue:='';

      for x:= 1 to char_Length(s) do
        if s[x]<> ':' then sIdentifier := sIdentifier+ s[x]
        else begin
          sValue:= copy(s , x+1 , char_Length(s));
          break;
        end;
      MatrixItems[ctr].identifierID := strToInt(sIdentifier);
      MatrixItems[ctr].ValueID      := strToInt(sValue);
      MatrixItems[ctr].identifier   := getEntryName(MatrixItems[ctr].identifierID);
      MatrixItems[ctr].Value        := getEntryValue(MatrixItems[ctr].ValueID);
    end;
  Finally
    Freeandnil(st);
  End;
end;


initialization
  RegisterClass(TPartsPriceEntry);
  (*RegisterClass(TPartsPriceEntries);*)
  RegisterClass(TPartsPriceMethodValues);
  RegisterClass(TPartsPriceMethodEntries);
  RegisterClass(TPartsPriceMethod);
end.
