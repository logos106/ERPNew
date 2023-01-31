unit frmEmployeeInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  DNMPanel, StdCtrls, wwclearbuttongroup, wwradiogroup, wwdbdatetimepicker,
  wwdblook, Mask, DBCtrls, Shader, BusObjEmployeeDetails ,BusObjBase,
  DNMSpeedButton, wwdbedit, Wwdotdot, Wwdbcomb, ProgressDialog;

type
  TfmEmployeeInfo = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Title: TDBEdit;
    Initials: TDBEdit;
    FirstName: TDBEdit;
    MiddleName: TDBEdit;
    LastName: TDBEdit;
    DNMPanel6: TDNMPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Phone: TwwDBEdit;
    FaxNumber: TwwDBEdit;
    Mobile: TwwDBEdit;
    AltPhone: TwwDBEdit;
    AltContact: TDBEdit;
    DBEdit1: TDBEdit;
    DNMPanel8: TDNMPanel;
    Label18: TLabel;
    Label21: TLabel;
    DOB: TwwDBDateTimePicker;
    rgSex: TwwRadioGroup;
    Position: TDBEdit;
    Qryemployee: TERPQuery;
    QryemployeeTitle: TWideStringField;
    QryemployeeInitials: TWideStringField;
    QryemployeeFirstName: TWideStringField;
    QryemployeeMiddleName: TWideStringField;
    QryemployeeLastName: TWideStringField;
    QryemployeePhone: TWideStringField;
    QryemployeeAltPhone: TWideStringField;
    QryemployeeFaxNumber: TWideStringField;
    QryemployeeMobile: TWideStringField;
    QryemployeeAltContact: TWideStringField;
    QryemployeeWorkPhone: TWideStringField;
    QryemployeeDefaultClassName: TWideStringField;
    QryemployeeEmployeeNo: TIntegerField;
    QryemployeeEmployeeID: TIntegerField;
    QryemployeePosition: TWideStringField;
    QryemployeeDOB: TDateField;
    QryemployeeSex: TWideStringField;
    QryemployeeNextOfKin: TWideStringField;
    QryemployeeNextOfKinRelationship: TWideStringField;
    QryemployeeNextOfKinPhone: TWideStringField;
    dsemployee: TDataSource;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    Label4: TLabel;
    DateStarted: TwwDBDateTimePicker;
    btnNew: TDNMSpeedButton;
    DBEdit3: TDBEdit;
    Label14: TLabel;
    QryemployeeDefaultClassID: TIntegerField;
    QryemployeeDateStarted: TDateField;
    rgBasisOfEmployment: TwwRadioGroup;
    QryemployeeBasisOfPayment: TWideStringField;
    DNMPanel2: TDNMPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Email: TDBEdit;
    rgEmailsFrom: TwwRadioGroup;
    QryemployeeemployeeName: TWideStringField;
    Qryemployeeemail: TWideStringField;
    Label19: TLabel;
    EmployeeNo: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label20: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    Qryemployeecallpriority: TIntegerField;
    pnlDevComments: TDNMPanel;
    Label22: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    EmployeeDetails:TEmployeeDetails;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, FormFactory, AppEnvironment, DefaultClassObj, BusObjConst  ;

{$R *.dfm}
procedure TfmEmployeeInfo.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TEmployeeDetails then TEmployeeDetails(Sender).Dataset:= Qryemployee;
    end;
end;

procedure TfmEmployeeInfo.FormCreate(Sender: TObject);
begin
  AddPhoneCallbutton(Phone);
  AddPhoneCallbutton(Mobile);
  AddPhoneCallbutton(AltPhone);
  inherited;

  pnlDevComments.visible := False;  Height := height -pnlDevComments.height;

  EmployeeDetails:=TEmployeeDetails.create(Self);
  EmployeeDetails.connection := TMyDacDataConnection.create(EmployeeDetails);
  EmployeeDetails.connection.Connection := Self.MyConnection;
  EmployeeDetails.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmEmployeeInfo.FormShow(Sender: TObject);
begin
  inherited;
  EmployeeDetails.Load(KeyID);
  EmployeeDetails.Connection.BeginTransaction;
  if KeyId = 0 then begin
      EmployeeDetails.New;
      EmployeeDetails.Defaultclassid:=Appenv.DefaultClass.ClassID;
  end;
  OpenQueries;
end;

procedure TfmEmployeeInfo.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not EmployeeDetails.Save then Exit;
  EmployeeDetails.Connection.CommitTransaction;
  EmployeeDetails.dirty := False;
  modalresult := mrOk;
end;

procedure TfmEmployeeInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  modalresult := mrOk;
end;

procedure TfmEmployeeInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := false;
  if EmployeeDetails.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          EmployeeDetails.PostDB;
          if EmployeeDetails.Save then begin
            EmployeeDetails.Dirty := True;
            EmployeeDetails.Connection.CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          EmployeeDetails.CancelDb;
          EmployeeDetails.Connection.RollbackTransaction;
          EmployeeDetails.dirty:= False;
          CanClose := true;
          modalresult := mrCancel;
        end;
      mrCancel: 
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;end;

procedure TfmEmployeeInfo.btnNewClick(Sender: TObject);
begin
  inherited;
  if not EmployeeDetails.Save then Exit;
  EmployeeDetails.Connection.CommitTransaction;
  EmployeeDetails.Connection.BeginTransaction;
  EmployeeDetails.New;
  SetControlFocus(Title);
end;

procedure TfmEmployeeInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

initialization
  RegisterClassOnce(TfmEmployeeInfo);
  (*with FormFact do begin
    RegisterMe(TfrmEmployee, 'TEmployeeExpresslistGUI_*=EmployeeID');
  end;*)

end.
