unit ErpSynchAvaTax;

interface

uses JsonObject, ErpSynchObj , BusObjBase , BusObjSaleBase;

Type
TErpSynchAvaTax = Class(TErpSynch)
  private
  Protected
  Public
    Function SynchERPSaletoAvaTax(ASaleObj :TSalesBase):Boolean;
  Published
End;

implementation

uses utAvaTaxCoreService, AppEnvironment,sysutils, utCoreEDIConst,
  ERPdbComponents, BusobjExternalXRef, BusObjTaxCodes, LogLib, BusobjCash,
  busobjPOS, BusObjPOSSale, BusObjSales, CommonLib;


{ TErpSynchAvaTax }

function TErpSynchAvaTax.SynchERPSaletoAvaTax(ASaleObj: TSalesBase): Boolean;
var
  ctr, Taxlinectr:Integer;
  aERPSaleJO:TJsonObject;
  amsg:String;
  joline, SubTaxLine:TJsonObject;
  aSubTaxCodeId :Integer;
  fdTotalRate:double;
  function SubTaxcode(const ataxName, ajurisName, ajurisdictionType:String):String;
  begin
    REsult :=ataxName;
    if trim(ajurisName) <> '' then result := result +' - ' + ajurisName;
    if trim(ajurisdictionType) <> '' then result := result +' ' + ajurisdictionType;
  end;
begin
  result := False;
    if SameTExt(CoreService.ServiceName, Servicename_AvaTax) then begin
      fCurrentSynchItemType := SynchItemType_Sales;
      aERPSaleJO := JO;
      try
          aERPSaleJO := Serialise(ASaleObj);
          ASaleObj.AvaTaxRelated(aERPSaleJO);
          try
                try if devmode then aERPSaleJO.savetofile('i:\temp\to be deleted\avalara\1_aERPSaleJO.json'); except end;
                try
                  Result := TAvaTaxCoreService(CoreService).SendAvaTaxDoc(aERPSaleJO);
                Except
                  on E:Exception do begin
                    LogText('Exit on Error :' + E.message);
                    try if devmode then TAvaTaxCoreService(CoreService).ResultData.savetofile('i:\temp\to be deleted\avalara\2_ResultData.json'); except end;
                    Exit;
                  end;
                end;
                if not result then begin
                    try if devmode then TAvaTaxCoreService(CoreService).ResultData.savetofile('i:\temp\to be deleted\avalara\2_ResultData.json'); except end;
                end else begin
                    try if devmode then TAvaTaxCoreService(CoreService).ResultData.savetofile('i:\temp\to be deleted\avalara\2_ResultData.json'); except end;
                    if (TAvaTaxCoreService(CoreService).ResultData.I['ID']<>0) then begin

                      if TAvaTaxCoreService(CoreService).ResultData.Exists('Response') then begin
                        if TAvaTaxCoreService(CoreService).ResultData.O['Response'].Exists('Lines') and
                           (TAvaTaxCoreService(CoreService).ResultData.O['Response'].A['Lines'].count>0) then begin
                            ASaleObj.DeleteAllTaxLines;
                            for ctr:= 0 to TAvaTaxCoreService(CoreService).ResultData.O['Response'].A['Lines'].count-1 do begin
                              joline :=TJsonObject(TAvaTaxCoreService(CoreService).ResultData.O['Response'].A['Lines'][ctr]);
                              if ASaleObj.lines.Locate('SeqNo' ,joLine.S['lineNumber'], []) then begin
                                  ASaleObj.Lines.AllowTaxinput := true;
                                  try
                                    ASaleObj.lines.DoFieldChange := false;
                                    //ASaleObj.lines.ignoreCheckSaveSpecialPrice:= true;
                                    try
                                      amsg := '';
                                      if joLine.B['isItemTaxable'] then begin
                                        //ASaleObj.lines.LineTaxRate      :=  can't have the tax rate as its in the details array -> joLine.A['Details'][xctr].F['rate']
                                        ASaleObj.lines.Totallineamount    := joLine.F['taxableAmount']; amsg := floattostr(ASaleObj.lines.Totallineamount )+',';
                                        ASaleObj.lines.LineTaxCode        := joLine.S['taxCode']      ; amsg := amsg+ASaleObj.lines.LineTaxCode +',';
                                        ASaleObj.lines.totallineamountinc := ASaleObj.lines.Totallineamount +joLine.F['taxCalculated']     ; amsg := amsg+floattostr(ASaleObj.lines.Totallineamountinc )+',';
                                        //ASaleObj.lines.DoFieldChange    := true;
                                        ASaleObj.lines.LineTaxTotal       := joLine.F['taxCalculated']; amsg := amsg+floattostr(ASaleObj.lines.LineTaxTotal )+',';
                                        ASaleObj.lines.LineTaxrate        := joLine.F['Rate']      ;
(*                                        TTaxCode.MakeaTaxcode(ASaleObj, ASaleObj.lines.LineTaxCode,ASaleObj.lines.LineTaxCode, ASaleObj.lines.LineTaxRate);
                                        ///if ASaleObj.lines.SalesTaxCode.count >1 then ASaleObj.lines.SalesTaxCode.deleteall; // just in case
                                        if ASaleObj.lines.SalesTaxCode.count =0 then begin
                                          // this is for testing -- this should not happen. Posting Salesline should create this record
                                          ASaleObj.lines.SalesTaxCode.New;
                                          ASaleObj.lines.SalesTaxCode.TaxCodeId :=  TTaxCode.IDToggle(ASaleObj.lines.LineTaxCode);
                                          ASaleObj.lines.SalesTaxCode.TaxCode   :=  ASaleObj.lines.LineTaxCode;
                                          ASaleObj.lines.SalesTaxCode.TotalTax  :=  ASaleObj.lines.LineTaxTotal;
                                          ASaleObj.lines.SalesTaxCode.TotallineAmountinc  :=  ASaleObj.lines.TotalLineamountinc;
                                          ASaleObj.lines.SalesTaxCode.PostDB;
                                        end;
                                        //ASaleObj.lines.SalesTaxCode.Lines.DEleteall; // have to delete the tax lines as changing a shipto address can have entirely different taxcodes
                                        if joLine.Exists('details') then begin
                                          if joLine.A['details'].count >0 then begin
                                            for Taxlinectr := 0 to joLine.A['details'].count-1 do begin
                                              SubTaxLine := TJsonObject(joLine.A['details'][Taxlinectr]);
                                              //aSubTaxCodeId := TSubTaxCode.MakeSubTaxCode(ASaleObj, SubTaxLine.S['taxName'], SubTaxLine.S['TaxName'], SubTaxLine.S['jurisdictionType'],  SubTaxLine.S['country'],ASaleObj.connection);
                                              aSubTaxCodeId := TSubTaxCode.MakeSubTaxCode(ASaleObj,
                                                                                          SubTaxcode(SubTaxLine.S['taxName'], SubTaxLine.S['jurisName'] ,SubTaxLine.S['jurisdictionType']),//SubTaxLine.S['TaxName'],
                                                                                          SubTaxcode(SubTaxLine.S['taxName'], SubTaxLine.S['jurisName'] ,SubTaxLine.S['jurisdictionType']),//SubTaxLine.S['TaxName'],
                                                                                          SubTaxLine.S['jurisdictionType'],
                                                                                          SubTaxLine.S['country'],
                                                                                          ASaleObj.connection);
                                              if aSubTaxCodeId  <> 0 then begin
                                                if not ASaleObj.lines.SalesTaxCode.Lines.Locate('SubTaxID' ,aSubTaxCodeId, []) then begin
                                                  ASaleObj.lines.SalesTaxCode.Lines.New;
                                                  ASaleObj.lines.SalesTaxCode.Lines.TransTaxCodeID := ASaleObj.lines.SalesTaxCode.ID;
                                                  ASaleObj.lines.SalesTaxCode.Lines.SubTaxID       := aSubTaxCodeId;
                                                  ASaleObj.lines.SalesTaxCode.Lines.SubTaxCode     := SubTaxcode(SubTaxLine.S['taxName'], SubTaxLine.S['jurisName'] ,SubTaxLine.S['jurisdictionType']);
                                                  ASaleObj.lines.SalesTaxCode.Lines.Percentage     := SubTaxLine.F['Rate']*100;
                                                  ASaleObj.lines.SalesTaxCode.Lines.TaxAmount      := SubTaxLine.F['taxCalculated'];  // there are 4 fields in the response for this tax -> Tax, taxCalculated , reportingTax, reportingTaxCalculated
                                                  ASaleObj.lines.SalesTaxCode.Lines.PostDB;
                                                end;
                                              end;
                                            end;
                                          end;

                                        end;*)
                                      end else begin
                                        //ASaleObj.lines.SalesTaxCode.Lines.DEleteall; // This item is not taxable, and if it was taxable and tax was calculated, then delete them
                                        ASaleObj.lines.Totallineamountinc := ASaleObj.lines.Totallineamount;amsg := floattostr(ASaleObj.lines.Totallineamount )+',';amsg := amsg+floattostr(ASaleObj.lines.Totallineamountinc )+',';
                                        ASaleObj.lines.LineTaxCode        := joLine.S['taxCode']      ;
                                        ASaleObj.lines.LineTaxrate        := joLine.F['Rate']      ;
                                        if ASaleObj.lines.LineTaxCode ='' then
                                          if Appenv.companyprefs.AvaTaxConfig.NotaxTaxcode <> '' then
                                               ASaleObj.lines.LineTaxCode        :=Appenv.companyprefs.AvaTaxConfig.NotaxTaxcode
                                          else ASaleObj.lines.LineTaxCode        := appenv.regionaloptions.TaxCodeNoTax                                                          ;amsg := amsg+ASaleObj.lines.LineTaxCode +',';
                                        //ASaleObj.lines.DoFieldChange      := true;
                                        ASaleObj.lines.LineTaxTotal       := 0                                                                                                 ;amsg := amsg+floattostr(ASaleObj.lines.LineTaxTotal )+',';
                                      end;

                                        TTaxCode.MakeaTaxcode(ASaleObj, ASaleObj.lines.LineTaxCode,ASaleObj.lines.LineTaxCode, ASaleObj.lines.LineTaxRate);
                                        if ASaleObj.lines.SalesTaxCode.count =0 then begin
                                          // this is for testing -- this should not happen. Posting Salesline should create this record
                                          ASaleObj.lines.SalesTaxCode.New;
                                        end;
                                        ASaleObj.lines.SalesTaxCode.TaxCodeId :=  TTaxCode.IDToggle(ASaleObj.lines.LineTaxCode);
                                        ASaleObj.lines.SalesTaxCode.TaxCode   :=  ASaleObj.lines.LineTaxCode;
                                        ASaleObj.lines.SalesTaxCode.TotalTax  :=  ASaleObj.lines.LineTaxTotal;
                                        ASaleObj.lines.SalesTaxCode.TotallineAmountinc  :=  ASaleObj.lines.TotalLineamountinc;
                                        ASaleObj.lines.SalesTaxCode.PostDB;
                                        //ASaleObj.lines.SalesTaxCode.Lines.DEleteall; // have to delete the tax lines as changing a shipto address can have entirely different taxcodes
                                        fdTotalRate:= 0;
                                        if joLine.Exists('details') then begin
                                          if joLine.A['details'].count >0 then begin
                                            for Taxlinectr := 0 to joLine.A['details'].count-1 do begin
                                              SubTaxLine := TJsonObject(joLine.A['details'][Taxlinectr]);
                                              //aSubTaxCodeId := TSubTaxCode.MakeSubTaxCode(ASaleObj, SubTaxLine.S['taxName'], SubTaxLine.S['TaxName'], SubTaxLine.S['jurisdictionType'],  SubTaxLine.S['country'],ASaleObj.connection);
                                              aSubTaxCodeId := TSubTaxCode.MakeSubTaxCode(ASaleObj,
                                                                                          SubTaxcode(SubTaxLine.S['taxName'], SubTaxLine.S['jurisName'] ,SubTaxLine.S['jurisdictionType']),//SubTaxLine.S['TaxName'],
                                                                                          SubTaxcode(SubTaxLine.S['taxName'], SubTaxLine.S['jurisName'] ,SubTaxLine.S['jurisdictionType']),//SubTaxLine.S['TaxName'],
                                                                                          SubTaxLine.S['jurisdictionType'],
                                                                                          SubTaxLine.S['country'],
                                                                                          ASaleObj.connection);
                                              if aSubTaxCodeId  <> 0 then begin
                                                if not ASaleObj.lines.SalesTaxCode.Lines.Locate('SubTaxID' ,aSubTaxCodeId, []) then begin
                                                  ASaleObj.lines.SalesTaxCode.Lines.New;
                                                  ASaleObj.lines.SalesTaxCode.Lines.TransTaxCodeID := ASaleObj.lines.SalesTaxCode.ID;
                                                  ASaleObj.lines.SalesTaxCode.Lines.SubTaxID       := aSubTaxCodeId;
                                                  ASaleObj.lines.SalesTaxCode.Lines.SubTaxCode     := SubTaxcode(SubTaxLine.S['taxName'], SubTaxLine.S['jurisName'] ,SubTaxLine.S['jurisdictionType']);
                                                  if SubTaxLine.F['taxableAmount'] <> 0 then begin
                                                      ASaleObj.lines.SalesTaxCode.Lines.Percentage     := SubTaxLine.F['Rate']*100;
                                                  end else begin
                                                      ASaleObj.lines.SalesTaxCode.Lines.Percentage     := 0;
                                                  end;
                                                  fdTotalRate := fdTotalRate +ASaleObj.lines.SalesTaxCode.Lines.Percentage;
                                                  ASaleObj.lines.SalesTaxCode.Lines.TaxAmount      := SubTaxLine.F['taxCalculated'];  // there are 4 fields in the response for this tax -> Tax, taxCalculated , reportingTax, reportingTaxCalculated
                                                  ASaleObj.lines.SalesTaxCode.Lines.PostDB;
                                                end;
                                              end;
                                            end;
                                          end;

                                        end;
                                      ASaleObj.lines.LineTaxrate        := DIVZer(fdTotalRate,100);
                                      ASaleObj.lines.PostDB;
                                      TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_SalesLines,
                                                             ASaleObj.lines.Id,inttostr(joLine.I['ID']),amsg,
                                                             0,TERPconnection(ASaleObj.Connection.Connection) );
                                      ASaleObj.lines.DoOnLineTaxChange;
                                      ASaleObj.lines.PostDB;
                                    finally
                                      ASaleObj.lines.DoFieldChange := TRue;
                                      //ASaleObj.lines.ignoreCheckSaveSpecialPrice:= False;
                                    end;
                                    /////ASaleObj.lines.CalcLinetotals;
                                    amsg := amsg+floattostr(ASaleObj.lines.TotalLineAmount )+','+
                                                   floattostr(ASaleObj.lines.TotalLineamountinc )+','+
                                                   floattostr(ASaleObj.lines.LineTaxTotal )+','+
                                                   ASaleObj.lines.LineTaxCode;
                                    Logtext(amsg);
                                  finally
                                     ASaleObj.Lines.AllowTaxinput := False;
                                  end;
                              end;
                            end;
                           TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Sales,
                               ASaleObj.Id,inttostr(TAvaTaxCoreService(CoreService).ResultData.I['ID']),amsg,
                               0,TERPconnection(ASaleObj.Connection.Connection) , TAvaTaxCoreService(CoreService).ResultData.O['Response'].S['Code']);
                           end;
                      end;
                    end;
                end;
          Except
            on E:Exception do begin
               Logtext('Error :' + E.message);
            end;
          end;

      finally
        aERPSaleJO.Free;
      end;
    end;


end;

end.
