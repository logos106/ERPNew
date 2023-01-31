unit PurchaseOrderAudit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmpurchaseorderPrn, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, StdCtrls,
  wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox;

type
  TPurchaseOrderAuditGUI = class(TPurchaseOrderPrnGUI)
    qryMainPrintedFrom: TWideStringField;
    qryMainPrintedBy: TWideStringField;
    qryMainemailcount: TFloatField;
    qryMainPreviewcount: TFloatField;
    qryMaintotalcount: TLargeintField;
    qryMainprintcount: TFloatField;
    qryMainPrintdate: TDateTimeField;
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;

implementation

uses CommonLib, tcConst;

{$R *.dfm}

{ TPurchaseOrderAuditGUI }

procedure TPurchaseOrderAuditGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Emailed');
  RemoveFieldfromGrid('Printed');
  RemoveFieldfromGrid(QrymainFTPPassword.fieldname);
  RemoveFieldfromGrid(QrymainFTPAddress.fieldname);
  RemoveFieldfromGrid(QrymainFTPUserName.fieldname);
  RemoveFieldfromGrid(QrymainIsBO.fieldname);
end;

initialization
  RegisterClassOnce(TPurchaseOrderAuditGUI);

end.

