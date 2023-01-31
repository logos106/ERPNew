unit frmPCCDipReading;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, Grids, Wwdbigrd,
  Wwdbgrid, StdCtrls, DNMSpeedButton, DNMPanel, MemDS, wwdbdatetimepicker,
  Mask, wwdbedit, wwdblook, wwcheckbox, Shader;

type
  TPCCDipReading = class(TBaseInputGUI)
    Bevel1: TBevel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    grdHoses: TwwDBGrid;
    qryDipReading: TMyQuery;
    qryDipReadingLines: TMyQuery;
    qryDipReadingTankNo: TIntegerField;
    qryDipReadingReadingDateTime: TDateTimeField;
    qryDipReadingDipReading: TIntegerField;
    qryDipReadingLinesPCCDipReadingLineID: TIntegerField;
    qryDipReadingLinesPCCDipReadingID: TIntegerField;
    qryDipReadingLinesHoseID: TIntegerField;
    qryDipReadingLinesHoseMeterReading: TLargeintField;
    dsDipReadingLines: TDataSource;
    wwDBEdit2: TwwDBEdit;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    dsDipReading: TDataSource;
    cboTankNo: TwwDBLookupCombo;
    qryTanks: TMyQuery;
    qryTanksTankNo: TIntegerField;
    qryTanksTankDescription: TStringField;
    qryDipReadingLinesDispenserNo: TIntegerField;
    qryDipReadingLinesHoseNo: TIntegerField;
    qryDipReadingPCCDipReadingID: TIntegerField;
    lblDesc: TLabel;
    cbActive: TwwCheckBox;
    qryDipReadingActive: TStringField;
    Label4: TLabel;
    Bevel2: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboTankNoCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdHosesDrawFooterCell(Sender: TObject; Canvas: TCanvas;
      FooterCellRect: TRect; Field: TField; FooterText: String;
      var DefaultDrawing: Boolean);
    procedure qryDipReadingLinesNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    fbAllowNewRecord : boolean;
    procedure InsertHoses(TankNo : integer);
    procedure RemoveHoses;
  public
    { Public declarations }
  end;

var
  PCCDipReading: TPCCDipReading;

implementation

uses FormFactory, CommonDbLib, CommonLib;

{$R *.dfm}

procedure TPCCDipReading.FormCreate(Sender: TObject);
begin
  inherited;
  wwDBDateTimePicker1.DisplayFormat := ShortDateFormat + ' ' + LongTimeFormat;
  fbAllowNewRecord := false;
end;

procedure TPCCDipReading.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPCCDipReading.btnOKClick(Sender: TObject);
begin
  if qryDipReading.State in [dsEdit, dsInsert] then begin
    qryDipReading.Post;
  end;
  CommitTransaction;
  Notify;
  inherited;
  Close;
end;

procedure TPCCDipReading.btnCancelClick(Sender: TObject);
begin
  inherited;
  //qryDipReading.Cancel;
  if (CommonLib.MessageDlgXP_Vista('Are you sure you want to cancel all changes?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    RollbackTransaction;
  end;
  Close;
end;

procedure TPCCDipReading.FormShow(Sender: TObject);
begin
  inherited;
  qryDipReading.ParamByName('PCCDipReadingID').AsInteger := KeyID;
  qryDipReadingLines.ParamByName('PCCDipReadingID').AsInteger := KeyID;
  OpenQueries;
  BeginTransaction;
  if KeyID = 0 then begin
    qryDipReading.Insert;
      qryDipReading.FieldByName('ReadingDateTime').AsDateTime := Now;
      qryDipReading.FieldByName('Active').AsBoolean := True;
    qryDipReading.Post;
    KeyID := qryDipReading.FieldByName('PCCDipReadingID').AsInteger;
  end
  else begin
    cboTankNo.Enabled := false;
    qryDipReading.Edit;
    qryTanks.Locate('TankNo',VarArrayOf([qryDipReading.FieldByName('TankNo').AsInteger]),[]);
    lblDesc.Caption := qryTanks.FieldByName('TankDescription').AsString;
  end;
end;

procedure TPCCDipReading.InsertHoses(TankNo : integer);
Var qry : TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.Text := 'SELECT HoseID ' +
                    ' FROM tblPCCHoses H'+
                    ' LEFT JOIN tblPCCTanks Using(TankID)' +
                    ' WHERE TankNo = :TankNo';
    qry.ParamByName('TankNo').AsInteger := TankNo;
    qry.Open;
    fbAllowNewRecord := true;
    while not qry.Eof do begin
      qryDipReadingLines.Insert;
      qryDipReadingLines.FieldByName('HoseID').AsInteger := qry.FieldByName('HoseID').AsInteger;
      qryDipReadingLines.FieldByName('PCCDipReadingID').AsInteger := KeyID;
      qryDipReadingLines.Post;
      qry.Next;
    end;
    fbAllowNewRecord := false;
    qryDipReadingLines.Close;
    qryDipReadingLines.ParamByName('PCCDipReadingID').AsInteger := KeyID;
    qryDipReadingLines.Open;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPCCDipReading.cboTankNoCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  lblDesc.Caption := qryTanks.FieldByName('TankDescription').AsString;
  RemoveHoses;
  InsertHoses(FillTable.FieldByName('TankNo').AsInteger);
end;

procedure TPCCDipReading.RemoveHoses;
begin
  while not qryDipReadingLines.Eof do begin
    qryDipReadingLines.Delete;
  end;
end;

procedure TPCCDipReading.grdHosesDrawFooterCell(Sender: TObject;
  Canvas: TCanvas; FooterCellRect: TRect; Field: TField;
  FooterText: String; var DefaultDrawing: Boolean);
begin
  inherited;
  grdHoses.ColumnByName('HoseMeterReading').FooterValue := 'Test';
end;

procedure TPCCDipReading.qryDipReadingLinesNewRecord(DataSet: TDataSet);
begin
  inherited;
  if not fbAllowNewRecord then DataSet.Cancel;
end;

initialization
  RegisterClassOnce(TPCCDipReading);
  FormFact.RegisterMe(TPCCDipReading, 'TPCCDipReadingList_*=PCCDipReadingID');

end.
