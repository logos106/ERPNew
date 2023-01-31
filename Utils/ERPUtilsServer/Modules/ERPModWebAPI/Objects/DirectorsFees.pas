unit DirectorsFees;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tdirectorsfees = class(TMSBusObj)
  private
    function GetDirectorsFeesName                                 : string    ;
    function GetDirectorsFeesDisplayName                          : string    ;
    function GetDirectorsFeesRateType                             : string    ;
    function GetDirectorsFeesExpenseAccount                       : string    ;
    function GetDirectorsFeesExemptPaygWithholding                : Boolean   ;
    function GetDirectorsFeesExemptSuperannuationGuaranteeCont    : Boolean   ;
    function GetDirectorsFeesReportableW1onActivityStatement      : Boolean   ;
    function GetDirectorsFeesActive                               : Boolean   ;
    procedure SetDirectorsFeesName                                 (const Value: string    );
    procedure SetDirectorsFeesDisplayName                          (const Value: string    );
    procedure SetDirectorsFeesRateType                             (const Value: string    );
    procedure SetDirectorsFeesExpenseAccount                       (const Value: string    );
    procedure SetDirectorsFeesExemptPaygWithholding                (const Value: Boolean   );
    procedure SetDirectorsFeesExemptSuperannuationGuaranteeCont    (const Value: Boolean   );
    procedure SetDirectorsFeesReportableW1onActivityStatement      (const Value: Boolean   );
    procedure SetDirectorsFeesActive                               (const Value: Boolean   );
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
    property DirectorsFeesName                                  :string      read GetDirectorsFeesName                                write SetDirectorsFeesName                             ;
    property DirectorsFeesDisplayName                           :string      read GetDirectorsFeesDisplayName                         write SetDirectorsFeesDisplayName                      ;
    property DirectorsFeesRateType                              :string      read GetDirectorsFeesRateType                            write SetDirectorsFeesRateType                         ;
    property DirectorsFeesExpenseAccount                        :string      read GetDirectorsFeesExpenseAccount                      write SetDirectorsFeesExpenseAccount                   ;
    property DirectorsFeesExemptPaygWithholding                 :Boolean     read GetDirectorsFeesExemptPaygWithholding               write SetDirectorsFeesExemptPaygWithholding            ;
    property DirectorsFeesExemptSuperannuationGuaranteeCont     :Boolean     read GetDirectorsFeesExemptSuperannuationGuaranteeCont   write SetDirectorsFeesExemptSuperannuationGuaranteeCont;
    property DirectorsFeesReportableW1onActivityStatement       :Boolean     read GetDirectorsFeesReportableW1onActivityStatement     write SetDirectorsFeesReportableW1onActivityStatement  ;
    property DirectorsFeesActive                                :Boolean     read GetDirectorsFeesActive                              write SetDirectorsFeesActive                           ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tdirectorsfees}

constructor Tdirectorsfees.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'directorsfees';
  fSQL := 'SELECT * FROM tbldirectorsfees';
end;


destructor Tdirectorsfees.Destroy;
begin
  inherited;
end;


procedure Tdirectorsfees.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DirectorsFeesName');
  SetPropertyFromNode(node,'DirectorsFeesDisplayName');
  SetPropertyFromNode(node,'DirectorsFeesRateType');
  SetPropertyFromNode(node,'DirectorsFeesExpenseAccount');
  SetBooleanPropertyFromNode(node,'DirectorsFeesExemptPaygWithholding');
  SetBooleanPropertyFromNode(node,'DirectorsFeesExemptSuperannuationGuaranteeCont');
  SetBooleanPropertyFromNode(node,'DirectorsFeesReportableW1onActivityStatement');
  SetBooleanPropertyFromNode(node,'DirectorsFeesActive');
end;


procedure Tdirectorsfees.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DirectorsFeesName' ,DirectorsFeesName);
  AddXMLNode(node,'DirectorsFeesDisplayName' ,DirectorsFeesDisplayName);
  AddXMLNode(node,'DirectorsFeesRateType' ,DirectorsFeesRateType);
  AddXMLNode(node,'DirectorsFeesExpenseAccount' ,DirectorsFeesExpenseAccount);
  AddXMLNode(node,'DirectorsFeesExemptPaygWithholding' ,DirectorsFeesExemptPaygWithholding);
  AddXMLNode(node,'DirectorsFeesExemptSuperannuationGuaranteeCont' ,DirectorsFeesExemptSuperannuationGuaranteeCont);
  AddXMLNode(node,'DirectorsFeesReportableW1onActivityStatement' ,DirectorsFeesReportableW1onActivityStatement);
  AddXMLNode(node,'DirectorsFeesActive' ,DirectorsFeesActive);
end;


function Tdirectorsfees.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tdirectorsfees.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tdirectorsfees.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tdirectorsfees.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tdirectorsfees.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tdirectorsfees.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tdirectorsfees.GetBusObjectTablename: string;
begin
  Result:= 'tbldirectorsfees';
end;


function Tdirectorsfees.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tdirectorsfees.GetDirectorsFeesName                             : string    ; begin Result := GetStringField('DirectorsFeesName');end;
function  Tdirectorsfees.GetDirectorsFeesDisplayName                      : string    ; begin Result := GetStringField('DirectorsFeesDisplayName');end;
function  Tdirectorsfees.GetDirectorsFeesRateType                         : string    ; begin Result := GetStringField('DirectorsFeesRateType');end;
function  Tdirectorsfees.GetDirectorsFeesExpenseAccount                   : string    ; begin Result := GetStringField('DirectorsFeesExpenseAccount');end;
function  Tdirectorsfees.GetDirectorsFeesExemptPaygWithholding            : Boolean   ; begin Result := GetBooleanField('DirectorsFeesExemptPaygWithholding');end;
function  Tdirectorsfees.GetDirectorsFeesExemptSuperannuationGuaranteeCont: Boolean   ; begin Result := GetBooleanField('DirectorsFeesExemptSuperannuationGuaranteeCont');end;
function  Tdirectorsfees.GetDirectorsFeesReportableW1onActivityStatement  : Boolean   ; begin Result := GetBooleanField('DirectorsFeesReportableW1onActivityStatement');end;
function  Tdirectorsfees.GetDirectorsFeesActive                           : Boolean   ; begin Result := GetBooleanField('DirectorsFeesActive');end;
procedure Tdirectorsfees.SetDirectorsFeesName                             (const Value: string    ); begin SetStringField('DirectorsFeesName'                              , Value);end;
procedure Tdirectorsfees.SetDirectorsFeesDisplayName                      (const Value: string    ); begin SetStringField('DirectorsFeesDisplayName'                       , Value);end;
procedure Tdirectorsfees.SetDirectorsFeesRateType                         (const Value: string    ); begin SetStringField('DirectorsFeesRateType'                          , Value);end;
procedure Tdirectorsfees.SetDirectorsFeesExpenseAccount                   (const Value: string    ); begin SetStringField('DirectorsFeesExpenseAccount'                    , Value);end;
procedure Tdirectorsfees.SetDirectorsFeesExemptPaygWithholding            (const Value: Boolean   ); begin SetBooleanField('DirectorsFeesExemptPaygWithholding'             , Value);end;
procedure Tdirectorsfees.SetDirectorsFeesExemptSuperannuationGuaranteeCont(const Value: Boolean   ); begin SetBooleanField('DirectorsFeesExemptSuperannuationGuaranteeCont' , Value);end;
procedure Tdirectorsfees.SetDirectorsFeesReportableW1onActivityStatement  (const Value: Boolean   ); begin SetBooleanField('DirectorsFeesReportableW1onActivityStatement'   , Value);end;
procedure Tdirectorsfees.SetDirectorsFeesActive                           (const Value: Boolean   ); begin SetBooleanField('DirectorsFeesActive'                            , Value);end;


initialization
  RegisterClass(Tdirectorsfees);


end.
