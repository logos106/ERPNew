unit BusObjProcessPartNDS;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  12/06/07  1.00.01  A  Initial Version.
  }


interface


uses BusObjNDSBase, DB, Classes,  BusObjProcessStep, BusObjProcessTimeNDS,
  XMLDoc, XMLIntf, BusObjProcResource, ProcessUtils;


type
  TProcessPartQtyList = class(TBusObjNDSList)
  private
  protected
    function GetItem(const index: integer): TProcessPartQtyNDS; reintroduce;
  public
    property Item[const index: integer]: TProcessPartQtyNDS Read GetItem; default;
    function AddProcessPartQty: TProcessPartQtyNDS;
    function ItemById(const Id: integer): TProcessPartQtyNDS;
  end;

  TProcessPartNDS = class(TMSBusObjNDS)
  private
    fProcessStep: TProcessStep;
    fIsTemplate: Boolean;
    fMakeCoupons: Boolean;
    fBreakdownDuration: Double;
    fQtyPerCoupon: Double;
    fRAtePercoupon: Double;
    fFixedAmount: Double;
    fDuration: Double;
    fSetupDuration: Double;
    fProcTreeId: Integer;
    fProcessStepSeq: Integer;
    fProcessStepID: Integer;
    fPartId: Integer;
    fStatus: TProcessPartStatus;
    fTimeEnd: TDateTime;
    fTimeStart: TDateTime;
    //fProcessTimeList: TProcessTimeList;
    fProcResourceProcessDetails: TProcResourceProcessDetails;
    fHourlyLabourRate :Double;
    fHourlyOverheadRate :Double;
    fProcessStepExtraInfo:String;
    fBuildingBlockQty :Double;
    fProcessPartQtyList: TProcessPartQtyList;
    function GetProcessPartQtyList: TProcessPartQtyList;

    function GetProcessStep: TProcessStep;
    function GetProcessStepDescription: string;
    //function GetProcessTimeList: TProcessTimeList;
    function getProcResourceProcessDetails: TProcResourceProcessDetails;

    procedure SetBreakdownDuration(const Value: Double);
    procedure SetQtyPerCoupon(const Value: Double);
    procedure SetRAtePercoupon(const Value: Double);
    procedure SetDuration(const Value: Double);
    procedure SetFixedAmount(const Value: Double);
    procedure SetIsTemplate(const Value: Boolean);
    procedure SetMakeCoupons(const Value: Boolean);
    procedure SetPartId(const Value: Integer);
    procedure SetProcessStepDescription(const Value: string);
    procedure SetProcessStepID(const Value: Integer);
    procedure SetProcessStepSeq(const Value: Integer);
    procedure SetProcTreeId(const Value: Integer);
    procedure SetSetupDuration(const Value: Double);
    procedure SetStatus(const Value: TProcessPartStatus);
    procedure SetTimeEnd(const Value: TDateTime);
    procedure SetTimeStart(const Value: TDateTime);
    Procedure SetHourlyOverheadRate(const Value:Double);
    Procedure setHourlyLabourRate(const Value:Double);
    procedure SetProcessStepExtraInfo(const Value: string);
    Procedure setBuildingBlockQty(const Value:Double);
  protected
    Function RelatedRecordsDeleteSQL:String;Override;
  public
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    property ProcessStep: TProcessStep read GetProcessStep;
    //property ProcessTimeList: TProcessTimeList read GetProcessTimeList;
    property ProcessStepDescription: string read GetProcessStepDescription write SetProcessStepDescription;
    procedure Assign(Source: TPersistent); override;
    Property ProcResourceProcessDetails:TProcResourceProcessDetails REad getProcResourceProcessDetails;
    property ProcessPartQtyList: TProcessPartQtyList read GetProcessPartQtyList;
  published
    property Id;
    property PartId                :Integer     read fPartId                write SetPartId           ;
    property ProcessStepID         :Integer     read fProcessStepID         write SetProcessStepID    ;
    property ProcessStepSeq        :Integer     read fProcessStepSeq        write SetProcessStepSeq   ;
    property ProcTreeId            :Integer     read fProcTreeId            write SetProcTreeId       ;
    property IsTemplate            :Boolean     read fIsTemplate            write SetIsTemplate       ;
    property MakeCoupons           :Boolean     read fMakeCoupons           write SetMakeCoupons      ;
    property Duration              :Double      read fDuration              write SetDuration         ;
    property SetupDuration         :Double      read fSetupDuration         write SetSetupDuration    ;
    property BreakdownDuration     :Double      read fBreakdownDuration     write SetBreakdownDuration;
    property QtyPerCoupon          :Double      read fQtyPerCoupon          write SetQtyPerCoupon     ;
    property RAtePercoupon         :Double      read fRAtePercoupon         write SetRAtePercoupon    ;
    property FixedAmount           :Double      read fFixedAmount           write SetFixedAmount      ;
    property TimeStart             :TDateTime   read fTimeStart             write SetTimeStart        ;
    property TimeEnd               :TDateTime   read fTimeEnd               write SetTimeEnd          ;
    property Status                :TProcessPartStatus      read fStatus    write SetStatus           ;
    Property HourlyLabourRate      :Double      read fHourlyLabourRate      write setHourlyLabourRate ;
    Property HourlyOverheadRate    :Double      read fHourlyOverheadRate    write setHourlyOverheadRate;
    property ProcessStepExtraInfo  :string      read fProcessStepExtraInfo  write SetProcessStepExtraInfo;
    Property BuildingBlockQty      :Double      read fBuildingBlockQty      write setBuildingBlockQty ;
  end;


implementation


uses CommonLib, SysUtils, BusObjProcess, tcConst;

{ TProcessPartNDS }

procedure TProcessPartNDS.Assign(Source: TPersistent);
begin
  inherited;
  fIsTemplate:= TProcessPartNDS(Source).IsTemplate;
  fMakeCoupons:= TProcessPartNDS(Source).MakeCoupons;
  fBreakdownDuration:= TProcessPartNDS(Source).BreakdownDuration;
  fQtyPerCoupon:= TProcessPartNDS(Source).QtyPerCoupon;
  fRAtePercoupon:= TProcessPartNDS(Source).RAtePercoupon;
  fFixedAmount:= TProcessPartNDS(Source).FixedAmount;
  fDuration:= TProcessPartNDS(Source).Duration;
  fSetupDuration:= TProcessPartNDS(Source).SetupDuration;
  fProcessStepSeq:= TProcessPartNDS(Source).ProcessStepSeq;
  fProcessStepID:= TProcessPartNDS(Source).ProcessStepID;
  fPartId:= TProcessPartNDS(Source).PartId;
  fStatus:= TProcessPartNDS(Source).Status;
  fTimeEnd:= TProcessPartNDS(Source).TimeEnd;
  fTimeStart:= TProcessPartNDS(Source).TimeStart;
  fHourlyOverheadRate := TProcessPartNDS(Source).HourlyOverheadRate;
  fHourlyLabourRate   := TProcessPartNDS(Source).HourlyLabourRate;
  fProcessStepExtraInfo := TProcessPartNDS(Source).ProcessStepExtraInfo;
  fBuildingBlockQty   := TProcessPartNDS(Source).BuildingBlockQty;
end;

constructor TProcessPartNDS.Create(AOwner: TComponent);
begin
  inherited;
  fIdFieldName:= 'Id';
  fBusObjectTableName:= 'tblProcessPart';
  fStatus:= psNotScheduled;
  fIsTemplate:= false;
  fMakeCoupons:= false;
  fProcResourceProcessDetails := nil;
end;

function TProcessPartNDS.RelatedRecordsDeleteSQL: String;
begin
  Result := 'Delete from tblbarcodexref  where barcodetype = ' + Quotedstr(BarCodeType_WorkOrder)+
            ' and intvalue1 = ' +  inttostr(proctreeId) +
            ' and intvalue2 = ' +  inttostr(Id) +';'+
            ' Delete from tblprocProgress  where ifnull(ProcTreePartId,0) = '+  inttostr(Id) +';';
end;

destructor TProcessPartNDS.Destroy;
begin

  inherited;
end;
function TProcessPartNDS.GetProcessPartQtyList: TProcessPartQtyList;
var
  SaveDirty: boolean;
begin
  if not Assigned(fProcessPartQtyList) then begin
    fProcessPartQtyList:= TProcessPartQtyList.Create(self);
    fProcessPartQtyList.ItemClassName:= 'TProcessPartQtyNDS';
    if self.Id > 0 then begin
      { Get steps linked to this node }
      fProcessPartQtyList.LoadSql:=
        'SELECT * FROM `tblProcessPartQty` WHERE `ProcessPartId` = ' +
        IntToStr(self.Id);
      SaveDirty:= self.Dirty;
      try
        Storer.LoadList(fProcessPartQtyList);
      finally
        self.Dirty:= SaveDirty;
      end;
    end;
  end;
  result:= fProcessPartQtyList;
end;

function TProcessPartNDS.GetProcessStep: TProcessStep;
begin
  if not Assigned(fProcessStep) then
    fProcessStep := TProcessStep.Create(self);
  if fProcessStep.Id <> fProcessStepID then
    fProcessStep.Load(fProcessStepID);

  Result := fProcessStep;
end;

function TProcessPartNDS.GetProcessStepDescription: string;
begin
  result:= ProcessStep.Description;
  FreeAndNil(fProcessStep);
end;

(*function TProcessPartNDS.GetProcessTimeList: TProcessTimeList;
var
  SaveDirty: boolean;
begin
  if not Assigned(fProcessTimeList) then begin
    fProcessTimeList:= TProcessTimeList.Create(self);
    fProcessTimeList.ItemClassName:= 'TProcessTimeNDS';
    if self.Id > 0 then begin
      { Get steps linked to this node }
      fProcessTimeList.LoadSql:=
        'SELECT * FROM `tblProcessTime` WHERE `ProcessPartId` = ' +
        IntToStr(self.Id);
      SaveDirty:= self.Dirty;
      try
        Storer.LoadList(fProcessTimeList);
      finally
        self.Dirty:= SaveDirty;
      end;
    end;
  end;
  result:= fProcessTimeList;
end;*)

function TProcessPartNDS.getProcResourceProcessDetails: TProcResourceProcessDetails;
begin
  if not(Assigned(fProcResourceProcessDetails)) then begin
    fProcResourceProcessDetails := TProcResourceProcessDetails.create(Self);
    fProcResourceProcessDetails.LoadSelect('PRP.ProcessStepid =' +IntToStr(ProcessStepID));
  end;
  result := fProcResourceProcessDetails;
end;

procedure TProcessPartNDS.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
end;

procedure TProcessPartNDS.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProcessStepDescription',self.ProcessStepDescription);
  AddXMLNode(node,'ProcessStepExtraInfo',self.ProcessStepExtraInfo);
  AddXMLNode(node,'PartId',self.PartId);
  AddXMLNode(node,'ProcessStepID',self.ProcessStepID);
  AddXMLNode(node,'ProcessStepSeq',self.ProcessStepSeq);
  AddXMLNode(node,'ProcTreeId',self.ProcTreeId);
  AddXMLNode(node,'IsTemplate',self.IsTemplate);
  AddXMLNode(node,'MakeCoupons',self.MakeCoupons);
  AddXMLNode(node,'Duration',self.Duration);
  AddXMLNode(node,'SetupDuration',self.SetupDuration);
  AddXMLNode(node,'BreakdownDuration',self.BreakdownDuration);
  AddXMLNode(node,'QtyPerCoupon',self.QtyPerCoupon);
  AddXMLNode(node,'RAtePercoupon',self.RAtePercoupon);
  AddXMLNode(node,'FixedAmount',self.FixedAmount);
  AddXMLNode(node,'TimeStart',self.TimeStart);
  AddXMLNode(node,'TimeEnd',self.TimeEnd);
  AddXMLNode(node,'Status',self.Status);
  AddXMLNode(node,'HourlyOverheadRate',self.HourlyOverheadRate);
  AddXMLNode(node,'ProcessStepExtraInfo',self.ProcessStepExtraInfo);
  AddXMLNode(node,'HourlyLabourRate',self.HourlyLabourRate);
  AddXMLNode(node,'BuildingBlockQty',self.BuildingBlockQty);
end;
procedure TProcessPartNDS.SetProcessStepDescription(const Value: string);
begin
  if ProcessStep.Description <> Value then begin
    fProcessStep.LoadSelect('`Description` = ' + QuotedStr(Value));
    fProcessStepID:= fProcessStep.Id;
    MakeDirty;
  end;
end;

procedure TProcessPartNDS.SetBreakdownDuration    (const Value: Double    );begin  fBreakdownDuration     := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetQtyPerCoupon         (const Value: Double    );begin  fQtyPerCoupon          := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetRAtePercoupon        (const Value: Double    );begin  fRAtePercoupon         := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetDuration             (const Value: Double    );begin  fDuration              := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetFixedAmount          (const Value: Double    );begin  fFixedAmount           := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetIsTemplate           (const Value: Boolean   );begin  fIsTemplate            := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetMakeCoupons          (const Value: Boolean   );begin  fMakeCoupons           := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetPartId               (const Value: Integer   );begin  fPartId                := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetProcessStepExtraInfo (const Value: string    );begin  fProcessStepExtraInfo  := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetProcessStepID        (const Value: Integer   );begin  fProcessStepID         := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetProcessStepSeq       (const Value: Integer   );begin  fProcessStepSeq        := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetProcTreeId           (const Value: Integer   );begin  fProcTreeId            := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetSetupDuration        (const Value: Double    );begin  fSetupDuration         := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetHourlyLabourRate     (const Value: Double    );begin  fHourlyLabourRate      := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetBuildingBlockQty     (const Value: Double    );begin  fBuildingBlockQty      := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetHourlyOverheadRate   (const Value: Double    );begin  fHourlyOverheadRate    := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetTimeEnd              (const Value: TDateTime );begin  fTimeEnd               := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetTimeStart            (const Value: TDateTime );begin  fTimeStart             := Value;  MakeDirty;end;
procedure TProcessPartNDS.SetStatus               (const Value: TProcessPartStatus);
begin
  if Assigned(Self.owner) and (Self.owner is TProcTreeNode) then TProcTreeNode(Self.Owner).OnBeforechangeStatus(fStatus ,Value);
  fStatus := Value;
  MakeDirty;
end;

{ TProcessPartQtyList }

function TProcessPartQtyList.AddProcessPartQty: TProcessPartQtyNDS;
begin
  result:= TProcessPartQtyNDS.Create(nil);
  self.Add(result);
end;

function TProcessPartQtyList.GetItem(const index: integer): TProcessPartQtyNDS;
begin
  result:= TProcessPartQtyNDS(inherited GetItem(index));
end;

function TProcessPartQtyList.ItemById(const Id: integer): TProcessPartQtyNDS;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to self.Count -1 do begin
    if Item[x].Id = Id then begin
      result:= TProcessPartQtyNDS(Item[x]);
      break;
    end;
  end;
end;

initialization
  RegisterClassOnce(TProcessPartNDS);
finalization
  UnregisterClass(TProcessPartNDS);
end.




