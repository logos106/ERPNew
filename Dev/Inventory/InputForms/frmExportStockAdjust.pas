unit frmExportStockAdjust;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DNMSpeedButton, DB,  ComCtrls,AdvOfficeStatusBar, ExtCtrls, BaseInputForm, DNMPanel,
  wwdblook, MemDS, DBAccess, MyAccess,ERPdbComponents, DataState, SelectionDialog, AppEvnts,
  Menus, AdvMenus, Shader, ImgList, daScript, ProgressDialog, Wwdbigrd, Grids,
  Wwdbgrid;


type
  TfrmExportStockAdjustGUI = class(TBaseInputGUI)
    Label14: TLabel;
    lblImporting: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    ExportProgressBar: TProgressBar;
    SpeedButton1: TDNMSpeedButton;
    txtFileName: TEdit;
    Letter_Label: TLabel;
    SaveDialog1: TSaveDialog;
    Bevel2: TBevel;
    cboClassQry: TERPQuery;
    cboClassSrc: TDataSource;
    DNMPanel1: TDNMPanel;
    cboClass: TwwDBLookupCombo;
    ClassLabel: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkExcludeBinBatch: TCheckBox;
    Label1: TLabel;
    chkallclasses: TCheckBox;
    Label2: TLabel;
    chkIncludeAllProducts: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkallclassesClick(Sender: TObject);
    (*procedure btnExportClick(Sender: TObject);*)
  private
    F: TextFile;
    fsSelectedProducts:String;
    function IsDir(const DirPath: string): boolean;
    function MakeDataLine(const TypeStr: string;Qry :TERPQuery): string;
    function MakeHeaderLine(const TypeStr, TypeStr2, TypeStr3: string): string;
    procedure MakeExportFile(const FileName: string);
    procedure CloseExportFile;
    procedure AddLinetoFile(const StrData: string);
    function GetClassID(const ClassName: string): string;
    procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
    Procedure SelectProduct;
    procedure onSelectProduct(Sender: TwwDBGrid);
  public
    { Public declarations }
  end;



implementation

uses FastFuncs, DNMExceptions, CommonDbLib, { VerifyFunctionsObj, }
  CommonLib, AppEnvironment, MySQLConst, BusobjStockAdjustEntry, ProductQtyLib, dateUtils,
  tcDataUtils, LogThreadLib, tcConst, CommonFormLib;

{$R *.DFM}


procedure TfrmExportStockAdjustGUI.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

function TfrmExportStockAdjustGUI.IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;

procedure TfrmExportStockAdjustGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TfrmExportStockAdjustGUI.onSelectProduct(Sender :TwwDBGrid);
begin
  Sender.SelectAll;
  fsSelectedProducts := SelectedIds(Sender , 'PartsID');
end;
procedure TfrmExportStockAdjustGUI.SelectProduct;
begin
  OpenERPListFormultiselectModal('TProductListExpressGUI' , nil, onSelectProduct)
end;

procedure TfrmExportStockAdjustGUI.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if SaveDialog1.Execute then begin
    txtFileName.Text := SaveDialog1.FileName;
  end;
end;

procedure TfrmExportStockAdjustGUI.AddLinetoFile(const StrData: string);
begin
  {$I-}
  Writeln(F, StrData);
  IOResult;
  {$I+}
end;

procedure TfrmExportStockAdjustGUI.MakeExportFile(const FileName: string);
begin
  {$I-}
  AssignFile(F, FileName);
  Rewrite(F);
  IOResult;
  {$I+}
end;

procedure TfrmExportStockAdjustGUI.CloseExportFile;
begin
  {$I-}
  Flush(F);
  CloseFile(F);
  IOResult;
  {$I+}
end;


function TfrmExportStockAdjustGUI.MakeHeaderLine(const TypeStr, TypeStr2, TypeStr3: string): string;
begin
  if not Empty(TypeStr) and not Empty(TypeStr2) and not Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9) + ReplaceStr(TypeStr2, ',', #9) + ReplaceStr(TypeStr3, ',', #9);
  end else if not Empty(TypeStr) and not Empty(TypeStr2) and Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9) + ReplaceStr(TypeStr2, ',', #9);
  end else if not Empty(TypeStr) and Empty(TypeStr2) and Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9);
  end;
end;

function TfrmExportStockAdjustGUI.MakeDataLine(const TypeStr: string; Qry :TERPQuery): string;
var
  TempStr, aFieldname: string;
  I: integer;
  aField:Tfield;
begin
  TempStr := '';
  with Qry do begin
    TempStr := TypeStr + #9;
    for I := 1 to CharCounter(',', STOCKADJUSTEXPORTFIELDNAMES) do begin
      aFieldname := SubStr(STOCKADJUSTEXPORTFIELDNAMES,',', i);

      if Sysutils.SameText(afieldName,'ExpiryDate') then afieldNAme := 'BatchExpiryDate';
      if ((Sysutils.SameText(aFieldName , 'Finalcount')) and
          (FieldByname('Batchnumber').asString = '') and
          (FieldByname('SerialNumber').asString = '') and
          (FieldByname('BinLocation').asString = '')) or {headerrecord}
      ((Sysutils.SameText(aFieldName , 'BinBatchFinalcount')) and
          ((FieldByname('Batchnumber').asString <> '') or
          (FieldByname('Serialnumber').asString <> '') or
          (FieldByname('BinLocation').asString <> ''))) then {detail record}
          afieldName := 'InstockUOMQty';
      aField:= Qry.Findfield(aFieldName);
      if sameText(afieldname, 'PartsDescription') then
        TempStr := TempStr + replacestr(trim(afield.AsString) , #13#10{chr(13)},' ' ) + #9
      else if (not Assigned(aField)) or (Sysutils.SameText(aFieldName , 'Qty')) or
        ((Sysutils.SameText(afieldNAme , 'BatchExpiryDate')) and (FieldByname('Batchnumber').asString='')) then begin
        if Sysutils.SameText(afieldName , 'Active') then TempStr := TempStr + 'T' + #9
        else TempStr := TempStr + #9;
      end else begin
        if (afield.DataType = ftDate) or (afield.DataType = ftDateTime) then begin
          if (*(Sysutils.SameText(afield.fieldName , 'ExpiryDate')) and*) (afield.IsNull ) then
              TempStr := TempStr + #9
          else TempStr := TempStr + FormatDateTime(MysqlDateFormat, afield.AsDateTime) + #9;
        end else begin
          TempStr := TempStr + afield.AsString + #9;
        end;
      end;
    end;
  end;
  Result := Copy(TempStr, 0, char_length(TempStr) - 1)
end;

procedure TfrmExportStockAdjustGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    if AccessLevel <> 1 then begin
      AccessLevel := 6;
    end;
    try
      inherited;
      cboClassQry.Active   := true;
      ClassLabel.Caption   := AppEnv.DefaultClass.ClassHeading;
      cboClass.LookupValue := GetClassID(AppEnv.DefaultClass.DefaultClassName);
    {$IFNDEF DevMode}
        if DirectoryExists('c:\temp\sae') then txtFileName.text := 'c:\temp\sae\a1.pdi';
    {$ENDIF}
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

function TfrmExportStockAdjustGUI.GetClassID(const ClassName: string): string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT ClassID FROM tblclass Where ClassName="' + ClassName + '";');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('ClassID').AsString;
    end else begin
      Result := '0';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;


procedure TfrmExportStockAdjustGUI.btnOKClick(Sender: TObject);
var
  qry: TERPQuery;
  script: TERPScript;
  tmp_name, str :String;
  I, LinesCount: integer;
  classID:Integer;
  StartPos: integer;

  Procedure GenerateTempTable;
  var
    SQLList:TStringList;
  begin
    SQLList:=TStringList.create;
    try


        SQLList.add('Drop table if Exists ' + tmp_name+';');
        SQLList.add('Create table ' +tmp_Name +' type = MYISAM '  );
        if chkallclasses.checked = False then ClassID := cboClass.LookupTable.FieldByname('classID').asInteger;
        SQLList.Add(ProductQtyLib.StockQty(False, 0 , 0 , tDetailswithSno, incDay(Date), False));
        //SQLList.Add(ProductQtyLib.StockQtywisno(False, 0 , 0 , tDetailswithSno, incDay(Date)));

        SQLList[SQLList.Count -1]:= SQLList[SQLList.Count -1] + ';';

        SQLList.Add('ALTER TABLE ' +tmp_name );
        SQLList.add(' ADD column `Active` Enum("T","F") Default "F",');
        SQLList.add(' ADD column Seqno int(11),');
        SQLList.add(' ADD column ProductBarCode varChar(255),');
        SQLList.Add(' ADD UNIQUE `uniqueind`(`PartsId`, `DepartmentID`, `UOM`, `gLevel`, `Batchnumber`, `ExpiryDate`, `Binlocation`, `Binnumber`), ');
        SQLList.Add(' ADD INDEX `PartsID`(`PartsId`), ');
        SQLList.Add(' ADD INDEX `DeaprtmentID`(`DepartmentID`);');

        SQLList.Add('update  ' +tmp_name +' set seqno = 1;');

        SQLList.add('update  ' + tmp_name + ' as tmp ' +
                    ' inner join tblPArts as P on P.PartsID = tmp.PartsId '+
                    ' Set tmp.Active = P.Active , ProductBarCode= P.Barcode ;');

        SQLList.Add('delete from ' + tmp_name +' where ifnull(DepartmentId,0) = 0;');
        SQLList.Add('insert IGNORE into ' + tmp_name );
        SQLList.Add('(seqno , PartsId , DepartmentID, GLevel , ProductName, ');
        SQLList.Add('ProductColumn1, ProductColumn2, ProductColumn3, ');
        SQLList.Add('PartsDescription,Classname,ProductBarcode,Active)');
        SQLList.Add('Select distinct  2, P.PartsId, PC.ClassId,1 , P.PartName  ,');
        SQLList.Add(Firstcolumn+ ',');
        SQLList.Add(Secondcolumn+ ',');
        SQLList.Add(Thirdcolumn+ ',');
        SQLList.Add('PartsDescription,PC.Classname,P.Barcode,P.Active');
        SQLList.Add('from tblParts as P');
        SQLList.Add('inner join tblProductClasses  as PC on  PC.ProductID = P.PartsID');
        SQLList.Add('Where P.Parttype = "INV" and PC.active = ''T'' ');
        SQLList.Add('and P.PartsID not in (Select PartsId from ' + tmp_name +'  Where DepartmentId = PC.ClassId)');
        if classId <> 0 then
          SQLList.Add('and    PC.classId = ' +IntToStr(classID));
        SQLList[SQLList.Count -1]:= SQLList[SQLList.Count -1] + ';';
        SQLList.Add(ProductUOMSQL(tmp_name +'UOM'));
        SQLList.Add('update '+ tmp_name +' T inner join ' + tmp_name +'UOM as T1 on T.PartsId = T1.PartsId Set T.UOMID = T1.PUOMID , T.UOM = T1.PUOM ,T.UOMMultiplier = T1.PMult  where ifnull(T.UOMID,0) =0;');
        //SQLList.Add('Delete from '+ tmp_name +' where ifnull(uomqty,0)=0 and ifnull(qty,0)=0 and ifnull(instockuomqty,0)=0 and ifnull(instockqty,0)=0;');

        if chkIncludeAllProducts.checked then begin

          SQLList.Add('Drop table if exists ' + tmp_name + 'UOM1;');
          SQLList.Add('Create table ' + tmp_name + 'UOM1');
          SQLList.add('Select distinct');
          SQLList.add(' 3, P.PartsId,');
          SQLList.add('C.ClassID as DepartmentID,' );
          SQLList.add('T.PUOMID  as UOMID,' );
          SQLList.add('T.PUOM as UOM,');
          SQLList.add('T.PMult as UOMMultiplier,');
          SQLList.add('1 as gLevel,');
          SQLList.add('P.Partname as ProductName,');
          SQLList.add(Firstcolumn + ' as ProductColumn1,');
          SQLList.add(Secondcolumn+' as ProductColumn2,');
          SQLList.add(Thirdcolumn +' as ProductColumn3,');
          SQLList.add('P.PartsDescription,');
          SQLList.add('C.ClassName as Classname,');
          SQLList.add('"" as Batchnumber,');
          SQLList.add('0 as ExpiryDate,');
          SQLList.add('0 as BatchExpiryDate,');
          SQLList.add('"" as Binlocation,');
          SQLList.add('"" as  Binnumber,');
          SQLList.add('"" as Serialnumber,');
          SQLList.add('0 as UOMQty,');
          SQLList.add('0 as Qty,');
          SQLList.add('0 as InstockUOMQty,');
          SQLList.add('0 as InstockQty,');
          SQLList.add('AvgCost as Cost,');
          SQLList.add('0 as Value,');
          SQLList.add('P.Active,');
          SQLList.add('P.Barcode');
          SQLList.add('from tblclass  C, tblParts as P ');
          SQLList.add('inner join ' +tmp_name +'UOM T on P.partsId = T.PartsID');
          SQLList.add('Left join  ' +tmp_name +' T1 on ' +
                    ' T.PartsId = T1.partsId  ' +
                    ' and  ifnull(T1.DepartmentID,0)=0  ' +
                    ' and T.PUOM = T1.UOM  ' +
                    ' and T1.gLevel=1  ' +
                    ' and ifnull(T1.Batchnumber,"")=""  ' +
                    ' and ifnull(T1.ExpiryDate,"")=""  ' +
                    ' and ifnull(T1.Binlocation,"")=""  ' +
                    ' and ifnull(T1.Binnumber,"")="" ');
          SQLList.add('where  P.Parttype = "INV" and ifnull(T1.PartsId,0)=0');
          SQLList.add('/*and IsNull(pcs.ProductID)*/');
          if classId <> 0 then
                SQLList.add(' and ifnull(C.ClassID,0) =  '+IntToStr(ClassId) );
          SQLList[SQLList.Count -1]:= SQLList[SQLList.Count -1] + ';';
          SQLList.add('insert IGNORE into ' + tmp_name + '');
          SQLList.add('( PartsId,');
          SQLList.add('DepartmentID,');
          SQLList.add('UOMID,');
          SQLList.add('UOM,');
          SQLList.add('UOMMultiplier,');
          SQLList.add('gLevel,');
          SQLList.add('ProductName,');
          SQLList.add('ProductColumn1,');
          SQLList.add('ProductColumn2,');
          SQLList.add('ProductColumn3,');
          SQLList.add('PartsDescription,');
          SQLList.add('Classname,');
          SQLList.add('Cost,');
          SQLList.add('Active,');
          SQLList.add('ProductBarCode)');
          SQLList.add('Select distinct');
          SQLList.add('T.PartsId,');
          SQLList.add('T.DepartmentID,');
          SQLList.add('T.UOMID,');
          SQLList.add('T.UOM,');
          SQLList.add('T.UOMMultiplier,');
          SQLList.add('T.gLevel,');
          SQLList.add('T.ProductName,');
          SQLList.add('T.ProductColumn1,');
          SQLList.add('T.ProductColumn2,');
          SQLList.add('T.ProductColumn3,');
          SQLList.add('T.PartsDescription,');
          SQLList.add('T.Classname,');
          SQLList.add('T.Cost,');
          SQLList.add('T.Active,');
          SQLList.add('T.Barcode');
          SQLList.add('from ' + tmp_name + 'UOM1 T');
          SQLList.add('Left join  ' + tmp_name + ' T1 on  T.PartsId = T1.partsId   and  ifnull(T1.DepartmentID,0)= T.DepartmentID   and T.UOM = T1.UOM   and T1.gLevel=1   and ifnull(T1.Batchnumber,"")=""   and ifnull(T1.ExpiryDate,"")=""   and ifnull(T1.Binlocation,"")=""   and ifnull(T1.Binnumber,"")=""');
          SQLList.add('where  ifnull(T1.PartsId,0)=0;');
          SQLList.add('Drop table if exists ' + tmp_name + 'UOM1;');


          (*SQLList.Add('insert IGNORE into ' + tmp_name );
          SQLList.Add('( seqno, PartsId,');
          SQLList.add('DepartmentID,');
          SQLList.add('UOMID,');
          SQLList.add('UOM,');
          SQLList.add('UOMMultiplier,');
          SQLList.add('gLevel,');
          SQLList.add('ProductName,');
          SQLList.Add('ProductColumn1,');
          SQLList.add('ProductColumn2,');
          SQLList.add('ProductColumn3,');
          SQLList.Add('PartsDescription,');
          SQLList.add('Classname,');
          SQLList.add('Batchnumber,');
          SQLList.add('ExpiryDate,');
          SQLList.add('BatchExpiryDate,');
          SQLList.add('Binlocation,');
          SQLList.add('Binnumber,');
          SQLList.add('Serialnumber,');
          SQLList.add('UOMQty,');
          SQLList.add('Qty,');
          SQLList.add('InstockUOMQty,');
          SQLList.add('InstockQty,');
          SQLList.add('Cost,');
          SQLList.add('Active,');
          SQLList.add('Value,');
          SQLList.add('ProductBarCode)');

          SQLList.add('Select distinct');
          SQLList.add('P.PartsId,');
          SQLList.add('C.ClassID as DepartmentID,' );
          SQLList.add('T.PUOMID  as UOMID,' );
          SQLList.add('T.PUOM as UOM,');
          SQLList.add('T.PMult as UOMMultiplier,');
          SQLList.add('1 as gLevel,');
          SQLList.add('P.Partname as ProductName,');
          SQLList.add(Firstcolumn + ' as ProductColumn1,');
          SQLList.add(Secondcolumn+' as ProductColumn2,');
          SQLList.add(Thirdcolumn +' as ProductColumn3,');
          SQLList.add('PartsDescription,');
          SQLList.add('C.ClassName as Classname,');
          SQLList.add('"" as Batchnumber,');
          SQLList.add('0 as ExpiryDate,');
          SQLList.add('0 as BatchExpiryDate,');
          SQLList.add('"" as Binlocation,');
          SQLList.add('"" as  Binnumber,');
          SQLList.add('"" as Serialnumber,');
          SQLList.add('0 as UOMQty,');
          SQLList.add('0 as Qty,');
          SQLList.add('0 as InstockUOMQty,');
          SQLList.add('0 as InstockQty,');
          SQLList.add('AvgCost as Cost,');
          SQLList.add('0 as Value,');
          SQLList.add('P.Active,');
          SQLList.add('P.Barcode');
          SQLList.add('from tblclass  C, tblParts as P ');
          SQLList.add('inner join ' +tmp_name +'UOM T on P.partsId = T.PartsID');
          SQLList.add('/*left join tblProductclasses PCS on P.PARTSID = pcs.ProductID */');
          SQLList.add('where  P.Parttype = "INV"');
          SQLList.add('/*and IsNull(pcs.ProductID)*/');
          if classId <> 0 then
                SQLList.add(' and ifnull(C.ClassID,0) =  '+IntToStr(ClassId) );
          SQLList[SQLList.Count -1]:= SQLList[SQLList.Count -1] + ';';*)
        end;

        script:= TERPScript.Create(nil);
        try
          script.Connection:= CommonDbLib.GetSharedMyDacConnection;
          script.BeforeExecute:= MyScriptBeforeExecute;
          script.SQL.Text:= SQLList.Text;
          ExportProgressBar.min   := 0;
          ExportProgressBar.Max   := script.Statements.Count;
          ExportProgressBar.Step  := 1;
          ExportProgressBar.Position := 0;
          script.Execute;
        finally
          script.Free;
        end;
        ExportProgressBar.Position := 0;
        lblImporting.Caption  := 'Please Wait Preparing Stock Adjustment ..... 0%';
    finally
        FreeandNil(SQLList);
    end;

  end;
begin
  DisableForm;
  try
    inherited;
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

    btnOK.Enabled := false;
    try
      try
        if empty(txtFileName.Text) then begin
          SpeedButton1Click(Sender);
        end;
        if IsDir(ExtractFileDir(txtFileName.Text)) then begin
          btnCancel.Enabled := false;
          MakeExportFile(txtFileName.Text);
          lblImporting.Caption  := 'Please Wait Preparing Stock Adjustment ..... 0%';
          lblImporting.Visible  := true;
          ExportProgressBar.Min := 0;
          Application.ProcessMessages;
          Qry := commondblib.TempMyQuery;
          tmp_name:= GetUserTemporaryTableName('tmp_' +Self.ClassName);
          Try
              GenerateTempTable;
              AddLinetoFile(MakeHeaderLine(TStockAdjustEntry.ExportHeader+','+STOCKADJUSTEXPORTFIELDNAMES, '', ''));

              qry.SQL.Clear;
              Qry.SQL.add('Select count(*) from ' + tmp_Name );
              Qry.SQL.add('where ifnull(ProductName , "") <> ""  and Active <> "F"' );
              if classId = 0 then
                Qry.SQL.add(' and ifnull(DepartmentID,0) <> 0 ' )
              else Qry.SQL.add(' and ifnull(DepartmentID,0) =  '+IntToStr(ClassID) );
              qry.Open;
              LinesCount:= qry.Fields[0].AsInteger + 1;
              ExportProgressBar.Max := LinesCount;
              ExportProgressBar.Position := ExportProgressBar.Min;
              qry.Close;

              StartPos:= 0;
              i:= 0;
              while true do begin
                qry.SQL.Clear;
                Qry.SQL.add('Select * from ' + tmp_Name );
                Qry.SQL.add('where ifnull(ProductName , "") <> ""  and Active <> "F"' );
                if classId = 0 then Qry.SQL.add(' and ifnull(DepartmentID,0) <> 0 ' )
                else Qry.SQL.add(' and ifnull(DepartmentID,0) =  '+IntToStr(ClassID) );
                if fsSelectedProducts <> '' then Qry.SQL.add(' and ifnull(PartsId,0) in (' + fsSelectedProducts  +')' );
                Qry.SQL.add(' limit ' + IntToStr(StartPos) + ', 1000');
                qry.Open;
                if qry.IsEmpty then
                  break;
                with qry do begin
                  while not Qry.Eof do begin
                    i := i+1;
                    ExportProgressBar.StepIt;
                    lblImporting.Caption := 'Please Wait Exporting Stock Adjustment ...' + FloatToStrF(((I / LinesCount) * 100),
                      ffFixed, 7, 0) + '% Complete';
                    AddLinetoFile(MakeDataLine(TStockAdjustEntry.XMLNodeName , qry));
                    Next;
                    Application.ProcessMessages;
                  end;
                end;
                StartPos:= StartPos + 1000;
              end;
              AddLinetoFile(TStockAdjustEntry.ExportFooter);
          finally
              if Qry.Active then Qry.Close;
              Qry.SQL.clear;
              Qry.SQL.add('Drop table if Exists ' + tmp_name+';');
              Qry.SQL.add('Drop table if Exists ' + tmp_name+'UOM;');
              Qry.Execute;
              FreeandNil(Qry);
          end;
        end else begin
          CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFileName.Text) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
        end;
     except
        raise;
        CloseExportFile;
        btnCancel.Enabled := true;
        btnOK.Enabled := true;
        Self.Close;
      end;
    finally
      CloseExportFile;
      btnCancel.Enabled := true;
      btnOK.Enabled     := true;
      Self.Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmExportStockAdjustGUI.chkallclassesClick(Sender: TObject);
begin
  inherited;
  ClassLabel.enabled := chkallclasses.Checked = False;
  cboClass.enabled   :=chkallclasses.Checked = False;
end;
procedure TfrmExportStockAdjustGUI.MyScriptBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  ExportProgressBar.StepIt;
  lblImporting.Caption  := 'Please Wait Preparing Stock Adjustment ..... ' +Trim(floatToStr(round(ExportProgressBar.position/ExportProgressBar.Max*100,0)))+'%';
  Application.ProcessMessages;
end;

Initialization
  RegisterClassOnce(TfrmExportStockAdjustGUI);

end.






