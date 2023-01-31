unit GridFieldsObj;

interface

uses Classes, wwdbGrid, DB;

type
  TGridFieldRec = class(TCollectionItem)
  private
    fReadOnly: boolean;
    fDisplayWidth: integer;
    fGroupName: string;
    fDisplayLabel: string;
    fFieldName: string;
    function GetAsString: string;
    procedure SetAsString(const Value: string);
    function getDisplayWidth: integer;
    procedure setDisplayWidth(const Value: integer);
  public
    property FieldName: string read fFieldName write fFieldName;
    property DisplayWidth: integer read getDisplayWidth write setDisplayWidth;
    property DisplayLabel: string read fDisplayLabel write fDisplayLabel;
    property ReadOnly: boolean read fReadOnly write fReadOnly;
    property GroupName: string read fGroupName write fGroupName;
    property AsString: string read GetAsString write SetAsString;
    procedure Assign(const Source: TGridFieldRec); reintroduce;
  end;

  TGridFieldList = class(TCollection)
  private
//    fText: string;
    function GetText: string;
    procedure SetText(const Value: string);
    function GetField(aName: string): TGridFieldRec;
    procedure SetAllReadOnly(const Value: boolean);
    function GetItem(index: integer): TGridFieldRec;
  public
    constructor Create;
    destructor Destroy; override;

    { find the GroupName for a given field .. empty if not found }
    function GroupForField(const aFieldName: string): string;
  //  Procedure SetGroupForField(const aFieldName: string; const Value: String);
    function ReadonlyForField(const aFieldName: string): Boolean;
    function FieldByNameAndGroup(const aName, aGroup: string): TGridFieldRec;
    function FieldByName(const aName: string): TGridFieldRec;
    procedure Delete(const aName: string); overload;
    Procedure ReplaceGroupname(const aName, aGroup, aDisplaylabel: string);
    procedure RemoveField(aFieldName: string);overload;
    procedure ChangeDisplayLabel(aFieldName: string; const sDisplaylabel:String);
    procedure AddField(aField: TField; cleanselectedList : TGridFieldList); overload;
    procedure AddField(aField: TField; aGroupName: string = ''); overload;
    procedure AddField(aFieldName: string; GridDataset: TDataset; cleanselectedList : TGridFieldList;aIndex:Integer=-1); overload;
    class procedure AddField(grid: TwwDbGrid; aField: TField; aGroupName: string = ''); overload;
    class procedure RemoveField(grid: TwwDbGrid; aField: TField); overload;
    class procedure RemoveFields(grid: TwwDbGrid; aFieldList: string);
    class procedure SetDisplayWidth(grid: TwwDbGrid; aFieldName: string; aWidth: integer);
    class procedure SetFieldGroup(grid: TwwDbGrid; aFieldName, aGroupName: string);
    procedure LoadFromGrid(grid: TwwDbGrid);
    procedure SaveToGrid(grid: TwwDbGrid);
    procedure Regroup;
//    Procedure DoTranslate;

    property Items[index: integer]: TGridFieldRec read GetItem;
    property Text: string read GetText write SetText;
    property AllReadOnly: boolean write SetAllReadOnly;
    property Field[aName: string]: TGridFieldRec read GetField;
    //Property GroupForField[aFieldName:String] :String read getGroupForField Write SetGroupForField;
  end;

  function GetGridSelectedText(grid: TwwDbGrid; IgnoreReadOnly: boolean = false): string;
  function DatasetHasCalculatedFields(Dataset: TDataset): boolean;
  Function GetSelectedTExtFromFields(grid:twwDBGrid; IgnoreReadOnly: boolean = false):String;
  //Procedure AdjustGridcols(grid: TwwDbGrid;Adjustthewidest:Boolean =False);
//  function Dotranslation(const Value:String):String;

implementation

uses SysUtils, StrUtils, Types {, LanguageTranslationObj};


Function GetSelectedTExtFromFields(grid:twwDBGrid; IgnoreReadOnly: boolean = false):String;
var
  oldList, newList: TGridFieldList;
  x: integer;
  field: TField;
  rec: TGridFieldRec;
begin
  oldList:= TGridFieldList.Create;
    newList:= TGridFieldList.Create;
    try
      oldList.Text:= grid.Selected.Text;
      for x:= 0 to grid.DataSource.DataSet.FieldCount-1 do begin
        field:= grid.DataSource.DataSet.Fields[x];
        if field.Visible then begin
          rec:= TGridFieldRec(newList.Add);
          rec.FieldName:= field.FieldName;
          rec.DisplayWidth:= field.DisplayWidth;
          rec.DisplayLabel:= field.DisplayLabel;

          if IgnoreReadOnly then
            rec.ReadOnly:= false
          else
            if field.ReadOnly then
              rec.ReadOnly:= field.ReadOnly
            else
              rec.ReadOnly:= oldList.ReadonlyForField(field.FieldName);
          rec.GroupName:= oldList.GroupForField(field.FieldName);
        end;
      end;
      result:= newList.Text;
    finally
      oldList.Free;
      newList.Free;
    end;
end;
(*Procedure AdjustGridcols(grid: TwwDbGrid;Adjustthewidest:Boolean =False);
var
  newList: TGridFieldList;
  ctr, x,w:Integer;
  ft:Integer;
  s:String;

  function Indicatorwidth:Integer;
    begin
      if assigned(grid.IndicatorButton) and (grid.IndicatorButton.visible) then result :=  grid.IndicatorButton.Width else result := 0;
      if result<0 then result:= 0;
      //if grid.ShowVertScrollBar then  result := result + 7;
    end;

    function Narroestcolumnindex:Integer;
    var
      i,x:Integer;
    begin
      result:=0;
      x :=   newList.items[0].displaywidth;
      for i := 0 to newList.count -1 do
          if x > newList.items[i].displaywidth then begin
            x:=newList.items[i].displaywidth;
            result :=i;
          end;
    end;

    function Widestcolumnindex:Integer;
    var
      i,x:Integer;
    begin
      result:=0;
      x :=   newList.items[0].displaywidth;
      for i := 0 to newList.count -1 do
          if x < newList.items[i].displaywidth then begin
            x:=newList.items[i].displaywidth;
            result :=i;
          end;
    end;
begin
      newList:= TGridFieldList.Create;
      try
        newList.LoadFromGrid(grid);
        try
          ft:= 0;
          for ctr:= 0 to newList.count-1 do ft := ft + newList.items[ctr].displaywidth;
          if grid.width -Indicatorwidth -ft =0 then exit;
          x:= 0;
          w := trunc((grid.width -Indicatorwidth)/8- NewList.Count/2);
          s:= floattostr(w) +':' +floattostr(ft);
          While w - ft <>0 do begin
              if Adjustthewidest then begin
                if w - ft>0 then begin
                  x:= Narroestcolumnindex;
                  newList.items[x].displaywidth := newList.items[x].displaywidth +1;
                  ft:= ft+1;
                  s:= s+ NL+ '1:' + floattostr(w) +':' +floattostr(ft);
                end else begin
                  x:= Widestcolumnindex;
                  newList.items[x].displaywidth := newList.items[x].displaywidth -1;
                  ft:= ft-1;
                  s:= s+ NL+ '2:' + floattostr(w) +':' +floattostr(ft);
                end;
              end else begin
                if w - ft>0 then begin
                  newList.items[x].displaywidth := newList.items[x].displaywidth +1;
                  ft:= ft+1;
                  s:= s+ NL+ '3:' + floattostr(w) +':' +floattostr(ft);
                end else begin
                  newList.items[x].displaywidth := newList.items[x].displaywidth -1;
                  ft:= ft-1;
                  s:= s+ NL+ '4:' + floattostr(w) +':' +floattostr(ft);
                end;
                x:= x +1 ;
                if x >= newList.count then x:= 0;
              end;
          end;
        finally
          Logtext(s);
          NewList.SaveToGrid(grid);
          if grid.UseTFields then
            for ctr:= 0 to newList.count-1 do
              try
                grid.datasource.DataSet.FieldByName(newList.items[ctr].FieldName).DisplayWidth := newList.items[ctr].displaywidth;
              Except
              end;
        end;
      finally
        newList.Free;
      end;
end;*)
function GetGridSelectedText(grid: TwwDbGrid; IgnoreReadOnly: boolean = false): string;
var
  newList: TGridFieldList;
begin
  result:= '';
  if grid.UseTFields and assigned(grid.DataSource.dataset) and grid.DataSource.DataSet.Active then begin
     result := GetSelectedTExtFromFields(grid, ignoreReadonly);
  end else begin
    { not storing settings in fields OR dataset not open
      so just grab the grids stored settings }
    if IgnoreReadOnly then begin
      newList:= TGridFieldList.Create;
      try
        newList.LoadFromGrid(grid);
        newList.AllReadOnly:= false;
        result:= newList.Text;
      finally
        newList.Free;
      end;
    end
    else
      result:= replacestr(grid.Selected.Text , #9'255'#9 , #9'20'#9);
  end;
end;

function DatasetHasCalculatedFields(Dataset: TDataset): boolean;
var
  x: integer;
begin
  result:= false;
  for x:= 0 to Dataset.FieldCount -1 do begin
    if Dataset.Fields[x].Calculated then begin
      result:= true;
      break;
    end;
  end;
end;

function StrToBool(const str: string): boolean;
begin
  result:= str = 'T';
end;

function BoolToStr(const bool: boolean): string;
begin
  if bool then result:= 'T'
  else result:= 'F';
end;


{ TGridFieldList }

procedure TGridFieldList.AddField(aField: TField; cleanselectedList : TGridFieldList);
var
  fld: TGridFieldRec;
begin
  if not Assigned(Field[aField.FieldName]) then begin
    fld:= TGridFieldRec(Add);
    fld.FieldName:= aField.FieldName;
    fld.fDisplayWidth:= aField.DisplayWidth;
    fld.DisplayLabel:= aField.DisplayLabel;
    fld.ReadOnly:= aField.ReadOnly;
    fld.GroupName:= cleanselectedList.GroupForField(fld.FieldName);
  end;
end;

procedure TGridFieldList.AddField(aFieldName: string;GridDataset: TDataset; cleanselectedList : TGridFieldList;aIndex:Integer=-1);
var
  fld: TGridFieldRec;
  aField: TField;
begin
  if not Assigned(Field[aFieldName]) then begin
    fld:= TGridFieldRec(Add);
    if aIndex>-1 then
      if aIndex <count then
        try
          fld.index :=aIndex;
        Except
          // kill the exception
        end;
    fld.FieldName:= aFieldName;
    fld.fDisplayWidth:= 10;
    if Assigned(GridDataSet) then begin
      aField:= GridDataset.FindField(aFieldName);
      if Assigned(aField) then begin
        fld.fDisplayWidth:= aField.DisplayWidth;
        fld.DisplayLabel:= aField.DisplayLabel;
        fld.ReadOnly:= aField.ReadOnly;
        fld.GroupName:= cleanselectedList.GroupForField(fld.FieldName);
      end;
    end;
  end;
end;

constructor TGridFieldList.Create;
begin
  inherited Create(TGridFieldRec);

end;

procedure TGridFieldList.Delete(const aName: string);
var
  fld: TGridFieldRec;
begin
  fld := self.GetField(aName);
  if Assigned(fld) then
    self.Delete(fld.Index);
end;

destructor TGridFieldList.Destroy;
begin

  inherited;
end;

//procedure TGridFieldList.DoTranslate;
//var
//  x: integer;
//begin
//  x:= 0;
//  while x < Count do begin
//    items[x].displaylabel := Dotranslation(items[x].displaylabel);
//    Inc(x);
//  end;
//end;

function TGridFieldList.GetField(aName: string): TGridFieldRec;
var
  x: integer;
  s: string;
begin
  result:= nil;
  s:= Lowercase(aName);
  for x:= 0 to Count-1 do begin
    if LowerCase(TGridFieldRec(Items[x]).FieldName) = s then begin
      result:= TGridFieldRec(Items[x]);
      Break;
    end;
  end;
end;

function TGridFieldList.GetText: string;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to count -1 do begin
    if x > 0 then result:= result + #13#10;
    result:= result + TGridFieldRec(Items[x]).AsString;
  end;
end;
function TGridFieldList.REadonlyForField(
  const aFieldName: string): Boolean;
var
  rec: TGridFieldRec;
begin
  rec:= Field[aFieldName];
  if Assigned(rec) then result:= rec.ReadOnly
  else result:= False;
end;

function TGridFieldList.GroupForField(const aFieldName: string): string;
var
  rec: TGridFieldRec;
begin
  rec:= Field[aFieldName];
  if Assigned(rec) then result:= rec.GroupName
  else result:= '';
end;
(*Procedure TGridFieldList.SetGroupForField(const aFieldName: string; const Value: String);
var
  rec: TGridFieldRec;
begin
  rec:= Field[aFieldName];
  if Assigned(rec) then rec.GroupName := Value;
end;*)
procedure TGridFieldList.LoadFromGrid(grid: TwwDbGrid);
begin
  Self.Text := GetGridSelectedText(grid);
(*var
  oldList: TGridFieldList;
  x: integer;
  field: TField;
  rec: TGridFieldRec;
begin
  if grid.UseTFields and grid.DataSource.DataSet.Active then begin
    oldList:= TGridFieldList.Create;
    try
      oldList.Text:= grid.Selected.Text;
      for x:= 0 to grid.DataSource.DataSet.FieldCount-1 do begin
        field:= grid.DataSource.DataSet.Fields[x];
        if field.Visible then begin
          rec:= TGridFieldRec(Add);
          rec.FieldName:= field.FieldName;
          rec.DisplayWidth:= field.DisplayWidth;
          rec.DisplayLabel:= field.DisplayLabel;
          if field.ReadOnly then rec.ReadOnly:= field.ReadOnly else rec.ReadOnly:= oldList.REadonlyForField(field.FieldName);
          rec.GroupName:= oldList.GroupForField(field.FieldName);
        end;
      end;
    finally
      oldList.Free;
    end;
  end
  else begin
    { not storing settings in fields OR dataset not open
      so just grab the grids stored settings }
    self.Text:= grid.Selected.Text;
  end;*)
end;

procedure TGridFieldList.RemoveField(aFieldName: string);
var
  fld: TGridFieldRec;
begin
  fld:= Field[aFieldName];
  if Assigned(fld) then
    self.Delete(fld.Index);
end;
class procedure TGridFieldList.RemoveField(grid: TwwDbGrid; aField: TField);
var
  GridFieldList: TGridFieldList;
begin
  GridFieldList := TGridFieldList.Create;
  try
    GridFieldList.LoadFromGrid(grid);
    GridFieldList.Delete(aField.FieldName);
    GridFieldList.SaveToGrid(grid);
  finally
    GridFieldList.Free;
  end;
end;

class procedure TGridFieldList.RemoveFields(grid: TwwDbGrid;
  aFieldList: string);
var
  GridFieldList: TGridFieldList;
  x: integer;
  sl: TStringList;
begin
  GridFieldList := TGridFieldList.Create;
  sl := TStringList.Create;
  try
    sl.CommaText := aFieldList;
    GridFieldList.LoadFromGrid(grid);
    for x := 0 to sl.Count -1 do
      GridFieldList.Delete(sl[x]);
    GridFieldList.SaveToGrid(grid);
  finally
    GridFieldList.Free;
    sl.Free;
  end;
end;

class procedure TGridFieldList.AddField(grid: TwwDbGrid; aField: TField;
  aGroupName: string);
var
  GridFieldList: TGridFieldList;
begin
  GridFieldList := TGridFieldList.Create;
  try
    GridFieldList.LoadFromGrid(grid);
    GridFieldList.Delete(aField.FieldName);
    GridFieldList.AddField(aField, aGroupName);
    GridFieldList.SaveToGrid(grid);

  finally
    GridFieldList.Free;
  end;


end;

procedure TGridFieldList.AddField(aField: TField; aGroupName: string);
var
  fld: TGridFieldRec;
begin
  if not Assigned(Field[aField.FieldName]) then begin
    fld:= TGridFieldRec(Add);
    fld.FieldName:= aField.FieldName;
    fld.fDisplayWidth:= aField.DisplayWidth;
    fld.DisplayLabel:= aField.DisplayLabel;
    fld.ReadOnly:= aField.ReadOnly;
    fld.GroupName:= aGroupName;
  end;
end;

procedure TGridFieldList.ChangeDisplayLabel(aFieldName: string; const sDisplaylabel:String);
var
  fld: TGridFieldRec;
begin
  fld:= Field[aFieldName];
  if Assigned(fld) then
    fld.DisplayLabel := sDisplaylabel;
end;
procedure TGridFieldList.SaveToGrid(grid: TwwDbGrid);
begin
  grid.Selected.Text:= self.Text;

  { Force the wwDbGrid to update its self and write back to persistant fields }
  grid.ApplySelected;
end;

procedure TGridFieldList.SetText(const Value: string);
var
  sl: TStringList;
  x: integer;
  rec: TGridFieldRec;
begin
  Clear;
  sl:= TStringList.Create;
  try
    sl.Text:= Value;
    for x:= 0 to sl.Count -1 do begin
     rec:=  TGridFieldRec(self.Add);
     rec.AsString:= sl[x];
    end;
  finally;
    sl.Free;
  end;
end;


procedure TGridFieldList.SetAllReadOnly(const Value: boolean);
var
  x: integer;
begin
  for x:= 0 to Count-1 do begin
    TGridFieldRec(Items[x]).ReadOnly:= Value;
  end;
end;

class procedure TGridFieldList.SetDisplayWidth(grid: TwwDbGrid; aFieldName: string;
  aWidth: integer);
var
  GridFieldList: TGridFieldList;
  FieldRec: TGridFieldRec;
begin
  GridFieldList := TGridFieldList.Create;
  try
    GridFieldList.LoadFromGrid(grid);
    FieldRec := GridFieldList.GetField(aFieldName);
    if Assigned(FieldRec) then begin
      FieldRec.DisplayWidth := aWidth;
      GridFieldList.SaveToGrid(grid);
    end;
  finally
    GridFieldList.Free;
  end;
end;

class procedure TGridFieldList.SetFieldGroup(grid: TwwDbGrid; aFieldName,
  aGroupName: string);
var
  GridFieldList: TGridFieldList;
  FieldRec: TGridFieldRec;
begin
  GridFieldList := TGridFieldList.Create;
  try
    GridFieldList.LoadFromGrid(grid);
    FieldRec := GridFieldList.GetField(aFieldName);
    if Assigned(FieldRec) then begin
      FieldRec.GroupName := aGroupName;
      GridFieldList.SaveToGrid(grid);
    end;
  finally
    GridFieldList.Free;
  end;
end;

function TGridFieldList.GetItem(index: integer): TGridFieldRec;
begin
  result:= TGridFieldRec(inherited Items[index]);
end;
Procedure TGridFieldList.ReplaceGroupname(const aName, aGroup , aDisplaylabel: string);
var
  x: integer;
begin
  for x:= 0 to count-1 do begin
    if (Items[x].FieldName = aName)  then begin
      if Items[x].GroupName     <> aGroup         then Items[x].GroupName     := aGroup;
      if Items[x].DisplayLabel  <> aDisplaylabel  then Items[x].DisplayLabel  := aDisplaylabel;
      break;
    end;
  end;
end;

function TGridFieldList.FieldByNameAndGroup(const aName,
  aGroup: string): TGridFieldRec;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to count-1 do begin
    if (Items[x].FieldName = aName) and (Items[x].GroupName = aGroup) then begin
      result:= Items[x];
      break;
    end;
  end;
end;
function TGridFieldList.FieldByName(const aName: string): TGridFieldRec;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to count-1 do begin
    if (Items[x].FieldName = aName)  then begin
      result:= Items[x];
      break;
    end;
  end;
end;

procedure TGridFieldList.Regroup;
var
  x, y: integer;
  currGroup: string;
begin
//  with TStringList.Create do begin
//    Text:= self.Text;
//    SaveToFile('c:\temp\selected1.txt');
//    Free;
//  end;
  x:= 0;
  while x < Count do begin
    if x = 0 then begin
      currGroup:= Items[x].GroupName;
    end
    else begin
      if currGroup <> '' then begin
        if Items[x].GroupName <> currGroup then begin
          y:= x + 1;
          while y < count do begin
            if Items[y].GroupName = currGroup then begin
              Items[y].Index:= x;
              Inc(x);
            end
            else
              Inc(y);
          end;
        end;
        currGroup:= Items[x].GroupName;
      end
      else begin
        currGroup:= Items[x].GroupName;
      end;
    end;
    Inc(x);
  end;
//  with TStringList.Create do begin
//    Text:= self.Text;
//    SaveToFile('c:\temp\selected2.txt');
//    Free;
//  end;
end;

{ TGridFieldRec }

procedure TGridFieldRec.Assign(const Source: TGridFieldRec);
begin
  self.fReadOnly:= source.ReadOnly;
  self.fDisplayWidth:= source.DisplayWidth;
  self.fGroupName:= source.GroupName;
  self.fDisplayLabel:= source.DisplayLabel;
  self.fFieldName:= source.FieldName;
end;

function TGridFieldRec.GetAsString: string;
begin
  result:=
    fFieldName + #9 +
    IntToStr(fDisplayWidth) + #9 +
    fDisplayLabel + #9 +
    BoolToStr(fReadOnly);
  if fGroupName <> '' then
    result:= result + #9 + fGroupName;
end;

function TGridFieldRec.getDisplayWidth: integer;
begin
  if fDisplayWidth = 255 then fDisplayWidth := 20;
  result := fDisplayWidth;
end;

procedure TGridFieldRec.SetAsString(const Value: string);
var
  sd: TStringDynArray;
begin
  sd:= SplitString(Value,#9);
  if High(sd) >= 2 then begin
    fFieldName:= sd[0];
    fDisplayWidth:= StrToInt(sd[1]);
    fDisplayLabel:= sd[2];
    if High(sd) > 2 then fReadOnly:= StrToBool(sd[3]) else fReadOnly:= False;
    if High(sd) > 3 then fGroupName:= sd[4]           else fGroupName:= '';
  end;
end;


procedure TGridFieldRec.setDisplayWidth(const Value: integer);
begin
  fDisplayWidth:= Value;
  if fDisplayWidth = 255 then fDisplayWidth := 20;
end;

//function Dotranslation(const Value:String):String;
//begin
//  Result := TLanguageTranslationObj.Inst.DoTranslate(Value , TLanguageTranslationObj.Inst.UserLanguageId, []);
//end;

end.
