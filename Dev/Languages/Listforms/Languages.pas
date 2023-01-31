unit Languages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TLanguagesGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainLanguage: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainctrr: TLargeintField;
    qryMainLanguagefont: TWideStringField;
    qryMainLanguagefontName: TStringField;
    qryMainLanguagefontsize: TStringField;
    qryMainLanguagefontStyle: TStringField;
    btnImportERP: TDNMSpeedButton;
    OpenDialog1: TOpenDialog;
    btnImportTranslation: TDNMSpeedButton;
    qryMainBaseURL: TWideStringField;
    procedure FormDestroy(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); Override;
    procedure grpFiltersClick(Sender: TObject);     override;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure btnImportERPClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnImportTranslationClick(Sender: TObject);
  private
    con :TERPConnection;
  Protected
    procedure SetConnectionString; override;
    Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;


implementation

uses CommonDbLib, CommonLib, BaseInputForm, FastFuncs, LanguageTranslationObj,
  ERPLib;

{$R *.dfm}

{ TBaseListingGUI2 }

procedure TLanguagesGUI.btnImportTranslationClick(Sender: TObject);
var
  filename:String;
  LT:TLanguageTranslationObj;
begin
  if OpenDialog1.Execute then
    filename:= Opendialog1.FileName
  else exit;

  LT:=TLanguageTranslationObj.create;
  try
    LT.DoimportText(fileName);
  finally
    FreeandNil(LT);
  end;
end;

procedure TLanguagesGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfmTranslation');
    if Assigned(Form) then begin //if has acess
      with TBaseInputGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;

end;

procedure TLanguagesGUI.btnImportERPClick(Sender: TObject);
var
  filename:String;
  LT:TLanguageTranslationObj;
begin
  if OpenDialog1.Execute then
    filename:= Opendialog1.FileName
  else exit;

  LT:=TLanguageTranslationObj.create;
  try
    if LT.Doimport(fileName) then begin
      {if in devmode, move the file into the done folder}
      if devmode then begin
        try
          Copyfile(PChar(filename),PChar(replaceStr(filename, ExtractFileDir(filename) , ExtractFileDir(filename) +'\done')), false);
          Deletefile(fileName);
        Except
          // kill the exception
        end;
      end;
    end;
  finally
    FreeandNil(LT);
  end;
end;

procedure TLanguagesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  btnImportERP.enabled := DevMode;
end;

procedure TLanguagesGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(con);
  inherited;
end;

procedure TLanguagesGUI.grdMainDblClick(Sender: TObject);
begin
  if SameText(QrymainLanguage.asString , 'English')  and not(CanUpdateLanguageBaseURL) then begin
    MessageDlgXP_Vista('English is the Base Language which Cannot be Edited.' , mtInformation, [mbok],0);
    exit;
  end else inherited;
end;

procedure TLanguagesGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:GroupFilterString := 'Active = '+quotedstr('T');
    1:GroupFilterString := 'Active = '+quotedstr('F');
  end;
  inherited;
end;

procedure TLanguagesGUI.qryMainCalcFields(DataSet: TDataSet);
var
  st:TStringList;
begin
  inherited;
  qrymainLanguageFontName.asString := '';
  qrymainLanguageFontSize.asString := '';
  qrymainLanguageFontStyle.asString := '';
  st:= tStringlist.create;
  try
    Split(qrymainLanguageFont.asString , ';' , st);
    if st.count>=1 then qrymainLanguageFontName.asString := st[0];
    if st.count>=2 then qrymainLanguageFontSize.asString := st[1];
    if st.count>=3 then qrymainLanguageFontStyle.asString := replacestr(replacestr(replacestr(st[2],'[' , ''),']' , ''),'fs' , '');
  finally
    freeandnil(st);
  end;
end;

procedure TLanguagesGUI.SetConnectionString;
begin
  inherited;
  con:=CommonDbLib.GetNewERPLanguageConnection(self);
  Qrymain.connection := con;
end;
procedure TLanguagesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ID');
  RemoveFieldfromGrid('Languagefont');
end;

initialization
  RegisterClassOnce(TLanguagesGUI);

end.
