unit SalesDispatchBatches;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup;

type
  TSalesDispatchBatchesGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryMainsaleDate: TDateField;
    qryMainproductname: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainBatchno: TWideStringField;
    qryMainBatchQty: TFloatField;
    qryMainTotalDispatched: TFloatField;
    qryMainTobedispatched: TFloatField;
    qryMainDetails: TLargeintField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fsWhere:String;
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, saleslib, CommonFormLib, JSONObject;

{$R *.dfm}

{ TSalesDispatchBatchesGUI }

procedure TSalesDispatchBatchesGUI.DNMSpeedButton1Click(Sender: TObject);
var
    sSQL:String;
    Json: TJsonObject;
begin
  inherited;
  iterateprocNo:= 1;
  fsWhere := '';
  IterateselectedRecords(TRue);
  if fsWhere = '' then begin
    MessageDlgXP_vista('Please select the batches to be printed', mtWarning, [mbOK], 0);
    Exit;
  end;
    //sSQL:= '~|||~ Where ' +  fsWhere +' order by productname , SaleLineID';
    sSQL:= SalesDispatchBarcodeSQL('' , '' , '' , fsWhere);
    ReportSQLSupplied :=  True;
    Json:= JO;
    try
        Json.O['0'].S['master']:= 'Details';
        Json.O['0'].S['detail']:= 'RelatedParts';
        Json.O['0'].S['masterfields']:='PQADetailID';
        Json.O['0'].S['detailfields']:= 'slpqad.PQADetailID';
        PrintTemplateReport(TemplateToPrint('Sales Dispatch Barcode', chkChooseRpt.checked , 'Sales Dispatch Barcode')  ,ssql,  PrintReport(chkPreview) , 1,Json );
    finally
      Json.Free;
    end;

end;

procedure TSalesDispatchBatchesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  BaseIndexFieldNames := QuotedStr('saleID') + ' DESC CIS;'+
                          QuotedStr('SaleLineId') + ' DESC CIS';
end;

procedure TSalesDispatchBatchesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymaindetails.AsInteger =1 then begin
    if sametext(field.FieldName , QrymainSaleID.FieldName) or
       sametext(field.FieldName , Qrymainproductname.FieldName) or
       sametext(field.FieldName , QrymainUnitofMeasureQtySold.FieldName) or
       sametext(field.FieldName , QrymainUnitofMeasureShipped.FieldName) or
       sametext(field.FieldName , QrymainUnitofMeasureBackorder.FieldName) or
       sametext(field.FieldName , QrymainUOM.FieldName) or
       sametext(field.FieldName , QrymainsaleDate.FieldName) then
    else Afont.Color := Abrush.Color;
  end else begin
    if sametext(field.FieldName , QrymainSaleID.FieldName) or
       sametext(field.FieldName , Qrymainproductname.FieldName) or
       sametext(field.FieldName , QrymainUnitofMeasureQtySold.FieldName) or
       sametext(field.FieldName , QrymainUnitofMeasureShipped.FieldName) or
       sametext(field.FieldName , QrymainUnitofMeasureBackorder.FieldName) or
       sametext(field.FieldName , QrymainUOM.FieldName) or
       sametext(field.FieldName , QrymainsaleDate.FieldName) then
      Afont.Color := Abrush.Color;
  end;
end;

procedure TSalesDispatchBatchesGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if iterateprocno = 1 then begin
      if fsWhere <> '' then fsWhere := fsWhere + ' or ';
      fsWhere := fsWhere + '( SL.saleLineId  =' + inttostr(QrymainSaleLineId.asInteger)+' and PQABatch.Value =' +quotedstr(Qrymainbatchno.AsString)+')';
  end;
end;

procedure TSalesDispatchBatchesGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure TSalesDispatchBatchesGUI.SetGridColumns;
begin
  inherited;
   RemoveFieldfromGrid(QrymainsaleLineID.fieldname);
   RemoveFieldfromGrid(QrymainDetails.fieldname);
end;

initialization
  RegisterClassOnce(TSalesDispatchBatchesGUI);

end.
