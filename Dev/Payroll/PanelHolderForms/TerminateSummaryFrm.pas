unit TerminateSummaryFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, wwdbdatetimepicker, StdCtrls, DNMSpeedButton,
  DB, DBAccess, MyAccess,ERPdbComponents, MemDS, Mask, wwdbedit,BusObjTermination, frmBase,
  Menus;

type
  TfrmTerminateSummary = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label29: TLabel;
    Label30: TLabel;
    Label42: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    lblEFT: TLabel;
    chkAddToEft: TCheckBox;
    dtpDate: TwwDBDateTimePicker;
    Label36: TLabel;
    Label35: TLabel;
    Label34: TLabel;
    Label33: TLabel;
    Label47: TLabel;
    Bevel2: TBevel;
    btnPreviewPreETPStatement: TDNMSpeedButton;
    btnPreviewETPStatement: TDNMSpeedButton;
    btnPreviewRollover: TDNMSpeedButton;
    Label38: TLabel;
    DSEmpTerminate: TDataSource;
    edLumpA: TwwDBEdit;
    edLumpB: TwwDBEdit;
    edLumpC: TwwDBEdit;
    edLumpD: TwwDBEdit;
    edLumpE: TwwDBEdit;
    edGross: TwwDBEdit;
    edTotalLumps: TwwDBEdit;
    edTax: TwwDBEdit;
    edNet: TwwDBEdit;
    btnPreviewPaySlip: TDNMSpeedButton;
    wwDBEdit1: TwwDBEdit;
    Label1: TLabel;
    Bevel3: TBevel;
    procedure SetSubTerminate(Const Value :Temployeeterminations   );
    procedure btnPreviewPaySlipClick(Sender: TObject);
    procedure chkAddToEftClick(Sender: TObject);
    procedure btnPreviewETPStatementClick(Sender: TObject);
    procedure btnPreviewPreETPStatementClick(Sender: TObject);
    procedure btnPreviewRolloverClick(Sender: TObject);
  private
    fSubTerminate:Temployeeterminations;
  public
    property SubTerminate:Temployeeterminations  read fSubTerminate write SetSubTerminate ;
  end;



implementation

uses
  BusObjBase, BusObjPayUtils, CommonLib, AppEnvironment, frmEmployeeTerminate;
  
procedure TfrmTerminateSummary.SetSubTerminate(Const Value :Temployeeterminations);
begin
  fSubTerminate := Value;
end;
{$R *.dfm}

procedure TfrmTerminateSummary.btnPreviewPaySlipClick(Sender: TObject);
var
  PayUtils:Tpayutils;
  bShowAnnual,bShowSick,bShowLong:Boolean;
begin
  PayUtils := TPayUtils.Create(Self,TERPConnection(TMyDacDataConnection(fSubTerminate.Connection).MyDacConnection ));
  bShowAnnual   := AppEnv.PayPrefs.ShowAccruedAnnualLeavePaySlip; {pay not processed yet so don't show entitlements}
  bShowSick     := AppEnv.PayPrefs.ShowAccruedSickLeavePaySlip;
  bShowLong     := AppEnv.PayPrefs.ShowAccruedLongServiceLeavePaySlip;
  if fSubTerminate.IsPayEntitled then begin
    try
      AppEnv.PayPrefs.ShowAccruedAnnualLeavePaySlip := False;
      AppEnv.PayPrefs.ShowAccruedSickLeavePaySlip   := False;
      AppEnv.PayPrefs.ShowAccruedLongServiceLeavePaySlip := False;
      fSubTerminate.LoadTerminationToPay;
      fSubTerminate.Pay.Paynotes := 'Termination Pay: PREVIEW ONLY. THIS IS AN UNPROCESSED PAY.';
      fSubTerminate.Pay.PostDb;
      PayUtils.PrintPaySlip(fSubTerminate.Pay,True,'F');
    finally
      AppEnv.PayPrefs.ShowAccruedAnnualLeavePaySlip := bShowAnnual;
      AppEnv.PayPrefs.ShowAccruedSickLeavePaySlip   := bShowSick;
      AppEnv.PayPrefs.ShowAccruedLongServiceLeavePaySlip := bShowLong;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('Employee is not being paid their normal pay.', mtInformation, [mbOK], 0);
  end;;
end;

procedure TfrmTerminateSummary.chkAddToEftClick(Sender: TObject);
begin
  inherited;
  if chkAddToEft.Checked then fSubTerminate.AddToEFT := True
  else if not chkAddToEft.Checked then fSubTerminate.AddToEFT := False;
end;

procedure TfrmTerminateSummary.btnPreviewETPStatementClick( Sender: TObject);
var
  TermForm: TfrmEmployeeTerminateGUI;
begin
  inherited;
  TermForm:= TfrmEmployeeTerminateGUI(DNMPanel1.Parent.Owner);
  if TermForm.Terminate.LumpSumC <> 0 then begin
    TermForm.PrintETPPaymentSummary();
  end
  else begin
    MessageDlgXP_Vista('There is no Lump Sum C amount..', mtInformation, [mbOK], 0);
  end;
end;

procedure TfrmTerminateSummary.btnPreviewPreETPStatementClick(Sender: TObject);
var
  TermForm: TfrmEmployeeTerminateGUI;
begin
  inherited;
  TermForm:= TfrmEmployeeTerminateGUI(DNMPanel1.Parent.Owner);
  if TermForm.Terminate.LumpSumC <> 0 then begin
    TermForm.PrintETPPrePaymentStatement();
  end
  else begin
    MessageDlgXP_Vista('There is no Lump Sum C amount..', mtInformation, [mbOK], 0);
  end;
end;

procedure TfrmTerminateSummary.btnPreviewRolloverClick(Sender: TObject);
var
  TermForm: TfrmEmployeeTerminateGUI;
begin
  inherited;
  TermForm:= TfrmEmployeeTerminateGUI(DNMPanel1.Parent.Owner);
  if TermForm.Terminate.LumpSumC <> 0 then begin
    TermForm.PrintETPRoloverStatement();
  end
  else begin
    MessageDlgXP_Vista('There is no Lump Sum C amount..', mtInformation, [mbOK], 0);
  end;
end;

initialization
RegisterClassOnce(TfrmTerminateSummary);
end.
