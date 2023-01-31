unit frmPayRunList;

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
  TUpdateWorker = class;
  TPayRunListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainRunDate: TDateTimeField;
    qryMainSubmitted: TWideStringField;
    qryMainSubmittedDate: TDateField;
    qryMainPaysProcessed: TIntegerField;
    qryMainInvalidated: TWideStringField;
    qryMainFinancialYearFinalRun: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainmsUpdateSiteCode: TWideStringField;
    qryMainMessageUuid: TWideStringField;
    qryMainMessageType: TWideStringField;
    qryMainMessageStatus: TWideStringField;
    qryMainComplete: TWideStringField;
    btnResult: TDNMSpeedButton;
    pnlAutoUpdate: TDNMPanel;
    chkAutoUpdate: TwwCheckBox;
    lblAutoUpdate: TLabel;
    procedure grdMainDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnResultClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkAutoUpdateClick(Sender: TObject);
  private
    Worker: TUpdateWorker;
    procedure DoBeforeShow(Sender: TObject);
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
  public
    procedure UpdateMe; override;
  end;

  TUpdateWorker = class(TThread)
  private
    NextTime: TDateTime;
    fStatusMessage: string;
    ListForm: TPayRunListGUI;
    MySQLServer, Database: string;
    procedure CheckForResponses;
    procedure UpdateStatus;
    procedure RefreshList;
  public
    Running: boolean;
    constructor Create(aListForm: TPayRunListGUI; aMySQLServer, aDatabase: string);

  protected
    procedure Execute; override;
  end;

implementation

uses
  CommonFormLib, CommonLib, frmSTPTestLoad, CommonDbLib, DateUtils, BusObjPayRun,
  MySQLUtils, BusObjBase, ActiveX, ConTnrs, BaseInputForm;

{$R *.dfm}

{ TBaseListingGUI2 }

procedure TPayRunListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Incomplete}
        GroupFilterString := '(Complete = "F")';
      end;
    1:
      begin {Complete}
        GroupFilterString := '(Complete = "T")';
      end;
    2:
      begin {Both}
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TPayRunListGUI.btnResultClick(Sender: TObject);
var
  qry: TMyQuery;
  sl, fl: TStringList;
  x: integer;
begin
  inherited;
  qry := TMyQuery.Create(nil);
  sl := TStringList.Create;
  fl := TStringList.Create;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'select pt.msTimeStamp as RunOn, pr.*, pt.* from tblpayrun pr inner join tblpayruntest pt on pt.payrunid = pr.id';
    qry.Open;
    qry.First;
    while not qry.Eof do begin
      sl.Add('');
      sl.Add('Test Case: ' + qry.FieldByName('TestCaseName').AsString);
      sl.Add('Service: ' + qry.FieldByName('Service').AsString);
      sl.Add('Description: ' + qry.FieldByName('TestCaseDesc').AsString);
      fl.Text := qry.FieldByName('TestCaseFiles').AsString;
      sl.Add('Files:');
      for x := 0 to fl.Count -1 do begin
        sl.Add('    ' + fl[x]);
      end;
      sl.Add('Upload Filename: ' + qry.FieldByName('UploadFileNAme').AsString);
      sl.Add('Performed By: ' + qry.FieldByName('EmployeeName').AsString);
      sl.Add('Performed On: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss',  qry.FieldByName('RunOn').AsDateTime));
      sl.Add('Test Result: ' + qry.FieldByName('TestResult').AsString);
      if qry.FieldByName('TestErrors').AsString <> '' then begin
        sl.Add('Errors:');
        sl.Add(qry.FieldByName('TestErrors').AsString);
      end;

      qry.Next;
    end;
    sl.SaveToFile('ato_stp_conformance_tests.txt');
  finally
    sl.Free;
    fl.Free;
    qry.Free;
  end;
end;

procedure TPayRunListGUI.chkAutoUpdateClick(Sender: TObject);
begin
  inherited;
  Worker.Running := chkAutoUpdate.Checked;
end;

procedure TPayRunListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  if LoadTestSTPData then begin
    self.RefreshQuery;
  end;

end;

procedure TPayRunListGUI.DoBeforeShow(Sender: TObject);
begin
  TBaseInputGUI(Sender).AttachObserver(self);
end;

procedure TPayRunListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Worker.Terminate;
end;

procedure TPayRunListGUI.FormCreate(Sender: TObject);
begin
  btnResult.Visible := CommonLib.DevMode;
  inherited;
  lblAutoUpdate.Caption := '';
  cmdNew.Enabled := CommonLib.DevMode;
  Worker := TUpdateWorker.Create(Self,CommonDbLib.GetSharedMyDacConnection.Server,
    CommonDbLib.GetSharedMyDacConnection.Database);

end;

procedure TPayRunListGUI.grdMainDblClick(Sender: TObject);
begin
//  inherited;
  OpenERPForm('TfmATOPayEvent',qryMainID.AsInteger,nil,DoBeforeShow);
end;

procedure TPayRunListGUI.RefreshQuery;
begin
  qryMain.Close;
  (*if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDateTime := 0;
    qryMain.ParamByName('DateTo').AsDateTime := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDateTime := dtFrom.Date;
    qryMain.ParamByName('DateTo').AsDateTime := dtTo.Date;
  end;*)
  InitDateFromnDateto;
  inherited;

end;

procedure TPayRunListGUI.UpdateMe;
begin
  inherited;
  self.RefreshQuery;
end;

{ TUpdateWorker }

procedure TUpdateWorker.CheckForResponses;
var
  con: TMyConnection;
  qry: TMyQuery;
  ErrorList: TObjectList;
  NewMessageStatus: string;
  s: string;
begin
  con := TMyConnection.Create(nil);
  qry := TMyQuery.Create(nil);
//  CoInitialize(nil);
  try
    SetConnectionProps(con,Database,MySQLServer);
    con.Connect;
    qry.Connection := con;
    qry.SQL.Add('select ID, LastCheckTime, MessageStatus, SubmittedDate, if(Length(ifnull(ATOResponse,"")) = 0, "F", "T") as ResponseReceived');
    qry.SQL.Add('from tblPayRun where Submitted = "T" and Complete = "F"');
    qry.Open;
    while not qry.Eof do begin
      if not qry.FieldByName('ResponseReceived').AsBoolean then begin
        if (qry.FieldByName('LastCheckTime').AsDateTime + (3 * OneMinute)) < now then begin
          ErrorList := TObjectList.Create;
          try
            fStatusMessage := 'Checking Pay Run ' + DateTimeToStr(qry.FieldByName('SubmittedDate').AsDateTime);
            Synchronize(UpdateStatus);
            s := TPayRun.CheckRunStatus(qry.FieldByName('ID').AsInteger,con,ErrorList,NewMessageStatus,false);
            fStatusMessage := '';
            Synchronize(UpdateStatus);
            if (s = '') or ((NewMessageStatus <> '') and (qry.FieldByName('MessageStatus').ASString <> NewMessageStatus)) then begin
              Synchronize(refreshList);
            end;
          finally
            ErrorList.Free;
          end;
        end;
      end;
      qry.Next;
    end;
  finally
//    CoUninitialize;
    qry.Free;
    con.Free;
  end;
end;

constructor TUpdateWorker.Create(aListForm: TPayRunListGUI; aMySQLServer, aDatabase: string);
begin
  inherited Create(false);
  MySQLServer := aMySQLServer;
  Database := aDatabase;
  ListForm := aListForm;
  FreeOnTerminate := true;
  Running := false;
  NextTime := 0;
end;

procedure TUpdateWorker.Execute;
begin
  inherited;
  while not terminated do begin
    try
      Sleep(500);
      if Running and (now > NextTime) then begin
        try
          CheckForResponses;
        finally
          NextTime := now + (OneMinute * 1);
        end;
      end;
    except
    end;
  end;
end;

procedure TUpdateWorker.RefreshList;
begin
  ListForm.RefreshQuery;
end;

procedure TUpdateWorker.UpdateStatus;
begin
  ListForm.lblAutoUpdate.Caption := fStatusMessage;
end;

initialization
  RegisterClass(TPayRunListGUI);

end.
