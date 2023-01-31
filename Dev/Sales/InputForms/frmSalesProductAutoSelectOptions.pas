unit frmSalesProductAutoSelectOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls, Shader, DNMSpeedButton, DNMPanel,
  frmBase, Menus, SelectionDialog;

type
  TfmSalesProductAutoSelectOptions = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel2: TDNMPanel;
    chkhide: TCheckBox;
    btnClose: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Bevel1: TDnmPanel;
    Bevel2: TDnmPanel;
    Bevel3: TDnmPanel;
    Bevel4: TDnmPanel;
    btnIgnore: TDNMSpeedButton;
    btnLastOrder: TDNMSpeedButton;
    btnOrderHistory: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIgnoreClick(Sender: TObject);
    procedure btnLastOrderClick(Sender: TObject);
    procedure btnOrderHistoryClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure chkhideClick(Sender: TObject);
  private
    AutoLoadProductOptionSelected:Integer;
  public
    Class Function  AutoLoadProductOption(AOwner:TComponent):Integer;
  end;


implementation

uses AppEnvironment;

{$R *.dfm}

{ TfmSalesProductAutoSelectOptions }

procedure TfmSalesProductAutoSelectOptions.FormCreate(Sender: TObject);
begin
  inherited;
  AutoLoadProductOptionSelected:= 0;
end;

procedure TfmSalesProductAutoSelectOptions.btnCloseClick(Sender: TObject);
begin
  inherited;
  self.close;
end;

procedure TfmSalesProductAutoSelectOptions.btnIgnoreClick       (Sender: TObject);begin  inherited;  AutoLoadProductOptionSelected:= 1; Self.close;end;
procedure TfmSalesProductAutoSelectOptions.btnLastOrderClick    (Sender: TObject);begin  inherited;  AutoLoadProductOptionSelected:= 2; Self.close;end;
procedure TfmSalesProductAutoSelectOptions.btnOrderHistoryClick (Sender: TObject);begin  inherited;  AutoLoadProductOptionSelected:= 3; Self.close;end;
procedure TfmSalesProductAutoSelectOptions.DNMSpeedButton1Click (Sender: TObject);begin  inherited;  AutoLoadProductOptionSelected:= 4; Self.close;end;
procedure TfmSalesProductAutoSelectOptions.chkhideClick(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = chkHide then begin
    Appenv.Employee.ShowSalesProductAutoSelectOptions := not(chkHide.checked);
  end;
end;

class function TfmSalesProductAutoSelectOptions.AutoLoadProductOption(AOwner:TComponent): Integer;
begin
  with TfmSalesProductAutoSelectOptions.Create(AOwner) do try
    if AOwner is Tform then Color := TForm(AOwner).Color;
    TitleShader.FromColor := Color;
    TitleShader.ToColorMirror := Color;
    showModal;
    Result:= AutoLoadProductOptionSelected;
  finally
    free;
  end;
end;

end.

