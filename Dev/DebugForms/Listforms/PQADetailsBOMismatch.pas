
unit PQADetailsBOMismatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox;

type
  TPQADetailsBOMismatchGUI = class(TBaseListingGUI)
    qryMainGlobalref: TWideStringField;
    qryMainTransId: TIntegerField;
    qryMainTransLineId: TIntegerField;
    qryMainQtysold: TFloatField;
    qryMainShipped: TFloatField;
    qryMainBackOrder: TFloatField;
    qryMainBaseLineno: TIntegerField;
    btndelete: TDNMSpeedButton;
    qryMainPQAID: TIntegerField;
    btnInactivate: TDNMSpeedButton;
    qryMainActive: TWideStringField;
    qryMainboid: TWideStringField;
    qryMainbaseno: TWideStringField;
    procedure btndeleteClick(Sender: TObject);
    procedure btnInactivateClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);override;
  private
    fsOriginalno: String;
    fiProductId: Integer;
    fsTransType: String;
    fsglobalref: String;
    fiSeqno: Integer;
    { Private declarations }
  public
    Property Originalno :String REad fsOriginalno write fsOriginalno;
    Property globalref :String REad fsglobalref write fsglobalref;
    Property ProductId:Integer read fiProductId write fiProductId;
    Property TranStype :String read fsTransType write fsTranstype;
    Property Seqno :Integer read fiSeqno write fiSeqno;
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, busobjOrders, ProductQtyLib, CommonDbLib;

{$R *.dfm}
{ TPQADetailsBOMismatchGUI }

procedure TPQADetailsBOMismatchGUI.btndeleteClick(Sender: TObject);
var
  st:TStringList;
begin
  inherited;
  st:= TStringlist.create;
  try
    (* st.add('insert ignore into erpfix_pqa_fixed Select * from tblPQa where PQAId = ' +inttostr(QrymainPQAId.asInteger)+';'); *)
        st.add('insert ignore into erpfix_pqa_fixed '+
            ' (`GlobalRef`, `PQAID`, `TransLineID`, `TransType`, `TransDate`, `Alloctype`, `IsBO`, `Qty`, `UOMQty`, `UOM`, `UOMMultiplier`, `UOMID`, `DepartmentID`, `ProductID`, `ProductName`, `Active`, `TransID`, `Reserved`, `msTimeStamp`, `MatrixRef` , fixtype)'+
            ' Select `GlobalRef`, `PQAID`, `TransLineID`, `TransType`, `TransDate`, `Alloctype`, `IsBO`, `Qty`, `UOMQty`, `UOM`, `UOMMultiplier`, `UOMID`, `DepartmentID`, `ProductID`, `ProductName`, `Active`, `TransID`, `Reserved`, `msTimeStamp`, `MatrixRef` , 1 '+
            ' from tblPQa where PQAId = ' +inttostr(QrymainPQAId.asInteger)+';');

    st.add('delete from tblPQa where PQAId = ' +inttostr(QrymainPQAId.asInteger)+';');
    ExecuteSQL(st.text);
    RefreshQuery;
  finally
    freeandnil(st);
  end;
end;

procedure TPQADetailsBOMismatchGUI.btnInactivateClick(Sender: TObject);
var
  st:TStringList;
begin
  inherited;
  st:= TStringlist.create;
  try
(*     if not(TableExists('erpfix_pqa_fixed')) then
      st.add(CreateTableSQL('erpfix_pqa_fixed' , 'tblpqa')+';'); *)
    st.add('insert ignore into erpfix_pqa_fixed '+
            ' (`GlobalRef`, `PQAID`, `TransLineID`, `TransType`, `TransDate`, `Alloctype`, `IsBO`, `Qty`, `UOMQty`, `UOM`, `UOMMultiplier`, `UOMID`, `DepartmentID`, `ProductID`, `ProductName`, `Active`, `TransID`, `Reserved`, `msTimeStamp`, `MatrixRef` , fixtype)'+
            ' Select `GlobalRef`, `PQAID`, `TransLineID`, `TransType`, `TransDate`, `Alloctype`, `IsBO`, `Qty`, `UOMQty`, `UOM`, `UOMMultiplier`, `UOMID`, `DepartmentID`, `ProductID`, `ProductName`, `Active`, `TransID`, `Reserved`, `msTimeStamp`, `MatrixRef`  , 2'+
            ' from tblPQa where PQAId = ' +inttostr(QrymainPQAId.asInteger)+';');
    st.add('update tblPQa Set Active = "F" where PQAId = ' +inttostr(QrymainPQAId.asInteger)+';');
    ExecuteSQL(st.text);
    RefreshQuery;
  finally
    freeandnil(st);
  end;

end;

procedure TPQADetailsBOMismatchGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrymainGlobalref.asString  = Globalref then AFont.color := clred;
end;

procedure TPQADetailsBOMismatchGUI.grdMainDblClick(Sender: TObject);
begin
  if Sametext(ActiveFieldNAme , 'Active') then
    if MessageDlgxp_vista('Do You Wish To make this PQA record Inactive?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
      btnInactivate.click;
      exit;
    end;
  inherited;

end;

procedure TPQADetailsBOMismatchGUI.RefreshQuery;
begin
  CloseDB(Qrymain);
  Qrymain.SQL.clear;
  if transtype = TPurchaseOrderLine.classname then begin
    Qrymain.SQL.add('Select ');
    Qrymain.SQL.add('PQA.PQAID, ');
    Qrymain.SQL.add('PQA.Active, ');
    Qrymain.SQL.add('PO.Globalref, ');
    Qrymain.SQL.add('PO.BOID,');
    Qrymain.SQL.add('PO.baseno,');
    Qrymain.SQL.add('PL.PurchaseOrderID as TransId , ');
    Qrymain.SQL.add('PL.PurchaseLineID as TransLineId, ');
    Qrymain.SQL.add('PL.Qtysold , ');
    Qrymain.SQL.add('PL.Shipped, ');
    Qrymain.SQL.add('PL.BackOrder , ');
    Qrymain.SQL.add('PL.BaseLineno ');
    Qrymain.SQL.add('From tblPurchaseOrders PO ');
    Qrymain.SQL.add('inner join tblpurchaselines PL on PO.PurchaseOrderId = PL.PurchaseOrderID ');
    Qrymain.SQL.add('inner join tblPQa PQA on PQa.Transid = PL.PurchaseOrderID and PQA.TransLineID = PL.PurchaseLineID and PQA.TransType in ('+quotedstr(TPurchaseOrderLine.classname) +')');
    Qrymain.SQL.add('Where PO.Originalno = '+Quotedstr(Originalno));
    Qrymain.SQL.add('and PL.ProductId = '+inttostr(ProductId));
    Qrymain.SQL.add('and PL.Seqno = '+ inttostr(Seqno));
    Qrymain.SQL.add('order by Globalref');
  end else begin
    Qrymain.SQL.add('Select ');
    Qrymain.SQL.add('PQA.PQAID, ');
    Qrymain.SQL.add('PQA.Active, ');
    Qrymain.SQL.add('S.Globalref, ');
    Qrymain.SQL.add('S.BOID,');
    Qrymain.SQL.add('S.baseno,');
    Qrymain.SQL.add('SL.SaleID as TransId , ');
    Qrymain.SQL.add('SL.SaleLineID as TransLineId, ');
    Qrymain.SQL.add('SL.Qtysold , ');
    Qrymain.SQL.add('SL.Shipped, ');
    Qrymain.SQL.add('SL.BackOrder , ');
    Qrymain.SQL.add('SL.BaseLineno ');
    Qrymain.SQL.add('From tblSales S ');
    Qrymain.SQL.add('inner join tblSaleslines SL on s.SAleId = SL.saleID ');
    Qrymain.SQL.add('inner join tblPQa PQA on PQa.Transid = Sl.SaleID and PQA.TransLineID = Sl.SaleLineID and PQA.TransType in ('+SalesTranstypes +')');
    Qrymain.SQL.add('Where S.Originalno = '+Quotedstr(Originalno));
    Qrymain.SQL.add(' and SL.ProductId = '+inttostr(ProductId));
    Qrymain.SQL.add(' and SL.Seqno = '+inttostr(Seqno));
    Qrymain.SQL.add('order by Globalref');
  end;
  inherited;

end;

initialization
  RegisterClassOnce(TPQADetailsBOMismatchGUI);

end.

