unit frmDU_ExtraSellPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base_grid, ExtCtrls, StdCtrls, wwcheckbox,
  wwdbdatetimepicker, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMPanel,
  DB, MemDS, DBAccess, MyAccess, ERPdbComponents, busobjDataupdator,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup,frmDU_base, Shader, Menus;

type
  TfmDU_ExtraSellPrice = class(TfmDU_base_grid)
    cboClientType: TwwDBLookupCombo;
    wwDBDateTo: TwwDBDateTimePicker;
    wwDBDatefrom: TwwDBDateTimePicker;
    cboUOMESP: TwwDBLookupCombo;
    optLockExtraSellPrice: TRadioGroup;
    optExtraSellPriceOverrides: TRadioGroup;
    QryUOM: TERPQuery;
    QryUOMUnitname: TWideStringField;
    qryClientTypes: TERPQuery;
    QryTerms: TERPQuery;
    cboTerms: TwwDBLookupCombo;
    procedure grdMainEnter(Sender: TObject);
    procedure grdMainRowChanged(Sender: TObject);
    procedure cboClientTypeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboUOMESPCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnDeleteClick(Sender: TObject);
  private
    fExtraSellPrice: TDataupdatorExtraSellPrice;
  Protected
    Class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; override;
    function Formhint :String;override;
  public
    Property ExtraSellPrice    : TDataupdatorExtraSellPrice read fExtraSellPrice  write fExtraSellPrice ;
  end;


implementation

uses CommonLib, BaseInputForm, ClientTypeForm, CommonDbLib, frmDataUpdator,
  tcConst;

{$R *.dfm}

{ TfmDU_ExtraSellPrice }

Class function TfmDU_ExtraSellPrice.MakeInstance(  AOwner: TComponent): TfmDU_base;
begin
  Result:= TfmDU_ExtraSellPrice.create(AOwner);
  With TfmDU_ExtraSellPrice(Result) do begin
    OpenQueries;
    if Owner is TfmDataUpdator then begin
      dsMain.DataSet := TfmDataUpdator(AOwner).qryExtraSellPrice;
    end;
  end;
end;
procedure TfmDU_ExtraSellPrice.grdMainRowChanged(Sender: TObject);
begin
  if not(assigned(ExtraSellPrice)) then exit;
    cboClientType.Enabled := not(ExtraSellPrice.AllClients);
end;

procedure TfmDU_ExtraSellPrice.btnDeleteClick(Sender: TObject);
begin
  inherited;
  fExtraSellPrice.deleted:= True;
  fExtraSellPrice.PostDb;

end;

procedure TfmDU_ExtraSellPrice.cboClientTypeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
var
  frm: TBaseInputGUI;
begin
  inherited;
  frm := nil;
  Accept := false;
  if CommonLib.MessageDlgXP_Vista('Client Type not found in list. Would you like to create this Client Type?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    try
      frm := TClientTypeGUI(GetComponentByClassName('TClientTypeGUI'));
      if Assigned(frm) then begin //if has acess
        TClientTypeGUI(frm).ClientTypeName := NewValue;
        frm.Position := poScreenCenter;
        frm.ShowModal;
      end;
    finally
      TERPQuery(cboClientType.Lookuptable).Close;
      TERPQuery(cboClientType.Lookuptable).Connection := CommonDbLib.GetSharedMyDacConnection;
      TERPQuery(cboClientType.Lookuptable).Open;
      if not Empty(TClientTypeGUI(frm).ClientTypeName) then begin
        if TERPQuery(cboClientType.Lookuptable).Locate('TypeName', TClientTypeGUI(frm).ClientTypeName, [loCaseInsensitive]) then begin
          ExtraSellPrice.ClientTypeID := TERPQuery(cboClientType.Lookuptable).fieldbyname('ClientTypeID').AsInteger;
          cboClientType.LookupValue := TERPQuery(cboClientType.Lookuptable).fieldbyname('ClientTypeID').AsString;
          Accept := true;
        end;
      end;
      if Assigned(frm) then
        FreeandNil(frm);
    end;
  end;
end;

procedure TfmDU_ExtraSellPrice.cboUOMESPCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not modified then Exit;
  inherited;
  if filltable.State = dsCalcFields then exit;
  EditDB(Filltable);
  filltable.fieldbyname('UOM').asString         := Lookuptable.fieldbyname('UnitName').asString;
  PostDB(Filltable);
  EditDB(Filltable);
end;

function TfmDU_ExtraSellPrice.Formhint: String;
begin
  REsult:= 'Varitaion Option :' + NL+
           '   Add/Update: This will create an ''Extra Sell Price'' for each product selected for the '+
            'selected ''Client type'' and ''Unit of measssure'' for the ''Date Range'' for the ''% discount'' '+
            'if doesn''t exists and will update the discount with the ''% discount'' if it already exists' +NL+
           '   Increase : will update the existing ''Extra Sell prices'' for each product selected for '+
            'the selected ''Client type'' and ''Unit of measssure'' for the ''Date Range'' by increasing the discount with the ''Variation Amount'' specified' +NL+
           '   Decrease : will update the existing ''Extra Sell prices'' for each product selected for '+
            'the selected ''Client type'' and ''Unit of measssure'' for the ''Date Range'' by decreasing the discount with the ''Variation Amount'' specified' ;
end;

procedure TfmDU_ExtraSellPrice.grdMainEnter(Sender: TObject);
begin
  inherited;
  cboClientType.Enabled := not(ExtraSellPrice.AllClients);
end;


end.

