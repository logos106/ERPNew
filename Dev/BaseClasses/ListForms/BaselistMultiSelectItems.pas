unit BaselistMultiSelectItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, jpeg;

type
  TSelctedItemsList = record
    ItemID:Integer;
    ItemName:String;
    Deleted :Boolean;
  end;

  TBaselistMultiSelectItemsGUI = class(TBaseListingGUI)
    qryMainName: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainID: TLargeintField;
    DNMPanel1: TDNMPanel;
    chksortList: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure grdMainBeforePaint(Sender: TObject);Override;
    procedure chksortListClick(Sender: TObject);
  private
    SelctedItemsList : Array of TSelctedItemsList;
    fsNameFieldName: String;
    fsIDFieldName: String;
    fiNamedisplayWidth :Integer;
    Function FindItem(const ID:Integer ; Name:String):Integer;
    procedure RemoveItem(const ID:Integer ;Name:String);
    procedure SetIDFieldName(const Value: String);
    procedure SetNameFieldName(const Value: String);
    function getNamedisplayWidth: Integer;

  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure SetupFormInPanel; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure AddItem(const ID:Integer ; Name:String);
    Procedure RefreshQuery;Override;
    Property IDFieldName:String read fsIDFieldName write SetIDFieldName;
    Property NameFieldName:String read fsNameFieldName write SetNameFieldName;
    Property NamedisplayWidth :Integer read getNamedisplayWidth write fiNamedisplayWidth;
    procedure RefreshOrignalSQL(Addlimit0:Boolean =true);Override;
    Procedure DeleteAll;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses CommonDbLib, tcConst, CommonLib, SystemLib, LogLib;

{$R *.dfm}

{ TBaselistMultiSelectItemsGUI }

procedure TBaselistMultiSelectItemsGUI.AddItem(const ID: Integer; Name: String);
var
  i:Integer;
begin
    try
      i:= FindItem(ID,Name);
      if i <0 then begin
        Closedb(Qrymain);
          setLength(SelctedItemsList, length(SelctedItemsList)+1);
          SelctedItemsList[high(SelctedItemsList)].ItemId := ID;
          SelctedItemsList[high(SelctedItemsList)].ItemName := Name;
          SelctedItemsList[high(SelctedItemsList)].Deleted:= False;
      end else begin
        SelctedItemsList[i].Deleted:= False;
      end;
    finally
      try
        RefreshQuery;
      Except
      end;
    end;
end;

procedure TBaselistMultiSelectItemsGUI.chksortListClick(Sender: TObject);
begin
  inherited;
  if Screen.activecontrol =chksortList then RefreshQuery;
end;

constructor TBaselistMultiSelectItemsGUI.Create(AOwner: TComponent);
begin
  inherited;
  fbForceWaterMark := True;
end;

procedure TBaselistMultiSelectItemsGUI.DeleteAll;
begin
  grdMain.selectAll;
  IterateProcno := 1;
  IterateSelectedRecords;
  RefreshQuery;
end;

function TBaselistMultiSelectItemsGUI.FindItem(const ID: Integer;  Name: String): Integer;
var
  ctr:Integer;
begin
  result :=-1;
  for ctr:= low(SelctedItemsList) to high(SelctedItemsList) do begin
          if (Id = SelctedItemsList[ctr].ItemId) and
             (Sametext(Name, SelctedItemsList[ctr].ItemName)) then begin
               REsult := ctr;
               Exit;
  end;

  end;

end;

procedure TBaselistMultiSelectItemsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SearchMode:= smFullList;
  NonSearchReport := True;
  fsNameFieldName:= '';
  fsIDFieldName:= '';
  setlength(SelctedItemsList,0);
  AddItem(0,'');
  FooterPanel.visible := False;
  HeaderPanel.visible := False;
  lblTimerMsg.visible := False;
  lblDateComments.visible := False;
  FilterLabel.visible := False;
  pnlMultiSelectList.visible := False;
  splMultiSelectList.visible := False;
  HaveDateRangeSelection := False;
end;

procedure TBaselistMultiSelectItemsGUI.FormShow(Sender: TObject);
begin
  inherited;
  EnableMultiSelect(''); // always enabled as its used for selection
  ShowWaterMark(imgGridWatermark);
end;

function TBaselistMultiSelectItemsGUI.getNamedisplayWidth: Integer;
begin
  result := qryMainName.displaywidth;
end;

procedure TBaselistMultiSelectItemsGUI.grdMainBeforePaint(Sender: TObject);
begin
  inherited;
  fbForceWaterMark := False;
end;

procedure TBaselistMultiSelectItemsGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  if Qrymainid.asInteger <> 0 then
    if MessageDlgXP_vista('Do You Want to Unselect '+quotedstr(Qrymainname.asString)+'?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      RemoveItem(QrymainID.asInteger , QrymainName.asString);
      RefreshQuery;
    end;


end;

procedure TBaselistMultiSelectItemsGUI.grdMainKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl] ) and (Key = VK_RETURN)  then begin
    grdMainDblClick(grdmain);
  end;
end;


procedure TBaselistMultiSelectItemsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainName.displaywidth := fiNamedisplayWidth;
end;

procedure TBaselistMultiSelectItemsGUI.RefreshOrignalSQL(Addlimit0: Boolean);
begin
//  inherited;
end;

procedure TBaselistMultiSelectItemsGUI.RefreshQuery;
var
  ctr:Integer;
  s:String;
begin
  Closedb(qrymain);
  try
    qrymain.SQL.clear;
    for ctr:= low(SelctedItemsList) to high(SelctedItemsList) do begin
      s:= ' Select '+
          ' convert(' + inttostr(SelctedItemsList[ctr].ItemId)+', Signed INTEGER) as  ID,'+
          Quotedstr(SelctedItemsList[ctr].ItemName)+' as Name, '+
          iif(   fsIDFieldName <> '' , 'convert('+inttostr(SelctedItemsList[ctr].ItemID)+', Signed INTEGER) as '+ fsIDFieldName +',','')+
          iif(   fsNameFieldName <> '' , Quotedstr(SelctedItemsList[ctr].ItemName)+' as '+ fsNameFieldName +',','')+
          Quotedstr(Booleantostr(SelctedItemsList[ctr].Deleted))+' as Deleted '+
          ' FROM DUAL';
      if qrymain.SQL.count >0 then qrymain.SQL.Add(' UNION ALL ');
      qrymain.SQL.add(s);
    end;

    qrymain.SQL.TExt := 'Select convert(Id, Signed INTEGER) as ID, name , ' +
                       iif(   fsIDFieldName <> '' ,' convert(' + fsIDFieldName +', Signed INTEGER) as ' + fsIDFieldName +',' , '')+
                        iif(   fsNameFieldName <> '' , fsNameFieldName +',' , '')+
                        'Deleted '+
                    ' from (' + qrymain.SQL.text +') as Details Having ID <> 0 and Deleted ="F" ';

    if chksortList.checked then
      qrymain.SQL.Add('Order by Name');
    //RefreshOrignalSQL(False);
  finally
    inherited;
  end;


end;

procedure TBaselistMultiSelectItemsGUI.RemoveItem(const ID: Integer;Name:String);
var
  i:Integer;
begin
  i:= findItem(ID,name);
  if i>=0 then
    SelctedItemsList[i].Deleted:= True;
end;

procedure TBaselistMultiSelectItemsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ID');
  RemoveFieldfromGrid('Deleted');
  RemoveFieldfromGrid(fsIDFieldName);
  RemoveFieldfromGrid(fsNameFieldName);
end;

procedure TBaselistMultiSelectItemsGUI.SetIDFieldName(const Value: String);
var
 fldID : TLargeintField;
begin
  fsIDFieldName := Value;
  try
  if Value <> '' then
    if Qrymain.findfield(fsIDFieldName) = nil then begin
      if Qrymain.active then Qrymain.close;
      fldID           := TLargeintField.Create(Qrymain.Owner);
      fldID.FieldKind := fkData;
      fldID.FieldName := fsIDFieldName;
      fldID.Lookup    := False;
      fldID.Name      := Qrymain.name + fsIDFieldName;
      fldID.dataset   := Qrymain;
    end;
  except
  end;
end;

procedure TBaselistMultiSelectItemsGUI.SetNameFieldName(const Value: String);
var
 fldName : TWideStringField;
begin
  fsNameFieldName := Value;
  try
  if Value <> '' then
    if Qrymain.findfield(fsNameFieldName) = nil then begin
      if Qrymain.active then Qrymain.close;
      fldName           := TWideStringField.Create(Qrymain.Owner);
      fldName.FieldKind := fkData;
      fldName.FieldName := fsNameFieldName;
      fldName.Lookup    := False;
      fldName.Name      := Qrymain.name + fsNameFieldName;
      fldName.dataset   := Qrymain;
    end;
  except
  end;
end;
procedure TBaselistMultiSelectItemsGUI.SetupFormInPanel;
begin
//  inherited;

end;

procedure TBaselistMultiSelectItemsGUI.IterateselectedRecordsCallback(  var Abort: boolean; SelIndex: Integer);
begin
  if IterateProcno = 1 then begin
    RemoveItem(QrymainID.asInteger , QrymainName.asString);
    Exit;
  end;
  inherited;
end;

procedure TBaselistMultiSelectItemsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
end;
procedure TBaselistMultiSelectItemsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.SortList'].AsBoolean := chksortList.checked ;
end;

end.
