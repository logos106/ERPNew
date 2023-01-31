unit InventoryAssetCheckList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TInventoryAssetCheckListGUI = class(TBaseListingGUI)
    grpFiltersExtra: TRadioGroup;
    qryMaintype: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainDebitsEx: TFloatField;
    qryMainCreditsEx: TFloatField;
    qryMainDebitsInc: TFloatField;
    qryMainCreditsInc: TFloatField;
    qryMainCreditsInc1: TFloatField;
    qryMainCreditsEx1: TFloatField;
    qryMainDebitsInc1: TFloatField;
    qryMainDebitsEx1: TFloatField;
    qryMainCreditsInc2: TFloatField;
    qryMainCreditsEx2: TFloatField;
    qryMainDebitsInc2: TFloatField;
    qryMainDebitsEx2: TFloatField;
    qryMainDetails: TLargeintField;
    qryMainTransId: TLargeintField;
    qryMainseqno: TLargeintField;
    qryMainsaleId: TLargeintField;
    qryMainPOID: TLargeintField;
    qryMainpaymentId: TLargeintField;
    qryMainPrepaymentID: TLargeintField;
    qryMainFixedAssetID: TLargeintField;
    qryMainSaleLineId: TLargeintField;
    qryMainPOLineID: TLargeintField;
    qryMainPaymentLineID: TLargeintField;
    qryMainPrePayLineID: TLargeintField;
    qryMainEx1: TFloatField;
    qryMainEx2: TFloatField;
    qryMaininc1: TFloatField;
    qryMaininc2: TFloatField;
    qryMainEx: TFloatField;
    qryMainInc: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grpFiltersExtraClick(Sender: TObject);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
  private
    procedure InitList(Sender: TObject);
    Procedure RefreshSQL;
  Protected
    Tablename : String;
    Procedure InitformSQL;Virtual;
    procedure SetGridColumns; Override;

  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonDbLib, LogLib, tcConst, TempTableUtils, MySQLConst,
  InventoryAssetCheckListByAccount, InventoryAssetCheckListByProduct,
  InventoryAssetCheckListByType, CommonFormLib;

{$R *.dfm}
procedure TInventoryAssetCheckListGUI.FormCreate(Sender: TObject);
begin
  Tablename := UniqueTableName('InvAssetcheck' );
  inherited;
  DisableSortoncolumtitleclick:= True;
  HaveDateRangeSelection := False;
  dtTo.visible := True;
  lblTo.visible := True;
end;

procedure TInventoryAssetCheckListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (Field is TIntegerField)   and (TIntegerField(Field).asInteger  = 0) then Afont.color := ABrush.color;
  if (Field is TFloatField  )   and (TFloatField(Field).asFloat      = 0) then Afont.color := ABrush.color;
  if (Field is TLargeintField)  and (TLargeintField(Field).asInteger = 0) then Afont.color := ABrush.color;


  if (QrymainDetails.asInteger =4 ) then begin
    if   (*SameText(Field.fieldname , qrymaincreditsEx1.fieldname ) or
         SameText(Field.fieldname , qrymaincreditsinc1.fieldname) or
         SameText(Field.fieldname , qrymainDebitsEx1.fieldname  ) or
         SameText(Field.fieldname , qrymainDebitsInc1.fieldname ) or*)
         SameText(Field.fieldname , qrymaincreditsEx2.fieldname ) or
         SameText(Field.fieldname , qrymaincreditsinc2.fieldname) or
         SameText(Field.fieldname , qrymainDebitsEx2.fieldname  ) or
         SameText(Field.fieldname , qrymainDebitsInc2.fieldname ) then begin
      Afont.color := ABrush.color;
    end else if SameText(Field.fieldname , qrymaintype.fieldname) and (grpFiltersExtra.itemindex = 2) then begin
        Afont.color := ABrush.color;
    end else if SameText(Field.fieldname , qrymainAccountname.fieldname) and (grpFiltersExtra.itemindex = 1) then begin
        Afont.color := ABrush.color;
    end else if SameText(Field.fieldname , qrymainProductname.fieldname) and (grpFiltersExtra.itemindex = 0) then begin
        Afont.color := ABrush.color;
    end;
  end else  if (*SameText(Field.fieldname , qrymaincreditsEx1.fieldname ) or
               SameText(Field.fieldname , qrymaincreditsinc1.fieldname) or
               SameText(Field.fieldname , qrymainDebitsEx1.fieldname  ) or
               SameText(Field.fieldname , qrymainDebitsInc1.fieldname ) or*)
               SameText(Field.fieldname , qrymaincreditsEx2.fieldname ) or
               SameText(Field.fieldname , qrymaincreditsinc2.fieldname) or
               SameText(Field.fieldname , qrymainDebitsEx2.fieldname  ) or
               SameText(Field.fieldname , qrymainDebitsInc2.fieldname ) then begin
       if TFloatField(Field).asFloat <> 0 then
        ABrush.color := GridColhighLightRed
       else AFont.color := ABrush.color;
  end;
end;

procedure TInventoryAssetCheckListGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  RefreshSQL;
end;

procedure TInventoryAssetCheckListGUI.grpFiltersExtraClick(Sender: TObject);
var
  s:STring;
begin
  inherited;
  ProcessingCursor(True);
    try
         if grpFiltersExtra.ItemIndex = 0 then s := 'TInventoryAssetCheckListByProductGUI'
    else if grpFiltersExtra.ItemIndex = 1 then s := 'TInventoryAssetCheckListByAccountGUI'
    else if grpFiltersExtra.ItemIndex = 2 then s := 'TInventoryAssetCheckListByTypeGUI'
    else exit;
    if Sametext(Self.ClassName , s) then exit;
    OpenERpListForm(s, InitList);
  finally
    ProcessingCursor(False);
  end;
  Self.Close;

end;
procedure TInventoryAssetCheckListGUI.InitformSQL;
begin

end;

procedure TInventoryAssetCheckListGUI.InitList(Sender: TObject);
begin
  CopyParamsto(Sender);
end;
procedure TInventoryAssetCheckListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  (*GuiPrefs.DbGridElement[grdMain].RemoveFields(qryMaintype.fieldname  +',' + qryMainProductname.fieldname+',' + qryMainAccountName.fieldname);
  if grpFiltersExtra.itemindex = 2 then begin
    GuiPrefs.DbGridElement[grdMain].AddFields(qryMaintype.fieldname  +',' + qryMainProductname.fieldname+',' + qryMainAccountName.fieldname, 0);
  end else if grpFiltersExtra.itemindex = 1 then begin
    GuiPrefs.DbGridElement[grdMain].AddFields( qryMainAccountName.fieldname+',' + qryMainProductname.fieldname+',' +qryMaintype.fieldname  , 0);
  end else begin
    GuiPrefs.DbGridElement[grdMain].AddFields( qryMainProductname.fieldname+',' + qryMainAccountName.fieldname+',' +qryMaintype.fieldname  , 0);
  end;*)

end;


procedure TInventoryAssetCheckListGUI.RefreshQuery;
begin
  With Scriptmain do begin
    SQL.Clear;
    SQL.add(' Drop table if exists ' + Tablename +'_1; ');
    SQL.add(' Drop table if exists ' + Tablename +'; ');
    SQL.add(' CREATE TABLE ' + Tablename +'_1 ( ' +
          ' id          INT(10) NOT NULL AUTO_INCREMENT, ' +
          ' AccountId   INT(11) NOT NULL DEFAULT  0 , ' +
          ' Accountname VARCHAR(50) NULL DEFAULT NULL, ' +
          ' PRIMARY KEY (id), ' +
          ' UNIQUE INDEX AccountS (AccountId , Accountname)) COLLATE="utf8_general_ci" ENGINE=myIsam; ');

    SQL.add(' insert ignore into ' + Tablename +'_1 (AccountId, AccountName ) select  distinct COA.AccountId		, COA.Accountname from tblparts         P  inner join tblchartofAccounts COA on P.ASSETACCNT = COA.accountname ; ');
    SQL.add(' insert ignore into ' + Tablename +'_1 (AccountId, AccountName ) Select  distinct SL.ASSETACCNTID , SL.ASSETACCNT 	from tblsaleslines    SL where ifnull(SL.ASSETACCNTID ,0)<> 0 and ifnull(ProductId,0)<> 0; ');
    SQL.add(' insert ignore into ' + Tablename +'_1 (AccountId, AccountName ) Select  distinct PL.ASSETACCNTID , PL.ASSETACCNT 	from tblpurchaselines PL where ifnull(PL.ASSETACCNTID ,0)<> 0 and ifnull(ProductId,0)<> 0; ');

    SQL.add(' Drop table if exists ' + Tablename +'_3; ');
    SQL.add(' CREATE TABLE ' + Tablename +'  ( ' +
          ' id              int(10) NOT NULL AUTO_INCREMENT, ' +
          ' TransId         int(11) DEFAULT  0 , ' +
          ' seqno           int(11) DEFAULT  0 , ' +
          ' saleId          int(11) DEFAULT  0 , ' +
          ' POID            int(11) DEFAULT  0 , ' +
          ' paymentId       int(11) DEFAULT  0 , ' +
          ' PrepaymentID    int(11) DEFAULT  0 , ' +
          ' FixedAssetID    int(11) DEFAULT  0 , ' +
          ' SaleLineId      int(11) DEFAULT  0 , ' +
          ' POLineID        int(11) DEFAULT  0 , ' +
          ' PaymentLineID   int(11) DEFAULT  0 , ' +
          ' PrePayLineID    int(11) DEFAULT  0 , ' +
          ' type            varchar(50) DEFAULT "", ' +
          ' Productname     varchar(60) DEFAULT "", ' +
          ' AccountId       int(11) DEFAULT  0 , ' +
          ' AccountName     varchar(60) DEFAULT "", ' +
          ' DebitsEx        double NULL DEFAULT  0 , ' +
          ' CreditsEx       double NULL DEFAULT  0 , ' +
          ' DebitsInc       double NULL DEFAULT  0 , ' +
          ' CreditsInc      double NULL DEFAULT  0 , ' +
          ' PRIMARY KEY (id) ' +
          ' ) ENGINE=myIsam DEFAULT CHARSET=utf8; ');

    SQL.add(' insert ignore into ' + Tablename +'  ' +
          ' (TransId,seqno,type,Accountname, AccountId, Productname,saleId,POID,paymentId,PrepaymentID,FixedAssetID,SaleLineId,POLineID,PaymentLineID,PrePayLineID,DebitsEx,CreditsEx,DebitsInc,CreditsInc) ' +
          ' Select ' +
          ' TR.TransId, TR.seqno , TR.type, TR.accountname, TR.accountId, Tr.Productname, Tr.saleId, TR.purchaseorderId, TR.paymentId , TR.PrepaymentID , TR.FixedAssetID, ' +
          ' TR.SaleLineId,TR.PurchaselineID,TR.PaymentLineID,TR.PrePaymentlineID, ' +
          ' TR.DebitsEx, TR.CreditsEx, TR.DebitsInc, TR.CreditsInc ' +
          ' from tblTransactions TR   ' +
          ' inner join  ' + Tablename +'_1 T on T.accountId = TR.accountId and TR.type <> "Closing Date Summary" and TR.Seqno <100 and  ' +
          ' TR.date <= ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, Filterdateto)) + ' ; ');

    SQL.add(' insert ignore into ' + Tablename +'  ' +
          ' (TransId,seqno,type,Accountname, AccountId, Productname,saleId,POID,paymentId,PrepaymentID,FixedAssetID,SaleLineId,POLineID,PaymentLineID,PrePayLineID,DebitsEx,CreditsEx,DebitsInc,CreditsInc) ' +
          ' Select ' +
          ' TR.TransId, TR.seqno , TR.type, TR.accountname, TR.accountId, Tr.Productname, Tr.saleId, TR.purchaseorderId, TR.paymentId , TR.PrepaymentID , TR.FixedAssetID, ' +
          ' TR.SaleLineId,TR.PurchaselineID,TR.PaymentLineID,TR.PrePaymentlineID, ' +
          ' TR.DebitsEx, TR.CreditsEx, TR.DebitsInc, TR.CreditsInc ' +
          ' from tbltransactionsummarydetails TR   ' +
          ' inner join  ' + Tablename +'_1 T on T.accountId = TR.accountId  ' +
          ' Where  TR.date <= ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, Filterdateto)) + ' ;');
    DoshowProgressbar(SQL.count , WAITMSG);
    try
      clog(SQL.text);
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;
  RefreshSQL;
  //inherited;
end;

procedure TInventoryAssetCheckListGUI.RefreshSQL;
begin
  if grpFiltersExtra.itemindex <0 then grpFiltersExtra.itemindex := 0;
  if grpFilters.itemindex <0 then grpFilters.itemindex := 0;

  closedb(Qrymain);
  Qrymain.sQL.clear;
  if grpFilters.itemindex = 1 then begin
    Qrymain.sql.add('select ');
    Qrymain.sql.add('convert(4             , UNSIGNED)  as Details ,  ');
    Qrymain.sql.add('convert(TransId       , UNSIGNED)  as TransId, ');
    Qrymain.sql.add('convert(seqno         , UNSIGNED)  as seqno, ');
    Qrymain.sql.add('convert(saleId        , UNSIGNED)  as saleId, ');
    Qrymain.sql.add('convert(POID          , UNSIGNED)  as POID, ');
    Qrymain.sql.add('convert(paymentId     , UNSIGNED)  as paymentId, ');
    Qrymain.sql.add('convert(PrepaymentID  , UNSIGNED)  as PrepaymentID, ');
    Qrymain.sql.add('convert(FixedAssetID  , UNSIGNED)  as FixedAssetID, ');
    Qrymain.sql.add('convert(SaleLineId    , UNSIGNED)  as SaleLineId, ');
    Qrymain.sql.add('convert(POLineID      , UNSIGNED)  as POLineID, ');
    Qrymain.sql.add('convert(PaymentLineID , UNSIGNED)  as PaymentLineID, ');
    Qrymain.sql.add('convert(PrePayLineID  , UNSIGNED)  as PrePayLineID, ');
    Qrymain.sql.add('type           as type, ');
    Qrymain.sql.add('Productname    as Productname, ');
    Qrymain.sql.add('AccountName    as AccountName, ');
    Qrymain.sql.add('DebitsEx       as DebitsEx, ');
    Qrymain.sql.add('CreditsEx      as CreditsEx, ');
    Qrymain.sql.add('DebitsInc      as DebitsInc, ');
    Qrymain.sql.add('CreditsInc     as CreditsInc,  ');
    Qrymain.sql.add('(if(ifnull(Productname,"")<>"",  DebitsEx  , 0))     as DebitsEx1, ');
    Qrymain.sql.add('(if(ifnull(Productname,"")<>"",  CreditsEx , 0))     as CreditsEx1, ');
    Qrymain.sql.add('(if(ifnull(Productname,"")<>"",  DebitsInc , 0))     as DebitsInc1, ');
    Qrymain.sql.add('(if(ifnull(Productname,"")<>"",  CreditsInc, 0))     as CreditsInc1, ');
    Qrymain.sql.add('(if(ifnull(Productname,"")="",  DebitsEx  , 0))     as DebitsEx2, ');
    Qrymain.sql.add('(if(ifnull(Productname,"")="",  CreditsEx , 0))     as CreditsEx2, ');
    Qrymain.sql.add('(if(ifnull(Productname,"")="",  DebitsInc , 0))     as DebitsInc2, ');
    Qrymain.sql.add('(if(ifnull(Productname,"")="",  CreditsInc, 0))     as CreditsInc2 , ');
    Qrymain.sql.add('DebitsEx -CreditsEx      as Ex, ');
    Qrymain.sql.add('DebitsInc-CreditsInc     as Inc,  ');
    Qrymain.sql.add('(if(ifnull(Productname,"")<>"",  DebitsEx  , 0))-(if(ifnull(Productname,"")<>"",  CreditsEx , 0))     as Ex1, ');
    Qrymain.sql.add('(if(ifnull(Productname,"")<>"",  DebitsInc , 0))-(if(ifnull(Productname,"")<>"",  CreditsInc, 0))     as Inc1, ');
    Qrymain.sql.add('(if(ifnull(Productname,"")="",  DebitsEx  , 0))-(if(ifnull(Productname,"")="",  CreditsEx , 0))     as Ex2, ');
    Qrymain.sql.add('(if(ifnull(Productname,"")="",  DebitsInc , 0))-(if(ifnull(Productname,"")="",  CreditsInc, 0))     as Inc2 ');

    Qrymain.sql.add('from ' +tablename );
    Qrymain.sql.add(' union ' );
  end;
  InitformSQL;
  RefreshOrignalSQL;
  try
    inherited RefreshQuery;
  Except
    // kill the exception to avoid calling it before the table is beign created
  end;
end;


procedure TInventoryAssetCheckListGUI.SctMainError(Sender: TObject;
  E: Exception; SQL: string; var Action: TErrorAction);
begin
  inherited;
  action := eaContinue;
end;

procedure TInventoryAssetCheckListGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainSaleLineId.Fieldname);
    RemoveFieldfromGrid(qryMainPOLineID.Fieldname);
    RemoveFieldfromGrid(qryMainPaymentLineID.Fieldname);
    RemoveFieldfromGrid(qryMainPrePayLineID.Fieldname);
    RemoveFieldfromGrid(qryMainDetails.Fieldname);
    if not devmode then begin
      RemoveFieldfromGrid(qryMainTransId.Fieldname);
    end;
end;


end.
