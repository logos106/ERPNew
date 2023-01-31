unit frmEmbroiderySelection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid,
  ExtCtrls, DNMPanel, DB, MemDS, DBAccess, MyAccess, MessageConst, 
  BaseInputForm, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, Buttons,
  StdCtrls, Shader;

type
  TEmbroiderySelectionGUI = class(TBaseInputGUI)
    grdMain: TwwDBGrid;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    qryMain: TMyQuery;
    dsMain: TDataSource;
    qryMainProductName: TStringField;
    grdMainIButton: TwwIButton;
    qryMainProductID: TIntegerField;
    qryMainQty: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure grdMainIButtonClick(Sender: TObject);
  private
    fSourceDataSet: TDataSet;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  public
    { Public declarations }
  end;

implementation

uses
  tcTypes, CommonLib;

{$R *.dfm}

{ TEmbroiderySelectionGUI }

procedure TEmbroiderySelectionGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := False;
end;

procedure TEmbroiderySelectionGUI.PerformStartup(var Msg: TMessage);
begin
  fSourceDataSet := PEmbroideryData(Msg.WParam).DataSet;
  qryMain.Connection := PEmbroideryData(Msg.WParam).Connection;
  qryMain.ParamByName('SaleID').asInteger := Msg.LParam;
  qryMain.Open;

  if qryMain.IsEmpty then
    ModalResult := mrCancel
  else
    grdMain.SelectAll;
end;

procedure TEmbroiderySelectionGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if ModalResult in [mrNone, mrCancel] then begin
    if fsModal in FormState then
      ModalResult := mrCancel
    else
      Action := caFree;
  end;
end;

procedure TEmbroiderySelectionGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TEmbroiderySelectionGUI.btnSaveClick(Sender: TObject);
var
  Index: Integer;
begin
  inherited;
  Hide;

  for Index := 0 to grdMain.SelectedList.Count - 1 do begin
    qryMain.GotoBookmark(grdMain.SelectedList[Index]);
    fSourceDataSet.Append;
    fSourceDataSet.FieldByName('ProductName').AsString := qryMain.FieldByName('ProductName').AsString;
    fSourceDataSet.FieldByName('ProductID').AsInteger := qryMain.FieldByName('ProductID').AsInteger;
    fSourceDataSet.FieldByName('Qty').AsInteger := qryMain.FieldByName('Qty').AsInteger;
    fSourceDataSet.Post;
  end;

  fSourceDataSet.First;

  if fsModal in FormState then
    ModalResult := mrOK
  else
    Release;
end;

procedure TEmbroiderySelectionGUI.grdMainIButtonClick(Sender: TObject);
begin
  inherited;

  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    qryMain.Delete;
end;

initialization
  RegisterClassOnce(TEmbroiderySelectionGUI);
finalization
  UnRegisterClass(TEmbroiderySelectionGUI);
end.
