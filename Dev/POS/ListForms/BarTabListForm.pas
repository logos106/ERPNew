unit BarTabListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, wwDialog, Wwlocate, SelectionDialog,
  ActnList, PrintDAT, ImgList, Menus, AdvMenus,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, wwcheckbox;

type
  TBarTabListGUI = class(TBaseListingGUI)
    qryMainClientID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainAmount: TFloatField;
    qryMainSaleDate: TDateField;
    qryMainTimeOfSale: TWideStringField;
    qryMainTillName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainClass: TWideStringField;
    qryMainBarTabEntrys: TLargeintField;
    qryMainDetails: TLargeintField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;    
  public
    { Public declarations }
  end;

implementation

uses CommonLib, MySQLConst;

{$R *.dfm}

procedure TBarTabListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin {Summary}
        GroupFilterString := 'Details = 0';
      end;
  end;
  inherited;
end;

procedure TBarTabListGUI.RefreshQuery;
begin
  inherited;
  qryMain.Params.ParamByName('txtfrom').AsString := FormatDateTime(MysqlDateFormat, dtfrom.DateTime);
  qryMain.Params.ParamByName('txtto').AsString := FormatDateTime(MysqlDateFormat, dtto.DateTime);
  qryMain.Params.ParamByName('txtfrom1').AsString := FormatDateTime(MysqlDateFormat, dtfrom.DateTime);
  qryMain.Params.ParamByName('txtto1').AsString := FormatDateTime(MysqlDateFormat, dtto.DateTime);
  inherited;
end;

procedure TBarTabListGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TBarTabListGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFiltersClick(Sender);
end;

procedure TBarTabListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if (qryMainDetails.AsInteger = 0) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

initialization
  RegisterClassOnce(TBarTabListGUI);
end.
