unit AccountTransactionlist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TransactionListForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwcheckbox, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton,
  Shader;

type
  TAccountTransactionlistGUI = class(TTransactionListGUI)
    procedure FormCreate(Sender: TObject);
  private
    fdDateTo: TDateTime;
    fdDateFrom: TDAtetime;
    procedure SetDateFrom(const Value: TDAtetime);
    procedure SetdateTo(const Value: TDateTime);
    { Private declarations }
  Protected
    Procedure RefreshQuery; override;
  public
    Property DateFrom :TDAtetime read fdDateFrom write SetDateFrom;
    Property Dateto :TDateTime read fdDateTo write SetdateTo;
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TAccountTransactionlistGUI.FormCreate(Sender: TObject);
begin
  inherited;
    fdDateTo    :=0;
    fdDateFrom  :=0;
end;

procedure TAccountTransactionlistGUI.RefreshQuery;
begin
  inherited;
end;

procedure TAccountTransactionlistGUI.SetDateFrom(const Value: TDAtetime);
begin
  fdDateFrom := Value;
  dtFrom.Date := Value;
end;

procedure TAccountTransactionlistGUI.SetdateTo(const Value: TDateTime);
begin
  fdDateTo := Value;
  dtto.Date := Value;

end;

initialization
  RegisterClassOnce(TAccountTransactionlistGUI);

end.

