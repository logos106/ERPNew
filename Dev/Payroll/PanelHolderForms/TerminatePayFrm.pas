unit TerminatePayFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, StdCtrls, wwclearbuttongroup, wwradiogroup,
  ExtCtrls, DNMPanel,BusObjTermination,MyAccess,ERPdbComponents, DB, MemDS,
  DBAccess, frmBase,MessageConst, Menus;

type
  TfrmTerminatePay = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label11: TLabel;
    rgPayStatus: TwwRadioGroup;
    Label40: TLabel;
    btnPrepare: TDNMSpeedButton;
    btnLoadTimesheet: TDNMSpeedButton;
    btnLoadRoster: TDNMSpeedButton;
    Bevel2: TBevel;
    DSEmpTerminate: TDataSource;
    lblPrepare: TLabel;
    procedure SetSubTerminate(Const Value :Temployeeterminations   );
    procedure rgPayStatusClick(Sender: TObject);
    procedure btnPrepareClick(Sender: TObject);
    procedure btnLoadTimesheetClick(Sender: TObject);
    procedure btnLoadRosterClick(Sender: TObject);
  private
    fResettingForm:Boolean;
    fSubTerminate:Temployeeterminations;
    fFinishCreatingForm:boolean;
    fConnection :TERPConnection;  
    function OpenRoster: boolean;
    procedure InitialiseButtons;
  public
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    property ResettingForm:Boolean read fResettingForm write fResettingForm;
    property SubTerminate:Temployeeterminations  read fSubTerminate write SetSubTerminate ;
    property Connection:TERPConnection read fConnection write fConnection;
  end;

implementation

uses
  frmEmployeePayFrm,CommonLib,BusObjBase,BusObjPayUtils,RosterCalForm,PayCommon,BusObjConst;

procedure TfrmTerminatePay.SetSubTerminate(Const Value :Temployeeterminations);
begin
  fSubTerminate := Value;

  if fSubTerminate.IsPayEntitled then
    rgPayStatus.Itemindex:= 0
  else
    rgPayStatus.Itemindex:= 1;
end;

{$R *.dfm}



procedure TfrmTerminatePay.rgPayStatusClick(Sender: TObject);
begin
  if not fFinishCreatingForm then begin
    fFinishCreatingForm := True;
  //  exit;
  end;
  if fResettingForm then exit;
  // employee doesn't have an existing pay
  if GetUnprocessedPayID(fSubTerminate.Employeeid) = 0 then begin
    fSubTerminate.SendEvent(BusObjEvent_Change,BusObjEvent_NoUnprocessedPay);
    Exit;
  end;


  fSubTerminate.IsPayEntitled := rgPayStatus.Itemindex = 0;
  if fSubTerminate.IsPayEntitled then  fSubTerminate.CalcOwedAnnual; 

  InitialiseButtons;
end;

procedure TfrmTerminatePay.btnPrepareClick(Sender: TObject);
var
  tmpPayID:integer;
  form: TfrmEmployeePay;
begin
  inherited;
  tmpPayID:= 0;
  form:= TfrmEmployeePay(GetComponentByClassName('TfrmEmployeePay',true,Self));
  if not assigned(form) then exit;
  fSubTerminate.PostDb;
  fSubTerminate.Connection.CommitTransaction;
  try
    form.KeyID := fSubTerminate.Pay.PayID;
    tmpPayID := fSubTerminate.Pay.PayID;
    form.FormStyle := fsNormal;
    form.Position := poScreenCenter;
    form.ShowModal;

  finally
    form.Release;
    Application.ProcessMessages;
    fSubTerminate.Connection.BeginTransaction;
    fSubTerminate.Pay.Closedb;
    fSubTerminate.Pay.Load(tmpPayID);
  end;
  if not fSubTerminate.Complete then begin
    fSubTerminate.Pay.RecalcAll;
    fSubTerminate.DoFinalCalcs;
  end;  
end;

procedure TfrmTerminatePay.btnLoadTimesheetClick(Sender: TObject);
begin
  {  -orobin : Later }
end;

procedure TfrmTerminatePay.btnLoadRosterClick(Sender: TObject);
var
  PayUtils: TPayUtils;
begin
  PayUtils := TPayUtils.Create(Self,TERPConnection(TMyDacDataConnection(SubTerminate.Connection).MyDacConnection ));
  try
    if SubTerminate.Pay.EmployeeDetails.Isontheroster <> True then begin
      CommonLib.MessageDlgXP_Vista(SubTerminate.Employeename + ' is not on the Roster.',mtInformation,[mbOK], 0);
      exit;
    end;

    if CommonLib.MessageDlgXP_Vista('You have chosen to Load Roster Hours and Leave into this pay. ' +
      'This will only apply if ' + SubTerminate.Employeename + ' has ' +
      '"Load Hours from Roster" or "Load Leave from Roster" ' +
      'Checked in the Employee forms.' + #13 + #10 + #13 + #10 + '' +
      'Hours will be adjusted for Meal Breaks ' + #10 + #13 + '' +
      'THIS WILL OVERRIDE ANY HOURS OR LEAVE ' +
      'PREVIOUSLY ASSIGNED' + #13 + #10 + #13 + #10 +
      'Do you wish to proceed?', mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
      Exit;
    end;
      if not OpenRoster() then begin
        CommonLib.MessageDlgXP_Vista('You have Cancelled from the Roster, the Hours will not be ' + #13 + #10 +
          'Loaded into the Payroll.', mtWarning, [mbOK], 0);
        Exit;
      end;
      Processingcursor(True);
      try
        PayUtils.LoadRoster(SubTerminate.Employeeid);
      finally
        Processingcursor(False);
      end;
      CommonLib.MessageDlgXP_Vista('Roster loaded.', mtInformation, [mbOK], 0);    
  finally

  end;
end;

function TfrmTerminatePay.OpenRoster: boolean;
var
  iModalResult: integer;
begin
  Result := false;
  with TRosterCalGUI.Create(Self) do
    try
      // get a sensible date
      fdtStartDate := SubTerminate.Pay.EmployeePaySettings.LastPaid;

      iModalResult := ShowModal;
      if iModalResult <> mrCancel then begin
        Result := true;
      end;
    finally
      Free;
    end;
end;

procedure TfrmTerminatePay.PerformStartup(var Msg: TMessage);
begin
  InitialiseButtons;
end;

procedure TfrmTerminatePay.InitialiseButtons;
begin
  if rgPayStatus.Itemindex = 0 then begin
    btnPrepare.Enabled := True;
    btnLoadTimesheet.Enabled := False; //True;  NOT USING AT THE MOMENT
    btnLoadRoster.Enabled := True;
  //  fSubTerminate.PayGross := fSubTerminate.Pay.Gross;
  end else begin
    btnPrepare.Enabled := False;
    btnLoadTimesheet.Enabled := False;
    btnLoadRoster.Enabled := False;
    fSubTerminate.PayGross := 0;
  end;
end;

initialization
RegisterClassOnce(TfrmTerminatePay);
end.
