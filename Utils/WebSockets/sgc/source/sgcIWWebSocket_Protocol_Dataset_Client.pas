{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcIWWebSocket_Protocol_Dataset_Client;

interface

{$I sgcVer.inc}

{$IFDEF IWIX}

uses
  Classes,
  sgcIWWebSocket_Protocol_Base, DB,
  sgcWebSocket_Protocol_Dataset_Message, 
  sgcIWWebSocket_Protocol_sgc_Client;

type
  TsgcIWWSProtocol_Dataset_Client = class(TsgcIWWSProtocol_sgc_client)

  { TsgcWSMessageDataset }
  private
    FWSMessageDataset: TsgcWSMessageDataset;
    function GetWSMessageDataset: TsgcWSMessageDataset;
  protected
    property WSMessageDataset: TsgcWSMessageDataset read GetWSMessageDataset write
        FWSMessageDataset;
  { TsgcWSMessageDataset }

  { from TsgcWSComponent }
  protected
    procedure DoNotifyMessage(const aMessage: String); override;
  { from TsgcWSComponent }

  public
    constructor Create(aOwner: TComponent); override;

  { subscription }
  public
    procedure Subscribe_New;
    procedure Subscribe_Update;
    procedure Subscript_Delete;
  { subscription }

  { dataset }
  private
    FDataSet: TDataSet;
  protected
    procedure SetDataSet(const Value: TDataSet);
  public
    property DataSet: TDataSet read FDataSet write SetDataSet;

  { events }
  private
    FOnAfterDeleteRecord: TNotifyEvent;
    FOnAfterNewRecord: TNotifyEvent;
    FOnAfterUpdateRecord: TNotifyEvent;
  private
    procedure OnAfterNewRecordEvent(Sender: TObject);
    procedure OnAfterUpdateRecordEvent(Sender: TObject);
    procedure OnAfterDeleteRecordEvent(Sender: TObject);
  protected
    procedure DoAfterNewRecordEvent;
    procedure DoAfterUpdateRecordEvent;
    procedure DoAfterDeleteRecordEvent;
  published
    property OnAfterNewRecord: TNotifyEvent read FOnAfterNewRecord write
        FOnAfterNewRecord;
    property OnAfterUpdateRecord: TNotifyEvent read FOnAfterUpdateRecord write
        FOnAfterUpdateRecord;
    property OnAfterDeleteRecord: TNotifyEvent read FOnAfterDeleteRecord write
        FOnAfterDeleteRecord;
  { events }
  end;

{$ENDIF}

implementation

{$IFDEF IWIX}

uses sgcWebSocket_Const;

constructor TsgcIWWSProtocol_Dataset_Client.Create(aOwner: TComponent);
begin
  inherited;
  FProtocol := CS_PROTOCOL_DATASET;
end;

procedure TsgcIWWSProtocol_Dataset_Client.DoAfterDeleteRecordEvent;
begin
  if Assigned(FOnAfterDeleteRecord) then FOnAfterDeleteRecord(self);
end;

procedure TsgcIWWSProtocol_Dataset_Client.DoAfterNewRecordEvent;
begin
  if Assigned(FOnAfterNewRecord) then FOnAfterNewRecord(self);
end;

procedure TsgcIWWSProtocol_Dataset_Client.DoAfterUpdateRecordEvent;
begin
  if Assigned(FOnAfterUpdateRecord) then FOnAfterUpdateRecord(self);
end;

procedure TsgcIWWSProtocol_Dataset_Client.DoNotifyMessage(const aMessage:
    String);
begin
  WSMessage.Read(aMessage);
  if WSMessage.Method = CS_DATASET then
    WSMessageDataset.Read(aMessage)
  else
    inherited;
end;

function TsgcIWWSProtocol_Dataset_Client.GetWSMessageDataset:
    TsgcWSMessageDataset;
begin
  if not Assigned(FWSMessageDataset) then
  begin
    FWSMessageDataset := TsgcWSMessageDataset.Create(self);
    FWSMessageDataset.OnAfterNewRecord := OnAfterNewRecordEvent;
    FWSMessageDataset.OnAfterUpdateRecord := OnAfterUpdateRecordEvent;
    FWSMessageDataset.OnAfterDeleteRecord := OnAfterDeleteRecordEvent;
  end;
  Result := FWSMessageDataset;
end;

procedure TsgcIWWSProtocol_Dataset_Client.OnAfterDeleteRecordEvent(Sender:
    TObject);
begin
  DoAfterDeleteRecordEvent;
end;

procedure TsgcIWWSProtocol_Dataset_Client.OnAfterNewRecordEvent(Sender:
    TObject);
begin
  DoAfterNewRecordEvent;
end;

procedure TsgcIWWSProtocol_Dataset_Client.OnAfterUpdateRecordEvent(Sender:
    TObject);
begin
  DoAfterUpdateRecordEvent;
end;

procedure TsgcIWWSProtocol_Dataset_Client.SetDataSet(const Value: TDataSet);
begin
  if FDataSet <> Value then
  begin
    FDataSet := Value;
    WSMessageDataSet.DataSet := Value;
  end;
end;

procedure TsgcIWWSProtocol_Dataset_Client.Subscribe_New;
begin
  Subscribe(CS_SGC_DATASET_NEW);
end;

procedure TsgcIWWSProtocol_Dataset_Client.Subscribe_Update;
begin
  Subscribe(CS_SGC_DATASET_UPDATE);
end;

procedure TsgcIWWSProtocol_Dataset_Client.Subscript_Delete;
begin
  Subscribe(CS_SGC_DATASET_DELETE);
end;

{$ENDIF}

end.
