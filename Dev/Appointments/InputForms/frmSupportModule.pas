unit frmSupportModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Shader, ExtCtrls, DNMPanel, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, DNMSpeedButton, wwcheckbox, Mask, wwdbedit,
  busobjSupportModules, BusObjBase, ProgressDialog;

type
  TfmSupportModule = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    Label1: TLabel;
    edtSupportModule: TwwDBEdit;
    Label2: TLabel;
    chkActive: TwwCheckBox;
    QrySupportModules: TERPQuery;
    dsSupportModules: TDataSource;
    QrySupportModulesID: TIntegerField;
    QrySupportModulesGlobalRef: TWideStringField;
    QrySupportModulesModuleName: TWideStringField;
    QrySupportModulesActive: TWideStringField;
    QrySupportModulesmstimeStamp: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    SupportModules :TSupportModules;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Function SaveOrCancelChanges:Boolean ; Override;
    function GetKeyString: string; override;
    procedure SetKeyString(const Value: string); override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, FormFactory;

{$R *.dfm}
procedure TfmSupportModule.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmSupportModule.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not(SupportModules.save) then Exit;
  SupportModules.Connection.CommitTransaction;
  Notify(False);
  Self.Close;
end;

procedure TfmSupportModule.cmdNewClick(Sender: TObject);
begin
  inherited;
  if not(SupportModules.Save) then exit;
  SupportModules.Connection.CommitTransaction;
  SupportModules.Connection.BeginTransaction;
  Notify(false);
  SupportModules.New;
  setcontrolFocus(EdtSupportModule);
end;

procedure TfmSupportModule.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TSupportModules then TSupportModules(Sender).Dataset := QrySupportModules;
  end;
end;

procedure TfmSupportModule.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSupportModule.FormCreate(Sender: TObject);
begin
  inherited;
  SupportModules := TSupportModules.Create(Self);
  SupportModules.connection := TMyDAcDataconnection.Create(Self);
  SupportModules.connection.Connection := Self.MyConnection;
  SupportModules.busObjEvent := DoBusinessObjectEvent;
end;

procedure TfmSupportModule.FormDestroy(Sender: TObject);
begin
  FreeandNil(SupportModules);
  inherited;

end;

procedure TfmSupportModule.FormShow(Sender: TObject);
begin
  inherited;
   SupportModules.Load(KeyID);
   SupportModules.connection.BeginTransaction;
   if SupportModules.count =0 then SupportModules.NEw;
end;

function TfmSupportModule.GetKeyString: string;
begin
  if QrySupportModules.Active then
    result:= QrySupportModulesModuleName.AsString
  else
    result:= '';

end;

function TfmSupportModule.SaveOrCancelChanges: Boolean;
var
  iExitResult: integer;
begin
  Result := true;

  if not(SupportModules.dirty) then begin
    REsult := True;
    Exit;
  end;

  iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
    [mbYes, mbNo, mbCancel], 0);
  case iExitResult of
    mrYes:
      begin
        result := SupportModules.Save;
        if result then begin
          SupportModules.Connection.CommitTransaction;
          Notify(False);
        end;
      end;
    mrNo:
      begin;
        SupportModules.Connection.RollbackTransaction;
        Notify(True);
        REsult := true;
      end;
    mrCancel: REsult := false;
  end;
end;

procedure TfmSupportModule.SetKeyString(const Value: string);
begin
  inherited;
  SetKeyString(TSupportModules, QrySupportModules, Value , 'ModuleName');
end;

initialization
  RegisterClassOnce(TfmSupportModule);
  with FormFact do begin
    RegisterMe(TfmSupportModule, 'TSupportModulesGUI_*=ID');
  end;
end.
