unit datSpelling;

interface

uses
  SysUtils, Classes, ad3SpellBase, ad3Spell, ad4Live;

type
  TdmSpelling = class(TDataModule)
    AddictSpell: TAddictSpell;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function Spelling: TdmSpelling;

implementation

uses
  forms, ad3ConfigurationDialogCtrl;

var
  fSpelling: TdmSpelling;

{$R *.dfm}

function Spelling: TdmSpelling;
begin
  result := fSpelling;
end;

procedure TdmSpelling.DataModuleCreate(Sender: TObject);
begin
  AddictSpell.CommandsVisible := AddictSpell.CommandsVisible - [sdcConfigLearningLink, sdcConfigDownloadLink];
end;

initialization
  fSpelling := TdmSpelling.Create(Application);

end.
