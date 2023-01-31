unit frmPartsPriceMatrix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, DNMPanel, Mask, wwdbedit, StdCtrls, wwdblook,
  Grids, Wwdbigrd, Wwdbgrid, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, BusObjBase, busobjPartsPriceMatrix,
  GradientLabel, DNMSpeedButton, ComCtrls, Contnrs, Wwdotdot, Wwdbcomb,
  AdvScrollBox, DBCtrls, Menus, AdvMenus, SelectionDialog;

type
  TfmPartsPriceMatrix = class(TBaseForm)
    pnlPriceMatrix: TDNMPanel;
    qrypartspricemethod: TERPQuery;
    qrypartspricemethodGlobalRef: TWideStringField;
    qrypartspricemethodID: TIntegerField;
    qrypartspricemethodProductId: TIntegerField;
    qrypartspricemethodXAxisID: TIntegerField;
    qrypartspricemethodYAxisID: TIntegerField;
    qrypartspricemethodQtyformula: TWideStringField;
    qrypartspricemethodmstimestamp: TDateTimeField;
    dspartspricemethod: TDataSource;
    qrypartspricemethodentries: TERPQuery;
    qrypartspricemethodentriesGlobalRef: TWideStringField;
    qrypartspricemethodentriesID: TIntegerField;
    qrypartspricemethodentriesPriceMethodID: TIntegerField;
    qrypartspricemethodentriesName: TWideStringField;
    qrypartspricemethodentriesEntryOption: TWideStringField;
    qrypartspricemethodentriesmstimestamp: TDateTimeField;
    dspartspricemethodentries: TDataSource;
    qrypartspricemethodvalues: TERPQuery;
    qrypartspricemethodvaluesGlobalRef: TWideStringField;
    qrypartspricemethodvaluesID: TIntegerField;
    qrypartspricemethodvaluesPriceMethodID: TIntegerField;
    qrypartspricemethodvaluesPriceEntryID: TIntegerField;
    qrypartspricemethodvaluesmstimestamp: TDateTimeField;
    dspartspricemethodvalues: TDataSource;
    qrycboxpartspricemethodentries: TERPQuery;
    qrycboxpartspricemethodentriesName: TWideStringField;
    qrycboxpartspricemethodentriesID: TIntegerField;
    qrycboxpartspricemethodentriesPriceMethodID: TIntegerField;
    qrycboypartspricemethodentries: TERPQuery;
    qrycboypartspricemethodentriesName: TWideStringField;
    qrycboypartspricemethodentriesID: TIntegerField;
    qrycboypartspricemethodentriesPriceMethodID: TIntegerField;
    QryMatrix: TERPQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pnlmatrix: TDNMPanel;
    Bevel19: TBevel;
    Label94: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    wwDBGrid3: TwwDBGrid;
    wwDBGrid4: TwwDBGrid;
    cboxAxis: TwwDBLookupCombo;
    cboyAxis: TwwDBLookupCombo;
    DNMPanel1: TDNMPanel;
    Bevel18: TBevel;
    lblXAttribute: TGradientLabel;
    lblYAttribute: TGradientLabel;
    pnlOptions: TDNMPanel;
    pnlMain: TDNMPanel;
    btnNext: TDNMSpeedButton;
    dsMatrix: TDataSource;
    cboentryOption: TwwDBComboBox;
    grdMatrix: TwwDBGrid;
    MyConnection: TERPConnection;
    qrypartspricemethodXAxis: TWideStringField;
    qrypartspricemethodYAxis: TWideStringField;
    scMain: TAdvScrollBox;
    memFormula: TDBMemo;
    pumFormula: TAdvPopupMenu;
    mnuColumns: TMenuItem;
    N5: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    multiply1: TMenuItem;
    divide1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    qrypartspricemethodvaluesSalesdefault: TWideStringField;
    Label1: TLabel;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitID: TIntegerField;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    cboUnitOfMeasure: TwwDBLookupCombo;
    qrypartspricemethodUOMID: TIntegerField;
    qrypartspricemethodUOM: TWideStringField;
    Label2: TLabel;
    qrypartspricemethodvaluesValue: TFloatField;
    qrypartspricemethodvaluesPurchaseDefault: TWideStringField;
    DNMPanel2: TDNMPanel;
    DNMSpeedButton1: TDNMSpeedButton;
    btnHowto: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure wwDBGrid3Exit(Sender: TObject);
    procedure wwDBGrid4Exit(Sender: TObject);
    procedure cboxAxisCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboyAxisCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qrypartspricemethodAfterPost(DataSet: TDataSet);
    procedure qrypartspricemethodentriesAfterPost(DataSet: TDataSet);
    procedure cboxAxisDropDown(Sender: TObject);
    procedure cboyAxisDropDown(Sender: TObject);
    procedure grdMatrixColEnter(Sender: TObject);
    procedure grdMatrixCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMatrixEnter(Sender: TObject);
    procedure grdMatrixExit(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMatrixKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memFormulaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdEntryPopupDblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure pumFormulaPopup(Sender: TObject);
    procedure ShowPriceMatrixHelp(Sender: TObject);
  private
    PriceMethod           : TPartsPriceMethod;
    fiProductID           : Integer;
    fiPriceMatrixTabIndex : Integer;
    fParentControl        : TWinControl;
    Combos                : TObjectList;
    fFormConnection       : TERPConnection;
    procedure SetFormConnection(const Value: TERPConnection);
    procedure SetProductID(const Value: Integer);
    procedure SetPriceMatrixTabIndex(const Value: Integer);
    Procedure onTabchange(const Tabindex:Integer);
    Procedure CreateCombos(Const Sender: TBusObj; var Abort: boolean);
    Function CombosCreated:Boolean;
    Procedure RefreshLookups;
    procedure PriceSelectionCombocloseup(Sender: TObject);
    Procedure RefreshGrid;
    Procedure SaveGrid;
    Function CellREf(FieldName:String):STring;
    procedure ImportFromClipBoard;
    Procedure CopytoclipBoard;
    procedure FormulaPopupCallback(const Sender: TBusObj; var Abort: boolean);
    function ComboID(xEntryID: Integer): Integer;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    constructor Create(AOwner:TComponent) ; Overload;override;
    Constructor Create(AOwner:Tcomponent;MyConnection: TERPConnection);reintroduce;Overload;
    Property FormConnection: TERPConnection read fFormConnection Write SetFormConnection;
    Property ProductID :Integer read fiProductID write SetProductID;
    Property PriceMatrixTabIndex :Integer read fiPriceMatrixTabIndex Write SetPriceMatrixTabIndex;
    Property ParentControl :TWinControl read fParentControl write fParentControl;
    function SAve:boolean;
  end;


implementation

uses CommonLib, Clipbrd, BusObjConst, objPartPriceSelection, IntegerListObj,
  FastFuncs, DocReaderObj;

{$R *.dfm}
procedure TfmPartsPriceMatrix.btnNextClick(Sender: TObject);
begin
  inherited;
  if not PriceMethod.ValidateData then exit;
  if PriceMethod.PartsPriceEntrys.count >0 then
  else
    if MessageDlgXP_Vista('It is not possible to add More Attributes once Product Prices are Entered.' +chr(13) +'Do You Wish to Save The Matrix and Create Product Prices?' , mtConfirmation, [mbyes,mbno] , 0) = mrNo then exit;
  if not PriceMethod.save then exit;
  PriceMatrixTabIndex := 1;
end;

function TfmPartsPriceMatrix.CellRef(FieldName:String): STring;
var
  yvalueID:Integer;
  ctr, x:Integer;
  EntryIds:TIntegerList;
  (*sresult :String;*)
begin
  yvalueID :=0;
  for ctr:=low(PriceMethod.PriceAttribs)  to high(PriceMethod.PriceAttribs) do
    if Sametext(PriceMethod.PriceAttribs[ctr].fieldname , fieldname) then begin
      yvalueID :=PriceMethod.PriceAttribs[ctr].EntryValueId;
      break;
    end;

  if yvalueID =0 then exit;

  EntryIds:=TIntegerList.create;
  try
    EntryIds.addSort(PriceMethod.XAxisID);
    EntryIds.addSort(PriceMethod.YAxisID);
    if comboscreated then
      if combos.count>0 then
        for x := 0 to combos.count-1 do
          EntryIds.addSort(TPartPriceSelection(combos[x]).PriceEntryID);
    result := '';
    for ctr := 0 to EntryIds.count-1 do begin
      if result <> '' then result := result +',';
      if entryIds[ctr] =  PriceMethod.XAxisID then result := result + '[' + inttostr(entryIds[ctr])+':' +inttostr(QryMatrix.fieldbyname('xId').asInteger) +']'
      else if entryIds[ctr] =  PriceMethod.YAxisID then result := result + '[' + inttostr(entryIds[ctr])+':' +inttostr(yvalueID) +']'
      else for x := 0 to combos.count-1 do
        if entryIds[ctr] =   TPartPriceSelection(combos[x]).PriceEntryID then begin
          result := result + '[' + inttostr(entryIds[ctr])+':' +inttostr(TPartPriceSelection(combos[x]).SelectedID) +']';
          break;
        end;
    end;
  finally
    FreeandNil(EntryIds);
  end;
end;

function TfmPartsPriceMatrix.CombosCreated: Boolean;
begin
  Result := combos.count >0;
end;

procedure TfmPartsPriceMatrix.CopytoclipBoard;
var
  x:Integer;
  Buff:String;
begin
  Buff:= ''+#9;
  for x:= low(pricemethod.PriceAttribs) to high(pricemethod.PriceAttribs) do
    Buff:= Buff + pricemethod.PriceAttribs[x].Displaylabel+ #9;
  Buff:= Buff + #$D#$A;
  Qrymatrix.first;
  While Qrymatrix.Eof = false do begin
    Buff:= Buff+ Qrymatrix.fieldByname('xref').asString +#9;
    for x:= low(pricemethod.PriceAttribs) to high(pricemethod.PriceAttribs) do
     Buff:= Buff+ Qrymatrix.fieldByname(pricemethod.PriceAttribs[x].fieldname).asString +#9;
     Buff:= Buff + #$D#$A;
    Qrymatrix.Next;
  end;
  Clipboard.asText:= Buff;
end;

constructor TfmPartsPriceMatrix.Create(AOwner:Tcomponent;MyConnection: TERPConnection);
begin
   FormConnection := Myconnection;
   Create(AOwner);
   FormConnection := Myconnection;
   fParentControl :=nil;

end;

constructor TfmPartsPriceMatrix.Create(AOwner: TComponent);
begin
  inherited;

end;

Function TfmPartsPriceMatrix.ComboID(xEntryID:Integer):Integer;
var
  ctr:Integer;
begin
  REsult := -1;
  if combos.count=0 then exit;
  for ctr := 0 to combos.count-1 do begin
    if TPartPriceSelection(Combos[ctr]).PriceEntryID = xEntryId then begin
      REsult := ctr;
      exit;
    end;
  end;
end;
procedure TfmPartsPriceMatrix.CreateCombos(const Sender: TBusObj;  var Abort: boolean);
var
  obj :TPartPriceSelection;
  xcomboID:Integer;
begin
  if not(Sender is TPartsPriceMethodEntries) then exit;

  if TPartsPriceMethodEntries(SendeR).Id = PriceMethod.xAxisId then begin
    lblXAttribute.caption :=TPartsPriceMethodEntries(SendeR).EntryName;
    exit;
  end;
  if TPartsPriceMethodEntries(SendeR).Id = PriceMethod.yAxisId then begin
    lblYAttribute.caption :=TPartsPriceMethodEntries(SendeR).EntryName;
    exit;
  end;

  xcomboID:=ComboID(TPartsPriceMethodEntries(Sender).Id) ;
  if xcomboID=-1 then begin
    obj :=TPartPriceSelection.create(Self,TPartsPriceMethodEntries(Sender).EntryName ,
                                    TPartsPriceMethodEntries(Sender).Id,TERPconnection(QryMatrix.connection) ,
                                    PriceSelectionCombocloseup , 'E');
    combos.add(obj);
  end else begin
    TPartPriceSelection(combos[xcomboid]).RefreshLookup;
  end;
  (*obj :=TPartPriceSelection.create(Self,TPartsPriceMethodEntries(Sender).EntryName ,
                                    TPartsPriceMethodEntries(Sender).Id,TERPconnection(QryMatrix.connection) ,
                                    PriceSelectionCombocloseup , 'E');
    combos.add(obj);*)
  //
end;
procedure TfmPartsPriceMatrix.grdEntryPopupDblClick(Sender: TObject);
begin
  inherited;
(*  memFormula.Text := memFormula.Text  + '[' + qrypartspricemethodentriesEntryName.asString +']';*)
end;

procedure TfmPartsPriceMatrix.memFormulaMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
(*var
  EntryID:Integer;
begin
  inherited;
  if  (ssRight in shift) then begin
    qrypartspricemethod.disablecontrols;
    try
      EntryId := qrypartspricemethodID.asInteger;
    finally
      qrypartspricemethod.Locate('ID' , EntryId, []);
      qrypartspricemethod.enablecontrol;
    end;
  end;*)
end;

procedure TfmPartsPriceMatrix.N1Click(Sender: TObject);
var
  s, InsertStr, MenuCaption: string;
  x: integer;
begin
  InsertStr := '';
  MenuCaption := StringReplace(TMenuItem(Sender).Caption, '&', '',[rfReplaceAll,rfIgnoreCase]); // remove "&" added by delphi
  if TMenuItem(Sender).tag > 0 then begin
    InsertStr :='['+MenuCaption+']';
  end else begin
         if SameText(MenuCaption,'add' )      then InsertStr := '+'
    else if SameText(MenuCaption,'subtract')  then InsertStr := '-'
    else if SameText(MenuCaption,'multiply')  then InsertStr := '*'
    else if SameText(MenuCaption,'divide')    then InsertStr := '/'
    else if SameText(MenuCaption,'(')         then InsertStr := '('
    else if SameText(MenuCaption,')')         then InsertStr := ')';
  end;

  if InsertStr <> '' then begin
    s := memFormula.Text;
    x := memFormula.SelStart;
    Insert(InsertStr, s, x + 1);
    memFormula.Text     := s;
  end;
  PriceMethod.Qtyformula := s;
  PriceMethod.PostDB;
  SetcontrolFocus(memFormula);
  memFormula.SelStart := Length(memFormula.text);
end;

procedure TfmPartsPriceMatrix.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  SaveGrid;
  PriceMatrixTabIndex := 0;
end;

procedure TfmPartsPriceMatrix.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
var
  x:Integer;
  FieldList:TStringList;
  str:STring;
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TPartsPriceMethod then TPartsPriceMethod(Sender).Dataset                   := qrypartspricemethod
        else if Sender is TPartsPriceMethodEntries then TPartsPriceMethodEntries(Sender).Dataset:= qrypartspricemethodentries
        else if Sender is TPartsPriceMethodValues then begin
          if (assigned(Sender.owner)) and (Sender.owner is TPartsPriceMethodEntries) then TPartsPriceMethodValues(Sender).Dataset:= qrypartspricemethodvalues;
        end;
    end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AfterInsert) then begin
      if sender is TPartsPriceMethod then begin
        TPartsPriceMethod(Sender).ProductId := Self.ProductID;
      end;
    end else if (Eventtype = BusobjEvent_ToDo) and (Value = ValuesRefreshed) then begin
      if qrypartspricemethodvalues.SQL.text <> Sender.SQL then begin
        if qrypartspricemethodvalues.active then qrypartspricemethodvalues.close;
        qrypartspricemethodvalues.SQL.text := Sender.SQL;
        qrypartspricemethodvalues.open;
      end;
    end else if (Eventtype = BusobjEvent_ToDo) and (Value = MatrixRefreshed) then begin
      if QryMatrix.active then QryMatrix.close;
      QryMatrix.SQL.clear;
      QryMatrix.SQL.text := 'Select * from ' +  PriceMethod.Tablename;
      QryMatrix.open;
      grdMatrix.Selected.clear;
      FieldList:=TStringList.create;
      try
        str := 'xref' + #9 +'10' + #9 +' '+ #9+'T' +#9;
        FieldList.add(str);
        for x:= low(PriceMethod.PriceAttribs) to high(PriceMethod.PriceAttribs) do begin
          if QryMatrix.findfield(PriceMethod.PriceAttribs[x].FieldName) <> nil then begin
            str := PriceMethod.PriceAttribs[x].FieldName + #9 +'10' + #9 +PriceMethod.PriceAttribs[x].Displaylabel+ #9 +#9;
            FieldList.add(str);
            if QryMatrix.findfield(PriceMethod.PriceAttribs[x].FieldName) is TFloatField then
              TFloatField(QryMatrix.findfield(PriceMethod.PriceAttribs[x].FieldName)).currency := True;
          end;
        end;
      finally
        grdMatrix.Selected := FieldList;
        grdMatrix.ApplySelected;
        freeandnil(fieldList);
      end;
    end;
end;

procedure TfmPartsPriceMatrix.FormCreate(Sender: TObject);
begin
  inherited;
  PriceMethod :=TPartsPriceMethod.create(Self);
  PriceMethod.connection := TMyDacDataConnection.create(PriceMethod);
  PriceMethod.connection.connection := Formconnection;
  PriceMethod.BusObjEvent := DoBusinessObjectEvent;
  Combos:= TObjectList.create;
end;

procedure TfmPartsPriceMatrix.FormDestroy(Sender: TObject);
var
  ctr:Integer;
begin
  FormConnection:=nil;
  fiProductID :=0;
  if combos.count>0 then
    for ctr:= combos.count-1 downto 0 do begin
      TPartPriceSelection(combos[ctr]).Parent := nil;
      combos.Delete(ctr);
    end;
  FreeAndNil(Combos);
  inherited;
end;

procedure TfmPartsPriceMatrix.grdMatrixCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Assigned(Field) and sameText(Field.fieldname  , 'xref') then begin
    ABrush.color := clmoneyGreen;
  end;
end;

procedure TfmPartsPriceMatrix.grdMatrixColEnter(Sender: TObject);
begin
  inherited;
  if Sametext(grdMatrix.GetActivefield.Fieldname , 'xref') then begin
    grdMatrix.SetActivefield(pricemethod.PriceAttribs[0].fieldname);
  end;
end;

procedure TfmPartsPriceMatrix.grdMatrixEnter(Sender: TObject);
begin
  inherited;
  grdMatrix.SetActivefield(pricemethod.PriceAttribs[0].fieldname);
end;

procedure TfmPartsPriceMatrix.grdMatrixExit(Sender: TObject);
begin
  inherited;
  postdb(Qrymatrix);
  SaveGrid;
end;

procedure TfmPartsPriceMatrix.grdMatrixKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ssCtrl in shift then
    if (Key = ord('V')) or (Key =Ord('v')) then begin
      ImportFromClipBoard;
    end else if (Key = ord('C')) or (Key =Ord('c')) then begin
      CopytoclipBoard;
    end;
end;

procedure TfmPartsPriceMatrix.onTabchange(const Tabindex: Integer);
var
  ctr:Integer;
begin
if Tabindex =0 then begin
  if qrycboxpartspricemethodentries.active = False then qrycboxpartspricemethodentries.open;
  if qrycboypartspricemethodentries.active = False then qrycboypartspricemethodentries.open;
  RefreshLookups;
end else if Tabindex = 1 then begin
  PriceMethod.CreateMatrix;
  if QryMatrix.active = False then QryMatrix.open;
  PriceMethod.pricemethodentries.Iteraterecords(CreateCombos);

  if combos.count>0 then
    for ctr := Combos.count-1 downto 0 do begin
      TPartPriceSelection(Combos[ctr]).parent := scMain;
      TPartPriceSelection(Combos[ctr]).align := Altop;
    end;

  pnlOptions.visible := combos.count>0;
  RefreshGrid;

  if not CombosCreated then begin
  end else
    for ctr := 0 to combos.count-1 do
      TPartPriceSelection(Combos[ctr]).RefreshLookup;
end;
end;

procedure TfmPartsPriceMatrix.PriceSelectionCombocloseup(Sender: TObject);
begin
  RefreshGrid;
end;

procedure TfmPartsPriceMatrix.pumFormulaPopup(Sender: TObject);
begin
  inherited;
    mnuColumns.Clear;
    if PriceMethod.pricemethodentries.count =0 then exit;
    PriceMethod.pricemethodentries.Iteraterecords(FormulaPopupCallback);
  end;
Procedure TfmPartsPriceMatrix.FormulaPopupCallback(Const Sender: TBusObj; var Abort: boolean);
var
    item : TMenuItem;
begin
  if not(Sender is TPartsPriceMethodEntries) then exit;
  item := TMenuItem.Create(self);
  item.Caption := TPartsPriceMethodEntries(Sender).EntryName;
  item.Tag := Sender.Id;
  item.OnClick := N1Click;
  mnuColumns.Add(item);
end;
procedure TfmPartsPriceMatrix.qrypartspricemethodAfterPost(DataSet: TDataSet);
begin
  inherited;
  RefreshLookups;

end;

procedure TfmPartsPriceMatrix.qrypartspricemethodentriesAfterPost(DataSet: TDataSet);
begin
  inherited;
  if qrycboypartspricemethodentries.active then qrycboypartspricemethodentries.Close;
  qrycboypartspricemethodentries.open;
  if qrycboxpartspricemethodentries.active then qrycboxpartspricemethodentries.Close;
  qrycboxpartspricemethodentries.open;
end;

procedure TfmPartsPriceMatrix.RefreshGrid;
var
  ctr:Integer;
begin
  if QryMatrix.recordcount =0 then exit;
  QryMatrix.first;
  While QryMatrix.Eof = False do begin
    for ctr := low(PriceMethod.PriceAttribs) to high(PriceMethod.PriceAttribs) do begin
      EditDB(QryMatrix);
      if PriceMethod.PartsPriceEntrys.Locate('EntryValueRef' , CellRef(PriceMethod.PriceAttribs[ctr].fieldname) , []) then begin
        QryMatrix.fieldbyname(PriceMethod.PriceAttribs[ctr].fieldname).asFloat :=PriceMethod.PartsPriceEntrys.Price;
      end else begin
        QryMatrix.fieldbyname(PriceMethod.PriceAttribs[ctr].fieldname).Value := NULL;
      end;
      PostDB(QryMatrix);
    end;
    QryMatrix.Next;
  end;
end;

procedure TfmPartsPriceMatrix.RefreshLookups;
begin
  if qrycboypartspricemethodentries.active then qrycboypartspricemethodentries.Close;
  if qrycboxpartspricemethodentries.active then qrycboxpartspricemethodentries.Close;

  if qrycboypartspricemethodentries.parambyname('PriceMethodId').asInteger <> PriceMethod.Id then
     qrycboypartspricemethodentries.parambyname('PriceMethodId').asInteger := PriceMethod.Id;
  if qrycboxpartspricemethodentries.parambyname('PriceMethodId').asInteger <> PriceMethod.Id then
     qrycboxpartspricemethodentries.parambyname('PriceMethodId').asInteger := PriceMethod.Id;

  if qrycboxpartspricemethodentries.parambyname('yaxisId').asInteger <> PriceMethod.yAxisId then
     qrycboxpartspricemethodentries.parambyname('yaxisId').asInteger  := PriceMethod.yAxisId;
  if qrycboypartspricemethodentries.parambyname('xaxisId').asInteger <> PriceMethod.xAxisId then
     qrycboypartspricemethodentries.parambyname('xaxisId').asInteger  := PriceMethod.xAxisId;

    qrycboypartspricemethodentries.open;
    qrycboxpartspricemethodentries.open;
end;
procedure TfmPartsPriceMatrix.ImportFromClipBoard;
var
    TextFileStrings, TextFileString, FieldNames: TStringList;
    Buff     : string;
    x,y, ctr:Integer;
    function fieldindex (const fieldname:String):Integer;
    var
      i:Integer;
    begin
      result := -1;
      for i := low(PriceMethod.PriceAttribs) to high(PriceMethod.PriceAttribs) do
        if Sametext(PriceMethod.PriceAttribs[i].Displaylabel , fieldname) then begin
          Result := i;
          break;
        end;
    end;
begin
  inherited;
  if qrymatrix.recordcount =0 then exit;

  Buff := Clipboard.asText;
  if Buff= '' then Exit;
  TextFileStrings:= TStringList.create;
  try
    Buff:='"'+ StringReplace(StringReplace(Stripquotes(Buff), #$D#$A ,'","',[rfReplaceAll]), #9 , ',' , [rfReplaceAll])+'"';
    TextFileStrings.Commatext := Buff;
    if TextFileStrings.count <=1 then exit;

    (*QryMatrix.first;*)
    TextFileString :=TStringlist.create;
    FieldNames:=TStringlist.create;
    try
      Split(TextFileStrings[0] , ',' , FieldNames); //first line is fieldnames
      if fieldnames.count <= 1 then exit;
      for x := 1 to TextFileStrings.count-1 do begin
        Split(TextFileStrings[x] , ',' , TextFileString);

        if TextFileString.count<=1 then continue;
        if not Qrymatrix.locate('xref' ,  TextFileString[0] , []) then continue;

        for y := 1 to TextFileString.count-1 do begin
          //if high(PriceMethod.PriceAttribs) > y then break;
            ctr:=fieldindex(FieldNames[y]);
            if ctr>= 0 then
              if IsNumeric(TextFileString[y]) then begin
                editdb(QryMatrix);
                QryMatrix.fieldByname(PriceMethod.PriceAttribs[ctr].FieldName).asFloat :=strTofloat(TextFileString[y]);
                PostDB(QryMatrix);
              end else begin
                editdb(QryMatrix);
                QryMatrix.fieldByname(PriceMethod.PriceAttribs[ctr].FieldName).Value := NULL;
                PostDB(QryMatrix);
              end;
        end;
        (*QryMatrix.Next;
        if QryMatrix.Eof then break;*)
      end;
    finally
        Freeandnil(TextFileString);
        Freeandnil(FieldNames);
    end;
  finally
    FreeandNil(TextFileStrings);
  end;
end;
function TfmPartsPriceMatrix.SAve: boolean;
begin
  result := False;
  PriceMethod.PostDB;
  if not PriceMethod.ValidateData then exit;
  if not PriceMethod.Save then exit;
  Result := True;
end;

procedure TfmPartsPriceMatrix.SaveGrid;
var
  ctr:Integer;
  xcellref:String;
begin
  if QryMatrix.recordcount =0 then exit;

  QryMatrix.first;
  While QryMatrix.Eof = False do begin
    for ctr := low(PriceMethod.PriceAttribs) to high(PriceMethod.PriceAttribs) do begin
      xcellref:=CellRef(PriceMethod.PriceAttribs[ctr].fieldname);
      if not PriceMethod.PartsPriceEntrys.Locate('EntryValueRef' , xcellref , []) then begin
          PriceMethod.PartsPriceEntrys.New;
          PriceMethod.PartsPriceEntrys.EntrynValueRef := xCellref;
      end;
      PriceMethod.PartsPriceEntrys.Price :=QryMatrix.fieldbyname(PriceMethod.PriceAttribs[ctr].fieldname).asFloat;
      PriceMethod.PartsPriceEntrys.PostDB;
    end;
    QryMatrix.Next;
  end;

end;

procedure TfmPartsPriceMatrix.SetFormConnection(const Value: TERPConnection);
var
  ctr:Integer;
begin
  fFormConnection := Value;
  for ctr := 0 to componentCount-1 do begin
    if Components[ctr] is TERpQuery then begin
      if TERpQuery(Components[ctr]).active then TERpQuery(Components[ctr]).close;
      TERpQuery(Components[ctr]).connection := Value;
    end;
  end;
end;

procedure TfmPartsPriceMatrix.SetProductID(const Value: Integer);
begin
   fiProductID := Value;
  PriceMethod.LoadSelect('ProductId = ' +inttostr(Value));
  if accesslevel <5 then begin
    if PriceMethod.count = 0 then begin
      PriceMethod.New;
      PriceMethod.PostDB;
    end;
  end;
  PriceMethod.pricemethodentries;
  qryUnitOfMeasure.Close;
  qryUnitOfMeasure.ParamByName('xPartID').AsInteger := Value;
  qryUnitOfMeasure.Open;
end;

procedure TfmPartsPriceMatrix.ShowPriceMatrixHelp(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, TRue, 'Price Matrix');
end;

procedure TfmPartsPriceMatrix.wwDBGrid3Exit(Sender: TObject);
begin
  inherited;
  PriceMethod.pricemethodentries.POstDb;
end;

procedure TfmPartsPriceMatrix.wwDBGrid4Exit(Sender: TObject);
begin
  inherited;
  if assigned(PriceMethod.pricemethodentries.pricemethodvalues) then
    PriceMethod.pricemethodentries.pricemethodvalues.PostDB;
end;

procedure TfmPartsPriceMatrix.cboxAxisCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  PriceMethod.XAXisId := qrycboxpartspricemethodentriesID.asInteger;
  PriceMethod.XAXis := qrycboxpartspricemethodentriesName.asString;
  PriceMethod.PostDB;
end;

procedure TfmPartsPriceMatrix.cboxAxisDropDown(Sender: TObject);
begin
  inherited;
  RefreshLookups;
end;

procedure TfmPartsPriceMatrix.cboyAxisCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  PriceMethod.YAXisId := qrycboypartspricemethodentriesID.asInteger;
  PriceMethod.YAXis := qrycboypartspricemethodentriesName.asString;
  PriceMethod.PostDB;;
end;

procedure TfmPartsPriceMatrix.cboyAxisDropDown(Sender: TObject);
begin
  inherited;
  RefreshLookups;

end;

procedure TfmPartsPriceMatrix.SetPriceMatrixTabIndex(const Value: Integer);
begin
  fiPriceMatrixTabIndex := Value;
  if not Assigned(ParentControl) then exit;
  if Value =0 then begin
    pnlmain.visible   := False;
    pnlmatrix.visible := True;
    pnlmatrix.Parent  := ParentControl;
    onTabchange(0);
  end else begin
    pnlmatrix.visible := False;
    pnlmain.visible   := True;
    pnlmain.Parent    := ParentControl;
    onTabchange(1);
  end;
end;
initialization
  RegisterClassOnce(TfmPartsPriceMatrix);

end.
