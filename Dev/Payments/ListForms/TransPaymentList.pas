unit TransPaymentList;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/09/05  1.00.01 IJB  Added RegisterClass to initialization section and moved
                        DblClickType to published so can be accessed by TypInfo
                        functions.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript;

type
  TTransPaymentListGUI = class(TBaseListingGUI)
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
  protected
    procedure RefreshQuery; override;
    procedure SetGridColumns; Override;
    procedure RefreshTotals; override;
  public
  published
  end;

implementation

uses
  CommonLib, FastFuncs;

{$R *.dfm}

{ TTransPaymentListGUI }

procedure TTransPaymentListGUI.RefreshQuery;
begin
  inherited;
  TFloatField(qryMain.FieldByName('Payment Amount')).currency := true;
end;

procedure TTransPaymentListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TTransPaymentListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('DblClickType');
end;

procedure TTransPaymentListGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  Self.Caption := StringReplace(Self.Caption,' - (Read Only)','',[]);
  AddCalcColumn('Payment Amount', true);
end;

procedure TTransPaymentListGUI.grdMainDblClick(Sender: TObject);
begin
  //SubsequentID := Chr(95) + fsDblClickType;
  SubsequentID := Chr(95) + Qrymain.fieldbyname('DblClickType').asString;
  inherited;
end;

initialization
  RegisterClassOnce(TTransPaymentListGUI);
end.
