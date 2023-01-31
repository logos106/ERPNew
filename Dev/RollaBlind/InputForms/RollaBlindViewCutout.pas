unit RollaBlindViewCutout;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 05/07/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, Grids, Wwdbigrd,
  Wwdbgrid, DNMSpeedButton, DBCtrls, StdCtrls, DNMPanel, MemDS, StrUtils;

type
  TRollaBlindViewCutoutGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label3: TLabel;
    txtLeadNumber: TDBText;
    Label5: TLabel;
    txtName: TDBText;
    txtProfileType: TDBText;
    Label2: TLabel;
    txtHeight: TDBText;
    Label4: TLabel;
    txtWidth: TDBText;
    Label6: TLabel;
    txtMod1Height: TDBText;
    Label7: TLabel;
    txtMod1Width: TDBText;
    Label8: TLabel;
    txtInstallType: TDBText;
    Label9: TLabel;
    txtSubInstallType: TDBText;
    Label10: TLabel;
    Label11: TLabel;
    pnlTitle: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    grdCutting: TwwDBGrid;
    grdComponents: TwwDBGrid;
    grdColours: TwwDBGrid;
    btnPrint: TDNMSpeedButton;
    qryHeading: TMyQuery;
    qryHeadingProfileType: TStringField;
    qryHeadingLeadNumber: TIntegerField;
    qryHeadingName: TStringField;
    qryHeadingOpeningHeight: TFloatField;
    qryHeadingOpeningWidth: TFloatField;
    qryHeadingMod1Height: TFloatField;
    qryHeadingMod1Width: TFloatField;
    qryHeadingInstallType: TStringField;
    qryHeadingSubInstallType: TStringField;
    dsHeading: TDataSource;
    qryCutting: TMyQuery;
    qryCuttingItemNumber: TStringField;
    qryCuttingDes: TStringField;
    qryCuttingQty: TFloatField;
    qryCuttingColour: TStringField;
    qryCuttingFlag: TStringField;
    dsCutting: TDataSource;
    qryComponents: TMyQuery;
    qryComponentsItemNumber: TStringField;
    qryComponentsDes: TStringField;
    qryComponentsQty: TFloatField;
    qryComponentsColour: TStringField;
    qryComponentsFlag: TStringField;
    dsComponents: TDataSource;
    qryColours: TMyQuery;
    qryColoursItemNumber: TStringField;
    qryColoursDescription: TStringField;
    qryColoursQty: TFloatField;
    qryColoursColour: TStringField;
    dsColours: TDataSource;
    qryCuttingLength: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  FormFactory, RollaBlindQueryLoadObj, CommonLib, FastFuncs;

procedure TRollaBlindViewCutoutGUI.FormShow(Sender: TObject);
var
  qryTmp: TMyQuery;
  LeadNumber: string;
begin
  inherited;
  qryTmp := TMyQuery.Create(nil);
  qryTmp.Options.FlatBuffers := True;
  try
    qryTmp.Connection := MyConnection;
    qryTmp.SQL.Text := 'SELECT LeadNumber FROM tblrollasheet1 WHERE SheetID=' + FastFuncs.IntToStr(KeyID);
    qryTmp.Open;
    qryTmp.First;
    LeadNumber := qryTmp.FieldByName('LeadNumber').AsString;
    qryHeading.ParamByname('ClientID').AsInteger := StrToIntDef(LeadNumber, 0);
    qryHeading.ParamByname('SheetID').AsInteger := KeyID;
    qryCutting.ParamByname('SheetID').AsInteger := KeyID;
    qryComponents.ParamByname('SheetID').AsInteger := KeyID;
    qryColours.ParamByname('SheetID').AsInteger := KeyID;
    OpenQueries;
  finally
    FreeandNil(qryTmp);
  end;
end;

procedure TRollaBlindViewCutoutGUI.btnPrintClick(Sender: TObject);
var
  TmpSql: string;
  QueryLoad: TRollaBlindQueryLoad;
begin
  inherited;
  QueryLoad := TRollaBlindQueryLoad.Create;

  try
    QueryLoad.Connection := MyConnection;
    TmpSql := QueryLoad.GetQuery('Report');
    TmpSql := AnsiReplaceText(TmpSql, ':SheetID', FastFuncs.IntToStr(KeyID));
    fbReportSQLSupplied := True;
    PrintTemplateReport('Rolla Blind', TmpSql, False, 1);
    fbReportSQLSupplied := False;
  finally
    FreeandNil(QueryLoad);
  end;
end;

procedure TRollaBlindViewCutoutGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TRollaBlindViewCutoutGUI.FormCreate(Sender: TObject);
begin
  TitleLabel.Caption := Caption;
  inherited;
end;

procedure TRollaBlindViewCutoutGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

initialization
  RegisterClassOnce(TRollaBlindViewCutoutGUI);

  with FormFact do
  begin
    RegisterMe(TRollaBlindViewCutoutGUI, 'TRollaBlindViewDatabaseListGUI_*=SheetID');
  end;
finalization
  UnRegisterClass(TRollaBlindViewCutoutGUI);
end.
