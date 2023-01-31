unit frmCustomImportGUI;
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/10/05  1.00.00 AL   Initial version.
 01/11/05  1.00.01 AL   1. Added Show Definition File Information in memoInfo
                        2. Save & Load last picked filename using TFormGuiPrefs
 23/03/06  1.00.02 DSP  Added functionality which allows direct importing of
                        data from an XML document without use of a CSV file.

}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, ExtCtrls, Buttons, DNMSpeedButton,
  XMLDoc, XMLIntf,
  DNMPanel, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB, Shader, ImgList, MemDS, ProgressDialog;

type
  TfrmCustomImport = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    lblImportDefinition: TLabel;
    Label1: TLabel;
    edtFileName: TEdit;
    btnPickfile: TDNMSpeedButton;
    bbtnImport: TDNMSpeedButton;
    bbtnCancel: TDNMSpeedButton;
    memoInfo: TMemo;
    chkImportCSVFile: TCheckBox;
    odPickXMLFile: TOpenDialog;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPickfileClick(Sender: TObject);
    procedure bbtnImportClick(Sender: TObject);
    procedure bbtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkImportCSVFileClick(Sender: TObject);
  private
    fDirectXML: Boolean;
    (*Function ImportFromXMLFile(FileName:String):boolean;*)
  public
    procedure ShowDefinitionFileInfo;
    property DirectXML: Boolean read fDirectXML write fDirectXML;
  end;


implementation

uses
  CustomImport, MemoDialog, DataTreeObj, GuiPrefsObj, DNMExceptions, CommonLib,
 DNMLib,SystemLib;
var
  Prefs: TFormGuiPrefs;

{$R *.dfm}

procedure TfrmCustomImport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  Prefs.Node.ItemByName['XMLDefFileName'].AsString := edtFileName.Text;

  if odPickXMLFile.FileName <> '' then
    Prefs.Node.ItemByName['XMLFileName'].AsString := odPickXMLFile.FileName;

  Prefs.SavePrefs;
  FreeAndNil(Prefs);

end;

procedure TfrmCustomImport.btnPickfileClick(Sender: TObject);
begin
  inherited;
  odPickXMLFile.InitialDir := SystemLib.ExeDir + 'CustomImports\';
  odPickXMLFile.Title := 'Select the Import Definition File';
  odPickXMLFile.Filter := 'XML Import Definition Files (*.xml)|*.xml';

  if odPickXMLFile.Execute then begin
    edtFileName.Text := odPickXMLFile.FileName;
    ShowDefinitionFileInfo;
  end; {if}

end;

procedure TfrmCustomImport.bbtnImportClick(Sender: TObject);
var
  CI: TCustomImport;
  slData: TStringList;
  ResponseXML: String;
  Success: boolean;
  ValidFile: boolean;
  LoadCancelled: boolean;
  xmlDoc: TXMLDocument;
begin
  DisableForm;
  try
    inherited;
    ValidFile := false;
    LoadCancelled := false;

    if DirectXML then begin
      odPickXMLFile.InitialDir := SystemLib.ExeDir + 'CustomImports\';
      odPickXMLFile.Title := 'Select the Import File';
      odPickXMLFile.Filter := 'XML Import Files (*.xml)|*.xml';

      if odPickXMLFile.Execute then
        ValidFile := FileExists(odPickXMLFile.FileName)
      else
        LoadCancelled := True;
    end;

    if ValidFile or (not DirectXML and FileExists(edtFileName.Text)) then begin
          slData := TStringList.Create;
          CI := TCustomImport.Create;
          CI.SilentMode := False;
          try
              if DirectXML then begin
                  (*slData.LoadFromFile(odPickXMLFile.FileName);
                  CI.XMLData := slData.Text;*)
                  CI.ImportFromXMLFile(odPickXMLFile.FileName, Self.MyConnection);
                  Success := True;
              end else begin
                  slData.LoadFromFile(edtFileName.Text);
                  CI.XMLDefinition := slData.Text;
                  Success := CI.Execute(ResponseXML);
             end;
            if Success then begin
              if CI.ImportMsg <> '' then begin
                  CommonLib.MessageDlgXP_Vista(CI.ImportMsg , mtInformation, [mbOK], 0);
              end else
                  CommonLib.MessageDlgXP_Vista('Import successful!', mtInformation, [mbOK], 0);
            end else begin
              xmlDoc := TXMLDocument.Create(self);
              try
                xmlDoc.Options := [doNodeAutoIndent];
                xmlDoc.LoadFromXML(ResponseXML);

                Application.CreateForm(TfrmMemoDialog, frmMemoDialog);
                try
                  frmMemoDialog.SetMemo('Custom Import Result', XMLdoc.DocumentElement.ChildNodes.FindNode('TwoClixXMLRequest').Attributes['DetailMessage']);
                except
                end;
                Try
                  frmMemoDialog.SetMemo('Custom Import Result',
                    XMLdoc.DocumentElement.ChildNodes.FindNode('TwoClixXMLResponse').Attributes['StatusMessage'] +
                    XMLdoc.DocumentElement.ChildNodes.FindNode('TwoClixXMLResponse').ChildNodes.FindNode('DetailMessage').NodeValue);
                except
                end;
                frmMemoDialog.ShowModal;
              finally
                xmldoc.free;
              end;
            end; {else}
          finally
              FreeandNil(slData);
              FreeandNil(CI);
          end;
    end else begin
      if DirectXML then begin
          if not LoadCancelled then
              CommonLib.MessageDlgXP_Vista('File ' + #13 + #10 + '"' + odPickXMLFile.FileName + '" ' + #13 + #10 + 'does not exist!', mtWarning, [mbOK], 0);
      end else
          CommonLib.MessageDlgXP_Vista('File ' + #13 + #10 + '"' + edtFileName.Text + '" ' + #13 + #10 + 'does not exist!', mtWarning, [mbOK], 0);
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomImport.bbtnCancelClick(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TfrmCustomImport.FormCreate(Sender: TObject);
begin
  inherited;
  fDirectXML := True;

  Prefs := TFormGuiPrefs.Create(self);
  Prefs.Active := true;
  Prefs.LoadPrefs;

end;

procedure TfrmCustomImport.FormShow(Sender: TObject);
begin
  try
    inherited;
    edtFileName.Text := Prefs.Node.ItemByName['XMLDefFileName'].AsString;
    odPickXMLFile.FileName := Prefs.Node.ItemByName['XMLFileName'].AsString;

    if (not DirectXML) and FileExists(edtFileName.Text) then begin
      ShowDefinitionFileInfo;
    end;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;
procedure TfrmCustomImport.ShowDefinitionFileInfo;
var
  xmlDoc: TXMLDocument;
begin
  xmlDoc := TXMLDocument.Create(self);
  try
    try
      xmlDoc.LoadFromFile(edtFileName.Text);
      memoInfo.Clear;
      memoInfo.Lines.Add('Description      : ' + xmlDoc.DocumentElement.ChildNodes.FindNode('Description').NodeValue);
      memoInfo.Lines.Add('Source file type : ' + xmlDoc.DocumentElement.ChildNodes.FindNode('Source').ChildNodes.FindNode
      ('SourceType').NodeValue);
      memoInfo.Lines.Add('Import to        : ' + xmlDoc.DocumentElement.ChildNodes.FindNode
      ('Destination').ChildNodes.FindNode('BusinessObject').NodeValue);
      memoInfo.Lines.Add('Action on Error  : ' + xmlDoc.DocumentElement.ChildNodes.FindNode('Options').ChildNodes.FindNode
      ('OnError').NodeValue);
    except
      CommonLib.MessageDlgXP_Vista('Import Definition File has improper format!', mtWarning, [mbOK], 0);
      edtFileName.Text := '';
    end;
  finally
    xmlDoc.free;
  end;
end;

procedure TfrmCustomImport.chkImportCSVFileClick(Sender: TObject);
begin
  inherited;
  fDirectXML := not chkImportCSVFile.Checked;
  lblImportDefinition.Enabled := chkImportCSVFile.Checked;
  edtFileName.Enabled := chkImportCSVFile.Checked;
  btnPickfile.Enabled := chkImportCSVFile.Checked;
end;

initialization

  RegisterClassOnce(TfrmCustomImport);
end.



