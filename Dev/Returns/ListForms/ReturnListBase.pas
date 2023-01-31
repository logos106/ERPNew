unit ReturnListBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TReturnListBaseGUI = class(TBaseListingGUI)
    btndelete: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    KeysPressed:String;
  Protected
    Procedure beforeOpenDetails(Sender:TObject);
  public

  end;


implementation

uses TransReturnList, tcConst;

{$R *.dfm}

{ TReturnListBaseGUI }

procedure TReturnListBaseGUI.beforeOpenDetails(Sender: TObject);
begin
  if not(Sender is TTransReturnListGUI) then exit;
  TTransReturnListGUI(Sender).TransType  := '';
  TTransReturnListGUI(Sender).transRef   := '';
  TTransReturnListGUI(Sender).ID         := Qrymain.fieldbyname('ID').AsInteger;
  TTransReturnListGUI(Sender).ReturnCode := '';
end;

procedure TReturnListBaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
  grdmain.hint := 'Each Return stores the Current ''Summary Date'' in the system when the return was created.' + NL +
                    'The Return will be readonly if '+NL+
                    '  --> Existing Retunr : The summary date of the return is greater than the current summary date' +NL+
                    '  --> New Return : The LAST return''s summary date is greater than the current summary date' +NL+
                    '  --> All returns except the last return/New Return' +NL;
  grdmain.showhint := True;
end;

procedure TReturnListBaseGUI.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift ) and (Key in [ord('D') , ord('E') , ord('L') , ord('E') , ord('T'), ord('E')]) then begin
      KeysPressed :=KeysPressed +chr(key);
    if Sysutils.SameText(KeysPressed , 'DELETE') then begin
      btndelete.visible := True;
    end;
  end else KeysPressed := '';

end;

procedure TReturnListBaseGUI.grpFiltersClick(Sender: TObject);
begin
    (*GroupFilterString := '';
    case grpFilters.ItemIndex of
    0:GroupFilterString := 'Done = ' + QuotedStr('F');
    1:GroupFilterString := 'Done = ' + QuotedStr('T');
  end;*)
  inherited;

end;

end.

