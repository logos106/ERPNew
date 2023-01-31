unit frmProdSalesDescAttribMatrixListSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, AppEvnts, ExtCtrls,
  DNMSpeedButton, StdCtrls, Shader, DNMPanel;

type
  TfmProdSalesDescAttribMatrixListSelect = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlBottom: TDNMPanel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lbSource: TListBox;
    lbSelected: TListBox;
    edtAxis: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure lbSourceDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbSelectedDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure edtAxisDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbSelectedDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbSourceDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure edtAxisDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
//    ProdDescAttrib: TProductDescriptionAttribute;
    SelectedList: string;
    XAxisItem: string;
  end;

var
  fmProdSalesDescAttribMatrixListSelect: TfmProdSalesDescAttribMatrixListSelect;

implementation

{$R *.dfm}

uses
  CommonLib;


procedure TfmProdSalesDescAttribMatrixListSelect.FormShow(Sender: TObject);
var
  x: integer;
begin
  inherited;
  if edtAxis.Text <> '' then
    lbSource.Items.Delete(lbSource.Items.IndexOf(edtAxis.Text));
  for x:= 0 to lbSelected.Items.Count -1 do
    lbSource.Items.Delete(lbSource.Items.IndexOf(lbSelected.Items[x]));
end;

procedure TfmProdSalesDescAttribMatrixListSelect.lbSourceDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept:= (source = lbSelected) or (source = edtAxis);
end;

procedure TfmProdSalesDescAttribMatrixListSelect.lbSelectedDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept:= (source = lbSource) or (source = edtAxis);
end;

procedure TfmProdSalesDescAttribMatrixListSelect.edtAxisDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept:= (edtAxis.Text = '') and
    ((source = lbSource) or (source = lbSelected));
end;

procedure TfmProdSalesDescAttribMatrixListSelect.lbSelectedDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
  inherited;
  if (Source = lbSource) and (lbSource.ItemIndex > -1) then begin
    lbSelected.Items.Add(lbSource.Items[lbSource.ItemIndex]);
    lbSource.Items.Delete(lbSource.ItemIndex);
  end
  else if (Source = edtAxis) and (edtAxis.Text <> '') then begin
    lbSelected.Items.Add(edtAxis.Text);
    edtAxis.Text:= '';
  end
end;

procedure TfmProdSalesDescAttribMatrixListSelect.lbSourceDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
  inherited;
  if (Source = lbSelected) and (lbSelected.ItemIndex > -1) then begin
    lbSource.Items.Add(lbSelected.Items[lbSelected.ItemIndex]);
    lbSelected.Items.Delete(lbSelected.ItemIndex);
  end
  else if (Source = edtAxis) and (edtAxis.Text <> '') then begin
    lbSource.Items.Add(edtAxis.Text);
    edtAxis.Text:= '';
  end;
end;

procedure TfmProdSalesDescAttribMatrixListSelect.edtAxisDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
  inherited;
  if (source is TListBox) and (TListBox(Source).ItemIndex > -1) then begin
    edtAxis.Text:= TListBox(Source).Items[TListBox(Source).ItemIndex];
    TListBox(Source).Items.Delete(TListBox(Source).ItemIndex);
  end;
end;

procedure TfmProdSalesDescAttribMatrixListSelect.btnOkClick(
  Sender: TObject);
begin
  inherited;
  if edtAxis.Text = '' then
    CommonLib.MessageDlgXP_Vista('Please select an Item to use for the X Axis',mtInformation,[mbOk],0)
  else
    ModalResult:= mrOk;
end;

end.
