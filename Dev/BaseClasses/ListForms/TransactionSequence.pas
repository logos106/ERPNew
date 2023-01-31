unit TransactionSequence;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TTransactionSequenceGUI = class(TBaseListingGUI)
    qryMainglobalref: TWideStringField;
    qryMainTransID: TIntegerField;
    qryMaindocNumber: TWideStringField;
    qryMainboid: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainClientName: TWideStringField;
    qryMainbaseno: TWideStringField;
    qryMainRefno: TWideStringField;
    qryMaintranstype: TWideStringField;
    qryMainTransDate: TDateField;
    qryMainInvoiced: TWideStringField;
    qryMainLockedstatus: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    fsTranstype :String;
    fsOriginalglobalref: String;
    fsGlobalref: String;
    Tablename :string;
    { Private declarations }
  Protected
    Procedure SetGridColumns;Override;
  public
    Property Originalglobalref :String read fsOriginalglobalref write fsOriginalglobalref;
    Property Globalref :String Read fsGlobalref Write fsGlobalref;
    Property Transtype :String read fsTranstype Write fsTranstype;
    Procedure RefreshQuery; Override;


  end;

implementation

uses CommonLib, FastFuncs, CommonDbLib, BaseFormForm, DbSharedObjectsObj;

{$R *.dfm}
{ TTransactionSequenceGUI }

procedure TTransactionSequenceGUI.RefreshQuery;
var
  s:String;
  transId :Integer;
  BOId:String;
  SeqNo:Integer;
  Shipped :Boolean;
  qry: TERPQuery;
begin
  closedb(qrymain);
  s:=  'Drop table if exists ' +tablename +';' ;
  if Transtype = 'PO' then begin
    s:= s +
      'Create table ' +Tablename +
        ' Select distinct trans.globalref, '+
        ' ifnull(trans.baseno,"") baseno, '+
        ' trans.PurchaseOrderid as TransID, '+
        ' trans.PurchaseOrderNumber as docNumber,'+
        ' trans.boid , '+
        ' date(convert(trans.orderDate, Datetime)) as TransDate , '+
        ' trans.EmployeeName , '+
        ' trans.SupplierName as ClientName,'+
        ' "                   " as Refno , '+
        ' "F" as Lockedstatus , '+
        '"PO" as TransType , ' +
        'if(ifnull((Select Sum(Shipped) from `tblPurchaseLines` where PurchaseOrderId =trans.PurchaseOrderID),0)=0 , "F" , "T") as Invoiced' +
        ' from  `tblPurchaseOrders`  Trans inner join `tblPurchaselines` TransLines using (PurchaseOrderID) '+
        ' Where trans.Originalno = ' +QuotedStr(fsOriginalglobalref);
  end else if Transtype = 'QUOTE' then begin
      s:= s+ 'Create table ' +Tablename +
        ' Select ' +
        ' S.Globalref globalref, ' +
        ' RS.PreviousREf as baseno, ' +
        ' S.SaleId as TransID, ' +
        ' S.InvoiceDocNumber  as docNumber, ' +
        ' space(255)  as boid, ' +
        ' Date(convert(s.SaleDate, Datetime)) as TransDate , ' +
        ' s.EmployeeName  as EmployeeName, ' +
        ' CustomerName as ClientName, ' +
        ' "                   " as Refno , ' +
        ' "F" as Lockedstatus , ' +
        ' "Quote" as Transtype , ' +
        ' "F" as Invoiced ' +
        ' from `tblrelatedsales` RS inner join `tblsales` S on Rs.Transref = S.Globalref ' +
        ' where RS.Originalref in (select Originalref from `tblrelatedsales` ' +
        ' where transref = ' +QuotedStr(fsGlobalref)+') order by seqno';
  end else begin
    s:= s +
      'Create table ' +Tablename +
        ' Select distinct trans.globalref, '+
        ' ifnull(trans.baseno,"") baseno , '+
        ' trans.SaleID as TransID, '+
        ' trans.InvoiceDocNumber as docNumber,'+
        ' trans.boid , '+
        ' Date(convert(trans.SaleDate, Datetime)) as TransDate , '+
        ' trans.EmployeeName , '+
        ' trans.CustomerName as ClientName,'+
        ' "                   " as Refno , '+
        ' "F" as Lockedstatus , '+
        'if(trans.issalesorder="T" , "SO" , "INV") as Transtype , ' +
        'if(ifnull((Select Sum(Shipped) from `tblsaleslines` where SaleId=trans.SaleId),0)=0 , "F" , "T") as Invoiced' +
        ' from  `tblSales`  Trans inner join `tblsaleslines` TransLines using (SaleId) '+
        ' Where trans.Originalno = ' +QuotedStr(fsOriginalglobalref);
  end;
  ExecuteSQL(s);
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    With qry do begin
      sql.Text:= Qrymain.SQL.text;
      Open;                           // **GH** 2022.03.23
      if not Eof then
      begin
        TransId := FieldByname('TransId').AsInteger;
        if (TransId <> 0) then
        begin
          SeqNo := 0;
          while not Eof do
          begin
            Edit;
            Inc(SeqNo);
            FieldByname('RefNo').AsString := IntToStr(TransId) + '-' + IntToStr(SeqNo);
            Post;
            Next;
          end;

          while not Bof do
          begin
            boid := FieldByname('BaseNo').AsString;
            if (boId = '') then
              break;

            Shipped := FieldByname('Invoiced').AsBoolean;
            if Locate('GlobalRef', boid, []) then
            begin
              Edit;
              fieldByname('LockedStatus').AsBoolean := Shipped;
              Post;
            end else
              break;
          end;
        end;
      end;
    end;
  Finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  inherited;

end;


procedure TTransactionSequenceGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fsOriginalglobalref := '';
  fsglobalref := '';
  fsTranstype  := '';
  tablename := commondblib.GetUserTemporaryTableName('TransactionSequence');
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('Select * from ' +tablename);
  RefreshOrignalSQL;
end;


procedure TTransactionSequenceGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainglobalref.asString = fsGlobalref then begin
    Afont.Color := clRed;
  end;
end;

procedure TTransactionSequenceGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainTranstype.asString;
  inherited;
end;

procedure TTransactionSequenceGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Transtype');
  RemoveFieldfromGrid('baseno');
end;

procedure TTransactionSequenceGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if qryMain.Locate('Globalref', fsGlobalref, []) then begin
    TitleLabel.Caption := 'Transaction Sequence ('+ Transtype +' # ' +  QrymainDocNumber.AsString+')';
  end;
end;

initialization
  RegisterClassOnce(TTransactionSequenceGUI);

end.
