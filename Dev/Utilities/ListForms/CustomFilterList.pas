unit CustomFilterList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton;

type
  TCustomFiltersListGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainFilterName: TWideStringField;
    qryMainFilterStatement: TWideMemoField;
    qryMainActive: TWideStringField;
    qryMainAllUsers: TWideStringField;
    qryMainDefaultFilter: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainListName: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainDblClick(Sender: TObject);Override; 
  private
    { Private declarations }
    fiUserId: Integer;
    fsReportName: String;
  protected
    procedure RefreshQuery;override;
  public
    { Public declarations }
    Property UserId :Integer REad fiUserId Write fiUserId;
    Property ReportName :String REad fsReportName Write fsReportName;
  end;

implementation

uses
  CommonLib, frmSaveCustomFilter;

{$R *.dfm}


procedure TCustomFiltersListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TCustomFiltersListGUI.grdMainDblClick(Sender: TObject);
var
  CustomFilterForm :TfmSaveCustomFilter;
begin
  If (qryMain.RecordCount=0) Or (qryMainID.asInteger=0) then Exit;
//  inherited;
    CustomFilterForm := TfmSaveCustomFilter(GetComponentByClassName('TfmSaveCustomFilter'));
    CustomFilterForm.KeyId := qryMainID.asInteger;
    CustomFilterForm.CustomFilter.Load(qryMainID.asInteger);
    CustomFilterForm.FormStyle := fsMDIChild;
    CustomFilterForm.BringToFront;
end;

procedure TCustomFiltersListGUI.RefreshQuery;
begin
  qryMain.Params.Parambyname('xReportName').asString := fsReportName;
  qryMain.Params.Parambyname('xUSERID').asInteger := fiUserId;
  inherited;
end;

initialization
  RegisterClassOnce(TCustomFiltersListGUI);
end.
