unit SalesDashBoardTopTenDetailbase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesDashBoardDetails, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, wwcheckbox, CustomInputBox;

type
  TSalesDashBoardTopTenDetailbaseGUI = class(TSalesDashBoardDetailsGUI)
    qryMainDetailname: TWideStringField;
    qryMainPrice: TFloatField;
    qryMainMargin: TFloatField;
    qryMainType: TWideStringField;
    btnSummary: TDNMSpeedButton;
    qryMainSaleID: TIntegerField;
    qryMainId: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure btnSummaryClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  Protected
    Idtofilter:Integer;
    function getSQL:String ; virtual;
    procedure SetGridColumns; Override;
    procedure RefreshTotals; override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonFormLib;

{$R *.dfm}

{ TSalesDashBoardTopTenDetailbaseGUI }

procedure TSalesDashBoardTopTenDetailbaseGUI.btnSummaryClick(Sender: TObject);
begin
   inherited;
   Idtofilter:=0;
   RefreshQuery;
end;

procedure TSalesDashBoardTopTenDetailbaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalccolumn(Qrymainprice.FieldName, true);
  AddCalccolumn(Qrymainmargin.FieldName, true);
  Idtofilter:=0;
end;

procedure TSalesDashBoardTopTenDetailbaseGUI.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and (btnSummary.visible) and (IDTofilter<>0) then begin
    IDTofilter:=0;
    btnSummary.click;
    exit;
  end;
  inherited;

end;

procedure TSalesDashBoardTopTenDetailbaseGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.caption := 'Sales Dashboard Details';
end;

function TSalesDashBoardTopTenDetailbaseGUI.getSQL: String;
begin
  result:= '';
end;

procedure TSalesDashBoardTopTenDetailbaseGUI.grdMainDblClick(Sender: TObject);
begin
  if Idtofilter = 0 then begin
    Idtofilter:= QrymainId.AsInteger;
    RefreshQuery;
  end else begin
    SubsequentID := Chr(95) + qryMainType.AsString;
    inherited;
  end;
end;

procedure TSalesDashBoardTopTenDetailbaseGUI.RefreshQuery;
begin
  Qrymain.disablecontrols;
  try
    closedb(Qrymain);
    Qrymain.SQL.Clear;
    Qrymain.SQL.Add(getSQL);
    inherited;
    btnSummary.Visible :=  Idtofilter<> 0;
    if Idtofilter <> 0 then begin
      guiprefs.DbGridElement[grdmain].AddField(QrymainsaleId.fieldname);
      guiprefs.DbGridElement[grdmain].AddField(Qrymaintype.FieldName);
      QrymainsaleId.Index :=0;
      Qrymaintype.Index := 0;
    end else begin
      RemoveFieldfromGrid(QrymainsaleId.FieldName);
      RemoveFieldfromGrid(Qrymaintype.FieldName);
    end;
  finally
    Qrymain.EnableControls
  end;
end;

procedure TSalesDashBoardTopTenDetailbaseGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TSalesDashBoardTopTenDetailbaseGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainId.FieldName);
end;

end.

