unit FCOnreportLib;

interface

uses ERPDbComponents;

Procedure    LoadFCPref(var fDataset:TERPQuery; const ListClassName:String; IncludeLookupfields:boolean);

implementation

uses AppEnvironmentVirtual,sysutils, DbSharedObjectsObj;

Procedure    LoadFCPref(var fDataset:TERPQuery; const ListClassName:String; IncludeLookupfields:boolean);
var
  strSQL:String;
  cmd :TERPCommand;
Const
  FCSQL1 = 'SELECT CC.Code code,CC.CurrencySymbol AS Symbol,CC.Currency,CC.Country,CC.BuyRate, CC.SellRate, FCR.* FROM tblforeigncurrencyonreport FCR inner join tblcurrencyconversion CC on FCR.CurrencyID = CC.CurrencyID and CC.Active = "T" ';
  FCSQL2 = 'SELECT FCR.* FROM tblforeigncurrencyonreport FCR inner join tblcurrencyconversion CC on FCR.CurrencyID = CC.CurrencyID and CC.Active = "T" ';
Function FCSQL:String;
begin
  if IncludeLookupfields then result :=FCSQL1 else result := FCSQL2;
end;
begin
    strSQL:= FCSQL +
              ' where CC.Active = "T" and FCR.ListName = ' + quotedStr(ListClassName) +
              ' and FCR.Active = "T" and Showinthereport = "T" ' +
              ' and FCR.USerID = ' + IntToStr(AppEnvVirt.Int['Employee.employeeID']) +
              ' and CC.code <> ' + quotedStr(Appenvvirt.str['RegionalOptions.ForeignExDefault']);
    if fDataset.active then fDataset.Close;
    fDataset.SQL.Text := strSQL;
    fDataset.Open;

    if fDataset.Recordcount = 0 then begin
        strSQL:= FCSQL +
                ' where FCR.ListName = ' + quotedStr(ListClassName) +
                ' and FCR.Active = "T" and Showinthereport = "T" ' +
                ' and FCR.USerID = 0' ;
          if fDataset.active then fDataset.Close;
          fDataset.SQL.Text := strSQL;
          fDataset.Open;
        if fDataset.recordcount > 0 then begin
            strSQL := ' insert into tblForeigncurrencyonReport ' +
                        ' (CurrencyID   , formID  , ListName   , Active  ,Showinthereport , userId)' +
                        ' select CurrencyID   , formID  , ListName   , Active  ,Showinthereport , ' + IntToStr(AppEnvVirt.Int['Employee.employeeID']) +
                        ' from tblForeigncurrencyonReport FCR where ' + strSQL;

            cmd := DbSharedObj.Getcommand(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
            try
              cmd.SQL.Text := StrSQL;
              cmd.Execute;
            finally
              DbSharedObj.ReleaseObj(cmd);
            end;


            strSQL:=  FCSQL +
                     ' where CC.Active = "T" and FCR.ListName = ' + quotedStr(ListClassName) +
                          ' and FCR.Active = "T" and FCR.Showinthereport = "T" ' +
                          ' and FCR.USerID = ' + IntToStr(AppEnvVirt.Int['Employee.employeeID'])+
                          ' and CC.code <> ' + quotedStr(Appenvvirt.str['RegionalOptions.ForeignExDefault']);
          if fDataset.active then fDataset.Close;
          fDataset.SQL.Text := strSQL;
          fDataset.Open;
        end;
    end;

end;

end.
