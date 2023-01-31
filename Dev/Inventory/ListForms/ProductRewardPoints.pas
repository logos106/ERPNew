unit ProductRewardPoints;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 30/03/05  1.00.00 IJB  Initial verson.


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook,
  kbmMemTable, Shader;

type
  TProductRewardPointsGUI = class(TBaseListingGUI)
    grpFilters2: TRadioGroup;
    qryMainProductRewardPointsId: TIntegerField;
    qryMainPartsId: TIntegerField;
    qryMainUseUOM: TWideStringField;
    qryMainUOMID: TIntegerField;
    qryMainUOM: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMainPartname: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainPoints: TFloatField;
    qryMainValue: TFloatField;
    qryMainUseDate: TWideStringField;
    qryMainDateFrom: TDateField;
    qryMainDateTo: TDateField;
    qryMainUseExpiryDate: TWideStringField;
    qryMainRewardPointExpiresOn: TDateField;
    qryMainActive: TWideStringField;
    qryMainDateCreated: TDateTimeField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainExpiresOnNoOfMonthsAfterPurchase: TIntegerField;
    qryMainClientTypeID: TLargeintField;
    qryMainTypeName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
  private
    { Private declarations }
  Protected
    Procedure SetGridColumns;override;
  public
    { Public declarations }
    procedure RefreshQuery; override;
  end;

implementation

{$R *.dfm}

uses
  (*frmRewardPointFrm, *) CommonLib, frmRewardPoint;

procedure TProductRewardPointsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Self.DefaultMaxGridColumnWidth := 60;
end;

procedure TProductRewardPointsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TProductRewardPointsGUI.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TProductRewardPointsGUI.RefreshQuery;
begin
  qryMain.Close;
  qryMain.ParamByName('Active').AsString      := grpFilters.Items[grpFilters.ItemIndex];
  qryMain.ParamByName('RangeFilter').AsString := grpFilters2.Items[grpFilters2.ItemIndex];
  qryMain.ParamByName('DateFrom').AsDateTime  := FilterDateFrom;
  qryMain.ParamByName('DateTo').AsDateTime    := FilterDateTo;
  inherited;
end;



procedure TProductRewardPointsGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfmRewardPoint');
    if Assigned(Form) then begin //if has acess
      with TfmRewardPoint(Form) do begin
        KeyId := 0;
        AttachObserver(Self);
        FormStyle        := fsMdiChild;
        CallingClassName := Self.ClassName;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TProductRewardPointsGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  grdMain.DataSource.DataSet.DisableControls;
  try
    qryMain.Close;
    qryMain.ParamByName('Active').AsString      := grpFilters.Items[grpFilters.ItemIndex];
    qryMain.ParamByName('RangeFilter').AsString := grpFilters2.Items[grpFilters2.ItemIndex];
    qryMain.ParamByName('DateFrom').AsDateTime  := FilterDateFrom;
    qryMain.ParamByName('DateTo').AsDateTime    := FilterDateTo;
    qryMain.Open;
  finally
    grdMain.DataSource.DataSet.EnableControls;
  end;
end;

procedure TProductRewardPointsGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProductRewardPointsGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProductRewardPointsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ProductRewardPointsId');
  RemoveFieldfromGrid('PartsId');
  RemoveFieldfromGrid('UOMID');
  RemoveFieldfromGrid('msTimeStamp');
  RemoveFieldfromGrid('ClientTypeId');
  qryMainDateCreated.DisplayFormat := FormatSettings.ShortDateformat;
end;

initialization
  RegisterClassOnce(TProductRewardPointsGUI);
end.


