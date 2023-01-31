unit frmVS1_cloudDBSetUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, DAScript,
  MyScript;

type
  TfmVS1_cloudDBSetUp = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdNew: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    ERPScript1: TERPScript;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure onScriptBeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure DoProcess;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib, AppEnvironment, BusObjEmployee, utVS1Const, DbSharedObjectsObj,
  CommonDbLib, DNMLib, ModuleConst, utCloudconst;

{$R *.dfm}

procedure TfmVS1_cloudDBSetUp.cmdCloseClick(Sender: TObject);
begin
  inherited;
  self.close;
end;

procedure TfmVS1_cloudDBSetUp.cmdNewClick(Sender: TObject);
begin
  Processingcursor(True);
  try
    DoProcess;
  finally
    Processingcursor(False);
  end;
end;
procedure TfmVS1_cloudDBSetUp.DoProcess;
var
  emp:TEmployee;
  scr :TERPScript;
  qry :TERPQuery;
begin
  inherited;
  Memo1.Lines.Add('Varify the logged in Database is '+ VS1_Admin_DB_Sandbox+'');
  if not sametext(Appenv.appdb.Database, VS1_Admin_DB_Sandbox) then begin
    MessageDlgXP_Vista('Please Create and Login into '+ VS1_Admin_DB_Sandbox+' database', mtWarning, [mbOK], 0);
    Exit;
  end;
  Memo1.Lines.Add('......  Done');

  emp:= TEmployee.CreateWithNewConn(self);
  try
    Memo1.Lines.Add('Check for User - ' + ERP_ADMIN_USER);
    emp.loadselect('employeename=' +quotedstr(ERP_ADMIN_USER));
    if emp.count =0 then begin
      emp.New;
      emp.Firstname := ERP_ADMIN_USER;
      emp.DefaultClassName := Appenv.defaultclass.DefaultClassName;
      emp.PostDB;
    end;
    emp.executeSQL('insert ignore into tblpassword set '+
                  'EmployeeId = ' + inttostr(emp.id)+', '+
                  'Logon_Name = '+quotedstr(ERP_ADMIN_USER)+', '+
                  'Logon_Password =' +  quotedstr(EnCrypt(ERP_ADMIN_TOKEN, 'z'))+','+
                  'PasswordDate = curdate();', true);
    Memo1.Lines.Add('......  Done');
    Memo1.Lines.Add('Check for User - ' + ERP_CLOUD_ADMIN_USER);
    emp.loadselect('employeename=' +quotedstr(ERP_CLOUD_ADMIN_USER));
    if emp.count =0 then begin
      emp.New;
      emp.Firstname := ERP_CLOUD_ADMIN_USER;
      emp.DefaultClassName := Appenv.defaultclass.DefaultClassName;
      emp.PostDB;
    end;
    emp.executeSQL('insert ignore into tblpassword set '+
                  'EmployeeId = ' + inttostr(emp.id)+', '+
                  'Logon_Name = '+quotedstr(ERP_CLOUD_ADMIN_USER)+', '+
                  'Logon_Password =' +  quotedstr(EnCrypt(ERP_CLOUD_ADMIN_TOKEN, 'z'))+','+
                  'PasswordDate = curdate();', true);

    Memo1.Lines.Add('......  Done');
    Memo1.Lines.Add('Check for User - WebUser');
    emp.loadselect('employeename=' +quotedstr('WebUser'));
    if emp.count =0 then begin
      emp.New;
      emp.Firstname := 'WebUser';
      emp.DefaultClassName := Appenv.defaultclass.DefaultClassName;
      emp.PostDB;
    end;
    emp.executeSQL('insert ignore into tblpassword set '+
                  'EmployeeId = ' + inttostr(emp.id)+', '+
                  'Logon_Name = '+quotedstr('WebUser')+', '+
                  'Logon_Password =' +  quotedstr(EnCrypt('WebUser', 'z'))+','+
                  'PasswordDate = curdate();', true);

  Memo1.Lines.Add('......  Done');
  Memo1.Lines.Add('Make VS1 tables in Services');
  if OpenDialog1.Execute and FileExists(OpenDialog1.FileName) then begin
    scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
    try
      scr.BeforeExecute := onScriptBeforeExecute;
      scr.SQL.loadFromfile(OpenDialog1.FileName);
      try
        scr.Execute;
        Memo1.Lines.Add('......  Done');
      Except
        on E:Exception do begin
          MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
        end;
      end;
    finally
      scr.BeforeExecute := nil;
      DbSharedObj.ReleaseObj(scr);
    end;
  end;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Memo1.Lines.Add('Check for VS1 client Databsaes and drop them');
    qry.SQL.TExt:='SHOW databases LIKE "vs1_cloud_db_%"';
    qry.open;
    if qry.recordcount >0 then begin
      qry.First;
      scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
      try
        scr.BeforeExecute := onScriptBeforeExecute;
        scr.SQL.clear;
        While qry.EOF = False do begin
          scr.SQL.Add('Drop database if exists '+ qry.Fields[0].asString+';');
          qry.Next;
        end;
        scr.Execute;
        Memo1.Lines.Add('......  Done');
      finally
        scr.BeforeExecute := nil;
        DbSharedObj.ReleaseObj(scr);
      end;
    end else begin
      Memo1.Lines.Add('.... None Found');
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  finally
    Freeandnil(emp);
  end;
end;

procedure TfmVS1_cloudDBSetUp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmVS1_cloudDBSetUp.FormShow(Sender: TObject);
begin
  inherited;
  Memo1.Lines.Clear;
end;

procedure TfmVS1_cloudDBSetUp.onScriptBeforeExecute(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  inherited;
  Memo1.Lines.add(SQL+' ......');
end;

Initialization
  RegisterClassOnce(TfmVS1_cloudDBSetUp);

end.
