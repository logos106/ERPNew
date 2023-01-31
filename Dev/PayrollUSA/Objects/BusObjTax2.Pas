unit BusObjTax2;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  10/03/08  1.00.01  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TTaxUS = class(TMSBusObj)
  private
    Function GetScaleID        : Integer;
    Function GetA              : Double;
    Function GetB              : Double;
    Function GetC              : Double;
    Function GetD              : Double;
    Function GetE              : Double;

    Procedure SetScaleID        (const Value: Integer   );
    Procedure SetA              (const Value: Double    );
    Procedure SetB              (const Value: Double    );
    Procedure SetC              (const Value: Double    );
    Procedure SetD              (const Value: Double    );
    Procedure SetE              (const Value: Double    );
    
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
    property A               :Double      read GetA             write SetA          ;
    property B               :Double      read GetB             write SetB          ;
    property C               :Double      read GetC             write SetC          ;
    property D               :Double      read GetD             write SetD          ;
    property E               :Double      read GetE             write SetE          ;
  end;


implementation

uses CommonLib,BusObjTaxScales;

Constructor TTaxUS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'tax_us';
  fSQL := 'SELECT * FROM tbltax_us';
end;


Destructor TTaxUS.Destroy;
begin
  inherited;
end;

Function  TTaxUS.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    if not Result then Exit;

    if Self.Owner is TTaxScales then begin
      TTaxScales(Self.Owner).PostDB;
      ScaleId := TTaxScales(Self.Owner).ID;
    end;
end;

Procedure TTaxUS.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ScaleID');
  SetPropertyFromNode(node,'A');
  SetPropertyFromNode(node,'B');
  SetPropertyFromNode(node,'C');
  SetPropertyFromNode(node,'D');
  SetPropertyFromNode(node,'E');
end;


Procedure TTaxUS.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ScaleID' ,ScaleID);
  AddXMLNode(node,'A', A);
  AddXMLNode(node,'B', B);
  AddXMLNode(node,'C', C);
  AddXMLNode(node,'D', D);
  AddXMLNode(node,'E', E);
end;

Function TTaxUS.ValidateData: Boolean;
begin
  Result := False;

  Resultstatus.Clear;

  if ScaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  Fielddisplaylabel('ScaleID') + ' should not be 0' , true );
    Exit;
  end;

  if (A <> 0) and (B <> 0) and (A > B) then begin
    Resultstatus.AddItem(False , rssError , 0,  Fielddisplaylabel('B') + ' should not be less then A' , true );
    Exit;
  end;

  Result := True;
end;

Function TTaxUS.Save : Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;

  Result := inherited Save;
end;

Procedure TTaxUS.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

Procedure TTaxUS.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

Function TTaxUS.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

Class Function TTaxUS.GetIDField: string;
begin
  Result := 'TaxID'
end;

Class Function TTaxUS.GetBusObjectTablename: string;
begin
  Result:= 'tbltax_us';
end;

Function TTaxUS.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
Function  TTaxUS.GetScaleID    : Integer   ; begin Result := GetIntegerField('ScaleID');end;
Function  TTaxUS.GetA          : Double    ; begin Result := GetFloatField('A');end;
Function  TTaxUS.GetB          : Double    ; begin Result := GetFloatField('B');end;
Function  TTaxUS.GetC          : Double    ; begin Result := GetFloatField('C');end;
Function  TTaxUS.GetD          : Double    ; begin Result := GetFloatField('D');end;
Function  TTaxUS.GetE          : Double    ; begin Result := GetFloatField('E');end;

Procedure TTaxUS.SetScaleID    (const Value: Integer   ); begin SetIntegerField('ScaleID', Value);end;
Procedure TTaxUS.SetA          (const Value: Double    ); begin SetFloatField('A', Value);end;
Procedure TTaxUS.SetB          (const Value: Double    ); begin SetFloatField('B', Value);end;
Procedure TTaxUS.SetC          (const Value: Double    ); begin SetFloatField('C', Value);end;
Procedure TTaxUS.SetD          (const Value: Double    ); begin SetFloatField('D', Value);end;
Procedure TTaxUS.SetE          (const Value: Double    ); begin SetFloatField('E', Value);end;

initialization
  RegisterClassOnce(TTaxUS);


end.
