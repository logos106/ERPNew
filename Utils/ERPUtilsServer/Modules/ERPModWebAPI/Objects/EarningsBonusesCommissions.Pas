unit EarningsBonusesCommissions;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tearningsbonusescommissions = class(TMSBusObj)
  private
    function GetEarningBonusesCommisionsName                                 : string    ;
    function GetEarningBonusesCommisionsDisplayName                          : string    ;
    function GetEarningBonusesCommisionsRateType                             : string    ;
    function GetEarningBonusesCommisionsExpenseAccount                       : string    ;
    function GetEarningBonusesCommisionsExemptPaygWithholding                : Boolean   ;
    function GetEarningBonusesCommisionsExemptSuperannuationGuaranteeCont    : Boolean   ;
    function GetEarningBonusesCommisionsReportableW1onActivityStatement      : Boolean   ;
    function GetEarningBonusesCommisionsActive                               : Boolean   ;
    procedure SetEarningBonusesCommisionsName                                 (const Value: string    );
    procedure SetEarningBonusesCommisionsDisplayName                          (const Value: string    );
    procedure SetEarningBonusesCommisionsRateType                             (const Value: string    );
    procedure SetEarningBonusesCommisionsExpenseAccount                       (const Value: string    );
    procedure SetEarningBonusesCommisionsExemptPaygWithholding                (const Value: Boolean   );
    procedure SetEarningBonusesCommisionsExemptSuperannuationGuaranteeCont    (const Value: Boolean   );
    procedure SetEarningBonusesCommisionsReportableW1onActivityStatement      (const Value: Boolean   );
    procedure SetEarningBonusesCommisionsActive                               (const Value: Boolean   );
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
    property EarningBonusesCommisionsName                                  :string      read GetEarningBonusesCommisionsName                                write SetEarningBonusesCommisionsName                             ;
    property EarningBonusesCommisionsDisplayName                           :string      read GetEarningBonusesCommisionsDisplayName                         write SetEarningBonusesCommisionsDisplayName                      ;
    property EarningBonusesCommisionsRateType                              :string      read GetEarningBonusesCommisionsRateType                            write SetEarningBonusesCommisionsRateType                         ;
    property EarningBonusesCommisionsExpenseAccount                        :string      read GetEarningBonusesCommisionsExpenseAccount                      write SetEarningBonusesCommisionsExpenseAccount                   ;
    property EarningBonusesCommisionsExemptPaygWithholding                 :Boolean     read GetEarningBonusesCommisionsExemptPaygWithholding               write SetEarningBonusesCommisionsExemptPaygWithholding            ;
    property EarningBonusesCommisionsExemptSuperannuationGuaranteeCont     :Boolean     read GetEarningBonusesCommisionsExemptSuperannuationGuaranteeCont   write SetEarningBonusesCommisionsExemptSuperannuationGuaranteeCont;
    property EarningBonusesCommisionsReportableW1onActivityStatement       :Boolean     read GetEarningBonusesCommisionsReportableW1onActivityStatement     write SetEarningBonusesCommisionsReportableW1onActivityStatement  ;
    property EarningBonusesCommisionsActive                                :Boolean     read GetEarningBonusesCommisionsActive                              write SetEarningBonusesCommisionsActive                           ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tearningsbonusescommissions}

constructor Tearningsbonusescommissions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'earningsbonusescommissions';
  fSQL := 'SELECT * FROM tblearningsbonusescommissions';
end;


destructor Tearningsbonusescommissions.Destroy;
begin
  inherited;
end;


procedure Tearningsbonusescommissions.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EarningBonusesCommisionsName');
  SetPropertyFromNode(node,'EarningBonusesCommisionsDisplayName');
  SetPropertyFromNode(node,'EarningBonusesCommisionsRateType');
  SetPropertyFromNode(node,'EarningBonusesCommisionsExpenseAccount');
  SetBooleanPropertyFromNode(node,'EarningBonusesCommisionsExemptPaygWithholding');
  SetBooleanPropertyFromNode(node,'EarningBonusesCommisionsExemptSuperannuationGuaranteeCont');
  SetBooleanPropertyFromNode(node,'EarningBonusesCommisionsReportableW1onActivityStatement');
  SetBooleanPropertyFromNode(node,'EarningBonusesCommisionsActive');
end;


procedure Tearningsbonusescommissions.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EarningBonusesCommisionsName' ,EarningBonusesCommisionsName);
  AddXMLNode(node,'EarningBonusesCommisionsDisplayName' ,EarningBonusesCommisionsDisplayName);
  AddXMLNode(node,'EarningBonusesCommisionsRateType' ,EarningBonusesCommisionsRateType);
  AddXMLNode(node,'EarningBonusesCommisionsExpenseAccount' ,EarningBonusesCommisionsExpenseAccount);
  AddXMLNode(node,'EarningBonusesCommisionsExemptPaygWithholding' ,EarningBonusesCommisionsExemptPaygWithholding);
  AddXMLNode(node,'EarningBonusesCommisionsExemptSuperannuationGuaranteeCont' ,EarningBonusesCommisionsExemptSuperannuationGuaranteeCont);
  AddXMLNode(node,'EarningBonusesCommisionsReportableW1onActivityStatement' ,EarningBonusesCommisionsReportableW1onActivityStatement);
  AddXMLNode(node,'EarningBonusesCommisionsActive' ,EarningBonusesCommisionsActive);
end;


function Tearningsbonusescommissions.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tearningsbonusescommissions.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tearningsbonusescommissions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tearningsbonusescommissions.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tearningsbonusescommissions.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tearningsbonusescommissions.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tearningsbonusescommissions.GetBusObjectTablename: string;
begin
  Result:= 'tblearningsbonusescommissions';
end;


function Tearningsbonusescommissions.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tearningsbonusescommissions.GetEarningBonusesCommisionsName                             : string    ; begin Result := GetStringField('EarningBonusesCommisionsName');end;
function  Tearningsbonusescommissions.GetEarningBonusesCommisionsDisplayName                      : string    ; begin Result := GetStringField('EarningBonusesCommisionsDisplayName');end;
function  Tearningsbonusescommissions.GetEarningBonusesCommisionsRateType                         : string    ; begin Result := GetStringField('EarningBonusesCommisionsRateType');end;
function  Tearningsbonusescommissions.GetEarningBonusesCommisionsExpenseAccount                   : string    ; begin Result := GetStringField('EarningBonusesCommisionsExpenseAccount');end;
function  Tearningsbonusescommissions.GetEarningBonusesCommisionsExemptPaygWithholding            : Boolean   ; begin Result := GetBooleanField('EarningBonusesCommisionsExemptPaygWithholding');end;
function  Tearningsbonusescommissions.GetEarningBonusesCommisionsExemptSuperannuationGuaranteeCont: Boolean   ; begin Result := GetBooleanField('EarningBonusesCommisionsExemptSuperannuationGuaranteeCont');end;
function  Tearningsbonusescommissions.GetEarningBonusesCommisionsReportableW1onActivityStatement  : Boolean   ; begin Result := GetBooleanField('EarningBonusesCommisionsReportableW1onActivityStatement');end;
function  Tearningsbonusescommissions.GetEarningBonusesCommisionsActive                           : Boolean   ; begin Result := GetBooleanField('EarningBonusesCommisionsActive');end;
procedure Tearningsbonusescommissions.SetEarningBonusesCommisionsName                             (const Value: string    ); begin SetStringField('EarningBonusesCommisionsName'                              , Value);end;
procedure Tearningsbonusescommissions.SetEarningBonusesCommisionsDisplayName                      (const Value: string    ); begin SetStringField('EarningBonusesCommisionsDisplayName'                       , Value);end;
procedure Tearningsbonusescommissions.SetEarningBonusesCommisionsRateType                         (const Value: string    ); begin SetStringField('EarningBonusesCommisionsRateType'                          , Value);end;
procedure Tearningsbonusescommissions.SetEarningBonusesCommisionsExpenseAccount                   (const Value: string    ); begin SetStringField('EarningBonusesCommisionsExpenseAccount'                    , Value);end;
procedure Tearningsbonusescommissions.SetEarningBonusesCommisionsExemptPaygWithholding            (const Value: Boolean   ); begin SetBooleanField('EarningBonusesCommisionsExemptPaygWithholding'             , Value);end;
procedure Tearningsbonusescommissions.SetEarningBonusesCommisionsExemptSuperannuationGuaranteeCont(const Value: Boolean   ); begin SetBooleanField('EarningBonusesCommisionsExemptSuperannuationGuaranteeCont' , Value);end;
procedure Tearningsbonusescommissions.SetEarningBonusesCommisionsReportableW1onActivityStatement  (const Value: Boolean   ); begin SetBooleanField('EarningBonusesCommisionsReportableW1onActivityStatement'   , Value);end;
procedure Tearningsbonusescommissions.SetEarningBonusesCommisionsActive                           (const Value: Boolean   ); begin SetBooleanField('EarningBonusesCommisionsActive'                            , Value);end;


initialization
  RegisterClass(Tearningsbonusescommissions);


end.
