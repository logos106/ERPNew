unit AddinPackageInfoObj;

interface

uses
  classes, forms, BaseGuiDataModule;

type
  TPackageType = (ptStatic, ptDynamic, ptDynamicDLL);

{$M+}
  TAddinPackageInfo = class(TObject)
  private
    FPreference: boolean;
    fGuiDataModule: TdtmGUI;
    fPrefClassname : string;
    function GetGuiDataModule: TdtmGUI;
    procedure setPrefClassname(const Value: string);

  public
    PackageName: string;
    Handle: HMODULE;
    PackageType: TPackageType;
    Version: integer;
    PrefPage: TFormClass;
    GuiDataModuleClass: TdtmGUIClass;
    constructor Create;
    destructor Destroy; override;
    function VersionStr: string;
    function GetPrefPanel: TFormClass;
    property GuiDataModule: TdtmGUI read GetGuiDataModule;
    property PrefClassname: string read fPrefClassname write setPrefClassname;
  published
    property HasPreference: boolean read Fpreference write FPreference;
  end;
{$M-}

var
  AddinInfo: TAddinPackageInfo;

implementation

uses
  SysUtils, windows;

{ TAddinPackageInfo }

constructor TAddinPackageInfo.Create;
begin
  inherited;
  PackageType := ptStatic;
  Version := 0;
end;

function TAddinPackageInfo.VersionStr: string;
begin
  Result := FormatFloat('000"-"00"-"00', Version);
end;

  {extra package info required}
function TAddinPackageInfo.GetPrefPanel: TFormClass;
begin
  Result := TFormClass(FindClass(PrefClassname));
end;

procedure TAddinPackageInfo.setPrefClassname(const Value: string);
begin
  fPrefClassname := Value;
end;

destructor TAddinPackageInfo.Destroy;
begin
  if PackageType = ptDynamic then
    UnloadPackage(Handle)
  else if PackageType = ptDynamicDLL then
    FreeLibrary(Handle);
  fGuiDataModule.Free;
  inherited;
end;

function TAddinPackageInfo.GetGuiDataModule: TdtmGUI;
begin
  if (not Assigned(fGuiDataModule)) and Assigned(GuiDataModuleClass) then
    fGuiDataModule:= GuiDataModuleClass.Create(nil);
  result:= fGuiDataModule;
end;

end.
