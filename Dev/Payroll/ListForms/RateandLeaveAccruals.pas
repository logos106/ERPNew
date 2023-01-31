unit RateandLeaveAccruals;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TRateandLeaveAccrualsGUI = class(TBaseListingGUI)
    grpfilterOn: TRadioGroup;
    Label4: TLabel;
    qryMainDetails: TLargeintField;
    qryMainCategory: TLargeintField;
    qryMainpayID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMaindescription: TWideStringField;
    qryMainQty: TFloatField;
    qryMainAmount: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMaindatePaid: TDateTimeField;
    qryMainPayDate: TDateField;
    qryMainpaid: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    Tablename:String;
    procedure Maketable;
  Protected
    procedure SetGridColumns; Override;
    procedure RefreshTotals; override;
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib, CommonDbLib, MySQLConst;

{$R *.dfm}
{ TRateandLeaveAccrualsGUI }


procedure TRateandLeaveAccrualsGUI.FormCreate(Sender: TObject);
begin
  tablename:= GetUserTemporaryTableName('RatenLeave');
  Qrymain.SQL.Clear;
  Qrymain.SQL.Add('Select ');
  Qrymain.SQL.Add('2 as Details, ');
  Qrymain.SQL.Add('Category         AS Category , ');
  Qrymain.SQL.Add('payID            AS payID, ');
  Qrymain.SQL.Add('EmployeeName     AS EmployeeName, ');
  Qrymain.SQL.Add('description      AS description, ');
  Qrymain.SQL.Add('Qty              AS Qty, ');
  Qrymain.SQL.Add('Amount           AS Amount, ');
  Qrymain.SQL.Add('totalAmount      AS TotalAmount, ');
  Qrymain.SQL.Add('datePaid         AS datePaid, ');
  Qrymain.SQL.Add('PayDate          AS PayDate, ');
  Qrymain.SQL.Add('Paid             AS paid');
  Qrymain.SQL.Add('from ' + tablename + ' T ');
  Qrymain.SQL.Add('union all');
  Qrymain.SQL.Add('Select ');
  Qrymain.SQL.Add('1                AS Details, ');
  Qrymain.SQL.Add('NULL             AS Category, ');
  Qrymain.SQL.Add('NULL             AS payID, ');
  Qrymain.SQL.Add('EmployeeName     AS EmployeeName, ');
  Qrymain.SQL.Add('description      AS description, ');
  Qrymain.SQL.Add('Sum(Qty)         AS Qty, ');
  Qrymain.SQL.Add('NULL             AS Amount, ');
  Qrymain.SQL.Add('sum(totalAmount) AS TotalAmount, ');
  Qrymain.SQL.Add('Null             AS  datePaid, ');
  Qrymain.SQL.Add('NULL             AS PayDate, ');
  Qrymain.SQL.Add('NULL             AS Paid ');
  Qrymain.SQL.Add('from ' + tablename + ' T  ');
  Qrymain.SQL.Add('where category <> 0 ');
  Qrymain.SQL.Add('group by employeeName, description');
  Qrymain.SQL.Add('order by details, EmployeeName, payId , Category, Description');
  inherited;
  AddCalccolumn('totalAmount' , true);
end;

procedure TRateandLeaveAccrualsGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if GrpFilters.ItemIndex = 1 then begin
    if qryMainCategory.asinteger =0 then AFont.Style := AFont.Style +[fsbold];
  end;
end;

procedure TRateandLeaveAccrualsGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMainpayID.AsInteger > 0 then
    inherited;

end;

procedure TRateandLeaveAccrualsGUI.grpFiltersClick(Sender: TObject);
begin
  case grpFilters.ItemIndex of
    0:GroupFilterString := 'Details = 1';
    1:GroupFilterString := 'Details = 2';
  end;
  inherited;
end;
procedure TRateandLeaveAccrualsGUI.Maketable;
begin
    With TempMyScript do try
      SQL.Add('Drop table if exists ' + Tablename +' ;');
      SQL.Add('Create table ' + Tablename +' ');
      SQL.Add('select 1 Category, P.PayId, e.EmployeeName , PR.Description , PPR.Qty, PPR.Amount, PPR.linetotal totalAmount, P.DatePaid, P.Paydate  , P.Paid');
      SQL.Add('from tblPays P');
      SQL.Add('inner join tblpayspayrates PPR  on P.PayID = PPR.PayId');
      SQL.Add('inner join tblPayrates PR on PPR.PayRateID = PR.rateId');
      SQL.Add('inner join tblemployees E on P.EmployeeId = E.EmployeeID');
      SQL.Add('Where (' +inttostr(grpfilterOn.itemIndex) +' = 0 and P.DatePaid between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' ');
      SQL.Add('and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +') or (' +inttostr(grpfilterOn.itemIndex) +' = 1 ');
      SQL.Add('and P.Paydate  between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +')');
      SQL.Add('and P.deleted = "F"');
      SQL.Add('union all');
      SQL.Add('Select 2, P.PayId, E.employeeName, A.Description , PA.Qty , PA.Amount , PA.Qty * PA.Amount , P.DatePaid, P.Paydate  , P.Paid');
      SQL.Add('from tblpaysallowances  PA');
      SQL.Add('inner join tblallowances A on A.AllowanceID = PA.AllowanceID');
      SQL.Add('inner join tblPays P on PA.PayID = P.PayId');
      SQL.Add('inner join tblemployees E on P.EmployeeId = E.EmployeeID');
      SQL.Add('Where (' +inttostr(grpfilterOn.itemIndex) +' = 0 and P.DatePaid between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' ');
      SQL.Add('and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +') or (' +inttostr(grpfilterOn.itemIndex) +' = 1 ');
      SQL.Add('and P.Paydate  between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +')');
      SQL.Add('and P.deleted = "F"');
      SQL.Add('union all');
      SQL.Add('Select 3, P.PayId, E.employeeName, D.Description , PD.Qty , PD.Amount , PD.Qty * PD.Amount , P.DatePaid, P.Paydate  , P.Paid');
      SQL.Add('from tblpaysdeductions    PD');
      SQL.Add('inner join tbldeductions D on D.DeductionID = PD.DeductionID');
      SQL.Add('inner join tblPays P on PD.PayID = P.PayId');
      SQL.Add('inner join tblemployees E on P.EmployeeId = E.EmployeeID');
      SQL.Add('Where (' +inttostr(grpfilterOn.itemIndex) +' = 0 and P.DatePaid between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' ');
      SQL.Add('and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +') or (' +inttostr(grpfilterOn.itemIndex) +' = 1 ');
      SQL.Add('and P.Paydate  between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +')');
      SQL.Add('and P.deleted = "F"');
      SQL.Add('union all');
      SQL.Add('Select 4, P.PayId, E.employeeName, CT.CommissionDesc,   1 , PC.Gross , PC.gross , P.DatePaid, P.Paydate  , P.Paid');
      SQL.Add('from tblpayscommission    PC');
      SQL.Add('inner join tblcommissiontypes CT on PC.CommissionID = CT.CommissionID');
      SQL.Add('inner join tblPays P on PC.PayID = P.PayId');
      SQL.Add('inner join tblemployees E on P.EmployeeId = E.EmployeeID');
      SQL.Add('Where (' +inttostr(grpfilterOn.itemIndex) +' = 0 and P.DatePaid between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' ');
      SQL.Add('and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +') or (' +inttostr(grpfilterOn.itemIndex) +' = 1 ');
      SQL.Add('and P.Paydate  between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +')');
      SQL.Add('and P.deleted = "F"');
      SQL.Add('union all');
      SQL.Add('Select 5, P.PayId, E.employeeName, ST.SundryDesc ,   1 , PSN.Amount , PSN.Amount, P.DatePaid, P.Paydate  , P.Paid');
      SQL.Add('from tblpayssundries    PSN');
      SQL.Add('inner join tblPays P on PSN.PayID = P.PayId');
      SQL.Add('inner join tblsundrytypes ST on PSN.SundryID = ST.SundryID');
      SQL.Add('inner join tblemployees E on P.EmployeeId = E.EmployeeID');
      SQL.Add('Where (' +inttostr(grpfilterOn.itemIndex) +' = 0 and P.DatePaid between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' ');
      SQL.Add('and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +') or (' +inttostr(grpfilterOn.itemIndex) +' = 1 ');
      SQL.Add('and P.Paydate  between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +')');
      SQL.Add('and P.deleted = "F"');
      SQL.Add('union all');
      SQL.Add('Select 6, P.PayId, E.employeeName, ST.Description ,   1 , PSP.AmountPaid , PSP.AmountPaid, P.DatePaid, P.Paydate  , P.Paid');
      SQL.Add('from tblpayssuperannuation    PSP');
      SQL.Add('inner join tblsuperannuation SA on SA.SuperID = PSP.SuperID');
      SQL.Add('inner join tblsupertype ST on  ST.SuperTypeID = SA.SuperTypeID');
      SQL.Add('inner join tblPays P on PSP.PayID = P.PayId');
      SQL.Add('inner join tblemployees E on P.EmployeeId = E.EmployeeID');
      SQL.Add('Where (' +inttostr(grpfilterOn.itemIndex) +' = 0 and P.DatePaid between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' ');
      SQL.Add('and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +') or (' +inttostr(grpfilterOn.itemIndex) +' = 1 ');
      SQL.Add('and P.Paydate  between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +')');
      SQL.Add('and P.deleted = "F"');
      SQL.Add('union all');
      SQL.Add('select Distinct 0 Category, P.PayId, e.EmployeeName , "" , NULL, NULL, NULL, NULL,NULL , NULL');
      SQL.Add('from tblPays P');
      SQL.Add('inner join tblemployees E on P.EmployeeId = E.EmployeeID');
      SQL.Add('Where (' +inttostr(grpfilterOn.itemIndex) +' = 0 and P.DatePaid between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' ');
      SQL.Add('and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +') or (' +inttostr(grpfilterOn.itemIndex) +' = 1 ');
      SQL.Add('and P.Paydate  between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateFrom)) +' and ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, filterdateTo)) +')');
      SQL.Add('and P.deleted = "F"');
      SQL.Add('order by EmployeeName, payId , Category;');
      Execute;
    finally
      Free;
    end;
end;
procedure TRateandLeaveAccrualsGUI.RefreshQuery;
begin
  (*Qrymain.Parambyname('FilterOn').asInteger  := grpfilterOn.itemIndex;
  Qrymain.Parambyname('dateFrom').asDateTime := FilterDateFrom;
  Qrymain.Parambyname('Dateto').asDateTime   := FilterDateTo;*)
  Maketable;
  inherited;
end;

procedure TRateandLeaveAccrualsGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TRateandLeaveAccrualsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Category');
end;

Initialization
  RegisterClassOnce(TRateandLeaveAccrualsGUI);

end.

