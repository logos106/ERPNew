{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_Dataset_Server;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils, DB,
  sgcWebSocket_Protocol_sgc_Message, sgcWebSocket_Protocol_dataset_message,
  sgcWebSocket_Protocol_sgc_server, sgcWebSocket_HTTPResponse,
  sgcWebSocket_Classes;

type


  TsgcWSProtocol_dataset_server = class(TsgcWSProtocol_sgc_server)

  { TsgcWSMessageDataset }
  private
    FWSMessageDataset: TsgcWSMessageDataset;
    function GetWSMessageDataset: TsgcWSMessageDataset;
  protected
    property WSMessageDataset: TsgcWSMessageDataset read GetWSMessageDataset write
        FWSMessageDataset;
  { TsgcWSMessageDataset }

  { events }
  private
    FDSBeforePost: TDataSetNotifyEvent;
    FDSBeforeDelete: TDataSetNotifyEvent;
  protected
    procedure OnUpdateRecordEvent(Sender: TDataSet); virtual;
    procedure OnDeleteRecordEvent(Sender: TDataSet); virtual;
  { events }

  { from sgcWebSocket_Protocol_sgc }
  protected
    procedure DoBroadCast(aMessage: TsgcWSMessage; const aChannel: String; const
        Exclude: String = ''; const Include: String = ''); override;
  { from sgcWebSocket_Protocol_sgc }

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

  { dataset }
  private
    FDataSet: TDataSet;
  protected
    procedure SetDataSet(const Value: TDataSet);
  public
    property DataSet: TDataSet read FDataSet write SetDataSet;
  { dataset }
  end;



  TsgcWSProtocol_JS_dataset = class(TsgcWSHTTPResponse_Base)
  protected
    function GetResponse: string; override;
  public
    class function GetFileName: string; override;
  end;


  TsgcWSProtocol_HTML_dataset = class(TsgcWSHTTPResponse_Base)
  protected
    function GetResponse: string; override;
  public
    class function GetFileName: string; override;
  end;


implementation

uses sgcWebSocket_Helpers, sgcWebSocket_Const, sgcWebsocket_Resources;

function TsgcWSProtocol_JS_dataset.GetResponse: string;
begin
  result := GetResourceString('SGC_JS_DATASET_ESEGECE_COM');
end;

class function TsgcWSProtocol_JS_dataset.GetFileName: string;
begin
  Result := 'dataset.esegece.com.js';
end;

constructor TsgcWSProtocol_dataset_server.Create(aOwner: TComponent);
begin
  inherited;
  FProtocol := CS_PROTOCOL_DATASET;
end;

destructor TsgcWSProtocol_dataset_server.Destroy;
begin
  FDataset := nil;
  inherited;
end;

procedure TsgcWSProtocol_dataset_server.DoBroadCast(aMessage: TsgcWSMessage;
    const aChannel: String; const Exclude: String = ''; const Include: String =
    '');
begin
  WSMessage.DoEnterWrite;

  WSMessageDataSet.Method := CS_SGC_DATASET;
  WSMessageDataSet.Channel := aChannel;
  WSMessageDataSet.Guid := Guid;
  WSMessageDataSet.Text := '';
  inherited;
end;

function TsgcWSProtocol_dataset_server.GetWSMessageDataset:
    TsgcWSMessageDataset;
begin
  if not Assigned(FWSMessageDataset) then
    FWSMessageDataset := TsgcWSMessageDataset.Create(self);
  Result := FWSMessageDataset;
end;

procedure TsgcWSProtocol_dataset_server.OnUpdateRecordEvent(Sender: TDataSet);
begin
  if Assigned(FDSBeforePost) then FDSBeforePost(Sender);
  if Sender.State in [dsInsert] then
    DoBroadCast(WSMessageDataSet, CS_SGC_DATASET_NEW)
  else
    DoBroadCast(WSMessageDataSet, CS_SGC_DATASET_UPDATE);
end;

procedure TsgcWSProtocol_dataset_server.OnDeleteRecordEvent(Sender: TDataSet);
begin
  if Assigned(FDSBeforeDelete) then FDSBeforeDelete(Sender);
  DoBroadCast(WSMessageDataSet, CS_SGC_DATASET_DELETE);
end;

procedure TsgcWSProtocol_dataset_server.SetDataSet(const Value: TDataSet);
begin
  if FDataSet <> Value then
  begin
    FDataSet := Value;
    FDSBeforePost := FDataSet.AfterPost;
    FDSBeforeDelete := FDataSet.BeforeDelete;
    FDataSet.BeforePost := OnUpdateRecordEvent;
    FDataSet.BeforeDelete := OnDeleteRecordEvent;

    WSMessageDataset.DataSet := Value;
  end;
end;

class function TsgcWSProtocol_HTML_dataset.GetFileName: string;
begin
  Result := 'dataset.esegece.com.html';
end;

function TsgcWSProtocol_HTML_dataset.GetResponse: string;
begin
  result := GetResourceString('SGC_HTML_DATASET_ESEGECE_COM');
end;

initialization
  TsgcWSHTTPResponse.RegisterfileName(TsgcWSProtocol_JS_dataset);
  TsgcWSHTTPResponse.RegisterfileName(TsgcWSProtocol_HTML_dataset);

end.
