unit UOMSummaryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TUOMSummaryListGUI = class(TBaseListingGUI)
    qryMainUnitName: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonFormLib, CommonLib;

{$R *.dfm}

procedure TUOMSummaryListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  if fsModal in formstate then begin
    OpenERPFormModal('TUnitsOfMeasureGUI' , 0);
    RefreshQuery;
  end else begin
    OpenERPForm('TUnitsOfMeasureGUI' , 0);
  end;
end;

procedure TUOMSummaryListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbAllowdrilldownwhenModal:= TRue;
end;

initialization
  RegisterClassOnce(TUOMSummaryListGUI);

end.

