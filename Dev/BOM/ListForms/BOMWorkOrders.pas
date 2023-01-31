unit BOMWorkOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  DNMAction , BOMWorkOrderBase, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBOMWorkOrdersGUI = class(TBOMWorkOrderBaseGUI)
    qryMainID: TIntegerField;
    qryMainClassID: TIntegerField;
    qryMainsaleDate: TDateTimeField;
    qryMainSaleID: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMainsaleLineId: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainProctreeID: TIntegerField;
    qryMainCaption: TWideStringField;
    qryMainSequencedown: TIntegerField;
    qryMainParentId: TIntegerField;
    qryMainLevel: TIntegerField;
    qryMainPartsId: TIntegerField;
    qryMainTree: TWideStringField;
    qryMainManufactureQty: TFloatField;
    qryMainFromStockQty: TFloatField;
    qryMainBOMOnOrderQty: TFloatField;
    qryMainTotalQty: TFloatField;
    qryMainInstock: TFloatField;
    qryMainAvailable: TFloatField;
    qryMainOnOrder: TFloatField;
    qryMainSOQty: TFloatField;
    qryMainReceived: TFloatField;
    qryMainBackorder: TFloatField;
    qryMainGoodsReceived: TIntegerField;
    qryMainStockAvailable: TIntegerField;
    qryMainSubBOMsDone: TIntegerField;
    qryMainProcessesDone: TIntegerField;
    qryMainProcessesScheduled: TIntegerField;
    qryMainOktoSchedule: TIntegerField;
    qryMainProcesspartID: TIntegerField;
    qryMainProcessStepId: TIntegerField;
    qryMainProcessStep: TWideStringField;
    qryMainDuration: TWideStringField;
    qryMainSetupDuration: TWideStringField;
    qryMainBreakdownDuration: TWideStringField;
    qryMainwDuration: TWideStringField;
    qryMainScheduledtime: TWideStringField;
    qryMainProcessStepSeq: TIntegerField;
    qryMainStatus: TWideStringField;
    qryMainPsStatus: TWideStringField;
    qryMainRecordDescription: TWideStringField;
    qryMainctr: TIntegerField;
    qryMainSaleIDnLinenum: TWideStringField;
    qryMainiDuration: TIntegerField;
    qryMainiSetupDuration: TIntegerField;
    qryMainiBreakdownDuration: TIntegerField;
    qryMainLineSeqno: TIntegerField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormActivate(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure btnOptionsClick(Sender: TObject);
  private
    function SubNodefield(const Fieldname: String): Boolean;
    procedure beforeshowList(Sender: TObject);
    procedure AfterShowList(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
    Procedure MakeTempTableSQL;Override;
    function IsSalesLinefield(const Fieldname: String): Boolean; Override;
    procedure DogrdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);Override;
    function Processfield(Fieldname:String):Boolean;
    Procedure OnMultiSelect(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean) ; virtual;

    function SnSlSeqNo1: String;
    function SnSlSeqNo2: String;
    function SnSlSeqNo3: String;

    function PTsqNo1: String;
    function PTsqNo2: String;
    function PTsqNo3: String;


    function PSsqNo1: String;
    function PSsqNo2: String;
    function PSsqNo3: String;

    function PPsqNo1: String;
    function PPsqNo2: String;
    function PPsqNo3: String;

    function PresSqNo1: String;
    function PresSqNo2: String;
    function PresSqNo3: String;

    function PresDetSqNo1: String;
    function PresDetSqNo2: String;
    function PresDetSqNo3: String;

    function EmpDetSqno1: String;
    function EmpDetSqno2: String;
    function EmpDetSqno3: String;

    function PrtDetSqno1: String;
    function PrtDetSqno2: String;
    function PrtDetSqno3: String;


  public
    Procedure RefreshQuery;Override;
    Procedure SetMainTablefields(const Processno :Integer);
  end;


implementation

uses CommonLib, CommonDbLib, LogLib, commonGuiLib, CommonFormLib, ProcessUtils,
  tcConst, frmAutoScheduleSelection;

{$R *.dfm}
{ TBOMWorkOrdersGUI }
function TBOMWorkOrdersGUI.SubNodefield(const Fieldname: String): Boolean;
begin
  result :=  Sametext(Fieldname ,Qrymaincaption.Fieldname) Or
             Sametext(Fieldname ,QrymainTree.Fieldname) Or
             Sametext(Fieldname ,QrymainTotalQty.Fieldname) Or
             Sametext(Fieldname ,QrymainManufactureQty.Fieldname) Or
             Sametext(Fieldname ,QrymainFromStockQty.Fieldname) Or
             Sametext(Fieldname ,QrymainBOMOnOrderQty.Fieldname) Or
             Sametext(Fieldname ,QrymainInstock.Fieldname) Or
             Sametext(Fieldname ,QrymainAvailable.Fieldname) Or
             Sametext(Fieldname ,QrymainOnOrder.Fieldname) Or
             Sametext(Fieldname ,QrymainSOQty.Fieldname) Or
             Sametext(Fieldname ,QrymainReceived.Fieldname) Or
             Sametext(Fieldname ,QrymainBackorder.Fieldname)(* Or
             Sametext(Fieldname ,QrymainOktoSchedule.Fieldname) Or
             Sametext(Fieldname ,QrymainGoodsReceived.Fieldname) Or
             Sametext(Fieldname ,QrymainStockAvailable.Fieldname) Or
             Sametext(Fieldname ,QrymainProcessStep.Fieldname) Or
             Sametext(Fieldname ,QrymainDuration.Fieldname) Or
             Sametext(Fieldname ,QrymainSetupDuration.Fieldname) Or
             Sametext(Fieldname ,QrymainBreakdownDuration.Fieldname) Or
             Sametext(Fieldname ,QrymainScheduledtime.Fieldname) Or
             Sametext(Fieldname ,QrymainStatus.Fieldname) *);
end;
procedure TBOMWorkOrdersGUI.FormActivate(Sender: TObject);
begin
  inherited;
  Self.WindowState := wsMaximized;
end;

procedure TBOMWorkOrdersGUI.FormCreate(Sender: TObject);
begin
  inherited;
  GrpfilterSupplied:= True; // as each form has a fixed filter and on filter selection, a differnt form si opened
  DisableSortoncolumtitleclick:= TRue;
  //Self.WindowState := wsMaximized;
  OnGidMultiselect := OnMultiSelect;
  GuiPrefs.AddFieldPair('Duration', 'wDuration', Qrymain);
end;

procedure TBOMWorkOrdersGUI.btnOptionsClick(Sender: TObject);
begin
  if TfmAutoScheduleSelection.ReadOptions(fbOktoScheduleWhenSubBOMsDone,
                                         fbOktoScheduleWhenGoodsReceived,
                                         fbOktoScheduleWhenProcessesnotScheduled,
                                         fbOktoScheduleWhenStockAvailable ) then begin

  end;
end;

procedure TBOMWorkOrdersGUI.DogrdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin

  if IsSalesLinefield(Field.FieldName) and
        (Qrymain.findfield('ProcessPartSeqno') <> nil) and
        (Qrymain.findfield('ProcTreeSeqno')<> nil) and
        ((Qrymain.fieldbyname('ProcTreeSeqno').asInteger <> 1) or (Qrymain.fieldbyname('ProcessPartSeqno').asInteger <> 1 )) then begin
        AFont.color := ABrush.color;
        fifieldhideNo:=6;
        Exit;
  end else if SubNodefield(Field.FieldName) and
              (Qrymain.findfield('ProcessPartSeqno') <> nil)  and
              (Qrymain.fieldbyname('ProcessPartSeqno').asInteger <> 1)  then begin
          AFont.color := ABrush.color;
          fifieldhideNo:=7;
          Exit;
  end else if sametext(field.fieldname , 'ResourceDetailName') and
              (Qrymain.findfield('ResourceProcTreeSeqno') <> nil) and
              (Qrymain.fieldbyname('ResourceProcTreeSeqno').asInteger <> 1 )  then begin
        AFont.color := ABrush.color;
        fifieldhideNo:=8;
        Exit;
  end;
  inherited;

  if not(Sametext(qryMainPsStatus.asString , PS_NOTSCHEDULED) ) then begin
      if ((Field is TIntegerfield) or (Field is TLargeintField)) and (Field.asInteger =0) then begin
      end else if (Field is TFloatField) and (Field.asfloat =0) then begin
      end else if fifieldhideNo =0 then begin
        AFont.color := clGray;
        fifieldhideNo:=10;
      end;
  end;
end;

procedure TBOMWorkOrdersGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  (*if fifieldhideNo <>0 then
    Logtext(inttostr(Qrymainid.asInteger)+'->'+ Field.fieldname +':' +inttostr(fifieldhideNo));*)
end;

procedure TBOMWorkOrdersGUI.grdMainTitleButtonClick(Sender: TObject;AFieldName: string);
begin
(*  if Sametext(AFieldName , QrymainDuration.FieldName) then
    guiprefs.DbGridElement[grdMain].SwitchFields(QrymainwDuration.FieldName , QrymainDuration.FieldName)
  else if Sametext(AFieldName , QrymainwDuration.FieldName) then
    guiprefs.DbGridElement[grdMain].SwitchFields(QrymainDuration.FieldName , QrymainwDuration.FieldName);*)

  inherited;

end;

procedure TBOMWorkOrdersGUI.grpFiltersClick(Sender: TObject);
var
  s:String;
begin
  if not IsFormshown then exit;
  s:= '';
       if Grpfilters.itemindex =0 then s :='TBOMWorkOrdersSummaryGUI'
  else if Grpfilters.itemindex =1 then s :='TBOMWorkOrdersEmployeesGUI'
  else if Grpfilters.itemindex =2 then s :='TBOMWorkOrdersProcessGUI'
  else if Grpfilters.itemindex =3 then s :='TBOMWorkOrdersProductGUI'
  else if Grpfilters.itemindex =4 then s :='TBOMWorkOrdersSalesOrderGUI'
  else if Grpfilters.itemindex =5 then s :='TBOMWorkOrdersExtraDetailsGUI'
  else exit;

  if Sametext(Self.ClassName , s) then exit;
  OpenERpListForm(s, beforeshowList , AfterShowList);
  CloseWait;
end;
procedure TBOMWorkOrdersGUI.AfterShowList(Sender: TObject);
begin
  if Sender is TBOMWorkOrdersGUI then
    TBOMWorkOrdersGUI(Sender).WindowState := wsMaximized;
end;

procedure TBOMWorkOrdersGUI.beforeshowList(Sender: TObject);
begin
  copyParamsto(Sender);
end;
function TBOMWorkOrdersGUI.IsSalesLinefield(const Fieldname: String): Boolean;
begin
  result := inherited IsSalesLinefield(Fieldname);
end;

procedure TBOMWorkOrdersGUI.MakeTempTableSQL;
begin
  inherited;
(*var
  i1,i2 :Integer;

  function TableNames(Const Details:Boolean):String;
  begin
    REsult :=  Tablename +' as T';
    if Details then
      REsult :=
            REsult + ' inner join tblprocessstep PS on PS.ID =  T.ProcessStepId'     + Trim(IntToStr(i1))+
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
    SQL.Add('Create table  '+Tablename +'1 ');

      for i1 := 1 to fiProcesses do begin
        for i2 := 1 to 2 do begin
            if (i1<>1) or (i2<>1)  then SQL.Add('union all');

            SQL.add( 'Select ');
            SQL.add( 'T.ID 	                  as	 ID,');
            SQL.add( 'T.ClassID	              as	  ClassID,');
            SQL.add( 'T.saleDate	            as	  saleDate,');
            SQL.add( 'T.SaleID 	              as	  SaleID ,');
            SQL.add( 'T.customername	        as	  customername,');
            SQL.add( 'T.saleLineId  	        as	  saleLineId  ,');
            SQL.add( 'T.productname 	        as	 productname ,');
            SQL.add( 'T.UnitofMeasureShipped 	as	 UnitofMeasureShipped ,');
            SQL.add( 'T.UOM                  	as	 UOM                  ,');
            SQL.add( 'T.ProctreeID           	as	 ProctreeID           ,');
            SQL.add( 'T.Caption              	as	 Caption              ,');
            SQL.add( 'T.Sequencedown         	as	 Sequencedown         ,');
            SQL.add( 'T.ParentId             	as	 ParentId             ,');
            SQL.add( 'T.Level                	as	 Level                ,');
            SQL.add( 'T.PartsId              	as	 PartsId              ,');
            SQL.add( 'T.Tree                 	as	 Tree                 ,');
            SQL.add( 'T.ManufactureQty       	as	 ManufactureQty       ,');
            SQL.add( 'T.FromStockQty         	as	 FromStockQty         ,');
            SQL.add( 'T.BOMOnOrderQty        	as	 BOMOnOrderQty        ,');
            SQL.add( 'T.TotalQty             	as	 TotalQty             ,');
            SQL.add( 'T.Instock        	      as	 Instock        ,');
            SQL.add( 'T.Available      	      as	 Available      ,');
            SQL.add( 'T.OnOrder        	      as	 OnOrder        ,');
            SQL.add( 'T.SOQty          	      as	 SOQty          ,');
            SQL.add( 'T.Received       	      as	 Received       ,');
            SQL.add( 'T.Backorder      	      as	 Backorder      ,');
            SQL.add( 'T.GoodsReceived  	      as	 GoodsReceived  ,');
            SQL.add( 'T.StockAvailable 	      as	 StockAvailable ,');
            SQL.add( 'T.SubBOMsDone    	      as	 SubBOMsDone    ,');
            SQL.add( 'T.ProcessesDone  	      as	 ProcessesDone  ,');
            SQL.add( 'T.ProcessesScheduled    as	 ProcessesScheduled    ,');
            SQL.add( 'T.OktoSchedule   	      as	 OktoSchedule   ,');
            SQL.add( 'T.ProcesspartID'     + Trim(IntToStr(i1))+' as ProcesspartID,');
            SQL.add( 'T.ProcessStepId'     + Trim(IntToStr(i1))+' as ProcessStepId,');
            SQL.add( 'T.ProcessStep'       + Trim(IntToStr(i1))+' as ProcessStep,');
            SQL.add( 'T.Duration'          + Trim(IntToStr(i1))+' as Duration,');
            SQL.add( 'T.SetupDuration'     + Trim(IntToStr(i1))+' as SetupDuration,');
            SQL.add( 'T.BreakdownDuration' + Trim(IntToStr(i1))+' as BreakdownDuration,');
            SQL.add( 'T.Scheduledtime'     + Trim(IntToStr(i1))+' as Scheduledtime,');
            SQL.add( 'T.ProcessStepSeq'    + Trim(IntToStr(i1))+' as ProcessStepSeq,');
            SQL.add( 'T.Status'            + Trim(IntToStr(i1))+' as Status,');
            SQL.add( 'T.RecordDescription     as RecordDescription,  ');
            if i2 =1 then begin
                SQL.add( 'Null as ResourceId,  ');
                SQL.add( 'Null as ResourceDetailId,  ');
                SQL.add( 'Null as ResourceName,  ');
                SQL.add( 'Null as ResourceDetailName,  ');
                SQL.add( 'Null as EmployeeName,');
            end else begin
                SQL.add( 'PR.ProcResourceId as ResourceId,');
                SQL.add( 'PRD.ID ResourceDetailId,');
                SQL.add( 'PR.ResourceName as ResourceName,');
                SQL.add( 'PRD.Description ResourceDetailName,');
                SQL.add( 'E.EmployeeName,');
            end;
            SQL.add( inttostr(i1)+'           as	  ctr,');
            SQL.add( inttostr(i2)+'           as	  Details,');
            SQL.add( 'T.ProcTreeSeqno	              as	  ProcTreeSeqno');

            SQL.add( 'from ' +Tablenames((i2=2)) );
            SQL.add( 'where ifnull( T.ProcesspartID'     + Trim(IntToStr(i1))+' ,0)<>0');
        end;
      end;
      SQL.add( ' order by saleDate desc, saleLineId , level , SequenceDown, ProcessStepSeq,Details , ResourceName,ResourceDetailName, EmployeeName;');
  end;*)
end;
procedure TBOMWorkOrdersGUI.OnMultiSelect(Grid: TwwDBGrid; Selecting: Boolean;var Accept: Boolean);
begin
  if TotalsLine then Accept := False;
end;

function TBOMWorkOrdersGUI.Processfield(Fieldname: String): Boolean;
begin
  result := Sametext(Fieldname, QrymainProcessStep.fieldname) or
            Sametext(Fieldname, QrymainDuration.fieldname) or
            Sametext(Fieldname, QrymainSetupDuration.fieldname) or
            Sametext(Fieldname, QrymainBreakdownDuration.fieldname) or
            Sametext(Fieldname, QrymainwDuration.fieldname) or
            Sametext(Fieldname, QrymainScheduledtime.fieldname) or
            Sametext(Fieldname, QrymainStatus.fieldname);
end;

procedure TBOMWorkOrdersGUI.RefreshQuery;
begin
  clog('');
  try
    try
      CreateTempTable;
      inherited;
    Except
      on E:Exception do begin
        MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
      //logtext(ScriptMain.SQL.Text);
      logtext(Qrymain.SQL.Text);
  end;
end;

procedure TBOMWorkOrdersGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainiDuration.FieldName);
    RemoveFieldfromGrid(qryMainiSetupDuration.FieldName);
    RemoveFieldfromGrid(qryMainiBreakdownDuration.FieldName);
    RemoveFieldfromGrid(QrymainClassID.FieldName);
    RemoveFieldfromGrid(QrymainsaleLineId.FieldName);
    RemoveFieldfromGrid(QrymainProctreeID.FieldName);
    RemoveFieldfromGrid(QrymainSequencedown.FieldName);
    RemoveFieldfromGrid(QrymainParentId.FieldName);
    RemoveFieldfromGrid(QrymainLevel.FieldName);
    RemoveFieldfromGrid(QrymainPartsId.FieldName);
    RemoveFieldfromGrid(QrymainProcesspartID.FieldName);
    RemoveFieldfromGrid(QrymainProcessStepId.FieldName);
    RemoveFieldfromGrid(Qrymainctr.FieldName);
    RemoveFieldfromGrid(qryMainProcessesDone.FieldName);
    RemoveFieldfromGrid(qryMainProcessesScheduled.FieldName);
    RemoveFieldfromGrid(qryMainProcessStepSeq.FieldName);
    RemoveFieldfromGrid(qryMainPsStatus.FieldName);
    RemoveFieldfromGrid('LineSeqno');
    RemoveFieldfromGrid('ProcTreeSeqno');
    RemoveFieldfromGrid('ProcessPartSeqno');
    RemoveFieldfromGrid('ProcessStepResNum');
    RemoveFieldfromGrid('ProcessPartResNum');
    RemoveFieldfromGrid('ProcResDetSeqno');
    RemoveFieldfromGrid('ProcResDetEmpSeqno');
    RemoveFieldfromGrid('EmployeeDetailSeqno');
    RemoveFieldfromGrid('PartsDetailSeqno');

    if not devmode then begin
      RemoveFieldfromGrid(QrymainID.FieldName);
      RemoveFieldfromGrid(qryMainRecordDescription.FieldName);
    end;
end;
procedure TBOMWorkOrdersGUI.SetMainTablefields(const Processno: Integer);
begin
  With ScriptMain do begin
            SQL.add( 'Select ');
            SQL.add( 'T.ID 	                  as	 ID,');
            SQL.add( 'T.LineSeqno 	          as	 LineSeqno,');
            SQL.add( 'T.SaleIDnLinenum 	      as	 SaleIDnLinenum,');
            SQL.add( inttostr(Processno)+'    as	  ctr,');
            SQL.add( 'T.ClassID	              as	  ClassID,');
            SQL.add( 'T.saleDate	            as	  saleDate,');
            SQL.add( 'T.SaleID 	              as	  SaleID ,');
            SQL.add( 'T.customername	        as	  customername,');
            SQL.add( 'T.saleLineId  	        as	  saleLineId  ,');
            SQL.add( 'T.productname 	        as	 productname ,');
            SQL.add( 'T.UnitofMeasureShipped 	as	 UnitofMeasureShipped ,');
            SQL.add( 'T.UOM                  	as	 UOM                  ,');
            SQL.add( 'T.ProctreeID           	as	 ProctreeID           ,');
            SQL.add( 'T.Caption              	as	 Caption              ,');
            SQL.add( 'T.Sequencedown         	as	 Sequencedown         ,');
            SQL.add( 'T.ParentId             	as	 ParentId             ,');
            SQL.add( 'T.Level                	as	 Level                ,');
            SQL.add( 'T.PartsId              	as	 PartsId              ,');
            SQL.add( 'T.Tree                 	as	 Tree                 ,');
            SQL.add( 'T.ManufactureQty       	as	 ManufactureQty       ,');
            SQL.add( 'T.FromStockQty         	as	 FromStockQty         ,');
            SQL.add( 'T.BOMOnOrderQty        	as	 BOMOnOrderQty        ,');
            SQL.add( 'T.TotalQty             	as	 TotalQty             ,');
            SQL.add( 'T.Instock        	      as	 Instock        ,');
            SQL.add( 'T.Available      	      as	 Available      ,');
            SQL.add( 'T.OnOrder        	      as	 OnOrder        ,');
            SQL.add( 'T.SOQty          	      as	 SOQty          ,');
            SQL.add( 'T.Received       	      as	 Received       ,');
            SQL.add( 'T.Backorder      	      as	 Backorder      ,');
            SQL.add( 'T.GoodsReceived  	      as	 GoodsReceived  ,');
            SQL.add( 'T.StockAvailable 	      as	 StockAvailable ,');
            SQL.add( 'T.SubBOMsDone    	      as	 SubBOMsDone    ,');
            SQL.add( 'T.ProcessesDone  	      as	 ProcessesDone  ,');
            SQL.add( 'T.ProcessesScheduled    as	 ProcessesScheduled    ,');
            SQL.add( 'T.OktoSchedule   	      as	 OktoSchedule   ,');
            SQL.add( 'T.ProcesspartID'     + Trim(IntToStr(Processno))+' as ProcesspartID,');
            SQL.add( 'T.ProcessStepId'     + Trim(IntToStr(Processno))+' as ProcessStepId,');
            SQL.add( 'T.ProcessStep'       + Trim(IntToStr(Processno))+' as ProcessStep,');
            SQL.add( 'T.Duration'          + Trim(IntToStr(Processno))+' as Duration,');
            SQL.add( 'T.SetupDuration'     + Trim(IntToStr(Processno))+' as SetupDuration,');
            SQL.add( 'T.BreakdownDuration' + Trim(IntToStr(Processno))+' as BreakdownDuration,');
            SQL.add( 'T.wDuration'         + Trim(IntToStr(Processno))+' as wDuration,');
            SQL.add( 'T.iDuration'         + Trim(IntToStr(Processno))+' as iDuration,');
            SQL.add( 'T.iSetupDuration'    + Trim(IntToStr(Processno))+' as iSetupDuration,');
            SQL.add( 'T.iBreakdownDuration'+ Trim(IntToStr(Processno))+' as iBreakdownDuration,');
            SQL.add( 'T.Scheduledtime'     + Trim(IntToStr(Processno))+' as Scheduledtime,');
            SQL.add( 'T.ProcessStepSeq'    + Trim(IntToStr(Processno))+' as ProcessStepSeq,');
            SQL.add( 'T.Status'            + Trim(IntToStr(Processno))+' as Status,');
            SQL.add( 'T.psStatus'          + Trim(IntToStr(Processno))+' as psStatus,');
            SQL.add( 'T.RecordDescription     as RecordDescription  ');

  end;
end;
{LineSeqno        : Lines of Sale
ProcTreeSeqno     : Proctree of lines
ProcessPartSeqno  : Process PArt of Proctree
ProcessStepResNum : Resources of Process step
ProcessPartResNum : Resources of ProcessPart
ProcResDetSeqno   : REsource DEtails within Resource
EmployeeDetailSeqno : Details under employee
PartsDetailSeqno    : Details under Part
}
(*Function TBOMWorkOrdersGUI.SnSlSeqNo1:String;begin       Result := 'Convert(@LineSeqno          :=if(@SaleId          <> T.SaleID     ,  @LineSeqno             := 1 , if(@saleLineid     = T.SalelineID , @LineSeqno       , @LineSeqno      +1)), Signed) LineSeqno, ' + NL+
                                                                   'Convert(@ProcTreeSeqno      :=if(@saleLineid      <> T.SalelineID ,  @ProcTreeSeqno         := 1 , if(@ProctreeID     = T.ProctreeId , @ProcTreeSeqno   , @ProcTreeSeqno  +1)), Signed) ProcTreeSeqno ,'+NL+
                                                                   'Convert(concat(T.SaleID,"-" , @LineSeqno), char(100)) as SaleIDnLinenum,';end;*)
Function TBOMWorkOrdersGUI.SnSlSeqNo1:String;begin       Result := 'Convert(@ProcTreeSeqno      :=if(@saleLineid      <> ifnull(T.SalelineID      ,0 ),@ProcTreeSeqno         := 1 , if(@ProctreeID     = ifnull(T.ProctreeId,0) , @ProcTreeSeqno   , @ProcTreeSeqno  +1)), Signed) ProcTreeSeqno ,';end;
Function TBOMWorkOrdersGUI.PTsqNo1  :String;begin        Result := 'Convert(@ProcessPartSeqno   :=if(@ProctreeID      <> ifnull(T.ProctreeId      ,0 ),@ProcessPartSeqno      := 1 ,  @ProcessPartSeqno      +1), Signed) ProcessPartSeqno      ,';end;
Function TBOMWorkOrdersGUI.PSsqNo1  :String;begin        Result := 'convert(@ProcessStepResNum  :=if(@ProcessStepId   <> ifnull(T.ProcessStepID   ,0 ),@ProcessStepResNum     := 1 ,  @ProcessStepResNum     +1), SIGNED ) ProcessStepResNum    ,';end;
Function TBOMWorkOrdersGUI.PPsqNo1  :String;begin        Result := 'convert(@ProcessPartResNum  :=if(@ProcessPartID   <> ifnull(T.ProcessPartID   ,0 ),@ProcessPartResNum     := 1 ,  @ProcessPartResNum     +1), SIGNED ) ProcessPartResNum    ,';end;
Function TBOMWorkOrdersGUI.PresSqNo1:String;begin        Result := 'convert(@ProcResDetSeqno    :=if(@ResourceId      <> ifnull(T.ResourceId      ,0 ),@ProcResDetSeqno       := 1 ,  @ProcResDetSeqno       +1), SIGNED ) ProcResDetSeqno      ,';end;
Function TBOMWorkOrdersGUI.PresDetSqNo1:String;begin     Result := 'convert(@ProcResDetEmpSeqno :=if(@ResourceDetailId<> ifnull(T.ResourceDetailId,0 ),@ProcResDetEmpSeqno    := 1 ,  @ProcResDetEmpSeqno    +1), SIGNED ) ProcResDetEmpSeqno   ,';end;
Function TBOMWorkOrdersGUI.EmpDetSqno1 :String;begin     Result := 'convert(@EmployeeDetailSeqno:=if(@EmployeeName    <> ifnull(T.EmployeeName    ,""),@EmployeeDetailSeqno   := 1 ,  @EmployeeDetailSeqno   +1), SIGNED ) EmployeeDetailSeqno  ,';end;
Function TBOMWorkOrdersGUI.PrtDetSqno1 :String;begin     Result := 'convert(@PartsDetailSeqno   :=if(@PartsID         <> ifnull(T.PartsID         ,0 ),@PartsDetailSeqno      := 1 ,  @PartsDetailSeqno      +1), SIGNED ) PartsDetailSeqno     ,';end;

Function TBOMWorkOrdersGUI.SnSlSeqNo2   :String;begin	REsult := '@saleLineid      := ifnull(T.SalelineID      ,0 ), ';end;
Function TBOMWorkOrdersGUI.PTsqNo2      :String;begin	REsult := '@ProctreeID      := ifnull(T.ProctreeID      ,0 ), ';end;
Function TBOMWorkOrdersGUI.PSsqNo2      :String;begin	REsult := '@ProcessStepId   := ifnull(T.ProcessStepId   ,0 ), ';end;
Function TBOMWorkOrdersGUI.PPsqNo2      :String;begin	REsult := '@ProcessPartID   := ifnull(T.ProcessPartID   ,0 ), ';end;
Function TBOMWorkOrdersGUI.PresSqNo2    :String;begin	REsult := '@ResourceId      := ifnull(T.ResourceId      ,0 ), ';end;
Function TBOMWorkOrdersGUI.PresDetSqNo2 :String;begin	REsult := '@ResourceDetailId:= ifnull(T.ResourceDetailId,0 ), ';end;
Function TBOMWorkOrdersGUI.EmpDetSqno2 :String;begin	REsult := '@EmployeeName    := ifnull(T.EmployeeName    ,""), ';end;
Function TBOMWorkOrdersGUI.PrtDetSqno2 :String;begin	REsult := '@PartsID         := ifnull(T.PartsID         ,0 ), ';end;

Function TBOMWorkOrdersGUI.SnSlSeqNo3   :String;begin	Result := '(SELECT @saleLineid      := 0 ) b,  ';end;
Function TBOMWorkOrdersGUI.PTsqNo3      :String;begin	Result := '(SELECT @ProctreeID      := 0 ) c,  ';end;
Function TBOMWorkOrdersGUI.PSsqNo3      :String;begin	Result := '(SELECT @ProcessStepId   := 0 ) d,  ';end;
Function TBOMWorkOrdersGUI.PPsqNo3      :String;begin	Result := '(SELECT @ProcessPartID   := 0 ) e,  ';end;
Function TBOMWorkOrdersGUI.PresSqNo3    :String;begin	Result := '(SELECT @ResourceId      := 0 ) f,  ';end;
Function TBOMWorkOrdersGUI.PresDetSqNo3 :String;begin	Result := '(SELECT @ResourceDetailId:= 0 ) g,  ';end;
Function TBOMWorkOrdersGUI.EmpDetSqno3 :String;begin	Result := '(SELECT @EmployeeName    := "") h,  ';end;
Function TBOMWorkOrdersGUI.PrtDetSqno3 :String;begin	Result := '(SELECT @PartsID         := 0 ) i,  ';end;

end.


