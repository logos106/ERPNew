unit frmListnLookupLarge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListnLookup, SelectionDialog, Menus, ExtCtrls, StdCtrls, Shader,
  DNMSpeedButton, DBCtrls, DNMPanel, ActnList, DNMAction, wwdblook;

type
  TfmListnLookupLarge = class(TBaseListnLookupGUI)
    procedure FormShow(Sender: TObject);
  private
  public
    class function MakeInstance: TBaseListnLookupGUI; Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TfmListnLookupLarge.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(fListForm) then begin
    fListForm.grdMain.font.Size := 16;
  end;
end;

class function TfmListnLookupLarge.MakeInstance : TBaseListnLookupGUI;
begin
  Result := TBaseListnLookupGUI(GetComponentByClassName('TfmListnLookupLarge'));
end;

initialization
  RegisterClassOnce(TfmListnLookupLarge);

end.
