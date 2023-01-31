unit ReportTemplates;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 16/12/05  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db,  StdCtrls, Buttons, DNMSpeedButton, MemDS, DBAccess, Contnrs,
  {^Need These Use To Keep OPtion in Report Builder}
  ppDB, ppDBPipe,
  ppTypes, ppMemo, ppRichTx, ppCtrls, ppBarCod, ppBarCode2D,
  myChkBox,myChkBoxDesign, ppRegion, ppReport, ppSubRpt, ppPageBreak, ppCTMain,
  ppVar, ppStrtch, ppPrnabl, ppClass, ppBands, ppCache, ppComm, ppRelatv,
  ppProd, ppEndUsr, ExtCtrls,
  ppWWRichEd,wwriched,
  TeeProcs, TeEngine,
  ppChrt, Chart,
  ppChrtDP , DbChart,
  ppChrtUI, ppPDFDevice, ppZLib,TXtraDev,
  {^}
  MyAccess;

type
  TReportGroup = class(TObject)
  private
    FDataSource: TDataSource;
    FPipeline: TppDBPipeline;
    FMyQuery: TMyQuery;
    FPipelineUserName: string;
  public
    constructor Create(const Form: TForm); reintroduce;
    destructor Destroy; override;
    property DataSource: TDataSource read FDataSource;
    property Pipeline: TppDBPipeline read FPipeline;
    property MyQuery: TMyQuery read FMyQuery;
    property PipelineUserName: string read FPipelineUserName write FPipelineUserName;
  end;

  TReportTemplates = class(TObject)
  private
    FForm: TForm;
    FReport: TppReport;
    FDesigner: TppDesigner;
    FMyConnection: TCustomMyConnection;
    FGroupList: TObjectList;
    FReportStream: TStream;
    FMaxPreview: Boolean;
    procedure QueryAfterOpen(DataSet: TDataSet);
  protected
    procedure AddReportGroup;
    procedure SetConnections;
    procedure SetReportProperties;
    function GetReportGroup(const Index: Integer): TReportGroup;
    procedure SetMyConnection(const Connection: TCustomMyConnection);
    function GetPipelineUserName(const Index: Integer): string;
    procedure SetPipelineUserName(const Index: Integer; const Value: string);
    procedure SetMaxPreview(const Value: Boolean);
//    procedure ChangeRegionSettings;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ReportPageRequest(Sender, APageRequest: TObject);
    procedure ReportBeforePrint(Sender: TObject);
    procedure DesignerActivate(Sender: TObject);
    procedure DesignerShow(Sender: TObject);
    function GetMyQuery(const Index: Integer): TMyQuery;
    function GetDataSource(const Index: Integer): TDataSource;
    function GetPipeline(const Index: Integer): TppDBPipeline;
    function GetSQLCount(const ReportName: string): Integer;
    function GetSQLForReport(const ReportName: string; const SQLNumber: Integer = 1): string;
    function CheckTemplateExists(const ReportName: string): Boolean;
    property MyConnection: TCustomMyConnection read FMyConnection write SetMyConnection;
    property ReportStream: TStream read FReportStream;
    property Report: TppReport read FReport;
    property Designer: TppDesigner read FDesigner;
    property PipelineUserName[const Index: Integer]: string read GetPipelineUserName write SetPipelineUserName;
    property MaxPreview: Boolean read FMaxPreview write SetMaxPreview;
  end;

implementation

uses
//  CommonLib,
//  CommonDbLib,
//   AppEnvironment,
   FastFuncs, EmailFaxServerLib;

{ TReportGroup }

constructor TReportGroup.Create(const Form: TForm);
begin
  inherited Create;
  FDataSource := TDataSource.Create(Form);
  FPipeline := TppDBPipeline.Create(Form);
  FMyQuery := TMyQuery.Create(Form);
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

{ TReportTemplates }

procedure TReportTemplates.AddReportGroup;
var
  TmpReportGroup: TReportGroup;
begin
  TmpReportGroup := TReportGroup.Create(FForm);

  with TmpReportGroup do
  begin
    Pipeline.DataSource := DataSource;
    MyQuery.AfterOpen := QueryAfterOpen;
    MyQuery.Tag := FGroupList.Count;
    MyQuery.Name := 'MyQuery' + intToStr(MyQuery.Tag);
  end;

  FGroupList.Add(TmpReportGroup);
  SetConnections;
end;

constructor TReportTemplates.Create;
begin
  inherited;
  FForm := TForm.Create(Application);
  FReport := TppReport.Create(FForm);
  FDesigner := TppDesigner.Create(FForm);
  FGroupList := TObjectList.Create;
  FReport.BeforePrint := ReportBeforePrint;
  FDesigner.Report := FReport;
  FDesigner.OnActivate := DesignerActivate;
  FDesigner.OnShow := DesignerShow;
  FMyConnection := nil;
  FReportStream := TMemoryStream.Create;
  FMaxPreview := False;
  SetReportProperties;
end;

destructor TReportTemplates.Destroy;
begin
  //FreeandNil(FReport);  // Freed by FForm
  //FreeandNil(FDesigner);// Freed by FForm
  FreeandNil(FGroupList);
  FreeandNil(FReportStream);
  FForm.Release;
  FForm := nil;
  inherited;
end;

function TReportTemplates.GetPipelineUserName(const Index: Integer): string;
begin
  if (Index - 1) < FGroupList.Count then
    Result := TReportGroup(FGroupList[Index - 1]).PipelineUserName
  else
    Result := '';
end;

procedure TReportTemplates.SetPipelineUserName(const Index: Integer; const Value: string);
begin
  while FGroupList.Count < Index do
    AddReportGroup;

  TReportGroup(FGroupList[Index-1]).PipelineUserName := Value;
end;



function TReportTemplates.GetSQLCount(const ReportName: string): Integer;
var
  qryTmp: TMyQuery;

begin
  Result := 1;
  qryTmp := TMyQuery.Create(nil);
  qryTmp.Options.FlatBuffers := True;

  with qryTmp do
  begin
    try
      Connection := FMyConnection;
      Sql.Add(Format('SELECT TemplID, SqlString, Report FROM tblTemplates WHERE TemplateClass = %s;',
                     [QuotedStr(FastFuncs.Trim(ReportName))]));
      Open;

      if not IsEmpty then
        Result := CharCounter('~|||~', FieldByName('SqlString').AsVariant)
      else
      begin
        Close;
        Sql.Clear;
        Sql.Add(Format('SELECT TemplID, SqlString, Report FROM tblTemplates WHERE TemplName = %s;',
                       [QuotedStr(FastFuncs.Trim(ReportName))]));
        Open;

        if not IsEmpty then
          Result := CharCounter('~|||~', FieldByName('SqlString').AsString);
      end;
    finally
      FreeandNil(qryTmp);
    end;
  end;
end;

function TReportTemplates.GetSQLForReport(const ReportName: string; const SQLNumber: Integer): string;
var
  qryTmp: TMyQuery;
begin
  Result := '';
  qryTmp := TMyQuery.Create(nil);
  qryTmp.Options.FlatBuffers := True;

  while FGroupList.Count < SQLNumber do
    AddReportGroup;

  with qryTmp do
  begin
    try
      Connection := FMyConnection;
      Sql.Add(Format('SELECT TemplID, SqlString, Report FROM tblTemplates WHERE TemplName = %s;',
                     [QuotedStr(FastFuncs.Trim(ReportName))]));
      Open;

      if not IsEmpty then
      begin
        Result := ExtractStrPortion(FieldByName('SqlString').AsString, '~|||~', SQLNumber);

        if (FastFuncs.PosEx('{', Result) > 0) and (FastFuncs.PosEx('}', Result) > 0) then
          PipelineUserName[SQLNumber] := FastFuncs.Trim(ExtractStrPortion(ReplaceStr(Result, '{', ''), '}', 0))
        else
          PipelineUserName[SQLNumber] := '';

        Result := ReplaceStr(Result, '{' + PipelineUserName[SQLNumber] + '}', '');
        TBlobField(FieldByName('Report')).SaveToStream(FReportStream);
        FReportStream.Position := 0;
      end
      else
      begin
        Close;
        Sql.Clear;
        Sql.Add(Format('SELECT TemplID, SqlString, Report FROM tblTemplates WHERE TemplateClass = %s;',
                       [QuotedStr(FastFuncs.Trim(ReportName))]));
        Open;

        if not IsEmpty then
        begin
          Result := ExtractStrPortion(FieldByName('SqlString').AsString, '~|||~', SQLNumber);

          if (FastFuncs.PosEx('{', Result) > 0) and (FastFuncs.PosEx('}', Result) > 0) then
            PipelineUserName[SQLNumber] := FastFuncs.Trim(ExtractStrPortion(ReplaceStr(Result, '{', ''), '}', 0))
          else
            PipelineUserName[SQLNumber] := '';

          Result := ReplaceStr(Result, '{' + PipelineUserName[SQLNumber] + '}', '');
          TBlobField(FieldByName('Report')).SaveToStream(FReportStream);
          FReportStream.Position := 0;
        end;
      end;
    finally
      FreeandNil(qryTmp);
    end;
  end;
  FReport.BeforePrint := ReportBeforePrint;
end;


procedure TReportTemplates.SetConnections;
var
  Index: Integer;
  TmpMyConnection: TCustomMyConnection;
begin
  if Assigned(MyConnection) then
    TmpMyConnection := MyConnection
  else
    TmpMyConnection := FMyConnection;

  for Index := 0 to FGroupList.Count - 1 do
  begin
    if TmpMyConnection <> TReportGroup(FGroupList[Index]).MyQuery.Connection then
      TReportGroup(FGroupList[Index]).MyQuery.Connection := TmpMyConnection;
  end;
end;

procedure TReportTemplates.SetMyConnection(const Connection: TCustomMyConnection);
begin
  if Connection <> FMyConnection then
  begin
    FMyConnection := Connection;
    SetConnections;
  end;
end;

function TReportTemplates.CheckTemplateExists(const ReportName: string): Boolean;
var
  qryTmp :TMyQuery;
begin
  qryTmp := TMyQuery.Create(nil);
  qryTmp.Options.FlatBuffers := True;
  try
    qryTmp.Connection := FMyConnection;
    qryTmp.SQL.Text := 'SELECT TemplID FROM tblTemplates WHERE TemplName = ' + QuotedStr(FastFuncs.Trim(ReportName))+
                       ' OR TemplateClass = ' + QuotedStr(FastFuncs.Trim(ReportName));
    qryTmp.Open;
    Result := not qryTmp.IsEmpty;
    qryTmp.Close;
  finally
    FreeandNil(qryTmp);
  end;
end;

procedure TReportTemplates.SetMaxPreview(const Value: Boolean);
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

procedure TReportTemplates.ReportPageRequest(Sender, APageRequest: TObject);
begin
   if FReport.DeviceType = dtScreen then
     FReport.PreviewForm.WindowState := wsMaximized;
end;

procedure TReportTemplates.QueryAfterOpen(DataSet: TDataSet);
var
  GroupIndex: Integer;
begin
  GroupIndex := DataSet.Tag;
  TReportGroup(FGroupList[GroupIndex]).DataSource.DataSet := DataSet;
  TReportGroup(FGroupList[GroupIndex]).Pipeline.DataSource := TReportGroup(FGroupList[GroupIndex]).DataSource;

  if GroupIndex = 0 then
    TReportGroup(FGroupList[GroupIndex]).Pipeline.Name := 'ppDBPipeline'
  else
    TReportGroup(FGroupList[GroupIndex]).Pipeline.Name := 'ppDBPipeline_' + FastFuncs.IntToStr(GroupIndex);

  if not Empty(PipelineUserName[GroupIndex + 1]) then
    TReportGroup(FGroupList[GroupIndex]).Pipeline.UserName := ReplaceStr(PipelineUserName[GroupIndex + 1], ' ', '_')
  else if GroupIndex = 0 then
    TReportGroup(FGroupList[GroupIndex]).Pipeline.UserName := 'SQL'
  else
    TReportGroup(FGroupList[GroupIndex]).Pipeline.UserName := 'SQL_' + FastFuncs.IntToStr(GroupIndex);

  FReport.BeforePrint := ReportBeforePrint;    
end;

function TReportTemplates.GetReportGroup(const Index: Integer): TReportGroup;
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

function TReportTemplates.GetMyQuery(const Index: Integer): TMyQuery;
var
  ReportGroup: TReportGroup;
begin
  ReportGroup := GetReportGroup(Index - 1);

  if Assigned(ReportGroup) then
    Result := ReportGroup.MyQuery
  else
    Result := nil;
end;

function TReportTemplates.GetPipeline(const Index: Integer): TppDBPipeline;
var
  ReportGroup: TReportGroup;
begin
  ReportGroup := GetReportGroup(Index - 1);

  if Assigned(ReportGroup) then
    Result := ReportGroup.Pipeline
  else
    Result := nil;
end;

procedure TReportTemplates.SetReportProperties;
begin

  with FReport do
  begin
    Name := 'Report';
    Icon.Assign(Application.Icon);
    AutoStop := True;
    PassSetting := psOnePass;
    PrinterSetup.BinName := 'Default';
    PrinterSetup.DocumentName := 'Report';
    PrinterSetup.PaperName := 'A4';
    PrinterSetup.PrinterName := 'Default';
    Template.SaveTo := stDatabase;
    Units := utMillimeters;
    DeviceType := 'Screen';
    AllowPrintToFile := True;
    AllowPrintToArchive := False;
  end;


  with FDesigner do
  begin
    Name := 'ppDesigner';
    Icon.Assign(Application.Icon);
    AllowSaveToFile := True;
    Caption := 'Report Designer';
    EnableHelp := False;
    Position := poScreenCenter;
    ShowComponents := cAllShowComponents;
    WindowState := wsMaximized;
    AllowDataSettingsChange := False;
  end;
end;

procedure TReportTemplates.ReportBeforePrint(Sender: TObject);
begin
//  ChangeRegionSettings;
end;

procedure TReportTemplates.DesignerActivate(Sender: TObject);
begin
  Designer.WindowState := wsMaximized;
end;

procedure TReportTemplates.DesignerShow(Sender: TObject);
begin
//  ChangeRegionSettings;
end;

function TReportTemplates.GetDataSource(const Index: Integer): TDataSource;
var
  ReportGroup: TReportGroup;
begin
  ReportGroup := GetReportGroup(Index - 1);

  if Assigned(ReportGroup) then
    Result := ReportGroup.DataSource
  else
    Result := nil;
end;

//procedure TReportTemplates.ChangeRegionSettings;
//var
//  iIndex, iIndexBand: integer;
//  tmpBand: TppBand;
//  Component: TComponent;
//begin
//  fReport.BeginUpdate;
//  for iIndex := 0 to fReport.BandCount - 1 do begin
//    tmpBand := fReport.Bands[iIndex];
//    for iIndexBand := 0 to tmpBand.ObjectCount - 1 do begin
//      Component := tmpBand.Objects[iIndexBand];
//      if (Component is TppLabel) then begin
//        TppLabel(Component).Caption := FastFuncs.AnsiStringReplace(TppLabel(Component).Caption, '$', AppEnv.RegionalOptions.CurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
//      end;
//    end;
//  end;
//  fReport.EndUpdate;
//end;

end.

