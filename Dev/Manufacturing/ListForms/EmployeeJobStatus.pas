unit EmployeeJobStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, TeEngine, Series, TeeProcs, Chart, DBChart, TeeGDIPlus,
  wwclearbuttongroup, wwradiogroup;

type
  TEmployeeJobStatusGUI = class(TBaseListingGUI)
    pnlChart: TDNMPanel;
    DBChart1: TDBChart;
    Series2: THorizBarSeries;
    Series1: THorizBarSeries;
    DNMPanel1: TDNMPanel;
    Label2: TLabel;
    chkhideconverted: TwwCheckBox;
    qryMainTimetofinishForchart: TFloatField;
    qryMainDetailsForChart: TStringField;
    qryMainTotalTimeforchart: TFloatField;
    qryMainDetails: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryMainProctreeID: TIntegerField;
    qryMainPPID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainconverted: TWideStringField;
    qryMainSaledate: TDateField;
    qryMainproductname: TWideStringField;
    qryMainUnitofMeasureSaleLines: TWideStringField;
    qryMainUnitofMeasureMultiplier: TFloatField;
    qryMainLineItem: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainTreePartUOMTotalQty: TFloatField;
    qryMainProcessStep: TWideStringField;
    qryMainDuration: TFloatField;
    qryMainsetupDuration: TFloatField;
    qryMainbreakdownduration: TFloatField;
    qryMaincDuration: TWideStringField;
    qryMaincsetupDuration: TWideStringField;
    qryMaincbreakdownduration: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMaintotaltimerequired: TFloatField;
    qryMainScheduledtime: TFloatField;
    qryMaintotlatime: TFloatField;
    qryMaintimetofinish: TFloatField;
    qryMaintotlatimeemployee: TFloatField;
    qryMainctotaltimerequired: TWideStringField;
    qryMaincScheduledtime: TWideStringField;
    qryMainctotlatime: TWideStringField;
    qryMainctimetofinish: TWideStringField;
    qryMainctotlatimeemployee: TWideStringField;
    qryMainComment: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainBeforeClose(DataSet: TDataSet);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure grpViewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkhideconvertedClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    Tablename :String;
    procedure PopulateTempTable;
    procedure CreateTempTable;
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, SystemLib, LogLib, tcConst, CommonDbLib, MySQLConst;

{$R *.dfm}
{ TEmployeeJobStatusGUI }

procedure TEmployeeJobStatusGUI.chkhideconvertedClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkhideconverted then
    RefreshQuery;
end;
procedure TEmployeeJobStatusGUI.CreateTempTable;
begin
  with ScriptMain do try
    SQL.Clear;
    SQL.add('drop table if exists '+Tablename +'  ;');
    SQL.add('CREATE TABLE '+Tablename +'  ( '+
                ' Details                 INT(11)       NOT NULL  DEFAULT 0,    '+
                ' saleLineId              INT(11)       NOT NULL  DEFAULT 0,    '+
                ' ProctreeID              INT(11)       NOT NULL  DEFAULT 0,    '+
                ' PPID                    INT(11)       NOT NULL  DEFAULT 0,    '+
                ' SaleID                  INT(11)       NOT NULL  DEFAULT 0,    '+
                ' converted               ENUM("T","F")           DEFAULT "T",  '+
                ' Saledate                DATE DEFAULT  NULL,                   '+
                ' productname             VARCHAR(60)             DEFAULT NULL, '+
                ' UnitofMeasureSaleLines  VARCHAR(255)            DEFAULT NULL, '+
                ' UnitofMeasureMultiplier DOUBLE        NOT NULL  DEFAULT 0,    '+
                ' LineItem                VARCHAR(100),                         '+
                ' UOM                     VARCHAR(100)            DEFAULT NULL, '+
                ' UnitofMeasureShipped    DOUBLE        NOT NULL  DEFAULT 0,    '+
                ' TreePartUOMTotalQty     DOUBLE                  DEFAULT NULL, '+
                ' ProcessStep             VARCHAR(100)  NOT NULL  DEFAULT "",   '+
                ' Duration                DOUBLE        NOT NULL  DEFAULT 0,    '+
                ' setupDuration           DOUBLE        NOT NULL  DEFAULT 0,    '+
                ' breakdownduration       DOUBLE        NOT NULL  DEFAULT 0,    '+
                ' cDuration               VARCHAR(50),                          '+
                ' csetupDuration          VARCHAR(50),                          '+
                ' cbreakdownduration      VARCHAR(50),                          '+
                ' EmployeeName            VARCHAR(100)            DEFAULT NULL, '+
                ' EmployeeID              INT(11)                 DEFAULT NULL, '+
                ' totaltimerequired       DOUBLE        NOT NULL  DEFAULT 0,    '+
                ' Scheduledtime           DOUBLE                  DEFAULT NULL, '+
                ' totlatime               DOUBLE                  DEFAULT NULL, '+
                ' timetofinish            DOUBLE                  DEFAULT NULL, '+
                ' totlatimeemployee       DOUBLE                  DEFAULT NULL, '+
                ' ctotaltimerequired      VARCHAR(50),                          '+
                ' cScheduledtime          VARCHAR(50),                          '+
                ' ctotlatime              VARCHAR(50),                          '+
                ' ctimetofinish           VARCHAR(50),                          '+
                ' ctotlatimeemployee      VARCHAR(50),                           '+
                ' Comment                 VARCHAR(255)'+
                ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

  finally
    Execute;
    SQL.Clear;
  end;
end;
procedure TEmployeeJobStatusGUI.FormCreate(Sender: TObject);
begin
  Tablename := Commondblib.GetUserTemporaryTableName('empJobStatus');
  CreateTempTable;
  Qrymain.SQL.Clear;
  Qrymain.SQL.AdD('Select');
  Qrymain.SQL.Add('*');
  Qrymain.SQL.Add('from '+ Tablename );
  Qrymain.SQL.Add('Order by SaleID, saleLineId, ProctreeID , ppid, employeename');

  pnlChart.Align := alclient;
  inherited;
  Selectionoption := soEmployee;
end;

procedure TEmployeeJobStatusGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;
end;

procedure TEmployeeJobStatusGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpViewclick(grpView);
end;

procedure TEmployeeJobStatusGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymaindetails.AsInteger <> 1 then
    if not(sametext(field.FieldName , qrymainemployeename.FieldName ) Or
    sametext(field.FieldName , qryMainTimetofinishForchart.FieldName ) Or
    sametext(field.FieldName , qryMainDetailsForChart.FieldName ) Or
    sametext(field.FieldName , qrymainctotlatimeemployee.FieldName )) then
    Afont.Color := abrush.Color;
  if Qrymaintimetofinish.AsFloat <0 then
    if sametext(field.FieldName , qryMainctimetofinish.FieldName )and (Qrymaindetails.AsInteger =1) then AFont.color := clred;
end;

procedure TEmployeeJobStatusGUI.grpViewClick(Sender: TObject);
const
  graphfilter = 'Details =2 and employeeId <>0' ;
  andgraphfilter = ' and Details =2 and employeeId <>0';
begin
  grdmain.Visible := grpView.ItemIndex = 1;
  pnlchart.Visible := grpView.ItemIndex = 0;
  if grpView.ItemIndex = 1 then begin
    if pos(andgraphfilter , Qrymain.Filter)  >0 then Qrymain.Filter := replacestr(Qrymain.Filter , andgraphfilter , '')
    else if pos(graphfilter , Qrymain.Filter)  >0 then Qrymain.Filter := replacestr(Qrymain.Filter , graphfilter , '');
  end else if (pos(andgraphfilter , Qrymain.Filter) =0) and (pos(graphfilter , Qrymain.Filter)  =0) then begin
    if Qrymain.Filter <> '' then Qrymain.filter := '('+ Qrymain.filter+')' + andgraphfilter
    else Qrymain.filter :=  graphfilter;
  end;
  Qrymain.Filtered := Qrymain.filter <> '';
  DBChart1.RefreshData;
end;


(*procedure TEmployeeJobStatusGUI.QryForchartCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryForchartTimetoFinish.AsFloat :=  QryForcharttotaltimerequired.AsFloat - QryForcharttotlatime.AsFloat;

  if QryForchartTimetoFinish.AsFloat <0 then QryForchartTimetoFinish.AsFloat := 0;
  if QryForchartTimetoFinish.AsFloat <> 0 then QryForchartTimetoFinish.AsFloat := Round(QryForchartTimetoFinish.AsFloat/60/60, 2);
  if QryForcharttotlatimeemployee.AsFloat =0 then QryForcharttotlaemployeehours.AsFloat:= 0
  else QryForcharttotlaemployeehours.AsFloat := Round(QryForcharttotlatimeemployee.AsFloat/60/60,2);
  QryForchartDetails.asString := '[' +SecondsToTime( trunc(QryForcharttotlaemployeehours.AsFloat) , true, False, '0') +'] : [' + SecondsToTime( trunc(QryForchartTimetoFinish.AsFloat) , true, False , '0') +']' +
                                ' -> Sale # '+  QryForchartsaleID.asString  +':' +
                                QryForchartEmployeeName.asString +  ', ' +
                                QryForchartproductname.asString +' :  '+ FloatToStrF( QryForchartUnitofMeasureShipped.asfloat , ffFixed, 15,2)+ '  ' + QryForchartUnitofMeasureSaleLines.asString +'(' +  FloattostrF(QryForchartUnitofMeasureMultiplier.asFloat, ffFixed, 15,2) +')' ;
end;*)

procedure TEmployeeJobStatusGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
(*  try
      CloseDB(QryForchart);
      QryForchart.Connection := Qrymain.Connection;
      QryForchart.Parambyname('dateFrom').AsDatetime    := Qrymain.Parambyname('dateFrom').AsDatetime;
      QryForchart.Parambyname('dateTo').AsDatetime      := Qrymain.Parambyname('dateTo').AsDatetime;
      QryForchart.parambyname('employeeId').asInteger   := Qrymain.parambyname('employeeId').asInteger;
      QryForchart.parambyname('HideConverted').asString := Qrymain.parambyname('HideConverted').asString;
      openDB(QryForchart);
  Except
     on E:Exception do begin
      MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
     end;
  end;*)
end;

procedure TEmployeeJobStatusGUI.qryMainBeforeClose(DataSet: TDataSet);
begin
  inherited;
(*  CloseDB(QryForchart);*)
end;

procedure TEmployeeJobStatusGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryMainTimetofinish.asFloat<0 then qryMainTimetofinishForchart.asFloat := 0
  else qryMainTimetofinishForchart.asFloat :=   round(qryMainTimetofinish.asFloat/60/60,4);

  if qryMaintotlatimeemployee.asFloat =0 then qryMainTotalTimeforchart.asFloat :=   0
  else qryMainTotalTimeforchart.asFloat :=   round(qryMaintotlatimeemployee.asFloat/60/60,4);


  qryMainDetailsForChart.asString := '[' + qryMainctotlatimeemployee.asString +'] : [' + iif(Qrymaintimetofinish.AsFloat<0 , 'Over Spent' , qryMainctimetofinish.asString) +'] ------ ' +
                                      '[' + qryMainctotlatime.asString +'] : [' +  qryMainctotaltimerequired.asString +']' +
                                NL+ 'Sale # '+  QrymainsaleID.asString  +':' + Qrymainproductname.asString +' :  '+ FloatToStrF( QrymainUnitofMeasureShipped.asfloat , ffFixed, 15,2)+ '  ' + QrymainUnitofMeasureSaleLines.asString +'(' +  FloattostrF(QrymainUnitofMeasureMultiplier.asFloat, ffFixed, 15,2) +')'+
                                NL+ QrymainEmployeeName.asString +  ', ' +
                                qryMainProcessStep.asString ;
  Logtext(qryMainDetailsForChart.asString);
end;

procedure TEmployeeJobStatusGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.grpViewOption') then
      grpView.ItemIndex :=  GuiPrefs.Node['Options.grpViewOption'].asInteger;
  if GuiPrefs.Node.Exists('Options.HideConverted') then
  chkhideconverted.checked := GuiPrefs.Node['Options.HideConverted'].asBoolean;
end;
procedure TEmployeeJobStatusGUI.PopulateTempTable;
var
  ctr:Integer;
begin
  with ScriptMain do try
    SQL.Clear;
    SQL.Add('truncate '+Tablename +';');
    SQL.Add('insert into '+Tablename +'(Details,saleLineId,ProctreeID,PPID,SaleID,converted,Saledate,productname,UnitofMeasureSaleLines, ' +
            ' UnitofMeasureMultiplier,LineItem,UOM ,UnitofMeasureShipped,TreePartUOMTotalQty,ProcessStep, ' +
            ' Duration,setupDuration,breakdownduration,cDuration,csetupDuration,cbreakdownduration,totaltimerequired ,ctotaltimerequired, Comment)' +
            ' SELECT  Distinct ' +
            ' 1 as Details, ' +
            ' SL.saleLineId as saleLineId, ' +
            ' PT.ProctreeID  as ProctreeID, ' +
            ' PP.ID  as PPID, ' +
            ' S.sAleId as SaleID, ' +
            ' S.converted as converted, ' +
            ' S.Saledate as Saledate, ' +
            ' SL.productname as productname, ' +
            ' SL.UnitofMeasureSaleLines as UnitofMeasureSaleLines, ' +
            ' SL.UnitofMeasureMultiplier as UnitofMeasureMultiplier, ' +
            ' Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) as LineItem, ' +
            ' concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , ")") as UOM , ' +
            ' SL.UnitofMeasureShipped as UnitofMeasureShipped, ' +
            ' PT.TreePartUOMTotalQty as TreePartUOMTotalQty, ' +
            ' PS.description as ProcessStep, ' +
            ' PT.TotalQty*PP.Duration as Duration, ' +
            ' PP.setupDuration as setupDuration, ' +
            ' PP.breakdownduration as breakdownduration, ' +
            ' FormatSecondsTotime(PT.TotalQty*PP.Duration) as cDuration, ' +
            ' FormatSecondsTotime(PP.setupDuration) as csetupDuration, ' +
            ' FormatSecondsTotime(PP.breakdownduration) as cbreakdownduration, ' +
            ' (PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration)as totaltimerequired , ' +
            ' FormatSecondsTotime((PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration)) as ctotaltimerequired,  ' +
            ' PPT.Comment ' +
            ' From tblSales S ' +
            ' inner join tblsaleslines SL on S.saleID = SL.saleID ' +
            ' inner join tblproctree PT on PT.MasterId = SL.saleLineId and PT.mastertype <> "mtProduct" ' +
            ' inner join tblProcessPart PP on PP.proctreeId = PT.proctreeId ' +
            ' inner join tblProcessStep PS on PP.processstepId = PS.id ' +
            ' Left join tblProcesstime PRT on PRT.ProcessPartID = PP.ID ' +
            ' Left join tblprocessparttimesheet PPT  on PPT.ProcessPartID = PP.ID ' +
            ' where S.SAleDate between '+ Quotedstr(FormatDateTime(MYSQLDatetimeformat, filterDateFrom)) +' and '+ Quotedstr(FormatDateTime(MYSQLDatetimeformat, filterDateTo)) +' '+
            iif(chkhideconverted.checked , ' and S.converted     = "F"' , '') +
            iif(AllEmployees =False      , ' and PPT.employeeId  = ' + inttostr(SelectedemployeeID), '')+';');


      (*SQL.Add('Drop table if exists ' +tablename +'1;');
      SQL.Add('Create table ' +tablename +'1 Select T.PPID, sum(Duration) Scheduledtime  '+
              ' from '+tablename +' T inner join tblProcesstime PRT on PRT.ProcessPartID = T.PPID group by T.PPID;');
      SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId Set T.Scheduledtime = T1.Scheduledtime;');


      SQL.Add('Drop table if exists ' +tablename +'1;');
      SQL.Add('Create table ' +tablename +'1 Select T.PPID, sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd)))  totlatime '+
              ' from '+tablename +' T inner join tblprocessparttimesheet PPTtotal  on PPTtotal.ProcessPartID =  T.PPID group by T.PPID;');
      SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId Set T.totlatime = T1.totlatime;');


      SQL.Add('Drop table if exists ' +tablename +'1;');
      SQL.Add('Create table ' +tablename +'1 Select T.PPID, sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd)))  as  timetofinish  '+
              ' from '+tablename +' T inner join tblprocessparttimesheet PPTtotal on PPTtotal.ProcessPartID =  T.PPID group by T.PPID;');
      SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId Set T.ctimetofinish = FormatSecondsTotime(T.totaltimerequired - T1.timetofinish);');



      SQL.Add('Drop table if exists ' +tablename +'1;');
      SQL.Add('Create table ' +tablename +'1 Select T.PPID, sum(Duration) as Scheduledtime   '+
              ' from '+tablename +' T inner join tblProcesstime PRT on  PRT.ProcessPartID =  T.PPID group by T.PPID;');
      SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId Set T.cScheduledtime = FormatSecondsTotime(T1.Scheduledtime);');


      SQL.Add('Drop table if exists ' +tablename +'1;');
      SQL.Add('Create table ' +tablename +'1 Select T.PPID, sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) as  totlatime  '+
              ' from '+tablename +' T inner join tblprocessparttimesheet PPTtotal on PPTtotal.ProcessPartID =  T.PPID group by T.PPID;');
      SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId Set T.ctotlatime = FormatSecondsTotime(T1.totlatime);');


      SQL.Add('Drop table if exists ' +tablename +'1;');
      SQL.Add('Create table ' +tablename +'1 Select T.PPID,sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) as timetofinish   '+
              ' from '+tablename +' T inner join tblprocessparttimesheet PPTtotal on PPTtotal.ProcessPartID  =  T.PPID group by T.PPID;');
      SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId Set T.timetofinish = T.totaltimerequired - T1.timetofinish;');*)

      SQL.Add('insert into '+Tablename +'(Details,saleLineId,ProctreeID,PPID,SaleID,converted,Saledate,productname,UnitofMeasureSaleLines,UnitofMeasureMultiplier,LineItem,UOM , ' +
                                        'UnitofMeasureShipped,TreePartUOMTotalQty,ProcessStep,Duration,setupDuration,breakdownduration,cDuration, ' +
                                        'csetupDuration,cbreakdownduration,EmployeeName,EmployeeId,totaltimerequired ,ctotaltimerequired, Comment )' +
            ' Select Distinct ' +
            ' 2 as Details, ' +
            ' SL.saleLineId as saleLineId, ' +
            ' PT.ProctreeID  as ProctreeID, ' +
            ' PP.ID  as PPID, ' +
            ' S.sAleId as SaleID, ' +
            ' S.converted as converted, ' +
            ' S.Saledate as Saledate, ' +
            ' SL.productname as productname, ' +
            ' SL.UnitofMeasureSaleLines as UnitofMeasureSaleLines, ' +
            ' Sl.UnitofMeasureMultiplier as UnitofMeasureMultiplier, ' +
            ' Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) as LineItem, ' +
            ' concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , ")") as UOM , ' +
            ' SL.UnitofMeasureShipped as UnitofMeasureShipped, ' +
            ' PT.TreePartUOMTotalQty as TreePartUOMTotalQty, ' +
            ' PS.description as ProcessStep, ' +
            ' PT.TotalQty*PP.Duration as Duration, ' +
            ' PP.setupDuration as setupDuration, ' +
            ' PP.breakdownduration as breakdownduration, ' +
            ' FormatSecondsTotime(PT.TotalQty*PP.Duration) as cDuration, ' +
            ' FormatSecondsTotime(PP.setupDuration) as csetupDuration, ' +
            ' FormatSecondsTotime(PP.breakdownduration) as cbreakdownduration, ' +
            ' ifnull(E.EmployeeName,"") as EmployeeName, ' +
            ' ifnull(E.EmployeeId,0) as EmployeeId, ' +
            ' (PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration)as totaltimerequired , ' +
            ' FormatSecondsTotime((PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration)) as ctotaltimerequired,  ' +
            ' PPT.Comment ' +
            ' From tblSales S ' +
            ' inner join tblsaleslines SL on S.saleID = SL.saleID ' +
            ' inner join tblproctree PT on PT.MasterId = SL.saleLineId and PT.mastertype <> "mtProduct" ' +
            ' inner join tblProcessPart PP on PP.proctreeId = PT.proctreeId ' +
            ' inner join tblProcessStep PS on PP.processstepId = PS.id ' +
            ' inner join tblProcesstime PRT on PRT.ProcessPartID = PP.ID ' +
            ' inner join (tblprocessparttimesheet PPT inner join tblemployees E on PPT.employeeId = E.EmployeeId ) on PPT.ProcessPartID = PP.ID ' +
            ' where S.SAleDate between '+ Quotedstr(FormatDateTime(MYSQLDatetimeformat, filterDateFrom)) +' and '+ Quotedstr(FormatDateTime(MYSQLDatetimeformat, filterDateTo)) +' '+
            iif(chkhideconverted.checked , ' and S.converted     = "F"' , '') +
            iif(AllEmployees =False      , ' and PPT.employeeId  = ' + inttostr(SelectedemployeeID), '')+';');

      sql.SaveToFile('c:\temp\jobs.txt');
      For ctr := 1 to 2 do begin
          SQL.Add('Drop table if exists ' +tablename +'1;');
          SQL.Add('Create table ' +tablename +'1 Select T.PPID,T.EmployeeID,  sum(PRT.Duration) Scheduledtime  '+
                  ' from '+tablename +' T inner join tblProcesstime PRT on PRT.ProcessPartID = T.PPID and T.DEtails= ' + inttostr(ctr) +' group by T.PPID ,T.EmployeeID;');
          SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId and T.employeeId = T1.employeeId  and T.DEtails= ' + inttostr(ctr) +' Set T.Scheduledtime = T1.Scheduledtime Where T.DEtails= ' + inttostr(ctr) +' ;');


          SQL.Add('Drop table if exists ' +tablename +'1;');
          SQL.Add('Create table ' +tablename +'1 Select T.PPID,T.EmployeeID, sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd)))  totlatime '+
                  ' from '+tablename +' T inner join tblprocessparttimesheet PPTtotal  on PPTtotal.ProcessPartID =  T.PPID  and T.DEtails= ' + inttostr(ctr) +' group by T.PPID ,T.EmployeeID;');
          SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId and T.employeeId = T1.employeeId  and T.DEtails= ' + inttostr(ctr) +' Set T.totlatime = T1.totlatime Where T.DEtails= ' + inttostr(ctr) +' ;');


          SQL.Add('Drop table if exists ' +tablename +'1;');
          SQL.Add('Create table ' +tablename +'1 Select T.PPID,T.EmployeeID, sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd)))  as  timetofinish  '+
                  ' from '+tablename +' T inner join tblprocessparttimesheet PPTtotal on PPTtotal.ProcessPartID =  T.PPID  and T.DEtails= ' + inttostr(ctr) +' group by T.PPID ,T.EmployeeID;');
          SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId and T.employeeId = T1.employeeId  and T.DEtails= ' + inttostr(ctr) +' Set T.ctimetofinish = FormatSecondsTotime(T.totaltimerequired - T1.timetofinish) Where T.DEtails= ' + inttostr(ctr) +' ;');



          SQL.Add('Drop table if exists ' +tablename +'1;');
          SQL.Add('Create table ' +tablename +'1 Select T.PPID,T.EmployeeID, sum(PRT.Duration) as Scheduledtime   '+
                  ' from '+tablename +' T inner join tblProcesstime PRT on  PRT.ProcessPartID =  T.PPID  and T.DEtails= ' + inttostr(ctr) +' group by T.PPID ,T.EmployeeID;');
          SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId and T.employeeId = T1.employeeId  and T.DEtails= ' + inttostr(ctr) +' Set T.cScheduledtime = FormatSecondsTotime(T1.Scheduledtime) Where T.DEtails= ' + inttostr(ctr) +' ;');


          SQL.Add('Drop table if exists ' +tablename +'1;');
          SQL.Add('Create table ' +tablename +'1 Select T.PPID,T.EmployeeID, sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) as  totlatime  '+
                  ' from '+tablename +' T inner join tblprocessparttimesheet PPTtotal on PPTtotal.ProcessPartID =  T.PPID  and T.DEtails= ' + inttostr(ctr) +' group by T.PPID ,T.EmployeeID;');
          SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId and T.employeeId = T1.employeeId  and T.DEtails= ' + inttostr(ctr) +' Set T.ctotlatime = FormatSecondsTotime(T1.totlatime) Where T.DEtails= ' + inttostr(ctr) +' ;');


          SQL.Add('Drop table if exists ' +tablename +'1;');
          SQL.Add('Create table ' +tablename +'1 Select T.PPID,T.EmployeeID,sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) as timetofinish   '+
                  ' from '+tablename +' T inner join tblprocessparttimesheet PPTtotal on PPTtotal.ProcessPartID  =  T.PPID  and T.DEtails= ' + inttostr(ctr) +' group by T.PPID ,T.EmployeeID;');
          SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId and T.employeeId = T1.employeeId  and T.DEtails= ' + inttostr(ctr) +' Set T.timetofinish = T.totaltimerequired - T1.timetofinish Where T.DEtails= ' + inttostr(ctr) +' ;');

      end;
      SQL.Add('Drop table if exists ' +tablename +'1;');
      SQL.Add('Create table ' +tablename +'1 Select T.PPID, T.employeeId , sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) as  totlatimeemployee  '+
              ' from '+tablename +' T inner join tblprocessparttimesheet PPTtotal on  PPTtotal.ProcessPartID =  T.PPID and PPTtotal.employeeID = T.employeeId and T.Details = 2 group by T.PPID, T.employeeId;');
      SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId and T.employeeId = T1.employeeId  and T.DEtails= 2  Set T.totlatimeemployee = T1.totlatimeemployee ;');

      SQL.Add('Drop table if exists ' +tablename +'1;');
      SQL.Add('Create table ' +tablename +'1 Select T.PPID, T.employeeId, sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) as totlatimeemployee   '+
              ' from '+tablename +' T inner join tblprocessparttimesheet PPTtotal on PPTtotal.ProcessPartID =  T.PPID and PPTtotal.employeeID = T.employeeId and T.Details = 2 group by T.PPID, T.employeeId;');
      SQL.Add('update ' +tablename +' T inner join ' +Tablename +'1 T1 on T.PPId = T1.PPId and T.employeeId = T1.employeeId  and T.DEtails= 2 Set T.ctotlatimeemployee = FormatSecondsTotime(T1.totlatimeemployee);');
  finally
    clog(SQL.Text);
    Execute;
    SQL.Clear;
  end;
end;
procedure TEmployeeJobStatusGUI.RefreshQuery;
begin
  PopulateTempTable;
  inherited;
end;

procedure TEmployeeJobStatusGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymaintotaltimerequired.fieldname);
  RemoveFieldfromGrid(QrymainScheduledtime.fieldname);
  RemoveFieldfromGrid(Qrymaintotlatime.fieldname);
  RemoveFieldfromGrid(Qrymaintotlatimeemployee.fieldname);
  RemoveFieldfromGrid(Qrymaintimetofinish.fieldname);
  RemoveFieldfromGrid(Qrymaindetails.fieldname);
  RemoveFieldfromGrid(qryMainDuration.fieldname);
  RemoveFieldfromGrid(qryMainsetupDuration.fieldname);
  RemoveFieldfromGrid(qryMainbreakdownduration.fieldname);
  RemoveFieldfromGrid(qryMainEmployeeID.fieldname);
  RemoveFieldfromGrid(QrymainTimetofinishForchart.fieldname);
  RemoveFieldfromGrid(QrymainDetailsForChart.fieldname);
  RemoveFieldfromGrid(QrymainUnitofMeasureSaleLines.fieldname);
  RemoveFieldfromGrid(QrymainUnitofMeasureMultiplier.fieldname);
  RemoveFieldfromGrid(QrymainTotalTimeforchart.fieldname);
  RemoveFieldfromGrid(Qrymainproductname.fieldname);
  RemoveFieldfromGrid(QrymainTreePartUOMTotalQty.fieldname);

  if not devmode then begin
    RemoveFieldfromGrid(qryMainTimetofinishForchart.fieldname);
    RemoveFieldfromGrid(qryMainDetailsForChart.fieldname);
  end;
end;

procedure TEmployeeJobStatusGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.grpViewOption'].asInteger := grpView.ItemIndex ;
  GuiPrefs.Node['Options.HideConverted'].asBoolean :=chkhideconverted.checked;
end;

initialization
  RegisterClassOnce(TEmployeeJobStatusGUI);

(*Select Distinct
1 as Details,
SL.saleLineId as saleLineId,
PT.ProctreeID  as ProctreeID,
PP.ID  as PPID,
S.sAleId as SaleID,
S.converted as converted,
S.Saledate as Saledate,
SL.productname as productname,
SL.UnitofMeasureSaleLines as UnitofMeasureSaleLines,
SL.UnitofMeasureMultiplier as UnitofMeasureMultiplier,
Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) as LineItem,
concat(SL.UnitofMeasureSaleLines , ' (' , SL.UnitofMeasureMultiplier , ')') as UOM ,
SL.UnitofMeasureShipped as UnitofMeasureShipped,
PT.TreePartUOMTotalQty as TreePartUOMTotalQty,
PS.description as ProcessStep,
PT.TotalQty*PP.Duration as Duration,
PP.setupDuration as setupDuration,
PP.breakdownduration as breakdownduration,
FormatSecondsTotime(PT.TotalQty*PP.Duration) as cDuration,
FormatSecondsTotime(PP.setupDuration) as csetupDuration,
FormatSecondsTotime(PP.breakdownduration) as cbreakdownduration,
null as EmployeeName,
null as EmployeeID,
(PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration)as totaltimerequired ,
(Select sum(Duration) from tblProcesstime PRT where PRT.ProcessPartID = PP.ID ) as Scheduledtime ,
(Select sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) from tblprocessparttimesheet PPTtotal Where PPTtotal.ProcessPartID = PP.ID) as totlatime ,
(PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration) - (Select sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) from tblprocessparttimesheet PPTtotal Where PPTtotal.ProcessPartID = PP.ID) timetofinish,
Null as totlatimeemployee ,
FormatSecondsTotime((PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration)) as ctotaltimerequired ,
FormatSecondsTotime((Select sum(Duration) from tblProcesstime PRT where PRT.ProcessPartID = PP.ID )) as cScheduledtime ,
FormatSecondsTotime((Select sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) from tblprocessparttimesheet PPTtotal Where PPTtotal.ProcessPartID = PP.ID)) as ctotlatime ,
FormatSecondsTotime((PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration) - (Select sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) from tblprocessparttimesheet PPTtotal Where PPTtotal.ProcessPartID = PP.ID)) ctimetofinish,
null as ctotlatimeemployee
From tblSales S
inner join tblsaleslines SL on S.saleID = SL.saleID
inner join tblproctree PT on PT.MasterId = SL.saleLineId and PT.mastertype <> 'mtProduct'
inner join tblProcessPart PP on PP.proctreeId = PT.proctreeId
inner join tblProcessStep PS on PP.processstepId = PS.id
Left join tblProcesstime PRT on PRT.ProcessPartID = PP.ID
Left join tblprocessparttimesheet PPT  on PPT.ProcessPartID = PP.ID
where (:HideConverted ="F" or S.converted ="F") and  S.SAleDate between :datefrom and :Dateto and (:EmployeeID =0 or PPT.employeeId  = :EmployeeID)
union all
Select Distinct
2 as Details,
SL.saleLineId as saleLineId,
PT.ProctreeID  as ProctreeID,
PP.ID  as PPID,
S.sAleId as SaleID,
S.converted as converted,
S.Saledate as Saledate,
SL.productname as productname,
SL.UnitofMeasureSaleLines as UnitofMeasureSaleLines,
Sl.UnitofMeasureMultiplier as UnitofMeasureMultiplier,
Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) as LineItem,
concat(SL.UnitofMeasureSaleLines , ' (' , SL.UnitofMeasureMultiplier , ')') as UOM ,
SL.UnitofMeasureShipped as UnitofMeasureShipped,
PT.TreePartUOMTotalQty as TreePartUOMTotalQty,
PS.description as ProcessStep,
PT.TotalQty*PP.Duration as Duration,
PP.setupDuration as setupDuration,
PP.breakdownduration as breakdownduration,
FormatSecondsTotime(PT.TotalQty*PP.Duration) as cDuration,
FormatSecondsTotime(PP.setupDuration) as csetupDuration,
FormatSecondsTotime(PP.breakdownduration) as cbreakdownduration,
ifnull(E.EmployeeName,'') as EmployeeName,
ifnull(E.EmployeeId,0) as EmployeeId,
(PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration)as totaltimerequired ,
(Select sum(Duration) from tblProcesstime PRT where PRT.ProcessPartID = PP.ID ) as Scheduledtime ,
(Select sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) from tblprocessparttimesheet PPTtotal Where PPTtotal.ProcessPartID = PP.ID) as totlatime ,
(PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration) - (Select sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) from tblprocessparttimesheet PPTtotal Where PPTtotal.ProcessPartID = PP.ID)  timetofinish,
(Select sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) from tblprocessparttimesheet PPTtotal Where PPTtotal.ProcessPartID = PP.ID and PPTtotal.employeeID = PPT.employeeId) as totlatimeemployee ,
FormatSecondsTotime((PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration)) as ctotaltimerequired ,
FormatSecondsTotime((Select sum(Duration) from tblProcesstime PRT where PRT.ProcessPartID = PP.ID )) as cScheduledtime ,
FormatSecondsTotime((Select sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) from tblprocessparttimesheet PPTtotal Where PPTtotal.ProcessPartID = PP.ID)) as ctotlatime ,
FormatSecondsTotime((PT.TotalQty*PP.Duration + PP.setupDuration + PP.breakdownduration) - (Select sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) from tblprocessparttimesheet PPTtotal Where PPTtotal.ProcessPartID = PP.ID) ) ctimetofinish,
FormatSecondsTotime((Select sum(TIMESTAMPDIFF(second, PPTtotal.timestart , if(ifnull(PPTtotal.timeend, "1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() , PPTtotal.timeEnd))) from tblprocessparttimesheet PPTtotal Where PPTtotal.ProcessPartID = PP.ID and PPTtotal.employeeID = PPT.employeeId)) as ctotlatimeemployee
From tblSales S
inner join tblsaleslines SL on S.saleID = SL.saleID
inner join tblproctree PT on PT.MasterId = SL.saleLineId and PT.mastertype <> 'mtProduct'
inner join tblProcessPart PP on PP.proctreeId = PT.proctreeId
inner join tblProcessStep PS on PP.processstepId = PS.id
inner join tblProcesstime PRT on PRT.ProcessPartID = PP.ID
inner join (tblprocessparttimesheet PPT inner join tblemployees E on PPT.employeeId = E.EmployeeId ) on PPT.ProcessPartID = PP.ID
where (:HideConverted ="F" or S.converted ="F") and  S.SAleDate between :datefrom and :Dateto and (:EmployeeID =0 or E.employeeId = :EmployeeID)
Order by SaleID, saleLineId, ProctreeID , ppid, employeename
*)

end.
