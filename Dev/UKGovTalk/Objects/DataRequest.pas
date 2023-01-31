unit DataRequest;

interface

uses
 XMLDoc, XMLIntf, BaseGovtalkMessage;

type
    TDataRequest = class(TBaseGovTalkMessageObj)
  private
    fXML                :string;
    fDocumentClass      :string;
    fSenderID           :string;
    fKeyType            :string;
    fKeys               :string;
    fVendorID           :string;
    fStartDate          :String;
    fEndDate            :string;
    fStartTime          :string;
    fEndTime            :string;
    function HasRequiredData:boolean;
    function GetXML:string;
    procedure CreateRequest;  
  public
    property XML :string read GetXML ;
    property DocumentClass :string read fDocumentClass write fDocumentClass;
    property SenderID :string read fSenderID write fSenderID;
    property KeyType :string read fKeyType write fKeyType;
    property Keys :string read fKeys write fKeys;
    property VendorID :string read fVendorID write fVendorID;
    property StartDate:string read fStartDate write fStartDate;
    property EndDate:string read fEndDate write fEndDate;
    property StartTime:string read fStartTime write fStartTime;
    property EndTime:string read fEndTime write fEndTime;
  end;
implementation



function TDataRequest.HasRequiredData:boolean;
begin
  Result := True;
  if (DocumentClass = '')
    or (SenderID = '')
    or (VendorID = '')
    or (StartDate = '')
    or (EndDate = '')     
    then Result := False;
end;

function TDataRequest.GetXML:string;
begin  
  if HasRequiredData then begin
    CreateEnvelopeHeader;
    CreateRequest;
    Result := fXML;
  end;
end;

procedure TDataRequest.CreateRequest;
var
  nHeader,nMessageDetails,nClass,nQualifier,nFunction,nEndTime          :IXMLNode;
  nTransformation,nSenderDetails,nIDAuthentication       :IXMLNode;
  nAuthentication,nMethod,nValue,nSenderID              :IXMLNode;
  nBody ,nStartDate,nEndDate,nStartTime                                 :IXMLNode;

begin
  StartTime := '01:01:01';
  EndTime := '01:01:01';
  try
    nHeader                     := fnGate.AddChild('Header');//,govtalkgovuk_CM_envelope);
 //   nHeader.Attributes['xmlns']   := govtalkgovuk_CM_envelope;
    nMessageDetails             := nHeader.AddChild('MessageDetails');
    nClass                      := nMessageDetails.AddChild('Class');
    nClass.Text                 := DocumentClass;
    nQualifier                  := nMessageDetails.AddChild('Qualifier');
    nQualifier.Text             := 'request';
    nFunction                   := nMessageDetails.AddChild('Function');
    nFunction.Text              := 'list';
    nMessageDetails.AddChild('CorrelationID');
    nTransformation             := nMessageDetails.AddChild('Transformation');
    nTransformation.Text        := 'XML';
    nSenderDetails              := nHeader.AddChild('SenderDetails');
    nIDAuthentication           := nSenderDetails.AddChild('IDAuthentication');
    nSenderID                   := nIDAuthentication.AddChild('SenderID');
    nSenderID.Text              := SenderID;
    nAuthentication             := nIDAuthentication.AddChild('Authentication');
    nMethod                     := nAuthentication.AddChild('Method');
    nMethod.Text                := 'clear';
    nValue                      := nAuthentication.AddChild('Value');
    nValue.Text                 := AuthenticationValue;

    fnGate.AddChild('GovTalkDetails');//,govtalkgovuk_CM_envelope);
  //  nGovTalkDetails.Attributes['xmlns']   := govtalkgovuk_CM_envelope;
    nBody                       := fnGate.AddChild('Body');//,govtalkgovuk_CM_envelope);
    nStartDate                  := nBody.AddChild('StartDate');
    nStartDate.Text             := StartDate;
    nEndDate                    := nBody.AddChild('EndDate');
    nEndDate.Text               := EndDate;
    nStartTime                  := nBody.AddChild('StartTime');
    nStartTime.Text             := StartTime;
    nEndTime                    := nBody.AddChild('EndTime');
    nEndTime.Text               := EndTime;

    fXML :=  fXMLDoc.XML.Text;
  except

  end;
end;


end.
