unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmMainBase, DB, DBAccess, MyAccess, StdCtrls, DNMSpeedButton,
  ExtCtrls, DAScript, MyScript, MemDS, ComCtrls, Grids, Wwdbigrd, Wwdbgrid;

type
  TfmMain = class(TfmMainBase)
    InvalidTrans: TMyQuery;
    ProgressBar: TProgressBar;
    dsInvalidTrans: TDataSource;
    grdInvalidTrans: TwwDBGrid;
  private
  protected
    function GetDescription: string; override;
    procedure StartUpdate; override;
//    function ConnectToServer: boolean; override;
    procedure UpdateDb(const Conn: TMyConnection); override;
    procedure UpdateBusobj; Override;
  public
  end;

var
  fmMain: TfmMain;

implementation

uses DLLConnectObj, fastfuncs, typinfo, DataUpdaterconfig, DataUpdateObj,
  Objects;

{$R *.dfm}

{ TfmMain }



function TfmMain.GetDescription: string;
begin
  result:= '';
end;

procedure TfmMain.StartUpdate;
begin
  inherited;
end;

procedure TfmMain.UpdateBusobj;
begin
  inherited;

end;

procedure TfmMain.UpdateDb(const Conn: TMyConnection);
begin
    inherited UpdateDb(Conn);
end;
end.
