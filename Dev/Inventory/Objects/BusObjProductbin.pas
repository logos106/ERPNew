{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/11/05 1.00.00  BJ  Initial Version
  20/02/06 1.00.01  AL  Added UOMID to TProductBinQty, TProductBatchQty,
  TProductAllocation, TProdactReservation
  15/08/06 1.00.02 BJ  1) Dataset.. procedures are changed to normal private procedures , the
  descendants are supposed to override the Do... procedures
}
unit BusObjProductbin;

interface

uses BusObjBase, classes, db, XMLDoc, XMLIntf, MyAccess;

const
  NEW_BIN = 'New_Bin';

type

  TProductBin = class(TMSBusObj)
  private
    fiNumberTo: Integer;
    fsLocationTo: string;
    fiNumberFrom: Integer;
    fsLocationFrom: string;
    fsLocationPrefix: string;
    fdLocationVolume: Double;
    fiClassId: Integer;

    function GetClassID: Integer;
    function getbinLocation: string;
    function getBinnumber: string;
    function getActive: Boolean;
    function getBinvolume: Double;
    function getVolume_used: Double;
    function getCleanBinvolume: Double;
    function getCleanBinVolume_used: Double;
    function getBinVolumeAvailable: Double;

    procedure setClassID(const Value: Integer);
    procedure SetbinLocation(const Value: string);
    procedure SetBinNumber(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure SetBinVolume(const Value: Double);
    procedure SetVolume_used(const Value: Double);
    function IsDuplicate(const fsBinloc, fiBinNnumber: string; const fClassId: Integer; const KeyId: Integer = 0): Integer;
//    function GetBinclassName: string;
//    procedure setBinclassName(const Value: string);
    function GetBinClassName: string;
    procedure SetBinClassName(const Value: string);

  protected
    function GetSQL: string; override;
    function GetId: Integer; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
//    function ValidateXMLData(const Node: IXMLNode): Boolean; override;
    function ExportsubClasses(const Node: IXMLNode): Boolean; override;
    function ImportsubClasses(const Node: IXMLNode): Boolean; override;
//    function ForeignKeysValid(const Node: IXMLNode): Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;

  public
    constructor Create(AOwner: TComponent); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
    function ValidateData: Boolean; override;
    function Generatebins: Boolean;
    procedure New; override;
    procedure SaveToXMLNode(const Node: IXMLNode); override;
    procedure LoadFromXMLNode(const Node: IXMLNode); override;
    function BinQtyforAvailableSpace(Uom_Multiplier: Double; ProductVolume: Double): Double;
    property LocationFrom: string read fsLocationFrom write fsLocationFrom;
    property LocationTo: string read fsLocationTo write fsLocationTo;
    property numberFrom: Integer read fiNumberFrom write fiNumberFrom;
    property NumberTo: Integer read fiNumberTo write fiNumberTo;
    property LocationPrefix: string read fsLocationPrefix write fsLocationPrefix;
    property LocationVolume: Double read fdLocationVolume write fdLocationVolume;
    property LocClassId: Integer read fiClassId write fiClassId;
    property CleanBinvolume: Double read getCleanBinvolume;
    property CleanBinVolume_used: Double read getCleanBinVolume_used;
    property BinVolume_used: Double read getVolume_used write SetVolume_used;
    class function IDToggle(const fiDepartmentID: Integer; const FSBinLocation, FSbinNumber: string; const Conn: TCustomMyConnection = nil): Integer; overload;
    class function IDToggle(const iBinId: Integer; const GetLocation: Boolean; const Conn: TCustomMyConnection = nil): string; overload;
    class procedure updatevolumeUSed(const fiBinId: Integer; const fdvolume, fdCleanVolume: Double; const Conn: TCustomMyConnection = nil);
    function Save: Boolean; override;
    class function AvailableQuantity(const BinID: integer;  const Conn: TCustomMyConnection = nil): double;
    Class function MakebinforClass(aOwner:TComponent; const abinID:Integer; const aClassID:Integer):Integer; Overload;
    Class function MakebinforClass(aOwner:TComponent; const aClassID:Integer; abinlocation, abinnumber:STring; aVolume:double):Integer;Overload;
    class function DeptIDOfbin(AOwner:TComponent; abinID:Integer):Integer;
  published
    property BinLocation: string read getbinLocation write SetbinLocation;
    property BinNumber: string read getBinnumber write SetBinNumber;
    property ClassID: Integer read GetClassID write setClassID;
    property BinClassName: string read GetBinClassName write SetBinClassName;
    property BinVolume: Double read getBinvolume write SetBinVolume;
    property BinVolumeUsed: Double read getVolume_used;
    property Active: Boolean read getActive write SetActive;
    property BinVolumeAvailable: Double read getBinVolumeAvailable;
  end;

implementation

uses pqalib, sysutils, Variants, DateUtils, ERPdbComponents, BusObjConst, CommonDbLib,
  tcDataUtils, AppEnvironment, CommonLib, BusObjClass, BusObjectListObj,
  DbSharedObjectsObj, ProductQtyLib, tcConst ;

function TProductBin.GetClassID: Integer;
begin
  Result := GetIntegerField('ClassId');
end;

function TProductBin.GetBinClassName: string;
begin
  result := GetStringField('ClassName');
end;

function TProductBin.getbinLocation: string;
begin
  Result := GetStringField('BinLocation');
end;

function TProductBin.getActive: Boolean;
begin
  Result := GetbooleanField('Active');
end;

//function TProductBin.GetBinclassName: string;
//begin
//  Result := TDeptClass.IDToggle(ClassID);
//end;

function TProductBin.getBinnumber: string;
begin
  Result := GetStringField('BinNumber');
end;

function TProductBin.getBinvolume: Double;
begin
  Result := GetFloatField('volume');
end;

function TProductBin.getVolume_used: Double;
begin
  Result := GetFloatField('Volume_Used');
end;

procedure TProductBin.setClassID(const Value: Integer);
begin
  if Value = 0 then
  else SetIntegerField('classId', Value);
end;

procedure TProductBin.SetbinLocation(const Value: string);
begin
  SetStringField('BinLocation', Value);
end;

procedure TProductBin.SetBinNumber(const Value: string);
begin
  SetStringField('BinNumber', Value);
end;

procedure TProductBin.SetActive(const Value: Boolean);
begin
  SetbooleanField('Active', Value);
end;

//procedure TProductBin.setBinclassName(const Value: string);
//begin
//  SetIntegerField('classId', TDeptClass.IDToggle(Value));
//end;

procedure TProductBin.SetBinVolume(const Value: Double);
begin
  SetFloatField('Volume', Value);
end;

procedure TProductBin.SetBinClassName(const Value: string);
begin
  SetStringField('ClassName', Value);
end;

procedure TProductBin.SetVolume_used(const Value: Double);
begin
  SetFloatField('Volume_Used', Value);
end;

procedure TProductBin.SaveToXMLNode(const Node: IXMLNode);
begin
  inherited;
  AddXMLNode(Node, 'BinLocation', BinLocation);
  AddXMLNode(Node, 'BinNumber', BinNumber);
  AddXMLNode(Node, 'ClassId', ClassID);
  AddXMLNode(Node, 'BinClassName', BinClassName);
  AddXMLNode(Node, 'volume', BinVolume);
  AddXMLNode(Node, 'Volume_Used', BinVolume_used);
  AddXMLNode(Node, 'Active', Active);
end;

procedure TProductBin.LoadFromXMLNode(const Node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'ClassId');
  SetPropertyFromNode(Node, 'BinClassName');
  SetPropertyFromNode(Node, 'binLocation');
  SetPropertyFromNode(Node, 'BinNumber');
  SetPropertyFromNode(Node, 'volume');
  SetPropertyFromNode(Node, 'Volume_Used');
  SetBooleanPropertyFromNode(Node, 'Active');
end;
Class function TProductBin.MakebinforClass(aOwner:TComponent; const aClassID:Integer; abinlocation, abinnumber:STring; aVolume:double):Integer;
var
  aTarget:TProductBin;
begin
  aTarget:= TProductBin.CreateWithNewConn(AOwner);
  try
    aTarget.loadSelect('classid =' + inttostr(aClassID)+' and BinLocation=' + quotedstr(abinlocation)+' and BinNumber =' +Quotedstr(abinnumber));
    if aTarget.count>0 then begin
      Result := aTarget.ID;
      Exit;
    end;
    aTarget.connection.Begintransaction;
    try
        aTarget.New;
        aTarget.ClassId :=aClassID;
        aTarget.BinClassName  := TDeptClass.IdToggle(aTarget.ClassID, aTarget.Connection.Connection);
        aTarget.BinLocation   := abinlocation;
        aTarget.BinNumber     := abinnumber;
        aTarget.Active        := true;
        aTarget.BinVolume     := aVolume;
        aTarget.BinVolume_used:= 0;
        aTarget.PostDB;
        if not aTarget.Save then begin
          aTarget.Connection.rollbacktransaction;
          Exit;
        end;
        Result := aTarget.ID;
        aTarget.Connection.CommitTransaction;
    Except
      aTarget.Connection.rollbacktransaction;
    end;
  finally
    freeandnil(aTarget);
  end;
end;
class function TProductBin.MakebinforClass(aOwner:TComponent; const abinID: Integer;const aClassID: Integer): Integer;
var
  asource, aTarget:TProductBin;
begin
  result := 0;
  if abinID =0 then exit;
  if aClassID =0 then exit;
  asource:= TProductBin.CreateWithNewConn(AOwner);
  aTarget:= TProductBin.Create(AOwner);
  try
    asource.load(aBinID);
    if asource.count <> 1 then exit;
    aTarget.loadSelect('classid =' + inttostr(aClassID)+' and BinLocation=' + quotedstr(aSource.BinLocation)+' and BinNumber =' +Quotedstr(asource.BinNumber));
    if aTarget.count>0 then begin
      Result := aTarget.ID;
      Exit;
    end;
    aTarget.connection.Begintransaction;
    try
        aTarget.New;
        aTarget.ClassId :=aClassID;
        aTarget.BinLocation := aSource.BinLocation;
        aTarget.BinNumber := aSource.BinNumber;
        aTarget.Active := aSource.Active;
        aTarget.BinVolume := aSource.BinVolume;
        aTarget.BinVolume_used := 0;
        aTarget.PostDB;
        if not aTarget.Save then begin
          aTarget.Connection.rollbacktransaction;
          Exit;
        end;
        Result := aTarget.ID;
        aTarget.Connection.CommitTransaction;
    Except
      aTarget.Connection.rollbacktransaction;
    end;
  finally
    freeandnil(aTarget);
    freeandnil(asource);
  end;
end;

function TProductBin.getCleanBinvolume: Double;
begin
  Result := GetXMLNodeFloatValue(CleanXMLNode, 'volume');
end;

function TProductBin.getCleanBinVolume_used: Double;
begin
  Result := GetXMLNodeFloatValue(CleanXMLNode, 'Volume_Used');
end;

function TProductBin.GetSQL: string;
begin
  REsult := inherited GetSQL;
//  Result := '';
//  if fSQL = '' then fSQL := 'Select * from Tblproductbin';
//  if fSQL <> '' then Result := fSQL;
//  if fSQLSelect <> '' then Result := Result + ' WHERE ' + fSQLSelect;
end;

function TProductBin.GetId: Integer;
begin
  Result := GetIntegerField('BinID');
end;

class function TProductBin.GetIDField: string;
begin
  Result := 'BinID';
end;

class function TProductBin.GetKeyStringField: string;
begin
  result := 'ClassName,BinLocation,BinNumber';
end;

class function TProductBin.GetKeyStringProperty: string;
begin
  result := 'BinClassName,BinLocation,BinNumber';
end;

class function TProductBin.GetBusObjectTablename: string;
begin
  Result := 'tblproductbin';
end;

constructor TProductBin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('classid');
  fSQL := 'Select * from Tblproductbin';
end;

class function TProductBin.DeptIDOfbin(AOwner:TComponent; abinID: Integer): Integer;
var
  aProductBin: TProductBin;
begin
  aProductBin:= TProductBin.CreateWithNewConn(AOwner);
  try
    aProductBin.load(abinID);
    result := aProductBin.Classid;
  finally
    Freeandnil(aProductBin);
  end;

end;

function TProductBin.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
//  Result := ValidateData;
//  if not Result then abort;
end;

procedure TProductBin.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName, 'ClassId') then begin
    if not RawMode then begin
      BinClassName := TDeptClass.IdToggle(ClassId, Connection.Connection);
    end;
  end else if Sysutils.SameText(Sender.fieldName, 'ClassName') then begin
    if not RawMode then begin
      ClassId := TDeptClass.IdToggle(BinClassName, Connection.Connection);
    end;
  end
end;

//function TProductBin.ValidateXMLData(const Node: IXMLNode): Boolean;
//var
//  fsXMLData: string;
//  fiClassId: Integer;
//  fsXMLTag: string;
//begin
//  Result := inherited ValidateXMLData(Node);
//
//  if not Result then Exit;
//  if not ImportingFromXMLFile then Exit;
//
//  XMLSearchRecorddESC := 'BinLocation=' + QuotedStr(GetXMLNodeStringValue(Node, 'BinLocation')) + ' and BinNumber = ' + QuotedStr(GetXMLNodeStringValue(Node, 'BinNumber'));
//
//  Result := False;
//  fsXMLTag := 'ClassName';
//  fsXMLData := GetXMLNodeStringValue(Node, fsXMLTag);
//  if fsXMLData <> '' then begin
//    fiClassId := GetDeptID(fsXMLData);
//    if fiClassId = 0 then begin
//      ErrRecordNotfound(fsXMLTag, fsXMLData);
//      Exit;
//    end;
//  end;
//  Result := true;
//  XMLSearchRecord := 'BinLocation=' + QuotedStr(GetXMLNodeStringValue(Node, 'BinLocation')) + ' and BinNumber = ' + QuotedStr(GetXMLNodeStringValue(Node, 'BinNumber'));
//  LocateXMLRecord;
//end;

function TProductBin.ExportsubClasses(const Node: IXMLNode): Boolean;
begin
  Result := true;
end;

function TProductBin.ImportsubClasses(const Node: IXMLNode): Boolean;
begin
  Result := true;
end;

//function TProductBin.ForeignKeysValid(const Node: IXMLNode): Boolean;
//var
//  fsXMLTag: string;
//  fsXMLData: string;
//begin
//  Result := False;
//  fiClassId := 0;
//
//  fsXMLTag := 'ClassName';
//  fsXMLData := GetXMLNodeStringValue(Node, fsXMLTag);
//  if fsXMLData <> '' then begin
//    fiClassId := GetDeptID(fsXMLData);
//    if fiClassId = 0 then begin
//      ErrRecordNotfound(fsXMLTag, fsXMLData);
//      Exit;
//    end;
//  end;
//  Result := true;
//end;

procedure TProductBin.New;
begin
  inherited;
  ClassID := AppEnv.DefaultClass.ClassID;
  BinClassName := TDeptClass.IdToggle(ClassId, Connection.Connection);
end;


function TProductBin.Generatebins: Boolean;
var
  fictr: Integer;
  fsCtr: string;
  KeyId: Integer;
  { const
    alphas:array [1..26] of String = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'); }
  function makebinnumber(const Value: Integer): string;
  var
    s: string;
  begin
    s := IntToStr(Value);
    while char_length(s) < char_length(IntToStr(fiNumberTo)) do s := '0' + s;
    Result := s;
  end;
{ function StrOrd(Const Value :String):double;
  var
  i,ii:Integer;
  substring:string;

  begin
  Result := 0;
  if char_length(Value) = 0 then Exit;
  for i :=  char_length(Value) downto 1 do begin
  substring := UpperCase(copy(value,I,1));
  ii:= SearchArray(Alphas, substring)+1;
  result := result + ii * Power(10,(i-1));
  end;
  end;
  function nextno(Const Value :STring):String;
  var
  i, ii:Integer;
  substring:string;
  x:array of double;
  begin
  if char_length(Value) = 0 then Exit;
  REsult := '';
  for i :=  1 to char_length(Value)  do begin
  substring := UpperCase(copy(value,I,1));
  Setlength(x ,i);
  x[i-1] := strOrd(substring);
  end;
  for i := high(x) downto low(x) do begin
  if x[i] = high(alphas) then begin
  for ii := i to high(x) do x[ii] := low(alphas);
  if i > low(alphas) then x[i-1] := x[i-1] +1;
  break;
  end else begin
  x[i] := x[i] +1; break;
  end;
  end;
  for i := low(x) to high(x) do
  result := result + alphas[System.round(x[i])];
  end; }

begin
  Result := False;
  if (fsLocationPrefix = '') then begin
    if (fsLocationFrom = '') or (fsLocationTo = '') then begin
      AddResult(False, rssWarning, BOR_ProdQty_Warn, 'Please provide both Location from and To');
      Exit;
    end;
  end
  else if (fsLocationFrom = '') <> (fsLocationTo = '') then begin
    AddResult(False, rssWarning, BOR_ProdQty_Warn, 'Please provide both Location from and To');
    Exit;
  end
  else if (fiNumberFrom = 0) or (fiNumberTo = 0) then begin
    AddResult(False, rssWarning, BOR_ProdQty_Warn, 'Please provide Both bin Number From and To');
    Exit;
    { end else if StrOrd(fsLocationFrom) > strOrd(fsLocationto) then begin
      ResultStatus.AddItem(false, rssWarning, BOR_ProdQty_Warn, '''Bin Location From'' should be less than ''Bin Location To''');
      Exit; }
  end
  else if fdLocationVolume = 0 then begin
    if AppEnv.CompanyPrefs.EnforceBinVolume then begin
      AddResult(False, rssWarning, BOR_ProdQty_Warn, 'Bin Volume should not be blank');
      Exit;
    end;
  end;

  if Self.Lock then begin
    try
      fsCtr := fsLocationFrom;
      while fsCtr <= fsLocationTo do begin
        for fictr := fiNumberFrom to fiNumberTo do begin
          KeyId := IsDuplicate(fsLocationPrefix + fsCtr, IntToStr(fictr), fiClassId);
          if KeyId = 0 then begin
            New;
            if fiClassId <> 0 then ClassID := fiClassId;
            BinLocation := fsLocationPrefix + fsCtr;
            BinNumber := makebinnumber(fictr); // IntToStr(fiCtr);
            BinVolume := fdLocationVolume;
            Active := true;
            Save;
          end else begin
            canceldb;
            Load(KeyId);
            if count > 0 then begin
              BinVolume := fdLocationVolume;
              Active := true;
              Save;
            end;
          end;
        end;
        if fsCtr <> '' then fsCtr := chr(Ord(fsCtr[1]) + 1)
        else break;
      end;

    finally Self.Unlock;
    end;
    Result := true;
  end else begin
  end;
end;

class function TProductBin.AvailableQuantity(const BinID: integer;
  const Conn: TCustomMyConnection): double;
var
  qry: TERPQuery;
begin
  result := 0;
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('Select ' + SQL4Qty(tAvailable , 'PQA', 'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.Qty , 0)')+ ' from ' + ProductTables(tExtraDetails));
    qry.SQL.Add('where PBin.BinId = ' + IntToStr(BinID));
    qry.Open;
    if qry.Fields.Count > 0 then
      result := qry.Fields[0].AsFloat;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TProductBin.BinQtyforAvailableSpace(Uom_Multiplier: Double; ProductVolume: Double): Double;
begin
  Result := (BinVolume - BinVolume_used) / Uom_Multiplier / ProductVolume;
end;

function TProductBin.getBinVolumeAvailable: Double;
begin
  Result := BinVolume - BinVolume_used;
  (* with TERPQuery.Create(nil) do try
    Options.FlatBuffers := True;
    Connection := GetSharedMyDacConnection;
    SQL.add('select sum(uomMultiplier * qty) as volume from tblProductReservedQty where STOCK_IN_OUT = ''IN'' and BinId = ' + IntToStr(ID));
    Open;
    if recordcount > 0 then
    Result := Result - FieldByname('volume').asFloat ;
    Finally
    if Active then close;
    Free;
    end; *)
end;

function TProductBin.IsDuplicate(const fsBinloc, fiBinNnumber: string; const fClassId: Integer; const KeyId: Integer = 0): Integer;
begin
  Result := 0;
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := true;
      connection := CommonDbLib.GetSharedMyDacConnection;
      SQl.Add('Select * from tblProductbin ');
      SQl.Add('WHERE BinLocation = ' + QuotedStr(fsBinloc));
      SQl.Add('AND   Binnumber  = ' + QuotedStr(fiBinNnumber));
      SQl.Add('AND   BinId <> ' + IntToStr(KeyId));
      SQl.Add('AND   ClassId = ' + IntToStr(fClassId));
      Open;
      if Recordcount > 0 then Result := FieldByname('binId').asInteger;
    finally
      if Active then Close;
      Free;
    end;
end;

function TProductBin.ValidateData: Boolean;
var
  s:String;
  fd:Double;
begin

  Result := False;

  if not IsUnique(ID, 'BinLocation = ' + QuotedStr(BinLocation)+' and BinNumber = ' + QuotedStr(BinNumber)+' and ClassId = ' + inttostr(ClassId) ) then begin
    self.AddResult(false, rssWarning, 0, 'Record already exists for' + chr(13)+
                                          '     - Location : ' + QuotedStr(BinLocation)+'' + chr(13)+
                                          '     - Number : ' + QuotedStr(BinNumber)+' and' + chr(13)+
                                          '     - '+AppEnv.DefaultClass.ClassHeading +' : ' + Quotedstr(BinClassName));
    Exit;
  end;

  if not(Dataset.State in [dsInsert]) and (BinLocation = '') then begin
    AddResult(False, rssWarning, BOR_ProdQty_Warn, 'Bin Location Should Not Be Blank');
    Exit;
  end;
  if not(Dataset.State in [dsInsert]) and (BinNumber = '') then begin
    AddResult(False, rssWarning, BOR_ProdQty_Warn, 'Bin Number Should Not Be Blank');
    Exit;
  end;
  if ClassID = 0 then begin
    AddResult(False, rssWarning, BOR_ProdQty_Warn, AppEnv.DefaultClass.ClassHeading + ' Should Not Be Blank');
    Exit;
  end;
  { binvolume is optional based on the preference }
  if BinVolume = 0 then
    if AppEnv.CompanyPrefs.EnforceBinVolume then begin
      AddResult(False, rssWarning, BOR_ProdQty_Warn, 'Bin Volume Should Not Be Blank');
      Exit;
    end;

  if IsDuplicate(BinLocation, BinNumber, ClassID, Id) <> 0 then begin
    AddResult(False, rssWarning, BOR_ProdQty_Warn, 'A Bin Already Exists For This Bin Location and Bin Number.');
    Exit;
  end;
  if (not active) and GetXMLNodeBooleanValue(CleanXMLNode, 'Active') then begin
      fd:=self.AvailableQuantity(self.ID, self.Connection.Connection);
    if fd <> 0 then begin
      s:= 'This Bin Location''s Available Quantity is '+ floattostrF(fd, ffGeneral, 15,2)+'.  ';
      if BinVolume_used = 0 then
        s:= s + NL+'(The used Volume = 0 becuase some of the Stock''s Unit of Measure does not have any Volume Allocated.)';
      s := s +NL+'So You Can not Make it Inactive.';
      AddResult(False, rssWarning, BOR_ProdQty_Warn, s);
      Exit;
    end;
  end;

  Result := inherited ValidateData;
end;


function TProductBin.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  postDB;
  Result := true;
end;

class procedure TProductBin.updatevolumeUSed(const fiBinId: Integer; const fdvolume, fdCleanVolume: Double; const Conn: TCustomMyConnection = nil);
var
  strSQL: string;
  fConn: TCustomMyConnection;
begin
  fConn := Conn;
  if fConn = nil then fConn := CommonDbLib.GetSharedMyDacConnection;
  strSQL := 'Update ' + GetBusObjectTablename + ' Set volume_Used = volume_Used +' + FloatToStr(fdvolume) + '-' + FloatToStr(fdCleanVolume) + ' where BinId = ' + IntToStr(fiBinId);
  getnewDataset(strSQL, fConn);
end;

class function TProductBin.IDToggle(const iBinId: Integer; const GetLocation: Boolean; const Conn: TCustomMyConnection = nil): string;
var
  strSQL: string;
  fConn: TCustomMyConnection;
begin
  fConn := Conn;
  Result := '';
  if iBinId = 0 then Exit;
  if fConn = nil then fConn := CommonDbLib.GetSharedMyDacConnection;
  strSQL := 'Select  BinLocation, BinNumber from ' + GetBusObjectTablename + ' where ' + GetIDField + ' = ' + IntToStr(iBinId);
  with getnewDataset(strSQL, fConn) do
    try
      if Recordcount > 0 then
        if GetLocation then Result := FieldByname('BinLocation').AsString
        else Result := FieldByname('Binnumber').AsString;
    finally
      if Active then Close;
      Free;
    end;

end;

class function TProductBin.IDToggle(const fiDepartmentID: Integer; const FSBinLocation, FSbinNumber: string; const Conn: TCustomMyConnection = nil): Integer;
var
  strSQL: string;
  fConn: TCustomMyConnection;
begin
  fConn := Conn;
  Result := 0;
  if fConn = nil then fConn := CommonDbLib.GetSharedMyDacConnection;
  strSQL := 'Select  ' + GetIDField + ' from ' + GetBusObjectTablename + ' where ifnull(BinLocation,"") = ' + QuotedStr(FSBinLocation) + ' and ifnull(Binnumber,"") = ' + QuotedStr(FSbinNumber) +
    ' and ClassId = ' + IntToStr(fiDepartmentID);
  with getnewDataset(strSQL, fConn) do
    try
      if Recordcount > 0 then Result := FieldByname(GetIDField).asInteger;
    finally
      if Active then Close;
      Free;
    end;

end;
initialization

RegisterClassOnce(TProductBin);
BusObjectListObj.TBusObjInfoList.Inst.Add('Product Bin', 'TProductBin', 'TBinLocationListGUI');

end.
