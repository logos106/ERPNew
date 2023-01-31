unit dmGUIStylers;

interface

uses
  SysUtils, Classes, AdvMenus, AdvMenuStylers, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers;

type
  TdatGUIStylers = class(TDataModule)
    MainMenuStyler: TAdvMenuFantasyStyler;
    AdvOfficeStatusBarStyler: TAdvOfficeStatusBarOfficeStyler;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  datGUIStylers: TdatGUIStylers;

implementation

Uses Forms;

{$R *.dfm}

initialization
  datGUIStylers := TdatGUIStylers.Create(Application);
end.
