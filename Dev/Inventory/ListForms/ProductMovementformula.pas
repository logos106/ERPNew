unit ProductMovementformula;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox;

type
  TProductMovementformulaGUI = class(TBaseListingGUI)
    qryMainSeqno: TLargeintField;
    qryMainTransID: TIntegerField;
    qryMaintranslineId: TIntegerField;
    qryMainTransDate: TDateField;
    qryMainPARTSID: TIntegerField;
    qryMainPARTSNAME: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainQty: TFloatField;
    qryMainFormulaQtyValue1: TFloatField;
    qryMainFormulaQtyValue2: TFloatField;
    qryMainFormulaQtyValue3: TFloatField;
    qryMainFormulaQtyValue4: TFloatField;
    qryMainFormulaQtyValue5: TFloatField;
    qryMainCategory: TWideStringField;
    qryMainDescription: TWideStringField;
    cboPartsQry: TERPQuery;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    cboPart: TwwDBLookupCombo;
    cboPartsQryPARTSID: TIntegerField;
    cboPartsQryPartName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboPartCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fiProductId: Integer;
    procedure MakeQuery;
    procedure SetProductID(const Value: Integer);
  Protected
    procedure SetGridColumns; Override;
    procedure AdjustDisplayLabels; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;

  public
    Property ProductID :Integer read fiProductId write SetProductID;

  end;


implementation

uses CommonLib, ProductQtyLib,  AppEnvironment;

{$R *.dfm}

procedure TProductMovementformulaGUI.AdjustDisplayLabels;
begin
    qryMainFormulaQtyValue1.Displaylabel := Appenv.CompanyPrefs.PartCalcField1Name;
    qryMainFormulaQtyValue2.Displaylabel := Appenv.CompanyPrefs.PartCalcField2Name;
    qryMainFormulaQtyValue3.Displaylabel := Appenv.CompanyPrefs.PartCalcField3Name;
    qryMainFormulaQtyValue4.Displaylabel := Appenv.CompanyPrefs.PartCalcField4Name;
    qryMainFormulaQtyValue5.Displaylabel := Appenv.CompanyPrefs.PartCalcField5Name;
  inherited;
end;

procedure TProductMovementformulaGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainSeqno.fieldName);
  RemoveFieldfromGrid(qryMaintranslineId.fieldName);
  RemoveFieldfromGrid(qryMainPartsId.fieldName);
  if not Appenv.CompanyPrefs.PartCalcfield1Visible then RemoveFieldfromGrid(qryMainFormulaQtyValue1.fieldName);
  if not Appenv.CompanyPrefs.PartCalcfield2Visible then RemoveFieldfromGrid(qryMainFormulaQtyValue2.fieldName);
  if not Appenv.CompanyPrefs.PartCalcfield3Visible then RemoveFieldfromGrid(qryMainFormulaQtyValue3.fieldName);
  if not Appenv.CompanyPrefs.PartCalcfield4Visible then RemoveFieldfromGrid(qryMainFormulaQtyValue4.fieldName);
  if not Appenv.CompanyPrefs.PartCalcfield5Visible then RemoveFieldfromGrid(qryMainFormulaQtyValue5.fieldName);
end;

procedure TProductMovementformulaGUI.SetProductID(const Value: Integer);
begin
  fiProductId := Value;
  if cboPartsQry.active = false then cboPartsQry.open;
  if cboPartsQry.Locate('PartsID' , Value, []) then begin
    cboPart.text :=cboPartsQryPartName.asString;
    fiProductID := cboPartsQryPartsID.asInteger;
    MakeQuery;
  end;
end;

procedure TProductMovementformulaGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['General.ProductName'].AsString:=cboPart.text;
end;

procedure TProductMovementformulaGUI.cboPartCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  cboPartsQry.Locate('PartName' , cboPart.text , []);
  fiProductID := cboPartsQryPartsID.asInteger;
  MakeQuery;
  RefreshQuery;
end;

procedure TProductMovementformulaGUI.FormCreate(Sender: TObject);
begin
  fiProductId:=0;
  MakeQuery;
  inherited;
  if not ErrorOccurred then begin
    cboPartsQry.Connection := qryMain.Connection;
    cboPartsQry.Open;
    cboPartsQry.first;
  end;
end;
procedure TProductMovementformulaGUI.MakeQuery;
begin
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select  ');
  Qrymain.SQL.add('1                    as Seqno,  ');
  Qrymain.SQL.add('SL.SmartOrderID      as TransID,   ');
  Qrymain.SQL.add('SL.SmartOrderLinesID as translineId,    ');
  Qrymain.SQL.add('"Smart Order"        as Category ,   ');
  Qrymain.SQL.add('SO.CreationDate      as TransDate,   ');
  Qrymain.SQL.add('SO.SmartOrderDesc    as Description,   ');
  Qrymain.SQL.add('SL.PARTSID           as PartsId,   ');
  Qrymain.SQL.add('SL.PARTSNAME         as PartsName,   ');
  Qrymain.SQL.add(UOM('SL.UnitofMeasure','SL.UnitofMeasureMultiplier')+' as  UOM ,   ');
  Qrymain.SQL.add('Sum(SL.UnitofMeasureQty) as Qty,     ');
  Qrymain.SQL.add('SL.FormulaQtyValue1      as FormulaQtyValue1,');
  Qrymain.SQL.add('SL.FormulaQtyValue2      as FormulaQtyValue2,');
  Qrymain.SQL.add('SL.FormulaQtyValue3      as FormulaQtyValue3,');
  Qrymain.SQL.add('SL.FormulaQtyValue4      as FormulaQtyValue4,');
  Qrymain.SQL.add('SL.FormulaQtyValue5      as FormulaQtyValue5');
  Qrymain.SQL.add('from  tblsmartorderlines SL inner join tblsmartorder SO  on SL.SmartOrderID = SO.SmartOrderID   ');
  Qrymain.SQL.add('where Sl.converted = "F"   ');
  if ProductId <> 0 then Qrymain.SQL.add('and SL.PartsId = ' +inttostr(ProductId));
  Qrymain.SQL.add('group by SL.FormulaQtyValue1 , SL.FormulaQtyValue2 , SL.FormulaQtyValue3, SL.FormulaQtyValue4, SL.FormulaQtyValue5 , SL.UnitOfMeasureID' );

  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('Select ');
  Qrymain.SQL.add('2 ,');
  Qrymain.SQL.add('PL.purchaseorderId, ');
  Qrymain.SQL.add('PL.purchaselineID,  ');
  Qrymain.SQL.add(''+ TransBOType(POType('PO'), 'PL.UnitofMeasureShipped') +', ');
  Qrymain.SQL.add('PO.OrderDate ,');
  Qrymain.SQL.add('"" , ');
  Qrymain.SQL.add('PL.ProductID , ');
  Qrymain.SQL.add('PL.ProductName , ');
  Qrymain.SQL.add(''+UOM('PL.UnitofMeasurePOLines','PL.UnitofMeasureMultiplier')+' UOM , ');
  Qrymain.SQL.add('Sum(if(ifnull(PL.UnitofMeasureShipped,0)<> 0  , ');
  Qrymain.SQL.add('PL.UnitofMeasureShipped , ');
  Qrymain.SQL.add('PL.UnitofMeasureBackorder)) qty  , ');
  Qrymain.SQL.add('if(ifnull(PL.Shipped,0)=0 , PL.FormulaQtySoldValue1,PL.FormulaQtyShippedValue1),');
  Qrymain.SQL.add('if(ifnull(PL.Shipped,0)=0 , PL.FormulaQtySoldValue2,PL.FormulaQtyShippedValue2),');
  Qrymain.SQL.add('if(ifnull(PL.Shipped,0)=0 , PL.FormulaQtySoldValue3,PL.FormulaQtyShippedValue3),');
  Qrymain.SQL.add('if(ifnull(PL.Shipped,0)=0 , PL.FormulaQtySoldValue4,PL.FormulaQtyShippedValue4),');
  Qrymain.SQL.add('if(ifnull(PL.Shipped,0)=0 , PL.FormulaQtySoldValue5,PL.FormulaQtyShippedValue5)');
  Qrymain.SQL.add('from tblpurchaselines PL inner join tblpurchaseorders PO on PL.PurchaseOrderID = Po.PurchaseOrderID  ');
  Qrymain.SQL.add('where PL.deleted="F" and PO.Deleted="F" and PO.Cancelled="F"  ');
  if ProductId <> 0 then Qrymain.SQL.add('and PL.ProductID= ' +inttostr(ProductId));
  Qrymain.SQL.add('group by '+
                    ' if(ifnull(PL.Shipped,0)=0 , PL.FormulaQtySoldValue1,PL.FormulaQtyShippedValue1),'+
                    ' if(ifnull(PL.Shipped,0)=0 , PL.FormulaQtySoldValue2,PL.FormulaQtyShippedValue2),'+
                    ' if(ifnull(PL.Shipped,0)=0 , PL.FormulaQtySoldValue3,PL.FormulaQtyShippedValue3),'+
                    ' if(ifnull(PL.Shipped,0)=0 , PL.FormulaQtySoldValue4,PL.FormulaQtyShippedValue4),'+
                    ' if(ifnull(PL.Shipped,0)=0 , PL.FormulaQtySoldValue5,PL.FormulaQtyShippedValue5), PL.UnitofMeasureMultiplier, '+ TransBOType(POType('PO'), 'PL.UnitofMeasureShipped')  );
  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('Select ');
  Qrymain.SQL.add('3 ,');
  Qrymain.SQL.add('SL.SaleId, ');
  Qrymain.SQL.add('SL.SaleLineID,  ');
  Qrymain.SQL.add(''+ TransBOType(Saletype('S'), 'SL.UnitofMeasureShipped') +', ');
  Qrymain.SQL.add('S.SAleDate, ');
  Qrymain.SQL.add('"" , ');
  Qrymain.SQL.add('SL.ProductID , ');
  Qrymain.SQL.add('SL.ProductName , ');
  Qrymain.SQL.add(''+UOM('SL.UnitofMeasureSaleLines','SL.UnitofMeasureMultiplier')+' UOM , ');
  Qrymain.SQL.add('sum(if(ifnull(SL.UnitofMeasureShipped,0)<> 0  , SL.UnitofMeasureShipped , SL.UnitofMeasureBackorder)) qty  , ');
  Qrymain.SQL.add('if(ifnull(SL.Shipped,0)=0 , SL.FormulaQtySoldValue1,SL.FormulaQtyShippedValue1),');
  Qrymain.SQL.add('if(ifnull(SL.Shipped,0)=0 , SL.FormulaQtySoldValue2,SL.FormulaQtyShippedValue2),');
  Qrymain.SQL.add('if(ifnull(SL.Shipped,0)=0 , SL.FormulaQtySoldValue3,SL.FormulaQtyShippedValue3),');
  Qrymain.SQL.add('if(ifnull(SL.Shipped,0)=0 , SL.FormulaQtySoldValue4,SL.FormulaQtyShippedValue4),');
  Qrymain.SQL.add('if(ifnull(SL.Shipped,0)=0 , SL.FormulaQtySoldValue5,SL.FormulaQtyShippedValue5)');
  Qrymain.SQL.add('from tblsales S inner join tblsaleslines SL on S.SAleId = SL.SaleId where SL.deleted="F" and S.Deleted="F" and S.Cancelled="F"  ');
  if ProductId <> 0 then Qrymain.SQL.add('and SL.ProductID  = ' +inttostr(ProductId));
  Qrymain.SQL.add('group by '+
                    'if(ifnull(SL.Shipped,0)=0 , SL.FormulaQtySoldValue1,SL.FormulaQtyShippedValue1),'+
                    'if(ifnull(SL.Shipped,0)=0 , SL.FormulaQtySoldValue2,SL.FormulaQtyShippedValue2),'+
                    'if(ifnull(SL.Shipped,0)=0 , SL.FormulaQtySoldValue3,SL.FormulaQtyShippedValue3),'+
                    'if(ifnull(SL.Shipped,0)=0 , SL.FormulaQtySoldValue4,SL.FormulaQtyShippedValue4),'+
                    'if(ifnull(SL.Shipped,0)=0 , SL.FormulaQtySoldValue5,SL.FormulaQtyShippedValue5), '+
                    'SL.UnitofMeasureMultiplier,'+ TransBOType(Saletype('S'), 'SL.UnitofMeasureShipped')) ;

  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('Select  ');
  Qrymain.SQL.add('4 ,');
  Qrymain.SQL.add('RP.RepairID , ');
  Qrymain.SQL.add('RP.RepairPartsID,  ');
  Qrymain.SQL.add('"Repair" , ');
  Qrymain.SQL.add('R.CreationDate, ');
  Qrymain.SQL.add('"", ');
  Qrymain.SQL.add('RP.PartsID , ');
  Qrymain.SQL.add('RP.PartName,   ');
  Qrymain.SQL.add(''+UOM('RP.UnitofMeasure ','RP.UnitofMeasureMultiplier ')+' UOM , ');
  Qrymain.SQL.add('sum(RP.UOMQty ) Qty   , ');
  Qrymain.SQL.add('RP.FormulaQtyValue1 , ');
  Qrymain.SQL.add('RP.FormulaQtyValue2 , ');
  Qrymain.SQL.add('RP.FormulaQtyValue3, ');
  Qrymain.SQL.add('RP.FormulaQtyValue4, ');
  Qrymain.SQL.add('RP.FormulaQtyValue5 ');
  Qrymain.SQL.add('from  tblrepairs R inner join tblrepairparts RP on R.RepairID = RP.RepairID where RP.Deleted = "F"   ');
  if ProductId <> 0 then Qrymain.SQL.add('and RP.PartsID = ' +inttostr(ProductId));
  Qrymain.SQL.add('group by RP.FormulaQtyValue1 , RP.FormulaQtyValue2 , RP.FormulaQtyValue3, RP.FormulaQtyValue4, RP.FormulaQtyValue5 , RP.UnitofMeasureMultiplier ' );

  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('Select  ');
  Qrymain.SQL.add('5 , ');
  Qrymain.SQL.add('SL.StockmovementID , ');
  Qrymain.SQL.add('SL.StockmovementLinesID , ');
  Qrymain.SQL.add(StockMovementType('SM') +' , ');
  Qrymain.SQL.add('SM.MovementDate , ');
  Qrymain.SQL.add('"" , ');
  Qrymain.SQL.add('SL.ProductID , ');
  Qrymain.SQL.add('SL.ProductName,');
  Qrymain.SQL.add(UOM('SL.UOM','SL.UOMMultiplier')+' UOM , ');
  Qrymain.SQL.add('sum(SL.UOMQty ) Qty   , ');
  Qrymain.SQL.add('SL.FormulaQtyValue1 , ');
  Qrymain.SQL.add('SL.FormulaQtyValue2 , ');
  Qrymain.SQL.add('SL.FormulaQtyValue3, ');
  Qrymain.SQL.add('SL.FormulaQtyValue4, ');
  Qrymain.SQL.add('SL.FormulaQtyValue5 ');
  Qrymain.SQL.add('from  tblstockmovement SM inner join tblstockmovementlines SL on SM.StockmovementID = SL.StockmovementID  ');
  if ProductId <> 0 then Qrymain.SQL.add('and SL.ProductID  = ' +inttostr(ProductId));
  Qrymain.SQL.add('group by SL.FormulaQtyValue1 , SL.FormulaQtyValue2 , SL.FormulaQtyValue3, SL.FormulaQtyValue4, SL.FormulaQtyValue5 , SL.UOMID , '+StockMovementType('SM')  );

  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('Select ');
  Qrymain.SQL.add('6 ,');
  Qrymain.SQL.add('S.SaleID , ');
  Qrymain.SQL.add('PT.ProcTreeId , ');
  Qrymain.SQL.add('"build" , ');
  Qrymain.SQL.add('S.SaleDate , ');
  Qrymain.SQL.add('"", ');
  Qrymain.SQL.add('PT.PartsId , ');
  Qrymain.SQL.add('PT.Caption,  ');
  Qrymain.SQL.add(UOM('PT.TreePartUOM','PT.TreePartUOMMultiplier ')+' UOM , ');
  Qrymain.SQL.add('Sum(PT.ManufactureUOMQty ) qty  , ');
  Qrymain.SQL.add('PT.FormulaQtyValue1 , ');
  Qrymain.SQL.add('PT.FormulaQtyValue2 , ');
  Qrymain.SQL.add('PT.FormulaQtyValue3, ');
  Qrymain.SQL.add('PT.FormulaQtyValue4, ');
  Qrymain.SQL.add('PT.FormulaQtyValue5 ');
  Qrymain.SQL.add('from tblsales S inner join tblsaleslines SL on S.SAleId = SL.SaleId inner join tblproctree PT on Sl.SaleLineId	= PT.masterID and PT.Mastertype <> "mtProduct" 	');
  Qrymain.SQL.add('where SL.deleted="F" and S.Deleted="F" and S.Cancelled="F" and ifnull(PT.ManufactureUOMQty , 0)<> 0 and ifnull(PT.PartsId,0)<> 0 ');
  if ProductId <> 0 then Qrymain.SQL.add('and PT.PartsId = ' +inttostr(ProductId));
  Qrymain.SQL.add('group by PT.FormulaQtyValue1 , PT.FormulaQtyValue2 , PT.FormulaQtyValue3, PT.FormulaQtyValue4, PT.FormulaQtyValue5 , PT.TreePartUOMMultiplier') ;
  RefreshOrignalSQL;
end;


procedure TProductMovementformulaGUI.ReadnApplyGuiPrefExtra;
var
  s:String;
begin
  inherited;
  if fiProductID =0 then begin
    s:=GuiPrefs.Node['General.ProductName'].AsString;
    if s<> '' then begin
       if cboPartsQry.active = false then cboPartsQry.open;
        if cboPart.text <> s then begin
          cboPart.text:=s;
          cboPartCloseUp(cboPart ,cboPart.LookupTable , nil,  True);
        end;
    end;
  end;
end;

procedure TProductMovementformulaGUI.FormShow(Sender: TObject);
begin
  inherited;
  if cboPartsQry.active = false then cboPartsQry.open;

end;

procedure TProductMovementformulaGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if SameText(field.FieldName ,    qryMainFormulaQtyValue1.FieldName) or
     SameText(field.FieldName ,    qryMainFormulaQtyValue2.FieldName) or
     SameText(field.FieldName ,    qryMainFormulaQtyValue3.FieldName) or
     SameText(field.FieldName ,    qryMainFormulaQtyValue4.FieldName) or
     SameText(field.FieldName ,    qryMainFormulaQtyValue5.FieldName) then
     if field.AsFloat = 0 then AFont.Color := Abrush.Color;
end;

initialization
  RegisterClassOnce(TProductMovementformulaGUI);
end.

