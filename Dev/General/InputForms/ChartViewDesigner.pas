unit ChartViewDesigner;

{$I ERP.inc}
interface

uses
  {$ifdef COMPILER_22_UP}
  Windows, Messages, Registry, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, ComCtrls,AdvOfficeStatusBar,
  ToolWin, ImgList, Menus, DNMPanel, AdvMenus, dmGUIStylers, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, frmBase,
  TeeInspector,TeeProcs, TeEngine, Chart, DBChart, Series,
  TeeEdiGene, TeeNavigator, TeeChartGrid, TeeLisB, TeePreviewPanel, TeeComma,
  TeeEdit, TeeGalleryPanel, TeeEdiSeri, TeCanvas, TeeOpenGL, TeeURL,
  TeeSelectorTool, TeeTools;
  {$else}
  Windows, Messages, Registry, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, ComCtrls,AdvOfficeStatusBar, ToolWin, ImgList, Menus,
  TeeProcs, TeEngine, Chart, DBChart, Series,
  TeeOpenGL, TeeURL, TeeEdiGene,
  TeeNavigator, TeeChartGrid, TeeLisB, TeePreviewPanel, TeeComma, TeeEdit,
  TeeGalleryPanel, TeeEdiSeri, TeCanvas, TeeSelectorTool, TeeTools, TeeInspector,
  TeeThemeEditor, TeeExtraLegendTool, TeeSurfaceTool, TeeDataTableEditor,
  TeeLighting, TeeLegendScrollbar, TeeDesignOptions,
  DNMPanel, AdvMenus,
  dmGUIStylers, Mask, wwdbedit, Wwdotdot, Wwdbcomb, frmBase;
  {$endif}

type 
  TEnableJustify = (ejNo, ejAll, ejNoCenter);
  TChartDesigner = class(TfrmBaseGUI)
    SubForm: TDNMPanel;
    Splitter1: TSplitter;
    Panel1: TDNMPanel;
    PageControlSeries: TPageControl;
    PanelSeries: TTabSheet;
    ChartListBox1: TChartListBox;
    ToolBar1: TToolBar;
    SBAdd: TToolButton;
    SBDelete: TToolButton;
    ToolButton3: TToolButton;
    TBMoveUp: TToolButton;
    TBMoveDown: TToolButton;
    ToolButton6: TToolButton;
    SBEdit: TToolButton;
    ToolButton2: TToolButton;
    SBFont: TToolButton;
    PanelInspector: TDNMPanel;
    Panel2: TDNMPanel;
    Inspector: TTeeInspector;
    ControlBar1: TControlBar;
    PanelFont: TDNMPanel;
    FontBold: TSpeedButton;
    FontItalic: TSpeedButton;
    FontUnderline: TSpeedButton;
    FontStrike: TSpeedButton;
    FontLeftAlign: TSpeedButton;
    FontCenterAlign: TSpeedButton;
    FontRightAlign: TSpeedButton;
    ShapeFontColor: TShape;
    SBOutline: TSpeedButton;
    EditFontInter: TEdit;
    UDFontInter: TUpDown;
    PanelPage: TDNMPanel;
    ChartPageNavigator1: TChartPageNavigator;
    PanelTools: TDNMPanel;
    Annotation: TSpeedButton;
    SBZoom: TSpeedButton;
    SBScroll: TSpeedButton;
    SBDrawLine: TSpeedButton;
    SBHints: TSpeedButton;
    TeeCommander1: TTeeCommander;
    ToolBarSeries: TToolBar;
    ColorEach: TToolButton;
    ShowAtLegend: TToolButton;
    ShowMarks: TToolButton;
    Panel3: TDNMPanel;
    ShapeBorderColor: TShape;
    BorderWidth: TScrollBar;
    ImageListSeries: TImageList;
    ImageList3: TImageList;
    Panel4: TDNMPanel;
    Splitter4: TSplitter;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    DBChart1: TDBChart;
    ChartGalleryPanel1: TChartGalleryPanel;
    LocalMenu: TAdvPopupMenu;
    AddItem: TMenuItem;
    Change1: TMenuItem;
    DeleteItem: TMenuItem;
    CloneItem: TMenuItem;
    Title1: TMenuItem;
    MenuItem1: TMenuItem;
    SelectAllItem: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    PopupMenuToolbar: TAdvPopupMenu;
    AligntoTop1: TMenuItem;
    AligntoBottom1: TMenuItem;
    PopupMenuGallery: TAdvPopupMenu;
    Borders1: TMenuItem;
    Rightside1: TMenuItem;
    ShowHints1: TMenuItem;
    Small1: TMenuItem;
    Smooth1: TMenuItem;
    View3D1: TMenuItem;
    PopupLegend: TAdvPopupMenu;
    Visible1: TMenuItem;
    Checkboxes1: TMenuItem;
    Dividinglines1: TMenuItem;
    Inverted1: TMenuItem;
    UseSeriesColor1: TMenuItem;
    N10: TMenuItem;
    Position1: TMenuItem;
    Right1: TMenuItem;
    Left1: TMenuItem;
    Top1: TMenuItem;
    Bottom1: TMenuItem;
    Style1: TMenuItem;
    Seriesnames1: TMenuItem;
    Values1: TMenuItem;
    Lastvalues1: TMenuItem;
    Symbols1: TMenuItem;
    Left2: TMenuItem;
    Right2: TMenuItem;
    N12: TMenuItem;
    Continous1: TMenuItem;
    N11: TMenuItem;
    LegendBorder: TMenuItem;
    Color4: TMenuItem;
    LegendFont: TMenuItem;
    LegendGradient: TMenuItem;
    LegendTransparent: TMenuItem;
    PopupMenuTitle: TAdvPopupMenu;
    Text1: TMenuItem;
    Alignment1: TMenuItem;
    TitleLeft: TMenuItem;
    TitleCenter: TMenuItem;
    TitleRight: TMenuItem;
    N14: TMenuItem;
    TitleAutosize: TMenuItem;
    CustomPosition1: TMenuItem;
    N13: TMenuItem;
    TitleBorder: TMenuItem;
    Color1: TMenuItem;
    TitleFont: TMenuItem;
    TitleGradient: TMenuItem;
    TitleShadow: TMenuItem;
    TitleTransparent: TMenuItem;
    TitleVisible: TMenuItem;
    PopupMenuPanel: TAdvPopupMenu;
    Edit2: TMenuItem;
    N22: TMenuItem;
    PanelBackimage: TMenuItem;
    Bevel1: TMenuItem;
    Lower1: TMenuItem;
    Raise1: TMenuItem;
    None1: TMenuItem;
    PanelBorder: TMenuItem;
    PanelColor: TMenuItem;
    GrayScale1: TMenuItem;
    Colors1: TMenuItem;
    GrayScale2: TMenuItem;
    GrayScaleVisual1: TMenuItem;
    InvertedGrayScale1: TMenuItem;
    Monochrome1: TMenuItem;
    Frame1: TMenuItem;
    PanelGradient: TMenuItem;
    PanelView3D: TMenuItem;
    N15: TMenuItem;
    AutoSize1: TMenuItem;
    PopupMenuAnn: TAdvPopupMenu;
    EditAnnotation: TMenuItem;
    Delete1: TMenuItem;
    N17: TMenuItem;
    Position2: TMenuItem;
    LeftTop1: TMenuItem;
    LeftBottom1: TMenuItem;
    RightTop1: TMenuItem;
    RightBottom1: TMenuItem;
    N18: TMenuItem;
    Custom1: TMenuItem;
    N19: TMenuItem;
    AnnBorder: TMenuItem;
    AnnColor: TMenuItem;
    AnnoFont: TMenuItem;
    AnnGradient: TMenuItem;
    Shadow1: TMenuItem;
    Transparent1: TMenuItem;
    PopupMenuMarks: TAdvPopupMenu;
    Edit4: TMenuItem;
    N20: TMenuItem;
    Arrow1: TMenuItem;
    MarksBorder: TMenuItem;
    Color3: TMenuItem;
    MarksFont: TMenuItem;
    MarksGradient: TMenuItem;
    MarksStyle: TMenuItem;
    Value1: TMenuItem;
    Percent1: TMenuItem;
    Label1: TMenuItem;
    LabelPercent1: TMenuItem;
    LabelValue1: TMenuItem;
    Legend2: TMenuItem;
    PercentTotal1: TMenuItem;
    LabelPercentTotal1: TMenuItem;
    XValue1: TMenuItem;
    XY1: TMenuItem;
    Symbol1: TMenuItem;
    Transparent2: TMenuItem;
    Visible3: TMenuItem;
    PopupMenuAxis: TAdvPopupMenu;
    Edit5: TMenuItem;
    N21: TMenuItem;
    Axisline1: TMenuItem;
    AxisFont: TMenuItem;
    LabelsFormat1: TMenuItem;
    Grid1: TMenuItem;
    Inverted2: TMenuItem;
    Labels1: TMenuItem;
    AxisMinorGrid: TMenuItem;
    Ticks1: TMenuItem;
    AxisVisible: TMenuItem;
    PopupMenuSeries: TAdvPopupMenu;
    Edit6: TMenuItem;
    N25: TMenuItem;
    Color5: TMenuItem;
    Coloreach1: TMenuItem;
    ShowatLegend1: TMenuItem;
    ShowMarks1: TMenuItem;
    Title2: TMenuItem;
    Visible2: TMenuItem;
    SeriesPopupSep: TMenuItem;
    PopupLine: TAdvPopupMenu;
    PopupLineBorder: TMenuItem;
    PopupLineOutline: TMenuItem;
    PopupLinePattern: TMenuItem;
    PopupLineStairs: TMenuItem;
    PopupLineInverted: TMenuItem;
    PopupMenuWall: TAdvPopupMenu;
    Edit3: TMenuItem;
    N26: TMenuItem;
    WallBorder: TMenuItem;
    WallColor: TMenuItem;
    WallDark3D: TMenuItem;
    WallGradient: TMenuItem;
    WallTransparent: TMenuItem;
    WallVisible: TMenuItem;
    PopupBar: TAdvPopupMenu;
    BarBorder: TMenuItem;
    BarGradient: TMenuItem;
    BarPattern: TMenuItem;
    BarSideMargins: TMenuItem;
    BarStyleItem: TMenuItem;
    BarRectangle: TMenuItem;
    BarPyramid: TMenuItem;
    BarInvertPyramid: TMenuItem;
    BarCyllinder: TMenuItem;
    BarEllipse: TMenuItem;
    BarArrow: TMenuItem;
    BarGradientStyle: TMenuItem;
    BarCone: TMenuItem;
    BarUseOrigin: TMenuItem;
    BarWidthItem: TMenuItem;
    PopupPie: TAdvPopupMenu;
    PieBorder: TMenuItem;
    PieCircled: TMenuItem;
    PieDark3D: TMenuItem;
    PiePatterns: TMenuItem;
    PieRotation: TMenuItem;
    PopupFastLine: TAdvPopupMenu;
    FastLineBorder: TMenuItem;
    PopupPoint: TAdvPopupMenu;
    PointBorder: TMenuItem;
    PointDark: TMenuItem;
    PointDraw3D: TMenuItem;
    PointHeight: TMenuItem;
    PointStyleItem: TMenuItem;
    Rectangle1: TMenuItem;
    Circle1: TMenuItem;
    Triangle1: TMenuItem;
    DownTriangle1: TMenuItem;
    Cross1: TMenuItem;
    DiagonalCross1: TMenuItem;
    Star1: TMenuItem;
    Diamond1: TMenuItem;
    Smalldot1: TMenuItem;
    PointWidth: TMenuItem;
    PopupTabs: TAdvPopupMenu;
    LeftTab: TMenuItem;
    RightTab: TMenuItem;
    TopTab: TMenuItem;
    BottomTab: TMenuItem;
    PopupToolSeries: TAdvPopupMenu;
    TopToolBar: TMenuItem;
    Bottom2: TMenuItem;
    PopupMenuGrid: TAdvPopupMenu;
    Top2: TMenuItem;
    N28: TMenuItem;
    AlignGrid1: TMenuItem;
    Top3: TMenuItem;
    Bottom3: TMenuItem;
    Left3: TMenuItem;
    Right3: TMenuItem;
    ComboFonts: TwwDBComboBox;
    ComboFontSize: TwwDBComboBox;
    ComboPenStyle: TwwDBComboBox;
    ComboBoxParts: TwwDBComboBox;
    ChartEditor1: TChartEditor;
    SBSeriesData: TToolButton;
    lblNote: TLabel;
    procedure ChartProperties1Click(Sender: TObject);
    procedure ChartListBox1DblClickSeries(Sender: TChartListBox; Index: Integer);
    procedure ChartListBox1Click(Sender: TObject);
    procedure SBAddClick(Sender: TObject);
    procedure SBDeleteClick(Sender: TObject);
    procedure SBEditClick(Sender: TObject);
    procedure TBMoveUpClick(Sender: TObject);
    procedure TBMoveDownClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Title1Click(Sender: TObject);
    procedure Change1Click(Sender: TObject);
    procedure CloneItemClick(Sender: TObject);
    procedure LocalMenuPopup(Sender: TObject);
    procedure SelectAllItemClick(Sender: TObject);
    procedure ChartTools1Click(Sender: TObject);
    procedure DBChart1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DBChart1DblClick(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure NewusingWizard1Click(Sender: TObject);
    procedure HideSerieslist1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure TeeCommander1EditedChart(Sender: TTeeCommander; AChart: TCustomChart);
    procedure ChartGalleryPanel1ChangeChart(Sender: TObject);
    procedure SBOutlineClick(Sender: TObject);
    procedure EditFontInterChange(Sender: TObject);
    procedure ComboFontSizeChange(Sender: TObject);
    procedure ComboFontsChange(Sender: TObject);
    procedure FontBoldClick(Sender: TObject);
    procedure ShapeFontColorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AligntoBottom1Click(Sender: TObject);
    procedure View3D1Click(Sender: TObject);
    procedure ComboBoxPartsChange(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure ShowMarksClick(Sender: TObject);
    procedure ColorEachClick(Sender: TObject);
    procedure Titles1Click(Sender: TObject);
    procedure ShowAtLegendClick(Sender: TObject);
    procedure AnnotationClick(Sender: TObject);
    procedure SBZoomClick(Sender: TObject);
    procedure SBScrollClick(Sender: TObject);
    procedure SBDrawLineClick(Sender: TObject);
    procedure UseSeriesColor1Click(Sender: TObject);
    procedure Inverted1Click(Sender: TObject);
    procedure PopupLegendPopup(Sender: TObject);
    procedure Checkboxes1Click(Sender: TObject);
    procedure Dividinglines1Click(Sender: TObject);
    procedure LegendGradientClick(Sender: TObject);
    procedure LegendTransparentClick(Sender: TObject);
    procedure Bottom1Click(Sender: TObject);
    procedure Right2Click(Sender: TObject);
    procedure Continous1Click(Sender: TObject);
    procedure Lastvalues1Click(Sender: TObject);
    procedure PopupMenuTitlePopup(Sender: TObject);
    procedure LegendBorderClick(Sender: TObject);
    procedure TitleBorderClick(Sender: TObject);
    procedure TitleVisibleClick(Sender: TObject);
    procedure TitleGradientClick(Sender: TObject);
    procedure TitleTransparentClick(Sender: TObject);
    procedure TitleShadowClick(Sender: TObject);
    procedure TitleAutosizeClick(Sender: TObject);
    procedure Color1Click(Sender: TObject);
    procedure TitleRightClick(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure PopupMenuPanelPopup(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure PanelColorClick(Sender: TObject);
    procedure PanelBackimageClick(Sender: TObject);
    procedure PanelGradientClick(Sender: TObject);
    procedure PanelBorderClick(Sender: TObject);
    procedure TeeChartHelp1Click(Sender: TObject);
    procedure Sendto1Click(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure EditAnnotationClick(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure AnnBorderClick(Sender: TObject);
    procedure AnnColorClick(Sender: TObject);
    procedure AnnGradientClick(Sender: TObject);
    procedure Transparent1Click(Sender: TObject);
    procedure PopupMenuAnnPopup(Sender: TObject);
    procedure Custom1Click(Sender: TObject);
    procedure RightBottom1Click(Sender: TObject);
    procedure Edit4Click(Sender: TObject);
    procedure Arrow1Click(Sender: TObject);
    procedure MarksBorderClick(Sender: TObject);
    procedure Color3Click(Sender: TObject);
    procedure MarksGradientClick(Sender: TObject);
    procedure Transparent2Click(Sender: TObject);
    procedure ShowHints1Click(Sender: TObject);
    procedure Edit5Click(Sender: TObject);
    procedure Labels1Click(Sender: TObject);
    procedure Inverted2Click(Sender: TObject);
    procedure Ticks1Click(Sender: TObject);
    procedure Grid1Click(Sender: TObject);
    procedure Axisline1Click(Sender: TObject);
    procedure PopupMenuAxisPopup(Sender: TObject);
    procedure AutoSize1Click(Sender: TObject);
    procedure PopupMenuGalleryPopup(Sender: TObject);
    procedure Color4Click(Sender: TObject);
    procedure PopupMenuSeriesPopup(Sender: TObject);
    procedure PopupMenuMarksPopup(Sender: TObject);
    procedure Visible2Click(Sender: TObject);
    procedure Coloreach1Click(Sender: TObject);
    procedure ShowatLegend1Click(Sender: TObject);
    procedure ShowMarks1Click(Sender: TObject);
    procedure Color5Click(Sender: TObject);
    procedure LegendFontClick(Sender: TObject);
    procedure SBHintsClick(Sender: TObject);
    procedure ChartEditor1Close(Sender: TObject);
    procedure Frame1Click(Sender: TObject);
    procedure Shadow1Click(Sender: TObject);
    procedure CustomPosition1Click(Sender: TObject);
    procedure AxisFontClick(Sender: TObject);
    procedure Visible3Click(Sender: TObject);
    procedure PopupLineBorderClick(Sender: TObject);
    procedure PopupLinePopup(Sender: TObject);
    procedure PopupLineStairsClick(Sender: TObject);
    procedure PopupLineInvertedClick(Sender: TObject);
    procedure XY1Click(Sender: TObject);
    procedure WallBorderClick(Sender: TObject);
    procedure WallColorClick(Sender: TObject);
    procedure WallGradientClick(Sender: TObject);
    procedure WallTransparentClick(Sender: TObject);
    procedure WallVisibleClick(Sender: TObject);
    procedure PopupMenuWallPopup(Sender: TObject);
    procedure WallDark3DClick(Sender: TObject);
    procedure Edit3Click(Sender: TObject);
    procedure PopupLinePatternClick(Sender: TObject);
    procedure BarEllipseClick(Sender: TObject);
    procedure BarUseOriginClick(Sender: TObject);
    procedure PopupBarPopup(Sender: TObject);
    procedure BarGradientClick(Sender: TObject);
    procedure BarWidthItemClick(Sender: TObject);
    procedure AxisMinorGridClick(Sender: TObject);
    procedure AxisVisibleClick(Sender: TObject);
    procedure BarSideMarginsClick(Sender: TObject);
    procedure PopupPiePopup(Sender: TObject);
    procedure PieCircledClick(Sender: TObject);
    procedure PieDark3DClick(Sender: TObject);
    procedure PiePatternsClick(Sender: TObject);
    procedure PieRotationClick(Sender: TObject);
    procedure PopupFastLinePopup(Sender: TObject);
    procedure PopupPointPopup(Sender: TObject);
    procedure PointDarkClick(Sender: TObject);
    procedure PointDraw3DClick(Sender: TObject);
    procedure PointHeightClick(Sender: TObject);
    procedure PointWidthClick(Sender: TObject);
    procedure Smalldot1Click(Sender: TObject);
    procedure PanelView3DClick(Sender: TObject);
    procedure Colors1Click(Sender: TObject);
    procedure GrayScale2Click(Sender: TObject);
    procedure Monochrome1Click(Sender: TObject);
    procedure DBChart1AfterDraw(Sender: TObject);
    procedure GrayScaleVisual1Click(Sender: TObject);
    procedure InvertedGrayScale1Click(Sender: TObject);
    procedure ChartGrid1SetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure PopupLineOutlineClick(Sender: TObject);
    procedure LabelsFormat1Click(Sender: TObject);
    procedure BottomTabClick(Sender: TObject);
    procedure None1Click(Sender: TObject);
    procedure MarksFontClick(Sender: TObject);
    procedure TitleFontClick(Sender: TObject);
    procedure AnnoFontClick(Sender: TObject);
    procedure FontLeftAlignClick(Sender: TObject);
    procedure Bottom2Click(Sender: TObject);
    procedure Whatsthis1Click(Sender: TObject);
    procedure ChartEditor1Show(Sender: TObject);
    procedure ChartListBox1RemovedSeries(Sender: TChartListBox; Series: TCustomChartSeries);
    procedure ShapeBorderColorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ComboPenStyleDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ComboPenStyleChange(Sender: TObject);
    procedure BorderWidthChange(Sender: TObject);
    procedure Borders1Click(Sender: TObject);
    procedure Top2Click(Sender: TObject);
    procedure ChartListBox1ChangeOrder(Sender: TChartListBox; Series1, Series2: TCustomChartSeries);
    procedure ChartListBox1ChangeColor(Sender: TChartListBox; Series: TCustomChartSeries);
    procedure Options2Click(Sender: TObject);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure Symbol1Click(Sender: TObject);
    procedure Small1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SBSeriesDataClick(Sender: TObject);
  private 
    ChartGalleryWidth: Integer;
    FModified: Boolean;
    Selector: TSelectorTool;
    TeeOpenGL1: TTeeOpenGL;
    Old3DEvent: TNotifyEvent;
    IPanelFont: TTeeFont;
    DrawGrayScale: Integer;
    DrawGrayInverted: Boolean;
    SelectedBorder: TChartPen;
    procedure ArrangeGallery;
    procedure ChangeGalleryChartSize;
    procedure CheckDefaultTheme;
    procedure CheckInspectorList;
    procedure CheckLegendSelector;
    procedure CheckSeriesButtons(ASeries: TChartSeries);
    procedure CheckTitleSelector;
    procedure Commander3DClick(Sender: TObject);
    procedure CreateGallery(const AGallery: array of TChartSeriesClass);
    procedure CreateSelector;
    procedure DisableDrawLine;
    procedure DoColorEachChange;
    function DoEditColor(AColor: TColor; var Changed: Boolean): TColor;
    procedure DrawLineNewLine(Sender: TObject);
    function DrawLineTool: TDrawLineTool;
    procedure EnableButtons;
    procedure EnablePanelFont(IsEnabled: Boolean);
    procedure EnableToolButtons(ASeries: TChartSeries);
    function ExistGallerySeries(ASeries: TChartSeries): Boolean;
    function FindDrawLineTool: TDrawLineTool;
    function FindSelector: TSelectorTool;
    function InputInteger(const St: string; const Num: Integer): Integer;
    function MarkTipsTool: TMarksTipTool;
    procedure MergeSeriesMenu;
    procedure DeleteDataSetClick(Sender: TObject);
    procedure OnCreateEditSeries(Sender: TFormTeeSeries; AChart: TCustomChart);
    function SelectedTitleName: string;
    procedure SelectorDragged(Sender: TObject);
    procedure SelectorSelected(Sender: TObject);
    procedure SetBorderToolbar;
    procedure SetChartMenuItems;
    procedure SetGalleryBorders;
    procedure SetGrayScale(Method: Integer; Inverted: Boolean);
    procedure SetInspectorProperties;
    procedure SetPanelFont(AFont: TTeeFont; EnableJustify: TEnableJustify = ejNo; Justification: TAlignment = taCenter);
    procedure Smooth1Click(Sender: TObject);
    procedure TeeCommander1SetLabel(Sender: TTeeCommander; var Text: string);
    procedure TeeModified(YesNo: Boolean = true);
    function ToogleModified(Item: TMenuItem): Boolean;
    procedure ResetChart;
    procedure DisablePopupItems(menu: TAdvPopupMenu);
  public
    Procedure LoadChart(Const ChartStream :TStream);
    function CreateNewChart(Const InitSeries: Boolean = true): Boolean;    
  end;

implementation

{$R *.dfm}

uses
     {$ifdef COMPILER_22_UP}
     CommonLib, ShellAPI, ShlObj, CommCtrl, Db, TeeEditCha,
     TeExport, TeeAbout, TeeStore,
     TypInfo, TeePenDlg, TeeConst,
     TeeEdiGrad, TeeBrushDlg, TeeEdiTitl,
     TeeSourceEdit,
     TeeFormatting, ListChartView, ChartViewPrintOptions, TeeDesignOptions,
     TeeThemes, TeeExpForm, TeeProCo, TeeDonut, MyPoint, CandleCh, StatChar,
     TeeBezie, TeePyramid, TeePolar, TeeSurfa, TeeTriSurface, TeePoin3,
     TeeAnnToolEdit, TeeFilters,
     FastFuncs;
     {$else}
     CommonLib, ShellAPI, ShlObj, CommCtrl, Db, TeeEditCha,TeeEditPro,DBEditCh,
     TeExport, TeeAbout, TeeStore, TeeSVGCanvas, TeePSCanvas, TeePCX, TeeGLEditor,
     TeeJPEG, TeeGIF, TeePNG, TeePDFCanvas, TeeDBEdit, TypInfo, TeePenDlg, TeeConst,
     TeeEdiGrad, TeeProCo, TeeBrushDlg, TeeEdiTitl, TeeAnnToolEdit, TeeVMLCanvas,
     TeeExpForm, TeeDragPoint, TeeSourceEdit, StatChar, CandleCh, TeeBezie, TeePyramid,
     MyPoint, TeeDonut, TeePolar, TeeSurfa, TeeTriSurface, TeePoin3, TeeSeriesTextEd,
     TeeXML, TeeDBCrosstab, TeeThemes, TeeFormatting, ListChartView, ChartViewPrintOptions,
     FastFuncs, SystemLib;
     {$endif}

const
  ComboPart_Chart     = 0;
  ComboPart_Legend    = 1;
  ComboPart_Title     = 2;
  ComboPart_Series    = 3;
  ComboPart_Marks     = 4;
  ComboPart_Axis      = 5;
  ComboPart_Wall      = 6;
  ComboPart_Annot     = 7;
  ConstMsg_ZoomInstructions = 'Drag mouse to right-bottom to zoom. To left-top to unzoom.';
  ConstMsg_ScrollInstructions = 'Drag mouse to scroll Chart contents.';
  ConstMsg_DrawLineInstructions = 'Drag mouse to draw, select and move lines.';
  ConstMsg_SureToDeleteDataSet = 'Are you sure to delete DataSet?';
  ConstMsg_Select       = 'Select';
  ConstMsg_EMail        = 'e-mail';
  ConstMsg_Open         = 'Open';
  ConstMsg_New          = 'New';
  ConstMsg_ImportingWeb = 'Importing from Web: %s';
  ConstMsg_Annotation   = 'Annotation';
  ConstMsg_Modified     = 'Modified';
  ConstMsg_Next         = '&Next >';
  ConstMsg_OK           = 'OK';
  ConstMsg_Close        = 'Close';
  ConstMsg_Go           = '&Go !';
  ConstMsg_Upload       = '&Upload !';
  ConstMsg_CannotGetVersion = 'Cannot connect to obtain current version.' + #13 + 'Error: %d %s';
  ConstMsg_CannotGetNewVersion = 'Cannot download current version.' + #13 + 'Error: %d %s';
  ConstMsg_WrongVersion = 'Wrong version number received.';
  ConstMsg_HasLatestVersion = 'You already have the latest version.';
  ConstMsg_ClickToUpdateVersion = 'Click the Update button to receive the latest version.';
  ConstMsg_UpdateButton = '&Update...';
  ConstMsg_WrongZip     = 'Wrong version file received.';
  ConstMsg_VersionReceived = 'Latest version received. Click Ok to Install.';
  ConstMsg_SelectFolder = 'Select Folder';
  ConstMsg_EmailNotValid = 'Email address is not correct.';
  ConstMsg_NameNotValid = 'Your Name is empty. Please type your name.';
  ConstMsg_WrongPassword = 'Password is empty. Please type your password or ' + #13 + 'click the Obtain Password button to receive it by e-mail.';
  ConstMsg_WrongChartID = 'Chart name is empty. Please type a Chart name to ' + 'identify it at the Web Gallery database.';
  ConstMsg_CannotObtainPassword = 'Cannot connect to obtain your Password.';
  ConstMsg_PasswordSent = 'Your Password has been sent to your email address.';
  ConstMsg_Congrats     = 'Congratulations.' + #13 + 'You have been included in TeeChart Office ' + 'Web Charts Gallery user database.' + #13 + ConstMsg_PasswordSent;
  ConstMsg_UploadingWeb = 'Uploading %s to Web Gallery...';
  ConstMsg_Uploaded     = '%s has been uploaded to Web Gallery.';
  ConstMsg_TitleEditor  = 'Title Editor';
  ConstMsg_EnterValue   = 'Enter value';
  ConstMsg_PointWidth   = 'Width';
  ConstMsg_PointHeight  = 'Height';
  ConstMsg_Position     = 'Position: %d,%d';
  ConstMsg_Size         = 'Size: %d x %d';
  ConstMsg_BetaWarning  = 'Note: ' + 'This is Pre-Release Software.' + #13 + #13 + 'Some features might be incomplete or' + #13 + 'removed in the final product version.' + #13 + #13 + 'Submit problems and suggestions at our web site:' + #13 + #13 + 'www.steema.com';
  ConstMsg_Caps         = 'CAPS';
  ConstMsg_Num          = 'NUM';
  ConstMsg_SCR          = 'SCR';
  ConstMsg_Chart1       = 'Chart1';
  ConstMsg_SaveAs       = 'Save as...';
  ConstMsg_LeftWall     = 'Left Wall';
  ConstMsg_BottomWall   = 'Bottom Wall';
  ConstMsg_RightWall    = 'Right Wall';
  ConstMsg_BackWall     = 'Back Wall';
  ConstMsg_ShouldClose  = 'Please close and restart TeeChartOffice.';
  ConstMsg_AxisDivider  = 'Axis Divider';
  ConstMsg_PieTool      = 'Pie Slices';
  ConstMsg_Table        = 'Table';
  ConstMsg_Query        = 'Query';
  ConstMsg_XMLFile      = 'XML files';
  ConstMsg_ExcelFile    = 'Excel files';
  ConstMsg_ExcelEmptyFile = 'Excel file name is empty.';
  ConstMsg_Expression   = 'Expression';
  ConstMsg_OpenWithTeeChartOffice = 'Open with &TeeChart Office';
  ConstMsg_BarWidth     = 'Bar Width %';
  ConstMsg_PieRotation  = 'Rotation';
var 
  ChartListXY: array[0..17] of TChartSeriesClass;
  ChartListXYZ: array[0..5] of TChartSeriesClass;

procedure TChartDesigner.ChartProperties1Click(Sender: TObject);
begin
  with ChartEditor1 do begin
    DefaultTab := cetMain;
    Execute;
  end;
  TeeModified;
end;

function Toogle(Item: TMenuItem): Boolean;
begin 
  Item.Checked := Not Item.Checked;
  Result := Item.Checked;
end;

procedure TChartDesigner.ChartListBox1DblClickSeries(Sender: TChartListBox; Index: Integer);
begin 
  SBEditClick(Sender);
end;

procedure TChartDesigner.EnableButtons;
begin 
  SBEdit.Enabled := ChartListBox1.AnySelected;
  SBFont.Enabled := SBEdit.Enabled;
  SBDelete.Enabled := SBEdit.Enabled;
  TBMoveUp.Enabled := SBEdit.Enabled And (ChartListBox1.ItemIndex > 0);
  TBMoveDown.Enabled := SBEdit.Enabled And (ChartListBox1.ItemIndex < ChartListBox1.Items.Count - 1);
end;

function TChartDesigner.ExistGallerySeries(ASeries: TChartSeries): Boolean;
var 
  t: Integer;
  tmp: TChartSeries;
begin 
  Result := false;
  if Assigned(ASeries) then with ChartGalleryPanel1 do begin 
      for t := 0 to Charts.Count - 1 do begin 
        tmp := Charts[t].Series[0];
        if tmp Is ASeries.ClassType then begin 
          Result := true;
          Break;
        end;
      end;
    end;
end;

type 
  TChartGalleryAccess = class(TChartGalleryPanel);

procedure TChartDesigner.ChartListBox1Click(Sender: TObject);
var 
  tmp: TChartSeries;
  tmpClass: TChartSeriesClass;
  tmpFound: Boolean;
  t: Integer;
begin 
  EnableButtons;
  if ExistGallerySeries(ChartListBox1.SelectedSeries) then begin
    if ChartGalleryPanel1.SelectedSeries <> ChartListBox1.SelectedSeries then begin 
      ChartGalleryPanel1.SelectedSeries := ChartListBox1.SelectedSeries;
      TChartGalleryAccess(ChartGalleryPanel1).FindSelectedChart;
      ChartGalleryPanel1.SelectedChart.Tag := 0;
      ChartGalleryPanel1.OnChangeChart := nil;
      TChartGalleryAccess(ChartGalleryPanel1).ShowSelectedChart;
      ChartGalleryPanel1.OnChangeChart := ChartGalleryPanel1ChangeChart;
    end;
  end else begin
    if Assigned(ChartListBox1.SelectedSeries) then begin
      tmpClass := TChartSeriesClass(ChartListBox1.SelectedSeries.ClassType);
      tmpFound := false;
      for t := Low(ChartListXY) to High(ChartListXY) do if ChartListXY[t] = tmpClass then begin
          tmpFound := true;
          Break;
        end;
      if tmpFound then CreateGallery(ChartListXY)
      else CreateGallery([tmpClass]);
    end;
  end;
  tmp := ChartListBox1.SelectedSeries;
  EnableControls(Assigned(tmp), [ColorEach, ShowMarks, ShowAtLegend]);
  CheckSeriesButtons(tmp);
  if PanelSeries.TabVisible And ChartListBox1.CanFocus And Showing then SetControlFocus(ChartListBox1);
  EnableToolButtons(tmp);
  if Not Assigned(Selector) then CreateSelector;
  try
    if ChartListBox1.SelCount = 1 then
      if (Selector.Series=nil) or (Selector.Series <> tmp) then
        Selector.Series := tmp;
  Except
    on E:Exception do
      if devmode then
       TimerMsg(lblNote ,  E.Message);
  end;
end;

procedure TChartDesigner.CheckSeriesButtons(ASeries: TChartSeries);
begin 
  if Assigned(ASeries) then begin 
    ColorEach.Down    := ASeries.ColorEachPoint;
    ColorEach.Enabled := Not (ASeries Is TPieSeries);
    ShowMarks.Down    := ASeries.Marks.Visible;
    ShowAtLegend.Down := ASeries.ShowInLegend;
  end;
end;

procedure TChartDesigner.EnableToolButtons(ASeries: TChartSeries);
begin 
  EnableControls(Assigned(ASeries) And ASeries.UseAxis, [SBZoom, SBScroll, SBDrawLine]);
end;

procedure TChartDesigner.SBAddClick(Sender: TObject);
var
  tmp: TChartSeries;
begin 
  tmp := ChartListBox1.AddSeriesGallery;
  if Assigned(tmp) then begin
    tmp.DataSource:=TListChartView(Self.Owner).ChartSetup.ChartDataset;
    tmp.CheckDataSource;
    tmp.ParentChart := DBChart1;
    EnableButtons;
    Selector.Series := tmp;
    TeeModified;
    SBSeriesData.Click;
    TListChartView(Self.Owner).ChartSetup.EnableSeriesDataChange;
  end;
end;

procedure TChartDesigner.SBDeleteClick(Sender: TObject);
begin 
  if ChartListBox1.DeleteSeries then begin
    EnableButtons;
    Selector.ClearSelection;
    TeeModified;
  end;
end;

procedure TChartDesigner.SBEditClick(Sender: TObject);
begin
  with ChartEditor1 do begin
    DefaultTab := cetSeriesData;
    Execute;
  end;
  TeeModified;
end;

procedure TChartDesigner.TBMoveUpClick(Sender: TObject);
begin 
  ChartListBox1.MoveCurrentUp;
  EnableButtons;
  TeeModified;
end;

procedure TChartDesigner.TBMoveDownClick(Sender: TObject);
begin 
  ChartListBox1.MoveCurrentDown;
  EnableButtons;
  TeeModified;
end;

procedure TChartDesigner.CreateGallery(const AGallery: array of TChartSeriesClass);
begin 
  with ChartGalleryPanel1 do begin 
    SelectedSeries := ChartListBox1.SelectedSeries;
    if High(AGallery) = 0 then begin 
      with TChartGalleryAccess(ChartGalleryPanel1) do begin 
        tmpSeries := SelectedSeries;
        AddSubCharts(ChartGalleryPanel1);
      end;
      DisplaySub := false;
    end else begin 
      CreateChartList(AGallery);
      DisplaySub := true;
    end;
    ArrangeGallery;
  end;
end;

procedure TChartDesigner.ArrangeGallery;
var 
  t: Integer;
begin 
  with ChartGalleryPanel1 do for t := 0 to Charts.Count - 1 do with Charts[t] do begin 
        Title.Visible := false;
        Hint := Title.Text[0];
        LeftAxis.Axis.Width := 1;
        BottomAxis.Axis.Width := 1;
      end;
end;

procedure TChartDesigner.CheckDefaultTheme;
begin 
  if TeeNewChartTheme <> 0 then ApplyChartTheme(ChartThemes[TeeNewChartTheme], DBChart1, - 1);
end;

type 
  TCommanderAccess = class(TTeeCommander);

procedure TChartDesigner.FormShow(Sender: TObject);
var 
  t: Integer;
begin
  inherited;
  TeeNewChartTheme := TeeReadIntegerOption(TeeMsg_DefaultTheme, 0);
  CheckDefaultTheme;
  ComboFonts.Items := Screen.Fonts;
  with ImageList3 do begin 
    GetBitmap(14, FontBold.Glyph);
    GetBitmap(15, FontItalic.Glyph);
    GetBitmap(16, FontUnderline.Glyph);
    GetBitmap(17, FontStrike.Glyph);
    GetBitmap(18, FontLeftAlign.Glyph);
    GetBitmap(19, FontCenterAlign.Glyph);
    GetBitmap(20, FontRightAlign.Glyph);
  end;
  with ChartGalleryPanel1 do begin 
    clTeeGallery  := clWhite;
    clTeeGallery1 := clSilver;
    ShowHint      := true;
    NumRows       := High(ChartListXY) + 1;
  end;
  with TCommanderAccess(TeeCommander1) do begin 
    TeeCommander1.ButtonSave.Visible := false;
    TeeCommander1.ButtonPrint.Visible := false;
    TeeCommander1.ButtonCopy.Visible := false;
    RepositionControls;
    for t := 0 to ControlCount - 1 do Controls[t].Top := 0;
    Old3DEvent       := Button3D.OnClick;
    Button3D.OnClick := Commander3DClick;
  end;
  CreateGallery(ChartListXY);
  SetGalleryBorders;
  ChangeGalleryChartSize;
  ComboBoxParts.ItemIndex := ComboPart_Chart;
  SetInspectorProperties;
  TeeModified(false);
  EnableButtons;
  SubForm.Color := TListChartView(Self.Owner).TabColor;
end;

procedure TChartDesigner.Title1Click(Sender: TObject);
begin 
  if ChartListBox1.RenameSeries then TeeModified;
end;

procedure TChartDesigner.Change1Click(Sender: TObject);
begin 
  ChartListBox1.ChangeTypeSeries(Self);
  TeeModified;
end;

procedure TChartDesigner.CloneItemClick(Sender: TObject);
begin 
  with ChartListBox1 do begin 
    CloneSeries;
    ItemIndex := Items.Count - 1;
    ChartListBox1Click(Self);
  end;
  TeeModified;
end;

procedure TChartDesigner.LocalMenuPopup(Sender: TObject);
begin 
  DeleteItem.Enabled := ChartListBox1.SelCount > 0;
  CloneItem.Enabled := (DBChart1.SeriesCount > 0) And (ChartListBox1.SelCount = 1);
  SelectAllItem.Enabled := ChartListBox1.Items.Count > 0;
  Change1.Enabled := DeleteItem.Enabled;
  MenuItem2.Enabled := CloneItem.Enabled;
  Title1.Enabled := CloneItem.Enabled;
  MoveUp1.Enabled := MenuItem2.Enabled And (ChartListBox1.ItemIndex > 0);
  MoveDown1.Enabled := MenuItem2.Enabled And (ChartListBox1.ItemIndex < ChartListBox1.Items.Count - 1);
end;

procedure TChartDesigner.SelectAllItemClick(Sender: TObject);
begin 
  ChartListBox1.SelectAll;
end;

procedure TChartDesigner.SelectorDragged(Sender: TObject);
begin 
  AutoSize1.Checked := DBChart1.Align = alClient;
  SetInspectorProperties;
  TeeModified;
end;

function TChartDesigner.FindSelector: TSelectorTool;
var 
  t: Integer;
begin 
  Result := nil;
  for t := 0 to DBChart1.Tools.Count - 1 do if DBChart1.Tools[t] Is TSelectorTool then begin 
      Result := TSelectorTool(DBChart1.Tools[t]);
      Break;
    end;
end;

procedure TChartDesigner.CreateSelector;
var 
  t: Integer;
begin
  repeat
    Selector := FindSelector;
    if Assigned(Selector) then FreeAndNil(Selector);
  until Not Assigned(Selector);
  Selector := TSelectorTool.Create(Self);
  with Selector do begin 
    Brush.Color := clWhite;
    ParentChart := DBChart1;
    OnSelected  := SelectorSelected;
    OnDragged   := SelectorDragged;
    OnResized   := SelectorDragged;
  end;
  with DBChart1 do for t := 0 to Tools.Count - 1 do if Tools[t] Is TRotateTool then Tools[t].Active := false;
  if Assigned(IPanelFont) then begin 
    IPanelFont := nil;
    SetPanelFont(nil);
  end;
end;

procedure TChartDesigner.SetChartMenuItems;
begin 
end;

function TChartDesigner.ToogleModified(Item: TMenuItem): Boolean;
begin 
  Result := Toogle(Item);
  TeeModified;
end;

procedure TChartDesigner.ChartTools1Click(Sender: TObject);
begin
  with ChartEditor1 do begin
    DefaultTab := cetTools;
    Execute;
  end;
  TeeModified;
end;

procedure TChartDesigner.DBChart1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  procedure CheckCornerCursor;
  begin
    with DBChart1 do if Selector.ClickedCorner(X, Y) then begin
        Cursor := crSizeNWSE;
        OriginalCursor := crSizeNWSE;
        CancelMouse := true;
      end else if Cursor = crSizeNWSE then begin 
      Cursor         := crDefault;
      OriginalCursor := crDefault;
    end;
  end;
var 
  Part: TChartClickedPart;
  S: string;
begin 
  if FindSelector = nil then CreateSelector;
  DBChart1.CalcClickedPart(TeePoint(X, Y), Part);
  case Part.Part of 
    cpLegend: S := TeeMsg_Legend;
    cpAxis: S := DBChart1.AxisTitleOrName(Part.AAxis);
    cpSeries:
      begin
        S := SeriesTitleOrName(Part.ASeries) + ' ' + IntToStr(Part.PointIndex);
        Selector.Part.PointIndex := Part.PointIndex;
      end;
    cpSeriesMarks: S := SeriesTitleOrName(Part.ASeries) + ' ' + TeeMsg_Marks;
    cpSubTitle, cpTitle, cpSubFoot, cpFoot: S := SelectedTitleName;
    else begin 
        S := '';
        CheckCornerCursor;
      end;
  end;
end;

procedure TChartDesigner.DBChart1DblClick(Sender: TObject);
Var
 tmpTab: TChartEditorTab;
begin 
  if Assigned(Selector.Annotation) then begin 
    EditAnnotationClick(Self);
    DBChart1.CancelMouse := true;
    Selector.StopDragging;
    TeeModified;
  end else if Selector.Part.Part <> cpNone then begin 
    case Selector.Part.Part of
      cpLegend   : tmpTab := cetLegend;
      cpAxis     : tmpTab := cetAxis;
      cpSeries   : tmpTab := cetSeriesGeneral;
    cpSeriesMarks: tmpTab := cetSeriesMarks;
      cpTitle    : tmpTab := cetTitles;
      cpFoot     : tmpTab := cetTitles;
      cpSubTitle : tmpTab := cetTitles;
      cpSubFoot  : tmpTab := cetTitles;
    else
      tmpTab := cetMain;
    end;

    with ChartEditor1 do begin
      DefaultTab := tmpTab;
      Execute;
    end;

    if FindSelector = nil then CreateSelector;
    DBChart1.CancelMouse := true;
    Selector.StopDragging;
    TeeModified;
  end;
end;

procedure TChartDesigner.Print1Click(Sender: TObject);
begin 
  with TPrintDialog.Create(Self) do try 
      if Execute then DBChart1.Print;
    finally 
      Free;
    end;
end;

procedure TChartDesigner.New1Click(Sender: TObject);
begin 
  CreateNewChart;
end;

function TChartDesigner.CreateNewChart(Const InitSeries: Boolean = true): Boolean;
var 
  tmpS: TFastLineSeries;
begin 
  ResetChart;
  if InitSeries then begin
    CreateSelector;
    tmpS := TFastLineSeries.Create(nil);
    try
      if Not ExistGallerySeries(tmpS) then CreateGallery(ChartListXY);
    finally
      tmpS.Free;
    end;
    ChartPageNavigator1.EnableButtons;
    EnableButtons;
    SetInspectorProperties;
  end;
  Result := True;
end;

procedure TChartDesigner.ResetChart;
var 
  tmpEmpty: TDBChart;
begin 
  Selector.ClearSelection;
  Selector := nil;
  DBChart1.FreeAllSeries;
  DBChart1.Tools.Clear;
  tmpEmpty := TDBChart.Create(nil);
  try
    tmpEmpty.Title.Text.Add(ConstMsg_Chart1);
    tmpEmpty.AllowZoom    := false;
    tmpEmpty.AllowPanning := pmNone;
    tmpEmpty.Color        := clWhite;
    DBChart1.Assign(tmpEmpty);
    CheckDefaultTheme;
  finally
    tmpEmpty.Free;
  end;
end;

type 
  TTeeWizardAccess = class(TTeeDlgWizard);

procedure TChartDesigner.NewusingWizard1Click(Sender: TObject);
begin 
  with TTeeWizardAccess(TTeeDlgWizard.Create(Self)) do try 
      if ShowModal = mrOk then begin 
        if Self.CreateNewChart(False) then begin
          CopyPreviewChart(TCustomChart(Self.DBChart1));
          ChartListBox1Click(Self);
        end;
        TeeModified;
      end;
    finally 
      Free;
    end;
end;

procedure TChartDesigner.HideSerieslist1Click(Sender: TObject);
begin 
  PanelSeries.TabVisible := false;
  CheckInspectorList;
end;

procedure TChartDesigner.CheckInspectorList;
begin 
  Panel1.Visible := PanelSeries.TabVisible Or PanelInspector.Visible;
  Splitter1.Visible := Panel1.Visible;
end;

procedure TChartDesigner.TeeCommander1SetLabel(Sender: TTeeCommander; var Text: string);
begin 
  if Text = TeeCommanMsg_NormalLabel then Text := '';
end;

type 
  TChartGridAccess    = class(TChartGrid);
  TChartListBoxAccess = class(TChartListBox);

procedure TChartDesigner.FormCreate(Sender: TObject);
  procedure FillDefaultSeriesArrays;
  begin 
    ChartListXY[0] := TLineSeries;
    ChartListXY[1] := TBarSeries;
    ChartListXY[2] := THorizBarSeries;
    ChartListXY[3] := TPieSeries;
    ChartListXY[4] := TPointSeries;
    ChartListXY[5] := THorizLineSeries;
    ChartListXY[6] := TDonutSeries;
    ChartListXY[7] := TBarJoinSeries;
    ChartListXY[8] := TVolumeSeries;
    ChartListXY[9] := TFastLineSeries;
    ChartListXY[10] := TAreaSeries;
    ChartListXY[11] := THistogramSeries;
    ChartListXY[12] := TBezierSeries;
    ChartListXY[13] := TPyramidSeries;
    ChartListXY[14] := TPolarSeries;
    ChartListXY[15] := TRadarSeries;
    ChartListXY[16] := TMyPointSeries;
    ChartListXY[17] := THorizAreaSeries;
    ChartListXYZ[0] := TSurfaceSeries;
    ChartListXYZ[1] := TWaterFallSeries;
    ChartListXYZ[2] := TContourSeries;
    ChartListXYZ[3] := TTriSurfaceSeries;
    ChartListXYZ[4] := TColorGridSeries;
    ChartListXYZ[5] := TPoint3DSeries;
  end;


begin
  inherited;
  FillDefaultSeriesArrays;
  ChartGalleryWidth := 66;
  DrawGrayScale := -1;
  DrawGrayInverted := false;
  ScrollBox1.VertScrollBar.Style := ssFlat;
  PageControlSeries.HotTrack := true;
  PageControlSeries.ActivePage := PanelSeries;
  DBChart1.Color := clWhite;
  Inspector.Color := clWhite;
  ChartGalleryPanel1.Color := clWhite;
  Text1.Default := true;
  Edit2.Default := true;
  Edit3.Default := true;
  Edit4.Default := true;
  Edit5.Default := true;
  Edit6.Default := true;
  EditAnnotation.Default := true;
  Smooth1.OnClick := Smooth1Click;
  with ScrollBox2 do begin 
    HorzScrollBar.Style := ssFlat;
    VertScrollBar.Style := ssFlat;
  end;
  ScrollBox1.VertScrollBar.Style := ssFlat;
  TeeOpenGL1 := TTeeOpenGL.Create(Self);
  TeeOpenGL1.TeePanel := DBChart1;
  TeeGalleryCheckMaximize := false;
  Smooth1.Checked := ChartGalleryPanel1.DefaultSmooth;
  with TChartListBoxAccess(ChartListBox1) do ItemHeight := ItemHeight - 2;
  TeeCommander1.OnSetLabel := TeeCommander1SetLabel;
  TeeCommander1.ChartEditor := ChartEditor1;
  EnablePanelFont(false);
  CreateSelector;
  InternalOnCreateEditSeriesObj := OnCreateEditSeries;
end;

function TChartDesigner.SelectedTitleName: string;
begin 
  case Selector.Part.Part of 
    cpSubTitle, cpTitle: Result := TeeMsg_Title;
    cpSubFoot, cpFoot: Result := TeeMsg_Foot;
    else Result := '';
  end;
end;

procedure TChartDesigner.SelectorSelected(Sender: TObject);
var 
  tmp: TTeeFont;
  tmpJustify: TEnableJustify;
  tmpJustification: TAlignment;
  procedure SelectTitle(ATitle: TChartTitle);
  begin 
    tmp := ATitle.Font;
    DBChart1.PopupMenu := PopupMenuTitle;
    ComboBoxParts.Items[ComboPart_Title] := SelectedTitleName;
    ComboBoxParts.ItemIndex := ComboPart_Title;
    tmpJustify := ejAll;
    tmpJustification := Selector.SelectedTitle.Alignment;
    SelectedBorder := ATitle.Frame;
  end;
  procedure SelectSeries(APartIndex: Integer);
  var 
    tmpSt: string;
  begin 
    tmpSt := SeriesTitleOrName(Selector.Series);
    if APartIndex = ComboPart_Marks then tmpSt := tmpSt + ' ' + TeeMsg_Marks;
    ComboBoxParts.Items[APartIndex] := tmpSt;
    ComboBoxParts.ItemIndex := APartIndex;
    if APartIndex = ComboPart_Marks then begin 
//      with Selector.Series.Marks do if Visible then tmp := Font;
      if Assigned(Selector.Series) and Selector.Series.Marks.Visible then
        tmp:= Selector.Series.Marks.Font;
      DBChart1.PopupMenu := PopupMenuMarks;
    end else DBChart1.PopupMenu := PopupMenuSeries;
    ChartListBox1.ClearSelection;
    ChartListBox1.SelectedSeries := Selector.Series;
    ChartListBox1Click(Self);
    if Assigned(Selector.Series) then begin
      if APartIndex = ComboPart_Marks then begin
        Selector.Part.Part := cpSeriesMarks;
        SelectedBorder     := Selector.Series.Marks.Frame;
      end else SelectedBorder := Selector.Series.Pen;
    end;
  end;
  procedure SelectAxis;
  begin 
    tmp := Selector.Part.AAxis.LabelsFont;
    ComboBoxParts.Items[ComboPart_Axis] := DBChart1.AxisTitleOrName(Selector.Part.AAxis);
    ComboBoxParts.ItemIndex := ComboPart_Axis;
    with Selector.Part.AAxis do begin 
      if Horizontal then tmpJustify := ejNo 
      else begin 
        tmpJustify := ejNoCenter;
        if LabelsAlign = alDefault then if OtherSide then tmpJustification := taLeftJustify 
          else tmpJustification := taRightJustify 
        else if OtherSide then tmpJustification := taRightJustify 
        else tmpJustification := taLeftJustify;
      end;
    end;
    DBChart1.PopupMenu := PopupMenuAxis;
    SelectedBorder := Selector.Part.AAxis.Axis;
  end;
  procedure SelectWall(AWall: TChartWall);
  var 
    tmpSt: string;
  begin 
    if AWall = DBChart1.LeftWall then tmpSt := ConstMsg_LeftWall 
    else if AWall = DBChart1.BottomWall then tmpSt := ConstMsg_BottomWall 
    else if AWall = DBChart1.RightWall then tmpSt := ConstMsg_RightWall 
    else if AWall = DBChart1.BackWall then tmpSt := ConstMsg_BackWall;
    ComboBoxParts.Items[ComboPart_Wall] := tmpSt;
    ComboBoxParts.ItemIndex := ComboPart_Wall;
    DBChart1.PopupMenu := PopupMenuWall;
    SelectedBorder := AWall.Frame;
  end;
  procedure SelectLegend;
  begin 
    tmp := DBChart1.Legend.Font;
    DBChart1.PopupMenu := PopupLegend;
    ComboBoxParts.ItemIndex := ComboPart_Legend;
    SelectedBorder := DBChart1.Legend.Frame;
  end;
begin 
  DBChart1.PopupMenu := nil;
  SelectedBorder := nil;
  tmpJustify := ejNo;
  tmp := nil;
  case Selector.Part.Part of 
    cpLegend: SelectLegend;
    cpTitle: SelectTitle(DBChart1.Title);
    cpSubTitle: SelectTitle(DBChart1.SubTitle);
    cpFoot: SelectTitle(DBChart1.Foot);
    cpSubFoot: SelectTitle(DBChart1.SubFoot);
    cpAxis: SelectAxis;
    cpSeries: SelectSeries(ComboPart_Series);
    cpSeriesMarks: SelectSeries(ComboPart_Marks);
    cpChartRect: SelectWall(Selector.Wall);
    else if Assigned(Selector.Annotation) then begin 
        tmp := Selector.Annotation.Shape.Font;
        DBChart1.PopupMenu := PopupMenuAnn;
        with ComboBoxParts do if Items.IndexOf(ConstMsg_Annotation) = -1 then Items.Add(ConstMsg_Annotation);
        ComboBoxParts.ItemIndex := ComboPart_Annot;
        SelectedBorder := Selector.Annotation.Shape.Frame;
      end else begin 
          DBChart1.PopupMenu := PopupMenuPanel;
          ComboBoxParts.ItemIndex := ComboPart_Chart;
        end;
  end;
  SetPanelFont(tmp, tmpJustify, tmpJustification);
  SetBorderToolbar;
  SetInspectorProperties;
  Inspector.Row := 1;
end;

procedure TChartDesigner.SetInspectorProperties;
begin 
  if DBChart1.PopupMenu = PopupMenuSeries then MergeSeriesMenu;
  Inspector.SetProperties(DBChart1.PopupMenu);
end;

procedure TChartDesigner.EnablePanelFont(IsEnabled: Boolean);
var 
  t: Integer;
begin 
  for t := 0 to PanelFont.ControlCount - 1 do PanelFont.Controls[t].Enabled := IsEnabled;
  if IsEnabled then
    ShapeFontColor.Pen.Color := clBlack 
  else begin 
    ShapeFontColor.Pen.Color   := clSilver;
    ShapeFontColor.Brush.Color := clWhite;
    ComboFonts.ItemIndex := -1;
    ComboFontSize.ItemIndex := -1;
    ComboFontSize.Text         := '';
    UDFontInter.Position       := 0;
  end;
end;


procedure TChartDesigner.Exit1Click(Sender: TObject);
begin 
  Close;
end;

type 
  TSeriesAccess = class(TChartSeries);

procedure TChartDesigner.TeeCommander1EditedChart(Sender: TTeeCommander; AChart: TCustomChart);
begin 
  TeeModified;
end;

procedure TChartDesigner.ChartGalleryPanel1ChangeChart(Sender: TObject);
var
  tmpClass: TChartSeriesClass;
  tmpFunctionClass: TTeeFunctionClass;
  SubIndex: Integer;
  tmpSeries: TChartSeries;
begin
  if ChartGalleryPanel1.GetSeriesClass(tmpClass, tmpFunctionClass, SubIndex) then begin
    tmpSeries := ChartListBox1.SelectedSeries;
    if Assigned(tmpSeries) then if tmpSeries.ClassType <> tmpClass then begin
        with Selector do
          if (Part.Part = cpSeries) Or (Part.Part = cpSeriesMarks) then
            ClearSelection;
        ChangeSeriesType(tmpSeries, tmpClass);
        TSeriesAccess(tmpSeries).SetSubGallery(tmpSeries, SubIndex);
        ChartGalleryPanel1.SelectedSeries := tmpSeries;
        ChartListBox1.SelectedSeries := tmpSeries;
        CheckSeriesButtons(tmpSeries);
        Selector.Series := tmpSeries;
        EnableToolButtons(tmpSeries);
        TeeModified;
      end else if SubIndex > 0 then begin
        TSeriesAccess(tmpSeries).SetSubGallery(tmpSeries, SubIndex);
        CheckSeriesButtons(tmpSeries);
        TeeModified;
      end;
  end;
end;

procedure TChartDesigner.SetPanelFont(AFont: TTeeFont; EnableJustify: TEnableJustify; Justification: TAlignment);
begin 
  IPanelFont := AFont;
  if Assigned(IPanelFont) then begin 
    with ComboFonts do ItemIndex := Items.IndexOf(IPanelFont.Name);
    ComboFontSize.Text     := IntToStr(IPanelFont.Size);
    ShapeFontColor.Visible := true;
    if Not ComboFonts.Enabled then EnablePanelFont(true);
    with IPanelFont do begin 
      FontBold.Down := fsBold In Style;
      FontItalic.Down := fsItalic In Style;
      FontUnderline.Down := fsUnderline In Style;
      FontStrike.Down := fsStrikeOut In Style;
      ShapeFontColor.Brush.Color := Color;
      UDFontInter.Position := InterCharSize;
    end;
    FontLeftAlign.Enabled   := EnableJustify <> ejNo;
    FontCenterAlign.Enabled := EnableJustify = ejAll;
    FontRightAlign.Enabled  := EnableJustify <> ejNo;
    if EnableJustify <> ejNo then begin 
      case Justification of 
        taLeftJustify: FontLeftAlign.Down := true;
        taCenter: FontCenterAlign.Down := true;
        else FontRightAlign.Down := true;
      end;
    end;
  end else if ComboFonts.Enabled then EnablePanelFont(false);
end;

procedure TChartDesigner.SBOutlineClick(Sender: TObject);
begin 
  if EditChartPen(Self, IPanelFont.OutLine) then TeeModified;
end;

procedure TChartDesigner.EditFontInterChange(Sender: TObject);
begin 
  if Assigned(IPanelFont) then begin 
    IPanelFont.InterCharSize := UDFontInter.Position;
    TeeModified;
  end;
end;

procedure TChartDesigner.ComboFontSizeChange(Sender: TObject);
begin 
  if ComboFontSize.ItemIndex<>-1 then begin 
    with IPanelFont do Size := StrToIntDef(ComboFontSize.Items[ComboFontSize.ItemIndex], Size);
    TeeModified;
  end;
end;

procedure TChartDesigner.ComboFontsChange(Sender: TObject);
begin 
  If ComboFonts.ItemIndex<>-1 then
    IPanelFont.Name := ComboFonts.Items[ComboFonts.ItemIndex]
  else
    IPanelFont.Name := '';
  TeeModified;
end;

procedure TChartDesigner.FontBoldClick(Sender: TObject);
var 
  tmp: TFontStyles;
begin 
  tmp := [];
  if FontBold.Down then tmp := tmp + [fsBold];
  if FontItalic.Down then tmp := tmp + [fsItalic];
  if FontUnderline.Down then tmp := tmp + [fsUnderline];
  if FontStrike.Down then tmp := tmp + [fsStrikeOut];
  IPanelFont.Style := tmp;
  TeeModified;
end;

function TChartDesigner.DoEditColor(AColor: TColor; var Changed: Boolean): TColor;
var 
  tmpOld: TColor;
begin 
  tmpOld := AColor;
  Result := EditColor(Self, AColor);
  Changed := Result <> tmpOld;
end;

procedure TChartDesigner.ShapeFontColorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var 
  Changed: Boolean;
begin 
  IPanelFont.Color := DoEditColor(IPanelFont.Color, Changed);
  if Changed then begin 
    ShapeFontColor.Brush.Color := IPanelFont.Color;
    TeeModified;
  end;
end;

procedure TChartDesigner.AligntoBottom1Click(Sender: TObject);
begin 
  Toogle(TMenuItem(Sender));
  if AlignToTop1.Checked then ControlBar1.Align := alTop 
  else ControlBar1.Align := alBottom;
end;

procedure TChartDesigner.View3D1Click(Sender: TObject);
begin 
  ChartGalleryPanel1.View3D := Toogle(View3D1);
  DBChart1.View3D := ChartGalleryPanel1.View3D;
  TeeModified;
end;

procedure TChartDesigner.ComboBoxPartsChange(Sender: TObject);
  procedure CheckSeries;
  begin 
    if (Not Assigned(ChartListBox1.SelectedSeries)) And (DBChart1.SeriesCount > 0) then ChartListBox1.SelectedSeries := DBChart1[0];
  end;
begin
  with Selector.Part do case ComboBoxParts.ItemIndex of 
      ComboPart_Chart:
        begin 
          Part := cpChartRect;
          Selector.Wall := nil;
        end;
      ComboPart_Legend: Part := cpLegend;
      ComboPart_Title: Part := cpTitle;
      ComboPart_Series:
        begin 
          CheckSeries;
          if Assigned(ChartListBox1.SelectedSeries) then begin 
            Selector.Series := ChartListBox1.SelectedSeries;
            Exit;
          end else Part := cpNone;
        end;
      ComboPart_Marks:
        begin 
          CheckSeries;
          if Assigned(ChartListBox1.SelectedSeries) then begin 
            Part := cpSeriesMarks;
            ASeries := ChartListBox1.SelectedSeries;
          end else Part := cpNone;
        end;
      ComboPart_Axis:
        begin 
          Part := cpAxis;
          AAxis := DBChart1.LeftAxis;
        end;
      ComboPart_Wall:
        begin 
          Selector.Wall := DBChart1.BackWall;
          Exit;
        end;
      else Exit;
    end;
  SelectorSelected(Self);
  Selector.Repaint;
end;

procedure TChartDesigner.Copy1Click(Sender: TObject);
begin 
  DBChart1.CopyToClipboardBitmap 
end;

procedure TChartDesigner.ShowMarksClick(Sender: TObject);
begin 
  with ChartListBox1 do if SelectedSeries <> nil then begin 
      SelectedSeries.Marks.Visible := ShowMarks.Down;
      TeeModified;
    end;
end;

procedure TChartDesigner.ColorEachClick(Sender: TObject);
begin 
  with ChartListBox1 do if Assigned(SelectedSeries) then begin 
      SelectedSeries.ColorEachPoint := ColorEach.Down;
      DoColorEachChange;
    end;
end;

procedure TChartDesigner.DoColorEachChange;
begin 
  ChartListBox1.Invalidate;
  CheckSeriesButtons(Selector.Part.ASeries);
  TeeModified;
end;

procedure TChartDesigner.Titles1Click(Sender: TObject);
begin 
  with DBChart1 do begin 
    SubTitle.Visible := Title.Visible;
    Foot.Visible     := Title.Visible;
    SubFoot.Visible  := Title.Visible;
  end;
  CheckTitleSelector;
end;


procedure TChartDesigner.ShowAtLegendClick(Sender: TObject);
begin 
  with ChartListBox1 do if SelectedSeries <> nil then begin 
      SelectedSeries.ShowInLegend := ShowAtLegend.Down;
      if ShowAtLegend.Down then DBChart1.Legend.Visible := true;
      Invalidate;
      CheckLegendSelector;
      TeeModified;
    end;
end;

procedure TChartDesigner.AnnotationClick(Sender: TObject);
var 
  tmpSt: string;
  tmp: TAnnotationTool;
  A, B: Integer;
  tmpIndex: Integer;
begin 
  tmpSt := ConstMsg_Annotation;
  if InputQuery(Annotation.Hint, TeeMsg_Text, tmpSt) then begin
    tmp      := TAnnotationTool.Create(Self);
    tmp.Text := tmpSt;
    tmp.ParentChart := DBChart1;
    with DBChart1 do begin 
      A := Tools.IndexOf(Selector);
      B := Tools.IndexOf(tmp);
      Tools.Exchange(A, B);
      tmpIndex := Tools[A].ComponentIndex;
      Tools[A].ComponentIndex := Tools[B].ComponentIndex;
      Tools[B].ComponentIndex := tmpIndex;
    end;
    Selector.Annotation := tmp;
    TeeModified;
  end;
end;

procedure TChartDesigner.DisableDrawLine;
begin 
  if SBDrawLine.Down then SBDrawLine.Down := false;
  if DrawLineTool.Active then SBDrawLineClick(Self);
end;

procedure TChartDesigner.DisablePopupItems(menu: TAdvPopupMenu);
var
  x: integer;
begin
  for x := 0 to menu.Items.Count -1 do
    if not (Pos('Edit',menu.Items[x].Caption) in [1,2]) then
      menu.Items[x].Enabled := false;
end;

procedure TChartDesigner.SBZoomClick(Sender: TObject);
var 
  tmpSt: string;
begin 
  DBChart1.Zoom.Allow := SBZoom.Down;
  if SBZoom.Down then begin 
    DisableDrawLine;
    TeeCommander1.ButtonNormal.Down := true;
    with DBChart1.Zoom do begin 
      Pen.Color := clDkGray;
      Brush.Style := bsSolid;
    end;
    DBChart1.AllowPanning := pmNone;
    DBChart1.Cursor := crCross;
    tmpSt := ConstMsg_ZoomInstructions;
  end else begin 
    DBChart1.Cursor := crDefault;
    tmpSt           := '';
  end;
  Selector.Active := Not SBZoom.Down;
  DBChart1.OriginalCursor := DBChart1.Cursor;
end;

procedure TChartDesigner.SBScrollClick(Sender: TObject);
var 
  tmpSt: string;
begin 
  if SBScroll.Down then begin 
    DisableDrawLine;
    TeeCommander1.ButtonNormal.Down := true;
    DBChart1.AllowPanning := pmBoth;
    DBChart1.ScrollMouseButton := mbLeft;
    DBChart1.Cursor := crTeeHand;
    DBChart1.Zoom.Allow := false;
    tmpSt := ConstMsg_ScrollInstructions;
  end else begin 
    DBChart1.AllowPanning := pmNone;
    DBChart1.Cursor := crDefault;
    tmpSt := '';
  end;
  Selector.Active := Not SBScroll.Down;
  DBChart1.OriginalCursor := DBChart1.Cursor;
end;

function TChartDesigner.FindDrawLineTool: TDrawLineTool;
var 
  t: Integer;
begin 
  Result := nil;
  with DBChart1.Tools do for t := 0 to Count - 1 do if Items[t] Is TDrawLineTool then begin 
        Result := TDrawLineTool(Items[t]);
        Break;
      end;
end;

function TChartDesigner.DrawLineTool: TDrawLineTool;
begin 
  Result := FindDrawLineTool;
  if Not Assigned(Result) then begin 
    Result := TDrawLineTool.Create(Self);
    Result.ParentChart := DBChart1;
  end;
  Result.OnNewLine := DrawLineNewLine;
  Result.OnDraggedLine := DrawLineNewLine;
end;

procedure TChartDesigner.SBDrawLineClick(Sender: TObject);
var 
  tmpSt: string;
begin 
  DrawLineTool.EnableDraw := SBDrawLine.Down;
  if SBDrawLine.Down then begin 
    TeeCommander1.ButtonNormal.Down := true;
    DBChart1.Zoom.Allow := false;
    DBChart1.AllowPanning := pmNone;
    tmpSt := ConstMsg_DrawLineInstructions;
  end else begin 
    tmpSt := '';
  end;
  Selector.Active := Not SBDrawLine.Down;
  DBChart1.Cursor := crDefault;
  DBChart1.OriginalCursor := DBChart1.Cursor;
end;

procedure TChartDesigner.UseSeriesColor1Click(Sender: TObject);
begin 
  DBChart1.Legend.FontSeriesColor := ToogleModified(UseSeriesColor1);
end;

procedure TChartDesigner.Inverted1Click(Sender: TObject);
begin 
  DBChart1.Legend.Inverted := ToogleModified(Inverted1);
end;

procedure TChartDesigner.DrawLineNewLine(Sender: TObject);
begin 
  TeeModified;
end;

procedure TChartDesigner.TeeModified(YesNo: Boolean);
begin 
  FModified := YesNo;
  if FModified then begin 
    Inspector.Update;
    TListChartView(Self.Owner).ChartPrintOptions.TeePreviewPanel1.Refresh;
  end;
end;

procedure CreateColorBitmap(Item: TMenuItem; AColor: TColor);
begin 
  with Item.Bitmap do begin 
    Width  := 15;
    Height := 15;
    Canvas.Brush.Color := AColor;
    Canvas.Rectangle(0, 0, 14, 14);
  end;
  Item.Tag := AColor;
  Item.HelpContext := 2;
end;

procedure TChartDesigner.PopupLegendPopup(Sender: TObject);
begin 
  with DBChart1.Legend do begin 
    Visible1.Checked          := Visible;
    CheckBoxes1.Checked       := CheckBoxes;
    Inverted1.Checked         := Inverted;
    UseSeriesColor1.Checked   := FontSeriesColor;
    DividingLines1.Tag        := Integer(DividingLines);
    LegendTransparent.Checked := Transparent;
    case Alignment of 
      laLeft: Left1.Checked := true;
      laRight: Right1.Checked := true;
      laTop: Top1.Checked := true;
      laBottom: Bottom1.Checked := true;
    end;
    if Symbol.Position = Chart.spLeft then Left2.Checked := true 
    else Right2.Checked := true;
    Continous1.Checked := Symbol.Continuous;
    case LegendStyle of 
      lsAuto, lsValues: Values1.Checked := true;
      lsSeries: SeriesNames1.Checked := true;
      lsLastValues: Lastvalues1.Checked := true;
    end;
    CreateColorBitmap(Color4, Color);
    LegendBorder.Tag   := Integer(Pen);
    LegendGradient.Tag := Integer(Gradient);
    LegendFont.Tag     := Integer(Font);
  end;
end;

procedure TChartDesigner.Checkboxes1Click(Sender: TObject);
begin 
  DBChart1.Legend.CheckBoxes := ToogleModified(Checkboxes1);
end;

procedure TChartDesigner.Dividinglines1Click(Sender: TObject);
begin 
  if EditChartPen(Self, DBChart1.Legend.DividingLines) then TeeModified;
end;

procedure TChartDesigner.LegendGradientClick(Sender: TObject);
begin 
  with DBChart1.Legend do if EditTeeGradient(Self, Gradient) then begin 
      if Gradient.Visible then Transparent := false;
      TeeModified;
    end;
end;

procedure TChartDesigner.LegendTransparentClick(Sender: TObject);
begin 
  DBChart1.Legend.Transparent := ToogleModified(LegendTransparent);
end;

procedure TChartDesigner.Bottom1Click(Sender: TObject);
begin 
  with DBChart1.Legend do begin 
    if Sender = Left1 then Alignment := laLeft 
    else if Sender = Right1 then Alignment := laRight 
    else if Sender = Top1 then Alignment := laTop 
    else Alignment := laBottom;
    CustomPosition := false;
  end;
  TeeModified;
end;

procedure TChartDesigner.Right2Click(Sender: TObject);
begin 
  with DBChart1.Legend.Symbol do if Sender = Left2 then Position := Chart.spLeft 
  else Position := Chart.spRight;
  TeeModified;
end;

procedure TChartDesigner.Continous1Click(Sender: TObject);
begin 
  DBChart1.Legend.Symbol.Continuous := ToogleModified(Continous1);
end;

procedure TChartDesigner.Lastvalues1Click(Sender: TObject);
begin 
  with DBChart1.Legend do if Sender = Seriesnames1 then LegendStyle := lsSeries 
  else if Sender = Values1 then LegendStyle := lsValues 
  else LegendStyle := lsLastValues;
  TeeModified;
end;

procedure TChartDesigner.CheckLegendSelector;
begin 
  if Not DBChart1.Legend.Visible then if Selector.Part.Part = cpLegend then Selector.ClearSelection;
end;

procedure TChartDesigner.PopupMenuTitlePopup(Sender: TObject);
begin 
  with Selector.SelectedTitle do begin 
    TitleVisible.Checked     := Visible;
    TitleTransparent.Checked := Transparent;
    CustomPosition1.Checked  := CustomPosition;
    TitleShadow.Checked      := ShadowSize > 0;
    TitleAutoSize.Checked    := AdjustFrame;
    case Alignment of 
      taLeftJustify: TitleLeft.Checked := true;
      taCenter: TitleCenter.Checked := true;
      taRightJustify: TitleRight.Checked := true;
    end;
    CreateColorBitmap(Color1, Color);
    TitleBorder.Tag   := Integer(Pen);
    TitleGradient.Tag := Integer(Gradient);
    TitleFont.Tag     := Integer(Font);
  end;
end;

procedure TChartDesigner.LegendBorderClick(Sender: TObject);
begin 
  with DBChart1.Legend do if EditChartPen(Self, Pen) then begin 
      if Pen.Visible then Transparent := false;
      TeeModified;
    end;
end;

procedure TChartDesigner.TitleBorderClick(Sender: TObject);
begin 
  with Selector.SelectedTitle do if EditChartPen(Self, Pen) then begin 
      if Pen.Visible then Transparent := false;
      TeeModified;
    end;
end;

procedure TChartDesigner.TitleVisibleClick(Sender: TObject);
begin 
  Selector.SelectedTitle.Visible := Toogle(TitleVisible);
  CheckTitleSelector;
  TeeModified;
end;

procedure TChartDesigner.TitleGradientClick(Sender: TObject);
begin 
  with Selector.SelectedTitle do if EditTeeGradient(Self, Gradient) then begin 
      if Gradient.Visible then Transparent := false;
      TeeModified;
    end;
end;

procedure TChartDesigner.TitleTransparentClick(Sender: TObject);
begin 
  Selector.SelectedTitle.Transparent := ToogleModified(TitleTransparent);
end;

procedure TChartDesigner.TitleShadowClick(Sender: TObject);
begin 
  Toogle(TitleShadow);
  with Selector.SelectedTitle do if TitleShadow.Checked then ShadowSize := 3 
  else ShadowSize := 0;
  TeeModified;
end;

procedure TChartDesigner.TitleAutosizeClick(Sender: TObject);
begin 
  with Selector.SelectedTitle do begin 
    AdjustFrame := Toogle(TitleAutoSize);
    if Not AdjustFrame then Transparent := false;
  end;
  TeeModified;
end;

procedure TChartDesigner.CheckTitleSelector;
var 
  tmp: TChartTitle;
begin 
  tmp := Selector.SelectedTitle;
  if Assigned(tmp) And (Not tmp.Visible) then Selector.ClearSelection;
end;

procedure TChartDesigner.Color1Click(Sender: TObject);
var 
  Changed: Boolean;
begin 
  with Selector.SelectedTitle do begin 
    Color := DoEditColor(Color, Changed);
    if Changed then begin 
      Transparent := false;
      CreateColorBitmap(Color1, Color);
      TeeModified;
    end;
  end;
end;

procedure TChartDesigner.TitleRightClick(Sender: TObject);
begin 
  with Selector.SelectedTitle do if Sender = TitleLeft then Alignment := taLeftJustify 
  else if Sender = TitleRight then Alignment := taRightJustify 
  else Alignment := taCenter;
  TeeModified;
end;

procedure TChartDesigner.Text1Click(Sender: TObject);
var 
  tmpForm: TFormTeeTitle;
begin 
  tmpForm := TFormTeeTitle.CreateTitle(nil, DBChart1, Selector.SelectedTitle);
  with tmpForm do try 
      Position := poScreenCenter;
      BorderStyle := TeeBorderStyle;
      BorderIcons := [biSystemMenu];
      Caption := ConstMsg_TitleEditor;
      Panel1.Align := alBottom;
      CBTitles.Visible := false;
      with TButton.Create(tmpForm) do begin 
        Parent := Panel1;
        Caption := ConstMsg_Close;
        Left := tmpForm.Width - 100;
        Top := 4;
        ModalResult := mrOk;
        Default := true;
      end;
      TeeTranslateControl(tmpForm);
      if ShowModal = mrOk then TeeModified;
    finally 
      Free;
    end;
end;

procedure TChartDesigner.DeleteDataSetClick(Sender: TObject);
var 
  tmp: TChartSeries;
  tmpData: TComponent;
  t: Integer;
begin 
  tmp := TFormTeeSeries(TButton(Sender).Owner).TheSeries;
  if Assigned(tmp) And Assigned(tmp.DataSource) then if TeeYesNo(ConstMsg_SureToDeleteDataSet) then begin 
      TeeModified;
      tmpData := tmp.DataSource;
      tmp.DataSource := nil;
      TFormTeeSeries(TButton(Sender).Owner).PageSeriesChange(Sender);
      for t := 0 to tmp.ParentChart.SeriesCount - 1 do
        if tmp.ParentChart[t].DataSource = tmpData then Exit;
      tmpData.Free;
    end;
end;

procedure TChartDesigner.PopupMenuPanelPopup(Sender: TObject);
begin 
  with DBChart1 do begin 
    PanelBorder.Tag    := Integer(Border);
    PanelGradient.Tag  := Integer(Gradient);
    PanelBackImage.Tag := Integer(BackImage);
    Frame1.Tag         := Integer(Frame);
    CreateColorBitmap(PanelColor, Color);
    PanelView3D.Checked := View3D;
    if Monochrome then Monochrome1.Checked := true 
    else if DrawGrayScale = -1 then Colors1.Checked := true 
    else begin 
      if DrawGrayInverted then InvertedGrayScale1.Checked := true 
      else if DrawGrayScale = 0 then GrayScale2.Checked := true 
      else if DrawGrayScale = 1 then GrayScaleVisual1.Checked := true;
    end;
    case BevelOuter of 
      bvLowered: Lower1.Checked := true;
      bvRaised: Raise1.Checked := true;
      else None1.Checked := true;
    end;
  end;
end;

procedure TChartDesigner.Edit2Click(Sender: TObject);
begin 
  with ChartEditor1 do begin
    DefaultTab := cetPanel;
    Execute;
  end;
  TeeModified;
end;

procedure TChartDesigner.PanelColorClick(Sender: TObject);
var 
  Changed: Boolean;
begin 
  DBChart1.Color := DoEditColor(DBChart1.Color, Changed);
  if Changed then begin 
    DBChart1.Gradient.Visible := false;
    CreateColorBitmap(PanelColor, DBChart1.Color);
    TeeModified;
  end;
end;

procedure TChartDesigner.PanelBackimageClick(Sender: TObject);
begin 
  Edit2Click(Sender);
end;

procedure TChartDesigner.PanelGradientClick(Sender: TObject);
begin 
  if EditTeeGradient(Self, DBChart1.Gradient) then TeeModified;
end;

procedure TChartDesigner.PanelBorderClick(Sender: TObject);
begin 
  if EditChartPen(Self, DBChart1.Border) then TeeModified;
end;

procedure TChartDesigner.TeeChartHelp1Click(Sender: TObject);
begin 
  Application.HelpCommand(HELP_INDEX, 0);
end;

procedure TChartDesigner.Sendto1Click(Sender: TObject);
begin 
  with TTeeExportForm.Create(nil) do try 
      ExportPanel := Self.DBChart1;
      FormShow(Self);
      with LBFormat do begin 
        ItemIndex := Items.IndexOf(TeeMsg_AsJPEG);
        if ItemIndex = -1 then ItemIndex := 1;
      end;
      Self.Selector.DrawHandles := false;
      try 
        BSendClick(Self);
      finally 
        Self.Selector.DrawHandles := true;
      end;
    finally 
      Free;
    end;
end;

procedure TChartDesigner.Panel2Resize(Sender: TObject);
begin 
  ComboBoxParts.Width := Panel2.Width - 6;
end;

procedure TChartDesigner.EditAnnotationClick(Sender: TObject);
begin 
  with TAnnotationToolEdit.Create(nil) do try 
      BorderStyle := TeeBorderStyle;
      Align := alNone;
      Position := poScreenCenter;
      Tag := Integer(Selector.Annotation);
      ShowModal;
      TeeModified;
    finally;
      Free;
    end;
end;

procedure TChartDesigner.Delete1Click(Sender: TObject);
begin 
  Selector.Annotation.Free;
  Selector.ClearSelection;
  Selector.Repaint;
  TeeModified;
end;

procedure TChartDesigner.AnnBorderClick(Sender: TObject);
begin 
  with Selector.Annotation.Shape do if EditChartPen(Self, Pen) then begin 
      if Pen.Visible then Transparent := false;
      TeeModified;
    end;
end;

procedure TChartDesigner.AnnColorClick(Sender: TObject);
var 
  Changed: Boolean;
begin 
  with Selector.Annotation.Shape do begin 
    Color := DoEditColor(Color, Changed);
    if Changed then begin 
      Gradient.Visible := false;
      Transparent := false;
      CreateColorBitmap(AnnColor, Color);
      TeeModified;
    end;
  end;
end;

procedure TChartDesigner.AnnGradientClick(Sender: TObject);
begin 
  with Selector.Annotation.Shape do if EditTeeGradient(Self, Gradient) then begin 
      if Gradient.Visible then Transparent := false;
      TeeModified;
    end;
end;

procedure TChartDesigner.Transparent1Click(Sender: TObject);
begin 
  Selector.Annotation.Shape.Transparent := ToogleModified(Transparent1);
end;

procedure TChartDesigner.PopupMenuAnnPopup(Sender: TObject);
begin
  with Selector.Annotation do begin
    Transparent1.Checked := Shape.Transparent;
    Custom1.Checked      := Shape.CustomPosition;
    case Position of 
      ppLeftTop: LeftTop1.Checked := true;
      ppLeftBottom: LeftBottom1.Checked := true;
      ppRightTop: RightTop1.Checked := true;
      ppRightBottom: RightBottom1.Checked := true;
    end;
    CreateColorBitmap(AnnColor, Shape.Color);
    AnnBorder.Tag   := Integer(Shape.Frame);
    AnnGradient.Tag := Integer(Shape.Gradient);
    AnnoFont.Tag    := Integer(Shape.Font);
  end;
end;

procedure TChartDesigner.Custom1Click(Sender: TObject);
begin 
  Selector.Annotation.Shape.CustomPosition := ToogleModified(Custom1);
end;

procedure TChartDesigner.RightBottom1Click(Sender: TObject);
begin 
  with Selector.Annotation do if Sender = LeftTop1 then Position := ppLeftTop 
  else if Sender = RightTop1 then Position := ppRightTop 
  else if Sender = LeftBottom1 then Position := ppLeftBottom 
  else if Sender = RightBottom1 then Position := ppRightBottom;
  TeeModified;
end;

procedure TChartDesigner.Edit4Click(Sender: TObject);
begin 
  with ChartEditor1 do begin
    DefaultTab := cetSeriesMarks;
    Execute;
  end;
  TeeModified;
end;

procedure TChartDesigner.Arrow1Click(Sender: TObject);
begin 
  if EditChartPen(Self, Selector.Series.Marks.Arrow) then TeeModified;
end;

procedure TChartDesigner.MarksBorderClick(Sender: TObject);
begin 
  if EditChartPen(Self, Selector.Series.Marks.Frame) then TeeModified;
end;

procedure TChartDesigner.Color3Click(Sender: TObject);
var 
  Changed: Boolean;
begin 
  with Selector.Series.Marks do begin 
    BackColor := DoEditColor(BackColor, Changed);
    if Changed then begin 
      Transparent := false;
      CreateColorBitmap(Color3, BackColor);
      TeeModified;
    end;
  end;
end;

procedure TChartDesigner.MarksGradientClick(Sender: TObject);
begin 
  with Selector.Series.Marks do if EditTeeGradient(Self, Gradient) then begin 
      if Gradient.Visible then Transparent := false;
      TeeModified;
    end;
end;

procedure TChartDesigner.Transparent2Click(Sender: TObject);
begin 
  Selector.Series.Marks.Transparent := ToogleModified(Transparent2);
end;

procedure TChartDesigner.ShowHints1Click(Sender: TObject);
begin 
  ChartGalleryPanel1.ShowHint := Toogle(ShowHints1);
end;

procedure TChartDesigner.Edit5Click(Sender: TObject);
begin
  with ChartEditor1 do begin
    DefaultTab := cetAxis;
    Execute;
  end;
  TeeModified;
end;

procedure TChartDesigner.Labels1Click(Sender: TObject);
begin 
  Selector.Part.AAxis.Labels := ToogleModified(Labels1);
end;

procedure TChartDesigner.Inverted2Click(Sender: TObject);
begin 
  Selector.Part.AAxis.Inverted := ToogleModified(Inverted2);
end;

procedure TChartDesigner.Ticks1Click(Sender: TObject);
begin 
  if EditChartPen(Self, Selector.Part.AAxis.Ticks) then TeeModified;
end;

procedure TChartDesigner.Grid1Click(Sender: TObject);
begin 
  if EditChartPen(Self, Selector.Part.AAxis.Grid) then TeeModified;
end;

procedure TChartDesigner.Axisline1Click(Sender: TObject);
begin 
  if EditChartPen(Self, Selector.Part.AAxis.Axis) then TeeModified;
end;

procedure TChartDesigner.PopupMenuAxisPopup(Sender: TObject);
begin 
  with Selector.Part.AAxis do begin 
    Inverted2.Checked   := Inverted;
    Labels1.Checked     := Labels;
    Ticks1.Tag          := Integer(Ticks);
    Grid1.Tag           := Integer(Grid);
    AxisLine1.Tag       := Integer(Axis);
    AxisMinorGrid.Tag   := Integer(MinorGrid);
    AxisFont.Tag        := Integer(LabelsFont);
    AxisVisible.Checked := Visible;
  end;
end;

procedure TChartDesigner.AutoSize1Click(Sender: TObject);
begin 
  Toogle(AutoSize1);
  if AutoSize1.Checked then DBChart1.Align := alClient
  else DBChart1.Align := alNone;
  TeeModified;
end;

procedure TChartDesigner.PopupMenuGalleryPopup(Sender: TObject);
begin 
  ShowHints1.Checked := ChartGalleryPanel1.ShowHint;
  View3D1.Checked := ChartGalleryPanel1.View3D;
end;

procedure TChartDesigner.Color4Click(Sender: TObject);
var 
  Changed: Boolean;
begin 
  with DBChart1.Legend do begin 
    Color := DoEditColor(Color, Changed);
    if Changed then begin 
      Transparent := false;
      CreateColorBitmap(Color4, Color);
      TeeModified;
    end;
  end;
end;

procedure TChartDesigner.PopupMenuSeriesPopup(Sender: TObject);
begin
  if Assigned(Selector.Series) then begin
    with Selector.Series do begin
      ShowAtLegend1.Checked := ShowInLegend;
      ShowMarks1.Checked    := Marks.Visible;
      ColorEach1.Checked    := ColorEachPoint;
      Visible2.Checked      := Active;
      CreateColorBitmap(Color5, SeriesColor);
    end;
  end
  else
    DisablePopupItems(TAdvPopupMenu(Sender));
end;

procedure TChartDesigner.MergeSeriesMenu;
  procedure MergeMenu(AMenu: TPopupMenu);
    function CreateItem(AItem: TMenuItem): TMenuItem;
    begin 
      Result := TMenuItem.Create(AMenu);
      with AItem do begin 
        Result.Caption     := Caption;
        Result.Tag         := Tag;
        Result.Checked     := Checked;
        Result.RadioItem   := RadioItem;
        Result.OnClick     := OnClick;
        Result.HelpContext := HelpContext;
      end;
    end;
  var 
    t, tt: Integer;
    tmp: TMenuItem;
  begin 
    AMenu.OnPopup(Self);
    for t := 0 to AMenu.Items.Count - 1 do begin 
      tmp := CreateItem(AMenu.Items[t]);
      for tt := 0 to AMenu.Items[t].Count - 1 do tmp.Add(CreateItem(AMenu.Items[t].Items[tt]));
      PopupMenuSeries.Items.Add(tmp);
    end;
  end;
var 
  tmp: TMenuItem;
begin 
  with PopupMenuSeries do begin
    tmp := Items[Items.Count - 1];
    while tmp <> SeriesPopupSep do begin 
      Items.Delete(Items.Count - 1);
      tmp.Free;
      tmp := Items[Items.Count - 1];
    end;
  end;
  try
         if Selector.Series Is TLineSeries then MergeMenu(PopupLine)
    else if Selector.Series Is TCustomBarSeries then MergeMenu(PopupBar)
    else if Selector.Series Is TPieSeries then MergeMenu(PopupPie)
    else if Selector.Series Is TFastLineSeries then MergeMenu(PopupFastLine)
    else if Selector.Series Is TPointSeries then MergeMenu(PopupPoint);
  Except
    on E:Exception do
      if devmode then
       TimerMsg(lblNote ,  E.Message);
  end;
end;

procedure TChartDesigner.PopupMenuMarksPopup(Sender: TObject);
begin
  if {Assigned(Selector.Part) and} Assigned(Selector.Part.ASeries) then begin
    with Selector.Part.ASeries.Marks do begin
      Transparent2.Checked := Transparent;
      Visible3.Checked     := Visible;
      CreateColorBitmap(Color3, BackColor);
      Arrow1.Tag        := Integer(Arrow);
      MarksBorder.Tag   := Integer(Pen);
      MarksGradient.Tag := Integer(Gradient);
      MarksFont.Tag     := Integer(Font);
      MarksStyle.Items[Ord(Style)].Checked := true;
    end;
  end
  else
    DisablePopupItems(TAdvPopupMenu(Sender));
end;

procedure TChartDesigner.Visible2Click(Sender: TObject);
begin 
  with ChartListBox1 do if Assigned(SelectedSeries) then SelectedSeries.Active := ToogleModified(Visible2);
end;

procedure TChartDesigner.Coloreach1Click(Sender: TObject);
begin 
  Selector.Part.ASeries.ColorEachPoint := Toogle(ColorEach1);
  DoColorEachChange;
end;

procedure TChartDesigner.ShowatLegend1Click(Sender: TObject);
begin 
  Selector.Part.ASeries.ShowInLegend := Toogle(ShowAtLegend1);
  CheckSeriesButtons(Selector.Part.ASeries);
  TeeModified;
end;

procedure TChartDesigner.ShowMarks1Click(Sender: TObject);
begin 
  Selector.Part.ASeries.Marks.Visible := Toogle(ShowMarks1);
  CheckSeriesButtons(Selector.Part.ASeries);
  TeeModified;
end;

procedure TChartDesigner.Color5Click(Sender: TObject);
var 
  Changed: Boolean;
begin
  if not Assigned(Selector.Part.ASeries) then
    exit;
  with Selector.Part.ASeries do begin
    SeriesColor := DoEditColor(SeriesColor, Changed);
    if Changed then begin 
      CreateColorBitmap(Color5, SeriesColor);
      if ColorEachPoint then begin 
        ColorEachPoint := false;
        SetInspectorProperties;
      end;
      TeeModified;
    end;
  end;
end;

procedure TChartDesigner.OnCreateEditSeries(Sender: TFormTeeSeries; AChart: TCustomChart);
begin 
  with Sender do begin 
    DeleteDataButton.OnClick := DeleteDataSetClick;
  end;
end;

procedure TChartDesigner.LegendFontClick(Sender: TObject);
begin 
  if EditTeeFont(Self, DBChart1.Legend.Font) then TeeModified;
end;

procedure TChartDesigner.SBHintsClick(Sender: TObject);
begin 
  MarkTipsTool.Active := SBHints.Down;
  if SBHints.Down then DisableDrawLine;
end;

function TChartDesigner.MarkTipsTool: TMarksTipTool;
var 
  t: Integer;
begin 
  Result := nil;
  with DBChart1.Tools do for t := 0 to Count - 1 do if Items[t] Is TMarksTipTool then begin 
        Result := TMarksTipTool(Items[t]);
        Break;
      end;
  if Not Assigned(Result) then begin 
    Result       := TMarksTipTool.Create(Self);
    Result.ParentChart := DBChart1;
    Result.Style := smsValue;
  end;
  Result.MouseAction := mtmMove;
  Result.MouseDelay := 100;
end;

procedure TChartDesigner.ChartEditor1Close(Sender: TObject);
begin 
  SetChartMenuItems;
  if FindSelector = nil then CreateSelector;
  Selector.DrawHandles := true;
  TeeModified;
end;

procedure TChartDesigner.Frame1Click(Sender: TObject);
begin 
  if EditChartPen(Self, DBChart1.Frame) then TeeModified;
end;

procedure TChartDesigner.Shadow1Click(Sender: TObject);
begin 
  EditAnnotationClick(Sender);
end;

procedure TChartDesigner.CustomPosition1Click(Sender: TObject);
begin 
  Selector.SelectedTitle.CustomPosition := ToogleModified(CustomPosition1);
end;

procedure TChartDesigner.AxisFontClick(Sender: TObject);
begin 
  if EditTeeFont(Self, Selector.Part.AAxis.LabelsFont) then TeeModified;
end;

procedure TChartDesigner.Visible3Click(Sender: TObject);
begin 
  Selector.Part.ASeries.Marks.Visible := Toogle(Visible3);
  ShowMarks.Down := Visible3.Checked;
  TeeModified;
end;

procedure TChartDesigner.PopupLineBorderClick(Sender: TObject);
begin 
  if EditChartPen(Self, Selector.Series.Pen) then TeeModified;
end;

procedure TChartDesigner.PopupLinePopup(Sender: TObject);
begin 
  with Selector.Series As TLineSeries do begin
    PopupLineBorder.Tag       := Integer(LinePen);
    PopupLinePattern.Tag      := Integer(LineBrush);
    PopupLineOutline.Tag      := Integer(OutLine);
    PopupLineStairs.Checked   := Stairs;
    PopupLineInverted.Checked := InvertedStairs;
  end;
end;

procedure TChartDesigner.PopupLineStairsClick(Sender: TObject);
begin
  (Selector.Series As TLineSeries).Stairs := ToogleModified(Sender As TMenuItem);
end;

procedure TChartDesigner.PopupLineInvertedClick(Sender: TObject);
begin
  (Selector.Series As TLineSeries).InvertedStairs := ToogleModified(Sender As TMenuItem);
end;

procedure TChartDesigner.XY1Click(Sender: TObject);
begin 
  Selector.Series.Marks.Style := TSeriesMarksStyle((Sender As TMenuItem).MenuIndex);
  TeeModified;
end;

procedure TChartDesigner.WallBorderClick(Sender: TObject);
begin 
  if EditChartPen(Self, Selector.Wall.Pen) then TeeModified;
end;

procedure TChartDesigner.WallColorClick(Sender: TObject);
var 
  Changed: Boolean;
begin 
  with Selector.Wall do begin 
    Color := DoEditColor(Color, Changed);
    if Changed then begin 
      Transparent := false;
      Gradient.Visible := false;
      CreateColorBitmap(WallColor, Color);
      TeeModified;
    end;
  end;
end;

procedure TChartDesigner.WallGradientClick(Sender: TObject);
begin 
  if EditTeeGradient(Self, Selector.Wall.Gradient) then begin 
    if Selector.Wall.Gradient.Visible then Selector.Wall.Transparent := false;
    TeeModified;
  end;
end;

procedure TChartDesigner.WallTransparentClick(Sender: TObject);
begin 
  Selector.Wall.Transparent := ToogleModified(WallTransparent);
end;

procedure TChartDesigner.WallVisibleClick(Sender: TObject);
begin 
  Selector.Wall.Visible := ToogleModified(WallVisible);
end;

procedure TChartDesigner.PopupMenuWallPopup(Sender: TObject);
begin 
  with Selector.Wall do begin 
    WallTransparent.Checked := Transparent;
    WallVisible.Checked     := Visible;
    WallDark3D.Checked      := Dark3D;
    CreateColorBitmap(WallColor, Color);
    WallGradient.Tag     := Integer(Gradient);
    WallBorder.Tag       := Integer(Pen);
    WallGradient.Visible := Selector.Wall = DBChart1.BackWall;
  end;
end;

procedure TChartDesigner.WallDark3DClick(Sender: TObject);
begin 
  Selector.Wall.Dark3D := ToogleModified(WallDark3D);
end;

procedure TChartDesigner.Edit3Click(Sender: TObject);
begin 
  with ChartEditor1 do begin
    DefaultTab := cetWalls;
    Execute;
  end;
  TeeModified;
end;

procedure TChartDesigner.PopupLinePatternClick(Sender: TObject);
begin 
  if EditChartBrush(Self, Selector.Series.Brush) then TeeModified;
end;

procedure TChartDesigner.BarEllipseClick(Sender: TObject);
begin 
  TCustomBarSeries(Selector.Series).BarStyle := TBarStyle((Sender As TMenuItem).MenuIndex);
  TeeModified;
end;

procedure TChartDesigner.BarUseOriginClick(Sender: TObject);
begin 
  TCustomBarSeries(Selector.Series).UseYOrigin := ToogleModified(Sender As TMenuItem);
end;

procedure TChartDesigner.PopupBarPopup(Sender: TObject);
begin 
  with Selector.Series As TCustomBarSeries do begin 
    BarBorder.Tag          := Integer(Pen);
    BarPattern.Tag         := Integer(Brush);
    BarGradient.Tag        := Integer(Gradient);
    BarWidthItem.Tag       := BarWidthPercent;
    BarUseOrigin.Checked   := UseYOrigin;
    BarStyleItem.Items[Ord(BarStyle)].Checked := true;
    BarSideMargins.Checked := SideMargins;
  end;
end;

procedure TChartDesigner.BarGradientClick(Sender: TObject);
begin 
  if EditTeeGradient(Self, TCustomBarSeries(Selector.Series).Gradient, true, true) then TeeModified;
end;

function TChartDesigner.InputInteger(const St: string; const Num: Integer): Integer;
var 
  Old: Integer;
  tmp: string;
begin 
  Old := Num;
  tmp := IntToStr(Num);
  if InputQuery(ConstMsg_EnterValue, St, tmp) then begin 
    Result := FastFuncs.StrToInt(tmp);
    if Old <> Result then TeeModified;
  end else Result := Num;
end;

procedure TChartDesigner.BarWidthItemClick(Sender: TObject);
begin 
  with TCustomBarSeries(Selector.Series) do begin 
    BarWidthPercent           := InputInteger(ConstMsg_BarWidth, BarWidthPercent);
    (Sender As TMenuItem).Tag := BarWidthPercent;
  end;
end;

procedure TChartDesigner.AxisMinorGridClick(Sender: TObject);
begin 
  if EditChartPen(Self, Selector.Part.AAxis.MinorGrid) then TeeModified;
end;

procedure TChartDesigner.AxisVisibleClick(Sender: TObject);
begin 
  Selector.Part.AAxis.Visible := ToogleModified(Sender As TMenuItem);
end;

procedure TChartDesigner.BarSideMarginsClick(Sender: TObject);
begin 
  TCustomBarSeries(Selector.Series).SideMargins := ToogleModified(Sender As TMenuItem);
end;

procedure TChartDesigner.PopupPiePopup(Sender: TObject);
begin
  with Selector.Series As TPieSeries do begin 
    PieBorder.Tag       := Integer(Pen);
    PiePatterns.Checked := UsePatterns;
    PieDark3D.Checked   := Dark3D;
    PieCircled.Checked  := Circled;
    PieRotation.Tag     := RotationAngle;
  end;
end;

procedure TChartDesigner.PieCircledClick(Sender: TObject);
begin 
  TPieSeries(Selector.Series).Circled := ToogleModified(Sender As TMenuItem);
end;

procedure TChartDesigner.PieDark3DClick(Sender: TObject);
begin 
  TPieSeries(Selector.Series).Dark3D := ToogleModified(Sender As TMenuItem);
end;

procedure TChartDesigner.PiePatternsClick(Sender: TObject);
begin 
  TPieSeries(Selector.Series).UsePatterns := ToogleModified(Sender As TMenuItem);
end;

procedure TChartDesigner.PieRotationClick(Sender: TObject);
begin 
  with TCircledSeries(Selector.Series) do begin 
    RotationAngle := InputInteger(ConstMsg_PieRotation, RotationAngle);
    (Sender As TMenuItem).Tag := RotationAngle;
  end;
end;

procedure TChartDesigner.PopupFastLinePopup(Sender: TObject);
begin 
  with Selector.Series As TFastLineSeries do begin 
    FastLineBorder.Tag := Integer(Pen);
  end;
end;

procedure TChartDesigner.PopupPointPopup(Sender: TObject);
begin 
  with(Selector.Series As TPointSeries).Pointer do begin 
    PointDark.Checked   := Dark3D;
    PointDraw3D.Checked := Draw3D;
    PointHeight.Tag     := VertSize;
    PointWidth.Tag      := HorizSize;
    PointBorder.Tag     := Integer(Pen);
    PointStyleItem.Items[Ord(Style)].Checked := true;
  end;
end;

procedure TChartDesigner.PointDarkClick(Sender: TObject);
begin 
  TPointSeries(Selector.Series).Pointer.Dark3D := ToogleModified(Sender As TMenuItem);
end;

procedure TChartDesigner.PointDraw3DClick(Sender: TObject);
begin 
  TPointSeries(Selector.Series).Pointer.Draw3D := ToogleModified(Sender As TMenuItem);
end;

procedure TChartDesigner.PointHeightClick(Sender: TObject);
begin 
  with TPointSeries(Selector.Series).Pointer do begin 
    VertSize := InputInteger(ConstMsg_PointHeight, VertSize);
    (Sender As TMenuItem).Tag := VertSize;
  end;
end;

procedure TChartDesigner.PointWidthClick(Sender: TObject);
begin 
  with TPointSeries(Selector.Series).Pointer do begin 
    HorizSize := InputInteger(ConstMsg_PointWidth, HorizSize);
    (Sender As TMenuItem).Tag := HorizSize;
  end;
end;

procedure TChartDesigner.Smalldot1Click(Sender: TObject);
begin 
  TPointSeries(Selector.Series).Pointer.Style := TSeriesPointerStyle((Sender As TMenuItem).MenuIndex);
  TeeModified;
end;

procedure TChartDesigner.PanelView3DClick(Sender: TObject);
begin 
  DBChart1.View3D := ToogleModified(PanelView3D);
  ChartGalleryPanel1.View3D := DBChart1.View3D;
end;

procedure TChartDesigner.Colors1Click(Sender: TObject);
begin 
  DBChart1.Monochrome := false;
  DrawGrayScale := -1;
  DrawGrayInverted := false;
  DBChart1.Invalidate;
  TeeModified;
end;

procedure TChartDesigner.SetGrayScale(Method: Integer; Inverted: Boolean);
begin 
  DBChart1.Monochrome := false;
  DrawGrayScale := Method;
  DrawGrayInverted := Inverted;
  DBChart1.Invalidate;
  TeeModified;
end;

procedure TChartDesigner.GrayScale2Click(Sender: TObject);
begin 
  SetGrayScale(0, false);
end;

procedure TChartDesigner.Monochrome1Click(Sender: TObject);
begin 
  DBChart1.Monochrome := true;
  DrawGrayScale := -1;
  TeeModified;
end;

procedure TChartDesigner.DBChart1AfterDraw(Sender: TObject);
begin 
  if DrawGrayScale<>-1 then TeeGrayScale((DBChart1.Canvas As TTeeCanvas3D).Bitmap, DrawGrayInverted, DrawGrayScale);
end;

procedure TChartDesigner.GrayScaleVisual1Click(Sender: TObject);
begin 
  SetGrayScale(1, false);
end;

procedure TChartDesigner.InvertedGrayScale1Click(Sender: TObject);
begin 
  if DrawGrayScale = -1 then DrawGrayScale := 0;
  SetGrayScale(DrawGrayScale, true);
end;

procedure TChartDesigner.ChartGrid1SetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
begin 
  TeeModified;
end;

(*procedure TrimWorkingSet;
begin
var
  MainHandle: THandle;
begin
  MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
  SetProcessWorkingSetSize(MainHandle, $ffffffff, $ffffffff);
  CloseHandle(MainHandle);
end;*)

procedure TChartDesigner.PopupLineOutlineClick(Sender: TObject);
begin 
  if EditChartPen(Self, TLineSeries(Selector.Series).OutLine) then TeeModified;
end;

procedure TChartDesigner.LabelsFormat1Click(Sender: TObject);
var 
  tmp: TChartAxis;
begin 
  tmp := Selector.Part.AAxis;
  with TFormatEditor.Create(nil) do try 
      IsDate := tmp.IsDateTime;
      if IsDate then begin 
        Format := tmp.DateTimeFormat;
        if Format = '' then Format := DateTimeDefaultFormat(tmp.Maximum);
      end else Format := tmp.AxisValuesFormat;
      if ShowModal = mrOk then begin 
        if IsDate And tmp.IsDateTime then tmp.DateTimeFormat := TheFormat 
        else tmp.AxisValuesFormat := TheFormat;
        TeeModified;
      end;
    finally 
      Free;
    end;
end;

procedure TChartDesigner.BottomTabClick(Sender: TObject);
begin 
  TMenuItem(Sender).Checked := true;
end;

procedure TChartDesigner.None1Click(Sender: TObject);
begin 
  if Sender = Lower1 then DBChart1.BevelOuter := bvLowered 
  else if Sender = Raise1 then DBChart1.BevelOuter := bvRaised 
  else DBChart1.BevelOuter := bvNone;
  TeeModified;
end;

procedure TChartDesigner.MarksFontClick(Sender: TObject);
begin 
  if EditTeeFont(Self, Selector.Series.Marks.Font) then TeeModified;
end;

procedure TChartDesigner.TitleFontClick(Sender: TObject);
begin 
  if EditTeeFont(Self, Selector.SelectedTitle.Font) then TeeModified;
end;

procedure TChartDesigner.AnnoFontClick(Sender: TObject);
begin 
  if EditTeeFont(Self, Selector.Annotation.Shape.Font) then TeeModified;
end;

procedure TChartDesigner.Commander3DClick(Sender: TObject);
begin 
  Old3DEvent(TeeCommander1.Button3D);
  ChartGalleryPanel1.View3D := DBChart1.View3D;
end;

procedure TChartDesigner.FontLeftAlignClick(Sender: TObject);
begin 
  if Selector.Part.AAxis <> nil then begin 
    with Selector.Part.AAxis do if OtherSide then if Sender = FontLeftAlign then LabelsAlign := alDefault 
      else LabelsAlign := alOpposite 
      else if Sender = FontLeftAlign then LabelsAlign := alOpposite 
      else LabelsAlign := alDefault;
  end else if Selector.SelectedTitle <> nil then with Selector.SelectedTitle do if Sender = FontLeftAlign then Alignment := taLeftJustify 
    else if Sender = FontCenterAlign then Alignment := taCenter 
    else Alignment := taRightJustify;
end;

procedure TChartDesigner.Bottom2Click(Sender: TObject);
begin 
  Toogle(TMenuItem(Sender));
  if Sender = TopToolBar then ToolBar1.Align := alTop 
  else ToolBar1.Align := alBottom;
end;

procedure TChartDesigner.Whatsthis1Click(Sender: TObject);
begin 
  DefWindowProc(Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
end;

procedure TChartDesigner.ChartEditor1Show(Sender: TObject);
begin 
  Selector.DrawHandles := false;
  TeeTranslateControl(Sender As TCustomForm);
end;

procedure TChartDesigner.ChartListBox1RemovedSeries(Sender: TChartListBox; Series: TCustomChartSeries);
begin 
  if Assigned(Selector) then Selector.ClearSelection;
  TListChartView(Self.Owner).ChartSetup.LoadSeriesNameList;
  TeeModified;
end;

procedure TChartDesigner.ShapeBorderColorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var 
  Changed: Boolean;
begin 
  SelectedBorder.Color := DoEditColor(SelectedBorder.Color, Changed);
  if Changed then begin 
    ShapeBorderColor.Brush.Color := SelectedBorder.Color;
    TeeModified;
  end;
end;

procedure TChartDesigner.ComboPenStyleDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var 
  tmp: TColor;
begin 
  if (SelectedBorder <> nil) then with TControlCanvas(ComboPenStyle.Canvas) do begin 
      FillRect(Rect);
      if Index <> ComboPenStyle.Items.Count - 1 then Pen.Style := TPenStyle(Index);
      Pen.Color := SelectedBorder.Color;
      if odSelected In State then tmp := clHighlight 
      else tmp := ComboPenStyle.Color;
      if Pen.Color = ColorToRGB(tmp) then if Pen.Color = clWhite then Pen.Color := clBlack 
        else Pen.Color := clWhite;
      if IsWindowsNT And (Index = ComboPenStyle.Items.Count - 1) then Pen.Handle := TeeCreatePenSmallDots(Pen.Color);
      MoveTo(Rect.Left + 4, Rect.Top + 8);
      LineTo(Rect.Right - 4, Rect.Top + 8);
    end;
end;

procedure TChartDesigner.ComboPenStyleChange(Sender: TObject);
var 
  tmp: Boolean;
  ThePen: TPen;
begin 
  ThePen := SelectedBorder;
  if (ThePen Is TChartPen) And IsWindowsNT And (ComboPenStyle.ItemIndex = ComboPenStyle.Items.Count - 1) then begin 
    TChartPen(ThePen).SmallDots := true;
    tmp := false;
  end else begin 
    tmp          := true;
    ThePen.Style := TPenStyle(ComboPenStyle.ItemIndex);
    if ThePen Is TChartPen then TChartPen(ThePen).SmallDots := false;
  end;
  BorderWidth.Enabled := tmp;
  TeeModified(true);
end;

procedure TChartDesigner.BorderWidthChange(Sender: TObject);
begin 
  if Assigned(SelectedBorder) then begin 
    SelectedBorder.Width := BorderWidth.Position;
    TeeModified(true);
  end;
end;

procedure TChartDesigner.SetBorderToolbar;
var 
  tmp: TChartPen;
begin 
  tmp := SelectedBorder;
  if Assigned(tmp) then begin 
    ShapeBorderColor.Brush.Color := tmp.Color;
    ShapeBorderColor.Visible     := true;
    if Not ComboPenStyle.Enabled then EnableControls(true, [ComboPenStyle, BorderWidth]);
    BorderWidth.Position := tmp.Width;
    if tmp.SmallDots then begin 
      ComboPenStyle.ItemIndex := ComboPenStyle.Items.Count - 1;
      BorderWidth.Enabled := false;
    end else ComboPenStyle.ItemIndex := Ord(tmp.Style);
  end else begin 
    ShapeBorderColor.Visible := false;
    if ComboPenStyle.Enabled then EnableControls(false, [ComboPenStyle, BorderWidth]);
  end;
end;

procedure TChartDesigner.SetGalleryBorders;
var 
  t: Integer;
  tt: Integer;
  tmp: TChartSeries;
begin 
  with ChartGalleryPanel1 do for t := 0 to Charts.Count - 1 do for tt := 0 to Charts[t].SeriesCount - 1 do begin 
        tmp := Charts[t][tt];
        tmp.Pen.Visible := Borders1.Checked;
        if tmp Is TCustomSeries then TCustomSeries(tmp).Pointer.Pen.Visible := Borders1.Checked 
        else if tmp Is TCustomPolarSeries then TCustomPolarSeries(tmp).Pointer.Pen.Visible := Borders1.Checked;
      end;
end;

procedure TChartDesigner.Borders1Click(Sender: TObject);
begin 
  Toogle(Borders1);
  SetGalleryBorders;
end;

procedure TChartDesigner.Top2Click(Sender: TObject);
begin 
  Toogle(TMenuItem(Sender));
end;

procedure TChartDesigner.ChartListBox1ChangeOrder(Sender: TChartListBox; Series1, Series2: TCustomChartSeries);
begin 
  TeeModified;
end;

procedure TChartDesigner.ChartListBox1ChangeColor(Sender: TChartListBox; Series: TCustomChartSeries);
begin 
  TeeModified;
end;

procedure TChartDesigner.Options2Click(Sender: TObject);
begin 
  with TOptionsForm.Create(Self) do try 
      if ShowModal = mrOk then begin 
        Self.ChartGalleryPanel1.Smooth := TChartGalleryPanel.DefaultSmooth;
      end;
    finally 
      Free;
    end;
end;

procedure TChartDesigner.ScrollBox1Resize(Sender: TObject);
begin
  with ChartGalleryPanel1 do begin 
    NumCols := ScrollBox1.Width Div ChartGalleryWidth;
    Width   := NumCols * ChartGalleryWidth;
  end;
end;

procedure TChartDesigner.Symbol1Click(Sender: TObject);
begin 
  with ChartEditor1 do begin
    DefaultTab := cetSeriesMarks;
    Execute;
  end;
  TeeModified;
end;

procedure TChartDesigner.ChangeGalleryChartSize;
begin 
  if Small1.Checked then ChartGalleryWidth := 66 
  else ChartGalleryWidth := 100;
  ScrollBox1.Width := ChartGalleryWidth + 17;
  ChartGalleryPanel1.Height := ChartGalleryPanel1.Charts.Count * (ChartGalleryWidth - 2);
end;

procedure TChartDesigner.Small1Click(Sender: TObject);
begin 
  Toogle(Small1);
  ChangeGalleryChartSize;
end;

procedure TChartDesigner.Smooth1Click(Sender: TObject);
begin 
  ChartGalleryPanel1.Smooth := Toogle(Smooth1);
end;

procedure TChartDesigner.FormActivate(Sender: TObject);
begin 
  PerformPaints;
end;


Procedure TChartDesigner.LoadChart(Const ChartStream :TStream);
begin
  ResetChart;
  TeeModified(False);
  try
    DBChart1.Align:=alNone;

    LoadChartFromStreamCheck(TCustomChart(DBChart1),ChartStream,nil,True);

    if DBChart1.Align=alNone then
    begin
      DBChart1.Left:=0;
      DBChart1.Top:=0;
    end;

    if FindDrawLineTool<>nil then
       DrawLineTool.EnableDraw:=False;

  finally
    CreateSelector;
    SetChartMenuItems;
    ChartGalleryPanel1.View3D:=DBChart1.View3D;
    if DBChart1.SeriesCount>0 then
    begin
      ChartListBox1.SelectedSeries:=DBChart1[0];
      ChartListBox1Click(Self);
    end;
    ChartPageNavigator1.EnableButtons;
    Selector.ClearSelection;
  end;
  TListChartView(Self.Owner).ChartPrintOptions.TeePreviewPanel1.Refresh;
  TListChartView(Self.Owner).ChartSetup.LoadSeriesNameList;
  TeeModified(False);
  TListChartView(Self.Owner).ChartSetup.DoCustomFilter;
end;

procedure TChartDesigner.SBSeriesDataClick(Sender: TObject);
begin
  TListChartView(Self.Owner).ChartViewTabs.ActivePage := TListChartView(Self.Owner).tabSetup;
  TListChartView(Self.Owner).pnlActiveForm.Caption := 'Data Setup';
  TListChartView(Self.Owner).ChartSetup.EnableSeriesDataChange;
  TListChartView(Self.Owner).ChartSetup.SubForm.Invalidate;
  { TODO : Add Series Name to Series Combo }
end;

initialization
  RegisterClassOnce(TChartDesigner);
end.

