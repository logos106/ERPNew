unit frmExportnuploadLanguage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton;

type
  TfmExportnuploadLanguage = class(TBaseInputGUI)
    btn1: TDNMSpeedButton;
    btn2: TDNMSpeedButton;
    btn3: TDNMSpeedButton;
    btn4: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib, CommonFormLib, ShellAPI, Clipbrd;

{$R *.dfm}
procedure TfmExportnuploadLanguage.btn1Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TLanguagesGUI');
end;

procedure TfmExportnuploadLanguage.btn2Click(Sender: TObject);
var
src:String;
begin
  inherited;
  src:=  '"\\erp-svr1\Data\ERP Packages\Language and Help Uploader\LanguageUpdateBuilder.exe"';
  ShellExecute(Handle, 'open', PChar(src), '', '', SW_SHOW);
end;

procedure TfmExportnuploadLanguage.btn3Click(Sender: TObject);
var
src:String;
begin
  inherited;
  Clipboard.asText := '/public_html/erp_updates/server/language';
  src:=  '"C:\Program Files (x86)\FileZilla FTP Client\filezilla.exe"';
  ShellExecute(Handle, 'open', PChar(src), '', '', SW_SHOW);
end;

procedure TfmExportnuploadLanguage.btn4Click(Sender: TObject);
begin
  inherited;
  Clipboard.asText := '\\erp-svr1\Data\ERP Packages\Language and Help Uploader';
end;

procedure TfmExportnuploadLanguage.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  self.Close;
end;

procedure TfmExportnuploadLanguage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

initialization
  RegisterClassOnce(TfmExportnuploadLanguage);

end.

