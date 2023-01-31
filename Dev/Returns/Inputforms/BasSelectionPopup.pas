unit BasSelectionPopup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, Grids, Wwdbigrd,
  Wwdbgrid, DB, DBCtrls, MyAccess,ERPdbComponents, MemDS, DBAccess, BasObj, frmBase, IntegerListObj,
  Menus;

type
  TBasSelectionGUI = class(TfrmBaseGUI)
    ActionLbl: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    List: TwwDBGrid;
    DSMain: TDataSource;
    edtSearch: TEdit;
    Label9: TLabel;
    qryMain: TERPQuery;
    dsSelected: TDataSource;
    QrySelected: TERPQuery;
    grdSelected: TwwDBGrid;
    lblSelected: TLabel;
    grdSelectedIButton: TwwIButton;
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure grdSelectedIButtonClick(Sender: TObject);
    procedure QrySelectedAfterScroll(DataSet: TDataSet);
    procedure grdSelectedRowChanged(Sender: TObject);
  private
    SelectedIds:TIntegerlist;
    MultiSelecting:Boolean;
    fiAccesslevel: Integer;
    fbformshown:Boolean;
    Function IDfield:String;
    Procedure CloseDB(Ds:TDataset);
    Procedure openDB(Ds:TDataset);
    Procedure OpenSelectedlist;
    (*function SelectedIDs(IDFieldname:String; ignoreduplicates:Boolean = False):STring;*)
  public
    { Public declarations }
     BAS : TBASObj;
     Property Accesslevel :Integer read fiAccesslevel write fiAccesslevel;
  end;


implementation

uses StrUtils, CommonDbLib, CommonLib, ReturnObj;

{$R *.dfm}

procedure TBasSelectionGUI.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TBasSelectionGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeandNil(BAS);
  inherited;
  Action := caFree;
end;

procedure TBasSelectionGUI.FormPaint(Sender: TObject);
begin
  inherited;
  PaintGradientColor(Self);
end;

procedure TBasSelectionGUI.FormShow(Sender: TObject);
var
  comp: TComponent;
  I,StatusAndToolbarHeight: integer;
begin
  try
    inherited;
    BAS.Initialize;
    if BAS.BMList.Count <> 0 then begin
      for I := 0 to BAS.BMList.Count-1 do begin
        qryMain.GotoBookmark(BAS.BMList.Items[i]);
        List.SelectRecord;
      end;
      qryMain.First;
    end;
    commonlib.SelectedIDs(List, Idfield, SelectedIDs ,true);
    SelectedIDs.add(0);//for the SQL when the list is blank

    OpenSelectedlist;

    with BAS.qryMain do begin
      case BAS.ObjType of
        ftTax:
          begin
            Self.ActionLbl.caption :=  'Select Tax Code(s) :';
            Self.caption :=  'Select Tax Code(s)';
            lblSelected .caption :=  'Selected Tax Code(s) :';
          end;
        ftAcc:
          begin
            Self.ActionLbl.caption :=  'Select Account(s)';
            Self.caption :=  'Select Account(s)';
            lblSelected.caption :=  'Selected Tax Account(s)';
          end;
      end;
    end;

    StatusAndToolbarHeight := 0;
    comp := CommonLib.FindControlClass(Application.MainForm, 'TToolBar');
    if Assigned(comp) then StatusAndToolbarHeight := TToolBar(comp).Height;
    comp := CommonLib.FindControlClass(Application.MainForm, 'TAdvOfficeStatusBar');
    if Assigned(comp) then StatusAndToolbarHeight := StatusAndToolbarHeight + TAdvOfficeStatusBar(comp).Height;

    if (Self.FormStyle <> fsMDIChild) then begin
      Top := ((Application.MainForm.ClientHeight + StatusAndToolbarHeight) - Self.Height) shr 1;
    end else begin
      Top := ((Application.MainForm.ClientHeight - StatusAndToolbarHeight) - Self.Height) shr 1;
    end;
    Left := ((Application.MainForm.ClientWidth - Self.Width) shr 1);
  finally
    if accesslevel <> 1 then ReadonlyGrid(List);
    if accesslevel <> 1 then ReadonlyGrid(grdSelected);
    btnCompleted.enabled := Accesslevel = 1;
    fbformshown:= true;
  end;
end;

procedure TBasSelectionGUI.grdSelectedIButtonClick(Sender: TObject);
begin
  inherited;
  if Qrymain.locate(IDfield, QrySelected.fieldbyname(IDfield).asInteger, []) then begin
    Setcontrolfocus(list);
    application.ProcessMessages;
    list.UnselectRecord;
    application.ProcessMessages;
    Qrymain.locate(IDfield, QrySelected.fieldbyname(IDfield).asInteger, []);
  end;
end;

procedure TBasSelectionGUI.grdSelectedRowChanged(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = grdSelected then
    Qrymain.locate(IDfield, QrySelected.fieldbyname(IDfield).asInteger, []);
end;

(*function TBasSelectionGUI.SelectedIDs(IDFieldname:String; ignoreduplicates:Boolean = False):STring;
var
  st:tSTringList;
begin
  st:=tSTringList.create;
  try
      commonlib.SelectedIDs(List, IDFieldName, st ,ignoreduplicates);
  finally
    st.Delimiter:= ',';
    result := st.DelimitedText;
    if result = '' then result :='0'  ;
      Freeandnil(St);
  end;
end;*)
procedure TBasSelectionGUI.btnCompletedClick(Sender: TObject);
begin
  BAS.AssignBookmarks(List.SelectedList);
  BAS.Calc;
  Self.Close;
end;

procedure TBasSelectionGUI.edtSearchChange(Sender: TObject);
var
  sFieldName: string;
begin
  if (edtSearch.Text <> '') and (qryMain.RecordCount > 2) then begin
    sFieldName   := qryMain.Fields[0].FieldName;
//    qryMain.IndexFieldNames := '[' + sFieldName + '] ASC';
// added order by clause to sql to replace above
    DSMain.Dataset.Locate(sFieldName, edtSearch.Text, [loCaseInsensitive, loPartialKey]);
  end;
end;

procedure TBasSelectionGUI.FormCreate(Sender: TObject);
begin
  inherited;
    qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;
  BAS := TBASObj.Create;
  BAS.OwnerForm := self;
  BAS.qryMain := qryMain;
  SelectedIds:=TIntegerlist.create;
  MultiSelecting := False;
  fiAccesslevel:= 1;
  fbformshown:= false;
end;

procedure TBasSelectionGUI.CloseDB(Ds: TDataset);
begin
  if ds = nil then exit;
  if ds.Active then ds.Close;
end;

procedure TBasSelectionGUI.openDB(Ds: TDataset);
begin
  if ds = nil then exit;
  if ds.Active = False then ds.Open;

end;


procedure TBasSelectionGUI.OpenSelectedlist;
begin
  closeDB(QrySelected);
  QrySelected.SQL.clear;
  QrySelected.Connection := qrymain.connection;
  case BAS.ObjType of
      ftTax:
        begin
            QrySelected.SQL.add('SELECT Name as "TaxCode Name", Description ,TaxCodeID FROM tbltaxcodes Where TaxCodeID in (' +SelectedIDs.commatext+') order by name');

        end;
      ftAcc:
        begin
            QrySelected.sql.add('SELECT tblChartofAccounts.AccountName as "Account Name",AccDesc AS Type,tblChartofAccounts.Description as "Description",AccountID ');
            QrySelected.sql.add('FROM tblChartofAccounts LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType=tblChartofAccounts.AccountType ');
            QrySelected.sql.add('WHERE AccountID in (' +SelectedIDs.commatext+') ORDER BY tblChartofAccounts.AccountType, tblChartofAccounts.AccountName ');
        end;
  end;
  Opendb(QrySelected);
end;

procedure TBasSelectionGUI.QrySelectedAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if screen.ActiveControl = grdSelected then
    Qrymain.locate(IDfield, QrySelected.fieldbyname(IDfield).asInteger, []);
end;

procedure TBasSelectionGUI.ListMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if MultiSelecting then exit;
  MultiSelecting:= true;
  try
    if fbformshown then
      if Accesslevel <> 1 then begin
        Accept := False;
        Exit;
      end;

    if selecting then begin
       SelectedIDs.AddIfNotInList(Qrymain.fieldByname(IDfield).asInteger);
    end else begin
      SelectedIDs.Remove(Qrymain.fieldByname(IDfield).asInteger);
    end;

    OpenSelectedlist;
    Application.ProcessMessages;
  Finally
      MultiSelecting := False;
  end;
end;

function TBasSelectionGUI.IDfield: String;
begin
  case BAS.ObjType of
      ftTax:result := 'TaxCodeID' ;
      ftAcc:result :='AccountId' ;
  end;

end;

procedure TBasSelectionGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeandNil(SelectedIds);
end;

procedure TBasSelectionGUI.ListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if MultiSelecting then exit;
  SelectedIDs.Clear;
  commonlib.SelectedIDs(List, Idfield, SelectedIDs ,true);
  SelectedIDs.add(0);//for the SQL when the list is blank
  OpenSelectedlist;
end;

initialization
  RegisterClassOnce(TBasSelectionGUI);
end.

