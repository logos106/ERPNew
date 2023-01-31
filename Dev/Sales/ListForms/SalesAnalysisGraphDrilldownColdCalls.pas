unit SalesAnalysisGraphDrilldownColdCalls;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesAnalysisGraphDrilldown, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, wwcheckbox;

type
  TSalesAnalysisGraphDrilldownColdCallsGUI = class(TSalesAnalysisGraphDrilldownGUI)
    qryMainId: TIntegerField;
    qryMainLeadid: TIntegerField;
    qryMainemployeeId: TIntegerField;
    qryMainsourceId: TIntegerField;
    qryMainfirstfollowupdate: TDateTimeField;
    qryMainfirstLeadDate: TDateTimeField;
    qryMainsource: TWideStringField;
    qryMainFollowupAction: TIntegerField;
    qryMainCOMPANY: TWideStringField;
    qryMainactiontype: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    procedure FormShow(Sender: TObject);
  private
  Protected
    function Idsfieldname :String;Override;
    procedure SetGridColumns; override;
  public
  end;

implementation

uses CommonLib;

{$R *.dfm}


procedure TSalesAnalysisGraphDrilldownColdCallsGUI.FormShow(Sender: TObject);
begin
  Qrymain.DisableControls;
  try
    if Qrymain.Active then Qrymain.Close;
    Qrymain.SQL.Clear;
    Qrymain.SQL.Add('select ');
    Qrymain.SQL.Add('MC.Id                    as ID, ');
    Qrymain.SQL.Add('MC.COMPANY               as COMPANY, ');
    Qrymain.SQL.Add('MLL.Leadid               as Leadid, ');
    Qrymain.SQL.Add('MLL.employeeId           as employeeId,  ');
    Qrymain.SQL.Add('MLL.EmployeeName         as EmployeeName , ');
    Qrymain.SQL.Add('cast(min(MLL.ActionDate) as DateTime) as firstfollowupdate , ');
    Qrymain.SQL.Add('cast(min(if(MLL.IsLead="T" , MLL.actiondate , null)) as DateTime) as firstLeadDate ,  ');
    Qrymain.SQL.Add('MC.source                as source, ');
    Qrymain.SQL.Add('S.MedTypeID              as sourceId, ');
    Qrymain.SQL.Add('MLL.Actiontype           as FollowupAction, ');
    Qrymain.SQL.Add('ST.name                  as actiontype');
    Qrymain.SQL.Add('from tblmarketingleadlines MLL ');
    Qrymain.SQL.Add('inner join tblmarketingleads ML on ML.LeadID = MLL.LeadID ');
    Qrymain.SQL.Add('inner join tblmarketingcontacts Mc on ML.MarketingContactID = MC.ID ');
    Qrymain.SQL.Add('Left join tblsource S on MC.source = S.MediaType ');
    Qrymain.SQL.Add('Left join tblSimpleTypes  ST on ST.Id = MLL.Actiontype');
    Qrymain.SQL.Add('where ifnull(actiondate,0)<> 0  ');
    if IdsTofilter <> '' then Qrymain.SQL.Add(' and MC.ID in ( ' + IdsTofilter +') ');
    Qrymain.SQL.Add('group by Leadid ');
    //Qrymain.SQL.Add('having firstfollowupdate between :Datefrom and :DateTo');
    Qrymain.SQL.Add('order by followupdate desc');
    inherited;
  finally
    Qrymain.EnableControls;
  end;
end;

function TSalesAnalysisGraphDrilldownColdCallsGUI.Idsfieldname: String;
begin
  REsult:= 'ID';
end;
procedure TSalesAnalysisGraphDrilldownColdCallsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainId.FieldName);
  RemoveFieldfromGrid(qryMainLeadid.FieldName);
  RemoveFieldfromGrid(qryMainemployeeId.FieldName);
  RemoveFieldfromGrid(qryMainsourceId.FieldName);
  RemoveFieldfromGrid(qryMainfollowupAction.FieldName);
end;

initialization
  RegisterClassOnce(TSalesAnalysisGraphDrilldownColdCallsGUI);

end.

