unit ProductSumQtyList;

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
  TProductSumQtyListGUI = class(TBaseListingGUI)
    qryMainpartname: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainInStock: TFloatField;
    qryMainAvailable: TFloatField;
    qryMainAllocatedSO: TFloatField;
    qryMainPOBO: TFloatField;
    qryMainSOBO: TFloatField;
    qryMainInvBO: TFloatField;
    qryMainOnBuild: TFloatField;
    qryMainBuilding: TFloatField;
    qryMainOnTransit: TFloatField;
    qryMainason: TDateTimeField;
    btnSnch: TDNMSpeedButton;
    QryProgress: TERPQuery;
    QryProgressProgressmsg: TWideStringField;
    QryProgressID: TIntegerField;
    QryProgressProgresscode: TIntegerField;
    qryMainProductId: TIntegerField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnSnchClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    procedure DoSynch(aProductID: Integer);
    procedure SetDispLabels;
  Protected
    procedure SetGridColumns; Override;
    procedure AfterPopup(Popupform:TComponent);Override;
  public
  end;


implementation

uses CommonDbLib, tcConst, CommonLib, SyncReportTableObj, frmPartsFrm, ComCtrls,
  AppEnvironment, GuiPrefsObj;

{$R *.dfm}
procedure TProductSumQtyListGUI.DoSynch(aProductID:Integer);
begin
  ExecuteSQLwithProgress(SyncReportObj.DoUpdateProductQtySum_SQL(iif(aProductID=0 , '' , inttostr(aProductID))));
  RefreshQuery;
end;
procedure TProductSumQtyListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection:=false;
  ShowcontrolHint(grdmain, 'Double Click on Any of the Quantity field to Re-Calculate the Quantity');
end;

procedure TProductSumQtyListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if popupform is TfrmParts then
    With TfrmParts(popupform) do begin
      pageControl.ActivePage := TTabSheet(Quantities);
    end;
end;

procedure TProductSumQtyListGUI.btnSnchClick(Sender: TObject);
begin
  inherited;
  DoSynch(0);
end;

procedure TProductSumQtyListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  HideZeroValueInNumberfield(State,Field,AFont,ABrush);
end;

procedure TProductSumQtyListGUI.grdMainDblClick(Sender: TObject);
begin
  if sametext(Activefieldname,qryMainInStock.fieldname) Or
     sametext(Activefieldname,qryMainAvailable.fieldname) Or
     sametext(Activefieldname,qryMainAllocatedSO.fieldname) Or
     sametext(Activefieldname,qryMainPOBO.fieldname) Or
     sametext(Activefieldname,qryMainSOBO.fieldname) Or
     sametext(Activefieldname,qryMainInvBO.fieldname) Or
     sametext(Activefieldname,qryMainOnBuild.fieldname) Or
     sametext(Activefieldname,qryMainBuilding.fieldname) Or
     sametext(Activefieldname,qryMainOnTransit.fieldname) then begin
    DoSynch(qrymainproductid.asInteger);
    Exit;
  end;
  inherited;
end;

procedure TProductSumQtyListGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.Itemindex =0 then
    groupfilterstring := '(' + qrymainInStock.fieldname     +' <> 0 ) Or ' +
                         '(' + qrymainAvailable.fieldname   +' <> 0 ) Or ' +
                         '(' + qrymainAllocatedSO.fieldname +' <> 0 ) Or ' +
                         '(' + qrymainPOBO.fieldname        +' <> 0 ) Or ' +
                         '(' + qrymainSOBO.fieldname        +' <> 0 ) Or ' +
                         '(' + qrymainInvBO.fieldname       +' <> 0 ) Or ' +
                         '(' + qrymainOnBuild.fieldname     +' <> 0 ) Or ' +
                         '(' + qrymainBuilding.fieldname    +' <> 0 ) Or ' +
                         '(' + qrymainOnTransit.fieldname+' <> 0 ) '
  else groupfilterstring :='';
  inherited;
end;

procedure TProductSumQtyListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  SetDispLabels;
end;

procedure TProductSumQtyListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainproductid.fieldname);
end;
procedure TProductSumQtyListGUI.SetDispLabels;
var
  s:String;
begin
  s:= 'Quantity Read As ' +quotedstr(AppEnv.DefaultClass.DefaultUOM) + ' - (SO BO ';
  if AppEnv.CompanyPrefs.CountSOBOInAvailable  then s := s + 'Included In Available)'
  else s := s + 'not Counted in Available)';

      With TwwDbGridGuiElement(GuiPrefs.DbGridElement[grdMain]) do begin
        FieldGroupname[qrymainInStock.fieldname     ] := s;
        FieldGroupname[qrymainAvailable.fieldname   ] := s;
        FieldGroupname[qrymainAllocatedSO.fieldname ] := s;
        FieldGroupname[qrymainPOBO.fieldname        ] := s;
        FieldGroupname[qrymainSOBO.fieldname        ] := s;
        FieldGroupname[qrymainInvBO.fieldname       ] := s;
        FieldGroupname[qrymainOnBuild.fieldname     ] := s;
        FieldGroupname[qrymainBuilding.fieldname    ] := s;
        FieldGroupname[qrymainOnTransit.fieldname   ] := s;
      end;
end;

initialization
  RegisterClassOnce(TProductSumQtyListGUI);
end.
