unit frmExportData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, DNMSpeedButton, wwclearbuttongroup, wwradiogroup, AdvMemo,
  Mask, wwdbedit, ProgressDialog;

type
  TfmExportData = class(TBaseInputGUI)
    edtBusObjClass: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtFileName: TEdit;
    btnExport: TDNMSpeedButton;
    memLog: TMemo;
    Label3: TLabel;
    edtId: TEdit;
    btnImport: TDNMSpeedButton;
    chkCSV: TCheckBox;
    FontDialog1: TFontDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExportClick(Sender: TObject);
    procedure edtBusObjClassChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure chkCSVClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmExportData: TfmExportData;

implementation

{$R *.dfm}

uses
  ExportDataObj, JsonObject;
//  BusObjStock, BusObjBase, CommonDbLib;

procedure TfmExportData.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmExportData.edtBusObjClassChange(Sender: TObject);
begin
  inherited;
  if chkCSV.Checked then
    edtFileName.Text:= 'c:\temp\' + edtBusObjClass.Text + '.csv'
  else
    edtFileName.Text:= 'c:\temp\' + edtBusObjClass.Text + '.txt';
end;

procedure TfmExportData.FormCreate(Sender: TObject);
begin
  inherited;
  if chkCSV.Checked then
    edtFileName.Text:= 'c:\temp\' + edtBusObjClass.Text + '.csv'
  else
    edtFileName.Text:= 'c:\temp\' + edtBusObjClass.Text + '.txt';
end;

procedure FormatJson(strings: TStrings);
var
  x: integer;
  ident: integer;
  isObj: boolean;

  function PadStr: string;
  var y: integer;
  begin
    result:= '';
    for y:= 0 to ident -1 do
      result:= result + '    ';
  end;

begin
  ident:= 0;
  for x:= 0 to strings.Count-1 do begin
    if (Pos('}',strings[x]) = 1) and (ident > 0) then
      dec(ident);
    isObj:= Pos('{',strings[x]) = 1;
    strings[x]:= PadStr + strings[x];
    if IsObj then Inc(ident);
  end;
end;

procedure TfmExportData.btnExportClick(Sender: TObject);
var
  Exporter: TDataExporter;
  sl: TStringList;
begin
  inherited;
  Exporter:= TDataExporter.Create;
  sl:= TStringList.Create;
  try
    if chkCSV.Checked then
      Exporter.DataFormat:= dfCSV
    else
      Exporter.DataFormat:= dfJSON;
    Exporter.ExportDataToFile(edtBusObjClass.Text, edtFileName.Text, StrToInt(edtId.Text));
    sl.LoadFromFile(edtFileName.Text);
    if Exporter.DataFormat = dfJSON then begin
      FormatJson(sl);
      sl.SaveToFile(edtFileName.Text);
    end;
    memLog.Lines.Assign(sl);
  finally
    Exporter.Free;
  end;
end;




procedure TfmExportData.btnImportClick(Sender: TObject);
var
  sl: TStringList;
  Exporter: TDataExporter;
  allOk: boolean;
begin
  allOk:= true;
  Exporter:= TDataExporter.Create;
  sl:= TStringList.Create;
  try
    if chkCSV.Checked then
      Exporter.DataFormat:= dfCSV
    else
      Exporter.DataFormat:= dfJSON;
    allOk:= Exporter.ImportDataFromFile(edtBusObjClass.Text,edtFileName.Text,sl);
  finally
    memLog.Lines.Assign(sl);
    if AllOk then
      memLog.Lines.Insert(0,'Finished')
    else
      memLog.Lines.Insert(0,'Error');
    sl.Free;
    Exporter.Free;
  end;
end;

procedure TfmExportData.chkCSVClick(Sender: TObject);
begin
  inherited;
  if chkCSV.Checked then
    edtFileName.Text:= 'c:\temp\' + edtBusObjClass.Text + '.csv'
  else
    edtFileName.Text:= 'c:\temp\' + edtBusObjClass.Text + '.txt';
end;

initialization
  RegisterClass(TfmExportData);

end.
