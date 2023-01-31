unit StSLib;

interface


function StSTagList(Var fstablename:String; const Tags :String =''; fiClassID:Integer =0; FilterDateTo :TDatetime=0):string;
Function StSPackageTagProductID:Integer ;
Function StSPlantTagProductID :Integer;

implementation

uses BusobjProduct, AppEnvironment, CommonDbLib,classes, ProductQtyLib,
  ERPdbComponents, CommonLib, sysutils, SystemLib, DbSharedObjectsObj;

Function StSPackageTagProductID:Integer ;
begin
  Result := TProductsimple.idtoggle(Appenv.companyPREfs.StSPackageTagProduct);
end;
Function StSPlantTagProductID :Integer;
begin
  Result  := TProductsimple.idtoggle(Appenv.companyPREfs.StSPlantTagProduct  );
end;

function StSTagList(Var fstablename:String; const Tags :String =''; fiClassID:Integer =0; FilterDateTo :TDatetime=0):string;
var
  fiStSPackageTagProductID ,fiStSPlantTagProductID:Integer;
  St:TStringList;
  scr :TERPScript;
  ErrorMsg :String;
begin
  Result :='';
  if fstablename ='' then fsTablename := GetUserTemporaryTableName('StsTaglist');
  st:= TStringList.create;
  try
    commondblib.ExecuteDBCommand( 'Drop table if exists '+ fsTablename+';'+
                      'CREATE TABLE  '+ fsTablename+' ( ' +
                              ' ID                INT(11)       NOT NULL AUTO_INCREMENT, ' +
                              ' PartsId           INT(11)           NULL DEFAULT 0, ' +
                              ' DepartmentID      INT(11)           NULL DEFAULT NULL, ' +
                              ' UOMID             INT(11)           NULL DEFAULT NULL, ' +
                              ' UOM               VARCHAR(255)      NULL DEFAULT "", ' +
                              ' UOMMultiplier     DOUBLE            NULL DEFAULT 0, ' +
                              ' gLevel            INT(11)           NULL DEFAULT 0, ' +
                              ' ProductName       VARCHAR(255)      NULL DEFAULT NULL, ' +
                              ' ProductColumn1    VARCHAR(255)      NULL DEFAULT NULL, ' +
                              ' ProductColumn2    VARCHAR(255)      NULL DEFAULT NULL, ' +
                              ' ProductColumn3    VARCHAR(255)      NULL DEFAULT NULL, ' +
                              ' PartsDescription  VARCHAR(255)      NULL DEFAULT NULL, ' +
                              ' Classname         VARCHAR(255)      NULL DEFAULT "", ' +
                              ' Batchnumber       VARCHAR(100)      NULL DEFAULT NULL, ' +
                              ' TruckLoadNo       VARCHAR(100)      NULL DEFAULT "", ' +
                              ' cBatchExpiryDate  VARCHAR(50)       NULL DEFAULT NULL, ' +
                              ' BatchExpiryDate   DATETIME          NULL DEFAULT NULL, ' +
                              ' binLocation       VARCHAR(100)      NULL DEFAULT "", ' +
                              ' Binnumber         VARCHAR(100)      NULL DEFAULT "", ' +
                              ' Serialnumber      VARCHAR(100)      NULL DEFAULT NULL, ' +
                              ' DEscription       VARCHAR(100)      NULL DEFAULT NULL, ' +
                              ' Transdate         DATETIME          NULL DEFAULT NULL, ' +
                              ' allocType         VARCHAR(50)       NULL DEFAULT NULL, ' +
                              ' PQAID             int(11)           Null Default Null,'+
                              ' Transtype         VARCHAR(255)      NULL DEFAULT NULL, ' +
                              ' UsedOn            DATETIME          NULL DEFAULT NULL,' +
                              ' TagID             INT(11)           NULL DEFAULT "0",' +
                              ' StrainName        VARCHAR(255)      NULL,' +
                              ' Plantcount        INT(11)           NULL DEFAULT NULL,' +
                              ' WastedCount       INT(11)           NULL DEFAULT NULL,' +
                              ' UsedCount         INT(11)           NULL DEFAULT NULL,' +
                              ' Destroycount      INT(11)           NULL DEFAULT NULL,' +
                              ' TransferedCount   INT(11)           NULL DEFAULT NULL,' +
                              ' Harvestcount      INT(11)           NULL DEFAULT NULL,' +
                              ' ChangedCount      INT(11)           NULL DEFAULT NULL,' +
                              ' ACtivecount       INT(11)           NULL DEFAULT NULL,' +
                              ' SrcSerialnumber   VARCHAR(100)      NULL DEFAULT NULL, ' +
                              ' SrcTagID          INT(11)           NULL DEFAULT "0",' +
                              ' StsPhase          VARCHAR(1)        NULL DEFAULT "",'+
                              ' hasAction         Enum(''T'',''F'') DEFAULT ''F'', ' +
                              ' IsPlantTag        Enum(''T'',''F'') DEFAULT ''F'', ' +
                              ' IsPackageTag      Enum(''T'',''F'') DEFAULT ''F'', ' +
                              ' supplierid        INT(11)           NULL DEFAULT 0, '+
                              ' Supplier          varchar(255)      null default "", '+
                              ' PRIMARY KEY (ID)) ENGINE=MyISAM DEFAULT CHARSET=utf8;'+
                      'drop   table if exists '+fstablename+'1;'+
                      'Create table '+fstablename+'1 like tblststags;'+
                      'Drop   table if exists ' + fsTablename +'2;'+
                      'Create table  ' + fsTablename +'2 like tblStSTag_Actions;', ErrorMsg);


    With st do begin
      clear;
      if FilterDateTo =0 then FilterDateTo:= ERPListMaxDatetime;
      fiStSPackageTagProductID := StSPackageTagProductID;
      fiStSPlantTagProductID   := StSPlantTagProductID;
      add('delete from '+fsTablename+';');
      if fiStSPackageTagProductID <>0 then
        add('insert ignore into '+ fsTablename +
                ' (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,'+
                'ProductColumn1,ProductColumn2,ProductColumn3,'+
                'PartsDescription,Classname,Batchnumber,TruckLoadNo,cBatchExpiryDate,BatchExpiryDate,'+
                'binLocation,Binnumber,Serialnumber,DEscription,Transdate,allocType,PQAID,transType) '+
                ProductQtylib.Serialnumberlist(fiStSPackageTagProductID , fiClassID ,  0,  0, FilterDateTo, false, 'Pqa.PQAID,PQA.transType')+
                iif(trim(Tags)<>'', ' and PQASN.value in ('+quotedstr(Tags)+')','')+
                ';');

      if fiStSPlantTagProductID <> 0 then
        add('insert ignore into '+ fsTablename +
                ' (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,'+
                'ProductColumn1,ProductColumn2,ProductColumn3,'+
                'PartsDescription,Classname,Batchnumber,TruckLoadNo,cBatchExpiryDate,BatchExpiryDate,'+
                'binLocation,Binnumber,Serialnumber,DEscription,Transdate,allocType,pqaid,transType) '+
                 ProductQtylib.Serialnumberlist(fiStSPlantTagProductID, fiClassID ,  0,  0, FilterDateTo, false, 'Pqa.PQAID,PQA.transType')+
                iif(trim(Tags)<>'', ' and PQASN.value in ('+Quotedstr(Tags)+')','')+
                ';');

      add('Update  '+fstablename+' Set isPlantTag ="T", Ispackagetag ="F" where ifnull(PartsId,0)<> 0 and PartsId = ' + inttostr(fiStSPlantTagProductID)+';');
      add('Update  '+fstablename+' Set isPlantTag ="F", Ispackagetag ="T" where ifnull(PartsId,0)<> 0 and PartsId = ' + inttostr(fiStSPackageTagProductID)+';');

      add('delete from  '+fstablename+'1;');
      add('insert ignore into '+fstablename+'1 select * from  tblststags ST where Id not in (Select ifnull(SourceTagID,0) from tblststags STS where STS.StsTag =ST.StsTag);');
      add('update ' + fsTablename +' T inner join '+fstablename+'1  ST on T.Serialnumber = ST.StsTag '+
              ' Set T.UsedOn       = ST.UsedOn, '+
                  ' T.StsPhase     = ST.StsPhase,'+
                  ' T.TagID        = ST.ID, '+
                  ' T.SrcTagID     = ST.SourceTagID, '+
                  ' T.Strainname   = ST.Strainname,'+
                  ' T.Plantcount   = ST.Plantcount,'+
                  ' T.WastedCount  = ST.WastedCount,'+
                  ' T.UsedCount    = ST.UsedCount,'+
                  ' T.Harvestcount = ST.Harvestcount,'+
                  ' T.Destroycount = ST.Destroycount,'+
                  ' T.TransferedCount = ST.TransferedCount,'+
                  ' T.ChangedCount = ST.ChangedCount;');
      add('delete  from  '+fstablename+'1;');
      add('insert ignore into '+fstablename+'1 select * from  tblststags ST ;');
      add('update ' + fsTablename +' T inner join '+fstablename+'1  ST on T.SrcTagID = ST.Id '+
              ' Set SrcSerialnumber = St.StsTag;');
      add('update ' + fsTablename +' Set UOM = concat(UOM, "(" ,UOMMultiplier,")");');
      add('update ' + fsTablename +' T  Set T.HasAction="F";');
      add('insert ignore into ' + fsTablename +'2 Select ST.* '+
            ' from  tblStSTag_Actions  ST inner join '+ fsTablename +' T on T.TagID  = ST.Id ;');
      add('update ' + fsTablename +' T '+
              ' inner join  ' + fsTablename +'2  ST on T.TagID  = ST.Id '+
              ' Set T.HasAction="T";');
      add('update ' + fsTablename +' T Set Activecount = Plantcount-(ChangedCount+WastedCount+Destroycount+Harvestcount+TransferedCount+UsedCount);');

      {Stock transfer tags got the }
      add('update ' + fsTablename +' T INNER JOIN tblststags ST ON ST.tagproductID = T.partsId  AND ST.StsTag = T.serialnumber AND T.departmentId = ST.DeptID Set alloctype ="Used" WHERE (T.alloctype = "Not-Used" OR T.alloctype ="New");');
      add('update ' + fsTablename +' T INNER JOIN tblststags ST ON ST.StSProductID = T.partsId  AND ST.StsTag = T.serialnumber AND T.departmentId = ST.DeptID Set alloctype ="Used" WHERE (T.alloctype = "Not-Used" OR T.alloctype ="New");');

    end;
  finally
    result := St.text;
    FreeandNil(st);
  end;
end;
end.
