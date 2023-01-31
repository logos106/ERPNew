unit BusObjProcPickSlip;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  14/08/07  1.00.01  A  Initial Version.
  }


interface


uses BusObjBase, DB, Classes,  BusObjProcTreePart, ALXmlDoc;


type

  TProcPickSlipLine = class;

  TProcPickSlip = class(TMSBusObj)
  private
    function GetDate              : TDateTime ;
    function GetDescription       : string    ;
    procedure SetDate              (const Value: TDateTime );
    procedure SetDescription       (const Value: string    );
    function GetLines: TProcPickSlipLine;
    function ValidateLineData: boolean;
    function SaveLines: boolean;
    function GetPicked: boolean;
    procedure SetPicked(const Value: boolean);
    function GetPickType: string;
    procedure SetPickType(const Value: string);
  protected
    procedure OnDataIDChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    procedure InitializeNewObject; override;
    property PickType: string read GetPickType write SetPickType;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTableName: string; Override;
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: TALXMLNode);                  override;
    procedure    SaveToXMLNode(const node: TALXMLNode);                    override;
    function     ValidateData: Boolean ;                                 override;
    function     Save: Boolean ;                                         override;
    property Lines: TProcPickSlipLine read GetLines;
    procedure New; override;
    procedure PickAll; //virtual;
  published
    property Date               :TDateTime   read GetDate             write SetDate          ;
    property Description        :string      read GetDescription      write SetDescription   ;
    property Picked             : boolean    read GetPicked           write SetPicked ;
  end;

  TProcPickSlipLine = class(TMSBusObj)
  private
    function GetProcPickSlipId                : Integer   ;
    function GetProcTreeId                    : Integer   ;
    function GetSaleId                        : Integer   ;
    function GetSaleDocNumber                 : string    ;
    function GetSaleCustomerName              : string    ;
    function GetSaleShipDate                  : TDateTime ;
    function GetSaleLineId                    : Integer   ;
    function GetSaleLineProductName           : string    ;
    function GetSaleLineProductDescription    : string    ;
    function GetSaleLineQuantity              : Double    ;
    function GetStepDescription               : string    ;
    function GetItemCaption                   : string    ;
    function GetItemDescription               : string    ;
    function GetItemTotalQty                  : Double    ;
    function GetItemTotalQtyOriginal          : Double    ;
    function GetItemTotalQtyUsed              : Double    ;
    function GetItemPartId                    : Integer   ;
    function GetItemPartUom                   : string    ;
    procedure SetProcPickSlipId                (const Value: Integer   );
    procedure SetProcTreeId                    (const Value: Integer   );
    procedure SetSaleId                        (const Value: Integer   );
    procedure SetSaleDocNumber                 (const Value: string    );
    procedure SetSaleCustomerName              (const Value: string    );
    procedure SetSaleShipDate                  (const Value: TDateTime );
    procedure SetSaleLineId                    (const Value: Integer   );
    procedure SetSaleLineProductName           (const Value: string    );
    procedure SetSaleLineProductDescription    (const Value: string    );
    procedure SetSaleLineQuantity              (const Value: Double    );
    procedure SetStepDescription               (const Value: string    );
    procedure SetItemCaption                   (const Value: string    );
    procedure SetItemDescription               (const Value: string    );
    procedure SetItemTotalQty                  (const Value: Double    );
    procedure SetItemTotalQtyOriginal          (const Value: Double    );
    procedure SetItemTotalQtyUsed              (const Value: Double    );
    procedure SetItemPartId                    (const Value: Integer   );
    procedure SetItemPartUom                   (const Value: string    );
    function GetProcTreePart: TProcTreePart;
    function GetItemRoot: boolean;
    procedure SetItemRoot(const Value: boolean);
    function GetPickSlip: TProcPickSlip;
    function GetSaleLineShipDate: TDateTime;
    procedure SetSaleLineShipDate(const Value: TDateTime);
  protected
    procedure OnDataIDChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    procedure InitializeNewObject; override;
    property PickSlip: TProcPickSlip read GetPickSlip;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTableName: string; Override;
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: TALXMLNode);                  override;
    procedure    SaveToXMLNode(const node: TALXMLNode);                    override;
    function     ValidateData: Boolean ;                                 override;
    function     Save: Boolean ;                                         override;
    property ProcTreePart: TProcTreePart read GetProcTreePart;
    procedure New; override;
  published
    property ProcPickSlipId                 :Integer     read GetProcPickSlipId               write SetProcPickSlipId            ;
    property ProcTreeId                     :Integer     read GetProcTreeId                   write SetProcTreeId                ;
    property SaleId                         :Integer     read GetSaleId                       write SetSaleId                    ;
    property SaleDocNumber                  :string      read GetSaleDocNumber                write SetSaleDocNumber             ;
    property SaleCustomerName               :string      read GetSaleCustomerName             write SetSaleCustomerName          ;
    property SaleShipDate                   :TDateTime   read GetSaleShipDate                 write SetSaleShipDate               ;
    property SaleLineId                     :Integer     read GetSaleLineId                   write SetSaleLineId                ;
    property SaleLineProductName            :string      read GetSaleLineProductName          write SetSaleLineProductName       ;
    property SaleLineProductDescription     :string      read GetSaleLineProductDescription   write SetSaleLineProductDescription;
    property SaleLineQuantity               :Double      read GetSaleLineQuantity             write SetSaleLineQuantity          ;
    property SaleLineShipDate               :TDateTime   read GetSaleLineShipDate             write SetSaleLineShipDate               ;
    property StepDescription                :string      read GetStepDescription              write SetStepDescription           ;
    property ItemRoot                       :boolean     read GetItemRoot                     write SetItemRoot;
    property ItemCaption                    :string      read GetItemCaption                  write SetItemCaption               ;
    property ItemDescription                :string      read GetItemDescription              write SetItemDescription           ;
    property ItemTotalQty                   :Double      read GetItemTotalQty                 write SetItemTotalQty              ;
    property ItemTotalQtyOriginal           :Double      read GetItemTotalQtyOriginal         write SetItemTotalQtyOriginal      ;
    property ItemTotalQtyUsed               :Double      read GetItemTotalQtyUsed             write SetItemTotalQtyUsed          ;
    property ItemPartId                     :Integer     read GetItemPartId                   write SetItemPartId                ;
    property ItemPartUom                    :string      read GetItemPartUom                  write SetItemPartUom               ;
  end;

  TProcStowAwaySlip = class(TProcPickSlip)
  private
  protected
    procedure InitializeNewObject; override;
  public
    constructor  Create(AOwner: TComponent);                             override;
    procedure StowAll;
  published
  end;

implementation


uses
  tcDataUtils, CommonLib, sysutils, MyAccess, FastFuncs, BusObjConst,
  Dialogs, Controls, BusObjGeneral;



      {TProcPickSlip}

constructor TProcPickSlip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Production Picking Slip';
  fSQL := 'SELECT * FROM tblprocpickslip WHERE PickType = "Picking"';
end;


destructor TProcPickSlip.Destroy;
begin
  inherited;
end;


procedure TProcPickSlip.LoadFromXMLNode(const node: TALXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Date');
  SetPropertyFromNode(node,'Description');
  SetBooleanPropertyFromNode(node, 'Picked');

end;


procedure TProcPickSlip.SaveToXMLNode(Const node: TALXMLNode);
begin
  inherited;
  AddXMLNode(node,'Date' ,Date);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Picked' ,Picked);
end;


function TProcPickSlip.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := self.ValidateLineData;
end;


function TProcPickSlip.Save: Boolean ;
var
  msg: string;
begin
  Result := true;
  PostList.Clear;
  if not ValidateData then begin
    result:= false;
    Exit;
  end;
  if Picked and (not SilentMode) then begin
  Msg := Resultstatus.GetAllMessages(BOR_ProdQty_Warn , Chr(13));
  if Msg <> '' then
     result := CommonLib.MessageDlgXP_Vista('The following product(s) are Batch/Bin enabled and 0 allocation is made.' + chr(13)+
                            Msg + chr(13) + 'Do you wish to save them? ' , mtconfirmation , [mbYes, mbNo] , 0) = mrYes;
  end;
  if not result then exit;

  result:= self.SaveLines;
  if result then begin
    Result := inherited Save;
    if result then begin
      result:= PostList.Execute;
      self.UnLock;
    end;
  end;
end;


procedure TProcPickSlip.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcPickSlip.DoFieldOnChange(Sender: TField);
begin
  inherited;
  
end;


function TProcPickSlip.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcPickSlip.GetIDField: string;
begin
  Result := 'ProcPickSlipId'
end;

class function TProcPickSlip.GetBusObjectTableName: string;
begin
  Result := 'tblprocpickslip';
end;

function TProcPickSlip.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
function  TProcPickSlip.GetDate          : TDateTime ; begin Result := GetDateTimeField('Date');end;
function  TProcPickSlip.GetDescription   : string    ; begin Result := GetStringField('Description');end;
procedure TProcPickSlip.SetDate          (const Value: TDateTime ); begin SetDateTimeField('Date'           , Value);end;
procedure TProcPickSlip.SetDescription   (const Value: string    ); begin SetStringField('Description'    , Value);end;


function TProcPickSlip.GetLines: TProcPickSlipLine;
begin
  if Id < 1 then begin
    self.PostDb;
  end;
  if Id > 0 then
    self.ContainerList.DoSetId(Id);
  result:= TProcPickSlipLine(Container.ItemByClass(TProcPickSlipLine,false));
  if not Assigned(result) then begin
    result:= TProcPickSlipLine.Create(nil);
    Container.Add(result);
    result.Connection:= self.Connection;
    result.LoadSelect('ProcPickSlipId = ' + Fastfuncs.IntToStr(self.ID));
  end
  else begin
    if not result.DatasetActive then
      result.LoadSelect('ProcPickSlipId = ' + Fastfuncs.IntToStr(self.ID));
  end;
end;

function TProcPickSlip.SaveLines: boolean;
var
  bm: TBookMark;
begin
  result:= true;
  if Lines.Count > 0 then begin
    Lines.Dataset.DisableControls;
    bm:= Lines.Dataset.GetBookmark;
    try
      Lines.Dataset.First;
      while not Lines.Dataset.Eof do begin
        if Lines.Dirty then begin
          if not Lines.Save then begin
            result:= false;
            break;
          end;
        end;  
        Lines.Dataset.Next;
      end;
    finally
      Lines.Dataset.GotoBookmark(bm);
      Lines.Dataset.FreeBookmark(bm);
      Lines.Dataset.EnableControls;
    end;
  end;
end;

function TProcPickSlip.GetPicked: boolean;
begin
  result:= GetBooleanField('Picked');
end;

procedure TProcPickSlip.SetPicked(const Value: boolean);
begin
  SetBooleanField('Picked', Value);
end;

function TProcPickSlip.ValidateLineData: boolean;
var
  bm: TBookMark;
begin
  result:= true;
  if Lines.Count > 0 then begin
    Lines.Dataset.DisableControls;
    bm:= Lines.Dataset.GetBookmark;
    try
      Lines.Dataset.First;
      while not Lines.Dataset.Eof do begin
        if not Lines.ValidateData then begin
          result:= false;
          break;
        end;
        Lines.Dataset.Next;
      end;
    finally
      Lines.Dataset.GotoBookmark(bm);
      Lines.Dataset.FreeBookmark(bm);
      Lines.Dataset.EnableControls;
    end;
  end;
end;

procedure TProcPickSlip.InitializeNewObject;
begin
  inherited;
  PickType:= 'Picking';
end;

function TProcPickSlip.GetPickType: string;
begin
  result:= GetStringField('PickType');
end;

procedure TProcPickSlip.SetPickType(const Value: string);
begin
  SetStringField('PickType', Value);
end;

procedure TProcPickSlip.New;
begin
  inherited;
  self.InitializeNewObject;
end;

procedure TProcPickSlip.PickAll;
var
  bm: TBookmark;
begin
  Lines.Dataset.DisableControls;
  try
    bm:= Lines.Dataset.GetBookmark;
    Lines.DoFieldChangewhenDisabled:= true;
    try
      Lines.First;
      while not Lines.Dataset.Eof do begin
        Lines.ItemTotalQtyUsed:= Lines.ItemTotalQtyOriginal;
        Lines.PostDb;
        Lines.Next;
      end;
    finally
      Lines.DoFieldChangewhenDisabled:= false;
      Lines.Dataset.GotoBookmark(bm);
      Lines.Dataset.FreeBookmark(bm);
    end;
  finally
    Lines.Dataset.EnableControls;
  end;
  Picked:= true;
end;

{TProcPickSlipLine}

constructor TProcPickSlipLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Process Picking Slip Line';
  fSQL := 'SELECT * FROM tblprocpickslipline';
end;


destructor TProcPickSlipLine.Destroy;
begin
  inherited;
end;


procedure TProcPickSlipLine.LoadFromXMLNode(const node: TALXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProcPickSlipId');
  SetPropertyFromNode(node,'ProcTreeId');
  SetPropertyFromNode(node,'SaleId');
  SetPropertyFromNode(node,'SaleDocNumber');
  SetPropertyFromNode(node,'SaleCustomerName');
  SetPropertyFromNode(node,'SaleShipDate');
  SetPropertyFromNode(node,'SaleLineId');
  SetPropertyFromNode(node,'SaleLineProductName');
  SetPropertyFromNode(node,'SaleLineProductDescription');
  SetPropertyFromNode(node,'SaleLineQuantity');
  SetPropertyFromNode(node,'SaleLineShipDate');
  SetPropertyFromNode(node,'StepDescription');
  SetPropertyFromNode(node,'StepTimeStart');
  SetPropertyFromNode(node,'StepStatus');
  SetBooleanPropertyFromNode(node,'ItemRoot');
  SetPropertyFromNode(node,'ItemCaption');
  SetPropertyFromNode(node,'ItemDescription');
  SetPropertyFromNode(node,'ItemTotalQty');
  SetPropertyFromNode(node,'ItemTotalQtyOriginal');
  SetPropertyFromNode(node,'ItemTotalQtyUsed');
  SetPropertyFromNode(node,'ItemPartId');
  SetPropertyFromNode(node,'ItemPartUom');
end;


procedure TProcPickSlipLine.SaveToXMLNode(Const node: TALXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProcPickSlipId' ,ProcPickSlipId);
  AddXMLNode(node,'ProcTreeId' ,ProcTreeId);
  AddXMLNode(node,'SaleId' ,SaleId);
  AddXMLNode(node,'SaleDocNumber' ,SaleDocNumber);
  AddXMLNode(node,'SaleCustomerName' ,SaleCustomerName);
  AddXMLNode(node,'SaleShipDate' ,SaleShipDate);
  AddXMLNode(node,'SaleLineId' ,SaleLineId);
  AddXMLNode(node,'SaleLineProductName' ,SaleLineProductName);
  AddXMLNode(node,'SaleLineProductDescription' ,SaleLineProductDescription);
  AddXMLNode(node,'SaleLineQuantity' ,SaleLineQuantity);
  AddXMLNode(node,'SaleLineShipDate' ,SaleLineShipDate);
  AddXMLNode(node,'StepDescription' ,StepDescription);
  AddXMLNode(node,'ItemRoot' ,ItemRoot);
  AddXMLNode(node,'ItemCaption' ,ItemCaption);
  AddXMLNode(node,'ItemDescription' ,ItemDescription);
  AddXMLNode(node,'ItemTotalQty' ,ItemTotalQty);
  AddXMLNode(node,'ItemTotalQtyOriginal' ,ItemTotalQtyOriginal);
  AddXMLNode(node,'ItemTotalQtyUsed' ,ItemTotalQtyUsed);
  AddXMLNode(node,'ItemPartId' ,ItemPartId);
  AddXMLNode(node,'ItemPartUom' ,ItemPartUom);
end;


function TProcPickSlipLine.ValidateData: Boolean ;
begin
  Result := True;
  if Assigned(ProcTreePart) and (not ProcTreePart.ValidateData) then
    result:= false;
end;


function TProcPickSlipLine.Save: Boolean ;
var
  s: string;
begin
  Result := False;
  if not ValidateData then Exit;
  if Assigned(ProcTreePart) then begin
    if (not ProcTreePart.Save) then begin
      result:= false;
      exit;
    end
    else begin
      { update the tree node that is associated with this product }
      s:= 'UPDATE tblProcTree SET'+
        ' TotalQty = ' + FloatToStr(self.ItemTotalQty) +
        ', TotalQtyUsed = ' + FloatToStr(self.ItemTotalQtyUsed) +
        ' WHERE ProcTreeId = ' + Fastfuncs.IntToStr(self.ProcTreeId);
      self.PostList.AddQuery(s);
    end;
  end;

  Result := inherited Save;
end;


procedure TProcPickSlipLine.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcPickSlipLine.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

//  if Id < 1 then
//    InitializeNewObject;

  if FastFuncs.SameText(Sender.FieldName , 'ItemTotalQty') then begin
    if Assigned(ProcTreePart) then
      ProcTreePart.UOMQty:= Sender.AsFloat;
  end
//  else if FastFuncs.SameText(Sender.FieldName , 'ItemTotalQtyOriginal') then begin
//    if Assigned(ProcTreePart) then
//      ProcTreePart.UOMQtyOriginal:= Sender.AsFloat;
//  end
//  else if FastFuncs.SameText(Sender.FieldName , 'ItemTotalQtyUsed') then begin
//    if Assigned(ProcTreePart) then begin
//      ProcTreePart.UOMQtyUsed:= Sender.AsFloat;
//      ProcTreePart.UOMQty:= Sender.AsFloat;
//    end;
//  end
end;


function TProcPickSlipLine.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TProcPickSlipLine.GetIDField: string;
begin
  Result := 'ProcPickSlipLineId'
end;

class function TProcPickSlipLine.GetBusObjectTableName: string;
begin
  Result := 'tblprocpickslipline';
end;

function TProcPickSlipLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
function  TProcPickSlipLine.GetProcPickSlipId            : Integer   ; begin Result := GetIntegerField('ProcPickSlipId');end;
function  TProcPickSlipLine.GetProcTreeId                : Integer   ; begin Result := GetIntegerField('ProcTreeId');end;
function  TProcPickSlipLine.GetSaleId                    : Integer   ; begin Result := GetIntegerField('SaleId');end;
function  TProcPickSlipLine.GetSaleDocNumber             : string    ; begin Result := GetStringField('SaleDocNumber');end;
function  TProcPickSlipLine.GetSaleCustomerName          : string    ; begin Result := GetStringField('SaleCustomerName');end;
function  TProcPickSlipLine.GetSaleShipDate              : TDateTime ; begin Result := GetDateTimeField('SaleShipDate');end;
function  TProcPickSlipLine.GetSaleLineId                : Integer   ; begin Result := GetIntegerField('SaleLineId');end;
function  TProcPickSlipLine.GetSaleLineProductName       : string    ; begin Result := GetStringField('SaleLineProductName');end;
function  TProcPickSlipLine.GetSaleLineProductDescription: string    ; begin Result := GetStringField('SaleLineProductDescription');end;
function  TProcPickSlipLine.GetSaleLineQuantity          : Double    ; begin Result := GetFloatField('SaleLineQuantity');end;
function  TProcPickSlipLine.GetStepDescription           : string    ; begin Result := GetStringField('StepDescription');end;
function  TProcPickSlipLine.GetItemCaption               : string    ; begin Result := GetStringField('ItemCaption');end;
function  TProcPickSlipLine.GetItemDescription           : string    ; begin Result := GetStringField('ItemDescription');end;
function  TProcPickSlipLine.GetItemTotalQty              : Double    ; begin Result := GetFloatField('ItemTotalQty');end;
function  TProcPickSlipLine.GetItemTotalQtyOriginal      : Double    ; begin Result := GetFloatField('ItemTotalQtyOriginal');end;
function  TProcPickSlipLine.GetItemTotalQtyUsed          : Double    ; begin Result := GetFloatField('ItemTotalQtyUsed');end;
function  TProcPickSlipLine.GetItemPartId                : Integer   ; begin Result := GetIntegerField('ItemPartId');end;
function  TProcPickSlipLine.GetItemPartUom               : string    ; begin Result := GetStringField('ItemPartUom');end;
procedure TProcPickSlipLine.SetProcPickSlipId            (const Value: Integer   ); begin SetIntegerField('ProcPickSlipId'             , Value);end;
procedure TProcPickSlipLine.SetProcTreeId                (const Value: Integer   ); begin SetIntegerField('ProcTreeId'                 , Value);end;
procedure TProcPickSlipLine.SetSaleId                    (const Value: Integer   ); begin SetIntegerField('SaleId'                     , Value);end;
procedure TProcPickSlipLine.SetSaleDocNumber             (const Value: string    ); begin SetStringField('SaleDocNumber'              , Value);end;
procedure TProcPickSlipLine.SetSaleCustomerName          (const Value: string    ); begin SetStringField('SaleCustomerName'           , Value);end;
procedure TProcPickSlipLine.SetSaleShipDate              (const Value: TDateTime ); begin SetDateTimeField('SaleShipDate'             , Value);end;
procedure TProcPickSlipLine.SetSaleLineId                (const Value: Integer   ); begin SetIntegerField('SaleLineId'                 , Value);end;
procedure TProcPickSlipLine.SetSaleLineProductName       (const Value: string    ); begin SetStringField('SaleLineProductName'        , Value);end;
procedure TProcPickSlipLine.SetSaleLineProductDescription(const Value: string    ); begin SetStringField('SaleLineProductDescription' , Value);end;
procedure TProcPickSlipLine.SetSaleLineQuantity          (const Value: Double    ); begin SetFloatField('SaleLineQuantity'           , Value);end;
procedure TProcPickSlipLine.SetStepDescription           (const Value: string    ); begin SetStringField('StepDescription'            , Value);end;
procedure TProcPickSlipLine.SetItemCaption               (const Value: string    ); begin SetStringField('ItemCaption'                , Value);end;
procedure TProcPickSlipLine.SetItemDescription           (const Value: string    ); begin SetStringField('ItemDescription'            , Value);end;
procedure TProcPickSlipLine.SetItemTotalQty              (const Value: Double    ); begin SetFloatField('ItemTotalQty'               , Value);end;
procedure TProcPickSlipLine.SetItemTotalQtyOriginal      (const Value: Double    ); begin SetFloatField('ItemTotalQtyOriginal'       , Value);end;
procedure TProcPickSlipLine.SetItemTotalQtyUsed          (const Value: Double    ); begin SetFloatField('ItemTotalQtyUsed'           , Value);end;
procedure TProcPickSlipLine.SetItemPartId                (const Value: Integer   ); begin SetIntegerField('ItemPartId'                 , Value);end;
procedure TProcPickSlipLine.SetItemPartUom               (const Value: string    ); begin SetStringField('ItemPartUom'                , Value);end;
function TProcPickSlipLine.GetItemRoot                   : boolean   ; begin Result := GetBooleanField('ItemRoot'); end;
procedure TProcPickSlipLine.SetItemRoot                  (const Value: boolean   ); begin SetBooleanField('ItemRoot'                  , Value); end;



function TProcPickSlipLine.GetProcTreePart: TProcTreePart;
begin
  if self.ProcTreeId > 0 then begin
    result:= TProcTreePart(Container.ItemByClass(TProcTreePart,false));
    if not Assigned(result) then begin
      if self.Id < 1 then
        self.PostDb;
      result:= TProcTreePart.Create(nil);
      Container.Add(result);
      result.Connection:= self.Connection;
      result.LockGroupName:= self.LockGroupName;
//      if self.ItemRoot then
//        result.IN_OUT_Transtype:= 'PTB'   // IN
//      else
//        result.IN_OUT_Transtype:= 'PB';   // OUT
      result.LoadSelect('ProcTreeId = ' + Fastfuncs.IntToStr(ProcTreeId));
    end;
  end
  else
    result:= nil;
end;

procedure TProcPickSlipLine.InitializeNewObject;
begin
  inherited;
  self.ProcPickSlipId:= TProcPickSlip(Owner).Id;
  self.PostDb;
end;

function TProcPickSlipLine.GetPickSlip: TProcPickSlip;
begin
  if Assigned(owner) and (owner is TProcPickSlip) then
    result:= TProcPickSlip(Owner)
  else
    result:= nil;  
end;

function TProcPickSlipLine.GetSaleLineShipDate: TDateTime;
begin
  result:= GetDateTimeField('SaleLineShipDate');
end;

procedure TProcPickSlipLine.SetSaleLineShipDate(const Value: TDateTime);
begin
  SetDateTimeField('SaleLineShipDate', Value);
end;

procedure TProcPickSlipLine.New;
begin
  inherited;
  InitializeNewObject;
end;

{ TProcStowAwaySlip }

constructor TProcStowAwaySlip.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'Production Stow Away Slip';
  fSQL := 'SELECT * FROM tblprocpickslip WHERE PickType = "StowAway"';
end;

procedure TProcStowAwaySlip.InitializeNewObject;
begin
  PickType:= 'StowAway';
end;

procedure TProcStowAwaySlip.StowAll;
begin
  PickAll;
end;

initialization
  RegisterClassOnce(TProcPickSlip);
  RegisterClassOnce(TProcPickSlipLine);
  RegisterClassOnce(TProcStowAwaySlip);


end.

