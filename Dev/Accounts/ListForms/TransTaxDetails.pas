unit TransTaxDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TTransTaxDetailsGUI = class(TBaseListingGUI)
    qryMainDetails: TLargeintField;
    qryMainSeqno: TIntegerField;
    qryMainTransID: TIntegerField;
    qryMainLineTaxCode: TWideStringField;
    qryMainLineTaxRate: TFloatField;
    qryMainPercentageOn: TWideStringField;
    qryMainTotalLineamount: TFloatField;
    qryMainLineTax: TFloatField;
    qryMainTotalLineAmountinc: TFloatField;
    qryMainDescription: TWideStringField;
    qryMainCapAmount: TFloatField;
    qryMainAmountPerUnit: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainThresholdAmount: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);  Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    fiTransId: Integer;
    fsTranstype: String;
    fiTransLineId: Integer;
    fsTransName: String;
    Refreshingtotals :boolean;
    { Private declarations }
  Protected
    Procedure SetGridColumns;Override;
    Procedure RefreshTotals;Override;
    Procedure CalcFooter; Override;
  public
    Property TransID:Integer read fiTransId write fiTransID;
    Property Transtype :String read fsTranstype Write fsTranstype;
    Property TransLineId :Integer read fiTransLineId write fiTransLineId;
    Property TransName :String read fsTransName write fsTransName;
  end;


implementation

uses CommonLib, BusObjTaxCodes;

{$R *.dfm}

procedure TTransTaxDetailsGUI.CalcFooter;
begin
  if QrymainDetails.asInteger = 2 then exit;
  inherited;

end;

procedure TTransTaxDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
    Refreshingtotals := False;
    fiTransId:=0;
    fsTranstype:='';
    fiTransLineId := 0;
    fsTransName := '';
  AddCalcColumn('LineTax', true);
end;

procedure TTransTaxDetailsGUI.FormShow(Sender: TObject);
begin
  Qrymain.Disablecontrols;
  try
     CloseDB(Qrymain);
     Qrymain.SQL.clear;
     if SameText(Transtype , 'P') then begin
        Qrymain.SQL.add('Select');
        Qrymain.SQL.add('1 as Details,');
        Qrymain.SQL.add('L.Seqno,');
        Qrymain.SQL.add('ifnull(L.ProductName, AccountName) as Description ,');
        Qrymain.SQL.add('L.purchaselineID TransID,');
        Qrymain.SQL.add('L.LineTaxCode,');
        Qrymain.SQL.add('L.LineTaxRate *100 LineTaxRate,');
        Qrymain.SQL.add('0.0 as CapAmount,');
        Qrymain.SQL.add('0.0 as AmountPerUnit,');
        Qrymain.SQL.add('null as UOM,');
        Qrymain.SQL.add('0.0 as ThresholdAmount,');
        Qrymain.SQL.add(Quotedstr(AMOUNT_EX) + ' PercentageOn ,');
        Qrymain.SQL.add('0 as PercentageOnID,');
        Qrymain.SQL.add('L.TotalLineamount,');
        Qrymain.SQL.add('L.LineTax,');
        Qrymain.SQL.add('L.TotalLineAmountinc');
        Qrymain.SQL.add('from  tblpurchaselines L');
        Qrymain.SQL.add('where L.PurchaseOrderID  = '+inttostr(TransID));
        if TransLineId <> 0 then
          Qrymain.SQL.add('and PurchaseLineID  = '+inttostr(TransLineId));
        Qrymain.SQL.add('union');
        Qrymain.SQL.add('Select');
        Qrymain.SQL.add('2 as Details ,');
        Qrymain.SQL.add('L.Seqno,');
        Qrymain.SQL.add('ifnull(L.ProductName, AccountName) as Description ,');
        Qrymain.SQL.add('TTC.PurchaseLineId,');
        Qrymain.SQL.add('TTCL.`SubTaxCode`,');
        Qrymain.SQL.add('TTCL.`Percentage`,');
        Qrymain.SQL.add('TTCL.`CapAmount`,');
        Qrymain.SQL.add('TTCL.AmountPerUnit,');
        Qrymain.SQL.add('TTCL.UOM,');
        Qrymain.SQL.add('TTCL.ThresholdAmount,');
        Qrymain.SQL.add('TTCL.`PercentageOn`,');
        Qrymain.SQL.add('TTCL.`PercentageOnID` as PercentageOnID,');
        Qrymain.SQL.add('0,');
        Qrymain.SQL.add('TTCL.`TaxAmount`,');
        Qrymain.SQL.add('0');
        Qrymain.SQL.add('from `tblpurchasetaxcodelines` TTCL');
        Qrymain.SQL.add('inner join `tblpurchasetaxcodes` TTC on TTCL.PurchaseTaxCodeID = TTC.ID');
        Qrymain.SQL.add('inner join tblpurchaselines L  on L.PurchaseLineID = TTC.PurchaseLineId');
        Qrymain.SQL.add('where TTC.PurchaseOrderID  = '+inttostr(TransID));
        if TransLineId <> 0 then
          Qrymain.SQL.add('and TTC.PurchaseLineID  = '+inttostr(TransLineId));
        Qrymain.SQL.add('order by Seqno , details , `PercentageOnID`');
     end else begin
        Qrymain.SQL.add('Select');
        Qrymain.SQL.add('1 as Details,');
        Qrymain.SQL.add('L.Seqno,');
        Qrymain.SQL.add('ifnull(L.ProductName, "") as Description ,');
        Qrymain.SQL.add('L.SaleID TransID,');
        Qrymain.SQL.add('L.LineTaxCode,');
        Qrymain.SQL.add('L.LineTaxRate *100 LineTaxRate,');
        Qrymain.SQL.add('0.0 as CapAmount,');
        Qrymain.SQL.add('0.0 as AmountPerUnit,');
        Qrymain.SQL.add('null as UOM,');
        Qrymain.SQL.add('0.0 as ThresholdAmount,');
        Qrymain.SQL.add(Quotedstr(AMOUNT_EX) + ' PercentageOn,');
        Qrymain.SQL.add('0 as PercentageOnID,');
        Qrymain.SQL.add('L.TotalLineamount,');
        Qrymain.SQL.add('L.LineTax,');
        Qrymain.SQL.add('L.TotalLineAmountinc');
        Qrymain.SQL.add('from');
        Qrymain.SQL.add('tblsaleslines L');
        Qrymain.SQL.add('where L.SaleID = '+inttostr(TransID));
        if TransLineId <> 0 then
          Qrymain.SQL.add('and SaleLineID  = '+inttostr(TransLineId));
        Qrymain.SQL.add('union');
        Qrymain.SQL.add('Select');
        Qrymain.SQL.add('2 as Details ,');
        Qrymain.SQL.add('L.Seqno,');
        Qrymain.SQL.add('ifnull(L.ProductName, "") as Description ,');
        Qrymain.SQL.add('TTC.SaleID,');
        Qrymain.SQL.add('Concat("   " , TTCL.`SubTaxCode`),');
        Qrymain.SQL.add('TTCL.`Percentage`,');
        Qrymain.SQL.add('TTCL.`CapAmount`,');
        Qrymain.SQL.add('TTCL.AmountPerUnit,');
        Qrymain.SQL.add('TTCL.UOM,');
        Qrymain.SQL.add('TTCL.ThresholdAmount,');
        Qrymain.SQL.add('TTCL.`PercentageOn`,');
        Qrymain.SQL.add('TTCL.`PercentageOnID` as PercentageOnID,');
        Qrymain.SQL.add('0,');
        Qrymain.SQL.add('TTCL.`TaxAmount`,');
        Qrymain.SQL.add('0');
        Qrymain.SQL.add('from tblsalestaxcodelines TTCL');
        Qrymain.SQL.add('inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID');
        Qrymain.SQL.add('inner join tblsaleslines L  on L.SaleLineID = TTC.SaleLineID');
        Qrymain.SQL.add('where TTC.SaleId = '+inttostr(TransID));
        if TransLineId <> 0 then
          Qrymain.SQL.add('and TTC.SaleLineID  = '+inttostr(TransLineId));
        Qrymain.SQL.add('order by Seqno , details , `PercentageOnID`');
     end;
     RefreshOrignalSQL;
  finally
    Qrymain.enablecontrols;
  end;
  inherited;
  if fsTransName <> '' then TitleLabel.Caption :=fsTransName +' # ' + inttostr(TransID);
  if transLineId<>0 then begin
    grpFilters.ItemIndex := 1;
    grpFilters.visible := False;
  end;
end;
procedure TTransTaxDetailsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Grpfilters.ItemIndex = 1 then begin
    if QrymainDetails.AsInteger = 1 then
      Afont.Style := Afont.Style+[fsBold];
    if QrymainDetails.AsInteger = 2 then
      if (SameText(Field.Fieldname ,qryMainTotalLineamount.FieldName)) or (SameText(Field.Fieldname ,qryMainTotalLineAmountinc.FieldName)) then
        Afont.color := ABrush.color;
  end;
  if (SameText(Field.fieldname, 'Description')) and (QrymainDetails.asInteger = 2) then
    Afont.color := ABrush.color;
end;

procedure TTransTaxDetailsGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:GroupFilterString :='Details=1';
    1:GroupFilterString := '';
  end;
  inherited;
end;

procedure TTransTaxDetailsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if Qrymain.Locate('Details' , 2 , []) then begin
    grpFilters.Itemindex := 1;
    grpFilters.visible := True;
  end else begin
    grpFilters.Itemindex := 0;
    grpFilters.visible := False;
  end;
end;

procedure TTransTaxDetailsGUI.RefreshTotals;
(* var
  grpfiltersItemindex:Integer;
  bm:TBookmark; *)
begin
  if Refreshingtotals then exit;
  Refreshingtotals := true;
  try
    CalcnShowFooter;
  (* {totals should be calculatedonly from the summary records as the details sums to the summary rec}
  Qrymain.Disablecontrols;
  try
    bm:=Qrymain.getbookmark;
    try
      grpfiltersItemindex := grpfilters.ItemIndex;
      grpfilters.ItemIndex := 0;
      Try
        CalcnShowFooter;
      Finally
        grpfilters.ItemIndex := grpfiltersItemindex
      End;
    finally
       Qrymain.gotobookmark(bm);
       Qrymain.freebookmark(bm);
    end;
  finally
    Qrymain.Enablecontrols;
  end; *)
  finally
    Refreshingtotals := False;
  end;
end;

procedure TTransTaxDetailsGUI.SetGridColumns;
begin
  RemoveFieldfromGrid('Details');
  RemoveFieldfromGrid('Seqno');
  RemoveFieldfromGrid('transId');
end;


initialization
  RegisterClass(TTransTaxDetailsGUI);

end.

