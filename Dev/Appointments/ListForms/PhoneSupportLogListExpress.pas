unit PhoneSupportLogListExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpress, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPhoneSupportLogListExpressGUI = class(TBaseListExpressGUI)
    qryMainSupportLogID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainContact: TWideStringField;
    qryMainDateCreated: TDateTimeField;
    qryMainModule: TWideStringField;
    qryMainType: TWideStringField;
    qryMainIssue: TWideMemoField;
    qryMainSolution: TWideMemoField;
    qryMainCallTime: TWideStringField;
    qryMainFinished: TWideStringField;
    qryMainVersion: TWideStringField;
    qryMainCallSecs: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fiCustomerId: Integer;
  Protected
    procedure SetGridColumns; Override;
    procedure ApplyQueryFilter; override;
  public
    Function ExpressDetailListName:String;Override;
    Property CustomerId :Integer read fiCustomerId write fiCustomerId;
    procedure RefreshQuery; Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TPhoneSupportLogListExpressGUI }

procedure TPhoneSupportLogListExpressGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {All}
        GroupFilterString := '';
      end;
    1:
      begin {Finished}
        GroupFilterString := '(Finished = "T")';
      end;
    2:
      begin {Not Finised}
        GroupFilterString := '(Finished = "F")';
      end;
  end;
  inherited;
end;

function TPhoneSupportLogListExpressGUI.ExpressDetailListName: String;
begin
  REsult := 'TPhSupportLogListGUI';
end;

procedure TPhoneSupportLogListExpressGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiCustomerId:=0;
end;

procedure TPhoneSupportLogListExpressGUI.FormShow(Sender: TObject);
begin
  inherited;
  cmdnew.Enabled := False;  // input form is opened from customer on suppport with the customer selected
end;

procedure TPhoneSupportLogListExpressGUI.RefreshQuery;
begin
  Qrymain.Parambyname('CustomerId').asInteger := fiCustomerId;
  inherited;

end;

procedure TPhoneSupportLogListExpressGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('SupportLogId');
end;

initialization
  RegisterClassOnce(TPhoneSupportLogListExpressGUI);

end.

