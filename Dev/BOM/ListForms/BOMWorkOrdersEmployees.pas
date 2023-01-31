unit BOMWorkOrdersEmployees;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOMWorkOrders, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TBOMWorkOrdersEmployeesGUI = class(TBOMWorkOrdersGUI)
    qryMainEmployeeName: TWideStringField;
    qryMainProcTreeSeqno: TLargeintField;
    qryMainEmployeeDetailSeqno: TLargeintField;
    qryMainSeqno: TIntegerField;
  private
  Protected
    procedure SetGridColumns; Override;
    function TablenamePrefix :STring;Override;
    Procedure MakeQrymain;Override;
    procedure MakeTempTableSQL;Override;
    procedure DogrdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);Override;
    Function ReportCategoryChanged:Boolean;Override;
    Function TotalsField(const FieldName:String):Boolean;Override;
    function GroupField(const FieldName:String):Boolean;Override;
    function Samesalesrec:Boolean;Override;
    function SameSalesLineRec:Boolean; Override;
  public
  end;


implementation

uses CommonLib, tcConst;

{$R *.dfm}
{ TBOMWorkOrdersEmployeesGUI }

procedure TBOMWorkOrdersEmployeesGUI.DogrdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if sametext(field.fieldname , QrymainEmployeeName.fieldname) then begin
    if qryMainEmployeeDetailSeqno.asInteger <> 1 then begin
      Afont.color := ABrush.color;
      fifieldhideNo:=9;
    end;
  end;
end;

function TBOMWorkOrdersEmployeesGUI.GroupField(const FieldName: String): Boolean;
begin
  result := inherited GroupField(Fieldname);
  //result := sametext(fieldname , 'EmployeeName') ;
end;

procedure TBOMWorkOrdersEmployeesGUI.MakeQrymain;
begin
  inherited;
  closedb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select');
  Qrymain.SQL.add( SnSlSeqNo1);
  Qrymain.SQL.add( EmpDetSqno1);
  Qrymain.SQL.add( SnSlSeqNo2);
  Qrymain.SQL.add( EmpDetSqno2);
  Qrymain.SQL.Add('  T.*  ');
  Qrymain.SQL.Add('  from  ');
  Qrymain.SQL.add( SnSlSeqNo3);
  Qrymain.SQL.add( EmpDetSqno3);
  Qrymain.SQL.Add('  '+tablename +'1 as T');
  Qrymain.SQL.Add(' order by EmployeeName , Seqno, saleDate desc, saleLineId , SequenceDown, ProcessStepSeq  , level ;');

end;

procedure TBOMWorkOrdersEmployeesGUI.MakeTempTableSQL;
var
  i1 :Integer;

  function TableNames:String;
  begin
    REsult :=  Tablename +' as T'+
               ' inner join tblprocessstep PS on PS.ID =  T.ProcessStepId'     + Trim(IntToStr(i1))+
               ' inner join tblemployeeprocesssteps EPS on EPS.ProcessStepID = PS.ID ' +
               ' inner join tblemployees E on EPS.EmployeeID = E.EmployeeID ' ;
  end;
begin
  inherited;
  With ScriptMain do begin
    SQL.Add('Drop table if Exists '+Tablename +'1;');
    SQL.Add('Create table  '+Tablename +'1 ( ' +
            ' ID 							int(11) NOT NULL DEFAULT 0, ' +
            ' LineSeqno 			int(11) DEFAULT NULL, ' +
            ' SaleIDnLinenum 	varchar(55) DEFAULT NULL, ' +
            ' ctr 						int(11)  NOT NULL DEFAULT 0, ' +
            ' ClassID 				int(11) DEFAULT NULL, ' +
            ' saleDate 				datetime DEFAULT NULL, ' +
            ' SaleID 					int(11) DEFAULT NULL, ' +
            ' customername 		varchar(255) DEFAULT NULL, ' +
            ' saleLineId 			int(11) NOT NULL DEFAULT 0, ' +
            ' productname 		varchar(60) DEFAULT NULL, ' +
            ' UnitofMeasureShipped double NOT NULL DEFAULT 0, ' +
            ' UOM 						varchar(100) DEFAULT NULL, ' +
            ' ProctreeID 			int(11) NOT NULL DEFAULT 0, ' +
            ' Caption 				varchar(255) DEFAULT NULL, ' +
            ' Sequencedown 		int(11) DEFAULT NULL, ' +
            ' ParentId 				int(11) DEFAULT NULL, ' +
            ' Level 					int(11) DEFAULT NULL, ' +
            ' PartsId 				int(11) DEFAULT NULL, ' +
            ' Tree 						varchar(255) DEFAULT NULL, ' +
            ' ManufactureQty 	double DEFAULT NULL, ' +
            ' FromStockQty 		double DEFAULT NULL, ' +
            ' BOMOnOrderQty 	double DEFAULT NULL, ' +
            ' TotalQty 				double NOT NULL DEFAULT 0, ' +
            ' Instock 				double DEFAULT NULL, ' +
            ' Available 			double DEFAULT NULL, ' +
            ' OnOrder 				double DEFAULT NULL, ' +
            ' SOQty 					double DEFAULT NULL, ' +
            ' Received 				double DEFAULT NULL, ' +
            ' Backorder 			double DEFAULT NULL, ' +
            ' GoodsReceived 	int(11) DEFAULT NULL, ' +
            ' StockAvailable 	int(11) DEFAULT NULL, ' +
            ' SubBOMsDone 		int(11) DEFAULT NULL, ' +
            ' ProcessesDone 	int(11) DEFAULT NULL, ' +
            ' ProcessesScheduled int(11) DEFAULT NULL, ' +
            ' OktoSchedule 		int(11) DEFAULT NULL, ' +
            ' ProcesspartID 	int(11) DEFAULT NULL, ' +
            ' ProcessStepId 	int(11) DEFAULT NULL, ' +
            ' ProcessStep 		varchar(50) DEFAULT NULL, ' +
            ' Duration 				varchar(40) DEFAULT NULL, ' +
            ' SetupDuration 	varchar(40) DEFAULT NULL, ' +
            ' BreakdownDuration varchar(40) DEFAULT NULL, ' +
            ' wDuration 			varchar(40) DEFAULT NULL, ' +
            ' iDuration 			int(11) DEFAULT NULL, ' +
            ' iSetupDuration 	int(11) DEFAULT NULL, ' +
            ' iBreakdownDuration int(11) DEFAULT NULL, ' +
            ' Scheduledtime 	varchar(40) DEFAULT NULL, ' +
            ' ProcessStepSeq 	int(11) DEFAULT NULL, ' +
            ' Status 					varchar(20) DEFAULT NULL, ' +
            ' psStatus 				varchar(20) DEFAULT NULL, ' +
            ' RecordDescription varchar(255) DEFAULT NULL, ' +
            ' Seqno 					int(11) NOT NULL DEFAULT 0, ' +
            ' EmployeeName 		varchar(255) DEFAULT NULL ' +
            ' ) ENGINE=InnoDB DEFAULT CHARSET=utf8;');

    SQL.Add('insert ignore into  '+Tablename +'1 ( ' +
            ' ID,LineSeqno,SaleIDnLinenum,ctr,ClassID,saleDate,SaleID,customername,saleLineId,productname,UnitofMeasureShipped,UOM,ProctreeID,Caption,'+
            'Sequencedown,ParentId,Level,PartsId,Tree,ManufactureQty,FromStockQty,BOMOnOrderQty,TotalQty,Instock,Available,OnOrder,SOQty,Received,Backorder,'+
            'GoodsReceived,StockAvailable,SubBOMsDone,ProcessesDone,ProcessesScheduled,OktoSchedule,ProcesspartID,ProcessStepId,ProcessStep,Duration,SetupDuration,'+
            'BreakdownDuration,wDuration,iDuration,iSetupDuration,iBreakdownDuration,Scheduledtime,ProcessStepSeq,Status,psStatus,RecordDescription,Seqno,EmployeeName)');
      for i1 := 1 to fiProcesses do begin
            if (i1<>1)  then SQL.Add('union all');
            SetMainTablefields(i1);
            SQL.add( ',1 as Seqno , E.EmployeeName ');
            SQL.add( 'from ' +Tablenames);
            SQL.add( 'where ifnull( T.ProcesspartID'     + Trim(IntToStr(i1))+' ,0)<>0');
      end;
      SQL.add( 'order by EmployeeName , saleDate desc, saleLineId , SequenceDown, ProcessStepSeq  , level ;');

    {Totals group by emoployee}
    SQL.add( 'insert ignore into  '+Tablename +'1 (Seqno , Employeename , UnitofMeasureShipped ,ManufactureQty ,  Duration , SetupDuration , BreakdownDuration, wDuration ) '+
              ' Select 2 , Employeename ,  '+
                          ' sum(UnitofMeasureShipped) as UnitofMeasureShipped,   '+
                          ' Sum(ManufactureQty) as ManufactureQty, '+
                          ' FormatSeconds(0,sum(iDuration)) as iDuration ,   '+
                          ' FormatSeconds(0,sum(iSetupDuration)) as iSetupDuration,   '+
                          ' FormatSeconds(0,sum(iBreakdownDuration)) as iBreakdownDuration, '+
                          ' FormatSeconds('+inttostr(SecsInaWorkingDay)+',sum(iDuration)) as wDuration  from '+
              ' (Select distinct SaleLineId, Employeename , UnitofMeasureShipped ,sum(ManufactureQty) as ManufactureQty, sum(iDuration) as iDuration , sum(iSetupDuration) as iSetupDuration, sum(iBreakdownDuration) as iBreakdownDuration'+
              ' from   '+Tablename +'1 as T group by SaleLineId, Employeename ) Details Group by Employeename;');

  end;
end;

function TBOMWorkOrdersEmployeesGUI.ReportCategoryChanged: Boolean;
begin
  result := QrymainEmployeeDetailSeqno.asInteger = 1;
end;

function TBOMWorkOrdersEmployeesGUI.SameSalesLineRec: Boolean;
begin
  Result := inherited SameSalesLineRec;
  if result then
    Result := (QrymainEmployeeDetailSeqno.asInteger <> 1);
end;

function TBOMWorkOrdersEmployeesGUI.Samesalesrec: Boolean;
begin
  result := inherited Samesalesrec;
  if result then
    Result := (QrymainEmployeeDetailSeqno.asInteger <> 1);
end;

procedure TBOMWorkOrdersEmployeesGUI.SetGridColumns;
begin
  inherited;
end;

function TBOMWorkOrdersEmployeesGUI.TablenamePrefix: STring;
begin
  result := 'BOMWOE';
end;

function TBOMWorkOrdersEmployeesGUI.TotalsField(const FieldName: String): Boolean;
begin
  REsult := inherited TotalsField(Fieldname);
  if not result then result := sametext(fieldname , 'UnitofMeasureShipped') or sametext(fieldname , 'ProductName') ;
end;

initialization
 RegisterClassOnce(TBOMWorkOrdersEmployeesGUI);

end.
