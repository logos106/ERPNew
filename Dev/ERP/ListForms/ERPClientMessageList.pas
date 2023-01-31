unit ERPClientMessageList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TERPClientMessageListGUI = class(TBaseListingGUI)
    qryMainId: TIntegerField;
    qryMainName: TWideStringField;
    qryMainERPClientName: TWideStringField;
    qryMainEntityRef: TWideStringField;
    qryMainDirection: TWideStringField;
    qryMainMessageType: TWideStringField;
    qryMainMessageId: TWideStringField;
    qryMainMessageFrom: TWideStringField;
    qryMainMessageTo: TWideStringField;
    qryMainMessageDate: TDateTimeField;
    qryMainCurrencyCost: TFloatField;
    qryMainCurrencyPrice: TFloatField;
    qryMainCurrencyCode: TWideStringField;
    qryMainPrice: TFloatField;
    qryMainERPSaleID: TIntegerField;
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure RefreshQuery; override;
    Procedure RefreshTotals; override;
  public
  end;

var
  ERPClientMessageListGUI: TERPClientMessageListGUI;

implementation

{$R *.dfm}

uses
  DateUtils;

{ TERPClientMessageListGUI }

procedure TERPClientMessageListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalcColumn(qryMainCurrencyCost.FieldName,False);
  AddCalcColumn(qryMainCurrencyPrice.FieldName,False);
  AddCalcColumn(qryMainPrice.FieldName,true);
end;

procedure TERPClientMessageListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('DateTo').AsDate := IncYear(Now(), 1000);
    qryMain.Params.ParamByName('DateFrom').AsDate := 0;
  end else begin
    qryMain.Params.ParamByName('DateFrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('DateTo').AsDate := dtTo.DateTime;
  end;
  inherited;
end;

procedure TERPClientMessageListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

initialization
  RegisterClass(TERPClientMessageListGUI);

end.
