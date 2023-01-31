unit frmRapPrescriberTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls , BusObjRap, StdCtrls,
  wwcheckbox, DNMSpeedButton, wwdblook, Grids, Wwdbigrd, Wwdbgrid, Mask,
  wwdbedit, DNMPanel, MemDS, Shader;

type
  TfmRapPrescriberType = class(TBaseInputGUI)
    dsDetails: TDataSource;
    tblDetails: TMyQuery;
    tblMaster: TMyQuery;
    dsMaster: TDataSource;
    tblMasterPrescriberID: TAutoIncField;
    tblMasterPrescriberCode: TStringField;
    tblMasterPrescriberName: TStringField;
    tblMasterproviderNum: TStringField;
    tblMasterActive: TStringField;
    tblDetailsID: TAutoIncField;
    tblDetailsPrescriberId: TIntegerField;
    tblDetailsRapProductID: TIntegerField;
    tblDetailsActive: TStringField;
    tblDetailsRapProductCode: TStringField;
    tblDetailsRapProductName: TStringField;
    Panel1: TDNMPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtItemName: TwwDBEdit;
    edtItemNo: TwwDBEdit;
    wwDBGrid1: TwwDBGrid;
    cboRapProduct: TwwDBLookupCombo;
    HeaderPanel: TDNMPanel;
    Panel2: TDNMPanel;
    Label32: TLabel;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    qryRapProducts: TMyQuery;
    qryRapProductsProductCode: TStringField;
    qryRapProductsDescription: TStringField;
    qryRapProductsRapProductID: TIntegerField;
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
        RapObj :TRAPprescriberType;
  public
    { Public declarations }
  end;


implementation

uses BusObjBase, FormFactory, CommonLib;


{$R *.dfm}

procedure TfmRapPrescriberType.FormCreate(Sender: TObject);
begin
  inherited;
    RapObj := TRAPprescriberType.Create(self);
    RapObj.Connection := TMyDacDataConnection.Create(RapObj);
    TMyDacDataConnection(RapObj.connection).MyDacConnection := Self.MyConnection;
    RapObj.Dataset := tblMaster;

end;

procedure TfmRapPrescriberType.FormDestroy(Sender: TObject);
begin
  FreeAndNil(RapObj);
  Notify;
  inherited;
end;

procedure TfmRapPrescriberType.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
    Action := caFree;

end;

procedure TfmRapPrescriberType.btnCompletedClick(Sender: TObject);
begin
  inherited;
    if RapObj.Save then Self.Close;
end;

procedure TfmRapPrescriberType.btnCloseClick(Sender: TObject);
begin
  inherited;
    Self.Close;
end;

procedure TfmRapPrescriberType.cmdNewClick(Sender: TObject);
begin
  inherited;
    if not RapObj.Save then Exit;
    RapObj.New;
    SetFocusedControl(edtItemNo);
end;

procedure TfmRapPrescriberType.FormCloseQuery(Sender: TObject;
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

procedure TfmRapPrescriberType.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  inherited;
    RapObj.Lines.Dataset := tblDetails;
    RapObj.load(KeyID);
    RapObj.Lines;
    SetLength(QueryNamesNotToOpen, 2);
    QueryNamesNotToOpen[0] := 'tblMaster';
    QueryNamesNotToOpen[1] := 'tblDetails';
    OpenQueries(QueryNamesNotToOpen);
end;
procedure TfmRapPrescriberType.wwDBGrid1Enter(Sender: TObject);
begin
  inherited;
    RapObj.PostDB;
    RapObj.Lines;
end;

initialization
  RegisterClassOnce(TfmRapPrescriberType);

  with FormFact do  begin
    RegisterMe(TfmRapPrescriberType, 'TRapPrescribertypeListGUI_*=PrescriberID');
  End;


end.
