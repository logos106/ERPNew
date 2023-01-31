unit UOMMismatchinBOMPQA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, wwcheckbox;

type
  TUOMMismatchinBOMPQAGUI = class(TBaseListingGUI)
    qryMainsAleID: TIntegerField;
    qryMainsalelineId: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMainSLUOM: TWideStringField;
    qryMainPQAUOM: TWideStringField;
    qryMainPTPQAUOM: TWideStringField;
    qryMainSLUOMMUlt: TFloatField;
    qryMainpqaUOMMUlt: TFloatField;
    qryMainptppqaUOMMUlt: TFloatField;
    qryMainSLUOMID: TIntegerField;
    qryMainpqaUOMID: TIntegerField;
    qryMainptpqaUOMID: TIntegerField;
    qryMainSLuomqty: TFloatField;
    qryMainpqauomqty: TFloatField;
    qryMainptpqauomqty: TFloatField;
    qryMainSLQty: TFloatField;
    qryMainptpqaQty: TFloatField;
    qryMainpqaQty: TFloatField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainPQAID: TIntegerField;
    qryMainPTPQaID: TIntegerField;
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    strSql:String;
    procedure CreateTablebackups;
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;      SelIndex: Integer);override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, DebugLib, CommonDbLib, tcConst;

{$R *.dfm}

procedure TUOMMismatchinBOMPQAGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  CreateTablebackups;
end;


procedure TUOMMismatchinBOMPQAGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('PQAID');
  RemoveFieldfromGrid('PTPQaid');
end;

procedure TUOMMismatchinBOMPQAGUI.CreateTablebackups;
var
  s:String;
begin
  if qrymain.RecordCount=0 then exit;

  if grdmain.SelectedList.Count =0 then
    if MessageDlgXP_Vista('No Product selected for recalculation. Do you wish to select aal products?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit
    else grdmain.selectall;

  s:= DoBackuptables(['tblpqa'] , '_UOMMismatchinBOMPQA' , true);
  if s<> '' then
    executeSQL(s);
  strSql:= '';
  IterateProcNo:= 1;
  IterateselectedRecords(true);
  if strSQL<> '' then begin
    executeSQL(strSQL);
    RefreshQuery;
  end;

end;
procedure TUOMMismatchinBOMPQAGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if IterateProcNo = 1 then begin
    if not(SameText(qryMainSLUOM.AsString,qryMainPQAUOM.AsString)) or
        ( qryMainSLUOMMUlt.AsFloat <> qryMainpqaUOMMUlt.AsFloat ) or
        ( qryMainSLUOMID.asinteger <> qryMainpqaUOMID.asinteger ) or
        ( qryMainSLuomqty.AsFloat <> qryMainpqauomqty.AsFloat ) or
        ( qryMainSLQty.AsFloat <> qryMainpqaQty.AsFloat ) then begin
      strSQL := strsql + Nl +'update tblpqa set ' +
                      ' UOMMultiplier = ' +floattostr(qryMainSLUOMMUlt.AsFloat) +',  ' +
                      ' uomid = ' + inttostr(qryMainSLUOMID.asinteger)+', ' +
                      ' uomqty =' + FloatTostr(qryMainSLuomqty.AsFloat)+',  ' +
                      ' qty =' +Floattostr(qryMainSLQty.AsFloat) +'  ' +
                      ' where pqaid = ' + inttostr(Qrymainpqaid.AsInteger)+';';
    end;

    if not(SameText(qryMainSLUOM.AsString,qrymainPTPqaUOM.AsString)) or
        ( qryMainSLUOMMUlt.AsFloat <> qryMainptppqaUOMMUlt.AsFloat ) or
        ( qryMainSLUOMID.asinteger <> qrymainPTPqaUOMID.asinteger ) or
        ( qryMainSLuomqty.AsFloat <> qrymainPTPqauomqty.AsFloat ) or
        ( qryMainSLQty.AsFloat <> qrymainPTPqaQty.AsFloat ) then begin
      strSQL := strsql + Nl +'update tblpqa set ' +
                      ' UOMMultiplier = ' +floattostr(qryMainSLUOMMUlt.AsFloat) +',  ' +
                      ' uomid = ' + inttostr(qryMainSLUOMID.asinteger)+', ' +
                      ' uomqty =' + FloatTostr(qryMainSLuomqty.AsFloat)+',  ' +
                      ' qty =' +Floattostr(qryMainSLQty.AsFloat) +'  ' +
                      ' where pqaid = ' + inttostr(qrymainPTPqaid.AsInteger)+';';
    end;
  end;

end;

initialization
  RegisterClassOnce(TUOMMismatchinBOMPQAGUI);

end.

