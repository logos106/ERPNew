unit frmProductReorderPoints;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMPanel, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdblook, DNMSpeedButton, Shader, Mask, DBCtrls, wwdbdatetimepicker;

type
  TfmProductReorderPoints = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    dsReorderLevels: TDataSource;
    QryReorderLevels: TERPQuery;
    QryReorderLevelsLine: TWideStringField;
    QryReorderLevelsJanuary: TFloatField;
    QryReorderLevelsFebruary: TFloatField;
    QryReorderLevelsMarch: TFloatField;
    QryReorderLevelsApril: TFloatField;
    QryReorderLevelsMay: TFloatField;
    QryReorderLevelsJune: TFloatField;
    QryReorderLevelsJuly: TFloatField;
    QryReorderLevelsAugust: TFloatField;
    QryReorderLevelsSeptember: TFloatField;
    QryReorderLevelsOctober: TFloatField;
    QryReorderLevelsNovember: TFloatField;
    QryReorderLevelsDecember: TFloatField;
    qryHistory: TERPQuery;
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
    qryHistoryClassId: TIntegerField;
    dsHistory: TDataSource;
    Panel2: TPanel;
    lblcheck2: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Horizontal1: TSplitter;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    pnlHistory: TDNMPanel;
    lblSaleshistory: TLabel;
    grdHistory: TwwDBGrid;
    btnOK: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    btnAdjsut: TDNMSpeedButton;
    btnRequery: TDNMSpeedButton;
    btnReorder: TDNMSpeedButton;
    Panel5: TPanel;
    Label4: TLabel;
    dsProductnClass: TDataSource;
    QryProductnClass: TERPQuery;
    QryProductnClassPARTNAME: TWideStringField;
    QryProductnClassClassName: TWideStringField;
    DBEdit2: TDBEdit;
    Panel3: TPanel;
    lblDepartment: TLabel;
    DBEdit3: TDBEdit;
    lblTo: TLabel;
    dtFrom: TwwDBDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdMainDblClick(Sender: TObject);
    procedure grdHistoryCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnAdjsutClick(Sender: TObject);
    procedure btnRequeryClick(Sender: TObject);
    procedure btnReorderClick(Sender: TObject);
    procedure qryHistoryAfterScroll(DataSet: TDataSet);
    procedure qryHistoryAfterOpen(DataSet: TDataSet);
    procedure dtFromChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    OnHistoryRecChange:boolean;
    fProductId: integer;
    fClassId: integer;
    fSelectedMonth: string;
    fsTableName : string;
    //fdHistoryStartDate: TDateTime;
    procedure CreateTempTable;
    procedure InitProductForecast(Sender: TObject);
    procedure RefreshQuery;
    procedure PopulateTempTable;
    function LongMonthToIndex(const aMonth : string) : integer;
    function SavePoints(ASaveClass : boolean) : boolean;
    procedure BuildHistoryQuery;
    procedure RefreshHistory;

    procedure ReorderMainGrid;

    procedure ReadnApplyGuiPref;
    Procedure WriteGuiPref;
    Function HistoryStartDate :TDatetime;
    Procedure LockTables;
    Procedure UnlockTables;
  public
    //Property HistoryStartDate : TDateTime read fdHistoryStartDate write fdHistoryStartDate;
    property SelectedMonth : string read fSelectedMonth write fSelectedMonth;
    property ProductId : integer read fProductId write fProductId;
    property ClassId : integer read fClassId write fClassId;
  end;


implementation

uses CommonLib, CommonDbLib, CommonFormLib, DbSharedObjectsObj, DateTimeUtils,
  DateUtils,MySQLConst, PQALib, AppEnvironment, LogLib, frmProductForecast,
  tcDataUtils, FastFuncs;
type
  TPointLine = array[0..11] of string;
  TPointsArray = array[0..3] of TPointLine;
  TSaveArray = array[0..2] of array [0..11] of string;

const
  csLines : array[0..2] of string = ('Reorder Point', 'Preferred Level', 'Reorder Amount');
  csSaveMonths : TMonthArray = ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

function IndexToMonth(const aIndex :Integer) : String;
begin
  Result := '';
  if aindex <= high(csMonths) then Result := csMonths[aIndex];
end;
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


{$R *.dfm}
procedure TfmProductReorderPoints.btnOKClick(Sender: TObject);
begin
  inherited;
  if not SavePoints(TRUE) then exit;

  CommitTransaction;
  Close;
end;

procedure TfmProductReorderPoints.btnReorderClick(Sender: TObject);
begin
  inherited;
  CommitTransaction;
  try
    if (fsModal in self.FormState) then
          OpenERPListFormModal('TfmReorderLevels', nil)
    else  OpenERPListForm('TfmReorderLevels');
  finally
    begintransaction;
  end;

end;

procedure TfmProductReorderPoints.btnRequeryClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;

end;

procedure TfmProductReorderPoints.BuildHistoryQuery;
var
  csSqlLine :String;
  idx : integer;
  dt : TDate;
  s:string;
begin
  csSqlLine := 'sum(If(PQA.transdate >= :Datefrom and PQA.transdate <= :DateTo , ' + SQL4QtyField(tTotSalesExBo )+',0))';
  dt := HistoryStartDate;
  qryHistory.SQL.Clear;
  qryHistory.sql.Add('select CLS.ClassName as Department, ');
  for idx := 0 to 11 do begin
    s:=  csSqlLine;
    s:= ReplaceStr(s , ':DateFrom' , Quotedstr(FormatDateTime(MySqlDatetimeFormat, dt)));
    s:= ReplaceStr(s , ':DateTo'   , Quotedstr(FormatDateTime(MySqlDatetimeFormat, EndOfTheMonth(dt))));
    qryHistory.sql.Add(s+' as m' + inttostr(idx)+',');
    dt := incMonth(dt, 1);
  end;
  qryHistory.sql.Add('CLS.ClassId');
  qryHistory.SQL.Add('from tblProductClasses CLS Left join tblPQA PQA on CLS.productId = PQa.productID and CLS.clasSId = PQA.departmentId');
  qryHistory.SQL.Add('where CLS.productid=' + IntToStr(ProductId));
  qryHistory.SQL.Add('group by PQA.DepartmentId');
  logtext(qryHistory.SQL.text);
  qryHistory.Open;
end;

procedure TfmProductReorderPoints.btnAdjsutClick(Sender: TObject);
begin
  inherited;
    if (fsModal in self.FormState) then
          OpenERPFormModal('TProductForecastGUI' , 0     , InitProductForecast)
    else  OpenERPForm('TProductForecastGUI' , 0     , InitProductForecast);

end;
procedure TfmProductReorderPoints.InitProductForecast(Sender: TObject);
begin
  if not(sender is TProductForecastGUI) then exit;
    TProductForecastGui(Sender).TempTableName := '';
    TProductForecastGui(Sender).AutoReorder := false;
    TProductForecastGui(Sender).InitProduct(ProductId, ClassId, false);
    TProductForecastGui(Sender).btnProdList.Enabled := false;
    TProductForecastGui(Sender).rgProducts.Enabled := false;
    TProductForecastGui(Sender).AttachObserver(Self);
end;
function TfmProductReorderPoints.LongMonthToIndex(
  const aMonth: string): integer;
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

procedure TfmProductReorderPoints.PopulateTempTable;
const
  csTempInsert = 'INSERT INTO %s (Line, January, February, March, April, May, June, July, August, September, October, November, December) '+
                                  ' Values ( "%s", %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);';

var
  lPoints : TPointsArray;
  qry : TERPQuery;
  idx : integer;
  scr :TERPScript;
begin
  CreateTempTable;
  system.fillchar(lPoints, SizeOf(lPoints), 0);
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(QryReorderLevels.Connection);
  try
    Qry.sql.add('SELECT ' +
                ' ifnull(R.OrderMonth, "") as OrderMonth, PC.classId, PC.ProductID, ' +
                ' if(ifnull(R.PointId,0)<>0 and PC.Useproductforecastformula="T" , R.ReorderAmount ,  PC.ReorderAmount ) as ReorderAmount, ' +
                ' if(ifnull(R.PointId,0)<>0 and PC.Useproductforecastformula="T" , R.ReOrderPoint  ,  PC.ReOrderPoint  ) as ReOrderPoint, ' +
                ' if(ifnull(R.PointId,0)<>0 and PC.Useproductforecastformula="T" , R.PreferredLevel,  PC.PreferredLevel) as PreferredLevel ' +
                ' from tblProductClasses as PC ' +
                ' left join tblReorderPoints R on R.ClassId = PC.ClassId and R.ProductId=PC.ProductId ' +
                ' Where PC.productId =  ' + IntToStr(ProductId) + '  and PC.classId =  ' + IntToStr(ClassId));
    qry.Open;
      for idx := 0 to 11 do begin
        if Qry.locate('Ordermonth' , IndexToMonth(idx) , []) or
           Qry.locate('Ordermonth' , '' , []) then begin
        lPoints[0][idx] := Floattostr(qry.FieldByName('ReorderPoint').AsFloat);
        lPoints[1][idx] := Floattostr(qry.FieldByName('PreferredLevel').AsFloat);
        lPoints[2][idx] := Floattostr(qry.FieldByName('ReorderAmount').AsFloat);
        end;
      end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  scr := DbSharedObj.GetScript(QryReorderLevels.Connection);
  try
    With scr do begin
      for idx := 0 to 2 do  begin
        if lPoints[idx][0]  ='' then lPoints[idx][0]  := '0';
        if lPoints[idx][1]  ='' then lPoints[idx][1]  := '0';
        if lPoints[idx][2]  ='' then lPoints[idx][2]  := '0';
        if lPoints[idx][3]  ='' then lPoints[idx][3]  := '0';
        if lPoints[idx][4]  ='' then lPoints[idx][4]  := '0';
        if lPoints[idx][5]  ='' then lPoints[idx][5]  := '0';
        if lPoints[idx][6]  ='' then lPoints[idx][6]  := '0';
        if lPoints[idx][7]  ='' then lPoints[idx][7]  := '0';
        if lPoints[idx][8]  ='' then lPoints[idx][8]  := '0';
        if lPoints[idx][9]  ='' then lPoints[idx][9]  := '0';
        if lPoints[idx][10] ='' then lPoints[idx][10] := '0';
        if lPoints[idx][11] ='' then lPoints[idx][11] := '0';

        SQL.Add(Format(csTempInsert, [fsTableName, csLines[idx], lPoints[idx][0], lPoints[idx][1],
                          lPoints[idx][2], lPoints[idx][3],lPoints[idx][4],lPoints[idx][5],lPoints[idx][6],
                          lPoints[idx][7],lPoints[idx][8],lPoints[idx][9],lPoints[idx][10],lPoints[idx][11]]));
      end;
      Execute;
    end;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;

procedure TfmProductReorderPoints.cmdCloseClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  closeIt;
end;

procedure TfmProductReorderPoints.CreateTempTable;
var
  scr :TERPScript;
begin
  inherited;
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    scr.SQL.Clear;
    scr.SQL.Add('DROP TABLE IF EXISTS ' + fsTableName + ';');
    scr.SQL.Add('CREATE TABLE ' + fsTableName);
    scr.SQL.Add('(Line varchar(30), January Double, February Double, March Double, April Double, May Double, June Double,');
    scr.SQL.Add('July Double, August Double, September Double, October Double, November Double, December Double');
    scr.sql.Add(');');
    scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;

procedure TfmProductReorderPoints.dtFromChange(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = dtFrom then
    RefreshQuery;
end;

procedure TfmProductReorderPoints.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
  UnlockTables;
end;

procedure TfmProductReorderPoints.FormCreate(Sender: TObject);
begin
  dtFrom.date := Date;
  OnHistoryRecChange := False;
  fsTablename := GetUserTemporaryTableName('reorderpoints');
  QryReorderLevels.SQL.Clear;
  QryReorderLevels.SQL.Text := 'SELECT Line, January, February, March, April, May, June, July, August, September, October, November, December FROM ' +fsTablename;
  inherited;
end;

procedure TfmProductReorderPoints.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  RollbackTransaction;
  inherited;

end;

procedure TfmProductReorderPoints.FormShow(Sender: TObject);
begin

  inherited;
  ReadnApplyGuiPref;
  closedb( QryProductnClass);
  QryProductnClass.ParamByName('ProductId').AsInteger := ProductId;
  QryProductnClass.ParamByName('classId').AsInteger := classId;
  RefreshQuery;
  OpenQueries;
  begintransaction;

  QryReorderLevelsLine.DisplayLabel := 'Month';
  QryReorderLevelsLine.DisplayWidth := 20;

  grdHistory.Color := grdMain.Color;
  grdHistory.TitleColor := grdMain.TitleColor;
  grdHistory.FooterColor := grdMain.FooterColor;
  grdHistory.Columns[0].DisplayWidth := grdMain.Columns[0].DisplayWidth;
  LockTables;
end;

procedure TfmProductReorderPoints.grdHistoryCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
var
  y, m : word;
  y1, m1 : word;
  s : string;
begin
  inherited;
  m := MonthOf(Date);
  s := Copy(Field.DisplayLabel, 1, pos(' ', Field.DisplayLabel) - 1);
  m1 := MonthToIndex(s) + 1;
  if m <> m1 then exit;

  y := YearOf(Date);
  s := Copy(Field.DisplayLabel, pos(' ', Field.DisplayLabel) + 1, 255);
  y1 := StrToInt(s);
 if y <> y1 then exit;

 ABrush.Color := clLime;

end;

procedure TfmProductReorderPoints.grdMainDblClick(Sender: TObject);
var
  lMonth : string;
begin
  if (grdMain.GetActiveField <> nil) and
     (grdMain.GetActiveField.Index > 0) then
  begin
    lMonth := grdMain.GetActiveField.DisplayLabel;
    if CommonLib.MessageDlgXP_Vista('Do You Want To Use ' + lMonth + ' As a Base For Reordering?', mtWarning, [mbYes, mbNo], 0) = mrYes then
    begin
      SelectedMonth := lMonth;
      btnOkClick(Self);
    end;
  end
  else
    inherited;
end;

procedure TfmProductReorderPoints.grdMainTitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
  inherited;
  if LongMonthToIndex(AFieldName) >= 0 then
    SelectedMonth := AFieldName;
end;


function TfmProductReorderPoints.HistoryStartDate: TDatetime;
begin
  Result := StartOfTheMonth(dtFrom.date);
end;

procedure TfmProductReorderPoints.qryHistoryAfterOpen(DataSet: TDataSet);
var
  idx : integer;
  dt : TDate;
begin

  dt := HistoryStartDate;
  qryHistory.Fields[0].DisplayLabel := Appenv.DefaultClass.ClassHeading;
  for idx := 0 to 11 do  begin
    qryHistory.Fieldbyname('m' + trim(inttostr(idx))).DisplayLabel := csMonths[MonthOf(dt)-1] + ' ' + IntToStr(YearOf(dt));
    grdHistory.columnbyname('m' + trim(inttostr(idx))).DisplayLabel := qryHistory.Fieldbyname('m' + trim(inttostr(idx))).DisplayLabel ;
    dt := IncMonth(dt, 1);
  end;
  lblSaleshistory.caption := 'Sales History from ' +qryHistory.Fieldbyname('m0').displaylabel +' to ' +
                                                    qryHistory.Fieldbyname('m11').displaylabel ;
  lblSaleshistory.Refresh;
end;

procedure TfmProductReorderPoints.qryHistoryAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not IsFormshown then exit;

  if qryHistory.FieldByName('ClassId').asInteger = ClassId then exit;
  if OnHistoryRecChange then exit;
  OnHistoryRecChange:= TRue;
  try
    SavePoints(False);
    ClassId := qryHistory.FieldByName('ClassId').asInteger;
    RefreshQuery;
    qryHistory.Locate('ClassId', ClassId, []);
  finally
    OnHistoryRecChange := False;
  end;
end;
procedure TfmProductReorderPoints.ReadnApplyGuiPref;
begin
  if not GuiPrefs.active then GuiPrefs.active := True;
  if GuiPrefs.Node.Exists('Options.HistoryHeight') then pnlHistory.Height :=  GuiPrefs.Node['Options.HistoryHeight'].asInteger;
  if GuiPrefs.Node.Exists('Options.FromDate')      then dtFrom.Date :=  GuiPrefs.Node['Options.FromDate'].asDatetime
  else dtFrom.Date :=  Date;

end;

procedure TfmProductReorderPoints.RefreshHistory;
begin
  closedb(qryHistory);
  BuildHistoryQuery;

  ReorderMainGrid;
end;

procedure TfmProductReorderPoints.RefreshQuery;
begin
  closedb(QryReorderLevels);
  PopulateTempTable;
  Opendb(QryReorderLevels);
  RefreshHistory;
end;
procedure TfmProductReorderPoints.ReorderMainGrid;
var
  lMonth : integer;
  idx : integer;

begin

  lMonth := MonthOf(HistoryStartDate);

  for idx := 1 to 12 do
  begin
    grdMain.ColumnByName(csSaveMonths[lMonth - 1]).Index := idx;
    lMonth := lMonth + 1;
    if lMonth > 12 then
      lMonth := 1;
  end;

end;

function TfmProductReorderPoints.SavePoints(ASaveClass: boolean): boolean;
var
  idx : integer;
  lPoints : TSaveArray;
  Scr :TERPScript;

  procedure SetLine(aNo : integer);
  var
    i : integer;
  begin
    for i := 0 to 11 do
      lPoints[aNo][i] := QryReorderLevels.FieldByName(csSaveMonths[i]).AsString;
  end;
begin
  Result := true;
  Postdb(QryReorderLevels);

  QryReorderLevels.First;
  idx := 0;
  while (not (QryReorderLevels.Eof)) and (idx < 3) do begin
    SetLine(idx);
    QryReorderLevels.Next;
    inc(idx);
  end;
  inherited;
  Scr := DbSharedObj.GetScript(QryReorderLevels.Connection);
  try
    Scr.SQL.Clear;
    for idx := 0 to 11 do
    begin
      Scr.SQL.Add('UPDATE tblReorderPoints SET ' +
                      ' ReorderPoint   =' + lPoints[0][idx] + ', ' +
                      ' PreferredLevel =' + lPoints[1][idx] + ', ' +
                      ' ReorderAmount  =' + lPoints[2][idx]  +
                      ' WHERE ProductId=' + inttostr(ProductId) +' and ClassId=' + inttostr(ClassId) +' and OrderMonth=' + quotedstr(csMonths[idx])+';');
    end;
    Scr.execute;

    if not ASaveClass then Exit;

    if SelectedMonth = '' then begin
      if MessageDlgXP_Vista('Month To Be Used For Reorder Has Not Been Selected.'#13#10 +
                            'Do You Want To Use Values For The Current Month?', mtWarning, [mbYes, mbNo], 0) = mrNo then begin
        CommonLib.MessageDlgXP_Vista('Please Select the Month To Be Used For Reorder', mtWarning, [mbOK], 0);
        Result := false;
        Exit;
      end else SelectedMonth := csSaveMonths[MonthOf(Date) - 1];
    end;

    idx := LongMonthToIndex(SelectedMonth);
    Scr.SQL.Clear;
    Scr.SQL.Text :=   ' update tblProductClasses C ' +
                          ' inner join tblReorderPoints R on (R.ProductId=C.ProductId and R.ClassId = C.ClassId) ' +
                          ' Set C.ReorderPoint = R.ReorderPoint, C.PreferredLevel=R.PreferredLevel, C.ReorderAmount=R.ReorderAmount ' +
                          ' where C.ProductId=' + inttostr(ProductId) +'  and R.OrderMonth=' + quotedstr(csMonths[idx])+';';
    Scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;

  end;


procedure TfmProductReorderPoints.WriteGuiPref;
begin
  GuiPrefs.Node['Options.HistoryHeight'].asInteger := pnlHistory.Height;
  GuiPrefs.Node['Options.FromDate'].asDatetime := dtFrom.Date;
  fbIsLocalPrefChanged := True;
end;
Procedure TfmProductReorderPoints.LockTables;
begin
  if not UserLock.Enabled then UserLock.Enabled := TRue;
    if not UserLock.Lock('tblParts',ProductId,Self.Caption) then begin
        AccessLevel:= 5; // read only
        MessageDlgXP_Vista(UserLock.LockMessage+#13+#10+#13+#10+'Access has been changed to read-only.', mtWarning, [mbOK], 0);
    end;
end;
Procedure TfmProductReorderPoints.UnlockTables;
begin
    UserLock.Unlock(Copy(ClassName, 2, FastFuncs.Strlength(ClassName)));
    UserLock.Unlock(Self.Caption);
end;

initialization
  RegisterClassOnce(TfmProductReorderPoints);

end.
