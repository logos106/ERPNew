unit EmployeeAddressFrm;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwclearbuttongroup, wwradiogroup, wwdblook, Mask,
  DBCtrls, ExtCtrls, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, DNMPanel,BusObjEmployeePay,
  frmBase, BusObjBase, wwcheckbox, DNMSpeedButton,BaseInputForm, ProgressDialog,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ibgoauth;

type
  TEmployeeAddress = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DSEmployeesAddress: TDataSource;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    Label78: TLabel;
    Label148: TLabel;
    lblSuburb: TLabel;
    lblState: TLabel;
    lblPostCode: TLabel;
    Label48: TLabel;
    Street: TDBEdit;
    Street2: TDBEdit;
    Suburb: TwwDBLookupCombo;
    State: TDBEdit;
    PostCode: TDBEdit;
    Country: TDBEdit;
    Email: TDBEdit;
    rgEmailsFrom: TwwRadioGroup;
    Label1: TLabel;
    Label3: TLabel;
    qrySuburb: TERPQuery;
    lblAddress3: TLabel;
    Street3: TDBEdit;
    Label4: TLabel;
    chkTrackEmails: TwwCheckBox;
    btnEmailConfig: TDNMSpeedButton;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    lblArea: TLabel;
    cboAreaCode: TwwDBLookupCombo;
    pnlGoogle: TDNMPanel;
    Label2: TLabel;
    Label5: TLabel;
    GoogleEmail: TDBEdit;
    chkSynchWithGoogle: TwwCheckBox;
    Label7: TLabel;
    btnGoogleTest: TDNMSpeedButton;
    tmrAuth: TTimer;
    Label6: TLabel;
    chkTrackSales: TwwCheckBox;
    procedure SuburbCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure SuburbEnter(Sender: TObject);
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure btnEmailConfigClick(Sender: TObject);
    procedure chkTrackEmailsClick(Sender: TObject);
    procedure cboAreaCodeEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGoogleTestClick(Sender: TObject);
    procedure GoogleEmailExit(Sender: TObject);
    procedure chkSynchWithGoogleClick(Sender: TObject);
    procedure tmrAuthTimer(Sender: TObject);
    procedure GoogleEmailChange(Sender: TObject);
    procedure chkTrackSalesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
  public
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
  end;

implementation

uses
  BusObjConst,CommonLib, AppEnvironment, BusObjEmailConfig,
  GoogleApi, GoogleConst, ibgGCalendar, GoogleAuth, GoogleCalendarTest,
  frmEmailConfig2;


{$R *.dfm}

procedure TEmployeeAddress.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

//procedure TEmployeeAddress.HandleAddressErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.EmployeeDetails.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    case FatalStatusItem.Code of
//      BOR_Employee_Err_NoAddress           : begin
//                                               SetControlFocus(Street);
//                                             end;
//      BOR_Employee_Err_NoCity              : begin
//                                               SetControlFocus(Suburb);
//                                             end;
//      BOR_Employee_Err_NoState             : begin
//                                               SetControlFocus(State);
//                                             end;
//      BOR_Employee_Err_NoCountry           : begin
//                                               SetControlFocus(Country);
//                                             end;
//      BOR_Employee_Err_NoEmail             : begin
//                                               SetControlFocus(Email);
//                                             end;
//    end;
//  end;
//end;
procedure TEmployeeAddress.SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  FillTable.FieldByName('State').AsString := LookupTable.FieldByName('State').AsString;
  FillTable.FieldByName('Postcode').AsString := LookupTable.FieldByName('Postcode').AsString;
  FillTable.FieldByName('Country').asString := LookupTable.FieldByName('Country').asString;
end;

procedure TEmployeeAddress.SuburbEnter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

procedure TEmployeeAddress.tmrAuthTimer(Sender: TObject);
begin
  inherited;
  //
end;

procedure TEmployeeAddress.btnEmailConfigClick(Sender: TObject);
var
  Config: TEmailConfig;
begin
  inherited;
  Config := TEmailConfig.Create(nil);
  try
    Config.Connection := TMydacDataConnection.Create(Config);
    Config.Connection.Connection := TMyQuery(DSEmployeesAddress.DataSet).Connection;

    if rgEmailsFrom.ItemIndex = 0 then begin
      Config.LoadSelect('EntityName = "' + DSEmployeesAddress.DataSet.FieldByName('EmployeeName').AsString + '"');
      if Config.Count = 0 then begin
        Config.New;
        Config.EntityName := DSEmployeesAddress.DataSet.FieldByName('EmployeeName').AsString;
        Config.PostDb;
      end;
      if not SameText(Email.Text,Config.EmailAddress) then begin
        Config.EmailAddress := Email.Text;
        Config.PostDb;
      end;
    end
    else begin
      // company email
      Config.LoadSelect('EntityName = "Company"');
      if Config.Count = 0 then begin
        Config.New;
        Config.EntityName := 'Company';
        Config.PostDb;
      end;
      if not SameText(AppEnv.CompanyInfo.Email, Config.EmailAddress) then begin
        Config.EmailAddress := AppEnv.CompanyInfo.Email;
        Config.PostDb;
      end;
    end;


    if frmEmailConfig2.DoEmailConfig(Config) then begin
      if rgEmailsFrom.ItemIndex = 0 then begin
        if not SameText(Email.Text,Config.EmailAddress) then begin
          if not (dsEmployeesAddress.DataSet.State in [dsInsert, dsEdit]) then
            dsEmployeesAddress.DataSet.Edit;
          dsEmployeesAddress.DataSet.FieldByName('Email').AsString := Config.EmailAddress;
        end;
        if not Config.ConfigValid then begin
          if not (dsEmployeesAddress.DataSet.State in [dsInsert, dsEdit]) then
            dsEmployeesAddress.DataSet.Edit;
          dsEmployeesAddress.DataSet.FieldByName('TrackEmails').AsBoolean := false;
        end;
      end
      else begin
        // company email
        if not SameText(AppEnv.CompanyInfo.Email,Config.EmailAddress) then begin
          AppEnv.CompanyInfo.Email := Config.EmailAddress;
          AppEnv.CompanyInfo.PostDb;
        end;
        if not Config.ConfigValid then begin
          if not (dsEmployeesAddress.DataSet.State in [dsInsert, dsEdit]) then
            dsEmployeesAddress.DataSet.Edit;
          dsEmployeesAddress.DataSet.FieldByName('TrackEmails').AsBoolean := false;
          AppEnv.CompanyInfo.TrackEmails := false;
          AppEnv.CompanyInfo.PostDb;
        end;
      end;
    end;

  finally
    Config.Free;
  end;
end;

procedure TEmployeeAddress.btnGoogleTestClick(Sender: TObject);
var
  Auth, RefreshToken: string;
begin
  inherited;
  Auth := DSEmployeesAddress.DataSet.FieldByName('GooglePassword').AsString;
  RefreshToken := DSEmployeesAddress.DataSet.FieldByName('GoogleRefreshPassword').AsString;
  if TestGoogleCalendar(GoogleEmail.Text,Auth,RefreshToken) then begin
    EditDb(DSEmployeesAddress.DataSet);
    DSEmployeesAddress.DataSet.FieldByName('GooglePassword').AsString := Auth;
    DSEmployeesAddress.DataSet.FieldByName('GoogleRefreshPassword').AsString := RefreshToken;
  end;
end;

procedure TEmployeeAddress.cboAreaCodeEnter(Sender: TObject);
begin
  inherited;
  if QryareaCodes.Active = False then
    QryareaCodes.Open;
end;

procedure TEmployeeAddress.chkSynchWithGoogleClick(Sender: TObject);
var
  Auth, RefreshToken: string;
begin
  inherited;
  if not chkSynchWithGoogle.focused then  exit;

  if chkSynchWithGoogle.Checked then begin
    Auth := DSEmployeesAddress.DataSet.FieldByName('GooglePassword').AsString;
    RefreshToken := DSEmployeesAddress.DataSet.FieldByName('GoogleRefreshPassword').AsString;
    if TestGoogleCalendar(GoogleEmail.Text, Auth, RefreshToken) then begin
      EditDb(DSEmployeesAddress.DataSet);
      DSEmployeesAddress.DataSet.FieldByName('GooglePassword').AsString := Auth;
      DSEmployeesAddress.DataSet.FieldByName('GoogleRefreshPassword').AsString := RefreshToken;
    end
    else begin
      chkSynchWithGoogle.Checked := false;
    end;
  end;
end;

procedure TEmployeeAddress.chkTrackEmailsClick(Sender: TObject);
begin
  inherited;
  if chkTrackEmails.Checked then begin
    if DSEmployeesAddress.DataSet.FieldByName('EmailsFromEmployeeAddress').AsBoolean then begin
      if DSEmployeesAddress.DataSet.FieldByName('Email').AsString = '' then begin
        chkTrackEmails.Checked := false;
        CommonLib.MessageDlgXP_Vista('Please enter an email address for this employee', mtInformation, [mbOk], 0);
        exit;
      end;
      if not TEmailConfig.EntityConfigValid(DSEmployeesAddress.DataSet.FieldByName('EmployeeName').AsString,TMyQuery(DSEmployeesAddress.DataSet).Connection) then begin
        chkTrackEmails.Checked := false;
        CommonLib.MessageDlgXP_Vista('Please configure this employee''s email settings.', mtInformation, [mbOk], 0);
        exit;
      end;
    end;
  end;
end;

procedure TEmployeeAddress.chkTrackSalesClick(Sender: TObject);
begin
  inherited;
  if (dsEmployeesAddress.DataSet.State in [dsEdit, dsInsert]) then
    dsEmployeesAddress.DataSet.FieldByName('TrackSales').AsBoolean := chkTrackSales.Checked;
end;

procedure TEmployeeAddress.DoBusinessObjectEvent(  const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited;
  if Value = BusobjEventVal_FailedAddressValidateData then begin
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_Employee_Err_NoAddress           : begin
                                               SetControlFocus(Street);
                                             end;
      BOR_Employee_Err_NoCity              : begin
                                               SetControlFocus(Suburb);
                                             end;
      BOR_Employee_Err_NoState             : begin
                                               SetControlFocus(State);
                                             end;
      BOR_Employee_Err_NoCountry           : begin
                                               SetControlFocus(Country);
                                             end;
      BOR_Employee_Err_NoEmail             : begin
                                               SetControlFocus(Email);
                                             end;
    end;
  end;
end;

procedure TEmployeeAddress.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
end;

procedure TEmployeeAddress.FormShow(Sender: TObject);
begin
  inherited;
  chkTrackSales.Checked := dsEmployeesAddress.DataSet.FieldByName('TrackSales').AsBoolean;
end;

procedure TEmployeeAddress.GoogleEmailChange(Sender: TObject);
begin
  inherited;
  if not GoogleEmail.Focused then exit;
  
  DSEmployeesAddress.DataSet.FieldByName('GooglePassword').AsString := '';
  DSEmployeesAddress.DataSet.FieldByName('GoogleRefreshPassword').AsString := '';
end;

procedure TEmployeeAddress.GoogleEmailExit(Sender: TObject);
var
  Auth, RefreshToken: string;
begin
  inherited;
  RefreshToken := '';
  if GoogleEmail.Modified then begin
    try
      if chkSynchWithGoogle.Checked then begin
        Auth := DSEmployeesAddress.DataSet.FieldByName('GooglePassword').AsString;
        RefreshToken := DSEmployeesAddress.DataSet.FieldByName('GoogleRefreshPassword').AsString;
        if TestGoogleCalendar(GoogleEmail.Text, Auth, RefreshToken) then begin
          EditDb(DSEmployeesAddress.DataSet);
          DSEmployeesAddress.DataSet.FieldByName('GooglePassword').AsString := Auth;
          DSEmployeesAddress.DataSet.FieldByName('GoogleRefreshPassword').AsString := RefreshToken;
        end
        else begin
          chkSynchWithGoogle.Checked := false;
        end;
      end;
    finally
      GoogleEmail.Modified := false;
    end;
  end;
end;

initialization
  RegisterClassOnce(TEmployeeAddress);
end.
