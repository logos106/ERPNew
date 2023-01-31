unit frmSaleSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, Shader,
  DNMSpeedButton, DNMPanel , ERPdbComponents, DB, MemDS, DBAccess,
  MyAccess;

type
  TfmSaleSummary = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlMain: TDNMPanel;
    shp1: TShape;
    shp2: TShape;
    shp3: TShape;
    dsMain: TDataSource;
    qryMain: TERPQuery;
    qryMainCategory: TLargeintField;
    qryMainseqno: TLargeintField;
    qryMainDescription: TWideStringField;
    qryMainFieldType: TLargeintField;
    qryMainStringValue: TWideStringField;
    qryMainDateValue: TDateTimeField;
    qryMaintimeValue: TDateTimeField;
    qryMainCurrencyValue: TFloatField;
    qryMainFloatValue: TFloatField;
    qryMainValue: TWideStringField;
    pnl_2 : TDNMPanel;    lbl_2_del : TLabel;    lbl_2_caption : TLabel;    lbl_2_data : TEdit;
    pnl_4 : TDNMPanel;    lbl_4_del : TLabel;    lbl_4_caption : TLabel;    lbl_4_data : TEdit;
    pnl_6 : TDNMPanel;    lbl_6_del : TLabel;    lbl_6_caption : TLabel;    lbl_6_data : TEdit;
    pnl_8 : TDNMPanel;    lbl_8_del : TLabel;    lbl_8_caption : TLabel;    lbl_8_data : TEdit;
    pnl_10: TDNMPanel;    lbl_10_del: TLabel;    lbl_10_caption: TLabel;    lbl_10_data: TEdit;
    pnl_12: TDNMPanel;    lbl_12_del: TLabel;    lbl_12_caption: TLabel;    lbl_12_data: TEdit;
    pnl_14: TDNMPanel;    lbl_14_del: TLabel;    lbl_14_caption: TLabel;    lbl_14_data: TEdit;
    pnl_16: TDNMPanel;    lbl_16_del: TLabel;    lbl_16_caption: TLabel;    lbl_16_data: TEdit;
    pnl_18: TDNMPanel;    lbl_18_del: TLabel;    lbl_18_caption: TLabel;    lbl_18_data: TEdit;
    pnl_20: TDNMPanel;    lbl_20_del: TLabel;    lbl_20_caption: TLabel;    lbl_20_data: TEdit;
    pnl_22: TDNMPanel;    lbl_22_del: TLabel;    lbl_22_caption: TLabel;    lbl_22_data: TEdit;
    pnl_24: TDNMPanel;    lbl_24_del: TLabel;    lbl_24_caption: TLabel;    lbl_24_data: TEdit;
    pnl_26: TDNMPanel;    lbl_26_del: TLabel;    lbl_26_caption: TLabel;    lbl_26_data: TEdit;
    pnl_28: TDNMPanel;    lbl_28_del: TLabel;    lbl_28_caption: TLabel;    lbl_28_data: TEdit;
    pnl_30: TDNMPanel;    lbl_30_del: TLabel;    lbl_30_caption: TLabel;    lbl_30_data: TEdit;
    pnl_32: TDNMPanel;    lbl_32_del: TLabel;    lbl_32_caption: TLabel;    lbl_32_data: TEdit;
    pnl_34: TDNMPanel;    lbl_34_del: TLabel;    lbl_34_caption: TLabel;    lbl_34_data: TEdit;
    pnl_36: TDNMPanel;    lbl_36_del: TLabel;    lbl_36_caption: TLabel;    lbl_36_data: TEdit;
    pnl_38: TDNMPanel;    lbl_38_del: TLabel;    lbl_38_caption: TLabel;    lbl_38_data: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
(*    panels :Array of TDnMPanel;
    Captionlabels :Array of TLabel;
    DelimeterLabels :Array of TLabel;
    Datalabels :Array of TLabel;*)
    oncloseForm :TNotifyEvent;
    SaleID:Integer;
    Saletype:String;
    Connection :TERPConnection;
    fbclosebtnclicked: Boolean;

(*    Procedure Cleanform;
    procedure NewPanel;*)
    procedure Resizeit;
    procedure MakeQry;
  public
    Class Function ShowSaleSummary(AOwner :TComponent; SaleID:Integer ; saletype:String; Connection :TERPConnection; oncloseForm :TNotifyEvent): TfmSaleSummary;
    Procedure RefreshQuery;
    Property closebtnclicked :Boolean read fbclosebtnclicked write fbclosebtnclicked;
  end;

implementation

uses CommonDbLib, Sales, tcConst, CommonLib, LogLib, AppEnvironment, MAIN;


{$R *.dfm}

{ TfmSaleSummary }

(*procedure TfmSaleSummary.Cleanform;
var
  ctr:Integer;
begin
  for ctr := high(Captionlabels) downto low(Captionlabels)  do Freeandnil(Captionlabels[ctr]);
  for ctr := high(DelimeterLabels) downto low(DelimeterLabels)  do Freeandnil(DelimeterLabels[ctr]);
  for ctr := high(Datalabels)    downto low(Datalabels)     do Freeandnil(Datalabels[ctr]);
  for ctr := high(panels)        downto low(panels)         do Freeandnil(panels[ctr]);

  SetLength(panels ,0);
  SetLength(Captionlabels ,0);
  SetLength(DelimeterLabels ,0);
  SetLength(Datalabels ,0);

  Finalize(panels );
  Finalize(Captionlabels );
  Finalize(DelimeterLabels );
  Finalize(Datalabels );

end;*)

procedure TfmSaleSummary.cmdCloseClick(Sender: TObject);
begin
  inherited;
  closebtnclicked:= True;
  Self.close;
end;

procedure TfmSaleSummary.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if assigned(oncloseForm) then oncloseForm(Self);
  action := caFree;
end;

procedure TfmSaleSummary.FormCreate(Sender: TObject);
begin
  inherited;
(*  SetLength(panels ,0);
  SetLength(Captionlabels ,0);
  SetLength(DelimeterLabels ,0);
  SetLength(Datalabels ,0);*)
  oncloseForm := nil;
  closebtnclicked:= False;
end;
procedure TfmSaleSummary.FormShow(Sender: TObject);
begin
  inherited;
  Resizeit;
end;

(*procedure TfmSaleSummary.NewPanel ;
var
  ctr:Integer;

begin
    ctr := length(panels)+1;
    SetLength(panels ,ctr);
    SetLength(Captionlabels ,ctr);
    SetLength(DelimeterLabels ,ctr);
    SetLength(Datalabels ,ctr);

    ctr := high(panels);
    panels[ctr] := TDNMPanel.create(Self);
    with panels[ctr] do begin
        Align :=  alTop;
        Height := 20;
        BevelOuter :=  bvNone;
        //BorderWidth :=  1;
        BorderStyle :=  bsnone;
        Font.Charset :=  DEFAULT_CHARSET;
        Font.Color :=  clWindowText;
        Parent := pnlMain;
        Visible := True;
        Transparent := False;
        Parentcolor := True;
        tag := QrymainSeqno.AsInteger;
    end;
    DelimeterLabels[ctr] := TLabel.create(Self);
    with DelimeterLabels[ctr] do begin
      Align :=  alLeft;
      Alignment :=  taCenter;
      AutoSize :=  TRue;
      Caption := ' : ';
      Layout :=  tlCenter;
      font.size := 9;
      Font.style := Font.style +[fsBold];
      Parent := panels[ctr];
      Visible := True;
      Transparent := False;
      Parentcolor := True;
      Left := 0;
    end;

    Captionlabels[ctr] := TLabel.create(Self);
    with Captionlabels[ctr] do begin
      Align :=  alLeft;
      Alignment :=  taRightJustify;
      AutoSize :=  False;
      Caption := qryMainDescription.asString;
      Layout :=  tlCenter;
      font.size := 9;
      Font.style := Font.style +[fsBold];
      Parent := panels[ctr];
      Visible := True;
      Width := 280;
        Transparent := False;
        Parentcolor := True;
      Left := 0;
    end;

    Datalabels[ctr] := TLabel.create(Self);
    with Datalabels[ctr] do begin
      Align :=  alClient;
      AutoSize :=  False;
      Caption := qryMainValue.asString;
      Layout :=  tlCenter;
      if qryMainFieldType.asInteger in [4,5] then  Alignment := taRightJustify else Alignment := taLeftJustify;
      if qryMainseqno.asinteger in [32,38] then begin font.size := 10; Font.style := Font.style +[fsBold]; end else begin font.size := 9; Font.style := Font.style -[fsBold]; end;
      Parent := panels[ctr];
      Visible := True;
      Transparent := False;
      Parentcolor := True;
      Alignwithmargins := True;
      Margins.left :=0;
      Margins.top :=0;
      Margins.bottom :=0;
      Margins.right :=10;

    end;

end;*)
procedure TfmSaleSummary.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  clog(qrymain.sqlText);
end;

procedure TfmSaleSummary.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
        if qryMainFieldType.asinteger = 1 then  qryMainValue.AsString := qryMainStringValue.AsString
  else  if qryMainFieldType.asinteger = 2 then  qryMainValue.AsString := iif(qryMainDateValue.asDatetime = 0 , '' , formatdatetime(FormatSettings.shortdateformat ,qryMainDateValue.asDatetime ))
  else  if qryMainFieldType.asinteger = 3 then  qryMainValue.AsString := iif(qryMainDateValue.asDatetime = 0 , '' , Formatdatetime('hh:nn:ss am/pm', qryMaintimeValue.asDatetime ))
  else  if (qryMainFieldType.asinteger = 4) and (qryMainSeqno.asInteger in [22]) then  qryMainValue.AsString := floattostrF(round(qryMainCurrencyValue.asfloat, TcConst.GeneralRoundPlaces)    , ffGeneral  , 15, TcConst.GeneralRoundPlaces)+'%'
                                                                                                              //floattostrF(qryMainCurrencyValue.asfloat , ffcurrency , 15, AppEnv.RegionalOptions.CurrencyRoundPlaces)
  else  if (qryMainFieldType.asinteger = 4) and (qryMainSeqno.asInteger in [32,38]) then  qryMainValue.AsString := floattostrF(qryMainCurrencyValue.asfloat , ffcurrency , 15, AppEnv.RegionalOptions.CurrencyRoundPlaces)

  else  if qryMainFieldType.asinteger = 4 then  qryMainValue.AsString := floattostrF(qryMainCurrencyValue.asfloat , ffcurrency , 15, AppEnv.RegionalOptions.CurrencyRoundPlaces)
  else  if qryMainFieldType.asinteger = 5 then  qryMainValue.AsString := floattostrF(round(qryMainFloatValue.asfloat, TcConst.GeneralRoundPlaces)    , ffGeneral  , 15, TcConst.GeneralRoundPlaces)
  else qryMainValue.AsString := '';

end;

procedure TfmSaleSummary.RefreshQuery;
var
  ctr:Integer;
  (*pnl,*)lbl_Caption , (*lbl_Del   , *)lbl_data :TComponent;
  s:String;
begin
  closedb(Qrymain);
  try
    Qrymain.ParamByName('SaleId').AsInteger := saleId;
    Qrymain.ParamByName('Saletype').asString := saletype;
  finally
    Opendb(Qrymain);
  end;

(*  closedb(Qrymain);
  Opendb(Qrymain);*)
  //Cleanform;
  if Qrymain.recordcount >0 then begin
    Qrymain.first;
    While Qrymain.eof = False do begin
      //NewPanel;
      s :=trim(inttostr(qrymainSeqno.asInteger));
      //pnl         := findcomponent('pnl_' + s);
      lbl_Caption := findcomponent('lbl_' + s + '_Caption');
      //lbl_Del     := findcomponent('lbl_' + s + '_Del');
      lbl_data    := findcomponent('lbl_' + s + '_data');
      if (*(pnl <> nil) and *)( lbl_Caption<> nil) (*and ( lbl_Del <> nil)*) and (lbl_data <> nil) then begin
        //pnl.visible := true;
        //pnl.top := itop; itop := itop +pnl.height;
        TLabel(lbl_Caption).caption := qrymaindescription.asString;
        TEdit(lbl_Data).Text := qrymainValue.asString;
      end;
      Qrymain.next;
    end;
  end;
  (*shp1.Visible:= False;
  shp2.Visible:= False;
  shp3.Visible:= False;
  if length(Panels) >0 then
    for ctr:= high(Panels) downto low(Panels) do begin
      if  (Panels[ctr].tag < 12) and (shp1.Visible=False) then begin
        shp1.Visible:= True;
        shp1.top := 0;
      end;
      if (Panels[ctr].tag < 18) and (Panels[ctr].tag >= 12) and (shp2.Visible=False) then begin
        shp2.Visible:= True;
        shp2.top := 0;
      end;
      if (Panels[ctr].tag < 24) and (Panels[ctr].tag >=18) and (shp3.Visible=False) then begin
        shp3.Visible:= True;
        shp3.top := 0;
      end;
      Panels[ctr].top := 0;
    end;*)

end;

class function TfmSaleSummary.ShowSaleSummary(AOwner: TComponent;SaleID: Integer; saletype: String;Connection: TERPConnection; oncloseForm :TNotifyEvent): TfmSaleSummary;
begin
  Result := TfmSaleSummary.create(AOwner);
  Result.saleId := SaleId;
  Result.saletype := saletype;
  Result.Connection := Connection;
  Result.oncloseForm := oncloseForm;
  Result.MakeQry;
  Result.FormStyle := fsMDIChild;
  Result.BringToFront;
  Result.WindowState := wsNormal;
end;

Procedure TfmSaleSummary.MakeQry;
var
  s:String;
  Function StringValue  (const value:String;aDateValue:String ='Null'):String; begin Result := '1 as FieldType, '+Value +' as StringValue ,  '+ aDateValue +'        as DateValue , null         as timeValue , null         as CurrencyValue, Null        as FloatValue  ';  end;
  Function DateValue    (const value:String):String; begin Result := '2 as FieldType, null       as StringValue ,  '+ Value +' as DateValue , null         as timeValue , null         as CurrencyValue, Null        as FloatValue  ';  end;
  Function TimeValue    (const value:String):String; begin Result := '3 as FieldType, null       as StringValue ,  null        as DateValue , '+ Value +'  as timeValue , null         as CurrencyValue, Null        as FloatValue  ';  end;
  Function CurrencyValue(const value:String):String; begin Result := '4 as FieldType, null       as StringValue ,  null        as DateValue , null         as timeValue , '+ Value +'  as CurrencyValue, Null        as FloatValue  ';  end;
  Function FloatValue   (const value:String):String; begin Result := '5 as FieldType, null       as StringValue ,  null        as DateValue , null         as timeValue , Null         as CurrencyValue, '+ Value +' as FloatValue  ';  end;
begin


    Qrymain.Connection := Connection;
    closedb(qrymain);
    Qrymain.sql.Clear;
    Qrymain.sql.Add('Select  1 as Category, 2 as seqno , "Entered By" as Description , '+ StringValue('EnteredBy')+' from tblsales where saleId = :SaleId  union all');
    Qrymain.sql.Add('Select  1 as Category, 4 as seqno , "Entered At" as Description , '+ StringValue('EnteredAt')+'   from tblsales where saleId = :SaleId  union all');
    Qrymain.sql.Add('Select * from (Select  1 as Category, 6 as seqno , "Printed By" as Description , '+ StringValue('E.Employeename' , 'PD.PrintDate')+'   ' + ' from tblsales S left join tblprintdocs PD on PD.docname =:SaleType and PD.docid = S.saleId left join tblemployees E on E.EmployeeID = PD.PrintedBy where saleId = :SaleId  Order by DateValue desc limit 1) as Details  union all');
    Qrymain.sql.Add('Select * from (Select  1 as Category, 8 as seqno , "Printed On" as Description , '+ DateValue('PD.PrintDate') + ' from tblsales S left join tblprintdocs PD on PD.docname =:SaleType and PD.docid = S.saleId where saleId = :SaleId  Order by DateValue desc limit 1) as Details  union all');
    Qrymain.sql.Add('Select * from (Select  1 as Category, 10 as seqno , "Printed At" as Description, '+ TimeValue('PD.PrintDate') + 'from tblsales S left join tblprintdocs PD on PD.docname =:SaleType and PD.docid = S.saleId where saleId = :SaleId Order by DateValue desc limit 1) as Details  union all');

    Qrymain.sql.Add('Select 2 as Category, 12 as seqno , "Ordered "      as Description , '+ FloatValue('Sum(SL.Qtysold)')  + ' from tblsaleslines SL where SL.saleId = :SaleId  union all');
    Qrymain.sql.Add('Select 2 as Category, 14 as seqno , "Shipped "      as Description , '+ FloatValue('Sum(SL.Shipped)') + ' from tblsaleslines SL where SL.saleId = :SaleId  union all');
    Qrymain.sql.Add('Select 2 as Category, 16 as seqno , "Backordered "  as Description , '+ FloatValue('Sum(SL.BackOrder)') + ' from tblsaleslines SL where SL.saleId = :SaleId  union all');

    Qrymain.sql.Add('Select 2 as Category, 18 as seqno , "Estimate "      as Description , '+ CurrencyValue('Sum(SL.QtySold * SL.linepriceinc)')  + ' from tblsaleslines SL where SL.saleId = :SaleId  union all');
    Qrymain.sql.Add('Select 2 as Category, 20 as seqno , "Cost "          as Description , '+ CurrencyValue('Sum(SL.LineCost * SL.Shipped* (1+SL.LineTaxRate))')  + ' from tblsaleslines SL where SL.saleId = :SaleId  union all');
    Qrymain.sql.Add('Select 2 as Category, 22 as seqno , "Margin "        as Description , '+ CurrencyValue('(if(S.IsQuote="T",S.TotalQuoteAmount, S.totalAmountinc) - Sum(SL.LineCost * SL.Shipped* (1+SL.LineTaxRate)))/if(S.IsQuote="T",S.TotalQuoteAmount, S.totalAmountinc)')   + ' from tblsaleslines SL  inner join tblsales S on S.saleId = SL.saleId   where SL.saleId = :SaleId Union all');

    Qrymain.sql.Add('Select 3 as Category, 24 as Seqno, "Total Product Discount "  Description, '+ CurrencyValue('0-S.TotalDiscount') + ' from tblsales S where saleid = :SaleId  union all ');
    Qrymain.sql.Add('Select 3 as Category, 26 as Seqno, ' + quotedstr(PAYMENT_DISCOUNT_PRODUCT) +' Description, '+ CurrencyValue('(Sum(ifnull(TotalLineamountinc,0)))') + ' from tblsaleslines SL where saleid = :SaleId  and productname = ' + quotedstr(PAYMENT_DISCOUNT_PRODUCT) +' union all');
    Qrymain.sql.Add('Select 3 as Category, 28 as Seqno, ' + Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +' Description, '+ CurrencyValue(' (Sum(ifnull(TotalLineamountinc,0)))') + ' from tblsaleslines SL where saleid = :SaleId  and productname = ' + Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +' union all');
    Qrymain.sql.Add('Select 3 as Category, 30 as Seqno, ' + Quotedstr(TOTALDISCOUNT_PRODUCT) +' Description, '+ CurrencyValue('(Sum(ifnull(TotalLineamountinc,0)))') + ' from tblsaleslines SL where saleid = :SaleId  and productname = ' + Quotedstr(TOTALDISCOUNT_PRODUCT) +' union all');
    Qrymain.sql.Add('Select 3 as Category, 32 as Seqno, "Sales Total(Before Discount/Markup)" as Description, '+
                              ' '+ CurrencyValue('Totalamountinc - S.totalmarkup -(0- S.TotalDiscount + ifnull((select (Sum(ifnull(TotalLineamountinc,0))) '+
                              ' from tblsaleslines SL where Sl.saleid = S.SaleID '+
                              ' and (productname = ' + quotedstr(PAYMENT_DISCOUNT_PRODUCT) +'  or productname = ' + Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +' or productname = ' + Quotedstr(TOTALDISCOUNT_PRODUCT) +' )),0))') + ' from tblsales S '+
                              ' where saleid = :SaleId   union all');
    Qrymain.sql.Add('Select 3 as Category, 34 as Seqno, "Total Product Markup "  Description,  '+ CurrencyValue('S.totalmarkup') + ' from tblsales S where saleid = :SaleId union all');
    Qrymain.sql.Add('Select 3 as Category, 36 as Seqno, "Total Discount" as Description, '+ CurrencyValue('0- S.TotalDiscount + ifnull((select (Sum(ifnull(TotalLineamountinc,0))) '+
                              ' from tblsaleslines SL where Sl.saleid = S.SaleID '+
                              ' and (productname = ' + quotedstr(PAYMENT_DISCOUNT_PRODUCT) +'  or productname = ' + Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +' or productname = ' + Quotedstr(TOTALDISCOUNT_PRODUCT) +' )),0) ') + ' from tblsales S '+
                              ' where saleid = :SaleId   union all');
    Qrymain.sql.Add('Select 3 as Category, 38 as Seqno , "Sales Total(After Discount/Markup)" as Description , '+ CurrencyValue('S.TotalAmountInc') + ' from tblsales S where saleId = :SaleId');
    Qrymain.sql.Add('Order by Category , Seqno');


    s:= '1: Total Product Discount : Total of "Discount '+AppEnv.RegionalOptions.CurrencySymbol+'" OR "Discount %" Applied to the Lines.'+NL+
        '2: ' +PAYMENT_DISCOUNT_PRODUCT +': Discount applied to the Sale from Customer Payment' +NL+
        '3: ' +EARLY_PAYMENT_DISCOUNT_PRODUCT+': This is the Disount given when the invoice is being paid before Due Date (Based on Terms).'+NL+
        '4: ' +TOTALDISCOUNT_PRODUCT +': This is the Discount applied to Grand Total of the Sale ("Discount '+AppEnv.RegionalOptions.CurrencySymbol+' From Grand Total (Inc)").' + NL+
        '5: Sales Total(Before Discount/Markup) : Total of all Lines before the Discount / Markup Applied.' + NL +
        '6: Total Product Markup : Total of "Markup '+AppEnv.RegionalOptions.CurrencySymbol+'" OR "Markup %" Applied to the Lines.'+NL+
        '7: Total Discount : This is the Total of all types of Discounts Applied to the sale. ie: [1] + [2] + [3] + [4].'+ NL+
        '   Sales Total(After Discount/Markup) : Total Sales Price - Total discounts + Total Markup. ie: [5] - [6] + [7].';
      Showcontrolhint(pnlMain , s );
    RefreshQuery;
end;

procedure TfmSaleSummary.Resizeit;
begin
  if assigned(Owner) and (Owner is TBaseSaleGUI) then begin
      Top   := TBaseSaleGUI(Owner).top;
      //Height:= TBaseSaleGUI(Owner).Height;
      Left  := (MainForm.ClientWidth - width) -20;
  end;
end;

end.
