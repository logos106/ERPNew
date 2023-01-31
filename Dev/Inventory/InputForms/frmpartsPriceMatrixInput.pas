unit frmpartsPriceMatrixInput;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, AdvScrollBox,
  DNMSpeedButton, DNMPanel, DB, DBAccess, MyAccess, ERPdbComponents, BusObjBase, Contnrs,
  StdCtrls, Shader , BaseProcTreeEdit, BaseInputForm, MemDS, ImgList, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, ProgressDialog;

type
  TRefreshentry = Procedure(entry,value:String) of object;
  TEntryItem = record
    Entryname:String;
    EntryValue:String;
  end;
  TfmpartsPriceMatrixInput = class(TBaseinputGUI)
    pnlOptions: TDNMPanel;
    scMain: TAdvScrollBox;
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    EdtPrice: TEdit;
    lblPrice: TLabel;
    edtvalue: TEdit;
    lblvalue: TLabel;
    edtRef: TEdit;
    lblRef: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fiProductId: Integer;

    fMyconnection: TERPconnection;
    Combos                : TObjectList;
    fsEntrynValueRef: String;
    fsEntrynValue: String;
    xAxisID:Integer;
    yAxisID:Integer;
    fPriceQuery:TERpQuery;
    ProductPrice1:double;
    fEntryItem:TEntryItem;
    fdPrice: Double;

    (*Function CombosCreated:Boolean;*)
    Procedure CreateCombos(Const Sender: TBusObj; var Abort: boolean);
    Procedure CreateCombo(const Sender: TBusObj);
    Procedure PriceSelectionCombocloseup(Sender:TObject);
    (*function DoPriceMAtrix(var fentrynValueRef, fEntrynValue:String):double;*)
    Procedure DoPriceMAtrix(fentrynValueRef , fEntrynValue: String);
    (*procedure RefreshValue(fentrynValueRef:String);*)
    procedure SaveDetails;
    Function PriceQuery:TERPQuery;
    procedure SetProductID(const Value: Integer);
    procedure SetEntrynValue(const Value: String);
    procedure setEntrynValueRef(const Value: String);
    procedure ProcessEntry(const Value: String; RefreshEntry: TRefreshentry);
    procedure RefreshEntryValue(Entry, Value: String);
    procedure RefreshEntryRef(Entry, Value: String);
    procedure setEntryItem(Value: String);
    Property EntryItem :String write setEntryItem;
  public
    Property ProductId :Integer read fiProductId write SetProductID;
    Property FormMyconnection :TERPconnection Read fMyconnection write fMyconnection;
    Property EntrynValueRef :String read fsEntrynValueRef write setEntrynValueRef;
    Property EntrynValue :String read fsEntrynValue  write SetEntrynValue;
    Property Price :Double read fdPrice;
    Class Function PriceMAtrix(AOwner:TComponent; var fentrynValueRef, fEntrynValue:String; var fdPrice:Double;fProductID:Integer; fconnection :TERPConnection):Double;
    function Save:Boolean;

  end;

implementation

uses busobjPartsPriceMatrix, objPartPriceSelection, BusObjConst, CommonLib, FastFuncs,
  CommonDbLib, idStrings;


{$R *.dfm}

{ TfmpartsPriceMatrixInput }

procedure TfmpartsPriceMatrixInput.btnCancelClick(Sender: TObject);
begin
  inherited;
  modalresult := mrCancel;
end;

procedure TfmpartsPriceMatrixInput.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Save then Modalresult := mrok;
end;

(*function TfmpartsPriceMatrixInput.CombosCreated: Boolean;
begin
  Result := combos.count >0;
end;*)

procedure TfmpartsPriceMatrixInput.CreateCombo(const Sender: TBusObj);
var
  obj :TPartPriceSelection;
begin
  if not (Sender is TPartsPriceMethodEntries) then exit;

  obj :=TPartPriceSelection.create(Self,TPartsPriceMethodEntries(Sender).EntryName ,
          TPartsPriceMethodEntries(Sender).Id,
          FormMyconnection ,
          PriceSelectionCombocloseup, TPartsPriceMethodEntries(Sender).EntryOption);
  combos.add(obj);
end;

procedure TfmpartsPriceMatrixInput.CreateCombos(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not(Sender is TPartsPriceMethodEntries) then exit;
  if TPartsPriceMethodEntries(SendeR).Id = xAxisId then Exit;
  if TPartsPriceMethodEntries(SendeR).Id = yAxisId then exit;
  CreateCombo(SendeR);
end;

procedure TfmpartsPriceMatrixInput.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmpartsPriceMatrixInput.FormCreate(Sender: TObject);
begin
  inherited;
 {$IFDEF DevMode}
   lblRef.visible := True;
   edtRef.visible := True;
   edtvalue.visible := True;
   lblvalue.visible := True;
 {$ENDIF}
  Combos:= TObjectList.create;
  if assigned(Self.Owner) then
    if self.Owner is TForm then
      Self.color := Tform(Self.Owner).color;
  fPriceQuery:= nil;
  ProductPrice1:=0;
end;

procedure TfmpartsPriceMatrixInput.FormDestroy(Sender: TObject);
begin
  Freeandnil(Combos);

  inherited;
end;
Procedure TfmpartsPriceMatrixInput.DoPriceMAtrix(fentrynValueRef, fEntrynValue: String);
var
  ctr:Integer;
  PriceMethod :TPartsPriceMethod;
begin
  PriceMethod :=TPartsPriceMethod.create(Self);
  try
    PriceMethod.connection := TMydacDataconnection.create(Self);
    if FormMyconnection = nil then FormMyconnection:= commondblib.GetNewMyDacConnection(self);
    PriceMethod.connection.connection := FormMyconnection;
    PriceMethod.LoadSelect('ProductId = ' +inttoStr(ProductID));
    if PriceMethod.count =0 then begin
      MessageDlgXP_Vista('Price Matrix is not Defined for this Product.',mtInformation , [mbok] , 0);
      exit;
    end;
    {x , y combos first}
    if PriceMethod.xAxisID>0 then
      if PriceMethod.pricemethodentries.Locate('ID' , PriceMethod.xAxisID, []) then
        CreateCombo(PriceMethod.PriceMethodentries);

    if PriceMethod.yAxisID>0 then
      if PriceMethod.pricemethodentries.Locate('ID' , PriceMethod.yAxisID, []) then
        CreateCombo(PriceMethod.PriceMethodentries);
    {all other attributes}
    xAxisId := PriceMethod.xAxisId;
    yAxisId := PriceMethod.yAxisId;
    PriceMethod.pricemethodentries.Iteraterecords(CreateCombos);
    if combos.count>0 then begin
      (*for ctr := Combos.count-1 downto 0 do begin*)
      for ctr :=  0 to Combos.count-1  do begin
        TPartPriceSelection(Combos[ctr]).parent := scMain;
        TPartPriceSelection(Combos[ctr]).align := alleft;
        TPartPriceSelection(Combos[ctr]).Taborder := ctr;
      end;
      TPartPriceSelection(Combos[0]).SetFocus;
    end;
    if combos.count>6 then begin
      Self.Width:=6*124;
      scMain.HorzScrollBar.Visible := True;
    end else begin
      Width:= combos.count*124;
      scMain.HorzScrollBar.Visible := False;
    end;
    //RefreshValue(fentrynValueRef);
    EntrynValueRef :=fentrynValueRef;
    EntrynValue :=fEntrynValue;

  finally
    Freeandnil(PriceMethod);
  end;
end;

(*Procedure TfmpartsPriceMatrixInput.RefreshValue(fentrynValueRef:String);
var
  ctr,i:Integer;
  st,st1:TStringlist;
  s:string;
  EntryId, valueId:Integer;
begin
  if fentrynValueRef <> '' then begin
    st:=TStringList.create;
    st1:=TStringList.create;
    try
        Split( fentrynValueRef, ',' , st);
        if st.count =0 then exit;
        for ctr := 0 to st.count-1 do begin
           ReadRef(s, EntryId, ValueID);
           if (EntryId<>0) and (ValueID<> 0) then begin
               for i := 0 to combos.count-1 do begin
                 if TPartPriceSelection(combos[ctr]).PriceEntryId = entryId then begin
                    TPartPriceSelection(combos[ctr]).SelectedId :=ValueID;
                 end;
               end;
           end;
        end;
    finally
      FreeandNil(st);
      FreeandNil(st1);
    end;
  end;
  SaveDetails;
end;*)

class function TfmpartsPriceMatrixInput.PriceMAtrix(AOwner:TComponent; var fentrynValueRef,  fEntrynValue: String; var fdPrice:Double;fProductID:Integer; fconnection :TERPConnection): Double;
var
  form :TComponent;
begin
  Result := 0;
  (*fentrynValueRef:= '';
  fEntrynValue:= '';*)
  form := GetComponentByClassName('TfmpartsPriceMatrixInput', False, AOwner, False);
  if not assigned(form) then exit;
  if AOwner is TForm then TfmpartsPriceMatrixInput(form).color:=  TForm(AOwner).color;
  TfmpartsPriceMatrixInput(Form).FormMyconnection :=fconnection;
  TfmpartsPriceMatrixInput(Form).productId :=fProductID;
  TfmpartsPriceMatrixInput(Form).dopriceMatrix(fentrynValueRef , fEntrynValue);
  if TfmpartsPriceMatrixInput(Form).combos.count = 0 then begin
    (*MessageDlgXP_Vista('Price Matrix is Not Defined for this Product.',mtInformation , [mbok] , 0);*)
    exit;
  end;
  TfmpartsPriceMatrixInput(Form).ShowModal;
  if TfmpartsPriceMatrixInput(Form).modalresult =mrok then begin
     fentrynValueRef:= TfmpartsPriceMatrixInput(Form).entrynValueRef;
     fEntrynValue   := TfmpartsPriceMatrixInput(Form).EntrynValue;
     fdPrice        := TfmpartsPriceMatrixInput(Form).Price;
  end;
end;

function TfmpartsPriceMatrixInput.PriceQuery: TERPQuery;
begin
  if fPriceQuery = nil then fPriceQuery:= TempMyQuery;

  if Assigned(FormMyconnection) and (fPriceQuery.connection <> FormMyconnection) then
    fPriceQuery.connection := FormMyconnection;

  Result := fPriceQuery;
end;

procedure TfmpartsPriceMatrixInput.PriceSelectionCombocloseup(Sender: TObject);
begin
  SaveDetails;
end;
function TfmpartsPriceMatrixInput.Save : Boolean;
var
  ctr:Integer;
begin
  for ctr:= 0 to combos.count-1 do begin
    if (TPartPriceSelection(combos[ctr]).SelectedId=0) or
        (TPartPriceSelection(combos[ctr]).Selectedtext = '') then begin
          result := False;
          Exit;
        end;
  end;
  Result := True;
  SaveDetails;
end;

Procedure TfmpartsPriceMatrixInput.SaveDetails;
var
  ctr:Integer;
  s:String;
  strSQL:String;
begin
  fsEntrynValueRef:='';
  fsEntrynValue:='';;
  strSQL:= '';
  for ctr:= 0 to combos.count-1 do begin
    s:='[' +TPartPriceSelection(combos[ctr]).Entryname+':'+TPartPriceSelection(combos[ctr]).Selectedtext+']';
    if fsEntrynValue <> '' then fsEntrynValue := fsEntrynValue +',';
    fsEntrynValue := fsEntrynValue + s;
    if strSQL<>'' then strSQL :=strSQL  +' and ';

    s:='[' +inttostr(TPartPriceSelection(combos[ctr]).PriceEntryID)+':'+inttostr(TPartPriceSelection(combos[ctr]).SelectedId)+']';
    if fsEntrynValueRef <> '' then fsEntrynValueRef := fsEntrynValueRef +',';
    fsEntrynValueRef := fsEntrynValueRef + s;
    strSQL  := strSQL  + 'EntryValueRef like '+Quotedstr('%' +s+'%');
  end;

  edtRef.text := fsEntrynValueRef;
  edtValue.text := fsEntrynValue;

  EdtPrice.text := '';
  fdPrice := 0;
  if strSQL <> '' then
    with PriceQuery do begin
      if active then close;
      SQL.text := 'SELECT Price FROM tblpartspriceentry Where '+strSQL;
      open;
      if fieldbyname('Price').asFloat <> 0 then
        fdPrice := fieldbyname('Price').asFloat
      else
        fdPrice :=  ProductPrice1;
      EdtPrice.Text := FloatToStrF(fdPrice,ffCurrency, 15, CurrencyRoundPlaces)
    end;
end;
procedure TfmpartsPriceMatrixInput.setEntryItem(Value: String);
begin
  Value := replaceStr(replaceStr(Value, '[' , ''), ']' , '');
  SplitString(Value , ':' ,fEntryItem.entryName  ,  fEntryItem.entryValue);
end;

procedure TfmpartsPriceMatrixInput.RefreshEntryRef(Entry, Value: String);
var
  ctr:Integer;
begin
  for ctr :=  0 to Combos.count-1  do begin
    if TPartPriceSelection(Combos[ctr]).PriceEntryID = strtoint(entry) then begin
      if TPartPriceSelection(Combos[ctr]).SelectedId <> strToint(Value) then
        TPartPriceSelection(Combos[ctr]).SelectedId := strToint(Value);
      Exit;
    end;

  end;

end;

procedure TfmpartsPriceMatrixInput.RefreshEntryValue(Entry, Value:String);
var
  ctr:Integer;
begin
  for ctr :=  0 to Combos.count-1  do begin
    if TPartPriceSelection(Combos[ctr]).Entryname = entry then begin
      if TPartPriceSelection(Combos[ctr]).Selectedtext <> Value then
        TPartPriceSelection(Combos[ctr]).Selectedtext := Value;
      Exit;
    end;
  end;
end;
procedure TfmpartsPriceMatrixInput.ProcessEntry(const Value: String; RefreshEntry:TRefreshentry);
var
  ctr:Integer;
  st:TStringList;
begin
  st:= tStringList.create;
  Try
    st.commatext := Value;
    if st.count =0 then exit;
    for ctr := 0 to st.count-1 do begin
      EntryItem :=st[ctr];
      RefreshEntry(fEntryItem.entryName  ,  fEntryItem.entryValue);
    end;
  Finally
    Freeandnil(st);
  End;

end;
procedure TfmpartsPriceMatrixInput.SetEntrynValue(const Value: String);
begin
  fsEntrynValue := Value;
  ProcessEntry(Value , RefreshEntryValue);
  SaveDetails;{calculate price based on the selection}
end;

procedure TfmpartsPriceMatrixInput.setEntrynValueRef(const Value: String);
begin
  fsEntrynValueRef := Value;
  ProcessEntry(Value , RefreshEntryRef);
  SaveDetails;{calculate price based on the selection}
end;

procedure TfmpartsPriceMatrixInput.SetProductID(const Value: Integer);
begin
  fiProductId := Value;
  with PriceQuery do begin
    if active then close;
    SQL.text := 'Select PRICE1 from tblparts where partsId =' + inttostr(Value);
    open;
    ProductPrice1:= fieldbyname('Price1').asfloat;
  end;
end;

initialization
  RegisterClassOnce(TfmpartsPriceMatrixInput);

end.
