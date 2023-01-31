unit ProdattribPartsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TProdattribPartsListGUI = class(TBaseListingGUI)
    qryMainGroupName: TWideStringField;
    qryMainPartsId: TIntegerField;
    qryMainPartName: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    fiGroupID: Integer;
    { Private declarations }
  public
    Property groupID:Integer read fiGroupID write fiGroupID;
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TProdattribPartsListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiGroupID:= 0;
end;

procedure TProdattribPartsListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('GroupID').asInteger :=GroupID;
  inherited;
end;

initialization
  RegisterClassOnce(TProdattribPartsListGUI);

end.

