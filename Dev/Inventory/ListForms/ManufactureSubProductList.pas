unit ManufactureSubProductList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseInputForm,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TManufactureSubProductListGUI = class(TBaseListingGUI)
    qryMainMainTAXCODE: TWideStringField;
    qryMainMainGlobalRef: TWideStringField;
    qryMainMainPARTSID: TIntegerField;
    qryMainMainPARTTYPE: TWideStringField;
    qryMainMainPRODUCTGROUP: TWideStringField;
    qryMainMainPARTNAME: TWideStringField;
    qryMainMainPARTSDESCRIPTION: TWideStringField;
    qryMainMainPURCHASEDESC: TWideStringField;
    qryMainMainINCOMEACCNT: TWideStringField;
    qryMainMainASSETACCNT: TWideStringField;
    qryMainMainCOGSACCNT: TWideStringField;
    qryMainMainBARCODE: TWideStringField;
    qryMainMainPRODUCTCODE: TWideStringField;
    qryMainMainTAXCODE_1: TWideStringField;
    qryMainMainPURCHTAXCODE: TWideStringField;
    qryMainMainSpecialDiscount: TWideStringField;
    qryMainMainAvgCost: TFloatField;
    qryMainMainSellQTY1: TIntegerField;
    qryMainMainSellQTY2: TIntegerField;
    qryMainMainSellQTY3: TIntegerField;
    qryMainMainPRICE1: TFloatField;
    qryMainMainPRICE2: TFloatField;
    qryMainMainPRICE3: TFloatField;
    qryMainMainWHOLESALEPRICE: TFloatField;
    qryMainMainActive: TWideStringField;
    qryMainMainproductcomment: TWideStringField;
    qryMainSubTAXCODE: TWideStringField;
    qryMainSubGlobalRef: TWideStringField;
    qryMainSubPARTSID: TIntegerField;
    qryMainSubPARTTYPE: TWideStringField;
    qryMainSubPRODUCTGROUP: TWideStringField;
    qryMainSubPARTNAME: TWideStringField;
    qryMainSubPARTSDESCRIPTION: TWideStringField;
    qryMainSubPURCHASEDESC: TWideStringField;
    qryMainSubINCOMEACCNT: TWideStringField;
    qryMainSubASSETACCNT: TWideStringField;
    qryMainSubCOGSACCNT: TWideStringField;
    qryMainSubBARCODE: TWideStringField;
    qryMainSubPRODUCTCODE: TWideStringField;
    qryMainSubTAXCODE_1: TWideStringField;
    qryMainSubPURCHTAXCODE: TWideStringField;
    t: TWideStringField;
    qryMainSubAvgCost: TFloatField;
    qryMainSubSellQTY1: TIntegerField;
    qryMainSubSellQTY2: TIntegerField;
    qryMainSubSellQTY3: TIntegerField;
    qryMainSubPRICE1: TFloatField;
    qryMainSubPRICE2: TFloatField;
    qryMainSubPRICE3: TFloatField;
    qryMainSubWHOLESALEPRICE: TFloatField;
    qryMainSubActive: TWideStringField;
    qryMainSubproductcomment: TWideStringField;
    qryMainSubBuyQTY1: TIntegerField;
    qryMainSubBuyQTY2: TIntegerField;
    qryMainSubBuyQTY3: TIntegerField;
    qryMainSubCOST1: TFloatField;
    qryMainSubCOST2: TFloatField;
    qryMainSubCOST3: TFloatField;
    qryMainSubPREFEREDSUPP: TWideStringField;
    qryMainSubSNTracking: TWideStringField;
    qryMainSubMultipleBins: TWideStringField;
    qryMainSubbatch: TWideStringField;
    qryMainSubAutoBatch: TWideStringField;
    qryMainSubAutoReorder: TWideStringField;
    qryMainQuantity: TFloatField;
    qryMainTotalQty: TFloatField;
    qryMainAddToSale: TWideStringField;
    qryMainPartSource: TWideStringField;
    qryMainselected: TWideStringField;
    qryMainInputType: TWideStringField;
    qryMainPriceinTree: TFloatField;
    qryMainCostinTree: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainparentInputType: TWideStringField;
    qryMainProcess: TWideStringField;
    qryMainProcTreeId: TIntegerField;
    qryMainLabourPrice: TFloatField;
    qryMainHourlyLabourRate: TFloatField;
    qryMainDuration: TWideStringField;
    qryMainSetupDuration: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainSubProductname: TWideStringField;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  Protected
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
  public
    { Public declarations }
  end;


implementation

uses ProductQtyLib, FastFuncs, CommonLib;

{$R *.dfm}

procedure TManufactureSubProductListGUI.AssignKeyId(
  Popupform: TBaseInputGUI);
begin
  if  Sysutils.SameText(copy(grdmain.getActiveField.fieldname, 1,4) , 'main') then
    Popupform.KeyId := qryMain.FieldByName('mainPArtsID').asInteger
  else if  Sysutils.SameText(copy(grdmain.getActiveField.fieldname, 1,3) , 'sub') then
    Popupform.KeyId := qryMain.FieldByName('subPArtsID').asInteger;
  if Popupform.KeyId = 0 then inherited;
end;

procedure TManufactureSubProductListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmParts');
    if Assigned(Form) then begin //if has acess
      with TBaseInputGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TManufactureSubProductListGUI.DNMSpeedButton1Click(Sender: TObject);
var
  strSQL:String;
begin
  inherited;
  strSQL:= '{CompanyInfo} SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,' +
            ' Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN' +
            ' FROM tblCompanyInformation AS CO ~|||~{Details} ' + ManufactureSubProductSQL(QrymainsubpartsId.asInteger);
  ReportSQLSupplied := true;
  PrintTemplateReport('sub Product Tree' , strSQL , False, 1);
end;

procedure TManufactureSubProductListGUI.grdMainDblClick(Sender: TObject);
begin
  if  Sysutils.SameText(copy(grdmain.getActiveField.fieldname, 1,4) , 'main') then
    SubsequentID := '_Main'
  else if  Sysutils.SameText(copy(grdmain.getActiveField.fieldname, 1,3) , 'sub') then
    SubsequentID := '_Sub'
  else SubsequentID := '' ;
  inherited;
end;

initialization
  RegisterClassOnce(TManufactureSubProductListGUI);

end.
