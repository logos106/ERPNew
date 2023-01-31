unit frmProdAttribMatrixBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, ComCtrls, Buttons,
  Wwdbigrd, Wwdbgrid, Grids, BaseGrid, AdvGrid, GradientLabel, StdCtrls,
  ExtCtrls, Shader, DNMPanel, ImgList, Menus, AdvMenus, DataState,
  Contnrs, SelectionDialog, AppEvnts, BusobjProdAttribGroup, BusObjBase, AdvObj,
  ProgressDialog;

type
  TfmProdAttribMatrixBase = class(TBaseInputGUI)
    Image1: TImage;
    pnlCaption: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Subform: TPanel;
    pnlLookupAttribs: TDNMPanel;
    blClass: TBevel;
    lblclass: TLabel;
    blAttributes: TBevel;
    cboClass: TComboBox;
    pnlDetails: TPanel;
    Bevel1: TBevel;
    lblXAttribute: TGradientLabel;
    lblYAttribute: TGradientLabel;
    grdMatrix: TAdvStringGrid;
    pnlProducts: TDNMPanel;
    grdSelection: TwwDBGrid;
    grdSelectionButton: TwwIButton;
    ProgressBar: TProgressBar;
    DSToBeCreated: TDataSource;
    qryToBeCreated: TERPQuery;
    QryClasses: TERPQuery;
    dsClasses: TDataSource;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMatrixEnter(Sender: TObject);
    procedure FormShow(Sender: TObject); overload;
    procedure qryToBeCreatedAfterOpen(DataSet: TDataSet);
    procedure SubformResize(Sender: TObject);
  private

    fiAttribGroupID: Integer;
    procedure Addcols(Const Sender: Tbusobj; Var Abort :Boolean); overload;
    procedure Addrows(Const Sender: Tbusobj; Var Abort :Boolean); overload;
    Function LookupAttribs:String;
    function getAttributeGroups: TProdAttribGroups;



  Protected
    Tablename       : STring;
    StrinGList      : TstringList;
    XAttributeName  : String;
    YAttributeName  : String;
    ButtonTop       : Integer;
    comboList       : TcomponentList;

    procedure SetUpAttributes;overload;
    procedure SetUpAttributes(Const Sender: Tbusobj; Var Abort :Boolean); overload;
    Function EnableLookups:Boolean ; virtual; abstract;
    procedure comboCloseUP(Sender: TObject); virtual;
    function CurrentRecord(c,r:Integer) :String;Virtual;
    function NumericCellvalue(col, row:Integer):double;
    Procedure InitForm;virtual;abstract;
    Procedure RefreshDetails;virtual;
    Procedure RunSQL(strSQL:String; const inTrans :boolean = False);
  public
    fProductattributegroups : TProdAttribGroups ;
    Property AttribGroupID :Integer   Read fiAttribGroupID  Write fiAttribGroupID;
    Procedure SetupGrid;virtual;
    procedure FormShow; overload;Virtual;
    Property AttributeGroups : TProdAttribGroups read getAttributeGroups;
  end;

implementation

uses ProductAttributeLib, FastFuncs, CommonLib, CommonDbLib,
  frmProdAttribMain, LanguageTranslationObj, JSONObject, LogLib;





{$R *.dfm}
procedure TfmProdAttribMatrixBase.SetUpAttributes;
var
  xvisible, yVisible:Boolean;
begin
   if AttributeGroups.AttributeNames.count = 0 then Exit;
   grdMatrix.RowCount := 0;
   grdMatrix.colcount := 1;
   xvisible :=  lblXAttribute.visible;
   yvisible :=  lblYAttribute.visible;

   AttributeGroups.AttributeNames.IterateRecords(SetUpAttributes);
   if xvisible <> lblYAttribute.visible  then
     if lblYAttribute.visible = False then begin
         grdMatrix.Top := grdMatrix.Top   - lblYAttribute.height;
         grdMatrix.height:= grdMatrix.height + lblYAttribute.height;
     end else begin
         grdMatrix.Top := grdMatrix.Top   + lblYAttribute.height;
         grdMatrix.height:= grdMatrix.height - lblYAttribute.height;
     end;
   if yvisible <>lblXAttribute.visible then
     if lblXAttribute.visible = false then begin
         grdMatrix.left := grdMatrix.left  - lblxAttribute.width;
         grdMatrix.width:= grdMatrix.width + lblxAttribute.width;
     end else begin
         grdMatrix.left := grdMatrix.left  + lblxAttribute.width;
         grdMatrix.width:= grdMatrix.width - lblxAttribute.width;
     end;
   pnlLookupAttribs.visible := EnableLookups;
   if grdMatrix.colcount = 1 then begin
      lblYAttribute.visible := False;
      grdMatrix.colcount := 2;
   end;
   if grdMatrix.rowcount = 1 then begin
    lblXAttribute.visible := False;
    grdMatrix.rowcount := 2;
   end;
   if grdMatrix.colcount> 1 then grdMatrix.FixedCols := 1;
   if grdMatrix.rowcount> 1 then grdMatrix.FixedRows := 1;
end;

procedure TfmProdAttribMatrixBase.SetUpAttributes(const Sender: Tbusobj;var Abort: Boolean);
begin
  if not(Sender is TProdAtribName) then Exit;
  if TProdAtribName(Sender).ProductAttributeValues.count = 0 then exit;
  StrinGList.Add('alter table ' + Tablename + ' Add column `' +TProdAtribName(Sender).AttribName + '` varchar(255);');
  StrinGList.Add('alter table ' + Tablename + ' Add column `' +TProdAtribName(Sender).AttribName + '_ID` int(11);');
  (*StrinGList.Add('update ' + tablename + ' as tmp inner join tblproductattributeproducts pap set tmp.`' +TProdAtribName(Sender).AttribName + '` = pap.attribValue where pap.ProductId = tmp.ProductID and pap.attribname = ' +quotedStr(TProdAtribName(Sender).AttribName)+';');*)
  //StrinGList.Add('update ' + tablename + ' as tmp set tmp.`' +TProdAtribName(Sender).AttribName + '` = (Select pap.attribValue  from tblproductattributeproducts pap where pap.ProductId = tmp.ProductID and pap.attribname = ' +quotedStr(TProdAtribName(Sender).AttribName)+');');

  StrinGList.Add('Drop table if exists ' + Tablename + '1;');
  StrinGList.Add('Create table  ' + Tablename + '1 Select pap.attribValue ,PAV.PAV_ID , PAP.ProductID ' +
                ' From tblproductattributegroups PAG ' +
                ' inner join tblproductattributenames PAN on PAG.PAG_ID = PAN.PAG_ID' +
                ' inner join tblproductattributevalues PAV on PAN.PAN_ID = PAV.PAN_ID' +
                ' inner join tblproductattributeproducts PAP on PAP.PAG_ID = PAG.PAG_ID and PAP.AttribName = PAN.Name and PAP.AttribValue = PAV.Value' +
                ' inner join ' + tablename + ' as tmp on PAP.ProductID = Tmp.productId ' +
                ' where pap.attribname = ' +quotedStr(TProdAtribName(Sender).AttribName)+';');

(*  StrinGList.Add('update tblproductattributegroups PAG ' +
                ' inner join tblproductattributenames PAN on PAG.PAG_ID = PAN.PAG_ID' +
                ' inner join tblproductattributevalues PAV on PAN.PAN_ID = PAV.PAN_ID' +
                ' inner join tblproductattributeproducts PAP on PAP.PAG_ID = PAG.PAG_ID and PAP.AttribName = PAN.Name and PAP.AttribValue = PAV.Value' +
                ' inner join ' + tablename + ' as tmp on PAP.ProductID = Tmp.productId ' +
                ' set tmp.`' +TProdAtribName(Sender).AttribName + '` = pap.attribValue   ,  ' +
                ' tmp.`' +TProdAtribName(Sender).AttribName + '_ID` = PAV.PAV_ID  ' +
                ' where pap.attribname = ' +quotedStr(TProdAtribName(Sender).AttribName)+';');*)

    StrinGList.Add('update ' + tablename + '  T inner join ' + tablename + '1 as T1 on T.productId = T1.ProductId '+
              ' set T.`' +TProdAtribName(Sender).AttribName + '` = T1.attribValue   , '+
              'T.`' +TProdAtribName(Sender).AttribName + '_ID` = T1.PAV_ID;');

    StrinGList.Add('Drop table if exists ' + Tablename + '1;');

  if (TProdAtribName(Sender).ID = AttributeGroups.XAxisAttributeID) then begin
    XAttributeName :=TProdAtribName(Sender).Attribname;
    TProdAtribName(Sender).ProductAttributeValues.IterateREcords(Addrows);
    lblXAttribute.Caption := XAttributeName+'          ';
    lblXAttribute.visible := True;
  end else if (TProdAtribName(Sender).ID = AttributeGroups.YAxisAttributeID) then begin
    YAttributeName:=TProdAtribName(Sender).Attribname;
    TProdAtribName(Sender).ProductAttributeValues.IterateREcords(AddCols);
    lblYAttribute.Caption := '                          ' + YAttributeName;
    lblYAttribute.visible := True;
  end else begin
     ComboList.Add(ProductAttributeLib.AddComboBox(Self,TProdAtribName(Sender).AttribName ,
                   ButtonTop, cButtonLeft, cButtonWidth,
                   pnlLookupAttribs , comboCloseUP,
                   TProdAtribName(Sender).ProductAttributeValues.dataset , 'Value',
                   IntToStr(TProdAtribName(Sender).Dataset.recno)));
     if blAttributes.visible = False then begin
        blAttributes.visible := True;
        blAttributes.top     := ButtonTop-5;
     end;
     blAttributes.Height := blAttributes.Height + 50;
     ButtonTop := ButtonTop + 50;
  end;
end;

procedure TfmProdAttribMatrixBase.FormDestroy(Sender: TObject);
begin
  Freeandnil(comboList);
  if qryToBeCreated.active then qryToBeCreated.close;
  qryToBeCreated.connection := nil;
  if Assigned(fProductattributegroups) and
     Assigned(fProductattributegroups.Owner) and
     (fProductattributegroups.Owner = self) then FreeandNil(fProductattributegroups);
  {NOTE table is destroyed when we have finished with its connection (see TempTableUtils)}
  //  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TfmProdAttribMatrixBase.Addcols(const Sender: Tbusobj;
  var Abort: Boolean);
begin
   if not(Sender is TProdAtribValue) then exit;
   grdMatrix.ColCount := grdMatrix.ColCount + 1;
   grdMatrix.Alignments[grdMatrix.ColCount-1,0] := taRightJustify;
   grdMatrix.Cells[grdMatrix.ColCount-1,0] :=TProdAtribValue(Sender).Value;
    if char_length(grdmatrix.cells[grdMatrix.ColCount-1,0])<= 10 then
    else grdMatrix.ColWidths[grdMatrix.ColCount-1] := grdMatrix.defaultcolwidth+ (char_length(grdmatrix.cells[grdMatrix.ColCount-1,0])-10)*8;
end;

procedure TfmProdAttribMatrixBase.Addrows(const Sender: Tbusobj;
  var Abort: Boolean);
begin
   if not(Sender is TProdAtribValue) then exit;
   grdMatrix.Rowcount := grdMatrix.Rowcount + 1;
   grdMatrix.Cells[0,grdMatrix.Rowcount-1] := TProdAtribValue(Sender).Value;
   grdMatrix.AutoSizeCol(0,10);
end;

procedure TfmProdAttribMatrixBase.FormCreate(Sender: TObject);
begin
  inherited;
  ButtonTop := cButtonTopStart;
  comboList       := nil;
  Self.Color      := GetGradientColor(Self.Owner.Classname).color;
  UseDefaultColor := False;
  fProductattributegroups := nil;

end;
procedure TfmProdAttribMatrixBase.comboCloseUP(Sender: TObject);
begin
  inherited;
  TComboBox(Sender).Text := TComboBox(Sender).Items[TComboBox(Sender).itemindex];
  SetControlFocus(grdMatrix);
  
end;

function TfmProdAttribMatrixBase.getAttributeGroups: TProdAttribGroups;
begin
  if fProductattributegroups = nil then begin
      if (Assigned(Self.Owner)) and (Self.Owner is TfmProdAttribMain) then begin
          fProductattributegroups := TfmProdAttribMain(Self.Owner).AttributeGroups;
      end else begin
        fProductattributegroups := TProdAttribGroups.Create(Self);
        fProductattributegroups.connection := TMyDacDataConnection.Create(fProductattributegroups);
        fProductattributegroups.connection.connection := qryToBeCreated.connection;
        fProductattributegroups.Load(AttribGroupID);
      end;
  end;
  REsult := fProductattributegroups;
end;

procedure TfmProdAttribMatrixBase.grdMatrixEnter(Sender: TObject);
var
  i :Integer;
begin
  inherited;
  if comboList.count > 0 then
    for i := 0 to comboList.count-1 do
      if TComboBox(comboList[i]).text = '' then begin
         SetControlFocus(TComboBox(comboList[i]));
         break
      end;
end;
function TfmProdAttribMatrixBase.LookupAttribs: String;
var
  strSQL:String;
  i:Integer;
  cmp:Tcomponent;
begin
  strSQL:= '';
  for i := 0 to comboList.count-1 do begin
    cmp:= FindComponent(StringReplace(comboList[i].name, 'Attribcombo' , 'Attriblabel' , [rfIgnoreCase]));
    if Assigned(cmp) then begin
      if strSQL <> '' then strSQL := strSQL +' and ';
      strSQL:=  strSQL + '`' + TLanguageTranslationObj.Inst.DoTranslateToEnglish(TLabel(cmp).Caption) + '`  = ' + QuotedStr(TcomboBox(comboList[i]).text);
    end;
  end;
  result := strSQL;
end;

function TfmProdAttribMatrixBase.CurrentRecord(c,r:Integer): String;
begin
  Result := LookupAttribs;

  if XAttributeName <> '' then begin
    if Result <> '' then Result := Result +' and ';
    Result := Result + '`' + XAttributeName + '` = ' +QuotedStr(EncodeString(grdMatrix.Cells[0, r]));
  end;
  if YAttributeName <> '' then begin
    if Result <> '' then Result := Result +' and ';
    Result := Result + '`' + YAttributeName + '` = ' +QuotedStr(EncodeString(grdMatrix.Cells[c, 0]));
  end;
end;
function TfmProdAttribMatrixBase.NumericCellvalue(col,  row: Integer): double;
var
  celltext:String;
begin
  Result := 0;
  celltext := grdMatrix.Cells[Col, row];
  if isnumeric(Celltext) then result := strtofloat(Celltext);
end;

procedure TfmProdAttribMatrixBase.FormShow(Sender: TObject);
begin
    FormShow;
end;
procedure TfmProdAttribMatrixBase.qryToBeCreatedAfterOpen(DataSet: TDataSet);
var
  i:Integer;
  totWidth :Integer;
  totGridWidth:Integer;
begin
  inherited;
  qryToBeCreated.fieldByname('ProductID').Visible := false;
  qryToBeCreated.fieldByname('AutoID').Visible    := false;
  qryToBeCreated.fieldByname('DepartmentID').visible :=False;
  qryToBeCreated.fieldByname('ProductActive').visible :=False;
  totWidth := 0;
  for i := 0 to qryToBeCreated.FieldCount-1 do begin
    if length(qryToBeCreated.Fields[i].fieldname)> 3 then
      if sametext(copy(qryToBeCreated.Fields[i].fieldname , length(qryToBeCreated.Fields[i].fieldname)-2 , 3) , '_ID') then
        qryToBeCreated.Fields[i].visible := False;
    if qryToBeCreated.Fields[i].visible then begin
      qryToBeCreated.Fields[i].DisplayWidth := 10;
      totWidth := totWidth +qryToBeCreated.Fields[i].DisplayWidth;
    end;
  end;
  totGridWidth:= 83;
  if totWidth>totGridWidth then totWidth := 20 else totWidth := 20 + totGridWidth-totWidth;
  qryToBeCreated.fieldByname('ProductName').DisplayWidth := totWidth;
end;
procedure TfmProdAttribMatrixBase.FormShow;
var
  cmp:Tcomponent;
begin
  DisableForm;
  try
    inherited FormShow(self);
    blAttributes.visible :=False;
    blAttributes.height := 0;
    if assigned(comboList) then begin
      While comboList.Count <> 0 do begin
        cmp:= FindComponent(StringReplace(comboList[0].name, 'Attribcombo' , 'Attriblabel' , [rfIgnoreCase]));
        if assigned(cmp) then cmp.free;
        comboList.Items[0].Free;
      end;
      FreeAndNil(comboList);
    end;
    comboList       := TcomponentList.create;
    
    ProcessingCursor(True);
    try
      (*Productattributegroups := TProdAttribGroups.Create(Self);
      if (Assigned(Self.Owner)) and (Self.Owner is TfmProdAttribMain) then
          Productattributegroups.connection := TfmProdAttribMain(Self.Owner).AttributeGroups.Connection
      else begin
        Productattributegroups.connection := TMyDacDataConnection.Create(Productattributegroups);
        Productattributegroups.connection.connection := qryToBeCreated.connection;
      end;
      Productattributegroups.Load(AttribGroupID);
      *)


      if AttributeGroups.count = 0 then exit;
      TitleLabel.Caption := AttributeGroups.GroupName;
      AttributeGroups.AssignXnYAttibs; // picks up the first 2 as x and Y if not assigned already
      StrinGList:=TstringList.create;
      try

        initForm;
        (*StrinGList.add('update ' +tablename + ' as tmp  inner join tblParts P on tmp.ProductID = P.PartsId set tmp.ProductActive  = P.Active;');*)
        {binny - inner join in the update query lock the parts table
        so using sub query - will have to do a load test to knwo the speed}
        StrinGList.add('update ' +tablename + ' as tmp  set tmp.ProductActive  = ( sELECT P.Active FROM tblParts as P where tmp.ProductID = P.PartsId  );');
        StrinGList.add('update ' +tablename + ' as tmp  set tmp.ProductActive  = ( sELECT if(P.Discontinued ="T" , "F" , "T") FROM tblParts as P where tmp.ProductID = P.PartsId  ) where ProductActive ="T";');
        logtext(Self.classname);
        logtext(StrinGList.text);
        try
          RunSQL(StrinGList.text, false);
        Except
          on E:Exception do begin
            logtext(E.message);
          end;
        end;
        logtext('1:===================================');
        StrinGList.clear;
        SetUpAttributes;
        if AttributeGroups.YAxisAttributeID = 0 then begin
            YAttributeName := '';
            grdMatrix.ColCount := 2;
            grdMatrix.Cells[grdMatrix.ColCount-1,0] :='Quantity';
            grdMatrix.FixedCols := 1;
        end;
        logtext(StrinGList.text);
        try
          RunSQL(StrinGList.text, false);
        Except
          on E:Exception do begin
            logtext(E.message);
          end;
        end;
        logtext('2:===================================');
      Finally
          StrinGList.Free;
      end;
        if qryToBeCreated.active then qryToBeCreated.close;
        qryToBeCreated.SQL.clear;
        qryToBeCreated.SQL.add('select * from ' +tablename );
        qryToBeCreated.SQL.add('Order by  ' + AttributeGroups.OrderbyAttributeNameIds);

        qryToBeCreated.filterSQL := 'Qty <> 0';
        qryToBeCreated.Active := True;
        RefreshDetails;
        SetControlFocus(grdMatrix);
        grdMatrix.Invalidate;
        pnlDetails.Invalidate;
        self.Refresh;
        pnlDetails.Refresh;

    finally
        ProcessingCursor(False);
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmProdAttribMatrixBase.RunSQL(strSQL: String;
  const inTrans: boolean);
begin
  if inTrans then ExecuteSQL(strSQL ,qryToBeCreated.connection) else ExecuteSQL(strSQL);
end;

procedure TfmProdAttribMatrixBase.REfreshDetails;
begin
// descendants will override if necessary
end;

procedure TfmProdAttribMatrixBase.SetupGrid;
begin
  FormShow;
end;

procedure TfmProdAttribMatrixBase.SubformResize(Sender: TObject);
begin
  inherited;
//  pnlProducts.Height:= Trunc(Height /3);
end;

end.

