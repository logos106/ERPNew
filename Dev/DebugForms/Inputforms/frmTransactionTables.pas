unit frmTransactionTables;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls;

type
  TfmTransactionTables = class(TBaseForm)
    edtNumebr: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, TransactionsTable;

{$R *.dfm}
procedure TfmTransactionTables.Button1Click(Sender: TObject);
begin
  inherited;
  With TTransactionTableObj.create do try
    Memo1.Lines.Clear;
    Memo1.Lines.Add(TransactionSummarySQL(strtoint(edtNumebr.Text)));
  finally
    Free;
  end;
end;

initialization
  RegisterClassOnce(TfmTransactionTables);

end.

