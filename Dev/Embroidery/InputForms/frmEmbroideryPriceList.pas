unit frmEmbroideryPriceList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/11/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, DB,
  DBAccess, MyAccess, ExtCtrls, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid,
  DNMPanel, MemDS, MyScript, DBGrids, StdCtrls, Shader;

type
  TEmbroideryPriceListGUI = class(TBaseInputGUI)
    dsMain: TDataSource;
    qryMain: TMyQuery;
    DNMPanel1: TDNMPanel;
    grdMain: TwwDBGrid;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnConfig: TDNMSpeedButton;
    qryAxes: TMyQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    procedure SetRowAndColumnLabels;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, FastFuncs;

{$R *.dfm}

procedure TEmbroideryPriceListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := False;
end;

procedure TEmbroideryPriceListGUI.btnConfigClick(Sender: TObject);
var
  EmbForm: TForm;
begin
  inherited;

  if CommonLib.MessageDlgXP_Vista('Any current changes will be saved before configuration. Continue?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if qryMain.State in [dsEdit, dsInsert] then
      qryMain.Post;

    CommitTransaction;
    EmbForm := TForm(GetComponentByClassName('TEmbroideryDropdownGUI'));

    if Assigned(EmbForm) then begin
      EmbForm.ShowModal;

      if EmbForm.ModalResult = mrOK then
        SetRowAndColumnLabels;

      EmbForm.Release;
    end;

    BeginTransaction;
  end;
end;


procedure TEmbroideryPriceListGUI.FormShow(Sender: TObject);
begin
  inherited;
  SetRowAndColumnLabels;
  BeginTransaction;
end;

procedure TEmbroideryPriceListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult in [mrNone, mrCancel] then begin
    inherited;
    RollbackTransaction;

    if fsModal in FormState then
      ModalResult := mrCancel
    else
      Action := caFree;
  end;    
end;

procedure TEmbroideryPriceListGUI.SetRowAndColumnLabels;
var
  Index: Integer;
  FieldCount: Integer;
  LabelCount: Integer;
  sctAdd: TMyScript;
begin
  qryMain.DisableControls;

  try
    qryAxes.ParamByName('AxisType').AsString := 'Row';
    qryAxes.Open;
    qryMain.Close;
    qryMain.ParamByName('RowLimit').AsInteger := qryAxes.RecordCount;;
    qryAxes.Close;
    qryAxes.ParamByName('AxisType').AsString := 'Column';
    qryAxes.Open;
    qryAxes.First;
    qryMain.Open;
    FieldCount := qryMain.FieldCount;
    LabelCount := qryAxes.RecordCount;
    qryMain.Close;

    if LabelCount > (FieldCount - 4) then begin
      sctAdd := TMyScript.Create(nil);

      try
        sctAdd.Connection := MyConnection;

        for Index := (FieldCount - 3) to LabelCount do begin
          sctAdd.SQL.Add('ALTER TABLE `tblembroiderypricelist` ADD COLUMN `Col' + FastFuncs.IntToStr(Index) +
                         '` double NULL;');
        end;

        sctAdd.Execute;
      finally
        FreeandNil(sctAdd);
      end;
    end;

    MyConnection.Disconnect;
    MyConnection.Connect;

    qryAxes.Open;
    qryMain.Open;
    FieldCount := qryMain.FieldCount;

    for Index := 0 to FieldCount - 1 do begin
      if (qryMain.Fields[Index].FieldName = 'EmbroideryPriceListID') or
         (qryMain.Fields[Index].FieldName = 'GlobalRef') or
         (qryMain.Fields[Index].FieldName = 'msTimeStamp') then begin
        qryMain.Fields[Index].Visible := False;
      end
      else if qryMain.Fields[Index].FieldName = 'RowHeader' then begin
        qryMain.Fields[Index].DisplayLabel := ' ';
        qryMain.Fields[Index].DisplayWidth := 10;
      end
      else begin
        if not qryAxes.Eof then begin
          qryMain.Fields[Index].DisplayLabel := qryAxes.FieldByName('AxisValue').AsString;
          TFloatField(qryMain.Fields[Index]).Currency := True;
          qryAxes.Next;
        end
        else
          qryMain.Fields[Index].Visible := False;
      end;
    end;

    qryAxes.Close;
    qryAxes.ParamByName('AxisType').AsString := 'Row';
    qryAxes.Open;
    qryAxes.First;
    LabelCount := qryAxes.RecordCount;

    while qryMain.RecordCount < LabelCount do begin
      qryMain.Append;
      qryMain.Post;
    end;

    qryMain.First;

    while (not qryMain.Eof) and (not qryAxes.Eof) do begin
      qryMain.Edit;
      qryMain.FieldByName('RowHeader').AsString := qryAxes.FieldByName('AxisValue').AsString;
      qryMain.Next;
      qryAxes.Next;
    end;

    qryMain.First;
    qryAxes.Close;
  finally
    qryMain.EnableControls;
  end;
end;

procedure TEmbroideryPriceListGUI.btnSaveClick(Sender: TObject);
begin
  inherited;

  if qryMain.State in [dsEdit, dsInsert] then
    qryMain.Post;

  CommitTransaction;

  if fsModal in FormState then
    ModalResult := mrOK
  else
    Release;
end;

procedure TEmbroideryPriceListGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

initialization
  RegisterClassOnce(TEmbroideryPriceListGUI);
finalization
  UnRegisterClass(TEmbroideryPriceListGUI);
end.
