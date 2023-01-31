unit PCCTransactionsObj;

interface

uses VisualConsole_TLB, ActiveX, MyAccess, SysUtils, Classes;

Const SECURITY_MODE_NOT_SET = 255;
      SECURITY_MODE_VisualConsoleUnlocked = 0;
      SECURITY_MODE_DisableTransactionProcessing = 1;
      SECURITY_MODE_VisualConsoleLocked = 2;
type
  TPCCTransactionsObj = class(TObject)

  private
    fSwapHandle: integer;
    fSecurityMode: byte;
    fLoggedIn: boolean;
    procedure SetSecurityMode(const Value: byte);
  protected
    fPOSI : TPOSInterface;
    procedure POSINTransactionAvailable(ASender: TObject; Site,
      TransHandle, Dispenser, Hose, Grade: Integer;
      const GradeName: WideString; Value, Volume, UnitPrice: Double;
      AtdNum: Integer; const AtdName: WideString; SDate, STime, EDate,
      ETime, PDate, PTime, DayNum, ShiftNum, ClientType, Node, TransType,
      TransCode, Odometer: Integer; EngineHours: Double; RouteNum,
      MethOfPay, CompartNum, ContractNum: Integer; const PANNum,
      RemTrackTwo, VehicleReg, TagNum, Driver, Misc1, Misc2: WideString;
      RI_1, RI_2: Integer; const RS_1, RS_2, RS_3: WideString);
    procedure POSIDCADispenserStateChange(Dispenser: Integer; State: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    function Login(ClerkID: Integer;
                    Password: Integer;
                    POSSwapHnd: Integer;
                    InitialWindHnd: Integer) : boolean;
    function Logout : boolean;
    function POSINConfirmTransaction(Dispenser: Integer; TransactionHandle: Integer; MethodOfPayment: Integer): Integer;
    function POSINReturnTransaction(Dispenser: Integer; TransactionHandle: Integer): Integer;

    property SwapHandle : integer read fSwapHandle write fSwapHandle;
    property SecurityMode : byte read fSecurityMode write SetSecurityMode;
    property POSI : TPOSInterface read fPOSI;
  end;


implementation

uses FastFuncs,CommonDbLib, Dialogs, CommonLib;

constructor TPCCTransactionsObj.Create;
begin
  inherited;
  fLoggedIn := false;
  fSecurityMode := SECURITY_MODE_NOT_SET;
  fPOSI := TPOSInterface.Create(nil);
end;

procedure TPCCTransactionsObj.POSIDCADispenserStateChange(Dispenser,
  State: Integer);
begin
  CommonLib.MessageDlgXP_Vista('State ' + FastFuncs.IntToStr(State), mtWarning, [mbOK], 0);;
end;

destructor TPCCTransactionsObj.Destroy;
begin
  FreeAndNil(fPOSI);
  inherited;
end;

function TPCCTransactionsObj.Login(ClerkID, Password, POSSwapHnd, InitialWindHnd: Integer): boolean;
Var LoginResult: integer;
begin
  LoginResult := fPOSI.Login(ClerkID,Password,POSSwapHnd,InitialWindHnd);
  if LoginResult <> 0 then begin
    Result := true;
    fLoggedIn := true;
    //fPOSI.OnNTransactionAvailable := POSINTransactionAvailable;
    //fPOSI.OnDCADispenserStateChange := POSIDCADispenserStateChange;
  end
  else
    Result := false;
end;

function TPCCTransactionsObj.Logout: boolean;
Var LogoutResult : integer;
begin
  LogoutResult := fPOSI.Logout;
  if LogoutResult = 0 then begin
    Result := true;
    fLoggedIn := false;
    fSecurityMode := SECURITY_MODE_NOT_SET;
  end
  else
    Result :=false;
end;

procedure TPCCTransactionsObj.POSINTransactionAvailable(ASender: TObject;
  Site, TransHandle, Dispenser, Hose, Grade: Integer;
  const GradeName: WideString; Value, Volume, UnitPrice: Double;
  AtdNum: Integer; const AtdName: WideString; SDate, STime, EDate, ETime,
  PDate, PTime, DayNum, ShiftNum, ClientType, Node, TransType, TransCode,
  Odometer: Integer; EngineHours: Double; RouteNum, MethOfPay, CompartNum,
  ContractNum: Integer; const PANNum, RemTrackTwo, VehicleReg, TagNum,
  Driver, Misc1, Misc2: WideString; RI_1, RI_2: Integer; const RS_1, RS_2,
  RS_3: WideString);
Var qry : TMyQuery;
    TransDate: String;
    TimeStr, DateStr : String;
begin
  // because PTime is integer time 09:10:12 looks like 91:01:2 as leading zero is not showing
  TimeStr := Format('%.6d',[PTime]);

  DateStr := FastFuncs.IntToStr(PDate);

  TransDate := DateStr[1]+DateStr[2]+DateStr[3]+DateStr[4] + '-' + //year
               DateStr[5]+DateStr[6] + '-' +                      //month
               DateStr[7]+DateStr[8]+                             //day
               ' ' +
               TimeStr[1]+TimeStr[2] +
               ':' + TimeStr[3]+TimeStr[4] +
               ':' + TimeStr[5]+TimeStr[6];

  qry := TMYQuery.Create(nil);
  try
    try
      qry.Options.FlatBuffers := True;
      qry.Connection := GetSharedMyDacConnection;
      qry.SQL.Text := Format('INSERT HIGH_PRIORITY INTO tblPCCTransAvailable '+
                      '(DispenserNo,TransactionHandle,MethodOfPayment,Site,Hose,Grade,Value,Volume,UnitPrice,TransDate) ' +
                      'VALUES (%d,%d,%d,%d,%d,%d,%f,%f,%f,"' + TransDate + '")',
                      [Dispenser, TransHandle, MethOfPay, Site, Hose, Grade, Value, Volume, UnitPrice]);
      qry.Execute;
    except
      // May Be duplicated
      on E: exception do begin
        if FastFuncs.PosEx('DUPLICATE ENTRY',FastFuncs.UpperCase(E.Message))>0 then // do nothing
        else begin
          CommonLib.MessageDlgXP_Vista('Possible database error.'+#13+#10+'Transaction will be returned!', mtWarning, [mbOK], 0);
          fPOSI.NReturnTransaction(Dispenser, TransHandle);
        end;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPCCTransactionsObj.SetSecurityMode(const Value: byte);
begin
  if fLoggedIn then begin
    fPOSI.SetSecurityMode(Value);
    fSecurityMode := Value;
  end
  else begin
    fSecurityMode := SECURITY_MODE_NOT_SET;
  end;
end;

function TPCCTransactionsObj.POSINConfirmTransaction(Dispenser,
  TransactionHandle, MethodOfPayment: Integer): Integer;
begin
  result := fPOSI.NConfirmTransaction(Dispenser, TransactionHandle, MethodOfPayment);
end;

function TPCCTransactionsObj.POSINReturnTransaction(Dispenser,
  TransactionHandle: Integer): Integer;
begin
  result := fPOSI.NReturnTransaction(Dispenser, TransactionHandle);
  //fPOSI.
end;

initialization
  //RegisterClassOnce(TPCCTransactionsObj);

end.

