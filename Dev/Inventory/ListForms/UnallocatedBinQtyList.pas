unit UnallocatedBinQtyList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TUnallocatedBinQtyListGUI = class(TBaseListingGUI)
    qryMainProductId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMaindepartmentId: TIntegerField;
    qryMainuomid: TIntegerField;
    qryMainuom: TWideStringField;
    qryMainDefaultbinId: TIntegerField;
    qryMainBatch: TWideStringField;
    qryMainmultipleBins: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUOMqty: TFloatField;
    qryMainBQty: TFloatField;
    qryMainBUOMQty: TFloatField;
    qryMainQtydiff: TFloatField;
    qryMainuomQtydiff: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TUnallocatedBinQtyListGUI)

end.
