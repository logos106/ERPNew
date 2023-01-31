unit BusObjProcessTimeNDS;

interface


uses Contnrs,BusObjNDSBase, DB, Classes;


type
  TProcessPartQtyNDS = class(TMSBusObjNDS)
  Private
    fiProcessPartQtyID: Integer;
    fiProcessPartID: Integer;
    fdQtyScheduled: Double;
    fiScheduledEmployeeId: Integer;
    fdQtyBuilt: Double;
    fbactive: Boolean;
    fdQtyUsed: Double;
    fdBuildDate: TDateTime;
    fiBuiltEmployeeId: Integer;
    fiProcesstimeID: Integer;
    procedure Setactive(const Value: Boolean);
    procedure SetBuildDate(const Value: TDateTime);
    procedure SetBuiltEmployeeId(const Value: Integer);
    procedure SetProcessPartQtyID(const Value: Integer);
    procedure SetProcessPartID(const Value: Integer);
    procedure SetProcesstimeID(const Value: Integer);
    procedure SetQtyBuilt(const Value: Double);
    procedure SetQtyScheduled(const Value: Double);
    procedure SetQtyUsed(const Value: Double);
    procedure SetScheduledEmployeeId(const Value: Integer);
  protected
    function GetId: integer; override;
    procedure SetId(const Value: integer); override;
  Public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure DeleteNoCheck; Override;
    function SaveNoCheck: boolean; Override;
    property ProcessPartQtyID        :Integer     read fiProcessPartQtyID      write SetProcessPartQtyID      ;
    FUNCTION LogString:sTRING;
  Published
    property ProcessPartID           :Integer     read fiProcessPartID         write SetProcessPartID      ;
    property ProcesstimeID           :Integer     read fiProcesstimeID         write SetProcesstimeID      ;
    property BuildDate               :TDateTime   read fdBuildDate             write SetBuildDate          ;
    property QtyScheduled            :Double      read fdQtyScheduled          write SetQtyScheduled       ;
    property QtyBuilt                :Double      read fdQtyBuilt              write SetQtyBuilt           ;
    property QtyUsed                 :Double      read fdQtyUsed               write SetQtyUsed            ;
    property ScheduledEmployeeId     :Integer     read fiScheduledEmployeeId   write SetScheduledEmployeeId;
    property BuiltEmployeeId         :Integer     read fiBuiltEmployeeId       write SetBuiltEmployeeId    ;
    property active                  :Boolean     read fbactive                write Setactive             ;
  end;

  TProcessTimeNDS = class(TMSBusObjNDS)
  private
    FActive: boolean;
    FProcessTimeId: integer;
    FProcessPartId: integer;
    FTimeStart: TDateTime;
    FTimeEnd: TDateTime;
    FDuration: double;
    fDeleted: boolean;
    fiResourcedetailsID:Integer;
    fiEmployeeId:Integer;
    fiSalesLineID:Integer;
    fProcessPartQtys : Array of TProcessPartQtyNDS;
    procedure SetActive(const Value: boolean);
    procedure SetProcessPartId(const Value: integer);
    procedure SetProcessTimeId(const Value: integer);
    procedure SetTimeEnd(const Value: TDateTime);
    procedure SetTimeStart(const Value: TDateTime);
    procedure SetDuration(const Value: double);
    procedure setResourcedetailsID(const Value: Integer);
    procedure setEmployeeId(const Value: Integer);
    procedure setSalesLineID(const Value: Integer);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Deleted: boolean read fDeleted write fDeleted;
    procedure DeleteNoCheck; Override;
    Property SalesLineID :Integer read fiSalesLineID write setSalesLineID;
    function SaveNoCheck: boolean; Override;
    Procedure AddNewScheduledQty(Const FdDate :TDatetime; fdQty:Double);
    Function Endtime :TDatetime;
  protected
    function GetId: integer; override;
    procedure SetId(const Value: integer); override;
  Public
    function LogString:String;
  published
    property ProcessTimeId: integer read FProcessTimeId write SetProcessTimeId;
    property ProcessPartId: integer read FProcessPartId write SetProcessPartId;
    property TimeStart: TDateTime read FTimeStart write SetTimeStart;
    property TimeEnd: TDateTime read FTimeEnd write SetTimeEnd;
    property Duration: double read FDuration write SetDuration;
    property Active: boolean read FActive write SetActive;
    Property ResourcedetailsID :Integer read fiResourcedetailsID write setResourcedetailsID;
    Property EmployeeId :Integer read fiEmployeeId write setEmployeeId;
  end;

implementation

uses
  CommonLib, BusObjProcessPart, sysutils, MySQLConst ,dateutils;

{ TProcessTimeNDS }


procedure TProcessTimeNDS.AddNewScheduledQty(const FdDate: TDatetime;fdQty: Double);
begin
  SetLength(fProcessPartQtys , length(fProcessPartQtys) +1);
  fProcessPartQtys[high(fProcessPartQtys)] := TProcessPartQtyNDS.Create(nil);
  fProcessPartQtys[high(fProcessPartQtys)].Storer:= self.Storer;
  fProcessPartQtys[high(fProcessPartQtys)].ProcessPartId:= self.ProcessPartId;
  fProcessPartQtys[high(fProcessPartQtys)].ProcesstimeID:= self.ID;
  fProcessPartQtys[high(fProcessPartQtys)].BuildDate := fdDate;
  fProcessPartQtys[high(fProcessPartQtys)].QtyScheduled := fdQty;
  fProcessPartQtys[high(fProcessPartQtys)].ScheduledEmployeeId := self.EmployeeId;
  //Logtext('Created:' +LogString);
end;

constructor TProcessTimeNDS.Create(aOwner: TComponent);
begin
  inherited;
  SetLength(fProcessPartQtys,0);
  fBusObjectTableName:= 'tblProcessTime';
  fIdFieldName:= 'ProcessTimeId';
  fDeleted:= false;
  fActive:= true;
end;

procedure TProcessTimeNDS.DeleteNoCheck;
begin
  if ProcessTimeId <> 0 then begin
    Storer.RunSQLCommand(' Delete from tblprocesspartqty Where ProcesstimeID = '+ inttostr(ProcesstimeID)+';');
    inherited DeleteNoCheck;
    if ProcesspartId <> 0 then begin
      TProcessPartTimesheet.CancelAllJobs(ProcesspartId , Storer.connection);
(*      Storer.RunSQLCommand('Delete from tblbomworkorderlines where ProcessPartID = ' + inttostr(ProcesspartId)+';'+
      'delete from tblbomworkorder where ID not in (Select BOMWorkOrderID from tblbomworkorderlines);');*)

    end;
  end else begin
      Storer.RunSQLCommand('Delete from ' + fBusObjectTableName +' where ProcessPartID = ' + inttostr(ProcessPartID)+
                          '  and TimeStart >= ' + Quotedstr(formatDateTime(MySQLDatetimeformat , Timestart))  + ' and Date(timestart) = date(' + Quotedstr(formatDateTime(MySQLDatetimeformat , Timestart))  + ' );'
                          (*+' delete from tblBOMWorkOrderLines Where EmployeeId = '+ inttostr(employeeId) + ' and ProcesstimeID = '+ inttostr(ProcesstimeID)*));
  end;
end;

destructor TProcessTimeNDS.Destroy;
var
  ctr:Integer;
begin

  for ctr:= high(fProcessPartQtys) downto low(fProcessPartQtys) do FreeandNil(fProcessPartQtys[ctr]);
  Finalize(fProcessPartQtys);

  inherited;
end;

function TProcessTimeNDS.Endtime: TDatetime;
begin
  REsult := incSecond(TimeStart , trunc(Duration));
end;

function TProcessTimeNDS.GetId: integer;
begin
  result:= ProcessTimeId;
end;

function TProcessTimeNDS.LogString: String;
var
  x:Integer;
begin
  result := '';
  for x:=low(fProcessPartQtys) to high(fProcessPartQtys) do begin
    if result <> '' then result := result + ',' ;
    result := result +fProcessPartQtys[x].LogString;
  end;

end;

function TProcessTimeNDS.SaveNoCheck: boolean;
var
  ctr:Integer;
begin
    Result := inherited SaveNoCheck;
    for ctr:= low(fProcessPartQtys) to high(fProcessPartQtys) do begin
      if fProcessPartQtys[ctr].ProcesstimeId = 0 then fProcessPartQtys[ctr].ProcesstimeId  := ID;
      fProcessPartQtys[ctr].Save;
    end;
(*    if result then
      ProcessPartQtyList.Save;*)
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

procedure TProcessTimeNDS.SetId(const Value: integer);
begin
  inherited;
  ProcessTimeId:= Value;
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

(*procedure TProcessTimeNDS.setProcessTimeIDs(const Value: String);
begin
  if fsProcessTimeIDs <> Value then begin
    fsProcessTimeIDs := Value;
    MakeDirty;
  end;
end;*)

procedure TProcessTimeNDS.setResourcedetailsID(const Value: Integer);
begin
  if fiResourcedetailsID <> Value then begin
    fiResourcedetailsID := Value;
    MakeDirty;
  end;

end;
procedure TProcessTimeNDS.setEmployeeId(const Value: Integer);
begin
  if fiEmployeeId <> Value then begin
    fiEmployeeId := Value;
    MakeDirty;
  end;

end;
procedure TProcessTimeNDS.setSalesLineID(const Value: Integer);
begin
  if fiSalesLineID <> Value then begin
    fiSalesLineID := Value;
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

{ TProcessPartQtyNDS }
procedure TProcessPartQtyNDS.SetProcessPartQtyID   (Const Value :Integer    ); begin if fiProcessPartQtyID    <> Value then begin fiProcessPartQtyID   := Value; Dirty := true; end; end;
procedure TProcessPartQtyNDS.SetProcessPartID      (Const Value :Integer    ); begin if fiProcessPartID       <> Value then begin fiProcessPartID      := Value; Dirty := true; end; end;
procedure TProcessPartQtyNDS.SetProcesstimeID      (Const Value :Integer    ); begin if fiProcesstimeID       <> Value then begin fiProcesstimeID      := Value; Dirty := true; end; end;
procedure TProcessPartQtyNDS.SetBuildDate          (Const Value :TDateTime  ); begin if fdBuildDate           <> Value then begin fdBuildDate          := Value; Dirty := true; end; end;
procedure TProcessPartQtyNDS.SetQtyScheduled       (Const Value :Double     ); begin if fdQtyScheduled        <> Value then begin fdQtyScheduled       := Value; Dirty := true; end; end;
procedure TProcessPartQtyNDS.SetQtyBuilt           (Const Value :Double     ); begin if fdQtyBuilt            <> Value then begin fdQtyBuilt           := Value; Dirty := true; end; end;
procedure TProcessPartQtyNDS.SetQtyUsed            (Const Value :Double     ); begin if fdQtyUsed             <> Value then begin fdQtyUsed            := Value; Dirty := true; end; end;
procedure TProcessPartQtyNDS.SetScheduledEmployeeId(Const Value :Integer    ); begin if fiScheduledEmployeeId <> Value then begin fiScheduledEmployeeId:= Value; Dirty := true; end; end;
procedure TProcessPartQtyNDS.SetBuiltEmployeeId    (Const Value :Integer    ); begin if fiBuiltEmployeeId     <> Value then begin fiBuiltEmployeeId    := Value; Dirty := true; end; end;
procedure TProcessPartQtyNDS.Setactive             (Const Value :Boolean    ); begin if fbactive              <> Value then begin fbactive             := Value; Dirty := true; end; end;
procedure TProcessPartQtyNDS.SetId                 (const Value: integer    ); begin inherited; ProcessPartQtyID:= Value;end;
function TProcessPartQtyNDS.SaveNoCheck: boolean;
begin
    Result := inherited SaveNoCheck;
end;

constructor TProcessPartQtyNDS.Create(aOwner: TComponent);
begin
  inherited;
  fBusObjectTableName:= 'tblProcessPartQty';
  fIdFieldName:= 'Id';
end;

procedure TProcessPartQtyNDS.DeleteNoCheck;
begin
  inherited DeleteNoCheck;
end;

destructor TProcessPartQtyNDS.Destroy;
begin
  inherited;
end;

function TProcessPartQtyNDS.GetId: integer;begin  result:= ProcessPartQtyID;end;

function TProcessPartQtyNDS.LogString: sTRING;
begin
RESULT := inttostr(ProcessPartID)+',' +
            inttostr(ProcesstimeID)+',' +
            formatdatetime('dd-mm-yy hh:nn:ss' , BuildDate)+',' +
            floattostr(QtyScheduled          )+',' +
            floattostr(QtyBuilt              )+',' +
            floattostr(QtyUsed               )+',' +
            inttostr(ScheduledEmployeeId     )+',' +
            inttostr(BuiltEmployeeId        )+',' +
            Booltostr(active             );

end;

initialization
  RegisterClassOnce(TProcessTimeNDS);
  RegisterClassOnce(TProcessPartQtyNDS);
finalization
  UnregisterClass(TProcessTimeNDS);
  UnregisterClass(TProcessPartQtyNDS);

end.
