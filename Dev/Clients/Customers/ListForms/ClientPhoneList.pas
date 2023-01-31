unit ClientPhoneList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TClientPhoneListGUI = class(TBaseListingGUI)
    qryMainseqno: TLargeintField;
    qryMainCompany: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainDescription: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    fiCustomerId: Integer;
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;override;
    Property CustomerId :Integer read fiCustomerId write fiCustomerId;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TClientPhoneListGUI }

procedure TClientPhoneListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiCustomerId :=0;
end;

procedure TClientPhoneListGUI.RefreshQuery;
begin
  Qrymain.Parambyname('CustomerId').asInteger := fiCustomerId;
  inherited;
end;

procedure TClientPhoneListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Seqno');
end;

initialization
  RegisterClassOnce(TClientPhoneListGUI);

end.

