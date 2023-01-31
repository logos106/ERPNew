unit ShippingContainerListDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, kbmMemTable,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TShippingContainerListDetailsGUI = class(TBaseListingGUI)
    qryMainContainerName: TWideStringField;
    qryMainShippingContainerStatus: TWideStringField;
    qryMainDeparturePoint: TWideStringField;
    qryMainArrivalPoint: TWideStringField;
    qryMainVesselName: TWideStringField;
    qryMainETA: TDateField;
    qryMainETDeparture: TDateField;
    qryMainContainerNotes: TWideMemoField;
    qryMainShippingContainerID: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainCustomerJob: TWideStringField;
    qryMainCustomerJobID: TIntegerField;
    btnSummary: TDNMSpeedButton;
    qryMainContainerNumber: TWideStringField;
    qryMainContainerSize: TWideStringField;
    qryMainActive: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure btnSummaryClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure RefreshQuery;override;
  end;

implementation

uses CommonFormLib,commonLib;

{$R *.dfm}

procedure TShippingContainerListDetailsGUI.grpFiltersClick(Sender: TObject);
begin
  case grpFilters.ItemIndex of
    0: GroupFilterString := 'ETA <> null and Active = ' + QuotedStr('T');
    1: GroupFilterString := 'ETA <> null and Active = ' + QuotedStr('F');
    2: GroupFilterString := 'ETA = null';
    3: GroupFilterString := '';
  end;
  inherited;
end;

procedure TShippingContainerListDetailsGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDateTime := FilterDateFrom;
  qryMain.Params.ParamByName('txtto').AsDateTime := filterDateTo;
  inherited;
end;
procedure TShippingContainerListDetailsGUI.btnSummaryClick(
  Sender: TObject);
begin
  inherited;
  OpenERPListForm('TfrmShippingContainerList');
  Self.Close;

end;

initialization
  RegisterClassOnce(TShippingContainerListDetailsGUI);

end.
