unit BackorderListBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB, Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, IntegerListObj, DNMSpeedButton, BaseListDetails,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TBackorderListBaseGUI = class(TBaseListDetailsGUI)
    btnSmartOrder: TDNMSpeedButton;
  private
    SOIds: TIntegerList;
  Protected
    procedure MakeSmartOrder(BOtype: String);
    Procedure BeforeShowSmartOrderList(sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses BusObjSales, CommonFormLib, CommonLib, BusObjBase, CommonDbLib,
  SmartOrderListForm;

{$R *.dfm}

procedure TBackorderListBaseGUI.BeforeShowSmartOrderList(sender: TObject);
begin
  if not(sender is TSmartOrderListGUI) then
    exit;
  TSmartOrderListGUI(sender).SmartOrdersToHighlight := SOIds.commatext;
  (* if not (sender is TBaseListingGUI) then exit;
    TBaseListingGUI(Sender).FilterString := 'SmartOrderID = '+replacestr(SOIDs.commatext,',' , ' Or SmartOrderID ='); *)
end;

procedure TBackorderListBaseGUI.MakeSmartOrder(BOtype: String);
Var
  SaleIDs: String;
  IL: TIntegerList;
  I: Integer;
  SaleID: Integer;
  SOID: Integer;
  SalesObj: TSales;
begin
  inherited;
  SOIds := TIntegerList.create;
  try
    IL := TIntegerList.create;
    try
      SaleIDs := SelectedIDs('SaleID', IL, True);
      if SaleIDs = '' then
        exit;

      DoShowProgressbar(IL.count, 'Creating Smart Order(s)', '', False);
      try
        for I := 0 to IL.count - 1 do begin
          SaleID := IL[I];
          DoStepProgressbar('Creating Smart Order for Backorder #' + IntToStr(SaleID));
          if BOtype = 'SO' then
            SalesObj := TSalesorder.create(Self)
          else
            SalesObj := TInvoice.create(Self);
          try
            SalesObj.connection := TMyDacDataConnection.create(SalesObj);
            SalesObj.connection.connection := GetNewMyDacConnection(SalesObj);
            SalesObj.Load(SaleID);
            if SalesObj.count = 0 then
              continue
            else begin
              SalesObj.connection.BeginTransaction;
              SOID := SalesObj.CopyToSmartOrder;
              SalesObj.UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
              SalesObj.connection.CommitTransaction;
              if SOID <> 0 then
                SOIds.add(SOID);
            end;
          finally
            FreeandNil(SalesObj);
          end;
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      FreeandNil(IL);
    end;
    if SOIds.count > 0 then begin
      if MessageDlgXP_Vista('Do You wish To View The Smart Order(s)', mtConfirmation, [mbyes, mbno],
        0) = mrno then
        exit;
      if SOIds.count = 1 then
        OpenERPForm('TSmartOrderGUI', SOIds[0])
      else
        OpenERPListForm('TSmartOrderListGUI', BeforeShowSmartOrderList);
    end;
  finally
    FreeandNil(SOIds);
  end;
end;

end.
