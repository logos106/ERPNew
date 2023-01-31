unit BOMSalesProgressReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TBOMSalesProgressReportGUI = class(TBaseListingGUI)
    qryMainSeqno: TLargeintField;
    qryMainsaleID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMainSequenceDown: TIntegerField;
    qryMainCaption: TWideStringField;
    qryMaintotalQty: TFloatField;
    qryMainPQAID: TIntegerField;
    qryMaintranstype: TWideStringField;
    qryMainCTranstype: TWideStringField;
    qryMainalloctype: TWideStringField;
    qryMainQty: TFloatField;
    qryMainpqatype: TWideStringField;
    qryMainvalue: TWideStringField;
    qryMaincPQAType: TWideStringField;
    qryMainproctreeId: TIntegerField;
    qryMainInqty: TFloatField;
    qryMainOutqty: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fiSaleLineID: Integer;
    fiProctreeID: Integer;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
    Property SaleLineID :Integer read fiSaleLineID write fiSaleLineID;
    Property ProctreeID :Integer read fiProctreeID write fiProctreeID;
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TBOMSalesProgressReportGUI }

procedure TBOMSalesProgressReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SaleLineID := 0;
  ProctreeID := 0;
  HaveDateRangeSelection := False;
  DisableSortoncolumtitleclick := True;
end;

procedure TBOMSalesProgressReportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qrymainseqno.asInteger =0 then DoGreenhighlight(AFont, ABrush)
  else if sametext(Field.fieldname,QrymainsaleID.fieldname) or
          sametext(Field.fieldname,Qrymainproductname.fieldname) or
          sametext(Field.fieldname,QrymainCaption.fieldname) or
          sametext(Field.fieldname,QrymaintotalQty.fieldname) then
     Afont.color := ABrush.color;
  if field is TFloatfield then
    if TFloatfield(Field).asFloat =0 then
      Afont.color := ABrush.color;
  if Sametext(field.fieldname , qrymainqty.fieldname)  then
    if (Qrymaininqty.asfloat<>0) or (Qrymainoutqty.asfloat<>0)  then Afont.color := ABrush.color;

  //if (ProctreeID<>0) and (qryMainproctreeId.asInteger = ProctreeId) then DoRedhighlight(AFont, ABrush);
end;

procedure TBOMSalesProgressReportGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if sametext(qryMainpqatype.asString ,'Batch') then  qryMaincPQAType.asString := 'Batch'
  else if sametext(qryMainpqatype.asString ,'Bin') then  qryMaincPQAType.asString := 'Bin'
  else if sametext(qryMainpqatype.asString ,'SN') then  qryMaincPQAType.asString := 'Serial Number'
  else qryMaincPQAType.asString := '';
end;

procedure TBOMSalesProgressReportGUI.RefreshQuery;
begin
  Qrymain.parambyname('SaleLineID').asInteger := SaleLineID;
  Qrymain.parambyname('ProctreeID').asInteger := ProctreeID;
  inherited;

end;

procedure TBOMSalesProgressReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainSeqno.fieldname);
  RemoveFieldfromGrid(qryMainProductID.fieldname);
  RemoveFieldfromGrid(qryMainSequenceDown.fieldname);
  RemoveFieldfromGrid(qryMaintotalQty.fieldname);
  RemoveFieldfromGrid(qryMaintranstype.fieldname);
  RemoveFieldfromGrid(qryMainpqaid.fieldname);
  RemoveFieldfromGrid(qryMainpqatype.fieldname);
  RemoveFieldfromGrid(qryMainalloctype.fieldname);
  RemoveFieldfromGrid(qryMainproctreeId.fieldname);
end;
initialization
  RegisterClassOnce(TBOMSalesProgressReportGUI);

end.
