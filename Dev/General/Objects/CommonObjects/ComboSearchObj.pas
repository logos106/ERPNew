unit ComboSearchObj;

interface

uses
  classes, contnrs, wwDBLook, wwDBGrid, db;

type
  {
     NOTE:
       This unit modifies the behaviour of the TwwDbLookupCombos by intercepting
       the form key events and tapping into the windows keyboard events.
       The main functionality we want is as follows:
       Tab key: will process the text the user has typed into the combo
                 - if exact match is found that item will be selected
                 - if partial match and the list has only on filterd item this will be selected
                 - no match will give not in list
       F5:  will drop down entire list
       F6:  will drop down list of items starting with entered text
       F7:  will drop down list of items containing entered text
       Return: if nothing is selected in list this will do the same as pressing
               F5,F6 or F7 (depending which was last used)
               if somthing is selected in list ccombo will close up and select
               that item.
       F4: implements the TAB function as described above, had to use F4 for
           this as TAB cha handling is different in combo/grid/forms than other
           keys ie to get around this we get TAB key press
           (with modified TfrmBaseGUI) and send F4 key press to combo.
  }



  TComboKeyDownEvent = procedure (Sender: TObject; var Key: Word; Shift: TShiftState) of object;
  TComboKeyPressEvent = procedure (Sender: TObject; var Key: Char) of object;
  TComboNotInList =  procedure(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean) of object;

  IKeyboardHookHandler = interface(IInterface)
    function DoKeyboardProc(Code: Integer; WordParam: Word; LongParam: LongInt): LongInt;
  end;

  TwwDBComboSearcher = class(TComponent, IKeyboardHookHandler)
  private
    fCombo: TwwDbLookupCombo;
    fDisplayLabel: string;
    fSearchMode: integer;
    fResultField: string;
    DoingKeyboardProc:Boolean;
    fbAllowF5: Boolean;
    SavedOnKeyDown: TComboKeyDownEvent;
    SavedOnKeyPress: TComboKeyPressEvent;
    SavedOnNotInList: TComboNotInList;
    AllowTab: boolean;
    function DoKeyboardProc(Code: Integer; WordParam: Word; LongParam: LongInt): LongInt;
    procedure SetSearchMode(const Value: integer);
    procedure CheckComboSettings;
    function GetResultField: string;
    procedure UpdateSearchQry(const SearchMode: integer;SearchValue: String);
    procedure DoOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DoOnKeyPress(Sender: TObject; var Key: Char);
    procedure CheckNotInList;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(aOwner: TComponent; aCombo: TwwDbLookupCombo;DisableF5:Boolean); reintroduce; overload;
    destructor Destroy; override;
    property SearchMode: integer read fSearchMode write SetSearchMode;
    property DisplayLabel: string read fDisplayLabel write fDisplayLabel;
    property ResultField: string read GetResultField;
    Property AllowF5 :Boolean read fbAllowF5 Write fbAllowF5; 
    procedure UpdateDisplayLabel;
  end;

const
  SEARCH_MODE_ALL = 0;
  SEARCH_MODE_STARTS_WITH = 1;
  SEARCH_MODE_LIKE = 2;

implementation

uses
  sysutils, windows, forms, controls, MyAccess,ERPdbComponents, sndkey32,
  Messages, frmBase, LogLib;

var
  fKeyboardHookObjectList: TObjectList;
  KBHook: HHook; {this intercepts keyboard input}

const
  CONTINUE_KEY_PROCESSING = 0;
  STOP_KEY_PROCESSING = 1;

procedure EmptyKeyQueue;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, WM_KEYFIRST, WM_KEYLAST,
    PM_REMOVE or PM_NOYIELD) do;
end;

function KeyboardHookProc(Code: Integer; WordParam: Word; LongParam: LongInt): LongInt; stdcall;
var
  x: integer;
begin
  result:= 0;
  if Assigned(fKeyboardHookObjectList) then begin
    for x:= 0 to fKeyboardHookObjectList.Count -1 do begin
      if fKeyboardHookObjectList[x] is TwwDBComboSearcher then begin
        result:= TwwDBComboSearcher(fKeyboardHookObjectList[x]).DoKeyboardProc(Code,WordParam,LongParam);
        if result > 0 then break;
      end;
    end;
  end;
end;


{ TwwDBComboSearcher }

procedure TwwDBComboSearcher.CheckComboSettings;
var
  errStr: string;
begin
  errStr:= '';
  if fCombo.UseTFields then
    errStr:= 'Combo "' + fCombo.Name + '" has use TFields set to true!'
  else if not fCombo.AutoSelect then
    errStr:= 'Combo "' + fCombo.Name + '" has AutoSelect turned off!'
  else if not fCombo.AutoDropDown then
    errStr:= 'Combo "' + fCombo.Name + '" has AutoDropDown turned off!';
  if errStr <> '' then
    raise Exception.Create(errStr);
end;

procedure TwwDBComboSearcher.CheckNotInList;
begin
  if Assigned(fCombo.OnNotInList) then begin
    SavedOnNotInList:= fCombo.OnNotInList;
    fCombo.OnNotInList:= nil;
  end;
end;

constructor TwwDBComboSearcher.Create(aOwner: TComponent; aCombo: TwwDbLookupCombo;DisableF5:Boolean);
begin
  Create(aOwner);
  AllowF5 := not(DisableF5);
  fCombo:= aCombo;
  aCombo.Tag:= 1;
  CheckComboSettings;
  fDisplayLabel:= '';
  fResultField:= '';
  fSearchMode:= SEARCH_MODE_ALL;
  DoingKeyboardProc := False;
  if Assigned(fKeyboardHookObjectList) then
    fKeyboardHookObjectList.Add(self);
  { capture the combo's owner forms key events }
  if fCombo.Owner is TForm then begin
    SavedOnKeyDown:= TForm(fCombo.Owner).OnKeyDown;
    TForm(fCombo.Owner).OnKeyDown:= DoOnKeyDown;
    SavedOnKeyPress:= TForm(fCombo.Owner).OnKeyPress;
    TForm(fCombo.Owner).OnKeyPress:= DoOnKeyPress;
  end;
  AllowTab:= false;
  { TfrmBaseGUI has been modified to pass on TAB key events  }
  if fCombo.Owner is TfrmBaseGUI then
    TfrmBaseGUI(fCombo.Owner).AllowTABKeyEvent:= true;
end;

constructor TwwDBComboSearcher.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  fbAllowF5 := True;
end;

destructor TwwDBComboSearcher.Destroy;
var idx: integer;
begin
  if Assigned(fKeyboardHookObjectList) then begin
    idx:= fKeyboardHookObjectList.IndexOf(self);
    if idx > -1 then
      fKeyboardHookObjectList.Delete(idx);
  end;
  inherited;
end;

function TwwDBComboSearcher.DoKeyboardProc(Code: Integer; WordParam: Word;
  LongParam: Integer): LongInt;
var
  actCtrl: TWinControl;
  Accept: boolean;
  EscChar: Char;
  UserText: string;
  comboModified: boolean;

  procedure SendTab;
  begin
    if WordParam = VK_TAB then
      exit;
    { allow combo to close up }
    Application.ProcessMessages;
    AllowTab:= true;
    try
      SendKeys('{TAB}', false);
      Application.ProcessMessages;
    finally
      AllowTab:= false;
    end;
  end;

begin
  EscChar:= chr(27);
  result:= CONTINUE_KEY_PROCESSING;
  if DoingKeyboardProc then Exit;
  DoingKeyboardProc := true;
  try
    try
      if (Owner is TForm) and (TForm(Owner) = Screen.ActiveForm) then begin
        actCtrl:= TForm(Owner).ActiveControl;
        if Assigned(actCtrl) and (actCtrl = fCombo) then begin
//          Logtext('TwwDBComboSearcher.DoKeyboardProc ' + fCombo.Name + ' ' + IntToStr(WordParam)  + ' Modified: ' + BoolToStr(fcombo.Modified,true));
          CheckNotInList;
          case WordParam of
            VK_F5: begin
                if AllowF5 then begin
                  SearchMode:= SEARCH_MODE_ALL;
                end;
              end;
            VK_F6: begin
                SearchMode:= SEARCH_MODE_STARTS_WITH;
              end;
            VK_F7: begin
                SearchMode:= SEARCH_MODE_LIKE;
              end;
            VK_RETURN: begin
                if fCombo.SelText <> '' then begin
                  UserText:= fCombo.Text;
                  if (UserText <> '') and
                    (LowerCase(UserText) <> LowerCase(fCombo.LookupTable.FieldByName(ResultField).AsString)) then begin
                    if not fCombo.LookupTable.Locate(ResultField ,UserText , []) then begin
                      result:= STOP_KEY_PROCESSING;
                      fCombo.KeyPress(EscChar);
                      fCombo.Clear;
                      //fCombo.OnNotInList(fCombo,fCombo.LookupTable,UserText, accept);
                      if Assigned(SavedOnNotInList) then
                        SavedOnNotInList(fCombo,fCombo.LookupTable,UserText,accept);
                    end else begin
                     Application.ProcessMessages;
                     fCombo.DropDown;
                    end;
                  end;
                end;
              end;
            VK_F4, VK_TAB: begin
//                Logtext('TwwDBComboSearcher.DoKeyboardProc VK_F4 ' + fCombo.Name + ' Modified: ' + BoolToStr(fcombo.Modified,true));
                if not fCombo.Modified then begin
                  SendTab;
                  exit;
                end;
                UserText:= fCombo.Text;
                if userText <> '' then begin
                  UpdateSearchQry(SEARCH_MODE_STARTS_WITH ,userText);
                  if (fcombo.datafield <> '') and (fcombo.datasource.dataset.findfield(fcombo.datafield) <> nil) and (Sametext(fcombo.datasource.dataset.fieldbyname(fcombo.datafield).asString, userText)) then begin
                    SendTab;
                    exit;
                  end else if (fCombo.LookupTable.RecordCount = 1) and
                    fCombo.LookupTable.Locate(ResultField ,UserText , [loCaseInsensitive, loPartialKey]) then begin
                    { setting combo text clears modified so save and reset it }
                    comboModified:= fCombo.Modified;
                    try
                      fCombo.text := fCombo.LookupTable.fieldbyname(ResultField).asString; //reinstate the search text          fCombo.PerformSearch;
                    finally
                      fCombo.Modified:= comboModified;
                    end;
                    fCombo.DropDown;
                    { make sure close up processing is performed }
                    fCombo.OnCloseUp(fCombo,fCombo.LookupTable,fCombo.DataSource.DataSet,true);
                    { allow combo to close up }
                    SendTab;
                    exit;
                  end;
                end;
                if (UserText <> '') and
                    (LowerCase(UserText) <> LowerCase(fCombo.LookupTable.FieldByName(ResultField).AsString)) and
                    (not fCombo.LookupTable.Locate(ResultField ,UserText , [loCaseInsensitive])) then begin
                  result:= STOP_KEY_PROCESSING;
                  fCombo.KeyPress(EscChar);
                  fCombo.Clear;
//                  fCombo.OnNotInList(fCombo,fCombo.LookupTable,UserText, accept);
                  if Assigned(SavedOnNotInList) then
                    SavedOnNotInList(fCombo,fCombo.LookupTable,UserText,accept);
                end else begin
                  { setting combo text clears modified so save and reset it }
                  comboModified:= fCombo.Modified;
                  try
                    fCombo.text := fCombo.LookupTable.fieldbyname(ResultField).asString; //reinstate the search text          fCombo.PerformSearch;
                  finally
                    fCombo.Modified:= comboModified;
                  end;
                  fCombo.DropDown;
                  { make sure close up processing is performed }
                  fCombo.OnCloseUp(fCombo,fCombo.LookupTable,fCombo.DataSource.DataSet,true);
                  { allow combo to close up }
                  SendTab;
                end;
              end;

          end;
        end;
      end;
    except
      { hide exception if eg user hits esc and cloes form during not in list processing }
    end;
  finally
    DoingKeyboardProc:= False;
  end;
end;

procedure TwwDBComboSearcher.DoOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if fCombo.Focused then begin
    if (key = VK_TAB) then begin
      if (not AllowTab) then begin
//        Logtext('TwwDBComboSearcher.DoOnKeyDown ' + fCombo.Name + ' Modified: ' + BoolToStr(fcombo.Modified, true));
        { senf F4 to combo }
        SendKeys('{F4}',false);
        Application.ProcessMessages;
        Key:= 0;
        exit;
      end;
    end
    else if (key = VK_Return) then begin
      if fCombo.SelText = '' then begin
        SearchMode:= fSearchMode;
        Key:= 0;
        exit;
      end;
    end;
  end;

  if Assigned(SavedOnKeyDown) then
    SavedOnKeyDown(Sender,Key,Shift);
end;

procedure TwwDBComboSearcher.DoOnKeyPress(Sender: TObject; var Key: Char);
begin
  if fCombo.Focused and (key = #9) and (not AllowTab) then begin
    Key:= Chr(0);
    exit;
  end;

  if Assigned(SavedOnKeyPress) then
    SavedOnKeyPress(Sender,Key);
end;

function TwwDBComboSearcher.GetResultField: string;
begin
  if fResultField = '' then begin
    if Assigned(fCombo) then begin
      fResultField:= fCombo.Selected[0];
      if Pos(#9,fResultField) > 0 then
        fResultField:= Copy(fResultField,1,Pos(#9,fResultField)-1);
    end;
  end;
  result:= fResultField;
end;

procedure TwwDBComboSearcher.UpdateSearchQry(const SearchMode: integer;  SearchValue:String);
var
   ActiveState: boolean;
   qry: TERPQuery;
   comboModified: boolean;
begin
  qry:= TERPQuery(fCombo.LookupTable);
  if Assigned(qry.ParamByName('SearchMode')) and Assigned(qry.ParamByName('SearchValue')) then begin
    ActiveState:= qry.Active;
    { this will clear modified property so save and reset it }
    comboModified:= fCombo.Modified;
    try
      qry.Close;
      qry.ParamByName('SearchMode').AsInteger:= SearchMode;
      qry.ParamByName('SearchValue').AsString:= SearchValue;
    finally
      qry.Active:= ActiveState;
      fCombo.Modified:= comboModified;
    end;
  end;
end;
procedure TwwDBComboSearcher.SetSearchMode(const Value: integer);
var
  qry: TERPQuery;
  comboModified: boolean;
  UserText: string;
begin
  fSearchMode := Value;
  if Assigned(fCombo) then begin
    UserText:= fCombo.Text;
    if UserText = '' then
      UserText:= ' ';
    try
      UpdateDisplayLabel;
    finally
      if fCombo.LookupTable is TERPQuery then begin
        qry:= TERPQuery(fCombo.LookupTable);
        if Assigned(qry.ParamByName('SearchMode')) and Assigned(qry.ParamByName('SearchValue')) then begin
          updateSearchQry(Value,userText);
          fCombo.ClearSelection;
          if Qry.RecordCount > 0 then begin
            fCombo.CloseUp(false);
            Application.ProcessMessages;
            if not fCombo.Focused then begin
              if Assigned(fCombo.Parent) and  (fCombo.Parent is TwwDbGrid) then begin
                TwwDbGrid(fCombo.Parent).SetActiveField(fCombo.DataField);
              end;
            end;
            fCombo.DropDown;
            Application.ProcessMessages;
            if not fCombo.Focused then begin
              if Assigned(fCombo.Parent) and  (fCombo.Parent is TwwDbGrid) then begin
                TwwDbGrid(fCombo.Parent).SetActiveField(fCombo.DataField);
              end;
            end;
            { setting combo text clears modified so save and reset it }
            comboModified:= fCombo.Modified;
            try
              fCombo.text := UserText; //reinstate the search text          fCombo.PerformSearch;
            finally
              fCombo.Modified:= comboModified;
            end;
            fCombo.SelStart := fCombo.GetTextLen;  //move caret to end of text
            fCombo.Invalidate;
          end;
        end;
      end;
    end;
  end;
end;

procedure TwwDBComboSearcher.UpdateDisplayLabel;
begin
  if not Assigned(fCombo.DataSource) then exit;

  fCombo.DataSource.Dataset.DisableControls;
  try
    if fCombo.DataSource.Dataset.Active then begin
      if fDisplayLabel = '' then
        fDisplayLabel:= fCombo.DataSource.Dataset.FieldByName(fCombo.DataField).DisplayLabel;
      case fSearchMode of
        0: fCombo.DataSource.Dataset.FieldByName(fCombo.DataField).DisplayLabel:= fDisplayLabel + ' Search F5';
        1: fCombo.DataSource.Dataset.FieldByName(fCombo.DataField).DisplayLabel:= fDisplayLabel + ' Search F6';
        2: fCombo.DataSource.Dataset.FieldByName(fCombo.DataField).DisplayLabel:= fDisplayLabel + ' Search F7';
      end;
    end;
  finally
    fCombo.DataSource.Dataset.EnableControls;
  end;
end;

initialization
  fKeyboardHookObjectList:= TObjectList.Create(false);
  KBHook:=SetWindowsHookEx(WH_KEYBOARD,
           {callback —>} @KeyboardHookProc,
                          HInstance,
                          GetCurrentThreadId());


finalization;
  UnHookWindowsHookEx(KBHook);
  FreeAndNil(fKeyboardHookObjectList);

end.
