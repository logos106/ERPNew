unit frmAppointmentsPrn;

{

 Date    Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 11/07/05  1.00.XX DMS  1. Formatted unit's source code.
                        2. Changed queries to retrieve only active appointments.
 15/07/05  1.00.X1 DMS  1. Readjusted query that retrieves active appointments
                           when user selects "Print Itenary" option.
 21/07/05  1.00.02 DSP  Enabled email to be sent when chkPrintItinerary or
                        chkPrintList is checked.
 28/07/05  1.00.03 DSP  Added company preference option to not print cancelled
                        appointments.
 12/09/05  1.00.04 DSP  Added option to not print cancelled appointments into
                        the print appointment list section of code.
 19/10/05  1.00.05 DLS  Added RegisterClass
 08/12/05  1.00.06 MV   Added FormClose to Fix Task tracker Issue 301
 20/02/06  1.00.07 DSP  Added password to email authentication.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB,  StdCtrls, DBCtrls, ComCtrls,AdvOfficeStatusBar, ExtCtrls,
  wwcheckbox, Mask, wwdbedit, Wwdotdot, Wwdbcomb, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdblook, SelectionDialog, AppEvnts, DataState, EmailUtils,
  Menus, AdvMenus, DNMSpeedButton, Shader, DNMPanel, ImgList, ProgressDialog;

type
  TAppointmentsPrnGUI = class(TBaseInputGUI)
    dtFrom: TDateTimePicker;
    dtTo: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    btnPrint: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    Label3: TLabel;
    Bevel1: TBevel;
    chkAllReps: TCheckBox;
    Label12: TLabel;
    Bevel2: TBevel;
    chkPrintItinerary: TwwCheckBox;
    lblItinerary: TLabel;
    Bevel3: TBevel;
    chkPrintList: TwwCheckBox;
    lblList: TLabel;
    lblProgress: TLabel;
    qryReps: TERPQuery;
    cboReps: TwwDBLookupCombo;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkIncludefollowups: TwwCheckBox;
    Label4: TLabel;
    lblIncludeRepairParts: TLabel;
    chkIncludeRepairParts: TwwCheckBox;
    procedure cboRepsChange(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure PrintApp(AppointID: integer; chkCancellation, chkRescheduled, Preview: boolean);
    procedure EmailApp(AppointID: integer; chkCancellation, chkRescheduled: boolean);
    procedure chkAllRepsClick(Sender: TObject);
    procedure cboRepsDropDown(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure SelectOption(Sender: TObject);
  private
    sSQL:String;
    iEmployeeID: integer;
    Procedure getFollowups(IsItinerary:Boolean = False);
    function ReportDetails(AppointID: integer; chkCancellation, chkRescheduled, Preview: boolean):String;
  public
    { Public declarations }

  end;


implementation

{$R *.dfm}
uses
   CommonDbLib,  DnMLib, DNMExceptions, tcConst,
  AppEnvironment, CommonLib, FastFuncs, MySQLConst, JSONObject, tcDataUtils,
  CorrespondenceObj, EmailExtraUtils;

procedure TAppointmentsPrnGUI.cboRepsChange(Sender: TObject);
begin
    if cboReps.Text = '' then begin
        chkAllReps.checked := true;
        iEmployeeID := 0;
    end else begin
        iEmployeeID := qryReps.FieldByName('EmployeeID').AsInteger;
        if FastFuncs.PosEx('@', qryReps.FieldByName('Email').AsString) <> 0 then begin
            btnEmail.Enabled := true
        end else begin
         //   btnEmail.Enabled := false;
        end;
    end;
end;
{}
procedure TAppointmentsPrnGUI.btnClick(Sender: TObject);
var
  qry: TERPQuery;
  AppointmentCancelled: boolean;
begin
  DisableForm;
  try
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;

      if chkPrintItinerary.Checked or chkPrintList.Checked  or chkIncludeRepairParts.checked or chkIncludefollowups.checked then begin
        if Sender = btnEmail then EmailApp(0, false, false)
        else PrintApp(0, false, false, (Sender = btnPreview));
      end else begin
        with qry do begin
          // Keypad table
          SQL.Add('SELECT AppointID, Cancellation, Reschedulled ' +
            'FROM tblAppointments WHERE ');
          SQL.Add('AppDate BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateFormat,
            dtFrom.DateTime)) +
            ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime)));
          SQL.Add('AND Active = ''T''');

          if not chkAllReps.Checked then begin
            SQL.Add(' AND TrainerID = :xTrainerID');
            Params.ParamByName('xTrainerID').asInteger := iEmployeeID;
          end;

          Open;
          if IsEmpty then CommonLib.MessageDlgXP_Vista('There are no appointments for this period.', mtInformation,[mbOK], 0);

          if not IsEmpty then begin
            First;

            while not Eof do begin
              if Sender = btnPrint then begin
                AppointmentCancelled := FieldByName('Cancellation').AsBoolean;

                if not (AppointmentCancelled and AppEnv.CompanyPrefs.CancelledAppointmentsNotPrinted) then begin
                  PrintApp(FieldByName('AppointID').AsInteger,
                    AppointmentCancelled,
                    FieldByName('Reschedulled').AsBoolean,
                    false);
                end;
              end else if Sender = btnPreview then begin
                PrintApp(FieldByName('AppointID').AsInteger,
                  FieldByName('Cancellation').AsBoolean,
                  FieldByName('Reschedulled').AsBoolean,
                  true);
              end else if Sender = btnEmail then begin
                EmailApp(FieldByName('AppointID').AsInteger,
                  FieldByName('Cancellation').AsBoolean,
                  FieldByName('Reschedulled').AsBoolean);
              end;

              Next;
            end;
          end;
        end;
      end;
    finally
      FreeAndNil(qry);
    end;
  finally
    EnableForm;
  end;
end;

procedure TAppointmentsPrnGUI.PrintApp(AppointID: integer; chkCancellation, chkRescheduled, Preview: boolean);
var
  sReportName: string;
  Json: TJsonObject;
begin
    sReportName := ReportDetails(AppointID,chkCancellation, chkRescheduled, Preview);
    if sReportName = 'Appointment with Repair Parts' then begin
      Json:= JO;
      try
        Json.O['1'].S['master']:= 'Appointments';
        Json.O['1'].S['detail']:= 'Details';
        Json.O['1'].S['masterfields']:= 'AppointID';
        Json.O['1'].S['detailfields']:= 'AppointID';

        Json.O['2'].S['master']:= 'Appointments';
        Json.O['2'].S['detail']:= 'RepairEquipments';
        Json.O['2'].S['masterfields']:= 'AppointID';
        Json.O['2'].S['detailfields']:= 'AppointID';

        Json.O['3'].S['master']:= 'Appointments';
        Json.O['3'].S['detail']:= 'MasterDetails';
        Json.O['3'].S['masterfields']:= 'AppointID';
        Json.O['3'].S['detailfields']:= 'AppointID';

        fbReportSQLSupplied := true;
        PrintTemplateReport(sReportName , sSQL, (not Preview), 1,Json);
      finally
        Json.Free;
      end;
    end else begin
     PrintTemplateReport(sReportName, sSQL, (not Preview), 1);
    end;
    fbReportSQLSupplied := false;
end;

Procedure TAppointmentsPrnGUI.GetFollowUps(IsItinerary:Boolean = False);
var
    strSQL :String;
    iHideDays :Integer;
    ReminderDays :Integer;

    Procedure  getReminderHideDays ;
    begin
        with TERPQuery.Create(nil) do try
            Connection := CommonDbLib.GetSharedMyDacConnection;
            SQL.Clear;
            SQL.Add('SELECT EmployeeID,ReminderHideDays FROM tblpersonalpreferences WHERE EmployeeID = ');
            SQL.Add(IntToStr(iEmployeeId));
            Open;
            iHideDays := FieldByName('ReminderHideDays').AsInteger;
        finally
            if active then close;
            Free;
        end;
    end;
    Procedure Datefilter(const fName:STring ; Days :Integer);
    begin
        strSQL := strSQL + ' AND (DATE_ADD(' + fname + ', INTERVAL  ' + IntToStr(days) + ' DAY)>= ' + QuotedStr(FormatDatetime(MysqlDateFormat , dtFrom.Date)) +')' +
                           ' AND (DATE_ADD(' + fname + ', INTERVAL  ' + IntToStr(days) + ' DAY) <= ' + QuotedStr(FormatDatetime(MysqlDateFormat , dtTo.Date)) +')' ;
        if iHideDays <> 0 then begin
            strSQL := strSQL + ' AND (DATE_ADD(' + fname + ', INTERVAL  ' + IntToStr(iHideDays) + ' DAY)>= ' + QuotedStr(FormatDatetime(MysqlDateFormat , dtFrom.Date)) +')' +
                               ' AND (DATE_ADD(' + fname + ', INTERVAL  ' + IntToStr(iHideDays) + ' DAY) <= ' + QuotedStr(FormatDatetime(MysqlDateFormat , dtTo.Date)) +')' ;
        end;
        (*if iHideDays <> 0 then
            strSQL := strSQL + ' and (Date_Add(' + fname + ', INTERVAL ' + IntToStr(iHideDays) + ' DAY)>= ' + QuotedStr(FormatDatetime(MysqlDateFormat , dtFrom.Date)) +')';*)
    end;
    Function Equipmentfields(const IDFieldName :String):String;
    begin
      result := '';
        if  IsItinerary then begin
          result := ',' + IDFieldName +' as ID, "" as EquipName, "" as Manufacture, "" as model, "" as Serialno, "" as Registration, '+
          '0 as WarantyPeriod,NULL as  WarantyFinishDate,  NULL as WarantyStartDate,'+
          '0 as Quantity, "" as UOM,0 as WarantyPeriodLeft,0 as WarantyPeriodTaken, "" as OnSite, "" as Notes';
        end;
    end;
begin
    if chkIncludefollowups.checked = False then exit;
    getReminderHideDays;
    strSQL := '';
    ReminderDays    := AppEnv.Employee.MarketingContactsAppearDays ;
    if ReminderDays <= 0 then ReminderDays := 2;
{Follow-Up[Marketingcontact]}
    strSQL := 'Select "Follow-Up[Marketingcontact]" as Description,';
    strSQL := strSQL + ' DAYNAME(F1.Actiondate) as Day,F1.Actiondate ,E.EmployeeName AS RepName ,  ';
    strSQL := strSQL + ' F1.FollowUpID, DAte_FORMAT(F1.Actiondate , "%a, %d %b") as ActionDateDetail, ';

    strSQL := strSQL + ' C3.Company, ';
    strSQL := strSQL + ' C3.Street ,  C3.Street2 ,C3.Street3, C3.Suburb, C3.State,  C3.Postcode as Address, ';
    strSQL := strSQL + ' Concat_ws(" ",C3.FirstName,C3.LastName) As Contact, ';
    strSQL := strSQL + ' C3.Phone,  C3.AltPhone,  C3.Mobile,  ';
    strSQL := strSQL + ' CASE WHEN TO_DAYS(F1.Actiondate) = TO_DAYS(NOW()) THEN "TODAY"';
    strSQL := strSQL + ' WHEN TO_DAYS(F1.Actiondate)-1 = TO_DAYS(NOW()) THEN "TOMORROW"';
    strSQL := strSQL + ' WHEN TO_DAYS(F1.Actiondate) < TO_DAYS(NOW()) THEN';
    strSQL := strSQL + ' CONCAT("OVERDUE! ", TO_DAYS(NOW()) - TO_DAYS(F1.Actiondate))';
    strSQL := strSQL + ' ELSE CONCAT("+ ",TO_DAYS(F1.Actiondate) - TO_DAYS(NOW())) END as comments,';
    strSQL := strSQL + ' F1.Actiondate as SortDate, ';
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date)) +',INTERVAL 1 SECOND) as DateFrom, ' ;
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date))   + ',INTERVAL 1 SECOND) as DateTo ' ;
    strSQL := strSQL + Equipmentfields('F1.LeadLineID')+chr(13);
    strSQL := strSQL + ' FROM tblmarketingleadlines as F1, tblmarketingleads as F2, tblmarketingcontacts as C3,tblEmployees E  '+chr(13);
    strSQL := strSQL + ' WHERE  F1.EmployeeID=E.EmployeeID  and F1.IsLead <> "T" and F1.LeadId = F2.LeadID  and F1.done <> "T"' ;
    if iemployeeID <> 0 then
        strSQL := strSQL + ' and F1.EmployeeID = '+ IntToStr(AppEnv.Employee.EmployeeID) ;
    Datefilter('F1.ActionDate' , ReminderDays);
    strSQL := strSQL + ' AND (     C3.ID = F2.MarketingcontactID AND ifnull(F1.ResultTypeName, "")  <> "Appointment")';

    ReminderDays    := AppEnv.Employee.LeadsAppearDays;
    if ReminderDays <= 0 then ReminderDays := 2;
    if strSQL <> '' then strSQL := strSQL +chr(13)+' union '+chr(13);
{"Follow-Up[Marketing Lead]"}
    strSQL := strSQL + ' SELECT  "Follow-Up[Marketing Lead]", ';
    strSQL := strSQL + ' DAYNAME(F1.Actiondate) as Day,F1.Actiondate , E.EmployeeName AS RepName,';
    strSQL := strSQL + ' F1.FollowUpID, DAte_FORMAT(F1.Actiondate , "%a, %d %b") ,';
    strSQL := strSQL + ' C3.Company, ';
    strSQL := strSQL + ' C3.Street ,  C3.Street2 ,C3.Street3, C3.Suburb, C3.State,  C3.Postcode, ';
    strSQL := strSQL + ' Concat_ws(" ",C3.FirstName,C3.LastName) As Contact, ';
    strSQL := strSQL + ' C3.Phone,  C3.AltPhone,  C3.Mobile,   ';
    strSQL := strSQL + ' CASE WHEN TO_DAYS(F1.Actiondate) = TO_DAYS(NOW()) THEN "TODAY"';
    strSQL := strSQL + ' WHEN TO_DAYS(F1.Actiondate)-1 = TO_DAYS(NOW()) THEN "TOMORROW"';
    strSQL := strSQL + ' WHEN TO_DAYS(F1.Actiondate) < TO_DAYS(NOW()) THEN';
    strSQL := strSQL + ' CONCAT("OVERDUE! ", TO_DAYS(NOW()) - TO_DAYS(F1.Actiondate))';
    strSQL := strSQL + ' ELSE CONCAT("+ ",TO_DAYS(F1.Actiondate) - TO_DAYS(NOW())) END,';
    strSQL := strSQL + ' F1.Actiondate as SortDate, ';
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date)) +',INTERVAL 1 SECOND) as DateFrom, ' ;
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date))   + ',INTERVAL 1 SECOND) as DateTo ';
    strSQL := strSQL + Equipmentfields('F1.LeadLineID')+chr(13);
    strSQL := strSQL + ' FROM tblmarketingleadlines as F1, tblmarketingleads as F2, tblmarketingcontacts as C3, tblEmployees E ' +chr(13);
    strSQL := strSQL + ' WHERE F1.EmployeeID=E.EmployeeID  and F1.IsLead = "T" and F1.LeadId = F2.LeadID  and F1.done <> "T"' ;
    if iemployeeID <> 0 then
        strSQL := strSQL + ' and F1.EmployeeID = '+ IntToStr(AppEnv.Employee.EmployeeID) ;
    Datefilter('F1.ActionDate' , ReminderDays);
    strSQL := strSQL + ' AND (     C3.ID = F2.MarketingcontactID AND ifnull(F1.ResultTypeName, "")  <> "Appointment")';

    ReminderDays    := AppEnv.Employee.OthContactAppearDays;
    if ReminderDays <= 0 then ReminderDays := 2;
    if strSQL <> '' then strSQL := strSQL + chr(13)+' union '+chr(13);
{Follow-Up[Repair]}
    strSQL := strSQL + ' SELECT  "Follow-Up[Repair]",';
    strSQL := strSQL + ' DAYNAME(F.FollowUpDate) as Day, F.FollowUpDate , E.EmployeeName AS RepName,';
    strSQL := strSQL + ' F.RepairID, DAte_FORMAT(F.FollowUpDate , "%a, %d %b") ,';
    strSQL := strSQL + ' C3.Company, ';
    strSQL := strSQL + ' C3.Street ,  C3.Street2 ,C3.Street3, C3.Suburb, C3.State,  C3.Postcode, ';
    strSQL := strSQL + ' Concat_ws(" ",C3.FirstName,C3.LastName) As Contact, C3.Phone,  ';
    strSQL := strSQL + ' C3.AltPhone,  C3.Mobile,  ';
    strSQL := strSQL + ' CASE WHEN TO_DAYS(F.FollowUpDate) = TO_DAYS(NOW()) THEN "TODAY"';
    strSQL := strSQL + ' WHEN TO_DAYS(F.FollowUpDate)-1 = TO_DAYS(NOW()) THEN "TOMORROW"';
    strSQL := strSQL + ' WHEN TO_DAYS(F.FollowUpDate) < TO_DAYS(NOW()) THEN';
    strSQL := strSQL + ' CONCAT("OVERDUE! ", TO_DAYS(NOW()) - TO_DAYS(F.FollowUpDate))';
    strSQL := strSQL + ' ELSE CONCAT("+ ",TO_DAYS(F.FollowUpDate) - TO_DAYS(NOW())) END, ';
    strSQL := strSQL + ' F.FollowUpDate as SortDate, ';
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date)) +',INTERVAL 1 SECOND) as DateFrom, ' ;
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date))   + ',INTERVAL 1 SECOND) as DateTo ' ;
    strSQL := strSQL + Equipmentfields('F.FollowUpID')+chr(13);
    strSQL := strSQL + ' FROM tblOtherFollowup as F, tblClients as C3,tblEmployees  E' +chr(13);
    strSQL := strSQL + ' WHERE F.EmployeeID=E.EmployeeID  and F.RepairID > 0 AND F.Done <> "T"';
    if iEmployeeId <> 0 then
        strSQL := strSQL + ' AND F.EmployeeID = ' + IntToStr(iEmployeeID);
    Datefilter('F.FollowUpDate' , ReminderDays);
    strSQL := strSQL +' AND C3.ClientID = F.ClientID';

    ReminderDays := AppEnv.Employee.OthContactAppearDays;
    if ReminderDays <= 0 then ReminderDays := 2;
    if strSQL <> '' then strSQL := strSQL + chr(13)+' union '+chr(13);
{Follow-Up[Other]}
    strSQL := strSQL + ' SELECT "Follow-Up[Other]", ';
    strSQL := strSQL + ' DAYNAME(F1.FollowUpDate) as Day,F1.FollowUpDate ,E.EmployeeName AS RepName, ';
    strSQL := strSQL + ' F1.FollowUpID,DAte_FORMAT(F1.FollowUpDate , "%a, %d %b") ,';
    strSQL := strSQL + ' C3.Company, ';
    strSQL := strSQL + ' C3.Street ,  C3.Street2 ,C3.Street3, C3.Suburb, C3.State,  C3.Postcode, ';
    strSQL := strSQL + ' Concat_ws(" ",C3.FirstName,C3.LastName) As Contact, C3.Phone,  ';
    strSQL := strSQL + ' C3.AltPhone,  C3.Mobile,';
    strSQL := strSQL + ' CASE WHEN TO_DAYS(F1.FollowUpDate) = TO_DAYS(NOW()) THEN "TODAY"';
    strSQL := strSQL + ' WHEN TO_DAYS(F1.FollowUpDate)-1 = TO_DAYS(NOW()) THEN "TOMORROW"';
    strSQL := strSQL + ' WHEN TO_DAYS(F1.FollowUpDate) < TO_DAYS(NOW()) THEN';
    strSQL := strSQL + ' CONCAT("OVERDUE! ", TO_DAYS(NOW()) - TO_DAYS(F1.FollowUpDate))';
    strSQL := strSQL + ' ELSE CONCAT("+ ",TO_DAYS(F1.FollowUpDate) - TO_DAYS(NOW())) END,';
    strSQL := strSQL + ' F1.FollowUpDate as SortDate, ';
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date)) +',INTERVAL 1 SECOND) as DateFrom, ' ;
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date))   + ',INTERVAL 1 SECOND) as DateTo ' ;
    strSQL := strSQL + Equipmentfields('F1.FollowUpID')+chr(13);
    strSQL := strSQL + ' FROM tblOtherFollowup as F1, tblClients as C3, tblEmployees E ' +chr(13);
    strSQL := strSQL + ' WHERE F1.EmployeeID=E.EmployeeID  and F1.OtherContactID > 0';
    Datefilter('F1.FollowUpDate' , ReminderDays );
    if iEmployeeID <> 0 then
        strSQL := strSQL+ ' AND F1.EmployeeID = ' + IntToStr(iemployeeID);
    strSQL := strSQL+ ' AND F1.Done <> "T"  AND C3.ClientID = F1.ClientID '+
            ' AND F1.IsSupplier <> "T" AND IsCustomer <> "T"';


    ReminderDays := AppEnv.Employee.OthContactAppearDays;
    if ReminderDays <= 0 then ReminderDays := 2;
    if strSQL <> '' then strSQL := strSQL + chr(13)+' union '+chr(13);
{Follow-Up[Supplier]}
    strSQL := strSQL + ' SELECT "Follow-Up[Supplier]",';
    strSQL := strSQL + ' DAYNAME(F1.FollowUpDate) as Day,F1.FollowUpDate , E.EmployeeName AS RepName,';
    strSQL := strSQL + ' F1.FollowUpID, DAte_FORMAT(F1.FollowUpDate , "%a, %d %b"),  ';
    strSQL := strSQL + ' C3.Company, ';
    strSQL := strSQL + ' C3.Street ,  C3.Street2 ,C3.Street3, C3.Suburb, C3.State,  C3.Postcode, ';
    strSQL := strSQL + ' Concat_ws(" ",C3.FirstName,C3.LastName) As Contact, C3.Phone,  ';
    strSQL := strSQL + ' C3.AltPhone,  C3.Mobile,    ';
    strSQL := strSQL + ' CASE WHEN TO_DAYS(F1.FollowUpDate) = TO_DAYS(NOW()) THEN "TODAY"';
    strSQL := strSQL + ' WHEN TO_DAYS(F1.FollowUpDate)-1 = TO_DAYS(NOW()) THEN "TOMORROW"';
    strSQL := strSQL + ' WHEN TO_DAYS(F1.FollowUpDate) < TO_DAYS(NOW()) THEN';
    strSQL := strSQL + ' CONCAT("OVERDUE! ", TO_DAYS(NOW()) - TO_DAYS(F1.FollowUpDate))';
    strSQL := strSQL + ' ELSE CONCAT("+ ",TO_DAYS(F1.FollowUpDate) - TO_DAYS(NOW())) END, ';
    strSQL := strSQL + ' F1.FollowUpDate as SortDate, ';
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date)) +',INTERVAL 1 SECOND) as DateFrom, ' ;
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date))   + ',INTERVAL 1 SECOND) as DateTo ' ;
    strSQL := strSQL + Equipmentfields('F1.FollowUpID')+chr(13);
    strSQL := strSQL + ' FROM tblOtherFollowup as F1, tblClients as C3, tblEmployees E ' +chr(13);
    strSQL := strSQL + ' WHERE F1.EmployeeID=E.EmployeeID  and F1.Done <> "T"';
    Datefilter('F1.FollowUpDate' , ReminderDays);
    if iEmployeeID <> 0 then
        strSQL := strSQL+ ' AND F1.EmployeeID = ' + IntToStr(iemployeeID);
    strSQL := strSQL+ ' AND C3.ClientID = F1.ClientID AND F1.IsSupplier = "T"';


    ReminderDays := AppEnv.Employee.OthContactAppearDays;
    if ReminderDays <= 0 then ReminderDays := 2;
    if strSQL <> '' then strSQL := strSQL + chr(13)+' union '+chr(13);
{Follow-Up[Job]/Follow-Up[Customer]}
    strSQL := strSQL + ' SELECT IF(C3.IsJob = "T","Follow-Up[Job]","Follow-Up[Customer]"),';
    strSQL := strSQL + ' DAYNAME(F1.FollowUpDate) as Day, F1.FollowUpDate , E.EmployeeName AS RepName,';
    strSQL := strSQL + ' F1.FollowUpID,  DAte_FORMAT(F1.FollowUpDate , "%a, %d %b"),';
    strSQL := strSQL + ' C3.Company, ';
    strSQL := strSQL + ' C3.Street ,  C3.Street2 ,C3.Street3, C3.Suburb, C3.State,  C3.Postcode, ';
    strSQL := strSQL + ' Concat_ws(" ",C3.FirstName,C3.LastName) As Contact, C3.Phone,  ';
    strSQL := strSQL + ' C3.AltPhone,  C3.Mobile,    ';
    strSQL := strSQL + ' CASE WHEN TO_DAYS(F1.FollowUpDate) = TO_DAYS(NOW()) THEN "TODAY"';
    strSQL := strSQL + ' WHEN TO_DAYS(F1.FollowUpDate)-1 = TO_DAYS(NOW()) THEN "TOMORROW"';
    strSQL := strSQL + ' WHEN TO_DAYS(F1.FollowUpDate) < TO_DAYS(NOW()) THEN';
    strSQL := strSQL + ' CONCAT("OVERDUE! ", TO_DAYS(NOW()) - TO_DAYS(F1.FollowUpDate))';
    strSQL := strSQL + ' ELSE CONCAT("+ ",TO_DAYS(F1.FollowUpDate) - TO_DAYS(NOW())) END, ';
    strSQL := strSQL + ' F1.FollowUpDate as SortDate, ';
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date)) +',INTERVAL 1 SECOND) as DateFrom, ' ;
    strSQL := strSQL + ' DATE_ADD(' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date))   + ',INTERVAL 1 SECOND) as DateTo ' ;
    strSQL := strSQL + Equipmentfields('F1.FollowUpID')+chr(13);
    strSQL := strSQL + ' FROM tblOtherFollowup as F1, tblClients as C3,tblEmployees E ' +chr(13);
    strSQL := strSQL + ' WHERE   F1.EmployeeID=E.EmployeeID  and F1.Done <> "T"';
    Datefilter('F1.FollowUpDate' , ReminderDays);
    if iEmployeeID <> 0 then
        strSQL := strSQL+ ' AND F1.EmployeeID = ' + IntToStr(iemployeeID);

    strSQL := strSQL+ ' AND C3.ClientID = F1.ClientID AND F1.IsCustomer = "T"';
    if strSQL <> '' then begin
      if sSQL <> '' then sSQL :=sSQL +chr(13)+' union ';
      sSQL := sSQL +chr(13)+ strSQL;
    end;
end;


procedure TAppointmentsPrnGUI.chkAllRepsClick(Sender: TObject);
begin
  inherited;
  if chkAllReps.Checked then begin
    cboReps.Text         := '';
    lblItinerary.Enabled := false;
    chkPrintItinerary.Enabled := false;
    chkPrintItinerary.Checked := false;
    lblList.Enabled      := false;
    chkPrintList.Enabled := false;
    chkPrintList.Checked := false;
  end else begin
    lblItinerary.Enabled      := true;
    chkPrintItinerary.Enabled := true;
    lblList.Enabled           := true;
    chkPrintList.Enabled      := true;
  end;
end;

procedure TAppointmentsPrnGUI.cboRepsDropDown(Sender: TObject);
begin
  inherited;
  chkAllReps.Checked := false;
end;

procedure TAppointmentsPrnGUI.EmailApp(AppointID: integer; chkCancellation, chkRescheduled: boolean);
var
  f: file;
  RecipientAddress, ReportType, OutGoingFileName: string;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  sReportName: string;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
begin
  // Clear all previous params/data
  lblProgress.Caption   := 'Emailing, ' + WAITMSG;
  RecipientAddress      := '';
  ReportType            := '';
  OutGoingFileName      := '';

  RecipientAddress := qryReps.FieldByName('Email').AsString;

  lSilent := true;
  if RecipientAddress = '' then
    if AppEnv.CompanyPrefs.UseDefaultMailClient then
    begin
      if CommonLib.MessageDlgXP_Vista(qryReps.FieldByName('Name').AsString + ' does not have an email address.' + #13 + #10 +
        'Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;
        lSilent := false;
    end else begin
      CommonLib.MessageDlgXP_Vista('Please review customer information to add an email address.', mtWarning,[mbOK], 0);
      exit;
    end;

  try
    ReportType := 'Appointments';
    lblProgress.Visible := true;
    Application.ProcessMessages;

    sreportName := ReportDetails(AppointID,chkCancellation, chkRescheduled, false);
    SaveTemplateReport(sReportName, sSQL, false, 'PDF');
    if PrintTemplate.NoRecordsToPrint then begin
      CommonLib.MessageDlgXP_Vista(qryReps.FieldByName('Name').AsString + ' does not have any appointments for this period to email',mtInformation, [mbOK], 0);
      lblProgress.Visible := false;
      exit;
    end;

    fbReportSQLSupplied := false;

    lblProgress.Caption := 'Connecting...';

    lblProgress.Caption := 'Emailing, ' + WAITMSG;

    Corres := TCorrespondenceGui.Create;
    try

      Corres.Subject := ReportType + ' for ' + qryReps.FieldByName('Name').AsString;

      Corres.RecipientList := RecipientAddress;
      Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

      OutGoingFileName := getOutGoingFileName('' ,' ' + ReportType ,'.PDF');
      AssignFile(f, Commonlib.TempDir  + 'EmailReport.PDF');

      if not FileExists(Commonlib.TempDir  + OutGoingFileName) then begin
        Copyfile(PChar(Commonlib.TempDir + 'EmailReport.PDF'),
          PChar(Commonlib.TempDir + OutGoingFileName), false);
      end;

      Corres.AttachmentList.Add(Commonlib.TempDir + OutGoingFileName);
      ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres, GetTemplate(sreportName));

      // finally shoot the email
      if lSilent and not EmailShortSendMode(lSilent, lSecret) then
        exit;
      if Corres.Execute(lSilent, lSecret) then begin
        TransactionID := IntToStr(AppointID);
        UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
        EmailDate := Now;

        // ReportType already defined at start of procedure
        TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' + IntToStr(AppointID)
          + ' for ' + qryReps.FieldByName('Name').AsString;

        qryEmailedList := TERPQuery.Create(nil);
        qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("'
            + TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
            EmailDate) + '", "' + ReportType + '", "' + TransactionDescription +
            '")');
          qryEmailedList.Execute;

        finally
          FreeandNil(qryEmailedList);
        end;
      end;
      DeleteFiles(Commonlib.TempDir , '*.PDF');
      DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
      lblProgress.Visible := false;
    finally
      Corres.Free;
    end;
  except
    lblProgress.Visible := false;
  end;
end;

procedure TAppointmentsPrnGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      dtFrom.Date := Date;
      dtTo.Date   := Date + 5;
      OpenQueries;
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
  end;
end;

procedure TAppointmentsPrnGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TAppointmentsPrnGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TAppointmentsPrnGUI.ReportDetails(AppointID: integer; chkCancellation, chkRescheduled, Preview: boolean): String;
var
  sReportName:String;

begin
  result := '';
  try
    if chkPrintItinerary.Checked then begin
        sReportName := 'Print Appointment Itinerary';
        sSQL:= ' Select  A.RepairId,"Appointment"  as Description,   DAYNAME(A.AppDate) as Day,   A.AppDate as Date,'+
            ' Concat_ws("-",TIME_FORMAT(A.STARTTIME,"%l:%i %p") ,  TIME_FORMAT(A.ENDTIME, "%l:%i %p") ) as apptTime,'+
            ' A.CUSTFLD1, A.CUSTFLD2, A.CUSTFLD3, A.CUSTFLD4, A.CUSTFLD5, A.CUSTFLD6, A.CUSTFLD7, A.CUSTFLD8, A.CUSTFLD9,'+
            ' A.CUSTFLD10, A.CUSTFLD11, A.CUSTFLD12, A.CUSTFLD13, A.CUSTFLD14, A.CUSTFLD15, A.CUSTDATE1, A.CUSTDATE2,'+
            '  A.CUSTDATE3, s.MediaType as Source,   E.EmployeeName AS RepName,'+
            ' A.STARTTIME as SortDate, '+
            '  TIME_TO_SEC(DATE_SUB(A.ENDTIME, INTERVAL TIME_TO_SEC(A.STARTTIME) SECOND))/3600 as Hrs,'+
            '  C.Company,   C.Street as Address,   C.Street2 as Address2,  C.Street3 as Address3, C.Suburb,'+
            '  C.State,  C.Postcode,   Concat(C.FirstName," ",C.LastName) As Contact,'+
            ' C.Phone,  C.AltPhone,  C.Mobile,  A.Notes, A.FeedbackNotes,  SC.ServiceDesc  ,'+
            '  DATE_ADD("2008-03-05",INTERVAL 1 SECOND)  as DateFrom,  DATE_ADD("2008-03-31",INTERVAL 1 SECOND) as DateTo, '+
            ' A.AppointID as ID, CEQ.EquipName,CEQ.Manufacture,CEQ.model,CEQ.Serialno,CEQ.Registration,CEQ.WarantyPeriod,CEQ.WarantyFinishDate, '+
            ' CEQ.WarantyStartDate,EQ.Quantity,EQ.UOM,EQ.WarantyPeriodLeft,EQ.WarantyPeriodTaken,EQ.OnSite,EQ.Notes as EquipmentNote, A.CustomerDetails'+chr(13)+
            '  FROM      tblAppointments  A'+chr(13)+
            '  LEFT JOIN tblClients       C   ON A.CusID     = C.ClientID'+chr(13)+
            '  LEFT JOIN tblEmployees     E   ON A.TrainerID = E.EmployeeID'+      chr(13)+
            '  LEFT JOIN tblServices      SC  ON A.ServiceID = SC.ServiceID'+chr(13)+
            '  LEFT JOIN tblSource        S   ON A.MedTypeId = s.MedTypeId'+chr(13)+
            '  Left Join tblequipmentxref EQ  ON A.AppointID = EQ.AppointmentID ' +chr(13)+
            '  Left Join tblcustomerequip CEQ ON EQ.CustomerEquipmentID = CEQ.id'+chr(13)+
            ' WHERE  Cancellation="F" AND A.Active = "T"' +
            ' AND AppDate BETWEEN ' +
            QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.DateTime)) + ' AND ' +
            QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime));
        if iEmployeeId <> 0 then
            Ssql := ssQL + ' and TrainerID = ' + IntToStr(iEmployeeID) ;
        (*GetFollowups(True);*)
        sSQL := sSQL + chr(13)+' ORDER BY Date,SortDate,Appttime;';
        sSQL := sSQL + chr(13)+' ~|||~{CompanyInfo}' +
            ' SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, ' +
            ' CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';
        fbReportSQLSupplied := true;
    end else if chkPrintList.Checked then begin
        sReportName := 'Appointment List';
        sSQL        :='SELECT A.RepairId,"Appointment"  as Description,  A.appointid, ' +
            'DATE_FORMAT(A.AppDate, "%a, %d %b") as Date, ' +
            'TIME_FORMAT(A.STARTTIME,"%l:%i %p") as StartTime, ' +
            'TIME_FORMAT(A.ENDTIME, "%l:%i %p") as EndTime, ' +
            'TIME_TO_SEC(DATE_SUB(A.ENDTIME, INTERVAL TIME_TO_SEC(A.STARTTIME) SECOND))/3600 as Hrs, ' +
            'A.CUSTFLD1, A.CUSTFLD2, A.CUSTFLD3, A.CUSTFLD4, A.CUSTFLD5, A.CUSTFLD6, A.CUSTFLD7, A.CUSTFLD8, A.CUSTFLD9, A.CUSTFLD10, A.CUSTFLD11, A.CUSTFLD12, A.CUSTFLD13, A.CUSTFLD14, A.CUSTFLD15, ' +
            'A.CUSTDATE1, A.CUSTDATE2, A.CUSTDATE3, s.MediaType as Source, ' +
            'E.EmployeeName AS RepName,  C.Company, ' +
            ' A.customerDetails as Address, '+
            'Concat_ws(" ",C.FirstName,C.LastName) As Contact, ' +
            ' if(trim(ifnull(A.Phone    , "")) = "", C.Phone   , A.phone) as Phone,   '+
            ' if(trim(ifnull(A.altPhone , "")) = "", C.altPhone, A.altphone) as AltPhone,   '+
            ' if(trim(ifnull(A.mobile   , "")) = "", C.mobile  , A.mobile) as mobile,  '+
            ' A.Notes, ' +
            'SC.ServiceDesc, ' +
            'A.STARTTIME as SortDate, '+
            QuotedStr(FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, dtFrom.DateTime)) +' as DateFrom,'+
            QuotedStr(FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, dtTo.DateTime)) +' as Dateto ,'+chr(13)+
            'CEQ.EquipName,CEQ.Manufacture,CEQ.model,CEQ.Serialno,CEQ.Registration,CEQ.WarantyPeriod,CEQ.WarantyFinishDate, '+
            ' CEQ.WarantyStartDate,EQ.Quantity,EQ.UOM,EQ.WarantyPeriodLeft,EQ.WarantyPeriodTaken,EQ.OnSite,EQ.Notes as EquipmentNote'+chr(13)+
            'FROM      tblAppointments A ' +chr(13)+
            'LEFT JOIN tblClients      C  ON A.CusID     = C.ClientID ' +chr(13)+
            'LEFT JOIN tblEmployees    E  ON A.TrainerID = E.EmployeeID ' +chr(13)+
            'LEFT JOIN tblServices     SC ON A.ServiceID = SC.ServiceID ' +chr(13)+
            'LEFT JOIN tblSource       S  ON A.MedTypeId = s.MedTypeId ' +chr(13)+
            '  Left Join tblequipmentxref EQ  ON A.AppointID = EQ.AppointmentID ' +chr(13)+
            '  Left Join tblcustomerequip CEQ ON EQ.CustomerEquipmentID = CEQ.id'+chr(13)+
            'WHERE A.Active = "T"' + ' AND AppDate BETWEEN ' +
            QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.DateTime)) + ' AND ' +
            QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime));
        if iEmployeeID <> 0 then
            sSQL := sSQL + ' AND TrainerID = ' +IntToStr(iEmployeeID) ;
        if AppEnv.CompanyPrefs.CancelledAppointmentsNotPrinted then
            sSQL := sSQL + ' AND A.Cancellation="F"';
        (*GetFollowups;*)
        sSQL := sSQL + chr(13)+' order by date,SortDate, starttime,description';
        sSQL := sSQL + chr(13)+' ~|||~{CompanyInfo}' +
            ' SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, ' +
            ' CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';
        fbReportSQLSupplied := true;
    end else if chkIncludeRepairParts.Checked then begin
        sReportName := 'Appointment with Repair Parts';
        sSQL := ' {CompanyInfo}  SELECT   CompanyName, Address, Address2, City, ' +
                ' State, Postcode, ABN, PhoneNumber, FaxNumber   ' +
                ' FROM tblCompanyInformation   ' +chr(13)+
                ' ~|||~ {Appointments}SELECT ' +
                ' TIME_FORMAT(A.STARTTIME,"%l:%i %p") as StartTime, '+
                ' A.RepairId,"Appointment"  as Description,   DAYNAME(A.AppDate) as Day,    ' +
                ' A.AppDate as Date, Concat_ws("-",TIME_FORMAT(A.STARTTIME,"%l:%i %p") ,   ' +
                ' TIME_FORMAT(A.ENDTIME, "%l:%i %p") ) as apptTime,  ' +
                ' A.CUSTFLD1, A.CUSTFLD2, A.CUSTFLD3, A.CUSTFLD4, A.CUSTFLD5,  ' +
                ' A.CUSTFLD6, A.CUSTFLD7, A.CUSTFLD8, A.CUSTFLD9, A.CUSTFLD10,  ' +
                ' A.CUSTFLD11, A.CUSTFLD12, A.CUSTFLD13, A.CUSTFLD14, A.CUSTFLD15,  ' +
                ' A.CUSTDATE1, A.CUSTDATE2,  A.CUSTDATE3, s.MediaType as Source,    ' +
                ' E.EmployeeName AS RepName, A.STARTTIME as SortDate,    ' +
                ' TIME_TO_SEC(DATE_SUB(A.ENDTIME, INTERVAL TIME_TO_SEC(A.STARTTIME) SECOND))/3600 as Hrs,   ' +
                ' C.Company,   C.Street as Address,   C.Street2 as Address2,   ' +
                ' C.Street3 as Address3, C.Suburb,  C.State,  C.Postcode,    ' +
                ' Concat(C.FirstName," ",C.LastName) As Contact, C.Phone,   ' +
                ' C.AltPhone,  C.Mobile,  A.Notes, A.FeedbackNotes,  SC.ServiceDesc  ,   ' +
                ' DATE_ADD("2008-03-05",INTERVAL 1 SECOND)  as DateFrom,   ' +
                ' DATE_ADD("2008-03-31",INTERVAL 1 SECOND) as DateTo, ' +
                ' A.AppointID  ' +chr(13)+
                ' FROM      tblAppointments  A ' +chr(13)+
                ' LEFT JOIN tblClients       C   ON A.CusID     = C.ClientID ' +chr(13)+
                ' LEFT JOIN tblEmployees     E   ON A.TrainerID = E.EmployeeID ' +chr(13)+
                ' LEFT JOIN tblServices      SC  ON A.ServiceID = SC.ServiceID ' +chr(13)+
                ' LEFT JOIN tblSource        S   ON A.MedTypeId = s.MedTypeId ' +chr(13)+
                ' WHERE  Cancellation="F" AND A.Active = "T"  ' +
                ' AND AppDate BETWEEN ' +
                    QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.DateTime)) + ' AND ' +
                    QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime)) +chr(13);
        if iEmployeeID <> 0 then
            sSQL := sSQL + ' AND A.TrainerID = ' +IntToStr(iEmployeeID) ;
        if AppEnv.CompanyPrefs.CancelledAppointmentsNotPrinted then
            sSQL := sSQL + ' AND A.Cancellation="F"';


                sSQL :=  sSQL +' ORDER BY Date,SortDate,Appttime'+ chr(13)+
                ' ~|||~ {Details}SELECT ' +
                ' A.AppointID , ' +
                ' `RP`.`PartName` RepairPart, ' +
                ' CEQ.EquipName RepairPartForEquipment, ' +
                ' `RP`.`UnitofMeasure` RepairPartUOM, ' +
                ' `RP`.`Qty` RepairPartQty, ' +
                ' `RP`.`PriceEx` RepairPartPriceEx, ' +
                ' `RP`.`PriceInc` RepairPartPriceInc, ' +
                ' `RP`.`ClassName` RepairPartClass, ' +
                ' `RP`.`Linecost` RepairPartCost, ' +
                ' `RP`.`Description` RepairPartDescription, ' +
                ' `RP`.`TaxCode` RepairPartTaxCode, ' +
                ' `RP`.`TaxRate` RepairPartTaxrat, ' +
                ' `RP`.`Discount` RepairPartDiscount, ' +
                ' `RP`.`ETADate` RepairPartETA ,' +
                ' RP. LineTotalEx  as RepairPartLinetotalEx, RP. LineTotalEx+ifnull(RP. LineTotalEx,0)*ifnull(`RP`.`TaxRate`,0)/100  RepairPartLinetotalInc ' +chr(13)+
                ' FROM      tblAppointments  A ' +chr(13)+
                ' Inner join tblrepairParts RP on RP.RepairId = A.RepairId ' +chr(13)+
                ' Left Join tblcustomerequip CEQ ON `RP`.`CustomerEquipmentID` = CEQ.id ' +chr(13)+
                ' WHERE  Cancellation="F" AND A.Active = "T"  ' +
                ' AND AppDate BETWEEN ' +
                    QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.DateTime)) + ' AND ' +
                    QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime));
        if iEmployeeID <> 0 then
            sSQL := sSQL + ' AND A.TrainerID = ' +IntToStr(iEmployeeID) ;
        if AppEnv.CompanyPrefs.CancelledAppointmentsNotPrinted then
            sSQL := sSQL + ' AND A.Cancellation="F"';


                sSQL :=  sSQL +'~|||~' +
                '{RepairEquipments}Select  A.AppointID, CEQ.EquipName,CEQ.Manufacture, '+
                ' CEQ.model,CEQ.Serialno,CEQ.Registration,CEQ.WarantyPeriod,CEQ.WarantyFinishDate, '+
                ' CEQ.WarantyStartDate,EQ.Quantity,EQ.UOM,EQ.WarantyPeriodLeft, '+
                ' EQ.WarantyPeriodTaken,EQ.OnSite,EQ.Notes as EquipmentNote'+chr(13)+
                ' FROM      tblAppointments A  ' +chr(13)+
                ' Inner Join tblequipmentxref EQ  ON A.AppointID = EQ.AppointmentID ' + chr(13) +
                ' Left Join tblcustomerequip CEQ ON EQ.CustomerEquipmentID = CEQ.id'+
                ' WHERE  A.Cancellation="F" AND A.Active = "T"  ' +
                ' AND AppDate BETWEEN ' +
                    QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.DateTime)) + ' AND ' +
                    QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime)) ;

        if iEmployeeID <> 0 then
            sSQL := sSQL + ' AND A.TrainerID = ' +IntToStr(iEmployeeID) ;
        if AppEnv.CompanyPrefs.CancelledAppointmentsNotPrinted then
            sSQL := sSQL + ' AND A.Cancellation="F"'+chr(13);
        sSQL := sSQL + '  ~|||~{MasterDetails}SELECT A.AppointID  ' +chr(13)+
                ' FROM      tblAppointments  A ' +chr(13)+
                ' WHERE  Cancellation="F" AND A.Active = "T"  ' +
                ' AND AppDate BETWEEN ' +
                    QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.DateTime)) + ' AND ' +
                    QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime)) +chr(13);
        if iEmployeeID <> 0 then
            sSQL := sSQL + ' AND A.TrainerID = ' +IntToStr(iEmployeeID) ;
        if AppEnv.CompanyPrefs.CancelledAppointmentsNotPrinted then
            sSQL := sSQL + ' AND A.Cancellation="F"';

        fbReportSQLSupplied := true;
    end else if chkIncludefollowups.Checked then begin
        sReportName := 'Followup List';
        sSQL := '';
        getFollowups;
        ssql:= '{CompanyInfo}  SELECT   CompanyName, Address, Address2, City, State, Postcode, ' +
                'ABN, PhoneNumber, FaxNumber  FROM tblCompanyInformation  ~|||~ {Details}' +ssql;
        fbReportSQLSupplied := true;
    end else begin
        sSQL := '~|||~'+ Format(' WHERE tblAppointments.AppointID = %d', [AppointID]);
        if chkCancellation and chkRescheduled then begin
            sReportName := 'Appointment R & C';
        end else if chkRescheduled then begin
            sReportName := 'Appointment Resched';
        end else if chkCancellation then begin
            sReportName := 'Appointment Cancel';
        end else begin
            sReportName := 'Appointment';
        end;
    end;

  finally
    result :=sReportName;
  end;
end;
{if chkPrintItinerary.Checked then begin
        sReportName := 'Appointment Itinerary';
        sSQL:= ' Select  "Appointment"  as Description,   DAYNAME(A.AppDate) as Day,   A.AppDate as Date,'+
            ' Concat_ws("-",TIME_FORMAT(A.STARTTIME,"%l:%i %p") ,  TIME_FORMAT(A.ENDTIME, "%l:%i %p") ) as apptTime,'+
            ' A.CUSTFLD1, A.CUSTFLD2, A.CUSTFLD3, A.CUSTFLD4, A.CUSTFLD5, A.CUSTFLD6, A.CUSTFLD7, A.CUSTFLD8, A.CUSTFLD9,'+
            ' A.CUSTFLD10, A.CUSTFLD11, A.CUSTFLD12, A.CUSTFLD13, A.CUSTFLD14, A.CUSTFLD15, A.CUSTDATE1, A.CUSTDATE2,'+
            '  A.CUSTDATE3, s.MediaType as Source,   tblEmployees.EmployeeName AS RepName,'+
            ' A.STARTTIME as SortDate, '+
            '  TIME_TO_SEC(DATE_SUB(A.ENDTIME, INTERVAL TIME_TO_SEC(A.STARTTIME) SECOND))/3600 as Hrs,'+
            '  tblClients.Company,   tblClients.Street as Address,   tblClients.Street2 as Address2,  tblClients.Suburb,'+
            '  tblClients.State,  tblClients.Postcode,   Concat(tblClients.FirstName," ",tblClients.LastName) As Contact,'+
            ' tblClients.Phone,  tblClients.AltPhone,  tblClients.Mobile,  A.Notes, A.FeedbackNotes,  tblServices.ServiceDesc  ,'+
            '  DATE_ADD("2008-03-05",INTERVAL 1 SECOND)  as DateFrom,  DATE_ADD("2008-03-31",INTERVAL 1 SECOND) as DateTo'+
            '  FROM tblAppointments  a'+
            '  LEFT JOIN tblClients  ON A.CusID=tblClients.ClientID'+
            '  LEFT JOIN tblEmployees  ON A.TrainerID=tblEmployees.EmployeeID'+
            '  LEFT JOIN tblServices  ON A.ServiceID=tblServices.ServiceID'+
            '  LEFT JOIN tblSource s ON A.MedTypeId = s.MedTypeId'+
            ' WHERE  Cancellation="F" AND A.Active = "T"' +
            ' AND AppDate BETWEEN ' +
            QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.DateTime)) + ' AND ' +
            QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime));
        if iEmployeeId <> 0 then
            Ssql := ssQL + ' and TrainerID = ' + IntToStr(iEmployeeID) ;
        GetFollowups(True);
        sSQL := sSQL + ' ORDER BY Date,SortDate,Appttime;';
        fbReportSQLSupplied := true;
    end else if chkPrintList.Checked then begin
        sReportName := 'Appointment List';
        sSQL        :='SELECT "Appointment"  as Description,  A.appointid, ' +
            'DATE_FORMAT(A.AppDate, "%a, %d %b") as Date, ' +
            'TIME_FORMAT(A.STARTTIME,"%l:%i %p") as StartTime, ' +
            'TIME_FORMAT(A.ENDTIME, "%l:%i %p") as EndTime, ' +
            'TIME_TO_SEC(DATE_SUB(A.ENDTIME, INTERVAL TIME_TO_SEC(A.STARTTIME) SECOND))/3600 as Hrs, ' +
            'A.CUSTFLD1, A.CUSTFLD2, A.CUSTFLD3, A.CUSTFLD4, A.CUSTFLD5, A.CUSTFLD6, A.CUSTFLD7, A.CUSTFLD8, A.CUSTFLD9, A.CUSTFLD10, A.CUSTFLD11, A.CUSTFLD12, A.CUSTFLD13, A.CUSTFLD14, A.CUSTFLD15, ' +
            'A.CUSTDATE1, A.CUSTDATE2, A.CUSTDATE3, s.MediaType as Source, ' +
            'tblEmployees.EmployeeName AS RepName,  tblClients.Company, ' +
            ' A.customerDetails as Address, '+
            'Concat_ws(" ",tblClients.FirstName,tblClients.LastName) As Contact, ' +
            ' if(trim(ifnull(A.Phone    , "")) = "", tblclients.Phone   , A.phone) as Phone,   '+
            ' if(trim(ifnull(A.altPhone , "")) = "", tblclients.altPhone, A.altphone) as AltPhone,   '+
            ' if(trim(ifnull(A.mobile   , "")) = "", tblclients.mobile  , A.mobile) as mobile,  '+
            ' A.Notes, ' +
            'tblServices.ServiceDesc, ' +
            'A.STARTTIME as SortDate, '+
            QuotedStr(FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, dtFrom.DateTime)) +' as DateFrom,'+
            QuotedStr(FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, dtTo.DateTime)) +' as Dateto '+
            'FROM tblAppointments a ' +
            'LEFT JOIN tblClients  ON A.CusID=tblClients.ClientID ' +
            'LEFT JOIN tblEmployees  ON A.TrainerID=tblEmployees.EmployeeID ' +
            'LEFT JOIN tblServices  ON A.ServiceID=tblServices.ServiceID ' +
            'LEFT JOIN tblSource s ON A.MedTypeId = s.MedTypeId ' +
            'WHERE A.Active = "T"' + ' AND AppDate BETWEEN ' +
            QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.DateTime)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime));
        if iEmployeeID <> 0 then
            sSQL := sSQL + ' AND TrainerID = ' +IntToStr(iEmployeeID) ;
        if AppEnv.CompanyPrefs.CancelledAppointmentsNotPrinted then
            sSQL := sSQL + ' AND A.Cancellation="F"';
        GetFollowups;
        sSQL := sSQL + ' order by date,SortDate, starttime,description';
        fbReportSQLSupplied := true;
    end else begin
        sSQL := '~|||~'+ Format(' WHERE tblAppointments.AppointID = %d', [AppointID]);
        if chkCancellation and chkRescheduled then begin
            sReportName := 'Appointment R & C';
        end else if chkRescheduled then begin
            sReportName := 'Appointment Resched';
        end else if chkCancellation then begin
            sReportName := 'Appointment Cancel';
        end else begin
            sReportName := 'Appointment';
        end;
    end;}
procedure TAppointmentsPrnGUI.SelectOption(Sender: TObject);
begin
  inherited;
  if not (Sender is TwwCheckBox) then exit;
  if not(twwCheckbox(Sender).checked) then exit;

  if sender <> chkPrintItinerary     then chkPrintItinerary.Checked     :=False;
  if sender <> chkPrintList          then chkPrintList.Checked          :=False;
  if sender <> chkIncludeRepairParts then chkIncludeRepairParts.Checked :=False;
  if sender <> chkIncludefollowups   then chkIncludefollowups.Checked   :=False;
end;

initialization
  RegisterClassOnce(TAppointmentsPrnGUI);
end.



