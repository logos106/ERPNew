unit BusObjEmployeePic;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/05/08  1.00.01  A.  Initial Version.
}

interface

{$I ERP.inc}

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TEmployeePicture = class(TMSBusObj)
  private
    fPictureStream: TStream;
    Function GetEmployeeID: Integer;
    Procedure SetEmployeeID(const Value: Integer);
    Function GetEncodedPic: string;
    Procedure SetEncodedPic(const Value: String);
    function GetPictureStream: TStream;
    function GetEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    Procedure DoFieldOnChange(Sender: TField); override;
    Function GetSQL: string; override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  Public
    Class Function GetIDField: string; override;
    Class Function GetBusObjectTablename: string; override;
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    Procedure LoadFromXMLNode(const node: IXMLNode); override;
    Procedure SaveToXMLNode(const node: IXMLNode); override;
    Function ValidateData: Boolean; override;
    Function Save: Boolean; override;
    property PictureStream: TStream read GetPictureStream;
  Published
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property EncodedPic: String read GetEncodedPic write SetEncodedPic;
  end;

implementation

uses SysUtils, IdCoder3to4,
  IdCoderMIME, IdCoder, BusObjConst, BusObjEmployee, LogLib;

{ TEmployeePicture }

Constructor TEmployeePicture.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'employeepics';
  fSQL := 'SELECT * FROM tblemployeepics';
end;

Destructor TEmployeePicture.Destroy;
begin
  FreeAndNil(fPictureStream);
  inherited;
end;

function TEmployeePicture.GetPictureStream: TStream;
var
  fld: TField;
begin
  result := nil;
  if Assigned(Dataset) and Dataset.Active then begin
    if not Assigned(fPictureStream) then begin
      fld := Dataset.FieldByName('EmployeePic');
      if (Dataset.State in [dsEdit, dsInsert]) then
        fPictureStream := Dataset.CreateBlobStream(TBlobField(fld), bmReadWrite)
      else
        fPictureStream := Dataset.CreateBlobStream(TBlobField(fld), bmRead);
    end;
    result := fPictureStream;
  end;
end;

Function TEmployeePicture.GetEncodedPic: string;
var
  EncodeMime: TIdEncoderMIME;
begin
  result := '';
  if dsReadOk then begin
    EncodeMime := TIdEncoderMIME.Create(nil);
    try
      PictureStream;
      if Assigned(fPictureStream) then
        fPictureStream.Seek(0, 0);
      result := EncodeMime.Encode(Self.PictureStream);
      clog(result , 'i:\temp\to be deleted\emp_'+trim(inttostr(id))+'.txt');
    finally
      EncodeMime.Free;
    end;
  end;
end;

Procedure TEmployeePicture.SetEncodedPic(const Value: String);
var
  DecoderMIME: TIdDecoderMIME;
begin
  if dsWriteOK then begin
    DecoderMIME := TIdDecoderMIME.Create(nil);
    try
      PictureStream;
      if Assigned(fPictureStream) then
        fPictureStream.Seek(0, 0);
{$IFDEF COMPILER_22_UP}
      DecoderMIME.DecodeBegin(PictureStream);
      try
        DecoderMIME.Decode(Value);
      finally
        DecoderMIME.DecodeEnd;
      end;
{$ELSE}
      DecoderMIME.DecodeToStream(Value, PictureStream);
{$ENDIF}
    PostDB;
    finally
      FreeAndNil(DecoderMIME);
    end;
  end;
end;

Procedure TEmployeePicture.LoadFromXMLNode(const node: IXMLNode);

begin
  inherited;
  SetPropertyFromNode(node, 'EmployeeID');
  SetPropertyFromNode(node, 'encodedpic');
end;

Procedure TEmployeePicture.SaveToXMLNode(Const node: IXMLNode);
begin
  // AddXMLBlobNode(node,'EncodedPic' ,EncodedPic);
  inherited;
  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLCDataNode(node, 'EncodedPic', EncodedPic);
end;

Function TEmployeePicture.ValidateData: Boolean;
var
  tmpResultStatus: TResultStatusItem;
begin
  result := False;
  Resultstatus.Clear;
  Try
    if EmployeeID = 0 then begin
      Resultstatus.AddItem(False, rssError, 0, 'EmployeeID should not be 0');
      Exit;
    end;
    result := true;
  Finally
    If not result then Begin
      tmpResultStatus := Resultstatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),
          BusobjEventVal_FailedPhoto_IDValidateData);
    end;
  end;
end;

Function TEmployeePicture.Save: Boolean;
begin
  result := False;
  if not ValidateData then
    Exit;
  result := inherited Save;
end;

Procedure TEmployeePicture.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  FreeAndNil(fPictureStream);
end;

Procedure TEmployeePicture.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

Function TEmployeePicture.GetSQL: string;
begin
  result := inherited GetSQL;
end;

Class Function TEmployeePicture.GetIDField: string;
begin
  result := 'EmployeePicID'
end;

Class Function TEmployeePicture.GetBusObjectTablename: string;
begin
  result := 'tblemployeepics';
end;

Function TEmployeePicture.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
Function TEmployeePicture.GetEmployeeID: Integer;
begin
  result := GetIntegerField('EmployeeID');
end;

function TEmployeePicture.GetEmployeeName: string;
begin
  result := TEmployee.IDToggle(EmployeeID, Connection.Connection);
end;

Procedure TEmployeePicture.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TEmployeePicture.SetEmployeeName(const Value: string);
begin
  EmployeeID := TEmployee.IDToggle(Value, Connection.Connection);
end;

initialization

RegisterClass(TEmployeePicture);

end.
