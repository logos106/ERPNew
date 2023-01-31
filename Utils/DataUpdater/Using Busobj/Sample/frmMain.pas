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
    InvalidTransID: TIntegerField;
    InvalidTransTransID: TIntegerField;
    InvalidTransTranstype: TStringField;
    InvalidTransOHeader: TFloatField;
    InvalidTransOLines: TFloatField;
    InvalidTransPayment: TFloatField;
    InvalidTransNHEader: TFloatField;
    InvalidTransdescription: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  protected
    function GetDescription: string; override;
    function getcurVersion:String; override;
//    function ConnectToServer: boolean; override;
    procedure UpdateBusobj; Override;
  public
  end;

var
  fmMain: TfmMain;

implementation

uses DLLConnectObj, fastfuncs, typinfo, DataUpdateObj,
  Objects, DataUpdaterconfig;

{$R *.dfm}

{ TfmMain }
function TfmMain.GetDescription: string;
begin
  result:= '............................';
end;
function TfmMain.getcurVersion: String;
begin
  result :='7.4.3.9';
end;

procedure TfmMain.UpdateBusobj;
var
  ProductObj : TDLLProduct;
begin
  With getNewDataset('Select PartsID from tblParts where Parttype = "INV"') do try
    if recordcount = 0 then exit;
    first;
    ProductObj := TDLLProduct.create(DLLConnection, 'TProduct' , Self);
    TRy
      While Eof = False do begin
        ProductObj.RecalculateAvgcost(Fieldbyname('PartsID').asInteger;
        Next;
      end;
    finally
        FreeandNil(ProductObj);
    end;
  Finally
      if Active then close;
      Free;
  end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;


end.
