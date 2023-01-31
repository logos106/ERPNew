unit ProductBarcodes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TProductBarcodesGUI = class(TBaseListingGUI)
    qryMainProductBarCodeID: TIntegerField;
    qryMainPartsID: TIntegerField;
    qryMainBarCode: TWideStringField;
    qryMainIsprimaryBarcode: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainPartname: TWideStringField;
    qryMainProductActive: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
  private
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TProductBarcodesGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.itemindex = 0 then
    GroupFilterString := 'Active = ' + QuotedStr('T')+' and ProductActive = '+quotedStr('T')
  else if grpFilters.itemindex = 0 then
    GroupFilterString := 'Active = ' + QuotedStr('F')+' OR ProductActive = '+quotedStr('F')
  else GroupFilterString := '';
  inherited;
end;

initialization
    RegisterClassOnce(TProductBarcodesGUI);

end.
