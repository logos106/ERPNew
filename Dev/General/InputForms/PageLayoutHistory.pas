unit PageLayoutHistory;

interface

uses
  Windows, Types, Messages, SysUtils, Variants, Classes, Graphics, Controls, Contnrs, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, CheckLst, DNMSpeedButton, PageLayoutModifier;

type
  TLayoutHistoryGUI = class(TBaseInputGUI)
    cbHistory: TCheckListBox;
    lblPageName: TLabel;
    Image1: TImage;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryHistory: TERPQuery;
    cbIndustry: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure cbHistoryClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbHistoryClickCheck(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    fPageName: string;
    fModList: TObjectList;
    fSelectedId: integer;
    procedure SetPageName(const Value: string);
    { Private declarations }
  protected
    procedure LoadHistory;
    procedure PreviewItem(AItem : TPageModifier);
    property ModList : TObjectList read fModList write fModList;
  public
    { Public declarations }
    property PageName : string read fPageName write SetPageName;
    property SelectedId : integer read fSelectedId;
  end;

implementation

{$R *.dfm}
uses
  MySQLConst, AppEnvironment, CommonLib;

procedure TLayoutHistoryGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TLayoutHistoryGUI.btnOkClick(Sender: TObject);
var
  idx : integer;
  scr : TERPScript;

  function ActiveValue(k : integer) : string;
  begin
    if cbHistory.Checked[k] then
      Result := '"T"'
    else
      Result := '"F"';
  end;
begin
  inherited;
    if cbHistory.Items.Count = 0 then
    begin
      ModalResult := mrOk;
      exit;
    end;

    fSelectedId := -1;
    for idx := 0 to cbHistory.Items.Count - 1 do
      if cbHistory.Checked[idx] then
      begin
        fSelectedId := TPageModifier(cbHistory.Items.Objects[idx]).Id;
        Break;
      end;
    if SelectedId = -1 then
    begin
      MessageDlgXP_Vista('You Need To Select The Layout To Be Used', mtWarning, [mbOk], 0);
      exit;
    end;

    scr := TERPScript.Create(nil);
    try
      scr.Connection := MyConnection;

      for idx := 0 to  cbHistory.Items.Count - 1 do
      begin
        scr.SQL.Add('update tblPageLayout set Active = ' + ActiveValue(idx) + ' where id=' + intToStr(TPageModifier(cbHistory.Items.Objects[idx]).id) + ';');
      end;
      if scr.SQL.Count > 0 then
        scr.Execute;
    finally
      scr.Free;
    end;
    ModalResult := mrOk;

end;

procedure TLayoutHistoryGUI.cbHistoryClick(Sender: TObject);
var
  idx : integer;
begin
  for idx := 0 to cbHistory.Items.Count - 1 do
    if cbHistory.Selected[idx] then
      PreviewItem(TPageModifier(cbHistory.Items.Objects[idx]));

end;

procedure TLayoutHistoryGUI.cbHistoryClickCheck(Sender: TObject);
var
  idx : integer;
begin
  if cbHistory.Checked[cbHistory.ItemIndex] then
    for idx := 0 to cbHistory.Items.Count - 1 do
      if idx <> cbHistory.ItemIndex then
        cbHistory.Checked[idx] := false;
end;

procedure TLayoutHistoryGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ModList := TObjectList.Create(true);
end;

procedure TLayoutHistoryGUI.FormDestroy(Sender: TObject);
begin
  ModList.Free;
  inherited;
end;

procedure TLayoutHistoryGUI.FormShow(Sender: TObject);
begin
  inherited;
  LoadHistory;

end;

procedure TLayoutHistoryGUI.LoadHistory;
var
  pm : TPageModifier;
  idx : integer;
begin
  qryHistory.Close;
  if PageName = '' then
    exit;
  cbHistory.Clear;
  (*
  qryHistory.SQL.Text := 'select Id, P.msTimeStamp from tblPageLayout P';
  qryHistory.SQL.Add('inner join tblIndustries I on I.IndustryId=P.IndustryId)
  where PageName="' + PageName +
      '" and UserId=' + IntToStr(AppEnv.Employee.EmployeeID) + ' group by id order by msTimeStamp desc';
  *)
  qryHistory.SQL.Text := 'Select Id, msTimeStamp, IndustryId from tblPageLayout';
  qryHistory.sql.add('  where PageName="' + PageName +
      '" and UserId=' + IntToStr(AppEnv.Employee.EmployeeID));
  if not cbIndustry.Checked then
    qryHistory.SQL.Add('and IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId));
  qryHistory.sql.add('group by id order by msTimeStamp desc');
  qryHistory.Open;
  while not qryHistory.eof do
  begin
    pm := TPageModifier.Create(ModList);
    pm.Id := qryHistory.Fields[0].AsInteger;
    pm.Load(PageName, qryHistory.FieldByName('IndustryId').asINteger);
    ModList.Add(pm);
    cbHistory.Items.AddObject(FormatDateTime(MySqlDateFormat, pm.TimeStamp) + ' ' + FormatDateTime(MySQLTimeFormat, pm.TimeSTamp), pm);
    cbHistory.Checked[cbHistory.Items.Count - 1] := pm.Active;
    qryHistory.Next;
  end;

  if cbHistory.Items.Count = 0 then
    exit;

  for idx := 0 to cbHistory.Items.Count - 1 do
    if cbHistory.Checked[idx] then
    begin
      PreviewItem(TPageModifier(cbHistory.Items.Objects[idx]));
      exit;
    end;

  cbHistory.ItemIndex := 0;
  PreviewItem(TPageModifier(cbHistory.Items.Objects[0]));

end;

procedure TLayoutHistoryGUI.PreviewItem(AItem: TPageModifier);
const
 wPanel = 786;
 hPanel = 630;
var
  xR,
  yR : extended;
  idx : integer;
//  r : TRect;
  d : TPageItemDesc;
  pts : array [0..3] of TPoint;
begin
  Image1.Canvas.Brush.Color := clWhite;
  Image1.Canvas.FillRect(Image1.Canvas.ClipRect);
  xr := Image1.Width / wPanel;
  yr := Image1.Height / hPanel;
  Image1.Canvas.Brush.Color := clGray;
  Image1.Canvas.Pen.Color := clBlack;

  for idx := 0 to AItem.Count - 1 do
  begin
    d := AItem.Items[idx];
    if d.NodeType = mtButton then
    begin
      pts[0] := Point(Trunc(d.Left * xR), Trunc(d.Top * yr));
      pts[1] := Point(Trunc((d.Left + d.Width) * xR), Trunc(d.Top * yr));
      pts[2] := Point(Trunc((d.Left + d.Width)* xR), Trunc((d.Top + d.Height) * yr));
      pts[3] := Point(Trunc(d.Left * xR), Trunc((d.Top+d.Height) * yr));
      Image1.Canvas.Polygon(pts);
    end
    else
    begin
      Image1.Canvas.MoveTo(Trunc(d.Left * xR), Trunc(d.Top * yr));
      Image1.Canvas.LineTo(Trunc(d.Width  * xR), Trunc(d.Height * yr));
    end;
  end;
end;

procedure TLayoutHistoryGUI.SetPageName(const Value: string);
begin
  fPageName := Value;
  lblPageName.Caption := Value;
  lblPageName.Left := ((ClientRect.Right - ClientRect.Left) - lblPageName.Canvas.TextWidth(Value) + 8) div 2;
  LoadHistory;
end;

end.
