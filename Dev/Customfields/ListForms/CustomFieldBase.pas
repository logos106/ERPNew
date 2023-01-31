unit CustomFieldBase;
{
TCustomFieldBaseGUI
  |---TCustomFieldValuesBaseGUI
      |------TCustomFieldValuesAllGUI
      |------TCustomFieldValuesLeadsGUI
      |------TCustomFieldValuesContactGUI
      |------TCustomFieldValuesListRepairsGUI
      |------TCustomFieldValuesSupplierGUI
      |------TCustomFieldValuesProductsGUI
      |------TCustomFieldValuesCustomerGUI
      |------TCustomFieldValuesEquipmentGUI
  |---TCustomFieldValuesListBaseGUI
      |------TCustomFieldValuesListLeadsGUI
      |------TCustomFieldValuesListProductGUI
      |------TCustomFieldValuesListRepairsGUI
      |------TCustomFieldValuesListSupplierGUI
      |------TCustomFieldValuesListContactGUIS
      |------TCustomFieldValuesListCustomerGUI
      |------TCustomFieldValuesListEquipmentGUI

  }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , Busobjcustomfields , BaseListExpress,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustomFieldBaseGUI = class(TBaseListExpressGUI)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnExpressDetailClick(Sender: TObject);
  private
    fListtype: TListType;
    btnSearch :TObject;
    procedure setListtype(const Value: TListType);
  Protected
    Procedure MakeQrymain;Virtual;Abstract;
    function ExtraFeilds: String;Virtual;
    function ExtraTables: String;Virtual;
    Procedure initform;Virtual;
    function CustomFieldValueMastertype(aListType : TListType = ltNone): TPersistentClass; Virtual;
    function CustomFieldValuetype(aListType : TListType = ltNone): TPersistentClass;Virtual;
    function CustomFieldValueMasterTable(aListType : TListType = ltNone) :String;Virtual;
    Function customFieldValuetable      (aListType : TListType = ltNone) :String;Virtual;
    function CustomFieldValueMasterName (aListType : TListType = ltNone) :String;Virtual;
    function CustomFieldValueMasterID   (aListType : TListType = ltNone):String;Virtual;
    Function ExpressDetailListName:String;Override;
    Procedure CopyParamsto(Sender:TObject);Override;

  public
    Property Listtype : TListType read fListtype write setListtype;
    Procedure RefreshQuery;Override;
    Constructor Create(AOwner:TComponent);Override;
  end;

implementation

uses BusObjContact, BusObjRepairs, BusObjClient, BusobjProduct,
  BusObjEquipment, BusObjMarketingLeads, BusObjBase, CommonFormLib, LogLib,
  CustomFieldValuesListBase, CustomFieldValuesBase;

{$R *.dfm}

{ TCustomFieldBaseGUI }

procedure TCustomFieldBaseGUI.btnExpressDetailClick(Sender: TObject);
begin
  btnSearch := sender;
  try
    inherited;
  finally
    btnSearch := nil;
  end;

end;

procedure TCustomFieldBaseGUI.cmdNewClick(Sender: TObject);
begin
  btnSearch := sender;
  try
    btnExpressDetailClick(Sender);
  finally
    btnSearch := nil;
  end;

end;

procedure TCustomFieldBaseGUI.CopyParamsto(Sender: TObject);
begin
  inherited;
  if self is TCustomFieldValuesBaseGUI then
    TCustomFieldValuesListBaseGUI(sender).grpfilters.itemindex := self.grpfilters.Itemindex-1
  else if self is TCustomFieldValuesListBaseGUI then
    TCustomFieldValuesListBaseGUI(sender).grpfilters.itemindex := self.grpfilters.Itemindex+1;
end;

constructor TCustomFieldBaseGUI.Create(AOwner: TComponent);
begin
  inherited;
             if Self.ClassnameIs('TCustomFieldValuesAllGUI'      ) then begin  Self.Caption := 'Customisable List - All';
    end else if Self.ClassnameIs('TCustomFieldValuesContactGUI'  ) then begin  Self.Caption := 'Customisable List - Contact';
    end else if Self.ClassnameIs('TCustomFieldValuesCustomerGUI' ) then begin  Self.Caption := 'Customisable List - Customer';
    end else if Self.ClassnameIs('TCustomFieldValuesEquipmentGUI') then begin  Self.Caption := 'Customisable List - Equipment';
    end else if Self.ClassnameIs('TCustomFieldValuesLeadsGUI'    ) then begin  Self.Caption := 'Customisable List - Leads';
    end else if Self.ClassnameIs('TCustomFieldValuesProductsGUI' ) then begin  Self.Caption := 'Customisable List - Products';
    end else if Self.ClassnameIs('TCustomFieldValuesListRepairsGUI'  ) then begin  Self.Caption := 'Customisable List - Repairs';
    end else if Self.ClassnameIs('TCustomFieldValuesSupplierGUI' ) then begin  Self.Caption := 'Customisable Fields - Suppliers';
    end else if Self.ClassnameIs('TCustomFieldValuesListContactGUI'  ) then begin  Self.Caption := 'Customisable Fields - Contact';
    end else if Self.ClassnameIs('TCustomFieldValuesListCustomerGUI' ) then begin  Self.Caption := 'Customisable Fields - Customer';
    end else if Self.ClassnameIs('TCustomFieldValuesListEquipmentGUI') then begin  Self.Caption := 'Customisable Fields - Equipment';
    end else if Self.ClassnameIs('TCustomFieldValuesListLeadsGUI'    ) then begin  Self.Caption := 'Customisable Fields - Leads';
    end else if Self.ClassnameIs('TCustomFieldValuesListProductGUI'  ) then begin  Self.Caption := 'Customisable Fields - Products';
    end else if Self.ClassnameIs('TCustomFieldValuesListRepairsGUI'  ) then begin  Self.Caption := 'Customisable Fields - Repairs';
    end else if Self.ClassnameIs('TCustomFieldValuesListSupplierGUI' ) then begin  Self.Caption := 'Customisable Fields - Suppliers';
    end;
    TitleLabel.Caption := Caption ;
end;

function TCustomFieldBaseGUI.CustomFieldValueMasterID   (aListType : TListType = ltNone): String;
begin
  result := TDatasetBusObjClass(CustomFieldValueMastertype(aListType)).GetIDField            ;
  Logtext(Self.classname +'.CustomFieldValueMasterID:' + Result);
end;
function TCustomFieldBaseGUI.CustomFieldValueMasterName (aListType : TListType = ltNone): String;
begin
  result := TDatasetBusObjClass(CustomFieldValueMastertype(aListType)).GetKeyStringField     ;
  if pos(',' , REsult)>0 then result := copy(result , 1 ,pos(',' , REsult)-1);
  if result = '' then result := 'GlobalRef';
  //if Tableprefix <> '' then REsult := Tableprefix + replacestr(Result , ',' , ','+Tableprefix);
  Logtext(Self.classname +'.CustomFieldValueMasterName:' + Result);
end;

function TCustomFieldBaseGUI.CustomFieldValueMasterTable(aListType : TListType = ltNone): String;
begin
  result := TDatasetBusObjClass(CustomFieldValueMastertype(aListType)).GetBusObjectTablename ;
  Logtext(Self.classname +'.CustomFieldValueMasterTable:' + Result);
end;
function TCustomFieldBaseGUI.customFieldValuetable      (aListType : TListType = ltNone): String;
begin
  result := TDatasetBusObjClass(CustomFieldValuetype(aListType)).GetBusObjectTablename       ;
  Logtext(Self.classname +'.customFieldValuetable:' + Result);
end;

function TCustomFieldBaseGUI.CustomFieldValueMastertype(aListType: TListType): TPersistentClass;
begin
  if aListType = ltNone then aListType :=listtype;

        if aListType = ltContact   then Result := TContact
  else  if aListType = ltRepair    then Result := TRepairs
  else  if aListType = ltCustomer  then Result := TCustomer
  else  if aListType = ltSupplier  then Result := TSupplier
  else  if aListType = ltProducts  then Result := TProductsimple
  else  if aListType = ltEquipment then Result := TEquipment
  else  if aListType = ltLeads     then Result := TLeads
  else begin
    Result := nil;
  end;

end;

function TCustomFieldBaseGUI.CustomFieldValuetype(aListType: TListType): TPersistentClass;
begin
  if aListType = ltNone then aListType :=listtype;

        if aListType = ltContact   then Result := TContactCustomFieldValues
  else  if aListType = ltRepair    then Result := TRepairCustomFieldValues
  else  if aListType = ltCustomer  then Result := TCustomerCustomFieldValues
  else  if aListType = ltSupplier  then Result := TSupplierCustomFieldValues
  else  if aListType = ltProducts  then Result := TProductCustomFieldValues
  else  if aListType = ltEquipment then Result := TEquipmentCustomfieldValues
  else  if aListType = ltLeads     then Result := TLeadCustomfieldValues
  else Result := nil;

end;

function TCustomFieldBaseGUI.ExpressDetailListName: String;
begin
  if btnSearch  = nil then begin
    REsult := Self.classname;
  end else if btnSearch  = btnExpressDetail then begin
           if Self.classnameis('TCustomFieldValuesAllGUI'       ) then result := Self.classname
      else if Self.classnameis('TCustomFieldValuesLeadsGUI'     ) then result := 'TCustomFieldValuesListLeadsGUI'
      else if Self.classnameis('TCustomFieldValuesContactGUI'   ) then result := 'TCustomFieldValuesListContactGUI'
      else if Self.classnameis('TCustomFieldValuesReapirsGUI'   ) then result := 'TCustomFieldValuesListRepairsGUI'
      else if Self.classnameis('TCustomFieldValuesSupplierGUI'  ) then result := 'TCustomFieldValuesListSupplierGUI'
      else if Self.classnameis('TCustomFieldValuesProductsGUI'  ) then result := 'TCustomFieldValuesListProductGUI'
      else if Self.classnameis('TCustomFieldValuesCustomerGUI'  ) then result := 'TCustomFieldValuesListCustomerGUI'
      else if Self.classnameis('TCustomFieldValuesEquipmentGUI' ) then result := 'TCustomFieldValuesListEquipmentGUI'


      else if Self.classnameis('TCustomFieldValuesListLeadsGUI'     ) then result := 'TCustomFieldValuesLeadsGUI'
      else if Self.classnameis('TCustomFieldValuesListProductGUI'   ) then result := 'TCustomFieldValuesProductsGUI'
      else if Self.classnameis('TCustomFieldValuesListRepairsGUI'   ) then result := 'TCustomFieldValuesReapirsGUI'
      else if Self.classnameis('TCustomFieldValuesListSupplierGUI'  ) then result := 'TCustomFieldValuesSupplierGUI'
      else if Self.classnameis('TCustomFieldValuesListContactGUI'   ) then result := 'TCustomFieldValuesContactGUI'
      else if Self.classnameis('TCustomFieldValuesListCustomerGUI'  ) then result := 'TCustomFieldValuesCustomerGUI'
      else if Self.classnameis('TCustomFieldValuesListEquipmentGUI' ) then result := 'TCustomFieldValuesEquipmentGUI'

      else result := Self.classname;
  end else if btnSearch  = CmdNew then begin
             if Self.ClassnameIs('TCustomFieldValuesCustomerGUI' ) or Self.ClassnameIs('TCustomFieldValuesListCustomerGUI' ) then begin  result :=  'TCustomerExpressListGUI';
    end else if Self.ClassnameIs('TCustomFieldValuesEquipmentGUI') or Self.ClassnameIs('TCustomFieldValuesListEquipmentGUI') then begin  result := 'TEquipmentListGUI';
    end else if Self.ClassnameIs('TCustomFieldValuesLeadsGUI'    ) or Self.ClassnameIs('TCustomFieldValuesListLeadsGUI'    ) then begin  Result := 'TMarketingLeadsGUI';
    end else if Self.ClassnameIs('TCustomFieldValuesProductsGUI' ) or Self.ClassnameIs('TCustomFieldValuesListProductGUI'  ) then begin  Result := 'TProductListExpressGUI';
    end else if Self.ClassnameIs('TCustomFieldValuesReapirsGUI'  ) or Self.ClassnameIs('TCustomFieldValuesListRepairsGUI'  ) then begin  REsult := 'TRepairSummaryGUI';
    end else if Self.ClassnameIs('TCustomFieldValuesSupplierGUI' ) or Self.ClassnameIs('TCustomFieldValuesListSupplierGUI' ) then begin  Result := 'TSupplierExpressListGUI';
    end;
  end else begin
    REsult := Self.classname;
  end;
end;

procedure TCustomFieldBaseGUI.FormCreate(Sender: TObject);
begin
  btnSearch := nil;
       if self is TCustomFieldValuesListBaseGUI then btnExpressDetail.caption := 'Customisable List'
  else if self is TCustomFieldValuesBaseGUI     then btnExpressDetail.caption := 'Customisable Fields';
  HaveDateRangeSelection := False;

  initform;
  MakeQrymain;
  inherited;
  btnExpressDetail.parent := Panel3;
  btnExpressDetail.enabled := not ( Self.ClassnameIs('TCustomFieldValuesAllGUI'      ) or
                          Self.ClassnameIs('TCustomFieldValuesContactGUI'  ) or
                          Self.ClassnameIs('TCustomFieldValuesListContactGUI'  ));

end;

procedure TCustomFieldBaseGUI.FormShow(Sender: TObject);
begin
  inherited;
  initform;
  logtext(self.classname +':' + inttostr(grpFilters.Itemindex));
  CmdNew.Enabled :=not ( Self.ClassnameIs('TCustomFieldValuesAllGUI'      ) or
                          Self.ClassnameIs('TCustomFieldValuesContactGUI'  ) or
                          Self.ClassnameIs('TCustomFieldValuesListContactGUI'  ));
end;

procedure TCustomFieldBaseGUI.initform;
begin
end;

procedure TCustomFieldBaseGUI.RefreshQuery;
begin
  clog(Qrymain.SQL.Text);
  inherited;
end;

procedure TCustomFieldBaseGUI.setListtype(const Value: TListType);
begin
  fListtype := Value;
end;
function TCustomFieldBaseGUI.ExtraTables:String;begin result :='';end;
Function TCustomFieldBaseGUI.ExtraFeilds:String;begin result :='';end;


end.
