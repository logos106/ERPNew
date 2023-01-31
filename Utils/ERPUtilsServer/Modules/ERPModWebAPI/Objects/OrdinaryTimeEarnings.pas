unit OrdinaryTimeEarnings;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tordinarytimeearnings = class(TMSBusObj)
  private
    function GetOrdinaryTimeEarningsName                                 : string    ;
    function GetOrdinaryTimeEarningsDisplayName                          : string    ;
    function GetOrdinaryTimeEarningsRateType                             : string    ;
    function GetOrdinaryTimeEarningsExpenseAccount                       : string    ;
    function GetOrdinaryTimeEarningsExemptPaygWithholding                : Boolean   ;
    function GetOrdinaryTimeEarningsExemptSuperannuationGuaranteeCont    : Boolean   ;
    function GetOrdinaryTimeEarningsReportableW1onActivityStatement      : Boolean   ;
    function GetOrdinaryTimeEarningsActive                               : Boolean   ;
    procedure SetOrdinaryTimeEarningsName                                 (const Value: string    );
    procedure SetOrdinaryTimeEarningsDisplayName                          (const Value: string    );
    procedure SetOrdinaryTimeEarningsRateType                             (const Value: string    );
    procedure SetOrdinaryTimeEarningsExpenseAccount                       (const Value: string    );
    procedure SetOrdinaryTimeEarningsExemptPaygWithholding                (const Value: Boolean   );
    procedure SetOrdinaryTimeEarningsExemptSuperannuationGuaranteeCont    (const Value: Boolean   );
    procedure SetOrdinaryTimeEarningsReportableW1onActivityStatement      (const Value: Boolean   );
    procedure SetOrdinaryTimeEarningsActive                               (const Value: Boolean   );
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
    property OrdinaryTimeEarningsName                                  :string      read GetOrdinaryTimeEarningsName                                write SetOrdinaryTimeEarningsName                             ;
    property OrdinaryTimeEarningsDisplayName                           :string      read GetOrdinaryTimeEarningsDisplayName                         write SetOrdinaryTimeEarningsDisplayName                      ;
    property OrdinaryTimeEarningsRateType                              :string      read GetOrdinaryTimeEarningsRateType                            write SetOrdinaryTimeEarningsRateType                         ;
    property OrdinaryTimeEarningsExpenseAccount                        :string      read GetOrdinaryTimeEarningsExpenseAccount                      write SetOrdinaryTimeEarningsExpenseAccount                   ;
    property OrdinaryTimeEarningsExemptPaygWithholding                 :Boolean     read GetOrdinaryTimeEarningsExemptPaygWithholding               write SetOrdinaryTimeEarningsExemptPaygWithholding            ;
    property OrdinaryTimeEarningsExemptSuperannuationGuaranteeCont     :Boolean     read GetOrdinaryTimeEarningsExemptSuperannuationGuaranteeCont   write SetOrdinaryTimeEarningsExemptSuperannuationGuaranteeCont;
    property OrdinaryTimeEarningsReportableW1onActivityStatement       :Boolean     read GetOrdinaryTimeEarningsReportableW1onActivityStatement     write SetOrdinaryTimeEarningsReportableW1onActivityStatement  ;
    property OrdinaryTimeEarningsActive                                :Boolean     read GetOrdinaryTimeEarningsActive                              write SetOrdinaryTimeEarningsActive                           ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tordinarytimeearnings}

constructor Tordinarytimeearnings.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ordinarytimeearnings';
  fSQL := 'SELECT * FROM tblordinarytimeearnings';
end;


destructor Tordinarytimeearnings.Destroy;
begin
  inherited;
end;


procedure Tordinarytimeearnings.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OrdinaryTimeEarningsName');
  SetPropertyFromNode(node,'OrdinaryTimeEarningsDisplayName');
  SetPropertyFromNode(node,'OrdinaryTimeEarningsRateType');
  SetPropertyFromNode(node,'OrdinaryTimeEarningsExpenseAccount');
  SetBooleanPropertyFromNode(node,'OrdinaryTimeEarningsExemptPaygWithholding');
  SetBooleanPropertyFromNode(node,'OrdinaryTimeEarningsExemptSuperannuationGuaranteeCont');
  SetBooleanPropertyFromNode(node,'OrdinaryTimeEarningsReportableW1onActivityStatement');
  SetBooleanPropertyFromNode(node,'OrdinaryTimeEarningsActive');
end;


procedure Tordinarytimeearnings.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OrdinaryTimeEarningsName' ,OrdinaryTimeEarningsName);
  AddXMLNode(node,'OrdinaryTimeEarningsDisplayName' ,OrdinaryTimeEarningsDisplayName);
  AddXMLNode(node,'OrdinaryTimeEarningsRateType' ,OrdinaryTimeEarningsRateType);
  AddXMLNode(node,'OrdinaryTimeEarningsExpenseAccount' ,OrdinaryTimeEarningsExpenseAccount);
  AddXMLNode(node,'OrdinaryTimeEarningsExemptPaygWithholding' ,OrdinaryTimeEarningsExemptPaygWithholding);
  AddXMLNode(node,'OrdinaryTimeEarningsExemptSuperannuationGuaranteeCont' ,OrdinaryTimeEarningsExemptSuperannuationGuaranteeCont);
  AddXMLNode(node,'OrdinaryTimeEarningsReportableW1onActivityStatement' ,OrdinaryTimeEarningsReportableW1onActivityStatement);
  AddXMLNode(node,'OrdinaryTimeEarningsActive' ,OrdinaryTimeEarningsActive);
end;


function Tordinarytimeearnings.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tordinarytimeearnings.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tordinarytimeearnings.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tordinarytimeearnings.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tordinarytimeearnings.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tordinarytimeearnings.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tordinarytimeearnings.GetBusObjectTablename: string;
begin
  Result:= 'tblordinarytimeearnings';
end;


function Tordinarytimeearnings.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tordinarytimeearnings.GetOrdinaryTimeEarningsName                             : string    ; begin Result := GetStringField('OrdinaryTimeEarningsName');end;
function  Tordinarytimeearnings.GetOrdinaryTimeEarningsDisplayName                      : string    ; begin Result := GetStringField('OrdinaryTimeEarningsDisplayName');end;
function  Tordinarytimeearnings.GetOrdinaryTimeEarningsRateType                         : string    ; begin Result := GetStringField('OrdinaryTimeEarningsRateType');end;
function  Tordinarytimeearnings.GetOrdinaryTimeEarningsExpenseAccount                   : string    ; begin Result := GetStringField('OrdinaryTimeEarningsExpenseAccount');end;
function  Tordinarytimeearnings.GetOrdinaryTimeEarningsExemptPaygWithholding            : Boolean   ; begin Result := GetBooleanField('OrdinaryTimeEarningsExemptPaygWithholding');end;
function  Tordinarytimeearnings.GetOrdinaryTimeEarningsExemptSuperannuationGuaranteeCont: Boolean   ; begin Result := GetBooleanField('OrdinaryTimeEarningsExemptSuperannuationGuaranteeCont');end;
function  Tordinarytimeearnings.GetOrdinaryTimeEarningsReportableW1onActivityStatement  : Boolean   ; begin Result := GetBooleanField('OrdinaryTimeEarningsReportableW1onActivityStatement');end;
function  Tordinarytimeearnings.GetOrdinaryTimeEarningsActive                           : Boolean   ; begin Result := GetBooleanField('OrdinaryTimeEarningsActive');end;
procedure Tordinarytimeearnings.SetOrdinaryTimeEarningsName                             (const Value: string    ); begin SetStringField('OrdinaryTimeEarningsName'                              , Value);end;
procedure Tordinarytimeearnings.SetOrdinaryTimeEarningsDisplayName                      (const Value: string    ); begin SetStringField('OrdinaryTimeEarningsDisplayName'                       , Value);end;
procedure Tordinarytimeearnings.SetOrdinaryTimeEarningsRateType                         (const Value: string    ); begin SetStringField('OrdinaryTimeEarningsRateType'                          , Value);end;
procedure Tordinarytimeearnings.SetOrdinaryTimeEarningsExpenseAccount                   (const Value: string    ); begin SetStringField('OrdinaryTimeEarningsExpenseAccount'                    , Value);end;
procedure Tordinarytimeearnings.SetOrdinaryTimeEarningsExemptPaygWithholding            (const Value: Boolean   ); begin SetBooleanField('OrdinaryTimeEarningsExemptPaygWithholding'             , Value);end;
procedure Tordinarytimeearnings.SetOrdinaryTimeEarningsExemptSuperannuationGuaranteeCont(const Value: Boolean   ); begin SetBooleanField('OrdinaryTimeEarningsExemptSuperannuationGuaranteeCont' , Value);end;
procedure Tordinarytimeearnings.SetOrdinaryTimeEarningsReportableW1onActivityStatement  (const Value: Boolean   ); begin SetBooleanField('OrdinaryTimeEarningsReportableW1onActivityStatement'   , Value);end;
procedure Tordinarytimeearnings.SetOrdinaryTimeEarningsActive                           (const Value: Boolean   ); begin SetBooleanField('OrdinaryTimeEarningsActive'                            , Value);end;


initialization
  RegisterClass(Tordinarytimeearnings);


end.
