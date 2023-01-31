unit RollaBlindCutoutSheet;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 29/06/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, DBAccess, MyAccess, SelectionDialog, AppEvnts, DB, 
  Grids, Wwdbigrd, Wwdbgrid, MemDS, StdCtrls, DBCtrls, StrUtils;

type
  TRollaBlindCutoutSheetGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    grdCutting: TwwDBGrid;
    Label1: TLabel;
    qryHeading: TMyQuery;
    qryHeadingLeadNumber: TIntegerField;
    qryHeadingProfileType: TStringField;
    qryHeadingOpeningHeight: TFloatField;
    qryHeadingOpeningWidth: TFloatField;
    qryHeadingMod1Height: TFloatField;
    qryHeadingMod1Width: TFloatField;
    qryHeadingInstallType: TStringField;
    qryHeadingSubInstallType: TStringField;
    Label3: TLabel;
    txtLeadNumber: TDBText;
    Label5: TLabel;
    txtName: TDBText;
    dsHeading: TDataSource;
    qryHeadingName: TStringField;
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
    qryCutting: TMyQuery;
    dsCutting: TDataSource;
    qryComponents: TMyQuery;
    dsComponents: TDataSource;
    Label10: TLabel;
    grdComponents: TwwDBGrid;
    qryCuttingItemNumber: TStringField;
    qryCuttingDes: TStringField;
    qryCuttingQty: TFloatField;
    qryCuttingLength: TStringField;
    qryCuttingColour: TStringField;
    qryComponentsItemNumber: TStringField;
    qryComponentsDes: TStringField;
    qryComponentsQty: TFloatField;
    qryComponentsColour: TStringField;
    qryColours: TMyQuery;
    dsColours: TDataSource;
    Label11: TLabel;
    grdColours: TwwDBGrid;
    qryColoursItemNumber: TStringField;
    qryColoursDescription: TStringField;
    qryColoursQty: TFloatField;
    qryColoursColour: TStringField;
    qryCuttingFlag: TStringField;
    qryComponentsFlag: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
  private
    fSheetID: Integer;
    fLeadNumber: string;
  public
    property SheetID: Integer read fSheetID write fSheetID;
    property LeadNumber: string read fLeadNumber write fLeadNumber;
  end;

implementation

{$R *.dfm}

uses
  RollaBlindQueryLoadObj, CommonLib;

procedure TRollaBlindCutoutSheetGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryHeading.ParamByname('ClientID').AsInteger := StrToIntDef(LeadNumber, 0);
  qryHeading.ParamByname('SheetID').AsInteger := SheetID;
  qryCutting.ParamByname('SheetID').AsInteger := SheetID;
  qryComponents.ParamByname('SheetID').AsInteger := SheetID;
  qryColours.ParamByname('SheetID').AsInteger := SheetID;
  OpenQueries;
end;

procedure TRollaBlindCutoutSheetGUI.FormCreate(Sender: TObject);
begin
  TitleLabel.Caption := Caption;
  inherited;
  fSheetID := 0;
  fLeadNumber := '';
end;

procedure TRollaBlindCutoutSheetGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TRollaBlindCutoutSheetGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  QueryLoad: TRollaBlindQueryLoad;
begin
  inherited;
  CloseQueries;

  QueryLoad := TRollaBlindQueryLoad.Create;

  try
    QueryLoad.Connection := MyConnection;
    //
    // Don't delete all records from tables as primary key is reset when server is
    // turned off then on
    //
//    QueryLoad.Execute('A13b', SheetID);
//    QueryLoad.Execute('A13d', SheetID);
  finally
    FreeandNil(QueryLoad);
  end;

  Action := caFree;
end;

procedure TRollaBlindCutoutSheetGUI.btnSaveClick(Sender: TObject);
var
  QueryLoad: TRollaBlindQueryLoad;
begin
  inherited;
  CloseQueries;

  QueryLoad := TRollaBlindQueryLoad.Create;

  try
    QueryLoad.Connection := MyConnection;
    QueryLoad.Execute('A13a', SheetID);
    //
    // Don't delete all records from tables as primary key is reset when server is
    // turned off then on
    //
//    QueryLoad.Execute('A13b', SheetID);
    QueryLoad.Execute('A13c', SheetID);
//    QueryLoad.Execute('A13d', SheetID);
  finally
    FreeandNil(QueryLoad);
    Release;
  end;
end;

initialization
  RegisterClassOnce(TRollaBlindCutoutSheetGUI);
finalization
  UnRegisterClass(TRollaBlindCutoutSheetGUI);
end.
