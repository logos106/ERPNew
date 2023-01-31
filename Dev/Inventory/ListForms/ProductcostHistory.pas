unit ProductcostHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, Mask, wwdbedit;

type
  TProductcostHistoryGUI = class(TBaseListingGUI)
    qryMainPQAID: TIntegerField;
    qryMainTransID: TLargeintField;
    qryMainTransLineID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainTransDate: TDateTimeField;
    qryMainAlloctype: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUOMQty: TFloatField;
    qryMainStockQty: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMainUOMID: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainLinecost: TFloatField;
    qryMainlinecostinc: TFloatField;
    qryMainActuallinecost: TFloatField;
    qryMainActualLinecostinc: TFloatField;
    qryMaintotalcost: TFloatField;
    qryMaintotalcostinc: TFloatField;
    qryMainActualtotalcost: TFloatField;
    qryMainActualtotalcostinc: TFloatField;
    qryMainRunningQty: TFloatField;
    qryMainclassname: TWideStringField;
    qryMainUOMdesc: TWideStringField;
    cboPartsQry: TERPQuery;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    cboPart: TwwDBLookupCombo;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure cboPartCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
  private
    fiProductID: Integer;
    Procedure MakeQrymain;
    procedure SetProductID(const Value: Integer);
  public
    Property ProductID :Integer read fiProductID write SetProductID;
    Procedure RefreshQuery; Override;
  end;

implementation

uses CommonLib, math, AppEnvironment;

{$R *.dfm}


procedure TProductcostHistoryGUI.cboPartCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  ProductId := cboPartsQry.fieldbyname('PartsID').asInteger;
  RefreshQuery;
end;

procedure TProductcostHistoryGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  cboPartsQry.Connection := qryMain.Connection;
  cboPartsQry.Open;
  cboPartsQry.first;
  fiProductID := 0;
end;

procedure TProductcostHistoryGUI.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
Procedure HighLightIfDifferent(field1, field2:TFloatField);
begin
    if not(samevalue(field1.asfloat    , field2.asfloat)) then
      if Sametext(field.fieldname , Field1.fieldname   ) or Sametext(field.fieldname , field2.fieldname   ) then
        Afont.color := clred;
end;
begin
  inherited;
  HighLightIfDifferent(qrymaintotalcost   ,qrymainactualtotalcost   );
  HighLightIfDifferent(qrymaintotalcostinc,qrymainactualtotalcostinc);
  HighLightIfDifferent(qrymainLinecost    ,qrymainactualLinecost    );
  HighLightIfDifferent(qrymainLinecostinc ,qrymainactualLinecostinc );
  if Sametext(field.fieldname , qryMainLinecost.fieldname         ) or Sametext(field.fieldname , qryMainlinecostinc.fieldname        ) then ABrush.color := $00AEFFFF;
  if Sametext(field.fieldname , qryMainActuallinecost.fieldname   ) or Sametext(field.fieldname , qryMainActualLinecostinc.fieldname  ) then ABrush.color := $00B9FFB9;
  if Sametext(field.fieldname , qryMaintotalcost.fieldname        ) or Sametext(field.fieldname , qryMaintotalcostinc.fieldname       ) then ABrush.color := $00FFFFC4;
  if Sametext(field.fieldname , qryMainActualtotalcost.fieldname  ) or Sametext(field.fieldname , qryMainActualtotalcostinc.fieldname ) then ABrush.color := $00E6CCFF;
end;

procedure TProductcostHistoryGUI.MakeQrymain;
begin
  Qrymain.SQL.Clear;
  Qrymain.SQL.Add('Select');
  Qrymain.SQL.Add('pqa.PQAID	        as	PQAID	,');
  Qrymain.SQL.Add('pqa.TransID	      as	TransID	,');
  Qrymain.SQL.Add('pqa.TransLineID	  as	TransLineID	,');
  Qrymain.SQL.Add('pqa.TransType	    as	TransType	,');
  Qrymain.SQL.Add('pqa.TransDate	    as	TransDate	,');
  Qrymain.SQL.Add('pqa.Alloctype	    as	Alloctype	,');
  Qrymain.SQL.Add('pqa.Qty	          as	Qty	,');
  Qrymain.SQL.Add('pqa.UOMQty	        as	UOMQty	,');
  Qrymain.SQL.Add('pqa.StockQty	      as	StockQty	,');
  Qrymain.SQL.Add('pqa.UOM	          as	UOM	,');
  Qrymain.SQL.Add('pqa.UOMMultiplier	as	UOMMultiplier	,');
  Qrymain.SQL.Add('concat(pqa.UOM, " (" , pqa.UOMMultiplier, ")") as UOMdesc,');
  Qrymain.SQL.Add('pqa.UOMID	        as	UOMID	,');
  Qrymain.SQL.Add('pqa.DepartmentID	  as	DepartmentID	,');
  Qrymain.SQL.Add('pqa.ProductID	    as	ProductID	,');
  Qrymain.SQL.Add('pqa.ProductName	  as	ProductName	,');
  Qrymain.SQL.Add('pqa.Active	        as	Active	,');
  Qrymain.SQL.Add('pqa.Linecost	      as	Linecost	,');
  Qrymain.SQL.Add('pqa.linecostinc	  as	linecostinc	,');
  Qrymain.SQL.Add('pqa.totalcost	    as	totalcost	,');
  Qrymain.SQL.Add('pqa.totalcostinc	  as	totalcostinc	,');
  Qrymain.SQL.Add('pqa.Actualtotalcost	            as	Actualtotalcost	,');
  Qrymain.SQL.Add('pqa.Actualtotalcostinc	          as	Actualtotalcostinc	,');
  Qrymain.SQL.Add('(pqa.Actualtotalcost/pqa.Qty)	  as	Actuallinecost	,');
  Qrymain.SQL.Add('(pqa.Actualtotalcostinc/pqa.Qty) as	ActualLinecostinc	,');
  Qrymain.SQL.Add('pqa.RunningQty	    as	RunningQty	,');
  Qrymain.SQL.Add('C.ClassName        as classname');
  Qrymain.SQL.Add('from tbltransactionpqas pqa');
  Qrymain.SQL.Add('inner join tblclass C on pqa.DepartmentID = C.ClassID');
  Qrymain.SQL.Add('where productID = :ProductID');
  Qrymain.SQL.Add('order by ' + (*iif(Appenv.companyprefs.ProductAvgcostCalculatedForDepartment , 'Classname,' ,  '') +*)'transdate , pqaId , transId, translineId');
  (*if Appenv.companyprefs.ProductAvgcostCalculatedForDepartment then grdmain.GroupFieldName := 'classname';*)
end;

procedure TProductcostHistoryGUI.RefreshQuery;
begin
  closedb(Qrymain);
  Qrymain.parambyname('ProductID').asInteger := ProductID;
  inherited;
end;

procedure TProductcostHistoryGUI.SetProductID(const Value: Integer);
begin
  fiProductID := Value;
  if cboPartsQry.active = false then cboPartsQry.open;
  if cboPartsQry.fieldbyname('PartsID').asInteger <> value then
    cboPartsQry.Locate('PartsID' , Value , []);
  cboPart.Text :=cboPartsQry.fieldByname('PartName').asSTring;
end;

initialization
  RegisterClassOnce(TProductcostHistoryGUI);
(*'classname'#9'20'#9'Class Name'
        'TransID'#9'10'#9'ID'
        'TransType'#9'15'#9'Type'
        'TransDate'#9'12'#9'Date'
        'Alloctype'#9'1'#9'In / Out'
        'UOM'#9'15'#9'UOM'
        'UOMMultiplier'#9'15'#9'Multiplier'
        'UOMQty'#9'15'#9'Trans'#9#9'Quantity'
        'RunningQty'#9'15'#9'Running'#9#9'Quantity'
        'Linecost'#9'10'#9'Ex'#9#9'Line Cost'
        'linecostinc'#9'10'#9'Inc'#9#9'Line Cost'
        'totalcost'#9'10'#9'Ex'#9#9'Total Cost'
        'totalcostinc'#9'10'#9'Inc'#9#9'Total Cost'
        'Actualtotalcost'#9'10'#9'Ex'#9#9'Calculated Total Cost'
        'Actualtotalcostinc'#9'10'#9'Inc'#9#9'Calculated Total Cost'*)
end.
