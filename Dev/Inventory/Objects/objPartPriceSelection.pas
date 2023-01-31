unit objPartPriceSelection;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, StdCtrls,
  ExtCtrls, DNMPanel , Wwdbcomb, IntegerListObj;

type
  TPartPriceSelection = class(TDNMPanel)
    Private
      lblCaption: TLabel;
      lblhint: TLabel;
      cboLookup: TCombobox;
      cboLookupvalues:TIntegerList;
      fiPriceEntryID:Integer;
      fodataset :TDataset;
      fmyconnection: TERPconnection;
      fsEntryOption: String;
      fSortedValues:TERpQuery;
      fonselection: TNotifyEvent;
      fiSelectedId: Integer;
      fsSelectedTExt: String;
      procedure setPriceselectionCaption(const Value: String);
      procedure setPriceEntryID(const Value: Integer);
      procedure setDataset(const Value: TDataset);
      function getEntryname: String;
      Function ValuesAreNumeric:Boolean;
      procedure setSelectedId(const Value: Integer);
      Procedure CmboExit(Sender:TObject);
      Procedure Combocloseup(Sender:TObject);
      procedure setEntryOption(const Value: String);
      function SortedValues:TERPQuery;
    procedure setSelectedText(const Value: String);
    Public
      Property PriceselectionCaption :String write setPriceselectionCaption;
      Property PriceEntryID:Integer read fiPriceEntryID Write setPriceEntryID;
      Property Dataset:TDataset read fodataset write setDataset;
      constructor Create(AOwner: TComponent); overload; override;
      constructor Create(AOwner: TComponent;fCaption :String ; fPriceEntryID:Integer;  fconnection : TERPconnection; PriceSelectionCombocloseup: TNotifyEvent;fEntryOption:String); reintroduce;overload;
      Destructor Destroy; override;
      Procedure RefreshLookup;
      Property SelectedID :Integer Read fiSelectedId write setSelectedId;
      Property SelectedTExt :String read fsSelectedTExt write setSelectedText;
      Property Entryname:String read getEntryname;
      Property myconnection : TERPconnection read fmyconnection  write fMyconnection;
      Property EntryOption :String read fsEntryOption write setEntryOption;
      Procedure SetFocus;Override;
      Property onselection :TNotifyEvent Read fonselection write fonselection;
  end;

  Procedure ReadRef(Ref:String; var EntryId, ValueID:Integer);
implementation

uses CommonDbLib, CommonLib, FastFuncs, idstrings;
{ TPartPriceSelection }
Procedure REadRef(Ref:String; var EntryId, ValueID:Integer);
var
   Entry, Value:String;
begin
  SplitString(Ref , ':' , entry, value);
  if isinteger(entry) then entryId := strtoint(Entry);
  if isinteger(Value) then ValueId := strtoint(Value);
(*var
  s:String;
  st:TStringlist;
begin
  st:= tstringlist.create;
  try
    s:= replacestr(replacestr(ref,'[' , '') , ']' , '');
    Split( s, ':' , st);
    if st.count=2 then begin
      entryId := strtoInt(st[0]);
      ValueId := strtoint(st[1]);
    end;
  finally
    Freeandnil(st);
  end;*)
end;
constructor TPartPriceSelection.Create(AOwner: TComponent);
begin
  fSortedValues:=nil;
  fonselection := nil;
  inherited Create(AOwner);
    Parent:= TWinControl(AOwner);
    Width       := 120;
    Height      := 45;
    //Align       := altop;
    Transparent := False;
    Parentcolor := true;
    Bevelouter  := bvNone;
    BevelInner  := bvNone;

    lblCaption        := TLabel.Create(Self);
    lblCaption.Parent := Self;
    lblCaption.Left   := 5;
    lblCaption.Top    := 2;
    lblCaption.Width  := 56;
    lblCaption.Height := 15;

    lblhint        := TLabel.Create(Self);
    lblhint.Parent := Self;
    lblhint.Left   := 100;
    lblhint.Top    := 2;
    lblhint.Width  := 75;
    lblhint.Height := 15;
    lblhint.Visible := False;
    lblhint.Alignment := taRightJustify;
    lblhint.font.color := clred;
    {$IFDEF DevMode}
      lblhint.visible:= True;
    {$ENDIF}

    cboLookup                   := TCombobox.create(self);
    cboLookup.Parent            := Self;
    cboLookup.Left              := 5;
    cboLookup.Top               := 16;
    cboLookup.Width             := 112;
    cboLookup.Height            := 23;
    cboLookup.TabOrder          := 0;
    cboLookup.AutoDropDown      := False;
    cboLookup.DropDownCount     := 8;
    cboLookup.Style             := csDropDownList;
    cboLookup.Parentfont        := False;
    cboLookup.font.size := 9;
    cboLookup.font.style := cboLookup.font.style - [fsbold];
    cboLookupvalues := TIntegerlist.create;
end;

procedure TPartPriceSelection.Combocloseup(Sender: TObject);
begin
  if cboLookup.itemindex >-1 then  begin
    fiSelectedId := cboLookupvalues[cboLookup.itemindex];
    fsSelectedTExt := cboLookup.Text;
  end;
  if assigned(fonselection) then fonselection(Sender);
end;

constructor TPartPriceSelection.Create(AOwner: TComponent; fCaption: String;fPriceentryId: Integer; fconnection : TERPconnection; PriceSelectionCombocloseup:TNotifyEvent; fEntryOption:String);
begin
  Create(AOwner);
  PriceselectionCaption := fCaption;
  MyConnection          := fconnection;
  PriceEntryID          := fPriceEntryID;
  cboLookup.OnCloseup     := Combocloseup;
  EntryOption := fEntryOption;
  fonselection :=PriceSelectionCombocloseup;
end;

destructor TPartPriceSelection.Destroy;
begin
  Freeandnil(cboLookupvalues);
  Freeandnil(fSortedValues);
  Freeandnil(cboLookup);
  Freeandnil(lblhint);
  Freeandnil(lblcaption);
  inherited;
end;

function TPartPriceSelection.getEntryname: String;
begin
  result :=  lblCaption.caption;
end;

procedure TPartPriceSelection.CmboExit(Sender: TObject);
var
  SelectedValue :double;
begin
  with SortedValues do begin
    if (recordcount =0) or (cbolookup.text='') or (not (isnumeric(cbolookup.text))) then begin
        cboLookup.text := '';
        fsSelectedTExt:= '';
        fiSelectedId:= 0;
        Exit;
    end;
    SelectedValue := strTofloat(cbolookup.text);

    if Entryoption = 'P' then begin
      filter :=     'Value <= '+floatToStr(SelectedValue);
      filtered:= true;
      Last;
    end else if Entryoption = 'N' then begin
      filter :=     'Value >= '+floatToStr(SelectedValue);
      filtered:= true;
      First;
    end;
    fsSelectedTExt:= cboLookup.text;
    fiSelectedId:= fieldbyname('Id').asInteger;
  end;
  if assigned(fonselection) then fonselection(Sender);
end;

procedure TPartPriceSelection.RefreshLookup;
begin
   With tempmyQuery do try
      connection := Myconnection;
      SQL.add('Select  `ID`,`Value`, SalesDefault  from tblpartspricemethodvalues  where `PriceEntryID` = ' + inttostr(fiPriceEntryID));
      open;
      cboLookup.items.clear;
      if recordcount =0 then exit;
      first;
      While eof = False do begin
        cboLookup.items.Add(fieldbyname('value').asString);
        cboLookupvalues.add(Fieldbyname('ID').asInteger);
        if Fieldbyname('SalesDefault').asBoolean then begin
          cboLookup.itemindex := cboLookup.Items.count-1;
          fiSelectedId  := cboLookupvalues[cboLookup.itemindex];
          fsSelectedTExt:= cboLookup.Text;
        end;
        Next;
      end;
      if cboLookup.ItemIndex <0 then cboLookup.ItemIndex := 0;
   finally
      if active then close;
      Free;
   end;
end;

procedure TPartPriceSelection.setDataset(const Value: TDataset);
begin
  fodataset := Value;
end;

procedure TPartPriceSelection.setEntryOption(const Value: String);
begin
  fsEntryOption := Value;
  if (fsEntryOption='E') or not(ValuesAreNumeric) then
    cboLookup.Style             := csDropDownList
  else begin
    cboLookup.Style             := csDropDown;
    cboLookup.onExit            := CmboExit;
  end;
  lblhint.caption :=fsEntryOption;
end;

procedure TPartPriceSelection.SetFocus;
begin
  setcontrolfocus(cbolookup);
end;

procedure TPartPriceSelection.setPriceEntryID(const Value: Integer);
begin
  fiPriceEntryID := Value;
  RefreshLookup;
end;

procedure TPartPriceSelection.setPriceselectionCaption(const Value: String);
begin
  lblCaption.caption := value;
end;

procedure TPartPriceSelection.setSelectedId(const Value: Integer);
var
  ctr:Integer;
begin
  for ctr := 0 to cboLookupvalues.count -1 do
    if cboLookupvalues[ctr] = Value then begin
      fiSelectedId        := cboLookupvalues[ctr];
      cboLookup.itemindex := ctr;
      exit;
    end;
end;

procedure TPartPriceSelection.setSelectedText(const Value: String);
var
  ctr:Integer;
  function Previousindex:Integer;
  var
    LowValue,dValue,thisvalue:Double;
    x:Integer;
  begin
    result := 0;
    try
      dValue:=strTofloat(Value);
      LowValue:=strTofloat(cboLookup.items[0]);
      for x := 0 to cboLookupvalues.count -1 do begin
        thisvalue:=strTofloat(cboLookup.items[x]);
        if thisvalue>dValue then continue;
        if LowValue< thisvalue then begin
          result := x;
          Lowvalue := thisvalue
        end;
      end;
    Except
       // incase if the value is not numeric
    end;
  end;
  function Nextindex:Integer;
  var
    LowValue,dValue,thisvalue:Double;
    x:Integer;
  begin
    result :=0;
    try
      dValue:=strTofloat(Value);
      LowValue:=strTofloat(cboLookup.items[0]);
      for x := 0 to cboLookupvalues.count -1 do begin
        thisvalue:=strTofloat(cboLookup.items[x]);
        if thisvalue<dValue then continue;
        if LowValue>thisvalue then begin
          result := x;
          Lowvalue := thisvalue
        end;
      end;
    Except
       // incase if the value is not numeric
    end;
  end;

begin
  for ctr := 0 to cboLookupvalues.count -1 do
    if cboLookup.items[ctr] = value then begin
      cboLookup.itemindex := ctr;
      fsSelectedTExt      := Value;
      exit;
    end;
  {not exact match}
  if EntryOption = 'P' then begin
      cboLookup.itemindex := Previousindex;
      fsSelectedTExt:= Value;
      cboLookup.TExt := Value;
  end;
  if EntryOption = 'N' then begin
      cboLookup.itemindex := Nextindex;
      fsSelectedTExt:= Value;
      cboLookup.TExt := Value;
  end;
end;

function TPartPriceSelection.SortedValues: TERPQuery;
begin
  if not Assigned(fSortedValues) then begin
    fSortedValues:= TempmyQuery;
    fSortedValues.connection  := fmyconnection;
    fSortedValues.SQl.text    :=  ' SELECT ID, convert(value , DECIMAL) Value  from tblpartspricemethodvalues ' +
                                  ' WHERE PriceEntryID = ' +inttostr(PriceEntryID) +
                                  ' ORDER BY convert(value , DECIMAL)';
    fSortedValues.open;
  end;
  result := fSortedValues;
end;

function TPartPriceSelection.ValuesAreNumeric: Boolean;
var
  ctr:Integer;
begin
  for ctr := 0 to cbolookup.items.count-1 do
    if not ISNumeric(cbolookup.items[ctr]) then begin
      result := False;
      Exit;
    end;
  Result := True;
end;

end.
