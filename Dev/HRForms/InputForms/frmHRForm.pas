unit frmHRForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  HRFormsLib, DNMSpeedButton ,   BusObjBase , BusObjHRForms, Mask, wwdblook, wwcheckbox, IntegerListObj;

type
  TfmHRForm = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    QryHRForms: TERPQuery;
    QryHRFormsID: TIntegerField;
    QryHRFormsName: TWideStringField;
    QryHRFormsTemplate: TWideStringField;
    QryHRFormsformtype: TWideStringField;
    QryHRFormsmsTimeStamp: TDateTimeField;
    QryHRFormsmsUpdateSitecode: TWideStringField;
    Description_Label: TLabel;
    edtName: TDBEdit;
    dsHRForms: TDataSource;
    qryTemplate: TERPQuery;
    qryTemplateTemplName: TWideStringField;
    qryTemplateTemplID: TAutoIncField;
    cboTemplate: TwwDBLookupCombo;
    Label1: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    btnPrint: TDNMSpeedButton;
    QryHRFormsActive: TWideStringField;
    Qrylanguages: TERPQuery;
    QrylanguagesLanguage: TWideStringField;
    QrylanguagesID: TIntegerField;
    Label22: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    QryHRFormsLanguageID: TIntegerField;
    chkActive: TwwCheckBox;
    optOutputtype: TRadioGroup;
    btnNewTemplate: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure cboTemplateEnter(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNewTemplateClick(Sender: TObject);
    procedure cboTemplateDblClick(Sender: TObject);
  private
    HRFormObj: THRForms;

    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure NewRecord;
    function Outputtype: TOutputtype;
    procedure chooseTemplate(Sender: TObject);
    procedure initTemplateType(Sender: TObject);
    procedure initTempform(Sender: TObject);

  Protected
    procedure CommitAndNotify;override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment, FormFactory, CommonFormLib,
  frmReportTemplate, tcDataUtils;

{$R *.dfm}

procedure TfmHRForm.cboTemplateEnter(Sender: TObject);
begin
  inherited;
  if (qryTemplate.Parambyname('typeID').asInteger =0) or (qryTemplate.Parambyname('typeID').asInteger <> HRFormObj.TemplateTypeID) then begin
    Closedb(qryTemplate);
    qryTemplate.Parambyname('typeID').asInteger :=  HRFormObj.TemplateTypeID;
    Opendb(qryTemplate);
  end;
end;
procedure TfmHRForm.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmHRForm.SaveRecord :Boolean;
begin
  result:= False;
  HRFormObj.PostDB;
  if not(HRFormObj.Save) then exit;
  Result:= True;

end;

procedure TfmHRForm.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  HRFormObj.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmHRForm.cmdNewClick(Sender: TObject);
begin
  inherited;
  // If user does not have access to this form don't process any further
  DisableForm;
  try
    if HRFormObj.Dirty then begin
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

procedure TfmHRForm.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;

procedure TfmHRForm.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is THRForms then THRForms(Sender).Dataset  := QryHRForms;
     end;
end;

procedure TfmHRForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmHRForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if HRFormObj.Dirty then begin
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
          HRFormObj.Dirty := false;
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

procedure TfmHRForm.FormCreate(Sender: TObject);
begin
  inherited;
   NewBusObjinstance;

end;
procedure TfmHRForm.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
end;

procedure TfmHRForm.NewBusObjinstance;
begin
  HRFormObj := THRForms.CreateWithNewConn(Self);
  HRFormObj.Connection.connection := Self.MyConnection;
  HRFormObj.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmHRForm.NewRecord;
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

procedure TfmHRForm.Openrec;
begin
  HRFormObj.Load(KeyID);
  HRFormObj.connection.BeginTransaction;
  if HRFormObj.count=0 then HRFormObj.new;
  openQueries;
  HRFormObj.Dirty := false;
end;
procedure TfmHRForm.cboTemplateDblClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit; // just to make sure the record can be saved
  if  HRFormObj.template = '' then exit;
  OpenERPFormModal('TfmReportTemplate', GetTemplate(HRFormObj.template) , initTempform);
end;

procedure TfmHRForm.btnNewTemplateClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit; // just to make sure the record can be saved
  OpenERPFormModal('TfmReportTemplate', 0 , initTemplateType , true,chooseTemplate);
end;
procedure TfmHRForm.initTempform(Sender: TObject);
begin
   if not(Sender is TfmReportTemplate) then exit;
   TfmReportTemplate(Sender).OpenDesignonshow := True;
end;
procedure TfmHRForm.initTemplateType(Sender: TObject);
begin
   if not(Sender is TfmReportTemplate) then exit;
         if HRFormObj.formtype ='E' then TfmReportTemplate(Sender).TempTypeforNew :='HR Forms - Employee'
    else if HRFormObj.formtype ='C' then TfmReportTemplate(Sender).TempTypeforNew :='HR Forms - Customer';
    initTempform(Sender);
end;
procedure TfmHRForm.chooseTemplate(Sender: TObject);
begin
  if not(Sender is TfmReportTemplate) then exit;
  HRFormObj.Template :=  TfmReportTemplate(Sender).qryTemplatesTemplName.AsString;
end;
procedure TfmHRForm.btnPrintClick(Sender: TObject);
begin
  if not SaveRecord then exit;
  HRFormObj.Connection.CommitTransaction;
  Try
    TPrintHRForm.PrintTemplate(0, self, HRFormObj,0 , Outputtype);
  Finally
    HRFormObj.Connection.begintransaction;
  End;
end;
function TfmHRForm.Outputtype: TOutputtype;
begin
       if optOutputtype.itemindex = 0 then result := otPrint
  else if optOutputtype.itemindex = 1 then result := otPreview
  else result := otEmail;
end;

initialization
  RegisterClassOnce(TfmHRForm);
  with FormFact do begin
    RegisterMe(TfmHRForm, 'THRFormsGUI_*=ID');
  end;


end.

