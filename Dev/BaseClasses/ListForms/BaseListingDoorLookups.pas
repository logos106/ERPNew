unit BaseListingDoorLookups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB, CustomInputBox, Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, BaseInputForm;

type
  TBaseListingDoorLookupGUI = class(TBaseListingGUI)
    procedure grdMainDblClick(Sender: TObject); override;
    procedure grpFiltersClick(Sender: TObject); override;
  private
    { Private declarations }
  Protected
        Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
  public
    Globalref :String;
  end;

implementation

uses BaseInputDoorLookups;

{$R *.dfm}
Procedure TBaseListingDoorLookupGUI.AssignKeyId(Popupform :TBaseInputGUI);
begin
    inherited;
    if popupform is TBaseInputdoorLookupGUI then
        TBaseInputdoorLookupGUI(Popupform).GlobalRef := Qrymain.fieldbyname('globalref').asString;
end;
procedure TBaseListingDoorLookupGUI.grdMainDblClick(Sender: TObject);
begin
    if Qrymain.findfield('Globalref') <> nil then
        Globalref := qrymain.FieldByname('globalref').asString;
  inherited;

end;

procedure TBaseListingDoorLookupGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  if grpFilters.ItemIndex = 0 then begin
    Qrymain.filter := 'Active <> ''F'' ';
    Qrymain.filtered := True;
  end else if grpFilters.ItemIndex = 1 then begin
    Qrymain.filter := 'Active = ''F'' ';
    Qrymain.filtered := True;
  end else Qrymain.filtered := False;
end;

end.
