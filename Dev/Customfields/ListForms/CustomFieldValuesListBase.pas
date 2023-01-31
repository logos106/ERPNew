unit CustomFieldValuesListBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustomFieldValuesListBaseGUI = class(TCustomFieldBaseGUI)
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function TablePrefix:String;
  Protected
    fstablename :String;
    procedure SetGridColumns; Override;
    procedure MakeQrymain(const Fields : String; Tables: String);Overload;Virtual;Abstract;
    Procedure initform;Override;
    Procedure AddtoQrymainsql;Virtual;
  public
  end;


implementation

uses LogLib, CustomFieldListLib, CommonFormLib, Busobjcustomfields, CommonDbLib;

{$R *.dfm}

{ TCustomFieldValuesListBaseGUI }

procedure TCustomFieldValuesListBaseGUI.AddtoQrymainsql;
begin
//
end;

procedure TCustomFieldValuesListBaseGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName(TablePrefix);
  Qrymain.sql.clear;
  Qrymain.sql.add('Select');
  Qrymain.sql.add('*');
  Qrymain.sql.add('from ' + fstablename );
  AddtoQrymainsql;
  inherited;

end;

procedure TCustomFieldValuesListBaseGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;

end;

procedure TCustomFieldValuesListBaseGUI.grpFiltersClick(Sender: TObject);
var
  fsFormname :String;
begin
  if not IsFormshown then exit;
    if (Sender is TRadioGroup) and (sametext(TRadioGroup(Sender).name ,'grpExtraFilters'))   then begin
      inherited grpFiltersClick(Sender);
      exit;
    end;

  //inherited;
       if grpFilters.Itemindex = 0 then fsFormname := 'TCustomFieldValuesListContactGUI'
  else if grpFilters.Itemindex = 1 then fsFormname := 'TCustomFieldValuesListCustomerGUI'
  else if grpFilters.Itemindex = 2 then fsFormname := 'TCustomFieldValuesListEquipmentGUI'
  else if grpFilters.Itemindex = 3 then fsFormname := 'TCustomFieldValuesListLeadsGUI'
  else if grpFilters.Itemindex = 4 then fsFormname := 'TCustomFieldValuesListProductGUI'
  else if grpFilters.Itemindex = 5 then fsFormname := 'TCustomFieldValuesListRepairsGUI'
  else if grpFilters.Itemindex = 6 then fsFormname := 'TCustomFieldValuesListSupplierGUI'
  else exit;
  if Sametext(self.classname  , fsFormname) then Exit;

(*  if Sametext(self.classname  , fsFormname) then begin
    if sametext(classname , 'TCustomFieldValuesListContactGUI') and sametext(fsformname , 'TCustomFieldValuesListContactGUI') and (Sender is TRadioGroup) and (sametext(TRadioGroup(Sender).name ,'grpExtraFilters'))   then
      inherited grpFiltersClick(Sendwer);
    exit;
  end;*)

  OpenERpListForm(fsFormname, nil);
  CloseWait;

end;

procedure TCustomFieldValuesListBaseGUI.SetGridColumns;
begin
  inherited;

end;

function TCustomFieldValuesListBaseGUI.TablePrefix: String;
begin
             if Self.ClassnameIs('TCustomFieldValuesListContactGUI'  ) then begin  Result := 'cfvContact';
    end else if Self.ClassnameIs('TCustomFieldValuesListCustomerGUI' ) then begin  Result := 'cfvCustomer';
    end else if Self.ClassnameIs('TCustomFieldValuesListEquipmentGUI') then begin  Result := 'cfvEquip';
    end else if Self.ClassnameIs('TCustomFieldValuesListLeadsGUI'    ) then begin  Result := 'cfvLead';
    end else if Self.ClassnameIs('TCustomFieldValuesListProductGUI'  ) then begin  Result := 'cfvProduct';
    end else if Self.ClassnameIs('TCustomFieldValuesListRepairsGUI'  ) then begin  Result := 'cfvRepair';
    end else if Self.ClassnameIs('TCustomFieldValuesListSupplierGUI' ) then begin  Result := 'cfvSupplier';
    end else begin Result := 'cfvmisc';
    end;
end;

procedure TCustomFieldValuesListBaseGUI.initform;
begin
  inherited;

             if Self.ClassnameIs('TCustomFieldValuesListContactGUI'  ) then begin  grpFilters.Itemindex := 0;listtype := ltContact  ;
    end else if Self.ClassnameIs('TCustomFieldValuesListCustomerGUI' ) then begin  grpFilters.Itemindex := 1;listtype := ltCustomer ;
    end else if Self.ClassnameIs('TCustomFieldValuesListEquipmentGUI') then begin  grpFilters.Itemindex := 2;listtype := ltEquipment ;
    end else if Self.ClassnameIs('TCustomFieldValuesListLeadsGUI'    ) then begin  grpFilters.Itemindex := 3;listtype := ltLeads  ;
    end else if Self.ClassnameIs('TCustomFieldValuesListProductGUI'  ) then begin  grpFilters.Itemindex := 4;listtype := ltProducts ;
    end else if Self.ClassnameIs('TCustomFieldValuesListRepairsGUI'  ) then begin  grpFilters.Itemindex := 5;listtype := ltRepair    ;
    end else if Self.ClassnameIs('TCustomFieldValuesListSupplierGUI' ) then begin  grpFilters.Itemindex := 6;listtype := ltSupplier;
    end;

end;

end.
