unit Productionjobstatusdetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductionjobstatusdetailsList = class(TBaseListingGUI)
    qryMainsAleId: TIntegerField;
    qryMainSaleLineID: TIntegerField;
    qryMainProcTreeId: TIntegerField;
    qryMainSAleDate: TDateField;
    qryMainID: TIntegerField;
    qryMainCaption: TWideStringField;
    qryMainStatus: TWideMemoField;
    qryMainResource: TWideStringField;
    qryMainProcesstep: TWideStringField;
    qryMainProcessduration: TTimeField;
    qryMaintimeStart: TDateTimeField;
    qryMainTimeto: TDateTimeField;
    qryMainScheduledDuration: TFloatField;
    qryMaincustomerName: TWideStringField;
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, StoredProcedures;

{$R *.dfm}
{ TProductionjobstatusdetailsList }

procedure TProductionjobstatusdetailsList.FormCreate(Sender: TObject);
begin
  inherited;
  CreateSP('ProcessPartStatusToUserStr');
end;

procedure TProductionjobstatusdetailsList.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QrymainTimeStart.DisplayFormat:= FormatSettings.ShortDateformat;
  QrymainTimeTo.DisplayFormat:= FormatSettings.ShortDateformat;
end;

procedure TProductionjobstatusdetailsList.RefreshQuery;
begin
  qryMain.Params.ParamByName('DAteFrom').asDateTime := FilterDatefrom;
  qryMain.Params.ParamByName('Dateto').AsDateTime   := FilterDateTo;
  inherited;
end;

procedure TProductionjobstatusdetailsList.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainSaleLineID.FieldName);
  RemoveFieldfromGrid(qryMainProcTreeId.FieldName);
  RemoveFieldfromGrid(qryMainID.FieldName);
end;

initialization
  RegisterClassOnce(TProductionjobstatusdetailsList);

end.

