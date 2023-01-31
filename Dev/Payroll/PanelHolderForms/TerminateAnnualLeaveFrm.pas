unit TerminateAnnualLeaveFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, StdCtrls, DB, MemDS, DBAccess, MyAccess,ERPdbComponents,
  BusObjTermination,Mask, wwdbedit, wwcheckbox, frmBase;

type
  TfrmTerminateAnnualLeave = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label16: TLabel;
    Bevel5: TBevel;
    Label19: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label41: TLabel;
    Label20: TLabel;
    DSEmpTerminate: TDataSource;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    chkOverrideAnnualLeave: TwwCheckBox;
    procedure SetSubTerminate(Const Value :Temployeeterminations   );
  private
    fSubTerminate:Temployeeterminations;
  public
    property SubTerminate:Temployeeterminations  read fSubTerminate write SetSubTerminate ;
  end;



implementation

uses
  CommonLib;

procedure TfrmTerminateAnnualLeave.SetSubTerminate(Const Value :Temployeeterminations);
begin
  fSubTerminate := Value;
end;

{$R *.dfm}

initialization
RegisterClassOnce(TfrmTerminateAnnualLeave);
end.
