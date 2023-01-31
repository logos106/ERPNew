unit frmAutoScheduleSelection;

interface

uses
  Windows, Types, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader , frmDateRangeSelection , frmBOMSchedulewhenReadytoScheduleOptions;

type
  TfmAutoScheduleSelection = class(TfmBOMSchedulewhenReadytoScheduleOptions)
    pnlDateRange: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    DateRangeSelectionform : TfmDateRangeSelection;
  public
    class Function ReadOptions(var fbOktoScheduleWhenSubBOMsDone:boolean;var fbOktoScheduleWhenGoodsReceived:boolean;var fbOktoScheduleWhenProcessesnotScheduled:boolean;var fbOktoScheduleWhenStockAvailable:boolean ):boolean; Override;
  end;

implementation


{$R *.dfm}

procedure TfmAutoScheduleSelection.FormCreate(Sender: TObject);
begin
  inherited;
  DateRangeSelectionform := DateRangeSelection(Self ,  pnlDateRange , point(5,5));
  DateRangeSelectionform.HasIgnoreDateRange := False;
  DateRangeSelectionform.HasCustomRangeOptions := False;
  DateRangeSelectionform.HasDateFrom :=True;
  DateRangeSelectionform.HasDateTo :=False;
end;

class Function TfmAutoScheduleSelection.ReadOptions(var fbOktoScheduleWhenSubBOMsDone:boolean;var fbOktoScheduleWhenGoodsReceived:boolean;var fbOktoScheduleWhenProcessesnotScheduled:boolean;var fbOktoScheduleWhenStockAvailable:boolean ):boolean;
var
  fb:Boolean;
  form : TfmAutoScheduleSelection;
begin
  fb:= false;
  form := TfmAutoScheduleSelection.Create(nil);
  try
      result := form.DoReadOptions(fbOktoScheduleWhenSubBOMsDone,fbOktoScheduleWhenGoodsReceived,fbOktoScheduleWhenProcessesnotScheduled,fbOktoScheduleWhenStockAvailable,Fb,False);
  finally
    FreeandNil(Form);
  end;
end;

end.
