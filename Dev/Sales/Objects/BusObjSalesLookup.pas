unit BusObjSalesLookup;

interface

uses BusObjBase, DB, Classes, XMLDoc;


type

  TTransLineProductCustomFields = class(TMSBusObj)
  private
    function GetCUSTFLD1     : string    ;
    function GetCUSTFLD2     : string    ;
    function GetCUSTFLD3     : string    ;
    function GetCUSTFLD4     : string    ;
    function GetCUSTFLD5     : string    ;
    function GetCUSTFLD6     : string    ;
    function GetCUSTFLD7     : string    ;
    function GetCUSTFLD8     : string    ;
    function GetCUSTFLD9     : string    ;
    function GetCUSTFLD10    : string    ;
    function GetCUSTFLD11    : string    ;
    function GetCUSTFLD12    : string    ;
    function GetCUSTFLD13    : string    ;
    function GetCUSTFLD14    : string    ;
    function GetCUSTFLD15    : string    ;
    function GetCUSTDATE1    : TDateTime ;
    function GetCUSTDATE2    : TDateTime ;
    function GetCUSTDATE3    : TDateTime ;
    function GetPARTSID      : Integer   ;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
  published
    property CUSTFLD1      :string      read GetCUSTFLD1;
    property CUSTFLD2      :string      read GetCUSTFLD2;
    property CUSTFLD3      :string      read GetCUSTFLD3;
    property CUSTFLD4      :string      read GetCUSTFLD4;
    property CUSTFLD5      :string      read GetCUSTFLD5;
    property CUSTFLD6      :string      read GetCUSTFLD6;
    property CUSTFLD7      :string      read GetCUSTFLD7;
    property CUSTFLD8      :string      read GetCUSTFLD8;
    property CUSTFLD9      :string      read GetCUSTFLD9;
    property CUSTFLD10     :string      read GetCUSTFLD10;
    property CUSTFLD11     :string      read GetCUSTFLD11;
    property CUSTFLD12     :string      read GetCUSTFLD12;
    property CUSTFLD13     :string      read GetCUSTFLD13;
    property CUSTFLD14     :string      read GetCUSTFLD14;
    property CUSTFLD15     :string      read GetCUSTFLD15;
    property CUSTDATE1     :TDateTime   read GetCUSTDATE1;
    property CUSTDATE2     :TDateTime   read GetCUSTDATE2;
    property CUSTDATE3     :TDateTime   read GetCUSTDATE3;
    property PARTSID       :Integer     read GetPARTSID  ;
  end;


implementation


uses SysUtils, tcDataUtils, CommonLib;




  {TTransLineProductCustomFields}

constructor TTransLineProductCustomFields.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SaleslineProductCustomFields';
  fSQL := 'SELECT PARTSID , CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5, ' +
          ' CUSTFLD6, CUSTFLD7, CUSTFLD8, CUSTFLD9, CUSTFLD10, CUSTFLD11,  ' +
          ' CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15, CUSTDATE1, CUSTDATE2, ' +
          ' CUSTDATE3  from tblparts';
end;




class function TTransLineProductCustomFields.GetIDField: string;
begin
  Result := 'PartsId'
end;


class function TTransLineProductCustomFields.GetBusObjectTablename: string;
begin
  Result:= 'tblParts';
end;




{Property Functions}
function  TTransLineProductCustomFields.GetCUSTFLD1 : string    ; begin Result := GetStringField('CUSTFLD1');end;
function  TTransLineProductCustomFields.GetCUSTFLD2 : string    ; begin Result := GetStringField('CUSTFLD2');end;
function  TTransLineProductCustomFields.GetCUSTFLD3 : string    ; begin Result := GetStringField('CUSTFLD3');end;
function  TTransLineProductCustomFields.GetCUSTFLD4 : string    ; begin Result := GetStringField('CUSTFLD4');end;
function  TTransLineProductCustomFields.GetCUSTFLD5 : string    ; begin Result := GetStringField('CUSTFLD5');end;
function  TTransLineProductCustomFields.GetCUSTFLD6 : string    ; begin Result := GetStringField('CUSTFLD6');end;
function  TTransLineProductCustomFields.GetCUSTFLD7 : string    ; begin Result := GetStringField('CUSTFLD7');end;
function  TTransLineProductCustomFields.GetCUSTFLD8 : string    ; begin Result := GetStringField('CUSTFLD8');end;
function  TTransLineProductCustomFields.GetCUSTFLD9 : string    ; begin Result := GetStringField('CUSTFLD9');end;
function  TTransLineProductCustomFields.GetCUSTFLD10: string    ; begin Result := GetStringField('CUSTFLD10');end;
function  TTransLineProductCustomFields.GetCUSTFLD11: string    ; begin Result := GetStringField('CUSTFLD11');end;
function  TTransLineProductCustomFields.GetCUSTFLD12: string    ; begin Result := GetStringField('CUSTFLD12');end;
function  TTransLineProductCustomFields.GetCUSTFLD13: string    ; begin Result := GetStringField('CUSTFLD13');end;
function  TTransLineProductCustomFields.GetCUSTFLD14: string    ; begin Result := GetStringField('CUSTFLD14');end;
function  TTransLineProductCustomFields.GetCUSTFLD15: string    ; begin Result := GetStringField('CUSTFLD15');end;
function  TTransLineProductCustomFields.GetCUSTDATE1: TDateTime ; begin Result := GetDateTimeField('CUSTDATE1');end;
function  TTransLineProductCustomFields.GetCUSTDATE2: TDateTime ; begin Result := GetDateTimeField('CUSTDATE2');end;
function  TTransLineProductCustomFields.GetCUSTDATE3: TDateTime ; begin Result := GetDateTimeField('CUSTDATE3');end;
function  TTransLineProductCustomFields.GetPARTSID  : Integer   ; begin Result := GetIntegerField('PARTSID');end;


initialization
  RegisterClass(TTransLineProductCustomFields);

end.
