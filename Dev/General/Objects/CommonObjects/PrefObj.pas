////////////////////////////////////////////////////////////////////////////////
  // 2 Clix Software Library                                                    //
  ////////////////////////////////////////////////////////////////////////////////
unit PrefObj;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 26/06/05  1.00.00 DMS  Initial version.
  // 04/07/05  1.00.01 DMS  Added GetPrefCountByGroup function.
  // 05/07/05  1.00.02 DMS  Added FieldTypeToPrefType function. Declared types 
  //                        moved to tcTypes unit.
  // 06/07/05  1.00.03 IJB  Removed XMLData type pref and added AsTree, changed
  //                        PrefType to read only and changed so this is
  //                        information only and not required/stored with pref.
  // 09/08/05  1.00.04 IJB  Removed AsTree.

interface

uses
  SysUtils, Classes, Variants, MyAccess,ERPdbComponents, DB, tcTypes;

type
  { TPrefItem }
  TPrefItem = class(TCollectionItem)
  private
    FUserID: integer;
    FComponent: TComponent;
    FPackageID: integer;  // ID of package
    FPrefDesc: string;    // description of preference
    FPrefGroup: string;   // name of preference group
    FPrefName: string;    // name of preference
    FValue: Variant;
    FIndustryId: integer;
    function GetAsBoolean: boolean;
    function GetAsFloat: double;
    function GetAsInteger: integer;
    function GetAsString: string;
    function GetAsVariant: Variant;
    procedure SetAsBoolean(const Value: boolean);
    procedure SetAsFloat(const Value: double);
    procedure SetAsInteger(const Value: integer);
    procedure SetAsString(const Value: string);
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(const Value: TDateTime);
    function GetPrefType: TVarType;
  public
    function IsGUIActive: boolean;
    procedure SetValue(const AValue: Variant);
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsInteger: integer read GetAsInteger write SetAsInteger;
    property AsString: string read GetAsString write SetAsString;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsVariant: Variant read GetAsVariant;
    property UserID: integer read FUserID write FUserID;
    property Component: TComponent read FComponent write FComponent;
    property PackageID: integer read FPackageID write FPackageID;
    property PrefDesc: string read FPrefDesc write FPrefDesc;
    property PrefGroup: string read FPrefGroup write FPrefGroup;
    property PrefName: string read FPrefName write FPrefName;
    property PrefType: TVarType read GetPrefType;
    property IndustryId : integer read FIndustryId write FIndustryId;
  end;

  { TPrefCollection }
  TPrefCollection = class(TCollection)
  private
    FGUIActive: boolean;
    FDefaultPackageId: integer;
    FDefaultUserID: integer;
    FDefaultPrefGroup: string;
    FIndustryId : integer;
    function GetCountByGroup(Const AGroupName: string): integer;
    function GetCountByPackageID(Const APackageID: integer): integer;
    function GetCountByUserID(Const AUserID: integer): integer;
    function GetItems(Const Index: integer): TPrefItem;
    function GetPrefByName(Const PrefName: string): TPrefItem;
    function StrIsDigit(Const S: string): boolean;
    function StrIsUpperCase(Const S: string): boolean;
    procedure SetItems(Const Index: integer; const Value: TPrefItem);
    procedure SetPrefByName(Const PrefName: string; const Value: TPrefItem);
  public
    constructor Create; overload;
    constructor Create(const APackageID, AUserID: integer; const APrefGroup: string; const AIndustryId : integer = 0); overload;
    destructor Destroy; override;
    function Add: TPrefItem; overload;
    function Add(const APrefName: string): TPrefItem; overload;
    function AddPreference(Const APrefRec: TPrefRec; const Overwrite: boolean = false): boolean;
    function DeletePrefs(const APackageID, AUserID: integer): integer;
    function DeletePrefsByUserID(const AUserID: integer): integer;
    function DeletePrefsByGroup(const AGroupName: string): integer;
    function DeletePrefsByPackageID(const APackageID: integer): integer;
    function PreferenceExists(const APackageID, AUserID: integer; const APrefGroup, APrefName: string): boolean; overload;
    function PreferenceExists(const APrefName: string): boolean; overload;
    procedure SetupGUI;
    procedure UpdateComponentLink(Sender: TObject; const APrefName: string = '');
    procedure UpdatePrefItem(Sender: TObject);
    property CountByUserID[Const AUserID: integer]: integer read GetCountByUserID;
    property CountByGroup[Const AGroupName: string]: integer read GetCountByGroup;
    property CountByPackageID[Const APackageID: integer]: integer read GetCountByPackageID;
    property GUIActive: boolean read FGUIActive write FGUIActive;
    property Items[Const Index: integer]: TPrefItem read GetItems write SetItems;
    property PrefByName[Const PrefName: string]: TPrefItem read GetPrefByName write SetPrefByName; default;
    procedure Save;
    procedure Load;
    Class function AddAction(aPagename, aActionname , APrefGroup:String):Boolean;
  end;

  { TPrefHelper }
  TPrefHelper = class
  private
    FPrefCol: TPrefCollection;
    FQuery: TERPQuery;
  public
    constructor Create(APrefCol: TPrefCollection);
    destructor Destroy; override;
    property PrefCol: TPrefCollection read FPrefCol write FPrefCol;
    property Query: TERPQuery read FQuery write FQuery;
  end;

  { TPrefReader }
  TPrefReader = class(TPrefHelper)
  private
    procedure InitQuery;
  public
    constructor Create(APrefCol: TPrefCollection);
    function LoadPreferences(const PackageID: integer = 0; const UserID: integer = 0;
      const PrefGroup: string = ''; const AIndustryId : integer = 0): boolean;
  end;

  { TPrefWriter }
  TPrefWriter = class(TPrefHelper)
  private
  public
    constructor Create(APrefCol: TPrefCollection);
    procedure Save;
  end;

  {

  Example of adding preference item to the collection:

  procedure AddPreferenceItem(var PC: TPrefCollection);
  var
    PI: TPrefItem;
  begin
    PI := PC.Add;
    // now set TPrefItem properties
    ...
    ...
    // and you are done
  end;

  }

function GetPrefCountByGroup(const APrefGroup: string; const PackageID, UserID: integer): integer;
function PrefItemToRec(const APrefItem: TPrefItem): TPrefRec;
  //function PrefValueToDateTime(var PrefValue: string; const DateFormat: string): TDateTime;

implementation

uses FastFuncs,StdCtrls, ExtCtrls, tcConst, CommonDbLib, BusObjPreference, BusObjBase,
  AppEnvironment;


function GetPrefCountByGroup(const APrefGroup: string; const PackageID, UserID: integer): integer;
var
  Prefs: TPrefCollection;
begin
  Prefs := TPrefCollection.Create(0, 0, APrefGroup);
  try
    Result := Prefs.Count;
  finally
    FreeAndNil(Prefs);
  end;
end;

function PrefItemToRec(const APrefItem: TPrefItem): TPrefRec;
begin
  Result.PackageID := APrefItem.PackageID;
  Result.UserID := APrefItem.UserID;
  Result.PrefGroup := APrefItem.PrefGroup;
  Result.PrefName := APrefItem.PrefName;
  Result.PrefDesc := APrefItem.PrefDesc;
  Result.Value := APrefItem.AsVariant;
end;

{ TPrefCollection }

constructor TPrefCollection.Create;
begin
  inherited Create(TPrefItem);
  FDefaultPackageId := 0;
  FDefaultUserID := 0;
  FDefaultPrefGroup := PREF_GROUP_GENERAL;
  FGUIActive := false; // needs to be set in the code
end;

constructor TPrefCollection.Create(const APackageID, AUserID: integer; const APrefGroup: string; const AIndustryId : integer = 0);
begin
  inherited Create(TPrefItem);
  FGUIActive := false; // needs to be set in the code
  FDefaultPackageId := APackageID;
  FDefaultUserID := AUserID;
  FDefaultPrefGroup := APrefGroup;
  if AIndustryId = 0 then
    FIndustryId := AppEnv.CompanyInfo.IndustryId
  else
    FIndustryId := AIndustryId;
  Load;
end;

procedure TPrefCollection.Load;
var
  Reader: TPrefReader;
begin
  if (FDefaultPrefGroup <> '') then begin
    self.Clear;
    Reader := TPrefReader.Create(self);
    try
      Reader.LoadPreferences(FDefaultPackageID, FDefaultUserID, FDefaultPrefGroup);
    finally
      FreeAndNil(Reader);
    end;
  end;  
end;

destructor TPrefCollection.Destroy;
begin
  inherited;
end;

function TPrefCollection.Add: TPrefItem;
begin
  Result := TPrefItem(inherited Add);
  Result.PackageID := FDefaultPackageID;
  Result.UserID := FDefaultUserID;
  Result.PrefGroup := FDefaultPrefGroup;
  Result.IndustryId := AppEnv.CompanyInfo.IndustryId;
end;

function TPrefCollection.Add(const APrefName: string): TPrefItem;
begin
  Result := Self.Add;
  Result.PrefName := APrefName;
end;

class function TPrefCollection.AddAction(aPagename, aActionname , APrefGroup:String):Boolean;
var
  Prefs : TPrefCollection;
  I, ii:Integer;
  List : TStringList;
  s:String;
begin
  Result := False;
  Prefs := TPrefCollection.Create(0, AppEnv.Employee.EmployeeID, APrefGroup);
    if Prefs.Count > 0 then begin
      for I := 0 to Prefs.Count - 1 do begin
        if Prefs.Items[I].PrefName = PREF_NAME_MAIN_SWITCH_MENU then begin
          List := TStringList.Create;
          try
            List.Text := Prefs.Items[I].AsString;
            if List.Count > 0 then begin
              if List.IndexOfName(aPagename) >= 0 then begin
                ii := List.IndexOfName(aPagename);
                s:= List[ii];
                if (POS(uppercase(aActionname)+',' , uppercase(s)) >0) or
                   (POS(uppercase(','+aActionname) , uppercase(s)) >0) then begin
                    REsult := True;
                    break;
                end else begin
                    s:= s+','+aActionname;
                    List[ii] := s;
                    Prefs.Items[I].AsString:= List.Text;
                    Prefs.Save;
                    Result := True;
                    break;
                end;
              end else begin
                s:= aPagename +'='+aActionname;
                List.add(s);
                Prefs.Items[I].AsString:= List.Text;
                Prefs.Save;
                Result := True;
                break;
              end;
            end;
          finally
            Freeandnil(List);
          end;
          break;
        end;
      end;
    end;


end;

function TPrefCollection.AddPreference(Const APrefRec: TPrefRec; const Overwrite: boolean): boolean;
var
  Pref: TPrefItem;
  I: integer;
  MatchFound: boolean;
begin
  Result := false;
  // first find out if the preference already exists
  if Self.Count > 0 then begin
    MatchFound := false;
    for I := 0 to Self.Count - 1 do begin
      Pref := Items[I];

      if (Pref.PrefGroup = APrefRec.PrefGroup) and
        (Pref.PrefName = APrefRec.PrefName) and   // does the name matches?
        (Pref.PackageID = APrefRec.PackageID) and // is it same package?
        (Pref.UserID = APrefRec.UserID) then      // is the client same?
      begin
        MatchFound := true;
        if Overwrite then begin
          // overwrite the preferences properties
          Pref.PrefDesc := APrefRec.PrefDesc;
          Pref.SetValue(APrefRec.Value);
          Result := true;
          Break;
        end else begin
          Result := false; // preference was not added
          Break;
        end;
      end;
    end;

    if not MatchFound then begin
      // add preference to the collection
      Pref := Self.Add;
      Pref.PackageID := APrefRec.PackageID;
      Pref.UserID := APrefRec.UserID;
      Pref.PrefGroup := APrefRec.PrefGroup;
      Pref.PrefName := APrefRec.PrefName;
      Pref.PrefDesc := APrefRec.PrefDesc;
      Pref.SetValue(APrefRec.Value);
      Result := true;
    end;
  end;
end;

function TPrefCollection.DeletePrefs(const APackageID, AUserID: integer): integer;
var
  I: integer;
begin
  Result := 0;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if (Items[I].PackageID = APackageID) and
        (Items[I].UserID = AUserID) then begin
        Self.Delete(I);
        Inc(Result);
      end;
end;

function TPrefCollection.DeletePrefsByUserID(const AUserID: integer): integer;
var
  I: integer;
begin
  Result := 0;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if (Items[I].UserID = AUserID) then begin
        Self.Delete(I);
        Inc(Result);
      end;
end;

function TPrefCollection.DeletePrefsByGroup(const AGroupName: string): integer;
var
  I: integer;
begin
  Result := 0;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Sysutils.SameText(Items[I].PrefGroup, AGroupName) then begin
        Self.Delete(I);
        Inc(Result);
      end;
end;

function TPrefCollection.DeletePrefsByPackageID(const APackageID: integer): integer;
var
  I: integer;
begin
  Result := 0;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Items[I].PackageID = APackageID then begin
        Self.Delete(I);
        Inc(Result);
      end;
end;

function TPrefCollection.GetCountByUserID(Const AUserID: integer): integer;
var
  I: integer;
begin
  Result := 0;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if (Items[I].UserID = AUserID) then Inc(Result);
end;

function TPrefCollection.GetCountByGroup(Const AGroupName: string): integer;
var
  I: integer;
begin
  Result := 0;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Sysutils.SameText(Items[I].PrefGroup, AGroupName) then Inc(Result);
end;

function TPrefCollection.GetCountByPackageID(Const APackageID: integer): integer;
var
  I: integer;
begin
  Result := 0;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if (Items[I].PackageID = APackageID) then Inc(Result);
end;

function TPrefCollection.GetItems(Const Index: integer): TPrefItem;
begin
  Result := TPrefItem(inherited Items[Index]);
end;

function TPrefCollection.GetPrefByName(Const PrefName: string): TPrefItem;
var
  I: integer;
begin
  Result := nil;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Items[I].PrefName = PrefName then begin
        Result := Items[I];
        Break;
      end;
end;

function TPrefCollection.PreferenceExists(const APackageID, AUserID: integer; const APrefGroup, APrefName: string): boolean;
var
  I: integer;
  Pref: TPrefItem;
begin
  Result := false;
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do begin
      Pref := Items[I];
      if (Pref.PackageID = APackageID) and
        (Pref.UserID = AUserID) and
        (Pref.PrefName = APrefName) then begin
        Result := true;
        Break;
      end;
    end;
end;

function TPrefCollection.PreferenceExists(const APrefName: string): boolean;
begin
  Result := PreferenceExists(FDefaultPackageID, FDefaultUserID, FDefaultPrefGroup, APrefName);
end;


procedure TPrefCollection.SetItems(Const Index: integer; const Value: TPrefItem);
begin
  TPrefItem(inherited Items[Index]).Assign(Value);
end;

procedure TPrefCollection.SetPrefByName(Const PrefName: string; const Value: TPrefItem);
var
  I: integer;
begin
  if Self.Count > 0 then begin
    for I := 0 to Self.Count - 1 do if Items[I].PrefName = PrefName then begin
        Items[I] := Value;
        Break;
      end;
  end;
end;

procedure TPrefCollection.SetupGUI;
var
  I, J: integer;
  Component: TComponent;
  ComboBox: TComboBox;
begin
  // set the component state/data based on the preference
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do if Assigned(Items[I].Component) then begin
        Component := Items[I].Component;
        // CheckBox
        if Component is TCheckBox then TCheckBox(Component).Checked := Items[I].AsBoolean
            // Edit
        else if Component is TEdit then TEdit(Component).Text := Items[I].AsString
            // RadioGroup
        else if Component is TRadioGroup then TRadioGroup(Component).ItemIndex := Items[I].AsInteger
            // ComboBox
        else if Component is TComboBox then begin
          ComboBox := TComboBox(Component);
          if ComboBox.Items.Count > 0 then for J := 0 to ComboBox.Items.Count - 1 do
              if ComboBox.Items[J] = Items[I].AsString then begin
                ComboBox.ItemIndex := J;
                Break;
              end;
        end;
      end;
end;

function TPrefCollection.StrIsDigit(Const S: string): boolean;
begin
  Result := CharInSet(S[1],['0'..'9']);
end;

function TPrefCollection.StrIsUpperCase(Const S: string): boolean;
begin
  Result := (S = uppercase(S));
end;

procedure TPrefCollection.UpdateComponentLink(Sender: TObject; const APrefName: string);
var
  I, J: integer;
  CompName, Part, PrefName: string;
  Portions: TStrings;
  MatchFound: boolean;
begin
  if Self.Count > 0 then begin
    MatchFound := false;

    for I := 0 to Self.Count - 1 do begin
      if APrefName <> '' then // preference name specified
      begin
        if Items[I].PrefName = APrefName then begin
          Items[I].Component := TComponent(Sender);
          MatchFound := true;
        end;
      end else begin
        // decode the component name into a preference name
        CompName := TComponent(Sender).Name;

        Portions := TStringList.Create;
        try
          Part := '';
          for J := 1 to Length(CompName) do begin
            if StrIsUpperCase(CompName[J]) then begin
              if StrIsDigit(CompName[J]) then Part := Part + CompName[J]
              else begin
                if Part <> '' then begin
                  Portions.Add(Part);
                  Part := '';
                end else Part := CompName[J];
              end;
            end else begin
              if Part <> '' then Part := Part + CompName[J];
            end;
          end;

          PrefName := '';
          if Portions.Count = 0 then PrefName := Part
          else for J := 0 to Portions.Count - 1 do begin
              if PrefName = '' then PrefName := Portions[J]
              else PrefName := PrefName + '.' + Portions[J];
            end;

          if PrefName <> '' then if Items[I].PrefName = PrefName then begin
              Items[I].Component := TComponent(Sender);
              MatchFound := true;
            end;
        finally
          FreeAndNil(Portions);
        end;
      end;
    end;

    if not MatchFound then raise Exception.Create('Component does not have corresponding preference assigned');
  end else raise Exception.Create('No preferences loaded');
end;

procedure TPrefCollection.UpdatePrefItem(Sender: TObject);
var
  I: integer;
  Component: TComponent;
  ComboBox: TComboBox;
begin
  // update preference item from the control
  if Self.Count > 0 then for I := 0 to Self.Count - 1 do begin
      if Items[I].Component.Name = TComponent(Sender).Name then begin
        Component := Items[I].Component;
        // 1. read the component value
        // 2. set the preference


        // CheckBox
        if Component is TCheckBox then Items[I].AsBoolean := TCheckBox(Component).Checked
            // Edit
        else if Component is TEdit then Items[I].AsInteger := StrToIntDef(TEdit(Component).Text, 0)
            // RadioGroup
        else if Component is TRadioGroup then Items[I].AsInteger := TRadioGroup(Component).ItemIndex
            // ComboBox
        else if Component is TComboBox then begin
          ComboBox := TComboBox(Component);
          Items[I].AsString := ComboBox.Items[ComboBox.ItemIndex];
        end;
      end;
    end;
end;

procedure TPrefCollection.Save;
var
  Writer: TPrefWriter;
begin
  Writer := TPrefWriter.Create(Self);
  try
    Writer.Save;
  finally
    FreeAndNil(Writer);
  end;
end;

{ TPrefItem }

function TPrefItem.GetAsBoolean: boolean;
var
  S: string;
begin
  S := GetAsString;
  Result := (Length(S) > 0) and CharInSet(S[1],['T', 't', 'Y', 'y']);
end;

function TPrefItem.GetAsFloat: double;
begin
  Result := StrToFloat(GetAsString);
end;

function TPrefItem.GetAsInteger: integer;
begin
  Result := FastFuncs.StrToInt(GetAsString);
end;

function TPrefItem.GetAsString: string;
begin
  try
    Result := string(FValue);
  except
    Result := EmptyStr;
  end;
end;

function TPrefItem.GetAsVariant: Variant;
begin
  Result := FValue;
end;

function TPrefItem.IsGUIActive: boolean;
begin
  Result := (Collection as TPrefCollection).GUIActive;
end;

procedure TPrefItem.SetAsBoolean(const Value: boolean);
const
  Values: array[boolean] of string[1] = ('F', 'T');
begin
  SetAsString(string(Values[Value]));
end;

procedure TPrefItem.SetAsFloat(const Value: double);
begin
  SetAsString(FloatToStr(Value));
end;

procedure TPrefItem.SetAsInteger(const Value: integer);
begin
  FValue := Value;
end;

procedure TPrefItem.SetAsString(const Value: string);
begin
  FValue := Value;
end;

procedure TPrefItem.SetValue(const AValue: Variant);
begin
  FValue := AValue;
end;

function TPrefItem.GetAsDateTime: TDateTime;
begin
  Result := FValue;
end;

procedure TPrefItem.SetAsDateTime(const Value: TDateTime);
begin
  FValue := Value;
end;

function TPrefItem.GetPrefType: TVarType;
begin
  Result := VarType(FValue);
end;

{ TPrefReader }

constructor TPrefReader.Create(APrefCol: TPrefCollection);
begin
  inherited Create(APrefCol);
  InitQuery;
end;

procedure TPrefReader.InitQuery;
begin
  Query.SQL.Add('SELECT * FROM tblPreferences ');
  Query.SQL.Add('WHERE PackageID = :PackageID AND UserID = :UserID AND PrefGroup = :PrefGroup and IndustryId=:IndustryId');
end;

function TPrefReader.LoadPreferences(const PackageID, UserID: integer; const PrefGroup: string; const AIndustryId : integer): boolean;
var
  Pref: TPrefItem;
begin
  try
    Query.ParamByName('PackageID').AsInteger := PackageID;
    Query.ParamByName('UserID').AsInteger    := UserID;
    Query.ParamByName('PrefGroup').AsString  := PrefGroup;
    if AIndustryId=0 then
      Query.ParamByName('IndustryId').AsInteger := AppEnv.CompanyInfo.IndustryId
    else
      Query.ParamByName('IndustryId').AsInteger := AIndustryId;
    Query.Open;
    Result := not Query.IsEmpty;
    if Result then while not Query.Eof do begin
        // possibly call delete first
        Pref := PrefCol.Add;
        Pref.PackageID := PackageID;
        Pref.UserID := UserID;
        Pref.PrefName := Query.FieldByName('PrefName').AsString;
        Pref.PrefDesc := Query.FieldByName('PrefDesc').AsString;
        Pref.SetValue(Query.FieldByName('PrefValue').AsVariant);
        Pref.IndustryId := Query.FieldByName('IndustryId').AsInteger;

        Query.Next;
      end;
  finally
    Query.Close;
  end;
end;

{ TPrefHelper }

constructor TPrefHelper.Create(APrefCol: TPrefCollection);
begin
  inherited Create;
  FPrefCol := APrefCol;
  FQuery := TERPQuery.Create(nil);
  FQuery.Options.FlatBuffers := True;
  FQuery.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

destructor TPrefHelper.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

{ TPrefWriter }

constructor TPrefWriter.Create(APrefCol: TPrefCollection);
begin
  inherited Create(APrefCol);
end;

procedure TPrefWriter.Save;
var
  I: integer;
  PrefObj: TPreference;
  Pref: TPrefItem;
begin
  if PrefCol.Count > 0 then begin
    PrefObj:= TPreference.Create(nil);
    try
      PrefObj.Connection:= TMyDacDataConnection.Create(PrefObj);
      PrefObj.Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;

      for I := 0 to PrefCol.Count - 1 do begin
        Pref:= PrefCol.Items[I];
        PrefObj.Load(Pref.UserID,Pref.PrefGroup,Pref.PrefName,'','',Pref.PackageID,true);
        PrefObj.PrefValue:= Pref.AsString;
        PrefObj.PrefDesc:= Pref.PrefDesc;
        PrefObj.IndustryId := Pref.IndustryId;
        if not PrefObj.Save then
          raise Exception.Create(PrefObj.ResultStatus.Messages);
      end;
    finally
      PrefObj.Free;
    end;
  end;
end;

end.
