unit NumberSequenceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TNumberSequenceListGUI = class(TBaseListingGUI)
    qryMainTransactionNo: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainTransDate: TDateTimeField;
    qryMainTransactionType: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainTransStatus: TWideStringField;
    qryMainSeqno: TIntegerField;
    ERPQuery: TERPQuery;
    btnResetSeqno: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnResetSeqnoClick(Sender: TObject);
  private
    fsAllTransactionsTablename, fsSingleTransactionTablename,fsQrymainTablename  :STring;
    Procedure CreateTempTable(showPopup:boolean);

  protected
    procedure RefreshQuery; override;
    function getFilterDateFrom: TDatetime;override;
    function getFilterdateto: TDAteTime;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, CommonDbLib, tcConst, dateutils,
  frmNumberSequenceListPopup;

{$R *.dfm}
procedure TNumberSequenceListGUI.CreateTempTable(showPopup:boolean);
begin
{Seqno required for each type of transaction
all transaction records are added into a temptable(fatablename1)
records for each type from this table repeat the following steps:
      is added into a differenct table with auto-id (fsSingleTransactionTablename)
      and added into the third table(fsQrymainTablename) with auto-id as the seqno}

  With Scriptmain do begin
      SQL.Clear;
      SQL.add('truncate  ' +fsAllTransactionsTablename +';');
      SQL.add('truncate  ' +fsSingleTransactionTablename +';');
      SQL.add('truncate  ' +fsQrymainTablename +';');

      SQL.add('INSERT INTO ' +fsAllTransactionsTablename + ' (TransType, TransactionNo, GlobalRef , TransDate , TransactionType , EmployeeName, TransStatus) ' +
              ' SELECT "S", ' +
              ' tblSales.SaleId as TransactionNo, ' +
              ' tblSales.GlobalRef as GlobalRef, ' +
              ' date(if(ifnull(tblSales.SaleDate,0)=0 ,tblSales.mstimeStamp , tblSales.SaleDate))   as TransDate, ' +
              ' if(tblSales.IsCashSale="T" and tblSales.IsPOS="F" ,"Cash Sale", ' +
              ' if(tblSales.IsRefund="T","Refund", ' +
              ' if(tblSales.IsCashSale="T" and tblSales.IsPOS="T","POS", ' +
              ' if(tblSales.IsInvoice="T","Invoice", ' +
              ' if(tblSales.IsQuote="T","Quote","Sales Order"))))) as TransactionType, ' +
              ' tblSales.EmployeeName as EmployeeName, ' +
              ' if(tblSales.Cancelled = "T","Cancelled",if(tblSales.Deleted = "T", "Deleted","Active")) as TransStatus ' +
              ' FROM tblSales ' +
              ' order by TransactionNo;');

      SQL.add('INSERT INTO ' +fsAllTransactionsTablename + ' (TransType, TransactionNo, GlobalRef , TransDate , TransactionType , EmployeeName, TransStatus) ' +
              ' SELECT "P",  ' +
              ' tblpurchaseorders.PurchaseOrderID as TransactionNo, ' +
              ' tblpurchaseorders.GlobalRef as GlobalRef, ' +
              ' date(if(ifnull(tblpurchaseorders.OrderDate,0)=0 ,tblpurchaseorders.mstimeStamp , tblpurchaseorders.OrderDate))   as TransDate, ' +
              ' if(tblpurchaseorders.IsPO="T","Purchase Order", ' +
              ' if(tblpurchaseorders.IsRA="T","Return Authority", ' +
              ' if(tblpurchaseorders.IsBill="T","Bill", ' +
              ' if(tblpurchaseorders.IsCredit="T","Credit", ' +
              ' if(tblpurchaseorders.IsCheque="T","Cheque","PO Credit"))))) as TransactionType, ' +
              ' tblpurchaseorders.EmployeeName as EmployeeName, ' +
              ' if(tblpurchaseorders.Cancelled = "T","Cancelled",if(tblpurchaseorders.Deleted = "T", "Deleted","Active")) as TransStatus ' +
              ' FROM tblpurchaseorders ' +
              ' order by TransactionNo;');

      SQL.add('INSERT INTO ' +fsAllTransactionsTablename + ' (TransType, TransactionNo, GlobalRef , TransDate , TransactionType , EmployeeName, TransStatus) ' +
              ' SELECT "R",  ' +
              ' R.RepairID as TransactionNo, ' +
              ' R.GlobalRef as GlobalRef, ' +
              ' date(if(ifnull(R.CreationDate ,0)=0 ,R.mstimeStamp , R.CreationDate ))   as TransDate, ' +
              ' "Repairs" as TransactionType, ' +
              ' E.EmployeeName as EmployeeName, ' +
              ' if(R.Cancelled ="T" , "Cancelled" , "Active") as TransStatus ' +
              ' FROM tblrepairs R inner join tblemployees E on R.employeeId = E.employeeID  ' +
              ' order by TransactionNo;');

      showProgressbar('Please Wait' , 5);
      try
        Execute;
      finally
          hideProgressbar;
      end;
      TfmNumberSequenceListPopup.NumberSequenceListPopup(fsAllTransactionsTablename , showPopup) ;
      CloseDb(ERPQuery);
      ERPQuery.SQL.clear;
      ERPQuery.SQL.add('select * from tblnumbersequencelistseqno');
      ERPQuery.open;
      if ERPQuery.recordcount = 0 then exit;
      ERPQuery.first;

      SQL.Clear;

      showProgressbar('Please Wait' , ERPQuery.Recordcount*4+5);
      try
        While ERPQuery.Eof = False do begin
          SQL.add('truncate  ' +fsSingleTransactionTablename +';');
          SQL.add('ALTER TABLE ' +fsSingleTransactionTablename +' AUTO_INCREMENT = ' + inttoStr(ERPQuery.fieldByname('SeqnoTostart').asInteger) +';');
          SQL.add('INSERT INTO ' +fsSingleTransactionTablename + ' (TransType, TransactionNo, GlobalRef , TransDate , TransactionType , EmployeeName, TransStatus) Select TransType,TransactionNo, GlobalRef , TransDate , TransactionType , EmployeeName, TransStatus from ' +fsAllTransactionsTablename +' where TransactionType = '+quotedstr(ERPQuery.fieldbyname('TransactionType').asString)+';');
          SQL.add('INSERT INTO ' +fsQrymainTablename + ' (SeqNo , TransType, TransactionNo, GlobalRef , TransDate , TransactionType , EmployeeName, TransStatus) Select ID, TransType, TransactionNo, GlobalRef , TransDate , TransactionType , EmployeeName, TransStatus from ' +fsSingleTransactionTablename+';');
          ERPQuery.NExt;
        end;
        Execute;
      finally
        HideProgressbar;
      end;
  end;

end;

procedure TNumberSequenceListGUI.btnResetSeqnoClick(Sender: TObject);
begin
  inherited;
  CreateTempTable(True);
  RefreshQuery;
end;

procedure TNumberSequenceListGUI.FormCreate(Sender: TObject);
begin
  fsAllTransactionsTablename := commondbLib.CreateUserTemporaryTable('tmp_NumberSequenceList' , '1');
  fsSingleTransactionTablename := commondbLib.CreateUserTemporaryTable('tmp_NumberSequenceList' , '2');
  fsQrymainTablename := commondbLib.CreateUserTemporaryTable('tmp_NumberSequenceList','');

  Qrymain.SQL.clear;
  Qrymain.SQL.Add(' Select');
  Qrymain.SQL.Add('`ID`  as `ID`,');
  Qrymain.SQL.Add('`TransType`  as `TransType`,');
  Qrymain.SQL.Add('`TransactionNo`  as `TransactionNo`,');
  Qrymain.SQL.Add('`GlobalRef`  as `GlobalRef`,');
  Qrymain.SQL.Add('`TransDate`  as `TransDate`,');
  Qrymain.SQL.Add('`TransactionType`  as `TransactionType`,');
  Qrymain.SQL.Add('`EmployeeName`  as `EmployeeName`,');
  Qrymain.SQL.Add('`TransStatus`  as `TransStatus`,');
  Qrymain.SQL.Add('`Seqno`  as `Seqno`');
  Qrymain.SQL.Add('from '+fsQrymainTablename);
  Qrymain.SQL.Add('where TransDate between :DateFrom and :DateTo');
  Qrymain.SQL.Add('order by TransactionNo , TransactionType');
  inherited;
  CreateTempTable(False);
end;

procedure TNumberSequenceListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsQrymainTablename);
  DestroyUserTemporaryTable(fsAllTransactionsTablename);
  DestroyUserTemporaryTable(fsSingleTransactionTablename);
  inherited;
end;

function TNumberSequenceListGUI.getFilterDateFrom: TDatetime;
begin
  if chkIgnoreDates.checked then result := 0 else result := inherited getFilterDateFrom;
end;

function TNumberSequenceListGUI.getFilterdateto: TDAteTime;
begin

  if chkIgnoreDates.checked then result := incyear(Now, 100) else result := inherited getFilterDateto;
end;

procedure TNumberSequenceListGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMainTransStatus.AsString = 'Active' then begin
    SubsequentID := Chr(95) + qryMainTransactionType.AsString;
    inherited;
  end
  else
    CommonLib.MessageDlgXP_Vista('No further information available. ', mtInformation, [mbOK], 0);
end;

procedure TNumberSequenceListGUI.grpFiltersClick(Sender: TObject);
begin
  case grpFilters.ItemIndex of
    0: begin
       GroupFilterString := '';
       end;
    1: begin
       GroupFilterString := 'TransType = '+Quotedstr('S');
       end;
    2: begin
       GroupFilterString := 'TransType = '+Quotedstr('P');
       end;
    3: begin
       GroupFilterString := 'TransType = '+Quotedstr('R');
       end;
  end;
  inherited;
end;

procedure TNumberSequenceListGUI.RefreshQuery;
begin
  CloseDb(Qrymain);
  qryMain.ParamByName('DateFrom').AsDate:= FilterDateFrom;
  qryMain.ParamByName('DateTo').AsDate  := FilterDateTo;

  (*qryMain.ParamByName('DateFrom').AsDate:= FilterDateFrom;
  qryMain.ParamByName('DateTo').AsDate:= FilterDateTo;
  qryMain.ParamByName('IgnoreDates').AsString := BooleanToStr(chkIgnoreDates.Checked);
  qryMain.ParamByName('ShowSales').AsString:= 'F';
  qryMain.ParamByName('ShowPurchases').AsString:= 'F';
  case grpFilters.ItemIndex of
    0: begin
         qryMain.ParamByName('ShowSales').AsString:= 'T';
         qryMain.ParamByName('ShowPurchases').AsString:= 'T';
       end;
    1: begin
         qryMain.ParamByName('ShowSales').AsString:= 'T';
       end;
    2: begin
         qryMain.ParamByName('ShowPurchases').AsString:= 'T';
       end;
  end;*)
  inherited;
end;

initialization
  RegisterClass(TNumberSequenceListGUI);

end.
