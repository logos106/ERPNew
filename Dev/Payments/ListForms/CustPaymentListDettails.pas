unit CustPaymentListDettails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustPaymentList, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel , BaseListDetails, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustPaymentListDettailsGUI = class(TCustPaymentListGUI)
    qryMainIsSplitPay: TWideStringField;
    qryMainSplitPaymentID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainsalestotal: TFloatField;
    qryMainforeignsalestotal: TFloatField;
    qryMainSalesPayment: TFloatField;
    qryMainforeignSalesPayment: TFloatField;
    qryMainbalance: TFloatField;
    qryMainForeignbalance: TFloatField;
    qryMainSalesForeignExchangeCode: TWideStringField;
    qryMainSalesForeignExchangeRate: TFloatField;
    qryMainPaymentForeignExchangeCode: TWideStringField;
    qryMainPaymentForeignExchangeRate: TFloatField;
    qryMainPaymentForeignCurrencyAmount: TFloatField;
    qryMainForeignPaymentinsalesCurrency: TFloatField;
    qryMainForeignVariationAmount: TFloatField;
    qryMainSplitPaymentGroup: TWideStringField;
    qryMainsalegroup: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject); Override;
    procedure grdMainDblClick(Sender: TObject); Override;
    procedure FormDestroy(Sender: TObject);
  private
    //fstablename :string;
    fiSaleId: Integer;
    fstablename:String;

    Procedure makeQrymain;
    Procedure PopulateData;
  Protected
    Function ExpressDetailListName:String;override;
    procedure SetGridColumns; override;
  public
    Procedure RefreshQuery;Override;
    Property SaleId :Integer read fiSaleId write fiSaleId;
  end;


implementation

uses CommonLib, MySQLConst, DbSharedObjectsObj, CommonDbLib, LogLib, tcConst;

{$R *.dfm}

function TCustPaymentListDettailsGUI.ExpressDetailListName: String;
begin
  Result := 'TCustPaymentListGUI';
end;

procedure TCustPaymentListDettailsGUI.FormCreate(Sender: TObject);
begin
  SaleId := 0;
  MakeQrymain;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
end;

procedure TCustPaymentListDettailsGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  DeleteTable(fstablename+'1');
  DeleteTable(fstablename+'2');
  DeleteTable(fstablename+'3');
  inherited;
end;

procedure TCustPaymentListDettailsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainSplitPaymentGroup.asBoolean then begin
    if sametext(field.fieldname , QrymainSplitpaymentId.fieldname) then begin
        Afont.color := abrush.color;
       end;
  end;
  if qryMainsalegroup.asBoolean then begin
    if sametext(field.fieldname , QrymainSaleID.fieldname) or
       sametext(field.fieldname , qrymainCustomerName.fieldname) or
       sametext(field.fieldname , Qrymainsalestotal.fieldname) or
       sametext(field.fieldname , Qrymainforeignsalestotal.fieldname) or
       sametext(field.fieldname , QrymainSalesPayment.fieldname) or
       sametext(field.fieldname , QrymainforeignSalesPayment.fieldname) or
       sametext(field.fieldname , Qrymainbalance.fieldname) or
       sametext(field.fieldname , QrymainForeignbalance.fieldname) or
       sametext(field.fieldname , QrymainSalesForeignExchangeCode.fieldname) or
       sametext(field.fieldname , QrymainSalesForeignExchangeRate.fieldname) then begin
      Afont.color := abrush.color;
    end;

  end;
end;

procedure TCustPaymentListDettailsGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := '';
  if QrymainsaleId.asinteger <> 0 then
    if (grdMain.GetActiveField = qryMainSaleID) or
       (grdMain.GetActiveField = qryMainsalestotal) or
       (grdMain.GetActiveField = qryMainforeignsalestotal) or
       (grdMain.GetActiveField = qryMainSalesPayment) or
       (grdMain.GetActiveField = qryMainforeignSalesPayment) or
       (grdMain.GetActiveField = qryMainbalance) or
       (grdMain.GetActiveField = qryMainForeignbalance) or
       (grdMain.GetActiveField = qryMainSalesForeignExchangeCode) or
       (grdMain.GetActiveField = qryMainSalesForeignExchangeRate) then
          SubsequentID := Chr(95) + 'Invoice';
  inherited;
end;

procedure TCustPaymentListDettailsGUI.grpFiltersClick(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TCustPaymentListDettailsGUI.makeQrymain;
begin
  fsTablename := CommonDbLib.GetUserTemporaryTableName('cpdl' );
  Qrymain.sql.clear;
  Qrymain.sql.add('select');
  Qrymain.sql.add('*');
  Qrymain.sql.add('from '+ fstablename);
  Qrymain.sql.add('Order by SaleID, PaymentDate , SplitPaymentID, PaymentID');
end;

procedure TCustPaymentListDettailsGUI.PopulateData;
function ShowDeletedfiltedFilter:String;
begin
       if grpfilters.itemindex =0  then Result := 'F'
  else if grpfilters.itemindex =1  then Result := 'T'
  else Result := '';
end;
begin
  With scriptmain do begin
    SQL.clear;
    SQL.add('DROP   TABLE if exists '+ fstablename+'1;');
    SQL.add('CREATE TABLE '+ fstablename+'1 like tblsplitpaymentlines;');
    SQL.add('ALTER TABLE  '+ fstablename+'1 ADD COLUMN saleId INT(11) NULL DEFAULT 0;');
    SQL.add('ALTER TABLE  '+ fstablename+'1 ADD INDEX `SaleIDndex` (`SaleID`);');
    {splitpayments}
    SQL.add('insert ignore into '+ fstablename+'1 ' +
                ' select SP.saleId , ' +
                ' SPL.* ' +
                ' from tblsales S ' +
                ' inner join tbldepositline       DL  on S.saleId     = DL.SaleID ' +
                ' inner join tbldeposits          D   on D.PaymentID  = DL.PaymentID ' +
                ' INNER JOIN tblsplitpayments     SP  on SP.SaleID    = S.SaleID ' +
                ' inner join tblsplitpaymentlines SPL on SP.SplitPaymentID = SPL.SplitPaymentID and D.SplitPaymentID = SPL.SplitPaymentID and D.SplitPaymentLineID = SPL.SplitPaymentLineID ' +
				    ' Where D.PaymentDate  Between '+ quotedStr(FormatDateTime(MysqlDateFormat , Filterdatefrom))+ ' and  ' + quotedStr(FormatDateTime(MysqlDateFormat , FilterDateto)) +
				    ' and (' + inttostr(SaleID)+'=0 or S.sAleID = ' + inttostr(SaleID)+')  '+
				    '  and ('+ quotedstr(ShowDeletedfiltedFilter)+'  ="" or D.Deleted ='+ quotedstr(ShowDeletedfiltedFilter)+'); ');

    SQL.add(' DROP   TABLE if exists '+ fstablename+'2; ' +
            ' CREATE TABLE '+ fstablename+'2 (   ' +
            ' Id 														INT(11) 	NOT NULL AUTO_INCREMENT,  ' +
            ' CustomerName 									VARCHAR(255) 	NULL DEFAULT NULL,  ' +
            ' JobName 											VARCHAR(255) 	NULL DEFAULT NULL, ' +
            ' PrintJobName 									VARCHAR(255) 	NULL DEFAULT NULL,  ' +
            ' OpeningBalance 								DOUBLE 				NULL DEFAULT 0,  ' +
            ' Notes 												VARCHAR(255) 	NULL DEFAULT NULL,  ' +
            ' BankAccount 									VARCHAR(255) 	NULL DEFAULT NULL,  ' +
            ' Department 										VARCHAR(255) 	NULL DEFAULT "",  ' +
            ' Deleted 											ENUM("T","F") NULL DEFAULT "F" ,  ' +
            ' ClassID 											INT(11) 			NULL DEFAULT NULL,  ' +
            ' ClientID 											INT(11) 			NULL DEFAULT NULL,  ' +
            ' EmployeeID 										INT(11) 			NULL DEFAULT NULL,  ' +
            ' AccountID 										INT(11) 			NULL DEFAULT NULL,  ' +
            ' GlobalRef 										VARCHAR(255) 	NULL DEFAULT NULL,  ' +
            ' IsSplitPay 										VARCHAR(1) 		NULL DEFAULT "",  ' +
            ' SplitPaymentID 								INT(11) 			NULL DEFAULT 0,  ' +
            ' SaleID 												INT(11) 			NULL DEFAULT 0,  ' +
            ' salestotal 										DOUBLE 				NULL DEFAULT 0,  ' +
            ' foreignsalestotal 						DOUBLE 				NULL DEFAULT 0,  ' +
            ' SalesPayment 									DOUBLE 				NULL DEFAULT 0,  ' +
            ' foreignSalesPayment 					DOUBLE 				NULL DEFAULT 0,  ' +
            ' balance 											DOUBLE 				NULL DEFAULT 0,  ' +
            ' Foreignbalance 								DOUBLE 				NULL DEFAULT 0, ' +
            ' PaymentID 										INT(11) 			NULL DEFAULT 0,  ' +
            ' ReferenceNo 									VARCHAR(255) 	NULL DEFAULT NULL,  ' +
            ' ReceiptNo 										VARCHAR(255) 	NULL DEFAULT NULL,  ' +
            ' PaymentDate 									DATETIME 			NULL DEFAULT NULL,  ' +
            ' SalesForeignExchangeCode 			VARCHAR(3) 		NULL DEFAULT NULL,  ' +
            ' SalesForeignExchangeRate 			DOUBLE 				NULL DEFAULT 0, ' +
            ' PayMethodID                   INT(11)       NULL DEFAULT 0, ' +
            ' SplitPaymentLineID            INT(11)       NULL DEFAULT 0, ' +
            ' PaymentMethod 								VARCHAR(255) 	NULL DEFAULT NULL,  ' +
            ' PaymentForeignExchangeCode 		VARCHAR(3) 		NULL DEFAULT NULL,  ' +
            ' PaymentForeignExchangeRate 		DOUBLE 				NULL DEFAULT NULL,  ' +
            ' PaymentForeignCurrencyAmount 	DOUBLE 				NULL DEFAULT NULL,  ' +
            ' PaymentAmount 								DOUBLE 				NULL DEFAULT NULL,  ' +
            ' ForeignPaymentinsalesCurrency DOUBLE 				NULL DEFAULT 0,  ' +
            ' ForeignVariationAmount 				DOUBLE 				NULL DEFAULT 0,  ' +
          ' PRIMARY KEY (Id) ) COLLATE="utf8_general_ci" ENGINE=MyISAM ;');

    SQL.add('ALTER TABLE '+ fstablename+'2 	ADD INDEX clientIDIDX     ( clientID);');
    SQL.add('ALTER TABLE '+ fstablename+'2 	ADD INDEX PayMethodIDIDX  ( PayMethodID );');
    SQL.add('ALTER TABLE '+ fstablename+'2 	ADD INDEX AccountIDIDX    ( AccountID);');
    SQL.add('ALTER TABLE '+ fstablename+'2 	ADD INDEX ClassIDIDX      ( ClassID);');

    SQL.add('insert ignore into   '+ fstablename+'2 ' +
                ' ( CustomerName,OpeningBalance,Notes,Deleted,ClassID,ClientID,EmployeeID,AccountID,GlobalRef,IsSplitPay,SplitPaymentID,SaleID,' +
                ' salestotal,foreignsalestotal,SalesPayment,foreignSalesPayment,balance,Foreignbalance,PaymentID,ReferenceNo,ReceiptNo,PaymentDate,' +
                ' SalesForeignExchangeCode,Paymethodid,PaymentMethod, SplitPaymentLineID, SalesForeignExchangeRate,PaymentForeignExchangeCode,' +
                ' PaymentForeignExchangeRate,PaymentForeignCurrencyAmount,PaymentAmount,ForeignPaymentinsalesCurrency,ForeignVariationAmount) ' +
                ' Select ' +
                ' S.CustomerName                    as CustomerName, ' +
                ' D.Balance                         as OpeningBalance, ' +
                ' D.Notes                           as Notes, ' +
                ' D.Deleted                         as Deleted , ' +
                ' D.ClassID                         as ClassID, ' +
                ' D.CusID                           as ClientID, ' +
                ' D.EmployeeID                      as EmployeeID, ' +
                ' D.AccountID                       as AccountID, ' +
                ' D.GlobalRef                       as GlobalRef, ' +
                ' "T"                               as IsSplitPay,   ' +
                ' SPL.SplitPaymentID                as SplitPaymentID, ' +
                ' S.saleID                          as SaleID, ' +
                ' S.TotalAmountInc                  as salestotal, ' +
                ' S.ForeignTotalAmount              as foreignsalestotal, ' +
                ' S.Payment                         as SalesPayment, ' +
                ' S.ForeignPaidAmount               as foreignSalesPayment, ' +
                ' S.Balance                         as balance, ' +
                ' S.ForeignBalanceAmount            as Foreignbalance, ' +
                ' D.PaymentID                       as PaymentID, ' +
                ' D.ReferenceNo                     as ReferenceNo, ' +
                ' convert(D.PaymentNo , char(255))  as ReceiptNo, ' +
                ' convert(D.PaymentDate,datetime)   as PaymentDate, ' +
                ' S.ForeignExchangeCode             as SalesForeignExchangeCode, ' +
                ' S.ForeignExchangeRate             as SalesForeignExchangeRate, ' +
                ' D.PayMethodID                     as PayMethodID, ' +
                ' SPL.PayMethod                     as PaymentMethod, ' +
                ' SPL.SplitPaymentLineID            as SplitPaymentLineID, ' +
                ' SPL.ForeignExchangeCode           as PaymentForeignExchangeCode, ' +
                ' SPL.ForeignExchangeRate           as PaymentForeignExchangeRate, ' +
                ' SPL.ForeignCurrencyAmount         as PaymentForeignCurrencyAmount, ' +
                ' SPL.Amount                        as PaymentAmount, ' +
                ' DL.ForeignPayment                 as ForeignPaymentinsalesCurrency,   ' +
                ' D.ForeignVariationAmount          as ForeignVariationAmount ' +
                ' From tblsales S ' +
                ' inner join tbldepositline    DL  on S.saleId = DL.SaleID ' +
                ' inner join tbldeposits       D   on D.PaymentID = DL.PaymentID ' +
                ' inner join '+ fstablename+'1 SPL on SPL.SaleID = S.SaleID and D.SplitPaymentID = SPL.SplitPaymentID and D.SplitPaymentLineID = SPL.SplitPaymentLineID ' +
				    ' Where D.PaymentDate  Between '+ quotedStr(FormatDateTime(MysqlDateFormat , Filterdatefrom))+ ' and  ' + quotedStr(FormatDateTime(MysqlDateFormat , FilterDateto)) +
				    ' and (' + inttostr(SaleID)+'=0 or S.sAleID = ' + inttostr(SaleID)+')  '+
				    ' and ('+ quotedstr(ShowDeletedfiltedFilter)+'  ="" or D.Deleted ='+ quotedstr(ShowDeletedfiltedFilter)+'); ');

    SQL.add('insert ignore into   '+ fstablename+'2 ' +
                ' ( CustomerName,OpeningBalance,Notes,Deleted,ClassID,ClientID,EmployeeID,AccountID,GlobalRef,IsSplitPay,SplitPaymentID,SaleID,' +
                ' salestotal,foreignsalestotal,SalesPayment,foreignSalesPayment,balance,Foreignbalance,PaymentID,ReferenceNo,ReceiptNo,PaymentDate,' +
                ' SalesForeignExchangeCode,Paymethodid,PaymentMethod, SplitPaymentLineID, SalesForeignExchangeRate,PaymentForeignExchangeCode,PaymentForeignExchangeRate,' +
                ' PaymentForeignCurrencyAmount,PaymentAmount,ForeignPaymentinsalesCurrency,ForeignVariationAmount) ' +
                ' Select ' +
                ' S.CustomerName                    as CustomerName, ' +
                ' D.Balance                         as OpeningBalance, ' +
                ' D.Notes                           as Notes, ' +
                ' D.Deleted                         as Deleted , ' +
                ' D.ClassID                         as ClassID, ' +
                ' D.CusID                           as ClientID, ' +
                ' D.EmployeeID                      as EmployeeID, ' +
                ' D.AccountID                       as AccountID, ' +
                ' D.GlobalRef                       as GlobalRef, ' +
                ' "F"                               as IsSplitPay,   ' +
                ' 0                                 as SplitPaymentID, ' +
                ' S.saleID                          as SaleID, ' +
                ' S.TotalAmountInc                  as salestotal, ' +
                ' S.ForeignTotalAmount              as foreignsalestotal, ' +
                ' S.Payment                         as SalesPayment, ' +
                ' S.ForeignPaidAmount               as foreignSalesPayment, ' +
                ' S.Balance                         as balance, ' +
                ' S.ForeignBalanceAmount            as Foreignbalance, ' +
                ' D.PaymentID                       as PaymentID, ' +
                ' D.ReferenceNo                     as  ReferenceNo, ' +
                ' convert(D.PaymentNo , char(255))  as ReceiptNo, ' +
                ' convert(D.PaymentDate,datetime)   as PaymentDate, ' +
                ' S.ForeignExchangeCode             as SalesForeignExchangeCode, ' +
                ' S.ForeignExchangeRate             as SalesForeignExchangeRate, ' +
                ' D.PayMethodID                     as PayMethodID, ' +
                ' SPL.PayMethod                     as PaymentMethod, ' +
                ' SPL.SplitPaymentLineID            as SplitPaymentLineID, ' +
                ' D.ForeignExchangeCode             as PaymentForeignExchangeCode, ' +
                ' D.ForeignExchangeRate             as PaymentForeignExchangeRate, ' +
                ' D.ForeignCurrencyAmount           as PaymentForeignCurrencyAmount, ' +
                ' D.Amount                          as PaymentAmount, ' +
                ' DL.ForeignPayment                 as ForeignPaymentinsalesCurrency,   ' +
                ' D.ForeignVariationAmount          as ForeignVariationAmount ' +
                ' From tblsales S ' +
                ' inner join tbldepositline   DL  on S.saleId = DL.SaleID ' +
                ' inner join tbldeposits      D   on D.PaymentID = DL.PaymentID ' +
                ' Left join '+ fstablename+'1 SPL on SPL.SaleID = S.SaleID and D.SplitPaymentID = SPL.SplitPaymentID and D.SplitPaymentLineID = SPL.SplitPaymentLineID ' +
				    ' Where D.PaymentDate  Between '+ quotedStr(FormatDateTime(MysqlDateFormat , Filterdatefrom))+ ' and  ' + quotedStr(FormatDateTime(MysqlDateFormat , FilterDateto)) +
				    ' and (' + inttostr(SaleID)+'=0 or S.sAleID = ' + inttostr(SaleID)+')  '+
				    ' and ('+ quotedstr(ShowDeletedfiltedFilter)+'  ="" or D.Deleted ='+ quotedstr(ShowDeletedfiltedFilter)+'); ');

    SQL.add('update '+ fstablename+'2 T inner join tblclients CL on CL.clientId = T.clientID Set ' +
                ' T.jobname =CL.JobName , ' +
                ' T.PrintJobName =CL.PrintJobName ;    ');

    SQL.add('update '+ fstablename+'2 T inner join tblpaymentmethods  PM    on PM.PayMethodID = T.PayMethodID   Set ' +
                ' T.PaymentMethod = PM.NAME where ifnull(T.PaymentMethod, "")=""  ;  ');

    SQL.add('update '+ fstablename+'2 T inner join tblchartofaccounts COA   ON COA.AccountID=T.AccountID   Set ' +
                ' T.BankAccount =COA.accountname ;       ');

    SQL.add('update '+ fstablename+'2 T inner join tblclass           C     ON C.ClassID= T.ClassID   Set ' +
                ' Department = C.ClassName ;   ');

    SQL.add('DROP   TABLE if exists '+ fstablename+';');
    SQL.add('CREATE TABLE '+ fstablename+' like '+ fstablename+'2;');
    SQL.add('ALTER TABLE '+ fstablename+' add column aSaleGroup 									VARCHAR(1) 		NULL DEFAULT "";');
    SQL.add('ALTER TABLE '+ fstablename+' add column aSaleId 											INT(11) 			NULL DEFAULT 0;');
    SQL.add('ALTER TABLE '+ fstablename+' add column aSplitPaymentGroup 					VARCHAR(1) 		NULL DEFAULT "";');
    SQL.add('ALTER TABLE '+ fstablename+' add column aSplitPaymentID 							INT(11) 			NULL DEFAULT NULL;');

    SQL.add('insert ignore into   '+ fstablename+'( aSaleGroup,aSaleId,aSplitPaymentGroup,aSplitPaymentID,CustomerName,JobName,PrintJobName,OpeningBalance,Notes,BankAccount,Department,' +
                ' Deleted,ClassID,ClientID,EmployeeID,AccountID,GlobalRef,IsSplitPay,SplitPaymentID,SaleID,salestotal,foreignsalestotal,SalesPayment,foreignSalesPayment,balance,Foreignbalance,' +
                ' PaymentID,ReferenceNo,ReceiptNo,PaymentDate,SalesForeignExchangeCode,SalesForeignExchangeRate,PaymentMethod,PaymentForeignExchangeCode,PaymentForeignExchangeRate,' +
                ' PaymentForeignCurrencyAmount,PaymentAmount,ForeignPaymentinsalesCurrency,ForeignVariationAmount) ' +
                ' Select   @SaleGroup:=if(@SaleId <> T.SaleId,  "F",  "T") as SaleGroup , ' +
                '           @SaleId := T.SaleId,   @SplitPaymentGroup:=if(@SplitPaymentID <> T.SplitPaymentID ,  "F",  "T") as SplitPaymentGroup , ' +
                '           @SplitPaymentID := T.SplitPaymentID as aSplitPaymentID, ' +
                ' T.CustomerName,T.JobName,T.PrintJobName,T.OpeningBalance,T.Notes,T.BankAccount,T.Department,T.Deleted,T.ClassID,T.ClientID,T.EmployeeID,T.AccountID,' +
                ' T.GlobalRef,T.IsSplitPay,T.SplitPaymentID,T.SaleID,T.salestotal,T.foreignsalestotal,T.SalesPayment,T.foreignSalesPayment,T.balance,T.Foreignbalance,' +
                ' T.PaymentID,T.ReferenceNo,T.ReceiptNo,T.PaymentDate,T.SalesForeignExchangeCode,T.SalesForeignExchangeRate,T.PaymentMethod,T.PaymentForeignExchangeCode,' +
                ' T.PaymentForeignExchangeRate,T.PaymentForeignCurrencyAmount,T.PaymentAmount,T.ForeignPaymentinsalesCurrency,T.ForeignVariationAmount ' +
                ' From  (SELECT @SaleId:=0) s1, ' +
                ' (SELECT @SplitPaymentID:=0) s2, ' +
                ' '+ fstablename+'2 as T ' +
                ' Order by T.SaleID, PaymentDate , T.SplitPaymentID, T.PaymentID ;');

    (*SQL.add('DROP   TABLE if exists '+ fstablename+';');
    SQL.add('CREATE TABLE '+ fstablename+' (  ' +
				    ' Id 														INT(11) 	NOT NULL AUTO_INCREMENT, ' +
				    ' aSaleGroup 										VARCHAR(1) 		NULL DEFAULT "", ' +
				    ' aSaleId 											INT(11) 			NULL DEFAULT 0, ' +
				    ' aSplitPaymentGroup 						VARCHAR(1) 		NULL DEFAULT "",' +
				    ' aSplitPaymentID 							INT(11) 			NULL DEFAULT NULL, ' +
				    ' CustomerName 									VARCHAR(255) 	NULL DEFAULT NULL, ' +
				    ' JobName 											VARCHAR(255) 	NULL DEFAULT NULL,' +
				    ' PrintJobName 									VARCHAR(255) 	NULL DEFAULT NULL, ' +
				    ' OpeningBalance 								DOUBLE 				NULL DEFAULT 0, ' +
				    ' Notes 												VARCHAR(255) 	NULL DEFAULT NULL, ' +
				    ' BankAccount 									VARCHAR(255) 	NULL DEFAULT NULL, ' +
				    ' Department 										VARCHAR(255) 	NULL DEFAULT "", ' +
				    ' Deleted 											ENUM("T","F") NULL DEFAULT "F" , ' +
				    ' ClassID 											INT(11) 			NULL DEFAULT NULL, ' +
				    ' ClientID 											INT(11) 			NULL DEFAULT NULL, ' +
				    ' EmployeeID 										INT(11) 			NULL DEFAULT NULL, ' +
				    ' AccountID 										INT(11) 			NULL DEFAULT NULL, ' +
				    ' GlobalRef 										VARCHAR(255) 	NULL DEFAULT NULL, ' +
				    ' IsSplitPay 										VARCHAR(1) 		NULL DEFAULT "", ' +
				    ' SplitPaymentID 								INT(11) 			NULL DEFAULT 0, ' +
				    ' SaleID 												INT(11) 			NULL DEFAULT 0, ' +
				    ' salestotal 										DOUBLE 				NULL DEFAULT 0, ' +
				    ' foreignsalestotal 						DOUBLE 				NULL DEFAULT 0, ' +
				    ' SalesPayment 									DOUBLE 				NULL DEFAULT 0, ' +
				    ' foreignSalesPayment 					DOUBLE 				NULL DEFAULT 0, ' +
				    ' balance 											DOUBLE 				NULL DEFAULT 0, ' +
				    ' Foreignbalance 								DOUBLE 				NULL DEFAULT 0,' +
				    ' PaymentID 										INT(11) 			NULL DEFAULT 0, ' +
				    ' ReferenceNo 									VARCHAR(255) 	NULL DEFAULT NULL, ' +
				    ' ReceiptNo 										VARCHAR(255) 	NULL DEFAULT NULL, ' +
				    ' PaymentDate 									DATETIME 			NULL DEFAULT NULL, ' +
				    ' SalesForeignExchangeCode 			VARCHAR(3) 		NULL DEFAULT NULL, ' +
				    ' SalesForeignExchangeRate 			DOUBLE 				NULL DEFAULT 0, ' +
				    ' PaymentMethod 								VARCHAR(255) 	NULL DEFAULT NULL, ' +
				    ' PaymentForeignExchangeCode 		VARCHAR(3) 		NULL DEFAULT NULL, ' +
				    ' PaymentForeignExchangeRate 		DOUBLE 				NULL DEFAULT NULL, ' +
				    ' PaymentForeignCurrencyAmount 	DOUBLE 				NULL DEFAULT NULL, ' +
				    ' PaymentAmount 								DOUBLE 				NULL DEFAULT NULL, ' +
				    ' ForeignPaymentinsalesCurrency DOUBLE 				NULL DEFAULT 0, ' +
				    ' ForeignVariationAmount 				DOUBLE 				NULL DEFAULT 0, ' +
				    ' PRIMARY KEY (Id) ) COLLATE="utf8_general_ci" ENGINE=MyISAM ;');

    SQL.add('insert ignore into   '+ fstablename+
            ' ( aSaleGroup,aSaleId,aSplitPaymentGroup,aSplitPaymentID,CustomerName,JobName,PrintJobName,OpeningBalance,Notes,BankAccount,Department, '+
				    '   Deleted,ClassID,ClientID,EmployeeID,AccountID,GlobalRef,IsSplitPay,SplitPaymentID,SaleID,salestotal,foreignsalestotal,SalesPayment, '+
				    '   foreignSalesPayment,balance,Foreignbalance,PaymentID,ReferenceNo,ReceiptNo,PaymentDate,SalesForeignExchangeCode,SalesForeignExchangeRate, '+
				    '   PaymentMethod,PaymentForeignExchangeCode,PaymentForeignExchangeRate,PaymentForeignCurrencyAmount,PaymentAmount,ForeignPaymentinsalesCurrency,ForeignVariationAmount) '+
				    ' Select '+
				    '  @SaleGroup:=if(@SaleId <> S.SaleId,  "F",  "T") as SaleGroup , '+
				    '  @SaleId := s.SaleId, '+
				    '  @SplitPaymentGroup:=if(@SplitPaymentID <> SPL.SplitPaymentID ,  "F",  "T") as SplitPaymentGroup , '+
				    '  @SplitPaymentID := SPL.SplitPaymentID, '+
				    '  S.CustomerName    as CustomerName, '+
				    '  CL.JobName as JobName, '+
				    '  CL.PrintJobName as PrintJobName, '+
				    '  D.Balance         as OpeningBalance, '+
				    '  D.Notes           as Notes, '+
				    '  COA.accountname   as BankAccount, '+
				    '  C.ClassName       as Department, '+
				    '  D.Deleted         as Deleted , '+
				    '  D.ClassID         as ClassID, '+
				    '  D.CusID           as ClientID, '+
				    '  D.EmployeeID      as EmployeeID, '+
				    '  D.AccountID       as AccountID, '+
				    '  D.GlobalRef       as GlobalRef, '+
				    '  if(ifnull(SPL.SplitPaymentLineID,0)= 0, "F","T") as IsSplitPay, '+
				    '  SPL.SplitPaymentID      as SplitPaymentID, '+
				    '  S.saleID                as SaleID, '+
				    '  S.TotalAmountInc        as salestotal, '+
				    '  S.ForeignTotalAmount    as foreignsalestotal, '+
				    '  S.Payment               as SalesPayment, '+
				    '  S.ForeignPaidAmount     as foreignSalesPayment, '+
				    '  S.Balance               as balance, '+
				    '  S.ForeignBalanceAmount  as Foreignbalance, '+
				    '  D.PaymentID             as PaymentID, '+
				    '  D.ReferenceNo           as  ReferenceNo, '+
				    '  convert(D.PaymentNo , char(255))            as ReceiptNo, '+
				    '  convert(D.PaymentDate,datetime) as PaymentDate, '+
				    '  S.ForeignExchangeCode   as SalesForeignExchangeCode, '+
				    '  S.ForeignExchangeRate   as SalesForeignExchangeRate, '+
				    '  if(ifnull(SPL.SplitPaymentLineID,0)= 0, PM.NAME ,SPL.PayMethod)                             as PaymentMethod, '+
				    '  if(ifnull(SPL.SplitPaymentLineID,0)= 0, D.ForeignExchangeCode, SPL.ForeignExchangeCode)     as PaymentForeignExchangeCode, '+
				    '  if(ifnull(SPL.SplitPaymentLineID,0)= 0, D.ForeignExchangeRate, SPL.ForeignExchangeRate)     as PaymentForeignExchangeRate, '+
				    '  if(ifnull(SPL.SplitPaymentLineID,0)= 0, D.ForeignCurrencyAmount,SPL.ForeignCurrencyAmount)  as PaymentForeignCurrencyAmount, '+
				    '  if(ifnull(SPL.SplitPaymentLineID,0)= 0, D.Amount , SPL.Amount)                              as PaymentAmount, '+
				    '  DL.ForeignPayment         as ForeignPaymentinsalesCurrency, '+
				    '  D.ForeignVariationAmount  as ForeignVariationAmount '+
				    '  From  (SELECT @SaleId:=0) s1, '+
				    '  (SELECT @SplitPaymentID:=0) s2, '+
				    '  tblsales S '+
				    '  inner join tbldepositline     DL    on S.saleId = DL.SaleID '+
				    '  inner join tbldeposits        D     on D.PaymentID = DL.PaymentID '+
				    '  inner join tblclients CL on CL.clientId = D.CusID '+
				    '  inner join tblpaymentmethods  PM    on PM.PayMethodID = D.PayMethodID '+
				    '  INNER JOIN tblchartofaccounts COA   ON COA.AccountID=D.AccountID '+
				    '  INNER JOIN tblclass           C     ON C.ClassID= D.ClassID '+
				    '  Left join (tblsplitpayments   SP inner join tblsplitpaymentlines SPL on SP.SplitPaymentID = SPL.SplitPaymentID) on SP.SaleID = S.SaleID and D.SplitPaymentID = SPL.SplitPaymentID and D.SplitPaymentLineID = SPL.SplitPaymentLineID '+
				    ' Where D.PaymentDate  Between '+ quotedStr(FormatDateTime(MysqlDateFormat , Filterdatefrom))+ ' and  ' + quotedStr(FormatDateTime(MysqlDateFormat , FilterDateto)) +
				    ' and (' + inttostr(SaleID)+'=0 or S.sAleID = ' + inttostr(SaleID)+')  '+
				    '  and ('+ quotedstr(ShowDeletedfiltedFilter)+'  ="" or D.Deleted ='+ quotedstr(ShowDeletedfiltedFilter)+') '+
				    '  Order by S.SaleID, PaymentDate , SP.SplitPaymentID, D.PaymentID ;');*)
    clog(SQL.text);
    ExecutewithProgress(False);
  end;

end;
procedure TCustPaymentListDettailsGUI.RefreshQuery;
begin
  PopulateData;
  inherited;
end;
procedure TCustPaymentListDettailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainSplitPaymentGroup.fieldname);
  RemoveFieldfromGrid(qryMainsalegroup.fieldname);
end;

initialization
  RegisterClassOnce(TCustPaymentListDettailsGUI);
end.
