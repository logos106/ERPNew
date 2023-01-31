unit datVs1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BaseGUIDatamodule, Menus, ActnList, DNMAction;

type
  TdmVs1 = class(TdtmGUI)
    ActionList: TActionList;
    actvs1ClientList: TDNMAction;
    MainMenu: TMainMenu;
    ERP1: TMenuItem;
    VS1LicenceList1: TMenuItem;
    actVS1LicenseLevelsnModules: TDNMAction;
    actVs1DatabaseList: TDNMAction;
    actVS1AdminDBconfig: TDNMAction;
    actVS1Test: TDNMAction;
    actClientARListGUI: TDNMAction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses ERPLib, CommonLib;

{$R *.dfm}

procedure TdmVs1.DataModuleCreate(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  for ctr:= 0 to componentcount-1 do begin
    if components[ctr] is TDNMAction then
      try
        TDNMAction(components[ctr]).Visible := IsVS1_ProductionAdminDatabase or IsVS1_SandBoxAdminDatabase;
      Except
        on E:Exception do begin
          TDNMAction(components[ctr]).Visible := False;
        end;

      end;
  end;
  actVS1AdminDBconfig.Visible := (IsVS1_ProductionAdminDatabase or IsVS1_SandBoxAdminDatabase) and devmode;
end;

end.
