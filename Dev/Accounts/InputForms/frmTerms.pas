unit frmTerms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , busObjcommon, Spin, wwcheckbox, Mask, wwdbedit,
  Wwdbspin, ComCtrls;

type
  TfmTerms = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    qryTerms: TERPQuery;
    frmTermsSrc: TDataSource;
    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtName: TDBEdit;
    DBEdit2: TDBEdit;
    Panel1: TDNMPanel;
    rgFrequency: TDBRadioGroup;
    pnlDay: TDNMPanel;
    Label4: TLabel;
    Label5: TLabel;
    seDayDays: TwwDBSpinEdit;
    pnlWeekDay: TDNMPanel;
    Label6: TLabel;
    Label7: TLabel;
    seWeekDays: TwwDBSpinEdit;
    pnlMonth: TDNMPanel;
    Label8: TLabel;
    Label9: TLabel;
    seMonthMonths: TwwDBSpinEdit;
    Label10: TLabel;
    edtInstallments: TwwDBSpinEdit;
    Label11: TLabel;
    edtEarlyPaymentDiscount: TDBEdit;
    chkP: TwwCheckBox;
    qryTermsGlobalRef: TWideStringField;
    qryTermsTermsID: TIntegerField;
    qryTermsTerms: TWideStringField;
    qryTermsTermsAmount: TIntegerField;
    qryTermsEOM: TWideStringField;
    qryTermsEOMPlus: TWideStringField;
    qryTermsDays: TWideStringField;
    qryTermsPP: TWideStringField;
    qryTermsActive: TWideStringField;
    qryTermsDescription: TWideStringField;
    qryTermsEditedFlag: TWideStringField;
    qryTermsRequired: TWideStringField;
    qryTermsEarlyPaymentDiscount: TFloatField;
    qryTermsmsTimeStamp: TDateTimeField;
    qryTermsmsUpdateSiteCode: TWideStringField;
    qryTermsProgressPaymenttype: TWideStringField;
    qryTermsProgressPaymentDuration: TIntegerField;
    lblPPHint: TLabel;
    Label3: TLabel;
    edtPPDays: TwwDBSpinEdit;
    Label12: TLabel;
    chkProgressPaymentfirstPayonSaleDate: TDBCheckBox;
    qryTermsProgressPaymentInstallments: TIntegerField;
    qryTermsProgressPaymentfirstPayonSaleDate: TWideStringField;
    Label13: TLabel;
    edtEarlyPaymentDiscountDays: TDBEdit;
    Label14: TLabel;
    qryTermsEarlyPaymentDays: TIntegerField;
    chkActive: TwwCheckBox;
    DNMPanel9: TDNMPanel;
    DNMPanel7: TDNMPanel;
    lblNDays2: TLabel;
    lblNDays1: TLabel;
    chkN: TwwCheckBox;
    edtNDays: TwwDBSpinEdit;
    DNMPanel8: TDNMPanel;
    Label23: TLabel;
    lblEDays: TLabel;
    chkE: TwwCheckBox;
    edtEDays: TwwDBSpinEdit;
    DNMPanel6: TDNMPanel;
    lblDDays: TLabel;
    edtDDays: TwwDBSpinEdit;
    chkD: TwwCheckBox;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMPanel10: TDNMPanel;
    wwCheckBox1: TwwCheckBox;
    qryTermsPublishOnVS1: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chooseType(Sender: TObject);
    procedure rgFrequencyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure qryTermsAfterOpen(DataSet: TDataSet);
    procedure chkProgressPaymentfirstPayonSaleDateClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    TermsObj: TTerms;
    chooseTypechanging:Boolean;
    function SaveRecord: Boolean;
    procedure NewRecord;
    procedure NewBusObjinstance;
    procedure OpenRec;
    Procedure OnFrequencychange;
    function EPHint: String;
    procedure setTermnametoAdd(const Value: String);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure CommitAndNotify;override;
  public
    Property TermnametoAdd:String write setTermnametoAdd;
  end;


implementation

uses CommonLib, BusObjConst, tcConst, FormFactory, AppEnvironment, dateutils;

{$R *.dfm}

procedure TfmTerms.chkProgressPaymentfirstPayonSaleDateClick(Sender: TObject);
begin
  inherited;
  if TermsObj.count >0 then begin
    TermsObj.ProgressPaymentfirstPayonSaleDate :=chkProgressPaymentfirstPayonSaleDate.checked;
    TermsObj.PostDB;
    TermsObj.EditDB;
    edtPPDays.enabled := TermsObj.ProgressPaymentfirstPayonSaleDate;
  end;
end;

procedure TfmTerms.chooseType(Sender: TObject);
begin
  inherited;
  if chooseTypechanging then exit;
  if not qryterms.active then exit;
  chooseTypechanging:= True;
  try
    if not IsFormshown then exit;
    if (chkD.Focused and (not TwwCheckBox(Sender).Checked) and TermsObj.IsDays)
      or (chkE.Focused and (not TwwCheckBox(Sender).Checked) and TermsObj.IsEOM)
      or (chkN.Focused and (not TwwCheckBox(Sender).Checked) and TermsObj.IsEOMPlus)
      or (chkP.Focused and (not TwwCheckBox(Sender).Checked) and TermsObj.IsProgresspayment) then
      { user is trying to uncheck this option .. must have one checked }
     CommonLib.MessageDlgXP_Vista('You can not Deselect all Terms Types, please Select a Different Terms Type',mtInformation,[mbOk],0);

    TermsObj.PostDB;
    TermsObj.EditDB;

    if (chkD.Checked =False) and (chkN.Checked =False) and (chkE.Checked =False) and (chkP.Checked =False) then
      TwwCheckBox(Sender).Checked := True;

    chkD.Checked := not((Sender <>chkD) and ( chkN.Checked or chkE.Checked or chkP.Checked));
    chkE.Checked := not((Sender <>chkE) and ( chkN.Checked or chkD.Checked or chkP.Checked));
    chkN.Checked := not((Sender <>chkN) and ( chkD.Checked or chkE.Checked or chkP.Checked));
    chkP.Checked := not((Sender <>chkP) and ( chkN.Checked or chkE.Checked or chkD.Checked));

    TermsObj.IsDays :=chkD.Checked ;
    TermsObj.IsEOM :=chkE.Checked ;
    TermsObj.IsEOMPlus := chkN.Checked ;
    TermsObj.IsProgresspayment := chkP.Checked ;
    TermsObj.PostDB;
    TermsObj.EditDB;


    edtDDays.Enabled := chkD.Checked ;
    edtEDays.Enabled := chkE.Checked ;
    edtNDays.Enabled := chkN.Checked ;

    rgFrequency.Enabled := chkP.Checked ;
    seDayDays.Enabled := chkP.Checked ;
    seWeekDays.Enabled := chkP.Checked ;
    seMonthMonths.Enabled := chkP.Checked ;
    edtInstallments.Enabled := chkP.Checked ;
  finally
    chooseTypechanging := False;
  end;

end;

procedure TfmTerms.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmTerms.SaveRecord :Boolean;
begin
  result:= False;
  TermsObj.PostDB;
  if not(TermsObj.Save) then exit;
  Result:= True;
end;

procedure TfmTerms.setTermnametoAdd(const Value: String);
begin
  if TermsObj.TermsName = '' then begin
    TermsObj.TermsName:= Value;
    Setcontrolfocus(edtName);
    MessageDlgXP_vista('Please Provide Details for ' + QuotedStr(Value)+'.', mtInformation, [mbOK], 0);
  end;
end;

procedure TfmTerms.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  TermsObj.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmTerms.cmdNewClick(Sender: TObject);
begin
  // If user does not have access to this form don't process any further
  DisableForm;
  try
    if TermsObj.Dirty then begin
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
procedure TfmTerms.OnFrequencychange;
begin
  seDayDays.Enabled :=(TermsObj.ProgressPaymenttype ='D') and chkP.Checked;
  seWeekDays.Enabled :=(TermsObj.ProgressPaymenttype ='W') and chkP.Checked;
  seMonthMonths.Enabled :=(TermsObj.ProgressPaymenttype ='M') and chkP.Checked;
end;


Procedure TfmTerms.OpenRec;
begin
  TermsObj.Load(KeyID);
  TermsObj.connection.BeginTransaction;
  if TermsObj.count=0 then TermsObj.new;
  OpenQueries;
  TermsObj.Dirty := False;
  edtName.ReadOnly := keyID<>0;
  if not TermsObj.Lock then begin
        AccessLevel := 5; // read only

        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
          mtWarning, [mbOK], 0);

  end;
end;
procedure TfmTerms.qryTermsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  OnFrequencychange;
end;

Procedure TfmTerms.NewBusObjinstance;
begin
  Freeandnil(TermsObj);
  TermsObj := TTerms.CreateWithNewConn(Self);
  TermsObj.Connection.connection := Self.MyConnection;
  TermsObj.BusObjEvent := DoBusinessObjectEvent;
end;
Procedure TfmTerms.NewRecord;
begin
    CloseQueries;
    KeyID:= 0;
    NewBusObjinstance;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    self.BeginTransaction;
    OpenRec;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    Setcontrolfocus(edtName);
end;
procedure TfmTerms.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;
function TfmTerms.EPHint :String;
var
  dt:TDate;
begin
  dt := EndOfTheMonth(incmonth(date,1));
  REsult := 'Days are the Number of days prior to the due date that the ''Early Payment Discount'' is Applicable.'+NL+NL+
                                                'ie: if Due Date is  ' + quotedstr(formatdatetime(FormatSettings.shortdateformat , dt))+'  and Days are ''10'', '+NL+
                                                '''Early payment Discount'' is Applicable if payment is made before   ' + quotedstr(formatdatetime(FormatSettings.shortdateformat , incday(dt, -10)));
end;
procedure TfmTerms.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  MessageDlgXP_VISTA( EPHint, mtinformation, [mbOK], 0);
  SetcontrolFocus(edtEarlyPaymentDiscountDays);
end;

procedure TfmTerms.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TTerms then TTerms(Sender).Dataset  := qryTerms;
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_ProgressPaymenttype) then begin
        rgFrequencyClick(rgFrequency);
     end;
end;

procedure TfmTerms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmTerms.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if TermsObj.Dirty then begin
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
          TermsObj.Dirty := false;
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

procedure TfmTerms.FormCreate(Sender: TObject);
begin
  inherited;
  chooseTypechanging := False;
  NewBusObjinstance;
  //chkP.caption := '  Progress'+NL+'  Payment';
  lblPPHint.caption :=  'Progress Payment is only applicable for INVOICE.'+NL+
                        'The First Date, Based on the Selections, is the Due Date for All Other Type of Transactions.';
end;
procedure TfmTerms.FormShow(Sender: TObject);
begin
  inherited;
  Openrec;

end;

procedure TfmTerms.rgFrequencyClick(Sender: TObject);
begin
  inherited;
  TermsObj.ProgressPaymenttype :=rgFrequency.values[rgFrequency.itemindex];
  TermsObj.PostDB;
  OnFrequencychange;
end;

initialization
  RegisterClassOnce(TfmTerms);
  FormFact.RegisterMe(TfmTerms, 'TTermsListGUI_*=TermsID');
  FormFact.RegisterMe(TfmTerms, 'TTermsListGUI_Terms=TermsID');
  FormFact.RegisterMe(TfmTerms, 'TClientTypeListGUI_Terms=TermsID');
  FormFact.RegisterControl(TfmTerms, '*_cboTerms=TermsID');
  FormFact.RegisterControl(TfmTerms, '*_Terms=TermsID');
end.

