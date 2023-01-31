unit SmartOrderRFQs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TSmartOrderRFQsGUI = class(TBaseListingGUI)
    qryMainsupplier: TWideStringField;
    qryMainDateEmailedOn: TDateTimeField;
    qryMainsmartOrderId: TIntegerField;
    qryMainSmartOrderDesc: TWideStringField;
    qryMainSOdate: TDateField;
    qryMainArea: TWideStringField;
  private
    fiSmartOrderID:Integer;
  public
    Property SmartOrderID:Integer read fiSmartOrderID write fiSmartOrderID;
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TBaseListingGUI3 }


procedure TSmartOrderRFQsGUI.RefreshQuery;
begin
  chkIgnoreDates.visible :=  fiSmartOrderID =0;
  cboDateRange.visible :=  fiSmartOrderID =0;
  lblFrom.visible :=  fiSmartOrderID =0;
  dtFrom.visible :=  fiSmartOrderID =0;
  lblTo.visible :=  fiSmartOrderID =0;
  dtTo.visible :=  fiSmartOrderID =0;

  Qrymain.ParamByName('SmartOrderID').AsInteger := SmartOrderID;
  Qrymain.ParamByName('DateFrom').AsDateTime    := FilterDateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime      := FilterDateTo;
  inherited;
end;

initialization
  RegisterClassOnce(TSmartOrderRFQsGUI);

end.

