unit BOMWorkOrderBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBOMWorkOrderBaseGUI = class(TBaseListingGUI)
    btnOptions: TDNMSpeedButton;
    procedure btnOptionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
  Protected
    Tablename :String;
    fiProcesses:Integer;
    fiAllProcesses:Integer;
    fiBomLevels:Integer;

    fbOktoScheduleWhenSubBOMsDone :boolean;
    fbOktoScheduleWhenGoodsReceived:boolean;
    fbOktoScheduleWhenProcessesnotScheduled:boolean;
    fbOktoScheduleWhenStockAvailable:boolean;
    fbEnableSingleclickSelection:boolean;

    fifieldhideNo:Integer;

    function TablenamePrefix :STring;Virtual;
    procedure CreateTempTable;
    Procedure MakeTempTableSQL;Virtual;
    function CreateTableSQL: String;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Procedure MakeQrymain;Virtual;
    function IsSalesLinefield(const Fieldname: String): Boolean; virtual;
    function IsSalesfield(const Fieldname: String): Boolean; virtual;
    function  Gridcolors(aField: Tfield; AfieldName: String; AFont: Tfont;ABrush: TBrush; IsTitle: Boolean):Boolean;Virtual;
    procedure DogrdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);Virtual;
    function ReportCategoryChanged:Boolean;Virtual;
    function TotalsLine:boolean; Virtual;
    function BlankLineTotalsLine:boolean; Virtual;
    Function TotalsField(const FieldName:String):Boolean;virtual;
    function GroupField(const FieldName:String):Boolean;virtual;
    function Samesalesrec:Boolean;Virtual;
    function SameSalesLineRec:Boolean; virtual;

  public
    Constructor Create(AOwner:TComponent);Override;
  end;

implementation

uses tcDataUtils, CommonDbLib, ProcessUtils, MySQLConst, CommonLib,
  ProductQtyLib, PQALib, ManufactureLib,
  frmBOMSchedulewhenReadytoScheduleOptions, LogLib, tcConst;

{$R *.dfm}

{ TBOMWorkOrderBaseGUI }
function TBOMWorkOrderBaseGUI.IsSalesfield(const Fieldname: String): Boolean;
begin
  result :=  Sametext(Fieldname ,'SaleID') or
             Sametext(Fieldname ,'SaleDate') or
             Sametext(Fieldname ,'customername') ;

end;

function TBOMWorkOrderBaseGUI.IsSalesLinefield(const Fieldname: String): Boolean;
begin
  result :=  Sametext(Fieldname ,'productname') or
             Sametext(Fieldname ,'UnitofMeasureShipped') or
             Sametext(Fieldname ,'SaleIDnLinenum') or
             Sametext(Fieldname ,'UOM');
end;

function TBOMWorkOrderBaseGUI.BlankLineTotalsLine: boolean;
begin
  REsult := False;
  if Qrymain.findfield('Seqno') <> nil then
    Result := qryMain.findfield('Seqno').asInteger =3;
end;

procedure TBOMWorkOrderBaseGUI.btnOptionsClick(Sender: TObject);
begin
  inherited;
  if TfmBOMSchedulewhenReadytoScheduleOptions.ReadOptions(fbOktoScheduleWhenSubBOMsDone,
                                         fbOktoScheduleWhenGoodsReceived,
                                         fbOktoScheduleWhenProcessesnotScheduled,
                                         fbOktoScheduleWhenStockAvailable) then RefreshQuery;

end;

constructor TBOMWorkOrderBaseGUI.Create(AOwner: TComponent);
begin
  inherited;
  fiAllProcesses := 0;
  fiProcesses := BOMProcesses;
  if fiProcesses > 65 then begin
    fiAllProcesses :=fiProcesses;
    fiProcesses := 65;
  end;
  fiBomLevels := BOMTreeLevels;
  Tablename := CommonDbLib.GetUserTemporaryTableName(TablenamePrefix);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select');
  Qrymain.SQL.Add('T.*');
  Qrymain.SQL.Add('from');
  Qrymain.SQL.Add(Tablename +' as T');
end;

function TBOMWorkOrderBaseGUI.TablenamePrefix: STring;
begin
  REsult := '';
end;

procedure TBOMWorkOrderBaseGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.OktoScheduleWhenSubBOMsDone'].asBoolean := fbOktoScheduleWhenSubBOMsDone;
  GuiPrefs.Node['Options.OktoScheduleWhenGoodsReceived'].asBoolean := fbOktoScheduleWhenGoodsReceived;
  GuiPrefs.Node['Options.OktoScheduleWhenProcessesnotScheduled'].asBoolean := fbOktoScheduleWhenProcessesnotScheduled;
  GuiPrefs.Node['Options.OktoScheduleWhenStockAvailable'].asBoolean := fbOktoScheduleWhenStockAvailable;

end;

function TBOMWorkOrderBaseGUI.CreateTableSQL:String;
var
  ctr:Integer;
begin
    REsult := 'Drop table if exists ' + Tablename +NL+';';
    REsult := REsult +' CREATE TABLE ' + Tablename +'(';
    REsult := REsult +' ID                   int(11) NOT NULL AUTO_INCREMENT,';
    REsult := REsult +' LineSeqno             int(11) DEFAULT 0,';
    //REsult := REsult +' ProcTreeSeqno         int(11) DEFAULT 0,';
    REsult := REsult +' ClassID              int(11) DEFAULT 0,';
    REsult := REsult +' SaleID               int(11) DEFAULT 0,';
    REsult := REsult +' SaleIDnLinenum       varchar(55)  DEFAULT "",';
    REsult := REsult +' saleDate             Datetime,';
    REsult := REsult +' customername         varchar(255)  DEFAULT "",';
    REsult := REsult +' saleLineId           int(11) NOT NULL DEFAULT 0 ,';
    REsult := REsult +' productname          varchar(60)  DEFAULT "",';
    REsult := REsult +' UnitofMeasureShipped double NOT NULL DEFAULT 0 ,';
    REsult := REsult +' UOM                  varchar(100)  DEFAULT "",';
    REsult := REsult +' ProctreeID           int(11) NOT NULL DEFAULT 0 ,';
    REsult := REsult +' Caption              varchar(255)  DEFAULT "",';
    REsult := REsult +' Sequencedown         int(11) DEFAULT 0,';
    REsult := REsult +' ParentId             int(11) DEFAULT 0,';
    REsult := REsult +' Level                int(11) DEFAULT 0,';
    REsult := REsult +' PartsId              int(11) DEFAULT 0,';
    REsult := REsult +' Tree                 varchar(255),';
    REsult := REsult +' ManufactureQty       double  DEFAULT 0,';
    REsult := REsult +' FromStockQty         double  DEFAULT 0,';
    REsult := REsult +' BOMOnOrderQty           double  DEFAULT 0,';
    REsult := REsult +' TotalQty             double NOT NULL DEFAULT 0 ,';
    REsult := REsult +' Instock        double  DEFAULT 0,';
    REsult := REsult +' Available      double  DEFAULT 0,';
    REsult := REsult +' OnOrder        double  DEFAULT 0,';
    REsult := REsult +' SOQty          double  DEFAULT 0,';
    REsult := REsult +' Received       double  DEFAULT 0,';
    REsult := REsult +' Backorder      double  DEFAULT 0,';
    REsult := REsult +' GoodsReceived  int(11) default 0,';
    REsult := REsult +' StockAvailable int(11) default 0,';
    REsult := REsult +' SubBOMsDone    int(11) default 0,';
    REsult := REsult +' ProcessesDone    int(11) default 0,';
    REsult := REsult +' ProcessesScheduled    int(11) default 0,';
    REsult := REsult +' OktoSchedule   int(11) default 0,'+NL;

    for ctr := 1 to fiProcesses do begin
      REsult := REsult +' ProcesspartID'     + Trim(IntToStr(ctr))+' int(11) DEFAULT 0,';
      REsult := REsult +' ProcessStepId'     + Trim(IntToStr(ctr))+' int(11) DEFAULT 0,';
      REsult := REsult +' ProcessStep'       + Trim(IntToStr(ctr))+' varchar(50)  DEFAULT "",';
      REsult := REsult +' Duration'          + Trim(IntToStr(ctr))+' Varchar(40)  DEFAULT "",';
      REsult := REsult +' SetupDuration'     + Trim(IntToStr(ctr))+' varchar(40)  DEFAULT "",';
      REsult := REsult +' BreakdownDuration' + Trim(IntToStr(ctr))+' varchar(40)  DEFAULT "",';
      REsult := REsult +' wDuration'         + Trim(IntToStr(ctr))+' Varchar(40)  DEFAULT "",';
      REsult := REsult +' iDuration'         + Trim(IntToStr(ctr))+' int(11)  DEFAULT 0,';
      REsult := REsult +' iSetupDuration'    + Trim(IntToStr(ctr))+' int(11)  DEFAULT 0,';
      REsult := REsult +' iBreakdownDuration'+ Trim(IntToStr(ctr))+' int(11)  DEFAULT 0,';
      REsult := REsult +' Scheduledtime'     + Trim(IntToStr(ctr))+' varchar(40)  DEFAULT "",';
      REsult := REsult +' ProcessStepSeq'    + Trim(IntToStr(ctr))+' int(11) DEFAULT 0,';
      REsult := REsult +' Status'            + Trim(IntToStr(ctr))+' varchar(20)  DEFAULT "",';
      REsult := REsult +' psStatus'          + Trim(IntToStr(ctr))+' varchar(20)  DEFAULT "",'+NL;
    end;
    REsult := REsult +' RecordDescription   varChar(255),';
    REsult := REsult +' PRIMARY KEY (ID),';
    REsult := REsult +' KEY ProctreeID (ProctreeID),';
    REsult := REsult +' KEY PartsId (PartsId),';
    REsult := REsult +' KEY ClassId (ClassID)';
    REsult := REsult +' ) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;';
end;

procedure TBOMWorkOrderBaseGUI.CreateTempTable;
begin
  With scriptmain do begin
    SQL.Clear;
    SQL.add(CreateTableSQL);
    Execute;
    SQL.clear;
    MakeTempTableSQL;

    clog(SQL.Text);
    logtext(Qrymain.sQL.text);
    doshowProgressbar(SQL.count , WaitMSg);
    try
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;


end;
Procedure  TBOMWorkOrderBaseGUI.MakeTempTableSQL;
var
  ctr :Integer;
  s:String;

  function ThisProcessesDoneSQL(tablealias :String ='T') :String;
  var
    i:Integer;
  begin
    REsult := '';
    for i:= 1 to fiProcesses do begin
      if result <> '' then result := result +','   ;
      REsult := result +'if(' + tablealias +'.ProcesspartID'+Trim(Inttostr(i))+'=0,  2,'+
                         'if(' + tablealias +'.psstatus'+Trim(Inttostr(i))+'='+Quotedstr(PS_STR_COMPLETE)+' or ' +
                                 tablealias +'.psStatus'+Trim(Inttostr(i))+'='+Quotedstr(PS_STR_COMPLETENINVOICE) +',2,1))';
    end;
    if fiProcesses >1 then REsult := 'Least('+Result +')';
  end;

  function ThisProcessesScheduledSQL(tablealias :String ='T') :String;
  var
    i:Integer;
  begin
    REsult := '';
    for i:= 1 to fiProcesses do begin
      if result <> '' then result := result +','   ;
      REsult := result +'if(' + tablealias +'.ProcesspartID'+Trim(Inttostr(i))+'=0,  2,'+
                         'if(' + tablealias +'.psstatus'+Trim(Inttostr(i))+'='+Quotedstr(PS_STR_NOTSCHEDULED)+' or ' +
                                 tablealias +'.psStatus'+Trim(Inttostr(i))+'='+Quotedstr(PS_STR_STOPPED) +' or ' +
                                 tablealias +'.psStatus'+Trim(Inttostr(i))+'='+Quotedstr(PS_STR_UNKNOWN)+',1,2))';
    end;
    if fiProcesses >1 then REsult := 'Least('+Result +')';
  end;

  Function Processes(tablealias :String ='T') :String;
  var
    i:Integer;
  begin
    REsult := '';
    for i:= 1 to fiProcesses do begin
      if result <> '' then result := result +','   ;
      REsult := result +'if(' + tablealias +'.ProcesspartID'+Trim(Inttostr(i))+'=0,  "",'+
                          'concat( ' + tablealias +'.ProcessStep'+Trim(Inttostr(i))+',":",ProcessPartStatusToUserStr(' + tablealias +'.psstatus'+Trim(Inttostr(i))+')))';
    end;
    if fiProcesses >1 then REsult := 'concat_WS("\n", '+Result +')';
  end;
  function ProcessStepSeqFilter:String;
  var
    i:Integer;
  begin
    REsult := '';
    if ctr = 1 then exit;
    for i := 1 to ctr-1 do begin
      result := result +  ' and PP.ProcessStepSeq > T.ProcessStepSeq'+trim(inttostr(i));
    end;

  end;

begin

  inherited;
  With ScriptMain do begin
    SQL.Clear;
    SQL.Add('/*1*/    insert into '+tablename +' (/*ProcTreeSeqno , */LineSeqno , saleDate, ClassID,customername,SaleID ,saleLineId,productname,UnitofMeasureShipped,UOM ,ProctreeID,Caption,Sequencedown,ParentId, Level, PartsId,Tree,ManufactureQty,FromStockQty,BOMOnOrderQty,TotalQty) ' +
                   ' Select ' +
                   ' /*@ProcTreeSeqno:=if(@saleLineid <> Sl.SalelineID,  @ProcTreeSeqno:= 1 ,  @ProcTreeSeqno+1) ProcTreeSeqno , */'+
                   ' @LineSeqno:=if(@SaleId <> S.SaleID,  @LineSeqno:= 1 , if(@saleLineid = Sl.SalelineID , @LineSeqno ,  @LineSeqno+1)) LineSeqno , '+
                   ' S.saleDate , ' +
                   ' S.ClassID,'+
                   ' S.customername,'+
                   ' @SaleId := S.SaleId,'+
                   ' @SalelineId := sl.SalelineID,'+
                   ' SL.productname, SL.UnitofMeasureShipped, concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier  , ")") as UOM , ' +
                   ' PT.ProctreeID,'+
                   ' PT.Caption, PT.Sequencedown ,PT.ParentId , PT.Level,  ' +
                   ' PT.PartsId, '+
                   ' Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)) Tree , ' +
                   ' PT.ManufactureQty, ' +
                   ' PT.FromStockQty, ' +
                   ' PT.OnOrderQty, ' +
                   ' PT.TotalQty ' +
                   ' from (SELECT @saleLineid:=0) a, ' +
                   ' (SELECT @SaleId:=0) b, ' +
                   ' tblsales S inner join  tblSaleslines SL on S.saleId = SL.saleID ' +
                   ' inner join tblproctree PT on Sl.saleLineId = PT.MasterId and PT.MasterType <> "mtProduct" ' +
                   ' where S.IsSalesOrder ="T" and  S.converted ="F" and  ifnull(S.DueDate,' + quotedstr(formatDateTime(MysqlDateTimeFormat , 0 ))+ ' ) between ' + Quotedstr(formatDateTime(MySQLDateTimeformat , filterDateFrom)) +' and  ' + Quotedstr(formatDateTime(MySQLDateTimeformat , filterDateTo)) +
                   ' order by SL.saleLineId  ,  PT.Sequencedown;');
    SQl.Add('Update '+Tablename +' T Set SaleIDnLinenum = Convert(concat(SaleID ,"-" , LineSeqno) , char(50)) ;');

    {Processes as columns}
    for ctr := 1 to fiProcesses do begin
       SQl.Add('/*2-'+inttostr(ctr)+'*/Update '+Tablename +' T '+
                        ' inner join (Select * from tblprocesspart order by ProcessStepSeq)  PP on PP.ProctreeId = T.ProctreeId '+
                          //iif(ctr>1 , ' and PP.ProcessStepSeq > T.ProcessStepSeq'+trim(inttostr(ctr-1))  , '')+
                          ProcessStepSeqFilter+
                        ' inner join tblProcessstep PS on PP.processStepId = PS.Id  '+
                                ' Set ProcesspartID'    +Trim(IntToStr(ctr))+'= PP.ID,'+
                                    ' ProcessStepId'    +Trim(IntToStr(ctr))+'= PS.ID,'+
                                    ' ProcessStep'      +Trim(IntToStr(ctr))+'= PS.Description , '+
                                    ' Duration'         +Trim(IntToStr(ctr))+'= FormatSeconds(0,PP.Duration*T.ManufactureQty), '+
                                    ' SetupDuration'    +Trim(IntToStr(ctr))+'= FormatSeconds(0,PP.SetupDuration),'+
                                    ' BreakdownDuration'+Trim(IntToStr(ctr))+'= FormatSeconds(0,PP.BreakdownDuration),'+
                                    ' wDuration'         +Trim(IntToStr(ctr))+'= FormatSeconds('+inttostr(SecsInaWorkingDay)+',PP.Duration*T.ManufactureQty), '+
                                    ' iDuration'         +Trim(IntToStr(ctr))+'= PP.Duration*T.ManufactureQty, '+
                                    ' iSetupDuration'    +Trim(IntToStr(ctr))+'= PP.SetupDuration,'+
                                    ' iBreakdownDuration'+Trim(IntToStr(ctr))+'= PP.BreakdownDuration,'+
                                    ' Status'           +Trim(IntToStr(ctr))+'= ProcessPartStatusToUserStr(PP.status),'+
                                    ' psStatus'         +Trim(IntToStr(ctr))+'= PP.status,'+
                                    ' ProcessStepSeq'   +Trim(IntToStr(ctr))+'= PP.ProcessStepSeq;');

    end;

    {Product Stock Quantities}
    SQL.Add('/*3*/Drop table if exists ' +Tablename +'1;');
    SQL.Add('/*4*/    Create table '+tablename +'1 Select PQA.ProductId , PQA.DepartmentID , ' +
                                                      SQL4Qty(tInStock)+' as Instock,'+
                                                      SQL4Qty(tAvailable)+' as Available,'+
                                                      SQL4Qty(tPOBO)+' as OnOrder '+
                                                      ' from (Select Distinct ClassId, PartsId from '+Tablename +') as T inner join tblpqa pqa on pqa.DepartmentID = t.classId and pqa.productId = T.partsId '+
                                                      'group by    PQA.ProductId , PQA.DepartmentID ;');
    SQL.Add('/*5*/update '+Tablename +' T  '+
                          ' inner join ' + tablename +'1 as T1 on T.PartsId = T1.ProductId and T.classId = T1.departmentId  '+
                          ' Set T.Instock = T1.Instock, '+
                          ' T.Available = T1.Available ,'+
                          ' T.OnOrder = T1.Onorder;');


    {Flags based on the record}
    SQL.Add('/*6*/Drop table if exists ' +Tablename +'1;');
    SQL.Add('/*7*/'+SQLToUpdateOrderQtys(Tablename , 'SOQty' , 'Received' , 'Backorder' , false));

    SQL.Add('/*8*/update ' +Tablename +' T Set GoodsReceived = 2 where (BOMOnOrderQty <= Received and SOQty <> 0) or (SOQty  =0);');
    SQL.Add('/*9*/update ' +Tablename +' T Set GoodsReceived = 1 where BOMOnOrderQty > Received and SOQty <> 0;');

    SQL.Add('/*10*/update ' +Tablename +' T Set StockAvailable =2 where (TotalQty <= Instock and (FromStockQty <> 0 or BOMOnOrderQty <>0)) or (FromStockQty  =0 and BOMOnOrderQty =0);');
    SQL.Add('/*11*/update ' +Tablename +' T Set StockAvailable =1 where  TotalQty > Instock and (FromStockQty <> 0 or BOMOnOrderQty <>0) ;');

    SQL.Add('/*12*/update ' +Tablename +' T Set ProcessesDone =    '+ ThisProcessesDoneSQL+';');
    SQL.Add('/*12*/update ' +Tablename +' T Set ProcessesScheduled =    '+ ThisProcessesScheduledSQL+';');



    {Lowest Level nodes in the tree - with no subnodes}
    SQL.Add('/*13*/Drop table if exists ' +Tablename +'1;');
    SQL.Add('/*14*/Create table ' +Tablename +'1 '+
                ' Select totalQty, ParentID,Level, SaleId,saleDate ,  saleLineId, ProctreeId ,  '+
                ' 0 GoodsReceived , '+
                ' 0 as StockAvailable, '+
                ' 0 as SubBOMsDone, '+
                ' ProcessesDone, '+
                ' ProcessesScheduled, '+
                ' SOQty , Received, Instock,BOMOnOrderQty '+
                ' From '+Tablename +
                ' WHERE ProctreeId not in (Select ParentId from ' +tablename +');');
    SQL.Add('/*15*/update ' +Tablename +'1 Set GoodsReceived =2 where (BOMOnOrderQty <= Received and SOQty <> 0) or (SOQty  =0);');
    SQL.Add('/*16*/update ' +Tablename +'1 Set GoodsReceived =1 where BOMOnOrderQty > Received and SOQty <> 0;');
    SQL.Add('/*17*/update ' +Tablename +'1 Set StockAvailable =2 where TotalQty <= Instock ;');
    SQL.Add('/*18*/update ' +Tablename +'1 Set StockAvailable =1 where  TotalQty > Instock ;');
    SQL.Add('/*19*/update ' +Tablename +'1 Set SubBOMsDone =2 ;');


    SQL.Add('/*20*/update ' +Tablename +' T inner join (Select ParentId,  '+
                                                        ' Min(GoodsReceived) as GoodsReceived ,  '+
                                                        ' Min(StockAvailable) as StockAvailable ,  '+
                                                        ' Min(SubBOMsDone) as SubBOMsDone , '+
                                                        ' Min(ProcessesDone) as ProcessesDone  '+
            ' from ' + Tablename +'1 group by ParentId) as T1 on T.proctreeId = T1.ParentId Set T.GoodsReceived   = Least(T1.GoodsReceived, T.GoodsReceived)  , '+
                                                                                              ' T.StockAvailable  = Least(T1.StockAvailable, T.StockAvailable)  , '+
                                                                                              ' T.SubBOMsDone     = Least(T1.SubBOMsDone, T1.ProcessesDone)   ;');
    {Update Parent record based on child record status}
    for ctr := fiBomLevels-1 downto 0 do begin
      SQL.Add('/*21-1-'+inttostr(ctr)+'*/Drop table if exists ' +Tablename +'1;');
      SQL.Add('/*21-2-'+inttostr(ctr)+'*/Create table ' +Tablename +'1  Select T.ParentID, '+
                ' Min(if(T.GoodsReceived=0,2,T.GoodsReceived)) GoodsReceived , '+
                ' Min(if(T.StockAvailable=0,2,T.StockAvailable)) as StockAvailable, '+
                ' Min(if(T.SubBOMsDone=0,2,T.SubBOMsDone)) as SubBOMsDone, '+
                ' Min(if(T.ProcessesDone=0,2,T.ProcessesDone)) as ProcessesDone, '+
                ' T.SOQty , T.Received, T.Instock , T.ManufactureQty,T.FromStockQty,T.BOMOnOrderQty '+
                ' From '+Tablename + ' T Where Level = ' + inttostr(ctr)+' group by ParentID;');
      SQL.Add('/*21-3-'+inttostr(ctr)+'*/update ' +Tablename +' T inner join ' + Tablename +'1  as T1 on T.proctreeId = T1.ParentId Set T.GoodsReceived   = Least(T1.GoodsReceived, T.GoodsReceived)  , '+
                                                                                              ' T.StockAvailable  = Least(T1.StockAvailable, T.StockAvailable)  , '+
                                                                                              ' T.SubBOMsDone     = Least(T1.SubBOMsDone, T1.ProcessesDone)  ;');
    end;

    {Flag to auto schedule based on the user options}
    s:= '';
    if fbOktoScheduleWhenSubBOMsDone            then begin if s<> '' then s := s +' and '; s:= s +' SubBOMsDone in (2,0)'        ; end;
    if fbOktoScheduleWhenGoodsReceived          then begin if s<> '' then s := s +' and '; s:= s +' GoodsReceived in (2,0) '        ; end;
    if fbOktoScheduleWhenProcessesnotScheduled  then begin if s<> '' then s := s +' and '; s:= s +' ProcessesScheduled =1 ' ; end;
    if fbOktoScheduleWhenStockAvailable         then begin if s<> '' then s := s +' and '; s:= s +' StockAvailable in (2,0) '       ;end;
    if s<> '' then SQL.Add('/*22*/update  ' +Tablename +' Set OktoSchedule = if(' +s+',2,1);');


    SQL.Add('/*23*/update  ' +Tablename +' T Set RecordDescription = concat_ws("\n",'+Processes +', '+
                                                                          ' if(SubBOMsDone in (2,0) , "" , "Sub BOMs Pending") ,  '+
                                                                          ' if(GoodsReceived = 2, "Good Received" ,  if(GoodsReceived = 1, "Goods Yet To be received", "")),  '+
                                                                          ' if(StockAvailable = 2, "Enough Stock Available" ,  if(StockAvailable = 1, "Enough Stock not Available", "")),  '+
                                                                          ' if(ProcessesDone in (2,0) , "" ,if(ProcessesScheduled in (2,0) , "Process(es) are Scheduled" , "Processes to be Scheduled")));');

    {Lowest Level nodes in the tree - with no subnodes}
    SQL.Add('/*24*/Drop table if exists ' +Tablename +'1;');
    SQL.Add('/*25*/Create table ' +Tablename +'1 '+
                ' Select ProctreeId '+
                ' From '+Tablename +
                ' WHERE ProctreeId not in (Select ParentId from ' +tablename +');');

    SQL.Add('/*26*/update ' +Tablename +' T inner join ' +Tablename +'1 as T1 on T.proctreeId = T1.ProctreeId Set T.SubBOMsDone     = 0 , OktoSchedule=0;');
    SQL.Add('/*27*/update ' +Tablename +' T Set GoodsReceived =0 , StockAvailable =0 where BOMOnOrderQty =0;');

    SQL.Add('/*28*/Drop table if exists ' +Tablename +'1;');
  end;
end;
procedure TBOMWorkOrderBaseGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if fiAllProcesses >0 then
(*    MessageDlgXP_Vista('There are 100 Processes. Database Design only Permits to Show Maximum of  65 Processes.' + NL+
                       'The Rest of the Process are Ignored in this Report', mtWarning, [mbOK], 0);*)
    ListTimerMsg('There are ' + inttostr(fiAllProcesses) +' Processes in Your Database. Because of Database limitations, a Maximum of  65 Processes can can be Summarised.' + NL+
                       'The Rest of the Process are Ignored for This Report',nil,  20);
end;

procedure TBOMWorkOrderBaseGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  DateRangeSelectionHint := 'Report is filterd on Sales DueDate';
  fbRemeberIgnoreDateSelection := True;
end;

procedure TBOMWorkOrderBaseGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  DestroyUserTemporaryTable(Tablename+'1');
  inherited;
end;

procedure TBOMWorkOrderBaseGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  fifieldhideNo:=0;
  AFont.Color := ClBlack;
  ABrush.color := ClWhite;
  if BlankLineTotalsLine then begin
    ABrush.color := clWhite;
    AFont.color := ABrush.color;
  end else if TotalsLine then begin
    //Logtext('1:' + Field.fieldname );
    ABrush.color := GridColhighLightRed;
    if Totalsfield(Field.fieldname) then begin
      //AFont.color := clblack;
      AFont.Style := AFont.Style +[fsBold];
      //Logtext('2:' + Field.fieldname );
      Exit;
    end else begin
      AFont.color := ABrush.color;
    end;
  end else begin
    if GroupField(Field.fieldname ) then begin
      ABrush.color := GridColhighLightRed;
    end;

    Gridcolors(Field, field.fieldname, Afont, ABrush, False);
    DogrdMainCalcCellColors(Sender,Field,State,highlight,Afont,ABrush);
  end;
end;
procedure TBOMWorkOrderBaseGUI.DogrdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if IsSalesfield(Field.Fieldname) then begin
    if SameSalesRec then begin
        AFont.color := ABrush.color;
        fifieldhideNo := 1;
    end;
  end else if IsSalesLinefield(Field.FieldName) then begin
    if SameSalesLineRec  then begin
      if not(ReportCategoryChanged) then begin
        AFont.color := ABrush.color;
        fifieldhideNo := 1;
      end;
    end;
  end;

 if (Field is TIntegerfield) or (Field is TLargeintField) then begin
    if Field.asInteger =0 then AFont.color := ABrush.color;
  end else if Field is TFloatField then begin
    if round(Field.asfloat,2) =0 then AFont.color := ABrush.color;
  end;

end;
Function TBOMWorkOrderBaseGUI.Gridcolors(aField:Tfield; AfieldName:String; AFont :Tfont; ABrush:TBrush; IsTitle:Boolean):Boolean;
begin
  result := False;
      if      (Sametext(AFieldName,'ManufactureQty')) or
              (Sametext(AFieldName,'FromStockQty')) or
              (Sametext(AFieldName,'BOMOnOrderQty')) or
              (Sametext(AFieldName,'TotalQty')) then  begin
                ABrush.color := GridColhighLightGreen;
                Afont.color := Clblack;
                Result := TRue;
                fifieldhideNo := 2;

      end else if (Sametext(AFieldName,'Instock')) or
              (Sametext(AFieldName,'Available')) or
              (Sametext(AFieldName,'OnOrder')) then  begin
                ABrush.color := GridColhighLightYellow1;
                Afont.color := Clblack;
                Result := TRue;
                fifieldhideNo := 3;
      end else if (Sametext(AFieldName,'SOQty')) or
              (Sametext(AFieldName,'Received')) or
              (Sametext(AFieldName,'Backorder')) then  begin
                ABrush.color := GridColhighLightBlue;
                Afont.color := Clblack;
                Result := TRue;
                fifieldhideNo := 4;
      end else if not(IsTitle) and grdmain.IsSelectedRecord then begin
            AFont.Color := Clwhite;
            ABrush.color := clNavy;
            Result := TRue;
            fifieldhideNo := 5;
      end;
end;

function TBOMWorkOrderBaseGUI.GroupField(const FieldName: String): Boolean;
begin
  REsult := False;
end;

function TBOMWorkOrderBaseGUI.TotalsField(const FieldName: String): Boolean;
begin
  result := sametext(fieldname , 'Duration') or
            sametext(fieldname , 'SetupDuration') or
            sametext(fieldname , 'BreakdownDuration') or
            sametext(fieldname , 'wDuration') or
            sametext(fieldname , 'ManufactureQty');
end;

function TBOMWorkOrderBaseGUI.TotalsLine: boolean;
begin
  REsult := False;
  if Qrymain.findfield('Seqno') <> nil then
    Result := qryMain.findfield('Seqno').asInteger =2;
end;

procedure TBOMWorkOrderBaseGUI.MakeQrymain;
begin
end;

procedure TBOMWorkOrderBaseGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  fbOktoScheduleWhenSubBOMsDone := True;
  fbOktoScheduleWhenGoodsReceived:= True;
  fbOktoScheduleWhenProcessesnotScheduled:= True;
  fbOktoScheduleWhenStockAvailable:=False;

  if GuiPrefs.Node.Exists('Options.OktoScheduleWhenSubBOMsDone')            then fbOktoScheduleWhenSubBOMsDone:=  GuiPrefs.Node['Options.OktoScheduleWhenSubBOMsDone'].asBoolean;
  if GuiPrefs.Node.Exists('Options.OktoScheduleWhenGoodsReceived')          then fbOktoScheduleWhenGoodsReceived:=  GuiPrefs.Node['Options.OktoScheduleWhenGoodsReceived'].asBoolean;
  if GuiPrefs.Node.Exists('Options.OktoScheduleWhenProcessesnotScheduled')  then fbOktoScheduleWhenProcessesnotScheduled:=  GuiPrefs.Node['Options.OktoScheduleWhenProcessesnotScheduled'].asBoolean;
  if GuiPrefs.Node.Exists('Options.OktoScheduleWhenStockAvailable')         then fbOktoScheduleWhenStockAvailable:=  GuiPrefs.Node['Options.OktoScheduleWhenStockAvailable'].asBoolean;

end;

function TBOMWorkOrderBaseGUI.ReportCategoryChanged: Boolean;
begin
  Result := False;
end;

function TBOMWorkOrderBaseGUI.SameSalesLineRec: Boolean;
begin
  result := False;
  if (Qrymain.findfield('ProcTreeSeqno')<> nil) then
    Result := (*(Qrymain.fieldbyname('LineSeqno').asInteger = 1) or*) (Qrymain.fieldbyname('ProcTreeSeqno').asInteger <> 1 );
  if not result then
    if (Qrymain.findfield('ProcessPartSeqno')<> nil) then
     result := (Qrymain.fieldbyname('ProcessPartSeqno').asInteger <> 1 );
end;

function TBOMWorkOrderBaseGUI.Samesalesrec: Boolean;
begin
  Result := False;
  if (Qrymain.findfield('LineSeqno')<> nil) then
    Result := (Qrymain.fieldbyname('LineSeqno').asInteger <> 1);
  if not result then result := SameSalesLineRec;
end;

end.
