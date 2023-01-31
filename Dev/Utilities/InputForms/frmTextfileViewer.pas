unit frmTextfileViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Shader, ExtCtrls, DNMPanel, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, StdCtrls,
  DNMSpeedButton, TextFileObj;

type
  TfmTextfileViewer = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnClose: TDNMSpeedButton;
    lstTextfile: TListBox;
    lblfilename: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lblfilenameDblClick(Sender: TObject);
  private
    fstextfileName: String;
    TF: TTextfile;
    procedure SetTextList(const Value: TStringList);
    procedure SettextfileName(const Value: String);
    procedure SetTF(const Value: TTextfile);

  public
    Property textfileName:String read fstextfileName write SettextfileName;
    Property Textlist :TStringList write SetTextList;
    Property Textfile : TTextfile read TF write SetTF;
  end;

implementation

uses CommonLib , ShellAPI;

{$R *.dfm}

procedure TfmTextfileViewer.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmTextfileViewer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmTextfileViewer.FormShow(Sender: TObject);
begin
  inherited;
  Setcontrolfocus(lstTextFile);
  lstTextfile.itemindex :=0;
end;

procedure TfmTextfileViewer.lblfilenameDblClick(Sender: TObject);
var
  fsPath :String;
begin
  inherited;
  fsPath := ExtractFilePath(fstextfileName);
  ShellExecute(Handle, 'open', PChar(fsPath), '', '', SW_SHOW);
end;

procedure TfmTextfileViewer.SettextfileName(const Value: String);
begin
  fstextfileName := Value;
  lblfilename.Caption := Value;
  lblfilename.Visible := true;
  TF:=TTextFile.Create(Value, tfmOpenRead);
  try
    while not TF.EOF do begin
       lstTextfile.Items.Add(TF.REadline);
    end;
  finally
    FreeandNil(TF);
  end;

end;

procedure TfmTextfileViewer.SetTextList(const Value: TStringList);
var
  ctr:Integer;
begin
  lstTextfile.Items.Clear;
  for ctr:= 0 to value.Count-1 do
    lstTextfile.Items.Add(Value[ctr])
end;

procedure TfmTextfileViewer.SetTF(const Value: TTextfile);
begin
    while not TF.EOF do begin
       lstTextfile.Items.Add(Value.REadline);
    end;
end;


initialization
  RegisterClassOnce(TfmTextfileViewer);

end.

