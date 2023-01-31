unit RollaBlindItemPrice;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindInput, DB, MemDS, DBAccess, MyAccess, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  DNMSpeedButton, ExtCtrls,
  DNMPanel, StdCtrls, Mask, wwdbedit, wwdblook;

type
  TRollaBlindItemPriceGUI = class(TBaseRollaBlindInputGUI)
    qryPriceGroups: TMyQuery;
    Label1: TLabel;
    edtItemNumber: TwwDBEdit;
    Label2: TLabel;
    cboGroupHeading: TwwDBLookupCombo;
    Label3: TLabel;
    edtCutoutDescription: TwwDBEdit;
    Label4: TLabel;
    edtPriceListDescription: TwwDBEdit;
    Label5: TLabel;
    edtLength: TwwDBEdit;
    Label6: TLabel;
    cboColourCode: TwwDBLookupCombo;
    qryColourCodes: TMyQuery;
    Label7: TLabel;
    edtUnit: TwwDBEdit;
    edtList: TwwDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtKanga: TwwDBEdit;
    Label10: TLabel;
    edtGroup: TwwDBEdit;
    Label11: TLabel;
    edtExport: TwwDBEdit;
    Label12: TLabel;
    edtBranch: TwwDBEdit;
    Label13: TLabel;
    edtCost: TwwDBEdit;
    qryMainItemPriceID: TIntegerField;
    qryMainGlobalRef: TStringField;
    qryMainItemNumber: TStringField;
    qryMainColourCode: TStringField;
    qryMainHeading: TStringField;
    qryMainDescription: TStringField;
    qryMainDescription2: TStringField;
    qryMainLength: TStringField;
    qryMainColour: TStringField;
    qryMainUnit: TStringField;
    qryMainList: TFloatField;
    qryMainKanga: TFloatField;
    qryMainGroup: TFloatField;
    qryMainExport: TFloatField;
    qryMainBranch: TFloatField;
    qryMainCost: TFloatField;
    qryMainSheetID: TIntegerField;
    qryMainFlag: TStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryPriceGroupsHeading: TStringField;
    qryColourCodesColourCode: TStringField;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  FormFactory, CommonLib;

procedure TRollaBlindItemPriceGUI.FormShow(Sender: TObject);
begin
  OpenQueries;

  if KeyID = 0 then
    qryMain.Insert
  else
    qryMain.Locate('ItemPriceID', KeyID, [loCaseInsensitive]);

  inherited;
end;

initialization
  RegisterClassOnce(TRollaBlindItemPriceGUI);

  with FormFact do
  begin
    RegisterMe(TRollaBlindItemPriceGUI, 'TRollaBlindItemPriceListGUI_*=ItemPriceID');
  end;                                      
finalization
  UnRegisterClass(TRollaBlindItemPriceGUI);
end.
