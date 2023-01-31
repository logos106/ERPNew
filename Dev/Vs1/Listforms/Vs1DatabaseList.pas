unit Vs1DatabaseList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TVs1DatabaseListGUI = class(TBaseListingGUI)
    btnDelete: TDNMSpeedButton;
    btnDeleteall: TDNMSpeedButton;
    btnDropAllDBs: TDNMSpeedButton;
    btnDropADB: TDNMSpeedButton;
    qryMainrownum: TLargeintField;
    qryMainClientId: TIntegerField;
    qryMaindid: TIntegerField;
    qryMainDatabaseName: TWideStringField;
    qryMainServerName: TWideStringField;
    qryMainRegionname: TWideStringField;
    qryMainSTATUS: TWideStringField;
    qryMainCreatedOn: TDateField;
    qryMainUsedOn: TDateField;
    qryMainvs1ClientName: TWideStringField;
    qryMainRegistrationDate: TDateField;
    qryMainSoftwareReleaseType: TWideStringField;
    qryMainLicenseLevel: TWideStringField;
    qryMainModuleName: TWideStringField;
    qryMainModuleDescription: TWideStringField;
    qryMainDateStarted: TDateField;
    qryMainLicenseFrom: TDateField;
    qryMainLicenseUntil: TDateField;
    qryMainVs1_ClientID: TIntegerField;
    qryMainishttps: TWideStringField;
    qryMainAPIPort: TIntegerField;
    qryMainusername: TWideStringField;
    qryMainPassword: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDeleteallClick(Sender: TObject);
    procedure btnDropAllDBsClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDropADBClick(Sender: TObject);
    procedure HeaderPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Deletingall:Boolean;
    Procedure MakeQrymain;
    function DeleteRelatedSQL: String;
    function DropDBSQL: String;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, DbSharedObjectsObj, LogLib, CommonDbLib, tcConst,
  Clipbrd,  ERPErrorEmailUtils, AppEnvironment, ERPVersionConst, ERPLib, JSONObject;

{$R *.dfm}

{ TVs1DatabaseListGUI }

procedure TVs1DatabaseListGUI.btnDeleteallClick(Sender: TObject);
begin
  inherited;
  if not devmode then exit;
  try
    with ScriptMain do begin
        sql.clear;
        sql.add('truncate tblVS1_clientmodules ;');
        sql.add('truncate tblVS1_clientmodulesusage ;');
        sql.add('truncate tblVS1_clients ;');
        sql.add('truncate tblVS1_clientusers ;');
        sql.add('truncate tblVS1_clientpayments ;');
        sql.add('UPDATE tblVS1_databases SET STATUS ="Available", Usedon=NULL, DiscontinuedOn=NULL,Vs1_ClientID=null ;');
        Clog(SQL.text);
        ExecutewithProgress(False);
    end;
  finally
    RefreshQuery;
  end;
end;

procedure TVs1DatabaseListGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if not devmode then exit;

  if MessageDlgXP_Vista('Do You Wish to Delete '+qryMainvs1ClientName.asString +'?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

  try
    with ScriptMain do begin
        sql.clear;
        sql.add('delete from tblVS1_clientmodules where ClientId =' +inttostr(qrymainclientId.asInteger)+';');
        sql.add('delete from tblVS1_clientmodulesusage where ClientId =' +inttostr(qrymainclientId.asInteger)+';');
        sql.add('delete from tblVS1_clients where ID =' +inttostr(qrymainclientId.asInteger)+';');
        sql.add('delete from tblVS1_clientusers where ClientId =' +inttostr(qrymainclientId.asInteger)+';');
        sql.add('delete from tblVS1_clientpayments where ClientId =' +inttostr(qrymainclientId.asInteger)+';');
        sql.add('UPDATE tblVS1_databases SET STATUS ="Available", Usedon=NULL, DiscontinuedOn=NULL,Vs1_ClientID=null where ID = =' +inttostr(qrymaindId.asInteger)+';');
        Clog(SQL.text);
        ExecutewithProgress(False);
        MessageDlgXP_Vista('VS1 Database and Users are deleted for  '+qryMainvs1ClientName.asString +'.'+NL+NL+
                            'Please Note that the Invoice(s), Customer Payemnt(s) Or any other transactions created for '+qryMainvs1ClientName.asString +' as a Customer, are not Deleted', mtInformation, [mbOK], 0);
    end;
  finally
    RefreshQuery;
  end;
end;

procedure TVs1DatabaseListGUI.btnDropAllDBsClick(Sender: TObject);
var
  st1, st2:TStringList;
begin
  st1:=TStringList.Create;
  st2:=TStringList.Create;
  try
    Deletingall:=true;
    try
      qrymain.first;
      while qrymain.eof = false do begin
         st1.add(DropDBSQL);
         st2.add(DeleteRelatedSQL);
        qrymain.Next;
      end;
    finally
      Deletingall:=False;
    end;
  finally
    st1.SAveTofile('c:\st1.log');
    st2.SAveTofile('c:\st2.log');

    Freeandnil(st1);
    Freeandnil(st2);
  end;
(*var
  qry1, qry2: TERPQuery;
  conn: TERPConnection;
begin

  inherited;
  if not devmode then exit;
  try
      btnDeleteall.click;
      with ScriptMain do begin
        SQL.clear;
        SQL.add('truncate tblVS1_databases;');
        SQL.add('truncate tblsales;');
        SQL.add('truncate tblsaleslines;');
        SQL.add('truncate tbldeposits;');
        SQL.add('truncate tbldepositline;');
        SQL.add('truncate tblpqa;');
        SQL.add('truncate tblprepayments;');
        Execute;
      end;
      qry1 := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        qry1.sql.text := 'SELECT DISTINCT servername FROM  tblVS1_clientdbservers';
        qry1.open;
        if qry1.recordcount =0 then exit;
        qry1.first;
        while qry1.EOF = false do begin
          if MessageDlgXP_Vista('Are you sure to Delete all VS1 databases from '+NL+Quotedstr(qry1.fieldbyname('servername').asString)+'?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
              logtext('Conn :' +qry1.fieldbyname('servername').asString);
              conn := GetNewMyDacConnection(self,'', qry1.fieldbyname('servername').asString);
              qry2 := DbSharedObjectsObj.DbSharedObj.GetQuery(conn);
              try
                qry2.sql.text :='Show databases like "vs1_cloud_db_%"';
                qry2.open;
                if qry2.recordcount =0 then exit;
                qry2.first;
                with ScriptMain do begin
                  connection := conn;
                  SQL.clear;
                  while qry2.eof = false do begin
                    SQL.add('drop database if exists ' + qry2.Fields[0].asString+';');
                    qry2.Next;
                  end;
                  if SQL.count =0 then exit;
                  logtext(SQL.text);
                end;
                ExecutewithProgress(False);
              finally
                DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry2);
              end;
          end;
          qry1.Next;
        end;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry1);
      end;
  finally
    RefreshQuery;
  end;*)
end;

Function TVs1DatabaseListGUI.DropDBSQL:String;
  begin
    REsult := 'Drop database if exists ' + qryMainDatabaseName.asString+';';
  end;

Function TVs1DatabaseListGUI.DeleteRelatedSQL:String;
begin
  Result := 'delete from tblVS1_clientmodules where ClientId =' +inttostr(qrymainclientId.asInteger)+';'+NL+
            'delete from tblVS1_clientmodulesusage where ClientId =' +inttostr(qrymainclientId.asInteger)+';'+NL+
            'delete from tblVS1_clients where ID =' +inttostr(qrymainclientId.asInteger)+';'+NL+
            'delete from tblVS1_clientusers where ClientId =' +inttostr(qrymainclientId.asInteger)+';'+NL+
            'delete from tblVS1_clientpayments where ClientId =' +inttostr(qrymainclientId.asInteger)+';'+NL+
            'delete from tblVS1_databases where ID =' +inttostr(qrymaindId.asInteger)+';'+NL+
            'update tblclients Set Active ="F" where ClientId =' +inttostr(qrymainVs1_ClientID.asInteger)+';'
end;

procedure TVs1DatabaseListGUI.btnDropADBClick(Sender: TObject);
var
  //acon : TERPConnection;
  //cmd :TERPCommand;
  s:String;
begin
  inherited;
  //if not devmode then exit;
  if not Deletingall then begin
    if (qryMainusername.asString = '')  and (MessageDlgXP_Vista('This is an Empty Database - Not Assgined to any Client. Do you want to delete this Database ?', mtConfirmation, [mbYes, mbNo], 0) = mrno) then exit;

    if (qryMainusername.asString <> '')  and (MessageDlgXP_Vista('It is NOT Possible to Revert if you Delete' +NL+
                          'Are u sure u want to Delete  ' + quotedstr(qryMainusername.asString)  +', the database and all Users of this Database?', mtConfirmation, [mbYes, mbNo], 0) = mrno) then exit;
  end;

    SendEmailtoErp('DropVS1databaseScript',
                            'Company     :' + Appenv.CompanyInfo.Companyname + NL +
                            'Server      :' + GetSharedMyDacConnection.Server + NL +
                            'Datase      :' + GetSharedMyDacConnection.Database + NL +
                            'Version     :' + TABLE_VERSION + NL +NL +



                            '/* ********* RUN in License Server (Core EDI) ******* */'+NL+NL+

                            '1: Run ERP and log into database - vs1_sandbox_license'+NL+NL+

                            '2: open "VS1 Database List" and Select the database to delete'+NL+
                            '  Choose "delete Users and drop db"'+NL+
                            '   This will generate an email to simon@erpoz.com'+NL+NL+

                            '3: Check email'+NL+NL+

                            '4: Open Special form and run the script below'+NL+
                            '   Choose Utilities -> Database Utils -> Special Form( Password :mc3My&%!))'+NL+
                            '5: Copy script below from email (below is an example)'+NL+NL+
                            DeleteRelatedSQL+NL+NL+NL+

                            '  =============================================================='+NL+NL+

                            '  /* ********* RUN in VS1_SandBox_Server ******* */'+NL+NL+

                            '  1: Run ERP and log into database - aus_sample_company(or any database other than one deleting)'+NL+
                            '     Open Special form and run the script below'+NL+
                            '     Choose Utilities -> Database Utils -> Special Form( Password :mc3My&%!))'+NL+NL+

                            '  2: Copy script below from email (below is an example)'+NL+NL+

                            DropDBSQL+NL+NL+

                            (*'/* ********* RUN in VS1_SandBox_Server ******* */'+NL+
                            '1: Save the Following Script into a File '+NL+
                            DropDBSQL+NL+NL+
                            '2: Copy the script file to  ' + qryMainServerName.asString+' '+NL+
                            '3: On ' + qryMainServerName.asString+' Run ERP and log into any database other than '+qryMainDatabaseName.asString+NL+
                            '4: Choose Utilities -> Database Utils -> Special Form( Password :' + SPECIALPASSWORD+')' +NL+
                            '5: Choose the Script file copied and Run.'+NL+NL+NL+

                            '/* ********* RUN in License Server ******* */'+NL+
                            '1: Save the Following Script into a File '+NL+
                            DeleteRelatedSQL+NL+NL+NL+
                            '2: Copy the script file to  ' + GetSharedMyDacConnection.Server+' '+NL+
                            '3: On ' + GetSharedMyDacConnection.Server +' Run ERP and log into VS1_License database ('+AppEnv.AppDb.Database+')'+NL+
                            '4: Choose Utilities -> Database Utils -> Special Form( Password :' + SPECIALPASSWORD+')' +NL+
                            '5: Choose the Script file copied and Run.'+NL+NL+NL+*)

                            '  =============================================================='+NL+NL+
                            '/* ********* MAGENTO ADMIN LOGIN (Please check this with RASHEED)******* */'+NL+
                            'Magento Subscription needs to be INACTIVATED. Please Login to Magento to do it '

                            (*'URL:	https://www.payments.vs1cloud.com/admin/'+NL+
                            'User:	admin@vs1cloud.com'+NL+
                            'Pass: 	Pe6dd5Q','Email Log'*), '', VS1LogEmailID );
    if  Deletingall then Exit;

    MessageDlgXP_Vista('Email is Sent to ERP To Drop the VS1 Databse - ' +  qryMainServerName.asString+'.'+qryMainDatabaseName.asString +'. ', mtInformation, [mbOK], 0);
    Exit;

  try
  try
    (*ShowProgressbar('Droping the Database', 5);
    try
      acon := GetNewMyDacConnection(Self, 'erpnewdb',qryMainServerName.asString);
      try
          StepProgressbar;
          cmd := DbSharedObj.Getcommand(acon);
          try
            cmd.SQL.Clear;
            cmd.SQL.Add(DropDBSQL);
            clog(cmd.SQL.text);
            StepProgressbar;
            cmd.Execute;
            StepProgressbar;
          finally
            DbSharedObj.ReleaseObj(cmd);
          end;
      finally
        Freeandnil(acon);
      end;
    finally
      HideProgressbar;
    end;*)

    s:= qryMainServerName.asString;
    if qryMainishttps.asBoolean then  s:= 'https://'+s else s:= 'http://' +s;
    s:= s+':' + trim(inttostr(qryMainAPIPort.asInteger));
    s:= s+'/erpapi/system/method?Name="DropDatabase"';
     // copy code from webapi test form to a lilbrary and clal web api


    with ScriptMain do begin
        sql.clear;
        sql.add(DeleteRelatedSQL);
        //sql.add('UPDATE tblVS1_databases SET STATUS ="Available", Usedon=NULL, DiscontinuedOn=NULL,Vs1_ClientID=null where ID = =' +inttostr(qrymaindId.asInteger)+';');
        Logtext(SQL.text);
        ExecutewithProgress(False);
         if (qryMainusername.asString <> '')  then MessageDlgXP_Vista('VS1 Database and Users are deleted for  '+qryMainvs1ClientName.asString +'.'+NL+NL+
                            'Please Note that the Invoice(s), Customer Payemnt(s) Or any other transactions created for '+qryMainvs1ClientName.asString +' as a Customer, are not Deleted', mtInformation, [mbOK], 0)
         else MessageDlgXP_Vista('Database Deleted.',mtInformation, [mbOK], 0);

    end;
  finally
    RefreshQuery;
  end;
  Except
    on E:Exception do begin
          SendEmailtoErp('DropVS1databaseScript',
                            'Company     :' + Appenv.CompanyInfo.Companyname + NL +
                            'Server      :' + GetSharedMyDacConnection.Server + NL +
                            'Datase      :' + GetSharedMyDacConnection.Database + NL +
                            'Version     :' + TABLE_VERSION + NL +NL +
                            'Use '+qryMainServerName.asString+'.ERPnewdb;'+NL+
                            DropDBSQL+NL+NL+
                            'Use '+GetSharedMyDacConnection.Server +'.VS1_License;'+
                            DeleteRelatedSQL);
          MessageDlgXP_Vista('Failed to Drop the VS1 Databse - ' +  qryMainServerName.asString+'.'+qryMainDatabaseName.asString +'. '+NL+
                             'Email is Sent to ERP. Please contact ERP Admin', mtInformation, [mbOK], 0);
    end;
  end;

end;

procedure TVs1DatabaseListGUI.FormCreate(Sender: TObject);
begin
  Deletingall := False;
  MakeQrymain;
  qryMain.IndexFieldNames := QuotedStr('did') + ' ASC CIS';
  BaseIndexFieldNames := QuotedStr(qrymaindid.fieldname) + ' ASC CIS,' + QuotedStr(qryMainrownum.fieldname) + ' ASC CIS';
  BaseIndexFieldNames := QuotedStr(qrymaindid.fieldname) + ' ASC CIS,' + QuotedStr(qryMainrownum.fieldname) + ' ASC CIS';
  inherited;
  btnDropAllDBs.visible := False; //devmode;
  btnDropADB.visible :=  IsVS1_ProductionAdminDatabase or IsVS1_SandBoxAdminDatabase;//devmode;


  //btnDelete.visible := devmode;
  //btnDeleteall.visible := devmode;
  HaveDateRangeSelection := False;
end;

procedure TVs1DatabaseListGUI.FormShow(Sender: TObject);
begin
  inherited;
  Closedb(Qrymain);
  Refreshquery;
end;

procedure TVs1DatabaseListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  try
  if qrymainrownum.asInteger <>1 then
    if sametext(field.fieldname,qryMainLicenseLevel.fieldname) or
       sametext(field.fieldname,qryMainModuleName.fieldname) or
       sametext(field.fieldname,qryMainModuleDescription.fieldname) then
       else DoHide(Field,State,Afont,ABrush);
  Except
    on E:Exception do begin
      Logtext(E.message);
    end;
  end;
end;

procedure TVs1DatabaseListGUI.grdMainKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
var
  js: TJsonObject;
begin
  inherited;
  if (Shift = [ssCtrl] ) and ((char(Key) = 'c') or (char(Key) = 'C')) then begin
    js := jo;
    try
      js.s['DatabaseName'] := qryMainDatabaseName.asString;
      js.s['ServerName'] := qryMainServerName.asString;
      js.s['username'] := qryMainusername.asString;
      js.s['Password'] := qryMainPassword.asString;
      Clipboard.asText := js.asString;
    finally
      js.Free;
    end;
  end;
end;

procedure TVs1DatabaseListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('STATUS', ['Used', 'Available', '']);
  inherited;
end;

procedure TVs1DatabaseListGUI.HeaderPanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if devmode then
    if Shift = [ssShift, ssCtrl, ssALt,ssRight] then
      btnDropAllDBs.visible := not(btnDropAllDBs.visible);
end;

procedure TVs1DatabaseListGUI.MakeQrymain;
begin
  qrymain.SQL.clear;
  qrymain.SQL.Add('SELECT');
  qrymain.SQL.Add(' @rownum:=if(@Vs1_ClientID <> d.Vs1_ClientID OR IFNULL(d.Vs1_ClientID,0)=0,  @rownum:= 1 ,  @rownum+1) rownum ,');
  qrymain.SQL.Add(' @Vs1_ClientID := d.Vs1_ClientID,');
  qrymain.SQL.Add('d.id                   AS did,');
  qrymain.SQL.Add('VC.id                  AS ClientId,');
  qrymain.SQL.Add('d.DatabaseName         AS DatabaseName,');
  qrymain.SQL.Add('d.ServerName           AS ServerName,');
  qrymain.SQL.Add('d.Regionname           AS Regionname,');
  qrymain.SQL.Add('d.Status               AS STATUS,');
  qrymain.SQL.Add('d.CreatedOn            AS CreatedOn,');
  qrymain.SQL.Add('d.UsedOn               AS UsedOn,');
  qrymain.SQL.Add('c.company              AS vs1ClientName,');
  qrymain.SQL.Add('vc.RegistrationDate    AS RegistrationDate,');
  qrymain.SQL.Add('vc.SoftwareReleaseType AS SoftwareReleaseType,');
  qrymain.SQL.Add('ll.Description         AS LicenseLevel,');
  qrymain.SQL.Add('lm.ModuleName          AS ModuleName,');
  qrymain.SQL.Add('lm.Description         as ModuleDescription,');
  qrymain.SQL.Add('cm.DateStarted         AS DateStarted,');
  qrymain.SQL.Add('cm.LicenseFrom         AS LicenseFrom, ');
  qrymain.SQL.Add('cm.LicenseUntil        AS LicenseUntil,');
  qrymain.SQL.Add('C.clientID				      AS Vs1_ClientID,');
  qrymain.SQL.Add('cu.EmailId             AS username,');
  qrymain.SQL.Add('cu.Password            AS Password,');
  qrymain.SQL.Add('d.ishttps              AS ishttps,');
  qrymain.SQL.Add('d.APIPort              AS APIPort');
  qrymain.SQL.Add('FROM  (SELECT @rownum:=0) r , tblVS1_databases d');
  qrymain.SQL.Add('LEFT JOIN tblclients c ON d.Vs1_ClientID = c.clientID');
  qrymain.SQL.Add('LEFT JOIN tblVS1_clients vc ON vc.vs1ClientID = c.clientID');
  qrymain.SQL.Add('LEFT JOIN tblVS1_clientmodules cm ON vc.id = cm.ClientId');
  qrymain.SQL.Add('LEFT JOIN tblVS1_licenselevels ll ON ll.ID = cm.LicenseLevel AND ifnull(cm.ModuleId,0)=0');
  qrymain.SQL.Add('LEFT JOIN tblVS1_modules lm ON cm.ModuleId = lm.ID');
  qrymain.SQL.Add('LEFT JOIN tblVS1_clientusers cu ON vc.id = cu.ClientID AND cu.IsAdminUser="T"');
  qrymain.SQL.Add('Order by did, rownum');
end;

procedure TVs1DatabaseListGUI.RefreshQuery;
begin
  inherited;

end;

initialization
  RegisterClass(TVs1DatabaseListGUI);

end.
