unit GUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,XMLIntf, WebCopy, DNMSpeedButton;

type
  TForm1 = class(TForm)
    XML_File: TLabeledEdit;
    OpenDialog: TOpenDialog;
    Memo: TMemo;
    WebCheck: TWebCopy;
    MemoFailed: TMemo;
    Label1: TLabel;
    btnCheckLinks: TDNMSpeedButton;
    BitBtn2: TDNMSpeedButton;
    BitBtn1: TDNMSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnCheckLinksClick(Sender: TObject);
    procedure WebCheckURLNotFound(Sender: TObject; url: String);
    procedure WebCheckErrorInfo(Sender: TObject; ErrorCode: Integer;
      ErrorInfo: String);
    procedure WebCheckCopyProgress(Sender: TObject; fileidx: Integer; size,
      totsize: Cardinal);
  private
    { Private declarations }
    LastURL :String;
    procedure ParseXML;
    procedure ScanXmlNode(Const Node: IXMLNode);
    function GetXMLNodeStringValue(const Node: IXMLNode; const aNodeName: string): string;
    procedure AddDownloadLink(const URLPath: String);    
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
  Uses XMLDoc;
{$R *.dfm}

Const
//  URLPrefix = 'http://webupdates.p1software.com';
  URLPrefix = 'http://webupdates.erpaustralia.com.au';

procedure TForm1.BitBtn1Click(Sender: TObject);
Var
  xmlfilename :String;
begin
  If XML_File.Text<>'' then begin
    OpenDialog.InitialDir := ExtractFilePath(XML_File.Text);
    OpenDialog.FileName := '';
  end;
  if OpenDialog.Execute then begin
    xmlfilename := OpenDialog.FileName;
    XML_File.Text := xmlfilename;
  end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

function TForm1.GetXMLNodeStringValue(const Node: IXMLNode; const aNodeName: string): string;
var
  ValNode: IXMLNode;
begin
  Result := '';
  if Node = nil then Exit;
  ValNode := Node.ChildNodes.FindNode(aNodeName);
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Result := ValNode.NodeValue;
end;

procedure TForm1.ScanXmlNode(const Node: IXMLNode);
var
  CheckXMLNode :IXMLNode;
  idx :Integer;
  tmpURL:String;
begin
  for idx := 0 to Node.ChildNodes.Count -1 do begin
    CheckXMLNode := Node.ChildNodes[idx];

    tmpURL := GetXMLNodeStringValue(CheckXMLNode,'URL');
    If tmpURL<>'' then Begin
      Memo.Lines.Add(tmpURL);
      tmpURL:='';
    end;
    tmpURL := GetXMLNodeStringValue(CheckXMLNode,'TemplatesURL');
    If tmpURL<>'' then Begin
      Memo.Lines.Add(tmpURL);
      tmpURL:='';
    end;
    
    if Assigned(CheckXMLNode) then Begin
      ScanXmlNode(CheckXMLNode);
    end;
  end;
end;

procedure TForm1.ParseXML;
var
  dm        :TDataModule;
  XMLDoc   :TXMLDocument;
  RootXMLNode,
  CheckXMLNode :IXMLNode;
  idx :Integer;
begin
  Memo.Clear;
  MemoFailed.Clear;
  If not FileExists(XML_File.Text) then Exit;
  dm := TDataModule.Create(Self);
  XMLDoc := TXMLDocument.Create(dm);
  try
    XMLDoc.LoadFromFile(XML_File.Text);
    XMLDoc.Active := True;
    RootXMLNode := XMLDoc.ChildNodes.FindNode('Updates');
    if Assigned(RootXMLNode) then Begin
      for idx := 0 to RootXMLNode.ChildNodes.Count -1 do begin
        CheckXMLNode := RootXMLNode.ChildNodes[idx];
        if Assigned(CheckXMLNode) then
          ScanXmlNode(RootXMLNode.ChildNodes[idx]);
      end;
    end;
  finally
     freeAndNil(XMLDoc);
     FreeAndNil(dm);
  end;
end;

procedure TForm1.AddDownloadLink(const URLPath: String);
begin
  WebCheck.Items.Clear;
  with WebCheck.Items.Add do begin
     Protocol := wpHTTP;
     URL := URLPath;
     LastURL := URLPath;
  end;
end;

procedure TForm1.btnCheckLinksClick(Sender: TObject);
var
  idx :Integer;
begin
  ParseXML;
  Memo.Lines.Add('#-#-#-#-#-#');
  for idx := 0 to Memo.Lines.Count -2 do begin
    AddDownloadLink(URLPrefix + Memo.Lines[idx]);
    WebCheck.ThreadExecAndWait;
  end;
end;

procedure TForm1.WebCheckURLNotFound(Sender: TObject; url: String);
begin
  Memo.Lines.Add('FAILED :- '+url);
end;

procedure TForm1.WebCheckErrorInfo(Sender: TObject; ErrorCode: Integer;
  ErrorInfo: String);
begin
  If ErrorCode=404 then
    Memo.Lines.Add('FAILED {File not Found} :- '+LastURL)
  else
    Memo.Lines.Add('FAILED {'+ErrorInfo+'} :- '+LastURL);
  MemoFailed.Lines.Add(LastURL);

  WebCheck.CancelCopy;
end;

procedure TForm1.WebCheckCopyProgress(Sender: TObject; fileidx: Integer; size, totsize: Cardinal);
begin
  Memo.Lines.Add('PASSED - '+ LastURL);
  WebCheck.CancelCopy;
end;

end.
