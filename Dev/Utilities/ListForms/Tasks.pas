unit Tasks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox, ERPdbComponents, EmailExtraUtils, wwradiogroup,
  wwclearbuttongroup, GIFImg;

type

  TTasksGUI = class(TBaseListingGUI)
    qryMainTasktype: TWideStringField;
    qryMainVersionNo: TWideStringField;
    qryMainCreatedOn: TDateTimeField;
    qryMainEnteredBy: TWideStringField;
    qryMainSubject: TWideStringField;
    qryMainDetails: TWideMemoField;
    qryMainEstimatedHrs: TFloatField;
    qryMainPercentagedone: TFloatField;
    qryMainmstimeStamp: TDateTimeField;
    qryMainID: TLargeintField;
    btnUpdate: TDNMSpeedButton;
    qryMainActive: TWideStringField;
    qryMainClientCode: TWideStringField;
    qryMaincatg: TLargeintField;
    qryMainSeqno: TIntegerField;
    grpExtraFilters: TwwRadioGroup;
    qryMainTaskno: TLargeintField;
    cmdEmail: TDNMSpeedButton;
    qryMainCustomerName: TWideStringField;
    bvlExtraFilters: TBevel;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure cmdEmailClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    fEmailText: string;
    fEmailMode: TSendEmailMode;
    fEmailTemplate: string;


    procedure initTasksforVer(Sender: TObject);
//    function PrepareMailText(aMode : TSendEmailMode) : string;
    procedure PopulateMailTExt(const AName : string);//, ADateTime :

  Protected
    Procedure RefreshQuery; override;
    procedure SetGridColumns; override;
    function GetReportTypeID : integer;override;
    function Email_body : string; override;
    property EmailText : string read fEmailText write fEmailText;
    property EmailMode :TSendEmailMode read fEmailMode write fEmailMode;
    property EmailTemplate : string read fEmailTemplate write fEmailTemplate;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
    procedure InitWwRadioGroup(Sender : TwwRadioGroup); override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, CommonFormLib, ERPLib, ERPDocsDBObj, AppEnvironment,
  frmTasksforVer, DbSharedObjectsObj, tcDataUtils , tcConst, BusObjEmailConfig,
  frmEmailReferenceTask, TasksEmailMessage, Vista_MessageDlg;

{$R *.dfm}

procedure TTasksGUI.btnUpdateClick(Sender: TObject);
var
  ERPDocsDB : TERPDocsDB;
begin
  inherited;
    ERPDocsDB := TERPDocsDB.Create;
    try
      ERPDocsDB.Server := appEnv.AppDb.Server;
      ERPDocsDB.ERPDatabase := appEnv.AppDb.Database;
      DoShowProgressbar(10, WAITMSG , '' , False , TRue);
      try
          ERPDocsDB.UploadTasks;
      finally
        DoHideProgressbar;
      end;
      MessageDlgXP_Vista('Your changes are uploaded', mtInformation, [mbOK], 0);
    finally
      FreeandNil(ERPDocsDB);
    end;
end;

procedure TTasksGUI.cmdEmailClick(Sender: TObject);
var
  fsIds:String;
  s : string;
  Qry1,
  Qry : TERPQuery;
  MailsToSend : integer;
  lCount : integer;
//  lEmailConfig : TEmailConfig;
  lForm : TfrmTasksEmailMessage;
  lProgress : TProgressDialog;
begin
  inherited;
  if grdmain.SelectedList.Count =0 then begin
    MessageDlgXP_vista('Please Choose The entries to be Emailed', mtInformation, [mbOK], 0);
    Exit;
  end;

  fsIds:= SelectedIds('ID');
  if fsIds = '' then begin
    MessageDlgXP_vista('Please Choose The entries to be Emailed', mtInformation, [mbOK], 0);
    Exit;
  end;


  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Qrymain.Connection);
  try
    //  Check email configuration
    qry.sql.text := 'Select Distinct concat(ifnull(FirstName,""), " ", ifNull(LastName, "")) as ClientName, ifnull(FirstName, "") as FirstName'#13#10 +
                    'from tblclients where ifnull("clientCode", "")<> "" and'#13#10+
                    'clientCode in (Select distinct clientCode   from tbltasks   where ifnull("clientCode", "")<> ""   and'#13#10+
                    'ID in (' + fsIds + ')) and ifnull(email, "") = ""';
    qry.Open;

    lCount := qry.RecordCount;

    s := '';

    if lCount > 0 then
    begin
      while not qry.eof do
      begin
        if s = '' then
          s := qry.Fields[0].asString
        else
          s := s + ', ' + qry.Fields[0].asString;
        qry.Next;
      end;
    end;

    qry.Close;

    Qry.sql.text := 'Select Distinct clientId , clientCode , Email, ifnull(FirstName, "") as FirstName '+
                    ' from tblclients where ifnull("clientCode", "")<> "" and  '+
                    ' clientCode in (Select distinct clientCode  '+
                                      ' from tbltasks  '+
                                      ' where ifnull("clientCode", "")<> ""  '+
                                      ' and ID in (' + fsIds+')) and ifnull(email, "") <> "" order by clientCode';
    Qry.open;

    if lCount > 0 then
    begin
      lForm := TfrmTasksEmailMessage.Create(nil);
      try
        lForm.TaskIds := fsIds;
        lForm.ShowModal;
      finally
        lForm.Free;
      end;
    end;

    if Qry.recordcount =0 then begin
      MessageDlgXP_vista('None of the Selected Records are linked to Any customer.'#13#10#13#10'Please Choose Entries Linked to Customer to Email.', mtInformation, [mbOK], 0);
//      Exit; - Anyway will send secret mails
    end;

    if qry.RecordCount > 0 then
    begin

    (*
      lEmailConfig := TEmailConfig.CreateWithSharedConn(nil);
      if AppEnv.Employee.UseEmpEmailAsFromAddress then
        lEmailConfig.LoadSelect('EntityName = ' + QuotedStr(AppEnv.Employee.EmployeeName))
      else
        lEmailConfig.LoadSelect('EntityName = "Company"');
      try
        if SameText(lEmailConfig.IntegrationType, 'Email Client') then
        begin
          lCount := MessageDlgXPEx('The Program Set Up To Use Your Local Email Client. It Means You Will Get ' + IntToStr(qry.RecordCount) +
                             ' Email Pop-Ups.'#13#10'Do You Want To', mtWarning,
                              [mbYes, mbNo, mbOk, mbRetry, mbIgnore], ['Send', 'Edit && Send', 'Silent', 'Edit && Silent','Cancel']);
          case lCount  of
            mrYes : EmailMode := smSend;
            mrNo : EmailMode := smSendEdit;
            mrOK : EmailMode := smSilent;
            mrRetry : EmailMode := smSilentEdit;
            mrIgnore :exit;  // Actually Cancel...
          end;
        end
        else
        begin
          case MessageDlgXPEx('Do You Want To Edit Email Or Send It As It Is?', mtWarning,
                               [mbOk, mbNo, mbCancel], ['Send', 'Edit', 'Cancel']) of
            mrOk : EmailMode := smSilent;
            mrNo : EmailMode := smSilentEdit;
            mrCancel : exit;
          end;
        end;
      finally
        lEmailConfig.Free;
      end;
      *)
    end;
    EmailMode := EmailSendMode(qry.RecordCount, true, fiEmailMsgOption,  not(chkShowEmailOptions.checked),DoOnDoNotAskMsgCheck);
    if EmailMode = smNone then
      exit;

    EmailTemplate := PrepareMailText(EmailMode, 'Task');


    qry1 := DbSharedObjectsObj.DbSharedObj.GetQuery(Qrymain.Connection);
    lProgress := DoShowNewProgressbar(qry.RecordCount + 1, 'Sending Emails', '', false);
    try
      qry1.SQL.Text := 'SELECT * from tblEmailForwards where Task like "Tasks"';
      qry1.Open;
      MailsToSend := qry.RecordCount;
      Qry.first;
      ReportSQLSupplied := false;
      While Qry.EOF = False do begin
        if Qry.fieldbyname('Email').asString <> '' then
        begin
          DoStepProgressBar(lProgress, 'Mail To: ' + Qry.fieldbyname('Email').asString);
          AddresstoEmail := Qry.fieldbyname('Email').asString;
          PopulateMailText(qry.FieldByName('FirstName').asString);
          ReportToPrint := 'ERP Tasks';
          TemplateSQL := '~|||~Where T.clientCode =  ' + Quotedstr(Qry.fieldbyname('clientCode').asString) +' and T.Id in (' +fsIds+') Order by T.msTimeStamp';
          case EmailMode of
            smSend, smSendEdit    : LoadTemplate(False,False , False, true, true, false);
            smSilent,smSilentEdit : LoadTemplate(False,False , False, true, true, true);  // Email, silent
          end;
        end;
        Qry.Next;
      end;

      // Message - just to say something while sending secret mails
      DoStepProgressBar(lProgress, 'Closing connections...');
      qry1.First;
      while not qry1.eof do
      begin
        // All selected tasks, does not matter whether there is email address or not
        TemplateSql := '~|||~Where T.Id in (' +fsIds+') Order by T.msTimeStamp';
        AddressToEmail := qry1.FieldByName('Email').AsString;
        PopulateMailText(qry1.FieldByName('Name').AsString);
        ReportToPrint := 'ERP Tasks';
        LoadTemplate(False,False , False, true, true, true);
        qry1.Next;
      end;

      if MailsToSend > 0 then
        if MailsToSend = 1 then
          MessageDlgXP_vista('1 Email Has Been Sent To The Customer.', mtInformation, [mbOK], 0)
        else
          MessageDlgXP_vista(IntToStr(MailsToSend) + ' Emails Have Been Sent to The Customers.', mtInformation, [mbOK], 0);
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry1);
        DoHideProgressBar(lProgress);
      end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;

procedure TTasksGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmTasks' , 0);
end;
function TTasksGUI.Email_body: string;
begin
  if EmailText <> '' then
    REsult := EmailText
  else
      Result := 'Task Email';
end;

procedure TTasksGUI.FormCreate(Sender: TObject);
begin
  inherited;
  BaseIndexfields :='versionno DESC,seqno,catg';
  fbhideIDFields := not IsERPCustomEnabled;
  fbHideSitefields := True;
  btnUpdate.Visible := IsERPCustomEnabled;

  if IsERPCustomEnabled  then begin
    EnableMultiSelect('Select Items to Email');
    cmdEmail.enabled := True;
    grdMain.Options := grdMain.Options - [dgRowSelect];
  end else begin
    cmdEmail.enabled := False;
  end;
end;

procedure TTasksGUI.FormResize(Sender: TObject);
begin
  inherited;
  bvlExtraFilters.Width := grpExtraFilters.Width;
end;

procedure TTasksGUI.FormShow(Sender: TObject);
begin
  inherited;
  bvlExtraFilters.Left := 0;
  bvlExtraFilters.Top := 0;
  bvlExtraFilters.Width := grpExtraFilters.Width;
  bvlExtraFilters.Height := grpExtraFilters.Height;
end;

function TTasksGUI.GetReportTypeId: integer;
begin
  result := TemplateTypeID('ERP Tasks')
end;

procedure TTasksGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (Qrymaincatg.asInteger =1)  then begin
    AFont.Style := Afont.style +[fsbold];
    if SameText(Field.Fieldname, 'Versionno') then else AFont.color := ABrush.color;
  end;
end;

procedure TTasksGUI.initTasksforVer(Sender: TObject);
begin
  if not(Sender is TfmTasksforVer) then exit;
  TfmTasksforVer(Sender).VersionNo := Qrymainversionno.AsString;
end;

procedure TTasksGUI.InitWwRadioGroup(Sender: TwwRadioGroup);
begin
  inherited;

//  Sender.ShowGroupCaption := true;
//  Sender.Caption := ' ';
//  grpFilters.ShowGroupCaption := true;
//  grpExtraFilters.ShowGroupCaption := true;
//  bvlExtraFilters.Left := 0;
//  bvlExtraFilters.Top := 0;
//  bvlExtraFilters.Width := grpExtraFilters.Width;
//  bvlExtraFilters.Height := grpExtraFilters.Height;
end;

procedure TTasksGUI.PopulateMailTExt(const AName: string);
begin
  if EmailTemplate='' then
    EMailText := 'Task Email'
  else
  begin
    EMailText := replacestr(EmailTemplate , '»'+CORRESPONDENCE_FIELD1+'«' , AName);
    EMailText := replacestr(EMailText , '»'+CORRESPONDENCE_FIELD2+'«' , '');
  end;
end;
(*
function TTasksGUI.PrepareMailText(aMode: TSendEmailMode): string;
var
  Form : TfmEmailReferenceTask;
begin
  case aMode of
    smSend: begin  // Send without editing - default mail text
       Result := 'Task';
      end;
    smSilentEdit,
    smSendEdit: begin  // Select Reference
      form := TfmEmailReferenceTask.Create(Self);
      try
        if Form.ShowModal=mrOk then
        begin
          EmailTemplate := Form.EmailTemplate;
        end;
      finally
        form.Free;
      end;
      end;
    smSilent: begin

      end;
  end;
end;
*)
procedure TTasksGUI.grdMainDblClick(Sender: TObject);
var
  id:Integer;
begin
  if sametext(Activefieldname , qrymainversionno.FieldName) and (Qrymainversionno.AsString <> '') then begin
    id := qryMainID.AsInteger;
    OpenERPFormModal('TfmTasksforVer' , 0 , initTasksforVer);
    closedb(Qrymain);
    opendb(Qrymain);
    Qrymain.Locate('ID' , ID , []);
    Exit;
  end;
  inherited;
end;

procedure TTasksGUI.grpFiltersClick(Sender: TObject);
var
  s:String;
begin
  InitGroupfilterString('Active' , ['T','F','']);
  s:= '';
  if  grpExtrafilters.ItemIndex >= 7 then
  else if  grpExtrafilters.ItemIndex = 0 then s := ' tasktype ='+Quotedstr('Bug') +' or tasktype ='+Quotedstr('Feature')
  else s := ' tasktype =' + quotedstr(trim(grpExtrafilters.items[grpExtrafilters.itemindex]));
  if s<> '' then begin
    if GroupfilterString <> '' then GroupfilterString  := '(' + GroupfilterString  +') and ';
    GroupfilterString  := GroupfilterString  +' (' + s+')';
  end;
  inherited;
//  RefreshQuery;
end;

procedure TTasksGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainmstimeStamp.DisplayFormat := FormatSettings.ShortdateFormat +'  hh:nn am/pm';
  qryMainCreatedOn.Displayformat := FormatSettings.ShortdateFormat +'  hh:nn am/pm';
end;

procedure TTasksGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('grpExtrafilters') then
    grpExtrafilters.ItemIndex := GuiPrefs.Node['grpExtrafilters.ItemIndex'].asInteger
  else
    grpExtrafilters.ItemIndex := grpExtrafilters.Items.Count -1;

  if GuiPrefs.Node.Exists('chkIgnoreDates') then
    chkIgnoreDates.Checked := GuiPrefs.Node['chkIgnoreDates.Checked'].asBoolean;

end;

procedure TTasksGUI.RefreshQuery;
begin
(*  qryMain.ParamByName('DateFrom').AsDateTime := FilterDateFrom;
  qryMain.ParamByName('Dateto').AsDateTime := FilterDateTo;
  case grpFilters.ItemIndex of
    0: qryMain.ParamByName('Active').AsString := 'T';
    1: qryMain.ParamByName('Active').AsString := 'F';
    else qryMain.ParamByName('Active').AsString := '';
  end;*)
  InitDateFromnDateto;
  inherited;
end;

procedure TTasksGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymainseqno.FieldName);
  RemoveFieldfromGrid(Qrymaincatg.FieldName);
//  if not IsERPCustomEnabled then
//    RemoveFieldfromGrid(QrymainID.FieldName)
//  else
//    AddFieldtoGrid(QrymainID.FieldName);
end;

procedure TTasksGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['grpExtrafilters.ItemIndex'].asInteger := grpExtrafilters.ItemIndex;
  GuiPrefs.Node['chkIgnoreDates.Checked'].asBoolean := chkIgnoreDates.Checked;
end;

initialization
  RegisterClassOnce(TTasksGUI);

end.

