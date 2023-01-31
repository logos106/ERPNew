unit ERPCombinedContacts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel , ERPCombinedContactsSQL;

type
  TERPCombinedContactsGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainprintname: TWideStringField;
    qryMainisprospect: TWideStringField;
    qryMainiscustomer: TWideStringField;
    qryMainissupplier: TWideStringField;
    qryMainisEmployee: TWideStringField;
    qryMainphone: TWideStringField;
    qryMainmobile: TWideStringField;
    qryMainaltphone: TWideStringField;
    qryMainemail: TWideStringField;
    qryMainstreet: TWideStringField;
    qryMainstreet2: TWideStringField;
    qryMainstreet3: TWideStringField;
    qryMainsuburb: TWideStringField;
    qryMainstate: TWideStringField;
    qryMainpostcode: TWideStringField;
    qryMainTYPE: TWideStringField;
    qryMainname: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ERPCombinedContacts : TERPCombinedContacts;
    procedure MakeQrymain;
  Protected
    Procedure SetGridColumns;override;

  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TERPCombinedContactsGUI.FormCreate(Sender: TObject);
begin
  ERPCombinedContacts := TERPCombinedContacts.Create;
  MakeQrymain;
  inherited;
  HaveDateRangeSelection := False;
end;
Procedure TERPCombinedContactsGUI.MakeQrymain;
var
  msg:String;
begin
  ERPCombinedContacts.PopulateReportSQL(qryMain.SQL, msg);
  self.RefreshOrignalSQL();
end;

procedure TERPCombinedContactsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainTYPE.fieldname);
end;

procedure TERPCombinedContactsGUI.FormDestroy(Sender: TObject);
begin
  ERPCombinedContacts.Free;
  inherited;

end;

initialization
  RegisterClassOnce(TERPCombinedContactsGUI);

end.
