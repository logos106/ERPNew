unit frmDuration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase  , BusObjDuration, wwcheckbox, Mask;

type
  TfmDuration = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    QryDuration: TERPQuery;
    dsDuration: TDataSource;
    QryDurationDurationId: TIntegerField;
    QryDurationGlobalRef: TWideStringField;
    QryDurationDescription: TWideStringField;
    QryDurationQty: TFloatField;
    QryDurationDurationType: TWideStringField;
    QryDurationActive: TWideStringField;
    QryDurationmstimestamp: TDateTimeField;
    QryDurationmsUpdateSiteCode: TWideStringField;
    Name_Label: TLabel;
    edtDescription: TDBEdit;
    txtQty: TDBEdit;
    Label1: TLabel;
    grpDurationtype: TDBRadioGroup;
    btnNew: TDNMSpeedButton;
    Shape1: TShape;
    QryDurationStepQty: TFloatField;
    QryDurationStepDurationType: TWideStringField;
    QryDurationGraceQty: TFloatField;
    QryDurationGraceDurationType: TWideStringField;
    chkActive: TwwCheckBox;
    lblSetupDurations: TLabel;
    Label2: TLabel;
    Shape2: TShape;
    Label3: TLabel;
    edtStepQty: TDBEdit;
    grpStepDuration: TDBRadioGroup;
    Label4: TLabel;
    Shape3: TShape;
    Label5: TLabel;
    edtGraceQty: TDBEdit;
    grpGraceDuration: TDBRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNewClick(Sender: TObject);
  private
    DurationObj: TDuration;
    function SaveDuration: Boolean;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure CommitAndNotify;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, FormFactory, tcConst;

{$R *.dfm}

procedure TfmDuration.btnNewClick(Sender: TObject);
begin
  inherited;
  try
    if not SaveDuration then exit;
    DurationObj.Dirty := False;
    CommitAndNotify;
    beginTRansaction;
    DurationObj.New;
    Setcontrolfocus(edtDescription);
  finally
    beginTRansaction;
  end;

end;

procedure TfmDuration.cmdCancelClick(Sender: TObject);
begin
  inherited;
  CloseIt(False);
end;

Function TfmDuration.SaveDuration :Boolean;
begin
  result:= False;
  DurationObj.PostDB;
  if not(DurationObj.Save) then exit;
  Result:= True;

end;

procedure TfmDuration.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveDuration then exit;
  CommitAndNotify;
  DurationObj.Dirty := False;
  CloseIt(TRue);
end;

procedure TfmDuration.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;

procedure TfmDuration.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TDuration then TDuration(Sender).Dataset  := QryDuration;
     end;
end;

procedure TfmDuration.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmDuration.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if DurationObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveDuration then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          DurationObj.Dirty := false;
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

procedure TfmDuration.FormCreate(Sender: TObject);
begin
  inherited;
  lblSetupDurations.Caption   := 'Hire Durations are used to Define the Hire Rates for a Piece of Equipment.' +NL+NL+
                                 'ie. To make a Duration of 2 Days, Please enter 2 in the Duration and Choose type ''Days''.';
  DurationObj := TDuration.CreateWithNewConn(Self);
  DurationObj.Connection.connection := Self.MyConnection;
  DurationObj.BusObjEvent := DoBusinessObjectEvent;

  lblSetupDurations.Caption :=
    'Hire Durations are used to Define the Hire Rates for a Piece of Equipment.  '+
    'ie To make a Duration of 2 Days, Please enter 2 in the Quantity and Choose type ''Days''.';

  Label2.Caption :=
    'Enter the Quantity and Duration Type required as a minimum to "step up to"  this Duration.  '+
    'ie set this to 3 days so that previous 2 day hire after 3 days it moves to the week rate.';

  Label4.Caption :=
    'Enter an optional Quantity and Duration Type to define a Grace Period.  ' +
    'ie if on the 2 day example you allow them to return the hire after 2 days ' +
    'and 5 hours it will still charge at the day rate and not jump up to the next rate eg week.';
end;

procedure TfmDuration.FormShow(Sender: TObject);
begin
  inherited;
  DurationObj.Load(KeyID);
  DurationObj.connection.BeginTransaction;
  if DurationObj.count=0 then DurationObj.new;
  openQueries;
end;

initialization
  RegisterClassOnce(TfmDuration);
  with FormFact do  begin
    RegisterMe(TfmDuration, 'TDurationListGUI_*=DurationId');
  end;

end.

