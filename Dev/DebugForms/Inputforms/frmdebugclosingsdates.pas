unit frmdebugclosingsdates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, wwdbdatetimepicker, ExtCtrls, DNMPanel;

type
  Tfmdebugclosingsdates = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cboGlobal: TwwDBDateTimePicker;
    cboAccountsRec: TwwDBDateTimePicker;
    cboAccountsPay: TwwDBDateTimePicker;
    cboSummarisedTransDate: TwwDBDateTimePicker;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    Label6: TLabel;
    Label7: TLabel;
    Button2: TButton;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    { Public declarations }
  end;

implementation

uses TransactionsTable, AppEnvironment, CommonLib;

{$R *.dfm}

procedure Tfmdebugclosingsdates.Button1Click(Sender: TObject);
var
  TransactionTableObj : TTransactionTableObj;
begin
  inherited;
    Appenv.companyprefs.ClosingDate:= cboGlobal.date;
    Appenv.companyprefs.ClosingDateAR:=cboAccountsRec.date;
    Appenv.companyprefs.ClosingDateAP:=cboAccountsPay.date;
    Appenv.companyprefs.SummarisedTransDate:=cboSummarisedTransDate.Date;

    TransactionTableObj := TTransactionTableObj.Create(False);
    try
      TransactionTableObj.CleanRefreshTrnsTable(True, True);
      TransactionTableObj.CreatePermanentSummaryTable;
      TransactionTableObj.CleanRefreshTrnsTable(True, False, True);
    finally
      FreeandNil(TransactionTableObj);
    end;

end;

procedure Tfmdebugclosingsdates.FormShow(Sender: TObject);
begin
  inherited;
    cboGlobal.date:= Appenv.companyprefs.ClosingDate;
    cboAccountsRec.date:= Appenv.companyprefs.ClosingDateAR;
    cboAccountsPay.date:= Appenv.companyprefs.ClosingDateAP;
    cboSummarisedTransDate.Date := Appenv.companyprefs.SummarisedTransDate;
end;

initialization
  RegisterClassOnce(Tfmdebugclosingsdates);

end.
