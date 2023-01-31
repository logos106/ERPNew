unit BusObjPaysPayratesUK;

interface
uses
  BusObjPaysPayratesBASE,Classes,Db;
type
   TPaysPayRatesUK = class(Tpayspayrates)
   private
   protected
    //  procedure DoFieldOnChange(Sender: TField); override;
   public

   end;

implementation

//procedure TpayspayratesUK.DoFieldOnChange(Sender: TField);
//begin
//  inherited ;
//end;

initialization
RegisterClass(TpayspayratesUK);
end.
