unit frmHireLineAllocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, DNMPanel, BusObjHire, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, Buttons, Wwdbigrd, Grids, Wwdbgrid;

type
  TfmHireLineAllocation = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    MyConnection: TERPConnection;
    qryLineAsset: TERPQuery;
    qryLineAssetHireLineAssetID: TIntegerField;
    qryLineAssetGlobalRef: TWideStringField;
    qryLineAssetHireLineID: TIntegerField;
    qryLineAssetAssetId: TIntegerField;
    qryLineAssetAssetName: TWideStringField;
    qryLineAssetAssetCode: TWideStringField;
    qryLineAssetmsTimeStamp: TDateTimeField;
    qryLineAssetmsUpdateSiteCode: TWideStringField;
    dsLineAsset: TDataSource;
    btnAdd: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCloseClick(Sender: TObject);
    procedure btnGridClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    fHireLine: THireLines;
    InTrans: boolean;
    procedure SetHireLine(const Value: THireLines);
    { Private declarations }
  public
    property HireLine: THireLines read fHireLine write SetHireLine;
  end;

  function DoHireLineAllocation(aHireLine: THireLines): boolean;

implementation

{$R *.dfm}

uses
  CommonLib, frmHireLineAssetSelect;

function DoHireLineAllocation(aHireLine: THireLines): boolean;
var
  form: TfmHireLineAllocation;
begin
  form := TfmHireLineAllocation.Create(nil);
  try
    form.HireLine := aHireLine;

    result := form.ShowModal = mrOk;

  finally
    form.Free;
  end;

end;


{ TfmHireLineAllocation }

procedure TfmHireLineAllocation.btnAddClick(Sender: TObject);
begin
  inherited;
  if SelectAssetsForHireLine(HireLine) then begin

  end;
end;

procedure TfmHireLineAllocation.btnGridClick(Sender: TObject);
begin
  inherited;
  if HireLine.AssetLines.Count = 0 then exit;
  if MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation,[mbYes,mbNo] , 0 ) = mrYes then
    HireLine.AssetLines.Delete;
end;

procedure TfmHireLineAllocation.cmdCloseClick(Sender: TObject);
begin
  inherited;
  HireLine.HireQty := HireLine.AssetLines.Count;
  HireLine.Connection.CommitNestedTransaction;
  InTrans := false;
  ModalResult := mrOk;
end;

procedure TfmHireLineAllocation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if InTrans then begin
    HireLine.Connection.RollbackNestedTransaction;
    InTrans := false;
  end;
end;

procedure TfmHireLineAllocation.FormCreate(Sender: TObject);
begin
  inherited;
  InTrans := false;
end;

procedure TfmHireLineAllocation.FormShow(Sender: TObject);
begin
  inherited;
  HireLine.Connection.BeginNestedTransaction;
  InTrans := true;
end;

procedure TfmHireLineAllocation.SetHireLine(const Value: THireLines);
begin
  fHireLine := Value;
  dsLineAsset.DataSet := HireLine.AssetLines.Dataset;
end;

end.
