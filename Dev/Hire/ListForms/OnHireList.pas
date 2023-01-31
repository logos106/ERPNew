unit OnHireList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TOnHireListGUI = class(TBaseListingGUI)
    qryMainhireId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainshipToAddress: TWideStringField;
    qryMainBillcustomerName: TWideStringField;
    qryMainBillToAddress: TWideStringField;
    qryMainClassname: TWideStringField;
    qryMainnotes: TWideMemoField;
    qryMainTerms: TWideStringField;
    qryMainemployeeName: TWideStringField;
    qryMainEquipmentName: TWideStringField;
    qryMainhirefrom: TDateTimeField;
    qryMainHireTo: TDateTimeField;
    qryMainLineAmountInc: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainHireQty: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainconverted: TWideStringField;
  private
  Protected
    procedure SetupFormInPanel; Override;
  public
    Procedure RefreshQuery; Override;
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TOnHireListGUI }


procedure TOnHireListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;
procedure TOnHireListGUI.SetupFormInPanel;
begin
  inherited;
  pnlHeader.visible := True;
  pnlHeader.Parent.Height := 80;
  pnlHeader.Height := pnlHeader.Parent.Height - pnlbuttons.Height -4;
  pnlHeader.Top :=2;
  pnlHeader.Left := trunc((HEaderpanel.width -pnlHeader.width)/2);
  Panel3.visible := False;
  Self.Invalidate;
end;

initialization
  RegisterClassOnce(TOnHireListGUI);

end.
