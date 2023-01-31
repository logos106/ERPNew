unit VoucherListForm;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 07/06/05  1.00.01 IJB  Added GridDoubleClicked flag to prevent asigning 0 for
  //                        POS voucher when form closes after user has selected
  //                        from list.
  // 01/11/05  1.00.02 DLS  Added RegisterClass
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TVoucherListGUI = class(TBaseListingGUI)
    qryMainVoucherNo: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainValue: TFloatField;
    qryMainDateCreated: TDateField;
    qryMainDateIssued: TDateField;
    qryMainIsIssued: TWideStringField;
    qryMainDateRedeemed: TDateField;
    qryMainIsRedeemed: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainOtherStore: TWideStringField;
    qryMainIssuingClass: TWideStringField;
    qryMainVoucherID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainInvNo: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    GridDoubleClicked: boolean;
  end;

implementation

{$R *.dfm}

uses POSScreenGUI, CommonLib, CommonFormLib;

procedure TVoucherListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  GridDoubleClicked := false;
end;

procedure TVoucherListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if self.fbFormOpenedOk then begin
    grpFiltersClick(Self);
  end;
end;

procedure TVoucherListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPform('TfmVoucherSale' , 0);
end;

procedure TVoucherListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Owner is TPOSScreenForm then begin
    if not GridDoubleClicked then begin
      TPOSScreenForm(Owner).edtVoucherID.Text := '0';
    end;
  end;  
end;

procedure TVoucherListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'IsRedeemed = ' + QuotedStr('F');
      end;
  end;
  inherited;
end;

procedure TVoucherListGUI.grdMainDblClick(Sender: TObject);
begin
  GridDoubleClicked := true;
  inherited;
end;

initialization
  RegisterClassOnce(TVoucherListGUI);
end.
