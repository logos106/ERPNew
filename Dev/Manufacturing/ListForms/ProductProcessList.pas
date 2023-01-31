unit ProductProcessList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TProductProcessListGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainMastertype: TWideStringField;
    qryMainCaption: TWideStringField;
    qryMainProcTreePart: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainProcessPart: TWideStringField;
    qryMainSeq: TIntegerField;
    qryMainIsTemplate: TWideStringField;
    qryMainduration: TFloatField;
    qryMainsetupDuration: TFloatField;
    qryMainbreakdownduration: TFloatField;
    qryMainfixedAmount: TFloatField;
    qryMaintimestart: TDateTimeField;
    qryMaintimeEnd: TDateTimeField;
    qryMainStatus: TWideStringField;
    qryMainPartId: TIntegerField;
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}
{ TProductProcessListGUI }

procedure TProductProcessListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('PartID');
  RemoveFieldfromGrid('Id');
end;

initialization
  RegisterClassOnce(TProductProcessListGUI);
end.
