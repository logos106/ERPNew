unit frmRapPrescribers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, wwcheckbox,
  DNMSpeedButton, wwdblook, Grids, Wwdbigrd, Wwdbgrid, Mask, wwdbedit,
  DNMPanel, MemDS, BusObjRap, Shader;

type
  TfmRapPrescriber = class(TBaseInputGUI)
    dsMaster: TDataSource;
    tblMaster: TMyQuery;
    dsDetails: TDataSource;
    tblDetails: TMyQuery;
    tblMasterPrescriberID: TAutoIncField;
    tblMasterPrescriberName: TStringField;
    tblMasterProviderNum: TStringField;
    tblDetailsID: TAutoIncField;
    tblDetailsPrescriberID: TIntegerField;
    tblDetailsPrescriberTypeID: TIntegerField;
    tblDetailsPrescriberTypeCode: TStringField;
    tblDetailsPrescriberTypeName: TStringField;
    qryPrescribertypes: TMyQuery;
    tblMasterPrescriberCode: TStringField;
    StringField1: TStringField;
    LargeintField1: TIntegerField;
    HeaderPanel: TDNMPanel;
    Panel1: TDNMPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    edtItemName: TwwDBEdit;
    wwDBGrid1: TwwDBGrid;
    cboPrescribertype: TwwDBLookupCombo;
    edtProvidernum: TwwDBEdit;
    Panel2: TDNMPanel;
    Label32: TLabel;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    tblMasterGlobalRef: TStringField;
    tblDetailsGlobalRef: TStringField;
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
    procedure wwDBGrid1Enter(Sender: TObject);
  private
    RapObj :TRAPprescriber;
  public
    { Public declarations }
  end;


implementation

uses BusObjBase, FormFactory, CommonLib;

{$R *.dfm}

procedure TfmRapPrescriber.FormCreate(Sender: TObject);
begin
  inherited;
    RapObj := TRAPprescriber.Create(self);
    RapObj.Connection := TMyDacDataConnection.Create(RapObj);
    TMyDacDataConnection(RapObj.connection).MyDacConnection := Self.MyConnection;
    RapObj.Dataset := tblMaster;
end;
procedure TfmRapPrescriber.FormDestroy(Sender: TObject);
begin
  FreeAndNil(RapObj);
  Notify;
  inherited;
end;

procedure TfmRapPrescriber.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    inherited;
    Action := caFree;
end;

procedure TfmRapPrescriber.btnCompletedClick(Sender: TObject);
begin
    inherited;
    if RapObj.Save then begin
        Notify(false);
        Self.Close;
    end;

end;

procedure TfmRapPrescriber.btnCloseClick(Sender: TObject);
begin
    inherited;
    Notify(true);
    Self.Close;
end;

procedure TfmRapPrescriber.cmdNewClick(Sender: TObject);
begin
    inherited;
    if not RapObj.Save then Exit;
    Notify;
    RapObj.New;
    RapObj.Lines;
    SetFocusedControl(edtItemName);
end;

procedure TfmRapPrescriber.FormCloseQuery(Sender: TObject;
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

procedure TfmRapPrescriber.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  inherited;
    RapObj.Lines.Dataset := tblDetails;
    RapObj.load(KeyID);
    RapObj.Lines;
    if keyId = 0 then rapObj.new;
    SetLength(QueryNamesNotToOpen, 2);
    QueryNamesNotToOpen[0] := 'tblMaster';
    QueryNamesNotToOpen[1] := 'tblDetails';
    OpenQueries(QueryNamesNotToOpen);

end;
procedure TfmRapPrescriber.wwDBGrid1Enter(Sender: TObject);
begin
  inherited;
    RapObj.PostDB;
    RapObj.Lines;
end;

initialization
  RegisterClassOnce(TfmRapPrescriber);
  with FormFact do  begin
    RegisterMe(TfmRapPrescriber, 'TRapPrescriberListGUI_*=PrescriberID');
    RegisterControl(TfmRapPrescriber, '*_cbolookupPrescribers=PrescriberID');
  End;


end.
