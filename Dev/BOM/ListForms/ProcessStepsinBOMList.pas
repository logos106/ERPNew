unit ProcessStepsinBOMList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TProcessStepsInBOMListGUI = class(TBaseListingGUI)
    qryMainProcessStep: TWideStringField;
    qryMainBOMProduct: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainDuration: TFloatField;
    qryMainOrderId: TIntegerField;
    qryMainPSID: TIntegerField;
    qryMainCAtegory: TWideStringField;
    qryMainProductId: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainDblClick(Sender: TObject);override;
  private
    fiPSID: Integer;
    procedure SetPSID(const Value: Integer);
  Protected
    procedure SetGridColumns; Override;
  public
    Property PSID:Integer read fiPSID write SetPSID;

    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, tcDataUtils, CommonFormLib;

{$R *.dfm}

procedure TProcessStepsInBOMListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
  PSID := 0;
end;

procedure TProcessStepsInBOMListGUI.grdMainDblClick(Sender: TObject);
begin
  if Qrymaincategory.asString = 'Order' then OpenERPForm('TSalesOrderGUI' , QrymainOrderId.asInteger)
  else OpenERPForm('TfrmParts' , qryMainProductId.asInteger);
  //inherited;
end;

procedure TProcessStepsInBOMListGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
   RefreshQuery;
end;

procedure TProcessStepsInBOMListGUI.RefreshQuery;
begin
  if not(grpFilters.Visible) or (grpFilters.Itemindex =1) then
    Qrymain.parambyname('PSID').asInteger := 0
  else
    Qrymain.parambyname('PSID').asInteger := PSID;
  inherited;

end;
procedure TProcessStepsInBOMListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPSID.Fieldname);
  RemoveFieldfromGrid(qryMainProductId.Fieldname);
end;

procedure TProcessStepsInBOMListGUI.SetPSID(const Value: Integer);
begin
  fiPSID := Value;
  if value <> 0 then begin
    grpFilters.items.clear;
    grpFilters.items.Add('List for ' +quotedstr(getProcessStep(Value)));
    grpFilters.items.Add('All');
    grpFilters.columns := 2;
    grpFilters.Itemindex := 0;
    grpFilters.visible := True;
  end;
end;

initialization
  RegisterClassOnce(TProcessStepsInBOMListGUI);

end.
