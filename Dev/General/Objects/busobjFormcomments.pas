unit busobjFormcomments;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  08/03/13  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TFormComments = class(TMSBusObj)
  private
    function GetformId              : Integer   ;
    function GetComments            : string    ;
    function Getactive              : Boolean   ;
    procedure SetformId              (const Value: Integer   );
    procedure SetComments            (const Value: string    );
    procedure Setactive              (const Value: Boolean   );
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
    property formId               :Integer     read GetformId             write SetformId          ;
    property Comments             :string      read GetComments           write SetComments        ;
    property active               :Boolean     read Getactive             write Setactive          ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TFormComments}

constructor TFormComments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'FromCommnets';
  fSQL := 'SELECT * FROM tblfromcommnets';
end;


destructor TFormComments.Destroy;
begin
  inherited;
end;


procedure TFormComments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'formId');
  SetPropertyFromNode(node,'Comments');
  SetBooleanPropertyFromNode(node,'active');
end;


procedure TFormComments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'formId' ,formId);
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'active' ,active);
end;


function TFormComments.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if formId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'formId should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TFormComments.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TFormComments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TFormComments.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TFormComments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TFormComments.GetIDField: string;
begin
  Result := 'ID'
end;


class function TFormComments.GetBusObjectTablename: string;
begin
  Result:= 'tblfromcommnets';
end;


function TFormComments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TFormComments.GetformId          : Integer   ; begin Result := GetIntegerField('formId');end;
function  TFormComments.GetComments        : string    ; begin Result := GetStringField('Comments');end;
function  TFormComments.Getactive          : Boolean   ; begin Result := GetBooleanField('active');end;
procedure TFormComments.SetformId          (const Value: Integer   ); begin SetIntegerField('formId'           , Value);end;
procedure TFormComments.SetComments        (const Value: string    ); begin SetStringField('Comments'         , Value);end;
procedure TFormComments.Setactive          (const Value: Boolean   ); begin SetBooleanField('active'           , Value);end;


initialization
  RegisterClass(TFormComments);


end.
