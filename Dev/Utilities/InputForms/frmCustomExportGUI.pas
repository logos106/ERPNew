unit frmCustomExportGUI;
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/04/06  1.00.00 BJ   Initial version.
 10/08/06  1.00.01 BJ   Code is moved from the form to Business Object - CustomExport.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, Grids, Wwdbigrd,
  Wwdbgrid, DNMSpeedButton, ExtCtrls, DNMPanel, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts,  ComCtrls,AdvOfficeStatusBar, ImgList, StdCtrls,  Buttons,
  Shader, AdvSplitter, wwcheckbox, ProgressDialog;

type
  TfrmCustomExport = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel5: TDNMPanel;
    btnCancel: TDNMSpeedButton;
    btnExport: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    qryExportObjectList: TERPQuery;
    qryExportObjectListRecordSelected: TBooleanField;
    qryExportObjectListID: TIntegerField;
    qryExportObjectListDescription: TWideStringField;
    qryExportObjectListObjectName: TWideStringField;
    qryExportObjectListActive: TWideStringField;
    dsExportObjectList: TDataSource;
    lvExportTables: TListView;
    ImageListNew: TImageList;
    Pnlfilename: TDNMPanel;
    edtFileName: TEdit;
    btnPickfile: TDNMSpeedButton;
    lblImportDefinition: TLabel;
    SaveDialog1: TSaveDialog;
    Pnlprogressbars: TDNMPanel;
    MsgLabel: TLabel;
    ProgressBar: TProgressBar;
    RecordsProgressBar: TProgressBar;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    chkExcludeInactive: TwwCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnPickfileClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);

  private

  public
    { Public declarations }
  end;

var
  frmCustomExport: TfrmCustomExport;

implementation

uses FastFuncs,XMLDoc,  tcDataUtils,
  CommonLib, CustomExport,DNMLib,SystemLib;

{$R *.dfm}
procedure TfrmCustomExport.FormShow(Sender: TObject);
var
  LI: TListItem;
begin
  inherited;
    OpenQueries;
    lvExportTables.Clear;
    While not qryExportObjectList.Eof do begin
        LI := lvExportTables.Items.Add;
        LI.Caption := qryExportObjectListDescription.asString;
        LI.SubItems.Add(qryExportObjectListObjectName.asString);
        qryExportObjectList.Next;
    end;
    edtFileName.Text := SystemLib.ExeDir +'\XMLDoc.XML';
end;

procedure TfrmCustomExport.btnExportClick(Sender: TObject);
var
    CEObj :TCustomExport;
    Selectedclasses :String;
    I:Integer;

begin
  DisableForm;
  try
    Selectedclasses := '';
    for I := 0 to lvExportTables.Items.Count - 1 do begin
      if lvExportTables.Items[I].Checked then begin
          if Selectedclasses <> '' then Selectedclasses := Selectedclasses + ',';
          Selectedclasses := Selectedclasses + lvExportTables.Items[I].SubItems[0];
      End;
    End;
    if Selectedclasses = '' then Exit;

    Pnlfilename.Visible := False;
    Pnlprogressbars.Visible := True;
    CEObj := TCustomExport.Create;
    try
      CEObj.fileName := Trim(edtFileName.Text);
      CEObj.MsgLabel := MsgLabel;
      CEObj.Progressbar := Progressbar;
      CEObj.RecordsProgressBar := RecordsProgressBar;
      CEObj.ExportClasses := Selectedclasses;
      CEObj.ExcludeInactive :=chkExcludeInactive.checked;
      CEObj.ExportToXML;
      Pnlfilename.visible := True;
      Pnlprogressbars.Visible := False;
      CommonLib.MessageDlgXP_Vista(XMLExportResultDocName +' file contains the exported data' , mtInformation , [mbOK] , 0);
    finally
      FreeAndNil(CEObj);
      Pnlfilename.visible := True;
      Pnlprogressbars.Visible := False;
    End;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomExport.btnPickfileClick(Sender: TObject);
begin
  inherited;
  SaveDialog1.InitialDir := SystemLib.ExeDir ;
  Savedialog1.Title := 'Select a file to export';
  SaveDialog1.Filter:= 'XML Import Files (*.xml)|*.xml';
  if SaveDialog1.Execute then begin
    edtFileName.Text := SaveDialog1.FileName;
  end;
  if edtFileName.Text = '' then edtFileName.Text :=SystemLib.ExeDir +'\XMLdoc.XML';
end;
procedure TfrmCustomExport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmCustomExport.btnCancelClick(Sender: TObject);
begin
  inherited;
    Self.Close;
end;

initialization
  RegisterClassOnce(TfrmCustomExport);
end.


