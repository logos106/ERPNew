unit BusObjProcessTime;

interface


uses BusObjNDSBase, DB, Classes, XMLIntf, BusObjProcessStep;


type

  TProcessTimeNDS = class(TMSBusObjNDS)
  private
    FActive: boolean;
    FProcessTimeId: integer;
    FProcessPartId: integer;
    FTimeStart: TDateTime;
    FTimeEnd: TDateTime;
    FDuration: double;
    procedure SetActive(const Value: boolean);
    procedure SetProcessPartId(const Value: integer);
    procedure SetProcessTimeId(const Value: integer);
    procedure SetTimeEnd(const Value: TDateTime);
    procedure SetTimeStart(const Value: TDateTime);
    procedure SetDuration(const Value: double);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ProcessTimeId: integer read FProcessTimeId write SetProcessTimeId;
    property ProcessPartId: integer read FProcessPartId write SetProcessPartId;
    property TimeStart: TDateTime read FTimeStart write SetTimeStart;
    property TimeEnd: TDateTime read FTimeEnd write SetTimeEnd;
    property Duration: double read FDuration write SetDuration;
    property Active: boolean read FActive write SetActive;
  end;

  TProcessTimeList = class(TBusObjNDSList)
  private
  protected
    function GetItem(index: integer): TProcessTimeNDS; reintroduce;
  public
    property Item[index: integer]: TProcessTimeNDS read GetItem; default;
//    function AddProcessPart: TProcessPartNDS;
//    function ItemById(Id: integer): TProcessPartNDS;
  published
  end;


implementation

{ TProcessTimeNDS }

constructor TProcessTimeNDS.Create(aOwner: TComponent);
begin
  inherited;
  fBusObjectTableName:= 'tblProcessTime';
  fIdFieldName:= 'ProcessTimeId';
end;

destructor TProcessTimeNDS.Destroy;
begin

  inherited;
end;

procedure TProcessTimeNDS.SetActive(const Value: boolean);
begin
  if FActive <> Value then begin
    FActive := Value;
    MakeDirty;
  end  
end;

procedure TProcessTimeNDS.SetDuration(const Value: double);
begin
  if FDuration <> Value then begin
    FDuration := Value;
    MakeDirty;
  end;
end;

procedure TProcessTimeNDS.SetProcessPartId(const Value: integer);
begin
  if FProcessPartId <> Value then begin
    FProcessPartId := Value;
    MakeDirty;
  end;
end;

procedure TProcessTimeNDS.SetProcessTimeId(const Value: integer);
begin
  if FProcessTimeId <> Value then begin
    FProcessTimeId := Value;
    MakeDirty;
  end;
end;

procedure TProcessTimeNDS.SetTimeEnd(const Value: TDateTime);
begin
  if FTimeEnd <> Value then begin
    FTimeEnd := Value;
    MakeDirty;
  end;
end;

procedure TProcessTimeNDS.SetTimeStart(const Value: TDateTime);
begin
  if FTimeStart <> Value then begin
    FTimeStart := Value;
    MakeDirty;
  end;  
end;

{ TProcessTimeList }

function TProcessTimeList.GetItem(index: integer): TProcessTimeNDS;
begin
  result:= TProcessTimeNDS(Item[index]);
end;

initialization
  RegisterClass(TProcessTimeNDS);
finalization
  UnregisterClass(TProcessTimeNDS);

end.
