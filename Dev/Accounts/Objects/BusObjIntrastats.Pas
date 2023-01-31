unit BusObjIntrastats;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  23/01/08  1.00.01  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, BusObjIntrastatLines, XMLDoc, XMLIntf;


type
  Tintrastats = class(TMSBusObj)
  private
    fIntrastatLinesObj:Tintrastatlines;
    Function GetSubmittedDate    : TDateTime ;
    Function GetIntrastatType    : string    ;
    Function GetIsSubmitted      : Boolean   ;
    Function GetMonth            : string    ;
    Function GetYear             : integer;
    Procedure SetSubmittedDate    (const Value: TDateTime );
    Procedure SetIntrastatType    (const Value: string    );
    Procedure SetIsSubmitted      (const Value: Boolean   );
    Procedure SetMonth            (const Value: string    );
    Procedure SetYear             (const Value: integer   );
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    Procedure DoFieldOnChange(Sender: TField);                          override;
    Function  GetSQL                             : string;              override;
    Function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  Public
    Class Function  GetIDField                   : string;              override;
    Class Function  GetBusObjectTablename        : string;              override;
    Constructor  Create(AOwner: TComponent);                            override;
    Destructor   Destroy;                                               override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;
    Function     ValidateData: Boolean ;                                override;
    Function     Save: Boolean ;                                        override;
  Published
    property SubmittedDate     :TDateTime   read GetSubmittedDate   write SetSubmittedDate;
    property IntrastatType     :string      read GetIntrastatType   write SetIntrastatType;
    property IsSubmitted       :Boolean     read GetIsSubmitted     write SetIsSubmitted  ;
    property Month             :String      read GetMonth           write SetMonth;
    property Year              :integer     read GetYear            write SetYear;
    property IntrastatLines    :Tintrastatlines read fIntrastatlinesObj write fIntrastatlinesObj;
  end;


implementation


uses SysUtils, CommonLib, FastFuncs;



      {Tintrastats}

Constructor Tintrastats.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'intrastats';
  fSQL := 'SELECT * FROM tblintrastats';
  fIntrastatLinesObj := Tintrastatlines.Create(Self);
end;


Destructor Tintrastats.Destroy;
begin
  inherited;
end;

procedure   Tintrastats.Load(Const aId: integer;const fIsReadonly:boolean =False);
begin
  inherited Load(aid, fIsReadonly);
  fIntrastatLinesObj.LoadSelect('IntrastatID = ' + IntToStr(Self.id));
end;
 

Procedure Tintrastats.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SubmittedDate');
  SetPropertyFromNode(node,'IntrastatType');
  SetPropertyFromNode(node,'IsSubmitted');
  SetPropertyFromNode(node,'Month');
  SetPropertyFromNode(node,'Year');
end;


Procedure Tintrastats.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SubmittedDate' ,SubmittedDate);
  AddXMLNode(node,'IntrastatType' ,IntrastatType);
  AddXMLNode(node,'IsSubmitted' ,IsSubmitted);
  AddXMLNode(node,'Month' ,Month);
  AddXMLNode(node,'Year' ,Year);
end;


Function Tintrastats.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Month = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Month should not be blank' );
    Exit;
  end;
  if Year = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Year should not be 0' );
    Exit;
  end;
  Result := True;
end;


Function Tintrastats.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure Tintrastats.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure Tintrastats.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function Tintrastats.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


Class Function Tintrastats.GetIDField: string;
begin
  Result := 'IntrastatID'
end;


Class Function Tintrastats.GetBusObjectTablename: string;
begin
  Result:= 'tblintrastats';
end;


Function Tintrastats.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  Tintrastats.GetSubmittedDate: TDateTime ; begin Result := GetDateTimeField('SubmittedDate');end;
Function  Tintrastats.GetIntrastatType: string    ; begin Result := GetStringField('IntrastatType');end;
Function  Tintrastats.GetMonth: string    ; begin Result := GetStringField('Month');end;
Function  Tintrastats.GetYear : integer   ; begin Result := GetIntegerField('Year');end;
Function  Tintrastats.GetIsSubmitted  : Boolean   ; begin Result := GetBooleanField('IsSubmitted');end;
Procedure Tintrastats.SetSubmittedDate(const Value: TDateTime ); begin SetDateTimeField('SubmittedDate' , Value);end;
Procedure Tintrastats.SetIntrastatType(const Value: string    ); begin SetStringField('IntrastatType' , Value);end;
Procedure Tintrastats.SetMonth(const Value: string    ); begin SetStringField('Month' , Value);end;
Procedure Tintrastats.SetYear(const Value: integer   ); begin SetIntegerField('Year' , Value);end;
Procedure Tintrastats.SetIsSubmitted  (const Value: Boolean   ); begin SetBooleanField('IsSubmitted'   , Value);end;


initialization
  RegisterClassOnce(Tintrastats);


end.
