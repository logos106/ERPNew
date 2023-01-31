unit FixedAssetsPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 14/08/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MessageConst, DB, DataSourcePrefs, DBAccess, MyAccess,ERPdbComponents, StdCtrls,
  MemDS, wwdblook, ExtCtrls, DNMPanel, wwclearbuttongroup, wwradiogroup, BasePrefs,
  frmBase, Menus, AdvScrollBox;

type
  TFixedAssetsPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    qryAccountFixed: TERPQuery;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwDBLookupCombo2: TwwDBLookupCombo;
    wwDBLookupCombo3: TwwDBLookupCombo;
    wwDBLookupCombo4: TwwDBLookupCombo;
    wwRadioGroup1: TwwRadioGroup;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label6: TLabel;
    Bevel3: TBevel;
    Label7: TLabel;
    Bevel4: TBevel;
    Label8: TLabel;
    wwRadioGroup2: TwwRadioGroup;
    wwRadioGroup3: TwwRadioGroup;
    wwRadioGroup4: TwwRadioGroup;
    wwRadioGroup5: TwwRadioGroup;
    wwRadioGroup6: TwwRadioGroup;
    wwRadioGroup7: TwwRadioGroup;
    wwRadioGroup8: TwwRadioGroup;
    wwRadioGroup9: TwwRadioGroup;
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
  Protected
        procedure StartupProcess(var Msg: TMessage); Override;
        procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CommonLib;

{ TFixedAssetsPrefsGUI }

procedure TFixedAssetsPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TFixedAssetsPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
//
end;

procedure TFixedAssetsPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TFixedAssetsPrefsGUI.FinishProcess(var Msg: TMessage);
begin
//
end;

initialization
  RegisterClassOnce(TFixedAssetsPrefsGUI);
finalization
  UnRegisterClass(TFixedAssetsPrefsGUI);
end.
