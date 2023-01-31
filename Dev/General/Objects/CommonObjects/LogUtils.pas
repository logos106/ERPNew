unit LogUtils;

interface

uses
  contnrs;

type

  TLogBlockType = (lbNone, lbBegin, lbEnd, lbBeginUnique);

  TLogBlockItem = class(TObject)
  public
    BlockName: string;
    TimeStart: TDateTime;
    function Duration: TDateTime;
  end;

  TLogBlockList = class(TObject)
  private
    fList: TObjectList;
    function GetItem(index: integer): TLogBlockItem;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddBlock(const BlockName: string; AllowDuplicate: boolean = true);
    procedure RemoveBlock(const BlockName: string = '');
    function Count: integer;
    function LastBlock: TLogBlockItem;
    function LastDuration: TDateTime;
    function LastDurationStr: string;
    property Item[index: integer]: TLogBlockItem read GetItem;
  end;


  { debugging/profiling log functions }
  procedure LogD(const msg: string; LogBlockType: TLogBlockType = lbNone);

implementation

uses
  LogThreadLib, sysutils, LogMessageTypes, classes;

var
  fBlockList: TLogBlockList;
  fFirstLog: boolean = true;

const
  DebugLoggingEnabled = false;
  IndentStr = #9;

function LogBlockList: TLogBlockList;
begin
  if not Assigned(fBlockList) then
    fBlockList:= TLogBlockList.Create;
  result:= fBlockList;
end;



procedure LogD(const msg: string; LogBlockType: TLogBlockType = lbNone);
var
  s: string;

  function PadStr(const Indent: integer): string;
  var i: integer;
  begin
    result:= '';
    for i:= 0 to Indent do
      result:= result + IndentStr;
  end;


begin
  s:= '';
  if DebugLoggingEnabled then begin
    case LogBlockType of
      lbNone:
        s:= PadStr(LogBlockList.Count) + msg;
      lbBegin: begin
                 s:= PadStr(LogBlockList.Count) + 'Start - ' + msg;
                 LogBlockList.AddBlock(msg);
               end;
      lbBeginUnique:
               begin
                 if (LogBlockList.Count = 0) or (LogBlockList.LastBlock.BlockName <> msg) then begin
                   s:= PadStr(LogBlockList.Count) + 'Start - ' + msg;
                   LogBlockList.AddBlock(msg);
                 end;
               end;
      lbEnd:   begin
                 if LogBlockList.Count > 0 then begin
                   s:= PadStr(LogBlockList.Count -1) + 'End - ' +LogBlockList.LastBlock.BlockName + ' ('+ LogBlockList.LastDurationStr + ')';
                   LogBlockList.RemoveBlock(msg);
                 end
                 else
                   s:= PadStr(LogBlockList.Count) + 'End - ' + msg;
               end;
    end;
    if fFirstLog then begin
      TLogger.Inst.LogMessageTypes:= TLogger.Inst.LogMessageTypes + [ltDebug];
      fFirstLog:= false;
    end;
    TLogger.Inst.Log(s, ltDebug);
  end;
end;

{ TLogBlockItem }

function TLogBlockItem.Duration: TDateTime;
begin
  result:= now - TimeStart;
end;

{ TLogBlockList }

procedure TLogBlockList.AddBlock(const BlockName: string; AllowDuplicate: boolean = true);
var
  item: TLogBlockItem;
begin
  if (not AllowDuplicate) and (fList.Count > 0) and (LastBlock.BlockName = BlockName) then
    exit;
  item:= TLogBlockItem.Create;
  item.BlockName:= BlockName;
  item.TimeStart:= now;
  fList.Add(item);
end;

function TLogBlockList.Count: integer;
begin
  result:= fList.count;
end;

constructor TLogBlockList.Create;
begin
  fLIst:= TObjectList.Create(true);
end;

destructor TLogBlockList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TLogBlockList.GetItem(index: integer): TLogBlockItem;
begin
  result:= TLogBlockItem(fList[index]);
end;

function TLogBlockList.LastBlock: TLogBlockItem;
begin
  if fList.Count > 0 then
    result:= TLogBlockItem(fList[fList.Count-1])
  else
    result:= nil;  
end;

function TLogBlockList.LastDuration: TDateTime;
begin
  result:= 0;
  if fList.Count > 0 then begin
    result:= LastBlock.Duration;
  end;
end;

function TLogBlockList.LastDurationStr: string;
begin
  result:= FormatDateTime('hh:nn:ss zzz', LastDuration);
end;

procedure TLogBlockList.RemoveBlock(const BlockName: string = '');
var
  x: integer;
begin
  if BlockName = '' then begin
    if fList.Count > 0 then
      fList.Delete(fList.Count-1);
  end
  else begin
    for x:= fList.Count -1 downto 0 do begin
      if Item[x].BlockName = BlockName then begin
        fList.Delete(x);
        Break;
      end;
    end;
  end;
end;

initialization
  fBlockList:= nil;
  LogD('Application Run -------------------------------------------------------');

finalization
  fBlockList.Free;


end.
