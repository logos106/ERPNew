unit frmHireDefaultDuration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, DNMPanel, Mask, wwdbedit, Wwdotdot, AdvEdit, Grids,
  AdvObj, BaseGrid, AdvGrid, BusObjHire;

type
  TfmHireDefaultDuration = class(TBaseForm)
    Label9: TLabel;
    cboTimeFrom: TwwDBComboDlg;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    cboTimeTo: TwwDBComboDlg;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label2: TLabel;
    cboActualTimeFrom: TwwDBComboDlg;
    Label3: TLabel;
    cboActualTimeTo: TwwDBComboDlg;
    cboDuration: TComboBox;
    Label4: TLabel;
    edtQty: TAdvEdit;
    Label5: TLabel;
    Label6: TLabel;
    cboActualDuration: TComboBox;
    Label7: TLabel;
    edtActualQty: TAdvEdit;
    grdDuration: TAdvStringGrid;
    grdActualDuration: TAdvStringGrid;
    lblWeekendDays: TLabel;
    lblActWeekendDays: TLabel;
    btnCopyToActual: TDNMSpeedButton;
    btnUpdateLines: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdDurationGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdDurationGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure grdDurationGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormShow(Sender: TObject);
    procedure cboTimeFromCustomDlg(Sender: TObject);
    procedure cboTimeToCustomDlg(Sender: TObject);
    procedure cboActualTimeFromCustomDlg(Sender: TObject);
    procedure cboActualTimeToCustomDlg(Sender: TObject);
    procedure cboDurationChange(Sender: TObject);
    procedure edtQtyChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCopyToActualClick(Sender: TObject);
    procedure btnUpdateLinesClick(Sender: TObject);
  private
    fDefHireFrom: TDateTime;
    fDefHireTo: TDateTime;
    fDefActHireFrom: TDateTime;
    fDefActHireTo: TDateTime;
    procedure LoadValues;
    procedure CalcHireTo;
    procedure SetDefHireFrom(const Value: TDateTime);
    procedure SetDefHireTo(const Value: TDateTime);
    procedure SetDefActHireFrom(const Value: TDateTime);
    procedure SetDefActHireTo(const Value: TDateTime);
    procedure PopulateGrid(aGrid: TAdvStringGrid; dtFrom, dtTo: TDateTime; WeekendDays: integer); overload;
    procedure PopulateGrid(aGrid: TAdvStringGrid; DurationId: integer; Qty: double); overload;
    procedure CalcDurationAndQtyFromDates;
    procedure CalActDurationAndQtyFromDates;
    procedure SaveValues;
    function GetDurationID: integer;
    function GetActDurationID: integer;
  protected
    property DefHireFrom: TDateTime read fDefHireFrom write SetDefHireFrom;
    property DefHireTo: TDateTime read fDefHireTo write SetDefHireTo;
    property DefActHireFrom: TDateTime read fDefActHireFrom write SetDefActHireFrom;
    property DefActHireTo: TDateTime read fDefActHireTo write SetDefActHireTo;
    property DurationID: integer read GetDurationID;
    property ActDurationID: integer read GetActDurationID;

  public
    Hire: THire;
  end;

  function DoSetHireDurations(aHire: THire): boolean;


implementation

uses
  ERPDbComponents, CommonDbLib, DbSharedObjectsObj, frmDateTimeSelect,
  BusObjAssetHire, AppEnvironment, DnmLib, CommonLib, frmHireRateEdit;

{$R *.dfm}

function DoSetHireDurations(aHire: THire): boolean;
var
  form: TfmHireDefaultDuration;
begin
  form := TfmHireDefaultDuration.Create(nil);
  form.Hire := aHire;
  result := form.ShowModal = mrOk;
end;

procedure TfmHireDefaultDuration.grdDurationGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if ACol = 1 then
    HAlign := taRightJustify;
end;

procedure TfmHireDefaultDuration.grdDurationGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
  if ACol = 1 then
    Value := '#0.00';
end;

procedure TfmHireDefaultDuration.grdDurationGetEditorType(Sender: TObject;
  ACol, ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  if ACol = 1 then
      AEditor:= edFloat;
end;

procedure TfmHireDefaultDuration.LoadValues;
begin

  cboDuration.ItemIndex := cboDuration.Items.IndexOfObject(TObject(Hire.DefaultDurationId));
  edtQty.FloatValue := Hire.DefaultDurationQty;

  cboActualDuration.ItemIndex := cboActualDuration.Items.IndexOfObject(TObject(Hire.DefaultActualDurationId));
  edtActualQty.FloatValue := Hire.DefaultActualDurationQty;

  lblWeekendDays.Caption := '';
  lblActWeekendDays.Caption := '';

end;

procedure TfmHireDefaultDuration.PopulateGrid(aGrid: TAdvStringGrid;
  DurationId: integer; Qty: double);
var
  qry: TERPQuery;
  fQty: double;
  hoursPerDay: double;
  daysPerWeek: integer;
  weeksPerMonth: double;
const
  weeksPerYear = 365 / 7;
//  weeksPerMonth = 52 / 12;
//  daysPerMonth = 365 / 12;
begin
  hoursPerDay := (Frac(AppEnv.CompanyPrefs.EndOfDay) - Frac(AppEnv.CompanyPrefs.StartOfDay)) * 24;
  daysPerWeek := 7 - AppEnv.CompanyPrefs.NoOfWeekendDays;
  weeksPerMonth := Round(WeeksPerYear / 12,2);
  qry := DbSharedObj.GetQuery(Hire.Connection.Connection);
  try
    qry.SQL.Text := 'select * from tblDuration where DurationId = ' + IntToStr(DurationId);
    qry.Open;
    fQty := Qty * qry.FieldByName('Qty').AsFloat;

    if SameText(qry.FieldByName('DurationType').AsString, 'H') then begin
      aGrid.Floats[1,0] := fQty;
      aGrid.Floats[1,1] := DivZer(fQty, hoursPerDay);
      aGrid.Floats[1,2] := DivZer(fQty, hoursPerDay * DaysPerWeek);
      aGrid.Floats[1,3] := DivZer(fQty, hoursPerDay * DaysPerWeek * weeksPerMonth);
      aGrid.Floats[1,4] := DivZer(fQty, hoursPerDay * DaysPerWeek * 52);
    end
    else if SameText(qry.FieldByName('DurationType').AsString, 'Y') then begin
      aGrid.Floats[1,0] := fQty * HoursPerDay * 365;
      aGrid.Floats[1,1] := fQty * 365;
      aGrid.Floats[1,2] := fQty * 52;
      aGrid.Floats[1,3] := fQty * 12;
      aGrid.Floats[1,4] := fQty;
    end
    else if SameText(qry.FieldByName('DurationType').AsString, 'M') then begin
      aGrid.Floats[1,0] := fQty * HoursPerDay * daysPerWeek * WeeksPerMonth;
      aGrid.Floats[1,1] := fQty * daysPerWeek * WeeksPerMonth;
      aGrid.Floats[1,2] := fQty * weeksPerMonth;
      aGrid.Floats[1,3] := fQty;
      aGrid.Floats[1,4] := DivZer(fQty,12);
    end
    else if SameText(qry.FieldByName('DurationType').AsString, 'W') then begin
      aGrid.Floats[1,0] := fQty * HoursPerDay * daysPerWeek;
      aGrid.Floats[1,1] := fQty * daysPerWeek;
      aGrid.Floats[1,2] := fQty;
      aGrid.Floats[1,3] := DivZer(fQty,weeksPerMonth);
      aGrid.Floats[1,4] := DivZer(fQty,52);
    end
    else if SameText(qry.FieldByName('DurationType').AsString, 'D') then begin
      aGrid.Floats[1,0] := fQty * HoursPerDay;
      aGrid.Floats[1,1] := fQty;
      aGrid.Floats[1,2] := DivZer(fQty, daysPerWeek);
      aGrid.Floats[1,3] := DivZer(fQty, daysPerWeek * weeksPerMonth);
      aGrid.Floats[1,4] := DivZer(fQty,365);
    end
  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;

procedure TfmHireDefaultDuration.PopulateGrid(aGrid: TAdvStringGrid; dtFrom,
  dtTo: TDateTime; WeekendDays: integer);
var
  dt: TDateTime;
  hours: double;
  days: double;
  hoursPerDay: double;
  DaysPerWeek: integer;
  WeeksPerMonth: double;
//  DaysPerYear: integer;
begin
  dt := dtTo - WeekendDays;
  hoursPerDay := (Frac(AppEnv.CompanyPrefs.EndOfDay) - Frac(AppEnv.CompanyPrefs.StartOfDay)) * 24;
  DaysPerWeek := 7 - AppEnv.CompanyPrefs.NoOfWeekendDays;
  WeeksPerMonth := 52 / 12;
  hours := 0;
  if (Trunc(dt) - Trunc(dtFrom)) > 1  then
    days := (Trunc(dt) - Trunc(dtFrom)) -1
  else
    days := 0;

  if Frac(dtFrom) > Frac(AppEnv.CompanyPrefs.StartOfDay) then
    { partial day }
    hours := hours  + ((Frac(AppEnv.CompanyPrefs.EndOfDay) - Frac(dtFrom)) * 24)
  else
    hours := hours  + hoursPerDay;

  if Frac(dt) < Frac(AppEnv.CompanyPrefs.EndOfDay) then
    { partial day }
    hours := hours  + ((Frac(dt) - Frac(AppEnv.CompanyPrefs.StartOfDay)) * 24)
  else
    hours := hours  + hoursPerDay;

  while hours >= hoursPerday do begin
    days := days + 1;
    hours := hours - hoursPerday;
  end;
  days := days + DivZer(hours, hoursPerDay);

  aGrid.Floats[1,0] := (days * hoursPerDay);
  aGrid.Floats[1,1] := days;
  aGrid.Floats[1,2] := DivZer(days, DaysPerWeek);
  aGrid.Floats[1,3] := DivZer(days, DaysPerWeek * WeeksPerMonth);
  aGrid.Floats[1,4] := DivZer(days, DaysPerWeek * 52);
end;

procedure TfmHireDefaultDuration.SaveValues;
begin
  Hire.DefaultHireFrom := DefHireFrom;
  Hire.DefaultHireTo := DefHireTo;
  Hire.DefaultDurationId := 0;
  if cboDuration.ItemIndex >= 0 then
    Hire.DefaultDurationId := Integer(cboDuration.Items.Objects[cboDuration.ItemIndex]);
  Hire.DefaultDurationQty := edtQty.FloatValue;

  Hire.DefaultActualHireFrom := DefActHireFrom;
  Hire.DefaultActualHireTo := DefActHireTo;
  Hire.DefaultActualDurationId := 0;
  if cboActualDuration.ItemIndex >= 0 then
    Hire.DefaultActualDurationId := Integer(cboActualDuration.Items.Objects[cboActualDuration.ItemIndex]);
  Hire.DefaultActualDurationQty := edtActualQty.FloatValue;
end;

procedure TfmHireDefaultDuration.SetDefActHireFrom(const Value: TDateTime);
begin
  fDefActHireFrom := Value;
  if DefActHireFrom > 0 then
    cboActualTimeFrom.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,DefActHireFrom) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,DefActHireFrom)
  else
    cboActualTimeFrom.Text := ''
end;

procedure TfmHireDefaultDuration.SetDefActHireTo(const Value: TDateTime);
begin
  fDefActHireTo := Value;
  if DefActHireTo > 0 then
    cboActualTimeTo.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,DefActHireTo) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,DefActHireTo)
  else
    cboActualTimeTo.Text := '';
end;

procedure TfmHireDefaultDuration.SetDefHireFrom(const Value: TDateTime);
begin
  fDefHireFrom := Value;
  if DefHireFrom > 0 then
    cboTimeFrom.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,DefHireFrom) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,DefHireFrom)
  else
    cboTimeFrom.Text := '';
end;

procedure TfmHireDefaultDuration.SetDefHireTo(const Value: TDateTime);
begin
  fDefHireTo := Value;
  if DefHireTo > 0 then
    cboTimeTo.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,DefHireTo) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,DefHireTo)
  else
    cboTimeTo.Text := '';
end;

procedure TfmHireDefaultDuration.btnCopyToActualClick(Sender: TObject);
begin
  inherited;
  DefActHireFrom := DefHireFrom;
  DefActHireTo := DefHireTo;
  if cboActualDuration.ItemIndex <> cboDuration.ItemIndex then
    cboActualDuration.ItemIndex := cboDuration.ItemIndex;
  if edtActualQty.FloatValue <> edtQty.FloatValue then
    edtActualQty.FloatValue := edtQty.FloatValue;
  PopulateGrid(grdActualDuration,Integer(cboActualDuration.Items.Objects[cboActualDuration.ItemIndex]),edtActualQty.FloatValue);
end;

procedure TfmHireDefaultDuration.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveValues;
  ModalResult := mrOk;
end;

procedure TfmHireDefaultDuration.btnUpdateLinesClick(Sender: TObject);
var
  durID: integer;
begin
  inherited;
  try
    durId := DurationID;
    if (DefActHireFrom > 0) and (DefActHireTo > 0) then
      durId := ActDurationId;

    if CommonLib.MessageDlgXP_Vista('This will update the dates on all hire lines to match the dates selected here, is that what you want to do?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      Hire.HireLines.First;
      while not Hire.HireLines.EOF do begin
        if (DurId > 0) and (not TAssetHire.HasDurationPrice(Hire.HireLines.AssetId,DurId)) then begin
          if CommonLib.MessageDlgXP_Vista(Hire.HireLines.AssetName + ' ' + Hire.HireLines.AssetCode +
            ' does not have a price for ' + cboDuration.Text + ', do you want to add one?', mtWarning,[mbYes,mbNo],0) = mrYes then begin
            if frmHireRateEdit.AddNewHireRate(Hire.HireLines.AssetName, DurId) then begin
              Hire.HireLines.DurationId := DurID;
              Hire.HireLines.PostDb;
            end;

          end;
        end;

        if Hire.HireLines.HireFrom <> DefHireFrom then
          Hire.HireLines.HireFrom := DefHireFrom;
        if Hire.HireLines.ActualHireFrom <> DefActHireFrom then
          Hire.HireLines.ActualHireFrom := DefActHireFrom;
  //      if Hire.HireLines.HireTo <> DefHireTo then
  //        Hire.HireLines.HireTo := DefHireTo;
        if Hire.HireLines.DurationId <> DurId then
          Hire.HireLines.DurationId := DurId;
        if Hire.HireLines.DurationQty <> edtQty.FloatValue then
          Hire.HireLines.DurationQty := edtQty.FloatValue;

  //      if Hire.HireLines.ActualHireFrom <> DefActHireFrom then
  //        Hire.HireLines.ActualHireFrom := DefActHireFrom;
  //      if Hire.HireLines.ActualHireTo <> DefActHireTo then
  //        Hire.HireLines.ActualHireTo := DefActHireTo;


        Hire.HireLines.Next;
      end;
    end;
  except
    on e: exception do begin
//      showmessage(e.Message);
      raise;
    end;
  end;
end;

procedure TfmHireDefaultDuration.CalActDurationAndQtyFromDates;
var
  qty: double;
  DurationId: integer;
begin
  if (DefActHireFrom = 0) or (DefActHireTo = 0) then exit;
  { get data for all durations }
  DurationId := TAssetHire.CalcHireQty(DefActHireFrom,DefActHireTo,'',qty);
  if DurationId = 0 then exit;
  cboActualDuration.ItemIndex := cboActualDuration.Items.IndexOfObject(TObject(DurationId));
  edtActualQty.FloatValue := Qty;
  PopulateGrid(grdActualDuration,DurationId,Qty);
end;

procedure TfmHireDefaultDuration.CalcDurationAndQtyFromDates;
var
  qty: double;
  DurationId: integer;
begin
  if (DefHireFrom = 0) or (DefHireTo = 0) then exit;
  { get data for all durations }
  DurationId := TAssetHire.CalcHireQty(DefHireFrom,DefHireTo,'',qty);
  if DurationId = 0 then exit;
  cboDuration.ItemIndex := cboDuration.Items.IndexOfObject(TObject(DurationId));
  edtQty.FloatValue := Qty;
  PopulateGrid(grdDuration,DurationId,Qty);
end;

procedure TfmHireDefaultDuration.CalcHireTo;
var
  WeekendDays: integer;
begin
  if cboDuration.ItemIndex < 0 then exit;
  if edtQty.FloatValue = 0 then exit;
  if DefHireFrom = 0 then exit;
  DefHireTo := TAssetHire.CalcHireToDate(DefHireFrom,Integer(cboDuration.Items.Objects[cboDuration.ItemIndex]),
    edtQty.FloatValue,TERPConnection(Hire.Connection.Connection));
  WeekendDays := TAssetHire.WeekendDays(DefHireFrom,DefHireTo);
  if WeekendDays > 0 then
    lblWeekendDays.Caption := IntToStr(WeekendDays) + ' weekend days'
  else
    lblWeekendDays.Caption := '';
//  PopulateGrid(grdDuration,DefHireFrom,DefHireTo,WeekendDays);
  PopulateGrid(grdDuration,Integer(cboDuration.Items.Objects[cboDuration.ItemIndex]),edtQty.FloatValue);
end;

procedure TfmHireDefaultDuration.cboActualTimeFromCustomDlg(Sender: TObject);
var
  dt: TDateTime;
begin
  inherited;
  if DefActHireFrom  = 0 then
    dt := Now()
  else
    dt := DefActHireFrom;
  if frmDateTimeSelect.SelectDateTime(dt) then begin
    DefActHireFrom := dt;
    cboActualTimeFrom.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,DefActHireFrom) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,DefActHireFrom);
  end;
  CalActDurationAndQtyFromDates;
end;

procedure TfmHireDefaultDuration.cboActualTimeToCustomDlg(Sender: TObject);
var
  dt: TDateTime;
begin
  inherited;
  if DefActHireTo  = 0 then
    dt := Now()
  else
    dt := DefActHireTo;
  if frmDateTimeSelect.SelectDateTime(dt) then begin
    DefActHireTo := dt;
    cboActualTimeTo.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,DefActHireTo) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,DefActHireTo);
  end;
  CalActDurationAndQtyFromDates;
end;

procedure TfmHireDefaultDuration.cboDurationChange(Sender: TObject);
begin
  inherited;
  if not cboDuration.Focused then exit;
  CalcHireTo;
end;

procedure TfmHireDefaultDuration.cboTimeFromCustomDlg(Sender: TObject);
var
  dt: TDateTime;
begin
  inherited;
  if DefHireFrom  = 0 then
    dt := Now()
  else
    dt := DefHireFrom;
  if frmDateTimeSelect.SelectDateTime(dt) then begin
    DefHireFrom := dt;
    cboTimeFrom.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,DefHireFrom) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,DefHireFrom);
  end;
  CalcDurationAndQtyFromDates;
end;

procedure TfmHireDefaultDuration.cboTimeToCustomDlg(Sender: TObject);
var
  dt: TDateTime;
begin
  inherited;
  if DefHireTo  = 0 then
    dt := Now()
  else
    dt := DefHireTo;
  if frmDateTimeSelect.SelectDateTime(dt) then begin
    DefHireTo := dt;
    cboTimeTo.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,DefHireTo) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,DefHireTo);
  end;
  CalcDurationAndQtyFromDates;
end;

procedure TfmHireDefaultDuration.edtQtyChange(Sender: TObject);
begin
  inherited;
  if not edtQty.Focused then exit;
  CalcHireTo;
end;

procedure TfmHireDefaultDuration.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmHireDefaultDuration.FormCreate(Sender: TObject);
var
  qry: TERPQuery;

  procedure LoadTimeCombo;
  begin
    qry.Open;
    while not qry.EOF do begin
      cboDuration.Items.AddObject(qry.FieldByName('Description').AsString, TObject(qry.FieldByName('DurationId').AsInteger));
      cboActualDuration.Items.AddObject(qry.FieldByName('Description').AsString, TObject(qry.FieldByName('DurationId').AsInteger));
      qry.Next;
    end;
    qry.Close;
  end;

begin
  inherited;

  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select * from tblDuration where Active = "T" and DurationType = :DurationType');
    qry.SQL.Add('order by Qty');

    qry.ParamByName('DurationType').AsString := 'H';
    LoadTimeCombo;
    qry.ParamByName('DurationType').AsString := 'D';
    LoadTimeCombo;
    qry.ParamByName('DurationType').AsString := 'W';
    LoadTimeCombo;
    qry.ParamByName('DurationType').AsString := 'M';
    LoadTimeCombo;
    qry.ParamByName('DurationType').AsString := 'Y';
    LoadTimeCombo;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;

  grdDuration.ColWidths[1] := grdDuration.Width - grdDuration.ColWidths[0] -4;
  if AppEnv.CompanyPrefs.NoOfWeekendDays > 0 then begin
    grdDuration.Cells[0,0] := 'Hours';
    grdDuration.Cells[0,1] := 'Working Days';
    grdDuration.Cells[0,2] := 'Working Weeks';
    grdDuration.Cells[0,3] := 'Working Months';
    grdDuration.Cells[0,4] := 'Working Years';
  end
  else begin
    grdDuration.Cells[0,0] := 'Hours';
    grdDuration.Cells[0,1] := 'Calendar Days';
    grdDuration.Cells[0,2] := 'Calendar Weeks';
    grdDuration.Cells[0,3] := 'Calendar Months';
    grdDuration.Cells[0,4] := 'Calendar Years';
  end;

  grdDuration.Floats[1,0] := 0;
  grdDuration.Floats[1,1] := 0;
  grdDuration.Floats[1,2] := 0;
  grdDuration.Floats[1,3] := 0;
  grdDuration.Floats[1,4] := 0;

  grdActualDuration.ColWidths[1] := grdActualDuration.Width - grdActualDuration.ColWidths[0] -4;
  if AppEnv.CompanyPrefs.NoOfWeekendDays > 0 then begin
    grdActualDuration.Cells[0,0] := 'Hours';
    grdActualDuration.Cells[0,1] := 'Working Days';
    grdActualDuration.Cells[0,2] := 'Working Weeks';
    grdActualDuration.Cells[0,3] := 'Working Months';
    grdActualDuration.Cells[0,4] := 'Working Years';
  end
  else begin
    grdActualDuration.Cells[0,0] := 'Hour';
    grdActualDuration.Cells[0,1] := 'Calendar Days';
    grdActualDuration.Cells[0,2] := 'Calendar Weeks';
    grdActualDuration.Cells[0,3] := 'Calendar Months';
    grdActualDuration.Cells[0,4] := 'Calendar Years';
  end;
  grdActualDuration.Floats[1,0] := 0;
  grdActualDuration.Floats[1,1] := 0;
  grdActualDuration.Floats[1,2] := 0;
  grdActualDuration.Floats[1,3] := 0;
  grdActualDuration.Floats[1,4] := 0;
end;

procedure TfmHireDefaultDuration.FormShow(Sender: TObject);
begin
  inherited;
  DefHireFrom := Hire.DefaultHireFrom;
  DefHireTo := Hire.DefaultHireTo;
  DefActHireFrom := Hire.DefaultActualHireFrom;
  DefActHireTo := Hire.DefaultActualHireTo;
  LoadValues;
  if cboDuration.ItemIndex >= 0 then
    PopulateGrid(grdDuration,Integer(cboDuration.Items.Objects[cboDuration.ItemIndex]),edtQty.FloatValue);
  if cboActualDuration.ItemIndex >= 0 then
    PopulateGrid(grdActualDuration,Integer(cboActualDuration.Items.Objects[cboActualDuration.ItemIndex]),edtActualQty.FloatValue);
end;

function TfmHireDefaultDuration.GetActDurationID: integer;
begin
  result := 0;
  if cboActualDuration.ItemIndex >= 0 then
    result := Integer(cboActualDuration.Items.Objects[cboActualDuration.ItemIndex]);
end;

function TfmHireDefaultDuration.GetDurationID: integer;
begin
  result := 0;
  if cboDuration.ItemIndex >= 0 then
    result := Integer(cboDuration.Items.Objects[cboDuration.ItemIndex]);
end;

end.
