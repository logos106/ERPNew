unit frmCrossStockCompanies;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusobjCrossStockCompanies, Grids, Wwdbigrd,
  Wwdbgrid, wwdblook;

type
  TfmCrossStockCompanies = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    QryCrossStockCompanies: TERPQuery;
    QryERPDatabases: TERPQuery;
    dsCrossStockCompanies: TDataSource;
    pnlDatabases: TDNMPanel;
    pnlOptions: TDNMPanel;
    grdCrossStockCompanies: TwwDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    dsERPDatabases: TDataSource;
    grdDbs: TwwDBGrid;
    DNMPanel4: TDNMPanel;
    btnemoveAll: TDNMSpeedButton;
    btnRemove: TDNMSpeedButton;
    btnChooseAll: TDNMSpeedButton;
    btnChoose: TDNMSpeedButton;
    QryERPDatabasesDBName: TWideStringField;
    btnMoveItemUp: TDNMSpeedButton;
    btnMoveItemDown: TDNMSpeedButton;
    QryCrossStockCompaniesID: TIntegerField;
    QryCrossStockCompaniesGlobalRef: TWideStringField;
    QryCrossStockCompaniesDBName: TWideStringField;
    QryCrossStockCompaniesLogon_Name: TWideStringField;
    QryCrossStockCompaniesCheckOrder: TIntegerField;
    QryCrossStockCompaniesActive: TWideStringField;
    QryCrossStockCompaniesmsTimeStamp: TDateTimeField;
    QryCrossStockCompaniesmsupdateSitecode: TWideStringField;
    qryUsernames: TERPQuery;
    qryUsernamesdbname: TWideStringField;
    qryUsernamesLogon_Name: TWideStringField;
    cboLogon_Name: TwwDBLookupCombo;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnChooseClick(Sender: TObject);
    procedure btnChooseAllClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnemoveAllClick(Sender: TObject);
    procedure btnMoveItemUpClick(Sender: TObject);
    procedure btnMoveItemDownClick(Sender: TObject);
    procedure grdCrossStockCompaniesEnter(Sender: TObject);
    procedure grdDbsDblClick(Sender: TObject);
    procedure grdCrossStockCompaniesDblClick(Sender: TObject);
  private
    CrossStockCompanies: TCrossStockCompanies;
    Dirty :boolean;
    //fMyConnectionForDB: TERPConnection;
    AlllinesValid  :Boolean;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure RefreshERPDatabaseList;
    function AddCrossStockCompany: Boolean;
    function RemoveCrossStockCompany: Boolean;
    procedure REfreshForDb;
    //function ConnectionForDB: TERPConnection;
    procedure saveRecordCallback(const Sender: TBusObj; var Abort: boolean);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure CommitAndNotify;override;
  public
    { Public declarations }
  end;


implementation

uses
  CommonLib, BusObjConst, AppEnvironment, AppDatabase, CommonDbLib,
  ERPVersionConst;

{$R *.dfm}

procedure TfmCrossStockCompanies.btnChooseAllClick(Sender: TObject);
begin
  inherited;
  if QryERPDatabases.RecordCount =0 then exit;
  Dirty := False;

  QryERPDatabases.First;
  while QryERPDatabases.Eof = False do begin
    if AddCrossStockCompany then Dirty := True;
    QryERPDatabases.Next;
  end;
  if Dirty then RefreshERPDatabaseList;
end;

procedure TfmCrossStockCompanies.btnChooseClick(Sender: TObject);
begin
  inherited;
  if AddCrossStockCompany then RefreshERPDatabaseList;
end;

Function TfmCrossStockCompanies.AddCrossStockCompany:Boolean;
begin
  REsult := False;
  if QryERPDatabasesDBName.AsString <> '' then begin
    if CrossStockCompanies.Locate('DBNAme' , QryERPDatabasesDBName.AsString  , []) = false then begin
      CrossStockCompanies.New;
      CrossStockCompanies.DBNAme :=QryERPDatabasesDBName.AsString;
      CrossStockCompanies.PostDB;
      REsult := True;
    end;
  end;
end;

procedure TfmCrossStockCompanies.btnemoveAllClick(Sender: TObject);
begin
  inherited;
  if CrossStockCompanies.count =0 then exit;
  CrossStockCompanies.DeleteAll;
  RefreshERPDatabaseList;
end;

procedure TfmCrossStockCompanies.btnMoveItemDownClick(Sender: TObject);
var
  aid:Integer;
begin
  inherited;
  if CrossStockCompanies.dataset.recno = CrossStockCompanies.count then exit;
  if CrossStockCompanies.checkorder <= 0 then exit;

  aid :=CrossStockCompanies.ID;
  CrossStockCompanies.next;
  CrossStockCompanies.checkOrder:= CrossStockCompanies.checkOrder -1;
  CrossStockCompanies.PostDb;
  CrossStockCompanies.Locate(CrossStockCompanies.IDfieldname , aid, []);
  CrossStockCompanies.checkOrder:= CrossStockCompanies.checkOrder +1;
  CrossStockCompanies.PostDb;
  CrossStockCompanies.closedb;
  CrossStockCompanies.OpenDb;
  CrossStockCompanies.Locate(CrossStockCompanies.IDfieldname , aid, []);
end;

procedure TfmCrossStockCompanies.btnMoveItemUpClick(Sender: TObject);
var
  aid:Integer;
begin
  inherited;
  if CrossStockCompanies.dataset.recno = 1 then exit;
  if CrossStockCompanies.checkorder <= 1 then exit;
  aid :=CrossStockCompanies.ID;
  CrossStockCompanies.Prior;
  CrossStockCompanies.checkOrder:= CrossStockCompanies.checkOrder +1;
  CrossStockCompanies.PostDb;
  CrossStockCompanies.Locate(CrossStockCompanies.IDfieldname , aid, []);
  CrossStockCompanies.checkOrder:= CrossStockCompanies.checkOrder -1;
  CrossStockCompanies.PostDb;
  CrossStockCompanies.closedb;
  CrossStockCompanies.OpenDb;
  CrossStockCompanies.Locate(CrossStockCompanies.IDfieldname , aid, []);
end;

procedure TfmCrossStockCompanies.btnRemoveClick(Sender: TObject);
begin
  inherited;
  if RemoveCrossStockCompany then RefreshERPDatabaseList;
end;
Function TfmCrossStockCompanies.RemoveCrossStockCompany:Boolean;
begin
  Result := False;
  CrossStockCompanies.PostDB;
  if CrossStockCompanies.count =0 then exit;
  CrossStockCompanies.Delete;
  REsult := True;
end;


Procedure TfmCrossStockCompanies.RefreshERPDatabaseList;
begin
  closedb(QryERPDatabases);
  OpenDb(QryERPDatabases);
end;
procedure TfmCrossStockCompanies.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in Self.FormState then ModalResult := mrCancel else Close;
end;

Function TfmCrossStockCompanies.SaveRecord :Boolean;
begin
//  result:= False;
  CrossStockCompanies.PostDB;
  AlllinesValid := True;
  CrossStockCompanies.Iteraterecords(saveRecordCallback);
  //if not(CrossStockCompanies.Save) then exit;
  Result:= AlllinesValid;
end;
procedure TfmCrossStockCompanies.SaveRecordCallback(const Sender: TBusObj; var Abort: boolean);
begin
  if not (Sender is TCrossStockCompanies) then exit;
  if not(TCrossStockCompanies(Sender).Save) then begin
    AlllinesValid := False;
    Abort := True;
    Exit;
  end;
end;
procedure TfmCrossStockCompanies.grdCrossStockCompaniesDblClick(  Sender: TObject);
begin
  inherited;
   btnRemove.click;
end;

procedure TfmCrossStockCompanies.grdCrossStockCompaniesEnter(Sender: TObject);
begin
  inherited;
  if CrossStockCompanies.count =0 then Setcontrolfocus(grdDbs);
end;

procedure TfmCrossStockCompanies.grdDbsDblClick(Sender: TObject);
begin
  inherited;
  btnChoose.click;
end;

procedure TfmCrossStockCompanies.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  CrossStockCompanies.Connection.CommitTransaction;
  KeyId := CrossStockCompanies.ID; // just to return true when called
  if fsModal in Self.FormState then ModalResult := mrOk else Close;
end;

procedure TfmCrossStockCompanies.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;

procedure TfmCrossStockCompanies.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TCrossStockCompanies then TCrossStockCompanies(Sender).Dataset  := QryCrossStockCompanies;
     end else if Sender is TCrossStockCompanies then begin
      if ((Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value) )) or
         ((Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost )) or
         ((Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen )) then begin
         REfreshForDb;
      end;
     end;
end;
procedure TfmCrossStockCompanies.RefreshForDb;
begin
try
  closedb(qryUsernames);
  //qryUsernames.Connection :=ConnectionForDB;
  qryUsernames.SQL.Text := 'select ' + quotedstr(CrossStockCompanies.dbname) +' dbname, Logon_Name from  ' + CrossStockCompanies.dbname +'.tblpassword where ifnull(EmployeeId ,0)<> 0 order by Logon_Name';
  Opendb(qryUsernames);
Except
  //kill the exception
end;
end;
(*Function TfmCrossStockCompanies.ConnectionForDB :TERPConnection;
begin
  if CrossStockCompanies.dbname <> '' then
  if fMyConnectionForDB = nil then fMyConnectionForDB :=GetNewMyDacConnection(Self ,CrossStockCompanies.dbname)
  else if (not(fMyConnectionForDB.connected)) or (not(sametext(fMyConnectionForDB.database , CrossStockCompanies.dbname))) then begin
      fMyConnectionForDB.connected := False;
      fMyConnectionForDB.Database := CrossStockCompanies.DBNAme;
      fMyConnectionForDB.connected := True;
  end;
  Result := fMyConnectionForDB;
end;*)
procedure TfmCrossStockCompanies.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if CrossStockCompanies.Dirty then begin
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
          CrossStockCompanies.Dirty := false;
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

procedure TfmCrossStockCompanies.FormCreate(Sender: TObject);
var
  x: integer;
  DbRec: TDatabaseRec;
begin
  //fMyConnectionForDB := nil;
  QryERPDatabases.SQL.Clear;

 for x:= 0 to AppEnv.AppDb.DatabaseList.Count -1 do begin
    DbRec:= TDatabaseRec(AppEnv.AppDb.DatabaseList.Objects[x]);
    if (not(Sametext(DbRec.Name , 'erpnewdb'))) and  (not(Sametext(DbRec.Name , Appenv.AppDb.Database)))  then begin
      if sametext(DbRec.Version , TABLE_VERSION) then begin
        if QryERPDatabases.SQL.count >0 then QryERPDatabases.SQL.add ('UNION ');
        QryERPDatabases.SQL.add ('Select ' +quotedstr(DbRec.Name)+' as DBName ');
      end;
    end;
  end;
  if QryERPDatabases.SQL.count =0 then QryERPDatabases.SQL.add ('Select "" as DBName ');
  QryERPDatabases.SQL.TExt := 'Select * from (' + QryERPDatabases.SQL.Text +' ) as DBs where DBName not in (Select DBName from tblCrossStockCompanies)';
  QryERPDatabases.SQL.Add('Order by DBName');
  inherited;
  NewBusObjinstance;
end;
procedure TfmCrossStockCompanies.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
end;

procedure TfmCrossStockCompanies.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  CrossStockCompanies := TCrossStockCompanies.CreateWithNewConn(Self);
  CrossStockCompanies.Connection.connection := Self.MyConnection;
  CrossStockCompanies.BusObjEvent := DoBusinessObjectEvent;
  CrossStockCompanies.ResultStatus.ResultSuffix := ' in the Selected Companies panel';
  {$WARNINGS ON}

end;

procedure TfmCrossStockCompanies.Openrec;
begin
  CrossStockCompanies.Load(*(KeyID)*);// open all
  CrossStockCompanies.connection.BeginTransaction;
  openQueries;
  CrossStockCompanies.Dirty := false;
end;

initialization
  RegisterClassOnce(TfmCrossStockCompanies);

end.

