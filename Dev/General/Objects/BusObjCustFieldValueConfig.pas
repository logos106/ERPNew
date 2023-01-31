unit BusObjCustFieldValueConfig;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/04/12  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TBusObjCustFieldValueConfig = class(TMSBusObj)
  private
    function GetFieldNumber         : Integer   ;
    function GetText                : string    ;
    procedure SetFieldNumber         (const Value: Integer   );
    procedure SetText                (const Value: string    );
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
    property FieldNumber          :Integer     read GetFieldNumber        write SetFieldNumber     ;
    property Text                 :string      read GetText               write SetText            ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TBusObjCustFieldValueConfig}

constructor TBusObjCustFieldValueConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BusObjCustFieldValueConfig';
  fSQL := 'SELECT * FROM tblcustomfielddropdowns';
end;


destructor TBusObjCustFieldValueConfig.Destroy;
begin
  inherited;
end;


procedure TBusObjCustFieldValueConfig.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FieldNumber');
  SetPropertyFromNode(node,'Text');
  SetPropertyFromNode(node,'msUpdateSiteCode');
end;


procedure TBusObjCustFieldValueConfig.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FieldNumber' ,FieldNumber);
  AddXMLNode(node,'Text' ,Text);
  AddXMLNode(node,'msUpdateSiteCode' ,msUpdateSiteCode);
end;


function TBusObjCustFieldValueConfig.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if FieldNumber < 0 then begin
    AddResult(false,rssWarning,0,'Invalid Field Number');
    exit;
  end;
  if Text = '' then begin
    AddResult(false,rssWarning,0,'Text is blank');
    exit;
  end;
  Result := True;
end;


function TBusObjCustFieldValueConfig.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TBusObjCustFieldValueConfig.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TBusObjCustFieldValueConfig.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TBusObjCustFieldValueConfig.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TBusObjCustFieldValueConfig.GetIDField: string;
begin
  Result := 'DropDownID'
end;


class function TBusObjCustFieldValueConfig.GetBusObjectTablename: string;
begin
  Result:= 'tblcustomfielddropdowns';
end;


function TBusObjCustFieldValueConfig.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TBusObjCustFieldValueConfig.GetFieldNumber     : Integer   ; begin Result := GetIntegerField('FieldNumber');end;
function  TBusObjCustFieldValueConfig.GetText            : string    ; begin Result := GetStringField('Text');end;
procedure TBusObjCustFieldValueConfig.SetFieldNumber     (const Value: Integer   ); begin SetIntegerField('FieldNumber'      , Value);end;
procedure TBusObjCustFieldValueConfig.SetText            (const Value: string    ); begin SetStringField('Text'             , Value);end;


initialization
  RegisterClass(TBusObjCustFieldValueConfig);


end.
