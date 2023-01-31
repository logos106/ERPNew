unit frmExportStockAdjustment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts, Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader,
  DNMPanel, wwdblook, ComCtrls, Grids, Wwdbigrd, Wwdbgrid, DAScript, MyScript;

type
  TfmExportStockAdjustment = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    SaveDialog1: TSaveDialog;
    DNMPanel4: TDNMPanel;
    Letter_Label: TLabel;
    txtFileName: TEdit;
    SpeedButton1: TDNMSpeedButton;
    DNMPanel5: TDNMPanel;
    ClassLabel: TLabel;
    chkallclasses: TCheckBox;
    chkExcludeBinBatch: TCheckBox;
    chkIncludeAllProducts: TCheckBox;
    cboClassQry: TERPQuery;
    cboClass: TwwDBLookupCombo;
    SctMain: TERPScript;
    lblMsg: TLabel;
    chkExcludeInactiveProducts: TCheckBox;
    optQtytype: TRadioGroup;
    lblAdjustmentOnInstock: TLabel;
    PnlMain :TDNMPanel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkallclassesClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure SctMainBeforeExecute(Sender: TObject; var SQL: string; var Omit: Boolean);
  private
    fsSelectedProducts:String;
    ClassID:Integer;
    fGenerateTable: TNotifyEvent;
    Function GenerateTempTable :Boolean ;
    procedure SelectProduct;
    procedure onSelectProduct(Sender: TwwDBGrid);
    procedure ReadnApplyGuiPref;
    Procedure WriteGuiPref;
    Procedure ExportProgressBarStep(const Msg:String='');
    procedure OnExportProgress(const desc: string; const RecNo, RecCount: integer);
    function QtyType:String;
    function getClassId: Integer;
  public
    function DoExport: Boolean;
    Property GenerateTable :TNotifyEvent read fGenerateTable write fGenerateTable;
    Property ExportClassId:Integer read getClassId;
  end;


implementation

uses CommonLib, CommonDbLib, ExportDataObj, AppEnvironment, tcDataUtils, DNMExceptions, ProductQtyLib, CommonFormLib, dateutils, LogLib, BusobjStockAdjustmentExport, tcConst,
  DbSharedObjectsObj;

{$R *.dfm}

procedure TfmExportStockAdjustment.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmExportStockAdjustment.btnOKClick(Sender: TObject);
begin
  if DoExport then begin
            MessageDlgXP_vista('The Stock is exported to ' +quotedstr(txtFileName.text), mtInformation, [mbOK], 0);
            Self.close;
  end;
end;
function TfmExportStockAdjustment.DoExport:Boolean;
var
  Exporter: TDataExporter;
function hasDatatoExport:Boolean;
var
  qry:TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(commondblib.GetSharedMyDacConnection);
  try
    Qry.SQL.Text := 'Select count(*) ctr from tblstockadjustmentimportexport';
    Qry.Open;
    result := Qry.FieldByName('ctr').AsInteger >0;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

end;
begin
  inherited;
  REsult := False;
  if Userlock.Lock('tblstockadjustmentImportExport' , 0) = False then begin
      MessageDlgXP_Vista(replacestr(replacestr(Userlock.LockMessage ,  'Unable to update data.'  , 'Unable Export Stock Adjustment.') , 'is accessing this record' , 'is performing Stock Adjustment Export/Import'), mtWarning, [mbOK], 0);
      Exit;
  end;
  try
     DeleteContentsFromUserTemporaryTable('tblstockadjustmentImportExport');
     try
        Exporter:= TDataExporter.Create;
        try
          Exporter.DataFormat:= dfCSV;
          Exporter.StopOnError:= false;
          Exporter.OnProgress := OnExportProgress;
          lblMsg.Visible := True;
          DoShowProgressbar(35 , WAITMSG );
          try
            ExportProgressBarStep;
            if assigned(fGenerateTable) then fGenerateTable(nil) else GenerateTempTable;
            if not hasDatatoExport then begin
              MessageDlgXP_Vista('As per the selections you have made, there is no data to be exported', mtInformation, [mbOK], 0);
              exit;
            end;
            ExportProgressBarStep;
            Exporter.ExportDataToFile('TStockAdjustmentImportExport',txtFileName.text);
            ExportProgressBarStep;
            DoHideProgressbar; // hide the progressbar before the message, otherwise message goes behin progressbar and u cannot see it
            Result := True;
          finally
            //ExportProgressBar.Position := 0;
            DoHideProgressbar;
            lblMsg.Visible := False;
          end;
        finally
          Exporter.Free;
        end;
     finally
       DeleteContentsFromUserTemporaryTable('tblstockadjustmentImportExport');
     end;
  finally
    Userlock.Unlock('tblstockadjustmentImportExport' , 0);
  end;
end;

procedure TfmExportStockAdjustment.chkallclassesClick(Sender: TObject);
begin
  inherited;
  ClassLabel.enabled := chkallclasses.Checked = False;
  cboClass.enabled   :=chkallclasses.Checked = False;

end;

procedure TfmExportStockAdjustment.ExportProgressBarStep(const Msg: String='');
begin
  (*ExportProgressBar.StepIT;
  lblImporting.Visible := True;
  if Msg <> '' then begin
    lblImporting.caption := Msg;
  end else begin
    lblImporting.Caption  := 'Please Wait Preparing Stock Adjustment .....' + inttostr(ExportProgressBar.Position)+' %';
  end;
  lblImporting.refresh;*)
  DoStepProgressbar(MSG);
end;

procedure TfmExportStockAdjustment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
  action := cafree;
end;

procedure TfmExportStockAdjustment.FormCreate(Sender: TObject);
begin
  fsSelectedProducts := '';
  ClassID := 0;
  fGenerateTable := nil;
  inherited;
end;
procedure TfmExportStockAdjustment.SctMainBeforeExecute(Sender: TObject; var SQL: string; var Omit: Boolean);
begin
  inherited;
  ExportProgressBarStep;//(iif(devmode , copy(SQL ,1,100), ''));
end;

procedure TfmExportStockAdjustment.SelectProduct;
begin
  OpenERPListFormultiselectModal('TProductListExpressGUI' , nil, onSelectProduct)
end;

procedure TfmExportStockAdjustment.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    if AccessLevel <> 1 then begin
      AccessLevel := 6;
    end;
    try
      inherited;
      cboClassQry.Active   := true;
      ClassLabel.Caption   := AppEnv.DefaultClass.ClassHeading +' :';
      chkallclasses.Caption:= 'All ' + AppEnv.DefaultClass.ClassHeading +'(s)';
      cboClass.LookupValue := inttostr(GetDeptID(AppEnv.DefaultClass.DefaultClassName));
      if devmode then if DirectoryExists('D:\temp\to be deleted') then txtFileName.text := 'i:\temp\to be deleted\a1.pdi';
      ReadnApplyGuiPref;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;

end;

Function TfmExportStockAdjustment.GenerateTempTable :Boolean ;
var
  Str:String;
  SAE: TStockAdjustmentImportExport;
begin
  REsult:= False;
  if empty(txtFileName.Text) then SpeedButton1Click(SpeedButton1);
  if empty(txtFileName.Text) then exit;
  if IsDir(ExtractFileDir(txtFileName.Text)) =False then begin
    MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFileName.Text) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
    Exit;
  end;

  str :='The exported file will have the tick option ' +
            '"Show Only as Unit of Measure" turned on.  '+
          'This is only showing the Quantity of the selected Unit of Measure.  It is not '+
          'displaying the Quantity of any other Unit of Measure for this product on this line or row, as it is expecting '+
          'you to count the Quantities separately on a different line or row  ie. If You have 2 Cartons and 8 singles, it will only '+
          'display as 2 Cartons on this line or row.'+chr(13)+chr(13)+
          'The tick option "Adjustment on In-Stock Quantity" will be turned on.  '+
          'This will calculate the values based on the ''In-Stock'' Column  '+
          'ie If you have 100 in stock and 20 on Sales Order, it will base the adjustment on 100.';
    MessageDlgXP_Vista(str , mtInformation , [mbok] , 0);
    fsSelectedProducts:='';
    if    MessageDlgXP_Vista('On the Next Screen the ''Product List'' Will Open. Please Display the Records Using the "F5" Key and Then Filter the List as Required Using the "Right Mouse Click".'
                        +chr(13) +chr(13) +'Do you Wish to Skip the Selection List and Export All Products?',mtConfirmation,[mbNo,mbYes],0) = mrNo then begin
      SelectProduct;
    end;
    if chkallclasses.checked = False then ClassID := cboClass.LookupTable.FieldByname('classID').asInteger else ClassID := 0;
    SAE := TStockAdjustmentImportExport.CreateWithNewConn(Self);
    try
      SAE.Connection.Connection := Self.MyConnection;
      SAE.Load(0);
      //lblImporting.Caption  := 'Please Wait Preparing Stock Adjustment ..... 0%';
      SAE.MakeExportdata(0, iif(chkExcludeBinBatch.checked , tSummary, tDetailswithSno) , chkIncludeAllProducts.checked, chkExcludeInactiveProducts.checked, '' , classID ,  fsSelectedProducts ,'' , '' , SctMainBeforeExecute , QtyType);
    finally
      FreeandNil(SAE);
    end;


    (*SctMain.SQL.Clear;
    try
      SctMain.connection := MyConnection;
        SctMain.SQL.Add('TRuncate table tblstockadjustmentImportExport;');

        if chkallclasses.checked = False then ClassID := cboClass.LookupTable.FieldByname('classID').asInteger else ClassID := 0;

        // list of product list
        SctMain.SQL.Add('insert ignore into tblstockadjustmentImportExport ' +
                    '(PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,' +
                    'PartsDescription,DeptName,Batchnumber,ExpiryDate,BatchExpiryDate,Binlocation,Binnumber,Serialnumber,UOMQty,Qty,InstockUOMQty,InstockQty,Cost,Value) ' +
                    ProductQtyLib.StockQty(False, 0 , 0 , iif(chkExcludeBinBatch.checked , tSummary, tDetailswithSno), incDay(Date), False)+';');

        SctMain.SQL.Add('update tblstockadjustmentImportExport set seqno = 1;');

        SctMain.SQL.Add('update tblstockadjustmentImportExport as tmp ' +
                    ' inner join tblPArts as P on P.PartsID = tmp.PartsId '+
                    ' Set tmp.Active = P.Active , ProductBarCode= P.Barcode ;');

        SctMain.SQL.Add('delete from tblstockadjustmentImportExport where ifnull(DepartmentId,0) = 0;');
        SctMain.SQL.Add('insert IGNORE into tblstockadjustmentImportExport  '+
                    ' (seqno , PartsId , DepartmentID, GLevel , ProductName,  ' +
                    'ProductColumn1, ProductColumn2, ProductColumn3, '+
                    'PartsDescription,DeptName,ProductBarcode,Active)  '+
                    'Select distinct  2, P.PartsId, PC.ClassId,1 , P.PartName  , '+
                    Firstcolumn+ ','+
                    Secondcolumn+ ','+
                    Thirdcolumn+ ','+
                    'PartsDescription,PC.Classname,P.Barcode,P.Active  '+
                    'from tblParts as P '+
                    'inner join tblProductClasses  as PC on  PC.ProductID = P.PartsID '+
                    'Where P.Parttype = "INV" and PC.active = ''T''   '+
                    'and P.PartsID not in (Select PartsId from tblstockadjustmentImportExport  Where DepartmentId = PC.ClassId)'+
                    'and    (PC.classId = ' +IntToStr(classID) +' or ' +IntToStr(classID) +' = 0);');

        SctMain.SQL.Add(ProductUOMSQL('tblstockadjustmentImportExportUOM'));

        SctMain.SQL.Add('update tblstockadjustmentImportExport T  '+
                    ' inner join tblstockadjustmentImportExportUOM as T1 on T.PartsId = T1.PartsId  '+
                    ' Set T.UOMID = T1.PUOMID , T.UOM = T1.PUOM ,T.UOMMultiplier = T1.PMult   '+
                    ' where ifnull(T.UOMID,0) =0;');

        if chkIncludeAllProducts.checked then begin
          SctMain.SQL.Add('Drop table if exists tblstockadjustmentImportExportUOM1;');
          SctMain.SQL.Add('Create table tblstockadjustmentImportExportUOM1 '+
                    'Select distinct '+
                    ' 3, P.PartsId, '+
                    'C.ClassID as DepartmentID,' +
                    'T.PUOMID  as UOMID,' +
                    'T.PUOM as UOM, '+
                    'T.PMult as UOMMultiplier, '+
                    '1 as gLevel, '+
                    'P.Partname as ProductName, '+
                    Firstcolumn + ' as ProductColumn1, '+
                    Secondcolumn+' as ProductColumn2, '+
                    Thirdcolumn +' as ProductColumn3, '+
                    'P.PartsDescription, '+
                    'C.ClassName as Deptname, '+
                    '"" as Batchnumber, '+
                    '0 as ExpiryDate, '+
                    '0 as BatchExpiryDate, '+
                    '"" as Binlocation, '+
                    '"" as  Binnumber, '+
                    '"" as Serialnumber, '+
                    '0 as UOMQty, '+
                    '0 as Qty, '+
                    '0 as InstockUOMQty, '+
                    '0 as InstockQty, '+
                    'AvgCost as Cost, '+
                    '0 as Value, '+
                    'P.Active, '+
                    'P.Barcode '+
                    'from tblclass  C, tblParts as P  '+
                    'inner join tblstockadjustmentImportExportUOM T on P.partsId = T.PartsID '+
                    'Left join  tblstockadjustmentImportExport T1 on ' +
                    ' T.PartsId = T1.partsId  ' +
                    ' and  ifnull(T1.DepartmentID,0)=0  ' +
                    ' and T.PUOM = T1.UOM  ' +
                    ' and T1.gLevel=1  ' +
                    ' and ifnull(T1.Batchnumber,"")=""  ' +
                    ' and ifnull(T1.ExpiryDate,"")=""  ' +
                    ' and ifnull(T1.Binlocation,"")=""  ' +
                    ' and ifnull(T1.Binnumber,"")=""  '+
                    'where  P.Parttype = "INV" and ifnull(T1.PartsId,0)=0 '+
                    'and    (ifnull(C.ClassID,0) = ' +IntToStr(classID) +' or ' +IntToStr(classID) +' = 0);');

          SctMain.SQL.Add('insert IGNORE into tblstockadjustmentImportExport '+
                    '( PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,DeptName,Cost,Active,ProductBarCode) '+
                    ' Select distinct  T.PartsId,T.DepartmentID, T.UOMID,T.UOM,T.UOMMultiplier,T.gLevel,T.ProductName,T.ProductColumn1, '+
                    ' T.ProductColumn2,T.ProductColumn3, T.PartsDescription, T.DeptName, T.Cost,T.Active,T.Barcode '+
                    ' from tblstockadjustmentImportExportUOM1 T '+
                    ' Left join  tblstockadjustmentImportExport T1 on  T.PartsId = T1.partsId    '+
                    ' and  ifnull(T1.DepartmentID,0)= T.DepartmentID   and T.UOM = T1.UOM   and T1.gLevel=1    '+
                    ' and ifnull(T1.Batchnumber,"")=""   and ifnull(T1.ExpiryDate,"")=""   and ifnull(T1.Binlocation,"")=""   and ifnull(T1.Binnumber,"")="" '+
                    ' where  ifnull(T1.PartsId,0)=0;');
          SctMain.SQL.Add('Drop table if exists tblstockadjustmentImportExportUOM1;');
          SctMain.SQL.Add('update tblstockadjustmentImportExport Set AllocFinalcount = UOMQty '+
                        ' Where ifnull(Batchnumber,"")<> ""  '+
                        ' or ifnull(ExpiryDate,0)<> 0  '+
                        ' or ifnull(BatchExpiryDate,"")<> ""  '+
                        ' or ifnull(Binlocation,"")<> ""  '+
                        ' or ifnull(Binnumber,"")<> ""  '+
                        ' or ifnull(Serialnumber,"")<> "" ;');
          SctMain.SQL.Add('update tblstockadjustmentImportExport Set Finalcount = UOMQty '+
                        ' Where ifnull(Batchnumber,"")= ""  '+
                        ' and ifnull(ExpiryDate,0)= 0  '+
                        ' and ifnull(BatchExpiryDate,"")= ""  '+
                        ' and ifnull(Binlocation,"")= ""  '+
                        ' and  ifnull(Binnumber,"")= ""  '+
                        ' and  ifnull(Serialnumber,"")= "" ;');
        end;

        if fsSelectedProducts <> '' then
          SctMain.SQL.Add('Delete from  tblstockadjustmentImportExport where PartsId not in (' + fsSelectedProducts +');');

        clog(SctMain.SQL.Text);
        lblImporting.Caption  := 'Please Wait Preparing Stock Adjustment ..... 0%';
        SctMain.Execute;
    finally
      SctMain.SQL.Clear;
    end;*)
end;

function TfmExportStockAdjustment.getClassId: Integer;
begin
  if chkallclasses.checked then result := 0 else REsult := cboClass.LookupTable.FieldByname('classID').asInteger ;
end;

procedure TfmExportStockAdjustment.OnExportProgress(const desc: string; const RecNo, RecCount: integer);
begin
  DoStepProgressbar('Exporting Data .. ' + inttostr(RecNo) +' / ' + inttostr(RecCount));
end;

procedure TfmExportStockAdjustment.onSelectProduct(Sender: TwwDBGrid);
begin
  { if nothing selected in grid assume user is using filtering so select all .. }
  if Sender.SelectedList.Count = 0 then
    Sender.SelectAll;
  fsSelectedProducts := SelectedIds(Sender , 'PartsID');
end;

function TfmExportStockAdjustment.QtyType: String;
begin
  if optQtytype.ItemIndex <0 then optQtytype.ItemIndex := 1;
  if optQtytype.ItemIndex =0 then result := Adjustment_on_Quantity_type_Instock else result := Adjustment_on_Quantity_type_Available;
end;

procedure TfmExportStockAdjustment.ReadnApplyGuiPref;
begin
    if GuiPrefs.Active = False then GuiPrefs.Active := TRue;
    if GuiPrefs.Node.Exists('Options.ExcludeBinBatch')    then chkExcludeBinBatch.checked     := GuiPrefs.Node['Options.ExcludeBinBatch'].asBoolean;
    if GuiPrefs.Node.Exists('Options.IncludeAllProducts') then chkIncludeAllProducts.checked  := GuiPrefs.Node['Options.IncludeAllProducts'].asBoolean;
    if GuiPrefs.Node.Exists('Options.ExcludeInactiveProducts') then chkExcludeInactiveProducts.checked  := GuiPrefs.Node['Options.ExcludeInactiveProducts'].asBoolean;
    if GuiPrefs.Node.Exists('Options.ExportTofileName')   then txtFileName.text               := GuiPrefs.Node['Options.ExportTofileName'].asString;
    if GuiPrefs.Node.Exists('Options.allclasses')         then chkallclasses.checked          := GuiPrefs.Node['Options.allclasses'].asBoolean;
    opendb(cboClass.LookupTable);
    if GuiPrefs.Node.Exists('Options.ClassID')            then cboClass.LookupTable.Locate('classID' ,GuiPrefs.Node['Options.ClassID'].asInteger , []);
    if GuiPrefs.Node.Exists('Options.Qtytype')            then optQtytype.ItemIndex := iif(GuiPrefs.Node['Options.Qtytype'].asString =Adjustment_on_Quantity_type_Instock , 0, 1);
    if optQtytype.ItemIndex <0 then optQtytype.ItemIndex := 1;
end;

procedure TfmExportStockAdjustment.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if SaveDialog1.Execute then begin
    txtFileName.Text := SaveDialog1.FileName;
  end;

end;

procedure TfmExportStockAdjustment.WriteGuiPref;
begin
    GuiPrefs.Node['Options.ExcludeBinBatch'].asBoolean := chkExcludeBinBatch.checked;
    GuiPrefs.Node['Options.IncludeAllProducts'].asBoolean := chkIncludeAllProducts.checked;
    GuiPrefs.Node['Options.ExcludeInactiveProducts'].asBoolean := chkExcludeInactiveProducts.checked;
    GuiPrefs.Node['Options.ExportTofileName'].asString := txtFileName.text;
    GuiPrefs.Node['Options.allclasses'].asBoolean := chkallclasses.checked;
    if chkallclasses.checked or not(cboClass.LookupTable.active) then GuiPrefs.Node['Options.ClassID'].asInteger  := 0
    else GuiPrefs.Node['Options.ClassID'].asInteger  := cboClass.LookupTable.fieldbyname('classID').asInteger;
    GuiPrefs.Node['Options.Qtytype'].asString  := iif(optQtytype.ItemIndex =0 , Adjustment_on_Quantity_type_Instock , Adjustment_on_Quantity_type_Available);
end;

Initialization
  RegisterClassOnce(TfmExportStockAdjustment);

end.

