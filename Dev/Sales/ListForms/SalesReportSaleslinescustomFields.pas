unit SalesReportSaleslinescustomFields;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesReportCustomFieldsForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwcheckbox, wwdbdatetimepicker, StdCtrls,
  wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript,
  MyScript;

type
  TSalesReportSaleslinescustomFieldsGUI = class(TSalesReportCustomFieldsGUI)
    qryMainSALESLINESCUSTFIELD1: TWideStringField;
    qryMainSALESLINESCUSTFIELD2: TWideStringField;
    qryMainSALESLINESCUSTFIELD3: TWideStringField;
    qryMainSALESLINESCUSTFIELD4: TWideStringField;
    qryMainSALESLINESCUSTFIELD5: TWideStringField;
    qryMainSALESLINESCUSTFIELD6: TWideStringField;
    qryMainSALESLINESCUSTFIELD7: TWideStringField;
    qryMainSALESLINESCUSTFIELD8: TWideStringField;
    qryMainSALESLINESCUSTFIELD9: TWideStringField;
    qryMainSALESLINESCUSTFIELD10: TWideStringField;
    qryMainSALELINEID: TIntegerField;
    qryMainPRODUCTID: TIntegerField;
    qryMainPRODUCTNAME: TWideStringField;
    qryMainTAXCODE: TWideStringField;
    qryMainLINETAX: TFloatField;
    qryMainLINETOTALEX: TFloatField;
    qryMainLINETOTALINC: TFloatField;
    qryMainUNITOFMEASURESALELINES: TWideStringField;
    qryMainUNITOFMEASURESHIPPED: TFloatField;
    qryMainSALEID: TIntegerField;
    qryMainCLIENTID: TIntegerField;
    qryMainCLASSID: TIntegerField;
    qryMainSALEDATE: TDateField;
    qryMainTRANSACTIONTYPE: TWideStringField;
    qryMainCUSTOMERNAME: TWideStringField;
    qryMainEMPLOYEENAME: TWideStringField;
    qryMainCLASSNAME: TWideStringField;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    { Private declarations }
  Protected
    Procedure SetQrymainSQL;Override;
    function salesreportcustomfieldname:String ; Override;

    procedure MakeQrySQL(SQLList:TStringList);Override;
    procedure RefreshTotals; override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses MySQLConst, CommonLib;



{$R *.dfm}

{ TSalesReportSaleslinescustomFieldsGUI }
procedure TSalesReportSaleslinescustomFieldsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalccolumn('LineTax', true);
  AddCalccolumn('LineTotalEx', true);
  AddCalccolumn('LineTotalInc', true);
end;

procedure TSalesReportSaleslinescustomFieldsGUI.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TSalesReportSaleslinescustomFieldsGUI.grdMainDblClick(  Sender: TObject);
var
  Col: integer;
  FieldName: string;
begin
  { when double clicking on grid:
    allow qualification of row type depending on content of field 'Transaction Type'
  }
  SubsequentID := Chr(95) + Qrymain.FieldByName('TransactionType').AsString;
  Col := grdMain.GetActiveCol;
  FieldName := grdMain.FieldName(Col);
  if FieldName <> 'Memo' then begin
    inherited;
  end;

end;

procedure TSalesReportSaleslinescustomFieldsGUI.MakeQrySQL(SQLList:TStringList);
begin
       SQLList.Add('truncate  ' + fstablename + ';');
        SQLList.Add('Insert into ' + fstablename + '(' +
        'SALELINEID,  SALEID,  PRODUCTID,    CLIENTID,  CLASSID ,  SALEDATE,  TRANSACTIONTYPE ,  CUSTOMERNAME ,'+
        'EMPLOYEENAME ,  CLASSNAME ,  PRODUCTNAME,  TAXCODE ,  LINETAX ,  LINETOTALEX,  LINETOTALINC,  UNITOFMEASURESALELINES ,  UNITOFMEASURESHIPPED )'+
        ' SELECT ' +
        ' SL.SaleLineId as SaleLineId,' +
        ' S.SaleID as SaleID,' +
        ' SL.ProductID as ProductID,' +
        ' S.ClientID as ClientID,' +
        ' S.ClassID as ClassID,' +
        ' S.SaleDate as SaleDate,' +
        ' If(S.IsCashSale="T" And S.IsPOS="F", "Cash Sale",If(S.IsRefund="T","Refund",If(S.IsCashSale="T" And S.IsPOS="T","POS",If(S.IsInvoice="T","Invoice","Unknown")))) as TransactionType,' +
        ' S.CustomerName as CustomerName,' +
        ' S.EmployeeName AS EmployeeName,' +
        ' S.Class as ClassName,' +
        ' SL.ProductName as ProductName,' +
        ' SL.LineTaxCode as TaxCode,' +
        ' SL.LineTax as LineTax,' +
        ' SL.TotalLineAmount as LineTotalEx,' +
        ' SL.TotalLineAmountInc as LineTotalInc,' +
        ' SL.UnitOfMeasureSaleLines as UnitOfMeasureSaleLines,' +
        ' SL.UnitOfMeasureShipped as UnitOfMeasureShipped' +
        ' FROM tblSales S ' +
        ' INNER JOIN tblSalesLines SL ON  S.SaleID = SL.SaleID ' +
        ' WHERE (S.IsRefund ="T" OR S.IsCashSale="T" OR ' +
        ' S.IsInvoice="T" OR S.IsPOS="T") ' +
        ' AND S.IsQuote="F" AND S.IsLayby="F" ');
        if not chkAllClass.Checked then  SQLList.add('AND S.ClassID = ' + IntToStr(cboClassQry.Fieldbyname('classId').asInteger));
        if not chkBaseOnShipped.Checked then SQLList.add('AND S.SaleDate Between ' +
                            quotedstr(FormatDateTime(MysqlDateFormat, dtfrom.DateTime)) +
                            ' AND ' + quotedstr(FormatDateTime(MysqlDateFormat, dtto.DateTime)) )
        else SQLList.add('AND S.ShipDate Between ' +
                            quotedstr(FormatDateTime(MysqlDateFormat, dtfrom.DateTime)) +
                            ' AND ' + quotedstr(FormatDateTime(MysqlDateFormat, dtto.DateTime)) );
        SQLList.add('GROUP BY SL.SaleLineID');
        SQLList.add('Order BY SL.SaleID Desc; ');

        SQLList.add('update '+fstablename +' T  ' +
                    ' inner join tblSalesLines SL on SL.SaleLineID = T.SaleLineID Set '+
				                  ' T.SalesLinesCustField1=SL.SalesLinesCustField1, '+
				                  ' T.SalesLinesCustField2=SL.SalesLinesCustField2, '+
				                  ' T.SalesLinesCustField3=SL.SalesLinesCustField3, '+
				                  ' T.SalesLinesCustField4=SL.SalesLinesCustField4, '+
				                  ' T.SalesLinesCustField5=SL.SalesLinesCustField5, '+
				                  ' T.SalesLinesCustField6=SL.SalesLinesCustField6, '+
				                  ' T.SalesLinesCustField7=SL.SalesLinesCustField7, '+
				                  ' T.SalesLinesCustField8=SL.SalesLinesCustField8, '+
				                  ' T.SalesLinesCustField9=SL.SalesLinesCustField9, '+
				                  ' T.SalesLinesCustField10=SL.SalesLinesCustField10; ');
end;



procedure TSalesReportSaleslinescustomFieldsGUI.RefreshQuery;
begin
  inherited;

end;

procedure TSalesReportSaleslinescustomFieldsGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

function TSalesReportSaleslinescustomFieldsGUI.salesreportcustomfieldname: String;
begin
  result := 'SL';
end;

procedure TSalesReportSaleslinescustomFieldsGUI.SetQrymainSQL;
begin
  inherited;
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select  Distinct ');
  Qrymain.SQL.add('SALEID as  SALEID , ');
  Qrymain.SQL.add('CLIENTID as  CLIENTID , ');
  Qrymain.SQL.add('CLASSID as  CLASSID , ');
  Qrymain.SQL.add('SALEDATE as  SALEDATE , ');
  Qrymain.SQL.add('TRANSACTIONTYPE as  TRANSACTIONTYPE , ');
  Qrymain.SQL.add('CUSTOMERNAME as  CUSTOMERNAME , ');
  Qrymain.SQL.add('EMPLOYEENAME as  EMPLOYEENAME , ');
  Qrymain.SQL.add('CLASSNAME as  CLASSNAME , ');
  Qrymain.SQL.add('PRODUCTID as  PRODUCTID , ');
  Qrymain.SQL.add('SALELINEID as  SALELINEID , ');
  Qrymain.SQL.add('PRODUCTNAME as  PRODUCTNAME , ');
  Qrymain.SQL.add('TAXCODE as  TAXCODE , ');
  Qrymain.SQL.add('LINETAX as  LINETAX , ');
  Qrymain.SQL.add('LINETOTALEX as  LINETOTALEX , ');
  Qrymain.SQL.add('LINETOTALINC as  LINETOTALINC , ');
  Qrymain.SQL.add('UNITOFMEASURESALELINES as  UNITOFMEASURESALELINES , ');
  Qrymain.SQL.add('UNITOFMEASURESHIPPED as  UNITOFMEASURESHIPPED , ');
  Qrymain.SQL.add('Trim(ifnull(SALESLINESCUSTFIELD1,"")) as  SALESLINESCUSTFIELD1 , ');
  Qrymain.SQL.add('Trim(ifnull(SALESLINESCUSTFIELD2,"")) as  SALESLINESCUSTFIELD2 , ');
  Qrymain.SQL.add('Trim(ifnull(SALESLINESCUSTFIELD3,"")) as  SALESLINESCUSTFIELD3 , ');
  Qrymain.SQL.add('Trim(ifnull(SALESLINESCUSTFIELD4,"")) as  SALESLINESCUSTFIELD4 , ');
  Qrymain.SQL.add('Trim(ifnull(SALESLINESCUSTFIELD5,"")) as  SALESLINESCUSTFIELD5 , ');
  Qrymain.SQL.add('Trim(ifnull(SALESLINESCUSTFIELD6,"")) as  SALESLINESCUSTFIELD6 , ');
  Qrymain.SQL.add('Trim(ifnull(SALESLINESCUSTFIELD7,"")) as  SALESLINESCUSTFIELD7 , ');
  Qrymain.SQL.add('Trim(ifnull(SALESLINESCUSTFIELD8,"")) as  SALESLINESCUSTFIELD8 , ');
  Qrymain.SQL.add('Trim(ifnull(SALESLINESCUSTFIELD9,"")) as  SALESLINESCUSTFIELD9 , ');
  Qrymain.SQL.add('Trim(ifnull(SALESLINESCUSTFIELD10,"")) as  SALESLINESCUSTFIELD10  ');
  Qrymain.SQL.add('from '+fstablename);
end;
initialization
  RegisterClassOnce(TSalesReportSaleslinescustomFieldsGUI);
end.
