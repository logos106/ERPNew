unit frmEmbroideryPosition;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 14/11/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, DB,
  DBAccess, MyAccess, ExtCtrls, DNMPanel, DNMSpeedButton, StdCtrls, Mask,
  wwdbedit, MemDS, ExtDlgs, MessageConst, DBCtrls, Shader;

type
  TEmbroideryPositionGUI = class(TBaseInputGUI)
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    edtPosition: TwwDBEdit;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    qryPosition: TMyQuery;
    qryPositionEmbroideryPositionID: TIntegerField;
    qryPositionGlobalRef: TStringField;
    qryPositionDescription: TStringField;
    qryPositionImage: TBlobField;
    qryPositionmsTimeStamp: TDateTimeField;
    dsPosition: TDataSource;
    dlgImage: TOpenPictureDialog;
    btnLoadPic: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    imgPosition: TDBImage;
    btnClearPicture: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnLoadPicClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNewClick(Sender: TObject);
    procedure btnClearPictureClick(Sender: TObject);
  private
    fSourceHandle: THandle;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    function ConfirmStorage: Boolean;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, JPeg, FastFuncs;

{$R *.dfm}

procedure TEmbroideryPositionGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fSourceHandle := 0;
end;

procedure TEmbroideryPositionGUI.btnLoadPicClick(Sender: TObject);
var
  Bitmap: TBitmap;
  JPegImage: TJPegImage;
begin
  inherited;

  if dlgImage.Execute then begin
    Update;
    
    if FileExists(dlgImage.FileName) then begin
      if FastFuncs.SameText(ExtractFileExt(dlgImage.FileName), '.bmp') then begin
        TBlobField(qryPosition.FieldByName('Image')).LoadFromFile(dlgImage.FileName);

        if ConfirmStorage then
          imgPosition.Show
        else
          imgPosition.Hide;
      end
      else begin
        Bitmap := TBitmap.Create;
        JPegImage := TJPegImage.Create;

        try
          JPegImage.LoadFromFile(dlgImage.FileName);
          Bitmap.Assign(JPegImage);
          TBlobField(qryPosition.FieldByName('Image')).Assign(Bitmap);

          if ConfirmStorage then
            imgPosition.Show
          else
            imgPosition.Hide;
        finally
          FreeandNil(Bitmap);
          FreeandNil(JPegImage);
        end;
      end;
    end;
  end;
end;

procedure TEmbroideryPositionGUI.PerformStartup(var Msg: TMessage);
begin
  BeginTransaction;
  fSourceHandle := Msg.LParam;
  qryPosition.ParamByName('EmbroideryPositionID').AsInteger := Msg.WParam;
  qryPosition.Open;
  qryPosition.Edit;

  if Msg.WParam = 0 then
    qryPosition.Append
  else if (not qryPosition.IsEmpty) and (TBlobField(qryPosition.FieldByName('Image')).BlobSize > 0) then
    imgPosition.Show;
end;

procedure TEmbroideryPositionGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TEmbroideryPositionGUI.btnSaveClick(Sender: TObject);
begin
  inherited;

  if qryPosition.State in [dsEdit, dsInsert] then begin
    if (not Empty(qryPosition.FieldByName('Description').AsString)) or
       (TBlobField(qryPosition.FieldByName('Image')).BlobSize > 0) then
      qryPosition.Post;
  end;

  CommitTransaction;

  if fSourceHandle > 0 then
    PostMessage(fSourceHandle, TX_PerformRefresh, 0, 0);

  if fsModal in FormState then
    ModalResult := mrOK
  else
    Release;
end;

procedure TEmbroideryPositionGUI.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TEmbroideryPositionGUI.btnNewClick(Sender: TObject);
begin
  inherited;

  if (not Empty(qryPosition.FieldByName('Description').AsString)) or
     (TBlobField(qryPosition.FieldByName('Image')).BlobSize > 0) then begin
    imgPosition.Hide;

    if qryPosition.State in [dsEdit, dsInsert] then
      qryPosition.Post;

    qryPosition.Append;
  end;

  SetControlFocus(edtPosition);
end;

function TEmbroideryPositionGUI.ConfirmStorage: Boolean;
begin
  Result := True;

  if TBlobField(qryPosition.FieldByName('Image')).BlobSize > 300000 then begin
    if CommonLib.MessageDlgXP_Vista('This picture is large (more than 300k) and may slow processing. Use anyway?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
      TBlobField(qryPosition.FieldByName('Image')).AsVariant := Null;
      Result := False;
    end;
  end;
end;

procedure TEmbroideryPositionGUI.btnClearPictureClick(Sender: TObject);
begin
  inherited;

  if (not qryPosition.IsEmpty) and (TBlobField(qryPosition.FieldByName('Image')).AsVariant <> Null) then begin
    if CommonLib.MessageDlgXP_Vista('Clear this picture?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        qryPosition.Edit;
        imgPosition.Hide;
        TBlobField(qryPosition.FieldByName('Image')).AsVariant := Null;
    end;
  end;
  
  SetControlFocus(edtPosition);
end;

initialization
  RegisterClassOnce(TEmbroideryPositionGUI);
finalization
  UnRegisterClass(TEmbroideryPositionGUI);
end.
