unit frmFormcomments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, busobjFormcomments, BusObjBase, DNMSpeedButton,
  Shader, DNMPanel, ComCtrls, DBCtrls;

type
  TfmFormcomments = class(TBaseInputGUI)
    QryFormComments: TERPQuery;
    dsFormComments: TDataSource;
    QryFormCommentsID: TIntegerField;
    QryFormCommentsGlobalref: TWideStringField;
    QryFormCommentsformId: TIntegerField;
    QryFormCommentsComments: TWideMemoField;
    QryFormCommentsactive: TWideStringField;
    QryFormCommentsmsTimeStamp: TDateTimeField;
    QryFormCommentsmsUpdateSiteCode: TWideStringField;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    edtDetails: TDBRichEdit;
    cmdRules: TDNMSpeedButton;
    memExport: TMemo;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cmdRulesClick(Sender: TObject);
    procedure memExportExit(Sender: TObject);
  private
    fiCommnetsFormID: Integer;
    FormComments :TFormComments;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure KeyIdChanged(const NewKeyId: integer);override;
  public
    Property CommnetsFormID :Integer read fiCommnetsFormID write fiCommnetsFormID;
    Class Procedure  ShowFormComments(aFormID:Integer);
  end;



implementation

uses Clipbrd, CommonLib, BusObjConst, CommonDbLib, tcDataUtils, AppEnvironment,
   SystemLib;

{$R *.dfm}
{ TfmFormcomments }

procedure TfmFormcomments.btnCloseClick(Sender: TObject);
begin
  inherited;
  FormComments.Connection.RollbackTransaction;
  ModalResult:= mrcancel;
end;

procedure TfmFormcomments.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not(FormComments.ValidateData) then exit;
  if not(FormComments.Save) then exit;
  FormComments.Connection.CommitTransaction;
  ModalResult:= mrOk;
end;

procedure TfmFormcomments.cmdRulesClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  if not(FormComments.ValidateData) then exit;
  if not(FormComments.Save) then exit;
    s:= 'delete from TblFromcommnets '+
                            ' where formId = (Select FormId from tblforms where formname = ' + quotedstr(getFormName((FormComments.formId))) +');' +
    'INSERT INTO TblFromcommnets '+
                            ' (formId , Comments, active) '+
                            '  VALUES '+
                            ' ( (Select FormId from tblforms where formname = ' + quotedstr(getFormName((FormComments.formId))) +'),' +
                            QuotedStr(StringReplace(StringReplace(StringReplace(Trim(Trim(FormComments.Comments)),'\', '\\', [rfReplaceAll, rfIgnoreCase]),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase]),#10 , '\r\n', [rfReplaceAll, rfIgnoreCase])) +', ' +
                            QuotedStr(BooleanToStr(FormComments.Active))+');';
    Clipboard.asText := s;
    memExport.Lines.Clear;
    memExport.Lines.Add(s);
    memExport.Visible:= TRue;
    SetControlfocus(memExport);
end;

procedure TfmFormcomments.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
  {-->} if (EventType = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
          if Sender is TFormComments then TFormComments(Sender).DataSet := QryFormComments;
        end;
end;

procedure TfmFormcomments.FormCreate(Sender: TObject);
begin
  inherited;
  UserLock.Enabled := true;
  FormComments := TFormComments.Create(Self);
  FormComments.Connection := TMyDacDataConnection.Create(FormComments);
  FormComments.Connection.Connection:= Self.MyConnection;
  FormComments.BusObjEvent := DoBusinessObjectEvent;
end;
procedure TfmFormcomments.KeyIdChanged(const NewKeyId: integer);
begin
  logInuseform;
  if UserLock.Enabled and (AccessLevel < 5) then begin
    // remove all existing locks
    UserLock.UnlockAllCurrentInstance;

    if (KeyId > 0) then begin
      if not UserLock.Lock('TblFromcommnets', KeyId, Self.Caption) then begin
        AccessLevel := 5; // read only

        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
          mtWarning, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TfmFormcomments.memExportExit(Sender: TObject);
begin
  inherited;
  memExport.Visible := False;
end;

procedure TfmFormcomments.FormShow(Sender: TObject);
begin
  inherited;
  if CommnetsFormID<> 0 then begin
    FormComments.LoadSelect('formId = ' + inttostr(CommnetsFormID));
  end else begin
    FormComments.Load(KeyID);
  end;

  if FormComments.formID >0 then
    TitleLabel.caption := AppEnv.AccessLevels.GetFormDescription(getformName(FormComments.formID))
  else
    TitleLabel.caption := 'Form comments';

  FormComments.Connection.BeginTransaction;
  if (FormComments.count =0) and (devmode) then begin
    FormComments.New;
    FormComments.formId := CommnetsFormID;
    FormComments.PostDB;
    FormComments.Edit
  end;
  btnCompleted.Enabled := Devmode and (Accesslevel = 1);
  edtDetails.ReadOnly := not(devmode) or (Accesslevel <> 1);
  cmdRules.visible := Devmode and (Accesslevel = 1);
end;
class procedure TfmFormcomments.ShowFormComments(aFormID: Integer);
var
  form : TfmFormcomments;
begin
  if not(Formhascomments(aFormID)) and not(Devmode) then exit;
  form :=  TfmFormcomments(getcomponentbyclassname('TfmFormcomments' , True , nil, False));
  try
    if not(Assigned(form)) then exit;
    form.CommnetsFormID := aFormID;
    form.ShowModal;
  finally
    FreeandNil(form);
  end;

end;

initialization
  RegisterClassOnce(TfmFormcomments);

end.

