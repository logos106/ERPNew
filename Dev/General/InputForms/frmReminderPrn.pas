unit frmReminderPrn;

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
  wwcheckbox, {Psock,} Mask, wwdbedit, Wwdotdot, Wwdbcomb, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdblook, SelectionDialog, AppEvnts, DataState, 
  Menus, AdvMenus, DNMSpeedButton, Shader, DNMPanel, ImgList, ProgressDialog;

type
  TfmReminderPrnGUI = class(TBaseInputGUI)
    dtFrom: TDateTimePicker;
    dtTo: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    btnPrint: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    Label3: TLabel;
    Bevel1: TBevel;
    chkAllReps: TCheckBox;
    Label12: TLabel;
    Bevel2: TBevel;
    qryReps: TERPQuery;
    cboReps: TwwDBLookupCombo;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkIncludeHistoryNotes: TCheckBox;
    Label4: TLabel;
    procedure cboRepsChange(Sender: TObject);
    procedure chkAllRepsClick(Sender: TObject);
    procedure cboRepsDropDown(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
  private
    iEmployeeID: integer;
    tablename :String;
    StringListForSQL :TStringlist;
    Procedure makeReport;
  end;


implementation

{$R *.dfm}
uses
   CommonDbLib,  DNMExceptions,
  CommonLib, ReminderLib;

procedure TfmReminderPrnGUI.cboRepsChange(Sender: TObject);
begin
    if cboReps.Text = '' then begin
        chkAllReps.checked := true;
    end else begin
        iEmployeeID := qryReps.FieldByName('EmployeeID').AsInteger;
    end;
end;
{}
procedure TfmReminderPrnGUI.chkAllRepsClick(Sender: TObject);
begin
  inherited;
  if chkAllReps.Checked then cboReps.Text         := '';
end;

procedure TfmReminderPrnGUI.cboRepsDropDown(Sender: TObject);
begin
  inherited;
  chkAllReps.Checked := false;
end;


procedure TfmReminderPrnGUI.FormShow(Sender: TObject);
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

procedure TfmReminderPrnGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if tablename <> '' then begin
        With TERPQuery.create(Self) do try
            Connection := GetSharedMyDacConnection;
            SQL.add('Drop table if exists ' + tablename );
          //  Execute;
        finally
            if active then Close;
            Free;
        end;
    End;
    inherited;
    Action := caFree;
end;

procedure TfmReminderPrnGUI.btnCloseClick(Sender: TObject);
begin
    inherited;
    Close;
end;
Procedure TfmReminderPrnGUI.makeReport;
begin
    tablename := '';
    if chkAllReps.checked then
        tablename := PopulateReminders(tablename, dtFrom.Date , dtTo.Date, 0   )
    else
        tablename := PopulateReminders(tablename, dtFrom.Date , dtTo.Date, qryReps.fieldByname('EmployeeID').asInteger );
    StringListForSQL.Clear;
    StringListForSQL.add('{reminderlist}SELECT R.DueTime, R.AutoID,typeno, R.CompanyLabel , R.TYPE,R.DUE,R.DESCRIPTION,R.Notes,');
    StringListForSQL.add('concat_WS(" ",E.title, E.FirstName,E.MiddleName,E.LastName) AS EmployeeName,');
    StringListForSQL.add('Dayname(Due) as Day,');
    StringListForSQL.add('DATE_FORMAT( R.DUE, "%D %M, %Y")   as DetailDate,');
    StringListForSQL.add('Dayname(Due) as DayName ,');
    StringListForSQL.add('R.Client,');
    StringListForSQL.add('if(ifnull(R.MarketingcontactID,0) = 0, Concat_ws(",",if(ifnull(C.Street,"") = "",  null, C.Street),');
    StringListForSQL.add('if(ifnull(C.Street2,"") = "",null, C.Street2),');
    StringListForSQL.add('if(ifnull(C.Suburb,"")  = "",null, C.Suburb),');
    StringListForSQL.add('if(ifnull(C.State,"")   = "",null, C.State),');
    StringListForSQL.add('if(ifnull(C.PostCode,"")= "",null, C.PostCode)),');
    StringListForSQL.add('Concat_ws(",",if(ifnull(MC.Street,"") = "",  null, MC.Street),');
    StringListForSQL.add('if(ifnull(MC.Street2,"") = "",null, MC.Street2),');
    StringListForSQL.add('if(ifnull(MC.Suburb,"")  = "",null, MC.Suburb),');
    StringListForSQL.add('if(ifnull(MC.State,"")   = "",null, MC.State),');
    StringListForSQL.add('if(ifnull(MC.PostCode,"")= "",null, MC.PostCode))) as Address ,');
    StringListForSQL.add('if(ifnull(R.MarketingcontactID,0) = 0, Concat_ws(" " , C.Firstname , C.MiddleName , C.LastName),Concat_ws(" " , MC.Firstname , MC.MiddleName , MC.LastName)) as contact,');
    StringListForSQL.add('if(ifnull(R.MarketingcontactID,0) = 0, if(ifnull(C.Phone,"")   = "",""  , Concat("Phone      :"    ,C.Phone)),if(ifnull(MC.Phone,"")   = "",""  , Concat("Phone      :"    ,MC.Phone)))  AS Phone,');
    StringListForSQL.add('if(ifnull(R.MarketingcontactID,0) = 0, if(ifnull(C.AltPhone,"")= "",""  , Concat("Alt Phone  :"    ,C.AltPhone)),if(ifnull(MC.AltPhone,"")= "",""  , Concat("Alt Phone  :"    ,MC.AltPhone)))  as AltPhone,');
    StringListForSQL.add('if(ifnull(R.MarketingcontactID,0) = 0, if(ifnull(C.Mobile,"")  = "",""  , Concat("Mobile     :"    ,C.Mobile)),if(ifnull(MC.Mobile,"")  = "",""  , Concat("Mobile     :"    ,MC.Mobile)))  as Mobile,');
    StringListForSQL.add('if(ifnull(R.MarketingcontactID,0) = 0,C.Notes,MC.Notes)  as ContactNotes,');
    StringListForSQL.add('R.CREATED');
    StringListForSQL.add('FROM ' + tablename + ' AS R ');
    StringListForSQL.add('Left Join tblclients AS C ON R.CLIENTID = C.ClientID ');
    StringListForSQL.add('Left Join tblmarketingcontacts AS MC ON R.MarketingcontactID = MC.ID');
    StringListForSQL.add('Left Join tblemployees AS E ON R.EMPLOYEEID = E.EmployeeID');
    StringListForSQL.add('Order by E.EmployeeID, due,R.DueTime,  typeno , type;');
    StringListForSQL.add('~|||~{notes}SELECT if(ifnull(MLL.notes,"") = "" , "","Notes:") as Description, R.AutoID,`ML`.Notes as ContactNotes,`MLL`.Notes,`MLL`.ActionDate  ');
    StringListForSQL.add('FROM  `tblmarketingleadlines` AS `MLL` ');
    StringListForSQL.add('Inner Join `tblmarketingleads` AS `ML` ON `ML`.`LeadID` = `MLL`.`LeadID` ');
    StringListForSQL.add('Inner Join ' + tablename + ' as R ');
    StringListForSQL.add('on R.MarketingcontactID = ML.MarketingContactID ');
    //StringListForSQL.add('on R.clientId = if( ifNull(ML.clientID ,0) =0 , ML.MarketingContactID , ML.clientID)');
    StringListForSQL.add('Where R.Type in ("Appointment","Marketing Contact FollowUp","Lead FollowUp")');
    StringListForSQL.add('AND R.AutoID = :AutoID ');
    StringListForSQL.add('and MLL.LeadLineId = R.ID');
    if chkIncludeHistoryNotes.checked   then begin
        StringListForSQL.add(' UNION SELECT  distinct if(ifnull(MLL.notes,"") = "" , "","Old Notes:") as Description, R.AutoID, `ML`.Notes as ContactNotes,`MLL`.Notes,`MLL`.ActionDate  ');
        StringListForSQL.add('FROM  `tblmarketingleadlines` AS `MLL` ');
        StringListForSQL.add('Inner Join `tblmarketingleads` AS `ML` ON `ML`.`LeadID` = `MLL`.`LeadID` ');
        StringListForSQL.add('Inner Join ' + tablename + ' as R ');
        StringListForSQL.add('on R.MarketingcontactID = ML.MarketingContactID ');
        //StringListForSQL.add('on R.clientId = if( ifNull(ML.clientID ,0) =0 , ML.MarketingContactID , ML.clientID)');// and MLL.LeadLineId <> R.ID');
        StringListForSQL.add('Left join tblAppointments A on A.globalref = MLL.ActionREf');
        StringListForSQL.add('Where');// R.Type in ("Appointment","Marketing Contact FollowUp","Lead FollowUp")');
        StringListForSQL.add('((R.Type in ("Marketing Contact FollowUp","Lead FollowUp"))  or (R.type = "Appointment" and ifnull(A.Cancellation,"F") <> "T"))');
        StringListForSQL.add('AND R.AutoID = :AutoID ');
        StringListForSQL.add('AND MLL.Notes <> ""');
        StringListForSQL.add('and MLL.LeadLineId <> R.ID');
    end;

    StringListForSQL.add(' UNION SELECT  distinct "Old Notes:" as Description, R.AutoID,');
    StringListForSQL.add('"" as ContactNotes,');
    StringListForSQL.add('R.Notes,');
    StringListForSQL.add('R.Due as ActionDate ');
    StringListForSQL.add('From  ' + tablename + ' as R');
    StringListForSQL.add('Where R.Type = "Appointment"');
    StringListForSQL.add('AND R.Notes <> ""');
    StringListForSQL.add('AND R.AutoID = :AutoID ');

    StringListForSQL.add('Order by Description  ');
    StringListForSQL.add(' ~|||~{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO');
end;
procedure TfmReminderPrnGUI.btnPrintClick(Sender: TObject);
begin
    StringListForSQL:=TStringList.create;
    fbReportSQLSupplied := True;
    try
        Makereport;
        PrintTemplateReport('Reminder List' , StringListForSQL.TExt, True , 1 );
    finally
        Freeandnil(StringListForSQL);
        fbReportSQLSupplied := False;
    end;

end;

procedure TfmReminderPrnGUI.btnPreviewClick(Sender: TObject);
begin
  DisableForm;
  try
    StringListForSQL:=TStringList.create;
    fbReportSQLSupplied := True;
    try
        Makereport;
        PrintTemplateReport('Reminder List' , StringListForSQL.TExt, False , 1);
    finally
        Freeandnil(StringListForSQL);
        fbReportSQLSupplied := False;
    end;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfmReminderPrnGUI);
end.




