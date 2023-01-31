unit ClientDiscountObj;
{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/10/05  1.00.01 IJB  Modified function ClientPrice_Discounts, added params
                        'ResultMessage' and 'Silent' so this can be called
                        from non-visual business objects.

}
interface

uses
  MyAccess,ERPdbComponents, ProductPriceObj;

const

  {
   Discount Types:

   1. EXTRA_SELL (Set on Product using 'Extra Sell Price' Tab)
    This discount is given by Client type.  A % discount is applied to the
    Volume (Qty) Price. (Client Type EG. Plumbers, wholesalers...)

    2. PERMANENT (Set on Customer using Special Prods Tab)
    This discount is applied accross the board for the customer it applies to.

    3.SPEC_DISC (Set on Customer and applied in the Product form by checking Special Discount)
    This discount is given on all products designated as "special".  The amount of discount is
    specified using the customer forms "Special Products" Tab using the
    "Special Products Discount" edit box

    4.SPEC_PRICE_DISC (Set on customer)
    This discount is set on the customer form using the grid in the
    "Special Products" Tab.  Each product is simply given a special price

    5. PROD_GROUP_DISC (Set on customer form using Grid in Group Disc Tab)
    Given to Customers as a % disc if a product is of a certain product group
    ie. Productgroup column (eg Hardware).

    Also each product can have a different price according to the quantity sold,
    Price1, Price2, Price3.  This is known in POS as a volume discount.
  }
  DISC_NONE           = 0;
  EXTRA_SELL          = 1;
  PERMANENT           = 2;
  SPEC_DISC           = 3;
  SPEC_PRICE_DISC     = 4;
  PROD_GROUP_DISC     = 5;
  EXTRA_SELL_OVERRIDE =6;
  CSP_DISC            = 7;
  EXCEL_PRICE_DISC    = 8;


  BEST_DISCOUNT_EXTRASELLPRICE      = 1;
  BEST_DISCOUNT_PERMANENTDISOCUNT   = 2;
  BEST_DISCOUNT_SPECIALDISCOUNT     = 3;
  BEST_DISCOUNT_PRODUCTGROUPDISCOUNT= 5;
  BEST_DISCOUNT_GENERAL             = 6;
  BEST_DISCOUNT_CSP_DISC            = 7;
  BEST_DISCOUNT_EXCELPRICE          = 8;

type
  TClientDiscountObj = class(TObject)
  private
    ProductPriceObj           : TProductPriceObj;
    fiDiscountType            : integer;
    fiExtraSellpriceId        : Integer;
    fiGrpDiscID               : Integer;
    fiCustomerLinesID         : Integer;
    fsClientPriceAllDiscounts : String;
    fsClientPriceDiscount     : String;
    fLastMessageStr           : string;
    fbOverridePartspecialPrice: Boolean;
    fbOverridePartsGroupDiscount: Boolean;

    fqryInsertSP      :TERPCommand;
    fClientQry        :TERPQuery;
    fProductQry       :TERPQuery;
    fClientDiscQry    :TERPQuery;
    fESPQry           :TERPQuery;
    fProdGroupDiscsQry:TERPQuery;
    fbpartsforexcelpriceOverrides :Boolean;
    fbHaspartsforexcelprice :Boolean;
    fdpartsforexcelprice,fdpartsforexcelpriceDefaultQty,fdpartsforexcelpriceDisc:double;
    //fExcelPriceQry    :TERPQuery;

    function OverrideWithGroupDiscount(ClientID: integer): boolean;
    function OverrideWithProductspecialPrice(ClientID: integer): boolean;
    procedure NoRepeatInfoMessage(aMsg: string);

    Function ClientQry        (Const ClientID:Integer):TERPQuery;
    Function ProductQry       (Const ProductID:Integer):TERPQuery;
    Function ClientDiscQry    (Const ClientID, ProductID, UOMID:Integer; TransactionDate :TDAteTime):TERPQuery;
    Function ESPQry           (const ClientId, ProductId, UOMID:Integer; Terms :String ; TransactionDate :TDAteTime; Ordered :double): TERPQuery;
    function ProdGroupDiscsQry(const clientId:Integer; col1, col2, col3 :String): TERPQuery;
    Procedure LogAllQueries(const ClientID:Integer; Terms :String; ProductID, UOMID, ClassID: integer; const Ordered: double;
                                   const TransactionDate: TDateTime);

    Function qryInsertSP:TERPCommand;
    //function ExcelPriceQry(const ProductId: Integer): TERPQuery;
  public
    constructor Create;
    destructor Destroy; override;
    function ClientPrice_Discounts(const ClientID:Integer; Terms :String; ProductID, UOMID, ClassID: integer; const Ordered: double;
                                   const TransactionDate: TDateTime; const WholeSale: boolean;
                                   var PriceEx: double; var Discount: double; var ExtraSellPartDesc: string; var ResultMessage: string;
                                   const Silent: boolean = false;MatrixRef:String=''; Salehastree:Boolean = False): boolean;
    function Client_Add_SpecialPrice(ClientID, ProductID: integer; PriceEx: currency): boolean;
    property DiscountType: integer read fiDiscountType;
    Property ExtraSellpriceId :Integer read fiExtraSellpriceId;
    Property GrpDiscID :Integer read fiGrpDiscID;
    Property CustomerLinesID :Integer read fiCustomerLinesID;
    Property ClientPriceAllDiscounts:String read fsClientPriceAllDiscounts;
    Property ClientPriceDiscount :String read fsClientPriceDiscount;
    Property OverrideProductspecialPrice :Boolean read fbOverridePartspecialPrice;
    Property OverridePartsGroupDiscount :Boolean read fbOverridePartsGroupDiscount;
    Property partsforexcelpriceOverrides :Boolean read fbpartsforexcelpriceOverrides write fbpartsforexcelpriceOverrides;
    Property partsforexcelprice : Double read fdpartsforexcelprice write fdpartsforexcelprice;
    Property partsforexcelpriceDisc:double read fdpartsforexcelpriceDisc write fdpartsforexcelpriceDisc;
    Property Haspartsforexcelprice :Boolean read fbHaspartsforexcelprice write fbHaspartsforexcelprice;
    Property partsforexcelpriceDefaultQty : Double read fdpartsforexcelpriceDefaultQty write fdpartsforexcelpriceDefaultQty;

  end;

implementation

uses Forms, Controls, SysUtils,  Math, Dialogs,
  CommonDbLib,CommonLib, AppEnvironment, MySQLConst, ProductQtyLib, LogUtils,
  SalesDiscountValidationObj, StringUtils, tcConst , Dateutils , loglib,
  DbSharedObjectsObj, ExcelfileObj, tcDataUtils;

{ TClientDiscountObj }

function TClientDiscountObj.ClientPrice_Discounts(const ClientID:Integer; Terms :String;  ProductID, UOMID, ClassID: integer;
  const Ordered: double; const TransactionDate: TDateTime; const WholeSale: boolean;
  var PriceEx: double; var Discount: double; var ExtraSellPartDesc: string; var ResultMessage: string;
  const Silent: boolean = false;MatrixRef:String=''; Salehastree:Boolean = False): boolean;
var
  ExtraSellDiscTemp, ExtraSellDisc, PermanentDiscount, SpecialDiscount, SpecialPriceDiscount, SpecialPrice: double;
  ExtraSellPrice1 : double;
  ProdGroupDiscount: double;
  BestDiscount: integer;
  I: integer;
  (*PriceMatrixPartDesc, *)ExtraSellDesc: string;
  fbExtraSellExtraSellPriceOverridesAllDiscounts:boolean;
  LinePrice:Double;
  Msg:String;
  aDiscountAmt:Double;
  fiMatcho:Integer;

  function Ishighest(const aSearchValue :Double; aSearchList :Array of Double):Boolean;
  var
    ctr:Integer;
  begin
    Result := False;
    for ctr := low(aSearchList) to high(aSearchList) do begin
      if aSearchValue < aSearchList[ctr] then exit;
    end;
    Result := True;
  end;
begin

        fiExtraSellpriceId:= 0;
        fiGrpDiscID :=0;
        fiCustomerLinesID:=0;
        fsClientPriceAllDiscounts:= '';
        fsClientPriceDiscount := '';
        ExtraSellPrice1 := 0.0;
        LogD('TClientDiscountObj.ClientPrice_Discounts', lbBegin);
        try
          ExtraSellDisc := 0.0;
          (*SpecialPriceDiscount := 0.0;*)
//          SpecialPrice := 0.0;
          PriceEx := 0.0;
          Discount := 0.0;
          Result := false;
          try
            LogAllQueries(ClientID,Terms ,ProductID, UOMID, ClassID,Ordered,TransactionDate);
            With ClientDiscQry(clientId, productID ,uomid,  TransactionDate) do begin
              fbExtraSellExtraSellPriceOverridesAllDiscounts := Fieldbyname('ExtraSellPriceOverridesAllDiscounts').asBoolean;
              if RecordCount > 0 then begin
                //ExtraSellDisc
                With ESPQry(ClientId, ProductId, UOMID,Terms,TransactionDate,Ordered ) do begin
                    if fESPQry.RecordCount > 0 then begin
                          First;
                          {get the first record info}
                          ExtraSellDisc := Round(FieldByName('QtyPercent1').AsFloat,GeneralRoundPlaces) /100;
                          ExtraSellDesc := FieldByName('ExtraSellDesc').AsString;
                          fiExtraSellpriceId:= Fieldbyname('PriceID').asInteger;
{1:----------------------}ExtraSellPrice1 := FieldByName('Price1').AsFloat;


                          for I := 0 to RecordCount - 1 do begin
                              if Round(FieldByName('QtyPercent1').AsFloat, GeneralRoundPlaces) / 100>= ExtraSellDisc then begin
{2:----------------------------}ExtraSellDisc := Round(FieldByName('QtyPercent1').AsFloat, GeneralRoundPlaces) / 100;
                                ExtraSellDesc := FieldByName('ExtraSellDesc').AsString;
                                fiExtraSellpriceId:= Fieldbyname('PriceID').asInteger;
                              end;
                            Next;
                          end;
                    end;
                  end;
                end;

                // Get Product Group Discount
                ProdGroupDiscount := 0.0;

                if not ProductQry(ProductID).IsEmpty then begin
                    With ProdGroupDiscsQry(ClientID ,
                                          EscSqlSpecialChars(fProductQry.FieldByName('col1').AsString) ,
                                          EscSqlSpecialChars(fProductQry.FieldByName('col2').AsString),
                                          EscSqlSpecialChars(fProductQry.FieldByName('col3').AsString)) do begin
                    ProdGroupDiscount := 0.0;
                    if RecordCount > 0 then begin
                      First;
{3:------------------}ProdGroupDiscount := FieldByName('Discount').AsFloat;
                      fiGrpDiscID := FieldByname('GrpDiscID').asInteger;
                    end;
                  end;
                  ProdGroupDiscount := ProdGroupDiscount / 100;
                end;
                //PermanentDiscount
{4:-------------}PermanentDiscount := FieldByName('PermanentDiscount').AsFloat;

                //SpecialDiscount
{5:-------------}if FieldByName('IsSpecialDiscount').AsString = 'T' then begin
                  SpecialDiscount := FieldByName('SpecialDiscount').AsFloat;
                end else begin
                  SpecialDiscount := 0.0;
                end;

                //SpecialPrice as a Discount
{6:-------------}if FieldByName('SpecialPrice').AsFloat <> 0.0 then begin
                  SpecialPriceDiscount := DivZer(FieldByName('PRICE1').AsFloat - FieldByName('SpecialPrice').AsFloat,
                      FieldByName('PRICE1').AsFloat);
                  SpecialPrice := FieldByName('SpecialPrice').AsFloat;
                end else begin
                  SpecialPriceDiscount := 0.0;
                  SpecialPrice := 0.0;
                end;

               (* With ExcelPriceQry do begin
                     if recordcount >0 then begin
                      fiExcelPriceId := fieldbyname('ID').asInteger;
                      if fieldbyname('ExcelPopupOption').asBoolean then begin
                        // wait until input selected
                      end;
                      fbExcelSellPriceOverridesOtherPrices := fieldbyname('ExcelSellPriceOverridesOtherPrices').asBoolean;
                      fdpartsforexcelprice := calcpartsforexcelprice(fiExcelPriceId; );

                     end;
                end;*)
                 //if (Appenv.Companyprefs.HasExcelPrices) then begin
                 if HasExcelPriceforProduct(ProductID, False ) then begin
    {7:-------------}fdpartsforexcelprice := TExcelObj.calcpartsforexcelprice(Owner, ProductId,  fbpartsforexcelpriceOverrides,fbHaspartsforexcelprice, fdpartsforexcelpriceDefaultQty, false );
                     if fdpartsforexcelprice <> 0 then
                      fdpartsforexcelpriceDisc := DivZer(FieldByName('PRICE1').AsFloat - fdpartsforexcelprice,FieldByName('PRICE1').AsFloat);
                 end else begin
                  fdpartsforexcelprice          := 0;
                  fdpartsforexcelpriceDisc      := 0;
                  fbpartsforexcelpriceOverrides := False;
                  fbHaspartsforexcelprice       := False;
                  fdpartsforexcelpriceDefaultQty:= 0;
                 end;

                // 1 - ExtraSell
                // 2 - Permanent
                // 3 - SpecialDiscount
                // 4 - Special Price Discount
                // 5 - Product Group Discount
                // 6 - special Price
                // 7 - Excel price

                fsClientPriceAllDiscounts :=
                    'Product''s Extra Sell Price Discount (%) :'                  + FloatToStrF(ExtraSellDisc * 100 , ffFixed , 15, 2)+ chr(13) +
                    'Customer''s Permanent Discount (%) :'                        + FloatToStrF( PermanentDiscount * 100, ffFixed , 15, 2)+ chr(13) +
                    'Customer''s Special Product Discount (%) :'                  + FloatToStrF( SpecialDiscount * 100, ffFixed , 15, 2)+ chr(13) +
                    'Customer''s Special Products   (%) :'                        + FloatToStrF( SpecialPriceDiscount * 100, ffFixed , 15, 2)+ chr(13) +
                    'Customer''s Group Discounts   (%) :'                         + FloatToStrF( ProdGroupDiscount * 100, ffFixed , 15, 2)+ chr(13) +
                    'Customer''s Group Discount Overrides All Discounts :'        + BooleanToString(OverrideWithGroupDiscount(ClientID))+chr(13) +
                    'Customer''s special Price    :'                              + FloatToStrF( SpecialPrice , ffFixed , 15, 2)+ chr(13) +
                    'Customer''s Special  Price Overrides All Discounts :'        + BooleanToString(Appenv.CompanyPrefs.CSPOverridesRawMaterialPrices)+chr(13) +
                    'Customer''s Special Product Price Overrides All Discounts :' + BooleanToString(OverrideWithProductspecialPrice(clientID))+chr(13) +
                    'Product''s Extra Sell Price Overrides All Other Discounts :' + BooleanToString(fbExtraSellExtraSellPriceOverridesAllDiscounts)+chr(13) +
                    'Company Pref''s Special Product Price Overrides All Discounts For All customers :' +BooleanToString(AppEnv.CompanyPrefs.SpecialProductOverridesDiscounts)+chr(13) +
                    'Company Pref''s Maximum Allowed Discount :'                  + FloatToStrF( Appenv.CompanyPrefs.MaxDiscountPercentage * 100, ffFixed , 15, 2)+  ' %'+chr(13) +
                    'Employee Pref''s Maximum Allowed Discount :'                 + FloatToStrF( AppEnv.Employee.EmployeemaxDiscountPercentage * 100, ffFixed , 15, 2)+  ' %'+ Char(13);
                if fdpartsforexcelprice <> 0 then
                  fsClientPriceAllDiscounts := fsClientPriceAllDiscounts +
                    'Excel Price (' + AppEnv.RegionalOptions.CurrencySymbol +') :'                 + FloatToStrF( fdpartsforexcelprice, ffCurrency , 15, 2)+ Char(13) +
                    'Excel Price Overrides All Other Prices : ' + BooleanToString(fbpartsforexcelpriceOverrides)+chr(13) ;



                if  Salehastree
                    and not(Appenv.CompanyPrefs.CSPOverridesRawMaterialPrices)
                    and Appenv.CompanyPrefs.BOMPriceOverridesAllOtherPrice
                    and ((PermanentDiscount <>0) or (SpecialDiscount<>0)) then begin
                      {if price is calculated from the tree,
                      the customer's discounts are already applied to the raw materials ,
                      it should avoided for the top level}
                      SpecialDiscount :=0;
                      PermanentDiscount :=0;
                end;
{--------------}if (fdpartsforexcelprice <> 0) and (fbpartsforexcelpriceOverrides) then begin
                  BestDiscount := BEST_DISCOUNT_EXCELPRICE;
{--------------}end else if Salehastree and Appenv.CompanyPrefs.CSPOverridesRawMaterialPrices and (SpecialPrice <> 0) then begin
                  BestDiscount := BEST_DISCOUNT_CSP_DISC;
{--------------}end else if (ExtraSellDisc <> 0.0) or (PermanentDiscount <> 0.0) or (SpecialDiscount <> 0.0) or (SpecialPriceDiscount <> 0.0) or (ProdGroupDiscount <> 0.0) or (fdpartsforexcelpriceDisc<> 0.0) then begin
                       if Ishighest(ExtraSellDisc       , (*vararrayof(*)[PermanentDiscount ,SpecialDiscount,SpecialPriceDiscount,ProdGroupDiscount,fdpartsforexcelpriceDisc]) then BestDiscount := BEST_DISCOUNT_EXTRASELLPRICE
                  else if Ishighest(PermanentDiscount   , (*vararrayof(*)[                   SpecialDiscount,SpecialPriceDiscount,ProdGroupDiscount,fdpartsforexcelpriceDisc]) then BestDiscount := BEST_DISCOUNT_PERMANENTDISOCUNT
                  else if Ishighest(SpecialDiscount     , (*vararrayof(*)[                                   SpecialPriceDiscount,ProdGroupDiscount,fdpartsforexcelpriceDisc]) then BestDiscount := BEST_DISCOUNT_SPECIALDISCOUNT
                  else if Ishighest(SpecialPriceDiscount, (*vararrayof(*)[                                                        ProdGroupDiscount,fdpartsforexcelpriceDisc]) then BestDiscount := BEST_DISCOUNT_PRODUCTGROUPDISCOUNT
                  else if Ishighest(ProdGroupDiscount   , (*vararrayof(*)[                                                                          fdpartsforexcelpriceDisc]) then BestDiscount := BEST_DISCOUNT_GENERAL
                  else                                                                                                                                                           BestDiscount := BEST_DISCOUNT_EXCELPRICE;
                                 (*if (ExtraSellDisc >= PermanentDiscount) and (ExtraSellDisc     >= SpecialDiscount) and (ExtraSellDisc     >= SpecialPriceDiscount) and (ExtraSellDisc        >= ProdGroupDiscount) and (ExtraSellDisc        >= fdpartsforexcelpriceDisc) then begin BestDiscount := BEST_DISCOUNT_EXTRASELLPRICE;
                        end else if                                          (PermanentDiscount >= SpecialDiscount) and (PermanentDiscount >= SpecialPriceDiscount) and (PermanentDiscount    >= ProdGroupDiscount) and (PermanentDiscount    >= fdpartsforexcelpriceDisc) then begin BestDiscount := BEST_DISCOUNT_PERMANENTDISOCUNT;
                        end else if                                                                                     (SpecialDiscount   >= SpecialPriceDiscount) and (SpecialDiscount      >= ProdGroupDiscount) and (SpecialDiscount      >= fdpartsforexcelpriceDisc) then begin BestDiscount := BEST_DISCOUNT_SPECIALDISCOUNT;
                        end else if                                                                                                                                     (SpecialPriceDiscount >= ProdGroupDiscount) and (SpecialPriceDiscount >= fdpartsforexcelpriceDisc) then begin BestDiscount := BEST_DISCOUNT_PRODUCTGROUPDISCOUNT;
                        end else if                                                                                                                                                                                     (ProdGroupDiscount    >= fdpartsforexcelpriceDisc) then begin BestDiscount := BEST_DISCOUNT_GENERAL;
                        end else begin BestDiscount := BEST_DISCOUNT_EXCELPRICE;
                        end;*)
{--------------}end else begin
                    BestDiscount := DISC_NONE;
                    Discount := 0.0;
{--------------}end;


                //Final Set Price  (note discount should be applied against this price)
                if not ProductPriceObj.ProductPrice(ProductID, ClassID, Ordered, PriceEx, WholeSale,MatrixRef) then
                begin
                  ResultMessage := 'Error Occured While Attempting To Get Volume Pricing.';
                  if not Silent then CommonLib.MessageDlgXP_Vista(ResultMessage, mtWarning, [mbOK], 0);
                  Exit;
                end;

                //Final Set Discount
                         if BestDiscount = BEST_DISCOUNT_EXTRASELLPRICE       then begin Discount := ExtraSellDisc;     ExtraSellPartDesc := ExtraSellDesc;
                end else if BestDiscount = BEST_DISCOUNT_PERMANENTDISOCUNT    then begin Discount := PermanentDiscount; ExtraSellDesc := '';
                end else if BestDiscount = BEST_DISCOUNT_SPECIALDISCOUNT      then begin Discount := SpecialDiscount;   ExtraSellDesc := '';
                end else if BestDiscount = BEST_DISCOUNT_PRODUCTGROUPDISCOUNT then begin Discount := 0.0;               ExtraSellDesc := ''; if (FieldByName('SpecialPrice').AsFloat <> 0.00) then PriceEx := FieldByName('SpecialPrice').AsFloat;
                end else if BestDiscount = BEST_DISCOUNT_GENERAL              then begin Discount := ProdGroupDiscount; ExtraSellDesc := '';
                end else if BestDiscount = BEST_DISCOUNT_CSP_DISC             then begin Discount := 0.00;              ExtraSellDesc := ''; if (FieldByName('SpecialPrice').AsFloat <> 0.00) then PriceEx := FieldByName('SpecialPrice').AsFloat;
                end else if BestDiscount = BEST_DISCOUNT_EXCELPRICE           then begin Discount := 0.00;              ExtraSellDesc := '';  PriceEx := fdpartsforexcelprice;
                end;
                fiDiscountType := BestDiscount;

                //product discount overrides based on prefereces
             {1}if (fdpartsforexcelprice<>0) and fbpartsforexcelpriceOverrides then begin
                      Discount := 0.0;
                      PriceEx := fdpartsforexcelprice;
                      fiDiscountType := EXCEL_PRICE_DISC;
            {2}end else if Salehastree and Appenv.CompanyPrefs.CSPOverridesRawMaterialPrices and (SpecialPrice <> 0) then begin
                      Discount := 0.0;
                      PriceEx := FieldByName('SpecialPrice').AsFloat;
                      fiDiscountType := CSP_DISC;
                      fiCustomerLinesID := fieldbyname('CustomerLinesID').asInteger;
            {3}end else if fbExtraSellExtraSellPriceOverridesAllDiscounts then begin
                      if (ExtraSellDisc <> 0) then begin
                        Discount := ExtraSellDisc;
                        ExtraSellPartDesc := ExtraSellDesc;
                        fiDiscountType := EXTRA_SELL;
                      end else if ExtraSellPrice1 > 0 then begin
                        Discount := 0;
                        ExtraSellPartDesc := ExtraSellDesc;
                        fiDiscountType := EXTRA_SELL_OVERRIDE;
                        PriceEx := ExtraSellPrice1;
                      end;
            {4}end else  if (SpecialPriceDiscount <> 0.00) and (OverrideWithProductspecialPrice(clientID)) then begin
                      Discount := 0.0;
                      PriceEx := FieldByName('SpecialPrice').AsFloat;
                      fiDiscountType := SPEC_PRICE_DISC;
                      fiCustomerLinesID := fieldbyname('CustomerLinesID').asInteger;
            {5}end else if (ProdGroupDiscount <> 0.0) and (OverrideWithGroupDiscount(ClientID)) then begin
                      if ProdGroupDiscount > 0 then begin
                        Discount := ProdGroupDiscount;
                        ExtraSellDesc := '';
                        fiDiscountType := PROD_GROUP_DISC;
                      end else begin {Hide Neg- Discount}
                        Discount := 0;
                        ExtraSellDesc := '';
                        PriceEx := PriceEx - RoundCurrency(PriceEx * ProdGroupDiscount);
                        fiDiscountType := PROD_GROUP_DISC;
                      end;
            {6}end else if (FieldByName('SpecialPrice').AsFloat <> 0.0) and (AppEnv.CompanyPrefs.SpecialProductOverridesDiscounts) then begin
                      Discount := 0.0;
                      PriceEx := FieldByName('SpecialPrice').AsFloat;
                      fiDiscountType := SPEC_PRICE_DISC;
               end;

                //Override with Group Discount

                ExtraSellPartDesc := ExtraSellDesc;

                LinePrice:= 0;
                aDiscountAmt:= 0;
                if Discount <> 0 then Discount := Discount*100;
                if not TSalesDiscountValidationObj.ValidateDiscount(nil, aDiscountAmt , Discount , 0 ,PriceEx , LinePrice , Ordered, ProductId , True, True, Msg) then begin
                    if not Silent then NoRepeatInfoMessage(Msg);
                end else begin

                end;
                if Discount <> 0 then Discount := Discount/100;
                         if discounttype = EXTRA_SELL      then begin fsClientPriceDiscount   := 'Product''s Extra Sell Price Discount (%) :'  +FloatToStrF(ExtraSellDisc        * 100, ffFixed , 15, 2);
                end else if discounttype = PERMANENT       then begin fsClientPriceDiscount   := 'Customer''s Permanent Discount (%) :'        +FloatToStrF(PermanentDiscount    * 100, ffFixed , 15, 2);
                end else if discounttype = SPEC_DISC       then begin fsClientPriceDiscount   := 'Customer''s Special Product Discount (%) :'  +FloatToStrF(SpecialDiscount      * 100, ffFixed , 15, 2);
                end else if discounttype = SPEC_PRICE_DISC then begin fsClientPriceDiscount   := 'Customer''s Special Products  (%) :'         +FloatToStrF(SpecialPriceDiscount * 100, ffFixed , 15, 2);
                end else if discounttype = PROD_GROUP_DISC then begin fsClientPriceDiscount   := 'Customer''s Group Discounts  (%) :'          +FloatToStrF(ProdGroupDiscount    * 100, ffFixed , 15, 2);
                end else if discounttype =EXTRA_SELL_OVERRIDE then begin fsClientPriceDiscount:= 'Product''s Extra Sell Price Override ($) :'     +FloatToStrF(PriceEx, ffFixed , 15, 2);
                end else if discounttype =CSP_DISC          then begin fsClientPriceDiscount  := 'Customer''s Special Price Override ($) :'     +FloatToStrF(PriceEx, ffFixed , 15, 2);
                end else if discounttype =EXCEL_PRICE_DISC  then begin fsClientPriceDiscount  := 'EXCEL Price Override ($) :'     +FloatToStrF(PriceEx, ffFixed , 15, 2);
                end;
                Result := true;
              end;
          finally
            //Processingcursor(False);
          end;
        finally
          LogD('', lbEnd);
        end
end;

function TClientDiscountObj.Client_Add_SpecialPrice(ClientID, ProductID: integer; PriceEx: currency): boolean;
var
  ID, Count: integer;
  PartName, Description, OrigPrice, LinePrice: string;
begin
  ID := 0;
  Result := False;
  try
    Processingcursor(True);
    If (ClientID=0) or (ProductID=0) then Exit;
    //with fqryPrep do begin
    With ProductQry(ProductID) do begin
      Count := RecordCount;
      if Count > 0 then begin
        PartName := FieldByName('PARTNAME').AsString;
        Description := FieldByName('PARTSDESCRIPTION').AsString;
        OrigPrice := FieldByName('PRICE1').AsString;
        LinePrice := FloatToStr(StrValue(CurrToStr(PriceEx)));
      end;
      Active := false;
      Sql.Clear;
      Sql.Add('SELECT CustomerLinesID FROM tblcustomerlines ');
      Sql.Add('WHERE CustomerId=' + IntToStr(ClientID) + ' AND ProductID =' + IntToStr(ProductID) + ';');
      Active := true;
      Count := RecordCount;
      if Count > 0 then begin
        ID := FieldByName('CustomerLinesID').AsInteger;
      end;
      Active := false;
      Sql.Clear;
    end;
    with qryInsertSP do begin
      if Count > 0 then begin
        // Update Existing Price
        Connection := CommonDbLib.GetSharedMyDacConnection;
        Sql.Clear;
        Sql.Add('UPDATE tblcustomerlines SET CustomerId =' + IntToStr(ClientID) + ' , ProductID =' + IntToStr(ProductID) + ' ,');
        Sql.Add('Name ="' + PartName + '" , Description ="' + Description + '" , OrigPrice ="' +
          OrigPrice + '" , LinePrice ="' + LinePrice + '"');
        Sql.Add('Where CustomerLinesID =' + IntToStr(ID) + ';');
        Execute;
      end else begin
        // Insert Price
        Sql.Clear;
        Sql.Add('INSERT HIGH_PRIORITY INTO tblcustomerlines (CustomerId,ProductID,Name,Description,OrigPrice,LinePrice)');
        Sql.Add('VALUES ("' + IntToStr(ClientID) + '","' + IntToStr(ProductID) + '","' + PartName +
          '","' + Description + '","' + OrigPrice + '","' + LinePrice + '")');
        Execute;
      end;
    end;
    Result := true;
  finally
    Processingcursor(False);
  end;
end;

constructor TClientDiscountObj.Create;
begin
  Inherited;
  ProductPriceObj := TProductPriceObj.Create;
  fbOverridePartspecialPrice := False;
end;

destructor TClientDiscountObj.Destroy;
begin
  if assigned(fqryInsertSP) then DbSharedObj.ReleaseObj(fqryInsertSP);//FreeandNil(fqryInsertSP);
  FreeandNil(ProductPriceObj);
  if assigned(fClientQry) then DbSharedObjectsObj.DbSharedObj.ReleaseObj(fClientQry);
  if assigned(fProductQry) then DbSharedObjectsObj.DbSharedObj.ReleaseObj(fProductQry);
  if assigned(fClientDiscQry) then DbSharedObjectsObj.DbSharedObj.ReleaseObj(fClientDiscQry);
  if assigned(fESPQry) then DbSharedObjectsObj.DbSharedObj.ReleaseObj(fESPQry);
  if assigned(fProdGroupDiscsQry) then DbSharedObjectsObj.DbSharedObj.ReleaseObj(fProdGroupDiscsQry);
  inherited;
end;

procedure TClientDiscountObj.NoRepeatInfoMessage(aMsg: string);
begin
  if fLastMessageStr <> aMsg then begin
    fLastMessageStr := aMsg;
    CommonLib.MessageDlgXP_Vista(aMsg, mtInformation, [mbOK], 0);
  end;
end;

function TClientDiscountObj.OverrideWithGroupDiscount      (ClientID: integer): boolean;begin  with ClientQry(ClientID) do begin    Result := FieldByName('GroupDiscountOverridesAll').AsBoolean; fbOverridePartsGroupDiscount:= Result; end;end;
function TClientDiscountObj.OverrideWithProductspecialPrice(ClientID: integer): boolean;begin  with ClientQry(ClientID) do begin    Result := FieldByName('SpecialProductPriceOverridesAll').AsBoolean; fbOverridePartspecialPrice := Result; end;end;

function TClientDiscountObj.qryInsertSP: TERPCommand;
begin
  inherited;
  if fqryInsertSP = nil then begin
    fqryInsertSP := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  end;
  REsult := fqryInsertSP;
end;

function TClientDiscountObj.ClientQry(const ClientID:Integer): TERPQuery;
begin

  if fClientQry = nil then  begin
    fClientQry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    fClientQry.ParamCheck := True;
    fClientQry.Sql.Add('Select ClientID, SpecialProductPriceOverridesAll, GroupDiscountOverridesAll From tblclients WHERE ClientID=:ClientID;');
  end;
  if (fClientQry.active = False) or
     (fClientQry.fieldbyname('ClientID').asInteger <> ClientID) then begin
    Closedb(fClientQry);
    fClientQry.parambyname('ClientID').asInteger := clientID;
    Opendb(fClientQry);
  end;
  REsult :=fClientQry;
end;
(*Function TClientDiscountObj.ExcelPriceQry(const ProductId:Integer): TERPQuery;
begin
  if fExcelPriceQry = nil then begin
    fExcelPriceQry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    fExcelPriceQry.ParamCheck := True;
    fExcelPriceQry.Sql.text := 'Select * from tblpartsforexcelprice where productId =:ProductId ';
  end;
  if (fExcelPriceQry.active = False) or (fExcelPriceQry.parambyname('ProductID').asInteger <> ProductID) then begin
    Closedb(fExcelPriceQry);
    fExcelPriceQry.parambyname('ProductID').asInteger := ProductId;
    Opendb(fExcelPriceQry);
    LogQuerySQL(fExcelPriceQry);
  end;
  REsult :=fExcelPriceQry;
end;*)
function TClientDiscountObj.ProductQry(const ProductId:Integer): TERPQuery;
begin
  if fProductQry = nil then  begin
    fProductQry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    fProductQry.ParamCheck := True;
    fProductQry.Sql.Add('Select PartsId,');
    fProductQry.Sql.Add(FirstColumn('tblparts') +' as col1,' );
    fProductQry.Sql.Add(Secondcolumn('tblparts')+' as col2,' );
    fProductQry.Sql.Add(ThirdColumn('tblparts') +' as col3,' );
    fProductQry.Sql.Add('PARTNAME, PARTSDESCRIPTION, PRICE1 ');
    fProductQry.Sql.Add(' From tblparts WHERE PartsId=:ProductID;');
  end;
  if (fProductQry.active = False) or (fProductQry.parambyname('ProductID').asInteger <> ProductID) then begin
    Closedb(fProductQry);
    fProductQry.parambyname('ProductID').asInteger := ProductId;
    Opendb(fProductQry);
    LogQuerySQL(fProductQry);
  end;
  REsult :=fProductQry;
end;
function TClientDiscountObj.ClientDiscQry(const ClientId, ProductId, UOMID:Integer; TransactionDate :TDAteTime): TERPQuery;
begin
  if fClientDiscQry = nil then  begin
    fClientDiscQry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    fClientDiscQry.ParamCheck := True;
    fClientDiscQry.SQL.Add('Select C.ClientID,C.SpecialDiscount,Discount as PermanentDiscount, ');
    fClientDiscQry.SQL.Add('CL.LinePrice as SpecialPrice, ');
    fClientDiscQry.SQL.Add('CL.CustomerLinesID,');
    fClientDiscQry.SQL.Add('SellQTY1,');
    fClientDiscQry.SQL.Add('SellQTY2,SellQTY3,');
    fClientDiscQry.SQL.Add('PRICE1,');
    fClientDiscQry.SQL.Add('PRICE2,PRICE3, ');
    fClientDiscQry.SQL.add('ExtraSellPriceOverridesAllDiscounts ,');
    fClientDiscQry.SQL.Add('P.SpecialDiscount as IsSpecialDiscount  ');
    fClientDiscQry.SQL.Add('From tblparts  P   ');
    fClientDiscQry.SQL.Add('Left Join tblcustomerlines CL ON   CL.ProductID =P.PartsId     ');
    fClientDiscQry.SQL.Add('and CL.customerId = :ClientID' );
    fClientDiscQry.SQL.Add('left join tblclients  C on C.ClientID =:ClientID'   );
    fClientDiscQry.SQL.Add( ' Where P.PartsID = :ProductID ');
    fClientDiscQry.SQL.Add(' and ( CL.UOMID = :UOMID or ifnull(CL.UOMID,0) = 0 )' );
    fClientDiscQry.SQL.Add(' AND ((CL.DateFrom <= :TransactionDate' +
                      ' AND CL.DateTo >= :TransactionDate ) OR IsNull(CL.DateFrom) OR IsNull(CL.DateTo)) ' );

  end;
  if  (fClientDiscQry.active = False) or
     ((fClientDiscQry.Parambyname('ProductID').asInteger <> ProductID) or
      (fClientDiscQry.Parambyname('ClientID').asInteger <> ClientID) or
      (fClientDiscQry.Parambyname('UOMID').asInteger    <> UOMID) or
      (fESPQry.Parambyname('TransactionDate').asDatetime<> TransactionDate) ) then begin
    Closedb(fClientDiscQry);
    fClientDiscQry.Parambyname('ProductID').asInteger := ProductID;
    fClientDiscQry.Parambyname('ClientID').asInteger := ClientID;
    fClientDiscQry.Parambyname('UOMID').asInteger    := UOMID;
    fClientDiscQry.Parambyname('TransactionDate').asDatetime:= TransactionDate;
    Opendb(fClientDiscQry);
    LogQuerySQL(fClientDiscQry);
  end;
  REsult :=fClientDiscQry;
end;

function TClientDiscountObj.ESPQry(const ClientId, ProductId, UOMID:Integer; Terms :String ; TransactionDate :TDAteTime; Ordered :double): TERPQuery;
begin
  if fESPQry = nil then  begin
    fESPQry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    fESPQry.ParamCheck := True;
    fESPQry.SQL.Add('Select EPS.UOMID , EPS.Terms , EPS.PriceID, QtyPercent1, ');
    fESPQry.SQL.Add('DateFrom,DateTo,ExtraSellDesc, Price1   ');
    fESPQry.SQL.Add('From tblextrapricesell EPS ');
    fESPQry.SQL.Add('Left Join tblclients CL on CL.ClientTypeID = EPS.ClientTypeID AND ClientID = :ClientID' + ' ');
    fESPQry.SQL.Add('WHERE (CL.ClientTypeID = EPS.ClientTypeID OR AllClients="T" )AND PartsID = :ProductId' );
    fESPQry.SQL.Add(' and ( EPS.Terms = :Terms or ifnull(EPS.terms,"") ="" )' );
    fESPQry.SQL.Add(' and ( EPS.UOMID = :UOMID or ifnull(EPS.UOMID,0) = 0 )' );
    fESPQry.SQL.Add(' AND ((DateFrom <= :TransactionDate' +
                      ' AND DateTo >= :TransactionDate ) OR IsNull(DateFrom) OR IsNull(DateTo)) ' );
    fESPQry.SQL.Add(' AND (ifnull(QtyLimitforDiscount ,0)=0 OR if(ifnull(UOMMultiplier,0)=0 ,QtyLimitforDiscount , QtyLimitforDiscount*UOMMultiplier) >= :Ordered)' );
    fESPQry.SQL.Add(' order by UOMID desc , Terms Desc;');

  end;
  if  (fESPQry.active = False) or
     ((fESPQry.Parambyname('ProductID').asInteger       <> ProductID) or
      (fESPQry.Parambyname('ClientID').asInteger        <> ClientID) or
      (fESPQry.Parambyname('UOMID').asInteger           <> UOMID) or
      (fESPQry.Parambyname('Terms').asString            <> Terms) or
      (fESPQry.Parambyname('TransactionDate').asDatetime<> TransactionDate) or
      (fESPQry.Parambyname('Ordered').asfloat           <> Ordered) ) then begin
    Closedb(fESPQry);
    fESPQry.Parambyname('ProductID').asInteger       := ProductID;
    fESPQry.Parambyname('ClientID').asInteger        := ClientID;
    fESPQry.Parambyname('UOMID').asInteger           := UOMID;
    fESPQry.Parambyname('Terms').asString            := Terms;
    fESPQry.Parambyname('TransactionDate').asDatetime:= TransactionDate;
    fESPQry.Parambyname('Ordered').asfloat           := Ordered ;
    Opendb(fESPQry);
    LogQuerySQL(fESPQry);
  end;
  REsult :=fESPQry;
end;

procedure TClientDiscountObj.LogAllQueries(const ClientID:Integer; Terms :String; ProductID, UOMID, ClassID: integer; const Ordered: double; const TransactionDate: TDateTime);
begin

    ProductQry(ProductID);
    ClientDiscQry(clientId, productID ,uomid,  TransactionDate) ;
    ESPQry(ClientId, ProductId, UOMID,Terms,TransactionDate,Ordered );
    ProdGroupDiscsQry(ClientID ,
                      EscSqlSpecialChars(fProductQry.FieldByName('col1').AsString) ,
                      EscSqlSpecialChars(fProductQry.FieldByName('col2').AsString),
                      EscSqlSpecialChars(fProductQry.FieldByName('col3').AsString)) ;

end;

function TClientDiscountObj.ProdGroupDiscsQry(const clientId:Integer; col1, col2, col3 :String): TERPQuery;
begin
  if fProdGroupDiscsQry = nil then  begin
    fProdGroupDiscsQry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    fProdGroupDiscsQry.ParamCheck := True;
    fProdGroupDiscsQry.SQL.Add('SELECT GrpDiscID , Col1, Col2, Col3, Discount,');
(*    fProdGroupDiscsQry.SQL.Add('if ((IfNull(Col1,"") = :col1 and IfNull(Col2,"")  = :col2 and IfNull(Col3,"")  = :col3) ,5 , '+
                               'if ((IfNull(Col1,"") = :col1 OR IfNull(Col1,"") ="")  AND '+
                               '     (IfNull(Col2,"") = :col2    OR IfNull(Col2,"") ="")  AND '+
                               '     (IfNull(Col3,"") = :col3          OR IfNull(Col3,"") ="")   ,4 , '+
                               'if(IfNull(Col1,"") = :col1 ,1,0)+if(IfNull(Col2,"") = :col2    ,1,0)+if(IfNull(Col3,"") = :col3,1,0))) AS matchno');*)
    fProdGroupDiscsQry.SQL.Add('if(IfNull(Col1,"") = :col1 ,1,0)+'+
                               'if(IfNull(Col2,"") = :col2 ,1,0)+'+
                               'if(IfNull(Col3,"") = :col3,1,0) AS matchno');

    fProdGroupDiscsQry.SQL.Add('FROM tblprodgroupdiscs');
    fProdGroupDiscsQry.SQL.Add('WHERE ClientID = :ClientID');
    fProdGroupDiscsQry.SQL.Add('and ((IfNull(Col1,"") <> "") or (IfNull(Col2,"") <> "") or (IfNull(Col3,"") <> ""))'); { at least one has a value }
                    { product col1 will always have a value from query above }
    fProdGroupDiscsQry.SQL.Add('and  ((MustMatch = "T" and  (IfNull(Col1,"") <> "" and Col1 = :col1 and col2 = :col2 and col3 = :col3)) '+
                                 ' or (MustMatch = "F" and  ((IfNull(Col1,"") <> "" and Col1 = :col1) OR (IfNull(Col2,"") <> "" and col2 = :col2) Or (IfNull(Col3,"") <> "" and col3 = :col3))))');
    fProdGroupDiscsQry.SQL.Add('ORDER BY matchno desc , Discount');
  end;
  if  (fProdGroupDiscsQry.active = False) or
     ( fProdGroupDiscsQry.Parambyname('ClientID').asInteger <> ClientID) Or
     ( fProdGroupDiscsQry.Parambyname('col1').asString  <> col1) Or
     ( fProdGroupDiscsQry.Parambyname('col2').asString  <> col2) Or
     ( fProdGroupDiscsQry.Parambyname('col3').asString  <> col3) then begin

    Closedb(fProdGroupDiscsQry);
    fProdGroupDiscsQry.Parambyname('ClientID').asInteger  := ClientID;
    fProdGroupDiscsQry.Parambyname('col1').asString  := col1;
    fProdGroupDiscsQry.Parambyname('col2').asString  := col2;
    fProdGroupDiscsQry.Parambyname('col3').asString  := col3;
    Opendb(fProdGroupDiscsQry);
    LogQuerySQL(fProdGroupDiscsQry);
  end;
  REsult :=fProdGroupDiscsQry;
end;
end.

