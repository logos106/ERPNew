unit BusObjTax;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  10/03/08  1.00.01  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TTax = class(TMSBusObj)
  private
    Function GetScaleID        : Integer   ;
    Function GetThreshold      : Double    ;
    Function GetA              : Double    ;
    Function GetB              : Double    ;
    Procedure SetScaleID        (const Value: Integer   );
    Procedure SetThreshold      (const Value: Double    );
    Procedure SetA              (const Value: Double    );
    Procedure SetB              (const Value: Double    );
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    Procedure DoFieldOnChange(Sender: TField);                          override;
    Function  GetSQL                             : string;              override;
    Function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;           Override;
  Public
    Class Function  GetIDField                   : string;              override;
    Class Function  GetBusObjectTablename        : string;              override;
    Constructor  Create(AOwner: TComponent);                            override;
    Destructor   Destroy;                                               override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Function     ValidateData: Boolean ;                                override;
    Function     Save: Boolean ;                                        override;  
  Published
    property ScaleID         :Integer     read GetScaleID       write SetScaleID    ;
    property Threshold       :Double      read GetThreshold     write SetThreshold  ;
    property A               :Double      read GetA             write SetA          ;
    property B               :Double      read GetB             write SetB          ;
  end;


implementation


uses CommonLib,BusObjTaxScales;



      {Ttax}

Constructor Ttax.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'tax';
  fSQL := 'SELECT * FROM tbltax';
end;


Destructor Ttax.Destroy;
begin
  inherited;
end;

Function  Ttax.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    if not Result then exit;
    if Self.Owner is TTaxScales then begin
      TTaxScales(Self.Owner).PostDB;
      ScaleId := TTaxScales(Self.Owner).ID;
    end;
end;


Procedure Ttax.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ScaleID');
  SetPropertyFromNode(node,'Threshold');
  SetPropertyFromNode(node,'A');
  SetPropertyFromNode(node,'B');
end;


Procedure Ttax.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ScaleID' ,ScaleID);
  AddXMLNode(node,'Threshold' ,Threshold);
  AddXMLNode(node,'A' ,A);
  AddXMLNode(node,'B' ,B);
end;


Function Ttax.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ScaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  Fielddisplaylabel('ScaleID')+' should not be 0' , true );
    Exit;
  end;
  if Threshold = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  Fielddisplaylabel('Threshold')+' should not be 0' , true );
    Exit;
  end;
  (*if A = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  Fielddisplaylabel('A')+' should not be 0' , true );
    Exit;
  end;
  if B = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  Fielddisplaylabel('B')+' should not be 0' , true );
    Exit;
  end;*)
  Result := True;
end;


Function Ttax.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure Ttax.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure Ttax.DoFieldOnChange(Sender: TField);
begin
  inherited;
  
end;


Function Ttax.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


Class Function Ttax.GetIDField: string;
begin
  Result := 'TaxID'
end;


Class Function Ttax.GetBusObjectTablename: string;
begin
  Result:= 'tbltax';
end;


Function Ttax.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  Ttax.GetScaleID    : Integer   ; begin Result := GetIntegerField('ScaleID');end;
Function  Ttax.GetThreshold  : Double    ; begin Result := GetFloatField('Threshold');end;
Function  Ttax.GetA          : Double    ; begin Result := GetFloatField('A');end;
Function  Ttax.GetB          : Double    ; begin Result := GetFloatField('B');end;
Procedure Ttax.SetScaleID    (const Value: Integer   ); begin SetIntegerField('ScaleID'     , Value);end;
Procedure Ttax.SetThreshold  (const Value: Double    ); begin SetFloatField('Threshold'   , Value);end;
Procedure Ttax.SetA          (const Value: Double    ); begin SetFloatField('A'           , Value);end;
Procedure Ttax.SetB          (const Value: Double    ); begin SetFloatField('B'           , Value);end;


initialization

  RegisterClassOnce(Ttax);


end.
