unit SaleconvertedToList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TSaleconvertedToListGUI = class(TBaseListingGUI)
    qryMainClientId: TIntegerField;
    qryMainSaleno: TWideStringField;
    qryMainSaleId: TIntegerField;
    qryMainBORef: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmountinc: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainSaleDate: TDateField;
    qryMainConverted: TWideStringField;
    qryMainfutureSo: TWideStringField;
    qryMainDone: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainshipdate: TDateField;
    qryMainheld: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainterms: TWideStringField;
    qryMainComments: TWideMemoField;
    qryMainHasSignature: TWideStringField;
    qryMainSaletype: TWideStringField;
    qryMainGlobalref: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    fsSalesOrderRef: String;
    fsQuoteRef: String;
    Procedure MakeQrymain;
  Protected
    procedure SetGridColumns; Override;

  public
    Property SalesOrderRef:String read fsSalesOrderRef write fsSalesOrderRef ;
    Property QuoteRef     :String read fsQuoteRef      write fsQuoteRef;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonDbLib, ProductQtyLib;

{$R *.dfm}

procedure TSaleconvertedToListGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  fsSalesOrderRef:= '';
  fsQuoteRef:= '';
end;

procedure TSaleconvertedToListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
        if  (fsSalesOrderRef<>'') and Sametext(QrymainGlobalref.asString , fsSalesOrderRef) then afont.color := clmaroon
  else  if  (fsQuoteRef     <>'') and Sametext(QrymainGlobalref.asString , fsQuoteRef     ) then afont.color := clmaroon;
end;

procedure TSaleconvertedToListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainsaleType.asString;
  inherited;

end;

procedure TSaleconvertedToListGUI.MakeQrymain;
begin
  closedb(Qrymain);
  Qrymain.SQl.Clear;
  Qrymain.SQl.add('Select Distinct');
  Qrymain.SQl.add('S.clientId         as ClientId,');
  Qrymain.SQl.add('S.Globalref        as Globalref,');
  Qrymain.SQl.add('S.InvoiceDocNumber as Saleno,');
  Qrymain.SQl.add('S.SaleId           as SaleId,');
  Qrymain.SQl.add('S.BOID             as BORef,');
  Qrymain.SQl.add('S.Customername     as CustomerName,');
  Qrymain.SQl.add('S.totalAmountinc   As TotalAmountinc,');
  Qrymain.SQl.add('S.totalAmount      As TotalAmount,');
  Qrymain.SQl.add('S.Payment          As Payment,');
  Qrymain.SQl.add('S.balance          as Balance,');
  Qrymain.SQl.add('S.SaleDate         as SaleDate,');
  Qrymain.SQl.add('S.Converted        as Converted,');
  Qrymain.SQl.add('S.futureSo         as futureSo,');
  Qrymain.SQl.add('S.Deleted          as Done,');
  Qrymain.SQl.add('S.QuoteStatus      as Status,');
  Qrymain.SQl.add('S.ShipDate         as shipdate,');
  Qrymain.SQl.add('S.HoldSale         as held,');
  Qrymain.SQl.add('S.PONumber         as PONumber,');
  Qrymain.SQl.add('S.terms            as terms,');
  Qrymain.SQl.add('S.Comments         as Comments,');
  Qrymain.SQl.add('If(IsNull(ClientSignature),"F","T") as HasSignature,');
  Qrymain.SQl.add(SaleType+ '         as Saletype');
  Qrymain.SQl.add('From tblSales S');
  Qrymain.SQl.add('Where  ifnull(S.salesorderGlobalref  ,"")<> "" and (ifnull(S.salesorderGlobalref ,"") = :SalesOrderRef)');
  Qrymain.SQl.add('OR     ifnull(S.QuoteGlobalref       ,"")<> "" and (ifnull(S.QuoteGlobalref      ,"") = :QuoteRef)');
  Qrymain.SQl.add('OR     ifnull(S.Globalref            ,"")<> "" and (ifnull(S.Globalref           ,"") = :SalesOrderRef)');
  Qrymain.SQl.add('OR     ifnull(S.Globalref            ,"")<> "" and (ifnull(S.Globalref           ,"") = :QuoteRef)');
  Qrymain.SQl.add('Order by SaleId DEsc');
end;

procedure TSaleconvertedToListGUI.RefreshQuery;
begin
  Qrymain.PArambyname('SalesOrderRef').asString := SalesOrderRef;
  Qrymain.PArambyname('QuoteRef').asString := QuoteRef;
  inherited;
end;

procedure TSaleconvertedToListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainclientId.fieldname);
end;

initialization
  RegisterClassOnce(TSaleconvertedToListGUI);
end.
