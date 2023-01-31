unit AccountsPayableNotesList;

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
  Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TAccountsPayableNotes = class(TBaseListingGUI)
    qryAPNotes: TERPQuery;
    APMemoDialog: TwwMemoDialog;
    DSAPNotes: TDataSource;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainPONumber: TWideStringField;
    qryMainOrderDate: TDateField;
    qryMainAccountName: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainAPNotes: TWideMemoField;
    qryAPNotesPurchaseOrderID: TIntegerField;
    qryAPNotesAPNotes: TWideMemoField;
    qryMainIsBill: TWideStringField;
    qryMainIsPO: TWideStringField;
    qryMainIsCredit: TWideStringField;
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

uses CommonLib;

{$R *.dfm}

procedure TAccountsPayableNotes.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TAccountsPayableNotes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TAccountsPayableNotes.FormShow(Sender: TObject);
begin
  inherited;
  cboFilter.ItemIndex := 0;
end;

procedure TAccountsPayableNotes.grdMainDblClick(Sender: TObject);
Var
  fsType:  String;
begin
  if qryMainPurchaseOrderID.AsInteger > 0 then begin
    if (grdMain.GetActiveField.FieldName = 'APNotes') and (qryMainPurchaseOrderID.AsInteger <> 0) then begin
      qryAPNotes.Close;
      qryAPNotes.ParamByName('ID').AsInteger := qryMainPurchaseOrderID.AsInteger;
      qryAPNotes.Execute;
      if not qryAPNotes.IsEmpty then APMemoDialog.Execute;
    end else Begin
        If qryMainIsBill.AsBoolean then
          fsType := 'Bill'
        else If qryMainIsPO.AsBoolean then
          fsType := 'PO'
        else If qryMainIsCredit.AsBoolean then
          fsType := 'Credit';
        SubsequentID := Chr(95) + fsType;
        inherited;        
    end;
  end;
end;

initialization
  RegisterClassOnce(TAccountsPayableNotes);

finalization
  UnRegisterClass(TAccountsPayableNotes);
end.
