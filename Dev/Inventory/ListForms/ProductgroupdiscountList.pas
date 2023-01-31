unit ProductgroupdiscountList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TProductgroupdiscountListGUI = class(TBaseListingGUI)
    qryMainCompany: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainGrpDiscID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainCol1: TWideStringField;
    qryMainCol2: TWideStringField;
    qryMainCol3: TWideStringField;
    qryMainDiscount: TFloatField;
  private
  Protected
    Procedure SetGridColumns;Override;
  public
  end;
implementation

uses CommonLib;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TProductgroupdiscountListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('GrpDiscID');
  RemoveFieldfromGrid('clientID');
  RemoveFieldfromGrid('globalref');
end;

initialization
  RegisterClassOnce(TProductgroupdiscountListGUI);
end.

