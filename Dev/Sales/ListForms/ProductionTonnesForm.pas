unit ProductionTonnesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel ,
  BaseListExpressDetails, BaseListDetails, ProductionTonnesBase,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductionTonnesGUI = class(TProductionTonnesBaseGUI)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  protected
    Function ExpressDetailListName:String;Override;
  public
  end;

implementation

{$R *.dfm}
uses
  CommonLib, tcConst;

{ TProductionTonnesGUI }

function TProductionTonnesGUI.ExpressDetailListName: String;
begin
  REsult := 'TProductionTonnesDetailsGUI';
end;

procedure TProductionTonnesGUI.FormCreate(Sender: TObject);
begin
  Self.caption := 'Production Tonnes Report - Main Product';
  inherited;
  DisableSortoncolumtitleclick:= True;
  DateRangeSelectionHint := 'Report is filterd on the Progress Build Date';
end;

procedure TProductionTonnesGUI.FormShow(Sender: TObject);
begin
  inherited;
  FocusControl(chkIgnoreDates);
  TitleLabel.caption := 'Production Tonnes Report'+NL+'Main Product';
end;


initialization
  RegisterClassOnce(TProductionTonnesGUI);
end.
