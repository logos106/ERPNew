unit QuoteListExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SaleslistExpress, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TQuoteListExpressGUI = class(TSaleslistExpressGUI)
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    Function ExpressDetailListName:String;Override;
    Function ListType:String;Override;
    procedure SetGridColumns; Override;
    procedure MakeQryMain; Override;
  public
  end;


implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}
{ TQuoteListExpressGUI }

procedure TQuoteListExpressGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TQuoteGUI' , 0);
end;

function TQuoteListExpressGUI.ExpressDetailListName: String;begin  Result := 'TQuoteListGUI';end;

procedure TQuoteListExpressGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin   // Active Quotes
        GroupFilterString := 'Done = ' + QuotedStr('F') + ' AND Converted = ' + QuotedStr('F');
      end;

    1:
      begin // Converted Quotes
        GroupFilterString := 'Converted = ' + QuotedStr('T');
      end;

    2:
      begin // Completed Quotes
        GroupFilterString := 'Done = ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

function TQuoteListExpressGUI.ListType: String;begin  REsult := 'Quote'end;


procedure TQuoteListExpressGUI.MakeQryMain;
begin
  ExcludeDeleted := false;
  inherited;
end;

procedure TQuoteListExpressGUI.SetGridColumns;
begin
    RemoveFieldfromGrid(qryMainPayment.Fieldname);
    RemoveFieldfromGrid(qryMainBalance.Fieldname);
    RemoveFieldfromGrid(qryMainConverted.Fieldname);
    RemoveFieldfromGrid(qryMainType.Fieldname);
    RemoveFieldfromGrid('futureso');
    RemoveFieldfromGrid('Shipdate');
    RemoveFieldfromGrid('Held');
    RemoveFieldfromGrid('PONumber');
    RemoveFieldfromGrid('Terms');
end;

initialization
  RegisterClassOnce(TQuoteListExpressGUI);

end.

