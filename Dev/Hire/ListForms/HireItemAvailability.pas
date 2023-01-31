unit HireItemAvailability;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  THireItemAvailabilityGUI = class(TBaseListingGUI)
    qryMainDetails: TLargeintField;
    qryMainAssetId: TIntegerField;
    qryMainItemName: TWideStringField;
    qryMainHireID: TIntegerField;
    qryMainDurationQty: TFloatField;
    qryMainDurationName: TWideStringField;
    qryMainHireOut: TDateTimeField;
    qryMainHireIn: TDateTimeField;
    qryMainCustomerName: TWideStringField;
    qryMainAssetCode: TWideStringField;
    qryMainTotalQty: TLargeintField;
    qryMainOnHireQty: TLargeintField;
    qryMainAvailableQty: TLargeintField;
    btnPrev: TButton;
    btnNext: TButton;
    procedure dtToChange(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
  protected
    Procedure RefreshQuery; Override;
    procedure ApplyQueryFilter; override;
    procedure ReadnApplyGuiPrefExtra; override;
  public
    { Public declarations }
  end;

var
  HireItemAvailabilityGUI: THireItemAvailabilityGUI;

implementation

{$R *.dfm}

{ THireItemAvailabilityGUI }

procedure THireItemAvailabilityGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(Details = 0)';
      end;
    1:
      begin {Detail}
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure THireItemAvailabilityGUI.btnNextClick(Sender: TObject);
begin
  inherited;
  dtTo.Date := dtTo.Date +1;
end;

procedure THireItemAvailabilityGUI.btnPrevClick(Sender: TObject);
begin
  inherited;
  dtTo.Date := dtTo.Date -1;
end;

procedure THireItemAvailabilityGUI.dtToChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure THireItemAvailabilityGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainDetails.AsInteger = 0 then
    AFont.Style := AFont.Style + [fsBold];
end;

procedure THireItemAvailabilityGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  grpFilters.ItemIndex := 0;
end;

procedure THireItemAvailabilityGUI.RefreshQuery;
begin
  qryMAin.ParamByName('AsOn').AsDateTime := dtTo.Date + EncodeTime(12,0,0,0);
  inherited;

end;

initialization
  RegisterClass(THireItemAvailabilityGUI);

end.
