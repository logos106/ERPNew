unit frmTranslation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  Shader, DNMSpeedButton, StdCtrls, wwcheckbox, DNMPanel, Grids, Wwdbigrd,
  Wwdbgrid, Mask, wwdbedit, ProgressDialog, wwradiogroup, wwclearbuttongroup;
type
  TfmTranslation = class(TBaseInputGUI)
    pnlFooter: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    pnlMain: TDNMPanel;
    pnlHeader: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QryLanguageTranslate: TERPQuery;
    QryLanguageTranslateInenglish: TWideStringField;
    QryLanguageTranslateTranslation: TWideStringField;
    QryLanguageTranslateID: TIntegerField;
    QryLanguageTranslateLanguageID: TIntegerField;
    QryLanguageTranslateEnglishID: TIntegerField;
    QryLanguageTranslateModified: TWideStringField;
    dsLanguageTranslate: TDataSource;
    QryinEnglish: TERPQuery;
    QryinEnglishID: TIntegerField;
    QryinEnglishInEnglish: TWideStringField;
    Qrylanguages: TERPQuery;
    QrylanguagesLanguage: TWideStringField;
    QrylanguagesID: TIntegerField;
    lblFilter: TLabel;
    edtSearch: TEdit;
    Label49: TLabel;
    grdTranslation: TwwDBGrid;
    DNMSpeedButton1: TDNMSpeedButton;
    dslanguages: TDataSource;
    dlgSave: TSaveDialog;
    Label2: TLabel;
    edtLanguage: TwwDBEdit;
    QrylanguagesLanguageIdentifier: TWideStringField;
    QrylanguagesActive: TWideStringField;
    Label32: TLabel;
    chkActive: TwwCheckBox;
    btnLanguagefont: TDNMSpeedButton;
    Label48: TLabel;
    languagefontDialog: TFontDialog;
    QrylanguagesLanguagefont: TWideStringField;
    lblMsg: TLabel;
    grpFilters: TwwRadioGroup;
    cmdNew: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    QrylanguagesBaseURL: TWideStringField;
    edtBaseURL: TwwDBEdit;
    lblBaseURL: TLabel;
    lblBaseUrlHint: TLabel;
    procedure QryLanguageTranslateAfterInsert(DataSet: TDataSet);
    procedure QryLanguageTranslateAfterOpen(DataSet: TDataSet);
    procedure QryLanguageTranslateBeforeOpen(DataSet: TDataSet);
    procedure QryLanguageTranslateBeforePost(DataSet: TDataSet);
    procedure grdTranslationColEnter(Sender: TObject);
    procedure grdTranslationColExit(Sender: TObject);
    procedure grdTranslationEnter(Sender: TObject);
    procedure grdTranslationExit(Sender: TObject);
    procedure grdTranslationKeyPress(Sender: TObject; var Key: Char);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QrylanguagesAfterPost(DataSet: TDataSet);
    procedure edtLanguageExit(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnLanguagefontClick(Sender: TObject);
    procedure QrylanguagesAfterOpen(DataSet: TDataSet);
    procedure grdTranslationCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure pnlMainResize(Sender: TObject);
    procedure lblBaseUrlHintClick(Sender: TObject);
  private
    fiLanguageId: Integer;
    conn :TERPConnection;
    defaultLanguage:String;
    procedure setLanguageID(const Value: Integer);
    procedure changeLanguage;
    Procedure PostLanguageTranslate;
    Procedure RefreshLanguageTranslate;
    Procedure ApplyLanguagefont;
    procedure InitLanguagefontdialog;
    Procedure MakeBaseURLField;
    Procedure CheckForEnglish;
    { Private declarations }
  Protected
    procedure SetConnectionString(const TransactionMode: boolean = true);Override;
  public
    Property LanguageId:Integer read fiLanguageId write setLanguageID;
    procedure BeginTransaction; Override;
    procedure CommitTransaction; Override;
    procedure RollbackTransaction;Override;

  end;


implementation

uses CommonLib, AppEnvironment, LanguageTranslationObj,
  JSONObject, sndkey32, ExportDataObj, FormFactory, CommonDbLib,
  DatasetExporter, ERPLib, DbSharedObjectsObj, TempTableUtils, FrmInputText,
  tcConst, AppDatabase, ERPErrorEmailUtils, ERPVersionConst;

{$R *.dfm}

{ TBaseInputGUI2 }


procedure TfmTranslation.ApplyLanguagefont;
begin
    btnLanguagefont.Font.Name  :=languagefontDialog.font.Name;
    btnLanguagefont.Font.size  :=languagefontDialog.font.size;
    btnLanguagefont.Font.style :=languagefontDialog.font.style;
end;

procedure TfmTranslation.BeginTransaction;
begin
  inherited;
  if assigned(conn) then
    if conn.connected then
      if not conn.InTransaction then
        conn.StartTransaction;

end;

procedure TfmTranslation.btnCloseClick(Sender: TObject);
begin
  inherited;
  CancelDB(Qrylanguages);
  canceldb(QryLanguageTranslate);
  RollbackTransaction;
  Self.Close;
end;

procedure TfmTranslation.btnCompletedClick(Sender: TObject);
begin
  inherited;
  PostDB(Qrylanguages);
  PostLanguageTranslate;
  RefreshLanguageTranslate;
  CommitTransaction;
  Self.close;
end;

procedure TfmTranslation.btnLanguagefontClick(Sender: TObject);
var
  s:String;
begin
  inherited;
    if languagefontDialog.Execute then begin
        s:=  languagefontDialog.Font.Name +';' +
             inttoStr(languagefontDialog.Font.size) +';' ;
             if languagefontDialog.Font.Style = [fsBold, fsItalic]  then s:= s +'[fsBold, fsItalic]'
        else if languagefontDialog.Font.Style = [fsItalic]          then s := s + '[fsItalic]'
        else if languagefontDialog.Font.Style = [fsBold]            then s := s + '[fsBold]'
        else if languagefontDialog.Font.Style = []                  then s := s +'[]'
        else s := s +'[]';
        editdb(Qrylanguages);
        QrylanguagesLanguagefont.AsString := s;
        postdb(Qrylanguages);
    end;
    ApplyLanguagefont;
end;
procedure TfmTranslation.changeLanguage;
begin
  {add new languages here }
    if (screen.activecontrol = grdTranslation)
        and  (grdTranslation.getactivefield <> nil)
        and (sameTExt(grdTranslation.getactivefield.fieldname , 'Translation') )
        and  (QrylanguagesLanguageIdentifier.AsString <> '')then
        LoadKeyboardLayoutA(QrylanguagesLanguageIdentifier.AsansiString,KLF_ACTIVATE)
    else
      LoadKeyboardLayoutA(ansiString(defaultLanguage),KLF_ACTIVATE);

end;


procedure TfmTranslation.CheckForEnglish;
begin
  if SameText(QrylanguagesLanguage.asString , 'English') then begin
    TimerMsg(lblMsg , 'English is the Base Language which Cannot be Edited except the Base URL' , 50);
    pnlMain.Enabled := False;
    Setcontrolfocus(edtBaseURL);
    highLightcontrol(edtBaseURL);
  end;
end;

procedure TfmTranslation.cmdNewClick(Sender: TObject);
var
  inEnglish:String;
begin
  inherited;
  try
    PostDB(QryLanguageTranslate);
    InEnglish := InputBox('In English', 'Please Enter the New English Word for Translation' , '');
    if InEnglish = '' then exit;
    if QryinEnglish.Locate('InEnglish' , InEnglish , []) then begin
    end else begin
      QryinEnglish.Append;
      QryinEnglishInEnglish.asString := InEnglish;
      QryinEnglish.Post;
    end;
    if QryinEnglishID.asinteger <> 0 then
      if not QryLanguageTranslate.Locate('EnglishID' ,QryinEnglishID.asinteger , []) then begin
        QryLanguageTranslate.Append;
        QryLanguageTranslateInenglish.asString :=QryinEnglishInEnglish.asString;
        QryLanguageTranslateEnglishID.asInteger:=QryinEnglishID.asinteger;
        QryLanguageTranslateModified.asBoolean := TRue;
        PostDb(QryLanguageTranslate);
        grdTranslation.SetActivefield('Translation');
      end;
  Except
    // ignore the exception
  end;
end;

procedure TfmTranslation.CommitTransaction;
begin
  inherited;
  if assigned(conn) then
    if conn.connected then
      if conn.InTransaction then
        conn.Commit;

end;

procedure TfmTranslation.pnlMainResize(Sender: TObject);
begin
  inherited;
//  grdTranslation.Top:= 36;
//  grdTranslation.Invalidate;
end;

procedure TfmTranslation.DNMSpeedButton1Click(Sender: TObject);
var
  filename:String;
  LT:TLanguageTranslationObj;
  errorlog:String;
begin
  inherited;
  dlgSave.filename :=appenv.companyinfo.Companyname +'_' +qryLanguageslanguage.asString+'_' + formatDatetime('yyymmddhhnn' , now())+'.csv';
  if not dlgSave.Execute then Exit;
  filename:= dlgSave.FileName;
  if filename = '' then exit;

  try
    PostDB(Qrylanguages);
    PostLanguageTranslate;
    CommitTransaction;
  except
    on E:Exception do begin
      MessageDlgXP_Vista('Save Failed.' +chr(13) + E.Message, mtwarning, [mbok],0)    ;
      Exit;
    end;
  end;
  try
    LT:= TLanguageTranslationObj.create;
    try
      if not LT.ExportModified(filename,QrylanguagesID.asInteger ) then
        MessageDlgXP_Vista('Export  of Language ' + QrylanguagesLanguage.asString +' Failed. Please contact ERP.' , mtwarning, [mbok],0)
      else begin
        Application.processmessages;
        ProgressDialog.DoShowProgressbar(4 , 'Sending Translation to ERP...' );
        try
          if not(fileExists(fileName)) then begin
            MessageDlgXP_Vista('Nothing to Export of Language ' + QrylanguagesLanguage.asString +'.' , mtwarning, [mbok],0);
            Exit;
          end;
            ProgressDialog.DoStepProgressbar;
            errorlog:=  SendEmailtoErp('Language Translation' ,
                                        'Language Translation file Attached'+chr(13) +
                                        'Filename :' + ExtractFileName(Filename) + chr(13) +
                                        'From     : ' + Appenv.CompanyInfo.Companyname+ chr(13) +
                                        'User     : ' + Appenv.Employee.EmployeeName+ chr(13) +
                                        'Date     : ' +formatDateTime('dd-mm-yyyy hh:nn' , now()) +chr(13)+chr(13)+
                                        'Note for ERP: Run the Application  on Server1, General->Language List -> Import(ERP) and select the file to import.'  , '' , filename  );
            ProgressDialog.DoStepProgressbar;
            if errorlog <> '' then begin
              MessageDlgXP_Vista('Export  of Language ' + QrylanguagesLanguage.asString +' Failed. Please Contact ERP.'+chr(13)+'Error Log:'+ErrorLog , mtwarning, [mbok],0);
              ProgressDialog.DoStepProgressbar;
            end else begin
              MessageDlgXP_Vista('All Changes of Language ' + QrylanguagesLanguage.asString +chr(13)+
                                  'are Exported and Sent to ERP.' +chr(13)+ chr(13)+
                                  'Please Keep a Copy of '+filename+' for Backup.' , mtInformation, [mbok],0);
              ProgressDialog.DoStepProgressbar;
              LT.AllSynchronized(QrylanguagesID.asInteger);
              ProgressDialog.DoStepProgressbar;
            end;
        finally
          ProgressDialog.DoHideProgressbar;
        end;
      end;
    finally
      Freeandnil(LT);
    end;
  finally
    Self.close;
  end;
end;

procedure TfmTranslation.DNMSpeedButton2Click(Sender: TObject);
var
  Filename:String;
  DE:TERPQueryExporter;
  Qry:TERPQuery;
begin
  dlgSave.filename :=qryLanguageslanguage.asString+'.csv';
  dlgSave.Title := 'Export - ' + Caption;
  if dlgSave.Execute then begin
    Processingcursor(True);
    try
      Filename := dlgSave.FileName;
      DE:= TERPQueryExporter.create(Self);
      try
        Qry := TempMyQuery;
        Try
          Qry.Connection := Qrylanguages.connection;
          Qry.SQL.add('SELECT ' +
                      ' E.InEnglish ,  ' +
                      ' L.Language, ' +
                      ' LT.Translation ' +
                      ' FROM inEnglish E ' +
                      ' Left join `languagetranslationlocal`  LT on LT.EnglishID = E.ID  and LT.LanguageID = '+ inttostr(LanguageId) +
                      ' Left join languages L on L.ID = LT.LanguageID ' +
                      ' order by Language , InEnglish');
            Qry.open;
            DE.Query                  := Qry;
            //DE.Grid                   := grdMain;
            DE.fileName               := FileName;
            DE.DefaultExtension       := 'txt';
            DE.RemoveNonPrintablechar := True;
            if DE.DoExport <> '' then
              MessageDlgXP_Vista('Language Transalation is exported to  ' + chr(13) + Quotedstr(filename)+ '.', mtInformation, [mbOK], 0)
            else MessageDlgXP_Vista('Exporting Language Transalation Failed', mtWarning, [mbOK], 0);
        Finally
            Qry.ClosenFree;
        end;

      finally
        FreeandNil(DE);
      end;
    finally
      ProcessingCursor(False);
    end;
  end;


end;

procedure TfmTranslation.edtLanguageExit(Sender: TObject);
begin
  inherited;
  if Qrylanguageslanguage.asString = '' then exit;
  PostDB(Qrylanguages);
end;

procedure TfmTranslation.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (ord(key) = vk_return)  then begin
    QryLanguageTranslate.Locate('inenglish' , edtsearch.text , [loCaseInsensitive, loPartialKey])
  end;
end;

procedure TfmTranslation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmTranslation.FormCreate(Sender: TObject);
begin
  MakeBaseURLField;
  inherited;
  defaultLanguage :='00000400';
  LanguageId := 0;
  conn:= nil;
end;

procedure TfmTranslation.FormShow(Sender: TObject);
begin
  inherited;
  edtBaseURL.Enabled := CanUpdateLanguageBaseURL;
  lblBaseURL.Enabled := CanUpdateLanguageBaseURL;
  lblBaseUrlHint.Visible := not(edtBaseURL.Enabled) or devmode;
  SetcontrolFocus(edtLanguage);
  if (keyID<> 0) and (fiLanguageId=0) then LanguageId := KeyID
  else if (keyID= 0) and (fiLanguageId<>0) then keyID:= LanguageID;
  OpenQueries;
  edtLanguage.readonly := Qrylanguages.recordcount>0;
  begintransaction;
  if keyId = 0 then QryLanguages.append;

  cmdNew.enabled := AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowAddNewInEnglish') = 1;
end;

procedure TfmTranslation.grdTranslationCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QryLanguageTranslateModified.asboolean then begin
    AFont.color := clred;
  end;
end;

procedure TfmTranslation.grdTranslationColEnter(Sender: TObject);
begin
  inherited;
  edtsearch.Text := '';
  changeLanguage;
end;

procedure TfmTranslation.grdTranslationColExit(Sender: TObject);
begin
  inherited;
  edtsearch.Text := '';
end;

procedure TfmTranslation.grdTranslationEnter(Sender: TObject);
begin
  inherited;
  if Qrylanguageslanguage.asString = '' then begin
    Setcontrolfocus(edtLanguage);
    exit;
  end;
  PostDB(Qrylanguages);
  edtsearch.Text := '';
  changeLanguage;
end;

procedure TfmTranslation.grdTranslationExit(Sender: TObject);
begin
  inherited;
  changeLanguage;
end;

procedure TfmTranslation.grdTranslationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
(*   if screen.ActiveControl = grdTranslation then
    if Sametext(grdTranslation.GetActiveField.FieldName , 'inenglish') then
      if (ord(key) = vk_return)  then begin
          if edtsearch.text ='' then exit;
          QryLanguageTranslate.Locate('inenglish' , edtsearch.text , [loCaseInsensitive, loPartialKey])
      end else if (ord(key) = VK_ESCAPE) or (Key = #8) then begin
          edtsearch.Text := '';
      end else begin
        if (ord(key)>= 32) and   (ord(key)<= 126) then edtsearch.text := edtsearch.text + key;
      end; *)

end;

procedure TfmTranslation.grpFiltersClick(Sender: TObject);
begin
  inherited;
  Processingcursor(True);
  try
    postdb(QryLanguageTranslate);
    QryLanguageTranslate.filtered:= grpfilters.itemindex =1;
  finally
    Processingcursor(False);
  end;
end;

procedure TfmTranslation.PostLanguageTranslate;
begin
try
    Postdb(QryLanguageTranslate);
  Except
    on E:Exception do begin
      canceldb(QryLanguageTranslate);
    end;
  end;

end;

procedure TfmTranslation.QrylanguagesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  InitLanguagefontdialog;
  ApplyLanguagefont;
  CheckforEnglish;
end;
Procedure TfmTranslation.InitLanguagefontdialog;
begin
   StrTofont(languagefontDialog.font , Qrylanguageslanguagefont.asString);
end;

procedure TfmTranslation.lblBaseUrlHintClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  if  ModalInputBox('Message For ERP', 'Base URL of ' + QrylanguagesLanguage.AsString +':'  , '',s) then begin
    s:= 'User      : ' +appenv.Employee.EmployeeName +NL +
        'Server   : ' + GetSharedMyDacConnection.Server+NL +
        'Database  : ' + GetSharedMyDacConnection.Database+'.' + Appenv.CompanyInfo.CompanyName +NL +
        'ERP Version : ' + TABLE_VERSION+NL +NL +NL +

        'Hi ' + Nl +'Please Change the Base URL of ' + QrylanguagesLanguage.AsString
              +iif(s<> '' ,  ' to :'+Nl+NL+s , '') +Nl+NL+
                Appenv.Employee.EmployeeName;

    SendEmailtoErp('Change Language Base URL' ,s , 'Base URL' );
  end;
end;

procedure TfmTranslation.MakeBaseURLField;
var
  script :TERPScript;
  fbIgnorenContinueOnError:Boolean;
  conn :TERPConnection;
begin
  inherited;
  conn :=GetNewERPLanguageConnection(self);
  try
    if not TempTableUtils.FieldExists(conn , 'languages', 'BaseURL') then begin
        script := DbSharedObj.GetScript(GetSharedMyDacConnection);
        try
          try
            fbIgnorenContinueOnError:= Script.IgnorenContinueOnError;
            try
              Script.IgnorenContinueOnError := True;
              Script.SQL.Text := 'ALTER TABLE erplanguages.languages 	ADD COLUMN  `BaseURL` VARCHAR(255) NULL ;';
              Script.Execute;
            finally
              Script.IgnorenContinueOnError := fbIgnorenContinueOnError;
            end;
          Except
            // kill exception if field already exists
          end;
        finally
          DbSharedObj.ReleaseObj(Script);
        end;
    end;
  finally
    Freeandnil(Conn);
  end;
end;

procedure TfmTranslation.QrylanguagesAfterPost(DataSet: TDataSet);
begin
  inherited;
  if fiLanguageId<> QrylanguagesID.asInteger then
    LanguageId:= QrylanguagesID.asInteger;
end;

procedure TfmTranslation.QryLanguageTranslateAfterInsert(DataSet: TDataSet);
begin
  inherited;
  QryLanguageTranslateLanguageID.AsInteger := fiLanguageId;
end;

procedure TfmTranslation.QryLanguageTranslateAfterOpen(DataSet: TDataSet);
begin
  inherited;
  QryLanguageTranslateTranslation.DisplayLabel := QrylanguagesLanguage.asString;
end;

procedure TfmTranslation.QryLanguageTranslateBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  opendb(Qrylanguages);
  TLanguageTranslationObj.Inst.LoadAllEntriesforLanguage(fiLanguageID);
end;

procedure TfmTranslation.QryLanguageTranslateBeforePost(DataSet: TDataSet);
begin
  inherited;
  QryLanguageTranslateModified.AsBoolean := true;
end;


procedure TfmTranslation.RefreshLanguageTranslate;
begin
  With TempMyScript do try
    connection := QryLanguageTranslate.connection;
    SQl.add('insert ignore into   `languagetranslation` ' +
              ' (LanguageID ,EnglishID ,Translation)  ' +
              ' Select LanguageID ,EnglishID ,Translation  ' +
              ' from `languagetranslationlocal` where modified = "T";');
    SQl.add('update `languagetranslation` LT  ' +
              ' inner join `languagetranslationlocal` LTL  ' +
              ' on LT.LanguageID = LTL.LanguageID and LT.EnglishID = LTL.EnglishID   ' +
              ' Set LT.Translation = LTL.Translation where LTL.Modified = "T";');
    Execute;
  finally
    free;
  end;
end;

procedure TfmTranslation.RollbackTransaction;
begin
  inherited;
  if assigned(conn) then
    if conn.connected then
      if conn.InTransaction then
        conn.Rollback;
end;

procedure TfmTranslation.SetConnectionString(const TransactionMode: boolean);
begin
  inherited;
  conn := commondblib.GetNewERPLanguageConnection(Self);
  QryLanguageTranslate.connection := conn;
  QryinEnglish.connection := conn;
  Qrylanguages.connection := conn;
end;

procedure TfmTranslation.setLanguageID(const Value: Integer);
begin
  fiLanguageId := Value;
  if QryLanguageTranslate.ParamByName('LanguageId').AsInteger <>  fiLanguageId then begin
    closedb(QryLanguageTranslate);
    QryLanguageTranslate.ParamByName('LanguageId').AsInteger :=  fiLanguageId;
    closedb(Qrylanguages);
    Qrylanguages.ParamByName('ID').AsInteger :=  fiLanguageId;
  end;
  opendb(QryinEnglish);
  opendb(Qrylanguages);
  opendb(QryLanguageTranslate);
  KeyId:=fiLanguageId;
end;

initialization
  RegisterClassOnce(TfmTranslation);
  with FormFact do
  begin
    RegisterMe(TfmTranslation, 'TLanguagesGUI_*=Id');
    RegisterControl(TfmTranslation, '*_cboLanguage=ID');
  end;
end.
