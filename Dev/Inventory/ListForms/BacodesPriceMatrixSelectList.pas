unit BacodesPriceMatrixSelectList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,
  wwdbdatetimepicker, ProgressDialog, DNMSpeedButton, CustomInputBox,
  wwdblook, Shader, kbmMemTable;

type
  TBarcodePriceMatrixGUI = class(TBaseListingGUI)
    btnContinue: TDNMSpeedButton;
    qryMainPriceMatrixID: TAutoIncField;
    qryMainPartsID: TIntegerField;
    qryMainUnitofMeasure: TStringField;
    qryMainDescAttrib1: TStringField;
    qryMainDescAttrib2: TStringField;
    qryMainDescAttrib3: TStringField;
    qryMainDescAttrib4: TStringField;
    qryMainDescAttrib5: TStringField;
    qryMainBARCODE: TStringField;
    qryMainPriceMatrixDesc: TStringField;
    qryMainProductName: TStringField;
    pnlBarCode: TDNMPanel;
    lblBarCode: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    { Private declarations }
    fiPartsID: integer;
    iCount: integer;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
    property ProductID: integer read fiPartsID write fiPartsID;
    property Count: integer read iCount write iCount;
  end;

var
  BarcodePriceMatrixGUI: TBarcodePriceMatrixGUI;

implementation

uses CommonDbLib, dnmlib;

{$R *.dfm}

procedure TBarcodePriceMatrixGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  BarcodePriceMatrixGUI := nil;
end;

procedure TBarcodePriceMatrixGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('ID').asInteger := fiPartsID;
  inherited;
end;

procedure TBarcodePriceMatrixGUI.FormShow(Sender: TObject);
begin
  inherited;
  grdMain.Options := grdMain.Options + [dgMultiSelect];
  grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoShiftSelect];

  grdMain.columnbyName('DescAttrib1').DisplayLabel := GetDescAttribName(1);
  grdMain.columnbyName('DescAttrib2').DisplayLabel := GetDescAttribName(2);
  grdMain.columnbyName('DescAttrib3').DisplayLabel := GetDescAttribName(3);
  grdMain.columnbyName('DescAttrib4').DisplayLabel := GetDescAttribName(4);
  grdMain.columnbyName('DescAttrib5').DisplayLabel := GetDescAttribName(5);
  if not IsDescAttribVisible(1) then grdMain.RemoveField('DescAttrib1');
  if not IsDescAttribVisible(2) then grdMain.RemoveField('DescAttrib2');
  if not IsDescAttribVisible(3) then grdMain.RemoveField('DescAttrib3');
  if not IsDescAttribVisible(4) then grdMain.RemoveField('DescAttrib4');
  if not IsDescAttribVisible(5) then grdMain.RemoveField('DescAttrib5');
end;

procedure TBarcodePriceMatrixGUI.btnContinueClick(Sender: TObject);
var
  i, j: integer;
  qrytemp: TMyQuery;
begin
  inherited;
  qrytemp := TMyQuery.Create(self);
  qrytemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    for i := 0 to grdMain.SelectedList.Count - 1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
      for j := 0 to iCount - 1 do begin
        qrytemp.SQL.Clear;
        qrytemp.Sql.Add('INSERT HIGH_PRIORITY INTO tblbarcodestoprint (ProductID,PriceMatrixID) VALUES (' +
          qryMain.FieldByName('PartsID').AsString + ',' + qryMain.FieldByName('PriceMatrixID').AsString + ')');
        qrytemp.Execute;
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
  Close;
end;

procedure TBarcodePriceMatrixGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TBarcodePriceMatrixGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
end;

end.
