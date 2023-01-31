unit ReportTemplateBase;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 16/12/05  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Db,  StdCtrls, Buttons, DNMSpeedButton, MemDS, DBAccess, Contnrs,
  {^Need These Use To Keep OPtion in Report Builder}
  ppDB, ppDBPipe,
  ppTypes, ppMemo, ppRichTx, ppCtrls, ppBarCod, ppBarCode2D,
  myChkBox,myChkBoxDesign, ppRegion, ppReport, ppSubRpt, ppPageBreak, ppCTMain,
  ppVar, ppStrtch, ppPrnabl, ppClass, ppBands, ppCache, ppComm, ppRelatv,
  ppProd, ppEndUsr, ExtCtrls,
  {ppWWRichEd,} wwriched,
  {TeeProcs, TeEngine,
  ppChrt, Chart,
  ppChrtDP , DbChart,
  ppChrtUI, ppPDFDevice, ppZLib,}
  {^}
  MyAccess,ERPdbComponents, frmDesigner, JsonObject;

type
  TReportGroup = class(TObject)
  private
    FDataSource: TDataSource;
    FPipeline: TppDBPipeline;
    FMyQuery: TERPQuery;
    FPipelineUserName: string;
  public
    constructor Create(const Form: TForm); reintroduce;
    destructor Destroy; override;
    property DataSource: TDataSource read FDataSource;
    property Pipeline: TppDBPipeline read FPipeline;
    property MyQuery: TERPQuery read FMyQuery;
    property PipelineUserName: string read FPipelineUserName write FPipelineUserName;
  end;

  TReportTemplateBase = class(TObject)
  private
    FForm: TfmDesigner;
    FReport: TppReport;
    FDesigner: TppDesigner;
    FMyConnection: TCustomMyConnection;
    FGroupList: TObjectList;
    FReportStream: TStream;
    FMaxPreview: Boolean;
    fHelpEvent: TPPHelpEvent;
    fCreatedOk: boolean;
    fOnLoadTemplate: TNotifyEvent;
    //fOnPreviewFormCreate: TNotifyEvent;
    fBeforePrint: TNotifyEvent;
    procedure QueryAfterOpen(DataSet: TDataSet);
    procedure HandleHelp(Sender: TObject; var aHelpFile,aKeyphrase: String; var aCallHelp: Boolean);
    function GetReportGroupByName(const aName: string): TReportGroup;
    function getPrintername: String;
    procedure setPrintername(const Value: String);
    procedure DoBeforePrint(Sender: TObject);
    procedure DoOnLoadTemplate(Sender: TObject);
    //procedure DoOnPreviewFormCreate(Sender: TObject);

  protected
    fUserMsgInfo : string;
    fUserMsgWarn : string;
    procedure AddReportGroup;
    procedure SetConnections;
    procedure SetReportProperties;
    function GetReportGroup(const Index: Integer): TReportGroup;
    procedure SetMyConnection(const Connection: TCustomMyConnection);
    function GetPipelineUserName(const Index: Integer): string;
    procedure SetPipelineUserName(const Index: Integer; const Value: string);
    procedure SetMaxPreview(const Value: Boolean);
    procedure ChangeRegionSettings;
    function ReportHasDatapipes:Boolean;
    Procedure UserMsgInfo(Const value:String);Virtual;
    Procedure UserMsgWarn(Const value:String);Virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ReportPageRequest(Sender, APageRequest: TObject);
    procedure DesignerActivate(Sender: TObject);
    procedure DesignerShow(Sender: TObject);
    procedure InitializeParameters(Sender: TObject;  var aCancel: Boolean);
    function GetMyQuery(const Index: Integer): TERPQuery;
    function GetDataSource(const Index: Integer): TDataSource;
    function GetPipeline(const Index: Integer): TppDBPipeline;
    function GetSQLCount(const ReportName: string): Integer;
    function GetSQLForReport(const ReportName: string; const SQLNumber: Integer = 1): string;
    function CheckTemplateExists(const ReportName: string): Boolean;
    function GetUserMessage : string;
    property MyConnection: TCustomMyConnection read FMyConnection write SetMyConnection;
    property ReportStream: TStream read FReportStream;
    property Report: TppReport read FReport;
    property Designer: TppDesigner read FDesigner;
    property PipelineUserName[const Index: Integer]: string read GetPipelineUserName write SetPipelineUserName;
    property MaxPreview: Boolean read FMaxPreview write SetMaxPreview;
    Property HelpEvent:TPPHelpEvent read fHelpEvent write fHelpEvent;
    property CreatedOk: boolean read fCreatedOk;
    Property Printername :String read getPrintername write setPrintername;
    procedure ApplyMasterDetailLink(Json: TJsonObject);
    Property BeforePrint        :TNotifyEvent read fBeforePrint         write fBeforePrint;
    Property OnLoadTemplate     :TNotifyEvent read fOnLoadTemplate      write fOnLoadTemplate;
    //Property OnPreviewFormCreate:TNotifyEvent read fOnPreviewFormCreate write fOnPreviewFormCreate;
    class function GetReportSQL(const ReportName: string): string;
    class function GetDefaultReportSQL(const ReportType: string; var ReportName, ReportSQL: string): boolean;
  end;

implementation

uses
   Menus, ShellAPI  , AppEnvironmentVirtual, SystemLib, tcConst;

{ TReportGroup }

constructor TReportGroup.Create(const Form: TForm);
begin
  inherited Create;
  FDataSource := TDataSource.Create(Form);
  FPipeline := TppDBPipeline.Create(Form);
  FMyQuery := TERPQuery.Create(Form);
  FMyQuery.Options.FlatBuffers := True;
  FPipelineUserName := '';
end;

destructor TReportGroup.Destroy;
begin
  FreeandNil(FDataSource);
  FreeandNil(FPipeline);
  FreeandNil(FMyQuery);
  inherited;
end;

{ TReportTemplateBase }

procedure TReportTemplateBase.AddReportGroup;
var
  TmpReportGroup: TReportGroup;
begin
  TmpReportGroup := TReportGroup.Create(FForm);

  with TmpReportGroup do
  begin
    Pipeline.DataSource := DataSource;
    MyQuery.AfterOpen := QueryAfterOpen;
    MyQuery.Tag := FGroupList.Count;
    MyQuery.Name := 'MyQuery' + IntToStr(MyQuery.Tag);
  end;

  FGroupList.Add(TmpReportGroup);
  SetConnections;
end;

constructor TReportTemplateBase.Create;
begin
  inherited;
  fCreatedOk:= true;
  try
    FForm := TfmDesigner.Create(Application);  (*TForm.Create(Application);*)
    FReport := TppReport.Create(FForm);
    FDesigner := TppDesigner.Create(FForm);
    FGroupList := TObjectList.Create;
    FReport.OnInitializeParameters := InitializeParameters;

    FDesigner.Report := FReport;
    FDesigner.OnActivate := DesignerActivate;
    FDesigner.OnShow := DesignerShow;
    FMyConnection := nil;
    FReportStream := TMemoryStream.Create;
    FMaxPreview := False;
    SetReportProperties;
    FReport.BeforePrint         := DoBeforePrint;
    FReport.OnLoadTemplate      := DoOnLoadTemplate;
    //FReport.OnPreviewFormCreate := DoOnPreviewFormCreate;

  except
    fCreatedOk:= false;
    UserMsgInfo('ERP has not been installed with full Windows Administration ' +
     'rights so can not print/ preview reports.' + #13#10 + #13#10 +
     'Please reinstall ERP with full Windows Administration rights.');//, mtInformation, [mbOk],0);
  end;
end;

destructor TReportTemplateBase.Destroy;
begin
  //FreeandNil(FReport);  // Freed by FForm
  //FreeandNil(FDesigner);// Freed by FForm
  FreeandNil(FGroupList);
  FreeandNil(FReportStream);
  try
    //FForm.Release;
    FreeandNil(FForm);
  except
    on E:Exception do begin

    end;
    // release create access violation some times, kill it
  end;

  inherited;
end;

function TReportTemplateBase.GetPipelineUserName(const Index: Integer): string;
begin
  if (Index - 1) < FGroupList.Count then
    Result := TReportGroup(FGroupList[Index - 1]).PipelineUserName
  else
    Result := '';
end;

function TReportTemplateBase.getPrintername: String;
begin
  result:= '';
  if assigned(FReport ) then
    result := FReport.PrinterSetup.PrinterName;
end;

procedure TReportTemplateBase.SetPipelineUserName(const Index: Integer; const Value: string);
begin
  while FGroupList.Count < Index do
    AddReportGroup;

  TReportGroup(FGroupList[Index-1]).PipelineUserName := Value;
end;

procedure TReportTemplateBase.setPrintername(const Value: String);
begin
  if assigned(FReport ) then
    FReport.PrinterSetup.PrinterName := Value;

end;

function TReportTemplateBase.GetSQLCount(const ReportName: string): Integer;
var
  qryTmp: TERPQuery;
begin
  Result := 1;
  qryTmp := TERPQuery.Create(nil);
  qryTmp.Options.FlatBuffers := True;

  with qryTmp do
  begin
    try
      Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
      Sql.Add(Format('SELECT TemplID, SqlString, Report FROM tblTemplates WHERE TemplateClass = %s;',
                     [QuotedStr(Trim(ReportName))]));
      Open;

      if not IsEmpty then
        Result := CharCounter('~|||~', FieldByName('SqlString').AsVariant)
      else
      begin
        Close;
        Sql.Clear;
        Sql.Add(Format('SELECT TemplID, SqlString, Report FROM tblTemplates WHERE TemplName = %s;',
                       [QuotedStr(Trim(ReportName))]));
        Open;

        if not IsEmpty then
          Result := CharCounter('~|||~', FieldByName('SqlString').AsString);
      end;
    finally
      FreeandNil(qryTmp);
    end;
  end;
end;

function TReportTemplateBase.GetSQLForReport(const ReportName: string; const SQLNumber: Integer): string;
var
  qryTmp: TERPQuery;
begin
  Result := '';
  qryTmp := TERPQuery.Create(nil);
  qryTmp.Options.FlatBuffers := True;

  while FGroupList.Count < SQLNumber do
    AddReportGroup;

  with qryTmp do
  begin
    try
      Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
      Sql.Add(Format('SELECT TemplID, SqlString, DefaultTemplate, Report FROM tblTemplates WHERE TemplName = %s;',
                     [QuotedStr(Trim(ReportName))]));
      Open;

      if not IsEmpty then
      begin
        Result := ExtractStrPortion(FieldByName('SqlString').AsString, '~|||~', SQLNumber);

        if (Pos('{', Result) > 0) and (Pos('}', Result) > 0) then
          PipelineUserName[SQLNumber] := Trim(ExtractStrPortion(StringReplace(Result, '{', '',[rfReplaceAll,rfIgnoreCase]), '}', 0))
        else
          PipelineUserName[SQLNumber] := '';

        Result := StringReplace(Result, '{' + PipelineUserName[SQLNumber] + '}', '',[rfReplaceAll,rfIgnoreCase]);
        TBlobField(FieldByName('Report')).SaveToStream(FReportStream);
        FReportStream.Position := 0;
      end
      else
      begin
        Close;
        Sql.Clear;
        Sql.Add(Format('SELECT TemplID, SqlString, DefaultTemplate, Report FROM tblTemplates WHERE TemplateClass = %s;',
                       [QuotedStr(Trim(ReportName))]));
        Open;

        if not IsEmpty then
        begin
          if RecordCount > 1 then begin
            if not Locate('DefaultTemplate','T',[]) then
              First;
          end;

          Result := ExtractStrPortion(FieldByName('SqlString').AsString, '~|||~', SQLNumber);

          if (Pos('{', Result) > 0) and (Pos('}', Result) > 0) then
            PipelineUserName[SQLNumber] := Trim(ExtractStrPortion(StringReplace(Result, '{', '',[rfReplaceAll,rfIgnoreCase]), '}', 0))
          else
            PipelineUserName[SQLNumber] := '';

          Result := StringReplace(Result, '{' + PipelineUserName[SQLNumber] + '}', '',[rfReplaceAll,rfIgnoreCase]);
          TBlobField(FieldByName('Report')).SaveToStream(FReportStream);
          FReportStream.Position := 0;
        end;
      end;
    finally
      FreeandNil(qryTmp);
    end;
  end;
//  FReport.BeforePrint := ReportBeforePrint;
//  FReport.OnLoadTemplate := ReportOnLoadTemplate;
//  FReport.OnPreviewFormCreate := ReportPreviewCreate;
 FReport.OnInitializeParameters := InitializeParameters;
end;


function TReportTemplateBase.GetUserMessage: string;
begin
  Result := fUserMsgInfo;
end;

procedure TReportTemplateBase.SetConnections;
var
  Index: Integer;
  TmpMyConnection: TCustomMyConnection;
begin
  if Assigned(MyConnection) then
    TmpMyConnection := MyConnection
  else
    TmpMyConnection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

  for Index := 0 to FGroupList.Count - 1 do
  begin
    if TmpMyConnection <> TReportGroup(FGroupList[Index]).MyQuery.Connection then
      TReportGroup(FGroupList[Index]).MyQuery.Connection := TmpMyConnection;
  end;
end;

procedure TReportTemplateBase.SetMyConnection(const Connection: TCustomMyConnection);
begin
  if Connection <> FMyConnection then
  begin
    FMyConnection := Connection;
    SetConnections;
  end;
end;

function TReportTemplateBase.CheckTemplateExists(const ReportName: string): Boolean;
var
  qryTmp :TERPQuery;
begin
  qryTmp := TERPQuery.Create(nil);
  qryTmp.Options.FlatBuffers := True;
  try
    qryTmp.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qryTmp.SQL.Text := 'SELECT TemplID FROM tblTemplates WHERE TemplName = ' + QuotedStr(Trim(ReportName))+
                       ' OR TemplateClass = ' + QuotedStr(Trim(ReportName));
    qryTmp.Open;
    Result := not qryTmp.IsEmpty;
    qryTmp.Close;
  finally
    FreeandNil(qryTmp);
  end;
end;

procedure TReportTemplateBase.SetMaxPreview(const Value: Boolean);
begin
  if Value <> FMaxPreview then
  begin
    FMaxPreview := Value;

    if FMaxPreview then
      FReport.OnPageRequest := ReportPageRequest
    else
      FReport.OnPageRequest := nil;
  end;
end;

procedure TReportTemplateBase.ReportPageRequest(Sender, APageRequest: TObject);
begin
   if (FReport.DeviceType = dtScreen) and Assigned(FReport.PreviewForm) then
     FReport.PreviewForm.WindowState := wsMaximized;
end;

procedure TReportTemplateBase.QueryAfterOpen(DataSet: TDataSet);
var
  GroupIndex: Integer;
begin
  GroupIndex := DataSet.Tag;
  TReportGroup(FGroupList[GroupIndex]).DataSource.DataSet := DataSet;
  TReportGroup(FGroupList[GroupIndex]).Pipeline.DataSource := TReportGroup(FGroupList[GroupIndex]).DataSource;

  if GroupIndex = 0 then
    TReportGroup(FGroupList[GroupIndex]).Pipeline.Name := 'ppDBPipeline'
  else
    TReportGroup(FGroupList[GroupIndex]).Pipeline.Name := 'ppDBPipeline_' + IntToStr(GroupIndex);

  if Trim(PipelineUserName[GroupIndex + 1])<>'' then
    TReportGroup(FGroupList[GroupIndex]).Pipeline.UserName := StringReplace(PipelineUserName[GroupIndex + 1], ' ', '_',[rfReplaceAll,rfIgnoreCase])
  else if GroupIndex = 0 then
    TReportGroup(FGroupList[GroupIndex]).Pipeline.UserName := 'SQL'
  else
    TReportGroup(FGroupList[GroupIndex]).Pipeline.UserName := 'SQL_' + IntToStr(GroupIndex);

//  FReport.BeforePrint := ReportBeforePrint;
//  FReport.OnLoadTemplate := ReportOnLoadTemplate;
//  FReport.OnPreviewFormCreate := ReportPreviewCreate;
 FReport.OnInitializeParameters := InitializeParameters;
end;

function TReportTemplateBase.GetReportGroup(const Index: Integer): TReportGroup;
begin
  if Index >= 0 then
  begin
    if Index < FGroupList.Count then
      Result := TReportGroup(FGroupList[Index])
    else
    begin
      while FGroupList.Count <= Index do
        AddReportGroup;

      Result := TReportGroup(FGroupList[Index]);
    end;
  end
  else
    Result := nil;
end;

function TReportTemplateBase.GetMyQuery(const Index: Integer): TERPQuery;
var
  ReportGroup: TReportGroup;
begin
  ReportGroup := GetReportGroup(Index - 1);

  if Assigned(ReportGroup) then
    Result := ReportGroup.MyQuery
  else
    Result := nil;
end;

function TReportTemplateBase.GetPipeline(const Index: Integer): TppDBPipeline;
var
  ReportGroup: TReportGroup;
begin
  ReportGroup := GetReportGroup(Index - 1);

  if Assigned(ReportGroup) then
    Result := ReportGroup.Pipeline
  else
    Result := nil;
end;

procedure TReportTemplateBase.SetReportProperties;
begin

  with FReport do
  begin
    Name := 'Report';
    Icon.Assign(Application.Icon);
    PassSetting := psTwoPass;
    PrinterSetup.BinName := 'Default';
    PrinterSetup.DocumentName := 'Report';
    PrinterSetup.PaperName := 'A4';
    PrinterSetup.PrinterName := 'Default';
    Template.SaveTo := stDatabase;
    Units := utMillimeters;
    DeviceType := 'Screen';
    AllowPrintToFile := True;
    AllowPrintToArchive := False;
    FReport.NoDataBehaviors := [ndMessageDialog];
  end;


  with FDesigner do
  begin
    Name := 'ppDesigner';
    Icon.Assign(Application.Icon);
    AllowSaveToFile := True;
    Caption := 'Report Designer';
    EnableHelp := True;
    FDesigner.HelpFile := ExeDir + 'LearnReportBuilder.pdf';
    FDesigner.OnHelp := HandleHelp;

    Position := poScreenCenter;
    ShowComponents := cAllShowComponents;
    WindowState := wsMaximized;
    AllowDataSettingsChange := False;
  end;
end;

procedure TReportTemplateBase.UserMsgInfo(const value: String);
begin
  fUserMsgInfo := Value;
end;

procedure TReportTemplateBase.UserMsgWarn(const value: String);
begin
  fUserMsgWarn := Value;
end;

procedure TReportTemplateBase.HandleHelp(Sender: TObject; var aHelpFile,
        aKeyphrase: String; var aCallHelp: Boolean);
var
  hExec : HINST;
begin
  hExec := ShellExecute(Self.FForm.Handle, PChar('Open'), PChar(ExeDir + 'LearnReportBuilder.pdf'),nil , PChar(ExeDir), SW_SHOWNORMAL);
  if hExec <= 32 Then UserMsgWarn('LearnReportBuilder.pdf file not found !');//, mtWarning, [mbOK], 0);
end;

procedure TReportTemplateBase.DesignerActivate(Sender: TObject);
begin
  Designer.WindowState := wsMaximized;
end;

procedure TReportTemplateBase.DesignerShow(Sender: TObject);
begin
  ChangeRegionSettings;
  If not ReportHasDatapipes then
    FReport.AutoStop := True
  else
    FReport.AutoStop := False;
end;

function TReportTemplateBase.GetDataSource(const Index: Integer): TDataSource;
var
  ReportGroup: TReportGroup;
begin
  ReportGroup := GetReportGroup(Index - 1);

  if Assigned(ReportGroup) then
    Result := ReportGroup.DataSource
  else
    Result := nil;
end;

procedure TReportTemplateBase.ChangeRegionSettings;
var
  iIndex, iIndexBand: integer;
  tmpBand: TppBand;
  Component: TComponent;
begin
  fReport.BeginUpdate;
  for iIndex := 0 to fReport.BandCount - 1 do begin
    tmpBand := fReport.Bands[iIndex];
    for iIndexBand := 0 to tmpBand.ObjectCount - 1 do begin
      Component := tmpBand.Objects[iIndexBand];
      if (Component is TppLabel) then begin
        TppLabel(Component).Caption := StringReplace(TppLabel(Component).Caption, '$', AppEnvVirt.Str['RegionalOptions.CurrencySymbol'], [rfReplaceAll,rfIgnoreCase]);
      end;
    end;
  end;
  fReport.EndUpdate;
end;

function TReportTemplateBase.ReportHasDatapipes:Boolean;
var
  iIndex, iIndexBand: integer;
  tmpBand: TppBand;
  Component: TComponent;
begin
  Result := false;
  If not Assigned(fReport.DataPipeline) then begin
    UserMsgWarn('This Causes Infinite Pages to Print.' + NL + 'Report Has No Data PipeLine Attached !');//,mtWarning,[mbOK],0,nil,'Report Has No Data PipeLine Attached !');
    exit;
  end;

  for iIndex := 0 to fReport.BandCount - 1 do begin
    tmpBand := fReport.Bands[iIndex];
    for iIndexBand := 0 to tmpBand.ObjectCount - 1 do begin
      Component := tmpBand.Objects[iIndexBand];
      if (Component is TppSubReport) then
      If not Assigned(TppSubReport(Component).DataPipeline) then begin
        UserMsgWarn('This Causes Infinite Pages to Print.' +NL+ 'Report Has a SubReport with No Data PipeLine Attached !');//,mtWarning,[mbOK],0,nil,);
        exit;
      end;
    end;
  end;
  Result := True;
end;

procedure TReportTemplateBase.InitializeParameters(Sender: TObject;  var aCancel: Boolean);
begin
  ChangeRegionSettings;
  If not ReportHasDatapipes then
    FReport.AutoStop := True
  else
    FReport.AutoStop := False;
end;

procedure TReportTemplateBase.DoOnLoadTemplate(Sender: TObject);
begin
  if assigned(fOnLoadTemplate) then
    fOnLoadTemplate(Sender);
end;
procedure TReportTemplateBase.DoBeforePrint(Sender: TObject);
begin
  if assigned(fBeforePrint) then
    fBeforePrint(Sender);
end;

(*procedure TReportTemplateBase.DoOnPreviewFormCreate(Sender: TObject);
begin
  if assigned(fOnPreviewFormCreate) then
    fOnPreviewFormCreate(Sender);
end;*)
class function TReportTemplateBase.GetReportSQL(const ReportName: string): string;
var
  qry: TERPQuery;
begin
  Result:= '';
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qry.Sql.Add('SELECT TemplID, SqlString, Report FROM tblTemplates');
    qry.Sql.Add('WHERE TemplName = ' + QuotedStr(Trim(ReportName)));
    qry.Open;
    if qry.recordcount=0 then begin
        qry.close;
        qry.Sql.text := 'SELECT TemplID, SqlString, Report FROM   tblTemplates where TypeID in (Select TypeID from tbltemplatetype where TypeName = ' + quotedstr(ReportName) +')';
        qry.Open;
    end;
    result:= qry.FieldByName('SqlString').AsString;
  finally
    qry.Free;
  end;

end;

class function TReportTemplateBase.GetDefaultReportSQL(
  const ReportType: string; var ReportName, ReportSQL: string): boolean;
var
  qry: TERPQuery;
begin
  Result:= false;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qry.Sql.Add('SELECT TemplName, SqlString FROM tblTemplates');
    qry.Sql.Add('WHERE DefaultTemplate = "T"');
    qry.Sql.Add('AND TypeID = (SELECT TypeID FROM tblTemplateType WHERE TypeName = ' + QuotedStr(ReportType) + ')');
    qry.Open;
    if not qry.IsEmpty then begin
      result:= true;
      ReportName:= qry.FieldByName('TemplName').AsString;
      ReportSQL:= qry.FieldByName('SQLString').AsString;
    end;
  finally
    qry.Free;
  end;

end;

procedure TReportTemplateBase.ApplyMasterDetailLink(Json: TJsonObject);
var
  x: integer;
  link: TJsonObject;
  rgDetail, rgMaster: TReportGroup;
begin
  for x:= 0 to Json.Count -1 do begin
    link:= Json.Items[x].Value.AsObject;
    rgDetail:= GetReportGroupByName(link.S['detail']);
    if not Assigned(rgDetail) then
      raise exception.Create('Report Template - Could not find Detail table record: "' + link.S['detail'] + '"');
    rgMaster:= GetReportGroupByName(link.S['master']);
    if not Assigned(rgMaster) then
      raise exception.Create('Report Template - Could not find Master table record: "' + link.S['master'] + '"');
    if link.S['detailfields'] = '' then
      raise exception.Create('Report Template - Detail Fields missing for master / detail link: "' +
        link.S['master'] + '/' + link.S['detail'] + '"');
    if link.S['masterfields'] = '' then
      raise exception.Create('Report Template - Master Fields missing for master / detail link: "' +
        link.S['master'] + '/' + link.S['detail'] + '"');

    rgDetail.MyQuery.MasterFields:= link.S['masterfields'];
    rgDetail.MyQuery.DetailFields:= link.S['detailfields'];
    rgDetail.MyQuery.MasterSource:= rgMaster.DataSource;
  end;
end;


function TReportTemplateBase.GetReportGroupByName(
  const aName: string): TReportGroup;
var
  x: integer;
  item: TReportGroup;
begin
  result:= nil;
  for x:= 0 to self.FGroupList.Count -1 do begin
    item:= TReportGroup(FGroupList[x]);
    if SameText(item.PipelineUserName , aName) then begin
      result:= item;
      break;
    end;
  end;
end;

end.


