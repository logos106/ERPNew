unit salesOrderInvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TsalesOrderInvoicesGUI = class(TBaseListingGUI)
    qryMainDetails: TLargeintField;
    qryMainSaleId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmount: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainInvTotalAmount: TFloatField;
    qryMainInvTotalAmountInc: TFloatField;
    qryMainSaleLineId: TIntegerField;

    qryMainProductName: TWideStringField;
    qryMainProduct_Description: TWideStringField;
    qryMainSOLUOM: TWideStringField;
    qryMainsoQtysold: TFloatField;
    qryMainsoQtyshipped: TFloatField;
    qryMainsobo: TFloatField;
    qryMainsoamtEx: TFloatField;
    qryMainsoAmtinc: TFloatField;

    qryMainInvUOM: TWideStringField;
    qryMaininvQtySold: TFloatField;
    qryMaininvQtyshipped: TFloatField;
    qryMaininvBO: TFloatField;
    qryMaininvoicedon: TDateTimeField;
    qryMainEmployeename: TWideStringField;
    qryMaininvAmtEx: TFloatField;
    qryMaininvAmtinc: TFloatField;
    qryMainTotalamttoBeinvoiced: TFloatField;
    qryMaintotalSOAmttobeInvoiced: TFloatField;
    qryMainInvshipped: TFloatField;
    qryMaintobeshipped: TFloatField;
    qryMainSOInvoicedAmt: TFloatField;
    qryMainSOShipped: TFloatField;
    qryMainInvID: TIntegerField;
    qryMainInvDEsc: TWideStringField;

    DNMPanel1: TDNMPanel;
    Label4: TLabel;
    chkshowconverted: TwwCheckBox;
    qryMainconverted: TWideStringField;
    qryMainIsInternalOrder: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure chkshowconvertedClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
  private
    fiSaleID :Integer;
    fiSaleLineId :Integer;

    function InvoiceChangeMsgforSO(WithLineBreaks:boolean = false): String;
    function InvoiceChangeMsgforInv(WithLineBreaks:boolean = false): String;
  Protected
    procedure SetGridColumns; override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
  public
    Property SaleID :Integer read fiSaleID write fiSaleID;
    Property SaleLineId :Integer read fiSaleLineId write fiSaleLineId;
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib,  CommonDbLib, tcConst, CommonFormLib, math, SystemLib, MemoDialog;

{$R *.dfm}

{ TsalesOrderInvoicesGUI }

procedure TsalesOrderInvoicesGUI.chkshowconvertedClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TsalesOrderInvoicesGUI.FormCreate(Sender: TObject);
begin
  fiSaleID :=0;
    fiSaleLineId :=0;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
end;

procedure TsalesOrderInvoicesGUI.FormShow(Sender: TObject);
begin
  inherited;
  chkIgnoreDates.Visible := saleId =0;
  cboDateRange.Visible := saleId =0;
  lblFrom.Visible := saleId =0;
  dtFrom.Visible := saleId =0;
  lblTo.Visible := saleId =0;
  dtTo.Visible := saleId =0;
  TimerMsg(FilterLabel , 'Lines in ''Red'' colour means that the Partial shipment Invoices are changed for either Quantity, Amount or Both.' +
                            ' Double click on the ' + Quotedstr(Qrymaininvdesc.displaylabel)+' for details.' + NL +
                            '''Green'' colour indicates the invoices of the Sales Order line(Product) that you choose for the report.', 30);
end;

procedure TsalesOrderInvoicesGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;

    {main}
    if sameText(field.fieldname ,     qryMainDetails.FieldName) or
       sameText(field.fieldname ,     qryMainSaleId.FieldName) or
       sameText(field.fieldname ,     qryMainCustomerName.FieldName) or
       sameText(field.fieldname ,     qryMainTotalAmount.FieldName) or
       sameText(field.fieldname ,     qryMainTotalAmountInc.FieldName) or
       sameText(field.fieldname ,     qryMainInvTotalAmount.FieldName) or
       sameText(field.fieldname ,     qryMainInvTotalAmountInc.FieldName) or
       sameText(field.fieldname ,     qryMainTotalamttoBeinvoiced.FieldName) or
       sameText(field.fieldname ,     qryMainSaleLineId.FieldName) then
        aBrush.Color := $00FFD5FF;
    {Sales Order}
    if sameText(field.fieldname ,     qryMainProductName.FieldName) or
       sameText(field.fieldname ,     qryMainProduct_Description.FieldName) or
       sameText(field.fieldname ,     qryMainSOLUOM.FieldName) or
       sameText(field.fieldname ,     qryMainsoQtysold.FieldName) or
       sameText(field.fieldname ,     qryMainsoQtyshipped.FieldName) or
       sameText(field.fieldname ,     qryMainsobo.FieldName) or
       sameText(field.fieldname ,     qryMainsoamtEx.FieldName) or
       sameText(field.fieldname ,     qryMainsoAmtinc.FieldName) then
       Abrush.Color := $00FFFFD5;
    {invoice}
    if sameText(field.fieldname ,     qryMainInvUOM.FieldName) or
       sameText(field.fieldname ,     qryMaininvQtySold.FieldName) or
       sameText(field.fieldname ,     qryMaininvQtyshipped.FieldName) or
       sameText(field.fieldname ,     qryMaininvBO.FieldName) or
       sameText(field.fieldname ,     qryMaininvoicedon.FieldName) or
       sameText(field.fieldname ,     qryMainEmployeename.FieldName) or
       sameText(field.fieldname ,     qryMaininvAmtEx.FieldName) or
       sameText(field.fieldname ,     qryMaininvAmtinc.FieldName) or
       sameText(field.fieldname ,     qryMainInvID.FieldName) or
       sameText(field.fieldname ,     qryMainInvDEsc.FieldName) then
       Abrush.Color := $00B3FFFF;
    {Shipment}
    if sameText(field.fieldname ,     qryMainSOShipped.FieldName) or
       sameText(field.fieldname ,     qryMainInvshipped.FieldName) or
       sameText(field.fieldname ,     qryMaintobeshipped.FieldName) or
       sameText(field.fieldname ,     qryMaintotalSOAmttobeInvoiced.FieldName) or
       sameText(field.fieldname ,     qryMainSOInvoicedAmt.FieldName) then
       Abrush.Color := $00D2E1FF;




  {show the selected saleLine in green colour}
  if QrymainsaleLineId.AsInteger = SaleLineId then
    if ((grpfilters.itemindex = 2) and (qrymaindetails.AsInteger=3) and
        ( sameTExt(field.fieldname ,     qryMaininvQtySold.fieldname) or
          sameTExt(field.fieldname ,     qryMaininvQtyshipped.fieldname) or
          sameTExt(field.fieldname ,     qryMaininvId.fieldname) or
          sameTExt(field.fieldname ,     qryMaininvBO.fieldname) or
          sameTExt(field.fieldname ,     qryMaininvoicedon.fieldname) or
          sameTExt(field.fieldname ,     qryMainEmployeename.fieldname) or
          sameTExt(field.fieldname ,     qryMainInvDEsc.fieldname) or
          sameTExt(field.fieldname ,     qryMaininvAmtEx.fieldname) or
          sameTExt(field.fieldname ,     qryMaininvAmtinc.fieldname) or
          sameTExt(field.fieldname ,     qryMainInvUOM.fieldname))) or
       ((grpfilters.itemindex = 1) and
        (sameTExt(field.fieldname ,     qryMainsoQtysold.fieldname) or
         sameTExt(field.fieldname ,     qryMainsoQtyshipped.fieldname) or
         sameTExt(field.fieldname ,     qryMainsobo.fieldname) or
         sameTExt(field.fieldname ,     qryMainsoamtEx.fieldname) or
         sameTExt(field.fieldname ,     qryMaintobeshipped.fieldname) or
         sameTExt(field.fieldname ,     qryMaintotalSOAmttobeInvoiced.FieldName) or
         sameTExt(field.fieldname ,     qryMainInvshipped.FieldName) or
         sameTExt(field.fieldname ,     qryMainSOInvoicedAmt.FieldName) or
         sameTExt(field.fieldname ,     qryMainsoAmtinc.fieldname))) then begin
        AFont.color := clTeal;
        AFont.Style := AFont.Style +[fsBold];
      end;

  {hide colums irrelevant to the level - ie details 1 / 2 / 3}
  if qrymaindetails.asInteger <> 1 then
    if sameTExt(field.fieldname ,     qryMainCustomerName.fieldname) or
       sameTExt(field.fieldname ,     qryMainTotalAmount.fieldname) or
       sameTExt(field.fieldname ,     qryMainTotalAmountInc.fieldname) or
       sameTExt(field.fieldname ,     qryMainInvTotalAmount.fieldname) or
       sameTExt(field.fieldname ,     qryMainInvTotalAmountInc.fieldname) then
       Afont.color := ABrush.color;
  if qrymaindetails.asInteger <> 2 then
    if sameTExt(field.fieldname ,     qryMainInvshipped.fieldname) then
      Afont.color := ABrush.color;

  if (qrymaindetails.asInteger = 3)then
    if sameTExt(field.fieldname ,     qryMainProductName.fieldname) or
       sameTExt(field.fieldname ,     qryMainProduct_Description.fieldname) or
       sameTExt(field.fieldname ,     qryMainSOLUOM.fieldname) or
       sameTExt(field.fieldname ,     qryMainsoQtysold.fieldname) or
       sameTExt(field.fieldname ,     qryMainsoQtyshipped.fieldname) or
       sameTExt(field.fieldname ,     qryMainsobo.fieldname) or
       sameTExt(field.fieldname ,     qryMainsoamtEx.fieldname) or
       SameText(field.FieldName , QrymainSOShipped.FieldName) or
       SameText(field.FieldName , Qrymaintobeshipped.FieldName) or
       SameText(field.FieldName , QrymainSOInvoicedAmt.FieldName) or
       SameText(field.FieldName , QrymaintotalSOAmttobeInvoiced.FieldName) or
       sameTExt(field.fieldname ,     qryMainsoAmtinc.fieldname) then
       Afont.color := ABrush.color;

  { fields in red colour if the invoice is changed in qty / amount}
  if (qryMainIsInternalOrder.asBoolean =False ) then begin
      if (qrymaindetails.asInteger = 2) then
        if  (not SameValue(QrymainSOShipped.AsFloat , qryMainInvshipped.AsFloat , power(0.1, GeneralRoundPlaces))) or
            (not SameValue(qryMainSOInvoicedAmt.asfloat,qryMainInvTotalAmountInc.AsFloat,Power(0.1, CurrencyRoundPlaces))) then
          if  SameText(field.FieldName , QrymainSOShipped.FieldName) or
              SameText(field.FieldName , Qrymaintobeshipped.FieldName) or
              SameText(field.FieldName , QrymainSOInvoicedAmt.FieldName) or
              SameText(field.FieldName , QrymaintotalSOAmttobeInvoiced.FieldName) then begin
            AFont.color := clRed;
            AFont.Style := AFont.Style +[fsBold];
          end;
      if (qrymaindetails.asInteger = 3) then
        if  (not SameValue(QrymainSOShipped.AsFloat , qryMainInvshipped.AsFloat , power(0.1, GeneralRoundPlaces))) or
            (not SameValue(qryMainSOInvoicedAmt.asfloat,qryMainInvTotalAmountInc.AsFloat, Power(0.1, CurrencyRoundPlaces))) then
          if  SameText(field.FieldName , Qrymaininvoicedon.FieldName) or
              SameText(field.FieldName , QrymainEmployeename.FieldName) or
              SameText(field.FieldName , QrymainInvDEsc.FieldName) or
              SameText(field.FieldName , Qrymaininvid.FieldName) or
              SameText(field.FieldName , QrymainInvUOM.FieldName) or
              SameText(field.FieldName , QrymaininvQtySold.FieldName) or
              SameText(field.FieldName , QrymaininvQtyshipped.FieldName) or
              SameText(field.FieldName , QrymaininvBO.FieldName) or
              SameText(field.FieldName , QrymaininvAmtEx.FieldName) or
              SameText(field.FieldName , QrymaininvAmtinc.FieldName) then begin
              AFont.color := clRed;
              AFont.Style := AFont.Style +[fsBold];
          end;
  end;
end;

procedure TsalesOrderInvoicesGUI.grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
    {main}
    if sameText(AFieldName ,     qryMainDetails.FieldName) or
       sameText(AFieldName ,     qryMainSaleId.FieldName) or
       sameText(AFieldName ,     qryMainCustomerName.FieldName) or
       sameText(AFieldName ,     qryMainTotalAmount.FieldName) or
       sameText(AFieldName ,     qryMainTotalAmountInc.FieldName) or
       sameText(AFieldName ,     qryMainInvTotalAmount.FieldName) or
       sameText(AFieldName ,     qryMainInvTotalAmountInc.FieldName) or
       sameText(AFieldName ,     qryMainTotalamttoBeinvoiced.FieldName) or
       sameText(AFieldName ,     qryMainSaleLineId.FieldName) then
        aBrush.Color := $00FFD5FF;
    {Sales Order}
    if sameText(AFieldName ,     qryMainProductName.FieldName) or
       sameText(AFieldName ,     qryMainProduct_Description.FieldName) or
       sameText(AFieldName ,     qryMainSOLUOM.FieldName) or
       sameText(AFieldName ,     qryMainsoQtysold.FieldName) or
       sameText(AFieldName ,     qryMainsoQtyshipped.FieldName) or
       sameText(AFieldName ,     qryMainsobo.FieldName) or
       sameText(AFieldName ,     qryMainsoamtEx.FieldName) or
       sameText(AFieldName ,     qryMainsoAmtinc.FieldName) then
       Abrush.Color := $00FFFFD5;
    {invoice}
    if sameText(AFieldName ,     qryMainInvUOM.FieldName) or
       sameText(AFieldName ,     qryMaininvQtySold.FieldName) or
       sameText(AFieldName ,     qryMaininvQtyshipped.FieldName) or
       sameText(AFieldName ,     qryMaininvBO.FieldName) or
       sameText(AFieldName ,     qryMaininvoicedon.FieldName) or
       sameText(AFieldName ,     qryMainEmployeename.FieldName) or
       sameText(AFieldName ,     qryMaininvAmtEx.FieldName) or
       sameText(AFieldName ,     qryMaininvAmtinc.FieldName) or
       sameText(AFieldName ,     qryMainInvID.FieldName) or
       sameText(AFieldName ,     qryMainInvDEsc.FieldName) then
       Abrush.Color := $00B3FFFF;
    {Shipment}
    if sameText(AFieldName ,     qryMainSOShipped.FieldName) or
       sameText(AFieldName ,     qryMainInvshipped.FieldName) or
       sameText(AFieldName ,     qryMaintobeshipped.FieldName) or
       sameText(AFieldName ,     qryMaintotalSOAmttobeInvoiced.FieldName) or
       sameText(AFieldName ,     qryMainSOInvoicedAmt.FieldName) then
       Abrush.Color := $00D2E1FF;


end;

function TsalesOrderInvoicesGUI.InvoiceChangeMsgforSO(WithLineBreaks:boolean = false):String;
function LineBreak:String;
begin
  if WithLineBreaks then result := NL else result := '';
end;
begin
    if  (not SameValue(QrymainSOShipped.AsFloat , qryMainInvshipped.AsFloat , power(0.1, GeneralRoundPlaces))) and
        (not SameValue(qryMainSOInvoicedAmt.asfloat,qryMainInvTotalAmountInc.AsFloat, Power(0.1, CurrencyRoundPlaces))) then
        result  := 'Total ''Parial shipment'' for Sales Order#' + inttostr(QrymainsaleId.asInteger) +' was ' +LineBreak+
                                  quotedstr(floatTostrF(QrymainSOShipped.asfloat,ffGeneral, 15, CurrencyRoundPlaces) + ' ' + qryMainSOLUOM.asString)+
                                  ' for ' + floattostrF(qryMainSOInvoicedAmt.asfloat,ffCurrency, 15, CurrencyRoundPlaces)+'.'+LineBreak+LineBreak+
                                  'Both Quantity and Sales Amount are changed in its invoice(s) to ' + LineBreak+Quotedstr(FloatTostrF(qryMainInvshipped.asFloat,ffGeneral, 15, CurrencyRoundPlaces))+
                                  ' for ' + floattostrF(qryMainInvTotalAmountInc.asfloat,ffCurrency, 15, CurrencyRoundPlaces)+'.'
    else if  (not SameValue(QrymainSOShipped.AsFloat , qryMainInvshipped.AsFloat , power(0.1, GeneralRoundPlaces)))  then
        result  := 'Total ''Parial shipment'' for Sales Order#' + inttostr(QrymainsaleId.asInteger) +' was ' +
                                  quotedstr(floatTostrF(QrymainSOShipped.asfloat,ffGeneral, 15, CurrencyRoundPlaces) + ' ' + qryMainSOLUOM.asString)+'.'+LineBreak+LineBreak+
                                  'The Quantity is changed in its invoice(s) to ' + Quotedstr(FloatTostrF(qryMainInvshipped.asFloat,ffGeneral, 15, CurrencyRoundPlaces))+ '.'
    else     if  (not SameValue(qryMainSOInvoicedAmt.asfloat,qryMainInvTotalAmountInc.AsFloat, Power(0.1, CurrencyRoundPlaces))) then
        result  := 'Total ''Parial shipment'' for Sales Order#' + inttostr(QrymainsaleId.asInteger) +' was for ' + floattostrF(qryMainSOInvoicedAmt.asfloat,ffCurrency, 15, CurrencyRoundPlaces)+'.'+LineBreak+LineBreak+
                                  'The Sales Amount is changed in its invoice(s) to ' + Quotedstr(FloatTostrF(qryMainInvshipped.asFloat,ffGeneral, 15, CurrencyRoundPlaces))+
                                  ' for ' + floattostrF(qryMainInvTotalAmountInc.asfloat,ffCurrency, 15, CurrencyRoundPlaces)+'.'
    else
      REsult :='';
end;
function TsalesOrderInvoicesGUI.InvoiceChangeMsgforInv(WithLineBreaks:boolean = false):String;
function LineBreak:String;
begin
  if WithLineBreaks then result := NL else result := '';
end;
begin
    if  (QrymainSOShipped.AsFloat <> qryMainInvshipped.AsFloat) and
        (not SameValue(qryMainSOInvoicedAmt.asfloat,qryMainInvTotalAmountInc.AsFloat, Power(0.1, CurrencyRoundPlaces))) then
      result := '''Parial shipment'' of Sales Order#' + inttostr(QrymainsaleId.asInteger) +
                             ' was  ' +LineBreak+quotedstr(floatTostrF(QrymainSOShipped.asfloat,ffGeneral, 15, CurrencyRoundPlaces) + ' ' + qryMainSOLUOM.asString)+
                             ' for ' + floattostrF(qryMainSOInvoicedAmt.asfloat,ffCurrency, 15, CurrencyRoundPlaces)+'.' +LineBreak+LineBreak+
                             'Both Quantity and Sales Amount are changed in its invoice#' +inttostr(QrymainInvID.asInteger)+' to ' + LineBreak+quotedstr(floattostrF(qryMainInvshipped.AsFloat,ffGeneral, 15, CurrencyRoundPlaces) +' ' + QrymainInvUOM.asString) +
                             ' for  ' + floattostrF(qryMainInvTotalAmountInc.asfloat,ffCurrency, 15, CurrencyRoundPlaces)+'.'
    else if  (QrymainSOShipped.AsFloat <> qryMainInvshipped.AsFloat)  then
      result := '''Parial shipment'' of Sales Order#' + inttostr(QrymainsaleId.asInteger) +
                             ' was  ' +quotedstr(floatTostrF(QrymainSOShipped.asfloat,ffGeneral, 15, CurrencyRoundPlaces) + ' ' + qryMainSOLUOM.asString)+LineBreak+LineBreak+
                             'The Quantity is changed in its invoice#' +inttostr(QrymainInvID.asInteger)+' to ' + quotedstr(floattostrF(qryMainInvshipped.AsFloat,ffGeneral, 15, CurrencyRoundPlaces) +' ' + QrymainInvUOM.asString) +'.'
    else if   (not SameValue(qryMainSOInvoicedAmt.asfloat,qryMainInvTotalAmountInc.AsFloat, Power(0.1, CurrencyRoundPlaces))) then
      result := '''Parial shipment'' of Sales Order#' + inttostr(QrymainsaleId.asInteger) +
                             ' was for ' + floattostrF(qryMainSOInvoicedAmt.asfloat,ffCurrency, 15, CurrencyRoundPlaces)+'.' +LineBreak+LineBreak+
                             'The Sales Amount is changed in its invoice#' +inttostr(QrymainInvID.asInteger)+' to ' + floattostrF(qryMainInvTotalAmountInc.asfloat,ffCurrency, 15, CurrencyRoundPlaces)+'.'
    else
      REsult :='';
end;
procedure TsalesOrderInvoicesGUI.grdMainDblClick(Sender: TObject);
begin
  if Sametext(ActiveFieldname , QrymainInvdesc.FieldName ) and (trim(QrymainInvdesc.AsString) <> '') then begin
         if qrymaindetails.AsFloat = 2 then  DoMemoDialogReadonly('Parial Invoice - changed after creation' , InvoiceChangeMsgforSO(true))
    else if qrymaindetails.AsFloat = 3 then  DoMemoDialogReadonly('Parial Invoice - changed after creation' , InvoiceChangeMsgforInv(true));
    Exit;
  end else if (qrymaindetails.asInteger = 2) then
    if  (not SameValue(QrymainSOShipped.AsFloat , qryMainInvshipped.AsFloat , power(0.1, GeneralRoundPlaces))) or
        (not SameValue(qryMainSOInvoicedAmt.asfloat,qryMainInvTotalAmountInc.AsFloat, Power(0.1, CurrencyRoundPlaces))) then
      if  SameText(activeFieldName , QrymainSOShipped.FieldName) or
          SameText(activeFieldName , Qrymaintobeshipped.FieldName) or
          SameText(activeFieldName , QrymainSOInvoicedAmt.FieldName) or
          SameText(activeFieldName , QrymaintotalSOAmttobeInvoiced.FieldName) then begin
          if MessageDlgXP_vista(InvoicechangeMsgForSo(true)+NL+NL+
                                  'Do you wish to open the Sales Order#' + inttostr(QrymainsaleId.asInteger) +'?', mtConfirmation, [mbyes,mbno], 0) = mryes then
            OpenERPForm('TSalesOrderGUI' , QrymainsaleId.AsInteger);
          Exit;
      end;
  if (qrymaindetails.asInteger = 3) then
    if  (QrymainSOShipped.AsFloat <> qryMainInvshipped.AsFloat) or
        (not SameValue(qryMainSOInvoicedAmt.asfloat,qryMainInvTotalAmountInc.AsFloat, Power(0.1, CurrencyRoundPlaces))) then
      if  SameText(activeFieldName , Qrymaininvoicedon.FieldName) or
          SameText(activeFieldName , QrymainInvID.FieldName) or
          SameText(activeFieldName , QrymainEmployeename.FieldName) or
          SameText(activeFieldName , QrymainInvDEsc.FieldName) or
          SameText(activeFieldName , QrymainInvUOM.FieldName) or
          SameText(activeFieldName , QrymaininvQtySold.FieldName) or
          SameText(activeFieldName , QrymaininvQtyshipped.FieldName) or
          SameText(activeFieldName , QrymaininvBO.FieldName) or
          SameText(activeFieldName , QrymaininvAmtEx.FieldName) or
          SameText(activeFieldName , QrymaininvAmtinc.FieldName) then begin
          if MessageDlgXP_vista(InvoiceChangeMsgforInv(true) +NL+NL+
                             'Do you wish to open the Invoice #' +inttostr(QrymainInvID.asInteger)+'?', mtConfirmation, [mbyes,mbNo], 0) = mryes then
            OpenERPForm('TInvoiceGUI' , QrymainInvID.AsInteger);
          Exit;
      end;
      if  SameText(activeFieldName , Qrymaininvoicedon.FieldName) or
          SameText(activeFieldName , QrymainInvID.FieldName) or
          SameText(activeFieldName , QrymainEmployeename.FieldName) or
          SameText(activeFieldName , QrymainInvDEsc.FieldName) or
          SameText(activeFieldName , QrymainInvUOM.FieldName) or
          SameText(activeFieldName , QrymaininvQtySold.FieldName) or
          SameText(activeFieldName , QrymaininvQtyshipped.FieldName) or
          SameText(activeFieldName , QrymaininvBO.FieldName) or
          SameText(activeFieldName , QrymaininvAmtEx.FieldName) or
          SameText(activeFieldName , QrymaininvAmtinc.FieldName) then
           OpenERPForm('TInvoiceGUI' , QrymainInvID.AsInteger)
      else  OpenERPForm('TSalesOrderGUI' , QrymainsaleId.AsInteger);
end;

procedure TsalesOrderInvoicesGUI.grpFiltersClick(Sender: TObject);
begin
  if grpfilters.itemindex =0 then groupfilterString := 'details =1'
  else if grpfilters.itemindex =1 then groupfilterString := 'details =1 or details = 2'
  else if grpfilters.itemindex =2 then groupfilterString := 'details =1 or details = 2 or details = 3';
  inherited;
end;


procedure TsalesOrderInvoicesGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMaininvoicedon.DisplayFormat := FormatSettings.ShortDateFormat;
  qryMain.Last;
  qryMain.First;
end;

procedure TsalesOrderInvoicesGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qrymaindetails.AsInteger = 1 then
    qryMainTotalamttoBeinvoiced.AsFloat := qryMainTotalAmountInc.AsFloat - qryMainInvTotalAmountInc.AsFloat
  else if qrymaindetails.AsFloat = 2 then begin
    qryMaintotalSOAmttobeInvoiced.AsFloat := qryMainsoAmtinc.AsFloat - qryMainSOInvoicedAmt.AsFloat;
    qryMaintobeshipped.AsFloat := qryMainsoQtyshipped.AsFloat - qryMainsoshipped.AsFloat;
    if grpfilters.itemindex = 1 then  qrymainInvdesc.asString := InvoiceChangeMsgforSO(false);
  end else if qrymaindetails.AsFloat = 3 then begin
    qrymainInvdesc.asString := InvoiceChangeMsgforInv(false);
  end;
end;

procedure TsalesOrderInvoicesGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.Showconverted') then
      chkShowconverted.checked :=  GuiPrefs.Node['Options.Showconverted'].asBoolean;
end;

procedure TsalesOrderInvoicesGUI.RefreshQuery;
begin
  Qrymain.parambyname('SaleID').asInteger       := SaleId;
  Qrymain.parambyname('DateFrom').asDatetime    := filterDateFrom;
  Qrymain.parambyname('Dateto').asDatetime      := filterDateto;
  Qrymain.parambyname('ShowConverted').AsString := BooleanToStr(chkShowconverted.Checked);
  inherited;
end;

procedure TsalesOrderInvoicesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainDetails.fieldname);
  RemoveFieldfromGrid(QrymainSalelineID.fieldname);
  RemoveFieldfromGrid(qryMainInvshipped.fieldname);
end;

procedure TsalesOrderInvoicesGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.ShowConverted'].asBoolean:= chkShowConverted.checked;
end;

initialization
  RegisterClassOnce(TsalesOrderInvoicesGUI);

end.

