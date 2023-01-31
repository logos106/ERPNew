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
  FormFact.RegisterControl(TfrmSupplier, 'TPurchaseGUI_cboClient=ClientID');

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
  Classes, Forms,BaseInputForm;

type
  TRegForm = TBaseInputGUI;

  TRegFormClass = class of TRegForm;

  TFormFactory = class(TObject)
  private
    lstFormList: TList;
    lstKeyName: TStringList;
    fsIdentifier, fsFieldName: String;
    constructor Create;
    class function Instance: TFormFactory;
    function GetCount: Integer;
    function GetForm (sKey: String): TRegForm;
    procedure RegisterSomething(Const sClassName: TRegFormClass; Const sKeyword: String);
  public
    destructor Destroy; override;
    procedure RegisterMe(Const sClassName: TRegFormClass; Const sKeyword: String);
    procedure RegisterControl(Const sClassName: TRegFormClass; Const sKeyword: String);
    property Count: Integer read GetCount;
    property CreateForm[sKey: String]: TRegForm read GetForm; default;
    property Identifier: String read fsIdentifier write fsIdentifier;
    property FieldName: String read fsFieldName write fsFieldName;
  end;

var
  FormFact: TFormFactory;

implementation

Uses
  FuncLib, SysUtils, StrUtils,FastFuncs;

constructor TFormFactory.Create;
begin
  inherited;
  lstFormList := TList.Create;
  lstKeyName := TStringList.Create;
end;

destructor TFormFactory.Destroy;
begin
  lstFormList.Free;
  lstKeyName.free;
  inherited;
end;

function TFormFactory.GetCount: Integer;
begin
  Result := lstFormList.Count;
end;

function TFormFactory.GetForm(sKey: String): TRegForm;
Var
  iIndex: Integer;
  sWorkKey: String;
  iDelim: Integer;
begin
  result := nil;
  {Try searching on the column name first}
  iIndex := lstKeyName.IndexOfName(sKey);

  {Try a search with subsequent id as '*' if not found}
  if iIndex = -1 then begin
    iDelim := LastDelimiter('_', sKey);
    sWorkKey := Copy(sKey, 1, iDelim-1);

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

  {Try a subsequent search on '*' if not found}
  if iIndex = -1 then begin
    // replace last occurrence of field name with *
    sKey := FastFuncs.AnsiStringReplace(sKey, fsFieldName, '*', [rfReplaceAll]);
    iIndex := lstKeyName.IndexOfName(sKey);
  end;

  fsIdentifier := StripQuotes(lstKeyName.Values[sKey]);
  if iIndex <> -1 then begin
   try
    result := TRegFormClass(lstFormList[iIndex]).Instance;
   except
   end;
  end;
end;

procedure TFormFactory.RegisterSomething(Const sClassName: TRegFormClass; Const sKeyword: String);
begin
  try
    lstFormList.Add(sClassName);
    lstKeyName.Add(sKeyword);
  except
    raise Exception.Create('Error whilst Attempting to store keyword in FormFactory');
  end;
end;

procedure TFormFactory.RegisterMe(Const sClassName: TRegFormClass; Const sKeyword: String);
begin
  RegisterSomething(sClassName, sKeyword);
end;

procedure TFormFactory.RegisterControl(Const sClassName: TRegFormClass; Const sKeyword: String);
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

initialization
  TFormFactory.Instance;

finalization
  if FormFact <> nil then begin
    FormFact.Free;
    FormFact := nil;
  end;

end.

