unit AppointmentListReport;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Dialogs, BaseListingForm, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList,
  Menus, AdvMenus, PrintDAT, ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, 
  wwdblook, Shader, kbmMemTable;

type
  TAppointmentListReportGUI = class(TBaseListingGUI)
    Label72: TLabel;
    qryMainDate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMainRep: TWideStringField;
    qryMainSource: TWideStringField;
    qryMainHourlyRate: TFloatField;
    qryMainCalloutFee: TFloatField;
    qryMainTotalInc: TFloatField;
    qryMainTotalCost: TFloatField;
    qryMainNett: TFloatField;
    qryMainAppointID: TAutoIncField;
    qryMainHours: TFloatField;
    qryMainConverted: TWideStringField;
    qryMainService: TWideStringField;
    procedure cmdNewClick(Sender: TObject);

  private
    { Private declarations }

  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;

  public
    { Public declarations }
  end;

implementation

uses Forms, SysUtils, frmAppointments, CommonLib, tcConst;

{$R *.dfm}

procedure TAppointmentListReportGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').asDateTime := dtfrom.DateTime;
  qryMain.Params.ParamByName('txtto').asDateTime := dtto.DateTime;
  inherited;
  RefreshTotals;
end;

procedure TAppointmentListReportGUI.RefreshTotals;
var
  dHours: TDateTime;
  dTotalInc, dTotalCost, dNett: double;
begin
  dHours := 0;
  dTotalInc := 0;
  dTotalCost := 0;
  dNett := 0;
  qryMain.DisableControls;  
  with qryMain do begin
    First;
    while not Eof do begin
      dHours := dHours + FieldByName('Hours').AsFloat;
      dTotalInc := dTotalInc + FieldByName('TotalInc').AsFloat;
      dTotalCost := dTotalCost + FieldByName('TotalCost').AsFloat;
      dNett := dNett + FieldByName('Nett').AsFloat;
      Next;
    end;
    First;
  end;
  qryMain.EnableControls;
  grdMain.ColumnByName('Hours').FooterValue := FloatToStrF(dHours, ffFixed, 15, 2);
  //copy(TimeToStr(dHours), 1, char_length(TimeToStr(dHours))-6);
  grdMain.ColumnByName('TotalInc').FooterValue := FloatToStrF(dTotalInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('TotalCost').FooterValue := FloatToStrF(dTotalCost, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Nett').FooterValue := FloatToStrF(dNett, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TAppointmentListReportGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TAppointmentGUI');
  if Assigned(Form) then begin
    with TAppointmentGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  
  //  MainForm.NewAppointmentClick(Sender);
end;

initialization
  RegisterClassOnce(TAppointmentListReportGUI);
end.
