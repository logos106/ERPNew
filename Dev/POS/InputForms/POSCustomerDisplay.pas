unit POSCustomerDisplay;
{$I ERP.inc}

interface

uses
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, ExtCtrls, DNMPanel, Grids, Wwdbigrd, Wwdbgrid, DB, kbmMemTable, MyAccess,ERPdbComponents,
  StdCtrls, OleServer, MSPpt2000, OpPptXP, OpPower, tcTypes,
  frmBase, Menus, MPlayer, tcVideoUtils;

type
  TPOSCustomerDisplayGUI = class(TfrmBaseGUI)
    pnlTitle: TDNMPanel;
    pnlDetails: TDNMPanel;
    pnlTotals: TDNMPanel;
    memGrid: TkbmMemTable;
    DSGrid: TDataSource;
    memGridID: TAutoIncField;
    memGridPicture: TGraphicField;
    memGridDescription: TWideStringField;
    memGridTotalPriceInc: TCurrencyField;
    TitleLabel2: TLabel;
    TitleLabel1: TLabel;
    TotalsLabel: TLabel;
    grdDisplayItems: TwwDBGrid;
    memGridQty: TWideStringField;
    Label1: TLabel;
    TmrSaveScreen: TTimer;
    tmrMedia: TTimer;
    pnlMediaHost: TPanel;
    pnlDisplay: TPanel;
    Player: TMediaPlayer;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure memGridAfterPost(DataSet: TDataSet);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TmrSaveScreenTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrMediaTimer(Sender: TObject);
    procedure grdDisplayItemsCalcTitleAttributes(Sender: TObject;
      AFieldName: string; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
  private
    { Private declarations }
    fiTillID: integer;
    PowerPoint: TOpPowerPoint;
    Pres: TOpPresentation;
    IPres: OpPptXP.Presentation;
    CloseMode: boolean;
    SetPosition: boolean;
    ColumnsAdjusted: boolean;
    fVideoFiles: TWMVFileIterator;
    procedure SaveScreenPositionInformation(const X, Y: integer);
    procedure GetScreenPositionInformation(var X, Y: integer);
    procedure DeleteIniFile;
    function GetProductImage(const ProductID: integer): TMemoryStream;
    (*procedure CalcSubTotals;*)
    procedure AdjustGridColumns;
    function getVideoCount: integer;
  protected
    property VideoFiles : TWMVFileIterator read fVideoFiles write fVideoFiles;
  public
    { Public declarations }
    CustomerDiscount: double;
    procedure AddItemToDisplay(const ID:Integer; const ProductID: integer; const Qty: double; const Description: string;
      const TotalPriceInc: double; LineItem : pLineItemRec);
    procedure ClearDisplay;
    procedure DisplayOrderNo(const OrderNo: string);
    procedure KillSaveScreen;
    property TillID: integer read fiTillID;
    function PositionInitialised: boolean;
    Procedure RefreshTotal(const TotalAmount:double);
    procedure PlayVideo;
    procedure StopPlay;
    property VideoCount : integer read getVideoCount;
  end;

implementation

uses FastFuncs,IniFiles, CommonDbLib, CustomerDisplayObj, POSScreenGUI, CommonLib,
  tcConst, DNMLib,systemlib;

{$R *.dfm}

const
//  CustomerDisplayFile = 'POSDisplay.ini';moved to tcConst
  OrderNoTitle        = 'Your Order No.';
  OrderNoSalutation   = 'Thank You !';
  SetupMessage        = 'Move This Screen To The Customer Monitor and Dbl Click Here !';

procedure TPOSCustomerDisplayGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := CloseMode;
end;

procedure TPOSCustomerDisplayGUI.GetScreenPositionInformation(var X, Y: integer);
var
  RegIni: TMemIniFile;
begin
  RegIni := TMemIniFile.Create(SystemLib.ExeDir + csCustomerDisplayFile);
  try
    X := RegIni.ReadInteger('POS Customer Display', 'ScreenX', 0);
    Y := RegIni.ReadInteger('POS Customer Display', 'ScreenY', 0);
  finally
    FreeAndNil(RegIni);
  end;
end;

function TPOSCustomerDisplayGUI.getVideoCount: integer;
begin
  Result := VideoFiles.Count;
end;

procedure TPOSCustomerDisplayGUI.grdDisplayItemsCalcTitleAttributes(
  Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
     if sametext(AFieldName , memGridTotalPriceInc.fieldname) then ATitleAlignment  := taRightJustify
     else if sametext(AFieldName , memGridQty.fieldname) then ATitleAlignment  := taCenter;


end;

procedure TPOSCustomerDisplayGUI.SaveScreenPositionInformation(const X, Y: integer);
var
  RegIni: TMemIniFile;
begin
  RegIni := TMemIniFile.Create(SystemLib.ExeDir + csCustomerDisplayFile);
  try
    RegIni.WriteInteger('POS Customer Display', 'ScreenX', X);
    RegIni.WriteInteger('POS Customer Display', 'ScreenY', Y);
    RegIni.UpdateFile;
  finally
    FreeAndNil(RegIni);
  end;
end;

procedure TPOSCustomerDisplayGUI.StopPlay;
begin
  if not PositionInitialised then
    exit;
  Player.Stop;
  if VideoCount > 1 then
    Player.Close;
  pnlMediaHost.Visible := false;
end;

procedure TPOSCustomerDisplayGUI.tmrMediaTimer(Sender: TObject);
begin
  inherited;
  if not pnlMediaHost.Visible  then
    exit;
  if Player.Length <= Player.Position  then
    PlayVideo;
end;

procedure TPOSCustomerDisplayGUI.DeleteIniFile;
begin
  DeleteFile(SystemLib.ExeDir + csCustomerDisplayFile);
end;

procedure TPOSCustomerDisplayGUI.FormDestroy(Sender: TObject);
begin
  if not CloseMode then SaveScreenPositionInformation(Self.Top, Self.Left);
  if Assigned(PowerPoint) then begin
    PowerPoint.Server.Quit;
    Application.ProcessMessages;
    FreeAndNil(PowerPoint);
  end;
  FreeAndNil(fVideoFiles);
  inherited;
end;

procedure TPOSCustomerDisplayGUI.FormCreate(Sender: TObject);
var
  tmpTop, tmpLeft: integer;
begin
  inherited;
  ColumnsAdjusted:= false;
  CloseMode := false;
  SetPosition := false;
  GetScreenPositionInformation(tmpTop, tmpLeft);
  if (tmpTop = 0) and (tmpLeft = 0) then begin
    WindowState          := wsNormal;
    Self.Caption         := SetupMessage;
    grdDisplayItems.Visible := false;
    pnlDetails.Font.Size := 18;
    pnlDetails.Caption   := 'Exit POS to Save Customer Screen Position Information';
    SetPosition          := true;
    Exit;
  end;
  Self.Top := tmpTop;
  Self.Left := tmpLeft;
//  Self.WindowState := wsMaximized;
  Self.BorderStyle := bsNone;
  if FormStillOpen('TPosScreenForm') then begin
    TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).SetPOSScreenActive;
  end;
  // Video
  VideoFiles := TWMVFileIterator.Create(csPosVideFilesCustomer);
  pnlMediaHost.Visible := false;
end;

procedure TPOSCustomerDisplayGUI.AddItemToDisplay(const ID:Integer; const ProductID: integer; const Qty: double;
  const Description: string; const TotalPriceInc: double; LineItem : pLineItemRec);
begin
  if SetPosition then Exit;
  TmrSaveScreen.Enabled := false;
  TotalsLabel.Visible := true;
  TitleLabel1.Visible := true;
  TitleLabel2.Visible := true;
  grdDisplayItems.Visible := true;
  pnlTitle.Caption := '';
  pnlDetails.Caption := '';
  pnlTotals.Caption := '';
  memGrid.DisableControls;
  if not memGrid.Locate('ID' , ID , []) then
  memGrid.Append else memGrid.Edit;
  memGrid.FieldByName('Qty').AsString := ' x ' + FloatToStrF(Qty, ffGeneral, 15, 2) + '  ';
  memGrid.FieldByName('Description').AsString := Description;
  memGrid.FieldByName('TotalPriceInc').AsFloat := TotalPriceInc;
  TBlobField(memGrid.FieldByName('Picture')).LoadFromStream(GetProductImage(ProductID));

  {if LineItem^.PCCTransHandle > 0 then begin //if transaction from PCC then add info about dispenser and grade
    memGrid.FieldByName('Description').AsString := memGrid.FieldByName('Description').AsString +
     ' ' + LineItem^.PCCGradeDesc + ', Dispenser : ' + IntToStr(LineItem^.PCCDispenser) ;
    memGrid.FieldByName('Qty').AsString := TrimRight(memGrid.FieldByName('Qty').AsString) + 'L'; // litres
  end;}


  memGrid.Post;
(*  if not memGrid.FieldByName('Picture').IsNull then
    grdDisplayItems.RowHeightPercent:= 400;*)
  memGrid.Last;
  memGrid.EnableControls;
//  grdDisplayItems.SizeLastColumn;
  grdDisplayItems.UnselectRecord;
  grdDisplayItems.SetActiveField('ID');
  grdDisplayItems.SetActiveRow(0);
  if FormStillOpen('TPosScreenForm') then begin
    TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).SetPOSScreenActive;
  end;
  if not ColumnsAdjusted then begin
    ColumnsAdjusted:= true;
    AdjustGridColumns;
  end;
end;

function TPOSCustomerDisplayGUI.GetProductImage(const ProductID: integer): TMemoryStream;
var
  qry: TERPQuery;
begin
  Result := TMemoryStream.Create;
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT PARTID,PartPic FROM tblpartspics WHERE Ifnull(IsDefault,"F") = "T" AND PARTID = ' + IntToStr(ProductID) + ';');
      Open;
      if not IsEmpty then begin
        TBlobField(FieldByName('PartPic')).SaveToStream(Result);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPOSCustomerDisplayGUI.ClearDisplay;
begin
  if SetPosition then Exit;
  TmrSaveScreen.Enabled := false;
  TotalsLabel.Visible := true;
  TitleLabel1.Visible := true;
  TitleLabel2.Visible := true;
  grdDisplayItems.Visible := true;
  pnlTitle.Caption := '';
  pnlDetails.Caption := '';
  pnlTotals.Caption := '';
  KillSaveScreen;
  memGrid.DisableControls;
  memGrid.Close;
  memGrid.EmptyTable;
  grdDisplayItems.RowHeightPercent:= 100;
  memGrid.Open;
//  grdDisplayItems.SizeLastColumn;
  //CalcSubTotals;
  memGrid.EnableControls;  
  Application.ProcessMessages;
  TmrSaveScreen.Enabled := false;
  {$IFNDEF DevMode}
  TmrSaveScreen.Interval := CustomerDisplaySettings.PPIdleWait * 60000;
  {$ELSE}
  TmrSaveScreen.Interval := CustomerDisplaySettings.PPIdleWait * 1000;
  {$ENDIF}
  TmrSaveScreen.Enabled := CustomerDisplaySettings.EnablePPScreenSaver;
  if FormStillOpen('TPosScreenForm') then begin
    TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).SetPOSScreenActive;
  end;
end;

procedure TPOSCustomerDisplayGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel1.Caption := CommonDbLib.GetCompanyName;
  TitleLabel2.Caption := CommonDbLib.GetCompanyName;
  pnlMediaHost.Visible := false;
  if FormStillOpen('TPosScreenForm') then begin
    TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).SetPOSScreenActive;
  end;
end;

procedure TPOSCustomerDisplayGUI.AdjustGridColumns;
var
  x: integer;
  totColWidth: integer;
  dif: integer;
begin
  dif:= 0;
  totColWidth:= 0;
  for x:= 0 to grdDisplayItems.GetColCount -1 do
    totColWidth:= totColWidth + grdDisplayItems.ColWidths[x];
  if totColWidth <> grdDisplayItems.Parent.ClientWidth - 15  then begin
    dif:= grdDisplayItems.Parent.ClientWidth - 15 - totColWidth;
  end;
  if dif <> 0 then begin
    for x:= 0 to grdDisplayItems.GetColCount -1 do
      grdDisplayItems.ColWidths[x]:=
        grdDisplayItems.ColWidths[x] + Trunc((grdDisplayItems.ColWidths[x] / totColWidth)  * dif);
  end;
  grdDisplayItems.SizeLastColumn;
end;

(*procedure TPOSCustomerDisplayGUI.CalcSubTotals;
var
  TotalAmount: double;
  bm: TBookmark;
  lbl: string;
begin
  TotalAmount := 0.00;
  bm := memGrid.GetBookmark;
  memGrid.DisableControls;
  Try
    with memGrid do begin
      First;
      while not Eof do begin
        TotalAmount := TotalAmount + memGridTotalPriceInc.AsCurrency;
        Next;
      end;
    end;
  Finally
    memGrid.GotoBookmark(bm);
    memGrid.FreeBookmark(bm);
    memGrid.EnableControls;
  end;
  lbl:= 'Sub Total';
  if (CustomerDiscount <> 0) and (TotalAmount <> 0) then begin
    lbl:= lbl + ' (Disc '+ FloatToStrF(-CustomerDiscount, ffCurrency, 15, CurrencyRoundPlaces) + ')';
    TotalAmount:= TotalAmount - CustomerDiscount;
  end;

//  TotalsLabel.Caption := 'Sub Total : ' + FloatToStrF(TotalAmount, ffCurrency, 15, CurrencyRoundPlaces);
  TotalsLabel.Caption := lbl + ' : ' + FloatToStrF(TotalAmount, ffCurrency, 15, CurrencyRoundPlaces);
  if FormStillOpen('TPosScreenForm') then begin
    TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).SetPOSScreenActive;
  end;
end;*)

procedure TPOSCustomerDisplayGUI.memGridAfterPost(DataSet: TDataSet);
begin
  //CalcSubTotals;
end;

procedure TPOSCustomerDisplayGUI.PlayVideo;
var
  lRatio : double;
begin
  if not PositionInitialised then
   exit;
  tmrMedia.Enabled := false;
  try
    if not pnlMediaHost.visible then
    begin
      pnlMediaHost.Parent := self;
//      pnlMediaHost.Align := alClient;
      // Do not know why, but it tryes to align to the grdDisplayItem
      if pnlMediaHost.ClientRect.Bottom <> pnlMediaHost.Parent.ClientRect.Bottom then
      begin
//        pnlMediaHost.ClientRect.Bottom := pnlMediaHost.Parent.ClientRect.Bottom;
        pnlMediaHost.Height := pnlMediaHost.Parent.ClientRect.Bottom - pnlMediaHost.Parent.ClientRect.top;
        pnlMediaHost.Top := pnlMediaHost.Parent.ClientRect.top;
        pnlMediaHost.Left := pnlMediaHost.Parent.ClientRect.Left;
        pnlMediaHost.Width := pnlMediaHost.Parent.ClientRect.Right - pnlMediaHost.Parent.ClientRect.Left;
      end;
//      pnlDisplay.Align := alClient;
      if pnlDisplay.ClientRect.Bottom <> pnlMediaHost.ClientRect.Bottom then
      begin
//        pnlMediaHost.ClientRect.Bottom := pnlMediaHost.ClientRect.Bottom;
        pnlDisplay.Height := pnlMediaHost.ClientRect.Bottom - pnlMediaHost.ClientRect.top;
        pnlDisplay.Top := pnlMediaHost.ClientRect.top;
        pnlDisplay.Left := pnlMediaHost.ClientRect.Left;
        pnlDisplay.Width := pnlMediaHost.ClientRect.Right - pnlMediaHost.ClientRect.Left;
      end;
      pnlMediaHost.Visible := true;
    end;

    if VideoFiles.Count = 1 then
    begin
      if Player.FileName <> '' then
      begin
        if csUseRatio then
        begin // Pnl display loses top position somehow
          lRatio := Player.DisplayRect.Bottom / Player.DisplayRect.Right;
          pnlDisplay.Left := 0;
          pnlDisplay.Width := pnlMediaHost.Width;
          pnlDisplay.Height := system.Round(pnlMediaHost.Width * lRatio);
          pnlDisplay.Top := (pnlMediaHost.Height - pnlDisplay.Height) div 2;
        end;
        Player.Rewind;
        Player.Play;
        exit;
      end;
    end;
    if Player.FileName <> '' then
      Player.Close;
    Player.FileName := VideoFiles.Next;
    Player.Shareable := true;
    Player.Open;
    if csUseRatio then
    begin
      lRatio := Player.DisplayRect.Bottom / Player.DisplayRect.Right;
      // DisplayRect is to be changed after the call to Open, since Open sets it to the video frame sizes
      pnlDisplay.Left := 0;
      pnlDisplay.Width := pnlMediaHost.Width;
      pnlDisplay.Height := system.Round(pnlMediaHost.Width * lRatio);
      pnlDisplay.Top := (pnlMediaHost.Height - pnlDisplay.Height) div 2;
    end
    else
      pnlDisplay.Align := alClient;

    Player.DisplayRect := pnlDisplay.ClientRect;
    Player.Play;
  finally
    tmrMedia.Enabled := true;
  end;
end;

function TPOSCustomerDisplayGUI.PositionInitialised: boolean;
var
  tmpTop, tmpLeft: integer;
begin
  GetScreenPositionInformation(tmpTop, tmpLeft);
  result:= not ((tmpTop = 0) and (tmpLeft = 0));
end;

procedure TPOSCustomerDisplayGUI.RefreshTotal(const TotalAmount: double);
var
  s:String;
begin
  s:= 'Sub Total';
  if (CustomerDiscount <> 0) and (TotalAmount <> 0) then begin
    s:= s + ' (Disc '+ FloatToStrF(-CustomerDiscount, ffCurrency, 15, CurrencyRoundPlaces) + ')';
  end;

//  TotalsLabel.Caption := 'Sub Total : ' + FloatToStrF(TotalAmount, ffCurrency, 15, CurrencyRoundPlaces);
  TotalsLabel.Caption := s + ' : ' + FloatToStrF(TotalAmount, ffCurrency, 15, CurrencyRoundPlaces);
  if FormStillOpen('TPosScreenForm') then begin
    TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).SetPOSScreenActive;
  end;
end;

procedure TPOSCustomerDisplayGUI.DisplayOrderNo(const OrderNo: string);
begin
  ClearDisplay;
  TotalsLabel.Visible := false;
  TitleLabel1.Visible := false;
  TitleLabel2.Visible := false;
  grdDisplayItems.Visible := false;
  pnlTitle.Caption := OrderNoTitle;
  pnlDetails.Caption := OrderNo;
  pnlTotals.Caption := OrderNoSalutation;

  pnlTitle.Paint;
  pnlDetails.Paint;
  pnlTotals.Paint;

  Application.ProcessMessages;
  TmrSaveScreen.Enabled := false;
  {$IFNDEF DevMode}
  TmrSaveScreen.Interval := CustomerDisplaySettings.PPIdleWait * 60000;
  {$ELSE}
  TmrSaveScreen.Interval := CustomerDisplaySettings.PPIdleWait * 1000;
  {$ENDIF}
  TmrSaveScreen.Enabled := CustomerDisplaySettings.EnablePPScreenSaver;
end;

procedure TPOSCustomerDisplayGUI.Label1MouseEnter(Sender: TObject);
begin
  CloseMode := true;
  Self.KeyPreview := true;
end;

procedure TPOSCustomerDisplayGUI.Label1MouseLeave(Sender: TObject);
begin
  CloseMode := false;
  Self.KeyPreview := false;
end;

procedure TPOSCustomerDisplayGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (key = VK_ESCAPE) and CloseMode then begin
    Self.Close;
    DeleteIniFile;
    TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).CustomerDisplay := nil;
  end;
end;

procedure TPOSCustomerDisplayGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPOSCustomerDisplayGUI.KillSaveScreen;
begin
  Self.FormStyle := fsStayOnTop;
  TmrSaveScreen.Enabled := false;
  Application.ProcessMessages;
  if Assigned(Pres) then begin
    FreeAndNil(Pres);
  end;
end;

procedure TPOSCustomerDisplayGUI.TmrSaveScreenTimer(Sender: TObject);
var
  i: integer;
begin
  TmrSaveScreen.Enabled := false;
  if not CustomerDisplaySettings.EnablePPScreenSaver then Exit;
  if not Assigned(PowerPoint) then begin
    PowerPoint := TOpPowerPoint.Create(Self);
  end;
  try
    Self.FormStyle := fsNormal;
    //Start PowerPoint
    Application.ProcessMessages;
    PowerPoint.ServerTop  := Self.Top + Self.Height;
    PowerPoint.ServerLeft := Self.Left + Self.Width;
    PowerPoint.Connected  := true;
    Application.ProcessMessages;
    Pres  := PowerPoint.OpenPresentation(CustomerDisplaySettings.PathFileName);
    IPres := Pres.AsPresentation;
    IPres.SlideShowSettings.AdvanceMode := ppSlideShowUseSlideTimings;
    //Set Options
    if (Pres.Slides.Count > 0) then for i := 0 to Pred(Pres.Slides.Count) do with Pres.Slides[i] do begin
          with TransitionEffect do begin
            EntryEffect := TOpPpEntryEffect(CustomerDisplaySettings.TransitionEffect);
            Speed := TOpPpTransitionSpeed(CustomerDisplaySettings.TransitionSpeed);
            AdvanceOnClick := false;
            AdvanceOnTime := true;
            if AdvanceOnTime then AdvanceTime := CustomerDisplaySettings.SlideCycle;
          end;
        end;
    Self.SendToBack;
    Pres.RunSlideShow;
    if FormStillOpen('TPosScreenForm') then begin
      TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).SetPOSScreenActive;
    end;
    Application.ProcessMessages;
  except
    KillSaveScreen;
  end;
end;
procedure TPOSCustomerDisplayGUI.FormActivate(Sender: TObject);
begin
  //CommonLib.MessageDlgXP_Vista('Customar Display Active', mtInformation, [mbOK], 0);
end;

initialization
    RegisterClassOnce(TPOSCustomerDisplayGUI);

end.
