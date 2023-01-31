unit TransPallets;

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
  TTransPalletsGUI = class(TBaseListingGUI)
    qryMaintransId: TLargeintField;
    qryMainProductName: TWideStringField;
    qryMainPallet: TWideStringField;
    qryMainbatchno: TWideStringField;
    qryMainQty: TFloatField;
    qryMainWeight: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
    fitransId: Integer;
    fsTranstype: String;
  public
    Procedure RefreshQuery; Override;
    Property transId :Integer read fitransId write fitransId;
    Property Transtype :String read fsTranstype write fsTranstype;
  end;


implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}

procedure TTransPalletsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fitransId:=0;
  fsTranstype:= '';
  HaveDateRangeSelection := False;
end;

procedure TTransPalletsGUI.RefreshQuery;
begin
  closedb(Qrymain);
  Qrymain.parambyname('Transtype').asString := Transtype;
  Qrymain.parambyname('transId').asInteger := transId;
  inherited;
end;
initialization
  RegisterClassOnce(TTransPalletsGUI);

end.
