unit BarcodePickingManifestReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox;

type
  TBarcodePickingManifest = class(TBaseListingGUI)
    qryMainSaleDate: TDateField;
    qryMainFinishedPackingTime: TDateTimeField;
    qryMainCustomerName: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostCode: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainOriginal: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainAttrib1Sale: TFloatField;
    qryMainAttrib2Sale: TFloatField;
    qryMainAttrib1SaleRate: TFloatField;
    qryMainBoxes: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainPickingAssemblyID: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

//var
//  BarcodePickingManifest: TBarcodePickingManifest;

implementation
   
uses AppEnvironment, CommonLib;
{$R *.dfm}

procedure TBarcodePickingManifest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  BarcodePickingManifest := nil;
end;

procedure TBarcodePickingManifest.FormShow(Sender: TObject);
begin
  inherited;
  grdMain.columnbyName('Attrib1Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib1Name;
  grdMain.columnbyName('Attrib2Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib2Name;
  grdMain.columnbyName('Attrib1SaleRate').DisplayLabel := 'Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name;
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib1Sale');
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib2Sale');
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib1SaleRate');
end;

procedure TBarcodePickingManifest.RefreshQuery;
var
  Invoice, SO: string;
begin
  inherited;
  qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  if AppEnv.CompanyPrefs.BarcodePickingInSOMode then begin
    Invoice := 'F';
    SO      := 'T';
  end else begin
    Invoice := 'T';
    SO      := 'F';
  end;
  qryMain.Params.ParamByName('Invoice').asString := Invoice;
  qryMain.Params.ParamByName('SalesOrder').asString := SO;
  inherited;
  RefreshTotals;
end;

procedure TBarcodePickingManifest.RefreshTotals;
var
  Attrib1Sale, Attrib2Sale, Boxes: double;
begin
  Attrib1Sale := 0;
  Attrib2Sale := 0;
  Boxes := 0;

  with qryMain do begin
    First;
    while not Eof do begin
      Attrib1Sale := Attrib1Sale + qryMainAttrib1Sale.AsFloat;
      Attrib2Sale := Attrib2Sale + qryMainAttrib2Sale.AsFloat;
      Boxes := Boxes + qryMainBoxes.AsFloat;

      Next;
    end;
  end;
  grdMain.ColumnByName('Attrib1Sale').FooterValue := FloatToStrF(Attrib1Sale, ffFixed, 15, 2);
  grdMain.ColumnByName('Attrib2Sale').FooterValue := FloatToStrF(Attrib2Sale, ffFixed, 15, 2);
  grdMain.ColumnByName('Boxes').FooterValue := FloatToStrF(Boxes, ffFixed, 15, 2);
end;

procedure TBarcodePickingManifest.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TBarcodePickingManifest);
end.
