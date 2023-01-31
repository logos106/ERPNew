unit NonManufactureSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, CustomInputBox, wwcheckbox;

type
  TNonManufactureSalesGUI = class(TBaseListingGUI)
    qryMainCategory: TIntegerField;
    qryMainSaleLineID: TIntegerField;
    qryMainProductId: TIntegerField;
    qryMainSaleId: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMainSaledate: TDateField;
    qryMainisinvoice: TWideStringField;
    qryMainissalesorder: TWideStringField;
    qryMainconverted: TWideStringField;
    qryMainTotalcostinc: TFloatField;
    qryMainTotalcost: TFloatField;
    qryMainTotalOnAvgcost: TFloatField;
    qryMainAvgcost: TFloatField;
    qryMainLineTaxRate: TFloatField;
    qryMainoldTotalcostinc: TFloatField;
    qryMainoldTotalcost: TFloatField;
    qryMainTotalAmountinc: TFloatField;
    qryMainoldTotalAmountinc: TFloatField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    tablename :String;
    st:TStringlist;
    Procedure MakeQuery;
    procedure createSalesbackup;

  Protected
    Procedure RefreshQuery; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib,  CommonDbLib, tcConst, BusObjStock;

{$R *.dfm}

{ TBaseListingGUI1 }


procedure TNonManufactureSalesGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if qrymain.RecordCount=0 then exit;

  if grdmain.SelectedList.Count =0 then
    if MessageDlgXP_Vista('No Product selected for recalculation. Do you wish to select aal products?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit
    else grdmain.selectall;
  createSalesbackup;
  IterateProcno:= 1;
  st:= tstringlist.Create;
  try
    IterateselectedRecords(true);
    if st.Count > 0 then
      ExecuteSQL(st.Text);
  finally
    FreeandNil(st);
  end;
  RefreshQuery;
end;
procedure TNonManufactureSalesGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if IterateProcno = 1 then begin
    if QrymainCategory.AsInteger = 2 then begin
       st.Add('update tblsaleslines set lineCost = ' +FloatTostr((*Qrymainavgcost.AsFloat*)Round(TProduct.Cost(QrymainproductID.AsInteger),GeneralRoundPlaces)) +','+
                                   ' lineCostinc = ' +  FloatTostr(Round(GetAmountInc((*Qrymainavgcost.AsFloat*)TProduct.Cost(QrymainproductID.AsInteger), QrymainLineTaxRate.asFloat), GeneralRoundPlaces)  ) +
                                   ' where salelineId =' + inttostr(qrymainsalelineId.asInteger)+';');
    end;
  end;
end;
procedure TNonManufactureSalesGUI.createSalesbackup;
begin
  if Tableexists('erpfix_saleslines') and (MessageDlgXP_Vista('Do you wish to re-create the backup tables?', mtConfirmation, [mbYes, mbNo], 0)= mrno) then exit;
  With TempMyScript do try
    SQL.add('Drop table if exists erpfix_saleslines;');
    SQL.add('create table erpfix_saleslines like tblsaleslines;');
    SQL.add('insert into erpfix_saleslines select * from tblsaleslines;');
   execute;
  finally
    Free;
  end;
end;

procedure TNonManufactureSalesGUI.FormCreate(Sender: TObject);
begin
  tablename := GetUserTemporaryTableName('nonBOMSales');
  Qrymain.SQL.Text := 'Select * from ' +tablename +' order by saleId , category';
  inherited;
end;

procedure TNonManufactureSalesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymaincategory.AsInteger =1 then afont.Style := afont.Style +[fsbold];
end;

procedure TNonManufactureSalesGUI.MakeQuery;
begin
  With TempMyScript do try
        SQL.Add('drop table if exists '+ tablename +';');
        SQL.Add('Create table '+tablename );
        SQL.Add('Select  distinct ');
        SQL.Add('1 as Category ,0 as SaleLineID, s.SaleId as SaleId,');
        SQL.Add('s.CustomerName as customername,');
        SQL.Add('s.SAledate  as Saledate,');
        SQL.Add('S.isinvoice as isinvoice,');
        SQL.Add('S.issalesorder as issalesorder,');
        SQL.Add('S.converted as converted');
        SQL.Add('from tblsales s');
        SQL.Add('inner join tblsaleslines SL on S.SaleId = Sl.saleID');
        SQL.Add('Left join tblProctree PT on SL.SaleLineID = PT.masterId and PT.mastertype <> "mtProduct"');
        SQL.Add('where ifnull(PT.proctreeId,0)=0');
        SQL.Add('Group by s.SaleID');
        SQL.Add('order by SaleId desc;') ;
        SQL.Add('Alter table ' + tablename +' add column Totalcostinc double;');
        SQL.Add('Alter table ' + tablename +' add column Totalcost double;');
        SQL.Add('Alter table ' + tablename +' add column TotalOnAvgcost double;');
        SQL.Add('Alter table ' + tablename +' add column Avgcost double;');
        SQL.Add('Alter table ' + tablename +' add column LineTaxRate double;');
        SQL.Add('Alter table ' + tablename +' add column oldTotalcostinc double;');
        SQL.Add('Alter table ' + tablename +' add column oldTotalcost double;');
        SQL.Add('Alter table ' + tablename +' add column TotalAmountinc double;');
        SQL.Add('Alter table ' + tablename +' add column oldTotalAmountinc double;');
        SQL.Add('Alter table ' + tablename +' add column ProductId int(11);');
        SQL.Add('Alter table  ' + tablename +' add index saleId (SaleID);');

        SQL.Add('Drop table if exists ' +tablename +'1;');
        SQL.Add('create table  ' +tablename +'1');
        SQL.Add('Select ');
        SQL.Add('SL.saleID, ');
        SQL.Add('Sum(SL.LineCostInc * SL.QtySold) Totalcostinc,  ');
        SQL.Add('Sum(SL.LineCost * SL.QtySold) Totalcost ,  ');
        SQL.Add('Sum(P.AvgCost * SL.QtySold) TotalonAvgcost ,  ');
        SQL.Add('Sum(SL.totalLineAmountinc) totalLineAmountinc ');
        SQL.Add('from tblsaleslines SL inner join tblParts P on p.partsId = Sl.productId inner join ' +tablename + ' T on T.saleId = Sl.saleID group by saleID;');

        SQL.Add('Alter table  ' + tablename +'1 add index saleId (SaleID);');
        SQL.Add('update ' +tablename +' T ' +
                ' inner join ' +tablename + '1 T1 on T.SAleId = T1.SaleId ' +
                ' Set T.Totalcostinc = T1.Totalcostinc , ' +
                ' t.Totalcost = T1.Totalcost ,' +
                ' T.TotalOnAvgcost = T1.TotalOnAvgcost ,  ' +
                ' T.TotalAmountinc = T1.totalLineAmountinc;');

    if tableexists('erpfix_sales') and tableexists('erpfix_saleslines')  then begin
        SQL.Add('Drop table if exists ' +tablename +'1;');
        SQL.Add('create table  ' +tablename +'1');
        SQL.Add('Select ');
        SQL.Add('SL.saleID, ');
        SQL.Add('Sum(SL.LineCostInc * SL.QtySold) Totalcostinc,  ');
        SQL.Add('Sum(SL.LineCost * SL.QtySold) Totalcost ,  ');
        SQL.Add('Sum(SL.totalLineAmountinc) totalLineAmountinc ');
        SQL.Add('from erpfix_saleslines SL inner join ' +tablename + ' T on T.saleId = Sl.saleID group by saleID;');
    end;
    SQL.Add('update ' +tablename +' T ' +
                ' inner join ' +tablename + '1 T1 on T.SAleId = T1.SaleId ' +
                ' Set T.oldTotalcostinc = T1.Totalcostinc , ' +
                ' t.oldTotalcost = T1.Totalcost ,' +

                ' T.oldTotalAmountinc = T1.totalLineAmountinc;');
    SQL.add('insert into  ' +
                tablename +' (Category, saleID ,SaleLineID ,  ProductId , customername , sALeDate , isinvoice, issalesorder , Converted , Totalcostinc , Totalcost ,TotalonAvgcost , TotalAmountinc, avgCost , LineTaxRate) ' +
                ' Select 2 as Category , ' +
                ' Sl.sAleId,Sl.SaleLineID,Sl.ProductId,  T.customername, T.sALeDate , T.IsInvoice, T.IsSalesorder, T.Converted, ' +
                ' SL.LineCostInc*Qtysold , SL.LineCost*Qtysold, P.AvgCost*Qtysold , SL.TotalLineAmountInc , if(ifnull(P.Avgcost,0)=0 , P.COST1 , P.Avgcost) , SL.LineTaxRate' +
                ' from ' +tablename +' T ' +
                ' inner join tblsaleslines SL on T.SaleId = SL.SaleId ' +
                ' inner join tblparts P on P.PARTSID = SL.productID;');
    if tableexists('erpfix_sales') and tableexists('erpfix_saleslines')  then begin
      SQL.add('update '+tablename +'  T  ' +
                ' inner join erpfix_saleslines F on T.SaleLineId = F.SAleLineId  ' +
                ' Set oldTotalcostinc = F.LineCostInc*Qtysold  ,  ' +
                ' oldTotalcost = F.LineCost*Qtysold  ,  ' +
                ' oldTotalAmountinc = F.TotalLineAmountInc;');
    end;
    Execute;
  finally
    Free;
  end;
end;

procedure TNonManufactureSalesGUI.RefreshQuery;
begin
  MakeQuery;
  inherited;
end;
initialization
  RegisterClassOnce(TNonManufactureSalesGUI);

end.

