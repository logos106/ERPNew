unit frmVS1ClientDBServers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, ActnList,BusObjVS1_Cloud, Buttons, Wwdbigrd,
  Grids, Wwdbgrid;

type
  TfmVS1ClientDBServers = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Actionlist: TActionList;
    QryVS1_ClientDbServers: TERPQuery;
    QryVS1_ClientDbServersID: TIntegerField;
    QryVS1_ClientDbServersRegionId: TIntegerField;
    QryVS1_ClientDbServersServerName: TWideStringField;
    QryVS1_ClientDbServersAdminDB: TWideStringField;
    QryVS1_ClientDbServersAdminUser: TWideStringField;
    QryVS1_ClientDbServersAdminPass: TWideStringField;
    QryVS1_ClientDbServersAPIPort: TIntegerField;
    QryVS1_ClientDbServersIsHttps: TWideStringField;
    qryRegionalOptions: TERPQuery;
    qryRegionalOptionsRegionID: TIntegerField;
    qryRegionalOptionsRegion: TWideStringField;
    QryVS1_ClientDbServersRegion: TWideStringField;
    dsVS1_ClientDbServers: TDataSource;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure DNMPanel3Click(Sender: TObject);
    procedure grdTransactionsTitleButtonClick(Sender: TObject;
      AFieldName: string);
  private
    VS1_ClientDbServers: TVS1_ClientDbServers;
    copydata:String;
    ClientDbServersUpdatecallbackFieldname:String;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure Checkforemployees;
    procedure CheckforemployeesCAllback(const Sender: TBusObj;var Abort: boolean);
    procedure ClientDbServersUpdatecallback(const Sender: TBusObj;var Abort: boolean);
  Protected
    procedure CommitAndNotify;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment , DbSharedObjectsObj, CommonDbLib,
  utNewDBUtils, JSONObject;

{$R *.dfm}

procedure TfmVS1ClientDBServers.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmVS1ClientDBServers.SaveRecord :Boolean;
begin
  result:= False;
  VS1_ClientDbServers.PostDB;
  if not(VS1_ClientDbServers.Save) then exit;
  Result:= True;

end;

procedure TfmVS1ClientDBServers.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  VS1_ClientDbServers.Connection.CommitTransaction;
  Checkforemployees;
  Self.Close;
end;
procedure TfmVS1ClientDBServers.Checkforemployees;
begin
  VS1_ClientDbServers.IterateREcords(CheckforemployeesCAllback);
end;
Procedure TfmVS1ClientDBServers.CheckforemployeesCAllback(Const Sender: TBusObj; var Abort: boolean);
var
  conn:TERPConnection;
begin
  if not (sender is TVS1_ClientDbServers) then exit;
  conn := GetNewMyDacConnection(Self, TVS1_ClientDbServers(Sender).AdminDB , TVS1_ClientDbServers(Sender).servername);
  try
    TNewDbUtils.InitEmployee(Conn, '',nil);
(*    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(conn);
    try

    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;*)
  finally
    Freeandnil(conn);
  end;
end;
procedure TfmVS1ClientDBServers.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;

end;

procedure TfmVS1ClientDBServers.DNMPanel3Click(Sender: TObject);
begin
  inherited;
  copydata:='';
end;

procedure TfmVS1ClientDBServers.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TVS1_ClientDbServers then TVS1_ClientDbServers(Sender).Dataset  := QryVS1_ClientDbServers;
     end;
end;

procedure TfmVS1ClientDBServers.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmVS1ClientDBServers.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if VS1_ClientDbServers.Dirty then begin
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
          VS1_ClientDbServers.Dirty := false;
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

procedure TfmVS1ClientDBServers.FormCreate(Sender: TObject);
begin
  inherited;
   NewBusObjinstance;
   copydata:='';
   ClientDbServersUpdatecallbackFieldname := '';
end;
procedure TfmVS1ClientDBServers.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
end;

procedure TfmVS1ClientDBServers.grdTransactionsDblClick(Sender: TObject);
begin
  inherited;
  if copydata <> '' then begin
    EditDB(QryVS1_ClientDbServers);
    QryVS1_ClientDbServers.fieldbyname(grdTransactions.GetActiveField.fieldname).aSString :=copydata;
    PostDB(QryVS1_ClientDbServers);
  end else begin
    copydata := QryVS1_ClientDbServers.fieldbyname(grdTransactions.GetActiveField.fieldname).aSString;
  end;
end;

procedure TfmVS1ClientDBServers.grdTransactionsTitleButtonClick(Sender: TObject;  AFieldName: string);
begin
  inherited;
  if copydata = '' then exit;
  ClientDbServersUpdatecallbackFieldname:= AFieldname;
  try
    VS1_ClientDbServers.Iteraterecords(ClientDbServersUpdatecallback);
  finally
    ClientDbServersUpdatecallbackFieldname:= '';
  end;
end;
procedure TfmVS1ClientDBServers.ClientDbServersUpdatecallback(Const Sender: TBusObj; var Abort: boolean);
begin
    EditDB(QryVS1_ClientDbServers);
    QryVS1_ClientDbServers.fieldbyname(ClientDbServersUpdatecallbackFieldname).aSString :=copydata;
    PostDB(QryVS1_ClientDbServers);
end;

procedure TfmVS1ClientDBServers.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  VS1_ClientDbServers := TVS1_ClientDbServers.CreateWithNewConn(Self);
  VS1_ClientDbServers.Connection.connection := Self.MyConnection;
  VS1_ClientDbServers.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;


procedure TfmVS1ClientDBServers.Openrec;
begin
  VS1_ClientDbServers.Load;
  VS1_ClientDbServers.connection.BeginTransaction;
  openQueries;
  VS1_ClientDbServers.Dirty := false;
end;

initialization
  RegisterClassOnce(TfmVS1ClientDBServers);

end.

