unit CustomFieldValuesBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , Busobjcustomfields, CustomFieldBase,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustomFieldValuesBaseGUI = class(TCustomFieldBaseGUI)
    qryMainID: TIntegerField;
    qryMainMasterID: TIntegerField;
    qryMainMasterName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainValue: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
  private


  Protected
    Procedure MakeQrymain;Override;
    procedure SetGridColumns; Override;
    Procedure initform;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, LogLib,  CommonLib, BusObjBase, CommonFormLib;

{$R *.dfm}

{ TCustomFieldValuesBaseGUI }


procedure TCustomFieldValuesBaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
  GrpfilterSupplied := True;
  if classnameis('TCustomFieldValuesAllGUI') then qryMainMasterName.displaylabel :=  'Name'
  else qryMainMasterName.displaylabel :=  CustomFieldValueMasterName;
end;

procedure TCustomFieldValuesBaseGUI.grpFiltersClick(Sender: TObject);
var
  fsFormname :String;
begin
  if not IsFormshown then exit;
  //inherited;
       if grpFilters.Itemindex = 0 then fsFormname := 'TCustomFieldValuesAllGUI'
  else if grpFilters.Itemindex = 1 then fsFormname := 'TCustomFieldValuesContactGUI'
  else if grpFilters.Itemindex = 2 then fsFormname := 'TCustomFieldValuesCustomerGUI'
  else if grpFilters.Itemindex = 3 then fsFormname := 'TCustomFieldValuesEquipmentGUI'
  else if grpFilters.Itemindex = 4 then fsFormname := 'TCustomFieldValuesLeadsGUI'
  else if grpFilters.Itemindex = 5 then fsFormname := 'TCustomFieldValuesProductsGUI'
  else if grpFilters.Itemindex = 6 then fsFormname := 'TCustomFieldValuesReapirsGUI'
  else if grpFilters.Itemindex = 7 then fsFormname := 'TCustomFieldValuesSupplierGUI'
  else exit;

  if Sametext(self.classname  , fsFormname) then exit;

  OpenERpListForm(fsFormname, nil);
  CloseWait;

end;

procedure TCustomFieldValuesBaseGUI.initform;
begin
  inherited;
             if Self.ClassnameIs('TCustomFieldValuesAllGUI'      ) then begin  grpFilters.Itemindex := 0;
    end else if Self.ClassnameIs('TCustomFieldValuesContactGUI'  ) then begin  grpFilters.Itemindex := 1;listtype := ltContact  ;
    end else if Self.ClassnameIs('TCustomFieldValuesCustomerGUI' ) then begin  grpFilters.Itemindex := 2;listtype := ltCustomer ;
    end else if Self.ClassnameIs('TCustomFieldValuesEquipmentGUI') then begin  grpFilters.Itemindex := 3;listtype := ltEquipment ;
    end else if Self.ClassnameIs('TCustomFieldValuesLeadsGUI'    ) then begin  grpFilters.Itemindex := 4;listtype := ltLeads  ;
    end else if Self.ClassnameIs('TCustomFieldValuesProductsGUI' ) then begin  grpFilters.Itemindex := 5;listtype := ltProducts ;
    end else if Self.ClassnameIs('TCustomFieldValuesReapirsGUI'  ) then begin  grpFilters.Itemindex := 6;listtype := ltRepair    ;
    end else if Self.ClassnameIs('TCustomFieldValuesSupplierGUI' ) then begin  grpFilters.Itemindex := 7;listtype := ltSupplier;
    end;
end;

procedure TCustomFieldValuesBaseGUI.MakeQrymain;
begin
  closedb(Qrymain);
  Qrymain.sql.clear;
  Qrymain.sql.add('Select');
  Qrymain.sql.add('CFV.ID as ID,');
  Qrymain.sql.add('CFV.masterID as MasterID,');
  Qrymain.sql.add('M.'+CustomFieldValueMasterName +' as MasterName ,');
  Qrymain.sql.add('CFL.Description as Description ,');
  Qrymain.sql.add(ExtraFeilds);
  Qrymain.sql.add('CFV.Value as Value');
  Qrymain.sql.add('from  ' + customFieldValuetable +' CFV');
  Qrymain.sql.add('inner join ' + CustomFieldValueMasterTable+'  M on CFV.masterId = M.'+ CustomFieldValueMasterID);
  Qrymain.sql.add('inner join tblCustomfieldList CFL on CFL.CFID =  CFV.CustomFieldlistId and CFL.Listtype = ' + Quotedstr(ListTypetoString(ListType)));
  Qrymain.sql.add(ExtraTables);
  Qrymain.sql.add('Order by  MasterName , Description');
  logtext(Qrymain.SQL.Text);
end;

procedure TCustomFieldValuesBaseGUI.RefreshQuery;
begin
  inherited;
  logtext('================================================================================================');
end;

procedure TCustomFieldValuesBaseGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainmasterID.fieldname);
end;


end.
