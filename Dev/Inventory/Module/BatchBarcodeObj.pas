unit BatchBarcodeObj;

interface


Type
  TBatchBarcode = class(TObject)
    Private

    Protected
      fsBarcode: String;
      fsBarcodevalidationMsg: String;
      fsBatchno: String;
      procedure setBarcode(const Value: String);Virtual;
      function getIsBarCodeValid: boolean;
    Public
      Property Barcode:String read fsBarcode Write setBarcode;
      Property BarcodevalidationMsg:String read fsBarcodevalidationMsg;
      Property IsBarCodeValid:boolean read getIsBarCodeValid;
      Property Batchno:String read fsBatchno;
  end;

  TSalesDispatchBatchBarcode = class(TBatchBarcode)
    Private
      //fiSaleID: Integer;
      fiSalesOrderLineID: Integer;
      fiInvoiceLineID: Integer;
    Protected
      procedure setBarcode(const Value: String);Override;
    Public
      Constructor Create;
      //Property SaleID:Integer read fiSaleID ;
      Property SalesOrderLineID:Integer read fiSalesOrderLineID;
      Property InvoiceLineID:Integer read fiInvoiceLineID;

  end;

  TProductBatchBarcode = Class(TBatchBarcode)
    Private
    fiProductID: Integer;
    Protected
      procedure setBarcode(const Value: String);Override;
    Public
      Property ProductID:Integer read fiProductID;
  End;


implementation

uses ERPdbComponents, classes, DNMLib, CommonLib, Sysutils, tcDataUtils,
  DbSharedObjectsObj, CommonDbLib, tcConst, Barcodeconst;

{ TBatchBarcode }
procedure TBatchBarcode.setBarcode(const Value: String);
begin
  fsBarcode := Value;
end;

{TBatchBarcode}
function TBatchBarcode.getIsBarCodeValid: boolean;
begin
   Result := trim(fsBarcodevalidationMsg) ='';
end;

{ TSalesDispatchBatchBarcode }
constructor TSalesDispatchBatchBarcode.Create;
begin
  inherited;
    fsBarcode:='';
    //fiSaleID:=0;
    fiSalesOrderLineID:=0;
    fiInvoiceLineID:=0;
    fsBatchno:='';
end;


procedure TSalesDispatchBatchBarcode.setBarcode(const Value: String);
var
  st:Tstringlist;
  i:Integer;
  fiSaleID:Integer;
  Qry:TERPQuery;
begin
  inherited setBarcode(Value);
  //fiSaleID:=0;
  fiSalesOrderLineID:=0;
  fiInvoiceLineID:=0;
  fsBatchno:='';
  fsBarcodevalidationMsg := '';
  st:= TStringlist.Create;
  try
    SplitString(Value , '-' , st);
    if st.Count <3 then begin
        fsBarcodevalidationMsg:= 'This is not a valid Dispatch Barcode';
        Exit;
    end;
    if not (st[0] = Barcode_Prefix_SLBatch) then begin
        fsBarcodevalidationMsg:= 'This is not a valid Dispatch Barcode';
        Exit;
    end;
    st.Delete(0); // remove the constant

(*    if not(isinteger(st[0])) then begin
        fsBarcodevalidationMsg:= 'This is not a valid Dispatch Barcode';
        Exit;
    end;
    fiSaleID := strtoInt(st[0]);
    if fiSaleID =0 then begin
        fsBarcodevalidationMsg:= 'This is not a valid Dispatch Barcode';
        Exit;
    end;
    st.Delete(0);*)

    if not(isinteger(st[0])) then begin
        fsBarcodevalidationMsg:= 'This is not a valid Dispatch Barcode';
        Exit;
    end;
    i:=strtoInt(st[0]);
    if i =0 then begin
        fsBarcodevalidationMsg:= 'This is not a valid Dispatch Barcode';
        Exit;
    end;

    Qry := DbSharedObj.GetQuery(Commondblib.GetSharedMyDacConnection);
    try

          closedb(Qry);
          Qry.SQL.Text := 'Select s.sAleId, S.isinvoice, S.issalesorder , SL.saleLineId as SOLineID , InvSL.SaleLineId as InvLineID ' +
                ' From tblSales S ' +
                ' inner join tblsaleslines SL on S.saleId = SL.saleID ' +
                ' Left join ( tblsales Inv inner join tblsaleslines INvSL  on  inv.saleId = invSL.saleID) on Inv.salesorderglobalref = S.GlobalRef and  SL.productId =  INvSL.productID and SL.Seqno =  INvSL.Seqno ' +
                ' Where S.ISSalesOrder ="T" and  SL.saleLineId = ' + inttostr(i)+
                ' union all ' +
                ' Select s.sAleId, S.isinvoice, S.issalesorder, SOL.saleLineId as SOLineID , SL.SaleLineId as InvLineID ' +
                ' From tblSales S ' +
                ' inner join tblsaleslines SL on S.saleId = SL.saleID ' +
                ' Left join ( tblsales SO inner join tblsaleslines SOL on  SO.saleId = SOL.saleID) on SO.GlobalRef= S.salesorderglobalref  and  SL.productId =  SOL.productID and SL.Seqno =  SOL.Seqno ' +
                ' Where S.isinvoice ="T" and  SL.saleLineId = ' + inttostr(i);

          with Qry do try
              open;
              fiSalesOrderLineID := fieldbyname('SOLineID').asInteger;
              fiInvoiceLineID := fieldbyname('InvLineID').asInteger;
              fiSaleID := fieldbyname('sAleId').asInteger;
          finally
            if active then close;
          end;

          if fiInvoiceLineID =0 then begin
            if fiSalesOrderLineID =0 then begin
              fsBarcodevalidationMsg:= 'This is not a valid Dispatch Barcode';
              Exit;
            end;
            fsBarcodevalidationMsg:= 'Sales Order #' + inttostr(fiSaleID) +' is not converted to an Invoice yet.'+NL+'You will have to convert the Sales Order to dispatch';
            Exit;
          end;

          st.Delete(0);
          st.Delimiter:= '-';
          fsBatchno := St.DelimitedText;
          if fsBatchno = '' then begin
              fsBarcodevalidationMsg:= 'This is not a valid Dispatch Barcode';
              Exit;
          end;
          closedb(Qry);
          if fiSalesOrderLineID <> 0 then
            Qry.SQL.Text := 'Select PQABatch.PQADetailID ' +
                  ' From tblSales S ' +
                  ' inner join tblsaleslines SL on S.saleId = SL.saleID  and SL.saleLineID =  ' + inttostr(fiInvoiceLineID) +
                  ' inner join tblpqa PQA on PQA.transID = S.saleId and PQA.TransLineID = SL.saleLineID and PQA.transType  in("TInvoiceLine" ) and PQA.alloctype = "OUT" ' +
                  ' inner join tblpqaDetails PQABatch on PQABatch.pqaid = PQA.PQAID and PQABatch.PQAType ="Batch" and PQABatch.value = ' +Quotedstr(fsBatchno)
          else
            Qry.SQL.Text :=' Select ' +
                          ' sl.saleId , sl.saleLineId,pqad.PQADetailID  '+
                          ' From tblsaleslines SL inner join tblsales S on SL.saleId = S.saleId  '+
                          ' inner join (Select  '+
                          ' SL.productId, SL.seqno , S.originalno  '+
                          ' From tblsaleslines SL inner join tblsales S on SL.saleId = S.saleId  '+
                          ' Where SL.saleLineId = ' + inttostr(fiInvoiceLineID) +') Originalsale  on Originalsale.originalno = S.OriginalNo and ifnull(S.BOID , "")="" and SL.productId = Originalsale.ProductId and SL.Seqno = Originalsale.Seqno  '+
                          ' inner join tblPQA pqa on pqa.transId = S.saleId and pqa.translineId = SL.saleLIneID and pqa.transtype ="TInvoiceLine" and pqa.alloctype ="OUT"  '+
                          ' inner join tblpqadetails pqad on pqa.pqaid = pqad.PQAID    and pqad.Value = ' +Quotedstr(fsBatchno) +' and pqad.PQAType ="Batch" and (ifnull(pqad.boqty,0)<>0 or ifnull(pqad.qty,0)<>0)';

          with Qry do try
              open;
              if (recordcount=0) or (fieldbyname('PQADetailID').asInteger =0) then begin
                fsBarcodevalidationMsg:= 'This Batch ' +quotedstr(fsBatchno) +' is being removed from the Invoice after conversion';
                Exit;
              end;
              if fiSalesOrderLineID = 0 then
                if Fieldbyname('saleLineId').asinteger <> fiInvoiceLineID then begin
                  fiInvoiceLineID := Fieldbyname('saleLineId').asinteger;
                  fiSaleID := Fieldbyname('SaleId').asinteger;
                end;
          finally
            if active then close;
          end;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
  finally
    Freeandnil(st);
  end;
end;

{ TProductBatchBarcode }

procedure TProductBatchBarcode.setBarcode(const Value: String);
var
  st:Tstringlist;
begin
  inherited setBarcode(Value);
  fiProductID:=0;
  fsBatchno:='';
  fsBarcodevalidationMsg := '';
  st:= TStringlist.Create;
  try
    SplitString(Value , '-' , st);
    if st.Count <2 then begin
        fsBarcodevalidationMsg:= 'This is not a valid Product Batch Barcode';
        Exit;
    end;
    if not(isinteger(st[0])) then begin
        fsBarcodevalidationMsg:= 'This is not a valid Product Batch Barcode';
        Exit;
    end;
    fiProductID := strtoInt(st[0]);
    if fiProductID =0 then begin
        fsBarcodevalidationMsg:= 'This is not a valid Product Batch Barcode';
        Exit;
    end;
    st.Delete(0);

    st.Delimiter:= '-';
    fsBatchno := St.DelimitedText;
    if fsBatchno = '' then begin
        fsBarcodevalidationMsg:= 'This is not a valid Product Batch Barcode';
        Exit;
    end;
  finally
    Freeandnil(st);
  end;
end;
end.
