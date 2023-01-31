unit frmProductForecast;

interface

uses
  Windows, Contnrs, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, Shader, DNMPanel,
  wwdbdatetimepicker, MemDS, wwcheckbox, Mask, wwdbedit, Grids, BaseGrid,
  AdvGrid, wwdblook, BusObjProductForecast, DNMSpeedButton, Wwdbspin, MessageConst,
  ImgList, AdvObj, ProgressDialog, CheckComboBox, DateUtils, Spin, wwDbGrid, DateTimeUtils, Math,
  AdvGroupBox, ComCtrls;

type



//  TUseAdjustmentEvent = procedure (AAdjustmentRecord : TProductAdjustRecord) of object;

  TProductForecastGUI = class(TBaseInputGUI)
    qryMain: TERPQuery;
    dsMain: TDataSource;
    qryDepartment: TERPQuery;
    qryDepartmentClassID: TIntegerField;
    qryDepartmentClassName: TWideStringField;
    pnlHistory: TDNMPanel;
    chkUseReorderAmount: TwwCheckBox;
    pnlLevels: TDNMPanel;
    btnReorderPoint: TDNMSpeedButton;
    btnPreferredLevel: TDNMSpeedButton;
    btnReorderAmount: TDNMSpeedButton;
    spReorderAmount: TSpinEdit;
    spPreferredLevel: TSpinEdit;
    spReorderPoint: TSpinEdit;
    lblDescription: TLabel;
    Bevel3: TBevel;
    rgApplyTo: TRadioGroup;
    gbHistory: TAdvGroupBox;
    chkQuotes: TwwCheckBox;
    chkSalesOrders: TwwCheckBox;
    chkInvoices: TwwCheckBox;
    lblFromDate: TLabel;
    dtFromDate: TwwDBDateTimePicker;
    lblToDate: TLabel;
    dtToDate: TwwDBDateTimePicker;
    AdvGroupBox2: TAdvGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    gbFormula: TGroupBox;
    txtFormula: TwwDBEdit;
    btnFormulaHelp: TDNMSpeedButton;
    btnValidate: TDNMSpeedButton;
    pnlProducts: TDNMPanel;
    rgProducts: TRadioGroup;
    rgDepartments: TRadioGroup;
    cbDepartments: TCheckComboBox;
    btnProdList: TDNMSpeedButton;
    chkUseFormula: TwwCheckBox;
    chkUseHistory: TwwCheckBox;
    pnlButtons: TDNMPanel;
    btnHowTo: TDNMSpeedButton;
    btnOk: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    pnlCaption: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    lblMonth: TLabel;
    cbMonth: TComboBox;
    chkDoRound: TCheckBox;
    lblRounding: TLabel;
    cbRounding: TComboBox;
    chkUseAvailQty: TwwCheckBox;
    rbUseAvgDailySales: TRadioButton;
    rbUseAvgMonthlySales: TRadioButton;
    rbUseActualMonthlySales: TRadioButton;
    btnReorderLevels: TDNMSpeedButton;
    chkUseNonERPsales: TwwCheckBox;
    Bevel2: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    btnFromPeriodSales: TDNMSpeedButton;
    dtApplyToFrom: TwwDBDateTimePicker;
    dtApplyToTo: TwwDBDateTimePicker;
    procedure cboProductNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFormulaHelpClick(Sender: TObject);
    procedure cboDepartmentCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboProductCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnValidateClick(Sender: TObject);
    procedure DelayedPreviewForProductEvent(Sender: TObject);
    procedure dtFromDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rgDepartmentsClick(Sender: TObject);
    procedure btnProdListClick(Sender: TObject);
    procedure btnReorderPointClick(Sender: TObject);
    procedure btnPreferredLevelClick(Sender: TObject);
    procedure btnReorderAmountClick(Sender: TObject);
    procedure chkDoRoundClick(Sender: TObject);
    procedure rgApplyToClick(Sender: TObject);
    procedure rbUseAvgMonthlySalesClick(Sender: TObject);
    procedure rbUseActualMonthlySalesClick(Sender: TObject);
    procedure rbUseAvgDailySalesClick(Sender: TObject);
    procedure chkUseFormulaClick(Sender: TObject);
    procedure chkUseHistoryClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure dtFromDateChange(Sender: TObject);
    procedure dtToDateChange(Sender: TObject);
    procedure btnHowToClick(Sender: TObject);
    procedure btnReorderLevelsClick(Sender: TObject);
    procedure dtApplyToFromChange(Sender: TObject);
    procedure dtApplyToToChange(Sender: TObject);
    procedure btnFromPeriodSalesClick(Sender: TObject);
  private
    fMyTable: boolean;
    Procedure Writeguiprefs;
    Procedure readguiprefs;
  protected
    procedure SetAllCombo(aCombo : TCheckComboBox; AAll : boolean);
    procedure LoadDepartmentCombo;
    function GetCommaValues(ACombo : TCheckComboBox) : string;
    function CheckReorderPoints : boolean;
    function CreateReorderPointsFromProductclass(fSQL:String) : boolean;
    function AdjustReorderPoints(aUseClasses : boolean): boolean;
    function AdjustReorderPointsTable : boolean;
    function AdjustPoint(AOldValue, AValue : double; AMode : boolean) : double;
    procedure CreateTempTable;
    procedure DropTempTable;
    procedure SetLimits(btn : TDNMSpeedButton; sp : TSpinEdit);
    procedure ProcessAutoAdjustment;
    function SaveByMode : boolean;
    function  CalculateByFormula : boolean;

    function ApplyToReorder : boolean;
    function ApplyToSmart : boolean;
    procedure CopyToSmartOrder(Month : integer);

    function ApplyToMonth : integer;
    function ApplyFromMonth : integer;
    function DateFrom : TDate;
    function DateTo : TDate;
    function ApplyFrom : TDate;
    function ApplyTo : TDate;
    function DaysInTheMonth(const AShortMonth : string) : integer;
    function MonthNumber(const aShortMonth : string) : integer;

    procedure DoProgressBarInit(Sender: TObject; MaxValue: Integer);
    procedure DoProgressBarStepIt(Sender: TObject);
    procedure DoProgressBarSmartOrder(Sender : TObject; const aMessage : string);
    function ApplyMode : TApplyMode;
    procedure SetUseState(Sender : TObject);

    property MyTable : boolean read fMyTable write fMyTable;
  private
    ProductForecastFormula: TProductForecastFormula;
    fTempTableName: string;
    fOnSelectProduct: TNotifyEvent;
    FOnUseAdjustment: TNotifyEvent;
    fProductCount: integer;
    fAutoReorder: boolean;
    procedure PreviewForProduct;
    procedure DelayedPreviewForProduct;
    procedure WMPostMsgToSelf(var Msg: TMessage); message WM_PostMsgToSelf;
    procedure DoOnProdListShow(Sender : TObject);
    procedure ProductGridDataSelect(Sender: TwwDbGrid);
    procedure AddProduct(ProductId : integer);
    procedure SetTempTableName(const Value: string);
    function Percentage(btn : TDNMSpeedButton) : boolean;
    //function GetPartsList(qry : TERPQuery) : string;
    procedure SetOnUseAdjustment(const Value: TNotifyEvent);
//    procedure CreateReorderPointsFromProductclassByMonth(const aMonth : string);
    procedure CreateAdjustRecord;
    function BuildAdjustRecord : TProductAdjustRecord;
    procedure SetAutoReorder(const Value: boolean);
    function SelectedProductIDs: String;
    function SelectedClassIds: string;
    procedure initsaleslist(Sender: TObject);
    procedure setClassIDs(const Value: String);
    procedure setProductIDs(const Value: String);
    procedure ChooseProducts(Ids: String);
    procedure initReorderLevels(Sender: TObject);

    property ProductCount : integer read fProductCount write fProductCount;
    Procedure updateproductclasses;
    Property ClassIDs :String read SelectedClassIds write setClassIDs;
    Property ProductIDs :String read SelectedProductIDs write setProductIDs;
  public
    procedure InitProduct(AProductId : integer; AClassId : integer; AAutoReorder : boolean = false);

    property TempTableName : string read fTempTableName write SetTempTableName;
    property OnSelectProduct : TNotifyEvent read fOnSelectProduct write fOnSelectProduct;
    property OnUseAdjustment : TNotifyEvent read FOnUseAdjustment write SetOnUseAdjustment;
    property AutoReorder : boolean read fAutoReorder write SetAutoReorder;
  end;

implementation

uses
  tcConst, CommonDbLib, BusObjBase, DNMExceptions, CommonLib, CommonFormLib,
  BaseListingForm, AppEnvironment, frmSmartOrderFrm,
  DocReaderObj, ProductListExpressForm, DbSharedObjectsObj, tcDataUtils,
  LogLib, SalesSummaryReport, saleslib, DecimalRounding, frmReorderLevels;

{$R *.dfm}

const
(*  csQueryProducts = 'select if (P.PartName <> P.PartsDescription, concat(P.PartName, ": ", P.PartsDescription), P.PartName) as Name,'#13#10+
                    'P.PartsId as PartsId from tblParts P where P.Active="T" and p.AutoReorder="T" and p.PartType="INV"';*)

  cs_PCCount = 'select count(distinct PC.Productid, PC.ClassId)  ctr  from';
  csAllProducts = 0;
  csSelectedProduct = 1;
  csAllDepartments = 0;
  csSelectedDepartment = 1;

  csApplyToReorder = 0;
  csApplyToSmart = 1;
  csApplyToBoth = 2;
 //order by PartName
  csAllText = '-- ALL --';

procedure TProductForecastGUI.cboProductNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  Accept := False;
end;
function TProductForecastGUI.SelectedProductIDs:String;
begin
  result := '';
  if rgProducts.ItemIndex <> csSelectedProduct then exit;
  Result := allIds('Select * from ' + TempTableName  , 'PartsID');
end;
function TProductForecastGUI.SelectedClassIds:string;
begin
  result := '';
  if rgDepartments.ItemIndex <> csSelectedDepartment then exit;
  Result := GetCommaValues(cbDepartments);
end;
function TProductForecastGUI.CheckReorderPoints : boolean;
var
  s : string;
  qry : TERPQuery;
begin
  Result := true;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(ProductForecastFormula.connection.Connection);
  try

    qry.SQL.Text := cs_Pccount +'  tblProductClasses PC  ' +
                   ' left join tblReorderPoints R on R.ProductId=PC.ProductId ' +
                   ' inner join tblParts P on P.PartsId = PC.ProductId ' +
                   ' where PC.Active = "T" and P.Active="T" and P.AutoReorder = "T" and P.PartType="INV" ' +
                   ' and ifnull(R.PointID,0)=0';
    s:= SelectedProductIDs; if s <> '' then  qry.SQL.Add('and PC.ProductId in (' + s + ')');
    s:= SelectedClassIds; if s <> '' then  qry.SQL.Add('and PC.ClassId in (' + s + ')');

    qry.Open;
    if qry.fieldbyname('ctr').asInteger >0 then begin
      if MessageDlgXP_Vista(IntToStr(qry.fieldbyname('ctr').asInteger ) + ' Combination(s) of Product/Department '+ NL+
        'Do Not Have Reorder Points Set.'+ NL+ 'Setting Them Can Take Some Time.'+ NL+  NL+ 'Do You Want To Continue?',
        mtInformation, [mbYes, mbNo], 0) = mrNo then Result := false
      else begin
        Result := CreateReorderPointsFromProductclass(qry.SQL.text);
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TProductForecastGUI.FormCreate(Sender: TObject);
begin
  inherited;
  dtApplyToFrom.date :=0;
  dtApplyToTo.date :=0;
  Setlength(BusObjqueries, 1);
  BusObjqueries[0] := 'qryMain';
  TempTableName := '';

  //qryProduct.Connection := GetSharedMyDacConnection;
  ProductForecastFormula := TProductForecastFormula.Create(Self);
  ProductForecastFormula.Connection := TMyDacDataConnection.Create(ProductForecastFormula);
  TMyDacDataConnection(ProductForecastFormula.Connection).Connection := MyConnection;
  ProductForecastFormula.Dataset := qryMain;
  lblDescription.caption := 'This Section Will Adjust the Re-Order Levels.'+NL+
                            'When You Select "Start" on The "Auto Re-Order" Screen, These Levels Will Be Used To Make Smart Orders';
end;

procedure TProductForecastGUI.FormShow(Sender: TObject);
var
  DoNotOpenQueries: array of string;
  idx : integer;
begin
  DisableForm;
  try
    try
      inherited;
      BringToFront;

      Setlength(DonotOpenQueries, 1);
      DoNotOpenQueries[0] := 'qryMain';
      OpenQueries(DoNotOpenQueries);

      if MyConnection.InTransaction then Exit;
      ProductForecastFormula.Load;
      ProductForecastFormula.connection.begintransaction;

      if (ProductForecastFormula.Dataset.RecordCount = 0) and ProductForecastFormula.CanCreate then ProductForecastFormula.new;

      if TempTableName = '' then rgProducts.ItemIndex := csAllProducts;

      if cbDepartments.Items.Count = 0 then begin
        LoadDepartmentCombo;
        rgDepartments.ItemIndex := csAllDepartments;
      end;

      ReadGuiprefs;

      if dtFromDate.date = 0 then ProductForecastFormula.DateFrom := IncYear(startofthemonth(Date), -1);
      if dtToDate.date = 0 then  ProductForecastFormula.DateTo:= incday(Startoftheyear(date) , -1);
      ProductForecastFormula.Postdb;

      if dtApplyToFrom.date <1 then dtApplyToFrom.date  := startofthemonth(Date);
      if dtApplyToTo.date   <1 then dtApplyToTo.date    := endoftheyear(Date);


      if not AutoReorder then begin
        cbMonth.Items.Clear;
        cbMonth.Items.Add(csAllText);
        for idx := 1 to 12 do
          cbMonth.Items.Add(FormatSettings.LongMonthNames[idx]);
        cbMonth.ItemIndex := 0;
      end;

      cbRounding.Items.Clear;
      for idx := 0 to 8 do
        if csRounding[idx] = 0 then
          cbRounding.Items.Add('0 : No Rounding')
        else
          cbRounding.Items.Add(IntToStr(csRounding[idx]));


      chkDoRound.Checked := AppEnv.CompanyPrefs.ProductReorderRoundNearest;
      if AppEnv.CompanyPrefs.ProductReorderRoundNearest then begin
        cbRounding.ItemIndex := cbRounding.Items.IndexOf(IntToStr(AppEnv.CompanyPrefs.ProductReorderRoundValue));
        if cbRounding.ItemIndex = -1 then
          cbRounding.ItemIndex := 4;
      end else begin
        cbRounding.ItemIndex := 4;
        cbRounding.Enabled := false;
      end;

      rgApplyTo.ItemIndex := csApplyToReorder;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;


function TProductForecastGUI.GetCommaValues(ACombo: TCheckComboBox): string;
var
  idx : integer;
begin
  Result := '';
  for idx := 0 to ACombo.Items.Count - 1 do
  begin
    if ACombo.Checked[idx] then
    begin
      if Result = '' then
        Result := ACombo.Values[idx]
      else
        Result := Result + ',' + ACombo.Values[idx];
    end;
  end;
end;

(*function TProductForecastGUI.GetPartsList(qry: TERPQuery): string;
begin
  Result := '';
  if rgProducts.ItemIndex = csSelectedProduct then
  begin
    qry.SQL.Text := 'select * from ' + TempTableName;
    qry.Open;
    try
      while not qry.eof do
      begin
        if Result = '' then
          Result := qry.FieldByName('PartsId').AsString
        else
          Result := Result + ',' + qry.FieldByName('PartsId').AsString;
        qry.Next;
      end;
    finally
      qry.Close;
    end;
  end;
end;*)

procedure TProductForecastGUI.InitProduct(AProductId, AClassId: integer; AAutoReorder : boolean = false);
var
  idx : integer;
begin
  CreateTempTable;
  AutoReorder := AAutoReorder;
  if AProductId <> 0 then
  begin
    AddProduct(AProductId);
    rgProducts.ItemIndex := csSelectedProduct;
  end;
  LoadDepartmentCombo;
  if AClassId = 0 then
    rgDepartments.ItemIndex := csAllDepartments
  else
  begin
    for idx := 0 to cbDepartments.Items.Count - 1  do
      if cbDepartments.Values[idx] = IntToStr(AClassId) then
      begin
        cbDepartments.ItemIndex := idx;
        cbDepartments.Checked[idx] := true;
        Break;
      end;
    rgDepartments.ItemIndex := csSelectedDepartment;
  end;
end;

procedure TProductForecastGUI.LoadDepartmentCombo;
begin
  if qryDepartment.State = dsInactive then
    qryDepartment.Open;
  qryDepartment.First;

  while not qryDepartment.eof do
  begin
    cbDepartments.Items.Add(qryDepartment.FieldByName('ClassName').AsString);
    cbDepartments.Values.Add(qryDepartment.FieldByName('ClassId').AsString);
    qryDepartment.Next;
  end;

  cbDepartments.ItemIndex := 0;
end;

function TProductForecastGUI.MonthNumber(const aShortMonth: string): integer;
var
  idx : integer;
begin
  Result := 1;
  for idx := 0 to 11 do
  begin
    if SameText(aShortMonth, csMonths[idx]) then
    begin
      Result := idx + 1;
      exit;
    end;
  end;
end;

procedure TProductForecastGUI.chkDoRoundClick(Sender: TObject);
begin
  inherited;
  cbRounding.Enabled := chkDoRound.Checked;
end;

procedure TProductForecastGUI.chkUseFormulaClick(Sender: TObject);
begin
(*
  inherited;
//
  if chkUseFormula.Checked  then
  begin
    gbFormula.Enabled := true;
    txtFormula.Enabled := true;
    btnFormulaHelp.Enabled := true;
    btnValidate.Enabled := true;
  end
  else
  begin
    gbFormula.Enabled := false;
    txtFormula.Enabled := false;
    btnFormulaHelp.Enabled := false;
    btnValidate.Enabled := false;
  end;
  *)
  SetUseState(Sender);
end;

procedure TProductForecastGUI.chkUseHistoryClick(Sender: TObject);
begin
(*
  inherited;
//
  if chkUseHistory.Checked then
  begin
    gbHistory.Enabled := true;
    chkQuotes.Enabled := true;
    chkSalesOrders.Enabled := true;
    chkInvoices.Enabled := true;
    lblFromDate.Enabled := true;
    dtFromDate.Enabled := true;
    lblToDate.Enabled := true;
    dtToDate.Enabled := true;
    rbUseAvgDailySales.Enabled := true;
    rbUseAvgMonthlySales.Enabled := true;
    rbUseActualMonthlySales.Enabled := true;
  end
  else
  begin
    gbHistory.Enabled := false;
    chkQuotes.Enabled := false;
    chkSalesOrders.Enabled := false;
    chkInvoices.Enabled := false;
    lblFromDate.Enabled := false;
    dtFromDate.Enabled := false;
    lblToDate.Enabled := false;
    dtToDate.Enabled := false;
    rbUseAvgDailySales.Enabled := false;
    rbUseAvgMonthlySales.Enabled := false;
    rbUseActualMonthlySales.Enabled := false;
  end;
*)
  SetUSeState(Sender);
end;

procedure TProductForecastGUI.cmdCloseClick(Sender: TObject);
begin
  RollbackTransaction;
  Close;
end;

procedure TProductForecastGUI.CopyToSmartOrder(Month: integer);
var
  s : string;
  s1 : string;
//  lSql : string;
  qry : TERPQuery;
begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := GetSharedMyDacConnection;
      s := SelectedProductIDs;
      if rgDepartments.ItemIndex = csSelectedDepartment then
        s1 := GetCommaValues(cbDepartments)
      else
        s1 := '';

      qry.SQL.Clear;
      qry.SQL.Add('update tblProductClasses C');
      qry.SQL.Add('inner join tblReorderPoints R on R.ClassId=C.ClassId and R.ProductId=c.ProductId');
      qry.SQL.Add('set C.ReorderPoint = R.ReorderPoint, C.ReorderAmount=R.ReorderAmount, C.PreferredLevel=R.PreferredLevel');
      qry.SQL.Add('where R.OrderMonth="' + csMonths[Month - 1] + '"');
      if s <> '' then
        qry.SQL.Add('and C.ProductId in (' + s + ')');
      if s1 <> '' then
        qry.SQL.Add('and C.ClassId in (' + s1 + ')');
      qry.ExecSQL;
    finally
      qry.ClosenFree;
    end;
end;

procedure TProductForecastGUI.CreateAdjustRecord;
var
  lRec : TProductAdjustRecord;
begin
  if assigned(OnUseAdjustment) then
  begin
    lRec := BuildAdjustRecord;
    OnUseAdjustment(lRec);
  end;
end;

procedure TProductForecastGUI.CreateTempTable;
var
  scr:TERPScript;
begin
  if TempTableName <> '' then exit;

  TempTableName := GetUserTemporaryTableName('SelectedProducts');
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
      SCR.SQL.clear;
      SCR.SQL.add('Drop table if exists ' + TempTableName+';');
      SCR.SQL.add(' Create Table ' + TempTableName+' (PartsId int(11), ' +
                                                    ' Done ENUM("T","F") DEFAULT "F",' +
                                                    ' unique key Part(PartsId)) ENGINE=MyISAM;');
      MyTable := true;
      scr.Execute;
      TempTableName := TempTableName;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;

(*//  TempTableName
  lName := GetUserTemporaryTableName('SelectedProducts');
  with TERPQuery.Create(nil) do begin
    try
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQl.add('Drop table if exists ' + lName);
      Execute;
      SQL.Clear;
      SQL.add(' Create Table ' + lName);
      SQL.add('(PartsId int(11), Done ENUM("T","F") DEFAULT "F",');
      SQL.add('unique key Part(PartsId)) ENGINE=MyISAM;');
      Execute;
      TempTableName := lName;
      MyTable := true;
    finally
      free;
    end;
  end;*)
end;

procedure TProductForecastGUI.btnOkClick(Sender: TObject);
begin

  if not CheckReorderPoints then  exit;

  if (txtFormula.Text = '') and chkUseFormula.Checked then
  begin
    MessageDlgXP_Vista('You Selected To Use Formula, But Did Not Supply The Formula.', mtWarning, [mbOk], 0);
    Exit;
  end;

  if (rgApplyTo.ItemIndex = 0) or (rgApplyTo.ItemIndex = 2) then begin
    if MessageDlgXP_Vista('This will Modify your Reorder Levels for the Selected Products and Date Range. Do you wish to continue?', mtWarning, [mbYes, mbNo], 0) = mrNo then
      exit;
  end;

  try
    ProductForecastFormula.PostDb;
  except
    on EAbort do begin end;
  end;

  if ProductForecastFormula.Save then
  begin
    MyConnection.Commit;  // so all calcs will be run
    MyConnection.StartTransaction;
    if not SaveByMode then
    begin
      exit;
    end;
    MyConnection.Commit;
    Close;
  end;
end;

procedure TProductForecastGUI.btnPreferredLevelClick(Sender: TObject);
begin
  inherited;
  if Percentage(btnPreferredLevel) then
    btnPreferredLevel.Caption := 'PreferredLevel Value'
  else
    btnPreferredLevel.Caption := 'PreferredLevel  %';
    SetLimits(btnPreferredLevel, spPreferredLevel);
end;

procedure TProductForecastGUI.btnProdListClick(Sender: TObject);
begin
  if fsModal in  FormState then
       CommonFormLib.OpenERPListFormultiselectModal('TProductListExpressGUI',DoOnProdListShow , ProductGridDataSelect)
  else CommonFormLib.OpenERPListFormultiselect('TProductListExpressGUI',DoOnProdListShow, true , ProductGridDataSelect);
end;
(*procedure TProductForecastGUI.OnProductselection(Sender: TwwDbGrid);
var
  st:TStringlist;
  ctr:Integer;
begin
st:= tStringlist.create;
try
  SelectedIDs(sender, 'PartsId' , St, true);
  if st.count > 0 then begin
    rgProducts.itemindex := 1;
    for ctr:= 0 to st.count-1 do
      AddProduct(strtoint(st[ctr]));
  end else begin
    rgProducts.itemindex := 0;
  end;
finally
  Freeandnil(st);
end;

end;*)

procedure TProductForecastGUI.btnReorderAmountClick(Sender: TObject);
begin
  inherited;
  if Percentage(btnReorderAmount)then
  begin
    btnReorderAmount.Caption := 'ReorderAmount Value'
  end
  else
  begin
    btnReorderAmount.Caption := 'ReorderAmount %';
  end;
  SetLimits(btnReorderAmount, spReorderAmount);
end;

procedure TProductForecastGUI.btnReorderLevelsClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TfmReorderLevels' , initReorderLevels);
end;
procedure TProductForecastGUI.initReorderLevels(Sender: TObject);
begin
   if sender is TfmReorderLevels then begin
     TfmReorderLevels(Sender).productIds := ProductIDs ;
   end;
end;
procedure TProductForecastGUI.btnReorderPointClick(Sender: TObject);
begin
  inherited;
  if Percentage(btnReorderPoint) then
    btnReorderPoint.Caption := 'ReorderPoint Value'
  else
    btnReorderPoint.Caption := 'ReorderPoint     %';
  SetLimits(btnReorderPoint, spReorderPoint);
end;

procedure TProductForecastGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Writeguiprefs;
  inherited;
  DropTempTable;
  Action := caFree;
end;

procedure TProductForecastGUI.AddProduct(ProductId: integer);
var
  cmd: TERPCommand;
begin
  if ProductId <= 0 then
    exit;

  cmd := TERPCommand.Create(nil);
  try
    cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
    cmd.SQL.Clear;
    cmd.SQL.Add('insert ignore into ' + TempTableName);
    cmd.SQL.Add('set PartsId = ' + IntToStr(ProductId));
    cmd.Execute;
    if assigned(OnSelectProduct) then
      OnSelectProduct(Self);
    ProductCount := ProductCount + 1;
  finally
    cmd.Free;
  end;
end;

function TProductForecastGUI.AdjustPoint(AOldValue, AValue : double; AMode : boolean) : double;
var
  newMod : Double;
begin
  if aMode then   // %
    Result := AOldValue * (1 + AValue/100)
  else
    Result := AValue;

  if csRounding[cbRounding.ItemIndex] <> 0 then
  begin
    newMod := (trunc(Result) mod csRounding[cbRounding.ItemIndex]) + Frac(Result);
    Result := Result - newMod;
    if (csRounding[cbRounding.ItemIndex] > 0) and (NewMod > 0) then
      Result := Result + csRounding[cbRounding.ItemIndex];
  end;
end;

function TProductForecastGUI.AdjustReorderPoints(aUseClasses : boolean): boolean;
const
  csUsePoints = 'select PC.ProductId, PC.ClassId, o.ReorderPoint,o.PreferredLevel, o.ReorderAmount'#13#10 +
                'from tblProductClasses PC'#13#10 +
                'inner join tblParts P on P.PartsId = PC.ProductId'#13#10 +
                'inner join tblReorderPoints o on o.ProductId = pc.ProductId and o.ClassId = PC.ClassId'#13#10 +
                'where PC.Active = "T" and P.Active="T" and P.AutoReorder = "T" and P.PartType="INV"'#13#10 +
                'and O.OrderMonth="%s"';
  csUseClasses = 'select PC.ProductId, PC.ClassId, PC.ReorderPoint,PC.PreferredLevel, PC.ReorderAmount'#13#10 +
                'from tblProductClasses PC'#13#10 +
                'inner join tblParts P on P.PartsId = PC.ProductId'#13#10 +
                'where PC.Active = "T" and P.Active="T" and P.AutoReorder = "T" and P.PartType="INV"';
var
  qry : TERPQuery;
  scr : TERPScript;
  s : string;

  function CreatePoint(const AName : string; aMode : boolean; aExt : double) : string;
  var
    newMod,
    newValue : double;
  begin
    if aMode then   // %
      newValue := qry.FieldByName(AName).asFloat * (1 + aExt/100)
    else
      newValue :=aExt;

    if csRounding[cbRounding.ItemIndex] <> 0 then
    begin
      newMod := (trunc(newValue) mod csRounding[cbRounding.ItemIndex]) + Frac(newValue);
      newValue := newValue - newMod;
      if (csRounding[cbRounding.ItemIndex] > 0) and (NewMod > 0) then
        newValue := newValue + csRounding[cbRounding.ItemIndex];
    end;
    Result := AName + ' = ' + FloatToStrF(newValue, ffFixed, 4,4);
  end;


begin
  Result := true;

  try
  if (spReorderPoint.Value = 0) and Percentage(btnReorderPoint) and
     (spPreferredLevel.Value = 0) and Percentage(btnPreferredLevel) and
     (spReorderAmount.Value = 0) and Percentage(btnReorderAmount) and
     (not chkDoRound.Checked) then
     exit;

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;
    s := SelectedProductIDs;
    qry.sql.Clear;
    if aUseClasses then
      qry.SQL.Text := csUseClasses
    else
      qry.SQL.Text := Format(csUsePoints, [csMonths[cbMonth.ItemIndex]]);
    if s <> '' then
      qry.SQL.Add('and PC.ProductId in (' + s + ')');

    if rgDepartments.ItemIndex = csSelectedDepartment then
    begin
      s := GetCommaValues(cbDepartments);
      if s <> '' then
        qry.SQL.Add('and PC.ClassId in (' + s + ')');
    end;

    qry.Open;

    if qry.RecordCount = 0 then
      exit;

    scr := TERPScript.Create(nil);
    try
      scr.Connection := GetSharedMyDacConnection;
      while not qry.Eof  do
      begin
        scr.SQL.Clear;
        scr.sql.Add('update tblProductClasses set');
        if rgApplyTo.ItemIndex = csApplyToSmart then
        begin   // just set ReordePoints to the values of the desired month
          scr.sql.Add('ReorderPoint = ' + qry.FieldByName('ReorderPoint').asString + ',');
          scr.sql.Add('PreferredLevel = ' +  qry.FieldByName('PreferredLevel').asString + ',');
          scr.sql.Add('ReorderAmount = ' + qry.FieldByName('ReorderAmount').asString);
        end
        else
        begin  // for Both and ReorderPoints - run calcs
          scr.SQL.Add(CreatePoint('ReorderPoint', Percentage(btnReorderPoint), spReorderPoint.Value) + ',');
          scr.SQL.Add(CreatePoint('PreferredLevel', Percentage(btnPreferredLevel), spPreferredLevel.Value) + ',');
          scr.SQL.Add(CreatePoint('ReorderAmount', Percentage(btnReorderAmount), spReorderAmount.Value));
        end;
        scr.SQL.Add(Format('where ClassId=%s and ProductId=%s;', [qry.FieldByName('ClassId').AsString, qry.FieldByName('ProductId').asString]));

        if rgApplyTo.ItemIndex <> csApplyToSmart then
        begin
          // For Both and ReorderPoints - fix tblReorderPoints
          scr.SQL.Add('update tblReorderPoints set');
          scr.SQL.Add(CreatePoint('ReorderPoint', Percentage(btnReorderPoint), spReorderPoint.Value) + ',');
          scr.SQL.Add(CreatePoint('PreferredLevel', Percentage(btnPreferredLevel), spPreferredLevel.Value) + ',');
          scr.SQL.Add(CreatePoint('ReorderAmount', Percentage(btnReorderAmount), spReorderAmount.Value));
          scr.SQL.Add(Format('where ClassId=%s and ProductId=%s and OrderMonth="%s";',
             [qry.FieldByName('ClassId').AsString, qry.FieldByName('ProductId').asString, csMonths[cbMonth.ItemIndex]]));

        end;
        scr.Execute;
        qry.Next;
      end;
    finally
      scr.Free;
    end;

  finally
    qry.Free;
  end;
  except
    On Exception do
      Result := false;
  end;
end;

function TProductForecastGUI.AdjustReorderPointsTable: boolean;
var
  qry : TERPQuery;
  s, s1, s2 : string;
  idx : integer;
  lMonth : integer;

  procedure SetPoint(const AName : string; aMode : boolean; aExt : double);
  var
    newMod,
    newValue : double;
  begin
    if aMode then   // %
      newValue := qry.FieldByName(AName).asFloat * (1 + aExt/100)
    else
      newValue :=aExt;

    if csRounding[cbRounding.ItemIndex] <> 0 then
    begin
      newMod := (trunc(newValue) mod csRounding[cbRounding.ItemIndex]) + Frac(newValue);
      newValue := newValue - newMod;
      if (csRounding[cbRounding.ItemIndex] > 0) and (NewMod > 0) then
        newValue := newValue + csRounding[cbRounding.ItemIndex];
    end;
    // Result := AName + ' = ' + FloatToStrF(newValue, ffFixed, 4,4);
    qry.FieldByName(AName).asFloat := newValue;
  end;

begin
  Result := true;

  try
    if (spReorderPoint.Value = 0) and Percentage(btnReorderPoint) and
       (spPreferredLevel.Value = 0) and Percentage(btnPreferredLevel) and
       (spReorderAmount.Value = 0) and Percentage(btnReorderAmount) and
       (not chkDoRound.Checked) then
       exit;
    s := ''; s1 := ''; s2 := '';
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := GetSharedMyDacConnection;
      s := SelectedProductIDs;
      qry.sql.text := 'SELECT * from tblReorderPoints';

      if rgDepartments.ItemIndex = csSelectedDepartment then
      begin
        s1 := GetCommaValues(cbDepartments);
      end;

      if cbMonth.Visible then
      begin
        if cbMonth.Items[cbMonth.ItemIndex] <> csAllText then
        begin
          s2 := '';
          for idx := 1 to 12 do
            if SameText(FormatSettings.LongMonthNames[idx],cbMonth.Items[cbMonth.ItemIndex]) then
            begin
              s2 := {'AND} 'OrderMonth="' + csMonths[idx - 1] + '"';
              Break;
            end;
        end;
//        qry.SQL.Add(s);
      end
      else
      begin
          lMonth := MonthOf(dtApplyToFrom.Date);
          idx := 0;
          while lMonth <> MonthOf(dtApplyToTo.Date) do
          begin
            if s2 = '' then
              s2 := '"' + csMonths[lMonth - 1] + '"'
            else
              s2 := s2 + ',"' + csMonths[lMonth - 1] + '"';
            lMonth := lMonth + 1;
            if lMonth > 12 then
              lMonth := 1;
            idx := idx + 1;
          end;
            if s2 = '' then
              s2 := '"' + csMonths[lMonth - 1] + '"'
            else
              s2 := s2 + ',"' + csMonths[lMonth - 1] + '"';
            idx := idx + 1;
          if idx = 11 then
            s2 := ''
          else
            s2 := 'OrderMonth in ('+s2+')';
        end;

      if (s <> '') or (s1 <> '') or (s2 <> '') then
      begin
        // qry.SQL.Add('where' + s +s1 + s2);
        qry.SQL.Add('Where');
        if s <> '' then
        begin
          if (s1 <> '') or (s2 <> '') then
            qry.SQL.Add(s + ' and')
          else
            qry.SQL.Add(s);
        end;
        if s1 <> '' then
        begin
          if s2 <> '' then
            qry.SQL.add(s1 + ' and')
          else
            qry.SQL.Add(s1);
        end;
        if s2 <> '' then
          qry.SQL.Add(s2);
      end;

      qry.Open;
      while not qry.eof do
      begin
        qry.Edit;
        SetPoint('ReorderPoint', Percentage(btnReorderPoint), spReorderPoint.Value);
        SetPoint('PreferredLevel', Percentage(btnPreferredLevel), spPreferredLevel.Value);
        SetPoint('ReorderAmount', Percentage(btnReorderAmount), spReorderAmount.Value);
        qry.Post;
        qry.Next;
      end;
      qry.Close;
    finally
      qry.Free;
    end;
  except
    on Exception do
      Result := false;

  end;
end;

function TProductForecastGUI.ApplyFrom: TDate;
begin
  Result := EncodeDate(YearOf(dtApplyToFrom.Date), MonthOf(dtApplyToFrom.Date), 1);
end;

function TProductForecastGUI.ApplyFromMonth: integer;
begin
  Result := MonthOf(dtApplyToFrom.Date);
end;

function TProductForecastGUI.ApplyMode: TApplyMode;
begin
  if rbUseAvgDailySales.Checked then
    Result := amDailyAvg
  else if rbUseAvgMonthlySales.Checked then
    Result := amMonthlyAvg
  else
    Result := amMonthlyActual;

end;

function TProductForecastGUI.ApplyTo: TDate;
var
  y, m : word;
begin
  y := YearOf(dtApplyToTo.Date);
  m := MonthOf(dtApplyToTo.Date);
  Result := EncodeDate(y, m, DaysInAMonth(y, m));
end;

function TProductForecastGUI.ApplyToMonth: integer;
begin
  Result := MonthOf(dtApplyToTo.Date);
end;

function TProductForecastGUI.ApplyToReorder: boolean;
begin
  Result := CalculateByFormula;
end;

function TProductForecastGUI.ApplyToSmart: boolean;
var
  ProductForecast : TProductForecast;
  idx : integer;
  lDate : TDate;
  lMonths,
  lDepartments : TStringList;
  lCount : integer;
  Form : TSmartOrderGui;
begin

//  lDate := dtApplyToFrom.Date;
  lDate := ApplyFrom;
  // NOTE: Month List is NOT sorted, and in creating SmartOrder i HEAVELY
  // rely on the order of month in the list -not going to re-calc
  // (say, today is november, we want orders to Feb. It means nov, dec, jan, feb
  // SEQUENTIALLY, though month numbers are 11, 12, 1, 2)
  lMonths := TStringList.Create;
  try
    while lDate <= ApplyTo do // dtApplyToTo.Date do
    begin
      lMonths.Add(IntToStr(MonthOf(lDate)));
      lDate := IncMonth(lDate, 1);
    end;

    if rbUseActualMonthlySales.Checked  then
    begin
      lCount := 0;
      lDate := DateFrom;
      while lDate < DateTo do
      begin
        lCount := lCount + 1;
        lDate := IncMonth(lDate, 1);
      end;

      if lCount <> lMonths.Count then
      begin
        MessageDlgXP_Vista('To Use Actual Monthly Sales, Number of Month in History''s From Month and To Month'#13#10+
          'Must Be The Same As In Apply To Month From and Month To.', mtWarning, [mbOk], 0);
        Result := false;
        exit;
      end;

    end;

    ProductForecast := TProductForecast.Create(nil);
    try
      if ProductCount > 0 then
        ProductForecast.TempTableName := TempTableName
      else
        ProductForecast.TempTableName := '';

      if rgDepartments.ItemIndex = csSelectedDepartment then
      begin
        lDepartments := TStringList.Create;
        for idx := 0 to cbDepartments.Items.Count - 1 do
        begin
          if cbDepartments.Checked[idx] then
          begin
            lDepartments.Add(cbDepartments.Values[idx]);
          end;
        end;
      end
      else
        lDepartments := nil;
      try
        ProductForecast.OnProgressBarInit := DoProgressBarInit;
        ProductForecast.OnProgressBarSmartOrder := DoProgressBarSmartOrder;
        ProductForecast.AdjustRecord := BuildAdjustRecord;
        try
//          idx := ProductForecast.CreateSmartOrderOnApply(lMonths, lDepartments);
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          idx := ProductForecast.CreateSmartOrderOnSmartApply(lMonths, lDepartments, ApplyMode); //rgUseAverage.ItemIndex = 0);
          case idx of
            -1 : begin
                   MessageDlgXP_Vista('Nothing Is To Be Ordered Based On Your Settings', mtInformation, [mbOK], 0);
                   Result := true;
                 end;
             0 : begin
                   MessageDlgXP_Vista('Failed To Create Smart Orders', mtInformation, [mbOK], 0);
                   Result := false;
                 end;
             else begin
                   Form := TSmartOrderGUI(GetComponentByClassName('TSmartOrderGUI'));
                   if Assigned(Form) then
                   begin //if has acess
                       with TSmartOrderGUI(Form) do
                       begin
                         KeyID := idx;
                         FormStyle := fsmdiChild;
                       end;
                   end;
                   Result := true;
                 end;
          end;
        finally
          ProductForecast.AdjustRecord.Free;
          ProductForecast.AdjustRecord := nil;
        end;
      finally
        lDepartments.Free;
      end;
    finally
      ProductForecast.Free;
    end;
  finally
    lMonths.Free;
    DoHideProgressBar;
  end;
end;

procedure TProductForecastGUI.btnFormulaHelpClick(Sender: TObject);
begin
  CommonLib.MessageDlgXP_Vista('A = Re-order point'+#13+#10+
             'B = Available quantity (adjusted for allocated stock)'+#13+#10+
             'C = On order quantity'+#13+#10+
             'D = Usage amount per day'+#13+#10+
             'E = Normal delivery time in days', mtInformation, [mbOK], 0);
end;

procedure TProductForecastGUI.btnFromPeriodSalesClick(Sender: TObject);
begin
  inherited;

  if fsModal in  FormState then
    OpenERPListFormModal('TSalesSummary_ReportGUI',nil, initsaleslist)
  else
    OpenERPListForm('TSalesSummary_ReportGUI' , initsaleslist );

end;
procedure TProductForecastGUI.initsaleslist(Sender:TObject);
begin
  if  (Sender is TSalesSummary_ReportGUI) then begin
    TSalesSummary_ReportGUI(sender).Qrymain.sql.text := SalessummarySQL(0, iif(rgDepartments.ItemIndex = csAllDepartments , 0 ,SelectedClassIds ) ,
                                                        chkInvoices.checked,
                                                        chkSalesOrders.checked,
                                                        chkQuotes.checked ,
                                                        chkUseHistory.checked ,
                                                        dtFromDate.date , IncSecond(IncDay(endofthemonth(dtToDate.DateTime), 1), -1),
                                                        iif(rgProducts.ItemIndex <> csSelectedProduct , '' ,TempTableName  ) ,
                                                        iif(rbUseAvgDailySales.Checked ,1, iif(rbUseActualMonthlySales.Checked ,2,iif(rbUseAvgMonthlySales.Checked ,3,0))) , true);
    TSalesSummary_ReportGUI(sender).RefreshOrignalSQL(False);
  end;
end;
procedure TProductForecastGUI.btnHowToClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Product Forecast Formula');
end;

function TProductForecastGUI.Percentage(btn: TDNMSpeedButton): boolean;
begin
  Result := pos('%', btn.Caption) > 0;
end;

procedure TProductForecastGUI.PreviewForProduct;
begin
  ProductForecastFormula.PostDb;
  ProductForecastFormula.EditDB;
end;

procedure TProductForecastGUI.ProcessAutoAdjustment;
//var
//  lRec : TProductAdjustRecord;
begin
  if not Assigned(OnUseAdjustment) then
    exit;

  if rgApplyTo.ItemIndex = csApplyToReorder then
    exit;
(*
  lRec := CreateAdjustRecord;

  OnUseAdjustment(lRec);
*)
  CreateAdjustRecord;
end;
procedure TProductForecastGUI.ChooseProducts(Ids:String);
var
    scr :TERPScript;
begin
  CreateTempTable;
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    scr.SQL.clear;
    scr.SQL.add('truncate ' + TempTableName +';');
    if Ids<> '' then scr.SQL.Add('insert ignore into ' + TempTableName+
                               ' (PartsId) Select PartsId from tblparts where partsId in (' + Ids + ');');
    scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;
procedure TProductForecastGUI.ProductGridDataSelect(Sender: TwwDbGrid);
var
  s:String;
begin
  inherited;
  s := SelectedIDs(sender, 'PartsId');

  if s<> '' then rgProducts.ItemIndex := csSelectedProduct else rgProducts.ItemIndex := csAllProducts;
  ChooseProducts(s);
  if s<> '' then
      if assigned(fOnSelectProduct) then
        fOnSelectProduct(Self);

  (*scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    scr.SQL.clear;
    scr.SQL.add('truncate ' + TempTableName +';');
    if s<> '' then scr.SQL.Add('insert ignore into ' + TempTableName+
                               ' (PartsId) Select PartsId from tblparts where partsId in (' + s + ');');
    scr.Execute;
    if s<> '' then
      if assigned(fOnSelectProduct) then
        fOnSelectProduct(Self);
  finally
    DbSharedObj.ReleaseObj(scr);
  end;*)
(*var
  cmd: TERPCommand;
  i: integer;
begin
  //UserHasSelectedProducts := false;
  cmd := TERPCommand.Create(nil);
  try
    cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
    Sender.DataSource.DataSet.DisableControls;
    try
      if Sender.SelectedList.Count > 0 then
        rgProducts.ItemIndex := csSelectedProduct
      else
        rgProducts.ItemIndex := csAllProducts;
      ProductCount := Sender.SelectedList.Count;
      // clear table
      cmd.SQL.Clear;
      cmd.SQL.Text := 'delete from ' + TempTableName;
      cmd.Execute;

      for i := 0 to Sender.SelectedList.Count - 1 do
      begin
//        UserHasSelectedProducts := true;
        Sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList.Items[i]);
        cmd.SQL.Clear;
        cmd.SQL.Add('insert ignore into ' + TempTableName);
        cmd.SQL.Add('set PartsId = ' + IntToStr(Sender.DataSource.DataSet.FieldByName('PartsId').AsInteger));
        cmd.Execute;
      end;
      if Sender.SelectedList.Count > 0 then
        if assigned(OnSelectProduct) then
          OnSelectProduct(Self);

    finally
      Sender.DataSource.DataSet.EnableControls;
    end;
  finally
    cmd.Free;
  end;*)

end;

procedure TProductForecastGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
//
  chkUseFormulaClick(Self);
  chkUseHistoryClick(Self);
end;

procedure TProductForecastGUI.rbUseActualMonthlySalesClick(Sender: TObject);
begin
  rbUseAvgDailySales.Checked := false;
  rbUseAvgMonthlySales.Checked := false;
end;

procedure TProductForecastGUI.rbUseAvgDailySalesClick(Sender: TObject);
begin
  rbUseActualMonthlySales.Checked := false;
  rbUseAvgMonthlySales.Checked := false;
end;

procedure TProductForecastGUI.rbUseAvgMonthlySalesClick(Sender: TObject);
begin
  rbUseAvgDailySales.Checked := false;
  rbUseActualMonthlySales.Checked := false;
end;

procedure TProductForecastGUI.rgApplyToClick(Sender: TObject);

  procedure SetModeSmart(value : boolean);
  begin
  (*
    txtFormula.Enabled := Value;
    btnFormulaHelp.Enabled := Value;
    btnValidate.Enabled := Value;
    gbFormula.Enabled := Value;
    gbHistory.Enabled := Value;
    chkQuotes.Enabled := Value;
    chkSalesOrders.Enabled := Value;
    chkInvoices.Enabled := Value;
    lblFromDate.Enabled := value;
    lblToDate.Enabled := false;
    dtFromDate.Enabled := Value;
    dtToDate.Enabled := Value;
    chkUseReorderAmount.Enabled := Value;
    *)
    chkUseAvailQty.Enabled := Value;
//    chkUseReorderAmount.Enabled := Value;
  end;

  procedure SetModeReorder(Value : boolean);
  begin
    lblDescription.Enabled := Value;
    btnReorderPoint.Enabled := Value;
    btnPreferredLevel.Enabled := value;
    btnReorderAmount.Enabled := Value;
    cbMonth.Enabled := Value;
    lblMonth.Enabled := Value;
//    cbMonth.Visible := Value;
//    lblMonth.Visible := Value;
    spReorderPoint.Enabled := Value;
    spPreferredLevel.Enabled := Value;
    spReorderAmount.Enabled := Value;
    chkDoRound.Enabled := Value;
    lblRounding.Enabled := Value;
    cbRounding.Enabled := Value;
  end;
begin
  inherited;
  (*
  if rgApplyTo.ItemIndex = csApplyToReorder then
  begin
   SetModeSmart(False);
   SetModeReorder(true);
  end
  else if rgApplyTo.ItemIndex = csApplyToSmart then
  begin
    SetModeSmart(true);
    SetModeReorder(false);
    pnlBottom.Enabled := false;
  end
  else
  begin
    SetModeSmart(true);
    SetModeReorder(true);
    pnlBottom.Enabled := true;
  end;
  *)
  if rgApplyTo.ItemIndex = csApplyToReorder then
  begin
   SetModeSmart(False);
    SetModeReorder(true);
    pnlLevels.Enabled := true;
  end
  else if rgApplyTo.ItemIndex = csApplyToSmart then
  begin
    SetModeSmart(true);
    SetModeReorder(false);
    pnlLevels.Enabled := false;
  end
  else
  begin
    SetModeSmart(true);
    SetModeReorder(true);
    pnlLevels.Enabled := true;
  end;
end;

procedure TProductForecastGUI.rgDepartmentsClick(Sender: TObject);
begin
  inherited;

  SetAllCombo(cbDepartments, rgDepartments.ItemIndex = csAllDepartments);
end;

function TProductForecastGUI.SaveByMode: boolean;
begin
{
 Apply To ReorderPoints
 - Set tblProductClasses reorder data as per selected month
 - Run Forecast formula and set reorder data in Classes as calculated
 - run adjustments
 - Set tblReorderPoints for this month as calculated

 Apply to Smart Order
 - Adjust reorderPoints table
 - Set Classes reorder data to the selected month
 - Set AutoUpdate rounding

 Both

}
  Result := true;  // make compiler happy
  try
    if (MyTable) or (not chkUseHistory.Checked and not chkUseFormula.Checked) then
      Result := AdjustReorderPointsTable
    else
    begin
      case rgApplyTo.ItemIndex of
        csApplyToReorder : begin
          Result := ApplyToReorder;
        end;
        csApplyToSmart : begin
          Result := ApplyToSmart;
          CopyToSmartOrder(MonthOf(Today));
          if Result then
            ProcessAutoAdjustment;
        end;
        csApplyToBoth : begin
          Result := ApplyToReorder;  // Fix order points
          if Result then
            Result := ApplyToSmart;
          if Result then
          begin
            CopyToSmartOrder(MonthOf(Today));  // Set Current month changed points in ProductClass
            ProcessAutoAdjustment;             // Create Adjustment record for
          end;
        end;
      end;
    end;
  finally
     updateproductclasses;
  end;
end;

procedure TProductForecastGUI.updateproductclasses;
var
  scr :TERPScript;
begin
  inherited;
  scr := DbSharedObj.GetScript(MyConnection);
  try
    scr.SQL.text:= 'insert ignore into tblproductclasses ' +
                    ' (ProductID, classId, classname, productname , Useproductforecastformula)  ' +
                    ' select distinct RP.productId, RP.classId , C.classname , P.partname , "F"   ' +
                    ' from tblReorderPoints RP  ' +
                    ' inner join tblparts P on RP.productId = P.partsId inner join tblclass C on c.classid = RP.classid';
    scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;

procedure TProductForecastGUI.SetAllCombo(aCombo: TCheckComboBox;
  AAll: boolean);
const
  csAll = '-- ALL --';
begin
  if AAll then
  begin
    aCombo.Text := csAll;
    aCombo.Enabled := false;
    aCombo.Invalidate;
  end
  else
  begin
    aCombo.Enabled := true;
    SendMessage(aCombo.Handle, CBN_CLOSEUP, 0, 0);
  end;
end;

procedure TProductForecastGUI.SetAutoReorder(const Value: boolean);
begin
  fAutoReorder := Value;
  if Value then
  begin
    cbMonth.Visible := false;
    lblMonth.Visible := false;
    //chkDoRound.Top := btnReorderAmount.Top;
  end
  else
  begin
    cbMonth.ItemIndex := 0;
    pnlHistory.Visible := false;
    rgApplyTo.Visible := false;
    pnlProducts.Top := rgApplyTo.Top;
    pnlLevels.Top := pnlProducts.Top + pnlProducts.Height + 2;
//    pnlBottom.Top := rgApplyTo.Top;//pnlTop.Top;
    Self.ClientHeight := pnlLevels.Top + pnlLevels.Height + btnOk.Height + 24;
    TitleLabel.Caption := 'Reorder Points Adjustment';
  end;
end;

procedure TProductForecastGUI.SetLimits(btn: TDNMSpeedButton; sp: TSpinEdit);
begin
  if Percentage(btn) then
  begin
    sp.MinValue := -100;
    sp.MaxValue := 100;
  end
  else
  begin
    sp.MinValue := 0;
    sp.MaxValue := 0;
  end;

end;

procedure TProductForecastGUI.SetOnUseAdjustment(
  const Value: TNotifyEvent);
begin
  FOnUseAdjustment := Value;
end;

function TProductForecastGUI.CreateReorderPointsFromProductclass(fSQL:String): boolean;
var
  scr :TERPScript;
  idx : integer;
  s:String;
begin
  inherited;
  Result := True;
  s:= fSQL;
  s := replacestr(s  ,cs_Pccount ,' Select Distinct PC.ProductId, PC.ClassId, PC.ReorderPoint, PC.PreferredLevel, PC.ReorderAmount , :Month from ');
  s := replacestr(s  ,'and ifnull(R.PointID,0)=0' , '');

  scr := DbSharedObj.GetScript(ProductForecastFormula.connection.Connection);
  try
    try
      for idx := 0 to 11 do begin
        scr.SQL.Add('insert IGNORE into tblReorderPoints (ProductId, ClassId, ReorderPoint, PreferredLevel, ReorderAmount, OrderMonth) ' +
                     replacestr(s  ,':Month', quotedstr(csMonths[idx]))+';');
      end;
      scr.SQL.add(replacestr(replacestr(fSQL  , cs_PCCount ,'update '), ' where ' , ' Set PC.Useproductforecastformula ="T" where ' )+';');
      clog(scr.SQL.text);
      scr.Execute;

    Except
      on E:Exception do begin
          REsult := False;
      end;
    end;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;


(*var
  qry : TERPQuery;
  scr : TERPScript;
  idx : integer;
begin
  Result := true;
  AQry.First;

  if AQry.RecordCount = 0 then
    exit;
  try
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := GetSharedMyDacConnection;
//      qry1 := TERPQuery.Create(nil);
     scr := TERPSCript.Create(nil);
    try
      scr.Connection := GetSharedMyDacConnection;
      while not AQry.EOF do
      begin
        qry.SQL.Text := 'SELECT ProductId, ClassId, ReorderPoint, PreferredLevel, ReorderAmount';
        qry.SQL.Add('FROM tblproductclasses where ProductId=' + AQry.FieldByName('ProductId').AsString + ' and ClassId = ' + AQry.FieldByName('ClassId').asString);
        qry.Open;
        try
          if qry.RecordCount <> 0 then
          begin
            scr.SQL.Clear;
            for idx := 0 to 11 do
            begin
              scr.SQL.Add('insert into tblReorderPoints (ProductId, ClassId, ReorderPoint, PreferredLevel, ReorderAmount, OrderMonth) Values(');
              scr.SQL.Add(qry.FieldByName('ProductId').AsString + ',' + qry.FieldByName('ClassId').AsString + ',' +
                          qry.FieldByName('ReorderPoint').AsString + ',' + qry.FieldByName('PreferredLevel').AsString + ',' +
                          qry.FieldByName('ReorderAmount').AsString + ',"' + csMonths[idx] + '");');
            end;
            scr.Execute;
          end;
        finally
          qry.Close;
        end;
        AQry.Next;
      end;
    finally
      scr.Free;
    end;
  finally
    qry.Free;
  end;
  except
    Result := false;
  end;*)
end;
(*
procedure TProductForecastGUI.CreateReorderPointsFromProductclassByMonth(const AMonth : string);
const
  csQryMonths  = 'update tblProductClasses C'#13#10+
              'inner join tblReorderPoints P'#13#10+
              'on P.ProductId=C.ProductId and P.ClassId = C.ClassId'#13#10+
              'set C.ReorderPoint=P.ReorderPoint,'#13#10+
              'C.PreferredLevel=P.PreferredLevel,'#13#10+
              'C.ReorderAmount = P.ReorderAmount where';
var
  qry : TERPQuery;
  s : string;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;

    s := '';
    if rgProducts.ItemIndex = csSelectedProduct then
    begin
      qry.SQL.Text := 'select * from ' + TempTableName;
      qry.Open;
      try
        while not qry.eof do
        begin
          if s = '' then
            s := qry.FieldByName('PartsId').AsString
          else
            s := s + ',' + qry.FieldByName('PartsId').AsString;
          qry.Next;
        end;
      finally
        qry.Close;
      end;
    end;

    qry.SQL.Text := csQryMonths;
//    qry.SQL.Add('P.OrderMonth="' + csMonths[cbMonth.ItemIndex] +'"');
    qry.SQL.Add(Format('P.OrderMonth="%s"', [AMonth]));
    if s <> '' then
      qry.SQL.Add('and C.ProductId in (' + s + ')');

    if rgDepartments.ItemIndex = csSelectedDepartment then
    begin
      s := GetCommaValues(cbDepartments);
      if s <> '' then
        qry.SQL.Add('and C.ClassId in (' + s + ')');
    end;
    qry.ExecSQL;
  finally
    qry.Free;
  end;

end;
*)
procedure TProductForecastGUI.SetTempTableName(const Value: string);
var
  qry : TERPQuery;
begin
  fTempTableName := Value;
  if Value <>'' then  begin
    if not tableexists (Value) then begin
        ProductCount := 0;
    end else begin
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        qry.SQL.Text := 'select count(*) from ' + Value;
        qry.Open;
        if qry.RecordCount = 0  then
          ProductCount := 0
        else
          ProductCount := qry.Fields[0].AsInteger;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
    end;
  end;
  MyTable := false;
  rgApplyTo.ItemIndex := 0;
  rgApplyTo.Enabled := true;
  if ProductCount > 0 then
    rgProducts.ItemIndex := 1
  else
    rgProducts.ItemIndex := 0;
end;

procedure TProductForecastGUI.SetUseState(Sender: TObject);
begin
  // allowed states are
  // chkUseHistory   chkUseFormula
  //       0          0               -- Simple Rounding
  //       0          1
  //       1          0
  if (Sender = chkUseFormula) and (chkUseFormula.Checked) then
  begin
    chkUseHistory.Checked := false;
  end
  else if (Sender = chkUseHistory) and (chkUseHistory.Checked) then
    chkUseFormula.Checked := false;

  if chkUseHistory.Checked then
  begin
    gbHistory.Enabled := true;
    chkQuotes.Enabled := true;
    chkSalesOrders.Enabled := true;
    chkInvoices.Enabled := true;
    lblFromDate.Enabled := true;
    dtFromDate.Enabled := true;
    lblToDate.Enabled := true;
    dtToDate.Enabled := true;
    rbUseAvgDailySales.Enabled := true;
    rbUseAvgMonthlySales.Enabled := true;
    rbUseActualMonthlySales.Enabled := true;
  end
  else
  begin
    gbHistory.Enabled := false;
    chkQuotes.Enabled := false;
    chkSalesOrders.Enabled := false;
    chkInvoices.Enabled := false;
    lblFromDate.Enabled := false;
    dtFromDate.Enabled := false;
    lblToDate.Enabled := false;
    dtToDate.Enabled := false;
    rbUseAvgDailySales.Enabled := false;
    rbUseAvgMonthlySales.Enabled := false;
    rbUseActualMonthlySales.Enabled := false;
  end;

  if chkUseFormula.Checked  then
  begin
    gbFormula.Enabled := true;
    txtFormula.Enabled := true;
    btnFormulaHelp.Enabled := true;
    btnValidate.Enabled := true;
  end
  else
  begin
    gbFormula.Enabled := false;
    txtFormula.Enabled := false;
    btnFormulaHelp.Enabled := false;
    btnValidate.Enabled := false;
  end;

end;


procedure TProductForecastGUI.cboDepartmentCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  PreviewForProduct;
end;

procedure TProductForecastGUI.cboProductCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  PreviewForProduct;
end;

procedure TProductForecastGUI.btnValidateClick(Sender: TObject);
begin
  if (txtFormula.Text = '') or (ProductForecastFormula.ValidateFormula) then begin
    CommonLib.MessageDlgXP_Vista('Formula is OK!', mtInformation, [mbOK], 0);
    DelayedPreviewForProduct;
  end;
end;

function TProductForecastGUI.BuildAdjustRecord: TProductAdjustRecord;
begin
    Result := TProductAdjustRecord.Create;
    Result.ReorderPointPercent := Percentage(btnReorderPoint);
    Result.ReorderPointValue := spReorderPoint.Value;
    Result.PreferredLevelPercent := Percentage(btnPreferredLevel);
    Result.PreferredLevelValue := spPreferredLevel.Value;
    Result.ReorderAmountPercent := Percentage(btnReorderAmount);
    Result.ReorderAmountValue := spReorderAmount.Value;
    Result.RoundPoints := chkDoRound.Checked;
    if Result.RoundPoints then
      Result.RoundValue := csRounding[cbRounding.ItemIndex];
end;


function TProductForecastGUI.CalculateByFormula : boolean;
var
  ProductForecast : TProductForecast;
  psParts, fsClasses : string;
  qry : TERPQuery;
  lValue : double;
  lCount1,
  lCount : integer;
  lDate : TDate;
  lCurrentMonth : TDate;
  lProduct, lClass : integer;
begin
  Result := false;

  lCurrentMonth := Today;
  if rbUseActualMonthlySales.Checked  then
  begin
    lCount := trunc(DecimalRoundDbl(MonthSpan(datefrom , dateTo ) ,0 , drrndup));//lCount := 0;    lDate := DateFrom;    while lDate < DateTo do    begin      lCount := lCount + 1;      lDate := IncMonth(lDate, 1);    end;
    lCount1:= trunc(DecimalRoundDbl(MonthSpan(ApplyFrom, ApplyTo) ,0 , drrndup));//lCount1 := 0;   lDate := ApplyFrom;   while lDate < ApplyTo do   begin      lCount1 := lCount1 + 1;    lDate := IncMonth(lDate, 1);    end;


    if lCount <> lCount1 then
      begin
        MessageDlgXP_Vista('To Use Actual Monthly Sales, Number of Month in History''s From Month and To Month'#13#10+
          'Must Be The Same As In Apply To Month From and Month To.', mtWarning, [mbOk], 0);
        Result := false;
        exit;
      end;

    end;

  ProductForecast := TProductForecast.Create(nil);
  try
//    AdjustRecord := CreateAdjustRecord;
//    ProductForecast.AdjustRecord := AdjustRecord;

    qry := TERPQuery.Create(nil);
    try
      qry.Connection := GetSharedMyDacConnection;

      psParts := SelectedProductIDs;

      qry.SQL.Text := 'select R.ProductId, R.ClassId, R.ReorderPoint, R.PreferredLevel,';
      qry.SQL.Add('R.ReorderAmount, R.OrderMonth, cast(ifnull(P.DateCreated, "1999-01-01") as Date) as DateCreated');
      qry.SQL.Add('from tblReorderPoints R inner join tblParts P on R.ProductId=P.PartsId');
      if ApplyTo > ApplyFrom then
      begin
        qry.SQL.Add('WHERE OrderMonth IN');
        lDate := ApplyFrom;
        fsClasses := '';
        while lDate < ApplyTo do begin
            if fsClasses = '' then fsClasses := '"' + csMonths[MonthOf(lDate) - 1] + '"'
          else fsClasses := fsClasses + ',"' + csMonths[MonthOf(lDate) - 1] + '"';
          lDate := IncMonth(lDate, 1);
        end;
        qry.SQL.Add('(' + fsClasses + ')');
      end else
        qry.sql.Add('where OrderMonth ="' + csMonths[ApplyFromMonth - 1] + '"');

      if rgDepartments.ItemIndex = csSelectedDepartment then fsClasses := GetCommaValues(cbDepartments)
      else fsClasses := '';

      if psParts   <> '' then qry.SQL.Add('and ProductId in (' + psParts   + ')');
      if fsClasses <> '' then qry.SQL.Add('and ClassId   in (' + fsClasses + ')');

      qry.Open;

      lProduct := 0;
      lClass := 0;
      while not qry.eof do begin
        if not rbUseActualMonthlySales.Checked then begin
          Result := ProductForecast.CalcReorderPoint(qry.FieldByName('ProductId').AsInteger, qry.FieldByName('ClassId').AsInteger,
                                                      qry.FieldByName('ReorderPoint').AsFloat, //qry.FieldByName('PreferredLevel').asFloat,
                                                      //qry.FieldByName('ReorderAmount').AsFloat, // DaysInTheMonth(qry.FieldByName('OrderMonth').asString),lValue);
                                                      MonthNumber(qry.FieldByName('OrderMonth').asString), //qry.FieldByName('DateCreated').AsDateTime,
                                                      ApplyMode, lValue);
        end else begin
          if (lProduct <> qry.FieldByName('ProductId').asInteger ) and (lProduct = 0 )then begin
              lCurrentMonth := DateFrom;
              lProduct := qry.FieldByName('ProductId').AsInteger;
          end;
          if lClass <> qry.FieldByName('ClassId').AsInteger then begin
            lClass := qry.FieldByName('ClassId').AsInteger;
            lCurrentMonth := DateFrom;
          end;

          lValue := ProductForecast.CalcSalesInAMonth(lProduct, lClass, lCurrentMonth);

          if lValue <= 0 then lValue := 0
          else if chkUseReorderAmount.Checked then begin
            if (lValue < qry.FieldByName('ReorderAmount').AsFloat) then lValue := qry.FieldByName('ReorderAmount').AsFloat
            else if Int(lValue / qry.FieldByName('ReorderAmount').AsFloat) = (lValue / qry.FieldByName('ReorderAmount').AsFloat) then
            else lValue := (Int(lValue / qry.FieldByName('ReorderAmount').AsFloat) + 1) * qry.FieldByName('ReorderAmount').AsFloat;
          end;
          lCurrentMonth := IncMonth(lCurrentMonth, 1);
          Result := true;
        end;
        if Result then begin
           qry.Edit;
          qry.FieldByName('ReorderPoint').AsFloat   := AdjustPoint(lValue, spReorderPoint.Value, Percentage(btnReorderPoint));
          qry.FieldByName('PreferredLevel').AsFloat := AdjustPoint((*qry.FieldByName('PreferredLevel').AsFloat, *)lValue,spPreferredLevel.Value, Percentage(btnPreferredLevel));
          qry.FieldByName('ReorderAmount').AsFloat  := AdjustPoint((*qry.FieldByName('ReorderAmount').AsFloat, *)lValue,spReorderAmount.Value, Percentage(btnReorderAmount));
        end;
        qry.Next;
      end;

    finally
      qry.ClosenFree;
    end;
  finally
    ProductForecast.Free;
  end;
end;

procedure TProductForecastGUI.DelayedPreviewForProductEvent(Sender: TObject);
begin
  DelayedPreviewForProduct;
end;

procedure TProductForecastGUI.DoOnProdListShow(Sender: TObject);
begin
  TBaseListingGUI(Sender).FilterString := 'PartType = "INV" and Discontinued = "F" and Active = "T"';
  TBaseListingGUI(Sender).SearchMode := smFullList;
  TBaseListingGUI(Sender).Selectrecordsfieldname := 'PartsId';
  TBaseListingGUI(Sender).SelectrecordsValues := ProductIDs;
end;

procedure TProductForecastGUI.DoProgressBarInit(Sender: TObject;
  MaxValue: Integer);
begin
  DoShowProgressBar(MaxValue, 'Creating Smart Orders');
end;

procedure TProductForecastGUI.DoProgressBarSmartOrder(Sender: TObject;
  const aMessage: string);
begin
  DoStepProgressBar(AMessage);
end;

procedure TProductForecastGUI.DoProgressBarStepIt(Sender: TObject);
begin
  DoStepProgressBar;
end;

procedure TProductForecastGUI.DropTempTable;
var
  scr : TERPScript;
  Form : TForm;
begin
  if not MyTable then
    exit;

  Form:= TForm(FindExistingComponent('TfmReorderPoints'));
  if assigned(Form) then
    TBaseListingGUI(Form).btnRequery.Click;    // actRefreshQryExecute(self);

  scr := TERPScript.Create(nil);
  try
    scr.Connection := GetSharedMyDacConnection;
    scr.SQL.Text := 'drop table ' + TempTableName;
    scr.Execute;
  finally
    scr.Free;
  end;


end;

procedure TProductForecastGUI.WMPostMsgToSelf(var Msg: TMessage);
begin
  PreviewForProduct;
end;

function TProductForecastGUI.DateFrom: TDate;
begin
  Result := EncodeDate(YearOf(dtFromDate.Date), MonthOf(dtFromDate.Date), 1);
end;

function TProductForecastGUI.DateTo: TDate;
var
  y, m : word;
begin
  y := YearOf(dtToDate.Date);
  m := MonthOf(dtToDate.Date);
  Result := EncodeDate(y, m, DaysInAMonth(y, m));
end;

function TProductForecastGUI.DaysInTheMonth(const AShortMonth: string): integer;
var
  idx : integer;
begin
  Result := 30;  // Make compiler happy
  for idx := 0 to 11 do
  begin
    if SameText(aShortMonth, csMonths[idx]) then
      Result := DaysInAMonth(YearOf(Date), idx + 1);
  end;
end;

procedure TProductForecastGUI.DelayedPreviewForProduct;
begin
  PostMessage(Handle, WM_PostMsgToSelf, 0, 0);
end;

procedure TProductForecastGUI.dtApplyToFromChange(Sender: TObject);
begin
  inherited;
  if screen.activecontrol <>dtApplyToFrom then exit;
  if dtApplyToFrom.date >=dtApplyToTo.date then begin
         if rbUseAvgDailySales.checked      then dtApplyToTo.date := endofthemonth(dtApplyToFrom.date)
    else if rbUseAvgMonthlySales.checked    then dtApplyToTo.date := endoftheyear(dtApplyToFrom.date)
    else if rbUseActualMonthlySales.checked then dtApplyToTo.date := endoftheyear(dtApplyToFrom.date);
  end;
end;

procedure TProductForecastGUI.dtApplyToToChange(Sender: TObject);
begin
  inherited;
  if screen.activecontrol <>dtApplyToto then exit;
  if dtApplyToFrom.date >=dtApplyToTo.date then begin
         if rbUseAvgDailySales.checked      then dtApplyTofrom.date := startofthemonth(dtApplyToto.date)
    else if rbUseAvgMonthlySales.checked    then dtApplyTofrom.date := startoftheyear(dtApplyToto.date)
    else if rbUseActualMonthlySales.checked then dtApplyTofrom.date := startoftheyear(dtApplyToto.date);
  end;

end;

procedure TProductForecastGUI.dtFromDateChange(Sender: TObject);
begin
  inherited;
  if rbUseActualMonthlySales.Checked then
    dtApplyToFrom.DateTime := dtFromDate.DateTime;
end;

procedure TProductForecastGUI.dtFromDateKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_BACK then begin
    Key := 0;
    if not (Sender is TwwDBDateTimePicker) then Exit;
    with TwwDBDateTimePicker(Sender) do begin
      Clear;
      DataSource.DataSet.FieldByName(DataField).Clear;
    end;
    DelayedPreviewForProduct;
  end;
end;

procedure TProductForecastGUI.dtToDateChange(Sender: TObject);
begin
  inherited;
  if rbUseActualMonthlySales.Checked then
    dtApplyToTo.DateTime := dtToDate.DateTime;
end;
procedure TProductForecastGUI.readguiprefs;
begin
  if guiprefs.active =False then guiprefs.active := True;
  rgProducts.ItemIndex            :=  GuiPrefs.Node['Options.rgProducts'].asInteger;
  rgDepartments.ItemIndex         :=  GuiPrefs.Node['Options.rgDepartments'].asInteger;
  chkUseHistory.Checked           :=  GuiPrefs.Node['Options.chkUseHistory'].asBoolean;
  chkUseFormula.Checked           :=  GuiPrefs.Node['Options.chkUseFormula'].asBoolean;
  chkQuotes.Checked               :=  GuiPrefs.Node['Options.chkQuotes'].asBoolean;
  chkSalesOrders.Checked          :=  GuiPrefs.Node['Options.chkSalesOrders'].asBoolean;
  chkInvoices.Checked             :=  GuiPrefs.Node['Options.chkInvoices'].asBoolean;
  chkUseNonERPsales.Checked       :=  GuiPrefs.Node['Options.chkUseNonERPsales'].asBoolean;
  rbUseAvgDailySales.Checked      :=  GuiPrefs.Node['Options.rbUseAvgDailySales'].asBoolean;
  rbUseAvgMonthlySales.Checked    :=  GuiPrefs.Node['Options.rbUseAvgMonthlySales'].asBoolean;
  rbUseActualMonthlySales.Checked :=  GuiPrefs.Node['Options.rbUseActualMonthlySales'].asBoolean;
  chkUseAvailQty.Checked          :=  GuiPrefs.Node['Options.chkUseAvailQty'].asBoolean;
  chkUseReorderAmount.Checked     :=  GuiPrefs.Node['Options.chkUseReorderAmount'].asBoolean;
  dtApplyToFrom.Date              :=  GuiPrefs.Node['Options.dtApplyToFrom'].asDatetime;
  dtApplyToTo.Date                :=  GuiPrefs.Node['Options.dtApplyToTo'].asDatetime;
  spReorderPoint.Value            :=  GuiPrefs.Node['Options.spReorderPoint'].asInteger;
  spPreferredLevel.Value          :=  GuiPrefs.Node['Options.spPreferredLevel'].asInteger;
  spReorderAmount.Value           :=  GuiPrefs.Node['Options.spReorderAmount'].asInteger;
  cbMonth.ItemIndex               :=  GuiPrefs.Node['Options.cbMonth'].asInteger;
  chkDoRound.Checked              :=  GuiPrefs.Node['Options.chkDoRound'].asBoolean;
  cbRounding.ItemIndex            :=  GuiPrefs.Node['Options.cbRounding'].asInteger;
  ProductIDs                      :=  GuiPrefs.Node['Options.ProductIDs'].asString;
  ClassIDs                        :=  GuiPrefs.Node['Options.ClassIDs'].asString;
end;
procedure TProductForecastGUI.Writeguiprefs;
begin
		  GuiPrefs.Node['Options.rgProducts'].asInteger	            := rgProducts.ItemIndex           ;
		  GuiPrefs.Node['Options.rgDepartments'].asInteger	        := rgDepartments.ItemIndex        ;
		  GuiPrefs.Node['Options.chkUseHistory'].asBoolean	        := chkUseHistory.Checked          ;
		  GuiPrefs.Node['Options.chkUseFormula'].asBoolean	        := chkUseFormula.Checked          ;
		  GuiPrefs.Node['Options.chkQuotes'].asBoolean	            := chkQuotes.Checked              ;
		  GuiPrefs.Node['Options.chkSalesOrders'].asBoolean	        := chkSalesOrders.Checked         ;
		  GuiPrefs.Node['Options.chkInvoices'].asBoolean	          := chkInvoices.Checked            ;
		  GuiPrefs.Node['Options.chkUseNonERPsales'].asBoolean	    := chkUseNonERPsales.Checked      ;
		  GuiPrefs.Node['Options.rbUseAvgDailySales'].asBoolean	    := rbUseAvgDailySales.Checked     ;
		  GuiPrefs.Node['Options.rbUseAvgMonthlySales'].asBoolean	  := rbUseAvgMonthlySales.Checked   ;
		  GuiPrefs.Node['Options.rbUseActualMonthlySales'].asBoolean:= rbUseActualMonthlySales.Checked;
		  GuiPrefs.Node['Options.chkUseAvailQty'].asBoolean	        := chkUseAvailQty.Checked         ;
		  GuiPrefs.Node['Options.chkUseReorderAmount'].asBoolean	  := chkUseReorderAmount.Checked    ;
		  GuiPrefs.Node['Options.dtApplyToFrom'].asDatetime	        := dtApplyToFrom.Date             ;
		  GuiPrefs.Node['Options.dtApplyToTo'].asDatetime	          := dtApplyToTo.Date               ;
		  GuiPrefs.Node['Options.spReorderPoint'].asInteger	        := spReorderPoint.Value           ;
		  GuiPrefs.Node['Options.spPreferredLevel'].asInteger	      := spPreferredLevel.Value         ;
		  GuiPrefs.Node['Options.spReorderAmount'].asInteger	      := spReorderAmount.Value          ;
		  GuiPrefs.Node['Options.cbMonth'].asInteger	              := cbMonth.ItemIndex              ;
		  GuiPrefs.Node['Options.chkDoRound'].asBoolean	            := chkDoRound.Checked             ;
		  GuiPrefs.Node['Options.cbRounding'].asInteger	            := cbRounding.ItemIndex           ;
      GuiPrefs.Node['Options.ProductIDs'].asString              := ProductIDs                     ;
      GuiPrefs.Node['Options.ClassIDs'].asString                := ClassIDs                       ;

end;
procedure TProductForecastGUI.setClassIDs(const Value: String);
var
  idx : integer;
  st:TStringlist;
begin
  st:= tStringlist.create;
  try
    st.commatext := value;
    for idx := 0 to cbDepartments.Items.Count - 1 do begin
      cbDepartments.Checked[idx] := st.indexof(cbDepartments.Values[idx])>=0;
    end;
  finally
    Freeandnil(st);
  end;
end;
procedure TProductForecastGUI.setProductIDs(const Value: String);
begin
  ChooseProducts(Value);
end;

initialization
  RegisterClassOnce(TProductForecastGUI);
end.
