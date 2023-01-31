unit frmConnectionTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls;

type
  TfmConnectionTest = class(TBaseInputGUI)
    Button1: TButton;
    memLog: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function NewConnection: TERPConnection;
  end;

var
  fmConnectionTest: TfmConnectionTest;

implementation

uses
  commondblib;

{$R *.dfm}

procedure TfmConnectionTest.Button1Click(Sender: TObject);
var
  x: integer;
  conn: TERPConnection;
begin
  inherited;
  for x := 1 to 10 do begin
    conn := NewConnection;
    try
      if conn.InTransaction then
        memLog.Lines.Add('New connection is IN TRANSACTIOn!')
      else
        memLog.Lines.Add('New connection ok.');


      conn.StartTransaction;
    finally
      conn.Free;
    end;

  end;
end;

procedure TfmConnectionTest.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TfmConnectionTest.NewConnection: TERPConnection;
begin
//  result := commondblib.GetNewMyDacConnection(nil);
  Result := TERPConnection.Create(nil);

  with GetSharedMyDACConnection do begin
    Result.LoginPrompt      := false;
    Result.Server           := Server;
    Result.Database         := Database;
    Result.Port             := Port;
    Result.Username         := Username;
    Result.Password         := Password;
    Result.Options.Compress := Options.Compress;
    Result.Options.Protocol := Options.Protocol;
    Result.Port             := Port;
    result.PoolingOptions.MaxPoolSize := 100;
    result.PoolingOptions.MinPoolSize := 1;
    result.PoolingOptions.ConnectionLifetime := 0;
    result.Pooling := true;
    Result.Open;
  end;
end;

initialization
  RegisterClass(TfmConnectionTest);

end.
