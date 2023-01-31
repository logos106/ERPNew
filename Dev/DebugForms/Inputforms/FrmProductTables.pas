unit FrmProductTables;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, ProgressDialog;
const
  fieldnames : array[1..73] of array[1..2] of String =
(('tblassessmenttypes','ProductID'),
('tblbarcodestoprint','ProductID'),
('tblbuildpartalloc','PartsId'),
('tblcustomercoststransferlines','ProductID'),
('tblcustomerlines','ProductID'),
('tbldefaultrunparts','ProductID'),
('tbldespatchrunlines','ProductID'),
('tblembroiderydetails','ProductID'),
('tblempnocommsproducts','ProductID'),
('tblequipment','ProductId'),
('tblequipmentparts','ProductId'),
('tblextraprice','PartsID'),
('tblextrapricesell','PartsID'),
('tblfesaleslines','ProductID'),
('tblfesaleslinesrelatedprs','ProductID'),
('tblfixedassets','PARTSID'),
('tblforeignprice','PartsID'),
('tblfuncbookingdrinks','ProductID'),
('tblfuncbookingmeals','ProductID'),
('tblhirelines','ProductID'),
('tblhiresaleslines','ProductID'),
('tblintrastatlines','ProductID'),
('tblmanuftemplate','ProductID'),
('tblmarketingcontactproducts','ProductID'),
('tblorderlines','PartID'),
('tblpartbarcodes','PartsID'),
('tblparts','PARTSID'),
('tblpartsnotes','PartsId'),
('tblpartspics','partID'),
('tblpartsspecifications','PartsID'),
('tblpartstemporary','PARTSID'),
('tblpaysemployeeservices','PartID'),
('tblpccproductcode','ProductID'),
('tblpcctanks','ProductID'),
('tblpickingassemblylines','ProductID'),
('tblpicksliplines','PartsID'),
('tblposkeypadcustomize','PartID'),
('tblposlines','ProductID'),
('tblposredeempoints','ProductId'),
('tblpqa','ProductID'),
('tblpricelistitem','ProductID'),
('tblprocess','ProductID'),
('tblprocesspart','PartId'),
('tblproctree','PartsId'),
('tblproctreepart','ProductId'),
('tblproductattributeproducts','ProductID'),
('tblproductclasses','ProductID'),
('tblproductcommission','PartsId'),
('tblproductrewardpoints','PartsId'),
('tblprojectlines','PartsID'),
('tblprojects','ProductID'),
('tblpurchaselines','ProductID'),
('tblrelatedparts','ProductID'),
('tblrepairparts','PartsID'),
('tblrunslines','ProductID'),
('tblsalescommission','ProductID'),
('tblsaleslines','ProductID'),
('tblsaleslines_pos','ProductID'),
('tblsaleslinespoints','ProductID'),
('tblsalesredeempoints','ProductId'),
('tblserialnumbers','ProductId'),
('tblsmartorderlines','PARTSID'),
('tblstockadjustentrylines','ProductID'),
('tblstocklastcostadjustments','ProductID'),
('tblstockmovementlines','ProductID'),
('tblstocktransferentrylines','ProductID'),
('tbltimesheets','PartID'),
('tblunits','PartsID'),
('tblunitsofmeasure','PartID'),
('tblunpacksegproductlines','ProductID'),
('tblwoalloclines','ProductID'),
('tblfePOlines','ProductID'),
('tblfePOlinesrelatedprs','ProductID'));


type
  TFmProductTables = class(TBaseInputGUI)
    Button1: TButton;
    Memo1: TMemo;
    ERPQuery1: TERPQuery;
    Memo2: TMemo;
    Memo3: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, FastFuncs;

{$R *.dfm}

procedure TFmProductTables.Button1Click(Sender: TObject);
var
  i1 :Integer;
  tablename :String;
  fieldname :String;
  found:boolean;
begin
  inherited;
  Memo1.Lines.clear;
  Memo2.Lines.clear;
  for i1:= 1 to 71 do begin
    tablename :=fieldnames[i1,1];
    fieldname :=fieldnames[i1,2];
    closedb(ERPQuery1);
    ERPQuery1.SQl.clear;
    ERPQuery1.SQL.add('Desc '+tablename);
    ERPQuery1.open;
    ERPQuery1.first;
    found:= False;
    while (ERPQuery1.eof = False) and (found =False) do begin
      if (Sysutils.SameText(ERPQuery1.fieldbyname('field').asString , 'Partname')) or
          (Sysutils.SameText(ERPQuery1.fieldbyname('field').asString , 'Partsname')) or
          (Sysutils.SameText(ERPQuery1.fieldbyname('field').asString , 'Parts_name')) or
          (Sysutils.SameText(ERPQuery1.fieldbyname('field').asString , 'Part_name')) or
          (Sysutils.SameText(ERPQuery1.fieldbyname('field').asString , 'Productname')) or
          (Sysutils.SameText(ERPQuery1.fieldbyname('field').asString , 'Product_name')) then begin
          found:= True;
          Memo1.Lines.add('Select ' + ERPQuery1.fieldbyname('field').asString  +', ' + fieldname + ' from ' + tablename +' Where '+ fieldname +' not in (select PartsId from tblParts)');
          continue;
      end;
      ERPQuery1.Next;
    end;
    if not found then begin
        Memo2.Lines.add('Select TT.'+ fieldname + ' as InvalidPartsId, T.PartsId as ValidPartsId '+
                  ' from ' + tablename +' TT inner join tmp_1 T on T.ProductId = TT.' +fieldname +'  Where TT.'+ fieldname +' not in (select PartsId from tblParts)');
    end;
(*    for i2 :=0 to ERPQuery1.fields.Count-1 do
      memo1.Lines.Add(ERPQuery1.fields[i2].fieldname);
    exit;*)
  end;
end;
procedure TFmProductTables.Button2Click(Sender: TObject);
var
  i1 :Integer;
  tablename :String;
  fieldname :String;
begin
  inherited;
  Memo3.Lines.clear;
  for i1:= 1 to 71 do begin
    tablename :=fieldnames[i1,1];
    fieldname :=fieldnames[i1,2];
    Memo3.Lines.add('update  ' + tablename  +' TT inner join tmp_1 t on T.ProductId = TT.'+fieldname +' set TT.'+fieldname +' = T.PartsId;'); 
  end;

end;

initialization
  RegisterClassOnce(TFmProductTables);

end.
