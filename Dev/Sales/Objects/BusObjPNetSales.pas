unit BusObjPNetSales;

interface

uses
  Classes, BusObjBase, BusObjSales, BusObjAttachment, BusObjTrans;

type

  TPNetSaleExtra = class(TMSBusObj)
  private
    function GetPNETAuthorisedQuoteNumber: string;
    function GetQuoteStatus: string;
    function GetQuoteType: string;
    function GetQuotingMethodIndicator: string;
    function GetRepairDaysRequired: integer;
    function GetSaleID: integer;
    procedure SetPNETAuthorisedQuoteNumber(const Value: string);
    procedure SetQuoteStatus(const Value: string);
    procedure SetQuoteType(const Value: string);
    procedure SetQuotingMethodIndicator(const Value: string);
    procedure SetRepairDaysRequired(const Value: integer);
    procedure SetSaleID(const Value: integer);
  published
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SaleID: integer read GetSaleID write SetSaleID;
    property QuoteStatus: string read GetQuoteStatus write SetQuoteStatus; { (Active,Responded,Win,Lose,TotalLoss,Cancelled)  }
    property PNETAuthorisedQuoteNumber: string read GetPNETAuthorisedQuoteNumber write SetPNETAuthorisedQuoteNumber;
    property RepairDaysRequired: integer read GetRepairDaysRequired write SetRepairDaysRequired;
    property QuoteType: string read GetQuoteType write SetQuoteType;  { R,S,ADJR,ADJS,AUTR or AUTS (max 4)}
    property QuotingMethodIndicator: string read GetQuotingMethodIndicator write SetQuotingMethodIndicator; { C or H (max 1)}
  end;

  TPNetLabourLine = class;
  TPNetPaintLine = class;
  TPNetPartLine = class;
  TPNetReportLine = class;
  TPNetSubletLine = class;

  TPNetSale = class(TSales)
  private
    fLabourTotal: double;
    fPaintTotal: double;
    fPartTotal: double;
    fPartMarkupTotal: double;
    fSubletTotal: double;
    fExtra: TPNetSaleExtra;
    function GetAttachments: TAttachment;
    function GetExtra: TPNetSaleExtra;
    function GetGST: double;
    function GetImageCount: integer;
    function GetLabourTotal: double;
    function GetPaintTotal: double;
    function GetPartMarkupTotal: double;
    function GetPartTotal: double;
    function GetPNETAuthorisedQuoteNumber: string;
    function GetQuotationSoftware: string;
    function GetQuotationSoftwareVersion: string;
    function GetQuoteComments: string;
    function GetQuoteCreator: string;
    function GetQuoteReference: string;
    function GetQuoteStatus: string;
    function GetQuoteTotal: double;
    function GetQuoteType: string;
    function GetQuotingMethodIndicator: string;
    function GetRepairDaysRequired: integer;
    function GetSubletTotal: double;
    procedure SetPNETAuthorisedQuoteNumber(const Value: string);
    procedure SetQuoteComments(const Value: string);
    procedure SetQuoteCreator(const Value: string);
    procedure SetQuoteStatus(const Value: string);
    procedure SetQuoteType(const Value: string);
    procedure SetQuotingMethodIndicator(const Value: string);
    procedure SetRepairDaysRequired(const Value: integer);
    function GetLabourLines: TPNetLabourLine;
    function GetPaintLines: TPNetPaintLine;
    function GetReportLines: TPNetReportLine;
    function GetSubletLines: TPNetSubletLine;
    function GetPartLines: TPNetPartLine;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function ValidateData: Boolean; override;
    procedure CalcOrderTotals; override;
  protected
    property Extra: TPNetSaleExtra read GetExtra;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    procedure CalcTotalsCallback(const Sender: TBusObj; var Abort: Boolean); override;
  published
    property QuoteStatus: string read GetQuoteStatus write SetQuoteStatus; { PNetSales (Active,Responded,Win,Lose,TotalLoss,Cancelled)  }
    property PNETAuthorisedQuoteNumber: string read GetPNETAuthorisedQuoteNumber write SetPNETAuthorisedQuoteNumber;     { PNetSale }
    property QuotationSoftware: string read GetQuotationSoftware; { ERP }
    property QuotationSoftwareVersion: string read GetQuotationSoftwareVersion; { 10.0.0.0 }
    property QuoteCreator: string read GetQuoteCreator write SetQuoteCreator; { tblSales.EmployeeName }

(*  The following all come from the Job Customer
    property QuoteRequestNumber: string;           { from TPNetJob }
    property QuoteRequestVersionNumber: integer;     { from TPNetJob }
    property ClaimNumber: string;                   { from TPNetJob }
    property ClaimCustomerTitle: string;            { from TPNetJob }
    property ClaimCustomerFirstName: string;            { from TPNetJob }
    property ClaimCustomerSurname: string;            { from TPNetJob }
    property ClaimCustomerCompanyName: string;            { from TPNetJob }
    property ClaimCustomerPrivatePhoneNumber: string;            { from TPNetJob }
    property ClaimCustomerBusinessPhoneNumber: string;            { from TPNetJob }
    property VehicleRegistration: string;           { from TPNetJob }
    property VehicleDescription: string;           { from TPNetJob }
    property VehicleMake: string;           { from TPNetJob }
    property VehicleYearOfManufacture: integer;           { from TPNetJob }
    property VehicleMonthOfManufacture: integer;           { from TPNetJob }
    property VehicleBodyShape: string;           { from TPNetJob }
    property VehicleTransmissionType: string;           { from TPNetJob }
    property VehicleNumberOfCylinders: string;           { from TPNetJob }
    property VehicleVINChassis: string;           { from TPNetJob }
    property VehicleColor: string;           { from TPNetJob }
    property VehiclePaintType: string;           { from TPNetJob }
    property VehicleOdometer: integer;           { from TPNetJob }
    property VehicleFuelLevel: integer;           { from TPNetJob }
    property VehicleDamageDescription: string;           { from TPNetJob }
    property VehicleOldDamageDescription: string;           { from TPNetJob }
*)
    property QuoteComments: string read GetQuoteComments write SetQuoteComments; { tblSales.Comments }
    property RepairDaysRequired: integer read GetRepairDaysRequired write SetRepairDaysRequired; { PNetSale }
    property QuoteReference: string read GetQuoteReference;  { reference within ERP system eg sale GlobalRef (max 20)}
    property QuoteType: string read GetQuoteType write SetQuoteType;  { R,S,ADJR,ADJS,AUTR or AUTS (max 4)}
    property QuotingMethodIndicator: string read GetQuotingMethodIndicator write SetQuotingMethodIndicator; { C or H (max 1)}
    property LabourTotal: double read GetLabourTotal; { sum of net labour lines (ex GST) }
    property PaintTotal: double read GetPaintTotal; { sum of net paint lines (ex GST) }
    property PartTotal: double read GetPartTotal; { sum of net part lines (ex GST) }
    property PartMarkupTotal: double read GetPartMarkupTotal; { sum of net part lines markup amounts (ex GST) }
    property SubletTotal: double read GetSubletTotal; { sum of net sublet lines (ex GST) }
    property GST: double read GetGST; { GST = (Labour Total + Paint Total + Part Total + Part MarkUp Total + Sublet Total ) * GST Rate }
    property QuoteTotal: double read GetQuoteTotal; { Quote Total = Labour Total + Paint Total + Part Total + Part MarkUp Total + Sublet Total + GST }
    property ImageCount: integer read GetImageCount; { = Attachment count }
    property Attachments: TAttachment read GetAttachments;
    { Quote body lines lists }
    property LabourLines: TPNetLabourLine read GetLabourLines;
    property PaintLines: TPNetPaintLine read GetPaintLines;
    property PartLines: TPNetPartLine read GetPartLines;
    property ReportLines: TPNetReportLine read GetReportLines;
    property SubletLines: TPNetSubletLine read GetSubletLines;
  end;

  TPNetQuote = class(TPNetSale)
  private
  protected
    function GetLines: TTransLineBase; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
  end;

  TPNetSaleLineExtra = class(TMSBusObj)
  private
    function GetGroup: integer;
    function GetItemType: string;
    function GetLineType: string;
    function GetQuoteLineChangeIndicator: string;
    function GetQuoteLineNumber: integer;
    function GetSaleLineID: integer;
    function GetSubletAuthorityNumber: integer;
    procedure SetGroup(const Value: integer);
    procedure SetItemType(const Value: string);
    procedure SetLineType(const Value: string);
    procedure SetQuoteLineChangeIndicator(const Value: string);
    procedure SetQuoteLineNumber(const Value: integer);
    procedure SetSaleLineID(const Value: integer);
    procedure SetSubletAuthorityNumber(const Value: integer);
    function GetSubletManagmentFlag: string;
    procedure SetSubletManagmentFlag(const Value: string);
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SaleLineID: integer read GetSaleLineID write SetSaleLineID;
    property LineType: string read GetLineType write SetLineType; { Labour,Paint,Part,Report,Sublet  }
    { QuoteLineNumber will normally = salelineId except if insurer has inserted line then will be zero and QuoteLineChangeIndicator = I }
    property QuoteLineNumber: integer read GetQuoteLineNumber write SetQuoteLineNumber;
    property QuoteLineChangeIndicator: string read GetQuoteLineChangeIndicator write SetQuoteLineChangeIndicator;
    { Qroup is used for grouping lines of the same type (eg Labour, Paint) where only last line in group will have an amount, other lines will have amount of 0 }
    property Group: integer read GetGroup write SetGroup;
    {  LabourType = (RR, REPR, OTH, RI, MECH, PLAS); }
    property ItemType: string read GetItemType write SetItemType;
    property SubletAuthorityNumber: integer read GetSubletAuthorityNumber write SetSubletAuthorityNumber;
    property SubletManagmentFlag: string read GetSubletManagmentFlag write SetSubletManagmentFlag;
  end;


  TPNetSaleLine = class(TSalesLine)
  private
    fExtra: TPNetSaleLineExtra;
//    function GetAttachment: TAttachment;
    function GetGroup: integer;
    function GetLineType: string;
    function GetQuoteLineChangeIndicator: string;
    function GetQuoteLineNumber: integer;
//    function GetSubletAuthorityNumber: integer;
//    function GetSubletManagementFlag: string;
    procedure SetGroup(const Value: integer);
    procedure SetLineType(const Value: string);
    procedure SetQuoteLineChangeIndicator(const Value: string);
    procedure SetQuoteLineNumber(const Value: integer);
//    procedure SetSubletAuthorityNumber(const Value: integer);
//    procedure SetSubletManagementFlag(const Value: string);
    function GetExtra: TPNetSaleLineExtra;
    function GetItemType: string;
    procedure SetItemType(const Value: string);
    function GetCostMarkupAmount: double;
    function GetCostMarkupPercent: double;
    procedure SetCostMarkupAmount(const Value: double);
    procedure SetCostMarkupPercent(const Value: double);
  protected
    property Extra: TPNetSaleLineExtra read GetExtra;
    function DoAfterPost(Sender: TDatasetBusObj): boolean; override;
  published
    property LineType: string read GetLineType write SetLineType;
    property QuoteLineNumber: integer read GetQuoteLineNumber write SetQuoteLineNumber;
    property QuoteLineChangeIndicator: string read GetQuoteLineChangeIndicator write SetQuoteLineChangeIndicator;
    property Group: integer read GetGroup write SetGroup;
    property ItemType: string read GetItemType write SetItemType;
    property CostMarkupAmount: double read GetCostMarkupAmount write SetCostMarkupAmount;
    property CostMarkupPercent: double read GetCostMarkupPercent write SetCostMarkupPercent;

    { -- Labour Line -- }
    (* property QuoteLineNumber: integer; *)
    (* property QuoteLineChangeIndicator: string; *)
    (* property LabourGroup: integer; { use Group } *)
    (* property LabourType: string; { ItemType } *)
    (* property LabourDescription: string; { SaleLine Description }  *)
    (* property LabourAmount: double; { SaleLine TotalLineAmount (2 places)}  *)
    (* property LabourHours: double; { SaleLine UOMQtySold (2 places)}  *)
    (* property LabourRate: double; { SaleLine LinePrice (2 places)}  *)

    { -- Paint Line -- }
    (* property QuoteLineNumber: integer; *)
    (* property QuoteLineChangeIndicator: string; *)
    (* property PaintGroup: integer; { use Group } *)
    (* property PaintWorkType: string; { ItemType } *)
    (* property PaintDescription: string; { SaleLine Description }  *)
    (* property PaintAmount: double; { SaleLine TotalLineAmount (2 places)}  *)
    (* property PaintHours: double; { SaleLine UOMQtySold (2 places)}  *)
    (* property PaintRate: double; { SaleLine LinePrice (2 places)}  *)

    { -- Part Line -- }
    (* property QuoteLineNumber: integer; *)
    (* property QuoteLineChangeIndicator: string; *)
    (* property PartType: string; { ItemType } *)
    (* property PartNumber: string; { SaleLine ProductName } *)
    (* property PartQuantity: double; { SaleLine UOMQtySold ( integer )}  *)
    (* property PartUnitPrice: double; { SaleLine LinePrice (2 places)}  *)
    (* property PartAmount: double; { SaleLine TotalLineAmount (2 places)}  *)
    (* property PartMarkupPercentage: double; { SaleLine MarkupPercent or calc from cost? (% with 2 places)}  *)
    (* property PartMarkupAmount: double; { SaleLine Markup or calc from cost? (2 places)}  *)

    { -- Report Line -- }
    (* property QuoteLineNumber: integer; *)
    (* property QuoteLineChangeIndicator: string; *)
    (* property ReportItemDescription: string; { SaleLine Description }  *)

    { -- Sublet Line -- }
    (* property QuoteLineNumber: integer; *)
    (* property QuoteLineChangeIndicator: string; *)
    (* property SubletType: string; { ItemType } *)
    (* property SubletDescription: string; { SaleLine Description }  *)
    (* property SubletAmount: double; { SaleLine TotalLineAmount (2 places)}  *)
    (* property SubletManagementFlag: string read GetSubletManagementFlag write SetSubletManagementFlag; *)
    (* property SubletRepairer: string; { TSalesLine SupplierName } *)
    (* property SubletRepairerAddress: string; { TSalesLine SupplierNAme > TSupplier address(max 120)} *)
    (* property SubletRepairerPhone: string; { TSalesLine SupplierNAme > TSupplier.Phone (max 10)} *)
    (* property SubletAuthorityNumber: integer read GetSubletAuthorityNumber write SetSubletAuthorityNumber; *)
    (* property SubletAuthorityDocument: { Attachment } *)
  end;

  TPNetLabourLine = class(TPNetSaleLine)
  private
    function GetLabourAmount: double;
    function GetLabourDescription: string;
    function GetLabourGroup: integer;
    function GetLabourHoures: double;
    function GetLabourRate: double;
    function GetLabourType: string;
    procedure SetLabourAmount(const Value: double);
    procedure SetLabourDescription(const Value: string);
    procedure SetLabourGroup(const Value: integer);
    procedure SetLabourHours(const Value: double);
    procedure SetLabourRate(const Value: double);
    procedure SetLabourType(const Value: string);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    { -- Labour Line -- }
    (* property QuoteLineNumber: integer; *)
    (* property QuoteLineChangeIndicator: string; *)
    property LabourGroup: integer read GetLabourGroup write SetLabourGroup; { use Group }
    property LabourType: string read GetLabourType write SetLabourType; { ItemType }
    property LabourDescription: string read GetLabourDescription write SetLabourDescription; { SaleLine Description }
    property LabourAmount: double read GetLabourAmount write SetLabourAmount; { SaleLine TotalLineAmount (2 places)}
    property LabourHours: double read GetLabourHoures write SetLabourHours; { SaleLine UOMQtySold (2 places)}
    property LabourRate: double Read GetLabourRate write SetLabourRate; { SaleLine LinePrice (2 places)}
  end;

  TPNetPaintLine = class(TPNetSaleLine)
  private
    function GetPaintAmount: double;
    function GetPaintDescription: string;
    function GetPaintGroup: integer;
    function GetPaintHoures: double;
    function GetPaintRate: double;
    function GetPaintWorkType: string;
    procedure SetPaintAmount(const Value: double);
    procedure SetPaintDescription(const Value: string);
    procedure SetPaintGroup(const Value: integer);
    procedure SetPaintHours(const Value: double);
    procedure SetPaintRate(const Value: double);
    procedure SetPaintWorkType(const Value: string);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    { -- Labour Line -- }
    (* property QuoteLineNumber: integer; *)
    (* property QuoteLineChangeIndicator: string; *)
    property PaintGroup: integer read GetPaintGroup write SetPaintGroup; { use Group }
    property PaintWorkType: string read GetPaintWorkType write SetPaintWorkType; { ItemType }
    property PaintDescription: string read GetPaintDescription write SetPaintDescription; { SaleLine Description }
    property PaintAmount: double read GetPaintAmount write SetPaintAmount; { SaleLine TotalLineAmount (2 places)}
    property PaintHours: double read GetPaintHoures write SetPaintHours; { SaleLine UOMQtySold (2 places)}
    property PaintRate: double Read GetPaintRate write SetPaintRate; { SaleLine LinePrice (2 places)}
  end;

  TPNetPartLine = class(TPNetSaleLine)
  private
    function GetPartAmount: double;
    function GetPartDescription: string;
    function GetPartMarkupAmount: double;
    function GetPartMarkupPercentage: double;
    function GetPartNumber: string;
    function GetPartQuantity: double;
    function GetPartType: string;
    function GetPartUnitPrice: double;
    procedure SetPartAmount(const Value: double);
    procedure SetPartDescription(const Value: string);
    procedure SetPartMarkupAmount(const Value: double);
    procedure SetPartMarkupPercentage(const Value: double);
    procedure SetPartNumber(const Value: string);
    procedure SetPartQuantity(const Value: double);
    procedure SetPartType(const Value: string);
    procedure SetPartUnitPrice(const Value: double);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    { -- Labour Line -- }
    (* property QuoteLineNumber: integer; *)
    (* property QuoteLineChangeIndicator: string; *)
    property PartType: string read GetPartType write SetPartType; { ItemType }
    property PartNumber: string read GetPartNumber write SetPartNumber; { SaleLine ProductName }
    property PartDescription: string read GetPartDescription write SetPartDescription;
    property PartQuantity: double read GetPartQuantity write SetPartQuantity; { SaleLine UOMQtySold ( integer )}
    property PartUnitPrice: double read GetPartUnitPrice write SetPartUnitPrice; { SaleLine LinePrice (2 places)}
    property PartAmount: double read GetPartAmount write SetPartAmount; { SaleLine TotalLineAmount (2 places)}
    property PartMarkupPercentage: double read GetPartMarkupPercentage write SetPartMarkupPercentage; { SaleLine MarkupPercent or calc from cost? (% with 2 places)}
    property PartMarkupAmount: double read GetPartMarkupAmount write SetPartMarkupAmount; { SaleLine Markup or calc from cost? (2 places)}
  end;

  TPNetReportLine = class(TPNetSaleLine)
  private
    function GetReportItemDescription: string;
    procedure SetReportItemDescription(const Value: string);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    { -- Labour Line -- }
    (* property QuoteLineNumber: integer; *)
    (* property QuoteLineChangeIndicator: string; *)
    property ReportItemDescription: string read GetReportItemDescription write SetReportItemDescription;
  end;

  TPNetSubletLine = class(TPNetSaleLine)
  private
    function GetSubletAmount: double;
    function GetSubletAuthorityDocument: TAttachment;
    function GetSubletDescription: string;
    function GetSubletRepairer: string;
    function GetSubletRepairerAddress: string;
    function GetSubletRepairerPhone: string;
    procedure SetSubletAmount(const Value: double);
    procedure SetSubletDescription(const Value: string);
    procedure SetSubletRepairer(const Value: string);
    function GetSubletAuthorityNumber: integer;
    function GetSubletManagementFlag: string;
    procedure SetSubletAuthorityNumber(const Value: integer);
    procedure SetSubletManagementFlag(const Value: string);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    { -- Sublet Line -- }
    (* property QuoteLineNumber: integer; *)
    (* property QuoteLineChangeIndicator: string; *)
    (* property SubletType: string; { ItemType } *)
    property SubletDescription: string read GetSubletDescription write SetSubletDescription; { SaleLine Description }
    property SubletAmount: double read GetSubletAmount write SetSubletAmount; { SaleLine TotalLineAmount (2 places)}
    property SubletManagementFlag: string read GetSubletManagementFlag write SetSubletManagementFlag;
    property SubletRepairer: string read GetSubletRepairer write SetSubletRepairer; { TSalesLine SupplierName }
    property SubletRepairerAddress: string read GetSubletRepairerAddress; { TSalesLine SupplierNAme > TSupplier address(max 120)}
    property SubletRepairerPhone: string read GetSubletRepairerPhone; { TSalesLine SupplierNAme > TSupplier.Phone (max 10)}
    property SubletAuthorityNumber: integer read GetSubletAuthorityNumber write SetSubletAuthorityNumber;
    property SubletAuthorityDocument: TAttachment read GetSubletAuthorityDocument;
  end;

  TPNetQuoteLine = class(TPNetSaleLine)
  end;


implementation

uses
  SysUtils, DB, windows, FileVersion, CommonLib, BusObjClient, BusObjSaleBase;

function GetModuleNameStr: string;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

{ TPNetSale }

procedure TPNetSale.CalcOrderTotals;
begin
  LabourLines.PostDb;
  PaintLines.PostDb;
  PartLines.PostDb;
  SubletLines.PostDb;
  Lines.Dataset.Refresh;
  fLabourTotal:= 0;
  fPaintTotal:= 0;
  fPartTotal:= 0;
  fPartMarkupTotal:= 0;
  fSubletTotal:= 0;
  inherited;
end;

procedure TPNetSale.CalcTotalsCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if SameText(TPNetSaleLine(Sender).QuoteLineChangeIndicator, 'D') or
  TSalesLineBase(Sender).Deleted then exit;
  inherited;
  if SameText(TPNetSaleLine(Sender).LineType,'Labour') then
    fLabourTotal := fLabourTotal + TPNetSaleLine(Sender).TotalLineAmount
  else if SameText(TPNetSaleLine(Sender).LineType,'Paint') then
    fPaintTotal := fPaintTotal + TPNetSaleLine(Sender).TotalLineAmount
  else if SameText(TPNetSaleLine(Sender).LineType,'Part') then begin
    fPartTotal := fPartTotal + TPNetSaleLine(Sender).TotalLineAmount;
    fPartMarkupTotal := fPartMarkupTotal + (TPNetSaleLine(Sender).MarkupAmount * TPNetSaleLine(Sender).UOMQtySold);
  end
  else if SameText(TPNetSaleLine(Sender).LineType,'Sublet') then
    fSubletTotal := fSubletTotal + TPNetSaleLine(Sender).TotalLineAmount;
end;

constructor TPNetSale.Create(AOwner: TComponent);
begin
  fLabourTotal:= 0;
  fPaintTotal:= 0;
  fPartTotal:= 0;
  fPartMarkupTotal:= 0;
  fSubletTotal:= 0;
  inherited;
  self.ExportExcludeList.Add('lines');
end;

destructor TPNetSale.Destroy;
begin

  inherited;
end;

function TPNetSale.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  Extra.PostDb;
end;

function TPNetSale.GetAttachments: TAttachment;
begin
  result := TAttachment(GetContainerComponent(TAttachment ,'TableName = "tblSales" and TableId = ' + IntToStr(Self.ID)));
end;

function TPNetSale.GetExtra: TPNetSaleExtra;
begin
  if not Assigned(fExtra) then
    fExtra:= TPNetSaleExtra.Create(self);
  result := fExtra;
  if self.ID = 0 then begin
    if Dataset.State in [dsEdit, dsInsert] then
      PostDb;
  end;
  if (result.ID <> self.ID) and (self.ID <> 0)then begin
    result.Load(Self.ID);
    if (result.ID <> self.ID) then begin
      result.New;
      result.SaleID := self.ID;
      result.PostDb;
    end;
  end;
end;

function TPNetSale.GetGST: double;
begin
  result := self.TotalTax;
end;

function TPNetSale.GetImageCount: integer;
begin
  result := Attachments.Count;
end;

function TPNetSale.GetLabourLines: TPNetLabourLine;
begin
  result := TPNetLabourLine(GetContainerComponent(TPNetLabourLine, 'SaleID = '+ IntToStr(Self.Id) + ' and SaleLineID = (select SaleLineID from PNetSaleLine where LineType = "Labour")'));
end;

function TPNetSale.GetLabourTotal: double;
begin
  result := fLabourTotal;
end;

function TPNetSale.GetPaintLines: TPNetPaintLine;
begin
  result := TPNetPaintLine(GetContainerComponent(TPNetPaintLine, 'SaleID = '+ IntToStr(Self.Id) + ' and SaleLineID = (select SaleLineID from PNetSaleLine where LineType = "Paint")'));
end;

function TPNetSale.GetPaintTotal: double;
begin
  result := fPaintTotal;
end;

function TPNetSale.GetPartLines: TPNetPartLine;
begin
  result := TPNetPartLine(GetContainerComponent(TPNetPartLine, 'SaleID = '+ IntToStr(Self.Id) + ' and SaleLineID = (select SaleLineID from PNetSaleLine where LineType = "Part")'));
end;

function TPNetSale.GetPartMarkupTotal: double;
begin
  result := fPartMarkupTotal;
end;

function TPNetSale.GetPartTotal: double;
begin
  result := fPartTotal;
end;

function TPNetSale.GetPNETAuthorisedQuoteNumber: string;
begin
  result := Extra.PNETAuthorisedQuoteNumber;
end;

function TPNetSale.GetQuotationSoftware: string;
begin
  result := 'ERP';
end;

function TPNetSale.GetQuotationSoftwareVersion: string;
begin
  result := FileVersion.GetFileVersion(GetModuleNameStr);
end;

function TPNetSale.GetQuoteComments: string;
begin
  result := self.Comments;
end;

function TPNetSale.GetQuoteCreator: string;
begin
  result := self.EmployeeName;
end;

function TPNetSale.GetQuoteReference: string;
begin
  result := self.GlobalRef;
end;

function TPNetSale.GetQuoteStatus: string;
begin
  result := Extra.QuoteStatus;
end;

function TPNetSale.GetQuoteTotal: double;
begin
  result := self.TotalAmountInc;
end;

function TPNetSale.GetQuoteType: string;
begin
  result := Extra.QuoteType;
end;

function TPNetSale.GetQuotingMethodIndicator: string;
begin
  result := Extra.QuotingMethodIndicator;
end;

function TPNetSale.GetRepairDaysRequired: integer;
begin
  result:= Extra.RepairDaysRequired;
end;

function TPNetSale.GetReportLines: TPNetReportLine;
begin
  result := TPNetReportLine(GetContainerComponent(TPNetReportLine, 'SaleID = '+ IntToStr(Self.Id) + ' and SaleLineID = (select SaleLineID from PNetSaleLine where LineType = "Report")'));
end;

function TPNetSale.GetSubletLines: TPNetSubletLine;
begin
  result := TPNetSubletLine(GetContainerComponent(TPNetSubletLine, 'SaleID = '+ IntToStr(Self.Id) + ' and SaleLineID = (select SaleLineID from PNetSaleLine where LineType = "Sublet")'));
end;

function TPNetSale.GetSubletTotal: double;
begin
  result := fSubletTotal;
end;

procedure TPNetSale.SetPNETAuthorisedQuoteNumber(const Value: string);
begin
  Extra.PNETAuthorisedQuoteNumber := Value;
end;

procedure TPNetSale.SetQuoteComments(const Value: string);
begin
  self.Comments := Value;
end;

procedure TPNetSale.SetQuoteCreator(const Value: string);
begin
  self.EmployeeName := Value;
end;

procedure TPNetSale.SetQuoteStatus(const Value: string);
begin
  Extra.QuoteStatus := Value;
  FlagAsUpdated;
end;

procedure TPNetSale.SetQuoteType(const Value: string);
begin
  Extra.QuoteType := Value;
  FlagAsUpdated;
end;

procedure TPNetSale.SetQuotingMethodIndicator(const Value: string);
begin
  Extra.QuotingMethodIndicator := Value;
  FlagAsUpdated;
end;

procedure TPNetSale.SetRepairDaysRequired(const Value: integer);
begin
  Extra.RepairDaysRequired := Value;
  FlagAsUpdated;
end;

function TPNetSale.ValidateData: Boolean;
begin
  result:= inherited;
  if not result then exit;
//  result:= false;

  result:= true;
end;

{ TPNetQuote }

constructor TPNetQuote.Create(AOwner: TComponent);
begin
  inherited;
  fSQL:= 'SELECT * FROM tblSales';
  fSQLSelect := 'IsQuote = "T" and tblSales.SaleID = (select SaleID from PNetSale where PNetSale.SaleID = tblSales.SaleID)';
end;

destructor TPNetQuote.Destroy;
begin

  inherited;
end;


function TPNetQuote.GetLines: TTransLineBase;
begin
  result := TPNetSaleLine(GetContainerComponent(TPNetSaleLine, 'SaleID = '+ IntToStr(Self.Id)));
end;

{ TPNetSaleExtra }

constructor TPNetSaleExtra.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'PNetSale';
  fSQL := 'SELECT * FROM pnetsale';
end;

destructor TPNetSaleExtra.Destroy;
begin

  inherited;
end;

class function TPNetSaleExtra.GetBusObjectTablename: string;
begin
  result:= 'PNetSale';
end;

class function TPNetSaleExtra.GetIDField: string;
begin
  result := 'SaleId'
end;

function TPNetSaleExtra.GetPNETAuthorisedQuoteNumber: string;
begin
  result := GetStringField('PNETAuthorisedQuoteNumber');
end;

function TPNetSaleExtra.GetQuoteStatus: string;
begin
  result := GetStringField('QuoteStatus');
end;

function TPNetSaleExtra.GetQuoteType: string;
begin
  result := GetStringField('QuoteType');
end;

function TPNetSaleExtra.GetQuotingMethodIndicator: string;
begin
  result := GetStringField('QuotingMethodIndicator');
end;

function TPNetSaleExtra.GetRepairDaysRequired: integer;
begin
  result := GetIntegerField('RepairDaysRequired');
end;

function TPNetSaleExtra.GetSaleID: integer;
begin
  result := GetIntegerField('SaleID');
end;

procedure TPNetSaleExtra.SetPNETAuthorisedQuoteNumber(const Value: string);
begin
  SetStringField('PNETAuthorisedQuoteNumber',Value)
end;

procedure TPNetSaleExtra.SetQuoteStatus(const Value: string);
begin
  SetStringField('QuoteStatus', Value);
end;

procedure TPNetSaleExtra.SetQuoteType(const Value: string);
begin
  SetStringField('QuoteType', Value);
end;

procedure TPNetSaleExtra.SetQuotingMethodIndicator(const Value: string);
begin
  SetStringField('QuoteMethodIndicator', Value);
end;

procedure TPNetSaleExtra.SetRepairDaysRequired(const Value: integer);
begin
  SetIntegerField('RepairDaysRequired',Value)
end;

procedure TPNetSaleExtra.SetSaleID(const Value: integer);
begin
  SetIntegerField('SaleID',Value)
end;

{ TPNetSaleLineExtra }

constructor TPNetSaleLineExtra.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'PNetSaleLine';
  fSQL := 'SELECT * FROM pnetsaleline';
end;

destructor TPNetSaleLineExtra.Destroy;
begin

  inherited;
end;

class function TPNetSaleLineExtra.GetBusObjectTablename: string;
begin
  result := 'PNetSaleLine'
end;

function TPNetSaleLineExtra.GetGroup: integer;
begin
  result := GetIntegerField('Group');
end;

class function TPNetSaleLineExtra.GetIDField: string;
begin
  result := 'SaleLineID';
end;

function TPNetSaleLineExtra.GetItemType: string;
begin
  result := GetStringField('ImageType');
end;

function TPNetSaleLineExtra.GetLineType: string;
begin
  result := GetStringField('LineType');
end;

function TPNetSaleLineExtra.GetQuoteLineChangeIndicator: string;
begin
  result := GetStringField('QuoteLineChangeIndicator');
end;

function TPNetSaleLineExtra.GetQuoteLineNumber: integer;
begin
  result := GetIntegerField('QuoteLineNumber');
end;

function TPNetSaleLineExtra.GetSaleLineID: integer;
begin
  result := GetIntegerField('QuoteSaleLineID');
end;

function TPNetSaleLineExtra.GetSubletAuthorityNumber: integer;
begin
  result := GetIntegerField('QuoteSunletAuthorityNumber');
end;

function TPNetSaleLineExtra.GetSubletManagmentFlag: string;
begin
  result := GetStringField('SubletManagmentFlag');
end;

procedure TPNetSaleLineExtra.SetGroup(const Value: integer);
begin
  SetIntegerField('Group',Value);
end;

procedure TPNetSaleLineExtra.SetItemType(const Value: string);
begin
  SetStringField('ItemType',Value);
end;

procedure TPNetSaleLineExtra.SetLineType(const Value: string);
begin
  SetStringField('LineType',Value);
end;

procedure TPNetSaleLineExtra.SetQuoteLineChangeIndicator(const Value: string);
begin
  SetStringField('QuoteLineChangeIndicator',Value);
end;

procedure TPNetSaleLineExtra.SetQuoteLineNumber(const Value: integer);
begin
  SetIntegerField('QuoteLineNumber',Value);
end;

procedure TPNetSaleLineExtra.SetSaleLineID(const Value: integer);
begin
  SetIntegerField('SaleLineID',Value);
end;

procedure TPNetSaleLineExtra.SetSubletAuthorityNumber(const Value: integer);
begin
  SetIntegerField('SubletAuthorityNumber',Value);
end;

procedure TPNetSaleLineExtra.SetSubletManagmentFlag(const Value: string);
begin
  SetStringField('SubletManagmentFlag',Value);
end;

{ TPNetSaleLine }

function TPNetSaleLine.DoAfterPost(Sender: TDatasetBusObj): boolean;
var
  LineNo: integer;
begin
  result := inherited;
  if self.QuoteLineChangeIndicator = 'I' then
    LineNo := 0
  else
    LineNo := self.ID;
  if self.QuoteLineNumber <> LineNo then
    self.QuoteLineNumber := LineNo;
end;

function TPNetSaleLine.GetCostMarkupAmount: double;
begin
  result := 0;
  if self.QtySold <> 0 then
    result := CommonLib.Round(self.LinePrice - self.LineCost,2);
end;

function TPNetSaleLine.GetCostMarkupPercent: double;
begin
  result := 0;
  if (self.QtySold <> 0) and (self.TotalLineAmount > 0) then
    result := CommonLib.Round((self.LineCost / self.LinePrice) * 100, 2);
end;

function TPNetSaleLine.GetExtra: TPNetSaleLineExtra;
begin
  if not Assigned(fExtra) then
    fExtra:= TPNetSaleLineExtra.Create(self);
  result := fExtra;
  if self.ID = 0 then begin
    if Dataset.State in [dsEdit, dsInsert] then
      PostDb;
  end;
  if (result.ID <> self.ID) and (self.ID <> 0)then begin
    result.Load(Self.ID);
    if (result.ID <> self.ID) then begin
      result.New;
      result.SaleLineID := self.ID;
      result.PostDb;
    end;
  end;
end;

function TPNetSaleLine.GetGroup: integer;
begin
  result := Extra.Group;
end;

function TPNetSaleLine.GetItemType: string;
begin
  result := Extra.ItemType;
end;

function TPNetSaleLine.GetLineType: string;
begin
  result := Extra.LineType;
end;

function TPNetSaleLine.GetQuoteLineChangeIndicator: string;
begin
  result := Extra.QuoteLineChangeIndicator;
end;

function TPNetSaleLine.GetQuoteLineNumber: integer;
begin
  result := Extra.QuoteLineNumber;
end;

procedure TPNetSaleLine.SetCostMarkupAmount(const Value: double);
begin
  Self.LinePrice := self.LineCost + Value;
end;

procedure TPNetSaleLine.SetCostMarkupPercent(const Value: double);
begin
  if Value <> 0 then begin
    self.LinePrice := self.LineCost * (1 + (Value / 100));
  end
  else begin
    { 0 percent }
    self.LinePrice := self.LineCost;
  end;
end;

procedure TPNetSaleLine.SetGroup(const Value: integer);
begin
  Extra.Group := Value;
  self.FlagAsUpdated();
end;

procedure TPNetSaleLine.SetItemType(const Value: string);
begin
  Extra.ItemType := Value;
  self.FlagAsUpdated();
end;

procedure TPNetSaleLine.SetLineType(const Value: string);
begin
  Extra.LineType := Value;
  self.FlagAsUpdated();
end;

procedure TPNetSaleLine.SetQuoteLineChangeIndicator(const Value: string);
begin
  Extra.QuoteLineChangeIndicator := Value;
  self.FlagAsUpdated();
end;

procedure TPNetSaleLine.SetQuoteLineNumber(const Value: integer);
begin
  Extra.QuoteLineNumber := Value;
  self.FlagAsUpdated();
end;

{ TPNetLabourLine }

constructor TPNetLabourLine.Create(AOwner: TComponent);
begin
  inherited;
  self.ExportExcludeList.Add('attachment');
end;

function TPNetLabourLine.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited;
  if LineType <> 'Labour' then
    LineType := 'Labour';
end;

function TPNetLabourLine.GetLabourAmount: double;
begin
  result := self.TotalLineAmount;
end;

function TPNetLabourLine.GetLabourDescription: string;
begin
  result := Self.Product_Description;
end;

function TPNetLabourLine.GetLabourGroup: integer;
begin
  result := self.Group;
end;

function TPNetLabourLine.GetLabourHoures: double;
begin
  result := self.UOMQtySold;
end;

function TPNetLabourLine.GetLabourRate: double;
begin
  result := self.LinePrice;
end;

function TPNetLabourLine.GetLabourType: string;
begin
  result := ItemType;
end;

procedure TPNetLabourLine.SetLabourAmount(const Value: double);
begin
  self.TotalLineAmount:= Value;
end;

procedure TPNetLabourLine.SetLabourDescription(const Value: string);
begin
  self.Product_Description := Value;
end;

procedure TPNetLabourLine.SetLabourGroup(const Value: integer);
begin
  self.Group := Value;
end;

procedure TPNetLabourLine.SetLabourHours(const Value: double);
begin
  self.UOMQtySold := Value;
end;

procedure TPNetLabourLine.SetLabourRate(const Value: double);
begin
  self.LinePrice := Value;
end;

procedure TPNetLabourLine.SetLabourType(const Value: string);
begin
  self.ItemType := Value;
end;

{ TPNetPaintLine }

constructor TPNetPaintLine.Create(AOwner: TComponent);
begin
  inherited;
  self.ExportExcludeList.Add('attachment');
end;

function TPNetPaintLine.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited;
  if LineType <> 'Paint' then
    LineType := 'Paint';
end;

function TPNetPaintLine.GetPaintAmount: double;
begin
  result := self.TotalLineAmount;
end;

function TPNetPaintLine.GetPaintDescription: string;
begin
  result := self.Product_Description;
end;

function TPNetPaintLine.GetPaintGroup: integer;
begin
  result := self.Group;
end;

function TPNetPaintLine.GetPaintHoures: double;
begin
  result := self.UOMQtySold;
end;

function TPNetPaintLine.GetPaintRate: double;
begin
  result := self.LinePrice;
end;

function TPNetPaintLine.GetPaintWorkType: string;
begin
  result := self.ItemType;
end;

procedure TPNetPaintLine.SetPaintAmount(const Value: double);
begin
  self.TotalLineAmount := Value;
end;

procedure TPNetPaintLine.SetPaintDescription(const Value: string);
begin
  self.Product_Description := Value;
end;

procedure TPNetPaintLine.SetPaintGroup(const Value: integer);
begin
  self.Group := Value;
end;

procedure TPNetPaintLine.SetPaintHours(const Value: double);
begin
  self.UOMQtySold := Value;
end;

procedure TPNetPaintLine.SetPaintRate(const Value: double);
begin
  self.LinePrice := Value;
end;

procedure TPNetPaintLine.SetPaintWorkType(const Value: string);
begin
  self.ItemType := Value;
end;

{ TPNetPartLine }

constructor TPNetPartLine.Create(AOwner: TComponent);
begin
  inherited;
  self.ExportExcludeList.Add('attachment');
end;

function TPNetPartLine.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited;
  if LineType <> 'Part' then
    LineType := 'Part';
end;

function TPNetPartLine.GetPartAmount: double;
begin
  result := self.TotalLineAmount;
end;

function TPNetPartLine.GetPartDescription: string;
begin
  result := self.Product_Description;
end;

function TPNetPartLine.GetPartMarkupAmount: double;
begin
  result := CostMarkupAmount;
end;

function TPNetPartLine.GetPartMarkupPercentage: double;
begin
  result := CostMarkupPercent;
end;

function TPNetPartLine.GetPartNumber: string;
begin
  result := self.ProductName;
end;

function TPNetPartLine.GetPartQuantity: double;
begin
  result := self.UOMQtySold;
end;

function TPNetPartLine.GetPartType: string;
begin
  result := self.ItemType;
end;

function TPNetPartLine.GetPartUnitPrice: double;
begin
  result := self.LinePrice;
end;

procedure TPNetPartLine.SetPartAmount(const Value: double);
begin
  self.TotalLineAmount := Value;
end;

procedure TPNetPartLine.SetPartDescription(const Value: string);
begin
  self.Product_Description := Value;
end;

procedure TPNetPartLine.SetPartMarkupAmount(const Value: double);
begin
  CostMarkupAmount:= Value;
end;

procedure TPNetPartLine.SetPartMarkupPercentage(const Value: double);
begin
  CostMarkupPercent := Value;
end;

procedure TPNetPartLine.SetPartNumber(const Value: string);
begin
  self.ProductName := Value;
end;

procedure TPNetPartLine.SetPartQuantity(const Value: double);
begin
  self.UOMQtySold := Value;
end;

procedure TPNetPartLine.SetPartType(const Value: string);
begin
  self.ItemType := Value;
end;

procedure TPNetPartLine.SetPartUnitPrice(const Value: double);
begin
  self.LinePrice := Value;
end;

{ TPNetReportLine }

constructor TPNetReportLine.Create(AOwner: TComponent);
begin
  inherited;
  self.ExportExcludeList.Add('attachment');
end;

function TPNetReportLine.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited;
  if LineType <> 'Report' then
    LineType := 'Report';
end;

function TPNetReportLine.GetReportItemDescription: string;
begin
  result := Self.Product_Description;
end;

procedure TPNetReportLine.SetReportItemDescription(const Value: string);
begin
  Self.Product_Description := Value;
end;

{ TPNetSubletLine }

constructor TPNetSubletLine.Create(AOwner: TComponent);
begin
  inherited;

end;

function TPNetSubletLine.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited;
  if LineType <> 'Sublet' then
    LineType := 'Sublet';
end;

function TPNetSubletLine.GetSubletAmount: double;
begin
  result := self.TotalLineAmount;
end;

function TPNetSubletLine.GetSubletAuthorityDocument: TAttachment;
begin
  result := TAttachment(GetContainerComponent(TAttachment ,'TableName = "tblSalesLines" and TableId = ' + IntToStr(Self.ID)));
end;

function TPNetSubletLine.GetSubletAuthorityNumber: integer;
begin
  result := Extra.SubletAuthorityNumber;
end;

function TPNetSubletLine.GetSubletDescription: string;
begin
  result := self.Product_Description;
end;

function TPNetSubletLine.GetSubletManagementFlag: string;
begin
  result := Extra.SubletManagmentFlag;
end;

function TPNetSubletLine.GetSubletRepairer: string;
begin
  result := self.SupplierName;
end;

function TPNetSubletLine.GetSubletRepairerAddress: string;
begin
  result := TClient.ClientStreetAddress(self.SubletRepairer);
end;

function TPNetSubletLine.GetSubletRepairerPhone: string;
begin
  result := TClient.ClientPhone(self.SubletRepairer);
end;

procedure TPNetSubletLine.SetSubletAmount(const Value: double);
begin
  self.TotalLineAmount := Value;
end;

procedure TPNetSubletLine.SetSubletAuthorityNumber(const Value: integer);
begin
  Extra.SubletAuthorityNumber := Value;
end;

procedure TPNetSubletLine.SetSubletDescription(const Value: string);
begin
  self.Product_Description := Value;
end;

procedure TPNetSubletLine.SetSubletManagementFlag(const Value: string);
begin
  Extra.SubletManagmentFlag := Value;
end;

procedure TPNetSubletLine.SetSubletRepairer(const Value: string);
begin
  self.SupplierName := Value;
end;

initialization
  Classes.RegisterClass(TPNetQuote);

end.
