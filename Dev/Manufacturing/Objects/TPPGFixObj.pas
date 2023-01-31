unit TPPGFixObj;

interface

uses classes , ERPdbComponents;

Type
  TPPGFix = class(Tcomponent)
  Private
    fConnection :TERPConnection;
    Function Connection :TERPConnection;
  Protected
  Public
      Procedure MakeJournals(Const aSaleID:Integer);
      procedure FixProcProgressDuplicates(Const aSaleID:Integer);
      procedure FixPPG(Const aSaleID:Integer);
      constructor Create (AOwner :Tcomponent ; aconn :TERPConnection);
  end;

implementation
uses  AppEnvironment, CommonDbLib, DbSharedObjectsObj, TransactionsTableLib,
  CommonLib, LogLib , SysUtils, BusObjGLAccount, BusObjEmployee;

function TPPGFix.Connection: TERPConnection;
begin
   if Assigned(fConnection) and (fConnection.connected) then Result := fConnection
   else result := CommonDbLib.GetSharedMyDacConnection;
end;

constructor TPPGFix.Create (AOwner :Tcomponent ; aconn :TERPConnection);
begin
  inherited Create(AOwner);
  fConnection := aconn;
end;

Procedure TPPGFix.MakeJournals(Const aSaleID:Integer);
var
  sct1,sct2,sct3 :TERPScript;
  Qry1 :TERPQuery;
  fsTablename : String;
  fsGeTablename :String;
  fsGeDetailTablename :String;
begin
  if AppEnv.CompanyPrefs.PPGBalanceAdjAccountID  = 0 then exit;
  if AppEnv.CompanyPrefs.PPGBalanceAdjEmployeeID = 0 then exit;

  fsTablename := commondblib.GetUserTemporaryTableName('PPGmismatch');
  sct1 := DbSharedObj.GetScript(GetSharedMyDacConnection);//GetSharedScript('', False) ;
  sct2 := DbSharedObj.GetScript(connection);//GetSharedScript('', true) ;
  sct3 := DbSharedObj.GetScript(GetSharedMyDacConnection);//GetSharedScript('', False) ;
  qry1 := DbSharedObj.GetQuery(GetSharedMyDacConnection);//GetShareddataset('', False) ;

  try
        sct1.SQL.Clear;
        sct2.SQL.Clear;
        sct3.SQL.Clear;
        qry1.SQL.Clear;

        {Create temp table with PPG records of this sale}
              with TTransactionTableExtra.Create(False) do try
                sct1.SQL.TExt := TransSQL(87, true, asaleId);
              finally
                Free;
              end;
              sct1.SQL.TExt := 'Drop table if exists ' + fsTablename +'1;' + 'Create table ' + fsTablename +'1 ' +sct1.SQL.TExt+';';
              sct1.SQL.add('drop table if exists ' + fsTablename +';');
              sct1.SQL.add('create table ' + fsTablename +' '+
                            ' select '+
                            ' SaleID, '+
                            ' DATE, '+
                            ' classid, '+
                            ' sum(DebitsEx) as DebitsEx, '+
                            ' sum(CreditsEx) as CreditsEx, '+
                            ' sum(DebitsInc) as DebitsInc, '+
                            ' sum(CreditsInc) as CreditsInc '+
                            ' from ' + fsTablename +'1 '+
                            ' group by saleID , date '+
                            ' having abs(round(DebitsEx-CreditsEx,5))>0.05 or '+
                            ' abs(round(DebitsInc-CreditsInc,5))>0.05 '+
                            ' Order by date; ');

              sct1.SQL.add('ALTER TABLE ' + fsTablename +' 	ADD COLUMN ID INT(11) NOT NULL AUTO_INCREMENT FIRST, 	ADD PRIMARY KEY (ID);');
              sct1.SQL.add('ALTER TABLE ' + fsTablename +' ADD COLUMN  	classname VARCHAR(255) NULL DEFAULT "";');
              sct1.SQL.add('UPDATE ' + fsTablename +' t INNER JOIN tblclass c ON t.classid = c.classid SET t.classname = c.classname;');


              sct1.SQL.add('  Alter table ' + fsTablename +' add column GJID int(11) null default null;');
              //sct1.SQL.add('  Alter table tblgeneraljournal add column ' + fsTablename +'Id int(11) null default 0;');
              fsGeTablename := fstablename+'_GE';
              fsGeDetailTablename := fstablename+'_GED';
              sct1.SQL.add(MakeTableSQL('tblgeneraljournal', 'GJID' ,fsGeTablename));
              sct1.SQL.add('  Alter table '+ fsGeTablename +' add column ' + fsTablename +'Id int(11) null default 0;');
              sct1.SQL.add(MakeTableSQL('tblgeneraljournaldetails', 'GJDID' ,fsGeDetailTablename));

        {check if has mismatch}
              qry1.SQL.add('  Select count(*) as ctr from ' + fsTablename +' where abs(Debitsinc-Creditsinc )> 0.05; ');

        {Create Journal Entry}
              sct2.SQL.add('  INSERT INTO ' + fsGeTablename +'  (TransactionDate, TransactionNo, Amount , ' + fsTablename +'Id) '+
                            '   Select Date TransactionDate ,concat("Adj-", ID) as TransactionNo, Debitsinc-Creditsinc as Amount , Id from ' + fsTablename +'; ');
              sct2.SQL.add('  update ' + fsTablename +' T inner join ' + fsGeTablename +'  G on T.ID  = G.' + fsTablename +'Id Set T.GJID = G.GJID;');

              sct2.SQL.add('INSERT INTO ' + fsGeDetailTablename +'  '+
                            ' (GJID ,AccountName ,AccountID ,DebitAmount ,DebitAmountInc,Creditamount ,Creditamountinc ,ClassName ,ClassID ,accountnumber ,employeeId,employeename) '+
                            ' SELECT GJID, ' + quotedstr(TAccount.IDToggle(AppEnv.CompanyPrefs.PPGBalanceAdjAccountID))+' AS accountname , '+
                            ' '+ inttostr(AppEnv.CompanyPrefs.PPGBalanceAdjAccountID)+' AS accountid, '+
                            ' 0 AS DebitAmount , '+
                            ' 0 AS Creditamount, '+
                            ' DebitsInc-CreditsInc AS DebitAmountInc , '+
                            ' 0 AS Creditamountinc , '+
                            ' classname, '+
                            ' classid,  '+
                            ' ' + quotedstr(TAccount.AccountNumberForID(AppEnv.CompanyPrefs.PPGBalanceAdjAccountID))+'  AS accountnumber, '+
                            ' '+ inttostr(AppEnv.CompanyPrefs.PPGBalanceAdjEmployeeID)+' AS Employeeid ,  '+
                            ' ' + quotedstr(TEmployee.IDToggle(AppEnv.CompanyPrefs.PPGBalanceAdjEmployeeID))+'  AS Employeename '+
                            ' FROM ' + fsTablename +';');

              sct2.SQL.Add('insert ignore into tblgeneraljournal ('       + GetFieldNames('tblgeneraljournal')        +') Select '+ GetFieldNames('tblgeneraljournal')       + ' from '+ fsGeTablename+';');
              sct2.SQL.Add('insert ignore into tblgeneraljournaldetails ('+ GetFieldNames('tblgeneraljournaldetails') +') Select '+ GetFieldNames('tblgeneraljournaldetails')+ ' from '+ fsGeDetailTablename+';');
        {Delete Temp table}
              //sct3.SQL.add('Alter table tblgeneraljournal drop column ' + fsTablename +'Id ;');
              sct3.SQL.add('drop table if exists ' + fsTablename +';');
              sct3.SQL.add('drop table if exists ' + fsGeTablename +';');
              sct3.SQL.add('drop table if exists ' + fsGeDetailTablename  +';');

        logtext(sct1.SQL.Text);
        sct1.Execute;
        logtext(qry1.SQL.Text);
        qry1.open;
        if qry1.fieldbyname('ctr').asInteger >0 then begin
          logtext(sct2.SQL.Text);
          sct2.Execute;
        end;
        logtext(sct3.SQL.Text);
        sct3.Execute;
  finally
     DbSharedObj.ReleaseObj(sct1);
     DbSharedObj.ReleaseObj(sct2);
     DbSharedObj.ReleaseObj(sct3);
     DbSharedObj.ReleaseObj(qry1);
  end;
end;
Procedure TPPGFix.FixProcProgressDuplicates(Const aSaleID:Integer);
var
  qry: TERPQuery;
  sct1 :TERPScript;
  fsTablename :String;
begin
  fsTableName := GetUserTemporaryTableName('BOnshipqty');
  sct1 := DbSharedObj.GetScript(GetSharedMyDacConnection);//GetSharedScript('', False) ;
  try
      With sct1 do begin
        SQL.clear;
        SQL.Add('Drop table if exists ' + fstablename +';');
        SQL.Add('Create table ' + fstablename +' SELECT ppg.inprocprogressid,  ' +
                                                      ' ppg.proctreepartId,  ' +
                                                      ' COUNT(ppg.Procprogressid) ctr,  ' +
                                                      ' MIN(ppg.ProcprogressID) minProcprogressID,  ' +
                                                      ' MAX(ppg.ProcprogressID) AS maxProcprogressID ' +
                                                  ' FROM tblsaleslines sl  ' +
                                                      ' inner join tblproctree pt on pt.masterid = sl.salelineid and pt.mastertype <> "mtProduct"  ' +
                                                      ' inner join tblprocprogress ppg on ppg.proctreeid = pt.ProcTreeId' +
                                                  ' WHERE ' + iif(asaleId<> 0 , 'SL.saleId = '+ inttostr(asaleId)+' and' , '')+' IFNULL(ppg.inprocprogressid,0)<> 0 ' +
                                                  ' GROUP BY ppg.inprocprogressid, ppg.proctreepartId ' +
                                                  ' HAVING ctr>1;' );
        SQL.Add('ALTER TABLE  ' + fstablename +'  ADD INDEX maxProcprogressID (maxProcprogressID);');
        SQL.Add('Delete from tblprocprogress where Procprogressid in (Select  maxProcprogressID from '+ fstablename +');');
        SQL.Add('Drop table if exists ' + fstablename +';');
        Logtext(SQL.text);
      end;

    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      repeat
          Logtext(sct1.SQL.text);
          sct1.Execute;
          closedb(qry);
          qry.sql.text := 'SELECT ppg.inprocprogressid, ppg.proctreepartId,  ' +
                                ' COUNT(ppg.Procprogressid) ctr  ' +
                                ' FROM tblsaleslines sl  ' +
                                    ' inner join tblproctree pt on pt.masterid = sl.salelineid and pt.mastertype <> "mtProduct"  ' +
                                    ' inner join tblprocprogress ppg on ppg.proctreeid = pt.ProcTreeId' +
                                ' WHERE ' + iif(asaleId<> 0 , 'SL.saleId = '+ inttostr(asaleId)+' and' , '')+'  IFNULL(inprocprogressid,0)<> 0 ' +
                                ' GROUP BY ppg.inprocprogressid, ppg.proctreepartId ' +
                                ' HAVING ctr>1 LIMIT 10 ' ;
          Opendb(qry);
          Logtext('FixProcProgressDuplicates : '+ inttostr(qry.REcordcount));
      until qry.REcordcount =0;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(sct1);
  end;
  end;

Procedure TPPGFix.FixPPG(Const aSaleID:Integer);
var
  //ctr1, ctr2, ctr3:Integer;
  //dtbeforeupdate:TDatetime;
  fsTablename1, fsTablename2, fstablename3 :String;
  sct1 :TERPScript;
begin
  sct1 := DbSharedObj.GetScript(GetSharedMyDacConnection);//GetSharedScript('', False) ;
  try
      With sct1 do begin
        SQL.clear;
        fsTablename1 := commondblib.GetUserTemporaryTableName('FixPPG');
        fsTablename2 := fsTablename1+'2';
        fstablename3 := fsTablename1+'3';
        fsTablename1 := fsTablename1+'1';

        {Create missing subnodes}
        SQL.add('Drop table if exists '+ fsTablename1 +';');
        SQL.add('create table '+ fsTablename1 +' select max(ProcprogressID) maxProcprogressID from tblprocprogress;');

        SQL.add('Drop table if exists '+ fsTablename2 +';');
        SQL.add('create table '+ fsTablename2 +' select max(pqaid) maxpqaid from tblpqa;');

        {some of the raw materials are missing from Progress build}
        SQL.add('insert ignore into tblprocprogress');
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
        SQL.add('INNER JOIN tblsales s ON s.saleID = sl.saleID ' + iif(asaleId<> 0 , ' AND S.saleId = '+ inttostr(asaleId) , ''));
        SQL.add('WHERE ppg.Alloctype ="IN"');
        SQL.add('AND IFNULL(cppg.ProcProgressID,0)=0;');



        SQL.add('insert ignore into tblpqa');
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
        SQL.add('inner join tblsaleslines sl on sl.SaleLineID = pt.MasterId ' + iif(asaleId<> 0 , ' and SL.saleId = '+ inttostr(asaleId) , '')+'');
        SQL.add('where procprogressid > (Select maxProcprogressID from '+ fsTablename1 +');');

        {all PPG in transactions}
        SQL.add('DROP TABLE If EXISTS '+ fsTablename1 +'_in;');
        SQL.add('CREATE TABLE '+ fsTablename1 +'_in '+
                  ' SELECT ppg.ProcProgressid, ppg.productid, ppg.proctreeid, ppg.ProctreepartID, ppg.qty, ppg.Productunitcost  '+
                  ' FROM tblsaleslines Sl inner join  tblproctree PT on pt.masterId = sl.salelineid and pt.mastertype <> "mtProduct"'+
                  ' inner join tblprocprogress ppg   on PT.proctreeid = ppg.proctreeid ' +
                  ' WHERE ' + iif(asaleId<> 0 , 'SL.saleId = '+ inttostr(asaleId)+' and' , '')+' ppg.alloctype = "IN";');
        {all PPG outs}
        SQL.add('DROP TABLE If EXISTS '+ fsTablename1 +'_out;');
        SQL.add('CREATE TABLE '+ fsTablename1 +'_out  '+
                  ' SELECT ppg.ProcProgressid, ppg.inProcProgressid, ppg.productid, ppg.proctreeid, ppg.ProctreepartID, ppg.qty, ppg.Productunitcost  '+
                  ' FROM tblsaleslines Sl inner join  tblproctree PT on pt.masterId = sl.salelineid and pt.mastertype <> "mtProduct"'+
                  ' inner join tblprocprogress ppg   on PT.proctreeid = ppg.proctreeid ' +
                  ' WHERE ' + iif(asaleId<> 0 , 'SL.saleId = '+ inttostr(asaleId)+' and' , '')+' ppg.alloctype = "OUT" and ifnull(ppg.inProcProgressid,0)<>0;');
        SQL.add('ALTER TABLE '+ fsTablename1 +'_in ADD INDEX ProcProgressid (ProcProgressid);');
        SQL.add('ALTER TABLE '+ fsTablename1 +'_out ADD INDEX ProcProgressid (ProcProgressid);');
        SQL.add('ALTER TABLE '+ fsTablename1 +'_out ADD INDEX inProcProgressid (inProcProgressid);');

        {total cost from outs}
        SQL.add('DROP TABLE If EXISTS '+ fsTablename1 +'_outsum;');
        SQL.add('CREATE TABLE '+ fsTablename1 +'_outsum  '+
                  ' SELECT inProcProgressid ,  '+
                  ' SUM(qty*Productunitcost) AS totalcost  '+
                  ' FROM '+ fsTablename1 +'_out GROUP BY inProcProgressid;');
        {list of INs where the cost doesn't mathc with the OUT's total cost}
        SQL.add('DROP TABLE If EXISTS '+ fsTablename1 +'_inMismatch;');
        SQL.add('CREATE TABLE '+ fsTablename1 +'_inMismatch  '+
                  ' SELECT tin.ProcProgressid, tin.productid, tin.proctreeid, tin.ProctreepartID,  '+
                  ' tin.qty, tin.Productunitcost ,  '+
                  ' tout.totalcost  '+
                  ' FROM '+ fsTablename1 +'_in tin  '+
                  ' INNER JOIN '+ fsTablename1 +'_outsum tout ON tin.ProcProgressid = tout.inProcProgressid  '+
                  ' WHERE tin.productunitcost <> tout.totalcost;');

        {update the In's cost from Sum of OUTS's cost }
        SQL.add('update tblprocprogress ppg  '+
                  ' INNER JOIN '+ fsTablename1 +'_inMismatch T ON ppg.ProcProgressID = T.ProcProgressid  '+
                  ' SET ppg.ProductUnitCost = T.totalcost;');
        {delete all temp tables}
        SQL.add('DROP TABLE If EXISTS '+ fsTablename1 +'_in;');
        SQL.add('DROP TABLE If EXISTS '+ fsTablename1 +'_out;');
        SQL.add('DROP TABLE If EXISTS '+ fsTablename1 +'_outsum;');
        SQL.add('DROP TABLE If EXISTS '+ fsTablename1 +'_inMismatch;');

        (*ctr1:= GetTableRecordCount('tblprocprogress');
        dtbeforeupdate := now;*)
        Logtext(SQL.text);
        Execute;
        (*ctr2:= GetTableRecordCount('tblprocprogress');
        ctr3:= GetTableRecordCount('tblprocprogress', 'mstimeStamp >= ' + quotedstr(formatdatetime(mysqldatetimeformat , dtbeforeupdate)));*)

        SQL.clear;
        SQL.add('DROP TABLE if EXISTS '+ fsTablename3 +';');
        SQL.add('CREATE TABLE '+ fsTablename3 +' LIKE tblprocprogress;');
        SQL.add('ALTER TABLE '+ fsTablename3 +' ADD COLUMN saleId INT(11) NULL DEFAULT NULL;');
        SQL.add('ALTER TABLE '+ fsTablename3 +' ADD COLUMN saleLineID INT(11) NULL DEFAULT NULL;');

        SQL.add('INSERT IGNORE INTO '+ fsTablename3 +'  ' +
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
                      ' INNER JOIN tblsaleslines    sl    ON sl.SaleLineID  = ppt.MasterId ' + iif(asaleId<> 0 , ' and SL.saleId = '+ inttostr(asaleId) , '') +
                      ' WHERE ifnull(inprocprogressid,0)<> 0 and inprocprogressid  NOT IN (SELECT procprogressid FROM tblprocprogress) ' +
                      ' GROUP BY ppg.inprocprogressid ;');

        SQL.add('INSERT IGNORE INTO tblpqa  ' +
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
                      ' FROM '+ fsTablename3 +' T inner join tblparts P ON T.productId = P.PARTSID;');

        SQL.add('INSERT IGNORE INTO tblprocprogress  ' +
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
                      ' FROM  '+ fsTablename3 +' ;');
        SQL.add('DROP TABLE if EXISTS '+ fsTablename3 +';');
        (*ctr1:= GetTableRecordCount('tblprocprogress');
        dtbeforeupdate := now;*)
        Logtext(SQL.text);
        Execute;
    end;
  finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(sct1);
  end;
end;
end.
