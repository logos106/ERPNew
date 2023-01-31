unit frmPriceSchemeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, DAScript,
  MyScript;

type
  TfmPriceSchemeList = class(TBaseListingGUI)
    qrySchemes: TERPQuery;
    qryMainPriceSchemeID: TIntegerField;
    qryMainSchemeNumber: TWideStringField;
    qryMainSchemeName: TWideStringField;
    qryMainSchemeType: TIntegerField;
    qryMainPrice: TFloatField;
    qryMainDateFrom: TDateField;
    qryMainDateTo: TDateField;
    qryMainCredit: TFloatField;
    qryMainRelatedSchemeID: TIntegerField;
    qryMainDiscountOrQtyFree: TFloatField;
    qryMainActive: TWideStringField;
    qryMainRelatedSchemeName: TWideStringField;
    qryMainSchemeTypeName: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure cboDateRangeCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  fmPriceSchemeList: TfmPriceSchemeList;

implementation

{$R *.dfm}

uses
  CommonLib,BaseInputForm, BusObjPriceScheme, MySQLConst;


procedure TfmPriceSchemeList.cmdNewClick(Sender: TObject);
var
  EditForm : TBaseInputGUI;
begin
  inherited;
  EditForm := TBaseInputGUI(GetComponentByClassName('TfmPriceSchemeEdit'));
  if Assigned(EditForm) then begin
    with EditForm do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TfmPriceSchemeList.RefreshQuery;
begin
  qryMain.Close;
  case grpFilters.ItemIndex of
    0: qryMain.ParamByName('Active').AsString:= 'T';
    1: qryMain.ParamByName('Active').AsString:= 'F';
    2: qryMain.ParamByName('Active').AsString:= '';
  end;
  if dtFrom.Date > 0 then
    qryMain.ParamByName('DateFromIn').AsString:= FormatDateTime(MysqlDateFormat,dtFrom.Date)
  else
    qryMain.ParamByName('DateFromIn').AsString:= '';
  if dtTo.Date > 0 then
    qryMain.ParamByName('DateToIn').AsString:= FormatDateTime(MysqlDateFormat,dtTo.Date)
  else
    qryMain.ParamByName('DateToIn').AsString:= '';
  inherited;
  grdMain.RemoveField('msTimeStamp');
  grdMain.RemoveField('GlobalRef');
  grdMain.RemoveField('PriceSchemeID');
  grdMain.RemoveField('SchemeType');
  grdMain.RemoveField('RelatedSchemeID');
end;

procedure TfmPriceSchemeList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmPriceSchemeList.FormCreate(Sender: TObject);
begin
  inherited;
  cboDateRange.Items.Add('All');
end;

procedure TfmPriceSchemeList.cboDateRangeCloseUp(Sender: TObject);
begin
  if cboDateRange.Text = 'All' then begin
    dtFrom.Clear;
    dtTo.Clear;
    dtToChange(nil);
  end
  else
    inherited;
end;

procedure TfmPriceSchemeList.FormShow(Sender: TObject);
begin
  inherited;
  grdMain.RemoveField('msTimeStamp');
  grdMain.RemoveField('GlobalRef');
  grdMain.RemoveField('PriceSchemeID');
  grdMain.RemoveField('SchemeType');
  grdMain.RemoveField('RelatedSchemeID');
end;

procedure TfmPriceSchemeList.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainSchemeTypeName.AsString:=
    PriceSchemeTypeName[TPriceSchemeType(qryMainSchemeType.AsInteger)];
end;

initialization
  RegisterClassOnce(TfmPriceSchemeList);

end.
