unit OPOSConfigObj;

interface
uses
  Classes, MyAccess,ERPdbComponents, OposScanner_CCO_TLB , OposScale_CCO_TLB, DB;

type
  TOPOSSettingObj = class(TObject)
  private
    fbUseScale: Boolean;
    fsscannerdevicename: String;
    fsScaleDeviceName: String;
    fbusescanner: Boolean;
    scanner:TOPOSScanner;
    Scale:TOPOSScale;
    Procedure InitObj;


  public
    class procedure Instance;
    constructor Create;
    destructor Destroy; override;
    procedure PopulateMe(const TillID: integer);
    Property UseScale         : Boolean Read  fbUseScale;
    Property usescanner       : Boolean Read  fbusescanner;
    Property ScaleDeviceName  : String  Read  fsScaleDeviceName;
    Property scannerdevicename: String  Read  fsscannerdevicename;
    function EnableOPOSScanner(AOwner:TComponent; OPOSScannerEvent: TOPOSScannerDataEvent ; OPOSOnErrorEvent :TOPOSScannerErrorEvent):TOPOSScanner;
    Function EnableOPOSScale(AOwner:Tcomponent; OPOSScaleEvent:TOPOSScaleDataEvent;OPOSOnErrorEvent:TOPOSScannerErrorEvent):TOPOSScale;
    Procedure CloseOPOSScanner;

  end;

var
  OPOSSetting: TOPOSSettingObj;

implementation

uses sysutils, CommonDbLib, FastFuncs,CommonLib, Dialogs;

{ TOPOSSettingObj }

procedure TOPOSSettingObj.CloseOPOSScanner;
var
  pcr:Integer;
begin
  if not useScanner then exit;
  Scanner.Deviceenabled := false;
  Scanner.ReleaseDevice(pcr);
  Scanner.Close(pcr);
end;

constructor TOPOSSettingObj.Create;
begin
    PopulateMe(0);
end;

destructor TOPOSSettingObj.Destroy;
begin
//  if not Assigned(OPOSSetting) then begin
//    FreeAndNil(OPOSSetting);
//  end;
  inherited;
end;
function TOPOSSettingObj.EnableOPOSScale(AOwner:Tcomponent; OPOSScaleEvent:TOPOSScaleDataEvent;OPOSOnErrorEvent:TOPOSScannerErrorEvent):TOPOSScale;
var
  pcr,Timeout  : Integer;
begin
  Result := nil;
  try
    if not(UseScale) then begin
      MessageDlgXP_Vista('This Till Has ''Use OPOS Scale'' Set To False. Please Enable This To Use The Scale on This Till.', mtwarning, [mbok],0);
      Exit;
    end;

    if ScaleDeviceName='' then begin
      MessageDlgXP_Vista('Please Provide The Scale DeviceName for this Till.', mtwarning, [mbok],0);
      Exit;
    end;

    Scale := TOPOSScale.Create(AOwner);
    Scale.OnDataEvent := OPOSScaleEvent;

    Scale.Open(ScaleDevicename , pcr);
    if Scale.DeviceName = '[Error]' then begin
      MessageDlgXP_Vista('Unable To Connect To '+ScaleDevicename+ '.', mtwarning, [mbok],0);
      Exit;
    end;

    Timeout:=1000;
    Scale.ClaimDevice(Timeout, pcr);
    if not Scale.Claimed then begin
      MessageDlgXP_Vista('Unable To Connect To '+ScaleDevicename+ '.', mtwarning, [mbok],0);
      Exit;
    end;

    Scale.DeviceEnabled := True;
    if not Scale.Deviceenabled then begin
        MessageDlgXP_Vista('Unable To Connect To '+ScaleDevicename+ '.', mtwarning, [mbok],0);
        Exit;
    end;

    Scale.DataEventEnabled := True;
    if not Scale.DataEventEnabled then begin
        MessageDlgXP_Vista('Unable To Connect To '+ScaleDevicename+ '.', mtwarning, [mbok],0);
        Exit;
    end;
    (*scanner.DecodeData:= true;
    Scanner.OnDataEvent := OPOSScannerEvent;
    Scanner.OnErrorEvent := OPOSOnErrorEvent;*)
    REsult := Scale;
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('Unable To Connect To '+scannerdevicename+ '.'+chr(13)+chr(13)+ E.Message, mtwarning, [mbok],0);
    end;
  end;

end;

function TOPOSSettingObj.EnableOPOSScanner(AOwner:TComponent; OPOSScannerEvent: TOPOSScannerDataEvent ; OPOSOnErrorEvent :TOPOSScannerErrorEvent):TOPOSScanner;
var
  pcr,Timeout  : Integer;
begin
  Result := nil;
  try
    if not(usescanner) then begin
      MessageDlgXP_Vista('This Till Has ''Use OPOS Scanner'' Set To False. Please Enable This To Use The Scanner on This Till.', mtwarning, [mbok],0);
      Exit;
    end;

    if scannerdevicename='' then begin
      MessageDlgXP_Vista('Please Provide The Scanner DeviceName for this Till.', mtwarning, [mbok],0);
      Exit;
    end;

    scanner:=TOPOSScanner.Create(AOwner);
    scanner.OnDataEvent := OPOSScannerEvent;

    scanner.Open(scannerdevicename , pcr);
    if scanner.DeviceName = '[Error]' then begin
      MessageDlgXP_Vista('Unable To Connect To '+scannerdevicename+ '.', mtwarning, [mbok],0);
      Exit;
    end;

    Timeout:=1000;
    Scanner.ClaimDevice(Timeout, pcr);
    if not Scanner.Claimed then begin
      MessageDlgXP_Vista('Unable To Connect To '+scannerdevicename+ '.', mtwarning, [mbok],0);
      Exit;
    end;

    Scanner.Deviceenabled := True;
    if not Scanner.Deviceenabled then begin
        MessageDlgXP_Vista('Unable To Connect To '+scannerdevicename+ '.', mtwarning, [mbok],0);
        Exit;
    end;

    Scanner.DataEventEnabled := True;
    if not Scanner.DataEventEnabled then begin
        MessageDlgXP_Vista('Unable To Connect To '+scannerdevicename+ '.', mtwarning, [mbok],0);
        Exit;
    end;
    scanner.DecodeData:= true;
    Scanner.OnDataEvent := OPOSScannerEvent;
    Scanner.OnErrorEvent := OPOSOnErrorEvent;
    REsult := Scanner;
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('Unable To Connect To '+scannerdevicename+ '.'+chr(13)+chr(13)+ E.Message, mtwarning, [mbok],0);
    end;
  end;
end;

procedure TOPOSSettingObj.InitObj;
begin
    fbUseScale          :=False;
    fbusescanner        :=False;
    fsscannerdevicename :='';
    fsScaleDeviceName   :='';
end;

class procedure TOPOSSettingObj.Instance;
begin
  if not Assigned(OPOSSetting) then begin
    OPOSSetting := TOPOSSettingObj.Create;
  end;
end;

procedure TOPOSSettingObj.PopulateMe(const TillID: integer);
var
  qry: TERPQuery;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    with qry do begin
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.ParamCheck := false;
      Sql.Add('Select  UseScale, usescanner,ScaleDeviceName, scannerdevicename  ');
      Sql.Add('From tblpostills Where TillID = ' + IntToStr(TillID) + ';');
      Open;
    end;
    InitObj;
    with qry do begin
      if not IsEmpty then begin
        fbUseScale          :=FieldByname('UseScale').asBoolean;
        fbusescanner        :=FieldByname('usescanner').asBoolean;
        fsscannerdevicename :=FieldByname('scannerdevicename').AsString;
        fsScaleDeviceName   :=FieldByname('ScaleDeviceName').AsString;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

initialization

finalization
  OPOSSetting.Free;
  OPOSSetting:= nil;

end.
