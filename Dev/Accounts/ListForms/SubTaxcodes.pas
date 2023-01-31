unit SubTaxcodes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSubTaxcodesGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainCode: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainRegionID: TSmallintField;
    qryMainmstimestamp: TDateTimeField;
    qryMainCategory: TWideStringField;
    qryMaincCategory: TStringField;
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;

implementation

uses CommonLib, AppEnvironment, CommonFormLib;

{$R *.dfm}
procedure TSubTaxcodesGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenErpform('TfmSubTaxCode' , 0);
end;

procedure TSubTaxcodesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  KeyIdfieldname := qryMainID.Fieldname;
  KeyNamefieldname :=qryMainCode.Fieldname;
end;

procedure TSubTaxcodesGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TSubTaxcodesGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
       if QrymainCAtegory.AsString = 'T' then qryMaincCategory.AsString := 'City'
  else if QrymainCAtegory.AsString = 'S' then qryMaincCategory.AsString := 'State'
  else if QrymainCAtegory.AsString = 'C' then qryMaincCategory.AsString := 'County'
  else if QrymainCAtegory.AsString = 'O' then qryMaincCategory.AsString := 'Other'
  else qryMaincCategory.AsString := 'Un-known';
end;

procedure TSubTaxcodesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainCategory.FieldName);
  RemoveFieldfromGrid(QrymainId.FieldName);
  RemoveFieldfromGrid(Qrymainglobalref.FieldName);
  RemoveFieldfromGrid(QrymainRegionId.FieldName);
  RemoveFieldfromGrid(QrymainmstimeStamp.FieldName);
end;

initialization
  RegisterClassOnce(TSubTaxcodesGUI);

end.

