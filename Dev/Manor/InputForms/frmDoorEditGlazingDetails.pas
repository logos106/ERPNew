unit frmDoorEditGlazingDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, AdvEdit, wwclearbuttongroup, wwradiogroup, wwcheckbox, Grids,
  BaseGrid, AdvGrid, MessageConst, DB, DBAccess, MyAccess,ERPdbComponents,
  MemDS, wwdblook;

type
  TfrmDooreditGlazingDetailsGUI = class(TBaseProcTreeEditGUI)
    rdgOpeningType: TwwRadioGroup;
    Label1: TLabel;
    Bevel2: TBevel;
    Label3: TLabel;
    edtPanelNumberLeafTwo: TAdvEdit;
    Label4: TLabel;
    cboGlazingSystem: TwwDBLookupCombo;
    Label5: TLabel;
    memAdditionalInstructions: TMemo;
    asgGlazingDetails: TAdvStringGrid;
    Label6: TLabel;
    edtTotalCost: TAdvEdit;
    imgDelete: TImage;
    tmrFocus: TTimer;
    qryGlazingSystem: TERPQuery;
    Label7: TLabel;
    memSpecialDescription: TMemo;
    edtPanelNumberLeafOne: TAdvEdit;
    Label8: TLabel;
    Label10: TLabel;
    edtBeadingCost: TAdvEdit;
    qryBeading: TERPQuery;
    chkGlazingBeads: TwwCheckBox;
    Label9: TLabel;
    cboBeading: TwwDBLookupCombo;
    Label11: TLabel;
    chkGlazingExtraOver: TwwCheckBox;
    chkStainAndVarnish: TwwCheckBox;
    chkBrassCapsAndScrews: TwwCheckBox;
    chkGlassRequired: TwwCheckBox;
    Label12: TLabel;
    memGlassDetails: TMemo;
    Label2: TLabel;
    edtLumpSumCost: TAdvEdit;
    procedure FormCreate(Sender: TObject);
    procedure asgGlazingDetailsGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure asgGlazingDetailsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrFocusTimer(Sender: TObject);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    Procedure PopulateGrid;
  protected
    procedure SetPropertyValue(Sender: TObject); override;
    Procedure GridCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: Integer;  var Allow: Boolean); override;
  public
    { Public declarations }
  end;
    TDetails = class(TObject)
    private
    public
        Leafno :Integer;
        VPNo :Integer;
        Done : Boolean;
    End;


implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib, FastFuncs, EditDoorQuotationDetailsObj;

const
  cCircular = 0;
  cRectangle = 1;
  cSpecial = 2;
  cGlazingPositionCol = 9;

procedure TfrmDooreditGlazingDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  asgGlazingDetails.ComboBox.Items.Add('Size Only');
  asgGlazingDetails.ComboBox.Items.Add('O/A BDS');
  asgGlazingDetails.ComboBox.Items.Add('Sight Size');
  asgGlazingDetails.AddBitmap(0, 0, imgDelete.Picture.Bitmap, True, haCenter, vaCenter);
end;

procedure TfrmDooreditGlazingDetailsGUI.asgGlazingDetailsGetEditorType(Sender: TObject; ACol, ARow: Integer; var AEditor: TEditorType);
begin
  inherited;

  if ACol = cGlazingPositionCol then
    AEditor := edComboEdit;
end;
Procedure TfrmDooreditGlazingDetailsGUI.PopulateGrid;
var
    Leaf1, Leaf2, i1, i2 :Integer ;
    Details :Array of TDetails;
    ISEmpty :Boolean;
    fifixedrows :Integer;
begin
    try
        Leaf1:= 1;//FastFuncs.strToInt(edtPanelNumberLeafOne.Text);
        Leaf2:= FastFuncs.strToInt(edtPanelNumberLeafOne.Text);//FastFuncs.strToInt(edtPanelNumberLeafTwo.Text);
         for i1 := 1 to Leaf1 do begin
            if Leaf2 = 0 then begin
                Setlength(Details,i1);
                Details[(i1-1)] := TDetails.create;
                Details[(i1-1)].LeafNo := i1;
                Details[(i1-1)].VPNo := 0;
                Details[(i1-1)].Done := False;
            end else
                for i2 := 1 to Leaf2 do begin
                    Setlength(Details, (i1-1)*Leaf2+i2);
                    Details[(i1-1)*Leaf2+i2-1] := TDetails.create;
                    Details[(i1-1)*Leaf2+i2-1].LeafNo := i1;
                    Details[(i1-1)*Leaf2+i2-1].VPNo := i2;
                    Details[(i1-1)*Leaf2+i2-1].Done := False;
                end;
         end;
         fifixedrows := asgGlazingDetails.fixedrows;
         if fifixedrows = 0 then fifixedrows := 1;
         for i1 :=  asgGlazingDetails.RowCount-1 downto asgGlazingDetails.fixedrows do begin
            ISEmpty := TRue;
            for i2 := asgGlazingDetails.FixedCols to asgGlazingDetails.ColCount-1 do
                if FastFuncs.Trim(asgGlazingDetails.cells[i2, i1]) <> '' then begin
                    isempty := False;
                    Break;
                end;
            if IsEmpty then
                asgGlazingDetails.RemoveRows(i1, 1);
            //asgGlazingDetails.Rows[i1].Delete(i1);
         end;
         for i1 := asgGlazingDetails.fixedrows to asgGlazingDetails.RowCount-1 do begin
             Leaf1 := System.Round(strValue(asgGlazingDetails.Cells[1, i1]));
             Leaf2 := System.Round(strValue(asgGlazingDetails.Cells[2, i1]));

             if (Leaf1 <> 0) and (Leaf2 <> 0) then
                 for i2 := low(Details) to high(Details) do
                    if (Details[i2].Leafno = leaf1) and (Details[i2].VPNo = leaf2) then begin
                        Details[i2].Done := TRue;
                        Break;
                    end;
         end;
         for i2 := low(Details) to high(Details) do
            if  Details[i2].done = False then begin
                asgGlazingDetails.Addrow;
                asgGlazingDetails.cells[1, asgGlazingDetails.rowcount-1] := Fastfuncs.IntToStr(Details[i2].Leafno);
                asgGlazingDetails.cells[2, asgGlazingDetails.rowcount-1] := Fastfuncs.IntToStr(Details[i2].VPNo);
            end;
         asgGlazingDetails.fixedrows := fifixedrows;

    Finally
        for i2 :=  high(Details) downto low(Details) do
            FreeandNil(details[i2]);
        DEtails := nil;
    end;
    (*if (FastFuncs.SameText(CurNodename, 'PanelNumberLeafOne')) or (FastFuncs.SameText(CurNodename, 'PanelNumberLeafTwo')) then begin
        for Index := 0 to LeafNumber.NodePropsCount - 1 do begin
            Leaf1 :=StrToIntDef(PanelNumberLeafOne.Value, 0);
            Leaf2 :=StrToIntDef(PanelNumberLeaftwo.Value, 0);
            for i1 := Low(Details) to High(Details) do
                if (Details[i1].Leafno = Leaf1) and (Details[i1].vpno = Leaf2) then begin
                    Details[i1].done := True;
                    break;
                end;
        end;
        for i1 := Low(Details) to High(Details) do
            if Details[i1].done = False then begin

            end;
    end;*)
end;
procedure TfrmDooreditGlazingDetailsGUI.PerformStartup(var Msg: TMessage);
begin
  qryGlazingSystem.Connection := GetSharedMyDacConnection;
  qryGlazingSystem.Open;
  qryGlazingSystem.FieldByName('GlazingType').DisplayWidth := 20;
  qryBeading.Connection := GetSharedMyDacConnection;
  qryBeading.ParamByName('GlazingShape').AsString := 'Circular';
  qryBeading.ParamByName('GlazingType').AsString := '300';
  qryBeading.Open;
  qryBeading.FieldByName('GlazingMats').DisplayWidth := 20;
  inherited;
  if (Assigned(Nodeproplink.owner)) and (nodePropLink.owner is TEditDoorQuotationDetails) then
    if TEditDoorQuotationDetails(NodeProplink.owner).DoorPairing.Value = '0' then begin
        edtPanelNumberLeafTwo.enabled := false;
        Label3.enabled := false;
    end else begin
        edtPanelNumberLeafTwo.Enabled := true;
        Label3.Enabled := true;
    end;

end;

procedure TfrmDooreditGlazingDetailsGUI.asgGlazingDetailsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN then
    tmrFocus.Enabled := True; 
end;

procedure TfrmDooreditGlazingDetailsGUI.tmrFocusTimer(Sender: TObject);
begin
  inherited;

  //
  // Done due to bug in TAdvStringGrid where a cell loses focus after the first
  // cell change using arrow keys.
  //
  tmrFocus.Enabled := False;
  SetControlFocus(asgGlazingDetails);
end;

procedure TfrmDooreditGlazingDetailsGUI.SetPropertyValue(Sender: TObject);
begin
    inherited;

    if Sender is TAdvEdit then
    if (FastFuncs.SameText(TAdvEdit(Sender).name , 'edtPanelNumberLeafOne')) or (FastFuncs.SameText(TAdvEdit(Sender).name , 'edtPanelNumberLeafTwo')) then
        PopulateGrid;
    if sender = chkGlassRequired then begin
        memGlassDetails.Enabled := chkGlassRequired.Checked;
        edtLumpSumCost.Enabled := chkGlassRequired.Checked;
        Label2.Enabled := chkGlassRequired.Checked;
        Label12.Enabled := chkGlassRequired.Checked;
    end else if Sender = rdgOpeningType then begin
    case rdgOpeningType.ItemIndex of
      cCircular:
      begin
        memSpecialDescription.Enabled := False;
        //edtLumpSumCost.Enabled := False;
        cboGlazingSystem.Enabled := False;
        chkStainAndVarnish.Enabled := True;
        chkGlassRequired.Enabled := True;
        chkGlazingBeads.Enabled := True;
        chkBrassCapsAndScrews.Enabled := True;
        chkGlazingExtraOver.Enabled := True;
        memAdditionalInstructions.Enabled := True;
        asgGlazingDetails.Enabled := True;
        qryBeading.Close;
        qryBeading.ParamByName('GlazingShape').AsString := 'Circular';
        qryBeading.ParamByName('GlazingType').AsString := '300';
        qryBeading.Open;
      end;

      cRectangle:
      begin
        memSpecialDescription.Enabled := False;
        //edtLumpSumCost.Enabled := False;
        cboGlazingSystem.Enabled := True;
        chkStainAndVarnish.Enabled := False;
        chkGlassRequired.Enabled := True;
        chkGlazingBeads.Enabled := True;
        chkBrassCapsAndScrews.Enabled := True;
        chkGlazingExtraOver.Enabled := True;
        memAdditionalInstructions.Enabled := True;
        asgGlazingDetails.Enabled := True;
        qryBeading.Close;
        qryBeading.ParamByName('GlazingShape').AsString := 'Square';
        //if cboGlazingSystem.Text <> '' then begin
          qryBeading.ParamByName('GlazingType').AsString := cboGlazingSystem.Text;
          qryBeading.Open;
        //end;
     end;

      cSpecial:
      begin
        memSpecialDescription.Enabled := True;
        edtLumpSumCost.Enabled := False;
        Label2.Enabled := False;
        cboGlazingSystem.Enabled := False;
        chkStainAndVarnish.Enabled := False;
        chkGlassRequired.Enabled := False;
        chkGlazingBeads.Enabled := False;
        chkBrassCapsAndScrews.Enabled := False;
        chkGlazingExtraOver.Enabled := False;
        memAdditionalInstructions.Enabled := False;
        asgGlazingDetails.Enabled := False;
      end;
    end;
  end
  else if Sender = cboGlazingSystem then begin
    qryBeading.Close;
    qryBeading.ParamByName('GlazingType').AsString := cboGlazingSystem.Text;
    qryBeading.Open;
  end
  else if Sender = chkGlazingBeads then begin
    cboBeading.Enabled := chkGlazingBeads.Checked;
    edtBeadingCost.Enabled := chkGlazingBeads.Checked;
  end;
end;

Procedure TfrmDooreditGlazingDetailsGUI.GridCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: Integer;  var Allow: Boolean);
  var
    fsActivefield :String;
    ctr:Integer;
  function activefield:String;
  begin
    Result := replacestr(   asgGlazingDetails.Cells[OldCol, 0] , ' ' , '');
  end;
begin
    fsActivefield := activefield;
    if FastFuncs.SameText(fsActivefield ,'Width') or
        FastFuncs.SameText(fsActivefield ,'Height') or
        FastFuncs.SameText(fsActivefield ,'SideMargin') or
        FastFuncs.SameText(fsActivefield ,'TopMargin') or
        FastFuncs.SameText(fsActivefield ,'BottomMargin') or
        FastFuncs.SameText(fsActivefield ,'VerticalMargin') then begin
        if oldrow =  asgGlazingDetails.fixedrows then begin
            for ctr := asgGlazingDetails.fixedrows to asgGlazingDetails.rowcount-1 do begin
                if asgGlazingDetails.cells[oldcol, ctr] = '' then asgGlazingDetails.cells[oldcol, ctr] := asgGlazingDetails.cells[oldcol, asgGlazingDetails.fixedrows];
            end;
        end;
    end;
    inherited;
end;

initialization
  RegisterClassOnce(TfrmDooreditGlazingDetailsGUI);
finalization
  UnregisterClass(TfrmDooreditGlazingDetailsGUI);
end.
