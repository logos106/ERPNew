unit frmReorderLevels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel, DateUtils,
  MySQLConst,Math, DateTimeUtils, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfmReorderLevels = class(TBaseListingGUI)
    qryMainLine: TWideStringField;
    qryMainJanuary: TFloatField;
    qryMainFebruary: TFloatField;
    qryMainMarch: TFloatField;
    qryMainApril: TFloatField;
    qryMainMay: TFloatField;
    qryMainJune: TFloatField;
    qryMainJuly: TFloatField;
    qryMainAugust: TFloatField;
    qryMainSeptember: TFloatField;
    qryMainOctober: TFloatField;
    qryMainNovember: TFloatField;
    qryMainDecember: TFloatField;
    btnOK: TDNMSpeedButton;
    qryWork: TERPQuery;
    WideStringField1: TWideStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    FloatField11: TFloatField;
    FloatField12: TFloatField;
    qryHistory: TERPQuery;
    dsHistory: TDataSource;
    qryHistoryDepartment: TWideStringField;
    qryHistorym0: TFloatField;
    qryHistorym1: TFloatField;
    qryHistorym2: TFloatField;
    qryHistorym3: TFloatField;
    qryHistorym4: TFloatField;
    qryHistorym5: TFloatField;
    qryHistorym6: TFloatField;
    qryHistorym7: TFloatField;
    qryHistorym8: TFloatField;
    qryHistorym9: TFloatField;
    qryHistorym10: TFloatField;
    qryHistorym11: TFloatField;
    qryMainProductId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainPrintProductName: TWideStringField;
    qryMainClassId: TIntegerField;
    qryMainDepartmentName: TWideStringField;
    qryHistoryProductId: TIntegerField;
    qryHistoryClassId: TIntegerField;
    ScrMain: TERPScript;
    cbSearchFields: TComboBox;
    btnReorder: TDNMSpeedButton;
    qryMainUseproductforecastformula: TWideStringField;
    qryMainDetails: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure actRefreshQryExecute(Sender: TObject);
    procedure grdMainDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainColEnter(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtSearchChange(Sender: TObject);
    procedure grdMainKeyPress(Sender: TObject; var Key: Char);
    procedure btnReorderClick(Sender: TObject);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure SctMainBeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure ScrMainAfterExecute(Sender: TObject; SQL: string);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
//    fProductId: integer;
//    fClassId: integer;
    fSelectedMonth: string;
    fDisplayingProgress: boolean;
    fsTableName : string;
    fsproductIds: String;
    fbdocancel:Boolean;
    procedure PrepareHistoryQuery;
    procedure CreateTempTable;
    procedure PopulateTempTable;
    procedure PopulateTempTableProduct(qry, qry1 : TERPQuery; AProductId : integer);
    procedure PopulateTempTableDepartment(qry : TERPQuery; AProductId, AClassId : integer; const ProdName : string);
    procedure PopulateHistoryLine(AProductId, AClassId : integer;const ProdName, DeptName : string);
    procedure UpdateHistoryLines;
    procedure FillSourceTable(qry : TERPQuery; AProductId, aClassId : integer);
    function LongMonthToIndex(const aMonth : string) : integer;
    function SavePoints(ASaveClass : boolean) : boolean;
    (*procedure BuildHistoryQuery(AProductId, aClassId : integer);*)
    function HistoryStartDate : TDateTime;
    procedure ReorderMainGrid;
    procedure BeforeShowReorderPoint(Sender : TObject);
    procedure DoCancelRefresh(Sender: Tobject);


    (*procedure DoShowProgressbar(ProgressCount: integer; ProgressBarCaption: string; ProgressBarMessage: string = ''; IsPercenage: boolean =true; AllowCancel :Boolean = False);
    procedure DoStepProgressbar(const ProgressBarMessage:String = '');Overload;
    procedure DoHideProgressbar;Overload;
    function GetProgressDialog: TProgressInfo;
    property ProgressDialog: TProgressInfo read GetProgressDialog;*)
    property DisplayingProgress : boolean read fDisplayingProgress write fDisplayingProgress;
    property SelectedMonth : string read fSelectedMonth write fSelectedMonth;
    Function ZeroWhenBlank(Const Value :String):String;
  protected

    procedure SetGridColumns; Override;
  public
    { Public declarations }
    procedure RefreshQuery;override;
    procedure UpdateMe; override; //(const Cancelled: boolean; const aObject: TObject = nil); override;
//    property ProductId : integer read fProductId write fProductId;
//    property ClassId : integer read fClassId write fClassId;
    procedure AttachObserver(const oObserver: TObject);
    Property productIds :String read fsproductIds write fsproductIds;
  end;

implementation

{$R *.dfm}
uses
  CommonLib, CommonFormLib, CommonDbLib, AppEnvironment, ObserverListObj, frmProductForecast,
  AppEnvironmentVirtual, LogLib, tcConst, PQALib, frmProductReorderPoints;

const
  (*csMainQry = 'SELECT ProductName, PrintProductName, DepartmentName, Line, January, February, March, April, May, June, July, August, September, October, November, December,'+
              'ProductId, ClassId FROM %s';*)
(*  csTempInsert = 'INSERT INTO %s (Line, January, February, March, April, May, June, July, August, September, October, November, December, '+
                 'ProductId, ClassId, DepartmentName, ProductName, Details) Values ('+
                 '"%s", %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %d, %d, "%s", "%s", %d);';*)

  CAP_SEARCH_NON_SEARCH = '"F5" (Full)';
  CAP_SEARCH_F5 = '"F5,F6,F7" (Full)';
  CAP_SEARCH_F6 = '"F5,F6,F7" (Starts with)';
  CAP_SEARCH_F7 = '"F5,F6,F7" (Like)';
type
  TPointLine = array[0..11] of string; //Double;
  TPointsArray = array[0..3] of TPointLine;
  TSaveArray = array[0..2] of array [0..11] of string;
const
  csLines : array[0..3] of string = ('Reorder Point', 'Preferred Level', 'Reorder Amount', 'Sales');
  csSaveMonths : TMonthArray = ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

function MonthToIndex(const aMonth : string) : integer;
var
  idx : integer;
begin
  for idx := 0 to 11 do
    if SameText(aMonth, csMonths[idx]) then
    begin
      Result := idx;
      exit;
    end;
  Result := -1;
end;
{ TfmReorderLevels }

procedure TfmReorderLevels.cmdCloseClick(Sender: TObject);
begin
  if qryMain.Connection.InTransaction then
    qryMain.Connection.Rollback;
  inherited;
//
end;

procedure TfmReorderLevels.CreateTempTable;
begin
  scrMain.SQL.Clear;
  scrMain.SQL.Add('DROP TABLE IF EXISTS ' + fsTableName + ';');
  scrMain.SQL.Add('CREATE TABLE ' + fsTableName);
  scrMain.SQL.Add('(Line varchar(30), January Double, February Double, March Double, April Double, May Double, June Double,');
  scrMain.SQL.Add('July Double, August Double, September Double, October Double, November Double, December Double,');
  scrMain.SQL.Add('ProductId int(11), ProductName varchar(60), PrintProductName varchar(255), ');
  scrMain.SQL.Add('ClassId INT(11), DepartmentName VARCHAR(40),Useproductforecastformula Enum("T","F") default "F" ,  Details INT(11)');
  scrMain.sql.Add(');');
  scrMain.Execute;
end;

(*procedure TfmReorderLevels.DoHideProgressbar;
begin
  if DisplayingProgress then
  begin
    ProgressDialog.CloseDialog;
    DisplayingProgress := false;
  end;
end;

procedure TfmReorderLevels.DoShowProgressbar(ProgressCount: integer;ProgressBarCaption, ProgressBarMessage: string; IsPercenage: boolean; AllowCancel :Boolean = False);
begin
  if DisplayingProgress then
  begin
    if ProgressBarCaption <> '' then
      ProgressDialog.Caption := ProgressBarCaption;
    if ProgressBarMessage <> '' then
      ProgressDialog.Message:= ProgressBarMessage;
    ProgressDialog.MaxValue := ProgressCount;
    ProgressDialog.minValue:= 0;
    ProgressDialog.Step := 1;
    ProgressDialog.ShowPercent := IsPercenage;
    ProgressDialog.AllowCancel := AllowCancel;
    ProgressDialog.Execute;
  end;
end;

procedure TfmReorderLevels.DoStepProgressbar(const ProgressBarMessage: String);
begin
  if DisplayingProgress then
  begin
    ProgressDialog.StepIt;
    if ProgressBarMessage <> '' then
      ProgressDialog.Message :=ProgressBarMessage;
  end;
end;  *)

procedure TfmReorderLevels.edtSearchChange(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmReorderLevels.PopulateHistoryLine(AProductId, AClassId: integer; const ProdName, DeptName : string);
begin

  if qryHistory.Locate('ProductId;ClassId', VarArrayOf([AProductId, aClassId]), []) then
    scrMain.SQL.Add('/*1*/INSERT INTO  ' + fsTableName+' set '+
              'Line = ' + Quotedstr(csLines[3])+','+
              'January = '  + IntToStr(qryHistory.FieldByName('m0').AsInteger)+','+
              'February ='  + IntToStr(qryHistory.FieldByName('m1').AsInteger) +','+
              'March ='     + IntToStr(qryHistory.FieldByName('m2').AsInteger) +','+
              'April ='     + IntToStr(qryHistory.FieldByName('m3').AsInteger) +','+
              'May ='       + IntToStr(qryHistory.FieldByName('m4').AsInteger) +','+
              'June ='      + IntToStr(qryHistory.FieldByName('m5').AsInteger) +','+
              'July ='      + IntToStr(qryHistory.FieldByName('m6').AsInteger) +','+
              'August ='    + IntToStr(qryHistory.FieldByName('m7').AsInteger) +','+
              'September =' + IntToStr(qryHistory.FieldByName('m8').AsInteger) +','+
              'October ='   + IntToStr(qryHistory.FieldByName('m9').AsInteger) +','+
              'November ='  + IntToStr(qryHistory.FieldByName('m10').AsInteger) +','+
              'December ='  + IntToStr(qryHistory.FieldByName('m11').AsInteger) +','+
              'ProductId =' + inttostr(AProductId) + ','+
              'ClassId = '  + IntTOstr(AClassId)+ ','+
              'DepartmentName = ' +quotedstr(qryHistory.FieldByName('Department').AsString) +','+
              'ProductName = ' +Quotedstr(ProdName) +','+
              'Details= 4; ')
  else
    scrMain.SQL.Add('/*1*/INSERT INTO  ' + fsTableName+' set '+
              'Line = ' + Quotedstr(csLines[3])+','+
              'January  = 0,'+
              'February = 0,'+
              'March    = 0,'+
              'April    = 0,'+
              'May      = 0,'+
              'June     = 0,'+
              'July     = 0,'+
              'August   = 0,'+
              'September= 0,'+
              'October  = 0,'+
              'November = 0,'+
              'December = 0,'+
              'ProductId= ' + inttostr(AProductId) + ','+
              'ClassId  = ' + IntTOstr(AClassId)   + ','+
              'DepartmentName = ' +quotedstr(DeptName) +','+
              'ProductName    = ' +Quotedstr(ProdName) +','+
              'Details= 4; ');
end;

procedure TfmReorderLevels.PopulateTempTable;
var
  qry2,
  qry1,
  qry : TERPQuery;
begin
  CreateTempTable;
  PrepareHistoryQuery;
  qry := TempMyQuery;
  try
    qry1 := TempMyQuery;
    try
      qry2 := TempMyQuery;
      try
        qry1.SQL.Text := 'select Count(*) from tblProductClasses C';
        qry1.SQL.add('left join tblreorderpoints P on  P.ProductId=C.Productid and c.ClassId=p.classid');
        qry1.SQL.add('inner join tblParts S on S.PartsId=C.Productid');
        qry1.SQL.add('where S.Active="T" and S.AutoReorder="T" and S.PartType="INV" and');
        qry1.SQL.add('P.ReOrderPoint is null');
        if ProductIDs <> '' then qry1.SQL.add('and S.partsId in (' +ProductIDs +')');
        qry1.Open;
        if (qry1.RecordCount > 0) and (qry1.Fields[0].AsInteger > 10) then
        begin
          // hope, 10 points will be filled quick enough not to bother about time. When it is more then 10, let's show
          // progress
           DisplayingProgress := true;
           //DoShowProgressBar(qry1.Fields[0].AsInteger, 'Prefilling ReorderPoints table');
           showProgressbar('Prefilling ReorderPoints table' , qry1.Fields[0].AsInteger, true , DoCancelRefresh);
        end else begin
          DisplayingProgress := true;
          //DoShowProgressBar(100, WAITMSG);
          showProgressbar(WAITMSG , 100, true , DoCancelRefresh);
        end;

        qry1.Close;
        qry1.SQL.Clear;

        qry2.SQL.Text := 'SELECT PartsId, PartName from tblParts where Active="T" and AutoReorder="T" and PartType="INV"';
        if ProductIDs <> '' then qry2.SQL.add('and partsId in (' +ProductIDs +')');
        qry2.sql.add('order by PartName');
        qry2.Open;
        while not(qry2.Eof) do
        begin
          PopulateTempTableProduct(qry, qry1, qry2.FieldByName('PartsId').AsInteger);
          if fbdocancel then break;
          qry2.Next;
        end;

      finally
        qry2.Free;
      end;
    finally
      qry1.Free;
    end;
  finally
   qry.Free;
   if DisplayingProgress then
     //DoHideProgressBar;
     HideProgressbar;
  end;
  fbdocancel := False;
end;
procedure TfmReorderLevels.DoCancelRefresh(Sender :Tobject);
begin
  fbdocancel := True;
  ListTimerMsg('List is incomplete - User Cancelled List Refresh' , nil, 30);
end;
procedure TfmReorderLevels.PopulateTempTableDepartment(qry : TERPQuery; AProductId,
  AClassId: integer; const ProdName : string);
var
  lPoints : TPointsArray;
  idx : integer;
  DepName : string;
begin
  fillchar(lPoints, SizeOf(lPoints), 0);
  try
    qry.SQL.Text := 'SELECT ClassName from tblProductClasses where ClassId=' + IntToStr(AClassId);
    qry.Open;
    DepName := qry.Fields[0].asString;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT OrderMonth, ReorderPoint, PreferredLevel, ReorderAmount from tblReorderPoints');
    qry.SQL.Add('where ProductId = ' + IntToStr(AProductId) + ' and ClassId = ' + IntToStr(AClassId));
    qry.SQL.Add('order by OrderMonth');
    qry.Open;
    if qry.RecordCount > 0 then
    begin
      while not qry.eof do
      begin
        idx := MonthToIndex(qry.FieldByName('OrderMonth').AsString);
        if idx >= 0 then
        begin
          lPoints[0][idx] := qry.FieldByName('ReorderPoint').AsString;
          lPoints[1][idx] := qry.FieldByName('PreferredLevel').AsString;
          lPoints[2][idx] := qry.FieldByName('ReorderAmount').AsString;
        end;
        qry.Next;
      end;
    end
    else
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select ReorderPoint, PreferredLevel, ReorderAmount from tblProductClasses');
      qry.SQL.Add('where ProductId = ' + IntToStr(AProductId) + ' and ClassId = ' + IntToStr(AClassId));
      qry.Open;
      if qry.RecordCount > 0 then
      begin
        for idx := 0 to 11 do
        begin
          lPoints[0][idx] := qry.FieldByName('ReorderPoint').AsString;
          lPoints[1][idx] := qry.FieldByName('PreferredLevel').AsString;
          lPoints[2][idx] := qry.FieldByName('ReorderAmount').AsString;
        end;
      end;
    end;

  finally
    qry.SQL.Clear;
    qry.Close;
  end;

  for idx := 0 to 2 do   begin
    scrMain.SQL.Add('/*3*/INSERT INTO  ' + fsTableName+' set '+
                                                  'Line     =' +quotedstr(csLines[idx])+','+
                                                  'January  = ' +(ZeroWhenBlank(lPoints[idx][0]))+','+
                                                  'February = ' +(ZeroWhenBlank(lPoints[idx][1]))+','+
                                                  'March    = ' +(ZeroWhenBlank(lPoints[idx][2]))+','+
                                                  'April    = ' +(ZeroWhenBlank(lPoints[idx][3]))+','+
                                                  'May      = ' +(ZeroWhenBlank(lPoints[idx][4]))+','+
                                                  'June     = ' +(ZeroWhenBlank(lPoints[idx][5]))+','+
                                                  'July     = ' +(ZeroWhenBlank(lPoints[idx][6]))+','+
                                                  'August   = ' +(ZeroWhenBlank(lPoints[idx][7]))+','+
                                                  'September= ' +(ZeroWhenBlank(lPoints[idx][8]))+','+
                                                  'October  = ' +(ZeroWhenBlank(lPoints[idx][9]))+','+
                                                  'November = ' +(ZeroWhenBlank(lPoints[idx][10]))+','+
                                                  'December = ' +(ZeroWhenBlank(lPoints[idx][11]))+','+
                                                  'ProductId= ' + inttostr(AProductId) + ','+
                                                  'ClassId  = ' + IntTOstr(AClassId)   + ','+
                                                  'DepartmentName = ' +quotedstr(DepName) +','+
                                                  'ProductName    = ' +Quotedstr(ProdName) +','+
                                                  'Details  = '+inttostr(idx+1)+'; ');
  end;
  PopulateHistoryLine(AProductId, AClassId, ProdName, DepName );
  scrMain.Execute;
end;

procedure TfmReorderLevels.PopulateTempTableProduct(qry, qry1 : TERPQuery; AProductId: integer);
var
  ProdName : string;
begin
  qry1.SQL.Text := 'select distinct PartsId, PartName, classId, className';
  qry1.SQL.Add('from tblparts P inner join  tblproductclasses C on C.ProductID=p.partsid where partsid=' + IntToStr(AProductId));
  qry1.Open;
  ProdName := qry1.FieldByName('PartName').AsString;
  try
    while not qry1.eof do
    begin
      scrMain.SQL.Clear;
      scrMain.SQL.Add('/*4*/Insert into ' + fsTableName + ' (ProductId, ClassId, ProductName, DepartmentName, Details) values ('+
                  IntToStr(AProductId)+',' +
                  qry1.FieldByName('ClassId').asString + ',' +
                  quotedstr(ProdName) + ','+
                  quotedstr(qry1.FieldByName('ClassName').AsString) + ','+
                  '1);');
      FillSourceTable(qry, AProductId, qry1.FieldByName('ClassId').asInteger);
      if fbdocancel then break;
      stepProgressbar('Preparing ' + ProdName);
      PopulateTempTableDepartment(qry, AProductId, qry1.FieldByName('ClassId').asInteger, ProdName);
      qry1.Next;
    end;
  finally
    qry1.Close;
    qry1.SQL.Clear;
  end;
end;

procedure TfmReorderLevels.PrepareHistoryQuery;
(*const
  csSqlLine = 'sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(If(PQA.TransDate between "%s" and "%s",PQA.Qty,0),0),0))) as m%d';*)
var
  idx : integer;
  dt : TDate;
  csSqlLine:String;
begin
  csSqlLine := 'sum(If(PQA.transdate between "%s" and "%s" , ' + SQL4QtyField(tTotSales )+',0))  as m%d';
  dt := HistoryStartDate;
  qryHistory.SQL.Clear;
  qryHistory.sql.Add('select Cls.ClassName as Department, CLS.ClassId, ');
  for idx := 0 to 11 do
  begin
    qryHistory.sql.add(Format(csSQLLine, [FormatDateTime(MySqlDatetimeFormat, dt), FormatDateTime(MySqlDateTimeFormat, EndOfTheMonth(dt)), idx])+',');
    dt := incMonth(dt, 1);
  end;
  qryHistory.sql.Add('PQA.ProductId');
  qryHistory.SQL.Add('from tblPQA PQA');
  qryHistory.SQL.Add('inner join tblClass CLS on PQA.DepartmentId = CLS.ClassId');
  qryHistory.SQL.Add('group by pqa.productid, cls.ClassId');
  qryHistory.Open;
end;

procedure TfmReorderLevels.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
    with scrmain do begin
      SQL.clear;
      SQL.add('update ' + fsTableName +' T inner join tblparts P on T.ProductId = P.partsId Set T.PrintProductName = P.ProductPrintName;');
      SQL.add('update ' + fsTableName +' T inner join tblproductclasses PC on T.ProductId = PC.ProductID and T.ClassId = PC.ClassID  '+
                      ' Set T.Useproductforecastformula = PC.Useproductforecastformula;');
      logtext(SQL.text);
      execute;
    end;
end;

procedure TfmReorderLevels.actRefreshQryExecute(Sender: TObject);
begin
  PopulateTempTable;
  inherited;
end;

procedure TfmReorderLevels.AttachObserver(const oObserver: TObject);
begin
  Assert(oObserver <> nil, 'TBaseInputGUI cannot attach a NIL object');
  ObserverList.Attach(oObserver, self);
end;

procedure TfmReorderLevels.BeforeShowReorderPoint(Sender: TObject);
begin
  if Sender is TfmProductReorderPoints then
  begin
    (Sender as TfmProductReorderPoints).ClassId := qryMain.FieldByName('ClassId').AsInteger;
    (Sender as TfmProductReorderPoints).ProductId := qryMain.FieldByName('ProductId').AsInteger;
  end;
end;

procedure TfmReorderLevels.btnOKClick(Sender: TObject);
begin
  inherited;

  qryMain.DisableControls;
  try
  if not SavePoints(TRUE) then
    exit;
  finally
    qryMain.EnableControls;
  end;
  qryMain.Connection.Commit;
  ObserverList.Notify(self, false);
  Close;
end;

procedure TfmReorderLevels.btnReorderClick(Sender: TObject);
begin
  inherited;
//
  OpenERPForm('TAutoReorderGUI',0);
end;

(*procedure TfmReorderLevels.BuildHistoryQuery(AProductId, aClassId : integer);
const
  csSqlLine = 'sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(If(PQA.TransDate between "%s" and "%s",PQA.Qty,0),0),0))) as m%d';
var
  idx : integer;
  dt : TDate;
begin

  dt := HistoryStartDate;
  qryHistory.SQL.Clear;
  qryHistory.sql.Add('select CLS.ClassName as Department, ');
  for idx := 0 to 11 do
  begin
    if idx = 0 then
      qryHistory.sql.add(Format(csSQLLine, [FormatDateTime(MySqlDateFormat, dt), FormatDateTime(MySqlDateFormat, EndOfTheMonth(dt)), idx]))
    else
      qryHistory.sql.add(',' + Format(csSQLLine, [FormatDateTime(MySqlDateFormat, dt), FormatDateTime(MySqlDateFormat, EndOfTheMonth(dt)), idx]));
    dt := incMonth(dt, 1);
  end;
  qryHistory.SQL.Add('from tblPQA PQA');
  qryHistory.SQL.Add('left join tblClass CLS on PQA.DepartmentId = CLS.ClassId');
  qryHistory.SQL.Add('where productid=' + IntToStr(AProductId) + ' and Cls.ClassId=' + IntToStr(AClassId));
end;*)

function TfmReorderLevels.SavePoints(ASaveClass : boolean) : boolean;
const
  csUpdate = 'UPDATE tblReorderPoints set';
  csUpdateClasses = 'UPDATE tblProductClasses SET ReorderPoint=%s, PreferredLevel=%s, ReOrderAmount=%s'#13#10 +
                    'WHERE ProductId=%d AND ClassId=%d';
var
  idx : integer;
  lPoints : TSaveArray;
  OldState : boolean;

  procedure SetLine(aNo : integer);
  var
    i : integer;
  begin
    for i := 0 to 11 do
      lPoints[aNo][i] := qryMain.FieldByName(csSaveMonths[i]).AsString;
  end;
begin
  inherited;
  Result := true;
  //doShowProgressbar(100 , WAITMSG);
  showProgressbar(WAITMSG , 100);
  try

      if qryMain.State = dsEdit then qryMain.Post;

      qryMain.First;
      while not qryMain.Eof do begin
      (*while not qryMain.Eof do
          if (qryMain.FieldByName('Line').IsNull) or (qryMain.FieldByName('Line').AsString = csLines[3]) then
            qryMain.Next
          else
            Break; *)
        while not qryMain.Eof do
          if (qryMain.FieldByName('Line').IsNull) or (qryMain.FieldByName('Line').AsString <> csLines[0]) then qryMain.Next
          else Break;

        if qryMain.Eof then exit;


        idx := 0;
        while (not (qryMain.Eof)) and (idx < 3) do begin
          SetLine(idx);
          qryMain.Next;
          inc(idx);
        end;

        scrMain.Sql.Clear;
        for idx := 0 to 11 do begin
          scrMain.SQL.Add('UPDATE tblReorderPoints SET');
          scrMain.SQL.Add('ReorderPoint=' + lPoints[0][idx] + ',');
          scrMain.SQL.Add('PreferredLevel=' + lPoints[1][idx] + ',');
          scrMain.SQL.Add('ReorderAmount=' + lPoints[2][idx]);
          scrMain.SQL.Add(Format('WHERE ProductId=%d and ClassId=%d and OrderMonth="%s";',
                          [qryMain.FieldByName('ProductId').AsInteger, qryMain.FieldByName('ClassId').asInteger, csMonths[idx]]));
        end;
        scrMain.Execute;
        DoStepProgressbar;
      end;
  finally
    //DoHideProgressbar;
    HideProgressbar;
  end;

  if not ASaveClass then
    Exit;

  if SelectedMonth = '' then
  begin
    if MessageDlgXP_Vista('Month To Be Used For Reorder Has Not Been Selected.'#13#10 +
                          'Do You Want To Use Values For The Current Month?', mtWarning, [mbYes, mbNo], 0) = mrNo then
    begin
      CommonLib.MessageDlgXP_Vista('Please Select the Month To Be Used For Reorder', mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end
    else
      SelectedMonth := csSaveMonths[MonthOf(Date) - 1];
  end;

  // lPoints array was already build
  idx := LongMonthToIndex(SelectedMonth);

  scrMain.SQL.Clear;
  scrMain.SQL.Text := 'update tblProductClasses';
  scrMain.SQL.Add('inner join tblReorderPoints on tblReorderPoints.ProductId=tblProductClasses.ProductId and tblReorderPoints.ClassId=tblProductClasses.ClassId');
  scrMain.SQL.Add('Set tblProductClasses.ReorderPoint=tblReorderPoints.ReorderPoint,');
  scrMain.SQL.Add('tblProductClasses.PreferredLevel=tblReorderPoints.PreferredLevel,');
  scrMain.SQL.Add('tblProductClasses.ReorderAmount=tblReorderPoints.ReorderAmount');
  scrMain.SQL.Add('where tblReorderPoints.OrderMonth = ' + quotedstr(csMonths[idx]) + ';');
  OldState := scrMain.Connection.InTransaction;
  try
    scrMain.Execute;
  finally
    if not OldState then
      scrMain.Connection.Commit;
  end;
end;

procedure TfmReorderLevels.ScrMainAfterExecute(Sender: TObject; SQL: string);
begin
  inherited;
  dostepProgressbar;
end;

procedure TfmReorderLevels.SctMainBeforeExecute(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  inherited;
  logtext(SQL );
end;

procedure TfmReorderLevels.SctMainError(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  inherited;
  Logtext(SQL);
  Logtext(E.message);
  action := eaContinue;
end;

procedure TfmReorderLevels.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainProductId.fieldname);
  RemoveFieldfromGrid(qryMainClassId.fieldname);
  RemoveFieldfromGrid(qryMainDetails.fieldname);
end;

procedure TfmReorderLevels.UpdateHistoryLines;
var
  idx : integer;
  dt : TDate;
begin
  qryHistory.Close;
  PrepareHistoryQuery;
  while not qryHistory.eof do
  begin
    if qryMain.Locate('ProductId;ClassId;Line',
       VarArrayOf([qryHistory.FieldByName('ProductId').AsInteger,qryHistory.FieldByName('ClassId').AsInteger, csLines[3]]), []) then
    begin
      dt := HistoryStartDate;
      qryMain.Edit;
      for idx := 0 to 11 do
      begin
//        qryMain.FieldByName(csSaveMonths[idx]).AsString := qryHistory.FieldByName('m' + IntToStr(idx)).AsString;
        qryMain.FieldByName(csSaveMonths[MonthOf(dt) - 1]).asString := qryHistory.FieldByName('m' + IntToStr(idx)).AsString;;
        dt := IncMonth(dt, 1);
      end;
      qryMain.Post;
    end;
    qryHistory.Next;
  end;

  //ReorderMainGrid;
end;

procedure TfmReorderLevels.UpdateMe;
begin
  inherited;
  actRefreshQryExecute(Self);
end;

function TfmReorderLevels.ZeroWhenBlank(const Value: String): String;
begin
  result := Value;
  if Trim(REsult) ='' then result := '0';
end;

procedure TfmReorderLevels.FillSourceTable(qry : TERPQuery; AProductId, AClassId : integer);
const
  csWhere = 'where ProductId=%d and ClassId=%d';
  csInsert = 'INSERT INTO tblReorderPoints (ProductId, ClassId, ReorderPoint, PreferredLevel, ReorderAmount, OrderMonth)' +
             'Values(%d, %d, %s, %s, %s,';
var
  idx : integer;
  lWhere : string;
  lInsert : string;
begin
    lWhere := Format(csWhere, [AProductId, AClassId]);
    qry.sql.text := 'SELECT * from tblReorderPoints ' + lWhere;
    qry.Open;
    if not qry.eof then
      exit;
    qry.Close;
    qry.sql.clear;
    qry.sql.add('select ReorderPoint, PreferredLevel, ReorderAmount from tblproductClasses');
    qry.sql.add(lWhere);
    qry.Open;
    lInsert := Format(csInsert, [AProductId, AClassId,
    qry.FieldByName('ReorderPoint').AsString,
    qry.FieldByName('PreferredLevel').AsString,
    qry.FieldByName('ReorderAmount').AsString]);
    for idx := 0 to 11 do
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add(lInsert);
      qry.SQL.Add('' + quotedstr(csMonths[idx]) + ')');
      qry.ExecSQL;

    end;
    qry.Close;
end;

procedure TfmReorderLevels.FormCreate(Sender: TObject);
begin
  fbdocancel:= False;
  fsproductIds :='';
  clog('');
  fsTablename := GetUserTemporaryTableName('reorderpoints');
  qryMain.SQL.Clear;
  qryMain.SQL.Text := 'Select * from ' +fsTablename ;// Format(csMainqry, [fsTablename]);
  inherited;

end;

procedure TfmReorderLevels.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  if qryMain.Connection.InTransaction then
    qryMain.Connection.Rollback;
  inherited;
end;

procedure TfmReorderLevels.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  FieldName : string;

  function CanSearch : boolean;
  begin
    Result := (edtSearch.Text <> '') and (cbSearchFields.Text <> '') and
              (sameText(cbSearchFields.Text, 'Department') or SameText(cbSearchFields.Text, 'Product'));
    if sameText(cbSearchFields.Text, 'Department') then
      FieldName := 'DepartmentName'
    else
      FieldName := 'ProductName';

  end;
begin
  if not (Key in [VK_F5, VK_F6, VK_F7])  then
  begin
    inherited;
    exit;
  end;

  if not CanSearch then
    Key := VK_F5;
  qryMain.SQL.Text := 'Select * from ' +fsTablename;//Format(csMainqry, [fsTablename]);
  try
    if (Key = VK_F7) then
    begin
      SearchMode := smSearchEngineLike;
      lblSearchoptions.Caption := CAP_SEARCH_F7;
      GuiPrefs.Node['SearchMode.type'].asString := 'Like';
      qryMain.sql.Add('WHERE ' +  {grdMain.ColumnByName(cbSearchFields.Text).FieldName} FieldName + ' LIKE ' +quotedstr('%' + edtSearch.Text + '%'));
    end else
    if (Key = VK_F6) then
    begin
      SearchMode := smSearchEngine;
      lblSearchoptions.Caption := CAP_SEARCH_F6;
      GuiPrefs.Node['SearchMode.type'].asString := 'StartsWith';
      qryMain.sql.Add('WHERE ' + { grdMain.ColumnByName(cbSearchFields.Text).FieldName} FieldName + ' LIKE ' + quotedstr(edtSearch.Text + '%'));
    end else
    if (Key = VK_F5) then
    begin
      SearchMode := smFullList; // it takes previous sql...
      lblSearchoptions.Caption := CAP_SEARCH_F5;
      GuiPrefs.Node['SearchMode.type'].asString := 'Full';
      // Need to fix sql again
      qryMain.SQL.Text := 'Select * from ' +fsTablename;//Format(csMainqry, [fsTablename]);
      //QueryManipulationObj.RefreshOrignalSQL(qryMain.SQL.Text);
//      RefreshQuery;
    end;
  finally
    QueryManipulationObj.RefreshOrignalSQL(qryMain.SQL.Text);
    RefreshQuery;
  end;
end;

procedure TfmReorderLevels.FormShow(Sender: TObject);
begin
  qryMain.DisableControls;
  try
    PopulateTempTable;
    QueryManipulationObj.RefreshOrignalSQL(qryMain.SQL.Text);
    SearchMode := smFullList;
    qryMain.Connection.StartTransaction;

    inherited;
    TitleLabel.Caption := 'Reorder Levels';
    (*!!!!!!!!!!!!!!
    HeaderPanel.Height := HeaderPanel.Height - Panel3.Height;
    Panel3.Visible := false;
    // Have to, since otherwise pnlHeader.height is left to be 19...
    pnlHeader.Height := TitleLabel.Canvas.TextHeight('R') + 6;
    !!!!!!!!!!!!!!!*)
    qryMainLine.DisplayLabel := 'Value';
    qryMainLine.DisplayWidth := 20;
    dtFrom.Date := IncMonth(Date, -6);  // half year back
    dtTo.Date := IncYear(dtFrom.Date, 1);
//  dtFrom.Date := Date;  // current
//  dtTo.Date := IncYear(dtFrom.Date, 1); // forweard one year
    chkIgnoreDates.Checked := true;
    grdMain.Height := panel1.Height - 24;

    qryMain.First;
    lblSearchoptions.Caption := CAP_SEARCH_F5;
//    cboFilter.Text := 'Product';
    cbSearchFields.Items.Add('Product');
    cbSearchFields.Items.Add('Department');
    cbSearchFields.Left := cboFilter.Left;
    cbSearchFields.Top := cboFilter.Top;
    cbSearchFields.Width := cboFilter.Width;
    cbSearchFields.Height := cboFilter.Height;
    cbSearchFields.OnChange := nil;
    cbSearchFields.OnExit := nil;
    cbSearchFields.OnKeyPress := nil;

    cbSearchFields.ItemIndex := 0;
    cboFilter.Visible := false;
  finally
    qryMain.EnableControls;
    qryMainProductId.ReadOnly := true;
    qrymainClassId.ReadOnly := true;
    //ReorderMainGrid;
  end;

end;

(*function TfmReorderLevels.GetProgressDialog: TProgressInfo;
begin
  result := TProgressInfo(AppEnvVirt.Obj['ProgressInfo']);
end;*)

procedure TfmReorderLevels.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
var
  m : word;
begin
  inherited;
//
  m := MonthOf(Date);
  if Field.DisplayLabel = csSaveMonths[m-1] then
    ABrush.Color := GridColhighLightGreen
  else if (sametext(Field.FieldName,'DEPARTMENTNAME')) or
          (sametext(Field.FieldName,'PrintProductName')) or
          (sametext(Field.FieldName,'Useproductforecastformula')) or
          (sametext(Field.FieldName,'PRODUCTNAME')) then
    ABrush.Color := Self.Brush.Color;

  if (sametext(Field.FieldName,'DEPARTMENTNAME')) or
          (sametext(Field.FieldName,'PrintProductName')) or
          (sametext(Field.FieldName,'Useproductforecastformula')) or
          (sametext(Field.FieldName,'PRODUCTNAME')) then
  if (Qrymaindetails.asinteger =1) and (TRim(Qrymainline.asString) ='') then else
    Afont.color := ABrush.Color ;
end;

procedure TfmReorderLevels.grdMainColEnter(Sender: TObject);
begin
  if SameText(ActiveFieldName, 'ProductName') then
    cbSearchFields.ItemIndex := 0
  else if SameText(ActiveFieldName, 'DepartmentName') then
    cbSearchFields.ItemIndex := 1;
end;

procedure TfmReorderLevels.grdMainDblClick(Sender: TObject);
var
  lMonth : string;
begin
  if (grdMain.GetActiveField <> nil) and //not empty(grdMain.GetActiveField.asString) then
     (grdMain.GetActiveField.Index > 0) then
  begin
    lMonth := grdMain.GetActiveField.DisplayLabel;
    if LongMonthToIndex(lMonth) >= 0 then
    begin
      if CommonLib.MessageDlgXP_Vista('Do You Want To Use ' + lMonth + ' As a Base For Reordering?', mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        SelectedMonth := lMonth;
        btnOkClick(Self);
      end
      else
        inherited;
    end
    else
    begin
      lMonth := UpperCase(grdMain.GetActiveField.FieldName);
      if (qryMain.FieldByName('ProductId').IsNull) or
         (qryMain.FieldByName('ClassId').IsNull) then
      begin
        inherited;
        exit;
      end;
      if (pos('DEPARTMENT', lMonth) > 0) or
         (pos('PRODUCT', lMonth) > 0) or
         (lMonth='LINE') then
      begin
        OpenERPFormModal('frmProductReorderPoints' , qryMain.FieldByName('ProductId').AsInteger, beforeshowReorderPoint);
        (*if FormStillOpen('TfmReorderPoints') then
        begin
          lForm := GetComponentByClassName('TfmReorderPoints');
          BeforeShowReorderPoint(lForm);
          TForm(lForm).OnShow(self);
          TForm(lForm).BringToFront;
        end
        else
          OpenErpListForm('TfmReorderPoints' , beforeshowReorderPoint);*)
      end
      else
        inherited;
    end;
  end
  else
    inherited;
//
end;

procedure TfmReorderLevels.grdMainDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  inherited;
  if SameText(Field.FieldName, 'DepartmentName') then
  begin
    grdMain.Canvas.Brush.Color := Self.Canvas.Brush.Color;
    if not qryMain.FieldByName('January').isNull then
    begin
      grdMain.Canvas.FillRect(Rect);  // Clear grid rect
    end;
  end
  else if SameTExt(Field.FieldName, 'ProductName') then
  begin
    grdMain.Canvas.Brush.Color := Self.Canvas.Brush.Color;
    if not qryMain.FieldByName('January').isNull then
      grdMain.Canvas.FillRect(Rect);

  end;

end;

procedure TfmReorderLevels.grdMainKeyPress(Sender: TObject; var Key: Char);
begin
  // Want to be able to edit grid.- changed the standard behaviour!!
  if SameText(ActiveFieldName, 'DepartmentName') or SameTExt(ActiveFieldName, 'ProductName') or
     SameTExt(ActiveFieldName, 'Line') then
     inherited
  else if not CharInSet(Key, ['0'..'9', '.']) then
    inherited;
end;

procedure TfmReorderLevels.grdMainTitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
//  inherited;
  if LongMonthToIndex(AFieldName) >= 0 then
    SelectedMonth := AFieldName;
end;

function TfmReorderLevels.HistoryStartDate: TDateTime;
begin
  if chkIgnoreDates.Checked then
    Result := StartOfTheMonth(IncMonth(Date, -12))
  else
    Result := StartOfTheMonth(dtFrom.Date);
end;

function TfmReorderLevels.LongMonthToIndex(const aMonth: string): integer;
var
  idx : integer;
begin
  for idx := 0 to 11 do
    if SameText(csSaveMonths[idx], aMonth) then
    begin
      Result := idx;
      exit;
    end;
  Result := -1;
end;

procedure TfmReorderLevels.ReorderMainGrid;
var
  lMonth : integer;
  idx : integer;

begin

  lMonth := MonthOf(HistoryStartDate);
  for idx  := 0 to 11 do
  begin
    grdMain.ColumnByName(csSaveMonths[lMonth-1]).Index := idx + 3;
    lMonth := lMonth + 1;
    if lMonth > 12 then
      lMonth := 1;
  end;
end;

procedure TfmReorderLevels.RefreshQuery;
begin
  inherited;
  UpdateHistoryLines;
end;


initialization
  RegisterClassOnce(TfmReorderLevels);
end.
