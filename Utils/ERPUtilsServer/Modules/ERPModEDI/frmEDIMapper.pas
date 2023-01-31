unit frmEDIMapper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EDIMapConfigObj, ExtCtrls, DNMPanel, StdCtrls, ComCtrls,
  DNMSpeedButton, ERPDbComponents,
  ProgressDialog;

type
  TfmEDIMapper = class(TForm)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pagesMain: TPageControl;
    tabFile: TTabSheet;
    Label3: TLabel;
    edtMapName: TEdit;
    pnlFile: TDNMPanel;
    tabMap: TTabSheet;
    pnlMap: TDNMPanel;
    pagesFiles: TPageControl;
    pagesMap: TPageControl;
    btnAdd: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure edtMapNameChange(Sender: TObject);
  private
    EDIMapConfig: TEDIMapConfig;
    IsNew: boolean;
    Connection: TERPConnection;
    procedure Load;
    procedure Save;
    function Validate: boolean;
  public
    { Public declarations }
  end;

  function DoEDIMapping(Sender: TForm; aEDIMapConfig: TEDIMapConfig): boolean;

implementation

uses
  frmEDIConfigMain, Vista_MessageDlg, fraEDIFileCSV, fraEDIMap, JsonObject,
  EDIUtils;

{$R *.dfm}

function DoEDIMapping(Sender: TForm; aEDIMapConfig: TEDIMapConfig): boolean;
var
  form: TfmEDIMapper;
begin
  result := false;
  form := TfmEDIMapper.Create(nil);
  try
    form.Color := Sender.Color;
    form.EDIMapConfig.Assign(aEDIMapConfig);
    form.EDIMapConfig.Name := aEDIMapConfig.Name;
    Form.Connection := TfmEDIConfigMain(Sender).Connection;
    if form.ShowModal = mrOk then begin
      result := true;
      aEDIMapConfig.Assign(form.EDIMapConfig);
      aEDIMapConfig.Name := form.EDIMapConfig.Name;
    end;
  finally
    form.Release;
  end;
end;

function UniqueComponentName(aComponent: TComponent): string;
var
  s: string;
  i: integer;

  function Exists(aName: string): boolean;
  var x: integer;
  begin
    result := false;
    for x := 0 to aComponent.Owner.ComponentCount -1 do begin
      if (aComponent.Owner.Components[x] <> aComponent) and (aComponent.Owner.Components[x].Name = aName) then begin
        result := true;
        break;
      end;
    end;
  end;

begin
  s:= aComponent.ClassName;
  if Assigned(aComponent.Owner) then begin
    if Exists(s) then begin
      i := 1;
      while Exists(s + IntToStr(i)) do
        Inc(i);
      s:= s + IntToStr(i);
    end;
  end;
  result := s;
end;

{ TfmEDIMapper }

procedure TfmEDIMapper.btnAddClick(Sender: TObject);
var
  s: string;
  TabSheet: TTabSheet;
  mapFrame: TfrEDIMap;
begin
  s := InputBox('Map Name', 'Short name for new map','');
  if s <> '' then begin
    EDIMapConfig.O['Mapping'].O[s];

    TabSheet := TTabSheet.Create(pagesMap);
    TabSheet.Caption := s;
    TabSheet.PageControl := pagesMap;

    mapFrame := TfrEDIMap.Create(self);
    mapFrame.Name := UniqueComponentName(mapFrame);
    mapFrame.Parent := TabSheet;
    mapFrame.MapName := s;
    mapFrame.SourceColumns := EDIMapConfig.O['InputFile'].O['Columns'];
    mapFrame.Config := EDIMapConfig.O['Mapping'].O[s];
  end;
end;

procedure TfmEDIMapper.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfmEDIMapper.btnDeleteClick(Sender: TObject);
var
  x: integer;
  Map: TfrEDIMap;
begin
  if Vista_MessageDlg.MessageDlgXP_Vista('Are you sure you want to Permantly Delete Map "' + pagesMap.ActivePage.Caption + '"',
    mtConfirmation,[mbYes, mbNo],0) = mrYes then begin
    EDIMapConfig.O['Mapping'].Delete(pagesMap.ActivePage.Caption);
    for x := 0 to pagesMap.ActivePage.ControlCount-1 do begin
      if pagesMap.ActivePage.Controls[x] is TfrEDIMap then begin
        Map := TfrEDIMap(pagesMap.ActivePage.Controls[x]);
        Map.Parent := nil;
        Map.Free;
        break;
      end;
    end;
    pagesMap.ActivePage.Free;
  end;
end;

procedure TfmEDIMapper.btnSaveClick(Sender: TObject);
begin
  Save;
  if Validate then
    ModalResult := mrOk;
end;

procedure TfmEDIMapper.edtMapNameChange(Sender: TObject);
begin
  EDIMapConfig.Name := edtMapName.Text;
end;

procedure TfmEDIMapper.FormCreate(Sender: TObject);
begin
  IsNew := false;
  EDIMapConfig := TEDIMapConfig.Create;
  pagesMain.ActivePageIndex := 0;
end;

procedure TfmEDIMapper.FormDestroy(Sender: TObject);
begin
  EDIMapConfig.Free;
end;

procedure TfmEDIMapper.FormShow(Sender: TObject);
begin
  Load;
end;

procedure TfmEDIMapper.Load;
var
  TabSheet: TTabSheet;
  fileFrame: TfrEDIFileCSV;
  mapFrame: TfrEDIMap;
  x: integer;
  pair: TJSONValuePair;
  SrcCols: TJsonObject;
  c: TCursor;
begin
  //c := Screen.Cursor;
  //Screen.Cursor := crHourGlass;
  dlg := TProgressDialog.Create(nil);
  try
    dlg.TimerUpdate := true;
    dlg.Execute;

    SrcCols := nil;
    IsNew := EDIMapConfig.Name = '';
    if EDIMapConfig.Name <> '' then begin
      edtMapName.Text := EDIMapConfig.Name;
      edtMapName.ReadOnly := true;
    end;

    if SameText(EDIMapConfig.S['Type'],'InputFromFile') then begin
      if SameText(EDIMapConfig.O['InputFile'].S['DataType'],'CSV') then begin
        TabSheet := TTabSheet.Create(pagesFiles);
        TabSheet.Caption := 'CSV Input File';
        TabSheet.PageControl := pagesFiles;

        fileFrame := TfrEDIFileCSV.Create(self);
        fileFrame.Parent := TabSheet;
        fileFrame.Config := EDIMapConfig.O['InputFile'];
        srcCols := EDIMapConfig.O['InputFile'].O['Columns'];
      end;
    end;
    for x := 0 to EDIMapConfig.O['Mapping'].Count -1 do begin
      pair := EDIMapConfig.O['Mapping'].Items[x];
      TabSheet := TTabSheet.Create(pagesMap);
      TabSheet.Caption := pair.Name;
      TabSheet.PageControl := pagesMap;

      mapFrame := TfrEDIMap.Create(self);
      mapFrame.Name := UniqueComponentName(mapFrame);
      mapFrame.Parent := TabSheet;
      mapFrame.MapName := pair.Name;
      mapFrame.SourceColumns := srcCols;
      mapFrame.Config := pair.Value.AsObject;
    end;
  finally
    //Screen.Cursor := c;
    FreeAndNil(dlg);
  end;
end;

procedure TfmEDIMapper.Save;
begin


end;

function TfmEDIMapper.Validate: boolean;
begin
  result := false;
  if edtMapName.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Mapping Name is missing',
        mtInformation,[mbOk],0);
    exit;
  end;

  if IsNew then begin
    if EDIMapConfig.NameExists(EDIMapConfig.Name,Connection) then begin
      Vista_MessageDlg.MessageDlgXP_Vista('This Map Name already exists "' + EDIMapConfig.Name + '"',
        mtInformation,[mbOk],0);
      exit;
    end;
  end;
  result := true;
end;

end.
