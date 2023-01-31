{$I ERP.inc}
unit BaseTemplateForm;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 25/05/05  1.00.01 BJ  'Raise exception' is changed to MessageDlg for user messages


{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons, DNMSpeedButton,  db, BaseInputForm,
  ExtCtrls, DNMPanel, wwcheckbox, Grids, DBGrids,
  Wwdbigrd, Wwdbgrid, AppEvnts, wwdbedit, Wwdotdot, Wwdbcomb, wwdblook,
  SelectionDialog, ImgList, DBAccess, MyAccess,ERPdbComponents, MemDS, DataState, Menus,
  AdvMenus, Shader, IntegerListObj, ppVar, ppBands, ppStrtch, ppCTMain,
  ppPrnabl, ppClass, ppCtrls, ppCache, ppComm, ppRelatv, ppProd, ppReport,
  ProgressDialog , frmAttachments;

type
  TBaseTemplateGUI = class(TBaseInputGUI)
    dsTemplates: TDataSource;
    pnlSQL: TDNMPanel;
    mmoSQL: TDBMemo;
    Label3: TLabel;
    Label1: TLabel;
    edName: TDBEdit;
    lbltype: TLabel;
    pnlMain: TDNMPanel;
    btnSave: TDNMSpeedButton;
    bbCancel: TDNMSpeedButton;
    btnDesigner: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    grdTemplates: TwwDBGrid;
    btnSQLHelper: TDNMSpeedButton;
    btnView: TDNMSpeedButton;
    cboType: TwwDBLookupCombo;
    dsTypes: TDataSource;
    btnExport: TDNMSpeedButton;
    SaveDialog1: TSaveDialog;
    imgPopup: TImageList;
    mmoDTSQL: TDBMemo;
    Label44: TLabel;
    Label54: TLabel;
    edtSearch: TEdit;
    Label4: TLabel;
    Bevel1: TBevel;
    qryTypes: TERPQuery;
    qryTemplates: TERPQuery;
    qryTemplatesTemplName: TWideStringField;
    qryTemplatesTemplID: TIntegerField;
    qryTemplatesTypeName: TWideStringField;
    qryTemplatesTemplateClass: TWideStringField;
    qryTemplatesSQLString: TWideMemoField;
    qryTemplatesDesignTimeSQLString: TWideMemoField;
    qryTemplatesEmployeeID: TIntegerField;
    qryTemplatesEditable: TWideStringField;
    qryTemplatesDefaultTemplate: TWideStringField;
    qryTemplatesTypeID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryTemplatesReportOnFc: TWideStringField;
    Label5: TLabel;
    qryTemplatesGlobalref: TWideStringField;
    qryTemplatesActive: TWideStringField;
    qryReport: TERPQuery;
    qryReportTemplID: TIntegerField;
    qryReportReport: TBlobField;
    qryReportGlobalref: TWideStringField;
    chkEditable: TwwCheckBox;
    qryTemplatesmstimestamp: TDateTimeField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure bbCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDesignerClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSQLHelperClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure ExportFromDB;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grdTemplatesCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure grdTemplatesCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure grdTemplatesDblClick(Sender: TObject);
    procedure grdTemplatesTitleButtonClick(Sender: TObject; const AFieldName: string);
    procedure qryTemplatesAfterScroll(DataSet: TDataSet);
    procedure qryTemplatesDefaultTemplateChange(Sender: TField);
    procedure qryTemplatesTypeIDChange(Sender: TField);
    procedure SaveToDB;
    procedure FormCreate(Sender: TObject);
    procedure qryTemplatesAfterPost(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure qryReportAfterPost(DataSet: TDataSet);
    procedure qryTemplatesAfterInsert(DataSet: TDataSet);
    procedure qryTemplatesBeforePost(DataSet: TDataSet);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Label54DblClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure mmoSQLDblClick(Sender: TObject);
    procedure mmoDTSQLDblClick(Sender: TObject);
  private
    DoingAfterPost: boolean;
    UpdatedIdList: TIntegerList;
    Exporting:boolean;
    function RetrieveFileFromBlob: TMemoryStream;
    procedure CopyDefaultFileToBLOB(const DefFile: string);
    procedure DeleteTemplates(const TemplateID: integer);
    procedure EnableDisableControls;
    function EmailedTemplatesOK: Boolean;
    Procedure AddFCFields(TemptypeID:Integer; QuerySeqno :Integer; Const QuerySQL :TStringList);
    procedure DoAudit;
    procedure OpenReportBlob(aId: integer = 0);
    function ValidateData: boolean;
    function Attachmentform: TfmAttachments;
  protected
    { Protected declarations }
  public
    { Public declarations }
  end;


implementation

uses FastFuncs,StrUtils, DNMLib, DNMExceptions,  SQLHelperForm,
  (*TemplatesFrm,*) frmExportTemplatesFrm,  MyClasses,
  CommonLib, ppTypes, AppEnvironment, QueryManipulationObj,
  BusObjFCOnReport, BusObjClass, GraphUtil, ReportTemplates, BusObjCurrency,
  StreamUtils, BusObjAudit, CommonDbLib, SysInfo, ReportBuilderUtils, SystemLib, LogLib,
  MemoDialog, tcConst, TemplateReportsLib, PrintTemplateBaseObj;

const
  HIGHLIGHTLOCATEDEF = $00DFFFFE;  // a very light yellow rw

  {$R *.DFM}
function TBaseTemplateGUI.Attachmentform: TfmAttachments;
begin
  result := nil;
  if qryTemplatesTemplID.AsInteger < 1 then Exit; // need POID
  result := TfmAttachments(GetComponentByClassName('TfmAttachments', true, self));
  if Assigned(result) then begin
    result.DBConnection := Self.MyConnection;
    result.AttachObserver(Self);
    result.TableName := 'tbltemplates';
    result.TableId   := qryTemplatesTemplID.AsInteger;
    (*if fsModal in self.FormState then begin
    end else begin
        result.FormStyle := fsMDIChild;
        result.BringToFront;
    end;*)
  end;
end;
procedure TBaseTemplateGUI.btnSaveClick(Sender: TObject);
begin
  if not ValidateData then exit;
  try
    If not EmailedTemplatesOK then Begin
      CommonLib.MessageDlgXP_Vista('Emailed Reports Require Date Parameters In The ''WHERE'' Clause.'+#13+#10+''+#13+#10+'(e.g WHERE Date Between :xDateFrom AND :xDateTo )', mtInformation, [mbOK], 0);
      Exit;
    end;
    DoAudit;
    CommitTransaction;
    RemoveXDesignSql;
    {$IFDEF DevMode}
    if not Exporting then CloseIt(true);
    {$ELSE}
    CloseIt(true);
    {$ENDIF}
  except
    on EAbort do HandleEAbortException;
    on e: ESQLError do begin
      CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
      SetControlFocus(mmoSql);
    end;
    on e: ERequiredFieldEmpty do begin
      CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
      SetControlFocus(edName);
    end;
  end;
end;

procedure TBaseTemplateGUI.bbCancelClick(Sender: TObject);
begin
  RollbackTransaction;
  Close;
end;

procedure TBaseTemplateGUI.FormShow(Sender: TObject);
begin
  try
    chkEditable.visible := devmode;
    if not UserLock.Lock('tbltemplates', -1, 'Customise Templates') then begin
      AccessLevel := 6; // read only
      EnableDisable;
      CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + GetFormDescription(Self.ClassName) +
        ' Access is Denied.', mtWarning, [mbOK], 0);
    end;
    inherited;
    TitleLabel.Caption    := ReplaceStr(Self.Caption, AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel), '');
    btnDesigner.Enabled := (AccessLevel in [1, 2, 3]);
    btnDelete.Enabled   := (AccessLevel = 1);
    btnNew.Enabled      := (AccessLevel <> 5);
    btnSave.Enabled     := (AccessLevel <> 5);
    if qryTemplates.Active then begin
      if not (qryTemplates.State in [dsBrowse]) then begin
        qryTemplates.Post;
      end;
      CloseQueries;
    end;
    BeginTransaction; // starting transaction prior opening queries may fix error when rolling back 


    qryTemplates.params.ParamByName('xEmployeeID').asInteger := KeyID;
    {TEmployeeReportsGUI is inherited from this form and current userId is set as the keyID in that form.
    Reports created from this form will only be seen by that employee who creates it.
    Exporting and Importing those templates will also have the employeeId }


    qryTemplates.Filter:= 'Active = "T"';
    qryTemplates.Filtered:= true;
    OpenQueries;
    EnableDisableControls;
    SetControlFocus(edtSearch);
    AlignbuttonLeftnWidth(pnlMain);
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TBaseTemplateGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TBaseTemplateGUI.CopyDefaultFileToBLOB(const DefFile: string);
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    OpenReportBlob;
    qry.Connection:= self.MyConnection;
    qry.SQL.Add('select report from tbltemplates');
    qry.SQL.Add('where TemplateClass = ' + QuotedStr(DefFile));
    qry.Open;

    if not qry.IsEmpty then begin
      qryReport.Edit;
      TBlobField(qryReport.FieldByName('Report')).Assign(TBlobField(qry.FieldByName('Report')));
      qryReport.Post;
    end
    else
      CommonLib.MessageDlgXP_Vista(DefFile + ' not found.', mtWarning, [mbOK], 0);
  finally
    qry.Free;
  end;
end;

function TBaseTemplateGUI.RetrieveFileFromBlob: TMemoryStream;
begin
  Result := TMemoryStream.Create;
  OpenReportBlob;
  qryReportReport.SaveToStream(Result);
end;


Procedure TBaseTemplateGUI.AddFCFields(TemptypeID:Integer; QuerySeqno :Integer; Const QuerySQL :TStringList) ;
var
    QMObj       : TQueryManipulationObj;
    Currency    : TCurrency;
    FCFields    : TForeignCurrencyFieldsonReport;
    QueryItem   : TQueryRec;
    I           : Integer;
    FieldList   : TStringList;
    classobj    : TDeptClass;
    ifield      : Integer;
    fsFieldName :String;
    fsFieldExpression :string;


    function Searchfield(Const amountfieldName :String):integer;
    var
        ctr:Integer;
    begin
        REsult := -1;
        for ctr := 0 to FieldList.count -1 do
            if fastfuncs.PosExIgnoreCase(amountfieldName , fieldList[ctr]) > 0 then
                if fastfuncs.PosExIgnoreCase(amountfieldName , fieldList[ctr]) + char_length(amountfieldName) = char_length(fieldList[ctr]) then begin
                    REsult := Ctr;
                    Exit;
                end;
    end;
    function Addfield(Const amountfieldName :String):Integer;
    var
        ctr:Integer;
    begin
        ctr := Searchfield(amountfieldName);
        result := ctr+1;
        if ctr < 0 then begin
            Fieldlist.Add('0 as `' + amountfieldname +'`');
            Result := Fieldlist.count;
        end;
    end;
    function  Deletefield(Const amountfieldName :String):integer;
    var
        ctr:Integer;
    begin
        REsult := fieldList.Count;
        ctr := Searchfield(amountfieldName);
        if ctr>= 0 then begin
            fieldList.Delete(ctr);
            REsult := Ctr;
        end;
    end;
begin
    FieldList := TStringList.create;
    FCFields:=TForeignCurrencyFieldsonReport.create(Self);
    Currency := TCurrency.Create(Self);
    classobj:= TDeptClass.create(Self);
    try
        FCFields.LoadSelect('TempTypeID = ' + IntToStr(TemptypeID) + ' and QuerySeqNo = ' + IntToStr(QuerySeqno) );
        classobj.Loadselect('Active = "T"  AND ifnull(Classname , "") <> "" ');
        Currency.Loadselect('Active = "T" AND ifnull(Code, "") <> "" AND ifnull(Code, "")  <> ' + QuotedStr(appenv.RegionalOptions.ForeignExDefault));;
        if FCFields.count = 0 then Exit;

        QMObj := TQueryManipulationObj.create(QuerySQL.text);
        Try
          for I := 0 to QMObj.QueryList.Count - 1 do begin
              QueryItem := TQueryRec(QMObj.QueryList.Items[i]);

              FieldList.clear;
              for iField := 0 to QueryItem.FieldsDesc.count -1 do begin
                  fsFieldExpression := Trim(ExtractStrPortion(QueryItem.FieldsDesc[iField], '~@~', 1));
                  fsFieldName       := Trim(ExtractStrPortion(QueryItem.FieldsDesc[iField], '~@~', 2));
                  fsFieldName := Trim(fsFieldName);
                  if copy(fsFieldName , char_length(fsFieldName) , 1) = ',' then fsFieldName := copy(fsFieldName , 1 , char_length(fsFieldName)-1);
                  if fsFieldExpression = fsFieldName then fsFieldExpression := '';
                  if fsFieldExpression <> '' then fsfieldName := fsfieldname + ' AS `' +fsFieldExpression + '`';
                  FieldList.Add(fsfieldName);
              end;

              FCFields.Dataset.filter := ' IsDeptRelated = "T"';
              FCFields.Dataset.filtered := true;
              try
                  if FCFields.count > 0 then begin
                      if classobj.count > 0 then begin
                          classobj.first;
                          while classobj.Dataset.eof = False do begin
                              FieldList.Add(Quotedstr(classObj.DeptClassName) + '  as `' + classObj.DeptClassName + '_Caption' +'`');
                              classobj.Next;
                          end;
                      end;
                  end;
              finally
                  FCFields.Dataset.filtered := False;
                  FCFields.Dataset.filter := ' ';
              end;

              if Currency.count > 0 then begin
                  Currency.first;
                  FieldList.Add(quotedStr(appenv.RegionalOptions.ForeignExDefault) + '  as `Defaultcurrency_Caption`' );
                  While Currency.EOF = false do begin
                      FieldList.Add(quotedStr(Currency.Code) + '  as `' + Currency.Code + '_Caption' +'`');
                      Currency.next;
                  end;
              end;

              FCFields.first;
              While FCFields.Dataset.eof = False do begin
                  if FCFields.IsDeptRelated then begin
                      Deletefield(FCFields.AmountFieldname);
                      if classobj.count > 0 then begin
                          classobj.first;
                          while classobj.Dataset.eof = False do begin
                              //////FieldList.Add(' 0 as `' +  'Defaultcurrency_' +classObj.DeptClassName +'_' + FCFields.AmountfieldName +'`');
                              FieldList.Add(' 0 as `' +  classObj.DeptClassName +'_' + FCFields.AmountfieldName +'`');
                              if Currency.count > 0 then begin
                                  Currency.first;
                                  While Currency.Eof = false do begin
                                      FieldList.Add(' 0 as `' + Currency.Code+ '_' + classObj.DeptClassName + '_' + FCFields.AmountfieldName  +'`');
                                      Currency.next;
                                  end;
                              end;
                              classobj.Next;
                          end;
                      end;
                  end else begin
                      Addfield(FCFields.AmountFieldname);
                      if Currency.count > 0 then begin
                          Currency.first;
                          While Currency.Eof = false do begin
                              FieldList.Add( ' 0 as `' + Currency.Code+ '_' + FCFields.AmountfieldName + '`');
                              Currency.next;
                          end;
                      end;
                  end;
                  FCFields.Next;
              end;

              QueryItem.FieldsDesc.clear;
              for iField := 0 to Fieldlist.count -1 do
                  QueryItem.FieldsDesc.Add(Fieldlist[ifield]);
          end;
          QuerySQL.Clear;
          for I := 0 to QMObj.QueryList.Count - 1 do begin
              QueryItem := TQueryRec(QMObj.QueryList.Items[i]);
              if I>0 then QuerySQL.add('Union All');
              QuerySQL.add('Select' );
              for ifield := 0 to QueryItem.FieldsDesc.count -1 do begin
                  if ifield < QueryItem.FieldsDesc.count -1 then
                      QuerySQL.add(QueryItem.FieldsDesc[ifield] + ',' )
                  else
                      QuerySQL.add(QueryItem.FieldsDesc[ifield]);
              End;
              //QuerySQL.add(QueryItem.Fields);
              if QueryItem.From  <> '' then QuerySQL.add('From ' + QueryItem.From );
              if QueryItem.where <> '' then QuerySQL.add('where  ' + QueryItem.Where  );
              if QueryItem.Groupby <> '' then QuerySQL.add('Group by  ' + QueryItem.Groupby  );
              if QueryItem.Orderby <> '' then QuerySQL.add('Order by  ' + QueryItem.Orderby  );
          end;
      Finally
        FreeandNil(QMObj);
      end;
    Finally
      FreeandNil(FieldList);
      FreeandNil(classobj);
      FreeandNil(FCFields);
      FreeandNil(Currency);
    end;
end;


procedure TBaseTemplateGUI.btnDesignerClick(Sender: TObject);
var
  ms1, msClean: TMemoryStream;
  TempMyqry: TERPQuery;
  iSQLcounter: integer;
  PipeName: string;
  SQLList :TStringList;
  ctr :Integer;
  Templates :TReportTemplates;
  msg: string;
  IniFileName: string;
begin
  PostDB(qryTemplates);

  if not ValidateData then exit;
  ms1 := nil;
  try

    OpenReportBlob;
    if qryReportReport.BlobSize > 0 then begin
      if GetKeyState(VK_CONTROL) < 0 then begin
        if CommonLib.MessageDlgXP_Vista('Overwrite Existing File?', mtWarning, [mbYes, mbNo], 0) = mrYes then begin
          CopyDefaultFileToBLOB('DefaultHeader');
        end;
      end;
    end else begin       // File does not exist
      if GetKeyState(VK_CONTROL) < 0 then begin
        CopyDefaultFileToBLOB('DefaultHeader');
      end else begin
        CopyDefaultFileToBLOB('Default');
      end;
    end;
    Templates := TReportTemplates.Create;
    if not Templates.CreatedOk then exit;
    with Templates do
      try
        if (Designer.IniStorageType = 'IniFile') then begin
          IniFileName:= Designer.IniStorageName;
          IniFileName:= StringReplace(IniFileName,'($WINSYS)', TPJSystemFolders.Windows, [rfReplaceAll, rfIgnoreCase]);
          {$ifdef COMPILER_22_UP}
          IniFileName:= StringReplace(IniFileName,'($LocalAppData)', GetLocalAppDataDir, [rfReplaceAll, rfIgnoreCase]);
          {$endif}
          if (not CanUseFile(IniFileName, msg)) then begin
            msg:= 'Unable to show designer: ' + #13#10 + #13#10 + msg;
            MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
            exit;
          end;
        end;
        MaxPreview := false;
        SQLList :=TStringList.create;
        try
            clog('');
            for iSQLcounter := 1 to GetSQLCount(qryTemplates.FieldByName('TemplateClass').AsString) do begin
              TempMyqry := GetMyQuery(iSQLcounter);
              if (TempMyqry = nil) then Continue;
              TempMyqry.Close;
              TempMyqry.Sql.Clear;

              TempMyqry.Sql.Text := ReplaceStr(ExtractStrPortion(qryTemplates.FieldByName('SQLString').AsString,
                '~|||~', iSQLcounter), ';', '');
              PipeName := Trim(ExtractStrPortion(ReplaceStr(TempMyqry.Sql.Text, '{', ''), '}', 0));
              if (Trim(TempMyqry.Sql.Text) <> PipeName) then begin
                Templates.PipelineUserName[iSQLcounter] := PipeName;
                TempMyqry.Sql.Text := ReplaceStr(TempMyqry.Sql.Text, '{' + PipeName + '}', '');
              end;
              TempMyqry.Sql.Add(' ' + ReplaceStr(ExtractStrPortion(qryTemplates.FieldByName('DesignTimeSQLString').AsString,
                '~|||~', iSQLcounter), ';', ''));

              try
                    if qryTemplatesreportOnFC.asBoolean then begin
                        SQLList.clear;
                        for ctr := 0 to TempMyqry.SQL.count -1 do
                            SQLList.Add(TempMyqry.SQL[ctr]);
                        AddFCFields(qryTemplatesTypeID.AsInteger , iSQLcounter , SQLList);
                        TempMyqry.SQL.text :=SQLList.text;
                    End;

                    If Trim(TempMyqry.Sql.Text) <> '' then Begin
                      TempMyqry.Sql.Text := TempMyqry.Sql.Text + ' LIMIT 0, 15';
                      PrintTemplateBaseObj.SetReportQueryParameters(TempMyQry);
                      Logtext('/*'+PipeName+'*/'+TempMyqry.SQLtext);
                      TempMyqry.Open;
                    end;
              except
                on EMyError do begin
                end else raise;
              end;
            end;
		finally
            Freeandnil(SQLList);
        end;
        msClean:= TMemoryStream.Create;
        try
          ms1 := RetrieveFileFromBlob;
          msClean.LoadFromStream(ms1);  { clean copy }
          ms1.Position := 0;
          Report.Template.LoadFromStream(ms1);
          { disable "Standard" menu because Save button causes AV crash }
          DisableDesignerToolbar(Designer,'Standard');
          Try
             Designer.ShowModal;
          except
            on e: exception do begin
              if e is EPrintError then begin
                CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
                exit;
              end
              else if Pos('Unable to write to RBuilder.ini',e.Message) > 0 then begin
                MessageDlgXP_Vista('Windows is preventing Report Builder from writing' +
                  ' a file to the disk (RBuilder.ini), please ensure that the user' +
                  ' you are logged on as has full rights to access the disk', mtInformation, [mbOk],0);
                exit;
              end
              else begin
                raise;
              end;
            end;
          end;

          {Post the report to the BLOB bob!}
          ms1.Clear;
          Report.Template.SaveToStream(ms1);
          { only update backend (post to) if the blob has actually been changed }
          if not StreamUtils.StreamsAreEqual(ms1, msClean) then begin
            OpenReportBlob;
            qryReport.Edit;
            ms1.Position := 0;
            qryReportReport.LoadFromStream(ms1);
            qryReport.Post;
          end;  
        finally
          msClean.Free;
        end;
      finally
        FreeandNil(Templates);
        FreeandNil(ms1);
      end;
  except
    on e: ESQLError do begin
      CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
      SetControlFocus(mmoSql);
      exit;
    end;
    on e: ERequiredFieldEmpty do begin
      CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
      SetControlFocus(edName);
      exit;
    end;
    on e: EReportNotFoundError do begin
      CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
      exit;
    end;
    else raise;
  end;
end;

procedure TBaseTemplateGUI.btnDeleteClick(Sender: TObject);
begin
  if Empty(qryTemplatesTemplName.AsString) then Exit;
  if qryTemplates.Active then begin
    if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this report?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      DeleteTemplates(qryTemplatesTemplID.AsInteger);

      qryTemplates.Refresh;
    end;
  end;
end;

procedure TBaseTemplateGUI.btnNewClick(Sender: TObject);
begin
  inherited;
  qryTemplates.Insert;
  qryTemplates.FieldByName('EmployeeID').AsInteger := KeyID;
  qryTemplates.FieldByName('Editable').AsBoolean := true;
  qryTemplates.FieldByName('Active').AsBoolean := true;
  qryTemplates.FieldByName('SQLString').AsString := companyInfoSQL('' , date , date);
    (*'{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, ' +
    //'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' + 'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN ' +
    'CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN ' +
    'FROM tblCompanyInformation AS CO';*)
  EnableDisableControls;
  SetControlFocus(edName);
end;

procedure TBaseTemplateGUI.btnSQLHelperClick(Sender: TObject);
var
  frm: TBaseInputGUI;

  function GetSelectedFields(lst: TListBox): string;
  var
    iIndex: integer;
  begin
    Result := '';
    for iIndex := 0 to lst.Count - 1 do begin
      if lst.Selected[iIndex] then begin
        Result := Result + lst.Items[iIndex] + ',';
      end;
    end;
    Result := Copy(Result, 0, char_length(Result) - 1);
  end;
begin
  inherited;
  frm := TSqlHelperGUI(GetComponentByClassName('TSqlHelperGUI'));
  if Assigned(frm) then begin
    with frm do try
        Caption := ReplaceStr(Caption, AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel), '');
        if ShowModal = mrOk then begin
          if TSqlHelperGUI(frm).lstFields.SelCount > 0 then begin
            qryTemplates.Edit;
            mmoSQL.Lines.Clear;
            mmoSQL.Lines.Add('SELECT');
            mmoSQL.Lines.Add(GetSelectedFields(TSqlHelperGUI(frm).lstFields));
            mmoSQL.Lines.Add('FROM ' + TSqlHelperGUI(frm).lstTables.Items[TSqlHelperGUI(frm).lstTables.ItemIndex]);
          end;
        end;
      finally
        Free;
      end;
  end;
end;

procedure TBaseTemplateGUI.grdTemplatesDblClick(Sender: TObject);
begin
  btnDesignerClick(Sender);
end;

procedure TBaseTemplateGUI.btnViewClick(Sender: TObject);
begin
  if not ValidateData then exit;
  inherited;
  if not Empty(grdTemplates.GetActiveField.AsString) then begin
    OpenReportBlob;
    if qryReportReport.BlobSize = 0 then begin
      CopyDefaultFileToBLOB('Default');
    end;
    PrintTemplateReport(qryTemplates.FieldByName('TemplateClass').AsString,
      ReplaceStr(qryTemplates.FieldByName('DesignTimeSQLString').AsString, ';', ''), false, 1);
  end;
end;

procedure TBaseTemplateGUI.qryTemplatesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  EnableDisableControls;
end;

procedure TBaseTemplateGUI.EnableDisableControls;
begin
  {$IFNDEF DevMode}
  edName.ReadOnly := (not qryTemplates.FieldByName('Editable').AsBoolean);
  mmoSql.ReadOnly := edName.ReadOnly;
  mmoDTSQL.ReadOnly := edName.ReadOnly;
  cboType.ReadOnly := edName.ReadOnly;
  btnSQLHelper.Enabled := (not edName.ReadOnly);
  {$ENDIF}

  if edName.ReadOnly then begin
    edName.Color   := clBtnFace;
    cboType.Color  := clBtnFace;
    mmoSql.Color   := clBtnFace;
    mmoDTSQL.Color := clBtnFace;
  end else begin
    edName.Color   := clWhite;
    cboType.Color  := clWhite;
    mmoSql.Color   := clWhite;
    mmoDTSQL.Color := clWhite;
  end;
end;

procedure TBaseTemplateGUI.qryTemplatesDefaultTemplateChange(Sender: TField);
var
  bm: TBookmark;
  iIndex, iTempID, iType: integer;
begin
  inherited;
  iTempID := qryTemplatesTemplID.AsInteger;
  iType := qryTemplatesTypeID.AsInteger;
  bm := qryTemplates.GetBookmark;
  Try
    if Sender.AsBoolean then begin
      qryTemplates.DisableControls;
      qryTemplates.First;
      for iIndex := 0 to qryTemplates.RecordCount - 1 do begin
        if (qryTemplatesTypeID.AsInteger = iType) and (qryTemplatesTemplID.AsInteger <> iTempID) and
          (qryTemplatesDefaultTemplate.AsBoolean = true) then begin
          qryTemplates.Edit;
          qryTemplatesDefaultTemplate.AsBoolean := false;
        end;
        qryTemplates.Next;
      end;
    end;
  finally
    qryTemplates.GotoBookmark(bm);
    qryTemplates.FreeBookmark(bm);
    qryTemplates.EnableControls;
  end;
end;

procedure TBaseTemplateGUI.ExportFromDB;
var
  ms: TMemoryStream;
  sFile: string;
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to export this report?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    ms := TMemoryStream.Create;
    try
      OpenReportBlob;
      qryReportReport.SaveToStream(ms);
      sFile := 'c:\DNMReport.rtm';
      ms.SaveToFile(sFile);
      CommonLib.MessageDlgXP_Vista('File successfully saved : ' + sFile, mtInformation , [mbOK], 0);
    finally
      FreeandNil(ms);
    end;
  end;
end;

procedure TBaseTemplateGUI.SaveToDB;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    with TOpenDialog.Create(Self) do try
        Title := 'Save Report to Active Record';
        if Execute then begin
          ms.LoadFromFile(FileName);
          OpenReportBlob;
          qryReport.Edit;
          ms.Position := 0;
          qryReportReport.LoadFromStream(ms);
          qryReport.Post;
          CommonLib.MessageDlgXP_Vista('File loaded into DB :' + FileName, mtInformation , [mbOK], 0);
        end;
      finally
        Free;
      end;
  finally
    FreeandNil(ms);
  end;
end;

procedure TBaseTemplateGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
  if ssCtrl in Shift then begin
    case Key of
      VK_NUMPAD1: SaveToDB;
      VK_NUMPAD9: ExportFromDB;
    end;
  end;
end;

procedure TBaseTemplateGUI.grdTemplatesTitleButtonClick(Sender: TObject; const AFieldName: string);
begin
  if {(qryTemplates.fieldbyname(AFieldName).FieldKind <> fkLookup) and  } //Put Lookup field 'TypeName' Qry To allow Type Filtering
    (qryTemplates.FieldByName(AFieldName).FieldKind <> fkCalculated) then begin
    if FastFuncs.PosEx(QuotedStr(AFieldName) + ' ASC CIS', qryTemplates.IndexFieldNames) <> 0 then begin
      qryTemplates.IndexFieldNames := QuotedStr(AFieldName) + ' DESC CIS';
    end else begin
      qryTemplates.IndexFieldNames := QuotedStr(AFieldName) + ' ASC CIS';
    end;
  end;
end;

procedure TBaseTemplateGUI.Label54DblClick(Sender: TObject);
begin
  inherited;
  if devmode then grdTemplatesTitleButtonClick(grdTemplates , qryTemplatesmstimestamp.fieldname);
end;

procedure TBaseTemplateGUI.mmoDTSQLDblClick(Sender: TObject);
begin
  inherited;
  DoDBMemoDialog(qryTemplatesDesignTimeSQLString.AsString, qryTemplatesDesignTimeSQLString.Displaylabel, qryTemplatesDesignTimeSQLString);
end;

procedure TBaseTemplateGUI.mmoSQLDblClick(Sender: TObject);
begin
  inherited;
  EditDB(qryTemplates);
  qryTemplatesSQLString.AsString := replaceStr(qryTemplatesSQLString.AsString , '~||||~' , CRLF+CRLF+ '~|||~');
  PostDB(qryTemplates);
  DoDBMemoDialog(qryTemplatesSQLString.AsString, qryTemplatesSQLString.Displaylabel, qryTemplatesSQLString);
  EditDB(qryTemplates);
  qryTemplatesSQLString.AsString := replaceStr(qryTemplatesSQLString.AsString , CRLF+CRLF+ '~|||~' , '~||||~' );
  PostDB(qryTemplates);
end;

procedure TBaseTemplateGUI.btnExportClick(Sender: TObject);
Var
  Form : TComponent;
begin
  Loglib.CopyToClipboard(qryTemplatesTemplName.asString);
  if not ValidateData then exit;
  inherited;
  Exporting := true;
  try
    Form := GetComponentByClassName('TExportTemplatesGUI');
    if Assigned(Form) then begin
      with TExportTemplatesGUI(Form) do begin
        TemplateID := qryTemplatesTemplID.AsInteger;
        PostMessage(TExportTemplatesGUI(Form).Handle, ShowFormMsg, 0, 0);
        Self.btnSave.Click;
      end;
    end;
  finally
    Exporting:= False;
  end;
end;

procedure TBaseTemplateGUI.grdTemplatesCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  inherited;
  if FastFuncs.PosEx(QuotedStr(Field.FieldName) + ' ASC CIS', qryTemplates.IndexFieldNames) > 0 then begin
    TitleImageAttributes.ImageIndex := 0;
  end else if FastFuncs.PosEx(QuotedStr(Field.FieldName) + ' DESC CIS', qryTemplates.IndexFieldNames) > 0 then begin
    TitleImageAttributes.ImageIndex := 1;
  end else begin
    TitleImageAttributes.ImageIndex := -1;
  end;
end;

procedure TBaseTemplateGUI.DeleteTemplates(const TemplateID: integer);
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := self.MyConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('UPDATE tbltemplates set Active = "F" WHERE TemplID=' + IntToStr(TemplateID) + ';');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TBaseTemplateGUI.DNMSpeedButton1Click(Sender: TObject);
var
  form: TfmAttachments;
begin
  inherited;
  form := Attachmentform;
  if Assigned(Form) then begin
    if fsModal in self.FormState then begin
      form.ShowModal;
    end else begin
      form.FormStyle := fsMDIChild;
      form.BringToFront;
    end;
  end;
end;

procedure TBaseTemplateGUI.edtSearchChange(Sender: TObject);
var
  sFieldName: string;
begin
  if (edtSearch.Text <> '') and (qryTemplates.RecordCount > 2) then begin
    sFieldName := 'TemplName';
    qryTemplates.IndexFieldNames := QuotedStr(sFieldName) + ' ASC CIS';
    dsTemplates.Dataset.Locate(sFieldName, edtSearch.Text, [loCaseInsensitive, loPartialKey]);
  end;
end;

procedure TBaseTemplateGUI.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = vk_f7) or ( Key = vk_f6)  then begin
       With TempMyQuery(TERPConnection(TERPQuery(dsTemplates.Dataset).connection)) do try
          SQL.add(TERPQuery(dsTemplates.Dataset).sqltext);
          if trim(edtSearch.text) <> '' then
            if Key = vk_f7 then begin
              filter:=  'TemplName like ' + quotedstr('%' +trim(edtSearch.text)+'%');
            end else if Key = vk_f6 then begin
              filter:=  'TemplName like ' + quotedstr(trim(edtSearch.text)+'%');
            end;
            filtered:= true;
            open;
            if recordcount > 0 then
              if dsTemplates.Dataset.Locate('TemplID', fieldbyname('TemplID').asInteger,[]) then
                  edtSearch.text :=dsTemplates.Dataset.fieldbyname('TemplName').asString;
        finally
          closenFree;
        end;
  end;
end;

procedure TBaseTemplateGUI.grdTemplatesCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
var
  sFieldName: string;
  HIGHLIGHTLOCATE: TColor;
begin
  inherited;
  if AppEnv.Employee.ListSelectionColour = 0 then begin
    HIGHLIGHTLOCATE := HIGHLIGHTLOCATEDEF;
  end else begin
    HIGHLIGHTLOCATE := AppEnv.Employee.ListSelectionColour;
  end;
  sFieldName := 'TemplName';
  if (not (gdSelected in State) or not TwwDBGrid(Sender).Focused) and
    (FastFuncs.PosEx(uppercase(ReplaceStr(ReplaceStr(edtSearch.Text, '%', ''), '*', '')),
    uppercase(qryTemplates.FieldByName(sFieldName).AsString)) = 1) then ABrush.Color := HIGHLIGHTLOCATE;
end;

procedure TBaseTemplateGUI.qryTemplatesTypeIDChange(Sender: TField);
begin
  inherited;
  if qryTypes.Locate('TypeID', qryTemplatesTypeID.AsInteger, [loCaseInsensitive]) then begin
    qryTemplatesTypeName.AsString := qryTypes.FieldByName('TypeName').AsString;
  end;
end;

function TBaseTemplateGUI.EmailedTemplatesOK: Boolean;
var
  bm: TBookmark;
begin
  Result := True;
  with qryTemplates do begin
    bm := GetBookmark;
    Try
      DisableControls;
      First;
      while not Eof do begin
        If (qryTemplatesTypeID.asInteger=80) then Begin
          If ((FastFuncs.PosEx(':xdatefrom',FastFuncs.LowerCase(qryTemplatesSQLString.asString))=0) OR
             (FastFuncs.PosEx(':xdateto',FastFuncs.LowerCase(qryTemplatesSQLString.asString))=0)) then Begin
            Result := False;
            Exit;
          end;
        end;
        Next;
      end;
    Finally
      GotoBookmark(bm);
      FreeBookmark(bm);
      EnableControls;
    end;
  end;
end;

procedure TBaseTemplateGUI.FormCreate(Sender: TObject);
begin
  inherited;
  UserLock.Enabled := True;
  pnlMain.color := TabColor;
  DoingAfterPost:= false;
  UpdatedIdList:= TIntegerList.Create;
  Exporting:= false;
end;

procedure TBaseTemplateGUI.qryTemplatesAfterPost(DataSet: TDataSet);
begin
  if DoingAfterPost then exit;
  DoingAfterPost:= true;
  try
    inherited;
    if qryTemplatesGlobalref.AsString = '' then begin
      EditDb(qryTemplates);
      qryTemplatesGlobalref.AsString:= Appenv.Branch.SiteCode + qryTemplatesTemplID.AsString;
      PostDb(qryTemplates);
    end;
    UpdatedIdList.AddIfNotInList(qryTemplatesTemplID.AsInteger);
  finally
    DoingAfterPost:= false;
  end;
end;

procedure TBaseTemplateGUI.DoAudit;
var
  qryClean: TERPQuery;
  x: integer;
  sl: TStringList;

  function DataChanged: boolean;
  var
    y: integer;
    fieldname: string;
    s: string;
    ms1, ms2: TMemoryStream;
  begin
    result:= false;
    for y:= 0 to qryClean.FieldCount -1 do begin
    fieldname:= Lowercase(qryClean.Fields[y].FieldName);
      if fieldname = 'templid' then
        { ignore}
      else if fieldname = 'report' then begin
        { compare the blobs }
        ms1:= TMemoryStream.Create;
        ms2:= TMemoryStream.Create;
        try
          TBlobField(qryClean.Fields[y]).SaveToStream(ms1);
          OpenReportBlob(UpdatedIdList[x]);
          TBlobField(qryReport.FieldByName(fieldname)).SaveToStream(ms2);
          if not StreamUtils.StreamsAreEqual(ms1,ms2) then begin
            result:= true;
            sl.Add('  Report Layout - Changed');
          end;
        finally
          ms1.Free;
          ms2.Free;
        end;
      end
      else begin
        if (qryClean.Fields[y].AsString <> qryTemplates.FieldByName(fieldname).AsString) then begin
          result:= true;
          s:= '  ' + fieldname + ' - ';
          if qryClean.Fields[y] is TWideMemoField then
            s:= s + 'Changed'
          else
            s:= s + 'Old Value = "' + qryTemplates.FieldByName(fieldname).AsString +
              '" New Value = "' + qryClean.Fields[y].AsString + '"';
          sl.Add(s);
        end;
      end;
    end;
  end;

begin
  if UpdatedIdList.Count = 0 then exit;
  qryClean:= TERPQuery.Create(nil);
  sl:= TStringList.Create;
  try
    qryClean.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qryClean.SQL.Add('select TemplID,TemplName,TemplateClass,SQLString,DesignTimeSQLString,EmployeeID,Editable,DefaultTemplate,TypeID,Active,Report from tbltemplates');
    qryClean.SQL.Add('where TemplID in (' + UpdatedIdList.CommaText + ')');
    qryClean.Open;
    qryTemplates.DisableControls;
    try
      qryTemplates.Filtered:= false;

      for x:= 0 to UpdatedIdList.Count -1 do begin
        sl.Clear;
        if qryTemplates.Locate('TemplID',IntToStr(UpdatedIdList[x]),[]) then begin
          if qryClean.Locate('TemplID',IntToStr(UpdatedIdList[x]),[]) then begin
            { check for changes .. }
            sl.Add('Template - ' + qryTemplatesTemplName.AsString);
            if DataChanged then { do nothing }
            else sl.Add('  Unknown change');
            TAudit.AddEntry('Main',qryTemplatesGlobalref.AsString,
              sl.Text,sl,'Template',MyConnection, false);

          end
          else begin
            { a new record ...}
            TAudit.AddEntry('Main',
              qryTemplatesGlobalref.AsString,
              'Template - Added (' + qryTemplatesTemplName.AsString + ')',nil,
              'Template',MyConnection, true);
          end;
        end;
      end;

      qryTemplates.Filtered:= true;
    finally
      qryTemplates.EnableControls;
    end;
  finally
    qryClean.Free;
    sl.Free;
  end;
end;

procedure TBaseTemplateGUI.FormDestroy(Sender: TObject);
begin
  UpdatedIdList.Free;
  inherited;
end;

procedure TBaseTemplateGUI.qryReportAfterPost(DataSet: TDataSet);
begin
  inherited;
  UpdatedIdList.AddIfNotInList(qryReportTemplID.AsInteger);
  if qryReportGlobalref.AsString = '' then begin
    EditDb(qryReport);
    qryReportGlobalref.AsString:= Appenv.Branch.SiteCode + qryReportTemplID.AsString;
    PostDb(qryReport);
  end;
end;

procedure TBaseTemplateGUI.OpenReportBlob(aId: integer = 0);
var
  id: integer;
begin
  if aId > 0 then
    id:= aId
  else begin
    PostDB(qryTemplates);
    id:= qryTemplatesTemplID.AsInteger;
  end;
  if (not qryReport.Active) or (qryReport.ParamByName('ID').AsInteger <> id) then begin
    qryReport.Close;
    qryReport.ParamByName('ID').AsInteger:= id;
    qryReport.Open;
  end;  
end;

procedure TBaseTemplateGUI.qryTemplatesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryTemplates.FieldByName('EmployeeID').AsInteger := KeyID;
end;

procedure TBaseTemplateGUI.qryTemplatesBeforePost(DataSet: TDataSet);
begin
  inherited;
  if not ValidateData then
    abort;
  if qryTemplatesTemplateClass.AsString = '' then
    qryTemplatesTemplateClass.AsString:= qryTemplatesTemplName.AsString;
end;

function TBaseTemplateGUI.ValidateData: boolean;
begin
  result:= true;
  if Trim(qryTemplatesTemplName.AsString) = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter a Template Name.', mtInformation, [mbOK], 0);
    edName.SetFocus;
    result:= false;
    exit;
  end
  else if qryTemplatesTypeID.AsInteger < 1 then begin
    CommonLib.MessageDlgXP_Vista('Please select a Template Type.', mtInformation, [mbOK], 0);
    cboType.SetFocus;
    result:= false;
    exit;
  end
  else if Trim(qryTemplatesSQLString.AsString) = '' then begin
    CommonLib.MessageDlgXP_Vista('SQL String can not be blank.', mtInformation, [mbOK], 0);
    mmoSQL.SetFocus;
    result:= false;
    exit;
  end;
end;

end.



