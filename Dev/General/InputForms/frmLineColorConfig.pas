unit frmLineColorConfig;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 27/11/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, DB,
  DBAccess, MyAccess,ERPdbComponents, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, MemDS, DNMPanel,
  DNMSpeedButton, MessageConst, StdCtrls, Shader, ImgList;

type
  TLineColorConfigGUI = class(TBaseInputGUI)
    dsMain: TDataSource;
    qryMain: TERPQuery;
    grdMain: TwwDBGrid;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryMainListLineColorID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainGroupType: TWideStringField;
    qryMainText: TWideStringField;
    qryMainColor: TIntegerField;
    qryMainmsTimeStamp: TDateTimeField;
    ColorDialog: TColorDialog;
    Label1: TLabel;
    qryMainActive: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure grdMainDblClick(Sender: TObject);
    procedure grdMainColEnter(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
  private
    fGroupType: string;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  public
    { Public declarations }
  end;

implementation

uses FastFuncs,CommonLib;

{$R *.dfm}

procedure TLineColorConfigGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fGroupType := '';
end;

procedure TLineColorConfigGUI.grdMainDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
var
  TmpRect: TRect;
begin
  inherited;

  if Sysutils.SameText(Field.FieldName, 'Color') then begin
    grdMain.Canvas.Brush.Color := Field.Value;
    grdMain.Canvas.FillRect(Rect);
  end
  else begin
    TmpRect := Rect;
    grdMain.Canvas.FillRect(TmpRect);
    TmpRect.Left := TmpRect.Left + 1;
    DrawText(grdMain.Canvas.Handle, PChar(Field.AsString), -1, TmpRect, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
  end;
end;

procedure TLineColorConfigGUI.grdMainDblClick(Sender: TObject);
begin
  inherited;

  if grdMain.GetActiveCol in [1, 2] then begin
    if not qryMain.IsEmpty then
      ColorDialog.Color := qryMain.FieldByName('Color').AsInteger;

    if ColorDialog.Execute then begin
      if qryMain.IsEmpty then
        qryMain.Append
      else
        qryMain.Edit;

      qryMain.FieldByName('GroupType').AsString := fGroupType;
      qryMain.FieldByName('Color').AsInteger := ColorDialog.Color;
    end;
  end;  
end;

procedure TLineColorConfigGUI.grdMainColEnter(Sender: TObject);
begin
  inherited;

  if Sysutils.SameText(grdMain.GetActiveField.FieldName, 'Color') then
    grdMain.Options := grdMain.Options - [dgEditing]
  else
    grdMain.Options := grdMain.Options + [dgEditing];
end;

procedure TLineColorConfigGUI.PerformStartup(var Msg: TMessage);
begin
  if Msg.WParam > 0 then begin
    Caption := string((Ptr(Msg.WParam))^);
    TitleLabel.Caption := Caption;
  end;

  if Msg.LParam > 0 then begin
    fGroupType := string((Ptr(Msg.LParam))^);
    qryMain.ParamByName('GroupType').AsString := fGroupType;
  end;

  qryMain.Open;
  BeginTransaction;
end;

procedure TLineColorConfigGUI.btnSaveClick(Sender: TObject);
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

procedure TLineColorConfigGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if ModalResult in [mrNone, mrCancel] then begin
    RollbackTransaction;
    
    if fsModal in FormState then
      ModalResult := mrCancel
    else
      Action := caFree;
  end;
end;

procedure TLineColorConfigGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

initialization
  RegisterClassOnce(TLineColorConfigGUI);
finalization
  UnRegisterClass(TLineColorConfigGUI);
end.
