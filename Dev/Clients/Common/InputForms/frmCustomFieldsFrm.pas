unit frmCustomFieldsFrm;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 15/09/05  1.00.01 DSP  Added SaveTransactions to resolve lockup issue when
                        switching between forms. The transactions were not
                        being committed when switching forms.
 19/12/05  1.00.08  AL   Removed "Instance", added RegisterClass  *Task306*
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons, DNMSpeedButton,
  BaseInputForm, kbmMemTable, SelectionDialog, AppEvnts, Grids, Wwdbigrd,
  Wwdbgrid, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS, DataState, Menus, AdvMenus, Shader,
  ImgList, ProgressDialog;

type
  TfrmCustomFields = class(TBaseInputGUI)
    frmCustomFieldsSrc: TDataSource;
    CFLabel1: TDBEdit;
    Label0: TLabel;
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
    CFCust1: TDBCheckBox;
    Label17: TLabel;
    CFEmpl1: TDBCheckBox;
    Label18: TLabel;
    CFSupp1: TDBCheckBox;
    Label19: TLabel;
    CFCust2: TDBCheckBox;
    CFEmpl2: TDBCheckBox;
    CFSupp2: TDBCheckBox;
    CFCust3: TDBCheckBox;
    CFEmpl3: TDBCheckBox;
    CFSupp3: TDBCheckBox;
    CFCust4: TDBCheckBox;
    CFEmpl4: TDBCheckBox;
    CFSupp4: TDBCheckBox;
    CFCust5: TDBCheckBox;
    CFEmpl5: TDBCheckBox;
    CFSupp5: TDBCheckBox;
    CFCust6: TDBCheckBox;
    CFEmpl6: TDBCheckBox;
    CFSupp6: TDBCheckBox;
    CFCust7: TDBCheckBox;
    CFEmpl7: TDBCheckBox;
    CFSupp7: TDBCheckBox;
    CFCust8: TDBCheckBox;
    CFEmpl8: TDBCheckBox;
    CFSupp8: TDBCheckBox;
    CFCust9: TDBCheckBox;
    CFEmpl9: TDBCheckBox;
    CFSupp9: TDBCheckBox;
    CFCust10: TDBCheckBox;
    CFEmpl10: TDBCheckBox;
    CFSupp10: TDBCheckBox;
    CFCust11: TDBCheckBox;
    CFEmpl11: TDBCheckBox;
    CFSupp11: TDBCheckBox;
    CFCust12: TDBCheckBox;
    CFEmpl12: TDBCheckBox;
    CFSupp12: TDBCheckBox;
    CFCust13: TDBCheckBox;
    CFEmpl13: TDBCheckBox;
    CFSupp13: TDBCheckBox;
    CFCust14: TDBCheckBox;
    CFEmpl14: TDBCheckBox;
    CFSupp14: TDBCheckBox;
    CFCust15: TDBCheckBox;
    CFEmpl15: TDBCheckBox;
    CFSupp15: TDBCheckBox;
    CFOthr1: TDBCheckBox;
    Label67: TLabel;
    CFOthr2: TDBCheckBox;
    CFOthr3: TDBCheckBox;
    CFOthr4: TDBCheckBox;
    CFOthr5: TDBCheckBox;
    CFOthr6: TDBCheckBox;
    CFOthr7: TDBCheckBox;
    CFOthr8: TDBCheckBox;
    CFOthr9: TDBCheckBox;
    CFOthr10: TDBCheckBox;
    CFOthr11: TDBCheckBox;
    CFOthr12: TDBCheckBox;
    CFOthr13: TDBCheckBox;
    CFOthr14: TDBCheckBox;
    CFOthr15: TDBCheckBox;
    frmCustomFieldsTbl: TMyTable;
    tblMergeFields: TMyTable;
    DataSource1: TDataSource;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Label1: TLabel;
    CFAssets1: TDBCheckBox;
    CFAssets2: TDBCheckBox;
    CFAssets3: TDBCheckBox;
    CFAssets4: TDBCheckBox;
    CFAssets5: TDBCheckBox;
    CFAssets6: TDBCheckBox;
    CFAssets7: TDBCheckBox;
    CFAssets8: TDBCheckBox;
    CFAssets9: TDBCheckBox;
    CFAssets10: TDBCheckBox;
    CFAssets11: TDBCheckBox;
    CFAssets12: TDBCheckBox;
    CFAssets13: TDBCheckBox;
    CFAssets14: TDBCheckBox;
    CFAssets15: TDBCheckBox;
    DNMPanel1: TDNMPanel;
    lblDropDownName: TLabel;
    Label3: TLabel;
    grdDropDownText: TwwDBGrid;
    dsDropDowns: TDataSource;
    qryDropDowns: TERPQuery;
    qryDropDownsDropDownID: TAutoIncField;
    qryDropDownsFieldNumber: TWordField;
    qryDropDownsText: TWideStringField;
    chkIsCombo: TCheckBox;
    DNMPanel2: TDNMPanel;
    Label4: TLabel;
    chkIsRequired1: TDBCheckBox;
    chkIsRequired2: TDBCheckBox;
    chkIsRequired3: TDBCheckBox;
    chkIsRequired4: TDBCheckBox;
    chkIsRequired5: TDBCheckBox;
    chkIsRequired6: TDBCheckBox;
    chkIsRequired7: TDBCheckBox;
    chkIsRequired8: TDBCheckBox;
    chkIsRequired9: TDBCheckBox;
    chkIsRequired10: TDBCheckBox;
    chkIsRequired11: TDBCheckBox;
    chkIsRequired12: TDBCheckBox;
    chkIsRequired13: TDBCheckBox;
    chkIsRequired14: TDBCheckBox;
    chkIsRequired15: TDBCheckBox;
    CFLabel16: TDBEdit;
    CFCust16: TDBCheckBox;
    CFEmpl16: TDBCheckBox;
    CFSupp16: TDBCheckBox;
    CFOthr16: TDBCheckBox;
    CFAssets16: TDBCheckBox;
    ChkIsRequired16: TDBCheckBox;
    CFLabel17: TDBEdit;
    CFCust17: TDBCheckBox;
    CFEmpl17: TDBCheckBox;
    CFSupp17: TDBCheckBox;
    CFOthr17: TDBCheckBox;
    CFAssets17: TDBCheckBox;
    chkIsRequired17: TDBCheckBox;
    CFLabel18: TDBEdit;
    CFCust18: TDBCheckBox;
    CFEmpl18: TDBCheckBox;
    CFSupp18: TDBCheckBox;
    CFOthr18: TDBCheckBox;
    CFAssets18: TDBCheckBox;
    chkIsRequired18: TDBCheckBox;
    Label2: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label5: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBCheckBox14: TDBCheckBox;
    DBCheckBox15: TDBCheckBox;
    DBCheckBox16: TDBCheckBox;
    DBCheckBox17: TDBCheckBox;
    DBCheckBox18: TDBCheckBox;
    grdDropDownTextIButton: TwwIButton;
    DBCheckBox19: TDBCheckBox;
    DBCheckBox20: TDBCheckBox;
    DBCheckBox21: TDBCheckBox;
    DBCheckBox22: TDBCheckBox;
    DBCheckBox23: TDBCheckBox;
    DBCheckBox24: TDBCheckBox;
    DBCheckBox25: TDBCheckBox;
    DBCheckBox26: TDBCheckBox;
    DBCheckBox27: TDBCheckBox;
    DBCheckBox28: TDBCheckBox;
    DBCheckBox29: TDBCheckBox;
    DBCheckBox30: TDBCheckBox;
    DBCheckBox31: TDBCheckBox;
    DBCheckBox32: TDBCheckBox;
    DBCheckBox33: TDBCheckBox;
    DBCheckBox34: TDBCheckBox;
    DBCheckBox35: TDBCheckBox;
    DBCheckBox36: TDBCheckBox;
    Label6: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Label7: TLabel;
    DBCheckBox37: TDBCheckBox;
    DBCheckBox38: TDBCheckBox;
    DBCheckBox39: TDBCheckBox;
    DBCheckBox40: TDBCheckBox;
    DBCheckBox41: TDBCheckBox;
    DBCheckBox42: TDBCheckBox;
    DBCheckBox43: TDBCheckBox;
    DBCheckBox44: TDBCheckBox;
    DBCheckBox45: TDBCheckBox;
    DBCheckBox46: TDBCheckBox;
    DBCheckBox47: TDBCheckBox;
    DBCheckBox48: TDBCheckBox;
    DBCheckBox49: TDBCheckBox;
    DBCheckBox50: TDBCheckBox;
    DBCheckBox51: TDBCheckBox;
    DBCheckBox52: TDBCheckBox;
    DBCheckBox53: TDBCheckBox;
    DBCheckBox54: TDBCheckBox;
    Label8: TLabel;
    Bevel11: TBevel;
    DBCheckBox55: TDBCheckBox;
    DBCheckBox56: TDBCheckBox;
    DBCheckBox57: TDBCheckBox;
    DBCheckBox58: TDBCheckBox;
    DBCheckBox59: TDBCheckBox;
    DBCheckBox60: TDBCheckBox;
    DBCheckBox61: TDBCheckBox;
    DBCheckBox62: TDBCheckBox;
    DBCheckBox63: TDBCheckBox;
    DBCheckBox64: TDBCheckBox;
    DBCheckBox65: TDBCheckBox;
    DBCheckBox66: TDBCheckBox;
    DBCheckBox67: TDBCheckBox;
    DBCheckBox68: TDBCheckBox;
    DBCheckBox69: TDBCheckBox;
    DBCheckBox70: TDBCheckBox;
    DBCheckBox71: TDBCheckBox;
    DBCheckBox72: TDBCheckBox;
    Bevel2: TBevel;
    memfrmCustomFieldsTbl :TkbmMemTable;
    qryDropDownsGlobalRef: TWideStringField;
    qryDropDownsEditedFlag: TWideStringField;
    qryDropDownsmsTimeStamp: TDateTimeField;
    qryDropDownsmsUpdateSiteCode: TWideStringField;
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
    procedure grdDropDownTextIButtonClick(Sender: TObject);
    procedure qryDropDownsBeforePost(DataSet: TDataSet);
    procedure qryDropDownsAfterPost(DataSet: TDataSet);
    procedure QryCustomFieldAfterPost(DataSet: TDataSet);
    procedure QryCustomFieldBeforePost(DataSet: TDataSet);
  private
    iFieldNumber: integer;
    sLabelFieldName: string;
    sIsComboFieldName: string;
    bIsFirstTime: boolean;
    procedure RefreshDropDown(edtCustom: TDBEdit);
    procedure UpDateIsCombo;
  protected
    procedure SaveTransactions;
  public
    class procedure CloseMe; override;
  end;


implementation

uses
  DNMExceptions, DNMLib, StrUtils, frmCustomerFrm, frmSupplier,
  frmOtherContactFrm, frmFixedAssetGUI, frmJob,
  CommonLib, FastFuncs, frmAppointments,EmployeeCustomFieldsFrm,
  BusObjDeletedItem, AppEnvironment;

{$R *.DFM}

procedure TfrmCustomFields.Form_Close;
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
    Post;
  end;
end;

procedure TfrmCustomFields.cmdCancelClick(Sender: TObject);
begin
  RollbackTransaction;
  Self.Close;
end;

procedure TfrmCustomFields.cmdOkClick(Sender: TObject);
begin
  try
    SaveTransactions;
    Notify(true);
    Self.Close;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TfrmCustomFields.FormShow(Sender: TObject);
begin
  UserLock.enabled := true;
  if not UserLock.Lock('tblcustomfields', 0, Self.Caption) then begin
        AccessLevel := 5; // read only
        //CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',mtWarning, [mbOK], 0);
        chkIsCombo.Enabled := False;
  end;
  DisableForm;
  try
    try
      inherited;
      if frmCustomFieldsTbl.Active then begin
        if not (frmCustomFieldsTbl.State in [dsBrowse]) then begin
          frmCustomFieldsTbl.Post;
          Notify;
        end;
        CloseQueries;
      end;
      BeginTransaction;
      frmCustomFieldsTbl.Connection := MyConnection;
      frmCustomFieldsTbl.Active     := true;
      (*frmCustomFieldsTbl.Open;
       frmCustomFieldsTbl.Edit;

      if frmCustomFieldsTbl.FieldByName('CFCust1').AsString = 'T' then CFCust1.Checked := true
      else CFCust1.Checked := false;
      if frmCustomFieldsTbl.FieldByName('CFCust2').AsString = 'T' then CFCust2.Checked := true
      else CFCust2.Checked := false;
      if frmCustomFieldsTbl.FieldByName('CFCust3').AsString = 'T' then CFCust3.Checked := true
      else CFCust3.Checked := false;
      if frmCustomFieldsTbl.FieldByName('CFCust4').AsString = 'T' then CFCust4.Checked := true
      else CFCust4.Checked := false;
      if frmCustomFieldsTbl.FieldByName('CFCust5').AsString = 'T' then CFCust5.Checked := true
      else CFCust5.Checked := false;
      if frmCustomFieldsTbl.FieldByName('CFCust6').AsString = 'T' then CFCust6.Checked := true
      else CFCust6.Checked := false;
      if frmCustomFieldsTbl.FieldByName('CFCust7').AsString = 'T' then CFCust7.Checked := true
      else CFCust7.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust8').AsString = 'T' then CFCust8.Checked := true
      else CFCust8.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust9').AsString = 'T' then CFCust9.Checked := true
      else CFCust9.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust10').AsString = 'T' then CFCust10.Checked := true
      else CFCust10.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust11').AsString = 'T' then CFCust11.Checked := true
      else CFCust11.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust12').AsString = 'T' then CFCust12.Checked := true
      else CFCust12.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust13').AsString = 'T' then CFCust13.Checked := true
      else CFCust13.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust14').AsString = 'T' then CFCust14.Checked := true
      else CFCust14.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust15').AsString = 'T' then CFCust15.Checked := true
      else CFCust15.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust16').AsString = 'T' then CFCust16.Checked := true
      else CFCust16.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust17').AsString = 'T' then CFCust17.Checked := true
      else CFCust17.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFCust18').AsString = 'T' then CFCust18.Checked := true
      else CFCust18.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl1').AsString = 'T' then CFEmpl1.Checked := true
      else CFEmpl1.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl2').AsString = 'T' then CFEmpl2.Checked := true
      else CFEmpl2.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl3').AsString = 'T' then CFEmpl3.Checked := true
      else CFEmpl3.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl4').AsString = 'T' then CFEmpl4.Checked := true
      else CFEmpl4.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl5').AsString = 'T' then CFEmpl5.Checked := true
      else CFEmpl5.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl6').AsString = 'T' then CFEmpl6.Checked := true
      else CFEmpl6.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl7').AsString = 'T' then CFEmpl7.Checked := true
      else CFEmpl7.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl8').AsString = 'T' then CFEmpl8.Checked := true
      else CFEmpl8.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl9').AsString = 'T' then CFEmpl9.Checked := true
      else CFEmpl9.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl10').AsString = 'T' then CFEmpl10.Checked := true
      else CFEmpl10.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl11').AsString = 'T' then CFEmpl11.Checked := true
      else CFEmpl11.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl12').AsString = 'T' then CFEmpl12.Checked := true
      else CFEmpl12.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl13').AsString = 'T' then CFEmpl13.Checked := true
      else CFEmpl13.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl14').AsString = 'T' then CFEmpl14.Checked := true
      else CFEmpl14.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl15').AsString = 'T' then CFEmpl15.Checked := true
      else CFEmpl15.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl16').AsString = 'T' then CFEmpl16.Checked := true
      else CFEmpl16.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl17').AsString = 'T' then CFEmpl17.Checked := true
      else CFEmpl17.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFEmpl18').AsString = 'T' then CFEmpl18.Checked := true
      else CFEmpl18.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp1').AsString = 'T' then CFSupp1.Checked := true
      else CFSupp1.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp2').AsString = 'T' then CFSupp2.Checked := true
      else CFSupp2.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp3').AsString = 'T' then CFSupp3.Checked := true
      else CFSupp3.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp4').AsString = 'T' then CFSupp4.Checked := true
      else CFSupp4.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp5').AsString = 'T' then CFSupp5.Checked := true
      else CFSupp5.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp6').AsString = 'T' then CFSupp6.Checked := true
      else CFSupp6.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp7').AsString = 'T' then CFSupp7.Checked := true
      else CFSupp7.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp8').AsString = 'T' then CFSupp8.Checked := true
      else CFSupp8.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp9').AsString = 'T' then CFSupp9.Checked := true
      else CFSupp9.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp10').AsString = 'T' then CFSupp10.Checked := true
      else CFSupp10.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp11').AsString = 'T' then CFSupp11.Checked := true
      else CFSupp11.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp12').AsString = 'T' then CFSupp12.Checked := true
      else CFSupp12.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp13').AsString = 'T' then CFSupp13.Checked := true
      else CFSupp13.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp14').AsString = 'T' then CFSupp14.Checked := true
      else CFSupp14.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp15').AsString = 'T' then CFSupp15.Checked := true
      else CFSupp15.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp16').AsString = 'T' then CFSupp16.Checked := true
      else CFSupp16.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp17').AsString = 'T' then CFSupp17.Checked := true
      else CFSupp17.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFSupp18').AsString = 'T' then CFSupp18.Checked := true
      else CFSupp18.Checked := false;

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

      if frmCustomFieldsTbl.FieldByName('CFIsRequired16').AsString = 'T' then chkIsRequired16.Checked := true
      else chkIsRequired16.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFIsRequired17').AsString = 'T' then chkIsRequired17.Checked := true
      else chkIsRequired17.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFIsRequired18').AsString = 'T' then chkIsRequired18.Checked := true
      else chkIsRequired18.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr1').AsString = 'T' then CFOthr1.Checked := true
      else CFOthr1.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr2').AsString = 'T' then CFOthr2.Checked := true
      else CFOthr2.Checked := false;
      if frmCustomFieldsTbl.FieldByName('CFOthr3').AsString = 'T' then CFOthr3.Checked := true
      else CFOthr3.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr4').AsString = 'T' then CFOthr4.Checked := true
      else CFOthr4.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr5').AsString = 'T' then CFOthr5.Checked := true
      else CFOthr5.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr6').AsString = 'T' then CFOthr6.Checked := true
      else CFOthr6.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr7').AsString = 'T' then CFOthr7.Checked := true
      else CFOthr7.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr8').AsString = 'T' then CFOthr8.Checked := true
      else CFOthr8.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr9').AsString = 'T' then CFOthr9.Checked := true
      else CFOthr9.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr10').AsString = 'T' then CFOthr10.Checked := true
      else CFOthr10.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr11').AsString = 'T' then CFOthr11.Checked := true
      else CFOthr11.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr12').AsString = 'T' then CFOthr12.Checked := true
      else CFOthr12.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr13').AsString = 'T' then CFOthr13.Checked := true
      else CFOthr13.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr14').AsString = 'T' then CFOthr14.Checked := true
      else CFOthr14.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr15').AsString = 'T' then CFOthr15.Checked := true
      else CFOthr15.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr16').AsString = 'T' then CFOthr16.Checked := true
      else CFOthr16.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr17').AsString = 'T' then CFOthr17.Checked := true
      else CFOthr17.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFOthr18').AsString = 'T' then CFOthr18.Checked := true
      else CFOthr18.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets1').AsString = 'T' then CFAssets1.Checked := true
      else CFAssets1.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets2').AsString = 'T' then CFAssets2.Checked := true
      else CFAssets2.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets3').AsString = 'T' then CFAssets3.Checked := true
      else CFAssets3.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets4').AsString = 'T' then CFAssets4.Checked := true
      else CFAssets4.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets5').AsString = 'T' then CFAssets5.Checked := true
      else CFAssets5.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets6').AsString = 'T' then CFAssets6.Checked := true
      else CFAssets6.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets7').AsString = 'T' then CFAssets7.Checked := true
      else CFAssets7.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets8').AsString = 'T' then CFAssets8.Checked := true
      else CFAssets8.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets9').AsString = 'T' then CFAssets9.Checked := true
      else CFAssets9.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets10').AsString = 'T' then CFAssets10.Checked := true
      else CFAssets10.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets11').AsString = 'T' then CFAssets11.Checked := true
      else CFAssets11.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets12').AsString = 'T' then CFAssets12.Checked := true
      else CFAssets12.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets13').AsString = 'T' then CFAssets13.Checked := true
      else CFAssets13.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets14').AsString = 'T' then CFAssets14.Checked := true
      else CFAssets14.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets15').AsString = 'T' then CFAssets15.Checked := true
      else CFAssets15.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets16').AsString = 'T' then CFAssets16.Checked := true
      else CFAssets16.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets17').AsString = 'T' then CFAssets17.Checked := true
      else CFAssets17.Checked := false;

      if frmCustomFieldsTbl.FieldByName('CFAssets18').AsString = 'T' then CFAssets18.Checked := true
      else CFAssets18.Checked := false; *)
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomFields.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmCustomFieldsTbl.Active := false;
  CloseQueries;
  inherited;
  Action := caFree;

end;

procedure TfrmCustomFields.frmCustomFieldsTblAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(frmCustomFieldsTbl, memfrmCustomFieldsTbl);
end;

procedure TfrmCustomFields.CFLabelEnter(Sender: TObject);
begin
  inherited;
  if Sender is TDBEdit then begin
    lblDropDownName.Enabled := true;
    chkIsCombo.Enabled      := Accesslevel =1;
    Label3.Enabled          := true;
    grdDropDownText.Enabled := true;
    RefreshDropDown(TDBEdit(Sender));
  end;
end;

procedure TfrmCustomFields.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;
  bIsFirstTime := true;
end;

procedure TfrmCustomFields.RefreshDropDown(edtCustom: TDBEdit);
begin
  if not bIsFirstTime then begin
    UpdateIsCombo;
    if qryDropDowns.Active and not (qryDropDowns.State in [dsBrowse]) then begin
      qryDropDowns.Post;
    end;
  end;

  iFieldNumber := Trunc(StrValue(edtCustom.Name));
  sLabelFieldName := 'CFLabel' + IntToStr(iFieldNumber);
  sIsComboFieldName := 'CFIsCombo' + IntToStr(iFieldNumber);

  lblDropDownName.Caption := 'Field ' + IntToStr(iFieldNumber) + ': ' +
    frmCustomFieldsTbl.FieldByName(sLabelFieldName).AsString;

  if iFieldNumber < 16 then begin
    chkIsCombo.Checked := (frmCustomFieldsTbl.FieldByName(sIsComboFieldName).AsString = 'T');

    // do something about ifieldnumber = 0

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

procedure TfrmCustomFields.qryDropDownsAfterPost(DataSet: TDataSet);
begin
  inherited;
  if qryDropDownsGlobalRef.AsString = '' then begin
    EditDb(qryDropDowns);
    qryDropDownsGlobalRef.AsString:= AppEnv.Branch.SiteCode + self.qryDropDownsDropDownID.AsString;
    PostDb(qryDropDowns);
  end;
end;

procedure TfrmCustomFields.qryDropDownsBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryDropDownsmsUpdateSiteCode.AsString := AppEnv.Branch.SiteCode;
end;

procedure TfrmCustomFields.qryDropDownsNewRecord(DataSet: TDataSet);
begin
  inherited;
  qryDropDowns.FieldByName('FieldNumber').AsInteger := iFieldNumber;
end;

procedure TfrmCustomFields.grdDropDownTextExit(Sender: TObject);
begin
  inherited;
  qryDropDowns.Edit;  
  qryDropDowns.Post;
  qryDropDowns.Edit;
end;

procedure TfrmCustomFields.UpDateIsCombo;
begin
end;

procedure TfrmCustomFields.chkIsComboClick(Sender: TObject);
begin
  inherited;
  editdb(frmCustomFieldsTbl);
  if chkIsCombo.Checked then begin
    frmCustomFieldsTbl.FieldByName(sIsComboFieldName).AsString := 'T';
  end else begin
    frmCustomFieldsTbl.FieldByName(sIsComboFieldName).AsString := 'F';
  end;

  frmCustomFieldsTbl.Post;
  frmCustomFieldsTbl.Edit;
end;

procedure TfrmCustomFields.CFLabel16Enter(Sender: TObject);
begin
  inherited;
  lblDropDownName.Enabled := false;
  chkIsCombo.Enabled := false;
  Label3.Enabled := false;
  grdDropDownText.Enabled := false;
end;


class procedure TfrmCustomFields.CloseMe;
begin
  inherited;
  if FormStillOpen('TfmrCustomFields') then begin
    TFrmCustomFields(FindExistingComponent('TfrmCustomFields')).Close;
    Application.ProcessMessages;
  end;
end;

procedure TfrmCustomFields.SaveTransactions;
begin
  if not (frmCustomFieldsTbl.State in [dsBrowse]) then begin
    ProcessEditedFlag('Main', Self, memfrmCustomFieldsTbl, frmCustomFieldsTbl, nil);
    frmCustomFieldsTbl.Edit;
    frmCustomFieldsTbl.Post;
    frmCustomFieldsTbl.Connection.Commit;
    frmCustomFieldsTbl.Connection.StartTransaction;
  end;

  if qryDropDowns.Active and not (qryDropDowns.State in [dsBrowse]) then begin
    qryDropDowns.Post;
  end;

  CommitTransaction;
  Notify(False);

  //Refresh Fields
  (*if FormStillOpen('TfrmCustomer') then TfrmCustomer(FindExistingComponent('TfrmCustomer')).CustomFieldsRefresh;
  if FormStillOpen('TJobGUI') then TJobGUI(FindExistingComponent('TJobGUI')).CustomFieldsRefresh;
  if FormStillOpen('TfmSupplier') then TfmSupplier(FindExistingComponent('TfmSupplier')).CustomFieldsRefresh;
  if FormStillOpen('TfrmOtherContact') then TfrmOtherContact(FindExistingComponent('TfrmOtherContact')).CustomFieldsRefresh;
  if FormStillOpen('TFixedAssetGUI') then TFixedAssetGUI(FindExistingComponent('TFixedAssetGUI')).CustomFieldsRefresh;
  if FormStillOpen('TAppointmentGUI') then TAppointmentGUI(FindExistingComponent('TAppointmentGUI')).CustomFieldsRefresh;                  *)
  if FormStillOpen('TEmployeeCustomFields') then TEmployeeCustomFields(FindExistingComponent('TEmployeeCustomFields')).CustomFieldsRefresh;
    //TO DO sort out CustomFieldsRefresh above
end;

procedure TfrmCustomFields.grdDropDownTextIButtonClick(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if not dsDropDowns.DataSet.IsEmpty then begin
    if not TDeletedItem.AddDeleted('tblcustomfielddropdowns','TBusObjCustFieldValueConfig',qryDropDownsGlobalRef.AsString, qryDropDownsDropDownID.AsInteger,qryDropDowns.Connection,msg) then
      CommonLib.MessageDlgXP_Vista('Error deleting item: ' + msg,mtError,[mbOk],0);
    dsDropDowns.DataSet.Refresh;
  end;
end;

procedure TfrmCustomFields.QryCustomFieldAfterPost(DataSet: TDataSet);
begin
  inherited;
  if QryCustomField.FieldByName('GlobalRef').AsString = '' then begin
    EditDb(QryCustomField);
    QryCustomField.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + QryCustomField.FieldByName('ID').AsString;
    PostDb(QryCustomField);
  end;
end;

procedure TfrmCustomFields.QryCustomFieldBeforePost(DataSet: TDataSet);
begin
  inherited;
  QryCustomField.FieldByName('msUpdateSiteCode').AsString := AppEnv.Branch.SiteCode;
end;

Initialization
  RegisterClassOnce(TfrmCustomFields);

end.
