unit ProductAttributeLib;

interface

uses
  kbmMemTable, BusobjProdAttribGroup, wwdbigrd , wwdbgrid, MyAccess,ERPdbComponents, Classes,
  Controls, Contnrs, wwdblook, DNMPanel, Graphics, DNMSpeedButton, StdCtrls, db;

const
  cButtonWidth                = 110;
  cButtonHeight               = 28;
  cButtonGap                  = 5;
  cButtonLeft                 = 10;
  cButtonTopStart             = 10;
  cButtonColor                = $00BCF8FC;
  cButtonLightColor           = clWhite;
  cButtonShadowColor          = clBlack;
  cButtonHotTrackColor        = clBtnShadow;
  cSelectedButtonColor        = $00ECCE94;
  cSelectedButtonLightColor   = $00FCE6D4;
  cSelectedButtonShadowColor  = clBlack;
  cSelectedButtonHotTrackColor= clWhite;
  PRODATTRIGROUP              = 'PRODATTRIGROUP';


    
procedure MemTableStartSetup(const MemTable: TkbmMemTable);
procedure MemTableReadyToUse(const MemTable: TkbmMemTable);

procedure SetupMemTable(const MemTable: TkbmMemTable; Const AttributeGroups: TProdAttribGroups);
function CreateLookupCombo(Const ComponentList: TComponentList; Const Parent: TWinControl; Const dbgrid: TwwDBGrid;
                            Const qryConnection: TCustomMyConnection; const ComboName, LookupSQL,LookupField : String):TwwDBLookupCombo;Overload;
function CreateLookupCombo(const AOwner:TComponent; Const Parent: TWinControl; Const qryConnection: TCustomMyConnection; const ComboName, LookupSQL,LookupField : String):TwwDBLookupCombo;Overload;
Function AddButton(const AOwner: TComponent; const ButtonCaption: string;
                   const ButtonTop, ButtonLeft, ButtonWidth, ButtonHeight: Integer;
                   Const ParentPanel: TDNMPanel;
                   Const OnClickEvent: TNotifyEvent;
                   const Buttonctr:Integer;
                   Const ButtonColor: TColor = clWhite):TDNMSpeedButton;
Function AddComboBox(const AOwner: TComponent;const combocaption :STring;
                   const ComboTop, ComboLeft, ComboWidth: Integer;
                   Const ParentPanel: TDNMPanel;
                   Const ComboCloseup: TNotifyEvent;
                   Const LookupDataset:TDataset; const listfield:String ;
                   const nameSuffix:String):TComboBox;
Procedure MultiSelectRecord(Sender :TObject;Grid:TwwDbgrid=nil; checkBox :  TCheckbox=nil );

implementation

uses FastFuncs, sysutils;

Procedure MultiSelectRecord(Sender :TObject;Grid:TwwDbgrid=nil; checkBox :  TCheckbox=nil );
begin
    if sender is Tcheckbox then begin
      if TcheckBox(Sender).Checked then Grid.SelectAll
      else Grid.UnselectAll;
    end else begin
        checkBox.checked := Grid.SelectedList.Count = Grid.Datasource.dataset.RecordCount; 
    end;
end;

Function AddComboBox(const AOwner: TComponent;const combocaption :STring;
                   const ComboTop, ComboLeft, ComboWidth: Integer;
                   Const ParentPanel: TDNMPanel;
                   Const ComboCloseup: TNotifyEvent;
                   Const LookupDataset:TDataset; const listfield:String;
                   const nameSuffix:String ):TComboBox;
begin
  Result := nil;
  if LookupDataset.RecordCount = 0 then exit;

  With  TLabel.Create(AOwner) do begin
    Left        := ComboLeft;
    Top         := combotop;
    Caption     := combocaption;
    Parent      := ParentPanel;
    Transparent := true;
    name        := 'Attriblabel'+Trim(nameSuffix);
  end;
  REsult        := TcomboBox.create(AOwner);
  with result do begin
    Left        := ComboLeft;
    Top         := combotop+16;
    Width       := comboWidth;
    Parent      := ParentPanel;
    OnCloseUp   := ComboCloseup;
    name        := 'Attribcombo'+Trim(nameSuffix);
    Style       := csDropDownList;
    LookupDataset.first;
    //Text :=LookupDataset.fieldbyname(listfield).AsString;
    while LookupDataset.Eof = False do begin
      Items.Add(LookupDataset.fieldbyname(listfield).AsString);
      LookupDataset.Next;
    end;
    ItemIndex := 0;
  end;
end;

Function AddButton(const AOwner: TComponent; const ButtonCaption: string;
                   const ButtonTop, ButtonLeft, ButtonWidth, ButtonHeight: Integer;
                   Const ParentPanel: TDNMPanel;
                   Const OnClickEvent: TNotifyEvent;
                   const Buttonctr:Integer;
                   Const ButtonColor: TColor = clWhite):TDNMSpeedButton;
begin
  REsult := TDNMSpeedButton.Create(AOwner);
  with REsult do begin
    Left          := ButtonLeft;
    Top           := ButtonTop;
    Width         := ButtonWidth;
    Height        := ButtonHeight;
    Caption       := ButtonCaption;
    Parent        := ParentPanel;
    Alignment     := taCenter;
    Color         := ButtonColor;
    HotTrackColor := clBtnShadow;
    SlowDecease   := True;
    Style         := bsModern;
    OnClick       := OnClickEvent;
    name := 'mainbutton'+inttostr(ButtonCtr);
  end;
end;
procedure MemTableReadyToUse(const MemTable: TkbmMemTable);
begin
  MemTable.Open;
  MemTable.AutoAddIndexes := true;
  MemTable.AutoReposition := true;
  MemTable.EnableIndexes := true;
  MemTable.UpdateIndexes;
  MemTable.EnableControls;
end;

procedure MemTableStartSetup(const MemTable: TkbmMemTable);
begin
  MemTable.Close;
  MemTable.Standalone := true;
  MemTable.EmptyTable;
  MemTable.Performance := mtpfFast;
  MemTable.DisableControls;
  MemTable.EnableIndexes := false;
  MemTable.Reset;
end;

procedure SetupMemTable(const MemTable: TkbmMemTable; Const AttributeGroups: TProdAttribGroups);
Var
  I:Integer;
  StringList: TStringList;
begin
  MemTableStartSetup(MemTable);
  MemTable.FieldDefs.Clear;

  with MemTable.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with MemTable.FieldDefs.AddFieldDef do begin
    Name     := 'ProductName';
    DataType := ftString;
    Size     := 255;
  end;
  with MemTable.FieldDefs.AddFieldDef do begin
    Name     := 'ProductDesc';
    DataType := ftString;
    Size     := 255;
  end;
  with MemTable.FieldDefs.AddFieldDef do begin
    Name     := 'Active';
    DataType := ftString;
    Size     := 1;
  end;

  StringList := AttributeGroups.GetAttributeNames;
  Try
    for I := 0 to StringList.Count-1 do Begin
      with MemTable.FieldDefs.AddFieldDef do begin
        Name     := StringList[I];
        DataType := ftString;
        Size     := 255;
      end;
    end;
  finally
    StringList.Free;
  end;
  MemTable.CreateTable;
  MemTableReadyToUse(MemTable);
  for I := 0 to MemTable.FieldCount-1  do Begin
    MemTable.Fields[I].DisplayWidth := 20;
  end;
end;
function CreateLookupCombo(const AOwner:TComponent; Const Parent: TWinControl; Const qryConnection: TCustomMyConnection; const ComboName, LookupSQL,LookupField : String):TwwDBLookupCombo;
Var
  Qrylookup: TERPQuery;
  TmpCombo :TwwDBLookupCombo;
begin
  qrylookup := TERPQuery.Create(nil);
  tmpCombo := TwwDBLookupCombo.Create(AOwner);
  qrylookup.Connection := qryConnection;
  qrylookup.SQL.Text := LookupSQL;
  qrylookup.Open;
  tmpCombo.Parent := Parent;
  tmpCombo.Name := StringReplace(Trim(ComboName), ' ', '_',[rfReplaceAll]);
  tmpCombo.LookupTable := qrylookup;
  tmpCombo.LookupField := LookupField;
  tmpCombo.DataField :=  LookupField;
  tmpCombo.Selected.Clear;
  tmpCombo.Selected.Add(LookupField+#9'30'#9+LookupField+#9#9);
  tmpCombo.AutoSelect := True;
  tmpCombo.AutoDropDown := True;
  Result := tmpCombo;

end;
Function CreateLookupCombo(Const ComponentList: TComponentList; Const Parent: TWinControl; Const dbgrid: TwwDBGrid;
                            Const qryConnection: TCustomMyConnection; const ComboName, LookupSQL,LookupField : String):TwwDBLookupCombo;
begin
  Result :=  CreateLookupCombo( dbgrid.Owner, Parent ,qryConnection  , ComboName , LookupSQL, LookupField);
  dbgrid.EditControlOptions :=  dbgrid.EditControlOptions + [ecoSearchOwnerForm];
  Result.DataSource := dbgrid.DataSource;
  Result.Visible := False;
  ComponentList.add(Result.LookupTable);
  ComponentList.add(Result);
end;

end.
