unit FormFactory;

{ML - This Object is used to register Popup GUIs. It's purpose is to serve up the
appropriate dynamic form when a DBGrid is double clicked

REGISTER A FORM
-----------------
Call RegisterMe in the Initialization section on any form you wish to popup on
the double click event of a DBGrid. eg.

Initialization
  FormFact.RegisterMe(TInvoiceGUI, 'TInvoiceListGUI_InvoiceDocNumber_Invoice=SaleID');

The first parameter will be the class you want to register, the second parameter is
a combination of; the calling classname (list), the Grid ColumnName and an
optional subsequent ID. The value to the right of the equals sign is the KeyID used to open the popup
form on the correct record

REGISTER A CONTROL
------------------
Call RegisterControl in the same manner as above on any form you wish to popup
according to the values in the control.

Initialization
  FormFact.RegisterControl(TfmSupplier, 'TPurchaseGUI_cboClient=ClientID');

The first parameter will be the class you want to register, the second parameter is
the calling classname (Popup form). The value to the right of the equals sign is
the KeyID used to open the popup form on the correct record. If you have a common
combo name like cboClient, you can substitute the calling class name with an Asterix *
e.g

Initialization
  FormFact.RegisterControl(TfrmCustomer, '*_cboClient=ClientID');

  ===> This will result in the customer form always opening when there is a cboClient control.


}

interface

uses
  Classes, BaseInputForm;

type
  TRegForm = TBaseInputGUI;

  TRegFormClass = class of TRegForm;

  TFormFactory = class(TObject)
  private
    lstFormList: TList;
    lstKeyName: TStringList;
    fsIdentifier, fsFieldName: string;
    function GetCount: integer;
    function GetForm(sKey: string): TRegForm;
    procedure RegisterSomething(const sClassName: TRegFormClass; const sKeyword: string);
    function GetFormIndex(sKey: string): Integer;
    function GetFormClassname(sKey: string): String;
  public
    constructor Create;
    destructor Destroy; override;

    class function Instance: TFormFactory;
    procedure RegisterMe(const sClassName: TRegFormClass; const sKeyword: string);
    procedure RegisterControl(const sClassName: TRegFormClass; const sKeyword: string);

    property Count: integer read GetCount;
    property CreateForm[sKey: string]: TRegForm read GetForm; default;
    property formClassName[sKey: string]: String read GetFormClassname; 
    property Identifier: string read fsIdentifier write fsIdentifier;
    property FieldName: string read fsFieldName write fsFieldName;
  end;

var
  FormFact: TFormFactory;

implementation

uses
  SysUtils, StrUtils, CommonLib,FastFuncs, forms;

constructor TFormFactory.Create;
begin
  inherited;
  lstFormList := TList.Create;
  lstKeyName := TStringList.Create;
end;

destructor TFormFactory.Destroy;
begin
  FreeAndNil(lstFormList);
  FreeAndNil(lstKeyName);
  inherited;
end;

function TFormFactory.GetCount: integer;
begin
  Result := lstFormList.Count;
end;

function TFormFactory.GetForm(sKey: string): TRegForm;
var
  iIndex: integer;
begin
  Result := nil;
  iIndex := GetFormIndex(sKey);
  if iIndex <> -1 then begin
    try
      Result := TRegForm(FindExistingComponent(TRegFormClass(lstFormList[iIndex]).ClassName));
      if Assigned(Result) then begin
        Result.BringToFront;
        Result.Close;
        Application.ProcessMessages;
      end;
      if FormStillOpen(TRegFormClass(lstFormList[iIndex]).ClassName) then
        Result := nil
      else
        Result := TRegForm(GetComponentByClassType(lstFormList[iIndex], true));
    except
    end;
  end;
end;

function TFormFactory.GetFormIndex(sKey: string): Integer;
var
  iIndex: integer;
  sWorkKey: string;
  iDelim: integer;
begin
  {Try searching on the column name first}
  iIndex := lstKeyName.IndexOfName(sKey);

  {Try a search with subsequent id as '*' if not found}
  if iIndex = -1 then begin
    iDelim   := LastDelimiter('_', sKey);
    sWorkKey := Copy(sKey, 1, iDelim - 1);

    // Make sure that a susequent ID field actually exists for this list
    // ie there are at least 2 '_'s
    iDelim := LastDelimiter('_', sWorkKey);
    if iDelim <> 0 then begin
      // Now seach for id wild carded string
      sWorkKey := sWorkKey + '_*';
      iIndex := lstKeyName.IndexOfName(sWorkKey);
      if iIndex <> -1 then begin
        sKey := sWorkKey; // found!!!
      end;
    end;
  end;

  {Try a subsequent search on '*' if not found RegisterMe}
  if iIndex = -1 then begin
    // replace last occurrence of field name with *
    sKey   := StringReplace(sKey, '_' + fsFieldName, '_*', [rfReplaceAll, rfIgnoreCase]);
    iIndex := lstKeyName.IndexOfName(sKey);
  end;

  {Try a subsequent search on '*' if not found for RegisterControl}
  if iIndex = -1 then begin
    // replace last occurrence of field name with *
    sKey   := StringReplace(sKey, fsFieldName, '*', [rfReplaceAll, rfIgnoreCase]);
    iIndex := lstKeyName.IndexOfName(sKey);
  end;

  fsIdentifier := StripQuotes(lstKeyName.Values[sKey]);

  result := iIndex;
end;

procedure TFormFactory.RegisterSomething(const sClassName: TRegFormClass; const sKeyword: string);
begin
  try
    lstFormList.Add(sClassName);
    lstKeyName.Add(sKeyword);
  except
    raise Exception.Create('Error whilst Attempting to store keyword in FormFactory');
  end;
end;

procedure TFormFactory.RegisterMe(const sClassName: TRegFormClass; const sKeyword: string);
begin
  RegisterSomething(sClassName, sKeyword);
end;

procedure TFormFactory.RegisterControl(const sClassName: TRegFormClass; const sKeyword: string);
begin
  RegisterSomething(sClassName, sKeyword);
end;

class function TFormFactory.Instance: TFormFactory;
begin
  if FormFact = nil then begin
    FormFact := TFormFactory.Create;
  end;
  Result := FormFact;
end;

function TFormFactory.GetFormClassname(sKey: string): String;
var
  iIndex: integer;
begin
  Result := '';
  iIndex := GetFormIndex(sKey);
  if iIndex <> -1 then
      Result:= TRegFormClass(lstFormList[iIndex]).ClassName;
end;

initialization
  TFormFactory.Instance;
finalization
  if FormFact <> nil then begin
    FreeAndNil(FormFact);
  end;
end.
