unit frmETPList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TfrmETPReport = class(TBaseListingGUI)
    qryEmployee: TERPQuery;
    qryMainEmployeeName: TWideStringField;
    qryMainGrossTermination: TFloatField;
    qryMainEmployeeID: TIntegerField;
    qryMainStartDate: TDateTimeField;
    qryMainEndDate: TDateTimeField;
    qryMainTerminationID: TIntegerField;
    procedure grdMainDblClick(Sender: TObject);Override;   //reintroduce;
    procedure actRefreshQryExecute(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    procedure CreateTempTable;
    procedure PopulateETPTable;
    procedure ProduceETPstatement(bPreview: boolean);
    function GetTempTableName: string;
  protected
    procedure RefreshQuery; override;
  public

  end;

implementation

uses FastFuncs,CommonDbLib,CommonLib, ReportTemplates, MySQLConst;

{$R *.dfm}

procedure TfrmETPReport.RefreshQuery;
begin
  qryMain.Close;
  qryMain.Params.ParamByName('dtFrom').AsString := FormatDateTime(MysqlDateFormat, dtfrom.DateTime);
  qryMain.Params.ParamByName('dtTo').AsString := FormatDateTime(MysqlDateFormat, dtto.DateTime);
  inherited;
end;

procedure TfrmETPReport.grdMainDblClick(Sender: TObject);
var
  iTerminationID:integer;
begin
//  inherited;
  iTerminationID := qryMain.FieldByName('TerminationID').AsInteger;
  if qryEmployee.Active then qryEmployee.Close;
  qryEmployee.Params.ParamByName('xTerminationID').AsInteger := iTerminationID;
  qryEmployee.Open;               
  CreateTempTable;
  PopulateETPTable;
  ProduceETPstatement(True);
end;

procedure TfrmETPReport.PopulateETPTable;
var
  qry: TERPQuery;
  qryInfo: TERPQuery;
  wYear, wMonth, wDay: word;

begin
  qry := nil;
  qryInfo := nil;
  try
    qryInfo := TERPQuery.Create(nil);
    qryInfo.Connection := CommonDbLib.GetSharedMyDACConnection;
    qryInfo.SQL.Clear;
    qryInfo.SQL.Add('SELECT * FROM tblcompanyinformation');
    qryInfo.Open;

    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDACConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM ' + GetTempTableName);
    qry.Open;

    qryEmployee.Open;

    qry.Insert;
    qry.FieldByName('PayeeFirstname').AsString := qryEmployee.FieldByName('FirstName').AsString;
    qry.FieldByName('PayeeSurname').AsString  := qryEmployee.FieldByName('LastName').AsString;
    qry.FieldByName('PayeeMiddleName').AsString := qryEmployee.FieldByName('MiddleName').AsString;
    qry.FieldByName('PayeeAddress').AsString  := qryEmployee.FieldByName('Street').AsString;
    qry.FieldByName('PayeeAddress2').AsString := qryEmployee.FieldByName('Street2').AsString;
    qry.FieldByName('TFN').AsString           := qryEmployee.FieldByName('TFN').AsString;
    qry.FieldByName('PayeeSuburb').AsString   := qryEmployee.FieldByName('Suburb').AsString;
    qry.FieldByName('PayeeState').AsString    := qryEmployee.FieldByName('State').AsString;
    qry.FieldByName('PayeePostcode').AsString := qryEmployee.FieldByName('Postcode').AsString;

    DecodeDate(qryEmployee.FieldByName('StartDate').AsDateTime, wYear, wMonth, wDay);
    qry.FieldByName('DateStartedDay').AsInteger   := wDay;
    qry.FieldByName('DateStartedMonth').AsInteger := wMonth;
    qry.FieldByName('DateStartedYear').AsInteger  := wYear;

    DecodeDate(qryEmployee.FieldByName('DOB').AsDateTime, wYear, wMonth, wDay);
    qry.FieldByName('DOBDay').AsInteger   := wDay;
    qry.FieldByName('DOBMonth').AsInteger := wMonth;
    qry.FieldByName('DOBYear').AsInteger  := wYear;

    DecodeDate(qryEmployee.FieldByName('EndDate').AsDateTime, wYear, wMonth, wDay);     //ET.DatePaid, wYear, wMonth, wDay);
    qry.FieldByName('DateOfPaymentDay').AsInteger   := wDay;
    qry.FieldByName('DateOfPaymentMonth').AsInteger := wMonth;
    qry.FieldByName('DateOfPaymentYear').AsInteger  := wYear;

    qry.FieldByName('NumDaysBefore1July1983').AsInteger := qryEmployee.FieldByName('DaysServicePre01071983').AsInteger;//empTermination.DaysServiceTo30Jun1983;
    qry.FieldByName('NumDaysAfter30June1983').AsInteger := qryEmployee.FieldByName('DaysServicePost30061983').AsInteger;//empTermination.DaysServiceFrom1July1983;
    
    // ETP values.
    qry.FieldByName('PreJuly1983').AsFloat   := qryEmployee.FieldByName('ETPPre071983').AsFloat;//EmpTermination.ETPpreJul1983;  //ET.PreJuly1983;
    qry.FieldByName('PostJune1983').AsFloat  := qryEmployee.FieldByName('ETPPost061983taxed').AsFloat; //EmpTermination.TaxableETPAmt; //     .ETPpostJun1983;    //ET.PostJune1983;
    qry.FieldByName('PostJune1994').AsFloat  := qryEmployee.FieldByName('ETPPost061994Component').AsFloat; //EmpTermination.ETPpostJun1994;     //ET.PostJune1994;
    qry.FieldByName('GrossETP').AsFloat      := qryEmployee.FieldByName('GrossTermination').AsFloat; //EmpTermination.GrossETP;
    qry.FieldByName('AssessableAmt').AsFloat := system.Round(qryEmployee.FieldByName('ETPAssessable').AsFloat);              //EmpTermination.AssesableETP);
    //EmpTermination.TaxableETPAmt+ (0.05 * empTermination.ETPpreJul1983));
    qry.FieldByName('ETPTaxWithheld').AsFloat := qryEmployee.FieldByName('TaxWithheld').AsFloat;  //EmpTermination.ETPtaxWitheld;  //ET.ETPTaxAmt;

    if qryEmployee.FieldByName('DeathBenefit').AsString = 'T' then begin
      // Yes, then tick appropriate death benefit.
      qry.FieldByName('DeathBenefitYes').AsString := 'X';
      qry.FieldByName('DeathBenefitNo').AsString := ' ';
   //   if cboDeathPaidTo.Text = 'Trustee' then begin
     if qryEmployee.FieldByName('TypeOfDeathBenifit').AsString = 'Trustee' then begin
        qry.FieldByName('DBTrustee').AsString := 'X';
        qry.FieldByName('DBNonDependant').AsString := ' ';
      end else begin
        qry.FieldByName('DBTrustee').AsString := ' ';
        qry.FieldByName('DBNonDependant').AsString := 'X';
      end;
    end else begin
      qry.FieldByName('DeathBenefitYes').AsString := ' ';
      qry.FieldByName('DeathBenefitNo').AsString := 'X';
      qry.FieldByName('DBTrustee').AsString := ' ';
      qry.FieldByName('DBNonDependant').AsString := ' ';
    end;

    qry.FieldByName('CompanyABN').AsString    := qryInfo.FieldByName('ABN').AsString;
    qry.FieldByName('PayerName').AsString     := qryInfo.FieldByName('CompanyName').AsString;
    qry.FieldByName('PayerAddress').AsString  := qryInfo.FieldByName('Address').AsString;
    qry.FieldByName('PayerAddress2').AsString := qryInfo.FieldByName('Address2').AsString;
    qry.FieldByName('PayerSuburb').AsString   := qryInfo.FieldByName('City').AsString;
    qry.FieldByName('PayerState').AsString    := qryInfo.FieldByName('State').AsString;
    qry.FieldByName('PayerPostcode').AsString := qryInfo.FieldByName('Postcode').AsString;
    qry.FieldByName('PayerPhone').AsString    := qryInfo.FieldByName('PhoneNumber').AsString;
    qry.Post;
  finally
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qryInfo) then FreeAndNil(qryInfo);
  end;
end;

procedure TfrmETPReport.ProduceETPstatement(bPreview: boolean);
var
  sSQL: string;
  Templates :TReportTemplates;
begin
  Templates := TReportTemplates.Create;
  try
    with Templates do begin
      if not CreatedOk then exit;
      sSQL := GetSQLForReport('ETP Payment Summary'); // creates  report stream
      sSQL := 'SELECT * FROM ' + GetTempTableName;
      with GetMyQuery(1) do begin
        Close;
        Sql.Clear;
        Sql.Add(sSQL);
        Open;
      end;

      Report.Template.LoadFromStream(ReportStream);
      Report.ShowPrintDialog := false;

      if not bPreview then begin
        Report.DeviceType := 'Printer';
      end;

      Report.PrinterSetup.Copies := 1;
      Templates.MaxPreview := True;
      Try
        Report.Print;
      except
        on E: Exception do begin
          If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
            CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
          end else
            raise;
        end;
      end;


    end;
  finally
    if Assigned(Templates) then
      FreeAndNil(Templates);
  end;
end;

procedure TfrmETPReport.CreateTempTable;
var
  qry: TERPQuery;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDACConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetTempTableName + '`');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE `' + GetTempTableName + '` (');
    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment,');
    qry.SQL.Add('`PreJuly1983` double default ''0'',');
    qry.SQL.Add('`PostJune1983` double default ''0'',');
    qry.SQL.Add('`PostJune1994` double default ''0'',');
    qry.SQL.Add('`GrossETP` double default ''0'',');
    qry.SQL.Add('`ETPTaxWithheld` double default ''0'',');
    qry.SQL.Add('`AssessableAmt` double default ''0'',');
    qry.SQL.Add('`DeathBenefitNo` char(1) default ''N'',');
    qry.SQL.Add('`DeathBenefitYes` char(1) default ''N'',');
    qry.SQL.Add('`NumDaysBefore1July1983` int(11) default ''0'',');
    qry.SQL.Add('`NumDaysAfter30June1983` int(11) default ''0'',');
    qry.SQL.Add('`DateStartedDay` int(11) default NULL,');
    qry.SQL.Add('`DateStartedMonth` int(11) default NULL,');
    qry.SQL.Add('`DateStartedYear` int(11) default ''0'',');
    qry.SQL.Add('`DateOfPaymentDay` int(11) default NULL,');
    qry.SQL.Add('`DateOfPaymentMonth` int(11) default NULL,');
    qry.SQL.Add('`DateOfPaymentYear` int(11) default NULL,');
    qry.SQL.Add('`DOBDay` int(11) default NULL,');
    qry.SQL.Add('`DOBMonth` int(11) default NULL,');
    qry.SQL.Add('`DOBYear` int(11) default NULL,');
    qry.SQL.Add('`TFN` varchar(9) default NULL,');
    qry.SQL.Add('`PayeeSurname` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeFirstname` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeMiddleName` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeAddress` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeAddress2` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeSuburb` varchar(255) default NULL,');
    qry.SQL.Add('`PayeeState` varchar(255) default NULL,');
    qry.SQL.Add('`PayeePostcode` varchar(255) default NULL,');
    qry.SQL.Add('`CompanyABN` varchar(15) default NULL,');
    qry.SQL.Add('`PayerName` varchar(255) default NULL,');
    qry.SQL.Add('`PayerAddress` varchar(255) default NULL,');
    qry.SQL.Add('`PayerAddress2` varchar(255) default NULL,');
    qry.SQL.Add('`PayerSuburb` varchar(255) default NULL,');
    qry.SQL.Add('`PayerState` varchar(255) default NULL,');
    qry.SQL.Add('`PayerPostcode` varchar(255) default NULL,');
    qry.SQL.Add('`PayerPhone` varchar(255) default NULL,');
    qry.SQL.Add('`DBTrustee` char(1) default NULL,');
    qry.SQL.Add('`DBNonDependant` char(1) default NULL,');
    qry.SQL.Add('PRIMARY KEY  (`ID`),');
    qry.SQL.Add('UNIQUE KEY `ID` (`ID`),');
    qry.SQL.Add('KEY `ID_2` (`ID`)');
    qry.SQL.Add(') ENGINE=InnoDB COMMENT=''ETP Payment Statement''');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TfrmETPReport.GetTempTableName: string;
begin
  Result := 'tmp_payetpstatement_' + GetMachineIdentification(true, true, true, true);
end;

procedure TfrmETPReport.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmETPReport.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
   // inherited;
    if qryEmployee.Active then qryEmployee.Close;
    qryEmployee.Params.ParamByName('xTerminationID').AsInteger := qryMain.FieldByName('TerminationID').AsInteger;
    qryEmployee.Open;
    CreateTempTable;
    PopulateETPTable;
    ProduceETPstatement(True);
  finally
    EnableForm;
  end;  
end;

initialization
  RegisterClassOnce(TfrmETPReport);
end.
