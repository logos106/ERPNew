
unit RepairExportHelp;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BusObjBase,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TRepairExportHelpGUI = class(TBaseListingGUI)
    qryMainDescription: TWideStringField;
    qryMainFieldname: TWideStringField;
    qryMainDatafieldName: TWideStringField;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
  private
    fiManufactureID: Integer;
    fgotoExportField: TGeneralStringProc;
  Protected
    Procedure SetGridColumns;Override;

  public
    Property ManufactureID :Integer read fiManufactureID write fiManufactureID;
    Procedure RefreshQuery; override;
    Property gotoExportField:TGeneralStringProc REad fgotoExportField Write fgotoExportField;
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TRepairExportHelpGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ManufactureID := 0;
  fgotoExportField := nil;
  HaveDateRangeSelection := False;
end;

procedure TRepairExportHelpGUI.RefreshQuery;
begin
  closeDB(Qrymain);
  Qrymain.Parambyname('ManufactureID').asInteger := ManufactureID;
  inherited;

end;

procedure TRepairExportHelpGUI.grdMainDblClick(Sender: TObject);
begin
//{don't inherit}  inherited;
 if assigned(fgotoExportField) then
  fgotoExportField(qryMainDatafieldName.asString); 
end;

procedure TRepairExportHelpGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('DatafieldName');
end;

initialization
  RegisterClassOnce(TRepairExportHelpGUI);

end.
