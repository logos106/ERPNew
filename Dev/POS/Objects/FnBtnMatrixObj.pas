unit FnBtnMatrixObj;

interface

uses
  Forms, Classes, Graphics, Controls, Dialogs, ExtCtrls, StdCtrls, PanelBtnObj;

Const
  // Defines size of POS button matrix
  MAX_ROW = 3;
  MAX_COL = 4;


type

  TFnBtnMatrix = class(TObject)
    faryPanelBtn: array[1..MAX_ROW, 1..MAX_COL] of TPanelBtn;
    ftmrDown: TTimer;            // Time for button to stay down
    fiSelRow: integer;           // Row of selcted button
    fiSelCol: integer;           // Column of selcted button
    fiRows: integer;             // number of rows
    fiCols: integer;             // Number of columns
    constructor Create(ParentPnl: TPanel); virtual;
    destructor Destroy; override;
    procedure SelectButton(BtnObj: TObject); overload;    // selects this button
    procedure ftmrDownTimer(Sender: TObject);
    procedure ResetftmrDown;
  end;

implementation

uses SysUtils, CommonLib, advpanel, AppEnvironment;

const
  TIMER_INTERVAL = 100;

  // Button size
  BTN_WIDTH  = 95;
  BTN_HEIGHT = 43;

  // Colours
  NICE_LIME = $00B0FFB0;
  NICE_PINK = $00A4A4FF;
  NICE_BLUE = $00FFCA95;

constructor TFnBtnMatrix.Create(ParentPnl: TPanel);
var
  iRow, iCol: integer;
begin
  inherited Create;
  // Create the array of buttons

  for iRow := 1 to MAX_ROW do for iCol := 1 to MAX_COL do begin
      faryPanelBtn[iRow, iCol] := TPanelBtn.Create(ParentPnl, (iRow - 1) * BTN_HEIGHT + 5,
        (iCol - 1) * BTN_WIDTH + 5, BTN_WIDTH, BTN_HEIGHT);
      with faryPanelBtn[iRow, iCol] do begin
        Line1.Font.Name := 'Arial';
        Line1.Font.Size := 10;
        Line1.Font.Style := Line1.Font.Style + [fsBold];
      end;
    end;

  fiRows := MAX_ROW;
  fiCols := MAX_COL;
  fiSelRow := 0;
  fiSelCol := 0;

  ftmrDown := TTimer.Create(nil);
  ftmrDown.Enabled := false;
  ftmrDown.Interval := TIMER_INTERVAL;
  ftmrDown.OnTimer := ftmrDownTimer;

  // Initilize the look of the Function Key Buttons
  with faryPanelBtn[1, 1] do begin
    Panel.Color    := NICE_LIME;
    Panel.ColorMirrorTo := NICE_LIME;
    HotKey.Caption := '+';
    Line1.Caption  := 'Sale Person';
    SetHint('Use to select your Name or ID.');
  end;

  with faryPanelBtn[1, 2] do begin
    Panel.Color    := NICE_LIME;
    Panel.ColorMirrorTo := NICE_LIME;
    HotKey.Caption := 'F2';
    Line1.Caption  := 'Product List';
    SetHint('Display''s the product list');
  end;

  with faryPanelBtn[1, 3] do begin
    Panel.Color    := NICE_LIME;
    Panel.ColorMirrorTo := NICE_LIME;
    HotKey.Caption := 'F3';
    Line1.Caption  := 'Customer';
    SetHint('Displays the Customer list for you to select');
  end;

  with faryPanelBtn[1, 4] do begin
    Panel.Color    := NICE_LIME;
    Panel.ColorMirrorTo := NICE_LIME;
    HotKey.Caption := 'F4';
    Line1.Caption  := 'Print';
    SetHint('Prints an additional Receipt.' + chr(13) +
            'Template used here is the ''Default Template(POS)'' Selected for the current Till or ' +chr(13)+
            'When ''Default Template(POS)'' is not selected, the default template of type ''POS - Receipt Printer'' .'+chr(13)  );
  end;

  with faryPanelBtn[2, 1] do begin
    Panel.Color    := NICE_PINK;
    Panel.ColorMirrorTo := NICE_PINK;
    HotKey.Caption := 'F5';
    Line1.Caption  := 'Quantity';
    SetHint('After selecting a Product, ' +
      'Key in the Quantity and then select this button');
  end;

  with faryPanelBtn[2, 2] do begin
    Panel.Color    := NICE_PINK;
    Panel.ColorMirrorTo := NICE_PINK;
    HotKey.Caption := 'F6';
    Line1.Caption  := 'No Sale';
    SetHint('Use this key to cancel the current transaction and start afresh.' +
      ' Open''s the Cash drawer.');
  end;

  with faryPanelBtn[2, 3] do begin
    Panel.Color    := NICE_PINK;
    Panel.ColorMirrorTo := NICE_PINK;
    HotKey.Caption := 'F7';
    Line1.Caption  := 'Refund';
    SetHint('To perform a refund, Select this key and then select the Returned Product');
  end;

  with faryPanelBtn[2, 4] do begin
    Panel.Color    := NICE_PINK;
    Panel.ColorMirrorTo := NICE_PINK;
    HotKey.Caption := 'F8';
    Line1.Caption  := 'Cancel';
    SetHint('Use this key to cancel the current transaction and start afresh');
  end;

  with faryPanelBtn[3, 1] do begin
    Panel.Color    := NICE_BLUE;
    Panel.ColorMirrorTo := NICE_BLUE;
    HotKey.Caption := 'F9';
    Line1.Caption  := 'Cheque';
    SetHint('Use this key to finalise the transaction when the customer' +
      ' pays by Cheque. Exact amount is assumed.');
  end;

  with faryPanelBtn[3, 2] do begin
    Panel.Color    := NICE_BLUE;
    Panel.ColorMirrorTo := NICE_BLUE;
    HotKey.Caption := 'F10';
    Line1.Caption  := 'Credit Card';
    SetHint('Use this key to finalise the transaction when the customer' +
      ' pays by Credit Card. Exact amount is assumed.');
  end;

  with faryPanelBtn[3, 3] do begin
    Panel.Color    := NICE_BLUE;
    Panel.ColorMirrorTo := NICE_BLUE;
    HotKey.Caption := 'F11';
    Line1.Caption  := 'EFTPOS';
    SetHint('Use this key to finalise the transaction when the customer' +
      ' pays by EFTPOS. Exact amount is assumed.');
  end;

  with faryPanelBtn[3, 4] do begin
    Panel.Color    := NICE_BLUE;
    Panel.ColorMirrorTo := NICE_BLUE;
    HotKey.Caption := 'F12';
    Line1.Caption  := 'Cash';
    SetHint('Enter the $''s received and use this key to finalise the cash ' +
      'transaction. If no $''s keyed in then exact cash is assumed.');
  end;


  for iRow := 1 to MAX_ROW do for iCol := 1 to MAX_COL do begin
      faryPanelBtn[iRow, iCol].ResizeLines;
      faryPanelBtn[iRow, iCol].ArrangeText(20);
    end;
end;

destructor TFnBtnMatrix.Destroy;
var
  iRow, iCol: integer;
begin
  ftmrDown.Enabled := false;
  Application.ProcessMessages;
  SysUtils.FreeAndNil(ftmrDown);
  // Destroy the array of buttons
  for iRow := 1 to MAX_ROW do
    for iCol := 1 to MAX_COL do begin
      try
        SysUtils.FreeAndNil(faryPanelBtn[iRow, iCol]);
      except
        // hide exception
      end;
    end;
  inherited;
end;


procedure TFnBtnMatrix.SelectButton(BtnObj: TObject);
  // Select the  button which contains the object passed
var
  pnlPanel: TAdvPanel;
  lblBtnLabel: TLabel;
  i, j: integer;
  bSelectFound: boolean;
  bOk: boolean;
begin
  bOk := true;

  { Get the Panel Button which was clicked - either the panel or one of
    its labels could have been clicked }

  if fiSelRow <> 0 then faryPanelBtn[fiSelRow, fiSelCol].BtnUp;

  pnlPanel := nil;

  if BtnObj is TAdvPanel then begin
    pnlPanel := (BtnObj as TAdvPanel);
  end else if BtnObj is TLabel then begin
    lblBtnLabel := (BtnObj as TLabel);
    pnlPanel    := (lblBtnLabel.Parent as TAdvPanel);
  end else begin
    CommonLib.MessageDlgXP_Vista('Problem with Selecting a Button', mtWarning, [mbOK], 0);
    bOk := false;
  end;

  // Find the row and column of the button selected
  if bOk then begin
    bSelectFound := false;
    for i := 1 to MAX_ROW do begin
      for j := 1 to MAX_COL do if faryPanelBtn[i, j].Panel = pnlPanel then begin
          bSelectFound := true;
          //fbtnSelected := aryPOSBtn[i,j];
          fiSelRow := i;
          fiSelCol := j;
          faryPanelBtn[i, j].BtnDown;
          ResetftmrDown;
          Break;
        end;
      if bSelectFound = true then Break;
    end;
  end;
  inherited;  
end;

procedure TFnBtnMatrix.ftmrDownTimer(Sender: TObject);
begin
  ftmrDown.Enabled := false;
  if fiSelRow <> 0 then begin
    faryPanelBtn[fiSelRow, fiSelCol].BtnUp;
    fiSelRow := 0;
    fiSelCol := 0;
  end;
end;

procedure TFnBtnMatrix.ResetftmrDown;
begin
  ftmrDown.Enabled := false;
  ftmrDown.Enabled := true;
end;


end.
