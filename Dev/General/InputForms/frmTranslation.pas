unit frmTranslation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  Shader, StdCtrls, DNMPanel, DBCtrls, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton;

type
  TfmTranslation = class(TBaseInputGUI)
    QryLanguageTranslate: TERPQuery;
    Qrylanguages: TERPQuery;
    QryinEnglish: TERPQuery;
    QryLanguageTranslateID: TIntegerField;
    QryLanguageTranslateLanguageID: TIntegerField;
    QryLanguageTranslateEnglishID: TIntegerField;
    QryLanguageTranslateTranslation: TWideStringField;
    QrylanguagesID: TIntegerField;
    QrylanguagesLanguage: TWideStringField;
    QryinEnglishID: TIntegerField;
    QryinEnglishInEnglish: TWideStringField;
    QryLanguageTranslateLanguage: TWideStringField;
    QryLanguageTranslateInenglish: TWideStringField;
    dsLanguageTranslate: TDataSource;
    pnlHeader: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    wwDBGrid1: TwwDBGrid;
    txtProductDescriptionSale: TDBMemo;
    DBMemo3: TDBMemo;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTranslation: TfmTranslation;

implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}

procedure TfmTranslation.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  postdb(QryLanguageTranslate);
  CommitTransaction;
  Self.Close;
end;

procedure TfmTranslation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmTranslation.FormShow(Sender: TObject);
begin
  inherited;
  IF MyConnection.Connected THEN MyConnection.Close;
  MyConnection.Database := 'sERVERUPDATES';
  MyConnection.Connect;
  if QryLanguageTranslate.Active =false then QryLanguageTranslate.Open;
  BeginTransaction;
end;
initialization
  RegisterClassOnce(TfmTranslation);
end.
