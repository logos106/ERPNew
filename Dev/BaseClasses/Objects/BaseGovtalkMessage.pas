unit BaseGovtalkMessage;

interface

uses
  XMLDoc, XMLIntf;

type
  TBaseGovTalkMessageObj = class(TObject)
  private
    fAuthenticationValue:string;
    fTestValue          :string;
    fSenderID           :string;
    fKeyType            :string;
    fKeys               :string;
    fVendorID           :string;
  protected
    fXMLDoc     :IXMLDocument;
    fnGate,fnEnvelopeVersion : IXMLNode;
    procedure CreateEnvelopeHeader;
  public
    constructor Create;
    property TestValue :string read fTestValue write fTestValue;
    property AuthenticationValue :string read fAuthenticationValue write fAuthenticationValue;
    property SenderID :string read fSenderID write fSenderID;
    property KeyType :string read fKeyType write fKeyType;
    property Keys :string read fKeys write fKeys;
    property VendorID :string read fVendorID write fVendorID;
  end;

implementation

uses
  SysUtils, tcConst;

constructor TBaseGovTalkMessageObj.Create;
begin
  inherited;
end;

procedure TBaseGovTalkMessageObj.CreateEnvelopeHeader;
begin
  fXMLDoc := TXMLDocument.Create(nil);
  try
    fXMLDoc.Active       := True;
    fXMLDoc.Version := '1.0' ;
    fXMLDoc.Encoding := 'UTF-8';
    fnGate := fXMLDoc.AddChild('GovTalkMessage');
    fnGate.Attributes['xmlns'] := govtalkgovuk_CM_envelope;

    fnEnvelopeVersion            := fnGate.AddChild('EnvelopeVersion');
    fnEnvelopeVersion.Text       := '2.0';
  except

  end;
end;

end.

