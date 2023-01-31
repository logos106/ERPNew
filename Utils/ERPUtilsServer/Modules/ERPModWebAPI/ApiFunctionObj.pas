unit ApiFunctionObj;

interface

uses
  classes, JsonObject;

type
  TApiFunction = class(TPersistent)
  protected
  public
    constructor Create;
    destructor Destroy; override;
    class function Execute(const aInput: TJsonObject): string;
  end;

implementation

uses
  SysUtils, AppEnvironment, ERPDbComponents,
  BusObjSaleBase, utCloudconst;

{ TApiFunction }

constructor TApiFunction.Create;
begin
  inherited;

end;

destructor TApiFunction.Destroy;
begin

  inherited;
end;

{ this expects a JSON input structure and returns a json string }
class function TApiFunction.Execute(const aInput: TJsonObject): string;
var
  res: TJsonObject;

begin
  res := JO;
  try
    try
      res.I[TAG_ResponseNo]:= 200; { "OK" }
      if SameText(aInput.S['Function'],'Echo') then begin
        res.O['JsonOut'].AsString := aInput.AsString;
      end
      else if SameText(aInput.S['Function'],'GetSaleTypeName') then begin
        if aInput.O[TAG_CLOUD_Params].Exists('SaleID') then begin
          res.O['JsonOut'].S['Result'] := TSalesBase.GetSaleTypeClassName(aInput.O[TAG_CLOUD_Params].ItemByName['SaleID'].Value.AsInteger, AppEnv.AppDb.Connection);

        end
        else begin
          res.I[TAG_ResponseNo]:= 400; { "Bad Request" }
          res.S[TAG_ErrorMessage]:= 'Invalid Function Request - Param SaleID Missing';
        end;
      end
      else begin
        res.I[TAG_ResponseNo]:= 400; { "Bad Request" }
        res.S[TAG_ErrorMessage]:= 'Invalid Function Request - "' + aInput.S['Function'] + '"';
      end;
    except
      on e: exception do begin
        res.I[TAG_ResponseNo]:= 500; { "Sever Error" }
        res.S[TAG_ErrorMessage]:= 'Error - ' + e.Message;
      end;
    end;
  finally
    result := res.AsString;
    res.Free;
  end;

end;

initialization

  RegisterClass(TApiFunction);


end.
