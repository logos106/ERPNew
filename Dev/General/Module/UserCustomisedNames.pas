unit UserCustomisedNames;

interface

uses stdctrls;

type
  TCaptiontype = (cpCustomerName      = 1,
                  cpSupplierName      = 2,
                  cpProspectName      = 3 ,
                  cpJob               = 4,
                  cpClientPrintName   = 5,
                  cpProductname       = 6,
                  cpProductPrintName  = 7,
                  cpPrductfirstcolumn = 8,
                  cpProdutSecondcolumn= 9,
                  cpProductthirdcolumn=10,
                  cptNone             =11);


Procedure ApplyLabelCaptions(lbl:TLabel; Captiontype:TCaptiontype);
function UserCustomisedName(Captiontype:TCaptiontype):String;
function UserCustomisedClientName(IsSupplier, IsCustomer ,  IsProspect,IsJob , IsPrintName:boolean ):String;

implementation

uses AppEnvironment;


Procedure ApplyLabelCaptions(lbl:TLabel; Captiontype:TCaptiontype);
var
  s:String;
begin
  s:=UserCustomisedName(Captiontype);
  if s<> '' then begin
    lbl.caption := s;
    lbl.refresh;
  end;

end;

function UserCustomisedName(Captiontype:TCaptiontype):String;
begin
  result := '';
       if Captiontype = cpCustomerName        then result := AppEnv.DefaultClass.CustomerColumnName
  else if Captiontype = cpSupplierName        then result := AppEnv.DefaultClass.SupplierColumnName
  else if Captiontype = cpProspectName        then result := AppEnv.DefaultClass.ProspectColumnName
  else if Captiontype = cpJob                 then result := 'Job Name'
  else if Captiontype = cpProductname         then result := AppEnv.DefaultClass.Partcolumn
  else if Captiontype = cpPrductfirstcolumn   then result := AppEnv.DefaultClass.FirstColumn
  else if Captiontype = cpProdutSecondcolumn  then result := AppEnv.DefaultClass.SecondColumn
  else if Captiontype = cpProductthirdcolumn  then result := AppEnv.DefaultClass.thirdColumn

  else if Captiontype = cpClientPrintName     then result := AppEnv.CompanyPrefs.ClientPrintNameHeading
  else if Captiontype = cpProductPrintName    then result := AppEnv.CompanyPrefs.ProductPrintNameHeading ;
end;
function UserCustomisedClientName(IsSupplier, IsCustomer ,  IsProspect,IsJob , IsPrintName:boolean ):String;
begin
  if IsPrintName then begin
    result := UserCustomisedName(cpClientPrintName)
  end else begin
         if Iscustomer then UserCustomisedName(cpCustomerName)
    else if IsSupplier then UserCustomisedName(cpSupplierName)
    else if IsProspect then UserCustomisedName(cpProspectName)
    else if isJob      then UserCustomisedName(cpJob)
  end;

end;
end.

