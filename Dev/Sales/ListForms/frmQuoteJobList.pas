unit frmQuoteJobList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, frmDiminishedValueGrid, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfmQuoteJobList = class(TBaseListingGUI)
    qryMainSaleDate: TDateField;
    qryMainFollowupDate: TDateField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
    qryMainClientNotes: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainWarrantyFinishDate: TDateTimeField;
    qryMainWarrantyPeriod: TFloatField;
    qryMainHoursTakenForJob: TFloatField;
    qryMainJobRep: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainJobTitle: TWideStringField;
    qryMainSerialNumber: TWideStringField;
    qryMainModelNumber: TWideStringField;
    qryMainManufacture: TWideStringField;
    qryMainCustomerJobNumber: TWideStringField;
    qryMainHours: TFloatField;
    qryMainInsuranceCompanyName: TWideStringField;
    qryMainClaimNumber: TWideStringField;
    qryMainStormLocation: TWideStringField;
    qryMainStormDate: TDateField;
    qryMainYear: TDateField;
    qryMainColour: TWideStringField;
    qryMainBodyType: TWideStringField;
    qryMainAssessorsName: TWideStringField;
    qryMainClientGlobalRef: TWideStringField;
    qryMainType: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainSaleGlobalRef: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainTotalQuoteAmount: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainQuoteStatus: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainSaleComments: TWideStringField;
    qryMainDone: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainReference: TWideStringField;
    qryMainInvoiceTo: TWideStringField;
    qryMainSaleRep: TWideStringField;
    qryMainEnteredBy: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainRegistration: TWideStringField;
    qryMainBailmentNumber: TWideStringField;
    qryMainBailmentAmountEx: TFloatField;
    qryMainStockReceivedDate: TDateField;
    qryMainNewOrUsed: TWideStringField;
    qryMainExcessAmount: TFloatField;
    qryMainNettSettlment: TFloatField;
    btnDiminishedValue: TDNMSpeedButton;
    qryMainDiminishedValue: TFloatField;
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure btnDiminishedValueClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    DiminishedValue_1: TValueGrid;
    DiminishedValue_2: TValueGrid;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  fmQuoteJobList: TfmQuoteJobList;

implementation

{$R *.dfm}

uses
  CommonLib, frmQuote, AppEnvironment, AppContextObj,
  JsonObject, PreferenceLib;


procedure TfmQuoteJobList.btnDiminishedValueClick(Sender: TObject);
var
  Json_1: TJsonObject;
  Json_2: TJsonObject;
begin
  inherited;
  Json_1:= JO;
  Json_2:= JO;
  try
    Json_1.AsString:= DiminishedValue_1.JsonText;
    Json_2.AsString:= DiminishedValue_2.JsonText;
    if DoEditDiminishedValeMatrix(Json_1, Json_2) then begin
      PreferenceLib.SetDbPrefValue('ptCompany','DiminishedValueJson_1',Json_1.AsString);
      DiminishedValue_1.JsonText:= Json_1.AsString;
      PreferenceLib.SetDbPrefValue('ptCompany','DiminishedValueJson_2',Json_2.AsString);
      DiminishedValue_2.JsonText:= Json_2.AsString;
    end;


  finally
    Json_1.Free;
    Json_2.Free;
  end;
end;

procedure TfmQuoteJobList.cmdNewClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    tmpComponent := GetComponentByClassName('TQuoteGUI');
    if not Assigned(tmpComponent) then Exit;
    with TQuoteGUI(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmQuoteJobList.FormCreate(Sender: TObject);
begin
  inherited;
  DiminishedValue_1:= TValueGrid.Create;
  DiminishedValue_1.JsonText:= PreferenceLib.GetDbPrefStr('ptCompany','DiminishedValueJson_1');
  DiminishedValue_2:= TValueGrid.Create;
  DiminishedValue_2.JsonText:= PreferenceLib.GetDbPrefStr('ptCompany','DiminishedValueJson_2');
end;

procedure TfmQuoteJobList.FormDestroy(Sender: TObject);
begin
  inherited;
  DiminishedValue_1.Free;
  DiminishedValue_2.Free;
end;

procedure TfmQuoteJobList.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainNettSettlment.AsFloat:= qryMainTotalAmountEx.AsFloat - qryMainExcessAmount.AsFloat;
  if qryMainRegistration.AsString <> '' then
    qryMainDiminishedValue.AsFloat:= DiminishedValue_1.CalcValue(qryMainBailmentAmountEx.AsFloat,qryMainTotalAmountEx.AsFloat)
  else
    qryMainDiminishedValue.AsFloat:= DiminishedValue_2.CalcValue(qryMainBailmentAmountEx.AsFloat,qryMainTotalAmountEx.AsFloat);
end;

procedure TfmQuoteJobList.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  inherited;
end;

initialization
  RegisterClass(TfmQuoteJobList);

finalization
  UnRegisterClass(TfmQuoteJobList);


end.
