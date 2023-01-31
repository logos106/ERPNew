unit EndOfPeriodPOS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TfrmEndOfPeriodPOS = class(TBaseListingGUI)
    qryMainPeriodID: TIntegerField;
    qryMainStartDate: TDateTimeField;
    qryMainEndDate: TDateTimeField;
    qryMainTillID: TIntegerField;
    qryMainTillName: TWideStringField;
    qryMaincStartdate: TDateTimeField;
    qryMaincEndDate: TDateTimeField;
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, DateUtils, POSLIB;

{$R *.dfm}
procedure TfrmEndOfPeriodPOS.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmEndOfPeriodPOS.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').asDateTime := Filterdatefrom;
  qryMain.Params.ParamByName('txtto').asDateTime := FilterDateto;
  inherited;

end;

procedure TfrmEndOfPeriodPOS.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainStartdate.fieldname);
  RemoveFieldfromGrid(qryMainEndDate.fieldname);
end;

procedure TfrmEndOfPeriodPOS.FormShow(Sender: TObject);
begin
  inherited;
  pnlHeader.Caption :=  'POS End Of Period Report';
end;

procedure TfrmEndOfPeriodPOS.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMaincStartdate.AsDateTime :=POSEOPStarttime(qryMainStartdate.AsDateTime);
  qryMaincEndDate.AsDateTime :=POSEOPEndtime(qryMainEndDate.AsDateTime);

end;

initialization
  RegisterClassOnce(TfrmEndOfPeriodPOS);;

end.
