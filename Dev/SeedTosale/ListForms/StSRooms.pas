unit StSRooms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TStSRoomsGUI = class(TBaseListingGUI)
    qryMainclassid: TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainPrincipleContact: TWideStringField;
    qryMainPrincipleContactPhone: TWideStringField;
    qryMainLicenseNumber: TWideStringField;
    qryMainDefaultRoom: TWideStringField;
    qryMainRoom: TWideStringField;
    qryMainbinid: TIntegerField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    procedure BeforePopup(Popupform:TComponent);Override;
  public
  end;

implementation

uses CommonLib, frmBinLocation;

{$R *.dfm}

procedure TStSRoomsGUI.BeforePopup(Popupform: TComponent);
begin
  inherited;
  if Popupform is  TfmbinLocation then begin
    TfmbinLocation(Popupform).BinlocationCaption := 'Room';
  end;
end;

procedure TStSRoomsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := false;
end;

procedure TStSRoomsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainbinid.fieldname);
  RemoveFieldfromGrid(qrymainclassid.fieldname);
end;

initialization
  RegisterClassOnce(TStSRoomsGUI);
end.
