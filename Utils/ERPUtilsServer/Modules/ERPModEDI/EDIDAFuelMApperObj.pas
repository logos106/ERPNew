unit EDIDAFuelMApperObj;

interface

uses
  JsonObject, LogThreadBase, Classes, LogMessageTypes, ERPDBComponents,
  EDIMapConfigObj, Types, EDICustomFileMapperObj;

type

  TERPDAFuelMapper = class(TEDICustomFileMapper)
  private
    ColList: TStringList;
    function ProcessCSVFile(reader: TStreamReader): boolean;
//    function FieldValid(fieldData: string; colConfig: TJsonObject): boolean;
//    function FieldOk(data: TStringDynArray; Columns: TJsonObject; ColNo, RowNo: integer; var msg: string): boolean;
//    function LineOk(data: TStringDynArray; Columns: TJsonObject; RowNo: integer; var msg: string): boolean;
//    function AddLineData(LineArray: TJsonArray; line: TStringDynArray; Columns: TJsonObject; RowNo: integer; var msg: string): boolean;
//    function ImportData(data: TJsonArray; Mapping: TJsonObject; var msg: string): boolean;
//    function MapToERP(data: TJsonArray; Mapping: TJsonObject; var msg: string): boolean;
//    function IsNewRec(DataLine, PriorDataLine: TJsonObject; NewRecordOn: TJsonObject): boolean;
//    function StringToCurrency(val: string; colDef: TJsonObject): double;
    function DateStrValid(s: string): boolean;
    function LineOk(data: TStringDynArray; RowNo: integer; var msg: string): boolean;
    function ValByName(aColName: string; aLine: TStringDynArray): string;
    function AddLineData(LineArray: TJsonArray; line: TStringDynArray; RowNo: integer; var msg: string): boolean;
    function MapToERP(data: TJsonArray; var msg: string): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    function ProcessFile(stream: TStream; aMapName: string): boolean; overload; override;
    function ProcessFile(aFileName: string; aMapName: string): boolean; overload; override;
  end;


implementation

uses
  sysutils, StringUtils, DateTimeUtils, ActiveX,
  AppEnvironment, BusObjBase, TypInfo, StrUtils, JsonToObject,
  BusObjSales, BusObjOrders, BusObjERPSales, DbSharedObjectsObj,
  DNMLib, CommonLib;

const
  SupplierName = 'Viva Energy Australia';
  TransDateFormat = 'dd-mmm-yyyy';
  TransTimeFormat = 'hh:nn:ss';
  EDIUserName = 'edi user';
  FieldSep = ',';
  ColumnNames =
    '"Transaction Date",' +
    '"Column B",'+
    '"Card Number",' +
    '"Reg Number",' +
    '"Driver",' +
    '"Cost Centre",' +
    '"Column G",' +
    '"Outlet",' +
    '"Column I",' +
    '"Location",' +
    '"Order No",' +
    '"Receipt Number",' +
    '"Odometer",' +
    '"Product",' +
    '"Quantity",' +
    '"Docket Amount Inc",' +
    '"Pump Price Inc",' +
    '"Shell Card Amount Ex",' +
    '"Column S",' +
    '"GST",' +
    '"Shell Card Amount Inc",' +
    '"Shell Card Price Inc"';

{ TERPDAFuelMapper }

function TERPDAFuelMapper.ProcessFile(stream: TStream;
  aMapName: string): boolean;
var
  reader: TStreamReader;
begin
  fLastErrorType := meNone;
  try
    Config.Name := aMapName;
    Config.Load(Connection);
    reader := TStreamReader.Create(stream);
    try
//      if SameText(Config.O['InputFile'].S['DataType'],'CSV') then
//        result := ProcessCSVFile(reader)
//      else begin
//        result := false;
//        Err('Could not process file, unknown file type: "' +
//          Config.O['InputFile'].S['DataType'] + '"');
//      end;
      result := ProcessCSVFile(reader)
    finally
      reader.Free;
    end;
  except
    on e: exception do begin
      Err('Error processing file: ' + e.Message);
    end;
  end;
end;

function TERPDAFuelMapper.AddLineData(LineArray: TJsonArray;
  line: TStringDynArray; RowNo: integer; var msg: string): boolean;
var
  rec: TJsonObject;
  x: integer;
  colNo: integer;
  s: string;
begin
  result := false;
//  colNo := 0;
  try
    rec := JO;
    rec.I['RowNumber'] := RowNo;
    for x := Low(line) to High(line) do begin
      ColNo := x +1;
      s := StringUtils.StripQuotes(Trim(line[x]));
      rec.S[ColList[x]] := s;
//      if Columns.ObjectExists(IntToStr(x+1)) then begin
//        def := Columns.O[IntToStr(x+1)];
//        if SameText(def.S['DataType'],'DateTime') then begin
//          rec.DT[IntToStr(x+1)] := DateTimeUtils.StrToDateTimeFmt(def.S['DateFormat'],def.S['TimeFormat'],s);
//        end
//        else if SameText(def.S['DataType'],'Integer') then begin
//          rec.I[IntToStr(x+1)] := StrToIntDef(s,0);
//        end
//        else if SameText(def.S['DataType'],'Float') then begin
//          rec.F[IntToStr(x+1)] := StrToFloatDef(s,0);
//        end
//        else if SameText(def.S['DataType'],'Currency') then begin
//          rec.F[IntToStr(x+1)] := StringToCurrency(s,def);
//        end
//        else begin
//          { else its a string }
//          rec.S[IntToStr(x+1)] := s;
//        end;
//      end
//      else begin
//        { assume string }
//        rec.S[IntToStr(x+1)] := s;
//      end;
    end;

    LineArray.Add(rec);
  except
    on e: exception do begin
      if ColNo > 0 then
        msg := 'Error loading data for Row Number ' + IntToStr(RowNo) + ' and Column Number '+IntToStr(ColNo)+': ' + e.Message
      else
        msg := 'Error loading data for Row Number ' + IntToStr(RowNo) + ': ' + e.Message;
      exit;
    end;
  end;
  result := true;
end;

constructor TERPDAFuelMapper.Create;
begin
  inherited;
  ColList := TStringList.Create;
  ColList.CommaText := ColumnNames;
end;

function TERPDAFuelMapper.DateStrValid(s: string): boolean;
var
  data: string;
  dt: TDateTime;
begin
  { return true if the data is valid using the column config data }
  result := false;
  data := StringUtils.StripQuotes(Trim(s));
  if data = '' then exit;

  { check for valid date tim data .. }
  try
    dt := DateTimeUtils.StrToDateTimeFmt(TransDateFormat,TransTimeFormat,data);
    if dt = 0 then
      exit;
  except
    exit;
  end;
  result := true;
end;

destructor TERPDAFuelMapper.Destroy;
begin
  ColList.Free;
  inherited;
end;

function TERPDAFuelMapper.LineOk(data: TStringDynArray; RowNo: integer;
  var msg: string): boolean;
begin
  result := false;
  { check we have the required data }
  if Trim(ValByName('Card Number',data)) = '' then begin
    msg := 'Row Number ' + IntToStr(RowNo) + ' - Card Number missing.';
    exit
  end
  else if Trim(ValByName('Product',data)) = '' then begin
    msg := 'Row Number ' + IntToStr(RowNo) + ' - Product missing.';
    exit
  end;
  result := true;
end;

function TERPDAFuelMapper.MapToERP(data: TJsonArray; var msg: string): boolean;
var
  x: integer;
  DataLine: TJsonObject;

  Invoice: ERPInvoice;
  PO: TPurchaseOrder;
  TransDate: TDateTime;
  InvLastTransDate: TDateTime;
  POLastTransDate: TDateTime;
  LastCardNumber: string;
  InvStartRowNo: integer;
  POStartRowNo: integer;
  Odometer: integer;
  qry: TERPQuery;
  HundredKm: double;
  KmSpan: integer;

  function FieldName(aTarget: TJsonObject): string;
  var
    arr: TStringDynArray;
    i: integer;
  begin
    arr := StrUtils.SplitString(aTarget.S['Field'],'.');
    result := arr[High(arr)];
  end;

  function StrToControl(str: string): string;
  begin
    result := StringReplace(str,'\r',#13,[rfReplaceAll]);
    result := StringReplace(result,'\n',#11,[rfReplaceAll]);
  end;

  function QtyStrToFloat(aQtyStr: string): double;
  begin
    result := StringToFloatDef(aQtyStr,1);
    if result = 0 then
      result := 1;
  end;

  function PreviousOdometer: integer;
  begin
    result := 0;
    qry := DbSharedObj.GetQuery(Invoice.Connection.Connection);
    try
      qry.SQL.Add('select SaleCustField5 from tblsales');
      qry.SQL.Add('where ClientId = ' + IntToStr(Invoice.ClientId));
      qry.SQL.Add('and SaleID <> ' + IntToStr(Invoice.ID));
      qry.SQL.Add('order by SaleDateTime DESC');
      qry.SQL.Add('limit 1');
      qry.Open;
      if not qry.IsEmpty then begin
        result := StrToIntDef(qry.Fields[0].AsString,0);
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end;

begin
  result := true;
  try

    Invoice:= ERPInvoice.Create(nil);
    PO := TPurchaseOrder.Create(nil);
    try

      Invoice.Connection := TMyDacDataConnection.Create(Invoice);
      Invoice.Connection.Connection := AppEnv.AppDb.TransConnection;
      Invoice.SilentMode := true;
      Invoice.Load(0);

      PO.Connection := TMyDacDataConnection.Create(PO);
      PO.Connection.Connection := AppEnv.AppDb.TransConnection;
      PO.SilentMode := true;
      PO.Load(0);

      InvLastTransDate := 0;
      POLastTransDate := 0;
      LastCardNumber := '';

      InvStartRowNo := 0;
      POStartRowNo := 0;
      for x := 0 to data.Count -1 do begin
        Log('Processing record ' + IntToStr(x+1) + ' of ' + IntToStr(data.count) + ' ..',ltDetail);
        { MAIN data loop }
        DataLine := data.Items[x].AsObject;
        TransDate := DateTimeUtils.StrToDateTimeFmt(TransDateFormat,TransTimeFormat,DataLine.S['Transaction Date']);

        { Invoice }
        if (InvLastTransDate <> TransDate) or (LastCardNumber <> DataLine.S['Card Number']) then begin
          { start a new invoice }
          if x <> 0 then begin
            { save existing invoice }
            if Invoice.Save then  begin
 //             if Invoice.Transcount > 0 then Invoice.Connection.CommitNestedTransaction;
            end
            else begin
              result := false;
              msg := Invoice.ResultStatus.Messages + ' Current Imput File Row Range is: ' + IntToStr(InvStartRowNo) + ' to '  + IntToStr(DataLine.I['RowNumber']);
              if Errors.Count > 0 then Errors.Add('');
              Errors.Add('An error occurred when saving an Invoice');
              Errors.Add(Invoice.ResultStatus.Messages);
              Errors.Add('Error located between input file row number ' + IntToStr(InvStartRowNo) + ' and ' + IntToStr(DataLine.I['RowNumber']));
//              if Invoice.Transcount > 0 then Invoice.Connection.RollbackNestedTransaction;
            end;
          end;
          Invoice.Load(0);
          Invoice.New;
//          if Invoice.Transcount = 0 then Invoice.Connection.BeginNestedTransaction;
          InvLastTransDate := TransDate;
          LastCardNumber := DataLine.S['Card Number'];
          { Map header }
          Invoice.JobName := DataLine.S['Card Number'];
          Invoice.SaleDateTime := TransDate;
          Invoice.EmployeeName := EDIUserName;
          if Trim(DataLine.S['Driver']) <> '' then begin
            Invoice.SaleCustField1  := Trim(DataLine.S['Driver']);
          end;
          if Trim(DataLine.S['Outlet']) <> '' then begin
            if Invoice.Comments <> '' then
              Invoice.Comments := Invoice.Comments + #13#10;
            Invoice.Comments := Invoice.Comments + Trim(DataLine.S['Outlet']);
            Invoice.SaleCustField2  := Trim(DataLine.S['Outlet']);
          end;
          if Trim(DataLine.S['Location']) <> '' then begin
            if Invoice.Comments <> '' then
              Invoice.Comments := Invoice.Comments + #13#10;
            Invoice.Comments := Invoice.Comments + Trim(DataLine.S['Location']);
            Invoice.SaleCustField3  := Trim(DataLine.S['Location']);
          end;
          if (DataLine.S['Odometer'] <> '') and (DataLine.S['Odometer'] <> '0') then begin
            Invoice.CustPONumber := DataLine.S['Odometer'];
            Odometer := StrToIntDef(DataLine.S['Odometer'],0);
            if OdoMeter > 0 then begin
              Invoice.WarrantyPeriod := Odometer; //StrToFloatDef(DataLine.S['Odometer'],0);
              Invoice.SaleCustField5 := IntToStr(Odometer);
              Invoice.SaleCustField6 := IntToStr(PreviousOdometer);
            end;
          end;
          if Trim(DataLine.S['Receipt Number']) <> '' then begin
            Invoice.SaleCustField4 := Trim(DataLine.S['Receipt Number']);
          end;
        end;
        { map Invoice lines }
        if not SameText(DataLine.S['Product'],'MONTHLY ADMIN CHARGE') then begin
          { monthly admin charge is only for PO }
          Invoice.Lines.New;
          InvStartRowNo := DataLine.I['RowNumber'];
          Invoice.Lines.ProductName := DataLine.S['Product'];
          Invoice.Lines.DocketNumber := DataLine.S['Receipt Number'];
          Invoice.Lines.MemoLine := DataLine.S['Card Number'];
          Invoice.Lines.UOMOrderQty := QtyStrToFloat(DataLine.S['Quantity']);
          Invoice.Lines.UOMQtyShipped := QtyStrToFloat(DataLine.S['Quantity']);
          Invoice.Lines.TotalLineAmountInc := StringToFloatDef(DataLine.S['Docket Amount Inc'],0);
          { now the discount }

          if Invoice.Lines.Product.ExtraSellPrice.Dataset.Locate('ClientTypeId',Invoice.Customer.ClientTypeId,[]) then begin
            if Invoice.Lines.Product.ExtraSellPrice.QtyPercent1 > 0 then begin
              { use QtyPercent1 as cents per liter  }
              Invoice.Lines.DiscountAmount := (Invoice.Lines.Product.ExtraSellPrice.QtyPercent1 / 100) * Invoice.Lines.UOMQtyShipped;
            end;
          end;
          { now the km stuff .. }
          if Invoice.Lines.UOMQtyShipped > 1 then begin
            { assume that if qty is greater than 1 then this is fuel }
            if (StrToIntDef(Invoice.SaleCustField5,0) > 0) and (StrToIntDef(Invoice.SaleCustField6,0) > 0) then begin
              { KM Span }
              kmSpan := StrToIntDef(Invoice.SaleCustField5,0) - StrToIntDef(Invoice.SaleCustField6,0);
              Invoice.Lines.SalesLinesCustField1 := IntToStr(kmSpan);
              { Litre per 100 km }
              HundredKm := DivZer(kmSpan, 100);
              Invoice.Lines.SalesLinesCustField2 := FormatFloat('#0.00;-#0.00',CommonLib.Round(DivZer(Invoice.Lines.UOMQtyShipped, HundredKm),2));
              { cents per km }
              Invoice.Lines.SalesLinesCustField3 := FormatFloat('#0.00;-#0.00',CommonLib.Round(DivZer(Invoice.Lines.TotalLineAmountInc,KmSpan),2));
            end;
          end;



          Invoice.Lines.PostDb;
        end;

        { Purchase order }
        if (POLastTransDate <> Trunc(TransDate)) then begin
          { start a new PO for each date}
          if x <> 0 then begin
            { save existing PO }
            if PO.Save then  begin
//              if PO.Transcount > 0 then PO.Connection.CommitNestedTransaction;
            end
            else begin
              result := false;
              msg := PO.ResultStatus.Messages + ' Current Imput File Row Range is: ' + IntToStr(POStartRowNo) + ' to '  + IntToStr(DataLine.I['RowNumber']);
              if Errors.Count > 0 then Errors.Add('');
              Errors.Add('An error occurred when saving a Purchase Order');
              Errors.Add(PO.ResultStatus.Messages);
              Errors.Add('Error located between input file row number ' + IntToStr(POStartRowNo) + ' and ' + IntToStr(DataLine.I['RowNumber']));
//              if PO.Transcount > 0 then PO.Connection.RollbackNestedTransaction;
            end;
          end;
          PO.Load(0);
          PO.New;
//          if PO.Transcount = 0 then PO.Connection.BeginNestedTransaction;
          POLastTransDate := Trunc(TransDate);
          { Map header }
          PO.SupplierName := SupplierName;
          PO.OrderDate := TransDate;
          PO.ConNote := DataLine.S['Receipt Number'];

        end;
        { map PO lines }
        PO.Lines.New;
        POStartRowNo := DataLine.I['RowNumber'];
        PO.Lines.ProductName := DataLine.S['Product'];
        { add card numbers to comments }
        if Pos(DataLine.S['Card Number'],PO.Comments) = 0 then begin
          if PO.Comments <> '' then
            PO.Comments := PO.Comments + #13#10;
          PO.Comments := PO.Comments + DataLine.S['Card Number'];
        end;
        PO.Lines.UOMQtySold := QtyStrToFloat(DataLine.S['Quantity']);
        PO.Lines.UOMQtyShipped := QtyStrToFloat(DataLine.S['Quantity']);
        PO.Lines.TotalLineAmountInc := StringToFloatDef(DataLine.S['Shell Card Amount Inc'],0);

        PO.Lines.PostDb;

      end; { MAIN Loop}

      if Invoice.Lines.Count > 0 then begin
        if Invoice.Save then  begin
//          if Invoice.Transcount > 0 then Invoice.Connection.CommitNestedTransaction;
        end
        else begin
          result := false;
          msg := Invoice.ResultStatus.Messages + ' Current Imput File Row Range is: ' + IntToStr(InvStartRowNo) + ' to '  + IntToStr(DataLine.I['RowNumber']);
          if Errors.Count > 0 then Errors.Add('');
          Errors.Add('An error occurred when saving an Invoice');
          Errors.Add(Invoice.ResultStatus.Messages);
          Errors.Add('Error located between input file row number ' + IntToStr(InvStartRowNo) + ' and ' + IntToStr(DataLine.I['RowNumber']));
//          if Invoice.Transcount > 0 then Invoice.Connection.RollbackNestedTransaction;
        end;
      end;

      if PO.Lines.Count > 0 then begin
        if PO.Save then  begin
//          if PO.Transcount > 0 then PO.Connection.CommitNestedTransaction;
        end
        else begin
          result := false;
          msg := PO.ResultStatus.Messages + ' Current Imput File Row Range is: ' + IntToStr(InvStartRowNo) + ' to '  + IntToStr(DataLine.I['RowNumber']);
          if Errors.Count > 0 then Errors.Add('');
          Errors.Add('An error occurred when saving a Purchase Order');
          Errors.Add(PO.ResultStatus.Messages);
          Errors.Add('Error located between input file row number ' + IntToStr(POStartRowNo) + ' and ' + IntToStr(DataLine.I['RowNumber']));
//          if PO.Transcount > 0 then PO.Connection.RollbackNestedTransaction;
        end;
      end;

    finally
      Invoice.Free;
      PO.Free;
    end;
  except
    on e: exception do begin
      result := false;
      msg := 'Error while Mapping Data: ' + e.Message;
      if Errors.Count > 0 then Errors.Add('');
      Errors.Add(msg);
//      RollbackTrans;
    end;
  end;
end;

function TERPDAFuelMapper.ProcessCSVFile(reader: TStreamReader): boolean;
var
  line: TStringDynArray;
  lineStr: string;
  lineNo: integer;
  x: integer;
  filter: TJsonObject;
  colNo: integer;
  loadLine: boolean;
  data: TJsonObject;
  msg: string;

begin
  result := false;
//  if Config.O['InputFile'].O['DataFormatParams'].S['FieldSep'] = '' then begin
//    raise Exception.Create(ClassName + ' Error - Field Separator missing from Mapping Configuration');
//    exit;
//  end;
  { assume comma separated }
  data := JO;
  try
    lineNo := 0;
    while not reader.EndOfStream do begin
      Inc(LineNo);
      SetLength(line,0);
      { split up columns }
//      if Config.O['InputFile'].O['DataFormatParams'].B['QuotedStrings'] then
//        line := StringUtils.SplitString(reader.ReadLine,Config.O['InputFile'].O['DataFormatParams'].S['FieldSep'],'"')
//      else
//        line := StringUtils.SplitString(reader.ReadLine,Config.O['InputFile'].O['DataFormatParams'].S['FieldSep']);
      lineStr := reader.ReadLine;
      line := StringUtils.SplitString(lineStr,FieldSep,'"');
      if Length(line) <> ColList.Count then begin
        Err(ClassName + ' The number of columns for Row Number ' + IntToStr(lineNo) +
          ' (' + IntToStr(Length(line)) +
          ' columns) does not match the Number of Columns expected ' +
          '(' + IntToStr(ColList.Count) +
          ' columns)');
        exit;
      end;
      loadLine := true;
      { check filters }
//      for x := 0 to Config.O['InputFile'].A['Filters'].Count -1 do begin
//        filter := Config.O['InputFile'].A['Filters'].Items[x].AsObject;
//        if SameText(filter.S['SelectWhen'],'DataValid') then begin
//          if  Config.O['InputFile'].O['Columns'].ObjectExists(IntToStr(filter.I['ColumnNumber'])) and
//            (not FieldValid(line[filter.I['ColumnNumber']-1],Config.O['InputFile'].O['Columns'].O[IntToStr(filter.I['ColumnNumber'])])) then
//            loadLine := false;
//        end;
//      end;
      loadLine := DateStrValid(ValByName('Transaction Date',line));
      if loadLine then begin
        { check for errors }
        if not LineOk(line,lineNo,msg) then begin
          Err(msg);
          exit;
        end;
        if not AddLineData(data.A['Lines'],line,lineNo,msg) then begin
          Err(msg);
          exit;
        end;
      end;
    end;

    if data.A['Lines'].Count = 0 then begin
      Err('No data found in input file to process');
      exit;
    end;

    { we now have lines we need to process loaded intp data.A['Lines'] }
    { now map it }

    CoInitialize(nil);
    try
      try
        AppEnv.AppDb.Database := Connection.Database;
        AppEnv.AppDb.ConnectUser(ERPUser, ERPPass);
      except
        on eusr: exception do begin
          msg := 'Error connecting to ERP: ' + eusr.Message;
          Err(msg,meTransient);
          exit;
        end;
      end;
      try
        if not AppEnv.UtilsClient.ConnectUser(msg,'localhost',Connection.Database,ERPUser,'','',true) then begin
          msg := 'Could not connect to ERP. ' + msg;
          Err(msg,meTransient);
          exit;
        end;
        try

          AppEnv.AppDb.TransConnection.StartTransaction;

//          if ImportData(data.A['Lines'],Config.O['Mapping'],msg) then begin
          if MapToERP(data.A['Lines'],msg) then begin
            AppEnv.AppDb.TransConnection.Commit;
          end
          else begin
            Err(msg);
            AppEnv.AppDb.TransConnection.Rollback;
            exit;
          end;

        finally
          AppEnv.UtilsClient.Disconnect;
        end;

      finally
        AppEnv.AppDb.TransConnection.Disconnect;
        AppEnv.AppDb.Connection.Disconnect;
      end;

    finally
      CoUninitialize;
    end;

  finally
    data.Free;
  end;
  result := true;
end;

function TERPDAFuelMapper.ProcessFile(aFileName, aMapName: string): boolean;
var
  stream: TFileStream;
begin
  Log('Processing file: ' + aFileName,ltDetail);
  fLastErrorType := meNone;
  try
    try
      stream := TFileStream.Create(aFileName,fmOpenRead);
      result := ProcessFile(stream,aMapName);
    finally
      stream.Free;
    end;
  except
    on e: exception do begin
      result := false;
      if Pos('Cannot open file',e.Message) > 0 then
        Err(e.Message,meTransient)
      else
        Err(e.Message);
    end;
  end;
end;

function TERPDAFuelMapper.ValByName(aColName: string;
  aLine: TStringDynArray): string;
begin
  result := aLine[ColList.IndexOf(aColName)];
end;

end.
