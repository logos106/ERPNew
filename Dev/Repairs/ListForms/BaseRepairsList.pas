unit BaseRepairsList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/05/05  1.00.01 BJ   The list is filtered for all the repair records with
                        a completion date within the date range given
                        Also the records with blank completion date included
                        as the completion date is not compulsory any more.
                        (based on Preference).
                        Note : When the date is not given, it gets initialised
                        to 0 which is 30/12/1899. In order to display the
                        records, 30/12/1899 is replaced to null.
 07/09/05  1.00.02 IJB  Modified to use new filtering on base listing.
 25/10/05  1.00.03 DSP  Added 'Job Employee Name' field to the grid using a
                        lookup field. This displays the name of the employee
                        to whom the job is allocated.

}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,
  wwdblook, wwcheckbox, wwDialog, Wwlocate,BaseInputForm,
  SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker,
  ProgressDialog,  Shader, kbmMemTable, AdvOfficeStatusBar,
  DAScript, MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg(*, RepairsPrefs *);


type
  TBaseRepairsListGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    cboClassQry: TERPQuery;
    qryJobEmployeeName: TERPQuery;
    qryJobEmployeeNameEmployeeName: TWideStringField;
    qryJobEmployeeNameEmployeeID: TIntegerField;
    qryMainRepairID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainCreationDate: TDateField;
    qryMainDone: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainFeedbackNotes: TWideMemoField;
    qryMainCustomerDetails: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainFax: TWideStringField;
    qryMainJobDueDate: TDateTimeField;
    qryMainConverted: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainBillToCustomerDetails: TWideStringField;
    qryMainBillCusID: TIntegerField;
    qryMainUseBillCust: TWideStringField;
    qryMainBillPhone: TWideStringField;
    qryMainBillAltPhone: TWideStringField;
    qryMainBillFax: TWideStringField;
    qryMainSOGlobalRef: TWideStringField;
    qryMainQuoteGlobalRef: TWideStringField;
    qryMainCustomerPONumber: TWideStringField;
    qryMainCompletionTime: TWideStringField;
    qryMainShipping: TWideStringField;
    qryMainTerms: TWideStringField;
    qryMainBillMobile: TWideStringField;
    qryMainQuotedAmount: TFloatField;
    qryMainQuotedAmountinc: TFloatField;
    qryMainRepairClient: TWideStringField;
    qryMainBilltoclient: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainRepName: TWideStringField;
    grpdone: TRadioGroup;
    Listoption: TRadioGroup;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateTimeField;
    qryMainCUSTDATE2: TDateTimeField;
    qryMainCUSTDATE3: TDateTimeField;
    qryMainHoldRepair: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkAllClassClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure ListoptionClick(Sender: TObject);


  private
    fiformIndex: Integer;
    fbformshown:boolean;
    fiClientID: Integer;
    procedure setformIndex(const Value: Integer);
    (*fRepairPrefs :TRepairPrefs;*)
  protected
    procedure RefreshQuery; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
    Procedure SetGridColumns;override;
    procedure SetupFormInPanel; override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
  public
    Property formIndex :Integer Read fiformIndex Write setformIndex;
    Property clientID:Integer read fiClientID write fiClientID;
  end;

const   RepairListforms: array[0..4] of string =('TRepairsList','TRepairListParts','TRepairListEquipment','TRepairListTimesheet','TfmRepairsKPIList');

implementation

uses
  frmRepairs,   AppContextObj,
  DNMLib, CommonLib, Forms, AppEnvironment, FastFuncs, FormFactory,
  BusObjSales , CommonFormLib;

{$R *.dfm}

procedure TBaseRepairsListGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
  if (grpdone.Visible) and (grpdone.Items.Count > 0) then begin
    if GuiPrefs.Node.Exists('grpdone') then begin
      x := GuiPrefs.Node['grpdone.ItemIndex'].asInteger;
      if x > 0 then if grpdone.Items.Count >= x then grpdone.ItemIndex := x - 1;
    end;
  end;

end;

procedure TBaseRepairsListGUI.RefreshQuery;
var
  Value: string;
begin
  qryMain.Close;
  qryMain.ParamCheck := true;
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('dtfrom').AsDateTime := 0;
    qryMain.Params.ParamByName('dtto').AsDateTime := SysUtils.MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('dtfrom').AsString := FormatDateTime('yyyy-mm-dd 0:00:00', dtfrom.DateTime);
    qryMain.Params.ParamByName('dtto').AsString := FormatDateTime('yyyy-mm-dd 23:59:59', dtto.DateTime);
  end;

  if not chkAllClass.Checked then Value := cboClassQry.fieldbyname('Classid').asSTring else Value := '%';
  qryMain.Params.ParamByName('ClassID').AsString := Value;

  if fiClientID <> 0 then   Value := IntToStr(ClientID) else Value := '%';
  qryMain.Params.ParamByName('ClientID').AsString := Value;

  inherited;
end;


procedure TBaseRepairsListGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TRepairsGUI' , 0);
(*var
  Form: TComponent;
begin
  Form := GetComponentByClassName('TRepairsGUI');
  if Assigned(Form) then begin
    with TRepairsGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;*)
end;

procedure TBaseRepairsListGUI.grpFiltersClick(Sender: TObject);
  Procedure Addfilter(fsFilter:String);
  begin
    if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ' ;
    GroupFilterString := GroupFilterString +'(' + fsFilter +')';
  end;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:Addfilter( 'Converted = ' + QuotedStr('T'));
    1:Addfilter('Converted = ' + QuotedStr('F'));
  end;
  case grpdone.ItemIndex of
    0:Addfilter('Done = ' + QuotedStr('T'));
    1:Addfilter('Done = ' + QuotedStr('F'));
  end;
  inherited;
end;

procedure TBaseRepairsListGUI.FormShow(Sender: TObject);
 (* function findform:Integer;
    var ctr:Integer;
  begin
    result := -1;
      for ctr := low(Repairlistforms) to high(repairListforms) do
        if Sysutils.SameText(repairlistform[ctr] , self.calssname) then begin
          result := ctr;
          exit;
          end;
  end;*)
begin
  lblClassTitle.Caption := AppEnv.DefaultClass.ClassHeading;
  cboClassQry.Open;
  cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
  cboClass.LookupValue := IntToStr(AppEnv.DefaultClass.ClassID);
  cboClass.Text := AppEnv.DefaultClass.DefaultClassName;
  inherited;
  grpFiltersClick(Sender);

  fbformshown := True;
end;

procedure TBaseRepairsListGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TBaseRepairsListGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;
  RefreshQuery;
end;

procedure TBaseRepairsListGUI.FormCreate(Sender: TObject);
begin
  grdmain.UseTFields := True;
  fbformshown:= False;
  fbEnableWebSearch := true;
  fiClientID := 0;
  inherited;
  ShowChartViewOnPopup := True;
  fiformIndex := -1;
end;

procedure TBaseRepairsListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Sysutils.SameText(Field.fieldname , 'JobDueDate')   then
    if (qryMain.fieldbyname('JobDueDate').asDatetime = 0) then AFont.Color := ABrush.Color;
end;

procedure TBaseRepairsListGUI.setformIndex(const Value: Integer);
var
  Form : TBaseRepairsListGUI;
begin
  fiformIndex := Value;
  if fbformshown =False then exit;

  if ClassNameIs(RepairListforms[value]) then Exit;
  Form := TBaseRepairsListGUI(GetComponentByClassName(RepairListforms[value]));
  if assigned(Form) then begin
    Form.FormStyle := fsMDIChild;
    Form.Qrymain.Locate('repairID' , qryMainRepairID.asInteger , []);
    Form.formIndex := Value;
    Form.Listoption.ItemIndex := Value;
    Form.dtFrom.Date := dtFrom.Date;
    Form.dtto.Date := dtto.Date;
    Form.grpFilters.itemindex := grpFilters.itemindex ;
    Form.grpdone.itemindex    := grpdone.itemindex ;
    if Form.cboClass.text <>cboClass.text then begin
      Form.cboClass.text := cboClass.text;
      Form.cboClass.lookuptable.Locate('ClassName' ,cboClass.text , []);
      Form.cboClassCloseUp(Form.cboClass , Form.cboClass.lookuptable , nil , True);
    end;
    Form.chkAllClass.checked := chkAllClass.checked;
    Form.BringToFront;
    Self.close;
  end;
end;

procedure TBaseRepairsListGUI.ListoptionClick(Sender: TObject);
begin
  inherited;
  if fbformshown =False then exit;
  formIndex := Listoption.ItemIndex;
end;

procedure TBaseRepairsListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin

  if  (Sysutils.SameText(FormFact.Identifier , 'SOGlobalref')) or
      (Sysutils.SameText(FormFact.Identifier , 'QuoteGlobalref')) then begin
      Popupform.KeyId := TSales.IDToggle(Qrymain.fieldByname(FormFact.Identifier).asString);
  end else inherited;
end;

procedure TBaseRepairsListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('billcusId');
  RemoveFieldfromGrid('AllocatedEmployeeId');
  RemoveFieldfromGrid('Altphone');
  SetUpcustomFields('Repairs');
end;

procedure TBaseRepairsListGUI.SetupFormInPanel;
begin
  Listoption.Visible:= false;
  inherited;
  HeaderPanel.Height:= HeaderPanel.Height + Panel2.Height;
  Panel2.Height:= (Panel2.Height * 2) + 5;
  Panel4.Top:= HeaderPanel.Height - Panel4.Height - 1;

  grpDone.Left:= Panel4.Left + Panel4.Width + 5;
  grpDone.Top:= Panel4.Top; // - 3;

  grpFilters.Left:= grpDone.Left + grpDone.Width + 5;
  grpFilters.Top := grpDone.Top;

  lblFilter.Top:= lblFilter.Top + 4;
  cboFilter.Top:= cboFilter.Top + 4;
  lblSearchoptions.Top:= lblSearchoptions.Top + 4;
  lblSearchMode.Top:= lblSearchMode.Top + 4;
  edtSearch.Top:= edtSearch.Top + 4;
  lblFrom.Top:= lblFrom.Top + 4;
  dtFrom.Top:= dtFrom.Top + 4;
  lblTo.Top:= lblTo.Top + 4;
  dtTo.Top:= dtTo.Top + 4;
end;

procedure TBaseRepairsListGUI.WriteGuiPrefExtra;
begin
  inherited;
  if (grpdone.Visible) and (grpdone.Items.Count > 0) then begin
    GuiPrefs.Node['grpdone.ItemIndex'].asInteger := grpdone.ItemIndex + 1;
  end;
end;

end.
