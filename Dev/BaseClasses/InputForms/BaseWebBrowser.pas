unit BaseWebBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, OleCtrls, SHDocVw, AppEvnts, ExtCtrls, StdCtrls,
  SelectionDialog, Menus;

type
  TBaseWebBrowserGUI = class(TBaseForm)
    WebBrowser: TWebBrowser;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WebBrowserNavigateError(ASender: TObject; const pDisp: IDispatch;
      var URL, Frame, StatusCode: OleVariant; var Cancel: WordBool);
  private

    formShown:Boolean;
  Protected
    fsWebAddress: String;
    fsAltWebAddress: String;
    procedure setAltWebAddress(const Value: String); virtual;
    procedure setWebAddress(const Value: String);Virtual;
  public

    Property WebAddress :String read fsWebAddress write setWebAddress;
    Property AltWebAddress :String read fsAltWebAddress write setAltWebAddress;
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TBaseWebBrowserGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;

end;
procedure TBaseWebBrowserGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fsWebAddress := '';
  fsAltWebAddress:= '';
  formShown:=  False;
end;

procedure TBaseWebBrowserGUI.FormShow(Sender: TObject);
begin
  inherited;
  if fsWebAddress <> '' then
      WebBrowser.Navigate(fsWebAddress);
  formShown := True;
end;

procedure TBaseWebBrowserGUI.setAltWebAddress(const Value: String);
begin
  if value = webaddress then fsAltWebAddress := '' else fsAltWebAddress := Value;
end;

procedure TBaseWebBrowserGUI.setWebAddress(const Value: String);
begin
  fsWebAddress := Value;
  if fsAltWebAddress = Value then fsAltWebAddress := '';
  if formShown then
    if fsWebAddress <> '' then
        WebBrowser.Navigate(fsWebAddress);
end;

procedure TBaseWebBrowserGUI.WebBrowserNavigateError(ASender: TObject;
  const pDisp: IDispatch; var URL, Frame, StatusCode: OleVariant;
  var Cancel: WordBool);
begin
  inherited;
  if StatusCode = 404 then
    if fsAltWebAddress <> '' then
      WebAddress := fsAltWebAddress;
end;

initialization
  RegisterClassOnce(TBaseWebBrowserGUI);


end.
