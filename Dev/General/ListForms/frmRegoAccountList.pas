// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.

unit frmRegoAccountList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, wwcheckbox, ProgressDialog,  wwdblook,
  Shader, kbmMemTable;

type
  TfrmRegoAccountListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainServerPrice: TFloatField;
    qryMainClientPrice: TFloatField;
    qryMainNoClients: TIntegerField;
    qryMainYearlyMaintenancePercent: TIntegerField;
    qryMainContractStart: TDateField;
    qryMainExpires: TDateField;
    qryMainAutoInvoice: TWideStringField;
    qryMainTodoIssued: TDateTimeField;
    qryMainTermsSigned: TDateField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainActive: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainAnnualFee: TCurrencyField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure qryMainCalcFields(DataSet: TDataSet);

  private
    { Private declarations }

  public
    { Public declarations }
    procedure RefreshQuery; override;

  end;



implementation

uses
  CommonLib;

{$R *.dfm}

procedure TfrmRegoAccountListGUI.RefreshQuery;
begin
  inherited;
  //
end;

procedure TfrmRegoAccountListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Expires <> NULL AND Expires <> 0';
      end;
    1: 
      begin
        GroupFilterString := 'Expires = NULL OR Expires = 0';
      end;
  end;
  inherited;
end;

procedure TfrmRegoAccountListGUI.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TfrmRegoAccountListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := 'Company ASC CIS';
end;

procedure TfrmRegoAccountListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if grpFilters.ItemIndex = 0 then begin
    qryMain.FieldByName('AnnualFee').AsFloat := (qryMainServerPrice.AsCurrency + qryMainClientPrice.asCurrency) *
      qryMainYearlyMaintenancepercent.AsInteger / 100;
  end;
end;

initialization
  RegisterClassOnce(TfrmRegoAccountListGUI);
end.

