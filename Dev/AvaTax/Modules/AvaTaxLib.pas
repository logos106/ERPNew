unit AvaTaxLib;

interface

uses IdHTTP, IdSSLOpenSSL , BusObjBase, BusObjSaleBase, JSONObject, classes, ERPEDIBase;

Type
  TAvaTaxERPObj = Class(TComponent)
  Private
    JoAvaTaxsale: TJsonobject;
    JoAvaTaxsaleCtr:Integer;
    //procedure ERPSaleToAvaTaxSaleCallback(const Sender: TBusObj;var Abort: Boolean);
    Function AvaTaxSaleToERPSale(AvaTaxSale:String;ASaleObj :TSalesBase):Boolean;
    //Function ERPSaleToAvaTaxSale(ASaleObj :TSalesBase):String;
    procedure DoOnSynchProg(Sender: TERPEDIBase; var Continue: boolean; msg: string);
    procedure DoOnSynchError(Sender: TObject);
    procedure DoOnLog(const msg: string; const aType: string = '');
  Protected
  Public
    Function CalcAvaTax(ASaleObj: TSalesBase; var msg:String): Boolean;
  Published
  End;

Procedure MakeHttpObj;

implementation

uses AppEnvironment, IdAuthentication, sysutils, ErpSynchAvaTax,
  utAvaTaxCoreService, CoreEDILib, CoreEDIObj, LogLib;

var
      IdHTTP: TIdHTTP;
      data: string;
      LHandler: TIdSSLIOHandlerSocketOpenSSL;
      aBody :TStringlist;


Procedure MakeHttpObj;
begin
      IdHTTP := TIdHTTP.Create(nil);
      LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        IdHTTP.IOHandler := LHandler;
        IdHTTP.Request.Accept          := 'text/javascript';
        IdHTTP.Request.ContentType     := 'application/json';
        IdHTTP.Request.ContentEncoding := 'utf-8';
        IdHTTP.Request.BasicAuthentication     := true;
        IdHTTP.Request.Authentication          := TIdBasicAuthentication.Create;
        IdHTTP.Request.Authentication.Username := Appenv.companyprefs.AvaTax_Username;
        IdHTTP.Request.Authentication.Password := Appenv.companyprefs.AvaTax_Password;
end;
procedure FreeHTTPObj;
begin
    LHandler.Free;
    FreeAndNil(IdHTTP);
end;

{ TAvaTaxERPObj }
procedure TAvaTaxERPObj.DoOnSynchProg(Sender: TERPEDIBase; var Continue: boolean; msg: string);
begin

end;
procedure TAvaTaxERPObj.DoOnSynchError(Sender: TObject);
begin

end;
procedure TAvaTaxERPObj.DoOnLog(const msg: string; const aType: string = '');
begin

end;
function TAvaTaxERPObj.CalcAvaTax(ASaleObj: TSalesBase; var msg:String): Boolean;
var
  ErpSynchavaTax :TErpSynchavaTax;
  avaTaxCoreService : TavaTaxCoreService;
  CoreEDI: TCoreEDI;
begin
  result := False;
  try
      clog('');
      CoreEDI := TCoreEDI.Create;
      try
        InitCodeEDI(CoreEDI);
        avaTaxCoreService := TavaTaxCoreService.Create;
        try
          CoreEDI.AddService(avaTaxCoreService);
          ErpSynchavaTax := TErpSynchavaTax.create;
          try
              ErpSynchavaTax.OnSynchProgress := DoOnSynchProg;
              ErpSynchavaTax.OnSynchError := DoOnSynchError;
              ErpSynchavaTax.CoreService := avaTaxCoreService;
              ErpSynchavaTax.OnLog := DoOnLog;
              if ConnecttoCoreEDI(CoreEDI, avaTaxCoreService, nil) then begin
                 ASaleObj.lines.ignoreCheckSaveSpecialPrice:= true;
                 try
                     if ErpSynchavaTax.SynchERPSaletoAvaTax(ASaleObj) then begin
                      result := true;
                      ASaleObj.calcordertotals;
                      Logtext(inttostr(ASaleObj.ID)+','+
                              Floattostr(ASaleObj.TotalAmount)+','+
                              Floattostr(ASaleObj.TotalAmountinc)+','+
                              Floattostr(ASaleObj.TotalTax));
                     end else begin
                       Msg :=  avaTaxCoreService.ResultData.S['ReturnStatus'];
                     end;
                 finally
                    ASaleObj.lines.ignoreCheckSaveSpecialPrice:= False;
                 end;
              end else begin
                REsult := False;
                if CoreEDI.ConnectError <> '' then msg := CoreEDI.ConnectError
                else Msg:= 'Failed to connect to CoreEDI';
                Logtext(Msg);
              end;
          finally
             ErpSynchavaTax.Free;
          end;
        finally
          //avaTaxCoreService.Free; // this will be freed with coreedi as its added to coreedi as a service
        end;
      finally
        Freeandnil(CoreEDI);
      end;
  Except
        on E:Exception do begin
          // kill the exception
          logtext('Exception :' +E.message);
        end;
  end;

  (*fs:= ERPSaleToAvaTaxSale(ASaleObj);
  if fs= '' then exit;
  MakeHttpObj;
  try
      try
        snd := TStringStream.Create(fs);
        try
          Resdata  := IdHTTP.Post(Appenv.companyprefs.AvaTax_BaseURL+'transactions/createoradjust', snd);

        finally
          snd.Free;
        end;
      Except
        on E: Exception do begin

        end;
      end;

  finally
    FreeHTTPObj;
  end;*)
end;

(*function TAvaTaxERPObj.ERPSaleToAvaTaxSale(ASaleObj: TSalesBase): String;
begin
  JoAvaTaxsaleCtr:=0;
  JoAvaTaxsale:= Jo;
  try
      if ASaleObj.lines.count =0 then exit;


      ASaleObj.Lines.iteraterecords(ERPSaleToAvaTaxSaleCallback);
      if not(JoAvaTaxsale.exists('Lines')) or
          (JoAvaTaxsale.A['lines'].count =0) then exit;
      if ASaleObj.IsSalesOrder then JoAvaTaxsale.S['type'] :=  'SalesInvoice' else JoAvaTaxsale.S['type'] :=  'undefined';
      JoAvaTaxsale.S['companyCode']     := Appenv.companyprefs.AvaTax_CompanyID;
      JoAvaTaxsale.DT['date']           := ASaleObj.SaleDate;
      JoAvaTaxsale.S['customerCode']    := ASaleObj.CustomerName;
      JoAvaTaxsale.S['purchaseOrderNo'] := ASaleObj.CustPONumber;
      JoAvaTaxsale.O['addresses'].S['singleLocation'] := ASaleObj.ShipToDesc;
      JoAvaTaxsale.B['commit'] := True;
      JoAvaTaxsale.S['currencyCode'] := ASaleObj.ForeignExchangeCode;
      JoAvaTaxsale.S['description'] := ASaleObj.Comments;
  finally
    Result := JoAvaTaxsale.asString;
    FreeandNil(JoAvaTaxsale);
  end;
end;
Procedure TAvaTaxERPObj.ERPSaleToAvaTaxSaleCallback(const Sender: TBusObj; var Abort: Boolean);
var
  ajo : TJsonObject;
begin
  if not(sender is TSalesLineBase) then Exit;
  if TSalesLineBase(Sender).Deleted  then exit;
  ajo :=jo;
  JoAvaTaxsaleCtr := JoAvaTaxsaleCtr + 1;
  ajo.I['number']       := JoAvaTaxsaleCtr;
  ajo.F['quantity']     := TSalesLineBase(Sender).QtyShipped;
  ajo.F['amount']       := TSalesLineBase(Sender).totalLineamount;
  ajo.S['itemCode']     := TSalesLineBase(Sender).Productname;
  ajo.S['description']  := TSalesLineBase(Sender).Product_Description;
  JoAvaTaxsale.A['lines'].add(ajo);
end;*)
Function TAvaTaxERPObj.AvaTaxSaleToERPSale(AvaTaxSale:String;ASaleObj :TSalesBase):Boolean;
begin

end;
end.
