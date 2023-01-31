unit LumpSumE;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tlumpsume = class(TMSBusObj)
  private
    function GetLumpSumEName                                 : string    ;
    function GetLumpSumEDisplayName                          : string    ;
    function GetLumpSumERateType                             : string    ;
    function GetLumpSumEExpenseAccount                       : string    ;
    function GetLumpSumEExemptPaygWithholding                : Boolean   ;
    function GetLumpSumEExemptSuperannuationGuaranteeCont    : Boolean   ;
    function GetLumpSumEReportableW1onActivityStatement      : Boolean   ;
    function GetLumpSumEActive                               : Boolean   ;
    procedure SetLumpSumEName                                 (const Value: string    );
    procedure SetLumpSumEDisplayName                          (const Value: string    );
    procedure SetLumpSumERateType                             (const Value: string    );
    procedure SetLumpSumEExpenseAccount                       (const Value: string    );
    procedure SetLumpSumEExemptPaygWithholding                (const Value: Boolean   );
    procedure SetLumpSumEExemptSuperannuationGuaranteeCont    (const Value: Boolean   );
    procedure SetLumpSumEReportableW1onActivityStatement      (const Value: Boolean   );
    procedure SetLumpSumEActive                               (const Value: Boolean   );
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
    function     Save: Boolean ;
                                            override;
  published
    property LumpSumEName                                  :string      read GetLumpSumEName                                write SetLumpSumEName                             ;
    property LumpSumEDisplayName                           :string      read GetLumpSumEDisplayName                         write SetLumpSumEDisplayName                      ;
    property LumpSumERateType                              :string      read GetLumpSumERateType                            write SetLumpSumERateType                         ;
    property LumpSumEExpenseAccount                        :string      read GetLumpSumEExpenseAccount                      write SetLumpSumEExpenseAccount                   ;
    property LumpSumEExemptPaygWithholding                 :Boolean     read GetLumpSumEExemptPaygWithholding               write SetLumpSumEExemptPaygWithholding            ;
    property LumpSumEExemptSuperannuationGuaranteeCont     :Boolean     read GetLumpSumEExemptSuperannuationGuaranteeCont   write SetLumpSumEExemptSuperannuationGuaranteeCont;
    property LumpSumEReportableW1onActivityStatement       :Boolean     read GetLumpSumEReportableW1onActivityStatement     write SetLumpSumEReportableW1onActivityStatement  ;
    property LumpSumEActive                                :Boolean     read GetLumpSumEActive                              write SetLumpSumEActive                           ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tlumpsume}

constructor Tlumpsume.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'lumpsume';
  fSQL := 'SELECT * FROM tbllumpsume';
end;


destructor Tlumpsume.Destroy;
begin
  inherited;
end;


procedure Tlumpsume.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'LumpSumEName');
  SetPropertyFromNode(node,'LumpSumEDisplayName');
  SetPropertyFromNode(node,'LumpSumERateType');
  SetPropertyFromNode(node,'LumpSumEExpenseAccount');
  SetBooleanPropertyFromNode(node,'LumpSumEExemptPaygWithholding');
  SetBooleanPropertyFromNode(node,'LumpSumEExemptSuperannuationGuaranteeCont');
  SetBooleanPropertyFromNode(node,'LumpSumEReportableW1onActivityStatement');
  SetBooleanPropertyFromNode(node,'LumpSumEActive');
end;


procedure Tlumpsume.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'LumpSumEName' ,LumpSumEName);
  AddXMLNode(node,'LumpSumEDisplayName' ,LumpSumEDisplayName);
  AddXMLNode(node,'LumpSumERateType' ,LumpSumERateType);
  AddXMLNode(node,'LumpSumEExpenseAccount' ,LumpSumEExpenseAccount);
  AddXMLNode(node,'LumpSumEExemptPaygWithholding' ,LumpSumEExemptPaygWithholding);
  AddXMLNode(node,'LumpSumEExemptSuperannuationGuaranteeCont' ,LumpSumEExemptSuperannuationGuaranteeCont);
  AddXMLNode(node,'LumpSumEReportableW1onActivityStatement' ,LumpSumEReportableW1onActivityStatement);
  AddXMLNode(node,'LumpSumEActive' ,LumpSumEActive);
end;


function Tlumpsume.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tlumpsume.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tlumpsume.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tlumpsume.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tlumpsume.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tlumpsume.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tlumpsume.GetBusObjectTablename: string;
begin
  Result:= 'tbllumpsume';
end;


function Tlumpsume.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tlumpsume.GetLumpSumEName                             : string    ; begin Result := GetStringField('LumpSumEName');end;
function  Tlumpsume.GetLumpSumEDisplayName                      : string    ; begin Result := GetStringField('LumpSumEDisplayName');end;
function  Tlumpsume.GetLumpSumERateType                         : string    ; begin Result := GetStringField('LumpSumERateType');end;
function  Tlumpsume.GetLumpSumEExpenseAccount                   : string    ; begin Result := GetStringField('LumpSumEExpenseAccount');end;
function  Tlumpsume.GetLumpSumEExemptPaygWithholding            : Boolean   ; begin Result := GetBooleanField('LumpSumEExemptPaygWithholding');end;
function  Tlumpsume.GetLumpSumEExemptSuperannuationGuaranteeCont: Boolean   ; begin Result := GetBooleanField('LumpSumEExemptSuperannuationGuaranteeCont');end;
function  Tlumpsume.GetLumpSumEReportableW1onActivityStatement  : Boolean   ; begin Result := GetBooleanField('LumpSumEReportableW1onActivityStatement');end;
function  Tlumpsume.GetLumpSumEActive                           : Boolean   ; begin Result := GetBooleanField('LumpSumEActive');end;
procedure Tlumpsume.SetLumpSumEName                             (const Value: string    ); begin SetStringField('LumpSumEName'                              , Value);end;
procedure Tlumpsume.SetLumpSumEDisplayName                      (const Value: string    ); begin SetStringField('LumpSumEDisplayName'                       , Value);end;
procedure Tlumpsume.SetLumpSumERateType                         (const Value: string    ); begin SetStringField('LumpSumERateType'                          , Value);end;
procedure Tlumpsume.SetLumpSumEExpenseAccount                   (const Value: string    ); begin SetStringField('LumpSumEExpenseAccount'                    , Value);end;
procedure Tlumpsume.SetLumpSumEExemptPaygWithholding            (const Value: Boolean   ); begin SetBooleanField('LumpSumEExemptPaygWithholding'             , Value);end;
procedure Tlumpsume.SetLumpSumEExemptSuperannuationGuaranteeCont(const Value: Boolean   ); begin SetBooleanField('LumpSumEExemptSuperannuationGuaranteeCont' , Value);end;
procedure Tlumpsume.SetLumpSumEReportableW1onActivityStatement  (const Value: Boolean   ); begin SetBooleanField('LumpSumEReportableW1onActivityStatement'   , Value);end;
procedure Tlumpsume.SetLumpSumEActive                           (const Value: Boolean   ); begin SetBooleanField('LumpSumEActive'                            , Value);end;


initialization
  RegisterClass(Tlumpsume);


end.
