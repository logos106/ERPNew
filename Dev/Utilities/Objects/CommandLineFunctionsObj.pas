unit CommandLineFunctionsObj;
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 10/08/06  1.00.01 BJ   Introduces /X: and /I: parameters
                        /X exports the list of classes listed and will terminate the application
                        /I Imports data from the file provided.
 }

interface

uses Classes, XMLDoc, XMLIntf;

type
  TCommandLineFunctions = class(TObject)
  private
    fCmdLineParams : TStringList;
    fUser: String;
    fXMLFileName :String;
    fXmlClasses:String;
    fbImportFromXML :boolean;
    fbExportToXML:Boolean;
    fPassword: String;
    fDatabase: String;
    fServer: String;
    fRunBatch: Boolean;
    fRunVerify: Boolean;
    fExitOnComplete: Boolean;
    fExcludeInactive:Boolean;
    fShowCommandLinesParamsHelp: Boolean;
    procedure GetVaildCmdLineParams;
    procedure ProcessCmdLineParams;
  public
    constructor Create;
    destructor Destroy; Override;
    Procedure ImportFromXMLFile;
    Procedure ExportToXMLFile;
    procedure ExecBeforeLoginCmdLineParams;
    procedure ExecAfterLoginCmdLineParams;
    property VaildCommandLinesParams: TStringList read fCmdLineParams;
    property User: String read fUser;
    Property XMLFileName :String read fXMLFileName;
    Property XmlClasses  : String read fXmlClasses;
    property Password: String read fPassword;
    property Database: String read fDatabase;
    property Server: String read fServer;
    property RunBatch: Boolean read fRunBatch;
    property RunVerify: Boolean read fRunVerify;
    property ExitOnComplete: Boolean read fExitOnComplete Write fExitOnComplete;
    Property ExcludeInactive:boolean read fExcludeInactive write fExcludeInactive;
  end;

var
  CommandLineFunctions: TCommandLineFunctions;

implementation
uses FastFuncs,MAIN, SysUtils, CommonLib, Windows, TransactionsTable,
     {VerifyFunctionsObj,} CustomImport,
     CustomExport;

constructor TCommandLineFunctions.Create;
begin
  inherited;
  fCmdLineParams := TStringList.Create;
  fUser := '';
  fXMLFileName := '';
  fXmlClasses := '';
  fPassword := '';
  fDatabase := '';
  fServer := '';
  fRunBatch := False;
  fRunVerify := False;
  fExitOnComplete := False;
  fExcludeInactive:= False;
  fShowCommandLinesParamsHelp := False;
  fbImportFromXML := False;
  fbExportToXML:= False;
  GetVaildCmdLineParams;
  SetXMLImportResultDocName('');
  ProcessCmdLineParams;
end;

destructor TCommandLineFunctions.Destroy;
begin
  SysUtils.FreeAndNil(fCmdLineParams);
  inherited;
end;

procedure TCommandLineFunctions.GetVaildCmdLineParams;
var
  i: Integer;
begin
  for i := 1 to ParamCount do begin
    if Sysutils.SameText('/u:',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),3)) OR
      Sysutils.SameText('/p:',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),3)) OR
      Sysutils.SameText('/v',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),2)) OR
      Sysutils.SameText('/b',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),2)) OR
      Sysutils.SameText('/e',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),2)) OR
      Sysutils.SameText('/a',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),2)) OR
      Sysutils.SameText('/d:',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),3)) OR
      Sysutils.SameText('/s:',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),3)) OR
      Sysutils.SameText('/i:',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),3)) OR
      Sysutils.SameText('/X:',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),3)) OR
      Sysutils.SameText('/O:',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),3)) OR
      Sysutils.SameText('/R:',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),3)) OR
      Sysutils.SameText('/?',FastFuncs.LeftStr(FastFuncs.LowerCase(ParamStr(i)),2)) Then
      fCmdLineParams.Add(ParamStr(i));
  end;
end;

procedure TCommandLineFunctions.ProcessCmdLineParams;
var
  i: Integer;
begin
  for i := 0 to fCmdLineParams.Count-1 do begin
    if Sysutils.SameText('/u:',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),3)) Then Begin
      fUser := Trim(CommonLib.ReplaceStr(fCmdLineParams[i],'/u:',''));
    end else If Sysutils.SameText('/p:',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),3)) Then Begin
      fPassword := Trim(CommonLib.ReplaceStr(fCmdLineParams[i],'/p:',''));
    end else If Sysutils.SameText('/d:',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),3)) Then Begin
      fDatabase := Trim(CommonLib.ReplaceStr(fCmdLineParams[i],'/d:',''));
    end else If Sysutils.SameText('/s:',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),3)) Then Begin
      fServer := Trim(CommonLib.ReplaceStr(fCmdLineParams[i],'/s:',''));
    end else If Sysutils.SameText('/v',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),2)) Then Begin
      fRunVerify := True;
    end else If Sysutils.SameText('/b',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),2)) Then Begin
      fRunBatch := True;
    end else If Sysutils.SameText('/e',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),2)) Then Begin
      fExitOnComplete := True;
    end else If Sysutils.SameText('/a',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),2)) Then Begin
      fExcludeInactive := True;
    end else if Sysutils.SameText('/i:',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),3)) Then Begin
      fXmlfileName := Trim(CommonLib.ReplaceStr(fCmdLineParams[i],'/i:',''));
      fbImportFromXML:=True;
    end else if Sysutils.SameText('/R:',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),3)) Then Begin
      SetXMLImportResultDocName(Trim(CommonLib.ReplaceStr(fCmdLineParams[i],'/R:','')));
    end else if Sysutils.SameText('/X:',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),3)) Then Begin
      fXmlClasses := Trim(CommonLib.ReplaceStr(fCmdLineParams[i],'/X:',''));
      fbExportToXML:=True;
    end else if Sysutils.SameText('/O:',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),3)) Then Begin
      SetXMLExportResultDocName(Trim(CommonLib.ReplaceStr(fCmdLineParams[i],'/O:','')));
    end else If Sysutils.SameText('/?',FastFuncs.LeftStr(FastFuncs.LowerCase(fCmdLineParams[i]),2)) Then Begin
      fShowCommandLinesParamsHelp := True;
    end;
  end;
end;
Procedure TCommandLineFunctions.ExportToXMLFile;
var
    CE: TCustomExport;

begin
    if not fbExportToXML then Exit;
    CE := TCustomExport.Create;
    Try
        CE.ExcludeInactive := fExcludeInactive;
        CE.ExportClasses := fXmlClasses;
        CE.ExportToXML;
    finally
        FreeandNil(CE);
    end;
end;

Procedure TCommandLineFunctions.ImportFromXMLFile;
var
    CI: TCustomImport;
    resultnode      : IXMLNode;
begin
    if not fbImportFromXML then Exit;
    if  (fXmlfileName = '') or (fXmlfileName = 'NULL') then begin
        resultnode := NewResultNode('ImportFrom');
        resultnode.Attributes['FileName'] := '';
        resultnode.Attributes['Status'] := 'Filename is blank';
    End else if FileExists(fXmlfileName) = False then begin
        resultnode := NewResultNode('ImportFrom');
        resultnode.Attributes['FileName'] := fXmlfileName;
        resultnode.Attributes['Status'] := 'File doesn''t Exist';
    end else if uppercase(Copy(fXMLFileName, FastFuncs.PosEx('.' , fXMLFileName), 4)) <> '.XML' then begin
        resultnode := NewResultNode('ImportFrom');
        resultnode.Attributes['FileName'] := fXmlfileName;
        resultnode.Attributes['Status'] := 'Invalid file format, XML file expected';
    end else begin
        CI := TCustomImport.Create;
        Try
            CI.SilentMode := True;
            CI.ImportFromXMLFile(fXMLFileName);
        finally
            FreeandNil(CI);
        end;
    End;
End;
procedure TCommandLineFunctions.ExecBeforeLoginCmdLineParams;
begin
  If fShowCommandLinesParamsHelp then Begin
    MessageBox(0, 'ERP.exe [/U:Username] [/P:Password] [/V] [/B] [/E] [/A] [/I] [/R] [/X] [/O] [/?]'+#13+#10+''+#13+#10+
    '	/U:	- Username or Logon Name For '+#13+#10+'		  Used Directly In Conjunction with /P:'+#13+#10+''+#13+#10+
    '	/P:	- Password or Logon Password for Auto Login'+#13+#10+'		  Used Directly In Conjunction with /U:'+#13+#10+''+#13+#10+
    '	/D:	- Database For Auto Login'+#13+#10+'		  Can be used in Conjunction with Auto Login'+#13+#10+''+#13+#10+
    '	/V	- Starts a ''Verify and Fix All'' Immediately After Login'+#13+#10+' 		  Can be used in Conjunction with Auto Login '+#13+#10+''+#13+#10+
    '	/B	- Starts a ''Batch Update'' Immediately After Login'+#13+#10+' 		  Can be used in Conjunction with Auto Login'+#13+#10+''+#13+#10+
    '	/E	- Exits after Command Functions Completed'+#13+#10+'		  Used Directly In Conjunction with /V or /B'+#13+#10+''+#13+#10+
    '	/I:	- Import from XML file (Name of the XML File)'+#13+#10+'		  Using business objects'+#13+#10+''+#13+#10+
    '	/R:	- Name of the file to be produced for the import status For '+#13+#10+'		  Used Directly In Conjunction with /I.  The RPC call to Import from XML file uses this Parameter'+#13+#10+''+#13+#10+
    '	/X:	- Export ERP data  into an XML file(Class names separated with Comma)'+#13+#10+'		  Using business objects'+#13+#10+'		  Include the globalref''s within {} to filter the records while exporting '+#13+#10+''+#13+#10+
    '	/A	- Exclude Inactive records in XML Export'+#13+#10+''+#13+#10+''+#13+#10+
    '	/O:	- Exporting to file name For '+#13+#10+'		  Used Directly In Conjunction with /X. The RPC call to Export data to XML file uses this Parameter'+#13+#10+''+#13+#10+
    '	/?	- Displays This Help Message'+#13+#10+''+#13+#10+''+#13+#10+''+#13+#10+
    'Note : Using /I and /X together will ignore /X.' +#13+#10+''+#13+#10+
    'Examples:'+#13+#10+'[Login]'+#13+#10+' ERP.exe /U:Admin /P:Admin'+#13+#10+''+#13+#10+
    '[Login And Run Batch Update]'+#13+#10+' ERP.exe /U:Admin /P:Admin /B'+#13+#10+''+#13+#10+
    '[Login And Run Verify Then Exit]'+#13+#10+' ERP.exe /U:Admin /P:Admin /V /E'
    , 'ERP Command line Parameters Help'
    , MB_ICONASTERISK or MB_OK or MB_DEFBUTTON1);
    MainForm.TerminateApp;
  end;
end;

procedure TCommandLineFunctions.ExecAfterLoginCmdLineParams;
var
  TransactionTableObj: TTransactionTableObj;
//  ServicesClient: TtcServicesClient;
begin
 {should be after logon as the import needs the login for the userId
 and the other objects like defaultclass, employee etc
 which are used in the objects for default values etc.}


//  // Verify
//  If fRunVerify then Begin
//    if (MainForm.GetCurrentUserCount <= 1) then Begin
//      ServicesClient := TtcServicesClient.Create;
//      try
//        ServicesClient.LockLogonToDB('Performing Verification');
//        VerifyData(vtVerifyAll, True, fExitOnComplete);
//      finally
//        ServicesClient.UnLockLogonToDB;
//        FreeandNil(ServicesClient);
//      end;
//    end;
//  end;

  // Batch Update
  If fRunBatch then Begin
    TransactionTableObj := TTransactionTableObj.Create(False);
    try
      if (MainForm.GetCurrentUserCount <= 1) AND (MainForm.MDIChildCount <=1) then TransactionTableObj.InitforRefreshTrnsTable;
      TransactionTableObj.CleanRefreshTrnsTable(true, false, true, true);
    finally
      FreeandNil(TransactionTableObj);
    end;
  end;

  // Import From XML File Then Terminate App
  CommandLineFunctions.ImportFromXMLFile;

  // Export To XML File Then Terminate App
  CommandLineFunctions.ExportToXMLFile;

  // Exit When Finished
  If (fRunBatch OR fRunVerify OR fbExportToXML OR fbImportFromXML) AND fExitOnComplete then Begin
    MainForm.TerminateApp;
  end;
end;

end.
