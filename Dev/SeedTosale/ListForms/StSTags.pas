unit StSTags;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, ERPEDIListBase;

type
  TStSTagsGUI = class(TERPEDIListBaseGUI)
    qryMainID: TIntegerField;
    qryMainPartsId: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainUOMID: TIntegerField;
    qryMainUOM: TWideStringField;
    qryMaingLevel: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductColumn1: TWideStringField;
    qryMainProductColumn2: TWideStringField;
    qryMainProductColumn3: TWideStringField;
    qryMainPartsDescription: TWideStringField;
    qryMainClassname: TWideStringField;
    qryMainBatchnumber: TWideStringField;
    qryMainTruckLoadNo: TWideStringField;
    qryMaincBatchExpiryDate: TWideStringField;
    qryMainBatchExpiryDate: TDateTimeField;
    qryMainbinLocation: TWideStringField;
    qryMainBinnumber: TWideStringField;
    qryMainSerialnumber: TWideStringField;
    qryMainDEscription: TWideStringField;
    qryMainTransdate: TDateTimeField;
    qryMainallocType: TWideStringField;
    qryMainUsedOn: TDateTimeField;
    qryMainTagID: TIntegerField;
    qryMainPlantcount: TIntegerField;
    qryMainSupplier: TWideStringField;
    qryMainSrcSerialnumber: TWideStringField;
    qryMainStsPhase: TWideStringField;
    qryMainStsPhaseDesc: TWideStringField;
    qryMainHasAction: TWideStringField;
    qryMainIsPackageTag: TWideStringField;
    qryMainIsPlantTag: TWideStringField;
    grpExtrafilters: TwwRadioGroup;
    grpPkgFilters: TwwRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); Override;
    procedure grdMainDblClick(Sender: TObject); Override;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fiClassID: Integer;
    fProcessTagOnIterateSelectedRecords: TIterateselectedRecordsCallback ;
    Procedure MakeQrymain;
    procedure PopulateData;
    function getSelectedTag: String;
    function getisSelectedTagAvailable: Boolean;
    function getSelectedProductId: Integer;
    function getSelectedID: Integer;
    procedure onShowfmStsTag(Sender: TObject);
  Protected
    fsTablename :String;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    Procedure DoEDIAutocheck(Sender:TObject); Override;
    function ExtraSQL: String;Virtual;
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
    Property ClassID:Integer read fiClassID write fiClassID;
    Property SelectedTag:String read getSelectedTag;
    Property SelectedProductID :Integer read getSelectedProductId;
    Property SelectedID :Integer read getSelectedID;
    Property isSelectedTagAvailable : Boolean read getisSelectedTagAvailable;
    Property ProcessTagOnIterateSelectedRecords:TIterateselectedRecordsCallback  read fProcessTagOnIterateSelectedRecords write fProcessTagOnIterateSelectedRecords;
    procedure IterateselectedRecords(UseProgressbar: boolean = false; Progressbarcaption: string = ''); Override;
    function AvailableTagsFilter(const FilterForPhase: String=''): String;
    function UnusedTagsFilter(const FilterForPhase: String=''): String;
    function UnusedPkgTagsFilter: String;
    function UsedPkgTagsFilter: String;
    function UsedTagsFilter(const FilterForPhase: String=''): String;
    function WastedTagsFilter(const FilterForPhase: String=''): String;
    function DestroyedTagsFilter(const FilterForPhase: String=''): String;
    Procedure InitDisplayCaption(Const Value:String);
  end;


implementation

uses ProductQtyLib, CommonDbLib, AppEnvironment, BusobjProduct, LogLib,
  CommonLib, CommonFormLib, StSLib;

{$R *.dfm}

{ TStSTagsGUI }


procedure TStSTagsGUI.DoEDIAutocheck(Sender: TObject);
begin
  inherited;
  InitTimers(false);
end;

procedure TStSTagsGUI.FormCreate(Sender: TObject);
begin
  HaveOnlyToDate['As On']:= true;
  MakeQrymain;
  inherited;
  fiClassID := 0;
  fProcessTagOnIterateSelectedRecords := nil;
end;

procedure TStSTagsGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);StepProgressbar('. . .');
  DestroyUserTemporaryTable(fsTablename+'1');StepProgressbar('. . . .');
  DestroyUserTemporaryTable(fsTablename+'2');StepProgressbar('. . . . .');
  DestroyUserTemporaryTable(fsTablename+'3');StepProgressbar('. . . . . .');
  inherited;StepProgressbar('. . . . . . .');
end;

procedure TStSTagsGUI.FormShow(Sender: TObject);
begin
  inherited;
  HasEDIAutocheckProgress := False;
end;

function TStSTagsGUI.getisSelectedTagAvailable: Boolean;
begin
  result := (trim(QrymainSerialnumber.asString)<>'') and
            ((trim(Qrymainalloctype.asString) = 'In-Stock') or (trim(Qrymainalloctype.asString) ='New'));
end;

function TStSTagsGUI.getSelectedID: Integer;
begin
  Result := QrymainId.AsInteger;
end;

function TStSTagsGUI.getSelectedProductId: Integer;
begin
  Result := QrymainPartsId.AsInteger;
end;

function TStSTagsGUI.getSelectedTag: String;
begin
  Result := trim(QrymainSerialnumber.asString);
end;

procedure TStSTagsGUI.grdMainDblClick(Sender: TObject);
begin
  if DoOnGridDataSelect(grdmain) then exit;
  if qrymaintagid.asinteger =0 then begin
      MessageDlgXP_vista('Tag ' + quotedstr(qryMainSerialnumber.asString) + '  is not Assigned to Seed To Sale Yet', mtInformation, [mbOK], 0);
      Exit;
  end;
  inherited;
end;
procedure TStSTagsGUI.onShowfmStsTag(Sender: TObject);
begin

end;

procedure TStSTagsGUI.grpFiltersClick(Sender: TObject);
var
  fsString:String;
  sDeptFilter: string;
begin
  GroupFilterString := '';

  // setting options depending on kind of tags

  // Plant Tags
  if (Sender = grpExtrafilters) and (grpExtrafilters.itemindex =0) then begin
    grpFilters.Visible    := True;
    grpPkgFilters.Visible := False;
  end;

   // Package Tags
  if (Sender = grpExtrafilters) and (grpExtrafilters.itemindex =1) then begin
    grpFilters.Visible    := False;
    grpPkgFilters.Visible := True;
  end;


  if grpExtrafilters.itemindex =0 then begin
     // Plant Tags
     if grpFilters.ItemIndex =0 then GroupFilterString  := UnusedTagsFilter;
     if grpFilters.ItemIndex =1 then GroupFilterString  := AvailableTagsFilter;
     if grpFilters.ItemIndex =2 then GroupFilterString  := UsedTagsFilter;
     if grpFilters.ItemIndex =3 then GroupFilterString  := DestroyedTagsFilter;
     if grpFilters.ItemIndex =4 then GroupFilterString  := WastedTagsFilter;

  end else begin
     // Package Tags
     if grpPkgFilters.ItemIndex =0 then GroupFilterString  := UnusedPkgTagsFilter;
     if grpPkgFilters.ItemIndex =1 then GroupFilterString  := UsedPkgTagsFilter;
  end;


  if grpExtrafilters.itemindex =0 then fsString:= 'PartsId =' + inttostr(StSPlantTagProductID);
  if grpExtrafilters.itemindex =1 then fsString:= 'PartsId =' + inttostr(StSPackageTagProductID);


  if (fsString <> '') and (GroupFilterString <> '') then
    GroupFilterString := '(' + GroupFilterString +') and ( '+ fsString+')';

  if GroupFilterString = '' then
    GroupFilterString := fsString;

  // filter records matching DepartmentID
  if fiClassID > 0 then sDeptFilter :=  '(DepartmentID=' + IntToStr(fiClassID) + ')';

  if Length(sDeptFilter) > 0 then
    if Length(GroupFilterString) = 0 then
      GroupFilterString := sDeptFilter
    else
      GroupFilterString := sDeptFilter + ' and (' + GroupFilterString + ')';

  inherited;
end;

function TStSTagsGUI.AvailableTagsFilter(const FilterForPhase:String = ''):String;
begin
   result :=  'ActiveCount > 0 and alloctype = ' + quotedstr('Used');     //  set Alloctype ="Used" where Alloctype <> "In-Stock" and Alloctype <> "New"
   if FilterForPhase <> '' then
    result := '('+ result +') Or StsPhase =' + quotedstr(FilterForPhase);
end;

function TStSTagsGUI.UnusedPkgTagsFilter: String;
begin
  result :=  'UsedOn IS NULL and alloctype = ' + quotedstr('Not-Used');
end;

function TStSTagsGUI.UnusedTagsFilter(const FilterForPhase: String): String;
begin
   result :=  'alloctype = '  + quotedStr('Not-Used');      // set Alloctype ="Not-Used" where Alloctype = "In-Stock" or  Alloctype = "New"
   if FilterForPhase <> '' then
    result := '('+ result +') Or StsPhase =' + quotedstr(FilterForPhase);
end;

function TStSTagsGUI.UsedPkgTagsFilter: String;
begin
  result :=  'UsedOn IS NOT NULL and alloctype = ' + quotedstr('Used');
end;

function TStSTagsGUI.UsedTagsFilter(const FilterForPhase:String = ''):String;
begin
   result := 'ActiveCount = 0  and alloctype = ' + quotedstr('Used');
   if FilterForPhase <> '' then
    result := '('+ result +') and StsPhase =' + quotedstr(FilterForPhase);
end;

function TStSTagsGUI.DestroyedTagsFilter(const FilterForPhase: String): String;
begin
   result := 'Destroycount > 0';
   if FilterForPhase <> '' then
    result := '('+ result +') and StsPhase =' + quotedstr(FilterForPhase);
end;

function TStSTagsGUI.WastedTagsFilter(const FilterForPhase: String): String;
begin
   result := 'WastedCount > 0';
   if FilterForPhase <> '' then
    result := '('+ result +') and StsPhase =' + quotedstr(FilterForPhase);
end;

procedure TStSTagsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['grpExtrafilters.ItemIndex'].asInteger := grpExtrafilters.ItemIndex + 1;
end;

procedure TStSTagsGUI.InitDisplayCaption(const Value: String);
begin
  TitleLabel.caption := value;
  caption := value;
end;

procedure TStSTagsGUI.IterateselectedRecords(UseProgressbar: boolean;Progressbarcaption: string);
begin
  inherited;

end;

procedure TStSTagsGUI.IterateselectedRecordsCallback(var Abort: boolean;  SelIndex: Integer);
begin
  inherited;
  ProcessTagOnIterateSelectedRecords(Abort,SelIndex);
end;

procedure TStSTagsGUI.MakeQrymain;
begin
  fsTablename := NewTempTableName('StsTags');
  closedb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add('T.*, ');
  Qrymain.SQL.add(' StsPhaseCodetoDesc(T.StsPhase) AS StsPhaseDesc ');
  Qrymain.SQL.add('from '+ fsTablename+' T ');
  Qrymain.SQL.Add('Order by ProductName,Serialnumber');
end;
procedure TStSTagsGUI.PopulateData;
var
  ErrorMsg :String;
begin
  commondblib.ExecuteDBCommand( 'DROP TABLE if EXISTS ' + fstablename +'3; '+
                                ' CREATE TABLE ' + fstablename +'3 ( '+
                                '   partsId int(11) DEFAULT  0, '+
                                '   serialnumber varchar(100) DEFAULT NULL, '+
                                '   pqaid int(11) DEFAULT NULL, '+
                                '   supplierid int(11) DEFAULT  0 '+
                                ' ) ENGINE=MyISAM DEFAULT CHARSET=UTF8;', ErrorMsg);
  With Scriptmain do begin
    SQL.text := StSTagList(fstablename);
    SQL.AdD(ExtraSQL);
  end;
  executewithProgress;
end;
Function TStSTagsGUI.ExtraSQL:String;
begin
    Result := 'update '+fstablename + ' set Alloctype ="Used"     where Alloctype <> "In-Stock" and Alloctype <> "New";' +
              'update '+fstablename + ' set Alloctype ="Not-Used" where Alloctype =  "In-Stock" or  Alloctype  = "New";';
  REsult := result +
           'insert ignore into  ' + fstablename +'3 (partsId , serialnumber , pqaid) Select ' +
                       ' T.partsId, T.serialnumber, MIN(pqa.pqaid) pqaid ' +
                       ' from ' + fstablename +' T ' +
                       ' INNER JOIN tblpqa pqa ON pqa.productId = T.partsID ' +
                       ' INNER JOIN tblpqadetails pqad ON pqa.pqaid = pqad.pqaid AND pqad.value = T.serialnumber AND  pqad.PQAType ="SN" ' +
                       ' GROUP BY T.partsId, T.serialnumber; ' +
           ' UPDATE ' + fstablename +'3 t INNER JOIN tblpqa pqa ON t.pqaid = pqa.pqaid AND pqa.transtype = "TPurchaseOrderLine" INNER JOIN tblpurchaseorders po ON pqa.transid = po.PurchaseOrderID SET T.supplierId = po.ClientID;'+
           ' update ' + fstablename +' T1 inner join ' + fstablename +'3 T2 on T1.partsId = t2.partsId and t1.Serialnumber = t2.serialnumber Set T1.supplierId = T2.supplierid;'+
           ' update ' + fstablename +' T inner join tblclients  C on C.clientId = T.supplierid Set T.Supplier = C.company;';

end;
procedure TStSTagsGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
  if GuiPrefs.Node.Exists('grpExtrafilters') then begin
        x := GuiPrefs.Node['grpExtrafilters.ItemIndex'].asInteger;
        if x > 0 then if grpExtrafilters.Items.Count >= x then grpExtrafilters.ItemIndex := x - 1;
  end;
end;

procedure TStSTagsGUI.RefreshQuery;
begin
  PopulateData;
  inherited;
end;

procedure TStSTagsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainPartsId.fieldname);
  RemoveFieldfromGrid(qryMainDepartmentID.fieldname);
  RemoveFieldfromGrid(qryMainUOMID.fieldname);
  RemoveFieldfromGrid(qryMaingLevel.fieldname);
  RemoveFieldfromGrid(qryMainTagID.fieldname);
  RemoveFieldfromGrid(qryMainBatchExpiryDate.fieldname);
  RemoveFieldfromGrid(qryMainStsPhase.fieldname);
  RemoveFieldfromGrid(qryMainHasAction.fieldname);
end;

initialization
  RegisterClassOnce(TStSTagsGUI);

end.
