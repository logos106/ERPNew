unit frmSiteIntergrationTestSteps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseTestSteps, StdCtrls, Shader, DNMSpeedButton, ExtCtrls,
  DNMPanel, JsonObject, Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwcheckbox;

type
  TfmSiteIntergrationTestSteps = class(TfmBaseTestSteps)
    Label1: TLabel;
    cboSites: TwwDBComboBox;
    chkRemoteTested: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure cboSitesCloseUp(Sender: TwwDBComboBox; Select: Boolean);
  private
    fERPServer: string;
    SiteIntConfig: TJsonObject;
    procedure SetERPServer(const Value: string);
    { Private declarations }
  public
    property ERPServer: string read fERPServer write SetERPServer;
  end;

var
  fmSiteIntergrationTestSteps: TfmSiteIntergrationTestSteps;

implementation

{$R *.dfm}

uses
  SiteIntergrationTestObj, MySQLUtils, ERPDbComponents;

procedure TfmSiteIntergrationTestSteps.btnTestClick(Sender: TObject);
var
  context: TJsonObject;
begin
  context := JO;
  try
    context.S['ERPServer'] := ERPServer;
//    context.S['PublicIP'] := PublicIP;
    context.O['Config'].Assign(SiteIntConfig);
    context.S['SelectedSite']:= Trim(StringReplace(StringReplace(cboSites.Text,'(Active)','',[]),'(Inactive)','',[]));
    context.B['UserHasTestedRemoteWebAPI']:= chkRemoteTested.Checked;
    Tester.Reset;
    Application.ProcessMessages;
    Tester.Test(context);
  finally
    context.Free;
  end;
end;

procedure TfmSiteIntergrationTestSteps.cboSitesCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  chkRemoteTested.Checked := false;
  Tester.Reset;
end;

procedure TfmSiteIntergrationTestSteps.FormCreate(Sender: TObject);
begin
  inherited;
  SiteIntConfig := JO;
  Tester := TSiteIntergrationTestList.Create;
end;

procedure TfmSiteIntergrationTestSteps.FormDestroy(Sender: TObject);
begin
  inherited;
  Tester.Free;
  SiteIntConfig.Free;
end;

procedure TfmSiteIntergrationTestSteps.SetERPServer(const Value: string);
var
  conn: TERPConnection;
  qry: TERPQuery;
  x: integer;
  site: TJsonObject;
  s: string;
begin
  fERPServer := Value;
  SiteIntConfig.Clear;
  cboSites.Clear;
  if value <> '' then begin
    conn := TERPConnection.Create(nil);
    qry:= TERPQuery.Create(nil);
    try
      SetConnectionProps(conn,'services',fERPServer);
      conn.Connect;
      qry.Connection := conn;
      qry.SQL.Add('select * from tblConfig where ConfigName = "SiteIntegration"');
      qry.Open;
      SiteIntConfig.AsString:= qry.FieldByName('ConfigValue').asString;
    finally
      qry.Free;
      conn.Free;
    end;
    if SiteIntConfig.Count > 0 then begin
      s:= '';
      for x := 0 to SiteIntConfig.A['Sites'].Count -1 do begin
        site:= SiteIntConfig.A['Sites'].Items[x].AsObject;
        if site.B['Active'] then begin
          cboSites.Items.Add(site.S['Name'] + '  (Active)');
          if s <> '' then
            s := site.S['Name'] + '  (Active)';
        end
        else
          cboSites.Items.Add(site.S['Name'] + '  (Inactive)');
      end;
      if s <> '' then
        cboSites.ItemIndex := cboSites.Items.IndexOf(s)
      else
        cboSites.ItemIndex := 0;
    end;
  end;
end;

end.
