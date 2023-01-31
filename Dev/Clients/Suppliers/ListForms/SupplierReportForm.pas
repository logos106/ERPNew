unit SupplierReportForm;
{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 04/05/05  1.00.01 BJ   Bug Fixed:form opening with a scroll bar at the bottom
 05/05/05  1.00.02 BJ (1)Used the hidden columns- HCompany and HType
                         To implement the sorting. These columns are populated with
                         values for all the rows unlike the 'Company' and 'Type'
                         field which are nullified for the 'detail rows'.
                         Not possible to sort on the 'Company' field  when the form
                         is in 'Detail' or 'Extra Detail' mode and not possible
                         to sorton 'Type' field when the form is in 'extra detail'
                         mode.
                      (2)new variable 'FilterField' introduced which gets intiialised
                         when 'Apply filter' is fired with the active column name
                         This variable is used in the 'Refreshtotal's to calculate the
                         total.
                      (3)Filtering on a 'summary field' for the 'Group record' is
                         disabled because calculating the total is a problem.

 13/05/05  1.00.03 DJH   Made Extra Details Drillable to Purchase Order Form?
 07/09/05  1.00.04 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwDialog, Wwlocate,
  SelectionDialog, DNMPanel, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TSupplierReportGUI = class(TBaseListingGUI)
    qryMainCompany: TWideStringField;
    qryMainType: TWideStringField;
    qryMainDueDate: TDateField;
    qryMainName: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainOriginal: TWideStringField;
    qryMainPurchaseOrderNumber: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainComments: TWideStringField;
    qryMainWareHouseNotes: TWideStringField;
    qryMainDetails: TLargeIntField;
    qryMainInvoiceDate: TDateField;
    qryMainClientID: TIntegerField;
    chkBasePurchOn: TCheckBox;
    Label47: TLabel;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainOrderDate: TDateTimeField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure chkBasePurchOnClick(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure FormShow(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure actAddToFilterExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FilterField: string;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
  public
    { Public declarations }
  end;

implementation

uses FastFuncs,Forms, CommonLib, tcConst;

{$R *.dfm}

{ TSupplierReportGUI }

procedure TSupplierReportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.BasesOnInvoicedate') then
    chkBasePurchOn.checked :=  GuiPrefs.Node['Options.BasesOnInvoicedate'].asBoolean;
end;

procedure TSupplierReportGUI.RefreshQuery;
begin
  if chkBasePurchOn.Checked then
    qryMain.Params.ParamByName('BasePurchaseOn').AsString := 'T'
  else
    qryMain.Params.ParamByName('BasePurchaseOn').AsString := 'F';
  qryMain.Params.ParamByName('txtfrom1').AsDateTime := filterdatefrom;
  qryMain.Params.ParamByName('txtto1').AsDateTime := filterDateTo;
  inherited;
end;

procedure TSupplierReportGUI.RefreshTotals;
var
  dTotCostEx, dTotCostInc: double;
  Bookmark: TBookmark;
begin
  dTotCostEx := 0;
  dTotCostInc := 0;
  qryMain.DisableControls;
  Bookmark := qryMain.GetBookmark;
  try
    with qryMain do begin
      First;
      while not Eof do begin
        if (FilterField = '') or (FilterField = 'Company') then begin
          if qryMainDetails.AsInteger = 0 then begin
            dTotCostEx := dTotCostEx + qryMainTotalAmountEx.AsCurrency;
            dTotCostInc := dTotCostInc + qryMainTotalAmountInc.AsCurrency;
          end;
        end else if FilterField = 'Type' then begin
          if qryMainDetails.AsInteger = 1 then begin
            dTotCostEx := dTotCostEx + qryMainTotalAmountEx.AsCurrency;
            dTotCostInc := dTotCostInc + qryMainTotalAmountInc.AsCurrency;
          end;
        end else if qryMainDetails.AsInteger = 2 then begin
          dTotCostEx := dTotCostEx + qryMainTotalAmountEx.AsCurrency;
          dTotCostInc := dTotCostInc + qryMainTotalAmountInc.AsCurrency;
        end;
        Next;
      end;
      First;
    end;
  Finally
    qryMain.GotoBookmark(Bookmark);
    qryMain.FreeBookmark(Bookmark);
    qryMain.EnableControls;
  end;

  grdMain.ColumnByName('Total Amount (Ex)').FooterValue := FloatToStrF(dTotCostEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Amount (Inc)').FooterValue := FloatToStrF(dTotCostInc, ffCurrency, 15, CurrencyRoundPlaces);
  FilterField := '';
end;

procedure TSupplierReportGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.BasesOnInvoicedate'].asBoolean:= chkBasePurchOn.checked;
end;

procedure TSupplierReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin {Summary}
        GroupFilterString := '(Details = 0)';
      end;
    1: 
      begin {Details}
        GroupFilterString := '(Details <> 2)';
        if FastFuncs.PosEx('HCompany', BaseIndexFieldNames) = 0 then begin
          // the procedure is called twice to intialise it as ASC
          grdMainTitleButtonClick(grdMain, 'Type');
          grdMainTitleButtonClick(grdMain, 'Type');
        end;
      end;
    2: 
      begin  {Extra Details}
        GroupFilterString := '(Details <> 1)';
        if FastFuncs.PosEx('HType', BaseIndexFieldNames) = 0 then begin
          // the procedure is called twice to intialise it as ASC
          grdMainTitleButtonClick(grdMain, 'OrderDate');
          grdMainTitleButtonClick(grdMain, 'OrderDate');
        end;
      end;
  end;
  inherited;
end;

procedure TSupplierReportGUI.grdMainDblClick(Sender: TObject);
begin
  if grpFilters.ItemIndex > 1 then begin
    SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
  end;
  
  inherited;
end;

procedure TSupplierReportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if not Empty(qryMainCompany.AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TSupplierReportGUI.chkBasePurchOnClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;

end;

procedure TSupplierReportGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  // sorting on company is not possible when the form is in detail mode
  // and sorting on the type is not possible when the form is in extra detail mode
  if grpFilters.ItemIndex = 2 then begin
    if (AFieldName = 'Company') or (AFieldName = 'Type') then Exit;
  end else if grpFilters.ItemIndex = 1 then if (AFieldName = 'Company') then Exit;

  case grpFilters.ItemIndex of
    0: 
      begin
        qryMain.IndexFieldNames := '';
        BaseIndexFieldNames := '';
        SwapBaseIndexFieldPriority := true;
      end;
    1:
      begin
        BaseIndexFieldNames := 'HCompany ASC CIS; Details ASC';
        qryMain.IndexFieldNames := BaseIndexFieldNames;
        SwapBaseIndexFieldPriority := true;
      end;
    2:
      begin
        BaseIndexFieldNames := 'HCompany ASC CIS; HType ASC CIS; Details ASC';
        qryMain.IndexFieldNames := BaseIndexFieldNames;
        SwapBaseIndexFieldPriority := true;
      end;
  end;

  inherited;
end;

procedure TSupplierReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT ');
  qryMain.SQL.Add('tblpurchaseorders.SupplierName as HCompany,');
  qryMain.SQL.Add('Space(50) as Company,');
  qryMain.SQL.Add('If(tblpurchaseorders.IsBill="T","Bill",If(tblpurchaseorders.IsPO="T","Purchase Order",If(tblpurchaseorders.IsCredit="T","Credit","Return Authority"))) AS HType,');
  qryMain.SQL.Add('If(tblpurchaseorders.IsBill="T","Bill",If(tblpurchaseorders.IsPO="T","Purchase Order",If(tblpurchaseorders.IsCredit="T","Credit","Return Authority"))) AS Type,');
  qryMain.SQL.Add('tblpurchaseorders.OrderDate as OrderDate,');
  qryMain.SQL.Add('tblpurchaseorders.DueDate as DueDate,');
  qryMain.SQL.Add('tblpurchaseorders.InvoiceDate as InvoiceDate,');
  qryMain.SQL.Add('tblpurchaseorders.SupplierName as Name,');
  qryMain.SQL.Add('tblpurchaseorders.GlobalRef as "Global #" ,');
  qryMain.SQL.Add('tblpurchaseorders.OriginalNo as "Original #",');
  qryMain.SQL.Add('tblpurchaseorders.PurchaseOrderNumber as "Purchase Order Number" ,');
  qryMain.SQL.Add('tblpurchaseorders.InvoiceNumber as "Invoice Number",');
  qryMain.SQL.Add('If(IsCredit="T",-tblpurchaseorders.TotalAmount,tblpurchaseorders.TotalAmount) as "Total Amount (Ex)",');
  qryMain.SQL.Add('If(IsCredit="T",-tblpurchaseorders.TotalAmountInc,tblpurchaseorders.TotalAmountInc) as "Total Amount (Inc)" ,');
  qryMain.SQL.Add('tblpurchaseorders.Comments as "Comments",');
  qryMain.SQL.Add('tblpurchaseorders.SalesComments as "WareHouse Notes",');
  qryMain.SQL.Add('tblpurchaseorders.PurchaseOrderID as PurchaseOrderID,');
  qryMain.SQL.Add('tblpurchaseorders.ClientID,');
  qryMain.SQL.Add('2 as Details');
  qryMain.SQL.Add('FROM tblpurchaseorders');
  qryMain.SQL.Add('INNER JOIN tblpurchaselines USING(PurchaseOrderID) ');
  qryMain.SQL.Add('LEFT JOIN tblClients  ON  tblpurchaseorders.ClientID = tblClients.ClientID');
  qryMain.SQL.Add('WHERE (IsBill ="T" OR IsPO ="T" OR IsRA ="T" OR IsCredit ="T")');
  qryMain.SQL.Add('And ((:BasePurchaseOn = "F" and OrderDate Between :txtfrom1 AND :txtto1)');
  qryMain.SQL.Add('or (:BasePurchaseOn = "T" and InvoiceDate Between :txtfrom1 AND :txtto1))');
//  if not chkBasePurchOn.Checked then begin
//    qryMain.SQL.Add(' And OrderDate Between :txtfrom1 AND :txtto1');
//  end else begin
//    qryMain.SQL.Add(' And InvoiceDate Between :txtfrom1 AND :txtto1');
//  end;

  qryMain.SQL.Add('AND tblpurchaseorders.Deleted<>"T"');
  qryMain.SQL.Add('GROUP BY tblpurchaseorders.ClientID,tblpurchaseorders.PurchaseOrderID');

  qryMain.SQL.Add('UNION ALL ');

  qryMain.SQL.Add('SELECT ');
  qryMain.SQL.Add('tblpurchaseorders.SupplierName as HCompany,');
  qryMain.SQL.Add('"" as Company,');
  qryMain.SQL.Add('If(tblpurchaseorders.IsBill="T","Bill",If(tblpurchaseorders.IsPO="T","Purchase Order",If(tblpurchaseorders.IsCredit="T","Credit","Return Authority"))) as HType,');
  qryMain.SQL.Add('If(tblpurchaseorders.IsBill="T","Bill",If(tblpurchaseorders.IsPO="T","Purchase Order",If(tblpurchaseorders.IsCredit="T","Credit","Return Authority"))) as Type,');
  qryMain.SQL.Add('Null as OrderDate,');
  qryMain.SQL.Add('Null as DueDate,');
  qryMain.SQL.Add('Null as InvoiceDate,');
  qryMain.SQL.Add('tblpurchaseorders.SupplierName as Name,');
  qryMain.SQL.Add('"" as "Global #" ,');
  qryMain.SQL.Add('"" as "Original #",');
  qryMain.SQL.Add('"" as "Purchase Order Number" ,');
  qryMain.SQL.Add('"" as "Invoice Number",');
  qryMain.SQL.Add('Sum( If(IsCredit="T",-tblpurchaseorders.TotalAmount,tblpurchaseorders.TotalAmount) ) as "Total Amount (Ex)",');
  qryMain.SQL.Add('Sum( If(IsCredit="T",-tblpurchaseorders.TotalAmountInc,tblpurchaseorders.TotalAmountInc) ) as "Total Amount (Inc)",');
  qryMain.SQL.Add('"" as "Comments",');
  qryMain.SQL.Add('"" as "WareHouse Notes",');
  qryMain.SQL.Add('Null as PurchaseOrderID,');
  qryMain.SQL.Add('null as ClientID,');
  qryMain.SQL.Add('1 as Details');
  qryMain.SQL.Add('FROM tblpurchaseorders');
  qryMain.SQL.Add('LEFT JOIN tblClients  ON  tblpurchaseorders.SupplierName = tblClients.Company');
  qryMain.SQL.Add('WHERE (IsBill ="T" OR IsPO ="T" OR IsRA ="T" OR IsCredit ="T")');
  qryMain.SQL.Add('And ((:BasePurchaseOn = "F" and OrderDate Between :txtfrom1 AND :txtto1)');
  qryMain.SQL.Add('or (:BasePurchaseOn = "T" and InvoiceDate Between :txtfrom1 AND :txtto1))');
//  if not chkBasePurchOn.Checked then begin
//    qryMain.SQL.Add(' And OrderDate Between :txtfrom1 AND :txtto1');
//  end else begin
//    qryMain.SQL.Add(' And InvoiceDate Between :txtfrom1 AND :txtto1');
//  end;
  qryMain.SQL.Add('AND tblpurchaseorders.Deleted<>"T"');
  qryMain.SQL.Add('GROUP BY tblpurchaseorders.ClientID,tblpurchaseorders.PurchaseOrderID,tblpurchaseorders.IsBill,tblpurchaseorders.IsPO,tblpurchaseorders.IsCredit,tblpurchaseorders.IsRA');

  qryMain.SQL.Add('UNION ALL ');

  qryMain.SQL.Add('SELECT ');
  qryMain.SQL.Add('tblpurchaseorders.SupplierName as HCompany,');
  qryMain.SQL.Add('tblpurchaseorders.SupplierName as Company,');
  qryMain.SQL.Add('"" as HType,');
  qryMain.SQL.Add('"" as Type,');
  qryMain.SQL.Add('Null as OrderDate,');
  qryMain.SQL.Add('Null as DueDate,');
  qryMain.SQL.Add('Null as InvoiceDate,');
  qryMain.SQL.Add('tblpurchaseorders.SupplierName as Name,');
  qryMain.SQL.Add('Space(50) as "Global #" ,');
  qryMain.SQL.Add('Space(50) as "Original #",');
  qryMain.SQL.Add('Space(50) as "Purchase Order Number" ,');
  qryMain.SQL.Add('Space(50) as "Invoice Number",');
  qryMain.SQL.Add('Sum( If(IsCredit="T",-tblpurchaseorders.TotalAmount,tblpurchaseorders.TotalAmount) ) as "Total Amount (Ex)",');
  qryMain.SQL.Add('Sum( If(IsCredit="T",-tblpurchaseorders.TotalAmountInc,tblpurchaseorders.TotalAmountInc) ) as "Total Amount (Inc)",');
  qryMain.SQL.Add('Space(50) as "Comments",');
  qryMain.SQL.Add('Space(50) as "WareHouse Notes",');
  qryMain.SQL.Add('null as PurchaseOrderID,');
  qryMain.SQL.Add('null as ClientID,');
  qryMain.SQL.Add('0 as Details');
  qryMain.SQL.Add('FROM tblpurchaseorders');
  qryMain.SQL.Add('LEFT JOIN tblClients  ON  tblpurchaseorders.SupplierName = tblClients.Company');
  qryMain.SQL.Add('WHERE (IsBill ="T" OR IsPO ="T" OR IsRA ="T" OR IsCredit ="T")');
  qryMain.SQL.Add('And ((:BasePurchaseOn = "F" and OrderDate Between :txtfrom1 AND :txtto1)');
  qryMain.SQL.Add('or (:BasePurchaseOn = "T" and InvoiceDate Between :txtfrom1 AND :txtto1))');
//  if not chkBasePurchOn.Checked then begin
//    qryMain.SQL.Add(' And OrderDate Between :txtfrom1 AND :txtto1');
//  end else begin
//    qryMain.SQL.Add(' And InvoiceDate Between :txtfrom1 AND :txtto1');
//  end;

  qryMain.SQL.Add('AND tblpurchaseorders.Deleted<>"T"');
  qryMain.SQL.Add('GROUP BY tblpurchaseorders.ClientID');

  qryMain.SQL.Add('Order By HCompany, HType, ClientID,OrderDate,Name,Details;');
  RefreshOrignalSQL;
end;

procedure TSupplierReportGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFilters.ItemIndex := 0;
end;

procedure TSupplierReportGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  case grpFilters.ItemIndex of
    0:
      begin
        qryMain.IndexFieldNames := '';
        BaseIndexFieldNames := '';
        SwapBaseIndexFieldPriority := false;
      end;
    1:
      begin
        BaseIndexFieldNames := 'HCompany ASC CIS; Details ASC';
        qryMain.IndexFieldNames := BaseIndexFieldNames;
        SwapBaseIndexFieldPriority := true;
      end;
    2:
      begin
        BaseIndexFieldNames := 'HCompany ASC CIS; HType ASC CIS; Details ASC';
        qryMain.IndexFieldNames := BaseIndexFieldNames;
        SwapBaseIndexFieldPriority := true;
      end;
  end;
  inherited;
end;

procedure TSupplierReportGUI.actAddToFilterExecute(Sender: TObject);
begin
  FilterField := grdMain.GetActiveField.FieldName;
  if (FilterField = 'Total Amount (Ex)') or (FilterField = 'Total Amount (Inc)') then if QryMain.FieldByName('Details').AsInteger <= 1 then if grpFilters.ItemIndex > 0 then begin 
        CommonLib.MessageDlgXP_Vista('Not possible to filter on a ''Summary Field'' of a ''Group record''', mtInformation, [mbOK], 0);
        Exit;
      end;

  inherited;
end;

initialization
  RegisterClassOnce(TSupplierReportGUI);
end.
