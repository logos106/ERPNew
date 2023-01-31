unit GoogleAnalysisReport_Summary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,GoogleAnalysisReportBase,
  CustomInputBox, wwcheckbox;

type
  TGoogleAnalysisReport_SummaryGUI = class(TGoogleAnalysisReportBaseGUI)
    qryMainDatetime: TDateTimeField;
    qryMainbounces: TFloatField;
    qryMainImpressions: TFloatField;
    qryMainPageviewsPerVisit: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
    fdbounces: Double;
    fdTimeOnSite: Double;
    fdPageviewsPerVisit: Double;

  Protected
    procedure SetGridColumns; Override;
    procedure CalcnShowFooter; Override;
    procedure CalcFooter; Override;
  public
  end;


implementation

uses CommonLib, ListLib;

{$R *.dfm}
procedure TGoogleAnalysisReport_SummaryGUI.CalcFooter;
begin
  inherited;
  fdbounces           := fdbounces          + Qrymainbounces.AsFloat;
  fdTimeOnSite       := fdTimeOnSite      + QrymainTimeOnSite.AsFloat;
  fdPageviewsPerVisit := fdPageviewsPerVisit+ QrymainPageviewsPerVisit.AsFloat;
end;

procedure TGoogleAnalysisReport_SummaryGUI.CalcnShowFooter;
begin
    fdbounces:=0;
    fdTimeOnSite:=0;
    fdPageviewsPerVisit:=0;
    inherited;
    if fdbounces          <> 0 then fdbounces           :=fdbounces          / Qrymain.RecordCount;
    if fdTimeOnSite       <> 0 then fdTimeOnSite        :=fdTimeOnSite       / Qrymain.RecordCount;
    if fdPageviewsPerVisit<> 0 then fdPageviewsPerVisit :=fdPageviewsPerVisit/ Qrymain.RecordCount;

    grdMain.ColumnByName('bounces').FooterValue           := FloatToStrF(fdbounces, ffNumber, 15, 2)+'%';
    grdMain.ColumnByName('FTimeonSite').FooterValue       := SecondsToTime(trunc(round(fdTimeOnSite,0)));//   FloatToStrF(fdTimeOnSite, ffNumber, 15, 2);
    grdMain.ColumnByName('PageviewsPerVisit').FooterValue := FloatToStrF(fdPageviewsPerVisit, ffNumber, 15, 5);
end;

procedure TGoogleAnalysisReport_SummaryGUI.FormCreate(Sender: TObject);
begin
  GAR_Category :='Summary';
  inherited;
  AddCalcColumn(qryMainImpressions.Fieldname, False, fctAvg);
end;


procedure TGoogleAnalysisReport_SummaryGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainDescription.fieldname);
end;

initialization
  RegisterClassOnce(TGoogleAnalysisReport_SummaryGUI);
end.

