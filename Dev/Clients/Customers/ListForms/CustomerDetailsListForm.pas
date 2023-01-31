unit CustomerDetailsListForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TCustomerDetailsListGUI = class(TBaseListingGUI)
    qryMainCompany: TWideStringField;
    qryMainDiscount: TFloatField;
    qryMainSpecialDiscount: TFloatField;
    qryMainClientID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainOrigPrice: TFloatField;
    qryMainLinePrice: TFloatField;
    qryMainCol1: TWideStringField;
    qryMainCol2: TWideStringField;
    qryMainCol3: TWideStringField;
    qryMainDetails: TLargeIntField;
    qryMainCompanyName: TWideStringField;
    qryMainRep: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainDiscountType: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;

//var
//  CustomerDetailsListGUI: TCustomerDetailsListGUI;

implementation
{$R *.dfm}

uses
   AppEnvironment, CommonLib, FastFuncs;

procedure TCustomerDetailsListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin {Summary}
        GroupFilterString := 'Details = 1';
      end;
    1: 
      begin {Details}
      end;
  end;
  inherited;
end;

procedure TCustomerDetailsListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if grpfilters.Itemindex=0 then exit;
  if not Empty(qryMain.FieldByName('Company').AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TCustomerDetailsListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if fbFormOpenedOk then begin
    grpFiltersClick(Sender);
  end;
end;

procedure TCustomerDetailsListGUI.RefreshQuery;
begin
  inherited;
end;

procedure TCustomerDetailsListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  CustomerDetailsListGUI := nil;
end;

procedure TCustomerDetailsListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Cust');
  RemoveFieldfromGrid('ClientID');
  RemoveFieldfromGrid('Details');
end;

initialization
  RegisterClassOnce(TCustomerDetailsListGUI);
end.
