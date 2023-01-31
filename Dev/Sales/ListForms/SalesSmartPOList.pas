unit SalesSmartPOList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, kbmMemTable,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox;

type
  TSalesSmartPOListGUI = class(TBaseListingGUI)
    qryMainSmartOrderID: TIntegerField;
    qryMainCreationDate: TDateField;
    qryMainSmartOrderDesc: TWideStringField;
    qryMainPARTSNAME: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUnitofMeasure: TWideStringField;
    qryMainQtySold: TFloatField;
    qryMainShipped: TFloatField;
    qryMainTotalLineAmount: TFloatField;
    qryMainBOCost: TFloatField;
    qryMainUnitofMeasurePOLines: TWideStringField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainBackOrder: TFloatField;
    qryMainBackOrdercost: TFloatField;
    qryMainETADate: TDateField;
    qryMainReceivedDate: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    fsSalesRef: String;
    fsSalestype: String;
  Protected
    procedure SetGridColumns; Override;
  public
    Property SalesRef :String read fsSalesRef write fsSalesRef;
    Property Salestype:String read fsSalestype write fsSalestype;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, tcDataUtils;

{$R *.dfm}
procedure TSalesSmartPOListGUI.FormCreate(Sender: TObject);
begin
  inherited;
    fsSalesRef:= '';
    fsSalestype:= '';
end;

procedure TSalesSmartPOListGUI.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Smart/Purchase Order(s) of ' +Salestype +' # ' + inttostr(GetSaleIDForGlobalRef(SalesRef));
  TitleLabel.Caption := 'Smart/Purchase Order(s) of ' +Salestype +' # ' + inttostr(GetSaleIDForGlobalRef(SalesRef));
end;

procedure TSalesSmartPOListGUI.grdMainDblClick(Sender: TObject);
begin
  if Sametext(ActiveFieldName ,qryMainSmartOrderID.fieldName) or
    Sametext(ActiveFieldName ,qryMainCreationDate.fieldName) or
    Sametext(ActiveFieldName ,qryMainSmartOrderDesc.fieldName) or
    Sametext(ActiveFieldName ,qryMainPARTSNAME.fieldName) or
    Sametext(ActiveFieldName ,qryMainClassName.fieldName) or
    Sametext(ActiveFieldName ,qryMainQty.fieldName) or
    Sametext(ActiveFieldName ,qryMainUnitofMeasure.fieldName) then
    SubsequentID := Chr(95) + 'SO' else SubsequentID := Chr(95) + 'PO';
  inherited;
end;

procedure TSalesSmartPOListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryMainBackOrder.asFloat := QryMainQtySold.asfloat -
                                     QryMainShipped.asfloat;
  QryMainBackOrdercost.asFloat :=QryMainBackOrder.asFloat*QryMainBOCost.asFloat;

end;

procedure TSalesSmartPOListGUI.RefreshQuery;
begin
  Qrymain.Parambyname('SalesGlobalref').asString :=SalesRef;
  inherited;
end;

procedure TSalesSmartPOListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('SmartOrderLinesID');
end;

initialization
  RegisterClassOnce(TSalesSmartPOListGUI);
end.

