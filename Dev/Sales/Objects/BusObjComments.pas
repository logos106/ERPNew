unit BusObjComments;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  18/06/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TComments = class(TMSBusObj)
  private
    function GetComments            : string    ;
    function GetCommentsType        : string    ;
    procedure SetComments            (const Value: string    );
    procedure SetCommentsType        (const Value: string    );
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
    property Comments             :string      read GetComments           write SetComments        ;
    property CommentsType         :string      read GetCommentsType       write SetCommentsType    ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TComments}

constructor TComments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Comments';
  fSQL := 'SELECT * FROM tblcomments';
end;


destructor TComments.Destroy;
begin
  inherited;
end;


procedure TComments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Comments');
  SetPropertyFromNode(node,'CommentsType');
end;


procedure TComments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'CommentsType' ,CommentsType);
end;


function TComments.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TComments.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TComments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TComments.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TComments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TComments.GetIDField: string;
begin
  Result := 'CommentsID'
end;


class function TComments.GetBusObjectTablename: string;
begin
  Result:= 'tblcomments';
end;


function TComments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TComments.GetComments        : string    ; begin Result := GetStringField('Comments');end;
function  TComments.GetCommentsType    : string    ; begin Result := GetStringField('CommentsType');end;
procedure TComments.SetComments        (const Value: string    ); begin SetStringField('Comments'         , Value);end;
procedure TComments.SetCommentsType    (const Value: string    ); begin SetStringField('CommentsType'     , Value);end;


initialization
  RegisterClass(TComments);


end.
