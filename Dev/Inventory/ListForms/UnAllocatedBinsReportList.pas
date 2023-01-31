unit UnAllocatedBinsReportList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TUnAllocatedBinsReportGUI = class(TBaseListingGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainProductId: TIntegerField;
    qryMainProductname: TWideStringField;
    qryMaindepartmentId: TIntegerField;
    qryMainuomid: TIntegerField;
    qryMainuom: TWideStringField;
    qryMainDefaultbinId: TIntegerField;
    qryMainBatch: TWideStringField;
    qryMainmultipleBins: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUOMqty: TFloatField;
    qryMainBQty: TFloatField;
    qryMainBUOMQty: TFloatField;
    qryMainQtydiff: TFloatField;
    qryMainuomQtydiff: TFloatField;
    qryMainClassname: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
      SAOriginalno:String;
      AdjustQtyFilter :String;
      Tablename :String;


    procedure AddDataToTempTable;


    procedure AdjustQty;
    procedure AfterPartsFormshow(Sender: TObject);
    procedure beforeshowStockAdjustEntryList(Sender: TObject);

  protected
    procedure RefreshQuery; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer); override;
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib,CommonDbLib, ProductQtyLib, busobjPQA, frmPartsFrm,
  frmStockAdjustEntryFlat, tcDataUtils, CommonFormLib,
  BusobjStockAdjustEntry, StockAdjustEntryList, tcConst, AppEnvironment;

{$R *.dfm}

{ TUnAllocatedBinsReportGUI }


procedure TUnAllocatedBinsReportGUI.FormCreate(Sender: TObject);
begin
  Tablename := commondblib.GetUserTemporaryTableName('UnAllocatedBinsReport');
  Qrymain.SQL.Clear;
  Qrymain.SQL.Add('select ');
  Qrymain.SQL.Add('T.*  ,  ');
  Qrymain.SQL.Add('C.Classname  ');
  Qrymain.SQL.Add('from ' +tablename +' T ');
  Qrymain.SQL.Add('left join tblClass C on T.DepartmentId = C.ClassId ');
  Qrymain.SQL.Add('order by ProductName, classname;');
  inherited;

end;

procedure TUnAllocatedBinsReportGUI.AddDataToTempTable;
begin
    ExecuteSQL('Drop table if exists ' +  tablename +'; '+
                ' create table '+ tablename +' ' +  UnallocatedBinQty(''));
end;

procedure TUnAllocatedBinsReportGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  AdjustQty;
end;


procedure TUnAllocatedBinsReportGUI.RefreshQuery;
begin
  AddDataToTempTable;
  inherited;
end;

procedure TUnAllocatedBinsReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainProductId.FieldName);
  RemoveFieldfromGrid(qryMaindepartmentId.FieldName);
  RemoveFieldfromGrid(qryMainuomid.FieldName);
  RemoveFieldfromGrid(qryMainDefaultbinId.FieldName);
  RemoveFieldfromGrid(qryMainmultipleBins.FieldName);
  RemoveFieldfromGrid(qryMainQty.FieldName);
  RemoveFieldfromGrid(qryMainBQty.FieldName);
  RemoveFieldfromGrid(qryMainQtydiff.FieldName);
end;

procedure TUnAllocatedBinsReportGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(tablename);
  inherited;
end;

procedure TUnAllocatedBinsReportGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);
begin
    if AdjustQtyFilter <> '' then AdjustQtyFilter := AdjustQtyFilter +' OR ' ;
    AdjustQtyFilter := AdjustQtyFilter +'( PQA.ProductId = ' + inttostr(qrymainProductID.AsInteger) + ' and PQA.DepartmentId = ' + inttostr(qrymainDepartmentId.asInteger) +' and PQA.UOMID = ' + inttostr(QrymainUOMID.asInteger) +')';
end;
procedure TUnAllocatedBinsReportGUI.AdjustQty;
begin
     SAOriginalno := '';
     DisableForm;
     try
      if grdMain.SelectedList.Count <= 1 then begin
        if qrymain.FieldByName('ProductID').AsInteger > 0 then begin
          SAOriginalno := TStockAdjustEntry.AutoAdjustBin(inttostr(qrymainProductID.AsInteger), inttostr(qrymainDepartmentId.AsInteger));
        end;
      end else begin
         AdjustQtyFilter := '';
         IterateselectedRecords;
         if AdjustQtyFilter = '' then exit;
         SAOriginalno := TStockAdjustEntry.AutoAdjustBin('' , '' , AdjustQtyFilter);
      end;
      if SAOriginalno <> '' then begin
              MessageDlgXP_Vista( QrymainProductname.asString+  '''s unallocated Quantity in Department ' +
                                  QrymainClassname.asString + ' is allocated to the Default Bin.' +
                                      chr(13)+chr(13)+'The Original no of the Stock Adjustment: ' +SAOriginalno +
                                      chr(13) +Chr(13) +'Please make sure the stock adjustment is processed.', mtInformation, [mbok], 0);
              OpenERPListForm('TStockAdjustEntryListGUI' , beforeshowStockAdjustEntryList);
              Self.close;
      end;
     finally
        EnableForm;
     end;

end;
procedure TUnAllocatedBinsReportGUI.beforeshowStockAdjustEntryList(Sender: TObject);
begin
  if not(Sender is  TStockAdjustEntryListGUI) then exit;
  TStockAdjustEntryListGUI(Sender).filterString :='Originalno = ' +QuotedStr(SAOriginalno);
end;
procedure TUnAllocatedBinsReportGUI.AfterPartsFormshow(Sender: TObject);
begin
  if not(Sender is    TfrmParts) then exit;
  TfrmParts(SEnder).Pagecontrol.ActivePage :=TfrmParts(SEnder).tabBatch;
  TfrmParts(SEnder).PagecontrolChange(TfrmParts(SEnder).Pagecontrol);
end;
procedure TUnAllocatedBinsReportGUI.grdMainDblClick(Sender: TObject);
var
  ans :Integer;

begin
  ans:= MessageDlgXP_Vista('Do you wish to View the Product?'+chr(13) +chr(13)+'Click on ''Fix Bin'' to adjust the Bin''s Quantity.', mtconfirmation ,[mbyes, mbno], 0 , nil, '','',False, nil, 'Fix Bin');
  if ans = mrno then Exit;
  if ans = mrYes then begin
    OpenERPForm('TfrmParts' , qrymain.FieldByName('ProductID').AsInteger , AfterPartsFormshow)
  end else begin
    AdjustQty;
  end;
end;

initialization
  RegisterClassOnce(TUnAllocatedBinsReportGUI);
end.
