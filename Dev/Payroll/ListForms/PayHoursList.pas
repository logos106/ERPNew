unit PayHoursList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPayHoursListGUI = class(TBaseListingGUI)
    chkUseDatePaid: TCheckBox;
    qryMainEmployeeName: TWideStringField;
    qryMainPayId: TIntegerField;
    qryMainPayDate: TDateField;
    qryMainDatePaid: TDateTimeField;
    qryMainDepartment: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainHours: TFloatField;
    lblDepartment: TLabel;
    cboDepartments: TwwDBLookupCombo;
    chkAllDepartments: TCheckBox;
    Label5: TLabel;
    qryClass: TERPQuery;
    procedure chkUseDatePaidClick(Sender: TObject);
    procedure chkAllDepartmentsClick(Sender: TObject);
    procedure cboDepartmentsCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    DoRefreshQuery: boolean;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

var
  PayHoursListGUI: TPayHoursListGUI;

implementation

uses
  DateUtils, CommonLib;

{$R *.dfm}

{ TPayHoursListGUI }

procedure TPayHoursListGUI.cboDepartmentsCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not chkAllDepartments.Checked then
    RefreshQuery;
end;

procedure TPayHoursListGUI.chkAllDepartmentsClick(Sender: TObject);
begin
  inherited;
//  if chkUseDatePaid.Focused then
  if chkAllDepartments.Checked then begin
    lblDepartment.Enabled := false;
    cboDepartments.Enabled := false;
  end
  else begin
    lblDepartment.Enabled := true;
    cboDepartments.Enabled := true;
    if cboDepartments.Text = '' then begin
      if cboDepartments.LookupTable.RecordCount > 0 then begin
        cboDepartments.LookupTable.First;
        cboDepartments.Text := cboDepartments.LookupTable.FieldByName(cboDepartments.LookupField).AsString;
      end;
    end;
  end;
  RefreshQuery;
end;

procedure TPayHoursListGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  inherited;
  chkUseDatePaid.Enabled := not chkIgnoreDates.Checked;
end;

procedure TPayHoursListGUI.chkUseDatePaidClick(Sender: TObject);
begin
  inherited;
//  if chkAllDepartments.Focused then
    RefreshQuery;
end;

procedure TPayHoursListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  DoRefreshQuery := false;
  self.AddCalcColumn('Hours',false);
end;

procedure TPayHoursListGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryClass.Open;
  DoRefreshQuery := true;
  RefreshQuery;
  SetControlFocus(edtSearch);
end;

procedure TPayHoursListGUI.RefreshQuery;
begin
  if not DoRefreshQuery then exit;

  if chkAllDepartments.Checked then
    qryMain.ParamByName('Department').AsString := ''
  else
    qryMain.ParamByName('Department').AsString := cboDepartments.Text;
  if ChkIgnoreDates.Checked then begin
    qryMain.ParamByName('PayDateFrom').AsDateTime := 0;
    qryMain.ParamByName('PayDateTo').AsDateTime := DateUtils.IncYear(now, 1000);
    qryMain.ParamByName('DatePaidFrom').AsDateTime := 0;
    qryMain.ParamByName('DatePaidTo').AsDateTime := DateUtils.IncYear(now, 1000);
  end
  else begin
    if chkUseDatePaid.Checked then begin
      qryMain.ParamByName('PayDateFrom').AsDateTime := 0;
      qryMain.ParamByName('PayDateTo').AsDateTime := DateUtils.IncYear(now, 1000);
      qryMain.ParamByName('DatePaidFrom').AsDateTime := filterdateFrom;
      qryMain.ParamByName('DatePaidTo').AsDateTime := Filterdateto;
    end
    else begin
      qryMain.ParamByName('PayDateFrom').AsDateTime := Filterdatefrom;
      qryMain.ParamByName('PayDateTo').AsDateTime := FilterDateTo;
      qryMain.ParamByName('DatePaidFrom').AsDateTime := 0;
      qryMain.ParamByName('DatePaidTo').AsDateTime := DateUtils.IncYear(now, 1000);
    end;
  end;

  inherited;

end;

procedure TPayHoursListGUI.RefreshTotals;
begin
  inherited;
  self.CalcnShowFooter;
end;

initialization
  RegisterClass(TPayHoursListGUI);

end.
