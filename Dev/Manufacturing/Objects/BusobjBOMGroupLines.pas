unit BusobjBOMGroupLines;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  27/06/12  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSalesGroupedLines = class(TMSBusObj)
  private
    function GetSaleID                 : Integer   ;
    function GetBOMProductionLineID    : Integer   ;
    function GetBOMGroupedLineID       : Integer   ;
    function GetEmployeeID             : Integer   ;
    function GetGroupedAt              : TDateTime ;
    procedure SetSaleID                 (const Value: Integer   );
    procedure SetBOMProductionLineID    (const Value: Integer   );
    procedure SetBOMGroupedLineID       (const Value: Integer   );
    procedure SetEmployeeID             (const Value: Integer   );
    procedure SetGroupedAt              (const Value: TDateTime );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
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
    property SaleID                  :Integer     read GetSaleID                write SetSaleID             ;
    property BOMProductionLineID     :Integer     read GetBOMProductionLineID   write SetBOMProductionLineID;
    property BOMGroupedLineID        :Integer     read GetBOMGroupedLineID      write SetBOMGroupedLineID   ;
    property EmployeeID              :Integer     read GetEmployeeID            write SetEmployeeID         ;
    property GroupedAt               :TDateTime   read GetGroupedAt             write SetGroupedAt          ;
  end;


implementation


uses tcDataUtils, CommonLib, BusObjSales, AppEnvironment , SysUtils;



  {TSalesGroupedLines}

constructor TSalesGroupedLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesGroupedLines';
  fSQL := 'SELECT * FROM tblsalesgroupedlines';
end;


destructor TSalesGroupedLines.Destroy;
begin
  inherited;
end;


procedure TSalesGroupedLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SaleID');
  SetPropertyFromNode(node,'BOMProductionLineID');
  SetPropertyFromNode(node,'BOMGroupedLineID');
  SetPropertyFromNode(node,'EmployeeID');
  SetDateTimePropertyFromNode(node,'GroupedAt');
end;


procedure TSalesGroupedLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'BOMProductionLineID' ,BOMProductionLineID);
  AddXMLNode(node,'BOMGroupedLineID' ,BOMGroupedLineID);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'GroupedAt' ,GroupedAt);
end;


function TSalesGroupedLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SaleID should not be 0' , False );
    Exit;
  end;
  if BOMProductionLineID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'BOMProductionLineID should not be 0' , False );
    Exit;
  end;
  if BOMGroupedLineID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'BOMGroupedLineID should not be 0' , False );
    Exit;
  end;
  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TSalesGroupedLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesGroupedLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesGroupedLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSalesGroupedLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesGroupedLines.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSalesGroupedLines.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesgroupedlines';
end;


function TSalesGroupedLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  EmployeeId := Appenv.Employee.EmployeeID;
  if Assigned(Owner) then
    if Owner is TSales then
      SaleId := TSales(Self.Owner).ID;
end;

function TSalesGroupedLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TSalesGroupedLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not(result) then exit;
  if GroupedAt =0 then GroupedAt := now;
end;

{Property Functions}
function  TSalesGroupedLines.GetSaleID             : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  TSalesGroupedLines.GetBOMProductionLineID: Integer   ; begin Result := GetIntegerField('BOMProductionLineID');end;
function  TSalesGroupedLines.GetBOMGroupedLineID   : Integer   ; begin Result := GetIntegerField('BOMGroupedLineID');end;
function  TSalesGroupedLines.GetEmployeeID         : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TSalesGroupedLines.GetGroupedAt          : TDateTime ; begin Result := GetDateTimeField('GroupedAt');end;
procedure TSalesGroupedLines.SetSaleID             (const Value: Integer   ); begin SetIntegerField('SaleID'              , Value);end;
procedure TSalesGroupedLines.SetBOMProductionLineID(const Value: Integer   ); begin SetIntegerField('BOMProductionLineID' , Value);end;
procedure TSalesGroupedLines.SetBOMGroupedLineID   (const Value: Integer   ); begin SetIntegerField('BOMGroupedLineID'    , Value);end;
procedure TSalesGroupedLines.SetEmployeeID         (const Value: Integer   ); begin SetIntegerField('EmployeeID'          , Value);end;
procedure TSalesGroupedLines.SetGroupedAt          (const Value: TDateTime ); begin SetDateTimeField('GroupedAt'           , Value);end;


initialization
  RegisterClass(TSalesGroupedLines);


end.
