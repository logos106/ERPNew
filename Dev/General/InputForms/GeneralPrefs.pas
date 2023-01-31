unit GeneralPrefs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BasePrefs, Menus, ExtCtrls, StdCtrls, DB, DataSourcePrefs,
  wwcheckbox, DNMPanel, MessageConst, Mask, wwdbedit, MemDS, DBAccess, MyAccess,
  ERPdbComponents, AdvScrollBox;

type
  TGeneralPrefsGUI = class(TBasePrefsGUI)
    dsPrefs: TDataSourcePrefs;
    lblWidth: TLabel;
    qryColumnHeadings: TERPQuery;
    dsColumnHeadings: TDataSource;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label94: TLabel;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit29: TwwDBEdit;
    wwDBEdit30: TwwDBEdit;
    DNMPanel16: TDNMPanel;
    Bevel20: TBevel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    wwDBEdit26: TwwDBEdit;
    wwDBEdit27: TwwDBEdit;
    wwDBEdit28: TwwDBEdit;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    wwDBEdit9: TwwDBEdit;
    Label3: TLabel;
    wwDBEdit1: TwwDBEdit;
    Label6: TLabel;
    wwDBEdit2: TwwDBEdit;
    wwCheckBox10: TwwCheckBox;
    wwCheckBox1: TwwCheckBox;
    chkMakeMcforClients: TwwCheckBox;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    wwCheckBox2: TwwCheckBox;
    DNMPanel4: TDNMPanel;
    lblNote1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure qryColumnHeadingsBeforePost(DataSet: TDataSet);
    procedure chkMakeMcforClientsClick(Sender: TObject);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure MakeMarketingcontacts;
  Protected
    procedure StartupProcess(var Msg: TMessage); Override;
    procedure FinishProcess(var Msg: TMessage); Override;
  public

  end;


implementation

uses CommonLib, tcConst, BusObjClient, Preferences;

{$R *.dfm}
{ TGeneralPrefsGUI }

procedure TGeneralPrefsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  lblNote1.caption := 'When Checked,'+NL+
                      '  The list forms will have a Section on the right side for the selected records.'+NL+
                      '  CTRL+ENTER or Double Click on the Main Grid to ''SELECT'' the Record.'+NL+
                      '  CTRL+ENTER or Double Click on the Selection Grid to ''REMOVE'' the Record from selection.';
end;

procedure TGeneralPrefsGUI.qryColumnHeadingsBeforePost(DataSet: TDataSet);
begin
  DsBeforePostAuditTrail(DataSet , 'ptcolumnHeadings');
end;
procedure TGeneralPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TGeneralPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  if qryColumnHeadings.State in [dsEdit, dsInsert] then
    qryColumnHeadings.Post;
end;

procedure TGeneralPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TGeneralPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
end;

procedure TGeneralPrefsGUI.chkMakeMcforClientsClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkMakeMcforClients then
    if chkMakeMcforClients.checked then
      if MessageDlgXP_Vista('Do you Wish To Create ''Marketing Contacts'' for the Existing Clients? ', mtConfirmation, [mbYes, mbNo], 0) = mryes then
        MakeMarketingcontacts;
end;
procedure TGeneralPrefsGUI.MakeMarketingcontacts;
begin
  TClient.MakeMarketingcontact(Preferenceform , TERPConnection(dsPrefs.Connection ) , TPreferencesGUI(Preferenceform).DoBusinessObjectEvent , 0);
end;

initialization
  RegisterClassOnce(TGeneralPrefsGUI);
finalization
  UnRegisterClass(TGeneralPrefsGUI);

end.
