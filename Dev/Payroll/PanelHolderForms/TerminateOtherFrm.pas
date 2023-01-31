unit TerminateOtherFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, StdCtrls, DB, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbedit, Mask, Wwdotdot, Wwdbcomb,BusObjTermination, frmBase;

type
  TfrmTerminateOther = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label53: TLabel;
    Bevel6: TBevel;
    Label45: TLabel;
    lblAmount: TLabel;
    DSEmpTerminate: TDataSource;
    cboOtherPayments: TwwDBComboBox;
    edAmount: TwwDBEdit;
    procedure SetSubTerminate(Const Value :Temployeeterminations   );
    procedure cboOtherPaymentsCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
  private
    fSubTerminate:Temployeeterminations;
  public
    property SubTerminate:Temployeeterminations  read fSubTerminate write SetSubTerminate ;
  end;



implementation

uses
  CommonLib;

procedure TfrmTerminateOther.SetSubTerminate(Const Value :Temployeeterminations);
begin
  fSubTerminate := Value;
end;
{$R *.dfm}

procedure TfrmTerminateOther.cboOtherPaymentsCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  if Sender.Text = 'None' then begin
    lblAmount.Enabled := False;
    edAmount.Enabled := False;
  end else begin
    lblAmount.Enabled := True;
    edAmount.Enabled := True;
  end;
end;

initialization
RegisterClassOnce(TfrmTerminateOther);
end.
