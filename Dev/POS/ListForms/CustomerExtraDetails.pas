unit CustomerExtraDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TfrmCustomerExtraDetails = class(TBaseListingGUI)
    qryMainSaleid: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainPOnumber: TWideStringField;
    qryMainPosPostcode: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainProductName: TWideStringField;
    qryMainLinePrice: TFloatField;
    qryMainQtyShipped: TFloatField;
    qryMainCustomerType: TWideStringField;
    qryMainSource: TWideStringField;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshQuery; override;
  end;

implementation

{$R *.dfm}
uses
  CommonLib, MySQLConst;

const
(*
  csQryMain = 'select saleid, customername, totalamount, ponumber, pospostcode, saledate'#13#10 +
              'from tblsales'#13#10+
              'where ispos="T" and'#13#10 +
              '((ponumber is not null) and (poNumber <> "") or ((pospostcode is not null)) and (pospostcode <> ""))';
*)
  csQryMain = 'select S.Saleid, CustomerName, '#13#10 +
              'POnumber, PosPostcode, SaleDate,'#13#10 +
              'ProductName, Round(LinePriceInc, 2) as LinePrice, Shipped as QtyShipped,'#13#10 +
              'TypeName as CustomerType,'#13#10 +
              'MediaType as Source'#13#10 +
              'from tblsales S'#13#10 +
              'inner join tblsaleslines SL on (SL.SaleID = S.SaleID)'#13#10 +
              'inner join tblClients C on (C.ClientId = S.ClientId)'#13#10 +
              'left join tblClientType CT on (CT.ClientTypeId = C.ClientTypeId)'#13#10 +
              'left join tblSource M on (M.MedTypeId = C.MedTypeId)'#13#10 +
              'where ispos="T" and'#13#10 +
              '((ponumber is not null) and (poNumber <> "") or ((pospostcode is not null)) and (pospostcode <> ""))';
{ TfrmCustomerExtraDetails }

procedure TfrmCustomerExtraDetails.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.Caption := 'POS Customer Extra Details';
end;

procedure TfrmCustomerExtraDetails.RefreshQuery;
begin
  qryMain.SQL.Text := csQryMain;
  if not chkIgnoreDates.Checked then
  begin
    qryMain.SQL.Add(Format('AND SaleDate >= %s and SaleDate <= %s', [QuotedStr(FormatDateTime(MysqlDateFormat , dtfrom.DateTime)),
    QuotedStr(FormatDateTime(MysqlDateFormat , dtTo.DateTime))]));
  end;
  qryMain.SQL.Add('order by saleid');
  inherited;

end;

initialization
  RegisterClassOnce(TfrmCustomerExtraDetails);
end.
