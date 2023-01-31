unit FrmProductCommissionOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, ExtCtrls, DNMPanel, DNMSpeedButton,
  rtflabel, ComCtrls, BaseFormForm, ImgList, Menus, AdvMenus, DataState,
  DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, MemDS,
  ProgressDialog;

type
  TFmProductCommissionOptions = class(TBaseInputGUI)
    Mainpage: TPageControl;
    tabEmployee: TTabSheet;
    tabProduct: TTabSheet;
    DNMPanel1: TDNMPanel;
    employeenote: TRTFLabel;
    DNMPanel2: TDNMPanel;
    GeneralNote: TRTFLabel;
    DNMPanel3: TDNMPanel;
    Productnote: TRTFLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControlDrawTab(Control: TCustomTabControl; TabIndex: integer; const Rect: TRect; Active: boolean);
    procedure MainpageChange(Sender: TObject);
    procedure TabSheetShow(Sender: TObject);
    procedure TabControlExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    fsEmployeename: String;
    procedure setEmployeename(const Value: String);
    { Private declarations }
  public
    Property Employeename :String read fsEmployeename Write setEmployeename; 
  end;

implementation

uses CommonLib, FastFuncs, CommonDbLib;

{$R *.dfm}

procedure TFmProductCommissionOptions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TFmProductCommissionOptions.FormShow(Sender: TObject);
begin
  inherited;
  mainpage.ActivePageIndex :=0;
  Left := 0;
  top := 0;
end;

procedure TFmProductCommissionOptions.setEmployeename(const Value: String);
begin
  fsEmployeename := Value;
  GeneralNote.RichText:= StringReplace(GeneralNote.RichText , '<employeeName>' , value ,[rfReplaceAll, rfIgnoreCase]);
  Productnote.RichText:= StringReplace(Productnote.RichText , '<employeeName>' , value ,[rfReplaceAll, rfIgnoreCase]);
  employeenote.RichText:= StringReplace(employeenote.RichText , '<employeeName>' , value, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TFmProductCommissionOptions.FormCreate(Sender: TObject);
Function Employeeform :TForm; begin
    if FormStillOpen('TfrmEmployee') then result :=TForm(FindExistingComponent('TfrmEmployee'))
    else result := self; 
end;
begin
  fbTabPaintDisabled := false;
  PaintGradientColor(Employeeform);
  inherited;

end;


procedure TFmProductCommissionOptions.PageControlDrawTab(
  Control: TCustomTabControl; TabIndex: integer; const Rect: TRect;
  Active: boolean);
var
  TmpRect: TRect;
  Bitmap: TBitmap;

  Function FindPageforTabIndex( pagecontrol: TPagecontrol; tabindex: Integer ): TTabSheet;
  Var
    i: Integer;
  Begin
    Assert( Assigned( pagecontrol ));
    Assert( (tabindex >= 0) and (tabindex < pagecontrol.pagecount ));
    Result := nil;
    For i:= 0 To pagecontrol.pagecount-1 Do
      If pagecontrol.pages[i].tabVisible Then Begin
        Dec( tabindex );
        If tabindex < 0 Then Begin
          result := pagecontrol.pages[i];
          break;
        End;
      End;
  end;


begin
  Bitmap := TBitmap.Create;
  try
    TmpRect    := Rect;
    Bitmap.Width := 300;
    Bitmap.Height := 300;
    Bitmap.Canvas.Brush.Color := Self.Color;
    Bitmap.Canvas.FillRect(Classes.Rect(0, 0, 300, 300));

    Control.Canvas.Brush.Bitmap := Bitmap;
    TmpRect := Control.ClientRect;
    TmpRect.Left := ((TPageControl(Control).TabWidth * TPageControl(Control).PageCount) div TPageControl(Control).RowCount) + 4;
    TmpRect.Bottom := Rect.Bottom - 4;
    Control.Canvas.FillRect(TmpRect);
    TmpRect := Rect;
    TmpRect.Bottom := TmpRect.Bottom + 2;
    Control.Canvas.FillRect(TmpRect);
    TmpRect.Bottom := TmpRect.Bottom - 2;

    if Active then
        Control.Canvas.Font.Color := clNavy;

    Control.Canvas.Brush.Style := bsClear;

    DrawText(Control.Canvas.Handle, PChar(FindPageforTabIndex(TPageControl(Control),TabIndex).Caption), - 1, TmpRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

  finally
    FreeAndNil(Bitmap);
  end;

end;

procedure TFmProductCommissionOptions.MainpageChange(Sender: TObject);
begin
  inherited;
  PostMessage(Self.Handle, CM_FOCUSCHANGED,  0, 0);
  Application.ProcessMessages;
end;

procedure TFmProductCommissionOptions.TabSheetShow(Sender: TObject);
var
  TabSheetRect: TRect;
  PageControlRect: TRect;
  Bitmap: TBitmap;
  fCanvas: TControlCanvas;
begin
  Bitmap := TBitmap.Create;
  fCanvas := TControlCanvas.Create;
  try
    Bitmap.Width := 300;
    Bitmap.Height := 300;
    Bitmap.Canvas.Brush.Color := Self.Color;
    Bitmap.Canvas.FillRect(Rect(0, 0, 300, 300));
    TabSheetRect := TTabSheet(Sender).ClientRect;
    fCanvas.Control := TTabSheet(Sender);
    fCanvas.Brush.Bitmap := Bitmap;
    fCanvas.FillRect(TabSheetRect);
    fCanvas.Control := TTabSheet(Sender).PageControl;
    fCanvas.Brush.Bitmap := Bitmap;
    PageControlRect := fCanvas.Control.ClientRect;
    PageControlRect.Left := TTabSheet(Sender).Left - 2;
    PageControlRect.Top := TTabSheet(Sender).Top - 2;
    PageControlRect.Right := PageControlRect.Right - 2;
    PageControlRect.Bottom := PageControlRect.Bottom - 2;
    fCanvas.FillRect(PageControlRect);
  finally
    FreeAndNil(Bitmap);
    FreeAndNil(fCanvas);
  end;


end;

procedure TFmProductCommissionOptions.TabControlExit(Sender: TObject);
begin
  if TPageControl(TTabSheet(Sender).Parent).ActivePage = Sender then
      if screen.activecontrol =  TPageControl(TTabSheet(Sender).Parent) then  begin
          PostMessage(Self.Handle, CM_FOCUSCHANGED,  0, 0);
          Application.ProcessMessages;
      end;

end;

procedure TFmProductCommissionOptions.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_ESCAPE then Begin
    Key:= 0;
    Self.close;
  end;
end;

initialization
RegisterClassOnce(TFmProductCommissionOptions);

end.
