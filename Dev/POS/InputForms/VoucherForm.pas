unit VoucherForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, DNMPanel, wwcheckbox, wwdblook, wwdbedit,
  Mask, DBCtrls, wwdbdatetimepicker, SelectionDialog, kbmMemTable,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, Shader,
  ImgList, ProgressDialog;

type
  TVoucherGUI = class(TBaseInputGUI)
    qryVouchers: TERPQuery;
    pnlHeader: TDNMPanel;
    pnlFooter: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    dsVouchers: TDataSource;
    qryVouchersVoucherID: TAutoIncField;
    qryVouchersVoucherNo: TWideStringField;
    qryVouchersClientID: TIntegerField;
    qryVouchersClassID: TIntegerField;
    qryVouchersSaleID: TIntegerField;
    qryVouchersValue: TFloatField;
    qryVouchersDateCreated: TDateField;
    qryVouchersDateIssued: TDateField;
    qryVouchersIsIssued: TWideStringField;
    qryVouchersDateRedeemed: TDateField;
    qryVouchersIsRedeemed: TWideStringField;
    qryVouchersActive: TWideStringField;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtVoucherNo: TwwDBEdit;
    edtValue: TwwDBEdit;
    cboClientID: TwwDBLookupCombo;
    cboClassID: TwwDBLookupCombo;
    Label2: TLabel;
    Label10: TLabel;
    qryClients: TERPQuery;
    qryClasses: TERPQuery;
    chkIsIssued: TwwCheckBox;
    chkIsRedeemed: TwwCheckBox;
    chkIsActive: TwwCheckBox;
    dtpCreated: TwwDBDateTimePicker;
    dtpIssued: TwwDBDateTimePicker;
    dtpRedeemed: TwwDBDateTimePicker;
    qryVouchersIssuedBy: TWideStringField;
    Label11: TLabel;
    edtIssuedBy: TwwDBEdit;
    memQryVouchers: TkbmMemTable;
    qryVouchersEditedFlag: TWideStringField;
    memQryVouchersVoucherID: TAutoIncField;
    memQryVouchersVoucherNo: TWideStringField;
    memQryVouchersClientID: TIntegerField;
    memQryVouchersClassID: TIntegerField;
    memQryVouchersSaleID: TIntegerField;
    memQryVouchersValue: TFloatField;
    memQryVouchersDateCreated: TDateField;
    memQryVouchersDateIssued: TDateField;
    memQryVouchersIsIssued: TWideStringField;
    memQryVouchersDateRedeemed: TDateField;
    memQryVouchersIsRedeemed: TWideStringField;
    memQryVouchersActive: TWideStringField;
    memQryVouchersIssuedBy: TWideStringField;
    memQryVouchersEditedFlag: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure qryVouchersAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    
  end;

  //var
  //  VoucherGUI: TVoucherGUI;

implementation

{$R *.dfm}

{ TVoucherGUI }
uses
  DNMExceptions, FormFactory, CommonLib;

procedure TVoucherGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
  //  VoucherGUI := nil;
end;

procedure TVoucherGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      qryVouchers.ParamByName('xVoucherID').asInteger := KeyID;
      OpenQueries;
      EditNoAbort(qryVouchers);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TVoucherGUI.btnSaveClick(Sender: TObject);
var 
  NumOfField: integer;
begin
  inherited;
  try
    if not (qryVouchers.State in [dsBrowse]) then begin
      qryVouchers.Post;

      // EDITED FLAG
      for NumOfField := 0 to memQryVouchers.FieldCount - 1 do begin
          if QryVouchers.FieldByName(memQryVouchers.Fields[NumOfField].FieldName).AsVariant <>
            memQryVouchers.Fields[NumOfField].AsVariant then begin
            QryVouchers.Edit;
            QryVouchers.FieldByName('EditedFlag').AsBoolean := true;
          end;
      end;

      Notify;
    end;
    Self.Close;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TVoucherGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TVoucherGUI.qryVouchersAfterOpen(DataSet: TDataSet);
var 
  NumOfField: integer;
begin
  inherited;
  memQryVouchers.Close;
  memQryVouchers.EmptyTable;
  memQryVouchers.Open;
  memQryVouchers.Insert; // Copy current data to memtable for later comparisson with posted data.
  for NumOfField := 0 to QryVouchers.FieldCount - 1 do begin;
    memQryVouchers.FieldByName(QryVouchers.Fields[NumOfField].FieldName).AsVariant := QryVouchers.Fields[NumOfField].AsVariant;
  end;
end;

initialization
  RegisterClassOnce(TVoucherGUI);
  with FormFact do begin
    RegisterMe(TVoucherGUI, 'TVoucherListGUI_*=VoucherID');
    RegisterMe(TVoucherGUI, 'TAllTransactionGUI_*_Voucher=TransNo');
  end;
end.
