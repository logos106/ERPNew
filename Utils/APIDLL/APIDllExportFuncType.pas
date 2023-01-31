unit APIDllExportFuncType;

interface

uses
  Classes, ALXMLDoc, Forms;

type

  TOpenCompany = function((*var msg: string;*) const User, Pass, dbname: string;
                     Server: string = ''; ServerPort: integer = 0): boolean;
  TCloseCompany = procedure();
  TExecute = procedure(const inReqNode, outRspNode: TALXMLNode; MainApp: TApplication = nil);

//  TProcessXML= procedure(const inBlock, outBlock: TALXMLNode);
//  TProcessXMLRequestNode = procedure(const InNode, OutNode: TALXMLNode);
  TGetClassPropertyList = procedure(const ClassName: string; const PropListStream: TMemoryStream);

implementation

end.
