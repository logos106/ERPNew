unit CustomChartList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, CustomInputBox, wwcheckbox, DNMAction;

type
  TCustomChartListGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainChartName: TWideStringField;
    qryMainReportClassName: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainDefaultChart: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    fsReportclassname: String;

  public
     Property Reportclassname :String read fsReportclassname write fsReportclassname;
     Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TCustomChartListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fsReportclassname :='';
end;

procedure TCustomChartListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('Reportclassname').AsString := Reportclassname;
  inherited;
end;

initialization
  RegisterClassOnce(TCustomChartListGUI);

end.

