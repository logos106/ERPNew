unit SalesLinesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesLinesListGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainProductName: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainLineCost: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMainLinePrice: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainTotalLineAmount: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    btnProcess: TDNMSpeedButton;
    qryMainsaleLineId: TIntegerField;
    qryMainSaleType: TWideStringField;
    qryMainStandardCost: TFloatField;
    qryMainPQAdate: TDateTimeField;
    qryMainBSDate: TDateField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure btnProcessClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure CostHints;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses tcConst, CommonLib, ProductQtyLib;

{$R *.dfm}

{ TSalesLinesListGUI }

procedure TSalesLinesListGUI.grpFiltersClick(Sender: TObject);
begin
  groupfilterString := '';
       if grpfilters.ItemIndex =0 then groupfilterString := 'Linecost <0'
  else if grpfilters.ItemIndex =1 then groupfilterString := 'Linecostinc <=0 and Linecost <>0';
  inherited;
  Costhints;
end;
procedure TSalesLinesListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if iterateProcno =0 then begin
    if grpfilters.ItemIndex =0 then
      Scriptmain.SQL.Add('update tblsaleslines set LineCost = Standardcost where saleLineId = ' + inttostr(Qrymainsalelineid.AsInteger)+';');
    if (grpfilters.ItemIndex =1) or (grpfilters.ItemIndex =0 ) then
      Scriptmain.SQL.Add('update tblsaleslines set LineCostInc = linecost * linetaxrate /100 where saleLineId = ' + inttostr(Qrymainsalelineid.AsInteger)+';');
  end;
end;

procedure TSalesLinesListGUI.btnProcessClick(Sender: TObject);
var
  saleslineID:Integer;
begin
  inherited;
  saleslineID:= Qrymainsalelineid.asInteger;
  scriptmain.SQL.Clear;
  iterateProcno := 1;
  IterateselectedRecords(True , WAITMSG);
  if Scriptmain.SQL.Count > 0 then begin
    DoShowProgressbar(scriptmain.SQL.Count, WAITMSG);
    try
      Scriptmain.Execute;
      RefreshQuery;
      Qrymain.locate(Qrymainsalelineid.FieldName , saleslineID , []);
    finally
      DoHideProgressbar;
    end;
  end;
end;

Procedure TSalesLinesListGUI.CostHints;
begin
           if grpfilters.ItemIndex =0 then begin Showcontrolhint(btnProcess , 'This Will Update all Selected Line''s Cost from Standard Cost'); btnProcess.Enabled := True;
  end else if grpfilters.ItemIndex =1 then begin Showcontrolhint(btnProcess , 'This Will Calculate Cost(Inc) from Cost(Ex)')                  ; btnProcess.Enabled := True;
  end else btnProcess.Enabled := False;
end;
procedure TSalesLinesListGUI.FormCreate(Sender: TObject);
begin
  Qrymain.SQL.Text := replacestr(qrymain.SQL.Text  , '"SaleType" as SaleType' , SaleType('S') +' as SaleType');
  inherited;
end;

procedure TSalesLinesListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
  Costhints;
end;

procedure TSalesLinesListGUI.SetGridColumns;
begin
  inherited;
   RemoveFieldfromGrid(qrymainsalelineid.FieldName);
end;

initialization
  RegisterClassOnce(TSalesLinesListGUI);
end.
