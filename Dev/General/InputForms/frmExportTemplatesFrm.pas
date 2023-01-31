unit frmExportTemplatesFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DNMSpeedButton, DB, MyAccess,ERPdbComponents, ComCtrls,AdvOfficeStatusBar, ExtCtrls, BaseInputForm, DNMPanel,
  wwcheckbox, MemDS, DBAccess, Shader, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, ImgList, cabfiles, ProgressDialog;

const
  ShowFormMsg = WM_USER + 122;

type
  TExportTemplatesGUI = class(TBaseInputGUI)
    lblImporting: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    ExportProgressBar: TProgressBar;
    SpeedButton1: TDNMSpeedButton;
    txtFileName: TEdit;
    Letter_Label: TLabel;
    SaveDialog1: TSaveDialog;
    qryTemplatesRTM: TERPQuery;
    qryTemplatesRTMTemplID: TWordField;
    qryTemplatesRTMReport: TBlobField;
    Label1: TLabel;
    SqlOnly: TwwCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShowForm(var Message: TMessage); message ShowFormMsg;
  private
    { Private declarations }
    qryExport: TERPQuery;
    F: TextFile;
    TempFilePath: string;
    fReportID: integer;
    function IsDir(const DirPath: string): boolean;
    function MakeDataLine(const TypeStr: string): string;
    function MakeHeaderLine(const TypeStr, TypeStr2, TypeStr3: string): string;
    procedure MakeExportFile(const FileName: string);
    procedure CloseExportFile;
    procedure AddLinetoFile(const StrData: string);
    procedure ExportRTMFromDB(const FileName: string);
    procedure CompressFiles(const CabName, FilesPath: string);
  public
    {Public declarations}
    property TemplateID: integer read fReportID write fReportID;
    
  end;

implementation

uses
  FastFuncs,DNMLib, DNMExceptions, CommonDbLib, CommonLib, MySQLConst, SystemLib;

{$R *.DFM}

const
  // Headers Strings
  HTEMPLATE = '$TEMPLATE,TemplID,TypeName,TemplName,TemplateClass,EmployeeName,SQLString,DesignTimeSQLString,Editable';

procedure TExportTemplatesGUI.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

function TExportTemplatesGUI.IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;

procedure TExportTemplatesGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TExportTemplatesGUI.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  //SaveDialog1.InitialDir := SystemLib.ExeDir;
  if devmode then SaveDialog1.InitialDir := 'U:\SQL';

  if SaveDialog1.Execute then begin
    txtFileName.Text := SaveDialog1.FileName;
  end;
end;

procedure TExportTemplatesGUI.AddLinetoFile(const StrData: string);
begin
  Writeln(F, StrData);
end;

procedure TExportTemplatesGUI.MakeExportFile(const FileName: string);
begin
  AssignFile(F, FileName);
  Rewrite(F);
end;

procedure TExportTemplatesGUI.CloseExportFile;
begin
  Flush(F);
  CloseFile(F);
end;

procedure TExportTemplatesGUI.btnOKClick(Sender: TObject);
var
  CreatedQryStr: string;
  I, LinesCount: integer;
begin
  DisableForm;
  try
    inherited;
    TempFilePath := '';
    btnOK.Enabled := false;
    try
      if empty(txtFileName.Text) then begin
        SpeedButton1Click(Sender);
      end;
      RemoveXDesignSql;
      if IsDir(ExtractFileDir(txtFileName.Text)) then begin
        btnCancel.Enabled := false;
        qryExport := TERPQuery.Create(nil);
        qryExport.Connection := CommonDbLib.GetSharedMyDacConnection;

        //Start File
        TempFilePath := WinTempDir + 'ERPTemplateExport\Templates.pdi';
        try
          if not IsDir(ExtractFileDir(TempFilePath)) then begin
            MkDir(ExtractFileDir(TempFilePath));
          end;
        except
        end;
        MakeExportFile(TempFilePath);
        //What to Export ??

        {Export Templates}
        begin
          { NOTE: the following code was resulting in SQLString being returned as
                  a TWideStringField (and was truncated to 8k) rather than TWideMemoField
                  ... do moved the formatting into delphi code }
  //        CreatedQryStr := 'SELECT TemplID,TypeName, TemplName, TemplateClass, Concat(FirstName," ",LastName) AS "EmployeeName",' +
  //          'REPLACE(REPLACE(REPLACE(REPLACE(SQLString,0x22,0x27),0xD," "),0xA," "),0x9," ") as SQLString,' +
  //          'REPLACE(REPLACE(REPLACE(REPLACE(DesignTimeSQLString,0x22,0x27),0xD," "),0xA," "),0x9," ") as DesignTimeSQLString,' +
  //          'Editable, DefaultTemplate ' + 'FROM tbltemplates INNER JOIN tbltemplatetype Using(TypeID) ' +
  //          'LEFT JOIN tblemployees On tbltemplates.EmployeeID=tblemployees.EmployeeID ';
          CreatedQryStr := 'SELECT TemplID,TypeName, TemplName, TemplateClass, Concat(FirstName," ",LastName) AS "EmployeeName",' +
            'SQLString as SQLString,' +
            'DesignTimeSQLString as DesignTimeSQLString,' +
            'Editable ' + 'FROM tbltemplates INNER JOIN tbltemplatetype Using(TypeID) ' +
            'LEFT JOIN tblemployees On tbltemplates.EmployeeID=tblemployees.EmployeeID ';

          if fReportID <> 0 then begin
            CreatedQryStr := CreatedQryStr + ' WHERE tbltemplates.TemplID = ' + IntToStr(fReportID);
          end;


          qryExport.SQL.Clear;
          qryExport.SQL.Add(CreatedQryStr);
          lblImporting.Caption := 'Please Wait Preparing Templates ..... 0%';
          lblImporting.Visible := true;
          ExportProgressBar.Min := 0;
          Application.ProcessMessages;
          qryTemplatesRTM.Active := true;
          qryExport.Active := true;
          AddLinetoFile(MakeHeaderLine(HTEMPLATE, '', ''));
          with qryExport do begin
            First;
            qryTemplatesRTM.First;
            LinesCount := qryExport.RecordCount + 1;
            ExportProgressBar.Max := LinesCount;
            ExportProgressBar.Position := ExportProgressBar.Min;

            for I := 0 to qryExport.RecordCount - 1 do begin
              ExportProgressBar.StepIt;
              lblImporting.Caption := 'Please Wait Exporting Templates ..... ' + FloatToStrF(((I / LinesCount) * 100),
                ffFixed, 7, 0) + '% Complete';
              AddLinetoFile(MakeDataLine('TEMPLATE'));

              if fReportID <> 0 then begin
                qryTemplatesRTM.Locate('TemplID', qryExport.FieldByName('TemplID').AsString, [loCaseInsensitive])
              end;

              if not SqlOnly.Checked then begin
                ExportRTMFromDB(qryTemplatesRTMTemplID.AsString);
              end;

              Next;
              qryTemplatesRTM.Next;
              Application.ProcessMessages;
            end;
          end;


          AddLinetoFile('FINALTEMPLATE');
        end;
        //Save And Close File
        CloseExportFile;
        lblImporting.Caption := 'Please Wait Completeing Templates Export..... 100%';
        Application.ProcessMessages;
        CompressFiles(txtFileName.Text, ExtractFileDir(TempFilePath));
        Application.ProcessMessages;
        //Delete Temp Directory
        try
          DeleteFiles(ExtractFileDir(TempFilePath) + '\TemplateFiles\', '*.*');
          DeleteFiles(ExtractFileDir(TempFilePath) + '\', '*.*');
          if IsDir(ExtractFileDir(TempFilePath)) then begin
            if IsDir(ExtractFileDir(TempFilePath)) then begin
              try
                RmDir(ExtractFileDir(TempFilePath) + '\TemplateFiles');
              except
              end;
            end;
            RmDir(ExtractFileDir(TempFilePath));
          end;
        except
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFileName.Text) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
      end;
      btnCancel.Enabled := true;
      btnOK.Enabled     := true;
      Self.Close;
    except
      raise;
      CloseExportFile;
      btnCancel.Enabled := true;
      btnOK.Enabled     := true;
      Self.Close;
    end;
  finally
    EnableForm;
  end;   
end;

function TExportTemplatesGUI.MakeHeaderLine(const TypeStr, TypeStr2, TypeStr3: string): string;
begin
  if not Empty(TypeStr) and not Empty(TypeStr2) and not Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9) + ReplaceStr(TypeStr2, ',', #9) + ReplaceStr(TypeStr3, ',', #9);
  end else if not Empty(TypeStr) and not Empty(TypeStr2) and Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9) + ReplaceStr(TypeStr2, ',', #9);
  end else if not Empty(TypeStr) and Empty(TypeStr2) and Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9);
  end;
end;

function TExportTemplatesGUI.MakeDataLine(const TypeStr: string): string;
var
  TempStr: string;
  I: integer;
  s: string;
begin
  TempStr := '';
  with qryExport do begin
    TempStr := TypeStr + #9;
    for I := 0 to qryExport.FieldCount - 1 do begin
      if (Fields[I].FieldName = 'SQLString') or (Fields[I].FieldName = 'DesignTimeSQLString') then begin
        s:= Fields[I].AsString;
        s:= StringReplace(s,#34,#39,[rfReplaceAll]);
        s:= StringReplace(s,#10,' ',[rfReplaceAll]);
        s:= StringReplace(s,#13,' ',[rfReplaceAll]);
        s:= StringReplace(s,#09,' ',[rfReplaceAll]);
        TempStr := TempStr + s + #9;
      end
      else if (Fields[I].DataType = ftDate) or (Fields[I].DataType = ftDateTime) then begin
        TempStr := TempStr + FormatDateTime(MysqlDateFormat, Fields[I].AsDateTime) + #9;
      end else begin
        TempStr := TempStr + Fields[I].AsString + #9;
      end;
    end;
  end;
  Result := Copy(TempStr, 0, char_length(TempStr) - 1)
end;

procedure TExportTemplatesGUI.ExportRTMFromDB(const FileName: string);
var
  ms: TMemoryStream;
  sFile: string;
begin
  ms := TMemoryStream.Create;
  try
    qryTemplatesRTMReport.SaveToStream(ms);
    try
      if not IsDir(ExtractFileDir(TempFilePath) + '\TemplateFiles') then begin
        MkDir(ExtractFileDir(TempFilePath) + '\TemplateFiles');
      end;
    except
    end;
    sFile := ExtractFileDir(TempFilePath) + '\TemplateFiles\' + FileName + '.tcr';
    ms.SaveToFile(sFile);
  finally
    FreeandNil(ms);
  end;
end;

procedure TExportTemplatesGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      if (fReportID = 0) AND UserLock.IsLocked('tbltemplates', -1, 'Customise Templates') then begin
        AccessLevel := 6;
        EnableDisable;
        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + GetFormDescription(Self.ClassName) +
          ' Access is Denied.', mtWarning, [mbOK], 0);
      end;
      inherited;
      OpenQueries;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TExportTemplatesGUI.CompressFiles(const CabName, FilesPath: string);
var
  aCab: TCabFile;
begin
  aCab := TCabFile.Create(nil);
  try
    aCab.CompressionType := typMsZip;
    aCab.CabFile:= CabName;
    aCab.CABFileContents.AddFolder(FilesPath + '\*.pdi');
    if not SqlOnly.Checked then begin
      aCab.CABFileContents.AddRelFolder(FilesPath + '\TemplateFiles\*.tcr' ,'\TemplateFiles');
    end;
    aCab.Compress;
  finally
    aCab.Free;
  end;
end;

procedure TExportTemplatesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  UserLock.Enabled := True;
  fReportID := 0;  
end;

procedure TExportTemplatesGUI.ShowForm(var Message: TMessage);
begin
  Self.FormStyle := fsMDIChild;
  Self.BringToFront;
end;

initialization
  RegisterClassOnce(TExportTemplatesGUI);
end.

