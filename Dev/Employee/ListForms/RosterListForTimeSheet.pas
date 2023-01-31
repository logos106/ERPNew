unit RosterListForTimeSheet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, tcTypes, DAScript, MyScript,
  wwcheckbox, CustomInputBox;

type


  TRosterListForTimeSheetGUI = class(TBaseListingGUI)
    qryMainRosterID: TIntegerField;
    qryMainType: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClassID: TIntegerField;
    qryMainNotes: TWideStringField;
    qryMainDate: TDateField;
    qryMainStartTime: TDateTimeField;
    qryMainEndTime: TDateTimeField;
    qryMainClockedOff: TWideStringField;
    qryMainTypeCatagory: TWideStringField;
    qryMainHours: TFloatField;
    qryMainIsClocked: TWideStringField;
    chkClocked: TCheckBox;
    qryMainEmployeeName: TWideStringField;
    btnLoadroster: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkClockedClick(Sender: TObject);
    procedure btnLoadrosterClick(Sender: TObject);
  private
    fLoadroster: TGeneralDatasetProc;

  Protected
    Procedure IterateselectedRecordsCallback(Var abort:Boolean;SelIndex:Integer);Override;
  public
    Property Loadroster :TGeneralDatasetProc read fLoadroster write fLoadroster;
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, AppEnvironment, MySQLConst;

{$R *.dfm}

procedure TRosterListForTimeSheetGUI.btnLoadrosterClick(Sender: TObject);
begin
  IterateselectedRecords(True , 'Loading Rosters into time sheet');
  Self.Close;
end;

procedure TRosterListForTimeSheetGUI.chkClockedClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkClocked then RefreshQuery;
end;

procedure TRosterListForTimeSheetGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TRosterListForTimeSheetGUI.FormCreate(Sender: TObject);
begin
  inherited;
  chkClocked.Checked :=appenv.companyprefs.UseClockedHrs;
  fLoadroster := nil;
  if appenv.companyprefs.UseClockedHrs then
    chkClocked.hint := 'Payroll Preference is to ''Use Only Clocked hours'''
  else chkClocked.hint := 'Payroll Preference is to ''Use All''';
  chkClocked.showhint := true;
end;

procedure TRosterListForTimeSheetGUI.IterateselectedRecordsCallback(var abort: Boolean;SelIndex:Integer);
begin
  inherited;
  if assigned(fLoadroster) then
    fLoadroster(Qrymain);
end;


procedure TRosterListForTimeSheetGUI.RefreshQuery;
begin
  qryMain.Close;
  qryMain.Params.ParamByName('FromDate').AsString := FormatDateTime(MysqlDateFormat, dtfrom.DateTime);
  qryMain.Params.ParamByName('ToDate').AsString := FormatDateTime(MysqlDateFormat, dtto.DateTime);
  Qrymain.Parambyname('Isclocked').asboolean :=  chkClocked.Checked ;
  inherited;
end;

initialization
  RegisterClassOnce(TRosterListForTimeSheetGUI);

end.
