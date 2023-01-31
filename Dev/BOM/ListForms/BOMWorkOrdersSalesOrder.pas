unit BOMWorkOrdersSalesOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOMWorkOrders, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBOMWorkOrdersSalesOrderGUI = class(TBOMWorkOrdersGUI)
    grpExtraOptions: TRadioGroup;
    qryMainProcessPartSeqno: TLargeintField;
    qryMainResourceName: TWideStringField;
    qryMainResourceDetailName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainProcTreeSeqno: TLargeintField;
    qryMainProcessStepResNum: TLargeintField;
    qryMainProcessPartResNum: TLargeintField;
    qryMainProcResDetSeqno: TLargeintField;
    qryMainSeqno: TIntegerField;
    qryMainResourceId: TIntegerField;
    qryMainResourceDetailId: TIntegerField;
    procedure grpExtraOptionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fiExtraOptionsIndex:Integer;
  Protected
    function TablenamePrefix :STring;Override;
    Procedure MakeQrymain;Override;
    procedure MakeTempTableSQL;Override;
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure DogrdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);Override;
    Function TotalsField(const FieldName:String):Boolean;Override;

  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}
{ TBOMWorkOrdersSalesOrderGUI }

procedure TBOMWorkOrdersSalesOrderGUI.MakeQrymain;
begin
  inherited;
  closedb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select distinct ');
  Qrymain.SQL.add( SnSlSeqNo1);
  Qrymain.SQL.add( PTsqNo1);
  Qrymain.SQL.add( PSsqNo1);
  Qrymain.SQL.add( PPsqNo1);
  Qrymain.SQL.add( PresSqNo1);

  Qrymain.SQL.add( SnSlSeqNo2);
  Qrymain.SQL.add( PTsqNo2);
  Qrymain.SQL.add( PSsqNo2);
  Qrymain.SQL.add( PPsqNo2);
  Qrymain.SQL.add( PresSqNo2);

  Qrymain.SQL.Add('  T.*  ');

  Qrymain.SQL.Add('  from  ');
  Qrymain.SQL.add( SnSlSeqNo3);
  Qrymain.SQL.add( PTsqNo3);
  Qrymain.SQL.add( PSsqNo3);
  Qrymain.SQL.add( PPsqNo3);
  Qrymain.SQL.add( PresSqNo3);

  Qrymain.SQL.Add('  '+tablename +'1 as T');
  Qrymain.SQL.Add(' order by saleDate desc, SaleId desc, Seqno, saleLineId , level , SequenceDown, ProcessStepSeq,ResourceName,ResourceDetailName, EmployeeName;');

end;

procedure TBOMWorkOrdersSalesOrderGUI.MakeTempTableSQL;
var
  i1  :Integer;
  function TableNames:String;
  begin
    if grpExtraOptions.ItemIndex =1  then begin
    Result :=  Tablename +' as T'+
               ' inner join tblprocessstep PS on PS.ID =  T.ProcessStepId'     + Trim(IntToStr(i1))+
               ' inner join tblprocresourceprocess PRP on PS.ID= PRP.ProcessStepId ' +
               ' inner join tblprocresource PR on PR.ProcResourceId = PRP.ProcResourceId ' +
               ' inner join tblprocresourcedetails PRD on PR.ProcResourceId = PRD.ProcResourceId';
    end else if grpExtraOptions.ItemIndex =0  then begin
    Result :=  Tablename +' as T'+
               ' inner join tblprocessstep PS on PS.ID =  T.ProcessStepId'     + Trim(IntToStr(i1))+
               ' inner join tblemployeeprocesssteps EPS on EPS.ProcessStepID = PS.ID ' +
               ' inner join tblemployees E on EPS.EmployeeID = E.EmployeeID ' ;
    end;
(*    Result :=  Tablename +' as T'+
               ' inner join tblprocessstep PS on PS.ID =  T.ProcessStepId'     + Trim(IntToStr(i1))+
               ' inner join tblemployeeprocesssteps EPS on EPS.ProcessStepID = PS.ID ' +
               ' inner join tblemployees E on EPS.EmployeeID = E.EmployeeID ' +
               ' inner join tblprocresourceprocess PRP on PS.ID= PRP.ProcessStepId ' +
               ' inner join tblprocresource PR on PR.ProcResourceId = PRP.ProcResourceId ' +
               ' inner join tblprocresourcedetails PRD on PR.ProcResourceId = PRD.ProcResourceId';*)
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
    'ResourceId int(11)  NOT NULL DEFAULT 0,'+
    'ResourceDetailId int(11)  NOT NULL DEFAULT 0,'+
    'ResourceName varchar(255) DEFAULT NULL,'+
    'ResourceDetailName varchar(255) DEFAULT NULL,'+
    'EmployeeName varchar(255) DEFAULT NULL'+
    ') ENGINE=InnoDB DEFAULT CHARSET=utf8; ');
    SQL.Add('Insert ignore into  '+Tablename +'1 (ID,LineSeqno,SaleIDnLinenum,ctr,ClassID,saleDate,SaleID,customername,saleLineId,productname,'+
    'UnitofMeasureShipped,UOM,ProctreeID,Caption,Sequencedown,ParentId,Level,PartsId,Tree,ManufactureQty,FromStockQty,BOMOnOrderQty,TotalQty,'+
    'Instock,Available,OnOrder,SOQty,Received,Backorder,GoodsReceived,StockAvailable,SubBOMsDone,ProcessesDone,ProcessesScheduled,OktoSchedule,'+
    'ProcesspartID,ProcessStepId,ProcessStep,Duration,SetupDuration,BreakdownDuration,wDuration,iDuration,iSetupDuration,iBreakdownDuration,Scheduledtime,'+
    'ProcessStepSeq,Status,psStatus,RecordDescription,Seqno,ResourceId,ResourceDetailId,ResourceName,ResourceDetailName,EmployeeName)');
      for i1 := 1 to fiProcesses do begin
            if (i1<>1)  then SQL.Add('union all');
            SetMainTablefields(i1);
            SQL.add( ',1 as Seqno, ');
            if grpExtraOptions.ItemIndex =1  then begin
              SQL.add( 'convert(PR.ProcResourceId  , SIGNED      ) as ResourceId,');
              SQL.add( ' convert(PRD.ID             , SIGNED      ) as ResourceDetailId,');
              SQL.add( ' convert(PR.ResourceName    , CHAR(255)   ) as ResourceName,');
              SQL.add( ' convert(PRD.Description    , CHAR(255)   ) as ResourceDetailName,');
              SQL.add( ' convert(NULL               , CHAR(255)   ) as EmployeeName');
            end else if grpExtraOptions.ItemIndex =0  then begin
              SQL.add( 'convert(NULL               , SIGNED      ) as  ResourceId,');
              SQL.add( ' convert(NULL               , SIGNED      ) as ResourceDetailId,');
              SQL.add( ' convert(NULL               , CHAR(255)   ) as ResourceName,');
              SQL.add( ' convert(NULL               , CHAR(255)   ) as ResourceDetailName,');
              SQL.add( ' convert(E.EmployeeName     , CHAR(255)   ) as EmployeeName');
            end;
            SQL.add( 'from ' +Tablenames);
            SQL.add( 'where ifnull( T.ProcesspartID'     + Trim(IntToStr(i1))+' ,0)<>0');
      end;
      SQL.add( ' order by saleDate desc, saleLineId , level , SequenceDown, ProcessStepSeq,ResourceName,ResourceDetailName, EmployeeName;');

    SQL.add( 'insert ignore into  '+Tablename+'1 (Seqno , SaleId, saledate, UnitofMeasureShipped ,  Duration ,wDuration,  SetupDuration , BreakdownDuration , iDuration , iSetupDuration , iBreakdownDuration) ' +
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

            (* ' Select 2 , SaleID, ' +
             ' Max(saleDate ) ,    ' +
             ' Sum(UnitofMeasureShipped) as UnitofMeasureShipped,   ' +
             ' FormatSeconds(0,sum(iDuration)) as iDuration ,     ' +
             ' FormatSeconds(0,sum(iSetupDuration)) as iSetupDuration,     ' +
             ' FormatSeconds(0,sum(iBreakdownDuration)) as iBreakdownDuration  ' +
             ' from  ( ' +
                      ' Select distinct  ProcTreeId , ProcessPArtID , SaleId  , saleDate  , UnitofMeasureShipped as UnitofMeasureShipped,  ' +
                      ' (iDuration) as iDuration ,  ' +
                      ' (iSetupDuration) as iSetupDuration,    ' +
                      ' (iBreakdownDuration) as iBreakdownDuration  ' +
                      ' from   '+Tablename+'1 as T   ' +
                      ' where ifnull(Caption  ,"")<> "" group by ProcTreeId , ProcessPArtID  ' +
             ' ) Details Group by SaleID ;');*)
  end;
end;

procedure TBOMWorkOrdersSalesOrderGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.ExtraOptionsIndex') then grpExtraOptions.ItemIndex:=  GuiPrefs.Node['Options.ExtraOptionsIndex'].asInteger;
end;

procedure TBOMWorkOrdersSalesOrderGUI.RefreshQuery;
var
  fiIndex:Integer;
begin
  if grpExtraOptions.ItemIndex =0  then fiIndex:= QryMainResourceName.Index else fiIndex:=QryMainEmployeeName.Index;

  inherited;
  if grpExtraOptions.ItemIndex =0  then begin
    GuiPrefs.DbGridElement[grdMain].AddFields(QryMainEmployeeName.FieldName , fiIndex);
    GuiPrefs.DbGridElement[grdMain].RemoveFields(QryMainResourceName.FieldName +',' +QryMainResourceDetailName.FieldName );
  end else if grpExtraOptions.ItemIndex =1  then begin
    GuiPrefs.DbGridElement[grdMain].AddFields(QryMainResourceName.FieldName +',' +QryMainResourceDetailName.FieldName , fiIndex );
    GuiPrefs.DbGridElement[grdMain].RemoveFields(QryMainEmployeeName.FieldName );
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[QryMainResourceName.FieldName] := 'Resource';
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[QryMainResourceDetailName.FieldName]:= 'Resource';
  end;
end;

procedure TBOMWorkOrdersSalesOrderGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainResourceId.fieldname);
    RemoveFieldfromGrid(qryMainResourceDetailId.fieldname);
end;

procedure TBOMWorkOrdersSalesOrderGUI.DogrdMainCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);
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

  inherited;
end;

procedure TBOMWorkOrdersSalesOrderGUI.FormCreate(Sender: TObject);
begin
  fiExtraOptionsIndex := -1;
  inherited;
end;

procedure TBOMWorkOrdersSalesOrderGUI.grpExtraOptionsClick(Sender: TObject);
begin
  if fiExtraOptionsIndex = grpExtraOptions.ItemIndex then Exit;
  if grpExtraOptions.ItemIndex =2  then begin
    grpFilters.ItemIndex :=  5;
  end else begin
    RefreshQuery;
  (*end else if grpExtraOptions.ItemIndex =0  then begin
    OpenERpListForm('TBOMWorkOrdersSalesOrderByEmployeeGUI', copyParamsto);
    CloseWait;
  end else if grpExtraOptions.ItemIndex =1  then begin
    OpenERpListForm('TBOMWorkOrdersSalesOrderByProcessGUI', copyParamsto);
    CloseWait;*)
  end;
  fiExtraOptionsIndex := grpExtraOptions.ItemIndex;
end;

function TBOMWorkOrdersSalesOrderGUI.TablenamePrefix: STring;
begin
  result := 'BOMWOSO';
end;

function TBOMWorkOrdersSalesOrderGUI.TotalsField(  const FieldName: String): Boolean;
begin
  Result := inherited TotalsField(Fieldname);
  if not result then result := sametext(fieldname , 'UnitofMeasureShipped') ;
end;

procedure TBOMWorkOrdersSalesOrderGUI.WriteGuiPrefExtra;
begin
  inherited;
  if grpExtraOptions.ItemIndex <> 2 then GuiPrefs.Node['Options.ExtraOptionsIndex'].asInteger := grpExtraOptions.ItemIndex;
end;

initialization
 RegisterClassOnce(TBOMWorkOrdersSalesOrderGUI);

end.
