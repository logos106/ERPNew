unit JournalEnrties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpress, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TJournalEnrtiesGUI = class(TBaseListExpressGUI)
    qryMainGJID: TIntegerField;
    qryMainTransactionDate: TDateField;
    qryMainTransactionNo: TWideStringField;
    qryMainAmount: TFloatField;
    qryMainTaxSelect: TWideStringField;
    qryMainMemo: TWideStringField;
    qryMainApproved: TWideStringField;
    qryMainDeleted: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    fClientId: integer;
  Protected
    Function ExpressDetailListName:String;Override;
  public
    Procedure RefreshQuery;Override;
    property ClientId: integer read fClientId write fClientId;
  end;

implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}

{ TBaseListExpressGUI1 }

procedure TJournalEnrtiesGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TJournalEntryGUI' , 0);
end;

function TJournalEnrtiesGUI.ExpressDetailListName: String;
begin
  result :='TJournalListGui';
end;
procedure TJournalEnrtiesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fClientId:= 0;
end;

procedure TJournalEnrtiesGUI.RefreshQuery;
begin
  qryMain.Close;
  InitDateFromnDateto('txtfrom' ,'txtto');
  inherited;

end;

initialization
  RegisterClassOnce(TJournalEnrtiesGUI);

end.
