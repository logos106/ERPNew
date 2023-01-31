unit frmATOSubmissions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, DB,
  DBAccess, MyAccess,ERPdbComponents, ExtCtrls, MemDS, Grids, Wwdbigrd, Wwdbgrid, DNMPanel,
  DNMSpeedButton, StdCtrls, wwcheckbox,wwdblook, Mask,
  wwdbedit, Wwdotdot, DBCtrls, Wwdbcomb, ImgList, ProgressDialog;

type TMatrix = array of array of string;


type
  TfrmATOSubmissionsGUI = class(TBaseInputGUI)
    grdMain: TwwDBGrid;
    DSSubmissions: TDataSource;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    cboYear: TComboBox;
    Label2: TLabel;
    chkActive: TwwCheckBox;
    chkTerminated: TwwCheckBox;
    chkProcessed: TwwCheckBox;
    cboMethod: TwwDBComboBox;
    btnSelectAll: TDNMSpeedButton;
    dlgSave: TSaveDialog;
    qryMain: TERPQuery;
    qryMainID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainIsTerminated: TWideStringField;
    qryMainDateTerminated: TDateField;
    qryMainMethod: TWideStringField;
    qryMainReportType: TWideStringField;
    qryMainProcess: TWideStringField;
    qryMainProcessCount: TFloatField;
    qryMainResult: TWideStringField;
    qryMainFiscalYear: TIntegerField;
    btnSubmit: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboYearChange(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnRecordingDirClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkProcessedClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
  private
    { Private declarations }
    iYear: integer;
    YearStart,
    YearEnd: TDateTime;
    DirectoryPath:String;
    procedure CreateTempTable;
    procedure PopulateTempTable(const iYear:integer; const ReportType:String);
    procedure DeleteDataTempTable;
    procedure SaveDetails(iSubmissionID:integer);
    function GetTempTableName: string;
    function GetNewSubmissionID:integer;
    procedure RetrieveProcessCount;
    procedure BackEndDetailsToTemp;
    Function GetETPpayerType:String;
    Function HasETP(iEmployeeID:integer):Boolean;
    procedure CalcDateRange;
  Protected

  public
    { Public declarations }
    procedure SaveSubmission;
  end;

implementation
{$WARN UNIT_PLATFORM OFF}
uses
  CommonDbLib,PayEmpdupeObj,{$WARNINGS OFF}FileCtrl{$WARNINGS ON},CommonLib,  AppEnvironment,
  FastFuncs, MySQLConst, DNMLib,  ATODataObj, ShellAPI;
{$R *.dfm}
procedure TfrmATOSubmissionsGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    iYear := FastFuncs.StrToInt(cboYear.Text)-1;
    CalcDateRange;
    DeleteDataTempTable;
    PopulateTempTable(iYear,'IndividualPAYG');
    { ETP needs lots of work so remove for now }
    // PopulateTempTable(iYear,'ETP');
    /////////////////////////////////////////////////  TO DO
    //    PopulateTempTable(iYear,'VoluntaryPAYG');
    //    PopulateTempTable(iYear,'LabourHire');
    //    PopulateTempTable(iYear,'PersonalServices');
    ///////////////////////////////////////////////////
    qryMain.Open;
    BackEndDetailsToTemp;
  finally
    EnableForm;
  end;
end;

procedure TfrmATOSubmissionsGUI.BackEndDetailsToTemp;
{ If there are records in tblatosubmissiondetails that match
 get the record count
 }
begin
  RetrieveProcessCount


end;

procedure TfrmATOSubmissionsGUI.RetrieveProcessCount;
var
  qry:TERPQuery;
  bFound: Boolean;
  bm: TBookmark;
begin
  try
    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDACConnection;
    with qry do begin
      qry.SQL.Clear;
      qry.SQL.Add('SELECT * FROM tblatosubmissiondetails WHERE FiscalYear = ');
      qry.SQL.Add(cboYear.Text);
      Open;
      bm := qryMain.GetBookmark;
      qryMain.DisableControls;
      Try
      qryMain.First;
      while not qryMain.Eof do begin
        bFound := False;
        First;
        while not Eof do begin
          if (qryMain.FieldByName('EmployeeID').AsInteger = FieldByName('EmployeeID').AsInteger)
            and (qryMain.FieldByName('ReportType').AsString = FieldByName('ReportType').AsString) then begin //'IndividualPAYG') then begin
            bFound := True;
            break;
          end;
          Next;
        end;
        if bFound = True then begin
          qryMain.Edit;
          qryMain.FieldByName('ProcessCount').AsInteger := FieldByName('ProcessCount').AsInteger;
          qryMain.FieldByName('Result').AsString := FieldByName('Result').AsString;
        end;
        qryMain.Next;
      end;
      Finally
        qryMain.GotoBookmark(bm);
        qryMain.FreeBookmark(bm);
        qryMain.EnableControls;        
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmATOSubmissionsGUI.FormCreate(Sender: TObject);
var
  dtTest: TDateTime;
  wYearEnd, wYear, wMonth, wDay: word;
  iX: integer;
begin
  CreateTempTable;
  qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'FROM aaaaa', 'FROM ' + GetTempTableName);
  inherited;

  dtTest := Now;
  DecodeDate(dtTest, wYear, wMonth, wDay);
  cboYear.Items.Clear;
  iX := wMonth;
  if iX <= 6 then begin
    cboYear.Text := IntToStr(wYear);
  end else begin
    cboYear.Text := IntToStr(wYear + 1);
  end;

  wYear := wYear - 15;
  wYearEnd := wYear + 30;
  for iX := wYear to wYearEnd do begin
    cboYear.Items.Add(IntToStr(iX));
  end;

end;

procedure TfrmATOSubmissionsGUI.CreateTempTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDACConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetTempTableName + '`');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE `' + GetTempTableName + '` (');
    qry.SQL.Add('`ID` int(11)  NOT NULL auto_increment,');
    qry.SQL.Add('`EmployeeID` int(11) default ''0'',');
    qry.SQL.Add('`EmployeeName` varchar(255) default NULL,');
    qry.SQL.Add('`Active` enum("T","F"),');
    qry.SQL.Add('`IsTerminated` enum("T","F"),');
    qry.SQL.Add('`DateTerminated` date default NULL,');
    qry.SQL.Add('`Method` enum("ELECTRONIC","MANUAL","N/A") default "ELECTRONIC",');
    qry.SQL.Add('`ReportType` enum("IndividualPAYG","ETP","VoluntaryPAYG","LabourHire","PersonalServices"),');
    qry.SQL.Add('`Process` enum("Yes","No") default "No",');
    qry.SQL.Add('`ProcessCount` DOUBLE,');
    qry.SQL.Add('`Result` varchar(255) default NULL,');
    qry.SQL.Add('`FiscalYear` int(11) ,');
    qry.SQL.Add('PRIMARY KEY  (`ID`),');
 //   qry.SQL.Add('UNIQUE KEY `ID` (`ID`),');
    qry.SQL.Add('KEY `ID_2` (`ID`)');
    qry.SQL.Add(') Engine=InnoDB COMMENT=''ATO Submissions''');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmATOSubmissionsGUI.DeleteDataTempTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DELETE FROM  ' + GetTempTableName + '; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;


procedure TfrmATOSubmissionsGUI.PopulateTempTable(const iYear:integer; const ReportType:String);
var
  qry :TERPQuery;
  qryTemp: TERPQuery;
  InsertSQL:String;
begin
  qry := TERPQuery.Create(Self);
  qryTemp := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    InsertSQL := 'INSERT INTO ' + GetTempTableName +
     '(EmployeeID,EmployeeName,Active,IsTerminated,DateTerminated,ReportType,FiscalYear)';

    with qryTemp do begin
      Sql.Clear;
      if ReportType <> 'ETP' then  begin
        SQL.Add('SELECT Distinct');         //get the active employee and the terminations for year
        SQL.Add('tblemployees.EmployeeID, ');

        SQL.Add('tblemployees.EmployeeName, ');
        SQL.Add('Active, ');
        SQL.Add('IsTerminated, ');
        SQL.Add('IfNull(tblEmployeeTerminations.EndDate,IfNull(tblemployees.DateFinished,"1900-01-01")) AS DateTerminated, ');
        SQL.Add(QuotedStr(ReportType) + ',');
        SQL.Add(IntToStr(iYear)+',');
        //SQL.Add('tblpays.Pay ,');
        SQL.Add('tblpays.EmployeeID ');
        SQL.Add('FROM tblemployees ');

//        SQL.Add('INNER JOIN tblpays ON tblpays.employeeID = tblemployees.EmployeeID and tblpays.PayDate between :FromDate and :Todate and tblpays.Deleted = "F"');
        { 2017-10-04 NOTE Changed to match TPAYGPaymentSummaryListGUI .. ie DatePaid from PayDate as ATO requires actual payment date }
        SQL.Add('INNER JOIN tblpays ON tblpays.employeeID = tblemployees.EmployeeID and tblpays.DatePaid between :FromDate and :Todate and tblpays.Deleted = "F"');
        SQL.Add('LEFT JOIN tblEmployeeTerminations on tblEmployeeTerminations.EmployeeID = tblemployees.EmployeeID');
        { NOTE: the following was removed because it was excluding employees terminated in one year
          but their final pay was in next year }
//        SQL.Add('WHERE (IsTerminated = "F" )');
//        SQL.Add('OR ((not isnull(tblEmployeeTerminations.EndDate)) and tblEmployeeTerminations.EndDate >= :FromDate  and tblEmployeeTerminations.Complete = "T")');
//        SQL.Add('OR ((IsTerminated = "T") and (tblemployees.DateFinished between :FromDate and :ToDate))');
        ParamByName('FromDate').AsDateTime := YearStart;
        ParamByName('ToDate').AsDateTime := YearEnd;
      end
      else begin
//        SQL.Add('UNION ');

        SQL.Add('SELECT ');
        SQL.Add('EmployeeID, ');

        SQL.Add('EmployeeName, ');
        SQL.Add('"F" as Active, ');
        SQL.Add('"T" as IsTerminated, ');
        SQL.Add('EndDate AS DateTerminated,');
        SQL.Add(QuotedStr(ReportType) + ',');
        SQL.Add(IntToStr(iYear));
        //SQL.Add('"F" as Pay ,');
        SQL.Add(',EmployeeID ');
        SQL.Add('FROM tblemployeeterminations ');
        SQL.Add('WHERE EndDate BETWEEN  '+ QuotedStr(IntToStr(iYear - 1) + '-06-30')+ ' AND ' + QuotedStr(IntToStr(iYear) + '-07-01'));
        SQL.Add(' ORDER BY EmployeeName');
      end;
      qryTemp.Open;
      qryTemp.First;
      while not qryTemp.eof do begin
        qry.SQL.Clear;
        qry.SQL.Add(InsertSQL);
        qry.SQL.Add('VALUES (' + qryTemp.FieldByName('EmployeeID').AsString + ',' );
        qry.SQL.Add(QuotedStr(qryTemp.FieldByName('EmployeeName').AsString) + ',');
        qry.SQL.Add(QuotedStr(qryTemp.FieldByName('Active').AsString) + ',');
        qry.SQL.Add(QuotedStr(qryTemp.FieldByName('IsTerminated').AsString) + ',');
        qry.SQL.Add(QuotedStr(qryTemp.FieldByName('DateTerminated').AsString));
        qry.SQL.Add(',' + QuotedStr(ReportType));
        qry.SQL.Add(',' + IntToStr(iYear));

        qry.SQL.Add(')');
        qry.Execute;

        qryTemp.Next;
      end;
    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(qryTemp);
  end;
end;

function TfrmATOSubmissionsGUI.GetTempTableName: string;
begin
  Result := 'tmp_atosubmissions_' + GetMachineIdentification(true, true, true, true);
end;


procedure TfrmATOSubmissionsGUI.cboYearChange(Sender: TObject);
begin
  inherited;
  qryMain.Close;
  DeleteDataTempTable;
  iYear := FastFuncs.StrToInt(cboYear.Text);
  CalcDateRange;
  PopulateTempTable(FastFuncs.StrToInt(cboYear.Text),'IndividualPAYG');
  { ETP needs lots of work .. so removed for now }
  //  PopulateTempTable(iYear,'ETP');

//  PopulateTempTable(iYear,'VoluntaryPAYG');
//  PopulateTempTable(iYear,'LabourHire');
//  PopulateTempTable(iYear,'PersonalServices');
  qryMain.Open;
end;

Function TfrmATOSubmissionsGUI.HasETP(iEmployeeID:integer):Boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblemployeeterminations WHERE EmployeeID = ' + IntToStr(iEmployeeID));
    qry.SQL.Add(' AND EndDate BETWEEN ' + QuotedStr(IntToStr(iYear - 1) + '-06-01')) ;
    qry.SQL.Add(' AND ' + QuotedStr(IntToStr(iYear) + '-07-01'));
    qry.Open;
    qry.Last;
//    if qry.FieldByName('GrossETP').AsFloat > 0 then result := True else result := False;
    if qry.FieldByName('ETPTotal').AsFloat > 0 then result := True else result := False;

  finally
    FreeAndNil(qry);
  end;
end;

Function TfrmATOSubmissionsGUI.GetETPpayerType:String;
var
  bm: TBookmark;
  i:integer;
begin
  //did any of the selected employees get  ETP's?
  result := ' ';
  with qryMain do begin
    bm := GetBookmark;
    DisableControls;
    First;

    for i := 0 to recordcount - 1  do begin
      if FieldByName('Process').AsString = 'Yes' then begin
        if FieldByName('Method').AsString = 'ELECTRONIC' then begin
          if HasETP(FieldByName('EmployeeID').AsInteger) then begin
            result := 'P';  //currently ERP does not deal with ETP associated with superannuation 'S'
          end;
        end;
      end;
      qryMain.Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;
end;

procedure TfrmATOSubmissionsGUI.btnCompletedClick(Sender: TObject);
var
  iSubmissionID:integer;
  ATOFile:TPayEmpdupeObj;
  i:integer;
  tmpStr:String;
  bm: TBookmark;
  ExportFileName:string;
  FileOk: boolean;
begin
  DisableForm;
  fileOk:= true;
  try
    inherited;
    dlgSave.Title := 'Export - ' + Caption;
    if dlgSave.Execute then begin
      ExportFileName := dlgSave.FileName;
      DirectoryPath := dlgSave.GetNamePath;
    end else begin
      exit;
    end;

    ATOFile := TPayEmpdupeObj.Create;
    try
      //Save data to tblatosubmissions
      SaveSubmission;
      iSubmissionID := GetNewSubmissionID;

      //create ATO submission files
      ATOFile.CreateATOFileHeader( ExportFileName,iSubmissionID,iYear);   //'EMPDUPE.A01',iSubmissionID,iYear,DirectoryPath) ;

      //Add Payer Identity

      ATOFile.AddPayer(iYear,GetETPpayerType); //To do; set etp flag P, S or blank
      ATOFile.AddSoftwareRec;

      with qryMain do begin
        bm := GetBookmark;
        DisableControls;
        try
          First;

          for i := 0 to recordcount - 1  do begin
            if FieldByName('Process').AsString = 'Yes' then begin
              if FieldByName('Method').AsString = 'ELECTRONIC' then begin
                if FieldByName('ReportType').AsString = 'IndividualPAYG' then begin
                  tmpStr := ATOFile.AddIndividual(FieldByName('EmployeeID').AsInteger,iYear,FieldByName('IsTerminated').AsString);
                  Edit;
                  FieldByName('Result').AsString := tmpStr;

                  if tmpStr = 'Success' then begin

                  end else begin

                  end;
                end;
              end;
            end;
            qryMain.Next;
          end;

          First;
          for i := 0 to recordcount - 1 do begin
            if FieldByName('Process').AsString = 'Yes' then begin
              if FieldByName('Method').AsString = 'ELECTRONIC' then begin
                if FieldByName('ReportType').AsString = 'VoluntaryPAYG' then begin
                  tmpStr := ATOFile.AddVoluntary(FieldByName('EmployeeID').AsInteger);
                  Edit;
                  FieldByName('Result').AsString := tmpStr;
                  if tmpStr = 'Success' then begin

                  end else begin

                  end;
                end;
              end;
            end;
            qryMain.Next;
          end;

          First;
          for i := 0 to recordcount - 1 do begin
            if FieldByName('Process').AsString = 'Yes' then begin
              if FieldByName('Method').AsString = 'ELECTRONIC' then begin
                if FieldByName('ReportType').AsString = 'LabourHire' then begin
                  tmpStr := ATOFile.AddLabourHire(FieldByName('EmployeeID').AsInteger);
                  Edit;
                  FieldByName('Result').AsString := tmpStr;
                  if tmpStr = 'Success' then begin

                  end else begin

                  end;
                end;
              end;
            end;
            qryMain.Next;
          end;

          First;
          for i := 0 to recordcount - 1 do begin
            if FieldByName('Process').AsString = 'Yes' then begin
              if FieldByName('Method').AsString = 'ELECTRONIC' then begin
                if FieldByName('ReportType').AsString = 'PersonalServices' then begin
                  tmpStr := ATOFile.AddPersonalServices(FieldByName('EmployeeID').AsInteger);
                  Edit;
                  FieldByName('Result').AsString := tmpStr;
                  if tmpStr = 'Success' then begin

                  end else begin

                  end;
                end;
              end;
            end;
            qryMain.Next;
          end;

          First;
          for i := 0 to recordcount - 1 do begin
            if FieldByName('Process').AsString = 'Yes' then begin
              if FieldByName('Method').AsString = 'ELECTRONIC' then begin
                if FieldByName('ReportType').AsString = 'ETP' then begin
                  if not HasETP(FieldByName('EmployeeID').AsInteger) then begin
                    fileOk:= false;
                    CommonLib.MessageDlgXP_Vista(FieldByName('EmployeeName').AsString +
                      ' does not have any ETPs.' + #13#10 + #13#10 +
                      'File will not be created.', mtInformation, [mbOK], 0);
                    exit;
                  end;
                  tmpStr := ATOFile.AddETP(FieldByName('EmployeeID').AsInteger);
                  Edit;
                  FieldByName('Result').AsString := tmpStr;
                  if tmpStr = 'Success' then begin

                  end else begin

                  end;
                end;
              end;
            end;
            qryMain.Next;
          end;
        finally
          EnableControls;
          GotoBookmark(bm);
          FreeBookmark(bm);
        end;
        ATOFile.AddFileTotalRec;
        SaveDetails(iSubmissionID);
      end;
    finally
      ATOFile.CloseExportFile;
      FreeAndNil(ATOFile);
      if fileOk then
        CommonLib.MessageDlgXP_Vista('File created.', mtInformation, [mbOK], 0)
      else
        DeleteFile(ExportFileName);
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmATOSubmissionsGUI.SaveDetails(iSubmissionID:integer);
var
  qry,qryInsert:TERPQuery;
  InsertSQL:String;
  bFound: Boolean;
  bm: TBookmark;
begin
  InsertSQL := 'INSERT INTO tblatosubmissiondetails' +
     '(SubmissionID,EmployeeID,EmployeeName,Active,IsTerminated,DateTerminated,' +
       'Method,ReportType,Result,FiscalYear,ProcessCount)';

  qry := TERPQuery.Create(nil);
  qryInsert := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryInsert.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblatosubmissiondetails WHERE FiscalYear = ' + IntToStr(iYear));
    qry.Open;

    bm := qryMain.GetBookmark;
    qryMain.DisableControls;
    Try
      qryMain.First;
      while not qryMain.Eof do begin
        qry.First;
        bFound := False;
        while not qry.Eof do begin
          if (qryMain.FieldByName('ReportType').AsString = qry.FieldByName('ReportType').AsString)
            and (qryMain.FieldByName('EmployeeID').AsInteger = qry.FieldByName('EmployeeID').AsInteger) then begin
            bFound := True;
            break;
          end;
          qry.Next;
        end;
        if bFound = False then begin
          if qryMain.FieldByName('Process').AsString = 'Yes' then begin
            // insert new
            qryInsert.SQL.Clear;
            qryInsert.SQL.Add(InsertSQL);
            qryInsert.SQL.Add(' (SELECT ' + IntToStr(iSubmissionID) + ' AS SubmissionID,');
            qryInsert.SQL.Add('EmployeeID,EmployeeName,Active,IsTerminated,DateTerminated,');
            qryInsert.SQL.Add('Method,ReportType,Result,' + IntToStr(iYear) + ',1' );
            qryInsert.SQL.Add(' FROM ' + GetTempTableName + ' WHERE Process = ' + QuotedStr('Yes'));
            qryInsert.SQL.Add(' AND EmployeeID = ' + qryMain.FieldByName('EmployeeID').AsString);
            qryInsert.SQL.Add(' AND ReportType = ' + QuotedStr(qryMain.FieldByName('ReportType').AsString) + ')');
            qryInsert.Execute;
            qryMain.Edit;
            qryMain.FieldByName('ProcessCount').AsInteger := 1;
          end;
        end else begin
          // update process count and result
          if qryMain.FieldByName('Process').AsString = 'Yes' then begin
            qry.Edit;
            qry.FieldByName('ProcessCount').AsInteger :=  qry.FieldByName('ProcessCount').AsInteger + 1;
            qryMain.Edit;
            qryMain.FieldByName('ProcessCount').AsInteger := qry.FieldByName('ProcessCount').AsInteger;
            qry.FieldByName('Result').AsString := qryMain.FieldByName('Result').AsString;
          end;
        end;
        qryMain.Next;
      end;
    Finally
     qryMain.EnableControls;
     qryMain.GotoBookmark(bm);
     qryMain.FreeBookmark(bm);
    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(qryInsert);
  end;
end;

procedure TfrmATOSubmissionsGUI.SaveSubmission;
var
  qry:TERPQuery;
  InsertSQL:String;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    InsertSQL := 'INSERT INTO tblatosubmissions' +
     '(IsEmployeeSub,Type,DateSubmitted,WhoCreated)';

    qry.SQL.Add(InsertSQL);
    qry.SQL.Add('VALUES (' + QuotedStr('T') + ',');
    qry.SQL.Add(QuotedStr('EMPDUPE') + ',');
    qry.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat,Now)) + ',' );
    qry.SQL.Add(IntToStr(AppEnv.Employee.EmployeeID) + ')' );
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

function TfrmATOSubmissionsGUI.GetNewSubmissionID:integer;
var
  qry:TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT SubmissionID,DateSubmitted FROM tblatosubmissions ');
    qry.SQL.Add('ORDER BY DateSubmitted ASC');
    qry.Open;
    qry.Last;
    result := qry.FieldByName('SubmissionID').AsInteger;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmATOSubmissionsGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmATOSubmissionsGUI.btnRecordingDirClick(Sender: TObject);
var
  sDir: string;
  sRoot: string;
begin
  inherited;
  sRoot := '';
  sDir := '';
  if SelectDirectory('Recording Path', sRoot, sDir) then begin
    DirectoryPath := sDir;
  end;
end;

procedure TfrmATOSubmissionsGUI.btnSelectAllClick(Sender: TObject);
var
  bm: TBookmark;
begin
  inherited;
  bm := qryMain.GetBookmark;
  qryMain.DisableControls;
  try
    qryMain.First;
    while not qryMain.Eof do begin
      qryMain.Edit;
      qryMain.FieldByName('Process').AsString := 'Yes';
      qryMain.Post;
      qryMain.Next;
    end;
  Finally
    qryMain.EnableControls;
    qryMain.GotoBookmark(bm);
    qryMain.FreeBookmark(bm);
  end;
end;

procedure TfrmATOSubmissionsGUI.btnSubmitClick(Sender: TObject);
begin
  inherited;
  ShellExecute(0, 'open', 'https://bp.ato.gov.au/', nil, nil, sw_shownormal);
end;

procedure TfrmATOSubmissionsGUI.CalcDateRange;
begin
  YearStart:= EncodeDate(iYear-1,GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts),01);
  YearEnd:= EncodeDate(iYear,GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts),01)-1;
end;
procedure TfrmATOSubmissionsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if (Field.FieldName = 'DateTerminated') then begin
    if (Field.Text = '01/01/1900') then begin
      AFont.Color := ABrush.Color;
    end;
  End;
end;

procedure TfrmATOSubmissionsGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Closequeries;
  Action := caFree;
end;

procedure TfrmATOSubmissionsGUI.chkProcessedClick(Sender: TObject);
var
  qry :TERPQuery;
begin
  inherited;
  qry := TERPQuery.Create(nil) ;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    if qryMain.State in [dsInsert, dsEdit] then begin
      if chkProcessed.Checked then begin
        if qryMainProcess.AsString <> 'Yes' then begin
          qryMainProcess.AsString := 'Yes';
        end;
        { ETP needs lots of work so remove for now }
//        if (HasETP(qryMain.FieldByName('EmployeeID').AsInteger))
//          and (qryMain.FieldByName('ReportType').AsString = 'IndividualPAYG') then begin
//
//          CommonLib.MessageDlgXP_Vista(qryMain.FieldByName('EmployeeName').AsString + '  has ETP. The ETP report must also be created.', mtInformation, [mbOK], 0);
//
//          qryMain.Locate('EmployeeID;ReportType', VarArrayOf([qryMain.FieldByName('EmployeeID').AsInteger, 'ETP']), [loPartialKey]);
//          chkProcessed.Checked := True;
//          qryMain.Edit;
//          qryMainProcess.AsString := 'Yes';
//        end;
      end else begin
        if qryMainProcess.AsString = 'Yes' then begin
          qryMainProcess.AsString := 'No';
        end;
        with qry do begin
          SQL.Clear;
          SQL.Add('UPDATE tblatosubmissiondetails SET process = ' + QuotedStr('No'));
          SQL.Add(' WHERE EmployeeID = ' + IntToStr(qryMain.FieldByName('EmployeeID').AsInteger) +   ' AND ReportType = ' + QuotedStr('ETP'));
          Execute;
        end;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

initialization
  RegisterClassOnce(TfrmATOSubmissionsGUI);

end.
