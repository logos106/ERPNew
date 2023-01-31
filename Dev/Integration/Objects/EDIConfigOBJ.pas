unit EDIConfigOBJ;

interface

uses
  JsonDbPrefsConfigObj, MyAccess, DB;

type

  TEDIConfig = class(TJsonDbPefConfig)
  private
    function GetAutoSynchFromList         : boolean;
    function GetEnableEDI                 : boolean;
    function GetPOReadyStatus             : string;
    function GetPOacknowledgementStatus   : string;
    function GetShowEDIOnMainmenuByDefault: boolean;
    function GetPOSentStatus              : string;
    function GetDocSenderCode             : string;
    function GetPOShippedStatus           : string;

    function GetEnableSalesEDI            : boolean;
    function GetAutoSynchFromSalesList    : boolean;
    function GetSalesDocSenderCode        : string;
    function GetSalesReadyStatus          : string;
    function GetSalesSentStatus           : string;
    function GetSalesAcknowledgementStatus: string;
    function GetSalesShippedStatus        : string;

    procedure SetAutoSynchFromList          (const Value: boolean);
    procedure SetEnableEDI                  (const Value: boolean);
    procedure SetPOReadyStatus              (const Value: string);
    procedure SetPOacknowledgementStatus    (const Value: string);
    procedure SetShowEDIOnMainmenuByDefault (const Value: boolean);
    procedure SetPOSentStatus               (const Value: string);
    procedure SetDocSenderCode              (const Value: string);
    procedure SetPOShippedStatus            (const Value: string);

    procedure SetEnableSalesEDI             (const Value: boolean);
    procedure SetAutoSynchFromSalesList     (const Value: boolean);
    procedure SetSalesDocSenderCode         (const Value: string);
    procedure SetSalesReadyStatus           (const Value: string);
    procedure SetSalesSentStatus            (const Value: string);
    procedure SetSalesAcknowledgementStatus (const Value: string);
    procedure SetSalesShippedStatus         (const Value: string);

    procedure CheckDefaults;

  public
    procedure Load(connection: TMyConnection); overload; override;
    procedure Load(ds: TDataset); overload; override;

    property POReadyStatus              : string  read GetPOReadyStatus               write SetPOReadyStatus;
    property POSentStatus               : string  read GetPOSentStatus                write SetPOSentStatus;
    property POAcknowledgementStatus    : string  read GetPOAcknowledgementStatus     write SetPOAcknowledgementStatus;
    property POShippedStatus            : string  read GetPOShippedStatus             write SetPOShippedStatus;
    property DocSenderCode              : string  read GetDocSenderCode               write SetDocSenderCode;
    property AutoSynchFromList          : boolean read GetAutoSynchFromList           write SetAutoSynchFromList;
    property EnableEDI                  : boolean read GetEnableEDI                   write SetEnableEDI;

    property EnableSalesEDI             : boolean read GetEnableSalesEDI              write SetEnableSalesEDI;
    property AutoSynchFromSalesList     : boolean read GetAutoSynchFromSalesList      write SetAutoSynchFromSalesList;
    property SalesDocSenderCode         : string  read GetSalesDocSenderCode          write SetSalesDocSenderCode;
    property SalesReadyStatus           : string  read GetSalesReadyStatus            write SetSalesReadyStatus;
    property SalesSentStatus            : string  read GetSalesSentStatus             write SetSalesSentStatus;
    property SalesAcknowledgementStatus : string  read GetSalesAcknowledgementStatus  write SetSalesAcknowledgementStatus;
    property SalesShippedStatus         : string  read GetSalesShippedStatus          write SetSalesShippedStatus;

    property ShowEDIOnMainMenuByDefault : boolean read GetShowEDIOnMainmenuByDefault  write SetShowEDIOnMainmenuByDefault;

  end;


implementation

{ TEDIConfig }

procedure TEDIConfig.CheckDefaults;
begin
  if POReadyStatus              = '' then POReadyStatus               := 'Ready';
  if POSentStatus               = '' then POSentStatus                := 'Sent';
  if POAcknowledgementStatus    = '' then POAcknowledgementStatus     := 'Acknowleged';
  if POShippedStatus            = '' then POShippedStatus             := 'Shipped';
  if SalesReadyStatus           = '' then SalesReadyStatus            := 'Ready';
  if SalesSentStatus            = '' then SalesSentStatus             := 'Sent';
  if SalesAcknowledgementStatus = '' then SalesAcknowledgementStatus  := 'Acknowleged';
  if SalesShippedStatus         = '' then SalesShippedStatus          := 'Shipped';
end;

function TEDIConfig.GetAutoSynchFromList          : boolean ;begin  result := B['AutoSynchFromList']         ;end;
function TEDIConfig.GetAutoSynchFromSalesList     : boolean ;begin  result := B['AutoSynchFromSalesList']    ;end;
function TEDIConfig.GetDocSenderCode              : string  ;begin  result := S['DocSenderCode']             ;end;
function TEDIConfig.GetSalesDocSenderCode         : string  ;begin  result := S['SalesDocSenderCode']        ;end;
function TEDIConfig.GetEnableEDI                  : boolean ;begin  result := B['EnableEDI']                 ;end;
function TEDIConfig.GetEnableSalesEDI             : boolean ;begin  result := B['EnableSalesEDI']            ;end;
function TEDIConfig.GetPOReadyStatus              : string  ;begin  result := S['POReadyStatus']             ;end;
function TEDIConfig.GetSalesReadyStatus           : string  ;begin  result := S['SalesReadyStatus']          ;end;
function TEDIConfig.GetPOAcknowledgementStatus    : string  ;begin  result := S['POAcknowledgementStatus']   ;end;
function TEDIConfig.GetSalesAcknowledgementStatus : string  ;begin  result := S['SalesAcknowledgementStatus'];end;
function TEDIConfig.GetPOSentStatus               : string  ;begin  result := S['POSentStatus']              ;end;
function TEDIConfig.GetSalesSentStatus            : string  ;begin  result := S['SalesSentStatus']           ;end;
function TEDIConfig.GetPOShippedStatus            : string  ;begin  result := S['POShippedStatus']           ;end;
function TEDIConfig.GetSalesShippedStatus         : string  ;begin  result := S['SalesShippedStatus']        ;end;
function TEDIConfig.GetShowEDIOnMainmenuByDefault : boolean;begin  result := B['ShowEDIOnMainmenuByDefault'] ;end;
procedure TEDIConfig.SetAutoSynchFromList         (const Value: boolean);begin  B['AutoSynchFromList']         := Value;end;
procedure TEDIConfig.SetAutoSynchFromSalesList    (const Value: boolean);begin  B['AutoSynchFromSalesList']    := Value;end;
procedure TEDIConfig.SetDocSenderCode             (const Value: string );begin  S['DocSenderCode']             := Value;end;
procedure TEDIConfig.SetSalesDocSenderCode        (const Value: string );begin  S['SalesDocSenderCode']        := Value;end;
procedure TEDIConfig.SetEnableEDI                 (const Value: boolean);begin  B['EnableEDI']                 := Value;end;
procedure TEDIConfig.SetEnableSalesEDI            (const Value: boolean);begin  B['EnableSalesEDI']            := Value;end;
procedure TEDIConfig.SetPOReadyStatus             (const Value: string );begin  S['POReadyStatus']             := Value;end;
procedure TEDIConfig.SetSalesReadyStatus          (const Value: string );begin  S['SalesReadyStatus']          := Value;end;
procedure TEDIConfig.SetPOAcknowledgementStatus   (const Value: string );begin  S['POAcknowledgementStatus']   := Value;end;
procedure TEDIConfig.SetSalesAcknowledgementStatus(const Value: string );begin  S['SalesAcknowledgementStatus']:= Value;end;
procedure TEDIConfig.SetPOSentStatus              (const Value: string );begin  S['POSentStatus']              := Value;end;
procedure TEDIConfig.SetSalesSentStatus           (const Value: string );begin  S['SalesSentStatus']           := Value;end;
procedure TEDIConfig.SetPOShippedStatus           (const Value: string );begin  S['POShippedStatus']           := Value;end;
procedure TEDIConfig.SetSalesShippedStatus        (const Value: string );begin  S['SalesShippedStatus']        := Value;end;
procedure TEDIConfig.SetShowEDIOnMainmenuByDefault(const Value: boolean);begin  B['ShowEDIOnMainmenuByDefault']:= Value;end;
procedure TEDIConfig.Load(connection: TMyConnection);
begin
  inherited;
  CheckDefaults;
end;

procedure TEDIConfig.Load(ds: TDataset);
begin
  inherited;
  CheckDefaults;
end;

end.
