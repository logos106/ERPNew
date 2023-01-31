unit TNTFreightChargesObj;

interface

uses
  DB, MyAccess,ERPdbComponents;

const
  TNTFreightPartName = 'TNT Freight Charges';

type
  TTNTFreightChargesObj = class(TObject)
  private
    SourcePostcode: integer;
    DestinationPostcode: integer;
    Minimum: currency;
    Basic: currency;
    Rate: double;
    // Insurance:Currency;
    // Surcharge:Currency;
    ChargeMass: double;
    function GetCompanyPostcode: integer;
    procedure GetChargeParameters(var Minimum, Basic: currency; var Rate: double);
    // Function AddOtherChargeParameters(var CurrentAmount,Insurance,Surcharge: Currency): Currency;
    function GetRatingAreaCode(Postcode: integer): integer;
  public
    function TNTTablesVaild: boolean;
    function GetChargesEx(DestPostcode: integer; ActualMass, CubicMetres: double): currency;
    function TNTFreightProductExist: boolean;
    function TNTFreightProductName: string;
  end;

implementation
  
uses FastFuncs,CommonDbLib, SysUtils, DecimalRounding;

{ TTNTFreightChargesObj }

function TTNTFreightChargesObj.TNTTablesVaild: boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT ID,RecordType FROM tbltntfileheader;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      if uppercase(qryTemp.FieldByName('RecordType').AsString) = 'H' then begin
        Result := true;
      end else begin
        Result := false;
        Exit;
      end;
    end else begin
      Result := false;
      Exit;
    end;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT Count(ID) as Count FROM tbltntpostcodetoratingareazone ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      if qryTemp.FieldByName('Count').AsInteger > 0 then begin
        Result := true;
      end;  
    end else begin
      Result := false;
      Exit;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TTNTFreightChargesObj.GetChargesEx(DestPostcode: integer; ActualMass, CubicMetres: double): currency;
var
  CubicMass: double;
  CubicFactor: double;
begin
  //TNT Freight Pricing Calculations (Temporary)
  SourcePostcode := GetCompanyPostcode;
  DestinationPostcode := DestPostcode;
  CubicFactor := 180; {For DASCH} //Should be getting this for Imported File But Files Wrong. (TNT Default 250)
  ActualMass := DecimalRoundDbl(ActualMass, 0, drRndUp);
  CubicMass := DecimalRoundDbl(CubicMetres * CubicFactor, 0, drRndUp);

  if ActualMass < CubicMass then begin
    ChargeMass := CubicMass;
  end else begin
    ChargeMass := ActualMass;
  end;

  GetChargeParameters(Minimum, Basic, Rate);
  Result := (ChargeMass * Rate) + Basic;
  if Result < Minimum then Result := Minimum;

  //#### Remove Insurance And Surcharges As Per Brenton Hampson Instructions
  //#### Date - 05/04/2004
  //Result := ADDOtherChargeParameters(Result,Insurance,Surcharge);
  //####

  {5% + Ex Markup For DASCH}
  Result := Result + (Result * 0.05);
end;

function TTNTFreightChargesObj.TNTFreightProductExist: boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT PARTSID FROM tblparts WHERE PARTNAME = ' + QuotedStr(TNTFreightPartName) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TTNTFreightChargesObj.TNTFreightProductName: string;
begin
  Result := TNTFreightPartName;
end;

function TTNTFreightChargesObj.GetCompanyPostcode: integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SetupID,Postcode FROM tblcompanyinformation WHERE SetupID=1;');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Postcode').AsInteger;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TTNTFreightChargesObj.GetChargeParameters(var Minimum, Basic: currency; var Rate: double);
var
  qryTemp: TERPQuery;
  SourceAreaCode: string;
  DestinationAreaCode: string;
begin
  SourceAreaCode := IntToStr(GetRatingAreaCode(SourcePostcode));
  DestinationAreaCode := IntToStr(GetRatingAreaCode(DestinationPostcode));
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Active := false;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT ID,UseMinimumConNoteCharge,');
    qryTemp.Sql.Add('MinimumConCharge,KiloBasicForBreakPoint1,KiloRate1 FROM tbltntscheduleservicetrafficlanerates ');
    qryTemp.Sql.Add('WHERE SourceRatingArea=' + SourceAreaCode + ' AND DestinationRatingArea=' + DestinationAreaCode + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      if uppercase(qryTemp.FieldByName('UseMinimumConNoteCharge').AsString) = 'C' then begin
        Minimum := qryTemp.FieldByName('MinimumConCharge').AsCurrency;
        Basic := qryTemp.FieldByName('KiloBasicForBreakPoint1').AsCurrency;
        Rate := qryTemp.FieldByName('KiloRate1').AsCurrency;
      end else begin
        Minimum := 0.00;
        Basic := 0.00;
        Rate := 0.00;
        Exit;
      end;
    end else begin
      Minimum := 0.00;
      Basic := 0.00;
      Rate := 0.00;
      Exit;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TTNTFreightChargesObj.GetRatingAreaCode(Postcode: integer): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT ID,RatRef FROM tbltntpostcodetoratingareazone ');
      SQL.Add('WHERE Pcode = "' + IntToStr(Postcode) + '";');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('RatRef').AsInteger;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

{
Function TTNTFreightChargesObj.AddOtherChargeParameters(var CurrentAmount,Insurance,Surcharge: Currency): Currency;
Var
  qryTemp:TERPQuery;

begin
 qryTemp := TERPQuery.Create(nil);
 qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
 try
    qryTemp.Active := False;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT SurchargePercent, SurchargeAmount, DangerousGoodsPercent, ');
    qryTemp.Sql.Add('DangerousGoodsAmount, SaturdayDeliveryFee, ATCPremium  FROM tbltntscheduleservicegroup; ');
    qryTemp.Active := True;
    If not qryTemp.IsEmpty then begin
        Insurance := qryTemp.FieldByName('ATCPremium').AsCurrency;
        Surcharge := CurrentAmount * (qryTemp.FieldByName('SurchargePercent').AsFloat / 100);
        Result := CurrentAmount + Insurance + Surcharge;
    End else begin
      Insurance := 0.00;
      Surcharge := 0.00;
      Result := 0.00;
      Exit;
    end;
 finally
  FreeAndNil(qryTemp);
 end;
end; }

end.
