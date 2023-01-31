unit SalesorderListExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SaleslistExpress, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesorderListExpressGUI = class(TSaleslistExpressGUI)
    CmdBackorders: TDNMSpeedButton;
    btnPrintMatrix: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure CmdBackordersClick(Sender: TObject);
    procedure btnPrintMatrixClick(Sender: TObject);
  private
  Protected
    Function ExpressDetailListName:String;Override;
    Function ListType:String;Override;
    procedure SetGridColumns; Override;
    function GetReportTypeID: integer; Override;
    Function LoadReportTypesconditions:String;Override;
  public
  end;

implementation

uses CommonLib, CommonFormLib, BackOrderSOExpress , MatrixObj;

{$R *.dfm}

{ TSalesorderListExpressGUI }
function TSalesorderListExpressGUI.GetReportTypeID: integer;
begin
  Result := 25;
end;
function TSalesorderListExpressGUI.LoadReportTypesconditions: String;
begin
  REsult := ' and (TemplName like ' + Quotedstr('%(Matrix-Y)%') +'  or TemplName like ' + Quotedstr('%(Matrix-X)%')+')';
end;
procedure TSalesorderListExpressGUI.btnPrintMatrixClick(Sender: TObject);
var
  strSQL:String;
  fsReport:String;
begin
  inherited;
  ChkChooseRpt.Checked := True;
  try
    fsReport:= ReportName;
    if fsReport = '' then exit;
    if  (Stringcontains(fsReport,'(Matrix-Y)')) or (Stringcontains(fsReport,'(Matrix-X)'))  then begin
      with TMatrixsale.Create(Self) do try
        SaleID := QrymainSaleID.asInteger;
        MakeMatrixTable(Stringcontains(fsReport,'(Matrix-Y)'));
        strSQL :=  SalesMatrixReportSQL(False, Stringcontains(fsReport,'(BOM)'));
        ReportSQLSupplied := True;
        PrintTemplateReport(fsReport, strSQL, False, 1 , SaleaMtrixMasterDetailLink(Stringcontains(fsReport,'(BOM)')));
      finally
        ReportToPrint:= '';
        free;
      end;
    end;
  finally
    ChkChooseRpt.Checked := False;
  end;
end;

procedure TSalesorderListExpressGUI.CmdBackordersClick(Sender: TObject);
var
  BackOrderSO: TBackOrderSOExpressGUI;
begin
  DisableForm;
  try
    inherited;
    BackOrderSO := TBackOrderSOExpressGUI(GetComponentByClassName('TBackOrderSOExpressGUI'));
    if Assigned(BackOrderSO) then begin
      BackOrderSO.FormStyle := fsMDIChild;
      BackOrderSO.BringToFront;
      Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesorderListExpressGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TSalesOrderGUI' , 0);
end;

function TSalesorderListExpressGUI.ExpressDetailListName: String;
begin
  REsult := 'TSalesOrderListGUI';
end;


procedure TSalesorderListExpressGUI.grpFiltersClick(Sender: TObject);
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

function TSalesorderListExpressGUI.ListType: String;
begin
  REsult := 'SalesOrder';
end;

procedure TSalesorderListExpressGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainDone.Fieldname);
    RemoveFieldfromGrid(qryMainType.Fieldname);
    RemoveFieldfromGrid(qryMainPayment.Fieldname);
    RemoveFieldfromGrid(qryMainBalance.Fieldname);
end;

initialization
  RegisterClassOnce(TSalesorderListExpressGUI);
end.

