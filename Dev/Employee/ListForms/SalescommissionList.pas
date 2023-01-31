unit SalescommissionList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup;

type
  TSalescommissionListGUI = class(TBaseListingGUI)
    grdPaidfilters: TRadioGroup;
    qryMainCalccommissionOn: TWideStringField;
    qryMainDetails: TLargeintField;
    qryMainSaleID: TIntegerField;
    qryMainIsCommissiononpaidInvoice: TWideStringField;
    qryMainCommissioninvoiceexprice: TWideStringField;
    qryMainCommissionOn: TWideStringField;
    qryMainOverheadbaserate: TFloatField;
    qryMainname: TWideStringField;
    qryMainCategory: TWideStringField;
    qryMainCommissionRate: TFloatField;
    qryMainIsCommissionPercent: TWideStringField;
    qryMainCommissionamt: TFloatField;
    qryMainAmountPaid: TFloatField;
    qryMainSalesCommissionId: TLargeintField;
    qryMainProductID: TLargeintField;
    qryMainBalanceAmount: TFloatField;
    qryMainClassId: TIntegerField;
    qryMainclass: TWideStringField;
    qryMainemployeeName: TWideStringField;
    qryMainEmployeeId: TIntegerField;
    qryMainTransType: TWideStringField;
    btnUpdateBatch: TDNMSpeedButton;
    qryMainGrossProfit: TFloatField;
    qryMainGrossProfitPercent: TFloatField;
    btnShowRelatedCustomersList: TDNMSpeedButton;
    btndelete: TDNMSpeedButton;
    qryMainTotalCost: TFloatField;
    qryMaintotalPrice: TFloatField;
    btnSelectAll: TDNMSpeedButton;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure btnUpdateBatchClick(Sender: TObject);
    procedure btnShowRelatedCustomersListClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
  private
    fSelectcommissions: TNotifyEvent;
    fTransconnection: TERPConnection;
    fsTablename :String;
    Procedure CreateTemptable;
    Procedure onBeforeExecute(Sender: TObject; var SQL: String;var Omit: Boolean);
    Procedure AfterSalescommissionShow(Sender:TObject);
  Protected
    Procedure SetGridColumns;override;
    procedure RefreshTotals; override;
    Procedure CalcFooter; override;
    function FormCaptionSuffix: string; override;
  public
    Procedure RefreshQuery; override;
    Class Procedure Listforemployee(const EmployeeId:Integer; const ClassId :Integer;AOwner:Tcomponent; fSelectcommissions :TNotifyEvent; Transconnection :TERPConnection);
    Property Selectcommissions :TNotifyEvent read fSelectcommissions write fSelectcommissions;
    Property Transconnection :TERPConnection Read fTransconnection write fTransconnection;
  end;


implementation

uses CommonFormLib,commonLib, FastFuncs, AppEnvironment, tcDataUtils, GlobalEventsObj,
  frmSalesCommission, CommonDbLib, SalesgrossProfit,
  SalesListwithCommision, CalcSalescommission, BusObjBase, tcConst, DbSharedObjectsObj;


{$R *.dfm}

{ TSalescommissionListGUI }

procedure TSalescommissionListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Details');
  RemoveFieldfromGrid('commissionOn');
  RemoveFieldfromGrid('ProductId');
  RemoveFieldfromGrid('EmployeeID');
  RemoveFieldfromGrid('SalescommissionId');
end;

function TSalescommissionListGUI.FormCaptionSuffix: string;
var
  qry: TERPQuery;
begin
  result := inherited;
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select Max(SaleDate) as MaxSaleDate from tblsalescommission';
    qry.Open;
    if qry.FieldByName('MaxSaleDate').AsDateTime > 0 then
      result := result + ' [Last Commission Sale Date ' + FormatDateTime(FormatSettings.ShortDateFormat,qry.FieldByName('MaxSaleDate').AsDateTime) + ']';
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TSalescommissionListGUI.FormCreate(Sender: TObject);
begin
  //NoDateRange := true;
  fSelectcommissions := nil;
  fTransconnection := nil;
  fsTablename := GetUserTemporaryTableName('CommissionList');
    qryMain.SQL.clear;
    qryMain.SQL.Add('SELECT');
    qryMain.SQL.Add('TransType as TransType,');
    qryMain.SQL.Add('Details as Details,');
    qryMain.SQL.Add('SalesCommissionId as SalesCommissionId,');
    qryMain.SQL.Add('SaleID as SaleID,');
    qryMain.SQL.Add('CustomerName as CustomerName,');
    qryMain.SQL.Add('EmployeeId as EmployeeId,');
    qryMain.SQL.Add('ProductID as ProductID,');
    qryMain.SQL.Add('ClassId as ClassId,');
    qryMain.SQL.Add('Class as Class,');
    qryMain.SQL.Add('IsCommissiononpaidInvoice as IsCommissiononpaidInvoice,');
    qryMain.SQL.Add('Commissioninvoiceexprice as Commissioninvoiceexprice,');
    qryMain.SQL.Add('CommissionOn as CommissionOn,');
    qryMain.SQL.Add('Overheadbaserate as Overheadbaserate,');
    qryMain.SQL.Add('EmployeeName as EmployeeName,');
    qryMain.SQL.Add('name as name,');
    qryMain.SQL.Add('Category as Category,');
    qryMain.SQL.Add('CommissionRate as CommissionRate,');
    qryMain.SQL.Add('IsCommissionPercent as IsCommissionPercent,');
    qryMain.SQL.Add('Commissionamt as Commissionamt,');
    qryMain.SQL.Add('AmountPaid as AmountPaid,');
    qryMain.SQL.Add('totalCost as totalCost,');
    qryMain.SQL.Add('totalPrice as totalPrice,');
    qryMain.SQL.Add('GrossProfit AS GrossProfit,');
    qryMain.SQL.Add('GrossProfitPercent AS GrossProfitPercent,');
    qryMain.SQL.Add('SaleDate');
    qryMain.SQL.Add('FROM  ' +fstablename);
//    qryMain.SQL.Add('where 1 = 1 ');
    qryMain.SQL.Add('where (IsNull(SaleDate) or SaleDate Between :DateFrom and :DateTo) ');
    qryMain.SQL.Add('order by EmployeeName ');
    CreateTempTable;
  inherited;
  AddCalccolumn('amountPaid', true);
  AddCalccolumn('Balanceamount', true);
  AddCalccolumn('Commissionamt', true);
    
end;

procedure TSalescommissionListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        case grdPaidfilters.ItemIndex of
          0: GroupFilterString := '(Details = 0)';
          1: GroupFilterString := '(Details = 0 and Balanceamount <> 0 )';
        end;
      end;
    1:
      begin {Details}
        case grdPaidfilters.ItemIndex of
          0: GroupFilterString := '(Details <> 0)';
          1: GroupFilterString := '(Details <> 0 and Balanceamount<> 0)';
        end;
      end;
  end;
  inherited grpFiltersClick(Sender);
end;

procedure TSalescommissionListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
        if qryMainCommissionOn.asString = 'G' then qrymainCalccommissionOn.asString := 'Gross Profit'
  else  if qryMainCommissionOn.asString = 'I' then qrymainCalccommissionOn.asString := 'Invoice Value'
  else  if qryMainCommissionOn.asString = 'L' then qrymainCalccommissionOn.asString := 'Landed Cost';
  qryMainBalanceAmount.asfloat := Qrymaincommissionamt.asFloat - QrymainAmountPaid.Asfloat;
end;

procedure TSalescommissionListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMainDetails.asInteger = 1 then begin
    if grpFilters.itemindex = 1 then begin
      AFont.Style := AFont.Style + [fsBold];
    end;
    if (Sysutils.SameText(field.Fieldname , 'Category')) or
        (Sysutils.SameText(field.Fieldname , 'Name')) or
        (Sysutils.SameText(field.Fieldname , 'CommissionRate')) or
        (Sysutils.SameText(field.Fieldname , 'IsCommissionPercent')) then begin
        Afont.color := ABrush.color;
    end;
  end else begin
  end;
  if Sysutils.SameText(field.Fieldname , 'Overheadbaserate') then
    if qryMainOverheadbaserate.asfloat = 0 then
      Afont.color := ABrush.color;
end;

class procedure TSalescommissionListGUI.Listforemployee(const EmployeeId: Integer;const ClassId :Integer;AOwner:Tcomponent; fSelectcommissions :TNotifyEvent; Transconnection :TERPConnection);
var
  form :Tcomponent;
begin
  if EmployeeId = 0 then exit;
  form := getcomponentByClassname('TSalescommissionListGUI' , True , AOwner);
  if not assigned(form) then exit;
  TSalescommissionListGUI(Form).grdPaidfilters.itemIndex := 1;
  TSalescommissionListGUI(Form).grdPaidfilters.enabled := False;
  TSalescommissionListGUI(Form).grpFilters.itemIndex := 1;
  TSalescommissionListGUI(Form).grpFilters.enabled := False;

  TSalescommissionListGUI(Form).Qrymain.SQL.add(' and EmployeeId = ' +IntToStr(EmployeeID) );
  if ClassId <> 0 then
    TSalescommissionListGUI(Form).Qrymain.SQL.add(' and classId = ' +IntToStr(ClassId) );
  TSalescommissionListGUI(Form).RefreshOrignalSQL;

  TSalescommissionListGUI(Form).Grdmain.Options:=TSalescommissionListGUI(Form).Grdmain.Options+[dgMultiSelect,dgRowSelect];
  TSalescommissionListGUI(Form).Selectcommissions := fSelectcommissions;
  TSalescommissionListGUI(Form).Transconnection :=Transconnection;
  TSalescommissionListGUI(Form).showmodal;
end;


procedure TSalescommissionListGUI.cmdCloseClick(Sender: TObject);
begin
  if assigned(fSelectcommissions) then
    Selectcommissions(grdMain);
  inherited;
end;

procedure TSalescommissionListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if qryMainDetails.asInteger = 1 then
    Accept := False
  else if qryMainBalanceamount.asfloat = 0 then
    Accept := False
  else Accept := true;
end;

procedure TSalescommissionListGUI.RefreshQuery;
begin
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDateTime := 0;
    qryMain.ParamByName('DateTo').AsDateTime := MaxDAteTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDateTime := dtFrom.Date;
    qryMain.ParamByName('DateTo').AsDateTime := dtTo.Date;
  end;

  inherited;
end;

procedure TSalescommissionListGUI.FormShow(Sender: TObject);
BEGIN 

  if Assigned(fTransconnection) then begin
      if Qrymain.active  then Qrymain.close;
      Qrymain.connection :=fTransconnection ;
  end;

  btnUpdateBatch.enabled :=SalesCommenabled;
  Self.Caption := 'Commission List    -    '+SalesCommissionbatchUpdateDetails;
  inherited;
  TitleLabel.Caption := 'Commission List';
  if Assigned(fSelectcommissions) then begin
    grpFilters.itemindex := 1;
    grdPaidfilters.itemindex := 1;
    btnSelectAll.Enabled := true;
  end;
end;

procedure TSalescommissionListGUI.grdMainDblClick(Sender: TObject);
begin
  if Sysutils.SameText(grdmain.getactivefield.fieldname , 'Grossprofit') then begin
    with TSalesgrossProfitGUI.create(Self) do try
      SaleID := qryMainSaleID.asInteger;
      showmodal;
    finally
        free;
    end;
  end else begin
    SubsequentID := Chr(95) + qryMain.Fields.FieldByName('TransType').AsString;
    inherited;
  end;
end;

procedure TSalescommissionListGUI.btnUpdateBatchClick(Sender: TObject);
begin
  inherited;
  if Appenv.CompanyPrefs.UseSalesCommission then begin
      TfmSalesCommission.Updatesalescommission(0,0,true);
      Self.Caption := 'Commission List    -    '+SalesCommissionbatchUpdateDetails;
      TitleLabel.Caption := 'Commission List';
      CreateTempTable;
      RefreshQuery;
  end;
end;

procedure TSalescommissionListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TSalescommissionListGUI.CalcFooter;
begin
  (*if ((grdPaidfilters.ItemIndex =0) OR (qryMainBalanceAmount.asFloat <> 0 )) and
    (qryMainDetails.asInteger = 2) then*)
  if ((grdPaidfilters.ItemIndex =0) and  (qryMainDetails.asInteger = 1)) or
    ((grdPaidfilters.ItemIndex =1) and  (qryMainDetails.asInteger = 2)) then
    inherited;
end;

procedure TSalescommissionListGUI.CreateTemptable;
begin
 with CommonDbLib.TempMyScript do try
    SQL.add('Drop table if exists ' + fstablename +';' );
    SQL.add('Create table ' +Fstablename + ' ');

    SQL.add('SELECT');
    SQL.add('If(s.IsCashSale="T" And s.IsPOS="F" ,"Cash Sale",If(s.IsRefund="T","Refund",If(s.IsCashSale="T" And s.IsPOS="T","POS",If(S.IsInvoice="T","Invoice","Unknown")))) as TransType,');
    SQL.add('0 as Details,');
    SQL.add('0 as SalesCommissionId,');
    SQL.add('SC.SaleID as SaleID,');
    SQL.add('S.ClientPrintName as CustomerName,');
    SQL.add('SC.employeeId as EmployeeId,');
    SQL.add('0 as ProductID,');
    SQL.add('S.ClassId as ClassId,');
    SQL.add('S.class as Class,');
    SQL.add('`SC`.`IsCommissiononpaidInvoice` as IsCommissiononpaidInvoice,');
    SQL.add('`SC`.`Commissioninvoiceexprice` as Commissioninvoiceexprice,');
    SQL.add('`SC`.`CommissionOn` as CommissionOn,');
    SQL.add('`SC`.`Overheadbaserate` as Overheadbaserate,');
    SQL.add('SC.employeeName as EmployeeName,');
    SQL.add('space(100) as name,');
    SQL.add('space(100) as Category,');
    SQL.add('0 as CommissionRate,');
    SQL.add('"F" as IsCommissionPercent,');
    SQL.add('Sum(Round((ifnull(SC.CommissionAmount,0)),'+inttostr(CurrencyRoundPlaces)+'))  as Commissionamt ,');
    SQL.add('(Select Round(Sum(ifnull(`PCL`.CommissionAmount,0)),'+inttostr(CurrencyRoundPlaces)+')  ');
        SQL.add('from tblpayscommissionlines PCL ');
        SQL.add('where  PCL.SalescommissionId = SC.SalesCommissionId )  as AmountPaid,');
    SQL.add('0.0 as GrossProfit,');
    SQL.add('0.0 as GrossProfitPercent, ');
    SQL.add('0.0 as TotalCost,');
    SQL.add('0.0 as TotalPrice,');
    SQL.add('S.SaleDate');
    SQL.add('FROM  `tblsalescommission` AS `SC` inner join tblSales S on S.SaleId = SC.SaleId');
    SQL.add('where SC.Deleted = "F" ');
    SQL.add('group by SC.SaleID');

    SQL.add('union all');

    SQL.add('SELECT');
    SQL.add('NULL as TransType,');
    SQL.add('1 as Details,');
    SQL.add('0 as SalesCommissionId,');
    SQL.add('NULL as SaleID,');
    SQL.add('NULL as CustomerName,');
    SQL.add('SC.employeeId as EmployeeId,');
    SQL.add('0 as ProductID,');
    SQL.add('NULL as ClassId,');
    SQL.add('null as Class,');
    SQL.add('NULL as IsCommissiononpaidInvoice,');
    SQL.add('NULL as Commissioninvoiceexprice,');
    SQL.add('NULL as CommissionOn,');
    SQL.add('NULL as Overheadbaserate,');
    SQL.add('SC.employeeName as EmployeeName,');
    SQL.add('space(100) as name,');
    SQL.add('space(100) as Category,');
    SQL.add('0 as CommissionRate,');
    SQL.add('"F" as IsCommissionPercent,');
    SQL.add('Sum(Round((ifnull(SC.CommissionAmount,0)),'+inttostr(CurrencyRoundPlaces)+'))  as Commissionamt ,');
    SQL.add('(Select Round(Sum(ifnull(`PCL`.CommissionAmount,0)),'+inttostr(CurrencyRoundPlaces)+')  ');
        SQL.add('from tblpayscommissionlines PCL ');
        SQL.add('where  PCL.SalescommissionId = SC.SalesCommissionId )  as AmountPaid,');
    SQL.add('NULL as GrossProfit,');
    SQL.add('NULL as GrossProfitPercent, ');
    SQL.add('NULL as TotalCost,');
    SQL.add('NULL as TotalPrice,');
    SQL.add('NULL as SaleDate');
    SQL.add('FROM  `tblsalescommission` AS `SC` inner join tblSales S on S.SaleId = SC.SaleId');
    SQL.add('where SC.Deleted = "F" ');
    SQL.add('group by SC.EmployeeID');

    SQL.add('union all');

    SQL.add('SELECT');
    SQL.add('If(s.IsCashSale="T" And s.IsPOS="F" ,"Cash Sale",If(s.IsRefund="T","Refund",If(s.IsCashSale="T" And s.IsPOS="T","POS",If(S.IsInvoice="T","Invoice","Unknown")))) as TransType,');
    SQL.add('2 as Details,');
    SQL.add('Sc.SalesCommissionId As SalesCommissionId,');
    SQL.add('sc.SaleId,');
    SQL.add('S.ClientPrintName as CustomerName,');
    SQL.add('SC.EmployeeID as EmployeeID,');
    SQL.add('0 as ProductId,');
    SQL.add('S.ClassId,');
    SQL.add('S.class,');
    SQL.add('`SC`.`IsCommissiononpaidInvoice` as IsCommissiononpaidInvoice,');
    SQL.add('`SC`.`Commissioninvoiceexprice` as Commissioninvoiceexprice,');
    SQL.add('`SC`.`CommissionOn` as CommissionOn,');
    SQL.add('`SC`.`Overheadbaserate` as Overheadbaserate,');
    SQL.add('SC.employeeName ,');
    SQL.add('space(100) as name,');
    SQL.add('"Employee" as Category,');
    SQL.add('CommissionRate as CommissionRate,');
    SQL.add('IsCommissionPercent ,');
    SQL.add('Round((ifnull(sc.CommissionAmount,0)),'+inttostr(CurrencyRoundPlaces)+')  as Commissionamt ,');
    SQL.add('Round(Sum(ifnull(`PCL`.CommissionAmount,0)),'+inttostr(CurrencyRoundPlaces)+')  as AmountPaid ,');
    SQL.add('0.0,0.0, 0.0,0.0,');
    SQL.add('S.SaleDate');
    SQL.add('FROM `tblsalescommission` AS `SC` inner join tblSales S on S.SaleId = SC.SaleId  Left join tblpayscommissionlines PCL on PCL.SalescommissionId = SC.SalesCommissionId');
    SQL.add('where SC.Deleted = "F"  and ifnull(SaleLineID,0) = 0');
    SQL.add('group by SC.SaleID, SC.EmployeeId');

    SQL.add('union all');
    SQL.add('SELECT');
    SQL.add('If(s.IsCashSale="T" And s.IsPOS="F" ,"Cash Sale",If(s.IsRefund="T","Refund",If(s.IsCashSale="T" And s.IsPOS="T","POS",If(S.IsInvoice="T","Invoice","Unknown")))) as TransType,');
    SQL.add('2 as Details,');
    SQL.add('SC.SalesCommissionId as SalesCommissionId,');
    SQL.add('sc.SaleId,');
    SQL.add('S.ClientPrintName as CustomerName,');
    SQL.add('SC.EmployeeID as EmployeeID,');
    SQL.add('SC.ProductId as ProductId,');
    SQL.add('S.ClassId,');
    SQL.add('S.class,');
    SQL.add('`SC`.`IsCommissiononpaidInvoice` as IsCommissiononpaidInvoice,');
    SQL.add('`SC`.`Commissioninvoiceexprice` as Commissioninvoiceexprice,');
    SQL.add('`SC`.`CommissionOn` as CommissionOn,');
    SQL.add('`SC`.`Overheadbaserate` as Overheadbaserate,');
    SQL.add('SC.employeeName ,');
    SQL.add('SC.ProductName  as name,');
    SQL.add('"Product Sale" as Category,');
    SQL.add('CommissionRate as CommissionRate,');
    SQL.add('IsCommissionPercent,');
    SQL.add('Round((ifnull(sc.CommissionAmount,0)),'+inttostr(CurrencyRoundPlaces)+')  as Commissionamt ,');
    SQL.add('Round(Sum(ifnull(`PCL`.CommissionAmount,0)),'+inttostr(CurrencyRoundPlaces)+')  as AmountPaid,');
    (*SQL.add('0.0,0.0');*)
    SQL.add('(SELECT (if(ifnull(SL.shipped,0) <> 0 and ( ifnull(SL.LineCostInc,0)<> 0 or ifnull(SL.LinePriceInc,0)<>0)  , ');
        SQL.add('if(ifnull(SL.LinePriceInc,0) = 0 , 0-(SL.shipped*ifnull(SL.LineCostInc,0)) ,  ');
        SQL.add('if(ifnull(SL.LineCostInc,0) = 0 ,(SL.shipped*ifnull(SL.LinePriceInc,0)),  ');
        SQL.add('Round((SL.LinePriceInc - LineCostInc)*SL.shipped, '+inttostr(CurrencyRoundPlaces)+')     )   )  ,0))  ');
        SQL.add('FROM tblsaleslines AS SL where SL.saleLineID =  SC.SaleLineId) as GrossProfit,');
    SQL.add('(SELECT ((if(ifnull(SL.shipped,0) <> 0 and ( ifnull(SL.LineCostInc,0)<> 0 or ifnull(SL.LinePriceInc,0)<>0)  , ');
        SQL.add('if(ifnull(SL.LinePriceInc,0) = 0 , 0-100 ,  ');
        SQL.add('if(ifnull(SL.LineCostInc,0) = 0 ,100,  ');
        SQL.add('Round(((SL.LinePriceInc - LineCostInc)/(SL.LinePriceInc))*100, '+inttostr(CurrencyRoundPlaces)+')  )   )  ,0)))  ');
        SQL.add('FROM tblsaleslines AS SL where SL.saleLineID =  SC.SaleLineId) as GrossProfitPercent,');

    SQL.add('(SELECT ifnull(SL.shipped,0) *ifnull(SL.LineCostInc,0) ');
        SQL.add('FROM tblsaleslines AS SL where SL.saleLineID =  SC.SaleLineId) as Totalcost, ');
    SQL.add('(SELECT ifnull(SL.shipped,0) *ifnull(SL.LinePriceInc,0) ');
        SQL.add('FROM tblsaleslines AS SL where SL.saleLineID =  SC.SaleLineId) as totalPrice, ');

    SQL.add('S.SaleDate');
    SQL.add('FROM `tblsalescommission` AS `SC` inner join tblSales S on S.SaleId = SC.SaleId  Left join tblpayscommissionlines PCL on PCL.SalescommissionId = SC.SalesCommissionId');
    SQL.add('where SC.Deleted = "F"  and ifnull(SaleLineID,0) <> 0');
    SQL.add('group by SC.SaleID, EmployeeId, SC.ProductName');
    SQL.add('Order by SaleId, EmployeeId, Category;');

//    sql.SaveToFile('c:\temp\temp.sql');

    SQL.add('ALTER TABLE ' +Fstablename + ' ADD INDEX `SaleIdidx` (`SaleID`);');
    
    SQL.add('Drop table if exists ' + fstablename +'1;' );
//    SQL.add('Create table ' +Fstablename + '1 Select saleId, TotalPrice, totalcost from  ' +fsTablename +' where details = 2 and Category = "Product Sale" ;');
    SQL.add('Create table ' +Fstablename + '1 Select t.SaleId , Sum(ifnull(SL.shipped,0) *ifnull(SL.LineCostInc,0))  as Totalcost , ' +
                      ' Sum(ifnull(SL.shipped,0) *ifnull(SL.LinePriceInc,0)) totalPrice ' +
                      ' From ' +Fstablename + ' T ' +
                      ' inner join tblsaleslines Sl on Sl.saleId = T.saleId ' +
                      ' group by T.Details, SaleID;');

    SQL.add('ALTER TABLE ' +Fstablename + '1 ADD COLUMN `ID` int NULL AUTO_INCREMENT , ADD PRIMARY KEY(`ID`), ADD INDEX `SaleID`(`saleId`);');
(*    SQL.add('ALTER TABLE ' +Fstablename + ' ADD COLUMN `Totalcost` Double;');
    SQL.add('ALTER TABLE ' +Fstablename + ' ADD COLUMN `totalPrice` Double;');*)
    SQL.add('Update   ' + fstablename +'  t1  inner join  ' + fstablename +'1  t2 on t1.SaleId = t2.SaleId set t1.totalcost = t2.totalCost, T1.TotalPrice = t2.totalPrice where  t1.details = 1 or category = "Employee" and t1.Details <> 1;');
    SQL.add('Update   ' + fstablename +'  t1  Set GrossProfitPercent = Round((totalPrice-Totalcost)/totalPrice*100,'+inttostr(CurrencyRoundPlaces)+')  where  t1.details = 1 or category = "Employee" and t1.Details <> 1;');
    SQL.add('Update   ' + fstablename +'  t1  Set GrossProfit = Round((totalPrice-Totalcost),'+inttostr(CurrencyRoundPlaces)+')  where  t1.details = 1 or category = "Employee" and t1.Details <> 1;');

    (*SQL.add('Update   ' + fstablename +'  t1 set GrossProfitPercent = (Select Round(((totalPrice)-sum(Totalcost))/sum(totalPrice)*100,2) from ' + fstablename +'1 as t2 where t2.SaleId = t1.SaleId ) where t1.details = 1 or category = "Employee";');
    SQL.add('Update   ' + fstablename +'  t1 set GrossProfit        = (Select Round(((totalPrice-Totalcost)),2)                from ' + fstablename +'1 as t2 where t2.SaleId = t1.SaleId ) where t1.details = 1  or category = "Employee";');*)

    SQL.add('Drop table if exists ' + fstablename +'1;' );
    BeforeExecute:= onBeforeExecute;
    showProgressbar(WAITMSG , 7);
    try
      execute;
    finally
        HideProgressbar;
    end;
  finally
      Free;
  end;
end;

procedure TSalescommissionListGUI.onBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  stepProgressbar;
end;

procedure TSalescommissionListGUI.btnSelectAllClick(Sender: TObject);
var
  bm: TBookmark;
begin
  inherited;
  qryMain.DisableControls;
  try
    bm := qryMain.GetBookmark;
    try
      if btnSelectAll.Caption = 'Unselect All' then begin
        grdMain.UnselectAll;
        btnSelectAll.Caption := 'Select All';
        exit;
      end;
      qryMain.First;
      while not qryMain.Eof do begin
        if (qryMainDetails.asInteger <> 1) and (qryMainBalanceamount.asfloat <> 0) then
          grdMain.SelectRecord;
        qryMain.Next;
      end;
      btnSelectAll.Caption := 'Unselect All';
      qryMain.GotoBookmark(bm);
    finally
      qryMain.FreeBookmark(bm);
    end;
  finally
    qryMain.EnableControls;
  end;
end;

procedure TSalescommissionListGUI.btnShowRelatedCustomersListClick(
  Sender: TObject);
begin
  inherited;
  if OpenERPForm('TSalesListwithCommisionGUI', 0, AfterSalescommissionShow) then
    Self.Close;
end;

procedure TSalescommissionListGUI.AfterSalescommissionShow(
  Sender: TObject);
begin
  TBaseListingGUI(Sender).qryMain.Locate('saleId' , QrymainSaleID.asInteger , []);
end;

procedure TSalescommissionListGUI.btndeleteClick(Sender: TObject);
var
  CalcSalescommissionObj:TCalcSalescommissionObj;
begin
  CalcSalescommissionObj:= TCalcSalescommissionObj.create(Self);
  try
    CalcSalescommissionObj.connection :=TMyDacDataConnection.create(CalcSalescommissionObj);
    CalcSalescommissionObj.connection.Connection := GetNewMyDacConnection(CalcSalescommissionObj);
    CalcSalescommissionObj.DeleteAll(MessageDlgXP_Vista('Do You Wish To Delete The Paid Commissions As Well? ' ,mtConfirmation , [mbyes, mbno] , 0) = mrYes);
    CreateTempTable;
    RefreshQuery;
  finally
    Freeandnil(CalcSalescommissionObj);
  end;
end;

initialization
  RegisterClassOnce(TSalescommissionListGUI);

end.
