unit SearchEngineObj;
{
 This object will be used with DBLookupCombo
 Original SQL Must have WHERE clause in it
 SearchLookupFields must not have any spaces (or may have spaces in double quotes)
   and should be semicoloumn (;) separated 

 MEMO: Create Object and set properties in OnFormCreate;
       HandleSwitchKeys in OnFormKeyUp;
       Free in OnFormDestroy;



 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 06/01/06  1.00.01  AL  Initial Version.
 }

interface

uses classes, sysutils, StrUtils, DB;

type
  TSearchEngineObjMode = (smFullList, smStartsWith, smLike);
  TNotInListEvent      = procedure(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean) of object;
  TComboKeyDownEvent = procedure(Sender: TObject; var Key: word; Shift: TShiftState) of object;
  TComboEnterEvent = procedure(Sender: TObject) of object;
  TComboExitEvent  = procedure(Sender: TObject) of object;

  TSearchEngineObj = class(TComponent)
  private
    fbOriginalGridEnterToTab: boolean;
    fbSwitchKeyHit: boolean;
    fbFirstModeSet: boolean;
    fbCanFocusCombo: boolean;
    fsComboName: string;
    fsSearchLookupFields: TStringList;
    fSearchMethod: TNotifyEvent;
    fsModifiedSQL: string;
    fsOriginalSQL: string;
    fsFilterStr: string;
    fsmMode: TSearchEngineObjMode;
    fsQueryName: string;
    fsGridName: string;
    fsGridFieldName: string;
    fsDisplayLabel_StartsWith: string;
    fsDisplayLabel_Like: string;
    fsDisplayLabel_FullList: string;
    fOriginalComboNotInList: TNotInListEvent;
    fsLabelEnd: string;
    fsDisplayLabel: string;
    fbActive: boolean;
    fOriginalComboKeyDown: TComboKeyDownEvent;
    fOriginalComboEnter: TComboEnterEvent;
    fOriginalComboExit: TComboExitEvent;
    procedure SetMode(const Value: TSearchEngineObjMode);
    //    procedure OnComboExit(Sender: Tobject);
    procedure SetGridName(const Value: string);
    //procedure ProductXNotInListSearchMode(Sender: TObject;LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    //    function SubQueryCount: integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property OriginalSQL: string read fsOriginalSQL write fsOriginalSQL;
    property ModifiedSQL: string read fsModifiedSQL;
    property ComboName: string read fsComboName write fsComboName;
    property GridName: string read fsGridName write SetGridName;
    property GridFieldName: string read fsGridFieldName write fsGridFieldName;
    property SearchLookupFields: TStringList read fsSearchLookupFields write fsSearchLookupFields; // should be semicolumn separated
    property SearchMethod: TNotifyEvent read fSearchMethod write fSearchMethod;
    property QueryName: string read fsQueryName write fsQueryName;
    property FilterStr: string read fsFilterStr write fsFilterStr;
    property Mode: TSearchEngineObjMode read fsmMode write SetMode;
    property DisplayLabel: string read fsDisplayLabel write fsDisplayLabel;
    property DisplayLabel_FullList: string read fsDisplayLabel_FullList write fsDisplayLabel_FullList;
    property DisplayLabel_StartsWith: string read fsDisplayLabel_StartsWith write fsDisplayLabel_StartsWith;
    property DisplayLabel_Like: string read fsDisplayLabel_Like write fsDisplayLabel_Like;
    property OriginalComboNotInList: TNotInListEvent read fOriginalComboNotInList write fOriginalComboNotInList;
    property OriginalComboKeyDown: TComboKeyDownEvent read fOriginalComboKeyDown write fOriginalComboKeyDown;
    property OriginalComboEnter: TComboEnterEvent read fOriginalComboEnter write fOriginalComboEnter;
    property OriginalComboExit: TComboExitEvent read fOriginalComboExit write fOriginalComboExit;
    property LabelEnd: string read fsLabelEnd write fsLabelEnd;
    property Active: boolean read fbActive write fbActive;
    procedure DoSearch;
    procedure ModifySQL;
    procedure HandleSwitchKeys(Key: word);
    procedure ComboEnter(Sender: TObject);
    procedure ComboExit(Sender: TObject);
    procedure ProductXNotInListSearchMode(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure ComboKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure SetComboKeyDown;
    procedure SetComboEnter;
    procedure SetComboExit;
  end;

implementation

uses FastFuncs, wwDBLook, MyAccess,  CommonLib, windows, wwDBGrid, wwDbiGrd, Forms;

{ TSearchEngineObj }

procedure TSearchEngineObj.ProductXNotInListSearchMode(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  SetControlFocus(TwwDBLookupCombo(Owner.FindComponent(ComboName)));
  TwwDBLookupCombo(Owner.FindComponent(ComboName)).DropDown;
  Accept := false;
end;

constructor TSearchEngineObj.Create(AOwner: TComponent);
begin
  fsFilterStr := '';
  fsDisplayLabel := 'Name';
  fsDisplayLabel_StartsWith := ' (Starts With)';
  fsDisplayLabel_Like := ' (Like)';
  fsDisplayLabel_FullList := ' (Full List)';
  fbCanFocusCombo := false;
  fsSearchLookupFields := TStringList.Create;
  fsSearchLookupFields.Clear;
  fsLabelEnd := ' "F5,F6,F7"';
  fsmMode := smFullList;
  fbFirstModeSet := true;
  fbSwitchKeyHit := false;
  fbActive := true;
  inherited;
end;

destructor TSearchEngineObj.Destroy;
begin
  FreeAndNil(fsSearchLookupFields);
  inherited;
end;

procedure TSearchEngineObj.DoSearch;
begin
  //if Assigned(fSearchMethod) then fSearchMethod(self);
  if ComboName = '' then Exit;
  if QueryName = '' then Exit;

  fsFilterStr := TwwDBLookupCombo(Owner.FindComponent(ComboName)).Text;

  if {not Empty(fsFilterStr) OR (fsmMode = smFullList)} true then begin
    ModifySQL;
    //if not TMyQuery(Owner.FindComponent(QueryName)).Active then Exit;
    TMyQuery(Owner.FindComponent(QueryName)).Close;
    TMyQuery(Owner.FindComponent(QueryName)).SQL.Text := ModifiedSQL;
    TMyQuery(Owner.FindComponent(QueryName)).Open;
  end;

  if fbCanFocusCombo then begin
    SetControlFocus(TwwDBLookupCombo(Owner.FindComponent(ComboName)));
    TwwDBLookupCombo(Owner.FindComponent(ComboName)).DropDown;
  end;  
  TwwDBLookupCombo(Owner.FindComponent(ComboName)).Text := fsFilterStr;
end;



procedure TSearchEngineObj.HandleSwitchKeys(Key: word);
begin
  if not fbActive then Exit;
  if not (Key in [VK_F7, VK_F6, VK_F5{, VK_RETURN}]) then Exit;

  if not (((FastFuncs.UpperCase(TForm(Owner).ActiveControl.Name) = FastFuncs.UpperCase(fsGridName)) or (FastFuncs.UpperCase(TForm(Owner).ActiveControl.Name) = FastFuncs.UpperCase(fsComboName))) and
    (FastFuncs.UpperCase(TwwDBGrid(Owner.FindComponent(fsGridName)).GetActiveField.FieldName) = FastFuncs.UpperCase(fsGridFieldName))) then Exit;

  //if Key in [VK_F7,VK_F6,VK_F5] then fbSwitchKeyHit := true;
  fbSwitchKeyHit := true;

  {if Key = VK_RETURN then begin
    case fsmMode of
      smLike: Key := VK_F7;
      smStartsWith: Key := VK_F6;
      smFullList: Key := VK_F5;
    end;
  end;} 

  if Key = VK_F7 then begin
    fbCanFocusCombo := true;
    Mode := smLike;
  end;
  if Key = VK_F6 then begin
    fbCanFocusCombo := true;
    Mode := smStartsWith;
  end;
  if Key = VK_F5 then begin
    fbCanFocusCombo := true;
    Mode := smFullList;
  end;
end;

procedure TSearchEngineObj.ModifySQL;
var
  Filter: string;
  FilterFields: TStringList;
  SearchStr: string;
  i, x, InsertIndex, Offset: integer;
begin
  InsertIndex := 1;
  Offset := 0;
  fsModifiedSQL := AnsiStringReplace(fsOriginalSQL, ';', '', []);
  if (FastFuncs.Trim(fsFilterStr) = '') and (fsmMode <> smFullList) then begin
    if not AnsiContainsStr(FastFuncs.UpperCase(fsModifiedSQL), 'LIMIT 0') then fsModifiedSQL := fsModifiedSQL + 'LIMIT 0';
    Exit;
  end;
  if fsSearchLookupFields.Count = 0 then Exit;
  case fsmMode of
    smFullList: Exit;
    smStartsWith: SearchStr := fsFilterStr + '%';
    smLike: SearchStr := '%' + fsFilterStr + '%';
  end;{case}

  for x := 0 to fsSearchLookupFields.Count - 1 do begin
    InsertIndex  := FastFuncs.PosEx('WHERE', FastFuncs.UpperCase(Copy(fsModifiedSQL, InsertIndex, FastFuncs.StrLength(fsModifiedSQL) - InsertIndex + 1))) + 5;
    Offset       := Offset + InsertIndex;
    Filter       := ' (';
    FilterFields := TStringList.Create;
    try
      FilterFields.Delimiter := ';';
      FilterFields.DelimitedText := SearchLookupFields[x];

      for i := 0 to FilterFields.Count - 1 do begin
        if FastFuncs.Trim(FilterFields[i]) <> '' then begin
            if i > 0 then Filter := Filter + ' OR ';
            Filter := Filter + '(' + FilterFields[i] + ' LIKE ' + QuotedStr(SearchStr) + ')';
        end;
      end;
      Filter := Filter + ') ';
    finally
      FreeAndNil(FilterFields);
    end;
    Insert(Filter + ' AND ', fsModifiedSQL, Offset);
  end; {for x}
end;

  //procedure TSearchEngineObj.OnComboExit(Sender: Tobject);
  //begin
  //  DoSearch;
  //end;

procedure TSearchEngineObj.SetMode(const Value: TSearchEngineObjMode);
var 
  sListLabel: string;
begin
  if not fbActive then Exit;
  if fbFirstModeSet then begin
    fOriginalComboNotInList := TwwDBLookupCombo(Owner.FindComponent(ComboName)).OnNotInList;
    fbFirstModeSet          := false;
  end;

  //get rid of suffixes e.g.: (Full List) (Starts withs) and (Like)
  fsDisplayLabel := FastFuncs.AnsiStringReplace(TwwDBGrid(Owner.FindComponent(GridName)).ColumnByName(GridFieldName).DisplayLabel, fsDisplayLabel_FullList, '', [rfReplaceAll, rfIgnoreCase]);
  fsDisplayLabel := FastFuncs.AnsiStringReplace(fsDisplayLabel, fsDisplayLabel_StartsWith, '', [rfReplaceAll, rfIgnoreCase]);
  fsDisplayLabel := FastFuncs.AnsiStringReplace(fsDisplayLabel, fsDisplayLabel_Like, '', [rfReplaceAll, rfIgnoreCase]);
  fsDisplayLabel := FastFuncs.AnsiStringReplace(fsDisplayLabel, fsLabelEnd, '', [rfReplaceAll, rfIgnoreCase]);

  fsmMode := Value;

  case fsmMode of
    smFullList: 
      begin
        TwwDBLookupCombo(Owner.FindComponent(ComboName)).OnNotInList := fOriginalComboNotInList;
      end;
    else begin
        TwwDBLookupCombo(Owner.FindComponent(ComboName)).OnNotInList := ProductXNotInListSearchMode;
      end;
  end;{case}

  DoSearch;
  if (not Empty(GridName)) and (not Empty(GridFieldName)) then begin
    case fsmMode of
      smFullList: sListLabel := fsDisplayLabel_FullList;
      smStartsWith: sListLabel := fsDisplayLabel_StartsWith;
      smLike: sListLabel := fsDisplayLabel_Like;
    end;{case}

    if fbSwitchKeyHit then begin
      TwwDBGrid(Owner.FindComponent(GridName)).ColumnByName(GridFieldName).DisplayLabel := fsDisplayLabel + sListLabel;
    end else begin
      TwwDBGrid(Owner.FindComponent(GridName)).ColumnByName(GridFieldName).DisplayLabel := fsDisplayLabel + fsLabelEnd;
    end;
  end;
  TwwDBLookupCombo(Owner.FindComponent(ComboName)).Text := fsFilterStr;
end;

  //function TSearchEngineObj.SubQueryCount: integer;
  //Var index: integer;
  //begin
  //  Result := 0;
  //  index := 1;
  //  while FastFuncs.PosEx('SELECT',FastFuncs.UpperCase(Copy(OriginalSQL,Index,Length(OriginalSQL)-Index+1)))> 0 do begin
  //    Index := FastFuncs.PosEx('SELECT',FastFuncs.UpperCase(Copy(OriginalSQL,Index+1,Length(OriginalSQL)-Index)));
  //    Inc(Result);
  //  end;
  //end;

procedure TSearchEngineObj.ComboKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  Key := VK_F6;
  HandleSwitchKeys(Key);
  //  if Assigned(fOriginalComboKeyDown) then
  //    fOriginalComboKeyDown(Sender,Key,Shift);
end;

procedure TSearchEngineObj.SetComboKeyDown;
begin
  fOriginalComboKeyDown := TwwDBLookupCombo(Owner.FindComponent(ComboName)).OnKeyDown;
  TwwDBLookupCombo(Owner.FindComponent(ComboName)).OnKeyDown := ComboKeyDown;
end;

procedure TSearchEngineObj.SetComboEnter;
begin
  fOriginalComboEnter := TwwDBLookupCombo(Owner.FindComponent(ComboName)).OnEnter;
  TwwDBLookupCombo(Owner.FindComponent(ComboName)).OnEnter := ComboEnter;
end;

procedure TSearchEngineObj.SetComboExit;
begin
  fOriginalComboExit := TwwDBLookupCombo(Owner.FindComponent(ComboName)).OnExit;
  TwwDBLookupCombo(Owner.FindComponent(ComboName)).OnExit := ComboExit;
end;

procedure TSearchEngineObj.ComboEnter(Sender: TObject);
begin
  //Include(TwwDBGrid(owner.FindComponent(fsGridName)).KeyOptions,dgEnterToTab);
  TwwDBGrid(Owner.FindComponent(fsGridName)).KeyOptions :=
    TwwDBGrid(Owner.FindComponent(fsGridName)).KeyOptions - [dgEnterToTab];
  fOriginalComboEnter(Sender);
end;

procedure TSearchEngineObj.ComboExit(Sender: TObject);
begin
  if fbOriginalGridEnterToTab then begin
    TwwDBGrid(Owner.FindComponent(fsGridName)).KeyOptions :=
      TwwDBGrid(Owner.FindComponent(fsGridName)).KeyOptions + [dgEnterToTab];
  end;
  if Assigned(fOriginalComboExit) then fOriginalComboExit(Sender);
end;

procedure TSearchEngineObj.SetGridName(const Value: string);
begin
  fsGridName := Value;
  //  if dgEnterToTab in TwwDBGrid(owner.FindComponent(Value)).KeyOptions then begin
  //    fbOriginalGridEnterToTab := true;
  //  end
  //  else begin
  //    fbOriginalGridEnterToTab := false;
  //  end;
  //SetComboKeyDown;
  //SetComboEnter;
  //SetComboExit;
end;

end.
