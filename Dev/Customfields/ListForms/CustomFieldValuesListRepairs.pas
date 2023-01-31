unit CustomFieldValuesListRepairs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustomFieldValuesListRepairsGUI = class(TCustomFieldValuesListBaseGUI)
    qryMainRepairID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainCreationDate: TDateField;
    qryMainDone: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainFeedbackNotes: TWideMemoField;
    qryMainCustomerDetails: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainFax: TWideStringField;
    qryMainJobDueDate: TDateTimeField;
    qryMainConverted: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainBillToCustomerDetails: TWideStringField;
    qryMainBillCusID: TIntegerField;
    qryMainUseBillCust: TWideStringField;
    qryMainBillPhone: TWideStringField;
    qryMainBillAltPhone: TWideStringField;
    qryMainBillFax: TWideStringField;
    qryMainSOGlobalRef: TWideStringField;
    qryMainQuoteGlobalRef: TWideStringField;
    qryMainCustomerPONumber: TWideStringField;
    qryMainCompletionTime: TWideStringField;
    qryMainShipping: TWideStringField;
    qryMainAllocatedEmployeeID: TIntegerField;
    qryMainTerms: TWideStringField;
    qryMainBillMobile: TWideStringField;
    qryMainQuotedAmount: TFloatField;
    qryMainQuotedAmountinc: TFloatField;
    qryMainHoldRepair: TWideStringField;
    qryMainRepairClient: TWideStringField;
    qryMainRepName: TWideStringField;
    qryMainClassName: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure MakeQrymain;Overload;Override;
    procedure MakeQrymain(const Fields : String; Tables: String);Overload;Override;
    Procedure AddtoQrymainsql;Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, customfieldlistlib;

{$R *.dfm}

{ TCustomFieldValuesListRepairsGUI }
procedure TCustomFieldValuesListRepairsGUI.MakeQrymain;
begin
    CustomfieldlistSQL(Listtype, qrymain, 'R.RepairID' , MakeQrymain , 0);
end;

procedure TCustomFieldValuesListRepairsGUI.AddtoQrymainsql;
begin
  inherited;
  Qrymain.sql.add('Where CreationDate between :Datefrom and :Dateto' );
end;

procedure TCustomFieldValuesListRepairsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := True;
end;

procedure TCustomFieldValuesListRepairsGUI.MakeQrymain(const Fields: String;  Tables: String);
begin
  With Scriptmain do try
    SQL.clear;
    SQL.add('Drop table if exists ' + fstablename +';');
    SQL.add('Create table ' + fstablename );
    SQL.add('SELECT');
    SQL.add('R.RepairID as RepairID,');
    SQL.add('R.GlobalRef as GlobalRef,');
    SQL.add('R.CreationDate as CreationDate,');
    SQL.add('R.Done as Done,');
    SQL.add('R.Notes as Notes,');
    SQL.add('R.FeedbackNotes as FeedbackNotes,');
    SQL.add('R.CustomerDetails,');
    SQL.add('R.Phone,');
    SQL.add('R.AltPhone,');
    SQL.add('R.Mobile,');
    SQL.add('R.Fax,');
    SQL.add('R.JobDueDate,');
    SQL.add('R.Converted,');
    SQL.add('R.Status,');
    SQL.add('R.BillToCustomerDetails,');
    SQL.add('R.BillCusID,');
    SQL.add('R.UseBillCust,');
    SQL.add('R.BillPhone,');
    SQL.add('R.BillAltPhone,');
    SQL.add('R.BillFax,');
    SQL.add('R.SOGlobalRef,');
    SQL.add('R.QuoteGlobalRef,');
    SQL.add('R.CustomerPONumber,');
    SQL.add('R.CompletionTime,');
    SQL.add('R.Shipping,');
    SQL.add('R.AllocatedEmployeeID,');
    SQL.add('R.Terms,');
    SQL.add('R.BillMobile,');
    SQL.add('R.QuotedAmount,');
    SQL.add('R.QuotedAmountinc,');
    SQL.add('R.HoldRepair,');
    SQL.add('C.Company AS RepairClient,');
    SQL.add('E.EmployeeName as RepName,');
    SQL.add(Fields);
    SQL.add('class.ClassName');
    SQL.add('FROM tblrepairs AS R');
    SQL.add('inner Join tblclients AS C ON R.CusID = C.ClientID');
    SQL.add('inner Join tblclass AS class ON R.ClassID = class.ClassID');
    SQL.add('inner Join tblemployees AS E ON R.EmployeeID = E.EmployeeID');
    SQL.add(Tables);
    SQL.add('Where ((R.CreationDate Between   :Datefrom and  :Dateto) or (isnull(R.CreationDate)) or (R.CreationDate="1899-12-30" ) )');
    SQL.add('And R.Cancelled ="F"');
    SQL.add('ORDER BY jobdueDate, C.Company');
  finally
    Execute;
    SQL.clear;
  end;

end;

procedure TCustomFieldValuesListRepairsGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;
initialization
  RegisterClassOnce(TCustomFieldValuesListRepairsGUI);

end.
