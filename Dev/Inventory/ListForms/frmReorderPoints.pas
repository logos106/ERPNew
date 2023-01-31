unit frmReorderPoints;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel, DateUtils,
  MySQLConst,Math, DateTimeUtils;

type
  TfmReorderPoints = class(TBaseListingGUI)
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
    pnlHistory: TDnmPanel;
    grdHistory: TwwDBGrid;
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
    Label2: TLabel;
    qryHistoryClassId: TIntegerField;
    Horizontal1: TSplitter;
    Panel4: TPanel;
    Label4: TLabel;
    lblProductName: TLabel;
    lblDepartment: TLabel;
    lblDepartmentName: TLabel;
    lblSaleshistory: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure grdHistoryCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure cmdNewClick(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure grdHistoryMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure qryHistoryAfterOpen(DataSet: TDataSet);
  private
    fProductId: integer;
    fClassId: integer;
    fSelectedMonth: string;
    procedure UnlockRelatedTables;
    procedure begintransaction;
    procedure committransaction;
    procedure RollbackTransaction;
    procedure LockProduct;

    { Private declarations }
  protected
    fsTableName : string;
    procedure CreateTempTable;
    procedure PopulateTempTable;
    //procedure FillSourceTable;
    function LongMonthToIndex(const aMonth : string) : integer;
    function SavePoints(ASaveClass : boolean) : boolean;
    procedure BuildHistoryQuery;
    procedure RefreshHistory;
    //procedure ResizeHistory;
    function HistoryStartDate : TDateTime;
    procedure ReorderMainGrid;
    procedure SetProductLabels;

    property SelectedMonth : string read fSelectedMonth write fSelectedMonth;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;

  public
    { Public declarations }
    procedure RefreshQuery;override;
    procedure UpdateMe; override; //(const Cancelled: boolean; const aObject: TObject = nil); override;
    property ProductId : integer read fProductId write fProductId;
    property ClassId : integer read fClassId write fClassId;
    procedure AttachObserver(const oObserver: TObject);
  end;

implementation

{$R *.dfm}
uses
  CommonLib, CommonDbLib, CommonFormLib, AppEnvironment, ObserverListObj, frmProductForecast,
  DbSharedObjectsObj, LogLib, PQALib, FastFuncs;

type
  TPointLine = array[0..11] of string; //Double;
  TPointsArray = array[0..3] of TPointLine;
//  TMonthArray = array [0..11] of string;
//  TSaveArray = array[0..11] of array [0..2] of string;
  TSaveArray = array[0..2] of array [0..11] of string;
const
//  csMonths : TMonthArray = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
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

{ TfmReorderPoints }

procedure TfmReorderPoints.cmdCloseClick(Sender: TObject);
begin
  RollbackTransaction;
  inherited;

end;

procedure TfmReorderPoints.cmdExportClick(Sender: TObject);
begin
  CommitTransaction;
  try
    if (fsModal in self.FormState) then
          OpenERPListFormModal('TfmReorderLevels', nil)
    else  OpenERPListForm('TfmReorderLevels');
  finally
    begintransaction;
  end;
end;

procedure TfmReorderPoints.cmdNewClick(Sender: TObject);
var
  Form: TForm;
begin
  Form := TForm(GetComponentByClassName('TProductForecastGUI'));
  if Assigned(Form) then begin
    TProductForecastGui(Form).TempTableName := '';
    TProductForecastGui(Form).AutoReorder := false;
    TProductForecastGui(Form).InitProduct(ProductId, ClassId, false);
    TProductForecastGui(Form).btnProdList.Enabled := false;
    TProductForecastGui(Form).rgProducts.Enabled := false;
    TProductForecastGui(Form).AttachObserver(Self);
    Form.FormStyle := fsMDIChild;
    Form.BringToFront;
  end;

end;

procedure TfmReorderPoints.cmdPrintClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmReorderPoints.CreateTempTable;
begin
  With ScriptMain do begin
    SQL.Clear;
    SQL.Add('DROP TABLE IF EXISTS ' + fsTableName + ';');
    SQL.Add('CREATE TABLE ' + fsTableName);
    SQL.Add('(Line varchar(30), January Double, February Double, March Double, April Double, May Double, June Double,');
    SQL.Add('July Double, August Double, September Double, October Double, November Double, December Double');
    sql.Add(');');
    Execute;
  end;
end;

procedure TfmReorderPoints.PopulateTempTable;
const
  csTempInsert = 'INSERT INTO %s (Line, January, February, March, April, May, June, July, August, September, October, November, December) Values ('#13#10 +
                 '"%s", %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);';

var
  lPoints : TPointsArray;
  qry : TERPQuery;
  idx : integer;
begin
  CreateTempTable;
  system.fillchar(lPoints, SizeOf(lPoints), 0);
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);//TempMyQuery;
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
  With ScriptMain do begin
    for idx := 0 to 2 do  begin
      SQL.Add(Format(csTempInsert, [fsTableName, csLines[idx], lPoints[idx][0], lPoints[idx][1],
                        lPoints[idx][2], lPoints[idx][3],lPoints[idx][4],lPoints[idx][5],lPoints[idx][6],
                        lPoints[idx][7],lPoints[idx][8],lPoints[idx][9],lPoints[idx][10],lPoints[idx][11]]));
    end;
  Execute;
  end;
end;

procedure TfmReorderPoints.qryHistoryAfterOpen(DataSet: TDataSet);
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

procedure TfmReorderPoints.actRefreshQryExecute(Sender: TObject);
begin
  PopulateTempTable;
  inherited;
end;

procedure TfmReorderPoints.AttachObserver(const oObserver: TObject);
begin
  Assert(oObserver <> nil, 'TBaseInputGUI cannot attach a NIL object');
  ObserverList.Attach(oObserver, self);
end;

procedure TfmReorderPoints.btnOKClick(Sender: TObject);
begin
  inherited;
  if not SavePoints(TRUE) then
    exit;

  committransaction;
  ObserverList.Notify(self, false);
  Close;
end;

procedure TfmReorderPoints.BuildHistoryQuery;
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
  (*if qryHistory.RecordCount = 0 then
  begin
    qryHistory.Close;
    qryHistory.SQL.Text := 'select CLS.ClassName as Department, 0.0 as m0, 0.0 as m1, 0.0 as m2, 0.0 as m3, 0.0 as m4, 0.0 as m5, 0.0 as m6, 0.0 as m7, 0.0 as m8, 0.0 as m9, 0.0 as m10, 0.0 as m11';
    qryHistory.SQL.Add('from tblProductClasses CLS');
    qryHistory.SQL.Add('where productid=' + IntToStr(ProductId));
    qryHistory.Open;
  end;*)
end;

function TfmReorderPoints.SavePoints(ASaveClass : boolean) : boolean;
var
  idx : integer;
  lPoints : TSaveArray;

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
//
  if qryMain.State = dsEdit then
    qryMain.Post;

  qryMain.First;
  idx := 0;
  while (not (qryMain.Eof)) and (idx < 3) do
  begin
    SetLine(idx);
    qryMain.Next;
    inc(idx);
  end;

  qryWork.Close;
  qryWork.SQL.Clear;
  for idx := 0 to 11 do
  begin
    qryWork.SQL.Add('UPDATE tblReorderPoints SET ' +
                    ' ReorderPoint=' + lPoints[0][idx] + ', ' +
                    ' PreferredLevel=' + lPoints[1][idx] + ', ' +
                    ' ReorderAmount=' + lPoints[2][idx]  +
                    ' WHERE ProductId=' + inttostr(ProductId) +' and ClassId=' + inttostr(ClassId) +' and OrderMonth=' + quotedstr(csMonths[idx])+';');
  end;
  qryWork.ExecSQL;

  qryWork.Close;

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
  qryWork.SQL.Clear;
  qryWork.SQL.Text :=   'update tblProductClasses C ' +
                    'inner join tblReorderPoints R on (R.ProductId=C.ProductId and R.ClassId = C.ClassId) ' +
                    'Set C.ReorderPoint = R.ReorderPoint, C.PreferredLevel=R.PreferredLevel, C.ReorderAmount=R.ReorderAmount ' +
                    'where C.ProductId=' + inttostr(ProductId) +'  and R.OrderMonth=' + quotedstr(csMonths[idx])+';';
  qryWork.ExecSQL;
  qryWork.Close;

end;

procedure TfmReorderPoints.SetProductLabels;
var
  qry : TERPQuery;

begin
  lblCustomReport.Caption := 'Product:';
  lblCustomReport.Width := lblCustomReport.Canvas.TextWidth(lblCustomReport.Caption) + 6;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.Text := 'select ProductName, ClassName'#13#10+
                        'from tblParts P inner join tblProductClasses C on C.ProductId=P.PartsId';
    qry.SQL.Add('where PartsId=' + IntToStr(ProductId) + ' and ClassId=' + IntToStr(ClassId));
    qry.Open;

    lblProductName.Caption := qry.FieldByName('ProductName').AsString;
    lblProductName.Width := lblProductName.Canvas.TextWidth(lblProductName.Caption) + 6;
    lblProductName.Left := lblCustomReport.Left + lblCustomReport.Width + 6;
    lblProductName.Top := (lblCustomReport.Top + lblCustomReport.Height div 2) - lblProductName.Height div 2;

    lblDepartment.Width := lblDepartment.Canvas.TextWidth(lblDepartment.Caption) + 6;
    lblDepartment.Left := lblProductName.Left + lblProductName.Width + 6;
    lblDepartment.Top := lblCustomReport.Top;

    lblDepartmentName.Caption := qry.FieldByName('ClassName').AsString;
    lblDepartmentName.Width := lblDepartmentName.Canvas.TextWidth(lblDepartmentName.Caption) + 6;
    lblDepartmentName.Left := lblDepartment.Left + lblDepartment.Width + 6;
    lblDepartmentName.Top := lblProductName.Top;

    pnlButtons.Width := lblDepartmentName.Left + lblDepartmentName.Width + 24;
  finally
    qry.Free;
  end;

end;

procedure TfmReorderPoints.UpdateMe;
begin
  inherited;
  actRefreshQryExecute(Self);
end;


(*procedure TfmReorderPoints.FillSourceTable;
const
  csWhere = 'where ProductId=%d and ClassId=%d';
  csInsert = 'INSERT INTO tblReorderPoints (ProductId, ClassId, ReorderPoint, PreferredLevel, ReorderAmount, OrderMonth)' +
             'Values(%d, %d, %s, %s, %s,';
var
  idx : integer;
  qry : TERPQuery;
  lWhere : string;
  lInsert : string;
begin
  qry := TempMyQuery;
  try
    lWhere := Format(csWhere, [ProductId, ClassId]);
    qry.sql.text := 'SELECT * from tblReorderPoints ' + lWhere;
    qry.Open;
    if not qry.eof then
      exit;
    qry.Close;
    qry.sql.clear;
    qry.sql.add('select ReorderPoint, PreferredLevel, ReorderAmount from tblproductClasses');
    qry.sql.add(lWhere);
    qry.Open;
    lInsert := Format(csInsert, [ProductId, ClassId,
      qry.FieldByName('ReorderPoint').AsString,
      qry.FieldByName('PreferredLevel').AsString,
      qry.FieldByName('ReorderAmount').AsString]);
    for idx := 0 to 11 do
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add(lInsert);
      qry.SQL.Add('"' + csMonths[idx] + '")');
      qry.ExecSQL;
    end;
    qry.Close;
  finally
    qry.Free;
  end;
end;*)

procedure TfmReorderPoints.FormCreate(Sender: TObject);
begin
  fsTablename := GetUserTemporaryTableName('reorderpoints');
  qryMain.SQL.Clear;
  qryMain.SQL.Text := 'SELECT Line, January, February, March, April, May, June, July, August, September, October, November, December FROM ' +fsTablename;
  inherited;
end;

procedure TfmReorderPoints.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  RollbackTransaction;
  inherited;
end;

procedure TfmReorderPoints.FormShow(Sender: TObject);
begin
  PopulateTempTable;
  SearchMode := smFullList;
  inherited;
  begintransaction;
  if Panel3.Visible then begin  // First entry
    HeaderPanel.Height := HeaderPanel.Height - Panel3.Height;
    Panel3.Visible := false;
    // Have to, since otherwise pnlHeader.height is left to be 19...
    pnlHeader.Height := TitleLabel.Canvas.TextHeight('R') + 6;
  end;

  qryMainLine.DisplayLabel := 'Month';
  qryMainLine.DisplayWidth := 20;
  dtFrom.Date := IncMonth(Date, -6);  // half year back
  dtTo.Date := IncYear(dtFrom.Date, 1);

  RefreshHistory;

  SetProductLabels;
  grdHistory.Color := grdMain.Color;
  grdHistory.TitleColor := grdMain.TitleColor;
  grdHistory.FooterColor := grdMain.FooterColor;
  grdHistory.Columns[0].DisplayWidth := grdMain.Columns[0].DisplayWidth;
  //LockProduct;
end;

procedure TfmReorderPoints.grdHistoryCalcCellColors(Sender: TObject;
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
  if m <> m1 then
    exit;

  y := YearOf(Date);
  s := Copy(Field.DisplayLabel, pos(' ', Field.DisplayLabel) + 1, 255);
  y1 := StrToInt(s);
 if y <> y1 then
   exit;

 ABrush.Color := clLime;

end;

procedure TfmReorderPoints.grdHistoryMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if qryHistory.FieldByName('ClassId').asInteger = ClassId then
    exit;
  SavePoints(False);
  ClassId := qryHistory.FieldByName('ClassId').asInteger;
  SetProductLabels;
  PopulateTempTable;
  RefreshQuery;
  qryHistory.Locate('ClassId', ClassId, []);
end;

procedure TfmReorderPoints.grdMainDblClick(Sender: TObject);
var
  lMonth : string;
begin
  if (grdMain.GetActiveField <> nil) and //not empty(grdMain.GetActiveField.asString) then
     (grdMain.GetActiveField.Index > 0) then
  begin
    lMonth := grdMain.GetActiveField.DisplayLabel;
    if CommonLib.MessageDlgXP_Vista('Do You Want To Use ' + lMonth + ' As a Base For Reordering?', mtWarning, [mbYes, mbNo], 0) = mrYes then
    begin
      SelectedMonth := lMonth;
      // SavePoints(true);
      btnOkClick(Self);
    end;
  end
  else
    inherited;
//
end;

procedure TfmReorderPoints.grdMainTitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
//  inherited;
  if LongMonthToIndex(AFieldName) >= 0 then
    SelectedMonth := AFieldName;
end;

function TfmReorderPoints.HistoryStartDate: TDateTime;
begin
  if chkIgnoreDates.Checked then
    Result := StartOfTheMonth(IncMonth(StartOfTheMonth(Date), -11))
  else
    Result := StartOfTheMonth(dtFrom.Date);
end;

function TfmReorderPoints.LongMonthToIndex(const aMonth: string): integer;
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


procedure TfmReorderPoints.RefreshHistory;
begin
  closedb(qryHistory);
  BuildHistoryQuery;

  //ResizeHistory;
  ReorderMainGrid;
end;

procedure TfmReorderPoints.ReorderMainGrid;
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

procedure TfmReorderPoints.RefreshQuery;
begin
  inherited;
  RefreshHistory;
end;

(*procedure TfmReorderPoints.ResizeHistory;
var
  lMaxHeight,
  lHeight : integer;
begin
  lHeight := (grdHistory.RowHeights[0] + 1) * (qryHistory.RecordCount + 1{Header} + 1 {ScrollBar}) + 2;
  lMaxHeight := Panel1.Height - grdMain.Top - grdMain.Height - 4;
  lHeight := Min(lHeight + 12, lMaxHeight);
  pnlHistory.Height := lHeight;
  // pnlHistory cannot be greater than pnlMain height - grdMain height, let's windows do the calculations
  grdHistory.Height := pnlHistory.Height - 12;

  pnlHistory.Color := HeaderPanel.Color;
  grdHistory.Color := grdMain.Color;
  grdMain.Columns[0].DisplayWidth := grdHistory.Columns[0].DisplayWidth;
end;*)
procedure TfmReorderPoints.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.HistoryHeight') then
      pnlHistory.Height :=  GuiPrefs.Node['Options.HistoryHeight'].asInteger;

end;

procedure TfmReorderPoints.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.HistoryHeight'].asInteger := pnlHistory.Height;
end;

procedure TfmReorderPoints.committransaction;
begin
  if qryMain.Connection.InTransaction  then qryMain.Connection.Commit;
  UnlockRelatedTables;
end;
Procedure TfmReorderPoints.RollbackTransaction;
begin
    if qryMain.Connection.InTransaction then qryMain.Connection.Rollback;
    UnlockRelatedTables;
end;
procedure TfmReorderPoints.begintransaction;
begin
  if not qryMain.Connection.InTransaction  then qryMain.Connection.StartTransaction;
  LockProduct;
end;
Procedure TfmReorderPoints.UnlockRelatedTables;
begin
    UserLock.Unlock(Copy(ClassName, 2, FastFuncs.Strlength(ClassName)));
    UserLock.Unlock(Self.Caption);
end;
Procedure TfmReorderPoints.LockProduct;
begin
  if not UserLock.Lock('tblParts',ProductID,Self.Caption) then begin
        AccessLevel:= 5; // read only
        MessageDlgXP_Vista(UserLock.LockMessage+#13+#10+#13+#10+'Access has been changed to read-only.', mtWarning, [mbOK], 0);
  end;
end;
initialization
  RegisterClassOnce(TfmReorderPoints);
end.
