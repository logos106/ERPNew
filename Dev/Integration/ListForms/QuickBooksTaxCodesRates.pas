unit QuickBooksTaxCodesRates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TQuickBooksTaxCodesRatesGUI = class(TBaseListingGUI)
    qryMaintype: TWideStringField;
    qryMainvalue: TWideStringField;
    qryMainname: TWideStringField;
    qryMainSubTID: TLargeintField;
    qryMainTID: TLargeintField;
    qryMainseqno: TLargeintField;
    qryMainTaxName: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure MakeQrymain(const Taxcodetablename, POTablename, SalesTablename:String);
  end;

implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}

{ TQuickBooksTaxCodesRatesGUI }

procedure TQuickBooksTaxCodesRatesGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain('', '','');
  HaveDateRangeSelection := False;
  NonSearchMode:= true;
  inherited;
  ShowGridOnlyinPanel := True;
end;

procedure TQuickBooksTaxCodesRatesGUI.MakeQrymain(const Taxcodetablename, POTablename,  SalesTablename: String);
begin
  closedb(QryMain);
      QryMain.SQL.clear;
  if (POTablename <> '') and (tableexists(POTablename)) and
     (SalesTablename <> '') and (tableexists(SalesTablename)) and
     (Taxcodetablename <> '') and (tableexists(Taxcodetablename))  then begin
      QryMain.SQL.Add('SELECT');
      QryMain.SQL.Add('"PO"                       as Type,');
      QryMain.SQL.Add('CONVERT(T.SubTID , signed) AS SubTID,');
      QryMain.SQL.Add('CONVERT(T.TID , signed)    AS TID,');
      QryMain.SQL.Add('T.VALUE                    as VALUE,');
      QryMain.SQL.Add('T.NAME                     as NAME,');
      QryMain.SQL.Add('TT.Name                    as TaxName,');
      QryMain.SQL.Add('CONVERT(T.seqno , signed)  AS seqno');
      QryMain.SQL.Add('FROM ' + POTablename +' T ');
      QryMain.SQL.Add('inner join ' + Taxcodetablename +' TT on T.TID = TT.TID');
      QryMain.SQL.Add('UNION ALL');
      QryMain.SQL.Add('SELECT ');
      QryMain.SQL.Add('"Sales"                    as Type,');
      QryMain.SQL.Add('CONVERT(T.SubTID , signed) AS SubTID,');
      QryMain.SQL.Add('CONVERT(T.TID , signed)    AS TID,');
      QryMain.SQL.Add('T.VALUE                    as VALUE,');
      QryMain.SQL.Add('T.NAME                     as NAME,');
      QryMain.SQL.Add('TT.Name                    as TaxName,');
      QryMain.SQL.Add('CONVERT(T.seqno , signed)  AS seqno');
      QryMain.SQL.Add('FROM ');
      QryMain.SQL.Add(''+ SalesTablename +' T');
      QryMain.SQL.Add('inner join ' + Taxcodetablename +' TT on T.TID = TT.TID');
  end else begin
      QryMain.SQL.Add('SELECT ""            as TYPE, ');
      QryMain.SQL.Add('CONVERT(0 , signed)  AS SubTID, ');
      QryMain.SQL.Add('CONVERT(0 , signed)  AS TID, ');
      QryMain.SQL.Add('""                   AS VALUE, ');
      QryMain.SQL.Add('""                   AS NAME , ');
      QryMain.SQL.Add('""                   AS TaxName , ');
      QryMain.SQL.Add('CONVERT(0 , signed)  AS seqno ');
      QryMain.SQL.Add('FROM dual ');
      QryMain.SQL.Add('LIMIT 0 ');
  end;
  RefreshOrignalSQL(False);
  if isformshown then RefreshQuery;
end;

procedure TQuickBooksTaxCodesRatesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainSubTID.Fieldname);
  RemoveFieldfromGrid(qryMainTID.Fieldname);
  RemoveFieldfromGrid(qryMainvalue.Fieldname);
  RemoveFieldfromGrid(qryMainSeqno.Fieldname);
end;


initialization
  RegisterClassOnce(TQuickBooksTaxCodesRatesGUI);

end.

