unit frmIntegrationSiteConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  JsonObject, DNMSpeedButton, Shader, DNMPanel, Mask, ComCtrls, StdCtrls,
  HTMLDialog;

type
  TfmIntegrationSiteConfig = class(TBaseInputGUI)
    Label1: TLabel;
    edtName: TEdit;
    chkTwoWaySynch: TCheckBox;
    chkActive: TCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    edtSourceURL: TEdit;
    Label4: TLabel;
    edtSourceDatabase: TEdit;
    Label5: TLabel;
    edtSourceUser: TEdit;
    Label6: TLabel;
    edtSourcePassword: TEdit;
    Label3: TLabel;
    edtDestURL: TEdit;
    Label7: TLabel;
    edtDestDatabase: TEdit;
    Label8: TLabel;
    edtDestUser: TEdit;
    Label9: TLabel;
    edtDestPassword: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    dtNextDate: TDateTimePicker;
    dtNextTime: TDateTimePicker;
    edtInterval: TMaskEdit;
    chkSat: TCheckBox;
    chkSun: TCheckBox;
    chkMon: TCheckBox;
    chkTues: TCheckBox;
    chkWeds: TCheckBox;
    chkThurs: TCheckBox;
    chkFri: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label17: TLabel;
    Bevel3: TBevel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    btnTest: TDNMSpeedButton;
    chkAll: TCheckBox;
    Label25: TLabel;
    chkPOS: TCheckBox;
    Label26: TLabel;
    chkProduct: TCheckBox;
    Label27: TLabel;
    cboCopyFrom: TComboBox;
    Label28: TLabel;
    btnSetup: TDNMSpeedButton;
    HTMLDialog: THTMLDialog;
    procedure btnSaveClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure chkAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboCopyFromCloseUp(Sender: TObject);
    procedure btnSetupClick(Sender: TObject);
    procedure chkPOSClick(Sender: TObject);
    procedure chkProductClick(Sender: TObject);
  private
    function NameUsed: boolean;
    function ValidateData: boolean;
    function TestConnection: boolean;
  public
    Site, Config: TJsonObject;
  end;

  function DoSiteConfig(site, config: TJsonObject): boolean;

implementation

{$R *.dfm}

uses
  CommonLib, WebApiClientObj, ProgressDialog, ShellAPI;

function DoSiteConfig(site, config: TJsonObject): boolean;
var
  form: TfmIntegrationSiteConfig;
begin
  result:= false;
  form:= TfmIntegrationSiteConfig.Create(nil);
  try
    form.Site:= site;
    form.Config:= config;
    form.edtName.Text:= site.S['Name'];
    form.chkTwoWaySynch.Checked:= site.B['TwoWaySynch'];
    form.edtSourceURL.Text:= site.S['SourceURL'];
    form.edtSourceDatabase.Text:= site.S['SourceDatabase'];
    form.edtSourceUser.Text:= site.S['SourceUserName'];
    form.edtSourcePassword.Text:= site.S['SourcePassword'];
    form.edtDestURL.Text:= site.S['DestinationURL'];
    form.edtDestDatabase.Text:= site.S['DestinationDatabase'];
    form.edtDestUser.Text:= site.S['DestinationUserName'];
    try
      form.dtNextDate.Date:= site.DT['NextSyncTime'];
      form.dtNextTime.Time:= site.DT['NextSyncTime'];
    except
      form.dtNextDate.Date := now;
      form.dtNextTime.Time := now;
    end;
    form.edtInterval.Text:= FormatFloat('00',site.O['Interval'].I['Hours']) + ':' + FormatFloat('00',site.O['Interval'].I['Mins']);
    form.chkMon.Checked:= site.O['Interval'].O['DayOfTheWeek'].B['1'];
    form.chkTues.Checked:= site.O['Interval'].O['DayOfTheWeek'].B['2'];
    form.chkWeds.Checked:= site.O['Interval'].O['DayOfTheWeek'].B['3'];
    form.chkThurs.Checked:= site.O['Interval'].O['DayOfTheWeek'].B['4'];
    form.chkFri.Checked:= site.O['Interval'].O['DayOfTheWeek'].B['5'];
    form.chkSat.Checked:= site.O['Interval'].O['DayOfTheWeek'].B['6'];
    form.chkSun.Checked:= site.O['Interval'].O['DayOfTheWeek'].B['7'];
    form.edtDestPassword.Text:= site.S['DestinationPassword'];
    form.chkAll.Checked := site.B['SynchAll'];
    form.chkPOS.Checked := site.B['SynchPOS'];
    form.chkProduct.Checked := site.B['SynchProduct'];
    if not form.chkAll.Checked then
      form.chkAll.Checked := (not site.B['SynchPOS']) and (not site.B['SynchProduct']);



    if form.edtName.Text = '' then
      form.chkActive.Checked:= true
    else
      form.chkActive.Checked:= site.B['Active'];
    if form.ShowModal = mrOK then begin
      result:= true;
      site.S['Name']:= form.edtName.Text;
      site.B['TwoWaySynch']:= form.chkTwoWaySynch.Checked;
      site.S['SourceURL']:= form.edtSourceURL.Text;
      site.S['SourceDatabase']:= form.edtSourceDatabase.Text;
      site.S['SourceUserName']:= form.edtSourceUser.Text;
      site.S['SourcePassword']:= form.edtSourcePassword.Text;
      site.S['DestinationURL']:= form.edtDestURL.Text;
      site.S['DestinationDatabase']:= form.edtDestDatabase.Text;
      site.S['DestinationUserName']:= form.edtDestUser.Text;
      site.S['DestinationPassword']:= form.edtDestPassword.Text;
      site.DT['NextSyncTime']:= Trunc(form.dtNextDate.Date) + Frac(form.dtNextTime.Time);
      site.O['Interval'].I['Hours']:= StrToIntDef(Copy(form.edtInterval.Text,1,2),0);
      site.O['Interval'].I['Mins']:= StrToIntDef(Copy(form.edtInterval.Text,4,2),15);
      site.O['Interval'].O['DayOfTheWeek'].B['1']:= form.chkMon.Checked;
      site.O['Interval'].O['DayOfTheWeek'].B['2']:= form.chkTues.Checked;
      site.O['Interval'].O['DayOfTheWeek'].B['3']:= form.chkWeds.Checked;
      site.O['Interval'].O['DayOfTheWeek'].B['4']:= form.chkThurs.Checked;
      site.O['Interval'].O['DayOfTheWeek'].B['5']:= form.chkFri.Checked;
      site.O['Interval'].O['DayOfTheWeek'].B['6']:= form.chkSat.Checked;
      site.O['Interval'].O['DayOfTheWeek'].B['7']:= form.chkSun.Checked;
      site.B['Active']:= form.chkActive.Checked;
      site.B['SynchAll'] := form.chkAll.Checked;
      site.B['SynchPOS'] := form.chkPOS.Checked;
      site.B['SynchProduct'] := form.chkProduct.Checked;
    end;
  finally
    form.Free;
  end;
end;

procedure TfmIntegrationSiteConfig.btnSaveClick(Sender: TObject);
begin
  inherited;
  if ValidateData then
    ModalResult:= mrOK;
end;

procedure TfmIntegrationSiteConfig.btnSetupClick(Sender: TObject);
begin
  inherited;
  // HTMLDialog.ShowModal;
  (*CommonLib.MessageDlgXP_Vista(
    '1)  Turn off "Two Way Synch".' + #13#10 + #13#10 +
    '2)  From head office select POS and set time to 5 minutes.' + #13#10 + #13#10 +
    '3)  From the site select Product and set time to 8 hours.',
    mtInformation,[mbOk],0);*)
  ShellExecute(0, nil, 'http://www.trueerp.com/wiki/EDI_Integration', '','', SW_SHOWDEFAULT);
end;

procedure TfmIntegrationSiteConfig.btnTestClick(Sender: TObject);
begin
  inherited;
  TestConnection;
end;

procedure TfmIntegrationSiteConfig.cboCopyFromCloseUp(Sender: TObject);
var
  sel: TJsonObject;
  x: integer;
begin
  inherited;
  if cboCopyFrom.Text = '' then
    exit;
  if (edtSourceURL.Text <> '') or (edtDestURL.Text <> '') then begin
    if MessageDlgXP_Vista('Are you sure you want to replace your settings?',mtConfirmation,[mbNo,mbYes],0) = mrNo then begin
      cboCopyFrom.ItemIndex := 0;
      exit;
    end;
  end;
  sel := nil;
  for x := 0 to Config.A['Sites'].Count -1 do begin
    if Config.A['Sites'].Items[x].AsObject.S['Name'] = cboCopyFrom.Text then begin
      sel := Config.A['Sites'].Items[x].AsObject;
      break;
    end;
  end;
  if Assigned(sel) then begin
    chkTwoWaySynch.Checked:= sel.B['TwoWaySynch'];
    edtSourceURL.Text:= sel.S['SourceURL'];
    edtSourceDatabase.Text:= sel.S['SourceDatabase'];
    edtSourceUser.Text:= sel.S['SourceUserName'];
    edtSourcePassword.Text:= sel.S['SourcePassword'];
    edtDestURL.Text:= sel.S['DestinationURL'];
    edtDestDatabase.Text:= sel.S['DestinationDatabase'];
    edtDestUser.Text:= sel.S['DestinationUserName'];
    try
      dtNextDate.Date:= sel.DT['NextSyncTime'];
      dtNextTime.Time:= sel.DT['NextSyncTime'];
    except
      dtNextDate.Date := now;
      dtNextTime.Time := now;
    end;
    edtInterval.Text:= FormatFloat('00',sel.O['Interval'].I['Hours']) + ':' + FormatFloat('00',sel.O['Interval'].I['Mins']);
    chkMon.Checked:= sel.O['Interval'].O['DayOfTheWeek'].B['1'];
    chkTues.Checked:= sel.O['Interval'].O['DayOfTheWeek'].B['2'];
    chkWeds.Checked:= sel.O['Interval'].O['DayOfTheWeek'].B['3'];
    chkThurs.Checked:= sel.O['Interval'].O['DayOfTheWeek'].B['4'];
    chkFri.Checked:= sel.O['Interval'].O['DayOfTheWeek'].B['5'];
    chkSat.Checked:= sel.O['Interval'].O['DayOfTheWeek'].B['6'];
    chkSun.Checked:= sel.O['Interval'].O['DayOfTheWeek'].B['7'];
    edtDestPassword.Text:= sel.S['DestinationPassword'];
    chkAll.Checked := sel.B['SynchAll'];
    chkPOS.Checked := sel.B['SynchPOS'];
    chkProduct.Checked := sel.B['SynchProduct'];
    if not chkAll.Checked then
      chkAll.Checked := (not sel.B['SynchPOS']) and (not sel.B['SynchProduct']);



    if edtName.Text = '' then
      chkActive.Checked:= true
    else
      chkActive.Checked:= sel.B['Active'];
  end;
end;

procedure TfmIntegrationSiteConfig.chkAllClick(Sender: TObject);
begin
  inherited;
  if chkAll.Checked then begin
    chkPOS.Checked := false;
    chkProduct.Checked := false;
  end;
end;

procedure TfmIntegrationSiteConfig.chkPOSClick(Sender: TObject);
begin
  inherited;
  if chkPOS.Checked then begin
    chkAll.Checked := false;
  end;
end;

procedure TfmIntegrationSiteConfig.chkProductClick(Sender: TObject);
begin
  inherited;
  if chkProduct.Checked then begin
    chkAll.Checked := false;
  end;
end;

procedure TfmIntegrationSiteConfig.FormShow(Sender: TObject);
var
  x: integer;
begin
  inherited;
  cboCopyFrom.Items.Clear;
  cboCopyFrom.Items.Add('');
  for x := 0 to Config.A['Sites'].Count -1 do begin
    if Config.A['Sites'].Items[x].AsObject.S['Name'] <> edtName.Text then
      cboCopyFrom.Items.Add(Config.A['Sites'].Items[x].AsObject.S['Name']);
  end;
end;

function TfmIntegrationSiteConfig.NameUsed: boolean;
var
  x: integer;
  s: TJsonObject;
begin
  result:= false;
  for x := 0 to Config.A['Sites'].Count -1 do begin
    s:= Config.A['Sites'].Items[x].AsObject;
    if (s <> Site) and SameText(s.S['Name'],edtNAme.Text) then begin
      result:= true;
      break;
    end;
  end;
end;

function TfmIntegrationSiteConfig.TestConnection: boolean;
var
  ApiSrc: TWebApiClient;
  ApiDst: TWebApiClient;
  SrcSysInfo: TJsonObject;
  DstSysInfo: TJsonObject;
  Prog: TProgressDialog;

  procedure ShowError(msg, SiteName: string);
  begin
    if Pos('invalid user name',Lowercase(msg)) > 0 then begin
      if MessageDlgXP_Vista('Error connectiong to ' + SiteName + ' ' + msg + #13#10 + #13#10 +
        'Make sure the database contains an employee with a Logon Name that matches the one specified here.',
        mtInformation,[],0,nil,'','',false,nil,'Ok,Help') = 101 then
          ShellExecute(0, nil, 'http://www.trueerp.com/wiki/EDI_Integration', '','', SW_SHOWDEFAULT);
    end
    else if Pos('invalid user password',Lowercase(msg)) > 0 then begin
      if MessageDlgXP_Vista('Error connectiong to ' + SiteName + ' ' + msg + #13#10 + #13#10 +
        'Make sure the database contains an employee with a Logon Password that matches the one specified here.',
        mtInformation,[],0,nil,'','',false,nil,'Ok,Help') = 101 then
          ShellExecute(0, nil, 'http://www.trueerp.com/wiki/EDI_Integration', '','', SW_SHOWDEFAULT);
    end
    else if Pos('host not found',Lowercase(msg)) > 0 then begin
      if MessageDlgXP_Vista('Error connectiong to ' + SiteName + ' ' + msg + #13#10 + #13#10 +
        'Please chect the following:' + #13#10 +
        'The URL is correct for the server you wish to connect to.' + #13#10 +
        'The specified port matches the server Web API port.' + #13#10 +
        'Routers are configured to allow access to the specified port.',
        mtInformation,[],0,nil,'','',false,nil,'Ok,Help') = 101 then
          ShellExecute(0, nil, 'http://www.trueerp.com/wiki/EDI_Integration', '','', SW_SHOWDEFAULT);
    end
    else if Pos('connection refused',Lowercase(msg)) > 0 then begin
      if MessageDlgXP_Vista('Error connectiong to ' + SiteName + ' ' + msg + #13#10 + #13#10 +
        'Please chect the following:' + #13#10 +
        'The specified port matches the server Web API port.' + #13#10 +
        'Routers are configured to allow access to the specified port.',
        mtInformation,[],0,nil,'','',false,nil,'Ok,Help') = 101 then
          ShellExecute(0, nil, 'http://www.trueerp.com/wiki/EDI_Integration', '','', SW_SHOWDEFAULT);
    end
    else begin
      if MessageDlgXP_Vista('Error connectiong to ' + SiteName + ' ' + msg + #13#10 + #13#10 +
        'Make sure the database name specified here matches the database on the server.',
        mtInformation,[],0,nil,'','',false,nil,'Ok,Help') = 101 then
          ShellExecute(0, nil, 'http://www.trueerp.com/wiki/EDI_Integration', '','', SW_SHOWDEFAULT);
    end;
  end;

begin
  result:= false;
  if not ValidateData then
    exit;

  Prog:= TProgressDialog.Create(nil);
  ApiSrc:= TWebApiClient.Create;
  ApiDst:= TWebApiClient.Create;
  SrcSysInfo:= JO;
  DstSysInfo:= JO;
//  DisableForm;
  try
    Prog.MaxValue:= 3;
    Prog.Step:= 1;
    Prog.Message:= 'Checking source: "' + edtSourceURL.Text + '"';
    Prog.Execute;
    Prog.StepIt;
    ApiSrc.UserName:= edtSourceUser.Text;
    ApiSrc.Password:= edtSourcePassword.Text;
    ApiSrc.Database:= edtSourceDatabase.Text;
    ApiSrc.URL:= edtSourceURL.Text;
    { test connectivity }
    if not ApiSrc.Get('TErpSysInfo',SrcSysInfo) then begin
      result:= false;
      FreeAndNil(Prog);
      ShowError(ApiSrc.ErrorMessage,'source "' + edtSourceURL.Text + '"');
//      MessageDlgXP_Vista('Error connectiong to source site ' + ApiSrc.ErrorMessage, mtInformation,[mbOk],0);
      exit;
    end;

//    Log(fSrcSysInfo.O['Fields'].S['DatabaseName'] + ' SiteCode ' + fSrcSysInfo.O['Fields'].S['SiteCode']  + ' Version ' + fSrcSysInfo.O['Fields'].S['Version'] + ' ' + utcSTR,ltDetail);

    Prog.Message:= 'Checking destination: "' + edtDestURL.Text + '"';
    Prog.StepIt;
    ApiDst.UserName:= edtDestUser.Text;
    ApiDst.Password:= edtDestPassword.Text;
    ApiDst.Database:= edtDestDatabase.Text;
    ApiDst.URL:= edtDestURL.Text;
    { test connectivity }
    if not ApiDst.Get('TErpSysInfo',DstSysInfo) then begin
      result:= false;
      FreeAndNil(Prog);
      ShowError(ApiSrc.ErrorMessage,'destination "' + edtDestURL.Text + '"');
//      MessageDlgXP_Vista('Error connectiong to destination site ' + ApiDst.ErrorMessage, mtInformation,[mbOk],0);
      exit;
    end;

    Prog.Message:= 'Checking site data';
    Prog.StepIt;
//    Log(fDstSysInfo.O['Fields'].S['DatabaseName'] + ' SiteCode ' + fDstSysInfo.O['Fields'].S['SiteCode'] + ' Version ' + fDstSysInfo.O['Fields'].S['Version'] + ' ' + utcSTR,ltDetail);

    if SameText(SrcSysInfo.O['Fields'].S['SiteCode'],DstSysInfo.O['Fields'].S['SiteCode']) then begin
      result:= false;
      FreeAndNil(Prog);
      MessageDlgXP_Vista('Both sites have the same Site Code (' + SrcSysInfo.O['Fields'].S['SiteCode'] + ').', mtInformation,[mbOk],0);
      exit;
    end;
    if not SameText(SrcSysInfo.O['Fields'].S['Version'],DstSysInfo.O['Fields'].S['Version']) then begin
      result:= false;
      FreeAndNil(Prog);
      MessageDlgXP_Vista('Sites have different versions:' + #1310 +
        'Source - ' + SrcSysInfo.O['Fields'].S['Version'] + #1310 +
        'Destination - ' + DstSysInfo.O['Fields'].S['Version'], mtInformation,[mbOk],0);
      exit;
    end;

  finally
    Prog.Free;
    ApiSrc.Free;
    ApiDst.Free;
    SrcSysInfo.Free;
    DstSysInfo.Free;
//    EnableForm;
  end;

  MessageDlgXP_Vista('Connectivity OK', mtInformation,[mbOk],0);
  result:= true;
end;

function TfmIntegrationSiteConfig.ValidateData: boolean;
begin
  result:= false;
  if edtNAme.Text = '' then begin
    MessageDlgXP_Vista('Name is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if NameUsed then begin
    MessageDlgXP_Vista('Name has already been used for a different site configuration',mtInformation,[mbOk],0);
    exit;
  end;
  if edtSourceURL.Text = '' then begin
    MessageDlgXP_Vista('Source URL is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtSourceDatabase.Text = '' then begin
    MessageDlgXP_Vista('Source Database is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtSourceUser.Text = '' then begin
    MessageDlgXP_Vista('Source User Name is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtSourcePassword.Text = '' then begin
    MessageDlgXP_Vista('Source Password is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtDestURL.Text = '' then begin
    MessageDlgXP_Vista('Destination URL is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtDestDatabase.Text = '' then begin
    MessageDlgXP_Vista('Destination Database is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtDestUser.Text = '' then begin
    MessageDlgXP_Vista('Destination User Name is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtDestPassword.Text = '' then begin
    MessageDlgXP_Vista('Destination Password is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtInterval.Text = '00:00' then begin
    MessageDlgXP_Vista('Interval can not be zero',mtInformation,[mbOk],0);
    exit;
  end;
  result:= true;
end;

end.
