unit frmProcJobCompleteProcess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess, SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  wwcheckbox, Shader, DNMPanel, wwDbGrid, IntegerListObj, ProgressDialog;

type
  TfmProcJobCompleteProcess = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkStowAll: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
  private
    ProgressDialog: TProgressDialog;
    fDbConnection: TMyConnection;
    fSalesOrderIdList: TIntegerList;
    fDbConnectionAssigned: Boolean;
    function ProcessSelected(SOList: TIntegerList; StowAll: boolean = false): boolean; //overload;
    function GetDbConnection: TMyConnection;
    procedure SetDbConnection(const Value: TMyConnection);
    property DbConnectionAssigned: boolean read fDbConnectionAssigned;
  protected
  public
    property DbConnection: TMyConnection read GetDbConnection write SetDbConnection;
    property SalesOrderIdList: TIntegerList read fSalesOrderIdList write fSalesOrderIdList;
  end;

var
  fmProcJobCompleteProcess: TfmProcJobCompleteProcess;

implementation

{$R *.dfm}


uses
  CommonLib, BusObjSales, BusObjProcPickSlip,
  BusObjBase, BusObjProcess, BusObjTrans, (*BusObjProductQty, *)FastFuncs;


procedure TfmProcJobCompleteProcess.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  fDbConnectionAssigned:= false;
  ProgressDialog:= TProgressDialog.Create(self);
end;

procedure TfmProcJobCompleteProcess.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfmProcJobCompleteProcess.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  //
end;

procedure TfmProcJobCompleteProcess.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmProcJobCompleteProcess.btnSaveClick(Sender: TObject);
begin
  inherited;
  if ProcessSelected(SalesOrderIdList, chkStowAll.Checked) then ModalResult:= mrOk
  else ModalResult:= mrAbort;
end;

function TfmProcJobCompleteProcess.ProcessSelected(
  SOList: TIntegerList; StowAll: boolean = false): boolean;
var
  msg: TStringList;
  SO: TSalesOrder;
//  StowSlip: TProcStowAwaySlip;
  x: Integer;
  Tree: TProcTreeNode;
  ConvertedCount: integer;
//  StowSlipLineCount: integer;
  SavedOk: boolean;

//  procedure AddStowAwayLine;
//  begin
//    StowSlip.Lines.New;
//    StowSlip.Lines.ProcTreeId:= Tree.Id;
//    StowSlip.Lines.SaleId:= SO.Id;
//    StowSlip.Lines.SaleDocNumber:= SO.DocNumber;
//    StowSlip.Lines.SaleCustomerName:= SO.CustomerName;
//    StowSlip.Lines.SaleShipDate:= SO.ShipDate;
//    StowSlip.Lines.SaleLineId:= SO.Lines.Id;
//    StowSlip.Lines.SaleLineProductName:= SO.Lines.ProductName;
//    StowSlip.Lines.SaleLineProductDescription:= SO.Lines.ProductDescription;
//    StowSlip.Lines.SaleLineQuantity:= SO.Lines.UOMQtyShipped;
//    StowSlip.Lines.SaleLineShipDate:= SO.Lines.ShipDate;
//    StowSlip.Lines.StepDescription:= '';
//    StowSlip.Lines.ItemRoot:= true;
//    StowSlip.Lines.ItemCaption:= Tree.Caption;
//    StowSlip.Lines.ItemDescription:= Tree.Description;
//    StowSlip.Lines.ItemTotalQty:= Tree.TotalQty;
//    StowSlip.Lines.ItemTotalQtyOriginal:= Tree.TotalQtyOriginal;
//    StowSlip.Lines.ItemPartId:= Tree.PartsId;
//    StowSlip.Lines.ItemPartUom:= Tree.ProcTreePart.UnitOfMeasure;
//    StowSlip.Lines.PostDb;
//    Inc(StowSlipLineCount);
//  end;

  function AllSaleProductionComplete(aSO: TSalesOrder): boolean;
  begin
    result:= true;
    aSO.Lines.First;
    while not aSO.Lines.EOF do begin
      Tree:= TProcTreeNode(aSO.Lines.Container.ItemByClass(TProcTreeNode,false));
      if Assigned(Tree) and (Tree.Children.Count > 0) then begin
        if not Tree.AllProcessesComplete then begin
          result:= false;
          msg.Add('Sales Order ' + aSO.OrderNumber + ' for ' + aSO.CustomerName);
          msg.Add('Could not be finialised as production is not complete for ' +
            aSO.Lines.ProductName);
          exit;
        end;
      end;
      aSO.Lines.Next;
    end;
  end;

begin
  result:= false;

  SO:= TSalesOrder.Create(nil);
  SO.Connection := TMyDacDataConnection.Create(SO);
  SO.Connection.Connection:= DbConnection;
  SO.SilentMode:= true;
//  StowSlip:= TProcStowAwaySlip.Create(nil);
//  StowSlip.Connection:= SO.Connection;
//  StowSlip.SilentMode:= true;
  msg:= TStringList.Create;

  try
    ProgressDialog.Caption:= 'Completing Sales Orders ...';
    ProgressDialog.MaxValue:= SOList.Count;
    ProgressDialog.MinValue:= 0;
    ProgressDialog.Step:= 1;
    ProgressDialog.Execute;
    ConvertedCount:= 0;

    if not DbConnectionAssigned then
      DbConnection.StartTransaction;

    for x:= 0 to SOList.Count-1 do begin
      SO.Load(SOList[x]);
//      StowSlipLineCount:= 0;
      SavedOk:= true;
      if SO.Converted or (SO.IsDVATrans and SO.PriorApprovalRequired and (SO.PriorApprovalRefNo = '')) then begin
        if SO.Converted then begin
          msg.Add('Sales order ' + SO.OrderNumber + ' for ' + SO.CustomerName);
          msg.Add('Order could not be converted as it has already been converted to an invoice.');
        end
        else begin
          msg.Add('Sales order ' + SO.OrderNumber + ' for ' + SO.CustomerName);
          msg.Add('Order could not be finalised/converted as prior approval required.');
        end;
      end
      else begin
        {1 - check that SO is all complete}
        if AllSaleProductionComplete(SO) then begin
          {2 - Complete production}
          SO.Connection.BeginNestedTransaction;
          SO.Lines.First;
          while not SO.Lines.EOF do begin
            Tree:= TProcTreeNode(SO.Lines.Container.ItemByClass(TProcTreeNode,false));
            if Assigned(Tree) and (Tree.Children.Count > 0) then begin
              if not Tree.Complete then begin
                Tree.Complete:= true;
//                if StowSlipLineCount = 0 then begin
//                  StowSlip.New;
//                  StowSlip.Date:= now;
//                  StowSlip.Description:= 'Production Stow Away - ' + SO.CustomerName + ' ' + SO.DocNumber; //FormatDateTime('dd/mm/yyyy',StowSlip.Date);
//                end;
//                AddStowAwayLine;
              end;
              Tree.ProcTreePart.Product.UpdateAvgCosts;
            end;
            SO.Lines.Next;
          end;
          { save the sales order }
          SO.ResultStatus.Clear;
          if SO.Save then begin
            //
          end
          else begin
            msg.Add('Sales order ' + SO.OrderNumber + ' for ' + SO.CustomerName);
            msg.Add('Error occured during save with message: ' + SO.ResultStatus.Messages);
            SavedOk:= false;
          end;
//          if SavedOk then begin
//            { save the stow away slip }
//            if StowAll then
//              StowSlip.StowAll;
//            StowSlip.ResultStatus.Clear;
//            if StowSlip.Save then begin
//              //
//            end
//            else begin
//              msg.Add('Stow Away Slip for sale: ' + SO.OrderNumber + ' ' + SO.CustomerName);
//              msg.Add('Error occured during save with message: ' + StowSlip.ResultStatus.Messages);
//              SavedOk:= false;
//            end;
//          end;
          if SavedOk then begin
            {convert sales order}
            if SO.IsInternalOrder then begin
              SO.Converted:= true;
              SO.PostDb;
              result:= true;
              Inc(ConvertedCount);
            end
            else begin
              SO.Copytoinvoice(SO.Id);
              result:= true;
              Inc(ConvertedCount);
            end;
          end;

          if SavedOk then
            SO.Connection.CommitNestedTransaction
          else
            SO.Connection.RollbackNestedTransaction;
        end;
      end;

      ProgressDialog.StepIt;
    end;

    if not DbConnectionAssigned then
      DbConnection.Commit;

    if msg.Count > 0 then begin
      msg.Insert(0,'');
      msg.Insert(0,IntToStr(ConvertedCount) + ' of a total of ' +
        Fastfuncs.IntToStr(SOList.Count) + ' Sales Orders converted.');
      CommonLib.MessageDlgXP_Vista(msg.Text,mtWarning,[mbOk],0);
    end
    else begin
      CommonLib.MessageDlgXP_Vista(FastFuncs.IntToStr(ConvertedCount) + ' of a total of ' +
      Fastfuncs.IntToStr(SOList.Count) + ' Sales Orders converted.',mtInformation,[mbOk],0);

    end;

  finally
//    StowSlip.Free;
    SO.Free;
    msg.Free;
    ProgressDialog.CloseDialog;
  end;

end;

function TfmProcJobCompleteProcess.GetDbConnection: TMyConnection;
begin
  if Assigned(fDbConnection) then
    result:= fDbConnection
  else
    result:= MyConnection;
end;

procedure TfmProcJobCompleteProcess.SetDbConnection(
  const Value: TMyConnection);
begin
  fDbConnection:= Value;
  fDbConnectionAssigned:= true;
end;

end.
