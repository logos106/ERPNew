unit ReturnsLib;

interface

function ReturnDateRange(REturnCode:String):String;

implementation

uses sysutils;


function ReturnDateRange(ReturnCode:String):String;
begin
  if sameText(ReturnCode, 'BAS') then begin
    Result := 'Select ' +
              ' ID,HasTab1 , HasTab2, HasTab3, HasTab4, ' +
              ' if(HasTab1="F" , NULL , Encodedate(1,MonthNo(Tab1_month), tab1_year)) Tab1_from, ' +
              ' if(HasTab1="F" , NULL , DateRangetypeToMonth(Tab1_Type)) Tab1_Months, ' +
              ' if(HasTab1="F" , NULL , IncMonth(MonthNo(Tab1_month), tab1_year , DateRangetypeToMonth(Tab1_Type)))  as Tab1_to, ' +
              ' if(HasTab2="F" , NULL , Encodedate(1,MonthNo(Tab2_month), tab2_year)) Tab2_From, ' +
              ' if(HasTab2="F" , NULL , DateRangetypeToMonth(Tab2_Type)) Tab2_Months, ' +
              ' if(HasTab2="F" , NULL , IncMonth(MonthNo(Tab2_month), tab2_year , DateRangetypeToMonth(Tab2_Type)))  as Tab2_to, ' +
              ' if(HasTab3="F" , NULL , Encodedate(1,MonthNo(Tab3_month), tab3_year)) Tab3_From, ' +
              ' if(HasTab3="F" , NULL , DateRangetypeToMonth(Tab3_Type)) Tab3_Months, ' +
              ' if(HasTab3="F" , NULL , IncMonth(MonthNo(Tab3_month), tab3_year , DateRangetypeToMonth(Tab3_Type)))  as Tab3_to, ' +
              ' if(HasTab4="F" , NULL , Encodedate(1,MonthNo(Tab4_month), tab4_year)) Tab4_from, ' +
              ' if(HasTab4="F" , NULL , DateRangetypeToMonth(Tab4_Type)) Tab4_Months, ' +
              ' if(HasTab4="F" , NULL , IncMonth(MonthNo(Tab4_month), tab4_year , DateRangetypeToMonth(Tab4_Type)))  as Tab4_to  ' +
              ' from tblbasreports' ;
  end else if SameText(ReturnCode , 'NZ' ) then begin
    Result:= 'Select ' +
              ' ID, ' +
              ' Encodedate(1,MonthNo(tab4_month), tab4_year) tab4_from, ' +
              ' DateRangetypeToMonth(tab4_Type) tab4_Months, ' +
              ' IncMonth(MonthNo(tab4_month), tab4_year , DateRangetypeToMonth(tab4_Type))  as tab4_to ' +
              ' from tblnzreturns';
  end else if SameText(ReturnCode , 'VAT' ) then begin
    Result:= 'Select ' +
              ' ID, ' +
              ' Encodedate(1,MonthNo(month), year) Dtfrom, ' +
              ' DateRangetypeToMonth(Type) Months, ' +
              ' IncMonth(MonthNo(month), year , DateRangetypeToMonth(Type))  as dtto ' +
              ' from tblvatreturns';
  end else begin
    result:= '';
  end;

end;
end.

