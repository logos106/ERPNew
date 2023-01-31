unit BusObjTaxScales;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/03/08  1.00.01  RM.  Initial Version.

  BusObjTaxScales
     |___BusObjTax

  }

interface


uses BusObjBase, DB, Classes, BusObjTax, XMLDoc, XMLIntf, BusObjTax2;


type
  TTaxScales = class(TMSBusObj)

  private
    //fTax:Ttax;
    alllinesValid :Boolean;
    Function GetScaleID             : Integer   ;
    Function GetScaleDescription    : string    ;
    Function GetLastUpdated         : TDateTime ;
    Function GetActive              : Boolean   ;
    Procedure SetScaleID             (const Value: Integer   );
    Procedure SetScaleDescription    (const Value: string    );
    Procedure SetLastUpdated         (const Value: TDateTime );
    Procedure SetActive              (const Value: Boolean   );
    Function getTax: Ttax;
    Function getTax2: TTaxUS;

    function  GetTaxTreatment    :  string;

  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    Procedure DoFieldOnChange(Sender: TField);                          override;
    Function  GetSQL                             : string;              override;
    Function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
    Procedure ValidateDatacallback(Const Sender: TBusObj; var Abort: boolean);


  Public
    Class Function  GetIDField                   : string;              override;
    Class Function  GetBusObjectTablename        : string;              override;
    Constructor  Create(AOwner: TComponent);                            override;
    Destructor   Destroy;                                               override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Function     ValidateData: Boolean ;                                override;
    Function     Save: Boolean ;                                        override;
    procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;


  Published
    property ScaleID              :Integer     read GetScaleID            write SetScaleID         ;
    property ScaleDescription     :string      read GetScaleDescription   write SetScaleDescription;
    property LastUpdated          :TDateTime   read GetLastUpdated        write SetLastUpdated     ;
    property Active               :Boolean     read GetActive             write SetActive          ;

    property Tax                  :TTax        read getTax;//fTax                  write fTax;
    property Tax2                 :TTaxUS      read getTax2;

    property TaxTreatment                 : string      read GetTaxTreatment;


  end;


implementation

uses CommonLib,SysUtils, FastFuncs;



      {Ttaxscales}

Constructor Ttaxscales.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'taxscales';
  fSQL := 'SELECT * FROM tbltaxscales';
  (*fTax  := Ttax.Create(Self);
  fTax.Connection := Self.Connection;*)
end;

Function  Ttaxscales.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then exit;
  LastUpdated := Now;
end;

Destructor Ttaxscales.Destroy;
begin
  inherited;
end;

procedure   Ttaxscales.Load(Const aId: integer;const fIsReadonly:boolean =False);
begin
  inherited Load(aid, fIsReadonly);
  Tax;
  Tax2;
  //fTax.LoadSelect('ScaleID = ' + IntToStr(ScaleID) , fIsReadonly);
end;

Procedure Ttaxscales.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ScaleID');
  SetPropertyFromNode(node,'ScaleDescription');
  SetPropertyFromNode(node,'LastUpdated');
  SetPropertyFromNode(node,'Active');
end;


Procedure Ttaxscales.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ScaleID' ,ScaleID);
  AddXMLNode(node,'ScaleDescription' ,ScaleDescription);
  AddXMLNode(node,'LastUpdated' ,LastUpdated);
  AddXMLNode(node,'Active' ,Active);
end;


Function Ttaxscales.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;

  if ScaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Tax Scale Number should not be 0');
    Exit;
  end;

  if LastUpdated = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Last Updated should not be blank');
    Exit;
  end;

  if ScaleDescription = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Description should not be blank');
    Exit;
  end;

  if (Tax.count = 0) and (Tax2.count = 0) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Tax scale should have at least one line' );
    Exit;
  end;

  alllinesValid := True;

  if Assigned(Tax) then
    Tax.iteraterecords(ValidateDatacallback);

  if Assigned(Tax2) then
    Tax2.iteraterecords(ValidateDatacallback);

  Result := alllinesValid;
end;

procedure TTaxScales.ValidateDatacallback(const Sender: TBusObj; var Abort: boolean);
begin
  if (not (Sender is TTax)) and (not (Sender is TTaxUS)) then exit;

  if (Sender is TTax) and (not TTax(SendeR).ValidateData) then begin
    alllinesValid := False;
    Abort := True;
  end;

  if (Sender is TTaxUS) and (not TTaxUS(SendeR).ValidateData) then begin
    alllinesValid := False;
    Abort := True;
  end;
end;


Function Ttaxscales.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure Ttaxscales.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure Ttaxscales.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function Ttaxscales.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TTaxScales.getTax: Ttax;
begin
  Result := TTax(getContainercomponent(Ttax, 'ScaleId = ' + inttostr(ID)));
end;

function TTaxScales.getTax2: TTaxUS;
begin
  Result := TTaxUS(getContainercomponent(TTaxUS, 'ScaleId = ' + inttostr(ID)));
end;

Class Function Ttaxscales.GetIDField: string;
begin
  Result := 'ScaleID'
end;


Class Function Ttaxscales.GetBusObjectTablename: string;
begin
  Result:= 'tbltaxscales';
end;


Function Ttaxscales.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  Ttaxscales.GetScaleID         : Integer   ; begin Result := GetIntegerField('ScaleID');end;
Function  Ttaxscales.GetScaleDescription: string    ; begin Result := GetStringField('ScaleDescription');end;
Function  Ttaxscales.GetLastUpdated     : TDateTime ; begin Result := GetDateTimeField('LastUpdated');end;
Function  Ttaxscales.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;

function  Ttaxscales.GetTaxTreatment    : String;
begin

   result := GetStringField('TT_Category') + GetStringField('TT_Option') + GetStringField('TT_STSL')
           + GetStringField('TT_MLS') + GetStringField('TT_MLE') + GetStringField('TT_MLR');

end;


Procedure Ttaxscales.SetScaleID         (const Value: Integer   ); begin SetIntegerField('ScaleID'          , Value);end;
Procedure Ttaxscales.SetScaleDescription(const Value: string    ); begin SetStringField('ScaleID'          , Value);end;
Procedure Ttaxscales.SetLastUpdated     (const Value: TDateTime ); begin SetDateTimeField('LastUpdated'      , Value);end;
Procedure Ttaxscales.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;


initialization
  RegisterClassOnce(Ttaxscales);


end.
