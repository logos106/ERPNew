unit frmHourlySalesReportConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, AppEvnts, ExtCtrls, Grids, BaseGrid, AdvGrid,
  StdCtrls, Shader, DNMSpeedButton, DNMPanel, DataTreeObj, AdvObj, Mask,
  AdvSpin, wwdbdatetimepicker;

type
  TfmHourlySalesReportConfig = class(TBaseForm)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    grdTimes: TAdvStringGrid;
    Label1: TLabel;
    DNMPanel2: TDNMPanel;
    Label2: TLabel;
    edttime: TwwDBDateTimePicker;
    btnPopulate: TDNMSpeedButton;
    Label3: TLabel;
    edtInt: TAdvSpinEdit;
    procedure grdTimesGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure grdTimesCanEditCell(Sender: TObject; ARow,
      ACol: Integer; var CanEdit: Boolean);
    procedure grdTimesGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure FormCreate(Sender: TObject);
    procedure grdTimesCellsChanged(Sender: TObject; R: TRect);
    procedure btnSaveClick(Sender: TObject);
    procedure btnPopulateClick(Sender: TObject);
  private
    fDirty: boolean;
    fNode: TDataTreeNode;
  public
    property Dirty: Boolean read fDirty write fDirty;
    procedure PopulateDefaults;
    function Validate: boolean;
    procedure Save(node: TDataTreeNode);
    procedure Load(node: TDataTreeNode);
    Class Procedure AutoPopulate(const node: TDataTreeNode);
  end;


implementation

{$R *.dfm}

uses
  CommonLib,dateutils;

procedure TfmHourlySalesReportConfig.grdTimesGetEditorType(
  Sender: TObject; ACol, ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  AEditor:= edTimeEdit;
end;

procedure TfmHourlySalesReportConfig.grdTimesCanEditCell(
  Sender: TObject; ARow, ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  CanEdit:= true;
end;

procedure TfmHourlySalesReportConfig.grdTimesGetEditMask(
  Sender: TObject; ACol, ARow: Integer; var Value: String);
begin
  inherited;
  Value:= '00:00';
end;

procedure TfmHourlySalesReportConfig.FormCreate(Sender: TObject);
begin
  inherited;
  grdTimes.DateTimePicker.Format:= 'HH:mm';
  grdTimes.Cells[0,0]:= 'Time From';
  grdTimes.Cells[1,0]:= 'Time To';
  edtTime.DateTime := date;
  //edtTime.text:= '12:00:00 AM';
  edtInt.Value:= 30;
end;

procedure TfmHourlySalesReportConfig.grdTimesCellsChanged(Sender: TObject;
  R: TRect);
begin
  inherited;
  fDirty:= True;
end;

procedure TfmHourlySalesReportConfig.PopulateDefaults;
var
  x: integer;
begin
  grdTimes.RemoveRows(3, grdTimes.RowCount-1);
  grdTimes.Cells[0,grdTimes.RowCount-1]:= FormatDateTime('hh:nn',EncodeTime(0,0,0,0));
  grdTimes.Cells[1,grdTimes.RowCount-1]:= FormatDateTime('hh:nn',EncodeTime(7,0,0,0));
  for x:= 7 to 18 do begin
//    if x > 7 then
    grdTimes.AddRow;
    grdTimes.Cells[0,grdTimes.RowCount-1]:= FormatDateTime('hh:nn',EncodeTime(x,0,0,0));
    grdTimes.Cells[1,grdTimes.RowCount-1]:= FormatDateTime('hh:nn',EncodeTime(x+1,0,0,0));
  end;
  grdTimes.AddRow;
  grdTimes.Cells[0,grdTimes.RowCount-1]:= FormatDateTime('hh:nn',EncodeTime(19,0,0,0));
  grdTimes.Cells[1,grdTimes.RowCount-1]:= FormatDateTime('hh:nn',EncodeTime(0,0,0,0));
end;

function TfmHourlySalesReportConfig.Validate: boolean;
var
  x: integer;
begin
  result:= true;
  for x:= 1 to grdTimes.RowCount -1 do begin
    if (grdTimes.Cells[0,x] = '') or (grdTimes.Cells[1,x] = '') then begin
      result:= false;
      CommonLib.MessageDlgXP_Vista('All cells must contain a value',mtInformation,[mbOk],0);
      grdTimes.Row:= x;
    end;
  end;
end;

class procedure TfmHourlySalesReportConfig.AutoPopulate(const node: TDataTreeNode);
begin
  With TfmHourlySalesReportConfig.Create(nil) do try
    Load(node);
    btnPopulate.Click;
    btnSave.Click;
  finally
    Free;
  end;
end;

procedure TfmHourlySalesReportConfig.btnPopulateClick(Sender: TObject);
var
  dt, dtCtr:TDatetime;
begin
  inherited;
  dt:= edttime.DateTime;
  dtCtr:= dt;
  grdTimes.Rowcount := grdTimes.Fixedrows;
  while (*dateof(dt) = dateof(dtctr)*) dtctr< incDay(dt,1) do begin
    grdTimes.Rowcount := grdTimes.Rowcount+1;
    grdTimes.cells[0, grdTimes.Rowcount-1] := formatDateTime('HH:NN:SS AM/PM' , dtctr);
    grdTimes.cells[1,grdTimes.Rowcount-1] := formatDateTime('HH:NN:SS AM/PM' , IncMinute(dtctr, edtInt.Value));
    dtctr := IncMinute(dtctr, edtInt.Value);
  end;
  //grdTimes.cells[1,grdTimes.Rowcount-1] := '23:59:59';
  Dirty:= True;
end;

procedure TfmHourlySalesReportConfig.btnSaveClick(Sender: TObject);
begin
  inherited;
  if (not Dirty) or Validate then begin
    if fDirty then
      Save(fNode);
    ModalResult:= mrOk;
  end;
end;

procedure TfmHourlySalesReportConfig.Save(node: TDataTreeNode);
var
  x: integer;
  subNode: TDataTreeNode;
begin
  node.DeleteChildren;
  for x:= 1 to grdTimes.RowCount-1 do begin
    subNode:= TDataTreeNode(node.AddNode('Row_'+IntToStr(x)));
    subNode['TimeFrom'].AsDateTime:= grdTimes.Times[0,x];
    subNode['TimeTo'].AsDateTime:= grdTimes.Times[1,x];
  end;
  fDirty:= False;
end;

procedure TfmHourlySalesReportConfig.Load(node: TDataTreeNode);
var
  x: integer;
begin
  fNode:= node;
  if node.Count > 0 then begin
    grdTimes.RemoveRows(3, grdTimes.RowCount-1);
    for x:= 0 to node.Count -1 do begin
      if x > 0 then grdTimes.AddRow;
      grdTimes.Times[0,grdTimes.RowCount-1]:= node.Items[x]['TimeFrom'].AsDateTime;
      grdTimes.Times[1,grdTimes.RowCount-1]:= node.Items[x]['TimeTo'].AsDateTime;
    end;
    fDirty:= false;
  end
  else
    PopulateDefaults;
end;

end.
