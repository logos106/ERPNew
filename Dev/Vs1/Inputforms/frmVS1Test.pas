unit frmVS1Test;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, DNMPanel, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid, wwclearbuttongroup,
  wwradiogroup;

type
  TfmVS1Test = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlButtons: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    Label1: TLabel;
    edtIP: TEdit;
    DNMPanel4: TDNMPanel;
    Label2: TLabel;
    edtUserNameToSearch: TEdit;
    btnRequery: TDNMSpeedButton;
    QryVS1Users: TERPQuery;
    DNMPanel5: TDNMPanel;
    Label3: TLabel;
    cboVs1CloudServerDB: TwwDBComboBox;
    dsVS1Users: TDataSource;
    DNMPanel8: TDNMPanel;
    Label4: TLabel;
    edtVS1Database: TwwDBEdit;
    Label5: TLabel;
    edtVS1DBServer: TwwDBEdit;
    QryVS1UsersClientID: TIntegerField;
    QryVS1UsersDatabaseName: TWideStringField;
    QryVS1UsersServerName: TWideStringField;
    QryVS1UsersRegionname: TWideStringField;
    QryVS1UsersStatus: TWideStringField;
    QryVS1UsersCreatedOn: TDateField;
    QryVS1UsersUsedOn: TDateField;
    QryVS1UsersDiscontinuedOn: TDateField;
    QryVS1UsersAdminDB: TWideStringField;
    QryVS1UsersAdminUser: TWideStringField;
    QryVS1UsersAdminPass: TWideStringField;
    QryVS1UsersAPIPort: TIntegerField;
    QryVS1UsersClientName: TWideStringField;
    QryVS1UsersCUDataabse: TWideStringField;
    QryVS1UsersCServer: TWideStringField;
    wwDBEdit10: TwwDBEdit;
    wwDBEdit11: TwwDBEdit;
    DNMPanel6: TDNMPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    wwDBEdit9: TwwDBEdit;
    DNMPanel7: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    dsClientDBEmployeenAccess: TDataSource;
    qryClientDBEmployeenAccess: TERPQuery;
    QryVS1UsersEmailId: TWideStringField;
    QryVS1UsersPassword: TWideStringField;
    Label16: TLabel;
    Label15: TLabel;
    wwDBEdit12: TwwDBEdit;
    wwDBEdit13: TwwDBEdit;
    ConnclientDB: TERPConnection;
    wwDBGrid1: TwwDBGrid;
    qryClientDBEmployeenAccessLogon_Name: TWideStringField;
    qryClientDBEmployeenAccessFirstName: TWideStringField;
    qryClientDBEmployeenAccessLastName: TWideStringField;
    qryClientDBEmployeenAccessEmployeeName: TWideStringField;
    qryClientDBEmployeenAccessactive: TWideStringField;
    qryClientDBEmployeenAccessFormName: TWideStringField;
    qryClientDBEmployeenAccessDescription: TWideStringField;
    qryClientDBEmployeenAccessAccessDesc: TWideStringField;
    DNMPanel9: TDNMPanel;
    grpFilters: TwwRadioGroup;
    lblMsg: TLabel;
    qryClientDBEmployeenAccessAccess: TLargeintField;
    lblrecno: TLabel;
    procedure btnRequeryClick(Sender: TObject);
    procedure MyConnectionAfterConnect(Sender: TObject);
    procedure QryVS1UsersBeforeOpen(DataSet: TDataSet);
    procedure edtIPExit(Sender: TObject);
    procedure edtUserNameToSearchExit(Sender: TObject);
    procedure QryVS1UsersAfterOpen(DataSet: TDataSet);
    procedure qryClientDBEmployeenAccessBeforeOpen(DataSet: TDataSet);
    procedure ConnclientDBAfterConnect(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryClientDBEmployeenAccessAfterOpen(DataSet: TDataSet);
  private
    function Vs1CloudServer:String ;
    function Vs1CloudServerDB:String ;
    function VS1Database:String ;
    function UserNameToSearch:String ;
    procedure DoRefresh;
    function clientDBconnection : TERPConnection;
    procedure showrecordcount;
  Protected
      procedure ReadnApplyGuiPrefExtra; Override;
      Procedure WriteGuiPrefExtra; Override;
  public
  end;

implementation

uses CommonLib, AppDatabase, AppEnvironment, MySQLUtils, StoredProcedures,
  LogLib, utVS1Const;

{$R *.dfm}
{ TfmVS1Test }

function TfmVS1Test.Vs1CloudServer: String;
begin
  REsult := trim(edtIP.Text);
end;
function TfmVS1Test.Vs1CloudServerDB: String;
begin
  REsult := trim(cboVs1CloudServerDB.Text);
end;
function TfmVS1Test.VS1Database: String;
begin
  REsult := trim(edtVS1Database.Text);
end;
function TfmVS1Test.clientDBconnection: TERPConnection;
begin
try
  if sametext(ConnclientDB.Database, QryVS1UsersDatabaseName.asString) and
     sametext(ConnclientDB.Server , QryVS1UsersServerName.asString) and
     (ConnclientDB.Connected) then
  else begin
    Logtext('database :' + QryVS1UsersDatabaseName.asString);
    Logtext('server :' + QryVS1UsersServerName.asString);
    ConnclientDB.Database:= QryVS1UsersDatabaseName.asString;
    ConnclientDB.Server := QryVS1UsersServerName.asString;
    ConnclientDB.Connect;
  end;
Except

end;
result:= ConnclientDB;
end;

procedure TfmVS1Test.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmVS1Test.ConnclientDBAfterConnect(Sender: TObject);
begin
  inherited;
  CreateSP('AccLevelNoToDescription', 0 , ConnclientDB);
end;

procedure TfmVS1Test.DoRefresh;
begin
  inherited;
  if (Vs1CloudServerDB='') or ( Vs1CloudServer='') then exit;
  try
    if (MyConnection.Connected ) and (MyConnection.Database =Vs1CloudServerDB) and (MyConnection.Server =Vs1CloudServer) then
    else begin
        MyConnection.Connected := False;
        MyConnection.Database := Vs1CloudServerDB;
        MyConnection.Server := Vs1CloudServer;
        MyConnection.Connected := True;
    end;
    with QryVS1Users do begin
      if active and (parambyname('UserNameToSearch').asString =  UserNameToSearch) then
      else begin
          if active then close;
          connection :=MyConnection;
          Active := true;
      end;
    end;
  Except

  end;
end;

procedure TfmVS1Test.MyConnectionAfterConnect(Sender: TObject);
begin
  inherited;
  cboVs1CloudServerDB.Items.commatext := MySQLUtils.DatabaseList(MyConnection.Server);
  if (cboVs1CloudServerDB.text<> '') and (cboVs1CloudServerDB.Items.IndexOf(cboVs1CloudServerDB.text)>=0) then cboVs1CloudServerDB.ItemIndex := cboVs1CloudServerDB.Items.IndexOf(cboVs1CloudServerDB.text)
  else if (cboVs1CloudServerDB.Items.IndexOf(VS1_Admin_DB_Sandbox)>=0) then cboVs1CloudServerDB.ItemIndex := cboVs1CloudServerDB.Items.IndexOf(VS1_Admin_DB_Sandbox)
  else if (cboVs1CloudServerDB.Items.IndexOf(VS1_Admin_DB_Production)>=0) then cboVs1CloudServerDB.ItemIndex := cboVs1CloudServerDB.Items.IndexOf(VS1_Admin_DB_Production);;
  closedb(QryVS1Users);
end;

procedure TfmVS1Test.qryClientDBEmployeenAccessAfterOpen(DataSet: TDataSet);
begin
  inherited;
  showrecordcount;
end;
procedure TfmVS1Test.showrecordcount;
begin
  lblrecno.caption :=inttostr(qryClientDBEmployeenAccess.recordcount);
end;

procedure TfmVS1Test.qryClientDBEmployeenAccessBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryClientDBEmployeenAccess.connection := clientDBconnection   ;
  qryClientDBEmployeenAccess.parambyname('UserNameToSearch').asString :=  UserNameToSearch;
  logtext(qryClientDBEmployeenAccess.SQLtext);
end;

procedure TfmVS1Test.QryVS1UsersAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if UserNameToSearch ='' then exit;
    //qryClientDBEmployeenAccess.connection := ConnclientDB;
  closedb(qryClientDBEmployeenAccess);
  Opendb(qryClientDBEmployeenAccess);
  if (QryVS1UsersServerName.asString <> QryVS1UsersCServer.asString) then begin
    highlightcontrol(edtVS1DBServer);
    Timermsg(lblmsg, 'Servername Doesn''t Match');
  end;
end;

procedure TfmVS1Test.QryVS1UsersBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryVS1Users.parambyname('UserNameToSearch').asString :=  UserNameToSearch;
  logtext(QryVS1Users.SQLtext);
end;

function TfmVS1Test.UserNameToSearch: String;
begin
  REsult := trim(edtUserNameToSearch.Text);
end;

procedure TfmVS1Test.edtUserNameToSearchExit(Sender: TObject);begin  inherited;  DoRefresh;end;
procedure TfmVS1Test.btnRequeryClick        (Sender: TObject);
begin
  inherited;
  closedb(qryClientDBEmployeenAccess);
  closedb(QryVS1Users);
  MyConnection.Connected := False;
  DoRefresh;
end;
procedure TfmVS1Test.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmVS1Test.FormShow(Sender: TObject);
begin
  inherited;
  DoRefresh;
end;

procedure TfmVS1Test.grpFiltersClick(Sender: TObject);
begin
  inherited;
  if grpFilters.ItemIndex = 0 then   qryClientDBEmployeenAccess.filter := 'Access =1 '
  else if grpFilters.ItemIndex = 1 then   qryClientDBEmployeenAccess.filter := 'Access =6 '
  else if grpFilters.ItemIndex = 2 then   qryClientDBEmployeenAccess.filter := 'Access =0 '
  else qryClientDBEmployeenAccess.filter :='';
  qryClientDBEmployeenAccess.filtered := qryClientDBEmployeenAccess.filter<>'';
  showrecordcount;
end;

procedure TfmVS1Test.edtIPExit              (Sender: TObject);begin  inherited;  DoRefresh; end;
procedure TfmVS1Test.ReadnApplyGuiPrefExtra;
begin
  if GuiPrefs.Node.Exists('Options.ServerName') then
      edtIP.Text :=  GuiPrefs.Node['Options.ServerName'].asString;
  if GuiPrefs.Node.Exists('Options.UserNameToSearch') then
      edtUserNameToSearch.Text :=  GuiPrefs.Node['Options.UserNameToSearch'].asString;
  if GuiPrefs.Node.Exists('Options.FilterOption') then
      grpFilters.ItemIndex :=  GuiPrefs.Node['Options.FilterOption'].asInteger;
end;
Procedure TfmVS1Test.WriteGuiPrefExtra;
begin
      GuiPrefs.Node['Options.ServerName'].asString:= edtIP.Text;
      GuiPrefs.Node['Options.UserNameToSearch'].asString:= edtUserNameToSearch.Text;
      GuiPrefs.Node['Options.FilterOption'].asInteger := grpFilters.ItemIndex;
end;

initialization
  RegisterClassOnce(TfmVS1Test);

end.
