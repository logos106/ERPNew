unit SQLsLib;

interface

Function SLNameUpdateSQL(Region:String; CleanSLname :String):String;

implementation

uses Sysutils;

Function SLNameUpdateSQL(Region:String; CleanSLname :String):String;
begin
      Result := ' update ignore tblleavetypes        set LeaveType   = replace(LeaveType   ,''Sick Leave'', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblpayrates          set Description = replace(Description ,''Sick Leave'', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblawardsleave       set Type        = replace(Type        ,''Sick Leave'', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblpaystransactions  set Description = replace(Description ,''Sick Leave'', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblroster            set TYPE        = replace(TYPE        ,''Sick Leave'', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblPaysLeave         set Leavetype   = replace(Leavetype   ,''Sick Leave'', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblleave             set type        = replace(type        ,''Sick Leave'', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblleaveaccruals     set LeaveType   = replace(LeaveType   ,''Sick Leave'', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;';
    if CleanSLname <> '' then
      Result := result +
                ' update ignore tblleavetypes        set LeaveType   = replace(LeaveType   ,'+Quotedstr(cleanSLName)+', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblpayrates          set Description = replace(Description ,'+Quotedstr(cleanSLName)+', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblawardsleave       set Type        = replace(Type        ,'+Quotedstr(cleanSLName)+', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblpaystransactions  set Description = replace(Description ,'+Quotedstr(cleanSLName)+', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblroster            set TYPE        = replace(TYPE        ,'+Quotedstr(cleanSLName)+', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblPaysLeave         set Leavetype   = replace(Leavetype   ,'+Quotedstr(cleanSLName)+', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblleave             set type        = replace(type        ,'+Quotedstr(cleanSLName)+', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;'+ chr(13)+chr(10)+
                ' update ignore tblleaveaccruals     set LeaveType   = replace(LeaveType   ,'+Quotedstr(cleanSLName)+', (select slname from tblregionaloptions where region = '+quotedstr(Region)+') ) where (select Fieldvalue from tbldbpreferences where name = ''CompanyRegion'') ='+quotedstr(Region)+' ;';


end;

end.
