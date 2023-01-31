unit CustomfieldonGrid;

interface

uses
  wwdbGrid , Busobjcustomfields, classes , wwDBComb, WwDBEdit, db,
  GuiPrefsObj, busobjbase,
  WwDBDateTimePicker;

type
  TCustomFieldonGrid = class(TComponent)
    Private
      fCustomFields: String;
      fListType: TListtype;
      fGrid: TwwDBGrid;
      Dataset:TDataset;
      Calcfields :Array[1..2] of Array of String;
      iCalcfields:Integer;
      fGuiPrefs: TFormGuiPrefs;
      dtchaning:boolean;
      Changingdate:boolean;
      fbusobj: TMSBusObj;
      Procedure DeleteOldcalcFields;
      Function newcombo(Owner:TComponent):TwwDBCombobox;
      Function newedit(Owner: TComponent):TwwDBEdit;
      function NewDateTimePicker(Owner: TComponent): TwwDBDateTimePicker;
      Function GetANewName(Suffix:STring;Owner:TComponent):String;
      procedure DateFieldGetTextEvent(Sender: TField; var Text: string; DisplayText: Boolean);
      procedure DateFieldSetTextEvent(Sender: TField; const Text: string);
    Public
      Property  grid :TwwDBGrid read fGrid Write fGrid;
      Property  Listtype :TListtype read fListType write flisttype;
      Property  CustomFields : String read fCustomFields write fCustomFields;
      Property GuiPrefs: TFormGuiPrefs read fGuiPrefs write fGuiPrefs;
      Property busobj :TMSBusObj read fbusobj write fbusobj;
      constructor Create(AOwner:TComponent);overload; override;
      constructor Create(AOwner:TComponent;cCustomFields: String;cListType: TListtype;cGrid: TwwDBGrid;cGuiPrefs: TFormGuiPrefs; cbusobj:TMSBusObj); Reintroduce;Overload;
      Destructor Destroy; override;
      Procedure ApplyCustomFieldsSettings;
      procedure SetUpcustomFields;
  end;

implementation

uses
  CommonLib, sysutils, StdCtrls, tcConst, GridFieldsObj, variants, ComCtrls,
  ERPDbComponents;

Function TCustomFieldonGrid.newedit(Owner:TComponent):TwwDBEdit;
begin
  REsult := TwwDBEdit.Create(Owner);
  REsult.Picture.PictureMask :=
    '{{{#[#][#]{{;,###*[;,###]},*#}[.*#]},.#*#}[E[[+,-]#[#][#]]],({{#' +
    '[#][#]{{;,###*[;,###]},*#}[.*#]},.#*#}[E[[+,-]#[#][#]]]),[-]{{#[' +
    '#][#]{{;,###*[;,###]},*#}[.*#]},.#*#}[E[[+,-]#[#][#]]]}';
  REsult.UnboundDataType := wwDefault;
end;
Function TCustomFieldonGrid.newcombo(Owner:TComponent):TwwDBCombobox;
begin
  REsult := TwwDBComboBox.Create(Owner);
  REsult.ShowButton := True;
  REsult.Style := csDropDownList;
  REsult.MapList := False;
  REsult.AllowClearKey := False;
  REsult.AutoDropDown := True;
  REsult.DropDownCount := 8;
  REsult.ItemHeight := 0;
  REsult.Sorted := False;
  REsult.UnboundDataType := wwDefault;
  REsult.Visible := False;
end;
function TCustomFieldonGrid.NewDateTimePicker(Owner: TComponent): TwwDBDateTimePicker;
begin
  result := TwwDBDateTimePicker.Create(Owner);
  //result.DisplayFormat := FormatSettings.ShortDateFormat;
  result.DateFormat := dfShort; //FormatSettings.ShortDateFormat;
end;

constructor TCustomFieldonGrid.Create(AOwner:TComponent;cCustomFields: String; cListType: TListtype; cGrid: TwwDBGrid;cGuiPrefs: TFormGuiPrefs;cbusobj:TMSBusObj);
begin
  Create(AOwner);
  ListType := cListType;
  Grid := cGrid;
  CustomFields := cCustomFields;
  GuiPrefs := cGuiPrefs;
  Dataset := Grid.Datasource.Dataset;
  busobj := cbusobj;
end;

constructor TCustomFieldonGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  dtchaning:= False;
  Changingdate:= False;
  iCalcfields:= 0;
  SetLength(Calcfields[1],0);
  SetLength(Calcfields[2],0);
end;
procedure TCustomFieldonGrid.DateFieldGetTextEvent(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull or (Sender.AsString = '') then begin
    try { in case dataset is read only .. }
      if not (Sender.DataSet.State in [dsEdit,dsInsert]) then begin
        Sender.DataSet.Edit;
        Sender.AsString := '0';
        Sender.DataSet.Post;
      end
      else
       Sender.AsString := '0';
    except
    end;
  end;
  DisplayText := true;
end;

procedure TCustomFieldonGrid.DateFieldSetTextEvent(Sender: TField;
  const Text: string);
var
  str: string;
begin
  str := DateToStr(StrToDateTimeDef(Sender.AsString,0));
  if not SameText(Sender.AsString,str) then begin
    if Sender.DataSet.RecordCount > 0 then begin
      try { in case dataset is read only .. }
        if not (Sender.DataSet.State in [dsEdit,dsInsert]) then begin
          Sender.DataSet.Edit;
          Sender.AsString := str;
          Sender.DataSet.Post;
        end
        else
         Sender.AsString := str;
      except
      end;
    end;
  end;
end;

Procedure TCustomFieldOnGrid.DeleteOldcalcFields;
var
  ctr:Integer;
begin
  if iCalcfields >0 then begin
    for ctr := low(Calcfields[1]) to high(Calcfields[1]) do begin
      if Dataset.findfield(Calcfields[2,ctr])<> nil then
        Dataset.fieldDefs.Delete(Dataset.findfield(Calcfields[2,ctr]).Index);
    end;
  end;
  SetLength(Calcfields[1],0);
  SetLength(Calcfields[2],0);
  iCalcfields:= 0;
end;
destructor TCustomFieldonGrid.Destroy;
begin
  inherited;
end;
Procedure TCustomFieldonGrid.ApplyCustomFieldsSettings;
var
  CustomFieldList : TCustomFieldList;
  i,ctr:integer;
  Combo: TwwDBCombobox;
  edt:TwwDBEdit;
  dt: TwwDBDateTimePicker;
  St:TStringlist;
  dsActive:Boolean;
begin
  ctr:=0;
  Dataset.DisableControls;
  try
    dsActive:=Dataset.Active;
    Dataset.Active := False;
    try
      deleteOldCalcfields;
      if CustomFields = '' then exit;
      try
        st:= TStringlist.create;
        try
          st.commatext :=CustomFields;
          CustomFieldList := TCustomFieldList.CreateWithSharedConn(grid.Owner);
          try
            CustomFieldList.LoadSelect('ListType = ' + QuotedStr(ListtypetoString(Listtype)));
            if CustomFieldList.count =0 then exit;
            ctr:= 0;
            grid.BeginUpdate;
            Try
              while CustomFieldList.Eof = False do begin
                GuiPrefs.DbGridElement[grid].UnHideField(st[ctr]);
                Dataset.fieldbyname(st[ctr]).displayLabel :=CustomFieldList.Description;
                  if   CustomFieldList.ISCombo then begin
                      combo := Newcombo(Grid.owner);
                      combo.parent := Grid.parent;
                      combo.name :=GetaNewName(st[ctr] , grid.owner);
                      if CustomFieldList.DropDown.count >0 then begin
                        CustomFieldList.DropDown.First;
                        while CustomFieldList.DropDown.Eof = False do begin
                          Combo.Items.add(CustomFieldList.DropDown.text);
                          CustomFieldList.DropDown.Next;
                        end;
                      end;
                      Dataset.fieldbyname(st[ctr]).Displaylabel := dataset.findfield(st[ctr]).displaylabel;
                      Dataset.fieldbyname(st[ctr]).displayWidth := dataset.findfield(st[ctr]).Displaywidth;
                      Combo.name :=GetaNewName(st[ctr] , grid.owner);
                      grid.ControlType.Add(st[ctr]+';CustomEdit;'+Combo.name+';F');
                  end else if   sameText(CustomFieldList.Datatype , 'ftFloat') then begin
                    edt:= newedit(grid.owner);
                    edt.name :=GetaNewName(st[ctr] , grid.owner);
                    Dataset.fieldbyname(st[ctr]).Displaylabel := dataset.findfield(st[ctr]).displaylabel;
                    Dataset.fieldbyname(st[ctr]).displayWidth := dataset.findfield(st[ctr]).Displaywidth;
                    grid.ControlType.Add(st[ctr]+';CustomEdit;'+edt.name+';F');
                  end else if   sameText(CustomFieldList.Datatype , 'ftBoolean') then begin
                    Dataset.fieldbyname(st[ctr]).Displaylabel := dataset.findfield(st[ctr]).displaylabel;
                    Dataset.fieldbyname(st[ctr]).displayWidth := dataset.findfield(st[ctr]).Displaywidth;
                    grid.ControlType.Add(st[ctr]+';CheckBox;T;F');
                  end else if sameText(CustomFieldList.Datatype , 'ftDateTime') then begin
                    dt := NewDateTimePicker(grid.Owner);
                    dt.Name :=GetaNewName(st[ctr] , grid.owner);
                    Dataset.fieldbyname(st[ctr]).Displaylabel := dataset.findfield(st[ctr]).displaylabel;
                    Dataset.fieldbyname(st[ctr]).displayWidth := dataset.findfield(st[ctr]).Displaywidth;
                    if Dataset.fieldbyname(st[ctr]) is TWideStringCustField then begin

                    end
                    else begin
                      Dataset.fieldbyname(st[ctr]).OnGetText := DateFieldGetTextEvent;
                      Dataset.fieldbyname(st[ctr]).OnSetText := DateFieldSetTextEvent;
                    end;
                    grid.ControlType.Add(st[ctr]+';CustomEdit;'+dt.name+';F');


                  end;
                CustomFieldList.Next;
                ctr:= ctr+1;
              end;
            Finally
              grid.EndUpdate;
            End;
          finally
            Freeandnil(CustomFieldList);
          end;
        finally
          {remove the custom fields disabled from guipref}
          if ctr<st.count-1 then
            for i := ctr to st.count-1 do begin
              GuiPrefs.DbGridElement[grid].HideField(st[i]);
              Grid.RemoveField(st[i]);
            end;
          Freeandnil(st);
        end;
      Except
        // kill the exception
      end;
    finally
      GuiPrefs.DbGridElement[grid].UpdateGridSelected(GetSelectedTExtFromFields(grid));
      Dataset.Active := dsActive;


    end;
  finally
    Dataset.Enablecontrols;
  end;
end;

Procedure TCustomFieldonGrid.SetUpcustomFields;
var
  CustomFieldList : TCustomFieldList;
  i,ctr:integer;
  St:TStringlist;
begin
  ctr:=0;
      if CustomFields = '' then exit;
      try
        st:= TStringlist.create;
        try
          st.commatext :=CustomFields;
          CustomFieldList := TCustomFieldList.CreateWithSharedConn(grid.Owner);
          try
            CustomFieldList.LoadSelect('ListType = ' + QuotedStr(ListtypetoString(Listtype)));
            if CustomFieldList.count =0 then exit;
            ctr:= 0;
            grid.BeginUpdate;
            Try
              while CustomFieldList.Eof = False do begin
                Dataset.fieldbyname(st[ctr]).displayLabel :=CustomFieldList.Description;
                if Dataset.fieldbyname(st[ctr]).DisplayWidth = 255 then Dataset.fieldbyname(st[ctr]).displaywidth := 20;
                CustomFieldList.Next;
                ctr:= ctr+1;
              end;
            Finally
              grid.EndUpdate;
            End;
          finally
            Freeandnil(CustomFieldList);
          end;
        finally
          {remove the custom fields disabled from guipref}
          if ctr<st.count-1 then
            for i := ctr to st.count-1 do begin
              GuiPrefs.DbGridElement[grid].HideField(st[i]);
              Grid.RemoveField(st[i]);
            end;
          Freeandnil(st);
        end;
      Except
        // kill the exception
      end;
end;

Function TCustomFieldonGrid.GetANewName(Suffix:STring;Owner:TComponent):String;
var
  ctr:Integer;
begin
  result := 'edt' + Suffix;
  ctr:= 0;
  while Owner.findcomponent(result)<> nil do begin
    result := result + inttostr(ctr);
    ctr:= ctr+1;
  end;
end;

end.

