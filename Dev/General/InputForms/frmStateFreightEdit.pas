unit frmStateFreightEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, wwdblook, Wwdbdlg,
  wwcheckbox, Mask, DBCtrls,
  BusObjStateFreight, BusObjBase;

type
  TfmStateFreightEdit = class(TBaseInputGUI)
    qryStateFreight: TERPQuery;
    qryStateFreightGlobalRef: TWideStringField;
    qryStateFreightID: TIntegerField;
    qryStateFreightState: TWideStringField;
    qryStateFreightPercent: TFloatField;
    qryStateFreightFixedAmount: TFloatField;
    qryStateFreightRegionID: TIntegerField;
    qryStateFreightActive: TWideStringField;
    qryStateFreightmsTimeStamp: TDateTimeField;
    qryStateFreightmsUpdateSiteCode: TWideStringField;
    dsStateFreight: TDataSource;
    qryStateLookup: TERPQuery;
    DNMPanel1: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cboState: TwwDBLookupCombo;
    edtPercent: TDBEdit;
    edtFixedAmount: TDBEdit;
    chkActive: TwwCheckBox;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cboStateNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
  private
    StateFreight: TStateFreight;
    function SaveData: boolean;
  protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); override;
    procedure CommitAndNotify; override;
  public
    { Public declarations }
  end;

implementation

uses
  BUsObjConst, CommonLib, FormFactory;

{$R *.dfm}

procedure TfmStateFreightEdit.cboStateNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('There are no Customers currently using this State, do you wish to add it anyway?',mtConfirmation,[mbYes,mbNo],0) = mrNo then begin
    Accept := false;
  end
  else begin
    Accept := true;
  end;
end;

procedure TfmStateFreightEdit.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmStateFreightEdit.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveData then exit;
  CommitAndNotify;
  Self.Close;
end;

procedure TfmStateFreightEdit.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  //AfterCommit;
  Notify;
end;

procedure TfmStateFreightEdit.DoBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TBusObj then Tbusobj(Sender).Dataset := qryStateFreight;
  end;
end;

procedure TfmStateFreightEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;

end;

procedure TfmStateFreightEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if StateFreight.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          StateFreight.Dirty := false;
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

procedure TfmStateFreightEdit.FormCreate(Sender: TObject);
begin
  inherited;
  StateFreight := TStateFreight.CreateWithNewConn(self);
  StateFreight.Connection.Connection := Self.MyConnection;
  StateFreight.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmStateFreightEdit.FormShow(Sender: TObject);
begin
  inherited;
  StateFreight.Load(KeyID);
  StateFreight.connection.BeginTransaction;
  if StateFreight.count= 0 then
    StateFreight.New;
  OpenQueries;
  StateFreight.Dirty := false;
end;

function TfmStateFreightEdit.SaveData: boolean;
begin
  result:= False;
  StateFreight.PostDB;
  if not(StateFreight.Save) then exit;
  Result:= True;
end;

initialization
  RegisterClass(TfmStateFreightEdit);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmStateFreightEdit, 'TfmStateFreightList_*=ID');
  end;

end.
