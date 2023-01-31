unit ApprovalList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, CustomInputBox;

type
  TApprovalListGUI = class(TBaseListingGUI)
    qryMainpurchaseOrderID: TIntegerField;
    qryMainTranstype: TWideStringField;
    qryMainApproved: TWideStringField;
    qryMainApprovalDAte: TDateTimeField;
    qryMainemployeeName: TWideStringField;
    qryMainApprovaltype: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainDblClick(Sender: TObject);override;
  private
    { Private declarations }
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TApprovalListGUI }

procedure TApprovalListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainTranstype.asString;
  inherited;
end;

procedure TApprovalListGUI.grpFiltersClick(Sender: TObject);
begin
  case grpFilters.ItemIndex of
    0:  GroupFilterString := 'Approved =' +quotedstr('T');
    1:  GroupFilterString := 'Approved =' +quotedstr('F');
    2:  GroupFilterString := '';
  end;
  inherited;

end;

procedure TApprovalListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('Datefrom').AsDateTime := FilterDateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime := FilterDateTo;
  inherited;
end;

initialization
  RegisterClassOnce(TApprovalListGUI);
end.

