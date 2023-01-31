unit LumpSumW;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tlumpsumw = class(TMSBusObj)
  private
    function GetLumpSumWName                                 : string    ;
    function GetLumpSumWDisplayName                          : string    ;
    function GetLumpSumWRateType                             : string    ;
    function GetLumpSumWExpenseAccount                       : string    ;
    function GetLumpSumWExemptPaygWithholding                : Boolean   ;
    function GetLumpSumWExemptSuperannuationGuaranteeCont    : Boolean   ;
    function GetLumpSumWReportableW1onActivityStatement      : Boolean   ;
    function GetLumpSumWActive                               : Boolean   ;
    procedure SetLumpSumWName                                 (const Value: string    );
    procedure SetLumpSumWDisplayName                          (const Value: string    );
    procedure SetLumpSumWRateType                             (const Value: string    );
    procedure SetLumpSumWExpenseAccount                       (const Value: string    );
    procedure SetLumpSumWExemptPaygWithholding                (const Value: Boolean   );
    procedure SetLumpSumWExemptSuperannuationGuaranteeCont    (const Value: Boolean   );
    procedure SetLumpSumWReportableW1onActivityStatement      (const Value: Boolean   );
    procedure SetLumpSumWActive                               (const Value: Boolean   );
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
    property LumpSumWName                                  :string      read GetLumpSumWName                                write SetLumpSumWName                             ;
    property LumpSumWDisplayName                           :string      read GetLumpSumWDisplayName                         write SetLumpSumWDisplayName                      ;
    property LumpSumWRateType                              :string      read GetLumpSumWRateType                            write SetLumpSumWRateType                         ;
    property LumpSumWExpenseAccount                        :string      read GetLumpSumWExpenseAccount                      write SetLumpSumWExpenseAccount                   ;
    property LumpSumWExemptPaygWithholding                 :Boolean     read GetLumpSumWExemptPaygWithholding               write SetLumpSumWExemptPaygWithholding            ;
    property LumpSumWExemptSuperannuationGuaranteeCont     :Boolean     read GetLumpSumWExemptSuperannuationGuaranteeCont   write SetLumpSumWExemptSuperannuationGuaranteeCont;
    property LumpSumWReportableW1onActivityStatement       :Boolean     read GetLumpSumWReportableW1onActivityStatement     write SetLumpSumWReportableW1onActivityStatement  ;
    property LumpSumWActive                                :Boolean     read GetLumpSumWActive                              write SetLumpSumWActive                           ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tlumpsumw}

constructor Tlumpsumw.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'lumpsumw';
  fSQL := 'SELECT * FROM tbllumpsumw';
end;


destructor Tlumpsumw.Destroy;
begin
  inherited;
end;


procedure Tlumpsumw.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'LumpSumWName');
  SetPropertyFromNode(node,'LumpSumWDisplayName');
  SetPropertyFromNode(node,'LumpSumWRateType');
  SetPropertyFromNode(node,'LumpSumWExpenseAccount');
  SetBooleanPropertyFromNode(node,'LumpSumWExemptPaygWithholding');
  SetBooleanPropertyFromNode(node,'LumpSumWExemptSuperannuationGuaranteeCont');
  SetBooleanPropertyFromNode(node,'LumpSumWReportableW1onActivityStatement');
  SetBooleanPropertyFromNode(node,'LumpSumWActive');
end;


procedure Tlumpsumw.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'LumpSumWName' ,LumpSumWName);
  AddXMLNode(node,'LumpSumWDisplayName' ,LumpSumWDisplayName);
  AddXMLNode(node,'LumpSumWRateType' ,LumpSumWRateType);
  AddXMLNode(node,'LumpSumWExpenseAccount' ,LumpSumWExpenseAccount);
  AddXMLNode(node,'LumpSumWExemptPaygWithholding' ,LumpSumWExemptPaygWithholding);
  AddXMLNode(node,'LumpSumWExemptSuperannuationGuaranteeCont' ,LumpSumWExemptSuperannuationGuaranteeCont);
  AddXMLNode(node,'LumpSumWReportableW1onActivityStatement' ,LumpSumWReportableW1onActivityStatement);
  AddXMLNode(node,'LumpSumWActive' ,LumpSumWActive);
end;


function Tlumpsumw.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tlumpsumw.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tlumpsumw.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tlumpsumw.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tlumpsumw.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tlumpsumw.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tlumpsumw.GetBusObjectTablename: string;
begin
  Result:= 'tbllumpsumw';
end;


function Tlumpsumw.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tlumpsumw.GetLumpSumWName                             : string    ; begin Result := GetStringField('LumpSumWName');end;
function  Tlumpsumw.GetLumpSumWDisplayName                      : string    ; begin Result := GetStringField('LumpSumWDisplayName');end;
function  Tlumpsumw.GetLumpSumWRateType                         : string    ; begin Result := GetStringField('LumpSumWRateType');end;
function  Tlumpsumw.GetLumpSumWExpenseAccount                   : string    ; begin Result := GetStringField('LumpSumWExpenseAccount');end;
function  Tlumpsumw.GetLumpSumWExemptPaygWithholding            : Boolean   ; begin Result := GetBooleanField('LumpSumWExemptPaygWithholding');end;
function  Tlumpsumw.GetLumpSumWExemptSuperannuationGuaranteeCont: Boolean   ; begin Result := GetBooleanField('LumpSumWExemptSuperannuationGuaranteeCont');end;
function  Tlumpsumw.GetLumpSumWReportableW1onActivityStatement  : Boolean   ; begin Result := GetBooleanField('LumpSumWReportableW1onActivityStatement');end;
function  Tlumpsumw.GetLumpSumWActive                           : Boolean   ; begin Result := GetBooleanField('LumpSumWActive');end;
procedure Tlumpsumw.SetLumpSumWName                             (const Value: string    ); begin SetStringField('LumpSumWName'                              , Value);end;
procedure Tlumpsumw.SetLumpSumWDisplayName                      (const Value: string    ); begin SetStringField('LumpSumWDisplayName'                       , Value);end;
procedure Tlumpsumw.SetLumpSumWRateType                         (const Value: string    ); begin SetStringField('LumpSumWRateType'                          , Value);end;
procedure Tlumpsumw.SetLumpSumWExpenseAccount                   (const Value: string    ); begin SetStringField('LumpSumWExpenseAccount'                    , Value);end;
procedure Tlumpsumw.SetLumpSumWExemptPaygWithholding            (const Value: Boolean   ); begin SetBooleanField('LumpSumWExemptPaygWithholding'             , Value);end;
procedure Tlumpsumw.SetLumpSumWExemptSuperannuationGuaranteeCont(const Value: Boolean   ); begin SetBooleanField('LumpSumWExemptSuperannuationGuaranteeCont' , Value);end;
procedure Tlumpsumw.SetLumpSumWReportableW1onActivityStatement  (const Value: Boolean   ); begin SetBooleanField('LumpSumWReportableW1onActivityStatement'   , Value);end;
procedure Tlumpsumw.SetLumpSumWActive                           (const Value: Boolean   ); begin SetBooleanField('LumpSumWActive'                            , Value);end;


initialization
  RegisterClass(Tlumpsumw);


end.
