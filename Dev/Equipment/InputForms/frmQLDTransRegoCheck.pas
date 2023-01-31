unit frmQLDTransRegoCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseWebBrowser, SelectionDialog, Menus, ExtCtrls, OleCtrls, SHDocVw,
  StdCtrls, JSONObject, Shader, DNMPanel;

const
  QLDVehiclefields : Array [1..6] of String = ('Registration number','Vehicle Identification Number (VIN)','Description','Purpose of use','Status','Expiry');


  type
  TfmQLDTransRegoCheck = class(TBaseWebBrowserGUI)
    DNMPanel1: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    tmrQLDRegisteredVehiclecheck: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure WebBrowserDocumentComplete(ASender: TObject;const pDisp: IDispatch; var URL: OleVariant);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tmrQLDRegisteredVehiclecheckTimer(Sender: TObject);
  private
    fiBrowserProgressLevel:Integer;
    RegoSearchResult: TJsonObject;
    fProgressproc :TNotifyEvent;
    fsRego :String;
    fdBrowserCheckTime:Tdatetime;
    Procedure DoCheckRego;
    function  Buttonclick(const buttoncaption: String):Boolean;
    function getProgressStatus: String;
    procedure ReadBrowser;
  public
    class Procedure  CheckRego(AOwner:TComponent; aRego: String;  aProgressproc: TNotifyEvent;var ajson:TJsonObject);
    Property ProgressStatus:String read getProgressStatus;
    Property BrowserProgresslevel :Integer read fiBrowserProgresslevel;
  end;


implementation

uses  types , ActiveX, dateutils, CommonLib, tcConst, LogLib;

{$R *.dfm}

{ TfmQLDTransRegoCheck }

function TfmQLDTransRegoCheck.Buttonclick(const buttoncaption: String):boolean;
var
  Buttons: OleVariant;
  Button: OleVariant;
  I: Integer;
begin
  result := False;
  Buttons := WebBrowser.OleObject.Document.getElementsByTagName('button');
  for I := 0 to Buttons.Length - 1 do  begin
    Button := Buttons.item(I);

    if Button.innerText = buttoncaption then begin
      Button.click();
      result := True;
      //break; // donot break, if there are multiple buttons with the same caption
    end;
  end;

end;

class Procedure  TfmQLDTransRegoCheck.CheckRego(AOwner:TComponent; aRego: String;  aProgressproc: TNotifyEvent;var ajson:TJsonObject);
var
  aForm : TfmQLDTransRegoCheck;
begin
    if arego = '' then exit;
      aform := TfmQLDTransRegoCheck.Create(AOwner);
      try
        aform.RegoSearchResult:= ajson;
        aform.fProgressproc   := aProgressproc;
        aForm.fsRego          := aRego;
        aForm.ShowModal;
      finally
        //Freeandnil(aform);
      end;
end;

procedure TfmQLDTransRegoCheck.DoCheckRego;
begin
  fiBrowserProgressLevel := 1;
  WebBrowser.Navigate('https://www.service.transport.qld.gov.au/checkrego/application/TermAndConditions.xhtml');
end;

procedure TfmQLDTransRegoCheck.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  tmrQLDRegisteredVehiclecheck.Enabled:= False;
  Action := caFree;
end;

procedure TfmQLDTransRegoCheck.FormCreate(Sender: TObject);
begin
  inherited;
  WebBrowser.Silent := True;
  WebBrowser.height := 1;
  fiBrowserProgressLevel := 0;
  Height := 200;
  fdBrowserCheckTime:=0;
end;

procedure TfmQLDTransRegoCheck.FormShow(Sender: TObject);
begin
  inherited;
  clog('');
  fdBrowserCheckTime:= now;
  borderstyle := bsNone;
  tmrQLDRegisteredVehiclecheck.Enabled:= True;
  DoCheckRego;
end;

function TfmQLDTransRegoCheck.getProgressStatus: String;
begin
  REsult := '';
       if  fiBrowserProgressLevel = 1 then result := 'Linking to QLD Transport Site'
  else if  fiBrowserProgressLevel = 2 then result := 'Accept QLD Transport Site Terms and Conditions'
  else if  fiBrowserProgressLevel = 3 then result := 'Checking for Rego '+Quotedstr(fsRego)
end;

procedure TfmQLDTransRegoCheck.WebBrowserDocumentComplete(ASender: TObject;  const pDisp: IDispatch; var URL: OleVariant);
begin
  inherited;
  if Assigned(fProgressproc) then fProgressproc(Self);
  fdBrowserCheckTime := now;
  if fiBrowserProgressLevel = 1 then begin
    logtext('Accpet terms and cond');
    fiBrowserProgressLevel := 2;
    if not Buttonclick('Accept') then WebBrowserDocumentComplete(ASender , pDisp, URL); // when called the form again, the Terms and C are already accepted, so this page will not be displayed, so skip it and go to the next step
  end else if fiBrowserProgresslevel = 2 then begin
    logtext('enter Rego');
    fiBrowserProgresslevel := 3;
    WebBrowser.OleObject.Document.getElementById('vehicleSearchForm:plateNumber').setAttribute('value', fsRego);
    Buttonclick('Search');
  end else if fiBrowserProgresslevel = 3 then begin
    logtext('Reading output');
    Readbrowser;
    fiBrowserProgresslevel := 4;
    if Assigned(fProgressproc) then fProgressproc(Self);
    tmrQLDRegisteredVehiclecheck.Enabled:= False;
    modalresult := mrOk;
  end;

end;
Procedure TfmQLDTransRegoCheck.ReadBrowser;
var
  strStream: TStringStream;
  adapter: IStream;
  browserStream: IPersistStreamInit;
  sresult:String;
  Jsonctr :Integer;
  ctr:Integer;
  Function readDefListItem(Tagname:String):String;
  var
    s:String;
    ctr:Integer;
  begin
    result := '';
    s:= sresult;
    if pos('<dt>'+ Tagname ,  s)<=0 then exit;

    s:= trim(copy(s,pos('<dt>'+ Tagname ,  s) , Length(s)));
    s:=replacestr(s, '<dt>'+ Tagname, '');

    if pos('</dt>' ,  s)<>1 then exit;
    s:= trim(copy(s,6,  Length(s)));

    if pos('<dd>', s)<> 1 then exit;
    s:= trim(copy(s,5,  Length(s)));

    if pos('</dd>', s)<=0 then exit;
    s:= trim(copy(s,1, pos('</dd>',  s)-1 ));

    result := s;

  end;

begin
  strStream := TStringStream.Create('');
  try
    browserStream := webBrowser.Document as IPersistStreamInit;
    adapter := TStreamAdapter.Create(strStream,soReference);
    browserStream.Save(adapter,true);
    sresult := strStream.DataString;
    sresult := copy(sresult , pos('<form id="j_id_2a" ', sresult) , length(sREsult));
    sresult := copy(sresult , 1, pos('</form>', sresult) );
    sresult := replacestr(sresult, chr(10), '');
    sresult := replacestr(replacestr(sresult, chr(10) , '' ) , #9 , '' );
    Jsonctr := 0;
    for ctr := low(QLDVehiclefields) to high(QLDVehiclefields) do begin
      Jsonctr := Jsonctr +1;
      RegoSearchResult.O[IntToStr(Jsonctr)].S['Name']:= QLDVehiclefields[ctr];
      if ctr =  high(QLDVehiclefields) then begin
        try RegoSearchResult.O[IntToStr(Jsonctr)].Dt['Value']:= strtoDateTime(readDefListItem(QLDVehiclefields[ctr])); except end;
      end else RegoSearchResult.O[IntToStr(Jsonctr)].S['Value']:= readDefListItem(QLDVehiclefields[ctr]);
    end;
  finally
    strStream.Free();
  end;
end;

procedure TfmQLDTransRegoCheck.tmrQLDRegisteredVehiclecheckTimer(Sender: TObject);
begin
  inherited;
  if fdBrowserCheckTime =0 then exit;
  // if waiting for more than a min, it should exit;
  if SecondsBetween(fdBrowserCheckTime , now) > 60 then begin
    tmrQLDRegisteredVehiclecheck.Enabled:= False;
    MessageDlgXP_vista(ProgressStatus+' . . .' +NL+NL+'Unable to Connect to the QLD Transport Site / Rego not found.', mtWarning, [mbOK], 0);
    modalresult := mrcancel;
  end;
end;

end.
