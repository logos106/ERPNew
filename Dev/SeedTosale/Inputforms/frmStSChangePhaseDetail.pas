unit frmStSChangePhaseDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStSChangePhase, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, wwdbedit, wwdblook, StdCtrls, wwcheckbox, wwdbdatetimepicker,
  Wwdbgrid, Mask, Wwdbspin, Shader, DNMSpeedButton, DNMPanel;

type
  TfmStSChangePhaseDetail = class(TfmStSChangePhase)
    pnlList: TDNMPanel;
    Label2: TLabel;
    btnUseSameTag: TDNMSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    pnlTagPhasechanged: TDNMPanel;
    lblPhasechangeComplete: TLabel;
    Label9: TLabel;
    chkTagPhasechanged: TwwCheckBox;
    pnlQty: TDNMPanel;
    Label3: TLabel;
    Label7: TLabel;
    edtQty: TwwDBSpinEdit;
    pnlPhaseProduct: TDNMPanel;
    Label4: TLabel;
    Label8: TLabel;
    edtPhaseProduct: TEdit;
    btnchooseProduct: TDNMSpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure btnUseSameTagClick(Sender: TObject);
    procedure btnchooseProductClick(Sender: TObject);
    procedure ChoosePhase(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ChooseProductforPhase(Sender: TwwDBGrid);
    procedure filterSNProductsinlist(Sender: TObject);
    procedure AddTagsToNewPhase(var Abort: boolean; SelIndex: Integer);
  Protected
    procedure LocatenShowBin(aDeptID, abinID:Integer); Override;
    procedure ShowAvailableTags;Override;
    Function ProcessSelectedTags:Boolean;Override;
    Procedure InitForMode; Override;
    procedure ChooseProduct(aProductID:Integer);Override;
  public
    { Public declarations }
  end;


implementation

uses ProductListExpressForm, CommonFormLib, StSConst, CommonLib, BusObjStock,
  tcConst, dateutils, AppEnvironment, StSTags, BaseListingForm;

{$R *.dfm}
procedure TfmStSChangePhaseDetail.filterSNProductsinlist (Sender:TObject);
begin
  if sender is TProductListExpressGUI then begin
      TProductListExpressGUI(Sender).filterString :=  'PartType ='          + Quotedstr('INV')+
                                                      ' and SNtracking ='   + Quotedstr('T')+
                                                      ' and Multiplebins =' + Quotedstr('F') +
                                                      ' and Batch ='        + Quotedstr('F');
      TProductListExpressGUI(Sender).ListTimerMsg('This is the List of Inventory Products With Serial Number Tracking ( and Bin and Batch Disabled)');
  end;
end;

procedure TfmStSChangePhaseDetail.btnchooseProductClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TProductListExpressGUI',ChooseProductforPhase, filterSNProductsinlist,true, TERPConnection(StsTagObj.connection.connection));
  (*if NewPhaseSelected = '' then
  else if NewPhaseSelected = 'I' then  chooseProduct(StSTagObj.StSStrain.ImmatureProductID)
  else if NewPhaseSelected = 'V' then  chooseProduct(StSTagObj.StSStrain.VegetativeProductId)
  else if NewPhaseSelected = 'F' then  chooseProduct(StSTagObj.StSStrain.FloweringProductID)
  else if NewPhaseSelected = 'H' then ChooseProduct
  else if NewPhaseSelected = 'P' then ChooseProduct*)

end;

procedure TfmStSChangePhaseDetail.btnUseSameTagClick(Sender: TObject);
begin
  inherited;
  if newPhaseselected ='D' then begin
    MessageDlgXP_Vista('You Cannot Assign a Tag for "Destroy". Please Choose Save', mtInformation, [mbOK], 0);
    Exit;
  end;
  ststagphases.QtyPerTag := StsTagObj.Activecount;
  ststagphases.TagChanged := true;
  ststagphases.NoOfTags := 1;
  ststagphases.StsPhase := NewPhaseSelected;
  ststagphases.postdb;
  MessageDlgXP_Vista(Quotedstr(StSTagObj.StsTag) +' has ' + trim(inttostr(StSTagObj.ActiveCount))+' Plants.'+NL+
                             'Changing the Growth Phase Keeping the Same Tag.', mtWarning, [mbOK], 0);
  MakeNewTagRec(StsTagObj.StsTAG,ststagphases.QtyPerTag, StsTagObj.TagProductID);
  ststagphases.PhaseProductID := StSTagObj.PhaseProductID;
  StsTagObj.ChangedCount:= StsTagObj.ChangedCount +StsTagObj.Activecount;
  StsTagObj.PostDB;
  StSTag_Actions.StatusDate :=   dtUsedOn.datetime;
  StSTag_Actions.ActionQty  := 0-1;
  StSTag_Actions.PostDB;
  ststagphases.postdb;

  StSTag_Actions.New;
  StSTag_Actions.StatusDate := incsecond(dtUsedOn.datetime,-1);
  StSTag_Actions.StatusAction := STS_ACTION_Use_Plant_Tag;
  StSTag_Actions.StatusActionId := StsTagObj.NewStsAction(STS_ACTION_Use_Plant_Tag);
  StSTag_Actions.ActionQty := 1;
  StSTag_Actions.PostDB;

  StsTagObj.Save;
  CommitNestedTransaction;
  Modalresult := mrOk;

end;

procedure TfmStSChangePhaseDetail.ChoosePhase(Sender: TObject);
begin
  inherited;
  if NewPhaseSelected ='V' then begin
    edtQty.Enabled := False;
    btnUseSameTag.visible := False;
  end else if NewPhaseSelected ='F' then begin
    edtQty.Enabled := False;
    btnUseSameTag.visible := StsTagObj.StsPhase<>'I';
  end else begin
    edtQty.Enabled := true;
    btnUseSameTag.visible := StsTagObj.StsPhase<>'I';
  end;
  if newphaseselected ='D' then begin
    if assigned(fListStSTags) then
      fListStSTags.grdMain.UnselectAll;
  end;

end;

procedure TfmStSChangePhaseDetail.ChooseProduct(aProductID: Integer);
begin
  inherited;
  if StSTagObj.PhaseProductID <> 0 then begin
    with TProduct.create(Self) do try
      connection := StSTagObj.Connection;
      Load(StSTagObj.PhaseProductID);
      if count >0 then begin
        edtPhaseProduct.Text := ProductName;
        edtQty.text := FloattostrF(UOMSalesMultiplier, ffGeneral, 15,2);
      end;
    finally
      Free;
    end;
  end else edtPhaseProduct.Text := '';

end;

procedure TfmStSChangePhaseDetail.ChooseProductforPhase(Sender: TwwDBGrid);
begin
  ChooseProduct(TBaseListingGUI(Sender.Owner).SelectedID['PartsID']);
end;

procedure TfmStSChangePhaseDetail.FormCreate(Sender: TObject);
begin
  inherited;
  AdjustHeightRelativetoMain := True;
  Showcontrolhint(chkTagPhasechanged , 'When Checked, The Original Plant (and Tag) is Destroyed , Transfering it into the New Phase and New Tag(s) will be assigned.'+NL+
                                       'When Un-checked, New Plant(s) is Produced from the Current Plant and New Tag(s) Assigned for them , Leaving the Current Plant');

end;

procedure TfmStSChangePhaseDetail.FormDestroy(Sender: TObject);
begin
  Freeandnil(fListStSTags); StepProgressbar('. . . . . . . .');
  inherited;

end;

procedure TfmStSChangePhaseDetail.InitForMode;
begin
  inherited;
  chkTagPhasechanged.visible := devmode;
  if StSTagObj.count <>0 then begin
    lblPhasechangeComplete.caption := 'Is Tag '+Quotedstr(StSTagObj.StsTag)+' Completely Changed to the New Phase';
  end;
end;

procedure TfmStSChangePhaseDetail.LocatenShowBin(aDeptID, abinID: Integer);
  function ListFilterforClassID:String;
  begin
    REsult := 'DepartmentId = ' + inttostr(aDeptID);
  end;
begin
  inherited;
  if assigned(fListStSTags) and (fListStSTags.filterString <>ListFilterforClassID) then begin
    fListStSTags.GrdMain.UnSelectAll;
    fListStSTags.filterString := ListFilterforClassID;
    fListStSTags.ListMsg('List is of Available '+STS_CAPTION+' Tags from '+ quotedstr(trim(edtDept.text))+' '+ AppEnv.DefaultClass.ClassHeading);
  end;

end;
function TfmStSChangePhaseDetail.ProcessSelectedTags: Boolean;
begin
  Result := False;
  if fListStSTags.SelectedRecords <> 0 then begin
        ststagphases.NoOfTags := fListStSTags.SelectedRecords;
        if QtyPerTag=0 then edtQty.value := 1;
        if fListStSTags.SelectedRecords*QtyPerTag >StSTagObj.ActiveCount then begin
            MessageDlgXP_Vista(Quotedstr(StSTagObj.StsTag) +' has ' + trim(inttostr(StSTagObj.ActiveCount))+' Plants.'+NL+
                               'Changing Phase Cannot Produce More than '+ trim(inttostr(StSTagObj.ActiveCount))+' Plants.'+NL+
                               'You have Selected ' + trim(inttostr(fListStSTags.SelectedRecords*QtyPerTag))+'.', mtWarning, [mbOK], 0);
            Exit;
        end;
        if ststagphases.TagChanged and (fListStSTags.SelectedRecords*QtyPerTag <StSTagObj.ActiveCount) then
            ststagphases.TagChanged := fListStSTags.SelectedRecords*QtyPerTag =StSTagObj.ActiveCount;

        if fListStSTags.SelectedRecords*QtyPerTag <StSTagObj.ActiveCount then begin
            MessageDlgXP_Vista(Quotedstr(StSTagObj.StsTag) +' has ' + trim(inttostr(StSTagObj.ActiveCount))+' Plants.'+NL+
                               'For the New Phase , You Have Selected '+ trim(inttostr(fListStSTags.SelectedRecords*QtyPerTag))+'  Only.', mtWarning, [mbOK], 0);

        end;
        TStSTagsGUI(fListStSTags).IterateSelectedRecords(true); // ProcessTagOnIterateSelectedRecords := AddTagsToNewPhase;
        //StsTagObj.UsedOn      := dtUsedOn.datetime;
        ststagphases.PhaseProductID := StSTagObj.PhaseProductID;
        //StsTagObj.PhaseChanged:= chkTagPhasechanged.checked;
        StsTagObj.ChangedCount:= StsTagObj.ChangedCount +(fListStSTags.SelectedRecords*QtyPerTag);;
        StsTagObj.PostDB;
        StSTag_Actions.StatusDate :=   dtUsedOn.datetime;
        StSTag_Actions.ActionQty  :=0-StSTagPhases.noOfTags;
        StSTag_Actions.PostDB;
        ststagphases.postdb;
        StsTagObj.Save;
        Result := TRue;
  end;

end;

procedure TfmStSChangePhaseDetail.ShowAvailableTags;
begin
  CreateHistorylistform('TStSTagsGUI' ,Self, fListStSTags);
  if Assigned(fListStSTags) then begin
    fListStSTags.Parent := pnlList;
    fListStSTags.BorderStyle := bsNone;
    fListStSTags.fbIgnoreQuerySpeed := true;
    fListStSTags.Show;
    fListStSTags.grpFilters.itemindex :=1;// change index to 1 and then to 0, to fire the onchange event
    fListStSTags.grpFilters.itemindex :=0;
    fListStSTags.grpFilters.Visible := True;
    fListStSTags.EnableMultiSelect('Choose the Tags for the new Phase');
    TStSTagsGUI(fListStSTags).ProcessTagOnIterateSelectedRecords := AddTagsToNewPhase;
    fListStSTags.AlignWithMargins := True;
    fListStSTags.Margins.Left := 2;
    fListStSTags.Margins.Right:= 2;
    fListStSTags.Margins.Top:= 2;
    fListStSTags.Margins.Bottom:= 4;
  end;
end;
procedure TfmStSChangePhaseDetail.AddTagsToNewPhase(var Abort: boolean; SelIndex:Integer);
begin
  MakeNewTagRec(TStSTagsGUI(fListStSTags).qryMainSerialnumber.asString ,
                QtyPerTag,
                TStSTagsGUI(fListStSTags).SelectedProductID);
end;

end.
