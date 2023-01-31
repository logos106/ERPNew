unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, LbCipher, LbClass, ALXmlDoc, ComCtrls;

type
  TfmMain = class(TForm)
    pnlTop: TPanel;
    memClientEmail: TMemo;
    btnReadLicence: TButton;
    lbKey: TLabel;
    LbBlowfish: TLbBlowfish;
    lbxml: TLabel;
    XMLDocument: TALXMLDocument;
    Label1: TLabel;
    edtClientId: TEdit;
    edMID: TLabeledEdit;
    edLicenceID: TLabeledEdit;
    edCompanyName: TLabeledEdit;
    btnEncodeLicence: TButton;
    Label15: TLabel;
    edNoMultiSites: TLabeledEdit;
    dtExpires: TDateTimePicker;
    Label14: TLabel;
    dtStarts: TDateTimePicker;
    Label2: TLabel;
    edNoClientSlots: TLabeledEdit;
    lbxmlOut: TLabel;
    cboLicence: TComboBox;
    procedure btnReadLicenceClick(Sender: TObject);
    procedure btnEncodeLicenceClick(Sender: TObject);
    procedure dtStartsChange(Sender: TObject);
  private
    procedure DecodeLicence;
    procedure EncodeLicence;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

{ TfmMain }

function MySQLDateStrToDate(const s: string): TDateTime;
var
  year, month, day: word;
begin
  year:= StrToInt(copy(s,1,4));
  month:= StrToInt(copy(s,6,2));
  day:= StrToInt(copy(s,9,2));
  result:= EncodeDate(year,Month,day);
end;

procedure TfmMain.DecodeLicence;
var 
  code: string;
  key: string;
  xml: string;
  i: integer;
  p1, p2: integer;
  lic: TALXMLNode;
//  ClientID:Integer;

  function attr(const Name: string): string;
  begin
    Result := '';
    if lic.Attributes[Name] <> null then Result := lic.Attributes[Name];
  end; //attr

begin
  inherited;
  p1 := Pos('*******>', memClientEmail.Text) + 8;
  p2 := Pos('<*******', memClientEmail.Text) - 1;
  code := '';
  //SetLength(code, p2-p1+1);
  for i := p1 to p2 do if memClientEmail.Text[i] > ' ' then code := code + memClientEmail.Text[i];
  key := Copy(code, Length(code) - 7, 8);
  lbKey.Caption := key;
  lbBlowfish.GenerateKey(key + key);
  xml := '';
  xml := lbBlowfish.DecryptString(Copy(code, 1, Length(code) - 8));

  lbxml.Caption := xml;

  XMLDocument.XML.Text := xml;
  XMLDocument.Active := true;
  lic := XMLDocument.DocumentElement;

  edtClientID.Text := attr('clientid');
  edMID.Text := key;
  edLicenceID.Text := attr('licenceid');
  edCompanyName.Text := attr('companyname');
  cboLicence.Text:= attr('licence');
  dtStarts.Date:= MySQLDateStrToDate(attr('expires'));
  dtStartsChange(dtStarts);
  edNoMultisites.Text:= attr('nomultisites');
  edNoClientSlots.Text:= attr('noclientslots');

//  ClientID := CheckLicClientID(StrToIntDef(edLicenceID.Text,0));
//  if (ClientID<>0) AND (StrToIntDef(edtClientID.Text,0)<>ClientID) then
//    edtClientID.Text := IntToStr(ClientID);

//  luClientSystem.Enabled := edMID.Text > '';
//  cbInvoiceSelect.Enabled := edMID.Text > '';

//  qryClientsLookup.Open;
//  if qryClientsLookup.Locate('ClientID', edClientID.Text, []) then begin
//    luClientSystem.Text     := qryClientsLookup.FieldByName('company').AsString;
//    luClientSystem.Enabled  := false;
//    cbInvoiceSelect.Visible := false;
//  end;
end;

procedure TfmMain.btnReadLicenceClick(Sender: TObject);
begin
  DecodeLicence;
end;

procedure TfmMain.EncodeLicence;

  function EscapeForXML(const s: string): string;
  var 
    i: integer;
    ch: string;
  begin
    for i := 1 to Length(s) do begin
      case s[i] of
        '&': ch := '&amp;';
        '<': ch := '&lt;';
        '>': ch := '&gt;';
        '''': ch := '&apos;';
        '"': ch := '&quot;';
        else ch := s[i];
      end;
      Result := Result + ch;
    end;
  end;
var 
  xml: string;
//  sql: string;
  memo: TMemo;
  i: integer;
const
  MysqlDateFormat = 'yyyy-mm-dd';
  MysqlDateTimeFormat = 'yyyy-mm-dd hh:nn:ss';

begin
  memo := TMemo.Create(nil);
  memo.Visible := false;
  memo.Parent := self;
  try
    lbBlowfish.GenerateKey(lbkey.Caption + lbkey.Caption);
    xml := '<Licence' + ' machineid="' + edMID.Text + '"' + ' licence="' + cboLicence.Text + '"' +
      ' licenceid="' + edlicenceID.Text + '"' + ' clientid="' + edtClientID.Text + '"' + ' noclientslots="' +
      edNoClientSlots.Text + '"' + ' nomultisites="' + edNoMultisites.Text + '"' + ' companyname="' +
      EscapeForXML(edCompanyName.Text) + '"' + ' begins="' + FormatDateTime(MysqlDateFormat,
      Date) + '"' + ' expires="' + FormatDateTime(MysqlDateFormat, dtExpires.Date) + '"' + '/>';
    lbxmlOut.Caption := xml;
    with TStringList.Create do begin
      Text:= xml;
      savetofile(ExtractFilePath(Application.ExeName) + 'Licence_xml.txt');
      free;
    end;
    xml := lbBlowfish.EncryptString(xml){ + edMID.Text};

    with memo.Lines do begin
      Add('To ' + edCompanyName.Text);
      Add('ERP Licence for   Server ' + edCompanyName.Text);
      Add(''); 
      Add(''); 
      Add('To process click Menu "Help | Register" and follow instructions');
      Add('');    
      Add('COPY FROM HERE >>');
      Add('************ Do not change text from here on *****************>');
      Add('');
      i := 1;
      while i <= Length(xml) do begin
        Add(Copy(xml, i, 50));
        Inc(i, 50);
      end;
      Add('');
      Add('<*********** Do not change text before this ******************');
      Add('<< TO HERE');
      Add('');
    end;

    memo.SelectAll;
    memo.CopyToClipboard;

//    sql := Format('INSERT HIGH_PRIORITY INTO tbllicencehistory SET ' +
//      'Issued="%s", LicenceID="%s", UserID="%d", ServerMID="%s", LicenceXML="%s";',
//      [FormatDateTime(MysqlDateTimeFormat, Now), edlicenceID.Text, AppEnv.Employee.EmployeeID, lbKey.Caption,
//      FastFuncs.AnsiStringReplace(lbxmlOut.Caption, '"', '\"', [rfReplaceAll,rfIgnoreCase])]);
//    CommonDbLib.GetSharedMyDacConnection.ExecSQL(sql, []);
  finally
    FreeandNil(memo);
  end;
end;

procedure TfmMain.btnEncodeLicenceClick(Sender: TObject);
begin
  EncodeLicence;
end;

procedure TfmMain.dtStartsChange(Sender: TObject);
var
  year, month, day: word;
begin
  DecodeDate(dtStarts.Date,year,month,day);
  dtExpires.Date:= EncodeDate(year+1,month,day);
end;

end.
