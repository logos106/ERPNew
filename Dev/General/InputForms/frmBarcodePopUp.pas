unit frmBarcodePopUp;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 20/04/05  1.00.00 IJB  Initial version.

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls,
  Wwdbgrid, MyAccess,ERPdbComponents, BaseInputForm, Menus, AdvMenus, DataState, DB,
  DBAccess, SelectionDialog, AppEvnts, ImgList, MemDS;

type


  TBarcodeObj = class(TObject)
  private
    fCreateIfNotFound: boolean;
    fProductId: integer;
    fDBConnection: TERPConnection;
    (*fProductName: string;*)
    procedure ProductGridSelect(Sender: TwwDbGrid);
  public
    constructor Create;
    destructor Destroy; override;
    property DBConnection: TERPConnection read fDBConnection write fDBConnection;
    function GetProductId(const Barcode: string): integer;
    (*property ProductName: string read fProductName;*)
    property CreateIfNotFound: boolean read fCreateIfNotFound write fCreateIfNotFound;
        //class function Instance: TBarcodeObj;
  end;

  TfmBarcodePopUp = class(TBaseInputGUI)
    Label9: TLabel;
    Bevel1: TBevel;
    edtBarcode: TEdit;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtBarcodeKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    class function GetProductId(const Barcode: string; var ProductName: string): integer;
  end;

implementation

{$R *.dfm}

uses
  CommonDbLib,
  BaseClassFuncs, BaseListingForm, CommonLib, FastFuncs, BusObjStock;

var
  EnteredBarcode: string;

class function TfmBarcodePopUp.GetProductId(const Barcode: string; var ProductName: string): integer;
var
  BarCodeObj: TBarCodeObj;
  frm: TfmBarcodePopUp;
begin
  Result := 0;
  EnteredBarcode := Barcode;
  if EnteredBarcode = '' then begin
    frm:= TfmBarcodePopUp.Create(nil);
    try
      frm.edtBarcode.Text:= EnteredBarcode;
      if frm.ShowModal = mrOk then
        EnteredBarcode:= frm.edtBarcode.Text;
    finally
      frm.free;
    end;
  end;
  if EnteredBarcode <> '' then begin
    BarCodeObj := TBarCodeObj.Create;
    try
      Result := BarCodeObj.GetProductId(EnteredBarcode);
    finally
      FreeandNil(BarcodeObj);
    end;
  end;
end;

procedure TfmBarcodePopUp.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  edtBarcode.Text := '';
end;

procedure TfmBarcodePopUp.FormShow(Sender: TObject);
begin
  SetControlFocus(edtBarcode);
end;

procedure TfmBarcodePopUp.edtBarcodeKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = VK_RETURN then btnOk.Click;
end;

  // -----------------------------------------------------------------------------
  //     TBarcodeObj
  // -----------------------------------------------------------------------------

constructor TBarcodeObj.Create;
begin
  inherited;
  fCreateIfNotFound := true;
  fProductId := 0;
  fDBConnection := nil;
end;

destructor TBarcodeObj.Destroy;
begin
  inherited;
end;

procedure TBarcodeObj.ProductGridSelect(Sender: TwwDbGrid);
begin
  fProductID := Sender.DataSource.DataSet.FieldByName('PARTSID').AsInteger;
end;


function TBarcodeObj.GetProductId(const Barcode: string): integer;
var
  ProductListForm: TBaseListingGUI;
begin

  Result := TProduct.ProductIdForBarcode(BarCode);
  if (Result < 1) and fCreateIfNotFound then begin
      if CommonLib.MessageDlgXP_Vista('No product found with the Barcode of ' + Barcode +
        chr(13) + 'Do you wish to assign this Barcode to a Product?', mtInformation, [mbYes, mbNo], 0) = Controls.mrYes then begin
        ProductListForm := BaseClassFuncs.GetBaseListingByClassName('TProductListExpressGUI');
        with ProductListForm do begin
          OnGridDataSelect := ProductGridSelect;
          ShowModal;
        end;
        if fProductId > 0 then begin
          Result := fProductId;
          TProduct.SetProductBarcode(fProductId, Barcode, True, fDBConnection);
        end;
      end;
    end;
end;

initialization

end.
