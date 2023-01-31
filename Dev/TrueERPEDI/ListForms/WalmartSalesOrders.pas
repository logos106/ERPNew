unit WalmartSalesOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesorderListExpress, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TWalmartSalesOrdersGUI = class(TSalesorderListExpressGUI)
    qryMaininvid: TIntegerField;
    qryMainWOpurchaseorderId: TWideStringField;
    qryMainWOcustomerorderId: TWideStringField;
    qryMainWOOrderID: TIntegerField;
    lblListHint: TLabel;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    function ExtraFields: String;Override;
    function ExtraTables: String;Override;
    procedure SetGridColumns; Override;
  public
  end;

implementation

uses CommonLib, tcConst, CommonFormLib;

{$R *.dfm}
{ TWalmartSalesOrdersGUI }


{ TWalmartSalesOrdersGUI }

function TWalmartSalesOrdersGUI.ExtraFields: String;
begin
  Result := 'inv.saleId as invid,'+NL+
            'WO.OrderId as WOOrderID,'+NL+
            'WO.purchaseorderId as WOpurchaseorderId,'+NL+
            'WO.customerorderId as WOcustomerorderId,'+NL;
end;

function TWalmartSalesOrdersGUI.ExtraTables: String;
begin
  REsult := 'inner join tblwalmartOrders WO on WO.ERPSalesRef = S.Globalref '+
            ' Left join tblsales Inv on S.globalref = Inv.SalesOrderGlobalRef';

end;
procedure TWalmartSalesOrdersGUI.SetGridColumns;
begin
  inherited;
   RemoveFieldfromGrid(qryMainWOOrderID.fieldname);
end;

procedure TWalmartSalesOrdersGUI.FormCreate(Sender: TObject);
begin
  inherited;
  lblListHint.caption := 'This is the List of ERP Sales Orders Created from Walmart Orders.';
end;

procedure TWalmartSalesOrdersGUI.grdMainDblClick(Sender: TObject);
begin
  if Sametext(activeFieldname, qrymaininvid.fieldname) and (qrymaininvid.asInteger <> 0) then begin
    OpenERPForm('TInvoiceGUI' , qrymaininvid.asInteger);
    Exit;
  end;
  if Sametext(activeFieldname, qryMainWOpurchaseorderId.fieldname) or Sametext(activeFieldname, qryMainWOcustomerorderId.fieldname)  then begin
    OpenERPForm('TFmWalmartOrder' , qryMainWOOrderID.asInteger);
    Exit;
  end;
  inherited;
end;


initialization
  RegisterClassOnce(TWalmartSalesOrdersGUI);

end.
