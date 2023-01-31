unit DeletedStockAdjustmentsTofix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TDeletedStockAdjustmentsTofixGUI = class(TBaseListingGUI)
    qryMainStockAdjustEntryID: TIntegerField;
    qryMainCreationDate: TDateField;
    qryMainAdjustmentdate: TDateTimeField;
    qryMainAccountname: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainIsStocktake: TWideStringField;
    qryMainEmployee: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainProcessed: TWideStringField;
    qryMainApproved: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
  end;

var
  DeletedStockAdjustmentsTofixGUI: TDeletedStockAdjustmentsTofixGUI;

implementation

uses DebugLib, BusobjStockAdjustEntry, LogLib, CommonLib;

{$R *.dfm}

procedure TDeletedStockAdjustmentsTofixGUI.cmdNewClick(Sender: TObject);
var
  s:String;
begin
//  inherited;
  s:= DoBackuptables(['tblstockadjustentry' ,'tblstockmovement' ,'tblstockadjustentrylines' ,'tblstockmovementlines' ,'tblpqa', 'tblpqadetails'] , '_deletedSAFIX' , false);
  if s<> '' then begin
    ExecuteSQLwithProgress(s);
    s:= '';
  end;

  if grdMain.SelectedList.Count =0 then exit;
  iterateprocno := 1;
  IterateselectedRecords(true);

end;

procedure TDeletedStockAdjustmentsTofixGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);
var
  StockAdjust :TStockAdjustEntry;
begin
  inherited;
  if IterateProcNo = 1 then begin
    StockAdjust := TStockAdjustEntry.CreateWithNewConn(self);
    try
      StockAdjust.Load(qryMainStockAdjustEntryID.AsInteger);
      if StockAdjust.count =0 then exit;
      if StockAdjust.deleted =False then exit;
      try
        StockAdjust.Connection.BeginTransaction;
        StockAdjust.Deleted := false;
        StockAdjust.PostDb;
        StockAdjust.Connection.CommitTransaction;
        StockAdjust.Connection.BeginTransaction;
        StockAdjust.Deleted := true;
        StockAdjust.PostDb;
        StockAdjust.Save;
        StockAdjust.Connection.CommitTransaction;
      Except
        on E:Exception do begin
          Logtext(inttostr(StockAdjust.ID) +' # '  + E.Message);
        end;
      end;
    finally
      Freeandnil(StockAdjust);
    end;
  end;
end;
initialization
  RegisterClassOnce(TDeletedStockAdjustmentsTofixGUI);

end.
