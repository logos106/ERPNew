unit frmATOPayEventErrors;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, DNMPanel, Grids, AdvObj, BaseGrid, AdvGrid, ConTnrs;

type
  TfmATOPayEventErrors = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCancel: TDNMSpeedButton;
    grdData: TAdvStringGrid;
    memDesc: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdDataSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    fErrorList: TObjectList;
    function GetErrorList: TObjectList;
    procedure SetErrorList(const Value: TObjectList);
    procedure LoadGrid;
    procedure ResizeGrid;
  public
    property ErrorList: TObjectList read GetErrorList write SetErrorList;
  end;

  procedure ShowPayEventErrors(aErrorList: TObjectList);

implementation

uses
  BusObjPayRun;

procedure ShowPayEventErrors(aErrorList: TObjectList);
var
  form: TfmATOPayEventErrors;
begin
  form := TfmATOPayEventErrors.Create(Application);
  form.ErrorList := aErrorList;
//  form.Show;
  form.FormStyle := fsMDIChild ;
  form.BringToFront;
end;



{$R *.dfm}

procedure TfmATOPayEventErrors.ResizeGrid;
begin
  grdData.ColWidths[3] := grdData.Width - grdData.ColWidths[0] - grdData.ColWidths[1] - grdData.ColWidths[2] -10;
end;

procedure TfmATOPayEventErrors.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmATOPayEventErrors.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmATOPayEventErrors.FormCreate(Sender: TObject);
begin
  inherited;
  fErrorList := TObjectList.Create;
  grdData.ColWidths[0] := 100; // employee name
  grdData.ColWidths[1] := 70;  // severity code
  grdData.ColWidths[2] := 140;  // location
  grdData.ColWidths[3] := 200;  // desc

end;

procedure TfmATOPayEventErrors.FormDestroy(Sender: TObject);
begin
  inherited;
  fErrorList.Free;
end;

procedure TfmATOPayEventErrors.FormResize(Sender: TObject);
begin
  inherited;
  ResizeGrid;
end;

procedure TfmATOPayEventErrors.FormShow(Sender: TObject);
begin
  inherited;
  ResizeGrid;
end;

function TfmATOPayEventErrors.GetErrorList: TObjectList;
begin
  result := fErrorList;
end;

procedure TfmATOPayEventErrors.grdDataSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  memDesc.Text := grdData.Cells[3,ARow];
end;

procedure TfmATOPayEventErrors.LoadGrid;
var
  I: Integer;
  item: TErrorItem;
begin
  grdData.RowCount := 1;
  for I := 0 to ErrorList.Count -1 do begin
    grdData.RowCount := grdData.RowCount + 1;
    item := TErrorItem(ErrorList[I]);
    grdData.Cells[0,I+1] := item.EmployeeName;
    grdData.Cells[1,I+1] := item.SeverityCode;
    grdData.Cells[2,I+1] := item.ErrorLocation;
    grdData.Cells[3,I+1] := item.ErrorMessage;
  end;
  if grdData.RowCount > 1 then
    grdData.FixedRows := 1;
end;

procedure TfmATOPayEventErrors.SetErrorList(const Value: TObjectList);
var
  item: TErrorItem;
  I: integer;
begin
  fErrorList.Clear;
  for I := 0 to Value.Count -1 do begin
    item := TErrorItem.Create;
    item.Assign(TErrorItem(Value.Items[I]));
    fErrorList.Add(item);
  end;
  LoadGrid;
end;

end.
