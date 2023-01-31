unit HirePrefs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BasePrefs, Menus, ExtCtrls, StdCtrls, wwdbdatetimepicker,
  DNMSpeedButton, wwcheckbox, Mask, wwdbedit, DNMPanel, DB, DataSourcePrefs,
  MemDS, DBAccess, MyAccess, ERPdbComponents, Wwdbspin, Wwdotdot, Wwdbcomb,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdblook, ERPDbLookupCombo, AdvScrollBox, MessageConst;

type
  THirePrefsGUI = class(TBasePrefsGUI)
    dsPrefs: TDataSourcePrefs;
    lblWidth: TLabel;
    qryColumnHeadings: TERPQuery;
    dsColumnHeadings: TDataSource;
    qryDuration: TERPQuery;
    MyConnection1: TERPConnection;
    qryDurationDurationId: TIntegerField;
    qryDurationDescription: TWideStringField;
    qryDurationDuration: TWideStringField;
    qryDurationStepDuration: TWideStringField;
    qryDurationGraceDuration: TWideStringField;
    qryDurationActive: TWideStringField;
    dsDuration: TDataSource;
    qryIncomeAccountLookup: TERPQuery;
    qryIncomeAccountLookupAccountname: TWideStringField;
    qryIncomeAccountLookupAccountType: TWideStringField;
    qryIncomeAccountLookupAccountId: TIntegerField;
    qryProductLookup: TERPQuery;
    pnlDayWeekInfo: TDNMPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblHours: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    wwDBSpinEdit1: TwwDBSpinEdit;
    wwDBEdit1: TwwDBEdit;
    cboHireIncomeAccountName: TERPDbLookupCombo;
    cboHireProduct: TERPDbLookupCombo;
    DNMPanel1: TDNMPanel;
    Bevel2: TBevel;
    Label10: TLabel;
    Label1: TLabel;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    cmdNew: TDNMSpeedButton;
    procedure wwDBDateTimePicker1Change(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    procedure OnSaveduration(Sender: TObject);
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
  Protected
    procedure StartupProcess(var Msg: TMessage); Override;
    procedure FinishProcess(var Msg: TMessage); Override;
  public
  end;


implementation

{$R *.dfm}

uses
  tcDataUtils, DateUtils, CommonLib, CommonFormLib, PreferancesLib,
  BaseInputForm, Preferences;

procedure THirePrefsGUI.OnSaveduration(Sender: TObject);
begin
  if Sender is TBaseInputGUI then
    if TBaseInputGUI(Sender).BusobjAuditLogDetails <> '' then
      if  Preferenceform <> nil then
        if Preferenceform  is TPreferencesGUI then
          TPreferencesGUI(Preferenceform).CreateAuditTrailEntry('Hire - Hire Durations - ' +TBaseInputGUI(Sender).BusobjAuditLogDetails);
end;
procedure THirePrefsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmDuration',0, nil, False, OnSaveduration);
  qryDuration.Refresh;
end;

procedure THirePrefsGUI.grdMainDblClick(Sender: TObject);
begin
  inherited;
  if qryDuration.Active and (qryDuration.RecordCount > 0) then begin
    OpenERPFormModal('TfmDuration',qryDurationDurationId.AsInteger, nil, False, OnSaveduration);
    qryDuration.Refresh;
  end;
end;

procedure THirePrefsGUI.wwDBDateTimePicker1Change(Sender: TObject);
begin
  inherited;
  lblHours.caption := 'Day Duration : ' + FormatSeconds(SecondsBetween(wwDBDateTimePicker2.time , wwDBDateTimePicker1.time ));
  lblHours.visible := devmode;
end;
procedure THirePrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;

end;
procedure THirePrefsGUI.FinishProcess(var Msg: TMessage);
begin
  inherited;

end;
procedure THirePrefsGUI.PerformStartup(var Msg: TMessage);
begin
   DoPerformStartup(Msg);
end;
procedure THirePrefsGUI.PerformFinish(var Msg: TMessage);
begin
  inherited;
  DoPrefformFinish(Msg);
end;

initialization
  RegisterClass(THirePrefsGUI);

end.