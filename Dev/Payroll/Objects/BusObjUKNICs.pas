unit BusObjUKNICs;
      //Only handle Class 1 at this stage. TO DO Handle all other classes of NICs
interface
uses
  BusObjBase,Classes,BusObjPensionBase,PayCommon;

type
   TUKNICs = class(TPensionBase)
   private
  //   procedure CallbackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
   protected
   public
     class function GetIDField: string; override;
     class function GetBusObjectTableName: string; Override;
     Constructor  Create(AOwner: TComponent);                             override;
     Destructor   Destroy;                                                override;

     procedure CalcContributions;override;
  //   procedure PostToAccounts;
end;

implementation
uses
  AppEnvironment,BusObjPayBase, DecimalRounding,SysUtils;

constructor TUKNICs.Create(AOwner: TComponent);
begin
   inherited Create(AOwner) ;
end;

class function TUKNICs.GetBusObjectTableName: string;
begin
  Result := 'tblpaysukbenefits';
end;

class function  TUKNICs.GetIDField : String;
begin
   Result := 'Benefitid'
end;

destructor TUKNICs.Destroy;
begin
   inherited;
end;

//procedure TUKNICs.PostToAccounts;  //DONE ELSEWHERE
//begin
//  Self.IterateRecords(CallbackPostToAccounts,False);
//end;

//procedure TUKNICs.CallBackPostToAccounts(const Sender: TBusObj; var Abort: Boolean);
//
//begin

//end;


procedure TUKNICs.CalcContributions;   //TO DO handle catagories D,E,F,G,J,L,S
var
  EmployeeBand1,EmployeeBand2,EmployerBand1,EmployerBand2:double;
//  LEL,
  EmployeeET,EmployerET,UEL:double;
begin
  if (TPaybase(Self.Owner.Owner).EmployeePaySettings.NICTableLetter = 'X') then begin
    TPaybase(Self.Owner.Owner).EmployeeNICsTotal := 0;
    TPaybase(Self.Owner.Owner).EmployerNICsTotal := 0;
    exit;
  end;

  if TPaybase(Self.Owner.Owner).EmployeePaySettings.Payperiod = 'Weekly' then begin
//    LEL := AppEnv.PayPrefs.UKNICLowerEarningsLimitWK;
    EmployeeET := AppEnv.PayPrefs.UKNICEarningsThreshold1WK;
    EmployerET := AppEnv.PayPrefs.UKNICEarningsThreshold2WK;
    UEL := AppEnv.PayPrefs.UKNICUpperEarningsLimitWK;
  end else if TPaybase(Self.Owner.Owner).EmployeePaySettings.Payperiod = 'Monthly' then begin
//    LEL := AppEnv.PayPrefs.UKNICLowerEarningsLimitMTH;
    EmployeeET := AppEnv.PayPrefs.UKNICEarningsThreshold1MTH;
    EmployerET := AppEnv.PayPrefs.UKNICEarningsThreshold2MTH;
    UEL := AppEnv.PayPrefs.UKNICUpperEarningsLimitMTH;
  end else begin  //default to weekly
    EmployeeET := AppEnv.PayPrefs.UKNICEarningsThreshold1WK;
    EmployerET := AppEnv.PayPrefs.UKNICEarningsThreshold2WK;
    UEL := AppEnv.PayPrefs.UKNICUpperEarningsLimitWK;
  end;

    //currently the Earning threshold is the same value for employees and employers but added code in case of change
  if TPaybase(Self.Owner.Owner).Gross > EmployeeET then begin
    if TPaybase(Self.Owner.Owner).Gross > UEL then begin
      EmployeeBand1 := UEL - EmployeeET;
      EmployeeBand2 := TPaybase(Self.Owner.Owner).Gross - EmployeeBand1 - EmployeeET;

      EmployerBand1 := UEL - EmployerET;
      EmployerBand2 := TPaybase(Self.Owner.Owner).Gross - EmployerBand1 - EmployerET;
    end else begin
      EmployeeBand1 := TPaybase(Self.Owner.Owner).Gross - EmployeeET;
      EmployeeBand2 := 0;

      EmployerBand1 := TPaybase(Self.Owner.Owner).Gross - EmployerET;
      EmployerBand2 := 0;
    end;
    if TPaybase(Self.Owner.Owner).EmployeePaySettings.NICTableLetter = 'A' then begin
      TPaybase(Self.Owner.Owner).EmployeeNICsTotal := EmployeeBand1 * AppEnv.PayPrefs.UKNICEmployeesClass1Rate1/100
                                             + EmployeeBand2 * AppEnv.PayPrefs.UKNICEmployeeClass1Rate2/100;

      TPaybase(Self.Owner.Owner).EmployerNICsTotal := EmployerBand1 * AppEnv.PayPrefs.UKNICEmployersClass1Rate1/100
                                             + EmployerBand2 * AppEnv.PayPrefs.UKNICEmployersClass1Rate2/100;
    end else if TPaybase(Self.Owner.Owner).EmployeePaySettings.NICTableLetter = 'B' then begin
      TPaybase(Self.Owner.Owner).EmployeeNICsTotal := EmployeeBand1 * AppEnv.PayPrefs.UKNICMarriedWomanClass1Rate1/100
                                             + EmployeeBand2 * AppEnv.PayPrefs.UKNICMarriedWomanClass1Rate2/100;

      TPaybase(Self.Owner.Owner).EmployerNICsTotal := EmployerBand1 * AppEnv.PayPrefs.UKNICEmployersClass1Rate1/100
                                             + EmployerBand2 * AppEnv.PayPrefs.UKNICEmployersClass1Rate2/100;

    end;
    if (TPaybase(Self.Owner.Owner).EmployeePaySettings.NICTableLetter = 'C') then begin
      TPaybase(Self.Owner.Owner).EmployeeNICsTotal := 0;
      TPaybase(Self.Owner.Owner).EmployerNICsTotal := EmployerBand1 * AppEnv.PayPrefs.UKNICEmployersClass1Rate1/100
                                             + EmployerBand2 * AppEnv.PayPrefs.UKNICEmployersClass1Rate2/100;
    end;

    //trunc to 3 decimal places
    TPaybase(Self.Owner.Owner).EmployeeNICsTotal := DecimalRoundDbl(TPaybase(Self.Owner.Owner).EmployeeNICsTotal, 3, drRndDown);
    TPaybase(Self.Owner.Owner).EmployerNICsTotal := DecimalRoundDbl(TPaybase(Self.Owner.Owner).EmployerNICsTotal, 3, drRndDown);

    TPaybase(Self.Owner.Owner).EmployeeNICsTotal := DecimalRoundDbl(TPaybase(Self.Owner.Owner).EmployeeNICsTotal, 2, drHalfDown);
    TPaybase(Self.Owner.Owner).EmployerNICsTotal := DecimalRoundDbl(TPaybase(Self.Owner.Owner).EmployerNICsTotal, 2, drHalfDown);

  end else begin
    TPaybase(Self.Owner.Owner).EmployeeNICsTotal := 0;
    TPaybase(Self.Owner.Owner).EmployerNICsTotal := 0;
  end;
end;


initialization
RegisterClass(TUKNICs);

end.
