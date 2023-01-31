unit frmMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls, DNMPanel,
  StdCtrls, Buttons, OleCtrls, SHDocVw, BaseGrid, AdvGrid, AdvCGrid, ExcMagic,
  XMLIntf, jpeg;

type
  TDefaultExcFilter = class(TInterfacedObject, IExcMagicFilter)
    function ShowException(ExceptionObject: TObject; Title: string; ExceptionMessage: string; CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): integer;
    function LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: integer; CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): integer;
    function ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo; Buffer: PChar; BufferSize: integer; CustomInfo: TStrings): integer;
  end;

  TfrmMenuGUI = class(TForm)
    DNMPanel1: TDNMPanel;
    grdVideos: TAdvColumnGrid;
    ImageHeader: TImage;
    CancelBtn: TDNMSpeedButton;
    grdTopics: TAdvColumnGrid;
    procedure FormShow(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdTopicsClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure grdVideosClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure grdTopicsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    CurrentTopic:String;
    TopicList:TList;
    FileName:String;
    VideoPath:String;
    procedure ClearGrid;
    procedure LoadXMLList;
    procedure LoadTopics;
    procedure LoadVideos(Const TopicName: String);
    function GetVideoFilePath(Const Col, Row: Integer): string;
    function ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
    function GetXMLNodeStringValue(const Node: IXMLNode; Const aNodeName: string): string;
    function GetXMLNodeIntegerValue(const Node: IXMLNode; Const aNodeName: string): integer;    
  public
    { Public declarations }
  end;

var
  frmMenuGUI: TfrmMenuGUI;
  DefaultExcFilter: TDefaultExcFilter;

implementation

uses
  ShellAPI,XMLDoc,xmldom, StrUtils;

type
  PTopicRecord = ^TTopic;
  TTopic = record
    DisplayName : string;
    Column : Integer;
    Videos : TList;
  end;

  PTopicVideoRecord = ^TTopicVideo;
  TTopicVideo = record
    No : Integer;
    DisplayName : string;
    Column : Integer;
    FileName : string;
  end;

Const
  TopicColumnsCount = 3;
  TopicColumnsWidth_0 = 240;
  TopicColumnsWidth_1 = 240;
  TopicColumnsWidth_2 = 240;

  VideoColumnsCount = 3;
  VideoColumnsWidth_0 = 240;
  VideoColumnsWidth_1 = 240;
  VideoColumnsWidth_2 = 240;

  NoFileColor = clRed;

{$R *.dfm}

{ TDefaultExcFilter }

function TfrmMenuGUI.ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := Source + Delim;
  S := 1;
  for L9 := 1 to PosCount - 1 do begin
    S := Pos(Delim, Src);
    if S > 0 then Delete(Src, S, Length(Delim))
    else Break;
  end;
  Result := '';
  if S > 0 then begin
    E      := Pos(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;

// --------- IXMLDocument/Node functions ---------------------------------------

function TfrmMenuGUI.GetXMLNodeStringValue(const Node: IXMLNode; Const aNodeName: string): string;
var
  ValNode: IXMLNode;
begin
  Result := '';
  if Node = nil then Exit;
  ValNode := Node.ChildNodes.FindNode(aNodeName);
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Result := ValNode.NodeValue;
end;

function TfrmMenuGUI.GetXMLNodeIntegerValue(const Node: IXMLNode; Const aNodeName: string): integer;
var
  ValNode: IXMLNode;
begin
  Result := 0;
  if Node = nil then Exit;
  ValNode := Node.ChildNodes.FindNode(aNodeName);
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Result := ValNode.NodeValue;
end;

function TDefaultExcFilter.ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo; Buffer: PChar; BufferSize: integer; CustomInfo: TStrings): integer;
const
  DEFAULT_EXCEPTION_MSG_BRIEF: PChar =
    'Exception ''%s'' in module %s at %p'#13#10'%s';
  DEFAULT_EXCEPTION_MSG_FULL: PChar  =
    'Exception ''%s'' in module %s at %p'#13#10 +
    '%s'#13#10#13#10 +
    'Module: %s, Source: %s, Line %s'#13#10 +
    'Procedure: %s';
  UNKNOWN: string = 'UNKNOWN';
begin
  with MessageInfo do
    if excDlgLocation in ExceptionHook.Options then
      StrLFmt(Buffer, BufferSize, DEFAULT_EXCEPTION_MSG_FULL,
        [ExceptionObject.ClassName,
        miModuleName,
        miModuleAddress,
        miMessage,
        ExtractFileName(miSrcModule),
        ExtractFileName(miSrcFile),
        miSrcLine,
        miSrcProc])
  else
    StrLFmt(Buffer, BufferSize, DEFAULT_EXCEPTION_MSG_BRIEF,
      [ExceptionObject.ClassName,
      miModuleName,
      miModuleAddress,
      miMessage]);

  Result := EXC_FILTER_CONTINUE;
end;

function TDefaultExcFilter.LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: integer; CallStack, Registers, CustomInfo: TStrings): integer;
const
  CRLF: word = $0A0D;
  HDRLINE    = '---------------------------';
  ADDITIONAL_TITLE: string = 'Additional info:'#13#10;
var
  HLog: THandle;
  S: string;
  Written: DWORD;
begin
  if ExceptionHook.LogFile <> '' then begin
    HLog := CreateFile(PChar(ExceptionHook.LogFile), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if HLog <> INVALID_HANDLE_VALUE then begin
      SetFilePointer(HLog, 0, nil, FILE_END);
      {S := HDRLINE + LocalTimeStr + HDRLINE + #13#10;}
      S := HDRLINE + DateTimeToStr(Now) + HDRLINE + #13#10;
      WriteFile(HLog, S[1], Length(S), Written, nil);
      WriteFile(HLog, Buffer^, BufferSize, Written, nil);
      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, nil);
      // write call stack
      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, nil);
      WriteFile(HLog, PChar(CallStack.Text)^, Length(CallStack.Text), Written, nil);
      // write registers
      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, nil);
      WriteFile(HLog, PChar(Registers.Text)^, Length(Registers.Text), Written, nil);
      // write custom info
      if Length(CustomInfo.Text) > 0 then begin
        WriteFile(HLog, CRLF, SizeOf(CRLF), Written, nil);
        WriteFile(HLog, ADDITIONAL_TITLE[1], Length(ADDITIONAL_TITLE), Written, nil);
        WriteFile(HLog, PChar(CustomInfo.Text)^, Length(CustomInfo.Text), Written, nil);
      end;

      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, nil);
      CloseHandle(HLog);
    end;
  end;

  Result := EXC_FILTER_CONTINUE;
end;

function TDefaultExcFilter.ShowException(ExceptionObject: TObject; Title, ExceptionMessage: string; CallStack, Registers, CustomInfo: TStrings): integer;
begin
  Writeln(ExceptionMessage);
  Writeln;
  if excDlgCallStack in ExceptionHook.Options then
    Writeln(CallStack.Text);
  if excDlgRegisters in ExceptionHook.Options then
    Writeln(Registers.Text);
  if excDlgCustomInfo in ExceptionHook.Options then
    Writeln(CustomInfo.Text);
  Result := EXC_FILTER_CONTINUE;
end;

procedure TfrmMenuGUI.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenuGUI.FormCreate(Sender: TObject);
var
  Path :string;
begin
  TopicList := TList.Create;
  Path := ExtractFilePath(Application.ExeName);
  FileName := Path + 'TrainingVideos.xml';
  VideoPath := Path + 'Videos\';

  grdTopics.Columns[0].Width := TopicColumnsWidth_0;
  grdTopics.Columns[1].Width := TopicColumnsWidth_1;
  grdTopics.Columns[2].Width := TopicColumnsWidth_2;

  GrdVideos.Columns[0].Width := VideoColumnsWidth_0;
  GrdVideos.Columns[1].Width := VideoColumnsWidth_1;
  GrdVideos.Columns[2].Width := VideoColumnsWidth_2;
end;

procedure TfrmMenuGUI.ClearGrid;
begin
  grdVideos.Clear;
  grdVideos.RowCount := 1;
  grdVideos.Refresh;
  Self.Update;
end;

procedure TfrmMenuGUI.FormShow(Sender: TObject);
begin
  LoadXMLList;
  LoadTopics;
  ClearGrid;
  LoadVideos(grdTopics.Cells[0,0]);
end;

procedure TfrmMenuGUI.FormDestroy(Sender: TObject);
Var
  Topic: TTopic;
  Videos : TList;
begin
  If Assigned(TopicList) then Begin
    while TopicList.Count > 0 do begin
      Topic := PTopicRecord(TopicList[0])^;
      Videos := Topic.Videos;
      If Assigned(Videos) then begin
        while Videos.Count > 0 do begin
          Dispose(PTopicVideoRecord(Videos[0]));
          Videos.Delete(0);
        end;
        Videos.Free;
      end;        
      Dispose(PTopicRecord(TopicList[0]));
      TopicList.Delete(0);
    end;
    TopicList.Free;
  end;
end;

procedure TfrmMenuGUI.LoadXMLList;
var
  XMLDoc   :TXMLDocument;
  RootXMLNode  :IXMLNode;
  XMLTopicNode      :IXMLNode;
  XMLVideosNode :IXMLNode;
  XMLVideoNode :IXMLNode;
  dm        :TDataModule;
  iTopic,iVideos :Integer;
  TopicRecord: PTopicRecord;
  VideosRecord: PTopicVideoRecord;
  VideoList: TList;
begin
  VideoList := Nil;
  dm := TDataModule.Create(nil);
  XMLDoc := TXMLDocument.Create(dm);
  try
    XMLDoc.LoadFromFile(Filename);
    XMLDoc.Active := True;
    RootXMLNode := XMLDoc.ChildNodes.FindNode('Topics');
    if Assigned(RootXMLNode) then Begin
      for iTopic := 0 to RootXMLNode.ChildNodes.Count -1 do begin
        XMLTopicNode :=  RootXMLNode.ChildNodes[iTopic];
        New(TopicRecord);
        TopicRecord^.DisplayName := GetXMLNodeStringValue(XMLTopicNode,'DisplayName');;
        TopicRecord^.Column := GetXMLNodeIntegerValue(XMLTopicNode,'Column');
        XMLVideosNode := XMLTopicNode.ChildNodes.FindNode('Videos');
        if Assigned(XMLVideosNode) then Begin
          VideoList := TList.Create;
          for iVideos := 0 to XMLVideosNode.ChildNodes.Count -1 do begin
            XMLVideoNode :=  XMLVideosNode.ChildNodes[iVideos];
            New(VideosRecord);
            VideosRecord^.No := GetXMLNodeIntegerValue(XMLVideoNode,'No');
            VideosRecord^.DisplayName := GetXMLNodeStringValue(XMLVideoNode,'DisplayName');
            VideosRecord^.Column := GetXMLNodeIntegerValue(XMLVideoNode,'Column');
            VideosRecord^.FileName := GetXMLNodeStringValue(XMLVideoNode,'FileName');
            VideoList.Add(VideosRecord);
          end;
        end;
        TopicRecord^.Videos := VideoList;
        TopicList.Add(TopicRecord);
      end;
    end;
  finally
     freeAndNil(XMLDoc);
     FreeAndNil(dm);
  end;
end;

procedure TfrmMenuGUI.LoadTopics;
Var
  TopicCount :Integer;
  Topic: TTopic;
  R1,R2,R3 :Integer;
begin
  R1 := 0;
  R2 := 0;
  R3 := 0;
  If Assigned(TopicList) then Begin
    for TopicCount := 0 to TopicList.Count -1 do begin
      Topic := PTopicRecord(TopicList[TopicCount])^;
      If Topic.Column=1 then Begin
        grdTopics.Cells[Topic.Column-1,R1] := Topic.DisplayName;
        Inc(R1);
        If (grdTopics.RowCount<R1) then grdTopics.RowCount := R1;
       end else If Topic.Column=2 then Begin
        grdTopics.Cells[Topic.Column-1,R2] := Topic.DisplayName;
        Inc(R2);
        If (grdTopics.RowCount<R2) then grdTopics.RowCount := R2;
      end else If Topic.Column=3 then Begin
        grdTopics.Cells[Topic.Column-1,R3] := Topic.DisplayName;
        Inc(R3);
        If (grdTopics.RowCount<R3) then grdTopics.RowCount := R3;
      end;
    end;
  end;
end;

procedure TfrmMenuGUI.LoadVideos(const TopicName: String);
Var
  TopicCount :Integer;
  Topic: TTopic;
  VideosCount :Integer;
  VideosList : TList;
  Video :TTopicVideo;
  R1,R2,R3 :Integer;
begin
  R1 := 0;
  R2 := 0;
  R3 := 0;
  If Assigned(TopicList) then Begin
    for TopicCount := 0 to TopicList.Count -1 do begin
      Topic := PTopicRecord(TopicList[TopicCount])^;
      If SameText(Topic.DisplayName,TopicName) then Break;
    end;
    CurrentTopic := Topic.DisplayName;
    VideosList := Topic.Videos;
    If Assigned(VideosList) then Begin
      for VideosCount := 0 to VideosList.Count -1 do begin
        Video := PTopicVideoRecord(VideosList[VideosCount])^;
        If Video.Column=1 then Begin
          grdVideos.Cells[Video.Column-1,R1] := IntToStr(Video.No) + '. ' + Video.DisplayName;
          If not FileExists(GetVideoFilePath(Video.Column-1,R1)) then
            grdVideos.FontColors[Video.Column-1,R1] := NoFileColor;
          Inc(R1);
          If (grdVideos.RowCount<R1) then grdVideos.RowCount := R1;
         end else If Video.Column=2 then Begin
          grdVideos.Cells[Video.Column-1,R2] := IntToStr(Video.No) + '. ' + Video.DisplayName;
          If not FileExists(GetVideoFilePath(Video.Column-1,R2)) then
            grdVideos.FontColors[Video.Column-1,R2] := NoFileColor;
          Inc(R2);
          If (grdVideos.RowCount<R2) then grdVideos.RowCount := R2;
        end else If Video.Column=3 then Begin
          grdVideos.Cells[Video.Column-1,R3] := IntToStr(Video.No) + '. ' + Video.DisplayName;
          If not FileExists(GetVideoFilePath(Video.Column-1,R3)) then
            grdVideos.FontColors[Video.Column-1,R3] := NoFileColor;
          Inc(R3);
          If (grdVideos.RowCount<R3) then grdVideos.RowCount := R3;
        end;
      end;
    end;
  end;
end;

procedure TfrmMenuGUI.grdTopicsClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  ClearGrid;
  LoadVideos(grdTopics.Cells[ACol,ARow]);
  grdVideos.Refresh;
  Self.Update;
end;

Function TfrmMenuGUI.GetVideoFilePath(const Col, Row: Integer):String;
Var
  TopicCount :Integer;
  Topic: TTopic;
  VideosCount :Integer;
  VideosList : TList;
  Video :TTopicVideo;
  VideoName :String;
begin
  Result := '';
  VideoName := Trim(ExtractStrPortion(grdVideos.Cells[Col,Row],'.',2));
  If Assigned(TopicList) then Begin
    for TopicCount := 0 to TopicList.Count -1 do begin
      Topic := PTopicRecord(TopicList[TopicCount])^;
      If SameText(Topic.DisplayName,CurrentTopic) then Break;
    end;
    VideosList := Topic.Videos;
    If Assigned(VideosList) then Begin
      for VideosCount := 0 to VideosList.Count -1 do begin
        Video := PTopicVideoRecord(VideosList[VideosCount])^;
        If SameText(Video.DisplayName,VideoName) then Begin
          Result := VideoPath + Video.FileName;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TfrmMenuGUI.grdVideosClickCell(Sender: TObject; ARow, ACol: Integer);
Var
  TempFile :String;
begin
  TempFile := GetVideoFilePath(ACol,ARow);
  if FileExists(TempFile) then
    ShellExecute(0, 'OPEN', PChar(TempFile), nil, nil, sw_shownormal);
end;

procedure TfrmMenuGUI.grdTopicsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  ClearGrid;
  LoadVideos(grdTopics.Cells[ACol,ARow]);
  grdVideos.Refresh;
  Self.Update;
end;

end.

