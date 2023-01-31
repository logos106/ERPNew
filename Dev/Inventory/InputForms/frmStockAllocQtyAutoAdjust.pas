unit frmStockAllocQtyAutoAdjust;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMPanel, Shader , frmImportStockAdjustment, frmExportStockAdjustment,
  DAScript, MyScript, DNMSpeedButton, ComCtrls;

type
  TfmStockAllocQtyAutoAdjust = class(TBaseInputGUI)
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    SctMain: TERPScript;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    TabCtl20: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pnlExport: TDNMPanel;
    pnlImport: TDNMPanel;
    sbImport: TScrollBox;
    sbExport: TScrollBox;
    DNMPanel2: TDNMPanel;
    chkProductQty: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SctMainBeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure TabCtl20Changing(Sender: TObject; var AllowChange: Boolean);
    procedure TabCtl20Change(Sender: TObject);
  private
    Tablename:String;
    Exportform:TfmExportStockAdjustment;
    Importform :TfmImportStockAdjustment;
    fiAdjustStatus:Integer;
    procedure CreateTempTable;
    procedure GenerateStockAllocQtyAutoAdjustData(Sender: TObject);
    procedure Populatedata;
    procedure setAdjustStatus(const Value: Integer);
    Procedure FixPQAAlloc;
  public
    Property AdjustStatus :Integer read fiAdjustStatus write setAdjustStatus;
  end;


implementation

uses CommonLib, CommonDbLib, LogLib, tcConst, ProductQtyLib, AppEnvironment,
  DNMLib;


{$R *.dfm}

procedure TfmStockAllocQtyAutoAdjust.FixPQAAlloc;
begin
  With SctMain do begin
    SQL.Clear;
    {This is for Asahi to delete the adjustemnts already made for using their last id in pqa and stocka adj tables}
    (*Qry to get the maxIDs
      Select 'pqa' , Max(PQAID) MaxId from tblpqa union all
      Select 'SM' , Max(StockmovementID) MaxId  from tblstockmovement union all
      Select 'SA' , Max(StockAdjustEntryID) MaxId  from tblstockadjustentry*)
    (*SQL.Add('delete from tblpqa where PQAID > 111840;');   //max(PQAID)
    SQL.Add('delete from tblpqadetails where PQAID > 111840;');//max(PQAID)
    SQL.Add('delete from tblstockadjustentry where StockAdjustEntryID > 2978;');//max(StockAdjustEntryID)
    SQL.Add('delete from tblstockadjustentrylines where StockAdjustEntryID > 2978;');//max(StockAdjustEntryID)
    SQL.Add('delete from tblstockmovement where StockmovementID > 3889;');//max(StockmovementID)
    SQL.Add('delete from tblstockmovementlines where StockmovementID > 3889;');//max(StockmovementID)*)

    {update bins to sum(SN) and batch to sum(Bin)/Sum(SN) based on the allocations}
    SQL.Add('create table if not exists erpfix_tblpqa'        + Replacestr( trim(Self.className), 'Tfm' , '') + ' like tblpqa;');
    SQL.Add('insert ignore into erpfix_tblpqa'                + Replacestr( trim(Self.className), 'Tfm' , '') + ' select * from  tblpqa;');
    SQL.Add('create table if not exists erpfix_tblpqadetails' + Replacestr( trim(Self.className), 'Tfm' , '') + ' like tblpqadetails;');
    SQL.Add('insert ignore into erpfix_tblpqadetails'         + Replacestr( trim(Self.className), 'Tfm' , '') + ' select * from  tblpqadetails;');

    SQL.Add('Drop table if exists tmp_3;');
    SQL.Add('create table tmp_3 like tblpqadetails;');

    SQL.Add('Drop table if exists tmp_2;');
    SQL.Add('create table tmp_2');

    SQL.Add('Select PartsId , pqa.pqaid , bins.PQADetailID as binID , bins.Qty as binQty, sum(SN.Qty) as SNQty ,');
    SQL.Add('bins.uomQty as binuomQty, sum(SN.uomQty) as SNuomQty');
    SQL.Add('from tblparts P');
    SQL.Add('inner join tblpqa pqa on p.partsId = PQa.productId');
    SQL.Add('inner join tblpqadetails bins on bins.pqaid = pqa.PQAID and bins.PQAType ="Bin"');
    SQL.Add('Left join tblpqadetails SN on SN.pqaid = bins.PQAID and ifnull(SN.ParentRef,"") = bins.GlobalRef and SN.PQAType ="SN"');
    SQL.Add('where Multiplebins ="T" and  SNTracking  ="T"');
    SQL.Add('group by PartsId , pqa.pqaid , bins.PQADetailID ;');

    SQL.Add('delete from tmp_2 where ifnull(binQty,0)= ifnull(SNQty,0) and ifnull(binuomQty,0)= ifnull(SNuomQty,0);');
    SQL.Add('insert ignore into tmp_3  select bins.* from tblpqadetails bins inner join tmp_2 t on bins.PQADetailID = t.binID ;');
    SQL.Add('update tblpqadetails bins inner join tmp_2 t on bins.PQADetailID = t.binID set bins.Qty = ifnull(t.snQty,0) , bins.uomQty = ifnull(t.snuomQty,0);');

    SQL.Add('Drop table if exists tmp_2;');
    SQL.Add('create table tmp_2');
    SQL.Add('Select PartsId , pqa.pqaid , Batch.PQADetailID as BatchID , Batch.Qty as BatchQty, sum(SN.Qty) as SNQty ,');
    SQL.Add('Batch.uomQty as BatchuomQty, sum(SN.uomQty) as SNuomQty');
    SQL.Add('from tblparts P');
    SQL.Add('inner join tblpqa pqa on p.partsId = PQa.productId');
    SQL.Add('inner join tblpqadetails Batch on Batch.pqaid = pqa.PQAID and Batch.PQAType ="Batch"');
    SQL.Add('Left join tblpqadetails SN on SN.pqaid = Batch.PQAID and ifnull(SN.ParentRef,"") = Batch.GlobalRef  and SN.PQAType ="SN"');
    SQL.Add('where Batch="T" and  Multiplebins ="F" and  SNTracking  ="T"');
    SQL.Add('group by PartsId , pqa.pqaid , Batch.PQADetailID ;');

    SQL.Add('delete from tmp_2 where ifnull(BatchQty,0)= ifnull(SNQty,0) and ifnull(BatchuomQty,0)= ifnull(SNuomQty,0);');
    SQL.Add('insert ignore into tmp_3  select Batch.* from tblpqadetails Batch inner join tmp_2 t on Batch.PQADetailID = t.BatchID ;');
    SQL.Add('update tblpqadetails Batch inner join tmp_2 t on Batch.PQADetailID = t.BatchID set Batch.Qty = ifnull(t.snQty,0) , Batch.uomQty = ifnull(t.snuomQty,0);');

    SQL.Add('Drop table if exists tmp_2;');
    SQL.Add('create table tmp_2');
    SQL.Add('Select PartsId , pqa.pqaid , Batch.PQADetailID as BatchID , Batch.Qty as BatchQty, sum(bins.Qty) as binsQty ,');
    SQL.Add('Batch.uomQty as BatchuomQty, sum(bins.uomQty) as binsuomQty');
    SQL.Add('from tblparts P');
    SQL.Add('inner join tblpqa pqa on p.partsId = PQa.productId');
    SQL.Add('inner join tblpqadetails Batch on Batch.pqaid = pqa.PQAID and Batch.PQAType ="Batch"');
    SQL.Add('Left join tblpqadetails bins on bins.pqaid = Batch.PQAID and ifnull(bins.ParentRef,"") = Batch.GlobalRef  and bins.PQAType ="Bin"');
    SQL.Add('where Batch="T" and  MultipleBins ="T"');
    SQL.Add('group by PartsId , pqa.pqaid , Batch.PQADetailID ;');

    SQL.Add('delete from tmp_2 where ifnull(BatchQty,0)= ifnull(binsQty,0) and ifnull(BatchuomQty,0)= ifnull(binsuomQty,0);');
    SQL.Add('insert ignore into tmp_3  select Batch.* from tblpqadetails Batch inner join tmp_2 t on Batch.PQADetailID = t.BatchID ;');
    SQL.Add('update tblpqadetails Batch inner join tmp_2 t on Batch.PQADetailID = t.BatchID set Batch.Qty = ifnull(t.binsQty,0) , Batch.uomQty = ifnull(t.binsuomQty,0);');
    Execute;
  end;
end;

procedure TfmStockAllocQtyAutoAdjust.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmStockAllocQtyAutoAdjust.FormCreate(Sender: TObject);
begin
  AdjustStatus:=0;
  inherited;
  Exportform:= TfmExportStockAdjustment(getcomponentbyClassname('TfmExportStockAdjustment' ,true ,self , false));
  Exportform.PnlMain.top:= 0;
  Exportform.PnlMain.Left := 0;
  Exportform.PnlMain.align := alnone;
  Exportform.PnlMain.Parent :=  sbExport; Exportform.FormShow(Exportform);
  Exportform.chkExcludeBinBatch.Checked := False;
  Exportform.chkExcludeBinBatch.Enabled := False;
  Exportform.DNMPanel3.Visible :=False;
  Exportform.DNMPanel1.Visible :=False;
  Exportform.GenerateTable := GenerateStockAllocQtyAutoAdjustData;

  Importform:=  TfmImportStockAdjustment(getcomponentbyClassname('TfmImportStockAdjustment' ,true ,self , false));
  if devmode then begin
    Importform.pnlTop.top:= 0;
    Importform.pnlTop.Left := 0;
    Importform.pnlTop.align := alnone;
    Importform.pnlTop.Parent :=  sbImport; Importform.FormShow(Importform);
  end;
  Importform.pnlGrid.top:= iif(devmode , Importform.pnlTop.height , 0);
  Importform.pnlGrid.Left := 0;
  Importform.pnlGrid.align := alnone;
  Importform.pnlGrid.Parent :=  sbImport; Importform.FormShow(Importform);
  Importform.FormShow(Exportform);
  Importform.pnlFooter.Visible := False;
  Importform.pnlTop.Visible := devmode;
  Importform.chkStockTake.checked := False;
  Importform.chkStockTake.Enabled := False;
  Importform.dtAdjustmentDate.Enabled := False;
  Importform.dtAdjustmentDate.Date := Date;
  Importform.chkIgnorebinbatchProducts.checked := False;
  Importform.chkIgnorebinbatchProducts.Enabled := False;
  Importform.dtAdjustmentDate.DateTime := Date;
  Tablename         := commondblib.GetUserTemporaryTableName('StockQtysLocationsvar');
  CreateTempTable;
end;

procedure TfmStockAllocQtyAutoAdjust.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;
end;


procedure TfmStockAllocQtyAutoAdjust.GenerateStockAllocQtyAutoAdjustData(Sender: TObject);
begin
  Populatedata;
end;
procedure TfmStockAllocQtyAutoAdjust.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmStockAllocQtyAutoAdjust.btnOKClick(Sender: TObject);
begin
  inherited;
  if AdjustStatus =0 then begin
      FixPQAalloc;
      if not Exportform.DoExport then exit;
      EditDb(Importform.qryImportDataMap);
      Importform.qryImportDataMapImportFileName.AsString:= Exportform.txtFileName.Text;
      PostDB(Importform.qryImportDataMap);
      TabCtl20.tabindex := 1;
      Importform.StockAdjumentDescription :=TitleLabel.caption +' - created on : ' + quotedstr(Formatdatetime(FormatSettings.shortDateformat , date)) +' by ' + quotedstr(Appenv.employee.employeename);
      AdjustStatus := 1;
      MessageDlgXP_Vista('Stock Data exported.  You can import them now.', mtWarning, [mbOK], 0);
  end else if AdjustStatus = 1 then begin
      Importform.btnRefresh.Click;
      //Importform.DoImportData(false);
      Importform.btnImport.click;
      //Freeandnil(Importform);
      //Freeandnil(Exportform);
      if Importform.StockImportOk then begin
        AdjustStatus := 0;
        TabCtl20.tabindex := 0;
      end;
  end;

end;

procedure TfmStockAllocQtyAutoAdjust.CreateTempTable;
begin
  With SctMain do begin
    SQL.clear;
    Connection := commondblib.GetSharedMyDacConnection;
    SQL.add('/*1*/Drop table if exists '+ tablename+';');
    SQL.add('/*2*/CREATE TABLE ' + tablename +' ( '+
	      ' ID                    INT(11) NOT NULL AUTO_INCREMENT, '+
        ' gLevel                INT(1) NOT NULL DEFAULT "0", '+
        ' PartsId               INT(11) NOT NULL DEFAULT "0", '+
        ' DepartmentID          INT(11) NULL DEFAULT NULL, '+
        ' UOMID                 INT(11) NULL DEFAULT NULL, '+
        ' UOM                   VARCHAR(50) NOT NULL DEFAULT "", '+
        ' UOMMultiplier         DOUBLE  NOT NULL DEFAULT "0", '+
        ' ProductName           VARCHAR(60) NULL DEFAULT NULL, '+
        ' ProductColumn1        VARCHAR(255) NULL DEFAULT NULL, '+
        ' ProductColumn2        VARCHAR(255) NULL DEFAULT NULL, '+
        ' ProductColumn3        VARCHAR(255) NULL DEFAULT NULL, '+
        ' PartsDescription      VARCHAR(255) NULL DEFAULT NULL, '+
        ' Classname             VARCHAR(255) NOT NULL DEFAULT "", '+
        ' Batchnumber           VARCHAR(100) DEFAULT "", '+
        ' TruckLoadNo           VARCHAR(10) DEFAULT "", '+
        ' ExpiryDate            VARCHAR(10) DEFAULT "", '+
        ' BatchExpiryDate       DATETIME DEFAULT 0, '+
        ' binLocation           VARCHAR(30) DEFAULT "", '+
        ' Binnumber             VARCHAR(30) DEFAULT "", '+
        ' Serialnumber          VARCHAR(100) DEFAULT "", '+
        ' Batch                 ENUM("T","F") DEFAULT "F", '+
        ' Bin                   ENUM("T","F") DEFAULT "F", '+
        ' SN                    ENUM("T","F") DEFAULT "F", '+
        ' AvailUOMQty           DOUBLE  NULL DEFAULT NULL, '+
        ' AvailQty              DOUBLE  NULL DEFAULT NULL, '+
        ' InstockUOMQty         DOUBLE  NULL DEFAULT NULL, '+
        ' InstockQty            DOUBLE  NULL DEFAULT NULL, '+
        ' SOUOMQty              DOUBLE  NULL DEFAULT NULL, '+
        ' SOQty                 DOUBLE  NULL DEFAULT NULL, '+
        ' AllocAvailUOMQty      DOUBLE  NULL DEFAULT NULL, '+
        ' AllocAvailQty         DOUBLE  NULL DEFAULT NULL, '+
        ' AllocInstockUOMQty    DOUBLE  NULL DEFAULT NULL, '+
        ' AllocInstockQty       DOUBLE  NULL DEFAULT NULL, '+
        ' AllocSOUOMQty         DOUBLE  NULL DEFAULT NULL, '+
        ' AllocSOQty            DOUBLE  NULL DEFAULT NULL, '+
        ' Cost                  DOUBLE  NULL DEFAULT NULL, '+
        ' Value                 DOUBLE  NULL DEFAULT NULL, '+
        ' AvailbatchQty         DOUBLE  NULL DEFAULT NULL, '+
        ' AvailUOMbatchQty      Double  NULL DEFAULT NULL, '+
        ' InstockbatchQty       DOUBLE  NULL DEFAULT NULL, '+
        ' InstockUOMbatchQty    DOUBLE  NULL DEFAULT NULL, '+
        ' SObatchQty            DOUBLE  NULL DEFAULT NULL, '+
        ' SOUOMbatchQty         DOUBLE  NULL DEFAULT NULL, '+
        ' AvailBinQty           DOUBLE  NULL DEFAULT NULL, '+
        ' AvailUOMBinQty        DOUBLE  NULL DEFAULT NULL, '+
        ' InstockBinQty         DOUBLE  NULL DEFAULT NULL, '+
        ' InstockUOMBinQty      DOUBLE  NULL DEFAULT NULL, '+
        ' SOBinQty              DOUBLE  NULL DEFAULT NULL, '+
        ' SOUOMBinQty           DOUBLE  NULL DEFAULT NULL, '+
        ' AvailSNQty            DOUBLE  NULL DEFAULT NULL, '+
        ' AvailUOMSNQty         DOUBLE  NULL DEFAULT NULL, '+
        ' InstockSNQty          DOUBLE  NULL DEFAULT NULL, '+
        ' InstockUOMSNQty       DOUBLE  NULL DEFAULT NULL, '+
        ' SOSNQty               DOUBLE  NULL DEFAULT NULL, '+
        ' SOUOMSNQty            DOUBLE  NULL DEFAULT NULL, '+
        ' Alloctype             INT(1) ,'+
        ' Mismatchtype          INT(1),'+
        ' PRIMARY KEY (`ID`), '+
        ' Index AllFlds (PartsId,DepartmentID,UOMID,Batchnumber,TruckLoadNo,BatchExpiryDate,binLocation,Binnumber), '+
        ' INDEX `AllpartFlds` (`PartsId`, `DepartmentID`, `UOMID`), '+
        ' INDEX `AllAllocFlds` (`Batchnumber`, `TruckLoadNo`, `ExpiryDate`, `BatchExpiryDate`, `binLocation`, `Binnumber`) '+
        ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');
        Execute;
  end;
end;
procedure TfmStockAllocQtyAutoAdjust.Populatedata;
Function InstockQty:Boolean;
begin
  result := Exportform.optQtytype.itemindex =0;
end;
Function QtyType:String;
begin
  if InstockQty then result := 'In-Stock' else result := 'Available';
end;
begin
  With SctMain do begin
    SQL.clear;
    SQL.add('/*1*/truncate table '+ tablename+';');
            SQL.add('/*2*/Drop table if exists  '+ tablename + '1;Create  table   '+ tablename + '1 like ' + Tablename +';');
            SQL.add('/*3*/Drop table if exists  '+ tablename + '2;Create  table   '+ tablename + '2 like ' + Tablename +';');
            SQL.add('/*3*/Drop table if exists  '+ tablename + '3;Create  table   '+ tablename + '3 like ' + Tablename +';');
            SQL.add('/*4*/insert into '+ tablename + '1 (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,'+
                                                          ' Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,binLocation,Binnumber,Serialnumber,'+
                                                          ' AvailUOMQty,AvailQty,InstockUOMQty,InstockQty,SOUOMQty,SOQty,Cost,Value) ' +
                                                          ProductQtyLib.StockQtySummary(True , 0, Exportform.ExportClassId , Date ) +';');

            SQL.add('/*6*/insert into '+ tablename + ' (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,'+
                                                          ' Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,binLocation,Binnumber,Serialnumber,'+
                                                          ' AvailUOMQty,AvailQty,InstockUOMQty,InstockQty,SOUOMQty,SOQty,Cost,Value) '+
                                                          ' select distinct PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,'+
                                                          ' Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,binLocation,Binnumber,Serialnumber,'+
                                                          ' AvailUOMQty,AvailQty,InstockUOMQty,InstockQty,SOUOMQty,SOQty,Cost,Value from  '+ tablename + '1;');


            SQL.add('/*5.1*/insert into '+ tablename + '2 (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,'+
                                                          ' Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,binLocation,Binnumber,Serialnumber,'+
                                                          ' AllocAvailUOMQty,AllocAvailQty,AllocInstockUOMQty,AllocInstockQty,AllocSOUOMQty,AllocSOQty,Cost,Value) ' +
                                                          ProductQtyLib.StockQtyDetails(True , 0, Exportform.ExportClassId  , DAte , False ) +';');
            SQL.add('/*5.2*/insert into '+ tablename + ' (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,'+
                                                          ' Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,'+
                                                          ' AvailUOMQty,AvailQty,InstockUOMQty,InstockQty,SOUOMQty,SOQty,'+
                                                          ' AllocAvailUOMQty,AllocAvailQty,AllocInstockUOMQty,AllocInstockQty,AllocSOUOMQty,AllocSOQty, Cost,Value ) '+
                                                          ' select distinct T2.PartsId,T2.DepartmentID,T2.UOMID,T2.UOM,T2.UOMMultiplier,T2.gLevel,T2.ProductName,T2.ProductColumn1,T2.ProductColumn2,T2.ProductColumn3,T2.PartsDescription,'+
                                                          ' T2.Classname,T2.Batchnumber,T2.TruckLoadNo,T2.ExpiryDate,T2.BatchExpiryDate,'+
                                                          ' T1.AvailUOMQty,T1.AvailQty,T1.InstockUOMQty,T1.InstockQty,T1.SOUOMQty,T1.SOQty,'+
                                                          ' T2.AllocAvailUOMQty,T2.AllocAvailQty,T2.AllocInstockUOMQty,T2.AllocInstockQty,T2.AllocSOUOMQty,T2.AllocSOQty,'+
                                                          ' T2.Cost,T2.Value '+
                                                          ' from  '+ tablename + ' T1 inner join ' +tablename +'2 T2 on T1.PartsId = T2.PartsId and T1.DepartmentID = T2.DepartmentID and T1.UOMID = T2.UOMID;');
            SQL.add('/*5.3*/TRuncate '+ tablename + '2;');
            SQL.add('/*5.4*/insert into '+ tablename + '2 (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,'+
                                                          ' Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,binLocation,Binnumber,Serialnumber,'+
                                                          ' AllocAvailUOMQty,AllocAvailQty,AllocInstockUOMQty,AllocInstockQty,AllocSOUOMQty,AllocSOQty,Cost,Value) ' +
                                                          ProductQtyLib.StockQtyExtraDetails(True , 0, Exportform.ExportClassId  , Date , False ) +';');
            SQL.add('/*5.2*/delete from  '+ tablename + '2 where ifnull(binlocation,"")="";');
            SQL.add('/*5.5*/insert into '+ tablename + ' (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,'+
                                                          ' Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,binlocation,binnumber,'+
                                                          ' AvailUOMQty,AvailQty,InstockUOMQty,InstockQty,SOUOMQty,SOQty,'+
                                                          ' AllocAvailUOMQty,AllocAvailQty,AllocInstockUOMQty,AllocInstockQty,AllocSOUOMQty,AllocSOQty, Cost,Value ) '+
                                                          ' select distinct T2.PartsId,T2.DepartmentID,T2.UOMID,T2.UOM,T2.UOMMultiplier,T2.gLevel,T2.ProductName,T2.ProductColumn1,T2.ProductColumn2,T2.ProductColumn3,T2.PartsDescription,'+
                                                          ' T2.Classname,T2.Batchnumber,T2.TruckLoadNo,T2.ExpiryDate,T2.BatchExpiryDate,T2.binlocation,T2.binnumber,'+
                                                          ' T1.AvailUOMQty,T1.AvailQty,T1.InstockUOMQty,T1.InstockQty,T1.SOUOMQty,T1.SOQty,'+
                                                          ' T2.AllocAvailUOMQty,T2.AllocAvailQty,T2.AllocInstockUOMQty,T2.AllocInstockQty,T2.AllocSOUOMQty,T2.AllocSOQty,'+
                                                          ' T2.Cost,T2.Value '+
                                                          ' from  '+ tablename + ' T1 inner join ' +tablename +'2 T2 on T1.PartsId = T2.PartsId and T1.DepartmentID = T2.DepartmentID and T1.UOMID = T2.UOMID;');

            SQL.add('/*5.6*/TRuncate '+ tablename + '2;');
            SQL.add('/*5.7*/insert into '+ tablename + '2 (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,'+
                                                          ' Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,binLocation,Binnumber,Serialnumber,'+
                                                          ' AllocAvailUOMQty,AllocAvailQty,AllocInstockUOMQty,AllocInstockQty,AllocSOUOMQty,AllocSOQty,Cost,Value) ' +
                                                          ProductQtyLib.StockQtyDetailswithSno(True , 0, Exportform.ExportClassId  , Date , true ) +';');
            SQL.add('/*5.2*/delete from  '+ tablename + '2 where ifnull(serialnumber,"")="";');
            SQL.add('/*5.8*/update '+ tablename + '2 Set AllocAvailUOMQty   =0 where ifnull(AllocAvailUOMQty,0)   <=0  and ifnull(Serialnumber,"")<>"" ;'+
                           'update '+ tablename + '2 Set AllocAvailUOMQty   =1 where ifnull(AllocAvailUOMQty,0)   >=1  and ifnull(Serialnumber,"")<>"" ;'+
                           'update '+ tablename + '2 Set AllocAvailQty      =0 where ifnull(AllocAvailQty,0)      <=0  and ifnull(Serialnumber,"")<>"" ;'+
                           'update '+ tablename + '2 Set AllocAvailQty      =1 where ifnull(AllocAvailQty,0)      >=1  and ifnull(Serialnumber,"")<>"" ;'+

                           'update '+ tablename + '2 Set AllocInstockUOMQty =0 where ifnull(AllocInstockUOMQty,0) <=0  and ifnull(Serialnumber,"")<>"" ;'+
                           'update '+ tablename + '2 Set AllocInstockUOMQty =1 where ifnull(AllocInstockUOMQty,0) >=1  and ifnull(Serialnumber,"")<>"" ;'+
                           'update '+ tablename + '2 Set AllocInstockQty    =0 where ifnull(AllocInstockQty,0)    <=0  and ifnull(Serialnumber,"")<>"" ;'+
                           'update '+ tablename + '2 Set AllocInstockQty    =1 where ifnull(AllocInstockQty,0)    >=1  and ifnull(Serialnumber,"")<>"" ;'+

                           'update '+ tablename + '2 Set AllocSOUOMQty      =0 where ifnull(AllocSOUOMQty,0)      <=0  and ifnull(Serialnumber,"")<>"" ;'+
                           'update '+ tablename + '2 Set AllocSOUOMQty      =1 where ifnull(AllocSOUOMQty,0)      >=1  and ifnull(Serialnumber,"")<>"" ;'+
                           'update '+ tablename + '2 Set AllocSOQty         =0 where ifnull(AllocSOQty,0)         <=0  and ifnull(Serialnumber,"")<>"" ;'+
                           'update '+ tablename + '2 Set AllocSOQty         =1 where ifnull(AllocSOQty,0)         >=1  and ifnull(Serialnumber,"")<>"" ;'+
                           'Delete from '+tablename +'2 where ifnull(AllocAvailUOMQty   ,0)=0 '+
                                                        ' and ifnull(AllocAvailQty      ,0)=0 '+
                                                        ' and ifnull(AllocInstockUOMQty ,0)=0 '+
                                                        ' and ifnull(AllocInstockQty    ,0)=0 '+
                                                        ' and ifnull(AllocSOUOMQty      ,0)=0 '+
                                                        ' and ifnull(AllocSOQty         ,0)=0;' );

            SQL.add('/*5.9*/insert into '+ tablename + ' (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,'+
                                                          ' Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,binlocation,binnumber,serialnumber,'+
                                                          ' AvailUOMQty,AvailQty,InstockUOMQty,InstockQty,SOUOMQty,SOQty,'+
                                                          ' AllocAvailUOMQty,AllocAvailQty,AllocInstockUOMQty,AllocInstockQty,AllocSOUOMQty,AllocSOQty, Cost,Value ) '+
                                                          ' select distinct T2.PartsId,T2.DepartmentID,T2.UOMID,T2.UOM,T2.UOMMultiplier,T2.gLevel,T2.ProductName,T2.ProductColumn1,T2.ProductColumn2,T2.ProductColumn3,T2.PartsDescription,'+
                                                          ' T2.Classname,T2.Batchnumber,T2.TruckLoadNo,T2.ExpiryDate,T2.BatchExpiryDate,T2.binlocation,T2.binnumber,t2.serialnumber,'+
                                                          ' T1.AvailUOMQty,T1.AvailQty,T1.InstockUOMQty,T1.InstockQty,T1.SOUOMQty,T1.SOQty,'+
                                                          ' T2.AllocAvailUOMQty,T2.AllocAvailQty,T2.AllocInstockUOMQty,T2.AllocInstockQty,T2.AllocSOUOMQty,T2.AllocSOQty,'+
                                                          ' T2.Cost,T2.Value '+
                                                          ' from  '+ tablename + ' T1 inner join ' +tablename +'2 T2 on T1.PartsId = T2.PartsId and T1.DepartmentID = T2.DepartmentID and T1.UOMID = T2.UOMID;');

          SQL.add('/*6.1*/Update '+tablename +' t inner join tblparts P on P.PartsId = T.PartsId Set T.batch = P.Batch, T.Bin = P.MultipleBins, T.sn = P.SNTracking;');


            SQL.add(' /*9*/update '+ tablename +' set Batchnumber     = ""            where  ifnull(Batchnumber     ,"")="";'+
                         ' update '+ tablename +' set BatchExpirydate = "1899/12/30"  where  ifnull(BatchExpirydate ,0) =0 ;'+
                         ' update '+ tablename +' set TruckLoadNo     = ""            where  ifnull(TruckLoadNo     ,"")="";'+
                         ' update '+ tablename +' set binlocation     = ""            where  ifnull(binlocation     ,"")="";'+
                         ' update '+ tablename +' set Binnumber       = ""            where  ifnull(Binnumber       ,"")="";'+
                         ' update '+ tablename +' set Serialnumber    = ""            where  ifnull(Serialnumber    ,"")="";'+
                         ' update '+ tablename +' set AvailQty        = 0.0           where  ifnull(AvailQty        ,0) =0;'+
                         ' update '+ tablename +' set AvailUOMQty     = 0.0           where  ifnull(AvailUOMQty     ,0) =0;'+
                         ' update '+ tablename +' set InstockUOMQty   = 0.0           where  ifnull(InstockUOMQty   ,0) =0;'+
                         ' update '+ tablename +' set InstockQty      = 0.0           where  ifnull(InstockQty      ,0) =0;'+
                         ' update '+ tablename +' set SOUOMQty        = 0.0           where  ifnull(SOUOMQty        ,0) =0;'+
                         ' update '+ tablename +' set SOQty           = 0.0           where  ifnull(SOQty           ,0) =0;'+
                         ' update '+ tablename +' set AllocAvailQty        = 0.0      where  ifnull(AllocAvailQty        ,0) =0;'+
                         ' update '+ tablename +' set AllocAvailUOMQty     = 0.0      where  ifnull(AllocAvailUOMQty     ,0) =0;'+
                         ' update '+ tablename +' set AllocInstockUOMQty   = 0.0      where  ifnull(AllocInstockUOMQty   ,0) =0;'+
                         ' update '+ tablename +' set AllocInstockQty      = 0.0      where  ifnull(AllocInstockQty      ,0) =0;'+
                         ' update '+ tablename +' set AllocSOUOMQty        = 0.0      where  ifnull(AllocSOUOMQty        ,0) =0;'+
                         ' update '+ tablename +' set AllocSOQty           = 0.0      where  ifnull(AllocSOQty           ,0) =0;');
            SQL.add(' /*10*/delete from '+ tablename +' where gLevel >=2 '+
                                                            ' and ifnull(Batchnumber,"")=""  '+
                                                            ' and ifnull(BAtchExpirydate,0)<="1900-01-01" '+
                                                            ' and ifnull(TruckLoadNo , "") = ""  '+
                                                            ' and ifnull(binlocation,"")=""  '+
                                                            ' and ifnull(Binnumber,"")=""  '+
                                                            ' and  ifnull(Serialnumber,"") = ""  '+
                                                            ' and ifnull(AllocAvailQty,0) =0;');


            SQL.add('/*12.1*/Update '+ tablename +                          ' Set   AvailSNQty      = 0 , '+
                                                                                  ' AvailUOMSNQty   = 0 ,  '+
                                                                                  ' InstockSNQty    = 0 ,  '+
                                                                                  ' InstockUOMSNQty = 0 ,  '+
                                                                                  ' SOSNQty         = 0 ,  '+
                                                                                  ' SOUOMSNQty      = 0 '+
                                                                                  ' where SN="T" and serialnumber = "";');
            SQL.add('/*13*/Drop table if exists '+ tablename +'1;');
            SQL.add('/*14*/Create table '+ tablename +'1 Select PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate , Binlocation , Binnumber , '+
                                                             ' sum(AllocAvailUOMQty)   as AvailUOMQty ,  '+
                                                             ' Sum(AllocAvailQty)      as AvailQty ,  '+
                                                             ' sum(AllocInstockUOMQty) as InstockUOMQty ,  '+
                                                             ' sum(AllocInstockQty)    as InstockQty ,  '+
                                                             ' Sum(AllocSOUOMQty)      as SOUOMQty ,  '+
                                                             ' sum(AllocSOQty)         as SOQty from '+tablename +
                                                             ' Where ifnull(Serialnumber,"")<> "" '+
                                                             ' group by  PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate , Binlocation , Binnumber;');
            SQL.add('/*15*/ALTER TABLE ' +tablename+'1  		ADD INDEX `AllFlds`  (PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate , Binlocation , Binnumber);');
            SQL.add('/*16*/Update '+ tablename +' T inner join '+ tablename +'1 as T1 on T.PartsID and T1.PartsID AND ' +
                                                                                  ' T.DepartmentID  = T1.DepartmentID and ' +
                                                                                  ' T.UOMID         = T1.UOMID and ' +
                                                                                  ' T.Batchnumber   = T1.Batchnumber and ' +
                                                                                  ' T.TruckLoadNo   = T1.TruckLoadNo and ' +
                                                                                  ' T.BatchExpiryDate    = T1.BatchExpiryDate and ' +
                                                                                  ' T.Binlocation   = T1.Binlocation and ' +
                                                                                  ' T.Binnumber     = T1.Binnumber ' +
                                                                              ' Set T.AvailSNQty      = T1.AvailQty , '+
                                                                                  ' T.AvailUOMSNQty   = T1.AvailUOMQty ,  '+
                                                                                  ' T.InstockSNQty    = T1.InstockQty ,  '+
                                                                                  ' T.InstockUOMSNQty = T1.InstockUOMQty ,  '+
                                                                                  ' T.SOSNQty         = T1.SOQty ,  '+
                                                                                  ' T.SOUOMSNQty      = T1.SoUOMQty'+
                                                                              ' Where ifnull(T.Serialnumber,"")= "";');

            SQL.add('/*16.1*/Update '+ tablename +                          ' Set   AvailBinQty      = 0 , '+
                                                                                  ' AvailUOMBinQty   = 0 ,  '+
                                                                                  ' InstockBinQty    = 0 ,  '+
                                                                                  ' InstockUOMBinQty = 0 ,  '+
                                                                                  ' SOBinQty         = 0 ,  '+
                                                                                  ' SOUOMBinQty      = 0 '+
                                                                                  ' Where (Bin ="T" or SN="T") and  ifnull(Binlocation, "")= "" and  ifnull(Serialnumber,"")= "";');
            SQL.add('/*17*/Drop table if exists '+ tablename +'1;');
            SQL.add('/*18*/Create table '+ tablename +'1 Select PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate  , '+
                                                             ' sum(ifnull(AvailUOMSNQty   ,AllocAvailUOMQty))   as AvailUOMQty ,  '+
                                                             ' Sum(ifnull(AvailSNQty      ,AllocAvailQty))      as AvailQty ,  '+
                                                             ' sum(ifnull(InstockUOMSNQty ,AllocInstockUOMQty)) as InstockUOMQty ,  '+
                                                             ' sum(ifnull(InstockSNQty    ,AllocInstockQty) )   as InstockQty ,  '+
                                                             ' Sum(ifnull(SOUOMSNQty      ,AllocSOUOMQty))      as SOUOMQty ,  '+
                                                             ' sum(ifnull(SOSNQty         ,AllocSOQty))         as SOQty from '+tablename +
                                                             ' Where (bin ="T" and ifnull(Binlocation, "")<> "" and ifnull(Serialnumber ,"")="") or'+
                                                                    '(bin ="F" and ifnull(Serialnumber,"")<> "" )'+
                                                             ' group by  PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate ;');
            SQL.add('/*19*/ALTER TABLE ' +tablename+'1  		ADD INDEX `AllFlds`  (PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate );');
            SQL.add('/*20*/Update '+ tablename +' T inner join '+ tablename +'1 as T1 on T.PartsID and T1.PartsID AND ' +
                                                                                  ' T.DepartmentID  = T1.DepartmentID and ' +
                                                                                  ' T.UOMID         = T1.UOMID and ' +
                                                                                  ' T.Batchnumber   = T1.Batchnumber and ' +
                                                                                  ' T.TruckLoadNo   = T1.TruckLoadNo and ' +
                                                                                  ' T.BatchExpiryDate    = T1.BatchExpiryDate ' +
                                                                              ' Set T.AvailBinQty      = T1.AvailQty , '+
                                                                                  ' T.AvailUOMBinQty   = T1.AvailUOMQty ,  '+
                                                                                  ' T.InstockBinQty    = T1.InstockQty ,  '+
                                                                                  ' T.InstockUOMBinQty = T1.InstockUOMQty ,  '+
                                                                                  ' T.SOBinQty         = T1.SOQty ,  '+
                                                                                  ' T.SOUOMBinQty      = T1.SoUOMQty'+
                                                                              ' Where ifnull(T.Binlocation, "")= "" and  ifnull(T.Serialnumber,"")= "";');

            SQL.add('/*20.1*/Update '+ tablename +
                                                                              ' Set AvailBatchQty      = 0 , '+
                                                                                  ' AvailUOMBatchQty   = 0 , '+
                                                                                  ' InstockBatchQty    = 0 , '+
                                                                                  ' InstockUOMBatchQty = 0 , '+
                                                                                  ' SOBatchQty         = 0 , '+
                                                                                  ' SOUOMBatchQty      = 0  '+
                                                                                  ' where (Batch ="T" or Bin="T" or SN="T") and serialnumber = "" and Binlocation ="" and Batchnumber ="";');

            SQL.add('/*21*/Drop table if exists '+ tablename +'1;');
            SQL.add('/*22*/Create table '+ tablename +'1 Select PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate  , '+
                                                             ' sum(ifnull(AvailUOMBinQty   ,ifnull(AvailUOMSNQty   ,AllocAvailUOMQty)))   as AvailUOMQty ,  '+
                                                             ' Sum(ifnull(AvailBinQty      ,ifnull(AvailSNQty      ,AllocAvailQty)))      as AvailQty ,  '+
                                                             ' sum(ifnull(InstockUOMBinQty ,ifnull(InstockUOMSNQty ,AllocInstockUOMQty))) as InstockUOMQty ,  '+
                                                             ' sum(ifnull(InstockBinQty    ,ifnull(InstockSNQty    ,AllocInstockQty)))    as InstockQty ,  '+
                                                             ' Sum(ifnull(SOUOMBinQty      ,ifnull(SOUOMSNQty      ,AllocSOUOMQty)))      as SOUOMQty ,  '+
                                                             ' sum(ifnull(SOBinQty         ,ifnull(SOSNQty         ,AllocSOQty)))         as SOQty from '+tablename +
                                                             ' Where (batch ="T" and ifnull(batchnumber , "")<> "") or  '+
                                                                    '(batch ="F" and bin ="T" and ifnull(Binlocation, "")<> "" and ifnull(Serialnumber,"")="") or   '+
                                                                    '(batch ="F"  and bin ="F" and ifnull(Serialnumber,"")<> "" )  '+
                                                             ' group by  PartsID, DepartmentID , UOMID  ;');
            SQL.add('/*23*/ALTER TABLE ' +tablename+'1  		ADD INDEX `AllFlds`  (PartsID, DepartmentID , UOMID  );');
            SQL.add('/*24*/Update '+ tablename +' T inner join '+ tablename +'1 as T1 on T.PartsID and T1.PartsID AND ' +
                                                                                  ' T.DepartmentID  = T1.DepartmentID and ' +
                                                                                  ' T.UOMID         = T1.UOMID  ' +
                                                                              ' Set T.AvailBatchQty      = T1.AvailQty , '+
                                                                                  ' T.AvailUOMBatchQty   = T1.AvailUOMQty ,  '+
                                                                                  ' T.InstockBatchQty    = T1.InstockQty ,  '+
                                                                                  ' T.InstockUOMBatchQty = T1.InstockUOMQty ,  '+
                                                                                  ' T.SOBatchQty         = T1.SOQty ,  '+
                                                                                  ' T.SOUOMBatchQty      = T1.SoUOMQty'+
                                                                              ' Where ifnull(T.Batchnumber, "")= "" and ifnull(T.Binlocation, "")= "" and  ifnull(T.Serialnumber,"")= "";');
            SQL.add('/*25*/Drop table if exists '+ tablename +'1;');
            SQL.add('/*26*/ update '+ Tablename +' Set Alloctype = 1 where glevel =1;');
            SQL.add('/*27*/ update '+ Tablename +' Set Alloctype = 2 where glevel >1 and batch  = "T" and batchnumber <> "" and binlocation ="" and serialnumber ="";');
            SQL.add('/*28*/ update '+ Tablename +' Set Alloctype = 3 where glevel >1 and bin    = "T" and binlocation <>"" and serialnumber ="";');
            SQL.add('/*29*/ update '+ Tablename +' Set Alloctype = 4 where glevel >1 and SN     = "T" and serialnumber<>"";');
            SQL.add('/*30*/ update '+ Tablename +' Set Mismatchtype  = 0;');
            SQL.add('/*31*/ update '+ Tablename +' Set Mismatchtype  = alloctype/*Mismatchtype + 1*/ where  alloctype =1 '+
                                                                            '  and (AvailBatchQty      <> AvailQty      OR '+
                                                                                  ' AvailUOMBatchQty   <> AvailUOMQty   OR  '+
                                                                                  ' InstockBatchQty    <> InstockQty    OR  '+
                                                                                  ' InstockUOMBatchQty <> InstockUOMQty OR  '+
                                                                                  ' SOBatchQty         <> SOQty         OR  '+
                                                                                  ' SOUOMBatchQty      <> SoUOMQty);');

            SQL.add('/*32*/ update '+ Tablename +' Set Mismatchtype  = alloctype/*Mismatchtype + 2*/ where  alloctype =2 '+
                                                                            '  and (AvailBinQty      <> AllocAvailQty      OR '+
                                                                                  ' AvailUOMBinQty   <> AllocAvailUOMQty   OR  '+
                                                                                  ' InstockBinQty    <> AllocInstockQty    OR  '+
                                                                                  ' InstockUOMBinQty <> AllocInstockUOMQty OR  '+
                                                                                  ' SOBinQty         <> AllocSOQty         OR  '+
                                                                                  ' SOUOMBinQty      <> AllocSoUOMQty);');
            SQL.add('/*33*/ update '+ Tablename +' Set Mismatchtype  = alloctype/*Mismatchtype + 4*/ where  alloctype =3 '+
                                                                            '  and (AvailSNQty      <> AllocAvailQty      OR '+
                                                                                  ' AvailUOMSNQty   <> AllocAvailUOMQty   OR  '+
                                                                                  ' InstockSNQty    <> AllocInstockQty    OR  '+
                                                                                  ' InstockUOMSNQty <> AllocInstockUOMQty OR  '+
                                                                                  ' SOSNQty         <> AllocSOQty         OR  '+
                                                                                  ' SOUOMSNQty      <> AllocSoUOMQty);');


            SQL.add('/*34*/ truncate tblstockadjustmentimportexport;');
            if chkProductQty.Checked then
              SQL.add('/*35*/ insert ignore into tblstockadjustmentimportexport '+
                        ' (DepartmentID,UOMID,UOM,UOMMultiplier,PartsId,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,DeptName,AccountName,AccountGroup,'+
                        ' Batchnumber,ExpiryDate,TruckLoadNo,BatchExpiryDate,Binlocation,Binnumber,Serialnumber,UOMQty,Finalcount,AllocFinalcount,Qty,InstockUOMQty,InstockQty,Cost,Value,Active,'+
                        ' Seqno,ProductBarCode,Batch,Bins,SN,QtyType) '+
                        ' Select DepartmentID	, UOMID	, UOM	, UOMMultiplier	, PartsId	, gLevel	, ProductName	, ProductColumn1	, ProductColumn2	, ProductColumn3	, PartsDescription, classname DeptName	,'+
                        ' null AccountName	,null AccountGroup, Batchnumber	, ExpiryDate	, TruckLoadNo	, BatchExpiryDate	, Binlocation	, Binnumber	, Serialnumber	, ' +
                        iif(InstockQty , 'InstockUOMQty' , 'AvailUOMQty')+' as UOMQty	, ' +
                        iif(InstockQty , 'InstockBatchQty' , 'AvailBatchQty')+' as Finalcount	, '+ ' 0 as AllocFinalcount	, ' +
                        iif(InstockQty , 'instockQty' , 'AvailQty')+' as Qty	, InstockUOMQty	, InstockQty	, null Cost	, null Value	, "T" Active	, 1 as Seqno	, null ProductBarCode	, Batch	, bin as Bins	, SN	, ' + Quotedstr(QtyType) +' as QtyType '+
                        ' from ' +tablename +' where mismatchtype in (1 );');
                        //' from ' +tablename +' where mismatchtype in (1 ,3 , 7);');

            SQL.add('/*36*/ insert ignore into tblstockadjustmentimportexport '+
                        ' (DepartmentID,UOMID,UOM,UOMMultiplier,PartsId,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,DeptName,AccountName,AccountGroup,'+
                        ' Batchnumber,ExpiryDate,TruckLoadNo,BatchExpiryDate,Binlocation,Binnumber,Serialnumber,UOMQty,Finalcount,AllocFinalcount,Qty,InstockUOMQty,InstockQty,Cost,Value,Active,'+
                        ' Seqno,ProductBarCode,Batch,Bins,SN,QtyType) '+
                        ' Select DepartmentID	, UOMID	, UOM	, UOMMultiplier	, PartsId	,gLevel	,ProductName	,ProductColumn1	,ProductColumn2	,ProductColumn3	,PartsDescription,classname DeptName	, '+
                        ' null AccountName	,null AccountGroup,Batchnumber	,ExpiryDate	,TruckLoadNo	,BatchExpiryDate	,Binlocation	,Binnumber	,Serialnumber	,' +
                         iif(InstockQty , 'InstockUOMQty' , 'AvailUOMQty')+' as UOMQty	, '+
                         iif(InstockQty , 'InstockUOMQty' , 'AvailUOMQty')+'  as Finalcount	,' +
                         iif(InstockQty , 'InstockBinQty' , 'AvailBinQty')+' as AllocFinalcount	,' +
                         iif(InstockQty , 'instockQty' , 'AvailQty')+' as Qty	,InstockUOMQty	,InstockQty	,null Cost	,null Value	,"T" Active	,2 as Seqno	,null ProductBarCode	, '+
                        ' Batch	,bin as Bins	,SN	,' + Quotedstr(QtyType) +' as QtyType '+
                        ' from ' +tablename +' where mismatchtype in (2);');
                        //' from ' +tablename +' where mismatchtype in (2,3,6,7);');

            SQL.add('/*37*/ insert ignore into tblstockadjustmentimportexport '+
                        ' (DepartmentID,UOMID,UOM,UOMMultiplier,PartsId,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,DeptName,AccountName,AccountGroup,'+
                        ' Batchnumber,ExpiryDate,TruckLoadNo,BatchExpiryDate,Binlocation,Binnumber,Serialnumber,UOMQty,Finalcount,AllocFinalcount,Qty,InstockUOMQty,InstockQty,Cost,Value,Active,'+
                        ' Seqno,ProductBarCode,Batch,Bins,SN,QtyType) '+
                        ' Select DepartmentID	,UOMID	,UOM	,UOMMultiplier	,PartsId	,gLevel	,ProductName	,ProductColumn1	,ProductColumn2	,ProductColumn3	,PartsDescription,classname DeptName	,null AccountName	, '+
                        ' null AccountGroup,Batchnumber	,ExpiryDate	,TruckLoadNo	,BatchExpiryDate	,Binlocation	,Binnumber	,Serialnumber	,' +
                        iif(InstockQty , 'InstockUOMQty' , 'AvailUOMQty')+' as UOMQty	,' +
                        iif(InstockQty , 'InstockUOMQty' , 'AvailUOMQty')+'  as Finalcount	,' +
                        iif(InstockQty , 'InstockSNQty' , 'AvailSNQty')+' as AllocFinalcount	, '+
                        iif(InstockQty , 'instockQty' , 'AvailQty')+' as Qty	,InstockUOMQty	,InstockQty	,null Cost	,null Value	,"T" Active	,3 as Seqno	,null ProductBarCode	,Batch	,bin as Bins	,SN	,' + Quotedstr(QtyType) +' as QtyType '+
                        ' from ' +tablename +' where mismatchtype in (3);');
                        //' from ' +tablename +' where mismatchtype in (4,5,6,7);');
          {
          Mismatchtype
          1: ProductQty <> allocationQty : Adjsut productQty
          2: Batch Qty <> Bin/Sr Qty :Adjust batchQty
          3:ProductQty <> allocationQty AND Batch Qty <> Bin/Sr Qty : Adjsut productQty and batchQty
          4:Bin Qty <> Sr Qty : Adjsut binQty
          5:ProductQty <> SR qty AND Batch Qty <> Bin/Sr Qty : Adjsut productQty and batchQty
          }

    DoshowProgressbar(SQL.Count, WAITMSG);
    try
      clog(SQL.Text);
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;
  inherited;
end;
procedure TfmStockAllocQtyAutoAdjust.SctMainBeforeExecute(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  inherited;
  DoStepProgressbar;
end;

procedure TfmStockAllocQtyAutoAdjust.setAdjustStatus(const Value: Integer);
begin
  fiAdjustStatus := Value;
  if value = 0 then btnOK.Caption := 'Export' else btnOK.Caption := 'Import';
end;

procedure TfmStockAllocQtyAutoAdjust.TabCtl20Change(Sender: TObject);
begin
  inherited;
  if devmode then AdjustStatus :=TabCtl20.TabIndex;
end;

procedure TfmStockAllocQtyAutoAdjust.TabCtl20Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if devmode then exit;
  if AdjustStatus =0 then
    if (TabCtl20.TabIndex = 0) then begin
      MessageDlg('Please Export the data before import', mtWarning, [mbOK], 0);
      AllowChange := False;
    end;
end;

procedure TfmStockAllocQtyAutoAdjust.FormResize     (Sender: TObject);begin  inherited;  RealignTabControl(TabCtl20, 1);end;
procedure TfmStockAllocQtyAutoAdjust.FormShow       (Sender: TObject);
begin
  inherited;
  RealignTabControl(TabCtl20, 1);
  TabCtl20.tabindex := 0;
end;

initialization
  RegisterClassOnce(TfmStockAllocQtyAutoAdjust);

end.
