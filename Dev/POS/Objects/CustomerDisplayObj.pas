unit CustomerDisplayObj;

interface

uses
  MyAccess,ERPdbComponents, DB;

type
  TCustomerDisplayObj = class(TObject)
  private
    fbEnableCustomerDisplay: boolean;
    fbEnablePPScreenSaver: boolean;
    fsPPPathFileName: string;
    fiPPTransitionEffect: integer;
    fiPPTransitionSpeed: integer;
    fiPPSlideCycle: integer;
    fiIdleWait: integer;
  public
    class procedure Instance;
    constructor Create;
    destructor Destroy; override;
    procedure PopulateMe(const TillID: integer);
    property EnableCustomerDisplay: boolean read fbEnableCustomerDisplay;
    property EnablePPScreenSaver: boolean read fbEnablePPScreenSaver;
    property PathFileName: string read fsPPPathFileName;
    property TransitionEffect: integer read fiPPTransitionEffect;
    property TransitionSpeed: integer read fiPPTransitionSpeed;
    property SlideCycle: integer read fiPPSlideCycle;
    property PPIdleWait: integer read fiIdleWait;
  end;

var
  CustomerDisplaySettings: TCustomerDisplayObj;

implementation

uses
  CommonDbLib, SysUtils, FastFuncs;

constructor TCustomerDisplayObj.Create;
begin
  Inherited;
  PopulateMe(0);
end;

destructor TCustomerDisplayObj.Destroy;
begin
  if not Assigned(CustomerDisplaySettings) then begin
    FreeAndNil(CustomerDisplaySettings);
  end;
  inherited;
end;

class procedure TCustomerDisplayObj.Instance;
begin
  if not Assigned(CustomerDisplaySettings) then begin
    CustomerDisplaySettings := TCustomerDisplayObj.Create;
  end;
end;

procedure TCustomerDisplayObj.PopulateMe(const TillID: integer);
var
  qry: TERPQuery;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    with qry do begin
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.ParamCheck := false;
      Sql.Add('Select TillID,EnableCustomerDisplay,EnablePPScreenSaver,PPPathFileName, ');
      Sql.Add('PPTransitionEffect,PPTransitionSpeed,PPSlideCycle,IdleWait ');
      Sql.Add('From tblpostills Where TillID = ' + IntToStr(TillID) + ';');
      Open;
    end;

    with qry do begin
      if not IsEmpty then begin
        fbEnableCustomerDisplay := FieldByName('EnableCustomerDisplay').AsBoolean;
        fbEnablePPScreenSaver := FieldByName('EnablePPScreenSaver').AsBoolean;
        fsPPPathFileName := FieldByName('PPPathFileName').AsString;
        fiPPTransitionEffect := FieldByName('PPTransitionEffect').AsInteger;
        fiPPTransitionSpeed := FieldByName('PPTransitionSpeed').AsInteger;
        fiPPSlideCycle := FieldByName('PPSlideCycle').AsInteger;
        fiIdleWait := FieldByName('IdleWait').AsInteger;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

initialization

finalization
  if CustomerDisplaySettings <> nil then begin
    FreeAndNil(CustomerDisplaySettings);
  end;
end.
