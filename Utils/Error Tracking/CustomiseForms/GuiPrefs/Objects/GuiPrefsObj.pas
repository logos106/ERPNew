unit GuiPrefsObj;

interface

uses
  Classes, DataTreeObj, wwDbGrid, DB, Contnrs, forms,
  Graphics;

const
  GUI_PERF_CUSTOM_COLUMN_TAG = 2;
  
type

  PEventHookRec = ^TEventHookRec;
  TEventHookRec = record
    ObjectName,
    EventName: string;
    ObjectMethod: TMethod;
  end;

  TEventHookList = class(Tobject)
  private
    fList: TList;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function Find(Const aObjectName, aEventName: string): PEventHookRec;
    procedure Add(Const aObjectName, aEventName: string; Const aObjectMethod: TMethod);
    procedure AddIfNotFound(Const aObjectName, aEventName: string; Const aObjectMethod: TMethod);
    function GetMethod(Const aObjectName, aEventName: string): TMethod;
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
    fFirstActivate: boolean;
    function GetNode: TDataTreeNode;
    function GetPrefFrameClassName: string;
    function GetTarget: TComponent;
    function GetTargetComponentName: string;
    procedure SetTarget(const Value: TComponent);
    procedure SetTargetComponentName(const Value: string);
    function GetFormGuiPrefs: TFormGuiPrefs;
  protected
    property EventHookList: TEventHookList read fEventHookList;
    procedure SetActive(const Value: Boolean); virtual;
    procedure FirstActivate; virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Active: Boolean read fActive write SetActive;
      // The name of the target component that this element will customise.
    property TargetName: string read GetTargetComponentName write SetTargetComponentName;
      // The target component that this element will customise.
    property Target: TComponent read GetTarget write SetTarget;
      // User friendly name for the component being customised
    property Description: string read fDescription write fDescription;
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
  end;

  TGuiElementClass = class of TGuiElement;

  TGuiElementList = class(TComponent)
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItems(Index: integer): TGuiElement;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddElement(aGuiElement: TGuiElement);
    function Add(Const aGuiElementClassName: string): TGuiElement; overload;
    function Add(Const aGuiElementClassName: string; Const aTarget: TComponent): TGuiElement; overload;
    property Count: integer read GetCount;
    property Items[Index: integer]: TGuiElement read GetItems; default;
  end;

  TFormGuiPrefs = class(TComponent)
  private
    fElements: TGuiElementList;
    fPrefsName: string;
    fNode: TDataTreeNode;
    fUserType: TPrefUserType;
    fUserPrefsOnly: boolean;
    fEnabled: boolean;
    fActive: boolean;
    function GetNode: TDataTreeNode;
    function GetPrefsName: string;
    procedure SetPrefsName(const Value: string);
    function GetDirty: boolean;
    procedure SaveElementsGuiPrefs;
    function GetUserType: TPrefUserType;
    procedure SetUserType(const Value: TPrefUserType);
    procedure SetActive(const Value: boolean);
    function GetForm: TForm;
    procedure SetEnabled(const Value: boolean);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Enabled: boolean read fEnabled write SetEnabled;
    property Active: boolean read fActive write SetActive;
    property UserType: TPrefUserType read GetUserType write SetUserType;
      // List of customisable elements for this form.
    property Elements: TGuiElementList read fElements;
      // Database identifier name.
    property PrefsName: string read GetPrefsName write SetPrefsName;
      // Root node for form customisation GUI data.
    property Node: TDataTreeNode read GetNode; // write SetNode;
      // Load node with current users prefs from database for this forms PrefName
    function LoadPrefs: boolean;
    procedure RevertToGlobalPrefs;
      // save currently loaded prefs node XML back to database for current user
    procedure SavePrefs;
    property Dirty: boolean read GetDirty;
      // Apply GUI customisation to all elements in list.
    procedure ApplyGuiPrefs; virtual;
    property UserPrefsOnly: boolean read fUserPrefsOnly write fUserPrefsOnly;
    procedure ShowCustomiseForm;
    property Form: TForm read GetForm;
  end;

  TwwDbGridGuiElement = class(TGuiElement)
  private
    procedure DoOnCalcFields(Dataset: TDataset);
    procedure DoOnColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure DoOnColWidthChanged(Sender: TObject; Column: Integer);
    procedure DoBeforeOpen(Dataset: TDataset);
    procedure DoAfterOpen(Dataset: TDataset);
    function GetColumns: TDataTreeNode;
    function GetCustomColumns: TDataTreeNode;
    function GetDataset: TDataset;
    function GetGrid: TwwDbGrid;
    procedure ApplyGridColumnOptions(RemoveIfNotFound: boolean = False);
    procedure ApplyGeneralGridOptions;
  protected
    procedure SetActive(const Value: Boolean); override;
    property Columns: TDataTreeNode read GetColumns;
    property CustomColumns: TDataTreeNode read GetCustomColumns;
    property Grid: TwwDbGrid read GetGrid;
    property Dataset: TDataset read GetDataset;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveGuiPrefs; override;
    procedure ApplyGuiPrefs; override;
    procedure GetColumnSettings;
    procedure GetGridOptions;
    function DatasetHasPersistantFields: boolean;
    procedure SetGuiDefaults; override;
  end;
  procedure FontToNode(Font: TFont; Node: TDataTreeNode);
  procedure NodeToFont(Node: TDataTreeNode; Font: TFont);


implementation

uses
  SysUtils, UserInfoObj, frmFormGuiPrefsEdit, dialogs,
  Grids, Wwdbigrd,FastFuncs;

const
  GUI_PREF_GROUP = 'GuiPrefs';

procedure FontToNode(Font: TFont; Node: TDataTreeNode);

  function FontStyleToStr(Style: TFontStyles): string;
  begin
    result:= '';
    if fsBold in Style then begin
      if result <> '' then result:= result + ',';
      result:= result + 'fsBold';
    end;
    if fsItalic in Style then begin
      if result <> '' then result:= result + ',';
      result:= result + 'fsItalic';
    end;
    if fsUnderline in Style then begin
      if result <> '' then result:= result + ',';
      result:= result + 'fsUnderline';
    end;
    if fsStrikeOut in Style then begin
      if result <> '' then result:= result + ',';
      result:= result + 'fsStrikeOut';
    end;
  end;

begin
  Node['Name'].AsString:= Font.Name;
  Node['Size'].AsInteger:= Font.Size;
  Node['Color'].AsInteger:= Font.Color;
  Node['Style'].AsSTring:= FontStyleToStr(Font.Style);
end;

procedure NodeToFont(Node: TDataTreeNode; Font: TFont);
var
  s: string;
begin
  if node.Exists('Name') then
    Font.Name:= Node['Name'].AsString;
  if node.Exists('Size') then
    Font.Size:= Node['Size'].AsInteger;
  if node.Exists('Color') then
    Font.Color:= Node['Color'].AsInteger;
  if node.Exists('Style') then begin
    s:= Node['Style'].AsString;
    if FastFuncs.PosEx('fsBold',s) > 0 then
      Font.Style := Font.Style + [fsBold]
    else
      Font.Style := Font.Style - [fsBold];
    if FastFuncs.PosEx('fsItalic',s) > 0 then
      Font.Style := Font.Style + [fsItalic]
    else
      Font.Style := Font.Style - [fsItalic];
    if FastFuncs.PosEx('fsUnderline',s) > 0 then
      Font.Style := Font.Style + [fsUnderline]
    else
      Font.Style := Font.Style - [fsUnderline];
    if FastFuncs.PosEx('fsStrikeOut',s) > 0 then
      Font.Style := Font.Style + [fsStrikeOut]
    else
      Font.Style := Font.Style - [fsStrikeOut];
  end;
end;

//------------------------------------------------------------------------------
{ TEventHookList }
//------------------------------------------------------------------------------

constructor TEventHookList.Create;
begin
  fList:= TList.Create;
end;

destructor TEventHookList.Destroy;
begin
  while fList.Count > 0 do begin
    Dispose(PEventHookRec(fList[0]));
    fList.Delete(0);
  end;
  fList.Free;
  inherited;
end;

procedure TEventHookList.Add(Const aObjectName, aEventName: string; Const aObjectMethod: TMethod);
var
  PRec: PEventHookRec;
begin
  New(Prec);
  Prec^.ObjectName:= aObjectName;
  Prec^.EventName:= aEventName;
  Prec^.ObjectMethod:= aObjectMethod;
  fList.Add(Prec);
end;

function TEventHookList.Find(Const aObjectName, aEventName: string): PEventHookRec;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to fList.Count -1 do begin
    if (PEventHookRec(fList[x])^.ObjectName = aObjectName) and
       (PEventHookRec(fList[x])^.EventName = aEventName) then begin
      result:= PEventHookRec(fList[x]);
      Break;
    end;
  end;
end;

function TEventHookList.GetMethod(Const aObjectName, aEventName: string): TMethod;
var
  PRec: PEventHookRec;
begin
  PRec:= Find(aObjectName, aEventName);
  if Assigned(PRec) then
    result:= PRec^.ObjectMethod
  else begin
    result.Code:= nil;
    result.Data:= nil;
  end;
end;

procedure TEventHookList.AddIfNotFound(Const aObjectName, aEventName: string; Const aObjectMethod: TMethod);
begin
  if not Assigned(Find(aObjectName, aEventName)) then begin
    //Log('TEventHookList.AddIfNotFound(' + aObjectName + ',' + aEventName + ',' +
    //  FastFuncs.IntToStr(Integer(AObjectMethod.Code)) + '/' + FastFuncs.IntToStr(Integer(AObjectMethod.Data))+')');
    Add(aObjectName, aEventName, aObjectMethod);
  end;  
end;

//------------------------------------------------------------------------------
{ TGuiElement }
//------------------------------------------------------------------------------

constructor TGuiElement.Create(AOwner: TComponent);
begin
  inherited;
  fActive:= false;
  fTargetName:= '';
  fTarget:= nil;
  fElementList:= nil;
  fPrefFrameClassName:= '';
  fDescription:= '';
  fFirstActivate:= true;
  fEventHookList:= TEventHookList.Create;;
end;

destructor TGuiElement.Destroy;
begin
  fEventHookList.Free;
  inherited;
end;

procedure TGuiElement.SetActive(const Value: Boolean);
begin
  fActive := Value;
  if fActive and fFirstActivate then begin
    self.FirstActivate;
    fFirstActivate:= false;
  end;
end;

procedure TGuiElement.FirstActivate;
begin
  // implement in descendants
end;

function TGuiElement.GetNode: TDataTreeNode;
begin
  if (TargetName <> '') and (Assigned(ElementList.Owner)) then
    result:= TFormGuiPrefs(ElementList.Owner).Node[TargetName]
  else
    result:= nil;
end;

function TGuiElement.GetPrefFrameClassName: string;
begin
  if fPrefFrameClassName <> '' then
    result:= fPrefFrameClassName
  else if TargetName <> '' then
    result:= 'frame' + self.TargetName
  else
    result:= '';
end;

function TGuiElement.GetTarget: TComponent;
begin
  if not Assigned(fTarget) and (fTargetName  <> '') then begin
    // find component on form
    if Assigned(ElementList.Owner.Owner) then
      fTarget:= ElementList.Owner.Owner.FindComponent(fTargetName);
  end;
  result:= fTarget;
end;

function TGuiElement.GetTargetComponentName: string;
begin
  result:= fTargetName;
end;

procedure TGuiElement.SetTarget(const Value: TComponent);
begin
  fTarget:= Value;
  fTargetName:= Value.Name;
  if fDescription = '' then
    fDescription:= fTarget.Name;
end;

procedure TGuiElement.SetTargetComponentName(const Value: string);
begin
  fTargetName:= Value;
  fTarget:= nil;
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
  if ElementList.Owner is TFormGuiPrefs then
    result:= TFormGuiPrefs(ElementList.Owner)
  else
    result:= nil;
end;

procedure TGuiElement.SetGuiDefaults;
begin
  // implement in descendants
end;

//------------------------------------------------------------------------------
{ TGuiElementList }
//------------------------------------------------------------------------------

constructor TGuiElementList.Create(AOwner: TComponent);
begin
  inherited;
  fList:= TObjectList.Create;
  fList.OwnsObjects:= true;
end;

destructor TGuiElementList.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TGuiElementList.AddElement(aGuiElement: TGuiElement);
var x: integer;
begin
  x:= fList.Add(aGuiElement);
  if not Assigned(TGuiElement(fLIst[x]).ElementList) then
    TGuiElement(fLIst[x]).ElementList:= self;
end;

function TGuiElementList.Add(Const aGuiElementClassName: string): TGuiElement;
var
  Cls: TPersistentClass;
begin
  try
    Cls:= FindClass(aGuiElementClassName);
    result:= TGuiElementClass(Cls).Create(nil);
    result.ElementList:= self;
    fList.Add(result);
  except
    raise;
  end;
end;

function TGuiElementList.Add(Const aGuiElementClassName: string; Const aTarget: TComponent): TGuiElement;
begin
  result:= Add(aGuiElementClassName);
  if Assigned(result) then
    result.Target:= aTarget;
end;

function TGuiElementList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TGuiElementList.GetItems(Index: integer): TGuiElement;
begin
  result:= TGuiElement(fList[Index]);
end;

//------------------------------------------------------------------------------
{ TFormGuiPrefs }
//------------------------------------------------------------------------------

constructor TFormGuiPrefs.Create(AOwner: TComponent);
begin
  inherited;
  fEnabled:= true;
  fActive:= false;
  fElements:= TGuiElementList.Create(self);
  fPrefsName:= '';
  fNode:= nil;
  fUserType:= puUser;
  fUserPrefsOnly:= false;
end;

destructor TFormGuiPrefs.Destroy;
begin
  if Assigned(fNode) then begin
    if Dirty then
      fNode.Storer.Save;
    fNode.Free;
  end;
  inherited;
end;

procedure TFormGuiPrefs.SetEnabled(const Value: boolean);
begin
  if fActive and (Value = false) then
    raise Exception.Create('Can not disable while TFormGuiPrefs is Active.')
  else
    fEnabled := Value;
end;

procedure TFormGuiPrefs.SetActive(const Value: boolean);
var
  x: integer;
begin
  if not fEnabled then exit;
  fActive := Value;
  if fActive then
    Self.LoadPrefs;
  for x:= 0 to self.Elements.Count -1 do begin
    Elements[x].Active:= Value;
  end;
  ApplyGuiPrefs;
end;

function TFormGuiPrefs.GetNode: TDataTreeNode;
begin
  if not Assigned(fNode) then
    fNode:= TDataTreeNode.Create;
  result:= fNode;
end;

function TFormGuiPrefs.GetPrefsName: string;
begin
  if not fEnabled then exit;
  if fPrefsName = '' then begin
    if Assigned(owner) then
      fPrefsName:= Owner.ClassName;
  end;
  result:= fPrefsName;
end;

function TFormGuiPrefs.LoadPrefs: boolean;
var
  UserId: integer;
  x: integer;
begin
  result:= false;
  if not fEnabled then exit;
  if PrefsName = '' then exit;
  if fUserType = puGlobal then begin
    UserId:= 0;
    result:= Node.Storer.Load(UserId, GUI_PREF_GROUP, PrefsName);
    if Node.NodeName = '' then
      Node.NodeName:= PrefsName;
    // if there are no global settings save the current UI settings back as global
    if not result then begin
      SaveElementsGuiPrefs;
      Node.Storer.Save;
    end;
  end
  else if fUserType = puUser then begin
    UserId:= UserInfo.UserID;
    result:= Node.Storer.Load( UserId, GUI_PREF_GROUP, PrefsName);
    if not result then begin
      UserId:= 0;

      // get global prefs ...
      result:= Node.Storer.Load( UserId, GUI_PREF_GROUP, PrefsName);
      if Node.NodeName = '' then
        Node.NodeName:= PrefsName;

      // if there are no global settings save the current UI settings back as global
      // (NOTE global means all the GUI settings for all users for this form class)
      if not result then begin
        // grab the current settings for this form and save as the default for
        // this form class for all users
        SaveElementsGuiPrefs;
        // load any default Gui settings for each Gui element
        for x:= 0 to Elements.Count -1 do
          Elements[x].SetGuiDefaults;
        Node.Storer.Save;
      end;

      // and save back for this user
      Node.Storer.UserId:= UserInfo.UserID;
      Node.Storer.Save;
    end;
  end;
end;

procedure TFormGuiPrefs.RevertToGlobalPrefs;
var
  UserId: integer;
begin
  if not fEnabled then exit;
  if PrefsName = '' then exit;
  UserId:= 0;
  // get global prefs ...
  Node.Storer.Load( UserId, GUI_PREF_GROUP, PrefsName);
  if Node.NodeName = '' then
    Node.NodeName:= PrefsName;

  Node.Storer.UserId:= UserInfo.UserID;
  // and save back for this user
  Node.Storer.Save;
end;

procedure TFormGuiPrefs.SavePrefs;
var
  UserId: integer;
begin
  if not fEnabled then exit;
  if PrefsName = '' then exit;
  //Node.Storer.Save;
  if fUserType = puUser then
    UserId:= UserInfo.UserID
  else
    UserId:= 0;
  Node.Storer.Save( UserId, GUI_PREF_GROUP, PrefsName);
end;

procedure TFormGuiPrefs.SetPrefsName(const Value: string);
begin
  if not fEnabled then exit;
  if fPrefsName <> Value then begin
    // This is a custom list view so set this true to prevent user from
    // trying to set global (ie default) prefs
    fUserPrefsOnly:= true;
    fPrefsName:= Value;
    if fActive then begin
      Active:= False;
      Active:= true;
    end;
  end;
end;

procedure TFormGuiPrefs.ApplyGuiPrefs;
var
  x: integer;
begin
  if not fEnabled then exit;
  for x:= 0 to Elements.Count -1 do begin
    Elements[x].ApplyGuiPrefs;
  end;
end;

procedure TFormGuiPrefs.ShowCustomiseForm;
begin
  if not fEnabled then exit;
  with TfmFormGuiPrefsEdit.Create(Application) do begin
    FormGuiPrefs:= self;
    ShowModal;
  end;
end;

function TFormGuiPrefs.GetDirty: boolean;
begin
  result:= false;
  if Assigned(fNode) and fNode.Dirty then
    result:= true;
end;

procedure TFormGuiPrefs.SaveElementsGuiPrefs;
var
  x: integer;
begin
  if not fEnabled then exit;
  for x:= 0 to Elements.Count -1 do begin
    Elements[x].SaveGuiPrefs;
  end;
end;

function TFormGuiPrefs.GetUserType: TPrefUserType;
begin
  result:= self.fUserType;
end;

procedure TFormGuiPrefs.SetUserType(const Value: TPrefUserType);
begin
  if not fEnabled then exit;
  if Value <> fUserType then begin
    fUserType:= Value;
    // reload data
    self.LoadPrefs;
    if fUserType = puGlobal then
      TForm(Owner).Caption:= TForm(Owner).Caption + ' [Global Customisation]'
    else
      TForm(Owner).Caption:= FastFuncs.AnsiStringReplace(TForm(Owner).Caption, ' [Global Customisation]', '',[rfReplaceAll]);
  end;
end;

function TFormGuiPrefs.GetForm: TForm;
begin
  if Owner is TForm then
    result:= TForm(Owner)
  else
    result:= nil;
end;

//------------------------------------------------------------------------------
{ TwwDbGridGuiElement }
//------------------------------------------------------------------------------

constructor TwwDbGridGuiElement.Create(AOwner: TComponent);
begin
  inherited;
  fPrefFrameClassName:= 'TfrWwDbGridGuiEdit';
  fDescription:= 'Grid';
end;

destructor TwwDbGridGuiElement.Destroy;
begin
  inherited;
end;

procedure TwwDbGridGuiElement.SetActive(const Value: Boolean);
begin
  inherited;
  if fActive then begin
    // hook the events we need
    //Log('TwwDbGridGuiElement.SetActive ----------');
    //Log('TwwDbGridGuiElement.SetActive Adding ' + Dataset.Owner.ClassName + ' Event OnCalcFields');
    EventHookList.AddIfNotFound(Dataset.Name, 'OnCalcFields', TMethod(Dataset.OnCalcFields));
    Dataset.OnCalcFields:= DoOnCalcFields;

    //Log('TwwDbGridGuiElement.SetActive Adding ' + Dataset.Owner.ClassName + ' Event OnColumnMoved');
    EventHookList.AddIfNotFound(Grid.Name, 'OnColumnMoved', TMethod(Grid.OnColumnMoved));
    Grid.OnColumnMoved:= DoOnColumnMoved;

    //Log('TwwDbGridGuiElement.SetActive Adding ' + Dataset.Owner.ClassName + ' Event OnColWidthChanged');
    EventHookList.AddIfNotFound(Grid.Name, 'OnColWidthChanged', TMethod(Grid.OnColWidthChanged));
    Grid.OnColWidthChanged:= DoOnColWidthChanged;

    //Log('TwwDbGridGuiElement.SetActive Adding ' + Dataset.Owner.ClassName + ' Event BeforeOpen');
    EventHookList.AddIfNotFound(Dataset.Name, 'BeforeOpen', TMethod(Dataset.BeforeOpen));
    Dataset.BeforeOpen:= DoBeforeOpen;

    //Log('TwwDbGridGuiElement.SetActive Adding ' + Dataset.Owner.ClassName + ' Event AfterOpen');
    EventHookList.AddIfNotFound(Dataset.Name, 'AfterOpen', TMethod(Dataset.AfterOpen));
    Dataset.AfterOpen:= DoAfterOpen;
  end;
end;

function TwwDbGridGuiElement.GetColumns: TDataTreeNode;
begin
  result:= node['Columns'];
end;

function TwwDbGridGuiElement.GetCustomColumns: TDataTreeNode;
begin
  result:= node['CustomColumns'];
end;

function TwwDbGridGuiElement.GetDataset: TDataset;
begin
  try
    result:= Grid.DataSource.DataSet;
  except
    result:= nil;
  end;
end;

function TwwDbGridGuiElement.GetGrid: TwwDbGrid;
begin
  result:= TwwDbGrid(Target);
end;

procedure TwwDbGridGuiElement.GetColumnSettings;
var
  x: integer;
  FieldIndex: integer;
begin
  if (not Assigned(Dataset)) then exit;
  // get column info starting with visible colums
  FieldIndex:= 0;
  for x:= 0 to Dataset.FieldCount -1 do begin
    if Dataset.Fields[x].Visible then begin
      Columns[Dataset.Fields[x].FieldName + '.Visible'].AsBoolean:= true;
      Columns[Dataset.Fields[x].FieldName + '.Index'].AsInteger:= FieldIndex;
      Columns[Dataset.Fields[x].FieldName + '.DisplayWidth'].AsInteger:=
        Dataset.Fields[x].DisplayWidth;
      Inc(FieldIndex);
    end;
  end;

  for x:= 0 to Dataset.FieldCount -1 do begin
    if not Dataset.Fields[x].Visible then begin
      Columns[Dataset.Fields[x].FieldName + '.Visible'].AsBoolean:= false;
      Columns[Dataset.Fields[x].FieldName + '.Index'].AsInteger:= FieldIndex;
      Columns[Dataset.Fields[x].FieldName + '.DisplayWidth'].AsInteger:=
        Dataset.Fields[x].DisplayWidth;
      Inc(FieldIndex);
    end;
  end;
end;

procedure TwwDbGridGuiElement.GetGridOptions;
begin
  // save grid option settings back to node
  FontToNode(Grid.TitleFont, Node['TitleFont']);
  FontToNode(Grid.Font, Node['Font']);
  Node['ShowGridLines'].AsBoolean:= dgColLines in Grid.Options;
  Node['AlternatingRowColor'].AsInteger := Grid.PaintOptions.AlternatingRowColor;
end;

procedure TwwDbGridGuiElement.DoOnCalcFields(Dataset: TDataset);
var
  SavedOnCalcFields: TDatasetNotifyEvent;
begin
  TMethod(SavedOnCalcFields):= EventHookList.GetMethod(Dataset.Name, 'OnCalcFields');
  if Assigned(SavedOnCalcFields) then begin
    SavedOnCalcFields(Dataset);
  end;
end;

procedure TwwDbGridGuiElement.DoOnColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var
  SavedMoveEvent: TMovedEvent;
begin
  TMethod(SavedMoveEvent):= EventHookList.GetMethod(Grid.Name, 'OnColumnMoved');
  if Assigned(SavedMoveEvent) then begin
    SavedMoveEvent(Sender, FromIndex, ToIndex);
  end;
  GetColumnSettings;
end;

procedure TwwDbGridGuiElement.DoOnColWidthChanged(Sender: TObject;
  Column: Integer);
var
  SavedWidthChangedEvent: TColWidthChangedEvent;
begin
  TMethod(SavedWidthChangedEvent):= EventHookList.GetMethod(Grid.Name, 'OnColWidthChanged');
  if Assigned(SavedWidthChangedEvent) then begin
    SavedWidthChangedEvent(Sender, Column);
  end;
  GetColumnSettings;
end;

procedure TwwDbGridGuiElement.DoBeforeOpen(Dataset: TDataset);
var
  SavedBeforeOpen: TDatasetNotifyEvent;
begin
  // first call any existing event handler
  TMethod(SavedBeforeOpen):= EventHookList.GetMethod(Dataset.Name, 'BeforeOpen');
  if Assigned(SavedBeforeOpen) then begin
    SavedBeforeOpen(Dataset);
  end;
end;

procedure TwwDbGridGuiElement.DoAfterOpen(Dataset: TDataset);
var
  SavedAfterOpen: TDatasetNotifyEvent;
begin
  // we need to apply custom column settings each time the grid dataset is opened

  // first call any existing event handler
  TMethod(SavedAfterOpen):= EventHookList.GetMethod(Dataset.Name, 'AfterOpen');
  if Assigned(SavedAfterOpen) then begin
    SavedAfterOpen(Dataset);
  end;

  // re-apply column settings
  ApplyGridColumnOptions(True);
end;

procedure TwwDbGridGuiElement.SaveGuiPrefs;
begin
  inherited;
  GetColumnSettings;
  GetGridOptions;
end;

procedure TwwDbGridGuiElement.ApplyGuiPrefs;
begin
  inherited;
  if (not Active) or (not Assigned(Target)) then exit;

  ApplyGeneralGridOptions;
  ApplyGridColumnOptions(False);
end;

procedure TwwDbGridGuiElement.ApplyGeneralGridOptions;
begin
  if not Assigned(Target) then exit;
  // set fonts etc
  NodeToFont(Node['Font'], Grid.Font);
  NodeToFont(Node['TitleFont'], Grid.TitleFont);
  if Node.Exists('ShowGridLines') then begin
    if Node['ShowGridLines'].AsBoolean then
      Grid.Options:= Grid.Options + [dgColLines, dgRowLines]
    else
      Grid.Options:= Grid.Options - [dgColLines, dgRowLines];
  end;
  if Node.Exists('AlternatingRowColor') then begin
    Grid.PaintOptions.AlternatingRowColor:= Node['AlternatingRowColor'].AsInteger;
  end;
end;

procedure TwwDbGridGuiElement.ApplyGridColumnOptions(RemoveIfNotFound: boolean = False);
var
  x: integer;
  ColField: TField;
  DisplayWidth: integer;
  ColumnsVisible: boolean;
begin
  if not Assigned(Target) or (not Dataset.Active) then exit;

  // Set visible columns and widths
  ColumnsVisible:= false;
  x:= 0;
  while x < Columns.Count do begin
    ColField:= Dataset.FindField(Columns.Items[x].NodeName);
    if Assigned(ColField) then begin
      ColField.Index:= Columns.Items[x].ItemByName['Index'].AsInteger;
      ColField.Visible:= Columns.Items[x].ItemByName['Visible'].AsBoolean;
      if ColField.Visible then
        ColumnsVisible:= true;
      DisplayWidth:= Columns.Items[x].ItemByName['DisplayWidth'].AsInteger;
      if ColField.Visible and (DisplayWidth > 0) and
                              (ColField.DisplayWidth <> DisplayWidth) then begin
        ColField.DisplayWidth:= DisplayWidth;
      end;
      Inc(x);
    end
    else begin
      if RemoveIfNotFound then begin
        CustomColumns.DeleteByName(Columns.Items[x].ItemByName['Name'].AsString);
        Columns.Delete(x);
      end
      else
        Inc(x);
    end;
  end;

//  // hide any "key" fields
//  for x:= 0 to Dataset.FieldCount -1 do begin
//    if TDbPrimaryKeys.TableKeyExists(Dataset.Fields[x].FieldName) then
//      Dataset.Fields[x].visible:= false;
//  end;
//  TDbPrimaryKeys.FreeMe;

  // make sure that at least one column is visible
  if not ColumnsVisible then
    Dataset.Fields[0].Visible:= true;
end;

function TwwDbGridGuiElement.DatasetHasPersistantFields: boolean;
var
  x: integer;
begin
  result:= true;
  if (not Assigned(Dataset)) then exit;
  if not Assigned(Target) then exit;
  for x:= 0 to Dataset.FieldCount -1 do begin
    if Dataset.Fields[x].Name = '' then begin
      result:= false;
      Break;
    end;
  end;
end;

procedure TwwDbGridGuiElement.SetGuiDefaults;
var
  x, ColIndex: integer;
  ColumnReindexRequired: boolean;
begin
  inherited;
  if (not Assigned(Dataset)) then exit;
  // By default hide all columns that are keys
  ColumnReindexRequired:= false;
//  for x:= 0 to Dataset.FieldCount -1 do begin
//    if TDbPrimaryKeys.TableKeyExists(Dataset.Fields[x].FieldName) and
//        Columns[Dataset.Fields[x].FieldName + '.Visible'].AsBoolean then begin
//      Columns[Dataset.Fields[x].FieldName + '.Visible'].AsBoolean := false;
//      ColumnReindexRequired:= true;
//    end;
//  end;
//  TDbPrimaryKeys.FreeMe;

  if ColumnReindexRequired then begin
    ColIndex:= 0;
    for x:= 0 to Columns.Count -1 do
      if Columns.Items[x].ItemByName['Visible'].AsBoolean then begin
        Columns.Items[x].ItemByName['Index'].AsInteger:= ColIndex;
        Inc(ColIndex);
      end;
    for x:= 0 to Columns.Count -1 do
      if not Columns.Items[x].ItemByName['Visible'].AsBoolean then begin
        Columns.Items[x].ItemByName['Index'].AsInteger:= ColIndex;
        Inc(ColIndex);
      end;
  end;
end;


////------------------------------------------------------------------------------
//{ TBaseListingGuiElement }
////------------------------------------------------------------------------------
//
//constructor TBaseListingGuiElement.Create(AOwner: TComponent);
//begin
//  inherited;
//  fPrefFrameClassName:= 'TfrBaseListingGuiEdit';
//  fDescription:= 'Custom Report';
//end;
//
//destructor TBaseListingGuiElement.Destroy;
//begin
//
//  inherited;
//end;
//
//procedure TBaseListingGuiElement.ApplyGuiPrefs;
//begin
//  inherited;
//end;
//
//procedure TBaseListingGuiElement.SaveGuiPrefs;
//begin
//  inherited;
//
//end;
//
//procedure TBaseListingGuiElement.SetActive(const Value: Boolean);
//begin
//  inherited;
////  if fActive then begin
////    // hook the events we need
////
////    EventHookList.AddIfNotFound(TBaseListingGUI(BaseListingForm).btnSearchEngine.Name, 'OnClick',
////      TMethod(TBaseListingGUI(BaseListingForm).btnSearchEngine.OnClick));
////    TBaseListingGUI(BaseListingForm).btnSearchEngine.OnClick:= DoSearchEngineClick;
////  end;
//end;
//
//procedure TBaseListingGuiElement.DoSearchEngineClick(Sender: TObject);
//var
//  SavedOnClick: TNotifyEvent;
//begin
////  TMethod(SavedOnClick):= EventHookList.GetMethod(TBaseListingGUI(BaseListingForm).btnSearchEngine.Name, 'OnClick');
////  if Assigned(SavedOnClick) then begin
////    SavedOnClick(Sender);
////  end;
//
//  // save the mode the user has just selected so form opens in this mode
////  Node['ListSearchMode'].AsInteger:= Ord(TBaseListingGUI(BaseListingForm).SearchMode);
//end;
//
//procedure TBaseListingGuiElement.FirstActivate;
//begin
//  inherited;
//  if not Assigned(BaseListingForm) then exit;
////  if Node.Exists('ListSearchMode') then begin
////    TBaseListingGUI(BaseListingForm).SearchMode:=
////      TBaseListingSearchMode(Node['ListSearchMode'].AsInteger);
////  end;
//end;
//
//function TBaseListingGuiElement.GetBaseListingForm: TForm;
//begin
//  if Assigned(FormGuiPrefs.Form) and
//     (FormGuiPrefs.Form is TBaseListingGUI) then
//    result:= TBaseListingGUI(FormGuiPrefs.Form)
//  else
//    result:= nil;
//end;
//
//procedure TBaseListingGuiElement.SetGuiDefaults;
//var
//  DefaultGuiPrefsNode: TDataTreeNode;
//begin
//  inherited;
//
//  // get default settings that are to be used for all grids
//  DefaultGuiPrefsNode:= TDataTreeNode.Create;
//  try
//    // get company wide global settings if they exist
//    if DefaultGuiPrefsNode.Storer.Load(0,
//                                       GUI_PREF_GROUP,
//                                       DEFAULT_USER_PREFSNAME_BASE_LISTING) then
//    begin
//      Node['TitleFont'].XML:= DefaultGuiPrefsNode['grdMain.TitleFont'].XML;
//      Node['Font'].XML:= DefaultGuiPrefsNode['grdMain.Font'].XML;
//      Node['ShowGridLines'].asBoolean:= DefaultGuiPrefsNode['grdMain.ShowGridLines'].asBoolean;
//      Node['AlternatingRowColor'].asInteger:= DefaultGuiPrefsNode['grdMain.AlternatingRowColor'].asInteger;
//    end;
//
//    // get user global settings if they exist
//    if DefaultGuiPrefsNode.Storer.Load(UserInfo.UserID,
//                                       GUI_PREF_GROUP,
//                                       DEFAULT_USER_PREFSNAME_BASE_LISTING) then
//    begin
//      Node['TitleFont'].XML:= DefaultGuiPrefsNode['grdMain.TitleFont'].XML;
//      Node['Font'].XML:= DefaultGuiPrefsNode['grdMain.Font'].XML;
//      Node['ShowGridLines'].asBoolean:= DefaultGuiPrefsNode['grdMain.ShowGridLines'].asBoolean;
//      Node['AlternatingRowColor'].asInteger:= DefaultGuiPrefsNode['grdMain.AlternatingRowColor'].asInteger;
//    end;
//  finally
//    DefaultGuiPrefsNode.Free;
//  end;
//end;

initialization
  RegisterClass(TwwDbGridGuiElement);
 // RegisterClass(TBaseListingGuiElement);

finalization
  UnregisterClass(TwwDbGridGuiElement);
 // UnregisterClass(TBaseListingGuiElement);

end.

