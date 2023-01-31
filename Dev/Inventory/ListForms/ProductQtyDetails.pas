unit ProductQtyDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Buttons, Wwdbigrd, Grids, Wwdbgrid, StdCtrls,
  Shader, ExtCtrls, DNMPanel, DB, DBAccess, MyAccess, ERPdbComponents,
  MemDS, ProductQtyLib, DNMSpeedButton, BaseFormForm, ImgList, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, BaseListingForm,
  kbmMemTable,  ProgressDialog, wwDialog, Wwlocate,
  ActnList, PrintDAT, wwdbdatetimepicker, wwdblook, AdvOfficeStatusBar,
  DAScript, MyScript, CustomInputBox, wwcheckbox, pqalib, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TProductQtyDetailsGUI = class(TBaseListingGUI)
    DNMPanel1: TDNMPanel;
    lblProduct: TLabel;
    lblProductname: TLabel;
    lblClass: TLabel;
    lblClassname: TLabel;
    lblQtytype: TLabel;
    lblQtytypedesc: TLabel;
    qryMainTransactionDate: TDateTimeField;
    qryMainTransType: TWideStringField;
    qryMainformName: TWideStringField;
    qryMainStockmovementEntryglobalref: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainQty: TFloatField;
    qryMainTransactionNo: TLargeintField;
    qryMainInvID: TIntegerField;
    qryMainSoID: TIntegerField;
    qryMainConverted: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fiClassID: Integer;
    fiProductId: Integer;
    fQtytype: TQtytype;

  Protected
    Procedure SetGridColumns;Override;
    procedure MakeQrymain;Virtual;
  public
    Property ProductId :Integer read fiProductId write fiProductId;
    Property ClassID :Integer read fiClassID Write fiClassID;
    Property Qtytype :TQtytype REad fQtytype write fQtytype;
    procedure RefreshQuery; override;
  end;


implementation

uses AppEnvironment, tcDataUtils, FastFuncs, busobjStockMovement, CommonLib;



{$R *.dfm}

procedure TProductQtyDetailsGUI.RefreshQuery;
begin
  lblProductname.Caption := GetProduct(fiProductId);
  lblQtytypedesc.caption := QtytypetoDesc(Qtytype);
  lblClass.caption       :=appenv.DefaultClass.ClassHeading ;
  if ficlassId<> 0 then lblClassname.Caption := GetClassName(ficlassid) else lblClassname.Caption  := 'All ' + appenv.DefaultClass.ClassHeading;
  
     MakeQrymain;
     inherited;
end;
Procedure TProductQtyDetailsGUI.MakeQrymain;
begin
  Qrymain.disablecontrols;
  try
      if Qrymain.active then Qrymain.close;
     Qrymain.SQL.clear;
     Qrymain.SQL.add('Select  PQA.TransDate as TransactionDate,');
     Qrymain.SQL.add('if(ifnull(SMTT.Description,"")<> "" ,SMTT.Description, if(ifnull(TT.Description,"") = "" , PQA.TransType , TT.Description))  as TransType,');
     Qrymain.SQL.add('ifnull(TT.formName, SMTT.formname) as formName,');
     Qrymain.SQL.add('SM.StockmovementEntryglobalref,');
     Qrymain.SQL.add('PQA.ProductName as ProductName,');
     Qrymain.SQL.add( SQL4QtyField(fQtytype) +' as Qty,');
     Qrymain.SQL.add('PQA.TransID as TransactionNo,');
     Qrymain.SQL.add('Inv.SaleId as InvID,');
     Qrymain.SQL.add('So.SaleID as SoID,');
     Qrymain.SQL.add('S3.Converted as Converted');
     Qrymain.SQL.add('FROM ' + ProductTables(tSummary, False, TRue));
     Qrymain.SQL.add('LEFT join tblSales S on S.SaleId = PQA.TransID and ((PQA.TRansType in ("TSalesOrderline" )  and S.converted = "T") or(PQA.TransType in ("TProcTreePart") and PQA.AllocType = "IN" and S.Converted = "T") )');
     Qrymain.SQL.add('LEFT join tblSales Inv on ifnull(Inv.SalesOrderGlobalref,"") =S.globalref');
     Qrymain.SQL.add('LEFT join tblSales S2 on S2.SaleId = PQA.TransID and PQA.TRansType in ("TInvoiceLine" )');
     Qrymain.SQL.add('LEFT join tblSales SO on ifnull(S2.SalesOrderGlobalref,"") =SO.globalref ');
     Qrymain.SQL.add('LEFT join tblSales S3 on S3.SaleId = PQA.TransID and ((PQA.TRansType in ("TSalesOrderline" )) or (PQA.TransType in ("TProcTreePart") and PQA.AllocType = "IN"))');
     Qrymain.SQL.add('LEFt JOIN tblStockMovement SM on SM.StockmovementId = PQA.TransId and PQA.TransType = ' + QuotedStr(TStockMovementLines.classname));
     Qrymain.SQL.add('LEFt JOIN tblpqatranstypes as SMTT on SM.StockmovementEntryType = SMTT.TransType');
     Qrymain.SQL.add('Where PQA.ProductID = '+IntToStr(fiProductId) );
     Qrymain.SQL.add(' and    ' + SQL4QtyField(fQtytype) + ' <> 0');
     if fiClassID<> 0 then
        Qrymain.SQL.add('and  PQA.DepartmentID = '+IntToStr(fiClassID) );
     Qrymain.SQL.add('group by  TransDate , PQA.TransID, PQA.productID, PQA.TRansType, PQA.departmentID, pqa.translineID');
     Qrymain.SQL.add('Order by TransDate desc');
  finally
      Qrymain.EnableControls;
      grdMain.refresh;
  end;
end;
procedure TProductQtyDetailsGUI.FormCreate(Sender: TObject);
begin
  NonSearchMode := True;   
  inherited;
  fiClassID:=0;
  fiProductId:=0;
  fQtytype:=tqtyNone;
end;

procedure TProductQtyDetailsGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TProductQtyDetailsGUI.SetGridColumns;
begin
     RemoveFieldfromGrid('invid');
     RemoveFieldfromGrid('soid');
     RemoveFieldfromGrid('converted');
     RemoveFieldfromGrid('formName');
     RemoveFieldfromGrid('StockmovementEntryglobalref');
     RemoveFieldfromGrid('ProductName');
end;
initialization
  RegisterClassOnce(TProductQtyDetailsGUI);

end.
