unit BOMSaleResourceCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TBOMSaleResourceCheckGUI = class(TBaseListingGUI)
    qryMainsaleId: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMainshipped: TFloatField;
    qryMaincaption: TWideStringField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainDuration: TFloatField;
    qryMainProcesstep: TWideStringField;
    qryMainProcesstepSeq: TIntegerField;
    qryMainResourcename: TWideStringField;
    qryMainREsourceDetailname: TWideStringField;
    qryMainRescourcecount: TLargeintField;
    qryMaintotaltimerequired: TFloatField;
    qryMainstotaltimerequired: TWideStringField;
    qryMaintotalhoursperweek: TTimeField;
    qryMainSunday: TWideStringField;
    qryMainSundayStartAt: TTimeField;
    qryMainSundayCapacityHoursDay: TFloatField;
    qryMainfSundayCapacityHoursDay: TTimeField;
    qryMainmonday: TWideStringField;
    qryMainmondayStartAt: TTimeField;
    qryMainmondayCapacityHoursDay: TFloatField;
    qryMainfmondayCapacityHoursDay: TTimeField;
    qryMainTuesday: TWideStringField;
    qryMainTuesdayStartAt: TTimeField;
    qryMainTuesdayCapacityHoursDay: TFloatField;
    qryMainfTuesdayCapacityHoursDay: TTimeField;
    qryMainWednesday: TWideStringField;
    qryMainWednesdayStartAt: TTimeField;
    qryMainWednesdayCapacityHoursDay: TFloatField;
    qryMainfWednesdayCapacityHoursDay: TTimeField;
    qryMainThursday: TWideStringField;
    qryMainThursdayStartAt: TTimeField;
    qryMainThursdayCapacityHoursDay: TFloatField;
    qryMainfThursdayCapacityHoursDay: TTimeField;
    qryMainFriday: TWideStringField;
    qryMainFridayStartAt: TTimeField;
    qryMainFridayCapacityHoursDay: TFloatField;
    qryMainfFridayCapacityHoursDay: TTimeField;
    qryMainSaturday: TWideStringField;
    qryMainSaturdayStartAt: TTimeField;
    qryMainSaturdayCapacityHoursDay: TFloatField;
    qryMainfSaturdayCapacityHoursDay: TTimeField;
    qryMainWeeksrequired: TFloatField;
    qryMainEstimatedDateen: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fiSaleId: Integer;
    fiSaleLineID: Integer;
    fsTablename :String;
    procedure SetSaleID(const Value: Integer);
    procedure SetSaleLineID(const Value: Integer);
    procedure Showtitle;
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
  public
    Property SaleID :Integer read fiSaleId write SetSaleID;
    Property SaleLineID :Integer read fiSaleLineID write SetSaleLineID;

    Procedure ReFreshQuery;Override;
  end;


implementation

uses DbSharedObjectsObj, CommonLib, CommonDbLib;

{$R *.dfm}

{ TBOMSaleResourceCheckGUI }

procedure TBOMSaleResourceCheckGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('BOMSaleCheck');
  Qrymain.sql.clear;
  Qrymain.sql.add('Select');
  Qrymain.sql.add('*');
  Qrymain.sql.add('from');
  Qrymain.sql.add(fstablename);
  Qrymain.sql.add('Order by SequenceDown, productname');
  inherited;
end;

procedure TBOMSaleResourceCheckGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fstablename);
  inherited;

end;

procedure TBOMSaleResourceCheckGUI.ReFreshQuery;
var
  scr :TERPScript;
begin
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    scr.SQL.clear;
    scr.SQL.AdD('DROP TABLE if EXISTS '+ fstablename +';');
    scr.SQL.AdD('CREATE TABLE '+ fstablename +'');
    scr.SQL.AdD('SELECT');
    scr.SQL.AdD('s.saleId, SL.saleLineId,');
    scr.SQL.AdD('PT.SequenceDown, sl.productname,');
    scr.SQL.AdD('Sl.shipped,');
    scr.SQL.AdD('TreeNodeCaption(PT.Level, PT.Caption) caption,');
    scr.SQL.AdD('PT.ManufactureUOMQty, PP.Duration,');
    scr.SQL.AdD('PS.Description Processtep,');
    scr.SQL.AdD('PP.ProcessStepSeq ProcesstepSeq,');
    scr.SQL.AdD('PR.Description AS Resourcename,');
    scr.SQL.AdD('group_concat(PRDt.Description) AS REsourceDetailname,');
    scr.SQL.AdD('COUNT(PRDt.ID) AS Rescourcecount,');
    scr.SQL.AdD('PT.ManufactureUOMQty* PP.Duration totaltimerequired,');
    scr.SQL.AdD('SEC_TO_TIME(PT.ManufactureUOMQty* PP.Duration) stotaltimerequired,');
    scr.SQL.AdD('SEC_TO_TIME(COUNT(PRDt.ID) *(if(PRD.Sunday="T", PRD.SundayCapacityHoursDay, 0)+');
    scr.SQL.AdD('if(PRD.monday    ="T", PRD.mondayCapacityHoursDay    , 0)+');
    scr.SQL.AdD('if(PRD.Tuesday   ="T", PRD.TuesdayCapacityHoursDay   , 0)+');
    scr.SQL.AdD('if(PRD.Wednesday ="T", PRD.WednesdayCapacityHoursDay , 0)+');
    scr.SQL.AdD('if(PRD.Thursday  ="T", PRD.ThursdayCapacityHoursDay  , 0)+');
    scr.SQL.AdD('if(PRD.Friday    ="T", PRD.FridayCapacityHoursDay    , 0)+');
    scr.SQL.AdD('if(PRD.Saturday  ="T", PRD.SaturdayCapacityHoursDay  , 0))) AS totalhoursperweek,');
    scr.SQL.AdD('PRD.Sunday		, PRD.SundayStartAt		,PRD.SundayCapacityHoursDay		,SEC_TO_TIME(PRD.SundayCapacityHoursDay	  ) AS fSundayCapacityHoursDay    ,');
    scr.SQL.AdD('PRD.monday		, PRD.mondayStartAt		,PRD.mondayCapacityHoursDay		,SEC_TO_TIME(PRD.mondayCapacityHoursDay	  ) AS fmondayCapacityHoursDay    ,');
    scr.SQL.AdD('PRD.Tuesday	, PRD.TuesdayStartAt	,PRD.TuesdayCapacityHoursDay	,SEC_TO_TIME(PRD.TuesdayCapacityHoursDay	) AS fTuesdayCapacityHoursDay   ,');
    scr.SQL.AdD('PRD.Wednesday, PRD.WednesdayStartAt,PRD.WednesdayCapacityHoursDay,SEC_TO_TIME(PRD.WednesdayCapacityHoursDay) AS fWednesdayCapacityHoursDay ,');
    scr.SQL.AdD('PRD.Thursday	, PRD.ThursdayStartAt	,PRD.ThursdayCapacityHoursDay	,SEC_TO_TIME(PRD.ThursdayCapacityHoursDay	) AS fThursdayCapacityHoursDay  ,');
    scr.SQL.AdD('PRD.Friday		, PRD.FridayStartAt		,PRD.FridayCapacityHoursDay		,SEC_TO_TIME(PRD.FridayCapacityHoursDay	  ) AS fFridayCapacityHoursDay    ,');
    scr.SQL.AdD('PRD.Saturday	, PRD.SaturdayStartAt	,PRD.SaturdayCapacityHoursDay	,SEC_TO_TIME(PRD.SaturdayCapacityHoursDay	) AS fSaturdayCapacityHoursDay  ');
    scr.SQL.AdD('FROM tblsales S');
    scr.SQL.AdD('INNER JOIN tblsaleslines SL            ON S.saleId           = SL.saleId');
    scr.SQL.AdD('INNER JOIN tblproctree PT              ON PT.MasterId        = SL.SaleLineID AND PT.MasterType <> "mtProduct"');
    scr.SQL.AdD('INNER JOIN tblprocesspart PP           ON PT.ProcTreeId      = PP.ProcTreeId');
    scr.SQL.AdD('INNER JOIN tblprocessstep PS           ON PP.ProcessStepID   = PS.ID');
    scr.SQL.AdD('LEFT  JOIN tblprocresourceprocess PRP  ON PRP.ProcessStepId  = PS.ID');
    scr.SQL.AdD('LEFT  JOIN tblprocresource PR          ON PRP.ProcResourceId = PR.ProcResourceId AND PR.ResourceAvailable <> "F"');
    scr.SQL.AdD('LEFT  JOIN tblprocresourcedays PRD     ON PRD.ProcResourceID = PR.ProcResourceId');
    scr.SQL.AdD('LEFT  JOIN tblprocresourcedetails PRDt ON PRDt.ProcResourceId= PR.ProcResourceId AND PRDt.ResourceAvailable <> "F"');
    scr.SQL.AdD('WHERE s.saleId <>0');
    if saleID     <> 0 then scr.SQL.AdD('AND S.saleId = '     + inttostr(SaleID));
    if SaleLineID <> 0 then scr.SQL.AdD('AND SL.SaleLineID = '+ inttostr(SaleLineID));
    scr.SQL.AdD('GROUP BY PT.ProcTreeId, PP.ID, PR.ProcResourceId');
    scr.SQL.AdD('HAVING PT.ManufactureUOMQty <>0');
    scr.SQL.AdD('Order BY SL.saleLineId, PT.SequenceDown;');
    scr.SQL.AdD('ALTER TABLE '+ fstablename +' ADD COLUMN Weeksrequired DOUBLE;');
    scr.SQL.AdD('UPDATE '+ fstablename +' SET Weeksrequired = totaltimerequired / totalhoursperweek ;');
    scr.SQL.AdD('ALTER TABLE '+ fstablename +' ADD COLUMN EstimatedDateen DATETIME;');
    scr.SQL.AdD('UPDATE '+ fstablename +' SET EstimatedDateen = DATE_ADD(CURDATE(),INTERVAL Weeksrequired Week);');
    scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
  closedb(Qrymain);
  inherited;
end;

procedure TBOMSaleResourceCheckGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainsaleLineId.fieldname);
    RemoveFieldfromGrid(qryMaintotaltimerequired.fieldname);
    RemoveFieldfromGrid(qryMainProcesstepSeq.fieldname);
    RemoveFieldfromGrid(qryMainSundayCapacityHoursDay.fieldname);
    RemoveFieldfromGrid(qryMainmondayCapacityHoursDay.fieldname);
    RemoveFieldfromGrid(qryMainTuesdayCapacityHoursDay.fieldname);
    RemoveFieldfromGrid(qryMainWednesdayCapacityHoursDay.fieldname);
    RemoveFieldfromGrid(qryMainThursdayCapacityHoursDay.fieldname);
    RemoveFieldfromGrid(qryMainFridayCapacityHoursDay.fieldname);
    RemoveFieldfromGrid(qryMainSaturdayCapacityHoursDay.fieldname);
end;

procedure TBOMSaleResourceCheckGUI.SetSaleID(const Value: Integer);
begin
  fiSaleId := Value;
  Showtitle;
end;

procedure TBOMSaleResourceCheckGUI.SetSaleLineID(const Value: Integer);
begin
  fiSaleLineID := Value;
  Showtitle;
end;
procedure TBOMSaleResourceCheckGUI.Showtitle;
var
  qry: TERPQuery;
  fs:String;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closeDB(Qry);
    Qry.SQl.clear;
    Qry.SQl.add('Select S.saleId, SL.Productname '+
                ' from tblsales S  '+
                ' left join tblSalesLines SL on S.saleId = SL.saleId  and SL.saleLineId=' + inttostr(saleLineId)+
                ' where (S.saleID =' + inttostr(SaleID)+' or ('+inttostr(SaleID)+' =0 and '+ inttostr(SaleLineID)+' <> 0))');
    Qry.Open;
    fs:='Sale # ' + inttostr(Qry.Fieldbyname('SaleID').asInteger);
    if Qry.Fieldbyname('Productname').asString <> '' then fs:= fs+' ('+Qry.Fieldbyname('Productname').asString +')';
    TitleLabel.caption := fs;
    Self.caption := fs;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

initialization
  RegisterClassOnce(TBOMSaleResourceCheckGUI);

end.
