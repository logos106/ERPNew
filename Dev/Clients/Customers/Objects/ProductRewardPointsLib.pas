unit ProductRewardPointsLib;

interface

  function PointsExpireDate(const SLPAlias: string = 'SLP'): string;


implementation

function PointsExpireDate(const SLPAlias: string): string;
begin
  Result := 'if(Ifnull(' + SLPAlias + '.PointExpiresOn,0)<> 0 , ' + SLPAlias + '.PointExpiresOn , ' + ' if(ifnull(' + SLPAlias + '.ExpiresOnNoOfMonthsAfterPurchase,0)  <> 0, ' +
    ' Date_Add(S.SaleDate , Interval   ExpiresOnNoOfMonthsAfterPurchase MONTH),' + ' 0 )) ';
end;

end.
