unit TerminateETPDetailsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DNMPanel, Mask, wwdbedit, DB, DBAccess,
  MyAccess,ERPdbComponents, MemDS,BusObjTermination, frmBase;

type
  TfrmTerminateETPDetails = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label22: TLabel;
    Label49: TLabel;
    Label65: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label61: TLabel;
    Label59: TLabel;
    Label66: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label54: TLabel;
    Label60: TLabel;
    Label55: TLabel;
    Bevel2: TBevel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtEarlyRetire: TwwDBEdit;
    edtOtherETP: TwwDBEdit;
    edtRedundancy: TwwDBEdit;
    edtInvalidity: TwwDBEdit;
    edtSick: TwwDBEdit;
    edtJobLoss: TwwDBEdit;
    edtGoldenHandshake: TwwDBEdit;
    edtPayInLieu: TwwDBEdit;
    edtRDOs: TwwDBEdit;
    edtDeath: TwwDBEdit;
    edtTotals: TwwDBEdit;
    edtRollOver: TwwDBEdit;
    DSEmpTerminate: TDataSource;
    edtPreJuly1983: TwwDBEdit;
    edPostJune1983: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    Label1: TLabel;
    procedure SetSubTerminate(Const Value :Temployeeterminations   );
  private
    fSubTerminate:Temployeeterminations;
  public
    property SubTerminate:Temployeeterminations  read fSubTerminate write SetSubTerminate ;
  end;



implementation

uses
  CommonLib;


procedure TfrmTerminateETPDetails.SetSubTerminate(Const Value :Temployeeterminations);
begin
  fSubTerminate := Value;
end;
{$R *.dfm}

initialization
RegisterClassOnce(TfrmTerminateETPDetails);
end.
