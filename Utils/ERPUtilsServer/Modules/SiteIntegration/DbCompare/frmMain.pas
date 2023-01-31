unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, MemDS, DBAccess, MyAccess, Grids, Wwdbigrd, Wwdbgrid,
  ExtCtrls, ComCtrls, JsonObject;

type
  TfmMain = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edtSourceServer: TEdit;
    Label3: TLabel;
    edtDestServer: TEdit;
    Label2: TLabel;
    edtSourceDatabase: TEdit;
    Label4: TLabel;
    edtDestDatabase: TEdit;
    grdMain: TwwDBGrid;
    btnCompare: TButton;
    SourceConn: TMyConnection;
    DestConn: TMyConnection;
    serviceConn: TMyConnection;
    qryMain: TMyQuery;
    qryMainid: TIntegerField;
    qryMainTableName: TStringField;
    qryMainFieldName: TStringField;
    qryMainGlobalRef: TStringField;
    qryMainSourceMsTimeStamp: TDateTimeField;
    qryMainDestMsTimeStamp: TDateTimeField;
    qryMainSourceValue: TStringField;
    qryMainDestValue: TStringField;
    dsMain: TDataSource;
    StatusBar1: TStatusBar;
    procedure btnCompareClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtSourceServerChange(Sender: TObject);
    procedure edtDestServerChange(Sender: TObject);
    procedure edtSourceDatabaseChange(Sender: TObject);
    procedure edtDestDatabaseChange(Sender: TObject);
  private
    ExcludeList: TStringList;
    TimeDiff: double;
    Config: TJsonObject;
    ConfigFile: string;
    procedure Compare(tblName: string; q1, q2: TMyQuery);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses
  StrUtils;

{$R *.dfm}

procedure TfmMain.btnCompareClick(Sender: TObject);
var
  cmd: TMyCommand;
  sl: TStringList;
  x: integer;
  tbl: string;
  src, dst: TMyQuery;
begin
  qryMain.Close;
  serviceConn.Disconnect;
  SourceConn.Disconnect;
  DestConn.Disconnect;
  serviceConn.Server:= edtSourceServer.Text;
  SourceConn.Server:= edtSourceServer.Text;
  SourceConn.Database:= edtSourceDatabase.Text;
  DestConn.Server:= edtDestServer.Text;
  DestConn.Database:= edtDestDatabase.Text;
  serviceConn.Connect;
  SourceConn.Connect;
  DestConn.Connect;

  cmd:= TMyCommand.Create(nil);
  try
    cmd.Connection:= serviceConn;
    cmd.SQL.Add('drop table if exists tblDatabaseCompare;');
    cmd.SQL.Add('CREATE TABLE tblDatabaseCompare (');
    cmd.SQL.Add('Id INT(11) NOT NULL AUTO_INCREMENT,');
    cmd.SQL.Add('TableName varchar(255) null default null,');
    cmd.SQL.Add('FieldName varchar(255) null default null,');
    cmd.SQL.Add('GlobalRef varchar(255) null default null,');
    cmd.SQL.Add('SourceMsTimeStamp TimeStamp null default null,');
    cmd.SQL.Add('DestMsTimeStamp TimeStamp null default null,');
    cmd.SQL.Add('SourceValue varchar(255) null default null,');
    cmd.SQL.Add('DestValue varchar(255) null default null,');
    cmd.SQL.Add('PRIMARY KEY (Id),');
    cmd.SQL.Add('INDEX `TableName_idx` (`TableName`),');
    cmd.SQL.Add('INDEX `SrcTime_idx` (`SourceMsTimeStamp`),');
    cmd.SQL.Add('INDEX `DstTime_idx` (`DestMsTimeStamp`),');
    cmd.SQL.Add('INDEX `GlobalRef_idx` (`GlobalRef`)');
    cmd.SQL.Add(')');
    cmd.SQL.Add('ENGINE=INODB;');

    cmd.Execute;
  finally
    cmd.Free;
  end;
  sl:= TStringList.Create;
  src:= TMyQuery.Create(nil);
  dst:= TMyQuery.Create(nil);
  try
    src.Connection:= SourceConn;
    dst.Connection:= DestConn;

    src.SQL.Text:= 'select TimeZone from tblUpdateDetails';
    src.Open;
    dst.SQL.Text:= 'select TimeZone from tblUpdateDetails';
    dst.Open;
    TimeDiff:= src.FieldByName('TimeZone').AsFloat - dst.FieldByName('TimeZone').AsFloat;
    src.Close;
    dst.Close;

    SourceConn.GetTableNames(sl);
    for x := 0 to sl.Count -1 do begin
      tbl:= Lowercase(sl[x]);
      if ExcludeList.IndexOf(tbl) >= 0 then
        continue;
      if Pos('tbl',tbl) = 1 then begin
        StatusBar1.Panels[0].Text:= 'Checking table ' + IntToStr(x+1) + ' of ' + IntToStr(sl.Count) + ' (' + tbl + ')';
        Application.ProcessMessages;
        try
          src.SQL.Text:= 'select * from ' + tbl;
          src.Open;
          if Assigned(src.FindField('GlobalRef')) and Assigned(src.FindField('msTimeStamp')) then begin
            while not src.Eof do begin
              if src.FieldByName('GlobalRef').AsString <> '' then begin
                dst.SQL.Text:= 'select * from ' + tbl + ' where globalref = ' + QuotedStr(src.FieldByName('GlobalRef').AsString);
                dst.Open;
                Compare(tbl,src,dst);
              end
              else begin
                Compare(tbl,src,nil);
              end;

              src.Next;
            end;
          end;
          src.Close;
        except
          on e: exception do begin
            StatusBar1.Panels[0].Text:= 'Error: ' + e.Message;
          end;

        end;
      end;
    end;
    StatusBar1.Panels[0].Text:= 'Done';
  finally
    sl.Free;
    src.Free;
    dst.Free;
  end;

  qryMain.Open;
end;

procedure TfmMain.Compare(tblName: string; q1, q2: TMyQuery);

  procedure AddDiff(tblName, fldName, aGlobalRef: string; SrcTime, DstTime: TDateTime; SrcVal, DstVal: string);
  var
    cmd: TMyCommand;
  begin
    cmd:= TMyCommand.Create(nil);
    try
      cmd.Connection:= serviceConn;
      cmd.SQL.Add('insert into tblDatabaseCompare');
      cmd.SQL.Add('set TableName = ' + QuotedStr(tblName));
      cmd.SQL.Add(', FieldName = ' + QuotedStr(fldName));
      cmd.SQL.Add(', GlobalRef = ' + QuotedStr(aGlobalRef));
      cmd.SQL.Add(', SourceMsTimeStamp = ' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',SrcTime)));
      cmd.SQL.Add(', DestMsTimeStamp = ' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',DstTime)));
      cmd.SQL.Add(', SourceValue = ' + QuotedStr(SrcVal));
      cmd.SQL.Add(', DestValue = ' + QuotedStr(DstVal));
      cmd.Execute;
    finally
      cmd.Free;
    end;
  end;

  function FieldBlank(fld: TField): boolean;
  begin
    result:= fld.IsNull or
            (fld.AsString = '') or
            ((fld.DataType in [ftSmallint,ftInteger,ftLargeint,ftWord,ftFloat,ftCurrency,ftSingle]) and (fld.AsString = '0'));
  end;

var
  x: integer;
  srcFld, dstFld: TField;
begin
  if not Assigned(q2) then begin
    AddDiff(tblName,'',q1.FieldByName('GlobalRef').AsString,q1.FieldByName('msTimeStamp').AsDateTime,0,'BLANK GLOBALREF','');
    exit;
  end;
  if q2.IsEmpty then begin
    AddDiff(tblName,'',q1.FieldByName('GlobalRef').AsString,q1.FieldByName('msTimeStamp').AsDateTime,0,'','RECORD NOT FOUND FOR GLOBALREF');
    exit;
  end;
  for x := 0 to q1.FieldCount-1 do begin
    srcFld:= q1.Fields[x];
    if not (srcFld.DataType in [ftBlob,ftGraphic,ftParadoxOle, ftDBaseOle, ftTypedBinary,ftCursor,ftADT, ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob,ftInterface, ftIDispatch,ftConnection, ftParams, ftStream, ftTimeStampOffset, ftObject]) then begin
      dstFld:= q2.FindField(srcFld.FieldName);
      if Assigned(dstFld) then begin
        if not (FieldBlank(srcFld) and FieldBlank(dstFld)) then begin
          if FieldBlank(srcFld) and (not FieldBlank(dstFld)) then
            AddDiff(tblName,srcFld.FieldName,q1.FieldByName('GlobalRef').AsString,q1.FieldByName('msTimeStamp').AsDateTime,q2.FieldByName('msTimeStamp').AsDateTime,'',LeftStr(DstFld.AsString,255))
          else if (not FieldBlank(srcFld)) and FieldBlank(dstFld) then
            AddDiff(tblName,srcFld.FieldName,q1.FieldByName('GlobalRef').AsString,q1.FieldByName('msTimeStamp').AsDateTime,q2.FieldByName('msTimeStamp').AsDateTime,LeftStr(SrcFld.AsString,255),'')
          else if srcFld.AsString <> dstFld.AsString then begin
            if SameText(srcFld.FieldName,'msTimeStamp') then begin
              if (srcFld.AsFloat - TimeDiff) <> dstFld.AsFloat then
                AddDiff(tblName,srcFld.FieldName,q1.FieldByName('GlobalRef').AsString,q1.FieldByName('msTimeStamp').AsDateTime,q2.FieldByName('msTimeStamp').AsDateTime,LeftStr(SrcFld.AsString,255),LeftStr(dstFld.AsString,255));
            end
            else
              AddDiff(tblName,srcFld.FieldName,q1.FieldByName('GlobalRef').AsString,q1.FieldByName('msTimeStamp').AsDateTime,q2.FieldByName('msTimeStamp').AsDateTime,LeftStr(SrcFld.AsString,255),LeftStr(dstFld.AsString,255));
          end;
        end;
      end
      else begin
        AddDiff(tblName,srcFld.FieldName,q1.FieldByName('GlobalRef').AsString,q1.FieldByName('msTimeStamp').AsDateTime,q2.FieldByName('msTimeStamp').AsDateTime,LeftStr(SrcFld.AsString,255),'FIELD NOT FOUND')
      end;
    end;
  end;
end;

procedure TfmMain.edtDestDatabaseChange(Sender: TObject);
begin
  if edtDestDatabase.Focused then begin
    Config.S['DestDatabase'] := edtDestDatabase.Text;
    Config.SaveToFile(ConfigFile);
  end;
end;

procedure TfmMain.edtDestServerChange(Sender: TObject);
begin
  if edtDestServer.Focused then begin
    Config.S['DestServer'] := edtDestServer.Text;
    Config.SaveToFile(ConfigFile);
  end;
end;

procedure TfmMain.edtSourceDatabaseChange(Sender: TObject);
begin
  if edtSourceDatabase.Focused then begin
    Config.S['SourceDatabase'] := edtSourceDatabase.Text;
    Config.SaveToFile(ConfigFile);
  end;
end;

procedure TfmMain.edtSourceServerChange(Sender: TObject);
begin
  if edtSourceServer.Focused then begin
    Config.S['SourceServer'] := edtSourceServer.Text;
    Config.SaveToFile(ConfigFile);
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  ConfigFile := ChangeFileExt(Application.ExeName,'_config.cfg');
  Config:= TJsonObject.Create;
  if FileExists(ConfigFile) then Config.LoadFromFile(ConfigFile);
  edtSourceServer.Text:= Config.S['SourceServer'];
  edtDestServer.Text:= Config.S['DestServer'];
  edtSourceDatabase.Text:= Config.S['SourceDatabase'];
  edtDestDatabase.Text:= Config.S['DestDatabase'];

  ExcludeList:= TStringList.Create;
  ExcludeList.Add('tblcompanyinformation');
  ExcludeList.Add('tblmsbackendid');
  ExcludeList.Add('tblbusobjfilter');
  ExcludeList.Add('tblbusobjfilterparam');
  ExcludeList.Add('tblaudittrail');
  ExcludeList.Add('tblcontrols');
  ExcludeList.Add('tblemployeeformsaccess');
  ExcludeList.Add('tblforms');
  ExcludeList.Add('tbltransactions');
  ExcludeList.Add('tbltransactionsummary');
  ExcludeList.Add('tbllocations');
  ExcludeList.Add('tbllocations');
  ExcludeList.Add('tblinuseforms');
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  ExcludeList.Free;
end;

end.
