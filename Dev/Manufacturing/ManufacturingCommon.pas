unit ManufacturingCommon;

interface

uses
  Forms;

implementation


var
  PrevApplication: TApplication;
  PrevScreen: TScreen;




initialization
  IsLibrary:= true;
  PrevApplication := Application;
  PrevScreen := Screen;

finalization
  Application := PrevApplication;
  Screen := PrevScreen;

end.
    
