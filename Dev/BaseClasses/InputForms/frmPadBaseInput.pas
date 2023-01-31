unit frmPadBaseInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  AdvSmoothExpanderGroup, ActnList, StdCtrls, ProgressDialog;

type
  TfmPadBaseInput = class(TBaseInputGUI)
    segMain: TAdvSmoothExpanderGroup;
    ActionList: TActionList;
    actSave: TAction;
    actNew: TAction;
    actCancel: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfmPadBaseInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

end.
