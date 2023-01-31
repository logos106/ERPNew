unit MagentoTax;

interface

type

(*
  {
    "class_id":"2",
    "class_name":
    "Taxable Goods",
    "class_type":"PRODUCT"
  }
  {
    "tax_calculation_rule_id":"4",
    "code":"Retail Customer - Taxable Good - Rate 1",
    "priority":"1",
    "position":"0",
    "calculate_subtotal":"0"
  }
  {
    "tax_calculation_rate_id":"7",
    "tax_country_id":"US",
    "tax_region_id":"0",
    "tax_postcode":null,
    "code":"US-All States-WholesaleTaxExemptRate",
    "rate":"0.0000",
    "zip_is_range":null,
    "zip_from":null,
    "zip_to":null
  }
  {
    "tax_calculation_id":"145",
    "tax_calculation_rate_id":"7",
    "tax_calculation_rule_id":"5",
    "customer_tax_class_id":"5",
    "product_tax_class_id":"6"
  }
*)

  TTaxClass = class(TObject)
  private
    Fclass_type: string;
    Fclass_id: string;
    Fclass_name: string;
    procedure Setclass_id(const Value: string);
    procedure Setclass_name(const Value: string);
    procedure Setclass_type(const Value: string);
  published
    property class_id: string read Fclass_id write Setclass_id;
    property class_name: string read Fclass_name write Setclass_name;
    property class_type: string read Fclass_type write Setclass_type;
  end;

  TTaxCalculationRule = class(TObject)
  private
    Ftax_calculatiom_rule_id: string;
    Fcode: string;
    Fcalculate_subtotal: string;
    Fposition: string;
    Fpriority: string;
    procedure Setcalculate_subtotal(const Value: string);
    procedure Setcode(const Value: string);
    procedure Setposition(const Value: string);
    procedure Setpriority(const Value: string);
    procedure Settax_calculatiom_rule_id(const Value: string);
  published
    property tax_calculatiom_rule_id: string read Ftax_calculatiom_rule_id write Settax_calculatiom_rule_id;
    property code: string read Fcode write Setcode;
    property priority: string read Fpriority write Setpriority;
    property position: string read Fposition write Setposition;
    property calculate_subtotal: string read Fcalculate_subtotal write Setcalculate_subtotal;
  end;

  TTaxCalculationRate = class(TObject)
  private
    Ftax_calculation_rate_id: string;
    Ftax_country_id: string;
    Ftax_postcode: string;
    Fcode: string;
    Ftax_region_id: string;
    Fzip_from: string;
    Fzip_is_range: string;
    Frate: string;
    Fzip_to: string;
    procedure Setcode(const Value: string);
    procedure Setrate(const Value: string);
    procedure Settax_calculation_rate_id(const Value: string);
    procedure Settax_country_id(const Value: string);
    procedure Settax_postcode(const Value: string);
    procedure Settax_region_id(const Value: string);
    procedure Setzip_from(const Value: string);
    procedure Setzip_is_range(const Value: string);
    procedure Setzip_to(const Value: string);
  published
    property tax_calculation_rate_id: string read Ftax_calculation_rate_id write Settax_calculation_rate_id;
    property tax_country_id: string read Ftax_country_id write Settax_country_id;
    property tax_region_id: string read Ftax_region_id write Settax_region_id;
    property tax_postcode: string read Ftax_postcode write Settax_postcode;
    property code: string read Fcode write Setcode;
    property rate: string read Frate write Setrate;
    property zip_is_range: string read Fzip_is_range write Setzip_is_range;
    property zip_from: string read Fzip_from write Setzip_from;
    property zip_to: string read Fzip_to write Setzip_to;
  end;

  TTaxCalculation = class(TObject)
  private
    Ftax_calculation_rate_id: string;
    Ftax_calculation_id: string;
    Fproduct_tax_class_id: string;
    Fcustomer_tax_class_id: string;
    Ftax_calculation_rule_id: string;
    procedure Setcustomer_tax_class_id(const Value: string);
    procedure Setproduct_tax_class_id(const Value: string);
    procedure Settax_calculation_id(const Value: string);
    procedure Settax_calculation_rate_id(const Value: string);
    procedure Settax_calculation_rule_id(const Value: string);
  published
    property tax_calculation_id: string read Ftax_calculation_id write Settax_calculation_id;
    property tax_calculation_rate_id: string read Ftax_calculation_rate_id write Settax_calculation_rate_id;
    property tax_calculation_rule_id: string read Ftax_calculation_rule_id write Settax_calculation_rule_id;
    property customer_tax_class_id: string read Fcustomer_tax_class_id write Setcustomer_tax_class_id;
    property product_tax_class_id: string read Fproduct_tax_class_id write Setproduct_tax_class_id;
  end;

implementation

const
  ClasName_Product = 'PRODUCT';
  ClassName_Customer = 'CUSTOMER';

{ TTaxClass }

procedure TTaxClass.Setclass_id(const Value: string);
begin
  Fclass_id := Value;
end;

procedure TTaxClass.Setclass_name(const Value: string);
begin
  Fclass_name := Value;
end;

procedure TTaxClass.Setclass_type(const Value: string);
begin
  Fclass_type := Value;
end;

{ TTaxCalculationRule }

procedure TTaxCalculationRule.Setcalculate_subtotal(const Value: string);
begin
  Fcalculate_subtotal := Value;
end;

procedure TTaxCalculationRule.Setcode(const Value: string);
begin
  Fcode := Value;
end;

procedure TTaxCalculationRule.Setposition(const Value: string);
begin
  Fposition := Value;
end;

procedure TTaxCalculationRule.Setpriority(const Value: string);
begin
  Fpriority := Value;
end;

procedure TTaxCalculationRule.Settax_calculatiom_rule_id(const Value: string);
begin
  Ftax_calculatiom_rule_id := Value;
end;

{ TTaxCalculationRate }

procedure TTaxCalculationRate.Setcode(const Value: string);
begin
  Fcode := Value;
end;

procedure TTaxCalculationRate.Setrate(const Value: string);
begin
  Frate := Value;
end;

procedure TTaxCalculationRate.Settax_calculation_rate_id(const Value: string);
begin
  Ftax_calculation_rate_id := Value;
end;

procedure TTaxCalculationRate.Settax_country_id(const Value: string);
begin
  Ftax_country_id := Value;
end;

procedure TTaxCalculationRate.Settax_postcode(const Value: string);
begin
  Ftax_postcode := Value;
end;

procedure TTaxCalculationRate.Settax_region_id(const Value: string);
begin
  Ftax_region_id := Value;
end;

procedure TTaxCalculationRate.Setzip_from(const Value: string);
begin
  Fzip_from := Value;
end;

procedure TTaxCalculationRate.Setzip_is_range(const Value: string);
begin
  Fzip_is_range := Value;
end;

procedure TTaxCalculationRate.Setzip_to(const Value: string);
begin
  Fzip_to := Value;
end;

{ TTaxCalculation }

procedure TTaxCalculation.Setcustomer_tax_class_id(const Value: string);
begin
  Fcustomer_tax_class_id := Value;
end;

procedure TTaxCalculation.Setproduct_tax_class_id(const Value: string);
begin
  Fproduct_tax_class_id := Value;
end;

procedure TTaxCalculation.Settax_calculation_id(const Value: string);
begin
  Ftax_calculation_id := Value;
end;

procedure TTaxCalculation.Settax_calculation_rate_id(const Value: string);
begin
  Ftax_calculation_rate_id := Value;
end;

procedure TTaxCalculation.Settax_calculation_rule_id(const Value: string);
begin
  Ftax_calculation_rule_id := Value;
end;

end.
