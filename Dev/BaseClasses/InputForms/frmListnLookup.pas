unit frmListnLookup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListnLookup, SelectionDialog, Menus, ExtCtrls, StdCtrls, Shader,
  DNMSpeedButton, DBCtrls, DNMPanel, ActnList, DNMAction, wwdblook;

type
  TfmListnLookup = class(TBaseListnLookupGUI)
  private
  public
    class function MakeInstance: TBaseListnLookupGUI; Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TfmListnLookup }

class function TfmListnLookup.MakeInstance: TBaseListnLookupGUI;
begin
  Result := TBaseListnLookupGUI(GetComponentByClassName('TfmListnLookup'));
end;
initialization
  RegisterClassOnce(TfmListnLookup);

end.
