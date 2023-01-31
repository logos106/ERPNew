unit BusObjProductTreetoImport;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  01/06/10  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjProcess;


type
  TProductTreeToImport = class(TMSBusObj)
  private
    fsTempTablename: String;
    Allvalid :boolean;
    InvalidItems:TStringList;
    Validatefieldno:Integer;
    PreviousProcTreeId:Integer;
    
    function GetPartname               : string    ;
    function GetSequenceDown           : Integer   ;
    function GetSequenceUp             : Integer   ;
    function GetCaption                : string    ;
    function GetDescription            : string    ;
    function GetComments               : string    ;
    function GetDetails                : string    ;
    function GetTreePartsName          : string    ;
    function GetQuantity               : Double    ;
    function GetTotalQty               : Double    ;
    function GetHideOnPrint            : Boolean   ;
    function GetAddToSale              : Boolean   ;
    function GetInputType              : string    ;
    function GetPrice                  : Double    ;
    function GetCost                   : Double    ;
    function GetSelected               : Boolean   ;
    (*function GetValue                  : string    ;*)
    function GetComplete               : Boolean   ;
    function GetLevel                  : Integer   ;
    function GetInfo                   : string    ;
    function GetTreePartUOMQuantity    : Double    ;
    function GetUOM                    : string    ;
    function GetTreePartUOMTotalQty    : Double    ;
    function GetMultiplier             : Double    ;
    function GetProcessStepSeq         : Integer   ;
    function GetDuration               : Double    ;
    function GetSetupDuration          : Double    ;
    function GetBreakdownDuration      : Double    ;
    (*function GetProcessPartPartname    : string    ;*)
    function GetResourceDescription    : string    ;
    function GetResourceName           : string    ;
    function GetProcessStep            : string    ;
    function GetProcTreeId             : Integer   ;
    function GetProcessStepID          : Integer   ;
    function GetParentId               : Integer   ;
    function GetMasterId               : Integer   ;
    function GetPartsId                : Integer   ;
    function GetUOMID                  : Integer   ;
    function GetTreePartsID            : Integer   ;
    function GetProcessPartPartID      : Integer   ;
    function GetProcResourceId         : Integer   ;
    procedure SetPartname               (const Value: string    );
    procedure SetSequenceDown           (const Value: Integer   );
    procedure SetSequenceUp             (const Value: Integer   );
    procedure SetCaption                (const Value: string    );
    procedure SetDescription            (const Value: string    );
    procedure SetComments               (const Value: string    );
    procedure SetDetails                (const Value: string    );
    procedure SetTreePartsName          (const Value: string    );
    procedure SetQuantity               (const Value: Double    );
    procedure SetTotalQty               (const Value: Double    );
    procedure SetHideOnPrint            (const Value: Boolean   );
    procedure SetAddToSale              (const Value: Boolean   );
    procedure SetInputType              (const Value: string    );
    procedure SetPrice                  (const Value: Double    );
    procedure SetCost                   (const Value: Double    );
    procedure SetSelected               (const Value: Boolean   );
    (*procedure SetValue                  (const Value: string    );*)
    procedure SetComplete               (const Value: Boolean   );
    procedure SetLevel                  (const Value: Integer   );
    procedure SetInfo                   (const Value: string    );
    procedure SetTreePartUOMQuantity    (const Value: Double    );
    procedure SetUOM                    (const Value: string    );
    procedure SetTreePartUOMTotalQty    (const Value: Double    );
    procedure SetMultiplier             (const Value: Double    );
    procedure SetProcessStepSeq         (const Value: Integer   );
    procedure SetDuration               (const Value: Double    );
    procedure SetSetupDuration          (const Value: Double    );
    procedure SetBreakdownDuration      (const Value: Double    );
    (*procedure SetProcessPartPartname    (const Value: string    );*)
    procedure SetResourceDescription    (const Value: string    );
    procedure SetResourceName           (const Value: string    );
    procedure SetProcessStep            (const Value: string    );
    procedure SetProcTreeId             (const Value: Integer   );
    procedure SetProcessStepID          (const Value: Integer   );
    procedure SetParentId               (const Value: Integer   );
    procedure SetUOMID                  (const Value: Integer   );
    procedure SetTreePartsID            (const Value: Integer   );
    procedure SetProcessPartPartID      (const Value: Integer   );
    procedure SetProcResourceId         (const Value: Integer   );
    procedure SetMasterId               (const Value: Integer   );
    procedure SetPartsId                (const Value: Integer   );

    Procedure DoValidateforImport;
    Procedure DoValidateForimportCallback(Const Sender: TBusObj; var Abort: boolean);
    function  DoValidatePart:Boolean;
    function  DoValidateUOM:Boolean;
    function  DoValidateproctreePart:Boolean;
    function  DoValidateParentId:Boolean;
    function  DoValidateProcessPart:Boolean;
    function  DoValidateResource:Boolean;
    Function  DoValidateProcessStep:Boolean;
    Function AddSubItems:Boolean;
    Function hasChildren:Boolean;
    Function MaxProcTreeId:Integer;

    Procedure AddLine(ProductProcTree:TProductProcTree; const fParentID:Integer; Conn :TMyDacDataConnection; AOwner:TProductTreeToImport);
    Procedure AddProcesses(ProductProcTree:TProductProcTree;fiProcTreeID:Integer; TreeObj:TProductTreeToImport);
    Function StrtoImputType(Const Value:String):TNodeInputType;
    function recno: String;
    Procedure AddIfMissing(const Value:String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;


  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                   Overload;override;
    constructor  Create(AOwner: TComponent; TempTablename:String); reintroduce; Overload;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function     ValidateForImport:Boolean;
    function     DoImport:Boolean;
    Class Function ExportProductTreeSQL(Const PartIDs:String;IdEx:Integer=0; CurLevel:Integer=0; fiPartsID:Integer = 0 ; fsPartsName:String = ''):string;
  published
    property Partname                :string      read GetPartname              write SetPartname           ;
    property SequenceDown            :Integer     read GetSequenceDown          write SetSequenceDown       ;
    property SequenceUp              :Integer     read GetSequenceUp            write SetSequenceUp         ;
    property Caption                 :string      read GetCaption               write SetCaption            ;
    property Description             :string      read GetDescription           write SetDescription        ;
    property Comments                :string      read GetComments              write SetComments           ;
    property Details                 :string      read GetDetails               write SetDetails            ;
    property TreePartsName           :string      read GetTreePartsName         write SetTreePartsName      ;
    property Quantity                :Double      read GetQuantity              write SetQuantity           ;
    property TotalQty                :Double      read GetTotalQty              write SetTotalQty           ;
    property HideOnPrint             :Boolean     read GetHideOnPrint           write SetHideOnPrint        ;
    property AddToSale               :Boolean     read GetAddToSale             write SetAddToSale          ;
    property InputType               :string      read GetInputType             write SetInputType          ;
    property Price                   :Double      read GetPrice                 write SetPrice              ;
    property Cost                    :Double      read GetCost                  write SetCost               ;
    property Selected                :Boolean     read GetSelected              write SetSelected           ;
    (*property Value                   :string      read GetValue                 write SetValue              ;*)
    property Complete                :Boolean     read GetComplete              write SetComplete           ;
    property Level                   :Integer     read GetLevel                 write SetLevel              ;
    property Info                    :string      read GetInfo                  write SetInfo               ;
    property TreePartUOMQuantity     :Double      read GetTreePartUOMQuantity   write SetTreePartUOMQuantity;
    property UOM                     :string      read GetUOM                   write SetUOM                ;
    property TreePartUOMTotalQty     :Double      read GetTreePartUOMTotalQty   write SetTreePartUOMTotalQty;
    property Multiplier              :Double      read GetMultiplier            write SetMultiplier         ;
    property ProcessStepSeq          :Integer     read GetProcessStepSeq        write SetProcessStepSeq     ;
    property Duration                :Double      read GetDuration              write SetDuration           ;
    property SetupDuration           :Double      read GetSetupDuration         write SetSetupDuration      ;
    property BreakdownDuration       :Double      read GetBreakdownDuration     write SetBreakdownDuration  ;
    (*property ProcessPartPartname     :string      read GetProcessPartPartname   write SetProcessPartPartname;*)
    property ResourceDescription     :string      read GetResourceDescription   write SetResourceDescription;
    property ResourceName            :string      read GetResourceName          write SetResourceName       ;
    property ProcessStep             :string      read GetProcessStep           write SetProcessStep        ;
    property ProcTreeId              :Integer     read GetProcTreeId            write SetProcTreeId         ;
    property ProcessStepID           :Integer     read GetProcessStepID         write SetProcessStepID      ;
    property ParentId                :Integer     read GetParentId              write SetParentId           ;
    property UOMID                   :Integer     read GetUOMID                 write SetUOMID              ;
    property TreePartsID             :Integer     read GetTreePartsID           write SetTreePartsID        ;
    property ProcessPartPartID       :Integer     read GetProcessPartPartID     write SetProcessPartPartID  ;
    property ProcResourceId          :Integer     read GetProcResourceId        write SetProcResourceId     ;
    property MasterId                :Integer     read GetMasterId              write SetMasterId           ;
    property PartsId                 :Integer     read GetPartsId               write SetPartsId            ; 
  end;


implementation


uses SysUtils,tcDataUtils, CommonLib,  BusObjProcResource,
  ERPdbComponents,tcConst, FastFuncs, ClassFuncs, BusObjNDSBase ,
  ProgressDialog, BusObjProcessPartNDS, CommonDbLib, Dialogs, BusobjUOM,
  AppEnvironment;



  {TProductTreeToImport}

constructor TProductTreeToImport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM '+fsTempTablename;
  fBusObjectTypeDescription:= 'ProductTreeToImport';

end;


destructor TProductTreeToImport.Destroy;
begin
  inherited;
end;


procedure TProductTreeToImport.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Partname');
  SetPropertyFromNode(node,'SequenceDown');
  SetPropertyFromNode(node,'SequenceUp');
  SetPropertyFromNode(node,'Caption');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'Comments');
  SetPropertyFromNode(node,'Details');
  SetPropertyFromNode(node,'TreePartsName');
  SetPropertyFromNode(node,'Quantity');
  SetPropertyFromNode(node,'TotalQty');
  SetBooleanPropertyFromNode(node,'HideOnPrint');
  SetBooleanPropertyFromNode(node,'AddToSale');
  SetPropertyFromNode(node,'InputType');
  SetPropertyFromNode(node,'Price');
  SetPropertyFromNode(node,'Cost');
  SetBooleanPropertyFromNode(node,'Selected');
  (*SetPropertyFromNode(node,'Value');*)
  SetBooleanPropertyFromNode(node,'Complete');
  SetPropertyFromNode(node,'Level');
  SetPropertyFromNode(node,'Info');
  SetPropertyFromNode(node,'TreePartUOMQuantity');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'TreePartUOMTotalQty');
  SetPropertyFromNode(node,'Multiplier');
  SetPropertyFromNode(node,'ProcessStepSeq');
  SetPropertyFromNode(node,'Duration');
  SetPropertyFromNode(node,'SetupDuration');
  SetPropertyFromNode(node,'BreakdownDuration');
  (*SetPropertyFromNode(node,'ProcessPartPartname');*)
  SetPropertyFromNode(node,'ResourceDescription');
  SetPropertyFromNode(node,'ResourceName');
  SetPropertyFromNode(node,'ProcessStep');
  SetPropertyFromNode(node,'ProcTreeId');
  SetPropertyFromNode(node,'ProcessStepID');
  SetPropertyFromNode(node,'ParentId');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'TreePartsID');
  SetPropertyFromNode(node,'ProcessPartPartID');
  SetPropertyFromNode(node,'ProcResourceId');
  SetPropertyFromNode(node,'MasterId');
  SetPropertyFromNode(node,'PartsId');
end;


procedure TProductTreeToImport.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Partname' ,Partname);
  AddXMLNode(node,'SequenceDown' ,SequenceDown);
  AddXMLNode(node,'SequenceUp' ,SequenceUp);
  AddXMLNode(node,'Caption' ,Caption);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'Details' ,Details);
  AddXMLNode(node,'TreePartsName' ,TreePartsName);
  AddXMLNode(node,'Quantity' ,Quantity);
  AddXMLNode(node,'TotalQty' ,TotalQty);
  AddXMLNode(node,'HideOnPrint' ,HideOnPrint);
  AddXMLNode(node,'AddToSale' ,AddToSale);
  AddXMLNode(node,'InputType' ,InputType);
  AddXMLNode(node,'Price' ,Price);
  AddXMLNode(node,'Cost' ,Cost);
  AddXMLNode(node,'Selected' ,Selected);
  (*AddXMLNode(node,'Value' ,Value);*)
  AddXMLNode(node,'Complete' ,Complete);
  AddXMLNode(node,'Level' ,Level);
  AddXMLNode(node,'Info' ,Info);
  AddXMLNode(node,'TreePartUOMQuantity' ,TreePartUOMQuantity);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'TreePartUOMTotalQty' ,TreePartUOMTotalQty);
  AddXMLNode(node,'Multiplier' ,Multiplier);
  AddXMLNode(node,'ProcessStepSeq' ,ProcessStepSeq);
  AddXMLNode(node,'Duration' ,Duration);
  AddXMLNode(node,'SetupDuration' ,SetupDuration);
  AddXMLNode(node,'BreakdownDuration' ,BreakdownDuration);
  (*AddXMLNode(node,'ProcessPartPartname' ,ProcessPartPartname);*)
  AddXMLNode(node,'ResourceDescription' ,ResourceDescription);
  AddXMLNode(node,'ResourceName' ,ResourceName);
  AddXMLNode(node,'ProcessStep' ,ProcessStep);
  AddXMLNode(node,'ProcTreeId' ,ProcTreeId);
  AddXMLNode(node,'ProcessStepID' ,ProcessStepID);
  AddXMLNode(node,'ParentId' ,ParentId);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'TreePartsID' ,TreePartsID);
  AddXMLNode(node,'ProcessPartPartID' ,ProcessPartPartID);
  AddXMLNode(node,'ProcResourceId' ,ProcResourceId);
  AddXMLNode(node,'MasterId' ,MasterId);
  AddXMLNode(node,'PartsId' ,PartsId);
end;


function TProductTreeToImport.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TProductTreeToImport.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProductTreeToImport.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  //don't want to clear the result status in validate import
  // iterate records called for each category and the errors
  // are stored in resultstatus and displayed all categories error together at the end 
 // inherited;
end;


procedure TProductTreeToImport.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProductTreeToImport.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProductTreeToImport.GetIDField: string;
begin
  Result := 'ID'
end;


class function TProductTreeToImport.GetBusObjectTablename: string;
begin
  Result:= ''; // the table name is changed dynamically for the temp table created
end;


function TProductTreeToImport.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TProductTreeToImport.GetPartname           : string    ; begin Result := GetStringField('Partname');end;
function  TProductTreeToImport.GetSequenceDown       : Integer   ; begin Result := GetIntegerField('SequenceDown');end;
function  TProductTreeToImport.GetSequenceUp         : Integer   ; begin Result := GetIntegerField('SequenceUp');end;
function  TProductTreeToImport.GetCaption            : string    ; begin Result := GetStringField('Caption');end;
function  TProductTreeToImport.GetDescription        : string    ; begin Result := GetStringField('Description');end;
function  TProductTreeToImport.GetComments           : string    ; begin Result := GetStringField('Comments');end;
function  TProductTreeToImport.GetDetails            : string    ; begin Result := GetStringField('Details');end;
function  TProductTreeToImport.GetTreePartsName      : string    ; begin Result := GetStringField('TreePartsName');end;
function  TProductTreeToImport.GetQuantity           : Double    ; begin Result := GetFloatField('Quantity');end;
function  TProductTreeToImport.GetTotalQty           : Double    ; begin Result := GetFloatField('TotalQty');end;
function  TProductTreeToImport.GetHideOnPrint        : Boolean   ; begin Result := GetBooleanField('HideOnPrint');end;
function  TProductTreeToImport.GetAddToSale          : Boolean   ; begin Result := GetBooleanField('AddToSale');end;
function  TProductTreeToImport.GetInputType          : string    ; begin Result := GetStringField('InputType');end;
function  TProductTreeToImport.GetPrice              : Double    ; begin Result := GetFloatField('Price');end;
function  TProductTreeToImport.GetCost               : Double    ; begin Result := GetFloatField('Cost');end;
function  TProductTreeToImport.GetSelected           : Boolean   ; begin Result := GetBooleanField('Selected');end;
(*function  TProductTreeToImport.GetValue              : string    ; begin Result := GetStringField('Value');end;*)
function  TProductTreeToImport.GetComplete           : Boolean   ; begin Result := GetBooleanField('Complete');end;
function  TProductTreeToImport.GetLevel              : Integer   ; begin Result := GetIntegerField('Level');end;
function  TProductTreeToImport.GetInfo               : string    ; begin Result := GetStringField('Info');end;
function  TProductTreeToImport.GetTreePartUOMQuantity: Double    ; begin Result := GetFloatField('TreePartUOMQuantity');end;
function  TProductTreeToImport.GetUOM                : string    ; begin Result := GetStringField('UOM');end;
function  TProductTreeToImport.GetTreePartUOMTotalQty: Double    ; begin Result := GetFloatField('TreePartUOMTotalQty');end;
function  TProductTreeToImport.GetMultiplier         : Double    ; begin Result := GetFloatField('Multiplier');end;
function  TProductTreeToImport.GetProcessStepSeq     : Integer   ; begin Result := GetIntegerField('ProcessStepSeq');end;
function  TProductTreeToImport.GetDuration           : Double    ; begin Result := GetFloatField('Duration');end;
function  TProductTreeToImport.GetSetupDuration      : Double    ; begin Result := GetFloatField('SetupDuration');end;
function  TProductTreeToImport.GetBreakdownDuration  : Double    ; begin Result := GetFloatField('BreakdownDuration');end;
(*function  TProductTreeToImport.GetProcessPartPartname: string    ; begin Result := GetStringField('ProcessPartPartname');end;*)
function  TProductTreeToImport.GetResourceDescription: string    ; begin Result := GetStringField('ResourceDescription');end;
function  TProductTreeToImport.GetResourceName       : string    ; begin Result := GetStringField('ResourceName');end;
function  TProductTreeToImport.GetProcessStep        : string    ; begin Result := GetStringField('ProcessStep');end;
function  TProductTreeToImport.GetProcTreeId         : Integer   ; begin Result := GetIntegerField('ProcTreeId');end;
function  TProductTreeToImport.GetProcessStepID      : Integer   ; begin Result := GetIntegerField('ProcessStepID');end;
function  TProductTreeToImport.GetParentId           : Integer   ; begin Result := GetIntegerField('ParentId');end;
function  TProductTreeToImport.GetUOMID              : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TProductTreeToImport.GetTreePartsID        : Integer   ; begin Result := GetIntegerField('TreePartsID');end;
function  TProductTreeToImport.GetProcessPartPartID  : Integer   ; begin Result := GetIntegerField('ProcessPartPartID');end;
function  TProductTreeToImport.GetProcResourceId     : Integer   ; begin Result := GetIntegerField('ProcResourceId');end;
function  TProductTreeToImport.GetMasterId           : Integer   ; begin Result := GetIntegerField('MasterId');end;
function  TProductTreeToImport.GetPartsId            : Integer   ; begin Result := GetIntegerField('PartsId');end;
procedure TProductTreeToImport.SetPartname           (const Value: string    ); begin SetStringField('Partname'            , Value);end;
procedure TProductTreeToImport.SetSequenceDown       (const Value: Integer   ); begin SetIntegerField('SequenceDown'        , Value);end;
procedure TProductTreeToImport.SetSequenceUp         (const Value: Integer   ); begin SetIntegerField('SequenceUp'          , Value);end;
procedure TProductTreeToImport.SetCaption            (const Value: string    ); begin SetStringField('Caption'             , Value);end;
procedure TProductTreeToImport.SetDescription        (const Value: string    ); begin SetStringField('Description'         , Value);end;
procedure TProductTreeToImport.SetComments           (const Value: string    ); begin SetStringField('Comments'         , Value);end;
procedure TProductTreeToImport.SetDetails            (const Value: string    ); begin SetStringField('Details'             , Value);end;
procedure TProductTreeToImport.SetTreePartsName      (const Value: string    ); begin SetStringField('TreePartsName'       , Value);end;
procedure TProductTreeToImport.SetQuantity           (const Value: Double    ); begin SetFloatField('Quantity'            , Value);end;
procedure TProductTreeToImport.SetTotalQty           (const Value: Double    ); begin SetFloatField('TotalQty'            , Value);end;
procedure TProductTreeToImport.SetHideOnPrint        (const Value: Boolean   ); begin SetBooleanField('HideOnPrint'         , Value);end;
procedure TProductTreeToImport.SetAddToSale          (const Value: Boolean   ); begin SetBooleanField('AddToSale'           , Value);end;
procedure TProductTreeToImport.SetInputType          (const Value: string    ); begin SetStringField('InputType'           , Value);end;
procedure TProductTreeToImport.SetPrice              (const Value: Double    ); begin SetFloatField('Price'               , Value);end;
procedure TProductTreeToImport.SetCost               (const Value: Double    ); begin SetFloatField('Cost'                , Value);end;
procedure TProductTreeToImport.SetSelected           (const Value: Boolean   ); begin SetBooleanField('Selected'            , Value);end;
(*procedure TProductTreeToImport.SetValue              (const Value: string    ); begin SetStringField('Value'               , Value);end;*)
procedure TProductTreeToImport.SetComplete           (const Value: Boolean   ); begin SetBooleanField('Complete'            , Value);end;
procedure TProductTreeToImport.SetLevel              (const Value: Integer   ); begin SetIntegerField('Level'               , Value);end;
procedure TProductTreeToImport.SetInfo               (const Value: string    ); begin SetStringField('Info'                , Value);end;
procedure TProductTreeToImport.SetTreePartUOMQuantity(const Value: Double    ); begin SetFloatField('TreePartUOMQuantity' , Value);end;
procedure TProductTreeToImport.SetUOM                (const Value: string    ); begin SetStringField('UOM'                 , Value);end;
procedure TProductTreeToImport.SetTreePartUOMTotalQty(const Value: Double    ); begin SetFloatField('TreePartUOMTotalQty'         , Value);end;
procedure TProductTreeToImport.SetMultiplier         (const Value: Double    ); begin SetFloatField('Multiplier'          , Value);end;
procedure TProductTreeToImport.SetProcessStepSeq     (const Value: Integer   ); begin SetIntegerField('ProcessStepSeq'      , Value);end;
procedure TProductTreeToImport.SetDuration           (const Value: Double    ); begin SetFloatField('Duration'            , Value);end;
procedure TProductTreeToImport.SetSetupDuration      (const Value: Double    ); begin SetFloatField('SetupDuration'       , Value);end;
procedure TProductTreeToImport.SetBreakdownDuration  (const Value: Double    ); begin SetFloatField('BreakdownDuration'   , Value);end;
(*procedure TProductTreeToImport.SetProcessPartPartname(const Value: string    ); begin SetStringField('ProcessPartPartname'         , Value);end;*)
procedure TProductTreeToImport.SetResourceDescription(const Value: string    ); begin SetStringField('ResourceDescription'         , Value);end;
procedure TProductTreeToImport.SetResourceName       (const Value: string    ); begin SetStringField('ResourceName'        , Value);end;
procedure TProductTreeToImport.SetProcessStep        (const Value: string    ); begin SetStringField('ProcessStep'        , Value);end;
procedure TProductTreeToImport.SetProcTreeId         (const Value: Integer   ); begin SetIntegerField('ProcTreeId'          , Value);end;
procedure TProductTreeToImport.SetProcessStepID      (const Value: Integer   ); begin SetIntegerField('ProcessStepID'          , Value);end;
procedure TProductTreeToImport.SetParentId           (const Value: Integer   ); begin SetIntegerField('ParentId'            , Value);end;
procedure TProductTreeToImport.SetUOMID              (const Value: Integer   ); begin SetIntegerField('UOMID'               , Value);end;
procedure TProductTreeToImport.SetTreePartsID        (const Value: Integer   ); begin SetIntegerField('TreePartsID'         , Value);end;
procedure TProductTreeToImport.SetProcessPartPartID  (const Value: Integer   ); begin SetIntegerField('ProcessPartPartID'   , Value);end;
procedure TProductTreeToImport.SetProcResourceId  (const Value: Integer   ); begin SetIntegerField('ProcResourceId'   , Value);end;
procedure TProductTreeToImport.SetMasterId           (const Value: Integer   ); begin SetIntegerField('MasterId'            , Value);end;
procedure TProductTreeToImport.SetPartsId            (const Value: Integer   ); begin SetIntegerField('PartsId'            , Value);end;

constructor TProductTreeToImport.Create(AOwner: TComponent;  TempTablename: String);
begin
  fsTempTablename := TempTablename;
  Create(AOwner);
end;
Function TProductTreeToImport.recno:String;
begin
  REsult := 'Line #' +IntToStr(Dataset.Recno)+':' ;
end;
function TProductTreeToImport.ValidateForImport: Boolean;
begin
  DoShowProgressbar(14 , 'Please Wait','Validating Data' );
  try

  DoStepProgressbar('Unit of Measure in the Header');
  First;
  if PArentId <> 0 then begin

    ResultStatus.AddItem(True , rssWarning , 0 , Caption +': Header Should Be The First Row In The Group And ParentId Should Always Be 0.  Import Failed.');
    Result := False;
    Exit;
  end else begin
      if (Multiplier <> 1) or (not (Sysutils.SameText(UOM, AppEnv.DefaultClass.DefaultUOM))) then begin
        ResultStatus.AddItem(True , rssInfo , 0 , Caption +': Header Will Allways Have Default Unit of measure.  '+ UOM+'(' + FloatToStr(Multiplier)+') Is Changed To ' + AppEnv.DefaultClass.DefaultUOM +'(1) In The Header (' +Caption +').');
        Multiplier := 1;
        uom := AppEnv.DefaultClass.DefaultUOM;
      end;
  end;
  
  DoStepProgressbar('Unique ProcTreeId');
  With getNewdataset('Select ProcTreeId , count(Distinct Caption) ctr from ' +fsTempTablename +' where MasterId = ' +IntToStr(MasterID) +' group by ProcTreeId') do try
    if count = 0 then begin
      ResultStatus.AddItem(True , rssWarning , 0 , 'File Is Empty.  Import Failed.');
      Result := False;
      Exit;
    end;

    First;
    While Eof = False do begin
      if Fieldbyname('ctr').asInteger > 1 then begin
        ResultStatus.AddItem(True , rssWarning , 0 , 'ProcTreeId is not Unique in the file. Import Failed.');
        Result := False;
        Exit;
      end;
      Next;
    end;
  finally
      if Active then Close;
      Free;
  end;




  PreviousProcTreeId := 0;
  Result := False;
  Allvalid := True;
  DoStepProgressbar('Product');
  Validatefieldno := 1; DoValidateforImport;
  DoStepProgressbar('Product');
  Validatefieldno := 2; DoValidateforImport;
  DoStepProgressbar('Unit of measure');
  Validatefieldno := 3; DoValidateforImport;
  DoStepProgressbar('ParentId');
  Validatefieldno := 4; DoValidateforImport;
  DoStepProgressbar('Product');
  Validatefieldno := 5; DoValidateforImport;
  DoStepProgressbar('Resource');
  Validatefieldno := 6; DoValidateforImport;
  DoStepProgressbar('Process Step');
  Validatefieldno := 7; DoValidateforImport;
  if not Allvalid then begin
    MessageDlgXP_Vista('Import Failed.'+chr(13) + ResultStatus.GetAllMessages(0 , chr(13)) , mtWarning , [mbok] , 0);
    exit;
  end;

  {don't add sub items if all is not valid}
  DoStepProgressbar('Searching for Subitems');
  ResultStatus.Clear;
  Validatefieldno := 8;  DoValidateforImport;
                        if not allValid then begin 
                          MessageDlgXP_Vista('Import Failed.'+chr(13) + ResultStatus.Messages , mtWarning , [mbok], 0);
                          exit;
                        end;
  DoStepProgressbar('Option Items and Product Unit of Measure');
  With commondblib.TempMyScript do try
    connection := Self.connection.connection;
    {option item if selected qty cannot be blank}
    SQL.add('update  ' +fsTempTablename +'  main  '+
              ' inner join  ' +fsTempTablename +'  Opt   '+
              ' on opt.ProcTreeId = main.ParentID and opt.inputtype = "itOption"   and opt.MasterID = ' +IntToStr(MasterID)+
              ' Set main.TreePartUOMQuantity = 1   '+
              ' where ifnull(main.selected,"F") ="T"  '+
              ' and main.MasterID = ' +IntToStr(MasterID)+
              ' and ifnull(main.TreePartUOMQuantity,0) =0;');
    Execute;
  finally
      Free;
  end;
  DoStepProgressbar;
  With commondblib.TempMyScript do try
    connection := Self.connection.connection;
    {option item if not selected qty should be 0}
    SQL.add('update  ' +fsTempTablename +'  main    '+
              ' inner join  ' +fsTempTablename +'  Opt   '+
              ' on opt.ProcTreeId = main.ParentID and opt.inputtype = "itOption"    '+
              ' and opt.MasterID = ' +IntToStr(MasterID)+
              ' Set main.TreePartUOMQuantity = 0   '+
              ' where ifnull(main.selected,"F") ="F"  '+
              ' and main.MasterID = ' +IntToStr(MasterID)+
              ' and ifnull(main.TreePartUOMQuantity,0) =1;');
    Execute;
  finally
      Free;
  end;
  DoStepProgressbar;
  With commondblib.TempMyScript do try
    connection := Self.connection.connection;
    {Treeitem if linked to product - unit should not be blank}
    SQL.add('update  ' +fsTempTablename +
              ' Set UOM = ' +Quotedstr(AppEnv.DefaultClass.DefaultUOM) +' ,   '+
              ' Multiplier = 1    '+
              ' where ifnull(treepartsname ,"")<> ""   '+
              ' and MasterID = ' +IntToStr(MasterID)+
              ' and (ifnull(UOM,"") = ""  or ifnull(Multiplier,0) = 0 );');
    Execute;
  finally
      Free;
  end;
  DoStepProgressbar;
  With commondblib.TempMyScript do try
    connection := Self.connection.connection;
    {Product Price}
    SQL.add('update  ' +fsTempTablename + ' T  Set Price = (Select Price1 from tblParts P where P.PartsId = T.TreePartsID ) '+
              ' where ifnull(T.Price,0) = 0  '+
              ' and T.MasterID = ' +IntToStr(MasterID)+';');
    SQL.add('update  ' +fsTempTablename + ' T  Set Cost= (Select cost1 from tblParts P where P.PartsId = T.TreePartsID ) '+
              ' where ifnull(T.cost,0) = 0  '+
              ' and T.MasterID = ' +IntToStr(MasterID)+';');
    Execute;
  finally
      Free;
  end;                        
  Result := True;
  finally
      DoHideProgressbar;
  end;
end;
Procedure TProductTreeToImport.DoValidateforImport;
  function Validatefield:String;
  begin
         if Validatefieldno =1 then Result := 'On The Spreadsheet The Column Name Called "PartName" Has Non-Existant Products'
    else if Validatefieldno =2 then Result := 'On The Spreadsheet The Column Name Called "TreePartsName" Has Non-Existant Products'
    else if Validatefieldno =3 then Result := 'On The Spreadsheet The Column Name Called "Multiplier" Has the Wrong Quantity'
    else if Validatefieldno =4 then REsult := 'On The Spreadsheet The Column Name Called "ParentID" Has no Matching Entry In The Column "ProcTreeId"'
    (*else if Validatefieldno =5 then REsult := 'On The Spreadsheet The Column Name Called "ProcessPartPartname" Has Non-Existant Products'*)
    else if Validatefieldno =6 then REsult := 'On The Spreadsheet The Column Name Called "ResourceName" Is Missing From EP.'
    else if Validatefieldno =7 then Result := 'On The Spreadsheet The Column Name Called "ProcessStep" Is Missing From EP.'
  end;
begin

    InvalidItems:= TStringList.Create;
    try
      IterateREcords(DoValidateForimportCallback);
      if InvalidItems.Text<> '' then begin
          ResultStatus.AddItem(True , rssWarning , 0 , Validatefield+ chr(13) +InvalidItems.Text , False);
      end;
    finally
        FreeandNil(InvalidItems);
    end;
end;
procedure TProductTreeToImport.DoValidateForimportCallback(const Sender: TBusObj; var Abort: boolean);
begin
           if Validatefieldno =1 then begin if not DoValidatePart         then begin allValid := False; end;
  end else if Validatefieldno =2 then begin if not DoValidateproctreePart then begin allValid := False; end;
  end else if Validatefieldno =3 then begin if not DoValidateUOM          then begin allValid := False; end;
  end else if Validatefieldno =4 then begin if not DoValidateParentId     then begin allValid := False; end;
  end else if Validatefieldno =5 then begin if not DoValidateProcessPart  then begin allValid := False; end;
  end else if Validatefieldno =6 then begin if not DoValidateResource     then begin allValid := False; end;
  end else if Validatefieldno =7 then begin if not DoValidateProcessStep  then begin allValid := False; end;
  end else if Validatefieldno =8 then begin if not AddSubItems            then begin allValid := False; end;
  end;
end;

{ValidateUOM}
Function TProductTreeToImport.DoValidateUOM:boolean;
var
  fUOM:TUnitOfMeasure;
begin
  Result := True;
  if (UOM= '') and (TreePartsName = '' ) then exit;

  fUOM:= TUnitOfMeasure.Create(Self);
  try
    fUOM.Connection := Self.connection;
    UOMID:=fUOM.CreateUOM(Self.UOM,Multiplier,TreePartsID,0 , True);
    if UOMID = 0 then  UOMID:= fUOM.CreateUOM(AppEnv.DefaultClass.DefaultUOM , 1 , 0,0);
    if fUOM.Multiplier<> Multiplier then begin
      //ResultStatus.AddItem(True , rssInfo , 0 , recno+UOM+'''s Multiplier(' + FloatToStr(Multiplier) +') is Invalid and the Correct Multipier is :' +floatToStr(fUOM.Multiplier) , False );
      (*if InvalidItems <> '' then InvalidItems := InvalidItems + chr(13) ;
      InvalidItems:= InvalidItems + recno +#9 + UOM +#9 + FloatToStr(Multiplier) +#9 +floatToStr(fUOM.Multiplier);*)
      AddIfMissing((*recno +#9 + *)UOM +': Multiplier Will Be Changed From ('+ FloatToStr(Multiplier) +') to ('  +floatToStr(fUOM.Multiplier)+')');
      Multiplier := fUOM.Multiplier;
      TreePartUOMQuantity := Quantity/Multiplier;
      TreePartUOMTotalQty := TotalQty/Multiplier;
    end;
  finally
      FreeandNil(fUOM);
  end;
  PostDB;
  result := UOMID<> 0;
end;
{ValidateproctreePart}
function TProductTreeToImport.DoValidateproctreePart: Boolean;
begin
  Result := True;
  if TreePartsName = '' then exit;
  TreePartsID := GetProduct(TreePartsName);
  if TreePartsId = 0 then begin
     //ResultStatus.AddItem(True , rssInfo , 0 , recno+'Invalid Productname :' + TreePartsName, False);
     (*if InvalidItems <> '' then InvalidItems := InvalidItems + chr(13) ;
     InvalidItems:= InvalidItems + recno +  TreePartsName;*)
     AddIfMissing(TreePartsName);
     REsult := False;
  end;
  PostDB;
end;
{ValidateParentId}
function TProductTreeToImport.DoValidateParentId: Boolean;
begin
  if parentId = 0 then begin
      result := True;
      Exit;
  end;
  with GetNewDataSet('Select Id from ' +fsTempTablename +' where   MasterId = ' + IntToStr(MasterID) +' and ProcTreeId = ' +IntToStr(ParentId) , true) do try
      result := recordcount <> 0;
      if not result then begin
        (*if InvalidItems <> '' then InvalidItems := InvalidItems + chr(13) ;
        InvalidItems:= InvalidItems + Self.recno ;*)
        AddIfMissing(Self.Recno);
      end;
  finally
      if active then close;
      Free;
  end;
end;
{ValidateProcessPart}
function TProductTreeToImport.DoValidateProcessPart: Boolean;
begin
  result := True;
  ProcessPartPartID := PartsID;
  (*if ProcessPartPartname = '' then exit;
  ProcessPartPartID := GetProduct(ProcessPartPartname);
  if ProcessPartPartID = 0 then begin
     //ResultStatus.AddItem(True , rssInfo , 0 , recno+'Invalid Productname :' + ProcessPartPartname, False);
     AddIfMissing(ProcessPartPartName);
     REsult := False;
  end;*)
  PostDB;
end;
{ValidateResource}

function TProductTreeToImport.DoValidateResource: Boolean;
var
  ProcResource :TProcResource;
begin
  Result := True;
  if ResourceName = '' then exit;
  ProcResource := TProcResource.create(Self);
  try
    ProcResource.LoadSelect('ResourceName = ' +QuotedStr(ResourceName));
    result :=ProcResource.count = 1;
    if result then
      ProcResourceId :=ProcResource.ID
    else begin
      (*if InvalidItems <> '' then InvalidItems := InvalidItems + chr(13) ;
      InvalidItems:= InvalidItems + recno +  ResourceName;*)
      AddIfMissing(resourceName);
    end;
  finally
      FreeandNil(ProcResource);
  end;
  PostDB;
end;

function TProductTreeToImport.DoValidatePart: Boolean;
begin
  Result := True;
  if Partname = '' then exit;
  PartsID := GetProduct(Partname);
  if PartsID = 0 then begin
     //ResultStatus.AddItem(True , rssInfo , 0 , recno+'Invalid Productname :' + Partname, False);
     (*if InvalidItems <> '' then InvalidItems := InvalidItems + chr(13) ;
     InvalidItems:= InvalidItems + recno +  Partname;*)
     AddIfMissing(PartName);
     REsult := False;
  end;
  PostDB;
end;

function TProductTreeToImport.DoValidateProcessStep: Boolean;
begin
  Result := True;
  if ProcessStep = '' then exit;
  with GetNewDataSet('Select ID from tblprocessstep where Description = '+QuotedStr(ProcessStep)) do try
    result := recordcount = 1;
    if result then ProcessStepID := Fieldbyname('ID').asInteger
    else begin
        (*if InvalidItems <> '' then InvalidItems := InvalidItems + chr(13) ;
        InvalidItems:= InvalidItems + Self.recno +  #9+ ProcessStep;*)
        AddIfMissing(ProcessStep);
    end;
  finally
      if active then close;
      Free;
  end;
  PostDB;
end;

class function TProductTreeToImport.ExportProductTreeSQL(const PartIDs: String;IdEx:Integer=0; CurLevel:Integer=0; fiPartsID:Integer = 0 ; fsPartsName:String = ''):string;
  Function PartDetails :String;
  begin
    result := '';
    if fiPartsId  = 0   then result := result +' P.PartsID , '           else result := result + IntToStr(fipartsID)+' as PartsID,';
    if fsPartsName= ''  then result := result +' P.PARTNAME Partname, '  else result := result + QuotedStr(fsPartsName)       +' as Partname,';
  end;
begin
    Result  := 'SELECT ' +
        ' PTD.ProcTreeId + ' +IntToStr(IdEx) +' as ProcTreeId  , ' +
        ' if(ifnull(PTD.ParentId,0)=0 , 0,  PTD.ParentId + ' +IntToStr(IdEx) +') as ParentId, ' +
        ' PT.MasterID, ' +
        PartDetails+
        ' PTD.SequenceDown, ' +
        ' PTD.SequenceUp, ' +
        ' PTD.Caption, ' +
        ' PTD.Description Description, ' +
        ' PTD.Comments Comments, ' +
        ' PTD.Details, ' +
        ' PTDP.PartsID AS TreePartsID , ' +
        ' PTDP.PARTNAME AS TreePartsName, ' +
        ' PTD.Quantity, ' +
        ' PTD.TotalQty, ' +
        ' PTD.TotalQtyOriginal, ' +
        //' PTD.TotalQtyUsed, ' +
        ' PTD.HideOnPrint, ' +
        ' PTD.AddToSale, ' +
        ' PTD.InputType, ' +
        ' PTD.CustomInputClass, ' +
        'PTD.TreePricechanged,'+
        ' PTD.Price, ' +
        ' PTD.Cost, ' +
        ' PTD.Selected, ' +
        (*' PTD.Value, ' +*)
        ' PTD.Complete, ' +
        ' PTD.Level + ' +IntToStr(CurLevel) +' as Level, ' +
        ' PTD.Info, ' +
        ' PTD.TreePartUOMQuantity, ' +
        ' uom.UnitID UOMID, ' +
        ' UOM.UnitName AS UOM, ' +
        ' PTD.TreePartUOMTotalQty, ' +
        ' UOM.Multiplier, ' +
        ' PP.ProcessStepSeq as ProcessStepSeq, ' +
        ' PP.Duration as Duration, ' +
        ' PP.SetupDuration as SetupDuration, ' +
        ' PP.BreakdownDuration as BreakdownDuration, ' +
        ' PP.PartId ProcessPartPartID, ' +
        (*' PPP.Partname ProcessPartPartname, ' +*)
        ' PR.Description ResourceDescription, ' +
         ' PR.ProcResourceId, ' +
        ' PR.ResourceName, ' +
        ' PS.Description ProcessStep ,' +
        ' PS.ID ProcessStepID  ' +
        ' FROM ' +
        ' tblparts AS P ' +
        ' Inner Join tblproctree            AS PT     ON P.PARTSID          = PT.MasterId   and PT.MasterType = "mtProduct"   AND PT.ParentId    =  0 ' +
        ' Inner Join tblproctree            AS PTD    ON P.PARTSID          = PTD.MasterId AND PTD.MasterType =  "mtProduct" and PT.ProcTreeId = PTD.TreeRootId' +
        ' Left  Join tblprocesspart         AS PP     ON PTD.ProcTreeId     = PP.ProcTreeId ' +
        (*' Left  Join tblparts               AS PPP    ON PP.PartId          = PPP.PARTSID ' +*)
        ' Left  Join tblprocessstep         AS PS     ON PP.ProcessStepID   = PS.ID ' +
        ' Left  Join tblprocresourceprocess AS RP     ON RP.ProcessStepId   = PS.ID ' +
        ' Left  Join tblprocresource        AS PR     ON PR.ProcResourceId  = RP.ProcResourceId ' +
        ' Left  Join tblparts               AS PTDP   ON PTD.PartsId        = PTDP.PARTSID ' +
        ' Left  Join tblunitsofmeasure      AS UOM    ON PTD.TreePartUOMID  = UOM.UnitID ' +
        ' Left  Join tblparts               AS UOMP   ON UOM.PartID         = UOMP.PARTSID ' +
        ' Where PT.masterID in (' +    PartIDs +') /*and PTD.ParentId<>0 */ ' +
        ' order by PT.masterID, Sequencedown, ProcessStepSeq ' ;
end;

function TProductTreeToImport.AddSubItems: Boolean;
var
   xParentID:Integer;
   xInstance:TProductTreeToImport;
   Qry :TDataSet;
begin
  Result := True;
  
  if PreviousProcTreeId = ProcTreeId then exit;
  PreviousProcTreeId := ProcTreeId; {to avoid adding sub items when the root has multiple process}


   if (TreePartsID<> 0) and not(hasChildren) then begin
      Qry := getNewDataset(ExportProductTreeSQL(IntToStr(TreePartsID) , MaxProcTreeId , Level , PartsId , PartName));
      try
        with Qry do begin
          if recordcount > 1 then begin // atleast one sub item- it should never be 1 , shoudl be either 0 or morethan 1
            First;
            xInstance:=TProductTreeToImport.create(Self , fsTempTablename);
            try
              xInstance.connection := Self.Connection;
              xInstance.Load(0);
              xParentID :=0;
              While Eof = False do begin
                if Fieldbyname('ParentId').asInteger = 0 then
                  xParentID :=Fieldbyname('ProcTreeID').asInteger // should be only 1 record and should be replaced with the branch in the tree
                else begin
                  xInstance.New;
                  SetObjectPropertiesFromDataSet(xInstance, qry);
                  if Fieldbyname('ParentId').asInteger = xParentID then
                    xInstance.ParentId := Self.ProctreeID
                  else xInstance.ParentId := fieldbyname('ParentID').asInteger;
                  xInstance.MasterId := Self.MasterId;
                  xInstance.PostDB;
                end;
                Next;
              end;
            finally
              Freeandnil(xInstance);
            end;
          end;
        end;
      finally
          if Qry.active then Qry.close;
          FreeandNil(Qry);
      end;
   end;
end;

function TProductTreeToImport.DoImport: Boolean;
var
  ProductProcTree:TProductProcTree;
begin
  REsult := TRue;
  CloseDB;
  openDB;
  ProductProcTree:=TProductProcTree.create(Self);
  try
    ProductProcTree.Load(GetTreeRootID(PartsID));
    connection.BeginTransaction;
    try
      ProductProcTree.Storer.Connection := TERPConnection(Self.connection.connection);
      ProductProcTree.Delete;
      ProductProcTree.children.clear;
      ProductProcTree.ProcessStepList.Clear(true);
      ProductProcTree.ProcessStepList:= nil; { .. so it will be reloaded when it is created }
      First;
      AddLine(ProductProcTree , ParentID ,  Self.Connection, Self);
      ProductProcTree.CalcPrice;
      if ProductProcTree.SaveNoCheck then
        connection.CommitTransaction
      else begin
        connection.RollbackTransaction;
        Result := False;
      end;
    Except
      Result := false;
      Connection.RollbackTransaction;
    end;


  finally
      FreeandNil(ProductProcTree);
  end;
end;



procedure TProductTreeToImport.AddLine(ProductProcTree:TProductProcTree; const fParentID:Integer; Conn :TMyDacDataConnection; AOwner:TProductTreeToImport );
var
  obj:TProductProcTree;
  TreeObj:TProductTreeToImport;
begin
      TreeObj := TProductTreeToImport.create(Self, fsTemptablename);
      TreeObj.Connection := Self.Connection;
      TreeObj.LoadSelect('PArentId = ' +IntToStr(fParentID)+' and masterId = ' +IntToStr(masterID));

  if TreeObj.count = 0 then exit;

  TreeObj.First;
  While TreeObj.Eof = False do begin
      if fparentID <> 0 then begin
        obj:= TProductProcTree(ProductProcTree.MakeInstance);
        ProductProcTree.Children.Add(obj);
      end else begin
        obj :=ProductProcTree;
      end;
      obj.SequenceDown          := TreeObj.SequenceDown;
      obj.SequenceUp            := TreeObj.SequenceUp;
      obj.EditVersion           := 0;
      obj.Level                 := TreeObj.Level;
      obj.MasterId              := TreeObj.PartsID;
      obj.MasterType            := mtProduct;
      obj.Caption               := TreeObj.Caption;
      if TreeObj.Description <> '' then obj.Description           := TreeObj.Description else {will take the product's defualt};
      obj.Comments              := TreeObj.Comments ;
      obj.Details               := TreeObj.Details;
      obj.Info                  := TreeObj.info;
      obj.PartsId               := TreeObj.TreePartsID;
      obj.TreePartUOM           := TreeObj.UOM;
      obj.TreePartUOMID         := TreeObj.UOMID;
      obj.TreePartUOMMultiplier := TreeObj.Multiplier;
      obj.TreePartUOMQuantity   := TreeObj.TreePartUOMQuantity;
      obj.IsTemplate            := True;
      obj.InputType             := StrtoImputType(TreeObj.InputType);
      obj.HideOnPrint           := TreeObj.HideOnPrint;
      obj.AddToSale             := TreeObj.AddToSale;
      if TreeObj.Price <> 0 then obj.Price                 := TreeObj.Price;
      if TreeObj.Cost  <> 0 then  obj.Cost                  := TreeObj.Cost;
      obj.Selected              := TreeObj.Selected;
      (*obj.Value                 := TreeObj.Value;*)
      obj.Complete              := TreeObj.Complete;
      AddLine(obj,TreeObj.ProcTreeId ,conn, AOwner );
      AddProcesses(obj , TreeObj.ProcTreeId , TreeObj);
  end;
end;

procedure TProductTreeToImport.AddProcesses(ProductProcTree:TProductProcTree;fiProcTreeID:Integer; TreeObj:TProductTreeToImport);
var
  PP: TProcessPartNDS;
begin
  While (TreeObj.Eof = False) and (TreeObj.ProcTreeId = fiProcTreeID) do begin
    if TreeObj.ProcessStepSeq <> 0 then begin
      pp:= ProductProcTree.ProcessStepList.AddProcessPart;
      pp.PartId           := TreeObj.ProcessPartPartID;
      pp.ProcessStepSeq   := TreeObj.ProcessStepSeq;
      pp.ProcTreeId       := ProductProcTree.ID;
      pp.IsTemplate       := True;
      pp.Duration         := TreeObj.Duration;
      pp.SetupDuration    := TreeObj.SetupDuration;
      pp.BreakdownDuration:= TreeObj.BreakdownDuration;
      pp.ProcessStepId    := TreeObj.ProcessStepID;
    end;
    TreeObj.Next;
  end;
end;

function TProductTreeToImport.StrtoImputType(  const Value: String): TNodeInputType;
begin
       if Sysutils.SameText('itNone' , Value) then result := itNone
  else if Sysutils.SameText('itUser' , Value) then result := itUser
  else if Sysutils.SameText('itOption' , Value) then result := itOption
  else if Sysutils.SameText('itCustom' , Value) then result := itCustom
  else result := itNone;

end;

function TProductTreeToImport.hasChildren: Boolean;
begin
    With GetNewDataSet('Select * from ' +fsTempTablename +' where MasterId = ' + IntToStr(MasterID) +' and ifnull(ParentID,0) = ' + IntToStr(ProcTreeID)) do try
        Result := Recordcount >0;
    finally
        if active then close;
        Free;
    end;
end;

function TProductTreeToImport.MaxProcTreeId: Integer;
begin
    With GetNewDataSet('Select Max(ProcTreeID) MaxID from ' +fsTempTablename ) do try
        Result := Fieldbyname('MaxID').asInteger;
    finally
        if active then close;
        Free;
    end;

end;

procedure TProductTreeToImport.AddIfMissing(const Value: String);
var
  ctr:Integer;
begin
  if InvalidItems.count > 0 then
    for ctr := 0 to InvalidItems.count-1 do begin
        if InvalidItems[ctr] = Value then exit;
    end;
  InvalidItems.add(Value);

end;

initialization
  RegisterClass(TProductTreeToImport);


end.
