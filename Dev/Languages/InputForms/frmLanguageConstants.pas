unit frmLanguageConstants;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, AdvEdit, DataTreeBaseObj, ComCtrls,
  ActnList, ExtCtrls, CheckLst, DFMObj, DNMPanel, BaseFormForm, Shader,
  DNMSpeedButton, Menus;

type
  TfmLanguageConstants = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    btnExportEnglishconst: TButton;
    memDetails: TMemo;
    edtProjectFile: TEdit;
    memProjectFiles: TMemo;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    memSQL: TMemo;
    edtFilename: TEdit;
    btnfilename: TDNMSpeedButton;
    OpenDialog: TOpenDialog;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExportEnglishconstClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnfilenameClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    LogFile: TextFile;
    LogFileOpen: boolean;
    dfmList: TStringList;

    procedure PopulateDfmList;
//    function MaxContext(obj: TDFMObject): integer;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{$warnings off}
uses
  {$WARNINGS OFF}FileCtrl{$WARNINGS ON}, CommonLib, CommonDbLib , dmMainGUI, PackageControl,
  AddinPackageInfoObj, DNMAction, typinfo;
{$warnings on}

procedure TfmLanguageConstants.btnfilenameClick(Sender: TObject);
begin
  if edtFilename.text <> '' then
    OpenDialog.FileName:= edtFilename.text;
  if OpenDialog.Execute then
    edtFilename.text:= OpenDialog.FileName;
end;

procedure TfmLanguageConstants.Button1Click(Sender: TObject);
var
  x:Integer;
  DFM: TDFM;

  procedure CheckObject(obj: TDFMObject);
  var
    i, hc: integer;
    s:String;
    comp:Tcomponent;
  begin
    s:= obj.ObjectClass;
    comp :=GetComponentByClassName(s);
    if assigned(comp) then
      for i := 0 to comp.ComponentCount-1 do begin
       try
        hc:=  GetInt64Prop(comp.components[i], 'HelpContext');
        if hc>0 then begin
          s:= '';
          if assigned(comp.components[i].owner) then s:= comp.components[i].owner.classname+'.';
          s:= s+ comp.components[i].classname+'.' +comp.components[i].name+':'+inttostr(hc);
          memDetails.lines.add(s);
        end;
       Except
        // kill exception if help context is not a property of the object
       end;
      end;




  end;

begin
  inherited;
  PopulateDfmList;
  if dfmList.Count = 0 then begin
    ShowMessage('No forms loaded');
    exit;
  end;
  memDetails.lines.clear;
  for x := 0 to dfmList.Count -1 do begin
        DFM:= TDFM.Create;
        try
          try
            DFM.LoadFromFile(dfmList[x]);
            CheckObject(DFM);
          Except
          end;
        finally
          DFM.Free;
        end;
  end;

end;

procedure TfmLanguageConstants.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmLanguageConstants.FormCreate(Sender: TObject);
begin
  edtProjectFile.Text:= Replacestr(Application.ExeName , '.exe', '.dpr');
  dfmList:= TStringList.Create;
  dfmList.Sorted:= true;
end;

procedure TfmLanguageConstants.FormDestroy(Sender: TObject);
begin
  if LogFileOpen then
    CloseFile(LogFile);
  dfmList.Free;
  inherited;  
end;

procedure TfmLanguageConstants.btnExportEnglishconstClick(Sender: TObject);
var
  x, Y: integer;
  DFM: TDFM;
  SelAddinInfo: TAddinPackageInfo;

  Procedure AddIt(description :String; s:String);
  begin
      s:= StringReplace(s , '+'+ #$D#$A , '' , [rfReplaceAll]);
      s:= StringReplace(s , ''' ''', '' , [rfReplaceAll]);
      s:= StringReplace(s , '''' ,'', [rfReplaceAll]);
      if s = '' then exit;
      memDetails.Lines.Add(description + s);
      s:= '(' +Quotedstr(s) +')';
      if memSQL.Lines.count > 0 then s:= ',' +s;
      memSQL.Lines.add(s);
  end;

  Procedure AddConstant(description :String; item: TDFMItem);
  var
    s: string;
  begin
    if item = nil then exit;
    s:= Trim(item.Value);
    if s<> '' then begin
      AddIt(description,s)
    end;
  end;

  procedure CheckObject(obj: TDFMObject);
  var
    i: integer;
  begin
  if Pos(lowercase('TField'), Lowercase(obj.ObjectClass)) = 1 then begin
      AddConstant(obj.ObjectClass+'.DisplayLabel:' ,obj.Items.ItemByName['DisplayLabel']);
  end else begin
    if  (Pos(lowercase('tlabel'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('TForm'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('TDNMSpeedbutton'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('tdnmaction'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('ttabsheet'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('TMenuItem'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('TProgressDialog'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('TCustomInputBox'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('TDNMPanel'), Lowercase(obj.ObjectClass)) = 1) then
            AddConstant(obj.ObjectClass+'.caption:' ,obj.Items.ItemByName['Caption']);

    if  (Pos(lowercase('tlabel'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('tdnmspeedbutton'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('TForm'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('TDNMSpeedbutton'), Lowercase(obj.ObjectClass)) = 1) or
        (Pos(lowercase('tdnmaction'), Lowercase(obj.ObjectClass)) = 1)    then
            AddConstant(obj.ObjectClass+'.hint:' ,obj.Items.ItemByName['Hint']);
  end;
    for i := 0 to obj.Objects.Count -1 do
      CheckObject(obj.Objects.Objects[i]);
  end;
begin
Processingcursor(True);
try
  memSQL.Lines.Clear;
  //memSQL.Lines.add('insert ignore into inEnglish (inenglish) values');

  memProjectFiles.Clear;


  if assigned(dtmMainGUI) then begin
      for x := 0 to dtmMainGUI.componentcount-1 do begin
        if dtmMainGUI.Components[x] is tAction then
          AddIt(dtmMainGUI.Components[x].classname+'.caption:' ,TAction(dtmMainGUI.Components[x]).Caption)
        else if dtmMainGUI.Components[x] is TmenuItem then begin
          AddIt(dtmMainGUI.Components[x].classname+'.caption:' ,TmenuItem(dtmMainGUI.Components[x]).Caption);
          AddIt(dtmMainGUI.Components[x].classname+'.hint:' ,TmenuItem(dtmMainGUI.Components[x]).hint);
        end;

      end;

  end;

  if Assigned(AddInPackageList) then begin
    for x := 0 to AddinPackageList.Count - 1 do begin
      SelAddinInfo := TAddinPackageInfo(AddinPackageList[x]);
      if Assigned(SelAddinInfo.GuiDataModule) then begin

      for Y := 0 to SelAddinInfo.GuiDataModule.componentcount-1 do begin
        if SelAddinInfo.GuiDataModule.Components[y] is tdnmaction then
          AddIt(SelAddinInfo.GuiDataModule.Components[y].classname+'.caption:' ,tdnmaction(SelAddinInfo.GuiDataModule.Components[y]).Caption)
        else if SelAddinInfo.GuiDataModule.Components[y] is TmenuItem then begin
          AddIt(SelAddinInfo.GuiDataModule.Components[y].classname+'.caption:' ,TmenuItem(SelAddinInfo.GuiDataModule.Components[y]).Caption);
          AddIt(SelAddinInfo.GuiDataModule.Components[y].classname+'.hint:' ,TmenuItem(SelAddinInfo.GuiDataModule.Components[y]).hint);
        end;
      end;
      end;
    end;
  end;

  //showmessage(inttostr(memSQL.Lines.count));

  PopulateDfmList;
  if dfmList.Count = 0 then begin
    ShowMessage('No forms loaded');
    exit;
  end;

  for x := 0 to dfmList.Count -1 do begin
    DFM:= TDFM.Create;
    try
      try
        DFM.LoadFromFile(dfmList[x]);
        CheckObject(DFM);
      Except
      end;
    finally
      DFM.Free;
    end;
  end;
  //showmessage(inttostr(memSQL.Lines.count));
  finally
    if memSQL.lines.count >1 then begin
      memSQL.lines[0] := 'insert ignore into inEnglish (inenglish) values  ' + memSQL.lines[0];


      if edtFilename.text = '' then
        if MessageDlgXP_Vista('Do You wish to Save  The Script?' , mtconfirmation , [mbyes,mbno],0) = mryes then
          btnfilename.click;

      if edtFilename.text <> '' then
        memSQL.lines.Savetofile(edtFilename.text);

      if MessageDlgXP_Vista('Do You wish to Add these Values into the English Constant Table?' , mtconfirmation , [mbyes,mbno],0) = mryes then begin
        With TempMyScript do try
          connection := GetNewERPLanguageConnection(self);
          SQl.add('truncate   inEnglish;');
          SQl.add('truncate   languagetranslation;');
          SQl.add(memSQL.lines.text);
          execute;
        finally
          free;
        end;
      end;

    end;
    Processingcursor(False);
  end;



end;

procedure TfmLanguageConstants.PopulateDfmList;
var
  sl,ss: TStringList;
  x: integer;
  s: string;
  dfm: TDFM;
begin
  dfmList.Clear;
  if FileExists(edtProjectFile.text) then begin
    sl:= TStringList.Create;
    ss:= TStringList.Create;
    dfm:= TDFM.Create;
    try
      sl.LoadFromFile(edtProjectFile.text);
      memProjectFiles.Lines.Add('The project forms ...');
      for x:= 0 to sl.Count -1 do begin
        ss.CommaText:= sl[x];
        if ((ss.count = 5) or ((ss.count = 4) and (Copy(ss[3],char_length(ss[3]),1) = ';'))) and
          (ss[1] = 'in') then begin
          s:= Copy(ss[2],2, Pos(ExtractFileExt(ss[2]),ss[2])-2) + '.dfm';
          dfmList.Add(s);
          memProjectFiles.Lines.Add(s);
        end;
      end;
    finally
      sl.Free;
      ss.Free;
      dfm.Free;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfmLanguageConstants);

end.
