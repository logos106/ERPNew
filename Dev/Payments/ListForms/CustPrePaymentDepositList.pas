unit CustPrePaymentDepositList;

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
  TCustPrePaymentDepositListGUI = class(TBaseListingGUI)
    qryMainPaymentMethod: TWideStringField;
    qryMainTYPE: TWideStringField;
    qryMainDepositDate: TDateField;
    qryMainGlobalRef: TWideStringField;
    qryMainDepositNo: TIntegerField;
    qryMainAmount: TFloatField;
    qryMaindeleted: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fiPaymentID: integer;
    fUpdateCustPrepayDepositFlag: TNotifyEvent;
    { Private declarations }
  public
    Property PaymentID : integer read fiPaymentID write fiPaymentID;
    Procedure RefreshQuery;override;
    Procedure ListActiveDeposits;
    Property UpdateCustPrepayDepositFlag:TNotifyEvent read fUpdateCustPrepayDepositFlag write fUpdateCustPrepayDepositFlag;
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TCustPrePaymentDepositListGUI }

procedure TCustPrePaymentDepositListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fUpdateCustPrepayDepositFlag := nil;
end;

procedure TCustPrePaymentDepositListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if assigned(fUpdateCustPrepayDepositFlag) then begin
    fUpdateCustPrepayDepositFlag(Self);
    fUpdateCustPrepayDepositFlag := nil;
  end;
end;

procedure TCustPrePaymentDepositListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Deleted' , ['F','T',''], False);
  inherited;
end;

procedure TCustPrePaymentDepositListGUI.ListActiveDeposits;
begin
  if grpfilters.itemindex <> 0 then
    grpfilters.itemindex := 0;
end;

procedure TCustPrePaymentDepositListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  Qrymain.ParamByName('PaymentID').asInteger := PaymentID;
  inherited;
end;

initialization
  RegisterClassOnce(TCustPrePaymentDepositListGUI);

end.
