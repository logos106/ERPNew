unit ReceiptPrinterObj;

interface

uses
  Windows, SysUtils, Dialogs, Printers, contnrs;

const
  FMT_UNDERLINE = $80;
  FMT_WIDE      = $20;
  FMT_HIGH      = $10;
  FMT_BOLD      = $8;
  FMT_NORMAL    = $1;

  NORM_CHR_WIDTH = 40;
  WIDE_CHR_WIDTH = 20;

  LJ = 1;
  CJ = 2;
  RJ = 3;


type
  TReceiptPrinter = class(TObject)
  private
    fHandle: THandle;   // handle of comm port
    fsDevice: string;
    fsPrinterType: string;
    fiRefCount: integer;

  protected
    fiType: integer;
    fiJustification: integer;
    fsBuffer: string;
    fiIndex: integer;
    fsPrinterName: string;
    procedure SetPrinterName(const Value: string); virtual;
    procedure OpenDrawer(const sCmd: string);
    procedure Send(const sText: string); virtual;
    function StrCJ(const Text: string; const Width: integer): string;
    function StrRJ(const Text: string; const Width: integer): string;
    procedure SetPrintercharset(const Value: Integer); virtual;
  public
    fbIsOpen: boolean;  // True if comm port is open
    fiWidth: integer;
    
    constructor Create; virtual;
    destructor Destroy; override;
    procedure SetDevice(const sDevice: string);
    procedure OpenPort; virtual;
    procedure InitPort;
    procedure ClosePort; virtual;
    procedure Initialize; virtual;
    procedure Justify(const iType: integer); virtual;
    procedure Format(const cFormat: char); virtual;
    procedure OpenCashDrawer; virtual; abstract;
    procedure Print(const sText: string); virtual; abstract;
    procedure PrintNoLf(const sText: string); virtual; abstract;
    procedure NewLine(const iLines: integer); virtual; abstract;
    procedure DoCR; virtual; abstract;
    procedure FeedPaperForCut; virtual; abstract;
    procedure LoadBuf(const sText: string); //virtual;
    procedure InitBuf; //virtual;
    function Combine(const Left, Right: string): string;
    property PrinterName: string read fsPrinterName Write SetPrinterName;
    property PrinteType: string read fsPrinterType Write fsPrinterType;
    property RefCount: integer read fiRefCount write fiRefCount;
    Procedure PrintLine(Linechar:String = '_');
    Property Printercharset:Integer write SetPrintercharset; 
  end;

type
  TCompanionPrn = class(TReceiptPrinter)
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure OpenCashDrawer; override;
    procedure Format(const cFormat: char); override;
    procedure Print(const sText: string); override;
    procedure PrintNoLf(const sText: string); override;
    procedure NewLine(const iLines: integer); override;
    procedure DoCR; override;
    procedure FeedPaperForCut; override;
  end;

type
  TLogPrinter = class(TReceiptPrinter)
  private
  public
    procedure OpenPort; Override;
    procedure ClosePort; Override;
    procedure Initialize; Override;
    procedure Justify(const iType: integer); Override;
    procedure Format(const cFormat: char); Override;
    procedure OpenCashDrawer; Override;
    procedure Print(const sText: string); Override;
    procedure PrintNoLf(const sText: string); Override;
    procedure NewLine(const iLines: integer); Override;
    procedure DoCR; Override;
    procedure FeedPaperForCut; Override;
  Protected
  end;

type
  TUSBPrinter = class(TReceiptPrinter)
  Private
    Prnfile: Textfile;
    fPrn : TPrinter;
    procedure SetPrn(const Value: TPrinter);
  Protected
    property prn: TPrinter read fPrn write SetPrn;
    procedure Send(const sText: string); override;
    procedure SetPrinterName(const Value: String); override;
  Public
    procedure ClosePort; override;
    procedure OpenPort; override;
    constructor Create; overload; override;
    constructor Create(Const sPrinter:String); reintroduce; overload;
    destructor Destroy; override;
    procedure OpenCashDrawer; override;
    procedure Justify(const iType: integer); override;
    procedure Format(const cFormat: char); override;
    procedure Print(const sText: string); override;
    procedure PrintNoLf(const sText: string); override;
    procedure NewLine(const iLines: integer); override;
    procedure DoCR; override;
    procedure FeedPaperForCut; override;
  End;
Type
  TEPSON_TM_U220Printer = class(TUSBPrinter)
  Private
  Public
    procedure Justify(const iType: integer); override;
end;
Type
  TEPSON_TM_T82IIPrinter = class(TUSBPrinter)
  Private
  Public
  end;
Type
  TSTAR_TSP_100 = class(TUSBPrinter)
  Private
  protected
    procedure SetPrintercharset(const Value: Integer); Override;
  Public
    constructor Create(Const sPrinter:String); reintroduce; overload;
    destructor Destroy; override;
    procedure PrintNoLf(const sText: string); override;
    procedure OpenCashDrawer; override;
    procedure Send(const sText: string); override;

end;
type
  TEpsonPrn = class(TReceiptPrinter)
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OpenCashDrawer; override;
    procedure Justify(const iType: integer); override;
    procedure Format(const cFormat: char); override;
    procedure Print(const sText: string); override;
    procedure PrintNoLf(const sText: string); override;
    procedure NewLine(const iLines: integer); override;
    procedure DoCR; override;
    procedure FeedPaperForCut; override;
  end;

type
  THeroPrn = class(TEpsonPrn)
  private
    fbFillLeft: boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OpenCashDrawer; override;
    procedure Justify(const iType: integer); override;
    procedure Format(const Format: char); override;
    procedure PrintNoLf(const Text: string); override;
    procedure FeedPaperForCut; override;
    procedure Initialize; override;
  end;

type
  TStarPrn = class(TReceiptPrinter)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OpenCashDrawer; override;
    //procedure Justify(iType: Integer); override;
    procedure Format(const cFormat: char); override;
    procedure Print(const sText: string); override;
    procedure PrintNoLf(const sText: string); override;
    procedure NewLine(const iLines: integer); override;
    procedure DoCR; override;
    procedure FeedPaperForCut; override;
  end;

type
  TCTZ460Prn = class(TStarPrn)
  private
    //fsBuffer: String;
    // fiIndex: Integer;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Format(const cFormat: char); override;
    procedure Initialize; override;
    procedure OpenCashDrawer; override;
  end;

type
  TCTZ3540Prn = class(TStarPrn)
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Format(const cFormat: char); override;
    procedure Initialize; override;
    procedure OpenCashDrawer; override;
  end;

type
 {
  The CITIZEN IDP3550 in native mode lacks support of bold etc (infact I could not
  get any of the char features going) so best to use STAR emulation
  mode.  This is a close emulation of the STAR except for Wide Char
  cancel and also need to watch the setting of the external drive
  pulse width (for the cash drawer). If the pulse width params n1 & n2
  are set to #20 and #50 then the printer gets set to double line mode :-0
  If set to #21 and #51 then all OK - that's all I can tell you about this
  bug.  This driver will work if Dip switches are set as follows (may work on
  other settings also)
    1-1  Off
    1-2  On
    1-3  On
    1-4  On
    1-5  Off
    1-6  Off
    1-7  Off
    1-8  On
    1-9  Off
    1-10 On
 }

  TCitizenPrn = class(TStarPrn)
    // Citizen IDP3550
  public
    procedure Format(const cFormat: char); override;
    procedure Print(const sText: string); override;
    procedure OpenCashDrawer; override;
    procedure Initialize; override;
  end;

  TReceiptPrinterList = class
  private
    fList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    function CreatePrinter(const sPrnType: string; sPrinterName:String): TReceiptPrinter;
    procedure FreePrinter(var aPrinter: TReceiptPrinter);
  end;


  function ReceiptPrinterList: TReceiptPrinterList;
  Procedure FreeReceiptPrinterList;

  // ----------------------------------------------------------------------------

implementation

uses
  Graphics, CommonLib, FastFuncs, AppEnvironment, classes, LogLib, tcConst;




const
  CONFIG = 'baud=9600 parity=n data=8 stop=1' + #0; // comm port config

  // ASCII control chars
  ASC_NUL = #0;
  BS      = #8;
  ESC     = #27;
  LF      = #10;
  CR      = #13;
  BELL    = #7;
  SO      = #14;
  SI      = #15;
  DC1     = #17;
  DC2     = #18;
  DC4     = #20;
  CAN     = #24;
  RS      = #30;
  US      = #31;
  FS      = #28;

  // Device types
  NUL      = 0;
  SERIAL   = 1;
  PARALLEL = 2;

  // Epson
  LJ_EPSON          = ESC + 'a0';
  CJ_EPSON          = ESC + 'a1';
  RJ_EPSON          = CR + ESC + 'a2';
  FMT_EPSON         = ESC + '!';
  OPEN_DRAWER_EPSON = ESC + 'p' + #48 + #100 + #250 + #13; // open cash drawer

  OPEN_DRAWER_USBPRINTER = 'A'; // open cash drawer

  // Companion
  INIT_COMPANION         = CAN;
  BOLD_SET_COMPANION     = '^D15';
  BOLD_CANCEL_COMPANION  = '^D06';
  UNDER_SET_COMPANION    = '^V';     // unsupported make it reversed
  UNDER_CANCEL_COMPANION = '^v';
  WIDE_SET_COMPANION     = '^A22';
  WIDE_CANCEL_COMPANION  = '^A12';
  HIGH_SET_COMPANION     = '^A22';      // same as wide for now
  HIGH_CANCEL_COMPANION  = '^A12';
  OPEN_DRAWER_COMPANION  = '^K';   // open cash drawer
  LEFT_MARGIN_COMPANION  = '^M05'; // Set left margin to 5mm to allow for exta width

  // Star
  BOLD_SET_STAR     = ESC + 'E';
  BOLD_CANCEL_STAR  = ESC + 'F';
  UNDER_SET_STAR    = ESC + '-1';
  UNDER_CANCEL_STAR = ESC + '-0';
  WIDE_SET_STAR     = ESC + 'W1';
  WIDE_CANCEL_STAR  = ESC + 'W0';
  HIGH_SET_STAR     = ESC + 'E';      // not supported, just make it bold
  HIGH_CANCEL_STAR  = ESC + 'F';
  OPEN_DRAWER_STAR  = ESC + BELL + #20 + #50 + BELL; // open cash drawer


  // Hero TH200
  CUT_HERO         = #$1D + #$56 + #$1; // note 2nd Cut function does not seem to work
  LEFT_MARGIN_HERO = #$1D#$4C#1#1; // i don't think this works
  INIT_HERO        = ESC + '@';

  // Citizen Printer IDP3550 - 'Star' Mode
  BOLD_SET_CTZ     = ESC + 'E';
  BOLD_CANCEL_CTZ  = ESC + 'F';
  UNDER_SET_CTZ    = ESC + '-1';
  UNDER_CANCEL_CTZ = ESC + '-0';
  WIDE_SET_CTZ     = SO;
  WIDE_CANCEL_CTZ  = DC4;
  HIGH_SET_CTZ     = ESC + '-1';      // not supported - just make it underline
  HIGH_CANCEL_CTZ  = ESC + '-0';
  // for Citizen don't use #20 and #50 as this sets printer to double line mode :-0
  OPEN_DRAWER_CTZ = ESC + BELL + #21 + #51 + BELL; // open cash drawer
  INIT_CTZ        = ESC + '@';

  // Citizen Printer IDP3540
  UNDER_SET_CTZ3540    = ESC + '-1';  // not supported - just make it underline
  UNDER_CANCEL_CTZ3540 = ESC + '-0';
  BOLD_SET_CTZ3540     = UNDER_SET_CTZ3540;
  BOLD_CANCEL_CTZ3540  = UNDER_CANCEL_CTZ3540;
  WIDE_SET_CTZ3540     = SO;
  WIDE_CANCEL_CTZ3540  = SI;
  HIGH_SET_CTZ3540     = UNDER_SET_CTZ3540;      // not supported - just make it underline
  HIGH_CANCEL_CTZ3540  = UNDER_CANCEL_CTZ3540;
  OPEN_DRAWER_CTZ3540  = ESC + BELL + #21 + #51 + BELL; // open cash drawer
  INIT_CTZ3540         = DC1;

  // Citizen Printer IDP460
  // I can't get any of the "print head type" character attributes below to work
  HIGH_SET_CTZ460     = ESC + 'a20;';
  HIGH_CANCEL_CTZ460  = ESC + 'a10;';
  BOLD_SET_CTZ460     = DC2;       // set to red
  BOLD_CANCEL_CTZ460  = ASC_NUL;   // 460 - resets after each char (do not use)
  UNDER_SET_CTZ460    = HIGH_SET_CTZ460;       // not supported - make high chars
  UNDER_CANCEL_CTZ460 = HIGH_CANCEL_CTZ460;
  WIDE_SET_CTZ460     = RS;
  WIDE_CANCEL_CTZ460  = US;
  OPEN_DRAWER_CTZ460  = BELL;
  INIT_CTZ460         = ESC + 'c';

type
  ePrnOpenError  = class(Exception);
  ePrnInitError  = class(Exception);
  ePrnWriteError = class(Exception);
  ePrnCloseError = class(Exception);

var
  ReceiptPrinterListVar: TReceiptPrinterList;
Procedure FreeReceiptPrinterList;
begin
  if not Assigned(ReceiptPrinterListVar) then Exit;
  ReceiptPrinterListVar := nil;
end;
function ReceiptPrinterList: TReceiptPrinterList;
begin
  if not Assigned(ReceiptPrinterListVar) then
    ReceiptPrinterListVar:= TReceiptPrinterList.Create;
  result:= ReceiptPrinterListVar;
end;


constructor TReceiptPrinter.Create;
begin
  inherited Create;
  //  fiPort := iPort;
  fiRefCount:= 0;
  fsDevice := 'COM1:';
  fiType := SERIAL;
  fiWidth := NORM_CHR_WIDTH;
  fbIsOpen := false;
  //logtext('1 ' +Self.classname +' : created');
end;

procedure TReceiptPrinter.SetDevice(const sDevice: string);
var
  bOK: boolean;
begin
  if fiRefCount > 1 then exit;
  bOK := true;
  fsDevice := SysUtils.UpperCase(SysUtils.Trim(sDevice));
  if fsDevice[char_length(fsDevice)] = ':' then begin   // to be sure, to be sure
    Setlength(fsDevice, char_length(fsDevice) - 1);     // knock off colon

         if FastFuncs.PosEx('COM', fsDevice)            = 1 then fiType := SERIAL
    else if FastFuncs.PosEx('EPSON-TM-U220', fsDevice)  = 1 then fiType := SERIAL
    else if FastFuncs.PosEx('EPSON-TM-T82II', fsDevice)  = 1 then fiType := SERIAL
    else if FastFuncs.PosEx('STAR-TSP-100', fsDevice)   = 1 then fiType := SERIAL
    else if FastFuncs.PosEx('ESDPRT002', fsDevice)      = 1 then fiType := SERIAL
    else if FastFuncs.PosEx('LPT', fsDevice)            = 1 then fiType := PARALLEL
    else if FastFuncs.PosEx('NUL', fsDevice)            = 1 then fiType := NUL
    else if FastFuncs.PosEx('EPSON', fsDevice)          = 1 then fiType := SERIAL
    else bOk := false;

  end else bOK := false;
  if not bOK then begin
    //    fsDevice := 'COM1:';
    fsDevice := 'COM1';
    fiType   := SERIAL;
  end;
end;

procedure TReceiptPrinter.OpenPort;
var
  ayDeviceName: array[0..80] of char;
  (*driver, port:String;*)
begin
  if fiType <> NUL then begin
    if not fbIsOpen then begin
      StrPCopy(ayDeviceName, fsDevice);                                                                                                                     //logtext('1-1');

      {fHandle := CreateFile(ayDeviceName, GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, (*FILE_ATTRIBUTE_NORMAL*)FILE_FLAG_OVERLAPPED, 0);}
      fHandle := CreateFile(ayDeviceName, GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);                                  //logtext('1-2');
      if fHandle = INVALID_HANDLE_VALUE then begin
        fbIsOpen := false;                                                                                                                                  //logtext('1-3');
        CommonLib.MessageDlgXP_Vista('Could not open printer port', mtWarning, [mbOK], 0);                                                                  //logtext('1-4');
        //Raise(ePrnOpenError.Create('Could not open printer port'));
      end else begin
        fbIsOpen := true;                                                                                                                                   //logtext('1-5');
      end;
    end;
  end else begin
    fbIsOpen := false;                                                                                                                                      //logtext('1-6');
  end;

  if fbIsOpen and (fiType = SERIAL) then begin
    InitPort;                                                                                                                                               //logtext('1-7');
  end;
end;

procedure TReceiptPrinter.InitPort;
const
  RxBufferSize = 256;
  TxBufferSize = 256;
var
  DCB: TDCB;
begin
  if fbIsOpen then begin
    if not SetupComm(fHandle, RxBufferSize, TxBufferSize) then
      CommonLib.MessageDlgXP_Vista('Could not Initialize printer port', mtWarning, [mbOK], 0);
    //Raise(ePrnInitError.Create('Could not Initialize printer port'));

    if not GetCommState(fHandle, DCB) then CommonLib.MessageDlgXP_Vista('Could not Initialize printer port', mtWarning, [mbOK], 0);
    //raise(ePrnInitError.Create('Could not Initialize printer port'));


    if not BuildCommDCB(@CONFIG[1], DCB) then CommonLib.MessageDlgXP_Vista('Could not Initialize printer port', mtWarning, [mbOK], 0);
    //raise(ePrnInitError.Create('Could not Initialize printer port'));

    DCB.Flags := DCB.Flags or $08;  // turn on DSR flow control bit

    if not SetCommState(fHandle, DCB) then CommonLib.MessageDlgXP_Vista('Could not Initialize printer port', mtWarning, [mbOK], 0);
    //raise(ePrnInitError.Create('Could not Initialize printer port'));
  end;
end;

procedure TReceiptPrinter.Initialize;
begin
  if fiRefCount > 1 then exit;

  // do nothing for now
end;

procedure TReceiptPrinter.Send(const sText: string);
var
  iBytesWritten: DWORD;
  xtext : AnsiString;
begin
  xtext := AnsiString(sText);
  if fbIsOpen then begin
    if not WriteFile(fHandle, xtext[1], length(xtext), iBytesWritten, nil) then
      CommonLib.MessageDlgXP_Vista('Could not write to printer', mtWarning, [mbOK], 0);
    //raise(ePrnWriteError.Create('Could not write to printer'));
    if integer(iBytesWritten) <> length(xtext) then CommonLib.MessageDlgXP_Vista('Could not write to printer', mtWarning, [mbOK], 0);
    //raise(ePrnWriteError.Create('Could not write to printer'));
  end;
(*var
  iBytesWritten: DWORD;
begin

  if fbIsOpen then begin
    if not WriteFile(fHandle, sText[1], char_length(sText), iBytesWritten, nil) then
      CommonLib.MessageDlgXP_Vista('Could not write to printer', mtWarning, [mbOK], 0);
    //raise(ePrnWriteError.Create('Could not write to printer'));
    if integer(iBytesWritten) <> char_length(sText) then CommonLib.MessageDlgXP_Vista('Could not write to printer', mtWarning, [mbOK], 0);
    //raise(ePrnWriteError.Create('Could not write to printer'));
  end;*)
end;


procedure TReceiptPrinter.ClosePort;
begin
  if fbIsOpen then begin
    if CloseHandle(fHandle) then fbIsOpen := false
    else CommonLib.MessageDlgXP_Vista('Could not Close printer port', mtWarning, [mbOK], 0);
    //raise(ePrnCloseError.Create('Could not Close printer port'));
  end;
end;

procedure TReceiptPrinter.Justify(const iType: integer);
begin
  fiJustification := iType;
end;

procedure TReceiptPrinter.Format(const cFormat: char);
begin
  // do nothing for now
end;

procedure TReceiptPrinter.OpenDrawer(const sCmd: string);
begin
try
  if not fbIsOpen then begin
    OpenPort;
    Send(sCmd);
    ClosePort;
  end else begin
    Send(sCmd);
  end;
Except


end;
end;

function TReceiptPrinter.StrCJ(const Text: string; const Width: integer): string;
var
  iWidth, iWidthRJ: integer;
  sText: string;
begin
  iWidth := Width;
  sText := Text;
  if char_length(sText) <= iWidth then begin
    iWidthRJ := ((iWidth - char_length(sText)) div 2) + char_length(sText);
    Result   := StrRJ(sText, iWidthRJ);
  end else begin
    Setlength(sText, iWidth);
    Result := sText;
  end;
end;

function TReceiptPrinter.StrRJ(const Text: string; const Width: integer): string;
var
  sPadded: string;
  i: integer;
  sText: string;
  iWidth: integer;
begin
  sText := Text;
  iWidth := Width;
  Setlength(sPadded, iWidth);
  if char_length(sText) <= iWidth then begin
    for i := 1 to iWidth do sPadded[i] := ' ';
    for i := char_length(sText) downto 1 do sPadded[i + (char_length(sPadded) - char_length(sText))] := sText[i];
    Result := sPadded
  end else begin
    Setlength(sText, iWidth);
    Result := sText;
  end;
end;

procedure TReceiptPrinter.LoadBuf(const sText: string);
var
  i, iLimit: integer;
begin
  if char_length(sText) <> 0 then begin
    iLimit := fiIndex + char_length(sText) - 1;
    if iLimit > char_length(fsBuffer) then iLimit := char_length(fsBuffer);
    for i := fiIndex to iLimit do if sText[i] <> ' ' then fsBuffer[i + fiIndex - 1] := sText[i];
    fiIndex := iLimit + 1;
  end;
end;

procedure TReceiptPrinter.InitBuf;
var
  i: integer;
begin
  Setlength(fsBuffer, fiWidth);
  for i := 1 to fiWidth do fsBuffer[i] := ' ';
  fiIndex := 1;
end;

function TReceiptPrinter.Combine(const Left, Right: string): string;
var
  iSpaces: integer;
  i: integer;
  sLeft, sRight: string;
begin
  Result := '';
  sLeft := TrimRight(Left);
  sRight := TrimLeft(Right);
  if char_length(sLeft) <= fiWidth then begin
    Result  := sLeft;
    iSpaces := fiWidth - (char_length(sLeft) + char_length(sRight));
    if iSpaces >= 0 then begin
      for i := 1 to iSpaces do begin
        Result := Result + ' ';
      end;
      Result := Result + sRight;
    end;
  end;
end;

destructor TReceiptPrinter.Destroy;
begin
  ClosePort;
  //logtext('1:' +Self.classname +' : destroyed');
  inherited;
end;

// ----------------------------------------------------------------------------

constructor TCompanionPrn.Create;
begin
  inherited;
  InitBuf;
  //logtext('2 ' +Self.classname +' : created');
end;

destructor TCompanionPrn.Destroy;
begin
  //logtext('2 '+Self.classname +' : destroyed');
  inherited;
end;

procedure TCompanionPrn.Initialize;
begin
  inherited;
  if fiRefCount > 1 then exit;
  Send(INIT_COMPANION + LEFT_MARGIN_COMPANION + '^S1' + CR);
end;

procedure TCompanionPrn.Format(const cFormat: char);
begin
  if (integer(cFormat) and FMT_WIDE) <> 0 then begin
    Send(WIDE_SET_COMPANION);
    fiWidth := WIDE_CHR_WIDTH;
  end else begin
    Send(WIDE_CANCEL_COMPANION);
    fiWidth := NORM_CHR_WIDTH;
  end;

  if (integer(cFormat) and FMT_BOLD) or (integer(cFormat) and FMT_HIGH) <> 0 then Send(BOLD_SET_COMPANION)
  else Send(BOLD_CANCEL_COMPANION);

  if (integer(cFormat) and FMT_UNDERLINE) <> 0 then Send(UNDER_SET_COMPANION)
  else Send(UNDER_CANCEL_COMPANION);
end;


procedure TCompanionPrn.OpenCashDrawer;
begin
  inherited OpenDrawer(OPEN_DRAWER_COMPANION);
end;

procedure TCompanionPrn.PrintNoLF(const sText: string);
begin
  case fiJustification of
    LJ: LoadBuf(sText);
    RJ: LoadBuf(StrRJ(sText, fiWidth));
    CJ: LoadBuf(StrCJ(sText, fiWidth));
    else LoadBuf(sText);
  end;
end;

procedure TCompanionPrn.Print(const sText: string);
begin
  Send(LEFT_MARGIN_COMPANION);
  PrintNoLF(sText);
  NewLine(1);
end;

procedure TCompanionPrn.NewLine(const iLines: integer);
var
  i: integer;
begin
  if char_length(fsBuffer) <> 0 then Send(fsBuffer);
  for i := 1 to iLines do Send(LF);
  InitBuf;
end;

procedure TCompanionPrn.DoCR;
begin
  fiIndex := 1;
end;

procedure TCompanionPrn.FeedPaperForCut;
begin
  Format(Chr(FMT_NORMAL));
  NewLine(4);
end;



// ----------------------------------------------------------------------------

constructor TEpsonPrn.Create;
begin
  inherited;
  //logtext('3 ' +Self.classname +' : created');
end;

destructor TEpsonPrn.Destroy;
begin
  //logtext('3 '+Self.classname +' : destroyed');
  inherited;
end;

procedure TEpsonPrn.Justify(const iType: integer);
begin
  inherited;
  case iType of
    CJ: Send(CJ_EPSON);
    LJ: Send(LJ_EPSON);
    RJ: Send(RJ_EPSON);
  end;
end;

procedure TEpsonPrn.Format(const cFormat: char);
begin
  Send(FMT_EPSON + cFormat);
end;

procedure TEpsonPrn.OpenCashDrawer;
begin
  inherited OpenDrawer(OPEN_DRAWER_EPSON);
end;

procedure TEpsonPrn.Print(const sText: string);
begin
  PrintNoLf(sText);
  NewLine(1);
end;

procedure TEpsonPrn.PrintNoLf(const sText: string);
begin
  Send(sText);
end;

procedure TEpsonPrn.NewLine(const iLines: integer);
var
  i: integer;
begin
  for i := 1 to iLines do Send(LF);
end;

procedure TEpsonPrn.DoCR;
begin
  Send(CR);
end;

procedure TEpsonPrn.FeedPaperForCut;
begin
  Format(Chr(FMT_NORMAL));
  NewLine(5);
end;


// ----------------------------------------------------------------------------

constructor THeroPrn.Create;
begin
  inherited;
  fbFillLeft := true;
  //logtext('4 ' +Self.classname +' : created');
end;

procedure THeroPrn.Justify(const iType: integer);
begin
  inherited;
  fbFillLeft := (iType = LJ);
end;

procedure THeroPrn.Format(const Format: char);
var
  iFormat: integer;
  cFormat: char;
begin
  // cFormat is in epson format which is fine except for bit 0 which selcts the
  // ..wrong font for the Hero
  cFormat := Format;
  iFormat := integer(cFormat);
  iFormat := iFormat and $FE;  // clear bit 0
  cFormat := char(iFormat);
  Send(FMT_EPSON + cFormat);
end;

procedure THeroPrn.OpenCashDrawer;
begin
  inherited OpenDrawer(OPEN_DRAWER_EPSON);
end;

procedure THeroPrn.PrintNoLf(const Text: string);
var
  sText: string;
begin
  sText := Text;
  if fbFillLeft then begin
    sText := '  ' + sText;   // cuz hero is wider
  end;
  inherited;
end;

destructor THeroPrn.Destroy;
begin
  //logtext('4 '+Self.classname +' : destroyed');
  inherited;
end;

procedure THeroPrn.FeedPaperForCut;
begin
  NewLine(6);
  Send(CUT_HERO);
end;

procedure THeroPrn.Initialize;
begin
  inherited;
  if fiRefCount > 1 then exit;
  Send(INIT_HERO);
end;


// ----------------------------------------------------------------------------

constructor TStarPrn.Create;
begin
  inherited;
  InitBuf;
  //logtext('5 ' +Self.classname +' : created');
end;

destructor TStarPrn.Destroy;
begin
  //logtext('5 '+Self.classname +' : destroyed');
  inherited;
end;


procedure TStarPrn.Format(const cFormat: char);
{
  UNDERLINE = $80;
  WIDE = $20;
  HIGH = $10;
  BOLD = $8;
  NORMAL = $1;
}
begin
  if (integer(cFormat) and FMT_WIDE) <> 0 then begin
    Send(WIDE_SET_STAR);
    fiWidth := WIDE_CHR_WIDTH;
  end else begin
    Send(WIDE_CANCEL_STAR);
    fiWidth := NORM_CHR_WIDTH;
  end;

  if (integer(cFormat) and FMT_BOLD) or (integer(cFormat) and FMT_HIGH) <> 0 then Send(BOLD_SET_STAR)
  else Send(BOLD_CANCEL_STAR);

  if (integer(cFormat) and FMT_UNDERLINE) <> 0 then Send(UNDER_SET_STAR)
  else Send(UNDER_CANCEL_STAR);
end;

procedure TStarPrn.OpenCashDrawer;
begin
  inherited OpenDrawer(OPEN_DRAWER_STAR);
end;

procedure TStarPrn.PrintNoLF(const sText: string);
begin
  case fiJustification of
    LJ: LoadBuf(sText);
    RJ: LoadBuf(StrRJ(sText, fiWidth));
    CJ: LoadBuf(StrCJ(sText, fiWidth));
  end;
end;

procedure TStarPrn.Print(const sText: string);
begin
  PrintNoLF(sText);
  NewLine(1);
end;

procedure TStarPrn.NewLine(const iLines: integer);
var
  i: integer;
begin
  if char_length(fsBuffer) <> 0 then Send(fsBuffer);
  for i := 1 to iLines do Send(LF);
  InitBuf;
end;

procedure TStarPrn.DoCR;
begin
  fiIndex := 1;
end;

procedure TStarPrn.FeedPaperForCut;
begin
  Format(Chr(FMT_NORMAL));
  NewLine(6);
end;

// ----------------------------------------------------------------------------

constructor TCTZ460Prn.Create;
begin
  inherited;
  InitBuf;
  //logtext('6 ' +Self.classname +' : created');
end;

destructor TCTZ460Prn.Destroy;
begin
  //logtext('6 '+Self.classname +' : destroyed');
  inherited;
end;

procedure TCTZ460Prn.Format(const cFormat: char);
begin
(*
  // can't get wide char mode to work, - ignore it
  if (Integer(cFormat) and WIDE) <> 0 then begin
    Send(WIDE_SET_CTZ460);
    fiWidth := WIDE_CHR_WIDTH;
  end else begin
    Send(WIDE_CANCEL_CTZ460);
    fiWidth := NORM_CHR_WIDTH;
  end;
*)

(*
  Don't wanna to print in red
  // Bold is not supported, print red instead
  if (Integer(cFormat) and BOLD) <> 0 then
    Send(BOLD_SET_CTZ460)
  else
    Send(BOLD_CANCEL_CTZ460);
*)

(*
  Same old deal - can't get it to go
  if ((Integer(cFormat) and HIGH)) <> 0 then
    Send(HIGH_SET_CTZ460)
  else
    Send(HIGH_CANCEL_CTZ460);
*)
end;

procedure TCTZ460Prn.OpenCashDrawer;
begin
  OpenDrawer(OPEN_DRAWER_CTZ460);
end;


procedure TCTZ460Prn.Initialize;
begin
  inherited;
  if fiRefCount > 1 then exit;
  Send(INIT_CTZ460);
end;



// ----------------------------------------------------------------------------

constructor TCTZ3540Prn.Create;
begin
  inherited;
  InitBuf;
  //logtext('7 ' +Self.classname +' : created');
end;

destructor TCTZ3540Prn.Destroy;
begin
  //logtext('7 '+Self.classname +' : destroyed');
  inherited;
end;

procedure TCTZ3540Prn.Format(const cFormat: char);
begin
(*
  I can't get any of the formatting modes to work, so we might as well just ignore them
  if (Integer(cFormat) and WIDE) <> 0 then begin
    Send(WIDE_SET_CTZ3540);
    fiWidth := WIDE_CHR_WIDTH;
  end else begin
    Send(WIDE_CANCEL_CTZ3540);
    fiWidth := NORM_CHR_WIDTH;
  end;

  if ((Integer(cFormat) and UNDERLINE) or
      (Integer(cFormat) and BOLD) or
      (Integer(cFormat) and HIGH)) <> 0 then
    Send(UNDER_SET_CTZ3540)
  else
    Send(UNDER_CANCEL_CTZ3540);
*)
end;

procedure TCTZ3540Prn.OpenCashDrawer;
begin
  OpenDrawer(OPEN_DRAWER_CTZ3540);
end;


procedure TCTZ3540Prn.Initialize;
begin
  inherited;
  if fiRefCount > 1 then exit;
  Send(INIT_CTZ3540);
end;

// ----------------------------------------------------------------------------

procedure TCitizenPrn.Format(const cFormat: char);
begin
  if (integer(cFormat) and FMT_WIDE) <> 0 then begin
    Send(WIDE_SET_CTZ);
    fiWidth := WIDE_CHR_WIDTH;
  end else begin
    Send(WIDE_CANCEL_CTZ);
    fiWidth := NORM_CHR_WIDTH;
  end;

  if (integer(cFormat) and FMT_BOLD) <> 0 then Send(BOLD_SET_CTZ)
  else Send(BOLD_CANCEL_CTZ);

  if (integer(cFormat) and FMT_HIGH) <> 0 then Send(HIGH_SET_CTZ)
  else Send(HIGH_CANCEL_CTZ);

  if (integer(cFormat) and FMT_UNDERLINE) <> 0 then Send(UNDER_SET_CTZ)
  else Send(UNDER_CANCEL_CTZ);
end;

procedure TCitizenPrn.Print(const sText: string);
begin
  inherited;
end;

procedure TCitizenPrn.Initialize;
begin
  inherited;
  if fiRefCount > 1 then exit;
  Send(INIT_CTZ);
end;


procedure TCitizenPrn.OpenCashDrawer;
begin
  OpenDrawer(OPEN_DRAWER_CTZ);
end;

{ TUSBPrinter }

procedure TUSBPrinter.ClosePort;
begin
  if not fbIsOpen then
    exit;

  try
    System.CloseFile(Prnfile);
  except
    { ignore i/o 103 error if file already closed }
  end;
  fbIsOpen:= False;
end;

constructor TUSBPrinter.Create;
begin
  inherited;
  //logtext('8 ' +Self.classname +' : created');
end;

constructor TUSBPrinter.Create(const sPrinter: String);
begin
  prn  := Printer;
  Printername := sPrinter;
  prn.Canvas.Font.Name := 'Arial';
  prn.Canvas.Font.Pitch :=  fpFixed;
  prn.Canvas.font.Size := 9;
  fiWidth := NORM_CHR_WIDTH;
  fbIsOpen := false;
  (*prn.Canvas.Font.Name := 'Arial';
  prn.Canvas.font.Size := 9;
  AssignPrn(Prnfile);
  Rewrite(Prnfile);*)
  //logtext('9 ' +Self.classname +'(sPrinter) : created');
end;

destructor TUSBPrinter.Destroy;
begin
  try
    //logtext('8 '+Self.classname +' : destroyed');
    inherited;
  Except
      // Destroy of the printer object check its printing status as true  which creates an exception
      //kill it  
  end;
end;

procedure TUSBPrinter.DoCR;
begin
  Send(CR);
end;

procedure TUSBPrinter.FeedPaperForCut;
begin
  Format(Chr(FMT_NORMAL));
  NewLine(5);
end;

procedure TUSBPrinter.Format(const cFormat: char);
begin
  (*Send(FMT_EPSON + cFormat);*)
end;

procedure TUSBPrinter.Justify(const iType: integer);
begin
  inherited;
end;

procedure TUSBPrinter.NewLine(const iLines: integer);
var
  i: integer;
begin
  if iLines<=1 then exit;
  for i := 1 to iLines-1 do Send(LF);
end;

procedure TUSBPrinter.OpenCashDrawer;
begin
  (*inherited OpenDrawer(OPEN_DRAWER_EPSON);*)
  (*OpenPort;*)
  prn.Canvas.Font.Name := 'Control';
  prn.Canvas.font.Size := 9;
  (*send(OPEN_DRAWER_USBPRINTER);*)
 (* Closeport;*)
 OpenDrawer(OPEN_DRAWER_USBPRINTER);
 prn.Canvas.Font.Name := 'Arial';
 prn.Canvas.Font.Pitch :=  fpFixed;
end;

procedure TUSBPrinter.OpenPort;
begin
  //inherited;
  AssignPrn(Prnfile);         //logtext('1-8');
  Rewrite(Prnfile);           //logtext('1-9');
  fbIsOpen := true;           //logtext('1-10');

end;

procedure TUSBPrinter.Print(const sText: string);
begin
  PrintNoLf(sText);
end;

procedure TUSBPrinter.PrintNoLf(const sText: string);
begin
  Send(sText);
end;

procedure TUSBPrinter.Send(const sText: string);
begin
  try
    Writeln(Prnfile,sText);
  Except
      on E:Exception do begin
        CommonLib.MessageDlgXP_Vista('Could not write to printer'+chr(13)+chr(13)+E.Message, mtWarning, [mbOK], 0);
      end;
  end;
end;

procedure TUSBPrinter.SetPrinterName(const Value: String);
begin
  if prn.Printers.IndexOf(Value) <> -1 then begin
    fsPrintername := Value;
    prn.PrinterIndex := prn.Printers.IndexOf(Value);
  end;
end;



procedure TUSBPrinter.SetPrn(const Value: TPrinter);
begin
  fPrn := Value;
end;

{ TLogPrinter }

procedure TLogPrinter.ClosePort;
begin
(*  inherited;*)
end;

procedure TLogPrinter.DoCR;
begin
(*  inherited;*)

end;

procedure TLogPrinter.FeedPaperForCut;
begin
(*  inherited;*)

end;

procedure TLogPrinter.Format(const cFormat: char);
begin
(*  inherited;*)
end;

procedure TLogPrinter.Initialize;
begin
(*  inherited;*)
  if fiRefCount > 1 then exit;
end;

procedure TLogPrinter.Justify(const iType: integer);
begin
(*  inherited;*)
end;

procedure TLogPrinter.NewLine(const iLines: integer);
begin
(*  inherited;*)

end;

procedure TLogPrinter.OpenCashDrawer;
begin
(*  inherited;*)

end;

procedure TLogPrinter.OpenPort;
begin
(*  inherited;*)

end;

procedure TLogPrinter.Print(const sText: string);
begin
(*  inherited;*)
end;

procedure TLogPrinter.PrintNoLf(const sText: string);
begin
(*  inherited;*)

end;

procedure TReceiptPrinter.SetPrinterName(const Value: string);
begin
  fsPrinterName := Value;
end;

{ TReceiptPrinterList }

constructor TReceiptPrinterList.Create;
begin
  //logtext('Creating  TReceiptPrinterList');
  fList:= TObjectList.Create(true);
  //logtext('10 ' +Self.classname +' : created');
end;

function TReceiptPrinterList.CreatePrinter(const sPrnType: string;
  sPrinterName: String): TReceiptPrinter;
var
  ptr: TReceiptPrinter;
  x: integer;
begin
  ptr:= nil;
  //logtext('Receipt Printers Count : ' + inttostr(fList.Count));
  for x:=  fList.Count -1 downto 0 do begin
    try
      //logtext('Printer Loop:' + inttostr(x));
      ptr:= TReceiptPrinter(fList[x]);
      if (ptr.PrinteType = sPrnType) and (ptr.PrinterName = sPrinterName) then begin
        //logtext('Receipt Printer Found , Index :   ' + inttostr(x));
        break;
      end;
    Except
      on E:Exception do begin
        //logtext('Receipt Printer Found with error, Index :   ' + inttostr(x));
        fList.Delete(x);
        //logtext('Receipt Printers Count after delete: ' + inttostr(fList.Count));
      end;
    end;
  end;
  if not Assigned(ptr) then begin
    if Sysutils.SameText('EPSON', sPrnType) then begin
      ptr := TEpsonPrn.Create;
      ptr.PrinterName:= sPrinterName;
    end
    else if Sysutils.SameText('STAR', sPrnType) then begin
      ptr := TStarPrn.Create;
      ptr.PrinterName:= sPrinterName;
    end
    else if Sysutils.SameText('CITIZEN', sPrnType) then begin // iDP 3550
      ptr := TCitizenPrn.Create;
      ptr.PrinterName:= sPrinterName;
    end
    else if Sysutils.SameText('CTZ460', sPrnType) then begin
      ptr := TCTZ460Prn.Create;
      ptr.PrinterName:= sPrinterName;
    end
    else if Sysutils.SameText('CTZ3540', sPrnType) then begin
      ptr := TCTZ3540Prn.Create;
      ptr.PrinterName:= sPrinterName;
    end
    else if Sysutils.SameText('HERO', sPrnType) then begin
      ptr := THeroPrn.Create;
      ptr.PrinterName:= sPrinterName;
    end
    else if Sysutils.SameText('COMPANION', sPrnType) then begin // Eltron Companion
      ptr := TCompanionPrn.Create;
      ptr.PrinterName:= sPrinterName;
    end
    else if  Sysutils.SameText('EPSON-TM-U220', sPrnType) then begin // Eltron Companion
      ptr := TEPSON_TM_U220Printer.Create(sPrinterName);
    end
    else if  Sysutils.SameText('EPSON-TM-T82II', sPrnType) then begin // Eltron Companion
      ptr := TEPSON_TM_T82IIPrinter.Create(sPrinterName);
    end
    else if  Sysutils.SameText('STAR-TSP-100', sPrnType) then begin // Eltron Companion
      ptr := TSTAR_TSP_100.Create(sPrinterName);
    end
    else if Sysutils.SameText('Log file' ,sPrntype) then begin
      ptr := TLogPrinter.Create;
      ptr.PrinterName:= sPrinterName;
    end
    else begin
      ptr := TEpsonPrn.Create;
      ptr.PrinterName:= sPrinterName;
    end;
    ptr.PrinteType:= sPrntype;
    fList.Add(ptr);
    //logtext('New Receipt Printer added, Count : ' + inttostr(fList.Count));
  end;
  ptr.RefCount:= ptr.RefCount + 1;
  result:= ptr;
end;

destructor TReceiptPrinterList.Destroy;
begin
  if fList <> nil then begin
    fList.Free;
    fList := nil;
  end;
  //logtext('9 '+Self.classname +' : destroyed');
  inherited;
end;

procedure TReceiptPrinterList.FreePrinter(var aPrinter: TReceiptPrinter);
var
  idx: integer;
begin
  try
    if Assigned(aPrinter) then begin
      aPrinter.RefCount:= aPrinter.RefCount -1;
      if aPrinter.RefCount < 1 then begin
        idx:= fList.IndexOf(aPrinter);
        if idx > -1 then
          fList.Delete(idx);
        aPrinter:= nil;
      end;
    end;
  except
  end;
end;

{ TSTAR_TSP_100 }


constructor TSTAR_TSP_100.Create(const sPrinter: String);
begin
  inherited;
  prn.Canvas.Font.Name := 'Courier New';
  prn.Canvas.Font.Style := prn.Canvas.Font.Style +[fsBold];
  fiWidth := 38;
  //logtext('11 ' +Self.classname +' : created');
end;




destructor TSTAR_TSP_100.Destroy;
begin
  //logtext('10 '+Self.classname +' : destroyed');
  inherited;
end;

procedure TSTAR_TSP_100.OpenCashDrawer;
begin
  inherited;
 prn.Canvas.Font.Name := 'Courier New';
 prn.Canvas.Font.Pitch :=  fpFixed;
end;

procedure TSTAR_TSP_100.PrintNoLf(const sText: string);
begin
    prn.Canvas.Font.Pitch := fpFixed;
    case fiJustification of
      LJ: send(sText);
      RJ: send(StrRJ(sText, fiWidth));
      CJ: send(StrCJ(sText, fiWidth));
      else send(sText);
    end;
end;

procedure TSTAR_TSP_100.Send(const sText: string);
begin
  inherited;

end;

procedure TSTAR_TSP_100.SetPrintercharset(const Value: Integer);
begin
  inherited;
  Prn.Canvas.Font.Charset := value;
end;

{ TEPSON_TM_U220Printer }

procedure TEPSON_TM_U220Printer.Justify(const iType: integer);
begin
  (*inherited;*)
end;

procedure TReceiptPrinter.PrintLine(Linechar: String = '_');
begin
  Justify(LJ);
  Print(ReplicateStr(Linechar, fiwidth ));
end;

procedure TReceiptPrinter.SetPrintercharset(const Value: Integer);
begin

end;

initialization

finalization
  ReceiptPrinterListVar.Free;

end.














