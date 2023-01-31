unit ListLib;

interface

Uses TypesLib, ERPdbComponents, Wwdbgrid;

Type

  TFooterCalcType = (fctSum, fctAvg);

  TFooterCalcFields = record
    FieldName: string;
    Total: Double;
    IsCurrency: boolean;
    CalcType: TFooterCalcType;
  end;
  TFooterCalcfieldsArray = array of TFooterCalcfields;

procedure CalcnShowGridFooter(grd :TwwDBGrid ; Qry :TERPQuery; FooterCalcfields: TFooterCalcfieldsArray ; CalcFooter :TGeneralProc= nil);Overload;
procedure CalcGridFooter(Qry :TERPQuery; FooterCalcfields: TFooterCalcfieldsArray);

implementation

uses db , Progressdialog, SysUtils , WwDbiGrd, CommonLib, LogLib;

procedure CalcGridFooter(Qry :TERPQuery; FooterCalcfields: TFooterCalcfieldsArray);
var
  ctr: integer;
begin
  for ctr := low(FooterCalcfields) to high(FooterCalcfields) do
    if (Qry.FindField(FooterCalcfields[ctr].fieldname) <> nil) then begin
      FooterCalcfields[ctr].Total := FooterCalcfields[ctr].Total + Qry.FindField(FooterCalcfields[ctr].fieldname).asfloat;
    end;
end;
procedure CalcnShowGridFooter(grd :TwwDBGrid ; Qry :TERPQuery; FooterCalcfields: TFooterCalcfieldsArray; CalcFooter :TGeneralProc=nil);
var
  bm: TBookmark;
  ctr: integer;
  recCount: integer;
begin
  if high(FooterCalcfields) < 0 then exit;

  if not(dgshowfooter in grd.Options) then grd.Options := grd.Options + [dgshowfooter];

  DoShowProgressbar(trunc(Qry.recordcount/100) + 2 , 'Calculating Totals');
  try
    if length(FooterCalcfields) >0 then Grd.options := Grd.options +[dgshowfooter];
    for ctr := low(FooterCalcfields) to high(FooterCalcfields) do FooterCalcfields[ctr].Total := 0;
    doStepProgressbar;
    recCount:= 0;
    if Qry.RecordCount > 0 then begin
      Qry.DisableControls;
      try
        bm := Qry.GetBookmark;
        try
          Qry.first;
          while Qry.eof = false do begin
            Inc(recCount);
            if Assigned(CalcFooter) then CalcFooter else CalcGridFooter(Qry ,FooterCalcfields) ;
            Qry.Next;
            if trunc(Qry.RecNo/100)*100 = Qry.RecNo then doStepProgressbar;
          end;
        finally
          Qry.GoToBookmark(bm);
          Qry.FreeBookmark(bm);
        end;
      finally Qry.Enablecontrols;
      end;
    end;
    doStepProgressbar;
    for ctr := low(FooterCalcfields) to high(FooterCalcfields) do begin
      logtext(FooterCalcfields[ctr].Fieldname+':' +FloatToStrF(FooterCalcfields[ctr].Total, ffCurrency, 15, CurrencyRoundPlaces));
      if Qry.FindField(FooterCalcfields[ctr].fieldname) <> nil then begin
        if FooterCalcfields[ctr].IsCurrency then begin
          if FooterCalcfields[ctr].CalcType = fctSum then
            Grd.ColumnByName(FooterCalcfields[ctr].fieldname).FooterValue := FloatToStrF(FooterCalcfields[ctr].Total, ffCurrency, 15, CurrencyRoundPlaces)
          else if (FooterCalcfields[ctr].CalcType = fctAvg) and (recCount > 0) then
            Grd.ColumnByName(FooterCalcfields[ctr].fieldname).FooterValue := FloatToStrF(FooterCalcfields[ctr].Total / recCount, ffCurrency, 15, CurrencyRoundPlaces)
        end else begin
          { not currency }
          if FooterCalcfields[ctr].CalcType = fctSum then
            Grd.ColumnByName(FooterCalcfields[ctr].fieldname).FooterValue := FloatToStrF(round(FooterCalcfields[ctr].Total, 2), ffGeneral, 15, 2)
          else if (FooterCalcfields[ctr].CalcType = fctAvg) and (recCount > 0) then
            Grd.ColumnByName(FooterCalcfields[ctr].fieldname).FooterValue := FloatToStrF(round(FooterCalcfields[ctr].Total / recCount, 2), ffGeneral, 15, 2);
        end;
        logtext(FooterCalcfields[ctr].fieldname +':' + Grd.ColumnByName(FooterCalcfields[ctr].fieldname).FooterValue);
      end;
      doStepProgressbar;
    end;
  finally
    DoHideProgressbar;
  end;
end;

end.
