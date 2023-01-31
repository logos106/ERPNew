unit ForeignExchangeRatesListFrm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 1/11/05   1.00.02 DLS  Added RegisterClass
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TForeignExchangeRatesListGUI = class(TBaseListingGUI)
    qryMainCountry: TWideStringField;
    qryMainCurrency: TWideStringField;
    qryMainCode: TWideStringField;
    qryMainBuyRate: TFloatField;
    qryMainActive: TWideStringField;
    qryMainRateLastModified: TDateField;
    qryMainSellRate: TFloatField;
    qryMainGlobalRef: TWideStringField;
    qryMainCurrencyID: TIntegerField;
    qryMainEditedFlag: TWideStringField;
    qryMainCurrencySymbol: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation
   
uses Forms, frmForeignExchangeRate, CommonLib;
{$R *.dfm}

procedure TForeignExchangeRatesListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TForeignExchangeRatesListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  Form := GetComponentByClassName('TForeignExchangeRateGUI');
  if Assigned(Form) then begin
    with TForeignExchangeRateGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TForeignExchangeRatesListGUI);
end.
