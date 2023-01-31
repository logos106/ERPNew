unit RewardPointsDueToExpire;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RewardPoints, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox;

type
  TRewardPointsDueToExpireGUI = class(TRewardPointsGUI)
    lblMsg1: TLabel;
    btnSelect: TDNMSpeedButton;
    cmdEmail: TDNMSpeedButton;
    procedure dtToChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdEmailClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    Procedure PrintList(const Email:Boolean);
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BaseListingForm, BusObjProductRewardPoints, FastFuncs, EmailUtils,
  MySQLConst, tcDataUtils, CommonDbLib, PrintTemplateObj, DNMLib, AppEnvironment,
  CorrespondenceObj, EmailExtraUtils;

{$R *.dfm}

procedure TRewardPointsDueToExpireGUI.dtToChange(Sender: TObject);
begin
  inherited;
  FilterString:= 'ExpiryDate <= ' +quotedStr(FormatDateTime(FormatSettings.ShortDateformat , FilterDateTo));
end;
procedure TRewardPointsDueToExpireGUI.FormShow(Sender: TObject);
begin
  inherited;
  dtTo.Date := IncMonth(DAte , 1);
  dtToChange(dtTo);

end;

procedure TRewardPointsDueToExpireGUI.cmdEmailClick(Sender: TObject);
begin
  PrintList(True);
end;
procedure TRewardPointsDueToExpireGUI.PrintList(const Email: Boolean);
var
  clientIDs:TStringList;
  ctr: Integer;
  strSQL:string;
  ReportSQL:String;
  ClientID:Integer;
  emailAddress:String;
  Corres: TCorrespondenceGUI;
  OutGoingFileName:string;
  ReportAttachmentfiles:String;
  fsReportName:String;

  Procedure EmailReport;
  var
    lSilent,
    lSecret : boolean;
  begin
    emailAddress := ClientEmail(clientID);
    if emailAddress = '' then begin
      CommonLib.MessageDlgXP_Vista('Email Address missing for client' + GetClientName(clientID)+'.'+#13+#10+#13+#10+'Email Failed !', mtWarning, [mbOK], 0);
      Exit;
    end;
    Corres := TCorrespondenceGUI.Create;
    try
      Corres.Subject := 'Reward points Expiring';
      Corres.RecipientList := emailAddress;
      Corres.MessageText := 'This report email has been sent to you from ' + CommonDbLib.GetCompanyName;
      PrintTemplate.SaveTemplateReport(fsReportName, reportSQL, true, 'PDF', 'EmailReport');

      OutGoingFileName := getOutGoingFileName('' ,' Reward Points #' + IntToStr(ClientID) ,'.PDF');

      if not FileExists( Commonlib.TempDir  + 'EmailReport.PDF') then begin
        CommonLib.MessageDlgXP_Vista('Can''t Find Attachment'+#13+#10+#13+#10+'Email Failed !', mtWarning, [mbOK], 0);
        Exit;
      end;
      try
      if not FileExists( Commonlib.TempDir  + OutGoingFileName) then
          copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
            PChar( Commonlib.TempDir  + OutGoingFileName), false);
      Corres.AttachmentList.Add( Commonlib.TempDir  + OutGoingFileName);
      ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(fsReportName));
      if not EmailShortSendMode(lSilent, lSecret) then
        exit;
      Corres.Execute(lSilent, lSecret);
      finally
        DeleteFiles( Commonlib.TempDir , '*.PDF');
        DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
      end;
    finally
       FreeandNil(Corres);
    end;
  end;

begin
  fsReportName :='Reward Points';
    clientIDs:=TStringList.create;
      for ctr:= 0 to grdmain.SelectedList.Count-1 do begin
          grdmain.Datasource.Dataset.GotoBookmark(grdmain.SelectedList.items[ctr]);
          if SearchStringList(ClientIDs ,grdmain.Datasource.Dataset.FieldByname('clientId').asString)<0 then
            ClientIDs.Add(grdmain.Datasource.Dataset.FieldByname('clientId').asString);
      end;
      if ClientIDs.count = 0 then begin
        CommonLib.MessageDlgXP_Vista('Please select a record. Hold Down Ctrl to Select Multiple Entries.' , mtInformation , [mbok] , 0);
        exit;
      end;
      strSQL:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2,  '+
              ' CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,  '+
              ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO '+
              ' ~|||~{Details}Select ' +
              quotedStr('Reward Points Expiring as on: ' + FormatdateTime(FormatSettings.ShortDateformat, DtTo.date)) +'  as Titlecaption , '+
              ' SP.SaleID,SP.ProductName,SP.LinePoints,SP.LineValue,SP.ValueforRewardPoint, ' +
              'SP.LinePoints - ifnull(round(Sum(SRP.UsedPoints),'+ intToStr(Appenv.CompanyPrefs.RoundUpPoints)+'),0) *`SP`.`ValueforRewardPoint` AvailableValue,' +
              'SP.LinePoints  *`SP`.`ValueforRewardPoint` Pointvalue,'+
              ' C.Company , ' +
              ' round(Sum(SRP.UsedPoints),'+ inttostr(Appenv.CompanyPrefs.RoundUpPoints) +') UsedPoints , ' +
              ' SP.LinePoints - ifnull(round(Sum(SRP.UsedPoints),'+inttostr(Appenv.CompanyPrefs.RoundUpPoints) +'),0) AvailablePoints , ' +
              ' round(Sum(SRP.RedeemAmount),'+inttostr(CurrencyRoundPlaces) +') RedeemAmount, ' +
              ' S.SaleDate,' +
              ' CAST(if(Ifnull(SP.PointExpiresOn,0)<> 0 , SP.PointExpiresOn ,  if(ifnull(SP.ExpiresOnNoOfMonthsAfterPurchase,0)  <> 0,  Date_Add(S.SaleDate , Interval   ExpiresOnNoOfMonthsAfterPurchase MONTH),NULL )) as DAteTime) as ExpiryDate' +
              ' from tblsaleslinespoints SP' +
              ' inner join tblClients c on C.clientID = SP.clientID' +
              ' Left Join tblsales AS S ON SP.SaleID = S.SaleID' +
              ' Left join tblsalesredeempoints SRP on SRP.SalesLinesPointsId = SP.SalesLinesPointsId and SRP.active ="T"' +
              ' where <clientFilter> and SP.active = "T"' +
              ' and (ifnull(ExpiresOnNoOfMonthsAfterPurchase,0) <> 0 OR  ifnull(PointExpiresOn,0) <> 0)' +
              ' and if(Ifnull(SP.PointExpiresOn,0)<> 0 , SP.PointExpiresOn ,  if(ifnull(SP.ExpiresOnNoOfMonthsAfterPurchase,0)  <> 0,  Date_Add(S.SaleDate , Interval   ExpiresOnNoOfMonthsAfterPurchase MONTH),NULL)) <= ' + QuotedStr(formatDateTime(mysqldateFormat , FilterDateTo))+
              ' group by SP.SalesLinesPointsId';

        for ctr := 0 to ClientIDs.count-1 do begin
          if ctr <> 0 then
            if CommonLib.MessageDlgXP_Vista('Do you wish to continue with the next customer''s recport?' , mtConfirmation , [mbyes,mbno],0) = mrno then break;
         clientId :=StrToInt(clientIDs[ctr] );
         if clientID <> 0 then begin
            ReportSQL := StringReplace(strSQL , '<clientFilter>' , 'SP.clientID = ' + clientIDs[ctr] , [rfIgnoreCase]);
            PrintTemplate.ReportSQLSupplied := true;
            if Email then begin
              Emailreport;
            end else begin
              PrintTemplate.PrintTemplateReport(fsReportName, reportSQL, False,1);
            end;
         end;
        end;
end;

procedure TRewardPointsDueToExpireGUI.cmdPrintClick(Sender: TObject);
begin
  PrintList(False);
end;



procedure TRewardPointsDueToExpireGUI.btnSelectClick(Sender: TObject);
begin
  inherited;
  grdmain.SelectAll;
end;

procedure TRewardPointsDueToExpireGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainTRanstype.asString;
  inherited;
end;

initialization
  RegisterClassOnce(TRewardPointsDueToExpireGUI);

end.
