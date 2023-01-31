unit fraTermWizBasePage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraBaseWizardPage, ExtCtrls, DNMPanel, frmTErminationWizard;

type
  TfrTermWizBasePage = class(TfrBaseWizardPage)
  private
  protected
    function Form: TfmTerminationWizard;
  public
    { Public declarations }
  end;

var
  frTermWizBasePage: TfrTermWizBasePage;

implementation

{$R *.dfm}

{ TfrTermWizBasePage }

function TfrTermWizBasePage.Form: TfmTerminationWizard;
begin
  result:= nil;
  if Assigned(Owner) and (Owner is TfmTerminationWizard) then
    result := TfmTerminationWizard(Owner);
end;

end.
