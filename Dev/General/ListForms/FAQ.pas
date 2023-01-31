unit FAQ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, DBCtrls, wwcheckbox;

type
  TFaqGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainDetails: TWideMemoField;
    DBMemo1: TDBMemo;
  private
  Protected
    Procedure RefreshQuery; Override;
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses Commonlib,systemlib;

{$R *.dfm}

{ TFaqGUI }

procedure TFaqGUI.RefreshQuery;
begin
  Qrymain.ParamByName('Devmode').AsString := BooleantoStr(Devmode);
  inherited;
end;

procedure TFaqGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.FieldName);
  RemoveFieldfromGrid(qryMainDetails.FieldName);
end;
initialization
  RegisterClassOnce(TFaqGUI);

end.

