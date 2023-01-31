unit ProductSpecificationList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox;

type
  TProductSpecificationListGUI = class(TBaseListingGUI)
    qryMainPartname: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainPartSpecID: TIntegerField;
    qryMainSpecDescription: TWideStringField;
    qryMainSpecValue: TWideStringField;
    qryMainIsMultiplier: TWideStringField;
    qryMainOnPrintOut: TWideStringField;
    qryMainPartsID: TIntegerField;
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}
{ TProductSpecificationListGUI }

procedure TProductSpecificationListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('PartsID');
  RemoveFieldfromGrid('PartspecId');
end;

initialization
  RegisterClassOnce(TProductSpecificationListGUI);

end.
