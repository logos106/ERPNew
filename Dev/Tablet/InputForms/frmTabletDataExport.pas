unit frmTabletDataExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel,
  TabletDataExportObj, FMTBcd, ExtDlgs, SqlExpr, ComCtrls, CheckLst;

type
  TfmTabletDataExport = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnExport: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnStop: TDNMSpeedButton;
    edtOutputFile: TEdit;
    Label1: TLabel;
    btnOutFile: TButton;
    SaveTextFileDialog: TSaveTextFileDialog;
    edtMinSaleDate: TDateTimePicker;
    chkLimitSales: TCheckBox;
    chkProductPictures: TCheckBox;
    pcMain: TPageControl;
    tabLog: TTabSheet;
    memLog: TMemo;
    tabDatabase: TTabSheet;
    Label2: TLabel;
    lbDatabase: TCheckListBox;
    procedure btnExportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnOutFileClick(Sender: TObject);
    procedure chkLimitSalesClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    DataExport: TTabletDataExport;
    procedure DoOnProgress(const msg: string; IsNewMessage: boolean);
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, SystemLib, DBUtils, DnMLib;

{$R *.dfm}

procedure TfmTabletDataExport.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmTabletDataExport.btnExportClick(Sender: TObject);
var
  s: string;
  x: integer;
begin
  inherited;
  memLog.Lines.Clear;
  if edtOutputFile.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('There is no Output File name specified',mtInformation,[mbOk],0);
    exit;
  end;
  ForceDirectories(ExtractFileDir(edtOutputFile.Text));
  if FileExists(edtOutputFile.Text) then begin
    if CommonLib.MessageDlgXP_Vista('Output File already exists, this will be deleted and re-created, is this OK?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
      exit
    else
      DeleteFile(edtOutputFile.Text);
  end;
  s := '';
  for x := 0 to lbDatabase.Items.Count -1 do begin
    if lbDatabase.Checked[x] then begin
      if s <> '' then s := s + ',';
      s := s + lbDatabase.Items[x];
    end;
  end;

  if s = '' then begin
    CommonLib.MessageDlgXP_Vista('There are no databases selected.',mtInformation,[mbOk],0);
    exit;
  end;


  DataExport := TTabletDataExport.Create;
  try
    DataExport.DbList := s;
    DataExport.OnExportProgress := DoOnProgress;
    DataExport.OutputDbName := edtOutputFile.Text;
    if chkLimitSales.Checked then
      DataExport.MinSaleDate := edtMinSaleDate.Date
    else
      DataExport.MinSaleDate := 0;
    DataExport.IncludeProductPictures := chkProductPictures.Checked;

    DataExport.ExportData;


  finally
    FreeAndNil(DataExport);
  end;
end;

procedure TfmTabletDataExport.btnOutFileClick(Sender: TObject);
begin
  inherited;
  SaveTextFileDialog.FileName := edtOutputFile.Text;
  if SaveTextFileDialog.Execute then
    edtOutputFile.Text := SaveTextFileDialog.FileName;
end;

procedure TfmTabletDataExport.btnStopClick(Sender: TObject);
begin
  inherited;
  if Assigned(DataExport) then
    DataExport.Active := false;
end;

procedure TfmTabletDataExport.chkLimitSalesClick(Sender: TObject);
begin
  inherited;
  edtMinSaleDate.Enabled := chkLimitSales.Checked;
end;

procedure TfmTabletDataExport.DoOnProgress(const msg: string;
  IsNewMessage: boolean);
begin
  if IsNewMessage then
    memLog.Lines.Add(msg)
  else begin
    if memLog.Lines.Count > 0 then
      memLog.Lines[memLog.Lines.Count-1] := msg;
  end;
  Application.ProcessMessages;
end;

procedure TfmTabletDataExport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmTabletDataExport.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := true;
  if Assigned(DataExport) and DataExport.Active then begin
    CanClose := false;
    CommonLib.MessageDlgXP_Vista('Please stop the export before closing.',mtInformation,[mbOK],0);
  end;
end;

procedure TfmTabletDataExport.FormCreate(Sender: TObject);
var
  year,month,day: word;
  x: integer;
begin
  inherited;
  pcMain.ActivePage := tabLog;
  edtOutputFile.Text := GetMyDocumentsDir + 'TrueErpTablet.db';
  DecodeDate(IncMonth(now, -3),year,month,day);
  edtMinSaleDate.Date := EncodeDate(year,month,1);

  lbDatabase.Items.CommaText := GetDatabaseList(MyConnection.Server, true);
  for x := 0 to lbDatabase.Items.Count -1 do begin
    if SameText(lbDatabase.Items[x],MyConnection.Database) then begin
      lbDatabase.Checked[x] := true;
      exit;
    end;
  end;
  RealignTabControl(pcMain,1);
end;

procedure TfmTabletDataExport.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pcMain,1);
end;

initialization
  RegisterClass(TfmTabletDataExport);

end.
