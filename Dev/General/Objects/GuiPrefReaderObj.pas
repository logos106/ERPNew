unit GuiPrefReaderObj;

interface

Uses Classes ,DataTreeReader;

type
  TFormGuiPrefReader = Class(TComponent)
    Private
      fPrefsName: string;
      fNode: TDataTreeReader;
      fiUserId:Integer;
      function GetNode: TDataTreeReader;
    protected
    Public
      constructor Create(aOwner: TComponent); override;
      property PrefsName: string read fPrefsName write fPrefsName;
      property Node: TDataTreeReader read GetNode; // write SetNode;
      Property UserId :Integer read fiUserId write fiUserId;
      function LoadPrefs: boolean;
  End;

implementation

uses
  AppEnvironmentVirtual;

const
  GUI_PREF_GROUP = 'GuiPrefs';

{ TFormGuiPrefReader }

constructor TFormGuiPrefReader.Create(aOwner: TComponent);
begin
  inherited;
  fPrefsName := '';
  fNode := nil;
end;

function TFormGuiPrefReader.GetNode: TDataTreeReader;
begin
  if not Assigned(fNode) then fNode := TDataTreeReader.Create;
  Result := fNode;
end;


function TFormGuiPrefReader.LoadPrefs: boolean;
begin
  Result := false;
  if PrefsName = '' then Exit;

  try
    Result := Node.Storer.Load(0, UserId, GUI_PREF_GROUP, PrefsName, {AppEnv.CompanyInfo.IndustryId} AppEnvVirt.Int['CompanyInfo.IndustryId']);
  except Result := false;
  end;
  if not(Result) and (UserID<>0) then
      try
        Result := Node.Storer.Load(0, 0, GUI_PREF_GROUP, PrefsName, {AppEnv.CompanyInfo.IndustryId} AppEnvVirt.Int['CompanyInfo.IndustryId']);
      except
        Result := false;
      end;
end;

end.

