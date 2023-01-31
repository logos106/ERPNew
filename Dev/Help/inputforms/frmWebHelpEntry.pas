unit frmWebHelpEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid, WebHelpObj,
  ProgressDialog;

type
  TfmWebHelpEntry = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    qryHelpTreeUrls: TERPQuery;
    dsHelpTreeUrls: TDataSource;
    grdmain: TwwDBGrid;
    qryHelpTreeUrlsID: TIntegerField;
    qryHelpTreeUrlsParentId: TIntegerField;
    qryHelpTreeUrlsCaption: TWideStringField;
    qryHelpTreeUrlsContextId: TIntegerField;
    qryHelpTreeUrlsURL: TWideStringField;
    qryHelpTreeUrlsUpdateTimeStamp: TDateTimeField;
    btnExport: TDNMSpeedButton;
    btnImport: TDNMSpeedButton;
    lblMsg: TLabel;
    qryHelpTreeUrlserphelpdocName: TWideStringField;
    qryHelpTreeUrlsVideoCaption: TWideStringField;
    qryHelpTreeUrlsVideoType: TWideStringField;
    lblNote: TLabel;
    qryHelpTreeUrlsVideoID: TIntegerField;
    DNMPanel4: TDNMPanel;
    lblForm: TLabel;
    lblcontrol: TLabel;
    procedure FormShow(Sender: TObject);
    procedure grdmainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExportClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdmainDblClick(Sender: TObject);
  private
    curID:Integer;
    CurformID:Integer;
    fWebHelpObj: TWebHelpObj;
    procedure ExportHelpURLs;
    procedure ImportHelpURLs;
    procedure onSelectERPHelpDoc(Sender: TwwDbGrid);
    procedure onSelectERPVideo(Sender: TwwDbGrid);
  Protected
    procedure SetConnectionString(const TransactionMode: boolean = true);Override;
  public
    Class Function NewEntry(WebHelp:TWebHelpObj):Boolean;
    Property objWebHelp :TWebHelpObj read fWebHelpObj Write fWebHelpObj;

  end;

implementation

uses CommonLib, CommonDbLib, typinfo, JsonObject, JsonToDatasetFuncs, SystemLib,
  AppEnvironment, SysInfo, tcConst, LogLib, ERPErrorEmailUtils, GridLib,
  CommonFormLib;

{$R *.dfm}
{ TfmWebHelpEntry }

procedure TfmWebHelpEntry.btnCloseClick(Sender: TObject);
begin
  inherited;
  Canceldb(qryHelpTreeUrls);
  RollbackTransaction;
  ModalResult := mrCancel;
end;

procedure TfmWebHelpEntry.btnCompletedClick(Sender: TObject);
var
//  ParentContextId: integer;
  ParentId: integer;
  qry: TERPQuery;
begin
  inherited;
  postDB(qryHelpTreeUrls);
  { copy data into local table }
  qry := TERPQuery.Create(nil);
  try
    ParentId := 0;
    qry.Connection := qryHelpTreeUrls.Connection;
    qryHelpTreeUrls.First;
    while not qryHelpTreeUrls.Eof do begin
      qry.SQL.Text := 'select * from helptreeurlslocal where ContextId = ' +
        IntToStr(qryHelpTreeUrls.FieldByName('ContextId').AsInteger);
      qry.Open;
      if not qry.IsEmpty then begin
        { upate existing }
        if (qry.FieldByName('Caption').AsString <> qryHelpTreeUrls.FieldByName('Caption').AsString) or
           (qry.FieldByName('URL').AsString <> qryHelpTreeUrls.FieldByName('URL').AsString) then begin
          qry.Edit;
          qry.FieldByName('ParentId').AsInteger := ParentId;
          qry.FieldByName('Caption').AsString := qryHelpTreeUrls.FieldByName('Caption').AsString;
          qry.FieldByName('URL').AsString := qryHelpTreeUrls.FieldByName('URL').AsString;
          qry.Post;
        end;
      end
      else begin
        { new record }
        if (qryHelpTreeUrls.FieldByName('ParentId').AsInteger = 0) or { always include parent }
           (qryHelpTreeUrls.FieldByName('Caption').AsString <> '') or
           (qryHelpTreeUrls.FieldByName('URL').AsString <> '') then begin
          qry.Insert;
          qry.FieldByName('ParentId').AsInteger := ParentId;
          qry.FieldByName('Caption').AsString := qryHelpTreeUrls.FieldByName('Caption').AsString;
          qry.FieldByName('URL').AsString := qryHelpTreeUrls.FieldByName('URL').AsString;
          qry.FieldByName('ContextId').AsInteger := qryHelpTreeUrls.FieldByName('ContextId').AsInteger;
          qry.Post;
        end;
      end;
      if (ParentId = 0) and (qry.FieldByName('ParentId').AsInteger = 0) then
        ParentId := qry.FieldByName('ID').AsInteger;

      qryHelpTreeUrls.Next;
    end;
  finally
    qry.Free;
  end;
  CommitTransaction;
  ModalResult := mrOk;
end;

procedure TfmWebHelpEntry.btnExportClick(Sender: TObject);
begin
  inherited;
  ExportHelpURLs;
end;

procedure TfmWebHelpEntry.btnImportClick(Sender: TObject);
begin
  inherited;
  self.ImportHelpURLs;
end;

procedure TfmWebHelpEntry.ExportHelpURLs;
var
  SaveDlg: TSaveDialog;
  qry: TERPQuery;
  json, rec: TJsonObject;
  s: string;
begin
  SaveDlg := TSaveDialog.Create(nil);
  qry := TERPQuery.Create(nil);
  json:= JO;
  try
    SaveDlg.Filter := 'Text files (*.txt)|*.TXT|All files (*.*)|*.*';
    SaveDlg.FileName := SystemLib.GetDesktopDir + 'ExportHelpURLs_' +
      FormatDateTime('yyyy-mm-dd_hh_nn_ss',NowUTC) + '.txt';
    if SaveDlg.Execute then begin
      qry.Connection := MyConnection;
      json.S['EmployeeName'] := AppEnv.Employee.EmployeeName;
      json.S['CurrentServer'] := AppEnv.AppDb.Server;
      json.S['CurrentDatabase'] := AppEnv.AppDb.Database;
      json.S['ComputerName'] := SysInfo.TPJComputerInfo.ComputerName;
      json.S['WindowsUser'] := SysInfo.TPJComputerInfo.UserName;

      qry.SQL.Add('select C.ContextId, C.URL, C.Caption, P.ContextId as ParentContextID, C.UpdateTimeStamp ,');
      qry.SQL.Add('C.erphelpdocName , C.VideoCaption, C.VideoType, C.VideoID ');
      qry.SQL.Add('from helptreeurls C');
      qry.SQL.Add('left join helptreeurls P on C.ParentId = P.ID');
      qry.SQL.Add('where C.URL <> "" or C.Caption <> ""');
      qry.SQL.Add('order by C.ContextId');
      qry.Open;
      while not qry.Eof do begin
        rec := JO;
        JsonToDatasetFuncs.DatasetToJson(qry,rec);
        json.A['helptreeurls'].Add(rec);
        qry.Next;
      end;

      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select C.ContextId, C.URL, C.Caption, P.ContextId as ParentContextID, C.UpdateTimeStamp,');
      qry.SQL.Add('C.erphelpdocName , C.VideoCaption, C.VideoType, C.VideoID ');
      qry.SQL.Add('from helptreeurlslocal C');
      qry.SQL.Add('left join helptreeurlslocal P on C.ParentId = P.ID');
      qry.SQL.Add('where C.URL <> "" or C.Caption <> ""');
      qry.SQL.Add('order by C.ContextId');
      qry.Open;
      while not qry.Eof do begin
        rec := JO;
        JsonToDatasetFuncs.DatasetToJson(qry,rec);
        json.A['helptreeurlslocal'].Add(rec);
        qry.Next;
      end;

      json.SaveToFile(SaveDlg.FileName);

      { clear local table }
      qry.Close;
      qry.SQL.Text := 'truncate helptreeurlslocal';
      qry.Execute;

      s:=  SendEmailtoErp('Help URL export' ,
                                        'Help URL export file Attached'+chr(13) +
                                        'Filename :' + ExtractFileName(SaveDlg.FileName) + chr(13) +
                                        'From     : ' + Appenv.CompanyInfo.Companyname+ chr(13) +
                                        'User     : ' + Appenv.Employee.EmployeeName+ chr(13) +
                                        'Date     : ' +formatDateTime('dd-mm-yyyy hh:nn' , now()) +chr(13)+chr(13)+
                                        'Note for ERP: Run the Application  on Server1, Help entry form -> Import.'+NL+
                                        'Language updator will update it for the users.'  , '' , SaveDlg.FileName  );


      if s = '' then

        CommonLib.MessageDlgXP_Vista('Your Help URL data has been saved as ' + SaveDlg.FileName + #13#10 + #13#10 +
          'This file has also been emailed to ERP Head Office',mtInformation,[mbOk],0)
      else
        CommonLib.MessageDlgXP_Vista('Your Help URL data has been saved as ' + SaveDlg.FileName + #13#10 + #13#10 +
          'Auto emailing failed, please email this file to ERP head office',mtInformation,[mbOk],0)
    end;
  finally
    SaveDlg.Free;
    qry.Free;
    json.Free;
  end;
end;

procedure TfmWebHelpEntry.ImportHelpURLs;
var
  OpenDlg: TOpenDialog;
  qry: TERPQuery;
  qryParentID: TERPQuery;
  json: TJsonObject;
  ctr:Integer;
  MsgOption :Word;

  function GetParentID(aConetxtId: integer): integer;
  begin
    if aConetxtId = 0 then begin
      result := 0;
      exit;
    end;
    if qryParentID.ParamByName('ctx').AsInteger <> aConetxtId then begin
      qryParentID.Close;
      qryParentID.ParamByName('ctx').AsInteger := aConetxtId;
    end;
    if not qryParentID.Active then qryParentID.Open;
    result := qryParentID.FieldByName('ID').AsInteger;
  end;

  procedure DoImport(list: TJsonArray);
  var
    x: integer;
    rec: TJsonObject;
    ParentId: integer;
  begin

    for x := 0 to list.Count -1 do begin
      rec := list.Items[x].AsObject;
      qry.Close;
      qry.SQL.Text := 'select * from helptreeurls where ContextId = ' + IntToStr(rec.I['ContextId']);
      ParentId := GetParentId(rec.I['ParentContextId']);
      qry.Open;
      if qry.IsEmpty then begin
        { add }
        qry.Insert;
        qry.FieldByName('ParentId').AsInteger := ParentId;
        qry.FieldByName('ContextId').AsInteger := rec.I['ContextId'];
        (*if rec.S['Caption'] <> '' then qry.FieldByName('Caption').AsString := rec.S['Caption'];
        if rec.S['URL'] <> '' then qry.FieldByName('URL').AsString := rec.S['URL'];
        qry.Post;*)
      end else begin
(*        { update }
        if (qry.FieldByName('Caption').AsString <> rec.S['Caption']) then begin EditDB(qry);qry.FieldByName('Caption').AsString := rec.S['Caption'];end;
        if (qry.FieldByName('URL').AsString     <> rec.S['URL'])     then begin EditDB(qry);qry.FieldByName('URL').AsString     := rec.S['URL'];    end;
        PostDB(qry);*)
      end;
      { update }
      if (qry.FieldByName('Caption').AsString         <> rec.S['Caption'])        then begin EditDB(qry);qry.FieldByName('Caption').AsString        := rec.S['Caption']       ;end;
      if (qry.FieldByName('URL').AsString             <> rec.S['URL'])            then begin EditDB(qry);qry.FieldByName('URL').AsString            := rec.S['URL']           ;end;
      if (qry.FieldByName('erphelpdocName').AsString  <> rec.S['erphelpdocName']) then begin EditDB(qry);qry.FieldByName('erphelpdocName').AsString := rec.S['erphelpdocName'];end;
      if (qry.FieldByName('VideoCaption').AsString    <> rec.S['VideoCaption'])   then begin EditDB(qry);qry.FieldByName('VideoCaption').AsString   := rec.S['VideoCaption']  ;end;
      if (qry.FieldByName('VideoType').AsString       <> rec.S['VideoType'])      then begin EditDB(qry);qry.FieldByName('VideoType').AsString      := rec.S['VideoType']     ;end;
      if (qry.FieldByName('VideoID').asInteger        <> rec.I['VideoID'])        then begin EditDB(qry);qry.FieldByName('VideoID').asInteger       := rec.I['VideoID']     ;end;
      PostDB(qry);

      if x =0 then LogdsStruct(Qry);
      LogDsData(qry);
    end;
  end;
  function ConfirmtoImport :Boolean;
  begin

    if MsgOption = mryes then begin
      REsult := True;
      Exit;
    end else if msgOption = mrno then begin
      Result := False ;
      Exit;
    end else if (CommonLib.MessageDlgXP_Vista('Import whole list as well as changes?' + NL + NL +' ---- Yes: Whole List'+NL+' ---- No: Only changes' ,mtInformation,[mbYes,mbNo],0) = mrYes) then begin
      MsgOption := mrYes;
      REsult := True;
      Exit;
    end else begin
      MsgOption := mrNo;
      Result := False ;
      Exit;
    end;
  end;
begin
try
  clog('');
  OpenDlg := TOpenDialog.Create(nil);
  OpenDlg.initialDir := 'W:\Development\HelpURLs';
  qry := TERPQuery.Create(nil);
  qryParentID := TERPQuery.Create(nil);
  json:= JO;
  ConfirmtoImport;
  try
    OpenDlg.Filter := 'Text files (*.txt)|*.TXT|All files (*.*)|*.*';
    OpenDlg.Options := OpenDlg.Options +[ofAllowMultiSelect];
    if OpenDlg.Execute then begin
      doshowProgressbar(OpenDlg.files.count, WAITMSG) ;
      try
        for ctr:= 0 to OpenDlg.files.count-1 do begin
          qry.Connection := CommonDbLib.GetNewMyDacConnection(qry,MyConnection.Database);
          qry.Connection.Connect;
          qryParentID.Connection := qry.Connection;
          qryParentID.SQL.Text := 'select ID from helptreeurls where ContextId = :ctx';
          Logtext(OpenDlg.files[ctr]);
          json.LoadFromFile(OpenDlg.files[ctr]);
          if json.ArrayExists('helptreeurls') and (confirmtoImport) then
            DoImport(json.A['helptreeurls']);

          if json.ArrayExists('helptreeurlslocal') then
            DoImport(json.A['helptreeurlslocal']);

          Copyfile(PChar(OpenDlg.files[ctr]),PChar(replaceStr(OpenDlg.files[ctr], ExtractFileDir(OpenDlg.files[ctr]) , ExtractFileDir(OpenDlg.files[ctr]) +'\done')), false);
          Deletefile(OpenDlg.files[ctr]);

          //CommonLib.MessageDlgXP_Vista(OpenDlg.files[ctr] +' has been imported.',mtInformation,[mbOk],0);
          DoStepProgressbar(OpenDlg.files[ctr] +' has been imported.');
        end;
      finally
        DoHideProgressbar;
      end;
    end;
  finally
    OpenDlg.Free;
    qryParentID.Free;
    qry.Free;
    json.Free;
  end;
Except

end;
end;

procedure TfmWebHelpEntry.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmWebHelpEntry.FormCreate(Sender: TObject);
begin
  inherited;
  lblMsg.caption := 'Please Note that changes that you make here are saved locally.'+NL+'It needs to be Exported and sent to the Head office.'+NL+NL+'Head office will review it and update the master list';
end;

procedure TfmWebHelpEntry.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{don't inherit as the inherit is for help}
//  inherited;
end;

procedure TfmWebHelpEntry.FormShow(Sender: TObject);
var
  hc:Integer;
  ParentID:Integer;
  Function CompContextIDFilter:String;
  var
    i:Integer;
  begin
    Result := '';
    if Assigned(fWebHelpObj.Curcomp) then begin
      i:= GetInt64Prop(fWebHelpObj.curcomp, 'HelpContext');
      if i <> 0 then Result := ' OR (ContextID = ' + inttostr(i)+') ';
    end;
  end;
begin
  inherited;
   closedb(qryHelpTreeUrls);
   qryHelpTreeUrls.SQl.clear;
   qryHelpTreeUrls.SQl.add('select * from helptreeurls '+
                          ' where (contextId >= ' + inttostr(fWebHelpObj.Curform.helpcontext)+
                          ' and  contextId <= ' + inttostr(fWebHelpObj.Curform.helpcontext)+' +999  )'+
                          compcontextIDFilter +
                          ' order by contextId');
   qryHelpTreeUrls.open;
   BeginTransaction;

   ParentID := 0;
   curID:= 0;
   CurformID:= 0;
   hc:=  GetInt64Prop(fWebHelpObj.Curform, 'HelpContext');
   if hc <> 0 then begin
     if not qryHelpTreeUrls.locate('contextID' , hc,[]) then begin
      qryHelpTreeUrls.Append;
      qryHelpTreeUrls.fieldbyname('contextID').asInteger := hc;
      qryHelpTreeUrls.fieldbyname('ParentId').asInteger := 0;
      Caption :=fWebHelpObj.Curform.caption;
      qryHelpTreeUrls.Post;
     end;
     ParentID:= qryHelpTreeUrls.fieldByname('id').asInteger;
     curID:=ParentID;
     CurformID:= qryHelpTreeUrls.fieldByname('id').asInteger;
   end;

   if fWebHelpObj.curcomp <> nil then begin
     hc:=  GetInt64Prop(fWebHelpObj.curcomp, 'HelpContext');
     if hc <> 0 then begin
       if not qryHelpTreeUrls.locate('contextID' , hc,[]) then begin
        qryHelpTreeUrls.Append;
        qryHelpTreeUrls.fieldbyname('contextID').asInteger := hc;
        qryHelpTreeUrls.fieldbyname('ParentId').asInteger := ParentID;
        qryHelpTreeUrls.Post;
       end;
       curID:= qryHelpTreeUrls.fieldByname('id').asInteger;
     end;
   end;

   grdmain.setActiveField('url');
   lblForm.Font.color := clGreen;
   lblcontrol.Font.color := clred;
end;

class Function TfmWebHelpEntry.NewEntry(WebHelp:TWebHelpObj):Boolean;
begin
  REsult:= false;
  With TfmWebHelpEntry(GetComponentByClassName('TfmWebHelpEntry')) do try
    ObjWebHelp := WebHelp;
    if Showmodal = mrOk then result := True;;
  finally
    Free;
  end;
end;

procedure TfmWebHelpEntry.SetConnectionString(const TransactionMode: boolean);
begin
  inherited;
  with GetNewERPLanguageConnection(Self) do try
    MyConnection.Server := Server;
    MyConnection.Username := Username;
    MyConnection.Password := Password;
    MyConnection.Database := Database;
    MyConnection.Port := Port;
  finally
    Free;
  end;
end;

procedure TfmWebHelpEntry.grdmainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryHelpTreeUrlsID.asInteger = curId then begin
    AFont.color := clred;
  end;
  if qryHelpTreeUrlsID.asInteger = CurformID then begin
    AFont.color := clGreen;
  end;
end;

procedure TfmWebHelpEntry.grdmainDblClick(Sender: TObject);
begin
  inherited;
  if sametext(GridLib.ActiveField(grdmain).fieldname , qryHelpTreeUrlserphelpdocName.fieldname) then begin
    OpenERPListFormSingleselectModal('TERPPDFDocsGUI', onSelectERPHelpDoc)   ;
  end else if sametext(GridLib.ActiveField(grdmain).fieldname , qryHelpTreeUrlsVideoCaption.fieldname) then begin
    OpenERPListFormSingleselectModal('TERPVideosGUI', onSelectERPVideo)   ;
  end;
end;
procedure TfmWebHelpEntry.onSelectERPVideo(Sender: TwwDbGrid);
var
  ds : TDataSet;
begin
  ds := Sender.DataSource.DataSet;
  editdb(qryHelpTreeUrls);
  qryHelpTreeUrlsVideoCaption.asString :=  ds.fieldbyname('PageCaption').asString;
  qryHelpTreeUrlsVideoType.asString :=  ds.fieldbyname('VideoType').asString;
  qryHelpTreeUrlsVideoID.asInteger :=  ds.fieldbyname('Id').asInteger;

  Postdb(qryHelpTreeUrls);
end;

procedure TfmWebHelpEntry.onSelectERPHelpDoc(Sender: TwwDbGrid);
var
  ds : TDataSet;
begin
  ds := Sender.DataSource.DataSet;
  editdb(qryHelpTreeUrls);
  qryHelpTreeUrlserphelpdocName.asString :=  ds.fieldbyname('Description').asString;
  Postdb(qryHelpTreeUrls);
end;
initialization
  RegisterClass(TfmWebHelpEntry);
end.
