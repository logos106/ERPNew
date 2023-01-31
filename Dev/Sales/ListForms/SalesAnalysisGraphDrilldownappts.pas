unit SalesAnalysisGraphDrilldownappts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesAnalysisGraphDrilldown, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader;

type
  TSalesAnalysisGraphDrilldownapptsGUI = class(TSalesAnalysisGraphDrilldownGUI)
    qryMaincompany: TWideStringField;
    qryMainAppointID: TIntegerField;
    qryMainFirstApptdate: TDateField;
    qryMaintotalAppts: TLargeintField;
    qryMainLeadEmployeeName: TWideStringField;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TSalesAnalysisGraphDrilldownapptsGUI.FormShow(Sender: TObject);
begin
  Qrymain.DisableControls;
  try
    if Qrymain.Active then Qrymain.Close;
    Qrymain.SQL.Clear;
    Qrymain.SQL.add('Select');
    Qrymain.SQL.add('C.company,');
    Qrymain.SQL.add('A.AppointID ,');
    Qrymain.SQL.add('contacts.EmployeeName as LeadEmployeeName,');
    Qrymain.SQL.add('min(A.AppDate) FirstApptdate ,');
    Qrymain.SQL.add('count(A.AppointID) totalAppts');
    Qrymain.SQL.add('from tblappointments A');
    Qrymain.SQL.add('inner join tblclients C on A.CusID = C.ClientID');
    if IdsTofilter <> '' then Qrymain.SQL.Add(' and A.AppointID in ( ' + IdsTofilter +') ');
    Qrymain.SQL.add('Left join ' +    contactTablename + ' contacts on contacts.ClientID = C.ClientID');
    Qrymain.SQL.add('group by c.ClientID');
    Qrymain.SQL.add('order by  FirstApptdate desc');
    inherited;
  finally
    Qrymain.EnableControls;
  end;
end;
initialization
  RegisterClassOnce(TSalesAnalysisGraphDrilldownapptsGUI);

end.

