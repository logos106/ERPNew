unit busobjSimpletypeActions;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  16/03/10  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSimpleTypeActions = class(TMSBusObj)
  private
    function GetChoice            : string    ;
    function GetSeqno             : Integer   ;
    function GetSimpletypeId      : Integer   ;
    function GetSimpletypeName    : string    ;
    function Getsimpletypecode    : string    ;
    function GetActive            : Boolean   ;
    procedure SetChoice            (const Value: string    );
    procedure SetSeqno             (const Value: Integer   );
    procedure SetSimpletypeId      (const Value: Integer   );
    procedure SetSimpletypeName    (const Value: string    );
    procedure Setsimpletypecode    (const Value: string    );
    procedure SetActive            (const Value: Boolean   );
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
    class Function StatusForchoice(fschoice:String; fstypecode:String):Integer;
    class Function SeqNoForchoice(fschoice:String; fstypecode:String):Integer;
    class Function SeqNoForstatus(fsStatus:String; fstypecode:String):Integer;
  published
    property Choice             :string      read GetChoice           write SetChoice        ;
    property Seqno              :Integer     read GetSeqno            write SetSeqno         ;
    property SimpletypeId       :Integer     read GetSimpletypeId     write SetSimpletypeId  ;
    property SimpletypeName     :string      read GetSimpletypeName   write SetSimpletypeName;
    property simpletypecode     :string      read Getsimpletypecode   write Setsimpletypecode;
    property Active             :Boolean     read GetActive           write SetActive        ;
  end;


implementation


uses tcDataUtils, CommonLib, CommonDbLib, sysutils;



  {TSimpleTypeActions}

constructor TSimpleTypeActions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SimpleTypeActions';
  fSQL := 'SELECT * FROM tblsimpletypeactions';
  fSQLOrder := 'SeqNo';
end;


destructor TSimpleTypeActions.Destroy;
begin
  inherited;
end;


procedure TSimpleTypeActions.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Choice');
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'SimpletypeId');
  SetPropertyFromNode(node,'SimpletypeName');
  SetPropertyFromNode(node,'simpletypecode');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TSimpleTypeActions.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Choice' ,Choice);
  AddXMLNode(node,'Seqno' ,Seqno);
  AddXMLNode(node,'SimpletypeId' ,SimpletypeId);
  AddXMLNode(node,'SimpletypeName' ,SimpletypeName);
  AddXMLNode(node,'simpletypecode' ,simpletypecode);
  AddXMLNode(node,'Active' ,Active);
end;


function TSimpleTypeActions.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Seqno = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Seqno should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TSimpleTypeActions.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSimpleTypeActions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSimpleTypeActions.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSimpleTypeActions.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSimpleTypeActions.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSimpleTypeActions.GetBusObjectTablename: string;
begin
  Result:= 'tblsimpletypeactions';
end;


function TSimpleTypeActions.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSimpleTypeActions.GetChoice        : string    ; begin Result := GetStringField('Choice');end;
function  TSimpleTypeActions.GetSeqno         : Integer   ; begin Result := GetIntegerField('Seqno');end;
function  TSimpleTypeActions.GetSimpletypeId  : Integer   ; begin Result := GetIntegerField('SimpletypeId');end;
function  TSimpleTypeActions.GetSimpletypeName: string    ; begin Result := GetStringField('SimpletypeName');end;
function  TSimpleTypeActions.Getsimpletypecode: string    ; begin Result := GetStringField('simpletypecode');end;
function  TSimpleTypeActions.GetActive        : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TSimpleTypeActions.SetChoice        (const Value: string    ); begin SetStringField('Choice'         , Value);end;
procedure TSimpleTypeActions.SetSeqno         (const Value: Integer   ); begin SetIntegerField('Seqno'          , Value);end;
procedure TSimpleTypeActions.SetSimpletypeId  (const Value: Integer   ); begin SetIntegerField('SimpletypeId'   , Value);end;
procedure TSimpleTypeActions.SetSimpletypeName(const Value: string    ); begin SetStringField('SimpletypeName'   , Value);end;
procedure TSimpleTypeActions.Setsimpletypecode(const Value: string    ); begin SetStringField('simpletypecode'   , Value);end;
procedure TSimpleTypeActions.SetActive        (const Value: Boolean   ); begin SetBooleanField('Active'         , Value);end;


class function TSimpleTypeActions.StatusForchoice(fschoice,fstypecode: String): Integer;
begin
  With TempMyQuery do try
    SQL.add('Select SimpletypeID from ' +GetBusObjectTablename +' where   Choice = ' +quotedStr(fsChoice) +' and    simpletypecode = ' +QuotedStr(fstypecode)+' and active ="T"');
    open;
    result := Fieldbyname('SimpletypeID').asInteger;
  finally
      if active then close;
      free;
  end;
end;

class function TSimpleTypeActions.SeqNoForchoice(fschoice,  fstypecode: String): Integer;
begin
  With TempMyQuery do try
    SQL.add('Select SeqNo from ' +GetBusObjectTablename +' where   Choice = ' +quotedStr(fsChoice) +' and    simpletypecode = ' +QuotedStr(fstypecode)+' and active ="T"');
    open;
    result := Fieldbyname('SeqNo').asInteger;
  finally
      if active then close;
      free;
  end;
end;

class function TSimpleTypeActions.SeqNoForstatus(fsStatus,  fstypecode: String): Integer;
begin

  With TempMyQuery do try
    SQL.add('Select SeqNo from ' +GetBusObjectTablename +' where   SimpletypeName = ' +quotedStr(fsStatus) +' and    simpletypecode = ' +QuotedStr(fstypecode)+' and active ="T"');
    open;
    result := Fieldbyname('SeqNo').asInteger;
  finally
      if active then close;
      free;
  end;

end;

initialization
  RegisterClass(TSimpleTypeActions);


end.
