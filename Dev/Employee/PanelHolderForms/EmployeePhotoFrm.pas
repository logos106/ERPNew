unit EmployeePhotoFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  BusObjEmployeepay, StdCtrls, wwdbdatetimepicker, DNMSpeedButton,
  DBCtrls, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, ExtCtrls, DNMPanel, Dialogs,
  frmBase, BusObjBase, Menus;

type
  TEmployeePhoto = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    qryemployeesphoto: TERPQuery;
    qryemployeesphotoEmployeeID: TAutoIncField;
    qryemployeesphotoTitle: TWideStringField;
    qryemployeesphotoFirstName: TWideStringField;
    qryemployeesphotoMiddleName: TWideStringField;
    qryemployeesphotoLastName: TWideStringField;
    qryemployeesphotoABN: TWideStringField;
    qryemployeesphotoCanvasser: TWideStringField;
    qryemployeesphotoRep: TWideStringField;
    qryemployeesphotoCreationDate: TDateField;
    qryemployeesphotoDateStarted: TDateField;
    qryemployeesphotoDateFinished: TDateField;
    qryemployeesphotoNotes: TWideMemoField;
    qryemployeesphotoActive: TWideStringField;
    qryemployeesphotoCUSTFLD1: TWideStringField;
    qryemployeesphotoCUSTFLD2: TWideStringField;
    qryemployeesphotoCUSTFLD3: TWideStringField;
    qryemployeesphotoCUSTFLD4: TWideStringField;
    qryemployeesphotoCUSTFLD5: TWideStringField;
    qryemployeesphotoCUSTFLD6: TWideStringField;
    qryemployeesphotoCUSTFLD7: TWideStringField;
    qryemployeesphotoCUSTFLD8: TWideStringField;
    qryemployeesphotoCUSTFLD9: TWideStringField;
    qryemployeesphotoCUSTFLD10: TWideStringField;
    qryemployeesphotoCUSTFLD11: TWideStringField;
    qryemployeesphotoCUSTFLD12: TWideStringField;
    qryemployeesphotoCUSTFLD13: TWideStringField;
    qryemployeesphotoCUSTFLD14: TWideStringField;
    qryemployeesphotoCUSTFLD15: TWideStringField;
    qryemployeesphotoEditedFlag: TWideStringField;
    qryemployeesphotoEmployeeNo: TIntegerField;
    qryemployeesphotoTFN: TWideStringField;
    qryemployeesphotoDOB: TDateField;
    qryemployeesphotoInitials: TWideStringField;
    qryemployeesphotoSex: TWideStringField;
    qryemployeesphotoOptionNo: TWordField;
    qryemployeesphotoTax: TFloatField;
    qryemployeesphotoGross: TFloatField;
    qryemployeesphotoNet: TFloatField;
    qryemployeesphotoWages: TFloatField;
    qryemployeesphotoCommission: TFloatField;
    qryemployeesphotoDeductions: TFloatField;
    qryemployeesphotoAllowances: TFloatField;
    qryemployeesphotoSundries: TFloatField;
    qryemployeesphotoSuper: TFloatField;
    qryemployeesphotoCDEProject: TWideStringField;
    qryemployeesphotoFringeBenefits: TFloatField;
    qryemployeesphotoDaysPre01071983: TIntegerField;
    qryemployeesphotoDaysPost30061983: TIntegerField;
    qryemployeesphotoCGTExempt: TFloatField;
    qryemployeesphotoNonQualifyingComponent: TFloatField;
    qryemployeesphotoUndeductedContribution: TFloatField;
    qryemployeesphotoConcessionalComponent: TFloatField;
    qryemployeesphotoRepCode: TWideStringField;
    qryemployeesphotoResident: TWideStringField;
    qryemployeesphotoTFNApplicationMade: TWideStringField;
    qryemployeesphotoUnder18: TWideStringField;
    qryemployeesphotoPensioner: TWideStringField;
    qryemployeesphotoIncomeType: TWideStringField;
    qryemployeesphotoBasisOfPayment: TWideStringField;
    qryemployeesphotoTaxFreeThreshold: TWideStringField;
    qryemployeesphotoFamilyTaxBenefit: TWideStringField;
    qryemployeesphotoZoneDependentSpecial: TWideStringField;
    qryemployeesphotoHECSIndicator: TWideStringField;
    qryemployeesphotoStudentLoanIndicator: TWideStringField;
    qryemployeesphotoUseOfTFNForSuper: TWideStringField;
    qryemployeesphotoAnnuitySuperPension: TWideStringField;
    qryemployeesphotoSignaturePresent: TWideStringField;
    qryemployeesphotoDateSigned: TDateField;
    qryemployeesphotoPayVia: TWideStringField;
    qryemployeesphotoEmployeeName: TWideStringField;
    qryemployeesphotoReportsTo: TIntegerField;
    qryemployeesphotoPayPeriod: TWideStringField;
    qryemployeesphotoAward: TIntegerField;
    qryemployeesphotoClassification: TWideStringField;
    qryemployeesphotoWorkersCompInsurer: TIntegerField;
    qryemployeesphotoUseAward: TWideStringField;
    qryemployeesphotoNextOfKin: TWideStringField;
    qryemployeesphotoNextOfKinRelationship: TWideStringField;
    qryemployeesphotoNextOfKinPhone: TWideStringField;
    qryemployeesphotoTaxScaleID: TIntegerField;
    qryemployeesphotoLeaveLoading: TFloatField;
    qryemployeesphotoExtraTax: TFloatField;
    qryemployeesphotoSickHours: TFloatField;
    qryemployeesphotoALHours: TFloatField;
    qryemployeesphotoLastPaid: TDateField;
    qryemployeesphotoCommissionOnValue: TWideStringField;
    qryemployeesphotoCommissionLastPaid: TDateField;
    qryemployeesphotoGlobalRef: TWideStringField;
    qryemployeesphotoPayNotes: TWideMemoField;
    qryemployeesphotoIsOnTheRoster: TWideStringField;
    qryemployeesphotoLoadHoursFromRoster: TWideStringField;
    qryemployeesphotoLoadLeaveFromRoster: TWideStringField;
    qryemployeesphotoMealBreakHours: TFloatField;
    qryemployeesphotoMealBreakThreshold: TFloatField;
    qryemployeesphotoAreaRange: TWideStringField;
    qryemployeesphotoPhotoIDVaildFromDate: TDateField;
    qryemployeesphotoPhotoIDVaildToDate: TDateField;
    qryemployeesphotoCDEPWageTotal: TFloatField;
    qryemployeesphotoIsTerminated: TWideStringField;
    qryemployeesphotoDefaultClassName: TWideStringField;
    qryemployeesphotoDefaultClassID: TIntegerField;
    qryemployeesphotoExtraTaxOptions: TWideStringField;
    qryemployeesphotoUseClassificationAdvance: TWideStringField;
    qryemployeesphotoLastPayPeriod: TSmallintField;
    qryemployeesphotoCommissionFlatRate: TFloatField;
    qryemployeesphotoCommissionInvoiceExPrice: TWideStringField;
    qryemployeesphotoCommissionUseEmp: TWideStringField;
    qryemployeesphotoCommissionUseProd: TWideStringField;
    qryemployeesphotoDefaultInvoiceTemplateID: TIntegerField;
    qryemployeesphotoPaySuperOnLeaveLoading: TWideStringField;
    qryemployeesphotoLastUpdated: TDateTimeField;
    qryemployeesphotoSalesTarget: TFloatField;
    qryemployeesphotoSendPaySlipViaEmail: TWideStringField;
    qryemployeesphotoEmailsFromEmployeeAddress: TWideStringField;
    qryemployeesphotoStreet: TWideStringField;
    qryemployeesphotoStreet2: TWideStringField;
    qryemployeesphotoSuburb: TWideStringField;
    qryemployeesphotoPostcode: TWideStringField;
    qryemployeesphotoState: TWideStringField;
    qryemployeesphotoCountry: TWideStringField;
    qryemployeesphotoPhone: TWideStringField;
    qryemployeesphotoAltPhone: TWideStringField;
    qryemployeesphotoFaxNumber: TWideStringField;
    qryemployeesphotoMobile: TWideStringField;
    qryemployeesphotoEmail: TWideStringField;
    qryemployeesphotoAltContact: TWideStringField;
    qryemployeesphotoCompany: TWideStringField;
    qryemployeesphotoPosition: TWideStringField;
    DSEmployeesPhoto: TDataSource;
    imgPhoto: TDBImage;
    btnAddPic: TDNMSpeedButton;
    btnStretch: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    Label17: TLabel;
    Label18: TLabel;
    dtTo: TwwDBDateTimePicker;
    dtFrom: TwwDBDateTimePicker;
    Button1: TDNMSpeedButton;
    btnClearPic: TDNMSpeedButton;
    qryPhotoBlob: TERPQuery;
    qryPhotoBlobEmployeeID: TIntegerField;
    OpenDialog1: TOpenDialog;
    DataSourceBlob: TDataSource;
    qryPhotoBlobEmployeePic: TBlobField;
    qryemployeesphotoOverheadbaserate: TFloatField;
    procedure btnAddPicClick(Sender: TObject);
    procedure btnClearPicClick(Sender: TObject);
    procedure btnStretchClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure dtFromCloseUp(Sender: TObject);
    procedure dtToCloseUp(Sender: TObject);
  private
    fEmployeeID:integer;
    function ConfirmStorage: Boolean;
  public
    KeyID:integer;
    EmpPay:Temployeepay;
    property EmployeeID :integer read fEmployeeID write fEmployeeID;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
  end;

implementation
uses
  FastFuncs,Jpeg,AppEnvironment, CommonLib,PrintTemplateObj, BusObjConst;
{$R *.dfm}   
  
function TEmployeePhoto.ConfirmStorage: Boolean;
begin
  Result := True;

  if TBlobField(qryPhotoBlob.FieldByName('EmployeePic')).BlobSize > 2000000 then begin
    CommonLib.MessageDlgXP_Vista('This picture is too large.',mtInformation,[mbOK], 0);
    Result := False;
    exit;
  end;

  if TBlobField(qryPhotoBlob.FieldByName('EmployeePic')).BlobSize > 300000 then begin
    if CommonLib.MessageDlgXP_Vista('This picture is large (more than 300k) and may slow processing. Use anyway?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
      TBlobField(qryPhotoBlob.FieldByName('EmployeePic')).AsVariant := Null;
      Result := False;
    end;
  end;
end;

procedure TEmployeePhoto.btnAddPicClick(Sender: TObject);
var
  Bitmap: TBitmap;
  JPegImage: TJPegImage;
begin
  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then begin
      qryphotoBlob.Edit;
      if Sysutils.SameText(ExtractFileExt(OpenDialog1.FileName), '.bmp') then begin
        qryPhotoBlobEmployeePic.LoadFromFile(OpenDialog1.FileName);

        if ConfirmStorage then
          imgPhoto.Show
        else
          imgPhoto.Hide;
      end
      else begin
        Bitmap := TBitmap.Create;
        JPegImage := TJPegImage.Create;

        try
          JPegImage.LoadFromFile(OpenDialog1.FileName);
          Bitmap.Assign(JPegImage);
          TBlobField(qryPhotoBlob.FieldByName('EmployeePic')).Assign(Bitmap);

          if ConfirmStorage then
            imgPhoto.Show
          else
            imgPhoto.Hide;
        finally
          FreeandNil(Bitmap);
          FreeandNil(JPegImage);
        end;
      end;
    end;
    qryPhotoBlob.FieldByName('EmployeeID').AsInteger := EmpPay.EmployeeDetails.Id;
    qryphotoBlob.Post;
  end;  
end;

procedure TEmployeePhoto.btnClearPicClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to Delete this Employee''s Picture?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    qryPhotoBlob.Edit;
    TBlobField(qryPhotoBlob.FieldByName('EmployeePic')).Clear;
    qryPhotoBlob.Post;
  end;
end;

procedure TEmployeePhoto.btnStretchClick(Sender: TObject);
begin
  if btnStretch.Down then
    imgPhoto.Stretch := true
  else
    imgPhoto.Stretch := false;
end;

procedure TEmployeePhoto.Button1Click(Sender: TObject);
var
  sSQL:string;
  PrintTemplate :TPrintTemplates;
begin
  PrintTemplate := TPrintTemplates.Create;
  try
    sSQL := Format('AND tblEmployees.EmployeeID = %d', [fEmployeeID]) ;
    PrintTemplate.PrintTemplateReport('Employee Photo ID', sSQL, not AppEnv.Employee.ShowPreview, 1, qryPhotoBlob.Connection);
  finally
  FreeAndNil(PrintTemplate);
end;
end;

procedure TEmployeePhoto.dtFromCloseUp(Sender: TObject);
begin
  inherited;
    if not qryemployeesphoto.Active then begin
      qryemployeesphoto.Params.ParamByName('xID').AsInteger := KeyID;
      qryemployeesphoto.Open;
    end;
    qryemployeesphoto.Edit;
    qryemployeesphoto.FieldByName('PhotoIDVaildFromDate').AsDateTime := dtFrom.Date;
    qryemployeesphoto.Post;
end;

procedure TEmployeePhoto.dtToCloseUp(Sender: TObject);
begin
  inherited;
  if not qryemployeesphoto.Active then begin
      qryemployeesphoto.Params.ParamByName('xID').AsInteger := KeyID;
      qryemployeesphoto.Open;
    end;
    qryemployeesphoto.Edit;
    qryemployeesphoto.FieldByName('PhotoIDVaildToDate').AsDateTime := dtTo.Date;
    qryemployeesphoto.Post;
end;

procedure TEmployeePhoto.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if Value = BusobjEventVal_FailedPhoto_IDValidateData then begin
    // HandleEmployeePhoto_IDErrors; {No Need For Error Handling Yet ?? }
  end;
end;

initialization
  RegisterClassOnce(TEmployeePhoto);

end.
