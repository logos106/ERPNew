unit frmProdAttribImportCostnPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmProdAttribBase, Grids, BaseGrid, AdvGrid, GradientLabel,
  ExtCtrls, StdCtrls, Shader, DNMPanel, DNMSpeedButton, Contnrs, BusobjProdAttribGroup, BusObjBase,
  ComCtrls, Menus, DB, MemDS, DBAccess, MyAccess,ERPdbComponents,
  ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts, Buttons,
  Wwdbigrd, Wwdbgrid, frmProdAttribMatrixBase, BusObjStock, AdvObj,
  ProgressDialog;

type
  TfmProdAttribImportCostnPrice = class(TfmProdAttribMatrixBase)
    OpenDialog1: TOpenDialog;
    mnuGrid: TPopupMenu;
    mnucopy: TMenuItem;
    mnuPaste: TMenuItem;
    pnlSelection: TDNMPanel;
    Letter_Label: TLabel;
    txtFilePath: TEdit;
    SpeedButton1: TDNMSpeedButton;
    cmdImport: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    cmdupdate: TDNMSpeedButton;
    GrpAmountField: TRadioGroup;
    GrpAmountFieldType: TRadioGroup;
    Bevel11: TBevel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);  overload;
    procedure FormCreate(Sender: TObject);
    procedure cmdImportClick(Sender: TObject);
    procedure grdMatrixKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure mnuPasteClick(Sender: TObject);
    procedure cmdupdateClick(Sender: TObject);
    procedure grdMatrixEditChange(Sender: TObject; ACol, ARow: Integer;
      Value: String);
    procedure mnucopyClick(Sender: TObject);

  private
    F: TextFile;
    AllProductOK:Boolean;
    Product:TProduct;
    ErrorMsg :String;
    ProductIDs:String;
    Updated:boolean;
    function ReadNextLine:String;
    function LineCount(const FileName: string): integer;
    Procedure ImportFromClipBoard;
    Procedure CopytoclipBoard;
    Procedure ImportIT(value :TStringList);
    Procedure LockProduct(Const Sender: TBusObj; var Abort: boolean);
    Procedure ShowError(MsgDlgType:TMsgDlgType);
    Procedure goup_ConcatProductID(Sender: TDataset; var Abort: boolean);
    function getTransactionconnection: TERPConnection;
    procedure showMessage(const Value: sTring);
  Protected
    Function EnableLookups:Boolean ;Override;
    Procedure InitForm; override;
  public
    function OnTabchange:Boolean;
    procedure FormShow; overload;override;
    Procedure SetupGrid;override;
    Property Transactionconnection :TERPConnection Read getTransactionconnection;



  end;


implementation

uses CommonLib, FastFuncs, CommonDbLib, frmProdAttribMain,
  ProductAttributeLib  , Clipbrd, ProductQtyLib , typinfo,
  BaseFormForm, AppEnvironment, DNMLib, tcConst,
  frmMessageBase,  frmMessageWithList, PQALib;

{$R *.dfm}
procedure TfmProdAttribImportCostnPrice.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    txtFilePath.Text := Opendialog1.FileName;
  Application.ProcessMessages;
  Self.Update;
end;

procedure TfmProdAttribImportCostnPrice.FormShow(Sender: TObject);
begin
    inherited;
    //
end;
procedure TfmProdAttribImportCostnPrice.FormShow;
begin
  Tablename   := CreateUserTemporaryTable('tmp_productmatrix' , 'costnPrice');
    inherited;
end;

procedure TfmProdAttribImportCostnPrice.FormCreate(Sender: TObject);
begin
  inherited;
  comboList       := nil;
  Self.Color      := GetGradientColor(Self.Owner.Classname).color;
  ButtonTop := cButtonTopStart;
  Updated:=False;
end;



function TfmProdAttribImportCostnPrice.OnTabchange: Boolean;
var
  Msgoption:word;
begin
  REsult := false;
  if cmdupdate.enabled then begin
      Msgoption:= CommonLib.MessageDlgXP_Vista('You haven''t updated the price/cost.'+
                                      (*chr(13) +'Please select the "Copy Details" option to copy.'+*)
                                      chr(13) +'Do you wish to  "Update" before change ?' , mtconfirmation, [mbyes, mbNo], 0);
      if Msgoption = mrNo then begin
         Exit;
      end else if Msgoption = mrYes then begin
        cmdupdateClick(cmdupdate);
      end;
  end;

  if Updated then begin
      Msgoption:= CommonLib.MessageDlgXP_Vista('The cost/Price is updated and you haven''t saved the details.'+
                                      chr(13)  +'Do you wish to  "Save" and change ?' , mtconfirmation, [mbyes, mbNo], 0);
      if Msgoption = mrNo then begin
         Exit;
      end else if Msgoption = mrYes then begin
        If not TfmProdAttribMain(Self.Owner).Save then Exit;
        if Transactionconnection.InTransaction then Transactionconnection.Commit;
        updated := False;
      end;
  end;

  result :=True;
end;

function TfmProdAttribImportCostnPrice.LineCount(const FileName: string): integer;
var
  Count: integer;
  F: TextFile;
begin
  Count := 0;
  if not FileExists(FileName) then begin
    Result := 0;
    Exit;
  end;
  AssignFile(F, FileName);
  try
    {$I-}
    Reset(F);
    {$I+}
    IOResult;
    while not Eof(F) do begin
      Readln(F);
      Inc(Count);
    end;
    CloseFile(F);
    Result := Count;
  except
    CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtWarning, [mbOK], 0);
    Result := 0;
  end;
end;

procedure TfmProdAttribImportCostnPrice.cmdImportClick(Sender: TObject);
var
  FileLinesCount:Integer;
  count, I:Integer;
  TextFileStrings: TStringList;
  LINESTRING:string;
begin
  inherited;
  if Trim(txtFilePath.Text) = '' then exit;
  if IsDir(ExtractFileDir(txtFilePath.Text)) = False  then begin
      CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFilePath.Text) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
      Exit;
  end;
  if IsFile(txtFilePath.Text) = False  then begin
    CommonLib.MessageDlgXP_Vista('File "' + txtFilePath.Text + '"' + #13 + 'Does Not Exist !', mtWarning, [mbOK], 0);
    Exit;
  end;
  FileLinesCount := LineCount(txtFilePath.Text);
  if (FileLinesCount = 0) then begin
    Exit;
  end;
  try
    ProgressBar.Min := 0;
    ProgressBar.Max := FileLinesCount;
    ProgressBar.Position := ProgressBar.Min;
    try
      AssignFile(F, txtFilePath.Text);
      try
          {$I-} Reset(F);{$I+}
          IOResult;
      except
          CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtWarning, [mbOK], 0);
      end;
      Count := FileLinesCount;
      TextFileStrings:= TStringList.create;
      try
        for I := 1 to Count do begin
          LINESTRING := Trim(REadNextline);
          if not empty(LINESTRING) then
            TextFileStrings.Add(StripQuotes(LINESTRING));
        end;
        Importit(TextFileStrings);
      finally
          FreeandNil(TextFileStrings);
      end;
      finally
        CloseFile(F);
      end;
  finally
   ProgressBar.Position := 0;
  end;
  grdMatrix.Options := grdMatrix.options + [goediting];
end;
Function TfmProdAttribImportCostnPrice.ReadNextLine:String;
begin
  try
    Readln(F, Result);
  except
    on EInOutError do Result := '';
  end;

end;
procedure TfmProdAttribImportCostnPrice.grdMatrixKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in shift then
    if (Key = ord('V')) or (Key =Ord('v')) then begin
      ImportFromClipBoard;
      cmdupdate.Enabled := True;
    end else if (Key = ord('C')) or (Key =Ord('c')) then
      CopytoclipBoard;
end;

procedure TfmProdAttribImportCostnPrice.ImportFromClipBoard;
var
    TextFileStrings: TStringList;
    Buff     : string;
begin
  inherited;
  Buff := Clipboard.asText;
  if Buff= '' then Exit;
  TextFileStrings:= TStringList.create;
  try
    Buff:='"'+ StringReplace(StringReplace(Stripquotes(Buff), #$D#$A ,'","',[rfReplaceAll]), #9 , ',' , [rfReplaceAll])+'"';
    TextFileStrings.Commatext := Buff;
    ImportIT(TextFileStrings);
  finally
    FreeandNil(TextFileStrings);
  end;
end;

procedure TfmProdAttribImportCostnPrice.ImportIT(value: TStringList);
var
  I:Integer;
  XValues :TStringlist;
  Linedata:TStringlist;
  YValue, XValue:String;
  xpos,yPos:Integer;
  
  Procedure  Search(Value :String ; isY:Boolean =False);
  var
    x:Integer;
  begin
    if isy then begin
      ypos:=0;
      for x := 1 to grdMatrix.RowCount do
        if Sysutils.SameText(grdMatrix.Cells[ 0, x], value) then begin
          ypos:= x; exit; end;
    end else  begin
      xpos:=0;
      for x := 1 to grdMatrix.ColCount do
        if Sysutils.SameText(grdMatrix.Cells[x, 0], value) then begin
          xpos:= x; exit; end;
    end;
  end;
  Procedure Wrongdata(data:String;x,y:Integer);
  begin
    if ErrorMsg <> '' then ErrorMsg := ErrorMsg +chr(13) +chr(10);
    ErrorMsg := ErrorMsg + 'Invalida Data        : '+Data +' at ' +IntToStr(x) +',' +IntToStr(y);
  end;
  Procedure MissingAttrib(Attribute:String; x, Y:Integer; isY:Boolean=true);
  var
    s:String;
  begin
    if isy then s:=         'Invalid Y-Attribute :' else s:= 'Invalid X-Attribute :';
    s:= s+ Attribute ;
    if pos(s, ErrorMsg ) <> 0 then Exit;
    s:=  s+  ' at ' +IntToStr(x) +',' +IntToStr(y);
    if ErrorMsg <> '' then ErrorMsg := ErrorMsg +chr(13) +chr(10);
    ErrorMsg := ErrorMsg + s;
  end;
  function ValidLine :Boolean;
  var
    x:Integer;
  begin
    result := False;
    if Linedata.count = 0 then exit;
    if Linedata[0]='' then begin
      MissingAttrib(Linedata[0], I,0, false );
      exit;
    end;
    for x := 1 to Linedata.count-1 do begin
      LineData[x] := StringReplace(LineData[x], AppEnv.RegionalOptions.CurrencySymbol    , '' , [rfReplaceAll,rfIgnoreCase]);
      if isnumeric(LineData[x]) then Result := True else begin
        Wrongdata(Linedata[x] , x, I) ;
        Linedata[x]:='';
      end;
    end;
    YValue :=Linedata[0];
  end;
  Procedure showAmount;
  var
    x:Integer;
  begin
    YValue :=LineData.Strings[0];
    Search(YValue, true);
    if (ypos<=0) then begin
        MissingAttrib(YValue, 1, I, true);
        Exit;
    end;
    for x := 1 to Linedata.count-1 do begin
        XValue :=XValues[x];
        Search(Xvalue);
        if xPos<=0 then
          MissingAttrib(XValue, x,I,  false )
        else grdMatrix.cells[xpos,ypos]:=LineData.Strings[X];
    end;
  end;
begin

  if Value.count <= 1 then Exit;
  XValues := TStringlist.create;
  Linedata:= TStringlist.create;
  Split(Value[0] , ',' , XValues);

  if XValues[0] <> '' then
    if Sysutils.SameText(XValues[0] , 'cost') then GrpAmountField.Itemindex := 0
    else if Sysutils.SameText(XValues[0] , 'Price') then GrpAmountField.Itemindex := 1;

  try
    if XValues.count <=1 then Exit;
    For I:= 1 to Value.count -1 do begin
      Split(Value[i] , ',' , Linedata);
      if ValidLine then begin
         showAmount;
      end;
    end;
  finally
    if ErrorMsg <> '' then ShowError(mtInformation);
    FreeandNil(XValues);
    FreeandNil(Linedata);
  end;
  cmdupdate.Enabled := True;
end;

procedure TfmProdAttribImportCostnPrice.mnuPasteClick(Sender: TObject);
begin
  ImportFromClipBoard;
end;
procedure TfmProdAttribImportCostnPrice.CopytoclipBoard;
var
  x, y:Integer;
  Buff:String;
begin
  Buff:= '';
  for y := 0 to grdMatrix.RowCount-1 do begin
    for x := 0 to grdMatrix.Colcount-1 do begin
      if (x=0) and (y=0) then begin
        if GrpAmountField.itemindex = 0 then Buff:= 'Cost' else Buff:= 'Price';
      end else begin
        if (x<>0) then Buff:= Buff + #9;
        Buff:= Buff + grdMatrix.cells[x,y];
      end;
    end;
    Buff:= Buff + #$D#$A;
  end;
  Clipboard.asText:= Buff;
end;


procedure TfmProdAttribImportCostnPrice.cmdupdateClick(Sender: TObject);
var
  x, y:Integer;
  SQLs:Tstringlist;
  strSQL:String;
  ProptoUpdate, PropEx:String;
  ds:TERPQuery;

  Procedure Progress(fito:Integer); begin
      Progressbar.min := 0;
      Progressbar.max := fiTo;
      Progressbar.position := 1;
  end;
  Procedure PropertytoUpdate;
  begin
    if (GrpAmountField.itemindex = 0) and  (GrpAmountFieldType.itemindex=0) then begin
      ProptoUpdate:='BuyQty1CostInc';
      PropEx:='BuyQty1Cost';
    end else if (GrpAmountField.itemindex = 0) and  (GrpAmountFieldType.itemindex=1) then  begin
      ProptoUpdate:= 'BuyQty1Cost';
      PropEx:= 'BuyQty1Cost';
    end else if (GrpAmountField.itemindex = 1) and  (GrpAmountFieldType.itemindex=0) then  begin
      ProptoUpdate:= 'SellQty1PriceInc';
      PropEx:= 'SellQty1Price';
    end else if (GrpAmountField.itemindex = 1) and (GrpAmountFieldType.itemindex=1) then  begin
      ProptoUpdate:= 'SellQty1Price';
      Propex:= 'SellQty1Price';
    end;
  end;
begin
  ProcessingCursor;
  Progressbar.visible := TRue;
  try
    Progress(2);
    SQLs:=Tstringlist.create;
    try
      for y := 1 to grdMatrix.RowCount-1 do begin
        for x := 1 to grdMatrix.Colcount-1 do begin
            SQLs.add('(' + CurrentRecord(x,y)+')');
        end;
      end;
      (*strSQL := 'Select group_concat(ProductId) as ProductIDs from  ' + Tablename +
                  ' where ' + StringReplace(Trim(SQLs.text), #$D#$A , ' OR ' , [rfReplaceAll]);
      With CommonDbLib.TempMyQuery do try
        connection := qryToBeCreated.connection;
        SQL.add(strSQL);
        try
          Open;
        except
          on e: Exception do begin
            raise Exception.Create('TfmProdAttribImportCostnPrice.cmdupdateClick ' +
              'exception opening query with message: ' + e.Message +
              ' Query SQL = ' + SQL.Text);
          end;
        end;
        if recordcount = 0 then exit;
        if Trim(fieldbyname('ProductIDs').asString) = '' then exit;
        strSQL:= 'PARTSID in  (' + Trim(fieldbyname('ProductIDs').asString) +')';*)

        strSQL := 'Select ProductId  from  ' + Tablename +
                  ' where ' + StringReplace(Trim(SQLs.text), #$D#$A , ' OR ' , [rfReplaceAll]);
      ds:= CommonDbLib.TempMyQuery;
      With ds do try
        connection := qryToBeCreated.connection;
        SQL.add(strSQL);
        try
          Open;
        except
          on e: Exception do begin
            raise Exception.Create('TfmProdAttribImportCostnPrice.cmdupdateClick ' +
              'exception opening query with message: ' + e.Message +
              ' Query SQL = ' + SQL.Text);
          end;
        end;
        if recordcount = 0 then exit;
        (*if Trim(fieldbyname('ProductIDs').asString) = '' then exit;*)
        ProductIDs :='';
        Iteraterecords(ds, goup_ConcatProductID);
        if ProductIDs = '' then Exit;
        strSQL:= 'PARTSID in  (' + Trim(ProductIDs) +')';
      finally
          if active then close;
          Freeandnil(ds);
      end;
      Progressbar.StepIt;
      Progress(2);
      Product:= TProduct.Create(SelF);
      try
        Product.SilentMode := True;
        Product.connection := TMyDacDataConnection.create(Product);
        Product.connection.connection := qryToBeCreated.connection;
        try
          Product.LoadSelect(StrSQL);
        except
          on e: Exception do begin
            raise Exception.Create('TfmProdAttribImportCostnPrice.cmdupdateClick ' +
              'exception loading Product object with message: ' + e.Message +
              ' Load SQL = ' + strSQL);
          end;
        end;
        if Product.count = 0 then Exit;
        Progress(Product.count);
        AllProductOK:=True;
        Product.LockGroupName  := PRODATTRIGROUP;
        Product.IterateRecords(LockProduct);
        try
          if AllProductOK =False then begin
            ErrorMsg := 'Import failed as the products are locked: ' +chr(13)+chr(10)+ErrorMsg;
            showError(mtWarning);
            Exit;
          end;
          SQLs.Clear;
          Progress(grdMatrix.RowCount*grdMatrix.Colcount);
          for y := 1 to grdMatrix.RowCount-1 do begin
            for x := 1 to grdMatrix.Colcount-1 do begin
              SQLs.add(' update ' +tablename +' set Qty =' +floatToStr(NumericCellvalue(x,y)) +
              ' where '+CurrentRecord(x,y) +';');
              Progressbar.StepIt;
            end;
          end;
          Progress(2);
          if SQLs.text <> '' then begin
            RunSQL(SQLs.text);
            With CommonDbLib.TempMyQuery do try
              connection := qryToBeCreated.connection;
              SQL.add('Select * from ' +Tablename );
              Open;
              first;
              Progress(recordcount);
              PropertyToupdate;
              Product.Connection.BeginNestedTransaction;
              try
                try
                  While Eof = False do begin
                    if Product.Dataset.Locate('PartsId' , FieldByname('ProductId').asInteger , []) = false then begin
                    end else begin
                      if ProptoUpdate = PropEx then begin
                        SetPropValue(Product , ProptoUpdate  , FieldByname('Qty').asFloat);
                      end else begin
                        if PropEx ='BuyQty1Cost' then
                          SetPropValue(Product , PropEx  , Round(GetAmountEx(FieldByname('Qty').asFloat, DnmLib.GetTaxRate(Product.TaxCodePurchase)),tcConst.GeneralRoundPlaces))
                        else
                          SetPropValue(Product , PropEx  , Round(GetAmountEx(FieldByname('Qty').asFloat, DnmLib.GetTaxRate(Product.TaxCodeSales)),tcConst.GeneralRoundPlaces));
                      end;
                      Product.PostDB;
                      Progressbar.stepit;
                    end;
                    Next;
                  end;
                except
                    on E:Exception do begin
                        Product.Connection.RollbackNestedTransaction;
                        Product.ResultStatus.addItem(False, rssError , 0, 'Import failed due to unknown reason ' + E.Message);
                        MessageDlgXP_Vista('Import failed due to unknown reason ' + E.Message , mtinformation , [mbOk], 0)
                    end;
                end;
              finally
                  Product.connection.CommitNestedTransaction;
                  cmdupdate.Enabled := False;
                  AttributeGroups.dirty := True;
              end;
            finally
                if Active then Close;
                Free;
            end;
        end;
        finally
          //Product.Userlock.Unlock(PRODATTRIGROUP);
        end;
      finally
          FreeandNil(Product);
      end;
    finally
        FreeandNil(SQLs);
    end;
  finally
    Progressbar.visible := False;
    ProcessingCursor(False);
    Updated := True;
  end;
end;

procedure TfmProdAttribImportCostnPrice.LockProduct(const Sender: TBusObj;var Abort: boolean);
begin
  Progressbar.StepIt;
  if Product.Lock = False then begin
    AllProductOK:= False;
    if ErrorMsg <> '' then ErrorMsg := ErrorMsg + chr(13)+chr(10);
    ErrorMsg := ErrorMsg + Product.name + Product.UserLock.LockMessage;
  end;
end;

function TfmProdAttribImportCostnPrice.EnableLookups: Boolean;
begin
  REsult := (comboList.Count <> 0) ;
end;

procedure TfmProdAttribImportCostnPrice.Initform;
begin
  inherited;
  StrinGList.Add('insert into ' + tablename + ' (ProductID , ProductName ,DepartmentID, Qty)' +
          ' SELECT P.PartsID,P.PartName, PQA.departmentID, '+ SQL4Qty(tinstock)  +
          ' From ' +  ProductTables(tProductList) +
          ' where P.PartsId in (Select ProductId from tblproductattributeproducts PaP  where   PaP.PAG_ID =' + IntToStr(AttributeGroups.ID) +' )' +
          ' group by P.PartsID,P.PartName ' +
          ' order by P.PartName;');

  grdMatrix.Options := grdMatrix.options - [goediting];
  if Subform.Parent is TDnMPanel then begin
       subform.Height :=TDnMPanel(Subform.Parent).Height;
       subform.Width :=TDnMPanel(Subform.Parent).width;
  end;
end;


procedure TfmProdAttribImportCostnPrice.ShowError(MsgDlgType:TMsgDlgType);
begin
  if  ErrorMsg <> '' then ShowMessage(ErrorMsg);//MessageDlgXP_Vista(ErrorMsg, MsgDlgType , [mbOk], 0);
  ErrorMsg:='';
end;
Procedure TfmProdAttribImportCostnPrice.showMessage(const Value:sTring);
begin
  if value = '' then exit;
    InitMsgParams;
    PopupMsgParams.Msgcaption := 'Warning';
    PopupMsgParams.MsgTExtForGridDelim := chr(13)+chr(10);
    PopupMsgParams.MsgTExtForGrid :=  Value;
    PopupMsgParams.displayLabels:= 'Message';
    PopupMsgParams.displayWidths:= '500';
    PopupMsgParams.Custombuttons :='"OK"' ;
    PopupMsgParams.Msg1:='Warning';
    PopupMsgParams.Msg2 := '';
    PopupMsgParams.MsgColor := Self.Color;
    TfmMessageWithList.MsgDlg;
end;
procedure TfmProdAttribImportCostnPrice.SetupGrid;
begin
  if self.owner is TfmProdAttribMain then
    qryToBeCreated.Connection := TfmProdAttribMain(Self.Owner).MyConnection;
  inherited;
end;

procedure TfmProdAttribImportCostnPrice.grdMatrixEditChange(
  Sender: TObject; ACol, ARow: Integer; Value: String);
begin
  inherited;
  cmdupdate.Enabled := True;
end;

procedure TfmProdAttribImportCostnPrice.goup_ConcatProductID(Sender: TDataset; var Abort: boolean);
begin
  if ProductIDs <> '' then ProductIDs := ProductIDs +',';
  ProductIDs:= ProductIDs + IntToStr(Sender.fieldByname('ProductId').asInteger);
end;

procedure TfmProdAttribImportCostnPrice.mnucopyClick(Sender: TObject);
begin
  inherited;
  CopytoclipBoard;
end;

function TfmProdAttribImportCostnPrice.getTransactionconnection: TERPConnection;
begin
  REsult := TfmProdAttribMain(Self.Owner).MyConnection;
end;

initialization
  RegisterClassOnce(TfmProdAttribImportCostnPrice);

end.
