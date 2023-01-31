unit frmStSChangePhaseSimple;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStSChangePhase, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, wwdbedit, wwdblook, StdCtrls, wwcheckbox, wwdbdatetimepicker,
  Mask, Wwdbspin, Shader, DNMSpeedButton, DNMPanel, Grids, Wwdbigrd, Wwdbgrid,
  Buttons;

type
  TSelectedTag = record
    StsTag:String;
    ProductId:Integer;
  end;

  TfmStSChangePhaseSimple = class(TfmStSChangePhase)
    DNMPanel1: TDNMPanel;
    btnChooseTags: TDNMSpeedButton;
    btnUseSameTag: TDNMSpeedButton;
    dsSelectedTags: TDataSource;
    QrySelectedTags: TERPQuery;
    QrySelectedTagsStsTag: TWideStringField;
    pnlSelectedTags: TDNMPanel;
    grdSelectedTags: TwwDBGrid;
    btnGrid: TwwIButton;
    Label2: TLabel;
    lblMsg: TLabel;
    procedure ChoosePhase(Sender: TObject);
    procedure btnChooseTagsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QrySelectedTagsBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnUseSameTagClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnImmatureEnter(Sender: TObject);
  private
    SelectedTag : Array of TSelectedTag;
    function MultipleTagsForNewPhase: Boolean;
    procedure initStSTags(Sender: TObject);
    procedure SelectStSTag(Sender: TwwDbGrid);
    Procedure UnselectAll(InitWithSameTag:boolean=False);
    procedure AddTagsforNewPhase(var Abort: boolean; SelIndex: Integer);
    procedure RefreshSelectedTags;
    procedure AddTagsToNewPhase;
    procedure OpenHarvest;
    procedure OpenPackage;
  Protected
    Function ProcessSelectedTags:Boolean;Override;

  public
    { Public declarations }
  end;


implementation

uses AppEnvironment, CommonFormLib, StSTags, CommonLib, tcConst, tcDataUtils,
     frmStSHarvest, frmStSCreatePackage, frmStSMain;

{$R *.dfm}

{ TfmStSChangePhaseSimple }

procedure TfmStSChangePhaseSimple.btnChooseTagsClick(Sender: TObject);
begin
  inherited;
  try
    if MultipleTagsForNewPhase then
         OpenERPListFormultiselectModal('TStSTagsGUI',initStSTags , SelectStSTag)
    else OpenERPListFormSingleselectModal('TStSTagsGUI', SelectStSTag,initStSTags );
  finally
    fListStSTags := nil;
  end;
end;
procedure TfmStSChangePhaseSimple.btnCompletedClick(Sender: TObject);
begin
  if (NewPhaseSelected ='H') then begin
    ModalResult := mrOK;
    OpenHarvest;
    Exit;
  end;

  if (NewPhaseSelected ='P') then begin
    ModalResult := mrOK;
    OpenPackage;
    Exit;
  end;

  if (StsTagObj.StsPhase='V') and (NewPhaseSelected ='F') then begin
    btnUseSameTag.click;
  end else begin
    inherited;
    // see ProcessSelectedTags
  end;
end;

procedure TfmStSChangePhaseSimple.btnImmatureEnter(Sender: TObject);
begin
  inherited;
  // not possible for user to choose the phase
  // phase is decided based on the current phase
  Setcontrolfocus(dtUsedOn);
end;

procedure TfmStSChangePhaseSimple.btnUseSameTagClick(Sender: TObject);
begin
  inherited;
  if StsTagObj.StsPhase = 'I' then begin
    MessageDlgXP_Vista('It is not Possible to Use the Same Tag when converted from "Immature"', mtWarning, [mbOK], 0);
    Exit;
  end;
  UnselectAll(true);
  inherited btnCompletedClick(btnCompleted);
end;

procedure TfmStSChangePhaseSimple.initStSTags(Sender:TObject);
begin
   if sender is  TStSTagsGUI then begin
     TStSTagsGUI(Sender).FilterString :=  'DepartmentId = ' + inttostr(fiNewPhaseClassID);

     if NewPhaseSelected ='H' then TStSTagsGUI(Sender).FilterString := TStSTagsGUI(Sender).FilterString +' and IsPackageTag =' + quotedstr('T')
     else TStSTagsGUI(Sender).FilterString := TStSTagsGUI(Sender).FilterString +' and IsPlantTag =' + quotedstr('T');

     TStSTagsGUI(Sender).ProcessTagOnIterateSelectedRecords := AddTagsforNewPhase;
     fListStSTags := TStSTagsGUI(Sender);
   end;
end;
procedure TfmStSChangePhaseSimple.SelectStSTag(Sender: TwwDbGrid);
begin
  UnselectAll(False);
  if assigned(Sender.Owner) then
    if Sender.Owner is TStSTagsGUI then begin
      ststagphases.QtyPerTag := 1;
      TStSTagsGUI(Sender.Owner).IterateSelectedRecords(true); // ProcessTagOnIterateSelectedRecords := AddTagsforNewPhase;
      RefreshSelectedTags;
    end;
end;
procedure TfmStSChangePhaseSimple.RefreshSelectedTags;
begin
  Closedb(QrySelectedTags);
  OpenDb(QrySelectedTags);
end;
procedure TfmStSChangePhaseSimple.AddTagsforNewPhase(var Abort: boolean; SelIndex: Integer);
begin
  SetLength(SelectedTag, length(SelectedTag)+1);
  SelectedTag[high(SelectedTag)].StsTag    := TStSTagsGUI(fListStSTags).qryMainSerialnumber.asString ;
  SelectedTag[high(SelectedTag)].ProductId := TStSTagsGUI(fListStSTags).SelectedProductID;

end;
procedure TfmStSChangePhaseSimple.UnselectAll(InitWithSameTag:boolean=False);
begin
  SetLength(SelectedTag,0);
  finalize(SelectedTag);
  SetLength(SelectedTag,0);
  (*if InitWithSameTag then
     if StsTagObj.StsPhase<>'I' then begin
        SetLength(SelectedTag,1);
        SelectedTag[high(SelectedTag)].StsTag    := StsTagObj.StsTag;
        SelectedTag[high(SelectedTag)].ProductId := StsTagObj.TagProductID;
        ststagphases.QtyPerTag := StsTagObj.Activecount;
     end;*)
end;

Function TfmStSChangePhaseSimple.MultipleTagsForNewPhase:Boolean;
begin
  result := False;
  if (StsTagObj.StsPhase='I') and (NewPhaseSelected<>'I') then REsult := True;
end;

procedure TfmStSChangePhaseSimple.OpenHarvest;
var
  frmHarvest: TfmStSHarvest;
begin
  frmHarvest := TfmStSHarvest.Create(Application);
  frmHarvest.FormStyle := fsMDIChild;
  frmHarvest.ChooseTag(StsTagObj.StsTag);
  frmHarvest.Show;
  frmHarvest.BringToFront;
end;

procedure TfmStSChangePhaseSimple.OpenPackage;
var
  frmPackage: TfmStSCreatePackage;
  frmStsMain: TfmStSMain;
begin
  inherited;

  frmStsMain := TfmStSMain.Create(nil);
  try
    frmPackage := TfmStSCreatePackage.Create(nil, StsTagObj);
    try
      if frmPackage.ShowModal = mrOK then
        frmStsMain.ProcessCreatePackage(frmPackage, nil);
    finally
      FreeAndNil(frmPackage);
    end;
  finally
    FreeAndNil(frmStsMain);
  end;
end;

procedure TfmStSChangePhaseSimple.ChoosePhase(Sender: TObject);
begin
  inherited;
  btnChooseTags.visible := not ((StsTagObj.StsPhase= 'V') and (NewPhaseSelected ='F')) and (NewPhaseSelected<> 'D') and (NewPhaseSelected <> 'P') and (NewPhaseSelected <> 'H');
  pnlSelectedTags.visible := btnChooseTags.visible ;
  btnUseSameTag.visible := False ;// dene doesn't want this button to be shown
  Self.Repaint;
  lblmsg.caption := 'Changing Phase from ' +
                    QuotedStr(StsTagObj.PhaseDescription)    +' To ' +
                    QuotedStr(StsPhaseCodeTodesc(NewPhaseSelected))    +'.';
  lblmsg.visible := true;
end;

procedure TfmStSChangePhaseSimple.FormCreate(Sender: TObject);
begin
  inherited;
  Setlength(SelectedTag,0);
  grdSelectedTags.TitleColor := Self.Color;
  grdSelectedTags.FooterColor := Self.Color;
  lblmsg.caption :='';
end;

procedure TfmStSChangePhaseSimple.FormShow(Sender: TObject);
begin
  inherited;
  Unselectall;
  ChoosePhase(nil);

       if StsTagObj.StsPhase ='I' then ChoosePhase(btnVegetative)
  else if StsTagObj.StsPhase ='V' then ChoosePhase(btnFlowering)
  else if StsTagObj.StsPhase ='F' then ChoosePhase(btnHarvest)
  else if StsTagObj.StsPhase ='H' then ChoosePhase(btnDestroy);

  if btnChooseTags.visible then Setcontrolfocus(btnChooseTags) else Setcontrolfocus(dtUsedOn);


end;
Procedure TfmStSChangePhaseSimple.AddTagsToNewPhase;
var
  ctr : integer;
begin
  ShowProgressbar(WAITMSG,high(SelectedTag) );
  try
    for ctr := low( SelectedTag) to high(SelectedTag) do begin
      StepProgressbar(SelectedTag[ctr].StSTag);
      MakeNewTagRec(SelectedTag[ctr].StSTag,
                  ststagphases.QtyPerTag,
                  SelectedTag[ctr].ProductID);

    end;
  finally
    hideProgressbar;
  end;
end;
function TfmStSChangePhaseSimple.ProcessSelectedTags: Boolean;
begin
  Result := False;
  try
  if length(SelectedTag) = 0 then begin
    if (StsTagObj.StsPhase ='V') and (newphaseselected ='F') then begin
        unselectAll(true);
        changePhaseWithSameTag;
        REsult := True;
        Exit;
    end else if (StsTagObj.StsPhase<>'I')  then begin
      if MessageDlgXP_Vista('Do you  Wish to Keep the Same Tag ('+ StsTagObj.StsTAg +') for the New Phase?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
        unselectAll(true);
        changePhaseWithSameTag;
        REsult := True;
        Exit;
      end else begin
        Exit;
      end;
    end else begin
      MessageDlgXP_Vista('Please Choose the Tag for the new phase', mtWarning, [mbOK], 0);
      Setcontrolfocus(btnChooseTags);
      Exit;
    end;
  end;
  if length(SelectedTag) <> 0 then begin

        ststagphases.NoOfTags := length(SelectedTag);
        if ststagphases.QtyPerTag=0 then ststagphases.QtyPerTag := 1;
        if ststagphases.NoOfTags*ststagphases.QtyPerTag >StSTagObj.ActiveCount then begin
            MessageDlgXP_Vista(Quotedstr(StSTagObj.StsTag) +' has ' + trim(inttostr(StSTagObj.ActiveCount))+' Plants.'+NL+
                               'Changing Phase Cannot Produce More than '+ trim(inttostr(StSTagObj.ActiveCount))+' Plants.'+NL+
                               'You have Selected ' + trim(inttostr(ststagphases.NoOfTags * ststagphases.QtyPerTag))+'.', mtWarning, [mbOK], 0);
            Exit;
        end;
        if ststagphases.TagChanged and (ststagphases.NoOfTags * ststagphases.QtyPerTag <StSTagObj.ActiveCount) then
            ststagphases.TagChanged := ststagphases.NoOfTags * ststagphases.QtyPerTag =StSTagObj.ActiveCount;

        if ststagphases.NoOfTags * ststagphases.QtyPerTag <StSTagObj.ActiveCount then begin
            MessageDlgXP_Vista(Quotedstr(StSTagObj.StsTag) +' has ' + trim(inttostr(StSTagObj.ActiveCount))+' Plants.'+NL+
                               'For the New Phase , You Have Selected '+ trim(inttostr(ststagphases.NoOfTags * ststagphases.QtyPerTag))+'  Only.', mtWarning, [mbOK], 0);

        end;
        AddTagsToNewPhase;
        Result := TRue;

(*        ststagphases.PhaseProductID := StSTagObj.PhaseProductID;
        StsTagObj.ChangedCount:= StsTagObj.ChangedCount +(ststagphases.NoOfTags * ststagphases.QtyPerTag);;
        StsTagObj.PostDB;

        {StSTag_Actions.StatusDate :=   dtUsedOn.datetime;
        StSTag_Actions.ActionQty  :=0-StSTagPhases.noOfTags;
        StSTag_Actions.PostDB;}
        StsTagObj.ChangeGrowthPhase(StSTag_Actions.ID, StSTagPhases.noOfTags);
        ststagphases.postdb;
        StsTagObj.Save;
        Result := TRue;*)
    end;
  finally
    if result then begin
        ststagphases.PhaseProductID := StSTagObj.PhaseProductID;
        StsTagObj.ChangedCount:= StsTagObj.ChangedCount +(ststagphases.NoOfTags * ststagphases.QtyPerTag);;
        StsTagObj.PostDB;

        StsTagObj.ChangeGrowthPhase(StSTag_Actions.ID, StSTagPhases.noOfTags);
        ststagphases.postdb;
        StsTagObj.Save;
        Result := TRue;
    end;
  end;
end;
procedure TfmStSChangePhaseSimple.QrySelectedTagsBeforeOpen(DataSet: TDataSet);
var
  ctr:Integer;
begin
  inherited;
  QrySelectedTags.Filter := 'StsTag <> '+ quotedstr('');
  QrySelectedTags.Filtered := True;
  QrySelectedTags.SQL.Clear;
  QrySelectedTags.SQL.Add('Select "" as StsTag From Dual');
  if Length(SelectedTag) =0 then exit;
  for ctr := low(SelectedTag) to high(SelectedTag) do begin
    QrySelectedTags.SQL.Add('Union Select '+  quotedstr(SelectedTag[ctr].StsTag) +' as StsTag From Dual');
  end;
  QrySelectedTags.SQL.text := 'Select * FROM (' + QrySelectedTags.SQL.text +')  as QrySQL HAVING trim(StsTag) <> ""';
end;

end.
