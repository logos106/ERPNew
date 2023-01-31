unit ErpX12Obj;

interface

uses
  JsonObject;

type

  TErpX12Progress = procedure(msg: string; var Continue: boolean) of object;

  TErpX12 = class(TObject)
  private
    GS: TJsonObject;
    fOnProgress: TErpX12Progress;
    { 850 Purchase Order }
    function Process850(ST: TJsonObject; var msg: string): boolean;
    function Process855(ST: TJsonObject; var msg: string): boolean;
    function Process856(ST: TJsonObject; var msg: string): boolean;
    function Process810(ST: TJsonObject; var msg: string): boolean; // purchase invoice when shipped

    function DecodeDateTimeStr(const DateStr: string; TimeStr: string = ''): TDateTime;
    function DoProgress(msg: string): boolean;
  public
    function ProcessX12(Obj: TJsonObject; var msg: string): boolean;
    property OnProgress: TErpX12Progress read fOnProgress write fOnProgress;
  end;

implementation

uses
  SysUtils, BusObjSales, BusObjClient, CommonLib, BusObjStock, BusObjUOM,
  BusObjTaxCodes, AppEnvironment, BusObjOrders, variants, X12Lib;

{ TErpX12 }

function TErpX12.DecodeDateTimeStr(const DateStr: string;
  TimeStr: string): TDateTime;
var
  hr,mn,sec: word;
begin
  sec := 0;
  mn := 0;
  hr := 0;
  result := EncodeDate(StrToInt(Copy(DateStr,1,4)), StrToInt(Copy(DateStr,5,2)), StrToInt(Copy(DateStr,7,2)));
  if TimeStr <> '' then begin
    hr := StrToInt(Copy(TimeStr,1,2));
    mn := StrToInt(Copy(TimeStr,3,2));
    sec := StrToIntDef(Copy(TimeStr,5,2),0);
  end;
  result := result + EncodeTime(hr,mn,sec,0);
end;

function TErpX12.DoProgress(msg: string): boolean;
var
  Continue: boolean;
begin
  Continue := true;
  if Assigned(fOnProgress) then begin
    fOnProgress(msg, Continue);
  end;
  result := Continue;
end;

function TErpX12.Process850(ST: TJsonObject; var msg: string): boolean;
var
  ChangeStr: string;
  SO: TSalesOrder;
  I, J: integer;
  Seg, SubSeg, Line, TXI: TJsonObject;
  s: string;
  ProductId: integer;
  UOMId, TaxCodeID: integer;

  procedure AddComment(Cmt: string);
  begin
    if SO.Comments <> '' then SO.Comments := SO.Comments + #13#10;
    SO.Comments := SO.Comments + Cmt;
  end;

  procedure AddLineMemo(mem: string);
  begin
    if SO.Lines.Product_Description_Memo <> '' then
      SO.Lines.Product_Description_Memo := SO.Lines.Product_Description_Memo + #13#10;
    SO.Lines.Product_Description_Memo := SO.Lines.Product_Description_Memo + mem;
  end;

begin
  result := DoProgress('Processing 850 Purchase Order');
  if not result then begin
    msg := 'Process Cancelled';
    exit;
  end;
  ChangeStr := '';
  if SameText(ST.O['BEG'].S['BEG01'], '00') then begin
    { Original PO }
  end
  else if SameText(ST.O['BEG'].S['BEG01'], '01') then begin
    { Cancelation }
    ChangeStr := 'Order Canceled ' + ST.O['BEG'].S['BEG05'];
  end
  else if SameText(ST.O['BEG'].S['BEG01'], '04') then begin
    { Change }
    ChangeStr := 'Order Changed ' + ST.O['BEG'].S['BEG05'];
  end
  else if SameText(ST.O['BEG'].S['BEG01'], '05') then begin
    { Replace }
    ChangeStr := 'Order Replaced ' + ST.O['BEG'].S['BEG05'];
  end
  else if SameText(ST.O['BEG'].S['BEG01'], '06') then begin
    { Confirmation }
    ChangeStr := 'Order Confirmed ' + ST.O['BEG'].S['BEG05'];
  end
  else if SameText(ST.O['BEG'].S['BEG01'], '07') then begin
    { Duplicate }
    ChangeStr := 'Order Duplicate ' + ST.O['BEG'].S['BEG05'];
  end
  else begin
    result := false;
    msg := '850 PO - Unknown BEG01 Code: ' + ST.O['BEG'].S['BEG01'];
    exit;
//    raise Exception.Create('850 PO - Unknown BEG01 Code: ' + ST.O['BEG'].S['BEG01']);
  end;

  SO := TSalesOrder.CreateWithNewConn(nil);
  try
    SO.SilentMode := true;
    SO.Connection.BeginTransaction;
    if ChangeStr <> '' then begin
      { flag the existing SO .. }
      SO.LoadSelect('PONumner = ' + QuotedStr(ST.O['BEG'].S['BEG03']));
      if SO.Count = 0 then begin
        result := false;
        msg := '850 PO - Could not update existing SO, not found for PO Number: ' + ST.O['BEG'].S['BEG03'];
        exit;
//        raise Exception.Create('850 PO - Could not update existing SO, not found for PO Number: ' + ST.O['BEG'].S['BEG03']);
      end;
      AddComment(ChangeStr);
      SO.PostDb;
    end;
    { new SO .. }
    SO.New;
    SO.ClientId := TClient.IDToggle(GS.O['GS'].S['GS02']);

    { CUR }
    if ST.O['CUR'].S['CUR02'] <> '' then
      SO.ForeignExchangeCode := ST.O['CUR'].S['CUR02'];

    { BEG }
    if ST.O['BEG'].S['BEG02'] <> '' then
      AddComment('Order Type: ' + ST.O['BEG'].S['BEG02']);
    if ST.O['BEG'].S['BEG03'] <> '' then
      SO.CustPONumber := ST.O['BEG'].S['BEG03'];
    if ST.O['BEG'].S['BEG05'] <> '' then
      AddComment('Order Date: ' + ST.O['BEG'].S['BEG05']);

    { REF }
    for I := 0 to ST.A['REF'].Count -1 do begin
      Seg := ST.A['REF'][I].AsObject.O['REF'];
      s := '';
      if Seg.S['REF03'] <> '' then
        s := Seg.S['REF03']
      else begin
        if SameText(Seg.S['REF01'], 'CO') then
          s := 'Customer Order Number '
        else if SameText(Seg.S['REF01'], 'DP') then
          s := 'Department '
        else if SameText(Seg.S['REF01'], 'IA') then
          s := 'Vendor Number '
        else if SameText(Seg.S['REF01'], '19') then
          s := 'Divison ';
      end;
      AddComment(s + Seg.S['REF03']);
    end;

    { PER }
    for I := 0 to ST.A['PER'].Count -1 do begin
      Seg := ST.A['PER'][I].AsObject.O['PER'];
      if Seg.S['PER01'] <> '' then begin
        s := '';
        if SameText(Seg.S['PER01'], 'BD') then
          s := 'Buyer '
        else if SameText(Seg.S['PER01'], 'IC') then
          s := 'Information Contact ';
        s := s + Seg.S['PER02'];
        AddComment(s);
      end;
      if Seg.S['PER03'] <> '' then begin
        s := '';
        if SameText(Seg.S['PER03'], 'TE') then
          s := 'Telephone '
        else if SameText(Seg.S['PER03'], 'FX') then
          s := 'Fax '
        else if SameText(Seg.S['PER03'], 'EM') then
          s := 'Email ';
        s := s + Seg.S['PER04'];
        AddComment(s);
      end;
      if Seg.S['PER05'] <> '' then begin
        s := '';
        if SameText(Seg.S['PER05'], 'TE') then
          s := 'Telephone '
        else if SameText(Seg.S['PER05'], 'FX') then
          s := 'Fax '
        else if SameText(Seg.S['PER05'], 'EM') then
          s := 'Email ';
        s := s + Seg.S['PER06'];
        AddComment(s);
      end;
      if Seg.S['PER07'] <> '' then begin
        s := '';
        if SameText(Seg.S['PER07'], 'TE') then
          s := 'Telephone '
        else if SameText(Seg.S['PER07'], 'FX') then
          s := 'Fax '
        else if SameText(Seg.S['PER07'], 'EM') then
          s := 'Email ';
        s := s + Seg.S['PER08'];
        AddComment(s);
      end;
    end;
    { FOB }
    for I := 0 to ST.A['FOB'].Count -1 do begin
      Seg := ST.A['FOB'][I].AsObject.O['FOB'];
      s := '';
      if SameText(Seg.S['FOB01'],'CC') then
        s := 'Collect '
      else if SameText(Seg.S['FOB01'],'PP') then
        s := 'Prepaid ';
      if SameText(Seg.S['FOB02'],'DE') then
        s := s + 'Destination '
      else if SameText(Seg.S['FOB02'],'OR') then
        s := s + 'Origin ';
      s := s + Seg.S['FOB03'];
      AddComment(s);
    end;
    { CTP }
    { This is in the header .. ie not at line level .. so just add to comments  }
    for I := 0 to ST.A['CTP'].Count -1 do begin
      Seg := ST.A['CTP'][I].AsObject.O['CTP'];
      s := '';
      if Seg.S['CTP01'] <> '' then begin
        if SameText(Seg.S['CTP01'], 'RS') then
          s := s + 'Resale '
        else
          s := s + Seg.S['CTP01'] + ' ';
      end;
      if Seg.S['CTP03'] <> '' then
        s := s + 'Unit Price ' + FloatToStrF(StrToFloat(Seg.S['CTP03']),ffCurrency, 15, CommonLib.CurrencyRoundPlaces) + ' ';
      if Seg.S['CTP04'] <> '' then
        s := s + 'Quantity ' + Seg.S['CTP04'] + ' ';
      if Seg.S['CTP05'] <> '' then begin
        if SameText(Seg.S['CTP05'], 'CA') then
          s := s + 'Case '
        else if SameText(Seg.S['CTP05'], 'DZ') then
          s := s + 'Dozen '
        else if SameText(Seg.S['CTP05'], 'EA') then
          s := s + 'Each '
        else if SameText(Seg.S['CTP05'], 'UN') then
          s := s + 'Unit '
        else
          s := s + Seg.S['CTP05'] + ' ';
      end;
      s := s + Seg.S['CTP05'];
      AddComment(s);
    end;

    { CSH }
    for I := 0 to ST.A['CSH'].Count -1 do begin
      Seg := ST.A['CSH'][I].AsObject.O['CSH'];
      if SameText(Seg.S['CSH01'],'N') then
        s := 'No Back Order'
      else if SameText(Seg.S['CSH01'],'Y') then
        s := 'Back Order if out of stock'
      else
        s := Seg.S['CSH01'];
      AddComment(s);
    end;

    { SAC }
    for I := 0 to ST.A['SAC'].Count -1 do begin
      Seg := ST.A['SAC'][I].AsObject.O['SAC'];
      s := '';
      if SameText(Seg.S['SAC01'], 'A') then
        s := s + 'Allowance '
      else if SameText(Seg.S['SAC01'], 'C') then
        s := s + 'Change '
      else if SameText(Seg.S['SAC01'], 'N') then
        s := s + 'Neither Allowance or Change '
      else
        s := s + Seg.S['SAC01'] + ' ';
      if Seg.S['SAC02'] <> '' then begin
        if SameText(Seg.S['SAC02'], 'C310') then
          s := s + 'Discount '
        else if SameText(Seg.S['SAC02'], 'D240') then
          s := s + 'Freight '
        else if SameText(Seg.S['SAC02'], 'G830') then
          s := s + 'Shipping and Handling '
        else if SameText(Seg.S['SAC02'], 'UNDF') then
          s := s + 'Undefined '
        else
          s := s + Seg.S['SAC02'] + ' ';
      end;
      if Seg.S['SAC03'] <> '' then begin
        if SameText(Seg.S['SAC03'], 'VI') then
          s := s + 'VICS '
        else
          s := s + Seg.S['SAC03'] + ' ';
      end;
      if Seg.S['SAC04'] <> '' then
        s := s + Seg.S['SAC04'] + ' ';
      if Seg.S['SAC05'] <> '' then
        s := s + FloatToStrF(StrToFloat(Seg.S['SAC05']),ffCurrency, 15, CommonLib.CurrencyRoundPlaces) + ' ';
      if Seg.S['SAC06'] <> '' then
        s := s + Seg.S['SAC06'] + ' ' + Seg.S['SAC07'] + '% ';
      if Seg.S['SAC08'] <> '' then
        s := s + FloatToStrF(StrToFloat(Seg.S['SAC08']),ffCurrency, 15, CommonLib.CurrencyRoundPlaces) + ' ';
      if Seg.S['SAC09'] <> '' then
        s := s + Seg.S['SAC09'] + ' ';
      if Seg.S['SAC10'] <> '' then
        s := s + Seg.S['SAC10'] + ' ';
      if Seg.S['SAC12'] <> '' then begin
        if SameText(Seg.S['SAC12'], '02') then
          s := s + 'Off Invoice '
        else if SameText(Seg.S['SAC12'], '06') then
          s := s + 'Change to be paid by Customer '
        else
          s := s + Seg.S['SAC12'] + ' ';
      end;
      if Seg.S['SAC13'] <> '' then
        s := s + Seg.S['SAC13'] + ' ';
      if Seg.S['SAC15'] <> '' then
        s := s + Seg.S['SAC15'] + ' ';
      AddComment(s);
    end;

    { ITD }
    for I := 0 to ST.A['ITD'].Count -1 do begin
      Seg := ST.A['ITD'][I].AsObject.O['ITD'];
      s := '';
      if SameText(Seg.S['ITD01'], '01') then
        s := s + 'Basic '
      else if SameText(Seg.S['ITD01'], '01') then
        s := s + 'Basic '
      else if SameText(Seg.S['ITD01'], '05') then
        s := s + 'Discount Not Applicable '
      else if SameText(Seg.S['ITD01'], '08') then
        s := s + 'Basic Discount Offered '
      else
        s := s + Seg.S['ITD01'];
      if SameText(Seg.S['ITD02'], '2') then
        s := s + 'Delivery Date '
      else if SameText(Seg.S['ITD02'], '3') then
        s := s + 'Invoice Date '
      else
        s := s + Seg.S['ITD02'] + ' ';

      s := s + Seg.S['ITD03'] + '% ';
      s := s + 'Due ' + Seg.S['ITD04'] + ' ';
      s := s + 'Discount Days Due ' + Seg.S['ITD05'] + ' ';
      s := s + 'Terms Net Due Date ' + Seg.S['ITD06'] + ' ';
      s := s + 'Terms Net Days ' + Seg.S['ITD07'] + ' ';
      s := s + FloatToStrF(StrToFloat(Seg.S['ITD08']),ffCurrency, 15, CommonLib.CurrencyRoundPlaces) + ' ';
      s :=  s + Seg.S['ITD12'];
      AddComment(s);
    end;

    { DTM }
    for I := 0 to ST.A['DTM'].Count -1 do begin
      Seg := ST.A['DTM'][I].AsObject.O['DTM'];
      s := '';
      if SameText(Seg.S['DTM01'], '001') then
        s := s + 'Cancel Date '
      else if SameText(Seg.S['DTM01'], '002') then
        s := s + 'Requested Delivery '
      else if SameText(Seg.S['DTM01'], '010') then
        s := s + 'Requested Ship Date '
      else if SameText(Seg.S['DTM01'], '037') then
        s := s + 'Ship Not Before '
      else if SameText(Seg.S['DTM01'], '038') then
        s := s + 'Ship No Later '
      else if SameText(Seg.S['DTM01'], '063') then
        s := s + 'Do Not Deliver After '
      else if SameText(Seg.S['DTM01'], '064') then
        s := s + 'Do Not Deliver Before '
      else
        s := s + Seg.S['DTM01'] + ' ';
      s := s + DateTimeToStr(DecodeDateTimeStr(Seg.S['DTM02'], Seg.S['DTM03'])) + ' ';
      AddComment(s);
    end;

    { TD5 }
    for I := 0 to ST.A['TD5'].Count -1 do begin
      Seg := ST.A['TD5'][I].AsObject.O['TD5'];
      s := '';
      s := s + Seg.S['TD503'] + ' ';
      if SameText(Seg.S['TD504'],'M') then
        s := s + 'Common Carrier '
      else if SameText(Seg.S['TD504'],'P') then
        s := s + 'Private Parcel Service '
      else if SameText(Seg.S['TD504'],'T') then
        s := s + 'Shippers Option '
      else
        s :=  s + Seg.S['TD504'] + ' ';
      s := s + Seg.S['TD505'] + ' ';
      s := s + Seg.S['TD512'];
      AddComment(s);
    end;

    { TXI }
    for I := 0 to ST.A['TXI'].Count -1 do begin
      Seg := ST.A['TXI'][I].AsObject.O['TXI'];
      s := '';
      if SameText(Seg.S['TXI01'],'GS') then
        s := s + 'Goods and Services '
      else if SameText(Seg.S['TXI01'],'VA') then
        s := s + 'Value Added Tax '
      else if SameText(Seg.S['TXI01'],'TX') then
        s := s + 'Tax '
      else
        s := s + Seg.S['TXI01'] + ' ';
      if Seg.S['TXI02'] <> '' then
        s := s + FloatToStrF(StrToFloat(Seg.S['TXI02']),ffCurrency, 15, CommonLib.CurrencyRoundPlaces) + ' ';
      if Seg.S['TXI04'] <> '' then
        s := s + Seg.S['TXI04'] + ' ';
      if Seg.S['TXI05'] <> '' then
        s := s + Seg.S['TXI05'] + ' ';
      if Seg.S['TXI06'] <> '' then begin
        if SameText(Seg.S['TXI06'], '0') then
          s := s + 'Exempt (For Export) '
        else if SameText(Seg.S['TXI06'], '1') then
          s := s + 'Tax Exempt '
        else if SameText(Seg.S['TXI06'], '2') then
          s := s + 'Not Tax Exempt ';
      end;
      AddComment(s);
    end;

    { N9 }
    for I := 0 to ST.A['N9'].Count -1 do begin
      Seg := ST.A['N9'][I].AsObject.O['N9'];
      s := Seg.S['N901'] + ' ' + Seg.S['N902'];
      if Seg.S['N903'] <> '' then
        s := s + ' ' + Seg.S['N903'];
      AddComment(s);
    end;

    { MTX }
    for I := 0 to ST.A['MTX'].Count -1 do begin
      Seg := ST.A['MTX'][I].AsObject.O['MTX'];
      s := '';
      if SameText(Seg.S['MTX01'], 'GEN')  then
        s := s + 'General Notes '
      else if SameText(Seg.S['MTX01'], 'SHP')  then
        s := s + 'Shipping Instructions '
      else if SameText(Seg.S['MTX01'], 'SPE')  then
        s := s + 'Special Instructions '
      else
        s := s + Seg.S['MTX01'] + ' ';
      s :=  s + Seg.S['MTX02'];
      AddComment(s);
    end;

    { N9 }
    for I := 0 to ST.A['N9'].Count -1 do begin
      Seg := ST.A['N9'][I].AsObject.O['N9'];
      s := Seg.S['N901'] + ' ' + Seg.S['N902'];
      if Seg.S['N903'] <> '' then
        s := ' ' + Seg.S['N903'];
      AddComment(s);
      { MTX }
      for J := 0 to ST.A['N9'][I].AsObject.A['MTX'].Count -1 do begin
        SubSeg := ST.A['N9'][I].AsObject.A['MTX'][J].AsObject;
        s := '';
        if SameText(SubSeg.S['MTX01'], 'GEN') then
          s := s + 'General Notes '
        else if SameText(SubSeg.S['MTX01'], 'SHP') then
          s := s + 'Shipping Instructions '
        else if SameText(SubSeg.S['MTX01'], 'SPE') then
          s := s + 'Special Instructions '
        else
          s := s + SubSeg.S['MTX01'] + ' ';
        s := s + SubSeg.S['MTX012'];
        AddComment(s);
      end;
    end;

    { N1 Party Itentification }
    for I := 0 to ST.A['N1'].Count -1 do begin
      Seg := ST.A['N1'][I].AsObject.O['N1'];
      s := '';
      if SameText(Seg.S['N101'], 'ST') then
        s := s + 'Ship To '
      else if SameText(Seg.S['N101'], 'SF') then
        s := s + 'Ship From '
      else if SameText(Seg.S['N101'], 'VN') then
        s := s + 'Vendor '
      else if SameText(Seg.S['N101'], 'BT') then
        s := s + 'Bill To '
      else if SameText(Seg.S['N101'], 'Z7') then
        s := s + 'Mark Foe Party '
      else
        s := s + Seg.S['N101']  + ' ';
      s := s + Seg.S['N102'];
      if Seg.S['N103'] <> '' then begin
        if SameText(Seg.S['N103'], '1') then
          s := s + 'DUNS '
        else if SameText(Seg.S['N103'], '9') then
          s := s + 'DUNS + 4 '
        else if SameText(Seg.S['N103'], '91') then
          s := s + 'Assigned by Seller '
        else if SameText(Seg.S['N103'], '92') then
          s := s + 'Assigned by Buyer or Buyer''s Agent '
        else
          s :=  s + Seg.S['N103'] + ' ';
        s := s + Seg.S['N104']
      end;

      AddComment(s);

      { N2 Addional Name Information }
      for J := 0 to ST.A['N1'][I].AsObject.A['N2'].Count -1 do begin
        SubSeg := ST.A['N1'][I].AsObject.A['N2'][J].AsObject;
        s := SubSeg.S['N201'];
        AddComment(s);
      end;

      { N3 Part Location }
      for J := 0 to ST.A['N1'][I].AsObject.A['N3'].Count -1 do begin
        SubSeg := ST.A['N1'][I].AsObject.A['N3'][J].AsObject;
        s := SubSeg.S['N301'] + ' ' + SubSeg.S['N302'];
        AddComment(s);
      end;

      { N4 Geographic Location }
      if ST.A['N1'][I].AsObject.ObjectExists('N4') then begin
        SubSeg := ST.A['N1'][I].AsObject.O['N4'];
        s := SubSeg.S['N401'] + ' ' + SubSeg.S['N402'] + ' ' + SubSeg.S['N403'];
        if SubSeg.S['N404'] <> '' then
          s := s + ' ' + SubSeg.S['N404'];
        AddComment(s);
      end;
    end;

      { PO lines }
      for I := 0 to ST.A['PO1'].Count -1 do begin
      Line := ST.A['PO1'][I].AsObject;
      SO.Lines.New;
      Seg := Line.O['PO1'];

      { find product using Vendoe Part Number }
      ProductId := 0;
      if SameText(Seg.S['PO106'],'VN') then begin
        ProductId := TProduct.IDToggle(Seg.S['PO107']);
      end
      else if SameText(Seg.S['PO108'],'VN') then begin
        ProductId := TProduct.IDToggle(Line.S['Seg']);
      end
      else if SameText(Seg.S['PO110'],'VN') then begin
        ProductId := TProduct.IDToggle(Seg.S['PO110']);
      end
      else if SameText(Seg.S['PO112'],'VN') then begin
        ProductId := TProduct.IDToggle(Seg.S['PO113']);
      end
      else if SameText(Seg.S['PO114'],'VN') then begin
        ProductId := TProduct.IDToggle(Seg.S['PO115']);
      end
      else if SameText(Seg.S['PO116'],'VN') then begin
        ProductId := TProduct.IDToggle(Seg.S['PO117']);
      end
      else if SameText(Seg.S['PO118'],'VN') then begin
        ProductId := TProduct.IDToggle(Seg.S['PO119']);
      end
      else if SameText(Seg.S['PO120'],'VN') then begin
        ProductId := TProduct.IDToggle(Seg.S['PO121']);
      end;
      if ProductId = 0 then begin
        result := false;
        msg := 'Could not find ERP product for provided Vendor Part Number on PO Line ' + Seg.S['PO101'];
        exit;
      end;
      SO.Lines.ProductID := ProductId;

      { UOM }
      UOMID := TUnitOfMeasure.IdForNameAndProductId(Seg.S['PO103'], ProductID);
      if UOMID = 0 then begin
        result := false;
        msg := 'Unit of Measure "' + Seg.S['PO103'] + '" not found for product ' +
          SO.Lines.ProductPrintName + ' for Line ' + Seg.S['PO101'];
        exit;
      end;
      SO.Lines.UnitOfMeasureID := UOMID;
      SO.Lines.UOMQtySold := StrToFloat(Seg.S['PO102']);

      { TXI }  { Tax Information }
      for J := 0 to Line.A['TXI'].Count -1 do begin
        TXI :=  Line.A['TXI'][J].AsObject.O['TXI'];
        if J = 0 then begin
          TaxCodeID := TTaxCode.IdForCode(TXI.S['TXI01'], AppEnv.RegionalOptions.ID);
          if TaxCodeID = 0 then begin
            { apply only first record found to line }
            result := false;
            msg := 'Could not find ERP Tax Code "'+ TXI.S['TXI01'] +'" for Product "'+SO.Lines.ProductPrintName+'" on PO Line ' + Seg.S['PO101'];
            exit;
          end;
          SO.Lines.LineTaxCode := TXI.S['TXI01'];
        end;
        { log all tax info to line memo .. }
        s := 'Tax ' + TXI.S['TXI01'];
        if TXI.S['TXI02'] <> '' then
          s := s + ' ' + FloatToStrF(StrToFloat(Seg.S['TXI02']),ffCurrency, 15, CommonLib.CurrencyRoundPlaces);
        if TXI.S['TXI04'] <> '' then
          s := s + ' ' + TXI.S['TXI04'];
        if TXI.S['TXI05'] <> '' then
          s := s + ' ' + TXI.S['TXI05'];
        if TXI.S['TXI06'] <> '' then
          s := s + ' Exempt Code ' + TXI.S['TXI06'];
        if TXI.S['TXI09'] <> '' then
          s := s + ' Tax ID No ' + TXI.S['TXI09'];
        AddLineMemo(s);
      end;

      SO.Lines.LinePriceInc := StrToFloat(Seg.S['PO104']);

      { SDQ } { Destination Quantity }
      if Line.ObjectExists('SDQ') then begin
        SubSeg := Line.O['SDQ'];
        s := 'Dest Qty ' + SubSeg.S['SDQ01'];
        if SubSeg.S['SDQ02'] <> '' then
          s := s + ' ' + SubSeg.S['SDQ02'];
        if SubSeg.S['SDQ03'] <> '' then
          s := s + ' ' + SubSeg.S['SDQ03'];
        if SubSeg.S['SDQ04'] <> '' then
          s := s + ' ' + SubSeg.S['SDQ04'];
        if SubSeg.S['SDQ05'] <> '' then
          s := s + ' ' + SubSeg.S['SDQ05'];
        if SubSeg.S['SDQ06'] <> '' then
          s := s + ' ' + SubSeg.S['SDQ06'];
        if SubSeg.S['SDQ07'] <> '' then
          s := s + ' ' + SubSeg.S['SDQ07'];
        if SubSeg.S['SDQ08'] <> '' then
          s := s + ' ' + SubSeg.S['SDQ08'];
        if SubSeg.S['SDQ09'] <> '' then
          s := s + ' ' + SubSeg.S['SDQ09'];
        if SubSeg.S['SDQ10'] <> '' then
          s := s + ' ' + SubSeg.S['SDQ10'];
        AddLineMemo(s);
      end;

      { CTP } { Price Info }
      for J := 0 to Line.A['CTP'].Count -1 do begin
        SubSeg := Line.A['CTP'][J].AsObject.O['CTP'];
        s := 'Price Info ';
        if SubSeg.S['CTP01'] <> '' then begin
          if SameText(SubSeg.S['CTP01'], 'RS') then
            s := s + 'Resale '
          else
            s := s + SubSeg.S['CTP01'] + ' ';
        end;
        if SubSeg.S['CTP03'] <> '' then
          s := s + 'Unit Price ' + FloatToStrF(StrToFloat(SubSeg.S['CTP03']),ffCurrency, 15, CommonLib.CurrencyRoundPlaces) + ' ';
        if SubSeg.S['CTP04'] <> '' then
          s := s + 'Quantity ' + SubSeg.S['CTP04'] + ' ';
        if SubSeg.S['CTP05'] <> '' then begin
          if SameText(SubSeg.S['CTP05'], 'CA') then
            s := s + 'Case '
          else if SameText(SubSeg.S['CTP05'], 'DZ') then
            s := s + 'Dozen '
          else if SameText(SubSeg.S['CTP05'], 'EA') then
            s := s + 'Each '
          else if SameText(SubSeg.S['CTP05'], 'UN') then
            s := s + 'Unit '
          else
            s := s + SubSeg.S['CTP05'] + ' ';
        end;
        s := s + SubSeg.S['CTP05'];
        AddLineMemo(s);
      end;

      { PID } { Product/Item Desc }
      for J := 0 to Line.A['PID'].Count -1 do begin
        SubSeg := Line.A['PID'][J].AsObject.O['PID'];
        s := SubSeg.S['PID05'];
        AddLineMemo(s);
      end;

      { PO4 } { Item Physical Details }
      for J := 0 to Line.A['PO4'].Count -1 do begin
        SubSeg := Line.A['PO4'][J].AsObject.O['PO4'];
        s := SubSeg.S['PO401'] + ' ' + SubSeg.S['PO402'] + ' ' + SubSeg.S['PO403'];
        if SubSeg.S['PO414'] <> '' then
          s := s + ' ' + SubSeg.S['PO414'];
        AddLineMemo(s);
      end;

      { REF } { Reference Information }
      for J := 0 to Line.A['REF'].Count -1 do begin
        SubSeg := Line.A['REF'][J].AsObject.O['REF'];
        s := SubSeg.S['REF01'] + ' ' + SubSeg.S['REF02'];
        AddLineMemo(s);
      end;

      { DTM } { Date/Time Reference }
      for J := 0 to Line.A['DTM'].Count -1 do begin
        SubSeg := Line.A['DTM'][J].AsObject.O['DTM'];
        if SameText(SubSeg.S['DTM01'], '002') then
          s := 'Requested Delivery '
        else if SameText(SubSeg.S['DTM01'], '010') then
          s := 'Requested Ship '
        else
          s := SubSeg.S['DTM01'] + ' ';
        s := s + DateTimeToStr(DecodeDateTimeStr(SubSeg.S['DTM02'], SubSeg.S['DTM03']));
        AddLineMemo(s);
      end;

      { MTX } { text }
      for J := 0 to Line.A['MTX'].Count -1 do begin
        SubSeg := Line.A['MTX'][J].AsObject.O['MTX'];
        if SameText(SubSeg.S['MTX01'], 'GEN') then
          s := 'General Notes '
        else if SameText(SubSeg.S['MTX01'], 'SPE') then
          s := 'Special Instructions '
        else if SameText(SubSeg.S['MTX01'], 'SHP') then
          s := 'Shipping Notes '
        else
          s := s + SubSeg.S['MTX01'] + ' ';
        s := s + SubSeg.S['MTX02'];
        AddLineMemo(s);
      end;

      { end of line }
      SO.Lines.PostDb;
    end;

    { CTT }  { Transaction Totals }
    Seg := ST.O['CTT'];
    s := 'Total lines ' + Seg.S['CTT01'] + ' ' +
      FloatToStrF(StrToFloat(SubSeg.S['CTTT02']),ffCurrency, 15, CommonLib.CurrencyRoundPlaces);
    AddComment(s);

    { AMT }  { Amount Information }
    Seg := ST.O['AMT'];
    if SameText(Seg.S['AMT01'], 'TT') then
      s := 'Total Transaction Amount '
    else
      s := Seg.S['AMT01'] + ' ';
    s := 'Total lines ' + Seg.S['AMT01'] + ' ' +
      FloatToStrF(StrToFloat(SubSeg.S['AMT02']),ffCurrency, 15, CommonLib.CurrencyRoundPlaces);
    AddComment(s);

    { SE }  { Trabsaction Set Trailer }

    if SO.Save then begin
      SO.Connection.CommitTransaction;
    end
    else begin
      result := false;
      msg := SO.ResultStatus.Messages;
      SO.Connection.RollbackTransaction;
    end;




  finally
    if SO.Connection.InTransaction  then
      SO.Connection.RollbackTransaction;
    SO.Free;
  end;



end;

function TErpX12.Process855(ST: TJsonObject; var msg: string): boolean;
var
  PO: TPurchaseOrder;
  s: string;

  procedure AddComment(aComment: string);
  begin
    if PO.Comments <> '' then PO.Comments := PO.Comments + #13#10;
    PO.Comments := PO.Comments + aComment;
  end;

begin
  result := DoProgress('Processing 855 Purchase Order Acknowledgment');
  if not result then begin
    msg := 'Process Cancelled';
    exit;
  end;
  PO := TPurchaseOrder.CreateWithNewConn(nil);
  try
    PO.SilentMode := true;
    PO.LoadSelect('PurchaseOrderNumber = ' + QuotedStr(ST.O['BAK'].S['BAK03']));
    if PO.Count = 0 then begin
      result := false;
      msg := 'Could not find ERP Purchase Order for PO Number contained in Acknowledgment message: ' + ST.O['BAK'].S['BAK03'];
      exit;
    end;
    if PO.LockTrans(s) then begin
      try
        PO.Connection.BeginTransaction;
        try
          { flag PO }
          PO.OrderStatus := AppEnv.CompanyPrefs.EDIConfig.POAcknowledgementStatus;
          if SameText(ST.O['BAK'].S['BAK02'],'AC') then
            AddComment('PO Acknowledge-with detail and change')
          else if SameText(ST.O['BAK'].S['BAK02'],'AD') then
            AddComment('PO Acknowledge - with detail no change')
          else if SameText(ST.O['BAK'].S['BAK02'],'AE') then
            AddComment('PO With exception - detail only ')
          else if SameText(ST.O['BAK'].S['BAK02'],'AH') then
            AddComment('PO Acknowledge - hold')
          else if SameText(ST.O['BAK'].S['BAK02'],'AK') then
            AddComment('PO Acknowledge - no detail or change')
          else if SameText(ST.O['BAK'].S['BAK02'],'AP') then
            AddComment('PO Acknowledge - product replenishment')
          else if SameText(ST.O['BAK'].S['BAK02'],'RD') then
            AddComment('PO Reject with detail')
          else if SameText(ST.O['BAK'].S['BAK02'],'RJ') then
            AddComment('PO Reject - no detail')
          else
            AddComment('PO Acknowledgment Type: ' + ST.O['BAK'].S['BAK02']);

          PO.PostDb;
          PO.Connection.CommitTransaction;
        finally
          if PO.Connection.InTransaction then
            PO.Connection.RollbackTransaction;
        end;
      finally
        PO.UnLock;
      end;
    end
    else begin
      result := false;
      msg := 'Could not lock PO to update it: ' + s;
    end;
  finally
    PO.Free;
  end;
end;
function TErpX12.Process810(ST: TJsonObject; var msg: string): boolean;
var
  PO, POCur: TPurchaseOrder;
  PONum :String;
  fiITDCtr :Integer;
  fiRecno:Integer;
  fbflag :Boolean;
  s:String;
  It1: TJsonObject;
begin
  fbflag :=False;
  result := DoProgress('Processing 810 Purchase Order');
  if not result then begin
    msg := 'Process Cancelled';
    exit;
  end;
  if ST.O['BIG'].S['BIG04'] <> '' then begin
    PONum :=trim(ST.O['BIG'].S['BIG04']);
    if (PONum<> '') and (ST.Exists('ITD')) and (ST.A['ITD'].count >0) then begin
      PO := TPurchaseOrder.CreateWithNewConn(nil);
      try
        PO.SilentMode := true;
        PO.LoadSelect('PurchaseOrderNumber = ' + QuotedStr(PONum));
        try if PO.Count = 0 then PO.Load(strtoint(PONum)); except end;
        if PO.Count = 0 then begin
          result := false;
          msg := 'Could not find ERP Purchase Order for PO Number contained in "PO Invoice" : ' + PONum;
          exit;
        end;
        POCur := PO.LastOrderOfGroup;

        if PO.LockTrans(s) then begin
          try
            PO.Connection.BeginTransaction;
            try
              if (trim(ST.O['BIG'].S['BIG02'])<> '') and (trim(POCur.SupplierInvoiceNumber)='') then begin
                POCur.SupplierInvoiceNumber :=trim(ST.O['BIG'].S['BIG02']);
                if ST.O['BIG'].S['BIG01'] <> '' then POCur.SupplierInvoiceDate :=CCYYMMDDDateToDate(ST.O['BIG'].S['BIG01']);
                POCur.PostDB;
              end;
              for fiITDCtr := 0 to ST.A['IT1'].count-1 do begin
                fiRecno:= 0;
                if not ST.A['IT1'][fiITDCtr].AsObject.exists('IT1') then continue;
                It1:=ST.A['IT1'][fiITDCtr].AsObject.O['IT1'];
                try fiRecno:= strtoint(IT1.S['IT101']); except end;
                if fiRecno=0 then continue;
                PO.Lines.GotoRecord(fiRecno);
                if (PO = POCur) or (POCur.Lines.Locate('SEQNo;ProductID', vararrayof([PO.Lines.SEQNo, PO.Lines.ProductID]), [])) then begin
                  try POCur.Lines.QtyShipped :=  POCur.Lines.QtyShipped  +strtoFloat(IT1.S['IT102']); except end;
                  POCur.Lines.PostDB;
                  fbflag :=true;
                end;
              end;
              if fbflag  then begin
                if POCur.save then begin
                  PO.Connection.CommitTransaction;
                  REsult := True;
                  Exit;
                end else begin
                  msg := POCur.LastErrorMsgFromREsultStatus;
                  REsult := False;
                end;
              end;
            finally
              if PO.Connection.InTransaction then
                PO.Connection.RollbackTransaction;
            end;
          finally
            PO.UnLock;
          end;
        end else begin
          result := false;
          msg := 'Could not lock PO to update it: ' + s;
        end;
      finally
        PO.Free;
      end;
    end;
  end;

end;
function TErpX12.Process856(ST: TJsonObject; var msg: string): boolean;
var
  PONum: string;
  I: integer;
  HL: TJsonObject;
  PO: TPurchaseOrder;
  s: string;
begin
  result := DoProgress('Processing 856 Ship Notice');
  if not result then begin
    msg := 'Process Cancelled';
    exit;
  end;
  PONum := '';
  for I := 0 to ST.A['HL'].Count -1 do begin
    HL := ST.A['HL'][I].AsObject;
    if HL.ObjectExists('PRF') then begin
      PONum := HL.O['PRF'].S['PRF01'];
      break;
    end;
  end;
  if PONum = '' then begin
    result := false;
    msg := 'PO Number not found in Ship Notice';
    exit;
  end;

  PO := TPurchaseOrder.CreateWithNewConn(nil);
  try
    PO.SilentMode := true;
    PO.LoadSelect('PurchaseOrderNumber = ' + QuotedStr(PONum));
    if PO.Count = 0 then begin
      result := false;
      msg := 'Could not find ERP Purchase Order for PO Number contained in Ship Notice message: ' + PONum;
      exit;
    end;
    if PO.LockTrans(s) then begin
      try
        PO.Connection.BeginTransaction;
        try
          { flag PO }
          PO.OrderStatus := AppEnv.CompanyPrefs.EDIConfig.POShippedStatus;
          PO.PostDb;
          PO.Connection.CommitTransaction;
        finally
          if PO.Connection.InTransaction then
            PO.Connection.RollbackTransaction;
        end;
      finally
        PO.UnLock;
      end;
    end
    else begin
      result := false;
      msg := 'Could not lock PO to update it: ' + s;
    end;
  finally
    PO.Free;
  end;
end;

function TErpX12.ProcessX12(Obj: TJsonObject; var msg: string): boolean;
var
  ST: TJsonObject;
  GSIdx, STIdx: integer;
begin
  result := false;
  DoProgress('Found ' + IntToStr(Obj.A['GS'].Count) + ' Functional Groups in X12 file.');
  for GSIdx := 0 to Obj.A['GS'].Count -1 do begin
    GS := Obj.A['GS'][GSIdx].AsObject;
    DoProgress('Found Group: ' + GS.O['GS'].S['GS01']);
    if SameText(GS.O['GS'].S['GS01'], 'PO') then begin
      { PO Functional Group }
      for STIdx := 0 to GS.A['ST'].Count -1 do begin
        ST := GS.A['ST'][STIdx].AsObject;
        if SameText(ST.O['ST'].S['ST01'], '850') then begin
          { 850 Purchase Order }
          result := Process850(ST, msg);
          if not result then
            exit;
        end
        else begin
          msg := 'Unknown Transaction Set Identifier: ' + ST.O['ST'].S['ST01'];
          DoProgress(msg);
        end;
      end;
    end
    else if SameText(GS.O['GS'].S['GS01'], 'PR') then begin
      { Purchase Order Acknowledgment Group }
      for STIdx := 0 to GS.A['ST'].Count -1 do begin
        ST := GS.A['ST'][STIdx].AsObject;
        if SameText(ST.O['ST'].S['ST01'], '855') then begin
          { 855 PO Ack }
          result := Process855(ST, msg);
          if not result then
            exit;
        end
        else begin
          msg := 'Unknown Transaction Set Identifier: ' + ST.O['ST'].S['ST01'];
          DoProgress(msg);
        end;
      end;
    end
    else if SameText(GS.O['GS'].S['GS01'], 'SH') then begin
      { Ship Notice/Mainfest Group }
      for STIdx := 0 to GS.A['ST'].Count -1 do begin
        ST := GS.A['ST'][STIdx].AsObject;
        if SameText(ST.O['ST'].S['ST01'], '856') then begin
          { 856 Shipment }
          result := Process856(ST, msg);
          if not result then
            exit;
        end
        else begin
          msg := 'Unknown Transaction Set Identifier: ' + ST.O['ST'].S['ST01'];
          DoProgress(msg);
        end;
      end;
    end
    else if SameText(GS.O['GS'].S['GS01'], 'IN') then begin
      { Purchase invoice}
      for STIdx := 0 to GS.A['ST'].Count -1 do begin
        ST := GS.A['ST'][STIdx].AsObject;
        if SameText(ST.O['ST'].S['ST01'], '810') then begin
            { 810 Purchase invoice}
          result := Process810(ST, msg);
          if not result then
            exit;
        end
        else begin
          msg := 'Unknown Transaction Set Identifier: ' + ST.O['ST'].S['ST01'];
          DoProgress(msg);
        end;
      end;

    end
    else begin
      msg := 'Unknown Transaction Set Code: ' + GS.O['GS'].S['GS01'];
      DoProgress(msg);
    end;

  end;
end;

end.
