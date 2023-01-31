unit frmPCCImportRates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMSpeedButton, DNMPanel,
  Buttons, Wwdbigrd, StdCtrls, Mask, wwdbedit, Grids, Wwdbgrid, MemDS,
  Shader;

type
  TPCCImportRates = class(TBaseInputGUI)
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    grdEFT: TwwDBGrid;
    grdProduct: TwwDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    wwDBEdit1: TwwDBEdit;
    Label3: TLabel;
    wwDBGrid1IButton: TwwIButton;
    wwDBGrid2IButton: TwwIButton;
    qryImportRates: TMyQuery;
    dsImportRates: TDataSource;
    dsEFTCodes: TDataSource;
    qryEFTCodes: TMyQuery;
    dsProductCodes: TDataSource;
    qryProductCodes: TMyQuery;
    Bevel2: TBevel;
    qryEFTCodesPCCImportRatesEFTCodesID: TIntegerField;
    qryEFTCodesEFTCode2: TStringField;
    qryEFTCodesAddPrice: TFloatField;
    qryProductCodesPCCImportRatesProductCodesID: TIntegerField;
    qryProductCodesProductCode: TStringField;
    qryProductCodesActive: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure wwDBGrid2IButtonClick(Sender: TObject);
    procedure grdEFTExit(Sender: TObject);
    procedure grdProductExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PCCImportRates: TPCCImportRates;

implementation

uses CommonLib;

{$R *.dfm}

procedure TPCCImportRates.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPCCImportRates.btnOKClick(Sender: TObject);
begin
  inherited;
  qryImportRates.Post;
  CommitTransaction;
  Close;
end;

procedure TPCCImportRates.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Close;
end;

procedure TPCCImportRates.FormShow(Sender: TObject);
begin
  inherited;
  OpenQueries;
  if qryImportRates.RecordCount > 0 then begin
    qryImportRates.Edit;
  end
  else begin
    qryImportRates.Insert;
  end;

  BeginTransaction;
end;

procedure TPCCImportRates.wwDBGrid1IButtonClick(Sender: TObject);
begin
  inherited;
  if (qryEFTCodes.RecordCount > 0) AND  (CommonLib.MessageDlgXP_Vista('Do you wish to delete selected record?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    qryEFTCodes.Edit;
    qryEFTCodes.FieldByName('Active').AsBoolean := false;
    qryEFTCodes.Post;
    qryEFTCodes.Refresh;
  end;
end;

procedure TPCCImportRates.wwDBGrid2IButtonClick(Sender: TObject);
begin
  inherited;
  if (qryProductCodes.RecordCount > 0) AND  (CommonLib.MessageDlgXP_Vista('Do you wish to delete selected record?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    qryProductCodes.Edit;
    qryProductCodes.FieldByName('Active').AsBoolean := false;
    qryProductCodes.Post;
    qryProductCodes.Refresh;
  end;  
end;

procedure TPCCImportRates.grdEFTExit(Sender: TObject);
begin
  inherited;
  if qryEFTCodes.State in [dsEdit,dsInsert] then begin
    qryEFTCodes.Post;
  end;
end;

procedure TPCCImportRates.grdProductExit(Sender: TObject);
begin
  inherited;
  if qryProductCodes.State in [dsEdit,dsInsert] then begin
    qryProductCodes.Post;
  end;
end;

initialization
  RegisterClassOnce(TPCCImportRates);

end.
