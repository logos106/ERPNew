unit AuditTrailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, wwriched, wwcheckbox,
  wwDataInspector, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker,
  ProgressDialog,  wwdblook, Shader, kbmMemTable, DAScript,
  MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TAuditTrailListGUI = class(TBaseListingGUI)
    qryMainAuditID: TAutoIncField;
    qryMainTransType: TWideStringField;
    qryMainAuditDate: TDateTimeField;
    qryMainEmployeeName: TWideStringField;
    qryMainChangesDetails: TWideStringField;
    qryAuditDetails: TERPQuery;
    qryAuditDetailsAuditID: TAutoIncField;
    qryAuditDetailsChangedFields: TWideMemoField;
    DSAuditDetails: TDataSource;
    qryMainDataDescription: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainTransGlobalRef: TWideStringField;
    procedure grdMainDblClick(Sender: TObject); override;
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib,DateUtils, MemoDialog;

{$R *.dfm}

procedure TAuditTrailListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').asDateTime := FilterDateFrom;
  qryMain.Params.ParamByName('txtto').asDateTime := Filterdateto;
  inherited;
end;

procedure TAuditTrailListGUI.grdMainDblClick(Sender: TObject);
begin
  qryAuditDetails.Close;
  qryAuditDetails.ParamByName('xAuditID').AsInteger := qryMain.FieldByName('AuditID').AsInteger;
  qryAuditDetails.Open;
  TfrmMemoDialog.Memopopup(qryAuditDetailsChangedfields.asString, 'Change Details');
end;

initialization
  RegisterClassOnce(TAuditTrailListGUI);
end.
