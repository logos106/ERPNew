unit busobjcomplogo;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  16/07/20  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , BusObjPicture;


type
  TCompLogo =class(TbusobjPicture)
  private
    function GetSetupID             : Integer   ;
    function GetPictype             : string    ;
    function GetImageName           : string    ;
    function GetImageTypes          : string    ;
    procedure SetSetupID             (const Value: Integer   );
    procedure SetPictype             (const Value: string    );
    procedure SetImageName           (const Value: string    );
    procedure SetImageTypes          (const Value: string    );
    function GetMIMEEncodedPicture: string;
    procedure SetMIMEEncodedPicture(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function Picturefieldname:String;Override;
    function Picturetypefieldname:String;Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure Load(const fIsReadonly: Boolean = False); override;
  published
    property SetupID              :Integer     read GetSetupID            write SetSetupID         ;
    property Pictype              :string      read GetPictype            write SetPictype         ;
    property ImageName            :string      read GetImageName          write SetImageName       ;
    property ImageTypes           :string      read GetImageTypes         write SetImageTypes      ;
    property MIMEEncodedPicture: string read GetMIMEEncodedPicture write SetMIMEEncodedPicture;
  end;


implementation


uses tcDataUtils, CommonLib , IdCoderMIME, sysutils;



  {TCompLogo}

constructor TCompLogo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CompLogo';
  fSQL := 'SELECT * FROM tblcomplogo';
end;


destructor TCompLogo.Destroy;
begin
  inherited;
end;


procedure TCompLogo.Load(const fIsReadonly: Boolean);
begin
  inherited;
  FreeAndNil(fPictureStream);
end;

procedure TCompLogo.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SetupID');
  SetPropertyFromNode(node,'Pictype');
  SetPropertyFromNode(node,'ImageName');
  SetPropertyFromNode(node,'ImageTypes');
end;


procedure TCompLogo.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SetupID' ,SetupID);
  AddXMLNode(node,'Pictype' ,Pictype);
  AddXMLNode(node,'ImageName' ,ImageName);
  AddXMLNode(node,'ImageTypes' ,ImageTypes);
end;


function TCompLogo.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SetupID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SetupID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TCompLogo.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCompLogo.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


function TCompLogo.Picturefieldname: String;
begin
  Result := 'CompLog';
end;

function TCompLogo.Picturetypefieldname: String;
begin
  result := 'Pictype';
end;

procedure TCompLogo.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TCompLogo.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCompLogo.GetIDField: string;
begin
  Result := 'ID'
end;


class function TCompLogo.GetBusObjectTablename: string;
begin
  Result:= 'tblcomplogo';
end;


function TCompLogo.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TCompLogo.GetSetupID         : Integer   ; begin Result := GetIntegerField('SetupID');end;
function  TCompLogo.GetPictype         : string    ; begin Result := GetStringField('Pictype');end;
function  TCompLogo.GetImageName       : string    ; begin Result := GetStringField('ImageName');end;
function  TCompLogo.GetImageTypes      : string    ; begin Result := GetStringField('ImageTypes');end;
function TCompLogo.GetMIMEEncodedPicture: string;
var
  MIMEEncoder: TIdEncoderMIME;
  Stream: TStream;
  fld: TField;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  fld := Dataset.FieldByName('CompLog');
  if (Dataset.State in [dsEdit, dsInsert]) then
    Stream := Dataset.CreateBlobStream(TBlobField(fld), bmReadWrite)
  else
    Stream := Dataset.CreateBlobStream(TBlobField(fld), bmRead);
  try
    Result := MIMEEncoder.Encode(Stream);
  finally
    MIMEEncoder.Free;
    Stream.Free;
  end;
end;

procedure TCompLogo.SetSetupID         (const Value: Integer   ); begin SetIntegerField('SetupID'          , Value);end;
procedure TCompLogo.SetPictype         (const Value: string    ); begin SetStringField('Pictype'          , Value);end;
procedure TCompLogo.SetImageName       (const Value: string    ); begin SetStringField('ImageName'        , Value);end;
procedure TCompLogo.SetImageTypes      (const Value: string    ); begin SetStringField('ImageTypes'       , Value);end;


procedure TCompLogo.SetMIMEEncodedPicture(const Value: string);
var
  DecoderMIME: TIdDecoderMIME;
  Stream: TStream;
  fld: TField;
begin
  DecoderMIME := TIdDecoderMIME.Create(nil);
  try
    if not(Dataset.State in [dsEdit, dsInsert]) then Dataset.Edit;
    fld := Dataset.FieldByName('CompLog');
    Stream := Dataset.CreateBlobStream(TBlobField(fld), bmReadWrite);
    try
      DecoderMIME.DecodeBegin(Stream);
      try
        DecoderMIME.Decode(Value);
      finally
        DecoderMIME.DecodeEnd;
      end;
    finally
      Stream.free;
    end;
  finally
    DecoderMIME.Free;
  end;
end;


initialization
  RegisterClass(TCompLogo);


end.

