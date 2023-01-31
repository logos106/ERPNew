unit frmStSChangePhase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStSInputBase, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, Shader, DNMSpeedButton, DNMPanel, StdCtrls, IntegerListObj,
  Spin, wwdbdatetimepicker, Mask, wwdbedit, Wwdbspin, wwcheckbox, BusObjSeedToSale,
  wwdblook, BaseListingForm;

type
  TfmStSChangePhase = class(TfmStSInputBase)
    pnlPlantPhaseOptions: TDNMPanel;
    Label1: TLabel;
    Shape4: TShape;
    Shape6: TShape;
    Shape7: TShape;
    btnImmature: TDNMSpeedButton;
    btnVegetative: TDNMSpeedButton;
    btnFlowering: TDNMSpeedButton;
    btnHarvest: TDNMSpeedButton;
    btnDestroy: TDNMSpeedButton;
    dsStSTagPhases: TDataSource;
    QryBin: TERPQuery;
    QryBinbin: TWideStringField;
    QryBinClassId: TIntegerField;
    QryBinbinId: TIntegerField;
    pnDetails: TDNMPanel;
    pnlDept: TDNMPanel;
    Label6: TLabel;
    edtDept: TwwDBEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    pnlUsedOn: TDNMPanel;
    Label5: TLabel;
    dtUsedOn: TwwDBDateTimePicker;
    pnlcbobin: TDNMPanel;
    lblbin: TLabel;
    cbobin: TwwDBLookupCombo;
    btnPackage: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChoosePhase(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QryBinBeforeOpen(DataSet: TDataSet);
    procedure cbobinEnter(Sender: TObject);
    procedure QryBinAfterOpen(DataSet: TDataSet);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure cbobinCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
  private
    SelectedPhase: TDNMSpeedButton;
    fNewTagIds: TIntegerList;
    fStSTagPhases : TStSTagPhases;
    fStSTag_Actions : TStSTag_Actions;
    procedure PanelBoardes;
    procedure HidePanelborders(Sender: TObject);
    procedure Phasebuttons;
    procedure setStSTagPhases(const Value: TStSTagPhases);
    function ValidateForSave: boolean;
    procedure initSelectFromList(Sender: TObject);
    procedure OnSelectfromSelectFromList(Sender: TObject);
    function IsSimpleMode: Boolean;
  Protected
    fiNewPhaseClassID:Integer;
    fiNewPhaseBinID:Integer;
    fListStSTags: TBaseListingGUI;
    function ButtonToExcludeFromFormating: String; Override;
    procedure LocatenShowBin(aDeptID, abinID:Integer); Virtual;
    procedure ShowAvailableTags; Virtual;
    procedure ChooseProduct(aProductID:Integer);Virtual;
    Function QtyPerTag :Integer;
    Procedure InitForMode; virtual;
    Function ProcessSelectedTags:Boolean;virtual;Abstract;
    procedure MakeNewTagRec(const NewTag: String; TagQty,TagProductID: Integer);
    procedure changePhaseWithSameTag;
  public
    function NewPhaseSelected: String;
    Property NewTagIds :TIntegerList read fNewTagIds;
    Property StSTagPhases   :TStSTagPhases    read fStSTagPhases    write setStSTagPhases;
    Property StSTag_Actions :TStSTag_Actions  read fStSTag_Actions  write fStSTag_Actions;
  end;

implementation

uses StSTags, CommonLib, tcConst,
  BusobjProduct, BusObjStock, LogLib, StSConst, dateutils,
  FrmSelectFromList, StSClassBinList, AppEnvironment, tcDataUtils,
  frmStSChangePhaseSimple, frmStSChangePhaseDetail;


{$R *.dfm}

{ TfmStSChangePhase }


procedure TfmStSChangePhase.btnCloseClick(Sender: TObject);
begin
  inherited;
  RollbackNestedTransaction;
  Modalresult := mrCancel;
end;
Function TfmStSChangePhase.ValidateForSave : boolean;
begin
  Result := False;

  fNewTagIds.clear;
  if (SelectedPhase = nil) or (NewPhaseSelected ='') then begin
    MessageDlgXP_Vista('Please Choose the New Phase', mtWarning, [mbOK], 0);
    Exit;
  end;

  if StsTagObj.PhaseProductID =0 then begin
      MessageDlgXP_Vista('Please Choose the The Product for Selected Phase '+ quotedstr(SelectedPhase.caption)+'.' , mtWarning, [mbOK], 0);
      Exit;
  end;

  Result := True;
end;
procedure TfmStSChangePhase.btnCompletedClick(Sender: TObject);
begin
  inherited;
  ststagphases.NoOfTags := StSTagObj.count ;
  ststagphases.StsPhase := NewPhaseSelected;
  ststagphases.postdb;

  if not ValidateForSave then exit;

  if StSTagObj.count >0 then begin
    if newPhaseselected ='D' then begin
      StsTagObj.StsPhase    := NewPhaseSelected;
      StsTagObj.Destroycount:= StsTagObj.Destroycount +QtyPerTag;
      StsTagObj.PostDB;
      StsTagObj.Save;
    end else begin
      if not ProcessSelectedTags then exit;
    end;
  end;

  CommitNestedTransaction;
  Modalresult := mrOk;
end;
Procedure TfmStSChangePhase.changePhaseWithSameTag;
begin
        MakeNewTagRec(StsTagObj.StsTAg, StsTagObj.Plantcount, StsTagObj.TagProductID);

        {using same tag - bring it back into stock }
        StsTagObj.StSTag_Actions.New;
        StsTagObj.StSTag_Actions.StatusDate     := incsecond(dtUsedOn.DateTime, -1);
        StsTagObj.StSTag_Actions.StatusAction   := STS_ACTION_ReUse_Plant;
        StsTagObj.StSTag_Actions.ActionQty      := 1;
        StsTagObj.StSTag_Actions.StSProductID   := 0;
        StsTagObj.StSTag_Actions.TagProductID   := StsTagObj.TagProductID;
        StsTagObj.StSTag_Actions.StatusActionId := TStSTags.NewStsAction(STS_ACTION_ReUse_Plant);
        StsTagObj.StSTag_Actions.PostDB;
        StsTagObj.Save;
end;
procedure TfmStSChangePhase.ChoosePhase(Sender: TObject);
begin
  inherited;
  if not (sender is TDNMSpeedButton) then exit;
  if SelectedPhase = TDNMSpeedButton(Sender) then exit;

  SelectedPhase := TDNMSpeedButton(Sender);

  Hidehighlightcontrol;
  Highlightcontrol(SelectedPhase);
  ChooseProduct(0);
  (*chkTagPhasechanged.checked*)StsTagPhases.TagChanged := (NewPhaseselected <>'H') and (NewPhaseselected<>'P') and (NewPhaseselected<>'D') and (NewPhaseselected<>'P');
  if NewPhaseSelected ='V' then begin
    ststagphases.QtyPerTag := 1;
    ststagphases.PostDB;
  end else if NewPhaseSelected ='F' then begin
    ststagphases.QtyPerTag := 1;
    ststagphases.PostDB;
  end;
  ststagphases.PostDB;
  LocatenShowBin(fiNewPhaseClassID,fiNewPhaseBinID);
end;

function TfmStSChangePhase.ButtonToExcludeFromFormating: String;
begin
  Result :=  btnPackage.name    +','+
             btnDestroy.name    +','+
             btnImmature.name   +','+
             btnVegetative.name +','+
             btnFlowering.name +','+
             btnHarvest.name ;
end;

procedure TfmStSChangePhase.cbobinCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  fiNewPhaseBinID := Qrybinbinid.asInteger;
end;

procedure TfmStSChangePhase.cbobinEnter(Sender: TObject);
begin
  inherited;
  closedb(QryBin);
  opendb(QryBin);
end;

procedure TfmStSChangePhase.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  TFmSelectFromList.SelectFromList(self, 'TStSClassBinListGUI',  'Classid' , initSelectFromList, OnSelectfromSelectFromList, true);
end;
procedure TfmStSChangePhase.initSelectFromList(Sender: TObject);
begin

end;
procedure TfmStSChangePhase.OnSelectfromSelectFromList(Sender: TObject);
begin
  if sender is  TFmSelectFromList then
    if TFmSelectFromList(Sender).Listfrom is TStSClassBinListGUI then begin
      LocatenShowBin(TStSClassBinListGUI(TFmSelectFromList(Sender).Listfrom).qryMainClassID.asInteger, TStSClassBinListGUI(TFmSelectFromList(Sender).Listfrom).qryMainBinId.asInteger);
    end;
end;

procedure TfmStSChangePhase.ChooseProduct(aProductID:Integer);
begin
  if (aProductID<>0) and (StSTagObj.PhaseProductID = aProductID) then exit;
  StSTagPhases.PhaseProductID :=aProductID;
  StSTagPhases.PostDB;
  if SelectedPhase = nil then begin
    StSTagObj.PhaseProductID :=0;
  end else if aProductID <> 0 then begin
    StSTagObj.PhaseProductID :=aProductID;
  end else   if NewPhaseSelected ='I' then StSTagObj.PhaseProductID := StSTagObj.StSStrain.ImmatureProductID
        else if NewPhaseSelected ='V' then StSTagObj.PhaseProductID := StSTagObj.StSStrain.VegetativeProductId
        else if NewPhaseSelected ='F' then StSTagObj.PhaseProductID := StSTagObj.StSStrain.FloweringProductID
        else StSTagObj.PhaseProductID :=0;
end;
procedure TfmStSChangePhase.FormCreate(Sender: TObject);
function btnsHelp:String;
begin
  result := '';
  if (NewPhaseSelected ='I') or (NewPhaseSelected='') then
    Result := Result +NL + 'Immature Phase : Usually Have Multiples in a Tray on one Tag.  So Select a Tag and Select the Plant Count'
  else if (NewPhaseSelected ='V')  then
    Result := Result +NL + 'Vegetative - One tag for one Plant.'+NL+'Choose the Tags for each Plants'
  else if (NewPhaseSelected ='F')  then
    Result := Result +NL + 'Flowering - One tag for one Plant.'+NL+'Choose the Tags for each Plants'
  else if (NewPhaseSelected ='P')  then
    Result := Result +NL + 'Product - Making Other Plants / Products.'+NL+'Choose the Tags for each one of them.' + NL+'The Original Plant(Tag) will be Active'
  else if (NewPhaseSelected ='H')  then
    Result := Result +NL + 'Harvest - Making Other Plants / Products.'+NL+'Choose the Tags for each one of them.' + NL+'The Original Plant(Tag) will be Active'
  else if (NewPhaseSelected ='D')  then
    Result := Result +NL + 'Destroy - No Tag Selection Allowed. This Plant is Destroyed';


end;
Function PhasePropertiesHelp :String;
begin

end;
begin
  inherited;
  fListStSTags := nil;
  InitForMode;
  cbobin.visible := Appenv.companyPrefs.StSUsesBins;
  lblbin.visible := Appenv.companyPrefs.StSUsesBins;


  SelectedPhase:= nil;
  fNewTagIds := TIntegerList.create;
  MakehelpButton(pnlPlantPhaseOptions,btnsHelp           , '', 175, 0);
  //MakehelpButton(pnlDetails          ,PhasePropertiesHelp,'', 450, 80);
  {with MakehelpButton(pnlPlantPhaseOptions,'Change To Phase'+NL+
                                       'Allows to Change the Phase of a plant.'(*+NL+
                                       'sadsadsa'+NL+
                                       'sdcedsdsfs sdf sfds'+NL+
                                       'sdlif sopfu fossfopj'+NL+
                                       'sdfu sdofjfidos f sdiofjsd'+NL+
                                       'weoiu wofmsklf lsdjk'+NL+
                                       'sdl jfljsdfldsjlsfj'+NL+
                                       'woeiw pdfjdsmnfd'+NL+
                                       'sdp iwemskjf ksdlfj'+NL+
                                       'weoi rwporjsmfs'+NL+
                                       'eps ofsfmlsdfmsd l;f'+NL+
                                       'seopf slf;fm,sd;lf'+NL+
                                       'weopri sf,lsdmdx,'+NL+
                                       'sdklfs l;fksdl;fdsk'+NL+
                                       'sadsadsa'+NL+
                                       'sdcedsdsfs sdf sfds'+NL+
                                       'sdlif sopfu fossfopj'+NL+
                                       'sdfu sdofjfidos f sdiofjsd'+NL+
                                       'weoiu wofmsklf lsdjk'+NL+
                                       'sdl jfljsdfldsjlsfj'+NL+
                                       'woeiw pdfjdsmnfd'+NL+
                                       'sdp iwemskjf ksdlfj'+NL+
                                       'weoi rwporjsmfs'+NL+
                                       'eps ofsfmlsdfmsd l;f'+NL+
                                       'seopf slf;fm,sd;lf'+NL+
                                       'weopri sf,lsdmdx,'+NL+
                                       'sdklfs l;fksdl;fdsk'+NL+
                                       'sadsadsa'+NL+
                                       'sdcedsdsfs sdf sfds'+NL+
                                       'sdlif sopfu fossfopj'+NL+
                                       'sdfu sdofjfidos f sdiofjsd'+NL+
                                       'weoiu wofmsklf lsdjk'+NL+
                                       'sdl jfljsdfldsjlsfj'+NL+
                                       'woeiw pdfjdsmnfd'+NL+
                                       'sdp iwemskjf ksdlfj'+NL+
                                       'weoi rwporjsmfs'+NL+
                                       'eps ofsfmlsdfmsd l;f'+NL+
                                       'seopf slf;fm,sd;lf'+NL+
                                       'weopri sf,lsdmdx,'+NL+
                                       'sdklfs l;fksdl;fdsk'+NL+
                                       'sadsadsa'+NL+
                                       'sdcedsdsfs sdf sfds'+NL+
                                       'sdlif sopfu fossfopj'+NL+
                                       'sdfu sdofjfidos f sdiofjsd'+NL+
                                       'weoiu wofmsklf lsdjk'+NL+
                                       'sdl jfljsdfldsjlsfj'+NL+
                                       'woeiw pdfjdsmnfd'+NL+
                                       'sdp iwemskjf ksdlfj'+NL+
                                       'weoi rwporjsmfs'+NL+
                                       'eps ofsfmlsdfmsd l;f'+NL+
                                       'seopf slf;fm,sd;lf'+NL+
                                       'weopri sf,lsdmdx,'+NL+
                                       'sdklfs l;fksdl;fdsk'+NL+
                                       'dsjfhsdkl fjhsdkfj'*)) do begin
    align := alnone;
    Left := 177;
    Top := 3;
    Height := 24;
  end;
  With MakehelpButton(pnlImmature   , 'Flag the Plant as in Immature Phase'   ) do begin end;
  With MakehelpButton(pnlVegetative , 'Flag the Plant as in Vegetative Phase' ) do begin end;
  With MakehelpButton(pnlFlowering  , 'Flag the Plant as in Flowering Phase'  ) do begin end;
  With MakehelpButton(pnlHarvest    , 'Flag the Plant as in Harvest Phase'    ) do begin end;
  With MakehelpButton(pnlPackage    , 'Flag the Plant as in Product Phase'    ) do begin end;
  With MakehelpButton(pnlDestroy    , 'Flag the Plant as in Destroy Phase'    ) do begin end;

  With MakehelpButton(pnlQty        , 'This is the Quantity Assigned to the New Tags Selected. '+NL+
                                      'Only applicable if Tag is changed'    ) do begin  end;
(*       align := alLeft;
       Margins.bottom := 7;
       Margins.Left := 0;
       Margins.Left := 70;
       Margins.right := 3;
       Margins.Top := 3;
       lblQtyhint.left := Left + width+10;
  end;*) }

end;

procedure TfmStSChangePhase.FormDestroy(Sender: TObject);
begin
  ShowProgressbar(WAITMSG,10);
  try
      StepProgressbar('.');
      Freeandnil(fNewTagIds);
      StepProgressbar('. .');
      inherited;
      StepProgressbar('. . . . . . . . .');
  finally
    HideProgressbar;
  end;
end;

procedure TfmStSChangePhase.FormShow(Sender: TObject);
  Procedure InitPhasebutton(btn:TDNMSpeedButton; btnActive:boolean);
  begin
    btn.enabled := btnActive and (AccessManager.accesslevel <5);
  end;
begin
  inherited;
  ChooseProduct(0);
  dtUsedOn.datetime := now;
  if StSTagObj.count <> 0 then begin
    InitPhasebutton(btnImmature   , StSTagObj.StsPhase ='');
    InitPhasebutton(btnVegetative , StSTagObj.StsPhase ='I');
    InitPhasebutton(btnFlowering  , StSTagObj.StsPhase ='V');
    InitPhasebutton(btnHarvest    , StSTagObj.StsPhase ='F');
    InitPhasebutton(btnPackage    , (StSTagObj.StsPhase ='I') or (StSTagObj.StsPhase ='V') );
//    InitPhasebutton(btnDestroy    , true);
    ShowAvailableTags;
  end;
  PanelBoardes;
  Phasebuttons;
  OpenQueries;
  edtDept.Text := StsTagObj.Dept;
  LocatenShowBin(StsTagObj.DeptId, StsTagObj.BinId);
end;
Procedure TfmStSChangePhase.LocatenShowBin(aDeptID, abinID:Integer);
begin
  fiNewPhaseClassID := aDeptID;
  fiNewPhaseBinID := aBinID;
  edtDept.Text := GetClassName(fiNewPhaseClassID);
  closedb(QryBin);
  opendb(QryBin);
  if QryBin.Locate('classid;binid', vararrayof([fiNewPhaseClassID,fiNewPhaseBinID]), []) then
    cbobin.Text :=QryBinbin.asString;
end;


Function TfmStSChangePhase.NewPhaseSelected:String;
begin
       if SelectedPhase = btnImmature   Then Result := 'I'
  else if SelectedPhase = btnVegetative Then Result := 'V'
  else if SelectedPhase = btnFlowering  Then Result := 'F'
  else if SelectedPhase = btnHarvest    Then Result := 'H'
  else if SelectedPhase = btnPackage    Then Result := 'P'
  else if SelectedPhase = btnDestroy    Then Result := 'D'
  else Result := '';
end;

procedure TfmStSChangePhase.MakeNewTagRec(const NewTag :String; TagQty:integer; TagProductID:Integer);
begin

  BeginNestedTransaction;
  try
    if StsTagObj.CloneBusObj('StSTag' ,NewTag, False) <> nil then begin
      try

        TStSTags(StsTagObj.ObjInstancetoclone).StsPhase                 := NewPhaseSelected;
        TStSTags(StsTagObj.ObjInstancetoclone).StSTagPhaseID            := StsTagPhases.ID;
        TStSTags(StsTagObj.ObjInstancetoclone).StSActionID              := StSTag_Actions.ID;
        TStSTags(StsTagObj.ObjInstancetoclone).TagProductID             := TagProductID;
        TStSTags(StsTagObj.ObjInstancetoclone).SourceTagID              := StsTagObj.ID;
        TStSTags(StsTagObj.ObjInstancetoclone).SourceTag                := StsTagObj.StSTag;
        TStSTags(StsTagObj.ObjInstancetoclone).Sourcetype               := STS_SOURCE_TYPE_New_Growth_Phase;
        TStSTags(StsTagObj.ObjInstancetoclone).UsedOn                   := dtUsedOn.datetime;
        TStSTags(StsTagObj.ObjInstancetoclone).Plantcount               := TagQty;
        TStSTags(StsTagObj.ObjInstancetoclone).ChangedCount             := 0;
        TStSTags(StsTagObj.ObjInstancetoclone).WastedCount              := 0;
        TStSTags(StsTagObj.ObjInstancetoclone).Destroycount             := 0;
        TStSTags(StsTagObj.ObjInstancetoclone).TransferedCount          := 0;
        TStSTags(StsTagObj.ObjInstancetoclone).UsedCount                := 0;
        TStSTags(StsTagObj.ObjInstancetoclone).EmployeeId               := StsTagObj.employeeId;
        TStSTags(StsTagObj.ObjInstancetoclone).PhaseProductID           := StSTagObj.PhaseProductID;
        TStSTags(StsTagObj.ObjInstancetoclone).ReplacedByTagID          := 0;
        if (fiNewPhaseClassID) <> 0 then begin
          TStSTags(StsTagObj.ObjInstancetoclone).DeptID :=fiNewPhaseClassID;
          if fiNewPhaseBinID <> 0 then TStSTags(StsTagObj.ObjInstancetoclone).BinId :=fiNewPhaseBinID;
        end;
(*        TStSTags(StsTagObj.ObjInstancetoclone).TagProduct_SMLineID      := 0;
        TStSTags(StsTagObj.ObjInstancetoclone).PlantProduct_SMLineID    := 0;
        TStSTags(StsTagObj.ObjInstancetoclone).PlantProductUsed_SMLineID:= 0;*)
        TStSTags(StsTagObj.ObjInstancetoclone).InitfieldsAfterclone;
        TStSTags(StsTagObj.ObjInstancetoclone).PostDB;
        TStSTags(StsTagObj.ObjInstancetoclone).UseTag;
        TStSTags(StsTagObj.ObjInstancetoclone).MakePlant(TagQty);

        if TStSTags(StsTagObj.ObjInstancetoclone).Save then begin
          fNewTagIds.add(TStSTags(StsTagObj.ObjInstancetoclone).ID);
          commitnestedTransaction;
        end else begin
          RollbacknestedTransaction;
        end;
      finally
        Freeandnil(StsTagObj.ObjInstancetoclone);
      end;
    end;
  Except
    on E:Exception do begin
      RollbacknestedTransaction;
    end;
  end;

end;
 procedure TfmStSChangePhase.HidePanelborders(Sender:TObject);
 begin
   if sender is TDnMPanel then begin
        TDnMPanel(Sender).Bevelinner := bvNone;
        TDnMPanel(Sender).BevelOuter := bvNone;
        TDnMPanel(Sender).Bevelkind  := bkNone;
        TDnMPanel(Sender).BorderStyle := bsnone;
   end;
 end;
Function TfmStSChangePhase.IsSimpleMode:Boolean;
begin
  REsult := Self is TfmStSChangePhaseSimple;
end;
procedure TfmStSChangePhase.InitForMode;
begin
(*  pnlQty.Visible := not(IsSimpleMode);
  pnlPhaseProduct.Visible := not(IsSimpleMode);
  pnlTagPhasechanged.Visible := not(IsSimpleMode);*)
  TitleLabel.Caption := 'Change of Phase';
end;

procedure TfmStSChangePhase.Phasebuttons;
var
  I, J: Integer;
begin
  With btnImmature    do begin top := 37; width := trunc(pnlPlantPhaseOptions.Width/6);end;
  With btnVegetative  do begin top := 37; width := trunc(pnlPlantPhaseOptions.Width/6);end;
  With btnFlowering   do begin top := 37; width := trunc(pnlPlantPhaseOptions.Width/6);end;
  With btnHarvest     do begin top := 37; width := trunc(pnlPlantPhaseOptions.Width/6);end;
  With btnPackage     do begin top := 37; width := trunc(pnlPlantPhaseOptions.Width/6);end;
//  With btnDestroy     do begin top := 37; width := trunc(pnlPlantPhaseOptions.Width/6);end;
  setlength(buttons,5);
  buttons[0] := 'btnImmature';
  buttons[1] := 'btnVegetative';
  buttons[2] := 'btnFlowering';
  buttons[3] := 'btnHarvest';
  buttons[4] := 'btnPackage';
//  buttons[5] := 'btnDestroy';

  with pnlPlantPhaseOptions do
    for I := 0 to Pred(ControlCount) do
      if Controls[I] is TDNMSpeedButton then
        for J := Low(Buttons) to High(Buttons) do
        begin
          Controls[I].Visible := SameText(Buttons[J], Controls[I].Name);
          if Controls[I].Visible then Break;
        end;

  Centralisebuttons(pnlPlantPhaseOptions);
end;
procedure TfmStSChangePhase.QryBinAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if StsTagObj.BinId <> 0 then
    QryBin.locate('binid', StsTagObj.binid, []);
end;

procedure TfmStSChangePhase.QryBinBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if fiNewPhaseClassID =0 then fiNewPhaseClassID := StsTagObj.DeptID;
  QryBin.parambyname('ClassID').asInteger := fiNewPhaseClassID;
end;

function TfmStSChangePhase.QtyPerTag: Integer;
begin
  Result := StSTagPhases.Qtypertag;  //trunc(edtQty.value);
end;

procedure TfmStSChangePhase.setStSTagPhases(const Value: TStSTagPhases);
begin
  fStSTagPhases := Value;
  dsStSTagPhases.dataset :=fStSTagPhases.dataset;
end;

procedure TfmStSChangePhase.ShowAvailableTags;
begin

end;

procedure TfmStSChangePhase.PanelBoardes;
var
  fIndex: integer;
begin
  for fIndex := 0 to ControlCount - 1 do begin
    if Controls[fIndex] is TDNMPanel then begin
      SetDnMPanelProperties(TDNMPanel(Controls[fIndex]), HidePanelborders);
    end;
  end;
end;
end.
