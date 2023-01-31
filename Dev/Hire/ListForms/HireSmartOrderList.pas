unit HireSmartOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  THireSmartOrderListGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainCreationDate: TDateTimeField;
    qryMainconverted: TWideStringField;
    qryMainType: TWideStringField;
    lblhireID: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
  private
    fsHireRef: String;
  public
    Property HireRef:String read fsHireRef write fsHireRef;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, BusobjHire;

{$R *.dfm}
{ THireSmartOrderListGUI }

procedure THireSmartOrderListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HireRef := '';
end;

procedure THireSmartOrderListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if HireRef <> '' then lblhireID.caption := 'Hire # ' + inttostr(THire.idToggle(HireRef));
end;

procedure THireSmartOrderListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainType.asString;
  inherited;
end;

procedure THireSmartOrderListGUI.RefreshQuery;
begin
  closeDB(Qrymain);
  Qrymain.ParamByName('HireGlobalref').AsString :=  HireRef;
  inherited;
end;

initialization
  RegisterClassOnce(THireSmartOrderListGUI);

end.
