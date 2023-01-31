unit BusObjHRForms;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  31/01/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  THRForms = class(TMSBusObj)
  private
    function GetFormName            : string    ;
    function GetTemplate            : string    ;
    function GetFormtype            : string    ;
    function GetActive              : Boolean   ;
    Function GetLanguageID          : Integer;
    procedure SetFormName            (const Value: string    );
    procedure SetTemplate            (const Value: string    );
    procedure SetFormtype            (const Value: string    );
    procedure SetActive              (const Value: Boolean   );
    Procedure SetLanguageID          (Const Value: Integer   );
    function getTemplateTypeID: Integer;
    function getformtypeDescription: String;
    function getTemplateTypeName: String;
    function getSQLPortion(IdforTemplate: Integer): String;
    function getSQLPortionFodIds(IdsforTemplate: String): String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property TemplateTypeID:Integer read getTemplateTypeID;
    Property TemplateTypeName:String read getTemplateTypeName;
    Property formtypeDescription :String read getformtypeDescription;
    Property SQLPortion[IdforTemplate:Integer] :String read getSQLPortion;
    Property SQLPortionFodIds[IdsforTemplate:String] :String read getSQLPortionFodIds;
  published
    property FormName             :string      read GetFormName           write SetFormName        ;
    property Template             :string      read GetTemplate           write SetTemplate        ;
    property Formtype             :string      read GetFormtype           write SetFormtype        ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    Property LanguageID           :Integer     read getLanguageID         write setLanguageID;
  end;


implementation


uses tcDataUtils, CommonLib, SysUtils, LanguageTranslationObj;



  {THRForms}

constructor THRForms.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'HRForms';
  fSQL := 'SELECT * FROM tblhrforms';
end;


destructor THRForms.Destroy;
begin
  inherited;
end;


procedure THRForms.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FormName');
  SetPropertyFromNode(node,'Template');
  SetPropertyFromNode(node,'Formtype');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'LanguageID');

end;


procedure THRForms.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FormName' ,FormName);
  AddXMLNode(node,'Template' ,Template);
  AddXMLNode(node,'Formtype' ,Formtype);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'LanguageID' ,LanguageID);

end;


function THRForms.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if FormName = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Name sould not be blank' , True);
    Exit;
  end;
  if Template <> '' then
    if tcdataUtils.GetTemplateTypeId(Template) <> Self.TemplateTypeId then begin
      Resultstatus.AddItem(False , rssError , 0,  'Form Type (' + formtypeDescription+') can Print Templates of ' + quotedstr(TemplateTypeName) +'.  Selected Template '+ quotedstr(Template)+' is of type ' + GetTypeNameoftemplate(Template) , True);
      Exit;
    end;
  Result := True;
end;


function THRForms.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure THRForms.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure THRForms.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function THRForms.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function THRForms.getSQLPortion(IdforTemplate: Integer): String;
begin
  result := '';
       if formtype ='E' then result := 'EmployeeID =' + inttostr(IdforTemplate)
  else if formtype ='C' then result := 'clientId =' + inttostr(IdforTemplate);
end;

function THRForms.getSQLPortionFodIds(IdsforTemplate: String): String;
begin
  result := '';
  if IdsforTemplate = '' then IdsforTemplate := '0';
       if formtype ='E' then result := 'EmployeeID in (' + IdsforTemplate +')'
  else if formtype ='C' then result := 'ClientId   in (' + IdsforTemplate +')';
end;

class function THRForms.GetIDField: string;
begin
  Result := 'ID'
end;


class function THRForms.GetBusObjectTablename: string;
begin
  Result:= 'tblhrforms';
end;


function THRForms.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  LanguageId := TLanguageTranslationObj.Inst.UserLanguageId;
end;

function THRForms.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  THRForms.GetFormName        : string    ; begin Result := GetStringField('Name');end;
function  THRForms.GetTemplate        : string    ; begin Result := GetStringField('Template');end;
function  THRForms.GetFormtype        : string    ; begin Result := GetStringField('Formtype');end;
function  THRForms.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
Function THRForms.GetLanguageID       : Integer   ; begin Result := GetIntegerField('LanguageID'); end;
function THRForms.getTemplateTypeID   : Integer   ; begin Result := tcdatautils.TemplateTypeID(TemplateTypeName);end;
procedure THRForms.SetFormName        (const Value: string    ); begin SetStringField('Name'             , Value);end;
procedure THRForms.SetTemplate        (const Value: string    ); begin SetStringField('Template'         , Value);end;
procedure THRForms.SetFormtype        (const Value: string    ); begin SetStringField('Formtype'         , Value);end;
procedure THRForms.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'         , Value);end;
procedure THRForms.SetLanguageID      (const Value: Integer   ); begin SetIntegerField('LanguageID'     , Value);end;

function THRForms.getformtypeDescription: String;
begin
  result := '';
       if formtype ='E' then result := 'Employee'
  else if formtype ='C' then result := 'Customer';
end;

function THRForms.getTemplateTypeName: String;
begin
  result := '';
       if formtype ='E' then result := 'HR Forms - Employee'
  else if formtype ='C' then result := 'HR Forms - Customer';

end;

initialization
  RegisterClass(THRForms);


end.
