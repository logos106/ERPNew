unit AusPosteParcelObj;

interface

uses  EFTObj, ERPdbComponents, ATODataObj, BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TAusPostEParcelconf = class(TMSBusObj)
  private
    function GetPostAccountNumber            : string    ;
    function GetChargeCode                   : string    ;
    function GetAddconsigneetoAddressBook    : Boolean   ;
    procedure SetPostAccountNumber            (const Value: string    );
    procedure SetChargeCode                   (const Value: string    );
    procedure SetAddconsigneetoAddressBook    (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property PostAccountNumber             :string      read GetPostAccountNumber           write SetPostAccountNumber        ;
    property ChargeCode                    :string      read GetChargeCode                  write SetChargeCode               ;
    property AddconsigneetoAddressBook     :Boolean     read GetAddconsigneetoAddressBook   write SetAddconsigneetoAddressBook;
  end;

  TAPHeaderRec = class(JsonATORec)
    Private

    Protected
      procedure PopulateFieldDefs; override;
    Public
      constructor Create;Override;

  end;

  TAPArticleRec = class(JsonATORec)
    Private
    Protected
      procedure PopulateFieldDefs; override;
    Public
      constructor Create;Override;
  end;
  TAPGroupRec = class(JsonATORec)
    Private
    Protected
      procedure PopulateFieldDefs; override;
    Public
      constructor Create;Override;
  end;

  TAusPostEParcelObj = class(TObject)
    Private
      fbIsExportingtoCSV: Boolean;
      fAusPostEParcelconf:TAusPostEParcelconf;
      fDataQry: TERPQuery;
      PartDelivery:Boolean;
      fdTotalAmount:Double;
      function Validatedata:Boolean;
      Procedure InitHeaderRec(fAPHeaderRec : TAPHeaderRec);
      function AddArticleRec:String;
      function AddGroupRec:String;
      function AusPostEParcelconf : TAusPostEParcelconf;
      function getDeliveryInstructions: String;
      function RemoveCommaFromString(Const Value:String):String;
    Public
      constructor Create;
      Destructor Destroy;Override;
      function DoExport(Const Filename:String = '') :Boolean;
      Property IsExportingtoCSV:Boolean read fbIsExportingtoCSV Write fbIsExportingtoCSV;
      Property DataQry :TERPQuery read fDataQry write fDataQry;
      Property DeliveryInstructions :String read getDeliveryInstructions;
    Protected
  end;
implementation

uses sysutils, CommonLib, tcDataUtils;

{ TAPHeaderRec }

constructor TAPHeaderRec.Create;
begin
  inherited;
  TrimDatainCSV:= True;
end;

function TAusPostEParcelObj.getDeliveryInstructions: String;
begin
  result := '';
  if DataQry.fieldbyname('SignatureReqd').asBoolean then result := 'Signature Required. '
  else begin
    result := 'Signature NOT Required. ';
    if DataQry.fieldbyname('LeaveAtAddress').asBoolean  then result := Result + 'If Premisses unattended, leave in a secure location out of weather. ';
  end;
  if Trim(DataQry.fieldbyname('ExtraDeliveryInstructions').asString) <> '' then
    result:= result+ DataQry.fieldbyname('ExtraDeliveryInstructions').asString;
end;

procedure TAPHeaderRec.PopulateFieldDefs;
begin
  inherited;
  AddField('LineIndicator'           ,1  ,ffAN ,ftM);
  AddField('Identifier'              ,20 ,ffAN ,ftO);
  AddField('PostAccountNumber'       ,20 ,ffAN ,ftM);
  AddField('Chargecode'              ,10 ,ffAN ,ftM);
  AddField('consigneecode'           ,20 ,ffAN ,ftM);
  AddField('consigneeName'           ,35 ,ffAN ,ftO);
  AddField('consigneeBusName'        ,35 ,ffAN ,ftO);
  AddField('consigneeAdd1'           ,40 ,ffAN ,ftO);
  AddField('consigneeAdd2'           ,40 ,ffAN ,ftO);
  AddField('consigneeAdd3'           ,40 ,ffAN ,ftO);
  AddField('consigneeAdd4'           ,40 ,ffAN ,ftO);
  AddField('consigneesub'            ,50 ,ffAN ,ftO);
  AddField('consigneeState'          ,10 ,ffAN ,ftO);
  AddField('consigneePostcode'       ,5  ,ffAN ,ftO);
  AddField('consigneeCountry'        ,30 ,ffAN ,ftO);
  AddField('consigneePhone'          ,20 ,ffAN ,ftO);
  AddField('consigneePhoneonLabel'   ,1  ,ffAN ,ftO);
  AddField('consigneeFax'            ,20 ,ffAN ,ftO);
  AddField('DeliveryInstructions'    ,128,ffAN ,ftO);
  AddField('ReqdSignature'           ,1  ,ffAN ,ftO);
  AddField('PartDelivery'            ,1  ,ffAN ,ftO);
  AddField('Comments'                ,256,ffAN ,ftO);
  AddField('AddconsigneeToAddbook'   ,1  ,ffAN ,ftO);
  AddField('CAshToCollect'           ,15 ,ffN  ,ftO);
  AddField('Reference1'              ,50 ,ffAN ,ftO);
  AddField('PrintRef1OnLabel'        ,1  ,ffAN ,ftO);
  AddField('Reference2'              ,50 ,ffAN ,ftO);
  AddField('PrintRef2OnLabel'        ,1  ,ffAN ,ftO);
  AddField('ChargeBackAcnt'          ,20 ,ffAN ,ftO);
  AddField('ReccuringConsignment'    ,1  ,ffAN ,ftO);
  AddField('ReturnName'              ,35 ,ffAN ,ftO);
  AddField('ReturnAdd1'              ,40 ,ffAN ,ftO);
  AddField('ReturnAdd2'              ,40 ,ffAN ,ftO);
  AddField('ReturnAdd3'              ,40 ,ffAN ,ftO);
  AddField('ReturnAdd4'              ,40 ,ffAN ,ftO);
  AddField('Returnsub'               ,50 ,ffAN ,ftO);
  AddField('ReturnState'             ,10 ,ffAN ,ftO);
  AddField('ReturnPostcode'          ,5  ,ffAN ,ftO);
  AddField('ReturnCountry'           ,30 ,ffAN ,ftO);
  AddField('RedirectBusName'         ,35 ,ffAN ,ftO);
  AddField('RedirectName'            ,35 ,ffAN ,ftO);
  AddField('RedirectAdd1'            ,40 ,ffAN ,ftO);
  AddField('RedirectAdd2'            ,40 ,ffAN ,ftO);
  AddField('RedirectAdd3'            ,40 ,ffAN ,ftO);
  AddField('RedirectAdd4'            ,40 ,ffAN ,ftO);
  AddField('Redirectsub'             ,50 ,ffAN ,ftO);
  AddField('RedirectState'           ,10 ,ffAN ,ftO);
  AddField('RedirectPostcode'        ,5  ,ffAN ,ftO);
  AddField('RedirectCountry'         ,30 ,ffAN ,ftO);
  AddField('ManifestIdentifier'      ,20 ,ffAN ,ftO);
  AddField('consigneeEmail'          ,50 ,ffAN ,ftO);
  AddField('EmailNotification'       ,10 ,ffAN ,ftO);

end;


{ TAPArticleRec }

constructor TAPArticleRec.Create;
begin
  inherited;
  TrimDatainCSV:= True;
end;

procedure TAPArticleRec.PopulateFieldDefs;
begin
  inherited;
  AddField('LineIndicator'            ,1  ,ffAN ,ftM);
  AddField('ActualWeight'             ,9  ,ffN  ,ftM);
  AddField('Length'                   ,10 ,ffN  ,ftO);
  AddField('Width'                    ,10 ,ffN  ,ftO);
  AddField('Height'                   ,10 ,ffN  ,ftO);
  AddField('noOfArticle'              ,10 ,ffN  ,ftO);
  AddField('Description'              ,40 ,ffAN ,ftO);
  AddField('Dangerous'                ,1  ,ffAN ,ftO);
  AddField('Reqdinsurance'            ,1  ,ffAN ,ftO);
  AddField('InsuranceAmt'             ,15 ,ffN  ,ftO);
  AddField('GoodValue'                ,11 ,ffN  ,ftO);
  AddField('Reason'                   ,128,ffAN ,ftO);
  AddField('ClearanceNo'              ,20 ,ffAN ,ftO);
  AddField('ReturnBySea'              ,1 ,ffAN ,ftO);
  AddField('ReturnByAir'              ,1 ,ffAN ,ftO);
  AddField('abandonGoods'             ,1 ,ffAN ,ftO);
  AddField('ReDirBySea'               ,1 ,ffAN ,ftO);
  AddField('reDirbyAir'               ,1 ,ffAN ,ftO);


end;


{ TAPGroupRec }

constructor TAPGroupRec.Create;
begin
  inherited;
  TrimDatainCSV:= True;
end;

procedure TAPGroupRec.PopulateFieldDefs;
begin
  inherited;
  AddField('LineIndicator'      ,1  ,ffAN ,ftM);
  AddField('Country'            ,30 ,ffAN ,fto);
  AddField('Tariffcode'         ,12 ,ffAN ,fto);
  AddField('Description'        ,50 ,ffAN ,fto);
  AddField('Productype'         ,20 ,ffAN ,fto);
  AddField('Classification'     ,30 ,ffAN ,fto);
  AddField('Quantity'           ,10 ,ffN ,fto);
  AddField('Weight'             ,11 ,ffN  ,fto);
  AddField('UnitValue'          ,15 ,ffN  ,fto);
  AddField('TotalValue'         ,15 ,ffN  ,fto);
end;


{ TAusPostEParcelObj }

function TAusPostEParcelObj.AddArticleRec: String;
var
  fAPArticleRec :TAPArticleRec;
begin
  fAPArticleRec := TAPArticleRec.Create;
  try
      fAPArticleRec.O['LineIndicator'].S['Value'] := RemoveCommaFromString('A');
      fAPArticleRec.O['ActualWeight'].F['Value']  := DataQry.fieldByname('ProductUOMWeight').asfloat;
      fAPArticleRec.O['Length'].I['Value']        := Trunc(DataQry.fieldByname('ProductUOMLength').asfloat);
      fAPArticleRec.O['Width'].I['Value']         :=  Trunc(DataQry.fieldByname('ProductUOMWidth').asfloat);
      fAPArticleRec.O['Height'].I['Value']        := Trunc(DataQry.fieldByname('ProductUOMHeight').asfloat);
      fAPArticleRec.O['noOfArticle'].F['Value']   := Trunc(DataQry.FieldByName('UnitofMeasureShipped').AsFloat);
      fAPArticleRec.O['Description'].S['Value']   := RemoveCommaFromString(DataQry.FieldByName('ProductName').AsString);
      fAPArticleRec.O['Dangerous'].S['Value']     := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('Dangerous').AsBoolean));
      fAPArticleRec.O['Reqdinsurance'].S['Value'] := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('Reqdinsurance').AsBoolean));
      fAPArticleRec.O['InsuranceAmt'].F['Value']  := DataQry.FieldByName('InsuranceAmount').AsFloat;
      fAPArticleRec.O['GoodValue'].F['Value']     := DataQry.FieldByName('LinePriceInc').AsFloat;
      fAPArticleRec.O['Reason'].S['Value']        := RemoveCommaFromString(DataQry.FieldByName('Product_Description').asString);
      fAPArticleRec.O['ClearanceNo'].S['Value']   := RemoveCommaFromString(''); // not sure
      fAPArticleRec.O['ReturnBySea'].S['Value']   := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('ReturnBySea').AsBoolean));
      fAPArticleRec.O['ReturnByAir'].S['Value']   := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('ReturnByAir').AsBoolean));
      fAPArticleRec.O['abandonGoods'].S['Value']  := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('abandonGoods').AsBoolean));
      fAPArticleRec.O['ReDirBySea'].S['Value']    := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('ReDirBySea').AsBoolean));
      fAPArticleRec.O['ReDirbyAir'].S['Value']    := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('ReDirbyAir').AsBoolean));
      Result:= fAPArticleRec.CSVRecordString;
  finally
    Freeandnil(fAPArticleRec);
  end;
end;

function TAusPostEParcelObj.AddGroupRec: String;
var
  fAPGroupRec :TAPGroupRec;
begin
  fAPGroupRec:= TAPGroupRec.Create;
  try
      fAPGroupRec.O['LineIndicator'].S['Value'] := RemoveCommaFromString('G');
      fAPGroupRec.O['Country'].S['Value']       := RemoveCommaFromString(DataQry.FieldByName('Country').AsString);
      fAPGroupRec.O['Tariffcode'].S['Value'] := RemoveCommaFromString(DataQry.FieldByName('Tariffcode').AsString);
      fAPGroupRec.O['Description'].S['Value'] := RemoveCommaFromString(DataQry.FieldByName('Productname').AsString);
      fAPGroupRec.O['Productype'].S['Value'] := RemoveCommaFromString(DataQry.FieldByName('consignmentProducttype').AsString);
      fAPGroupRec.O['Classification'].S['Value'] := RemoveCommaFromString(DataQry.FieldByName('Productclassification').AsString);
      fAPGroupRec.O['Quantity'].I['Value'] :=  Trunc(DataQry.FieldByName('UnitofMeasureShipped').asfloat);
      fAPGroupRec.O['Weight'].F['Value']  := DataQry.fieldByname('ProductUOMWeight').asfloat;
      fAPGroupRec.O['UnitValue'].F['Value']     := DataQry.FieldByName('LinePriceInc').AsFloat;
      fAPGroupRec.O['TotalValue'].F['Value']     := DataQry.FieldByName('TotalLineAmountinc').AsFloat;
      Result:= fAPGroupRec.CSVRecordString;
  finally
    Freeandnil(fAPGroupRec);
  end;
end;


Procedure TAusPostEParcelObj.InitHeaderRec(fAPHeaderRec : TAPHeaderRec);
begin
      fAPHeaderRec.O['LineIndicator'].S['Value']          := RemoveCommaFromString('C');
      fAPHeaderRec.O['Identifier'].S['Value']             := RemoveCommaFromString(ReplicateStr(' ', 20));
      fAPHeaderRec.O['PostAccountNumber'].S['Value']      := RemoveCommaFromString(AusPostEParcelconf.PostAccountNumber);
      fAPHeaderRec.O['Chargecode'].S['Value']             := RemoveCommaFromString(AusPostEParcelconf.ChargeCode);
      fAPHeaderRec.O['consigneecode'].S['Value']          := RemoveCommaFromString(ReplicateStr(' ',20));//
      fAPHeaderRec.O['consigneeName'].S['Value']          := RemoveCommaFromString(DataQry.FieldByName('FirstName').AsString);
      fAPHeaderRec.O['consigneeBusName'].S['Value']       := RemoveCommaFromString(DataQry.FieldByName('Company').AsString);
      fAPHeaderRec.O['consigneeAdd1'].S['Value']          := RemoveCommaFromString(DataQry.FieldByName('Street').AsString);
      fAPHeaderRec.O['consigneeAdd2'].S['Value']          := RemoveCommaFromString(DataQry.FieldByName('Street2').AsString);
      fAPHeaderRec.O['consigneeAdd3'].S['Value']          := RemoveCommaFromString(DataQry.FieldByName('Street3').AsString);
      fAPHeaderRec.O['consigneeAdd4'].S['Value']          := RemoveCommaFromString(ReplicateStr(' ', 40));
      fAPHeaderRec.O['consigneesub'].S['Value']           := RemoveCommaFromString(DataQry.FieldByName('Suburb').AsString);
      fAPHeaderRec.O['consigneeState'].S['Value']         := RemoveCommaFromString(DataQry.FieldByName('State').AsString);
      fAPHeaderRec.O['consigneePostcode'].S['Value']      := RemoveCommaFromString(DataQry.FieldByName('Postcode').AsString);
      fAPHeaderRec.O['consigneeCountry'].S['Value']       := RemoveCommaFromString(DataQry.FieldByName('Country').AsString);
      fAPHeaderRec.O['consigneePhone'].S['Value']         := RemoveCommaFromString(DataQry.FieldByName('Phone').AsString);
      fAPHeaderRec.O['consigneePhoneonLabel'].S['Value']  := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('consigneePhoneonLabel').asBoolean));
      fAPHeaderRec.O['consigneeFax'].S['Value']           := RemoveCommaFromString(DataQry.FieldByName('FaxNumber').AsString);
      fAPHeaderRec.O['DeliveryInstructions'].S['Value']   := RemoveCommaFromString(DeliveryInstructions);
      fAPHeaderRec.O['ReqdSignature'].S['Value']          := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('SignatureReqd').asBoolean));
      fAPHeaderRec.O['PartDelivery'].S['Value']           := RemoveCommaFromString(BooleanToYN(PartDelivery));
      fAPHeaderRec.O['Comments'].S['Value']               := RemoveCommaFromString(DataQry.FieldByName('Comments').AsString);
      fAPHeaderRec.O['AddconsigneeToAddbook'].S['Value']  := RemoveCommaFromString(BooleanToYN(AusPostEParcelconf.AddconsigneetoAddressBook));
      fAPHeaderRec.O['CAshToCollect'].F['Value']          := fdTotalAmount;
      fAPHeaderRec.O['Reference1'].S['Value']             := RemoveCommaFromString(DataQry.FieldByName('EParcelreference1').AsString);
      fAPHeaderRec.O['PrintRef1OnLabel'].S['Value']       := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('PrintEParcelreference1').asBoolean));
      fAPHeaderRec.O['Reference2'].S['Value']             := RemoveCommaFromString(DataQry.FieldByName('EParcelreference2').AsString);
      fAPHeaderRec.O['PrintRef2OnLabel'].S['Value']       := RemoveCommaFromString(BooleanToYN(DataQry.FieldByName('PrintEParcelreference2').asBoolean));
      fAPHeaderRec.O['ChargeBackAcnt'].S['Value']         := RemoveCommaFromString(DataQry.FieldByName('ChargeBackAcnt').asString);
      fAPHeaderRec.O['ReccuringConsignment'].S['Value']   := RemoveCommaFromString('N');// not sure
      fAPHeaderRec.O['ReturnName'].S['Value']             := RemoveCommaFromString(DataQry.FieldByName('Return_Name').AsString);
      fAPHeaderRec.O['ReturnAdd1'].S['Value']             := RemoveCommaFromString(DataQry.FieldByName('Return_street1').AsString);
      fAPHeaderRec.O['ReturnAdd2'].S['Value']             := RemoveCommaFromString(DataQry.FieldByName('Return_street2').AsString);
      fAPHeaderRec.O['ReturnAdd3'].S['Value']             := RemoveCommaFromString(DataQry.FieldByName('Return_Street3').AsString);
      fAPHeaderRec.O['ReturnAdd4'].S['Value']             := RemoveCommaFromString(ReplicateStr(' ' , 40));
      fAPHeaderRec.O['Returnsub'].S['Value']              := RemoveCommaFromString(DataQry.FieldByName('Return_suburb').AsString);
      fAPHeaderRec.O['ReturnState'].S['Value']            := RemoveCommaFromString(DataQry.FieldByName('Return_state').AsString);
      fAPHeaderRec.O['ReturnPostcode'].S['Value']         := RemoveCommaFromString(DataQry.FieldByName('Return_Postcode').AsString);
      fAPHeaderRec.O['ReturnCountry'].S['Value']          := RemoveCommaFromString(DataQry.FieldByName('Return_country').AsString);
      fAPHeaderRec.O['RedirectBusName'].S['Value']        := RemoveCommaFromString(DataQry.FieldByName('ReDir_company').AsString);
      fAPHeaderRec.O['RedirectName'].S['Value']           := RemoveCommaFromString(DataQry.FieldByName('ReDir_name').AsString);
      fAPHeaderRec.O['RedirectAdd1'].S['Value']           := RemoveCommaFromString(DataQry.FieldByName('ReDir_street1').AsString);
      fAPHeaderRec.O['RedirectAdd2'].S['Value']           := RemoveCommaFromString(DataQry.FieldByName('ReDir_street2').AsString);
      fAPHeaderRec.O['RedirectAdd3'].S['Value']           := RemoveCommaFromString(DataQry.FieldByName('ReDir_Street3').AsString);
      fAPHeaderRec.O['RedirectAdd4'].S['Value']           := RemoveCommaFromString(ReplicateStr(' ' , 40));
      fAPHeaderRec.O['Redirectsub'].S['Value']            := RemoveCommaFromString(DataQry.FieldByName('ReDir_suburb').AsString);
      fAPHeaderRec.O['RedirectState'].S['Value']          := RemoveCommaFromString(DataQry.FieldByName('ReDir_state').AsString);
      fAPHeaderRec.O['RedirectPostcode'].S['Value']       := RemoveCommaFromString(DataQry.FieldByName('ReDir_Postcode').AsString);
      fAPHeaderRec.O['RedirectCountry'].S['Value']        := RemoveCommaFromString(DataQry.FieldByName('ReDir_country').AsString);
      fAPHeaderRec.O['ManifestIdentifier'].S['Value']     := RemoveCommaFromString(ReplicateStr(' ' , 20));
      fAPHeaderRec.O['consigneeEmail'].S['Value']         := RemoveCommaFromString(DataQry.FieldByName('Email').AsString);

           if DataQry.FieldByName('EmailNotification').AsString = 'N' then fAPHeaderRec.O['EmailNotification'].S['Value']      := RemoveCommaFromString('NONE')
      else if DataQry.FieldByName('EmailNotification').AsString = 'D' then fAPHeaderRec.O['EmailNotification'].S['Value']      := RemoveCommaFromString('DESPATCH')
      else if DataQry.FieldByName('EmailNotification').AsString = 'T' then fAPHeaderRec.O['EmailNotification'].S['Value']      := RemoveCommaFromString('TRACKADV')
      else fAPHeaderRec.O['EmailNotification'].S['Value']      := RemoveCommaFromString(DataQry.FieldByName('EmailNotification').AsString);
end;

function TAusPostEParcelObj.AusPostEParcelconf: TAusPostEParcelconf;
begin
  if fAusPostEParcelconf = nil then begin
    fAusPostEParcelconf := TAusPostEParcelconf.CreateWithNewConn(fAusPostEParcelconf);
    fAusPostEParcelconf.Load;
  end;
  result:= fAusPostEParcelconf;
end;

constructor TAusPostEParcelObj.Create;
begin
  fbIsExportingtoCSV:= True;
  fAusPostEParcelconf := nil;
  PartDelivery:= False;
  inherited;
end;

destructor TAusPostEParcelObj.Destroy;
begin
  Freeandnil(fAusPostEParcelconf);
  inherited;
end;

function TAusPostEParcelObj.DoExport(const Filename: String): Boolean;
var
  stDetails, stExport:TStringlist;
  fiSaleId:Integer;
  fiArticlecount:Integer;
  fAPHeaderRec : TAPHeaderRec;
  ctr:Integer;
begin
  Result:= false;
  if not(Validatedata) then exit;
  if DataQry.RecordCount =0 then exit;

  fAPHeaderRec:= TAPHeaderRec.Create;
  try
    fiArticlecount:= 0;
    fdtotalamount := 0;
    stDetails     := TStringlist.create;
    stExport      := TStringlist.create;
    PartDelivery  := False;
    fiSaleId := DataQry.fieldByname('SaleId').asInteger;
    try
      DataQry.First;
      while (DataQry.Eof =False)  do begin
        if (fiSaleId <> DataQry.fieldByname('SaleId').asInteger) or ((fiArticlecount >=20) or ((fiArticlecount=1) and (IsInternational(DataQry.FieldByName('Country').AsString)))) then begin
          if StDetails.Count >0 then begin
            stExport.add(fAPHeaderRec.CSVRecordString);
            for ctr:= 0 to stDetails.count-1 do begin
              stExport.add(StDetails[ctr]);
            end;
          end;
          PartDelivery := (fiSaleId = DataQry.fieldByname('SaleId').asInteger);
          StDetails.clear;
          fiSaleId := DataQry.fieldByname('SaleId').asInteger;
          fiArticlecount:=0;
          fdTotalamount :=0;
        end;
        fiArticlecount:=fiArticlecount +1;
        fdtotalAmount := fdtotalAmount  +dataQry.FieldByName('TotalLineAmountInc').AsFloat;
        InitHeaderRec(fAPHeaderRec); // the header should show the amount of all lines - which is not tblsales.totalamountinc when count of lines are more than 20
        stDetails.add(AddArticleRec);
        if IsInternational(DataQry.FieldByName('Country').AsString) then
          stDetails.add(AddGroupRec);
        DataQry.Next;
      end;

      if StDetails.Count >0 then begin
        stExport.add(fAPHeaderRec.CSVRecordString);
        for ctr:= 0 to stDetails.count-1 do begin
          stExport.add(StDetails[ctr]);
        end;
      end;

      stExport.savetofile(fileNAme);
      REsult:= True;
    finally
      Freeandnil(stDetails);
    end;
  finally
    FreeandNil(fAPHeaderRec);
  end;
end;

function TAusPostEParcelObj.RemoveCommaFromString(const Value: String): String;
begin
  Result:= ReplaceStr(Value, ',' , ' ');
end;

function TAusPostEParcelObj.Validatedata: Boolean;
begin
  REsult:= TRue;
end;

 {TAusPostEParcelconf}

constructor TAusPostEParcelconf.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'auseparcelconf';
  fSQL := 'SELECT * FROM tblauseparcelconf';
end;


destructor TAusPostEParcelconf.Destroy;
begin
  inherited;
end;


procedure TAusPostEParcelconf.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PostAccountNumber');
  SetPropertyFromNode(node,'ChargeCode');
  SetBooleanPropertyFromNode(node,'AddconsigneetoAddressBook');
end;


procedure TAusPostEParcelconf.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PostAccountNumber' ,PostAccountNumber);
  AddXMLNode(node,'ChargeCode' ,ChargeCode);
  AddXMLNode(node,'AddconsigneetoAddressBook' ,AddconsigneetoAddressBook);
end;


function TAusPostEParcelconf.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TAusPostEParcelconf.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TAusPostEParcelconf.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TAusPostEParcelconf.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TAusPostEParcelconf.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TAusPostEParcelconf.GetIDField: string;
begin
  Result := 'ID'
end;


class function TAusPostEParcelconf.GetBusObjectTablename: string;
begin
  Result:= 'tblauseparcelconf';
end;


function TAusPostEParcelconf.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TAusPostEParcelconf.GetPostAccountNumber        : string    ; begin Result := GetStringField('PostAccountNumber');end;
function  TAusPostEParcelconf.GetChargeCode               : string    ; begin Result := GetStringField('ChargeCode');end;
function  TAusPostEParcelconf.GetAddconsigneetoAddressBook: Boolean   ; begin Result := GetBooleanField('AddconsigneetoAddressBook');end;
procedure TAusPostEParcelconf.SetPostAccountNumber        (const Value: string    ); begin SetStringField('PostAccountNumber'         , Value);end;
procedure TAusPostEParcelconf.SetChargeCode               (const Value: string    ); begin SetStringField('ChargeCode'                , Value);end;
procedure TAusPostEParcelconf.SetAddconsigneetoAddressBook(const Value: Boolean   ); begin SetBooleanField('AddconsigneetoAddressBook' , Value);end;


initialization
  RegisterClass(TAusPostEParcelconf);
end.

