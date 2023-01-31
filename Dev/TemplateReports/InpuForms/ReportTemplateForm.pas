unit ReportTemplateForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseTemplateForm, DB,  Grids, Wwdbigrd,
  Wwdbgrid, StdCtrls, Buttons, DNMSpeedButton, Mask, DBCtrls, ExtCtrls, DNMPanel, AppEvnts,
  wwdblook, SelectionDialog, ImgList, MemDS, DBAccess, MyAccess,ERPdbComponents, DataState,
  Menus, AdvMenus, Shader, ppVar, ppBands, ppStrtch, ppCTMain, ppPrnabl,
  ppClass, ppCtrls, ppCache, ppComm, ppRelatv, ppProd, ppReport, ProgressDialog,forms, wwcheckbox;

type
  TReportTemplateGUI = class(TBaseTemplateGUI)
    btnDeleted: TDNMSpeedButton;
    btnDefaultSQL: TDNMSpeedButton;
    btnValidateSQL: TDNMSpeedButton;
    btnSaveSQL: TDNMSpeedButton;
    btnLoadSQL: TDNMSpeedButton;
    procedure qryTemplatesTypeNameChange(Sender: TField);
    procedure btnDeletedClick(Sender: TObject);
    procedure mmoSQLKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnDefaultSQLClick(Sender: TObject);
    procedure btnValidateSQLClick(Sender: TObject);
    procedure btnSaveSQLClick(Sender: TObject);
    procedure btnLoadSQLClick(Sender: TObject);

  private
    Runonce: boolean;
    Procedure Readguiprefs;
    Procedure Writeguiprefs;
    procedure initReportSQLValidate(Sender: TObject);

  public
  end;

implementation

{$R *.dfm}

uses CommonLib, InactiveReportTemplates, LogLib, TemplateReportsLib,
  CommonFormLib, ReportSQLValidate, frmPrintPickingSlips, JSONObject, SystemLib ,
  ShellAPI, PrintPickingSlipsLib;

procedure TReportTemplateGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Writeguiprefs;
end;

procedure TReportTemplateGUI.FormShow(Sender: TObject);
begin
  btnDefaultSQL.Visible := devmode;
  btnValidateSQL.Visible := devmode;
  btnSaveSQL.Visible := devmode and DirectoryExists(SystemLib.ExeDir+'Templates');
  btnLoadSQL.Visible := devmode;
  inherited;
  Readguiprefs;
end;

procedure TReportTemplateGUI.mmoSQLKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
var
  i:Integer;
  s:String;
begin
  inherited;
  if (Shift = [ssCtrl]) then begin
    if chr(Key)='A' then begin
      mmoSQL.SelectAll;
    end else if CharInSet(chr(Key),['1','2','3','4','5','6','7','8','9']) then begin
      i:= strToint(chr(Key));
      s:= SubStr(mmoSQL.Lines.Text , '~|||~' , i);
      if s<> '' then begin
        mmoSQL.SelStart := pos(s , mmoSQL.lines.Text);
        mmoSQL.SelLength := length(s);
      end;
    end;
  end;
end;


procedure TReportTemplateGUI.qryTemplatesTypeNameChange(Sender: TField);
begin
  inherited;
  if Empty(qryTemplatesTemplateClass.AsString) and not Runonce then begin
    Runonce := true;
    qryTemplatesTemplateClass.AsString := qryTemplatesTemplName.AsString;
    Runonce := false;
  end;
end;

procedure TReportTemplateGUI.Readguiprefs;
var
  s:String;
begin
  if Guiprefs.active = False then Guiprefs.Active := True;
  //if devmode then begin {dene asked to locate the last template for non dev mode as well}
      if GuiPrefs.Node.Exists('TemplateName') then begin
        s := GuiPrefs.Node['TemplateName'].asString;
        if s<> '' then begin
          if qryTemplates.Active and qryTemplates.Locate('TemplName' ,s , []) then
            Setcontrolfocus(grdTemplates);
        end;
      end;

  //end;

end;

procedure TReportTemplateGUI.Writeguiprefs;
begin
  GuiPrefs.Node['TemplateName'].asString :=qryTemplates.fieldByname('TemplName').AsString;
end;

procedure TReportTemplateGUI.btnDefaultSQLClick(Sender: TObject);
var
  Json: TJsonObject;
begin
  inherited;
  clog(companyInfoSQL);
  logtext(ColumnHeadingsSQL);
  logtext(BlankColumnHeadings);
  logtext(invoicefooterSQL);
  if Sametext(qryTemplatesTypeName.AsString , 'Pick Slip') then
    logtext(PrintPickingSlipsLib.SQL4PickingSlipreport(qryTemplatesTemplName.AsString, json));

end;

procedure TReportTemplateGUI.btnDeletedClick(Sender: TObject);
var
  TemplID:Integer;
begin
  inherited;
  with TInactiveReportTemplatesGUI(GetComponentByClassName('TInactiveReportTemplatesGUI')) do try
    if showModal = mrOk then begin
      TemplID := self.qryTemplatesTemplID.asInteger;
      self.qryTemplates.Refresh;
      self.qryTemplates.Locate('TemplID' ,TemplID , []);
    end;
  finally

  end;
end;

procedure TReportTemplateGUI.btnLoadSQLClick(Sender: TObject);
var
  afilename:String;
begin
  inherited;
  afilename :=ValidFileName(qryTemplatesTemplName.asString+'.sql');
  afilename :=SystemLib.ExeDir+'Templates\'+afilename;
    with TOpenDialog.Create(Self) do try
        Title := 'Save Report to Active Record';
        filename := afilename;
        if Execute then begin
          mmoSQL.lines.clear;
          mmoSQL.lines.loadfromfile(filename);
          editdb(qryTemplates);
          qryTemplatesSQLstring.asString :=mmoSQL.lines.text;
          postdb(qryTemplates);
        end;
      finally
        Free;
      end;
end;

procedure TReportTemplateGUI.btnSaveSQLClick(Sender: TObject);
var
  afilename:String;
begin
  inherited;
  afilename :=ValidFileName(qryTemplatesTemplName.asString+'.sql');
  afilename :=SystemLib.ExeDir+'Templates\'+afilename;
  with TSaveDialog.Create(nil) do try
    Filter := 'SQL File|*.sql,*.txt';
    filename := afilename;
    if Execute then
      aFileName := FileName
    else
      exit;
  finally
    Free;
  end;

  clog(mmoSQL.lines.text, afilename);
  ShellExecute(0,'open',PChar(afilename),nil,nil,SW_NORMAL);
end;

procedure TReportTemplateGUI.btnValidateSQLClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TReportSQLValidateGUI' , initReportSQLValidate);
end;
Procedure TReportTemplateGUI.initReportSQLValidate(Sender: TObject);
begin
  if not (sender is  TReportSQLValidateGUI) then exit;
  TReportSQLValidateGUI(Sender).ReportTemplateID := qryTemplatesTemplID.AsInteger;
end;

initialization
  RegisterClassOnce(TReportTemplateGUI);
end.
