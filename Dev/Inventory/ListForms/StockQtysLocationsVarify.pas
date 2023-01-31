unit StockQtysLocationsVarify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TStockQtysLocationsVarifyGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainPartsId: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainUOMID: TIntegerField;
    qryMainUOM: TWideStringField;
    qryMainUOMDetails: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMaingLevel: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductColumn1: TWideStringField;
    qryMainProductColumn2: TWideStringField;
    qryMainProductColumn3: TWideStringField;
    qryMainPartsDescription: TWideStringField;
    qryMainClassname: TWideStringField;
    qryMainBatchnumber: TWideStringField;
    qryMainTruckLoadNo: TWideStringField;
    qryMainExpiryDate: TWideStringField;
    qryMainBatchExpiryDate: TDateTimeField;
    qryMainbinLocation: TWideStringField;
    qryMainBinnumber: TWideStringField;
    qryMainSerialnumber: TWideStringField;
    qryMainInstockUOMQty: TFloatField;
    qryMainInstockQty: TFloatField;
    qryMainSOUOMQty: TFloatField;
    qryMainSOQty: TFloatField;
    qryMainCost: TFloatField;
    qryMainValue: TFloatField;
    qryMainBatch: TWideStringField;
    qryMainBin: TWideStringField;
    qryMainSN: TWideStringField;
    qryMainInstockbatchQty: TFloatField;
    qryMainInstockUOMbatchQty: TFloatField;
    qryMainSObatchQty: TFloatField;
    qryMainSOUOMbatchQty: TFloatField;
    qryMainInstockBinQty: TFloatField;
    qryMainInstockUOMBinQty: TFloatField;
    qryMainSOBinQty: TFloatField;
    qryMainSOUOMBinQty: TFloatField;
    qryMainInstockSNQty: TFloatField;
    qryMainInstockUOMSNQty: TFloatField;
    qryMainSOSNQty: TFloatField;
    qryMainSOUOMSNQty: TFloatField;
    qryMainAvailUOMQty: TFloatField;
    qryMainAvailQty: TFloatField;
    qryMainAvailbatchQty: TFloatField;
    qryMainAvailUOMbatchQty: TFloatField;
    qryMainAvailBinQty: TFloatField;
    qryMainAvailUOMBinQty: TFloatField;
    qryMainAvailSNQty: TFloatField;
    qryMainAvailUOMSNQty: TFloatField;
    qryMainAlloctype: TIntegerField;
    qryMainMismatchtype: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    Formshown :Boolean;
    Tablename :String;
    procedure Populatedata;
    Procedure CreateTempTable;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses ProductQtyLib, LogLib, CommonLib, tcConst, CommonDbLib;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TStockQtysLocationsVarifyGUI.CreateTempTable;
begin
  With ScriptMain do begin
    SQL.clear;
    SQL.add('/*1*/Drop table if exists '+ tablename+';');
    SQL.add('/*2*/CREATE TABLE ' + tablename +' ( '+
	      ' ID                    INT(11) NOT NULL AUTO_INCREMENT, '+
        ' gLevel                INT(1) NOT NULL DEFAULT "0", '+
        ' PartsId               INT(11) NOT NULL DEFAULT "0", '+
        ' DepartmentID          INT(11) DEFAULT NULL, '+
        ' UOMID                 INT(11) DEFAULT NULL, '+
        ' UOM                   VARCHAR(50) NOT NULL DEFAULT "", '+
        ' UOMMultiplier         DOUBLE  NOT NULL DEFAULT "0", '+
        ' ProductName           VARCHAR(60) DEFAULT NULL, '+
        ' ProductColumn1        VARCHAR(255) DEFAULT NULL, '+
        ' ProductColumn2        VARCHAR(255) DEFAULT NULL, '+
        ' ProductColumn3        VARCHAR(255) DEFAULT NULL, '+
        ' PartsDescription      VARCHAR(255) DEFAULT NULL, '+
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
        ' AvailUOMQty           DOUBLE   DEFAULT NULL, '+
        ' AvailQty              DOUBLE   DEFAULT NULL, '+
        ' InstockUOMQty         DOUBLE   DEFAULT NULL, '+
        ' InstockQty            DOUBLE   DEFAULT NULL, '+
        ' SOUOMQty              DOUBLE   DEFAULT NULL, '+
        ' SOQty                 DOUBLE   DEFAULT NULL, '+
        ' Cost                  DOUBLE  NOT NULL DEFAULT "0.0", '+
        ' Value                 DOUBLE  NOT NULL DEFAULT "0.0", '+
        ' AvailbatchQty         DOUBLE  DEFAULT NULL, '+
        ' AvailUOMbatchQty      Double  DEFAULT NULL, '+
        ' InstockbatchQty       DOUBLE  DEFAULT NULL, '+
        ' InstockUOMbatchQty    DOUBLE  DEFAULT NULL, '+
        ' SObatchQty            DOUBLE  DEFAULT NULL, '+
        ' SOUOMbatchQty         DOUBLE  DEFAULT NULL, '+
        ' AvailBinQty           DOUBLE  DEFAULT NULL, '+
        ' AvailUOMBinQty        DOUBLE  DEFAULT NULL, '+
        ' InstockBinQty         DOUBLE  DEFAULT NULL, '+
        ' InstockUOMBinQty      DOUBLE  DEFAULT NULL, '+
        ' SOBinQty              DOUBLE  DEFAULT NULL, '+
        ' SOUOMBinQty           DOUBLE  DEFAULT NULL, '+
        ' AvailSNQty            DOUBLE  DEFAULT NULL, '+
        ' AvailUOMSNQty         DOUBLE  DEFAULT NULL, '+
        ' InstockSNQty          DOUBLE  DEFAULT NULL, '+
        ' InstockUOMSNQty       DOUBLE  DEFAULT NULL, '+
        ' SOSNQty               DOUBLE  DEFAULT NULL, '+
        ' SOUOMSNQty            DOUBLE  DEFAULT NULL, '+
        ' Alloctype             INT(1) ,'+
        ' Mismatchtype          INT(1),'+
        ' PRIMARY KEY (`ID`), '+
        ' KEY AllFlds (PartsId,DepartmentID,UOMID,Batchnumber,TruckLoadNo,BatchExpiryDate,binLocation,Binnumber) '+
        ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');
        Execute;
  end;

end;

procedure TStockQtysLocationsVarifyGUI.FormCreate(Sender: TObject);
begin
  Formshown := False;
  Tablename         := commondblib.GetUserTemporaryTableName('StockQtysLocationsvar');
  CreateTempTable;
  Qrymain.SQl.text := 'Select * , concat(UOM , " (" , UOMMultiplier , ")") as UOMDetails from ' + Tablename +
                      ' order by Productname , classname , UOM, glevel, Batchnumber , expirydate, truckloadno , binlocation, binnumber , serialnumber';
  inherited;

end;

procedure TStockQtysLocationsVarifyGUI.RefreshQuery;
begin
  Closedb(Qrymain);
  Populatedata;
  inherited;
end;
procedure TStockQtysLocationsVarifyGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TStockQtysLocationsVarifyGUI.FormShow(Sender: TObject);
begin
  inherited;
  Formshown := True;
end;

procedure TStockQtysLocationsVarifyGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  (*if (Qrymainglevel.asInteger = 1) then begin
      if (Qrymainbatch.asBoolean ) then begin
        if  (QrymainQty.asFloat           <> QrymainAvailbatchQty.asFloat) or
            (QrymainuomQty.asFloat        <> QrymainAvailuombatchQty.asFloat) or
            (QrymaininstockQty.asFloat    <> QrymaininstockbatchQty.asFloat) or
            (QrymaininstockuomQty.asFloat <> QrymaininstockuombatchQty.asFloat) or
            (QrymainSOQty.asFloat         <> QrymainSObatchQty.asFloat) or
            (QrymainSOuomQty.asFloat      <> QrymainSOuombatchQty.asFloat) then AFont.color := clred;
      end else if (Qrymainbin.asBoolean ) then begin
        if  (QrymainQty.asFloat           <> QrymainAvailBinQty.asFloat) or
            (QrymainuomQty.asFloat        <> QrymainAvailuomBinQty.asFloat) or
            (QrymaininstockQty.asFloat    <> QrymaininstockBinQty.asFloat) or
            (QrymaininstockuomQty.asFloat <> QrymaininstockuomBinQty.asFloat) or
            (QrymainSOQty.asFloat         <> QrymainSOBinQty.asFloat) or
            (QrymainSOuomQty.asFloat      <> QrymainSOuomBinQty.asFloat) then AFont.color := clred;
      end else if (QrymainSN.asBoolean ) then begin
        if  (QrymainQty.asFloat           <> QrymainAvailSNQty.asFloat) or
            (QrymainuomQty.asFloat        <> QrymainAvailuomSNQty.asFloat) or
            (QrymaininstockQty.asFloat    <> QrymaininstockSNQty.asFloat) or
            (QrymaininstockuomQty.asFloat <> QrymaininstockuomSNQty.asFloat) or
            (QrymainSOQty.asFloat         <> QrymainSOSNQty.asFloat) or
            (QrymainSOuomQty.asFloat      <> QrymainSOuomSNQty.asFloat) then AFont.color := clred;
      end;
  end else begin
    if (Qrymainbatchnumber.asString <> '')  and (Qrymainbinlocation.asString ='') and (qrymainSerialnumber.asString='')  then begin
      if  (Qrymainbin.asBoolean) then begin
        if  (QrymainQty.asFloat           <> QrymainAvailBinQty.asFloat) or
            (QrymainuomQty.asFloat        <> QrymainAvailuomBinQty.asFloat) or
            (QrymaininstockQty.asFloat    <> QrymaininstockBinQty.asFloat) or
            (QrymaininstockuomQty.asFloat <> QrymaininstockuomBinQty.asFloat) or
            (QrymainSOQty.asFloat         <> QrymainSOBinQty.asFloat) or
            (QrymainSOuomQty.asFloat      <> QrymainSOuomBinQty.asFloat) then AFont.color := clred;
      end else if  (QrymainSN.asBoolean)  then begin
        if  (QrymainQty.asFloat           <> QrymainAvailSNQty.asFloat) or
            (QrymainuomQty.asFloat        <> QrymainAvailuomSNQty.asFloat) or
            (QrymaininstockQty.asFloat    <> QrymaininstockSNQty.asFloat) or
            (QrymaininstockuomQty.asFloat <> QrymaininstockuomSNQty.asFloat) or
            (QrymainSOQty.asFloat         <> QrymainSOSNQty.asFloat) or
            (QrymainSOuomQty.asFloat      <> QrymainSOuomSNQty.asFloat) then AFont.color := clred;
      end;
    end else if (Qrymainbinlocation.asString <> '') and (qrymainSerialnumber.asString='')  and (QrymainSN.asBoolean)  then begin
        if  (QrymainQty.asFloat           <> QrymainAvailSNQty.asFloat) or
            (QrymainuomQty.asFloat        <> QrymainAvailuomSNQty.asFloat) or
            (QrymaininstockQty.asFloat    <> QrymaininstockSNQty.asFloat) or
            (QrymaininstockuomQty.asFloat <> QrymaininstockuomSNQty.asFloat) or
            (QrymainSOQty.asFloat         <> QrymainSOSNQty.asFloat) or
            (QrymainSOuomQty.asFloat      <> QrymainSOuomSNQty.asFloat) then AFont.color := clred;
    end;
  end;*)

end;

procedure TStockQtysLocationsVarifyGUI.grdMainTitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
//  inherited;

end;

procedure TStockQtysLocationsVarifyGUI.grpFiltersClick(Sender: TObject);
begin
  groupfilterstring := '';
  if grpfilters.itemindex =1 then groupfilterstring := 'mismatchtype <> 0';
  inherited;
end;

procedure TStockQtysLocationsVarifyGUI.Populatedata;
begin
  With ScriptMain do begin
    SQL.clear;
    SQL.add('/*1*/truncate table '+ tablename+';');
    if (Formshown = true) or  (SearchMode = smFullList) then begin
            SQL.add('/*3*/insert into '+ tablename + ' (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,'+
                                                          ' Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,binLocation,Binnumber,Serialnumber,'+
                                                          ' AvailUOMQty,AvailQty,InstockUOMQty,InstockQty,SOUOMQty,SOQty,Cost,Value) ' +
                                                          ProductQtyLib.StockQty(True , 0, 0 , tDetailswithSno) +';');
                                                          //ProductQtyLib.StockQtyDetailswithSno(True, 0, 0, 0, TRue, TRue) +';');
            SQL.add(' /*4*/update '+ tablename +' set Batchnumber     = ""            where  ifnull(Batchnumber     ,"")="";'+
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
                         ' update '+ tablename +' set SOQty           = 0.0           where  ifnull(SOQty           ,0) =0;');
            SQL.add(' /*5*/delete from '+ tablename +' where gLevel >=2 '+
                                                            ' and ifnull(Batchnumber,"")=""  '+
                                                            ' and ifnull(BAtchExpirydate,0)<="1900-01-01" '+
                                                            ' and ifnull(TruckLoadNo , "") = ""  '+
                                                            ' and ifnull(binlocation,"")=""  '+
                                                            ' and ifnull(Binnumber,"")=""  '+
                                                            ' and  ifnull(Serialnumber,"") = ""  '+
                                                            ' and ifnull(AvailQty,0) =0;');

            SQL.add('/*6*/delete from  '+tablename +' where serialnumber <> "" and AvailQty <=0 and InstockQty<=0 and SOQty <=0;');
            SQL.add('/*7*/Update '+tablename +' t inner join tblparts P on P.PartsId = T.PartsId Set T.batch = P.Batch, T.Bin = P.MultipleBins, T.sn = P.SNTracking;');

            SQL.add('/*11*/Drop table if exists '+ tablename +'1;');
            SQL.add('/*12*/Create table '+ tablename +'1 Select PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate , Binlocation , Binnumber , '+
                                                             ' sum(AvailUOMQty)   as AvailUOMQty ,  '+
                                                             ' Sum(AvailQty)      as AvailQty ,  '+
                                                             ' sum(InstockUOMQty) as InstockUOMQty ,  '+
                                                             ' sum(InstockQty)    as InstockQty ,  '+
                                                             ' Sum(SOUOMQty)      as SOUOMQty ,  '+
                                                             ' sum(SOQty)         as SOQty from '+tablename +
                                                             ' Where ifnull(Serialnumber,"")<> "" '+
                                                             ' group by  PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate , Binlocation , Binnumber;');
            SQL.add('/*13*/ALTER TABLE ' +tablename+'1  		ADD INDEX `AllFlds`  (PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate , Binlocation , Binnumber);');
            SQL.add('/*14*/Update '+ tablename +' T inner join '+ tablename +'1 as T1 on T.PartsID and T1.PartsID AND ' +
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
                                                                                  ' T.SOUOMSNQty      = T1.SoUOMQty;');

            SQL.add('/*15*/Drop table if exists '+ tablename +'1;');
            SQL.add('/*16*/Create table '+ tablename +'1 Select PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate  , '+
                                                             ' sum(ifnull(AvailUOMSNQty   ,AvailUOMQty))   as AvailUOMQty ,  '+
                                                             ' Sum(ifnull(AvailSNQty      ,AvailQty))      as AvailQty ,  '+
                                                             ' sum(ifnull(InstockUOMSNQty ,InstockUOMQty)) as InstockUOMQty ,  '+
                                                             ' sum(ifnull(InstockSNQty    ,InstockQty) )   as InstockQty ,  '+
                                                             ' Sum(ifnull(SOUOMSNQty      ,SOUOMQty))      as SOUOMQty ,  '+
                                                             ' sum(ifnull(SOSNQty         ,SOQty))         as SOQty from '+tablename +
                                                             ' Where (bin ="T" and ifnull(Binlocation, "")<> "" and ifnull(Serialnumber ,"")="") or'+
                                                                    '(bin ="F" and ifnull(Serialnumber,"")<> "" )'+
                                                             ' group by  PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate ;');
            SQL.add('/*17*/ALTER TABLE ' +tablename+'1  		ADD INDEX `AllFlds`  (PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate );');
            SQL.add('/*18*/Update '+ tablename +' T inner join '+ tablename +'1 as T1 on T.PartsID and T1.PartsID AND ' +
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
                                                                                  ' T.SOUOMBinQty      = T1.SoUOMQty;');
            SQL.add('/*19*/Drop table if exists '+ tablename +'1;');
            SQL.add('/*20*/Create table '+ tablename +'1 Select PartsID, DepartmentID , UOMID , Batchnumber , TruckLoadNo , BatchExpiryDate  , '+
                                                             ' sum(ifnull(AvailUOMBinQty   ,ifnull(AvailUOMSNQty   ,AvailUOMQty)))   as AvailUOMQty ,  '+
                                                             ' Sum(ifnull(AvailBinQty      ,ifnull(AvailSNQty      ,AvailQty)))      as AvailQty ,  '+
                                                             ' sum(ifnull(InstockUOMBinQty ,ifnull(InstockUOMSNQty ,InstockUOMQty))) as InstockUOMQty ,  '+
                                                             ' sum(ifnull(InstockBinQty    ,ifnull(InstockSNQty    ,InstockQty)))    as InstockQty ,  '+
                                                             ' Sum(ifnull(SOUOMBinQty      ,ifnull(SOUOMSNQty      ,SOUOMQty)))      as SOUOMQty ,  '+
                                                             ' sum(ifnull(SOBinQty         ,ifnull(SOSNQty         ,SOQty)))         as SOQty from '+tablename +
                                                             ' Where (batch ="T" and ifnull(batchnumber , "")<> "") or  '+
                                                                    '(batch ="F" and bin ="T" and ifnull(Binlocation, "")<> "" and ifnull(Serialnumber,"")="") or   '+
                                                                    '(batch ="F"  and bin ="F" and ifnull(Serialnumber,"")<> "" )  '+
                                                             ' group by  PartsID, DepartmentID , UOMID  ;');
            SQL.add('/*21*/ALTER TABLE ' +tablename+'1  		ADD INDEX `AllFlds`  (PartsID, DepartmentID , UOMID  );');
            SQL.add('/*22*/Update '+ tablename +' T inner join '+ tablename +'1 as T1 on T.PartsID and T1.PartsID AND ' +
                                                                                  ' T.DepartmentID  = T1.DepartmentID and ' +
                                                                                  ' T.UOMID         = T1.UOMID  ' +
                                                                              ' Set T.AvailBatchQty      = T1.AvailQty , '+
                                                                                  ' T.AvailUOMBatchQty   = T1.AvailUOMQty ,  '+
                                                                                  ' T.InstockBatchQty    = T1.InstockQty ,  '+
                                                                                  ' T.InstockUOMBatchQty = T1.InstockUOMQty ,  '+
                                                                                  ' T.SOBatchQty         = T1.SOQty ,  '+
                                                                                  ' T.SOUOMBatchQty      = T1.SoUOMQty;');
            SQL.add('/*23*/Drop table if exists '+ tablename +'1;');
            SQL.add('/*24*/ update '+ Tablename +' Set Alloctype = 1 where glevel =1;');
            SQL.add('/*25*/ update '+ Tablename +' Set Alloctype = 2 where glevel >1 and batch  = "T" and batchnumber <> "" and binlocation ="" and serialnumber ="";');
            SQL.add('/*26*/ update '+ Tablename +' Set Alloctype = 3 where glevel >1 and bin    = "T" and binlocation <>"" and serialnumber ="";');
            SQL.add('/*27*/ update '+ Tablename +' Set Alloctype = 4 where glevel >1 and SN     = "T" and serialnumber<>"";');
            SQL.add('/*28*/ update '+ Tablename +' Set Mismatchtype  = 0;');
            SQL.add('/*29*/ update '+ Tablename +' Set Mismatchtype  = Mismatchtype + 1 where  alloctype =1 '+
                                                                            '  and (AvailBatchQty      <> AvailQty      OR '+
                                                                                  ' AvailUOMBatchQty   <> AvailUOMQty   OR  '+
                                                                                  ' InstockBatchQty    <> InstockQty    OR  '+
                                                                                  ' InstockUOMBatchQty <> InstockUOMQty OR  '+
                                                                                  ' SOBatchQty         <> SOQty         OR  '+
                                                                                  ' SOUOMBatchQty      <> SoUOMQty);');

            SQL.add('/*30*/ update '+ Tablename +' Set Mismatchtype  = Mismatchtype + 2 where  alloctype =2 '+
                                                                            '  and (AvailBinQty      <> AvailQty      OR '+
                                                                                  ' AvailUOMBinQty   <> AvailUOMQty   OR  '+
                                                                                  ' InstockBinQty    <> InstockQty    OR  '+
                                                                                  ' InstockUOMBinQty <> InstockUOMQty OR  '+
                                                                                  ' SOBinQty         <> SOQty         OR  '+
                                                                                  ' SOUOMBinQty      <> SoUOMQty);');
            SQL.add('/*31*/ update '+ Tablename +' Set Mismatchtype  = Mismatchtype + 4 where  alloctype =3 '+
                                                                            '  and (AvailSNQty      <> AvailQty      OR '+
                                                                                  ' AvailUOMSNQty   <> AvailUOMQty   OR  '+
                                                                                  ' InstockSNQty    <> InstockQty    OR  '+
                                                                                  ' InstockUOMSNQty <> InstockUOMQty OR  '+
                                                                                  ' SOSNQty         <> SOQty         OR  '+
                                                                                  ' SOUOMSNQty      <> SoUOMQty);');
          {
          Mismatchtype
          1: ProductQty <> allocationQty : Adjsut productQty
          2: Batch Qty <> Bin/Sr Qty :Adjust batchQty
          3:ProductQty <> allocationQty AND Batch Qty <> Bin/Sr Qty : Adjsut productQty and batchQty
          4:Bin Qty <> Sr Qty : Adjsut binQty
          5:ProductQty <> SR qty AND Batch Qty <> Bin/Sr Qty : Adjsut productQty and batchQty
          }
    end;

    DoshowProgressbar(SQL.Count, WAITMSG);
    try
      clog(SQL.Text);
      Execute;
    finally
      DoHideProgressbar;
    end;
    logtext(Qrymain.SQL.Text);

  end;
  inherited;
end;

initialization
  RegisterClassOnce(TStockQtysLocationsVarifyGUI);

end.
