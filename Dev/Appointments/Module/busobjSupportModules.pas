unit busobjSupportModules;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  06/07/11  1.00.00  bs  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLIntf;


type
  TSupportModules = class(TMSBusObj)
  private
    function GetModuleName     : string    ;
    function GetActive         : Boolean   ;
    procedure SetModuleName     (const Value: string    );
    procedure SetActive         (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function GetKeyStringField: string; Override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ModuleName      :string      read GetModuleName    write SetModuleName ;
    property Active          :Boolean     read GetActive        write SetActive     ;
  end;


implementation


uses tcDataUtils, CommonLib , sysutils;



  {TSupportModules}

constructor TSupportModules.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SupportModules';
  fSQL := 'SELECT * FROM tblsupportmodules';
end;


destructor TSupportModules.Destroy;
begin
  inherited;
end;


procedure TSupportModules.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ModuleName');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TSupportModules.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ModuleName' ,ModuleName);
  AddXMLNode(node,'Active' ,Active);
end;


function TSupportModules.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Modulename = '' then begin
    REsultStatus.AddItem( False ,rssWarning , 0 ,  'Module name should not be blank' , true);
    Exit;
  end;
  if not(IsUnique(Id , 'ModuleName = ' +Quotedstr(ModuleName))) then begin
    REsultStatus.AddItem( False ,rssWarning , 0 ,  'Module name '+ Quotedstr(ModuleName) +' Already Exists, should be Unique' , true);
    Exit;
  end;
  Result := True;
end;


function TSupportModules.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSupportModules.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSupportModules.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSupportModules.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSupportModules.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSupportModules.GetKeyStringField: string;
begin
  Result:= 'ModuleName';
end;

class function TSupportModules.GetBusObjectTablename: string;
begin
  Result:= 'tblsupportmodules';
end;


function TSupportModules.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSupportModules.GetModuleName : string    ; begin Result := GetStringField('ModuleName');end;
function  TSupportModules.GetActive     : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TSupportModules.SetModuleName (const Value: string    ); begin SetStringField('ModuleName' , Value);end;
procedure TSupportModules.SetActive     (const Value: Boolean   ); begin SetBooleanField('Active'      , Value);end;


initialization
  RegisterClass(TSupportModules);


end.
