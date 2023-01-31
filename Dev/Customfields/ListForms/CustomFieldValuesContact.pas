unit CustomFieldValuesContact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TCustomFieldValuesContactGUI = class(TCustomFieldValuesBaseGUI)
    qryMaincompany: TWideStringField;
    qryMainISCustomer: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainisSupplier: TWideStringField;
    qryMainisOtherContact: TWideStringField;
    qryMaintype: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);override;
  private
  Protected
    function ExtraTables:String;Override;
    Function ExtraFeilds:String;Override;
    procedure SetGridColumns; Override;
  public
  end;

implementation

uses CommonLib, Busobjcustomfields, tcConst;

{$R *.dfm}

{ TCustomFieldValuesContactGUI }

function TCustomFieldValuesContactGUI.ExtraFeilds: String;
begin
  Result := 'C.company as company, ' + NL+
            ' C.IsJob as  IsJob, ' + NL+
            ' C.Customer as ISCustomer, ' + NL+
            ' C.Supplier as isSupplier, ' + NL+
            ' C.OtherContact as isOtherContact, ' + NL+
            ' if(C.Supplier ="T" , "Supplier", if(C.Customer ="T" , "Customer", if(C.OtherContact ="T" , "OtherContact", if(C.IsJob ="T" , "IsJob","" )))) as type, ' ;
end;

function TCustomFieldValuesContactGUI.ExtraTables: String;
begin
  REsult :=' inner join tblclients C on M.ClientID = C.clientId ';
end;

procedure TCustomFieldValuesContactGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
  inherited;

end;

procedure TCustomFieldValuesContactGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymaintype.fieldname);
end;

initialization
  RegisterClassOnce(TCustomFieldValuesContactGUI);

end.
