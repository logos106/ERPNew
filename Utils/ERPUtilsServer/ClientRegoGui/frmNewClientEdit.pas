unit frmNewClientEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseEdit, DB, DBAccess, MyAccess, ActnList, StdCtrls, ExtCtrls,
  PanelTreeObj, JsonObject;

type
  TfmNewClientEdit = class(TfmBaseEdit)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  private
    fKeyId: integer;
    Tree: TPanelTree;
    Data: TJsonObject;
    Headings: TJsonObject;
    procedure LoadTree;
  protected
    function GetKeyId: integer; override;
    procedure SetKeyId(const Value: integer); override;
  public
  end;

var
  fmNewClientEdit: TfmNewClientEdit;

implementation

uses
  JsonToDatasetFuncs, ClientUtils, JsonObjectUtils,
  fraHeading, fraClient, fraServer, fraLicence, fraServerConfig, fraCompanyDatabase;

{$R *.dfm}

{ TfmNewClientEdit }

procedure TfmNewClientEdit.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmNewClientEdit.actOkExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfmNewClientEdit.FormCreate(Sender: TObject);
begin
  inherited;
  Data := TJsonObject.Create;
  Headings := TJsonObject.Create;
  Headings.O['Servers'].S['Name'] := 'Servers';
  Headings.O['Licences'].S['Name'] := 'Licences';
  Headings.O['Config'].S['Name'] := 'Configurations';
  Headings.O['Db'].S['Name'] := 'Databases';
  Tree := TPanelTree.Create(self);
  Tree.Parent := self;
  Tree.Align := alClient;
end;

procedure TfmNewClientEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  JsonToFileFormated(Data,'c:\temp\temp.txt');
  Data.Free;
  Headings.Free;
end;

function TfmNewClientEdit.GetKeyId: integer;
begin
  result := fKeyId;
end;

procedure TfmNewClientEdit.LoadTree;
var
//  qry: TMyQuery;
  server, licence, config, db: TJsonObject;
  serverIdx, licenceIdx, configIdx, dbIdx: integer;
  ServerHeadingNode, LicenceHeadingNode, ConfigHeadingNode, DbHeadingNode: TTreePanelNode;
  ClientNode, ServerNode, LicenceNode{, DbNode}: TTreePanelNode;
begin
  Tree.Clear;
  LoadClient(fKeyId,Data,TransConnection);
  ClientNode := Tree.AddNode(TfrClient, Data);
  ServerHeadingNode := Tree.AddNode(TfrHeading,Headings.O['Servers'],ClientNode);
  for serverIdx := 0 to Data.A['server'].Count -1 do begin
    server := Data.A['server'].Items[serverIdx].AsObject;
    ServerNode := Tree.AddNode(TfrServer,server,ServerHeadingNode);
    LicenceHeadingNode := Tree.AddNode(TfrHeading,Headings.O['Licences'],ServerNode);
    for licenceIdx := 0 to server.A['Licence'].Count -1 do begin
      licence := server.A['Licence'].Items[licenceIdx].AsObject;
      LicenceNode := Tree.AddNode(TfrLicence,licence,LicenceHeadingNode);
      DbHeadingNode := Tree.AddNode(TfrHeading,Headings.O['Db'],LicenceNode);
      for dbIdx := 0 to licence.A['Database'].Count -1 do begin
        db := licence.A['Database'].Items[dbIdx].AsObject;
        Tree.AddNode(TfrCompanyDatabase,db,DbHeadingNode);
      end;
    end;
    ConfigHeadingNode := Tree.AddNode(TfrHeading,Headings.O['Config'],ServerNode);
    for configIdx := 0 to server.A['Config'].Count -1 do begin
      config := server.A['Config'].Items[configIdx].AsObject;
      Tree.AddNode(TfrServerConfig,config,ConfigHeadingNode);
    end;
  end;
end;

procedure TfmNewClientEdit.SetKeyId(const Value: integer);
begin
  inherited;
  fKeyId := Value;
  if TransConnection.InTransaction then
    TransConnection.Rollback;
//  qryConfig.Close;
//  qryClient.Close;
//  qryClient.ParamByName('KeyID').AsInteger:= Value;
//  qryClient.Open;
//  if Value = 0 then
//    qryClient.Insert;
//  qryServers.ParamByName('clientid').AsInteger:= qryClient.FieldByName('id').AsInteger;
//  qryServers.Open;

  LoadTree;

  TransConnection.StartTransaction;

end;

initialization
  RegisterClass(TfmNewClientEdit);


end.
