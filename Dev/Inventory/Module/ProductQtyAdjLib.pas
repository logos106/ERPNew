unit ProductQtyAdjLib;

interface

Uses BusobjStockAdjustEntry, classes , Wwdbigrd, Wwdbgrid;

Type
  TProductQtyAdjObj = Class(TComponent)
  Private
    SAOriginalno:String;
    AdjustBatchno:String;
    procedure beforeshowStockAdjustEntryList(Sender: TObject);
    //procedure SelectBatchno(Sender: TwwDBGrid);

  Protected
  Public
    Function getAdjustBatchno:String;
    Function AdjustAllProductBins(Emptybin :Boolean =False):Boolean;
    Function AutoAdjustBin(const fProductIDs:String =''; const fClassIDs:String ='' ; fFilter:String=''; Emptybin:Boolean =False):Boolean;
    Function EmptyStock(const AdjDate:TDatetime;Const StockBasedoninstock:Boolean; const fProductIDs:String =''; const fClassIDs:String ='' ):Boolean;
  End;

implementation

uses CommonLib, Dialogs, CommonFormLib,
  StockAdjustEntryList, sysutils, forms;
Function TProductQtyAdjObj.getAdjustBatchno:String;
begin
    AdjustBatchno :='Adjustment';
    MessageDlgXP_Vista('Batch Enabled Product(s) Will Use ''Adjustment'' as the Batch Number for This Auto Adjustment', mtInformation, [mbOK], 0);
    //Commonformlib.OpenERPListFormSingleselectModal('TProductBatchnoListGUI' , SelectBatchno , nil ,true);
    Result :=AdjustBatchno;
end;
(*procedure TProductQtyAdjObj.SelectBatchno(Sender: TwwDBGrid);
begin
  try
    AdjustBatchno :=Sender.DataSource.DataSet.FieldByName('Batchno').AsString;
  Except
    // kill the exception if field not found etc.
  end;
end;*)
function TProductQtyAdjObj.AutoAdjustBin(const fProductIDs:String =''; const fClassIDs:String ='' ; fFilter:String=''; Emptybin:Boolean =False):Boolean;
begin
      REsult := False;
      AdjustBatchno := '';
      getAdjustBatchno;
      SAOriginalno := TStockAdjustEntry.AutoAdjustBin(fProductIDs, fClassIDs,'' , AdjustBatchno , '' , nil , nil , EmptyBin );
      if SAOriginalno <> '' then begin
        if not Emptybin then
          MessageDlgXP_Vista( 'Unallocated bin Quantity is allocated to the Default Bin.' +
                                  chr(13)+chr(13)+'The Original no of the Stock Adjustment(s): ' +SAOriginalno +
                                  chr(13) +Chr(13) +'Please make sure the stock adjustment(s) are processed.', mtInformation, [mbok], 0)
        else
          MessageDlgXP_Vista( 'Bin Quantity is set to 0.' +
                                  chr(13)+chr(13)+'The Original no of the Stock Adjustment(s): ' +SAOriginalno +
                                  chr(13) +Chr(13) +'Please make sure the stock adjustment(s) are processed.', mtInformation, [mbok], 0);


          OpenErpListform('TStockAdjustEntryListGUI' , beforeshowStockAdjustEntryList);
          REsult := True;
      end;

end;

Procedure TProductQtyAdjObj.beforeshowStockAdjustEntryList(Sender:TObject);
begin
  if not(Sender is TStockAdjustEntryListGUI) then exit;
  TStockAdjustEntryListGUI(Sender).FormStyle := fsMDIChild;
  TStockAdjustEntryListGUI(Sender).qryMain.Filter := 'Originalno = ' +QuotedStr(SAOriginalno);
  TStockAdjustEntryListGUI(Sender).qryMain.Filtered := True;
  TStockAdjustEntryListGUI(Sender).BringToFront;
end;

function TProductQtyAdjObj.EmptyStock(const AdjDate:TDatetime;Const StockBasedoninstock:Boolean; const fProductIDs,  fClassIDs: String): Boolean;
begin
      SAOriginalno := TStockAdjustEntry.EmptyStock(AdjDate , StockBasedoninstock , fProductIDs, fClassIDs);
      if SAOriginalno <> '' then begin
          MessageDlgXP_Vista( 'In-Stock for All Selected Product(s) are Set to 0 as on  ' + FormatDatetime(FormatSettings.shortdateformat , AdjDate)+' ' +
                                  chr(13)+chr(13)+'The Original no of the Stock Adjustment(s): ' +SAOriginalno +
                                  chr(13) +Chr(13) +'Please make sure the stock adjustment(s) are processed.', mtInformation, [mbok], 0);

          OpenErpListform('TStockAdjustEntryListGUI' , beforeshowStockAdjustEntryList);
          REsult := True;
      end else begin
          MessageDlgXP_Vista( 'All the Selected Product(s) has 0 ' + iif(StockBasedoninstock , 'In-Stock' , 'Available')+' Quantity as on ' + FormatDatetime(FormatSettings.shortdateformat , AdjDate)+'.', mtInformation, [mbok], 0);
          Result := False;
      end;

end;

Function TProductQtyAdjObj.AdjustAllProductBins(Emptybin :Boolean =False):Boolean;
begin
  REsult := False;
  SAOriginalno := TStockAdjustEntry.AutoAdjustBin('' , '' , '' , '' , '', nil , nil , Emptybin);
      if SAOriginalno <> '' then begin
        if not Emptybin then
          MessageDlgXP_Vista( 'Unallocated bin Quantity is allocated to the Default Bin.' +
                                  chr(13)+chr(13)+'The Original no of the Stock Adjustment(s): ' +SAOriginalno +
                                  chr(13) +Chr(13) +'Please make sure the stock adjustment(s) are processed.', mtInformation, [mbok], 0)
        else
          MessageDlgXP_Vista( 'Bin Quantity is set to 0.' +
                                  chr(13)+chr(13)+'The Original no of the Stock Adjustment(s): ' +SAOriginalno +
                                  chr(13) +Chr(13) +'Please make sure the stock adjustment(s) are processed.', mtInformation, [mbok], 0);


          OpenErpListform('TStockAdjustEntryListGUI' , beforeshowStockAdjustEntryList);
          REsult := True;
      end;
end;

end.
