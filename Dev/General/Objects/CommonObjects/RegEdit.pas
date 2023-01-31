unit RegEdit;

interface

uses Registry, classes(*, BusObjBase, DB,  XMLDoc, XMLIntf*);

const
  OPOSRegPath= 'SOFTWARE\OLEforRetail\ServiceOPOS\';




(*type
  TBusobjRegEdit = class(TMSBusObj)
  private
    function GetKeyName     : string    ;
    function GetRegName     : string    ;
    function GetRegValue    : string    ;
    procedure SetKeyName     (const Value: string    );
    procedure SetRegName     (const Value: string    );
    procedure SetRegValue    (const Value: string    );
    procedure XMLCallback(const Sender: TBusObj; var Abort: boolean);
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
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property KeyName      :string      read GetKeyName    write SetKeyName ;
    property RegName      :string      read GetRegName    write SetRegName ;
    property RegValue     :string      read GetRegValue   write SetRegValue;
  end;*)


 type
  pRegEntryItem = ^TRegEntry;

  TRegEntry= record
    ID          : Integer;
    ParentID    : Integer;
    Level       : Integer;
    Key         : String;
    Name        : String;
    Value       : String;
    RegDataType : TRegDataType;
    RegItemType : Integer;
  end;


  TRegEdit = class(Tcomponent)
    Private
      ID:Integer;
      procedure populate(KeyName: String; Level, ParentID: Integer;pRegEntries: TList;ReadSubKeys:boolean);
      function NewId:Integer;

    Public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function ReadLocalMachineRegistry(KeyName:String;ReadSubKeys:boolean):TList;Overload;
      function ReadLocalMachineRegistry(KeyName:String;SubKey:String):String;Overload;
      Procedure SavetoRegistry(pathname, Keyname,Data:String);
  end;

function COMPorts:String;
Function ReadLocalmachineRegistryValues(KeyPath:String):String;

Function isExcelInstalled:Boolean;
Function IsAppinstalled(Const aAppname:String):Boolean;


implementation
uses windows, sysutils, DNMLib, tcDataUtils, CommonLib;


Function isExcelInstalled:Boolean;
begin
  result := IsAppinstalled('Excel');
end;
Function IsAppinstalled(Const aAppname:String):Boolean;
const
  UNINST_PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall';
var
  Registry: TRegistry;
  Keys: TStrings;
  Key: string;
  AppName: string;
begin
  Result := False;
  Registry := TRegistry.Create;
  Registry.RootKey := HKEY_LOCAL_MACHINE;
  if Registry.OpenKeyReadOnly(UNINST_PATH) then begin
    Keys := TStringList.Create;
    try
      Registry.GetKeyNames(Keys);
      Registry.CloseKey();
      for Key in Keys do begin
        if Registry.OpenKeyReadOnly(Format('%s\%s', [UNINST_PATH, Key])) then begin
          try
            AppName := Registry.ReadString('DisplayName');
            Result := Pos(AnsiUpperCase(aAppname), AnsiUpperCase(AppName)) > 0;
            if Result then Break;
          finally
            Registry.CloseKey();
          end;
        end;
      end;
    finally
      Keys.Free();
    end;
  end;
end;


{ TRegEdit }
constructor TRegEdit.Create(AOwner: TComponent);
begin
  inherited;

end;
Function ReadLocalmachineRegistryValues(KeyPath:String):String;
var
  reg: TRegistry;
  ValueNames: TstringList;
  i: Integer;
begin
  result := '';
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey(KeyPath, False);
    ValueNames := TstringList.Create;
        try
          reg.GetValueNames(ValueNames);
          if ValueNames.Count>0 then
            for i := 0 to ValueNames.Count - 1 do
              if ValueNames[i]<>'' then begin
                if result <>'' then result := result +',';
                result := result +reg.ReadString(ValueNames[i]);
              end;
        finally
          ValueNames.Free;
        end;
    reg.CloseKey;
  finally
    reg.Free;
  end;
end;

Function Comports:string;
begin
    result :=  ReadLocalmachineRegistryValues( 'hardware\devicemap\serialcomm');
end;


destructor TRegEdit.Destroy;
begin
  inherited;
end;

function TRegEdit.NewId: Integer;
begin
  ID:= ID+1;
  result := Id;
end;

function TRegEdit.ReadLocalMachineRegistry(KeyName: String;ReadSubKeys:boolean): TList;
var
  pRegEntries: TList;
begin
  pRegEntries          := TList.Create;
  ID:=0;
  populate(KeyNAme,1 , Id, pRegEntries,ReadSubKeys);
  result :=pRegEntries;
end;
procedure TRegEdit.SavetoRegistry(pathname, Keyname, Data: String);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey(pathname, False);
    if reg.GetDataType(Keyname) in [rdString, rdExpandString] then begin
      if not(Sametext(reg.ReadString(Keyname), Data)) then  begin
        reg.WriteString(Keyname , Data);
      end;
    end else if reg.GetDataType(Keyname) in [rdInteger] then
      if IsInteger(data) then
        if reg.ReadInteger(Keyname)<> strtoInt(Data) then begin
          reg.WriteInteger(Keyname , strtoInt(Data));
        end;
  finally
     reg.Free;
  end;
end;

procedure TRegEdit.populate(KeyName:String;Level:Integer;ParentID:Integer;pRegEntries: TList;ReadSubKeys:boolean);
var
  RegEntryItem: pRegEntryItem;    // line item list
  reg: TRegistry;
  ValueNames,KeyNames: Tstrings;
  i: Integer;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey(KeyName, False);
    KeyNames := TstringList.Create;
    try
      reg.GetKeyNames(KeyNames);
      if KeyNames.Count> 0 then begin
        for i := 0 to KeyNames.Count - 1 do begin
          New(RegEntryItem);
          RegEntryItem^.ID:= NewId;
          RegEntryItem^.ParentID:= ParentID;
          RegEntryItem^.Level:= Level;
          RegEntryItem^.Key:= KeyName+'\'+KeyNames[i];
          RegEntryItem^.Name:=KeyNames[i];
          RegEntryItem^.RegItemType:= 1;
          pRegEntries.Add(RegEntryItem);
          if ReadSubKeys then
            populate(RegEntryItem^.Key,Level+1 , Id, pRegEntries, ReadSubKeys);
        end;
      end else begin
        ValueNames := TstringList.Create;
        try
          reg.GetValueNames(ValueNames);
          if ValueNames.Count>0 then begin
            for i := 0 to ValueNames.Count - 1 do begin
              if ValueNames[i]<>'' then begin
                New(RegEntryItem);
                RegEntryItem^.ID:= NewId;
                RegEntryItem^.ParentID:= ParentID;
                RegEntryItem^.Level:= Level;
                RegEntryItem^.Key:= KeyName+'\'+ValueNames[i];
                RegEntryItem^.Name:=ValueNames[i];
                RegEntryItem^.RegDataType:=reg.GetDataType(RegEntryItem^.Name);
                RegEntryItem^.Value:= reg.ReadString(RegEntryItem^.Name);
                RegEntryItem^.RegItemType:= 2;
                pRegEntries.Add(RegEntryItem);
              end;
            end;
          end;
        finally
          ValueNames.Free;
        end;
      end;
    finally
      KeyNames.Free;
    end;
    reg.CloseKey;
  finally
    reg.Free;
  end;
end;
function TRegEdit.ReadLocalMachineRegistry(KeyName: String;subkey:String): String;
var
  reg: TRegistry;
  ValueNames:TStringlist;
  i:Integer;
begin
  REsult:= '';
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey(KeyName, False);
    ValueNames := TstringList.Create;
    try
      reg.GetValueNames(ValueNames);
      if ValueNames.Count>0 then begin
        for i := 0 to ValueNames.Count - 1 do begin
          if ValueNames[i]<>'' then begin
            if sameText(ValueNames[i] , subkey) then begin
              REsult := reg.ReadString(Subkey);
              Exit;
            end;
          end;
        end;
      end;
    finally
      ValueNames.Free;
    end;
    reg.CloseKey;
  finally
    reg.Free;
  end;

end;

(*  {TBusobjRegEdit}

constructor TBusobjRegEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Regedit';
  fSQL := 'SELECT * FROM tbltmp_regedit';
end;

destructor TBusobjRegEdit.Destroy;
begin
  inherited;
end;

procedure TBusobjRegEdit.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node,'KeyName');
  SetPropertyFromNode(node,'RegName');
  SetPropertyFromNode(node,'RegValue');
end;

procedure TBusobjRegEdit.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  self.XMLPropertyNode := node;
  self.XMLPropertyName:= XMLNodeName;
  self.IterateRecords(XMLCallback);
end;

procedure TBusobjRegEdit.XMLCallback(const Sender: TBusObj; var Abort: boolean);
var
    aNode :IXMLNode;
begin
  aNode :=TBusObj(Sender).XMLPropertyNode;
  aNode := anode.AddChild(XMLNodeName);
  AddXMLNode(aNode,'KeyName' ,KeyName);
  AddXMLNode(aNode,'RegName' ,RegName);
  AddXMLNode(aNode,'RegValue' ,RegValue);
end;

function TBusobjRegEdit.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TBusobjRegEdit.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TBusobjRegEdit.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TBusobjRegEdit.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TBusobjRegEdit.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TBusobjRegEdit.GetIDField: string;
begin
  Result := 'ID'
end;

class function TBusobjRegEdit.GetBusObjectTablename: string;
begin
  Result:= 'tmp_regedit';
end;

function TBusobjRegEdit.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TBusobjRegEdit.GetKeyName : string    ; begin Result := GetStringField('KeyName');end;
function  TBusobjRegEdit.GetRegName : string    ; begin Result := GetStringField('RegName');end;
function  TBusobjRegEdit.GetRegValue: string    ; begin Result := GetStringField('RegValue');end;
procedure TBusobjRegEdit.SetKeyName (const Value: string    ); begin SetStringField('KeyName' , Value);end;
procedure TBusobjRegEdit.SetRegName (const Value: string    ); begin SetStringField('RegName' , Value);end;
procedure TBusobjRegEdit.SetRegValue(const Value: string    ); begin SetStringField( 'RegValue', Value);end;*)

initialization
(*  commonlib.RegisterClassOnce(TBusobjRegEdit);*)
end.
