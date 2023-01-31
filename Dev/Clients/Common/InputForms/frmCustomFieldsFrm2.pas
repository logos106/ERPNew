unit frmCustomFieldsFrm2;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 15/09/05  1.00.01 DSP  Added SaveTransactions to resolve lockup issue when
                        switching between forms. The transactions were not
                        being committed when switching forms.

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls,   Buttons, DNMSpeedButton,
  BaseInputForm, kbmMemTable, SelectionDialog, AppEvnts, Grids, Wwdbigrd,
  Wwdbgrid, DNMPanel, DBAccess, MyAccess, wwcheckbox, MemDS, DataState,
  Menus, AdvMenus, Shader;

type
  TfrmCustomFields2 = class(TBaseInputGUI)
    frmCustomFieldsSrc: TDataSource;
    frmCustomFieldsTbl: TMyTable;
    tblMergeFields: TMyTable;
    DataSource1: TDataSource;
    memFrmCustomFieldsTbl: TkbmMemTable;
    DNMPanel1: TDNMPanel;
    lblDropDownName: TLabel;
    Label3: TLabel;
    grdDropDownText: TwwDBGrid;
    dsDropDowns: TDataSource;
    qryDropDowns: TMyQuery;
    qryDropDownsDropDownID: TAutoIncField;
    qryDropDownsFieldNumber: TWordField;
    qryDropDownsText: TStringField;
    chkIsCombo: TCheckBox;
    DNMPanel2: TDNMPanel;
    Label0: TLabel;
    Label2: TLabel;
    Label17: TLabel;
    Label4: TLabel;
    CFLabel2: TDBEdit;
    CFLabel3: TDBEdit;
    CFLabel4: TDBEdit;
    CFLabel5: TDBEdit;
    CFLabel6: TDBEdit;
    CFLabel7: TDBEdit;
    CFLabel8: TDBEdit;
    CFLabel9: TDBEdit;
    CFLabel10: TDBEdit;
    CFLabel11: TDBEdit;
    CFLabel12: TDBEdit;
    CFLabel13: TDBEdit;
    CFLabel14: TDBEdit;
    CFLabel15: TDBEdit;
    CFLabel16: TDBEdit;
    CFLabel17: TDBEdit;
    CFLabel18: TDBEdit;
    CFLabel1: TDBEdit;
    CFLabel19: TDBEdit;
    CFLabel20: TDBEdit;
    chkIsRequired1: TwwCheckBox;
    chkIsRequired2: TwwCheckBox;
    chkIsRequired3: TwwCheckBox;
    chkIsRequired4: TwwCheckBox;
    chkIsRequired5: TwwCheckBox;
    chkIsRequired6: TwwCheckBox;
    chkIsRequired7: TwwCheckBox;
    chkIsRequired8: TwwCheckBox;
    chkIsRequired9: TwwCheckBox;
    chkIsRequired10: TwwCheckBox;
    chkIsRequired11: TwwCheckBox;
    chkIsRequired12: TwwCheckBox;
    chkIsRequired13: TwwCheckBox;
    chkIsRequired14: TwwCheckBox;
    chkIsRequired15: TwwCheckBox;
    CFHire1: TwwCheckBox;
    CFHire2: TwwCheckBox;
    CFHire3: TwwCheckBox;
    CFHire4: TwwCheckBox;
    CFHire5: TwwCheckBox;
    CFHire6: TwwCheckBox;
    CFHire7: TwwCheckBox;
    CFHire8: TwwCheckBox;
    CFHire9: TwwCheckBox;
    CFHire10: TwwCheckBox;
    CFHire11: TwwCheckBox;
    CFHire12: TwwCheckBox;
    CFHire13: TwwCheckBox;
    CFHire14: TwwCheckBox;
    CFHire15: TwwCheckBox;
    CFHire16: TwwCheckBox;
    CFHire17: TwwCheckBox;
    CFHire18: TwwCheckBox;
    CFHire19: TwwCheckBox;
    CFHire20: TwwCheckBox;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    btnSet1: TDNMSpeedButton;
    Bevel2: TBevel;
    Label1: TLabel;
    chkIsRequired18: TDBCheckBox;
    chkIsRequired17: TDBCheckBox;
    ChkIsRequired16: TDBCheckBox;
    Label5: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure Form_Close;
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmCustomFieldsTblAfterOpen(DataSet: TDataSet);
    procedure CFLabelEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryDropDownsNewRecord(DataSet: TDataSet);
    procedure grdDropDownTextExit(Sender: TObject);
    procedure chkIsComboClick(Sender: TObject);
    procedure CFLabel16Enter(Sender: TObject);
    procedure btnSet1Click(Sender: TObject);

  private
    { Private declarations }
    iFieldNumber: integer;
    sLabelFieldName: string;
    sIsComboFieldName: string;
    bIsFirstTime: boolean;
    procedure RefreshDropDown(edtCustom: TDBEdit);
    procedure UpDateIsCombo;
  protected
    procedure SaveTransactions;
  public
    { Public declarations }
    class procedure CloseMe; override;
    
  end;

//var
//  frmCustomFields2: TfrmCustomFields2;

implementation

uses
  DNMExceptions, DNMLib, StrUtils, {HireCustomFields, }
  frmCustomFieldsFrm, CommonLib, FastFuncs;

{$R *.DFM}

procedure TfrmCustomFields2.Form_Close;
begin
  tblMergeFields.Active := true;
  with tblMergeFields do begin
    First;
    Edit;
    FieldByName('CUSTFLD1').AsString  := CFLabel1.Text;
    FieldByName('CUSTFLD2').AsString  := CFLabel2.Text;
    FieldByName('CUSTFLD3').AsString  := CFLabel3.Text;
    FieldByName('CUSTFLD4').AsString  := CFLabel4.Text;
    FieldByName('CUSTFLD5').AsString  := CFLabel5.Text;
    FieldByName('CUSTFLD6').AsString  := CFLabel6.Text;
    FieldByName('CUSTFLD7').AsString  := CFLabel7.Text;
    FieldByName('CUSTFLD8').AsString  := CFLabel8.Text;
    FieldByName('CUSTFLD9').AsString  := CFLabel9.Text;
    FieldByName('CUSTFLD10').AsString := CFLabel10.Text;
    FieldByName('CUSTFLD11').AsString := CFLabel11.Text;
    FieldByName('CUSTFLD12').AsString := CFLabel12.Text;
    FieldByName('CUSTFLD13').AsString := CFLabel13.Text;
    FieldByName('CUSTFLD14').AsString := CFLabel14.Text;
    FieldByName('CUSTFLD15').AsString := CFLabel15.Text;
    FieldByName('CUSTFLD16').AsString := CFLabel16.Text;
    FieldByName('CUSTFLD17').AsString := CFLabel17.Text;
    FieldByName('CUSTFLD18').AsString := CFLabel18.Text;
    FieldByName('CUSTFLD19').AsString := CFLabel19.Text;
    FieldByName('CUSTFLD20').AsString := CFLabel20.Text;
    Post;
  end;
end;

procedure TfrmCustomFields2.cmdCancelClick(Sender: TObject);
begin
  RollbackTransaction;
  Self.Close;
end;

procedure TfrmCustomFields2.cmdOkClick(Sender: TObject);
begin
  try
    SaveTransactions;
    Self.Close;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TfrmCustomFields2.FormShow(Sender: TObject);
begin
  try
    inherited;
    if frmCustomFieldsTbl.Active then begin
      if not (frmCustomFieldsTbl.State in [dsBrowse]) then begin
        frmCustomFieldsTbl.Post;
        Notify;
      end;
      CloseQueries;
    end;

    OpenQueries;

    BeginTransaction;

    frmCustomFieldsTbl.Connection := MyConnection;
    frmCustomFieldsTbl.Active     := true;
    frmCustomFieldsTbl.Open;
    frmCustomFieldsTbl.Edit;

    //////////////////////////////////////////////////////////////////////
    // Hire Fields.
    //////////////////////////////////////////////////////////////////////
    if frmCustomFieldsTbl.FieldByName('CFHire1').AsString = 'T' then CFHire1.Checked := true
    else CFHire1.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire2').AsString = 'T' then CFHire2.Checked := true
    else CFHire2.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire3').AsString = 'T' then CFHire3.Checked := true
    else CFHire3.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire4').AsString = 'T' then CFHire4.Checked := true
    else CFHire4.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire5').AsString = 'T' then CFHire5.Checked := true
    else CFHire5.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire6').AsString = 'T' then CFHire6.Checked := true
    else CFHire6.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire7').AsString = 'T' then CFHire7.Checked := true
    else CFHire7.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire8').AsString = 'T' then CFHire8.Checked := true
    else CFHire8.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire9').AsString = 'T' then CFHire9.Checked := true
    else CFHire9.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire10').AsString = 'T' then CFHire10.Checked := true
    else CFHire10.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire11').AsString = 'T' then CFHire11.Checked := true
    else CFHire11.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire12').AsString = 'T' then CFHire12.Checked := true
    else CFHire12.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire13').AsString = 'T' then CFHire13.Checked := true
    else CFHire13.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire14').AsString = 'T' then CFHire14.Checked := true
    else CFHire14.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire15').AsString = 'T' then CFHire15.Checked := true
    else CFHire15.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire16').AsString = 'T' then CFHire16.Checked := true
    else CFHire16.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire17').AsString = 'T' then CFHire17.Checked := true
    else CFHire17.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire18').AsString = 'T' then CFHire18.Checked := true
    else CFHire18.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire19').AsString = 'T' then CFHire19.Checked := true
    else CFHire19.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFHire20').AsString = 'T' then CFHire20.Checked := true
    else CFHire20.Checked := false;

    //////////////////////////////////////////////////////////////////////
    // Required Fields
    //////////////////////////////////////////////////////////////////////
    if frmCustomFieldsTbl.FieldByName('CFIsRequired1').AsString = 'T' then chkIsRequired1.Checked := true
    else chkIsRequired1.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired2').AsString = 'T' then chkIsRequired2.Checked := true
    else chkIsRequired2.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired3').AsString = 'T' then chkIsRequired3.Checked := true
    else chkIsRequired3.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired4').AsString = 'T' then chkIsRequired4.Checked := true
    else chkIsRequired4.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired5').AsString = 'T' then chkIsRequired5.Checked := true
    else chkIsRequired5.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired6').AsString = 'T' then chkIsRequired6.Checked := true
    else chkIsRequired6.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired7').AsString = 'T' then chkIsRequired7.Checked := true
    else chkIsRequired7.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired8').AsString = 'T' then chkIsRequired8.Checked := true
    else chkIsRequired8.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired9').AsString = 'T' then chkIsRequired9.Checked := true
    else chkIsRequired9.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired10').AsString = 'T' then chkIsRequired10.Checked := true
    else chkIsRequired10.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired11').AsString = 'T' then chkIsRequired11.Checked := true
    else chkIsRequired11.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired12').AsString = 'T' then chkIsRequired12.Checked := true
    else chkIsRequired12.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired13').AsString = 'T' then chkIsRequired13.Checked := true
    else chkIsRequired13.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired14').AsString = 'T' then chkIsRequired14.Checked := true
    else chkIsRequired14.Checked := false;

    if frmCustomFieldsTbl.FieldByName('CFIsRequired15').AsString = 'T' then chkIsRequired15.Checked := true
    else chkIsRequired15.Checked := false;

    //    if frmCustomFieldsTbl.FieldByName('CFIsRequired16').AsString = 'T' then
    //      chkIsRequired16.Checked := True
    //    else
    //      chkIsRequired16.Checked := False;
    //
    //    if frmCustomFieldsTbl.FieldByName('CFIsRequired17').AsString = 'T' then
    //      chkIsRequired17.Checked := True
    //    else
    //      chkIsRequired17.Checked := False;
    //
    //    if frmCustomFieldsTbl.FieldByName('CFIsRequired18').AsString = 'T' then
    //      chkIsRequired18.Checked := True
    //    else
    //      chkIsRequired18.Checked := False;
    //
    //    if frmCustomFieldsTbl.FieldByName('CFIsRequired19').AsString = 'T' then
    //      chkIsRequired19.Checked := True
    //    else
    //      chkIsRequired19.Checked := False;
    //
    //    if frmCustomFieldsTbl.FieldByName('CFIsRequired20').AsString = 'T' then
    //      chkIsRequired20.Checked := True
    //    else
    //      chkIsRequired20.Checked := False;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TfrmCustomFields2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmCustomFieldsTbl.Active := false;
  CloseQueries;
  inherited;  
  Action := caFree;
end;

procedure TfrmCustomFields2.frmCustomFieldsTblAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(frmCustomFieldsTbl, memfrmCustomFieldsTbl);
end;

procedure TfrmCustomFields2.CFLabelEnter(Sender: TObject);
begin
  inherited;
  if Sender is TDBEdit then begin
    lblDropDownName.Enabled := true;
    chkIsCombo.Enabled      := true;
    Label3.Enabled          := true;
    grdDropDownText.Enabled := true;
    RefreshDropDown(TDBEdit(Sender));
  end;
end;

procedure TfrmCustomFields2.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;
  bIsFirstTime := true;
end;

procedure TfrmCustomFields2.RefreshDropDown(edtCustom: TDBEdit);
begin
  if not bIsFirstTime then begin
    UpdateIsCombo;
    if qryDropDowns.Active and not (qryDropDowns.State in [dsBrowse]) then begin
      qryDropDowns.Post;
    end;
  end;
  if not frmCustomFieldsTbl.Active then Exit;//Stops Access Vol on No Access
  iFieldNumber := Trunc(StrValue(edtCustom.Name));
  sLabelFieldName := 'CFLabel' + FastFuncs.IntToStr(iFieldNumber);
  sIsComboFieldName := 'CFIsCombo' + FastFuncs.IntToStr(iFieldNumber);

  lblDropDownName.Caption := 'Field ' + FastFuncs.IntToStr(iFieldNumber) + ': ' +
    frmCustomFieldsTbl.FieldByName(sLabelFieldName).AsString;

  if iFieldNumber < 16 then begin
    chkIsCombo.Checked := (frmCustomFieldsTbl.FieldByName(sIsComboFieldName).AsString = 'T');

    // Do something about ifieldnumber = 0
    with qryDropDowns do begin
      Close;
      ParamByName('xFieldNumber').AsInteger := iFieldNumber;
      Open;
      Edit;
    end;
  end else begin
    // Since this is disabled, close it while doing dates fields.
    qryDropDowns.Close;
  end;

  bIsFirstTime := false;
end;

procedure TfrmCustomFields2.qryDropDownsNewRecord(DataSet: TDataSet);
begin
  inherited;
  qryDropDowns.FieldByName('FieldNumber').AsInteger := iFieldNumber;
end;

procedure TfrmCustomFields2.grdDropDownTextExit(Sender: TObject);
begin
  inherited;
  qryDropDowns.Edit;  
  qryDropDowns.Post;
  qryDropDowns.Edit;
end;

procedure TfrmCustomFields2.UpDateIsCombo;
begin
end;

procedure TfrmCustomFields2.chkIsComboClick(Sender: TObject);
begin
  inherited;

  if fbStartingUp then Exit;
  if chkIsCombo.Checked then begin
    frmCustomFieldsTbl.FieldByName(sIsComboFieldName).AsString := 'T';
  end else begin
    frmCustomFieldsTbl.FieldByName(sIsComboFieldName).AsString := 'F';
  end;

  frmCustomFieldsTbl.Post;
  frmCustomFieldsTbl.Edit;
end;

procedure TfrmCustomFields2.CFLabel16Enter(Sender: TObject);
begin
  inherited;
  lblDropDownName.Enabled := false;
  chkIsCombo.Enabled := false;
  Label3.Enabled := false;
  grdDropDownText.Enabled := false;
end;

procedure TfrmCustomFields2.btnSet1Click(Sender: TObject);
Var Form : TComponent;
begin
  inherited;

  try
    SaveTransactions;
    Form := GetComponentByClassName('TfrmCustomFields');
    if Assigned(Form) then begin
      with TfrmCustomFields(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
    Self.Close;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

class procedure TfrmCustomFields2.CloseMe;
begin
  inherited;
  if FormStillOpen('TfrmCustomFields2') then begin
    TFrmCustomFields2(FindExistingComponent('TfrmCustomFields2')).close;
    Application.ProcessMessages;
  end;
end;

procedure TfrmCustomFields2.SaveTransactions;
begin
  if not (frmCustomFieldsTbl.State in [dsBrowse]) then begin
    ProcessEditedFlag('Main', Self, memfrmCustomFieldsTbl, frmCustomFieldsTbl, nil);
    frmCustomFieldsTbl.Edit;
    frmCustomFieldsTbl.Post;
  end;

  if qryDropDowns.Active and not (qryDropDowns.State in [dsBrowse]) then begin
    qryDropDowns.Post;
  end;

  // Commit Changes.
  CommitTransaction;
  Notify;

  //Refresh Fields
//  if Assigned(frmHireCustomFields) then frmHireCustomFields.CustomFieldsRefresh;
 if FormStillOpen('TfrmHireCustomFields') then TfrmHireCustomFields(FindExistingComponent('TfrmHireCustomFields')).CustomFieldsRefresh;
end;

Initialization
  RegisterClassOnce(TfrmCustomFields2);

end.
