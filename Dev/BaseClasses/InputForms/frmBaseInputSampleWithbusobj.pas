unit frmBaseInputSampleWithbusobj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, ActnList;

type
  TfmBaseInputSampleWithbusobj = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    Actionlist: TActionList;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    busobj: Tbusobj;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure NewRecord;
  Protected
    procedure CommitAndNotify;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment;

{$R *.dfm}

procedure TfmBaseInputSampleWithbusobj.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmBaseInputSampleWithbusobj.SaveRecord :Boolean;
begin
  result:= False;
  busobj.PostDB;
  if not(busobj.Save) then exit;
  Result:= True;

end;

procedure TfmBaseInputSampleWithbusobj.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  busobj.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmBaseInputSampleWithbusobj.cmdNewClick(Sender: TObject);
begin
  inherited;
  // If user does not have access to this form don't process any further
  DisableForm;
  try
    if busobj.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if SaveRecord then begin
               CommitAndNotify;  // current record should be commited before inserting new reocrd
            end else Exit;
          end;
        mrNo:
          begin
            // Cancel edits and Rollback changes
            RollbackTransaction;
          end;
        mrCancel:
          begin
            Exit;
          end;
      end;
    end;
    KeyID := 0;
    NewRecord;
  finally
    EnableForm;
  end;

end;

procedure TfmBaseInputSampleWithbusobj.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  AfterCommit;
  Notify;

end;

procedure TfmBaseInputSampleWithbusobj.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is Tbusobj then Tbusobj(Sender).Dataset  := qry;
     end;
end;

procedure TfmBaseInputSampleWithbusobj.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmBaseInputSampleWithbusobj.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if busobj.Dirty then begin
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
          busobj.Dirty := false;
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

procedure TfmBaseInputSampleWithbusobj.FormCreate(Sender: TObject);
begin
  inherited;
   NewBusObjinstance;
end;
procedure TfmBaseInputSampleWithbusobj.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
end;

procedure TfmBaseInputSampleWithbusobj.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  busobj := Tbusobj.CreateWithNewConn(Self);
  busobj.Connection.connection := Self.MyConnection;
  busobj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

procedure TfmBaseInputSampleWithbusobj.NewRecord;
begin
    CloseQueries;
    KeyID:= 0;
    NewBusObjinstance;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    self.BeginTransaction;
    OpenRec;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    //Setcontrolfocus(edtName);
end;

procedure TfmBaseInputSampleWithbusobj.Openrec;
begin
  busobj.Load(KeyID);
  busobj.connection.BeginTransaction;
  if busobj.count=0 then busobj.new;
  openQueries;
  busobj.Dirty := false;
end;

initialization
  RegisterClassOnce(TfmBaseInputSampleWithbusobj);

end.

