unit BackOrderSOExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpress, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBackOrderSOExpressGUI = class(TBaseListExpressGUI)
    qryMainSaleID: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainSalesOrderNumber: TWideStringField;
    qryMainBackOrder: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainLinePrice: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainTotalLinePrice: TFloatField;
    qryMainTotalLinePriceInc: TFloatField;
    qryMainRep: TWideStringField;
    qryMainclass: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainfutureSo: TWideStringField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainUnitofMeasureSaleLines: TWideStringField;
    btnSalesOrderList: TDNMSpeedButton;
    qryMainPrintName: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure btnSalesOrderListClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    Function ExpressDetailListName:String;Override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, dateutils, CommonFormLib;

{$R *.dfm}
{ TBackOrderSOExpressGUI }

procedure TBackOrderSOExpressGUI.btnSalesOrderListClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  inherited;
  if not FormStillOpen('TSalesorderListExpressGUI') then begin
    tmpComponent := GetComponentByClassName('TSalesorderListExpressGUI');
    If not Assigned(tmpComponent) then Exit;
    with TForm(tmpComponent) do begin
      FormStyle := fsmdiChild;
      BringToFront;
    end;
  end else begin
    with TForm(FindExistingComponent('TSalesorderListExpressGUI')) do begin
      Show;
      BringToFront;
    end;
  end;
  Self.Close;
end;

procedure TBackOrderSOExpressGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TSalesOrderGUI' , 0);
end;

function TBackOrderSOExpressGUI.ExpressDetailListName: String;
begin
  REsult := 'TBackOrderSOGUI';
end;

procedure TBackOrderSOExpressGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'Converted <> ' + QuotedStr('T');
      end;
    1:
      begin
        GroupFilterString := 'FutureSO = ' + QuotedStr('T');
      end;
    2:
      begin
        GroupFilterString := 'Converted = ' + QuotedStr('T');
      end;
  end;
  inherited;

end;

procedure TBackOrderSOExpressGUI.RefreshQuery;
var
  ToDate, FromDate: TDateTime;
begin
  if chkIgnoreDates.Checked then begin
    ToDate   := IncYear(Now(), 1000);
    FromDate := 0;
  end else begin
    ToDate   := FilterdateTo;
    FromDate := FilterDateFrom;
  end;
  qryMain.Params.ParamByName('txtfrom').AsDate :=  FromDate;
  qryMain.Params.ParamByName('txtto').AsDate :=  ToDate;
  inherited;
end;

initialization
  RegisterClassOnce(TBackOrderSOExpressGUI);

end.

