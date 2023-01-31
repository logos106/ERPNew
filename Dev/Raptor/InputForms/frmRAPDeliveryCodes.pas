unit frmRAPDeliveryCodes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, wwcheckbox,
  DNMSpeedButton, Mask, wwdbedit, DNMPanel, BusObjRap, MemDS, Shader;

type
  TfmRAPDeliveryCodes = class(TBaseInputGUI)
    HeaderPanel: TDNMPanel;
    Panel1: TDNMPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtDescription: TwwDBEdit;
    edtDeliveryCode: TwwDBEdit;
    Panel2: TDNMPanel;
    Label32: TLabel;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    qryDeliveryCodes: TMyQuery;
    dsDeliveryCodes: TDataSource;
    qryDeliveryCodesDeliveryCodeID: TAutoIncField;
    qryDeliveryCodesDeliveryCode: TStringField;
    qryDeliveryCodesDescription: TStringField;
    qryDeliveryCodesActive: TStringField;
    qryDeliveryCodesGlobalRef: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
   RapObj :TRAPDeliveryCode;
  public
    { Public declarations }
  end;


implementation

uses BusObjBase, FormFactory, CommonLib;


{$R *.dfm}

procedure TfmRAPDeliveryCodes.FormCreate(Sender: TObject);
begin
  inherited;
    RapObj := TRAPDeliveryCode.Create(self);
    RapObj.Connection := TMyDacDataConnection.Create(RapObj);
    TMyDacDataConnection(RapObj.connection).MyDacConnection := Self.MyConnection;
    RapObj.Dataset := qryDeliveryCodes;
end;

procedure TfmRAPDeliveryCodes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(RapObj);
  Notify;
  inherited;
end;

procedure TfmRAPDeliveryCodes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
    Action := caFree;
end;

procedure TfmRAPDeliveryCodes.btnCompletedClick(Sender: TObject);
begin
  inherited;
if RapObj.Save then Self.Close;
end;

procedure TfmRAPDeliveryCodes.btnCloseClick(Sender: TObject);
begin
  inherited;
    Self.Close;
end;

procedure TfmRAPDeliveryCodes.cmdNewClick(Sender: TObject);
begin
  inherited;
    if not RapObj.Save then Exit;
    RapObj.New;
    SetFocusedControl(edtDeliveryCode);
end;

procedure TfmRAPDeliveryCodes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
CanClose := false;
  if RapObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if RapObj.Save then begin
            CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          RollbackTransaction;
          RapObj.Dirty := false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;

procedure TfmRAPDeliveryCodes.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  inherited;
    RapObj.load(KeyID);
    SetLength(QueryNamesNotToOpen, 1);
    QueryNamesNotToOpen[0] := 'qryDeliveryCodes';
    OpenQueries(QueryNamesNotToOpen);

end;
initialization
  RegisterClassOnce(TfmRAPDeliveryCodes);

  with FormFact do  begin
    RegisterMe(TfmRAPDeliveryCodes, 'TRAPDeliveryCodeListGUI_*=DeliveryCodeId');
  End;
end.
