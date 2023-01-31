unit SalesBuildStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesBuildStatusGUI = class(TBaseListingGUI)
    qryMainsalelineNo: TLargeintField;
    qryMainppNo: TLargeintField;
    qryMainsaleId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainuom: TWideStringField;
    qryMainCaption: TWideStringField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainManufacturedUOMQty: TFloatField;
    qryMaintobebuilt: TFloatField;
    qryMainTotalQty: TFloatField;
    qryMainManufacturingUOMQty: TFloatField;
    qryMaintobeused: TFloatField;
    qryMainProcess: TWideStringField;
    qryMainDuration: TWideMemoField;
    qryMainSingleDuration: TWideMemoField;
    qryMaintotalDuration: TWideMemoField;
    qryMaindoneDuration: TWideMemoField;
    qryMaintobedoneDuration: TWideMemoField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
  private
    fiSaleLineId: integer;
    procedure SetSaleLineId(const Value: integer);
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
    Property SaleLineId :integer read fiSaleLineId  write SetSaleLineId ;
  end;


implementation

uses CommonLib, CommonDbLib;

{$R *.dfm}

{ TSalesBuildStatusGUI }

procedure TSalesBuildStatusGUI.FormCreate(Sender: TObject);
begin
  closedb(qrymain);
  qrymain.SQL.Clear;
  qrymain.SQL.add('select');
  qrymain.SQL.add('convert(@salelineNo:=if(@salelineID <> SlsalelineID,  @salelineNo:= 1 ,  @salelineNo+1), unsigned) as salelineNo,');
  qrymain.SQL.add('  @salelineID := SlsalelineID,');
  qrymain.SQL.add('convert(@ppNo:=if(@PTID <> ifnull(PTID,0) or ifnull(PTID,0)=0,  @ppNo:= 1 ,  @ppNo+1), unsigned) as ppNo,');
  qrymain.SQL.add('  @PTID := ifnull(PTID,0), T.*');
  qrymain.SQL.add(' from (select  Sl.saleId      as saleId,Sl.saleLineId  as SLSaleLineId, PT.proctreeId as PTID ,SL.ProductName as ProductName,');
  qrymain.SQL.add('Concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")" )  as uom ,');
  qrymain.SQL.add('Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) as Caption  ,');
  qrymain.SQL.add('PT.ManufactureUOMQty   as ManufactureUOMQty,');
  qrymain.SQL.add('PT.ManufacturedUOMQty  as ManufacturedUOMQty,');
  qrymain.SQL.add('if(ifnull(PT.ParentId,0)<> 0 , 0, pqa.UOMQty  ) as tobebuilt,');
  qrymain.SQL.add('if(ifnull(PT.ParentId,0)<> 0 , PT.TotalQty , 0) as TotalQty,');
  qrymain.SQL.add('PT.ManufacturingUOMQty as ManufacturingUOMQty,');
  qrymain.SQL.add('if(ifnull(PT.ParentId,0)<> 0 , pqa.UOMQty  , 0) as tobeused  ,');
  qrymain.SQL.add('PS.description as Process ,');
  qrymain.SQL.add('FormatSecondsTotime(ifnull(PP.Duration,0) + ifnull(PP.SetupDuration,0) + ifnull(PP.BreakdownDuration,0))    as Duration,');
  qrymain.SQL.add('FormatSecondsTotime((ifnull(PP.Duration,0) + ifnull(PP.SetupDuration,0) + ifnull(PP.BreakdownDuration,0)) * PT.quantity) as SingleDuration,');
  qrymain.SQL.add('FormatSecondsTotime((ifnull(PP.Duration,0) + ifnull(PP.SetupDuration,0) + ifnull(PP.BreakdownDuration,0)) * PT.totalQty) as totalDuration,');
  qrymain.SQL.add('FormatSecondsTotime((ifnull(PP.Duration,0) + ifnull(PP.SetupDuration,0) + ifnull(PP.BreakdownDuration,0)) * PT.ManufacturedUOMQty ) as doneDuration,');
  qrymain.SQL.add('FormatSecondsTotime((ifnull(PP.Duration,0) + ifnull(PP.SetupDuration,0) + ifnull(PP.BreakdownDuration,0)) * (PT.totalQty-PT.ManufacturedUOMQty )) as tobedoneDuration');
  qrymain.SQL.add('from (SELECT @ppNo:=0) t1,(SELECT @PTID:=0) t2,(SELECT @salelineNo:=0) t3 ,(SELECT @salelineID:=0) t4,');
  qrymain.SQL.add('tblsales S');
  qrymain.SQL.add('inner join tblsaleslines SL on S.saleId = sl.saleId');
  qrymain.SQL.add('inner join tblproctree PT on PT.MasterId = SL.SaleLineID and PT.mastertype <> "mtProduct"');
  qrymain.SQL.add('inner join tblproctreepart PTP on PT.ProcTreeId = PTP.ProcTreeId');
  qrymain.SQL.add('left join tblprocesspart PP on PTP.ProcTreeId = PP.ProcTreeId');
  qrymain.SQL.add('Left join tblProcessstep PS on PS.id = PP.ProcessStepID');
  qrymain.SQL.add('inner join tblpqa pqa on PTP.ProcTreePartId = pqa.TransLineID and pqa.TransType in ("TProctreePart")');
  qrymain.SQL.add('where (Sl.saleLineID = :SaleLineId ) or (:SaleLineId =0 and  S.saleDate Between :DAtefrom and :DateTo)');
  qrymain.SQL.add('Order by S.saleId desc, SL.Productname, PT.sequenceDown, PP.ProcessStepSeq ) T');

  inherited;
  fiSaleLineId := 0;
  HaveDateRangeSelection := TRue;
  DisableSortoncolumtitleclick:= TRue;
end;

procedure TSalesBuildStatusGUI.grdMainCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);
begin
  inherited;
  if qryMainsalelineNo.asinteger >1 then begin
    if sametext(Field.fieldname , qryMainsaleId.FieldName) OR
       sametext(Field.fieldname , qryMainProductName.FieldName) OR
       sametext(Field.fieldname , qryMainuom.FieldName) OR
       sametext(Field.fieldname , qryMainManufactureUOMQty.FieldName) OR
       sametext(Field.fieldname , qryMainManufacturedUOMQty.FieldName) OR
       sametext(Field.fieldname , qryMaintobebuilt.FieldName)(* OR
       sametext(Field.fieldname , qryMainTotalQty.FieldName) OR
       sametext(Field.fieldname , qryMainManufacturingUOMQty.FieldName) OR
       sametext(Field.fieldname , qryMaintobeused.FieldName)*) then begin
          Afont.color := ABrush.color;
       end;
  end else begin
    if sametext(Field.fieldname , qryMainTotalQty.FieldName) OR
       sametext(Field.fieldname , qryMainCaption.FieldName) OR
       sametext(Field.fieldname , qryMainManufacturingUOMQty.FieldName) OR
       sametext(Field.fieldname , qryMaintobeused.FieldName) then begin
         Afont.color := ABrush.color;
    end;
  end;
  if qryMainPPNo.asinteger >1 then begin
    if sametext(Field.fieldname , qryMainCaption.FieldName) OR
       sametext(Field.fieldname , qryMainManufactureUOMQty.FieldName) OR
       sametext(Field.fieldname , qryMainManufacturedUOMQty.FieldName) OR
       sametext(Field.fieldname , qryMaintobebuilt.FieldName) OR
       sametext(Field.fieldname , qryMainTotalQty.FieldName) OR
       sametext(Field.fieldname , qryMainManufacturingUOMQty.FieldName) OR
       sametext(Field.fieldname , qryMaintobeused.FieldName) then begin
      Afont.color := ABrush.color;
    end;
  end;
end;

procedure TSalesBuildStatusGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  Qrymain.ParamByName('SaleLineId').asInteger := SaleLineId;
  inherited;
end;

procedure TSalesBuildStatusGUI.SetGridColumns;
begin
  inherited;
  if not devmode then begin
    RemoveFieldfromGrid(qryMainPPNo.fieldname);
    RemoveFieldfromGrid(qryMainsalelineNo.fieldname);
  end;
end;

procedure TSalesBuildStatusGUI.SetSaleLineId(const Value: integer);
begin
  fiSaleLineId := Value;
  HaveDateRangeSelection := Value = 0;
end;

initialization
  RegisterClassOnce(TSalesBuildStatusGUI);

end.
