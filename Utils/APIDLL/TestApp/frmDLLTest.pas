unit frmDLLTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ALXMLDoc, ComCtrls, ExtCtrls;

type
  TGetClassPropertyList = procedure(const ClassName: string; const PropListStream: TMemoryStream);
  TExecute = procedure(const inReqNode, outRspNode: TALXMLNode; MainApp: TApplication = nil);



  TForm1 = class(TForm)
    StatusBar: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button3: TButton;
    Label1: TLabel;
    edtClassName: TEdit;
    Panel1: TPanel;
    Button2: TButton;
    edtInFile: TEdit;
    Label2: TLabel;
    btnInFile: TButton;
    memOut: TMemo;
    Splitter1: TSplitter;
    memIn: TMemo;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnInFileClick(Sender: TObject);
    procedure edtInFileChange(Sender: TObject);
  private
    P1DllHandle: THandle;
    ExecRequest: TExecute;
  public
    { Public declarations }
  end;



var
  Form1: TForm1;

implementation

uses
  BusObjConst, XMLRequestConst, LogThreadLib, LogMessageTypes;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  inherited;
//  TLogger.Inst.LogMessageTypes:= [ltNone, ltError, ltWarning, ltInfo, ltDetail];
  P1DllHandle := LoadLibrary(PChar('C:\P1\Utils\APIDLL\Apidll.dll'));
  if P1DllHandle <> 0 then begin
    @ExecRequest:= GetProcAddress(P1DllHandle, 'Execute');
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if P1DllHandle <> 0 then
    FreeLibrary(P1DllHandle);
  inherited;
end;

procedure ModifyStrProp(aProp: string; Value: string);
begin
  aProp:= Value;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  inDoc, outDoc: TALXMLDocument;
  inNode, outNode, inBlock, outBlock: TALXMLNode;
  dt: TDateTime;
begin

  dt:= now;
  StatusBar.Panels[0].Text:= '';

  inDoc:= TALXMLDocument.Create(nil);
  outDoc:= TALXMLDocument.Create(nil);
  try
    inDoc.loadFromXML(memIn.Lines.Text); // LoadFromFile('XMLRequest.xml');
    inDoc.Active:= true;
    inNode:= inDoc.DocumentElement;
    inBlock:= inNode.ChildNodes.FindNode(XMLNodeBlock);
    outDoc := TALXMLDocument.Create('');
    outDoc.Active:= true;
    outDoc.Version:= XMLDocVersion;
    outDoc.Encoding:= XMLDocEncoding;
    {ToDo: remove the following option for production }
    outDoc.Options := outDoc.Options + [doNodeAutoIndent];
    outNode:= outDoc.AddChild(XMLNodeRoot);
    outBlock:= outNode.AddChild(XMLNodeBlock);



    if P1DllHandle <> 0 then begin
//      @ExecRequest:= GetProcAddress(P1DllHandle, 'Execute');
      ExecRequest(inBlock, outBlock, Application);
      memOut.Lines.Text:= outDoc.XML.Text;
      outDoc.SaveToFile('XMLRespoce.xml');
    end;


  finally;
    inDoc.Free;
    outDoc.Free;
  end;
  StatusBar.Panels[0].Text:= 'Done - total time: '  + FormatDateTime('hh:nn:ss:zzz',now-dt);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  GetClassPropertyList: TGetClassPropertyList;
  SL: TStringList;
  MS: TMemoryStream;
  FileName: string;
  x: integer;
begin
  if edtClassName.Text <> '' then begin
    SL:= TStringList.Create;
    MS:= TMemoryStream.Create;
    try
      @GetClassPropertyList:= GetProcAddress(P1DllHandle, 'GetClassPropertyList');
      GetClassPropertyList(edtClassName.Text, MS);
      SL.LoadFromStream(MS);
      if SL.Count > 0 then begin
        for x:= 0 to SL.Count -1 do begin
          SL[x]:=
            'INSERT INTO tblBusObjExportProp (`BusinessObjectName`,`PropertyName`) VALUES ("'+edtClassName.Text+'","'+SL[x]+'");';

        end;
        FileName:= edtClassName.Text + ' Property List.txt';
        SL.SaveToFile(FileName);
        ShowMessage('Saved to file: ' + Filename);
      end
      else begin
        ShowMessage('Nothing returned.');
      end;
    finally
      SL.Free;
      MS.Free;
    end;
  end;
end;

procedure TForm1.btnInFileClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    edtInFile.Text:= OpenDialog.FileName;
end;

procedure TForm1.edtInFileChange(Sender: TObject);
begin
  if FileExists(edtInFile.Text) then
    memIn.Lines.LoadFromFile(edtInFile.Text);
end;

end.
