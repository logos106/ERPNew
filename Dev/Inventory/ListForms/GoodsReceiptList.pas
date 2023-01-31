unit GoodsReceiptList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TGoodsReceiptListGUI = class(TBaseListingGUI)
    qryMainReceiptID: TIntegerField;
    qryMainReceiptGlobalRef: TWideStringField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainReceiptStartTime: TDateTimeField;
    qryMainReceiptEndTime: TDateTimeField;
    qryMainActive: TWideStringField;
    qryMainProcessed: TWideStringField;
    qryMainClientPrintName: TWideStringField;
    qryMainPurchaseOrderNumber: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    procedure cmdNewClick(Sender: TObject);
  private
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
  public
    { Public declarations }
  end;

implementation

uses
  CommonFormLib;

{$R *.dfm}

{ TGoodsReceiptListGUI }

procedure TGoodsReceiptListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Active}
        GroupFilterString := '(Active = "T")';
      end;
    1:
      begin { Not Active }
        GroupFilterString := '(Active = "F")';
      end;
    2:
      begin { all }
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TGoodsReceiptListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmGoodsReceipt', 0);

end;

procedure TGoodsReceiptListGUI.RefreshQuery;
begin
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDateTime := 0;
    qryMain.ParamByName('DateTo').AsDateTime := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDateTime := dtFrom.Date;;
    qryMain.ParamByName('DateTo').AsDateTime := dtTo.Date;
  end;

  inherited;

end;

initialization
  RegisterClass(TGoodsReceiptListGUI);

end.
