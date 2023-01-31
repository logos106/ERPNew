unit BOMSalesList_Details;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOMSalesList_Base, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel;

type
  TBOMSalesList_DetailsGUI = class(TBOMSalesList_BaseGUI)
    qryMainisRoot: TWideStringField;
    qryMainhasChildren: TWideStringField;
  private
  Protected
    function GrpfiltersItemidex :Integer ; Override;
    Procedure CalcFooter; Override;
    procedure SetGridColumns; Override;
  public
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TBOMSalesList_DetailsGUI }

procedure TBOMSalesList_DetailsGUI.CalcFooter;
begin
  if qryMainhasChildren.asBoolean then exit;  // calculate totals from the last nodes only
  inherited;

end;

function TBOMSalesList_DetailsGUI.GrpfiltersItemidex: Integer;
begin
  Result := 3;
end;

procedure TBOMSalesList_DetailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainisRoot.fieldname);
  RemoveFieldfromGrid(qryMainhasChildren.fieldname);
end;

initialization
  RegisterClassOnce(TBOMSalesList_DetailsGUI);

end.

