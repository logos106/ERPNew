unit busobjUDErpHelpDocs;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  18/01/19  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , BusobjERPHelpDoc;


type
  TUDErpHelpDocs = class(THelpDoc)
  private
    function GetContextId        : Integer   ;
    function GetIsERPTaskItem    : Boolean   ;
    procedure SetContextId        (const Value: Integer   );
    procedure SetIsERPTaskItem    (const Value: Boolean   );
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
    property ContextId         :Integer     read GetContextId       write SetContextId    ;
    property IsERPTaskItem     :Boolean     read GetIsERPTaskItem   write SetIsERPTaskItem;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TUDErpHelpDocs}

constructor TUDErpHelpDocs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'UDErpHelpDocs';
  fSQL := 'SELECT * FROM tbluderphelpdocs';
end;


destructor TUDErpHelpDocs.Destroy;
begin
  inherited;
end;


procedure TUDErpHelpDocs.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ContextId');
  SetBooleanPropertyFromNode(node,'IsERPTaskItem');
end;


procedure TUDErpHelpDocs.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ContextId' ,ContextId);
  AddXMLNode(node,'IsERPTaskItem' ,IsERPTaskItem);
end;


function TUDErpHelpDocs.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TUDErpHelpDocs.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TUDErpHelpDocs.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TUDErpHelpDocs.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TUDErpHelpDocs.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TUDErpHelpDocs.GetIDField: string;
begin
  Result := 'ID'
end;


class function TUDErpHelpDocs.GetBusObjectTablename: string;
begin
  Result:= 'tbluderphelpdocs';
end;


function TUDErpHelpDocs.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TUDErpHelpDocs.GetContextId    : Integer   ; begin Result := GetIntegerField('ContextId');end;
function  TUDErpHelpDocs.GetIsERPTaskItem: Boolean   ; begin Result := GetBooleanField('IsERPTaskItem');end;
procedure TUDErpHelpDocs.SetContextId    (const Value: Integer   ); begin SetIntegerField('ContextId'     , Value);end;
procedure TUDErpHelpDocs.SetIsERPTaskItem(const Value: Boolean   ); begin SetBooleanField('IsERPTaskItem' , Value);end;


initialization
  RegisterClass(TUDErpHelpDocs);


end.
