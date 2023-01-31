unit ChartViewSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DNMPanel, DB, wwcheckbox, Mask, wwdbedit,
  wwdblook, MemDS, DBAccess, MyAccess,ERPdbComponents, DNMSpeedButton, Wwdotdot,
  Wwdbcomb, frmBase;

type
  TChartSetup = class(TfrmBaseGUI)
    SubForm: TDNMPanel;
    DSCustomCharts: TDataSource;
    Bevel1: TBevel;
    txtChartName: TwwDBEdit;
    Label3: TLabel;
    chkDefault: TwwCheckBox;
    Label11: TLabel;
    chkGlobal: TwwCheckBox;
    Label1: TLabel;
    cboCustomReports: TwwDBLookupCombo;
    lblcustomReport: TLabel;
    qryCustomReports: TERPQuery;
    qryCustomReportsFilterName: TWideStringField;
    qryCustomReportsID: TIntegerField;
    qryCustomReportsFilterStatement: TWideMemoField;
    qryCustomReportsDefaultFilter: TWideStringField;
    btnApply: TDNMSpeedButton;
    pnlSeries: TDNMPanel;
    Bevel2: TBevel;
    lblX_LabelsField: TLabel;
    lblX_ChartedField: TLabel;
    lblY_ChartedField: TLabel;
    cboX_LabelsField: TwwDBComboBox;
    cboX_ChartedField: TwwDBComboBox;
    cboY_ChartedField: TwwDBComboBox;
    lblSeries: TLabel;
    cboZ_ChartedField: TwwDBComboBox;
    lblZ_ChartedField: TLabel;
    btnDelete: TDNMSpeedButton;
    SeriesName: TwwDBComboBox;
    LabelSeriesClass: TLabel;
    ImageSeries: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure SeriesNameChange(Sender: TObject);
    procedure cboCustomReportsCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    { Private declarations }
    FChartDataset: TDataset;
    FsX_LabelsField: String;
    FsX_ChartedField: String;
    FsY_ChartedField: String;
    Function SetDataFieldstoChart:boolean;
    Procedure SetDropdownFields;
  public
    { Public declarations }
    property ChartDataset : TDataset read FChartDataset write FChartDataset;
    property X_LabelsField : String read FsX_LabelsField write FsX_LabelsField;
    property X_ChartedField : String read FsX_ChartedField write FsX_ChartedField;
    property Y_ChartedField : String read FsY_ChartedField write FsY_ChartedField;
    Procedure DoCustomFilter;
    Procedure LoadSeriesNameList;
    Procedure EnableSeriesDataChange;
  end;

implementation

uses
  CommonLib, ListChartView, CommonDbLib, TeEngine, DBChart, TeeSurfa, Series,
  FastFuncs, Vista_MessageDlg, AppEnvironment, BaseListingForm, TeeProcs, Chart,
  MessageConst;

{$R *.dfm}



procedure TChartSetup.FormShow(Sender: TObject);
begin
  inherited;
  SubForm.Color := TListChartView(Self.Owner).TabColor;
  pnlSeries.Color := SubForm.Color;
  qryCustomReports.Connection := CommonDbLib.GetSharedMyDacConnection;

  if qryCustomReports.Active then qryCustomReports.close;
  qryCustomReports.Params.Parambyname('ReportName').asString := TListChartView(Self.Owner).FromFormClassName;
  qryCustomReports.Params.Parambyname('USERID').asInteger := AppEnv.employee.EmployeeId;

  qryCustomReports.Open;
  SetDropdownFields;
  DoCustomFilter;
end;

procedure TChartSetup.btnApplyClick(Sender: TObject);
begin
  if Trim(txtChartName.Text) = '' then Begin
    Vista_MessageDlg.MessageDlgXP_Vista('No Chart Name !', mtInformation, [mbOK], 0);
    SetControlFocus(txtChartName);
    Exit;
  end;

  if not (DSCustomCharts.DataSet.State in [dsInsert, dsEdit]) then
    DSCustomCharts.DataSet.Edit;

  DSCustomCharts.DataSet.FieldByName('ReportClassName').AsString := TListChartView(Self.Owner).FromFormClassName;

  If chkGlobal.Checked then Begin
    DSCustomCharts.DataSet.FieldByName('Global').AsString := 'T';
    DSCustomCharts.DataSet.FieldByName('EmployeeID').AsInteger := 0;
  end else begin
    DSCustomCharts.DataSet.FieldByName('Global').AsString := 'F';
    DSCustomCharts.DataSet.FieldByName('EmployeeID').AsInteger := Appenv.Employee.EmployeeID;
  end;

  DSCustomCharts.DataSet.Post;
  DSCustomCharts.DataSet.Edit;
  
  If not SetDataFieldstoChart then Exit;

  TListChartView(Self.Owner).AddTemplateButtons;    

  DoCustomFilter;

  TListChartView(Self.Owner).ChartViewTabs.ActivePage := TListChartView(Self.Owner).tabDesigner;
  TListChartView(Self.Owner).pnlActiveForm.Caption := 'Designer';

  If TListChartView(Self.Owner).ChartDesigner.ChartListBox1.Count =0 then
    TListChartView(Self.Owner).ChartDesigner.SBAdd.Click;

end;

Procedure TChartSetup.SetDropdownFields;
  Procedure FillFields;

    Procedure AddField(Const tmpSt:String; tmpType:TFieldType);
    begin
      Case TeeFieldType(tmpType) of
      tftNumber,
     tftDateTime: begin
                    cboX_LabelsField.Items.Add(tmpSt);
                    cboY_ChartedField.Items.Add(tmpSt);
                  end;
         tftText: cboX_LabelsField.Items.Add(tmpSt);
      end;
    end;

  Var
    t : Integer;
    sl: TStringList;
  Begin
    With ChartDataset do
    if FieldCount>0 then
       for t:=0 to FieldCount-1 do
           AddField(Fields[t].FieldName,Fields[t].DataType)
    else
    begin
      FieldDefs.Update;
      for t:=0 to FieldDefs.Count-1 do
          AddField(FieldDefs[t].Name,FieldDefs[t].DataType);
    end;
    { use string list to sort combo items }
    sl:= TStringList.Create;
    try
      sl.Sorted:= true;
      sl.Assign(cboX_LabelsField.Items);
      cboX_LabelsField.Items.Assign(sl);
      sl.Assign(cboY_ChartedField.Items);
      cboY_ChartedField.Items.Assign(sl);
    finally
      sl.Free;
    end;
  end;

var
  tmp: TChartSeries;
begin
    cboX_LabelsField.Clear;
    FillFields;
    cboX_ChartedField.Items.Text := cboY_ChartedField.Items.Text;
    cboZ_ChartedField.Items.Text := cboY_ChartedField.Items.Text;

    tmp := TListChartView(Self.Owner).ChartDesigner.ChartListBox1.SelectedSeries;
    If Assigned(tmp) then Begin
      With cboX_LabelsField do ItemIndex := Items.IndexOf(tmp.XLabelsSource);
      If not (tmp is TCircledSeries) then
        With cboX_ChartedField do ItemIndex := Items.IndexOf(tmp.XValues.ValueSource);
      With cboY_ChartedField do ItemIndex := Items.IndexOf(tmp.YValues.ValueSource);
      If tmp is TCustom3DSeries then
        With cboZ_ChartedField do ItemIndex := Items.IndexOf(TCustom3DSeries(tmp).ZValues.ValueSource);
    end;
    cboX_LabelsField.ApplyList;
end;

procedure TChartSetup.EnableSeriesDataChange;
var
  tmpChartSeries: TChartSeries;
  tmpBitmap: TBitmap;
  tmpString : String;
  Index :Integer;
begin

  tmpChartSeries := TListChartView(Self.Owner).ChartDesigner.ChartListBox1.SelectedSeries;
  If Assigned(tmpChartSeries) then Begin
    pnlSeries.Enabled := True;

    lblSeries.Enabled := True;
    SeriesName.Enabled := True;
    LoadSeriesNameList;

    tmpString := GetGallerySeriesName(tmpChartSeries);
    Index := FastFuncs.PosEx('&', tmpString);
    if Index > 0 then
       Insert('&', tmpString, Index + 1);
    LabelSeriesClass.Caption:=tmpString+': '+SeriesTitleOrName(tmpChartSeries);

    tmpBitmap:=TBitmap.Create;
    try
      TeeGetBitmapEditor(tmpChartSeries,tmpBitmap);
      ImageSeries.Picture.Assign(tmpBitmap);
    finally
      tmpBitmap.Free;
    end;

    lblX_LabelsField.Enabled := Not (tmpChartSeries is TCustom3DSeries);
    cboX_LabelsField.Enabled := Not (tmpChartSeries is TCustom3DSeries);

    lblX_ChartedField.Enabled := not (tmpChartSeries is TCircledSeries);
    cboX_ChartedField.Enabled := not (tmpChartSeries is TCircledSeries);

    lblY_ChartedField.Enabled := True;
    cboY_ChartedField.Enabled := True;

    lblZ_ChartedField.Enabled := (tmpChartSeries is TCustom3DSeries);
    cboZ_ChartedField.Enabled := (tmpChartSeries is TCustom3DSeries);

    With cboX_LabelsField do ItemIndex := Items.IndexOf(tmpChartSeries.XLabelsSource);
    If not (tmpChartSeries is TCircledSeries) then
      With cboX_ChartedField do ItemIndex := Items.IndexOf(tmpChartSeries.XValues.ValueSource);
    With cboY_ChartedField do ItemIndex := Items.IndexOf(tmpChartSeries.YValues.ValueSource);
    If (tmpChartSeries is TCustom3DSeries) then
      With cboZ_ChartedField do ItemIndex := Items.IndexOf(TCustom3DSeries(tmpChartSeries).ZValues.ValueSource);


    If (tmpChartSeries is TCircledSeries) then begin
      lblX_LabelsField.Caption := 'Labels';
      lblX_ChartedField.Caption := 'n/a';
      lblY_ChartedField.Caption := 'Pie ( Y: Axis )';
      lblZ_ChartedField.Caption := 'n/a';
    end else If (tmpChartSeries is TCustom3DSeries) then Begin
      lblX_LabelsField.Caption := 'n/a';
      lblX_ChartedField.Caption := 'X: Axis';
      lblY_ChartedField.Caption := 'Y: Axis';
      lblZ_ChartedField.Caption := 'Z: Axis';
    end else Begin
      lblX_LabelsField.Caption := 'Labels ( X: Axis )';
      lblX_ChartedField.Caption := 'X: Axis (Optional)';
      lblY_ChartedField.Caption := 'Bar ( Y: Axis )';
      lblZ_ChartedField.Caption := 'n/a';
    end;
    
  end else begin
    pnlSeries.Enabled := False;
    lblSeries.Enabled := False;
    SeriesName.Enabled := False;
    lblX_LabelsField.Enabled := False;
    cboX_LabelsField.Enabled := False;
    lblX_ChartedField.Enabled := False;
    cboX_ChartedField.Enabled := False;
    lblY_ChartedField.Enabled := False;
    cboY_ChartedField.Enabled := False;
    lblZ_ChartedField.Enabled := False;
    cboZ_ChartedField.Enabled := False;
  end;
end;

Function TChartSetup.SetDataFieldstoChart:boolean;
var
  tmp: TChartSeries;
begin
  Result := False;
  tmp := TListChartView(Self.Owner).ChartDesigner.ChartListBox1.SelectedSeries;

  If Assigned(tmp) then Begin
    tmp.XLabelsSource := DSCustomCharts.DataSet.FieldByName('X_LabelsField').asString;
    if Trim(tmp.XLabelsSource) = '' then Begin
      Vista_MessageDlg.MessageDlgXP_Vista('No "Labels (X: Axis)" Field !', mtInformation, [mbOK], 0);
      SetControlFocus(cboX_LabelsField);
      Exit;
    end;

    If not (tmp is TCircledSeries) then begin
      tmp.XValues.ValueSource := DSCustomCharts.DataSet.FieldByName('X_ChartedField').asString;
      { if the chart does not have an x value source it will automatically create a series ie 0,1,2,3 ect }
//      if Trim(tmp.XValues.ValueSource) = '' then Begin
//        Vista_MessageDlg.MessageDlgXP_Vista('No "X: Axis" Field !', mtInformation, [mbOK], 0);
//        SetControlFocus(cboX_ChartedField);
//        Exit;
//      end;
      if Trim(tmp.XValues.ValueSource) <> '' then
        tmp.XValues.DateTime := (ChartDataset.FieldByName(tmp.XValues.ValueSource).DataType = ftDate) OR
                              (ChartDataset.FieldByName(tmp.XValues.ValueSource).DataType = ftDateTime)
      else
        tmp.XValues.DateTime := false;
    end;

    tmp.YValues.ValueSource := DSCustomCharts.DataSet.FieldByName('Y_ChartedField').asString;
    if Trim(tmp.YValues.ValueSource) = '' then Begin
      Vista_MessageDlg.MessageDlgXP_Vista('No "Y: Axis" Field !', mtInformation, [mbOK], 0);
      SetControlFocus(cboY_ChartedField);
      Exit;
    end;
    tmp.YValues.DateTime := (ChartDataset.FieldByName(tmp.YValues.ValueSource).DataType = ftDate) OR
                            (ChartDataset.FieldByName(tmp.YValues.ValueSource).DataType = ftDateTime);
    If tmp is TCustom3DSeries then begin
      TCustom3DSeries(tmp).ZValues.ValueSource := DSCustomCharts.DataSet.FieldByName('Z_ChartedField').asString;
      if Trim(TCustom3DSeries(tmp).ZValues.ValueSource) = '' then Begin
        Vista_MessageDlg.MessageDlgXP_Vista('No "Z: Axis" Field !', mtInformation, [mbOK], 0);
        SetControlFocus(cboZ_ChartedField);
        Exit;
      end;

      TCustom3DSeries(tmp).ZValues.DateTime := (ChartDataset.FieldByName(TCustom3DSeries(tmp).ZValues.ValueSource).DataType = ftDate) OR
                              (ChartDataset.FieldByName(TCustom3DSeries(tmp).ZValues.ValueSource).DataType = ftDateTime);
    end;
    tmp.CheckDataSource;
    Result := True;
  end else
    Result := True;
end;

procedure TChartSetup.btnDeleteClick(Sender: TObject);
begin
  if (Vista_MessageDlg.MessageDlgXP_Vista('Are You Sure You Wish to Delete This Chart ?',
          mtConfirmation, [mbYes, mbNo], 0) = mrYes) then Begin
    try
      DSCustomCharts.DataSet.Delete;
      TListChartView(Self.Owner).ChartDeleted := True;
    except
      {Do nothing - raise a silent exception}
    end;
    TListChartView(Self.Owner).AddTemplateButtons;
    TListChartView(Self.Owner).NewChart;
  end;
end;

procedure TChartSetup.LoadSeriesNameList;
begin
  SeriesName.Items.Clear;
  SeriesName.Items.AddStrings(TListChartView(Self.Owner).ChartDesigner.ChartListBox1.Items);
  SeriesName.ItemIndex := TListChartView(Self.Owner).ChartDesigner.ChartListBox1.ItemIndex;
end;

procedure TChartSetup.SeriesNameChange(Sender: TObject);
Var
  ChartID:Integer;
begin
  ChartID := SeriesName.Items.IndexOf(SeriesName.Text);
  If ChartID<> -1  then Begin
    TListChartView(Self.Owner).ChartDesigner.ChartListBox1.ItemIndex := ChartID;
    TListChartView(Self.Owner).ChartDesigner.ChartListBox1Click(TListChartView(Self.Owner).ChartDesigner);
    EnableSeriesDataChange;
  end;
end;

procedure TChartSetup.DoCustomFilter;
begin
try
  if not(Assigned(TListChartView(Self.Owner).Grid)) then exit;
  If DSCustomCharts.DataSet.FieldByName('CustomFilterID').AsInteger <> 0 then Begin
    If not Sysutils.SameText(TBaseListingGUI(TListChartView(Self.Owner).Grid.Owner).cboCustomReports.Text,Self.cboCustomReports.Text) Then Begin
      TBaseListingGUI(TListChartView(Self.Owner).Grid.Owner).cboCustomReports.Text := Self.cboCustomReports.Text;
    end;
    TBaseListingGUI(TListChartView(Self.Owner).Grid.Owner).qryCustomReportsID := Self.qryCustomReportsID;
    TBaseListingGUI(TListChartView(Self.Owner).Grid.Owner).cboCustomReportsCloseUp(
        TBaseListingGUI(TListChartView(Self.Owner).Grid.Owner).cboCustomReports ,
        TBaseListingGUI(TListChartView(Self.Owner).Grid.Owner).qryCustomReports ,
        nil, true);

    if Assigned(TListChartView(Self.Owner).ChartDesigner.ChartListBox1.SelectedSeries) then
      TListChartView(Self.Owner).ChartDesigner.ChartListBox1.SelectedSeries.CheckDataSource;
  end;
Except
  // kill the exception if the custom filter is removed or any exceptionre with the custom filter
end;
end;

procedure TChartSetup.cboCustomReportsCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if Modified = false then Exit;
  inherited;
  DoCustomFilter;
end;

initialization
  RegisterClassOnce(TChartSetup);
end.

