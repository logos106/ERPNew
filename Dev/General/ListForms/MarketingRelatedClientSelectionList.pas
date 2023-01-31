unit MarketingRelatedClientSelectionList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox;

type
  TMarketingRelatedClientSelectionListGUI = class(TBaseListingGUI)
    qryMainClientID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainCustomer: TWideStringField;
    qryMainsupplier: TWideStringField;
    qryMainOthercontact: TWideStringField;
    qryMainMarketingcontact: TWideStringField;
    qryMaincategory: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
  private
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, FastFuncs;

{$R *.dfm}

procedure TMarketingRelatedClientSelectionListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + Trim(qryMain.FieldByName('Category').AsString);
  inherited;

end;

procedure TMarketingRelatedClientSelectionListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SearchMode:= smSearchEngine;
end;

procedure TMarketingRelatedClientSelectionListGUI.RefreshQuery;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TMarketingRelatedClientSelectionListGUI);

end.
