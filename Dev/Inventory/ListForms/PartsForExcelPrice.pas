unit PartsForExcelPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TPartsForExcelPriceGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainPartsId: TIntegerField;
    qryMainPartname: TWideStringField;
    qryMainExcelFilename: TWideStringField;
    qryMainHasPE: TWideStringField;
    qryMainExcelPopupOption: TWideStringField;
    qryMainPricecol: TWideStringField;
    qryMainCostcol: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainExcelSellPriceOverridesOtherPrices: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
  private
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TPartsForExcelPriceGUI }

procedure TPartsForExcelPriceGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := fAlse;
end;

procedure TPartsForExcelPriceGUI.grpFiltersClick(Sender: TObject);
begin
       if grpFilters.itemindex = 0 then groupfilterString := qryMainHasPE.fieldname +'=' + quotedstr('T')
  else if grpFilters.itemindex = 1 then groupfilterString := qryMainHasPE.fieldname +'=' + quotedstr('F')
  else groupfilterString := '';
  inherited;

end;

procedure TPartsForExcelPriceGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainPartsId.fieldname);
end;

initialization
  RegisterClassOnce(TPartsForExcelPriceGUI);

end.
