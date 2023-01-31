Unit ChartViewPrintOptions;

Interface 

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
     Dialogs, ExtCtrls, StdCtrls, ComCtrls,AdvOfficeStatusBar, Printers, Buttons, Types,
     TeeProcs, TeCanvas, TeePreviewPanel, TeeNavigator, TeEngine, Chart,
     DNMPanel, DNMSpeedButton, wwcheckbox, wwclearbuttongroup,
     wwradiogroup, AdvGroupBox, Mask, wwdbedit, Wwdotdot, Wwdbcomb, AdvTrackBar,
  frmBase;

Type
  TChartPrintOptions = class(TfrmBaseGUI)
    SubForm: TDNMPanel;
    TeePreviewPanel1: TTeePreviewPanel;
    Panel1: TDNMPanel;
    Label1: TLabel;
    Panel3: TDNMPanel;
    BSetupPrinter: TDNMSpeedButton;
    BPrint: TDNMSpeedButton;
    Panel2: TDNMPanel;
    PanelMargins: TDNMPanel;
    BReset: TDNMSpeedButton;
    Panel4: TDNMPanel;
    ShowMargins: TwwCheckBox;
    CBProp: TwwCheckBox;
    CheckBox1: TwwCheckBox;
    Label9: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Orientation: TwwRadioGroup;
    GBMargins: TAdvGroupBox;
    SETopMa: TEdit;
    SELeftMa: TEdit;
    SEBotMa: TEdit;
    SERightMa: TEdit;
    UDLeftMa: TUpDown;
    UDTopMa: TUpDown;
    UDRightMa: TUpDown;
    UDBotMa: TUpDown;
    ChangeDetailGroup: TAdvGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    CBPrinters: TwwDBComboBox;
    Resolution: TAdvTrackBar;
    Procedure FormShow(Sender: TObject);
    Procedure BSetupPrinterClick(Sender: TObject);
    Procedure CBPrintersChange(Sender: TObject);
    Procedure OrientationClick(Sender: TObject);
    Procedure SETopMaChange(Sender: TObject);
    Procedure SERightMaChange(Sender: TObject);
    Procedure SEBotMaChange(Sender: TObject);
    Procedure SELeftMaChange(Sender: TObject);
    Procedure ShowMarginsClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure BResetClick(Sender: TObject);
    Procedure BPrintClick(Sender: TObject);
    Procedure CBPropClick(Sender: TObject);
    Procedure TeePreviewPanel1ChangeMargins(Sender: TObject; DisableProportional: Boolean; Const NewMargins: TRect);
    Procedure ResolutionChange(Sender: TObject);
    Procedure FormDestroy(Sender: TObject);
    Procedure CheckBox1Click(Sender: TObject);
    Procedure Panel1Resize(Sender: TObject);
  private 
    ChangingMargins: Boolean;
    ChangingProp: Boolean;
    OldMargins: TRect;
    PageNavigator1: TCustomTeeNavigator;
    PageNavigatorClass: TTeePageNavigatorClass;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Procedure Navigator1ButtonClicked(Index: TTeeNavigateBtn);
    Procedure ResetMargins;
    Procedure CheckOrientation;
    Procedure ChangeMargin(Const UpDown: TUpDown; Var APos: Integer; OtherSide: Integer);
  End;


Implementation 

Uses CommonLib, ListChartView;

{$R *.DFM}

Var 
  TeeChangePaperOrientation: Boolean = true;

Procedure TChartPrintOptions.ResetMargins;
Begin 
  With TeePreviewPanel1 Do If Assigned(Panel) Then Begin 
      If Panel.PrintProportional And (Printer.Printers.Count > 0) Then Begin 
        OldMargins := Panel.CalcProportionalMargins;
        Panel.PrintMargins := OldMargins;
      End;
      TeePreviewPanel1ChangeMargins(Self, false, Panel.PrintMargins);
      Invalidate;
    End;
End;

Procedure TChartPrintOptions.FormShow(Sender: TObject);
Var 
  tmpClass: TTeePageNavigatorClass;
Begin 
  inherited;
  tmpClass := PageNavigatorClass;
  If Assigned(tmpClass) Then Begin 
    PageNavigator1        := tmpClass.Create(Self);
    PageNavigator1.Parent := Panel2;
    PageNavigator1.Align  := alBottom;
    PageNavigator1.HelpContext := 1488;
    PageNavigator1.OnButtonClicked := Navigator1ButtonClicked;
  End;
  If Tag <> 0 Then TeePreviewPanel1.Panel := TCustomTeePanel(TObject(Tag));
  CBPrinters.Items := Printer.Printers;
  If Printer.Printers.Count > 0 Then Begin 
    CBPrinters.ItemIndex := Printer.PrinterIndex;
    If TeeChangePaperOrientation Then Printer.Orientation := poLandscape;
    CheckOrientation;
  End Else Begin 
    EnableControls(false, [BPrint, BSetupPrinter, Orientation]);
  End;
  With TeePreviewPanel1 Do If Assigned(Panel) Then Begin 
      CBProp.Checked := Panel.PrintProportional;
      Resolution.Position := Panel.PrintResolution + 100;
      OldMargins := Panel.PrintMargins;
      ResetMargins;
      If Assigned(PageNavigator1) Then PageNavigator1.Panel := Panel;
    End Else Begin 
    CBProp.Enabled     := false;
    Resolution.Enabled := false;
    GBMargins.Enabled  := false;
    BPrint.Enabled     := false;
  End;
  CheckBox1.Checked := TeePreviewPanel1.AsBitmap;
  TeeTranslateControl(Self);
  SubForm.Color := TListChartView(Self.Owner).TabColor;
  GBMargins.Color := SubForm.Color;
  ChangeDetailGroup.Color := SubForm.Color;
End;

Procedure TChartPrintOptions.BSetupPrinterClick(Sender: TObject);
Begin 
  PrinterSetupDialog1.Execute;
  CBPrinters.Items := Printer.Printers;
  CBPrinters.ItemIndex := Printer.PrinterIndex;
  CheckOrientation;
  Invalidate;
End;

Procedure TChartPrintOptions.CBPrintersChange(Sender: TObject);
Begin 
  Printer.PrinterIndex := CBPrinters.ItemIndex;
  CheckOrientation;
  OrientationClick(Self);
End;

Procedure TChartPrintOptions.OrientationClick(Sender: TObject);
Begin 
  Printer.Orientation := TPrinterOrientation(Orientation.ItemIndex);
  ResetMargins;
  TeePreviewPanel1.Invalidate;
End;

Procedure TChartPrintOptions.ChangeMargin(Const UpDown: TUpDown; Var APos: Integer; OtherSide: Integer);
Var 
  tmpR: TRect;
Begin 
  If UpDown.Position + OtherSide < 100 Then Begin 
    APos := UpDown.Position;
    If Not ChangingMargins Then With TeePreviewPanel1 Do Begin 
        Invalidate;
        tmpR := Panel.PrintMargins;
        BReset.Enabled := Not EqualRect(tmpR, OldMargins);
        CBProp.Checked := false;
      End;
  End Else UpDown.Position := APos;
End;

Procedure TChartPrintOptions.SETopMaChange(Sender: TObject);
var
  rect: TRect;
Begin
  rect:= TeePreviewPanel1.Panel.PrintMargins;
  ChangeMargin(UDTopMa, rect.Top, rect.Bottom);
  TeePreviewPanel1.Panel.PrintMargins:= rect;
End;

Procedure TChartPrintOptions.SERightMaChange(Sender: TObject);
var
  rect: TRect;
Begin
  rect:= TeePreviewPanel1.Panel.PrintMargins;
  ChangeMargin(UDRightMa, rect.Right, rect.Left);
  TeePreviewPanel1.Panel.PrintMargins:= rect;
End;

Procedure TChartPrintOptions.SEBotMaChange(Sender: TObject);
var
  rect: TRect;
Begin
  rect:= TeePreviewPanel1.Panel.PrintMargins;
  ChangeMargin(UDBotMa, rect.Bottom, rect.Top);
  TeePreviewPanel1.Panel.PrintMargins:= rect;
End;

Procedure TChartPrintOptions.SELeftMaChange(Sender: TObject);
var
  rect: TRect;
Begin
  rect:= TeePreviewPanel1.Panel.PrintMargins;
  ChangeMargin(UDLeftMa, rect.Left, rect.Right);
  TeePreviewPanel1.Panel.PrintMargins:= rect;
End;

Procedure TChartPrintOptions.ShowMarginsClick(Sender: TObject);
Begin 
  TeePreviewPanel1.Margins.Visible := ShowMargins.Checked;
End;

Procedure TChartPrintOptions.FormCreate(Sender: TObject);
Begin 
  inherited;
  ChangingMargins := true;
  ChangingProp := false;
  PrinterSetupDialog1 := TPrinterSetupDialog.Create(Self);
End;

Procedure TChartPrintOptions.BResetClick(Sender: TObject);
Begin 
  With TeePreviewPanel1 Do Begin 
    Panel.PrintMargins := OldMargins;
    TeePreviewPanel1ChangeMargins(Self, false, Panel.PrintMargins);
    Invalidate;
  End;
  BReset.Enabled := false;
End;

Procedure TChartPrintOptions.CheckOrientation;
Begin 
  try
    Orientation.ItemIndex := Ord(Printer.Orientation);
  except
    on e :exception do begin
      CommonLib.MessageDlgXP_Vista(e.Message,mtInformation,[mbOk],0);
    end;
  end;
End;

Procedure TChartPrintOptions.BPrintClick(Sender: TObject);
Begin
  Processingcursor(True);
  Try
    If Assigned(PageNavigator1) And (PageNavigator1.PageCount > 1) Then PageNavigator1.Print
    Else TeePreviewPanel1.Print;
  Finally
    Processingcursor(False);
    Self.Invalidate;
  End;
End;

Procedure TChartPrintOptions.CBPropClick(Sender: TObject);
Begin 
  If Not ChangingProp Then Begin 
    TeePreviewPanel1.Panel.PrintProportional := CBProp.Checked;
    ResetMargins;
  End;
End;

Procedure TChartPrintOptions.TeePreviewPanel1ChangeMargins(Sender: TObject; DisableProportional: Boolean; Const NewMargins: TRect);
Begin 
  ChangingMargins := true;
  Try 
    UDLeftMa.Position  := NewMargins.Left;
    UDRightMa.Position := NewMargins.Right;
    UDTopMa.Position   := NewMargins.Top;
    UDBotMa.Position   := NewMargins.Bottom;
    If DisableProportional Then Begin 
      TeePreviewPanel1.Panel.PrintProportional := false;
      ChangingProp := true;
      CBProp.Checked := false;
      ChangingProp := false;
    End;
  Finally 
    ChangingMargins := false;
  End;
End;

Procedure TChartPrintOptions.Navigator1ButtonClicked(Index: TTeeNavigateBtn);
Begin 
  TeePreviewPanel1.Invalidate;
End;

Procedure TChartPrintOptions.ResolutionChange(Sender: TObject);
Begin 
  With TeePreviewPanel1 Do Begin 
    Panel.PrintResolution := Resolution.Position - 100;
    Invalidate;
  End;
End;

Procedure TChartPrintOptions.FormDestroy(Sender: TObject);
Begin 
  FreeAndNil(PrinterSetupDialog1);
  FreeAndNil(PageNavigator1);
End;

Procedure TChartPrintOptions.CheckBox1Click(Sender: TObject);
Begin 
  TeePreviewPanel1.AsBitmap := CheckBox1.Checked;
End;

Procedure TChartPrintOptions.Panel1Resize(Sender: TObject);
Begin 
  CBPrinters.Width := Panel3.Left - CBPrinters.Left;
End;

Initialization 
  RegisterClassOnce(TChartPrintOptions);
End.
