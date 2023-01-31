unit ReportTemplateList;

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
  TReportTemplateListGUI = class(TBaseListingGUI)
    qryMaintemplid: TIntegerField;
    qryMainTemplname: TWideStringField;
    qryMainTypeName: TWideStringField;
    qryMainactive: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    Function TTTypeID :Integer ; virtual;
    Procedure PopulateTemplateSQL;Virtual;
  public
    Procedure RefreshQuery;override;
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TReportTemplateListGUI.cmdPrintClick(Sender: TObject);
begin
  //inherited;
  PopulateTemplateSQL;
  PrintTemplateReport(qrymainTemplname.asString, templateSQL, False ,1)
end;

procedure TReportTemplateListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := false;
end;

procedure TReportTemplateListGUI.PopulateTemplateSQL;
begin
    sSQL:='';
    fbReportSQLSupplied:= False;
end;

procedure TReportTemplateListGUI.RefreshQuery;
begin
  Qrymain.parambyname('tttypeid').asInteger := tttypeid;
  inherited;

end;

procedure TReportTemplateListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMaintemplid.fieldname);
end;

function TReportTemplateListGUI.TTTypeID: Integer;
begin
  REsult := 0;
end;
initialization
  RegisterClassOnce(TReportTemplateListGUI);

end.
