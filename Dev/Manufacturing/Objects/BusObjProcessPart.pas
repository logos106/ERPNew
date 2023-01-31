unit BusObjProcessPart;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  12/06/07  1.00.01  A  Initial Version.
  }


interface


uses BusObjBase, DB, Classes,   BusObjProcessStep,
  XMLDoc, XMLIntf, ProcessUtils, MyAccess;


type
  TProcessPartTimesheet = class(TMSBusObj)
  private
    AllJobsStoped:Boolean;

    function GetProcessPartID    : Integer   ;
    function GetEmployeeID       : Integer   ;
    function GetTimestart        : TDateTime ;
    function GetTimeEnd          : TDateTime ;
    procedure SetProcessPartID    (const Value: Integer   );
    procedure SetEmployeeID       (const Value: Integer   );
    procedure SetTimestart        (const Value: TDateTime );
    procedure SetTimeEnd          (const Value: TDateTime );
    function getActive: Boolean;
    procedure setActive(const Value: Boolean);
    function getComment: string;
    procedure SetComment(const Value: string);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    class Function  StopAllOpenJobs(fProcessPartID:Integer; fConnection:TCustomMyConnection):Boolean; overload;
    class Function  CancelAllJobs(fProcessPartID:Integer; fConnection:TCustomMyConnection):Boolean; overload;
    Function  StopAllOpenJobs:Boolean;Overload;
    Procedure StopAllOpenJobsCallback(Const Sender: TBusObj; var Abort: boolean);
    Function  CancelAllJobs:Boolean;Overload;
    Procedure CancelAllJobsCallback(Const Sender: TBusObj; var Abort: boolean);

  published
    property ProcessPartID     :Integer     read GetProcessPartID   write SetProcessPartID;
    property EmployeeID        :Integer     read GetEmployeeID      write SetEmployeeID   ;
    property Timestart         :TDateTime   read GetTimestart       write SetTimestart    ;
    property TimeEnd           :TDateTime   read GetTimeEnd         write SetTimeEnd      ;
    Property Active            :Boolean     read getActive          write setActive;
    property Comment           : string read getComment write SetComment;
  end;

  TProcessPart = class(TMSBusObj)
  private
    fProcessStep: TProcessStep;
    function GetPartId               : Integer   ;
    function GetProcessStepID        : Integer   ;
    function GetProcessStepSeq       : Integer   ;
    function GetProcTreeId           : Integer   ;
    function GetIsTemplate           : Boolean   ;
    function GetMakeCoupons          : Boolean   ;
    function GetCouponLabelPrinted   : Boolean    ;
    function GetDuration             : Double    ;
    function GetSetupDuration        : Double    ;
    function GetBreakdownDuration    : Double    ;
    function GetQtyPerCoupon         : Double    ;
    function GetRatePercoupon        : Double    ;
    function GetHourlyLabourRate     : Double    ;
    function GetHourlyOverheadRate   : Double    ;
    function GetFixedAmount          : Double    ;
    function GetCouponsPerBundle     : Double    ;
    function GetBundleQty            : Double    ;
    function GetTimeStart            : TDateTime ;
    function GetTimeEnd              : TDateTime ;
    function GetStatus               : TProcessPartStatus    ;
    procedure SetPartId               (const Value: Integer   );
    procedure SetProcessStepID        (const Value: Integer   );
    procedure SetProcessStepSeq       (const Value: Integer   );
    procedure SetProcTreeId           (const Value: Integer   );
    procedure SetIsTemplate           (const Value: Boolean   );
    procedure SetMakeCoupons          (const Value: Boolean   );
    procedure SetCouponLabelPrinted   (const Value: Boolean    );
    procedure SetDuration             (const Value: Double    );
    procedure SetSetupDuration        (const Value: Double    );
    procedure SetBreakdownDuration    (const Value: Double    );
    procedure SetQtyPerCoupon         (const Value: Double    );
    procedure SetRatePercoupon        (const Value: Double    );
    procedure SetHourlyLabourRate     (const Value: Double    );
    procedure SetHourlyOverheadRate   (const Value: Double    );
    procedure SetFixedAmount          (const Value: Double    );
    procedure SetCouponsPerBundle     (const Value: Double    );
    procedure SetBundleQty            (const Value: Double    );
    procedure SetTimeStart            (const Value: TDateTime );
    procedure SetTimeEnd              (const Value: TDateTime );
    procedure SetStatus               (const Value: TProcessPartStatus    );
    function GetProcessStep: TProcessStep;
    function GetProcessStepDescription: string;
    function GetProcessStepExtraInfo: string;
    procedure SetProcessStepDescription(const Value: string);
    procedure SetProcessStepExtraInfo(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    function     ValidateData: Boolean ;                                 override;
    function     Save: Boolean ;                                         override;
    property ProcessStep: TProcessStep read GetProcessStep;
  published
    property PartId                :Integer     read GetPartId              write SetPartId           ;
    property ProcessStepID         :Integer     read GetProcessStepID       write SetProcessStepID    ;
    property ProcessStepSeq        :Integer     read GetProcessStepSeq      write SetProcessStepSeq   ;
    property ProcTreeId            :Integer     read GetProcTreeId          write SetProcTreeId       ;
    property IsTemplate            :Boolean     read GetIsTemplate          write SetIsTemplate       ;
    property MakeCoupons           :Boolean     read GetMakeCoupons         write SetMakeCoupons      ;
    property CouponLabelPrinted    :Boolean     read GetCouponLabelPrinted  write SetCouponLabelPrinted ;
    property Duration              :Double      read GetDuration            write SetDuration         ;
    property SetupDuration         :Double      read GetSetupDuration       write SetSetupDuration    ;
    property BreakdownDuration     :Double      read GetBreakdownDuration   write SetBreakdownDuration;
    property QtyPerCoupon          :Double      read GetQtyPerCoupon        write SetQtyPerCoupon     ;
    property RatePercoupon         :Double      read GetRatePercoupon       write SetRatePercoupon    ;
    property HourlyLabourRate      :Double      read GetHourlyLabourRate    write SetHourlyLabourRate ;
    property HourlyOverheadRate    :Double      read GetHourlyOverheadRate  write SetHourlyOverheadRate ;
    property FixedAmount           :Double      read GetFixedAmount         write SetFixedAmount      ;
    property CouponsPerBundle      :Double      read GetCouponsPerBundle    write SetCouponsPerBundle ;
    property BundleQty             :Double      read GetBundleQty           write SetBundleQty        ;
    property TimeStart             :TDateTime   read GetTimeStart           write SetTimeStart        ;
    property TimeEnd               :TDateTime   read GetTimeEnd             write SetTimeEnd          ;
    property Status                :TProcessPartStatus      read GetStatus  write SetStatus           ;
    property ProcessStepDescription: string     read GetProcessStepDescription write SetProcessStepDescription;
    property ProcessStepExtraInfo  : string     read GetProcessStepExtraInfo   write SetProcessStepExtraInfo;
  end;


implementation


uses CommonLib, SysUtils, CommonDbLib;
 {TProcessPart}

constructor TProcessPart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProcessPart';
  fSQL := 'SELECT * FROM tblprocesspart';
end;


destructor TProcessPart.Destroy;
begin
  inherited;
end;


procedure TProcessPart.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PartId');
  SetPropertyFromNode(node,'ProcessStepID');
  SetPropertyFromNode(node,'ProcessStepSeq');
  SetPropertyFromNode(node,'ProcTreeId');
  SetPropertyFromNode(node,'IsTemplate');
  SetPropertyFromNode(node,'MakeCoupons');
  SetBooleanPropertyFromNode(node,'CouponLabelPrinted');
  SetPropertyFromNode(node,'Duration');
  SetPropertyFromNode(node,'SetupDuration');
  SetPropertyFromNode(node,'BreakdownDuration');
  SetPropertyFromNode(node,'QtyPerCoupon');
  SetPropertyFromNode(node,'RatePercoupon');
  SetPropertyFromNode(node,'HourlyLabourRate');
  SetPropertyFromNode(node,'HourlyOverheadRate');
  SetPropertyFromNode(node,'FixedAmount');
  SetPropertyFromNode(node,'CouponsPerBundle');
  SetPropertyFromNode(node,'BundleQty');
  SetPropertyFromNode(node,'TimeStart');
  SetPropertyFromNode(node,'TimeEnd');
  SetPropertyFromNode(node,'Status');
  SetPropertyFromNode(node,'ProcessStepExtraInfo');
end;


procedure TProcessPart.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PartId' ,PartId);
  AddXMLNode(node,'ProcessStepID' ,ProcessStepID);
  AddXMLNode(node,'ProcessStepSeq' ,ProcessStepSeq);
  AddXMLNode(node,'ProcTreeId' ,ProcTreeId);
  AddXMLNode(node,'IsTemplate' ,IsTemplate);
  AddXMLNode(node,'MakeCoupons' ,MakeCoupons);
  AddXMLNode(node,'CouponLabelPrinted' ,CouponLabelPrinted);
  AddXMLNode(node,'Duration' ,Duration);
  AddXMLNode(node,'SetupDuration' ,SetupDuration);
  AddXMLNode(node,'BreakdownDuration' ,BreakdownDuration);
  AddXMLNode(node,'QtyPerCoupon' ,QtyPerCoupon);
  AddXMLNode(node,'RatePercoupon' ,RatePercoupon);
  AddXMLNode(node,'HourlyLabourRate' ,HourlyLabourRate);
  AddXMLNode(node,'HourlyOverheadRate' ,HourlyOverheadRate);
  AddXMLNode(node,'FixedAmount' ,FixedAmount);
  AddXMLNode(node,'CouponsPerBundle' ,CouponsPerBundle);
  AddXMLNode(node,'BundleQty' ,BundleQty);
  AddXMLNode(node,'TimeStart' ,TimeStart);
  AddXMLNode(node,'TimeEnd' ,TimeEnd);
  AddXMLNode(node,'Status' ,Status);
  AddXMLNode(node,'ProcessStepExtraInfo' ,ProcessStepExtraInfo);
end;


function TProcessPart.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TProcessPart.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProcessPart.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcessPart.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProcessPart.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TProcessPart.GetIDField: string;
begin
  Result := 'ID'
end;

class function TProcessPart.GetBusObjectTablename: string;
begin
  Result := 'tblprocesspart';
end;

function TProcessPart.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
function  TProcessPart.GetPartId           : Integer   ; begin Result := GetIntegerField('PartId');end;
function  TProcessPart.GetProcessStepID    : Integer   ; begin Result := GetIntegerField('ProcessStepID');end;
function  TProcessPart.GetProcessStepSeq   : Integer   ; begin Result := GetIntegerField('ProcessStepSeq');end;
function  TProcessPart.GetProcTreeId       : Integer   ; begin Result := GetIntegerField('ProcTreeId');end;
function  TProcessPart.GetIsTemplate       : Boolean   ; begin Result := GetBooleanField('IsTemplate');end;
function  TProcessPart.GetMakeCoupons      : Boolean   ; begin Result := GetBooleanField('MakeCoupons');end;
function  TProcessPart.GetCouponLabelPrinted: Boolean   ; begin Result := GetBooleanField('CouponLabelPrinted');end;
function  TProcessPart.GetDuration         : Double    ; begin Result := GetFloatField('Duration');end;
function  TProcessPart.GetSetupDuration    : Double    ; begin Result := GetFloatField('SetupDuration');end;
function  TProcessPart.GetBreakdownDuration: Double    ; begin Result := GetFloatField('BreakdownDuration');end;
function  TProcessPart.GetQtyPerCoupon     : Double    ; begin Result := GetFloatField('QtyPerCoupon');end;
function  TProcessPart.GetRatePercoupon    : Double    ; begin Result := GetFloatField('RatePercoupon');end;
function  TProcessPart.GetHourlyLabourRate : Double    ; begin Result := GetFloatField('HourlyLabourRate');end;
function  TProcessPart.GetHourlyOverheadRate: Double    ; begin Result := GetFloatField('HourlyOverheadRate');end;
function  TProcessPart.GetFixedAmount      : Double    ; begin Result := GetFloatField('FixedAmount');end;
function  TProcessPart.GetCouponsPerBundle : Double    ; begin Result := GetFloatField('CouponsPerBundle');end;
function  TProcessPart.GetBundleQty        : Double    ; begin Result := GetFloatField('BundleQty');end;
function  TProcessPart.GetTimeStart        : TDateTime ; begin Result := GetDateTimeField('TimeStart');end;
function  TProcessPart.GetTimeEnd          : TDateTime ; begin Result := GetDateTimeField('TimeEnd');end;
procedure TProcessPart.SetPartId           (const Value: Integer   ); begin SetIntegerField('PartId'            , Value);end;
procedure TProcessPart.SetProcessStepID    (const Value: Integer   ); begin SetIntegerField('ProcessStepID'     , Value);end;
procedure TProcessPart.SetProcessStepSeq   (const Value: Integer   ); begin SetIntegerField('ProcessStepSeq'    , Value);end;
procedure TProcessPart.SetProcTreeId       (const Value: Integer   ); begin SetIntegerField('ProcTreeId'        , Value);end;
procedure TProcessPart.SetIsTemplate       (const Value: Boolean   ); begin SetBooleanField('IsTemplate'        , Value);end;
procedure TProcessPart.SetMakeCoupons      (const Value: Boolean   ); begin SetBooleanField('MakeCoupons'       , Value);end;
procedure TProcessPart.SetCouponLabelPrinted(const Value: Boolean   ); begin SetBooleanField('CouponLabelPrinted', Value);end;
procedure TProcessPart.SetDuration         (const Value: Double    ); begin SetFloatField('Duration'            , Value);end;
procedure TProcessPart.SetSetupDuration    (const Value: Double    ); begin SetFloatField('SetupDuration'       , Value);end;
procedure TProcessPart.SetBreakdownDuration(const Value: Double    ); begin SetFloatField('BreakdownDuration'   , Value);end;
procedure TProcessPart.SetQtyPerCoupon     (const Value: Double    ); begin SetFloatField('QtyPerCoupon'        , Value);end;
procedure TProcessPart.SetRatePercoupon    (const Value: Double    ); begin SetFloatField('RatePercoupon'       , Value);end;
procedure TProcessPart.SetHourlyLabourRate (const Value: Double    ); begin SetFloatField('HourlyLabourRate'    , Value);end;
procedure TProcessPart.SetHourlyOverheadRate(const Value: Double    ); begin SetFloatField('HourlyOverheadRate' , Value);end;
procedure TProcessPart.SetFixedAmount      (const Value: Double    ); begin SetFloatField('FixedAmount'         , Value);end;
procedure TProcessPart.SetCouponsPerBundle (const Value: Double    ); begin SetFloatField('CouponsPerBundle'    , Value);end;
procedure TProcessPart.SetBundleQty        (const Value: Double    ); begin SetFloatField('BundleQty'           , Value);end;
procedure TProcessPart.SetTimeStart        (const Value: TDateTime ); begin SetDateTimeField('TimeStart'        , Value);end;
procedure TProcessPart.SetTimeEnd          (const Value: TDateTime ); begin SetDateTimeField('TimeEnd'          , Value);end;

function  TProcessPart.GetProcessStepExtraInfo: string ; begin Result := GetStringField('ProcessStepExtraInfo');end;
procedure TProcessPart.SetProcessStepExtraInfo(const Value: String);begin SetStringField('ProcessStepExtraInfo' , Value);end;
function  TProcessPart.GetStatus           : TProcessPartStatus    ; begin Result := StrToProcessPartStatus(GetStringField('Status'));end;
procedure TProcessPart.SetStatus           (const Value: TProcessPartStatus    ); begin SetStringField('Status' , ProcessPartStatusToStr(Value));end;



function TProcessPart.GetProcessStep: TProcessStep;
begin
  if not Assigned(fProcessStep) then
    fProcessStep:= TProcessStep.Create(self);
  if fProcessStep.Id <> ProcessStepID then
    fProcessStep.Load(ProcessStepID);
  result:= fProcessStep;
end;

function TProcessPart.GetProcessStepDescription: string;
begin
  result:= ProcessStep.Description;
  FreeAndNil(fProcessStep);
end;

procedure TProcessPart.SetProcessStepDescription(const Value: string);
begin
  if ProcessStep.Description <> Value then begin
    fProcessStep.LoadSelect('`Description` = ' + QuotedStr(Value));
    ProcessStepID:= fProcessStep.Id;
  end;  
end;

  {TProcessPartTimesheet}

constructor TProcessPartTimesheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProcessPartTimesheet';
  fSQL := 'SELECT * FROM tblprocessparttimesheet';
end;


destructor TProcessPartTimesheet.Destroy;
begin
  inherited;
end;


procedure TProcessPartTimesheet.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProcessPartID');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'Active');
  SetDateTimePropertyFromNode(node,'Timestart');
  SetDateTimePropertyFromNode(node,'TimeEnd');
end;


procedure TProcessPartTimesheet.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProcessPartID' ,ProcessPartID);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'Timestart' ,Timestart);
  AddXMLNode(node,'TimeEnd' ,TimeEnd);
  AddXMLNode(node,'Active' ,Active);
end;


function TProcessPartTimesheet.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TProcessPartTimesheet.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProcessPartTimesheet.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcessPartTimesheet.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProcessPartTimesheet.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcessPartTimesheet.GetIDField: string;
begin
  Result := 'ID'
end;


class function TProcessPartTimesheet.GetBusObjectTablename: string;
begin
  Result:= 'tblprocessparttimesheet';
end;


function TProcessPartTimesheet.getComment: string;
begin
  Result := GetStringField('Comment');
end;

function TProcessPartTimesheet.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TProcessPartTimesheet.GetProcessPartID: Integer   ; begin Result := GetIntegerField('ProcessPartID');end;
function  TProcessPartTimesheet.GetEmployeeID   : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TProcessPartTimesheet.GetTimestart    : TDateTime ; begin Result := GetDateTimeField('Timestart');end;
function  TProcessPartTimesheet.GetTimeEnd      : TDateTime ; begin Result := GetDateTimeField('TimeEnd');end;
function  TProcessPartTimesheet.getActive       : Boolean   ; begin Result := getBooleanfield('Active');end;

procedure TProcessPartTimesheet.SetProcessPartID(const Value: Integer   ); begin SetIntegerField( 'ProcessPartID', Value);end;
procedure TProcessPartTimesheet.SetComment(const Value: string);
begin
  SetStringField('Comment', Value);
end;

procedure TProcessPartTimesheet.SetEmployeeID   (const Value: Integer   ); begin SetIntegerField('EmployeeID'    , Value);end;
procedure TProcessPartTimesheet.SetTimestart    (const Value: TDateTime ); begin SetDateTimeField('Timestart'     , Value);end;
procedure TProcessPartTimesheet.SetTimeEnd      (const Value: TDateTime ); begin SetDateTimeField('TimeEnd'       , Value);end;
procedure TProcessPartTimesheet.setActive       (const Value: Boolean   ); begin  SetBooleanField('Active'        , Value);end;
class Function  TProcessPartTimesheet.CancelAllJobs(fProcessPartID:Integer; fConnection:TCustomMyConnection):Boolean; 
var
  PPT:  TProcessPartTimesheet;
begin
  REsult := False;
  PPT:= TProcessPartTimesheet.Create(nil) ;
  Try
    PPT.Connection := TMyDacDataConnection.Create(PPT);
    if fconnection = nil then fconnection :=CommonDbLib.GetNewMyDacConnection(PPT);
    PPt.Connection.connection := fconnection;
    PPT.LoadSelect('ProcessPartID= ' +IntToStr(fProcessPartID) );
    if PPT.count = 0 then exit;
    REsult := PPT.CancelAllJobs;
  finally
      FreeandNil(PPT);
  end;
end;  
class Function TProcessPartTimesheet.StopAllOpenJobs(fProcessPartID: Integer; fConnection: TCustomMyConnection):Boolean;
var
  PPT:  TProcessPartTimesheet;
begin
  PPT:= TProcessPartTimesheet.Create(nil) ;
  Try
    PPT.Connection := TMyDacDataConnection.Create(PPT);
    if fconnection = nil then fconnection :=CommonDbLib.GetNewMyDacConnection(PPT);
    PPt.Connection.connection := fconnection;
    PPT.LoadSelect('ProcessPartID= ' +IntToStr(fProcessPartID) +' and ifnull(Timestart,0) <> 0 and ifnull(TimeEnd ,0) = 0 ');
    if PPT.count = 0 then begin
      REsult := True;
      exit;
    end;
    REsult := PPT.StopAllOpenJobs;
  finally
      FreeandNil(PPT);
  end;
end;

procedure TProcessPartTimesheet.StopAllOpenJobsCallback(const Sender: TBusObj; var Abort: boolean);
begin
  if not(Sender is TProcessPartTimesheet) then exit;
  try
    if TProcessPartTimesheet(Sender).TimeEnd = 0 then begin
        TProcessPartTimesheet(Sender).TimeEnd := now;
        TProcessPartTimesheet(Sender).PostDB;
    end;
  Except
      AllJobsStoped:= False;
  end;
end;

Function TProcessPartTimesheet.StopAllOpenJobs:boolean;
begin
  if not((UserLock.Lock('tblProcessParttimesheet' , 0)) and
                (UserLock.Lock('tblProcessPart' , 0))) then begin
       UserLock.UnLock('tblProcessParttimesheet', 0);
       UserLock.UnLock('tblProcessPart'         , 0);
       Result := False;
       ResultStatus.addItem(False, rssWarning , 0 , 'ProcessParttimesheet - Updating End Time failed'+chr(13) +UserLock.LockMessage );
       Exit;
  end;
  AllJobsStoped:= true;
  try
    Iteraterecords(StopAllOpenJobsCallback);
  Finally
       UserLock.UnLock('tblProcessParttimesheet', 0);
       UserLock.UnLock('tblProcessPart'         , 0);
       result := AllJobsStoped;
  end;
end;

function TProcessPartTimesheet.CancelAllJobs: Boolean;
begin
  if not((UserLock.Lock('tblProcessParttimesheet' , 0)) and
                (UserLock.Lock('tblProcessPart' , 0))) then begin
       UserLock.UnLock('tblProcessParttimesheet', 0);
       UserLock.UnLock('tblProcessPart'         , 0);
       Result := False;
       ResultStatus.addItem(False, rssWarning , 0 , 'ProcessParttimesheet - Updating End Time failed'+chr(13) +UserLock.LockMessage );
       Exit;
  end;
  AllJobsStoped:= true;
  try
    Iteraterecords(CancelAllJobsCallback);
  Finally
       UserLock.UnLock('tblProcessParttimesheet', 0);
       UserLock.UnLock('tblProcessPart'         , 0);
       result := AllJobsStoped;
  end;

end;

procedure TProcessPartTimesheet.CancelAllJobsCallback(const Sender: TBusObj;var Abort: boolean);
begin
  if not(Sender is TProcessPartTimesheet) then exit;
  try
        if TProcessPartTimesheet(Sender).TimeEnd = 0 then TProcessPartTimesheet(Sender).timeEnd := 0;
        TProcessPartTimesheet(Sender).Active := False;
        TProcessPartTimesheet(Sender).PostDB;
  Except
      AllJobsStoped:= False;
  end;

end;



initialization
  RegisterClass(TProcessPartTimesheet);
  RegisterClassOnce(TProcessPart);


end.
