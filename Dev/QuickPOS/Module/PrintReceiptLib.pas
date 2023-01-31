unit PrintReceiptLib;

interface

uses ReceiptPrinterObj , BusObjPosTill, BusobjCash;

    procedure PrintReceipt(oRcptPrn: TReceiptPrinter; PosTill :TPosTillDetails; POSSale: TCashBase; comments :String ='');

implementation

uses AppEnvironment, CommonLib, sysutils, tcDataUtils, classes, dialogs;

procedure PrintReceipt(oRcptPrn: TReceiptPrinter; PosTill :TPosTillDetails; POSSale: TCashBase; comments :String ='');
var
  iProductdesc :Integer;
  function Addspace(Const data:String; Prefix:Boolean; datalength:Integer):String;
  begin
    result := data;
    while Length(Result)< datalength do
      if Prefix then Result := ' ' +Result else Result := Result +' ';
  end;
  procedure ReceiptHeader;
    var
      abn:String;
  begin
    with oRcptPrn do begin
      Justify(CJ);
      Format(char(FMT_HIGH or FMT_BOLD));
      if comments <> '' then begin
        Printline;
        Print(comments);
        Printline;
      end;
      Print(PosTill.Company);
      Format(char(FMT_NORMAL));
      NewLine(1);
      Print(PosTill.Address1 + ', ' + PosTill.Address2);
      Print(PosTill.City);
      Print(PosTill.State + ' ' + PosTill.PostCode);
      Print(Appenv.CompanyInfo.Country);
      abn:=AppEnv.RegionalOptions.BusinessTaxNoLabel;
      While length(abn)<5 do ABN:=' ' +abn;
      Print(abn +':  ' + Appenv.CompanyInfo.Abn);
      Format(char(FMT_NORMAL or FMT_BOLD));

      Print(ReplicateStr(' ' , char_length(abn)-5)+ 'Phone:  ' + PosTill.PhoneNumber);
      Format(char(FMT_NORMAL));
      Print(ReplicateStr(' ' , char_length(abn)-5)+'  Fax:  ' + PosTill.FaxNumber);
      Justify(LJ);
    end
  end;

    procedure ReceiptSaleDetails;
  begin
    with oRcptPrn do begin
      Justify(CJ);
      Format(char(FMT_NORMAL));
      PrintLine;
      Justify(LJ);
      NewLine(1);
      Print('Receipt No : ' +  inttostr(POSSale.SaleID));
      Print('Store      : ' + POSSale.TillName);
      Print('Person     : ' + ExtractStrPortion(POSSale.employeeName, ' ', 0));
      Justify(CJ);
      Format(char(FMT_WIDE + FMT_BOLD));
      NewLine(1);
      Print(AppEnv.RegionalOptions.POSDocName);
      Justify(LJ);
      Format(char(FMT_NORMAL));
      NewLine(2);
    end;
  end;

    procedure ReceiptLineDetails;
  var
    sQty , sPrice , sDesc:String;
    sBuf:String;


  begin
    try
      oRcptPrn.Justify(LJ);
      oRcptPrn.Format(char(FMT_NORMAL));
      if POSSale.Lines.Count =0 then exit;
      POSSale.Lines.first;
      While POSSale.Lines.Eof =False do begin
        sBuf := replicatestr( ' ' , oRcptPrn.fiwidth);

        sQty :=  floatTostrf(POSSale.Lines.uomQtyShipped , ffGeneral, 15,2);
        sPrice :=  floatTostrf(POSSale.Lines.totallineamountInc , ffCurrency, 15,2);
        sDesc:= trim(POSSale.Lines.productdescription)+ replicatestr( ' ' , oRcptPrn.fiwidth) ;
        iProductdesc := oRcptPrn.fiwidth - Length(sQty)- Length(sPrice)-2;
        sBuf := sQty + ' ' +  copy(sDesc , 1, iProductdesc)     +' ' +  sPrice;
        sDesc :=copy(sDesc , iProductdesc , length(sDesc));

        oRcptPrn.Print(sBuf);

        if POSTill.POSPrintDescriptionMultipleLines then
          while trim(sDesc) <> '' do begin
            sBuf := replicatestr( ' ' , length(sQty ))+ ' ' +  copy(sDesc , 1, iProductdesc)     +' ' +  replicatestr( ' ' , Length(sPrice));
            sDesc :=copy(sDesc , iProductdesc , length(sDesc));
            oRcptPrn.Print(sBuf);
          end;

        POSSale.Lines.Next;
      end;
      oRcptPrn.Justify(LJ);
      oRcptPrn.Format(char(FMT_NORMAL));
    Except
      on E:Exception do begin
        MessageDlgXP_vista(E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  end;
  Procedure ReceiptRewardPoints;
  var
    i: integer;
    st:TStringList;
  begin

    if POSSale.salePoints =0 then exit;

    st:= tStringlist.Create;
    try
    {$IFDEF DevMode}
        st.text:= 'Reward Points'+chr(13) + '**** Dev Mode ****';
    {$ELSE}
        st.text:= AppEnv.CompanyPrefs.POSRewardPointTemplate;
    {$ENDIF}

      st.text := StringReplace(st.text , '<CustomerName>'         ,POSSale.CustomerName    ,[rfReplaceAll]);
      st.text := StringReplace(st.text , '<SaleDate>'             ,FormatDateTime(FormatSettings.ShortDateformat , POSSale.saledatetime) ,[rfReplaceAll]);
      st.text := StringReplace(st.text , '<OpeningBalancePoints>' ,floatToStr(Round(tcdatautils.Availablerewardpoints(POSSale.clientID, date ), Appenv.CompanyPrefs.RoundUpPoints))   ,[rfReplaceAll]);
      st.text := StringReplace(st.text , '<RedeemedPoints>'       ,floatToStr(Round(POSSale.redeemedPoints, Appenv.CompanyPrefs.RoundUpPoints))     ,[rfReplaceAll]);
      st.text := StringReplace(st.text , '<SalePoints>'           ,floatToStr(Round(POSSale.salePoints, Appenv.CompanyPrefs.RoundUpPoints))        ,[rfReplaceAll]);
      st.text := StringReplace(st.text , '<CompanyName>'          ,POSSale.CustomerName                           ,[rfReplaceAll]);
      if st.count >0 then begin
        with oRcptPrn do begin
          Justify(LJ);
          Format(char(FMT_NORMAL));
          NewLine(1);
          for i := 0 to st.Count - 1 do begin
            If Empty(st[i]) then st[i]:= '';
            Print(st[i]);
          end;
          Justify(CJ);
          PrintLine;
          Justify(LJ);
        end;
      end;
    finally
      Freeandnil(st);
    end;
  end;
    procedure ReceiptFooter;
  var
    i: integer;
    st:TStringList;
  begin
    st:= TStringlist.Create;
    try

        {$IFDEF DevMode}
          st.Text      := 'Refund Policy'+chr(13) + '**** Dev Mode ****';
        {$ELSE}
          st.Text      := AppEnv.CompanyPrefs.ReceiptFooter;
        {$ENDIF}
        if st.Count <> 0 then begin
          with oRcptPrn do begin
            Justify(LJ);
            Format(char(FMT_NORMAL));
            NewLine(1);
            for i := 0 to st.Count - 1 do
              If Empty(st[i]) then
                NewLine(1)
              else
                Print(st[i]);
            Justify(CJ);
            PrintLine;
            Justify(LJ);
          end;
        end;
    finally
      Freeandnil(st);
    end;
  end;
  Procedure Receipttotal;
  var
    //sBuf:String;
    i:Integer;
  begin
    i := length(FloatTostrF(POSSale.totalamountinc , ffCurrency , 15,2));
      oRcptPrn.PrintLine;

    oRcptPrn.Justify(RJ);
    oRcptPrn.Print('Total GST     : ' +Addspace( FloatTostrF(POSSale.TotalTax , ffCurrency , 15,2) , True, i));

    oRcptPrn.Print('Total Amount  : ' + Addspace( FloatTostrF(POSSale.totalamountinc , ffCurrency , 15,2) , True, i));

      oRcptPrn.NewLine(1);
      oRcptPrn.NewLine(1);

    oRcptPrn.Print('Cash    : ' + Addspace( FloatTostrF(POSSale.totalamountinc , ffCurrency , 15,2) , True, i));
    oRcptPrn.Print('Change  : ' + Addspace( FloatTostrF(0 , ffCurrency , 15,2), True, i));

      oRcptPrn.NewLine(1);
      oRcptPrn.PrintLine;
      oRcptPrn.NewLine(1);
      oRcptPrn.Justify(LJ);
  end;

begin
  try
    oRcptPrn.OpenPort;
    try
      ReceiptHeader;
      ReceiptSaleDetails;
      ReceiptLineDetails;
      Receipttotal;
      ReceiptRewardPoints;
      ReceiptFooter;
      oRcptPrn.FeedPaperForCut;
    Finally
      oRcptPrn.ClosePort;
    end;

  except
      on E:Exception do begin
         // CommonLib.MessageDlgXP_Vista('Print Failed:' +E.message , mtWarning, [mbok], 0);
      end;
  end;

end;

end.
