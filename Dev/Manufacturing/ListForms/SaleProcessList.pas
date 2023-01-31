unit SaleProcessList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, Mask, wwdbedit, DAScript,
  MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSaleProcessListGUI = class(TBaseListingGUI)
    qryMainProcTreeId: TIntegerField;
    qryMainTreeRootId: TIntegerField;
    qryMainSaleId: TIntegerField;
    qryMainSaleDocNumber: TWideStringField;
    qryMainSaleCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainSaleShipDate: TDateField;
    qryMainSaleLineId: TIntegerField;
    qryMainSaleLineProductName: TWideStringField;
    qryMainSaleLineProductDescription: TWideStringField;
    qryMainSaleLineQuantity: TFloatField;
    qryMainSaleLineShipDate: TDateTimeField;
    qryMainProcTreeDescription: TWideStringField;
    qryMainProcTreeTotalQty: TFloatField;
    qryMainProcTreePartId: TIntegerField;
    qryMainProcTreeLevel: TIntegerField;
    qryMainProcTreeSequenceDown: TIntegerField;
    qryMainProcTreeComplete: TWideStringField;
    qryMainProcessDesc: TWideStringField;
    qryMainProcessPartId: TIntegerField;
    qryMainProcessTimeStart: TDateTimeField;
    qryMainProcessPartSetupDuration: TFloatField;
    qryMainProcessPartBreakdownDuration: TFloatField;
    qryMainProcessSequence: TIntegerField;
    qryMainProcessStepId: TIntegerField;
    qryMainProcessResourceId: TIntegerField;
    qryMainProcPickSlipId: TIntegerField;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    qryMainProcTreeCaption: tWideStringfield;
    qryMainProcessStatus: TWideMemoField;
    qryMainProcessPartDuration: TWideMemoField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    procedure SetSaleID(const Value: Integer);
  Protected
    Procedure SetGridColumns;Override;
  public
    Property SaleId :Integer write SetSaleID;
  end;


implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}

{ TSaleProcessListGUI }

procedure TSaleProcessListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
    if sameText(Field.fieldname , Qrymainprocesstimestart.fieldname) and (Qrymainprocesstimestart.asDateTime<1) then begin
      Afont.color := ABrush.color;
    end;
end;

procedure TSaleProcessListGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  CommonFormLib.OpenERPForm('TSalesOrderGUI',qryMainSaleId.AsInteger);
end;

procedure TSaleProcessListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainProcTreeId.Fieldname);
  RemoveFieldfromGrid(qryMainTreeRootId.Fieldname);
  RemoveFieldfromGrid(qryMainSaleId.Fieldname);
  RemoveFieldfromGrid(qryMainSaleShipDate.Fieldname);
  RemoveFieldfromGrid(qryMainSaleLineId.Fieldname);
  RemoveFieldfromGrid(qryMainProcTreePartId.Fieldname);
  RemoveFieldfromGrid(qryMainProcTreeLevel.Fieldname);
  RemoveFieldfromGrid(qryMainProcTreeSequenceDown.Fieldname);
  RemoveFieldfromGrid(qryMainProcessPartId.Fieldname);
  RemoveFieldfromGrid(qryMainProcessPartSetupDuration.Fieldname);
  RemoveFieldfromGrid(qryMainProcessPartBreakdownDuration.Fieldname);
  RemoveFieldfromGrid(qryMainProcessSequence.Fieldname);
  RemoveFieldfromGrid(qryMainProcessStepId.Fieldname);
  RemoveFieldfromGrid(qryMainProcessResourceId.Fieldname);
  RemoveFieldfromGrid(qryMainProcPickSlipId.Fieldname);
end;

procedure TSaleProcessListGUI.SetSaleID(const Value: Integer);
begin
  Qrymain.Parambyname('SaleID').asInteger := value;
end;

initialization
  RegisterClassOnce(TSaleProcessListGUI);
end.
