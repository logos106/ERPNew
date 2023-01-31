unit fraTermWizEmpPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraTermWizBasePage, ExtCtrls, DNMPanel, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, wwdbdatetimepicker, StdCtrls, wwdblook;

type
  TfrTermWizEmpPage = class(TfrTermWizBasePage)
    Label21: TLabel;
    cboName: TwwDBLookupCombo;
    Label1: TLabel;
    Label56: TLabel;
    dtpTerminationDate: TwwDBDateTimePicker;
    Label2: TLabel;
    Label8: TLabel;
    cboReason: TwwDBComboBox;
    lblDeath: TLabel;
    cboDeathPaidTo: TwwDBComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frTermWizEmpPage: TfrTermWizEmpPage;

implementation

{$R *.dfm}

end.
