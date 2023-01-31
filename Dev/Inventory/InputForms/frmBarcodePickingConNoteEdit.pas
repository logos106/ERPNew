unit frmBarcodePickingConNoteEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, BusObjSales, StdCtrls,
  Shader, DNMSpeedButton, DNMPanel, wwdblook, Mask, DBCtrls, wwdbedit,
  Wwdotdot, Wwdbcomb, MemDS, AdvEdit, ImgList, ProgressDialog;

type
  TfmBarcodePickingConNoteEdit = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label101: TLabel;
    Label47: TLabel;
    qryShipping: TERPQuery;
    dsShipping: TDataSource;
    edtConNote: TEdit;
    cboVia: TwwDBLookupCombo;
    edtCost: TAdvEdit;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    Sale: TSales;
  end;


function UpdateSaleConsignmentDetails(aSale: TSales): boolean;

(*var
  fmBarcodePickingConNoteEdit: TfmBarcodePickingConNoteEdit;*)

implementation

{$R *.dfm}

uses
  DNMExceptions;


function UpdateSaleConsignmentDetails(aSale: TSales): boolean;
var
  form: TfmBarcodePickingConNoteEdit;
begin
  result:= false;
  form:= TfmBarcodePickingConNoteEdit.Create(nil);
  try
    form.Sale:= aSale;

    if form.ShowModal = mrOk then begin
      aSale.Shipping:= form.qryShipping.FieldByName('ShippingMethod').AsString;
      aSale.ConNote:=  form.edtConNote.Text;
      aSale.ShippingCost:= form.edtCost.FloatValue;
      result:= true;
    end;
  finally
    form.Release;
  end;
end;



procedure TfmBarcodePickingConNoteEdit.btnSaveClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmBarcodePickingConNoteEdit.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      qryShipping.Open;

      if Assigned(Sale) then begin
        if qryShipping.Locate('ShippingMethod', Sale.Shipping, [loCaseInsensitive]) then
          cboVia.Text:= qryShipping.FieldByName('ShippingMethod').AsString;
        edtConNote.Text:= Sale.ConNote;
        edtCost.FloatValue:= Sale.ShippingCost;
      end;

    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;   
end;

end.
