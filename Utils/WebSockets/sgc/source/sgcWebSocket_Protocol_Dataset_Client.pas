{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_Dataset_Client;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils, DB,
  sgcWebSocket_Protocol_sgc_Client,
  sgcWebSocket_Protocol_dataset_message, sgcWebSocket_HTTPResponse,
  sgcWebSocket_Classes;

type

  TsgcWSProtocol_dataset_client = class(TsgcWSProtocol_sgc_client)

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
    procedure DoEventConnect(aConnection: TsgcWSConnection); override;
    procedure DoEventMessage(aConnection: TsgcWSConnection; const Text: string);
        override;
    procedure DoEventDisconnect(aConnection: TsgcWSConnection; aCode: Integer);
        override;
  { from TsgcWSComponent }

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

  { subscription }
  private
    FAutoSubscribe: Boolean;
  public
    procedure Subscribe_all;
    procedure UnSubscribe_all;
  public
    property AutoSubscribe: Boolean read FAutoSubscribe write FAutoSubscribe;
  { subscription }

  { dataset }
  private
    FDataSet: TDataSet;
  protected
    procedure SetDataSet(const Value: TDataSet);
  public
    property DataSet: TDataSet read FDataSet write SetDataSet;
  { dataset }

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
  public
    property OnAfterNewRecord: TNotifyEvent read FOnAfterNewRecord write
        FOnAfterNewRecord;
    property OnAfterUpdateRecord: TNotifyEvent read FOnAfterUpdateRecord write
        FOnAfterUpdateRecord;
    property OnAfterDeleteRecord: TNotifyEvent read FOnAfterDeleteRecord write
        FOnAfterDeleteRecord;
  { events }
  end;


implementation

uses sgcWebSocket_Helpers, sgcWebSocket_Const;

constructor TsgcWSProtocol_dataset_client.Create(aOwner: TComponent);
begin
  inherited;
  FProtocol := CS_PROTOCOL_DATASET;
//  AutoSubscribe := True;
end;

destructor TsgcWSProtocol_dataset_client.Destroy;
begin
  FDataset := nil;
  inherited;
end;

procedure TsgcWSProtocol_dataset_client.DoAfterDeleteRecordEvent;
begin
  if Assigned(FOnAfterDeleteRecord) then FOnAfterDeleteRecord(self);
end;

procedure TsgcWSProtocol_dataset_client.DoAfterNewRecordEvent;
begin
  if Assigned(FOnAfterNewRecord) then FOnAfterNewRecord(self);
end;

procedure TsgcWSProtocol_dataset_client.DoAfterUpdateRecordEvent;
begin
  if Assigned(FOnAfterUpdateRecord) then FOnAfterUpdateRecord(self);
end;

procedure TsgcWSProtocol_dataset_client.DoEventConnect(aConnection:
    TsgcWSConnection);
begin
  inherited;
  if AutoSubscribe then
    Subscribe_all;
end;

procedure TsgcWSProtocol_dataset_client.DoEventDisconnect(aConnection:
    TsgcWSConnection; aCode: Integer);
begin
//  Dataset := nil;
  inherited;
end;

procedure TsgcWSProtocol_dataset_client.DoEventMessage(aConnection:
    TsgcWSConnection; const Text: string);
begin
  WSMessage.Read(Text);
  if WSMessage.Method = CS_SGC_DATASET then
    WSMessageDataset.Read(Text)
  else
    inherited;
end;

function TsgcWSProtocol_dataset_client.GetWSMessageDataset:
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

procedure TsgcWSProtocol_dataset_client.OnAfterDeleteRecordEvent(Sender:
    TObject);
begin
  DoAfterDeleteRecordEvent;
end;

procedure TsgcWSProtocol_dataset_client.OnAfterNewRecordEvent(Sender: TObject);
begin
  DoAfterNewRecordEvent;
end;

procedure TsgcWSProtocol_dataset_client.OnAfterUpdateRecordEvent(Sender:
    TObject);
begin
  DoAfterUpdateRecordEvent;
end;

procedure TsgcWSProtocol_dataset_client.SetDataSet(const Value: TDataSet);
begin
  if FDataSet <> Value then
  begin
    FDataSet := Value;
    WSMessageDataSet.DataSet := Value;
  end;
end;

procedure TsgcWSProtocol_dataset_client.Subscribe_all;
begin
  subscribe(CS_SGC_DATASET_NEW);
  subscribe(CS_SGC_DATASET_UPDATE);
  subscribe(CS_SGC_DATASET_DELETE);
end;

procedure TsgcWSProtocol_dataset_client.UnSubscribe_all;
begin
  unsubscribe(CS_SGC_DATASET_NEW);
  unsubscribe(CS_SGC_DATASET_UPDATE);
  unsubscribe(CS_SGC_DATASET_DELETE);
end;

end.
