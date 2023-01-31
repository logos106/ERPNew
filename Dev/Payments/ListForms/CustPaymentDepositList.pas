unit CustPaymentDepositList;

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
  TCustPaymentDepositListGUI = class(TBaseListingGUI)
    qryMaindepositId: TIntegerField;
    qryMainDEpositdate: TDateField;
    qryMainEmployeeName: TWideStringField;
    qryMainPaymentID: TIntegerField;
    qryMainPaymentMethod: TWideStringField;
    qryMainPaymentDate: TDateField;
    qryMainCompanyName: TWideStringField;
    qryMainReferenceNo: TWideStringField;
    qryMainAmount: TFloatField;
    qryMainFromDeposited: TWideStringField;
    qryMainReconciled: TWideStringField;
    qryMainType: TWideStringField;
    qryMainDeleted: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fsTrnsType: String;
    fiPaymentID: integer;
    fUpdateCustPayDepositFlag: TNotifyEvent;
  public
    Property PaymentID : integer read fiPaymentID write fiPaymentID;
    Property TrnsType : String read fsTrnsType write fsTrnsType;
    Procedure RefreshQuery;override;
    Procedure ListActiveDeposits;
    Property UpdateCustPayDepositFlag:TNotifyEvent read fUpdateCustPayDepositFlag write fUpdateCustPayDepositFlag;
  end;

implementation

uses CommonLib;


{$R *.dfm}

{ TCustPaymentDepositListGUI }


procedure TCustPaymentDepositListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fUpdateCustPayDepositFlag:= nil;
end;

procedure TCustPaymentDepositListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if PaymentID <> 0 then HaveDateRangeSelection := False;
  if assigned(fUpdateCustPayDepositFlag) then begin
    fUpdateCustPayDepositFlag(Self);
    fUpdateCustPayDepositFlag := nil;
  end;

end;

procedure TCustPaymentDepositListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + Trim(qryMain.FieldByName('Type').AsString);
  inherited;
end;

procedure TCustPaymentDepositListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Deleted' , ['F','T',''], False);
  inherited;
end;

procedure TCustPaymentDepositListGUI.ListActiveDeposits;
begin
  if grpfilters.itemindex <> 0 then
    grpfilters.itemindex := 0;
end;

procedure TCustPaymentDepositListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  Qrymain.ParamByName('PaymentID').asInteger := PaymentID;
  Qrymain.ParamByName('TrnsType').asString:= TrnsType;
  inherited;
end;

initialization
  RegisterClassOnce(TCustPaymentDepositListGUI);

end.
