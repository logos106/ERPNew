unit UnitOfMeasureforProduct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TUnitOfMeasureforProductGUI = class(TBaseListingGUI)
    qryMainUnitID: TIntegerField;
    qryMainUnitName: TWideStringField;
    qryMainMultiplier: TFloatField;
    qryMainUnitDescription: TWideStringField;
    qryMainBaseUnitName: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    fiProductId: Integer;
    { Private declarations }
  public
    Property ProductId :Integer read fiProductId write fiProductId;
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TUnitOfMeasureforProductGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiProductId := 0;
end;

procedure TUnitOfMeasureforProductGUI.RefreshQuery;
begin
  Qrymain.ParamByName('xPartID').AsInteger := ProductId;
  inherited;

end;

initialization
  RegisterClassOnce(TUnitOfMeasureforProductGUI);

end.
