unit AccountsReceivableNotesList;

{
 Date     Version  Who  What
 -------- -------- ---  --------------------------------------------------------
 04/11/05 1.00.00  MV   Initial verson.
 04/11/05 1.00.01  MV   Added ARMemoDialog to view the complete memo
 11/11/05 1.00.02  MV   Removed compile warning by overriding grdMainDblClick
}

interface

uses
  Windows, Messages, SysUtils, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, Wwmemo, Classes, StdCtrls,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, wwcheckbox;

type
  TAccountsReceivableNotes = class(TBaseListingGUI)
    qryMainInvoiceNumber: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainAccountName: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainARNotes: TWideMemoField;
    qryMainCustomerName: TWideStringField;
    qryARNotes: TERPQuery;
    ARMemoDialog: TwwMemoDialog;
    qryMainSaleID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryARNotesSaleID: TIntegerField;
    qryARNotesARNotes: TWideMemoField;
    DSARNotes: TDataSource;
    qryMainPhone: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  CommonLIb;

{$R *.dfm}

procedure TAccountsReceivableNotes.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TAccountsReceivableNotes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TAccountsReceivableNotes.FormShow(Sender: TObject);
begin
  inherited;
  cboFilter.ItemIndex := 0;
end;

procedure TAccountsReceivableNotes.grdMainDblClick(Sender: TObject);
begin
  if qryMainSaleID.AsInteger > 0 then begin
    if (grdMain.GetActiveField.FieldName = 'ARNotes') and (qryMainSaleID.AsInteger <> 0) then begin
      qryARNotes.Close;
      qryARNotes.ParamByName('ID').AsInteger := qryMainSaleID.AsInteger;
      qryARNotes.Execute;
      if not qryARNotes.IsEmpty then ARMemoDialog.Execute;
    end else inherited;
  end;
end;

initialization
  RegisterClassOnce(TAccountsReceivableNotes);

finalization
  UnRegisterClass(TAccountsReceivableNotes);
end.
