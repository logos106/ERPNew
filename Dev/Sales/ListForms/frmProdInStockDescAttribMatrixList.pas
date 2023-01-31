unit frmProdInStockDescAttribMatrixList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB, CustomInputBox, Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, BusObjProdDescAttribute,
  DAScript, MyScript, NamedListObj;

type
  TfmProdInStockDescAttribMatrixList = class(TBaseListingGUI)
    qryClass: TMyQuery;
    btnSelect: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure btnSelectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    TempTableName: string;
    ProdDescAttrib: TProductDescriptionAttribute;
    ComboList: TNamedStringListList;
    StructureChanged: boolean;
    function AttribSelect: boolean;
    procedure ShowPrefsForm;
    procedure PopulateTempTable;
    procedure DoGetText(Sender: TField; var Text: String; DisplayText: Boolean);
    procedure GetCombinationsForProduct(Const aProductName, aDescription: string; Const Script: TMyScript);
    procedure LoadComboList(lst: TNamedStringListList);
    procedure LoadSettings;
    procedure SaveSettings;
  protected
    procedure RefreshQuery; override;
  public
  end;

var
  fmProdInStockDescAttribMatrixList: TfmProdInStockDescAttribMatrixList;

implementation

{$R *.dfm}
uses
  CommonLib, CommonDbLib, contnrs, frmProdSalesDescAttribMatrixListSelect,
  GuiPrefsObj, Preferences, (*frmStockTransfer, *)tcDataUtils, ProductQtylib,
  FastFuncs, tcConst;

type
  TSortRec = class(TObject)
  public
    Title: string;
    IdStr: string;
    IsAxis: boolean;
  end;

  TSortRecList = class(TObject)
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItem(const index: integer): TSortRec;
    function GetAxisRec: TSortRec;
  public
    ProdDescAttrib: TProductDescriptionAttribute;
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[const index: integer]: TSortRec read GetItem; default;
    procedure Clear;
    procedure Add(Const aTitle: String; Const IsXAxis: boolean = false);
    property AxisRec: TSortRec read GetAxisRec;
    function OrderByStr: string;
  end;

var
  SortList: TSortRecList;

{ TfmInStockReportMatrixAllocation }

procedure TfmProdInStockDescAttribMatrixList.FormCreate(Sender: TObject);
begin
  inherited;
  TempTableName:= GetUserTemporaryTableName('SalesMatrixAlloc');
  StructureChanged:= false;
  ProdDescAttrib:= TProductDescriptionAttribute.Create(self);
  ProdDescAttrib.SQL:= 'SELECT * FROM tblDescriptionAttribSetup WHERE Active = "T"';
  ComboList:= TNamedStringListList.Create;
  SortList:= TSortRecList.Create;
  SortList.ProdDescAttrib:= ProdDescAttrib;
  if not ProdDescAttrib.DatasetActive then
    ProdDescAttrib.Opendb;
end;

procedure TfmProdInStockDescAttribMatrixList.FormDestroy(Sender: TObject);
begin
  SaveSettings;
  SortList.Free;
  ComboList.Free;
  DestroyUserTemporaryTable(TempTableName);
  inherited;
end;

procedure TfmProdInStockDescAttribMatrixList.RefreshQuery;
var x: integer;
begin
  qryMain.Close;
  PopulateTempTable;
  qryMain.Fields.Clear;
  if SortList.Count > 0 then
    qryMain.SQL.Text:= 'SELECT * FROM ' + TempTableName
  else
    qryMain.SQL.Text:= 'SELECT 0 as DisplayLevel FROM DUAL';

  inherited;
  grdMain.RemoveField('DisplayLevel');
  grdMain.RemoveField('Description');
  for x:= 0 to qryMain.FieldCount -1 do
    if qryMain.Fields[x].DataType = ftString then
      qryMain.Fields[x].OnGetText:= DoGetText;
  StructureChanged:= false;
end;

procedure TfmProdInStockDescAttribMatrixList.PopulateTempTable;
var
  qry: TMyQuery;
  Script: TMyScript;
  x: integer;
  s: string;
  Dlg: TProgressDialog;
begin
  qry:= TMyQuery.Create(nil);
  Script:= TMyScript.Create(nil);
  Dlg:= TProgressDialog.Create(nil);
  try
    qry.Connection:= GetSharedMyDacConnection;
    Script.Connection:= GetSharedMyDacConnection;
    if StructureChanged then
      DestroyUserTemporaryTable(TempTableName);

    if not TableExists(TempTableName) then begin
      Script.SQL.Clear;
      Script.SQL.Add('CREATE TABLE ' + TempTableName + ' (');
      Script.SQL.Add('ID INT(11) AUTO_INCREMENT,');
      Script.SQL.Add('ProductName Varchar(255) default NULL,');

      for x:= 0 to SortList.Count -1 do begin
        if not SortList[x].IsAxis then
          Script.SQL.Add('`' + SortList[x].Title + '` Varchar(255) default NULL,');
      end;
      Script.SQL.Add('DepartmentName Varchar(255) default NULL,');
      if Assigned(SortList.AxisRec) and ProdDescAttrib.LocateAttribByTitle(SortList.AxisRec.Title) then begin
        ProdDescAttrib.ProdDescAttribLines.First;
        while not ProdDescAttrib.ProdDescAttribLines.EOF do begin
          Script.SQL.Add('`' + ProdDescAttrib.ProdDescAttribLines.AttribValue + '`' +
            ' Varchar(255) default NULL,');
          ProdDescAttrib.ProdDescAttribLines.Next;
        end;
      end;
      Script.SQL.Add('Total Double default NULL,');
      Script.SQL.Add('DisplayLevel Int default NULL,');
      Script.SQL.Add('Description Varchar(255) default NULL,');
      Script.SQL.Add('PRIMARY KEY (`ID`)) TYPE=MyISAM;');
    end
    else begin
      Script.SQL.Text:= 'DELETE FROM ' + TempTableName;
    end;
    Script.Execute;
    StructureChanged:= false;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT DISTINCT p.PartName as ProductName, p.PartsDescription as Description');
    qry.SQL.Add('FROM tblClass c, tblParts p, tblProductQtyAllocation pqa');
    qry.SQL.Add('WHERE pqa.Active = "T" AND pqa.DescAttrib1 <> ""');
    qry.SQL.Add('AND pqa.TransType IN ("TInvoiceLine","TCashSaleLine")');
    qry.SQL.Add('AND pqa.PartsId = p.PartsId');
    qry.SQL.Add('AND pqa.ClassId = c.ClassId');
    qry.SQL.Add('AND pqa.CreationDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date)));
    qry.Open;
    if qry.RecordCount > 0 then begin
      Script.SQL.Clear;

      Dlg.Caption:= 'Creating Combinations ...';
      Dlg.MinValue:= 1;
      Dlg.MaxValue:= qry.RecordCount;
      Dlg.Step:= 1;
      Dlg.Execute;
      LoadComboList(ComboList);
      while not qry.Eof do begin
        GetCombinationsForProduct(qry.FieldByName('ProductName').AsString,qry.FieldByName('Description').AsString,Script);

        qry.Next;
        Dlg.StepIt;
      end;
      Script.Execute;
      Dlg.CloseDialog;
    end
    else
      exit;

    if (SortList.Count = 0) then exit;

    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT p.PartName as ProductName');
    for x:= 0 to SortList.Count -1 do begin
      if not SortList[x].IsAxis then
        qry.SQL.Add(', pqa.' + SortList[x].IdStr + ' as "' + SortList[x].Title + '"');
    end;
    qry.SQL.Add(',c.ClassName as DepartmentName');
    if Assigned(SortList.AxisRec) then
      qry.SQL.Add(', pqa.' + SortList.AxisRec.IdStr + ' as "' + SortList.AxisRec.Title + '"');
    qry.SQL.Add(',SUM(' + ProductQtylib.AvailableqtySQL('pqa')+') as Qty');
    qry.SQL.Add('FROM tblClass c, tblParts p, tblProductQtyAllocation pqa');
    qry.SQL.Add('WHERE pqa.Active = "T" AND pqa.DescAttrib1 <> ""');
    qry.SQL.Add('AND pqa.PartsId = p.PartsId');
    qry.SQL.Add('AND pqa.ClassId = c.ClassId');
    qry.SQL.Add('AND pqa.CreationDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date)));
    qry.SQL.Add('GROUP BY p.PartName,' + SortList.OrderByStr +', c.ClassName, pqa.UOMQty');

    Script.SQL.Clear;
    qry.Open;
    Dlg.Caption:= 'Reading Data ...';
    Dlg.MinValue:= 1;
    Dlg.MaxValue:= qry.RecordCount;
    Dlg.Step:= 1;
    Dlg.Execute;

    if not Assigned(SortList.AxisRec) then exit;
    while not qry.Eof do begin
      Script.SQL.Add('UPDATE ' + TempTableName + ' SET `' +
        qry.FieldByName(SortList.AxisRec.Title).AsString + '` = ' +
        qry.FieldByName('Qty').AsString +
        ', `Total` = IFNULL(`Total`,0) + ' + qry.FieldByName('Qty').AsString);
      Script.SQL.Add('WHERE ProductName = ' + AnsiQuotedStr(qry.FieldByName('ProductName').AsString,'"'));
      s:= '';
      for x:= 1 to qry.Fields.Count -1 do begin
        if qry.Fields[x].FieldName = SortList.AxisRec.Title then
          break
        else begin
          s:= s + ' AND `' + qry.Fields[x].FieldName + '` = ' +
            AnsiQuotedStr(qry.Fields[x].AsString,'"');
        end;
      end;
      s:= s + ';';
      Script.SQL.Add(s);

      qry.Next;
      Dlg.StepIt;
    end;

    Script.Execute;

  finally
    qry.Free;
    Script.Free;
    Dlg.Free;
  end;
end;

procedure TfmProdInStockDescAttribMatrixList.DoGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if (grpFilters.ItemIndex > 0) or
    (sender.Index > Sender.DataSet.FieldByName('DisplayLevel').AsInteger + 1) then
    Text:= Sender.AsString;
end;

procedure TfmProdInStockDescAttribMatrixList.GetCombinationsForProduct(Const aProductName, aDescription: string; Const Script: TMyScript);
var
  x: integer;
  s: string;
  FirstLevel: boolean;
begin
  ComboList.First;
  FirstLevel:= true;
  s:= '';
  while not ComboList.EOF do begin
    Script.SQL.Add('INSERT INTO ' + TempTableName +' SET ProductName = ' +
      AnsiQuotedStr(aProductName,'"'));
    Script.SQL.Add(',Description = ' + AnsiQuotedStr(aDescription,'"'));
    s:= '';
    for x:= 0 to ComboList.Count -1 do
      s:= s + ',`' + ComboList[x].Name + '` = "' + ComboList[x].Item + '"';
    if FirstLevel then begin
      FirstLevel:= false;
      s:= s + ', `DisplayLevel` = ' + Fastfuncs.IntToStr(0) + ';';
    end
    else
      s:= s + ', `DisplayLevel` = ' + Fastfuncs.IntToStr(ComboList.Level +1) + ';';

    Script.SQL.Add(s);
    ComboList.Next;
  end;
end;

procedure TfmProdInStockDescAttribMatrixList.LoadComboList(
  lst: TNamedStringListList);
var
  x: integer;
  s: string;
begin
  lst.Clear;
  for x:= 0 to SortList.Count -1 do begin
    if not SortList[x].IsAxis then begin
      if ProdDescAttrib.LocateAttribByTitle(SortList[x].Title) then begin
        ProdDescAttrib.ProdDescAttribLines.First;
        s:= '';
        while not ProdDescAttrib.ProdDescAttribLines.EOF do begin
          if s <> '' then s:= s  + ',';
          s:= s + AnsiQuotedStr(ProdDescAttrib.ProdDescAttribLines.AttribValue,'"');
          ProdDescAttrib.ProdDescAttribLines.Next;
        end;
        if s <> '' then
          lst.Add(SortList[x].Title,s);
      end;
    end;
  end;
  {now the departments}
  s:= '';
  qryClass.Open;
  qryClass.First;
  while not qryClass.Eof do begin
    if s <> '' then s:= s + ',';
    s:= s + AnsiQuotedStr(qryClass.FieldByName('ClassName').AsString,'"');
    qryClass.Next;
  end;
  if s <> '' then
    lst.Add('DepartmentName',s);
end;

procedure TfmProdInStockDescAttribMatrixList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  grdMain.Refresh;
end;

procedure TfmProdInStockDescAttribMatrixList.btnSelectClick(Sender: TObject);
begin
  inherited;
  AttribSelect;
end;

procedure TfmProdInStockDescAttribMatrixList.LoadSettings;
var
  x: integer;
begin
  SortList.Clear;
  for x:= 0 to GuiPrefs.Node.ItemByName['SortAttribList'].Count -1 do begin
    SortList.Add(GuiPrefs.Node.ItemByName['SortAttribList'].Items[x].ItemByName['Title'].AsString,
    GuiPrefs.Node.ItemByName['SortAttribList'].Items[x].ItemByName['IsAxis'].AsBoolean);
  end;
end;

procedure TfmProdInStockDescAttribMatrixList.SaveSettings;
var
  x: integer;
begin
  GuiPrefs.Node.ItemByName['SortAttribList'].Clear;
  for x:= 0 to SortList.Count -1 do begin
    GuiPrefs.Node.ItemByName['SortAttribList.Item_' + Fastfuncs.IntToStr(x) + '.Title'].AsString:=
      SortList[x].Title;
    GuiPrefs.Node.ItemByName['SortAttribList.Item_' + Fastfuncs.IntToStr(x) + '.IsAxis'].AsBoolean:=
      SortList[x].IsAxis;
  end;
end;

function TfmProdInStockDescAttribMatrixList.AttribSelect: boolean;
var
  form: TfmProdSalesDescAttribMatrixListSelect;
  x: integer;
begin
  result:= false;
  form:= TfmProdSalesDescAttribMatrixListSelect.Create(nil);
  Try
    ProdDescAttrib.First;
    while not ProdDescAttrib.EOF do begin
      if ProdDescAttrib.Active then
        form.lbSource.Items.Add(ProdDescAttrib.Title);
      ProdDescAttrib.Next;
    end;
    for x:= 0 to SortList.Count -1 do begin
      if SortList[x].IsAxis then
        form.edtAxis.Text:= SortList[x].Title
      else
        form.lbSelected.Items.Add(SortList[x].Title);
    end;
    if form.ShowModal = mrOk then begin
      result:= true;
      StructureChanged:= true;
      SortList.Clear;
      for x:= 0 to form.lbSelected.Count -1 do begin
        SortList.Add(form.lbSelected.Items[x]);
      end;
      if form.edtAxis.Text <> '' then
        SortList.Add(form.edtAxis.Text,true);

      if Assigned(SortList.AxisRec) then
        self.RefreshQuery;

    end;
  Finally
    form.Free;
  end;
end;

procedure TfmProdInStockDescAttribMatrixList.ShowPrefsForm;
var
  frmPreferences: TPreferencesGUI;
begin
  inherited;
  frmPreferences := TPreferencesGUI(GetComponentByClassName('TPreferencesGUI', true, nil, False));
  if Assigned(frmPreferences) then begin //if has acess
    with frmPreferences do begin
      FormStyle := fsMDIChild;
      BringToFront;
      SearchForText('Set Customised Dropdown | Sales','btnSetCustomisedDropdown');
    end;
  end;
end;

procedure TfmProdInStockDescAttribMatrixList.FormShow(Sender: TObject);
begin
  inherited;
  LoadSettings;
  StructureChanged:= true;
  RefreshQuery;
  if (SortList.Count = 0) then begin
    if ProdDescAttrib.Count = 0 then begin
      if CommonLib.MessageDlgXP_Vista(
        'There are no Customised Dropdowns defined or active, click on OK to define theses now.',
        mtInformation,[mbOk,mbCancel],0) = mrOk then begin
        {show prefs form}
        ShowPrefsForm;
        Close;
      end;
    end
    else begin
      { SortList count = 0 }
      MessageDlgXP_Vista(
        'Please select the Attributes to use for the X Axis and to sort by.',
        mtInformation, [mbOk],0);
      if AttribSelect then
        RefreshQuery;
    end;
  end;
end;

procedure TfmProdInStockDescAttribMatrixList.cmdNewClick(Sender: TObject);
begin
  {TODO StockTransfer}
(*var
  TransForm: TStockTransferGUI;
  bm: TBookmark;
  x, y: integer;
  Dlg: TProgressDialog;
begin
  inherited;
  if grdMain.SelectedList.Count > 0 then begin
    TransForm:= TStockTransferGUI.Create(nil);
    TransForm.FormStyle := fsMDIChild;
    TransForm.KeyId:= 0;
    TransForm.BringToFront;
    TransForm.WindowState:= wsMinimized;
    bm:= qryMain.GetBookmark;
    qryMain.DisableControls;
    TransForm.Stock.Datetransferred:= Date;
    Dlg:= TProgressDialog.Create(nil);
    try
      Dlg.Caption:= 'Creating Stock Transfer ...';
      Dlg.MinValue:= 1;
      Dlg.MaxValue:= grdMain.SelectedList.Count;
      Dlg.Step:= 1;
      Dlg.Execute;
      for x:= 0 to grdMain.SelectedList.Count -1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList[x]);
        if x = 0 then begin
          TransForm.Stock.TransferfromClassID:=
            GetDeptID(qryMain.FieldByName('DepartmentName').AsString);
          TransForm.cboClassFromCloseUp(TransForm. cboClassFrom,TransForm.cboClassFrom.LookupTable,TransForm.cboClassFrom.DataSource.DataSet, True);
        end;
        if Assigned(SortList.AxisRec) then begin
          if SortList.ProdDescAttrib.LocateAttribByTitle(SortList.AxisRec.Title) then begin
            SortList.ProdDescAttrib.ProdDescAttribLines.First;
            while not SortList.ProdDescAttrib.ProdDescAttribLines.EOF do begin
              if not qryMain.FieldByName(SortList.ProdDescAttrib.ProdDescAttribLines.AttribValue).IsNull then begin

                TransForm.Stock.Lines.New;
                TransForm.Stock.Lines.Productname:=
                  qryMain.FieldByName('ProductName').AsString;
                TransForm.Stock.Lines.Partdesc:=
                  qryMain.FieldByName('Description').AsString;
                case SortList.ProdDescAttrib.Id of
                  1: TransForm.Stock.Lines.DescAttrib1:= SortList.ProdDescAttrib.ProdDescAttribLines.AttribValue;
                  2: TransForm.Stock.Lines.DescAttrib2:= SortList.ProdDescAttrib.ProdDescAttribLines.AttribValue;
                  3: TransForm.Stock.Lines.DescAttrib3:= SortList.ProdDescAttrib.ProdDescAttribLines.AttribValue;
                  4: TransForm.Stock.Lines.DescAttrib4:= SortList.ProdDescAttrib.ProdDescAttribLines.AttribValue;
                  5: TransForm.Stock.Lines.DescAttrib5:= SortList.ProdDescAttrib.ProdDescAttribLines.AttribValue;
                end;
                for y:= 0 to SortList.Count -1 do begin
                  if not SortList[y].IsAxis then begin
                    case TProductDescriptionAttribute.IDToggle(SortList[y].Title) of
                      1: TransForm.Stock.Lines.DescAttrib1:= qryMain.FieldByName(SortList[y].Title).AsString;
                      2: TransForm.Stock.Lines.DescAttrib2:= qryMain.FieldByName(SortList[y].Title).AsString;
                      3: TransForm.Stock.Lines.DescAttrib3:= qryMain.FieldByName(SortList[y].Title).AsString;
                      4: TransForm.Stock.Lines.DescAttrib4:= qryMain.FieldByName(SortList[y].Title).AsString;
                      5: TransForm.Stock.Lines.DescAttrib5:= qryMain.FieldByName(SortList[y].Title).AsString;
                    end;
                  end;
                end;
                TransForm.Stock.Lines.Transferqty:= 1;

                TransForm.Stock.Lines.PostDb;

              end;
              SortList.ProdDescAttrib.ProdDescAttribLines.Next;
            end;
          end;
          Dlg.StepIt;
        end;

      end;
    finally
      qryMain.GotoBookmark(bm);
      qryMain.EnableControls;
      qryMain.FreeBookmark(bm);
      Dlg.Free;
    end;
    TransForm.WindowState:= wsNormal;

  end
  else begin
    CommonLib.MessageDlgXP_Vista('Please select at least one line.',mtInformation,[mbOk],0);
  end;*)
end;

{ TSortRecList }

constructor TSortRecList.Create;
begin
  inherited;
  fList:= TObjectList.Create(true);
end;

destructor TSortRecList.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TSortRecList.Add(Const aTitle: String; Const IsXAxis: boolean);
var
  newRec: TSortRec;
begin
  newRec:= TSortRec.Create;
  newRec.Title:= aTitle;
  if ProdDescAttrib.LocateAttribByTitle(aTitle) then begin
    newRec.IdStr:= 'DescAttrib' + Fastfuncs.IntToStr(ProdDescAttrib.Id);
  end;
  newRec.IsAxis:= IsXAxis;
  fList.Add(newRec);
end;

procedure TSortRecList.Clear;
begin
  fList.Clear;
end;

function TSortRecList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TSortRecList.GetItem(const index: integer): TSortRec;
begin
  result:= TSortRec(fList[index]);
end;

function TSortRecList.GetAxisRec: TSortRec;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to count -1 do begin
    if Item[x].IsAxis then begin
      result:= Item[x];
      Break;
    end;
  end;
end;

function TSortRecList.OrderByStr: string;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to count -1 do begin
    if not Item[x].IsAxis then begin
      if result <> '' then result:= result + ',';
      result:= result + Item[x].IdStr;
    end;
  end;
  if result <> '' then result:= result + ',';
  result:= result + AxisRec.IdStr;
end;

initialization
  RegisterClassOnce(TfmProdInStockDescAttribMatrixList);

end.
