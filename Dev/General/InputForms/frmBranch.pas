unit frmBranch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Grids, Wwdbigrd, Wwdbgrid, DB, MemDS, DBAccess,
  MyAccess,ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  BusObjBase, ExtCtrls, BusobjBranch, DNMPanel, ProgressDialog, StdCtrls;

type
  TfmBranch = class(TBaseInputGUI)
    qryMs: TERPQuery;
    qryMsGlobalRef: TWideStringField;
    qryMsBackEndID: TIntegerField;
    qryMsSiteCode: TWideStringField;
    qryMsSiteDesc: TWideStringField;
    qryMsBEDefault: TWideStringField;
    qryMsEditedFlag: TWideStringField;
    qryMsEmailCount: TIntegerField;
    qryMsSentID: TIntegerField;
    qryMsSentStamp: TDateTimeField;
    qryMsReceivedID: TIntegerField;
    qryMsReceivedStamp: TDateTimeField;
    qryMsEmailAddressData: TWideStringField;
    qryMsEmailUsername: TWideStringField;
    qryMsEmailPassword: TWideStringField;
    qryMsConflictTodoUserId: TIntegerField;
    qryMsLastPC: TWideStringField;
    qryMsLastUserID: TIntegerField;
    qryMsmsTimeStamp: TDateTimeField;
    dsMs: TDataSource;
    pnlMS: TDNMPanel;
    grdmain: TwwDBGrid;
    qryMsServername: TWideStringField;
    qryMsDatabaseName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdmainRowChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private

    function getDirty: Boolean;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    BranchObj : TBranch;
    Property dirty :Boolean read getDirty;
    class Function Createform(AOwner: TBaseInputGUI): TfmBranch;
  end;


implementation

uses CommonLib, BusObjConst;

{$R *.dfm}

class function TfmBranch.Createform(AOwner: TBaseInputGUI): TfmBranch;
begin
  Result := TfmBranch(commonlib.getComponentbyClassname('TfmBranch' , True, AOwner , False , TRue , 99));
  if not Assigned(result) then exit;
  REsult.BranchObj.Connection.Connection :=AOwner.MyConnection;
end;

procedure TfmBranch.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TBranch then TBranch(Sender).Dataset  := qryMs;
    END;
end;

procedure TfmBranch.FormCreate(Sender: TObject);
begin
  inherited;
  BranchObj := TBranch.create(Self);
  BranchObj.connection := TMyDacdataconnection.create(BranchObj);
  BranchObj.connection.connection := MyConnection;
  BranchObj.BusObjEvent := DoBusinessObjectEvent;
end;
procedure TfmBranch.grdmainRowChanged(Sender: TObject);
begin
  inherited;
(*  if BranchObj.CleanSiteCode= '' then grdmain.Options := grdmain.Options  + [dgEditing]
  else grdmain.Options := grdmain.Options  - [dgEditing];*)
end;

procedure TfmBranch.FormShow(Sender: TObject);
begin
  inherited;
  BranchObj.Load;
end;

procedure TfmBranch.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  ExitResult: Word;
begin
  inherited;
  if not BranchObj.dirty then Exit;

  ExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes,  mbCancel], 0);
  case ExitResult of
    mrYes    : if not BranchObj.Save then canclose := False;
    mrCancel : CanClose := false;
  end;
end;

function TfmBranch.getDirty: Boolean;
begin
  REsult := BranchObj.Dirty;
end;

initialization
  RegisterClassOnce(TfmBranch);
end.
