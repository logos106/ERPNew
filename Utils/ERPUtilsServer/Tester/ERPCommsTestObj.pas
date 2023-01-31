unit ERPCommsTestObj;

interface

uses
  TesterObj, JsonObject;

type

  TWebApiTestList = class(TTestList)
  public
    constructor Create;
  end;

  TWebAccessTest = class(TTestStep)
  public
    constructor Create;
    procedure DoTest(context: TJsonObject); override;
  end;

  THeadOfficeTest = class(TTestStep)
  public
    constructor Create;
    procedure DoTest(context: TJsonObject); override;
  end;


implementation

uses
  InternetConnectivityUtils, JsonRpcConst, SysUtils;

{ TWebApiTestList }

constructor TWebApiTestList.Create;
var
  Test: TTestStep;
begin
  inherited;
  Test:= TWebAccessTest.Create;
  AddTest(Test);
  Test:= THeadOfficeTest.Create;
  AddTest(Test);
end;

{ TWebAccessTest }

constructor TWebAccessTest.Create;
begin
  inherited;
  fCaption := 'Check external access';
end;

procedure TWebAccessTest.DoTest(context: TJsonObject);
begin
  inherited;
  AddDetail('This tests if you have external access.');
  if InternetAccessOk(true) then begin
    fStatus := tssPass;
    AddDetail('External access is ok.');
  end
  else begin
    fStatus := tssFail;
    AddDetail('Could not connect to the Internet.');
    AddDetail('Tried to access the following web sites:');
    AddDetail('www.trueerp.com');
    AddDetail('www.google.com');
    AddDetail('www.yahoo.com');
    AddDetail('Unable to access any of these sites.');
  end;

end;

{ THeadOfficeTest }

constructor THeadOfficeTest.Create;
begin
  inherited;
  fCaption := 'Check access to ERP Head Office Licence Server';

end;

procedure THeadOfficeTest.DoTest(context: TJsonObject);
begin
  inherited;
  AddDetail('This tests connectivity to ERP Head Office Licence Server.');
  if ERPHeadOfficeAccessOk(true) then begin
    fStatus := tssPass;
    AddDetail('Server access is ok.');
  end
  else begin
    fStatus := tssFail;
    AddDetail('Could not connect to the ERP Head Office Licence Server.');
    AddDetail('Please ensure that port ' + IntToStr(DEFAULT_TCP_PORT) + ' is open for communication ');
    AddDetail('both ways on your router, firewalls and virus scanner.');
  end;
end;

end.
