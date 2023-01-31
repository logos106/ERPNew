unit frmAchInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,  busobjAchInfo, BusObjBase, Mask, wwdblook;

type
  TfmAchInfo = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryAchInfo: TERPQuery;
    dsAchInfo: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Address_Label: TLabel;
    txtAddress: TDBMemo;
    txtAddress2: TDBMemo;
    txtAddress3: TDBMemo;
    Box20: TBevel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryAchInfoID: TIntegerField;
    qryAchInfoGlobalRef: TWideStringField;
    qryAchInfoImmediateOriginNumber: TWideStringField;
    qryAchInfoImmediateOriginName: TWideStringField;
    qryAchInfoTaxID: TWideStringField;
    qryAchInfomsTimeStamp: TDateTimeField;
    qryAchInfomsupDatesiteCode: TWideStringField;
    CompanyInfo: TERPQuery;
    CompanyInfoSetupID: TAutoIncField;
    CompanyInfoCompanyName: TWideStringField;
    CompanyInfoTradingName: TWideStringField;
    CompanyInfoContactName: TWideStringField;
    CompanyInfoContactEmail: TWideStringField;
    CompanyInfoPhoneNumber: TWideStringField;
    CompanyInfoFaxNumber: TWideStringField;
    CompanyInfoABN: TWideStringField;
    CompanyInfoEditedFlag: TWideStringField;
    CompanyInfoPOBox: TWideStringField;
    CompanyInfoPOBox2: TWideStringField;
    CompanyInfoPOBox3: TWideStringField;
    CompanyInfoPOCity: TWideStringField;
    CompanyInfoPOState: TWideStringField;
    CompanyInfoPOPostcode: TWideStringField;
    CompanyInfoPOCountry: TWideStringField;
    CompanyInfoETPPayerType: TWideStringField;
    CompanyInfoFileReference: TWideStringField;
    CompanyInfoTaxSignatory: TWideStringField;
    CompanyInfoLeaveLoadingPercent: TFloatField;
    CompanyInfoCompulsorySuperPercent: TFloatField;
    CompanyInfoBSB: TWideStringField;
    CompanyInfoAccountNo: TWideStringField;
    CompanyInfoFontCompanyName: TWideStringField;
    CompanyInfoFontAddress: TWideStringField;
    CompanyInfoFontSuburb: TWideStringField;
    CompanyInfoFontPhone: TWideStringField;
    CompanyInfoFontABN: TWideStringField;
    CompanyInfoFontDefault: TWideStringField;
    CompanyInfoSizeCompanyName: TIntegerField;
    CompanyInfoSizeAddress: TIntegerField;
    CompanyInfoSizeSuburb: TIntegerField;
    CompanyInfoSizePhone: TIntegerField;
    CompanyInfoSizeABN: TIntegerField;
    CompanyInfoSizeDefault: TIntegerField;
    CompanyInfoColorCompanyName: TWideStringField;
    CompanyInfoColorAddress: TWideStringField;
    CompanyInfoColorSuburb: TWideStringField;
    CompanyInfoColorPhone: TWideStringField;
    CompanyInfoColorABN: TWideStringField;
    CompanyInfoColorDefault: TWideStringField;
    CompanyInfoStyleCompanyName: TWideStringField;
    CompanyInfoStyleAddress: TWideStringField;
    CompanyInfoStyleSuburb: TWideStringField;
    CompanyInfoStylePhone: TWideStringField;
    CompanyInfoStyleABN: TWideStringField;
    CompanyInfoStyleDefault: TWideStringField;
    CompanyInfoBankCode: TIntegerField;
    CompanyInfoBankBranch: TWideStringField;
    CompanyInfoAPCANo: TWideStringField;
    CompanyInfoWorkersCompInsurer: TIntegerField;
    CompanyInfoEmail: TWideStringField;
    CompanyInfoGlobalRef: TWideStringField;
    CompanyInfoAddress: TWideStringField;
    CompanyInfoAddress2: TWideStringField;
    CompanyInfoAddress3: TWideStringField;
    CompanyInfoCity: TWideStringField;
    CompanyInfoState: TWideStringField;
    CompanyInfoPostcode: TWideStringField;
    CompanyInfoCountry: TWideStringField;
    CompanyInfoURL: TWideStringField;
    CompanyInfoContact: TWideStringField;
    CompanyInfoMenuColor: TIntegerField;
    CompanyInfoSupplierId: TWideStringField;
    CompanyInfoDVAABN: TWideStringField;
    CompanyInfoRAPloginID: TWideStringField;
    CompanyInfoRAPPassword: TWideStringField;
    CompanyInfoRAPLoginPage: TWideStringField;
    CompanyInfoRAPProgramName: TWideStringField;
    CompanyInfoRAPInvoiceDescription: TWideStringField;
    CompanyInfoRAPProductGroup: TWideStringField;
    CompanyInfoRAPContractNumber: TWideStringField;
    CompanyInfoCompanyNumber: TWideStringField;
    CompanyInfoTrackEmails: TWideStringField;
    frmCompanyInformationSrc: TDataSource;
    CompanyName_Label: TLabel;
    txtCompanyName: TDBEdit;
    Label3: TLabel;
    edtCompanyNumber: TDBEdit;
    qryAchInfoImmediateDestination_AccountID: TIntegerField;
    qryAchInfoImmediateDestination_Accountname: TWideStringField;
    cboAccountQry: TERPQuery;
    lblAccount: TLabel;
    cboAccount: TwwDBLookupCombo;
    cboAccountQryAccountID: TIntegerField;
    cboAccountQryAccountName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    AchInfo: TAchInfo;
    function SaveRecord: Boolean;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment;

{$R *.dfm}

procedure TfmAchInfo.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmAchInfo.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  achinfo.Connection.CommitTransaction;
  AppEnv.Reset;
  Self.Close;
end;
Function TfmAchInfo.SaveRecord :Boolean;
begin
  if companyinfo.State in [dsEdit, dsInsert] then companyinfo.Post;
  result:= False;
  achinfo.PostDB;
  if not(achinfo.Save) then exit;
  Result:= True;

end;
procedure TfmAchInfo.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
      inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TAchInfo then TAchInfo(Sender).Dataset  := QryAchInfo;
     end;
end;

procedure TfmAchInfo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if AchInfo.Dirty then begin
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
          AchInfo.Dirty := false;
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

procedure TfmAchInfo.FormCreate(Sender: TObject);
begin
  inherited;
  achInfo := TAchinfo.CreateWithNewConn(Self);
  achinfo.Connection.connection := Self.MyConnection;
  Achinfo.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmAchInfo.FormShow(Sender: TObject);
begin
  inherited;
  CompanyInfo.ParamByName('KeyID').asInteger := 1;
  achInfo.Load;
  openQueries;
  UserLock.Enabled := True;
  if (UserLock.Lock('tblcompanyinformation' , 0) = False) then begin
        AccessLevel := 5;
        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access will be changed to read-only.', mtWarning, [mbOK], 0);
  end else if (UserLock.Lock('tblAchInfo' , 0) = False)  then begin
        AccessLevel := 5;
        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access will be changed to read-only.', mtWarning, [mbOK], 0);
  end else begin
    achInfo.connection.BeginTransaction;
    if achInfo.count=0 then achInfo.new;
  end;

end;

initialization
  RegisterClassOnce(TfmAchInfo);
end.

