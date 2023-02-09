unit frmCompanyInformationFrm;

{$I ERP.inc}

interface

uses
  Windows, Forms, SysUtils, BaseInputForm, DB, Buttons, DNMSpeedButton, StdCtrls, DBCtrls, Controls,
  Mask, Classes, ExtCtrls, Dialogs, jpeg, Grids, Wwdbigrd, Wwdbgrid, Variants,
  ComCtrls,AdvOfficeStatusBar, DNMPanel, wwdblook, wwdbedit, dbcgrids, kbmMemTable, DataState,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, AdvSelectors, Graphics,
  Menus, AdvMenus, wwclearbuttongroup, wwradiogroup, MemDS, Shader,
  DAScript, MyScript, ImgList, wwcheckbox, ProgressDialog, pngimage;

type
  TfrmCompanyInformation = class(TBaseInputGUI)
    frmCompanyInformationSrc: TDataSource;
    CompanyInfo: TERPQuery;
    qryInsert: TERPQuery;
    tblColumnHeadings: TMyTable;
    DSBranchCode: TDataSource;
    qryBranchCode: TERPQuery;
    CompanyInfoSetupID: TAutoIncField;
    CompanyInfoCompanyName: TWideStringField;
    CompanyInfoTradingName: TWideStringField;
    CompanyInfoContactName: TWideStringField;
    CompanyInfoContactEmail: TWideStringField;
    CompanyInfoPhoneNumber: TWideStringField;
    CompanyInfoFaxNumber: TWideStringField;
    CompanyInfoABN: TWideStringField;
    CompanyInfoEditedFlag: TWideStringField;
    CompanyInfoPOBox: TWideStringField;
    CompanyInfoPOBox2: TWideStringField;
    CompanyInfoPOCity: TWideStringField;
    CompanyInfoPOState: TWideStringField;
    CompanyInfoPOPostcode: TWideStringField;
    CompanyInfoPOCountry: TWideStringField;
    CompanyInfoETPPayerType: TWideStringField;
    CompanyInfoFileReference: TWideStringField;
    CompanyInfoTaxSignatory: TWideStringField;
    CompanyInfoLeaveLoadingPercent: TFloatField;
    CompanyInfoCompulsorySuperPercent: TFloatField;
    CompanyInfoBSB: TWideStringField;
    CompanyInfoAccountNo: TWideStringField;
    CompanyInfoFontCompanyName: TWideStringField;
    CompanyInfoFontAddress: TWideStringField;
    CompanyInfoFontSuburb: TWideStringField;
    CompanyInfoFontPhone: TWideStringField;
    CompanyInfoFontABN: TWideStringField;
    CompanyInfoFontDefault: TWideStringField;
    CompanyInfoSizeCompanyName: TIntegerField;
    CompanyInfoSizeAddress: TIntegerField;
    CompanyInfoSizeSuburb: TIntegerField;
    CompanyInfoSizePhone: TIntegerField;
    CompanyInfoSizeABN: TIntegerField;
    CompanyInfoSizeDefault: TIntegerField;
    CompanyInfoColorCompanyName: TWideStringField;
    CompanyInfoColorAddress: TWideStringField;
    CompanyInfoColorSuburb: TWideStringField;
    CompanyInfoColorPhone: TWideStringField;
    CompanyInfoColorABN: TWideStringField;
    CompanyInfoColorDefault: TWideStringField;
    CompanyInfoStyleCompanyName: TWideStringField;
    CompanyInfoStyleAddress: TWideStringField;
    CompanyInfoStyleSuburb: TWideStringField;
    CompanyInfoStylePhone: TWideStringField;
    CompanyInfoStyleABN: TWideStringField;
    CompanyInfoStyleDefault: TWideStringField;
    CompanyInfoBankCode: TIntegerField;
    CompanyInfoBankBranch: TWideStringField;
    CompanyInfoAPCANo: TWideStringField;
    CompanyInfoWorkersCompInsurer: TIntegerField;
    qrySuburb: TERPQuery;
    CompanyInfoEmail: TWideStringField;
    CompanyInfoGlobalRef: TWideStringField;
    CompanyInfoAddress: TWideStringField;
    CompanyInfoAddress2: TWideStringField;
    CompanyInfoCity: TWideStringField;
    CompanyInfoState: TWideStringField;
    CompanyInfoPostcode: TWideStringField;
    CompanyInfoCountry: TWideStringField;
    CompanyInfoURL: TWideStringField;
    qryBranchCodeBackEndID: TAutoIncField;
    qryBranchCodeSiteCode: TWideStringField;
    qryBranchCodeSiteDesc: TWideStringField;
    qryBranchCodeBEDefault: TWideStringField;
    CompanyInfoContact: TWideStringField;
    qryBranchCodeEmailAddressData: TWideStringField;
    qryBranchCodeEmailPassword: TWideStringField;
    qryBranchCodeConflictTodoUserId: TIntegerField;
    cboEmployeeLookup: TERPQuery;
    qryBranchCodeuserName: TWideStringField;
    qryBranchCodeEmailUsername: TWideStringField;
    CompanyInfoMenuColor: TIntegerField;
    CompanyInfoSupplierId: TWideStringField;
    CompanyInfoDVAABN: TWideStringField;
    CompanyInfoRAPloginID: TWideStringField;
    CompanyInfoRAPPassword: TWideStringField;
    CompanyInfoRAPLoginPage: TWideStringField;
    CompanyInfoRAPProgramName: TWideStringField;
    CompanyInfoRAPInvoiceDescription: TWideStringField;
    CompanyInfoRAPProductGroup: TWideStringField;
    CompanyInfoRAPContractNumber: TWideStringField;
    CompanyInfoAddress3: TWideStringField;
    CompanyInfoPOBox3: TWideStringField;
    DNMPanel1: TDNMPanel;
    Box20: TBevel;
    lblSuburb: TLabel;
    lblState: TLabel;
    lblPostCode: TLabel;
    Country_Label: TLabel;
    Label33: TLabel;
    Box31: TBevel;
    Address_Label: TLabel;
    Label22: TLabel;
    lblSuburb2: TLabel;
    lblState2: TLabel;
    lblPostcode2: TLabel;
    lblCountry: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label1: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    txtAddress: TDBMemo;
    State: TDBEdit;
    Postcode: TDBEdit;
    txtCountry: TDBEdit;
    txtPOBox: TDBMemo;
    State2: TDBEdit;
    Postcode2: TDBEdit;
    txtPOCountry: TDBEdit;
    txtAddress2: TDBMemo;
    txtPOBox2: TDBMemo;
    cmdCopy: TDNMSpeedButton;
    Suburb: TwwDBLookupCombo;
    Suburb2: TwwDBLookupCombo;
    edtEmail: TDBEdit;
    txtPhoneNumber: TwwDBEdit;
    txtFaxNumber: TwwDBEdit;
    txtAddress3: TDBMemo;
    txtPOBox3: TDBMemo;
    Bevel1: TBevel;
    Label3: TLabel;
    edtSiteCode: TDBEdit;
    Label5: TLabel;
    cboDefaultClass: TwwDBLookupCombo;
    qryDepartments: TERPQuery;
    qryColumnHeadings: TERPQuery;
    dsColumnHeadings: TDataSource;
    qryRegions: TMyQuery;
    CompanyInfoCompanyNumber: TWideStringField;
    Label6: TLabel;
    chkTrackEmails: TwwCheckBox;
    CompanyInfoTrackEmails: TWideStringField;
    btnEmailConfig: TDNMSpeedButton;
    CompanyInfoFirstName: TWideStringField;
    CompanyInfoLastName: TWideStringField;
    FaxNumber_Label: TLabel;
    CompanyInfoMobileNumber: TWideStringField;
    wwDBEdit1: TwwDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    txtABN: TDBEdit;
    edtCompanyNumber: TDBEdit;
    Label4: TLabel;
    Label10: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label11: TLabel;
    wwDBEdit2: TwwDBEdit;
    CompanyInfoCompanyCategory: TWideStringField;
    Label12: TLabel;
    DBEdit2: TDBEdit;
    btnUpdateAllGlobalrefs: TDNMSpeedButton;
    CompanyInfoTitle: TWideStringField;
    CompanyInfoEmployeeId: TIntegerField;
    qryIndustries: TERPQuery;
    CompanyInfoIndustryId: TIntegerField;
    qryIndustriesIndustryId: TIntegerField;
    qryIndustriesIndustryName: TWideStringField;
    ERPQuery1: TERPQuery;
    Label17: TLabel;
    cboEmployee: TwwDBLookupCombo;
    cboEmployeeLookupEmployeeID: TIntegerField;
    cboEmployeeLookupEmployeeName: TWideStringField;
    cboEmployeeLookupFirstname: TWideStringField;
    cboEmployeeLookupLastname: TWideStringField;
    lblLocationCode: TLabel;
    edtLocationCode: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    Label18: TLabel;
    CompanyInfoLocationcode: TWideStringField;
    CompanyInfoPOLocationcode: TWideStringField;
    Label2: TLabel;
    edtFirstName: TDBEdit;
    Label7: TLabel;
    edtLastName: TDBEdit;
    Label13: TLabel;
    edtTitle: TDBEdit;
    QryCompanyLogo: TERPQuery;
    dsCompanyLogo: TDataSource;
    QryCompanyLogoGlobalRef: TWideStringField;
    QryCompanyLogoID: TIntegerField;
    QryCompanyLogoSetupID: TIntegerField;
    QryCompanyLogoCompLog: TBlobField;
    QryCompanyLogoPictype: TWideStringField;
    QryCompanyLogoImageName: TWideStringField;
    QryCompanyLogoImageTypes: TWideStringField;
    QryCompanyLogomsTimeStamp: TDateTimeField;
    QryCompanyLogomsUpdateSiteCode: TWideStringField;
    DNMPanel2: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCustomise: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    CompanyName_Label: TLabel;
    txtCompanyName: TDBEdit;
    Label16: TLabel;
    cbIndustry: TwwDBLookupCombo;
    cboRegion: TwwDBLookupCombo;
    pnlcompanyLogo: TDNMPanel;
    imgcompanyLogo: TImage;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    procedure cmdCopyClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure AddCompanyClass;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdCustomiseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure Suburb2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure SuburbEnter(Sender: TObject);
    procedure Suburb2Enter(Sender: TObject);
    procedure txtFaxNumberExit(Sender: TObject);
    procedure qrySuburbBeforeOpen(DataSet: TDataSet);
    procedure lblCountryDblClick(Sender: TObject);
    procedure SuburbNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure Suburb2NotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure cboDefaultClassChange(Sender: TObject);
    procedure qryBranchCodeSiteCodeSetText(Sender: TField;
      const Text: String);
    procedure edtSiteCodeExit(Sender: TObject);
    procedure qryBranchCodeAfterInsert(DataSet: TDataSet);
    procedure cboDefaultClassBeforeDropDown(Sender: TObject);
    procedure cboRegionCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnEmailConfigClick(Sender: TObject);
    //procedure edtFirstNameExit(Sender: TObject);
    procedure btnUpdateAllGlobalrefsClick(Sender: TObject);
    procedure cbIndustryCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure CompanyInfoAfterOpen(DataSet: TDataSet);
    procedure QryCompanyLogoAfterScroll(DataSet: TDataSet);
    procedure chooseLogo(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    WasRegionID:Integer;
    WasIndustry : integer;
    cleancompanyName :String;
    CleanDefaultclass:String;
    DoingFormShow: boolean;
    fsPublishonVS1tablename:String;
    Procedure DoCountryChange;
    function SiteCodeUnique: boolean;
    function SaveData: Boolean;
    Procedure MakeContactName;
    Procedure UpdateGlobalRefWithcurrentSiteCode;
    procedure PublishonVS1;
  Protected
    Procedure CommitTransaction;Override;
    (*procedure CreateEmployee;*)
  public
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;


  end;

implementation

uses FastFuncs,DNMExceptions, frmCompanyInfoCustomiseFrm,
     DnmLib, MAIN, MainSwitchFrm2,
     CommonLib, CommonDbLib,
     AppEnvironment, {frmBranch,} TypInfo, BusObjClass,
     BusObjEmailConfig, BusObjBase, frmEmailConfig2, TransactionsTable,
  frmEmployeeFrm , ImagesLib, BusObjPicture, utNewDBUtils, DbSharedObjectsObj;

{$R *.DFM}

procedure TfrmCompanyInformation.cmdCopyClick(Sender: TObject);
begin
  CompanyInfo.edit;
  CompanyInfo.FieldByName('POBox').asString := txtAddress.Text;
  CompanyInfo.FieldByName('POBox2').asString := txtAddress2.Text;
  CompanyInfo.FieldByName('POBox3').asString := txtAddress3.Text;
  CompanyInfo.FieldByName('POCity').asString := Suburb.Text;
  CompanyInfo.FieldByName('POState').asString := State.Text;
  CompanyInfo.FieldByName('POPostcode').asString := Postcode.Text;
  CompanyInfo.FieldByName('POCountry').asString := txtCountry.Text;
end;
function TfrmCompanyInformation.SiteCodeUnique: boolean;
var qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= MyConnection;
    qry.SQL.Add('select * from tblclass');
    qry.SQL.Add('where SiteCode = ' + QuotedStr(qryBranchCodeSiteCode.AsString));
    qry.SQL.Add('and Classname  <> ' + QuotedStr(qryColumnHeadings.Fieldbyname('DefaultClass').asString));
    qry.Open;
    result:= qry.IsEmpty;
  finally
    qry.Free;
  end;

end;

function  TfrmCompanyInformation.SaveData:Boolean;
begin
  result := False;
  if Trim(txtCompanyName.Text) = '' then begin
    CommonLib.MessageDlgXP_Vista('Company Name is a required entry', mtInformation, [mbOK], 0);
    SetControlFocus(txtCompanyName);
    Exit;
  end;

  if Empty(CompanyInfo.FieldByName('SetupID').AsString) then begin
    AddCompanyClass;
    Refresh;
  end;
  if Empty(self.qryBranchCodeSiteCode.AsString) then begin
    CommonLib.MessageDlgXP_Vista('Site Code is a required entry', mtInformation, [mbOK], 0);
    SetControlFocus(edtSiteCode);
    Exit;
  end;
  postDb(qryBranchCode);
  PostDB(qryColumnHeadings);

  if Empty(self.qryColumnHeadings.FieldByName('DefaultClass').AsString) then begin
    CommonLib.MessageDlgXP_Vista('Default Class is a required entry', mtInformation, [mbOK], 0);
    SetControlFocus(cboDefaultClass);
    Exit;
  end;
  if Empty(qryBranchCodeSiteCode.AsString) then begin
    CommonLib.MessageDlgXP_Vista('Site Code is a required entry', mtInformation, [mbOK], 0);
    SetControlFocus(edtSiteCode);
    Exit;
  end;

  if qryDepartments.Locate('ClassName' ,qryColumnHeadings.FieldByName('DefaultClass').AsString , []) then
    if qryDepartments.FieldByName('SiteCode').AsString = '' then begin
      EditDb(qryDepartments);
      qryDepartments.FieldByName('SiteCode').AsString:= qryBranchCodeSiteCode.AsString;
      PostDB(qryDepartments);
    end;

  if not SiteCodeUnique then begin
    CommonLib.MessageDlgXP_Vista('Site Code is Used by Another Class/ Department, Please Select a Unique Site Code', mtInformation, [mbOK], 0);
    SetControlFocus(edtSiteCode);
    Exit;
  end;

  if TDeptClass.SiteCodeForClass(qryColumnHeadings.FieldByName('DefaultClass').AsString,MyConnection) <> qryBranchCodeSiteCode.AsString then begin
    CommonLib.MessageDlgXP_Vista('Site Code does not Match the Site Code Currently Saved for Selected Class/ Department', mtInformation, [mbOK], 0);
    SetControlFocus(edtSiteCode);
    Exit;
  end;

(*  if Trim(edtFirstName.Text) = '' then
  begin
    MessageDlgXP_Vista('Owner''s First Name Is a Required Entry', mtInformation, [mbOk], 0);
    SetControlFocus(edtFirstName);
    exit;
  end;

  if Trim(edtLastName.Text) = '' then
  begin
    MessageDlgXP_Vista('Owner''s Last Name Is a Required Entry', mtInformation, [mbOk], 0);
    SetControlFocus(edtLastName);
    exit;
  end;

  if Trim(edtTitle.Text) = '' then
  begin
    MessageDlgXP_Vista('Owner''s Title Is a Required Entry', mtInformation, [mbOk], 0);
    SetControlFocus(edtTitle);
    exit;
  end;*)

  if Trim(edtEmail.Text) = '' then
  begin
    MessageDlgXP_Vista('Owner''s Email Is a Required Entry', mtInformation, [mbOk], 0);
    SetControlFocus(edtEmail);
    exit;
  end;

  EditDB(CompanyInfo);
  MakeContactName;
  PostDB(CompanyInfo);

  if qryDepartments.Locate('ClassName' ,qryColumnHeadings.FieldByName('DefaultClass').AsString , []) then
    if qryDepartments.FieldByName('SiteCode').AsString <> qryBranchCodeSiteCode.AsString then begin
      EditDb(qryDepartments);
      qryDepartments.FieldByName('SiteCode').AsString:= qryBranchCodeSiteCode.AsString;
      qryDepartments.Post;
    end;
  if CleanDefaultclass <> qryColumnHeadings.fieldByname('DefaultClass').asString then begin
      updateDefaultCalss(qryColumnHeadings.fieldByname('DefaultClass').asString, '' ,CleanDefaultclass , TERPConnection(qryDepartments.Connection));
  end;
  Result := True;
end;

procedure TfrmCompanyInformation.cmdCloseClick(Sender: TObject);
begin
  if not SaveData then exit;
  CommitTransaction;

  //CreateEmployee;

  Notify(False);
  AppEnv.Reset;
  if WasIndustry <> AppEnv.CompanyInfo.IndustryId then
    MainForm.TerminateApp
  else If (WasRegionID <> AppEnv.RegionalOptions.ID) then
    MainForm.TerminateApp
  else Begin
    if Assigned(MainSwitch2) then begin
        Application.Title := replaceStr(Application.Title, CleancompanyName , Trim(txtCompanyName.text));
        MainSwitch2.FormShow(nil);
    end;
    Self.Close;
  end;
end;

procedure TfrmCompanyInformation.edtSiteCodeExit(Sender: TObject);
begin
  inherited;
  if SiteCodeUnique then
    if qryDepartments.Active and (qryColumnHeadings.FieldByName('DefaultClass').AsString <> '') and
      (qryBranchCodeSiteCode.AsString <> '') and
      (qryDepartments.FieldByName('SiteCode').AsString <> qryBranchCodeSiteCode.AsString) then begin
      EditDb(qryDepartments);
      qryDepartments.FieldByName('SiteCode').AsString:= qryBranchCodeSiteCode.AsString;
      PostDB(qryDepartments);
    end;
end;

procedure TfrmCompanyInformation.AddCompanyClass;
var
  tempClassID: string;
begin
  qryInsert.SQL.Clear;
  qryInsert.SQL.Add('INSERT HIGH_PRIORITY INTO tblClass ( ClassName, EditedFlag, Active )');
  qryInsert.SQL.Add('VALUES (' + txtCompanyName.Text + ',"T","T")');
  qryInsert.Execute;
  qryInsert.SQL.Clear;
  tblColumnHeadings.Open;
  tempClassID := tblColumnHeadings.Lookup('ClassName', txtCompanyName.Text, 'ClassID');
  qryInsert.SQL.ADD('UPDATE tblColumnHeadings SET DefaultClass=' + txtCompanyName.Text);
  qryInsert.Execute;
  qryDepartments.Refresh;
end;


procedure TfrmCompanyInformation.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;

  procedure CheckSiteCode;
  var qry: TERPQuery;
  begin
    qry:= TERPQuery.Create(nil);
    try
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Text:= 'select * from tblmsbackendid';
      qry.Open;
      if qry.RecordCount = 0 then begin
        qry.Insert;
        qry.FieldByName('SiteCode').AsString:= 'DEF';
        qry.FieldByName('SiteDesc').AsString:= 'Default';
        qry.FieldByName('BEDefault').AsBoolean:= true;
        qry.Post;
      end;
      if not qry.Locate('BEDefault','T',[]) then begin
        if not qry.Locate('SiteCode','DEF',[]) then
          qry.First;
        qry.Edit;
        qry.FieldByName('BEDefault').AsBoolean:= true;
        qry.Post;
      end;
    finally
      qry.Free;
    end;
  end;

begin
  DisableForm;
  DoingFormShow:= true;
  try
    try
      inherited;
      qryDepartments.Open;
      CompanyInfo.ParamByName('KeyID').asInteger := 1;
      Setlength(QueryNamesNotToOpen, 1);
      QueryNamesNotToOpen[0] := 'Qryinsert';
      OpenQueries(QueryNamesNotToOpen);
      BeginTransaction;
      UserLock.Enabled := true;
      if UserLock.Lock('tblcompanyinformation' , 0) = False then begin
        AccessLevel := 5;
        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access will be changed to read-only.', mtWarning, [mbOK], 0);
      end else begin
        CompanyInfo.Edit;
        CheckSiteCode;
      end;
      qryRegions.Locate('Region',AppEnv.CompanyPrefs.CompanyRegion,[]);
      WasRegionID := AppEnv.RegionalOptions.ID;
      qryIndustries.Locate('IndustryId', AppEnv.CompanyInfo.IndustryId, []);
      cbIndustry.Text := qryIndustries.FieldByName('IndustryName').asString;
      WasIndustry := AppEnv.CompanyInfo.IndustryId;
      qryBranchCode.Locate('BEDefault','T',[]);
      cboRegion.Text:= AppEnv.CompanyPrefs.CompanyRegion;
      SetControlFocus(txtCompanyName);
      Makeitcentralized;
      cleancompanyName := Trim(txtCompanyName.text);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
    DoingFormShow:= false;
  end;  
end;

procedure TfrmCompanyInformation.chooseLogo(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    if  (QryCompanyLogo.recordcount =1) then
      case  MessageDlgXP_Vista('Company Logo', mtConfirmation, [mbCancel], 0, nil, '', '', False, nil, 'Remove Logo,Choose Anohter') of
        mrCancel: Exit;
        100: begin  QryCompanyLogo.delete; exit; end;
      end;

    SelectPicture(TPotCompLogo, self, QryCompanyLogo , QryCompanyLogoID.FieldName,  QryCompanyLogoCompLog.FieldName, False , QryCompanyLogoPictype.fieldname , true);
    closedb(QryCompanyLogo);
    opendb(QryCompanyLogo);
  finally
    EnableForm;
    application.ProcessMessages;
  end;

end;

procedure TfrmCompanyInformation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CompanyInfo.Close;
  qryInsert.Close;
  tblColumnHeadings.Close;
  qrySuburb.Close;
  Action := caFree;
  RollbackTransaction;
end;


procedure TfrmCompanyInformation.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Notify(True);
  Self.Close;
end;

procedure TfrmCompanyInformation.cmdCustomiseClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  if MessageDlgXP_Vista('Do you wish to save the current changes you have made? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  if not (SaveData) then exit;
  CommitTransaction;
  tmpComponent := GetComponentByClassName('TfrmCompanyInfoCustomise');
  If not Assigned(tmpComponent) then Exit;
  with TfrmCompanyInfoCustomise(tmpComponent) do begin
    KeyID     := CompanyInfoSetupID.AsInteger;
    ShowModal;
  end;
  BeginTransaction;
end;

procedure TfrmCompanyInformation.CommitTransaction;
begin
  inherited;
  Appenv.DefaultClass.PopulateMe;
  Appenv.Branch.PopulateMe;
end;

procedure TfrmCompanyInformation.CompanyInfoAfterOpen(DataSet: TDataSet);
begin
  inherited;
   closedb(QryCompanyLogo);
   Opendb(QryCompanyLogo);
end;

(*procedure TfrmCompanyInformation.CreateEmployee;
var
  qry : TERPQuery;
  cid,
  EID : Integer;

  function DoUpdateInfoTable : boolean;
  begin
    Result := false;
    qry.SQL.Text := 'select E.EmployeeId, C.EmployeeId'#13#10+
                      'from tblEmployees E'#13#10+
                      'inner join tblcompanyinformation C on trim(C.FirstName)=trim(E.FirstName) and trim(C.LastName)=trim(E.LastName)';
    qry.Open;
    if qry.RecordCount = 1 then
    begin
      // There is employee with the same First Name/Last name
      eid := qry.Fields[0].AsInteger;
      cid := qry.Fields[1].AsInteger;
      if (cid = 0) or (cid <> eid) then
      begin
        qry.Close;
        // CompanyInformation contains only 1 record
        qry.SQL.Text := 'update tblCompanyInformation set EmployeeId = ' + IntToStr(eid);
        qry.ExecSQL;
      end;
      Result := true;
    end;

    if Result then
    begin
      // Update tblGoLive
      qry.Close;
      qry.sql.Text :=
                      Format('insert into tblGoLiveModules(GoLiveId, EmployeeId) '#13#10 +
                      'select distinct GL.GoLiveId, %d from tblGoLive GL'#13#10+
                      'where GL.StepType in (0,3) and'#13#10+
                      'not exists(select * from tblGoLiveModules inner join tblGoLive on tblGoLive.GoLiveId=tblGoLiveModules.GoLiveId where tblGoLiveModules.EmployeeId=%d)',
                      [eid,eid]);
      qry.ExecSQL;
    end;
  end;

begin
  qry := TERPQuery.Create(self);
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.Connection.StartTransaction;
    try
      {
      if CompanyInfo.FieldByName('EmployeeId').AsInteger = 0  then
      begin
        DoUpdateInfoTable();
        exit;
      end;
      }
      if DoUpdateInfoTable() then
        exit;


      if qry.RecordCount = 0 then
      begin
        // have not found employee with the same first/last name
        qry.Close;
        qry.sql.text := 'insert into tblEmployees (FirstName, LastName, Title, EmployeeName, email)';
        qry.sql.add('values(');
        qry.sql.add(Format('"%s", "%s", "%s", "%s", "%s")',
                    [CompanyInfo.FieldByName('FirstName').asString,
                     CompanyInfo.FieldByName('LastName').asString,
                     CompanyInfo.FieldByName('Title').asString,
                     Trim(CompanyInfo.FieldByName('FirstName').asString) + ' ' + Trim(CompanyInfo.FieldByName('LastName').AsString),
                     CompanyInfo.FieldByName('email').asString]));
        qry.Prepared := true;
        qry.ExecSQL;
        qry.Close;
        DoUpdateInfoTable;
        exit;
      end;
      MessageDlgXP_Vista('You have ' + intToStr(qry.RecordCount) + ' Employees With the Name'#13#10 +
          CompanyInfo.FieldByName('FirstName').asString + ' ' + CompanyInfo.FieldByName('LastName').asString +
          #13#10'The Owner Will Not Be Automatically Added To The GoLive Training', mtInformation, [mbOk], 0);
    except
      if qry.Connection.InTransaction  then
        qry.Connection.Rollback;
    end;

//    qry.SQL.Text := 'select
  finally
    if qry.Connection.InTransaction  then
      qry.Connection.Commit;
    qry.Free;
  end;
end;*)

procedure TfrmCompanyInformation.FormCreate(Sender: TObject);
begin
  inherited;
  tblColumnHeadings.Connection := MyConnection;
  btnUpdateAllGlobalrefs.visible := Devmode;
  fsPublishonVS1tablename:= '';
end;

procedure TfrmCompanyInformation.SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    FillTable.FieldByName('State').asString    := LookupTable.FieldByName('State').asString;
    FillTable.FieldByName('Postcode').asString := LookupTable.FieldByName('Postcode').asString;
    FillTable.FieldByName('Country').asString  := LookupTable.FieldByName('Country').asString;
  end;
end;

procedure TfrmCompanyInformation.Suburb2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    FillTable.FieldByName('POState').asString    := LookupTable.FieldByName('State').asString;
    FillTable.FieldByName('POPostcode').asString := LookupTable.FieldByName('Postcode').asString;
    FillTable.FieldByName('POCountry').asString  := LookupTable.FieldByName('Country').asString;
  end;
end;

procedure TfrmCompanyInformation.SuburbEnter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

procedure TfrmCompanyInformation.Suburb2Enter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

procedure TfrmCompanyInformation.txtFaxNumberExit(Sender: TObject);
begin
  inherited;
  if char_length(Trim(twwDbEdit(Sender).Text)) < 10 then begin
    CommonLib.MessageDlgXP_Vista(SeparateWords(twwDbEdit(Sender).DataField) + ' is incomplete.', mtWarning, [mbOK], 0);
    SetControlFocus(twwDbEdit(Sender));
    twwDbEdit(Sender).SelectAll;
  end;
end;

procedure TfrmCompanyInformation.qrySuburbBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySuburb.ParamByName('xRegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmCompanyInformation.lblCountryDblClick(Sender: TObject);
begin
  inherited;
  cboRegion.Visible := True;
end;

procedure TfrmCompanyInformation.MakeContactName;
begin
  if CompanyInfoContact.asString <> Trim(CompanyInfoFirstName.asString) +' ' + trim(CompanyInfoLastName.asString) then begin
    EditDB(CompanyInfo);
    CompanyInfoContact.asString := Trim(CompanyInfoFirstName.asString) +' ' + trim(CompanyInfoLastName.asString);
  end;
end;

procedure TfrmCompanyInformation.cboRegionCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  DoCountryChange;
  AppEnv.CompanyPrefs.CompanyRegion := cboRegion.Text;
end;

(*procedure TfrmCompanyInformation.edtFirstNameExit(Sender: TObject);
begin
  inherited;
  MakeContactName;
end;*)

procedure TfrmCompanyInformation.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  chooseLogo(Sender);
end;

procedure TfrmCompanyInformation.DoCountryChange;
begin

    if AppEnv.CompanyPrefs.CompanyRegion = cboRegion.Text then Exit;
    With TERPScript.Create(Self) do try
        connection := MyConnection;
        SQL.add('TRUNCATE tblforeigncurrencyonreport;');
        Execute;
    finally
        Free;
    end;
end;
procedure TfrmCompanyInformation.SuburbNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
var
  form: TBaseInputGUI;
begin
  inherited;
  Accept:= false;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    form:= TBaseInputGUI(GetComponentByClassName('TfrmLocation',false));
    if Assigned(form) then begin
      form.KeyID:= 0;
      SetStrProp(form,'NewSuburb',NewValue);
      form.AttachObserver(self);
      form.ShowModal;
      if LookupTable.Locate('City_sub',NewValue,[loCaseInsensitive]) then begin
        CompanyInfoCity.AsString:= NewValue;
        SuburbCloseUp(Suburb,LookupTable,Suburb.DataSource.DataSet,true);
        Accept:= true;
      end;
    end;
  end;
end;

procedure TfrmCompanyInformation.UpdateGlobalRefWithcurrentSiteCode;
var
  TransactionTableObj : TTransactionTableObj;
begin
      TransactionTableObj := TTransactionTableObj.Create(False);
      try
        TransactionTableObj.UpdateGlobalRefWithcurrentSiteCode;
      finally
        FreeandNil(TransactionTableObj);
      end;
end;

procedure TfrmCompanyInformation.UpdateMe(const Cancelled: boolean;
  const aObject: TObject);
begin
  inherited;
  if Assigned(aObject) then
    if aObject.ClassNameIs('TfrmLocation') then
      qrySuburb.Refresh
    else if aObject.ClassNameIs('TfrmEmployee') then begin
      cboEmployeeLookup.Refresh;
      if TfrmEmployee(aObject).qryemployeeEmployeeID.asInteger <> 0 then
        if cboEmployeeLookup.Locate('employeeId' ,TfrmEmployee(aObject).qryemployeeEmployeeID.asInteger, []) then begin
          try
              editdb(CompanyInfo);CompanyInfoContactName.asString :=TfrmEmployee(aObject).qryemployeeEmployeename.asString;
              editdb(CompanyInfo);CompanyInfoEmployeeId.asInteger :=TfrmEmployee(aObject).qryemployeeEmployeeID.asInteger;
              Postdb(CompanyInfo);
              editdb(CompanyInfo);
          Except
          end;
        end;
    end;
end;

procedure TfrmCompanyInformation.Suburb2NotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
var
  form: TBaseInputGUI;
begin
  inherited;
  Accept:= false;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    form:= TBaseInputGUI(GetComponentByClassName('TfrmLocation',false));
    if Assigned(form) then begin
      form.KeyID:= 0;
      SetStrProp(form,'NewSuburb',NewValue);
      form.AttachObserver(self);
      form.ShowModal;
      if LookupTable.Locate('City_sub',NewValue,[loCaseInsensitive]) then begin
        CompanyInfoPOCity.AsString:= NewValue;
        Suburb2CloseUp(Suburb2,LookupTable,Suburb2.DataSource.DataSet,true);
        Accept:= true;
      end;
    end;
  end;
end;

procedure TfrmCompanyInformation.cboDefaultClassChange(Sender: TObject);
begin
  inherited;
  if DoingFormShow then exit;
  if qryBranchCode.Active then begin
    EditDb(qryBranchCode);
    qryBranchCodeSiteCode.AsString:= qryDepartments.FieldByName('SiteCode').AsString;
    qryBranchCodeSiteDesc.AsString:= qryDepartments.FieldByName('ClassName').AsString;
  end;
end;

procedure TfrmCompanyInformation.cboEmployeeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  CompanyInfoFirstName.asString :=   cboEmployeeLookupFirstname.asString;
  CompanyInfoLastName.asString :=    cboEmployeeLookupLastname.asString;
  CompanyInfoEmployeeId.asInteger :=   cboEmployeeLookupEmployeeID.asInteger;
  PostDB(CompanyInfo);
  EditDB(CompanyInfo);
end;

procedure TfrmCompanyInformation.qryBranchCodeSiteCodeSetText(
  Sender: TField; const Text: String);
begin
  inherited;
  Sender.AsString:= Uppercase(Text);
end;

procedure TfrmCompanyInformation.QryCompanyLogoAfterScroll(DataSet: TDataSet);
begin
  inherited;
  try
    ImagesLib.RefreshDsImage(QryCompanyLogo, 'CompLog', '' , imgcompanyLogo,  nil , nil);
  Except
    // kill exception
  end;
end;

procedure TfrmCompanyInformation.qryBranchCodeAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  if qryBranchCode.recordcount = 0 then
    qryBranchCodeSiteCode.asString := 'DEF';
end;

procedure TfrmCompanyInformation.btnEmailConfigClick(Sender: TObject);
var
  Config: TEmailConfig;
begin
  inherited;
  Config := TEmailConfig.Create(nil);
  try
    Config.Connection := TMydacDataConnection.Create(Config);
    Config.Connection.Connection := MyConnection;
    Config.LoadSelect('EntityName = "Company"');
    if Config.Count = 0 then begin
      Config.New;
      Config.EntityName := 'Company';
      Config.PostDb;
    end;
    if not SameText(edtEmail.Text,Config.EmailAddress) then begin
      Config.EmailAddress := edtEmail.Text;
      Config.PostDb;
    end;

    if frmEmailConfig2.DoEmailConfig(Config) then begin

      if not SameText(edtEmail.Text,Config.EmailAddress) then
        edtEmail.Text := Config.EmailAddress;
      if not Config.ConfigValid then
        chkTrackEmails.Checked := false;
    end;

  finally
    Config.Free;
  end;
end;

procedure TfrmCompanyInformation.btnUpdateAllGlobalrefsClick(Sender: TObject);
begin
  inherited;
  UpdateGlobalRefWithcurrentSiteCode;
end;

procedure TfrmCompanyInformation.cbIndustryCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  AppEnv.CompanyInfo.IndustryId := qryIndustries.FieldByName('IndustryId').AsInteger;
  CompanyInfoIndustryId.asInteger := qryIndustries.FieldByName('IndustryId').AsInteger;
end;


procedure TfrmCompanyInformation.cboDefaultClassBeforeDropDown(
  Sender: TObject);
begin
  inherited;
  CleanDefaultclass := qryColumnHeadings.fieldByname('DefaultClass').asString;
end;


procedure TfrmCompanyInformation.PublishonVS1;
var
  cmd :TERPCommand;
begin
  inherited;
  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    cmd.SQL.Text := TNewDbUtils.PublishTablesOnVS1(MyConnection, AppEnv.CompanyPrefs.CompanyRegion, True);

    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;


procedure TfrmCompanyInformation.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;

  ProcessingCursor(true);
  try
    TNewDbUtils.InitEmployee(MyConnection, '', nil, False);
    PublishonVS1;
  finally
    ProcessingCursor(False);
    MessageDlgXP_vista('Upgraded to VS1 Database', mtInformation, [mbOK], 0);
  end;
end;


initialization

  RegisterClassOnce(TfrmCompanyInformation);

end.

