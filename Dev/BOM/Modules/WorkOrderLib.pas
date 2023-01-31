unit WorkOrderLib;

interface

uses ProgressDialog;

Procedure Track_processpartqty(const tmp_processpartqty , tmp_processtime:String);
Procedure PopulateWorkOrderReportTable(const Tablename :String; DateFrom , Dateto:TdateTime; SaleLineID:Integer);
Procedure MakeQrymain(const Tablename, tmp_processpartqty , tmp_processtime :String ;DateFrom , Dateto:TdateTime);

implementation

uses ERPdbComponents, DbSharedObjectsObj, CommonDbLib, tcConst, LogLib , SysUtils,
  MySQLConst, CommonLib;

procedure MakeQrymain(const Tablename, tmp_processpartqty , tmp_processtime :String;DateFrom , Dateto:TdateTime);
var
  qryprocesspartqty: TERPQuery;
  fiSAleID      , fiSaleLineID      , fiProctreeId      , fiProcessPartId     , fiResDetId     ,fiResID, fiPSID     :Integer;
  fiSAle_RowNum , fiSaleLine_RowNum , fiProctree_RowNum , fiProcessPart_RowNum, fiResDet_RowNum,fiREs_RowNum, fiPS_RowNum:Integer;
  scr :TERPScript;
begin
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    With scr do begin
        SQL.clear;
        SQl.add('Drop table if exists '+ Tablename+';');
        SQl.add('CREATE TABLE   '+ Tablename+' ( ' +
                ' ID                  int(11) NOT NULL AUTO_INCREMENT, ' +
                ' Details             int(11) NOT NULL DEFAULT 0 , ' +
                ' PPQID               int(11) NOT NULL DEFAULT 0 , ' +
                ' ProcessPartId       int(11) DEFAULT NULL, ' +
                ' Builddate           datetime DEFAULT NULL, ' +
                ' QtyScheduled        double DEFAULT NULL, ' +
                ' SaleID              int(11) DEFAULT NULL, ' +
                ' SaleLineID          int(11) DEFAULT NULL, ' +
                ' ProductNAme         varchar(255) DEFAULT NULL, ' +
                ' Level               int(11) DEFAULT NULL, ' +
                ' Caption             varchar(255) DEFAULT NULL, ' +
                ' ProcTreeID          int(11) DEFAULT NULL, ' +
                ' ProcessStepId       int(11) DEFAULT NULL, ' +
                ' ProcessStepSeq      int(11) DEFAULT NULL, ' +
                ' ProcessStep         varchar(255) DEFAULT NULL, ' +
                ' ProcessTimeId       int(11) DEFAULT NULL, ' +
                ' TimeStart           datetime DEFAULT NULL, ' +
                ' TimeEnd             datetime DEFAULT NULL, ' +
                ' Duration            double DEFAULT NULL, ' +
                ' cDuration           varchar(255) DEFAULT NULL, ' +
                ' Active              enum("T","F") CHARACTER SET latin1 DEFAULT NULL, ' +
                ' ResDetID            int(11) NOT NULL DEFAULT 0 , ' +
                ' ResID               int(11) NOT NULL DEFAULT 0 , ' +
                ' Resourcedetails     varchar(255) DEFAULT NULL, ' +
                ' Resource            varchar(255) DEFAULT NULL, ' +
                ' EmployeeId          int(11) DEFAULT NULL, ' +
                ' employeeName        varchar(255) DEFAULT NULL, ' +
                ' PCTQ_SchdID         int(11) DEFAULT 0 , ' +
                ' PCTQ_BuiltID        int(11) DEFAULT 0 , ' +
                ' SAle_RowNum         int(11) DEFAULT NULL, ' +
                ' SaleLine_RowNum     int(11) DEFAULT NULL, ' +
                ' Proctree_RowNum     int(11) DEFAULT NULL, ' +
                ' ProcessPart_RowNum  int(11) DEFAULT NULL, ' +
                ' ResDet_RowNum       int(11) DEFAULT NULL, ' +
                ' Res_RowNum          int(11) DEFAULT NULL, ' +
                ' PS_RowNum           int(11) DEFAULT NULL, ' +
                ' Selected            enum("T","F") DEFAULT "F", ' +
                ' FormulaId           int(11) default 0,'+
                ' FormulaName         varchar(255),'+
                ' formula             varchar(255),'+
                ' formulaDetails      varchar(255),'+
                ' FormulaQty1         Double, '+
                ' FormulaQty2         Double, '+
                ' FormulaQty3         Double, '+
                ' FormulaQty4         Double, '+
                ' FormulaQty5         Double, '+
                ' FormulaQty          Double, '+
                ' PRIMARY KEY (ID) ' +
                ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8 ;');

        SQl.add('insert into  '+ Tablename+
            ' (Details,PPQID,ProcessPartId,ProcessStepID, ProcessStep , Builddate,QtyScheduled,SaleID	,SaleLineID,ProductNAme,'+
            ' Level,Caption,ProcTreeID,TimeStart,TimeEnd,Duration,cDuration,ResDetID,ResID,'+
            'FormulaId, Formulaname,formula,formulaDetails,FormulaQty,FormulaQty1,FormulaQty2,FormulaQty3,FormulaQty4,FormulaQty5 )');
        SQl.add('Select');
        SQl.add('Distinct 1 as Details ,');
        SQl.add('PPQ.ID as PPQID,');
        SQl.add('PPQ.ProcessPartId	 as ProcessPartId	,');
        SQl.add('PPQ.ProcessStepID	 as ProcessStepID	,');
        SQl.add('PPQ.ProcessStep	 as ProcessStep	,');
        SQl.add('PPQ.Builddate as Builddate ,');
        SQl.add('PPQ.QtyScheduled AS QtyScheduled,');
        SQl.add('PPQ.SaleId AS SaleID	,');
        SQl.add('PPQ.SaleLineId AS SaleLineID,');
        SQl.add('PPQ.ProductNAme AS ProductNAme,');
        SQl.add('PPQ.Level as Level,');
        SQl.add('Convert(TreeNodeCaption(PPQ.Level, PPQ.caption ) , char(255)) as Caption,');
        SQl.add('PPQ.ProcTreeID as ProcTreeID,');
        SQl.add('Min(PPT.TimeStart) as TimeStart	,');
        SQl.add('Max(TimeEnd) as TimeEnd	,');
        SQl.add('Sum(PPT.Duration) as Duration	,');
        SQl.add('FormatSecondsTotime(Sum(PPT.Duration)) as cDuration	,');
        SQl.add('Convert(0, SIGNED) as ResDetID       ,');
        SQl.add('Convert(0, SIGNED) as ResID ,  ');
        SQl.add('PPQ.FormulaId,  ');
        SQl.add('PPQ.Formulaname, ');
        SQl.add('PPQ.formula, ');
        SQl.add('PPQ.formulaDetails, ');
        SQl.add('PPQ.FormulaQty, ');
        SQl.add('PPQ.FormulaQty1, ');
        SQl.add('PPQ.FormulaQty2, ');
        SQl.add('PPQ.FormulaQty3, ');
        SQl.add('PPQ.FormulaQty4, ');
        SQl.add('PPQ.FormulaQty5 ');
        SQl.add('from '+ tmp_processpartqty +' PPQ ');
        SQl.add('inner join '+ tmp_processtime +' PPT on PPT.PCTQ_SchdID = PPQ.ID');
        if DateFrom <> 0 then SQl.add('Where PPQ.Builddate between '+ Quotedstr(formatDateTime(mySQLDatetimeFormat , DateFrom))+' and '+ Quotedstr(formatDateTime(mySQLDatetimeFormat , dateTo))+'');
        SQl.add('Group by PPQ.ID;');

        SQl.add('insert into  '+ Tablename+
                 ' (Details,PPQID,ProcessPartId,Builddate,QtyScheduled,SaleID,SaleLineID,ProductNAme,Level,Caption,ProcTreeID,ProcessStepId,'+
                 'ProcessStepSeq,ProcessStep,ProcessTimeId,TimeStart,TimeEnd,Duration,cDuration,Active,ResDetID,ResID,Resourcedetails,Resource,'+
                 'employeeName,EmployeeId, PCTQ_SchdID,PCTQ_BuiltID,'+
            'FormulaId, Formulaname,formula,formulaDetails,FormulaQty,FormulaQty1,FormulaQty2,FormulaQty3,FormulaQty4,FormulaQty5 )');
        SQl.add('SELECT');
        SQl.add('2 AS Details,');
        SQl.add('PPQ.ID as PPQID,');
        SQl.add('PPQ.ProcessPartId AS ProcessPartId	,');
        SQl.add('PPQ.Builddate AS Builddate,');
        SQl.add('PPQ.QtyScheduled AS QtyScheduled,');
        SQl.add('PPQ.SaleId AS SaleID	,');
        SQl.add('PPQ.SaleLineId AS SaleLineID,');
        SQl.add('PPQ.ProductNAme AS ProductNAme,');
        SQl.add('PPQ.Level as Level,');
        SQl.add('Convert(TreeNodeCaption(PPQ.Level, PPQ.caption ) , char(255)) as Caption,');
        SQl.add('PPQ.ProcTreeID as ProcTreeID,');
        SQl.add('PPQ.ProcessStepId as ProcessStepId	,');
        SQl.add('PPQ.ProcessStepSeq as ProcessStepSeq	,');
        SQl.add('PS.Description as ProcessStep	,');
        SQl.add('PPT.ProcessTimeId AS ProcessTimeId	,');
        SQl.add('PPT.TimeStart AS TimeStart	,');
        SQl.add('PPT.TimeEnd AS TimeEnd	,');
        SQl.add('PPT.Duration AS Duration	,');
        SQl.add('FormatSecondsTotime(PPT.Duration) as cDuration	,');
        SQl.add('PPT.Active AS Active	,');
        SQl.add('PRD.ID as ResDetID       ,');
        SQl.add('PR.ProcResourceId as ResID   ,');
        SQl.add('PRD.Description AS Resourcedetails	,');
        SQl.add('PR.ResourceName as Resource,');
        SQl.add('E.employeeName  as employeeName ,');
        SQl.add('E.employeeID  as employeeID ,');
        SQl.add('PPT.PCTQ_SchdID AS PCTQ_SchdID,');
        SQl.add('PPT.PCTQ_BuiltID AS PCTQ_BuiltID ,  ');
        SQl.add('PPQ.FormulaId,  ');
        SQl.add('PPQ.Formulaname, ');
        SQl.add('PPQ.formula, ');
        SQl.add('PPQ.formulaDetails, ');
        SQl.add('PPQ.FormulaQty, ');
        SQl.add('PPQ.FormulaQty1, ');
        SQl.add('PPQ.FormulaQty2, ');
        SQl.add('PPQ.FormulaQty3, ');
        SQl.add('PPQ.FormulaQty4, ');
        SQl.add('PPQ.FormulaQty5 ');
        SQl.add('from '+ tmp_processpartqty +' PPQ ');
        SQl.add('inner join '+ tmp_processtime +' PPT on PPT.PCTQ_SchdID = PPQ.ID');
        SQl.add('inner join tblEmployees E on E.employeeId = PPT.EmployeeId');
        SQl.add('inner join tblprocresourcedetails PRD on PRD.ID  = PPT.ResourcedetailsID');
        SQl.add('inner join tblprocresource PR on PR.ProcResourceId = PRD.ProcResourceId');
        SQl.add('inner join tblprocessstep PS on PPQ.processstepID = PS.ID');
        if DateFrom <> 0 then SQl.add('Where PPQ.Builddate between '+ Quotedstr(formatDateTime(mySQLDatetimeFormat , DateFrom))+' and '+ Quotedstr(formatDateTime(mySQLDatetimeFormat , dateTo))+';');
        logtext(SQl.Text);
        Execute;
    end;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;

  qryprocesspartqty := DbSharedObjectsObj.DbSharedObj.GetQuery(commondblib.GetSharedMyDacConnection);
  try
    Closedb(qryprocesspartqty);
    qryprocesspartqty.SQL.Text := 'Select * from '+Tablename +' Order by SaleId, SaleLineId, Level , ProctreeId , ProcessPartId , Builddate  ,Resource , Resourcedetails ,  details ';
    opendb(qryprocesspartqty);
    if qryprocesspartqty.recordcount >0 then begin
      fiSAleID      := 0;      fiSaleLineID     := 0;      fiProctreeId     := 0;      fiProcessPartId      := 0;fiResDetId      := 0;fiResID   :=0;fiPSID := 0;
      fiSAle_RowNum := 0;      fiSaleLine_RowNum:= 0;      fiProctree_RowNum:= 0;      fiProcessPart_RowNum := 0;fiResDet_RowNum := 0;fiREs_RowNum := 0;fiPS_RowNum := 0;
      qryprocesspartqty.First;
      While qryprocesspartqty.Eof = False do begin
        if fiSAleID         <> qryprocesspartqty.fieldbyname('SaleID').asInteger        then begin
          fiSAleID         := qryprocesspartqty.fieldbyname('SaleID').asInteger        ;
          fiSAle_RowNum       := 1;
        end
        else
          fiSAle_RowNum       := fiSAle_RowNum        +1;
        if fiSaleLineID     <> qryprocesspartqty.fieldbyname('SaleLineID').asInteger    then begin
          fiSaleLineID     := qryprocesspartqty.fieldbyname('SaleLineID').asInteger    ;
          fiSaleLine_RowNum   := 1;
        end
        else
          fiSaleLine_RowNum   := fiSaleLine_RowNum    +1;
        if fiProctreeID     <> qryprocesspartqty.fieldbyname('ProctreeID').asInteger    then begin
          fiProctreeID     := qryprocesspartqty.fieldbyname('ProctreeID').asInteger    ;
          fiProctree_RowNum   := 1;
        end
        else
          fiProctree_RowNum   := fiProctree_RowNum    +1;
        if qryprocesspartqty.fieldbyname('Details').asInteger =2 then
          if fiProcessPartID  <> qryprocesspartqty.fieldbyname('ProcessPartID').asInteger then begin
             fiProcessPartID  := qryprocesspartqty.fieldbyname('ProcessPartID').asInteger ; fiProcessPart_RowNum:= 1;
           end
           else
             fiProcessPart_RowNum:= fiProcessPart_RowNum +1;
        if qryprocesspartqty.fieldbyname('Details').asInteger =2 then
          if fiResDetID       <> qryprocesspartqty.fieldbyname('ResDetID').asInteger      then begin
            fiResDetID       := qryprocesspartqty.fieldbyname('ResDetID').asInteger      ;
            fiResDet_RowNum     := 1;
          end
          else
            fiResDet_RowNum     := fiResDet_RowNum +1;
        if qryprocesspartqty.fieldbyname('Details').asInteger =2 then
          if fiResID          <> qryprocesspartqty.fieldbyname('ResID').asInteger         then begin
            fiResID          := qryprocesspartqty.fieldbyname('ResID').asInteger         ;
            fiRes_RowNum        := 1;
          end
          else
            fiRes_RowNum        := fiRes_RowNum +1;
        if qryprocesspartqty.fieldbyname('Details').asInteger =2 then
          if fiPSID           <> qryprocesspartqty.fieldbyname('ProcessStepId').asInteger then begin
            fiPSID           := qryprocesspartqty.fieldbyname('ProcessStepId').asInteger ;
            fiPS_RowNum         := 1;
          end
          else
            fiPS_RowNum         := fiPS_RowNum +1;

        EditDB(qryprocesspartqty);
        qryprocesspartqty.fieldbyname('Sale_RowNum').asInteger        := fiSAle_RowNum       ;
        qryprocesspartqty.fieldbyname('SaleLine_RowNum').asInteger    := fiSaleLine_RowNum   ;
        qryprocesspartqty.fieldbyname('Proctree_RowNum').asInteger    := fiProctree_RowNum   ;
        qryprocesspartqty.fieldbyname('ProcessPart_RowNum').asInteger := fiProcessPart_RowNum;
        qryprocesspartqty.fieldbyname('ResDet_RowNum').asInteger      := fiResDet_RowNum;
        qryprocesspartqty.fieldbyname('Res_RowNum').asInteger         := fiRes_RowNum;
        qryprocesspartqty.fieldbyname('PS_RowNum').asInteger          := fiPS_RowNum;
        PostDB(qryprocesspartqty);
        qryprocesspartqty.NExt;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryprocesspartqty);
  end;
end;

Procedure Track_processpartqty(const tmp_processpartqty , tmp_processtime:String);
var
  qryprocesspartqty, qryprocesstime: TERPQuery;
  s:String;
begin

  qryprocesspartqty := DbSharedObjectsObj.DbSharedObj.GetQuery(commondblib.GetSharedMyDacConnection);
  qryprocesstime := DbSharedObjectsObj.DbSharedObj.GetQuery(commondblib.GetSharedMyDacConnection);
  try

    {checking for the planned partial build for each processpart record - the partial build is the record in qryprocesspartqty with a Build date > Timeend}
    Closedb(qryprocesspartqty);
    Closedb(qryprocesstime);
    qryprocesspartqty.SQL.Text := 'Select * from '+tmp_processpartqty+' where ifnull(QtyScheduled,0)>0 order by ProcessPartId , BuildDate';
    qryprocesstime.SQL.Text := 'Select * from '+tmp_processtime+' Order by ProcessPartId , TimeEnd ';
    OpenDB(qryprocesspartqty);
    OpenDB(qryprocesstime);
    if (qryprocesstime.RecordCount=0) or (qryprocesspartqty.RecordCount =0) then exit;
    qryprocesspartqty.First;
    qryprocesstime.First;

    While qryprocesstime.EOF = False do begin
        S:=inttostr(qryprocesstime.fieldbyname('ProcessTimeId').AsInteger) +',' +inttostr(qryprocesspartqty.fieldbyname('ProcessPartId').AsInteger)+',' +inttostr(qryprocesstime.fieldbyname('ProcessPartId').AsInteger );
        if qryprocesspartqty.fieldbyname('ProcessPartId').AsInteger > qryprocesstime.fieldbyname('ProcessPartId').AsInteger then begin
          s:= s+',Break-1';
          qryprocesstime.Next;
          continue;
        end;

        While ((qryprocesspartqty.fieldbyname('ProcessPartId').AsInteger<>qryprocesstime.fieldbyname('ProcessPartId').AsInteger) or
              (qryprocesspartqty.fieldbyname('BuildDate').asDatetime< qryprocesstime.fieldbyname('TimeEnd').asDatetime)) and
              (qryprocesspartqty.EOF=False) do begin
                Logtext(s+',' + inttostr(qryprocesspartqty.fieldbyname('ID').asInteger)+',' +
                Formatdatetime('dd-mm-yyyy hh:nn:ss' , qryprocesspartqty.fieldbyname('BuildDate').asDatetime) +',' + Formatdatetime('dd-mm-yyyy hh:nn:ss' , qryprocesstime.fieldbyname('TimeEnd').asDatetime)+
                ',Loop') ;
                qryprocesspartqty.Next;
        end;

        if (qryprocesspartqty.EOF=False) and (qryprocesspartqty.fieldbyname('ProcessPartId').AsInteger<>qryprocesstime.fieldbyname('ProcessPartId').AsInteger) then begin
          Logtext(s+',' + inttostr(qryprocesspartqty.fieldbyname('ID').asInteger)+',break-2') ;
          break;
        end;

        if (qryprocesspartqty.fieldbyname('BuildDate').asDatetime>= qryprocesstime.fieldbyname('TimeEnd').asDatetime) or (qryprocesspartqty.EOF)  then begin
          s:= s+',' + inttostr(qryprocesspartqty.fieldbyname('ID').asInteger)+', updating';
          Editdb(qryprocesstime);
          qryprocesstime.Fieldbyname('PCTQ_SchdID').AsInteger := qryprocesspartqty.Fieldbyname('ID').AsInteger;
          Postdb(qryprocesstime);
        end;
        Logtext(s);
      DoStepProgressbar;
      qryprocesstime.Next;
    end;

    {checking for the planned partial build for each processpart record - the partial build is the record in qryprocesspartqty with a Build date > Timeend}
    Closedb(qryprocesspartqty);
    Closedb(qryprocesstime);
    qryprocesspartqty.SQL.Text := 'Select * from '+tmp_processpartqty+' where ifnull(QtyBuilt,0)>0 order by ProcessPartId , BuildDate';
    qryprocesstime.SQL.Text := 'Select * from '+tmp_processtime+' Order by ProcessPartId , TimeEnd ';
    OpenDB(qryprocesspartqty);
    OpenDB(qryprocesstime);
    if (qryprocesstime.RecordCount=0) or (qryprocesspartqty.RecordCount =0) then exit;
    qryprocesspartqty.First;
    qryprocesstime.First;

    While qryprocesstime.EOF = False do begin

      While (qryprocesspartqty.fieldbyname('ProcessPartId').AsInteger<>qryprocesstime.fieldbyname('ProcessPartId').AsInteger) or
            (qryprocesspartqty.fieldbyname('BuildDate').asDatetime< qryprocesstime.fieldbyname('TimeEnd').asDatetime) or
            (qryprocesspartqty.EOF) do qryprocesspartqty.Next;

      if qryprocesspartqty.fieldbyname('ProcessPartId').AsInteger<>qryprocesstime.fieldbyname('ProcessPartId').AsInteger then exit;

      if (qryprocesspartqty.fieldbyname('BuildDate').asDatetime>= qryprocesstime.fieldbyname('TimeEnd').asDatetime)  then begin
        Editdb(qryprocesstime);
        qryprocesstime.Fieldbyname('PCTQ_BuiltID').AsInteger := qryprocesspartqty.Fieldbyname('ID').AsInteger;
        Postdb(qryprocesstime);
      end;
      DoStepProgressbar;
      qryprocesstime.Next;
    end;



  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryprocesspartqty);
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryprocesstime);
  end;


end;

Procedure PopulateWorkOrderReportTable(const Tablename :String; DateFrom , Dateto:TdateTime; SaleLineID:Integer);
var
  scr :TERPScript;
  tmp_processpartqty:String;
  tmp_processtime:String;
begin
  tmp_processpartqty := Tablename+'_1';//CommonDbLib.GetUserTemporaryTablename('EMP_PPQ' );
  tmp_processtime :=Tablename+'_2';//CommonDbLib.GetUserTemporaryTablename('EMP_PPT' );
  try
    scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
    try
        DoShowProgressbar(20, WAITMSG);
        try
          With scr do begin
            SQL.Clear;
            SQL.Add('Drop table if exists '+tmp_processpartqty+';');
            SQL.Add('Drop table if exists '+tmp_processtime+';');
            SQL.Add('Create table '+tmp_processpartqty+' like tblprocesspartqty;');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column SaleID int(11); ');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column SaleLineID int(11); ');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column Productname varchar(255); ');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column ProctreeId int(11); ');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column TreeRootId int(11); ');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column Level int(11); ');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column Caption varchar(255); ');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column ProcessStepId int(11); ');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column ProcessStepSeq int(11); ');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column FormulaId int(11); ');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column FormulaQty1 Double;');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column FormulaQty2 Double;');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column FormulaQty3 Double;');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column FormulaQty4 Double;');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column FormulaQty5 Double;');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column FormulaQty Double;');


            SQL.Add('insert ignore into '+tmp_processpartqty+' select distinct PPQ.* , SL.saleId, Sl.saleLineId,  SL.productname,'+
                    ' PT.proctreeId, PT.TreeRootId, PT.level , PT.caption , PP.processstepId , PP.ProcessStepSeq, PT.formulaId ,'+
                    ' PT.FormulaQtyValue1 , PT.FormulaQtyValue2, PT.FormulaQtyValue3, PT.FormulaQtyValue4, PT.FormulaQtyValue5,PT.FormulaQtyValue '+
                    ' from tblsales S '+
                    ' inner join tblsaleslines SL on S.saleId = SL.saleId '+
                    ' inner join tblproctree PT on SL.saleLineID = PT.masterId and PT.MasterType ="mtSalesOrder" '+
                    ' inner join tblProcesspart PP on PT.proctreeId = PP.proctreeId '+
                    ' inner join tblprocesstime PCT on PCT.ProcessPartId = PP.id '+
                    ' inner join tblprocesspartqty PPQ on PP.ID = PPQ.ProcessPartID and PPQ.ProcesstimeID = PCT.ProcessTimeId '+
                    ' Where S.converted ="F" ' + iif(SaleLineID <> 0 , ' And SL.saleLineId =' + inttostr(SaleLineID) , '') +' order by PPQ.BuildDate;');

            SQL.Add('Alter table  '+tmp_processpartqty+' add column ProcessStep varchar(255); ');
            SQL.Add('Update  '+tmp_processpartqty+' T inner join tblprocessstep PS on T.ProcessStepId  = PS.Id set T.ProcessStep = PS.Description; ');

            SQL.Add('Alter table  '+tmp_processpartqty+' add column FormulaName varchar(255);');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column formula varchar(255);');
            SQL.Add('Alter table  '+tmp_processpartqty+' add column formulaDetails varchar(255);');

            SQL.Add('Create table '+tmp_processtime+' like tblprocesstime;');
            SQL.Add('insert ignore into '+tmp_processtime+' select distinct PCT.* /*, SL.saleID, SL.saleLineID  , SL.productname ,PT.level, PT.caption */'+
                    ' from tblsales S '+
                    ' inner join tblsaleslines SL on S.saleId = SL.saleId '+
                    ' inner join tblproctree PT on SL.saleLineID = PT.masterId and PT.MasterType ="mtSalesOrder" '+
                    ' inner join tblProcesspart PP on PT.proctreeId = PP.proctreeId '+
                    ' inner join tblprocesstime PCT on PCT.ProcessPartId = PP.id '+
                    ' Where S.converted ="F" order by PCT.TimeStart;');

            SQL.Add('Update '+tmp_processpartqty+' T inner join tblfesaleslines SL on SL.SaleLineID = T.saleLineId ' +
                      ' Set T.formulaId = SL.formulaId Where treeRootID = ProctreeId ;');

            SQL.Add('Update  '+tmp_processpartqty+' T  Inner join tblfeformula F on T.formulaId = F.formulaID  Set  '+
                        '  T.FormulaName =   F.FormulaName  , '+
                        '  T.formula = F.formula , '+
                        '  T.formulaDetails = DescribeFormula(F.Formula);');

            SQL.Add('update '+tmp_processtime+' Set TimeEnd = DATE_ADD(TimeStart,INTERVAL Duration Second)  Where DATE(Timeend) = "1899-12-30";');
            SQL.Add('Alter table  '+tmp_processtime+' add column PCTQ_SchdID int(11); ');
            SQL.Add('Alter table  '+tmp_processtime+' add column PCTQ_BuiltID int(11); ');
            DoStepProgressbar;
            clog(SQL.Text);
            Execute;
            DoStepProgressbar;
          end;
          Track_processpartqty(tmp_processpartqty , tmp_processtime);
          MakeQrymain(Tablename, tmp_processpartqty , tmp_processtime ,datefrom, dateto);
        finally
          DoHideProgressbar;
        end;
    finally
      DbSharedObj.ReleaseObj(scr);
    end;
  finally
    DestroyUserTemporaryTable(tmp_processpartqty);
    DestroyUserTemporaryTable(tmp_processtime);
  end;
end;

end.
