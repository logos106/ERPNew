unit EmailedReportScheduleList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton;

type
  TEmailedReportScheduleListGUI = class(TBaseListingGUI)
    procedure grpFiltersClick(Sender: TObject); override;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, BaseInputForm, Forms;

{$R *.dfm}

procedure TEmailedReportScheduleListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Active=' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Active=' + QuotedStr('F');
      end;
  end;
  inherited;
end;

procedure TEmailedReportScheduleListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TEmailedReportScheduleGUI');
  if Assigned(Form) then begin
    with TBaseInputGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TEmailedReportScheduleListGUI);
end.
