unit SupplierExpressList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpress, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox, CustomInputBox, DNMAction,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSupplierExpressListGUI = class(TBaseListExpressGUI)
    qryMainClientID: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainARBalance: TFloatField;
    qryMainAPBalance: TFloatField;
    qryMainBalance: TFloatField;
    qryMainFirstname: TWideStringField;
    qryMainLastname: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainForeignExchangeSellCode: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainPrintName: TWideStringField;
    qryMainEmail: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    Function ExpressDetailListName:String;Override;
    Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, CommonFormLib, EmployeeClientList;

{$R *.dfm}

{ TSupplierExpressListGUI }

procedure TSupplierExpressListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmSupplier' , 0);
end;

function TSupplierExpressListGUI.ExpressDetailListName: String;
begin
  REsult := 'TSupplierListGUI';
end;
procedure TSupplierExpressListGUI.DNMSpeedButton1Click(Sender: TObject);
var
  fiSupplierID:Integer;
begin
  inherited;
  fiSupplierID:= TEmployeeClientListGUI.ChoosenMakeSupplier;
  if fiSupplierID <> 0 then begin
    RefreshQuery;
    Qrymain.Locate('clientId' , fiSupplierID , []);
  end;
end;

procedure TSupplierExpressListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TSupplierExpressListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('ClientID');
end;

procedure TSupplierExpressListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainclientID.Fieldname);
end;

initialization
  RegisterClassOnce(TSupplierExpressListGUI);

end.

