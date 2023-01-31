unit GoogleLeadsummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, StdCtrls, ExtCtrls, DNMPanel;

type
  TGoogleLeadsummaryGUI = class(TBaseForm)
    pnlMain: TDNMPanel;
    lblNewLeads: TLabel;
    edtNewLeads: TEdit;
    lblNewVisits: TLabel;
    edtNewVisits: TEdit;
    lblconversionRate: TLabel;
    Edtconversionrate: TEdit;
    lblcostperLead: TLabel;
    edtcostperLead: TEdit;
    Label1: TLabel;
    procedure edtcostperLeadDblClick(Sender: TObject);
    procedure edtNewLeadsDblClick(Sender: TObject);
  private
    fdNewVisits: Double;
    fdDateto: TDatetime;
    fdDateFrom: TDatetime;
    procedure setNewVisits(const Value: Double);
    procedure AccountTransactionlistbeforeShow(Sender: TObject);
    Function googlesources:String;
    function NewLeads: double;
    function Googlecost: Double;
    procedure beforeshowGoogleLeads(Sender: TObject);
    function GetBatchDate: string;
  public
    procedure RefreshData;
    Property dateFrom :TDatetime  read fdDateFrom write fdDatefrom;
    Property Dateto :TDatetime    read fdDateto   write fdDateto;
    Property NewVisits         :Double read fdNewVisits         write setNewVisits;
  end;


implementation

uses CommonFormLib, AccountTransactionlist, DNMLib, MySQLConst, CommonDbLib,
  GoogleLeads , AppEnvironment, tcConst;

{$R *.dfm}

{ TGoogleLeadsummaryGUI }
procedure TGoogleLeadsummaryGUI.AccountTransactionlistbeforeShow(Sender: TObject);
var
  s:String;
begin
    if not(Sender is TAccountTransactionlistGUI) then exit;
    TAccountTransactionlistGUI(Sender).fbDateRangeSupplied := true;
    TAccountTransactionlistGUI(Sender).dateto := Dateto;
    TAccountTransactionlistGUI(Sender).datefrom := DateFrom;
    With TempMyQuery do try
      SQL.add('Select distinct concat("Accountid = " , ifnull(Account,0) ) as Account from tblsource where ShowinGoogle ="T" union all Select "AccountID = 0" ');
      open;
      s:= groupconcat('Account', '' , False ,  ' or ' );
      TAccountTransactionlistGUI(Sender).filterString := s;
    finally
      closenFree;
    end;
end;
procedure TGoogleLeadsummaryGUI.edtcostperLeadDblClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TAccountTransactionlistGUI' , nil , AccountTransactionlistbeforeShow);
end;
function TGoogleLeadsummaryGUI.GetBatchDate: string;
var
  TempDate: TDateTime;
begin
    Try
      TempDate := AppEnv.CompanyPrefs.TransactionTableLastUpdated;
      if TempDate = 0 then
        Result := ' '
      else
        Result := FormatDateTime(formatSettings.Shortdateformat+ ' ," at " hh:mm AM/PM', TempDate);
    except
      Result:='';
    end;
end;
procedure TGoogleLeadsummaryGUI.RefreshData;
begin

  edtNewLeads.Text       := FloatToStrF(NewLeads, ffNumber, 15, 2);
  edtconversionrate.Text := FloatToStrF(DivZer(NewLeads , NewVisits)*100, ffNumber, 15, 2) +' %';
  edtcostperLead.Text    := FloatToStrF(DivZer(GoogleCost, NewLeads), ffCurrency, 15, 2);

  edtNewLeads.hint      := 'New Leads created between ' +quotedstr(formatDatetime(FormatSettings.ShortdateFormat , DateFrom)) +' and ' + quotedstr(formatDatetime(FormatSettings.ShortdateFormat , DateTo)) + NL+
                            ' from Google Sources (listed below)' +NL+ googlesources+NL+NL+'Double Click for details' +NL;
  EdtNewVisits.hint     := 'New Google Visits between ' +quotedstr(formatDatetime(FormatSettings.ShortdateFormat , DateFrom)) +' and ' + quotedstr(formatDatetime(FormatSettings.ShortdateFormat , DateTo)) + NL;
  Edtconversionrate.hint:= 'New Leads / New Visits' +NL;
  edtcostperLead.hint   := 'Total Cost / New Lead ' +NL+' Do ''Update Batch'' to get up to date cost for calculation'+NL + 'Batch Transaction Last Updated on ' + GetBatchDate +NL;
  edtNewLeads.showhint  := True;
  EdtNewVisits.showhint := true;
  Edtconversionrate.showhint  := true;
  edtcostperLead.showhint     := true;
end;

procedure TGoogleLeadsummaryGUI.setNewVisits(const Value: Double)        ;begin  fdNewVisits        := Value;  edtNewVisits.Text         := FloatToStrF(Value, ffNumber, 15, 2);end;

function TGoogleLeadsummaryGUI.googlesources: String;
begin
    With TempMyquery do try
      SQL.add('select distinct concat("    " , mediatype) mediatype from tblsource where ShowinGoogle ="T"');
      open;
      result := Groupconcat('mediatype','' , False ,  NL);
      if result = '' then result := NL+'(You haven''t created any source for Google. Please create them)';
    finally
      closenFree;
    end;
end;
function TGoogleLeadsummaryGUI.NewLeads: double;
begin
     with TempMyquery do try
      SQL.Add('Select  Count(*) ctr  from tblmarketingcontacts  MC ' +
              ' where MC.DateEntered between ' +quotedstr(formatDateTime(MysqlDateFormat , DateFrom)) + '  and ' + Quotedstr(formatDateTime(MysqlDateFormat , DateTo)) +
              ' and MedTypeID in ( Select MedTypeID from tblsource where ShowinGoogle ="T")');
      open;
      result := Fieldbyname('ctr').AsFloat;
     finally
       closenFree;
     end;
end;
procedure TGoogleLeadsummaryGUI.beforeshowGoogleLeads(Sender: TObject);
begin
  if not(sender is TGoogleLeadsGUI) then exit;
  TGoogleLeadsGUI(Sender).dtfrom.date := DateFrom;
  TGoogleLeadsGUI(Sender).dtfrom.date := DateTo;
end;
procedure TGoogleLeadsummaryGUI.edtNewLeadsDblClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TGoogleLeadsGUI' , beforeshowGoogleLeads)
end;

function TGoogleLeadsummaryGUI.Googlecost: Double;
begin
  With TempMyQuery do try
    SQL.Add('Select   ' +
              ' sum(T.DebitsInc - T.CreditsInc) amount ' +
              '  from tblsource S  ' +
              ' inner join tblTransactions  T on S.Account = t.accountId   ' +
              ' where ShowinGoogle ="T"  ' +
              ' and t.Date between ' +quotedstr(formatDateTime(MysqlDateFormat , DateFrom)) + '  and ' + Quotedstr(formatDateTime(MysqlDateFormat , DateTo)) );
    open;
    result := fieldbyname('amount').AsFloat;
  finally
    closenFree;
  end;
end;

end.

