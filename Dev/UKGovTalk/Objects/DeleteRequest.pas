unit DeleteRequest;

interface

uses
 XMLDoc, XMLIntf, BaseGovtalkMessage;

type
    TDeleteRequest = class(TBaseGovTalkMessageObj)
  private
    fXML        :string;
    fDocumentClass:string;
    fCorrelationID:string;
    function HasRequiredData:boolean;
    function GetXML:string;
    procedure CreateDeleteRequest;
  public
    property XML :string read GetXML ;
    property DocumentClass :string read fDocumentClass write fDocumentClass;
    property CorrelationID:string read fCorrelationID write fCorrelationID;
  end;
  
implementation

uses
  tcConst;

function TDeleteRequest.GetXML:string;
begin
  if HasRequiredData then begin
    CreateEnvelopeHeader;
    CreateDeleteRequest;
    Result := fXML;
  end;
end;

procedure TDeleteRequest.CreateDeleteRequest;
var
  nHeader,nMessageDetails,nClass,nGatewayTest        :IXMLNode;
  nQualifier,nFunction,nCorrelationID,nTransformation :IXMLNode; 
begin
  try
    nHeader                     := fnGate.AddChild('Header');
    nHeader.Attributes['xmlns'] :=  govtalkgovuk_CM_envelope;
    nMessageDetails             := nHeader.AddChild('MessageDetails');
    nClass                      := nMessageDetails.AddChild('Class');
    nClass.Text                 := DocumentClass;
    nQualifier                  := nMessageDetails.AddChild('Qualifier');
    nQualifier.Text             := 'request';
    nFunction                   := nMessageDetails.AddChild('Function');
    nFunction.Text              := 'delete';
    nCorrelationID              := nMessageDetails.AddChild('CorrelationID');
    nCorrelationID.Text         := CorrelationID;
    nTransformation             := nMessageDetails.AddChild('Transformation');
    nTransformation.Text        := 'XML';
    nGatewayTest                := nMessageDetails.AddChild('GatewayTest');
    nGatewayTest.Text           := TestValue;
    nHeader.AddChild('SenderDetails');
    fnGate.AddChild('GovTalkDetails');
    fnGate.AddChild('Body');

    fXML :=  fXMLDoc.XML.Text;
  except

  end;
end;

function TDeleteRequest.HasRequiredData:boolean;
begin
  Result := True;
  if (DocumentClass = '')
    or (CorrelationID = '')  
    then Result := False;
end;        

end.
