unit SalesListwithCommision;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DBCtrls, DAScript,
  MyScript, wwcheckbox, CustomInputBox;

type
  TSalesListwithCommisionGUI = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMainemployeeId: TIntegerField;
    qryMainemployeeName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainIsPOS: TWideStringField;
    qryMainIsRefund: TWideStringField;
    qryMainIsCashSale: TWideStringField;
    qryMainIsInvoice: TWideStringField;
    qryMainCommissionAmount: TFloatField;
    dsLog: TDataSource;
    QrySalescommission: TERPQuery;
    grdLog: TwwDBGrid;
    QrySalescommissionEmployeeId: TIntegerField;
    QrySalescommissionSaleLineId: TIntegerField;
    QrySalescommissionSaleId: TIntegerField;
    QrySalescommissionEmployeeName: TWideStringField;
    QrySalescommissionProductName: TWideStringField;
    QrySalescommissionCommissionOn: TWideStringField;
    QrySalescommissionCommissionRate: TFloatField;
    QrySalescommissionOverheadbaserate: TFloatField;
    QrySalescommissionCommissionAmount: TFloatField;
    QrySalescommissionamount: TFloatField;
    QrySalescommissioncost: TFloatField;
    QrySalescommissionLandedcost: TFloatField;
    QrySalescommissionLatestcost: TFloatField;
    QrySalescommissionSalesCommissionId: TIntegerField;
    Qrylog: TERPQuery;
    QrylogID: TIntegerField;
    QrylogSalescommissionID: TIntegerField;
    Qrylogamount: TFloatField;
    QrylogCost: TFloatField;
    QrylogLandedcost: TFloatField;
    QrylogLatestcost: TFloatField;
    QrylogSaleID: TIntegerField;
    report2n3: TSplitter;
    btnShowRelatedCustomersList: TDNMSpeedButton;
    Label9: TLabel;
    QrySalescommissionValueformula: TWideMemoField;
    QrySalescommissionFormula: TWideMemoField;
    Qrylogformula: TWideMemoField;
    QrylogValueformula: TWideMemoField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure mDblClick(Sender: TObject);
    procedure grdMainRowChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnShowRelatedCustomersListClick(Sender: TObject);
  private
    fsTablename :String;
    Procedure Deletelog;
    (*Procedure Formula;*)
    Procedure AfterSalescommissionShow(Sender:TObject);
    
  public
    Procedure RefreshQuery; override;
  end;

implementation

uses CommonFormLib,commonLib, FastFuncs, BusObjSaleBase, BusObjSales, BusobjCash,
  CommonDbLib, BusObjBase, BusobjSalesCommission, AppEnvironment,
  EmployeeObj, Clipbrd, tcDataUtils, CalcSalescommission,
  SalescommissionList;

{$R *.dfm}
procedure TSalesListwithCommisionGUI.grdMainDblClick(Sender: TObject);
var
  (*salesObj:TSalesBase;*)
  SCU: TSalesCommissionUpdate;
  (*LogDetails :String ;*)
  bm:TBookmark;
  CalcSalescommissionObj:TCalcSalescommissionObj;
begin
  IF Sysutils.SameText(grdMain.GetActiveField.FieldName, 'CommissionAmount') then begin
    if SalesCommenabled = False then begin
      CommonLib.MessageDlgXP_Vista('Sales Commission Is Disabled Or Calculation In Progress.' , mtinformation, [mbok],0) ;
      exit;
    end;
    Appenv.CompanyPrefs.SalesCommissionCalcInProgress := True;
    Appenv.CompanyPrefs.SalesCommissionCalcEmployeeID := appenv.Employee.EmployeeID;
    try
        if CommonLib.MessageDlgXP_Vista('Do you wish to calculate the commission for ' +IntToStr(QrymainSaleID.asInteger)+'?' , mtconfirmation , [mbyes, mbno],0) = mrNo then exit;
        try
          SCU:= TSalesCommissionUpdate.create(Self);
          try
           SCU.connection := TMyDacDataConnection.create(SCU);
           SCU.connection.connection := CommonDbLib.GetNewMyDacConnection(SCU);
           SCU.Load(0);
           SCU.Connection.BeginTransaction;
           try
             SCU.New;
             SCU.CommissionCalculatedOn     :=now;
             SCU.IgnoredateRange            :=true;
             SCU.employeeID                 :=AppEnv.Employee.EmployeeID;
             SCU.PostDB;
             CalcSalescommissionObj:= TCalcSalescommissionObj.create(Self);
             try
              CalcSalescommissionObj.connection := SCU.Connection;
              CalcSalescommissionObj.SaleId := qryMainSaleId.asInteger;
              CalcSalescommissionObj.SalescommissionCalcId := SCU.ID;
              CalcSalescommissionObj.ignoredaterange := true;
              Deletelog;
              CalcSalescommissionObj.doCalc(Qrylog);
              QrySalescommission.Refresh;
             finally
                Freeandnil(CalcSalescommissionObj);
             end;
             SCU.Connection.CommitTransaction;
             Try
               bm:= Qrymain.GetBookmark;
               try
                RefreshQuery;
               finally
                 qrymain.GotoBookmark(bm);
                 qrymain.FreeBookmark(bm);
                 grdmain.SetActivefield('CommissionAmount');
               end;
             Except
                 // kill exception if any from the book mark
             end;
           except
               on E:Exception do begin
                CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbok],0);
                SCU.Connection.RollbackTransaction;
               end;
           end;
          finally
            Freeandnil(SCU);

          end;
        Except
          on E:Exception do begin
            CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbok],0)
          end;
        end;
    finally
      Appenv.CompanyPrefs.SalesCommissionCalcInProgress := False;
      Appenv.CompanyPrefs.SalesCommissionCalcEmployeeID := 0;
    end;
  end else begin
    IF Sysutils.SameText(grdMain.GetActiveField.FieldName, 'SaleId') then begin
      if QrymainIsPOS.asBoolean and QrymainIsCashSale.asBoolean then SubsequentID := Chr(95) + 'POS'
      else if QrymainIsCashSale.asBoolean then SubsequentID := Chr(95) + 'Cash Sale'
      else if QrymainIsRefund.asBoolean then SubsequentID := Chr(95) + 'Refund'
      else if QrymainIsInvoice.asBoolean then SubsequentID := Chr(95) + 'Invoice';
    end;
    inherited;
  end;
end;

procedure TSalesListwithCommisionGUI.mDblClick(Sender: TObject);
begin
  inherited;
  (*pnlLog.visible := False;*)
end;

procedure TSalesListwithCommisionGUI.grdMainRowChanged(Sender: TObject);
begin
  mDblClick(Sender);
end;

procedure TSalesListwithCommisionGUI.RefreshQuery;
begin
  qrymain.Parambyname('DateFrom').asDateTime := Self.FilterDateFrom;
  qrymain.Parambyname('Dateto').asDateTime := Self.FilterDateTo;
  inherited;
end;

procedure TSalesListwithCommisionGUI.FormShow(Sender: TObject);
var
  strSQL:String;
begin

fsTablename := GetUserTemporaryTableName('SalescommissionFormula');
  strSQL:= 'Drop table if exists ' +fstablename +';' +
             'CREATE TABLE ' +fstablename +' ( ID int NULL AUTO_INCREMENT ,  ' +
                  'SalescommissionID int NULL , ' +
                  'SaleID int NULL , ' +
                  'Amount Double NULL ,  ' +
                  'Cost Double NULL ,  ' +
                  'Landedcost Double NULL ,  ' +
                  'LatestCost Double NULL, ' +
                  'Formula Text NULL ,  ' +
                  'ValueFormula text NULL ,  ' +
                  'PRIMARY KEY(ID),  ' +
                  'INDEX SalescommissionID(SalescommissionID))';
  With CommonDbLib.TempMyScript do try
    Sql.add(strSQL);
    Execute;
  finally
      Free;
  end;
  Closedb(QrySalescommission);
  QrySalescommission.SQL.clear;
  QrySalescommission.SQL.add('SELECT `SC`.`SalesCommissionId` , `SC`.`EmployeeId`,'+
                    '`SC`.`SaleLineId`,`SC`.`SaleId`,`SC`.`EmployeeName`,'+
                    '`SC`.`ProductName`,`SC`.`CommissionOn`,`SC`.`CommissionRate`,'+
                    '`SC`.`Overheadbaserate`,'+
                    '`SC`.`CommissionAmount`,T.Amount ,T.cost,T.Landedcost, T.LatestCost, '+
                    '`T`.`Formula`, T.ValueFormula '+
                    ' FROM'+
                    '`tblsalescommission` AS `SC`'+
                    ' Left Join ' + fsTablename +' AS `T` ON `SC`.`SalesCommissionId` = `T`.`SalescommissionID`' +
                    ' where SC.Deleted ="F" ');
  opendb(QrySalescommission);
  grdLog.titlecolor:= GrdMain.titlecolor;
  grdLog.footercolor:= GrdMain.footercolor;
  grdLog.color:= GrdMain.color;

  Closedb(Qrylog);
  Qrylog.SQL.clear;
  Qrylog.SQL.add('select * from ' +fsTablename);
  opendb(Qrylog);

inherited;
end;

procedure TSalesListwithCommisionGUI.Deletelog;
begin
  With CommonDbLib.TempMyScript do try
    SQL.add('Delete from ' +fstablename +' where saleId = ' + IntToStr(QrymainsaleID.asInteger));
    Execute;
  finally
      free;
  end;
  QrySalescommission.refresh;
end;



procedure TSalesListwithCommisionGUI.btnShowRelatedCustomersListClick(
  Sender: TObject);
begin
  inherited;
  if OpenERPForm('TSalescommissionListGUI', 0, AfterSalescommissionShow) then
      Self.Close;
end;

procedure TSalesListwithCommisionGUI.AfterSalescommissionShow(
  Sender: TObject);
begin
  TBaseListingGUI(Sender).qryMain.Locate('saleId' , QrymainSaleID.asInteger , []);
end;

initialization
  RegisterClass(TSalesListwithCommisionGUI);

end.

