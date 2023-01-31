unit FuncRoomAllocationList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,
  wwdbdatetimepicker, ProgressDialog, CustomInputBox, wwdblook, Shader,
  kbmMemTable;

type
  TFuncRoomAllocationListGUI = class(TBaseListingGUI)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshQuery; override;
  end;

implementation

uses CommonLib,DateUtils;

{$R *.dfm}

procedure TFuncRoomAllocationListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('xFrom').asDateTime := DateUtils.StartOfTheDay(dtfrom.DateTime);
  qryMain.Params.ParamByName('xTo').asDateTime := DateUtils.EndOfTheDay(dtto.DateTime);
  inherited;
end;

initialization
  RegisterClassOnce(TFuncRoomAllocationListGUI);
end.
