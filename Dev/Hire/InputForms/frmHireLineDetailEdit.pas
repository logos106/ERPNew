unit frmHireLineDetailEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Grids, AdvObj, BaseGrid, AdvGrid, AdvEdit, Mask, wwdbedit,
  Wwdotdot, BusObjHire, Shader, DNMPanel;

type
  TfmHireLineDetailEdit = class(TBaseForm)
    Label9: TLabel;
    cboTimeFrom: TwwDBComboDlg;
    Label4: TLabel;
    cboDuration: TComboBox;
    Label5: TLabel;
    edtQty: TAdvEdit;
    Label1: TLabel;
    cboTimeTo: TwwDBComboDlg;
    grdDuration: TAdvStringGrid;
    Label2: TLabel;
    cboActualTimeFrom: TwwDBComboDlg;
    btnCopyToActual: TDNMSpeedButton;
    Label3: TLabel;
    cboActualTimeTo: TwwDBComboDlg;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lblWeekendDays: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure grdDurationGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure grdDurationGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure grdDurationGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure FormCreate(Sender: TObject);
    procedure grdDurationCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure edtQtyChange(Sender: TObject);
    procedure cboDurationChange(Sender: TObject);
    procedure grdDurationCheckBoxChange(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure grdDurationEditingDone(Sender: TObject);
    procedure grdDurationRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure cboTimeFromCustomDlg(Sender: TObject);
    procedure cboTimeToCustomDlg(Sender: TObject);
    procedure cboActualTimeFromCustomDlg(Sender: TObject);
    procedure cboActualTimeToCustomDlg(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCopyToActualClick(Sender: TObject);
  private
    fHireLine: THireLines;
    fActualTimeTo: TDateTime;
    fTimeTo: TDateTime;
    fActualTimeFrom: TDateTime;
    fTimeFrom: TDateTime;
    CurrentRow: integer;
    function GetDurationQty: double;
    function GetUrationId: integer;
    procedure SetActualTimeFrom(const Value: TDateTime);
    procedure SetActualTimeTo(const Value: TDateTime);
    procedure SetDurationId(const Value: integer);
    procedure SetDurationQty(const Value: double);
    procedure SetHireLine(const Value: THireLines);
    procedure SetTimeFrom(const Value: TDateTime);
    procedure SetTimeTo(const Value: TDateTime);
    procedure CalcHireTo;
    procedure UpdateGridQuantities;
    procedure CalcDurationAndQtyFromDates;
    procedure UpdateGrid;
    function GetDurationRate: double;
  protected
    property TimeFrom: TDateTime read fTimeFrom write SetTimeFrom;
    property TimeTo: TDateTime read fTimeTo write SetTimeTo;
    property DurationQty: double read GetDurationQty write SetDurationQty;
    property DurationId: integer read GetUrationId write SetDurationId;
    property DurationRate: double read GetDurationRate;

    property ActualTimeFrom: TDateTime read fActualTimeFrom write SetActualTimeFrom;
    property ActualTimeTo: TDateTime read fActualTimeTo write SetActualTimeTo;
    property HireLine: THireLines read fHireLine write SetHireLine;
  public
    { Public declarations }
  end;

  function DoEditHireLine(aLine: THireLines): boolean;

implementation

uses
  ERPDbComponents, DbSharedObjectsObj, BusObjAssetHire, DnmLib, CommonLib,
  frmDateTimeSelect;

const
  Col_Desc = 0;
  Col_Rate = 1;
  Col_Qty = 2;
  Col_Price = 3;
  Col_Sel = 4;

{$R *.dfm}

function DoEditHireLine(aLine: THireLines): boolean;
var
  form: TfmHireLineDetailEdit;
begin
  form := TfmHireLineDetailEdit.Create(nil);
  try
    form.HireLine := aLine;
    result := form.ShowModal = mrOk;
  finally
    form.Release;
  end;
end;

{ TfmHireLineDetailEdit }

procedure TfmHireLineDetailEdit.btnCopyToActualClick(Sender: TObject);
begin
  inherited;
  ActualTimeFrom := TimeFrom;
  ActualTimeTo := TimeTo;
end;

procedure TfmHireLineDetailEdit.btnSaveClick(Sender: TObject);
begin
  inherited;
  HireLine.HireFrom := TimeFrom;
  HireLine.HireTo := TimeTo;
  HireLine.ActualHireFrom := ActualTimeFrom;
  HireLine.ActualHireTo := ActualTimeTo;
  HireLine.DurationId := DurationId;
  HireLine.DurationQty := DurationQty;
  HireLine.DurationRate := DurationRate;
  ModalResult := mrOk;
end;

procedure TfmHireLineDetailEdit.CalcDurationAndQtyFromDates;
var
  qty: double;
  DurationId: integer;
begin
  if ((TimeFrom <> 0) and (TimeTo = 0)) or ((ActualTimeFrom <> 0) and (ActualTimeTo = 0)) then begin
    { get data for all durations }
    if (TimeFrom <> 0) then
      DurationId := TAssetHire.CalcHireQty(TimeFrom,TimeTo,'',qty)
    else
      DurationId := TAssetHire.CalcHireQty(ActualTimeFrom,ActualTimeTo,'',qty);
    if DurationId = 0 then exit;
    DurationQty := Qty;
//    PopulateGrid(grdDuration,DurationId,Qty);
  end;
end;

procedure TfmHireLineDetailEdit.CalcHireTo;
var
  WeekendDays: integer;
begin
  if DurationId = 0 then exit;
  if DurationQty = 0 then exit;
  if (TimeFrom = 0) and (ActualTimeFrom = 0) then exit;

  if (TimeFrom <> 0) then begin
//  if ((TimeFrom = 0) or (TimeTo = 0)) and ((ActualTimeFrom = 0) or (ActualTimeTo = 0)) then exit;
    TimeTo := TAssetHire.CalcHireToDate(TimeFrom,DurationId,DurationQty,HireLine.Connection.Connection);
    WeekendDays := TAssetHire.WeekendDays(TimeFrom,TimeTo);
  end
  else begin
    ActualTimeTo := TAssetHire.CalcHireToDate(ActualTimeFrom,DurationId,DurationQty,HireLine.Connection.Connection);
    WeekendDays := TAssetHire.WeekendDays(ActualTimeFrom,ActualTimeTo);
  end;
  if WeekendDays > 0 then
    lblWeekendDays.Caption := IntToStr(WeekendDays) + ' weekend days'
  else
    lblWeekendDays.Caption := '';
end;

procedure TfmHireLineDetailEdit.cboActualTimeFromCustomDlg(Sender: TObject);
var
  dt: TDateTime;
begin
  inherited;
  if ActualTimeFrom  = 0 then
    dt := Now()
  else
    dt := ActualTimeFrom;
  if frmDateTimeSelect.SelectDateTime(dt) then begin
    ActualTimeFrom := dt;
    CalcDurationAndQtyFromDates;
    UpdateGrid;
  end;
end;

procedure TfmHireLineDetailEdit.cboActualTimeToCustomDlg(Sender: TObject);
var
  dt: TDateTime;
begin
  inherited;
  if ActualTimeTo  = 0 then
    dt := Now()
  else
    dt := ActualTimeTo;
  if frmDateTimeSelect.SelectDateTime(dt) then begin
    ActualTimeTo := dt;
    CalcDurationAndQtyFromDates;
    UpdateGrid;
  end;
end;

procedure TfmHireLineDetailEdit.cboDurationChange(Sender: TObject);
begin
  inherited;
  if not cboDuration.Focused then exit;
  CalcHireTo;
  UpdateGrid;
end;

procedure TfmHireLineDetailEdit.cboTimeFromCustomDlg(Sender: TObject);
var
  dt: TDateTime;
begin
  inherited;
  if TimeFrom  = 0 then
    dt := Now()
  else
    dt := TimeFrom;
  if frmDateTimeSelect.SelectDateTime(dt) then begin
    TimeFrom := dt;
    CalcDurationAndQtyFromDates;
    UpdateGrid;
  end;
end;

procedure TfmHireLineDetailEdit.cboTimeToCustomDlg(Sender: TObject);
var
  dt: TDateTime;
begin
  inherited;
  if TimeTo  = 0 then
    dt := Now()
  else
    dt := TimeTo;
  if frmDateTimeSelect.SelectDateTime(dt) then begin
    TimeTo := dt;
    CalcDurationAndQtyFromDates;
    UpdateGrid;
  end;
end;

procedure TfmHireLineDetailEdit.edtQtyChange(Sender: TObject);
begin
  inherited;
  if not edtQty.Focused then exit;
  CalcHireTo;
  UpdateGrid;
end;

procedure TfmHireLineDetailEdit.FormCreate(Sender: TObject);
begin
  inherited;
  grdDuration.CheckTrue := 'T';
  grdDuration.CheckFalse := 'F';
  lblWeekendDays.Caption := '';
end;

function TfmHireLineDetailEdit.GetDurationQty: double;
begin
  result := edtQty.FloatValue;
end;

function TfmHireLineDetailEdit.GetDurationRate: double;
var
  row: integer;
begin
  result := 0;
  for row := 1 to grdDuration.RowCount do begin
    if Integer(grdDuration.Objects[Col_Desc,row]) = DurationId then begin
      result := grdDuration.Floats[Col_Rate,row];
      break;
    end;
  end;
end;

function TfmHireLineDetailEdit.GetUrationId: integer;
begin
  result := 0;
  if cboDuration.ItemIndex >= 0 then
    result := Integer(cboDuration.Items.Objects[cboDuration.ItemIndex]);
end;

procedure TfmHireLineDetailEdit.grdDurationCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  if (ACol = Col_Sel) or (ACol = Col_Qty) then
    CanEdit := true
  else
    CanEdit := false;
end;

procedure TfmHireLineDetailEdit.grdDurationCheckBoxChange(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
var
  row: integer;
begin
  inherited;
  if ACol = Col_Sel then begin
    if not State then
      grdDuration.SetCheckBoxState(ACol,ARow,true)
    else begin
      { clear other check box's }
      for row := 1 to grdDuration.RowCount do begin
        if row <> ARow then
          grdDuration.SetCheckBoxState(ACol,row,false);
      end;
      { now use the selected line ... }
      self.DurationId := Integer(grdDuration.Objects[Col_Desc,ARow]);
      self.DurationQty := grdDuration.Floats[Col_Qty,ARow];
    end;
  end;
end;

procedure TfmHireLineDetailEdit.grdDurationEditingDone(Sender: TObject);
var
  row: integer;
begin
  inherited;
  //
  if DurationId <> Integer(grdDuration.Objects[Col_Desc,CurrentRow]) then
    DurationId := Integer(grdDuration.Objects[Col_Desc,CurrentRow]);
  grdDuration.SetCheckBoxState(Col_Sel,CurrentRow,true);

  { clear other check box's }
  for row := 1 to grdDuration.RowCount do begin
    if row <> CurrentRow then
      grdDuration.SetCheckBoxState(Col_Sel,row,false);
  end;
  DurationQty := grdDuration.Floats[Col_Qty,CurrentRow];
  grdDuration.Floats[Col_Price,CurrentRow] := Round(grdDuration.Floats[Col_Qty,currentRow] * grdDuration.Floats[Col_Rate,currentRow],2);
  self.CalcHireTo;
  self.UpdateGridQuantities;
end;

procedure TfmHireLineDetailEdit.grdDurationGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if (ACol = Col_Rate) or (ACol = Col_Qty) or (ACol = Col_Price) then
    HAlign := taRightJustify
  else if (ACol = Col_Sel) then
    HAlign := taCenter;
end;

procedure TfmHireLineDetailEdit.grdDurationGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
var
  currFmt: string;
begin
  inherited;
//  if (ACol = Col_Qty) then
//    Value := '#0.00'
//  else
  if (ACol = Col_Rate)or (ACol = Col_Price) then begin
    currFmt := '#' + FormatSettings.ThousandSeparator + '###' + FormatSettings.ThousandSeparator + '##0' + FormatSettings.DecimalSeparator  + '00';
    currFmt := currFmt + ';-' + currFmt;
    Value := currFmt;
  end;
end;

procedure TfmHireLineDetailEdit.grdDurationGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  if ACol = Col_Sel then
//      AEditor:= edCheckBox;
      AEditor:= edDataCheckBox
   else if (ACol = Col_Qty) then
     AEditor:= edFloat;
end;

procedure TfmHireLineDetailEdit.grdDurationRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  inherited;
  CurrentRow := NewRow;
  Allow := true;
end;

procedure TfmHireLineDetailEdit.SetActualTimeFrom(const Value: TDateTime);
begin
  fActualTimeFrom := Value;
  if Value > 0 then
    cboActualTimeFrom.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,Value) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,Value)
  else
    cboActualTimeFrom.Text := '';
end;

procedure TfmHireLineDetailEdit.SetActualTimeTo(const Value: TDateTime);
begin
  fActualTimeTo := Value;
  if Value > 0 then
    cboActualTimeTo.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,Value) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,Value)
  else
    cboActualTimeTo.Text := '';
end;

procedure TfmHireLineDetailEdit.SetDurationId(const Value: integer);
begin
  cboDuration.ItemIndex := -1;
  if cboDuration.Items.IndexOfObject(TObject(Value)) >= 0 then
    cboDuration.ItemIndex := cboDuration.Items.IndexOfObject(TObject(Value));
end;

procedure TfmHireLineDetailEdit.SetDurationQty(const Value: double);
begin
  edtQty.FloatValue := Value;
end;

procedure TfmHireLineDetailEdit.SetHireLine(const Value: THireLines);
var
  qry: TERPQuery;
  row: integer;
begin
  fHireLine := Value;
  TimeFrom := Value.HireFrom;
  TimeTo := Value.HireTo;
  ActualTimeFrom := Value.ActualHirefrom;
  ActualTimeTo := Value.ActualHireTo;
  DurationQty := Value.DurationQty;

  qry := DbSharedObj.GetQuery(Value.Connection.Connection);
  try
    qry.SQL.Add('select * from tblhirepricinglines');
    qry.SQL.Add('inner join tblassethire on tblassethire.AssetHireId = tblhirepricinglines.AssetHireId');
    qry.SQL.Add('where tblassethire.AssetId = ' + IntToStr(Value.AssetId));
    qry.SQL.Add('and tblassethire.Active = "T"');
    qry.SQL.Add('and tblhirepricinglines.Active = "T"');
    qry.SQL.Add('order by Rate ASC');
    qry.Open;
    if not qry.IsEmpty then
      grdDuration.RowCount := qry.RecordCount +1;

    while not qry.Eof do begin
      cboDuration.Items.AddObject(qry.FieldByName('DurationName').AsString, TObject(qry.FieldByName('DurationId').AsInteger));
      row := qry.RecNo;
      grdDuration.Objects[Col_Desc,row] := TObject(qry.FieldByName('DurationId').AsInteger);
      grdDuration.Cells[Col_Desc,row] := qry.FieldByName('DurationName').AsString;
      grdDuration.Floats[Col_Rate,row] := qry.FieldByName('Rate').AsFloat;
      if Value.DurationId = qry.FieldByName('DurationId').AsInteger then begin
        grdDuration.Floats[Col_Qty,row] := DurationQty;
        grdDuration.Floats[Col_Price,row] := DurationQty * qry.FieldByName('Rate').AsFloat;
        grdDuration.AddCheckBox(Col_Sel,row,true,true);
      end
      else begin
        grdDuration.Floats[Col_Qty,row] := 0;
        grdDuration.Floats[Col_Price,row] := 0;
        grdDuration.AddCheckBox(Col_Sel,row,false,true);
      end;
      qry.Next;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;

  DurationId := Value.DurationId;
  UpdateGridQuantities;
end;

procedure TfmHireLineDetailEdit.SetTimeFrom(const Value: TDateTime);
begin
  fTimeFrom := Value;
  if Value > 0 then
    cboTimeFrom.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,Value) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,Value)
  else
    cboTimeFrom.Text := '';
end;

procedure TfmHireLineDetailEdit.SetTimeTo(const Value: TDateTime);
begin
  fTimeTo := Value;
  if Value > 0 then
    cboTimeTo.Text :=
      FormatDateTime(FormatSettings.ShortDateFormat,Value) + ' ' +
      FormatDateTime(FormatSettings.ShortTimeFormat,Value)
  else
    cboTimeTo.Text := '';
end;

procedure TfmHireLineDetailEdit.UpdateGrid;
var
  row: integer;
begin
  for row := 1 to grdDuration.RowCount do begin
    if Integer(grdDuration.Objects[Col_Desc,row]) = DurationId then begin
      grdDuration.SetCheckBoxState(Col_Sel,row,true);
      grdDuration.Floats[Col_Qty,row] := DurationQty;
      grdDuration.Floats[Col_Price,row] := Round(grdDuration.Floats[Col_Qty,row] * grdDuration.Floats[Col_Rate,row],2);
    end
    else begin
      grdDuration.SetCheckBoxState(Col_Sel,row,false);
    end;
  end;
  UpdateGridQuantities;
end;

procedure TfmHireLineDetailEdit.UpdateGridQuantities;
var
  qry: TERPQuery;
  hours: double;
  row: integer;
begin
  qry := DbSharedObj.GetQuery(HireLine.Connection.Connection);
  try
    qry.SQL.Add('set @DaysPerWeekend = (select FieldValue from tbldbpreferences where Name = "NoOfWeekendDays");');
    qry.SQL.Add('set @DaysPerWeek = 7 - @DaysPerWeekend;');
    qry.SQL.Add('set @HousPerDay = Round(((select FieldValue from tbldbpreferences where Name = "EndOfDay") - (select FieldValue from tbldbpreferences where Name = "StartOfDay")) * 24,2);');
    qry.SQL.Add('set @WeeksPerYear = Round(365 / 7,2);');
    qry.SQL.Add('set @WeeksPerMonth = Round(@WeeksPerYear / 12,2);');
    qry.SQL.Add('select tblhirepricinglines.DurationId,');
    qry.SQL.Add('case tblduration.DurationType');
    qry.SQL.Add('  when "H" then tblduration.Qty');
    qry.SQL.Add('  when "D" then tblduration.Qty * @HousPerDay');
    qry.SQL.Add('  when "W" then tblduration.Qty * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  when "M" then tblduration.Qty * @WeeksPerMonth * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  when "Y" then tblduration.Qty * @WeeksPerYear * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  else 0');
    qry.SQL.Add('end as ActualHours');
    qry.SQL.Add('from tblhirepricinglines');
    qry.SQL.Add('inner join tblassethire on tblassethire.AssetHireId = tblhirepricinglines.AssetHireId');
    qry.SQL.Add('inner join tblduration on tblduration.DurationId = tblhirepricinglines.DurationId');
    qry.SQL.Add('where tblassethire.AssetId = ' + IntToStr(HireLine.AssetId));
    qry.SQL.Add('and tblassethire.Active = "T"');
    qry.SQL.Add('and tblhirepricinglines.Active = "T"');
    qry.SQL.Add('and tblduration.Active = "T"');
//    qry.SQL.Add('order by Rate ASC');
    qry.Open;

    { use hours as base .. }
    // hours := 0;
    if qry.Locate('DurationId',DurationId,[]) then begin
      hours := qry.FieldByName('ActualHours').AsFloat * DurationQty;
      for row := 1 to grdDuration.RowCount do begin
        if Integer(grdDuration.Objects[Col_Desc,row]) <> DurationId then begin
          if qry.Locate('DurationId',Integer(grdDuration.Objects[Col_Desc,row]),[]) then begin
            grdDuration.Floats[Col_Qty,row] := Round(DivZer(hours,qry.FieldByName('ActualHours').AsFloat),2);
            grdDuration.Floats[Col_Price,row] := Round(grdDuration.Floats[Col_Qty,row] * grdDuration.Floats[Col_Rate,row],2);

          end;
        end;



      end;

    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

end.
