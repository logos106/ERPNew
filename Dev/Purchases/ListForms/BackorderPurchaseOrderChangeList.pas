unit BackorderPurchaseOrderChangeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, BaseListExpress;

type
  TBackorderPurchaseOrderChangeListGUI = class(TBaseListingGUI)
    qryMainSupplierName: TWideStringField;
    qryMainPrintName: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainBackOrder: TFloatField;
    qryMainUnitofMeasurePOLines: TWideStringField;
    qryMainPurchaseLineID: TIntegerField;
    qryMainOrderDate: TDateField;
    qryMainEmployeeName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainComments: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainLineCost: TFloatField;
    qryMainLineCostAmount: TFloatField;
    qryMainETADate: TDateField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainClass: TWideStringField;
    qryMainPOApproved: TWideStringField;
    qryMainConNote: TWideStringField;
    qryMainOrderStatus: TWideStringField;
    qryMainSmartOrderId: TIntegerField;
    qryMainFuturePo: TWideStringField;
    qryMainSmartOrderApprovedBy: TWideStringField;
    qryMainLeadDays: TLargeintField;
    qryMainOrderLineCustomField1: TWideStringField;
    qryMainOrderLineCustomField2: TWideStringField;
    qryMainOrderLineCustomField3: TWideStringField;
    qryMainOrderLineCustomField4: TWideStringField;
    qryMainOrderLineCustomField5: TWideStringField;
    qryMainOrderLineCustomField6: TWideStringField;
    qryMainOrderLineCustomField7: TWideStringField;
    qryMainOrderLineCustomField8: TWideStringField;
    qryMainOrderLineCustomField9: TWideStringField;
    qryMainOrderLineCustomField10: TWideStringField;
    qryMainMemoLine: TWideMemoField;
    qryMainChangeCreateDate: TDateTimeField;
    qryMainChangeActive: TWideStringField;
    qryMainChangeApproved: TWideStringField;
    qryMainChangeApprover: TWideStringField;
    qryMainChangeID: TLargeintField;
    procedure grdMainDblClick(Sender: TObject);
  private
    procedure POChangeBeforeShow(Sender: TObject);
  protected
    procedure ApplyQueryFilter; override;
  public
    Procedure RefreshQuery; override;
  end;

implementation

uses
  CommonFormLib, frmPurchaseOrderChange;

{$R *.dfm}



{ TBackorderPurchaseOrderApprovalExpressGUI }

procedure TBackorderPurchaseOrderChangeListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Approved}
        GroupFilterString := '(ChangeApproved = "T"';
      end;
    1:
      begin {Not Approved}
        GroupFilterString := '(ChangeApproved = "F")';
      end;
    2:
      begin {All}
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TBackorderPurchaseOrderChangeListGUI.grdMainDblClick(
  Sender: TObject);
begin
//  inherited;
// function OpenERPForm(const FormClassname: string; KeyID: Integer; Aftershow: TNotifyEvent = nil;Beforeshow: TNotifyEvent = nil; BringTofrontIfAlreadyShown: boolean = False; SingleInstance: boolean = true; IsReadOnly: boolean = false): Boolean;
  OpenERPForm('TfmPurchaseOrderChange',qryMainChangeID.AsInteger, nil, POChangeBeforeShow);
end;

procedure TBackorderPurchaseOrderChangeListGUI.POChangeBeforeShow(
  Sender: TObject);
begin
  TfmPurchaseOrderChange(Sender).PurchaseOrderID := qryMainPurchaseOrderID.AsInteger;
end;

procedure TBackorderPurchaseOrderChangeListGUI.RefreshQuery;
begin
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('txtFrom').AsDateTime := 0;
    qryMain.ParamByName('txtTo').AsDateTime := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('txtFrom').AsDateTime := dtFrom.Date;
    qryMain.ParamByName('txtTo').AsDateTime := dtTo.Date;
  end;
  inherited;
end;

initialization
  RegisterClass(TBackorderPurchaseOrderChangeListGUI);

end.
