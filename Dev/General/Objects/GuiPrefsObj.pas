unit GuiPrefsObj;

{

  Date     Version  Who Comment
  -------- -------- --- ---------------------------------------------------------
  10/08/05 _1.00.00 IJB Initial version.
  16/09/05  1.00.01 MV  Added constant GUI_PERF_CUSTOM_COLUMN_TAG value changed to
  two due to tag conflict in PersonalTabStop also modified
  procedures RmoveDatasetCustomFields and
  ApplyGridCustomColumnOptions to support new constant.
  19/09/05 _1.00.02 IJB Modified ApplyGridColumnOptions to hide table "Id" fields.
  20/09/05 _1.00.03 IJB Added Enabled property to TFormGuiPrefs, this can be set
  to false to prevent customisation of forms.
  01/11/05 _1.00.04 IJB Added GlobalPrefsOnly to TFormGuiPrefs and modified to
  not Save back to Global if this is true LoadPrefs
  (prefs form sets this when user is customising using
  PrefsSettingsListForm)
  03/01/06  1.00.05 DSP Added ActiveTabCaption parameter to ShowCustomiseForm.
  17/01/06  1.00.06 DSP 1. Added property HiddenFields to TFormGuiPrefs to
  prevent specified fileds from being displayed on the
  form.
  2. The field 'DisplayLabel' is now used in place of the
  'FieldName' for display on the form and is stored
  along with the other field attributes.
  18/01/06  1.00.07 DSP Added public methods AddFieldPair, IsPairedField and
  PairedField.
  09/02/06  1.00.08 DSP Moved IsPairedField, PairedField and
  HiddenFields from TFormGuiPrefs to TwwDbGridGuiElement.
  Added AddFieldPair and HideField to TFormGuiPrefs.
  17/02/06  1.00.09 DSP Added in test for Value <> fActive in the SetActive
  methods of TGuiElement and TwwDbGridGuiElement. Also
  changed AddIfNotFound to a function to resolve a
  problem with the dataset's AfterOpen event being
  overwritten.
  10/04/06  1.00.10 DSP Added test for paired fields in GetColumnSettings.
  04/05/06  1.00.11 DSP Removed 'fmFormGuiPrefsEdit.Free' from ShowCustomiseForm
  as it frees itself on close.
  13/09/06  1.00.12 DSP Removed DataSet.Update from ApplyGridCustomColumnOptions
  as it doesn't appear to be required and is causing
  errors with data-sets with parameters.

}

interface

uses
  Classes, DataTreeObj, wwDbGrid, DB, Contnrs, forms, ParserObj, Graphics,
  GridFieldsObj,MessageInterface, AdvGrid;

type
  TSelectedEntryPropertytype = (septDisplayWidth,septDisplayLabel,septbReadOnly,septGroupName, septVisible);

  PEventHookRec = ^TEventHookRec;

  TEventHookRec = record
    ObjectName, EventName: string;
    ObjectMethod: TMethod;
  end;

  TFieldPair = record
    FieldName1: string;
    FieldName2: string;
  end;

  TLinkedFields = record
    Mainfield: string;
    groupname: string;
    Linkedfields: array of string;
  end;

  PFieldPair = ^TFieldPair;
  PLinkedFields = ^TLinkedFields;

  TEventHookList = class(TObject)
  private
    fList: TList;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function Find(const aObjectName, aEventName: string): PEventHookRec;
    procedure Add(const aObjectName, aEventName: string; const aObjectMethod: TMethod);
    function AddIfNotFound(const aObjectName, aEventName: string; const aObjectMethod: TMethod): boolean;
    function GetMethod(const aObjectName, aEventName: string): TMethod;
  end;

  TPrefUserType = (puGlobal, puUser);

  TFormGuiPrefs = class;
  TGuiElementList = class;

  TGuiElement = class(TComponent)
  private
    fTargetName: string;
    fTarget: TComponent;
    fElementList: TGuiElementList;
    fEventHookList: TEventHookList;
    fPrefFrameClassName: string;
    fActive: boolean;
    fDescription: string;
    fElementPagehint: string;
    fFirstActivate: boolean;
    function GetNode: TDataTreeNode;
    function GetPrefFrameClassName: string;
    function GetTarget: TComponent;
    function GetTargetComponentName: string;
    // procedure SetTarget(const Value: TComponent);
    procedure SetTargetComponentName(const Value: string);
    function GetFormGuiPrefs: TFormGuiPrefs;
  protected
    property EventHookList: TEventHookList read fEventHookList;
    procedure SetActive(const Value: boolean); virtual;
    procedure FirstActivate; virtual;
    procedure SetTarget(const Value: TComponent);virtual; { rob }
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Active: boolean read fActive write SetActive;
    // The name of the target component that this element will customise.
    property TargetName: string read GetTargetComponentName write SetTargetComponentName;
    // The target component that this element will customise.
    property Target: TComponent read GetTarget write SetTarget;
    // User friendly name for the component being customised
    property Description: string read fDescription write fDescription;
    property ElementPagehint: string read fElementPagehint write fElementPagehint;
    // The list that this element belongs to
    property ElementList: TGuiElementList read fElementList write fElementList;
    // Frame for user to change GUI settings for this Element
    property PrefFrameClassName: string read GetPrefFrameClassName;
    // Node for this elements customisation GUI data.
    property Node: TDataTreeNode read GetNode; // write SetNode;
    // Apply GUI customisation to this elements target component.
    procedure ApplyGuiPrefs; virtual;
    // Save the targets settings back to node data structure
    procedure SaveGuiPrefs; virtual;
    property FormGuiPrefs: TFormGuiPrefs read GetFormGuiPrefs;
    // This will be called if no GuiPrefs are found in the database for
    // current user and this procedure should set any required Gui defaults.
    procedure SetGuiDefaults; virtual;
    // This will becalled before saving data to DB
    procedure BeforeSave; virtual;
  end;

  TGuiElementClass = class of TGuiElement;

  TGuiElementList = class(TComponent)
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItems(const index: integer): TGuiElement;
    function GetItemByClassName(const aGuiElementClassName: string): TGuiElement;
    function GetItemByTarget(const aTarget: TComponent): TGuiElement;
  protected
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddElement(aGuiElement: TGuiElement);
    function Add(const aGuiElementClassName: string): TGuiElement; overload;
    function Add(const aGuiElementClassName: string; aTarget: TComponent): TGuiElement; overload;
    procedure Remove(index: integer);
    property Count: integer read GetCount;
    property Items[const index: integer]: TGuiElement read GetItems; default;
    property ItemByClassName[const aGuiElementClassName: string]: TGuiElement read GetItemByClassName;
    property ItemByTarget[const aTarget: TComponent]: TGuiElement read GetItemByTarget;
  end;

  TwwDbGridGuiElement = class;

  TFormGuiPrefs = class(TComponent)
  private
    fElements: TGuiElementList;
    fPrefsName: string;
    fNode: TDataTreeNode;
    fGlobalNode: TDataTreeNode;
    fPackageId: integer;
    fUserType: TPrefUserType;
    fUserPrefsOnly: boolean;
    fGlobalPrefsOnly: boolean;
    fEnabled: boolean;
    fActive: boolean;
    fInitialiseHidden: boolean;
    fMsgHandler: TMsgHandler;
    fResetAllToGlobal: boolean;
    fOnActive: TNotifyEvent;
    function GetNode: TDataTreeNode;
    function GetPrefsName: string;
    procedure SetPrefsName(const Value: string);
    function GetDirty: boolean;

    function GetUserType: TPrefUserType;
    procedure SetUserType(const Value: TPrefUserType);
    procedure SetActive(const Value: boolean);
    function GetForm: TForm;
    function getFCEnabled: boolean;
    procedure SetEnabled(const Value: boolean);
    function GetDbGridElement(const aTarget: TComponent): TwwDbGridGuiElement;
    function GetGlobalNode: TDataTreeNode;
    procedure SaveElementsGuiPrefs;
    procedure SetDirty(const Value: boolean);
    procedure BeforeSave;
  protected
  public

    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    // Load node with current users prefs from database for this forms PrefName
    function LoadPrefs: boolean;
    procedure RevertToGlobalPrefs;
    // Save currently loaded prefs node XML back to database for current user
    procedure SavePrefs;
    procedure SaveGlobalNode;
    procedure Savecurrencysetup;
    // Apply GUI customisation to all elements in list.
    procedure ApplyGuiPrefs; // virtual;
    procedure ShowCustomiseForm(const ActiveTabCaption: string = '');
    procedure AddreadonlyField(const FieldName: string; const aDataSet: TDataSet);
    procedure AddFieldPair(const FieldName1, FieldName2: string; const aDataSet: TDataSet);
    procedure AddLinkedFields(const fsMainfieldName: string; const fsgroupname: string; const fsLinkedfields: array of string; const aDataSet: TDataSet);
    procedure clearLinkedfields(const aDataSet: TDataSet);
    property Enabled: boolean read fEnabled write SetEnabled;
    property Active: boolean read fActive write SetActive;
    property UserType: TPrefUserType read GetUserType write SetUserType;
    property PackageId: integer read fPackageId write fPackageId;
    // List of customisable elements for this form.
    property Elements: TGuiElementList read fElements;
    // return a wwdbgrid element for given target
    property DbGridElement[const aTarget: TComponent]: TwwDbGridGuiElement read GetDbGridElement;
    // Database identifier name.
    property PrefsName: string read GetPrefsName write SetPrefsName;
    // Root node for form customisation GUI data.
    property Node: TDataTreeNode read GetNode; // write SetNode;
    property GlobalNode: TDataTreeNode read GetGlobalNode;
    property Dirty: boolean read GetDirty write SetDirty;
    property UserPrefsOnly: boolean read fUserPrefsOnly write fUserPrefsOnly;
    property GlobalPrefsOnly: boolean read fGlobalPrefsOnly write fGlobalPrefsOnly;
    property InitialiseHidden: boolean read fInitialiseHidden;
    property Form: TForm read GetForm;
    property FCEnabled: boolean read getFCEnabled;
    Procedure SwapPairdfield(hidingfield, showingfield: String);
    procedure AddFieldstogether(Field1, field2: String);
    Procedure DoTranslate;
    property ResetAllToGlobal: boolean read fResetAllToGlobal write fResetAllToGlobal;
    Property OnActive :TNotifyEvent read fOnActive write fOnActive;
  end;

  TReportonForeignCurrency = class(TGuiElement)
  private
  public
    constructor Create(aOwner: TComponent); override;
  end;

  TwwDbGridGuiElement = class(TGuiElement)
  private
    fHiddenFields: TStrings;
    fRemovedFields: TStrings;
    fMandatoryFields :TStrings;
    fFieldPairs: TList;
    fLinkedFields: TList;
    fReadonlyFields: TStringList;
    Parser: TMathParser;
    fDataset: TDataSet;
    fCustomColumns: TDataTreeNode;
    CleanselectedList: TGridFieldList;
    procedure DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var Found: boolean);
    procedure DoOnCalcFields(Dataset: TDataSet);
    procedure DoOnColumnMoved(Sender: TObject; FromIndex, ToIndex: integer);
    procedure DoOnColWidthChanged(Sender: TObject; Column: integer);
    procedure DoOnTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure DoBeforeOpen(Dataset: TDataSet);
    procedure DoAfterOpen(Dataset: TDataSet);
    procedure RemoveDatasetCustomFields;
    procedure ApplyGridColumnOptions(RemoveIfNotFound: boolean = false);
    procedure ApplyGridCustomColumnOptions;
    procedure ApplyGeneralGridOptions;
    function GetCustomColumns: TDataTreeNode;
    function GetDataset: TDataSet;
    function GetGrid: TwwDbGrid;
    procedure setFieldGroupname(fsfieldname: string; const Value: string);
    procedure setFieldDisplayLabel(fsfieldname: string; const Value: string);
    function GetFieldGroupname(fsfieldname: string):String;
    function GetFieldDisplayLabel(fsfieldname: string):String;
    procedure RestfieldProperties(selectedList: TGridFieldList;AFieldName: String;CleanVisible:Boolean=True);
    procedure setFieldProperty(fsfieldname: string; const Value: string;
      PropertyPosition: Integer);
    function GetFieldProperty(fsfieldname: string;
      PropertyPosition: Integer): String;
  protected
    procedure SetActive(const Value: boolean); override;
    property CustomColumns: TDataTreeNode read GetCustomColumns;
    property Grid: TwwDbGrid read GetGrid;
    property Dataset: TDataSet read GetDataset;
    procedure SetTarget(const Value: TComponent);override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveGuiPrefs; override;
    procedure ApplyGuiPrefs; override;
    procedure GetColumnSettings(IgnoreReadOnly: boolean = false);
    procedure GetGridOptions;
    procedure AddFieldPair(const FieldName1, FieldName2: string);
    procedure AddreadonlyField(const FieldName: string);
    procedure AddLinkedFields(const fsMainfieldName: string; const fsgroupname: string; const fsLinkedfields: array of string);
    procedure clearLinkedfields;
    function DatasetHasPersistantFields: boolean;
    function IsPairedField(const Value: string): boolean;
    function IsLinkedfield(const Value: string; var mainfieldName: string; var groupname: string): boolean;
    function PairedField(const Value: string): string;
    function getLinkedFields(const Value: string): PLinkedFields;
    function IsLinkedMain(const Value: string; var fsgroupname: string): boolean;
    property HiddenFields: TStrings read fHiddenFields;
    property RemovedFields: TStrings read fRemovedFields;
    Property MandatoryFields :Tstrings read fMandatoryFields;
    procedure HideField(const AFieldName: string);
    procedure HideFields(const aFieldList: string);
    procedure UnHideField(const AFieldName: string);
    procedure UnHideFields(const aFieldList: string);
    function FieldHidden(const AFieldName: string): boolean;

    function GetSelectedFields : TStringList;

    procedure AddField(const AFieldName: string);
    procedure RemoveField(const AFieldName: string);

    Function IsMandatoryField(const AFieldName: string):Boolean;
    Procedure AddMandatoryField(const AFieldName: string);
    procedure RemoveFields(const aFieldList: string);
    procedure AddFields(const aFieldList: string;fieldIndex :Integer=-1);
    procedure SwitchFields(showFieldName, hideFieldName: string);
    property FieldGroupname[fsfieldname: string]: string read GetFieldGroupname write setFieldGroupname;
    property FieldDisplayLabel[fsfieldname: string]: string read GetFieldDisplayLabel write setFieldDisplayLabel;
    procedure UpdateGridSelected(const NewSelectedText: string);
    function SelectedEntryProperty(const NewSelectedText, sfieldname: String;SelectedEntryPropertytype: TSelectedEntryPropertytype): Variant;overload;
    function SelectedEntryProperty(const  sfieldname: String;SelectedEntryPropertytype: TSelectedEntryPropertytype): Variant;overload;
    Procedure SwapPairdfield(hidingfield,showingfield:String);
    procedure AddFieldstogether(Field1, field2: String);
    Procedure DoTranslate;
    procedure ReplaceGroupname(const aName, aGroup, aDisplaylabel: string);
  end;

  TAdvStringGridGuiElement = class(TGuiElement)
  private
    DoingApplyGridColumnOptions: boolean;
    procedure ApplyGridColumnOptions;
    function GetGrid: TAdvStringGrid;
    procedure DoColumnSizing(Sender: TObject; ACol, ColumnSize: Integer);
    procedure DoColumnSize(Sender: TObject; ACol: Integer; var Allow: Boolean);
  protected
    procedure SetActive(const Value: boolean); override;
    property Grid: TAdvStringGrid read GetGrid;
    procedure SetTarget(const Value: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveGuiPrefs; override;
    procedure ApplyGuiPrefs; override;
    procedure GetColumnSettings;
    procedure BeforeSave; override;
  end;



  TBaseListingGuiElement = class(TGuiElement)
  private
    function GetBaseListingForm: TForm;
  protected
    procedure SetActive(const Value: boolean); override;
    procedure FirstActivate; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveGuiPrefs; override;
    procedure ApplyGuiPrefs; override;
    procedure SetGuiDefaults; override;
    property BaseListingForm: TForm read GetBaseListingForm;
  end;

  TStockAnalysisGuiElement = class(TGuiElement)
  private
    function GetBaseListingForm: TForm;
  protected
    procedure SetActive(const Value: boolean); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveGuiPrefs; override;
    procedure ApplyGuiPrefs; override;
    procedure SetGuiDefaults; override;
    property BaseListingForm: TForm read GetBaseListingForm;
  end;

procedure FontToNode(Font: TFont; Node: TDataTreeNode);
procedure NodeToFont(Node: TDataTreeNode; Font: TFont);
function Dotranslation(const Value: String): String;
Function GridnametoCaption(Const Value:String):String;


implementation

uses
  SysUtils, dialogs, Grids, Wwdbigrd, DbPrimaryKeysObj, CommonLib, tcConst,
  TypInfo, AppEnvironment, Controls, CommonDbLib, MyAccess, ERPdbComponents,
  DataTreeBaseObj,  strUtils, LanguageTranslationObj, AdvObj , StringUtils;

const
  GUI_PREF_GROUP = 'GuiPrefs';
Function GridnametoCaption(Const Value:String):String;
begin
    Result := AnsiReplaceText(Value, 'grd', '');
    Result := SeparateWords(Result) + ' Grid';
end;
procedure FontToNode(Font: TFont; Node: TDataTreeNode);

  function FontStyleToStr(Style: TFontStyles): string;
  begin
    Result := '';
    if fsBold in Style then begin
      if Result <> '' then Result := Result + ',';
      Result := Result + 'fsBold';
    end;
    if fsItalic in Style then begin
      if Result <> '' then Result := Result + ',';
      Result := Result + 'fsItalic';
    end;
    if fsUnderline in Style then begin
      if Result <> '' then Result := Result + ',';
      Result := Result + 'fsUnderline';
    end;
    if fsStrikeOut in Style then begin
      if Result <> '' then Result := Result + ',';
      Result := Result + 'fsStrikeOut';
    end;
  end;

begin
  Node['Name'].AsString := Font.Name;
  Node['Size'].AsInteger := Font.Size;
  Node['Color'].AsInteger := Font.Color;
  Node['Style'].AsString := FontStyleToStr(Font.Style);
  Node['CharSet'].AsInteger := Font.Charset;
end;

procedure NodeToFont(Node: TDataTreeNode; Font: TFont);
var
  s: string;
begin
  if Node.Exists('Name') then Font.Name := Node['Name'].AsString;
  if Node.Exists('Size') then Font.Size := Node['Size'].AsInteger;
  if Node.Exists('Color') then Font.Color := Node['Color'].AsInteger;
  if Node.Exists('Style') then begin
    s := Node['Style'].AsString;
    if Pos('fsBold', s) > 0 then Font.Style := Font.Style + [fsBold]
    else Font.Style := Font.Style - [fsBold];
    if Pos('fsItalic', s) > 0 then Font.Style := Font.Style + [fsItalic]
    else Font.Style := Font.Style - [fsItalic];
    if Pos('fsUnderline', s) > 0 then Font.Style := Font.Style + [fsUnderline]
    else Font.Style := Font.Style - [fsUnderline];
    if Pos('fsStrikeOut', s) > 0 then Font.Style := Font.Style + [fsStrikeOut]
    else Font.Style := Font.Style - [fsStrikeOut];
  end;
  if Node.Exists('CharSet') then Font.Charset := Node['CharSet'].AsInteger;
end;

{ TEventHookList }

constructor TEventHookList.Create;
begin
  inherited;
  fList := TList.Create;
end;

destructor TEventHookList.Destroy;
begin
  while fList.Count > 0 do begin
    Dispose(PEventHookRec(fList[0]));
    fList.Delete(0);
  end;
  FreeAndNil(fList);
  inherited;
end;

procedure TEventHookList.Add(const aObjectName, aEventName: string; const aObjectMethod: TMethod);
var
  PRec: PEventHookRec;
begin
  New(PRec);
  PRec^.ObjectName := aObjectName;
  PRec^.EventName := aEventName;
  PRec^.ObjectMethod := aObjectMethod;
  fList.Add(PRec);
end;

function TEventHookList.Find(const aObjectName, aEventName: string): PEventHookRec;
var
  x: integer;
begin
  Result := nil;
  try
    if not Assigned(fList) then
      exit;
    for x := 0 to fList.Count - 1 do begin
      if (PEventHookRec(fList[x])^.ObjectName = aObjectName) and (PEventHookRec(fList[x])^.EventName = aEventName) then begin
        Result := PEventHookRec(fList[x]);
        Break;
      end;
    end;
  except
    on E: Exception do begin
      raise;
    end;
  end;
end;

function TEventHookList.GetMethod(const aObjectName, aEventName: string): TMethod;
var
  PRec: PEventHookRec;
begin
  PRec := Find(aObjectName, aEventName);
  if Assigned(PRec) then Result := PRec^.ObjectMethod
  else begin
    Result.Code := nil;
    Result.Data := nil;
  end;
end;

function TEventHookList.AddIfNotFound(const aObjectName, aEventName: string; const aObjectMethod: TMethod): boolean;
begin
  if not Assigned(Find(aObjectName, aEventName)) then begin
    // Log('TEventHookList.AddIfNotFound(' + aObjectName + ',' + aEventName + ',' +
    // IntToStr(Integer(AObjectMethod.Code)) + '/' + IntToStr(Integer(AObjectMethod.Data))+')');
    Add(aObjectName, aEventName, aObjectMethod);
    Result := True;
  end
  else Result := false;
end;

{ TGuiElement }

procedure TGuiElement.BeforeSave;
begin

end;

constructor TGuiElement.Create(aOwner: TComponent);
begin
  inherited;
  fActive := false;
  fTargetName := '';
  fTarget := nil;
  fElementList := nil;
  fPrefFrameClassName := '';
  fDescription := '';
  fElementPagehint := '';
  fFirstActivate := True;
  fEventHookList := TEventHookList.Create;;
end;

destructor TGuiElement.Destroy;
begin
  FreeAndNil(fEventHookList);
  inherited;
end;

procedure TGuiElement.SetActive(const Value: boolean);
begin
  if Value <> fActive then begin
    fActive := Value;

    if fActive and fFirstActivate then begin
      Self.FirstActivate;
      fFirstActivate := false;
    end;
  end;
end;

procedure TGuiElement.FirstActivate;
begin
  // implement in descendants
end;

function TGuiElement.GetNode: TDataTreeNode;
begin
  if (TargetName <> '') and (Assigned(ElementList.Owner)) then Result := TDataTreeNode(TFormGuiPrefs(ElementList.Owner).Node[TargetName])
  else Result := nil;
end;

function TGuiElement.GetPrefFrameClassName: string;
begin
  if fPrefFrameClassName <> '' then Result := fPrefFrameClassName
  else if TargetName <> '' then Result := 'frame' + Self.TargetName
  else Result := '';
end;

function TGuiElement.GetTarget: TComponent;
begin
  if not Assigned(fTarget) and (fTargetName <> '') then begin
    // find component on form
    if Assigned(ElementList.Owner.Owner) then fTarget := ElementList.Owner.Owner.FindComponent(fTargetName);
  end;
  Result := fTarget;
end;

function TGuiElement.GetTargetComponentName: string;
begin
  Result := fTargetName;
end;

// procedure TGuiElement.SetTarget(const Value: TComponent);
// begin
// fTarget := Value;
// fTargetName := Value.Name;
// if fDescription = '' then fDescription := fTarget.Name;
// end;

procedure TGuiElement.SetTarget(const Value: TComponent); { rob }
var
  tmpStr: string;
begin
  fTarget := Value;
  fTargetName := Value.Name;
  if fDescription = '' then fDescription := fTarget.Name;

  if fDescription = 'Grid' then begin
    (*tmpStr := AnsiReplaceText(fTarget.Name, 'grd', '');
    fDescription := SeparateWords(tmpStr) + ' Grid';*)
   fDescription := GridnametoCaption(fTarget.Name);
   if not sametext(fTarget.Name , 'grdmain') then fElementPagehint := 'Fields of ' + fDescription else fElementPagehint := '';
  end;
end;

procedure TGuiElement.SetTargetComponentName(const Value: string);
begin
  fTargetName := Value;
  fTarget := nil;
end;

procedure TwwDbGridGuiElement.SetTarget(const Value: TComponent);
begin
  inherited;
  if assigned(cleanselectedList) then freeandNil(cleanselectedList);
  cleanselectedList := TGridFieldList.Create;
  cleanselectedList.LoadFromGrid(Grid);
end;

procedure TwwDbGridGuiElement.AddFieldstogether(Field1,field2: String);
var
  fsGroupname:string;
begin
  Try
    if (Grid.columnbyname(field1).visible = False ) and (Grid.columnbyname(field2).visible = False) then begin
      Grid.AddField(field1);
      Grid.AddField(field2);
    end else if Grid.columnbyname(field1).visible = False then begin
      Grid.AddField(field1);
      Grid.datasource.dataset.FieldByName(field1).Index := Grid.datasource.dataset.FieldByName(field2).Index;
      fsgroupname:= GetFieldGroupname(Field2);
      GetColumnSettings(True);
      FormGuiPrefs.SavePrefs;
      if fsgroupname <> '' then begin
        SetFieldGroupname( Field1 , fsgroupname);
        ApplyGridColumnOptions;
      end;
    end else if Grid.columnbyname(field2).visible = False then begin
      Grid.AddField(field2);
      Grid.datasource.dataset.FieldByName(field2).Index := Grid.datasource.dataset.FieldByName(field1).Index;
      fsgroupname:= GetFieldGroupname(Field1);
      GetColumnSettings(True);
      FormGuiPrefs.SavePrefs;
      if fsgroupname <> '' then begin
        SetFieldGroupname( Field2 , fsgroupname);
        ApplyGridColumnOptions;
      end;
    end;
  Except
    // kill exception if any
  End;

end;

procedure TwwDbGridGuiElement.SwapPairdfield(hidingfield, showingfield: String);
var
  fsgroupname:string;
begin
  Try
    fsgroupname:= GetFieldGroupname(hidingfield);
    Grid.RemoveField(hidingfield);
    if Grid.columnbyname(Showingfield).visible =False  then begin
      Grid.AddField(Showingfield);
      Grid.datasource.dataset.FieldByName(Showingfield).Index := Grid.datasource.dataset.FieldByName(hidingfield).Index;
      Grid.SetActiveField(Showingfield);
      GetColumnSettings(True);
      FormGuiPrefs.SavePrefs;
      if (GetFieldGroupname(Showingfield) = '') and (fsgroupname <> '') then begin
        SetFieldGroupname( Showingfield , fsgroupname);
        ApplyGridColumnOptions;
      end;

    end;
  Except
    // kill exception if any
  End;
end;

procedure TGuiElement.ApplyGuiPrefs;
begin
  // implement in descendants
end;

procedure TGuiElement.SaveGuiPrefs;
begin
  // implement in descendants
end;

function TGuiElement.GetFormGuiPrefs: TFormGuiPrefs;
begin
  if ElementList.Owner is TFormGuiPrefs then Result := TFormGuiPrefs(ElementList.Owner)
  else Result := nil;
end;

procedure TGuiElement.SetGuiDefaults;
begin
  // implement in descendants
end;

{ TGuiElementList }

constructor TGuiElementList.Create(aOwner: TComponent);
begin
  inherited;
  fList := TObjectList.Create;
  fList.OwnsObjects := True;
end;

destructor TGuiElementList.Destroy;
begin
  FreeAndNil(fList);
  inherited;
end;

procedure TGuiElementList.AddElement(aGuiElement: TGuiElement);
var
  x: integer;
begin
  x := fList.Add(aGuiElement);
  if not Assigned(TGuiElement(fList[x]).ElementList) then TGuiElement(fList[x]).ElementList := Self;
end;

function TGuiElementList.Add(const aGuiElementClassName: string): TGuiElement;
var
  Cls: TPersistentClass;
begin
  try
    Cls := FindClass(aGuiElementClassName);
    Result := TGuiElementClass(Cls).Create(nil);
    Result.ElementList := Self;
    fList.Add(Result);
  except raise;
  end;
end;

function TGuiElementList.Add(const aGuiElementClassName: string; aTarget: TComponent): TGuiElement;
begin
  Result := Add(aGuiElementClassName);
  if Assigned(Result) then Result.Target := aTarget;
end;

procedure TGuiElementList.Remove(index: integer);
begin
  if (index >= 0) and (index < fList.Count) then fList.Delete(index);
end;

function TGuiElementList.GetCount: integer;
begin
  Result := fList.Count;
end;

function TGuiElementList.GetItems(const index: integer): TGuiElement;
begin
  Result := TGuiElement(fList[index]);
end;

function TGuiElementList.GetItemByClassName(const aGuiElementClassName: string): TGuiElement;
var
  x: integer;
begin
  Result := nil;
  for x := 0 to Count - 1 do begin
    if Items[x].ClassNameIs(aGuiElementClassName) then begin
      Result := Items[x];
      Break;
    end;
  end;
end;

function TGuiElementList.GetItemByTarget(const aTarget: TComponent): TGuiElement;
var
  x: integer;
begin
  Result := nil;
  for x := 0 to Count - 1 do begin
    if Items[x].Target = aTarget then begin
      Result := Items[x];
      Break;
    end;
  end;
end;

{ TFormGuiPrefs }

constructor TFormGuiPrefs.Create(aOwner: TComponent);
begin
  inherited;
  fEnabled := True;
  fActive := false;
  fElements := TGuiElementList.Create(Self);
  fPrefsName := '';
  fNode := nil;
  fPackageId := 0; // default to main ERP exec
  fUserType := puUser;
  fUserPrefsOnly := false;
  fGlobalPrefsOnly := false;
  fInitialiseHidden := false;
  fMsgHandler := TMsgHandler.Create(Self);
  fOnActive := nil;
end;

destructor TFormGuiPrefs.Destroy;
begin
  if Assigned(fNode) then begin
    if Dirty then fNode.Storer.Save;
    FreeAndNil(fNode);
  end;
  if Assigned(fGlobalNode) and fGlobalNode.Dirty then fGlobalNode.Storer.Save;
  fGlobalNode.Free;
  FreeAndNil(fMsgHandler);
  inherited;
end;

procedure TFormGuiPrefs.DoTranslate;
var
  x: integer;
begin
  for x := 0 to Self.Elements.Count - 1 do begin
    if Elements[x] is TwwDbGridGuiElement then
      TwwDbGridGuiElement(Elements[x]).DoTranslate;
  end;
end;

procedure TFormGuiPrefs.SetEnabled(const Value: boolean);
begin
  if fActive and (Value = false) then raise Exception.Create('Can not disable while TFormGuiPrefs is Active.')
  else fEnabled := Value;
end;

Procedure TFormGuiPrefs.AddFieldstogether(Field1, field2: String);
var
  x: integer;
begin
  for x := 0 to Self.Elements.Count - 1 do begin
    if Elements[x] is TwwDbGridGuiElement then
      TwwDbGridGuiElement(Elements[x]).AddFieldstogether(Field1, Field2);
  end;
end;

Procedure TFormGuiPrefs.SwapPairdfield(hidingfield, showingfield: String);
var
  x: integer;
begin
  for x := 0 to Self.Elements.Count - 1 do begin
    if Elements[x] is TwwDbGridGuiElement then
      TwwDbGridGuiElement(Elements[x]).SwapPairdfield(hidingfield, showingfield);
  end;
end;

procedure TFormGuiPrefs.SetActive(const Value: boolean);
var
  x: integer;
begin
  if not fEnabled then Exit;
  if fActive = Value then Exit;

  fActive := Value;
  if fActive then Self.LoadPrefs;
  for x := 0 to Self.Elements.Count - 1 do begin
    Elements[x].Active := Value;
  end;
  ApplyGuiPrefs;
  if Assigned(fOnActive) then fOnActive(Self);
end;

procedure TFormGuiPrefs.SetDirty(const Value: boolean);
begin
  if Assigned(fNode) then fNode.Dirty := Value;
end;

function TFormGuiPrefs.GetNode: TDataTreeNode;
begin
  if not Assigned(fNode) then fNode := TDataTreeNode.Create;
  Result := fNode;
end;

function TFormGuiPrefs.GetPrefsName: string;
begin
  if not fEnabled then Exit;
  if fPrefsName = '' then begin
    if Assigned(Owner) then fPrefsName := Owner.ClassName;
  end;
  Result := fPrefsName;
end;

function TFormGuiPrefs.LoadPrefs: boolean;
var
  UserId: integer;
  x: integer;
begin
  Result := false;
  if not fEnabled then Exit;
  if PrefsName = '' then Exit;
  if fUserType = puGlobal then begin
    UserId := 0;
    try Result := Node.Storer.Load(PackageId, UserId, GUI_PREF_GROUP, PrefsName, AppEnv.CompanyInfo.IndustryId);
    except Result := false;
    end;
    if Node.NodeName = '' then Node.NodeName := PrefsName;
    // if there are no global settings Save the current UI settings back as global
    if not Result then begin
      fInitialiseHidden := True;
      SaveElementsGuiPrefs;
      Node.Storer.Save;
      fInitialiseHidden := false;
    end;
  end
  else if fUserType = puUser then begin
    UserId := AppEnv.Employee.EmployeeID;
    try Result := Node.Storer.Load(PackageId, UserId, GUI_PREF_GROUP, PrefsName, AppEnv.CompanyInfo.IndustryId);
    except Result := false;
    end;
    if not Result then begin
      UserId := 0;

      // get global prefs ...
      if not Self.fUserPrefsOnly then begin
        try Result := Node.Storer.Load(PackageId, UserId, GUI_PREF_GROUP, PrefsName,AppEnv.CompanyInfo.IndustryId);
        except Result := false;
        end;
      end;
      if Node.NodeName = '' then Node.NodeName := PrefsName;

      // if there are no global settings Save the current UI settings back as global
      // (NOTE global means all the GUI settings for all users for this form class)
      if not Result then begin
        // grab the current settings for this form and Save as the default for
        // this form class for all users
        fInitialiseHidden := True;
        SaveElementsGuiPrefs;
        // load any default Gui settings for each Gui element
        for x := 0 to Elements.Count - 1 do Elements[x].SetGuiDefaults;
        if not Self.fUserPrefsOnly then Node.Storer.Save;
      end;

      // and Save back for this user
      Node.Storer.UserId := AppEnv.Employee.EmployeeID;
      Node.Storer.Save;
      fInitialiseHidden := false;
    end;
  end;
end;

procedure TFormGuiPrefs.RevertToGlobalPrefs;
var
  UserId: integer;
begin
  if not fEnabled then Exit;
  if PrefsName = '' then Exit;
  UserId := 0;
  // get global prefs ...
  Node.Storer.Load(PackageId, UserId, GUI_PREF_GROUP, PrefsName,AppEnv.CompanyInfo.IndustryId);
  if Node.NodeName = '' then Node.NodeName := PrefsName;

  Node.Storer.UserId := AppEnv.Employee.EmployeeID;
  // and Save back for this user
  Node.Storer.Save;
end;

procedure TFormGuiPrefs.SavePrefs;
var
  UserId: integer;
  cmd: TERPCommand;
begin
  if not fEnabled then Exit;
  if PrefsName = '' then Exit;
  BeforeSave;
  // Node.Storer.Save;
  if fUserType = puUser then UserId := AppEnv.Employee.EmployeeID
  else UserId := 0;
  Node.Storer.Save(PackageId, UserId, GUI_PREF_GROUP, PrefsName, AppEnv.CompanyInfo.IndustryId);
  if (fUserType = puGlobal) and fResetAllToGlobal then begin
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := Node.Storer.Connection;
      cmd.SQL.Add('delete from tblPreferences where');
      cmd.SQL.Add('PrefName = ' + QuotedStr(PrefsName));
      cmd.SQL.Add('and PrefGroup = ' + QuotedStr(GUI_PREF_GROUP));
      cmd.SQL.Add('and PackageID = ' + IntToStr(PackageID));
      cmd.SQL.Add('and UserID > 0');
      cmd.sql.Add('and IndustryId='+IntToStr(AppEnv.CompanyInfo.IndustryId));
      cmd.Execute;
    finally
      cmd.Free;
    end;
    // force user settings to be reloaded
    // UserType := puUser;
  end;
end;

procedure TFormGuiPrefs.Savecurrencysetup;
var
  UserId: integer;
  MsgObj: TMsgObj;
begin
  if fUserType = puUser then UserId := AppEnv.Employee.EmployeeID
  else UserId := 0;
  MsgObj := TMsgObj.Create;
  try
    MsgObj.SetAddress('TFrForeigncurrencyEdit', 'Save');
    MsgObj.IntValue := UserId;
    fMsgHandler.Send(MsgObj, MsgObj);
  finally FreeAndNil(MsgObj);
  end;
end;

procedure TFormGuiPrefs.SetPrefsName(const Value: string);
begin
  if not fEnabled then Exit;
  if fPrefsName <> Value then begin
    // This is a custom list view so set this true to prevent user from
    // trying to set global (ie default) prefs
    fUserPrefsOnly := True;
    fPrefsName := Value;
    if fActive then begin
      Active := false;
      Active := True;
    end;
  end;
end;

function TFormGuiPrefs.getFCEnabled: boolean;
var
  x: integer;
begin
  Result := false;
  for x := 0 to Elements.Count - 1 do begin
    if SysUtils.SameText(Elements[x].PrefFrameClassName, 'TFrForeigncurrencyEdit') then begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TFormGuiPrefs.ApplyGuiPrefs;
var
  x: integer;
begin
  if not fEnabled then Exit;
  for x := 0 to Elements.Count - 1 do begin
    Elements[x].ApplyGuiPrefs;
  end;
end;

procedure TFormGuiPrefs.BeforeSave;
var
  x: integer;
begin
  if not fEnabled then Exit;
  for x := 0 to Elements.Count - 1 do begin
    Elements[x].BeforeSave;
  end;
end;

procedure TFormGuiPrefs.ShowCustomiseForm(const ActiveTabCaption: string = '');
var
  fmFormGuiPrefsEdit: TForm;
begin
  if not fEnabled then Exit;
  fmFormGuiPrefsEdit := TForm(GetComponentByClassName('TfmFormGuiPrefsEdit'));
  if Assigned(fmFormGuiPrefsEdit) then begin
    TypInfo.SetObjectProp(fmFormGuiPrefsEdit, 'FormGuiPrefs', TFormGuiPrefs(Self));
    TypInfo.SetStrProp(fmFormGuiPrefsEdit, 'ActiveTab', ActiveTabCaption);
    fmFormGuiPrefsEdit.ShowModal;
    fmFormGuiPrefsEdit.release;
  end;
end;

procedure TFormGuiPrefs.clearLinkedfields(const aDataSet: TDataSet);
var
  index: integer;
  FoundDataSet: boolean;
begin
  FoundDataSet := false;
  index := 0;
  while (index < Elements.Count) and (FoundDataSet = false) do begin
    if Elements[index] is TwwDbGridGuiElement then begin
      if Assigned(TwwDbGridGuiElement(Elements[index]).Target) and Assigned(TwwDbGrid(TwwDbGridGuiElement(Elements[index]).Target).DataSource) and
        (TwwDbGrid(TwwDbGridGuiElement(Elements[index]).Target).DataSource.Dataset = aDataSet) then begin
        TwwDbGridGuiElement(Elements[index]).clearLinkedfields;
        FoundDataSet := True;
      end;
    end;
    Inc(index);
  end;
end;

procedure TFormGuiPrefs.AddLinkedFields(const fsMainfieldName: string; const fsgroupname: string; const fsLinkedfields: array of string; const aDataSet: TDataSet);
var
  index: integer;
  FoundDataSet: boolean;
begin
  FoundDataSet := false;
  index := 0;
  while (index < Elements.Count) and (FoundDataSet = false) do begin
    if Elements[index] is TwwDbGridGuiElement then begin
      if Assigned(TwwDbGridGuiElement(Elements[index]).Target) and Assigned(TwwDbGrid(TwwDbGridGuiElement(Elements[index]).Target).DataSource) and
        (TwwDbGrid(TwwDbGridGuiElement(Elements[index]).Target).DataSource.Dataset = aDataSet) then begin
        TwwDbGridGuiElement(Elements[index]).AddLinkedFields(fsMainfieldName, fsgroupname, fsLinkedfields);
        FoundDataSet := True;
      end;
    end;
    Inc(index);
  end;
end;


procedure TFormGuiPrefs.AddFieldPair(const FieldName1, FieldName2: string; const aDataSet: TDataSet);
var
  index: integer;
  FoundDataSet: boolean;
begin
  FoundDataSet := false;
  index := 0;
  while (index < Elements.Count) and (FoundDataSet = false) do begin
    if Elements[index] is TwwDbGridGuiElement then begin
      if Assigned(TwwDbGridGuiElement(Elements[index]).Target) and Assigned(TwwDbGrid(TwwDbGridGuiElement(Elements[index]).Target).DataSource) and
        (TwwDbGrid(TwwDbGridGuiElement(Elements[index]).Target).DataSource.Dataset = aDataSet) then begin
        TwwDbGridGuiElement(Elements[index]).AddFieldPair(FieldName1, FieldName2);
        FoundDataSet := True;
      end;
    end;
    Inc(index);
  end;
end;

function TFormGuiPrefs.GetDirty: boolean;
begin
  Result := false;
  if Assigned(fNode) and fNode.Dirty then Result := True;
end;

procedure TFormGuiPrefs.SaveElementsGuiPrefs;
var
  x: integer;
begin
  if not fEnabled then Exit;
  for x := 0 to Elements.Count - 1 do begin
    Elements[x].SaveGuiPrefs;
  end;
end;

function TFormGuiPrefs.GetUserType: TPrefUserType;
begin
  Result := Self.fUserType;
end;

procedure TFormGuiPrefs.SetUserType(const Value: TPrefUserType);
begin
  if not fEnabled then Exit;
  if Value <> fUserType then begin
    fUserType := Value;
    // reload data
    Self.LoadPrefs;
    if fUserType = puGlobal then TForm(Owner).Caption := TForm(Owner).Caption + ' [Global]'
    else TForm(Owner).Caption := StringReplace(TForm(Owner).Caption, ' [Global Customisation]', '', [rfReplaceAll, rfIgnoreCase]);
  end;
end;

function TFormGuiPrefs.GetForm: TForm;
begin
  if Owner is TForm then Result := TForm(Owner)
  else Result := nil;
end;

constructor TReportonForeignCurrency.Create(aOwner: TComponent);
begin
  inherited;
  fPrefFrameClassName := 'TFrForeigncurrencyEdit';
  fDescription := 'Foreign Currencies';
  fElementPagehint := 'Foreign Currencies';
end;

function TFormGuiPrefs.GetDbGridElement(const aTarget: TComponent): TwwDbGridGuiElement;
var
  x: integer;
begin
//  Result := TwwDbGridGuiElement(Elements.ItemByTarget[aTarget]);
  result := nil;
  for x := 0 to Elements.Count -1 do begin
    if SameText(Elements[x].ClassName,'TwwDbGridGuiElement') and (Elements[x].Target = aTarget) then begin
      result := TwwDbGridGuiElement(Elements[x]);
      break;
    end;
  end;
  if not Assigned(Result) then begin
    { create it }
    Result := TwwDbGridGuiElement(Elements.Add('TwwDbGridGuiElement', aTarget));
  end;
end;

procedure TFormGuiPrefs.AddreadonlyField(const FieldName: string; const aDataSet: TDataSet);
var
  index: integer;
  FoundDataSet: boolean;
begin
  FoundDataSet := false;
  index := 0;
  while (index < Elements.Count) and (FoundDataSet = false) do begin
    if Elements[index] is TwwDbGridGuiElement then begin
      if Assigned(TwwDbGridGuiElement(Elements[index]).Target) and Assigned(TwwDbGrid(TwwDbGridGuiElement(Elements[index]).Target).DataSource) and
        (TwwDbGrid(TwwDbGridGuiElement(Elements[index]).Target).DataSource.Dataset = aDataSet) then begin
        TwwDbGridGuiElement(Elements[index]).AddreadonlyField(FieldName);
        FoundDataSet := True;
      end;
    end;
    Inc(index);
  end;
end;

function TFormGuiPrefs.GetGlobalNode: TDataTreeNode;
begin
  Result := nil;
  if not fEnabled then Exit;
  if PrefsName = '' then Exit;
  if not Assigned(fGlobalNode) then begin
    fGlobalNode := TDataTreeNode.Create;
    fGlobalNode.Storer.Load(PackageId, 0, GUI_PREF_GROUP, PrefsName,AppEnv.CompanyInfo.IndustryId);
    if fGlobalNode.NodeName = '' then fGlobalNode.NodeName := PrefsName;
  end;
  Result := fGlobalNode;
end;

procedure TFormGuiPrefs.SaveGlobalNode;
begin
  if not fEnabled then Exit;
  if PrefsName = '' then Exit;
  if Assigned(fGlobalNode) then fGlobalNode.Storer.Save(PackageId, 0, GUI_PREF_GROUP, PrefsName, AppEnv.CompanyInfo.IndustryId);
end;

{ TwwDbGridGuiElement }

constructor TwwDbGridGuiElement.Create(aOwner: TComponent);
begin
  inherited;
  cleanselectedList := nil;
  fCustomColumns := nil;
  fDataset := nil;
  fPrefFrameClassName := 'TfrWwDbGridGuiEdit';
  fDescription := 'Grid';
  Parser := TMathParser.Create(Self);
  Parser.OnGetVar := DoGetParserVariable;
  fHiddenFields := TStringList.Create;
  fRemovedFields := TStringList.Create;
  fMandatoryFields := TStringlist.create;
  fFieldPairs := TList.Create;
  fReadonlyFields := TStringList.Create;
  fLinkedFields := TList.Create;
end;

destructor TwwDbGridGuiElement.Destroy;
begin
  FreeandNil(cleanselectedList);
  while fFieldPairs.Count > 0 do begin
    Dispose(PFieldPair(fFieldPairs[0]));
    fFieldPairs.Delete(0);
  end;

  while fLinkedFields.Count > 0 do begin
    Dispose(PLinkedFields(fLinkedFields[0]));
    fLinkedFields.Delete(0);
  end;

  FreeAndNil(fFieldPairs);
  FreeAndNil(fReadonlyFields);
  FreeAndNil(fLinkedFields);
  FreeAndNil(fHiddenFields);
  FreeAndNil(fRemovedFields);
  Freeandnil(fMandatoryFields);
  inherited;
end;

procedure TwwDbGridGuiElement.SetActive(const Value: boolean);
begin
  if Value <> fActive then begin
    inherited;

    if fActive then begin
      // hook the events we need
      // Log('TwwDbGridGuiElement.SetActive ----------');
      // Log('TwwDbGridGuiElement.SetActive Adding ' + Dataset.Owner.ClassName + ' Event OnCalcFields');
      if Dataset <> nil then if EventHookList.AddIfNotFound(Dataset.Name, 'OnCalcFields', TMethod(Dataset.OnCalcFields)) then Dataset.OnCalcFields := DoOnCalcFields;

      // Log('TwwDbGridGuiElement.SetActive Adding ' + Dataset.Owner.ClassName + ' Event OnColumnMoved');
      if Grid <> nil then if EventHookList.AddIfNotFound(Grid.Name, 'OnColumnMoved', TMethod(Grid.OnColumnMoved)) then Grid.OnColumnMoved := DoOnColumnMoved;

      // Log('TwwDbGridGuiElement.SetActive Adding ' + Dataset.Owner.ClassName + ' Event OnColWidthChanged');
      if Grid <> nil then if EventHookList.AddIfNotFound(Grid.Name, 'OnColWidthChanged', TMethod(Grid.OnColWidthChanged)) then Grid.OnColWidthChanged := DoOnColWidthChanged;

      // Log('TwwDbGridGuiElement.SetActive Adding ' + Dataset.Owner.ClassName + ' Event BeforeOpen');
      if Dataset <> nil then if EventHookList.AddIfNotFound(Dataset.Name, 'BeforeOpen', TMethod(Dataset.BeforeOpen)) then Dataset.BeforeOpen := DoBeforeOpen;

      // Log('TwwDbGridGuiElement.SetActive Adding ' + Dataset.Owner.ClassName + ' Event AfterOpen');
      if Dataset <> nil then if EventHookList.AddIfNotFound(Dataset.Name, 'AfterOpen', TMethod(Dataset.AfterOpen)) then Dataset.AfterOpen := DoAfterOpen;

      if Grid <> nil then if EventHookList.AddIfNotFound(Grid.Name, 'OnTitleButtonClick', TMethod(Grid.OnTitleButtonClick)) then Grid.OnTitleButtonClick := DoOnTitleButtonClick;
    end;
  end;
end;

function TwwDbGridGuiElement.GetCustomColumns: TDataTreeNode;
begin
  if not Assigned(fCustomColumns) then fCustomColumns := TDataTreeNode(Node['CustomColumns']);
  Result := fCustomColumns;
end;

function TwwDbGridGuiElement.GetDataset: TDataSet;
begin
  try
    if not Assigned(fDataset) then fDataset := Grid.DataSource.Dataset;
    Result := fDataset;
  except Result := nil;
  end;
end;

function TwwDbGridGuiElement.GetGrid: TwwDbGrid;
begin
  Result := TwwDbGrid(Target);
end;

procedure TwwDbGridGuiElement.RemoveDatasetCustomFields;
var
  x: integer;
  Field: TField;
begin
  if (not Assigned(Dataset)) then Exit;
  x := 0;
  while x < Dataset.FieldCount do begin
    try
      if ((Dataset.Fields[x].Tag and TAG_MASK_CG) = TAG_MASK_CG) and
      // Only remove cust columns that are not defined in node data
        (not CustomColumns.Exists(Dataset.Fields[x].FieldName)) then begin
        Dataset.Active := false;
        Field := Dataset.Fields[x];
        try
          Dataset.Fields.Remove(Field);
        finally
          FreeAndNil(Field);
        end;
      end
      else Inc(x);
    except
      Inc(x);
    end;
  end;
end;

procedure TwwDbGridGuiElement.DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var Found: boolean);
var
  Field: TField;
begin
  Field := Dataset.FindField(VarName);
  if Assigned(Field) then begin
    Value := Field.AsFloat;
    Found := True;
  end
  else Found := false;
end;

procedure TwwDbGridGuiElement.GetColumnSettings(IgnoreReadOnly: boolean = false);
begin
  if (not Assigned(Dataset)) then Exit;
  Node['GridFields'].CData := GetGridSelectedText(Grid, IgnoreReadOnly); // Grid.Selected.Text;
end;

procedure TwwDbGridGuiElement.GetGridOptions;
begin
  // Save grid option settings back to node
  FontToNode(Grid.TitleFont, TDataTreeNode(Node['TitleFont']));
  FontToNode(Grid.Font, TDataTreeNode(Node['Font']));
  Node['ShowGridLines'].AsBoolean := dgColLines in Grid.Options;
  Node['AlternatingRowColor'].AsInteger := Grid.PaintOptions.AlternatingRowColor;
  if dataset <> nil then
    if dataset is TERPQuery then
      Node['IndexFieldNames'].asString := TERPQuery(dataset).IndexFieldNames;
end;

procedure TwwDbGridGuiElement.DoOnCalcFields(Dataset: TDataSet);
var
  x: integer;
  Field: TField;
  SavedOnCalcFields: TDatasetNotifyEvent;
begin
  try
    TMethod(SavedOnCalcFields) := EventHookList.GetMethod(Dataset.Name, 'OnCalcFields');
  except
    SavedOnCalcFields := nil;
  end;
  if Assigned(SavedOnCalcFields) then begin
    SavedOnCalcFields(Dataset);
  end;

  // now perform calcs for all custom columns
  try
    for x := 0 to CustomColumns.Count - 1 do begin
      if CustomColumns.Items[x].ItemByName['FieldName'].AsString <> '' then begin
        Field := Dataset.FieldByName(CustomColumns.Items[x].ItemByName['FieldName'].AsString);
        if Assigned(Field) and (CustomColumns[Field.FieldName + '.Formula'].AsString <> '') then begin
          Parser.ParseString := CustomColumns[Field.FieldName + '.Formula'].AsString;
          Parser.Parse;
          Field.AsFloat := Parser.ParseValue;
        end;
      end;
    end;
  Except
    on E:Exception do begin
    end;
  end;
end;

procedure TwwDbGridGuiElement.DoOnColumnMoved(Sender: TObject; FromIndex, ToIndex: integer);
var
  SavedMoveEvent: TMovedEvent;
begin
  TMethod(SavedMoveEvent) := EventHookList.GetMethod(Grid.Name, 'OnColumnMoved');

  if Assigned(SavedMoveEvent) then begin
    SavedMoveEvent(Sender, FromIndex, ToIndex);
  end;

  GetColumnSettings(True);
  FormGuiPrefs.SavePrefs;
end;

procedure TwwDbGridGuiElement.DoOnColWidthChanged(Sender: TObject; Column: integer);
var
  SavedWidthChangedEvent: TColWidthChangedEvent;
begin
  TMethod(SavedWidthChangedEvent) := EventHookList.GetMethod(Grid.Name, 'OnColWidthChanged');

  if Assigned(SavedWidthChangedEvent) then begin
    SavedWidthChangedEvent(Sender, Column);
  end;

  GetColumnSettings(True);
  FormGuiPrefs.SavePrefs;
end;

procedure TwwDbGridGuiElement.DoOnTitleButtonClick(Sender: TObject; AFieldName: string);
var
  SavedTitleButtonClickEvent: TTitleButtonClickEvent;
begin
  TMethod(SavedTitleButtonClickEvent) := EventHookList.GetMethod(Grid.Name, 'OnTitleButtonClick');

  if Assigned(SavedTitleButtonClickEvent) then begin
    SavedTitleButtonClickEvent(Sender, AFieldName);
  end;

  GetColumnSettings(True);
  FormGuiPrefs.SavePrefs;
end;

procedure TwwDbGridGuiElement.DoTranslate;
var
  selectedList: TGridFieldList;
  idx: integer;
  Selectedrec : TGridFieldRec;
begin

  selectedList := TGridFieldList.Create;
  try
    selectedList.LoadFromGrid(Grid);
    for idx := 0 to selectedList.Count-1 do begin
      Selectedrec:= selectedList.items[idx];
      Selectedrec.GroupName := Dotranslation(Selectedrec.GroupName);
    end;
    selectedList.SaveToGrid(Grid);
  finally selectedList.Free;
  end;

end;

procedure TwwDbGridGuiElement.DoBeforeOpen(Dataset: TDataSet);
var
  SavedBeforeOpen: TDatasetNotifyEvent;
begin
  // we need to add custom fields before the dataset is opened

  // first call any existing event handler
  TMethod(SavedBeforeOpen) := EventHookList.GetMethod(Dataset.Name, 'BeforeOpen');
  if Assigned(SavedBeforeOpen) then begin
    SavedBeforeOpen(Dataset);
  end;

  ApplyGridCustomColumnOptions;
  ApplyGridColumnOptions(false);
end;

procedure TwwDbGridGuiElement.DoAfterOpen(Dataset: TDataSet);
var
  SavedAfterOpen: TDatasetNotifyEvent;
begin
  // we need to apply custom column settings each time the grid dataset is opened

  // first call any existing event handler
  TMethod(SavedAfterOpen) := EventHookList.GetMethod(Dataset.Name, 'AfterOpen');
  if Assigned(SavedAfterOpen) then begin
    SavedAfterOpen(Dataset);
  end;

  // re-apply column settings
  ApplyGridColumnOptions(True);
end;

procedure TwwDbGridGuiElement.SaveGuiPrefs;
begin
  inherited;
  GetColumnSettings(True);
  GetGridOptions;
end;

procedure TwwDbGridGuiElement.ApplyGuiPrefs;
begin
  inherited;
  if (not Active) or (not Assigned(Target)) then Exit;
  ApplyGeneralGridOptions;
  ApplyGridCustomColumnOptions;
  ApplyGridColumnOptions(false);
end;

procedure TwwDbGridGuiElement.ApplyGeneralGridOptions;
begin
  if not Assigned(Target) then Exit;
  // set fonts etc
  NodeToFont(TDataTreeNode(Node['Font']), Grid.Font);
  NodeToFont(TDataTreeNode(Node['TitleFont']), Grid.TitleFont);
  if Node.Exists('ShowGridLines') then begin
    if Node['ShowGridLines'].AsBoolean then Grid.Options := Grid.Options + [dgColLines, dgRowLines]
    else Grid.Options := Grid.Options - [dgColLines, dgRowLines];
  end;
  if Node.Exists('UseAlternatingRowColor') and  not(Node['UseAlternatingRowColor'].asBoolean) then
    Grid.PaintOptions.AlternatingRowColor := clNone
  else if Appenv.Employee.UseAlternatingRowColor then begin
    Grid.PaintOptions.AlternatingRowColor := Appenv.Employee.AlternatingRowColor;
  end else if Node.Exists('AlternatingRowColor') then begin
    Grid.PaintOptions.AlternatingRowColor := Node['AlternatingRowColor'].AsInteger;
  end;
  if dataset <> nil then
    if dataset is TERPQuery then
      if Node.Exists('IndexFieldNames') then
        if Node['IndexFieldNames'].asString <> '' then
          TERPQuery(dataset).IndexFieldNames := Node['IndexFieldNames'].asString;
end;

{ return < 0 if node1 is less than node2,
  0 if they are equal and
  > 0 if node1 is greater than node2 }
function SortColIdxFunc(node1, node2: TDataTreeNodeBase): integer;
var
  fld1name, fld2Name: string;
  fld1index, fld2index: integer;
begin
  Result := 0;
  try
    fld1name := node1.NodeName;
    fld2Name := node2.NodeName;
    fld1index := node1.ItemByName['Index'].AsInteger;
    fld2index := node2.ItemByName['Index'].AsInteger;
    if fld1index > fld2index then Result := 1
    else if fld1index < fld2index then Result := -1
    else begin
      Result := CompareText(fld1name, fld2Name);
    end;
  except
  end;
end;

procedure TwwDbGridGuiElement.ApplyGridColumnOptions(RemoveIfNotFound: boolean = false);
var
  x: integer;
begin
  if Node['GridFields'].CData <> '' then begin
    Grid.Selected.Text := Node['GridFields'].CData;
    Grid.ApplySelected;
    if RemovedFields.Count > 0 then RemoveFields(RemovedFields.CommaText);

    { NOTE: The wwDbGrid code will NOT Save the seleted data back to the
      fields if the dataset containes calculated fields ...
      so we force it here }
    // if Assigned(Dataset) and  DatasetHasCalculatedFields(DataSet) then
    Grid.ApplySelected;
  end;
  if fReadonlyFields.Count > 0 then
    for x := 0 to fReadonlyFields.Count - 1 do
      if Grid.columnbyname(fReadonlyFields[x]) <> nil then Grid.columnbyname(fReadonlyFields[x]).Readonly := True;
end;

procedure TwwDbGridGuiElement.ApplyGridCustomColumnOptions;
var
  DatasetIsOpen: boolean;
  x: integer;
  Field: TFloatField;
begin
  if (not Assigned(Target)) or (not Assigned(Dataset)) then Exit;

  DatasetIsOpen := Dataset.Active;

  try
    RemoveDatasetCustomFields;
    fCustomColumns := nil;
    if CustomColumns.Count > 0 then begin
      for x := 0 to CustomColumns.Count - 1 do begin
        if (CustomColumns.Items[x].ItemByName['FieldName'].AsString <> '') and (not Assigned(Dataset.FindField(CustomColumns.Items[x].ItemByName['FieldName'].AsString))) then begin
          Dataset.Active := false;
          Field := TFloatField.Create(Dataset.Owner);
          Field.FieldKind := fkCalculated;
          Field.FieldName := CustomColumns.Items[x].ItemByName['FieldName'].AsString;
          Field.Name := UniqueComponentName(Field, CustomColumns.Items[x].ItemByName['Name'].AsString);
          Field.DisplayFormat := CustomColumns.Items[x].ItemByName['DisplayFormat'].AsString;
          Field.Index := Dataset.FieldCount;
          Field.Tag := TAG_MASK_CG;
          Field.Dataset := Dataset;
          // DataSet.FieldDefs.Update;
        end;
      end;
    end;
  finally Dataset.Active := DatasetIsOpen;
  end;
end;

function TwwDbGridGuiElement.DatasetHasPersistantFields: boolean;
var
  x: integer;
begin
  Result := True;
  if (not Assigned(Dataset)) then Exit;
  if not Assigned(Target) then Exit;
  for x := 0 to Dataset.FieldCount - 1 do begin
    if Dataset.Fields[x].Name = '' then begin
      Result := false;
      Break;
    end;
  end;
end;

procedure TwwDbGridGuiElement.AddLinkedFields(const fsMainfieldName: string; const fsgroupname: string; const fsLinkedfields: array of string);
var
  LinkedPtr: PLinkedFields;
  ctr: integer;
begin
  New(LinkedPtr);
  LinkedPtr.Mainfield := fsMainfieldName;
  LinkedPtr.groupname := fsgroupname;
  Setlength(LinkedPtr.Linkedfields, Length(fsLinkedfields));
  for ctr := low(fsLinkedfields) to high(fsLinkedfields) do LinkedPtr.Linkedfields[ctr] := fsLinkedfields[ctr];
  fLinkedFields.Add(LinkedPtr);
end;

procedure TwwDbGridGuiElement.AddMandatoryField(const AFieldName: string);
begin
  if fMandatoryFields.IndexOf(AFieldName) < 0 then fMandatoryFields.Add(AFieldName);
end;

procedure TwwDbGridGuiElement.clearLinkedfields;
begin
  fLinkedFields.Clear;
end;

procedure TwwDbGridGuiElement.AddFieldPair(const FieldName1, FieldName2: string);
var
  PairPtr: PFieldPair;
begin
  New(PairPtr);
  PairPtr.FieldName1 := FieldName1;
  PairPtr.FieldName2 := FieldName2;
  fFieldPairs.Add(PairPtr);
end;

function TwwDbGridGuiElement.IsLinkedMain(const Value: string; var fsgroupname: string): boolean;
var
  index: integer;
  FoundMatch: boolean;
begin
  index := 0;
  FoundMatch := false;
  while (index < fLinkedFields.Count) and (FoundMatch = false) do begin
    if SysUtils.SameText(PLinkedFields(fLinkedFields[index]).Mainfield, Value) then begin
      FoundMatch := True;
      fsgroupname := PLinkedFields(fLinkedFields[index]).groupname;
    end
    else Inc(index);
  end;
  Result := FoundMatch;
end;

function TwwDbGridGuiElement.IsLinkedfield(const Value: string; var mainfieldName: string; var groupname: string): boolean;
var
  index: integer;
  FoundMatch: boolean;
  ctr: integer;
begin

  index := 0;
  FoundMatch := false;
  mainfieldName := '';
  while (index < fLinkedFields.Count) and (FoundMatch = false) do begin
    for ctr := low(PLinkedFields(fLinkedFields[index]).Linkedfields) to high(PLinkedFields(fLinkedFields[index]).Linkedfields) do
      if PLinkedFields(fLinkedFields[index]).Linkedfields[ctr] = Value then begin
        FoundMatch := True;
        mainfieldName := PLinkedFields(fLinkedFields[index]).Mainfield;
        groupname := PLinkedFields(fLinkedFields[index]).groupname;
      end;
    if not FoundMatch then Inc(index);
  end;
  Result := FoundMatch;
end;

function TwwDbGridGuiElement.IsPairedField(const Value: string): boolean;
var
  index: integer;
  FoundMatch: boolean;
begin
  index := 0;
  FoundMatch := false;

  while (index < fFieldPairs.Count) and (FoundMatch = false) do begin
    if SysUtils.SameText(Value, PFieldPair(fFieldPairs[index]).FieldName1) or SysUtils.SameText(Value, PFieldPair(fFieldPairs[index]).FieldName2) then FoundMatch := True
    else Inc(index);
  end;

  Result := FoundMatch;
end;


function TwwDbGridGuiElement.getLinkedFields(const Value: string): PLinkedFields;
var
  index: integer;
begin
  Result := nil;
  index := 0;
  while (index < fLinkedFields.Count) do begin
    if SysUtils.SameText(Value, PLinkedFields(fLinkedFields[index]).Mainfield) then begin
      Result := PLinkedFields(fLinkedFields[index]);
      Exit;
    end;
    Inc(index);
  end;
end;

function TwwDbGridGuiElement.PairedField(const Value: string): string;
var
  index: integer;
  FoundMatch: boolean;
begin
  index := 0;
  FoundMatch := false;
  Result := '';

  while (index < fFieldPairs.Count) and (FoundMatch = false) do begin
    if SysUtils.SameText(Value, PFieldPair(fFieldPairs[index]).FieldName1) then begin
      Result := PFieldPair(fFieldPairs[index]).FieldName2;
      FoundMatch := True;
    end
    else if SysUtils.SameText(Value, PFieldPair(fFieldPairs[index]).FieldName2) then begin
      Result := PFieldPair(fFieldPairs[index]).FieldName1;
      FoundMatch := True;
    end
    else Inc(index);
  end;
end;

function TwwDbGridGuiElement.FieldHidden(const AFieldName: string): boolean;
begin
  Result := fHiddenFields.IndexOf(AFieldName) > -1;
end;

procedure TwwDbGridGuiElement.HideField(const AFieldName: string);
begin
  if fHiddenFields.IndexOf(AFieldName) < 0 then fHiddenFields.Add(AFieldName);
end;

procedure TwwDbGridGuiElement.UnHideField(const AFieldName: string);
var
  idx: integer;
begin
    idx := fHiddenFields.IndexOf(AFieldName);
    if idx > -1 then fHiddenFields.Delete(idx);
end;

procedure TwwDbGridGuiElement.UnHideFields(const aFieldList: string);
var
  sl: TStringList;
  x: integer;
begin
  sl := TStringList.Create;
  try
    sl.CommaText := aFieldList;
    for x := 0 to sl.Count - 1 do begin
      UnHideField(sl[x]);
    end;
  finally sl.Free;
  end;
end;

procedure TwwDbGridGuiElement.HideFields(const aFieldList: string);
var
  sl: TStringList;
  x: integer;
begin
  sl := TStringList.Create;
  try
    sl.CommaText := aFieldList;
    for x := 0 to sl.Count - 1 do begin
      HideField(sl[x]);
    end;
  finally sl.Free;
  end;
end;

procedure TwwDbGridGuiElement.RestfieldProperties(selectedList: TGridFieldList;AFieldName:String;CleanVisible:Boolean=True);
var
  Selectedrec ,cleanrec: TGridFieldRec;
  ctr, i:Integer;
begin
  Selectedrec:= selectedList.Field[aFieldName];
  if not(Assigned(Selectedrec)) then exit;
  Cleanrec:= CleanselectedList.Field[aFieldName];
  if not(Assigned(Cleanrec)) then exit;
  Selectedrec.DisplayWidth:= Cleanrec.DisplayWidth;
  Selectedrec.ReadOnly    := Cleanrec.ReadOnly;
  Selectedrec.GroupName   := Dotranslation(Cleanrec.GroupName);

  if not CleanVisible then begin
    ctr:= -1;
    if Selectedrec.GroupName <> '' then begin
      for i := 0 to  selectedList.Count-1 do begin
        if Sametext(Selectedlist.Items[i].GroupName , Selectedrec.GroupName) and not(sametext(Selectedlist.Items[i].fieldname , SelectedRec.fieldname)) then
          if ctr<i then ctr := i;
      end;
      if ctr>=0 then Selectedrec.index := ctr+1;
    end;
  end;
end;


function TwwDbGridGuiElement.GetSelectedFields : TStringList;
var
  selectedList: TGridFieldList;
  idx: integer;
  Selectedrec : TGridFieldRec;
  CleanVisible:Boolean;
  selectedFieldNames : TStringList;

  g : Integer;
  gfr : TGridFieldRec;
begin
  if not Active then raise Exception.Create('Grid GUI Element not active, can not add field.');

  selectedList := TGridFieldList.Create;
  selectedFieldNames := TStringList.Create;

  try
    selectedList.LoadFromGrid(Grid);

    for g := 0 to selectedList.Count - 1 do
    begin
       gfr := selectedList.Items[g];
       selectedFieldNames.Add(gfr.FieldName);
    end;

    result := selectedFieldNames;

  finally selectedList.Free;
  end;
end;


procedure TwwDbGridGuiElement.AddField(const AFieldName: string);
var
  selectedList: TGridFieldList;
  idx: integer;
  Selectedrec : TGridFieldRec;
  CleanVisible:Boolean;
begin
  if not Active then raise Exception.Create('Grid GUI Element not active, can not add field.');
  selectedList := TGridFieldList.Create;
  try
    selectedList.LoadFromGrid(Grid);
    Selectedrec:= selectedList.Field[aFieldName];
    (*if (Assigned(Selectedrec)) then exit;*)
    CleanVisible :=Assigned(Selectedrec);
    if not(Assigned(Selectedrec)) then selectedList.AddField(AFieldName, Dataset,cleanselectedList);
    UnHideField(AFieldName);
    idx := fRemovedFields.IndexOf(AFieldName);
    if idx > -1 then fRemovedFields.Delete(idx);
    RestfieldProperties(selectedList ,AFieldName , CleanVisible);
    selectedList.SaveToGrid(Grid);
    Node['GridFields'].CData := selectedList.Text;
  finally selectedList.Free;
  end;
end;


procedure TwwDbGridGuiElement.RemoveField(const AFieldName: string);
var
  selectedList: TGridFieldList;
begin
  if not Active then exit; // raise Exception.Create('Grid GUI Element not active, can not remove field.');
  selectedList := TGridFieldList.Create;
  try
    selectedList.LoadFromGrid(Grid);
    selectedList.RemoveField(AFieldName);
    HideField(AFieldName);
    if fRemovedFields.IndexOf(AFieldName) < 0 then fRemovedFields.Add(AFieldName);
    selectedList.SaveToGrid(Grid);
  finally selectedList.Free;
  end;
end;


Function TwwDbGridGuiElement.IsMandatoryField(const AFieldName: string):Boolean;
begin
  result := fMandatoryFields.IndexOf(AFieldName) >=0;
end;


procedure TwwDbGridGuiElement.AddFields(const aFieldList: string;fieldIndex :Integer=-1);
var
  sl: TStringList;
  x, idx: integer;
  selectedList: TGridFieldList;
begin
  sl := TStringList.Create;
  selectedList := TGridFieldList.Create;
  try
    selectedList.LoadFromGrid(Grid);
    sl.CommaText := aFieldList;
    for x := 0 to sl.Count - 1 do begin
      selectedList.AddField(sl[x], Dataset,cleanselectedList,fieldIndex);
      UnHideField(sl[x]);
      idx := fRemovedFields.IndexOf(sl[x]);
      if idx > -1 then fRemovedFields.Delete(idx);
      RestfieldProperties(selectedList ,sl[x]);
      if fieldIndex >=0 then begin
        Dataset.FindField(sl[x]).Index := fieldIndex;
        fieldIndex := fieldIndex +1;
      end;
    end;
    selectedList.SaveToGrid(Grid);
  finally
    sl.Free;
    selectedList.Free;
  end;
end;

procedure TwwDbGridGuiElement.RemoveFields(const aFieldList: string);
var
  sl: TStringList;
  x: integer;
  selectedList: TGridFieldList;
begin
  sl := TStringList.Create;
  selectedList := TGridFieldList.Create;
  try
    selectedList.LoadFromGrid(Grid);
    sl.CommaText := aFieldList;
    for x := 0 to sl.Count - 1 do begin
      selectedList.RemoveField(sl[x]);
      HideField(sl[x]);
      if fRemovedFields.IndexOf(sl[x]) < 0 then fRemovedFields.Add(sl[x]);
    end;
    selectedList.SaveToGrid(Grid);
  finally
    sl.Free;
    selectedList.Free;
  end;
end;

procedure TwwDbGridGuiElement.SwitchFields(showFieldName, hideFieldName: string);
var
  idx, fldIdx: integer;
  selectedList: TGridFieldList;
  showFieldRec, hideFieldRec: TGridFieldRec;
begin
  selectedList := TGridFieldList.Create;
  try
    selectedList.Text := Grid.Selected.Text;
    showFieldRec := selectedList.Field[showFieldName];
    hideFieldRec := selectedList.Field[hideFieldName];
    if Assigned(showFieldRec) or Assigned(hideFieldRec) then begin
      fldIdx := -1;
      if Assigned(hideFieldRec) then fldIdx := hideFieldRec.Index;
      selectedList.RemoveField(hideFieldName);
      if not Assigned(showFieldRec) then begin
        selectedList.AddField(showFieldName, Dataset,cleanselectedList);
        if fldIdx > -1 then selectedList.Field[showFieldName].Index := fldIdx;
        UnHideField(showFieldName);
        idx := fRemovedFields.IndexOf(showFieldName);
        if idx > -1 then fRemovedFields.Delete(idx);
        RestfieldProperties(selectedList ,showFieldName);
      end;
      selectedList.SaveToGrid(Grid);
    end;
  finally selectedList.Free;
  end;
end;
function TwwDbGridGuiElement.GetFieldDisplayLabel(fsfieldname: string): String;begin   GetFieldProperty(fsFieldname, 1);end;
function TwwDbGridGuiElement.GetFieldGroupname(fsfieldname: string):String;begin   GetFieldProperty(fsFieldname, 4);end;

function TwwDbGridGuiElement.GetFieldProperty(fsfieldname: string;PropertyPosition :Integer):String;
var
  st: TStringList;
  stfields: TStringList;
  ctr: integer;
  //i: integer;
begin
  if Node['GridFields'].CData = '' then Exit;
  st := TStringList.Create;
  try
    st.Text := Node['GridFields'].CData;
    if st.Count = 0 then Exit;
    stfields := TStringList.Create;
    try
      stfields.Delimiter := #9; { Tab }
      stfields.StrictDelimiter := TRue;
      for ctr := 0 to st.Count - 1 do begin
        stfields.DelimitedText := st[ctr];
        (*i := SearchStringList(stfields, fsfieldname);
        if i >= 0 then begin*)
        if sametext(stfields[0] , fsFieldname) then begin
          if stfields.Count = PropertyPosition+1 then result:= stfields[PropertyPosition] ;
          Exit;
        end;
      end;
    finally FreeAndNil(stfields);
    end;
  finally FreeAndNil(st);
  end;

end;

procedure TwwDbGridGuiElement.setFieldGroupname(fsfieldname: string; const Value: string);begin  setFieldProperty(fsfieldname, Value , 4);end;
procedure TwwDbGridGuiElement.setFieldDisplaylabel(fsfieldname: string; const Value: string);begin  setFieldProperty(fsfieldname, Value , 2);end;

procedure TwwDbGridGuiElement.setFieldProperty(fsfieldname: string; const Value: string; PropertyPosition :Integer);
var
  st: TStringList;
  stfields: TStringList;
  ctr: integer;
  //i: integer;
  s: string;
begin
  if Node['GridFields'].CData = '' then Exit;
  st := TStringList.Create;
  try
    st.Text := Node['GridFields'].CData;
    if st.Count = 0 then Exit;
    stfields := TStringList.Create;
    try
      stfields.Delimiter := #9; { Tab }
      stfields.StrictDelimiter := TRue;
      for ctr := 0 to st.Count - 1 do begin
        stfields.DelimitedText := st[ctr];
        (*i := SearchStringList(stfields, fsfieldname);
        if i >= 0 then begin*)
        if sametext(stfields[0] , fsFieldname) then begin
          s := stfields.Text;
          if stfields.Count = PropertyPosition then stfields.Add(Value)
          else stfields[PropertyPosition] := Value;
          st[ctr] := stfields.DelimitedText(*stfields.Text*);
          Node['GridFields'].CData := st.Text;
          Exit;
        end;
      end;
    finally FreeAndNil(stfields);
    end;
  finally FreeAndNil(st);
  end;
end;



procedure TwwDbGridGuiElement.AddreadonlyField(const FieldName: string);
begin
  fReadonlyFields.Add(FieldName);
end;
function TwwDbGridGuiElement.SelectedEntryProperty(const  sfieldname: String;SelectedEntryPropertytype: TSelectedEntryPropertytype): Variant;
var
  selectedList: TGridFieldList;
  idx: integer;
  Selectedrec : TGridFieldRec;
begin

  selectedList := TGridFieldList.Create;
  try
    selectedList.LoadFromGrid(Grid);
    for idx := 0 to selectedList.Count-1 do begin
      Selectedrec:= selectedList.items[idx];
      if Selectedrec.fieldname =sfieldname then begin
             if SelectedEntryPropertytype = septDisplayWidth  then begin Result := Selectedrec.DisplayWidth; Exit;
        end else if SelectedEntryPropertytype = septDisplayLabel  then begin Result := Selectedrec.DisplayLabel;Exit;
        end else if SelectedEntryPropertytype = septbReadOnly     then begin Result := Selectedrec.Readonly;Exit;
        end else if SelectedEntryPropertytype = septGroupName     then begin Result := Selectedrec.Groupname;Exit;
        end else if SelectedEntryPropertytype = septVisible then begin Result := TRue;exit;
        end;
		Exit;	
      end;
    end;
    selectedList.SaveToGrid(Grid);
  finally selectedList.Free;
  end;

end;

function TwwDbGridGuiElement.SelectedEntryProperty(const NewSelectedText: string;const sfieldname:String; SelectedEntryPropertytype:TSelectedEntryPropertytype):Variant;
var
  GridFieldList: TGridFieldList;
  x: integer;
begin

  GridFieldList := TGridFieldList.Create;
  try
    GridFieldList.Text := NewSelectedText;
    for x := 0 to GridFieldList.Count - 1 do begin
      if SameText(GridFieldList.Items[x].FieldName, sFieldName) then begin
             if SelectedEntryPropertytype = septDisplayWidth  then begin Result := GridFieldList.Items[x].DisplayWidth; Exit;
        end else if SelectedEntryPropertytype = septDisplayLabel  then begin Result := GridFieldList.Items[x].DisplayLabel;Exit;
        end else if SelectedEntryPropertytype = septbReadOnly     then begin Result := GridFieldList.Items[x].Readonly;Exit;
        end else if SelectedEntryPropertytype = septGroupName     then begin Result := GridFieldList.Items[x].Groupname;Exit;
        end else if SelectedEntryPropertytype = septVisible then begin Result := TRue;exit;
        end;
      end;
    end;
    if SelectedEntryPropertytype = septVisible then
      Result := False;
  finally
    GridFieldList.Free;
  end;
end;
Procedure TwwDbGridGuiElement.ReplaceGroupname(const aName, aGroup , aDisplaylabel: string);
var
  newList: TGridFieldList;
begin
   newList := TGridFieldList.Create;
   try
      newList.Text := Node['GridFields'].CData;
      newList.ReplaceGroupname(aName, aGroup, aDisplayLabel);
      Node['GridFields'].CData := newList.Text; // Grid.Selected.Text:= oldList.Text;
   finally
     Freeandnil(newList);
   end;
end;
procedure TwwDbGridGuiElement.UpdateGridSelected(const NewSelectedText: string);
var
  oldList, newList: TGridFieldList;
  oldrec, rec: TGridFieldRec;
  x: integer;

begin
  oldList := TGridFieldList.Create;
  newList := TGridFieldList.Create;
  try
    newList.Text := NewSelectedText;
    oldList.Text := Node['GridFields'].CData;
    for x := 0 to newList.Count - 1 do begin
      oldrec := oldList.FieldByName(newList.Items[x].FieldName);
      if oldrec = nil then begin
        rec := TGridFieldRec(oldList.Add);
        rec.Assign(newList.Items[x]);
      end else begin
        oldList.ReplaceGroupname(newList.Items[x].FieldName, newList.Items[x].groupname, newList.Items[x].DisplayLabel);

      end;
    end;
    x := 0;
    while x < oldList.Count do begin
      if newList.FieldByName(oldList.Items[x].FieldName) = nil then oldList.Delete(x)
      else Inc(x);
    end;
    oldList.Regroup;
    Node['GridFields'].CData := oldList.Text; // Grid.Selected.Text:= oldList.Text;
  finally
    oldList.Free;
    newList.Free;
  end;
end;

{ TBaseListingGuiElement }

constructor TBaseListingGuiElement.Create(aOwner: TComponent);
begin
  inherited;
  fPrefFrameClassName := 'TfrBaseListingGuiEdit';
  fDescription := 'Custom Report';
  fElementPagehint := 'Custom Report';
end;

destructor TBaseListingGuiElement.Destroy;
begin
  inherited;
end;

procedure TBaseListingGuiElement.ApplyGuiPrefs;
begin
  inherited;
end;

procedure TBaseListingGuiElement.SaveGuiPrefs;
begin
  inherited;
end;

procedure TBaseListingGuiElement.SetActive(const Value: boolean);
begin
  inherited;
end;

procedure TBaseListingGuiElement.FirstActivate;
begin
  inherited;
  if not Assigned(BaseListingForm) then Exit;
  if Node.Exists('ListSearchMode') then begin
    TypInfo.SetInt64Prop(BaseListingForm, 'SearchMode', Node['ListSearchMode'].AsInteger);
  end;
end;

function TBaseListingGuiElement.GetBaseListingForm: TForm;
begin
  if Assigned(FormGuiPrefs.Form) and (IsClassByString(FormGuiPrefs.Form, 'TBaseListingGUI')) then Result := FormGuiPrefs.Form
  else Result := nil;
end;

procedure TBaseListingGuiElement.SetGuiDefaults;
begin
  inherited;
end;
function Dotranslation(const Value:String):String;
begin
  Result := TLanguageTranslationObj.Inst.DoTranslate(Value , TLanguageTranslationObj.Inst.UserLanguageId, []);
end;

{ TStockAnalysisGuiElement }

procedure TStockAnalysisGuiElement.ApplyGuiPrefs;
begin
  inherited;
end;

constructor TStockAnalysisGuiElement.Create(aOwner: TComponent);
begin
  inherited;
  fPrefFrameClassName := 'TfrStockAnalysisGuiEdit';
  fDescription := 'Stock Analysis Report';
  fElementPagehint := 'Stock Analysis Report';
end;

destructor TStockAnalysisGuiElement.Destroy;
begin

  inherited;
end;


function TStockAnalysisGuiElement.GetBaseListingForm: TForm;
begin
  if Assigned(FormGuiPrefs.Form) and (IsClassByString(FormGuiPrefs.Form, 'TBaseListingGUI')) then Result := FormGuiPrefs.Form
  else Result := nil;
end;

procedure TStockAnalysisGuiElement.SaveGuiPrefs;
begin
  inherited;

end;

procedure TStockAnalysisGuiElement.SetActive(const Value: boolean);
begin
  inherited;

end;

procedure TStockAnalysisGuiElement.SetGuiDefaults;
begin
  inherited;

end;

{ TAdvStringGridGuiElement }

procedure TAdvStringGridGuiElement.ApplyGridColumnOptions;
var
  x: integer;
begin
  if DoingApplyGridColumnOptions then exit;

  DoingApplyGridColumnOptions := true;
  try
    if Node['ColWidths'].Count > 0 then begin
      for x := 0 to Grid.ColCount -1 do begin
        if Node['ColWidths'].Exists('Col' + IntToStr(x)) then begin
          try
            Grid.ColWidths[x] := Node['ColWidths.Col' + IntToStr(x)].AsInteger;
          except
          end;
        end;
      end;
    end;
  finally
    DoingApplyGridColumnOptions := false;
  end;
end;

procedure TAdvStringGridGuiElement.ApplyGuiPrefs;
begin
  inherited;
  ApplyGridColumnOptions;
end;

procedure TAdvStringGridGuiElement.BeforeSave;
begin
  inherited;
  GetColumnSettings;
end;

constructor TAdvStringGridGuiElement.Create(aOwner: TComponent);
begin
  inherited;
  fDescription := 'Grid';
  DoingApplyGridColumnOptions := false;
end;

destructor TAdvStringGridGuiElement.Destroy;
begin

  inherited;
end;

procedure TAdvStringGridGuiElement.DoColumnSize(Sender: TObject; ACol: Integer;
  var Allow: Boolean);
var
  SavedColumnSizeEvent: TColumnSizeEvent;
begin
  if DoingApplyGridColumnOptions then exit;

  Allow := true;
  TMethod(SavedColumnSizeEvent) := EventHookList.GetMethod(Grid.Name, 'ColumnSizeEvent');

  if Assigned(SavedColumnSizeEvent) then begin
    SavedColumnSizeEvent(Sender, ACol, Allow);
  end;

  //GetColumnSettings;
  //FormGuiPrefs.SavePrefs;
  FormGuiPrefs.Dirty := true;
end;

procedure TAdvStringGridGuiElement.DoColumnSizing(Sender: TObject; ACol,
  ColumnSize: Integer);
var
  SavedColumnSizingEvent: TColumnSizingEvent;
begin
  if DoingApplyGridColumnOptions then exit;

  TMethod(SavedColumnSizingEvent) := EventHookList.GetMethod(Grid.Name, 'ColumnSizingEvent');

  if Assigned(SavedColumnSizingEvent) then begin
    SavedColumnSizingEvent(Sender, ACol, ColumnSize);
  end;

//  GetColumnSettings;
  FormGuiPrefs.Dirty := true;
end;

procedure TAdvStringGridGuiElement.GetColumnSettings;
var
  x: integer;
begin
  for x := 0 to Grid.ColCount -1 do begin
    Node['ColWidths.Col' + IntToStr(x)].AsInteger := Grid.ColWidths[x];
  end;
end;

function TAdvStringGridGuiElement.GetGrid: TAdvStringGrid;
begin
  Result := TAdvStringGrid(Target);
end;

procedure TAdvStringGridGuiElement.SaveGuiPrefs;
begin
  inherited;
  GetColumnSettings;

end;

procedure TAdvStringGridGuiElement.SetActive(const Value: boolean);
begin
  if Value <> fActive then begin
    inherited;

    if fActive then begin
      if Grid <> nil then
        if EventHookList.AddIfNotFound(Grid.Name, 'OnColumnSizing', TMethod(Grid.OnColumnSizing)) then
          Grid.OnColumnSizing := DoColumnSizing;
        if EventHookList.AddIfNotFound(Grid.Name, 'OnColumnSize', TMethod(Grid.OnColumnSize)) then
          Grid.OnColumnSize := DoColumnSize;
    end;

  end;
end;

procedure TAdvStringGridGuiElement.SetTarget(const Value: TComponent);
begin
  inherited;

end;

initialization

RegisterClassOnce(TwwDbGridGuiElement);
RegisterClassOnce(TBaseListingGuiElement);
RegisterClassOnce(TReportonForeignCurrency);
RegisterClassOnce(TStockAnalysisGuiElement);
RegisterClassOnce(TAdvStringGridGuiElement);

finalization

UnRegisterClass(TwwDbGridGuiElement);
UnRegisterClass(TBaseListingGuiElement);
UnRegisterClass(TReportonForeignCurrency);
UnRegisterClass(TStockAnalysisGuiElement);
UnRegisterClass(TAdvStringGridGuiElement);

end.
