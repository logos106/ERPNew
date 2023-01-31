unit frmReportOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, Shader,
  DNMPanel, BaseInputForm;

type
  TfmReportOptions = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    chkprint: TCheckBox;
    chkpreview: TCheckBox;
    chkemail: TCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkPDF: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
  private
    fEmailbutton: TDNMSpeedButton;
    fPDFButton: TDNMSpeedButton;
    fPreviewButton: TDNMSpeedButton;
    fPrintbutton: TDNMSpeedButton;
    { Private declarations }
  public
    Property Printbutton :TDNMSpeedButton read fPrintbutton Write fPrintbutton;
    Property PreviewButton :TDNMSpeedButton read fPreviewButton Write fPreviewButton;
    Property Emailbutton :TDNMSpeedButton read fEmailbutton Write fEmailbutton;
    Property PDFButton :TDNMSpeedButton read fPDFButton Write fPDFButton;
  end;

  Function DoPrintReport(AOwner:TComponent; btn1, btn2, btn3, btn4: TDNMSpeedButton):boolean;

implementation

uses CommonLib;

{$R *.dfm}

Function DoPrintReport(AOwner:TComponent; btn1, btn2, btn3, btn4: TDNMSpeedButton):boolean;
begin
  With TfmReportOptions(getcomponentbyclassname('TfmReportOptions',False, AOwner)) do try
    if AOwner is Tform then Color := TForm(AOwner).Color;
    Printbutton   := btn1;
    PreviewButton := btn2;
    Emailbutton   := btn3;
    PDFButton     := btn4;

    chkPrint.checked   := Screen.activecontrol = btn1;
    chkPreview.checked := Screen.activecontrol = btn2;
    chkEmail.checked   := Screen.activecontrol = btn3;
    chkPDF.checked     := Screen.activecontrol = btn4;

    Showmodal;
    result:= modalresult = mrok;
  finally
    Free;
  end;
end;
procedure TfmReportOptions.cmdCloseClick(Sender: TObject);
begin
  inherited;
  modalresult:= mrcancel;
end;

procedure TfmReportOptions.cmdPrintClick(Sender: TObject);
begin
  inherited;
  if chkprint.Checked    then  fPrintbutton.click;
  if chkpreview.Checked  then  fPreviewButton.click;
  if chkemail.Checked    then  fEmailbutton.click;
  if chkPDF.Checked      then  fPDFbutton.click;
  if chkprint.Checked  or chkpreview.Checked  or chkemail.Checked    or chkPDF.Checked      then  modalresult:= mrok else modalresult:= mrCancel;
end;

procedure TfmReportOptions.FormCreate(Sender: TObject);
begin
  inherited;
    fEmailbutton:=nil;
    fPDFButton:=nil;
    fPreviewButton:=nil;
    fPrintbutton:=nil;
end;

procedure TfmReportOptions.FormShow(Sender: TObject);
begin
  inherited;
  chkprint.enabled    :=  (fPrintbutton   <> nil) and fPrintbutton.visible    and fPrintbutton.enabled;
  chkpreview.enabled  :=  (fPreviewButton <> nil) and fPreviewButton.visible  and fPreviewButton.enabled;
  chkemail.enabled    :=  (fEmailbutton   <> nil) and fEmailbutton.visible    and fEmailbutton.enabled;
  chkPDF.enabled      :=  (fPDFbutton     <> nil) and fPDFbutton.visible      and fPDFbutton.enabled;
end;
initialization
  RegisterClassOnce(TfmReportOptions);

end.

