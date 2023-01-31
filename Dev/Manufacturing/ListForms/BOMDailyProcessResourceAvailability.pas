unit BOMDailyProcessResourceAvailability;

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
  TBOMDailyProcessResourceAvailabilityGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainProcresourcedetailID: TIntegerField;
    qryMainProductId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainSeqno: TIntegerField;
    qryMainNoOfResources: TIntegerField;
    qryMainActive: TWideStringField;
    qryMainResourceDate: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fiProductID: Integer;
    fiseqno :Integer;
    procedure SetProductID(const Value: Integer);
  Protected
    procedure SetGridColumns; Override;
  public
    Property ProductID :Integer read fiProductID write SetProductID;
    Procedure RefreshQuery;override;
  end;

implementation

uses CommonDbLib, CommonLib, BusobjProduct, DbSharedObjectsObj;

{$R *.dfm}

procedure TBOMDailyProcessResourceAvailabilityGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiProductID := 0;
  HaveDateRangeSelection := False;
end;


procedure TBOMDailyProcessResourceAvailabilityGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (qrymainseqno.asInteger < fiseqno)  then
    RedFont(AFont);
end;

procedure TBOMDailyProcessResourceAvailabilityGUI.qryMainBeforeOpen(DataSet: TDataSet);
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.SQL.text := 'SELECT Min(PRP.Seqno) as Seqno '+
                    ' FROM tblprocresourceproducts PRT  '+
                    ' INNER JOIN tblprocresourcedetails PRD ON  PRT.ProductId = '+ inttostr(ProductID)+' AND  PRD.ID = PRT.ProcresourcedetailID  '+
                    ' INNER JOIN tblprocresourceproducts PRP ON PRD.ID = PRP.ProcresourcedetailID   '+
                    ' WHERE IFNULL(prp.noofresources,0)>0';
    Qry.open;
    fiseqno := Qry.fieldbyname('Seqno').asInteger;
    if fiseqno > 1 then ListTimerMsg('Resources in RED colour is not Available Until Cleanup');

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  inherited;

end;

procedure TBOMDailyProcessResourceAvailabilityGUI.RefreshQuery;
begin
  Qrymain.parambyname('ProductID').asInteger :=ProductId;
  inherited;
end;

procedure TBOMDailyProcessResourceAvailabilityGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.Fieldname);
  RemoveFieldfromGrid(qryMainGlobalRef.Fieldname);
  RemoveFieldfromGrid(qryMainProcresourcedetailID.Fieldname);
  RemoveFieldfromGrid(qryMainProductId.Fieldname);
end;

procedure TBOMDailyProcessResourceAvailabilityGUI.SetProductID(const Value: Integer);
begin
  fiProductID := Value;
  Caption :='Daily Process Resource Availability for '  + Quotedstr(TProductsimple.IDToggle(value));
  TitleLabel.Caption := TProductsimple.IDToggle(value);
end;
initialization
  RegisterClassOnce(TBOMDailyProcessResourceAvailabilityGUI);

end.
