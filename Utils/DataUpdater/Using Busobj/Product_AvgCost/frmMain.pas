unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmMainBase, DB, DBAccess, MyAccess, StdCtrls, DNMSpeedButton,
  ExtCtrls, DAScript, MyScript, MemDS, ComCtrls, Grids, Wwdbigrd, Wwdbgrid, Progressdialog;

type
  TfmMain = class(TfmMainBase)
    grdInvalidTrans: TwwDBGrid;
    InvalidTrans: TMyQuery;
    InvalidTransPartsId: TSmallintField;
    InvalidTransPartName: TStringField;
    InvalidTranstmp_7489Fix_AvgCost: TFloatField;
    InvalidTransAvgCost: TFloatField;
    dsInvalidTrans: TDataSource;
    Label2: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure btnStartUpdateClick(Sender: TObject);
    procedure grdInvalidTransCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure memLogDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    ProgDialog:TProgressdialog;

    Procedure tmp_7489Fix_AvgCost;
  protected
    procedure UpdateDb(const Conn: TMyConnection); Override;
    function GetDescription: string; override;
    function getcurVersion:String; override;
    Procedure updateFormConnection;override;
    procedure Log(const msg: string); override;
//    function ConnectToServer: boolean; override;
    procedure UpdateBusobj; Override;
  public
  end;

var
  fmMain: TfmMain;

implementation

uses DLLConnectObj, fastfuncs, typinfo, DataUpdateObj,
  Objects, DataUpdaterconfig ;

{$R *.dfm}

{ TfmMain }
function TfmMain.GetDescription: string;
begin
  result:= 'Reclaulating Product''s Average Cost'+ chr(13) +'Version '+getcurVersion ;
end;
function TfmMain.getcurVersion: String;
begin
  result :='7.4.9.0';
end;

procedure TfmMain.UpdateBusobj;
var
  StrSQL:String;
  TempQry:TMyquery;
    AvgCostbeforecalc:Double;
    AvgCostAftercalc:Double;
begin
  tmp_7489Fix_AvgCost;
    StrSQL:= 'Select PartsId, Partname  from tblParts WHERE PARTTYPE ="INV" order by PartsId';

    TempQry := getNewDataset(strSQL) ;
    try
        if TempQry.recordcount = 0 then exit;
        TempQry.First;
        ProgDialog:=TProgressdialog.create(nil);
        ProgDialog.Message := 'Please Wait....';
        ProgDialog.MaxValue := TempQry.recordcount;
        ProgDialog.minValue:= 0;
        ProgDialog.Value :=0;
        ProgDialog.ShowPercent:= False;
        ProgDialog.Step:= 1;
        ProgDialog.Execute;
        try
            While TempQry.Eof = False do begin
              With TDLLProduct.create(DLLConnection, 'TProduct' , self) do try
                AvgCostbeforecalc  :=0;
                AvgCostAftercalc:= 0;
                RecalculateAvgcost(TempQry.fieldByname('PartsId').asInteger ,AvgCostbeforecalc  ,AvgCostAftercalc );
                if grdInvalidTrans.visible then begin
                  if InvalidTrans.active then InvalidTrans.close;
                  InvalidTrans.Open;
                  InvalidTrans.Last;
                  grdInvalidTrans.refresh;
                end;
              finally
                Free;
              end;
              TempQry.Next;
              ProgDialog.stepit;
              ProgDialog.Message:= 'Updating :' +fastfuncs.inttoStr(Tempqry.Recno) +' of ' +FastFuncs.intToStr(TempQry.recordcount) ;
              ProgDialog.refresh;
            end;
        finally
            ProgDialog.CloseDialog;
        end;
    finally
        if TempQry.active then TempQry.close;
        FreeandNil(TempQry);
    end;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
try
  inherited;
except
  on E:Exception do begin
    //ShowMessage(E.Message);
  end;
end;

end;


procedure TfmMain.updateFormConnection;
begin
  if InvalidTrans.active then InvalidTrans.close;
  inherited;
end;

procedure TfmMain.btnStartUpdateClick(Sender: TObject);
begin
try
  inherited;
  application.ProcessMessages;
  Self.Close;
Except
  on E:Exception do begin
     //ShowMessage(E.Message);
  end;
end;


end;

procedure TfmMain.tmp_7489Fix_AvgCost;
var
  StrSQL:String;
begin
  StrSQL:= 'Alter table tblparts Add column tmp_7489Fix_AvgCost Float;';
  try
    Execute(strSQL);
  Except
    // kill the exception   if the field is already added
  end;
  strSQL:= 'update tblparts Set tmp_7489Fix_AvgCost = Avgcost;';
  Execute(strSQL);
end;

procedure TfmMain.grdInvalidTransCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if InvalidTransAvgCost.asFloat  <> InvalidTranstmp_7489Fix_AvgCost.asFloat then
    AFont.color := clred;
end;

procedure TfmMain.memLogDblClick(Sender: TObject);
var
  s:String;
begin
  inherited;

end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  inherited;
  if grdInvalidTrans.visible = False then begin
    MemLog.width := 840;
  end else begin
    MemLog.width :=336;
  end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
try
  inherited;
  application.ProcessMessages;
except
    on E:Exception do begin
      //ShowMessage(E.Message);
    end;
end;
end;

procedure TfmMain.Log(const msg: string);
begin
  inherited;

end;

procedure TfmMain.UpdateDb(const Conn: TMyConnection);
begin
  inherited;

end;


end.
