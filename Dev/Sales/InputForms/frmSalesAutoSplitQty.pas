unit frmSalesAutoSplitQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusobjSalesQtySplit, busobjsalebase, Grids, Wwdbigrd, Wwdbgrid, Mask, wwdbedit, Buttons;

type
  TfmSalesAutoSplitQty = class(TBaseInputGUI)
    qrySalesautoSplitQty: TERPQuery;
    dsSalesautoSplitQty: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qrySalesautoSplitQtylines: TERPQuery;
    dsSalesautoSplitQtylines: TDataSource;
    qrySalesautoSplitQtyID: TIntegerField;
    qrySalesautoSplitQtyGlobalRef: TWideStringField;
    qrySalesautoSplitQtyProductID: TIntegerField;
    qrySalesautoSplitQtyProductname: TWideStringField;
    qrySalesautoSplitQtyUOMID: TIntegerField;
    qrySalesautoSplitQtyUOMMultiplier: TFloatField;
    qrySalesautoSplitQtyUOM: TWideStringField;
    qrySalesautoSplitQtyQty: TFloatField;
    qrySalesautoSplitQtymstimeStamp: TDateTimeField;
    qrySalesautoSplitQtymsUpdatesiteCode: TWideStringField;
    qrySalesautoSplitQtylinesID: TIntegerField;
    qrySalesautoSplitQtylinesGlobalRef: TWideStringField;
    qrySalesautoSplitQtylinesHeaderID: TIntegerField;
    qrySalesautoSplitQtylinesUOMID: TIntegerField;
    qrySalesautoSplitQtylinesUOMMultiplier: TFloatField;
    qrySalesautoSplitQtylinesUOM: TWideStringField;
    qrySalesautoSplitQtylinesQty: TFloatField;
    qrySalesautoSplitQtylinesmstimeStamp: TDateTimeField;
    qrySalesautoSplitQtylinesmsUpdatesiteCode: TWideStringField;
    qrySalesautoSplitQtyUOMwithmult: TWideStringField;
    grdLines: TwwDBGrid;
    grdHeader: TwwDBGrid;
    qrySalesautoSplitQtylinesUOMWithMult: TWideStringField;
    qrySalesautoSplitQtytotalAllocated: TFloatField;
    qrySalesautoSplitQtytotalUnAllocated: TFloatField;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnAutoAllocate: TDNMSpeedButton;
    qrySalesautoSplitQtylinessingleQty: TFloatField;
    grdHeaderIButton: TwwIButton;
    qrySalesautoSplitQtysaleRef: TWideStringField;
    qrySalesautoSplitQtySaleLineRef: TWideStringField;
    qrySalesautoSplitQtylinesSaleLineRef: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qrySalesautoSplitQtyCalcFields(DataSet: TDataSet);
    procedure qrySalesautoSplitQtylinesCalcFields(DataSet: TDataSet);
    procedure grdHeaderEnter(Sender: TObject);
    procedure btnAutoAllocateClick(Sender: TObject);
    procedure grdLinesCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdLinesEnter(Sender: TObject);
    procedure grdLinesColEnter(Sender: TObject);
  private
    SalesAutoSplitQtyObj: TSalesAutoSplitQty;
    fSalesLineobj : TSalesLineBase;
    function SaveRecord: Boolean;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property SalesLineobj : TSalesLineBase Read fSalesLineobj Write fSalesLineobj;
  end;


implementation

uses CommonLib, BusObjConst, tcDataUtils;

{$R *.dfm}

procedure TfmSalesAutoSplitQty.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then modalresult := mrcancel else Self.Close;
end;

Function TfmSalesAutoSplitQty.SaveRecord :Boolean;
begin
  result:= False;
  SalesAutoSplitQtyObj.Lines.PostDb;
  SalesAutoSplitQtyObj.PostDB;
  if not(SalesAutoSplitQtyObj.Save) then exit;
(*  if SalesAutoSplitQtyObj.TotalUnAllocated <> 0 then begin
    if SalesAutoSplitQtyObj.TotalUnAllocated  >0 then begin
      if MessageDlg('You haven''t allocated all the quantity. Do you want to continue updating sales with this Quantity?', mtConfirmation, [mbYes, mbNo], 0) = mrno then result := False;
    end else if MessageDlg('You have over allocated it. Do you want to continue updating sales with this Quantity?', mtConfirmation, [mbYes, mbNo], 0) = mrno then result := False;
    end else result := true;
    Exit;
  end;*)
  Result:= True;
end;

procedure TfmSalesAutoSplitQty.grdHeaderEnter(Sender: TObject);
begin
  inherited;
  SetcontrolFocus(grdLines);
end;

procedure TfmSalesAutoSplitQty.grdLinesCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not sameText(Field.FieldName , qrySalesautoSplitQtylinesQty.fieldname) then AFont.Color := clGray;
end;

procedure TfmSalesAutoSplitQty.grdLinesColEnter(Sender: TObject);
begin
  inherited;
  if not sameText(TField(grdLines.GetActiveField).FieldName, qrySalesautoSplitQtylinesQty.fieldname) then
    grdLines.SetActiveField(qrySalesautoSplitQtylinesQty.fieldname);
end;

procedure TfmSalesAutoSplitQty.grdLinesEnter(Sender: TObject);
begin
  inherited;
  grdLines.SetActiveField(qrySalesautoSplitQtylinesQty.fieldname);
end;

procedure TfmSalesAutoSplitQty.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  SalesAutoSplitQtyObj.Connection.CommitNestedTransaction;
  SalesAutoSplitQtyObj.Dirty := False;
  if fsModal in FormState then modalresult := mrok else Self.Close;
end;

procedure TfmSalesAutoSplitQty.btnAutoAllocateClick(Sender: TObject);
begin
  inherited;
  SalesAutoSplitQtyObj.AutoSplitQty;
end;

procedure TfmSalesAutoSplitQty.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited ;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSalesAutoSplitQty then TSalesAutoSplitQty(Sender).Dataset  := qrySalesautoSplitQty
        else if Sender is TSalesAutoSplitQtylines then TSalesAutoSplitQtylines(Sender).Dataset  := qrySalesautoSplitQtylines;
     end;
end;

procedure TfmSalesAutoSplitQty.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if SalesAutoSplitQtyObj.Dirty then begin
    if CommonLib.MessageDlgXP_Vista('Do You Wish To cancel These Changes You Have Made?', mtConfirmation, [mbYes, mbNo], 0) = mrno then begin
      Canclose := False;
    end else begin
          SalesAutoSplitQtyObj.Connection.RollbackNestedTransaction;
          SalesAutoSplitQtyObj.Dirty := false;
          CanClose := true;
    end;
  end;


  // If user does not have access to this form don't process any further
  (*if ErrorOccurred then Exit;

  CanClose := false;
  if SalesAutoSplitQtyObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          SalesAutoSplitQtyObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;*)

end;

procedure TfmSalesAutoSplitQty.FormCreate(Sender: TObject);
begin
  inherited;
  SalesAutoSplitQtyObj := TSalesAutoSplitQty.CreateWithNewConn(Self);
  SalesAutoSplitQtyObj.Connection.connection := Self.MyConnection;
  SalesAutoSplitQtyObj.BusObjEvent := DoBusinessObjectEvent;
end;
procedure TfmSalesAutoSplitQty.FormShow(Sender: TObject);
begin
  inherited;
  SetTransconenctiontoQueries;
  if TransConnection <> nil then SalesAutoSplitQtyObj.Connection.Connection := TransConnection;

  SalesAutoSplitQtyObj.LoadSelect('SaleLineref = ' + quotedstr(SalesLineobj.globalref));
  SalesAutoSplitQtyObj.connection.BeginNestedTransaction;
  if SalesAutoSplitQtyObj.count=0 then begin
    SalesAutoSplitQtyObj.new;
    SalesAutoSplitQtyObj.SaleRef        := GetSaleGlobalRef(SalesLineobj.SaleID);
    SalesAutoSplitQtyObj.salelineref    := SalesLineobj.Globalref;
  end;
    SalesAutoSplitQtyObj.ProductId      := SalesLineobj.ProductId;
    SalesAutoSplitQtyObj.Productname    := SalesLineobj.ProductName;
    SalesAutoSplitQtyObj.UOMID          := SalesLineobj.UnitOfMeasureID;
    SalesAutoSplitQtyObj.UOM            := SalesLineobj.UnitOfMeasure;
    SalesAutoSplitQtyObj.UOMMultiplier  := SalesLineobj.UOMMultiplier;
    SalesAutoSplitQtyObj.Qty            := SalesLineobj.UOMQtySold;
    SalesAutoSplitQtyObj.PostDB;
    SalesAutoSplitQtyObj.AutoSplitQty;

  openQueries;
end;

procedure TfmSalesAutoSplitQty.qrySalesautoSplitQtyCalcFields(DataSet: TDataSet);
begin
  inherited;
  qrySalesautoSplitQtyUOMwithmult.AsString := qrySalesautoSplitQtyUOM.AsString;
  if qrySalesautoSplitQtyUOMMultiplier.AsFloat >0 then
    qrySalesautoSplitQtyUOMwithmult.AsString :=  qrySalesautoSplitQtyUOMwithmult.AsString +'(' + floattoStr(qrySalesautoSplitQtyUOMMultiplier.AsFloat)+')';
end;

procedure TfmSalesAutoSplitQty.qrySalesautoSplitQtylinesCalcFields(DataSet: TDataSet);
begin
  inherited;
  qrySalesautoSplitQtylinesUOMwithmult.AsString := qrySalesautoSplitQtylinesUOM.AsString;
  if qrySalesautoSplitQtylinesUOMMultiplier.AsFloat >0 then
    qrySalesautoSplitQtylinesUOMwithmult.AsString :=  qrySalesautoSplitQtylinesUOMwithmult.AsString +'(' + floattoStr(qrySalesautoSplitQtylinesUOMMultiplier.AsFloat)+')';
  qrySalesautoSplitQtylinessingleQty.asFloat := qrySalesautoSplitQtylinesQty.AsFloat * qrySalesautoSplitQtylinesUOMMultiplier.AsFloat;
end;

initialization
  RegisterClassOnce(TfmSalesAutoSplitQty);

end.

