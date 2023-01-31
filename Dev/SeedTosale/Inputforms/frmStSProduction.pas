unit frmStSProduction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStSInputBase, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, Shader, DNMSpeedButton, DNMPanel, StdCtrls,
  wwclearbuttongroup, wwradiogroup, wwdbedit, wwdbdatetimepicker, Mask, Wwdbspin, BusObjSeedToSale;

type
  TfmStSProduction = class(TfmStSInputBase)
    optTagForProduct: TwwRadioGroup;
    dsststagproduct: TDataSource;
    Label1: TLabel;
    edtTHC_Content: TwwDBSpinEdit;
    Label2: TLabel;
    dtProductionDate: TwwDBDateTimePicker;
    lblProductPrintName: TLabel;
    edtStrainName: TwwDBEdit;
    btnChooseTags: TDNMSpeedButton;
    Shape1: TShape;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    fStSTagProduct: TStSTagProduct;
    fsTagForProduct: String;
    fiTagProductID :Integer;
    procedure setStSTagProduct(const Value: TStSTagProduct);
  Protected
    fiProductTagID :Integer;
    procedure SetTagForProduct(const Value: String);Virtual;
  public
    Property StSTagProduct : TStSTagProduct read fStSTagProduct write setStSTagProduct;
    Property TagForProduct :String read fsTagForProduct write SetTagForProduct;
    Property TagProductID :Integer read fiTagProductID write fiTagProductID;
  end;

implementation


{$R *.dfm}

procedure TfmStSProduction.FormCreate(Sender: TObject);
begin
  inherited;
  fiProductTagID :=0;
  fsTagForProduct := '';
  fiTagProductID := 0;
end;

procedure TfmStSProduction.setStSTagProduct(const Value: TStSTagProduct);
begin
  fStSTagProduct := Value;
  dsststagproduct.DataSet := Value.dataset;
end;

procedure TfmStSProduction.SetTagForProduct(const Value: String);
begin
  fsTagForProduct := Value;
end;

end.
