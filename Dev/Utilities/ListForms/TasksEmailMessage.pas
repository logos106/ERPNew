unit TasksEmailMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Grids, Wwdbigrd, Wwdbgrid, ProgressDialog, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, StdCtrls, DNMSpeedButton;

type
  TfrmTasksEmailMessage = class(TBaseInputGUI)
    grdTasks: TwwDBGrid;
    qryTasks: TERPQuery;
    dsTasks: TDataSource;
    qryTasksClientName: TWideStringField;
    qryTasksSubject: TWideStringField;
    qryTasksdetails: TWideMemoField;
    qryTasksid: TIntegerField;
    cmdExport: TDNMSpeedButton;
    Label1: TLabel;
    lblEmails: TLabel;
    procedure FormShow(Sender: TObject);
  private
    fTaskIds: string;
    { Private declarations }
  public
    { Public declarations }
    property TaskIds : string read fTaskIds write fTaskIds;
  end;

implementation

{$R *.dfm}

const
  csQry = 'select concat(ifnull(FirstName,""), " ", ifNull(LastName, "")) as ClientName,'#13#10+
        'Subject, details, id'#13#10+
        'from tblTasks T'#13#10+
        'inner join tblClients C on C.ClientCode = T.ClientCode'#13#10+
        'where ((email = "") or (email is null))'#13#10+
        'and (T.ID in (%s))';

procedure TfrmTasksEmailMessage.FormShow(Sender: TObject);
begin
  inherited;
//
  qryTasks.SQL.Text := Format(csQry, [TaskIds]);
  qryTasks.Open;

  if qryTasks.RecordCount = 1 then
    lblEmails.Caption := 'The Client Does Not Have Email Address'
  else
    lblEmails.Caption := 'The Clients Do Not Have Email Addresses';
end;

end.
