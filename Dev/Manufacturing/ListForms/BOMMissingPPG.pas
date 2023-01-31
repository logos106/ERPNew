unit BOMMissingPPG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel;

type
  TBOMMissingPPGGUI = class(TBaseListingGUI)
    qryMainsaLeId: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMainCaption: TWideMemoField;
    qryMainProcprogressid: TIntegerField;
    qryMainCcaption: TWideMemoField;
    qryMainProgressdate: TDateTimeField;
    qryMainqty: TFloatField;
    qryMainBuildstatus: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TBOMMissingPPGGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TBOMMissingPPGGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainprocprogressid.fieldname);
  RemoveFieldfromGrid(qryMainBuildstatus.fieldname);
end;

initialization
  RegisterClassOnce(TBOMMissingPPGGUI);

end.
