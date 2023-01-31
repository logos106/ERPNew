unit VATObligationObj;

interface

uses
  utGovUK_API;

type
  TVATObligation = class(TObject)
  private
    fAssignedAPI: TGovUK_API;

    fAuthSuccessMessage: string;
    function UpdateData: boolean;
    function GetAPI: TGovUK_API;
    procedure SetAPI(const Value: TGovUK_API);
    procedure DoOnAPIError(Sender: TObject);
//    procedure DoOnNewToken(Sender: TGovUK_API; Scope, Token: string);
  public
    constructor Create;
    destructor Destroy; override;
    property API: TGovUK_API read GetAPI write SetAPI;
    function CheckObligations: boolean;
    property AuthSuccessMessage: string read fAuthSuccessMessage write fAuthSuccessMessage;
  end;

implementation

uses
  AppEnvironment, CommonLib, CommonDbLib, Dialogs, ERPDbComponents, JsonObject,
  ProgressDialog, DateUtils, SysUtils, Controls, Preferences;

{ TVATObligation }
{ return true if obligation list changed }
function TVATObligation.CheckObligations: boolean;
var
  RequiresRefresh: boolean;
  msg: string;
begin
  result := false;
  if not AppEnv.CompanyPrefs.HMRC_APIConfig.Validate(msg) then begin
    if not AppEnv.CompanyPrefs.HMRC_APIConfig.Active then begin
        if MessageDlgXP_Vista(msg,mtinformation,[MbOk],0,
                              nil,'','', False,nil,'Open Preference') = 100 then
          //OpenPrefform('Accounts' ,  'chkHMRCActive', 0 , True, 'Sandbox Client ID' , '' );
          OpenPrefform('Accounts' ,  '', 0 , True, 'HMRC API (UK Gov VAT)' , '' );
    end else CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOK],0);
    exit;
  end;
  API.SandboxClientID := AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientID;
  API.SandboxClientSecret := AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientSecret;
  API.ProductionClientID := AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientID;
  API.ProductionClientSecret := AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientSecret;
  API.VATRegistrationNumber := AppEnv.CompanyPrefs.HMRC_APIConfig.VATRegistrationNumber;
  API.SandboxMode := AppEnv.CompanyPrefs.HMRC_APIConfig.TestMode;
  API.AuthSuccessMessage := Self.AuthSuccessMessage;

  if API.CheckToken(Scope_VAT, RequiresRefresh) then begin
    if RequiresRefresh then begin
      if CommonLib.MessageDlgXP_Vista('User validation required, continue?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        API.RefreshToken(Scope_VAT);
      end;
    end
    else begin
      result := UpdateData;
    end;
  end
  else begin
    CommonLib.MessageDlgXP_Vista(API.ErrorList.FormattedErrors, mtInformation, [mbOk], 0);
  end;
end;

constructor TVATObligation.Create;
begin
  fAssignedAPI := nil;
  fAuthSuccessMessage := '';
//  API := TGovUK_API.Create;
//  API.OnNewToken := DoOnNewToken;
end;

destructor TVATObligation.Destroy;
begin
  inherited;
end;

procedure TVATObligation.DoOnAPIError(Sender: TObject);
begin
  CommonLib.MessageDlgXP_Vista(TGovUK_API(Sender).ErrorList.FormattedErrors, mtError, [mbOk], 0);
end;

function TVATObligation.GetAPI: TGovUK_API;
begin
  if Assigned(fAssignedAPI) then
    result := fAssignedAPI
  else begin
    result := TGovUK_API.Inst;
  end;
  result.OnError := DoOnAPIError;
end;

procedure TVATObligation.SetAPI(const Value: TGovUK_API);
begin
  fAssignedAPI := Value;
end;

//procedure TVATObligation.DoOnNewToken(Sender: TGovUK_API; Scope, Token: string);
//begin
//
//end;

function TVATObligation.UpdateData: boolean;
var
  qry: TERPQuery;
  DateFrom, DateTo: TDateTime;
  res, item: TJsonObject;
  ScopeRequiringUserRefresh: string;
  I: Integer;
  NewCount, UpdateCount: integer;
  Dlg: TProgressDialog;
  steps: integer;
  status: string;
begin
  result := false;
  qry := TERPQuery.Create(nil);
  res := JO;
  API.EnableOnError := false;
  try
    status := '';
    DateFrom := 0;
    DateTo := 0;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    NewCount := 0;
    UpdateCount := 0;

    qry.SQL.Text := 'SELECT MIN(START) as DateFrom FROM tblvatobligations WHERE STATUS = "O"';
    qry.Open;
    if qry.FieldByName('DateFrom').IsNull then begin
      { just get all open returns }
      status := 'O';
    end
    else begin
      { get all from last open record }
      DateFrom := qry.FieldByName('DateFrom').AsDateTime;
      { max allowable date range is 366 days .. so lets get chunks of 6 months each .. }
      DateTo := IncMonth(DateFrom,6);
      if DateTo > Trunc(Now) then
        DateTo := Trunc(Now);
    end;

//    if qry.FieldByName('DateFrom').IsNull then
//      DateFrom := IncYear(Trunc(now), -10)
//    else
//      DateFrom := qry.FieldByName('DateFrom').AsDateTime;
//    DateTo := IncMonth(DateFrom,6);
//    if DateTo > Trunc(Now) then
//      DateTo := Trunc(Now);

    qry.Close;

    Dlg := TProgressDialog.Create(nil);
    try
      Dlg.Caption := 'Getting data ...';
      if DateFrom > 0 then begin
        steps := Trunc((MonthsBetween(now, DateFrom) / 6)) + 1;
        if steps < 2 then
          steps := 2;
        Dlg.Message := 'Checking from date ' + FormatDateTime('yyyy-mm-dd', DateFrom);
      end
      else begin
        steps := 2;
        Dlg.Message := 'Checking for open returns';
      end;
      Dlg.MaxValue := steps;
      Dlg.MinValue := 0;
      Dlg.Step := 1;
      Dlg.Value := 1;
      Dlg.Execute;

      while true do begin

        if DateFrom > 0 then
          Dlg.Message := 'Checking from date ' + FormatDateTime('yyyy-mm-dd', DateFrom);
        if not API.GetVATObligations(DateFrom,DateTo,status, res, ScopeRequiringUserRefresh) then begin
//          if API.ErrorList.FormattedErrors <> 'INVALID_DATE_RANGE' then begin
            Dlg.CloseDialog;
            CommonLib.MessageDlgXP_Vista(API.ErrorList.FormattedErrors,mtInformation,[mbOK],0);
            exit;
//          end;
        end;
        if ScopeRequiringUserRefresh <> '' then begin
          Dlg.CloseDialog;
          CommonLib.MessageDlgXP_Vista('User validation required.',mtInformation,[mbOK],0);
          exit;
        end;

        for I := 0 to res.A['obligations'].Count -1 do begin
          item := res.A['obligations'][I].AsObject;
          qry.SQL.Text := 'select * from tblvatobligations where PeriodKey = ' + QuotedStr(item.S['periodKey']);
          qry.Open;
          if qry.IsEmpty then begin
            qry.Insert;
            qry.FieldByName('PeriodKey').AsString := item.S['periodKey'];
            qry.FieldByName('Start').AsDateTime := item.DT['start'];
            qry.FieldByName('End').AsDateTime := item.DT['end'];
            qry.FieldByName('Due').AsDateTime := item.DT['due'];
            qry.FieldByName('Status').AsString := item.S['status'];
            qry.Post;
            Inc(NewCount);
          end
          else begin
            if qry.FieldByName('Status').AsString <> item.S['status'] then begin
              qry.Edit;
              qry.FieldByName('Received').AsDateTime := item.DT['received'];
              qry.FieldByName('Status').AsString := item.S['status'];
              qry.Post;
              Inc(UpdateCount);
            end;
          end;
          qry.Close;
        end;

        if DateFrom = 0 then
          break;
        if DateTo >= Trunc(now) then
          break;

        { max allowable date range is 366 days .. so lets get chunks of 6 months each .. }
        DateFrom := IncMonth(DateFrom,6);
        DateTo := IncMonth(DateFrom,6);
        if DateTo > Trunc(Now) then
          DateTo := Trunc(Now);
        if DateFrom >= DateTo then
          break;
        Dlg.StepIt;
      end;

    finally
      Dlg.Free;
    end;

    if (NewCount > 0) or (UpdateCount > 0) then begin
      result := true;
      CommonLib.MessageDlgXP_Vista('Downloadted ' + IntToStr(NewCount) + ' new records and updated ' + IntToStr(UpdateCount) + ' records.',mtInformation,[mbOk],0);
    end
    else begin
      CommonLib.MessageDlgXP_Vista('Your VAT Obligation data is up to date.',mtInformation,[mbOk],0);
    end;

  finally
    API.EnableOnError := true;;
    qry.Free;
    res.Free;
  end;
end;

end.
