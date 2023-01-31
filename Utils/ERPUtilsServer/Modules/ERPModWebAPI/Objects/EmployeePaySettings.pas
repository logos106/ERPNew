unit EmployeePaySettings;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/04/22  1.00.00  Jacob  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, EmployeeDetails, PayrollNotes, PayrollTaxes;


type
  Temployeepaysettings_vs1 = class(TMSBusObj)

  private
    function GetABN                     : Integer   ;
    function GetDateLastActuallyPaID    : TDateTime ;
    function GetEmployeeID              : Integer   ;
    function GetPayRollNotesID          : Integer   ;
    function GetPayrollTaxesID          : Integer   ;
    procedure SetABN                     (const Value: Integer   );
    procedure SetDateLastActuallyPaID    (const Value: TDateTime );
    procedure SetEmployeeID              (const Value: Integer   );
    procedure SetPayRollNotesID          (const Value: Integer   );
    procedure SetPayrollTaxesID          (const Value: Integer   );

    function GetEmployeeDetails: TEmployeeDetails_vs1;
    function GetPayrollNotes: Tpayrollnotes_vs1;
    function GetPayrollTaxes: Tpayrolltaxes_vs1;


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
    property ABN                      :Integer     read GetABN                    write SetABN                 ;
    property DateLastActuallyPaID     :TDateTime   read GetDateLastActuallyPaID   write SetDateLastActuallyPaID;
    property EmployeeID               :Integer     read GetEmployeeID             write SetEmployeeID          ;
    property PayRollNotesID           :Integer     read GetPayRollNotesID         write SetPayRollNotesID      ;
    property PayrollTaxesID           :Integer     read GetPayrollTaxesID         write SetPayrollTaxesID      ;

    property Employee: TEmployeeDetails_vs1 read GetEmployeeDetails;
    property PayrollNotes: Tpayrollnotes_vs1  read  GetPayrollNotes;
    property PayrollTaxes: Tpayrolltaxes_vs1  read  GetPayrollTaxes;

  end;


implementation


uses tcDataUtils, CommonLib, SysUtils;



  {Temployeepaysettings_vs1}

constructor Temployeepaysettings_vs1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'employeepaysettings_vs1';
  fSQL := 'SELECT * FROM tblemployeepaysettings_vs1';
end;


destructor Temployeepaysettings_vs1.Destroy;
begin
  inherited;
end;


procedure Temployeepaysettings_vs1.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ABN');
  SetDateTimePropertyFromNode(node,'DateLastActuallyPaID');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'PayRollNotesID');
  SetPropertyFromNode(node,'PayrollTaxesID');
end;


procedure Temployeepaysettings_vs1.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ABN' ,ABN);
  AddXMLNode(node,'DateLastActuallyPaID' ,DateLastActuallyPaID);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'PayRollNotesID' ,PayRollNotesID);
  AddXMLNode(node,'PayrollTaxesID' ,PayrollTaxesID);
end;


function Temployeepaysettings_vs1.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Temployeepaysettings_vs1.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Temployeepaysettings_vs1.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Temployeepaysettings_vs1.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Temployeepaysettings_vs1.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Temployeepaysettings_vs1.GetIDField: string;
begin
  Result := 'EmployeePaySettingID'
end;


class function Temployeepaysettings_vs1.GetBusObjectTablename: string;
begin
  Result:= 'tblemployeepaysettings_vs1';
end;


function Temployeepaysettings_vs1.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Temployeepaysettings_vs1.GetABN                 : Integer   ; begin Result := GetIntegerField('ABN');end;
function  Temployeepaysettings_vs1.GetDateLastActuallyPaID: TDateTime ; begin Result := GetDateTimeField('DateLastActuallyPaID');end;
function  Temployeepaysettings_vs1.GetEmployeeID          : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  Temployeepaysettings_vs1.GetPayRollNotesID      : Integer   ; begin Result := GetIntegerField('PayRollNotesID');end;
function  Temployeepaysettings_vs1.GetPayrollTaxesID      : Integer   ; begin Result := GetIntegerField('PayrollTaxesID');end;


function Temployeepaysettings_vs1.GetEmployeeDetails: TEmployeeDetails_vs1;
begin

   result := TEmployeeDetails_vs1(GetContainerComponent(TEmployeeDetails_vs1, 'EmployeeID = ' + IntToStr(EmployeeID)));

end;


function Temployeepaysettings_vs1.GetPayrollNotes: Tpayrollnotes_vs1;
begin

   result := Tpayrollnotes_vs1(GetContainerComponent(Tpayrollnotes_vs1, 'PayrollNotesID = ' + IntToStr(PayrollNotesID)));

end;


function Temployeepaysettings_vs1.GetPayrollTaxes: Tpayrolltaxes_vs1;
begin

   result := Tpayrolltaxes_vs1(GetContainerComponent(Tpayrolltaxes_vs1, 'PayrollTaxesID = ' + IntToStr(PayrollTaxesID)));

end;


procedure Temployeepaysettings_vs1.SetABN                 (const Value: Integer   ); begin SetIntegerField('ABN'                  , Value);end;
procedure Temployeepaysettings_vs1.SetDateLastActuallyPaID(const Value: TDateTime ); begin SetDateTimeField('DateLastActuallyPaID' , Value);end;
procedure Temployeepaysettings_vs1.SetEmployeeID          (const Value: Integer   ); begin SetIntegerField('EmployeeID'           , Value);end;
procedure Temployeepaysettings_vs1.SetPayRollNotesID      (const Value: Integer   ); begin SetIntegerField('PayRollNotesID'       , Value);end;
procedure Temployeepaysettings_vs1.SetPayrollTaxesID      (const Value: Integer   ); begin SetIntegerField('PayrollTaxesID'       , Value);end;



initialization

  RegisterClass(Temployeepaysettings_vs1);


end.
