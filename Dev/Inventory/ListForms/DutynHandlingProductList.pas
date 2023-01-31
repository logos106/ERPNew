unit DutynHandlingProductList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  DBCtrls, Mask, wwdbedit, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TDutynHandlingProductListGUI = class(TBaseListingGUI)
    qryMainIPID: TIntegerField;
    qryMainPartsID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainpartname: TWideStringField;
    qryMainSupplier: TWideStringField;
    qryMaincountry: TWideStringField;
    qryMainHandling: TFloatField;
    qryMainDuty: TFloatField;
    dsDutiesAccount: TDataSource;
    QryDutiesAccount: TERPQuery;
    dsBrokerHandlingAccount: TDataSource;
    qryBrokerHandlingAccount: TERPQuery;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    Label2: TLabel;
    Label4: TLabel;
    qryBrokerHandlingAccountAccountName: TWideStringField;
    QryDutiesAccountAccountName: TWideStringField;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
  Protected
    procedure SetGridColumns; Override;
    procedure AfterPopup(Popupform:TComponent);Override;
  public
  end;

implementation

uses CommonFormLib, frmPartsFrm, CommonLib, CommonDbLib;

{$R *.dfm}

{ TDutynHandlingProductListGUI }

procedure TDutynHandlingProductListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if popupform is TfrmParts then begin
    TfrmParts(Popupform).Pagecontrol.ActivePage := TfrmParts(popupform).Miscellaneous;
    TfrmParts(popupform).MiscPageControl.ActivePage := TfrmParts(popupform).TabIntrastat;
    Setcontrolfocus(TfrmParts(popupform).grdDuties);
    TfrmParts(popupform).qryimportProduct.locate('ID' , QrymainIPid.asInteger , []);
  end;
end;

procedure TDutynHandlingProductListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TDutynHandlingProductListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if sametext(field.fieldname , qrymainduty.fieldname) or
     sametext(field.fieldname , qrymainHandling.fieldname) then
      if Field.asfloat =0 then
        AFont.color := ABrush.color;
end;

procedure TDutynHandlingProductListGUI.grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  if sametext(AFieldName, qrymainduty.fieldname) or
     sametext(AFieldName, qrymainHandling.fieldname) then
      ATitleAlignment  := taRightJustify;
end;

procedure TDutynHandlingProductListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  opendb(qryBrokerHandlingAccount);
  opendb(QryDutiesAccount);
end;

procedure TDutynHandlingProductListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainIPID.Fieldname);
  RemoveFieldfromGrid(QrymainPartsID.Fieldname);
  RemoveFieldfromGrid(QrymainClientID.Fieldname);
end;

Initialization
  RegisterClassOnce(TDutynHandlingProductListGUI);

end.
