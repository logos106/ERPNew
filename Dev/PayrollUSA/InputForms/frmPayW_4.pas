unit frmPayW_4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMPanel, Shader, frmPayFormsBase , BusObjFormW4,
  DNMSpeedButton, wwcheckbox, Mask, wwdbedit, wwclearbuttongroup, wwradiogroup,
  BusObjBase, ComCtrls, EmployeeObj;

type
  TfmPayW_4 = class(TBaseInputGUI)
    sbPanels: TScrollBox;
    pnlHeader: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkUseW4: TwwCheckBox;
    pnlFooter: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    dspaysw_4: TDataSource;
    pnlMain: TDNMPanel;
    pnl01: TDNMPanel;
    DNMPanel3: TDNMPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    DNMPanel4: TDNMPanel;
    lbl7: TLabel;
    lbl8: TLabel;
    DNMPanel5: TDNMPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    pnlStep1: TDNMPanel;
    pnlMainLabel: TDNMPanel;
    lbl9: TLabel;
    pnlSocial: TDNMPanel;
    Label7: TLabel;
    DNMPanel6: TDNMPanel;
    Label6: TLabel;
    Edit5: TwwDBEdit;
    pnlEmployee: TDNMPanel;
    pnlfirstname: TDNMPanel;
    Label1: TLabel;
    edtFirstname: TwwDBEdit;
    pnlLastname: TDNMPanel;
    Label2: TLabel;
    edtLastName: TwwDBEdit;
    pnlAddress: TDNMPanel;
    Label3: TLabel;
    edtAddress: TwwDBEdit;
    pnlCity1: TDNMPanel;
    Label4: TLabel;
    edtCity: TwwDBEdit;
    edtTown: TwwDBEdit;
    edtState: TwwDBEdit;
    edtZIP: TwwDBEdit;
    Label5: TLabel;
    opt1: TwwRadioGroup;
    pnl02: TDNMPanel;
    Label8: TLabel;
    Label9: TLabel;
    pnlStep2: TDNMPanel;
    lbl12: TLabel;
    Label10: TLabel;
    RichEdit1: TRichEdit;
    chk1: TwwCheckBox;
    DNMPanel20: TDNMPanel;
    lbl10: TLabel;
    pnlStep3: TDNMPanel;
    DNMPanel12: TDNMPanel;
    lbl13: TLabel;
    DNMPanel13: TDNMPanel;
    Edit6: TwwDBEdit;
    DNMPanel14: TDNMPanel;
    Label11: TLabel;
    DNMPanel15: TDNMPanel;
    DNMPanel16: TDNMPanel;
    Label14: TLabel;
    DNMPanel17: TDNMPanel;
    Label15: TLabel;
    Edit8: TwwDBEdit;
    DNMPanel18: TDNMPanel;
    Label16: TLabel;
    Edit7: TwwDBEdit;
    DNMPanel19: TDNMPanel;
    Label17: TLabel;
    pnlStep4: TDNMPanel;
    DNMPanel22: TDNMPanel;
    lbl14: TLabel;
    DNMPanel25: TDNMPanel;
    pnl4C: TDNMPanel;
    Label18: TLabel;
    Label20: TLabel;
    DNMPanel32: TDNMPanel;
    Label23: TLabel;
    Edit10: TwwDBEdit;
    DNMPanel33: TDNMPanel;
    Label27: TLabel;
    pnl4B: TDNMPanel;
    Label24: TLabel;
    Label22: TLabel;
    DNMPanel30: TDNMPanel;
    Label12: TLabel;
    Edit11: TwwDBEdit;
    DNMPanel31: TDNMPanel;
    Label26: TLabel;
    pnl4A: TDNMPanel;
    Label25: TLabel;
    Label13: TLabel;
    DNMPanel23: TDNMPanel;
    Label19: TLabel;
    Edit9: TwwDBEdit;
    DNMPanel24: TDNMPanel;
    Label21: TLabel;
    pnlStep5: TDNMPanel;
    DNMPanel9: TDNMPanel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    DNMPanel21: TDNMPanel;
    DNMPanel39: TDNMPanel;
    Label37: TLabel;
    pnlName: TDNMPanel;
    pnlContent: TDNMPanel;
    pnlUpper: TDNMPanel;
    pnlBelow: TDNMPanel;
    pnlContainer: TDNMPanel;
    btnPrint: TDNMSpeedButton;
    lblA1: TLabel;
    qrypaysw_4: TERPQuery;
    qrypaysw_4EmployeeID: TIntegerField;
    qrypaysw_4PayYear: TIntegerField;
    qrypaysw_4PayYearStart: TDateField;
    qrypaysw_4FirstName: TWideStringField;
    qrypaysw_4LastName: TWideStringField;
    qrypaysw_4SocialSecurityNumber: TWideStringField;
    qrypaysw_4Street1: TWideStringField;
    qrypaysw_4Street2: TWideStringField;
    qrypaysw_4Suburb: TWideStringField;
    qrypaysw_4Postcode: TWideStringField;
    qrypaysw_4State: TWideStringField;
    qrypaysw_4Country: TWideStringField;
    qrypaysw_4TaxReportingtype: TWideStringField;
    qrypaysw_4UseW4: TWideStringField;
    qrypaysw_4HaveMultipleJobs: TWideStringField;
    qrypaysw_4ChildrenUnder17: TIntegerField;
    qrypaysw_4OtherDependent: TIntegerField;
    qrypaysw_4Dependent: TIntegerField;
    qrypaysw_4OtherIncome: TFloatField;
    qrypaysw_4Deductions: TFloatField;
    qrypaysw_4ExtraWithholding: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPrintClick(Sender: TObject);
  private
    FFormW4: TFormW4;
    fEmployeeId: Integer;
    function YearNo:Integer;
    procedure Initform;

    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveRecord: Boolean;
    Procedure OpenRecord;
    procedure NewBusObjinstance;
    procedure NewRecord;
  Protected
    procedure SetTransConnection(const Value: TERPConnection); Override;
  public
    Property EmployeeId: Integer read fEmployeeId write fEmployeeId;
  end;


implementation

uses tcConst, AppEnvironment, CommonLib, dateutils , DateTimeUtils, BusObjConst,
  BusObjPrintDoc;

{$R *.dfm}

procedure TfmPayW_4.btnCancelClick(Sender: TObject);
begin
  inherited;

  Self.Close;
end;

procedure TfmPayW_4.FormCreate(Sender: TObject);
begin
  inherited;

  WiderForm(1000);

//  pnlmain.left := 1;
//  pnlmain.top := 1;
//  //pnlmain.height := 930;
//  pnlmain.width  := sbPanels.width - 20;
  sbPanels.VertScrollbar.Range := pnlmain.height + 10;

  NewBusObjInstance;
end;

procedure TfmPayW_4.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  FFormW4 := TFormW4.CreateWithNewConn(Self);
  FFormW4.Connection.connection := Self.MyConnection;
  FFormW4.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

procedure TfmPayW_4.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;

  if not (Sender is TFormW4) then Exit;

  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then
    TFormW4(Sender).Dataset  := qrypaysw_4
  else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterInsert) then
    TFormW4(Sender).EmployeeId := EmployeeID;
end;

procedure TfmPayW_4.FormShow(Sender: TObject);
begin
  inherited;
  OpenRecord;
end;

procedure TfmPayW_4.OpenRecord;
var
  S : string;
  Emp : TEmployeeObj;
begin
  S := 'PayYear = ' + IntToStr(YearOf(Appenv.CompanyPrefs.FiscalYearStartingDate));
  S := S + ' AND EmployeeId = ' + IntToStr(EmployeeID);
  FFormW4.LoadSelect(S);
  FFormW4.connection.BeginNestedTransaction;

  if FFormW4.count = 0 then begin
    FFormW4.New;

    // Populate with employee's basic info
    Emp:= TEmployeeObj.Create;
    Emp.PopulateMe(EmployeeID, False);

    FFormW4.FirstName := Emp.FirstName;
    FFormW4.LastName := Emp.LastName;
    FFormW4.Street1 := Emp.Street;
    FFormW4.Street2 := Emp.Street2;
    FFormW4.Suburb := Emp.Suburb;
    FFormW4.State := Emp.State;
    FFormW4.Postcode := Emp.PostCode;
    FFormW4.SocialSecurityNumber := Emp.TFN;

    FreeAndNil(Emp);

    FFormW4.PayYear := YearOf(Appenv.CompanyPrefs.FiscalYearStartingDate);
    FFormW4.PayYearStart := Appenv.CompanyPrefs.FiscalYearStartingDate;

    FFormW4.Dirty := False;
  end;

  OpenQueries;
end;

procedure TfmPayW_4.btnSaveClick(Sender: TObject);
begin
  if not SaveRecord then Exit;

  FFormW4.Connection.CommitnestedTransaction;
  FFormW4.Dirty := False;
end;

procedure TfmPayW_4.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := False;

  if FFormW4.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            FFormW4.Connection.CommitNestedTransaction;
            FFormW4.Dirty := False;
            CanClose := True;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          FFormW4.CancelDb;
          FFormW4.Connection.RollbackNestedTransaction;
          FFormW4.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := False;
        end;
    end;
  end else begin
    CanClose := True;
    Notify(False);
  end;

end;

procedure TfmPayW_4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TfmPayW_4.SaveRecord: Boolean;
begin
  result:= False;

//  FFormW4.Dataset := qrypaysw_4;
  FFormW4.PostDB;

  if not(FFormW4.Save) then Exit;

  Result := True;
end;

procedure TfmPayW_4.Initform;
begin

(*  sbmain.top :=0;
  sbmain.left:= 0;
  sbmain.width := width;
  sbmain.height := height;
  sbmain.anchors := [akLeft,akTop,akright,akBottom];*)

  lbl1.caption :='Form'+NL+
                 '(Rev. December 2020)'+NL+
                 'Department of the Treasury'+NL+
                 'Internal Revenue Service';
  lbl8.caption := trim(inttostr(YearNo));
  chkUseW4.caption := 'HAS submitted a Form W-4 for '+trim(inttostr(YearNo))+' ?';
  lbl9.caption := 'Step 1:'+NL+
                 'Enter'+NL+
                 'Personal'+NL+
                 'Information';
  pnlLastname.top := pnlfirstname.top;
  pnlLastname.height := pnlfirstname.height;
  pnlLastname.Left:= trunc(pnlEmployee.width/2)+5;

  lbl10.caption := 'Step 2:'+NL+
                 'Multiple Jobs'+NL+
                 'or Spouse'+NL+
                 'Works';
  (*lbl11.caption :=replacestr(lbl11.caption, 'Complete this step if you (1) hold more than one job at a time, or (2) are married filing jointly and your spouse', 'Complete this step if you (1) hold more than one job at a time, or (2) are married filing jointly and your spouse'+NL);
  lbl11.caption :=replacestr(lbl11.caption, 'also works. The correct amount of withholding depends on income earned from all of these jobs.','also works. The correct amount of withholding depends on income earned from all of these jobs.'+NL);
  lbl11.caption :=replacestr(lbl11.caption, 'Do only one of the following.','Do only one of the following.'+NL);
  lbl11.caption :=replacestr(lbl11.caption, '(a) Use the estimator at www.irs.gov/W4App for most accurate withholding for this step (and Steps 3–4); or','(a) Use the estimator at www.irs.gov/W4App for most accurate withholding for this step (and Steps 3–4); or'+NL);
  lbl11.caption :=replacestr(lbl11.caption, '(b) Use the Multiple Jobs Worksheet on page 3 and enter the result in Step 4(c) below for roughly accurate withholding; or','(b) Use the Multiple Jobs Worksheet on page 3 and enter the result in Step 4(c) below for roughly accurate withholding; or'+NL);
  lbl11.caption :=replacestr(lbl11.caption, '(c) If there are only two jobs total, you may check this box. Do the same on Form W-4 for the other job. This option','(c) If there are only two jobs total, you may check this box. Do the same on Form W-4 for the other job. This option'+NL);*)

  lbl12.caption :='TIP: To be accurate, submit a 2021 Form W-4 for all other jobs. If you (or your spouse) have self-employment'+NL+
                 'income, including as an independent contractor, use the estimator.';

  lbl13.caption := 'Step 3:'+NL+
                 'Claim'+NL+
                 'Dependents';
  lbl14.caption := 'Step 4'+NL+
                 '(optional):'+NL+
                 'Other'+NL+
                 'Adjustments';
  opt1.items.clear;
  opt1.items.add('    Single or Married filing separately');
  opt1.items.add('    Married filing jointly or Qualifying widow(er)');
  opt1.items.add('    Head of household (Check only if you’re unmarried and pay more than half'+NLnLf+
                 '    the costs of keeping up a home for yourself and a qualifying individual.)');
  opt1.items.add('Un-known');

end;

procedure TfmPayW_4.NewRecord;
begin
    CloseQueries;
    KeyID := 0;
    NewBusObjinstance;
    AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
//    FFormW4.Connection.BeginnestedTransaction;
    OpenRecord;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    //Setcontrolfocus(edtName);
end;

procedure TfmPayW_4.SetTransConnection(const Value: TERPConnection);
begin
  inherited;

  if FFormW4 = nil then NewBusObjinstance;
  if FFormW4.connection.connection <> Value then begin
    FFormW4.closedb;
    FFormW4.connection.connection := Value;
    OpenRecord;
  end;
end;

function TfmPayW_4.YearNo: Integer;
begin
  REsult := YearOf(Appenv.companyprefs.FiscalYearStartingDate);
end;

procedure TfmPayW_4.btnPrintClick(Sender: TObject);
var
  lReport : string;
  lPrintDoc : TBusObjPrintDoc;
begin

  PrintTemplateReport('USA Payroll Form W-4 2021', 'WHERE EmployeeID=' + IntToStr(fEmployeeId), True, 1);

end;

initialization
  RegisterClassOnce(TfmPayW_4);
end.
