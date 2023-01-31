unit BusObjSeqNumber;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/01/20  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSeqNumber = class(TMSBusObj)
  private
    function GetSeqName             : string    ;
    function GetSeqValue            : Integer   ;
    function GetSeqMin              : Integer   ;
    function GetSeqMax              : Integer   ;
    function GetSeqStep             : Integer   ;
    function GetSeqRecycle          : Boolean   ;
    function GetPadToDigits         : Integer   ;
    function GetThreadID            : Integer   ;
    procedure SetSeqName             (const Value: string    );
    procedure SetSeqValue            (const Value: Integer   );
    procedure SetSeqMin              (const Value: Integer   );
    procedure SetSeqMax              (const Value: Integer   );
    procedure SetSeqStep             (const Value: Integer   );
    procedure SetSeqRecycle          (const Value: Boolean   );
    procedure SetPadToDigits         (const Value: Integer   );
    procedure SetThreadID            (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoCheckCreate(aSeqName: string; aSeqMax: integer = 0;aSeqMin: integer =1; aSeqStep: integer = 1; aPadToDigits: integer =0);
    class procedure CheckCreate(aSeqName: string; aSeqMax: integer = 0;aSeqMin: integer =1; aSeqStep: integer = 1; aPadToDigits: integer =0);
//    class procedure CheckCreate(aSeqName: string; aSeqMax: integer; aPadToDigits: integer =0); overload;
  published
    property SeqName              :string      read GetSeqName            write SetSeqName         ;
    property SeqValue             :Integer     read GetSeqValue           write SetSeqValue        ;
    property SeqMin               :Integer     read GetSeqMin             write SetSeqMin          ;
    property SeqMax               :Integer     read GetSeqMax             write SetSeqMax          ;
    property SeqStep              :Integer     read GetSeqStep            write SetSeqStep         ;
    property SeqRecycle           :Boolean     read GetSeqRecycle         write SetSeqRecycle      ;
    property PadToDigits          :Integer     read GetPadToDigits        write SetPadToDigits     ;
    property ThreadID             :Integer     read GetThreadID           write SetThreadID        ;
  end;


implementation


uses
//  tcDataUtils, CommonLib;
  ERPDbComponents, DbSharedObjectsObj, CommonDbLib, SysUtils;


  {TSeqNumber}

procedure TSeqNumber.DoCheckCreate(aSeqName: string; aSeqMax, aSeqMin, aSeqStep,
  aPadToDigits: integer);
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select * from ' + GetBusObjectTablename + ' where SeqName = ' + QuotedStr(aSeqName));
    qry.Open;
    if qry.IsEmpty then begin
      qry.Insert;
      qry.FieldByName('SeqName').AsString := aSeqName;
      qry.FieldByName('SeqMin').AsInteger := aSeqMin;
      qry.FieldByName('SeqValue').AsInteger := aSeqMin -1;
      qry.FieldByName('SeqMax').AsInteger := aSeqMax;
      qry.FieldByName('SeqStep').AsInteger := aSeqStep;
      qry.FieldByName('SeqRecycle').AsBoolean := aSeqMax > 0;
      qry.FieldByName('PadToDigits').AsInteger := aPadToDigits;
      qry.Post;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

class procedure TSeqNumber.CheckCreate(aSeqName: string; aSeqMax, aSeqMin,
  aSeqStep, aPadToDigits: integer);
var
  SeqNo: TSeqNumber;
begin
  SeqNo := TSeqNumber.CreateWithSharedConn(nil);
  try
    SeqNo.DoCheckCreate(aSeqName, aSeqMax, aSeqMin, aSeqStep, aPadToDigits);
  finally
    SeqNo.Free;
  end;
end;

//class procedure TSeqNumber.CheckCreate(aSeqName: string; aSeqMax,
//  aPadToDigits: integer);
//var
//  SeqNo: TSeqNumber;
//begin
//  SeqNo := TSeqNumber.CreateWithSharedConn(nil);
//  try
//    SeqNo.DoCheckCreate(aSeqName, aSeqMax, 1, 1, aPadToDigits);
//  finally
//    SeqNo.Free;
//  end;
//end;

constructor TSeqNumber.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SeqNumber';
  fSQL := 'SELECT * FROM tblseqnumbers';
end;


destructor TSeqNumber.Destroy;
begin
  inherited;
end;


procedure TSeqNumber.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SeqName');
  SetPropertyFromNode(node,'SeqValue');
  SetPropertyFromNode(node,'SeqMin');
  SetPropertyFromNode(node,'SeqMax');
  SetPropertyFromNode(node,'SeqStep');
  SetBooleanPropertyFromNode(node,'SeqRecycle');
  SetPropertyFromNode(node,'PadToDigits');
  SetPropertyFromNode(node,'ThreadID');
end;


procedure TSeqNumber.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SeqName' ,SeqName);
  AddXMLNode(node,'SeqValue' ,SeqValue);
  AddXMLNode(node,'SeqMin' ,SeqMin);
  AddXMLNode(node,'SeqMax' ,SeqMax);
  AddXMLNode(node,'SeqStep' ,SeqStep);
  AddXMLNode(node,'SeqRecycle' ,SeqRecycle);
  AddXMLNode(node,'PadToDigits' ,PadToDigits);
  AddXMLNode(node,'ThreadID' ,ThreadID);
end;


function TSeqNumber.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TSeqNumber.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSeqNumber.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSeqNumber.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSeqNumber.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSeqNumber.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSeqNumber.GetBusObjectTablename: string;
begin
  Result:= 'tblseqnumbers';
end;


function TSeqNumber.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSeqNumber.GetSeqName         : string    ; begin Result := GetStringField('SeqName');end;
function  TSeqNumber.GetSeqValue        : Integer   ; begin Result := GetIntegerField('SeqValue');end;
function  TSeqNumber.GetSeqMin          : Integer   ; begin Result := GetIntegerField('SeqMin');end;
function  TSeqNumber.GetSeqMax          : Integer   ; begin Result := GetIntegerField('SeqMax');end;
function  TSeqNumber.GetSeqStep         : Integer   ; begin Result := GetIntegerField('SeqStep');end;
function  TSeqNumber.GetSeqRecycle      : Boolean   ; begin Result := GetBooleanField('SeqRecycle');end;
function  TSeqNumber.GetPadToDigits     : Integer   ; begin Result := GetIntegerField('PadToDigits');end;
function  TSeqNumber.GetThreadID        : Integer   ; begin Result := GetIntegerField('ThreadID');end;
procedure TSeqNumber.SetSeqName         (const Value: string    ); begin SetStringField('SeqName'          , Value);end;
procedure TSeqNumber.SetSeqValue        (const Value: Integer   ); begin SetIntegerField('SeqValue'         , Value);end;
procedure TSeqNumber.SetSeqMin          (const Value: Integer   ); begin SetIntegerField('SeqMin'           , Value);end;
procedure TSeqNumber.SetSeqMax          (const Value: Integer   ); begin SetIntegerField('SeqMax'           , Value);end;
procedure TSeqNumber.SetSeqStep         (const Value: Integer   ); begin SetIntegerField('SeqStep'          , Value);end;
procedure TSeqNumber.SetSeqRecycle      (const Value: Boolean   ); begin SetBooleanField('SeqRecycle'       , Value);end;
procedure TSeqNumber.SetPadToDigits     (const Value: Integer   ); begin SetIntegerField('PadToDigits'      , Value);end;
procedure TSeqNumber.SetThreadID        (const Value: Integer   ); begin SetIntegerField('ThreadID'         , Value);end;


initialization
  RegisterClass(TSeqNumber);


end.
