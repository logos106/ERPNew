unit VATSelectionPopup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, Grids, Wwdbigrd,
  Wwdbgrid, DB, DBCtrls, MyAccess,ERPdbComponents, MemDS, DBAccess, VATObj, frmBase;

type
  TVATSelectionGUI = class(TfrmBaseGUI)
    ActionLbl: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    List: TwwDBGrid;
    DSMain: TDataSource;
    edtSearch: TEdit;
    Label9: TLabel;
    qryMain: TERPQuery;
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
  private
    fiAccesslevel: Integer;
    fbformshown :boolean;
    { Private declarations }
  public
    { Public declarations }
    VAT : TVATObj;
    Property Accesslevel :Integer read fiAccesslevel write fiAccesslevel;
  end;

implementation

uses StrUtils, CommonDbLib, CommonLib, ReturnObj;

{$R *.dfm}

procedure TVATSelectionGUI.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TVATSelectionGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeandNil(VAT);
  inherited;   
  Action := caFree;
end;

procedure TVATSelectionGUI.FormPaint(Sender: TObject);
begin
  inherited;
  PaintGradientColor(Self);
end;

procedure TVATSelectionGUI.FormShow(Sender: TObject);
var
  comp: TComponent;
  I,StatusAndToolbarHeight: integer;
begin
  inherited;
  try
    VAT.Initialize;
    if VAT.BMList.Count <> 0 then begin
      for I := 0 to VAT.BMList.Count-1 do begin
        qryMain.GotoBookmark(VAT.BMList.Items[i]);
        List.SelectRecord;
      end;
      qryMain.First;
    end;

    with VAT.qryMain do begin
      case VAT.ObjType of
        ftTax:
          begin
            Self.ActionLbl.caption := 'Select Tax Codes :';
            Self.caption := 'Select Tax Code/s';
          end;
        ftAcc:
          begin
            Self.ActionLbl.caption := 'Select Account/s';
            Self.caption := 'Select Account/s';
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
    btnCompleted.enabled := Accesslevel = 1;
    fbformshown:= True;
  end;
end;

procedure TVATSelectionGUI.ListMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if fbformshown then
    if Accesslevel <> 1 then
      Accept := False;
end;

procedure TVATSelectionGUI.btnCompletedClick(Sender: TObject);
begin
  VAT.AssignBookmarks(List.SelectedList);
  VAT.Calc;
  Self.Close;
end;

procedure TVATSelectionGUI.edtSearchChange(Sender: TObject);
var
  sFieldName: string;
begin
  if (edtSearch.Text <> '') and (qryMain.RecordCount > 2) then begin
    sFieldName   := qryMain.Fields[0].FieldName;
    qryMain.IndexFieldNames := '[' + sFieldName + '] ASC';
    DSMain.Dataset.Locate(sFieldName, edtSearch.Text, [loCaseInsensitive, loPartialKey]);
  end;
end;

procedure TVATSelectionGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;
  VAT := TVATObj.Create;
  VAT.qryMain := qryMain;
  fiAccesslevel:= 1;
  fbformshown:= False;
end;

initialization
  RegisterClassOnce(TVATSelectionGUI);
end.

