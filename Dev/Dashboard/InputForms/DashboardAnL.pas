unit DashboardAnL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardBase, ExtCtrls, DNMPanel, busobjbase, StdCtrls, DB,
  MemDS, DBAccess, MyAccess,ERPdbComponents, ComCtrls, BaseFormForm, DNMSpeedButton, Menus,
  SelectionDialog;

type
  TDashBoardAnLGUI = class(TDashBoardBaseGUI)
    PageControl: TPageControl;
    pgAsset: TTabSheet;
    pnlAsset: TDNMPanel;
    Asset2: TBevel;
    Asset1: TBevel;
    des1: TLabel;
    des2: TLabel;
    ex5: TLabel;
    ex2: TLabel;
    ex1: TLabel;
    baGross: TLabel;
    vaGross: TLabel;
    des3: TLabel;
    ex3: TLabel;
    des4: TLabel;
    ex4: TLabel;
    lblTotal: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    des5: TLabel;
    Bevel1: TBevel;
    TabSheet1: TTabSheet;
    pnlLiab: TDNMPanel;
    Liab1: TBevel;
    Liab2: TBevel;
    Bevel5: TBevel;
    des6: TLabel;
    ex9: TLabel;
    ex6: TLabel;
    bgross: TLabel;
    vgross: TLabel;
    des8: TLabel;
    ex8: TLabel;
    des7: TLabel;
    ex7: TLabel;
    Label17: TLabel;
    des9: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    TabSheet2: TTabSheet;
    pnlnet: TDNMPanel;
    Bevel7: TBevel;
    pnlsubheading: TDNMPanel;
    btnasset:  TDNMSpeedButton;
    btnliab: TDNMSpeedButton;
    btnnet: TDNMSpeedButton;
    pnlliabsummary: TDNMPanel;
    Bevel4: TBevel;
    Bevel2: TBevel;
    pnlAssetsummary: TDNMPanel;
    Label12: TLabel;
    Label13: TLabel;
    ex5c: TLabel;
    Label15: TLabel;
    bagrossc: TLabel;
    Label18: TLabel;
    vagrossc: TLabel;
    vagross1: TLabel;
    vagross2: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    ex9c: TLabel;
    Label6: TLabel;
    bgrossc: TLabel;
    Label7: TLabel;
    vGrossc: TLabel;
    vgross1: TLabel;
    vgross2: TLabel;
    DNMPanel4: TDNMPanel;
    Label3: TLabel;
    Label8: TLabel;
    ex10: TLabel;
    Label9: TLabel;
    bnet: TLabel;
    Label11: TLabel;
    vnet: TLabel;
    vnet1: TLabel;
    vnet2: TLabel;
    Bevel3: TBevel;
    Bevel6: TBevel;

    procedure FormCreate(Sender: TObject);
    procedure pnlmainResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure tabclick(Sender: TObject);
    procedure pnlnetResize(Sender: TObject);
    procedure pnlHeaderResize(Sender: TObject);
  private
    fStringListForSQL :TStringList;
    Accountnames      :Array [1..10] of string ;
    Labels            :Array [1..10] of array [1..6] of TLabel ;
    highest:Integer;
    procedure TabSheetShow(Sender: TObject);
    Procedure alignGraph(graph1, graph2, amount:TLabel);  
  Public
    procedure RefreshQuery; override;
    Procedure RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean); override;
    Procedure makeGraph(ctr:Integer; AmountEx:double;  BudgetAmount:double);
  end;

implementation

uses CommonLib, FastFuncs, dAteUtils, 
  AccountsSelectedForReports, CommonDbLib, DNMLib, AppEnvironment ,
  SyncReportTableObj, MySQLConst, tcConst;

{$R *.dfm}

{ TDashBoardAnLGUI }

procedure TDashBoardAnLGUI.RefreshQuery;
var
  Qry:TERPQuery;
  ctr:Integer;
  usingReportTables:Boolean;
  StartDateStr,
  EndDateStr: string;

  Function AsCurrency(FloatValue:Double):String ; begin Result := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, FloatValue);end;
  function Locate(AccountName:String):Boolean; begin result := Qry.Locate('Description', Accountname , [loPartialKey]); end;
  Function Description  :STring ; begin result := Qry.Fieldbyname('Description').asString; end;
  Function AmountEX     :double ; begin result := Qry.Fieldbyname('Ex').asFloat;           end;
  Function AmountInc    :double ; begin result := Qry.Fieldbyname('Inc').asFloat;          end;
  Function BudgetAmount :double ; begin result := Qry.Fieldbyname('BudgetAmount').AsFloat; end;
  Function Variance     :double ; begin result := Qry.Fieldbyname('Ex').AsFloat - Qry.Fieldbyname('BudgetAmount').asFloat; end;
  Procedure copydata(lto, lfrom:Tlabel);begin lTo.caption := lFrom.Caption; end;

begin
  if pnlmain.parent is TDNMPanel then begin
    Self.Width  := TDNMPanel(pnlmain.parent).Width;
    Self.height := TDNMPanel(pnlmain.parent).height;
  end;

  if self.fbignoreDates then begin
    StartDateStr := StartDate;
    EndDateStr := EndDate;
  end
  else begin
    StartDateStr := QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom));
    EndDateStr := QuotedStr(FormatDateTime(MysqlDateFormat, dtTo));
  end;


  fStringListForSQL:=TStringList.create;
  try
    with fStringListForSQL do begin
    (*'  Capital / Equity'*)
      Add('           SELECT 1 as finalorder,' + QuotedStr(Accountnames[1])+' as Description ,	' +
                                      ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                      ' sum(CreditsInc - DebitsInc) as "Inc", 0 as budgetAmount 	 	' +
                                      ' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "EQUITY") ) and Date between ' +StartDateStr + ' AND ' + EndDateStr );
  (*'  Fixed Asset'*)
      Add('UNION ALL  SELECT 2 as finalorder,' + QuotedStr(Accountnames[2])+'as Description ,	' +
                                      ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                      ' sum(CreditsInc - DebitsInc) as "Inc", 0 as budgetAmount 	 	' +
                                      ' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "FIXASSET") ) and Date between ' +StartDateStr + ' AND ' + EndDateStr);
  (*'  Other Asset'*)
      Add('UNION ALL  SELECT 3 as finalorder,' + QuotedStr(Accountnames[3])+'as Description ,	' +
                                      ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                      ' sum(CreditsInc - DebitsInc) as "Inc", 0 as budgetAmount 	 	' +
                                      ' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "OASSET") )and Date between ' +StartDateStr + ' AND ' + EndDateStr );
  (*'  Other Current Asset'*)
      Add('UNION ALL  SELECT 4 as finalorder,' + QuotedStr(Accountnames[4])+' as Description ,	' +
                                      ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                      ' sum(CreditsInc - DebitsInc) as "Inc", 0 as budgetAmount 	 	' +
                                      ' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "OCASSET") ) and Date between ' +StartDateStr + ' AND ' + EndDateStr );
  (*'Gross asset'*)
      Add('UNION ALL  SELECT 5 as finalorder,' + QuotedStr(Accountnames[5])+'as Description ,	' +
                                      ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                      ' sum(CreditsInc - DebitsInc) as "Inc" 	 ,	' +
                                      ' (select Assetbudget  from tblcompanyinformation) as Budgetamount 	' +
                                      ' FROM tbltransactions 	T Where char_length(AccountName)>0 AND (AccountType in("EQUITY", "FIXASSET", "OASSET" ,"OCASSET"))  and Date between ' +StartDateStr + ' AND ' + EndDateStr );

  (*'  Credit Card Account'*)
      Add('UNION ALL  SELECT 6 as finalorder,' + QuotedStr(Accountnames[6])+'as Description ,	' +
                                      ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                      ' sum(CreditsInc - DebitsInc) as "Inc", 0 as budgetAmount 	 	' +
                                      ' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "CCARD") ) and Date between ' +StartDateStr + ' AND ' + EndDateStr);
  (*'  Long Term Liability'*)
      Add('UNION ALL  SELECT 7 as finalorder,' + QuotedStr(Accountnames[7])+'as Description ,	' +
                                      ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                      ' sum(CreditsInc - DebitsInc) as "Inc", 0 as budgetAmount 	 	' +
                                      ' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "LTLIAB") )and Date between ' +StartDateStr + ' AND ' + EndDateStr );
  (*'  Other Current Liability'*)
      Add('UNION ALL  SELECT 8 as finalorder,' + QuotedStr(Accountnames[8])+' as Description ,	' +
                                      ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                      ' sum(CreditsInc - DebitsInc) as "Inc", 0 as budgetAmount 	 	' +
                                      ' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "OCLIAB", "CCARD", "AP") ) and Date between ' +StartDateStr + ' AND ' + EndDateStr );
  (*'Gross asset'*)

      Add('UNION ALL  SELECT 9 as finalorder,' + QuotedStr(Accountnames[9])+'as Description ,	' +
                                      ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                      ' sum(CreditsInc - DebitsInc) as "Inc" 	 ,	' +
                                      ' (select LiabilityBudget from tblcompanyinformation) as Budgetamount 	' +
                                      ' FROM tbltransactions 	T Where char_length(AccountName)>0 AND (AccountType in("OCLIAB", "LTLIAB", "CCARD"))  and Date between ' +StartDateStr + ' AND ' + EndDateStr );
  (*'Acual'*)
      Add('UNION ALL  SELECT 10 as finalorder,' + QuotedStr(Accountnames[10])+'as Description ,	' +
                                      ' sum(CreditsEx - DebitsEx) as "Ex" ,	' +
                                      ' sum(CreditsInc - DebitsInc) as "Inc" 	 ,	' +
                                      ' (select Assetbudget-LiabilityBudget  from tblcompanyinformation) as Budgetamount 	' +
                                      ' FROM tbltransactions 	T Where char_length(AccountName)>0 AND (AccountType in("EQUITY", "FIXASSET", "OASSET" ,"OCASSET", "OCLIAB", "LTLIAB", "CCARD"))  and Date between ' +StartDateStr + ' AND ' + EndDateStr );
    end;
    fStringListForSQL.add('Order by finalorder');
    Qry := CommonDbLib.TempMyQuery ;
    try
      Qry.SQL.add(SyncReportObj.ChangeQuery(fStringListForSQL.text, usingReportTables));
      Qry.Open;
      Qry.first;
    for ctr:= 1 to 10 do begin
        Labels[ctr,1].caption := Description;
        Labels[ctr,2].caption := AsCurrency(AmountEx);
        if ctr in [5,9,10] then begin
          Labels[ctr,3].caption := AsCurrency(BudgetAmount);
          Labels[ctr,4].caption := AsCurrency(Variance);
          makeGraph(ctr, abs(AmountEx) , abs(BudgetAmount));
        end;
        Qry.Next;
    end;
    {summary page showing same info}
    copydata(ex5c,ex5);
    copydata(baGrossc,baGross);
    copydata(vaGrossc,vaGross);
    copydata(ex9c,ex9);
    copydata(bgrossc,bgross);
    copydata(vGrossc,vGross);
    alignGraph(vaGross1 ,vaGross2, vaGrossc);
    alignGraph(vGross1 ,vGross2, vGrossc);
    alignGraph(vnet1 ,vnet2, vnet);

    finally
        if Qry.active then Qry.close;
        FreeandNil(Qry);
    end;
  finally
      FreeandNil(fStringListForSQL)
  end;
  inherited;
  pnlAsset.parent :=pnlDetails;
  pnlAsset.visible := False;
  pnlliab.parent :=pnlDetails;
  pnlliab.visible := true;
  pnlnet.parent :=pnlDetails;
  pnlnet.visible := true;
  tabclick(btnNet);
end;
procedure TDashBoardAnLGUI.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  Accountnames[1]:='  Capital / Equity';
  Accountnames[2]:='  Fixed Asset';
  Accountnames[3]:='  Other Asset';
  Accountnames[4]:='  Other Current Asset';
  Accountnames[5]:='Gross';
  Accountnames[6]:='  Credit Card Account';
  Accountnames[7]:='  Long Term Liability';
  Accountnames[8]:='  Other Current Liability';
  Accountnames[9]:='Gross';
  Accountnames[10]:='Acual';
  for ctr := 1 to 10 do begin
    Labels[ctr, 1] := TLabel(findcomponent('des'  + Trim(IntToStr(ctr))));
    Labels[ctr, 2] := TLabel(findcomponent('ex'  + Trim(IntToStr(ctr))));
  end;
  labels[5,3] := baGross; labels[5,4] := vaGross; labels[5,5] := vaGross1;labels[5,6] := vaGross2;
  labels[9,3] := bGross;  labels[9,4] := vGross;  labels[9,5] := vGross1; labels[9,6] := vGross2;
  labels[10,3]:= bnet;    labels[10,4]:= vnet;    labels[10,5]:= vnet1;   labels[10,6]:= vnet2;
  pnlliabsummary.color := RGB(250,220,200);
  pnlLiab.color := pnlliabsummary.color;
  pnlAsset.color :=     pnlAssetsummary.color;
end;

procedure TDashBoardAnLGUI.makeGraph(ctr: Integer; AmountEx,  BudgetAmount: Double);
var
  iAmountEx,  iBudgetAmount: integer;
  tot:Integer;
begin
  highest:= 0;
  iAmountEx:= system.round(AmountEx);
  iBudgetAmount := system.round(BudgetAmount);
  tot :=iAmountEx+iBudgetAmount;
  iAmountEx := system.round(iAmountEx*40/tot);
  iBudgetAmount := system.round(iBudgetAmount*40/tot);
  labels[ctr,5].width := 1+iamountEx;
  if  highest< labels[ctr,5].width  then highest:= labels[ctr,5].width;
  labels[ctr,6].width := 1+iBudgetAmount;
  if iamountEx < iBudgetAmount then begin
    labels[ctr,5].font.color := clmaroon;
    labels[ctr,5].color := clmaroon;
  end else begin
    labels[ctr,5].font.color := clgreen;
    labels[ctr,5].color := clgreen;
  end;
end;

procedure TDashBoardAnLGUI.pnlmainResize(Sender: TObject);
begin
  inherited;
  (*pageControl1.TabWidth := System.round(pnlmain.width/3)-4;*)
(*  vnet1.Left    := vnet.Left + vnet.width+2;
  vnet2.Left    := vnet1.Left;
  vgross1.Left  := vgross.Left + vgross.width+2;
  vgross2.Left  := vgross1.Left;
  vagross1.Left := vagross.Left + vagross.width+2;
  vagross2.Left := vagross1.Left;*)
end;

procedure TDashBoardAnLGUI.FormPaint(Sender: TObject);
var
  Index: integer;
begin
    for Index := 0 to ComponentCount - 1 do begin
      if (Components[Index] is TPageControl) and Assigned(TPageControl(Components[Index]).ActivePage) then
        TabSheetShow(TPageControl(Components[Index]).ActivePage);
    end;
  inherited;
end;
procedure TDashBoardAnLGUI.TabSheetShow(Sender: TObject);
var
  TabSheetRect: TRect;
  PageControlRect: TRect;
  Bitmap: TBitmap;
  fCanvas: TControlCanvas;
begin
  Bitmap := TBitmap.Create;
  fCanvas := TControlCanvas.Create;
  try
    Bitmap.Width := 300;
    Bitmap.Height := 300;
    Bitmap.Canvas.Brush.Color := Self.color;
    Bitmap.Canvas.FillRect(Rect(0, 0, 300, 300));
    TabSheetRect := TTabSheet(Sender).ClientRect;
    fCanvas.Control := TTabSheet(Sender);
    fCanvas.Brush.Bitmap := Bitmap;
    fCanvas.FillRect(TabSheetRect);
    fCanvas.Control := TTabSheet(Sender).PageControl;
    fCanvas.Brush.Bitmap := Bitmap;
    PageControlRect := fCanvas.Control.ClientRect;
    PageControlRect.Left := TTabSheet(Sender).Left - 2;
    PageControlRect.Top := TTabSheet(Sender).Top - 2;
    PageControlRect.Right := PageControlRect.Right - 2;
    PageControlRect.Bottom := PageControlRect.Bottom - 2;
    fCanvas.FillRect(PageControlRect);
  finally
    FreeAndNil(Bitmap);
    FreeAndNil(fCanvas);
  end;
end;
procedure TDashBoardAnLGUI.PageControlChange(Sender: TObject);
begin
  inherited;
  vnet1.Left    := vnet.Left + vnet.width+2;
  vnet2.Left    := vnet1.Left;
  vgross1.Left  := vgross.Left + vgross.width+2;
  vgross2.Left  := vgross1.Left;
  vagross1.Left := vagross.Left + vagross.width+2;
  vagross2.Left := vagross1.Left;
end;

procedure TDashBoardAnLGUI.tabclick(Sender: TObject);
begin
  inherited;
  pnlAsset.visible := Sender = btnAsset;
  pnlliab.visible := sender = btnLiab;
  pnlnet.visible := sender = btnNet;
           if pnlAsset.visible  then begin pnlmain.color := pnlAsset.color;pnlHeader.color:= pnlAsset.color ; pnlsubheading.color :=pnlAsset.color;
  end else if pnlliab.visible   then begin pnlmain.color := pnlliab.color;pnlHeader.color := pnlliab.color  ; pnlsubheading.color :=pnlliab.color;
  end else if pnlnet.visible    then begin pnlmain.color := pnlnet.color;pnlHeader.color  := pnlnet.color   ; pnlsubheading.color :=pnlnet.color;
  end;
  btnAsset.color:= clInfoBk;
  btnLiab.color := clInfoBk;
  btnNet.color  := clInfoBk;
  TDnmSpeedbutton(Sender).color := clMedGray;
  pnlHeader.visible := false;
  pnlHeader.Visible := True;
  Application.ProcessMessages;

(*  btnAsset.Left := btnAsset.Left ;  btnLiab.Left := btnliab.left;  btnNet.left := btnnet.left;*)

end;

procedure TDashBoardAnLGUI.pnlnetResize(Sender: TObject);
begin
  inherited;
  alignGraph(vaGross1 ,vaGross2, vaGrossc);
  alignGraph(vGross1 ,vGross2, vGrossc);
  alignGraph(vnet1 ,vnet2, vnet);
end;
procedure TDashBoardAnLGUI.RefreshQuery(const EmployeeID: Integer; DateFrom,
  DateTo: TDateTime; ignoreDates: Boolean);
begin
  inherited;
  RefreshQuery;
end;

Procedure TDashBoardAnLGUI.alignGraph(graph1, graph2, amount:TLabel);
var
  x:Integer;
begin
  if graph1.width<Graph2.width then x := graph2.Width else x := graph1.Width;
  Graph1.left := amount.Left+amount.width - x;
  Graph2.left := graph1.left;
end;
procedure TDashBoardAnLGUI.pnlHeaderResize(Sender: TObject);
begin
  inherited;
  pnlHeader.visible := false;
  pnlHeader.Visible := True;
  Application.ProcessMessages;
end;

initialization
  RegisterClassOnce(TDashBoardAnLGUI);
end.

