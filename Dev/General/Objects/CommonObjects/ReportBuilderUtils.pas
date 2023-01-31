unit ReportBuilderUtils;

interface

uses
  ppEndUsr;

procedure DisableDesignerToolbar(Designer: TppDesigner; MenuCaption: string);

implementation

uses
  ppTB2Item, FastFuncs, sysutils;

procedure DisableDesignerToolbar(Designer: TppDesigner; MenuCaption: string);
var
  x: integer;
  item: TppTBCustomItem;

  function GetSubItemByCaption(aItem: TppTBCustomItem; aCaption: string): TppTBCustomItem;
  var i: integer;
  begin
    result:= nil;
    if  Lowercase(StringReplace(aItem.Caption,'&','',[rfReplaceAll])) = Lowercase(aCaption) then begin
      result:= aItem;
    end
    else begin
      for i:= 0 to aItem.Count-1 do begin
        result:= GetSubItemByCaption(aItem.Items[i],aCaption);
        if Assigned(result) then
          break;
      end;
    end;
  end;


begin
  item:= nil;
  for x:= 0 to Designer.Menu.Items.Count-1 do begin
    item:= GetSubItemByCaption(Designer.Menu.Items[x], MenuCaption);
    if Assigned(item) then
      break;
  end;
  if Assigned(item) then begin
    if item.Checked then
      item.Click;
    item.Enabled:= false;
  end;
end;

end.
