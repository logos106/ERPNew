unit EmployeeCustomFieldsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  DB, MemDS, DBAccess, MyAccess,ERPdbComponents, ExtCtrls, DNMPanel,BusObjEmployeePay,
  frmBase, BusObjBase, wwdbdatetimepicker, Menus;

type
  TEmployeeCustomFields = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    DSEmployees: TDataSource;
    qryemployeesCustom: TERPQuery;
    qryemployeesCustomEmployeeID: TAutoIncField;
    qryemployeesCustomTitle: TWideStringField;
    qryemployeesCustomFirstName: TWideStringField;
    qryemployeesCustomMiddleName: TWideStringField;
    qryemployeesCustomLastName: TWideStringField;
    qryemployeesCustomABN: TWideStringField;
    qryemployeesCustomCanvasser: TWideStringField;
    qryemployeesCustomRep: TWideStringField;
    qryemployeesCustomCreationDate: TDateField;
    qryemployeesCustomDateStarted: TDateField;
    qryemployeesCustomDateFinished: TDateField;
    qryemployeesCustomNotes: TWideMemoField;
    qryemployeesCustomActive: TWideStringField;
    qryemployeesCustomCUSTFLD1: TWideStringField;
    qryemployeesCustomCUSTFLD2: TWideStringField;
    qryemployeesCustomCUSTFLD3: TWideStringField;
    qryemployeesCustomCUSTFLD4: TWideStringField;
    qryemployeesCustomCUSTFLD5: TWideStringField;
    qryemployeesCustomCUSTFLD6: TWideStringField;
    qryemployeesCustomCUSTFLD7: TWideStringField;
    qryemployeesCustomCUSTFLD8: TWideStringField;
    qryemployeesCustomCUSTFLD9: TWideStringField;
    qryemployeesCustomCUSTFLD10: TWideStringField;
    qryemployeesCustomCUSTFLD11: TWideStringField;
    qryemployeesCustomCUSTFLD12: TWideStringField;
    qryemployeesCustomCUSTFLD13: TWideStringField;
    qryemployeesCustomCUSTFLD14: TWideStringField;
    qryemployeesCustomCUSTFLD15: TWideStringField;
    qryemployeesCustomEditedFlag: TWideStringField;
    qryemployeesCustomEmployeeNo: TIntegerField;
    qryemployeesCustomTFN: TWideStringField;
    qryemployeesCustomDOB: TDateField;
    qryemployeesCustomInitials: TWideStringField;
    qryemployeesCustomSex: TWideStringField;
    qryemployeesCustomOptionNo: TWordField;
    qryemployeesCustomTax: TFloatField;
    qryemployeesCustomGross: TFloatField;
    qryemployeesCustomNet: TFloatField;
    qryemployeesCustomWages: TFloatField;
    qryemployeesCustomCommission: TFloatField;
    qryemployeesCustomDeductions: TFloatField;
    qryemployeesCustomAllowances: TFloatField;
    qryemployeesCustomSundries: TFloatField;
    qryemployeesCustomSuper: TFloatField;
    qryemployeesCustomCDEProject: TWideStringField;
    qryemployeesCustomRepCode: TWideStringField;
    qryemployeesCustomResident: TWideStringField;
    qryemployeesCustomTFNApplicationMade: TWideStringField;
    qryemployeesCustomUnder18: TWideStringField;
    qryemployeesCustomPensioner: TWideStringField;
    qryemployeesCustomIncomeType: TWideStringField;
    qryemployeesCustomBasisOfPayment: TWideStringField;
    qryemployeesCustomTaxFreeThreshold: TWideStringField;
    qryemployeesCustomFamilyTaxBenefit: TWideStringField;
    qryemployeesCustomZoneDependentSpecial: TWideStringField;
    qryemployeesCustomHECSIndicator: TWideStringField;
    qryemployeesCustomStudentLoanIndicator: TWideStringField;
    qryemployeesCustomUseOfTFNForSuper: TWideStringField;
    qryemployeesCustomAnnuitySuperPension: TWideStringField;
    qryemployeesCustomSignaturePresent: TWideStringField;
    qryemployeesCustomDateSigned: TDateField;
    qryemployeesCustomPayVia: TWideStringField;
    qryemployeesCustomEmployeeName: TWideStringField;
    qryemployeesCustomReportsTo: TIntegerField;
    qryemployeesCustomPayPeriod: TWideStringField;
    qryemployeesCustomAward: TIntegerField;
    qryemployeesCustomClassification: TWideStringField;
    qryemployeesCustomWorkersCompInsurer: TIntegerField;
    qryemployeesCustomUseAward: TWideStringField;
    qryemployeesCustomNextOfKin: TWideStringField;
    qryemployeesCustomNextOfKinRelationship: TWideStringField;
    qryemployeesCustomNextOfKinPhone: TWideStringField;
    qryemployeesCustomTaxScaleID: TIntegerField;
    qryemployeesCustomLeaveLoading: TFloatField;
    qryemployeesCustomExtraTax: TFloatField;
    qryemployeesCustomSickHours: TFloatField;
    qryemployeesCustomALHours: TFloatField;
    qryemployeesCustomLastPaid: TDateField;
    qryemployeesCustomCommissionOnValue: TWideStringField;
    qryemployeesCustomCommissionLastPaid: TDateField;
    qryemployeesCustomGlobalRef: TWideStringField;
    qryemployeesCustomPayNotes: TWideMemoField;
    qryemployeesCustomIsOnTheRoster: TWideStringField;
    qryemployeesCustomLoadHoursFromRoster: TWideStringField;
    qryemployeesCustomLoadLeaveFromRoster: TWideStringField;
    qryemployeesCustomMealBreakHours: TFloatField;
    qryemployeesCustomMealBreakThreshold: TFloatField;
    qryemployeesCustomAreaRange: TWideStringField;
    qryemployeesCustomEmpPicture: TBlobField;
    qryemployeesCustomPhotoIDVaildFromDate: TDateField;
    qryemployeesCustomPhotoIDVaildToDate: TDateField;
    qryemployeesCustomCDEPWageTotal: TFloatField;
    qryemployeesCustomIsTerminated: TWideStringField;
    qryemployeesCustomDefaultClassName: TWideStringField;
    qryemployeesCustomDefaultClassID: TIntegerField;
    qryemployeesCustomExtraTaxOptions: TWideStringField;
    qryemployeesCustomUseClassificationAdvance: TWideStringField;
    qryemployeesCustomLastPayPeriod: TSmallintField;
    qryemployeesCustomCommissionFlatRate: TFloatField;
    qryemployeesCustomCommissionInvoiceExPrice: TWideStringField;
    qryemployeesCustomCommissionUseEmp: TWideStringField;
    qryemployeesCustomCommissionUseProd: TWideStringField;
    qryemployeesCustomDefaultInvoiceTemplateID: TIntegerField;
    qryemployeesCustomPaySuperOnLeaveLoading: TWideStringField;
    qryemployeesCustomLastUpdated: TDateTimeField;
    qryemployeesCustomSalesTarget: TFloatField;
    qryemployeesCustomSendPaySlipViaEmail: TWideStringField;
    qryemployeesCustomEmailsFromEmployeeAddress: TWideStringField;
    qryemployeesCustomStreet: TWideStringField;
    qryemployeesCustomStreet2: TWideStringField;
    qryemployeesCustomSuburb: TWideStringField;
    qryemployeesCustomPostcode: TWideStringField;
    qryemployeesCustomState: TWideStringField;
    qryemployeesCustomCountry: TWideStringField;
    qryemployeesCustomPhone: TWideStringField;
    qryemployeesCustomAltPhone: TWideStringField;
    qryemployeesCustomFaxNumber: TWideStringField;
    qryemployeesCustomMobile: TWideStringField;
    qryemployeesCustomEmail: TWideStringField;
    qryemployeesCustomAltContact: TWideStringField;
    qryemployeesCustomCompany: TWideStringField;
    qryemployeesCustomPosition: TWideStringField;
    pnlCustFields: TDNMPanel;
    CUSTFLD1: TwwDBComboBox;
    CUSTFLD2: TwwDBComboBox;
    CUSTFLD3: TwwDBComboBox;
    CUSTFLD4: TwwDBComboBox;
    CUSTFLD5: TwwDBComboBox;
    CUSTFLD6: TwwDBComboBox;
    CUSTFLD7: TwwDBComboBox;
    CUSTFLD8: TwwDBComboBox;
    CUSTFLD9: TwwDBComboBox;
    CUSTFLD10: TwwDBComboBox;
    CUSTFLD11: TwwDBComboBox;
    CUSTFLD12: TwwDBComboBox;
    CUSTFLD13: TwwDBComboBox;
    CUSTFLD14: TwwDBComboBox;
    CUSTFLD15: TwwDBComboBox;
    cmdCustomLabelsOld: TDNMSpeedButton;
    CUSTLBL1: TLabel;
    CUSTLBL2: TLabel;
    CUSTLBL3: TLabel;
    CUSTLBL4: TLabel;
    CUSTLBL5: TLabel;
    CUSTLBL6: TLabel;
    CUSTLBL7: TLabel;
    CUSTLBL8: TLabel;
    CUSTLBL9: TLabel;
    CUSTLBL10: TLabel;
    CUSTLBL11: TLabel;
    CUSTLBL12: TLabel;
    CUSTLBL13: TLabel;
    CUSTLBL14: TLabel;
    CUSTLBL15: TLabel;
    qryCustomFields: TERPQuery;
    MyConnection1: TERPConnection;
    qryemployeesCustomCommissionOn: TWideStringField;
    qryemployeesCustomOverheadbaserate: TFloatField;
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure SetSubEmpPay(Const Value :Temployeepay );
  private
    fSubEmpPay:Temployeepay;

  public
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
    procedure CustomFieldsRefresh;
  end;  

implementation
uses
  frmCustomFieldsFrm,CommonLib, BusObjConst,CommonDBLib,FastFuncs, DNMLib,
  CommonFormLib;
{$R *.dfm}

procedure TEmployeeCustomFields.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

procedure TEmployeeCustomFields.cmdCustomLabelsOldClick(Sender: TObject);
begin
    OpenERPForm('TfrmCustomFields' , 0);
(*var
  Form:TComponent;
begin
  Form := GetComponentByClassName('TfrmCustomFields');
  if Assigned(Form) then begin
    with TfrmCustomFields(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;*)
end;

procedure TEmployeeCustomFields.CustomFieldsRefresh;
var
  ctr:Integer;
begin
  qryEmployeesCustom.Close;
  qryEmployeesCustom.Connection := CommonDbLib.GetSharedMyDacConnection;;
  qryEmployeesCustom.Open;

  qryCustomFields.close;
  qryCustomFields.connection := CommonDbLib.GetSharedMyDacConnection;
  qryCustomFields.Open;
  for ctr := 1 to 15(*18*) do begin
    try
      TLabel(FindComponent('CUSTLBL' + Trim(IntToStr(ctr)))).Caption :=
        qryCustomFields.FieldByName('CFLabel' + Trim(IntToStr(ctr))).AsString;
        TLabel(FindComponent('CUSTLBL' + Trim(IntToStr(ctr)))).enabled :=
          qryCustomFields.FieldByName('CFEmpl' + Trim(IntToStr(ctr))).AsString='T';
    except(*kill the exception*) end;
    try
      if ctr<16 then
        TwwDBComboBox(FindComponent('CUSTFLD' + Trim(IntToStr(ctr)))).Enabled :=
          qryCustomFields.FieldByName('CFEmpl' + Trim(IntToStr(ctr))).AsString='T'
      else
        TwwDBDateTimePicker(FindComponent('CUSTDATE' + Trim(IntToStr(ctr - 15)))).Enabled :=
          qryCustomFields.FieldByName('CFProduct' + Trim(IntToStr(ctr - 15))).AsString='T'
      except(*kill the exception*) end;
  end;
  qryCustomFields.Close;
  PopulateCustomCombos(pnlCustFields);
  if not qryEmployeesCustom.Active then qryEmployeesCustom.Open;
end;


procedure TEmployeeCustomFields.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if Value = BusobjEventVal_FailedCustom_FieldsValidateData then begin

  end;
end;

initialization
  RegisterClassOnce(TEmployeeCustomFields);
end.



