unit BOMPlannerLib;

interface
type
  TBOMPlannerItem  = Class(TObject)
  private
    fiProcessPartId       : Integer;
    fdQtyScheduled        : double;
    fiSaleID              : Integer;
    fiSaleLineId          : Integer;
    fsProductName         : String;
    fsProductDesc         : String;
    fsEmployeeName        : String;
    fdTimeStart           : TdateTime;
    fsUOM                 : String;
    fscustomername        : String;
    fsResource            : String;
    fdUnitofMeasureShipped: double;
    fscaption             : String;
    fsItemCaption         : String;
    fdProctreetotalQty    : double;
    fdTimeEnd             : TdateTime;
    fsDuration            : String;
    fsSchdDuration        : String;
    fsProcessStatus       : String;
    fdQtyBuilt            : double;
    fsResourceDetail      : String;
    fsProcessStep         : String;
    fiProcessStep         : Integer;
    fdsaledate            : TdateTime;
    fdQtyUsed             : double;
    fdBuildDate           : TdateTime;
    fiProcessTimeID       : Integer;
    fiProcResourceId      : Integer;
    fiEmployeeId          : Integer;
    fiPRDID               : Integer;
    fbSalesconverted      : Boolean;
  Public
    Property SaleID               : Integer   read fiSaleID               Write fiSaleID ;
    Property SaleLineId           : Integer   read fiSaleLineId           Write fiSaleLineId ;
    Property saledate             : TdateTime read fdsaledate             Write fdsaledate ;
    Property UnitofMeasureShipped : double    read fdUnitofMeasureShipped Write fdUnitofMeasureShipped ;
    Property UOM                  : String    read fsUOM                  Write fsUOM ;
    Property customername         : String    read fscustomername         Write fscustomername ;
    Property ProductName          : String    read fsProductName          Write fsProductName ;
    Property ProductDesc          : String    read fsProductDesc          Write fsProductDesc ;

    Property caption              : String    read fscaption              Write fscaption ;
    Property ItemCaption          : String    read fsItemCaption          Write fsItemCaption ;
    Property ProctreetotalQty     : double    read fdProctreetotalQty     Write fdProctreetotalQty ;
    Property ProcessStep          : String    read fsProcessStep          Write fsProcessStep ;
    Property ProcessStepId        : Integer   read fiProcessStep          write fiProcessStep;
    Property Resource             : String    read fsResource             Write fsResource ;
    Property ResourceDetail       : String    read fsResourceDetail       Write fsResourceDetail ;
    Property EmployeeName         : String    read fsEmployeeName         Write fsEmployeeName ;
    Property ProcessTimeID        : Integer   read fiProcessTimeID        Write fiProcessTimeID ;
    Property ProcResourceId       : Integer   read fiProcResourceId       Write fiProcResourceId ;
    Property EmployeeId           : Integer   read fiEmployeeId           Write fiEmployeeId ;
    Property PRDID                : Integer   read fiPRDID                Write fiPRDID ;
    Property ProcessPartId        : Integer   read fiProcessPartId        Write fiProcessPartId ;
    Property Duration             : String    read fsDuration             Write fsDuration ;
    Property SchdDuration         : String    read fsSchdDuration         Write fsSchdDuration ;
    Property ProcessStatus        : String    read fsProcessStatus        Write fsProcessStatus ;
    Property TimeStart            : TdateTime read fdTimeStart            Write fdTimeStart ;
    Property TimeEnd              : TdateTime read fdTimeEnd              Write fdTimeEnd ;

    Property BuildDate            : TdateTime read fdBuildDate            Write fdBuildDate ;
    Property QtyScheduled         : double    read fdQtyScheduled         Write fdQtyScheduled ;
    Property QtyBuilt             : double    read fdQtyBuilt             Write fdQtyBuilt ;
    Property QtyUsed              : double    read fdQtyUsed              Write fdQtyUsed ;
    Property Salesconverted       : Boolean   read fbSalesconverted       write fbSalesconverted ;

  End;

implementation

end.
