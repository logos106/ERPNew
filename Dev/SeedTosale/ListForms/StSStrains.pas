unit StSStrains;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProductListExpressForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, wwclearbuttongroup, wwradiogroup,
  DNMSpeedButton, Shader, GIFImg, DNMPanel, BaseInputForm, BaseListingForm,
  BaseListExpress;

type
  TStSStrainsGUI = class(TBaseListingGUI)
    btnImport: TDNMSpeedButton;
    qryMainID: TIntegerField;
    qryMainStrainName: TWideStringField;
    qryMainTested: TWideStringField;
    qryMainTestedInHouse: TWideStringField;
    qryMainTestedBy: TWideStringField;
    qryMainTHC_Content: TFloatField;
    qryMainCBD_Content: TFloatField;
    qryMainIndica: TFloatField;
    qryMainSativa: TFloatField;
    qryMainImmatureProduct: TWideStringField;
    qryMainVegetativeProduct: TWideStringField;
    qryMainFloweringProduct: TWideStringField;
    qryMainHarvestProduct: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure DoBeforeshowImportDataMapping(Sender: TObject);
    Function DataImportType:String;
  Protected
    procedure AssignKeyId(Popupform: TBaseInputGUI); Override;
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib, CommonFormLib, frmImportDataMapping, tcDataUtils, StSConst;

{$R *.dfm}

procedure TStSStrainsGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  inherited;
end;

procedure TStSStrainsGUI.btnImportClick(Sender: TObject);
begin
  inherited;
    OpenERPForm('TfmImportDataMapping',ImportDataMapIDFortype(DataImportType), nil, DoBeforeshowImportDataMapping);
    Self.close;
end;
function TStSStrainsGUI.DataImportType: String;
begin
  Result := STS_CAPTION;
end;

procedure TStSStrainsGUI.DoBeforeshowImportDataMapping(Sender:TObject);
begin
  if sender is TfmImportDataMapping then begin
    with TfmImportDataMapping(Sender) do
      IntforType(DataImportType , DataImportType);
  end;

end;

procedure TStSStrainsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TStSStrainsGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TfmStSStrain', 0);
end;

procedure TStSStrainsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainid.fieldname);
end;

initialization
  RegisterClassOnce(TStSStrainsGUI);


end.
