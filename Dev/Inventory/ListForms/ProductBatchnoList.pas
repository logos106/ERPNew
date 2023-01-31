unit ProductBatchnoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, CustomInputBox, wwcheckbox;

type
  TProductBatchnoListGUI = class(TBaseListingGUI)
    qryMainBatchno: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    fiProductID: Integer;
    fiClassId: Integer;

  public
    Property ProductID :Integer read fiProductID write fiProductID;
    Property ClassId :Integer read fiClassId write fiClassId;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TProductBatchnoListGUI.FormCreate(Sender: TObject);
begin
  inherited;
    fiProductID:=0;
    fiClassId:=0;
end;

procedure TProductBatchnoListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('ProductID').AsInteger := ProductID;
  Qrymain.ParamByName('DepartmentId').AsInteger := ClassId;
  inherited;
end;
initialization
  RegisterClassOnce(TProductBatchnoListGUI);

end.

