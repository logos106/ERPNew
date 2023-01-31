unit frmdebugSQLUpdator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, DAScript, MyScript, ProgressDialog, DNMSpeedButton;

type
  TfmdebugSQLUpdator = class(TBaseInputGUI)
    lstDatabases: TListBox;
    lstFiles: TListBox;
    memdb: TMemo;
    memSQL: TMemo;
    run: TButton;
    conUpdate: TERPConnection;
    scrUpdate: TERPScript;
    QryUpdate: TERPQuery;
    memSQLtoRun: TMemo;
    Button1: TButton;
    Button2: TButton;
    btnDrop: TButton;
    btnSetPassword: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    btnRefresh: TDNMSpeedButton;
    scr: TERPScript;
    Button4: TButton;
    procedure FormShow(Sender: TObject);
    procedure runClick(Sender: TObject);
    procedure scrUpdateError(Sender: TObject; E: Exception; SQL: string;      var Action: TErrorAction);
    procedure scrUpdateAfterExecute(Sender: TObject; SQL: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnDropClick(Sender: TObject);
    procedure btnSetPasswordClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure lstDatabasesClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure scrUpdateBeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure scrBeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure scrAfterExecute(Sender: TObject; SQL: string);
  private
    dblist : Array [1..2] of Array of String;
    minversion:String;

    procedure GetDataBases;
    procedure Getfiles;
    function versionno(dbname: String): String;
    function copyfile(src, tar, backup: String): Boolean;
    procedure getFromnTo(filename: String; var sfrom: String; var sto: String);
    procedure LogSQL(Sender: TObject; var SQL: string; var Omit: Boolean);

  public

    { Public declarations }
  end;


implementation

uses AppEnvironment, AppDatabase, FastFuncs, CommonLib, CommonDbLib, tcConst,
  TransactionsTable, (*COGSAdjustmentLib, *)LogLib, BusObjEmployee,
  busobjProjectnTasks;

{$R *.dfm}

procedure TfmdebugSQLUpdator.scrAfterExecute(Sender: TObject; SQL: string);
begin
  inherited;
  beep;
end;

procedure TfmdebugSQLUpdator.scrBeforeExecute(Sender: TObject; var SQL: string;
  var Omit: Boolean);
begin
  inherited;
  logtext(SQL);
end;

procedure TfmdebugSQLUpdator.scrUpdateAfterExecute(Sender: TObject; SQL: string);
begin
  inherited;
  try
    memSQL.Lines[memSQL.Lines.count-1] := memSQL.Lines[memSQL.Lines.count-1] +'......Done';
  Except
  end;
end;

procedure TfmdebugSQLUpdator.scrUpdateBeforeExecute(Sender: TObject;  var SQL: string; var Omit: Boolean);
begin
  inherited;
  memSQL.Lines.Add(SQL);
end;

procedure TfmdebugSQLUpdator.scrUpdateError(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  inherited;
  memdb.Lines.Add(SQL);
  memdb.Lines.Add(E.Message);
  Action := eacontinue;
end;

procedure TfmdebugSQLUpdator.btnDropClick(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  ProcessingCursor(True);
  try
    With TempMyScript do try
      for ctr:= 0 to lstDatabases.count-1 do begin
        if lstDatabases.selected[ctr] then begin
          if sametext(dblist[1,ctr] , Appenv.AppDb.Database) =False then
            SQL.add('Drop database ' +   dblist[1,ctr]+';');
        end;
      end;
      memSQL.Lines.clear;
      BeforeExecute := LogSQL;
      if SQL.Count >0 then execute;
    finally
      Free;
    end;
    GetDataBases;
    lstDatabases.itemindex := -1;
  finally
    ProcessingCursor(False);
  end;
end;
procedure TfmdebugSQLUpdator.LogSQL(Sender: TObject; var SQL: string;var Omit: Boolean);
begin
  memSQL.Lines.add(SQL);
end;
procedure TfmdebugSQLUpdator.btnRefreshClick(Sender: TObject);
var
  TransactionTableObj: TTransactionTableObj;
begin
TransactionTableObj := TTransactionTableObj.Create(False);
try
(*                            TransactionTableObj.CleanRefreshTrnsTable(True, True,False , True);
                            TransactionTableObj.CreatePermanentSummaryTable;
                            TransactionTableObj.CleanRefreshTrnsTable(True, False, True, true);*)

//MakeCOGSCost(TransactionTableObj, true);
finally
  FreeandNil(TransactionTableObj);
end;
end;
procedure TfmdebugSQLUpdator.btnSetPasswordClick(Sender: TObject);
(*var
  ctr:Integer;
begin
  inherited;
  for ctr:= 0 to lstDatabases.count-1 do begin
    if lstDatabases.selected[ctr] then begin
          ConUpdate.Connected:= false;
          ConUpdate.Database :=dblist[1,ctr];
          ConUpdate.Connected:= True;
           with Tprojectlist.CreateWithNewConn(Self) do try
              connection.connection :=ConUpdate;
              Load;
              New;
              ProjectName := 'ERP';
              Description  := 'ERP';
              PostDB;
              projecttasks.New;
              projecttasks.TaskName := 'API for Tasks';
              projecttasks.TaskLabel := 'Tasks';
              projecttasks.TaskDescription := 'Make API for Tasks';
              projecttasks.PostDB;

              projecttasks.subtasks.New;
              projecttasks.subtasks.SubTaskName := 'DB changes';
              projecttasks.subtasks.SubTaskDescription := 'Make DB relaed changes';
              projecttasks.subtasks.PostDB;

              projecttasks.Comments.New;
              projecttasks.Comments.CommentsName := 'created new tables';
              projecttasks.Comments.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'created new tables';
              projecttasks.Activity.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Populated Test data';
              projecttasks.Activity.PostDB;

              projecttasks.subtasks.New;
              projecttasks.subtasks.SubTaskName := 'API';
              projecttasks.subtasks.SubTaskDescription := 'Make API objectin ERP';
              projecttasks.subtasks.PostDB;

              projecttasks.Comments.New;
              projecttasks.Comments.CommentsName := 'Objects Created';
              projecttasks.Comments.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Project Object';
              projecttasks.Activity.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Task Object';
              projecttasks.Activity.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Sub tasks, Comments, activity objects';
              projecttasks.Activity.PostDB;


              projecttasks.subtasks.New;
              projecttasks.subtasks.SubTaskName := 'Test';
              projecttasks.subtasks.SubTaskDescription := 'test in Web API test';
              projecttasks.subtasks.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Tested in WEBApi Test form';
              projecttasks.Activity.PostDB;

              projecttasks.subtasks.New;
              projecttasks.subtasks.SubTaskName := 'Release ';
              projecttasks.subtasks.SubTaskDescription := 'Release in ERP';
              projecttasks.subtasks.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Release 2022.3.4.0';
              projecttasks.Activity.PostDB;

           finally
             Free;
           end;


           with Tprojectlist.CreateWithNewConn(Self) do try
              connection.connection :=ConUpdate;
              Load;
              New;
              ProjectName := 'VS1';
              Description  := 'VS1 cloud';
              PostDB;
              projecttasks.New;
              projecttasks.TaskName := 'Tasks form';
              projecttasks.TaskLabel := 'Tasks';
              projecttasks.TaskDescription := 'Tasks form';
              projecttasks.PostDB;

              projecttasks.subtasks.New;
              projecttasks.subtasks.SubTaskName := 'Check for APIs';
              projecttasks.subtasks.SubTaskDescription := 'Check for API object';
              projecttasks.subtasks.PostDB;

              projecttasks.Comments.New;
              projecttasks.Comments.CommentsName := 'All objects Available and is working in webapi';
              projecttasks.Comments.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'tested by Rasheed';
              projecttasks.Activity.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Tested by Bruno';
              projecttasks.Activity.PostDB;

              projecttasks.subtasks.New;
              projecttasks.subtasks.SubTaskName := 'Coding';
              projecttasks.subtasks.SubTaskDescription := 'Coding';
              projecttasks.subtasks.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Gui Design';
              projecttasks.Activity.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Coding';
              projecttasks.Activity.PostDB;

              projecttasks.subtasks.New;
              projecttasks.subtasks.SubTaskName := 'Test';
              projecttasks.subtasks.SubTaskDescription := 'Test';
              projecttasks.subtasks.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Tested by Developer';
              projecttasks.Activity.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Tested by Tester';
              projecttasks.Activity.PostDB;

              projecttasks.subtasks.New;
              projecttasks.subtasks.SubTaskName := 'Release ';
              projecttasks.subtasks.SubTaskDescription := 'Release in VS1';
              projecttasks.subtasks.PostDB;

              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Next Release ';
              projecttasks.Activity.PostDB;

           finally
             Free;
           end;

           with Tprojectlist.CreateWithNewConn(Self) do try
              connection.connection :=ConUpdate;
              Load;
              New;
              ProjectName := 'Test Project -1';
              Description  := 'Test Project -1';
              PostDB;
              projecttasks.New;
              projecttasks.TaskName := 'Task-1';
              projecttasks.TaskLabel := 'Task-1';
              projecttasks.TaskDescription := 'Task-1';
              projecttasks.PostDB;

              projecttasks.subtasks.New;
              projecttasks.subtasks.SubTaskName := 'Task-1-Sub-1';
              projecttasks.subtasks.SubTaskDescription := 'Task-1-Sub-1';
              projecttasks.subtasks.PostDB;
              projecttasks.subtasks.New;
              projecttasks.subtasks.SubTaskName := 'Task-1-Sub-2';
              projecttasks.subtasks.SubTaskDescription := 'Task-1-Sub-2';
              projecttasks.subtasks.PostDB;
              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Task-1-Activity-1';
              projecttasks.Activity.PostDB;
              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Task-1-Activity-2';
              projecttasks.Activity.PostDB;
              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Task-1-Activity-3';
              projecttasks.Activity.PostDB;
              projecttasks.Activity.New;
              projecttasks.Activity.ActivityName := 'Task-1-Activity-4';
              projecttasks.Activity.PostDB;

              projecttasks.Comments.New;
              projecttasks.Comments.CommentsName := 'Task-1-Comment-1';
              projecttasks.Comments.PostDB;
              projecttasks.Comments.New;
              projecttasks.Comments.CommentsName := 'Task-1-Comment-2';
              projecttasks.Comments.PostDB;
           finally
             Free;
           end;
      end;
  end;*)
begin

          With TEmployee.CreateWithNewConn(Self) do try
            connection.connection :=ConUpdate;
            Load('firstname = ''Web'' and Lastname =''User''' );
            if count =0 then begin
              New;
              Firstname := 'Web';
              Lastname := 'User';
              DOB := date;
              DateStarted := date;
              Sex :='F';
              EmailsFromEmployeeAddress := False;
              PostDB;
            end;
            if not User.locate('logon_Name', 'WebUser', []) then begin
              User.New;
              User.logon_name :='WebUser';
            end;
            User.LogonPassword :='WebUser';
            User.Postdb;
          finally
            Free;
          end;
          With TEmployee.CreateWithNewConn(Self) do try
            connection.connection :=ConUpdate;
            Load('firstname = ''Admin'' and Lastname =''.''' );
            if count =0 then begin
              New;
              Firstname := 'Admin';
              Lastname := '.';
              DOB := date;
              DateStarted := date;
              Sex :='F';
              EmailsFromEmployeeAddress := False;
              PostDB;
            end;
            if not User.locate('logon_Name', 'Admin', []) then begin
              User.New;
              User.logon_name :='Admin';
            end;
            User.LogonPassword :='Admin';
            User.Postdb;
          finally
            Free;
          end;

          (*ConUpdate.Connected:= false;
          ConUpdate.Database :=dblist[1,ctr];
          ConUpdate.Connected:= True;
          scrUpdate.SQL.clear;
          scrUpdate.SQL.text := 'update tblemployees set Active ="T" where firstname = ''Admin'' and Lastname =''.'' ;' +
                                ' update tblpassword  set logon_Password = ''лочуш'' where logon_Name = ''Admin'';';
          scrUpdate.Execute;*)
end;

procedure TfmdebugSQLUpdator.Button1Click(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  if memSQLtoRun.lines.count = 0 then exit;

  for ctr:= 0 to lstDatabases.count-1 do begin
    if lstDatabases.selected[ctr] then begin
          ConUpdate.Connected:= false;
          ConUpdate.Database :=dblist[1,ctr];
          ConUpdate.Connected:= True;
          scrUpdate.SQL.clear;
          scrUpdate.SQL.text := memSQLtoRun.text;
          scrUpdate.Execute;
    end;
  end;
end;

procedure TfmdebugSQLUpdator.Button2Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  i:= lstDatabases.ItemIndex;
  if i<0 then exit;
  While lstFiles.itemindex>=0 do begin
    lstDatabases.Selected[i]:= True;
    MessageDlgXP_Vista('Wait', mtWarning, [mbOK], 0);
    runClick(sender);
  end;
end;

procedure TfmdebugSQLUpdator.Button3Click(Sender: TObject);
var
  files : TStringlist;
  ctr:Integer;
  filename :String;
begin
  inherited;

    if OpenDialog1.Execute = False then exit;
    if Opendialog1.Files.count =0 then exit;
    files := TStringlist.create;
    try
      files.text := Opendialog1.Files.text;
      DoShowProgressbar(files.count , WAITMSG);
      try
        for ctr:= 0 to files.count-1 do begin
          filename := files[ctr];
          if (filename = '') or not(FileExists(filename)) then continue;
          DoStepProgressbar(filename);
          copyfile(filename, 'u:\SQL\workFlows.wfs', replacestr(filename , '\'+ExtractFileName(fileName), '\done\'+ExtractFileName(fileName))(*'C:\SQLdropbox\done\Workflows.SQL'*));
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      freeandnil(files);
    end;
end;
procedure TfmdebugSQLUpdator.Button4Click(Sender: TObject);
var
  ctr:Integer;
  s:String;
begin
  inherited;
  memdb.lines.clear;
  if not sametext(CustomInputPassword('Login', 'Please Check with ERP that the SQL is Correct Before Proceed!!!!' + chr(13) + 'Please Enter the Password',s) , SPECIALPASSWORD) then begin
    MessageDlgXP_vista('Invaid Password', mtWarning, [mbOK], 0);
    Exit;
  end;
  memdb.lines.add('Restart Default Prefs');

  for ctr:= 0 to lstDatabases.count-1 do begin
    if lstDatabases.selected[ctr] then begin
          ConUpdate.Connected:= false;
          ConUpdate.Database :=dblist[1,ctr];
          ConUpdate.Connected:= True;
          memdb.lines.add(dblist[1,ctr]);
          scrUpdate.SQL.clear;
          scrUpdate.SQL.text := 'update tbldbpreferences set FieldValue ="T" where Name = ''UseBudget'';'+
                                'update tbldbpreferences set FieldValue ="T" where Name = ''UseGoogleAnalytics'';'+
                                'update tbldbpreferences set FieldValue ="T" where Name = ''UseCRM'';'+
                                'update tbldbpreferences set FieldValue ="T" where Name = ''UseDelivery'';'+
                                'update tbldbpreferences set FieldValue ="T" where Name = ''UseFixedAssets'';'+
                                'update tbldbpreferences set FieldValue ="T" where Name = ''UseManufacturing'';'+
                                'update tbldbpreferences set FieldValue ="T" where Name = ''UseWorkShop'';'+
                                'update tbldbpreferences set FieldValue ="T" where Name = ''UseWorkflow'';'+
                                'update tbldbpreferences set FieldValue ="T" where Name = ''ShowEdiIntegration'';'+
                                'update tbldbpreferences set FieldValue ="F" where Name = ''ManufacturePartSourceStock'';'+
                                'update tbldbpreferences set FieldValue ="F" where Name = ''BackupAfterRestart'';'+
                                'update tbldbpreferences set FieldValue ="F" where Name = ''AutoBackup'';'+
                                'update tbldbpreferences set FieldValue ="F" where Name = ''AutoPurgeAuditTrail'';';
          scrUpdate.Execute;
    end;
  end;

end;

function  TfmdebugSQLUpdator.copyfile(src, tar, backup: String):Boolean;
var
  fTar: TextFile;
  lst:TStringlist;
begin
    try
    {$I-}
      lst := tStringList.create;
      lst.LoadFromFile(src);
      try
        try
          Assignfile(FTar, tar);
          if FileExists(tar) then Append(ftar) else Rewrite(ftar);
          Writeln(FTar, lst.text);
          CloseFile(FTar);

          if DirectoryExists(ExtractFileDir(backup)) then begin
            Assignfile(FTar, backup);
            if FileExists(backup) then Append(ftar) else Rewrite(ftar);
            Writeln(FTar, lst.text);
            CloseFile(FTar);
          end;

        Except
          on E:Exception do begin
            lst.SaveToFile(src);
          end;
        end;
      finally
        (*lst.Clear;
        lst.savetofile(src);*)
        DeleteFile(src);
        result := True;
        freeandnil(lst);
      end;
    {$I+}
    except
      on E: Exception do begin
        result := False;
      end;
    end;

end;
procedure TfmdebugSQLUpdator.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmdebugSQLUpdator.FormShow(Sender: TObject);
begin
  inherited;
    memSQLtoRun.Lines.Clear;
    ConUpdate.LoginPrompt      := false;
    ConUpdate.Server           := MyConnection.Server;
    ConUpdate.Port             := MyConnection.Port;
    ConUpdate.Username         := MyConnection.Username;
    ConUpdate.Password         := MyConnection.Password;
    ConUpdate.Options.Compress := MyConnection.Options.Compress;
    ConUpdate.Options.Protocol := MyConnection.Options.Protocol;
    ConUpdate.Port             := MyConnection.Port;
  GetDataBases;
  Getfiles;
  lstDatabases.Selectall;
end;
//Update9020to9030.sql
procedure TfmdebugSQLUpdator.Getfiles;
var
  s:String;
  sr: TSearchRec;
  i,ctr:Integer;
begin

  s:= 'to' +replacestr(minversion , '.' , '')+'.sql';
  lstFiles.Items.Clear;


  if FindFirst('u:\SQL\Old Ver 15\Update*.SQL', faAnyFile, sr) = 0 then begin
    repeat
      lstFiles.Items.add(sr.name);
    until FindNext(sr) <> 0;
  end;
  if FindFirst('U:\SQL\Prior 2020\Update*.SQL', faAnyFile, sr) = 0 then begin
    repeat
      lstFiles.Items.add(sr.name);
    until FindNext(sr) <> 0;
  end;
  if FindFirst('U:\SQL\Done SQLs and Templates\Update*.SQL', faAnyFile, sr) = 0 then begin
    repeat
      lstFiles.Items.add(sr.name);
    until FindNext(sr) <> 0;
  end;
  if FindFirst('U:\SQL\Update*.SQL', faAnyFile, sr) = 0 then begin
    repeat
      lstFiles.Items.add(sr.name);
    until FindNext(sr) <> 0;
  end;
  if FindFirst('C:\SQLdropbox\Update*.SQL', faAnyFile, sr) = 0 then begin
    repeat
      lstFiles.Items.add(sr.name);
    until FindNext(sr) <> 0;
  end;
  lstFiles.Items.add('C:\SQLdropbox\SQL.SQL');

  i:=0;
  for ctr := 0 to lstFiles.count-1 do
    if (pos(s ,  lstFiles.items[ctr]) <> 0) and (not(Sametext(s ,'C:\SQLdropbox\SQL.SQL'))) then begin
      i:= ctr;
      break;
    end;
  if  i>0 then begin
    for ctr:= i downto 0 do begin
      if not (Sametext(lstFiles.items[ctr] , 'C:\SQLdropbox\SQL.SQL')) then
        lstFiles.Items.Delete(ctr);
    end;
  end;
 if FindFirst('u:\SQL\Binny*.SQL', faAnyFile, sr) = 0 then begin
    repeat
      lstFiles.Items.add('u:\SQL\' +sr.name);
    until FindNext(sr) <> 0;
  end;
  if FindFirst('u:\SQL\Ian*.SQL', faAnyFile, sr) = 0 then begin
    repeat
      lstFiles.Items.add('u:\SQL\' +sr.name);
    until FindNext(sr) <> 0;
  end;

  if FindFirst('u:\SQL\Andrei*.SQL', faAnyFile, sr) = 0 then begin
    repeat
      lstFiles.Items.add('u:\SQL\' +sr.name);
    until FindNext(sr) <> 0;
  end;

  lstFiles.itemIndex := 0 ;
end;
procedure TfmdebugSQLUpdator.lstDatabasesClick(Sender: TObject);
var
  filename, sfrom, sto :String;
  ctr:Integer;
begin
  inherited;
  for ctr:= 0 to lstFiles.count-1 do begin
    filename := lstFiles.items[ctr];
    getFromnTo(filename, sFrom, sTo);
    if ((replacestr(dblist[2,lstDatabases.itemindex],'.' , '') = sfrom) and (replacestr(dblist[2,lstDatabases.itemindex],'.' , '') <= sto))  then begin
      lstFiles.itemindex := ctr;
      break;
    end;
  end;
end;
Procedure TfmdebugSQLUpdator.getFromnTo(filename:String; var sfrom:String;var sto:String);
begin
  sFrom := replacestr(filename , 'Update' , '');
  sto := sFrom;
  sfrom := copy(sfrom , 1 , pos('to' , sfrom)-1);
  sto := copy(sto, length(sfrom)+1 , length(sto));
  sto := replaceStr(sto, '.sql', '');
  sto := replaceStr(sto, 'to', '');
  sto:= replacestr(sto, '.' , '');
  sFrom:= replacestr(sFrom, '.' , '');
end;

procedure TfmdebugSQLUpdator.runClick(Sender: TObject);
var
  ctr:Integer;
  filename :String;
  sfrom, sto:String;
  i:Integer;
const
  binny   = 'u:\SQL\Binny';
  Andrei  =  'u:\SQL\andrei';
  ian     =  'u:\SQL\Ian';
begin
  inherited;
  DestroyUserTemporaryTable('tmp1');
  Processingcursor(True);
  try
    if lstDatabases.SelCount =0 then exit;
      i:= lstDatabases.itemindex;

    filename := lstFiles.items[lstFiles.itemindex];
    if sameText(filename  , 'C:\SQLdropbox\SQl.SQL') then else begin
      getFromnTo(filename, sFrom, sTo);
    end;
    memSQL.Lines.Clear;
    for ctr:= 0 to lstDatabases.count-1 do begin
      if lstDatabases.selected[ctr] then begin
        if   (sameText(filename  , 'C:\SQLdropbox\SQl.SQL') ) or
              (sametext(copy(filename , 1, length(binny ))  , Binny))  or
              (sametext(copy(filename , 1, length(Andrei))  , Andrei))  or
              (sametext(copy(filename , 1, length(ian   ))  , Ian))  or
              ((replacestr(dblist[2,ctr],'.' , '') = sfrom) and (replacestr(dblist[2,ctr],'.' , '') < sto)) then begin
            memSQL.Lines.add(dblist[1,ctr] +':-' + filename);
            memdb.Lines.add(dblist[1,ctr] +':-' + filename);
            ConUpdate.Connected:= false;
            ConUpdate.Database :=dblist[1,ctr];
            ConUpdate.Connected:= True;
            if not(Sametext(filename , 'C:\SQLdropbox\SQL.SQL')) and
              not(sametext(copy(filename , 1, length(binny  ))  , Binny)) and
              not(sametext(copy(filename , 1, length(Andrei ))  , Andrei)) and
              not (sametext(copy(filename , 1, length(ian   ))  , Ian)) then begin
              if fileexists('u:\SQL\' +filename) then scrUpdate.SQL.LoadFromFile('u:\SQL\' +filename)
              else if fileexists('U:\SQL\Done SQLs and Templates\' +filename) then scrUpdate.SQL.LoadFromFile('U:\SQL\Done SQLs and Templates\' +filename)
              else if fileexists('U:\SQL\Prior 2020\' +filename) then scrUpdate.SQL.LoadFromFile('U:\SQL\Prior 2020\' +filename)
              else if fileexists('u:\SQL\Old Ver 15\' +filename) then scrUpdate.SQL.LoadFromFile('u:\SQL\Old Ver 15\' +filename)
              else if fileexists('C:\SQLdropbox\' +filename) then scrUpdate.SQL.LoadFromFile('C:\SQLdropbox\' +filename);
            end else scrUpdate.SQL.LoadFromFile(filename);;
            scrUpdate.Execute;
            memSQL.Lines.add('done......');
            memSQL.Lines.add('=======================================================================');
            memdb.Lines.add('done......');
            memdb.Lines.add('=======================================================================');
            if QryUpdate.active then QryUpdate.close;
            QryUpdate.open;
            dblist[2,ctr]:= QryUpdate.fieldbyname('version').asString;
            if QryUpdate.active then QryUpdate.Close;
            scr.Connection := scrUpdate.Connection;
            scr.Execute;
        end;
      end;
    end;
    if lstFiles.Itemindex +1 = lstFiles.count then lstFiles.Itemindex:= -1 else lstFiles.ItemIndex := lstFiles.Itemindex +1;

    GetDataBases;
    try
      if lstDatabases.count>i then begin
        lstDatabases.itemindex := i;
        filename := lstFiles.items[lstFiles.itemindex];
        getFromnTo(filename, sfrom, sto);
        if (sameText(filename  , 'C:\SQLdropbox\SQl.SQL') ) or
                (sametext(copy(filename , 1, length(binny ))  , Binny))  or
                (sametext(copy(filename , 1, length(Andrei))  , Andrei))  or
                (sametext(copy(filename , 1, length(ian   ))  , Ian))  or
                ((replacestr(dblist[2,i],'.' , '') = sfrom) and (replacestr(dblist[2,i],'.' , '') < sto)) then
                lstDatabases.Selected[i] := True;
      end;
    Except

    end;
    if lstDatabases.count >0 then
      if lstFiles.ItemIndex >=0 then
        runClick(run);
  finally
    Processingcursor(False);
  end;
end;
function TfmdebugSQLUpdator.versionno(dbname:String):String;
begin
  if ConUpdate.Connected= false then ConUpdate.Connected:= True;
  if QryUpdate.active then QryUpdate.close;
  QryUpdate.SQL.clear;
  QryUpdate.SQL.add('Select * from ' +dbname+'.tblupdatedetails');
  QryUpdate.open;
  result := QryUpdate.fieldbyname('version').asString;
  if QryUpdate.active then QryUpdate.Close;
end;
procedure TfmdebugSQLUpdator.GetDataBases;
var
  x: integer;
  DbRec: TDatabaseRec;
  ctr:Integer;
begin
  minversion := '';
  ctr:= 0;
  SetLength(dblist[1] , 0);
  SetLength(dblist[2] , 0);
  lstDatabases.Items.Clear;
  for x:= 0 to AppEnv.AppDb.DatabaseList.Count -1 do begin
    DbRec:= TDatabaseRec(AppEnv.AppDb.DatabaseList.Objects[x]);
    //if DbRec.Name <> 'erpnewdb' then begin
    logtext(DbRec.Name);
    try
      ctr:= ctr+1;
      SetLength(dblist[1] , ctr);
      SetLength(dblist[2] , ctr);
      dblist[1, high(dblist[1])] :=DbRec.Name;
      dblist[2, high(dblist[2])] := versionno(DbRec.Name);
      lstDatabases.Items.Add(dblist[1, high(dblist[1])]+ '   -    ' + dblist[2, high(dblist[2])]);
      if minversion = '' then minversion :=DbRec.Version
      else if (DbRec.Version<> '') and (DbRec.Version <minversion) then minversion :=DbRec.Version;
    //end;
    Except
      on E:Exception do begin
        logtext(E.Message);
      end;
    end;
  end;
      ctr:= ctr+1;
      SetLength(dblist[1] , ctr);
      SetLength(dblist[2] , ctr);
      dblist[1, high(dblist[1])] := 'erpnewdb';
      dblist[2, high(dblist[2])] := versionno('erpnewdb');
      lstDatabases.Items.Add(dblist[1, high(dblist[1])]+ '   -    ' + dblist[2, high(dblist[2])]);
      if minversion = '' then minversion :=versionno('erpnewdb')
      else if (versionno('erpnewdb')<> '') and (versionno('erpnewdb') <minversion) then minversion :=versionno('erpnewdb');

end;

Initialization
  RegisterClassOnce(TfmdebugSQLUpdator);

end.

