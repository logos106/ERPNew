unit BusObjTransLinetotals;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  15/11/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TTransLinetotals = class(TMSBusObj)
  private
    function GetEstimatedAmountInc       : Double    ;
    function GetLineTax                  : Double    ;
    function GetTotalLineAmountInc       : Double    ;
    function GetTotalLineAmount          : Double    ;
    function GetTotalCost                : Double    ;
    function GetQtySold                  : Double    ;
    function GetShipped                  : Double    ;
    function GetUOM_WeightShipped        : Double    ;
    function GetUOM_LengthShipped        : Double    ;
    function GetForeignTotalLinePrice    : Double    ;
    function getTransID: Integer;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function LineTotalsQuery:String;virtual;Abstract;
    function getIsReadonly: boolean;Override;
    Function  DoBeforeOpen(Sender :TDatasetBusObj ):Boolean;Override;
  public

    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property TransID                   :Integer     read getTransID                 ;
    property EstimatedAmountInc        :Double      read GetEstimatedAmountInc      ;
    property LineTax                   :Double      read GetLineTax                 ;
    property TotalLineAmountInc        :Double      read GetTotalLineAmountInc      ;
    property TotalLineAmount           :Double      read GetTotalLineAmount         ;
    property TotalCost                 :Double      read GetTotalCost               ;
    property QtySold                   :Double      read GetQtySold                 ;
    property Shipped                   :Double      read GetShipped                 ;
    property UOM_WeightShipped         :Double      read GetUOM_WeightShipped       ;
    property UOM_LengthShipped         :Double      read GetUOM_LengthShipped       ;
    property ForeignTotalLinePrice     :Double      read GetForeignTotalLinePrice   ;
  end;
  TSalesLinetotals = Class(TTransLinetotals)
    Private
      function  GetWETTax               : Double    ;
      function  GetWEGTax               : Double    ;
      function  GetAttrib1Sale          : Double    ;
      function  GetAttrib2Sale          : Double    ;
      function  GetAttrib1SaleRate      : Double    ;
      function  GetAttrib1SaleEst       : Double    ;
      function  GetAttrib2SaleEst       : Double    ;
      function GetMarkup                   : Double    ;
      function GetDiscountsAmt             : Double    ;
      function GetDiscountPercent          : Double    ;
    Protected
      function LineTotalsQuery:String;Override;
    Public
      class function  GetIDField                   : string;              override;
      property WETTax                    :Double      read GetWETTax                  ;
      property WEGTax                    :Double      read GetWEGTax                  ;
      property Attrib1Sale               :Double      read GetAttrib1Sale             ;
      property Attrib2Sale               :Double      read GetAttrib2Sale             ;
      property Attrib1SaleRate           :Double      read GetAttrib1SaleRate         ;
      property Attrib1SaleEst            :Double      read GetAttrib1SaleEst          ;
      property Attrib2SaleEst            :Double      read GetAttrib2SaleEst          ;
      property Markup                    :Double      read GetMarkup                  ;
      property DiscountsAmt              :Double      read GetDiscountsAmt            ;
      property DiscountPercent           :Double      read GetDiscountPercent         ;
  End;
  TPOLinetotals = Class(TTransLinetotals)
    Private
    Protected
      function LineTotalsQuery:String;Override;
    Public
      class function  GetIDField                   : string;              override;
  End;
  TExpenseLinetotals = Class(TTransLinetotals)
    Private
    Protected
      function LineTotalsQuery:String;Override;
    Public
      class function  GetIDField                   : string;              override;
  End;


implementation


uses tcDataUtils, CommonLib, tcConst , sysutils, SystemLib, AppEnvironment,
  BusObjTrans, LogLib;



  {TTransLinetotals}

constructor TTransLinetotals.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'saleslinessum';
  fSQL := LineTotalsQuery;
end;


destructor TTransLinetotals.Destroy;
begin
  inherited;
end;


function TTransLinetotals.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TTransLinetotals.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTransLinetotals.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TTransLinetotals.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TTransLinetotals.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TTransLinetotals.getIsReadonly: boolean;
begin
  // inherited;
  Result := True;
end;

class function TTransLinetotals.GetBusObjectTablename: string;
begin
  Result:= '';
end;


function TTransLinetotals.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TTransLinetotals.DoBeforeOpen(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoBeforeOpen(Sender);
  logtext(sql);
end;
function TTransLinetotals.getTransID: Integer;
begin
  Result :=0;
  if Assigned(Owner) then
    if Owner is TTransbase then
      REsult := TTransbase(Owner).ID;
end;

{Property Functions}
function  TTransLinetotals.GetEstimatedAmountInc   : Double    ; begin Result := GetFloatField('EstimatedAmountInc');end;
function  TTransLinetotals.GetLineTax              : Double    ; begin Result := GetFloatField('LineTax');end;
function  TTransLinetotals.GetTotalLineAmountInc   : Double    ; begin Result := GetFloatField('TotalLineAmountInc');end;
function  TTransLinetotals.GetTotalLineAmount      : Double    ; begin Result := GetFloatField('TotalLineAmount');end;
function  TTransLinetotals.GetTotalCost            : Double    ; begin Result := GetFloatField('TotalCost');end;
function  TTransLinetotals.GetQtySold              : Double    ; begin Result := GetFloatField('QtySold');end;
function  TTransLinetotals.GetShipped              : Double    ; begin Result := GetFloatField('Shipped');end;
function  TTransLinetotals.GetUOM_WeightShipped    : Double    ; begin Result := GetFloatField('UOM_WeightShipped');end;
function  TTransLinetotals.GetUOM_LengthShipped    : Double    ; begin Result := GetFloatField('UOM_LengthShipped');end;
function  TTransLinetotals.GetForeignTotalLinePrice: Double    ; begin Result := GetFloatField('ForeignTotalLinePrice');end;

{ TSalesLinetotals }

class function TSalesLinetotals.GetIDField: string;begin  REsult := 'SaleID';end;
function  TSalesLinetotals.GetWETTax               : Double    ; begin Result := GetFloatField('WETTax');end;
function  TSalesLinetotals.GetWEGTax               : Double    ; begin Result := GetFloatField('WEGTax');end;
function  TSalesLinetotals.GetAttrib1Sale          : Double    ; begin Result := GetFloatField('Attrib1Sale');end;
function  TSalesLinetotals.GetAttrib2Sale          : Double    ; begin Result := GetFloatField('Attrib2Sale');end;
function  TSalesLinetotals.GetAttrib1SaleRate      : Double    ; begin Result := GetFloatField('Attrib1SaleRate');end;
function  TSalesLinetotals.GetAttrib1SaleEst       : Double    ; begin Result := GetFloatField('Attrib1SaleEst');end;
function  TSalesLinetotals.GetAttrib2SaleEst       : Double    ; begin Result := GetFloatField('Attrib2SaleEst');end;
function  TSalesLinetotals.GetMarkup               : Double    ; begin Result := GetFloatField('Markup');end;
function  TSalesLinetotals.GetDiscountsAmt         : Double    ; begin Result := GetFloatField('DiscountsAmt');end;
function  TSalesLinetotals.GetDiscountPercent      : Double    ; begin Result := GetFloatField('DiscountPercent');end;
function  TSalesLinetotals.LineTotalsQuery: String;
begin
  Result :='select ' + NL +
           ' SL.saleID, ' + NL +
           ' Sum(SL.qtySold * SL.LinePriceInc) as  EstimatedAmountInc, ' + NL +
           ' Sum(SL.Markup) as   Markup, '+ NL +
           ' Sum(SL.Discounts) as   DiscountsAmt, '+ NL +
           ' Sum(if (SL.DiscountPercent>=100 , SL.TotalLineAmountInc , SL.TotalLineAmountInc* (SL.DiscountPercent/(100- SL.DiscountPercent)))) as DiscountPercent,'+ NL +
           ' Sum(SL.LineTax ) as   LineTax, '+ NL +
           ' Sum(SL.TotalLineAmountInc) as   TotalLineAmountInc, '+ NL +
           ' Sum(SL.TotalLineAmount) as   TotalLineAmount, '+ NL +
           ' Sum(if(SL.LineTaxRate=0 , SL.LineCost , SL.LineCost*(1+ SL.LineTaxRate)*SL.shipped)) as TotalCost,'+ NL +
           ' Sum(if(Productname =' +quotedstr(PART_SOPROGRESSPAYMENT) +'  or Productname = ' +quotedstr(PART_PROGRESSShipment) +'  , 0 , SL.qtySold)) as QtySold,'+ NL +
           ' Sum(if(Productname =' +quotedstr(PART_SOPROGRESSPAYMENT) +'  or Productname = ' +quotedstr(PART_PROGRESSShipment) +'  , 0 , SL.Shipped)) as Shipped,'+ NL +
           ' Sum(if(Productname =' +quotedstr(PART_SOPROGRESSPAYMENT) +'  or Productname = ' +quotedstr(PART_PROGRESSShipment) +'  , 0 , SL.UnitofMeasureShipped * UOM.Weight)) as UOM_WeightShipped,'+ NL +
           ' Sum(if(Productname =' +quotedstr(PART_SOPROGRESSPAYMENT) +'  or Productname = ' +quotedstr(PART_PROGRESSShipment) +'  , 0 , SL.UnitofMeasureShipped * UOM.Length)) as UOM_LengthShipped, '+ NL +
           ' Sum(Round(if(' +quotedstr(Booleantostr(Appenv.CompanyPrefs.UseForeignCurrencyOnSales)) +'="T" , Round(SL.LinePriceInc* SL.ForeignExchangeSellRate , ' +inttostr(RoundPlacesGeneral) +'),0) * SL.Shipped , '+ inttostr(CurrencyRoundPlaces)+' ))  as ForeignTotalLinePrice,'+ NL +
           ' Sum(if(SL.LineTaxCode="WC", Round(SL.Shipped * SL.LineCost *(Select Rate from tbltaxcodes where Name ="WET") , '+inttostr(CurrencyRoundPlaces)+') ,0)) WETTax,'+ NL +
           ' Sum(if(SL.LineTaxCode="WC", Round(SL.Shipped * SL.LineCost *(Select Rate from tbltaxcodes where Name ="WEG") , '+inttostr(CurrencyRoundPlaces)+') ,0)) WEGTax,'+ NL +
           ' Sum(SL.Attrib1Sale ) as   Attrib1Sale, '+ NL +
           ' Sum(SL.Attrib2Sale) as   Attrib2Sale, '+ NL +
           ' Sum(SL.Attrib1SaleRate ) as   Attrib1SaleRate, '+ NL +
           ' Sum(SL.Attrib1SaleEst ) as   Attrib1SaleEst, '+ NL +
           ' Sum(SL.Attrib2SaleEst) as    Attrib2SaleEst'+ NL +
           ' from tblsaleslines SL ' + NL +
           ' left join tblunitsofmeasure UOM on SL.UnitOfMeasureID = UOM.UnitID ' + NL +
           ' where Sl.deleted ="F" ';
end;

{ TPOLinetotals }

class function TPOLinetotals.GetIDField: string;
begin
  Result :='';
end;

function TPOLinetotals.LineTotalsQuery: String;
begin

end;

{ TExpenseLinetotals }

class function TExpenseLinetotals.GetIDField: string;
begin
  Result := '';
end;

function TExpenseLinetotals.LineTotalsQuery: String;
begin

end;

initialization
  RegisterClass(TTransLinetotals);

end.
