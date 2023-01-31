unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JsonConfigObj, StdCtrls, ExtCtrls, ConTnrs, DtdObj;

type
  TfmMain = class(TForm)
    Panel1: TPanel;
    memLog: TMemo;
    edtDTD: TEdit;
    edtXML: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnDTD: TButton;
    btnXML: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    btnConvert: TButton;
    chkQuantifier: TCheckBox;
    chkRequired: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtDTDChange(Sender: TObject);
    procedure edtXMLChange(Sender: TObject);
    procedure btnDTDClick(Sender: TObject);
    procedure btnXMLClick(Sender: TObject);
    procedure btnConvertClick(Sender: TObject);
  private
    Config: TJsonConfig;
    dtd: TDTD;
  public
    { Public declarations }
  end;


var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.btnConvertClick(Sender: TObject);
begin
  dtd.LoadFromFile(Config.S['DTDFileName']);
  dtd.SaveAsXML(edtXML.Text,chkQuantifier.Checked, chkRequired.Checked);
  ShowMessage('Done');
end;

procedure TfmMain.btnDTDClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    edtDTD.Text := OpenDialog.FileName;
end;

procedure TfmMain.btnXMLClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    edtXML.Text := SaveDialog.FileName;
end;

procedure TfmMain.edtDTDChange(Sender: TObject);
begin
  Config.S['DTDFileName'] := edtDTD.Text;
  Config.Save;
end;

procedure TfmMain.edtXMLChange(Sender: TObject);
begin
  Config.S['XMLFileName'] := edtXML.Text;
  Config.Save;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Config := TJsonConfig.Create;
  Config.Load;
  edtDTD.Text := Config.S['DTDFileName'];
  edtXML.Text := Config.S['XMLFileName'];
  dtd := TDTD.Create;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Config.Free;
  dtd.Free;
end;

end.
