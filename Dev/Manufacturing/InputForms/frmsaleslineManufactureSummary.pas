unit frmsaleslineManufactureSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  Shader, ExtCtrls, DNMPanel, StdCtrls, Mask, wwdbedit,
  DB, DBAccess, MyAccess, ERPdbComponents, MemDS, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, DNMSpeedButton , BaseInputForm, BaseFormForm, ProgressDialog, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, wwradiogroup,
  wwclearbuttongroup;

type
  TfmsaleslineManufactureSummary = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    qryMain: TERPQuery;
    qryMainproductname: TWideStringField;
    qryMainSalesuom: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMaincaption: TWideStringField;
    qryMainuom: TWideStringField;
    qryMainTreePartUOMtotalQty: TFloatField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainFromStockUOMQty: TFloatField;
    qryMainInstockQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMainOnOrderUOMQty: TFloatField;
    dsMain: TDataSource;
    wwDBEdit1: TwwDBEdit;
    grdMain: TwwDBGrid;
    Label8: TLabel;
    cmdClose: TDNMSpeedButton;
    qryMainSAleID: TIntegerField;
    Label9: TLabel;
    wwDBEdit6: TwwDBEdit;
    qryMainPartsId: TIntegerField;
    btnEdit: TDNMSpeedButton;
    grpFilters: TwwRadioGroup;
    Label10: TLabel;
    btnPrint: TDNMSpeedButton;
    pnlChooseRpt: TDNMPanel;
    chkChooseRpt: TCheckBox;
    pnlHide: TDNMPanel;
    chkHide: TCheckBox;
    pnlsalesQty: TDNMPanel;
    Bevel3: TBevel;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkHideClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
  private
    fiSalesLineID: Integer;
    //fMyConnection: TERPConnection;

  Protected
    function GetReportTypeID: integer; Override;
    Procedure MakeQrymain;Virtual;
    Procedure OpenQrymain;Virtual;
  public
    Property SalesLineID:Integer read fiSalesLineID write fiSalesLineID;
    //Property MyConnection: TERPConnection read fMyConnection write fMyConnection;
    class Function  ShowSaleslineManufactureSummary(aMyConnection: TERPConnection; aSalesLineID:Integer; showNexttimeShowingOption :Boolean):Integer;
  end;
  function MainSQL: String;

implementation

uses pqalib, AppEnvironment, CommonLib,  ProductQtyLib, tcConst, CommonFormLib,
  tcDataUtils, frmPartsFrm;

{$R *.dfm}

procedure TfmsaleslineManufactureSummary.btnPrintClick(Sender: TObject);
var
  REportToPrint:String;
begin
  inherited;
  REportToPrint := '';
  if chkChooseRpt.Checked then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then
      ReportToPrint := dlgReportSelect.SelectedItems.Text
    else
      exit;
  end;
  if REportToPrint  = '' then ReportToPrint := GetDefaultReport(GetReportTypeID);
  if REportToPrint = '' then exit;
  fbReportSQLSupplied := True;
  try
  PrintTemplateReport(ReportToPrint, companyinfoSQLfortemplate +
                      '~|||~{Details}'+ MainSQL +' where masterId = ' + inttostr(SalesLineID) +' group by PT.proctreeID',
                      not(Devmode) and not(Appenv.Employee.ShowPreview), 1);
  finally
    fbReportSQLSupplied:= False;
  end;
  Self.Close;
end;

procedure TfmsaleslineManufactureSummary.chkHideClick(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = chkHide then begin
    Appenv.Employee.ShowManufacutresummarywhenchangedfromSales := not(chkHide.checked);
  end;
end;
Function MainSQL:String;
begin
  REsult := 'SELECT' +
      ' Sl.SaleLineId, Sl.SAleID,' +
      ' PT.PartsId,' +
      ' SL.productname,' +
      ' concat(SL.UnitofMeasureSaleLines, " (" , SL.UnitofMeasureMultiplier ,")" ) Salesuom,  SL.UnitofMeasureQtySold , SL.UnitofMeasureShipped , SL.UnitofMeasureBackorder,' +
      ' Convert(TreeNodeCaption(Level, caption ),char(255))  as caption,' +
      ' concat(TreePartUOM, " (" , treePartUOMMultiplier ,")" ) uom, ' +
      ' TreePartUOMtotalQty,  ' +
      ' ManufactureUOMQty, ' +
      ' FromStockUOMQty, ' +
      ' OnOrderUOMQty,' +
      ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)  +') AS AvailableQty,' +
      ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock)   +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)  +') AS InstockQty' +
      ' FROM ' + ProductTables(tProductList) +
      '  INNER JOIN  tblproctree   PT on PT.partsId  = P.partsID and PT.masterType <> "mtProduct"' +
      '  INNER JOIN  tblsaleslines SL on PT.masterId = SL.saleLineId ' ;
end;
procedure TfmsaleslineManufactureSummary.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
end;

procedure TfmsaleslineManufactureSummary.FormShow(Sender: TObject);
begin
  inherited;
  OpenQrymain;
  SetControlfocus(grdmain);
end;

function TfmsaleslineManufactureSummary.GetReportTypeID: integer;
begin
  Result:= 131;
end;

procedure TfmsaleslineManufactureSummary.grdMainCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);
begin
  inherited;
  AFont.color  := clBlack;
  if sameText(Field.FieldName ,   qryMainTreePartUOMtotalQty.FieldName) or
    sameText(Field.FieldName ,   qryMainManufactureUOMQty.FieldName) or
    sameText(Field.FieldName ,   qryMainFromStockUOMQty.FieldName) or
    sameText(Field.FieldName ,   qryMainOnOrderUOMQty.FieldName) then begin
      if Field.AsFloat = 0 then Afont.Color := ABrush.Color;
  end;
  if Grpfilters.itemindex = 0 then begin
    if sameText(Field.FieldName ,   qryMainManufactureUOMQty.FieldName) and (qryMainManufactureUOMQty.asFloat <> 0) then ABrush.Color := $00AEFFFF;
    if sameText(Field.FieldName ,   qryMainFromStockUOMQty.FieldName  ) and (qryMainFromStockUOMQty.asfloat   <> 0) then ABrush.Color := $00D7D7FF;
    if sameText(Field.FieldName ,   qryMainOnOrderUOMQty.FieldName    ) and (qryMainOnOrderUOMQty.asfloat     <> 0) then ABrush.Color := $00B3D9FF;
  end;
  if  QrymainpartsID.asInteger > 0 then
    if  sameText(Field.FieldName ,   qryMainManufactureUOMQty.FieldName) or
        sameText(Field.FieldName ,   qryMainFromStockUOMQty.FieldName) or
        sameText(Field.FieldName ,   qryMainOnOrderUOMQty.FieldName) then else
          aBrush.color := $00FFFFCC;

end;

procedure TfmsaleslineManufactureSummary.grdMainDblClick(Sender: TObject);
begin
  inherited;
  if Sametext(TField(grdMain.GetActiveField).fieldname, QrymainOnOrderUOMQty.fieldName) then begin
    OpenERPFormModal('TfrmProductQtyBinETA' , qryMainPartsId.AsInteger);
  end;
end;

procedure TfmsaleslineManufactureSummary.grpFiltersClick(Sender: TObject);
begin
  inherited;
       if Grpfilters.ItemIndex= 0 then qrymain.Filter := ''
  else if Grpfilters.ItemIndex= 1 then qrymain.Filter := qryMainFromStockUOMQty.fieldname + '<> 0'
  else if Grpfilters.ItemIndex= 2 then qrymain.Filter := qryMainManufactureUOMQty.fieldname + '<> 0'
  else if Grpfilters.ItemIndex= 3 then qrymain.Filter := qryMainOnOrderUOMQty.fieldname + '<> 0';
  Qrymain.Filtered := qrymain.Filter <> '';
end;

procedure TfmsaleslineManufactureSummary.MakeQrymain;
begin
  Qrymain.SQL.Clear;
  Qrymain.SQL.Add(mainSQL);
  Qrymain.SQL.Add(' where masterId = :saleLineId');
  Qrymain.SQL.Add(' group by PT.proctreeID');
end;

procedure TfmsaleslineManufactureSummary.OpenQrymain;
begin
  Qrymain.ParamByName('saleLineId').AsInteger := SalesLineID;
  Qrymain.Connection := TransConnection;
  Qrymain.open;
end;

class function TfmsaleslineManufactureSummary.ShowSaleslineManufactureSummary(aMyConnection: TERPConnection; aSalesLineID: Integer; showNexttimeShowingOption :Boolean):Integer;
begin
  With TfmsaleslineManufactureSummary.Create(nil) do try
    TransConnection := aMyConnection;
    SalesLineID := aSalesLineID;
    pnlHide.visible := showNexttimeShowingOption;
    result:= Showmodal ;
  finally
    Free;
  end;
end;


end.

