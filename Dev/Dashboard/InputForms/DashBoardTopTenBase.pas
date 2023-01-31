unit DashBoardTopTenBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardBase, ExtCtrls, DNMPanel, StdCtrls, DB, MemDS,
  DBAccess, MyAccess,ERPdbComponents, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton,ListChartView,
  AdvPageControl, ComCtrls, ToolWin, Menus, SelectionDialog, wwradiogroup,
  wwclearbuttongroup;

type
  TDashBoardTopTenBaseGUI = class(TDashBoardBaseGUI)
    Qrymain: TERPQuery;
    pnltop: TDNMPanel;
    grpFilters: TwwRadioGroup;
    grpView: TwwRadioGroup;
    pnldata: TDNMPanel;
    lblProductname: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    pr1: TLabel;
    q1: TLabel;
    p1: TLabel;
    m1: TLabel;
    pr2: TLabel;
    q2: TLabel;
    p2: TLabel;
    m2: TLabel;
    pr4: TLabel;
    q4: TLabel;
    p4: TLabel;
    m4: TLabel;
    pr3: TLabel;
    q3: TLabel;
    p3: TLabel;
    m3: TLabel;
    pr8: TLabel;
    q8: TLabel;
    p8: TLabel;
    m8: TLabel;
    pr7: TLabel;
    q7: TLabel;
    p7: TLabel;
    m7: TLabel;
    pr6: TLabel;
    pr5: TLabel;
    q5: TLabel;
    q6: TLabel;
    p6: TLabel;
    p5: TLabel;
    m5: TLabel;
    m6: TLabel;
    pr9: TLabel;
    pr10: TLabel;
    q10: TLabel;
    q9: TLabel;
    p10: TLabel;
    p9: TLabel;
    m10: TLabel;
    m9: TLabel;
    pnlGraph: TDNMPanel;
    MyConnection: TERPConnection;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure grpFiltersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grpViewClick(Sender: TObject);
    Procedure RefreshGraph;
    procedure QrymainAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    Graphform      : TListChartView;
    Labels :Array [1..10] of array [1..4] of TLabel ;
    Procedure RefreshData;
    procedure hideall;
  Protected
    SaleIDs:String;
    function datefrom: String;
    function DAteTo: String;
    function GetSQL:String; virtual;abstract;
    function dtdatefrom :TDateTime;
    Function dtDAteTo:TDateTime;
  public
    Procedure RefreshQuery; override;
  end;

implementation

uses CommonLib, CommonDbLib, ProductQtyLib, FastFuncs,  MessageInterface,
  tcConst, salesAnalysisLib, AppEnvironment, MySQLConst;

{$R *.dfm}

{ TMainSwitchTopTenProductsGUI }
function TDashBoardTopTenBaseGUI.datefrom: String;
begin
  if ((DtFrom = 0) and (fbignoreDates =false)) then result := startDate
  else result := Quotedstr(formatDateTime(mySQLDateTimeformat, dtFrom));
end;

function TDashBoardTopTenBaseGUI.DAteTo: String;
begin
  if dtTo = 0 then result := enddate
  else result := Quotedstr(formatDateTime(mySQLDateTimeformat, dtTo));
end;

procedure TDashBoardTopTenBaseGUI.RefreshQuery;
begin
  grpView.itemindex := 1;
  RefreshData;
  grpView.itemindex := 0;
  inherited;
end;

procedure TDashBoardTopTenBaseGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
    RefreshData;
    if  grpView.itemindex = 0 then RefreshGraph;
end;

procedure TDashBoardTopTenBaseGUI.FormCreate(Sender: TObject);
var
  ctr:Integer;
  R, b, g :Byte;
begin
  inherited;

  MyConnection.Server := CommonDbLib.GetSharedMyDacConnection.Server;
  MyConnection.Username := CommonDbLib.GetSharedMyDacConnection.Username;
  MyConnection.Password := CommonDbLib.GetSharedMyDacConnection.Password;
  MyConnection.Database := CommonDbLib.GetSharedMyDacConnection.Database;
  MyConnection.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
  MyConnection.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;

  Graphform := nil;
  for ctr := 1 to 10 do
    Labels[ctr, 1] := TLabel(findcomponent('Pr' + Trim(IntToStr(ctr))));

  for ctr := 1 to 10 do
    Labels[ctr, 2] := TLabel(findcomponent('q' + Trim(IntToStr(ctr))));

  for ctr := 1 to 10 do
    Labels[ctr, 3] := TLabel(findcomponent('P' + Trim(IntToStr(ctr))));

  for ctr := 1 to 10 do
    Labels[ctr, 4] := TLabel(findcomponent('M' + Trim(IntToStr(ctr))));

  (*r:= GetRValue(Labels[1, 1].font.Color);*)
(*  b:= GetBValue(Labels[1, 1].font.Color);
  g:= GetGValue(Labels[1, 1].font.Color);
  r:= 155;*)
  r:= 255;  G:= 1;  B:= 1; // maroon
  for ctr := 1 to 10 do begin
      Labels[ctr, 1].font.color := RGB(R-ctr*20 ,  G, B);
      Labels[ctr, 2].font.color := RGB(R-ctr*20 ,  G, B);
      Labels[ctr, 3].font.color := RGB(R-ctr*20 ,  G, B);
      Labels[ctr, 4].font.color := RGB(R-ctr*20 ,  G, B);
      Labels[ctr, 1].Visible    := False;
      Labels[ctr, 2].Visible    := False;
      Labels[ctr, 3].Visible    := False;
      Labels[ctr, 4].Visible    := False;
  end;
end;

procedure TDashBoardTopTenBaseGUI.grpViewClick(Sender: TObject);
begin
  inherited;
  if  grpView.itemindex = 1 then RefreshData
  else RefreshGraph;
end;

procedure TDashBoardTopTenBaseGUI.RefreshGraph;
var
  
  chartName : String;
  (*str       : String;*)
 (* DummyObj  : TDNMSpeedButton ;*)
begin
  pnldata.visible := False;
  pnlGraph.visible := True;
       if grpFilters.Itemindex = 0 then chartname := 'Price'
  else if grpFilters.Itemindex = 1 then chartname := 'Margin'
  else if grpFilters.Itemindex = 2 then chartname := 'Quantity'
  else exit;
  if Graphform = nil then
    Graphform := TListChartView(GetComponentByClassName('TListChartView', true, Self));
  Graphform.ShowChartView(Qrymain, chartName, pnlGraph, 'DashboardGraphs');
end;
procedure TDashBoardTopTenBaseGUI.hideall;
var
  ctr:Integer;
begin
  for ctr := low(labels) to high(Labels) do begin
      Labels[ctr , 1].Visible := False;
      Labels[ctr , 2].Visible := False;
      Labels[ctr , 3].Visible := False;
      Labels[ctr , 4].Visible := False;
  end;
end;
procedure TDashBoardTopTenBaseGUI.RefreshData;
begin
  pnldata.visible := true;
  pnlGraph.visible := False;
  With Qrymain do begin
    (*connection := CommonDbLib.GetSharedMyDacConnection;*)
    if active then close;
    SQL.Clear;
    SQL.add(GetSQL);
    open;
    hideall;
    if recordcount = 0 then exit;
    First;
    SeqNo := 1;
    while (Eof = False) and (Seqno <10) do begin
      Seqno:= recno;
      if findfield('Detailname')      <> nil then Labels[seqno , 1].Caption := Fieldbyname('DetailName').AsString;
      if findfield('Quantity')  <> nil then Labels[seqno , 2].Caption := Fieldbyname('Quantity').AsString ;
      if findfield('Price')     <> nil then Labels[seqno , 3].Caption := AsCurrency(Fieldbyname('Price').asFloat);
      if findfield('Margin')    <> nil then Labels[seqno , 4].Caption := AsCurrency(Fieldbyname('Margin').asFloat);
      Labels[seqno , 1].Visible := findfield('DetailName')      <> nil;
      Labels[seqno , 2].Visible := findfield('Quantity')  <> nil;
      Labels[seqno , 3].Visible := findfield('Price')     <> nil;
      Labels[seqno , 4].Visible := findfield('margin')    <> nil;
      Next;
    end;
  end;
end;

procedure TDashBoardTopTenBaseGUI.QrymainAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  case grpFilters.ItemIndex of
    0: Qrymain.IndexFieldNames:=  ' Price desc ';
    1: Qrymain.IndexFieldNames:=  ' margin desc';
    2: Qrymain.IndexFieldNames:=  ' Quantity desc';
  end;
end;

procedure TDashBoardTopTenBaseGUI.FormShow(Sender: TObject);
begin
  inherited;
  MyConnection.Open;
end;
function TDashBoardTopTenBaseGUI.dtdatefrom: TDateTime;
begin
  if (DtFrom = 0) and (fbignoreDates=false) then result := AppEnv.CompanyPrefs.ClosingDate
  else result := dtFrom;
end;

function TDashBoardTopTenBaseGUI.dtDAteTo: TDateTime;
begin
  if dtTo = 0 then result := Date
  else result := dtTo;
end;

initialization
  RegisterClassOnce(TDashBoardTopTenBaseGUI);
end.



