unit LaybyListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, kbmMemTable,
   wwdblook, Shader, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TLaybyListGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainTotalAmountInc: TFloatField;
    qryMainBalance: TFloatField;
    qryMainCompany: TWideStringField;
    qryMainEmpName: TWideStringField;
    qryMainInvoiceDocNumber: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure CmdBackordersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

//var
//  LaybyListGUI: TLaybyListGUI;

implementation

{$R *.dfm}

uses
  BackOrderSOForm, CommonLib, MySQLConst;

procedure TLaybyListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Deleted <> ' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Deleted = ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TLaybyListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('dtFrom').AsString := FormatDateTime(MysqlDateFormat, dtfrom.DateTime);
  qryMain.Params.ParamByName('dtTo').AsString := FormatDateTime(MysqlDateFormat, dtto.DateTime);
  inherited;
end;

procedure TLaybyListGUI.CmdBackordersClick(Sender: TObject);
var
  BackOrderSO: TBackOrderSOGUI;
begin
  inherited;
  BackOrderSO := TBackOrderSOGUI(GetComponentByClassName('TBackOrderSOGUI'));
  if Assigned(BackOrderSO) then begin
    BackOrderSO.FormStyle := fsMDIChild;
    BackOrderSO.BringToFront;
  end;
end;

procedure TLaybyListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  LaybyListGUI := nil;
end;

procedure TLaybyListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if self.fbFormOpenedOk then begin
    grpFiltersClick(Sender);
  end;
end;
initialization
 RegisterClassOnce(TLaybyListGUI);

end.
