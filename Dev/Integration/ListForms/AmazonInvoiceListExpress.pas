unit AmazonInvoiceListExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InvoicelistExpress, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TAmazonInvoiceListExpressGUI = class(TInvoicelistExpressGUI)
    qryMainSynchedtoAmazon: TWideStringField;
  private
  Protected
    function ExtraTables: String;Override;
    function ExtraFields: String;Override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TAmazonInvoiceListExpressGUI }

function TAmazonInvoiceListExpressGUI.ExtraFields: String;
var
  st:TStringlist;
begin
  Result := inherited ExtraFields;
  st:= tStringlist.create;
  try
    st.Add('if(ifnull(SHP.ID,0)<>0,"T","F") as  SynchedtoAmazon,');
    Result := result + st.Text
  finally
    Freeandnil(st);
  end;

end;

function TAmazonInvoiceListExpressGUI.ExtraTables: String;
begin
  Result := ' inner join tblsales SO on SO.Globalref = S.SAlesOrderGlobalref '+
            ' inner join tblediorder EDI on SO.saleId = EDI.ERPSalesOrderId and EDI.EDIParty = "Amazon"'+
            ' Left join tbledishipment SHP on S.saleId = SHP.ERPSaleId';

end;

initialization
  RegisterClass(TAmazonInvoiceListExpressGUI);

end.
