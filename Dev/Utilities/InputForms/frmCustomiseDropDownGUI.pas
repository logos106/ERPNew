unit frmCustomiseDropDownGUI;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 11/07/05  1.00.01 DSP  Added matrix sort priority radio buttons for x and
                        and y axis.

}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Buttons, DNMSpeedButton, Mask, DBCtrls, ExtCtrls,
  DNMPanel, SelectionDialog, AppEvnts, DB,  Grids, Wwdbigrd, Wwdbgrid,
  wwcheckbox, wwdblook, DBAccess, MyAccess, DataState, Menus, AdvMenus, MemDS, Shader;

type
  TCustomiseDropDownGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Label2: TLabel;
    edtTitle: TDBEdit;
    cmdCancel: TDNMSpeedButton;
    cmdOK: TDNMSpeedButton;
    Label1: TLabel;
    dbgComboName: TwwDBGrid;
    grdListValues: TwwDBGrid;
    tblMaster: TMyQuery;
    DSMaster: TDataSource;
    tblDetails: TMyQuery;
    DSDetails: TDataSource;
    tblMasterDescriptionAttribID: TAutoIncField;
    tblMasterComboName: TStringField;
    tblMasterActive: TStringField;
    tblMasterEditedFlag: TStringField;
    tblMasterGlobalRef: TStringField;
    tblDetailsDescriptionAttribLineID: TAutoIncField;
    tblDetailsDescriptionAttribID: TIntegerField;
    tblDetailsEditedFlag: TStringField;
    tblDetailsGlobalRef: TStringField;
    tblDetailsDescriptionAttribValue: TStringField;
    btnDelete: TwwIButton;
    qryDescAttribs: TMyQuery;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    cboX: TwwDBLookupCombo;
    cboY: TwwDBLookupCombo;
    Label139: TLabel;
    chkUseOrderingMatrix: TwwCheckBox;
    Label5: TLabel;
    AlphaOrderX: TwwCheckBox;
    Label6: TLabel;
    AlphaOrderY: TwwCheckBox;
    Label7: TLabel;
    DBCheckBox1: TwwCheckBox;
    qryDescAttribY: TMyQuery;
    qryDescAttribX: TMyQuery;
    rbtnXAxis: TRadioButton;
    rbtnYAxis: TRadioButton;
    Label8: TLabel;
    Label9: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grdListValuesExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tblDetailsBeforePost(DataSet: TDataSet);
    procedure tblMasterAfterScroll(DataSet: TDataSet);
    procedure cmdOKClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure cboXCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboYCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboYNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboXNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure chkUseOrderingMatrixClick(Sender: TObject);
    procedure cboXChange(Sender: TObject);
    procedure cboYChange(Sender: TObject);
    procedure AlphaOrderXClick(Sender: TObject);
    procedure AlphaOrderYClick(Sender: TObject);

  private
    { Private declarations }
    fbFormStartingUp: boolean;
    procedure RefreshDetailsGrid;
    function AllowOrderingMatrix: boolean;
  public
    { Public declarations }
  end;

implementation

uses
  Dnmlib,  AppEnvironment, CommonLib;

{$R *.dfm}

{ TCustomiseDropDownGUI }

procedure TCustomiseDropDownGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TCustomiseDropDownGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TCustomiseDropDownGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryDescAttribX.ParamByName('xID').AsInteger := 0;

  qryDescAttribY.ParamByName('xID').AsInteger := 0;

  OpenQueries;
  RefreshDetailsGrid;

  if AppEnv.CompanyPrefs.MatrixSortPriority = 'X' then
    rbtnXAxis.Checked := true
  else
    rbtnYAxis.Checked := true;

  chkUseOrderingMatrix.Checked := AppEnv.CompanyPrefs.UseOrderingMatrix;
  cboX.Text := AppEnv.CompanyPrefs.XaxisComboName;
  qryDescAttribX.Locate('ComboName', cboX.Text, [loCaseInsensitive]);
  cboY.Text := AppEnv.CompanyPrefs.YaxisComboName;
  qryDescAttribY.Locate('ComboName', cboY.Text, [loCaseInsensitive]);
  AlphaOrderX.Checked := AppEnv.CompanyPrefs.OrderingMartixAplhaOrderX;
  AlphaOrderY.Checked := AppEnv.CompanyPrefs.OrderingMartixAplhaOrderY;

  fbFormStartingUp := false;
end;

procedure TCustomiseDropDownGUI.RefreshDetailsGrid;
begin
  tblDetails.Close;
  tblDetails.ParamByName('ID').AsInteger := tblMasterDescriptionAttribID.AsInteger;
  tblDetails.Open;
end;

procedure TCustomiseDropDownGUI.grdListValuesExit(Sender: TObject);
begin
  inherited;
  tblDetails.Edit;
  tblDetails.Post;
  tblDetails.Edit;
  tblMaster.Edit;
  tblMaster.Post;
  tblMaster.Edit;
end;

procedure TCustomiseDropDownGUI.FormCreate(Sender: TObject);
begin
  fbFormStartingUp := true;
  fbIgnoreAccessLevels := true;
  inherited;
  tblMaster.Connection := MyConnection;
  tblDetails.Connection := MyConnection;
  qryDescAttribX.Connection := MyConnection;
  qryDescAttribY.Connection := MyConnection;

  MyConnection.Connected := true;

  if not MyConnection.intransaction then begin
    BeginTransaction;
  end;
end;

procedure TCustomiseDropDownGUI.tblDetailsBeforePost(DataSet: TDataSet);
begin
  inherited;
  tblDetails.Edit;
  tblDetailsDescriptionAttribID.AsInteger := tblMasterDescriptionAttribID.AsInteger;
end;

procedure TCustomiseDropDownGUI.tblMasterAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshDetailsGrid;
end;

procedure TCustomiseDropDownGUI.cmdOKClick(Sender: TObject);
begin
  inherited;
  try
    if (MyConnection.intransaction) then begin
      tblDetails.Edit;
      tblDetails.Post;
      tblMaster.Edit;
      tblMaster.Post;

      if rbtnXAxis.Checked then
        AppEnv.CompanyPrefs.MatrixSortPriority := 'X'
      else
        AppEnv.CompanyPrefs.MatrixSortPriority := 'Y';

      if not AllowOrderingMatrix then begin
        AppEnv.CompanyPrefs.UseOrderingMatrix := False;
        AppEnv.CompanyPrefs.XaxisComboName := '';
        AppEnv.CompanyPrefs.YaxisComboName := '';

        CommonLib.MessageDlgXP_Vista('One of the axis is not active or does not exist !' + #13 + #10 + '' + #13 +
          #10 + 'The use of ordering matrix has been disabled.', mtWarning, [mbOK], 0);
      end;
      CommitTransaction;
      AppEnv.CompanyPrefs.PopulateMe(nil);
    end;
  except
    RollbackTransaction;
  end;

  Self.Close;
end;

procedure TCustomiseDropDownGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(grdListValues.DataSource.DataSet);
end;

procedure TCustomiseDropDownGUI.DBCheckBox1Click(Sender: TObject);
var
  iID: integer;
begin
  if fbFormStartingUp then Exit;
  inherited;
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
  TwwCheckBox(Sender).DataSource.DataSet.Edit;
  if TwwCheckBox(Sender).Checked then begin
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'T';
    tblMaster.Post;
    tblMaster.Edit;
  end else begin
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
    tblMaster.Post;
    tblMaster.Edit;
    // Now check to see if our axis selections are invalid.  Lets start with X
    if cboX.Text <> '' then begin
      if tblMaster.FieldByName('ComboName').AsString = cboX.Text then begin
        cboX.Text := '';
        AppEnv.CompanyPrefs.XaxisComboName := '';
      end;
    end;

    if cboY.Text <> '' then begin
      if tblMaster.FieldByName('ComboName').AsString = cboY.Text then begin
        cboY.Text := '';
        AppEnv.CompanyPrefs.YaxisComboName := '';
      end;
    end;
  end;

  qryDescAttribs.Close;
  qryDescAttribs.Open;

  iID := 0;
  if (AppEnv.CompanyPrefs.YaxisComboName <> '') then begin
    iID := qryDescAttribY.FieldByName('DescriptionAttribID').AsInteger;
  end;

  qryDescAttribX.Close;
  qryDescAttribX.ParamCheck := true;
  qryDescAttribX.ParamByName('xID').AsInteger := iID;
  qryDescAttribX.Open;

  iID := 0;
  if (AppEnv.CompanyPrefs.XaxisComboName <> '') then begin
    iID := qryDescAttribY.FieldByName('DescriptionAttribID').AsInteger;
  end;

  qryDescAttribY.Close;
  qryDescAttribY.ParamCheck := true;
  qryDescAttribY.ParamByName('xID').AsInteger := iID;
  qryDescAttribY.Open;
end;

function TCustomiseDropDownGUI.AllowOrderingMatrix: boolean;
begin
  Result := true;
  if AppEnv.CompanyPrefs.UseOrderingMatrix then begin
    if tblMaster.Locate('ComboName', AppEnv.CompanyPrefs.XaxisComboName, []) then begin
      if not tblMasterActive.AsBoolean then Result := false;
    end
    else
      Result := false;

    if Result and tblMaster.Locate('ComboName', AppEnv.CompanyPrefs.YaxisComboName, []) then begin
      if not tblMasterActive.AsBoolean then Result := false;
    end
    else
      Result := false;
  end;
end;

procedure TCustomiseDropDownGUI.cboXCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  iID: integer;
begin
  if not Modified then Exit;
  inherited;
  iID := 0;
  if cboX.Text = '' then Exit;
  if (qryDescAttribY.Active) then begin
    iID := qryDescAttribY.FieldByName('DescriptionAttribID').AsInteger;
  end;

  qryDescAttribY.Close;
  qryDescAttribY.ParamCheck := true;
  qryDescAttribY.ParamByName('xID').AsInteger := LookupTable.FieldByName('DescriptionAttribID').AsInteger;
  qryDescAttribY.Open;

  if iID <> LookupTable.FieldByName('DescriptionAttribID').AsInteger then begin
    If qryDescAttribY.Locate('DescriptionAttribID', iID, [loCaseInsensitive]) then
      cboY.Text :=  qryDescAttribY.fieldbyName('ComboName').asString;
  end else begin
    qryDescAttribY.First;
  end;
end;

procedure TCustomiseDropDownGUI.cboYCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  iID: integer;
begin
  if not Modified then Exit;
  inherited;
  iID := 0;
  if cboY.Text = '' then Exit;
  if (qryDescAttribX.Active) then begin
    iID := qryDescAttribX.FieldByName('DescriptionAttribID').AsInteger;
  end;
  
  qryDescAttribX.Close;
  qryDescAttribX.ParamCheck := true;
  qryDescAttribX.ParamByName('xID').AsInteger := LookupTable.FieldByName('DescriptionAttribID').AsInteger;
  qryDescAttribX.Open;

  if iID <> LookupTable.FieldByName('DescriptionAttribID').AsInteger then begin
    If qryDescAttribX.Locate('DescriptionAttribID', iID, [loCaseInsensitive]) then
      cboX.Text :=  qryDescAttribX.fieldbyName('ComboName').asString;

  end else begin
    qryDescAttribX.First;
  end;
end;

procedure TCustomiseDropDownGUI.cboYNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: boolean);
begin
  Accept := false;
end;

procedure TCustomiseDropDownGUI.cboXNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: boolean);
begin
  Accept := false;
end;

procedure TCustomiseDropDownGUI.chkUseOrderingMatrixClick(Sender: TObject);
begin
  inherited;
  AppEnv.CompanyPrefs.UseOrderingMatrix := chkUseOrderingMatrix.Checked;
end;

procedure TCustomiseDropDownGUI.cboXChange(Sender: TObject);
begin
  inherited;
  AppEnv.CompanyPrefs.XaxisComboName := cboX.Text;
end;

procedure TCustomiseDropDownGUI.cboYChange(Sender: TObject);
begin
  inherited;
  AppEnv.CompanyPrefs.YaxisComboName := cboY.Text;
end;

procedure TCustomiseDropDownGUI.AlphaOrderXClick(Sender: TObject);
begin
  inherited;
  AppEnv.CompanyPrefs.OrderingMartixAplhaOrderX  := AlphaOrderX.Checked;
end;

procedure TCustomiseDropDownGUI.AlphaOrderYClick(Sender: TObject);
begin
  inherited;
  AppEnv.CompanyPrefs.OrderingMartixAplhaOrderY := AlphaOrderY.Checked;
end;

initialization
  RegisterClassOnce(TCustomiseDropDownGUI);


end.
