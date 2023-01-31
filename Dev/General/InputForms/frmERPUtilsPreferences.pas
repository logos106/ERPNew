unit frmERPUtilsPreferences;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DNMPanel, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, wwcheckbox, Mask, wwdbedit, Wwdotdot, Wwdbcomb, Grids,
  Wwdbigrd, Wwdbgrid;

type
  TfmERPUtilsPreferences = class(TForm)
    pnlUtilsconf: TDNMPanel;
    lblTitle: TLabel;
    Bevel1: TBevel;
    QryERPUtils: TERPQuery;
    dsERPUtils: TDataSource;
    wwDBGrid1: TwwDBGrid;
    MyConnection1: TERPConnection;
    QryERPUtilsID: TIntegerField;
    QryERPUtilsDescription: TWideStringField;
    QryERPUtilsEnableOnStartup: TWideStringField;
    QryERPUtilsEnableOntimer: TWideStringField;
    QryERPUtilstimerinterval: TIntegerField;
    QryERPUtilstimerStartupDelay: TIntegerField;
    cboInterval: TwwDBComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fsTablename :String;
    { Private declarations }
  public
    procedure Load;
    Procedure Save;
  end;

var
  fmERPUtilsPreferences: TfmERPUtilsPreferences;

implementation

uses DbSharedObjectsObj, CommonDbLib, LogLib;
const
  UtilPropertis : Array [1..21] of String = ('GoLive',
                                            'AuditTrailPurge',
                                            'Email',
                                            'DeleteTempTables',
                                            'GoogleCalendar',
                                            'GoogleAppointment',
                                            'GoogleTask',
                                            'ScheduledReports',
                                            'Ping',
                                            'ValidateTime',
                                            'InactiveUser',
                                            'UpdateBatch',
                                            'SMSSend',
                                            'SMSReceive',
                                            'General',
                                            'GoogleQueue',
                                            'ClearInUseTables',
                                            'CustomProcess',
                                            'FileCleanup',
                                            'DocDownload',
                                            'OffsiteBackup');
  Panelheight = 40;
  Chk1Left = 260;
  Chk2Left = 330;
  itemtop = 10;
  ChkWidth = 16;
  ItemHeight = 16;
  cbLeft = 390;
  cbWidth = 120;

{$R *.dfm}
procedure TfmERPUtilsPreferences.FormDestroy(Sender: TObject);
begin
   DestroyUserTemporaryTable(fsTablename);
   inherited;
end;

procedure TfmERPUtilsPreferences.Load;
var
  cmd :TERPCommand;
  ctr:Integer;
begin
  inherited;
  if QryERPUtils.active then QryERPUtils.close;
  fsTablename := CommonDbLib.GetUserTemporaryTableName('ERPutilPrefs' );

  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    cmd.SQL.Clear;
    cmd.SQL.Add('Drop table if exists '+ fstablename +';');
    cmd.SQL.Add('Create Table '+ fstablename +'( ' +
                      ' ID INT(11) NOT NULL AUTO_INCREMENT, ' +
                      ' Description VARCHAR(255) NOT NULL, ' +
                      ' EnableOnStartup ENUM(''T'',''F'') NOT NULL DEFAULT ''F'', ' +
                      ' EnableOntimer ENUM(''T'',''F'') NOT NULL DEFAULT ''F'', ' +
                      ' timerinterval INT(11) , ' +
                      ' timerStartupDelay INT(11) , ' +
                      ' PRIMARY KEY (ID) )COLLATE=''utf8_general_ci'' ENGINE=MyISAM ;');
    for ctr:= high(UtilPropertis) downto low(UtilPropertis)  do begin
      cmd.SQL.Add('Insert ignore into  '+ fstablename +'( ID, Description ,EnableOnStartup , EnableOntimer , timerinterval , timerStartupDelay) '+
                  ' Select ' + inttostr(ctr)+' as ID, '+
                  quotedstr(UtilPropertis[ctr])+' as Description, '+
                  'Enable_' +UtilPropertis[ctr]+'_Check_OnStartup as EnableOnStartup, ' +
                  'Enable_' +UtilPropertis[ctr]+'_Check as EnableOntimer, ' +
                  UtilPropertis[ctr]+'_Check_Interval as timerinterval ,'+
                  UtilPropertis[ctr]+'_Check_StartupDelay as timerStartupDelay '+
                  ' from Services.tblerpfunctionsconf where ID =1;');
    end;
    clog(cmd.SQL.Text);
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;

  QryERPUtils.SQl.text := 'select * from '+fsTablename+' order by Description';
  QryERPUtils.Open;
end;

procedure TfmERPUtilsPreferences.Save;
var
  ctr:Integer;
  cmd :TERPCommand;
begin
  inherited;
  if QryERPUtils.state in [dsEdit,dsInsert] then QryERPUtils.Post;

  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try

    for ctr:= high(UtilPropertis) downto low(UtilPropertis)  do begin
      cmd.SQL.Add('update Services.tblerpfunctionsconf T1, '+ fstablename +' as T2 Set   ' +
                  ' T1.Enable_' +UtilPropertis[ctr]+'_Check_OnStartup = T2.EnableOnStartup, ' +
                  ' T1.Enable_' +UtilPropertis[ctr]+'_Check = T2.EnableOntimer, ' +
                  ' T1.'+ UtilPropertis[ctr]+'_Check_Interval = T2.timerinterval, '+
                  ' T1.'+ UtilPropertis[ctr]+'_Check_StartupDelay = T2.timerStartupDelay '+
                  ' Where T2.ID ='+ inttostr(ctr)+' and T1.Id = 1;');
    end;
    clog(cmd.SQL.Text);
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

procedure TfmERPUtilsPreferences.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  if assigned(Owner) then
    if owner is Tform then
      color :=Tform(owner).color;
end;

end.
