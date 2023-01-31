unit BOMWorkOrdersExtraDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOMWorkOrders, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TBOMWorkOrdersExtraDetailsGUI = class(TBOMWorkOrdersGUI)
    qryMainProcTreeSeqno: TLargeintField;
    qryMainProcessPartSeqno: TLargeintField;
    qryMainProcessStepResNum: TLargeintField;
    qryMainProcessPartResNum: TLargeintField;
    qryMainProcResDetSeqno: TLargeintField;
    qryMainProcResDetEmpSeqno: TLargeintField;
    qryMainResourceId: TIntegerField;
    qryMainResourceDetailId: TIntegerField;
    qryMainResourceName: TWideStringField;
    qryMainResourceDetailName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainSeqno: TIntegerField;
  private
  Protected
    function TablenamePrefix :STring;Override;
    Procedure MakeQrymain;Override;
    procedure MakeTempTableSQL;Override;
    procedure SetGridColumns; Override;
    Function TotalsField(const FieldName:String):Boolean;Override;
    procedure DogrdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TBOMWorkOrdersExtraDetailsGUI }

procedure TBOMWorkOrdersExtraDetailsGUI.DogrdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin

    if Processfield(Field.fieldname) then begin
      //if  qryMainProcessStepResNum.asInteger <> 1 then begin
      if  qryMainProcessPartResNum.asInteger <> 1 then begin
        Afont.color := ABrush.color;
        Exit;
      end;
    end;
    if Sametext(Field.fieldname , qryMainResourceName.fieldname ) then begin
      if  (qryMainProcessPartResNum.asInteger <> 1 ) and (qryMainProcResDetSeqno.asInteger <> 1) then begin
        Afont.color := ABrush.color;
        Exit;
      end;
    end;

    if Sametext(Field.fieldname , qryMainResourceDetailName.fieldname ) then begin
      if  (qryMainProcessPartResNum.asInteger <> 1 ) and (qryMainProcResDetSeqno.asInteger <> 1) and (qryMainProcResDetEmpSeqno.asInteger <> 1)  then begin
        Afont.color := ABrush.color;
        Exit;
      end;
    end;

  inherited;
end;

procedure TBOMWorkOrdersExtraDetailsGUI.MakeQrymain;
begin
  inherited;
  closedb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select');
  Qrymain.SQL.add( SnSlSeqNo1);
  Qrymain.SQL.add( PTsqNo1);
  Qrymain.SQL.add( PSsqNo1);
  Qrymain.SQL.add( PPsqNo1);
  Qrymain.SQL.add( PresSqNo1);
  Qrymain.SQL.add( PresDetSqNo1);

  Qrymain.SQL.add( SnSlSeqNo2);
  Qrymain.SQL.add( PTsqNo2);
  Qrymain.SQL.add( PSsqNo2);
  Qrymain.SQL.add( PPsqNo2);
  Qrymain.SQL.add( PresSqNo2);
  Qrymain.SQL.add( PresDetSqNo2);

  Qrymain.SQL.Add('  T.*  ');
  Qrymain.SQL.Add('  from  ');
  Qrymain.SQL.add( SnSlSeqNo3);
  Qrymain.SQL.add( PTsqNo3);
  Qrymain.SQL.add( PSsqNo3);
  Qrymain.SQL.add( PPsqNo3);
  Qrymain.SQL.add( PresSqNo3);
  Qrymain.SQL.add( PresDetSqNo3);

  Qrymain.SQL.Add('  '+tablename +'1 as T');

end;

function TBOMWorkOrdersExtraDetailsGUI.TablenamePrefix: STring;
begin
  result := 'BOMWOED';
end;
function TBOMWorkOrdersExtraDetailsGUI.TotalsField(const FieldName: String): Boolean;
begin
  Result := inherited TotalsField(Fieldname);
  if not result then result := sametext(fieldname , 'UnitofMeasureShipped') ;
end;

procedure TBOMWorkOrdersExtraDetailsGUI.MakeTempTableSQL;
var
  i1 :Integer;

  function TableNames:String;
  begin
    REsult :=  Tablename +' as T'+
               ' inner join tblprocessstep PS on PS.ID =  T.ProcessStepId'     + Trim(IntToStr(i1))+
               ' inner join tblemployeeprocesssteps EPS on EPS.ProcessStepID = PS.ID ' +
               ' inner join tblemployees E on EPS.EmployeeID = E.EmployeeID ' +
               ' inner join tblprocresourceprocess PRP on PS.ID= PRP.ProcessStepId ' +
               ' inner join tblprocresource PR on PR.ProcResourceId = PRP.ProcResourceId ' +
               ' inner join tblprocresourcedetails PRD on PR.ProcResourceId = PRD.ProcResourceId';
  end;
begin
  inherited;
  With ScriptMain do begin
    SQL.Add('Drop table if Exists '+Tablename +'1;');
    SQL.Add('Create table  '+Tablename +'1 ('+
    'ID int(11) NOT NULL DEFAULT 0,'+
    'LineSeqno int(11) DEFAULT NULL,'+
    'SaleIDnLinenum varchar(55) DEFAULT NULL,'+
    'ctr int(11)  NOT NULL DEFAULT 0,'+
    'ClassID int(11) DEFAULT NULL,'+
    'saleDate datetime DEFAULT NULL,'+
    'SaleID int(11) DEFAULT NULL,'+
    'customername varchar(255) DEFAULT NULL,'+
    'saleLineId int(11) NOT NULL DEFAULT 0,'+
    'productname varchar(60) DEFAULT NULL,'+
    'UnitofMeasureShipped double NOT NULL DEFAULT 0,'+
    'UOM varchar(100) DEFAULT NULL,'+
    'ProctreeID int(11) NOT NULL DEFAULT 0,'+
    'Caption varchar(255) DEFAULT NULL,'+
    'Sequencedown int(11) DEFAULT NULL,'+
    'ParentId int(11) DEFAULT NULL,'+
    'Level int(11) DEFAULT NULL,'+
    'PartsId int(11) DEFAULT NULL,'+
    'Tree varchar(255) DEFAULT NULL,'+
    'ManufactureQty double DEFAULT NULL,'+
    'FromStockQty double DEFAULT NULL,'+
    'BOMOnOrderQty double DEFAULT NULL,'+
    'TotalQty double NOT NULL DEFAULT 0,'+
    'Instock double DEFAULT NULL,'+
    'Available double DEFAULT NULL,'+
    'OnOrder double DEFAULT NULL,'+
    'SOQty double DEFAULT NULL,'+
    'Received double DEFAULT NULL,'+
    'Backorder double DEFAULT NULL,'+
    'GoodsReceived int(11) DEFAULT NULL,'+
    'StockAvailable int(11) DEFAULT NULL,'+
    'SubBOMsDone int(11) DEFAULT NULL,'+
    'ProcessesDone int(11) DEFAULT NULL,'+
    'ProcessesScheduled int(11) DEFAULT NULL,'+
    'OktoSchedule int(11) DEFAULT NULL,'+
    'ProcesspartID int(11) DEFAULT NULL,'+
    'ProcessStepId int(11) DEFAULT NULL,'+
    'ProcessStep varchar(50) DEFAULT NULL,'+
    'Duration varchar(40) DEFAULT NULL,'+
    'SetupDuration varchar(40) DEFAULT NULL,'+
    'BreakdownDuration varchar(40) DEFAULT NULL,'+
    'wDuration varchar(40) DEFAULT NULL,'+
    'iDuration int(11) DEFAULT NULL,'+
    'iSetupDuration int(11) DEFAULT NULL,'+
    'iBreakdownDuration int(11) DEFAULT NULL,'+
    'Scheduledtime varchar(40) DEFAULT NULL,'+
    'ProcessStepSeq int(11) DEFAULT NULL,'+
    'Status varchar(20) DEFAULT NULL,'+
    'psStatus varchar(20) DEFAULT NULL,'+
    'RecordDescription varchar(255) DEFAULT NULL,'+
    'Seqno int(11)  NOT NULL DEFAULT 0,'+
    'ResourceId int(11) NOT NULL DEFAULT 0,'+
    'ResourceDetailId int(11) NOT NULL DEFAULT 0,'+
    'ResourceName varchar(255) NOT NULL DEFAULT "",'+
    'ResourceDetailName varchar(255) DEFAULT NULL,'+
    'EmployeeName varchar(255) DEFAULT NULL'+
    ') ENGINE=InnoDB DEFAULT CHARSET=utf8; ');

    SQL.Add('Insert ignore into  '+Tablename +'1 (ID,LineSeqno,SaleIDnLinenum,ctr,ClassID,saleDate,SaleID,customername,saleLineId,productname,'+
    'UnitofMeasureShipped,UOM,ProctreeID,Caption,Sequencedown,ParentId,Level,PartsId,Tree,ManufactureQty,FromStockQty,BOMOnOrderQty,TotalQty,'+
    'Instock,Available,OnOrder,SOQty,Received,Backorder,GoodsReceived,StockAvailable,SubBOMsDone,ProcessesDone,ProcessesScheduled,OktoSchedule,'+
    'ProcesspartID,ProcessStepId,ProcessStep,Duration,SetupDuration,BreakdownDuration,wDuration,iDuration,iSetupDuration,iBreakdownDuration,'+
    'Scheduledtime,ProcessStepSeq,Status,psStatus,RecordDescription,Seqno,ResourceId,ResourceDetailId,ResourceName,ResourceDetailName,EmployeeName)');
      for i1 := 1 to fiProcesses do begin
            if (i1<>1)  then SQL.Add('union all');
            SetMainTablefields(i1);
            SQL.add( ',1 as Seqno, ');
            SQL.add( 'PR.ProcResourceId as ResourceId,');
            SQL.add( 'PRD.ID ResourceDetailId,');
            SQL.add( 'PR.ResourceName as ResourceName,');
            SQL.add( 'PRD.Description ResourceDetailName,');
            SQL.add( 'E.EmployeeName');
            SQL.add( 'from ' +Tablenames);
            SQL.add( 'where ifnull( T.ProcesspartID'     + Trim(IntToStr(i1))+' ,0)<>0');
      end;
      SQL.add( ' order by saleDate desc, saleLineId , level , SequenceDown, ProcessStepSeq, ResourceName,ResourceDetailName, EmployeeName;');

    SQL.add( 'insert ignore into  '+Tablename+'1 (Seqno , SaleId, saledate, UnitofMeasureShipped ,  Duration ,wDuration , SetupDuration , BreakdownDuration ,  iDuration , iSetupDuration , iBreakdownDuration) ' +
             ' Select 2 , SaleID,  SaleDate,      ' +
             ' Sum(UnitofMeasureShipped) as UnitofMeasureShipped,     ' +
             ' FormatSeconds(0,sum(iDuration)) as Duration ,       ' +
             ' FormatSeconds('+inttostr(SecsInaWorkingDay)+',sum(iDuration)) as wDuration ,       ' +
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
procedure TBOMWorkOrdersExtraDetailsGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainResourceId.fieldname);
    RemoveFieldfromGrid(qryMainResourceDetailId.fieldname);

end;

initialization
 RegisterClassOnce(TBOMWorkOrdersExtraDetailsGUI);

end.
