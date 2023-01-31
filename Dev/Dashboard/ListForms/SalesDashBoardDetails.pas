unit SalesDashBoardDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, wwcheckbox, CustomInputBox;

type
  TSalesDashBoardDetailsGUI = class(TBaseListingGUI)
  private
    fiEmployeeID: Integer;
    procedure seTDateTime(const Value: TDateTime);
    procedure setDAteto(const Value: TDateTime);
    procedure setEmployeeID(const Value: Integer);
    procedure setignoreDateRange(const Value: Boolean);
  Protected
    function saleIDs:String;
  public
    Property DateFrom :TDateTime Write seTDateTime;
    Property DateTo   :TDateTime Write setDAteto;
    Property EmployeeID :Integer read fiEmployeeID write setEmployeeID;
    Property ignoreDateRange : Boolean write setignoreDateRange;
  end;


implementation

uses salesAnalysisLib;

{$R *.dfm}

{ TSalesDashBoardDetailsGUI }

function TSalesDashBoardDetailsGUI.saleIDs: String;
begin
    result := EmployeeSales(filterdateFrom , filterDateTo, EmployeeID);
    if result = '' then result := '0';
end;

procedure TSalesDashBoardDetailsGUI.seTDateTime(const Value: TDateTime);
begin
  DtFrom.date := Value;
end;

procedure TSalesDashBoardDetailsGUI.setDAteto(const Value: TDateTime);
begin
  dtTo.date := Value;
end;

procedure TSalesDashBoardDetailsGUI.setEmployeeID(const Value: Integer);
begin
  fiEmployeeID := Value;
end;

procedure TSalesDashBoardDetailsGUI.setignoreDateRange(const Value: Boolean);
begin
  chkIgnoreDates.Checked := value;
end;

end.

