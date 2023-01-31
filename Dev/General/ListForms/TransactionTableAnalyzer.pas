unit TransactionTableAnalyzer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type

  TTransactionTableAnalyzerGUI = class(TBaseListingGUI)
    QryTransTableSummary: TERPQuery;
    dsTransTableSummary: TDataSource;
    QryTransTableSummarySeqno: TLargeintField;
    QryTransTableSummarytranscount: TLargeintField;
    QryTransTableSummaryTransSQL: TWideMemoField;
    wwDBGrid1: TwwDBGrid;
    wwIButton1: TwwIButton;
    edtBalance: TEdit;
    lblbalance: TLabel;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    Procedure MakeQrymain;
    procedure Calcdiff;
  Protected
    Procedure RefreshTotals;Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonDbLib, DbSharedObjectsObj, tcConst, StringUtils, TransactionsTableLib,
  LogLib, CommonLib;

{$R *.dfm}

{ TTransactionTableAnalyzerGUI }

procedure TTransactionTableAnalyzerGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  HaveOnlyToDate['As On '] := true;
  inherited;
  //HasAsondateRange:= True;
  AddCalccolumn('CreditsEx', true);
  AddCalccolumn('Creditsinc', true);
  AddCalccolumn('DebitsEx', true);
  AddCalccolumn('DebitsInc', true);
  edtBalance.visible := devmode;
end;

procedure TTransactionTableAnalyzerGUI.MakeQrymain;
var
  qry: TERPQuery;
  ssql:String;
  ctr:Integer;
  TransObj:TTransactionTableExtra;
  s:String;
  Procedure initQrymainField(fld:Tfield;fsFieldname:String);
  begin
        fld.fieldKind := fkData;
        fld.fieldname := fsFieldname;
        fld.DataSet := Qrymain;
        fld.DisplayLabel := SeparateWords(fsFieldname);
        fld.Tag := 0;
        fld.visible := true;
  end;
  Procedure MakeFloatfield(fsFieldname:String);  begin initQrymainField(TFloatField.Create      (Qrymain), fsfieldname);  end;
  Procedure MakeIntfield(fsFieldname  :String);  begin initQrymainField(TIntegerField.Create    (Qrymain), fsfieldname);  end;
  Procedure Makedatefield(fsFieldname :String);  begin initQrymainField(TdateField.Create       (Qrymain), fsfieldname);  end;
  Procedure MakeCharfield(fsFieldname :String);  begin initQrymainField(TWideStringField.Create (Qrymain), fsfieldname);  end;

begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(Qrymain);

    qry.SQL.Text := 'desc tbltransactions';
    qry.open;
    qry.first;
    while qry.EOf = false do begin

      if sametext(trim(qry.fields[0].asString),'msTimeStamp') then else begin
        if ssql <> '' then ssql := ssql +',' +NL;
        ssql := ssql + '`'+trim(qry.fields[0].asString)+'` as `'+trim(qry.fields[0].asString)+'` ';
             if SameText(qry.fields[1].asString , 'double')  then MakeFloatfield(trim(qry.fields[0].asString))
        else if SameText(qry.fields[1].asString , 'int(11)') then MakeIntfield(trim(qry.fields[0].asString))
        else if SameText(qry.fields[1].asString , 'date')    then Makedatefield(trim(qry.fields[0].asString))
        else if Pos('varchar',qry.fields[1].asString )>0      then MakeCharfield(trim(qry.fields[0].asString))
        else if Pos('enum',qry.fields[1].asString )>0      then MakeCharfield(trim(qry.fields[0].asString));
      end;
      qry.Next;
    end;
    Qrymain.SQL.clear;
    Qrymain.SQL.add('Select ');
    Qrymain.SQL.add('1 as Transtype,' );
    Qrymain.SQL.add(ssql);
    Qrymain.SQL.add('From tbltransactions');
    Qrymain.SQL.add('where Date <= :DateTo and  type <> "Closing Date Summary"');

    Qrymain.SQL.add('Union ');
    Qrymain.SQL.add('Select ');
    Qrymain.SQL.add('2 as Transtype,' );
    Qrymain.SQL.add(ssql);
    Qrymain.SQL.add('From tbltransactionsummarydetails');
    Qrymain.SQL.add('where Date <= :DateTo ');
    Qrymain.SQL.add('Order by date desc');

    closedb(QryTransTableSummary);
    QryTransTableSummary.SQL.Clear;


    TransObj:= TTransactionTableExtra.Create;
    try
      for ctr:= 2 to 91 do begin
        s:=TransObj.TransSQL(ctr);
        if s<> '' then begin
          if ctr >2 then QryTransTableSummary.SQL.add('union');
          QryTransTableSummary.SQL.add('Select ' + inttostr(ctr)+' as Seqno , '+
                                     '(Select count(*) from tbltransactions '             + ' where seqno =' + inttostr(ctr)+' and type <> "Closing Date Summary") +  '+
                                     '(Select count(*) from tbltransactionsummarydetails '+ ' where seqno =' + inttostr(ctr)+' ) as transcount , '+
                                     Quotedstr(TransObj.StripNewLine(s))+' as TransSQL from dual ' );
        end;
      end;
    finally
      Freeandnil(TransObj);
    end;


  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TTransactionTableAnalyzerGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  closedb(QryTransTableSummary);
  QryTransTableSummary.Connection := qrymain.Connection;
  opendb(QryTransTableSummary);

end;

procedure TTransactionTableAnalyzerGUI.RefreshQuery;
begin
  Qrymain.parambyname('dateto').asDatetime := Filterdateto;
  inherited;
  Calcdiff;
end;
procedure TTransactionTableAnalyzerGUI.RefreshTotals;
begin
  inherited;
  CalcnshowFooter;

end;

procedure TTransactionTableAnalyzerGUI.wwDBGrid1CalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QryTransTableSummarytranscount.AsInteger = 0 then
    DoGreenhighlight(AFont,ABrush);
end;

procedure TTransactionTableAnalyzerGUI.wwDBGrid1DblClick(Sender: TObject);
begin
  inherited;
  clog( QryTransTableSummaryTransSQL.AsString);
end;
procedure TTransactionTableAnalyzerGUI.Calcdiff;
var
  fdex, fdinc:Double;
begin
  fdex  := FooterValue('CreditsEx') - FooterValue('DebitsEx');
  fdinc := FooterValue('Creditsinc') - FooterValue('Debitsinc');
  edtBalance.text := floatToStr(fdEx);
end;
initialization
  RegisterClassOnce(TTransactionTableAnalyzerGUI);

end.
