unit OverTimeEarnings;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tovertimeearnings = class(TMSBusObj)
  private
    function GetOverTimeEarningsName                                     : string    ;
    function GetOverTimeEarningsDisplayName                              : string    ;
    function GetOverTimeEarningsRateType                                 : string    ;
    function GetOverTimeEarningsExpenseAccount                           : string    ;
    function GetOverTimeEarningsExemptPaygWithholding                    : Boolean   ;
    function GetOverTimeEarningsExemptSuperannuationGuaranteeCont        : Boolean   ;
    function GetOverTimeEarningsReportableW1onActivityStatement          : Boolean   ;
    function GetOverTimeEarningsActive                                   : Boolean   ;
    procedure SetOverTimeEarningsName                                     (const Value: string    );
    procedure SetOverTimeEarningsDisplayName                              (const Value: string    );
    procedure SetOverTimeEarningsRateType                                 (const Value: string    );
    procedure SetOverTimeEarningsExpenseAccount                           (const Value: string    );
    procedure SetOverTimeEarningsExemptPaygWithholding                    (const Value: Boolean   );
    procedure SetOverTimeEarningsExemptSuperannuationGuaranteeCont        (const Value: Boolean   );
    procedure SetOverTimeEarningsReportableW1onActivityStatement          (const Value: Boolean   );
    procedure SetOverTimeEarningsActive                                   (const Value: Boolean   );
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
    property OverTimeEarningsName                                      :string      read GetOverTimeEarningsName                                    write SetOverTimeEarningsName                                 ;
    property OverTimeEarningsDisplayName                               :string      read GetOverTimeEarningsDisplayName                             write SetOverTimeEarningsDisplayName                          ;
    property OverTimeEarningsRateType                                  :string      read GetOverTimeEarningsRateType                                write SetOverTimeEarningsRateType                             ;
    property OverTimeEarningsExpenseAccount                            :string      read GetOverTimeEarningsExpenseAccount                          write SetOverTimeEarningsExpenseAccount                       ;
    property OverTimeEarningsExemptPaygWithholding                     :Boolean     read GetOverTimeEarningsExemptPaygWithholding                   write SetOverTimeEarningsExemptPaygWithholding                ;
    property OverTimeEarningsExemptSuperannuationGuaranteeCont         :Boolean     read GetOverTimeEarningsExemptSuperannuationGuaranteeCont       write SetOverTimeEarningsExemptSuperannuationGuaranteeCont    ;
    property OverTimeEarningsReportableW1onActivityStatement           :Boolean     read GetOverTimeEarningsReportableW1onActivityStatement         write SetOverTimeEarningsReportableW1onActivityStatement      ;
    property OverTimeEarningsActive                                    :Boolean     read GetOverTimeEarningsActive                                  write SetOverTimeEarningsActive                               ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tovertimeearnings}

constructor Tovertimeearnings.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'overtimeearnings';
  fSQL := 'SELECT * FROM tblovertimeearnings';
end;


destructor Tovertimeearnings.Destroy;
begin
  inherited;
end;


procedure Tovertimeearnings.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OverTimeEarningsName');
  SetPropertyFromNode(node,'OverTimeEarningsDisplayName');
  SetPropertyFromNode(node,'OverTimeEarningsRateType');
  SetPropertyFromNode(node,'OverTimeEarningsExpenseAccount');
  SetBooleanPropertyFromNode(node,'OverTimeEarningsExemptPaygWithholding');
  SetBooleanPropertyFromNode(node,'OverTimeEarningsExemptSuperannuationGuaranteeCont');
  SetBooleanPropertyFromNode(node,'OverTimeEarningsReportableW1onActivityStatement');
  SetBooleanPropertyFromNode(node,'OverTimeEarningsActive');
end;


procedure Tovertimeearnings.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OverTimeEarningsName' ,OverTimeEarningsName);
  AddXMLNode(node,'OverTimeEarningsDisplayName' ,OverTimeEarningsDisplayName);
  AddXMLNode(node,'OverTimeEarningsRateType' ,OverTimeEarningsRateType);
  AddXMLNode(node,'OverTimeEarningsExpenseAccount' ,OverTimeEarningsExpenseAccount);
  AddXMLNode(node,'OverTimeEarningsExemptPaygWithholding' ,OverTimeEarningsExemptPaygWithholding);
  AddXMLNode(node,'OverTimeEarningsExemptSuperannuationGuaranteeCont' ,OverTimeEarningsExemptSuperannuationGuaranteeCont);
  AddXMLNode(node,'OverTimeEarningsReportableW1onActivityStatement' ,OverTimeEarningsReportableW1onActivityStatement);
  AddXMLNode(node,'OverTimeEarningsActive' ,OverTimeEarningsActive);
end;


function Tovertimeearnings.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tovertimeearnings.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tovertimeearnings.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tovertimeearnings.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tovertimeearnings.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tovertimeearnings.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tovertimeearnings.GetBusObjectTablename: string;
begin
  Result:= 'tblovertimeearnings';
end;


function Tovertimeearnings.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tovertimeearnings.GetOverTimeEarningsName                                 : string    ; begin Result := GetStringField('OverTimeEarningsName');end;
function  Tovertimeearnings.GetOverTimeEarningsDisplayName                          : string    ; begin Result := GetStringField('OverTimeEarningsDisplayName');end;
function  Tovertimeearnings.GetOverTimeEarningsRateType                             : string    ; begin Result := GetStringField('OverTimeEarningsRateType');end;
function  Tovertimeearnings.GetOverTimeEarningsExpenseAccount                       : string    ; begin Result := GetStringField('OverTimeEarningsExpenseAccount');end;
function  Tovertimeearnings.GetOverTimeEarningsExemptPaygWithholding                : Boolean   ; begin Result := GetBooleanField('OverTimeEarningsExemptPaygWithholding');end;
function  Tovertimeearnings.GetOverTimeEarningsExemptSuperannuationGuaranteeCont    : Boolean   ; begin Result := GetBooleanField('OverTimeEarningsExemptSuperannuationGuaranteeCont');end;
function  Tovertimeearnings.GetOverTimeEarningsReportableW1onActivityStatement      : Boolean   ; begin Result := GetBooleanField('OverTimeEarningsReportableW1onActivityStatement');end;
function  Tovertimeearnings.GetOverTimeEarningsActive                               : Boolean   ; begin Result := GetBooleanField('OverTimeEarningsActive');end;
procedure Tovertimeearnings.SetOverTimeEarningsName                                 (const Value: string    ); begin SetStringField('OverTimeEarningsName'                                  , Value);end;
procedure Tovertimeearnings.SetOverTimeEarningsDisplayName                          (const Value: string    ); begin SetStringField('OverTimeEarningsDisplayName'                           , Value);end;
procedure Tovertimeearnings.SetOverTimeEarningsRateType                             (const Value: string    ); begin SetStringField('OverTimeEarningsRateType'                              , Value);end;
procedure Tovertimeearnings.SetOverTimeEarningsExpenseAccount                       (const Value: string    ); begin SetStringField('OverTimeEarningsExpenseAccount'                        , Value);end;
procedure Tovertimeearnings.SetOverTimeEarningsExemptPaygWithholding                (const Value: Boolean   ); begin SetBooleanField('OverTimeEarningsExemptPaygWithholding'                 , Value);end;
procedure Tovertimeearnings.SetOverTimeEarningsExemptSuperannuationGuaranteeCont    (const Value: Boolean   ); begin SetBooleanField('OverTimeEarningsExemptSuperannuationGuaranteeCont'     , Value);end;
procedure Tovertimeearnings.SetOverTimeEarningsReportableW1onActivityStatement      (const Value: Boolean   ); begin SetBooleanField('OverTimeEarningsReportableW1onActivityStatement'       , Value);end;
procedure Tovertimeearnings.SetOverTimeEarningsActive                               (const Value: Boolean   ); begin SetBooleanField('OverTimeEarningsActive'                                , Value);end;


initialization
  RegisterClass(Tovertimeearnings);


end.
