unit frmManufacture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImgList, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess, ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, wwcheckbox, DNMSpeedButton, Mask, wwdbedit, MemDS, Shader,
  DNMPanel, BusObjEquipment;

type
  TfmManufacture = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DSManufacture: TDataSource;
    qryManufacture: TERPQuery;
    qryManufactureGlobalRef: TWideStringField;
    qryManufactureID: TIntegerField;
    qryManufactureName: TWideStringField;
    qryManufactureActive: TWideStringField;
    qryManufactureCreatedOn: TDateTimeField;
    qryManufacturemsTimeStamp: TDateTimeField;
    Label1: TLabel;
    edName: TwwDBEdit;
    Label2: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    btnconfig: TDNMSpeedButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure qryManufactureAfterInsert(DataSet: TDataSet);
    procedure btnconfigClick(Sender: TObject);
  private
    
  public
    { Public declarations }
  end;

implementation

uses CommonLib, FormFactory, CommonFormLib, frmRepairExportconfig,
  BaseFormForm, DNMAccessManager;

{$R *.dfm}

procedure TfmManufacture.btnCancelClick(Sender: TObject);
begin
  inherited;
  Notify(True);
  if fsModal in FormState then  else Close;
end;

procedure TfmManufacture.btnSaveClick(Sender: TObject);
begin
  inherited;
  postDB(qryManufacture);
  if edName.Text = '' then exit;
  CommitTransaction;
  Notify(false);
  if fsModal in FormState then  else Close;
end;

procedure TfmManufacture.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 Closequeries;
  Action := caFree;
end;

procedure TfmManufacture.FormShow(Sender: TObject);
begin
  inherited;
  BeginTransaction;
  if Self.KeyID = 0 then begin
    OpenQueries;
    qryManufacture.Insert;
    qryManufacture.Post;
    qryManufacture.Edit;
    Self.KeyID := qryManufacture.fieldbyName('ID').AsInteger;
  end else begin
    qryManufacture.Params.ParamByName('KeyID').AsInteger := Self.KeyID;
    OpenQueries;
  end;
  btnconfig.enabled := AccessManager.AccessLevel = 1;
end;

procedure TfmManufacture.btnNewClick(Sender: TObject);
begin
  inherited;
  PostDB(qryManufacture);
  KeyID    := 0;
  FormShow(nil);
end;

procedure TfmManufacture.qryManufactureAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryManufactureCreatedOn.asDateTime := Date;
  qryManufactureActive.AsBoolean := true;
end;

procedure TfmManufacture.btnconfigClick(Sender: TObject);
begin
  inherited;
  PostDB(qryManufacture);
  CommitTransaction;
  With TfmRepairExportconfig(GetComponentByClassName('TfmRepairExportconfig'  , true , self)) do try
     ManufactureID := qryManufactureID.asInteger;
     showmodal;
  finally
      Free;
  end;
  Notify(False);
  Self.close;
end;

initialization
  RegisterClassOnce(TfmManufacture);
  with FormFact do begin
    RegisterMe(TfmManufacture, 'TManufactureListGUI_*=ID');
    RegisterControl(TfmManufacture, '*_cboManufacture=ID');
    RegisterControl(TfmManufacture, '*_cboManufactureID=ID');
  end;
end.
