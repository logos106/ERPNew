unit SalesConvertedList;

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
  TSalesConvertedListGUI = class(TBaseListingGUI)
    procedure FormCreate(Sender: TObject);
  private
    fisaleId: Integer;
    { Private declarations }
  public
    Property SaleId :Integer read fiSaleId write fisaleId;
  end;



implementation

uses CommonLib;

{$R *.dfm}

procedure TSalesConvertedListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fisaleId := 0;
end;

initialization
  RegisterClassOnce(TSalesConvertedListGUI);

end.
