{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 31/05/06  1.00.01 RM  Takes XML text , creates a file,
                       attaches it to an email and sends to email queue

}
unit XMLEmailObj;

interface
uses SysUtils,Classes;

type
  TXMLEmailObj = class(TObject)
  private
    fsAddress   : String;
    fsXMLText   : String;

    function CreateXMLFile(Const XMLText:string):string;
  public
    property EmailXMLAddress: string read fsAddress write fsAddress;
    property XMLText: string read fsXMLText write fsXMLText;
    constructor Create;
    procedure SendEmail(Const sFrom,sTo,XMLText,sSubject,sMessage:string; aCustomerId: integer = 0; aSupplierId: integer = 0);
  end;

implementation

uses
  Forms, EmailUtils, windows, DNMLib, SystemLib, CorrespondenceObj, EmailExtraUtils;

function TXMLEmailObj.CreateXMLFile(Const XMLText:string):String;
var
  s:TStrings;
begin
  result:= SystemLib.WinTempDir + 'XMLData.xml';
  s := TStringList.Create;
  try
    s.Add(XMLText);
//    if not FileExists(SystemLib.ExeDir + 'XMLData.xml') then  s.SaveToFile(SystemLib.ExeDir + 'XMLData.xml');
    if not FileExists(result) then  s.SaveToFile(result);
//    result :=  'XMLData.xml';
  finally
    FreeAndNil(s);
  end;
end;

procedure TXMLEmailObj.SendEmail(Const sFrom,sTo,XMLText,sSubject,sMessage: string;
  aCustomerId: integer = 0; aSupplierId: integer = 0);
var
  sFileName : string;
  Corres: TCorrespondenceGui;
  lSilent,
  lSecret : boolean;
begin
  Corres := TCorrespondenceGui.Create;
  try
    sFileName := CreateXMLFile(XMLText);
    if sFrom <> '' then
      Corres.From := sFrom;
    Corres.RecipientList := sTo;
    Corres.Subject := sSubject;
    Corres.MessageText := sMessage;
    Corres.CustomerId := aCustomerId;
    Corres.SupplierId := aSupplierId;
    if FileExists(sFileName) then
      Corres.AttachmentList.Add(sFileName);
    if not EmailShortSendMode(lSilent, lSecret) then
      exit;
    try
      Corres.Execute(lSilent, lSecret);
    except

    end;
  finally
    FreeAndNil(Corres);

    if FileExists(sFileName) then SysUtils.DeleteFile(sFileName);
  end;
end;


constructor TXMLEmailObj.Create;
begin
  inherited; 

end;

end.
