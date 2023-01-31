unit CustomFieldValuesAll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustomFieldValuesAllGUI = class(TCustomFieldValuesBaseGUI)
    qryMainListType: TWideStringField;
  private
  Protected
    Procedure MakeQrymain;Override;
  public
  end;

implementation

uses CommonLib, Busobjcustomfields, LogLib;

{$R *.dfm}

{ TCustomFieldValuesAllGUI }

procedure TCustomFieldValuesAllGUI.MakeQrymain;
var
  ctr:Integer ;
  Function ListtypeforCtr : TListType;
  begin
            if ctr = 1 then REsult := ltContact
      else  if ctr = 2 then REsult := ltRepair
      else  if ctr = 3 then REsult := ltCustomer
      else  if ctr = 4 then REsult := ltSupplier
      else  if ctr = 5 then REsult := ltProducts
      else  if ctr = 6 then REsult := ltEquipment
      else  if ctr = 7 then REsult := ltLeads
      else result := ltNone;
  end;

begin
  closedb(Qrymain);
  Qrymain.sql.clear;
  for ctr := 1 to 7 do begin
    if ctr <> 1 then Qrymain.sql.add('union');
    Qrymain.sql.add('Select');
    Qrymain.sql.add('CFV.ID as ID,');
    Qrymain.sql.add('CFV.masterID as MasterID,');
    Qrymain.sql.add('CFV.masterID as MasterID,');
    Qrymain.sql.add('if(CFL.listtype ="ltContact" ,"Contacts" , '+
                    'if(CFL.listtype ="ltRepair" ,"Repair" ,  '+
                    'if(CFL.listtype ="ltCustomer" ,"Customer" ,  '+
                    'if(CFL.listtype ="ltSupplier" ,"Supplier" ,  '+
                    'if(CFL.listtype ="ltProducts" ,"Products" ,  '+
                    'if(CFL.listtype ="ltEquipment" ,"Equipment" ,  '+
                    'if(CFL.listtype ="ltLeads" ,"Leads" , ""))))))) as ListType,');
    Qrymain.sql.add('M.'+ CustomFieldValueMasterName(ListtypeforCtr) +' as MasterName ,');
    Qrymain.sql.add('CFL.Description as Description ,');
    Qrymain.sql.add('CFV.Value as Value');
    Qrymain.sql.add('from  ' + customFieldValuetable(ListtypeforCtr) +' CFV');
    Qrymain.sql.add('inner join ' + CustomFieldValueMasterTable(ListtypeforCtr)+'  M on CFV.masterId = M.'+ CustomFieldValueMasterID(ListtypeforCtr));
    Qrymain.sql.add('inner join tblCustomfieldList CFL on CFL.CFID =  CFV.CustomFieldlistId and CFL.Listtype = ' + Quotedstr(ListTypetoString(ListtypeforCtr)));
  end;
  Qrymain.sql.add('Order by  MasterName , Description');
  logtext(qrymain.sql.text);
end;
initialization
  RegisterClassOnce(TCustomFieldValuesAllGUI);

end.
