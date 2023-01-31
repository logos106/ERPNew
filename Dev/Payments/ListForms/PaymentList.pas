unit PaymentList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel , PaymentsListSQL;

type
  TPaymentListGUI = class(TBaseListingGUI)
    qryMainTYPE: TWideStringField;
    qryMainReceiptNo: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainPaymentDate: TDateField;
    qryMainClientName: TWideStringField;
    qryMainjobname: TWideStringField;
    qryMainOpeningBalance: TFloatField;
    qryMainPaymentAmount: TFloatField;
    qryMainCredit: TFloatField;
    qryMainDebit: TFloatField;
    qryMainPaymentMethod: TWideStringField;
    qryMainReferenceNo: TWideStringField;
    qryMainBankAccount: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainPaymentID: TIntegerField;
    qryMainClassID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainAccountID: TIntegerField;
    qryMainChequePrinted: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);
  private
    PaymentListObj: TPaymentList;
    procedure MakeQrymain;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TPaymentListGUI.FormCreate(Sender: TObject);
begin
  PaymentListObj := TPaymentList.Create;
  makeQrymain;
  inherited;
end;
procedure TPaymentListGUI.FormDestroy(Sender: TObject);
begin
  PaymentListObj.Free;
  inherited;

end;

procedure TPaymentListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if field is TFloatfield then
    if TFloatfield(Field).value =0 then
      Afont.color := ABrush.color;
end;

procedure TPaymentListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainType.AsString;
  inherited;

end;

procedure TPaymentListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString(qryMainDeleted.fieldname  , ['F','T','']);
  inherited;
end;

Procedure TPaymentListGUI.MakeQrymain;
var
  msg:String;
begin
  PaymentListObj.PopulateReportSQL(qryMain.SQL, msg);
  self.RefreshOrignalSQL();
end;
procedure TPaymentListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  qrymain.parambyname('ClientID').asInteger  := 0;
  inherited;
end;

procedure TPaymentListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainClassID.Fieldname);
  RemoveFieldfromGrid(qryMainClientID.Fieldname);
  RemoveFieldfromGrid(qryMainEmployeeID.Fieldname);
  RemoveFieldfromGrid(qryMainAccountID.Fieldname);
end;

initialization
  RegisterClassOnce(TPaymentListGUI);

end.
