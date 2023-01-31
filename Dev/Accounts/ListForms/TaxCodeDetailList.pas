unit TaxCodeDetailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TTaxCodeDetailListGUI = class(TBaseListingGUI)
    qryMainTaxCodeID: TIntegerField;
    qryMainNAME: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainCODE: TWideStringField;
    qryMainrate: TFloatField;
    qryMainRateDescription: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure RefreshQuery; Override;
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TTaxCodeDetailListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  KeyIdfieldname := QrymainTaxcodeID.Fieldname;
  KeyNamefieldname :=qryMainDescription.Fieldname;
  HaveDateRangeSelection := False;
end;

procedure TTaxCodeDetailListGUI.RefreshQuery;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TTaxCodeDetailListGUI);


end.
