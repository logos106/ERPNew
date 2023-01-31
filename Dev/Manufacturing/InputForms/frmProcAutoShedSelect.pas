unit frmProcAutoShedSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, DNMPanel, ComCtrls, AdvOfficeStatusBar, AdvListV,
  ProcCapacityPlanningObj, Menus, ActnList, SelectionDialog;

type
  TfmProcAutoShedSelect = class(TBaseForm)
    pnlBottom: TDNMPanel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lvItems: TAdvListView;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    PopupMenu: TPopupMenu;
    SelectAll1: TMenuItem;
    ClearAll1: TMenuItem;
    btnSelectAll: TDNMSpeedButton;
    btnClearAll: TDNMSpeedButton;
    ActionList: TActionList;
    actSelectAll: TAction;
    actClearAll: TAction;
    mnucol1: TPopupMenu;
    mnucol2: TPopupMenu;
    mnuCol3: TPopupMenu;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actClearAllExecute(Sender: TObject);
    procedure lvItemsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvItemsColumnRClick(Sender: TObject; Column: Integer);
    procedure lvItemsClick(Sender: TObject);
    procedure mnuCol3Popup(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    fItemList: TProcItemList;
    hascol1mnu, hascol2mnu, hascol3mnu: Boolean;
    procedure AddMenu(mnu: TPopupMenu; st: TStringList; menuindex: Integer);
    procedure selectOncolumnClick(Sender: TObject);
    procedure DoSelection(Selectcol: Integer; Select: String);
  public
    property ItemList: TProcItemList read fItemList write fItemList;
  end;

var
  fmProcAutoShedSelect: TfmProcAutoShedSelect;

implementation

uses CommonDbLib, ProductQtyLib, AppEnvironment, CommonLib;

{$R *.dfm}

procedure TfmProcAutoShedSelect.FormCreate(Sender: TObject);
begin
  inherited;
  hascol1mnu := False;
  hascol2mnu := False;
  hascol3mnu := False;
end;

procedure TfmProcAutoShedSelect.FormShow(Sender: TObject);
var
  x: Integer;
  Item: TListitem;
  s: String;
  St1, St2, St3: TStringList;
  s1, s2, s3: String;
begin
  lvItems.Columns[6].Caption := AppEnv.DefaultClass.FirstColumn;
  lvItems.Columns[7].Caption := AppEnv.DefaultClass.SecondColumn;
  lvItems.Columns[8].Caption := AppEnv.DefaultClass.ThirdColumn;

  (* mnucol1.Caption := AppEnv.DefaultClass.FirstColumn;
    mnucol2.Caption := AppEnv.DefaultClass.SecondColumn;
    mnucol3.Caption := AppEnv.DefaultClass.ThirdColumn; *)

  St1 := TStringList.Create;
  St2 := TStringList.Create;
  St3 := TStringList.Create;
  Self.Enabled := False;
  try
    St1.Sorted := True;
    St2.Sorted := True;
    St3.Sorted := True;

    St1.CaseSensitive := False;
    St2.CaseSensitive := False;
    St3.CaseSensitive := False;
    St1.Duplicates := dupIgnore;
    St2.Duplicates := dupIgnore;
    St3.Duplicates := dupIgnore;

    inherited;
    s := '';
    for x := 0 to ItemList.Count - 1 do
    begin
      if ItemList.Item[x].ProctreePartID > 0 then
      begin
        if s <> '' then
          s := s + ',';
        s := s + inttostr(ItemList.Item[x].ProctreePartID);
      end;
    end;
    if s = '' then
      s := '0';
    With tempMyquery do
      try
        SQL.Add('Select partsid, partname , ' + FirstColumn('P') + ' Col1 , ' +
          SecondColumn('P') + ' Col2 , ' + ThirdColumn('P') +
          ' Col3 from tblparts P where partsId in (' + s + ')');
        Open;
        for x := 0 to ItemList.Count - 1 do
        begin
          Item := lvItems.Items.Add;
          Item.data := ItemList[x];
          Item.Caption := ItemList[x].SaleDocNumber;
          Item.SubItems.Add(ItemList[x].SaleCustomerName);
          Item.SubItems.Add(ItemList[x].SaleLineProductName);
          Item.SubItems.Add(FormatDateTime('dd/mm/yyyy',
            ItemList[x].SaleLineShipDate));
          Item.SubItems.Add(ItemList[x].ProcTreeCaption);
          Item.SubItems.Add(ItemList[x].ProcessDesc);
          s1 := '';
          s2 := '';
          s3 := '';
          if ItemList.Item[x].ProctreePartID > 0 then
          begin
            if Locate('PartsId', ItemList.Item[x].ProctreePartID, []) then
            begin
              s1 := FieldByname('Col1').AsString;
              s2 := FieldByname('Col2').AsString;
              s3 := FieldByname('Col3').AsString;
            end;
          end;
          Item.SubItems.Add(s1);
          Item.SubItems.Add(s2);
          Item.SubItems.Add(s3);
          if s1 <> '' then
            St1.Add(s1);
          if s2 <> '' then
            St2.Add(s2);
          if s3 <> '' then
            St3.Add(s3);

          Item.Checked := True;
        end;
      finally
        ClosenFree;
      end;
    AddMenu(mnucol1, St1, 1);
    AddMenu(mnucol2, St2, 2);
    AddMenu(mnuCol3, St3, 3);
    hascol1mnu := St1.Count > 0;
    hascol2mnu := St2.Count > 0;
    hascol3mnu := St3.Count > 0;
  finally
    Self.Enabled := True;
    Freeandnil(St1);
    Freeandnil(St2);
    Freeandnil(St3);
  end;
end;

procedure TfmProcAutoShedSelect.AddMenu(mnu: TPopupMenu; st: TStringList;
  menuindex: Integer);
var
  x: Integer;
  m: TMenuItem;
begin
  mnu.Items.Clear;
  if st.Count =0 then exit;
    m := TMenuItem.Create(Self);
    m.Caption :=   'Select All of ' + quotedstr(lvItems.Columns[5+menuindex].Caption);
    m.name := mnu.name + 'menutitle' ;
    m.OnClick := nil;
    mnu.Items.Add(m);
  for x := 0 to st.Count - 1 do
  begin
    m := TMenuItem.Create(Self);
    m.Caption :=  '   ' +st[x];
    m.name := mnu.name + 'mm' + inttostr(x);
    m.OnClick := selectOncolumnClick;
    m.Tag := menuindex;
    mnu.Items.Add(m);
  end;
end;

procedure TfmProcAutoShedSelect.selectOncolumnClick(Sender: TObject);
begin
  if not(Sender is TMenuItem) then exit;
  DoSelection(TMenuItem(Sender).Tag, TMenuItem(Sender).Caption);
end;

procedure TfmProcAutoShedSelect.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
    MessageDlgXP_Vista('''Right mouse click'' on grid column label to apply a ''Select Filter'' based on the column and ''Right mouse click'' in the grid to Clear all Selection', mtInformation, [mbOK], 0);
  end;

procedure TfmProcAutoShedSelect.DoSelection(Selectcol: Integer; Select: String);
var
  x: Integer;
  Item: TListitem;
begin
  lvItems.PopupMenu := PopupMenu;
  if (Selectcol < 1) or (Selectcol > 3) then
    exit;
  if Select = '' then
    exit;
  for x := 0 to lvItems.Items.Count - 1 do
    lvItems.Items[x].Checked := False;
  for x := 0 to lvItems.Items.Count - 1 do
  begin
    Item := lvItems.Items[x];
    if Sametext(Item.SubItems[4 + Selectcol],trim(replacestr(Select, '&', ''))) then
      lvItems.Items[x].Checked := True;
  end;
end;

procedure TfmProcAutoShedSelect.lvItemsClick(Sender: TObject);
begin
  inherited;
  lvItems.PopupMenu := PopupMenu;
end;

procedure TfmProcAutoShedSelect.lvItemsColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  inherited;
  lvItems.SortColumn := Column.Index;
end;

procedure TfmProcAutoShedSelect.lvItemsColumnRClick(Sender: TObject;
  Column: Integer);
(* var
  pt:TPoint;
  begin
  inherited;
  getcursorpos(pt);
  if column = 6 then mnucol1.Popup(pt.X,pt.Y)
  else if column = 7 then mnucol2.Popup(pt.X,pt.Y)
  else if column = 9 then mnucol3.Popup(pt.X,pt.Y); *)
begin
  if (Column = 6) and (hascol1mnu) then
    lvItems.PopupMenu := mnucol1
  else if (Column = 7) and (hascol2mnu) then
    lvItems.PopupMenu := mnucol2
  else if (Column = 8) and (hascol3mnu) then
    lvItems.PopupMenu := mnuCol3
  else
    lvItems.PopupMenu := PopupMenu;
end;

procedure TfmProcAutoShedSelect.mnuCol3Popup(Sender: TObject);
begin
  inherited;
  lvItems.PopupMenu := PopupMenu;
end;

procedure TfmProcAutoShedSelect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //
end;

procedure TfmProcAutoShedSelect.FormDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TfmProcAutoShedSelect.btnOkClick(Sender: TObject);
var
  x,y: Integer;
  function locateinItemIst:Integer;
  var
    fi:Integer;
  begin
    result:= -1;
    for fi := 0 to  ItemList.Count-1 do
      if itemlist[fi].ProcessPartId = TProcItem(lvItems.Items[x].Data).ProcessPartId then begin
        Result := fi;
        break;
      end;
  end;
begin
  inherited;
    for x := 0 to lvItems.Items.Count - 1 do begin
      if lvItems.Items[x].Checked then begin
        y:= locateinItemIst;
        if y>=0 then ItemList.SelectedList.Add(y);
      end;
    end;
  ModalResult := mrOk;
end;

procedure TfmProcAutoShedSelect.actSelectAllExecute(Sender: TObject);
var
  x: Integer;
begin
  inherited;
  for x := 0 to lvItems.Items.Count - 1 do
    lvItems.Items[x].Checked := True;
end;

procedure TfmProcAutoShedSelect.actClearAllExecute(Sender: TObject);
var
  x: Integer;
begin
  inherited;
  for x := 0 to lvItems.Items.Count - 1 do
    lvItems.Items[x].Checked := False;
end;

end.
