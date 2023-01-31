unit StockAdjustmentAccountTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TStockAdjustmentAccountTypesGUI = class(TBaseListingGUI)
    qryMainDetails: TLargeintField;
    qryMainStockAdjustentryID: TIntegerField;
    qryMainProcessed: TWideStringField;
    qryMainaccountName: TWideStringField;
    qryMainAccountType: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TStockAdjustmentAccountTypesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TStockAdjustmentAccountTypesGUI.SetGridColumns;
begin
  inherited;
   RemoveFieldfromGrid(qrymaindetails.fieldname);
end;

end.
