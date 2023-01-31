unit StsConfigObj;


interface

uses
  JsonDbPrefsConfigObj, MyAccess, DB;

type
  TStSConfig =  class(TJsonDbPefConfig)

    Function GetUseSeedtoSale         : Boolean;
    Function GetStSUsesBins    : Boolean;
    Function GetStSSimpleMode  : Boolean;
    function getStSPackageTagProduct  : String;
    function getStSPlantTagProduct    : String;
    function getStSDefaultClass       : String;
    function getStSDefaultWeightUOM   : String;
    function getStSSupplier           : String;
    Function getStSSupplierID         : Integer;
    function getStSStockAccount       : String;
    Function getStSDefaultClassID     : Integer;

    Procedure SetUseSeedtoSale        (Const Value: Boolean);
    Procedure SetStSUsesBins   (Const Value: Boolean);
    Procedure SetStSSimpleMode (Const Value: Boolean);
    procedure SetStSPackageTagProduct (const Value: String);
    procedure SetStSPlantTagProduct   (const Value: String);
    procedure SetStSDefaultClass      (const Value: String);
    procedure SetStSDefaultWeightUOM  (const Value: String);
    procedure SetStSSupplier          (const Value: String);
    procedure SetStSStockAccount      (const Value: String);

    Protected
    Public
      constructor Create; override;

      Property UseSeedtoSale          : Boolean   read getUseSeedtoSale         Write SetUseSeedtoSale;
      Property StSUsesBins     : Boolean   read getStSUsesBins    Write SetStSUsesBins;
      Property StSSimpleMode   : Boolean   read getStSSimpleMode  Write SetStSSimpleMode;
      Property StSPackageTagProduct   : String    read getStSPackageTagProduct  write SetStSPackageTagProduct;
      Property StSPlantTagProduct     : String    read getStSPlantTagProduct    write SetStSPlantTagProduct;
      Property StSDefaultClass        : String    read getStSDefaultClass       write SetStSDefaultClass;
      Property StSDefaultWeightUOM    : String    read getStSDefaultWeightUOM   write SetStSDefaultWeightUOM;
      Property StSSupplier            : String    read getStSSupplier           write SetStSSupplier     ;
      Property StSSupplierID          : Integer   read getStSSupplierID       ;
      Property StSDefaultClassID      : Integer   read getStSDefaultClassID   ;
      Property StSStockAccount        : String    read getStSStockAccount       write SetStSStockAccount     ;

      procedure Save(connection: TMyConnection); Override;
    Published

  end;

implementation

uses BusobjProduct, BusObjClient, BusObjStSCommon, BusobjUOM , busobjclass,
  BusObjGLAccount, StSConst;

{ TStSConfig }

constructor TStSConfig.Create;
begin
  inherited;
end;
procedure TStSConfig.Save(connection: TMyConnection);
begin
  inherited;
  if StSPackageTagProduct <> '' then TProductSimple.ChecknMakeProduct(StSPackageTagProduct, connection,False,False, true,StSSupplier , 'StS^Tag' );
  if StSPlantTagProduct   <> '' then TProductSimple.ChecknMakeProduct(StSPlantTagProduct  , connection,False,False, true,StSSupplier , 'StS^Tag');
  if StSSupplier          <> '' then TSupplier.MakeSupplier(nil, StSSupplier, true);
  TSupplier.MakeSupplier(nil, STS_BioTrackTHC_Supplier, true);
  TSupplier.MakeSupplier(nil, STS_METRC_Supplier, true);
  if StSStockAccount      <> '' then TAccount.MakeAccount(nil, StSStockAccount, '', 'EXP', true);
  if StSDefaultWeightUOM  <> '' then TUnitOfMeasure.CreateNewUOM(nil, 0,  StSDefaultWeightUOM );
end;

Function TStSConfig.GetUseSeedtoSale        : Boolean;begin result := B['UseSeedtoSale']         ;end;
Function TStSConfig.GetStSUsesBins   : Boolean;begin result := B['StSUsesBins']    ;end;
Function TStSConfig.GetStSSimpleMode : Boolean;begin result := B['StSSimpleMode']  ;end;
function TStSConfig.getStSPackageTagProduct : String ;begin result := S['StSPackageTagProduct']  ;end;
function TStSConfig.getStSPlantTagProduct   : String ;begin result := S['StSPlantTagProduct']    ;end;
function TStSConfig.getStSDefaultClass      : String ;begin result := S['StSDefaultClass']       ;end;
function TStSConfig.getStSDefaultWeightUOM  : String ;begin result := S['StSDefaultWeightUOM']   ;end;
function TStSConfig.getStSSupplier          : String ;begin result := S['StSSupplier']           ;end;
function TStSConfig.getStSSupplierID        : Integer;begin result := TClient.IDtoggle(S['StSSupplier']); end;
function TStSConfig.getStSDefaultClassID    : Integer;begin result := TDeptClass.IDtoggle(S['StSDefaultClass']); end;
function TStSConfig.getStSStockAccount      : String ;begin result := S['StSStockAccount']           ;end;
Procedure TStSConfig.SetUseSeedtoSale         (Const Value: Boolean); begin B['UseSeedtoSale']        := Value ; end;
Procedure TStSConfig.SetStSUsesBins    (Const Value: Boolean); begin B['StSUsesBins']   := Value ; end;
Procedure TStSConfig.SetStSSimpleMode  (Const Value: Boolean); begin B['StSSimpleMode'] := Value ; end;
procedure TStSConfig.SetStSPackageTagProduct  (const Value: String);  begin S['StSPackageTagProduct'] := Value ; end;
procedure TStSConfig.SetStSPlantTagProduct    (const Value: String);  begin S['StSPlantTagProduct']   := Value ; end;
procedure TStSConfig.SetStSDefaultClass       (const Value: String);  begin S['StSDefaultClass']      := Value ; end;
procedure TStSConfig.SetStSSupplier           (const Value: String);  begin S['StSSupplier']          := Value ; end;
procedure TStSConfig.SetStSStockAccount       (const Value: String);  begin S['StSStockAccount']      := Value ; end;
procedure TStSConfig.SetStSDefaultWeightUOM   (const Value: String);
begin
  S['StSDefaultWeightUOM']  := Value ;
end;

end.
