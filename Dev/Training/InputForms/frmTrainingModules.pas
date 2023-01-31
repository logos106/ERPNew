unit frmTrainingModules;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseTraining, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  DNMPanel, StdCtrls, Shader, Grids, Wwdbigrd, Wwdbgrid, BusobjTraining, BusObjBase,
  DNMSpeedButton, Mask, wwdbedit, ProgressDialog , TrainingLib;

type

  TfmTrainingModules = class(TfmBaseTraining)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QryTrainingModules: TERPQuery;
    dsTrainingModules: TDataSource;
    QryTrainingModulesGlobalref: TWideStringField;
    QryTrainingModulesTrainingModuleID: TIntegerField;
    QryTrainingModulesTrainingModuleName: TWideStringField;
    QryTrainingModulesTrainingID: TLargeintField;
    QryTrainingModulesTEMFieldname: TWideStringField;
    QryTrainingModulesVideofilename: TWideStringField;
    QryTrainingModulesTrainingHrs: TFloatField;
    QryTrainingModulesSeqNo: TLargeintField;
    QryTrainingModulesActive: TWideStringField;
    QryTrainingModulesmsTimestamp: TDateTimeField;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    btnup: TDNMSpeedButton;
    btndown: TDNMSpeedButton;
    wwDBGrid1: TwwDBGrid;
    Label1: TLabel;
    edtTotalHours: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure btnupClick(Sender: TObject);
    procedure btndownClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
  private
    TrainingModules :TTrainingModules;
    procedure MoveModule(direction: TMoveModule);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); Override;
    Procedure onShowERPHint(Const Value:Integer); override;
  public

  end;


implementation

uses CommonLib, BaseInputForm, FastFuncs, BaseFormForm, BusObjConst;

{$R *.dfm}

procedure TfmTrainingModules.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
      if Sender is TTrainingModules then TTrainingModules(Sender).Dataset := QryTrainingModules;
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_TotalHours) then begin
      edtTotalHours.Text := FloatToStr(Trainingmodules.TRaining.TotalHoursforActivemodeuls) +' Hr(s)';
    end;
end;

procedure TfmTrainingModules.FormCreate(Sender: TObject);
begin
  inherited;
  TrainingModules :=TTrainingModules.Create(Self);
  TrainingModules.connection := TMyDacDataConnection.Create(TrainingModules);
  TrainingModules.Connection.Connection := Self.MyConnection;
  TrainingModules.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmTrainingModules.FormShow(Sender: TObject);
begin
  inherited;
  TrainingModules.load;
  TrainingModules.Connection.BeginTransaction;
  TrainingModules.first;
  edtTotalHours.Text := FloatToStr(Trainingmodules.TRaining.TotalHoursforActivemodeuls) +' Hr(s)';

  {only one user can access this form}
  if not TrainingModules.UserLock.Lock(TrainingModules.BusObjectTableName , 0) then begin
    AccessManager.AccessLevel := 5;
    MessageDlgXP_Vista(ReplaceStr(TrainingModules.UserLock.LockMessage , ' this record' , 'Training Modules') , mtWArning, [mbok] , 0);
  end else AccessManager.AccessLevel := 1;
  ShowERPHint(10);  
end;

procedure TfmTrainingModules.wwDBGrid1DblClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  if TrainingModules.active then
    s:= 'Do You Wish to Make ' +QryTrainingModulesTrainingModuleName.asString +' Inactive?'
  else s:= QryTrainingModulesTrainingModuleName.asString +' Is Deleted. Do You Wish to Restore?';
  if MessageDlgXP_Vista(s , mtConfirmation , [mbyes, mbNo] , 0) = mrNo then exit;
  TrainingModules.active := not(TrainingModules.Active);
  TrainingModules.PostDB;
end;

procedure TfmTrainingModules.btnupClick(Sender: TObject);
begin
  MoveModule(mmUp);
end;

procedure TfmTrainingModules.btndownClick(Sender: TObject);
begin
  inherited;
  MoveModule(mmDown);
end;

Procedure TfmTrainingModules.MoveModule(direction :TMoveModule);
begin
    MoveRecEntry(Direction, TrainingModules , 'Seqno');
(*var
  bm:Tbookmark;
  s:String;
  id1, id2:Integer;
begin
  inherited;
  if (direction =mmUp)  and (TrainingModules.BOF) then exit;
  if (direction =mmDown)  and (TrainingModules.EOF) then exit;
  id1:= 0;
  TrainingModules.Dataset.DisableControls;
  try
    bm := TrainingModules.dataset.GetBookmark;
    try
      id1:= TrainingModules.Id;
      if direction =mmUp then begin
        TrainingModules.Prior;
      end else begin
        TrainingModules.Next;
      end;
      id2:= TrainingModules.ID;
      TrainingModules.Connection.BeginNestedTransaction;
      try
        if direction =mmUp then begin
          s:='update ' + TrainingModules.BusObjectTableName +' Set Seqno  = Seqno  -1 where ' +TrainingModules.IDFieldName +' = ' +IntToStr(id1) +';'+
            'update ' + TrainingModules.BusObjectTableName +' Set Seqno  = Seqno  +1 where ' +TrainingModules.IDFieldName +' = ' +IntToStr(id2) +';';

        end else begin
          s:= 'update ' + TrainingModules.BusObjectTableName +' Set Seqno  = Seqno  +1 where ' +TrainingModules.IDFieldName +' = ' +IntToStr(id1) +';'+
              'update ' + TrainingModules.BusObjectTableName +' Set Seqno  = Seqno  -1 where ' +TrainingModules.IDFieldName +' = ' +IntToStr(id2) +';';
        end;
        TrainingModules.GetNewDataSet(s,true);
        TrainingModules.Connection.CommitNestedTransaction;
        TrainingModules.closeDb;
        TrainingModules.OpenDB;
      except
          on E:Exception do begin
              TrainingModules.Connection.RollbackNestedTransaction;
          end;
      end;
    finally
        TrainingModules.Dataset.GotoBookmark(bm);
        TrainingModules.Dataset.FreeBookmark(bm);
        if id1 <> 0 then TrainingModules.Dataset.Locate(TrainingModules.idfieldname , id1, []);
    end;
  finally
      TrainingModules.dataset.enableControls;
  end;*)
end;



procedure TfmTrainingModules.btnSaveClick(Sender: TObject);
begin
  inherited;
  TrainingModules.Save;
  TrainingModules.Connection.CommitTransaction;
  Self.Close;
end;

procedure TfmTrainingModules.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmTrainingModules.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := false;
  if TrainingModules.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
            TrainingModules.Save;
            TrainingModules.Connection.CommitTransaction;
            CanClose := true;
        end;
      mrNo:
        begin
          TrainingModules.Connection.RollbackTransaction;
          TrainingModules.Dirty := false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;

end;

procedure TfmTrainingModules.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := CaFree;
end;

procedure TfmTrainingModules.onShowERPHint(const Value: Integer);
begin
  inherited;
  if Value =10 then begin
    HighlightControl(btnup);
    HighlightextraControl1(btndown);
  end;

end;

procedure TfmTrainingModules.wwDBGrid1CalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QryTrainingModulesActive.asBoolean =False then AFont.Color:= clInactiveCaption else AFont.Color:= clBlack; 
end;

initialization
  RegisterClassOnce(TfmTrainingModules);

end.
