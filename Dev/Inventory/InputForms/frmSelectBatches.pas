unit frmSelectBatches;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, AppEvnts, DB,  StdCtrls, ExtCtrls, DNMPanel,
  Grids, Wwdbigrd, Wwdbgrid, kbmMemTable, Buttons, DNMSpeedButton, SelectionDialog,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS,
  ImgList;

type
  TfrmSelectBatchesGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    lblDistributeNitems: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    edSelectNItems: TEdit;
    edUnallocated: TEdit;
    edClass: TEdit;
    edPartName: TEdit;
    DNMPanel2: TDNMPanel;
    kbBatches: TkbmMemTable;
    dsBatches: TDataSource;
    grdBatches: TwwDBGrid;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure grdBatchesFieldChanged(Sender: TObject; Field: TField);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    qtySold: double;
    procedure Initialise(PartID, ClassID: integer; Qty: double);

  public
    qry: TERPQuery;
    OK: boolean;
    function UserPick(const PartID, ClassID, SalesID: integer; const Qty: double; const ttype: string): boolean;

  end;


implementation

uses CommonDbLib, Forms, CommonLib;

{$R *.dfm}

procedure TfrmSelectBatchesGUI.Initialise(PartID, ClassID: integer; Qty: double);
var 
  sqty: double;
begin
  qry := TERPQuery.Create(nil);
  try
    with qry do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Text := Format('SELECT PartName FROM TblParts WHERE PartsID = %d', [PartID]);
      Open;
      if RecordCount = 1 then edPartName.Text := FieldByName('PartName').AsString;
      Close;
      SQL.Text := Format('SELECT ClassName FROM TblClass WHERE ClassID = %d', [ClassID]);
      Open;
      if RecordCount = 1 then edClass.Text := FieldByName('ClassName').AsString;
      Close;
      //    SQL.Text := format('SELECT BatchID, QtyOnHand, PurchaseOrderID ' +
      //                       'FROM tblPartsBatches WHERE PartsID = %d AND ClassID = %d',
      //                        [PartID, ClassID]);


      SQL.Text := Format('SELECT B.BatchID, B.QtyOnHand, B.PurchaseOrderID, B.BinID, ' +
        'L.BinLocation, P.SupplierName, P.OrderDate ' + 'FROM tblPartsBatches B, tblPurchaseOrders P ' +
        'LEFT JOIN  tblpartslocations L ON L.BinID = B.BinID ' + 'WHERE B.PartsID = %d AND B.ClassID = %d ' +
        '  AND (B.SalesID is null OR B.SalesID < 0) ' + '  AND P.PurchaseOrderID = B.PurchaseOrderID ' + 'ORDER BY B.PurchaseOrderID',
        [PartID, ClassID]);
      Open;
      //    kbBatches.LoadFromDataSet(qry, [mtcpoStructure]);
      with kbBatches.FieldDefs.AddFieldDef do begin
        Name := 'Selected Qty';
        DataType := ftFloat;
      end;
      with kbBatches.FieldDefs.AddFieldDef do begin
        Name := 'Qty Available';
        DataType := ftFloat;
      end;
      with kbBatches.FieldDefs.AddFieldDef do begin
        Name := 'PurchaseOrder ID';
        DataType := ftLargeint;
      end;
      with kbBatches.FieldDefs.AddFieldDef do begin
        Name := 'BinID';
        DataType := ftLargeint;
      end;
      with kbBatches.FieldDefs.AddFieldDef do begin
        Name := 'BatchID';
        DataType := ftLargeint;
      end;
      with kbBatches.FieldDefs.AddFieldDef do begin
        Name := 'BinLocation';
        DataType := ftString;
      end;
      with kbBatches.FieldDefs.AddFieldDef do begin
        Name := 'SupplierName';
        DataType := ftString;
      end;
      with kbBatches.FieldDefs.AddFieldDef do begin
        Name := 'OrderDate';
        DataType := ftDateTime;
      end;

      kbBatches.Open;
      grdBatches.RemoveField('PurchaseOrder ID', false);
      grdBatches.RemoveField('BinID', false);
      grdBatches.RemoveField('BatchID', false);
      while not Qry.Eof do begin
        if qty - qry.FieldByName('QtyOnHand').AsFloat > 0 then begin
          qty := qty - qry.FieldByName('QtyOnHand').AsFloat;
          sqty := qry.FieldByName('QtyOnHand').AsFloat;
        end else begin
          sqty := qty;
          qty := 0;
        end;
        kbBatches.AppendRecord([sqty,
          qry.FieldByName('QtyOnHand').AsFloat,
          qry.FieldByName('PurchaseOrderID').AsInteger,
          qry.FieldByName('BinID').AsInteger,
          qry.FieldByName('BatchID').AsInteger,
          qry.FieldByName('BinLocation').AsString,
          qry.FieldByName('SupplierName').AsString,
          qry.FieldByName('OrderDate').AsDateTime]);
        qry.Next;
      end;
      kbBatches.Fields[1].ReadOnly := true;
      kbBatches.Fields[2].ReadOnly := true;
      kbBatches.Fields[3].ReadOnly := true;
      kbBatches.Fields[4].ReadOnly := true;
      kbBatches.Fields[5].ReadOnly := true;
      kbBatches.Fields[6].ReadOnly := true;
      kbBatches.Fields[7].ReadOnly := true;
    end;
  finally
    FreeAndNil(qry);
  end;
end; //Initialise


function TfrmSelectBatchesGUI.UserPick(const PartID, ClassID, SalesID: integer; const Qty: double;
  const ttype: string): boolean;
begin
  Initialise(PartID, ClassID, Qty);
  qtySold := Qty;
  edSelectNItems.Text := Format('Select %1.1f Sold Items from Batches', [Qty]);
  edUnallocated.Text := FloatToStr(Qty);
  grdBatchesFieldChanged(nil, nil);
  grdBatches.SetActiveField('Selected Qty');
  Result := true;
end;

procedure TfrmSelectBatchesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;
end;

procedure TfrmSelectBatchesGUI.grdBatchesFieldChanged(Sender: TObject; Field: TField);
var 
  selected: double;
begin
  if (Sender = nil) or (Field.FieldName = 'Selected Qty') then begin
    selected := 0;
    with TkbmMemTable.Create(nil) do begin
      LoadFromDataSet(kbBatches, [mtcpoStructure]);
      First;
      while not Eof do begin
        selected := selected + FieldByName('Selected Qty').AsFloat;
        Next;
      end;
      edUnallocated.Text := FloatToStr(qtySold - selected);
      if StrToFloat(edUnallocated.Text) = 0 then edUnallocated.Color := clMoneyGreen
      else if StrToFloat(edUnallocated.Text) > 0 then edUnallocated.Color := clLime
      else edUnallocated.Color := clRed;
    end;
  end;
end;

procedure TfrmSelectBatchesGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  OK := false;
  Close;
end;

procedure TfrmSelectBatchesGUI.cmdOKClick(Sender: TObject);
begin
  if StrToFloat(edUnallocated.Text) <> 0.00 then begin
    CommonLib.MessageDlgXP_Vista('The "To Select" Value Must Equal to Zero(0)', mtWarning, [mbOK], 0);
  end else begin
    inherited;
    OK := true;
    Close;
  end;
end;
initialization
  RegisterClassOnce(TfrmSelectBatchesGUI);
end.
