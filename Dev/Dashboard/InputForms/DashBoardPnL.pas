unit DashBoardPnL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardBase, ExtCtrls, DNMPanel, busobjbase, StdCtrls, DB,
  MemDS, DBAccess, MyAccess,ERPdbComponents, ComCtrls, BaseFormForm, Menus,
  SelectionDialog;

type
  TDashBoardPnLGUI = class(TDashBoardBaseGUI)
    IncnCogs: TBevel;
    lblTotal: TLabel;
    lblBudget: TLabel;
    lblVariance: TLabel;
    C1 :TLabel;C2 :TLabel;C3 :TLabel;C4 :TLabel;C5 :TLabel;C6 :TLabel;C7 :TLabel;
    T1 :TLabel;T2 :TLabel;T3 :TLabel;T4 :TLabel;T5 :TLabel;T6 :TLabel;T7 :TLabel;
    B1 :TLabel;B2 :TLabel;B3 :TLabel;B4 :TLabel;B5 :TLabel;B6 :TLabel;B7 :TLabel;
    V1 :TLabel;V2 :TLabel;V3 :TLabel;V4 :TLabel;V5 :TLabel;V6 :TLabel;V7 :TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;bu2:TLabel;bu3:TLabel;bu4:TLabel;bu5:TLabel;bu6:TLabel;bu7:TLabel;
    a1 :TLabel;a2 :TLabel;a3 :TLabel;a4 :TLabel;a5 :TLabel;a6 :TLabel;
    bu1: TLabel;
    
    procedure FormCreate(Sender: TObject);
    procedure pnlmainResize(Sender: TObject);
  private
    fStringListForSQL :TStringList;
    Accountnames      :Array [1..7] of string ;
    Labels            :Array [1..7] of array [1..6] of TLabel ;
    //highest:Integer;
  Public
    procedure RefreshQuery; override;
    Procedure RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean); override;
    Procedure makeGraph(ctr:Integer; AmountEx:double;  BudgetAmount:double);
  end;

implementation

uses CommonLib, FastFuncs, dAteUtils,
  AccountsSelectedForReports, CommonDbLib, DNMLib, AppEnvironment,
  SyncReportTableObj, MySQLConst, tcConst;

{$R *.dfm}

{ TDashBoardPnLGUI }

procedure TDashBoardPnLGUI.RefreshQuery;
var
  Qry:TERPQuery;
  ctr:Integer;
  noOfDays:Integer;
  usingReportTables: Boolean;
  StartDateStr, EndDateStr: string;

  Function AsCurrency(FloatValue:Double):String ; begin if (ctr = 6) and (FloatValue = 0) then result := 'NIL' else Result := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, FloatValue);end;
  function Locate(AccountName:String):Boolean; begin result := Qry.Locate('Description', Accountname , [loPartialKey]); end;
  Function Description  :STring ; begin result := Qry.Fieldbyname('Description').asString; end;
  Function AmountEX     :double ; begin result := Qry.Fieldbyname('Ex').asFloat;           end;
  Function AmountInc    :double ; begin result := Qry.Fieldbyname('Inc').asFloat;          end;
  Function BudgetAmount :double ; begin result := Qry.Fieldbyname('BudgetAmount').AsFloat; end;
  Function Variance     :double ; begin result := Qry.Fieldbyname('Ex').AsFloat - Qry.Fieldbyname('BudgetAmount').asFloat; end;

  function calcbudget(ffieldname:String):String;
  begin
    {cogs and expense budget should be negative}
    ffieldname := 'ifnull('+ffieldname+',0)';
    if (fastfuncs.PosEx('COGSBudget', ffieldname )>0) or
      (fastfuncs.PosEx('ExpenseBudget' , ffieldname )>0) then
      ffieldname := '(0-'+ffieldname+')';
    Result := '(' + ffieldname +'/365*'+IntToStr(noofDays)+') ';
  end;

begin
  if self.fbignoreDates then begin
    StartDateStr := StartDate;
    EndDateStr := EndDate;
    noOfDays :=  system.round(DateTimeToJulianDate(date) - DateTimeToJulianDate(IncDay(AppEnv.CompanyPrefs.ClosingDate)))  ;
  end
  else begin
    StartDateStr := QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom));
    EndDateStr := QuotedStr(FormatDateTime(MysqlDateFormat, dtTo));
    noOfDays :=  system.round(DateTimeToJulianDate(dtTo) - DateTimeToJulianDate(IncDay(AppEnv.CompanyPrefs.ClosingDate)))  ;
  end;
//  noOfDays :=  system.round(DateTimeToJulianDate(date) - DateTimeToJulianDate(IncDay(AppEnv.CompanyPrefs.ClosingDate)))  ;
//  if noofDays<=0 then noofDays := 365;
  if noofDays < 0 then noofDays := 0;

  if pnlmain.parent is TDNMPanel then begin
    Self.Width  := TDNMPanel(pnlmain.parent).Width;
    Self.height := TDNMPanel(pnlmain.parent).height;
  end;


  fStringListForSQL:=TStringList.create;
  try
    with fStringListForSQL do begin
      Add('           SELECT 1 as finalorder,' + QuotedStr(Accountnames[1])+' as Description,');
                              Add(' sum(CreditsEx - DebitsEx) as "Ex" ,');
                              Add(' sum(CreditsInc - DebitsInc) as "Inc",');
                              Add(' (select '+ calcbudget('IncomeBudget')+' from tblcompanyinformation) as Budgetamount');
                              Add(' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "EXINC" ,"INC") ) and Date between ' +StartDateStr + ' AND ' + EndDateStr );
      Add('UNION ALL  SELECT 2 as finalorder,' + QuotedStr(Accountnames[2])+'as Description ,');
                              Add('sum(CreditsEx - DebitsEx) as "Ex",');
                              Add('sum(CreditsInc - DebitsInc) as "Inc",');
                              Add('(select '+ calcbudget('COGSBudget')+'  from tblcompanyinformation) as Budgetamount');
                              Add(' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "COGS") ) and Date between ' +StartDateStr + ' AND ' + EndDateStr);
      Add('UNION ALL  SELECT 3 as finalorder,' + QuotedStr(Accountnames[3])+'as Description ,');
                              Add(' sum(CreditsEx - DebitsEx) as "Ex" ,');
                              Add(' sum(CreditsInc - DebitsInc) as "Inc",');
                              Add(' (select round('+ calcbudget('IncomeBudget')+'+'+ calcbudget('COGSBudget')+')  from tblcompanyinformation) as Budgetamount');
                              Add(' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "COGS",  "EXINC" ,"INC") )and Date between ' +StartDateStr + ' AND ' + EndDateStr );
      Add('UNION ALL  SELECT 4 as finalorder,' + QuotedStr(Accountnames[4])+' as Description ,');
                              Add(' sum(CreditsEx - DebitsEx) as "Ex" ,');
                              Add(' sum(CreditsInc - DebitsInc) as "Inc",');
                              Add(' (select '+ calcbudget('ExpenseBudget')+'  from tblcompanyinformation) as Budgetamount');
                              Add(' FROM tbltransactions  T Where char_length(AccountName)>0 AND (AccountType in( "EXEXP" ,"EXP") ) and Date between ' +StartDateStr + ' AND ' + EndDateStr );
      Add('UNION ALL  SELECT 5 as finalorder,' + QuotedStr(Accountnames[5])+'as Description ,');
                              Add(' sum(CreditsEx - DebitsEx) as "Ex" ,');
                              Add(' sum(CreditsInc - DebitsInc) as "Inc",');
                              Add(' (select round('+ calcbudget('IncomeBudget')+'+ '+ calcbudget('COGSBudget')+' +'+ calcbudget('ExpenseBudget')+')  from tblcompanyinformation) as Budgetamount');
                              Add(' FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in( "EXEXP" ,"EXP", "COGS", "EXINC" ,"INC"))  and Date between ' +StartDateStr + ' AND ' + EndDateStr );
      Add('UNION ALL  SELECT 6 as finalorder, concat(' + QuotedStr(Accountnames[6]+'(')+',' +QuotedStr(FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage))+', "% )") as Description ,');
      if Appenv.CompanyPrefs.ZerotaxWhenLoss then begin
        Add('if(ifnull(sum(CreditsEx - DebitsEx),0)<=0, 0, sum(CreditsEx - DebitsEx)*'+ FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage)+'/100) as "Ex",');
                              Add(' if(ifnull(sum(CreditsInc - DebitsInc),0)<=0 , 0 , sum(CreditsInc - DebitsInc)*' +FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage)+'/100) as "Inc",');
      end else begin
        Add('sum(CreditsEx - DebitsEx)*'+ FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage)+'/100 as "Ex" ,');
                              Add('sum(CreditsInc - DebitsInc)*' +FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage)+'/100 as "Inc",' );

      end;
      Add('(select round(('+ calcbudget('IncomeBudget')+'+ '+ calcbudget('COGSBudget')+' +'+ calcbudget('ExpenseBudget')+')*' +FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage)+'/100)   from tblcompanyinformation) as Budgetamount');
                              Add(' FROM tbltransactions T');
                              Add(' Where char_length(AccountName)>0');
                              Add(' AND (AccountType in( "EXEXP" ,"EXP", "COGS", "EXINC" ,"INC")) and Date between ' +StartDateStr + ' AND ' + EndDateStr);
      Add('UNION ALL  SELECT 7 as finalorder,' + QuotedStr(Accountnames[7])+'as Description,' );
      if Appenv.CompanyPrefs.ZerotaxWhenLoss then begin
      Add(' if(ifnull(sum(CreditsEx - DebitsEx),0)<=0 , sum(CreditsEx - DebitsEx) , sum(CreditsEx - DebitsEx)*(100-' +FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage)+')/100) as "Ex" ,');
                                  Add('if(ifnull(sum(CreditsInc - DebitsInc),0)<=0 , sum(CreditsInc - DebitsInc) ,sum(CreditsInc - DebitsInc)*(100-' +FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage)+')/100)  as "Inc",' );
      end else begin
      Add('sum(CreditsEx - DebitsEx)*(100-' +FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage)+')/100 as "Ex" ,');
                                  Add(' sum(CreditsInc - DebitsInc)*(100-' +FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage)+')/100 as "Inc",');
      end;
      Add('(select round(('+ calcbudget('IncomeBudget')+'+ '+ calcbudget('COGSBudget')+' +'+ calcbudget('ExpenseBudget')+')*(100-' +FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage)+')/100)   from tblcompanyinformation) as Budgetamount');
                                  Add(    ' FROM tbltransactions T');
                                  Add(' Where char_length(AccountName)>0');
                                  Add(' AND (AccountType in( "EXEXP" ,"EXP", "COGS", "EXINC" ,"INC")) and Date between ' +StartDateStr + ' AND ' + EndDateStr);
    end;
    fStringListForSQL.add('Order by finalorder,description');
    Qry := CommonDbLib.TempMyQuery ;
    try
      Qry.SQL.add(SyncReportObj.ChangeQuery(fStringListForSQL.text, usingReportTables));
      Qry.Open;
    for ctr:= 1 to 7 do begin
      if Locate(Accountnames[ctr]) then begin
        Labels[ctr,1].caption := Description;
        Labels[ctr,2].caption := AsCurrency(AmountEx);
        Labels[ctr,3].caption := AsCurrency(BudgetAmount);
        Labels[ctr,4].caption := AsCurrency(Variance);
        makeGraph(ctr, abs(AmountEx) , abs(BudgetAmount));
      end;
    end;

    finally
        if Qry.active then Qry.close;
        FreeandNil(Qry);
    end;
  finally
      FreeandNil(fStringListForSQL)
  end;
  inherited;
end;
procedure TDashBoardPnLGUI.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  Accountnames[1]:='   Income';
  Accountnames[2]:='   COGS';
  Accountnames[3]:='Gross Profit';
  Accountnames[4]:='   Expense';
  Accountnames[5]:='Net Income(Inc)';
  Accountnames[6]:='   Income Tax';
  Accountnames[7]:='Net Income(Ex)';
  for ctr := 1 to 7 do begin
    Labels[ctr, 1] := TLabel(findcomponent('c'  + Trim(IntToStr(ctr))));
    Labels[ctr, 2] := TLabel(findcomponent('t'  + Trim(IntToStr(ctr))));
    Labels[ctr, 3] := TLabel(findcomponent('b'  + Trim(IntToStr(ctr))));
    Labels[ctr, 4] := TLabel(findcomponent('v'  + Trim(IntToStr(ctr))));
    Labels[ctr, 5] := TLabel(findcomponent('a'  + Trim(IntToStr(ctr))));
    Labels[ctr, 6] := TLabel(findcomponent('bu' + Trim(IntToStr(ctr))));
  end;

end;

procedure TDashBoardPnLGUI.makeGraph(ctr: Integer; AmountEx,  BudgetAmount: Double);
var
  iAmountEx,  iBudgetAmount: integer;
  tot:Integer;
begin
  //highest:= 0;
  iAmountEx:= system.round(AmountEx);
  iBudgetAmount := system.round(BudgetAmount);
  tot :=iAmountEx+iBudgetAmount;
  iAmountEx := system.round(iAmountEx*40/tot);
  iBudgetAmount := system.round(iBudgetAmount*40/tot);
  labels[ctr,5].width := 1+iamountEx;
  //if  highest< labels[ctr,5].width  then highest:= labels[ctr,5].width;
  labels[ctr,6].width := 1+iBudgetAmount;
  if iamountEx < iBudgetAmount then begin
    labels[ctr,5].font.color := clmaroon;
    labels[ctr,5].color := clmaroon;
  end else begin
    labels[ctr,5].font.color := clgreen;
    labels[ctr,5].color := clgreen;
  end;
end;

procedure TDashBoardPnLGUI.pnlmainResize(Sender: TObject);
var
  ctr:Integer;
  l :Integer;
begin
  inherited;
  l:=V1.Left + V1.width+2;
  for ctr := 1 to 7 do begin
    Labels[ctr, 6].Left := l;
    Labels[ctr, 5].Left := l;
  end;
end;

procedure TDashBoardPnLGUI.RefreshQuery(const EmployeeID: Integer; DateFrom,
  DateTo: TDateTime; ignoreDates: Boolean);
begin
  inherited;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TDashBoardPnLGUI);
end.

