unit frmVS1Database;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, ActnList , BusObjVS1_Cloud, Mask, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, ComCtrls;

type
  TfmVS1Database = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    Actionlist: TActionList;
    qryvs1_clients: TERPQuery;
    dsvs1_clients: TDataSource;
    qryvs1_clientsid: TIntegerField;
    qryvs1_clientsClientName: TWideStringField;
    qryvs1_clientsRegistrationDate: TDateField;
    qryvs1_clientsSoftwareReleaseType: TWideStringField;
    qryvs1_clientsVS1ClientName: TWideStringField;
    qryvs1_clientsvs1ClientID: TIntegerField;
    qryvs1_clientsCreditCardType: TWideStringField;
    qryvs1_clientsCreditCardCardHolderName: TWideStringField;
    qryvs1_clientsCreditCardNumber: TWideStringField;
    qryvs1_clientsCreditCardCVC: TWideStringField;
    qryvs1_clientsCreditCardExpiryMonth: TIntegerField;
    qryvs1_clientsCreditCardExpiryYear: TIntegerField;
    qryvs1_clientsCreditCardNotes: TWideStringField;
    qryvs1_clientsEmailVarified: TWideStringField;
    qryvs1_clientsServerName: TWideStringField;
    qryvs1_clientsDatabaseID: TIntegerField;
    qryvs1_clientsDatabasename: TWideStringField;
    qryvs1_clientsSampleDatabaseID: TIntegerField;
    qryvs1_clientsSampledatabasename: TWideStringField;
    qryvs1_clientsRegionName: TWideStringField;
    qryvs1_clientsLicenseFrom: TDateField;
    qryvs1_clientsLicenseUntil: TDateField;
    qryvs1_clientsLicenseLevel: TIntegerField;
    qryvs1_clientsLicenseRenewDurationType: TWideStringField;
    qryvs1_clientsLicenseRenewDuration: TIntegerField;
    qryvs1_clientsActive: TWideStringField;
    qryvs1_clientsAPIPort: TIntegerField;
    qryvs1_clientsIsHttps: TWideStringField;
    qryvs1_clientsmsTimeStamp: TDateTimeField;
    qryvs1_clientsmsUpdateSiteCode: TWideStringField;
    lblClientPrintNameHeading: TLabel;
    edtPrintName: TDBEdit;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    dsvs1_clientusers: TDataSource;
    qryvs1_clientusers: TERPQuery;
    qryvs1_clientusersID: TIntegerField;
    qryvs1_clientusersClientID: TIntegerField;
    qryvs1_clientusersVS1EmployeeId: TIntegerField;
    qryvs1_clientusersDatabaseName: TWideStringField;
    qryvs1_clientusersEmailId: TWideStringField;
    qryvs1_clientusersPassword: TWideStringField;
    qryvs1_clientusersPhone: TWideStringField;
    qryvs1_clientusersActive: TWideStringField;
    qryvs1_clientusersIsAdminUser: TWideStringField;
    qryvs1_clientusersmsTimeStamp: TDateTimeField;
    qryvs1_clientusersmsUpdateSiteCode: TWideStringField;
    qryvs1_clientmodules: TERPQuery;
    dsvs1_clientmodules: TDataSource;
    qryvs1_clientmodulesID: TIntegerField;
    qryvs1_clientmodulesClientId: TIntegerField;
    qryvs1_clientmodulesLicenseLevel: TIntegerField;
    qryvs1_clientmodulesLicenseRenewDurationType: TWideStringField;
    qryvs1_clientmodulesLicenseRenewDuration: TIntegerField;
    qryvs1_clientmodulesModuleId: TIntegerField;
    qryvs1_clientmodulesModulePriceID: TIntegerField;
    qryvs1_clientmodulesDateStarted: TDateField;
    qryvs1_clientmodulesLicenseFrom: TDateField;
    qryvs1_clientmodulesLicenseUntil: TDateField;
    qryvs1_clientmodulesPrice: TFloatField;
    qryvs1_clientmodulesDiscountAmt: TFloatField;
    qryvs1_clientmodulesDiscountedPrice: TFloatField;
    qryvs1_clientmodulesRenewPrice: TFloatField;
    qryvs1_clientmodulesRenewDiscountAmt: TFloatField;
    qryvs1_clientmodulesRenewDiscountedPrice: TFloatField;
    qryvs1_clientmodulesmoduleDiscountId: TIntegerField;
    qryvs1_clientmodulesDatePaid: TDateTimeField;
    qryvs1_clientmodulesClientPaymentId: TIntegerField;
    qryvs1_clientmodulesActive: TWideStringField;
    qryvs1_clientmodulesDiscountDesc: TWideStringField;
    qryvs1_clientmodulesRenewDiscountDesc: TWideStringField;
    qryvs1_clientmodulesmsTimeStamp: TDateTimeField;
    qryvs1_clientmodulesmsUpdateSiteCode: TWideStringField;
    qryvs1_clientmodulesLicenseExtensionDesc: TWideStringField;
    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    wwDBGrid1: TwwDBGrid;
    wwIButton1: TwwIButton;
    tqryvs1_modules: TERPQuery;
    tqryvs1_modulesID: TIntegerField;
    tqryvs1_modulesModuleName: TWideStringField;
    tqryvs1_modulesDescription: TWideStringField;
    qryvs1_clientmodulesModuleName: TWideStringField;
    qryvs1_clientmodulesModuleDesc: TWideStringField;
    Label2: TLabel;
    Label3: TLabel;
    DNMPanel6: TDNMPanel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit2: TDBEdit;
    dtExtendLicenseTo: TDateTimePicker;
    Label6: TLabel;
    Label7: TLabel;
    edtExtendLicense: TEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    edtAccountant: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCloseClick(Sender: TObject);
    procedure qryvs1_clientsAfterOpen(DataSet: TDataSet);
    procedure DNMSpeedButton1Click(Sender: TObject);

  private
    VS1_Client: TVS1_Clients;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure FillAccountList;

  Protected
  public
    { Public declarations }
  end;


implementation

uses MySQLConst, frmWebApiTest, CommonLib, AppEnvironment, FormFactory, busobjconst, dateutils,
  tcConst;

(*uses AppEnvironment, CommonLib, BusObjConst, FormFactory, frmWebApiTest;*)

{$R *.dfm}

procedure TfmVS1Database.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;

end;

procedure TfmVS1Database.DNMSpeedButton1Click(Sender: TObject);
var
  frm : TfmWebAPITest;
begin
  inherited;
  if dtExtendLicenseTo.date <=dateof(qryvs1_clientsLicenseUntil.asDateTime) then begin
    MessageDlgXP_vista('This database is already licensed for this date range', mtConfirmation, [mbOK], 0);
    Exit;
  end;
  if MessageDlgXP_Vista('This will only Extend the License in VS1 License Server.'+NL+
                        'VS1 login will allow the Application to Login by Extending this date .'+NL+
                        'Renewal payment will be processed as per the current License Date.  '+NL+NL+
                        '***** Magento Subscription needs to be INACTIVATED.******'+NL+
                        'Please Login to Magento to Change it Manually.'+NL+NL+
                        'Do you wish To continue ?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  if not qryvs1_clientusers.Locate('IsAdminUser', 'T', []) then qryvs1_clientusers.First;
  frm := TfmWebAPITest(GetComponentByClassName('TfmWebAPITest' , true, self, false));
  if assigned(frm) then begin
     frm.IgnorecheckSettings := true;
     frm.WindowState := wsNormal;
     frm.FormStyle := fsMDIChild;
     frm.WindowState := wsNormal;
     frm.BringToFront;
     frm.btnvs1credentisal.click;
     frm.edtDatabase.Text := AppEnv.AppDb.Database;
     frm.AddClassToURL('VS1_Cloud_Task/Method?Name="VS1_Renew"');
     frm.memRequest.Lines.Clear;
     frm.memRequest.Lines.Add('"JsonIn":{');
     frm.memRequest.Lines.Add('"Name":"VS1_Renew",');
     frm.memRequest.Lines.Add('"Params":{');
     frm.memRequest.Lines.Add('   "CloudUserName":"'+ trim(qryvs1_clientusersEmailId.asString) +'",');
     frm.memRequest.Lines.Add('   "CloudPassword":"'+ trim(qryvs1_clientusersPassword.asString) +'",');
     frm.memRequest.Lines.Add('   "Paymentamount":0,');
     frm.memRequest.Lines.Add('   "AdjustmentExtension":true,');
     frm.memRequest.Lines.Add('   "LicenseExtensionTo":"'+ FormatdateTime(mysqldateformat, dtExtendLicenseTo.Date) +'",');
     frm.memRequest.Lines.Add('   "LicenseExtensionDesc":"'+ trim(edtExtendLicense.Text) +'"');
     frm.memRequest.Lines.Add('}');
     frm.memRequest.Lines.Add('}');
     if MessageDlgXP_vista('Extend Date?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
        frm.btnPost.click;
  end;
end;

procedure TfmVS1Database.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TVS1_Clients then TVS1_Clients(Sender).Dataset  := qryvs1_clients
		else if Sender is TVS1_ClientUsers then TVS1_ClientUsers(Sender).Dataset  := qryvs1_clientUsers
		else if Sender is TVS1_ClientModules then TVS1_ClientModules(Sender).Dataset  := qryvs1_clientModules;
     end;
end;

procedure TfmVS1Database.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmVS1Database.FormCreate(Sender: TObject);
begin
  inherited;
  NewBusObjinstance;
  edtExtendLicense.text := '';
end;

procedure TfmVS1Database.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
  FillAccountList;
end;

procedure TfmVS1Database.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  VS1_Client := TVS1_Clients.CreateWithNewConn(Self);
  VS1_Client.Connection.connection := Self.MyConnection;
  VS1_Client.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

procedure TfmVS1Database.FillAccountList;
var
  TempQuery: TERPQuery;
  DBName: String;
begin
  DBName := VS1_Client.Databasename;

  TempQuery := TERPQuery.Create(nil);
  try
    with TempQuery do begin
      Connection := Self.MyConnection;
      SQL.Clear;
      SQL.Add('SELECT EmailID AS UserName FROM tblVS1_ClientUsers WHERE IsAccountant="T" AND DatabaseName=' + QuotedStr(DBName));
      Open;
//      cboAccountants.Items.Clear;
//      while not EOF do begin
//        cboAccountants.Items.Add(FieldByName('UserName').AsString);
//        Next;
//      end;
    end;
  finally
    TempQuery.Free;
  end;
end;

procedure TfmVS1Database.Openrec;
begin
  VS1_Client.Load(KeyID);
  VS1_Client.ClientUsers;
  VS1_Client.ClientModules;
  VS1_Client.Connection.BeginTransaction;
  if VS1_Client.Count = 0 then VS1_Client.New;
  openQueries;
  VS1_Client.Dirty := false;
end;

procedure TfmVS1Database.qryvs1_clientsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dtExtendLicenseTo.Date := IncDay(Dateof(qryvs1_clientsLicenseUntil.AsDateTime),1);
end;

initialization
  RegisterClassOnce(TfmVS1Database);
  with FormFact do begin
    RegisterMe(TfmVS1Database, 'TVs1DatabaseListGUI_*=ClientId');
  end;

end.

