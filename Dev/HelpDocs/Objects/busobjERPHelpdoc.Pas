unit busobjERPHelpdoc;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  20/08/19  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  THelpDoc = class(TMSBusObj)
  private
    function GetDescription      : string    ;
    function GetFiletype         : string    ;
    function GetFilename         : string    ;
    function GetModulename       : string    ;
    function GetIsERPTaskItem    : Boolean   ;
    function GetActive    : Boolean   ;
    procedure SetDescription      (const Value: string    );
    procedure SetFiletype         (const Value: string    );
    procedure SetFilename         (const Value: string    );
    procedure SetModulename       (const Value: string    );
    procedure SetIsERPTaskItem    (const Value: Boolean   );
    procedure SetActive    (const Value: Boolean   );
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
    Function LoadFromfile(aFileName: string):Boolean;
  published
    property Description       :string      read GetDescription     write SetDescription  ;
    property Filetype          :string      read GetFiletype        write SetFiletype     ;
    property Filename          :string      read GetFilename        write SetFilename     ;
    property Modulename        :string      read GetModulename      write SetModulename   ;
    property IsERPTaskItem     :Boolean     read GetIsERPTaskItem   write SetIsERPTaskItem;
    property Active     :Boolean     read GetActive   write SetActive;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils, systemlib, tcConst;

  {THelpDoc}

constructor THelpDoc.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'helpdocs';
  fSQL := 'SELECT * FROM erpdocumentaion.tblhelpdocs';
end;


destructor THelpDoc.Destroy;
begin
  inherited;
end;


Function THelpDoc.LoadFromfile(aFileName: string):Boolean;
var
  BLOB : TStream;
  fs : TFileStream;
begin
  Result := False;
  if not FileExists(aFileName) then begin
    AddResult(false, rssError, 0, 'File not found: "' + aFileName + '"');
    exit;
  end;
  filename := ExtractFilename(aFilename);
  if not validatedata then begin
    Description :='';
    fileType := '';
    filename := '';
    Exit;
  end;
  result := True;
  if dataset.findfield('Document') <> nil then begin
      ResultSTatus.Clear;

      fileType := uppercase(replacestr(ExtractFileExt(aFileName), '.' , ''));
      if (fileType <> 'DOC') and (fileType <> 'PDF') and (fileType <> 'RTF') then begin
        AddResult(false, rssError, 0, 'Invalid File Format. Please Choose DOC / RTF / PDF file');
        exit;
      end;
      if Description = '' then    Description :=ExtractFilename(aFileName);
      PostDB;


      try
        EditDB;
        fs := TFileStream.Create(afilename , fmOpenRead);
        fs.Position:= 0;
        blob := dataset.CreateBlobStream(dataset.fieldByname('Document') , bmWrite);
        blob.CopyFrom(fs,0);
        PostDB;
      finally
        Freeandnil(fs);
        Freeandnil(blob);
      end;
  end;
end;

procedure THelpDoc.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'Filetype');
  SetPropertyFromNode(node,'Filename');
  SetPropertyFromNode(node,'Modulename');
  SetBooleanPropertyFromNode(node,'IsERPTaskItem');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure THelpDoc.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Filetype' ,Filetype);
  AddXMLNode(node,'Filename' ,Filename);
  AddXMLNode(node,'Modulename' ,Modulename);
  AddXMLNode(node,'IsERPTaskItem' ,IsERPTaskItem);
  AddXMLNode(node,'Active' ,Active);
end;


function THelpDoc.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  if (Description = '') or (filename = '')  then begin
    AddResult(false, rssError, 0, 'Please Provide the file name and Description');
    exit;
  end;

  if (filetype = '')  then begin
    AddResult(false, rssError, 0, 'Invalid File Format. Please Choose DOC / RTF / PDF file');
    exit;
  end;
  Result := True;
end;


function THelpDoc.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure THelpDoc.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure THelpDoc.DoFieldOnChange(Sender: TField);
var
  s:String;
begin
  inherited;
  if sametext(SEnder.fieldname , 'Description') then begin
  end;
  if (trim(fileType)<> '') and (trim(description)<> '') then begin
    s:= ValidFileName(trim(Description)+'.' + trim(filetype));
    if not sametext(filename ,s) then
      filename := s;
  end;
end;


function THelpDoc.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function THelpDoc.GetIDField: string;
begin
  Result := 'ID'
end;


class function THelpDoc.GetBusObjectTablename: string;
begin
  Result:= 'erpdocumentaion.tblhelpdocs';
end;


function THelpDoc.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  THelpDoc.GetDescription  : string    ; begin Result := GetStringField('Description');end;
function  THelpDoc.GetFiletype     : string    ; begin Result := GetStringField('Filetype');end;
function  THelpDoc.GetFilename     : string    ; begin Result := GetStringField('Filename');end;
function  THelpDoc.GetModulename   : string    ; begin Result := GetStringField('Modulename');end;
function  THelpDoc.GetIsERPTaskItem: Boolean   ; begin Result := GetBooleanField('IsERPTaskItem');end;
function  THelpDoc.GetActive: Boolean   ; begin Result := GetBooleanField('Active');end;
procedure THelpDoc.SetDescription  (const Value: string    ); begin SetStringField('Description'   , Value);end;
procedure THelpDoc.SetFiletype     (const Value: string    ); begin SetStringField('Filetype'      , Value);end;
procedure THelpDoc.SetIsERPTaskItem(const Value: Boolean   ); begin SetBooleanField('IsERPTaskItem' , Value);end;
procedure THelpDoc.SetActive       (const Value: Boolean   ); begin SetBooleanField('Active' , Value);end;
procedure THelpDoc.SetModulename   (const Value: string    ); begin SetStringField('Modulename' ,Value );end;
procedure THelpDoc.SetFilename     (const Value: string    );
begin
  if (Value <> '') and (filename <> value) then begin
    SetStringField('Filename' ,Value );
    fileType := uppercase(replacestr(ExtractFileExt(Value), '.' , ''));
    Description :=replacestr(Value, '.'+filetype,'');
  end;
end;


initialization
  RegisterClass(THelpDoc);


end.
