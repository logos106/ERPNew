unit frmVs1Client;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, ActnList, Mask, wwdbdatetimepicker, Grids,
  Wwdbigrd, Wwdbgrid , BusObjVS1_Cloud, Buttons, wwdblook;

type
  TfmVs1Client = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Actionlist: TActionList;
    qryvs1_clients: TERPQuery;
    qryvs1_modules: TERPQuery;
    pnlclient: TDNMPanel;
    pnlclientModules: TDNMPanel;
    lblClientPrintNameHeading: TLabel;
    edtClientName: TDBEdit;
    dsvs1_clients: TDataSource;
    Label1: TLabel;
    edtRegistrationDate: TwwDBDateTimePicker;
    edtRegionName: TDBEdit;
    Label2: TLabel;
    edtDatabasename: TDBEdit;
    Label3: TLabel;
    dsvs1_clientmodules: TDataSource;
    qryvs1_modulesLicenseLevelID: TIntegerField;
    qryvs1_modulesLicenseOrder: TIntegerField;
    qryvs1_modulesDescription: TWideStringField;
    qryvs1_modulesModuleId: TIntegerField;
    qryvs1_modulesLicenseLevel: TIntegerField;
    qryvs1_modulesModuleName: TWideStringField;
    qryvs1_modulesIsExtra: TWideStringField;
    qryvs1_modulesRequiredLevel: TIntegerField;
    qryvs1_modulesActive: TWideStringField;
    qryvs1_clientmodules: TERPQuery;
    grdvs1_clientmodules: TwwDBGrid;
    FilterLabel: TLabel;
    Label4: TLabel;
    grdclientLicense: TwwDBGrid;
    grdclientLicenseIButton: TwwIButton;
    qryvs1_LicenseLevels: TERPQuery;
    qryvs1_LicenseLevelsID: TIntegerField;
    qryvs1_LicenseLevelsLicenseOrder: TIntegerField;
    qryvs1_LicenseLevelsActive: TWideStringField;
    cboLicenseLevel: TwwDBLookupCombo;
    qryvs1_clientsRegionName: TWideStringField;
    qryvs1_clientsDatabasename: TWideStringField;
    qryvs1_clientsClientName: TWideStringField;
    qryvs1_clientsLicenseLevel: TIntegerField;
    qryvs1_clientsServerName: TWideStringField;
    qryvs1_clientsLicenseRenewDurationType: TWideStringField;
    qryvs1_clientsLicenseRenewDuration: TIntegerField;
    qryvs1_clientsRegistrationDate: TDateField;
    grdDatabases: TwwDBGrid;
    qryDatabases: TERPQuery;
    qryDatabasesDatabaseName: TWideStringField;
    qryDatabasesServerName: TWideStringField;
    qryDatabasesAPIPort: TIntegerField;
    qryDatabasesIsHttps: TWideStringField;
    dsDAtabases: TDataSource;
    qryvs1_clientsid: TIntegerField;
    qryvs1_clientmodulesLicenseLevel: TWideStringField;
    qryvs1_clientmodulesModuleName: TWideStringField;
    qryvs1_clientmodulesActive: TWideStringField;
    qryvs1_clientmodulesModuleID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdvs1_clientmodulesDblClick(Sender: TObject);
    procedure qryvs1_clientmodulesBeforeOpen(DataSet: TDataSet);
    procedure pnlclientEnter(Sender: TObject);
    procedure grdvs1_clientmodulesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure cboLicenseLevelCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    VS1_ClientObj: TVS1_Clients;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveRecord: Boolean;
    Procedure OpenRec;
    procedure NewBusObjinstance;
  Protected
    procedure CommitAndNotify;override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, BusObjConst, AppEnvironment , frmVs1ClientModulerenew,
  FormFactory;

{$R *.dfm}

procedure TfmVs1Client.FormCreate(Sender: TObject);
begin
  inherited;
  NewBusObjinstance;
end;

procedure TfmVs1Client.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  VS1_ClientObj := TVS1_Clients.CreateWithNewConn(Self);
  VS1_ClientObj.Connection.Connection := Self.MyConnection;
  VS1_ClientObj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

procedure TfmVs1Client.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
  ShowcontrolHint(grdvs1_ClientModules, 'Double Click to Renew');
  SetControlfocus(grdvs1_ClientModules);
  grdvs1_clientmodules.SetActivefield('Active');

  // List the databases belong to the client.
  qryDatabases.SQL.Clear;
  qryDatabases.SQL.Add('SELECT * FROM tblVS1_Databases WHERE ClientID=' + IntToStr(KeyID));
  qryDatabases.Open;
  grdDatabases.Refresh;
end;

procedure TfmVs1Client.OpenRec;
begin
  VS1_ClientObj.Load(KeyID);
  VS1_ClientObj.Connection.BeginTransaction;
  qryvs1_clientmodules.ParamByName('cid').AsInteger := KeyID;
//  VS1_ClientObj.ClientModules;
  OpenQueries;
  VS1_ClientObj.Dirty := false;
end;

procedure TfmVs1Client.cboLicenseLevelCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  qryvs1_clientsLicenseLevel.AsInteger := qryvs1_LicenseLevelsID.AsInteger;
end;

procedure TfmVs1Client.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmVs1Client.SaveRecord: Boolean;
begin
  Result := False;
  VS1_ClientObj.PostDB;
  if not(VS1_ClientObj.Save) then exit;
  Result := True;

end;

procedure TfmVs1Client.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then Exit;
  VS1_ClientObj.Connection.CommitTransaction;
  VS1_ClientObj.Dirty := False;
  Self.Close;
end;

procedure TfmVs1Client.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;

procedure TfmVs1Client.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TVS1_Clients then TVS1_Clients(Sender).Dataset := qryvs1_clients
//    else if Sender is TVS1_ClientModules then TVS1_ClientModules(Sender).Dataset := qryvs1_clientmodules;
  end else if (Eventtype = BusObjEvent_ToDo) and (Value = BusObjEventCall_RenewLicense) then begin
    with TfmVs1ClientModuleRenew.Create(Self) do try
      VS1_ClientModule := VS1_ClientObj.ClientModules;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfmVs1Client.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmVs1Client.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if VS1_ClientObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          VS1_ClientObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmVs1Client.grdvs1_clientmodulesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if sametext(Field.fieldname,qryvs1_modulesActive.fieldname) then
  else Font.color := clGrayText;
end;

procedure TfmVs1Client.grdvs1_clientmodulesDblClick(Sender: TObject);
begin
  inherited;
  VS1_ClientObj.ClientModules.RenewModule;
end;

procedure TfmVs1Client.pnlclientEnter(Sender: TObject);
begin
  inherited;
  SetControlfocus(grdvs1_clientmodules);
  grdvs1_clientmodules.setActivefield('Active');
end;

procedure TfmVs1Client.qryvs1_clientmodulesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if qryvs1_modules.Active = False then begin
    qryvs1_modules.Connection := qryvs1_clientmodules.Connection;
    qryvs1_modules.Open;
  end;
end;

initialization

  RegisterClassOnce(TfmVs1Client);
  with FormFact do
  begin
    RegisterMe(TfmVs1Client, 'TVs1ClientListGUI_*=ID');
  end;

end.

