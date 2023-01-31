unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmMainBase, DB, DBAccess, MyAccess, StdCtrls, DNMSpeedButton,
  ExtCtrls, DAScript, MyScript, MemDS, ComCtrls, Grids, Wwdbigrd, Wwdbgrid;

type
  TfmMain = class(TfmMainBase)
    InvalidTrans: TMyQuery;
    ProgressBar: TProgressBar;
    dsInvalidTrans: TDataSource;
    grdInvalidTrans: TwwDBGrid;
    InvalidTransID: TIntegerField;
    InvalidTransTransID: TIntegerField;
    InvalidTransTranstype: TStringField;
    InvalidTransOHeader: TFloatField;
    InvalidTransOLines: TFloatField;
    InvalidTransPayment: TFloatField;
    InvalidTransNHEader: TFloatField;
    InvalidTransdescription: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  protected
    function getcurVersion:String; override;
    function GetDescription: string; override;
    procedure StartUpdate; override;
//    function ConnectToServer: boolean; override;
    procedure UpdateDb(const Conn: TMyConnection); override;
    procedure UpdateBusobj; Override;
    Function CreateMISCProduct:Integer;
  public
  end;

var
  fmMain: TfmMain;

implementation

uses DLLConnectObj, fastfuncs, typinfo, DataUpdateObj,
  Objects, DataUpdaterconfig;

{$R *.dfm}

{ TfmMain }

Function TfmMain.CreateMISCProduct:Integer;
begin
  With TDLLProduct.CreateProduct(LINEADJUSTMENTPRODUCT,'NONINV', DLLConnection,  self) do try
    Result := ID;
  finally
      free;
  end;
end;

function TfmMain.GetDescription: string;
begin
  result:= 'Fixing sales records';
end;

procedure TfmMain.StartUpdate;
begin
  inherited;
end;

procedure TfmMain.UpdateBusobj;
var
  strSQL:String;

  tot,linetot, Payment:Double;
  TempQry:TMyQuery;
  Ntot:Double;
  msg:STring;
  ctr:Integer;


  Procedure recalinv;

  begin
       TDLLSales.RecalTotal(Ntot,msg,  TempQry.FieldByname('Transtype').asString , linetot ,DLLConnection , self , TempQry.fieldbyname('SaleID').asInteger );
       InvalidTrans.fieldbyname('NHeader').asFloat:= ntot;
       InvalidTrans.fieldbyname('description').asString := msg;
  end;
  Procedure AddMiscProduct;
  begin
       TDLLSales.AddMiscProduct(Ntot,msg, TempQry.FieldByname('Transtype').asString , tot-linetot , DLLConnection , Self ,TempQry.fieldbyname('SaleID').asInteger );
       InvalidTrans.fieldbyname('NHeader').asFloat:= ntot;
       InvalidTrans.fieldbyname('description').asString := msg;
  end;
  Procedure Addmsg;
  begin
      InvalidTrans.insert;
      InvalidTrans.fieldbyname('Transtype').asString := TempQry.fieldbyname('Transtype').asString;
      InvalidTrans.fieldbyname('TransId').asInteger:= TempQry.fieldbyname('SaleId').asInteger;
      InvalidTrans.fieldbyname('Transtype').asString := TempQry.fieldbyname('Transtype').asString;
      InvalidTrans.fieldbyname('OHeader').asFloat:= tot;
      InvalidTrans.fieldbyname('Olines').asFloat:= linetot;
      InvalidTrans.fieldbyname('Payment').asFloat:= Payment;
  end;
begin
  inherited;
    strSQL :='drop table if exists tmp_UpdateSalesBalance;'+
        ' create table tmp_UpdateSalesBalance'+
        ' select  if(tblsales.IsRefund="T" , '+QuotedStr(RefundSale)+' , '+
        ' if(tblsales.IsCashSale      ="T" , '+QuotedStr(CashSale)+' , '+
        ' if(tblsales.IsInvoice       ="T" , '+QuotedStr(Invoice)+' , '+
        ' if(tblsales.IsQuote         ="T" , '+QuotedStr(Quote)+' , '+
        ' if(tblsales.IsSalesOrder    ="T" , '+QuotedStr(SalesOrder)+' ,"" ))))) as TransType,'+
        ' salesorderglobalref, saleDAte, tblsales.SaleID,'+
        ' round(totalamountInc,2) as rtotalamountInc , '+
        ' round(sum(totalLineAmountInc),2) as rlinestotalamountInc,'+
        ' round(TotalAmount,2)    as rTotalAmount , '+
        ' round(sum(TotalLineAmount),2) as rlinesTotalAmount,'+
        ' totalamountInc as totalamountInc , '+
        ' sum(totalLineAmountInc) as linestotalamountInc,'+
        ' TotalAmount    as TotalAmount , '+
        ' sum(TotalLineAmount) as linesTotalAmount,'+
        ' Payment, balance'+
        ' from tblsales'+
        ' inner join tblsaleslines on tblsales.saleid = tblsaleslines.saleid'+
        //' where tblSales.saleId = 600817' +
        ' group by tblsales.SaleID;';
    strSQL:= strSQL+'ALTER TABLE tmp_UpdateSalesBalance ' +
                    ' ADD COLUMN ID int NULL AUTO_INCREMENT ,  ' +
                    ' ADD PRIMARY KEY(ID);';
    strSQL:= strSQL + ' ALTER TABLE `tmp_updatesalesbalance` ADD INDEX `saleID`(`SaleID`);';

    strSQL:= strSQL+'update tblsaleslines '+
                  'Set Linepriceinc =ifnull(totalLineAmountInc,0)/ifnull(shipped,0)  '+
                  'where ifnull(shipped,0)<> 0  '+
                  'and SaleId in (Select saleId from tmp_UpdateSalesBalance where rTotalAmount       <> rlinesTotalAmount  or rtotalamountInc <> rlinestotalamountInc);';
    strSQL:= strSQL+'update tblsaleslines  '+
                  'Set Lineprice =ifnull(totalLineAmount,0)/ifnull(shipped,0)  '+
                  'where ifnull(shipped,0)<> 0  '+
                  'and  SaleId in (Select saleId from tmp_UpdateSalesBalance where rTotalAmount       <> rlinesTotalAmount  or rtotalamountInc <> rlinestotalamountInc);';
    strSQL:= strSQL+'update tblsaleslines SL1 inner join tblsaleslines  SL2 on SL1.saleLineId = SL2.Baselineno  Set SL2.Seqno = SL1.Seqno Where SL1.Seqno <> SL2.SeqNo;';
    strSQL:= strSQL+'drop table if exists tmp_log; CREATE TABLE `tmp_log`  ( `ID` int NULL AUTO_INCREMENT   , '+
            '`TransID` int NULL  , `Transtype` varchar(255) NULL  , `OHeader` double NULL  , `OLines` double NULL  , '+
            '`Payment` double NULL  , `NHEader` double NULL  , description varchar(100), ';
    strSQL:= strSQL+'PRIMARY KEY(`ID`)) ;';


    Execute(strSQL);
    DLLConnection.BeginTransaction;
    try
    CreateMISCProduct;
    strSQL:= 'Select *'+
          ' from tmp_UpdateSalesBalance where'+
          ' rTotalAmount       <> rlinesTotalAmount '+
          ' or rtotalamountInc <> rlinestotalamountInc'+
          ' order by TransType, SaleId';

    TempQry := getNewDataset(strSQL);
    try
      InvalidTrans.DisableControls;
      try
      if InvalidTrans.active then InvalidTrans.close;
      InvalidTrans.SQL.clear;
      InvalidTrans.Connection := dbconn;
      InvalidTrans.SQL.add('Select * from tmp_log');
      InvalidTrans.open;
      finally
          InvalidTrans.enablecontrols;
      end;
      for ctr:= 0 to InvalidTrans.FieldCount-1 do
        InvalidTrans.fields[ctr].displaywidth := 10;
      self.WindowState := wsMaximized;
      try
        grdInvalidTrans.visible := TRue;
        if TempQry.recordcount = 0 then exit;
        TempQry.first;

        ProgressBar.Min := 1;
        ProgressBar.Step:= 1;
        ProgressBar.Max :=TempQry.RecordCount;
        ProgressBar.visible := True;
        ProgressBar.Position:= 1;
        try
          memLog.Lines.Add('Busobj Update started.....');
          while TempQry.eof = False do begin
          if TempQry.Fieldbyname('saleId').asInteger = 600817 then
            beep;
            tot:= TempQry.Fieldbyname('totalamountInc').asFloat ;
            linetot:= TempQry.Fieldbyname('linestotalamountInc').asFloat;
            Payment := TempQry.Fieldbyname('Payment').asFloat;
            Addmsg;
            if (Payment<= linetot) and (linetot = tot) then
            else if (Payment = 0) or (payment <= linetot) or (linetot> tot) then
              recalinv
            else
              AddMiscProduct;
            ProgressBar.StepIt;
            InvalidTrans.Post;
            grdInvalidTrans.Refresh;

            TempQry.Next;
          end;
          DLLconnection.commitTransaction;
        finally
          memLog.Lines.Add('Busobj Update Done');
            ProgressBar.visible := False;
        end;
      finally
          self.WindowState := wsNormal;
      end;
    finally
      if TempQry.active then TempQry.close;
      FreeandNil(TempQry);
    end;
  Except
    on E:Exception do begin
      memLog.Lines.Add('Update Failed:' + E.Message);
      DLLconnection.RollbackTransaction;
    end;

  end;

end;

procedure TfmMain.UpdateDb(const Conn: TMyConnection);
begin
    inherited UpdateDb(Conn);
end;
procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  inherited;
  action := caFree;
end;

function TfmMain.getcurVersion: String;
begin
  Result := '7.4.3.9';
end;

end.
