unit POTotalAmountMisMatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  BusObjBase, DAScript, MyScript, wwcheckbox;

type
  TPOTotalAmountMisMatchGUI = class(TBaseListingGUI)
    grdsub: TwwDBGrid;
    wwIButton1: TwwIButton;
    qrysub: TERPQuery;
    dsSub: TDataSource;
    qrysubPurchaseOrderID: TIntegerField;
    qrysubProductID: TIntegerField;
    qrysubPARTTYPE: TWideStringField;
    qrysubProductName: TWideStringField;
    qrysubQtySold: TFloatField;
    QrysubmsTimeStamp: TDateTimeField;
    qrysubUnitofMeasureQtySold: TFloatField;
    qrysubShipped: TFloatField;
    qrysubUnitofMeasureShipped: TFloatField;
    qrysubBackOrder: TFloatField;
    qrysubUnitofMeasureBackorder: TFloatField;
    qrysubTotalLineAmount: TFloatField;
    qrysubTotalLineAmountInc: TFloatField;
    qrysubDeleted: TWideStringField;
    qrysubPurchaseLineID: TIntegerField;
    btndelete: TDNMSpeedButton;
    btnRecalculate: TDNMSpeedButton;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainTotalAmount: TFloatField;
    qryMaintotalamountinc: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainlineTotalAmount: TFloatField;
    qryMainlineTotalAmountinc: TFloatField;
    qryMainLineTax: TFloatField;
    qryMainDiffEx: TFloatField;
    qryMainDiffInc: TFloatField;
    qryMainTaxDiff: TFloatField;
    qryMainOrderDate: TDateTimeField;
    qryMainmsTimestamp: TDateTimeField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainPaid: TWideStringField;
    qryMainPOtype: TWideStringField;
    qrysubLinecost: TFloatField;
    qrysubLinecostInc: TFloatField;
    EdtDiff: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdsubDblClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
    procedure grdsubCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);

  private
      Tablename1, tablename2, Erpfix_POmismatch, erpfix_sl, erpfix_s:String;
  refreshed:Boolean;
    Function DeletePOLine(SilentMode: Boolean;ActionOption:Word):boolean;
    Procedure backupPOline;
    procedure Progressshow(Sender: TObject; var SQL: String; var Omit: Boolean);
    Procedure Readonlymode;
    procedure OnScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
    Procedure RefreshQrySub;
    function Diffvalue: String;
    Procedure CalcLinetotalscallback(const Sender: TBusObj; var Abort: boolean);
    Procedure backupPO(Const POID:Integer);
    
 public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, CommonDbLib, ProductQtyLib, FastFuncs,
  AppEnvironment, DNMLib, BaseFormForm,
   BusObjOrderBase, busobjOrders, busobjExpenses, DebugLib, tcConst;

{$R *.dfm}
{ TPOTotalAmountMisMatchGUI }

  function TPOTotalAmountMisMatchGUI.Diffvalue:String;
  begin
      if IsNumeric(EdtDiff.text) then result := EdtDiff.Text else result := '1';
  end;

procedure TPOTotalAmountMisMatchGUI.RefreshQuery;
var
  strSQL:String;

begin

  closeDB(Qrymain);
  closeDb(qrysub);
  strSQL:=  'drop table if exists ' + Tablename1 +' ;' +
            ' create table ' + Tablename1 +'' +
            ' Select po.PurchaseOrderID, po.TotalAmount, po.totalamountinc , PO.TotalTax , ' +
            ' sum(pl.TotalLineAmount) lineTotalAmount, sum(pl.TotalLineAmountInc) lineTotalAmountinc , sum(pl.LineTax) as LineTax' +
            ' from tblpurchaseorders po inner join tblpurchaselines pL on po.PurchaseOrderID = pl.PurchaseOrderID' +
            ' Group by po.PurchaseOrderID;' +
            ' drop table if exists ' + Tablename2 +' ;' +
            ' create table ' + Tablename2 +'' +
            ' select *, ' +
            ' abs(ifnull(TotalAmount,0) -ifnull(LineTotalAmount,0)) DiffEx ,' +
            ' abs(ifnull(TotalAmountinc,0)-ifnull(LineTotalAmountinc,0)) DiffInc ,' +
            ' abs(ifnull(TotalTax,0)-ifnull(LineTax,0)) TaxDiff   from ' + Tablename1 +'' +
            ' where abs(ifnull(TotalAmount,0) -ifnull(LineTotalAmount,0))>=' + Diffvalue+'  or' +
            ' abs(ifnull(TotalAmountinc,0)-ifnull(LineTotalAmountinc,0))>=' + Diffvalue+'  or' +
            ' abs(ifnull(TotalTax,0)-ifnull(LineTax,0))>=' + Diffvalue+'  ;' ;
  showProgressbar('Please wait' , 4);
  try
    try
      ExecuteSQL(strSQL, nil , Progressshow, OnScriptError);
  Except
      on E:Exception do begin
          CommonLib.MessageDlgXP_Vista('Error Saving Records To Backup Table. This Form Will Be Opened in Read Only Mode. Please contact ERP Support' ,mtWarning, [mbOk] , 0);
          REadonlymode;
      end;
  end;
    Finally
      HideProgressbar;
    end;
  RefreshqrySub;
  inherited;
  OpenDB(Qrysub);
  if Qrymain.recordcount > 0 then
    if not refreshed then begin
      backupPOline;
      refreshed := true;
    end;

end;

procedure TPOTotalAmountMisMatchGUI.FormCreate(Sender: TObject);
begin
  inherited;
  IgnoreQuerySpeed := TRue;
  refreshed:= False;
  Tablename1:= GetUserTemporaryTableName('POTotalAmountMisMatch1');
  Tablename2:= GetUserTemporaryTableName('POTotalAmountMisMatch2');
  Erpfix_POmismatch := 'erpfix_TAM_deletedduplicatepolines';
  erpfix_sl := 'erpfix_TAM_pl7500';
  erpfix_s := 'erpfix_TAM_po7500';

  closeDB(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select T.*,  po.OrderDate , po.msTimestamp, po.Payment, po.Balance, po.Paid, ' +
                ProductQtylib.POType('PO')+' as POtype ' +
              ' from ' +Tablename2+ ' T ' +
              ' inner join tblpurchaseorders po on po.PurchaseOrderID = T.PurchaseOrderID  ' +
              ' order by PurchaseOrderID');
  RefreshOrignalSQL;
  RefreshQrySub;
end;

Function  TPOTotalAmountMisMatchGUI.DeletePOLine(SilentMode:Boolean;ActionOption:Word):Boolean;
var
  POObj :TOrderbase;
  strSQL:String;
  MsgOption :  Word;
begin
  //inherited;
    Result := False;
    if Sysutils.SameText(qryMainPOType.asString , 'Purchase Order') then begin
      POObj :=TPurchaseOrder.create(Self);
    end else if Sysutils.SameText(qryMainPOType.asString , 'Bill') then begin
      POObj :=TBill.create(Self);
    end else if Sysutils.SameText(qryMainPOType.asString , 'Credit') then begin
      POObj :=TCredit.create(Self);
    end else if Sysutils.SameText(qryMainPOType.asString , 'Cheque') then begin
      POObj :=TCheque.create(Self);
    end else Exit;
    try
      POObj.SilentMode:= true;
      POObj.Connection := TMyDacDataConnection.create(POObj);
      POObj.Connection.Connection := GetNewMyDacConnection(self);
      POObj.Load(QrymainPurchaseOrderID.asInteger);

      if POObj.count = 0 then exit;

      if not(POObj.Lock) then exit;

      if  SilentMode then begin
        MsgOption := ActionOption;
        if not (POObj.Lines.locate('PurchaseLineID' , qrysubPurchaseLineID.asInteger , [])) then exit;
      end else begin
        if not (POObj.Lines.locate('PurchaseLineID' , qrysubPurchaseLineID.asInteger , [])) then exit;
        MsgOption :=  CommonLib.MessageDlgXP_Vista('If You Delete This Line From The Sale, The Details Will Be As Followpo.' + chr(13) +
                      '                             Header                 Lines' +chr(13) +
                      'Amount(ex)       : ' +FloatToStrF(qryMainTotalAmount.asfloat, ffCurrency, 15, CurrencyRoundPlaces) +'          ' +FloatToStrF(qryMainlineTotalAmount.asfloat - qrysubTotalLineAmount.asFloat, ffCurrency, 15, CurrencyRoundPlaces)+ chr(13) +
                      'Amount(Inc)      : ' +FloatToStrF(qryMainTotalAmountInc.asfloat, ffCurrency, 15, CurrencyRoundPlaces) +'          ' +FloatToStrF(qryMainlineTotalAmountInc.asfloat- qrysubTotalLineAmountInc.asFloat, ffCurrency, 15, CurrencyRoundPlaces) + chr(13) +
                      'Total Payment    : ' + FloatToStrF(qryMainPayment.asfloat, ffCurrency, 15, CurrencyRoundPlaces)+chr(13) +
                      'Balance: ' + FloatToStrF(qryMainBalance.asfloat, ffCurrency, 15, CurrencyRoundPlaces)+chr(13) +chr(13) +
                      'It Is Not Possible To Restore Once Deleted.' , mtconfirmation , [], 0 , nil , '' , '' , False , nil, 'Delete Line, Recalculate Total,Cancel');
                      (*'It Is Not Possible To Restore Once Deleted.' +chr(13) +'Are You Sure You Want To Delete It? ' , mtconfirmation , [mbyes,mbno], 0) = mrno then exit;*)
      end;

      POObj.Connection.BeginTransaction;
      try
        if MsgOption = 100 then begin
          strSQL:= 'insert into ' + Erpfix_POmismatch+' Select * from tblpurchaselines where PurchaseLineID = ' + IntToStr(POObj.Lines.ID);
          try
            POObj.GetNewDataSet(strSQL,true);
          Except
              on E:Exception do begin
                  CommonLib.MessageDlgXP_Vista('Error:' +E.Message ,mtWarning, [mbOk] , 0);
                  POObj.Connection.RollbackTransaction;
                  exit;
              end;
          end;
          StrSQL:= 'update tblpurchaselines Set ' +
                  ' Shipped=0 , ' +
                  ' UnitofMeasureShipped=0 , ' +
                  ' UnitofMeasureQtySold = UnitofMeasureQtySold - ' + FloattoStr(POObj.Lines.UOMQtyShipped) +', ' +
                  ' QtySold = QtySold - '+FloatToStr(POObj.Lines.QtySold) +', ' +
                  ' TotalLineAmount=0, ' +
                  ' TotalLineAmountInc=0 ' +
                  ' Where PurchaseLineID = ' +IntToStr(POObj.Lines.ID);
           POObj.GetNewDataSet(strSQL,true);
           POObj.Connection.CommitTransaction;
           Result := true;
          (*POObj.Lines.Deleted := true;
          POObj.Lines.PostDB;*)
        end else if MsgOption = 101 then begin
          backupPO(POObj.ID);
          POObj.Lines.Iteraterecords(CalcLinetotalscallback);
          POObj.CalcOrderTotals;
          POObj.PostDB;
          if not POObj.Save then begin
             POObj.Connection.RollbackTransaction;
          end else begin
            POObj.Connection.CommitTransaction;
            Result := true;
          end;
        end else begin
          POObj.Connection.RollbackTransaction;
          exit;
        end;
      Except
        POObj.Connection.RollbackTransaction;
      end;
    finally
        FreeandNil(POObj);
    end;
end;
Procedure TPOTotalAmountMisMatchGUI.CalcLinetotalscallback(const Sender: TBusObj; var Abort: boolean);
begin
      if not (Sender is TPurchaseOrderLine) then exit;
      TPurchaseOrderLine(Sender).calclinetotals;
      TPurchaseOrderLine(Sender).postdb;
end;
procedure TPOTotalAmountMisMatchGUI.btndeleteClick(
  Sender: TObject);
begin
  inherited;
  if sender = btnRecalculate then begin
    if CommonLib.MessageDlgXP_Vista('This Will Recalculate PO Total of All Listed PO Record.' +chr(13) + Chr(13)+ 'Its Not Possible To Cancel Once Recalculated.' +chr(13) + Chr(13)+ 'Are You Sure You Want To Continue? ' , mtconfirmation , [mbyes,mbno] , 0) = mrNo then exit;
  end else if CommonLib.MessageDlgXP_Vista('This Will Delete The Last Line From Each PO Record If The Line Amount Is Equal To The Difference Between PO Amount And Lines Total Amount.' +chr(13) + Chr(13)+ 'Its Not Possible To Restore Those Records Once Deleted.' +chr(13) + Chr(13)+ 'Are You Sure You Want To continue? ' , mtconfirmation , [mbyes,mbno] , 0) = mrNo then exit;
  
  if Qrymain.Recordcount= 0 then exit;
  Qrymain.first;
  showProgressbar('Deleting Extra POline' , qrymain.RecordCount);
  try
    while Qrymain.Eof = False do begin
       QrySub.Last;
       if sender = btndelete then begin
         if (round(qrysubTotalLineAmountInc.asFloat,CurrencyRoundPlaces) = round(qryMainDiffInc.asFloat,CurrencyRoundPlaces)) and
            (round(qrysubTotalLineAmount.asFloat,CurrencyRoundPlaces) = round(qryMainDiffEx.asFloat,CurrencyRoundPlaces)) then begin
            DeletePOLine(true, 100);
          end else if  (Sysutils.SameText(qryMainPOType.asString , 'Refund')) and
                (0-round(qrysubTotalLineAmountInc.asFloat,CurrencyRoundPlaces) = round(qryMainDiffInc.asFloat,CurrencyRoundPlaces)) and
                (0-round(qrysubTotalLineAmount.asFloat,CurrencyRoundPlaces) = round(qryMainDiffEx.asFloat,CurrencyRoundPlaces)) then begin
            DeletePOLine(true, 100);
          end;
       end else if sender = btnRecalculate then DeletePOLine(true, 101) ; 
       stepProgressbar;
       Qrymain.Next;
    end;
  finally
      HideProgressbar;
      RefreshQuery;
  end;
end;

procedure TPOTotalAmountMisMatchGUI.backupPO(const POID: Integer);
var
  POTablename , POLinesTablename :String;
begin
  POTablename  := 'erpfix_PO_' +formatDateTime('yyyymmdd' , date);
  POLinesTablename  := 'erpfix_POL_' +formatDateTime('yyyymmdd' , date);
  With ScriptMain do begin
    SQL.Clear;
    SQL.Add('Create table if not exists ' + POTablename      +'  like tblpurchaseorders ;' );
    SQL.Add('Create table if not exists ' + POLinesTablename +'  like tblpurchaselines ;' );
    SQL.Add(' insert into ' +POTablename      +' Select * from tblpurchaseorders where PurchaseOrderId = ' + inttostr(POID)+';' );
    SQL.Add(' insert into ' +POLinesTablename +' Select * from tblpurchaselines  where PurchaseOrderId = ' + inttostr(POID)+';' );
    Execute;
  end;
end;

procedure TPOTotalAmountMisMatchGUI.backupPOline;
var
  strSQL:String;
begin
  strSQL:= DuplicateTable('tblpurchaselines' ,  erpfix_sl , true);
  strSQL:= strSQL+chr(13);
  strSQL:= strSQL +DuplicateTable('tblpurchaselines' ,  Erpfix_POmismatch , false);
  strSQL:= strSQL+chr(13);
  strSQL:= strSQL +DuplicateTable('tblpurchaseorders' ,  erpfix_s , true);
  showProgressbar('Please wait' , 5);
  try
    try
      ExecuteSQL(strSQL, nil , Progressshow, OnScriptError);
  Except
      on E:Exception do begin
          CommonLib.MessageDlgXP_Vista('Error Saving Records To Backup Table. This Form Will Be Opened in Read Only Mode. Please contact ERP Support' ,mtWarning, [mbOk] , 0);
          REadonlymode;
      end;
  end;
    Finally
      HideProgressbar;
    end;
end;

procedure TPOTotalAmountMisMatchGUI.Progressshow(Sender: TObject;var SQL: String; var Omit: Boolean);
begin
  inherited;
  stepProgressbar;
end;

procedure TPOTotalAmountMisMatchGUI.FormShow(Sender: TObject);
begin
  inherited;
  grdsub.Footercolor := grdmain.footercolor;
  grdsub.Titlecolor := grdmain.titlecolor;
end;

procedure TPOTotalAmountMisMatchGUI.grdsubDblClick(Sender: TObject);
var
  PurchaseOrderID:Integer;
begin
    if DeletePOLine(False,0) then begin
        PurchaseOrderID := qryMainPurchaseOrderID.asInteger;
        RefreshQuery;
        Qrymain.Locate('PurchaseOrderID' , PurchaseOrderID , []);
    end;

end;

procedure TPOTotalAmountMisMatchGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if QrymainDiffEx.AsFloat <> 0 then
    if sameText(Field.FieldName , QrymainTotalAmount.FieldName) or
       sameText(Field.FieldName , QrymainLineTotalAmount.FieldName) or
       sameText(Field.FieldName , QrymainDiffEx.FieldName) then AFont.Color := clred;

    if sameText(Field.FieldName , QrymainTotalAmountinc.FieldName) or
       sameText(Field.FieldName , QrymainLineTotalAmountinc.FieldName) or
       sameText(Field.FieldName , QrymainDiffInc.FieldName) then AFont.Color := clred;


    if sameText(Field.FieldName , QrymainTotalTax.FieldName) or
       sameText(Field.FieldName , QrymainLineTax.FieldName) or
       sameText(Field.FieldName , QrymainTaxDiff.FieldName) then AFont.Color := clred;
end;

procedure TPOTotalAmountMisMatchGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainPOType.asString;
  inherited;

end;



procedure TPOTotalAmountMisMatchGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(tablename1);
  DeleteTable(tablename2);
  inherited;

end;

procedure TPOTotalAmountMisMatchGUI.grdsubCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (round(qrysubTotalLineAmount.asfloat,0) = round(qryMainDiffEx.asfloat,0)) or
      (round(qrysubTotalLineAmountInc.asfloat,0) = round(qryMainDiffInc.asfloat,0)) then
        AFont.Color := clred;
end;

procedure TPOTotalAmountMisMatchGUI.Readonlymode;
begin
  grdmain.enabled:= False;
  grdsub.Enabled:= False;
  btnRecalculate.Enabled:= False;
  btndelete.Enabled:= False;
  accessLevel := 5;
end;

procedure TPOTotalAmountMisMatchGUI.OnScriptError(Sender: TObject;
  E: Exception; SQL: String; var Action: TErrorAction);
begin
  inherited;
  Readonlymode
end;

procedure TPOTotalAmountMisMatchGUI.RefreshQrySub;
begin
  closeDB(Qrysub);
  qrysub.SQL.clear;
  qrysub.SQL.Add('Select pl.PurchaseOrderID, ' +
              ' pl.ProductID, ' +
              ' pl.PurchaseLineID, ' +
              ' pl.PARTTYPE, ' +
              ' pl.ProductName, ' +
              ' pl.Linecost, ' +
              ' pl.LinecostInc, ' +
              ' pl.QtySold, ' +
              ' pl.UnitofMeasureQtySold, ' +
              ' pl.Shipped, ' +
              ' pl.UnitofMeasureShipped, ' +
              ' pl.BackOrder, ' +
              ' pl.UnitofMeasureBackorder, ' +
              ' pl.TotalLineAmount, ' +
              ' pl.TotalLineAmountInc, ' +
              ' pl.Deleted , pl.msTimestamp' +
              ' from tblpurchaselines pL where pl.PurchaseOrderID in (Select PurchaseOrderID from ' +Tablename2+' T where abs(DiffInc) >' +diffValue+' or abs(DiffEx) >' +diffValue+'  ) ' +
              ' Order by pl.PurchaseOrderID, Seqno ' );
end;


initialization
  RegisterClassOnce(TPOTotalAmountMisMatchGUI);

end.
