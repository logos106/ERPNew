unit BOMWorkOrdersSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOMWorkOrders, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TBOMWorkOrdersSummaryGUI = class(TBOMWorkOrdersGUI)
    qryMainProcTreeSeqno: TLargeintField;
    qryMainProcessPartSeqno: TLargeintField;
    qryMainSeqno: TIntegerField;
  private
  Protected
    function TablenamePrefix :STring;Override;
    Procedure MakeQrymain;Override;
    Procedure MakeTempTableSQL;Override;
    procedure SetGridColumns; Override;
    procedure DogrdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);Override;
    Function TotalsField(const FieldName:String):Boolean;Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TBOMWorkOrdersSummaryGUI }

procedure TBOMWorkOrdersSummaryGUI.DogrdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
end;

procedure TBOMWorkOrdersSummaryGUI.MakeQrymain;
begin
  closedb(Qrymain);
  Qrymain.SQL.clear;

  closedb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select');

  Qrymain.SQL.add( SnSlSeqNo1);
  Qrymain.SQL.add( PTsqNo1);

  Qrymain.SQL.add( SnSlSeqNo2);
  Qrymain.SQL.add( PTsqNo2);
  Qrymain.SQL.Add('  T.*  ');
  Qrymain.SQL.Add('  from  ');

  Qrymain.SQL.add( SnSlSeqNo3);
  Qrymain.SQL.add( PTsqNo3);

  Qrymain.SQL.Add('  '+tablename +'1 as T ');
  Qrymain.SQL.Add('order by saleDate desc, SaleId desc, Seqno, saleLineId , level , SequenceDown, ProcessStepSeq ;');
end;

procedure TBOMWorkOrdersSummaryGUI.MakeTempTableSQL;
var
  i1 :Integer;

  function TableNames:String;
  begin
    REsult :=  Tablename +' as T';
  end;
begin
  inherited;
  With ScriptMain do begin
    SQL.Add('Drop table if Exists '+Tablename +'1;');
    SQL.Add('CREATE TABLE '+Tablename +'1 ( '+
              '  `ID` 										int(11) 			NOT NULL Default 0, '+
              '  `LineSeqno` 						int(11)       Null DEFAULT    NULL, '+
              '  `SaleIDnLinenum` 				varchar(55)   Null DEFAULT    NULL, '+
              '  `ctr` 									int(11) 			NULL  DEFAULT    0, '+
              '  `ClassID` 							int(11)       Null DEFAULT    NULL, '+
              '  `saleDate` 							datetime      Null DEFAULT    NULL, '+
              '  `SaleID` 								int(11)       Null DEFAULT    NULL, '+
              '  `customername` 					varchar(255)  Null DEFAULT    NULL, '+
              '  `saleLineId` 						int(11)       Null DEFAULT    0, '+
              '  `productname` 					varchar(60)   Null DEFAULT    NULL, '+
              '  `UnitofMeasureShipped` 	double   			Null DEFAULT    0, '+
              '  `UOM` 									varchar(100)  Null DEFAULT    NULL, '+
              '  `ProctreeID` 						int(11)       Null DEFAULT    0, '+
              '  `Caption` 							varchar(255)  Null DEFAULT    NULL, '+
              '  `Sequencedown` 					int(11)       Null DEFAULT    NULL, '+
              '  `ParentId` 							int(11)       Null DEFAULT    NULL, '+
              '  `Level` 								int(11)       Null DEFAULT    NULL, '+
              '  `PartsId` 							int(11)       Null DEFAULT    NULL, '+
              '  `Tree` 									varchar(255)  Null DEFAULT    NULL, '+
              '  `ManufactureQty` 				double        Null DEFAULT    NULL, '+
              '  `FromStockQty` 					double        Null DEFAULT    NULL, '+
              '  `BOMOnOrderQty` 				double        Null DEFAULT    NULL, '+
              '  `TotalQty` 							double        Null DEFAULT    0, '+
              '  `Instock` 							double        Null DEFAULT    NULL, '+
              '  `Available` 						double        Null DEFAULT    NULL, '+
              '  `OnOrder` 							double        Null DEFAULT    NULL, '+
              '  `SOQty` 								double        Null DEFAULT    NULL, '+
              '  `Received` 							double        Null DEFAULT    NULL, '+
              '  `Backorder` 						double        Null DEFAULT    NULL, '+
              '  `GoodsReceived` 				int(11)       Null DEFAULT    NULL, '+
              '  `StockAvailable` 				int(11)       Null DEFAULT    NULL, '+
              '  `SubBOMsDone` 					int(11)       Null DEFAULT    NULL, '+
              '  `ProcessesDone` 				int(11)       Null DEFAULT    NULL, '+
              '  `ProcessesScheduled` 		int(11)    		Null DEFAULT    NULL, '+
              '  `OktoSchedule` 					int(11)       Null DEFAULT    NULL, '+
              '  `ProcesspartID` 				int(11)       Null DEFAULT    NULL, '+
              '  `ProcessStepId` 				int(11)       Null DEFAULT    NULL, '+
              '  `ProcessStep` 					varchar(50)   Null DEFAULT    NULL, '+
              '  `Duration` 							varchar(40)   Null DEFAULT    NULL, '+
              '  `SetupDuration` 				varchar(40)   Null DEFAULT    NULL, '+
              '  `BreakdownDuration` 		varchar(40) 	Null DEFAULT    NULL, '+
              '  `wDuration` 						varchar(40)   Null DEFAULT    NULL, '+
              '  `iDuration` 						int(11)       Null DEFAULT    NULL, '+
              '  `iSetupDuration` 				int(11)       Null DEFAULT    NULL, '+
              '  `iBreakdownDuration` 		int(11)    		Null DEFAULT    NULL, '+
              '  `Scheduledtime` 				varchar(40)   Null DEFAULT    NULL, '+
              '  `ProcessStepSeq` 				int(11)       Null DEFAULT    NULL, '+
              '  `Status` 								varchar(20)   Null DEFAULT    NULL, '+
              '  `psStatus` 							varchar(20)   Null DEFAULT    NULL, '+
              '  `RecordDescription` 		varchar(255)	Null DEFAULT    NULL, '+
              '  `Seqno` 								int(11)       Null DEFAULT    0 '+
              '  ) ENGINE=MyIsam DEFAULT CHARSET=utf8;');

    SQL.Add('insert ignore  into '+Tablename +'1 ');
      for i1 := 1 to fiProcesses do begin
            if (i1<>1)  then SQL.Add('union all');
            SetMainTablefields(i1);
            SQL.add( ',Convert(1, Signed) as Seqno ');
            SQL.add( 'from ' +Tablenames);
            SQL.add( 'where ifnull( T.ProcesspartID'     + Trim(IntToStr(i1))+' ,0)<>0');
      end;
      SQL.add( ' order by saleDate desc, SaleId desc,  saleLineId , level , SequenceDown, ProcessStepSeq ;');

(*      SQL.add( ' insert ignore into  '+Tablename +'1 '+
                ' (SaleDate,SaleId , Seqno , UnitofMeasureShipped)  '+
                ' Select SaleDate,SaleId, 2 , sum(UnitofMeasureShipped) from (Select Distinct SaleDate,SaleId, SaleLineID  , UnitofMeasureShipped from '+Tablename +') DEtails Group by SaleDate,SaleId;');*)

    SQL.add( 'insert ignore into  '+Tablename+'1 (Seqno , SaleId, saledate, UnitofMeasureShipped ,  Duration , wDuration, SetupDuration , BreakdownDuration , iDuration , iSetupDuration , iBreakdownDuration) ' +
             ' Select 2 , SaleID,  SaleDate,      ' +
             ' Sum(UnitofMeasureShipped) as UnitofMeasureShipped,     ' +
             ' FormatSeconds(0,sum(iDuration)) as Duration ,       ' +
             ' FormatSeconds('+inttostr(SecsInaWorkingDay)+',sum(iDuration)) as Duration ,       ' +
             ' FormatSeconds(0,sum(iSetupDuration)) as SetupDuration,       ' +
             ' FormatSeconds(0,sum(iBreakdownDuration)) as BreakdownDuration  ,  ' +
             ' sum(iDuration) as iDuration ,       ' +
             ' sum(iSetupDuration) as iSetupDuration,       ' +
             ' sum(iBreakdownDuration) as iBreakdownDuration    ' +
             ' from  ( ' +
                      ' Select SaleID,  saleLineID, Max(saleDate ) SaleDAte,     ' +
                      ' UnitofMeasureShipped as UnitofMeasureShipped,    ' +
                      ' sum(iDuration) as iDuration ,      ' +
                      ' sum(iSetupDuration) as iSetupDuration,      ' +
                      ' sum(iBreakdownDuration) as iBreakdownDuration   ' +
                      ' from  ( ' +
                              ' Select distinct  saleLineID, ProcTreeId , ProcessPArtID , SaleId  , saleDate  ,  ' +
                              ' UnitofMeasureShipped as UnitofMeasureShipped,    ' +
                              ' (iDuration) as iDuration ,    ' +
                              ' (iSetupDuration) as iSetupDuration,      ' +
                              ' (iBreakdownDuration) as iBreakdownDuration    ' +
                              ' from   '+Tablename+'1 as T     ' +
                              ' where ifnull(Caption  ,"")<> "" group by ProcTreeId , ProcessPArtID ' +
                      ' ) Details group by saleLineID  ' +
             ' ) Subdetails Group by SaleID ;');


  end;
end;

procedure TBOMWorkOrdersSummaryGUI.SetGridColumns;
begin
  inherited;
end;

function TBOMWorkOrdersSummaryGUI.TablenamePrefix: STring;
begin
  result := 'BOMWOS';
end;

function TBOMWorkOrdersSummaryGUI.TotalsField(const FieldName: String): Boolean;
begin
  result := inherited TotalsField(Fieldname);
  if not result then
    result := sametext(fieldname , 'UnitofMeasureShipped') ;
end;

initialization
 RegisterClassOnce(TBOMWorkOrdersSummaryGUI);

end.
