unit ERPhindWindow;

interface
uses Controls, classes;
type
   TERPhindWindow = class(THintWindow)
     constructor Create(AOwner: TComponent); override;
   end;

implementation
{ TERPhindWindow }

constructor TERPhindWindow.Create(AOwner: TComponent);
begin
  inherited;
   inherited Create(AOwner);
   //Canvas.Brush.Color := Self.Color;
   with Canvas.Font do begin
     Name := 'Arial';
     Size := 10;
   end;
end;

end.

