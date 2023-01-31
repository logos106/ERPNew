unit FrmERPHelpDoc;
{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusobjERPHelpDoc, wwclearbuttongroup,
  wwradiogroup, Mask, wwdbedit, wwdblook, ERPDbLookupCombo;

type
  TFmERPHelpDoc = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    qryERPHelpDocs: TERPQuery;
    dsERPHelpDocs: TDataSource;
    lblPartname: TLabel;
    edtPart: TwwDBEdit;
    wwRadioGroup1: TwwRadioGroup;
    btnChoosefile: TDNMSpeedButton;
    OpenDialog1: TOpenDialog;
    btnActionname: TDNMSpeedButton;
    qryERPHelpDocsID: TIntegerField;
    qryERPHelpDocsDescription: TWideStringField;
    qryERPHelpDocsFiletype: TWideStringField;
    qryERPHelpDocsIsERPTaskItem: TWideStringField;
    qryERPHelpDocsActive: TWideStringField;
    qryERPHelpDocsFileName: TWideStringField;
    qryERPHelpDocsModulename: TWideStringField;
    qryERPHelpDocsmsTimeStamp: TDateTimeField;
    tmrAfterformShow: TTimer;
    lblMsg: TLabel;
    chkActive: TDBCheckBox;
    qryForms: TERPQuery;
    cboModuleNAme: TwwDBLookupcombo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure btnChoosefileClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnActionnameClick(Sender: TObject);
    procedure tmrAfterformShowTimer(Sender: TObject);
  private
    fsfilewithPath :String;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewRecord;
    function UploadHelpDocfile:Boolean;
  Protected
    DocReaderObj: THelpDoc;
    procedure NewBusObjinstance;Virtual;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure CommitAndNotify;override;
  public
    Function Choosefile:Boolean;virtual;
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment, Clipbrd, FormFactory, tcConst , IOUtils,
  LogLib, FiletoFTP;

{$R *.dfm}

procedure TFmERPHelpDoc.btnActionnameClick(Sender: TObject);
begin
  inherited;
  try
    Clipboard.asText:= makename('act_' + DocReaderObj.Description ,'.pdf');
  Except
    on E:Exception do begin
      MessageDlgXP_vista(Clipboard.asText+NL+NL+ 'CTRL+V for the Action Name' , mtWarning, [mbOK], 0);
    end;
  end;


end;

procedure TFmERPHelpDoc.cmdCancelClick(Sender: TObject);
begin
  inherited;
  CloseIt(False);
end;

Function TFmERPHelpDoc.SaveRecord :Boolean;
begin
  result:= False;
  DocReaderObj.PostDB;
  if not(DocReaderObj.Save) then exit;
  Result:= True;
end;


procedure TFmERPHelpDoc.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  DocReaderObj.Connection.CommitTransaction;
  if classnameis('TFmERPHelpDoc') then UploadHelpdocFile ;
  Self.Close;
end;
Function TFmERPHelpDoc.UploadHelpDocfile:Boolean;
var
  ERPDocs : TERPDocs;
begin
  inherited;
  if fsfilewithPath = '' then begin
    result := True;
    Exit;
  end;
  ERPDocs := TERPDocs.Create;
  try
    REsult := ERPDocs.Uploadhelpdoc(fsfilewithPath) ;
    if result then begin
      fsfilewithPath := '';
      MessageDlgXP_vista('Help Docs is Uploaded', mtInformation, [mbOK], 0)
    end else MessageDlgXP_vista('Help Docs is NOT Uploaded.' +NL +
                                ERPDocs.StatusMsg+NL+NL+
                                'Please upload '+quotedstr(fsfilewithPath)+' Manually to the FTP Folder', mtInformation, [mbOK], 0);
  finally
    FreeandNil(ERPDocs);
  end;

end;
procedure TFmERPHelpDoc.cmdNewClick(Sender: TObject);
begin
  inherited;
  // If user does not have access to this form don't process any further
  DisableForm;
  try
    if DocReaderObj.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if SaveRecord then begin
               CommitAndNotify;  // current record should be commited before inserting new reocrd
            end else Exit;
          end;
        mrNo:
          begin
            // Cancel edits and Rollback changes
            RollbackTransaction;
          end;
        mrCancel:
          begin
            Exit;
          end;
      end;
    end;
    KeyID := 0;
    NewRecord;
  finally
    EnableForm;
  end;

end;

procedure TFmERPHelpDoc.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;


procedure TFmERPHelpDoc.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is THelpDoc then THelpDoc(Sender).Dataset  := qryERPHelpDocs;
     end;
end;

procedure TFmERPHelpDoc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TFmERPHelpDoc.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if DocReaderObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          DocReaderObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TFmERPHelpDoc.FormCreate(Sender: TObject);
begin
  inherited;
   NewBusObjinstance;
   fsfilewithPath :='';
end;

procedure TFmERPHelpDoc.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  DocReaderObj := THelpDoc.CreateWithNewConn(Self);
  DocReaderObj.Connection.connection := Self.MyConnection;
  DocReaderObj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}

end;

procedure TFmERPHelpDoc.NewRecord;
begin
    CloseQueries;
    KeyID:= 0;
    NewBusObjinstance;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    self.BeginTransaction;
    OpenRec;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    //Setcontrolfocus(edtName);
end;

procedure TFmERPHelpDoc.Openrec;
begin
  DocReaderObj.Load(KeyID);
  DocReaderObj.connection.BeginTransaction;
  if DocReaderObj.count=0 then DocReaderObj.new;
  openQueries;
  DocReaderObj.Dirty := false;
end;
procedure TFmERPHelpDoc.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
  btnActionname.Visible := DEvmode;
  if classnameis('TFmERPHelpDoc')  then tmrAfterformShow.Enabled := KeyId = 0;
end;

procedure TFmERPHelpDoc.tmrAfterformShowTimer(Sender: TObject);
begin
  inherited;
  tmrAfterformShow.Enabled := False;
  if KeyId =0 then
    btnChoosefile.Click;
end;
procedure TFmERPHelpDoc.btnChoosefileClick(Sender: TObject);
begin
Processingcursor(true);
try
  TimerMsg(lblmsg, 'Please Wait .. Choosing the File');
  Choosefile;
finally
  hideTimerMsg;
  Processingcursor(False);
end;
end;
function TFmERPHelpDoc.Choosefile:boolean;
var
  done:Integer;
  ErrMsg:String;
begin
  inherited;
  result := False;
  if devmode then
    OpenDialog1.InitialDir := '\\192.168.1.110\Data\Corporate\PDF How Tos';
  if OpenDialog1.Execute then begin
    if DocReaderObj.LoadFromfile(OpenDialog1.FileName) then begin
      fsfilewithPath :=OpenDialog1.FileName;
      DocReaderObj.PostDB;
      Result :=true;
    end;
    {move the file in dev mode to the done folder}
    try
      if devmode then begin
        done := 1;
        ErrMsg:= '';
        repeat
          try
            if done =1 then begin
              TFile.Copy(OpenDialog1.FileName, '\\192.168.1.110\Data\Corporate\PDF How Tos\Done\', true);
              TFile.Delete(OpenDialog1.FileName);
              done := 0;
            end else if done =2 then begin
              TFile.Copy(OpenDialog1.FileName, '\\192.168.1.110\Data\Corporate\PDF How Tos\Done', true);
              TFile.Delete(OpenDialog1.FileName);
              done := 0;
            end else if done =3 then begin
              TFile.Copy(OpenDialog1.FileName, '\\192.168.1.110\Data\Corporate\PDF How Tos\Done\'+OpenDialog1.FileName, true);
              TFile.Delete(OpenDialog1.FileName);
              done := 0;
            end else begin
              done := 0;
              if ErrMsg <> '' then
                logtext('File Copy Failed:' + NL+ErrMsg);
            end;
          Except
            on E:Exception do begin
              ErrMsg := trim(ErrMsg+NL+inttostr(done)+':' +E.message);
              done := done +1;
            end;
          end;
        until done =0;
      end;
    Except
      // kill the exception
    end;
    //if classnameis('TFmERPHelpDoc') then cmdClose.Click;
  end;

end;

initialization
  RegisterClassOnce(TFmERPHelpDoc);
 (* with FormFact do begin
    {$IFDEF DevMode}
    RegisterMe(TFmERPHelpDoc, 'TERPPDFDocsGUI_*=ID');
    {$ENDIF}
  end;*)


end.

