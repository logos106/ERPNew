unit VoucherLib;

interface

uses
  ERPdbComponents,  classes;

type
  TVoucherValidate = class(TComponent)
    Private
      fiVNOto   : Integer;
      fiVNOFrom : Integer;
      fVoucherNoQry :TERPQuery;
    fconnection: TERPConnection;
      Function VoucherNoQry(iVNOFrom,iVNOto : Integer) :TERPQuery;
    Protected
    public
      constructor Create(AOwner :TComponent);Override;
      Property VNOFrom:Integer read fiVNOFrom write fiVNOFrom;
      Property VNOto:Integer read fiVNOto write fiVNOto;
      function Validvoucherno(voucherno :String;iVNOFrom,iVNOto: Integer;var  ErrMsg :String):Boolean;
      Property connection :TERPConnection read fconnection write fconnection;

  end;

Function NextVoucherno(fconnection :TERPConnection):Int64;

implementation

uses ProgressDialog, CommonDbLib, sysutils, tcConst;

Function NextVoucherno(fconnection :TERPConnection):Int64;
begin
  With tempMyQuery do try
    if fconnection <> nil then connection := fconnection;
    SQL.Add('select max(convert(voucherno , SIGNED)) voucherno from tblvouchers where IsInteger(voucherno)="T"');
    open;
    result:= fieldbyname('voucherno').AsLargeInt +1;
    if active then close;
    SQL.Clear;
    SQL.Add('select max(convert(voucherno , SIGNED)) voucherno from tblsaleslines where IsInteger(voucherno)="T"');
    open;
    if result< fieldbyname('voucherno').AsLargeInt +1 then
      result:= fieldbyname('voucherno').AsLargeInt +1;
  finally
    if active then close;
    Free;
  end;
end;


{ TVoucherValidate }

constructor TVoucherValidate.Create(AOwner: TComponent);
begin
  inherited;
      fiVNOto   :=0;
      fiVNOFrom :=0;
      fVoucherNoQry:= TERPQuery.Create(Self);
      fconnection := nil;
end;

function TVoucherValidate.Validvoucherno(voucherno: String; iVNOFrom,iVNOto: Integer; var ErrMsg: String): Boolean;
begin
  result:= true;
  with  VoucherNoQry (iVNOFrom,iVNOto) do begin
    if locate('voucherno' ,voucherno , []) then begin
      Result:= False;
      errmsg:='Voucher:' + VoucherNo +' is already issued to ' +fieldByname('Company').AsString +' on ' +FormatDateTime(FormatSettings.ShortDateformat , Fieldbyname('DateIssued').asDateTime );
    end;
  end;
end;

function TVoucherValidate.VoucherNoQry(iVNOFrom,iVNOto: Integer): TERPQuery;
var
  s:String;
  ctr:Integer;
begin
  result := nil;
  try
    if  (iVNOto = fiVNOto ) and (iVNOFrom = fiVNOFrom)  and (fVoucherNoQry.Active) then exit;
    if fVoucherNoQry.Active then fVoucherNoQry.Close;
    if fConnection <> nil then fVoucherNoQry.connection := fConnection else fVoucherNoQry.connection := commondblib.GetSharedMyDacConnection;
    fVoucherNoQry.SQL.Clear;
    s:= '0';
    DoShowProgressbar(iVNOto-iVNOFrom+3, WAITMSG);
    try
      for ctr:= iVNOFrom to iVNOto  do begin
        s:= s +',' +inttostr(ctr);
        doStepProgressbar;
      end;
      doStepProgressbar('Opening Query');
      fVoucherNoQry.SQL.Add('SELECT distinct ' +
              ' 1 as Seqno , ' +
              ' 0 as SaleLineId , ' +
              ' 0 as SaleId , ' +
              ' V.clientID , ' +
              ' C.company, ' +
              ' V.voucherno voucherno  , ' +
              ' V.DateIssued  DateIssued ' +
        ' FROM tblvouchers V ' +
        ' inner join tblclients c on c.clientId = V.clientId ' +
        ' where ifnull(V.voucherno ,"") in (' +s +')' +
        ' union  ' +
        ' SELECT distinct ' +
              ' 1 as Seqno , ' +
              ' SL.SaleLineId as SaleLineId , ' +
              ' SL.SaleID as SaleId ,' +
              ' S.clientId , ' +
              ' C.company,' +
              ' voucherno  voucherno , ' +
              ' S.SaleDate  DateIssued ' +
        ' from tblsaleslines SL ' +
        ' inner join tblsales s on s.saleId = Sl.saleID ' +
        ' inner join tblclients c on c.clientId = S.clientId ' +
        ' where ifnull(SL.voucherno ,"") in (' +s +') order by voucherno' );
      fVoucherNoQry.open;
    finally
      DoHideProgressbar;
    end;
    fVoucherNoQry.first;
    VNOto := iVNOto;
    VNOFrom := iVNOFrom;
  finally
    result :=fVoucherNoQry;
  end;
end;

end.

