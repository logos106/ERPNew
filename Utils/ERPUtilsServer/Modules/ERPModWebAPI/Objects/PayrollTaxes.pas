unit PayrollTaxes;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tpayrolltaxes_vs1 = class(TMSBusObj)
  private
    function GetTaxDeclarationStatus                           : Boolean   ;
    function GetTaxDeclarationTaxFileNumber                    : string    ;
    function GetTaxDeclarationTfnExemption                     : string    ;
    function GetTaxDeclarationEmploymentBasis                  : string    ;
    function GetTaxDeclarationResidencyStatus                  : string    ;
    function GetTaxDeclarationTaxFreeThresholdClaimed          : Boolean   ;
    function GetTaxDeclarationOtherTaxOffsetClaimed            : Boolean   ;
    function GetTaxDeclarationStudyTrainingSupportLoans        : Boolean   ;
    function GetTaxDeclarationUpwardVariationRequested         : Boolean   ;
    function GetTaxDeclarationEligibleToReceiveLeaveLoading    : Boolean   ;
    procedure SetTaxDeclarationStatus                           (const Value: Boolean   );
    procedure SetTaxDeclarationTaxFileNumber                    (const Value: string    );
    procedure SetTaxDeclarationTfnExemption                     (const Value: string    );
    procedure SetTaxDeclarationEmploymentBasis                  (const Value: string    );
    procedure SetTaxDeclarationResidencyStatus                  (const Value: string    );
    procedure SetTaxDeclarationTaxFreeThresholdClaimed          (const Value: Boolean   );
    procedure SetTaxDeclarationOtherTaxOffsetClaimed            (const Value: Boolean   );
    procedure SetTaxDeclarationStudyTrainingSupportLoans        (const Value: Boolean   );
    procedure SetTaxDeclarationUpwardVariationRequested         (const Value: Boolean   );
    procedure SetTaxDeclarationEligibleToReceiveLeaveLoading    (const Value: Boolean   );
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
  published
    property TaxDeclarationStatus                            :Boolean     read GetTaxDeclarationStatus                          write SetTaxDeclarationStatus                       ;
    property TaxDeclarationTaxFileNumber                     :string      read GetTaxDeclarationTaxFileNumber                   write SetTaxDeclarationTaxFileNumber                ;
    property TaxDeclarationTfnExemption                      :string      read GetTaxDeclarationTfnExemption                    write SetTaxDeclarationTfnExemption                 ;
    property TaxDeclarationEmploymentBasis                   :string      read GetTaxDeclarationEmploymentBasis                 write SetTaxDeclarationEmploymentBasis              ;
    property TaxDeclarationResidencyStatus                   :string      read GetTaxDeclarationResidencyStatus                 write SetTaxDeclarationResidencyStatus              ;
    property TaxDeclarationTaxFreeThresholdClaimed           :Boolean     read GetTaxDeclarationTaxFreeThresholdClaimed         write SetTaxDeclarationTaxFreeThresholdClaimed      ;
    property TaxDeclarationOtherTaxOffsetClaimed             :Boolean     read GetTaxDeclarationOtherTaxOffsetClaimed           write SetTaxDeclarationOtherTaxOffsetClaimed        ;
    property TaxDeclarationStudyTrainingSupportLoans         :Boolean     read GetTaxDeclarationStudyTrainingSupportLoans       write SetTaxDeclarationStudyTrainingSupportLoans    ;
    property TaxDeclarationUpwardVariationRequested          :Boolean     read GetTaxDeclarationUpwardVariationRequested        write SetTaxDeclarationUpwardVariationRequested     ;
    property TaxDeclarationEligibleToReceiveLeaveLoading     :Boolean     read GetTaxDeclarationEligibleToReceiveLeaveLoading   write SetTaxDeclarationEligibleToReceiveLeaveLoading;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tpayrolltaxes_vs1}

constructor Tpayrolltaxes_vs1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'payrolltaxes_vs1';
  fSQL := 'SELECT * FROM tblpayrolltaxes_vs1';
end;


destructor Tpayrolltaxes_vs1.Destroy;
begin
  inherited;
end;


procedure Tpayrolltaxes_vs1.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetBooleanPropertyFromNode(node,'TaxDeclarationStatus');
  SetPropertyFromNode(node,'TaxDeclarationTaxFileNumber');
  SetPropertyFromNode(node,'TaxDeclarationTfnExemption');
  SetPropertyFromNode(node,'TaxDeclarationEmploymentBasis');
  SetPropertyFromNode(node,'TaxDeclarationResidencyStatus');
  SetBooleanPropertyFromNode(node,'TaxDeclarationTaxFreeThresholdClaimed');
  SetBooleanPropertyFromNode(node,'TaxDeclarationOtherTaxOffsetClaimed');
  SetBooleanPropertyFromNode(node,'TaxDeclarationStudyTrainingSupportLoans');
  SetBooleanPropertyFromNode(node,'TaxDeclarationUpwardVariationRequested');
  SetBooleanPropertyFromNode(node,'TaxDeclarationEligibleToReceiveLeaveLoading');
end;


procedure Tpayrolltaxes_vs1.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TaxDeclarationStatus' ,TaxDeclarationStatus);
  AddXMLNode(node,'TaxDeclarationTaxFileNumber' ,TaxDeclarationTaxFileNumber);
  AddXMLNode(node,'TaxDeclarationTfnExemption' ,TaxDeclarationTfnExemption);
  AddXMLNode(node,'TaxDeclarationEmploymentBasis' ,TaxDeclarationEmploymentBasis);
  AddXMLNode(node,'TaxDeclarationResidencyStatus' ,TaxDeclarationResidencyStatus);
  AddXMLNode(node,'TaxDeclarationTaxFreeThresholdClaimed' ,TaxDeclarationTaxFreeThresholdClaimed);
  AddXMLNode(node,'TaxDeclarationOtherTaxOffsetClaimed' ,TaxDeclarationOtherTaxOffsetClaimed);
  AddXMLNode(node,'TaxDeclarationStudyTrainingSupportLoans' ,TaxDeclarationStudyTrainingSupportLoans);
  AddXMLNode(node,'TaxDeclarationUpwardVariationRequested' ,TaxDeclarationUpwardVariationRequested);
  AddXMLNode(node,'TaxDeclarationEligibleToReceiveLeaveLoading' ,TaxDeclarationEligibleToReceiveLeaveLoading);
end;


function Tpayrolltaxes_vs1.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tpayrolltaxes_vs1.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tpayrolltaxes_vs1.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tpayrolltaxes_vs1.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tpayrolltaxes_vs1.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tpayrolltaxes_vs1.GetIDField: string;
begin
  Result := 'PayrollTaxesID'
end;


class function Tpayrolltaxes_vs1.GetBusObjectTablename: string;
begin
  Result:= 'tblpayrolltaxes_vs1';
end;


function Tpayrolltaxes_vs1.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tpayrolltaxes_vs1.GetTaxDeclarationStatus                       : Boolean   ; begin Result := GetBooleanField('TaxDeclarationStatus');end;
function  Tpayrolltaxes_vs1.GetTaxDeclarationTaxFileNumber                : string    ; begin Result := GetStringField('TaxDeclarationTaxFileNumber');end;
function  Tpayrolltaxes_vs1.GetTaxDeclarationTfnExemption                 : string    ; begin Result := GetStringField('TaxDeclarationTfnExemption');end;
function  Tpayrolltaxes_vs1.GetTaxDeclarationEmploymentBasis              : string    ; begin Result := GetStringField('TaxDeclarationEmploymentBasis');end;
function  Tpayrolltaxes_vs1.GetTaxDeclarationResidencyStatus              : string    ; begin Result := GetStringField('TaxDeclarationResidencyStatus');end;
function  Tpayrolltaxes_vs1.GetTaxDeclarationTaxFreeThresholdClaimed      : Boolean   ; begin Result := GetBooleanField('TaxDeclarationTaxFreeThresholdClaimed');end;
function  Tpayrolltaxes_vs1.GetTaxDeclarationOtherTaxOffsetClaimed        : Boolean   ; begin Result := GetBooleanField('TaxDeclarationOtherTaxOffsetClaimed');end;
function  Tpayrolltaxes_vs1.GetTaxDeclarationStudyTrainingSupportLoans    : Boolean   ; begin Result := GetBooleanField('TaxDeclarationStudyTrainingSupportLoans');end;
function  Tpayrolltaxes_vs1.GetTaxDeclarationUpwardVariationRequested     : Boolean   ; begin Result := GetBooleanField('TaxDeclarationUpwardVariationRequested');end;
function  Tpayrolltaxes_vs1.GetTaxDeclarationEligibleToReceiveLeaveLoading: Boolean   ; begin Result := GetBooleanField('TaxDeclarationEligibleToReceiveLeaveLoading');end;
procedure Tpayrolltaxes_vs1.SetTaxDeclarationStatus                       (const Value: Boolean   ); begin SetBooleanField('TaxDeclarationStatus'                        , Value);end;
procedure Tpayrolltaxes_vs1.SetTaxDeclarationTaxFileNumber                (const Value: string    ); begin SetStringField('TaxDeclarationTaxFileNumber'                 , Value);end;
procedure Tpayrolltaxes_vs1.SetTaxDeclarationTfnExemption                 (const Value: string    ); begin SetStringField('TaxDeclarationTfnExemption'                  , Value);end;
procedure Tpayrolltaxes_vs1.SetTaxDeclarationEmploymentBasis              (const Value: string    ); begin SetStringField('TaxDeclarationEmploymentBasis'               , Value);end;
procedure Tpayrolltaxes_vs1.SetTaxDeclarationResidencyStatus              (const Value: string    ); begin SetStringField('TaxDeclarationResidencyStatus'               , Value);end;
procedure Tpayrolltaxes_vs1.SetTaxDeclarationTaxFreeThresholdClaimed      (const Value: Boolean   ); begin SetBooleanField('TaxDeclarationTaxFreeThresholdClaimed'       , Value);end;
procedure Tpayrolltaxes_vs1.SetTaxDeclarationOtherTaxOffsetClaimed        (const Value: Boolean   ); begin SetBooleanField('TaxDeclarationOtherTaxOffsetClaimed'         , Value);end;
procedure Tpayrolltaxes_vs1.SetTaxDeclarationStudyTrainingSupportLoans    (const Value: Boolean   ); begin SetBooleanField('TaxDeclarationStudyTrainingSupportLoans'     , Value);end;
procedure Tpayrolltaxes_vs1.SetTaxDeclarationUpwardVariationRequested     (const Value: Boolean   ); begin SetBooleanField('TaxDeclarationUpwardVariationRequested'      , Value);end;
procedure Tpayrolltaxes_vs1.SetTaxDeclarationEligibleToReceiveLeaveLoading(const Value: Boolean   ); begin SetBooleanField('TaxDeclarationEligibleToReceiveLeaveLoading' , Value);end;


initialization
  RegisterClass(Tpayrolltaxes_vs1);


end.
