unit SalesOrderProgressPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DAScript, MyScript, ERPdbComponents,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesOrderProgressPaymentsGUI = class(TBaseListingGUI)
    qryMainrownum: TIntegerField;
    qryMaininvrownum: TIntegerField;
    qryMainSOID: TIntegerField;
    qryMainSODate: TDateField;
    qryMainSOCustomerName: TWideStringField;
    qryMainSOAmount: TFloatField;
    qryMainSOTax: TFloatField;
    qryMainSOAmountinc: TFloatField;

    qryMainPPId: TIntegerField;
    qryMainPPDate: TDateField;
    qryMainPPAmount: TFloatField;
    qryMainPPTax: TFloatField;
    qryMainPPAmountinc: TFloatField;
    qryMainPPLAmount: TFloatField;
    qryMainPPLTax: TFloatField;
    qryMainPPLAmountinc: TFloatField;

    qryMainInvId: TIntegerField;
    qryMaininvAmt: TFloatField;
    qryMaininvTax: TFloatField;
    qryMaininvAmtinc: TFloatField;
    qryMainInvLAmt: TFloatField;
    qryMainInvLTax: TFloatField;
    qryMainInvLAmtInc: TFloatField;

    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    Tablename :String;
  Protected
    procedure SetGridColumns; Override;

  public
    Procedure RefreshQuery;Override;

  end;


implementation

uses CommonLib, CommonFormLib , math, tcConst, CommonDbLib, MySQLConst, LogLib;

{$R *.dfm}


procedure TSalesOrderProgressPaymentsGUI.FormCreate(Sender: TObject);
begin
  TableName := GetUserTemporaryTableName('SOPP');
  Qrymain.SQL.Text := 'Select * from '+tablename;
  inherited;

end;

procedure TSalesOrderProgressPaymentsGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;
end;

procedure TSalesOrderProgressPaymentsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  AFont.color := clblack;

    if Sametext(Field.fieldname , Qrymainrownum.Fieldname) or
        Sametext(Field.fieldname , Qrymaininvrownum.Fieldname) or
        Sametext(Field.fieldname , QrymainSOID.Fieldname) or
        Sametext(Field.fieldname , QrymainSODate.Fieldname) or
        Sametext(Field.fieldname , QrymainSOCustomerName.Fieldname) or
        Sametext(Field.fieldname , QrymainSOAmount.Fieldname) or
        Sametext(Field.fieldname , QrymainSOTax.Fieldname) or
        Sametext(Field.fieldname , QrymainSOAmountinc.Fieldname) then ABrush.color := GridColhighLightGreen

    else if Sametext(Field.fieldname , QrymainPPId.Fieldname) or
        Sametext(Field.fieldname , QrymainPPDate.Fieldname) or
        Sametext(Field.fieldname , QrymainPPAmount.Fieldname) or
        Sametext(Field.fieldname , QrymainPPTax.Fieldname) or
        Sametext(Field.fieldname , QrymainPPAmountinc.Fieldname) or
        Sametext(Field.fieldname , QrymainPPLAmount.Fieldname) or
        Sametext(Field.fieldname , QrymainPPLTax.Fieldname) or
        Sametext(Field.fieldname , QrymainPPLAmountinc.Fieldname)  then ABrush.color := GridColhighLightOrange

    else if Sametext(Field.fieldname , QrymaininvAmt.Fieldname) or
        Sametext(Field.fieldname , QrymainInvId.Fieldname) or
        Sametext(Field.fieldname , QrymaininvTax.Fieldname) or
        Sametext(Field.fieldname , QrymaininvAmtinc.Fieldname) or
        Sametext(Field.fieldname , QrymainInvLAmt.Fieldname) or
        Sametext(Field.fieldname , QrymainInvLTax.Fieldname) or
        Sametext(Field.fieldname , QrymainInvLAmtInc.Fieldname)   then ABrush.color := GridColhighLightBlue;

   if (qryMainInvId.AsInteger <> 0)  and
      (not(sameValue(qryMainPPLAmount.AsFloat , 0-qryMainInvLAmt.AsFloat , 0.00001)) or
       not(sameValue(qryMainPPLTax.AsFloat , 0-qryMainInvLTax.AsFloat , 0.00001)) or
       not(sameValue(qryMainPPLAmountinc.AsFloat , 0-qryMainInvLAmtInc.AsFloat , 0.00001))) then begin
      Abrush.color := GridColhighLightRed;
      if Sametext(Field.fieldname , qryMainPPLAmount.Fieldname) or
          Sametext(Field.fieldname , qryMainInvLAmt.Fieldname) then
            if (not(sameValue(qryMainPPLAmount.AsFloat , 0-qryMainInvLAmt.AsFloat , 0.00001))) then begin
              Font.Style := Afont.Style+[fsBold];
              ABrush.color := clred;
            end;

      if Sametext(Field.fieldname , qryMainPPLTax.Fieldname) or
          Sametext(Field.fieldname , qryMainInvLTax.Fieldname) then
          if not(sameValue(qryMainPPLTax.AsFloat , 0-qryMainInvLTax.AsFloat , 0.00001)) then begin
              Font.Style := Afont.Style+[fsBold];
              ABrush.color := clred;
            end;

      if Sametext(Field.fieldname , qryMainPPLAmountinc.Fieldname) or
          Sametext(Field.fieldname , qryMainInvLAmtInc.Fieldname) then
          if not(sameValue(qryMainPPLAmountinc.AsFloat , 0-qryMainInvLAmtInc.AsFloat , 0.00001)) then begin
              Font.Style := Afont.Style+[fsBold];
              ABrush.color := clred;
            end;
  end;

  if qryMainrownum.AsInteger<> 1 then begin
    if Sametext(Field.fieldname , qryMainSOID.fieldname) or
       Sametext(Field.fieldname , qryMainSODate.fieldname) or
       Sametext(Field.fieldname , qryMainSOCustomerName.fieldname) or
       Sametext(Field.fieldname , QrymainSOAmount.Fieldname) or
       Sametext(Field.fieldname , QrymainSOTax.Fieldname) or
       Sametext(Field.fieldname , QrymainSOAmountinc.Fieldname) then begin
        AFont.color := Abrush.Color;
       end;
  end;

  if qryMaininvrownum.AsInteger <> 1 then begin
    if Sametext(Field.fieldname , qryMainInvId.fieldname) or
       Sametext(Field.fieldname , qryMaininvAmt.fieldname) or
       Sametext(Field.fieldname , qryMaininvTax.fieldname) or
       Sametext(Field.fieldname , qryMaininvAmtinc.fieldname) then begin
        AFont.color := Abrush.Color;;
       end;
  end;
end;

procedure TSalesOrderProgressPaymentsGUI.grdMainDblClick(Sender: TObject);
begin
    if Sametext(ActiveFieldNAme , qryMainSOID.fieldname) or
       Sametext(ActiveFieldNAme , qryMainSODate.fieldname) or
       Sametext(ActiveFieldNAme , qryMainSOCustomerName.fieldname) or
       Sametext(ActiveFieldNAme , QrymainSOAmount.Fieldname) or
       Sametext(ActiveFieldNAme , QrymainSOTax.Fieldname) or
       Sametext(ActiveFieldNAme , QrymainSOAmountinc.Fieldname) then begin
       if qryMainSOID.AsInteger <> 0 then begin
         OpenERPForm('TSalesOrderGUI' , qryMainSOID.AsInteger );
         exit;
       end;
    end;

    if Sametext(ActiveFieldNAme , qryMainPPId.fieldname) or
       Sametext(ActiveFieldNAme , qryMainPPDate.fieldname) or
       Sametext(ActiveFieldNAme , qryMainPPAmount.fieldname) or
       Sametext(ActiveFieldNAme , qryMainPPTax.fieldname) or
       Sametext(ActiveFieldNAme , qryMainPPAmountinc.fieldname) or
       Sametext(ActiveFieldNAme , qryMainPPLAmount.fieldname) or
       Sametext(ActiveFieldNAme , qryMainPPLTax.fieldname) or
       Sametext(ActiveFieldNAme , qryMainPPLAmountinc.fieldname) then begin
       if qryMainPPId.AsInteger <> 0 then begin
         OpenERPForm('TInvoiceGUI' , qryMainPPId.AsInteger );
         exit;
       end;
    end;

    if Sametext(ActiveFieldNAme , qryMainInvId.fieldname) or
       Sametext(ActiveFieldNAme , qryMaininvAmt.fieldname) or
       Sametext(ActiveFieldNAme , qryMaininvTax.fieldname) or
       Sametext(ActiveFieldNAme , qryMaininvAmtinc.fieldname) or
       Sametext(ActiveFieldNAme , qryMainInvLAmt.fieldname) or
       Sametext(ActiveFieldNAme , qryMainInvLTax.fieldname) or
       Sametext(ActiveFieldNAme , qryMainInvLAmtInc.fieldname) then begin
           if qryMainPPId.AsInteger <> 0 then begin
         OpenERPForm('TInvoiceGUI' , qryMainInvId.AsInteger );
         exit;
       end;
    end;


  inherited;

end;

procedure TSalesOrderProgressPaymentsGUI.RefreshQuery;
begin
  With ScriptMain do begin
    SQL.Clear;
    SQL.Add('Drop table if exists '+ tablename +';');
    SQL.Add('Create table  '+ tablename +' ( '+
    '  `ID` int(11) not NULL AUTO_INCREMENT,'+
    '    rownum int(11) DEFAULT NULL, '+
    '    aSaleId int(11) NOT NULL Default 0, '+
    '    invrownum int(11) null DEFAULT NULL, '+
    '    ainvSaleId  int(11) null DEFAULT NULL, '+
    '    SOID int(11) NOT NULL Default 0, '+
    '    SODate date null DEFAULT NULL, '+
    '    SOCustomerName varchar(255) null DEFAULT NULL, '+
    '    SOAmount double NOT NULL Default 0, '+
    '    SOTax double NOT NULL Default 0, '+
    '    SOAmountinc double NOT NULL Default 0, '+
    '    PPId int(11) NOT NULL Default 0, '+
    '    PPDate date null DEFAULT NULL, '+
    '    PPAmount double NOT NULL Default 0, '+
    '    PPTax double NOT NULL Default 0, '+
    '    PPAmountinc double NOT NULL Default 0, '+
    '    PPLAmount double NOT NULL Default 0, '+
    '    PPLTax double NOT NULL Default 0, '+
    '    PPLAmountinc double NOT NULL Default 0, '+
    '    InvId int(11) Default 0, '+
    '    invAmt double Default 0, '+
    '    invTax double Default 0, '+
    '    invAmtinc double Default 0, '+
    '    InvLAmt double Default 0, '+
    '    InvLTax double Default 0, '+
    '    InvLAmtInc double Default 0, '+
    '  PRIMARY KEY (`ID`) ) ENGINE=MyISAM;');
    SQL.Add('insert ignore into '+Tablename +
    ' (rownum,aSaleId,invrownum,ainvSaleId,SOID,SODate,SOCustomerName,SOAmount,SOTax,SOAmountinc,PPId,PPDate,PPAmount,PPTax,PPAmountinc,PPLAmount,PPLTax,PPLAmountinc,InvId,invAmt,invTax,invAmtinc,InvLAmt,InvLTax,InvLAmtInc)'+
    ' Select' +
    '  @rownum:=if(@SaleId <> SOID,   1 ,  @rownum+1) rownum ,' +
    '   @SaleId := SOID,' +
    '   @invrownum:=if(ifnull(InvId,0) =0,0 , if(@invSaleId <> InvId,  1 ,  @invrownum+1)) invrownum ,' +
    '   @invSaleId := InvId,' +
    '   details.* from' +
    '   (Select' +
    '  SO.saleId as SOID,' +
    '  SO.SaleDate as SODate,' +
    '  SO.CustomerName as SOCustomerName,' +
    '  SO.TotalAmount as SOAmount,' +
    '  SO.totalTax as SoTax,' +
    '  SO.TotalAmountinc as SOAmountinc,' +


    '  PP.saleId as PPId ,' +
    '  PP.saleDate as PPDate,' +
    '  PP.TotalAmount as PPAmount,' +
    '  PP.totalTax as PPTax,' +
    '  PP.TotalAmountinc as PPAmountinc,' +
    '  PPSL.TotalLineAmount as PPLAmount,' +
    '  PPSL.LineTax as PPLTax,' +
    '  PPSL.TotalLineAmountInc as PPLAmountinc,' +
    '  Inv.saleId as InvId ,' +
    '  Inv.TotalAmount as invAmt,' +
    '  Inv.totalTax as invTax,' +
    '  Inv.TotalAmountinc as invAmtinc,' +
    '  InvSL.TotalLineAmount as InvLAmt,' +
    '  InvSL.LineTax as InvLTax,' +
    '  InvSL.TotalLineAmountInc  as InvLAmtInc' +
    '  from' +
    '  tblsales SO' +
    '  inner join tblSales PP   on SO.globalref = PP.SOProgressPaymentGlobalRef and SO.OriginalNo = PP.SOProgressPaymentOriginalRef' +
    '  inner join tblsaleslines PPSL on PP.SaleId = PPSL.SaleId and PPSL.ProductName = "Progress Payment"' +
    '  Left join tblsales Inv on SO.GlobalRef = Inv.SalesOrderGlobalRef and inv.deleted ="F" and Inv.cancelled ="F"' +
    '  Left join tblsaleslines InvSL on Inv.saleId = InvSl.saleId and PPSL.globalref = InvSl.ProgresspaymentRef' +
    '  Where So.Saledate between '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateFrom)) +'  and '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateTo)) +
    '  Order by SO.saleId desc, PP.saleId , Inv.SaleID' +
    '  ) details,' +
    '   (SELECT @rownum:=0) r1 ,' +
    '    (SELECT @invrownum:=0) r2,' +
    '    (Select  @SaleId  =0) r3,' +
    '      (Select  @invSaleId  =0) r4;');
    clog(SQL.Text);
    Execute;
  end;
  inherited;

end;

procedure TSalesOrderProgressPaymentsGUI.SetGridColumns;
begin
  inherited;
  if not devmode then begin
    RemoveFieldfromGrid(qryMainrownum.fieldname);
    RemoveFieldfromGrid(qryMaininvrownum.fieldname);
  end;
end;

initialization
  RegisterClassOnce(TSalesOrderProgressPaymentsGUI);

end.
