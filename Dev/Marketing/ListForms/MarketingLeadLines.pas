unit MarketingLeadLines;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  CustomInputBox, wwcheckbox;

type
  TMarketingLeadLinesGUI = class(TBaseListingGUI)
    qryMainEmployeeName: TWideStringField;
    qryMainname: TWideStringField;
    qryMainFollowUpDate: TDateTimeField;
    qryMainNotes: TWideMemoField;
  private
    fiMarketingcontactID: Integer;
    procedure setMarketingcontactID(const Value: Integer);
  Protected
    Procedure RefreshQuery;Override;
  public
    Property MarketingcontactID :Integer read fiMarketingcontactID write setMarketingcontactID;

  end;

implementation

uses tcDataUtils, CommonLib;

{$R *.dfm}

{ TMarketingLeadLinesGUI }

procedure TMarketingLeadLinesGUI.RefreshQuery;
begin
  Qrymain.ParamByName('McID').asinteger := MarketingcontactID;
  inherited;
end;

procedure TMarketingLeadLinesGUI.setMarketingcontactID(const Value: Integer);
begin
  fiMarketingcontactID := Value;
  TitleLabel.Caption :=   getMarketingcontactName(Value);
end;
initialization
  RegisterClassOnce(TMarketingLeadLinesGUI);
end.

