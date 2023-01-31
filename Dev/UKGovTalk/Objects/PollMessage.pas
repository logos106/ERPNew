unit PollMessage;

interface

uses
 XMLDoc, XMLIntf, BaseGovtalkMessage;

type
    TPollMessage = class(TBaseGovTalkMessageObj)
  private
    fXML        :string;
    fDocumentClass:string;
    fCorrelationID:string;
    function HasRequiredPollData:boolean;
    function GetXML:string;
    procedure CreatePoll;
  public
    property XML :string read GetXML ;
    property DocumentClass :string read fDocumentClass write fDocumentClass;
    property CorrelationID:string read fCorrelationID write fCorrelationID;
  end;
  
implementation




function TPollMessage.GetXML:string;
begin
  if HasRequiredPollData then begin
    CreateEnvelopeHeader;
    CreatePoll;
    Result := fXML;
  end;
end;

procedure TPollMessage.CreatePoll;
var
  nHeader,nMessageDetails,nClass,nGatewayTest,nSenderDetails        :IXMLNode;
  nQualifier,nFunction,nCorrelationID,nTransformation,nIDAuthentication   :IXMLNode;
  nAuthentication,nSenderID,nMethod,nValue   :IXMLNode;
begin
  try
    nHeader                     := fnGate.AddChild('Header');
    nMessageDetails             := nHeader.AddChild('MessageDetails');
    nClass                      := nMessageDetails.AddChild('Class');
    nClass.Text                 := DocumentClass;
    nQualifier                  := nMessageDetails.AddChild('Qualifier');
    nQualifier.Text             := 'poll';
    nFunction                   := nMessageDetails.AddChild('Function');
    nFunction.Text              := 'submit';
    nCorrelationID              := nMessageDetails.AddChild('CorrelationID');
    nCorrelationID.Text         := CorrelationID;
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

    fnGate.AddChild('GovTalkDetails');
    fnGate.AddChild('Body');       

    fXML :=  fXMLDoc.XML.Text;
  except

  end;
end;

function TPollMessage.HasRequiredPollData:boolean;
begin
  Result := True;
  if (DocumentClass = '')
    or (CorrelationID = '')  
    then Result := False;
end;
end.

