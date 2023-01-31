unit fraBaseWizardPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, DNMPanel;

type
  TfrBaseWizardPage = class(TFrame)
    pnlMain: TDNMPanel;
  private
    fSelected: Boolean;
    procedure SetSelected(const Value: Boolean);
//    procedure OnWizardFormShow(WizardForm: TForm);
  protected
  public
    PageName: string;
    Button: TWinControl;
    constructor Create(AOwner: TComponent); override;
    property Selected: Boolean read fSelected write SetSelected;
    procedure AfterPageAdded(WizardForm: TForm); virtual;
//    procedure OnWizardFormShow(WizardForm: TForm); virtual;
    procedure OnWizardInitialise(WizardForm: TForm); virtual;
  end;

implementation

{$R *.dfm}

{ TplBaseWizardPage }

procedure TfrBaseWizardPage.AfterPageAdded(WizardForm: TForm);
begin

end;

constructor TfrBaseWizardPage.Create(AOwner: TComponent);
begin
  inherited;
  self.Name := self.Name + '_' + IntToStr(integer(self));
  PageName:= 'Unknown Page';
end;

procedure TfrBaseWizardPage.OnWizardInitialise(WizardForm: TForm);
begin

end;

//procedure TfrBaseWizardPage.OnWizardFormShow(WizardForm: TForm);
//begin
//
//end;

procedure TfrBaseWizardPage.SetSelected(const Value: Boolean);
begin
  fSelected := Value;
  if fSelected then
    pnlMain.Visible := true
  else
    pnlMain.Visible := false;

end;

initialization
  RegisterClass(TfrBaseWizardPage);


end.
