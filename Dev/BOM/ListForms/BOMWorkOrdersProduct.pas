unit BOMWorkOrdersProduct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOMWorkOrders, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TBOMWorkOrdersProductGUI = class(TBOMWorkOrdersGUI)
    qryMainProcTreeSeqno: TLargeintField;
    qryMainPartsDetailSeqno: TLargeintField;
    qryMainSeqno: TIntegerField;
  private
  Protected
    function TablenamePrefix :STring;Override;
    Procedure MakeQrymain;Override;
    procedure MakeTempTableSQL;Override;
    procedure SetGridColumns; Override;
    procedure DogrdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);Override;
    function ReportCategoryChanged:Boolean;Override;
    function IsSalesLinefield(const Fieldname: String): Boolean; Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TBOMWorkOrdersProductGUI }

procedure TBOMWorkOrdersProductGUI.DogrdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if sametext(field.fieldname , QrymainCaption.fieldname) OR
    sametext(field.fieldname , QrymainTree.fieldname) then begin
    if  qryMainProcTreeSeqno.asInteger <> 1 then begin
      Afont.color := ABrush.color;
      Exit;
    end;
  end;
  inherited;
end;

function TBOMWorkOrdersProductGUI.IsSalesLinefield(const Fieldname: String): Boolean;
begin
  REsult := (inherited IsSalesLinefield(fieldname)) and
            (Qrymainctr.asInteger >1);
end;

procedure TBOMWorkOrdersProductGUI.MakeQrymain;
begin
  inherited;
  closedb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select');
  Qrymain.SQL.add( SnSlSeqNo1);
  Qrymain.SQL.add( PrtDetSqno1);
  Qrymain.SQL.add( SnSlSeqNo2);
  Qrymain.SQL.add( PrtDetSqno2);
  Qrymain.SQL.Add('  T.*');
  Qrymain.SQL.Add('  from  ');
  Qrymain.SQL.add( SnSlSeqNo3);
  Qrymain.SQL.add( PrtDetSqno3);
  Qrymain.SQL.Add(tablename +'1 as T');
  Qrymain.SQL.add( ' order by Caption , saleDate desc, Seqno, saleLineId , level , SequenceDown, ProcessStepSeq;');
end;

procedure TBOMWorkOrdersProductGUI.MakeTempTableSQL;
var
  i1 :Integer;

  function TableNames:String;
  begin
    REsult :=  Tablename +' as T'+
               ' inner join tblprocessstep PS on PS.ID =  T.ProcessStepId'     + Trim(IntToStr(i1));
  end;
begin
  inherited;
  With ScriptMain do begin
    SQL.Add('Drop table if Exists '+Tablename +'1;');
    SQL.Add('Create table  '+Tablename +'1  ('+
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
        'Seqno int(11)  NOT NULL DEFAULT 0'+
        ') ENGINE=InnoDB DEFAULT CHARSET=utf8;');

    SQL.Add('insert ignore into  '+Tablename +'1  (ID,LineSeqno,SaleIDnLinenum,ctr,ClassID,saleDate,SaleID,customername,saleLineId,productname,'+
        'UnitofMeasureShipped,UOM,ProctreeID,Caption,Sequencedown,ParentId,Level,PartsId,Tree,ManufactureQty,FromStockQty,BOMOnOrderQty,TotalQty,'+
        'Instock,Available,OnOrder,SOQty,Received,Backorder,GoodsReceived,StockAvailable,SubBOMsDone,ProcessesDone,ProcessesScheduled,OktoSchedule,'+
        'ProcesspartID,ProcessStepId,ProcessStep,Duration,SetupDuration,BreakdownDuration,wDuration,iDuration,iSetupDuration,iBreakdownDuration,'+
        'Scheduledtime,ProcessStepSeq,Status,psStatus,RecordDescription,Seqno)');
      for i1 := 1 to fiProcesses do begin
            if (i1<>1)  then SQL.Add('union all');
             SetMainTablefields(i1);
             SQL.add( ',1 as Seqno ');
            SQL.add( 'from ' +Tablenames);
            SQL.add( 'where ifnull( T.ProcesspartID'     + Trim(IntToStr(i1))+' ,0)<>0');
      end;
      SQL.add( ' order by Caption , saleDate desc, saleLineId , level , SequenceDown, ProcessStepSeq;');

(*      SQL.add( ' insert ignore into  '+Tablename +'1 '+
                ' (Caption  , saleDate , Seqno , ManufactureQty)  '+
                ' Select Caption  , Max(saleDate) ,  2 , sum(ManufactureQty) from ( '+
                ' Select Distinct T.Caption  , T.saleDate ,  T.ManufactureQty , Sum(iDuration) as iDuration , Sum(iSetupduration) as iSetupduration , Sum(ibreakdownduration) as ibreakdownduration from '+Tablename +'1 T  ) DEtails Group by  Caption   ;');*)


    {Totals group by Process}
    SQL.add( 'insert ignore into  '+Tablename+'1 (Seqno , caption, saledate, ManufactureQty ,  Duration , wDuration, SetupDuration , BreakdownDuration) ' +
             ' Select 2 , Caption  ,  ' +
             ' Max(saleDate ) ,    ' +
             ' Sum(ManufactureQty) as ManufactureQty,   ' +
             ' FormatSeconds(0,sum(iDuration)) as iDuration ,     ' +
             ' FormatSeconds('+inttostr(SecsInaWorkingDay)+',sum(iDuration)) as iDuration ,     ' +
             ' FormatSeconds(0,sum(iSetupDuration)) as iSetupDuration,     ' +
             ' FormatSeconds(0,sum(iBreakdownDuration)) as iBreakdownDuration  ' +
             ' from  ( ' +
                      ' Select distinct  ProcTreeId, Caption  , saleDate  , ManufactureQty as ManufactureQty,  ' +
                      ' sum(iDuration) as iDuration ,  ' +
                      ' sum(iSetupDuration) as iSetupDuration,    ' +
                      ' sum(iBreakdownDuration) as iBreakdownDuration  ' +
                      ' from   '+Tablename+'1 as T   ' +
                      ' where ifnull(Caption  ,"")<> "" group by ProcTreeId, Caption  order by ProcTreeId, caption  ' +
             ' ) Details Group by Caption  ;');



  end;
end;

function TBOMWorkOrdersProductGUI.ReportCategoryChanged: Boolean;
begin
  result :=(QrymainPartsDetailSeqno.asInteger = 1) ;
end;

procedure TBOMWorkOrdersProductGUI.SetGridColumns;
begin
  inherited;
end;

function TBOMWorkOrdersProductGUI.TablenamePrefix: STring;
begin
  result := 'BOMWOPD';
end;

initialization
 RegisterClassOnce(TBOMWorkOrdersProductGUI);

end.
