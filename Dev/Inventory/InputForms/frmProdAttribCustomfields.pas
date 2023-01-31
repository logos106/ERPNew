unit frmProdAttribCustomfields;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmProdAttribBase, Menus, ExtCtrls, StdCtrls, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, wwdbdatetimepicker, Mask, wwdbedit, Wwdotdot, Wwdbcomb, DNMSpeedButton, DNMPanel, wwdblook;

type
  TfmProdAttribCustomfields = class(TfmProdAttribBase)
    Subform: TDNMPanel;
    pnlCustFields: TDNMPanel;
    Bevel1: TBevel;
    Box181: TBevel;
    Label1: TLabel;
    CUSTLBL1: TLabel;
    CUSTLBL2: TLabel;
    CUSTLBL3: TLabel;
    CUSTLBL4: TLabel;
    CUSTLBL5: TLabel;
    CUSTLBL6: TLabel;
    CUSTLBL7: TLabel;
    CUSTLBL8: TLabel;
    CUSTLBL9: TLabel;
    CUSTLBL10: TLabel;
    CUSTLBL11: TLabel;
    CUSTLBL12: TLabel;
    CUSTLBL13: TLabel;
    CUSTLBL14: TLabel;
    CUSTLBL15: TLabel;
    CUSTLBL16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CUSTLBL17: TLabel;
    CUSTLBL18: TLabel;
    cmdCustomLabelsOld: TDNMSpeedButton;
    CUSTFLD1: TwwDBComboBox;
    CUSTFLD2: TwwDBComboBox;
    CUSTFLD3: TwwDBComboBox;
    CUSTFLD4: TwwDBComboBox;
    CUSTFLD5: TwwDBComboBox;
    CUSTFLD10: TwwDBComboBox;
    CUSTFLD9: TwwDBComboBox;
    CUSTFLD8: TwwDBComboBox;
    CUSTFLD7: TwwDBComboBox;
    CUSTFLD6: TwwDBComboBox;
    CUSTFLD11: TwwDBComboBox;
    CUSTFLD12: TwwDBComboBox;
    CUSTFLD13: TwwDBComboBox;
    CUSTFLD14: TwwDBComboBox;
    CUSTFLD15: TwwDBComboBox;
    CUSTFLD16: TwwDBDateTimePicker;
    CUSTFLD17: TwwDBDateTimePicker;
    CUSTFLD18: TwwDBDateTimePicker;
    qtyTemplateProducts: TERPQuery;
    qtyTemplateProductsPartName: TWideStringField;
    qtyTemplateProductsPartsId: TIntegerField;
    Label4: TLabel;
    cboTemplateProduct: TwwDBLookupCombo;
    bntUpdateCustomFields: TDNMSpeedButton;
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure bntUpdateCustomFieldsClick(Sender: TObject);
  private
    function getTransactionconnection: TERPConnection;
  Protected
  public
    function OnTabchange:Boolean;
    procedure SetupForm;
    Property Transactionconnection :TERPConnection Read getTransactionconnection;
  end;


implementation

uses CommonLib, frmProdAttribMain, BusObjStock;

{$R *.dfm}
{ TfmProdAttribCustomfields }

procedure TfmProdAttribCustomfields.cmdCustomLabelsOldClick(Sender: TObject);
begin
  inherited;
  if self.owner is TfmProdAttribMain then
    TfmProdAttribMain(self.owner).OpenCustomFields;
end;

function TfmProdAttribCustomfields.getTransactionconnection: TERPConnection;
begin
  REsult := TfmProdAttribMain(Self.Owner).MyConnection;
end;

procedure TfmProdAttribCustomfields.bntUpdateCustomFieldsClick(Sender: TObject);
begin
  inherited;
  if cboTemplateProduct.text = '' then exit;
  With TProduct.create(Self) do try
    connection := TfmProdAttribMain(self.owner).AttributeGroups.connection;
    Load(qtyTemplateProductsPartsID.asInteger);
    if count =0 then exit;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD1:= CustFld1;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD2:= CustFld2;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD3:= CustFld3;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD4:= CustFld4;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD5:= CustFld5;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD6:= CustFld6;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD7:= CustFld7;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD8:= CustFld8;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD9:= CustFld9;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD10:= CustFld10;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD11:= CustFld11;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD12:= CustFld12;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD13:= CustFld13;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD14:= CustFld14;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTFLD15:= CustFld15;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTDATE1:= CustDate1;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTDATE2:= CustDate2;
    TfmProdAttribMain(self.owner).AttributeGroups.CUSTDATE3:= CustDate3;
    TfmProdAttribMain(self.owner).AttributeGroups.PostDB;
  finally
    free;
  end;
end;

function TfmProdAttribCustomfields.OnTabchange: Boolean;
begin
  AttributeGroups.PostDB;
  REsult := True;
end;

procedure TfmProdAttribCustomfields.SetupForm;
var
  ctr:Integer;
begin
  if qtyTemplateProducts.Active then qtyTemplateProducts.close;
  qtyTemplateProducts.Connection := Transactionconnection;
  qtyTemplateProducts.ParamByName('GroupID').asInteger := AttributeGroups.Id;
  qtyTemplateProducts.Open;

  if self.owner is TfmProdAttribMain then begin
    if assigned(TfmProdAttribMain(self.owner).ProductAttributeSetup) then begin
      for ctr:= 0 to componentcount-1 do begin
        if components[ctr] is TwwDBComboBox then begin
          if TwwDBComboBox(components[ctr]).DataSource <> TfmProdAttribMain(self.owner).ProductAttributeSetup.DSMaster then
            TwwDBComboBox(components[ctr]).DataSource := TfmProdAttribMain(self.owner).ProductAttributeSetup.DSMaster;
        end;
        if components[ctr] is TwwDBDateTimePicker then begin
          if TwwDBDateTimePicker(components[ctr]).DataSource <> TfmProdAttribMain(self.owner).ProductAttributeSetup.DSMaster then
            TwwDBDateTimePicker(components[ctr]).DataSource := TfmProdAttribMain(self.owner).ProductAttributeSetup.DSMaster;
        end;
      end;
    end;
  end;

end;

initialization
  RegisterClassOnce(TfmProdAttribCustomfields);

end.

