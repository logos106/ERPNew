unit StockQtysLocationsReport;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/09/05  1.00.01 DSP  Added chkShowNegativeQtys checkbox.
 05/01/06  1.00.02 BJ   Component anchor changed to have correct positioning when size is changed.

}

interface

uses
  ActnList,
   BaseListingForm, Buttons, DNMSpeedButton, Classes, ComCtrls,AdvOfficeStatusBar, Controls, DB, DBAccess, Dialogs, DNMPanel, ExtCtrls,
  Graphics, Grids, ImgList, MemDS,
  Menus, AdvMenus, Messages, MyAccess,ERPdbComponents, PrintDAT, ProgressDialog, SelectionDialog, StdCtrls, SysUtils,
  Variants, Windows, wwcheckbox, wwdbdatetimepicker, Wwdbgrid,
  Wwdbigrd, wwdblook, wwDialog, Wwlocate,  Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg, frmBaselistingSelectionLookup,StockQtysLocationsBase;

type

  TStockQtysLocationsReportGUI = class(TStockQtysLocationsBaseGUI)
    chkShowNegativeQtys: TCheckBox;

    lblREfreshInfo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkAllClassClick(Sender: TObject);
    procedure chkShowNegativeQtysClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);

  private
    //procedure UpdateQryMainSql;
    procedure ToBeRefreshed;
  protected
    procedure RefreshQuery; override;
    //procedure RefreshTotals; override;
    procedure CheckForResync;

    procedure PopulateData;Override;
    procedure MakeQryMain;Override;
    Function ExpressDetailListName:String;Override;


  public
    class Function DrillDownfor(fiProductID,fiClassID: Integer;
                                fsBatchno: String=''; fdExpiryDate: TDatetime=0;
                                fsbinLocation: String='';  fsBinnumber: String='';
                                fsUOM:String=''; foFormDisplayMode: TFormDisplayMode= tNormal):TStockQtysLocationsReportGUI;
  end;

  //var
  //  StockQtysLocationsReportGUI: TStockQtysLocationsReportGUI;

implementation

uses pqalib,
   DNMLib, StrUtils, Forms, Commonlib, AppEnvironment,
  FastFuncs, ProductQtyLib, tcConst, CommonDbLib, DefaultClassObj,
  tcDataUtils, SystemLib;

{$R *.dfm}

procedure TStockQtysLocationsReportGUI.FormShow(Sender: TObject);

  Procedure SetDefaultfilter; begin
    if fDefaultGroupFilterItemIndex > -1 then
      grpFilters.ItemIndex := fDefaultGroupFilterItemIndex
    else begin
      if (FormDisplayMode in [tSelectRec, tDrillDown]) then grpFilters.ItemIndex := 2
      else if FormDisplayMode  in [tSummaryOnly] then begin
        grpFilters.ItemIndex := 0;
        grpFilters.enabled := False;
      end;
    end;
  end;

begin
  grdmain.UseTFields := True;
  CheckForResync;
  //UpdateQryMainSql;
  inherited;
  SetDefaultfilter;
  TitleLabel.Caption := 'Stock Quantities && Location';
(*  qryMain.FieldByName('ProductName').DisplayLabel := AppEnv.DefaultClass.PartColumn;
  qryMainProductColumn1.DisplayLabel := AppEnv.DefaultClass.FirstColumn;
  qryMainProductColumn2.DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  qryMainProductColumn3.DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
  qryMainClassname.DisplayLabel      := AppEnv.DefaultClass.ClassHeading;*)

  //PopulateFilterCombo;
  //cboFilter.ItemIndex := 0;

  if (FormDisplayMode = tSelectRec) then begin
      (*HeaderPanel.visible := false;*)
      BorderStyle := bssingle;
      (*Panel2.PArent := Self;
      Panel2.Align := alTop;*)
      cmdNew.enabled := false;
      cmdClose.caption := '&Select';
      grdmain.MultiSelectOptions := [msoAutoUnselect,msoShiftSelect];
      if dgMultiSelect in grdmain.Options then
      else
        grdmain.Options := grdmain.Options +[dgMultiSelect];
      LblNote.visible := True;
      LblNote.caption := 'Select records to transfer from. '+
                          'Hold down SHIFT and select multiple records. '+
                          'Press ''Select'' button to close the form and add to the transaction.';
  end;
  if Assigned(fOnGridDataSelect) then begin
    grdmain.MultiSelectOptions := [msoAutoUnselect,msoShiftSelect];
    if dgMultiSelect in grdmain.Options then
    else
      grdmain.Options := grdmain.Options +[dgMultiSelect];
  end;

end;

(*procedure TStockQtysLocationsReportGUI.UpdateQryMainSql;
var
  fsFilter: STring;

  Function  DrillDownfilter:String; begin
    fsFilter := '';
    if fsfilter <> '' then fsfilter := '(' +fsfilter +')';
    if (Batchno <> '') and (grpFilters.Itemindex >=1) then  begin
      if fsfilter <> '' then fsfilter := fsfilter +' and ' ;
      fsfilter := fsfilter + '(Batchnumber = ' + quotedStr(Batchno)+')';
    if (ExpiryDate <> Null) and (grpFilters.Itemindex >=1) then  begin
      if fsfilter <> '' then fsfilter := fsfilter +' and ' ;
      if (ExpiryDate = null) or (Expirydate = 0) then fsfilter := fsfilter + '(ifnull(ExpiryDate,0) = 0)'
      else fsfilter := fsfilter + '(ExpiryDate = ' + QuotedStr(FormatDatetime(FormatSettings.ShortDateformat, ExpiryDate))+')';
    end;
    end;
    if (Binlocation <> '') and (grpFilters.Itemindex =2) then  begin
      if fsfilter <> '' then fsfilter := fsfilter +' and ' ;
      fsfilter := fsfilter + '(Binlocation = ' + quotedStr(Binlocation)+')';
    if (Binnumber <> '') and (grpFilters.Itemindex =2) then  begin
      if fsfilter <> '' then fsfilter := fsfilter +' and ' ;
      fsfilter := fsfilter + '(Binnumber = ' + quotedStr(Binnumber)+')';
    end;
    end;
    if UOM <> '' then  begin
      if fsfilter <> '' then fsfilter := fsfilter +' and ' ;
      fsfilter := fsfilter + '(UOM = ' + quotedStr(UOM)+')';
    end;
    //if fsFilter <> '' then fsfilter := '(GLevel = 1 ) or (' + fsfilter+')';
    Result :=fsfilter;
  end;

begin
  if qryMain.Active then qryMain.Close;
  qryMain.SQL.clear;
  qryMain.SQL.Add('select');
  qryMain.SQL.Add('*');
  qryMain.SQL.Add('from ' +tablename);
  if chkAllClass.checked =False then
    if cboClassQry.active then
      Qrymain.SQL.add(' where DepartmentId = ' + IntToStr(cboClassQry.fieldByname('ClassId').asInteger));
  DrillDownfilter;

  if Pos('where',Lowercase(qryMain.SQL.Text)) = 0 then
    qryMain.SQL.Add('Where Active = "T"')
  else
    qryMain.SQL.Add('AND Active = "T"');


  if fsFilter <> '' then begin
    if Pos('where',Lowercase(qryMain.SQL.Text)) = 0 then
      qryMain.SQL.Add('Where ')
    else
      qryMain.SQL.Add('AND ');
    qryMain.SQL.Add(fsfilter);
  end;
  //RefreshOrignalSQL(((SearchMode = smSearchEngineLike) or (SearchMode = smSearchEngine)) and (SearchMode <> smFullList));
  RefreshOrignalSQL;
end;*)


procedure TStockQtysLocationsReportGUI.MakeQryMain;
begin
inherited;
  (*if qryMain.Active then qryMain.Close;
  qryMain.SQL.clear;
  qryMain.SQL.Add('select');
  qryMain.SQL.Add('*');
  qryMain.SQL.Add('from ' +tablename);
  qryMain.SQL.Add('Where Active ="T" ');
  qryMain.SQL.Add('and (:UOM ="" or UOM = :UOM)');
  qryMain.SQL.Add('and (:AllDept ="T" or   DepartmentId = :DepartmentId )');
  qryMain.SQL.Add('and (:FilterIndex <1 or ((:Batchnumber ="" or   Batchnumber = :Batchnumber ) and (:ExpiryDate <="1900/12/30" or ExpiryDate = :ExpiryDate) ))');
  qryMain.SQL.Add('and (:FilterIndex <2 or ((:Binlocation ="" or   Binlocation = :Binlocation ) and (:Binnumber ="" or Binnumber  = :Binnumber) ))');*)
end;

procedure TStockQtysLocationsReportGUI.PopulateData;
var
  fsFilter: STring;
begin
  inherited;
end;
procedure TStockQtysLocationsReportGUI.RefreshQuery;
begin
  (*qrymain.DisableControls;
  try
    closeDb(qrymain);
    PopulateData;
    qryMain.PArambyname('UOM').asString := uom;
    qryMain.PArambyname('AllDept').asString       := BooleantoStr(AllClasses);
    qryMain.PArambyname('DepartmentId').asInteger := SelectedClassID;
    qryMain.PArambyname('FilterIndex').asInteger  := grpfilters.itemindex;
    qryMain.PArambyname('Batchnumber').asString   := Batchno;
    qryMain.PArambyname('ExpiryDate').asDatetime  := ExpiryDate;
    qryMain.PArambyname('Binlocation').asString   := Binlocation;
    qryMain.PArambyname('Binnumber').asString     := Binnumber;
    inherited;
    if (CustomFilterString <> '') and (qryMain.Filter <> CustomFilterString) then begin
      qryMain.Filter := CustomFilterString;
      qryMain.Filtered := true;
    end;
  finally
    Qrymain.EnableControls;
  end;*)
  inherited;
end;
procedure TStockQtysLocationsReportGUI.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  lblREfreshInfo.visible := False;
end;

procedure TStockQtysLocationsReportGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  //RefreshQuery;
  ToBeRefreshed;
end;
procedure TStockQtysLocationsReportGUI.CheckForResync;
var
  qry : TERPQuery;
  Count : integer;
  s : string;
begin
  qry := TempMyQuery;
  try
    qry.SQL.Text := 'select Count(*) from tblParts where PartsId not in (Select PartsId from rpt_tblParts)';
    qry.Open;
    Count := qry.Fields[0].AsInteger;
    if Count = 0  then
      exit;
  finally
    qry.ClosenFree;
  end;

  //
  if Count = 1 then
    s := '1 Product was'
  else
    s := IntToStr(Count) + ' Products Were';
  s := s + ' Not Synchronised And Will Not Be Shown In The List.'#13#10 +
       'Synchronisation Can Take Some Time.'#13#10'Do You Want To Synchronise Products?';
  if MessageDlgXP_Vista(s, mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  begin
    rptsynchreporttablesClick(Self);
  end;
end;

procedure TStockQtysLocationsReportGUI.ToBeRefreshed;
begin
  inherited;
  if lblREfreshInfo.visible then Exit;
  lblREfreshInfo.visible := TRue;
end;

procedure TStockQtysLocationsReportGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
(*  if chkAllClass.Checked then cboClass.Enabled := false
  else cboClass.Enabled := true;
  ToBeREfreshed;//UpdateQryMainSql;
  //RefreshQuery;
  ToBeRefreshed;*)
end;

(*procedure TStockQtysLocationsReportGUI.RefreshTotals;
var
  bm: TBookmark;
  dValue: double;
  dQty: double;
  PartName: string;
  HasHeader: boolean;
  tmpIndexFieldNames: string;
begin
  dValue := 0.0;
  dQty := 0.0;

  with qryMain do begin
    bm := GetBookmark;
    DisableControls;

    if not Empty(IndexFieldNames) then begin
      tmpIndexFieldNames := IndexFieldNames;
      IndexFieldNames := '';
    end
    else
      tmpIndexFieldNames := '';

    try
      First;
      HasHeader := False;
      PartName := FieldByName('ProductName').AsString;

      while not Eof do begin
        if not Sysutils.SameText(PartName, FieldByName('ProductName').AsString) then
          HasHeader := False;

        if Empty(qryMainBinLocation.AsString) and Empty(qryMainBinNumber.AsString) and
          Empty(qryMainbatchnumber.AsString) then begin
          dValue := dValue + qryMainValue.AsFloat;
          dQty := dQty + qryMainInstockQty.AsFloat;
          HasHeader := True;
        end
        else begin
          if HasHeader = False then begin
            dValue := dValue + qryMainValue.AsFloat;
            dQty := dQty + qryMainInstockQty.AsFloat;
          end;
        end;

        PartName := FieldByName('ProductName').AsString;
        Next;
      end;
    finally
      if not Empty(tmpIndexFieldNames) then
        IndexFieldNames := tmpIndexFieldNames;

      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;

  grdMain.ColumnByName('Value').FooterValue := FloatToStrF(dValue, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Qty').FooterValue := FloatToStrF(dQty, ffFixed, 15, 2);
end;*)

procedure TStockQtysLocationsReportGUI.chkShowNegativeQtysClick(Sender: TObject);
begin
  inherited;
  //RefreshQuery;
  ToBeRefreshed;
end;

procedure TStockQtysLocationsReportGUI.grpFiltersClick(Sender: TObject);
begin
  if (grpFilters.ItemIndex = 0) and (FormDisplayMode = tDrillDown) then begin
    grpFilters.ItemIndex := 1;
    Exit;
  end;
  if not qryMain.Active then
    exit;
  //UpdateQryMainSql;
  //RefreshQuery;
  ToBeRefreshed;
  if fCustomFilterString <> '' then
    GroupFilterString := fCustomFilterString
  else
    GroupFilterString := '(UOMqty <> 0 or SOUOMQty <> 0) or (GLevel=1)';
  inherited;
end;

procedure TStockQtysLocationsReportGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
{-------bold the summary when not in summary mode}
      if (qrymain.fieldbyname('gLevel').asInteger <= 1) and (grpfilters.ItemIndex >0) and UseBoldInGrid then
        grdMain.Canvas.Font.Style := grdMain.Canvas.Font.Style + [fsBold];

{-------Qty and value -> blank when 0}
      if (Sysutils.SameText(field.fieldName , 'Cost')) or
         (Sysutils.SameText(field.fieldName , 'SOUOMQty')) or
         (Sysutils.SameText(field.fieldName , 'InstockUOMQty')) or
         (Sysutils.SameText(field.fieldName , 'Qty')) or
         (Sysutils.SameText(field.fieldName , 'UOMQty')) or
         (Sysutils.SameText(field.fieldName , 'AvailableQty')) or
         (Sysutils.SameText(field.fieldName , 'AvailableUOMQty')) or
         (Sysutils.SameText(field.fieldName , 'Value')) then
        if QryMain.Fieldbyname(Field.fieldName).asFloat = 0 then
            Afont.Color := ABrush.Color;

(*{-------batch expiry date -> blank when 0}
      if (Sysutils.SameText(field.fieldName , 'ExpiryDate')) then
        if (Qrymain.fieldbyname('ExpiryDate').asString = '')
            or (Qrymain.fieldbyname('ExpiryDate').asString = '1899-12-30')
            or (qryMaingLevel.asInteger = 1) then
            Afont.color := ABrush.color;*)
{-------un allocated Qty fields are only for bin/batch lines}
      if (Sysutils.SameText(field.fieldName , 'UnAllocatedSOUOMQty')) or
          (Sysutils.SameText(field.fieldName , 'UnAllocatedInstockUOMQty')) or
          (Sysutils.SameText(field.fieldName , 'UnAllocatedUOMQty')) then
        if (grpFilters.itemIndex = 0) or
         ((qryMainBatch.ASBoolean =False) and (grpFilters.ItemIndex=1)) or
          ((qryMainBatch.AsBoolean=False) and  (qryMainBin.AsBoolean =False)) or
          (TFloatField(Field).asFloat = 0) or
          (qrymainGLevel.asInteger <> 1) then
            Afont.color := ABrush.color;

{-------available Quantity details are only for the summary lines}
      if  (Sysutils.SameText(field.fieldName , 'Qty')) or
          (Sysutils.SameText(field.fieldName , 'UOMMultiplierDesc1')) or
          (Sysutils.SameText(field.fieldName , 'UOMMultiplierDesc2')) or
          (Sysutils.SameText(field.fieldName , 'AvailableUOMqty')) or
          (Sysutils.SameText(field.fieldName , 'AvailableQty')) then begin
        if (qrymainGLevel.asInteger <> 1) then
          Afont.color := ABrush.color;
      end;
(*{-------UOM descriptions are shown only when Qty <> 0}
      if    (Sysutils.SameText(field.fieldName , 'UOMMultiplierDesc1')) then
        if QrymainQty.asFloat = 0 then
          Afont.color := ABrush.color;
      if (Sysutils.SameText(field.fieldName , 'UOMMultiplierDesc2')) then
          if QrymainAvailableQty.asFloat = 0 then
              Afont.color := ABrush.color;*)

end;

procedure TStockQtysLocationsReportGUI.FormCreate(Sender: TObject);
begin
  //HaveOnlyToDate['As On '] := true;
  fCustomFilterString := '';
  fDefaultGroupFilterItemIndex := -1;
  Formshown := False;
  inherited;
end;
procedure TStockQtysLocationsReportGUI.cmdCloseClick(Sender: TObject);
begin
  if FormDisplayMode = tselectRec then begin
    grdMain.OnDblClick(grdMain);
  end else begin
    inherited;
  end;
end;

class function TStockQtysLocationsReportGUI.DrillDownfor(fiProductID,fiClassID: Integer;
                            fsBatchno: String=''; fdExpiryDate: TDatetime=0;
                            fsbinLocation: String='';  fsBinnumber: String='';
                            fsUOM:String=''; foFormDisplayMode: TFormDisplayMode= tNormal):TStockQtysLocationsReportGUI;
var
  form :TStockQtysLocationsReportGUI;
begin
  Result := nil;
  form := TStockQtysLocationsReportGUI(GetcomponentbyClassname('TStockQtysLocationsReportGUI'));
  if not Assigned(Form) then exit;
  form.ProductId   := fiproductID;
  form.ClassID     := fiClassID;
  form.Batchno     := fsBatchno;
  form.ExpiryDate  := fdExpiryDate;
  form.binLocation := fsbinLocation;
  form.Binnumber   := fsBinnumber;
  Form.UOM         := fsUOM;
  if (form.binlocation  <> '') and (form.grpFilters.Itemindex <2) then form.grpFilters.Itemindex := 2
  else if (form.Batchno <> '') and (form.grpFilters.Itemindex <1) then form.grpFilters.Itemindex := 1;
  form.FormDisplayMode := foFormDisplayMode;
  Result := Form;
end;

function TStockQtysLocationsReportGUI.ExpressDetailListName: String;
begin
    REsult := 'TStockBinQtysReportGUI';
end;

procedure TStockQtysLocationsReportGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblREfreshInfo.visible := False;
end;

procedure TStockQtysLocationsReportGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;

    qryMainUnAllocatedSOUOMQty.asFloat := qryMainSOUOMQty.asFloat - qryMainAllocatedSOUOMQty.asFloat;
    qryMainUnAllocatedUOMQty.asFloat := qryMainUOMQty.asFloat - qryMainAllocatedUOMQty.asFloat;
    qryMainUnAllocatedInstockUOMQty.asFloat := qryMainInstockUOMQty.asFloat - qryMainAllocatedInstockUOMQty.asFloat;
end;




initialization
  RegisterClassOnce(TStockQtysLocationsReportGUI);
end.
