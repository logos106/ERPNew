unit PartCalcFormulaObj;

interface



uses BaseTransForm , Graphics , Classes , db, grids , busobjStock, BusobjBaseProdTrans , wwdbGrid, BaseInputForm , GuiPrefsObj;

Type
  TPartCalcFormula = class(TComponent)
  Private

    Value1, value2, value3, value4, value5:Double;
    coloursInited:boolean;
    procedure FormulaDetailValues(Sender: TObject; const VarName: string;      var Value: extended; var FieldFound: Boolean);
    procedure SetFormulaColumns(fieldcount: Integer; Qry: TDataset;fieldNames: array  of string; Qtyfield: String; grid :twwDBGrid;GuiPrefs: TFormGuiPrefs);
    procedure Setcolumn(columnVisible: Boolean; columnName,      displaylabel: String; grid: twwDBGrid; Qry: TDataset;      GuiPrefs: TFormGuiPrefs);
    procedure DoShowformulafields(Sender: TObject);
    procedure MakeShowformulaFieldMenu(Grid: TwwDBGrid);
    procedure ApplyPref(Grid: TwwDBGrid;GuiPrefs: TFormGuiPrefs);

  Public
    constructor Create(AOwner :TComponent); Override;
    Procedure SetdisplayLabel(Transform :TBaseInputGUI);
    procedure ShowFormulaQtyFields(Transform :TBaseInputGUI);
    Procedure gridCalcTitleAttributes(Sender: TObject; const AFieldName: string;  const AFont: TFont; const ABrush: TBrush; var ATitleAlignment: TAlignment);
    Procedure gridCalcCellColors(ProductHasCalcformula :Boolean;Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
    procedure FormulaDetails(TRansLine :TProdTrans; Product:TProduct; IsQtySold:Boolean);
    procedure InitformulaQtyValues(TRansLine :TProdTrans);
    procedure LockPartCalcformulafields(grid:TwwdbGrid;ProductHasCalcformula: Boolean);
  end;



implementation

uses AppEnvironment, sysutils, tcTypes, Expenses , GraphUtil, CommonLib , dialogs,
  tcConst, frmSmartOrderFrm, BusObjTrans, frmRepairs,
  frmStockAdjustEntry, frmStockTransferEntry, ParserLib, menus, GridFieldsObj;

procedure TPartCalcFormula.FormulaDetailValues(Sender: TObject; const VarName: string;var Value: extended; var FieldFound: Boolean);
begin
              if SameText(varname, 'Field1') then begin Value := Value1 ;FieldFound:= True;
     end else if SameText(varname, 'Field2') then begin Value := VAlue2 ;FieldFound:= True;
     end else if SameText(varname, 'Field3') then begin Value := Value3 ;FieldFound:= True;
     end else if SameText(varname, 'Field4') then begin Value := Value4;FieldFound:= True;
     end else if SameText(varname, 'Field5') then begin Value := Value5 ;FieldFound:= True; end;
end;

constructor TPartCalcFormula.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ColoursInited:= False;
end;

Procedure TPartCalcFormula.FormulaDetails(TRansLine :TProdTrans; Product:TProduct; IsQtySold:Boolean);
var
   Qty :double;
  ErrMsg:String;
  s, FieldValues:String;
  function Quantity :double;
  begin
      if TRansLine is TTranslinebase then begin
        if IsQtySold then
          REsult := TransLine.FormulaQtySoldValue
        else
          REsult := TransLine.FormulaQtyShippedValue;
      end else begin
        REsult := TRansLine.FormulaQtyValue;
      end;
  end;
begin
    if TRansLine is TTranslinebase then begin
      if IsQtySold then begin
        Value1:= TransLine.FormulaQtySoldValue1;
        Value2:= TransLine.formulaQtysoldValue2;
        Value3:= TransLine.formulaQtysoldValue3;
        Value4:= TransLine.formulaQtysoldValue4;
        Value5:= TransLine.formulaQtysoldValue5;
      end else begin
        Value1:= TransLine.formulaQtyShippedValue1;
        Value2:= TransLine.formulaQtyShippedValue2;
        Value3:= TransLine.formulaQtyShippedValue3;
        Value4:= TransLine.formulaQtyShippedValue4;
        Value5:= TransLine.formulaQtyShippedValue5;
      end;
    end else  begin // repairs ,smart order , stock transfer, stockadjustment
        Value1:= TransLine.FormulaQtyValue1;
        Value2:= TransLine.FormulaQtyValue2;
        Value3:= TransLine.FormulaQtyValue3;
        Value4:= TransLine.FormulaQtyValue4;
        Value5:= TransLine.FormulaQtyValue5;
    end;

    Qty := ProductQtyParseValue(Self , FormulaDetailValues , errmsg,  TRansLine, Quantity);

      FieldValues:= TRansLine.QtyCalcFormulaDetails.PartCalcformula;//Product.PartCalcformula;
      if TRansLine is TTranslinebase then begin
        if IsQtySold  then begin
          FieldValues:=replacestr( FieldValues, '[Field1]' , FloattoSTr(TRansline.FormulaQtySoldValue1));
          FieldValues:=replacestr( FieldValues, '[Field2]' , FloattoSTr(TRansline.FormulaQtySoldValue2));
          FieldValues:=replacestr( FieldValues, '[Field3]' , FloattoSTr(TRansline.FormulaQtySoldValue3));
          FieldValues:=replacestr( FieldValues, '[Field4]' , FloattoSTr(TRansline.FormulaQtySoldValue4));
          FieldValues:=replacestr( FieldValues, '[Field5]' , FloattoSTr(TRansline.FormulaQtySoldValue5));
        end else begin
          FieldValues:=replacestr( FieldValues, '[Field1]' , FloattoSTr(TRansline.FormulaQtyShippedValue1));
          FieldValues:=replacestr( FieldValues, '[Field2]' , FloattoSTr(TRansline.FormulaQtyShippedValue2));
          FieldValues:=replacestr( FieldValues, '[Field3]' , FloattoSTr(TRansline.FormulaQtyShippedValue3));
          FieldValues:=replacestr( FieldValues, '[Field4]' , FloattoSTr(TRansline.FormulaQtyShippedValue4));
          FieldValues:=replacestr( FieldValues, '[Field5]' , FloattoSTr(TRansline.FormulaQtyShippedValue5));
        end;
      end else begin
          FieldValues:=replacestr( FieldValues, '[Field1]' , FloattoSTr(TRansline.FormulaQtyValue1));
          FieldValues:=replacestr( FieldValues, '[Field2]' , FloattoSTr(TRansline.FormulaQtyValue2));
          FieldValues:=replacestr( FieldValues, '[Field3]' , FloattoSTr(TRansline.FormulaQtyValue3));
          FieldValues:=replacestr( FieldValues, '[Field4]' , FloattoSTr(TRansline.FormulaQtyValue4));
          FieldValues:=replacestr( FieldValues, '[Field5]' , FloattoSTr(TRansline.FormulaQtyValue5));
      end;
      s:=          'Formula :' + TRansLine.QtyCalcFormulaDetails.PartCalcformula + '  = ' + floattoStr(TRansLine.QtyCalcFormulaDetails.PartCalcFormulaMult) + '  ' + TRansLine.QtyCalcFormulaDetails.PartCalcformulaUOM ;
      s:= s + NL + 'Values  : ' ;
      if AppEnv.Companyprefs.PartCalcfield1Visible then s:= s + '[' +AppEnv.Companyprefs.PartCalcfield1Name +' = ' +FloatTostr(Value1)+'] ';
      if AppEnv.Companyprefs.PartCalcfield2Visible then s:= s + '[' +AppEnv.Companyprefs.PartCalcfield2Name +' = ' +FloatTostr(Value2)+'] ';
      if AppEnv.Companyprefs.PartCalcfield3Visible then s:= s + '[' +AppEnv.Companyprefs.PartCalcfield3Name +' = ' +FloatTostr(Value3)+'] ';
      if AppEnv.Companyprefs.PartCalcfield4Visible then s:= s + '[' +AppEnv.Companyprefs.PartCalcfield4Name +' = ' +FloatTostr(Value4)+'] ';
      if AppEnv.Companyprefs.PartCalcfield5Visible then s:= s + '[' +AppEnv.Companyprefs.PartCalcfield5Name +' = ' +FloatTostr(Value5)+'] ';

      s:= s+ NL + NL+ '= ';
      if TRansLine is TTranslinebase then begin
        if IsQtySold  then begin
          if TransLine.FormulaQtySoldValue <> 0 then s := s + ' ' + floattostr(TransLine.FormulaQtySoldValue) +' of ' ;
        end else begin
          if TransLine.FormulaQtyShippedValue <> 0 then s := s + ' ' + floattostr(TransLine.FormulaQtyShippedValue)+' of ' ;
        end;
      end else begin
        if TransLine.FormulaQtyValue <> 0 then s := s + ' ' + floattostr(TransLine.FormulaQtyValue)+' of ' ;
      end;
      s:= s+Quotedstr(FieldValues);
      s:= s + ' /' + floattoStr(TRansLine.QtyCalcFormulaDetails.PartCalcFormulaMult) ;
      s:= s +NL +  NL+ ' =  ' + FloatToStrF(Qty, ffgeneral, 15, 5) + '   ' + TRansLine.QtyCalcFormulaDetails.PartcalcformulaUOM ;
      if TransLine.UnitOfMeasureID <> TRansLine.QtyCalcFormulaDetails.PartCalcformulaUOMID then begin
          Qty := Qty * TRansLine.QtyCalcFormulaDetails.PartCalcformulaUOMMult;
          Qty := DivZer(Qty ,TransLine.UOMMultiplier );
          S := s + NL+ ' =  ' + FloatToStrF(Qty, ffgeneral, 15, 5) + '   ' + Transline.UnitOfMeasure ;
      end;

      MessageDlgXP_Vista(s, mtInformation, [mbOK], 0);
end;

Procedure TPartCalcFormula.SetFormulaColumns(fieldcount:Integer; Qry:TDataset; fieldNames :Array of string; Qtyfield:String; grid :twwDBGrid;GuiPrefs: TFormGuiPrefs);
var
  i:Integer;
  ctr:Integer;
begin
   i:= fieldcount;
    for ctr :=   high(fieldNames) downto low(fieldNames)  do begin
      Qry.fieldbyname(fieldNames[ctr]).Index := i;
    end;
    Setcolumn(AppEnv.companyPrefs.PartCalcfieldVisible,    fieldNames[0] ,'Formula Qty' , grid,Qry,GuiPrefs);
    Setcolumn(AppEnv.companyPrefs.PartCalcfield1Visible,   fieldNames[1] ,AppEnv.companyPrefs.PartCalcField1Name,grid,Qry,GuiPrefs);
    Setcolumn(AppEnv.companyPrefs.PartCalcfield2Visible ,  fieldNames[2] ,AppEnv.companyPrefs.PartCalcField2Name,grid,Qry,GuiPrefs);
    Setcolumn(AppEnv.companyPrefs.PartCalcfield3Visible ,  fieldNames[3] ,AppEnv.companyPrefs.PartCalcField3Name,grid,Qry,GuiPrefs);
    Setcolumn(AppEnv.companyPrefs.PartCalcfield4Visible ,  fieldNames[4] ,AppEnv.companyPrefs.PartCalcField4Name,grid,Qry,GuiPrefs);
    Setcolumn(AppEnv.companyPrefs.PartCalcfield5Visible ,  fieldNames[5] ,AppEnv.companyPrefs.PartCalcField5Name,grid,Qry,GuiPrefs);

    i:=0;
    if Qry.FindField(Qtyfield) <> nil then
      i:=Qry.fieldbyname(Qtyfield).Index ;

    if i>=0 then
      for ctr :=   high(fieldNames) downto low(fieldNames) do
        Qry.fieldbyname(fieldNames[ctr]).Index := i;
end;
procedure TPartCalcFormula.Setcolumn(columnVisible: Boolean; columnName, displaylabel: String; grid :twwDBGrid;Qry:TDataset;GuiPrefs: TFormGuiPrefs);
begin
  if columnVisible then begin
    if displaylabel <> '' then begin
      if Grid.ColumnByName(columnName) = nil then begin
        if Qry.findfield(columnName) <> nil then
          Qry.fieldbyname(columnName).DisplayLabel :=DisplayLabel;
      end else begin
        Grid.ColumnByName(columnName).DisplayLabel := DisplayLabel;
      end;
    end;
    if guiprefs.active then guiprefs.DbGridElement[Grid].AddField(columnName) else Grid.AddField(columnName);
  end else begin
    if guiprefs.active then guiprefs.DbGridElement[Grid].RemoveField(columnName) else grid.RemoveField(columnname);
  end;
end;
procedure TPartCalcFormula.ApplyPref(Grid :TwwDBGrid;GuiPrefs: TFormGuiPrefs);
var
  s:String;
begin
  if GuiPrefs.Active then begin
    s := GetSelectedTExtFromFields(Grid,True);
    grid.Selected.Text := s;
    Grid.ApplySelected;
    GuiPrefs.DbGridElement[grid].GetColumnSettings(False);
    GuiPrefs.SavePrefs;
    GuiPrefs.ApplyGuiPrefs;
  end;
end;
procedure TPartCalcFormula.ShowFormulaQtyFields(Transform :TBaseInputGUI);
var
  QtyField:String;
begin

  if Transform is TBaseTransGUI then begin
    With TBaseTransGUI(Transform) do begin
      if Transform is TBaseExpenseGUI then
      else begin
          QtyField :='UnitofMeasureQtySold';
          if (Transform.classnameis('TReturnAGUI')) then QtyField:= 'RAQty';
          SetFormulaColumns(grdTransactions.Selected.Count , tbldetails, ['FormulaQtySoldValue' , 'FormulaQtySoldValue1', 'FormulaQtySoldValue2' , 'FormulaQtySoldValue3' , 'FormulaQtySoldValue4' , 'FormulaQtySoldValue5'] ,QtyField , grdTransactions , GuiPrefs);

          if (Transform.ClassName = 'TQuoteGUI') or ((Transform.ClassName = 'TSalesOrderGUI') and (appenv.CompanyPrefs.SingleQtySO)) then begin
              Setcolumn(False ,  'FormulaQtyShippedValue' ,'');
              Setcolumn(False ,  'FormulaQtyShippedValue1' ,'');
              Setcolumn(False,  'FormulaQtyShippedValue2' ,'');
              Setcolumn(False,  'FormulaQtyShippedValue3' ,'');
              Setcolumn(False,  'FormulaQtyShippedValue4' ,'');
              Setcolumn(False,  'FormulaQtyShippedValue5' ,'');
          end else begin
            QtyField :='UnitofMeasureShipped';
            if (Transform.classnameis('TRefundGUI')) then QtyField:= 'RefundQty';
            SetFormulaColumns(grdTransactions.Selected.Count , tbldetails, ['FormulaQtyShippedValue' , 'FormulaQtyShippedValue1', 'FormulaQtyShippedValue2' , 'FormulaQtyShippedValue3' , 'FormulaQtyShippedValue4' , 'FormulaQtyShippedValue5'] ,QtyField , grdTransactions , GuiPrefs);
          end;
         end;
         ApplyPref(grdTransactions, GuiPrefs);
    end;
  end else if   Transform is TSmartOrderGUI then begin
    with TSmartOrderGUI(Transform) do begin
        QtyField :='UnitofMeasureQty';
        if (Transform.classnameis('TRefundGUI')) then QtyField:= 'RefundQty';
        SetFormulaColumns(grdLines.Selected.Count , tbldetails, ['FormulaQtyValue' , 'FormulaQtyValue1', 'FormulaQtyValue2' , 'FormulaQtyValue3' , 'FormulaQtyValue4' , 'FormulaQtyValue5'] ,QtyField , grdLines , GuiPrefs);
        ApplyPref(grdLines , GuiPrefs);
    end;
  end else if   Transform is TRepairsGUI then begin
    with TRepairsGUI(Transform) do begin
        QtyField :='UOMQty';
        SetFormulaColumns(grdParts.Selected.Count , tblrepairparts, ['FormulaQtyValue' , 'FormulaQtyValue1', 'FormulaQtyValue2' , 'FormulaQtyValue3' , 'FormulaQtyValue4' , 'FormulaQtyValue5'] ,QtyField , grdParts , GuiPrefs);
        ApplyPref(grdParts, GuiPrefs);
    end;
  end else if   Transform is TfmStockAdjustEntry then begin
    with TfmStockAdjustEntry(Transform) do begin
        QtyField :='AdjustUOMQty';
        SetFormulaColumns(grdTransactions.Selected.Count , qryStockAdjustEntryLines, ['FormulaQtyValue' , 'FormulaQtyValue1', 'FormulaQtyValue2' , 'FormulaQtyValue3' , 'FormulaQtyValue4' , 'FormulaQtyValue5'] ,QtyField , grdTransactions , GuiPrefs);
        ApplyPref(grdTransactions,GuiPrefs);
    end;
  end else if   Transform is TfmStockTransferEntry then begin
    with TfmStockTransferEntry(Transform) do begin
        QtyField :='UOMTransferQty';
        SetFormulaColumns(SubformDetails.Selected.Count , tblDetails, ['FormulaQtyValue' , 'FormulaQtyValue1', 'FormulaQtyValue2' , 'FormulaQtyValue3' , 'FormulaQtyValue4' , 'FormulaQtyValue5'] ,QtyField , SubformDetails , GuiPrefs);
        ApplyPref(SubformDetails,GuiPrefs);
    end;
  end else begin
    exit;
  end;
end;




Procedure TPartCalcFormula.LockPartCalcformulafields(grid:TwwdbGrid; ProductHasCalcformula :Boolean);
begin
    if Grid.Columnbyname('FormulaQtyShippedValue').Index >= 0 then Grid.Columnbyname('FormulaQtyShippedValue').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyShippedValue1').Index >= 0 then Grid.Columnbyname('FormulaQtyShippedValue1').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyShippedValue2').Index >= 0 then Grid.Columnbyname('FormulaQtyShippedValue2').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyShippedValue3').Index >= 0 then Grid.Columnbyname('FormulaQtyShippedValue3').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyShippedValue4').Index >= 0 then Grid.Columnbyname('FormulaQtyShippedValue4').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyShippedValue5').Index >= 0 then Grid.Columnbyname('FormulaQtyShippedValue5').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtySoldValue').Index >= 0 then Grid.Columnbyname('FormulaQtySoldValue').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtySoldValue1').Index >= 0 then Grid.Columnbyname('FormulaQtySoldValue1').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtySoldValue2').Index >= 0 then Grid.Columnbyname('FormulaQtySoldValue2').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtySoldValue3').Index >= 0 then Grid.Columnbyname('FormulaQtySoldValue3').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtySoldValue4').Index >= 0 then Grid.Columnbyname('FormulaQtySoldValue4').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtySoldValue5').Index >= 0 then Grid.Columnbyname('FormulaQtySoldValue5').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyValue').Index >= 0 then Grid.Columnbyname('FormulaQtyValue').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyValue1').Index >= 0 then Grid.Columnbyname('FormulaQtyValue1').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyValue2').Index >= 0 then Grid.Columnbyname('FormulaQtyValue2').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyValue3').Index >= 0 then Grid.Columnbyname('FormulaQtyValue3').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyValue4').Index >= 0 then Grid.Columnbyname('FormulaQtyValue4').readonly :=not ProductHasCalcformula;
    if Grid.Columnbyname('FormulaQtyValue5').Index >= 0 then Grid.Columnbyname('FormulaQtyValue5').readonly :=not ProductHasCalcformula;
end;
Procedure TPartCalcFormula.gridCalcTitleAttributes(Sender: TObject; const AFieldName: string;  const AFont: TFont; const ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'UnitofMeasureShipped' )     then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'Shipped' )                  then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'RefundQty' )                then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'UnitofMeasureQty' )         then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;//SmartOrder
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'UOMQty' )                   then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;//Repair
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'UOMTransferQty' )           then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'AdjustUOMQty' )             then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'FormulaQtyShippedValue' )   then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(AfieldName , 'FormulaQtyShippedValue1' ) then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield2Visible  and SameText(AfieldName , 'FormulaQtyShippedValue2' ) then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield3Visible  and SameText(AfieldName , 'FormulaQtyShippedValue3' ) then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield4Visible  and SameText(AfieldName , 'FormulaQtyShippedValue4' ) then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield5Visible  and SameText(AfieldName , 'FormulaQtyShippedValue5' ) then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;

  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'UnitofMeasureQtySold' )     then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'QtySold' )                  then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'RAQty' )                    then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'FormulaQtySoldValue' )      then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(AfieldName , 'FormulaQtySoldValue1' )    then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfield2Visible  and SameText(AfieldName , 'FormulaQtySoldValue2' )    then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfield3Visible  and SameText(AfieldName , 'FormulaQtySoldValue3' )    then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfield4Visible  and SameText(AfieldName , 'FormulaQtySoldValue4' )    then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfield5Visible  and SameText(AfieldName , 'FormulaQtySoldValue5' )    then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  {smart order fields}
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(AfieldName , 'FormulaQtyValue' )          then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(AfieldName , 'FormulaQtyValue1' )        then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield2Visible  and SameText(AfieldName , 'FormulaQtyValue2' )        then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield3Visible  and SameText(AfieldName , 'FormulaQtyValue3' )        then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield4Visible  and SameText(AfieldName , 'FormulaQtyValue4' )        then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield5Visible  and SameText(AfieldName , 'FormulaQtyValue5' )        then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
end;

procedure TPartCalcFormula.InitformulaQtyValues(TRansLine: TProdTrans);
begin
  if TransLine.Hasformula = false then exit;
  if Transline.FormulaQtySoldValue <>0 then Transline.FormulaQtySoldValue := 0;
  if Transline.FormulaQtySoldValue1 =0 then Transline.FormulaQtySoldValue1 :=Transline.Product.FormulaQtyValue1;
  if Transline.FormulaQtySoldValue2 =0 then Transline.FormulaQtySoldValue2 :=Transline.Product.FormulaQtyValue2;
  if Transline.FormulaQtySoldValue3 =0 then Transline.FormulaQtySoldValue3 :=Transline.Product.FormulaQtyValue3;
  if Transline.FormulaQtySoldValue4 =0 then Transline.FormulaQtySoldValue4 :=Transline.Product.FormulaQtyValue4;
  if Transline.FormulaQtySoldValue5 =0 then Transline.FormulaQtySoldValue5 :=Transline.Product.FormulaQtyValue5;

  if Transline.FormulaQtyShippedValue <> 0 then Transline.FormulaQtyShippedValue :=0;
  if Transline.FormulaQtyShippedValue1 =0 then Transline.FormulaQtyShippedValue1 :=Transline.Product.FormulaQtyValue1;
  if Transline.FormulaQtyShippedValue2 =0 then Transline.FormulaQtyShippedValue2 :=Transline.Product.FormulaQtyValue2;
  if Transline.FormulaQtyShippedValue3 =0 then Transline.FormulaQtyShippedValue3 :=Transline.Product.FormulaQtyValue3;
  if Transline.FormulaQtyShippedValue4 =0 then Transline.FormulaQtyShippedValue4 :=Transline.Product.FormulaQtyValue4;
  if Transline.FormulaQtyShippedValue5 =0 then Transline.FormulaQtyShippedValue5 :=Transline.Product.FormulaQtyValue5;


  if Transline.FormulaQtyValue <> 0 then Transline.FormulaQtyValue :=0;
  if Transline.FormulaQtyValue1 =0 then Transline.FormulaQtyValue1 :=Transline.Product.FormulaQtyValue1;
  if Transline.FormulaQtyValue2 =0 then Transline.FormulaQtyValue2 :=Transline.Product.FormulaQtyValue2;
  if Transline.FormulaQtyValue3 =0 then Transline.FormulaQtyValue3 :=Transline.Product.FormulaQtyValue3;
  if Transline.FormulaQtyValue4 =0 then Transline.FormulaQtyValue4 :=Transline.Product.FormulaQtyValue4;
  if Transline.FormulaQtyValue5 =0 then Transline.FormulaQtyValue5 :=Transline.Product.FormulaQtyValue5;

  Transline.PostDB;
  Transline.EditDB;

  end;
Procedure TPartCalcFormula.DoShowformulafields(Sender:TObject);
var
  comp :TComponent;
begin
  if not(Assigned(Sender)) then exit;
  if not(Sender is TComponent) then exit;
  Comp :=TComponent(Sender);
  while (Comp<> nil) and (not(Comp  is TBaseInputGUI)) do comp :=Comp.Owner;

  if (comp = nil) or (not(Comp  is TBaseInputGUI)) then exit;
  ShowFormulaQtyFields(TBaseInputGUI(Comp));
end;
Procedure TPartCalcFormula.MakeShowformulaFieldMenu(Grid:TwwDBGrid);
var
  NewItem : TMenuItem;
begin
  if Grid.PopupMenu = nil then exit;
  if Grid.PopupMenu.FindComponent('mnuPartCalcFormulaShowFormulafield') = nil then
    if AppEnv.companyPrefs.PartCalcfieldVisible then begin
      NewItem := TMenuItem.Create(Grid.PopupMenu);
      NewItem.Caption := 'Show Formula Fields';
      NewItem.OnClick := DoShowformulafields;
      Grid.PopupMenu.Items.Add(NewItem);
      NewItem.Name :=  'mnuPartCalcFormulaShowFormulafield';
    end;
end;
Procedure TPartCalcFormula.SetdisplayLabel(Transform :TBaseInputGUI);
begin
  if Transform is TBaseTransGUI then  begin
    With TBaseTransGUI(Transform) do begin
      if tbldetails.Findfield('FormulaQtySoldValue')<> nil then tbldetails.Findfield('FormulaQtySoldValue').DisplayLabel:='Formula Qty';
      if tbldetails.Findfield('FormulaQtySoldValue1')<> nil then tbldetails.Findfield('FormulaQtySoldValue1').DisplayLabel:=AppEnv.companyPrefs.PartCalcField1Name;
      if tbldetails.Findfield('FormulaQtySoldValue2')<> nil then tbldetails.Findfield('FormulaQtySoldValue2').DisplayLabel:=AppEnv.companyPrefs.PartCalcField2Name;
      if tbldetails.Findfield('FormulaQtySoldValue3')<> nil then tbldetails.Findfield('FormulaQtySoldValue3').DisplayLabel:=AppEnv.companyPrefs.PartCalcField3Name;
      if tbldetails.Findfield('FormulaQtySoldValue4')<> nil then tbldetails.Findfield('FormulaQtySoldValue4').DisplayLabel:=AppEnv.companyPrefs.PartCalcField4Name;
      if tbldetails.Findfield('FormulaQtySoldValue5')<> nil then tbldetails.Findfield('FormulaQtySoldValue5').DisplayLabel:=AppEnv.companyPrefs.PartCalcField5Name;

      if tbldetails.Findfield('FormulaQtyshippedValue')<> nil then tbldetails.Findfield('FormulaQtyshippedValue').DisplayLabel:='Formula Qty';
      if tbldetails.Findfield('FormulaQtyshippedValue1')<> nil then tbldetails.Findfield('FormulaQtyshippedValue1').DisplayLabel:=AppEnv.companyPrefs.PartCalcField1Name;
      if tbldetails.Findfield('FormulaQtyshippedValue2')<> nil then tbldetails.Findfield('FormulaQtyshippedValue2').DisplayLabel:=AppEnv.companyPrefs.PartCalcField2Name;
      if tbldetails.Findfield('FormulaQtyshippedValue3')<> nil then tbldetails.Findfield('FormulaQtyshippedValue3').DisplayLabel:=AppEnv.companyPrefs.PartCalcField3Name;
      if tbldetails.Findfield('FormulaQtyshippedValue4')<> nil then tbldetails.Findfield('FormulaQtyshippedValue4').DisplayLabel:=AppEnv.companyPrefs.PartCalcField4Name;
      if tbldetails.Findfield('FormulaQtyshippedValue5')<> nil then tbldetails.Findfield('FormulaQtyshippedValue5').DisplayLabel:=AppEnv.companyPrefs.PartCalcField5Name;
      MakeShowformulaFieldMenu(grdTransactions);
    end;
  end else if Transform is TSmartOrderGUI then begin
    With TSmartOrderGUI(Transform) do begin
      if tbldetails.Findfield('FormulaQtyValue') <> nil then tbldetails.Findfield('FormulaQtyValue').DisplayLabel :='Formula Qty';
      if tbldetails.Findfield('FormulaQtyValue1')<> nil then tbldetails.Findfield('FormulaQtyValue1').DisplayLabel:=AppEnv.companyPrefs.PartCalcField1Name;
      if tbldetails.Findfield('FormulaQtyValue2')<> nil then tbldetails.Findfield('FormulaQtyValue2').DisplayLabel:=AppEnv.companyPrefs.PartCalcField2Name;
      if tbldetails.Findfield('FormulaQtyValue3')<> nil then tbldetails.Findfield('FormulaQtyValue3').DisplayLabel:=AppEnv.companyPrefs.PartCalcField3Name;
      if tbldetails.Findfield('FormulaQtyValue4')<> nil then tbldetails.Findfield('FormulaQtyValue4').DisplayLabel:=AppEnv.companyPrefs.PartCalcField4Name;
      if tbldetails.Findfield('FormulaQtyValue5')<> nil then tbldetails.Findfield('FormulaQtyValue5').DisplayLabel:=AppEnv.companyPrefs.PartCalcField5Name;
      MakeShowformulaFieldMenu(grdLines);
    end;
  end else if Transform is TRepairsGUI then begin
    With TRepairsGUI(Transform) do begin
      if tblrepairparts.Findfield('FormulaQtyValue') <> nil then tblrepairparts.Findfield('FormulaQtyValue').DisplayLabel :='Formula Qty';
      if tblrepairparts.Findfield('FormulaQtyValue1')<> nil then tblrepairparts.Findfield('FormulaQtyValue1').DisplayLabel:=AppEnv.companyPrefs.PartCalcField1Name;
      if tblrepairparts.Findfield('FormulaQtyValue2')<> nil then tblrepairparts.Findfield('FormulaQtyValue2').DisplayLabel:=AppEnv.companyPrefs.PartCalcField2Name;
      if tblrepairparts.Findfield('FormulaQtyValue3')<> nil then tblrepairparts.Findfield('FormulaQtyValue3').DisplayLabel:=AppEnv.companyPrefs.PartCalcField3Name;
      if tblrepairparts.Findfield('FormulaQtyValue4')<> nil then tblrepairparts.Findfield('FormulaQtyValue4').DisplayLabel:=AppEnv.companyPrefs.PartCalcField4Name;
      if tblrepairparts.Findfield('FormulaQtyValue5')<> nil then tblrepairparts.Findfield('FormulaQtyValue5').DisplayLabel:=AppEnv.companyPrefs.PartCalcField5Name;
      MakeShowformulaFieldMenu(grdParts);
    end;
  end else if Transform is TfmStockTransferEntry then begin
    With TfmStockTransferEntry(Transform) do begin
      if tblDetails.Findfield('FormulaQtyValue') <> nil then tblDetails.Findfield('FormulaQtyValue').DisplayLabel :='Formula Qty';
      if tblDetails.Findfield('FormulaQtyValue1')<> nil then tblDetails.Findfield('FormulaQtyValue1').DisplayLabel:=AppEnv.companyPrefs.PartCalcField1Name;
      if tblDetails.Findfield('FormulaQtyValue2')<> nil then tblDetails.Findfield('FormulaQtyValue2').DisplayLabel:=AppEnv.companyPrefs.PartCalcField2Name;
      if tblDetails.Findfield('FormulaQtyValue3')<> nil then tblDetails.Findfield('FormulaQtyValue3').DisplayLabel:=AppEnv.companyPrefs.PartCalcField3Name;
      if tblDetails.Findfield('FormulaQtyValue4')<> nil then tblDetails.Findfield('FormulaQtyValue4').DisplayLabel:=AppEnv.companyPrefs.PartCalcField4Name;
      if tblDetails.Findfield('FormulaQtyValue5')<> nil then tblDetails.Findfield('FormulaQtyValue5').DisplayLabel:=AppEnv.companyPrefs.PartCalcField5Name;
      MakeShowformulaFieldMenu(SubformDetails);
    end;
  end else if Transform is TfmStockAdjustEntry then begin
    With TfmStockAdjustEntry(Transform) do begin
      if qryStockAdjustEntryLines.Findfield('FormulaQtyValue') <> nil then qryStockAdjustEntryLines.Findfield('FormulaQtyValue').DisplayLabel :='Formula Qty';
      if qryStockAdjustEntryLines.Findfield('FormulaQtyValue1')<> nil then qryStockAdjustEntryLines.Findfield('FormulaQtyValue1').DisplayLabel:=AppEnv.companyPrefs.PartCalcField1Name;
      if qryStockAdjustEntryLines.Findfield('FormulaQtyValue2')<> nil then qryStockAdjustEntryLines.Findfield('FormulaQtyValue2').DisplayLabel:=AppEnv.companyPrefs.PartCalcField2Name;
      if qryStockAdjustEntryLines.Findfield('FormulaQtyValue3')<> nil then qryStockAdjustEntryLines.Findfield('FormulaQtyValue3').DisplayLabel:=AppEnv.companyPrefs.PartCalcField3Name;
      if qryStockAdjustEntryLines.Findfield('FormulaQtyValue4')<> nil then qryStockAdjustEntryLines.Findfield('FormulaQtyValue4').DisplayLabel:=AppEnv.companyPrefs.PartCalcField4Name;
      if qryStockAdjustEntryLines.Findfield('FormulaQtyValue5')<> nil then qryStockAdjustEntryLines.Findfield('FormulaQtyValue5').DisplayLabel:=AppEnv.companyPrefs.PartCalcField5Name;
      MakeShowformulaFieldMenu(grdTransactions);
    end;
  end;
  end;
Procedure TPartCalcFormula.gridCalcCellColors(ProductHasCalcformula:Boolean; Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
if ProductHasCalcformula then begin
  {set the preference color for the qty fields}
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(Field.FieldName , 'UnitofMeasureShipped' )      then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(Field.FieldName , 'UnitofMeasureQty' )          then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(Field.FieldName , 'Shipped' )                   then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(Field.FieldName , 'RefundQty' )                 then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(Field.FieldName , 'UOMQty' )                    then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;//Repair
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyShippedValue' )   then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyShippedValue1' )  then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyShippedValue2' )  then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyShippedValue3' )  then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyShippedValue4' )  then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyShippedValue5' )  then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;

  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(Field.FieldName , 'UnitofMeasureQtySold' )  then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(Field.FieldName , 'QtySold' )               then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(Field.FieldName , 'RAQty' )                 then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfieldVisible  and SameText(Field.FieldName , 'FormulaQtySoldValue' )   then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtySoldValue1' ) then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtySoldValue2' ) then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtySoldValue3' ) then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtySoldValue4' ) then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtySoldValue5' ) then ABrush.Color := AppEnv.companyPrefs.QtySoldcolour;
  {smart order fields}
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyValue' )  then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyValue1' ) then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyValue2' ) then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyValue3' ) then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyValue4' ) then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;
  if AppEnv.companyPrefs.PartCalcfield1Visible  and SameText(Field.FieldName , 'FormulaQtyValue5' ) then ABrush.Color := AppEnv.companyPrefs.QtyShippedColour;

end;
  {hide formula values if 0}
  if AppEnv.companyPrefs.PartCalcfieldVisible  and
      ( SameText(Field.FieldName , 'FormulaQtyShippedValue' ) or
        SameText(Field.FieldName , 'FormulaQtyShippedValue1' ) or
        SameText(Field.FieldName , 'FormulaQtyShippedValue2' ) or
        SameText(Field.FieldName , 'FormulaQtyShippedValue3' ) or
        SameText(Field.FieldName , 'FormulaQtyShippedValue4' ) or
        SameText(Field.FieldName , 'FormulaQtyShippedValue5' ) or
        SameText(Field.FieldName , 'FormulaQtySoldValue' ) or
        SameText(Field.FieldName , 'FormulaQtySoldValue1' ) or
        SameText(Field.FieldName , 'FormulaQtySoldValue2' ) or
        SameText(Field.FieldName , 'FormulaQtySoldValue3' ) or
        SameText(Field.FieldName , 'FormulaQtySoldValue4' ) or
        SameText(Field.FieldName , 'FormulaQtySoldValue5' ) or
        SameText(Field.FieldName , 'FormulaQtyValue' ) or
        SameText(Field.FieldName , 'FormulaQtyValue1' ) or
        SameText(Field.FieldName , 'FormulaQtyValue2' ) or
        SameText(Field.FieldName , 'FormulaQtyValue3' ) or
        SameText(Field.FieldName , 'FormulaQtyValue4' ) or
        SameText(Field.FieldName , 'FormulaQtyValue5' )) then
        if Field.Asfloat = 0 then AFont.color := ABrush.color;
end;

end.

