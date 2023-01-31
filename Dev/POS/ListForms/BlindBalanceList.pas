unit BlindBalanceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, Mask, wwdbedit,
   wwdblook, kbmMemTable, Shader, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TfrmBlindBalanceReport = class(TBaseListingGUI)
    qryMainTotalCash: TFloatField;
    qryMainPeriodID: TIntegerField;
    qryMainTillID: TIntegerField;
    qryMainTillName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainVariation: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainQtySold: TFloatField;
    qryMainTotalLineAmount: TFloatField;
    qryMainTotalAmountinc: TFloatField;
    qryMainStartDate: TDateTimeField;
    qryMainEndDate: TDateTimeField;
    qryMainHundreds: TIntegerField;
    qryMainFifties: TIntegerField;
    qryMainTwenties: TIntegerField;
    qryMainTens: TIntegerField;
    qryMainFives: TIntegerField;
    qryMainTwos: TIntegerField;
    qryMainOnes: TIntegerField;
    qryMainFiftyCents: TIntegerField;
    qryMainTwentyCents: TIntegerField;
    qryMainTenCents: TIntegerField;
    qryMainFiveCents: TIntegerField;
    qryMainEFTPOS: TFloatField;
    qryMainVisa: TFloatField;
    qryMainMasterCard: TFloatField;
    qryMainDinersClub: TFloatField;
    qryMainBankcard: TFloatField;
    qryMainAmex: TFloatField;
    qryMainCreditCard: TFloatField;
    qryMainCheques: TFloatField;
    qryMainInvoicePayments: TFloatField;
    qryMainSaleDateTime: TDateTimeField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainDetails: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fsTablename :String;
    (*procedure LoadBlindPeriodIDToSales;*)
//    function TimeOfSaleToDateTime(TimeOfSale:String):TDateTime;

    (*function GetUserTempBlindSummaryName: string;*)
    procedure CreateTempBlindSummaryTable;
    procedure AddDataToTempBlindSummaryTable;
(*    Procedure RefreshTotal;*)
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
    Procedure RefreshTotals; Override;
    Procedure CalcFooter;Override;
  public
    { Public declarations }
  end;

implementation
uses
  CommonDbLib,CommonLib, AppEnvironment, DateUtils, MySQLConst,
  DbSharedObjectsObj;

{$R *.dfm}


procedure TfrmBlindBalanceReport.FormCreate(Sender: TObject);
begin
  CreateTempBlindSummaryTable;

  Qrymain.SQL.Clear;
  Qrymain.SQL.Add('SELECT');
  Qrymain.SQL.Add('PeriodID       	        as PeriodID,');
  Qrymain.SQL.Add('T.TillID       	        as TillID,');
  Qrymain.SQL.Add('PT.TillName    	        as TillName,');
  Qrymain.SQL.Add('EmployeeName   	        as EmployeeName,');
  //Qrymain.SQL.Add('Variation as Variation,');
  Qrymain.SQL.Add('(ifnull(Hundreds,0)   *100 ) +'+
                                '(ifnull(Fifties,0)    *50  ) +'+
                                '(ifnull(Twenties,0)   *20  ) +'+
                                '(ifnull(Tens,0)       *10  ) +'+
                                '(ifnull(Fives,0)      *5   ) +'+
                                '(ifnull(Twos,0)       *2   ) +'+
                                '(ifnull(Ones,0)       *1   ) +'+
                                '(ifnull(FiftyCents,0) *0.5 ) +'+
                                '(ifnull(TwentyCents,0)*0.2 ) +'+
                                '(ifnull(TenCents,0)   *0.1 ) +'+
                                '(ifnull(FiveCents,0)  *0.05) as TotalCash,');

  Qrymain.SQL.Add('NULL                     as ProductName,');
  Qrymain.SQL.Add('Sum(QtySold)             as QtySold,');
  Qrymain.SQL.Add('sum(TotalLineAmount)     as TotalLineAmount,');
  Qrymain.SQL.Add('Sum(TotalLineAmountInc)  as TotalAmountinc,');
  Qrymain.SQL.Add('StartDate                as StartDate,');
  Qrymain.SQL.Add('EndDate                  as EndDate,');
  Qrymain.SQL.Add('Hundreds                 as Hundreds, ');
  Qrymain.SQL.Add('Fifties                  as Fifties,');
  Qrymain.SQL.Add('Twenties                 as Twenties,');
  Qrymain.SQL.Add('Tens	                    as	Tens	,');
  Qrymain.SQL.Add('Fives	                  as	Fives	,');
  Qrymain.SQL.Add('Twos	                    as	Twos	,');
  Qrymain.SQL.Add('Ones	                    as	Ones	,');
  Qrymain.SQL.Add('FiftyCents	              as	FiftyCents	,');
  Qrymain.SQL.Add('TwentyCents	            as	TwentyCents	,');
  Qrymain.SQL.Add('TenCents	                as	TenCents	,');
  Qrymain.SQL.Add('FiveCents	              as	FiveCents	,');
  Qrymain.SQL.Add('EFTPOS	                  as	EFTPOS	,');
  Qrymain.SQL.Add('Visa	                    as	Visa	,');
  Qrymain.SQL.Add('MasterCard		            as	MasterCard	,');
  Qrymain.SQL.Add('DinersClub		            as	DinersClub	,');
  Qrymain.SQL.Add('Bankcard		              as	Bankcard	,');
  Qrymain.SQL.Add('Amex		                  as	Amex	,');
  Qrymain.SQL.Add('CreditCard		            as	CreditCard	,');
  Qrymain.SQL.Add('Cheques		              as	Cheques	,');
  Qrymain.SQL.Add('InvoicePayments		      as	InvoicePayments	,');
  Qrymain.SQL.Add('NULL  	                  as SaleDateTime,');
  Qrymain.SQL.Add('NULL  	                  as InvoiceDocNumber,');
  Qrymain.SQL.Add('NULL  	                  as SaleID,');
  Qrymain.SQL.Add('0  	                    as Details');
  Qrymain.SQL.Add('FROM ' + fsTablename +' T');
  Qrymain.SQL.Add('LEFT JOIN tblPosTills PT on PT.TillId = T.TillId');
  //Qrymain.SQL.Add('WHERE EndDate  Between :txtfrom1  AND :txtto1');
  Qrymain.SQL.Add('GROUP BY PeriodID');
  Qrymain.SQL.Add('UNION');
  Qrymain.SQL.Add('SELECT');
  Qrymain.SQL.Add('PeriodID 	              as PeriodID,');
  Qrymain.SQL.Add('T.TillID 	              as TillID,');
  Qrymain.SQL.Add('PT.TillName 	            as TillName,');
  Qrymain.SQL.Add('SalesEmployeeName        as EmployeeName,');
  //Qrymain.SQL.Add('null 	                as Variation,');
  Qrymain.SQL.Add('null 	                  as TotalCash,');
  Qrymain.SQL.Add('ProductName 	            as ProductName,');
  Qrymain.SQL.Add('QtySold 	                as QtySold,');
  Qrymain.SQL.Add('TotalLineAmount 	        as TotalLineAmount,');
  Qrymain.SQL.Add('TotalLineAmountInc 	    as TotalLineAmountInc,');
  Qrymain.SQL.Add('NULL 	                  as StartDate,');
  Qrymain.SQL.Add('NULL 	                  as EndDate,');
  Qrymain.SQL.Add('NULL 	                  as Hundreds,');
  Qrymain.SQL.Add('NULL 	                  as Fifties,');
  Qrymain.SQL.Add('NULL 	                  as Twenties,');
  Qrymain.SQL.Add('NULL 	                  as Tens,');
  Qrymain.SQL.Add('NULL 	                  as Fives,');
  Qrymain.SQL.Add('NULL 	                  as Twos,');
  Qrymain.SQL.Add('NULL 	                  as Ones,');
  Qrymain.SQL.Add('NULL 	                  as FiftyCents,');
  Qrymain.SQL.Add('NULL 	                  as TwentyCents,');
  Qrymain.SQL.Add('NULL 	                  as TenCents,');
  Qrymain.SQL.Add('NULL 	                  as FiveCents,');
  Qrymain.SQL.Add('NULL  	                  as EFTPOS,');
  Qrymain.SQL.Add('NULL  	                  as Visa,');
  Qrymain.SQL.Add('NULL  	                  as MasterCard,');
  Qrymain.SQL.Add('NULL  	                  as DinersClub,');
  Qrymain.SQL.Add('NULL  	                  as Bankcard,');
  Qrymain.SQL.Add('NULL  	                  as Amex,');
  Qrymain.SQL.Add('NULL  	                  as CreditCard,');
  Qrymain.SQL.Add('NULL  	                  as Cheques,');
  Qrymain.SQL.Add('NULL  	                  as InvoicePayments,');
  Qrymain.SQL.Add('SaleDateTime 	          as SaleDateTime,');
  Qrymain.SQL.Add('InvoiceDocNumber 	      as InvoiceDocNumber,');
  Qrymain.SQL.Add('SaleID 	                as SaleID,');
  Qrymain.SQL.Add('1 	                      as Details');
  Qrymain.SQL.Add('From ' + fsTablename +' T');
  Qrymain.SQL.Add('LEFT JOIN tblPosTills PT on PT.TillId = T.TillId');
  //Qrymain.SQL.Add('WHERE SaleDateTime Between :txtfrom AND :txtTo');
  Qrymain.SQL.Add('GROUP BY SaleID, ProductName');
  Qrymain.SQL.Add('ORDER BY PeriodID,SaleID, ProductName');
  inherited;
  AddCalccolumn(qryMainTotalCash.fieldName      , True);
  AddCalccolumn(qryMainVariation.fieldName      , True);
  AddCalccolumn(qryMainQtySold.fieldName        , False);
  AddCalccolumn(qryMainTotalLineAmount.fieldName, True);
  AddCalccolumn(qryMainTotalAmountinc.fieldName , True);
  AddCalccolumn(qryMainHundreds.fieldName       , False);
  AddCalccolumn(qryMainFifties.fieldName        , False);
  AddCalccolumn(qryMainTwenties.fieldName       , False);
  AddCalccolumn(qryMainTens.fieldName           , False);
  AddCalccolumn(qryMainFives.fieldName          , False);
  AddCalccolumn(qryMainTwos.fieldName           , False);
  AddCalccolumn(qryMainOnes.fieldName           , False);
  AddCalccolumn(qryMainFiftyCents.fieldName     , False);
  AddCalccolumn(qryMainTwentyCents.fieldName    , False);
  AddCalccolumn(qryMainTenCents.fieldName       , False);
  AddCalccolumn(qryMainFiveCents.fieldName      , False);
  AddCalccolumn(qryMainEFTPOS.fieldName         , True);
  AddCalccolumn(qryMainVisa.fieldName           , True);
  AddCalccolumn(qryMainMasterCard.fieldName     , True);
  AddCalccolumn(qryMainDinersClub.fieldName     , True);
  AddCalccolumn(qryMainBankcard.fieldName       , True);
  AddCalccolumn(qryMainAmex.fieldName           , True);
  AddCalccolumn(qryMainCreditCard.fieldName     , True);
  AddCalccolumn(qryMainCheques.fieldName        , True);

    DonotChangeGridLabels:= True;
    (*if not ErrorOccurred then begin
    CreateTempBlindSummaryTable;
     qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'aaaaa', fsTablename);
    RefreshOrignalSQL;
     pnlHeader.Caption := 'Blind Balance Report';
  end;*)
end;

procedure TfrmBlindBalanceReport.FormDestroy(Sender: TObject);
begin
  CommonDbLib.DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TfrmBlindBalanceReport.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: GroupFilterString := '(Details = 0)';
  end;
  inherited;
end;

procedure TfrmBlindBalanceReport.RefreshQuery;
begin
  Processingcursor(True);
  try
    if not ErrorOccurred then begin
       Progressdialog.DoShowProgressbar(2 , 'Please wait');
       try
        Progressdialog.DoStepProgressbar;
        AddDataToTempBlindSummaryTable;
        Progressdialog.DoStepProgressbar;
       finally
        Progressdialog.DoHideProgressbar;
       end;
    end;
  finally
    Processingcursor(False);
  end;
  {qryMain.Params.ParamByName('txtfrom').asDateTime  := (*DateUtils.StartOfTheDay(dtfrom.DateTime) *) FilterdateFrom;
  qryMain.Params.ParamByName('txtto').asDateTime    := (*DateUtils.EndOfTheDay(dtto.DateTime))    *) FilterdateTo;
  qryMain.Params.ParamByName('txtfrom1').asDateTime := (*DateUtils.StartOfTheDay(dtfrom.DateTime) *) FilterdateFrom;
  qryMain.Params.ParamByName('txtto1').asDateTime   := (*DateUtils.EndOfTheDay(dtto.DateTime))    *) FilterdateTo;}
  inherited;
(*  RefreshTotal;*)
end;

procedure TfrmBlindBalanceReport.RefreshTotals;
begin
  CalcnShowFooter;
end;

procedure TfrmBlindBalanceReport.FormShow(Sender: TObject);
begin
  inherited;
  (*Processingcursor(True);
  try
    if not ErrorOccurred then begin
       Progressdialog.DoShowProgressbar(2 , 'Please wait');
       try
        Progressdialog.DoStepProgressbar;
        AddDataToTempBlindSummaryTable;
        Progressdialog.DoStepProgressbar;
        RefreshQuery;
       finally
        Progressdialog.DoHideProgressbar;
       end;
    end;
  finally
    Processingcursor(False);
  end;*)
end;

procedure TfrmBlindBalanceReport.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }

  if sametext(Field.FieldName , qrymainVariation.FieldName) then begin
      if (Field.asFloat > 0.00) then
        ABrush.Color := $00EAAA8E//clBlue;
      else if (Field.asFloat < 0.00) then
        ABrush.Color := $009A75F0;//clRed;
  End;

  if Sametext(field.fieldname , QrymainInvoiceDocNumber.fieldname) or
      Sametext(field.fieldname , QrymainSaleDateTime.fieldname) or
      Sametext(field.fieldname , QrymainProductName.fieldname) or
      Sametext(field.fieldname , QrymainQtySold.fieldname) or
      Sametext(field.fieldname , QrymainInvoicePayments.fieldname) or
      Sametext(field.fieldname , QrymainTotalLineAmount.fieldname) or
      Sametext(field.fieldname , QrymainTotalAmountinc.fieldname) then Abrush.color := $00B9FFFF;

  if Sametext(field.fieldname , QrymainHundreds.fieldname) or
      Sametext(field.fieldname , QrymainFifties.fieldname) or
      Sametext(field.fieldname , QrymainTwenties.fieldname) or
      Sametext(field.fieldname , QrymainTens.fieldname) or
      Sametext(field.fieldname , QrymainFives.fieldname) or
      Sametext(field.fieldname , QrymainTwos.fieldname) or
      Sametext(field.fieldname , QrymainOnes.fieldname) or
      Sametext(field.fieldname , QrymainFiftyCents.fieldname) or
      Sametext(field.fieldname , QrymainTwentyCents.fieldname) or
      Sametext(field.fieldname , QrymainTenCents.fieldname) or
      Sametext(field.fieldname , QrymainFiveCents.fieldname) or
      Sametext(field.fieldname , QrymainEFTPOS.fieldname) or
      Sametext(field.fieldname , QrymainVisa.fieldname) or
      Sametext(field.fieldname , QrymainMasterCard.fieldname) or
      Sametext(field.fieldname , QrymainDinersClub.fieldname) or
      Sametext(field.fieldname , QrymainBankcard.fieldname) or
      Sametext(field.fieldname , QrymainAmex.fieldname) or
      Sametext(field.fieldname , QrymainCreditCard.fieldname) or
      Sametext(field.fieldname , QrymainCheques.fieldname) or
      Sametext(field.fieldname , QrymainTotalCash.fieldname) then ABrush.color :=   $00E4FFCA;

  if (QrymainDEtails.asInteger = 0) and (grpfilters.ItemIndex =1 ) then AFont.Style := AFont.Style + [fsBold];
  if (Field is TFloatfield) and (Field.asfloat =0 )then AFont.Color := ABrush.Color;
  if (Field is TIntegerField) and (Field.asInteger =0) then AFont.Color := ABrush.Color;


(*  if ((SameText(Field.FieldName , 'QtySold'))         and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'TotalLineAmount')) and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'SaleID'))          and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'InvoiceDocNumber'))and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'TotalAmountinc'))  and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'PeriodTotal'))     and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Variation'))       and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Hundreds'))        and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Fifties'))         and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Twenties'))        and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Tens'))            and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Fives'))           and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Twos'))            and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'Ones'))            and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'fiftyCents'))      and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'TwentyCents'))     and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'TenCents'))        and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'fiveCents'))       and (Field.Text = '0')) OR
     ((SameText(Field.FieldName , 'EFTPOS'))          and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Visa'))            and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'MasterCard'))      and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'DinersClub'))      and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Bankcard'))        and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Amex'))            and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'CreditCard'))      and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'Cheques'))         and (Field.Value = 0))  OR
     ((SameText(Field.FieldName , 'InvoicePayments')) and (Field.Value = 0))  OR
     ((Qrymaindetails.asInteger = 1 )         and (SameText(Field.fieldName , 'PeriodName'))) Or
     ((Qrymaindetails.asInteger = 1 )         and (SameText(Field.fieldName , 'PeriodNumber'))) Or
     ((Qrymaindetails.asInteger = 1 )         and (SameText(Field.fieldName , 'Tillname'))) Or
     ((Qrymaindetails.asInteger = 1 )         and (SameText(Field.fieldName , 'PeriodTotal'))) then
      AFont.Color := ABrush.Color;*)
end;


//function TfrmBlindBalanceReport.TimeOfSaleToDateTime(TimeOfSale:String):TDateTime;
//var
//
//  sTemp: String;
////  iHour: integer;
//  wHour, wMin, wSecs : word;
//  sMinute,sSecond: String;
//  iPosition: integer;
//
//begin
//
//  iPosition := FastFuncs.PosEx(':',TimeOfSale);
//  if iPosition > 2 then begin       //hrs over 9
//    sTemp := Copy(TimeOfSale, 0, 2);
//
//    sMinute := Copy(TimeOfSale, 4, 2);
//    sSecond := Copy(TimeOfSale, 7, 2);
//  end else begin
//    sTemp := Copy(TimeOfSale, 0, 1);
//
//    sMinute := Copy(TimeOfSale, 3, 2);
//    sSecond := Copy(TimeOfSale, 6, 2);
//  end;
//  wHour := FastFuncs.StrToInt(sTemp);
//
//  //is it Am or pm
//  if FastFuncs.PosEx('P',TimeOfSale) > 0 then begin
//    if wHour < 12 then   wHour := wHour + 12;
//  end;
//
//  wMin := FastFuncs.StrToInt(sMinute);
//  wSecs:= FastFuncs.StrToInt(sSecond);
//
//  result := SysUtils.EncodeTime(wHour, wMin, wSecs,0);
//
//end;


{procedure TfrmBlindBalanceReport.LoadBlindPeriodIDToSales;
var
  cmd           : TERPCommand;
begin

  cmd := DbSharedObj.GetCommand(CommonDbLib.GetSharedMyDacConnection);
  try
    with cmd do begin
      SQL.Clear;
    (*SQL.Add('UPDATE '+  fsTablename +' SET SaleDateTime= ');
    SQL.Add('If(POSITION("PM" IN TimeOfSale)>0,');
    SQL.Add('DATE_ADD(DATE_FORMAT(Concat(DATE_FORMAT(SaleDate,"%Y-%m-%d ")  ,trim(Replace(TimeOfSale,"PM" , ""))),"%Y-%m-%d %k:%i:%s"),INTERVAL 12 HOUR),');
    SQL.Add('DATE_ADD(DATE_ADD(DATE_FORMAT(Concat(DATE_FORMAT(SaleDate,"%Y-%m-%d ")  ,trim(Replace(TimeOfSale,"AM" , ""))),"%Y-%m-%d %k:%i:%s"),INTERVAL 1 SECOND),INTERVAL -1 SECOND));');*)

      SQL.Add('UPDATE ');
      SQL.Add((*GetUserTempBlindSummaryName*) fsTablename+' BS');
      SQL.Add('Inner Join tblpostilleop ');
      SQL.Add('ON  BS.SaleDateTime >= tblpostilleop.Start ');
      SQL.Add('AND BS.SaleDateTime <= tblpostilleop.EndDate ');
      SQL.Add('and BS.TillId =  tblpostilleop.tillId');

      SQL.Add('SET ');
      SQL.Add('BS.PeriodID = tblpostilleop.PeriodID, ');
      SQL.Add('BS.PeriodTotal = tblpostilleop.PeriodTotal ');
      //SQL.Add('BS.Variation = tblpostilleop.Variation ');

      Sql.Add('WHERE tblpostilleop.Start Between ');
      SQL.Add(QuotedStr(FormatDateTime(MySQLDAtetimeformat, filterDateFrom)));
      SQL.Add(' AND ');
      SQL.Add(QuotedStr(FormatDateTime(MySQLdateTimeformat, filterDateTo)));
      Execute;
    end;
  finally
    DbSharedObj.releaseobj(cmd);
  end;
end;  }

(*function TfrmBlindBalanceReport.GetUserTempBlindSummaryName: string;
begin
  Result := 'tmp_BlindSummary_' + GetMachineIdentification(true, true, true, true);
end;*)

procedure TfrmBlindBalanceReport.CalcFooter;
begin
  if Qrymaindetails.asFloat<> 0 then exit;
  inherited;

end;

procedure TfrmBlindBalanceReport.CreateTempBlindSummaryTable;
var
  cmd: TERPCommand;
begin
  fsTablename := CommonDbLib.GetUserTemporaryTableName('tmp_BlindSummary');

  cmd := DbSharedObj.GetCommand(CommonDbLib.GetSharedMyDacConnection);
  try
    cmd.Sql.Clear;
    cmd.Sql.Add('DROP TABLE IF EXISTS ' + (*GetUserTempBlindSummaryName*) fsTablename + ' ;');
    cmd.Sql.Add('CREATE TABLE IF NOT EXISTS ' + (*GetUserTempBlindSummaryName*) fsTablename + ' ( ');
    cmd.Sql.Add('`ID`                 int(11) NOT NULL auto_increment, ');
    cmd.Sql.Add('`PeriodID`           int(11) default "0" , ');
    cmd.Sql.Add('`TillID`             int(11) default NULL, ');
    cmd.Sql.Add('`StartDate`          datetime default NULL, ');
    cmd.Sql.Add('`EndDate`            datetime default NULL, ');
    cmd.Sql.Add('`EmployeeName`       varchar(100) default NULL, ');
    cmd.Sql.Add('`SalesEmployeeName`  varchar(100) default NULL, ');
    cmd.Sql.Add('`Variation`          double default NULL, ');
    cmd.Sql.Add('`ProductName`        varchar(100) default NULL, ');
    cmd.Sql.Add('`QtySold`            Double default NULL, ');
    cmd.Sql.Add('`TotalLineAmount`    double default NULL, ');
    cmd.Sql.Add('`TotalLineAmountInc` double default NULL, ');
    cmd.Sql.Add('`InvoiceDocNumber`   varchar(20) default NULL, ');
    cmd.Sql.Add('`EFTPOS`             double default NULL, ');
    cmd.Sql.Add('`Cheques`            double default NULL, ');
    cmd.Sql.Add('`InvoicePayments`    double default NULL, ');
    cmd.Sql.Add('`DinersClub`         double default NULL, ');
    cmd.Sql.Add('`MasterCard`         double default NULL, ');
    cmd.Sql.Add('`VISA`               double default NULL, ');
    cmd.Sql.Add('`Amex`               double default NULL, ');
    cmd.Sql.Add('`CreditCard`         double default NULL, ');
    cmd.Sql.Add('`BankCard`           double default NULL, ');
    cmd.Sql.Add('`Hundreds`           int(11) NULL default "0", ');
    cmd.Sql.Add('`Fifties`            int(11) NULL default "0", ');
    cmd.Sql.Add('`Twenties`           int(11) NULL default "0", ');
    cmd.Sql.Add('`Tens`               int(11) NULL default "0", ');
    cmd.Sql.Add('`Fives`              int(11) NULL default "0", ');
    cmd.Sql.Add('`Twos`               int(11) NULL default "0", ');
    cmd.Sql.Add('`Ones`               int(11) NULL default "0", ');
    cmd.Sql.Add('`FiftyCents`         int(11) NULL default "0", ');
    cmd.Sql.Add('`TwentyCents`        int(11) NULL default "0", ');
    cmd.Sql.Add('`TenCents`           int(11) NULL default "0", ');
    cmd.Sql.Add('`FiveCents`          int(11) NULL default "0", ');
    cmd.Sql.Add('`SaleID`             int(11) default NULL, ');
    cmd.Sql.Add('`SaleDate`           datetime default NULL, ');
    cmd.Sql.Add('`TimeOfSale`         varchar(20) default NULL, ');   //tblsales has this as string so we
    cmd.Sql.Add('`SaleDateTime`       datetime default NULL, ');      //have to combine with saledate
    cmd.Sql.Add('`IsPOS`              varchar(1) default NULL, ');
    cmd.Sql.Add('PRIMARY KEY  (`ID`),  KEY `Dates` (`EndDate`)) ENGINE=MyISAM; ');
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

procedure TfrmBlindBalanceReport.AddDataToTempBlindSummaryTable;
var
  InsertSQL: string;
  cmd: TERPCommand;

begin
  InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + (*GetUserTempBlindSummaryName*) fsTablename +
  '(PeriodID,TillID,StartDate, EndDate,EmployeeName,SalesEmployeeName , ProductName,' +
  'QtySold,TotalLineAmount,TotalLineAmountInc,InvoiceDocNumber,EFTPOS,Cheques,' +
  'InvoicePayments,DinersClub,MasterCard,VISA,Amex,CreditCard,BankCard,Hundreds,Fifties,Twenties,' +
  'Tens,Fives,Twos, Ones,FiftyCents,TwentyCents,TenCents,FiveCents, SaleID,SaleDate,TimeOfSale,IsPOS , SaleDatetime)';

  cmd := DbSharedObj.GetCommand(CommonDbLib.GetSharedMyDacConnection);
  try
    //Data
    cmd.Sql.Clear;
    cmd.Sql.Add('truncate  ' + (*GetUserTempBlindSummaryName*) fsTablename + '; ');
    cmd.Sql.Add(InsertSQL);
    cmd.Sql.Add('SELECT B.PeriodID ,');
    cmd.Sql.Add('B.TillID, ');
    cmd.Sql.Add('B.Start, ');
    cmd.Sql.Add('B.EndDate, ');
    cmd.Sql.Add(' B.EmployeeName, ');
    cmd.Sql.Add(' S.EmployeeName as SalesEmployeeName, ');
    cmd.Sql.Add(' SL.ProductName, ');
    cmd.Sql.Add(' SL.QtySold, ');
    cmd.Sql.Add(' SL.TotalLineAmount, ');
    cmd.Sql.Add(' SL.TotalLineAmountInc, ');
    cmd.Sql.Add(' S.InvoiceDocNumber, ');
    cmd.Sql.Add('B.EFTPOS,');
    cmd.Sql.Add('If(UCase(S.Paymethod)=UCase("Cheque"),SL.TotalLineAmount,0.00) as Cheques, ');
    cmd.Sql.Add('B.InvoicePayments, ');
    cmd.Sql.Add('If(UCase(S.Paymethod)=UCase("Diners Club"),SL.TotalLineAmount,0.00) as DinersClub, ');
    cmd.Sql.Add('If(UCase(S.Paymethod)=UCase("Master Card"),SL.TotalLineAmount,0.00) as MasterCard, ');
    cmd.Sql.Add('If(UCase(S.Paymethod)=UCase("VISA"),SL.TotalLineAmount,0.00) as VISA, ');
    cmd.Sql.Add('If(UCase(S.Paymethod)=UCase("Amex"),SL.TotalLineAmount,0.00) as Amex, ');
    cmd.Sql.Add('If(UCase(S.Paymethod)=UCase("CreditCard"),SL.TotalLineAmount,0.00) as CreditCard, ');
    cmd.Sql.Add('If(UCase(S.Paymethod)=UCase("BankCard"),SL.TotalLineAmount,0.00) as BankCard, ');
    cmd.Sql.Add('B.Hundred as Hundreds, ');
    cmd.Sql.Add('B.Fifty as Fifties, ');
    cmd.Sql.Add('B.Twenty as Twenties, ');
    cmd.Sql.Add('B.Ten as Tens, ');
    cmd.Sql.Add('B.Five as Fives, ');
    cmd.Sql.Add('B.Two as Twos, ');
    cmd.Sql.Add('B.One as Ones, ');
    cmd.Sql.Add('B.FiftyCents, ');
    cmd.Sql.Add('B.TwentyCents, ');
    cmd.Sql.Add('B.TenCents, ');
    cmd.Sql.Add('B.FiveCents, ');
    cmd.Sql.Add('S.SaleID, ');
    cmd.Sql.Add('S.SaleDate, ');
    cmd.Sql.Add('S.TimeOfSale, ');
    cmd.Sql.Add('S.IsPOS, S.SaleDatetime ');
    cmd.Sql.Add('From tblpostilleop B  ');
    cmd.Sql.Add('Left JOIN tblSales S ON S.TillID = B.TillID and S.SaleDatetime between B.Start and B.endDate  '+
                                           //' AND S.SaleDate Between '+QuotedStr( FormatDateTime(MysqlDatetimeFormat, filterdateFrom))+' AND '+QuotedStr(FormatDateTime(MysqlDatetimeFormat, filterdateTo))+'  '+
                                           ' AND S.isPOS = "T" ');
    cmd.Sql.Add('Left JOIN tblsaleslines SL ON SL.SaleID = S.SaleID ');
    cmd.Sql.Add('WHERE /*B.Start*/Date(B.`EndDate`)  Between '+ QuotedStr(FormatDateTime(MYSQLDateTimeFormat, FilterdateFrom))+' AND '+QuotedStr(FormatDateTime(MYSQLDateTimeFormat, filterDateTo)));
    cmd.Sql.Add(' GROUP BY b.periodID, SaleLineID;');
    cmd.Execute;
    //LoadBlindPeriodIDToSales;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;


(*procedure TfrmBlindBalanceReport.RefreshTotal;
var
  totalInc :Double;
  totalEx:Double;
begin
  if grpFilters.itemindex = 0 then begin
    grdmain.Options := grdmain.Options - [dgShowFooter];
  end else begin
    grdmain.Options := grdmain.Options + [dgShowFooter];
    Qrymain.DisableControls;
    try
      Qrymain.First;
      TotalInc := 0;
      totalEx:= 0;
      While Qrymain.eof = False do begin
        TotalInc := Totalinc +qryMainTotalAmountinc.asFloat;
        TotalEx:= totalEx+qryMainTotalLineAmount.asFloat;
        Qrymain.Next;
      end;
      grdmain.columnByname('TotalLineAmount').FooterValue := FloatToStrF(TotalInc,ffCurrency, 15, CurrencyRoundPlaces);
      grdmain.columnByname('TotalAmountInc').FooterValue  := FloatToStrF(TotalEx,ffCurrency, 15, CurrencyRoundPlaces);
    finally
      Qrymain.EnableControls;
    end;
  end;
end;*)

procedure TfrmBlindBalanceReport.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  try
    (*qryMainTotalCash.asFloat := (qryMainHundreds.asInteger   *100 ) +
                                (qryMainFifties.asInteger    *50  ) +
                                (qryMainTwenties.asInteger   *20  ) +
                                (qryMainTens.asInteger       *10  ) +
                                (qryMainFives.asInteger      *5   ) +
                                (qryMainTwos.asInteger       *2   ) +
                                (qryMainOnes.asInteger       *1   ) +
                                (qryMainFiftyCents.asInteger *0.5 ) +
                                (qryMainTwentyCents.asInteger*0.2 ) +
                                (qryMainTenCents.asInteger   *0.1 ) +
                                (qryMainFiveCents.asInteger  *0.05) ;
    QrymainVariation.asFloat := qrymainTotalAmountinc.asfloat -qryMainTotalCash.asFloat ;*)
    if Qrymaindetails.AsInteger = 0 then
      QrymainVariation.asFloat := qrymainTotalAmountinc.asfloat -qryMainTotalCash.asFloat
    else QrymainVariation.asFloat := 0;

  except
      //kill the exception
  end;
end;

procedure TfrmBlindBalanceReport.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('TillID');
  RemoveFieldfromGrid(QrymainDetails.fieldname);
end;

initialization
  RegisterClassOnce(TfrmBlindBalanceReport);
end.
