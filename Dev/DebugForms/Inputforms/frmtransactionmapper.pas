unit frmtransactionmapper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ComCtrls, DB, Grids, Wwdbigrd, Wwdbgrid, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ExtCtrls, StdCtrls;

type
  Tfmtransactionmapper = class(TBaseInputGUI)
    QryTransactionmapper: TERPQuery;
    QryTransactionmapperGlobalRef: TWideStringField;
    QryTransactionmapperID: TIntegerField;
    QryTransactionmapperFromTranType: TWideStringField;
    QryTransactionmapperToTranType: TWideStringField;
    QryTransactionmapperMasterMappings: TWideMemoField;
    QryTransactionmapperDetailMappings: TWideMemoField;
    QryTransactionmapperEditedFlag: TWideStringField;
    QryTransactionmappermsTimeStamp: TDateTimeField;
    QryTransactionmappermsUpdateSiteCode: TWideStringField;
    wwDBGrid1: TwwDBGrid;
    dsTransactionmapper: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    mastersource1: TListBox;
    mastertarget1: TListBox;
    mastersource2: TListBox;
    mastertarget2: TListBox;
    detailSource1: TListBox;
    detailTarget1: TListBox;
    detailSource2: TListBox;
    detailTarget2: TListBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button3: TButton;
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabelselected(Sender: TObject);
    procedure RemoveSelection(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure RefreshDetails;
    procedure makelist(value: String; Sourcefields, Targetfields: TStringlist);
    procedure ListFields(Tablename: String; List:TListBox);
    function DetailMappings: String;
    function FromTranType: String;
    function MasterMappings: String;
    function ToTranType: String;
    function ValidateData: boolean;
    function ValidateIt(full, selection :TListbox):boolean;
    procedure Selecttable(Value: String; combo: TCombobox; ismaster: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib, CommonDbLib,  Clipbrd;


{$R *.dfm}
procedure Tfmtransactionmapper.ListFields(Tablename:String; List:TListBox);
begin
  List.Items.Clear;
  With TempMyQuery do try
    SQL.Add('desc ' +Tablename);
    open;
    if recordcount =0 then exit;
    first;
    While Eof = False do begin
      List.Items.Add(Fields[0].AsString);
      Next;
    end;
  finally
    closenFree;
  end;
end;
procedure Tfmtransactionmapper.Button1Click(Sender: TObject);
begin
  inherited;
  if mastersource1.ItemIndex <0 then exit;
  if mastertarget1.ItemIndex <0 then exit;
  mastersource2.Items.Add(mastersource1.Items[mastersource1.ItemIndex]);
  mastertarget2.Items.Add(mastertarget1.Items[mastertarget1.ItemIndex]);
end;

procedure Tfmtransactionmapper.Button2Click(Sender: TObject);
begin
  inherited;
  if Detailsource1.ItemIndex <0 then exit;
  if Detailtarget1.ItemIndex <0 then exit;
  Detailsource2.Items.Add(Detailsource1.Items[Detailsource1.ItemIndex]);
  Detailtarget2.Items.Add(Detailtarget1.Items[Detailtarget1.ItemIndex]);

end;
function Tfmtransactionmapper.MasterMappings:String;
var
  ctr:Integer;
begin
  result := '';
  if (mastersource2.Count =0) or (mastertarget2.Count <> mastersource2.Count) then exit;
  for ctr := 0 to mastersource2.Count-1 do begin
    if result <> '' then result := result +', ';
    result := result + mastersource2.Items[ctr] + '=' +masterTarget2.Items[ctr]
  end;
end;

function Tfmtransactionmapper.DetailMappings:String;
var
  ctr:Integer;
begin
  result := '';
  if (Detailsource2.Count =0) or (Detailtarget2.Count <> Detailsource2.Count) then exit;
  for ctr := 0 to Detailsource2.Count-1 do begin
    if result <> '' then result := result +', ';
    result := result + Detailsource2.Items[ctr] + '=' +DetailTarget2.Items[ctr]
  end;
end;
function Tfmtransactionmapper.FromTranType:String; begin result := QryTransactionmapperFromTranType.AsString; end;
function Tfmtransactionmapper.ToTranType:String; begin  result := QryTransactionmapperToTranType.AsString; end;
function Tfmtransactionmapper.ValidateData:boolean;
begin
  result := False;
  if combobox1.Text = '' then begin    MessageDlgXP_Vista('Please select table for the Master Source', mtWarning, [mbOK], 0);   SetControlfocus(combobox1); exit;  end;
  if combobox2.Text = '' then begin    MessageDlgXP_Vista('Please select table for the Master Target', mtWarning, [mbOK], 0);   SetControlfocus(combobox2); exit;  end;
  if combobox3.Text = '' then begin    MessageDlgXP_Vista('Please select table for the Detail Source', mtWarning, [mbOK], 0);   SetControlfocus(combobox3); exit;  end;
  if combobox4.Text = '' then begin    MessageDlgXP_Vista('Please select table for the Detail Target', mtWarning, [mbOK], 0);   SetControlfocus(combobox4); exit;  end;
  result := Validateit(mastersource1 ,mastersource2); if not result then exit;
  result := Validateit(Detailsource1 ,Detailsource2);
end;

function Tfmtransactionmapper.ValidateIt(full, selection :TListbox):boolean;
var
  ctr:Integer;
begin
  for ctr:= 0 to Selection.Count-1 do begin
    if Full.Items.IndexOf(selection.Items[ctr])<0 then begin
      REsult := False;
      MessageDlgXP_Vista('selected field :' + Quotedstr(selection.Items[ctr]) +' not found', mtWarning, [mbOK], 0);
      SetControlfocus(Selection);
      selection.Itemindex:= ctr;
      exit;
    end;
  end;
  REsult := TRue;
end;

procedure Tfmtransactionmapper.Button3Click(Sender: TObject);
var
  s:String;
begin
  inherited;
  s:= 'update      tblTransactionmapper  set MasterMappings = ' +quotedstr(MasterMappings) +', DetailMappings = ' +Quotedstr(DetailMappings) +' where FromTranType =' +Quotedstr(FromTranType) +' and ToTranType = ' +quotedstr(ToTranType) +';';
  Clipboard.asText := s;
  MessageDlgXP_Vista(s, mtInformation, [mbOK], 0);
end;

procedure Tfmtransactionmapper.Button4Click(Sender: TObject);
begin
  inherited;
  if ValidateData then
    MessageDlgXP_Vista('Fields are Valid', mtInformation, [mbOK], 0);
end;

procedure Tfmtransactionmapper.tabelselected(Sender: TObject);
begin
  inherited;
  if TCombobox(Sender).text = '' then exit;
  if sender = ComboBox1 then   ListFields(TCombobox(Sender).text, mastersource1);
  if sender = ComboBox2 then   ListFields(TCombobox(Sender).text, mastertarget1);
  if sender = ComboBox3 then   ListFields(TCombobox(Sender).text, detailsource1);
  if sender = ComboBox4 then   ListFields(TCombobox(Sender).text, DetailTarget1);
end;

procedure Tfmtransactionmapper.FormShow(Sender: TObject);
begin
  inherited;
  ComboBox1.Items.Clear;
  ComboBox2.Items.Clear;
  ComboBox3.Items.Clear;
  ComboBox4.Items.Clear;

  OPENDB(QryTransactionmapper);
  With TempMyQuery do try
    SQL.Add('show tables');
    open;
    if recordcount =0 then exit;
    first;
    while Eof = False do begin
      if sametext(copy(Fields[0].AsString ,1 ,3) , 'tbl') then begin
        ComboBox1.Items.Add(Fields[0].AsString);
        ComboBox2.Items.Add(Fields[0].AsString);
        ComboBox3.Items.Add(Fields[0].AsString);
        ComboBox4.Items.Add(Fields[0].AsString);
      end;
      Next;
    end;
  finally
    ClosenFree;
  end;
end;

procedure Tfmtransactionmapper.makelist(value:String; Sourcefields:TStringlist;Targetfields:TStringlist);
var
  st:TStringlist;
  ctr:Integer;
begin
  Sourcefields.Clear;
  TargetFields.Clear;
  st:= tstringlist.Create;
  try
    st.commatext := Value;
    for ctr := 0 to st.Count - 1 do begin
      Targetfields.Add(ExtractStrPortion(st.Strings[ctr], '=', 2));
      Sourcefields.Add(st.Names[ctr]);
    end;
  finally
    Freeandnil(st);
  end;
  Selecttable(QryTransactionmapperFromTranType.asString, Combobox1, True);
  Selecttable(QryTransactionmapperFromTranType.asString, Combobox3, False);
  Selecttable(QryTransactionmapperToTranType.asString, Combobox2, True);
  Selecttable(QryTransactionmapperToTranType.asString, Combobox4, False);
end;
procedure Tfmtransactionmapper.Selecttable(Value:String; combo:TCombobox; ismaster:Boolean);
begin
  if ismaster then begin
           if Sametext(Value , 'Repairs')  then  Combo.text := 'tblrepairs'
      else if Sametext(Value , 'Quote')  then  Combo.text := 'tblsales'
      else if Sametext(Value , 'SalesOrder')  then  Combo.text := 'tblsales'
      else if Sametext(Value , 'Appointment')  then  Combo.text := 'tblAppointments'
      else if Sametext(Value , 'Repair Bill Customer')  then  Combo.text := 'tblRepairs'
  (*    else if Sametext(Value , 'PhoneSupportLog')  then  Combo.text := ''
      else if Sametext(Value , 'Func Booking')  then  Combo.text := ''*)
      else if Sametext(Value , 'Invoice')  then  Combo.text := 'tblsales'
      else if Sametext(Value , 'Invoice')  then  Combo.text := 'tblsales'
      else if Sametext(Value , 'SmartOrder')  then  Combo.text := 'tblsmartOrder'
      else if Sametext(Value , 'Repairs')  then  Combo.text := 'tblrepairs'
      else if Sametext(Value , 'SalesOrder')  then  Combo.text := 'tblsales'
      else exit;
  end else begin
           if Sametext(Value , 'Repairs')  then  Combo.text := 'tblrepairparts'
      else if Sametext(Value , 'Quote')  then  Combo.text := 'tblsaleslines'
      else if Sametext(Value , 'SalesOrder')  then  Combo.text := 'tblsaleslines'
      else if Sametext(Value , 'Appointment')  then  Combo.text := ''
      else if Sametext(Value , 'Repair Bill Customer')  then  Combo.text := 'tblRepairparts'
  (*    else if Sametext(Value , 'PhoneSupportLog')  then  Combo.text := ''
      else if Sametext(Value , 'Func Booking')  then  Combo.text := ''*)
      else if Sametext(Value , 'Invoice')  then  Combo.text := 'tblsaleslines'
      else if Sametext(Value , 'Invoice')  then  Combo.text := 'tblsaleslines'
      else if Sametext(Value , 'SmartOrder')  then  Combo.text := 'tblsmartOrderlines'
      else if Sametext(Value , 'Repairs')  then  Combo.text := 'tblrepairParts'
      else if Sametext(Value , 'SalesOrder')  then  Combo.text := 'tblsaleslines'
      else exit;
  end;
  tabelselected(combo);

end;
procedure Tfmtransactionmapper.RefreshDetails;
var
  s:String;
  st1 , st2:TStringlist;
  ctr:Integer;
begin
  mastersource1.Clear;
  mastertarget1.Clear;
  detailsource1.Clear;
  detailtarget1.Clear;
  Combobox1.text := '';
  Combobox2.text := '';
  Combobox3.text := '';
  Combobox4.text := '';


  s:= QryTransactionmapperMasterMappings.AsString;
  st1:= tstringlist.Create;
  st2:= tstringlist.Create;
  try
    makelist(s , st1, st2);
    mastersource2.Items.Clear;
    for ctr := 0 to st1.count-1 do mastersource2.Items.add(st1[ctr]);
    masterTarget2.Items.Clear;
    for ctr := 0 to st2.count-1 do masterTarget2.Items.add(st2[ctr]);
  finally
    Freeandnil(st1);
    Freeandnil(st2);
  end;


  s:= QryTransactionmapperdetailMappings.AsString;
  st1:= tstringlist.Create;
  st2:= tstringlist.Create;
  try
    makelist(s , st1, st2);
    detailsource2.Items.Clear;
    for ctr := 0 to st1.count-1 do detailsource2.Items.add(st1[ctr]);
    detailTarget2.Items.Clear;
    for ctr := 0 to st2.count-1 do detailTarget2.Items.add(st2[ctr]);
  finally
    Freeandnil(st1);
    Freeandnil(st2);
  end;
end;

procedure Tfmtransactionmapper.RemoveSelection(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  if not(Sender is Tlistbox) then exit;
       if sender = detailSource2 then i := detailSource2.ItemIndex
  else if sender = detailTarget2 then i := detailTarget2.ItemIndex
  else if sender = mastersource2 then i := mastersource2.ItemIndex
  else if sender = mastertarget2 then i := mastertarget2.ItemIndex
  else exit;
  if i<0 then exit;

 if (sender = detailSource2) or (sender = detailTarget2) then begin
  detailSource2.Items.Delete(i);
  detailTarget2.Items.Delete(i);
 end else begin
  MasterSource2.Items.Delete(i);
  MasterTarget2.Items.Delete(i);
 end;
end;

procedure Tfmtransactionmapper.wwDBGrid1DblClick(Sender: TObject);
begin
  inherited;
  RefreshDetails;

end;

initialization
  RegisterClassOnce(Tfmtransactionmapper);

end.

