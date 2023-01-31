unit frmHireLineAssetSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, Shader, DNMPanel, BusObjHire, wwradiogroup,
  wwclearbuttongroup;

type
  TfmHireLineAssetSelect = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    grdMain: TwwDBGrid;
    MyConnection: TERPConnection;
    qryLineAsset: TERPQuery;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    grpFilters: TwwRadioGroup;
    qryLineAssetOnHire: TWideStringField;
    qryLineAssetAssetID: TIntegerField;
    qryLineAssetAssetName: TWideStringField;
    qryLineAssetAssetCode: TWideStringField;
    dsLineAsset: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
  private
    fHireLine: THireLines;
    procedure RefreshQuery;
    procedure SetHireLine(const Value: THireLines);
  public
//    property TimeFrom: TDateTime read fTimeFrom write fTimeFrom;
//    property TimeTo: TDateTime read fTimeTo write fTimeTo;
//    property AssetName: string read fAssetName write fAssetName;
    property HireLine: THireLines read fHireLine write SetHireLine;
  end;

function SelectAssetsForHireLine(aHireLine: THireLines): boolean;

implementation

{$R *.dfm}

uses
  CommonDbLib;

function SelectAssetsForHireLine(aHireLine: THireLines): boolean;
var
  form: TfmHireLineAssetSelect;
begin
  form := TfmHireLineAssetSelect.Create(nil);
  try
    form.HireLine := aHireLine;
    result := form.ShowModal = mrOk;
  finally
    form.Free;
  end;
end;

procedure TfmHireLineAssetSelect.cmdCloseClick(Sender: TObject);
var
  x: integer;
begin
  inherited;
  for x := 0 to grdMain.SelectedList.Count -1 do begin
    qryLineAsset.GotoBookmark(grdMain.SelectedList[x]);
    if not HireLine.AssetLines.Locate('AssetId',qryLineAssetAssetID.AsInteger,[]) then begin
      HireLine.AssetLines.New;
      HireLine.AssetLines.AssetId := qryLineAssetAssetID.AsInteger;
      HireLine.AssetLines.PostDb;
    end;
  end;
  HireLine.HireQty := HireLine.AssetLines.Count;
  ModalResult := mrOk;
end;

procedure TfmHireLineAssetSelect.FormCreate(Sender: TObject);
begin
  inherited;
  MyConnection.Database := CommonDbLib.GetSharedMyDacConnection.Database;
  MyConnection.Connect;
  qryLineAsset.Connection := MyConnection;
end;

procedure TfmHireLineAssetSelect.FormShow(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmHireLineAssetSelect.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmHireLineAssetSelect.RefreshQuery;
begin
  CloseDb(qryLineAsset);
  qryLineAsset.ParamByName('AssetName').AsString := HireLine.AssetName;
  qryLineAsset.ParamByName('HireLineId').AsInteger := HireLine.Id;
  if (HireLine.ActualHirefrom > 0) and (HireLine.ActualHireto > 0) then begin
    qryLineAsset.ParamByName('TimeFrom').AsDateTime := HireLine.ActualHireFrom;
    qryLineAsset.ParamByName('TimeTo').AsDateTime := HireLine.ActualHireTo;
  end
  else begin
    qryLineAsset.ParamByName('TimeFrom').AsDateTime := HireLine.HireFrom;
    qryLineAsset.ParamByName('TimeTo').AsDateTime := HireLine.HireTo;
  end;
  if grpFilters.ItemIndex = 1 then begin
    qryLineAsset.Filter := '';
    qryLineAsset.Filtered := false;
  end
  else begin
    qryLineAsset.Filter := 'OnHire = "F"';
    qryLineAsset.Filtered := true;
  end;

  OpenDb(qryLineAsset);
end;

procedure TfmHireLineAssetSelect.SetHireLine(const Value: THireLines);
begin
  fHireLine := Value;
end;

end.
