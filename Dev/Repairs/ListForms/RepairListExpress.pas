unit RepairListExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpress, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TRepairListExpressGUI = class(TBaseListExpressGUI)
    qryMainRepairID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainRepairDocNo: TWideStringField;
    qryMainCreationDate: TDateField;
    qryMainDone: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainCustomerPONumber: TWideStringField;
    qryMainJobDueDate: TDateTimeField;
    qryMainCompletionTime: TWideStringField;
    qryMainUseBillCust: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fiCustomerId: Integer;
    { Private declarations }
  Protected
    Function ExpressDetailListName:String;Override;
  public
    Property CustomerId:Integer read fiCustomerId write fiCustomerId;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib, dateutils;

{$R *.dfm}

{ TRepairListExpressGUI }

procedure TRepairListExpressGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TRepairsGUI' , 0);
end;

function TRepairListExpressGUI.ExpressDetailListName: String;
begin
  REsult := 'TRepairsList';
end;
procedure TRepairListExpressGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiCustomerId:=0;
end;

procedure TRepairListExpressGUI.RefreshQuery;
var
  ToDate, FromDate: TDateTime;
begin
  Qrymain.Parambyname('CustomerId').asInteger :=fiCustomerId;
  if chkIgnoreDates.Checked then begin
    ToDate   := IncYear(Now(), 1000);
    FromDate := 0;
  end else begin
    ToDate   := FilterdateTo;
    FromDate := FilterDateFrom;
  end;
  qryMain.Params.ParamByName('dtfrom').asDateTime := FromDate;
  qryMain.Params.ParamByName('dtto').asDateTime := ToDate;
  inherited;
end;

initialization
  RegisterClassOnce(TRepairListExpressGUI);
end.

