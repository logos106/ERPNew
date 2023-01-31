unit ERPUpdateFix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, BusObjBase, ERPDbLookupCombo, Mask,
  wwdbedit;

type
  TERPUpdateFixGUI = class(TBaseListingGUI)
    qryMainseqno: TIntegerField;
    qryMainproductId: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMainqtysold: TFloatField;
    qryMainshipped: TFloatField;
    qryMainbackorder: TFloatField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainisinvoice: TWideStringField;
    qryMainissalesorder: TWideStringField;
    qryMainCategory: TLargeintField;
    qryMainID: TIntegerField;
    qryMainLineID: TIntegerField;
    qryMainISPO: TWideStringField;
    qryMainInvoiced: TWideStringField;
    qryMaintype: TWideStringField;
    DNMPanel1: TDNMPanel;
    cboAccountLinesQry: TERPQuery;
    cboAccountLinesQryAccountName: TWideStringField;
    cboAccountLinesQryAccountID: TIntegerField;
    Label1: TLabel;
    Label2: TLabel;
    cboEmployeeLookup: TERPQuery;
    Label4: TLabel;
    cboEmployeeLookupEmployeeID: TIntegerField;
    cboEmployeeLookupEmployeeName: TWideStringField;
    cboAccountLinesQryAccountNumber: TWideStringField;
    Label5: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    dsAccountLinesQry: TDataSource;
    dsEmployeeLookup: TDataSource;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton4: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    btnRebuildTransTable: TDNMSpeedButton;
    btnPPGMismatch: TDNMSpeedButton;
    Memo1: TMemo;
    DNMSpeedButton5: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure cboAccountLinesQryBeforeOpen(DataSet: TDataSet);
    procedure cboEmployeeLookupBeforeOpen(DataSet: TDataSet);
(*    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);*)
    procedure btnRebuildTransTableClick(Sender: TObject);
    procedure btnPPGMismatchClick(Sender: TObject);
    procedure DNMSpeedButton5Click(Sender: TObject);
  private
    fiID:Integer;
    fsType:String;
    dttimeLog:TDatetime;
    procedure FixLinesCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure FixBonShippedqty;
    procedure FixProcProgressDuplicates;
    procedure BackupTables;
    procedure FixPQA;
    Procedure FixPPG;
    Procedure MakePPGJournalFix;
    Procedure MakeTranstable;
    procedure DoSendEmailtoErp(const Subject: String; Value: String);
    procedure DorunClosingdateRefresh;
    procedure cleantimeLog;
    procedure TimeLog(const Value: String;restartimer:boolean);
    function checkforBoMNonProductsubnodePostingAccount: boolean;
(*    procedure ChooseAccount(Sender: TwwDbGrid);
    procedure ChooseEmployee(Sender: TwwDbGrid);*)
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure ShowStatus(const Value: String);Override;
  public
  end;


implementation


uses BusObjSales, tcConst, CommonLib, BusObjConst, CommonDbLib, busobjPQA,
  BusObjTrans, busobjOrders, DbSharedObjectsObj, SharedObjs, PQALib, MySQLConst,
  ERPErrorEmailUtils, AppEnvironment, ERPVersionConst,
  TransactionsTable, CommonFormLib, DNMLib , TransactionsTableLib, LogLib ,
  TPPGFixObj, dateutils, Preferences;

{$R *.dfm}
procedure TERPUpdateFixGUI.cboAccountLinesQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cboAccountLinesQry.connection := qrymain.connection;
end;

procedure TERPUpdateFixGUI.cboEmployeeLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cboEmployeeLookup.connection := qrymain.connection;
end;

procedure TERPUpdateFixGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  clog('');
  if not checkforBoMNonProductsubnodePostingAccount then exit;
  Processingcursor(true);
  try
    ShowStatus('Lock Tables');
    if not Userlock.lock('tblSales', 0)  or
       not Userlock.lock('tblpurchaseorders', 0) or
       not Userlock.lock('tblprocprogress', 0) then begin
      MessageDlgXP_Vista('All Users will have to Exit', mtInformation, [mbOK], 0);
      Exit;
    end;
    try
      AppEnv.CompanyPrefs.DisableApprovalLevels;
      try
          ShowStatus('Backing Up Tables'             ); BackupTables;
          ShowStatus('Populate Transaction Table'    ); MakeTranstable;
          ShowStatus('Fixing Bo and Shipped Quantity'); FixBonShippedqty;
          ShowStatus('Fixing Quantities'             ); FixPQA;
          ShowStatus('Fixing Manufacture Transaction'); FixProcProgressDuplicates;
          ShowStatus('Fixing Progress Build'         ); FixPPG;
          ShowStatus('Creating Journals for Progress Build Mismatch'); MakePPGJournalFix;
         (* with TPPGFix.Create(self, nil) do try
            FixProcProgressDuplicates(0);
            FixPPG(0);
            MakeJournals(0);
          finally
            Free;
          end;*)
          ShowStatus('Populate Transaction Table'); MakeTranstable;
      finally
        AppEnv.CompanyPrefs.EnableApprovalLevels;
      end;
    finally
      ShowStatus('UnLock Tables');
      Userlock.unlock('tblSales', 0)  ;
      Userlock.unlock('tblpurchaseorders', 0) ;
      Userlock.unlock('tblprocprogress', 0) ;
    end;
    ShowStatus('Run closing Date Refresh'); DoRunclosingDateRefresh;
  finally
    HideStatus;
    Processingcursor(False);
    closewait;
  end;
end;

procedure TERPUpdateFixGUI.DNMSpeedButton5Click(Sender: TObject);
begin
  inherited;
  if not checkforBoMNonProductsubnodePostingAccount then exit;
  MakePPGJournalFix;
end;

procedure TERPUpdateFixGUI.btnRebuildTransTableClick(Sender: TObject);
begin
  inherited;
  cleantimeLog;
  TimeLog('Making transaction Table' , true);
  try
    MakeTranstable;
  finally
    TimeLog('' , true);
  end;
end;
procedure TERPUpdateFixGUI.cleantimeLog;
begin
  Memo1.Lines.clear;
  dttimeLog:= now;
end;
procedure TERPUpdateFixGUI.TimeLog(const Value:String;restartimer:boolean);
begin
  Memo1.Lines.add(formatdatetime('dd-mm-yyyy hh:nn:ss am/pm', dttimeLog )+'  to ' +formatdatetime('dd-mm-yyyy hh:nn:ss am/pm', now )+' :  ' + inttostr(SecondsBetween(dttimeLog , now))+'  -  ' + Value);
  if restartimer then dttimeLog := now;
end;
procedure TERPUpdateFixGUI.btnPPGMismatchClick(Sender: TObject);
begin
  inherited;
With scriptmain do begin
    SQL.Clear;
    SQL.add('Drop table if exists tmp_trans;' );
    SQL.add('Create table tmp_trans ' );
    with TTransactionTableExtra.Create(False) do try
      SQL.add(TransSQL(87, true));
    finally
      Free;
    end;
    SQL.add('drop table if exists tmp_1;');
    SQL.add('create table tmp_1 '+
                  ' select '+
                  ' SaleID, '+
                  ' DATE, '+
                  ' classid, '+
                  ' sum(DebitsEx) as DebitsEx, '+
                  ' sum(CreditsEx) as CreditsEx, '+
                  ' sum(DebitsInc) as DebitsInc, '+
                  ' sum(CreditsInc) as CreditsInc '+
                  ' from tmp_trans '+
                  ' group by saleID , date '+
                  ' having abs(round(DebitsEx-CreditsEx,5))>0.05 or '+
                  ' abs(round(DebitsInc-CreditsInc,5))>0.05 '+
                  ' Order by date; ');

    SQL.add('ALTER TABLE tmp_1 	ADD COLUMN ID INT(11) NOT NULL AUTO_INCREMENT FIRST, 	ADD PRIMARY KEY (ID);');
    SQL.add('ALTER TABLE tmp_1 ADD COLUMN  	classname VARCHAR(255) NULL DEFAULT "";');
    SQL.add('UPDATE tmp_1 t INNER JOIN tblclass c ON t.classid = c.classid SET t.classname = c.classname;');


    SQL.add('  Alter table tmp_1 add column GJID int(11) null default null;');

    Logtext(SQL.text);
    clog(SQL.text);
    //ExecutewithProgress;
  end;
end;

Procedure TERPUpdateFixGUI.DorunClosingdateRefresh;
var
  TransactionTableObj: TTransactionTableObj;
  msg:String;
begin
Exit;
          if AppEnv.UtilsClient.LockLogon(msg, AppEnv.AppDb.Database, 'Performing a Summarised Transactions') then begin
              try
                ShowUpdateBatchHint(Self , Width,  Trunc(Screen.Height/2)-50 , Left);
                try
                  TransactionTableObj := TTransactionTableObj.Create(False);
                  try
                    SetBatchInProgress(True);
                    SetBatchInProgress(False);
                    AppEnv.CompanyPrefs.ClosingDateChangeDone:= false;
                    try
                      TransactionTableObj.CleanRefreshTrnsTable(true, true);
                      TransactionTableObj.CreatePermanentSummaryTable;
                      TransactionTableObj.CleanRefreshTrnsTable(true, false, true);
                    finally
                      AppEnv.CompanyPrefs.ClosingDateChangeDone:= true;
                    end;

                  finally
                    FreeAndNil(TransactionTableObj);
                  end;
                finally
                  HideERPHint(Self)
                end;
              finally
                AppEnv.UtilsClient.UnlockLogon;
              end;
              DoSendEmailtoErp('Closing Date Refresh', 'Closing Date Refresh is done after update');
           end else begin
              CommonLib.MessageDlgXP_Vista('Unable to Summarise Transactions at This Time, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
              Exit;
           end;
end;
procedure TERPUpdateFixGUI.FixPPG;
var
  ctr1, ctr2, ctr3,x1:Integer;
  dtbeforeupdate:TDatetime;
begin
  With Scriptmain do begin
    SQL.clear;


    {Create missing subnodes}
    SQL.add('Drop table if exists tmp_1;');
    SQL.add('create table tmp_1 select max(ProcprogressID) maxProcprogressID from tblprocprogress;');

    SQL.add('Drop table if exists tmp_2;');
    SQL.add('create table tmp_2 select max(pqaid) maxpqaid from tblpqa;');

    {some of the raw materials are missing from Progress build}
    SQL.Add('Create table if not exists erpfix_Copy_tblprocprogress_2 like tblprocprogress;');
    for x1 := 1 to 2 do begin
      if x1 = 1 then SQL.add('insert ignore into erpfix_Copy_tblprocprogress_2')
      else SQL.add('insert ignore into tblprocprogress');
      SQL.add('(EmployeeId, ProcTreeId, ProcTreePartID,  ProductID, ClassID,Progressdate,Qty, UOMQty, UOM, UOMID, UOMMultiplier, Alloctype, BuildStatus,ReasonID,active,InProcProgressId,ProductUnitCost)');
      SQL.add('SELECT');
      SQL.add('ppg.EmployeeId EmployeeId,');
      SQL.add('cpt.ProcTreeId as ProcTreeId,');
      SQL.add('cppt.ProcTreePartId as ProcTreePartID,');
      SQL.add('cppt.ProductId as  ProductID,');
      SQL.add('cppt.ClassId as ClassID,');
      SQL.add('ppg.Progressdate as Progressdate,');
      SQL.add('cpt.Quantity as Qty,');
      SQL.add('cpt.TreePartUOMQuantity as UOMQty,');
      SQL.add('cpt.TreePartUOM as UOM,');
      SQL.add('cpt.TreePartUOMID as UOMID,');
      SQL.add('cpt.TreePartUOMMultiplier as UOMMultiplier,');
      SQL.add('"OUT" as Alloctype,');
      SQL.add('ppg.BuildStatus as BuildStatus,');
      SQL.add('0 as ReasonID,');
      SQL.add('"T" as active,');
      SQL.add('ppg.ProcProgressID as InProcProgressId,');
      SQL.add('cpt.ProductUnitCost as ProductUnitCost');
      SQL.add('FROM tblprocprogress ppg');
      SQL.add('INNER JOIN tblproctree pt ON ppg.proctreeid = pt.proctreeid');
      SQL.add('INNER JOIN tblproctreepart ppt ON ppg.ProcTreePartID = ppt.ProcTreePartId AND ppt.ProcTreeId = ppt.ProcTreeId');
      SQL.add('INNER JOIN tblproctree cpt ON pt.ProcTreeId = cpt.ParentId and (cpt.selected ="T" or pt.inputtype <> "itOption")');
      SQL.add('INNER JOIN tblproctreepart cppt ON cpt.ProcTreeId = cppt.ProcTreeId');
      SQL.add('LEFT JOIN tblprocprogress cppg ON ppg.ProcProgressID = cppg.InProcProgressId AND cppg.ProcTreeId = cpt.ProcTreeId');
      SQL.add('INNER JOIN tblsaleslines sl ON sl.salelineId = pt.MasterId AND pt.MasterType <> "mtProduct"');
      SQL.add('INNER JOIN tblsales s ON s.saleID = sl.saleID');
      SQL.add('WHERE ppg.Alloctype ="IN"');
      SQL.add('AND IFNULL(cppg.ProcProgressID,0)=0;');
    end;



    SQL.Add('Create table if not exists erpfix_Copy_tblpqa_2 like tblpqa;');

    for x1 := 1 to 2 do begin
      if x1 = 1 then SQL.add('insert ignore into erpfix_Copy_tblpqa_2')
      else SQL.add('insert ignore into tblpqa');
      SQL.add('(translineId,TransType,TransDate,Alloctype, IsBO, Qty, UOMQty, UOM, UOMMultiplier, UOMID, DepartmentID, ProductID, ProductName, ProductPrintName, active, TransID)');
      SQL.add('select');
      SQL.add('ppg.ProcProgressID as  translineId,');
      SQL.add('"TProcProgressOUT"  as TransType,');
      SQL.add('ppg.Progressdate as TransDate,');
      SQL.add('ppg.Alloctype as Alloctype,');
      SQL.add('"F" as IsBO,');
      SQL.add('ppg.Qty as Qty,');
      SQL.add('ppg.UOMQty as UOMQty,');
      SQL.add('ppg.UOM as UOM,');
      SQL.add('ppg.UOMMultiplier as UOMMultiplier,');
      SQL.add('ppg.UOMID as UOMID,');
      SQL.add('ppg.ClassID as DepartmentID,');
      SQL.add('ppg.ProductID as ProductID,');
      SQL.add('p.partname as ProductName,');
      SQL.add('p.ProductPrintName as ProductPrintName,');
      SQL.add('"T" as active,');
      SQL.add('sl.SaleID as TransID');
      SQL.add(' from tblprocprogress ppg');
      SQL.add('inner join tblparts p on ppg.ProductID = p.partsId and p.PARTTYPE ="INV"');
      SQL.add('inner join tblproctree pt on pt.ProcTreeId = ppg.ProcTreeId');
      SQL.add('inner join tblsaleslines sl on sl.SaleLineID = pt.MasterId');
      SQL.add('where procprogressid > (Select maxProcprogressID from tmp_1);');
    end;

    {all PPG in transactions}
    SQL.add('DROP TABLE If EXISTS tmp_1_in;');
    SQL.add('CREATE TABLE tmp_1_in '+
              ' SELECT ProcProgressid, productid, proctreeid, ProctreepartID, qty, Productunitcost  '+
              ' FROM tblprocprogress WHERE alloctype = "IN";');
    {all PPG outs}
    SQL.add('DROP TABLE If EXISTS tmp_1_out;');
    SQL.add('CREATE TABLE tmp_1_out  '+
              ' SELECT ProcProgressid, inProcProgressid, productid, proctreeid, ProctreepartID, qty, Productunitcost  '+
              ' FROM tblprocprogress WHERE alloctype = "OUT" and ifnull(inProcProgressid,0)<>0;');
    SQL.add('ALTER TABLE tmp_1_in ADD INDEX ProcProgressid (ProcProgressid);');
    SQL.add('ALTER TABLE tmp_1_out ADD INDEX ProcProgressid (ProcProgressid);');
    SQL.add('ALTER TABLE tmp_1_out ADD INDEX inProcProgressid (inProcProgressid);');

    {total cost from outs}
    SQL.add('DROP TABLE If EXISTS tmp_1_outsum;');
    SQL.add('CREATE TABLE tmp_1_outsum  '+
              ' SELECT inProcProgressid ,  '+
              ' SUM(qty*Productunitcost) AS totalcost  '+
              ' FROM tmp_1_out GROUP BY inProcProgressid;');
    {list of INs where the cost doesn't mathc with the OUT's total cost}
    SQL.add('DROP TABLE If EXISTS tmp_1_inMismatch;');
    SQL.add('CREATE TABLE tmp_1_inMismatch  '+
              ' SELECT tin.ProcProgressid, tin.productid, tin.proctreeid, tin.ProctreepartID,  '+
              ' tin.qty, tin.Productunitcost ,  '+
              ' tout.totalcost  '+
              ' FROM tmp_1_in tin  '+
              ' INNER JOIN tmp_1_outsum tout ON tin.ProcProgressid = tout.inProcProgressid  '+
              ' WHERE tin.productunitcost <> tout.totalcost;');

    {update the In's cost from Sum of OUTS's cost }
    SQL.add('update tblprocprogress ppg  '+
              ' INNER JOIN tmp_1_inMismatch T ON ppg.ProcProgressID = T.ProcProgressid  '+
              ' SET ppg.ProductUnitCost = T.totalcost;');
    {delete all temp tables}
    SQL.add('DROP TABLE If EXISTS tmp_1_in;');
    SQL.add('DROP TABLE If EXISTS tmp_1_out;');
    SQL.add('DROP TABLE If EXISTS tmp_1_outsum;');
    SQL.add('DROP TABLE If EXISTS tmp_1_inMismatch;');

    ctr1:= GetTableRecordCount('tblprocprogress');
    dtbeforeupdate := now;
    Logtext(SQL.text);
    ExecutewithProgress;
    ctr2:= GetTableRecordCount('tblprocprogress');
    ctr3:= GetTableRecordCount('tblprocprogress', 'mstimeStamp >= ' + quotedstr(formatdatetime(mysqldatetimeformat , dtbeforeupdate)));

    DoSendEmailtoErp('PPG-1', 'Count of Progress Was : '           + inttostr(ctr1)+' and is : '+ inttostr(ctr2)+NL+
                            'Count of updated Progress builds : '    + inttostr(ctr3));
    SQL.clear;
    SQL.add('DROP TABLE if EXISTS tmp_procprogress;');
    SQL.add('CREATE TABLE tmp_procprogress LIKE tblprocprogress;');
    SQL.add('ALTER TABLE tmp_procprogress ADD COLUMN saleId INT(11) NULL DEFAULT NULL;');
    SQL.add('ALTER TABLE tmp_procprogress ADD COLUMN saleLineID INT(11) NULL DEFAULT NULL;');

    SQL.add('INSERT IGNORE INTO tmp_procprogress  ' +
                  ' (ProcProgressID,EmployeeId,ProcTreeId,ProcTreePartID,ProductID,ClassID,Progressdate,Qty,UOMQty,UOM,UOMID,UOMMultiplier, ' +
                  ' Alloctype,BuildStatus,ReasonID,Active,InProcProgressId,ProductUnitCost,mstimestamp,msUpdatesiteCode,saleLineId, saleID) ' +
                  ' SELECT ' +
                  ' ppg.inprocprogressid                AS ProcProgressID, ' +
                  ' ppg.EmployeeId                      AS EmployeeId, ' +
                  ' ppt.ProcTreeId                      AS ProcTreeId, ' +
                  ' pppt.ProcTreePartId                 AS ProcTreePartId, ' +
                  ' pppt.ProductId                      AS ProductId, ' +
                  ' ppg.ClassID                         AS classid, ' +
                  ' ppg.Progressdate                    AS Progressdate, ' +
                  ' 1 *  ppt.TreePartUOMMultiplier      AS Qty, ' +
                  ' 1                                   AS UOMQty, ' +
                  ' ppt.TreePartUOM                     AS UOM, ' +
                  ' ppt.TreePartUOMID                   AS uomid, ' +
                  ' ppt.TreePartUOMMultiplier           AS UOMMultiplier, ' +
                  ' "IN"                                AS Alloctype, ' +
                  ' ppg.BuildStatus                     AS BuildStatus, ' +
                  ' ppg.ReasonID                        AS ReasonID, ' +
                  ' ppg.Active                          AS active, ' +
                  ' 0                                   AS InProcProgressId, ' +
                  ' SUM(ppg.qty * ppg.ProductUnitCost)  AS ProductUnitCost, ' +
                  ' ppg.mstimestamp                     AS mstimestamp, ' +
                  ' ppg.msUpdatesiteCode                AS msUpdatesiteCode, ' +
                  ' sl.salelineID                       AS saleLineID, ' +
                  ' sl.saleId                           AS saleId ' +
                  ' FROM tblprocprogress        ppg ' +
                  ' INNER JOIN tblproctree      pt    ON pt.proctreeid  = ppg.ProcTreeId ' +
                  ' INNER JOIN tblproctree      ppt   ON pt.ParentId    = ppt.ProcTreeId ' +
                  ' INNER JOIN tblproctreepart  pppt  ON ppt.ProcTreeId = pppt.ProcTreeId ' +
                  ' INNER JOIN tblsaleslines    sl    ON sl.SaleLineID  = ppt.MasterId ' +
                  ' WHERE ifnull(inprocprogressid,0)<> 0 and inprocprogressid  NOT IN (SELECT procprogressid FROM tblprocprogress) ' +
                  ' GROUP BY ppg.inprocprogressid ;');

    SQL.Add('Create table if not exists erpfix_Copy_tblpqa_3 like tblpqa;');
    for x1 := 1 to 2 do begin
        SQL.add('INSERT IGNORE INTO  ' + iif(X1 = 1 , 'erpfix_Copy_tblpqa_3' , 'tblpqa ')+
                      ' (TransLineID,TransType,TransDate,Alloctype,IsBO,Qty,UOMQty,UOM,UOMMultiplier,UOMID,DepartmentID, ' +
                      ' ProductID,ProductName,ProductPrintName,Active,TransID,Reserved,msTimeStamp,msUpdateSiteCode) ' +
                      ' SELECT ' +
                      ' T.ProcProgressID    AS TransLineId, ' +
                      ' "TProcProgressIn"   AS Transtype, ' +
                      ' T.progressdate      AS transdate, ' +
                      ' "IN"                AS alloctype, ' +
                      ' "F"                 AS isbo, ' +
                      ' T.qty               AS Qty, ' +
                      ' T.uomqty            AS UOMQty, ' +
                      ' t.UOM               AS UOM, ' +
                      ' t.UOMMultiplier     AS UOMMultiplier, ' +
                      ' t.UOMID             AS UOMID, ' +
                      ' t.classid           AS DepartmentID, ' +
                      ' t.ProductID         AS ProductID, ' +
                      ' p.partname          AS ProductName, ' +
                      ' p.ProductPrintName  AS ProductPrintName, ' +
                      ' "T"                 AS Active, ' +
                      ' t.saleId            AS transID, ' +
                      ' "F"                 AS Reserved, ' +
                      ' T.msTimeStamp       AS msTimeStamp, ' +
                      ' T.msUpdateSiteCode  AS msUpdateSiteCode ' +
                      ' FROM tmp_procprogress T inner join tblparts P ON T.productId = P.PARTSID;');
    end;

    SQL.Add('Create table if not exists erpfix_Copy_tblprocprogress_3 like tblprocprogress;');
    for x1 := 1 to 2 do begin
    SQL.add('INSERT IGNORE INTO   ' + iif(x1 =1 , 'erpfix_Copy_tblprocprogress_3' , 'tblprocprogress')+
                  ' (ProcProgressID,EmployeeId,ProcTreeId,ProcTreePartID,ProductID,ClassID,Progressdate,Qty,UOMQty, ' +
                  ' UOM,UOMID,UOMMultiplier,Alloctype,BuildStatus,ReasonID,Active,InProcProgressId,ProductUnitCost,mstimestamp,msUpdatesiteCode) ' +
                  ' SELECT  ' +
                  ' ProcProgressID, ' +
                  ' EmployeeId, ' +
                  ' ProcTreeId, ' +
                  ' ProcTreePartID, ' +
                  ' ProductID, ' +
                  ' ClassID, ' +
                  ' Progressdate, ' +
                  ' Qty, ' +
                  ' UOMQty, ' +
                  ' UOM, ' +
                  ' UOMID, ' +
                  ' UOMMultiplier, ' +
                  ' Alloctype, ' +
                  ' BuildStatus, ' +
                  ' ReasonID, ' +
                  ' Active, ' +
                  ' InProcProgressId, ' +
                  ' ProductUnitCost, ' +
                  ' mstimestamp, ' +
                  ' msUpdatesiteCode   ' +
                  ' FROM  tmp_procprogress ;');
    end;
    SQL.add('DROP TABLE if EXISTS tmp_procprogress;');
    ctr1:= GetTableRecordCount('tblprocprogress');
    dtbeforeupdate := now;
    Logtext(SQL.text);
    ExecutewithProgress;
    ctr2:= GetTableRecordCount('tblprocprogress');
    ctr3:= GetTableRecordCount('tblprocprogress', 'mstimeStamp >= ' + quotedstr(formatdatetime(mysqldatetimeformat , dtbeforeupdate)));

    DoSendEmailtoErp('PPG-2', 'Count of Progress Was : '           + inttostr(ctr1)+' and is : '+ inttostr(ctr2)+NL+
                            'Count of updated Progress builds : '    + inttostr(ctr3));

  end;
end;
procedure TERPUpdateFixGUI.FixPQA;
var
  ctr1, ctr2, ctr3, ctr4, ctr5, ctr6 :Integer;
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.Add('Create table if not exists erpfix_Copy_tblpqa_1 like tblpqa;');
    SQL.Add('insert ignore into erpfix_Copy_tblpqa_1 Select * from tblPqa WHERE transtype in (' + PPGTypes          +') and translineId not in (Select Procprogressid       from tblProcProgress      );');
    SQL.Add('insert ignore into erpfix_Copy_tblpqa_1 Select * from tblPqa WHERE transtype in (' + SalesTransTypes   +') and translineId not in (Select saleLineId           from tblsaleslines        );');
    SQL.Add('insert ignore into erpfix_Copy_tblpqa_1 Select * from tblPqa WHERE transtype in (' + POTranstypes      +') and translineId not in (Select PurchaselineId       from tblpurchaselines     );');
    SQL.Add('insert ignore into erpfix_Copy_tblpqa_1 Select * from tblPqa WHERE transtype in (' + ManufactureTypes  +') and translineId not in (Select ProcTreePartId       from tblproctreepart      );');
    SQL.Add('insert ignore into erpfix_Copy_tblpqa_1 Select * from tblPqa WHERE transtype in (' + StockMovementtypes+') and translineId not in (Select StockmovementLinesID from tblstockmovementlines);');
    SQL.Add('insert ignore into erpfix_Copy_tblpqa_1 Select * from tblPqa WHERE transtype in (' + RepairType        +') and translineId not in (Select RepairPartsID        from tblrepairparts       );');
    SQL.Add('Create table if not exists erpfix_Copy_tblpqadetails_1 like tblpqadetails;');
    SQL.Add('insert ignore into erpfix_Copy_tblpqadetails_1 Select * from tblPqadetails where pqaId not in (Select pqaid from tblPQa);');


    SQL.Add('delete from tblPqa WHERE transtype in (' + PPGTypes          +') and translineId not in (Select Procprogressid       from tblProcProgress      );');
    SQL.Add('delete from tblPqa WHERE transtype in (' + SalesTransTypes   +') and translineId not in (Select saleLineId           from tblsaleslines        );');
    SQL.Add('delete from tblPqa WHERE transtype in (' + POTranstypes      +') and translineId not in (Select PurchaselineId       from tblpurchaselines     );');
    SQL.Add('delete from tblPqa WHERE transtype in (' + ManufactureTypes  +') and translineId not in (Select ProcTreePartId       from tblproctreepart      );');
    SQL.Add('delete from tblPqa WHERE transtype in (' + StockMovementtypes+') and translineId not in (Select StockmovementLinesID from tblstockmovementlines);');
    SQL.Add('delete from tblPqa WHERE transtype in (' + RepairType        +') and translineId not in (Select RepairPartsID        from tblrepairparts       );');
    SQL.Add('delete from tblPqadetails where pqaId not in (Select pqaid from tblPQa);');
    SQL.Add('update tblsales s ' +
            ' INNER JOIN tblsaleslines sl ON s.saleId = sl.saleid ' +
            ' INNER JOIN tblproctree pt ON sl.SaleLineID = pt.MasterId AND pt.MasterType <> "mtproduct" ' +
            ' INNER JOIN tblproctreepart ptp ON pt.ProcTreeId = ptp.ProcTreeId ' +
            ' INNER JOIN tblpqa pqa ON pqa.TransLineID = ptp.ProcTreePartId AND pqa.TransType IN ("TProcTreePart" , "TProcTreePartIN") AND pqa.active ="F" ' +
            ' SET pqa.active ="T" ' +
            ' WHERE s.Converted ="T";');
    ctr1:= GetTableRecordCount('tblpqa');
    ctr2:= GetTableRecordCount('tblpqadetails');
    ctr3:= GetTableRecordCount('tblpqa', 'Active ="T"');
    Logtext(SQL.text);
    ExecutewithProgress;
    ctr4:= GetTableRecordCount('tblpqa');
    ctr5:= GetTableRecordCount('tblpqadetails');
    ctr6:= GetTableRecordCount('tblpqa', 'Active ="T"');
    DoSendEmailtoErp('PQA', 'Count of PQA Was : '           + inttostr(ctr1)+' and is : '+ inttostr(ctr4)+NL+
                            'Count of tblpqadetails Was : ' + inttostr(ctr2)+' and is : '+ inttostr(ctr5)+NL+
                            'Count of Active PQA Was : '    + inttostr(ctr3)+' and is : '+ inttostr(ctr6));
  end;
end;
procedure TERPUpdateFixGUI.BackupTables;
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.add(ERPFixtableSQL('tblsales'         , 'BnS', True));
    SQL.add(ERPFixtableSQL('tblsaleslines'    , 'BnS', True));
    SQL.add(ERPFixtableSQL('tblpurchaseorders', 'BnS', True));
    SQL.add(ERPFixtableSQL('tblpurchaselines' , 'BnS', True));
    SQL.add(ERPFixtableSQL('tblprocprogress'  , 'BnS', True));
    SQL.add(ERPFixtableSQL('tblpqa'           , 'BnS', True));
    SQL.add(ERPFixtableSQL('tblpqadetails'    , 'BnS', True));
    SQL.add(ERPFixtableSQL('tblgeneraljournal'        , 'BnS', True));
    SQL.add(ERPFixtableSQL('tblgeneraljournaldetails' , 'BnS', True));
    Logtext(SQL.text);
    if SQL.count >0 then
      ExecutewithProgress;
  end;
end;
procedure TERPUpdateFixGUI.FixProcProgressDuplicates;
var
  qry: TERPQuery;
  fsTablename :String;
begin
  fsTableName := GetUserTemporaryTableName('BOnshipqty');
  With Scriptmain do begin
    SQL.clear;
    SQL.Add('Create table if not exists erpfix_Copy_tblprocprogress_1 like tblprocprogress;');
    SQL.Add('Drop table if exists ' + fstablename +';');
    SQL.Add('Create table ' + fstablename +' SELECT inprocprogressid, proctreepartId, COUNT( * ) ctr, MIN(ProcprogressID) minProcprogressID, MAX(ProcprogressID) AS maxProcprogressID ' +
                                              ' FROM tblprocprogress ' +
                                              ' WHERE IFNULL(inprocprogressid,0)<> 0 ' +
                                              ' GROUP BY inprocprogressid, proctreepartId ' +
                                              ' HAVING ctr>1;' );
    SQL.Add('ALTER TABLE  ' + fstablename +'  ADD INDEX maxProcprogressID (maxProcprogressID);');
    SQL.Add('insert ignore into erpfix_Copy_tblprocprogress_1 select * from tblprocprogress where Procprogressid in (Select  maxProcprogressID from '+ fstablename +');');
    SQL.Add('Delete from tblprocprogress where Procprogressid in (Select  maxProcprogressID from '+ fstablename +');');
    SQL.Add('Drop table if exists ' + fstablename +';');
    Logtext(SQL.text);
  end;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    repeat
        ExecutewithProgress;
        DoSendEmailtoErp('ProcProgressDuplicates', ' PPG Duplicates :' + inttostr(qry.recordcount)+' Items Found');
        closedb(qry);
        qry.sql.text := 'SELECT inprocprogressid, proctreepartId,  ' +
                              ' COUNT( * ) ctr  ' +
                              ' FROM tblprocprogress ' +
                              ' WHERE IFNULL(inprocprogressid,0)<> 0 ' +
                              ' GROUP BY inprocprogressid, proctreepartId ' +
                              ' HAVING ctr>1 LIMIT 10 ' ;
        Opendb(qry);
        Logtext('FixProcProgressDuplicates : '+ inttostr(qry.REcordcount));
    until qry.REcordcount =0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
Procedure TERPUpdateFixGUI.DoSendEmailtoErp(Const Subject:String; Value:String);
begin
  SendEmailtoErp('ERPUpdateFix.'+Subject,
                 '    Company     :' + Appenv.CompanyInfo.Companyname + NL +
                 '    Server      :' + GetSharedMyDacConnection.Server + NL +
                 '    Datase      :' + GetSharedMyDacConnection.Database + NL +
                 '    Version     :' + TABLE_VERSION + NL + Value);
end;
procedure TERPUpdateFixGUI.FixBonShippedqty;
begin
  inherited;
  if qrymain.recordcount =0 then exit;
  DoSendEmailtoErp('BonShippedqty', inttostr(qrymain.recordcount)+' Items Found with BO & Shipped Qty Mixmatch');
  fiID:=0;
  fsType:='';
  IterateProcNo := 1;
  grdmain.selectall;
  IterateSelectedrecords(true);
end;

procedure TERPUpdateFixGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SearchMode:= smFullList;
  HaveDateRangeSelection := False;
  EnableMultiSelect('Choose Sales REcords To fix');
end;
procedure TERPUpdateFixGUI.FormShow(Sender: TObject);
begin
  inherited;
  btnRebuildTransTable.visible     := devmode;
  btnPPGMismatch.visible     := devmode;
  grdmain.visible     := False;
(*  btnCustomize.visible:= False;
  cmdExport.visible   := False;
  cmdNew.visible      := False;
  cmdPrint.visible    := False;*)
  pnlButtons.visible  := False;
  Panel3.visible  := False;
  FooterPanel.visible  := False;
  //HeaderPanel.height := pnlHeader.height + pnlHeader.top + pnlHeader.top;
  //pnlHeader.top :=2;
  //pnlHeader.height:= HeaderPanel.height-4;
  //Self.height := Panel1.top +Panel1.height;
  cleantimeLog;
  checkforBoMNonProductsubnodePostingAccount;
end;
function TERPUpdateFixGUI.checkforBoMNonProductsubnodePostingAccount:boolean;
begin
  if appenv.companyprefs.BoMNonProductsubnodePostingAccount = '' then begin
    if MessageDlgXP_Vista('Please update "Account For Progress Build - Non Product Sub Items" in the Preference', mtWarning, [], 0 , nil, '','', false,nil, 'Open Preference,Cancel') = 100 then begin
        OpenPrefform('Manufacturing' ,  'cboBoMNonProductsubnodePostingAccount' , 0 , true);
    end;
    Result := False;
    Exit;
  end;
  Result := True;
end;
procedure TERPUpdateFixGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (qrymaincategory.asInteger in [1,3]) then
    if  (sametext(field.fieldname ,qrymainUnitofMeasureShipped.fieldname))  or
        (sametext(field.fieldname ,qrymainUnitofMeasureBackorder.fieldname))  or
        (sametext(field.fieldname ,qrymainUnitofMeasureQtySold.fieldname))  then Abrush.color := Color_Yellow;
  if (qrymaincategory.asInteger in [2,4]) then
    if  (sametext(field.fieldname ,qrymainInvoiced.fieldname))  then Abrush.color := Color_Yellow;

end;

procedure TERPUpdateFixGUI.FixLinesCallback(Const Sender: TBusObj; Var Abort: Boolean);
var
  fdlinecost, fdlinecostinc, fdLineTaxTotal, fdtotallineamount, fdtotalLineamountinc :Double;
begin
  if sender is TTransLineBase then begin
  fdlinecost          := TTransLineBase(Sender).linecost;
  fdlinecostinc       := TTransLineBase(Sender).LineCostinc;
  fdLineTaxTotal      := TTransLineBase(Sender).LineTaxTotal;
  fdtotallineamount   := TTransLineBase(Sender).TotalLineamount;
  fdtotalLineamountinc:= TTransLineBase(Sender).TotalLineamountinc;
  try
    TTransLineBase(Sender).editdb;
    TTransLineBase(Sender).Invoiced := (TTransLineBase(Sender).QtyShipped <> 0);
    TTransLineBase(Sender).PostDB;
    TTransLineBase(Sender).DoFieldChangewhenDisabled := TRue;
    (*TTransLineBase(Sender).DoFieldOnChange(TTransLineBase(Sender).dataset.findfield('QtySold'));*)
  finally
    TTransLineBase(Sender).linecost           := fdlinecost;
    TTransLineBase(Sender).LineCostinc        := fdlinecostinc;
    TTransLineBase(Sender).LineTaxTotal       := fdLineTaxTotal;
    TTransLineBase(Sender).TotalLineamount    := fdtotallineamount;
    TTransLineBase(Sender).TotalLineamountinc := fdtotalLineamountinc;
    TTransLineBase(Sender).PostDB;
  end;
  end;
end;
procedure TERPUpdateFixGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
     end;
end;

procedure TERPUpdateFixGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  Trans:TTransBase;
begin
  inherited;
  if IterateProcNo = 1 then begin
    if (fiID =QrymainID.asInteger) and
        (fsType= qrymainType.asString) then exit;

    if QrymainIsSalesOrder.asboolean then Trans := TSalesOrder.CreateWithNewConn(Self)
    else if QrymainIsInvoice.asboolean    then Trans := TInvoice.CreateWithNewConn(Self)
    else  Trans := TPurchaseOrder.CreateWithNewConn(Self);

    try
      Trans.SilentMode := True;
      Trans.BusObjEvent := DoBusinessObjectEvent;
        Trans.load(QrymainID.asInteger);
        Trans.connection.begintransaction;
        try
            Trans.Comments := trim(trim(Trans.Comments) + NL+ 'BO n Shipped Qty Fix');
            Trans.RawMode := True;
            Trans.PostDB;
            Trans.Lines.IterateRecords(FixLinesCallback);
            if not Trans.save then begin
              Trans.connection.RollbackTransaction;
              Exit;
            end;
            Trans.connection.CommitTransaction;
            fiID := QrymainID.asInteger;
            fsType:= qrymainType.asString;
        Except
          on E:Exception do begin
            Trans.connection.RollbackTransaction;
          end;
        end;
    finally

      FreeandNil(Trans);
    end;
  end;
end;
procedure TERPUpdateFixGUI.MakePPGJournalFix;
begin
With scriptmain do begin
    SQL.Clear;
    with TTransactionTableExtra.Create(False) do try
      SQL.add(TransSQL(87, true));
    finally
      Free;
    end;

    SQL.TExt := 'Drop table if exists tmp_trans;' + 'Create table tmp_trans ' +SQL.TExt+';';
    SQL.add('drop table if exists tmp_1;');
    SQL.add('create table tmp_1 '+
                  ' select '+
                  ' SaleID, '+
                  ' DATE, '+
                  ' classid, '+
                  ' sum(DebitsEx) as DebitsEx, '+
                  ' sum(CreditsEx) as CreditsEx, '+
                  ' sum(DebitsInc) as DebitsInc, '+
                  ' sum(CreditsInc) as CreditsInc '+
                  ' from tmp_trans '+
                  ' group by saleID , date '+
                  ' having abs(round(DebitsEx-CreditsEx,5))>0.05 or '+
                  ' abs(round(DebitsInc-CreditsInc,5))>0.05 '+
                  ' Order by date; ');

    SQL.add('ALTER TABLE tmp_1 	ADD COLUMN ID INT(11) NOT NULL AUTO_INCREMENT FIRST, 	ADD PRIMARY KEY (ID);');
    SQL.add('ALTER TABLE tmp_1 ADD COLUMN  	classname VARCHAR(255) NULL DEFAULT "";');
    SQL.add('UPDATE tmp_1 t INNER JOIN tblclass c ON t.classid = c.classid SET t.classname = c.classname;');


    SQL.add('  Alter table tmp_1 add column GJID int(11) null default null;');
    SQL.add('  Alter table tblgeneraljournal add column tmp_1Id int(11) null default 0;');

    SQL.add('  INSERT INTO tblgeneraljournal (TransactionDate, TransactionNo, Amount , tmp_1Id) '+
                  '   Select Date TransactionDate ,concat("Adj-", ID) as TransactionNo, Debitsinc-Creditsinc as Amount , Id from tmp_1; ');
    SQL.add('  update tmp_1 T inner join tblgeneraljournal G on T.ID  = G.tmp_1Id Set T.GJID = G.GJID;');

    SQL.add('INSERT INTO tblgeneraljournaldetails '+
                  ' (GJID ,AccountName ,AccountID ,DebitAmount ,DebitAmountInc,Creditamount ,Creditamountinc ,ClassName ,ClassID ,accountnumber ,employeeId,employeename) '+
                  ' SELECT GJID, ' + quotedstr(cboAccountLinesQryAccountName.asString)+' AS accountname , '+
                  //' '+ inttostr(cboAccountLinesQryAccountID.AsInteger)+' AS accountid, '+
                  ' '+ inttostr(Appenv.companyPrefs.PPGBalanceAdjAccountID)+' AS accountid, '+
                  ' 0 AS DebitAmount , '+
                  ' 0 AS Creditamount, '+
                  ' DebitsInc-CreditsInc AS DebitAmountInc , '+
                  ' 0 AS Creditamountinc , '+
                  ' classname, '+
                  ' classid,  '+
                  ' ' + quotedstr(cboAccountLinesQryAccountNumber.asString)+'  AS accountnumber, '+
                  //' '+ inttostr(cboEmployeeLookupEmployeeID.AsInteger)+' AS Employeeid ,  '+
                  ' '+ inttostr(Appenv.companyPrefs.PPGBalanceAdjEmployeeID)+' AS Employeeid ,  '+
                  ' ' + quotedstr(cboEmployeeLookupEmployeeName.asString)+'  AS Employeename '+
                  ' FROM tmp_1;');

    SQL.add('Alter table tblgeneraljournal drop column tmp_1Id ;');
    SQL.add('drop table if exists tmp_1;');
    SQL.add('update tblgeneraljournaldetails Set globalref = concat('+QuotedStr(Appenv.Branch.SiteCode)+', GJDID) where ifnull(globalref,"") ="";');
    SQL.add('update tblgeneraljournal        Set globalref = concat('+QuotedStr(Appenv.Branch.SiteCode)+', GJID ) where ifnull(globalref,"") ="";');
    Logtext(SQL.text);
    ExecutewithProgress;
  end;
end;

procedure TERPUpdateFixGUI.MakeTranstable;
var
   fsTransSQLFields :String;
function MakeSQL(aSQL:String):String;
begin
  Result := '';
  if aSQL ='' then exit;
  Result := trim('Insert ignore into TblTransactions (' + fsTransSQLFields +') ' +NL+ aSQL);
  while pos(';', REsult)< length(result) do
    REsult := StringReplace(result , ';' ,' '+NL+'Union  all ' , [rfIgnoreCase]);
  Logtext(Result);
end;
begin
  With scriptmain do begin
    SQL.clear;
    SQL.add('truncate TblTransactions;');
    SQL.add('truncate tbltransactionsummarydetails;');
    SQL.add('truncate rpt_TblTransactions;');
    SQL.add('truncate rpt_tbltransactionsummarydetails;');

    (*    SQL.add('truncate tbltransactionsummariseddetails;');
    SQL.add('truncate tbltransactionsummary;');
    SQL.add('truncate tbltransactions_inprogress;');*)

    with TTransactionTableExtra.Create(False) do try
      fsTransSQLFields := TransSQLFields(0);
      SQL.add(MakeSQL(TransSQL(02, True)));
      SQL.add(MakeSQL(TransSQL(03, True)));
      SQL.add(MakeSQL(TransSQL(04, True)));
      SQL.add(MakeSQL(TransSQL(05, True)));
      SQL.add(MakeSQL(TransSQL(06, True)));
      SQL.add(MakeSQL(TransSQL(07, True)));
      SQL.add(MakeSQL(TransSQL(08, True)));
      SQL.add(MakeSQL(TransSQL(10, True)));
      SQL.add(MakeSQL(TransSQL(11, True)));
      SQL.add(MakeSQL(TransSQL(12, True)));
      SQL.add(MakeSQL(TransSQL(14, True)));
      SQL.add(MakeSQL(TransSQL(16, True)));
      SQL.add(MakeSQL(TransSQL(17, True)));
      SQL.add(MakeSQL(TransSQL(18, True)));
      SQL.add(MakeSQL(TransSQL(19, True)));
      SQL.add(MakeSQL(TransSQL(20, True)));
      SQL.add(MakeSQL(TransSQL(21, True)));
      SQL.add(MakeSQL(TransSQL(22, True)));
      SQL.add(MakeSQL(TransSQL(23, True)));
      SQL.add(MakeSQL(TransSQL(24, True)));
      SQL.add(MakeSQL(TransSQL(25, True)));
      SQL.add(MakeSQL(TransSQL(26, True)));
      SQL.add(MakeSQL(TransSQL(27, True)));
      SQL.add(MakeSQL(TransSQL(28, True)));
      SQL.add(MakeSQL(TransSQL(29, True)));
      SQL.add(MakeSQL(TransSQL(30, True)));
      SQL.add(MakeSQL(TransSQL(31, True)));
      SQL.add(MakeSQL(TransSQL(32, True)));
      SQL.add(MakeSQL(TransSQL(33, True)));
      SQL.add(MakeSQL(TransSQL(34, True)));
      SQL.add(MakeSQL(TransSQL(35, True)));
      SQL.add(MakeSQL(TransSQL(36, True)));
      SQL.add(MakeSQL(TransSQL(37, True)));
      SQL.add(MakeSQL(TransSQL(38, True)));
      SQL.add(MakeSQL(TransSQL(39, True)));
      SQL.add(MakeSQL(TransSQL(40, True)));
      SQL.add(MakeSQL(TransSQL(41, True)));
      SQL.add(MakeSQL(TransSQL(42, True)));
      SQL.add(MakeSQL(TransSQL(43, True)));
      SQL.add(MakeSQL(TransSQL(44, True)));
      SQL.add(MakeSQL(TransSQL(45, True)));
      SQL.add(MakeSQL(TransSQL(46, True)));
      SQL.add(MakeSQL(TransSQL(47, True)));
      SQL.add(MakeSQL(TransSQL(48, True)));
      SQL.add(MakeSQL(TransSQL(49, True)));
      SQL.add(MakeSQL(TransSQL(50, True)));
      SQL.add(MakeSQL(TransSQL(51, True)));
      SQL.add(MakeSQL(TransSQL(52, True)));
      SQL.add(MakeSQL(TransSQL(53, True)));
      SQL.add(MakeSQL(TransSQL(54, True)));
      SQL.add(MakeSQL(TransSQL(55, True)));
      SQL.add(MakeSQL(TransSQL(56, True)));
      SQL.add(MakeSQL(TransSQL(57, True)));
      SQL.add(MakeSQL(TransSQL(58, True)));
      SQL.add(MakeSQL(TransSQL(59, True)));
      SQL.add(MakeSQL(TransSQL(60, True)));
      SQL.add(MakeSQL(TransSQL(61, True)));
      SQL.add(MakeSQL(TransSQL(62, True)));
      SQL.add(MakeSQL(TransSQL(63, True)));
      SQL.add(MakeSQL(TransSQL(64, True)));
      SQL.add(MakeSQL(TransSQL(65, True)));
      SQL.add(MakeSQL(TransSQL(67, True)));
      SQL.add(MakeSQL(TransSQL(69, True)));
      SQL.add(MakeSQL(TransSQL(70, True)));
      SQL.add(MakeSQL(TransSQL(71, True)));
      SQL.add(MakeSQL(TransSQL(72, True)));
      SQL.add(MakeSQL(TransSQL(73, True)));
      SQL.add(MakeSQL(TransSQL(74, True)));
      SQL.add(MakeSQL(TransSQL(75, True)));
      SQL.add(MakeSQL(TransSQL(76, True)));
      SQL.add(MakeSQL(TransSQL(77, True)));
      SQL.add(MakeSQL(TransSQL(78, True)));
      SQL.add(MakeSQL(TransSQL(79, True)));
      SQL.add(MakeSQL(TransSQL(80, True)));
      SQL.add(MakeSQL(TransSQL(81, True)));
      SQL.add(MakeSQL(TransSQL(83, True)));
      SQL.add(MakeSQL(TransSQL(84, True)));
      SQL.add(MakeSQL(TransSQL(85, True)));
      SQL.add(MakeSQL(TransSQL(87, True)));
      SQL.add(MakeSQL(TransSQL(92, True)));
      SQL.add(MakeSQL(TransSQL(93, True)));

      fsTransSQLFields := TransSQLFields(66);
      SQL.add(MakeSQL(TransSQL(66, True)));
      SQL.add('truncate rpt_tbltransactions;');
      SQL.add('insert ignore into rpt_tbltransactions select * from tbltransactions;');

    finally
      Free;
    end;
    //Logtext(SQL.text);
    ExecutewithProgress;
  end;
end;

procedure TERPUpdateFixGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  (*Opendb(cboAccountLinesQry);
  Opendb(cboEmployeeLookup);
  if GuiPrefs.Node.Exists('Options.EmployeeID') then
    cboEmployeeLookup.Locate('employeeID', GuiPrefs.Node['Options.EmployeeID'].asInteger, []);

  if GuiPrefs.Node.Exists('Options.AccountID') then
    cboAccountLinesQry.Locate('AccountID', GuiPrefs.Node['Options.AccountID'].asInteger, []);*)
end;

procedure TERPUpdateFixGUI.ShowStatus(const Value: String);
begin
  inherited;
  Logtext(FormatDateTime('dd-mm-yyyy  hh:nn:ss am/pm', now) + ' ---- ' + Value);
end;

procedure TERPUpdateFixGUI.WriteGuiPrefExtra;
begin
  inherited;
  (*GuiPrefs.Node['Options.AccountID'].asInteger := cboAccountLinesQryAccountID.asInteger;
  GuiPrefs.Node['Options.EmployeeID'].asInteger := cboEmployeeLookupEmployeeID.asInteger;*)
end;
(*procedure TERPUpdateFixGUI.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TChartOfAccountsListExpressGUI', ChooseAccount);
end;
procedure TERPUpdateFixGUI.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TEmployeeExpresslistGUI', ChooseEmployee);
end;*)
(*procedure TERPUpdateFixGUI.ChooseEmployee(Sender: TwwDbGrid);
begin
   opendb(cboEmployeeLookup);
   cboEmployeeLookup.locate('EmployeeId' , Sender.Datasource.Dataset.fieldbyname('EmployeeId').asInteger , []);
end;
procedure TERPUpdateFixGUI.ChooseAccount(Sender: TwwDbGrid);
begin
   opendb(cboAccountLinesQry);
   cboAccountLinesQry.locate('accountID' , Sender.Datasource.Dataset.fieldbyname('AccountId').asInteger , []);
end;*)

initialization
  RegisterClassOnce(TERPUpdateFixGUI);

end.
