unit frmTransProductSpec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, wwclearbuttongroup, wwradiogroup, wwdblook,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, Shader, Mask, wwdbedit, DNMSpeedButton,
  DNMPanel , BusObjFeTransLines, busobjbase;

type
  TfmTransProductSpec = class(TBaseInputGUI)
    qryFieldNames: TERPQuery;
    qryFieldNamesFormulaEntryID: TIntegerField;
    qryFieldNamesFormulaEntryName: TWideStringField;
    qryFieldNamesFormulaEntryNO: TIntegerField;
    qryformula: TERPQuery;
    qryformulaFormulaID: TIntegerField;
    qryformulaFormulaName: TWideStringField;
    qryformulaFormula: TWideStringField;
    QryRelatedPRLookup: TERPQuery;
    StringField1: TWideStringField;
    IntegerField1: TIntegerField;
    pnlFooter: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlHeader: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtProductName: TwwDBEdit;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    edtFormula: TEdit;
    btnchooseformula: TDNMSpeedButton;
    edtFormulaWithValue: TEdit;
    DNMPanel2: TDNMPanel;
    Bevel1: TBevel;
    grdRelatedPr: TwwDBGrid;
    grdRelatedPrIButton: TwwIButton;
    cboProductX: TwwDBLookupCombo;
    cboFormula: TwwDBLookupCombo;
    pnlProduct: TDNMPanel;
    grdProductGroup: TwwDBGrid;
    grpFilters: TwwRadioGroup;
    Bevel41: TBevel;
    btnUpdateshipped: TDNMSpeedButton;
    btnUpdateOrderd: TDNMSpeedButton;
    LblMsg: TLabel;
    DNMPanel1: TDNMPanel;
    lblformulaValue1: TLabel;
    lblformulaValue2: TLabel;
    procedure grpFiltersClick(Sender: TObject);
    procedure btnchooseformulaClick(Sender: TObject);
    procedure grdProductGroupEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnUpdateOrderdClick(Sender: TObject);
    procedure btnUpdateshippedClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdProductGroupIButtonClick(Sender: TObject);
  private
    fDoBusinessObjectEvent :TBusObjEvent;
    function ShippedGroupname: String;
    procedure SetFETransLines(const Value: TFETransLines);

  Protected
    fFETransLines :TFETransLines;

    procedure Selectformula(Sender: TwwDbGrid);Virtual;abstract;
    procedure LocateFormula(Sender: TObject);Virtual;abstract;
    procedure DoShowFormulaValue(FELines : TFETransLines) ;Virtual;
    Procedure AfterFormShow; Override;
    Procedure InitShipQtyfromsold(const onlyWhenBlank:Boolean); Virtual;
    Procedure InitsoldQtyfromShipped(const onlyWhenBlank:Boolean); Virtual;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
    procedure DeleteLine;

  public
    Property FETransLines :TFETransLines REad fFETransLines Write SetFETransLines;
  end;

implementation

uses CommonLib, CommonFormLib, AppEnvironment,
  frmSalesProductSpec, Sales, tcConst, LogLib, BusObjConst;

{$R *.dfm}


procedure TfmTransProductSpec.DeleteLine;
var
  isFiltered :Boolean;
  fId :Integer;
begin
  isFiltered :=fFETransLines.Lines.dataset.filtered;
  fFETransLines.Lines.dataset.disableControls;
  try
      fId :=fFETransLines.Lines.ID;
      fFETransLines.Lines.Dataset.filtered := False;
      fFETransLines.Lines.Dataset.Locate('FESalesLineID' , fId , []);
      fFETransLines.Lines.Deleted:= true;
      if fFETransLines.Lines.Count > 0 then fFETransLines.Lines.PostDB;
  finally
      fFETransLines.Lines.Dataset.filtered := isFiltered;
      fFETransLines.Lines.dataset.EnableControls;
  end;
end;


procedure TfmTransProductSpec.AfterFormShow;
begin
  inherited;
  grpFiltersClick(grpFilters);
  Setcontrolfocus(grdProductGroup);
end;

procedure TfmTransProductSpec.btnchooseformulaClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TfmProductformulaList' , Selectformula , LocateFormula);
end;

procedure TfmTransProductSpec.grdProductGroupEnter(Sender: TObject);
begin
  inherited;
   if qryFieldNames.REcordcount = 0 then begin
       CommonLib.MessageDlgXP_Vista('This is a Formula attached product. But as none of the formula entries are defined, it is not possible to select the related product for this porduct. ' +chr(13) +chr(13)+
        'The option to create the formula entries are available in the main menu[Inventroy->Product Formula Entry]' , mtWarning , [mbOK] , 0);
        self.modalresult := mrok;
        Self.Close;
        Exit;
   end;
      if qryformula.REcordcount = 0 then begin
       CommonLib.MessageDlgXP_Vista('This is a Formula attached product. But as none of the formula are defined, it is not possible to select the related product for this porduct. ' +chr(13) +chr(13)+
        'The option to create the formula entries are available in the main menu[Inventroy->Product Formula]' , mtWarning , [mbOK] , 0);
        self.modalresult := mrok;
        Self.Close;
        Exit;
   end;
end;
procedure TfmTransProductSpec.grdProductGroupIButtonClick(Sender: TObject);
begin
  inherited;
    if not Assigned(FETransLines) then Exit;
    if (fFETransLines.Lines.Count > 0) or (fFETransLines.Lines.Dataset.State = dsInsert) then begin
        if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
            DeleteLine;
        end;
    end;

end;

procedure TfmTransProductSpec.SetFETransLines(const Value: TFETransLines);
begin
  fFETransLines := Value;
  fDoBusinessObjectEvent :=fFETransLines.BusObjEvent ;
  fFETransLines.BusObjEvent := DoBusinessObjectEvent;
end;

Function TfmTransProductSpec.ShippedGroupname:String; begin if self is TfmSalesProductSpec then result := 'Shipped' else result := 'Received'; end;

procedure TfmTransProductSpec.grpFiltersClick(Sender: TObject);
var
  FieldList: TStringList;

begin
  inherited;
  if not IsFormshown then exit;
  FieldList:= TStringList.create;
  try
    if grpfilters.itemindex =0 then begin
      if Appenv.Companyprefs.Fe1Visible and ((fFETransLines.Formula.FormulatypeId=0) or  fFETransLines.Formula.FeFormulaType.Fe1visible) then FieldList.add(SelectedText('field1' , Appenv.Companyprefs.Fe1Name,12, 'Ordered Quantity'));
      if Appenv.Companyprefs.Fe2Visible and ((fFETransLines.Formula.FormulatypeId=0) or  fFETransLines.Formula.FeFormulaType.Fe2visible) then FieldList.add(SelectedText('field2' , Appenv.Companyprefs.Fe2Name,12, 'Ordered Quantity'));
      if Appenv.Companyprefs.Fe3Visible and ((fFETransLines.Formula.FormulatypeId=0) or  fFETransLines.Formula.FeFormulaType.Fe3visible) then FieldList.add(SelectedText('field3' , Appenv.Companyprefs.Fe3Name,12, 'Ordered Quantity'));
      if Appenv.Companyprefs.Fe4Visible and ((fFETransLines.Formula.FormulatypeId=0) or  fFETransLines.Formula.FeFormulaType.Fe4visible) then FieldList.add(SelectedText('field4' , Appenv.Companyprefs.Fe4Name,12, 'Ordered Quantity'));
      if Appenv.Companyprefs.Fe5Visible and ((fFETransLines.Formula.FormulatypeId=0) or  fFETransLines.Formula.FeFormulaType.Fe5visible) then FieldList.add(SelectedText('field5' , Appenv.Companyprefs.Fe5Name,12, 'Ordered Quantity'));
    end else begin
      if Appenv.Companyprefs.Fe1Visible and ((fFETransLines.Formula.FormulatypeId=0) or  fFETransLines.Formula.FeFormulaType.Fe1visible) then FieldList.add(SelectedText('Shippedfield1' , Appenv.Companyprefs.Fe1Name,12, ShippedGroupname+' Quantity'));
      if Appenv.Companyprefs.Fe2Visible and ((fFETransLines.Formula.FormulatypeId=0) or  fFETransLines.Formula.FeFormulaType.Fe2visible) then FieldList.add(SelectedText('Shippedfield2' , Appenv.Companyprefs.Fe2Name,12, ShippedGroupname+' Quantity'));
      if Appenv.Companyprefs.Fe3Visible and ((fFETransLines.Formula.FormulatypeId=0) or  fFETransLines.Formula.FeFormulaType.Fe3visible) then FieldList.add(SelectedText('Shippedfield3' , Appenv.Companyprefs.Fe3Name,12, ShippedGroupname+' Quantity'));
      if Appenv.Companyprefs.Fe4Visible and ((fFETransLines.Formula.FormulatypeId=0) or  fFETransLines.Formula.FeFormulaType.Fe4visible) then FieldList.add(SelectedText('Shippedfield4' , Appenv.Companyprefs.Fe4Name,12, ShippedGroupname+' Quantity'));
      if Appenv.Companyprefs.Fe5Visible and ((fFETransLines.Formula.FormulatypeId=0) or  fFETransLines.Formula.FeFormulaType.Fe5visible) then FieldList.add(SelectedText('Shippedfield5' , Appenv.Companyprefs.Fe5Name,12, ShippedGroupname+' Quantity'));
    end;
    if not(sametext(grdProductGroup.selected.text ,FieldList.text)) then begin
      grdProductGroup.selected.Clear;
      grdProductGroup.selected.text :=FieldList.text;
      grdProductGroup.Applyselected;
    end;
  finally
    Freeandnil(FieldList);
  end;

end;

procedure TfmTransProductSpec.InitShipQtyfromsold(const onlyWhenBlank:Boolean);
begin
  inherited;
  if not(onlyWhenBlank) or ( (fFETransLines.Shippedfield1=0) and
      (fFETransLines.Shippedfield2=0) and
      (fFETransLines.Shippedfield3=0) and
      (fFETransLines.Shippedfield4=0) and
      (fFETransLines.Shippedfield5=0)) then begin
        fFETransLines.Shippedfield1 := fFETransLines.field1;
        fFETransLines.Shippedfield2 := fFETransLines.field2;
        fFETransLines.Shippedfield3 := fFETransLines.field3;
        fFETransLines.Shippedfield4 := fFETransLines.field4;
        fFETransLines.Shippedfield5 := fFETransLines.field5;
        TimerMsg(LblMsg , '''Ordered'' is Copied into '+Quotedstr(ShippedGroupname));
      end;

end;

procedure TfmTransProductSpec.InitSoldQtyfromShipped(const onlyWhenBlank:Boolean);
begin
  inherited;
  if not(onlyWhenBlank) or ( (fFETransLines.field1=0) and
      (fFETransLines.field2=0) and
      (fFETransLines.field3=0) and
      (fFETransLines.field4=0) and
      (fFETransLines.field5=0)) then begin
        fFETransLines.field1 := fFETransLines.Shippedfield1;
        fFETransLines.field2 := fFETransLines.Shippedfield2;
        fFETransLines.field3 := fFETransLines.Shippedfield3;
        fFETransLines.field4 := fFETransLines.Shippedfield4;
        fFETransLines.field5 := fFETransLines.Shippedfield5;
        TimerMsg(LblMsg , Quotedstr(ShippedGroupname)+' is Copied into ''Ordered''');
      end;

end;
procedure TfmTransProductSpec.btnUpdateshippedClick(Sender: TObject);begin  inherited;  InitShipQtyfromsold(False);end;
procedure TfmTransProductSpec.btnUpdateOrderdClick(Sender: TObject);begin  inherited;  InitsoldQtyfromShipped(False);end;

procedure TfmTransProductSpec.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  if assigned(fDoBusinessObjectEvent) then fDoBusinessObjectEvent(Sender , Eventtype , Value);
  inherited;
end;
procedure TfmTransProductSpec.DoShowFormulaValue(FELines : TFETransLines) ;
begin
  if assigned(FELines) then begin
    lblformulaValue1.caption :=trim('Ordered Qty'           + NL +FELines.FormulaWithValueSold   );lblformulaValue1.REfresh;
    lblformulaValue2.caption :=trim(ShippedGroupname+' Qty' + NL +FELines.FormulaWithValueShipped);lblformulaValue2.REfresh;
  end;
end;

procedure TfmTransProductSpec.FormCreate(Sender: TObject);
begin
inherited;
  grpfilters.items[1] := ShippedGroupname;
  btnUpdateshipped.caption := ShippedGroupname+' = Ordered' ;
  btnUpdateOrderd.caption := 'Ordered = ' + ShippedGroupname;
  Showcontrolhint(btnUpdateshipped, 'Update All ' + quotedstr(ShippedGroupname +' Quantities')+' from the ' + quotedstr('Ordered Quantities'));
  Showcontrolhint(btnUpdateOrderd,  'Update All  ' + quotedstr('Ordered Quantities')+' from the ' + quotedstr(ShippedGroupname +' Quantity'));


end;

procedure TfmTransProductSpec.FormDestroy(Sender: TObject);
begin
  fFETransLines.BusObjEvent := fDoBusinessObjectEvent;
  inherited;

end;

end.
