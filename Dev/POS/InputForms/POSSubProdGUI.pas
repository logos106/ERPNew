unit POSSubProdGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, wwdblook, DBAccess, MyAccess, DataState,
  Menus, AdvMenus, MemDS, Shader;

type
  TPOSSubProdPopUp = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryUnitOfMeasure: TMyQuery;
    qryUnitOfMeasureUnitName: TStringField;
    qryUnitOfMeasureUnitDescription: TStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    cboUnitofMeasure: TwwDBLookupCombo;
    Label1: TLabel;
    Bevel1: TBevel;
    qryUnitOfMeasureBaseUnitName: TStringField;
    qryUnitOfMeasureUnitID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fiProductID :integer;
  public
    { Public declarations }
    property ProductID: integer read fiProductID write fiProductID;
  end;

implementation

uses DNMLib, CommonLib;

{$R *.dfm}

{ TPOSSubProdPopUp }

procedure TPOSSubProdPopUp.FormShow(Sender: TObject);
begin
  inherited;
  qryUnitOfMeasure.ParamByName('xPartID').asInteger := fiProductID;
  OpenQueries;
end;

initialization
  RegisterClassOnce(TPOSSubProdPopUp);

end.
