unit StSHarvestList;

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
  TStSHarvestListGUI = class(TBaseListingGUI)
    qryMainHarvestID: TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainharvestname: TWideStringField;
    qryMainHarvestDate: TDateTimeField;
    qryMainStrainName: TWideStringField;
    qryMainWeightUOM: TWideStringField;
    qryMainTotalQty: TFloatField;
    qryMainPackedQty: TFloatField;
    qryMainHarvestDone: TWideStringField;
    qryMainBin: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure Refreshquery;Override;
  end;

implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}

{ TStSHarvestListGUI }

procedure TStSHarvestListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmStSHarvest' , 0);
end;

procedure TStSHarvestListGUI.Refreshquery;
begin
  InitDateFromnDateto;
  inherited;
end;
procedure TStSHarvestListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainHarvestID.fieldname);

end;

initialization
  RegisterClassOnce(TStSHarvestListGUI);

end.
