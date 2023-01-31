{ Builds the empdupe file/s for electronic lodgment to ATO. The empdupe file/s
  are tested and sent via the governments free application ECI Client v5 }

unit PayEmpdupeObj;

interface
uses
  MyAccess,ERPdbComponents,DB;
type
  TPayEmpdupeObj = class(TObject)
  private
    fErrorMessage:string;
    F: TextFile;
    fiNumRecs: integer;
    procedure ShowCompanyInformationForm;

//    function FillString(const Str: string; const StrLength: integer; const FillChar: char; const InFront: boolean): string;
    procedure AddLinetoFile(const StrData: string);
    procedure AddSupplierRecs(const iSubmissionID,iYear:Integer);

  public
    procedure CreateATOFileHeader(const sFileName:String; const iSubmissionID,iYear:integer);
    function AddIndividual(const iEmployeeID,iYear:integer;Const IsTerminated:String):String;
    function AddVoluntary(const iEmployeeID :integer):String;
    function AddLabourHire(const iEmployeeID :integer):String;
    function AddPersonalServices(const iEmployeeID :integer):String;
    function AddETP(const iEmployeeID :integer):String;
    procedure AddPayer(const iYear:integer; const ETPFlag:String);
    procedure AddSoftwareRec;
    procedure AddFileTotalRec;
    procedure CloseExportFile;

  end;

implementation
uses
  Classes, CommonDbLib, Dialogs, SysUtils, StrUtils,Forms,CommonLib,
  FastFuncs, PAYG_Calcs, windows, ATODataObj, DNMLib, AppEnvironment;

procedure TPayEmpdupeObj.AddFileTotalRec;
var
  TempLine:String;
  sNoOfRecs: String;
  Rec: TTotalRec;
begin
  sNoOfRecs := IntToStr(fiNumRecs +  1);
//  TempLine := '628' +
//      'FILE-TOTAL' +
//      FillString(sNoOfRecs,8,#48,True) +
//      FillString(' ',607,#32,False);

  Rec:= TTotalRec.Create;
  try
    Rec.O['NumberOfRecords'].I['Value'] := fiNumRecs +  1;
    TempLine := Rec.RecordString;
  finally
    Rec.Free;
  end;


  if (char_length(TempLine) <> 628)  then begin
    CommonLib.MessageDlgXP_Vista('File Total file format error.', mtWarning, [mbOK], 0);
    exit;
  end;
  AddLinetoFile(TempLine);
end;

function TPayEmpdupeObj.AddIndividual(Const iEmployeeID,iYear:integer;Const IsTerminated:String):String;
var
  qry,qryTerminated,(*qryPay,*)(*QrySuper, *)qryDed: TERPQuery;
  TempLine:String;
  sDataMissing:String;
  sTFN,sDOB,sDateStart,sDateEnd : String;
  dTotalTax,dTotalAllowances,dLumpA,dLumpB,dLumpD,dLumpE,dCDEP,dUnionFees, dSuper: double;
//  dOther: double;
  dReportableFB,dGrossPayments: double;
  EmpPAYG_Figures :TEmpPAYG_Figures;
  Rec: TPAYGSumRec;
  LumpSumPaymentAType: string;
begin
  LumpSumPaymentAType := '';
  qry := TERPQuery.Create(nil);
  qryTerminated := TERPQuery.Create(nil);
  //qryPay := TERPQuery.Create(nil);
  qryDed := TERPQuery.Create(nil);
  //QrySuper:= TERPQuery.Create(nil);
  try
    sDataMissing := '';
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblemployees WHERE EmployeeID = ');
    qry.SQL.Add(IntToStr(iEmployeeID));
    qry.Open;

    qryDed.Connection := CommonDbLib.GetSharedMyDacConnection;

            //note: if employee is applying for TFN it should be set to 111111111 in the employee form
    if empty(qry.FieldByName('TFN').AsString) then sTFN := '000000000' else sTFN := qry.FieldByName('TFN').AsString;
    if empty(qry.FieldByName('DOB').AsString) then sDOB := '00000000' else sDOB := FormatDateTime('ddmmyyyy',qry.FieldByName('DOB').AsDateTime);

    //TO DO set if started later in the year assign value
    sDateStart := '0107' + IntToStr(iYear - 1);

    if IsTerminated = 'F' then sDateEnd := '3006' + IntToStr(iYear) else sDateEnd := FormatDateTime('ddmmyyyy',qry.FieldByName('DateFinished').AsDateTime);
(*  Old code used with old termination wizard
    if IsTerminated = 'T' then begin
      with qryTerminated do begin
        Connection := CommonDbLib.GetSharedMyDacConnection;
        SQL.Clear;
        SQL.Add('SELECT * FROM tblemployeeterminations WHERE EmployeeID = ');
        SQL.Add(IntToStr(iEmployeeID));
        Open;
        Last;

        qryPay.Connection := CommonDbLib.GetSharedMyDacConnection;
        qryPay.SQL.Clear;
        qryPay.SQL.Add('SELECT P.*,ET.LumpSumA,ET.LumpSumB,ET.LumpSumC,ET.LumpSumD,ET.LumpSumE');
        qryPay.SQL.Add('FROM tblpays P');
        qryPay.SQL.Add('INNER JOIN tblemployeeterminations ET ON P.EmployeeID = ET.EmployeeId');
        qryPay.SQL.Add('WHERE P.PayID = ') ;
        qryPay.SQL.Add(IntToStr(FieldByName('PayID').AsInteger));
        qryPay.Open;


        QrySuper.Connection := CommonDbLib.GetSharedMyDacConnection;
        QrySuper.SQL.Clear;
        QrySuper.SQL.Add('select Sum(PS.AmountPaid) as AmountPaid from tblpayssuperannuation PS ') ;
        QrySuper.SQL.Add('inner join tblsupertype ST on PS.SuperTypeID = ST.SuperTypeID and ST.IncludeInEmployeereportableContribution ="T" ') ;
        QrySuper.SQL.Add('where PS.PayID =  ' + IntToStr(FieldByName('PayID').AsInteger));
        QrySuper.Open;

        dTotalTax := FieldByName('TaxWithheld').AsFloat;  //CHECK THIS IS GETTING THE RIGHT DATA
        dGrossPayments := FieldByName('GrossTermination').AsFloat;
        dTotalAllowances  := FieldByName('TotalAllowances').AsFloat;

        dCDEP  := FieldByName('CDEP').AsFloat;
        dReportableFB := FieldByName('ReportableFB').AsFloat;

        dLumpA := qryPay.FieldByName('LumpSumA').AsFloat;
        dLumpB := qryPay.FieldByName('LumpSumB').AsFloat;
        dLumpD := qryPay.FieldByName('LumpSumD').AsFloat;
        dLumpE := qryPay.FieldByName('LumpSumE').AsFloat;
        dSuper := QrySuper.FieldByName('AmountPaid').AsFloat;
//        dOther := qryPay.FieldByName('LumpSumE').AsFloat;
//        dUnionFees :=

        {  7.69	Lump sum payment A type – indicator to identify the type of Lump
                sum payment A. If Lump sum payment A field is greater than zero,
                this field must be set to one of the following:

           R – where payment was for a genuine redundancy, invalidity or
               under an early retirement scheme.
           T – where payment was not a payment for a genuine redundancy,
               invalidity or under an early retirement scheme.

           Blank fill this field if Lump sum payment A field is zero.
        }

        if dLumpA <> 0 then begin
          if SameText(FieldByName('ReasonLeft').AsString,'Redundancy') or
             SameText(FieldByName('ReasonLeft').AsString,'Invalidity') or
             SameText(FieldByName('ReasonLeft').AsString,'Early Retirement') then
            LumpSumPaymentAType := 'R'
          else
            LumpSumPaymentAType := 'T'
        end;
      end;

      { union fees }
      qryDed.SQL.Add('select sum(UnionFees) as UnionFees');
      qryDed.SQL.Add('from tblPays, tblPaysDeductions');
      qryDed.SQL.Add('where tblPays.PayID = tblPaysDeductions.PayID');
      qryDed.SQL.Add('and tblPays.EmployeeID = ' + IntToStr(iEmployeeID));
      qryDed.SQL.Add('and tblPays.Paid = "T" and tblPays.Deleted = "F"');
      qryDed.SQL.Add('and tblPaysDeductions.UnionFees = "T"');
      qryDed.SQL.Add('and tblPays.DatePaid between');
      qryDed.SQL.Add('"' + FormatDateTime('yyyy-mm-dd',EncodeDate(iYear-1,GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts),1)) + '"');
      qryDed.SQL.Add('and "' + FormatDateTime('yyyy-mm-dd',qry.FieldByName('DateFinished').AsDateTime) + '"');
      qryDed.Open;
      dUnionFees := qryDed.FieldByName('UnionFees').AsFloat;

    end else begin
*)
        { not terminated }
        EmpPAYG_Figures.EmployeeID := iEmployeeID;
        EmpPAYG_Figures.Year := iYear;
        PAYG_Calcs.GetEmployeePAYG_Figures(EmpPAYG_Figures);
        dTotalTax := EmpPAYG_Figures.Tax;
        dGrossPayments := EmpPAYG_Figures.Gross;
        dTotalAllowances  := EmpPAYG_Figures.Allowances;
        dLumpA := EmpPAYG_Figures.LumpA;
        dLumpB := EmpPAYG_Figures.LumpB;
        dLumpD := EmpPAYG_Figures.LumpD;
        dLumpE := EmpPAYG_Figures.LumpE;
        dSuper := EmpPAYG_Figures.Super;
        dCDEP  := EmpPAYG_Figures.CDEP;
//        dOther  := EmpPAYG_Figures.Other;
        dReportableFB := EmpPAYG_Figures.ReportableFB;
        dUnionFees := EmpPAYG_Figures.UnionFees;
(*
    end;
*)

    //check if mandatory data exists
    if empty(qry.FieldByName('TFN').AsString) then sDataMissing := 'Missing TFN';
    if iYear = 0 then sDataMissing := 'Missing Year';
    if empty(qry.FieldByName('DOB').AsString) then sDataMissing := 'Missing DOB';
    if empty(qry.FieldByName('FirstName').AsString) then sDataMissing := 'Missing First Name';
    if empty(qry.FieldByName('LastName').AsString) then sDataMissing := 'Missing Last Name';
    if empty(qry.FieldByName('Street').AsString) then sDataMissing := 'Missing Street';
    if empty(qry.FieldByName('Suburb').AsString) then sDataMissing := 'Missing Suburb';
    if empty(qry.FieldByName('State').AsString) then sDataMissing := 'Missing State';
    if empty(qry.FieldByName('Postcode').AsString) then sDataMissing := 'Missing Postcode';
    if sDateEnd = '' then sDataMissing := 'Missing End Date';
    if empty(qry.FieldByName('Tax').AsString) then sDataMissing := 'Missing Tax';
    if empty(qry.FieldByName('Gross').AsString) then sDataMissing := 'Missing Gross';
    if empty(qry.FieldByName('Allowances').AsString) then sDataMissing := 'Missing Allowances';
(*
    if IsTerminated = 'T' then begin
      if qryPay.FieldByName('LumpSumA').AsFloat < 0 then sDataMissing := 'Missing LumpSum A';
      if qryPay.FieldByName('LumpSumB').AsFloat < 0 then sDataMissing := 'Missing LumpSum B';
      if qryPay.FieldByName('LumpSumD').AsFloat < 0 then sDataMissing := 'Missing LumpSum D';
      if qryPay.FieldByName('LumpSumE').AsFloat < 0 then sDataMissing := 'Missing LumpSum E';
    end;
*)
    if empty(qry.FieldByName('CDEPWageTotal').AsString) then sDataMissing := 'Missing CDEP';
    if empty(qry.FieldByName('FringeBenefits').AsString) then sDataMissing := 'Missing Fringe Benefits';

//    TempLine := '628DINBS' + //Income type hard coded to S for salary or wage income
//      FillString(sTFN,9,#32,False) +
//      FillString(sDOB,8,#32,False) +
//      FillString(qry.FieldByName('LastName').AsString,30,#32,False) +
//      FillString(qry.FieldByName('FirstName').AsString,15,#32,False) +
//      FillString(qry.FieldByName('MiddleName').AsString,15,#32,False) +
//      FillString(qry.FieldByName('Street').AsString,38,#32,False) +
//      FillString(qry.FieldByName('Street2').AsString,38,#32,False) +
//      FillString(qry.FieldByName('Suburb').AsString,27,#32,False) +
//      FillString(qry.FieldByName('State').AsString,3,#32,False) +
//      FillString(qry.FieldByName('PostCode').AsString,4,#32,False) +
//      FillString(qry.FieldByName('Country').AsString,20,#32,False) +
//      FillString(sDateStart,8,#32,False) +
//      FillString(sDateEnd,8,#32,False) +
//      FillString(FormatFloat('#######0',dTotalTax),8,#48,True) +
//
//      FillString(FormatFloat('#######0',dGrossPayments),8,#48,True) +
//
//      FillString(FormatFloat('#######0',dTotalAllowances),8,#48,True) +
//      FillString(FormatFloat('#######0',dLumpA),8,#48,True) +
//      FillString(FormatFloat('#######0',dLumpB),8,#48,True) +
//      FillString(FormatFloat('#######0',dLumpD),8,#48,True) +
//      FillString(FormatFloat('#######0',dLumpE),8,#48,True) +
//      FillString(FormatFloat('#######0',dCDEP),8,#48,True) +
//      FillString(FormatFloat('#######0',dOther),8,#48,True) +
//      FillString(FormatFloat('#######0',dReportableFB),8,#48,True) +
//      FillString(' ',317,#32,False);

    Rec:= TPAYGSumRec.Create;
    try
      Rec.O['IncomeType'].S['Value'] := 'S'; { salary or wage income }
      if (Trim(qry.FieldByName('TFN').AsString)<>'') and isinteger(qry.FieldByName('TFN').AsString) then Rec.O['PayeeTaxFileNumber'].I['Value'] := qry.FieldByName('TFN').AsInteger;
      Rec.O['PayeeDOB'].DT['Value'] := qry.FieldByName('DOB').AsDateTime;
      Rec.O['PayeeSurname'].S['Value'] := qry.FieldByName('LastName').AsString;
      Rec.O['PayeeFirstName'].S['Value'] := qry.FieldByName('FirstName').AsString;
      Rec.O['PayeeSecondName'].S['Value'] := qry.FieldByName('MiddleName').AsString;
      Rec.O['PayeeAddressLine1'].S['Value'] := qry.FieldByName('Street').AsString;
      Rec.O['PayeeAddressLine2'].S['Value'] := qry.FieldByName('Street2').AsString;
      Rec.O['PayeeSuburb'].S['Value'] := qry.FieldByName('Suburb').AsString;
      Rec.O['PayeeState'].S['Value'] := qry.FieldByName('State').AsString;
      Rec.O['PayeePostCode'].I['Value'] := StrToIntDef(qry.FieldByName('PostCode').AsString,0);
      Rec.O['PayeeCountry'].S['Value'] := qry.FieldByName('Country').AsString;
      Rec.O['PeriodStartDate'].DT['Value'] := EncodeDate(iYear-1,GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts),1);
      if IsTerminated = 'F' then
        Rec.O['PeriodEndDate'].DT['Value'] := EncodeDate(iYear,GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts),1) -1
      else
        Rec.O['PeriodEndDate'].DT['Value'] := qry.FieldByName('DateFinished').AsDateTime;
      Rec.O['TotalTaxWithheld'].F['Value'] := dTotalTax;
      Rec.O['GrossPayments'].F['Value'] := dGrossPayments;
      Rec.O['TotalAllowances'].F['Value'] := dTotalAllowances;
      Rec.O['LumpSumPaymentA'].F['Value'] := dLumpA;
      Rec.O['LumpSumPaymentB'].F['Value'] := dLumpB;
      Rec.O['LumpSumPaymentD'].F['Value'] := dLumpD;
      Rec.O['LumpSumPaymentE'].F['Value'] := dLumpE;
      Rec.O['CommunityDevEmpProj'].F['Value'] := dCDEP;
      Rec.O['ReportableFringeBenifits'].F['Value'] := dReportableFB;
      Rec.O['AmendmentIndicator'].S['Value'] := 'O'; { Original data, not and amendment }
      Rec.O['ReportableEmpSuperContributions'].F['Value'] := dSuper;
      Rec.O['LumpSumPaymentAType'].S['Value'] := LumpSumPaymentAType;
      Rec.O['UnionProfFees'].F['Value'] := dUnionFees;
      Rec.O['ExemptForeignEmploymentIncome'].F['Value'] := 0;
      Rec.O['DeductableAmountOfTheUndeductedPurchasePriceOfTheAnnuity'].F['Value'] := 0;
      TempLine := Rec.RecordString;
    finally
      Rec.Free;
    end;

    if (char_length(TempLine) <> 628) or (sDataMissing <> '') then begin
      if char_length(TempLine) <> 628 then Result := 'File Format Error' else Result := sDataMissing;
        CommonLib.MessageDlgXP_Vista('Employee ' + qry.FieldByName('EmployeeName').AsString + ' ' + result, mtWarning, [mbOK], 0);
      Exit;
    end;
    Result := 'Success';
    AddLinetoFile(TempLine);
  finally
    FreeAndNil(qry);
    FreeAndNil(qryTerminated);
    qryDed.Free;
  end;
end;

function TPayEmpdupeObj.AddETP(Const iEmployeeID :integer):String;
var
  qry,qryTerminated:TERPQuery;
  TempLine:String;
  sDataMissing:String;
  sTFN,sDOB,sDateStart,sDateEnd,sDeathBenefit,sTypeOfDeathBenefit : String;
//  dTotalTax:double;
//  dGrossPayments: double;
//  NoOfDaysBefore1July1983: integer;
//  NoOfDaysAfter30June1983:integer;
//  CGTExemptComponent,NonQualifyingComponent: double;
//  UndeductedContributions: double;
//  ConcessionalComponent: double;
//  PreJuly1983untaxedElement,PostJume1983taxedElement:double;
//  PostJune1983untaxedElement: double;
//  PostJune1994invalidityComponent: double;
//  dAssessable:double;
  ETPSum: TETPSummmaryRec;
begin
  qry := TERPQuery.Create(nil);
  qryTerminated := TERPQuery.Create(nil);
  ETPSum:= TETPSummmaryRec.Create;
  try
    sDataMissing := '';
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblemployees WHERE EmployeeID = ');
    qry.SQL.Add(IntToStr(iEmployeeID));
    qry.Open;

                    //note: if employee is applying for TFN it should be set to 111111111 in the employee form
    if empty(qry.FieldByName('TFN').AsString) then sTFN := '000000000' else sTFN := qry.FieldByName('TFN').AsString;
    if empty(qry.FieldByName('DOB').AsString) then sDOB := '00000000' else sDOB := FormatDateTime('ddmmyyyy',qry.FieldByName('DOB').AsDateTime);

    with qryTerminated do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tblemployeeterminations WHERE EmployeeID = ');
      SQL.Add(IntToStr(iEmployeeID));
      Open;
      Last;

      sDateStart := FormatDateTime('ddmmyyyy',FieldByName('StartDate').AsDateTime);
      sDateEnd := FormatDateTime('ddmmyyyy',FieldByName('EndDate').AsDateTime);
//      dTotalTax := FieldByName('TaxWithheld').AsFloat;
//      dGrossPayments := FieldByName('Gross').AsFloat; //was grosstermination amount

//      NoOfDaysBefore1July1983 := FieldByName('DaysServicePre01071983').AsInteger;
//      NoOfDaysAfter30June1983 := FieldByName('DaysServicePost30061983').AsInteger;
//      CGTExemptComponent := 0;  //Capital Gains Tax relates to Super only.

      {Very few benefits will have a non-qualifying component. It represents the earnings
      on any annuities that were purchased with non-superannuation or termination of
      employment money. These amounts do not qualify for RBL concessional tax rates and
      are taxed as ordinary income. Ref ATO}
//      NonQualifyingComponent := 0;   //usume no earnings from ETP payout

      {Contributions paid into a superannuation fund by the member (or by a person other
      than an employer of the member) where no deduction has been allowed for the contributions,
      for example after tax income. These contributions must have been paid on or after
      1 July 1983. These contributions are often referred to as personal contributions.
      This component is not counted for RBL purposes and no further tax is payable. Ref ATO}
//      UndeductedContributions  := 0; //zero cause not a superannuation payer.

//      ConcessionalComponent := 0; // Applies to Super only
//      PreJuly1983untaxedElement := FieldByName('ETPpre071983').AsFloat;
//      PostJume1983taxedElement :=  FieldByName('ETPpost061983taxed').AsFloat;
//      PostJune1983untaxedElement := FieldByName('ETPpost061983untaxed').AsFloat;
//      PostJune1994invalidityComponent := FieldByName('ETPpost061994Component').AsFloat;
//      dAssessable :=  FieldByName('ETPAssessable').AsFloat;
      if FieldByName('DeathBenefit').AsString = 'T' then sDeathBenefit := 'Y' else sDeathBenefit := 'N';
      if sDeathBenefit = 'Y' then begin
        if FieldByName('TypeOfDeathBenefit').AsString = 'Trustee' then sTypeOfDeathBenefit := 'T' else sTypeOfDeathBenefit := 'O';
      end else begin
        sTypeOfDeathBenefit := ' ';
      end;
    end;

    //check if mandatory data exists
    if empty(qry.FieldByName('TFN').AsString) then sDataMissing := 'Missing TFN';
    if empty(qry.FieldByName('DOB').AsString) then sDataMissing := 'Missing DOB';
    if empty(qry.FieldByName('FirstName').AsString) then sDataMissing := 'Missing First Name';
    if empty(qry.FieldByName('LastName').AsString) then sDataMissing := 'Missing Last Name';
    if empty(qry.FieldByName('Street').AsString) then sDataMissing := 'Missing Street';
    if empty(qry.FieldByName('Suburb').AsString) then sDataMissing := 'Missing Suburb';
    if empty(qry.FieldByName('State').AsString) then sDataMissing := 'Missing State';
    if empty(qry.FieldByName('Postcode').AsString) then sDataMissing := 'Missing Postcode';
    if sDateEnd = '' then sDataMissing := 'Missing End Date';
    if empty(qry.FieldByName('Tax').AsString) then sDataMissing := 'Missing Tax';
    if empty(qry.FieldByName('Gross').AsString) then sDataMissing := 'Missing Gross';
//    TempLine := '628DETP' +
//      FillString(sTFN,9,#32,False) +
//      FillString(qry.FieldByName('LastName').AsString,30,#32,False) +
//      FillString(qry.FieldByName('FirstName').AsString,15,#32,False) +
//      FillString(qry.FieldByName('MiddleName').AsString,15,#32,False) +
//      FillString(qry.FieldByName('Street').AsString,38,#32,False) +
//      FillString(qry.FieldByName('Street2').AsString,38,#32,False) +
//      FillString(qry.FieldByName('Suburb').AsString,27,#32,False) +
//      FillString(qry.FieldByName('State').AsString,3,#32,False) +
//      FillString(qry.FieldByName('PostCode').AsString,4,#32,False) +
//      FillString(qry.FieldByName('Country').AsString,20,#32,False) +
//      FillString(sDOB,8,#32,False) +
//      FillString(sDateEnd,8,#32,False) +
//      FillString(sDateStart,8,#32,False) +
//      FillString(FormatFloat('#######0',NoOfDaysBefore1July1983),5,#48,True) +
//      FillString(FormatFloat('#######0',NoOfDaysAfter30June1983),5,#48,True) +
//      FillString(FormatFloat('#######0',CGTExemptComponent),8,#48,True) +
//      FillString(FormatFloat('#######0',NonQualifyingComponent),8,#48,True) +
//      FillString(FormatFloat('#######0',UndeductedContributions),8,#48,True) +
//      FillString(FormatFloat('#######0',ConcessionalComponent),8,#48,True) +
//      FillString(FormatFloat('#######0',PreJuly1983untaxedElement),8,#48,True) +
//      FillString(FormatFloat('#######0',PostJune1983untaxedElement),8,#48,True) +
//      FillString(FormatFloat('#######0',PostJume1983taxedElement),8,#48,True) +
//      FillString(FormatFloat('#######0',PostJune1994invalidityComponent),8,#48,True) +
//      FillString(FormatFloat('#######0',dGrossPayments),8,#48,True) +
//      FillString(FormatFloat('#######0',dTotalTax),8,#48,True) +
//      FillString(FormatFloat('#######0',dAssessable),8,#48,True) +
//      FillString(sDeathBenefit,1,#32,False) +
//      FillString(sTypeOfDeathBenefit,1,#32,False) +
//      FillString(' ',298,#32,False);
    ETPSum.O['PayeeTaxFileNumber'].S['Value'] := qry.FieldByName('TFN').AsString;
    ETPSum.O['PayeeSurname'].S['Value'] := qry.FieldByName('LastName').AsString;
    ETPSum.O['PayeeFirstName'].S['Value'] := qry.FieldByName('FirstName').AsString;
    ETPSum.O['PayeeSecondName'].S['Value'] := qry.FieldByName('MiddleName').AsString;
    ETPSum.O['PayeeAddressLine1'].S['Value'] := qry.FieldByName('Street').AsString;
    ETPSum.O['PayeeAddressLine2'].S['Value'] := qry.FieldByName('Street2').AsString;
    ETPSum.O['PayeeSuburb'].S['Value'] := qry.FieldByName('Suburb').AsString;
    ETPSum.O['PayeeState'].S['Value'] := qry.FieldByName('State').AsString;
    ETPSum.O['PayeePostcode'].S['Value'] := qry.FieldByName('Postcode').AsString;
    ETPSum.O['PayeeCountry'].S['Value'] := qry.FieldByName('Country').AsString;
    ETPSum.O['PayeeDateOfBirth'].DT['Value'] := qry.FieldByName('DOB').AsDateTime;
    ETPSum.O['DateOfPayment'].DT['Value'] := qryTerminated.FieldByName('EndDate').AsDateTime;
    ETPSum.O['TotalTaxWithheld'].F['Value'] := 0;
    ETPSum.O['TaxableComponent'].F['Value'] := 0;
    ETPSum.O['TaxFreeComponent'].F['Value'] := 0;
    ETPSum.O['DethBenifit'].S['Value'] := 'F';
    ETPSum.O['TypeOfDethBenifit'].S['Value'] := '';
    ETPSum.O['TransitionalTerminationPayment'].S['Value'] := 'N';
    ETPSum.O['PartOfPreviousYearETP'].S['Value'] := 'N';
    ETPSum.O['AmenmentIndicator'].S['Value'] := 'O';

    TempLine := ETPSum.RecordString;

    if (char_length(TempLine) <> 628) or (sDataMissing <> '') then begin
      if char_length(TempLine) <> 628 then Result := 'File Format Error' else Result := sDataMissing;
        CommonLib.MessageDlgXP_Vista('Employee ' + qry.FieldByName('EmployeeName').AsString + ' ' + result, mtWarning, [mbOK], 0);
      Exit;
    end;
    Result := 'Success';
    AddLinetoFile(TempLine);
  finally
    ETPSum.Free;
    FreeAndNil(qry);
    FreeAndNil(qryTerminated);
  end;
end;

function TPayEmpdupeObj.AddVoluntary(Const iEmployeeID :integer):String;  //stub
begin
  result := 'Soon available'
end;

function TPayEmpdupeObj.AddLabourHire(Const iEmployeeID :integer):String;  //stub
begin
  result := 'Soon available'
end;

function TPayEmpdupeObj.AddPersonalServices(Const iEmployeeID :integer):String; //stub
begin
  result := 'Soon available'
end;

procedure TPayEmpdupeObj.AddPayer(Const iYear:integer;Const ETPFlag:String);
var
  qry:TERPQuery;
  TempLine:String;
  bDataMissing:Boolean;
  Rec: TPayerDataRec;
begin
  qry := TERPQuery.Create(nil);
  try
    bDataMissing := False;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblcompanyinformation');
    qry.Open;

    //check if mandatory data exists
    if empty(qry.FieldByName('ABN').AsString) then begin bDataMissing := True; fErrorMessage := ' ABN.' end;
    if iYear = 0 then begin bDataMissing := True; fErrorMessage := ' Year.' end;
    if empty(qry.FieldByName('CompanyName').AsString) then begin bDataMissing := True; fErrorMessage := ' Name.' end;
    if empty(qry.FieldByName('Address').AsString) then begin bDataMissing := True; fErrorMessage := ' Address.' end;
    if empty(qry.FieldByName('City').AsString) then begin bDataMissing := True; fErrorMessage := ' City.' end;
    if empty(qry.FieldByName('State').AsString) then begin bDataMissing := True; fErrorMessage := ' State.' end;
    if empty(qry.FieldByName('Postcode').AsString) then begin bDataMissing := True; fErrorMessage := ' Postcode.' end;

//    TempLine := '628IDENTITY' +
//      FillString(qry.FieldByName('ABN').AsString,11,#32,False) +
//      '001' +
//      IntToStr(iYear) +
//      FillString(qry.FieldByName('CompanyName').AsString,200,#32,False) +
//      FillString(qry.FieldByName('TradingName').AsString,200,#32,False) +
//      FillString(qry.FieldByName('Address').AsString,38,#32,False) +
//      FillString(qry.FieldByName('Address2').AsString,38,#32,False) +
//      FillString(qry.FieldByName('City').AsString,27,#32,False) +
//      FillString(qry.FieldByName('State').AsString,3,#32,False) +
//      FillString(qry.FieldByName('PostCode').AsString,4,#32,False) +
//      FillString(qry.FieldByName('Country').AsString,20,#32,False) +
//      FillString(qry.FieldByName('Contact').AsString,38,#32,False) +
//      FillString(qry.FieldByName('PhoneNumber').AsString,15,#32,False) +
//      FillString(qry.FieldByName('FaxNumber').AsString,15,#32,False) +
//      FillString(ETPFlag,1,#32,False) ;

    Rec:= TPayerDataRec.Create;
    try
      Rec.O['PayerABN'].S['Value'] := qry.FieldByName('ABN').AsString;
      Rec.O['BranchNumber'].I['Value'] := 1;
      Rec.O['FinancialYear'].I['Value'] := iYear;
      Rec.O['PayerName'].S['Value'] := qry.FieldByName('CompanyName').AsString;
      Rec.O['PayerTradingName'].S['Value'] := qry.FieldByName('TradingName').AsString;
      Rec.O['PayerAddressLine1'].S['Value'] := qry.FieldByName('Address').AsString;
      Rec.O['PayerAddressLine2'].S['Value'] := qry.FieldByName('Address2').AsString;
      Rec.O['PayerSuburb'].S['Value'] := qry.FieldByName('City').AsString;
      Rec.O['PayerState'].S['Value'] := qry.FieldByName('State').AsString;
      Rec.O['PayerPostcode'].I['Value'] := StrToIntDef(qry.FieldByName('PostCode').AsString,0);
      Rec.O['PayerCountry'].S['Value'] := qry.FieldByName('Country').AsString;
      Rec.O['PayerContactName'].S['Value'] := qry.FieldByName('Contact').AsString;
      Rec.O['PayerContactPhoneNumber'].S['Value'] := qry.FieldByName('PhoneNumber').AsString;
      Rec.O['PayerContactFaxNumber'].S['Value'] := qry.FieldByName('FaxNumber').AsString;
      TempLine := Rec.RecordString;

    finally
      Rec.Free;
    end;

    if (char_length(TempLine) <> 628) then begin
      CommonLib.MessageDlgXP_Vista('Payer File format error.', mtWarning, [mbOK], 0);
      exit;
    end;
    if (bDataMissing = True) then begin
      CommonLib.MessageDlgXP_Vista('The selected company is missing a ' + fErrorMessage, mtWarning, [mbOK], 0);
      ShowCompanyInformationForm;
      Exit;
    end;
    AddLinetoFile(TempLine);
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPayEmpdupeObj.CreateATOFileHeader(Const sFileName:String;Const iSubmissionID,iYear:integer);
begin
   if FileExists(sFileName) then SysUtils.DeleteFile(sFileName);
  {$I-}
  AssignFile(F, sFileName);
  Rewrite(F);
  IOResult;
  {$I+}

  AddSupplierRecs(iSubmissionID,iYear);

//  CloseExportFile;
end;

procedure TPayEmpdupeObj.AddSoftwareRec;
var
  TempLine:String;
  SWRec: TSoftwareRec;
begin
  SWRec:= TSoftwareRec.Create;
  try
//    TempLine := '628SOFTWARE' +
//      FillString('ERP ver',80,#32,False) +
//      FillString('Y',1,#32,False) +
//      FillString(' ',536,#32,False);
    TempLine := SWRec.RecordString;
    AddLinetoFile(TempLine);
  finally
    SWREc.Free;
  end;
end;

procedure TPayEmpdupeObj.AddSupplierRecs(Const iSubmissionID,iYear:integer);
var
  qry:TERPQuery;
  TempLine:String;
  bDataMissing:Boolean;
  Rec1: TSupplierData1Rec;
  Rec2: TSupplierData2Rec;
  Rec3: TSupplierData3Rec;
begin
  qry := TERPQuery.Create(nil);
  try
    bDataMissing := False;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblcompanyinformation');
    qry.Open;

    //LINE 1
    //check if mandatory data exists
    if empty(qry.FieldByName('ABN').AsString) then begin bDataMissing := True; fErrorMessage := ' ABN'; end;

    Rec1 := TSupplierData1Rec.Create;
    try
//      TempLine := '628IDENTREGISTER1' +
//        FillString(qry.FieldByName('ABN').AsString,11,#32,False) +
//        'P'{Run Type T-test or P-Production} +'3006' + IntToStr(iYear) + 'E' + 'A' + 'P' + 'FEMPA007.4' +
//        FillString(' ',10,#32,False) +
//        FillString(' ',568,#32,False);

      Rec1.O['SupplierABN'].S['Value'] := qry.FieldByName('ABN').AsString;
      Rec1.O['ReportEndDate'].DT['Value'] := EncodeDate(iYear,GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts),1) -1;
      TempLine := Rec1.RecordString;

      if (char_length(TempLine) <> 628) or (bDataMissing = True) then begin
        CommonLib.MessageDlgXP_Vista('The selected company is missing an' + fErrorMessage, mtWarning, [mbOK], 0);
        ShowCompanyInformationForm;
        Exit;
      end;

      AddLinetoFile(TempLine);
    finally
      Rec1.Free;
    end;
    //LINE 2
    //check if mandatory data exists
    if empty(qry.FieldByName('CompanyName').AsString) then  begin bDataMissing := True; fErrorMessage := ' Name.'; end;
    if empty(qry.FieldByName('PhoneNumber').AsString) then begin bDataMissing := True; fErrorMessage := ' Phone number.'; end;

//    TempLine := '628IDENTREGISTER2' +
//      FillString(qry.FieldByName('CompanyName').AsString,200,#32,False) +
//      FillString(qry.FieldByName('Contact').AsString,38,#32,False) +
//      FillString(qry.FieldByName('PhoneNumber').AsString,15,#32,False) +
//      FillString(qry.FieldByName('FaxNumber').AsString,15,#32,False) +
//      FillString(IntToStr(iSubmissionID) + '-' + FormatDateTime('dd-mm-yyyy',Now),16,#32,False) +   //file ref
//      FillString(' ',327,#32,False);

    Rec2 := TSupplierData2Rec.Create;
    try
      Rec2.O['SupplierName'].S['Value'] := qry.FieldByName('CompanyName').AsString;
      Rec2.O['SupplierContactName'].S['Value'] := qry.FieldByName('Contact').AsString;
      Rec2.O['SupplierContactPhoneNumber'].S['Value'] := qry.FieldByName('PhoneNumber').AsString;
      Rec2.O['SupplierContactFaxNumber'].S['Value'] := qry.FieldByName('FaxNumber').AsString;
      Rec2.O['SupplierFileRef'].S['Value'] := IntToStr(iSubmissionID) + '-' + FormatDateTime('dd-mm-yyyy',Now);
      TempLine := Rec2.RecordString;

    finally
      Rec2.Free;
    end;

    if (char_length(TempLine) <> 628) or (bDataMissing = True) then begin
      CommonLib.MessageDlgXP_Vista('The selected company is missing a' + fErrorMessage, mtWarning, [mbOK], 0);
      ShowCompanyInformationForm;
      Exit;
    end;

    AddLinetoFile(TempLine);
    //LINE 3
    //check if mandatory data exists
    if empty(qry.FieldByName('CompanyName').AsString) then bDataMissing := True;
    if empty(qry.FieldByName('Address').AsString) then begin bDataMissing := True; fErrorMessage := ' Address'; end;
    if empty(qry.FieldByName('City').AsString) then begin bDataMissing := True; fErrorMessage := ' City'; end;
    if empty(qry.FieldByName('State').AsString) then begin bDataMissing := True; fErrorMessage := ' State'; end;
    if empty(qry.FieldByName('Postcode').AsString) then begin bDataMissing := True; fErrorMessage := ' Postcode'; end;
    if not empty(qry.FieldByName('POBox').AsString) then begin
      if empty(qry.FieldByName('CompanyName').AsString) then begin bDataMissing := True;fErrorMessage := ' Company Name'; end;
      if empty(qry.FieldByName('POCity').AsString) then begin bDataMissing := True; fErrorMessage := ' PO Box City'; end;
      if empty(qry.FieldByName('POState').AsString) then begin bDataMissing := True; fErrorMessage := ' PO Box State'; end;
      if empty(qry.FieldByName('POPostCode').AsString) then begin bDataMissing := True;fErrorMessage := ' PO Box PostCode'; end;
    end;

//    TempLine := '628IDENTREGISTER3' +
//      FillString(qry.FieldByName('Address').AsString,38,#32,False) +
//      FillString(qry.FieldByName('Address2').AsString,38,#32,False) +
//      FillString(qry.FieldByName('City').AsString,27,#32,False) +
//      FillString(qry.FieldByName('State').AsString,3,#32,False) +
//      FillString(qry.FieldByName('PostCode').AsString,4,#32,False) +
//      FillString(qry.FieldByName('Country').AsString,20,#32,False) +
//      FillString(qry.FieldByName('POBox').AsString,38,#32,False) +
//      FillString(qry.FieldByName('POBox2').AsString,38,#32,False) +
//      FillString(qry.FieldByName('POCity').AsString,27,#32,False) +
//      FillString(qry.FieldByName('POState').AsString,3,#32,False) +
//      FillString(qry.FieldByName('POPostcode').AsString,4,#32,False) +
//      FillString(qry.FieldByName('POCountry').AsString,20,#32,False) +
//      FillString(qry.FieldByName('Email').AsString,76,#32,False) +
//      FillString(' ',275,#32,False);

    Rec3 := TSupplierData3Rec.Create;
    try
      Rec3.O['SupplierStreetAddressLine1'].S['Value'] := qry.FieldByName('Address').AsString;
      Rec3.O['SupplierStreetAddressLine2'].S['Value'] := qry.FieldByName('Address2').AsString;
      Rec3.O['SupplierSuburb'].S['Value'] := qry.FieldByName('City').AsString;
      Rec3.O['SupplierState'].S['Value'] := qry.FieldByName('State').AsString;
      Rec3.O['SupplierPostcode'].I['Value'] := StrToIntDef(qry.FieldByName('PostCode').AsString,0);
      Rec3.O['SupplierCountry'].S['Value'] := qry.FieldByName('Country').AsString;

      Rec3.O['SupplierPostalAddressLine1'].S['Value'] := qry.FieldByName('POBox').AsString;
      Rec3.O['SupplierPostalAddressLine2'].S['Value'] := qry.FieldByName('POBox2').AsString;
      Rec3.O['SupplierPostalSuburb'].S['Value'] := qry.FieldByName('POCity').AsString;
      Rec3.O['SupplierPostalState'].S['Value'] := qry.FieldByName('POState').AsString;
      Rec3.O['SupplierPostalPostcode'].I['Value'] := StrToIntDef(qry.FieldByName('POPostCode').AsString,0);
      Rec3.O['SupplierPostalCountry'].S['Value'] := qry.FieldByName('POCountry').AsString;

      Rec3.O['SupplierEmailAddress'].S['Value'] := qry.FieldByName('Email').AsString;
      TempLine := Rec3.RecordString;

    finally
      Rec3.Free;
    end;

    if (char_length(TempLine) <> 628) or (bDataMissing = True) then begin
      CommonLib.MessageDlgXP_Vista('The selected company is missing ' + fErrorMessage, mtWarning, [mbOK], 0);
      ShowCompanyInformationForm;
      Exit;
    end;

    AddLinetoFile(TempLine);
  finally
   FreeAndNil(qry);
  end;
end;

procedure TPayEmpdupeObj.ShowCompanyInformationForm;
var
  frmAccount: TComponent;
begin
  if FormStillOpen('TfrmCompanyInformation') then TForm(FindExistingComponent('TfrmCompanyInformation')).Destroy;
  frmAccount := GetComponentByClassName('TfrmCompanyInformation');
  with TForm(frmAccount) do begin
    ShowModal;
  end;
end;

//function TPayEmpdupeObj.FillString(const Str: string; const StrLength: integer; const FillChar: char;
//  const InFront: boolean): string;
//var
//  FinalStr, TempStr: string;
//  RequiredSpaces: integer;
//begin
//  RequiredSpaces := StrLength - char_length(LeftStr(Trim(Str), StrLength));
//  TempStr := StringOfChar(FillChar, RequiredSpaces);
//  if InFront then begin
//    FinalStr := TempStr + Trim(LeftStr(Trim(Str), StrLength));
//  end else begin
//    FinalStr := Trim(LeftStr(Trim(Str), StrLength)) + TempStr;
//  end;
//  Result := FinalStr;
//end;

procedure TPayEmpdupeObj.CloseExportFile;
begin
  try
    Flush(F);
    CloseFile(F);
  except
  end;
end;

procedure TPayEmpdupeObj.AddLinetoFile(const StrData: string);
begin
  Writeln(F, StrData);
  fiNumRecs := fiNumRecs + 1;
end;

end.
