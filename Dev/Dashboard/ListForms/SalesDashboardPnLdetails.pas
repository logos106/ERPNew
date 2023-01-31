unit SalesDashboardPnLdetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesDashBoardDetails, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  BaseListingForm;

type
  TSalesDashboardPnLdetailsGUI = class(TSalesDashBoardDetailsGUI)
    qryMainDate: TWideStringField;
    qryMainfinalorder: TLargeintField;
    qryMaindetails: TLargeintField;
    qryMaintype: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainsaleID: TLargeintField;
    qryMainEx: TFloatField;
    qryMainInc: TFloatField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib, MySQLConst;

{$R *.dfm}

{ TSalesDashboardPnLdetailsGUI }

procedure TSalesDashboardPnLdetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.caption := 'Sales Dashboard Details';
end;

procedure TSalesDashboardPnLdetailsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymaindetails.AsInteger = 1 then begin
    afont.Style := afont.Style +[fsbold];
    if sametext(Field.FieldName , QrymainsaleID.FieldName) then AFont.Color := ABrush.Color;
  end;
end;

procedure TSalesDashboardPnLdetailsGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainType.AsString;
  inherited;

end;

procedure TSalesDashboardPnLdetailsGUI.RefreshQuery;
var
  fsSaleIDs:String;
begin
  fsSaleIds:= saleIDs;

  Qrymain.disablecontrols;
  try
    closedb(Qrymain);
    Qrymain.SQL.Clear;
    Qrymain.SQL.Add('Select ');
    Qrymain.SQL.Add('' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateto)) +' as Date,  ');
    Qrymain.SQL.Add('1 as finalorder,  ');
    Qrymain.SQL.Add('1 details, ');
    Qrymain.SQL.Add('"Total Income" as type, ');
    Qrymain.SQL.Add('"Income" 		as Description ,	 ');
    Qrymain.SQL.Add('0 as saleID	,  ');
    Qrymain.SQL.Add('sum(CreditsEx - DebitsEx) as "Ex" ,	  ');
    Qrymain.SQL.Add('sum(CreditsInc - DebitsInc) as "Inc" 	 	  ');
    Qrymain.SQL.Add('FROM tbltransactions  T 					 ');
    Qrymain.SQL.Add('Where char_length(AccountName)>0 AND (AccountType in( "EXINC" ,"INC") )   			 ');
    Qrymain.SQL.Add('and Date between ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateFrom)) +' and ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateto))   );
    if fsSaleIds <> '' then Qrymain.SQL.Add('and SaleId in (' + fsSaleIDs+')');
    Qrymain.SQL.Add('UNION ALL   ');
    Qrymain.SQL.Add('Select  ');
    Qrymain.SQL.Add('' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateto)) +' as date,  ');
    Qrymain.SQL.Add('2 as finalorder,  ');
    Qrymain.SQL.Add('1 details, ');
    Qrymain.SQL.Add('"Total Cogs" as type, ');
    Qrymain.SQL.Add('"COGS" 			as Description ,	 ');
    Qrymain.SQL.Add('0 as saleID	,  ');
    Qrymain.SQL.Add('sum(CreditsEx - DebitsEx) as "Ex" ,	  ');
    Qrymain.SQL.Add('sum(CreditsInc - DebitsInc) as "Inc" 	 	  ');
    Qrymain.SQL.Add('FROM tbltransactions  T 					 ');
    Qrymain.SQL.Add('Where char_length(AccountName)>0 AND (AccountType in( "COGS") ) 						 ');
    Qrymain.SQL.Add('and Date between ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateFrom)) +' and ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateto))  +' ');
    if fsSaleIds <> '' then Qrymain.SQL.Add('and SaleId in (' + fsSaleIDs+')');
    Qrymain.SQL.Add('UNION ALL   ');
    Qrymain.SQL.Add('Select  ');
    Qrymain.SQL.Add('' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateto)) +' as date,  ');
    Qrymain.SQL.Add('3 as finalorder,  ');
    Qrymain.SQL.Add('1 details, ');
    Qrymain.SQL.Add('"Total Gross Profit" as type, ');
    Qrymain.SQL.Add('"Gross Profit" as Description ,	 ');
    Qrymain.SQL.Add('0 as saleID	,  ');
    Qrymain.SQL.Add('sum(CreditsEx - DebitsEx) as "Ex" ,	  ');
    Qrymain.SQL.Add('sum(CreditsInc - DebitsInc) as "Inc" 	 	  ');
    Qrymain.SQL.Add('FROM tbltransactions  T 					 ');
    Qrymain.SQL.Add('Where char_length(AccountName)>0 AND (AccountType in( "COGS",  "EXINC" ,"INC") )  ');
    Qrymain.SQL.Add('and Date between ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateFrom)) +' and ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateto))  +' ');
    if fsSaleIds <> '' then Qrymain.SQL.Add('and SaleId in (' + fsSaleIDs+')');
    Qrymain.SQL.Add('union all   ');
    Qrymain.SQL.Add('Select  ');
    Qrymain.SQL.Add('Date 		 as Date,  ');
    Qrymain.SQL.Add('1 as finalorder,  ');
    Qrymain.SQL.Add('2 details, ');
    Qrymain.SQL.Add('Type as type, ');
    Qrymain.SQL.Add('"Income" 		as Description ,	 ');
    Qrymain.SQL.Add('saleId		,  ');
    Qrymain.SQL.Add('sum(CreditsEx - DebitsEx) as "Ex" ,	  ');
    Qrymain.SQL.Add('sum(CreditsInc - DebitsInc) as "Inc" 	 	  ');
    Qrymain.SQL.Add('FROM tbltransactions  T 					 ');
    Qrymain.SQL.Add('Where char_length(AccountName)>0 AND (AccountType in( "EXINC" ,"INC") )  			 ');
    Qrymain.SQL.Add('and Date between ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateFrom)) +' and ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateto))  +' ');
    Qrymain.SQL.Add('  and type <> "Closing Date Summary"  ');
    if fsSaleIds <> '' then Qrymain.SQL.Add('and SaleId in (' + fsSaleIDs+')');
    Qrymain.SQL.Add('group by saleID ');
    Qrymain.SQL.Add('UNION ALL   ');
    Qrymain.SQL.Add('Select  ');
    Qrymain.SQL.Add('Date 		 as Date,  ');
    Qrymain.SQL.Add('2 as finalorder,  ');
    Qrymain.SQL.Add('2 details, ');
    Qrymain.SQL.Add('Type as type, ');
    Qrymain.SQL.Add('"COGS" 			as Description ,	 ');
    Qrymain.SQL.Add('saleId		,  ');
    Qrymain.SQL.Add('sum(CreditsEx - DebitsEx) as "Ex" ,	  ');
    Qrymain.SQL.Add('sum(CreditsInc - DebitsInc) as "Inc" 	 	  ');
    Qrymain.SQL.Add('FROM tbltransactions  T 					 ');
    Qrymain.SQL.Add('Where char_length(AccountName)>0 AND (AccountType in( "COGS") )  						 ');
    Qrymain.SQL.Add('and Date between ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateFrom)) +' and ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateto))  +'   ');
    Qrymain.SQL.Add('and type <> "Closing Date Summary"  ');
    if fsSaleIds <> '' then Qrymain.SQL.Add('and SaleId in (' + fsSaleIDs+')');
    Qrymain.SQL.Add('group by saleID ');
    Qrymain.SQL.Add('union all   ');
    Qrymain.SQL.Add('Select Date 		 as Date,  ');
    Qrymain.SQL.Add('1 as finalorder,  ');
    Qrymain.SQL.Add('2 details, ');
    Qrymain.SQL.Add('Type as type, ');
    Qrymain.SQL.Add('"Income" 		as Description ,	 ');
    Qrymain.SQL.Add('saleId		,  ');
    Qrymain.SQL.Add('sum(CreditsEx - DebitsEx) as "Ex" ,	  ');
    Qrymain.SQL.Add('sum(CreditsInc - DebitsInc) as "Inc" 	 	  ');
    Qrymain.SQL.Add('FROM tbltransactionSummarydetails  T 	 ');
    Qrymain.SQL.Add('Where char_length(AccountName)>0 AND (AccountType in( "EXINC" ,"INC") )  			 ');
    Qrymain.SQL.Add('and Date between ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateFrom)) +' and ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateto))  +' ');
    if fsSaleIds <> '' then Qrymain.SQL.Add('and SaleId in (' + fsSaleIDs+')');
    Qrymain.SQL.Add('group by saleID ');
    Qrymain.SQL.Add('UNION ALL   ');
    Qrymain.SQL.Add('Select Date 		 as Date,  ');
    Qrymain.SQL.Add('2 as finalorder,  ');
    Qrymain.SQL.Add('2 details, ');
    Qrymain.SQL.Add('Type as type, ');
    Qrymain.SQL.Add('"COGS" 			as Description ,	 ');
    Qrymain.SQL.Add('saleId		,  ');
    Qrymain.SQL.Add('sum(CreditsEx - DebitsEx) as "Ex" ,	  ');
    Qrymain.SQL.Add('sum(CreditsInc - DebitsInc) as "Inc" 	 	  ');
    Qrymain.SQL.Add('FROM tbltransactionSummarydetails  T 	Where char_length(AccountName)>0 AND (AccountType in( "COGS") )  						 ');
    Qrymain.SQL.Add('and Date between ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateFrom)) +' and ' + Quotedstr(FormatDatetime(MySQLDatetimeformat, FilterDateto))  +' ');
    if fsSaleIds <> '' then Qrymain.SQL.Add('and SaleId in (' + fsSaleIDs+')');
    Qrymain.SQL.Add('group by saleID ');
    Qrymain.SQL.Add('order by finalorder , details');
    inherited;
  finally
    Qrymain.EnableControls
  end;

end;

initialization
  RegisterClassOnce(TSalesDashboardPnLdetailsGUI);

end.

