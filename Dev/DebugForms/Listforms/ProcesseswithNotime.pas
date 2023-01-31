unit ProcesseswithNotime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TProcesseswithNotimeGUI = class(TBaseListingGUI)
    qryMainmasterId: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainType: TWideStringField;
    qryMainpartname: TWideStringField;
    qryMaincaption: TWideStringField;
    qryMainSaleCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainSaleLineProductName: TWideStringField;
    qryMainProcessDesc: TWideStringField;
    qryMainProductID: TIntegerField;
    procedure grdMainDblClick(Sender: TObject);override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TProcesseswithNotimeGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + trim(qryMaintype.AsString);
  inherited;
end;
initialization
  RegisterClassOnce(TProcesseswithNotimeGUI);

end.

