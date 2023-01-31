unit BusobjProductPriceCalc;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/08/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjStock ;


type
  TPartsPriceCalc = class(TMSBusObj)
  private
    fdManAvgCostPrice        :Double;
    fdManLatestCostPrice     :Double;
    fdMancostWithLabourPrice :Double;
    fdLandedCostPrice        :Double;
    fdTotalLandedcostPrice   :Double;
    fdAvgCostPrice           :Double;
    fdCOST1Price             :Double;
    fdOverheadAmountPrice    :Double;
    fdLatestCostPrice        :Double;


    function GetPartsID                            : Integer   ;
    function GetProductPriceCalctype               : Integer   ;
    function GetLastCostGrossMarginMode            : Boolean   ;
    function GetProductCostGrossMarginMode         : Boolean   ;
    function GetAverageCostGrossMarginMode         : Boolean   ;
    function GetManCostGrossMarginMode             : Boolean   ;
    function GetManAverageCostGrossMarginMode      : Boolean   ;
    function GetManLastCostGrossMarginMode         : Boolean   ;
    function GetLandedCostGrossMarginMode          : Boolean   ;
    function GetTotalLandedcostGrossMarginMode     : Boolean   ;
    function GetIsStandardModePeercent             : Boolean   ;
    function GetOverheadAmount                     : Double    ;
    function GetLastCostGrossMarginAmount          : Double    ;
    function GetProductCostGrossMarginAmount       : Double    ;
    function GetAverageCostGrossMarginAmount       : Double    ;
    function GetManCostGrossMarginAmount           : Double    ;
    function GetManAverageCostGrossMarginAmount    : Double    ;
    function GetManLastCostGrossMarginAmount       : Double    ;
    function GetLandedCostGrossMarginAmount        : Double    ;
    function GetTotalLandedcostGrossMarginAmount   : Double    ;
    function GetManAvgCost        : Double    ;
    function GetManLatestCost     : Double    ;
    function GetMancostWithLabour : Double    ;
    function GetLandedCost        : Double    ;
    function GetTotalLandedcost   : Double    ;
    function GetAvgCost           : Double    ;
    function GetCOST1             : Double    ;
    function GetLatestCost        : Double    ;
    function GetManAvgCostPrice        : Double    ;
    function GetManLatestCostPrice     : Double    ;
    function GetMancostWithLabourPrice : Double    ;
    function GetLandedCostPrice        : Double    ;
    function GetTotalLandedcostPrice   : Double    ;
    function GetAvgCostPrice           : Double    ;
    function GetCOST1Price             : Double    ;
    function GetOverheadAmountPrice    : Double    ;
    function GetLatestCostPrice        : Double    ;

    procedure SetPartsID                            (const Value: Integer   );
    procedure SetProductPriceCalctype               (const Value: Integer   );
    procedure SetLastCostGrossMarginMode            (const Value: Boolean   );
    procedure SetProductCostGrossMarginMode         (const Value: Boolean   );
    procedure SetAverageCostGrossMarginMode         (const Value: Boolean   );
    procedure SetManCostGrossMarginMode             (const Value: Boolean   );
    procedure SetManAverageCostGrossMarginMode      (const Value: Boolean   );
    procedure SetManLastCostGrossMarginMode         (const Value: Boolean   );
    procedure SetLandedCostGrossMarginMode          (const Value: Boolean   );
    procedure SetTotalLandedcostGrossMarginMode     (const Value: Boolean   );
    procedure SetIsStandardModePeercent             (const Value: Boolean   );
    procedure SetOverheadAmount                     (const Value: Double    );
    procedure SetLastCostGrossMarginAmount          (const Value: Double    );
    procedure SetProductCostGrossMarginAmount       (const Value: Double    );
    procedure SetAverageCostGrossMarginAmount       (const Value: Double    );
    procedure SetManCostGrossMarginAmount           (const Value: Double    );
    procedure SetManAverageCostGrossMarginAmount    (const Value: Double    );
    procedure SetManLastCostGrossMarginAmount       (const Value: Double    );
    procedure SetLandedCostGrossMarginAmount        (const Value: Double    );
    procedure SetTotalLandedcostGrossMarginAmount   (const Value: Double    );
    procedure SetManAvgCost        (const Value: Double    );
    procedure SetManLatestCost     (const Value: Double    );
    procedure SetMancostWithLabour (const Value: Double    );
    procedure SetLandedCost        (const Value: Double    );
    procedure SetTotalLandedcost   (const Value: Double    );
    procedure SetAvgCost           (const Value: Double    );
    procedure SetCOST1             (const Value: Double    );
    procedure SetLatestCost        (const Value: Double    );
    procedure SetManAvgCostPrice        (const Value: Double    );
    procedure SetManLatestCostPrice     (const Value: Double    );
    procedure SetMancostWithLabourPrice (const Value: Double    );
    procedure SetLandedCostPrice        (const Value: Double    );
    procedure SetTotalLandedcostPrice   (const Value: Double    );
    procedure SetAvgCostPrice           (const Value: Double    );
    procedure SetCOST1Price             (const Value: Double    );
    procedure SetOverheadAmountPrice    (const Value: Double    );
    procedure SetLatestCostPrice        (const Value: Double    );
    procedure CalcAvgCostPrice;
    procedure CalcCOST1Price;
    procedure CalcLandedCostPrice;
    procedure CalcTotalLandedcostPrice;
    procedure CalcLatestCostPrice;
    procedure CalcManAvgCostPrice;
    procedure CalcMancostWithLabourPrice;
    procedure CalcManLatestCostPrice;
    procedure CalcOverheadAmountPrice;
    function getProduct: TProduct;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoCalcFields(Sender :TDatasetBusObj):Boolean;override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property Product :TProduct read getProduct;
  published
    property PartsID                             :Integer     read GetPartsID                           write SetPartsID                          ;
    property ProductPriceCalctype                :Integer     read GetProductPriceCalctype              write SetProductPriceCalctype             ;
    property LastCostGrossMarginMode             :Boolean     read GetLastCostGrossMarginMode           write SetLastCostGrossMarginMode          ;
    property ProductCostGrossMarginMode          :Boolean     read GetProductCostGrossMarginMode        write SetProductCostGrossMarginMode       ;
    property AverageCostGrossMarginMode          :Boolean     read GetAverageCostGrossMarginMode        write SetAverageCostGrossMarginMode       ;
    property ManCostGrossMarginMode              :Boolean     read GetManCostGrossMarginMode            write SetManCostGrossMarginMode           ;
    property ManAverageCostGrossMarginMode       :Boolean     read GetManAverageCostGrossMarginMode     write SetManAverageCostGrossMarginMode    ;
    property ManLastCostGrossMarginMode          :Boolean     read GetManLastCostGrossMarginMode        write SetManLastCostGrossMarginMode       ;
    property LandedCostGrossMarginMode           :Boolean     read GetLandedCostGrossMarginMode         write SetLandedCostGrossMarginMode        ;
    property TotalLandedcostGrossMarginMode      :Boolean     read GetTotalLandedcostGrossMarginMode    write SetTotalLandedcostGrossMarginMode   ;
    property IsStandardModePeercent              :Boolean     read GetIsStandardModePeercent            write SetIsStandardModePeercent           ;
    property OverheadAmount                      :Double      read GetOverheadAmount                    write SetOverheadAmount                   ;
    property LastCostGrossMarginAmount           :Double      read GetLastCostGrossMarginAmount         write SetLastCostGrossMarginAmount        ;
    property ProductCostGrossMarginAmount        :Double      read GetProductCostGrossMarginAmount      write SetProductCostGrossMarginAmount     ;
    property AverageCostGrossMarginAmount        :Double      read GetAverageCostGrossMarginAmount      write SetAverageCostGrossMarginAmount     ;
    property ManCostGrossMarginAmount            :Double      read GetManCostGrossMarginAmount          write SetManCostGrossMarginAmount         ;
    property ManAverageCostGrossMarginAmount     :Double      read GetManAverageCostGrossMarginAmount   write SetManAverageCostGrossMarginAmount  ;
    property ManLastCostGrossMarginAmount        :Double      read GetManLastCostGrossMarginAmount      write SetManLastCostGrossMarginAmount     ;
    property LandedCostGrossMarginAmount         :Double      read GetLandedCostGrossMarginAmount       write SetLandedCostGrossMarginAmount      ;
    property TotalLandedcostGrossMarginAmount    :Double      read GetTotalLandedcostGrossMarginAmount  write SetTotalLandedcostGrossMarginAmount ;
    property ManAvgCost         :Double      read GetManAvgCost         write SetManAvgCost    ;
    property ManLatestCost      :Double      read GetManLatestCost      write SetManLatestCost    ;
    property MancostWithLabour  :Double      read GetMancostWithLabour  write SetMancostWithLabour    ;
    property LandedCost         :Double      read GetLandedCost         write SetLandedCost    ;
    property TotalLandedcost    :Double      read GetTotalLandedcost    write SetTotalLandedcost    ;
    property AvgCost            :Double      read GetAvgCost            write SetAvgCost    ;
    property COST1              :Double      read GetCOST1              write SetCOST1    ;
    property LatestCost         :Double      read GetLatestCost         write SetLatestCost    ;
    property ManAvgCostPrice        :Double      read GetManAvgCostPrice        Write SetManAvgCostPrice;
    property ManLatestCostPrice     :Double      read GetManLatestCostPrice     Write SetManLatestCostPrice;
    property MancostWithLabourPrice :Double      read GetMancostWithLabourPrice Write SetMancostWithLabourPrice;
    property LandedCostPrice        :Double      read GetLandedCostPrice        Write SetLandedCostPrice;
    property TotalLandedcostPrice   :Double      read GetTotalLandedcostPrice   Write SetTotalLandedcostPrice;
    property AvgCostPrice           :Double      read GetAvgCostPrice           Write SetAvgCostPrice;
    property COST1Price             :Double      read GetCOST1Price             Write SetCOST1Price;
    property OverheadAmountPrice    :Double      read GetOverheadAmountPrice    Write SetOverheadAmountPrice;
    property LatestCostPrice        :Double      read GetLatestCostPrice        Write SetLatestCostPrice;
  end;


implementation


uses tcDataUtils, CommonLib, tcConst, sysutils, BusObjConst;



  {TPartsPriceCalc}

constructor TPartsPriceCalc.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PartsPriceCalc';
  fSQL := 'SELECT * FROM tblpartspricecalc';
end;


destructor TPartsPriceCalc.Destroy;
begin
  inherited;
end;


procedure TPartsPriceCalc.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PartsID');
  SetPropertyFromNode(node,'ProductPriceCalctype');
  SetBooleanPropertyFromNode(node,'LastCostGrossMarginMode');
  SetBooleanPropertyFromNode(node,'ProductCostGrossMarginMode');
  SetBooleanPropertyFromNode(node,'AverageCostGrossMarginMode');
  SetBooleanPropertyFromNode(node,'ManCostGrossMarginMode');
  SetBooleanPropertyFromNode(node,'ManAverageCostGrossMarginMode');
  SetBooleanPropertyFromNode(node,'ManLastCostGrossMarginMode');
  SetBooleanPropertyFromNode(node,'LandedCostGrossMarginMode');
  SetBooleanPropertyFromNode(node,'TotalLandedcostGrossMarginMode');
  SetBooleanPropertyFromNode(node,'IsStandardModePeercent');
  SetPropertyFromNode(node,'OverheadAmount');
  SetPropertyFromNode(node,'LastCostGrossMarginAmount');
  SetPropertyFromNode(node,'ProductCostGrossMarginAmount');
  SetPropertyFromNode(node,'AverageCostGrossMarginAmount');
  SetPropertyFromNode(node,'ManCostGrossMarginAmount');
  SetPropertyFromNode(node,'ManAverageCostGrossMarginAmount');
  SetPropertyFromNode(node,'ManLastCostGrossMarginAmount');
  SetPropertyFromNode(node,'LandedCostGrossMarginAmount');
  SetPropertyFromNode(node,'TotalLandedcostGrossMarginAmount');
  SetPropertyFromNode(node,'ManAvgCost');
  SetPropertyFromNode(node,'ManLatestCost');
  SetPropertyFromNode(node,'MancostWithLabour');
  SetPropertyFromNode(node,'LandedCost');
  SetPropertyFromNode(node,'TotalLandedcost');
  SetPropertyFromNode(node,'AvgCost');
  SetPropertyFromNode(node,'COST1');
  SetPropertyFromNode(node,'LatestCost');

  SetPropertyFromNode(node,'ManAvgCostPrice');
  SetPropertyFromNode(node,'ManLatestCostPrice');
  SetPropertyFromNode(node,'MancostWithLabourPrice');
  SetPropertyFromNode(node,'LandedCostPrice');
  SetPropertyFromNode(node,'TotalLandedcostPrice');
  SetPropertyFromNode(node,'AvgCostPrice');
  SetPropertyFromNode(node,'COST1Price');
  SetPropertyFromNode(node,'OverheadAmountPrice');
  SetPropertyFromNode(node,'LatestCostPrice');
end;


procedure TPartsPriceCalc.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PartsID' ,PartsID);
  AddXMLNode(node,'ProductPriceCalctype' ,ProductPriceCalctype);
  AddXMLNode(node,'LastCostGrossMarginMode' ,LastCostGrossMarginMode);
  AddXMLNode(node,'ProductCostGrossMarginMode' ,ProductCostGrossMarginMode);
  AddXMLNode(node,'AverageCostGrossMarginMode' ,AverageCostGrossMarginMode);
  AddXMLNode(node,'ManCostGrossMarginMode' ,ManCostGrossMarginMode);
  AddXMLNode(node,'ManAverageCostGrossMarginMode' ,ManAverageCostGrossMarginMode);
  AddXMLNode(node,'ManLastCostGrossMarginMode' ,ManLastCostGrossMarginMode);
  AddXMLNode(node,'LandedCostGrossMarginMode' ,LandedCostGrossMarginMode);
  AddXMLNode(node,'TotalLandedcostGrossMarginMode' ,TotalLandedcostGrossMarginMode);
  AddXMLNode(node,'IsStandardModePeercent' ,IsStandardModePeercent);
  AddXMLNode(node,'OverheadAmount' ,OverheadAmount);
  AddXMLNode(node,'LastCostGrossMarginAmount' ,LastCostGrossMarginAmount);
  AddXMLNode(node,'ProductCostGrossMarginAmount' ,ProductCostGrossMarginAmount);
  AddXMLNode(node,'AverageCostGrossMarginAmount' ,AverageCostGrossMarginAmount);
  AddXMLNode(node,'ManCostGrossMarginAmount' ,ManCostGrossMarginAmount);
  AddXMLNode(node,'ManAverageCostGrossMarginAmount' ,ManAverageCostGrossMarginAmount);
  AddXMLNode(node,'ManLastCostGrossMarginAmount' ,ManLastCostGrossMarginAmount);
  AddXMLNode(node,'LandedCostGrossMarginAmount' ,LandedCostGrossMarginAmount);
  AddXMLNode(node,'TotalLandedcostGrossMarginAmount' ,TotalLandedcostGrossMarginAmount);
  AddXMLNode(node,'ManAvgCost' ,ManAvgCost);
  AddXMLNode(node,'ManLatestCost' ,ManLatestCost);
  AddXMLNode(node,'MancostWithLabour' ,MancostWithLabour);
  AddXMLNode(node,'LandedCost' ,LandedCost);
  AddXMLNode(node,'TotalLandedcost' ,TotalLandedcost);
  AddXMLNode(node,'AvgCost' ,AvgCost);
  AddXMLNode(node,'COST1' ,COST1);
  AddXMLNode(node,'LatestCost' ,LatestCost);
  AddXMLNode(node,'ManAvgCostPrice' ,ManAvgCostPrice);
  AddXMLNode(node,'ManLatestCostPrice' ,ManLatestCostPrice);
  AddXMLNode(node,'MancostWithLabourPrice' ,MancostWithLabourPrice);
  AddXMLNode(node,'LandedCostPrice' ,LandedCostPrice);
  AddXMLNode(node,'TotalLandedcostPrice' ,TotalLandedcostPrice);
  AddXMLNode(node,'AvgCostPrice' ,AvgCostPrice);
  AddXMLNode(node,'COST1Price' ,COST1Price);
  AddXMLNode(node,'OverheadAmountPrice' ,OverheadAmountPrice);
  AddXMLNode(node,'LatestCostPrice' ,LatestCostPrice);
end;


function TPartsPriceCalc.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if PartsID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PartsID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TPartsPriceCalc.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPartsPriceCalc.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  CalcAvgCostPrice;
  CalcCOST1Price;
  CalcLandedCostPrice;
  CalcTotalLandedcostPrice;
  CalcLatestCostPrice;
  CalcManAvgCostPrice;
  CalcMancostWithLabourPrice;
  CalcManLatestCostPrice;
  CalcOverheadAmountPrice;
end;

procedure TPartsPriceCalc.CalcLatestCostPrice;
begin
    editdb;
    if LatestCost <> 0 then begin
      if LastCostGrossMarginMode then LatestCostPrice :=CommonLib.Round(TProduct.calcPricefromMarkup(LatestCost, LastCostGrossMarginAmount), tcConst.GeneralRoundPlaces)
                                 else LatestCostPrice := CommonLib.Round(TProduct.CalcPricefromGross(Latestcost, LastCostGrossMarginAmount), tcConst.GeneralRoundPlaces);
    end else begin
      LatestCostPrice := 0;
    end;
    PostDB;
    //SendEvent(BusObjEvent_Change, BusobjEventVal_LatestCostPrice);
end;
procedure TPartsPriceCalc.CalcCOST1Price;
begin
    editdb;
    if Cost1 <> 0 then begin
      if ProductCostGrossMarginMode then Cost1Price :=CommonLib.Round(TProduct.calcPricefromMarkup(Cost1, ProductCostGrossMarginAmount), tcConst.GeneralRoundPlaces)
                                    else Cost1Price := CommonLib.Round(TProduct.CalcPricefromGross(Cost1, ProductCostGrossMarginAmount), tcConst.GeneralRoundPlaces);
    end else begin
      Cost1Price := 0;
    end;
    PostDB;
    //SendEvent(BusObjEvent_Change, BusobjEventVal_COST1Price);
end;
procedure TPartsPriceCalc.CalcAvgCostPrice;
begin
    editdb;
    if AvgCost <> 0 then begin
      if AverageCostGrossMarginMode then AvgCostPrice :=CommonLib.Round(TProduct.calcPricefromMarkup(AvgCost, AverageCostGrossMarginAmount), tcConst.GeneralRoundPlaces)
                                    else AvgCostPrice :=CommonLib.Round(TProduct.CalcPricefromGross(AvgCost, AverageCostGrossMarginAmount), tcConst.GeneralRoundPlaces);
    end else begin
      AvgCostPrice := 0;
    end;
    PostDB;
    //SendEvent(BusObjEvent_Change, BusobjEventVal_AvgCostPrice);

end;
procedure TPartsPriceCalc.CalcLandedCostPrice;
begin
    editdb;
    if LandedCost <> 0 then begin
      if LandedCostGrossMarginMode then LandedCostPrice :=CommonLib.Round(TProduct.calcPricefromMarkup(LandedCost, LandedCostGrossMarginAmount), tcConst.GeneralRoundPlaces)
                                    else LandedCostPrice :=CommonLib.Round(TProduct.CalcPricefromGross(LandedCost, LandedCostGrossMarginAmount), tcConst.GeneralRoundPlaces);
    end else begin
      LandedCostPrice := 0;
    end;
    PostDB;
    //SendEvent(BusObjEvent_Change, BusobjEventVal_LandedCostPrice);
end;
procedure TPartsPriceCalc.CalcTotalLandedcostPrice;
begin
    editdb;
    if TotalLandedcost <> 0 then begin
      if TotalLandedcostGrossMarginMode then TotalLandedcostPrice :=CommonLib.Round(TProduct.calcPricefromMarkup(TotalLandedcost, TotalLandedcostGrossMarginAmount), tcConst.GeneralRoundPlaces)
                                    else TotalLandedcostPrice :=CommonLib.Round(TProduct.CalcPricefromGross(TotalLandedcost, TotalLandedcostGrossMarginAmount), tcConst.GeneralRoundPlaces);
    end else begin
      TotalLandedcostPrice := 0;
    end;
    PostDB;
    //SendEvent(BusObjEvent_Change, BusobjEventVal_TotalLandedcostPrice);
end;
procedure TPartsPriceCalc.CalcMancostWithLabourPrice;
begin
    editdb;
    if MancostWithLabour <> 0 then begin
      if ManCostGrossMarginMode then MancostWithLabourPrice :=CommonLib.Round(TProduct.calcPricefromMarkup(MancostWithLabour, ManCostGrossMarginAmount), tcConst.GeneralRoundPlaces)
                                else MancostWithLabourPrice :=CommonLib.Round(TProduct.CalcPricefromGross(MancostWithLabour, ManCostGrossMarginAmount), tcConst.GeneralRoundPlaces);
    end else begin
      MancostWithLabourPrice := 0;
    end;
    PostDB;
    //SendEvent(BusObjEvent_Change, BusobjEventVal_MancostWithLabourPrice);
end;
procedure TPartsPriceCalc.CalcManLatestCostPrice;
begin
    editdb;
    if ManLatestCost <> 0 then begin
      if ManLastCostGrossMarginMode then ManLatestCostPrice :=CommonLib.Round(TProduct.calcPricefromMarkup(ManLatestCost, ManLastCostGrossMarginAmount), tcConst.GeneralRoundPlaces)
                                    else ManLatestCostPrice :=CommonLib.Round(TProduct.CalcPricefromGross(ManLatestCost, ManLastCostGrossMarginAmount), tcConst.GeneralRoundPlaces);
    end else begin
      MancostWithLabourPrice := 0;
    end;
    PostDB;
    //SendEvent(BusObjEvent_Change, BusobjEventVal_ManLatestCostPrice);
end;
procedure TPartsPriceCalc.CalcManAvgCostPrice;
begin
    editdb;
    if ManAvgCost <> 0 then begin
      if ManAverageCostGrossMarginMode then ManAvgCostPrice :=CommonLib.Round(TProduct.calcPricefromMarkup(ManAvgCost, ManAverageCostGrossMarginAmount), tcConst.GeneralRoundPlaces)
                                       else ManAvgCostPrice :=CommonLib.Round(TProduct.CalcPricefromGross(ManAvgCost, ManAverageCostGrossMarginAmount), tcConst.GeneralRoundPlaces);
    end else begin
      ManAvgCostPrice := 0;
    end;
    PostDB;
    //SendEvent(BusObjEvent_Change, BusobjEventVal_ManAvgCostPrice);
end;
procedure TPartsPriceCalc.CalcOverheadAmountPrice;
begin
    editdb;
  if not IsStandardModePeercent then begin
    OverheadAmountPrice :=
      CommonLib.Round(COST1 +  OverheadAmount, tcConst.GeneralRoundPlaces);
  end else begin
    if COST1 <> 0 then begin
      OverheadAmountPrice :=CommonLib.Round(TProduct.calcPricefromMarkup(COST1, OverheadAmount), tcConst.GeneralRoundPlaces);
    end else begin
      OverheadAmountPrice := 0;
    end;
  end;
  //SendEvent(BusObjEvent_Change, BusobjEventVal_OverheadAmountPrice);
end;

procedure TPartsPriceCalc.DoFieldOnChange(Sender: TField);
begin

  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  PostDB;

  if Sysutils.SameText(Sender.fieldName , 'PartsID')  then begin
    if partsID<>0 then begin
      if ProductPriceCalctype = ppctNone then begin
        ProductPriceCalctype := ppctProductcost;
        ProductCostGrossMarginMode := Product.GrossMarginMode;
        ProductCostGrossMarginAmount := Product.MarkupPercentage;
      end;
    end;
  end else if Sysutils.SameText(Sender.fieldName , 'ProductPriceCalctype')  then begin
    SendEvent(BusObjEvent_Change, BusobjEventVal_ProductPriceCalctype);
  end else if Sysutils.SameText(Sender.fieldName , 'LastCostGrossMarginMode') Or Sysutils.SameText(Sender.fieldName , 'LastCostGrossMarginAmount') then begin
    if (LastCostGrossMarginMode        = False) and (LastCostGrossMarginAmount      >=100) then begin LastCostGrossMarginAmount:= 99;SendEvent(BusObjEvent_Change, BusobjEventVal_GrossMarginFixed);end;
    CalcLatestCostPrice;
    SendEvent(BusObjEvent_Change, BusobjEventVal_ProductPriceCalctype);
  end else if Sysutils.SameText(Sender.fieldName , 'ProductCostGrossMarginMode') Or Sysutils.SameText(Sender.fieldName , 'ProductCostGrossMarginAmount') then begin
    if (ProductCostGrossMarginMode     = False) and  (ProductCostGrossMarginAmount   >=100) then begin ProductCostGrossMarginAmount   := 99;SendEvent(BusObjEvent_Change, BusobjEventVal_GrossMarginFixed);end;
    CalcCOST1Price;
    SendEvent(BusObjEvent_Change, BusobjEventVal_ProductPriceCalctype);
  end else if Sysutils.SameText(Sender.fieldName , 'AverageCostGrossMarginMode') Or Sysutils.SameText(Sender.fieldName , 'AverageCostGrossMarginAmount') then begin
    if (AverageCostGrossMarginMode     = False) and  (AverageCostGrossMarginAmount   >=100) then begin AverageCostGrossMarginAmount   := 99;SendEvent(BusObjEvent_Change, BusobjEventVal_GrossMarginFixed);end;

    CalcAvgCostPrice;
    SendEvent(BusObjEvent_Change, BusobjEventVal_ProductPriceCalctype);
  end else if Sysutils.SameText(Sender.fieldName , 'LandedCostGrossMarginMode') Or Sysutils.SameText(Sender.fieldName , 'LandedCostGrossMarginAmount') then begin
    if (LandedCostGrossMarginMode      = False) and  (LandedCostGrossMarginAmount    >=100) then begin LandedCostGrossMarginAmount    := 99;SendEvent(BusObjEvent_Change, BusobjEventVal_GrossMarginFixed);end;
    CalcLandedCostPrice;
    SendEvent(BusObjEvent_Change, BusobjEventVal_ProductPriceCalctype);
  end else if Sysutils.SameText(Sender.fieldName , 'TotalLandedcostGrossMarginMode') Or Sysutils.SameText(Sender.fieldName , 'TotalLandedcostGrossMarginAmount') then begin
    if (TotalLandedcostGrossMarginMode      = False) and  (TotalLandedcostGrossMarginAmount    >=100) then begin TotalLandedcostGrossMarginAmount    := 99;SendEvent(BusObjEvent_Change, BusobjEventVal_GrossMarginFixed);end;
    CalcTotalLandedcostPrice;
    SendEvent(BusObjEvent_Change, BusobjEventVal_ProductPriceCalctype);
  end else if Sysutils.SameText(Sender.fieldName , 'ManCostGrossMarginMode') Or Sysutils.SameText(Sender.fieldName , 'ManCostGrossMarginAmount') then begin
    if (ManCostGrossMarginMode         = False) and  (ManCostGrossMarginAmount       >=100) then begin ManCostGrossMarginAmount       := 99;SendEvent(BusObjEvent_Change, BusobjEventVal_GrossMarginFixed);end;
    CalcMancostWithLabourPrice;
    SendEvent(BusObjEvent_Change, BusobjEventVal_ProductPriceCalctype);
  end else if Sysutils.SameText(Sender.fieldName , 'ManLastCostGrossMarginMode') Or Sysutils.SameText(Sender.fieldName , 'ManLastCostGrossMarginAmount') then begin
    if (ManLastCostGrossMarginMode     = False) and (ManLastCostGrossMarginAmount   >=100) then begin ManLastCostGrossMarginAmount   := 99;SendEvent(BusObjEvent_Change, BusobjEventVal_GrossMarginFixed);end;
    CalcManLatestCostPrice;
    SendEvent(BusObjEvent_Change, BusobjEventVal_ProductPriceCalctype);
  end else if Sysutils.SameText(Sender.fieldName , 'ManAverageCostGrossMarginMode') Or Sysutils.SameText(Sender.fieldName , 'ManAverageCostGrossMarginAmount') then begin
    if (ManAverageCostGrossMarginMode  = False) and (ManAverageCostGrossMarginAmount>=100) then begin ManAverageCostGrossMarginAmount:= 99;SendEvent(BusObjEvent_Change, BusobjEventVal_GrossMarginFixed);end;
    CalcManAvgCostPrice;
    SendEvent(BusObjEvent_Change, BusobjEventVal_ProductPriceCalctype);
  end else if Sysutils.SameText(Sender.fieldName , 'StandardMode') Or Sysutils.SameText(Sender.fieldName , 'OverheadAmount') then begin
    CalcOverheadAmountPrice;
    SendEvent(BusObjEvent_Change, BusobjEventVal_ProductPriceCalctype);
  end;
end;


function TPartsPriceCalc.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPartsPriceCalc.GetIDField: string;
begin
  Result := 'ID'                                          end;

class function TPartsPriceCalc.GetBusObjectTablename: string;
begin
  Result:= 'tblpartspricecalc';
end;


function TPartsPriceCalc.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function  TPartsPriceCalc.DoAfterInsert(Sender:TDatasetBusObj) : Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

function TPartsPriceCalc.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoCalcFields(Sender);
  if not result then exit;
  ManAvgCostPrice        := fdManAvgCostPrice;
  ManLatestCostPrice     := fdManLatestCostPrice;
  MancostWithLabourPrice := fdMancostWithLabourPrice;
  LandedCostPrice        := fdLandedCostPrice;
  TotalLandedcostPrice   := fdTotalLandedcostPrice;
  AvgCostPrice           := fdAvgCostPrice;
  COST1Price             := fdCOST1Price;
  OverheadAmountPrice    := fdOverheadAmountPrice;
  LatestCostPrice        := fdLatestCostPrice;
end;
function TPartsPriceCalc.getProduct: TProduct;
begin
  if Assigned(OWner) and (owner is TProduct) then result := TProduct(Owner)
  else result := TProduct(getContainercomponent(TProduct, 'PartsID = ' + inttostr(PartsID)));
end;
{Property Functions}
function  TPartsPriceCalc.GetPartsID                         : Integer   ; begin Result := GetIntegerField('PartsID');end;
function  TPartsPriceCalc.GetProductPriceCalctype            : Integer   ; begin Result := GetIntegerField('ProductPriceCalctype');end;
function  TPartsPriceCalc.GetLastCostGrossMarginMode         : Boolean   ; begin Result := GetBooleanField('LastCostGrossMarginMode');end;
function  TPartsPriceCalc.GetProductCostGrossMarginMode      : Boolean   ; begin Result := GetBooleanField('ProductCostGrossMarginMode');end;
function  TPartsPriceCalc.GetAverageCostGrossMarginMode      : Boolean   ; begin Result := GetBooleanField('AverageCostGrossMarginMode');end;
function  TPartsPriceCalc.GetManCostGrossMarginMode          : Boolean   ; begin Result := GetBooleanField('ManCostGrossMarginMode');end;
function  TPartsPriceCalc.GetManAverageCostGrossMarginMode   : Boolean   ; begin Result := GetBooleanField('ManAverageCostGrossMarginMode');end;
function  TPartsPriceCalc.GetManLastCostGrossMarginMode      : Boolean   ; begin Result := GetBooleanField('ManLastCostGrossMarginMode');end;
function  TPartsPriceCalc.GetLandedCostGrossMarginMode       : Boolean   ; begin Result := GetBooleanField('LandedCostGrossMarginMode');end;
function  TPartsPriceCalc.GetTotalLandedcostGrossMarginMode  : Boolean   ; begin Result := GetBooleanField('TotalLandedcostGrossMarginMode');end;
function  TPartsPriceCalc.GetIsStandardModePeercent          : Boolean   ; begin Result := GetBooleanField('StandardMode');end;
function  TPartsPriceCalc.GetOverheadAmount                  : Double    ; begin Result := GetFloatField('OverheadAmount');end;
function  TPartsPriceCalc.GetLastCostGrossMarginAmount       : Double    ; begin Result := GetFloatField('LastCostGrossMarginAmount');end;
function  TPartsPriceCalc.GetProductCostGrossMarginAmount    : Double    ; begin Result := GetFloatField('ProductCostGrossMarginAmount');end;
function  TPartsPriceCalc.GetAverageCostGrossMarginAmount    : Double    ; begin Result := GetFloatField('AverageCostGrossMarginAmount');end;
function  TPartsPriceCalc.GetManCostGrossMarginAmount        : Double    ; begin Result := GetFloatField('ManCostGrossMarginAmount');end;
function  TPartsPriceCalc.GetManAverageCostGrossMarginAmount : Double    ; begin Result := GetFloatField('ManAverageCostGrossMarginAmount');end;
function  TPartsPriceCalc.GetManLastCostGrossMarginAmount    : Double    ; begin Result := GetFloatField('ManLastCostGrossMarginAmount');end;
function  TPartsPriceCalc.GetLandedCostGrossMarginAmount     : Double    ; begin Result := GetFloatField('LandedCostGrossMarginAmount');end;
function  TPartsPriceCalc.GetTotalLandedcostGrossMarginAmount: Double    ; begin Result := GetFloatField('TotalLandedcostGrossMarginAmount');end;
function  TPartsPriceCalc.GetManAvgCost         : Double    ; begin Result := GetFloatField('ManAvgCost');end;
function  TPartsPriceCalc.GetManLatestCost      : Double    ; begin Result := GetFloatField('ManLatestCost');end;
function  TPartsPriceCalc.GetMancostWithLabour  : Double    ; begin Result := GetFloatField('MancostWithLabour');end;
function  TPartsPriceCalc.GetLandedCost         : Double    ; begin Result := GetFloatField('LandedCost');end;
function  TPartsPriceCalc.GetTotalLandedcost    : Double    ; begin Result := GetFloatField('TotalLandedcost');end;
function  TPartsPriceCalc.GetAvgCost            : Double    ; begin Result := GetFloatField('AvgCost');end;
function  TPartsPriceCalc.GetCOST1              : Double    ; begin Result := GetFloatField('COST1');end;
function  TPartsPriceCalc.GetLatestCost         : Double    ; begin Result := GetFloatField('LatestCost');end;
function  TPartsPriceCalc.GetManAvgCostPrice        : Double    ; begin Result := GetFloatField('ManAvgCostPrice');end;
function  TPartsPriceCalc.GetManLatestCostPrice     : Double    ; begin Result := GetFloatField('ManLatestCostPrice');end;
function  TPartsPriceCalc.GetMancostWithLabourPrice : Double    ; begin Result := GetFloatField('MancostWithLabourPrice');end;
function  TPartsPriceCalc.GetLandedCostPrice        : Double    ; begin Result := GetFloatField('LandedCostPrice');end;
function  TPartsPriceCalc.GetTotalLandedcostPrice   : Double    ; begin Result := GetFloatField('TotalLandedcostPrice');end;
function  TPartsPriceCalc.GetAvgCostPrice           : Double    ; begin Result := GetFloatField('AvgCostPrice');end;
function  TPartsPriceCalc.GetCOST1Price             : Double    ; begin Result := GetFloatField('COST1Price');end;
function  TPartsPriceCalc.GetOverheadAmountPrice    : Double    ; begin Result := GetFloatField('OverheadAmountPrice');end;
function  TPartsPriceCalc.GetLatestCostPrice        : Double    ; begin Result := GetFloatField('LatestCostPrice');end;


procedure TPartsPriceCalc.SetPartsID                         (const Value: Integer   ); begin SetIntegerField('PartsID'                         , Value);end;
procedure TPartsPriceCalc.SetProductPriceCalctype            (const Value: Integer   ); begin SetIntegerField('ProductPriceCalctype'            , Value);end;
procedure TPartsPriceCalc.SetLastCostGrossMarginMode         (const Value: Boolean   ); begin SetBooleanField('LastCostGrossMarginMode'         , Value);end;
procedure TPartsPriceCalc.SetProductCostGrossMarginMode      (const Value: Boolean   ); begin SetBooleanField('ProductCostGrossMarginMode'      , Value);end;
procedure TPartsPriceCalc.SetAverageCostGrossMarginMode      (const Value: Boolean   ); begin SetBooleanField('AverageCostGrossMarginMode'      , Value);end;
procedure TPartsPriceCalc.SetManCostGrossMarginMode          (const Value: Boolean   ); begin SetBooleanField('ManCostGrossMarginMode'          , Value);end;
procedure TPartsPriceCalc.SetManAverageCostGrossMarginMode   (const Value: Boolean   ); begin SetBooleanField('ManAverageCostGrossMarginMode'   , Value);end;
procedure TPartsPriceCalc.SetManLastCostGrossMarginMode      (const Value: Boolean   ); begin SetBooleanField('ManLastCostGrossMarginMode'      , Value);end;
procedure TPartsPriceCalc.SetLandedCostGrossMarginMode       (const Value: Boolean   ); begin SetBooleanField('LandedCostGrossMarginMode'       , Value);end;
procedure TPartsPriceCalc.SetTotalLandedcostGrossMarginMode  (const Value: Boolean   ); begin SetBooleanField('TotalLandedcostGrossMarginMode'  , Value);end;
procedure TPartsPriceCalc.SetIsStandardModePeercent          (const Value: Boolean   ); begin SetBooleanField('StandardMode'                    , Value);end;
procedure TPartsPriceCalc.SetOverheadAmount                  (const Value: Double    ); begin SetFloatField('OverheadAmount'                  , Value);end;
procedure TPartsPriceCalc.SetLastCostGrossMarginAmount       (const Value: Double    ); begin SetFloatField('LastCostGrossMarginAmount'       , Value);end;
procedure TPartsPriceCalc.SetProductCostGrossMarginAmount    (const Value: Double    ); begin SetFloatField('ProductCostGrossMarginAmount'    , Value);end;
procedure TPartsPriceCalc.SetAverageCostGrossMarginAmount    (const Value: Double    ); begin SetFloatField('AverageCostGrossMarginAmount'    , Value);end;
procedure TPartsPriceCalc.SetManCostGrossMarginAmount        (const Value: Double    ); begin SetFloatField('ManCostGrossMarginAmount'        , Value);end;
procedure TPartsPriceCalc.SetManAverageCostGrossMarginAmount (const Value: Double    ); begin SetFloatField('ManAverageCostGrossMarginAmount' , Value);end;
procedure TPartsPriceCalc.SetManLastCostGrossMarginAmount    (const Value: Double    ); begin SetFloatField('ManLastCostGrossMarginAmount'    , Value);end;
procedure TPartsPriceCalc.SetLandedCostGrossMarginAmount     (const Value: Double    ); begin SetFloatField('LandedCostGrossMarginAmount'     , Value);end;
procedure TPartsPriceCalc.SetTotalLandedcostGrossMarginAmount(const Value: Double    ); begin SetFloatField('TotalLandedcostGrossMarginAmount', Value);end;
procedure TPartsPriceCalc.SetManAvgCost       (const Value: Double    ); begin SetFloatField('ManAvgCost'       , Value);end;
procedure TPartsPriceCalc.SetManLatestCost    (const Value: Double    ); begin SetFloatField('ManLatestCost'    , Value);end;
procedure TPartsPriceCalc.SetMancostWithLabour(const Value: Double    ); begin SetFloatField('MancostWithLabour', Value);end;
procedure TPartsPriceCalc.SetLandedCost       (const Value: Double    ); begin SetFloatField('LandedCost'       , Value);end;
procedure TPartsPriceCalc.SetTotalLandedcost  (const Value: Double    ); begin SetFloatField('TotalLandedcost'  , Value);end;
procedure TPartsPriceCalc.SetAvgCost          (const Value: Double    ); begin SetFloatField('AvgCost'          , Value);end;
procedure TPartsPriceCalc.SetCOST1            (const Value: Double    ); begin SetFloatField('COST1'            , Value);end;
procedure TPartsPriceCalc.SetLatestCost       (const Value: Double    ); begin SetFloatField('LatestCost'       , Value);end;
procedure TPartsPriceCalc.SetManAvgCostPrice        (const Value: Double    ); begin if fdManAvgCostPrice       <> value then fdManAvgCostPrice       := value; SetFloatField('ManAvgCostPrice'       , Value);end;
procedure TPartsPriceCalc.SetManLatestCostPrice     (const Value: Double    ); begin if fdManLatestCostPrice    <> value then fdManLatestCostPrice    := Value; SetFloatField('ManLatestCostPrice'    , Value);end;
procedure TPartsPriceCalc.SetMancostWithLabourPrice (const Value: Double    ); begin if fdMancostWithLabourPrice<> value then fdMancostWithLabourPrice:= value;SetFloatField('MancostWithLabourPrice' , Value);end;
procedure TPartsPriceCalc.SetLandedCostPrice        (const Value: Double    ); begin if fdLandedCostPrice       <> value then fdLandedCostPrice       := Value; SetFloatField('LandedCostPrice'       , Value);end;
procedure TPartsPriceCalc.SetTotalLandedcostPrice   (const Value: Double    ); begin if fdTotalLandedcostPrice  <> value then fdTotalLandedcostPrice  := Value; SetFloatField('TotalLandedcostPrice'  , Value);end;
procedure TPartsPriceCalc.SetAvgCostPrice           (const Value: Double    ); begin if fdAvgCostPrice          <> value then fdAvgCostPrice          := Value; SetFloatField('AvgCostPrice'          , Value);end;
procedure TPartsPriceCalc.SetCOST1Price             (const Value: Double    ); begin if fdCOST1Price            <> value then fdCOST1Price            := Value; SetFloatField('COST1Price'            , Value);end;
procedure TPartsPriceCalc.SetOverheadAmountPrice    (const Value: Double    ); begin if fdOverheadAmountPrice   <> value then fdOverheadAmountPrice   := Value; SetFloatField('OverheadAmountPrice'   , Value);end;
procedure TPartsPriceCalc.SetLatestCostPrice        (const Value: Double    ); begin if fdLatestCostPrice       <> value then fdLatestCostPrice       := Value; SetFloatField('LatestCostPrice'       , Value);end;


initialization
  RegisterClass(TPartsPriceCalc);


end.
