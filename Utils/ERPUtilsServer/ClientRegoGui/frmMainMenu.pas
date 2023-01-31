unit frmMainMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, ExtCtrls;

type
  TfmMainMenu = class(TForm)
    alMain: TActionList;
    MainMenu1: TMainMenu;
    actClose: TAction;
    File1: TMenuItem;
    Close1: TMenuItem;
    actLogin: TAction;
    Login1: TMenuItem;
    actClientList: TAction;
    Lists1: TMenuItem;
    ClientList1: TMenuItem;
    actLicenceList: TAction;
    LicenceList1: TMenuItem;
    actServerLog: TAction;
    ServerLog1: TMenuItem;
    Timer1: TTimer;
    procedure actCloseExecute(Sender: TObject);
    procedure actLoginExecute(Sender: TObject);
    procedure actClientListExecute(Sender: TObject);
    procedure actLicenceListExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actServerLogExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
//    procedure OpenForm(FormClassName: string; aOwner: TComponent = nil);
    function FormsStillOpen: boolean;
//    function FormStillOpen(aClassName: string): boolean;
    function OpenFormInst(aClassName: string): TForm;
  public
    { Public declarations }
  end;

var
  fmMainMenu: TfmMainMenu;

implementation

{$R *.dfm}

uses
  AppConfigObj, ComponentLib, frmBase, JSONObject;

function GetFileVersion(const FileName: string): string;
var
  VersionInfoSize, VersionInfoValueSize, Zero: DWord;
  VersionInfo, VersionInfoValue: Pointer;
begin
  Result := '';
  if not FileExists(FileName) then Exit;
  VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Zero);
  if VersionInfoSize = 0 then Exit;
  GetMem(VersionInfo, VersionInfoSize);
  try
    if GetFileVersionInfo(PChar(FileName), 0, VersionInfoSize, VersionInfo) and VerQueryValue(VersionInfo,
      '\', VersionInfoValue,
      VersionInfoValueSize) and (0 <> longint(VersionInfoValueSize)) then begin
      with TVSFixedFileInfo(VersionInfoValue^) do begin
        Result := IntToStr(HiWord(dwFileVersionMS));
        Result := Result + '.' + IntToStr(LoWord(dwFileVersionMS));
        Result := Result + '.' + IntToStr(HiWord(dwFileVersionLS));
        Result := Result + '.' + IntToStr(LoWord(dwFileVersionLS));
      end;
    end;
  finally
    FreeMem(VersionInfo);
  end;
end;


procedure TfmMainMenu.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMainMenu.actLoginExecute(Sender: TObject);
var
  form: TForm;
begin
  if FormsStillOpen then begin
    MessageDlg('Please close all forms before connecting to a database.',mtInformation,[mbOk],0);
    exit;
  end;
  form:= OpenFormInst('TfmLogin');
  if Assigned(form) then
    form.BringToFront
  else
    CreateComponentInst('TfmLogin');
end;

function TfmMainMenu.FormsStillOpen: boolean;
var
  x: integer;
begin
  result:= false;
  for x:= 0 to self.MDIChildCount -1 do begin
    if not MDIChildren[x].ClassNameIs('TfmLogin') then begin
      result:= true;
      exit;
    end;
  end;
end;

//function TfmMainMenu.FormStillOpen(aClassName: string): boolean;
//var
//  x: integer;
//begin
//  result:= false;
//  for x:= 0 to self.MDIChildCount -1 do begin
//    if MDIChildren[x].ClassNameIs(aClassName) then begin
//      result:= true;
//      exit;
//    end;
//  end;
//end;

//procedure TfmMainMenu.OpenForm(FormClassName: string; aOwner: TComponent = nil);
//begin
//  ComponentLib.CreateComponentInst(FormClassName, aOwner);
//end;

function TfmMainMenu.OpenFormInst(aClassName: string): TForm;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to self.MDIChildCount -1 do begin
    if MDIChildren[x].ClassNameIs(aClassName) then begin
      result:= MDIChildren[x];
      exit;
    end;
  end;
end;

procedure TfmMainMenu.Timer1Timer(Sender: TObject);
var
  x: integer;
begin
  Timer1.Enabled := false;
  for x:= 0 to AppConfig.Data.Count -1 do begin
    if AppConfig.Data.Items[x].ValueType = valObject then begin
      if AppConfig.Data.Items[x].Value.AsObject.Exists('autoreopen') and
          AppConfig.Data.Items[x].Value.AsObject.B['autoreopen'] and
          AppConfig.Data.Items[x].Value.AsObject.B['reopen'] then
        CreateComponentInst(AppConfig.Data.Items[x].Name);
    end;
  end;
end;

procedure TfmMainMenu.actClientListExecute(Sender: TObject);
begin
  CreateComponentInst('TfmClientList');
end;

procedure TfmMainMenu.actLicenceListExecute(Sender: TObject);
begin
  CreateComponentInst('TfmLicenceList');
end;

procedure TfmMainMenu.FormCreate(Sender: TObject);
begin
  inherited;
  Caption:= Caption + ' [' + GetFileVersion(Application.ExeName) + ']';

  Left:= AppConfig.Data.O[ClassName].I['left'];
  Top:= AppConfig.Data.O[ClassName].I['top'];
  if AppConfig.Data.O[ClassName].I['width'] > 0 then
    Width:= AppConfig.Data.O[ClassName].I['width'];
  if AppConfig.Data.O[ClassName].I['height'] > 0 then
    Height:= AppConfig.Data.O[ClassName].I['height'];
end;

procedure TfmMainMenu.FormDestroy(Sender: TObject);
begin
  AppConfig.Data.O[ClassName].I['left']:= Left;
  AppConfig.Data.O[ClassName].I['top']:= Top;
  AppConfig.Data.O[ClassName].I['width']:= Width;
  AppConfig.Data.O[ClassName].I['height']:= Height;
end;

procedure TfmMainMenu.actServerLogExecute(Sender: TObject);
begin
  CreateComponentInst('TfmServerLog');
end;

procedure TfmMainMenu.FormClose(Sender: TObject; var Action: TCloseAction);
var
  x: integer;
begin
  for x:= 0 to self.MDIChildCount -1 do begin
    if MDIChildren[x] is TfmBase then begin
      TfmBase(MDIChildren[x]).Close(true);
    end;
  end;
end;

procedure TfmMainMenu.FormShow(Sender: TObject);
begin
  Timer1.Enabled := true;
end;

end.
