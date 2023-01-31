unit BusObjcommissionTypes;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   30/08/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   Tcommissiontypes = class(TMSBusObj)
   private
      Function GetCommissiondesc      :String    ;
      Procedure SetCommissiondesc      (Const Value :String    );
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;


      Property Commissiondesc       :String       Read getCommissiondesc    Write SetCommissiondesc;
   End;


implementation

uses
  CommonLib;





{========================================================
         Tcommissiontypes
========================================================}
constructor Tcommissiontypes.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblcommissiontypes';
end;


destructor Tcommissiontypes.Destroy;
begin
   inherited;
end;


procedure   Tcommissiontypes.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Commissiondesc');
end;


procedure   Tcommissiontypes.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Commissiondesc' ,Commissiondesc);
end;


function    Tcommissiontypes.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Commissiondesc = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Commission description should not be blank' , False );
      Exit;
   end;
   Result := true;
end;


function    Tcommissiontypes.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;

procedure Tcommissiontypes.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;

procedure Tcommissiontypes.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;

Function Tcommissiontypes.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;

class function  Tcommissiontypes.GetIDField : String;
begin
   Result := 'Commissionid'
end;

class function Tcommissiontypes.GetBusObjectTablename: string;
begin
  Result := 'tblcommissiontypes';
end;



Function  Tcommissiontypes.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Tcommissiontypes.GetCommissiondesc:String    ; begin Result := GetStringField('Commissiondesc');End;
Procedure Tcommissiontypes.SetCommissiondesc(Const Value :String    ); begin SetStringField('Commissiondesc' , Value);End;


initialization
RegisterClassOnce(Tcommissiontypes);


end.
