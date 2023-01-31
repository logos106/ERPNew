unit SubmitMessage;

interface
uses
 XMLDoc, XMLIntf, BaseGovtalkMessage, BusObjVATreturns;

type
  TSubmitMessage = class(TBaseGovTalkMessageObj)
  private
    fVatReturn :Tvatreturns;
    fsGenericKeyID:string;
    fsDocType:string;
    fXML :string;
    fDocumentClass:string;
    fYear:integer;
    fMonth:string;
    fCurrencyCode:string;
    function HasRequiredSubmitData:boolean;
    function GetXML:string;
    procedure CreateSubmission;
  public
    constructor Create;
    Destructor  Destroy;  override;
    property XML :string read GetXML ;
    property DocumentClass :string read fDocumentClass write fDocumentClass;
    property Year:integer read fYear write fYear;
    property Month:string read fMonth write fMonth;
    property CurrencyCode:string read fCurrencyCode write fCurrencyCode;
    property DocType :string read fsDocType write fsDocType;
    property GenericKeyID:string read fsGenericKeyID write fsGenericKeyID;
  end;
implementation

uses
  FastFuncs,CommonLib, SysUtils,DnMLib;

constructor TSubmitMessage.Create;
begin
  inherited;
  fVatReturn := Tvatreturns.Create(nil);
end;

Destructor TSubmitMessage.Destroy;
begin
  FreeAndNil(fVatReturn);    
  inherited;
end;

function TSubmitMessage.HasRequiredSubmitData:boolean;
begin
  Result := True;
  if (DocumentClass = '')
    or (SenderID = '')
    or (KeyType = '')
    or (Keys = '')
    or (VendorID = '')
    or (Year = 0)
    or (Month = '')
    or (CurrencyCode = '')
    then Result := False;
end;

function TSubmitMessage.GetXML:string;
begin
  if fsDocType = 'VAT' then fVatReturn.LoadSelect('ID = ' + fsGenericKeyID );
  if HasRequiredSubmitData then begin
    CreateEnvelopeHeader;
    CreateSubmission;
    Result := fXML;
  end;
end;

procedure TSubmitMessage.CreateSubmission;
var
  tmpStr:String;
  nHeader,nMessageDetails,nClass,nGatewayTest,nKey        :IXMLNode;
  nQualifier,nFunction,nCorrelationID,nTransformation,nSenderDetails        :IXMLNode;
  nIDAuthentication,nSenderID,nAuthentication,nMethod,nValue,nGovTalkDetails:IXMLNode;
  nKeys,nChannelRouting,nChannel,nURI,nProduct,nVersion,nBody               :IXMLNode;
  nVATDeclarationRequest,nHeader2,nVATCore_Period,nVATCore_PeriodID         :IXMLNode;
  nVATCore_CurrencyCode,nBody2,nVATCore_VATDueOnOutputs                     :IXMLNode;
  nVATCore_VATDueOnECAcquisitions,nVATCore_TotalVAT                         :IXMLNode;
  nVATCore_VATReclaimedOnInputs,nVATCore_NetVAT,nVATCore_NetSalesAndOutputs :IXMLNode;
  nVATCore_NetPurchasesAndInputs,nVATCore_NetECSupplies,nVATCore_NetECAquisitions :IXMLNode;
  sPeriod,sMonth:string;
  MultiplyFactor:double;
begin
  try
    if GetMonthNo(fMonth) < 10 then sMonth := '0' + IntToStr(GetMonthNo(fMonth))
    else sMonth := IntToStr(GetMonthNo(fMonth));

    sPeriod := IntToStr(fYear) + '-' +  sMonth;    

    nHeader                     := fnGate.AddChild('Header');
    nMessageDetails             := nHeader.AddChild('MessageDetails');
    nClass                      := nMessageDetails.AddChild('Class');
    nClass.Text                 := DocumentClass;
    nQualifier                  := nMessageDetails.AddChild('Qualifier');
    nQualifier.Text             := 'request';
    nFunction                   := nMessageDetails.AddChild('Function');
    nFunction.Text              := 'submit';
    nCorrelationID              := nMessageDetails.AddChild('CorrelationID');
    nTransformation             := nMessageDetails.AddChild('Transformation');
    nTransformation.Text        := 'XML';
    nGatewayTest                := nMessageDetails.AddChild('GatewayTest');
    nGatewayTest.Text           := TestValue;
    nSenderDetails              := nHeader.AddChild('SenderDetails');
    nIDAuthentication           := nSenderDetails.AddChild('IDAuthentication');
    nSenderID                   := nIDAuthentication.AddChild('SenderID');
    nSenderID.Text              := SenderID;
    nAuthentication             := nIDAuthentication.AddChild('Authentication');
    nMethod                     := nAuthentication.AddChild('Method');
    nMethod.Text                := 'clear';
    nValue                      := nAuthentication.AddChild('Value');
    nValue.Text                 := AuthenticationValue;
    nGovTalkDetails             := fnGate.AddChild('GovTalkDetails');
    nKeys                       := nGovTalkDetails.AddChild('Keys');
    nKey                        := nKeys.AddChild('Key');
    nKey.Attributes['Type']     := KeyType;
    nKey.Text                   := Keys;
    nChannelRouting             := nGovTalkDetails.AddChild('ChannelRouting');
    nChannel                    := nChannelRouting.AddChild('Channel');
    nURI                        := nChannel.AddChild('URI');
    nURI.Text                   := VendorID;
    nProduct                    := nChannel.AddChild('Product');
    nProduct.Text               := 'TERP';
    nVersion                    := nChannel.AddChild('Version');
    nVersion.Text               := '1.0';

    nBody                       := fnGate.AddChild('Body');
   
    nVATDeclarationRequest      := nBody.AddChild('VATDeclarationRequest');
    nVATDeclarationRequest.Attributes['xmlns'] := 'http://www.govtalk.gov.uk/taxation/vat/vatdeclaration/1';
    nVATDeclarationRequest.Attributes['xmlns:n1'] := 'http://www.govtalk.gov.uk/CM/gms-xs';
    nVATDeclarationRequest.Attributes['xmlns:VATCore'] := 'http://www.govtalk.gov.uk/taxation/vat/core/1';
    nVATDeclarationRequest.Attributes['xmlns:xsi'] := 'http://www.w3.org/2001/XMLSchema-instance';
    nVATDeclarationRequest.Attributes['xsi:schemaLocation'] := 'http://www.govtalk.gov.uk/taxation/vat/vatdeclaration/1 VATDeclarationRequest.xsd';
    nVATDeclarationRequest.Attributes['SchemaVersion'] := '1.0';

    nHeader2                    := nVATDeclarationRequest.AddChild('Header');
    nVATCore_Period             := nHeader2.AddChild('VATCore:VATPeriod');
    nVATCore_PeriodID           := nVATCore_Period.AddChild('VATCore:PeriodId');

    tmpStr := IntToStr(Year);
    tmpStr := tmpStr + '-' + IntToStr(MonthNameToNumber(Month));

    nVATCore_PeriodID.Text      := sPeriod;
    nVATCore_CurrencyCode       := nHeader2.AddChild('VATCore:CurrencyCode');
    nVATCore_CurrencyCode.Text  := CurrencyCode;

    nBody2                              := nVATDeclarationRequest.AddChild('Body');
    nVATCore_VATDueOnOutputs            := nBody2.AddChild('VATCore:VATDueOnOutputs');
    if fVatReturn.VAT1 < 0 then MultiplyFactor := -1 else MultiplyFactor := 1;
    nVATCore_VATDueOnOutputs.Text       := formatFloat('0000000000#.00',(fVatReturn.VAT1 * MultiplyFactor));
    nVATCore_VATDueOnECAcquisitions     := nBody2.AddChild('VATCore:VATDueOnECAcquisitions');
    if fVatReturn.VAT2 < 0 then MultiplyFactor := -1 else MultiplyFactor := 1;
    nVATCore_VATDueOnECAcquisitions.Text:= formatFloat('0000000000#.00',(fVatReturn.VAT2 * MultiplyFactor));
    nVATCore_TotalVAT                   := nBody2.AddChild('VATCore:TotalVAT');
    if fVatReturn.VAT3 < 0 then MultiplyFactor := -1 else MultiplyFactor := 1;
    nVATCore_TotalVAT.Text              := formatFloat('0000000000#.00',(fVatReturn.VAT3 * MultiplyFactor));
    nVATCore_VATReclaimedOnInputs       := nBody2.AddChild('VATCore:VATReclaimedOnInputs');
    if fVatReturn.VAT4 < 0 then MultiplyFactor := -1 else MultiplyFactor := 1;
    nVATCore_VATReclaimedOnInputs.Text  := formatFloat('0000000000#.00',(fVatReturn.VAT4 * MultiplyFactor));
    nVATCore_NetVAT                     := nBody2.AddChild('VATCore:NetVAT');
    if fVatReturn.VAT5 < 0 then MultiplyFactor := -1 else MultiplyFactor := 1;
    nVATCore_NetVAT.Text                := formatFloat('0000000000#.00',(fVatReturn.VAT5 * MultiplyFactor));
    nVATCore_NetSalesAndOutputs         := nBody2.AddChild('VATCore:NetSalesAndOutputs');
    if fVatReturn.VAT6 < 0 then MultiplyFactor := -1 else MultiplyFactor := 1;
    nVATCore_NetSalesAndOutputs.Text    := formatFloat('0000000000#',(fVatReturn.VAT6 * MultiplyFactor));
    nVATCore_NetPurchasesAndInputs      := nBody2.AddChild('VATCore:NetPurchasesAndInputs');
    if fVatReturn.VAT7 < 0 then MultiplyFactor := -1 else MultiplyFactor := 1;
    nVATCore_NetPurchasesAndInputs.Text := formatFloat('0000000000#',(fVatReturn.VAT7 * MultiplyFactor));
    nVATCore_NetECSupplies              := nBody2.AddChild('VATCore:NetECSupplies');
    if fVatReturn.VAT8 < 0 then MultiplyFactor := -1 else MultiplyFactor := 1;
    nVATCore_NetECSupplies.Text         := formatFloat('0000000000#',(fVatReturn.VAT8 * MultiplyFactor));
    nVATCore_NetECAquisitions           := nBody2.AddChild('VATCore:NetECAcquisitions');
    if fVatReturn.VAT9 < 0 then MultiplyFactor := -1 else MultiplyFactor := 1;
    nVATCore_NetECAquisitions.Text      := formatFloat('0000000000#',(fVatReturn.VAT9 * MultiplyFactor));

    fXML :=  fXMLDoc.XML.Text;
  except

  end;
end;

end.
