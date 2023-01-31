unit SalesPQAListByCategory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  ComCtrls;

type
  TSalesPQAListByCategoryGUI = class(TBaseListingGUI)
    qrySalesOrderLineOUT: TERPQuery;
    dsSalesOrderLineOUT: TDataSource;
    qryMainSaleId: TIntegerField;
    qryMainCustomerNAme: TWideStringField;
    qryMainproductname: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainSaleDate: TDateField;
    qrySalesOrderLineOUTpqaid: TIntegerField;
    qrySalesOrderLineOUTtransdate: TDateTimeField;
    qrySalesOrderLineOUTUOMQty: TFloatField;
    qrySalesOrderLineOUTuom: TWideStringField;
    qrySalesOrderLineOUTactive: TWideStringField;
    qrySalesOrderLineOUTbatchno: TWideStringField;
    qrySalesOrderLineOUTbatchQty: TFloatField;
    qrySalesOrderLineOUTBinLocation: TWideStringField;
    qrySalesOrderLineOUTBinNumber: TWideStringField;
    qrySalesOrderLineOUTbinQty: TFloatField;
    qrySalesOrderLineOUTSerialnumber: TWideStringField;
    QryProcTreePartOUT: TERPQuery;
    dsProcTreePartOUT: TDataSource;
    QryProcTreePartOUTpqaid: TIntegerField;
    QryProcTreePartOUTtransdate: TDateTimeField;
    QryProcTreePartOUTUOMQty: TFloatField;
    QryProcTreePartOUTuom: TWideStringField;
    QryProcTreePartOUTactive: TWideStringField;
    QryProcTreePartOUTbatchno: TWideStringField;
    QryProcTreePartOUTbatchQty: TFloatField;
    QryProcTreePartOUTBinLocation: TWideStringField;
    QryProcTreePartOUTBinNumber: TWideStringField;
    QryProcTreePartOUTbinQty: TFloatField;
    QryProcTreePartOUTSerialnumber: TWideStringField;
    qryProcTreePartIN: TERPQuery;
    dsProcTreePartIN: TDataSource;
    qryProcTreePartINpqaid: TIntegerField;
    qryProcTreePartINtransdate: TDateTimeField;
    qryProcTreePartINUOMQty: TFloatField;
    qryProcTreePartINuom: TWideStringField;
    qryProcTreePartINactive: TWideStringField;
    qryProcTreePartINbatchno: TWideStringField;
    qryProcTreePartINbatchQty: TFloatField;
    qryProcTreePartINBinLocation: TWideStringField;
    qryProcTreePartINBinNumber: TWideStringField;
    qryProcTreePartINbinQty: TFloatField;
    qryProcTreePartINSerialnumber: TWideStringField;
    qryProcProgressInIN: TERPQuery;
    dsProcProgressInIN: TDataSource;
    qryProcProgressInINpqaid: TIntegerField;
    qryProcProgressInINtransdate: TDateTimeField;
    qryProcProgressInINUOMQty: TFloatField;
    qryProcProgressInINuom: TWideStringField;
    qryProcProgressInINactive: TWideStringField;
    qryProcProgressInINbatchno: TWideStringField;
    qryProcProgressInINbatchQty: TFloatField;
    qryProcProgressInINBinLocation: TWideStringField;
    qryProcProgressInINBinNumber: TWideStringField;
    qryProcProgressInINbinQty: TFloatField;
    qryProcProgressInINSerialnumber: TWideStringField;
    qryProcProgressOUT: TERPQuery;
    dsProcProgressOUT: TDataSource;
    qrySalesOrderLineOUTProductName: TWideStringField;
    QryProcTreePartOUTProductName: TWideStringField;
    qryProcTreePartINProductName: TWideStringField;
    qryProcProgressInINProductName: TWideStringField;
    qryProcProgressOUTpqaid: TIntegerField;
    qryProcProgressOUTProductName: TWideStringField;
    qryProcProgressOUTtransdate: TDateTimeField;
    qryProcProgressOUTUOMQty: TFloatField;
    qryProcProgressOUTuom: TWideStringField;
    qryProcProgressOUTactive: TWideStringField;
    qryProcProgressOUTbatchno: TWideStringField;
    qryProcProgressOUTbatchQty: TFloatField;
    qryProcProgressOUTBinLocation: TWideStringField;
    qryProcProgressOUTBinNumber: TWideStringField;
    qryProcProgressOUTbinQty: TFloatField;
    qryProcProgressOUTSerialnumber: TWideStringField;
    PageMain: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    dsAllOthers: TDataSource;
    qryAllOthers: TERPQuery;
    qryAllOtherspqaid: TIntegerField;
    qryAllOthersProductName: TWideStringField;
    qryAllOtherstransdate: TDateTimeField;
    qryAllOthersUOMQty: TFloatField;
    qryAllOthersuom: TWideStringField;
    qryAllOthersactive: TWideStringField;
    qryAllOthersbatchno: TWideStringField;
    qryAllOthersbatchQty: TFloatField;
    qryAllOthersBinLocation: TWideStringField;
    qryAllOthersBinNumber: TWideStringField;
    qryAllOthersbinQty: TFloatField;
    qryAllOthersSerialnumber: TWideStringField;
    grdSalesOrderLineOUT: TwwDBGrid;
    wwIButton1: TwwIButton;
    wwDBGrid1: TwwDBGrid;
    wwIButton2: TwwIButton;
    wwDBGrid2: TwwDBGrid;
    wwIButton3: TwwIButton;
    wwDBGrid3: TwwDBGrid;
    wwIButton4: TwwIButton;
    wwDBGrid4: TwwDBGrid;
    wwIButton5: TwwIButton;
    wwDBGrid5: TwwDBGrid;
    wwIButton6: TwwIButton;
    qryAllOtherstranstype: TWideStringField;
    qryAllOthersalloctype: TWideStringField;
    qryProcTreePartINtranstype: TWideStringField;
    lblTabSheet1: TLabel;
    lblTabsheet2: TLabel;
    lblTabSheet3: TLabel;
    lblTabsheet4: TLabel;
    lblTabsheet5: TLabel;
    lblTabsheet6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    fiSaleLineId: Integer;
    procedure SetSaleLineId(const Value: Integer);
    { Private declarations }
  public
    Property SaleLineId :Integer read fiSaleLineId write SetSaleLineId;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, DNMLib, CommonDbLib, LogLib, tcConst;

{$R *.dfm}

procedure TSalesPQAListByCategoryGUI.FormCreate(Sender: TObject);
begin
  fiSaleLineId := 0;
  inherited;
  HaveDateRangeSelection := false;

  Tabsheet1.caption :=(*'TSalesOrderLine - OUT' + chr(13)+chr(10) +*)'Final Product SO Allocation';
  Tabsheet2.caption :=(*'TProcTreePart - OUT' + chr(13)+chr(10) +*)'Raw Material - NOT Done Allocation';
  Tabsheet3.caption :=(*'TProcTreePart - IN' + chr(13)+chr(10) +*)'Sub Build - NOT DONE';
  Tabsheet4.caption :=(*'TProcProgressIn - IN' + chr(13)+chr(10) +*)'Sub Build DONE';
  Tabsheet5.caption :=(*'TProcProgressOUT - OUT' + chr(13)+chr(10) +*)'Raw Material - DONE Allocation';

  lblTabsheet1.caption := 'TSalesOrderLine - OUT' ;
  lblTabsheet2.caption := 'TProcTreePart - OUT' ;
  lblTabsheet3.caption := 'TProcTreePart - IN' ;
  lblTabsheet4.caption := 'TProcProgressIn - IN';
  lblTabsheet5.caption := 'TProcProgressOUT - OUT' ;
  lblTabsheet6.caption := 'Others' ;

  PageMain.activepageindex := 0;
end;

procedure TSalesPQAListByCategoryGUI.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(PageMain, 1);
end;

procedure TSalesPQAListByCategoryGUI.FormShow(Sender: TObject);
begin
  inherited;
  RealignTabControl(PageMain, 1);
end;

procedure TSalesPQAListByCategoryGUI.RefreshQuery;
var
  ctr:Integer;
begin
  for ctr:= 0 to componentcount- 1 do
    if components[ctr] is TERPQuery then
      try
        closedb(TERPQuery(components[ctr]));
        TERPQuery(components[ctr]).Parambyname('SaleLineID').asInteger := SAleLineId;
        OpenDB(TERPQuery(components[ctr]));
      Except
        // kill exception if parameter doesn't exists
      end;
  inherited;
  clog(Qrymain.WrappedSQLtext);
  Logtext(qrySalesOrderLineOUT.wrappedSQLText);
  Logtext(QryProcTreePartOUT.wrappedSQLText);
  Logtext(qryProcTreePartIN.wrappedSQLText);
  Logtext(qryProcProgressInIN.wrappedSQLText);
  Logtext(qryProcProgressOUT.wrappedSQLText);
  Logtext(qryAllOthers.wrappedSQLText);

end;

procedure TSalesPQAListByCategoryGUI.SetSaleLineId(const Value: Integer);
begin
  fiSaleLineId := Value;
end;

initialization
  RegisterClassOnce(TSalesPQAListByCategoryGUI);

end.
