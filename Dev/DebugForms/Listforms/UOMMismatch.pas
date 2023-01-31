unit UOMMismatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TUOMMismatchGUI = class(TBaseListingGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainProductname: TWideStringField;
    qryMainTransType: TWideStringField;
    qryMainSeqno: TLargeintField;
    qryMainTransUOMID: TIntegerField;
    qryMainUOMID: TIntegerField;
    qryMainUnitName: TWideStringField;
    qryMainMultiplier: TFloatField;
    qryMainProductID: TLargeintField;
    DNMSpeedButton2: TDNMSpeedButton;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
  private
    Function MakeBaseunits:String;
  public
    { Public declarations }
  end;

implementation

uses
  CommonDbLib, CommonLib, AppDatabase, BusobjUOM, tcConst, MergeObj, LogLib,
  ERPVersionConst;

{$R *.dfm}
procedure TUOMMismatchGUI.DNMSpeedButton1Click(Sender: TObject);
var
  MergeObj : TMergeObj;
begin
  inherited;
  ExecuteSQL('Create table if not exists erpfix_unitsofmeasure'+replacestr(TABLE_VERSION, '.' , '')+' like   tblunitsofmeasure;' +
            'insert ignore into erpfix_unitsofmeasure'+replacestr(TABLE_VERSION, '.' , '')+' Select * from tblunitsofmeasure;' );

  MergeObj := TMergeObj.Create;
  try
    MergeObj.FixUOMnameFromID;
  finally
    FreeandNil(MergeObj);
  end;

  ExecuteSQL(MakeBaseunits +
            'drop table if exists tmp_1; ' +
             ' create table tmp_1 ' +
             ' Select distinct 1 as Type, SL.UnitOfMeasureID , SL.ProductID , SL.UnitofMeasureSaleLines uom , SL.UnitofMeasureMultiplier uommult , '+
                                ' concat(SL.UnitofMeasureSaleLines , ":" , SL.ProductName) as uompart from tblsaleslines SL where ifnull(SL.UnitOfMeasureID ,0)<>0 ' +
             ' union all ' +
             ' Select distinct 2 as Type, PL.UnitOfMeasureID , PL.ProductID , PL.UnitofMeasurePOLines uom , PL.UnitofMeasureMultiplier uommult,  '+
                                ' concat(PL.UnitofMeasurePOLines , ":" , PL.ProductName) uompart from tblpurchaselines PL where ifnull(PL.UnitOfMeasureID,0)<>0 ' +
             ' union all ' +
             ' Select distinct 3 as type, PTP.UnitOfMeasureId , PTP.ProductId , PTP.UnitOfMeasure uom , PTP.UnitOfMeasureMultiplier uommult,  '+
                                ' concat(PTP.UnitOfMeasure , ":" , PTP.productname ) uompart from tblproctreepart PTP where ifnull(PTP.UnitOfMeasureId  ,0)<>0 ' +
             ' union all ' +
             ' Select distinct 9 as type, PT.TreePartUOMID, PT.PartsId, PT.TreePartUOM uom , PT.TreePartUOMMultiplier uommult,  '+
                                ' concat(PT.TreePartUOM , ":" , PT.Caption ) uompart from tblproctree PT where ifnull(PT.TreePartUOMID  ,0)<>0 ' +
             ' union all ' +
             ' Select distinct 4 as Type, SML.UOMID , SML.ProductID , SML.UOM , SML.UOMMultiplier uommult ,  '+
                                ' concat(SML.UOM , ":" , SML.uom ) uompart from tblstockmovementlines SML where ifnull(SML.UOMID ,0)<>0 ' +
             ' union all ' +
             ' Select distinct 5 as Type, SML.UOMID , SML.ProductID , SML.UOM , SML.UOMMultiplier uommult ,  '+
                                ' concat(SML.UOM , ":" , SML.uom ) uompart from tblstockadjustentrylines SML where ifnull(SML.UOMID ,0)<>0 ' +
             ' union all ' +
             ' Select distinct 6 as Type, SML.UOMID , SML.ProductID , SML.UOM , SML.UOMMultiplier uommult ,  '+
                                ' concat(SML.UOM , ":" , SML.uom ) uompart from tblstocktransferentrylines SML where ifnull(SML.UOMID ,0)<>0 ' +
             ' union all ' +
             ' Select distinct 7 as Type, RP.UnitofMeasureID , RP.PartsID ProductID , RP.UnitofMeasure uom , RP.UnitofMeasureMultiplier uommult,  '+
                                ' concat(RP.UnitofMeasure , ":" , RP.PartName ) uompart from tblrepairparts RP where ifnull(RP.UnitofMeasureID ,0)<>0 ' +
             ' union all ' +
             ' Select distinct 8 as Type, PQA.uomID , PQA.ProductID , PQA.UOM uom , PQA.UOMMultiplier uommult,  '+
                                ' concat(PQA.UOM , ":" , P.PartName ) uompart from tblPQA PQA inner join tblParts P on P.partsId = PQa.productId where ifnull(PQA.UOMID ,0)<>0; ' +
             ' insert ignore  into tblunitsofmeasure  (PartID, UnitName , Multiplier , UnitProductKeyName, Active) Select distinct ProductID , uom  , uommult , uompart ,"T" from tmp_1 ; ' +

             ' Create table if not exists  erpfix_pqa'                    + replacestr(TABLE_VERSION, '.' , '') +'   like tblpqa; ' +
             ' Create table if not exists  erpfix_saleslines'             + replacestr(TABLE_VERSION, '.' , '') +'   like tblsaleslines; ' +
             ' Create table if not exists  erpfix_purchaselines'          + replacestr(TABLE_VERSION, '.' , '') +'   like tblpurchaselines; ' +
             ' Create table if not exists  erpfix_proctreepart'           + replacestr(TABLE_VERSION, '.' , '') +'   like tblproctreepart; ' +
             ' Create table if not exists  erpfix_proctree'               + replacestr(TABLE_VERSION, '.' , '') +'   like tblproctree; ' +
             ' Create table if not exists  erpfix_stockmovementlines'     + replacestr(TABLE_VERSION, '.' , '') +'   like tblstockmovementlines; ' +
             ' Create table if not exists  erpfix_stockadjustentrylines'  + replacestr(TABLE_VERSION, '.' , '') +'   like tblstockadjustentrylines; ' +
             ' Create table if not exists  erpfix_stocktransferentrylines'+ replacestr(TABLE_VERSION, '.' , '') +'   like tblstocktransferentrylines; ' +
             ' Create table if not exists  erpfix_repairparts'            + replacestr(TABLE_VERSION, '.' , '') +'   like tblrepairparts; ' +

             ' insert ignore into erpfix_pqa'                             + replacestr(TABLE_VERSION, '.' , '') +'   select * from tblpqa; ' +
             ' insert ignore into erpfix_saleslines'                      + replacestr(TABLE_VERSION, '.' , '') +'   select * from tblsaleslines; ' +
             ' insert ignore into erpfix_purchaselines'                   + replacestr(TABLE_VERSION, '.' , '') +'   select * from tblpurchaselines; ' +
             ' insert ignore into erpfix_proctreepart'                    + replacestr(TABLE_VERSION, '.' , '') +'   select * from tblproctreepart; ' +
             ' insert ignore into erpfix_proctree'                        + replacestr(TABLE_VERSION, '.' , '') +'   select * from tblproctree; ' +
             ' insert ignore into erpfix_stockmovementlines'              + replacestr(TABLE_VERSION, '.' , '') +'   select * from tblstockmovementlines; ' +
             ' insert ignore into erpfix_stockadjustentrylines'           + replacestr(TABLE_VERSION, '.' , '') +'   select * from tblstockadjustentrylines; ' +
             ' insert ignore into erpfix_stocktransferentrylines'         + replacestr(TABLE_VERSION, '.' , '') +'   select * from tblstocktransferentrylines; ' +
             ' insert ignore into erpfix_repairparts'                     + replacestr(TABLE_VERSION, '.' , '') +'   select * from tblrepairparts; ' +

             ' update tblpqa 								      Trans inner join tblunitsofmeasure uom on Trans.ProductID = uom.PartID and Trans.UOM 								    = uom.unitname Set Trans.uomID 					  = uom.unitId; ' +
             ' update tblsaleslines 						  Trans inner join tblunitsofmeasure uom on Trans.ProductID = uom.PartID and Trans.UnitofMeasureSaleLines = uom.unitname Set Trans.UnitOfMeasureID 	= uom.unitId; ' +
             ' update tblpurchaselines 				    Trans inner join tblunitsofmeasure uom on Trans.ProductID = uom.PartID and Trans.UnitofMeasurePOLines 	= uom.unitname Set Trans.UnitOfMeasureID 	= uom.unitId; ' +
             ' update tblproctreepart 					  Trans inner join tblunitsofmeasure uom on Trans.ProductID = uom.PartID and Trans.UnitOfMeasure	 				= uom.unitname Set Trans.UnitOfMeasureId 	=	uom.unitId; ' +
             ' update tblproctree 					      Trans inner join tblunitsofmeasure uom on Trans.PartsId   = uom.PartID and Trans.TreePartUOM	 				  = uom.unitname Set Trans.TreePartUOMID 	  =	uom.unitId WHERE IFNULL(Trans.PartsId,0)<>0; ' +
             ' update tblstockmovementlines 		  Trans inner join tblunitsofmeasure uom on Trans.ProductID = uom.PartID and Trans.UOM 								    = uom.unitname Set Trans.UOMID 					  = uom.unitId; ' +
             ' update tblstockadjustentrylines 		Trans inner join tblunitsofmeasure uom on Trans.ProductID = uom.PartID and Trans.UOM 								    = uom.unitname Set Trans.UOMID 					  = uom.unitId; ' +
             ' update tblstocktransferentrylines 	Trans inner join tblunitsofmeasure uom on Trans.ProductID = uom.PartID and Trans.UOM 								    = uom.unitname Set Trans.UOMID 					  = uom.unitId; ' +
             ' update tblrepairparts 						  Trans inner join tblunitsofmeasure uom on Trans.PartsID 	= uom.PartID and Trans.UnitofMeasure 					= uom.unitname Set Trans.UnitofMeasureID 	= uom.unitId;');
    RefreshQuery;
end;

procedure TUOMMismatchGUI.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  with TMergeObj.create do try
    clog(AllTablesof(mUOM));
  finally
     Free;
  end;
end;

function TUOMMismatchGUI.MakeBaseunits:String;
var
  fid:Integer;
  uom :TUnitOfMeasure;
begin
  REsult:= '';
  with TempMyquery do try
    SQL.text := 'Select  unitID, Baseunitname , baseunitID, partID from tblunitsofmeasure  where ifnull(baseunitID,0) <> 0;';
    open;
    if recordcount =0 then exit;
    first;
    DoShowProgressbar(recordcount, WAITMSG, '', False);
    try
      while Eof = False do begin
        uom := TUnitOfMeasure.CreateWithNewConn(Self);
          try
          uom.Load(0);
          fid := uom.CreateUOM(Fieldbyname('Baseunitname').AsString,1,fieldbyname('partID').AsInteger,0,False);
        finally
          Freeandnil(uom);
        end;
        if (fID<> fieldbyname('baseunitID').AsInteger) and (fID<>0) then
          REsult := result +'update tblunitsofmeasure  Set  baseunitID ='+inttostr(fid)+' where unitID =' + inttostr(fieldbyname('unitId').AsInteger)+';'+NL;
        Next;
        DoStepProgressbar(inttostr(recno)+' of ' + inttostr(recordcount));
      end;

    finally
      DoHideProgressbar;
    end;
  finally
    closenFree;
  end;
end;

initialization
  RegisterClassOnce(TUOMMismatchGUI);

end.

