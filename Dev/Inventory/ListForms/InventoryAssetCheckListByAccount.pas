unit InventoryAssetCheckListByAccount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InventoryAssetCheckList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TInventoryAssetCheckListByAccountGUI = class(TInventoryAssetCheckListGUI)
  private
  Protected
    Procedure InitformSQL;Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TInventoryAssetCheckListByAccountGUI }

procedure TInventoryAssetCheckListByAccountGUI.InitformSQL;
begin
  inherited;
    Qrymain.sql.add('Select ');
    Qrymain.sql.add('convert(2, UNSIGNED)  as Details ,  ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as TransId, ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as seqno, ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as saleId, ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as POID, ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as paymentId, ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as PrepaymentID, ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as FixedAssetID, ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as SaleLineId, ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as POLineID, ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as PaymentLineID, ');
    Qrymain.sql.add('convert(null, UNSIGNED)  as PrePayLineID,  ');
    Qrymain.sql.add('null as Type,  ');
    Qrymain.sql.add('null as Productname , ');
    Qrymain.sql.add('Accountname as Accountname,   ');
    Qrymain.sql.add('Sum(DebitsEx) as DebitsEx,  ');
    Qrymain.sql.add('Sum(CreditsEx) as CreditsEx ,   ');
    Qrymain.sql.add('Sum(DebitsInc) as DebitsInc,  ');
    Qrymain.sql.add('Sum(CreditsInc) as CreditsInc ,  ');
    Qrymain.sql.add('Sum(if(ifnull(Productname,"")<>"",  DebitsEx  , 0))     as DebitsEx1, ');
    Qrymain.sql.add('Sum(if(ifnull(Productname,"")<>"",  CreditsEx , 0))     as CreditsEx1, ');
    Qrymain.sql.add('Sum(if(ifnull(Productname,"")<>"",  DebitsInc , 0))     as DebitsInc1, ');
    Qrymain.sql.add('Sum(if(ifnull(Productname,"")<>"",  CreditsInc, 0))     as CreditsInc1, ');
    Qrymain.sql.add('Sum(if(ifnull(Productname,"")="",  DebitsEx  , 0))     as DebitsEx2, ');
    Qrymain.sql.add('Sum(if(ifnull(Productname,"")="",  CreditsEx , 0))     as CreditsEx2, ');
    Qrymain.sql.add('Sum(if(ifnull(Productname,"")="",  DebitsInc , 0))     as DebitsInc2, ');
    Qrymain.sql.add('Sum(if(ifnull(Productname,"")="",  CreditsInc, 0))     as CreditsInc2, ');
    Qrymain.sql.add('Sum(DebitsEx -CreditsEx      ) as Ex, ');
    Qrymain.sql.add('Sum(DebitsInc-CreditsInc     ) as Inc,  ');
    Qrymain.sql.add('Sum((if(ifnull(Productname,"")<>"",  DebitsEx  , 0))-(if(ifnull(Productname,"")<>"",  CreditsEx , 0))     ) as Ex1, ');
    Qrymain.sql.add('Sum((if(ifnull(Productname,"")<>"",  DebitsInc , 0))-(if(ifnull(Productname,"")<>"",  CreditsInc, 0))     ) as Inc1, ');
    Qrymain.sql.add('Sum((if(ifnull(Productname,"")="",  DebitsEx  , 0))-(if(ifnull(Productname,"")="",  CreditsEx , 0))     ) as Ex2, ');
    Qrymain.sql.add('Sum((if(ifnull(Productname,"")="",  DebitsInc , 0))-(if(ifnull(Productname,"")="",  CreditsInc, 0))     ) as Inc2 ');
    Qrymain.sql.add('from ' + Tablename +' group by Accountname');
    Qrymain.sql.add('Order by AccountName, Details, ProductName, Type');
end;

initialization
  RegisterClassOnce(TInventoryAssetCheckListByAccountGUI);

end.
