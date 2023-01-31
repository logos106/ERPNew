unit PnLReportBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPnLReportBaseGUI = class(TBaseListingGUI)
    btnSelect: TDNMSpeedButton;
    btnOptions: TDNMSpeedButton;
    procedure btnOptionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

    procedure beforeshowOptions(Sender: TObject);
    procedure InitOptionsform(Sender: TObject);
    procedure InitOptionsfromform(Sender: TObject);
  Protected
    includePO, includeBill, includeCredit, includecheque, includeinvoice,includeVoucher,  includeSO, includeCashSale, includePOS, includeRefund, includeLayby, includeJE:boolean;
    dtfromClean, DtToClean:TDatetime;
    FilterItemIndexclean:Integer;
    fstablename:string;

    Procedure MakeQrymain(const PopulateData:boolean = true);    Virtual;
  public
    { Public declarations }
  end;


implementation

uses CommonFormLib, frmPnLEmployeeReportoptions;

{$R *.dfm}

procedure TPnLReportBaseGUI.btnOptionsClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmPnLEmployeeReportoptions' , 0, beforeshowOptions);
end;
procedure TPnLReportBaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
    includePO:= True;
    includeBill:= True;
    includeCredit:= True;
    includecheque:= True;
    includeinvoice:= True;
    includeVoucher := True;
    includeSO:= True;
    includeJE:= True;
    includeCashSale:= True;
    includePOS:= True;
    includeRefund:= True;
    includeLayby:= True;
    dtfromClean:=0;
    DtToClean:=0;
    FilterItemIndexclean:=-1;
end;

procedure TPnLReportBaseGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fsTablename+'1');
  DeleteTable(fsTablename+'2');
  inherited;
end;

procedure TPnLReportBaseGUI.beforeshowOptions(Sender: TObject);
begin
  if not(Sender is TfmPnLEmployeeReportoptions) then exit;
  TfmPnLEmployeeReportoptions(Sender).InitOptionsform := InitOptionsform;
  TfmPnLEmployeeReportoptions(Sender).InitOptionsFromform := InitOptionsFromform;
end;
procedure TPnLReportBaseGUI.InitOptionsform(Sender: TObject);
begin
  if not (Sender is TfmPnLEmployeeReportoptions) then exit;
  TfmPnLEmployeeReportoptions(Sender).chkPO.checked       := includePO;
  TfmPnLEmployeeReportoptions(Sender).chkLayby.checked    := includeLayby;
  TfmPnLEmployeeReportoptions(Sender).chkcheque.checked   := includecheque;
  TfmPnLEmployeeReportoptions(Sender).chkBills.checked    := includeBill;
  TfmPnLEmployeeReportoptions(Sender).chkCredits.checked  := includeCredit;
  TfmPnLEmployeeReportoptions(Sender).chkInvoice.checked  := includeInvoice;
  TfmPnLEmployeeReportoptions(Sender).chkVoucher.checked  := includeVoucher;
  TfmPnLEmployeeReportoptions(Sender).chkPOS.checked      := includePOS;
  TfmPnLEmployeeReportoptions(Sender).chkSO.checked       := includeSO;
  TfmPnLEmployeeReportoptions(Sender).chkJE.checked       := includeJE;
  TfmPnLEmployeeReportoptions(Sender).chkCashSale.checked := includeCashSale;
  TfmPnLEmployeeReportoptions(Sender).chkRefunds.checked  := includeRefund;
  TfmPnLEmployeeReportoptions(Sender).optCategory.visible := False;
  TfmPnLEmployeeReportoptions(Sender).lblCategory.visible := False;
end;

procedure TPnLReportBaseGUI.InitOptionsfromform(Sender: TObject);
begin
  if not (Sender is TfmPnLEmployeeReportoptions) then exit;
  includePO       := TfmPnLEmployeeReportoptions(Sender).chkPO.checked;
  includeLayby    := TfmPnLEmployeeReportoptions(Sender).chkLayby.checked;
  includecheque   := TfmPnLEmployeeReportoptions(Sender).chkcheque.checked;
  includeBill     := TfmPnLEmployeeReportoptions(Sender).chkBills.checked ;
  includeCredit   := TfmPnLEmployeeReportoptions(Sender).chkCredits.checked ;
  includeInvoice  := TfmPnLEmployeeReportoptions(Sender).chkInvoice.checked ;
  includeVoucher  := TfmPnLEmployeeReportoptions(Sender).chkVoucher.checked ;
  includePOS      := TfmPnLEmployeeReportoptions(Sender).chkPOS.checked ;
  includeSO       := TfmPnLEmployeeReportoptions(Sender).chkSO.checked ;
  includeJE       := TfmPnLEmployeeReportoptions(Sender).chkJE.checked ;
  includeCashSale := TfmPnLEmployeeReportoptions(Sender).chkCashSale.checked ;
  includeRefund   := TfmPnLEmployeeReportoptions(Sender).chkRefunds.checked ;
  MakeQrymain;
  RefreshQuery;

end;
procedure TPnLReportBaseGUI.MakeQrymain(const PopulateData:boolean = true);
begin

end;

end.

