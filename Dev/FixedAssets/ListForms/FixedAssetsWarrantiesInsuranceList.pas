// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.

unit FixedAssetsWarrantiesInsuranceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TCheckWarranty_InsurancePolicyGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainAssetID: TIntegerField;
    qryMainAssetCode: TWideStringField;
    qryMainAssetName: TWideStringField;
    qryMainPurchDate: TDateField;
    qryMainPurchCost: TFloatField;
    qryMainAssetType: TWideStringField;
    qryMainLocationDescription: TWideStringField;
    qryMainClass: TWideStringField;
    qryMainBrandName: TWideStringField;
    qryMainManufacture: TWideStringField;
    qryMainModel: TWideStringField;
    qryMainSerial: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainQty: TIntegerField;
    qryMainAssetCondition: TWideStringField;
    qryMainColour: TWideStringField;
    qryMainSize: TWideStringField;
    qryMainShape: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainEstimatedValue: TFloatField;
    qryMainReplacementCost: TFloatField;
    qryMainWarrantyType: TWideStringField;
    qryMainWarrantyExpiresDate: TDateField;
    qryMainInsuredBy: TWideStringField;
    qryMainInsurancePolicy: TWideStringField;
    qryMainInsuredUntil: TDateField;
    qryMainBusinessUse: TFloatField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  CheckWarranty_InsurancePolicyGUI: TCheckWarranty_InsurancePolicyGUI;

implementation
   
uses frmFixedAssetGUI, CommonLib, MySQLConst, CommonFormLib;
{$R *.dfm}

procedure TCheckWarranty_InsurancePolicyGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  CheckWarranty_InsurancePolicyGUI := nil;
end;

procedure TCheckWarranty_InsurancePolicyGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TfmFixedAsset' , 0);
(*Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TFixedAssetGUI');
    if Assigned(Form) then begin //if has acess
      with TFixedAssetGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end; *)
end;

procedure TCheckWarranty_InsurancePolicyGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    1: 
      begin
        GroupFilterString := '((InsuredUntil=Null) OR (InsuredUntil<' + QuotedStr(FormatDateTime(MysqlDateFormat, Date())) + '))';
      end;
    2: 
      begin
        GroupFilterString := '((WarrantyExpiresDate=Null) OR (WarrantyExpiresDate < ' +
          QuotedStr(FormatDateTime(MysqlDateFormat, Date())) + '))';
      end;
  end;
  inherited;
end;

procedure TCheckWarranty_InsurancePolicyGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbEnableWebSearch := true;
end;

procedure TCheckWarranty_InsurancePolicyGUI.btnCustomizeClick(
  Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCheckWarranty_InsurancePolicyGUI.cmdExportClick(
  Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCheckWarranty_InsurancePolicyGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TCheckWarranty_InsurancePolicyGUI);
end.
