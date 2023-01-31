unit BusobjLanguageTranslation;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  22/12/10  1.00.00    Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TLanguageTranslation = class(TMSBusObj)
  private
    function GetLanguageID     : Integer   ;
    function GetEnglishID      : Integer   ;
    function GetTranslation    : string    ;
    function GetModified       : Boolean   ;
    procedure SetLanguageID     (const Value: Integer   );
    procedure SetEnglishID      (const Value: Integer   );
    procedure SetTranslation    (const Value: string    );
    procedure SetModified       (const Value: Boolean   );
    function getEnglish: String;
    function getLanguage: String;
    procedure setEnglish(const Value: String);
    procedure setLanguage(const Value: String);
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
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property LanguageID      :Integer     read GetLanguageID    write SetLanguageID ;
    property EnglishID       :Integer     read GetEnglishID     write SetEnglishID  ;
    property Translation     :string      read GetTranslation   write SetTranslation;
    property Modified        :Boolean     read GetModified      write SetModified   ;
    Property Language        :String      REad getLanguage      Write setLanguage;
    Property English         :String      Read getEnglish       Write setEnglish;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils;



  {TLanguageTranslation}

constructor TLanguageTranslation.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'LanguageTranslation';
  fSQL := 'SELECT * FROM languagetranslation';
end;


destructor TLanguageTranslation.Destroy;
begin
  inherited;
end;

procedure TLanguageTranslation.setEnglish(const Value: String);
begin
  With getNewDataset('Select ID from inEnglish where inenglish = ' +Quotedstr(Value) , true) do try
    EnglishID := fieldByname('ID').asInteger;
  finally
    if active then close;
    free;
  end;

end;

function TLanguageTranslation.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if LanguageID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'LanguageID should not be 0' , False );
    Exit;
  end;
  if EnglishID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EnglishID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TLanguageTranslation.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TLanguageTranslation.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TLanguageTranslation.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TLanguageTranslation.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TLanguageTranslation.GetIDField: string;
begin
  Result := 'ID'
end;


function TLanguageTranslation.getLanguage: String;
begin
  With getNewDataset('Select Language from languages where Id = ' +inttostr(LanguageID) , true) do try
    result := fieldByname('Language').asString;
  finally
    if active then close;
    free;
  end;

end;

class function TLanguageTranslation.GetBusObjectTablename: string;
begin
  Result:= 'languagetranslation';
end;


function TLanguageTranslation.getEnglish: String;
begin
  With getNewDataset('Select inenglish from inEnglish where Id = ' +inttostr(EnglishID) , true) do try
    result := fieldByname('InEnglish').asString;
  finally
    if active then close;
    free;
  end;
end;

function TLanguageTranslation.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TLanguageTranslation.GetLanguageID : Integer   ; begin Result := GetIntegerField('LanguageID');end;
function  TLanguageTranslation.GetEnglishID  : Integer   ; begin Result := GetIntegerField('EnglishID');end;
function  TLanguageTranslation.GetTranslation: string    ; begin Result := GetStringField('Translation');end;
function  TLanguageTranslation.GetModified   : Boolean   ; begin Result := GetBooleanField('Modified');end;
procedure TLanguageTranslation.SetLanguageID (const Value: Integer   ); begin SetIntegerField('LanguageID' , Value);end;
procedure TLanguageTranslation.SetEnglishID  (const Value: Integer   ); begin SetIntegerField('EnglishID'   , Value);end;
procedure TLanguageTranslation.setLanguage(const Value: String);
begin
  With getNewDataset('Select Id from languages where  Language= ' +quotedstr(Value) , true) do try
    LanguageID := fieldByname('ID').asInteger;
  finally
    if active then close;
    free;
  end;
end;

procedure TLanguageTranslation.SetTranslation(const Value: string    ); begin SetStringField('Translation'   , Value);end;

procedure TLanguageTranslation.SetModified   (const Value: Boolean   ); begin SetBooleanField('Modified'    , Value);end;


initialization
  RegisterClass(TLanguageTranslation);


end.
