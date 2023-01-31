

unit POSBtnMatrixObj;


interface
{$I ERP.inc}

uses Classes, Graphics, Controls, Dialogs, ExtCtrls, StdCtrls, PanelBtnObj,
     AdvPanel, DB, MyAccess,ERPdbComponents;

const
  // Defines size of POS button matrix
  MAX_ROW = 7;
  MAX_COL = 6;
  // POS Function types
  FN_NONE = -1;
  //FN_PROD = 0;

type

  // Describes the functionality of a POS button
  TBtnFunction = record
    FnID: integer;
    SubFn: integer;
    RoomID: integer;
    Description: string;//[50];
    PartNumber: int64;
    PartName: string;//[41];
    Price: currency;
    Memo: string;//[255];
  end;

  // Contains the major attributes of a font
  TFontAttributes = record
    Name: string;//[20];
    Size: integer;
    Style: TFontStyles;
    Colour: TColor;
  end;

  // Unique attributes of a POS button - for storage and retrieval
  TBtnAttributes = record
    BGColour: TColor;
    FontAttribs: TFontAttributes;
    Text1: string;//[10];
    Text2: string;//[10];
    HotKey: string;//[10];
    TextTop: integer;
    Hint: string;//[1000];
    Func: TBtnFunction;
  end;

  // This class defines a button designed specifically for the POS screen
  TPOSBtn = class(TPanelBtn)
    Func: TBtnFunction;
    constructor Create(ParentPnl: TPanel; Top, Left, Width, Height: integer); override;
    procedure ResetBtn(DefFont: TFont); override;
    procedure SetFunction(const FnRec: TBtnFunction);
    function GetFunction: TBtnFunction;
    procedure SetAttributes(Const BtnAtts: TBtnAttributes);
    procedure GetAttributes(var BtnAtts: TBtnAttributes);
  end;

  { This class creates and manages a matix of POS buttons - You must
    create a Panel of size that will fit the matrix, and pass the constructor
    the name of this panel.  In addition, the OnClick event of the
    panel will become the OnClick event for the entire button matrix }

  TPOSBtnMatrix = class(TObject)
    ParentPnl: TPanel;         // Panel which will house this matrix
    aryPOSBtn: array[1..MAX_ROW, 1..MAX_COL] of TPOSBtn;
    DownTimer: TTimer;
    KeypadID: integer;           // ID of the Keypad
    Selected: TPosBtn;           // Button selcted
    SelRow: integer;             // Row of selcted button
    SelCol: integer;             // Column of selcted button
    Rows: integer;               // Number of rows
    Cols: integer;               // Number of cols
    DefFont: TFont;              // Font used for default
    StayDown: boolean;           // Button type
    IsInDB: boolean;             // true if this keypad loadded from DB
    constructor Create(const ParentPnl: TPanel; const Font: TFont; const StayDown: boolean); virtual;
    destructor Destroy; override;
    procedure ResetMatrix;    // Sets all buttons back to their default
    procedure SelectButton(const BtnObj: TObject); overload;    // selects this button
    procedure SelectButton(const iRow, iCol: integer); overload;// Selects the button
    function SelectButton(const chHotKey: char): boolean; overload;// Selects the button
    procedure SaveToDB;       // saves button config to DataBase
    function LoadFromDb: boolean;
    procedure RemoveStars;
    procedure DownTimerTimer(Sender: TObject);
    procedure ResetDownTimer;
    procedure SetHotKey(const cChar: char);
    (*procedure SaveToFile(const sFileName: string);
    procedure LoadFromFile(const sFileName: string);*)
  end;

implementation

uses FastFuncs, SysUtils, CommonDbLib, CommonLib, Forms, CustomizePOSGUI, tcConst,
  POSConst;

const
  A_ASCII        = 65;
  TIMER_INTERVAL = 100;

  // POS button size
  POS_BTN_WIDTH  = 63;
  POS_BTN_HEIGHT = 49;


constructor TPOSBtn.Create(ParentPnl: TPanel; Top, Left, Width, Height: integer);
  { Initialize the function attributes for this button }
begin
  inherited;
  with func do begin
    func.FnID        := FN_NONE;
    func.SubFn       := 0;
    func.Description := '';
    func.PartNumber  := 0;
    func.Price       := 0.0;
  end;
end;

procedure TPOSBtn.ResetBtn(DefFont: TFont);
begin
  inherited;
  Func.FnID := FN_NONE;
  Func.SubFn := 0;
  Func.Description := '';
  Func.PartNumber := 0;
  Func.Price := 0.0;
end;

procedure TPOSBtn.SetFunction(const FnRec: TBtnFunction);
  // Sets the function attributes of this button
begin
  Func := FnRec;
end;

function TPOSBtn.GetFunction: TBtnFunction;
  // Returns the function attributes of this button
begin
  Result := Func;
end;



procedure TPOSBtn.GetAttributes(var BtnAtts: TBtnAttributes);
  // Returns the unique attributes of this POS button
begin
  {$warnings off}
  BtnAtts.BGColour := Panel.Color;
  BtnAtts.FontAttribs.Name := Line1.Font.Name;
  BtnAtts.FontAttribs.Size := Line1.Font.Size;
  BtnAtts.FontAttribs.Colour := Line1.Font.Color;
  BtnAtts.FontAttribs.Style := Line1.Font.Style;
  BtnAtts.Text1 := Line1.Caption;
  BtnAtts.Text2 := Line2.Caption;
  BtnAtts.HotKey := HotKey.Caption;
  BtnAtts.TextTop := Line1.Top;
  BtnAtts.Hint := GetHint;
  {$warnings on}
  BtnAtts.Func := GetFunction;
end;

procedure TPOSBtn.SetAttributes(Const BtnAtts: TBtnAttributes);
  // Sets the unique attributes of this POS button
begin
  SetFunction(BtnAtts.Func);
  Panel.Color := BtnAtts.BGColour;
  Panel.ColorMirrorTo := BtnAtts.BGColour;
  Line1.Font.Name := string(BtnAtts.FontAttribs.Name);
  Line2.Font.Name := string(BtnAtts.FontAttribs.Name);
  Line1.Font.Size := BtnAtts.FontAttribs.Size;
  Line2.Font.Size := BtnAtts.FontAttribs.Size;
  Line1.Font.Color := BtnAtts.FontAttribs.Colour;
  Line2.Font.Color := BtnAtts.FontAttribs.Colour;
  HotKey.Font.Color := BtnAtts.FontAttribs.Colour;
  Line1.Font.Style := BtnAtts.FontAttribs.Style;
  Line2.Font.Style := BtnAtts.FontAttribs.Style;
  Line1.Caption := string(BtnAtts.Text1);
  Line2.Caption := string(BtnAtts.Text2);
  HotKey.Caption := string(BtnAtts.HotKey);
  ResizeLines;
  SetHint(string(BtnAtts.Hint));
  ArrangeText(BtnAtts.TextTop);
end;


// TPOSBtnMatrix Methods

constructor TPOSBtnMatrix.Create(const ParentPnl: TPanel; const Font: TFont; const StayDown: boolean);
var
  iRow, iCol: integer;
  savedState: boolean;
begin
  inherited Create;
  Self.ParentPnl := ParentPnl;

  savedState := ParentPnl.Visible;
  try
    ParentPnl.Visible := false;
    // Create the array of buttons

    for iRow := 1 to MAX_ROW do
      for iCol := 1 to MAX_COL do begin
        aryPOSBtn[iRow, iCol] := TPOSBtn.Create(ParentPnl, (iRow - 1) * POS_BTN_HEIGHT + 5, (iCol - 1) * POS_BTN_WIDTH + 5, POS_BTN_WIDTH, POS_BTN_HEIGHT);
      end;

    KeyPadID := 1;

    Rows := MAX_ROW;
    Cols := MAX_COL;

    DownTimer          := TTimer.Create(nil);
    DownTimer.Enabled  := false;
    DownTimer.Interval := TIMER_INTERVAL;
    DownTimer.OnTimer  := DownTimerTimer;

    // Get default font and store it for later
    DefFont := TFont.Create;
    DefFont.Assign(Font);
    Self.StayDown := StayDown;

    // Complete the details on the buttons
    ResetMatrix;
  finally
    ParentPnl.Visible := savedState;
  end;
end;

destructor TPOSBtnMatrix.Destroy;
var
  iRow, iCol: integer;
begin
  // Destroy the array of buttons
  for iRow := 1 to MAX_ROW do
    for iCol := 1 to MAX_COL do
      FreeAndNil(aryPOSBtn[iRow, iCol]);

  FreeAndNil(DefFont);
  FreeAndNil(DownTimer);
  inherited;  
end;

procedure TPOSBtnMatrix.ResetMatrix;
  // resets the array of buttons to the default
var
  iRow, iCol: integer;
  savedState: boolean;
begin
  savedState := ParentPnl.Visible;
  ParentPnl.Visible := false;
  try
    for iRow := 1 to MAX_ROW do
      for iCol := 1 to MAX_COL do
        aryPOSBtn[iRow, iCol].ResetBtn(DefFont);
  finally
    ParentPnl.Visible := savedState;
  end;
end;


procedure TPOSBtnMatrix.SelectButton(const BtnObj: TObject);
  // Select the  button which contains the object passed
var
  Panel: TAdvPanel;
  BtnLabel: TLabel;
  i, j: integer;
  bSelectFound: boolean;
begin
  Panel := nil;
  // New Button clicked, so turn off Previous button
  if Selected <> nil then Selected.BtnUp;

  { Get the Panel Button which was clicked - either the panel or one of
    its labels could have been clicked }

  if BtnObj is TAdvPanel then begin
    Panel := (BtnObj as TAdvPanel);
  end else if BtnObj is TLabel then begin
    BtnLabel := (BtnObj as TLabel);
    Panel    := (BtnLabel.Parent as TAdvPanel);
  end else begin
    CommonLib.MessageDlgXP_Vista('Problem with Selecting a Button', mtWarning, [mbOK], 0);
    if Selected <> nil then 
      Panel := Selected.Panel; // Back to previoiusly selected button
  end;

  // Find the row and column of the button selected

  bSelectFound := false;
  for i := 1 to MAX_ROW do begin
    for j := 1 to MAX_COL do
      if aryPOSBtn[i, j].Panel = Panel then begin
        bSelectFound := true;
        Selected := aryPOSBtn[i, j];
        SelRow := i;
        SelCol := j;
        Break;
      end;
    if bSelectFound = true then Break;
  end;
  if Selected <> nil then begin
    Selected.BtnDown;
    if not StayDown then ResetDownTimer;
  end;
end;

procedure TPOSBtnMatrix.SelectButton(const iRow, iCol: integer);
  { Select the button given by iRow and ICol }
begin
  // New Button clicked, so turn off Previous button
  if Selected <> nil then Selected.BtnUp;
  SelRow := iRow;
  SelCol := iCol;
  Selected := aryPOSBtn[iRow, iCol];
  Selected.BtnDown;  // Show the button as 'selected'
  if not StayDown then ResetDownTimer;
end;

function TPOSBtnMatrix.SelectButton(const chHotKey: char): boolean;
  { Select the button with the hotkey given and return false if not found }
var
  iRow: integer;
  iCol: integer;
begin
  Result := false;

  // Search for the button which has the hotkey required
  for iRow := 1 to MAX_ROW do begin
    for iCol := 1 to MAX_COL do begin
      if (char_length(aryPOSBtn[iRow, iCol].HotKey.Caption) > 0) then begin
        if chHotKey = aryPOSBtn[iRow, iCol].HotKey.Caption[1] then begin
          // Button found
          Result := true;
          if Selected <> nil then Selected.BtnUp;
          // Select new button
          Selected := aryPOSBtn[iRow, iCol];
          SelRow := iRow;
          SelCol := iCol;
          Selected.BtnDown;
          if not StayDown then ResetDownTimer;
          Break;
        end;
      end;
    end;
    if Result = true then Break;
  end;
end;


procedure TPOSBtnMatrix.SaveToDB;
var
  qry: TERPCommand;
  sBold: string;
  sItalic: string;
  sUnderline: string;
  sKeyName: string;
  iRow: integer;
  iCol: integer;
  BtnAtts: TBtnAttributes;

  procedure PrepareParameters;
  begin
    with qry.Params do begin
      ParamByName('xKeyPadID').AsInteger := KeyPadID;
      ParamByName('xKeyName').AsString := sKeyName;
      ParamByName('xQuickKey').AsString := string(BtnAtts.HotKey);
      ParamByName('xCaptionLine1').AsString := string(BtnAtts.Text1);
      ParamByName('xCaptionLine2').AsString := string(BtnAtts.Text2);
      ParamByName('xFontColour').AsInteger := BtnAtts.FontAttribs.Colour;
      ParamByName('xFontName').AsString := string(BtnAtts.FontAttribs.Name);
      ParamByName('xFontSize').AsInteger := BtnAtts.FontAttribs.Size;
      ParamByName('xFontBold').AsString := sBold;
      ParamByName('xFontItalic').AsString := sItalic;
      ParamByName('xFontUnderline').AsString := sUnderline;
      ParamByName('xBackgroundColour').AsInteger := BtnAtts.BGColour;
      ParamByName('xTopMargin').AsFloat := BtnAtts.TextTop;
      ParamByName('xPartID').AsInteger := BtnAtts.Func.PartNumber;
      ParamByName('xFunctionNo').AsInteger := BtnAtts.Func.FnID;
      ParamByName('xRoomID').AsInteger := BtnAtts.Func.RoomID;
      ParamByName('xFunctionType').AsInteger := BtnAtts.Func.SubFn;
      ParamByName('xFunctionName').AsString := string(BtnAtts.Func.Description);
      ParamByName('xMemo').AsString := string(BtnAtts.Func.Memo);
      ParamByName('xHint').AsString := BtnAtts.Hint;
    end;
  end;

  procedure PerformUpdate;
  begin
    qry := TERPCommand.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qry do begin
        Sql.Clear;
        Sql.Add('UPDATE tblposkeypadcustomize SET ' +
          'QuickKey = :xQuickKey, ' +
          'CaptionLine1 = :xCaptionLine1, ' +
          'CaptionLine2 = :xCaptionLine2, ' +
          'FontColour = :xFontColour, ' +
          'FontName = :xFontName, ' +
          'FontSize = :xFontSize, ' +
          'FontBold = :xFontBold, ' +
          'FontItalic = :xFontItalic, ' +
          'FontUnderline = :xFontUnderline, ' +
          'BackgroundColour = :xBackgroundColour, ' +
          'TopMargin = :xTopMargin, ' +
          'PartID = :xPartID, ' +
          'FunctionNo = :xFunctionNo, ' +
          'FunctionType = :xFunctionType, ' +
          'FunctionName = :xFunctionName, ' +
          'RoomID = :xRoomID, ' +
          'Hint = :xHint, ' +
          'Memo = :xMemo ' +
          'WHERE KeyPadID = :xKeyPadID AND KeyName = :xKeyName');
        PrepareParameters;
        Execute;
      end;
    finally
      FreeAndNil(qry);
    end;
  end;

  procedure PerformInsert;
  begin
    qry := TERPCommand.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qry do begin
        Sql.Clear;
        Sql.Add('INSERT tblposkeypadcustomize' +
          '(KeypadID, ' +
          'KeyName, ' +
          'QuickKey, ' +
          'CaptionLine1, ' +
          'CaptionLine2, ' +
          'FontColour, ' +
          'FontName, ' +
          'FontSize, ' +
          'FontBold,  ' +
          'FontItalic, ' +
          'FontUnderline, ' +
          'BackgroundColour, ' +
          'TopMargin, ' +
          'PartID, ' +
          'FunctionNo, ' +
          'FunctionType, ' +
          'FunctionName, ' +
          'RoomID, ' +
          'Memo, ' +
          'Hint) ' +
          'VALUES ' +
          '(:xKeyPadID, ' +
          ':xKeyname, ' +
          ':xQuickKey, ' +
          ':xCaptionLine1, ' +
          ':xCaptionLine2, ' +
          ':xFontColour, ' +
          ':xFontName, ' +
          ':xFontSize, ' +
          ':xFontBold, ' +
          ':xFontItalic, ' +
          ':xFontUnderline, ' +
          ':xBackgroundColour, ' +
          ':xTopMargin, ' +
          ':xPartID, ' +
          ':xFunctionNo, ' +
          ':xFunctionType, ' +
          ':xFunctionName, ' +
          ':xRoomID, ' +
          ':xMemo, ' + 
          ':xHint);');
        PrepareParameters;
        Execute;
      end;
    finally
      FreeAndNil(qry);
    end;
  end;


  procedure GetValues;
  begin
    sKeyName := Chr(A_ASCII - 1 + iRow) + IntToStr(iCol);
    aryPOSBtn[iRow, iCol].GetAttributes(BtnAtts);
    with BtnAtts.FontAttribs do begin
      // extract font style elements
      if fsBold in Style then sBold := 'T'
      else sBold := 'F';
      if fsItalic in Style then sItalic := 'T'
      else sItalic := 'F';
      if fsUnderline in Style then sUnderline := 'T'
      else sUnderline := 'F';
    end;
  end;
begin
  // copied this code from marcus - not sure about try except block stucture
  // this should be checked.

  for iRow := 1 to MAX_ROW do begin
    for iCol := 1 to MAX_COL do begin
      GetValues;
      try
        if IsInDB then PerformUpdate
        else PerformInsert;
      except
        on e: Exception do begin
          raise Exception.Create(e.message);
        end;
      end;
    end;
  end;
end;

function TPOSBtnMatrix.LoadFromDb: boolean;
var
  qry: TERPQuery;
  iRow, iCol: integer;
  BtnAtts: TBtnAttributes;
  iRecIndex: integer;
  bFound: boolean;
  savedState: boolean;
begin
  savedState := ParentPnl.Visible;
  ParentPnl.Visible := false;
  try
    // Clear Matrix.
    ResetMatrix;
    DownTimerTimer(Self);
    Result := false;
    IsInDB := true;

    bFound := true;
    // Make sure that keypad ID is active
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      qry.Sql.Add('SELECT ' +
        'Description ' +
        'FROM tblposkeypads ' +
        'WHERE KeypadID = :xKeypadID and Active = ' + QuotedStr('T') + ';');
      qry.Params.ParamByName('xKeyPadID').asInteger := KeyPadID;
      qry.Open;
      if qry.IsEmpty then begin
        bFound := false;
      end
    finally
      FreeAndNil(qry);
    end;

    if bFound then begin
      qry := TERPQuery.Create(nil);
      qry.Options.FlatBuffers := True;
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      try
        qry.Sql.Add('SELECT ' +
          'QuickKey, ' +
          'CaptionLine1, ' +
          'CaptionLine2, ' +
          'FontColour, ' +
          'FontName, ' +
          'FontSize, ' +
          'FontBold, ' +
          'FontItalic, ' +
          'FontUnderline, ' +
          'BackgroundColour, ' +
          'TopMargin, ' +
          'PartID, ' +
          'FunctionNo, ' +
          'FunctionType, ' +
          'RoomID, ' +
          'Hint, ' +
          'Memo, ' +
          'FunctionName ' +
          'FROM tblposkeypadcustomize WHERE KeypadID = :xKeypadID');
        qry.Params.ParamByName('xKeyPadID').asInteger := KeyPadID;
        qry.Open;
        if qry.IsEmpty then begin
          IsInDB := false;
        end else begin
          IsInDB := true;
          if qry.RecordCount < MAX_ROW * MAX_COL then CommonLib.MessageDlgXP_Vista('Loading Buttons: Not enough records in DB. ' +
              'Will load what we can',
              mtWarning, [mbOK], 0);
          qry.First;
          iRecIndex := 1;
          while (not qry.Eof) and (iRecIndex <= MAX_ROW * MAX_COL) do begin
            // Determine row and column of button in matrix
            if devmode then begin
              if (Qry.fieldByname('functionno').asInteger > 0 ) and
                (Sametext(Qry.fieldbyname('functionname').asString , 'Devmode')) then begin
                  qry.Next;
                  continue;
              end;
            end;

            iRow := (iRecIndex - 1) div MAX_COL + 1;
            iCol := (iRecIndex - 1) mod MAX_COL + 1;

            // Now retrieve attributes for this button

            {$warnings off}
            BtnAtts.HotKey := qry.FieldByName('QuickKey').AsString;
            BtnAtts.Text1 := qry.FieldByName('CaptionLine1').AsString;
            BtnAtts.Text2 := qry.FieldByName('CaptionLine2').AsString;
            BtnAtts.FontAttribs.Colour := qry.FieldByName('FontColour').AsInteger;
            BtnAtts.FontAttribs.Name := qry.FieldByName('FontName').AsString;
            {$warnings on}
            BtnAtts.FontAttribs.Size := qry.FieldByName('FontSize').AsInteger;
            BtnAtts.FontAttribs.Style := [];
            if qry.FieldByName('FontBold').AsString = 'T' then begin
              BtnAtts.FontAttribs.Style := BtnAtts.FontAttribs.Style + [fsBold];
            end;

            if qry.FieldByName('FontItalic').AsString = 'T' then begin
              BtnAtts.FontAttribs.Style := BtnAtts.FontAttribs.Style + [fsItalic];
            end;

            if qry.FieldByName('FontUnderline').AsString = 'T' then begin
              BtnAtts.FontAttribs.Style := BtnAtts.FontAttribs.Style + [fsUnderline];
            end;

            {$warnings off}
            BtnAtts.BGColour := qry.FieldByName('BackgroundColour').AsInteger;
            BtnAtts.TextTop := qry.FieldByName('TopMargin').AsInteger;
            BtnAtts.Func.PartNumber := qry.FieldByName('PartID').AsInteger;
            BtnAtts.Func.FnID := qry.FieldByName('FunctionNo').AsInteger;
            BtnAtts.Func.RoomID := qry.FieldByName('RoomID').AsInteger;
            BtnAtts.Func.SubFn := qry.FieldByName('FunctionType').AsInteger;
            BtnAtts.Func.Description := qry.FieldByName('FunctionName').AsString;
            BtnAtts.Func.Memo := qry.FieldByName('Memo').AsString;
            BtnAtts.Hint := qry.FieldByName('Hint').AsString;
            if BtnAtts.Func.FnID = FN_PRINT_INV then begin
              BtnAtts.Hint := BtnAtts.Hint + NL +
                  'Template used here is the ''Default Template(A4)'' Selected for the current Till or ' +chr(13)+
                  'When ''Default Template(A4)'' is not selected, the default template of type ''Cash Sale''.'+chr(13);
            end;

            {$warnings on}

            // Set this buttons attributes
            aryPOSBtn[iRow, iCol].SetAttributes(BtnAtts);
            Inc(iRecIndex);
            qry.Next;
          end;
          Result := true;
        end;
      finally
        FreeAndNil(qry);
      end;
    end else Result := false;
  finally
    ParentPnl.Visible := savedState;
  end;
end;


procedure TPOSBtnMatrix.RemoveStars;
var
  i, j: integer;
begin
  // Remove *'s from HotKeys
  for i := 1 to Rows do for j := 1 to Cols do begin
      try
        if aryPOSBtn[i, j].HotKey.Caption[1] = '*' then aryPOSBtn[i, j].HotKey.Caption := '';
        if aryPOSBtn[i, j].Func.FnID = FN_NONE then begin
          aryPOSBtn[i, j].Line1.Caption := '';
          aryPOSBtn[i, j].Line2.Caption := '';
        end;
      except
      end;
    end;
end;


procedure TPOSBtnMatrix.DownTimerTimer(Sender: TObject);
begin
  If not DownTimer.Enabled then Exit;
  DownTimer.Enabled := false;
  Application.ProcessMessages;
  if Selected <> nil then begin
    if not StayDown then Selected.BtnUp;
    Selected := nil;
  end;
end;


procedure TPOSBtnMatrix.ResetDownTimer;
begin
  DownTimer.Enabled := false;
  DownTimer.Enabled := true;
end;


procedure TPOSBtnMatrix.SetHotKey(const cChar: char);
var
  i, j: integer;
  bFound: boolean;
begin
  bFound := false;
  if cChar <> '*' then begin
    for i := 1 to Rows do begin
      for j := 1 to Cols do begin
        if (i <> SelRow) and (j <> SelCol) then begin
          if aryPOSBtn[i, j].HotKey.Caption[1] = cChar then begin
            CommonLib.MessageDlgXP_Vista('This Hot key is already in use', mtWarning, [mbOK], 0);
            bFound := true;
            Break;
          end;
        end;
      end;
      if bFound then Break;
    end;
  end;
  if not bFound then Selected.HotKey.Caption := cChar;
end;


(*procedure TPOSBtnMatrix.SaveToFile(const sFileName: string);
  // Saves to file the unique attributes of each button
var
  BtnFile: file of TBtnAttributes;
  i, j: integer;
  BtnAtts: TBtnAttributes;
begin
  Assign(BtnFile, sFileName);
  try
    Rewrite(BtnFile);
    for i := 1 to MAX_ROW do begin
      for j := 1 to MAX_COL do begin
        aryPOSBtn[i, j].GetAttributes(BtnAtts);
        Write(BtnFile, BtnAtts);
      end;
    end;
  finally
    CloseFile(BtnFile);
  end;
end;

procedure TPOSBtnMatrix.LoadFromFile(const sFileName: string);
  // Reads from file, the unique attributes of each button
var
  BtnFile: file of TBtnAttributes;
  i, j: integer;
  BtnAtts: TBtnAttributes;
begin
  Assign(BtnFile, sFileName);
  try
    Reset(BtnFile);
    for i := 1 to MAX_ROW do begin
      for j := 1 to MAX_COL do begin
        Read(BtnFile, BtnAtts);
        aryPOSBtn[i, j].SetAttributes(BtnAtts); // UPdate button with attributes
      end;
    end;
  finally
    CloseFile(BtnFile);
  end;
end;*)


end.


