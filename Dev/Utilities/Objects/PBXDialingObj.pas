unit PBXDialingObj;
{
 LineDeviceName - Shoud be set from preferences, Name is preferable 'couse if other
                  TAPI equipment will be instaled on clients machine ID can be changed,
                  but name will not
 LineAddressID - ID of the phone connected to phone system used for dialing from
                 (in Alcatel it depends on plug phone plugged in, starts from 0,1,2 ...)
 LinePrefix -    Number dialed to go outside the office (like 0 in Platinum1)


 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 23/01/06  1.00.01  AL  Initial Version.
 }
interface

uses Dialogs, classes, etLine, sysutils, MyAccess, Controls;

Type
  TLineState = (lsLineInUse, lsLineIsFree);
  TOnLineStateChangeEvent = procedure(LineState : TLineState) of object;
//  TetLineCallBeginEvent = procedure(Sender: TObject; CallHandle: Integer) of object;
//  TetLineConnectedEvent = procedure(Sender: TObject; CallHandle: Integer) of object;
//  TetLineOfferingEvent = procedure(Sender: TObject; CallHandle: Integer) of object;

type
  TPBXDialingObj = class(TComponent)
  private
    fLineDeviceID: integer;
    fLinePrefix: string;
    fLine : TetLine;
    fLineDeviceName: string;
    fLineAddressID: integer;
    fLineInUse: boolean;
    fDialMessage: string;
    fOnLineStateChange: TOnLineStateChangeEvent;
    function GetLine: TetLine;
  public
    property LineDeviceID : integer read fLineDeviceID;
    property LinePrefix : string read fLinePrefix write fLinePrefix;
    property Line: TetLine read GetLine;
    property LineDeviceName : string read fLineDeviceName write fLineDeviceName;
    property LineAddressID : integer read fLineAddressID write fLineAddressID;
    property LineInUse : boolean read fLineInUse write fLineInUse;
    property DialMessage: string read fDialMessage;
    property OnLineStateChange: TOnLineStateChangeEvent read fOnLineStateChange write fOnLineStateChange;
    function Dial(const PhoneNumber: string) : boolean;
    procedure HangUp;
    function GetSettingsByUserPCName: boolean; // true if settings for user exists
    procedure OnCallBegin(Sender: TObject; CallHandle: Integer);
    procedure OnConnected(Sender: TObject; CallHandle: Integer);
    procedure OnOffering(Sender: TObject; CallHandle: Integer);
    procedure OnCallEnd(Sender: TObject; CallHandle: Integer);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  CommonDbLib, CommonLib;

{ TPBXDialingObj }


{ TPBXDialingObj }

constructor TPBXDialingObj.Create(AOwner: TComponent);
begin
  inherited;
  fLine := TetLine.Create(self);
  try
    fLine.About.SerialNumber := '301d-o14q-zp1u-46h0';
    fLine.Enabled := true;
    fLine.Privilege.Owner := true;
    fLinePrefix := '';
    fLineDeviceID := 0;
    fLineAddressID := 0;
    fLineDeviceName := '';
    fLineInUse := false;
    fLine.OnCallBegin := OnCallBegin;
    fLine.OnConnected := OnConnected;
    fLine.OnOffering := OnOffering;
    fLine.OnCallEnd := OnCallEnd;
    if not GetSettingsByUserPCName then Exit;
      fLine.Device.Name := fLineDeviceName;
      fLine.Device.Active := true;
  except
    FreeAndNil(fLine);
    CommonLib.MessageDlgXP_Vista('Error creating PBX Dialing Object', mtError, [mbOK], 0);
  end;
end;

destructor TPBXDialingObj.Destroy;
begin
  //if Assigned(fLine) then FreeAndNil(fLine);
  inherited;
end;

function TPBXDialingObj.Dial(Const PhoneNumber: string): boolean;
begin
  result := false;
  try
    fDialMessage := '';
    if not GetSettingsByUserPCName then Exit;
    fLine.Device.Name := fLineDeviceName;
    fLine.Device.Active := true;
    //CommonLib.MessageDlgXP_Vista(FastFuncs.IntToStr(fLine.Line.Handle));
    if fLineInUse then begin
      if CommonLib.MessageDlgXP_Vista('Line currently in use. '+#13+#10+'Do you wish to drop current call and dial: ' + PhoneNumber + '?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
        fDialMessage := 'User Abort';
        Exit;
      end;  
    end;
    fLine.Call.Handle := 0;
    fLine.Call.Parameters.AddressID := fLineAddressID;
    fLine.Call.PhoneNumber := fLinePrefix + PhoneNumber;
    result := fLine.Call.Dial;
    fDialMessage := fLine.Error.Text;
  except
    CommonLib.MessageDlgXP_Vista('Cannot find device: ' + fLineDeviceName, mtError, [mbOK], 0);
  end;
end;

function TPBXDialingObj.GetLine: TetLine;
begin
  result := fLine;
end;

function TPBXDialingObj.GetSettingsByUserPCName: boolean;
Var qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := GetSharedMyDacConnection;
  qry.SQL.Text := 'SELECT * FROM pbxMonitor.tblDialingSettings WHERE UserPCName = ' + QuotedStr(GetPCName);
  qry.Open;
  if qry.RecordCount > 0 then begin
    fLineDeviceName := qry.FieldByName('DeviceName').AsString;
    fLineDeviceID := qry.FieldByName('DeviceAddressID').AsInteger;
    fLinePrefix := qry.FieldByName('Prefix').AsString;
    result := true;
  end
  else begin
    result := false;
    //CommonLib.MessageDlgXP_Vista('No settings for this mashine! '+#13+#10+'Please enter settings for this PC in Utilities -> PABX Extensions', mtError, [mbOK], 0);
  end;
end;

procedure TPBXDialingObj.HangUp;
begin
  fLine.Call.Hangup;
end;

procedure TPBXDialingObj.OnCallBegin(Sender: TObject; CallHandle: Integer);
begin
  fLineInUse := true;
  OnLineStateChange(lsLineInUse);
end;

procedure TPBXDialingObj.OnCallEnd(Sender: TObject; CallHandle: Integer);
begin
  fLineInUse := false;
  OnLineStateChange(lsLineIsFree);
end;

procedure TPBXDialingObj.OnConnected(Sender: TObject; CallHandle: Integer);
begin
  fLineInUse := true;
  OnLineStateChange(lsLineInUse);
end;

procedure TPBXDialingObj.OnOffering(Sender: TObject; CallHandle: Integer);
begin
  fLineInUse := true;
  OnLineStateChange(lsLineInUse);
end;

end.
