unit ForeignExchangeHistoryListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, DNMPanel,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TForeignExchangeHistoryListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainCurrencyHistoryID: TIntegerField;
    qryMainCurrencyID: TIntegerField;
    qryMainCountry: TWideStringField;
    qryMainCode: TWideStringField;
    qryMainDate: TDateField;
    qryMainBuyRate: TFloatField;
    qryMainSellRate: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;    
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TForeignExchangeHistoryListGUI }

procedure TForeignExchangeHistoryListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
    qryMain.Params.ParamByName('txtto').AsDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  end;
  inherited;
end;

procedure TForeignExchangeHistoryListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

initialization
  RegisterClassOnce(TForeignExchangeHistoryListGUI);
end.
