unit BusObjFormW4;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  13/07/21  1.00.00  Binny  Initial Version.
  }


interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjPrintDoc;

type
  TFormW4 = class(TMSBusObj)
  private
    function GetEmployeeID              : Integer   ;
    function GetPayYear                 : Integer   ;
    function GetPayYearStart            : TDateTime ;
    function GetFirstName               : string    ;
    function GetLastName                : string    ;
    function GetSocialSecurityNumber    : string    ;
    function GetStreet1                 : string    ;
    function GetStreet2                 : string    ;
    function GetSuburb                  : string    ;
    function GetPostcode                : string    ;
    function GetState                   : string    ;
    function GetCountry                 : string    ;
    function GetTaxReportingtype        : string    ;
    function GetUseW4                   : Boolean   ;
    function GetHaveMultipleJobs        : Boolean   ;
    function GetChildrenUnder17         : Integer   ;
    function GetOtherDependent          : Integer   ;
    function GetDependent               : Integer   ;
    function GetOtherIncome             : Double    ;
    function GetDeductions              : Double    ;
    function GetExtraWithholding        : Double    ;
    function GetDeleted                 : Boolean   ;

    procedure SetEmployeeID              (const Value: Integer   );
    procedure SetPayYear                 (const Value: Integer   );
    procedure SetPayYearStart            (const Value: TDateTime );
    procedure SetFirstName               (const Value: string    );
    procedure SetLastName                (const Value: string    );
    procedure SetSocialSecurityNumber    (const Value: string    );
    procedure SetStreet1                 (const Value: string    );
    procedure SetStreet2                 (const Value: string    );
    procedure SetSuburb                  (const Value: string    );
    procedure SetPostcode                (const Value: string    );
    procedure SetState                   (const Value: string    );
    procedure SetCountry                 (const Value: string    );
    procedure SetTaxReportingtype        (const Value: string    );
    procedure SetUseW4                   (const Value: Boolean   );
    procedure SetHaveMultipleJobs        (const Value: Boolean   );
    procedure SetChildrenUnder17         (const Value: Integer   );
    procedure SetOtherDependent          (const Value: Integer   );
    procedure SetDependent               (const Value: Integer   );
    procedure SetOtherIncome             (const Value: Double    );
    procedure SetDeductions              (const Value: Double    );
    procedure SetExtraWithholding        (const Value: Double    );
    procedure SetDeleted                 (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  GetPrintDoc : TBusObjPrintDoc;
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
    property EmployeeID               :Integer     read GetEmployeeID             write SetEmployeeID          ;
    property PayYear                  :Integer     read GetPayYear                write SetPayYear             ;
    property PayYearStart             :TDateTime   read GetPayYearStart           write SetPayYearStart        ;
    property FirstName                :string      read GetFirstName              write SetFirstName           ;
    property LastName                 :string      read GetLastName               write SetLastName            ;
    property SocialSecurityNumber     :string      read GetSocialSecurityNumber   write SetSocialSecurityNumber;
    property Street1                  :string      read GetStreet1                write SetStreet1             ;
    property Street2                  :string      read GetStreet2                write SetStreet2             ;
    property Suburb                   :string      read GetSuburb                 write SetSuburb              ;
    property Postcode                 :string      read GetPostcode               write SetPostcode            ;
    property State                    :string      read GetState                  write SetState               ;
    property Country                  :string      read GetCountry                write SetCountry             ;
    property TaxReportingtype         :string      read GetTaxReportingtype       write SetTaxReportingtype    ;
    property UseW4                    :Boolean     read GetUseW4                  write SetUseW4               ;
    property HaveMultipleJobs         :Boolean     read GetHaveMultipleJobs       write SetHaveMultipleJobs    ;
    property ChildrenUnder17          :Integer     read GetChildrenUnder17        write SetChildrenUnder17     ;
    property OtherDependent           :Integer     read GetOtherDependent         write SetOtherDependent      ;
    property Dependent                :Integer     read GetDependent              write SetDependent           ;
    property OtherIncome              :Double      read GetOtherIncome            write SetOtherIncome         ;
    property Deductions               :Double      read GetDeductions             write SetDeductions          ;
    property ExtraWithholding         :Double      read GetExtraWithholding       write SetExtraWithholding    ;
    property Deleted                  :Boolean     read GetDeleted                write SetDeleted             ;
    Property PrintDoc                 :TBusObjPrintDoc Read GetPrintDoc;
  end;


implementation


uses tcDataUtils, CommonLib, AppEnvironment, DateUtils, SysUtils;



  {TFormW4}

constructor TFormW4.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'paysw_4';
  fSQL := 'SELECT * FROM tblPaysW_4';
end;


destructor TFormW4.Destroy;
begin
  inherited;
end;


procedure TFormW4.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'PayYear');
  SetDateTimePropertyFromNode(node,'PayYearStart');
  SetPropertyFromNode(node,'FirstName');
  SetPropertyFromNode(node,'LastName');
  SetPropertyFromNode(node,'SocialSecurityNumber');
  SetPropertyFromNode(node,'Street1');
  SetPropertyFromNode(node,'Street2');
  SetPropertyFromNode(node,'Suburb');
  SetPropertyFromNode(node,'Postcode');
  SetPropertyFromNode(node,'State');
  SetPropertyFromNode(node,'Country');
  SetBooleanPropertyFromNode(node,'TaxReportingtype');
  SetBooleanPropertyFromNode(node,'UseW4');
  SetBooleanPropertyFromNode(node,'HaveMultipleJobs');
  SetPropertyFromNode(node,'ChildrenUnder17');
  SetPropertyFromNode(node,'OtherDependent');
  SetPropertyFromNode(node,'OtherIncome');
  SetPropertyFromNode(node,'Deductions');
  SetPropertyFromNode(node,'ExtraWithholding');
  SetBooleanPropertyFromNode(node,'Deleted');
end;


procedure TFormW4.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'PayYear' ,PayYear);
  AddXMLNode(node,'PayYearStart' ,PayYearStart);
  AddXMLNode(node,'FirstName' ,FirstName);
  AddXMLNode(node,'LastName' ,LastName);
  AddXMLNode(node,'SocialSecurityNumber' ,SocialSecurityNumber);
  AddXMLNode(node,'Street1' ,Street1);
  AddXMLNode(node,'Street2' ,Street2);
  AddXMLNode(node,'Suburb' ,Suburb);
  AddXMLNode(node,'Postcode' ,Postcode);
  AddXMLNode(node,'State' ,State);
  AddXMLNode(node,'Country' ,Country);
  AddXMLNode(node,'TaxReportingtype' ,TaxReportingtype);
  AddXMLNode(node,'UseW4' ,UseW4);
  AddXMLNode(node,'HaveMultipleJobs' ,HaveMultipleJobs);
  AddXMLNode(node,'ChildrenUnder17' ,ChildrenUnder17);
  AddXMLNode(node,'OtherDependent', OtherDependent);
  AddXMLNode(node,'OtherIncome' ,OtherIncome);
  AddXMLNode(node,'Deductions' ,Deductions);
  AddXMLNode(node,'ExtraWithholding' ,ExtraWithholding);
  AddXMLNode(node,'Deleted' ,Deleted);
end;


function TFormW4.ValidateData : Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  if PayYear = 0 then begin
    PayYear := yearof(Appenv.companyprefs.FiscalYearStartingDate);
  end;

  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'EmployeeID should not be 0', False);
    Exit;
  end;

  if PayYearStart = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'PayYearStart should not be blank', False);
    Exit;
  end;

  Result := True;
end;


function TFormW4.Save : Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TFormW4.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TFormW4.DoFieldOnChange(Sender: TField);
begin
  inherited;

  if SysUtils.SameText(Sender.FieldName, 'ChildrenUnder17') Or SysUtils.SameText(Sender.FieldName, 'OtherDependent') then begin
    Dependent := ChildrenUnder17 + OtherDependent;
  end;
end;


function TFormW4.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TFormW4.GetIDField: string;
begin
  Result := 'ID'
end;


class function TFormW4.GetBusObjectTablename: string;
begin
  Result:= 'tblPaysW_4';
end;


function TFormW4.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  PayYear := yearof(Appenv.companyprefs.FiscalYearStartingDate);
  PayYearStart := Appenv.companyprefs.FiscalYearStartingDate;
end;

function TFormW4.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

Function TFormW4.GetPrintDoc : TBusObjPrintDoc;
Begin
  Result := TBusObjPrintDoc(Getcontainercomponent(TBusObjPrintDoc, 'docName = ' + QuotedStr(Self.ClassName) + ' and DocId = ' + IntToStr(Self.ID)));
  If Assigned(Result) Then Result.IsList := True;
End;

{Property Functions}
function  TFormW4.GetEmployeeID          : Integer   ; begin Result := GetIntegerField('EmployeeID')         ;end;
function  TFormW4.GetPayYear             : Integer   ; begin Result := GetIntegerField('PayYear')            ;end;
function  TFormW4.GetPayYearStart        : TDateTime ; begin Result := GetDateTimeField('PayYearStart')      ;end;
function  TFormW4.GetFirstName           : string    ; begin Result := GetStringField('FirstName')           ;end;
function  TFormW4.GetLastName            : string    ; begin Result := GetStringField('LastName')            ;end;
function  TFormW4.GetSocialSecurityNumber: string    ; begin Result := GetStringField('SocialSecurityNumber');end;
function  TFormW4.GetStreet1             : string    ; begin Result := GetStringField('Street1')             ;end;
function  TFormW4.GetStreet2             : string    ; begin Result := GetStringField('Street2')             ;end;
function  TFormW4.GetSuburb              : string    ; begin Result := GetStringField('Suburb')              ;end;
function  TFormW4.GetPostcode            : string    ; begin Result := GetStringField('Postcode')            ;end;
function  TFormW4.GetState               : string    ; begin Result := GetStringField('State')               ;end;
function  TFormW4.GetCountry             : string    ; begin Result := GetStringField('Country')             ;end;
function  TFormW4.GetTaxReportingtype    : string    ; begin Result := GetStringField('TaxReportingtype')   ;end;
function  TFormW4.GetUseW4               : Boolean   ; begin Result := GetBooleanField('UseW4')              ;end;
function  TFormW4.GetHaveMultipleJobs    : Boolean   ; begin Result := GetBooleanField('HaveMultipleJobs')   ;end;
function  TFormW4.GetChildrenUnder17     : Integer   ; begin Result := GetIntegerField('ChildrenUnder17')    ;end;
function  TFormW4.GetOtherDependent      : Integer   ; begin Result := GetIntegerField('OtherDependent')     ;end;
function  TFormW4.GetDependent           : Integer   ; begin Result := GetIntegerField('Dependent')          ;end;
function  TFormW4.GetOtherIncome         : Double    ; begin Result := GetFloatField('OtherIncome')          ;end;
function  TFormW4.GetDeductions          : Double    ; begin Result := GetFloatField('Deductions')           ;end;
function  TFormW4.GetExtraWithholding    : Double    ; begin Result := GetFloatField('ExtraWithholding')     ;end;
function  TFormW4.GetDeleted             : Boolean   ; begin Result := GetBooleanField('Deleted')            ;end;

procedure TFormW4.SetEmployeeID          (const Value: Integer   ); begin SetIntegerField('EmployeeID'         , Value);end;
procedure TFormW4.SetPayYear             (const Value: Integer   ); begin SetIntegerField('PayYear'            , Value);end;
procedure TFormW4.SetPayYearStart        (const Value: TDateTime ); begin SetDateTimeField('PayYearStart'      , Value);end;
procedure TFormW4.SetFirstName           (const Value: string    ); begin SetStringField('FirstName'           , Value);end;
procedure TFormW4.SetLastName            (const Value: string    ); begin SetStringField('LastName'            , Value);end;
procedure TFormW4.SetSocialSecurityNumber(const Value: string    ); begin SetStringField('SocialSecurityNumber', Value);end;
procedure TFormW4.SetStreet1             (const Value: string    ); begin SetStringField('Street1'             , Value);end;
procedure TFormW4.SetStreet2             (const Value: string    ); begin SetStringField('Street2'             , Value);end;
procedure TFormW4.SetSuburb              (const Value: string    ); begin SetStringField('Suburb'              , Value);end;
procedure TFormW4.SetPostcode            (const Value: string    ); begin SetStringField('Postcode'            , Value);end;
procedure TFormW4.SetState               (const Value: string    ); begin SetStringField('State'               , Value);end;
procedure TFormW4.SetCountry             (const Value: string    ); begin SetStringField('Country'             , Value);end;
procedure TFormW4.SetTaxReportingtype    (const Value: string    ); begin SetStringField('TaxReportingtype'    , Value);end;
procedure TFormW4.SetUseW4               (const Value: Boolean   ); begin SetBooleanField('UseW4'              , Value);end;
procedure TFormW4.SetHaveMultipleJobs    (const Value: Boolean   ); begin SetBooleanField('HaveMultipleJobs'   , Value);end;
procedure TFormW4.SetChildrenUnder17     (const Value: Integer   ); begin SetIntegerField('ChildrenUnder17'    , Value);end;
procedure TFormW4.SetOtherDependent      (const Value: Integer   ); begin SetIntegerField('OtherDependent'     , Value);end;
procedure TFormW4.SetDependent           (const Value: Integer   ); begin SetIntegerField('Dependent'          , Value);end;
procedure TFormW4.SetOtherIncome         (const Value: Double    ); begin SetFloatField('OtherIncome'          , Value);end;
procedure TFormW4.SetDeductions          (const Value: Double    ); begin SetFloatField('Deductions'           , Value);end;
procedure TFormW4.SetExtraWithholding    (const Value: Double    ); begin SetFloatField('ExtraWithholding'     , Value);end;
procedure TFormW4.SetDeleted             (const Value: Boolean   ); begin SetBooleanField('Deleted'            , Value);end;


initialization
  RegisterClass(TFormW4);


end.

