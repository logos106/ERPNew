unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppVarsObj, StdCtrls, Buttons, AdvEdit, DataTreeBaseObj, ComCtrls,
  ActnList, ExtCtrls, CheckLst, DFMObj;

type
  TfmMain = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    btnGo: TButton;
    btnStop: TButton;
    memLog: TMemo;
    chkReassign: TCheckBox;
    Label2: TLabel;
    Label1: TLabel;
    edtFormInc: TAdvEdit;
    edtContextDir: TEdit;
    btnContextFile: TBitBtn;
    TabSheet2: TTabSheet;
    edtProjectFile: TEdit;
    btnProjectFile: TBitBtn;
    Label3: TLabel;
    OpenDialog: TOpenDialog;
    memProj: TMemo;
    btnGetForms: TButton;
    ActionList1: TActionList;
    TabSheet3: TTabSheet;
    lstForms: TCheckListBox;
    Label5: TLabel;
    grpFormType: TRadioGroup;
    TabSheet4: TTabSheet;
    memExcludeList: TMemo;
    Label4: TLabel;
    Button1: TButton;
    TabSheet5: TTabSheet;
    Panel1: TPanel;
    btnFixProps: TButton;
    memFixProps: TMemo;
    chkReplaceContext: TCheckBox;
    btnCheckAll: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnContextFileClick(Sender: TObject);
    procedure edtFormIncChange(Sender: TObject);
    procedure edtContextDirChange(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure btnProjectFileClick(Sender: TObject);
    procedure edtProjectFileChange(Sender: TObject);
    procedure btnGetFormsClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnFixPropsClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
  private
    LogFile: TextFile;
    LogFileOpen: boolean;
    Stopped: boolean;
    dfmList: TStringList;

    procedure Log(const msg: string; showTime: boolean = true);
    procedure AssignContexts;
    function GetExistingMaxFormContext(AllFileList: TStringList): integer;
    function GetExistingMaxComponentContext(Node: TDataTreeNodeBase): integer;
    procedure PopulateDfmList;
    procedure LoadExcludeList;
    procedure SaveExcludeList;
    procedure AssignContextsToSelected(FixWrongId: boolean = false);
    function MaxFormContext: integer;
//    function MaxContext(obj: TDFMObject): integer;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

{$warnings off}
uses
  FileCtrl,
{$warnings on}
  IntegerListObj;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  LogFileOpen:= false;
  AppVars:= TAppVars.Create;
  AppVars.LoadFromFile();
  AppVars.SetDefault('FormIncrement','1000');
  AppVars.SetDefault('FormContextFile','AppContexts.xml');

  edtFormInc.IntValue:= AppVars.IntVar['FormIncrement'];
  edtContextDir.Text:= AppVars['FormContextDir'];
  edtProjectFile.Text:= AppVars['ProjectFile'];
//  LoadExcludeList;


  dfmList:= TStringList.Create;
  dfmList.Sorted:= true;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  SaveExcludeList;
  if AppVars.Dirty then
    AppVars.SaveToFile();
  AppVars.Free;
  if LogFileOpen then
    CloseFile(LogFile);
  dfmList.Free;
  inherited;  
end;

procedure TfmMain.btnCheckAllClick(Sender: TObject);
begin
  lstForms.CheckAll(cbChecked);
end;

procedure TfmMain.btnContextFileClick(Sender: TObject);
var
  tmpDir:String;
begin
  tmpDir := edtContextDir.text;
  FileCtrl.SelectDirectory('', '', tmpDir);
  edtContextDir.text := tmpDir;
end;

procedure TfmMain.btnFixPropsClick(Sender: TObject);
var
  x: integer;
  DFM: TDFM;
  labelcount: integer;
  lblCaption: string;
  sl: TStringList;

  procedure CheckObject(obj: TDFMObject);
  var
    i: integer;
    item: TDFMItem;
  begin
    if Pos('tdnmpanel', Lowercase(obj.ObjectClass)) = 1 then begin
      item:= obj.Items.ItemByName['Transparent'];
      if (not Assigned(item)) or (Assigned(item) and (Trim(item.Value) = 'True')) then begin
//        memFixProps.Lines.Add('    Panel Trasparent needs fixing: ' + obj.Name);

      end;
      item:= obj.Items.ItemByName['ParentColor'];
      if (not Assigned(item)) or (Assigned(item) and (Trim(item.Value) = 'False')) then begin
//        memFixProps.Lines.Add('    Panel ParentColor needs fixing: ' + obj.Name);

      end;
    end;
    if Pos('tlabel', Lowercase(obj.ObjectClass)) = 1 then begin
      inc(labelcount);
      item:= obj.Items.ItemByName['Caption'];
      lblCaption:= '';
      if Assigned(item) then
        lblCaption:= Trim(item.Value);
      memFixProps.Lines.Add('    label: ' + obj.Name + '  ' + lblCaption);
      if lblCaption <> '' then
        sl.Add('"' + lblCaption + '"');

    end;
    for i := 0 to obj.Objects.Count -1 do
      CheckObject(obj.Objects.Objects[i]);
  end;


begin
  if dfmList.Count = 0 then begin
    ShowMessage('No forms loaded');
    exit;
  end;
  labelcount:= 0;
  sl:= TStringList.Create;
  try
    for x := 0 to dfmList.Count -1 do begin
      memFixProps.Lines.Add('Checking .. ' + dfmList[x]);
      DFM:= TDFM.Create;
      try
        DFM.LoadFromFile(dfmList[x]);
        CheckObject(DFM);
      finally
        DFM.Free;
      end;

    end;
    memFixProps.Lines.Add('Total labels found: ' + IntToStr(labelcount));
    memFixProps.Lines.Add('Total forms: ' + IntToStr(dfmList.Count));
    memFixProps.Lines.Add('Finished');
    sl.Sorted:= true;
    sl.SaveToFile('c:\erp label captions.txt');
  finally
    sl.Free;
  end;
end;

procedure TfmMain.edtFormIncChange(Sender: TObject);
begin
  AppVars.IntVar['FormIncrement']:= edtFormInc.IntValue;
end;

procedure TfmMain.edtContextDirChange(Sender: TObject);
begin
  AppVars['FormContextDir']:= edtContextDir.Text;
end;

procedure TfmMain.Log(const msg: string; showTime: boolean = true);
var
  fName: string;
  s: string;
begin
  if not LogFileOpen then begin
    fName:= Copy(Application.ExeName,1,length(Application.ExeName)-3)+ 'log';
    AssignFile(LogFile, fName);
    if FileExists(fName) then
      Append(LogFile)
    else
      Rewrite(LogFile);
    LogFileOpen:= true;
  end;

  if ShowTime then
    s:= FormatDateTime('dd/mm/yy hh:nn:ss',now) + '  ' +  msg
  else
    s:= msg;  
  WriteLn(LogFile,s);
  Flush(LogFile);

  memLog.Lines.Add(s);
  while memLog.Lines.Count > 1000 do
    memLog.Lines.Delete(0);

end;

procedure TfmMain.btnStopClick(Sender: TObject);
begin
  Stopped:= True;
end;

procedure TfmMain.btnGoClick(Sender: TObject);
begin
  if chkReassign.Checked then begin
    if MEssageDlg('Are you sure you want to reassign all Help Contexts, this will overwrite existing ones?',mtWarning,[mbYes,mbNo],0) = mrNo then
      exit;

  end;
  Stopped:= false;
  AssignContexts;
end;

procedure TfmMain.AssignContexts;
var
  Tree: TDataTreeBase;
  node: TDataTreeNodeBase;
  MaxFormContext, MaxComponentContext: integer;
  I,x: integer;
  dfm: TDFM;
  startTime: TDateTime;
  s: string;
  AppContextFileList:TStringList;

  procedure AddFile(Dir: string; List: TStringList);
  var
    R: TSearchRec;
  begin
    if FindFirst(Dir + '\*.xml', faAnyFile	, R) = 0 then
    begin
      if (R.Attr and faAnyFile	 <> 0) and
         (R.Name <> '.') and
         (R.Name <> '..') then
        List.Add(Dir + '\' + R.Name);
      while FindNext(R) = 0 do
        if (R.Attr and faAnyFile <> 0) and
           (R.Name <> '.') and
           (R.Name <> '..') then Begin
            List.Add(Dir + '\' + R.Name);
          end;
    end;
    FindClose(R);
  end;

  procedure SubAssign(node: TDataTreeNodeBase; doAssign: boolean = true);
  var
    i: integer;
    dfmObj, dfmObjParent: TDFMObject;
  begin
    if Stopped then
      exit;
    if (node.NodeName = 'UnitName') or (node.NodeName = 'FormName') then
      exit;

    { get the corresponding dfm object- create it if not exists }
    dfmObj:= dfm.ObjectByFullName[node.NodePath];
    if not Assigned(dfmObj) then begin
      { create object and add to dfm }
      dfmObjParent:= dfm.ObjectByFullName[node.Parent.NodePath];
      if Assigned(dfmObjParent) then begin
        dfmObj:= TDFMObject.Create;
        dfmObj.InheritanceType:= itInherited;
        dfmObj.Name:= node.NodeName;
        dfmObj.ObjectClass:= node['ClassName'].AsString;
        dfmObjParent.Objects.Add(dfmObj);
        Log('  Created inherited object: ' + dfmObj.FullName);
      end
      else begin
        Log('Error - could not create inherited object ' + node.NodeName +
          ', could not find parent object ' + node.Parent.NodeName + ' in dfm file.');
        Stopped:= true;
        exit;
      end;
    end;

    if doAssign then begin
      if chkReassign.Checked or
         (node.Exists('HelpContext') and (node['HelpContext'].AsInteger = 0)) then begin
        MaxComponentContext:= MaxComponentContext + 1;
        dfmObj.Items.AddOrReplace('HelpContext', IntToStr(MaxComponentContext));
        Log('  ' + dfmObj.FullName + ' = ' + dfmObj.Items.ItemByName['HelpContext'].Value);
      end;
    end;
    for i:= 0 to node.Count-1 do begin
      if node.Items[i].Count > 0 then begin
        SubAssign(node.Items[i]);
      end;
    end;
  end;

begin
  If not SysUtils.DirectoryExists(edtContextDir.Text) then Exit;
  Tree:= TDataTreeBase.Create;
  dfm:= TDFM.Create;
  node:= TDataTreeNodeBase.Create;
  AppContextFileList := TStringList.Create;
  try
    startTime:= now;
    Log('');
    Log('Starting process ...');
    AppContextFileList.Clear;
    AddFile(edtContextDir.Text,AppContextFileList);

    MaxFormContext:= 0;
    if not chkReassign.Checked then
      MaxFormContext:= GetExistingMaxFormContext(AppContextFileList);

    for I := 0 to AppContextFileList.Count-1 do Begin
      if Stopped then
        break;

      Tree.LoadFromFile(AppContextFileList[I]);
//      Log('Found ' + IntToStr(Tree.Count) + ' forms in file to process.');


      for x:= 0 to Tree.Count -1 do begin
        { form loop }
        if Stopped then
          break;

        If not FileExists(Tree.Items[x]['FormName'].AsString) then begin
          Log('FAILED to Process File: ' + AppContextFileList[I] +' - DFM : '+ Tree.Items[x]['FormName'].AsString);
          Break;
        end;

        Log('Processing Form: ' + Tree.Items[x]['FormName'].AsString + '  ' +
          IntToStr(I+1) + ' of ' + IntToStr(AppContextFileList.Count));
        try
          dfm.LoadFromFile(Tree.Items[x]['FormName'].AsString);
          s:= Tree.Items[x]['FormName'].AsString;
          CopyFile(PChar(s), PChar(StringReplace(s,'.dfm', '_' + formatDateTime('yymmdd_hhnnss',startTime) + '.bak',[])), false);
        except
          on E: exception do begin
            Log('Error loading dfm with message: ' + E.Message);
            Stopped:= true;
            break;
          end;
        end;
        MaxComponentContext:= 0;
        if not chkReassign.Checked then
          MaxComponentContext:= GetExistingMaxComponentContext(Tree.Items[x]);
        Log('  Existing max HelpContext for form = ' + IntToStr(MaxComponentContext));

        node.XML:= Tree.Items[x].XML;
        if chkReassign.Checked or (node.Exists('HelpContext') and (node['HelpContext'].AsInteger = 0)) then begin
          MaxFormContext:= MaxFormContext + edtFormInc.IntValue;
          dfm.Items.AddOrReplace('HelpContext',IntToStr(MaxFormContext));
        end;
        if MaxComponentContext = 0 then
          MaxComponentContext:= MaxFormContext;

        subAssign(node, false);

        dfm.SaveToFile();
      end;
    end;
  finally
    Tree.Free;
    dfm.Free;
    node.Free;
    AppContextFileList.Free;
  end;
  Log('Allocation complete!');
end;

function TfmMain.GetExistingMaxFormContext(AllFileList: TStringList): integer;
var
  I,x: integer;
  Tree: TDataTreeBase;
begin
  result:= 0;
  Tree:= TDataTreeBase.Create;
  Try
    for I := 0 to AllFileList.Count-1 do Begin
      Tree.LoadFromFile(AllFileList[I]);
      for x:= 0 to Tree.Count -1 do begin
        if Tree.Items[x]['HelpContext'].AsInteger > result then
          result:= Tree.Items[x]['HelpContext'].AsInteger;
       end;
    end;        
  finally
    Tree.Free;
  end;
  Log('Existing max form HelpContext found = ' + IntToStr(result));
end;

function TfmMain.GetExistingMaxComponentContext(Node: TDataTreeNodeBase): integer;

  procedure CheckSub(node: TDataTreeNodeBase);
  var i: integer;
  begin
    if node.Exists('HelpContext') and (node['HelpContext'].AsInteger > result) then
      result:= node['HelpContext'].AsInteger;
    for i:= 0 to node.Count-1 do begin
      CheckSub(node.Items[i]);
    end;
  end;

begin
  result:= 0;
  CheckSub(Node);
end;

procedure TfmMain.btnProjectFileClick(Sender: TObject);
begin
  if edtProjectFile.text <> '' then
    OpenDialog.FileName:= edtProjectFile.text;
  if OpenDialog.Execute then
    edtProjectFile.text:= OpenDialog.FileName;
end;

procedure TfmMain.edtProjectFileChange(Sender: TObject);
begin
  AppVars['ProjectFile']:= edtProjectFile.Text;
  LoadExcludeList;
end;

procedure TfmMain.btnGetFormsClick(Sender: TObject);
begin
  memProj.Clear;
  PopulateDfmList;
  memProj.Lines.SaveToFile('Project form help context info.txt');
  ShowMessage(IntToStr(lstForms.Count) + ' forms added!');
end;

procedure TfmMain.PopulateDfmList;
var
  sl,ss: TStringList;
  x: integer;
  s: string;
  dfm: TDFM;

  function TrimBrac(s: string): string;
  begin
    result:= Copy(s,2,Length(s) -2);
  end;

begin
  dfmList.Clear;
  lstForms.Clear;
  if FileExists(AppVars['ProjectFile']) then begin
    sl:= TStringList.Create;
    ss:= TStringList.Create;
    dfm:= TDFM.Create;
    try
      sl.LoadFromFile(AppVars['ProjectFile']);
      if not SetCurrentDir(ExtractFilePath(AppVars['ProjectFile'])) then begin
        ShowMessage('Could not set current directory to dpr directory');
        exit;
      end;
      memProj.Lines.Add('The project forms ...');
      sl.SORT;
      for x:= 0 to sl.Count -1 do begin
        ss.CommaText:= sl[x];
        if ((ss.count = 5) or ((ss.count = 4) and (Copy(ss[3],Length(ss[3]),1) = ';'))) and
          (ss[1] = 'in') then begin
          s:= Copy(ss[2],2, Pos(ExtractFileExt(ss[2]),ss[2])-2) + '.dfm';
(*          if x = 2122 then
            beep;*)
          if memExcludeList.Lines.IndexOf(s) < 0 then begin
            dfmList.Add(s);
            dfm.LoadFromFile(s);
            if grpFormType.ItemIndex = 0 then begin
              {add all}
              lstForms.AddItem(s,nil);
              memProj.Lines.Add(s);
            end
            else if grpFormType.ItemIndex = 1 then begin
              {no help context}
              if Assigned(dfm.Items['HelpContext']) and (Trim(dfm.Items['HelpContext'].Value) <> '') then begin
                { ignore }
              end
              else begin
                lstForms.AddItem(s,nil);
                memProj.Lines.Add(s);
              end;
            end
            else if grpFormType.ItemIndex = 2 then begin
              {no help context or invalid id's}
              if Assigned(dfm.Items['HelpContext']) and (Trim(dfm.Items['HelpContext'].Value) <> '') then begin
                if dfm.HasInvalidId(AppVars.IntVar['FormIncrement']) then begin
                  lstForms.AddItem(s,nil);
                  memProj.Lines.Add(s);
                end;
              end
              else begin
                lstForms.AddItem(s,nil);
                memProj.Lines.Add(s);
              end;
            end
            else if grpFormType.ItemIndex = 3 then begin
              { invalid id's }
              if Assigned(dfm.Items['HelpContext']) and (Trim(dfm.Items['HelpContext'].Value) <> '') then begin
                if dfm.HasInvalidId(AppVars.IntVar['FormIncrement']) then begin
                  lstForms.AddItem(s,nil);
                  memProj.Lines.Add(s);
                end;
              end;
            end;
          end;

        end;
      end;
    finally
      sl.Free;
      ss.Free;
      dfm.Free;
    end;
  end;
end;

procedure TfmMain.LoadExcludeList;
begin
  if AppVars['ProjectFile'] <> '' then begin
    memExcludeList.Lines.CommaText:= AppVars['Exclude_' + AppVars['ProjectFile']];
  end;
end;

procedure TfmMain.SaveExcludeList;
begin
  if AppVars['ProjectFile'] <> '' then begin
    AppVars['Exclude_' + AppVars['ProjectFile']]:= memExcludeList.Lines.CommaText;
  end;
end;

procedure TfmMain.AssignContextsToSelected(FixWrongId: boolean = false);
var
  nextFormId, nextId: integer;
  x: integer;
  dfm: TDFM;
  BaseFormId: integer;
  IdList: TIntegerList;

  function IdIsValid(str: string): boolean;
  var
    val: integer;
  begin
    result := true;
    if not FixWrongId then exit;
    val := StrToIntDef(str,0);
    result := BaseFormId = Trunc(val / AppVars.IntVar['FormIncrement']);
    if result and (val <> 0) and IdList.InList(Val) then
      result := false
    else
      IdList.Add(Val);
  end;

  procedure AssignObjContext(obj: TDFMObject; var nxtId: integer);
  var idx: integer;
  begin
    if (obj.IsGUIControl) and
    ((not Assigned(obj.Items['HelpContext'])) or
     (Trim(obj.Items['HelpContext'].Value) = '') or
     (Trim(obj.Items['HelpContext'].Value) = '0') or
     (not IdIsValid(Trim(obj.Items['HelpContext'].Value))) or
     (chkReplaceContext.Checked)) then begin
      obj.Items.AddOrReplace('HelpContext',IntToStr(nxtId));
      Inc(nxtId);
    end;
    for idx:= 0 to obj.Objects.Count -1 do
      AssignObjContext(obj.Objects.Objects[idx], nxtId);
  end;

begin
  memProj.Lines.Add('Geting current max form context ...');
  Application.ProcessMessages;
  nextFormId:= MaxFormContext + AppVars.IntVar['FormIncrement'];
  memProj.Lines.Add('Max context = ' + IntToStr(nextFormId));
  Application.ProcessMessages;
  dfm:= TDFM.Create;
  IdList := TIntegerList.Create;
  try
    for x:= 0 to lstForms.Count -1 do begin
      if lstForms.Checked[x] then begin
        memProj.Lines.Add('Assigning contexts to: ' + lstForms.Items[x]);
        Application.ProcessMessages;
        dfm.LoadFromFile(lstForms.Items[x]);
        IdList.Clear;
        if (not Assigned(dfm.Items['HelpContext'])) or (Trim(dfm.Items['HelpContext'].Value) = '') then begin
          dfm.Items.AddOrReplace('HelpContext',IntToStr(NextFormId));
          nextFormId:= nextFormId + AppVars.IntVar['FormIncrement'];
        end;
        nextId:= dfm.MaxFormID(AppVars.IntVar['FormIncrement']) + 1; //  dfm.MaxHelpContext(AppVars.IntVar['FormIncrement']) + 1;
        BaseFormId := Trunc(StrToInt(Trim(dfm.Items['HelpContext'].Value)) / AppVars.IntVar['FormIncrement']);
        AssignObjContext(dfm, nextId);
        dfm.SaveToFile();
      end;
    end;
  finally
    IdList.Free;
    dfm.Free;
  end;
end;

function TfmMain.MaxFormContext: integer;
var
  x: integer;
  dfm: TDFM;
  maxID, id: integer;
begin
  dfm:= TDFM.Create;
  try
    maxId:= 0;
    for x:= 0 to dfmList.Count -1 do begin
      dfm.LoadFromFile(dfmList[x]);
      if Assigned(dfm.Items['HelpContext']) and (Trim(dfm.Items['HelpContext'].Value) <> '') then begin
        id := StrToInt(Trim(dfm.Items['HelpContext'].Value));
        if id > maxId then maxId:= id;
      end;

    end;
  finally
    dfm.Free;
  end;
  result:= maxId;
end;

procedure TfmMain.Button1Click(Sender: TObject);
begin
  memProj.Lines.Add('Start - Assign Contexts ...');
  Application.ProcessMessages;
  AssignContextsToSelected(true);
  memProj.Lines.Add('Assign Contexts Done!');
  ShowMessage('Done');
end;

//function TfmMain.MaxContext(obj: TDFMObject): integer;
//var
//  x, id: integer;
//begin
//  result:= 0;
//  if Assigned(obj.Items['HelpContext']) and (Trim(obj.Items['HelpContext'].Value) <> '') then begin
//    result:= StrToInt(Trim(obj.Items['HelpContext'].Value);
//  end;
//  for x:= 0 to obj.Objects.Count -1 do begin
//    id:= MaxContext(obj.Objects[x]);
//    if id > result then
//      result:= id;
//  end;
//end;

end.
