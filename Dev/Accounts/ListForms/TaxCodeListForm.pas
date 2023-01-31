unit TaxCodeListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TTaxCodeListGUI = class(TBaseListingGUI)
    qryMainName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainTaxCodeID: TAutoIncField;
    qryMainRate: TFloatField;
    qryMainActive: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainCAtegory: TWideStringField;
    qryMainLocationValue: TWideStringField;
    qryMaincCategory: TStringField;
    qryMaindetails: TLargeintField;
    grpOptions: TRadioGroup;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
  end;


implementation

uses frmTaxcodeFrm, CommonLib, Forms,  AppEnvironment, BusObjTaxCodes;

{$R *.dfm}

procedure TTaxCodeListGUI.cmdNewClick(Sender: TObject);
var 
  Form: TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmTaxcode');
  if Assigned(Form) then begin
    with TfrmTaxcode(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
  //  MainForm.axCode1Click(Sender);
end;

procedure TTaxCodeListGUI.FormCreate(Sender: TObject);
begin
  grpOptions.Visible:= appenv.CompanyPrefs.filterTaxcodeforClient;
  fbEnableWebSearch := true;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  KeyIdfieldname := QrymainTaxcodeID.Fieldname;
  KeyNamefieldname :=qryMainDescription.Fieldname;
end;

procedure TTaxCodeListGUI.grpFiltersClick(Sender: TObject);
begin

  if grpOptions.ItemIndex = 0 then GroupFilterString := 'Details =1' else GroupFilterString := 'Details =2';
  case grpFilters.ItemIndex of
    0:GroupFilterString := GroupFilterString + ' and Active = '+quotedstr('T');
    1:GroupFilterString := GroupFilterString + ' and Active = '+quotedstr('F');
  end;

  inherited;
end;

procedure TTaxCodeListGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TTaxCodeListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMaincCategory.AsString := TTaxCode.LocationCodetoDesc(qryMainCAtegory.AsString);
end;

procedure TTaxCodeListGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
  if (grpOptions.Visible)  then begin
      if GuiPrefs.Node.Exists('grpOptions') then begin
        x := GuiPrefs.Node['grpOptions.ItemIndex'].asInteger;
        if x > 0 then if grpOptions.Items.Count >= x then grpOptions.ItemIndex := x - 1;
      end;
    end;
end;

procedure TTaxCodeListGUI.SetGridColumns;
begin
  inherited;
  {hide these fields based on the preference}
  if not appenv.CompanyPrefs.filterTaxcodeforClient then begin
    RemoveFieldfromGrid(qryMainLocationValue.fieldname);
    RemoveFieldfromGrid(qryMaincCategory.fieldname);
  end;
  RemoveFieldfromGrid(qryMainCAtegory.fieldname);
  RemoveFieldfromGrid(qryMainDetails.fieldname);
  RemoveFieldfromGrid(qryMainTaxcodeID.fieldname);
//  RemoveFieldfromGrid(qryMainglobalref.fieldname);
  RemoveFieldfromGrid('GlobalRef');
end;

procedure TTaxCodeListGUI.WriteGuiPrefExtra;
begin
  inherited;
  if (grpOptions.Visible) and (grpOptions.Items.Count > 0) then begin
    GuiPrefs.Node['grpOptions.ItemIndex'].asInteger := grpOptions.ItemIndex + 1;
  end;
end;

initialization
  RegisterClassOnce(TTaxCodeListGUI);
end.
