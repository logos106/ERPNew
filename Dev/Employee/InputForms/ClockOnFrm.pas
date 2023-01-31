unit ClockOnFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, DataState,
  Menus, AdvMenus, Shader, ImgList, wwclearbuttongroup, wwradiogroup, MemDS,
  ProgressDialog , busobjRoster , BusObjBase;

type
  TClockOnGUI = class(TBaseInputGUI)
    btnCancel: TDNMSpeedButton;
    StatusPanel: TDNMPanel;
    lblEmployee: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblClockOn: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    grpOptions: TRadioGroup;
    edtBarcodeInput: TEdit;
    lblMsg: TLabel;
    tmrclock: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtBarcodeInputKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure grpOptionsClick(Sender: TObject);
    procedure tmrclockTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    dtClockTime: TDateTime;
    ClockedRoster : TClockedRoster;
    sEmployeeName: string;

    function AutoDetect(iEmployeeID: integer): boolean;
    function ClockOn(iEmployeeID: integer): boolean;
    function ClockOffEmployee(iEmployeeID: integer): boolean;
    function ClockOnEmployee(iEmployeeID: integer): boolean;
    function ClockOff(iRosterID: integer): boolean;
    function LocateClockedOn(iEmployeeID: integer): integer;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }

    procedure ClockIt;
  end;


implementation
{$R *.dfm}

uses
  DNMLib, CommonDbLib,  strUtils, DateUtils, CommonLib,
  AppEnvironment, FastFuncs ;

{ TClockOnGUI }
function TClockOnGUI.LocateClockedOn(iEmployeeID: integer): integer;
begin
  ClockedRoster.LoadSelect('EmployeeID = ' + IntToStr(iEmployeeID) + ' AND  Type = "Clocked" AND  ClockedOff <> "T"  AND IsClocked ="T"');
  Result :=ClockedRoster.ID;
end;
procedure TClockOnGUI.tmrclockTimer(Sender: TObject);
begin
  inherited;
   lblClockOn.Caption := FormatDateTime (formatSettings.ShortDateFormat +'  ' + FormatSettings.LongTimeFormat , now);
   lblClockOn.Refresh;
end;

function TClockOnGUI.AutoDetect(iEmployeeID: integer): boolean;
var
  iClockedOnRosterID: integer;
begin
  iClockedOnRosterID := LocateClockedOn(iEmployeeId);
  if iClockedOnRosterID <> 0 then begin
    Result := ClockOff(iClockedOnRosterId);
  end else begin
    Result := ClockOn(iEmployeeID);
  end;
end;
function TClockOnGUI.ClockOff(iRosterID: integer): boolean;
var
  dHours: double;
begin
  REsult:= False;
  if (ClockedRoster.count>0) and (ClockedRoster.EndTime =0) then begin
     dHours := HourSpan(dtClockTime, ClockedRoster.StartTime);
     ClockedRoster.EndTime:= dtClockTime;
     ClockedRoster.Hours := Round(dHours,4);
     ClockedRoster.PostDB;
     Result := True;
     TimerMsg(lblMsg , sEmployeename + ' : Clocked-Off');
  end else begin
    TimerMsg(lblMsg , sEmployeename + ' has NOT Clocked on');
  end;
end;
function TClockOnGUI.ClockOn(iEmployeeID: integer): boolean;
begin
  LocateClockedOn(iEmployeeId);
  if (ClockedRoster.count=0) or (ClockedRoster.EndTime <>0) then begin
    ClockedRoster.New;
    ClockedRoster.EmployeeID := iEmployeeId;
    ClockedRoster.RosterType := 'Clocked';
    ClockedRoster.ClassID    := AppEnv.DefaultClass.ClassID;
    ClockedRoster.Date       := dtClockTime;
    ClockedRoster.StartTime  := dtClockTime;
    ClockedRoster.EndTime    := 0;//IncMinute(dtClockTime, 10);
    ClockedRoster.PostDB;
    TimerMsg(lblMsg , sEmployeeName +' : Clocked-On');
  end else begin
    TimerMsg(lblMsg , sEmployeeName +' is already Clocked-On');
  end;
  Result := true;
end;


procedure TClockOnGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  //notify; // no need at this stage
  
end;

procedure TClockOnGUI.edtBarcodeInputKeyPress(Sender: TObject; var Key: char);
const
  VK_RETURN = 13;
begin
  inherited;
  if Key = char(VK_RETURN) then begin
    Key := #0;   // eat VK_RETURN
    ClockIt;
    edtBarcodeInput.Text := '';
  end;
end;


procedure TClockOnGUI.ClockIt;
var
  sValidateText: string;
  iEmployeeID: integer;
  bOk: boolean;
begin
  sEmployeeName := '';
  bOk := false;
  sValidateText := uppercase(LeftStr(edtBarcodeInput.Text, 4));
  if sValidateText = 'EMP-' then begin
    iEmployeeID   := Trunc(-StrValue(edtBarcodeInput.Text)); // -ve cuz of 'EMP-'
    sEmployeeName := GetEmployeeName(iEmployeeID);
    if not Empty(sEmployeeName) then begin
      dtClockTime := Now;
      case grpOptions.ItemIndex of
        0: bOk := AutoDetect(iEmployeeID);       // Auto Detect
        1: bOk := ClockOnEmployee(iEmployeeID);    // Clock On
        2: bOk := ClockOffEmployee(iEmployeeID); // Clock Off
      end;
    end;
  end else begin
    TimerMsg(lblMsg , 'Invalid Input : ' + edtBarcodeInput.Text );
  end;
  if bOk then begin
    DisableForm;
    CloseWithDelay(MilliSeconds(2));//Close;
  end;
end;



function TClockOnGUI.ClockOffEmployee(iEmployeeID: integer): boolean;
begin
  result := ClockOff(LocateClockedOn(iEmployeeID));
end;
function TClockOnGUI.ClockOnEmployee(iEmployeeID: integer): boolean;
begin
  LocateClockedOn(iEmployeeID);
  result := ClockOn(iEmployeeID);
end;
procedure TClockOnGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;
procedure TClockOnGUI.FormDestroy(Sender: TObject);
begin
  if assigned(ClockedRoster) then FreeAndNil(ClockedRoster);
  inherited;
end;

procedure TClockOnGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
end;
procedure TClockOnGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;

    ClockedRoster := TClockedRoster.CreateWithNewConn(Self);
    ClockedRoster.Connection.Connection := MyConnection;
    ClockedRoster.BusObjEvent := DoBusinessObjectEvent;
    ClockedRoster.Load(0);

    lblClockOn.Caption := '';
   // SetControlFocus(edtBarcodeInput);
   tmrclockTimer(tmrclock);
  finally
    EnableForm;
    edtBarcodeInput.SetFocus;
  end;   
end;

procedure TClockOnGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;  
end;

procedure TClockOnGUI.grpOptionsClick(Sender: TObject);
begin
  inherited;
  SetControlFocus(edtBarcodeInput);
end;

Initialization
  RegisterClassOnce(TClockOnGUI);

end.

