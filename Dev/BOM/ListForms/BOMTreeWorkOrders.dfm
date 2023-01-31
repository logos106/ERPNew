inherited BOMTreeWorkOrdersGUI: TBOMTreeWorkOrdersGUI
  Left = 313
  Top = 149
  Caption = 'BOM Work Orders'
  ExplicitLeft = 313
  ExplicitTop = 149
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1379002
  inherited lblSkingroupMsg: TLabel
    Top = 280
    ExplicitTop = 280
    ExplicitWidth = 1019
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  inherited shapehintextra1: TShape
    Left = 55
    ExplicitLeft = 55
  end
  inherited pnlTop: TDNMPanel
    HelpContext = 1379008
    inherited lblFrom: TLabel
      Left = 794
      Visible = True
      ExplicitLeft = 794
    end
    inherited lblTo: TLabel
      Left = 916
      Visible = True
      ExplicitLeft = 916
    end
    inherited cboDateRange: TComboBox
      Left = 830
      Visible = True
      ExplicitLeft = 830
    end
    inherited dtFrom: TwwDBDateTimePicker
      Left = 830
      Visible = True
      ExplicitLeft = 830
    end
    inherited dtTo: TwwDBDateTimePicker
      Left = 933
      Visible = True
      ExplicitLeft = 933
    end
    inherited pnlSearch: TPanel
      HelpContext = 1379009
      inherited edtSearch: TEdit
        Width = 199
        ExplicitWidth = 199
        HelpContext = 1379003
      end
      inherited btnGo: TDNMSpeedButton
        Left = 677
        ExplicitLeft = 677
      end
      object chkAlternateRowcolor: TCheckBox
        Left = 718
        Top = 1
        Width = 155
        Height = 31
        Align = alRight
        Caption = 'Change Colour on Alternate Sales/Product'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        WordWrap = True
        OnClick = chkAlternateRowcolorClick
        HelpContext = 1379004
      end
    end
    inherited pnlTitle: TDNMPanel
      Left = 265
      Anchors = []
      ExplicitLeft = 265
      HelpContext = 1379010
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'BOM Work Orders'
          ExplicitTop = 1
          HelpContext = 1379005
        end
      end
    end
  end
  inherited Tree: TVirtualStringTree
    Height = 187
    Header.AutoSizeIndex = 0
    Header.Font.Charset = ANSI_CHARSET
    Header.Font.Height = -12
    Header.Font.Name = 'Arial'
    Header.Font.Style = [fsBold]
    Header.Height = 40
    Header.MainColumn = 0
    Header.Options = [hoColumnResize, hoDrag, hoVisible]
    Header.Style = hsXPStyle
    TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect]
    OnAfterItemPaint = TreeAfterItemPaint
    OnBeforeCellPaint = TreeBeforeCellPaint
    ExplicitHeight = 187
    Columns = <
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 0
        Width = 150
        WideText = 'Tree'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 1
        Width = 150
        WideText = 'Total Man Qty'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 2
        Width = 150
        WideText = 'Process'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 3
        Width = 100
        WideText = 'Process Duration'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 4
        Width = 100
        WideText = 'Total Duration'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 5
        WideText = 'Sale #'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 6
        Width = 110
        WideText = 'Product'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 7
        Width = 80
        WideText = 'UOM'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 8
        Width = 100
        WideText = 'Qty Sold'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 9
        Width = 100
        WideText = 'Qty Shipped'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 10
        Width = 100
        WideText = 'Back Order'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 11
        Width = 10
        WideText = 'SequenceDown'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 12
        Width = 110
        WideText = 'Item'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 13
        Width = 100
        WideText = 'DurationinSec'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 14
        Width = 100
        WideText = 'TotalDurationinSec'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 15
        Width = 70
        WideText = 'parentID'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 16
        Width = 70
        WideText = 'proctreeId'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 17
        Width = 250
        WideText = 'childrenIDs'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 18
        Width = 250
        WideText = 'IsSalesRootrec'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 19
        Width = 250
        WideText = 'ProctreeCtr'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 20
        WideText = 'SaleLineId'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 21
        Width = 100
        WideText = 'RowColorIndex'
      end>
    HelpContext = 1379006
  end
  inherited pnlBottom: TDNMPanel
    HelpContext = 1379011
    inherited btnCustomize: TDNMSpeedButton
      Left = 205
      Anchors = []
      ExplicitLeft = 205
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 336
      Anchors = []
      ExplicitLeft = 336
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 467
      Anchors = []
      ExplicitLeft = 467
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 597
      Anchors = []
      ExplicitLeft = 597
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 728
      Anchors = []
      ExplicitLeft = 728
    end
  end
  inherited Memo1: TMemo
    Top = 280
    Height = 212
    ExplicitTop = 280
    ExplicitHeight = 212
    HelpContext = 1379007
  end
  inherited tmrProcessMessage: TTimer
    Left = 436
    Top = 184
  end
  inherited tmrdelay: TTimer
    Left = 472
    Top = 184
  end
  inherited popSpelling: TPopupMenu
    Left = 221
    Top = 184
  end
  inherited tmrdelayMsg: TTimer
    Left = 508
    Top = 184
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 293
    Top = 184
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 257
    Top = 184
  end
  inherited MyConnection: TERPConnection
    Server = 'Localhost'
    Connected = True
    Left = 42
    Top = 151
  end
  inherited DataState: TDataState
    Left = 616
    Top = 184
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 149
    Top = 184
  end
  inherited imgsort: TImageList
    Left = 580
    Top = 184
    Bitmap = {
      494C01010200D800D80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryCustomField: TERPQuery
    Left = 42
    Top = 184
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 544
    Top = 184
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 185
    Top = 184
  end
  inherited qryMemTrans: TERPQuery
    Left = 77
    Top = 184
  end
  inherited PrintDialog: TPrintDialog
    Left = 329
    Top = 184
  end
  inherited PrinterSetupDialog: TPrinterSetupDialog
    Left = 364
    Top = 184
  end
  inherited dlgSave: TSaveDialog
    Left = 400
    Top = 184
  end
  object qryMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select '
      'distinct '
      'PP.ID as PPID,'
      
        'replace(Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)),'#39','#39' , '#39'\n' +
        #39') CaptionIntend,'
      
        'concat_ws('#39','#39',S.saleID,SL.saleLineId, PT.ProctreeId, PP.ID) as K' +
        'eyStr,'
      
        'SL.saleId, SL.saleLineId, SL.productName, concat(SL.UnitofMeasur' +
        'eSaleLines ,  '#39'('#39' , SL.UnitofMeasureMultiplier,'#39')'#39' ) as UOM,  '
      
        'SL.UnitofMeasureQtySold, SL.UnitofMeasureShipped, SL.UnitofMeasu' +
        'reBackorder , PT.SequenceDown,'
      'PT.Caption , PP.Duration , '
      ' (PT.TotalQty/PT.Quantity )* PT.ManufactureQty TotalManQty, '
      
        ' (PT.TotalQty/PT.Quantity )* PT.ManufactureQty *PP.Duration as T' +
        'otalDuration,'
      
        'PT.parentID, Pt.proctreeId,  GROUP_CONCAT(distinct CPT.ProctreeI' +
        'd) as childrenIDs  , PS.description , '
      'Sum(PCT.Duration) TotalScheduled , '
      
        'Sum(if(ProcessPartStatusToNo(ifnull(PCT.status,PP.status))>=3 , ' +
        'PCT.Duration , 0)) totalStarted , '
      
        'ifnull(Sum(if(ProcessPartStatusToNo(ifnull(ifnull(PCT.status,PP.' +
        'status),'#39#39'))<3 , PCT.Duration , 0)),0) +if(ifnull(PCT.Processtim' +
        'eID,0) = 0 ,  (PT.TotalQty/PT.Quantity )* PT.ManufactureQty *PP.' +
        'Duration,0) ToBedone, '
      'Min(PCT.timeStart)  as AllocatedFrom,'
      
        '#Max(ADDDATE(PCT.timeStart,INTERVAL PCT.Duration second) )  as A' +
        'llocatedto'
      'Max(PCT.timeStart)  as Allocatedto , '
      
        'ProcessPartStatusNoToStr(Min(ProcessPartStatusToNo(ifnull(PCT.st' +
        'atus,PP.status)))) CurrentStatus'
      'From '
      'tblsales S'
      'inner join tblsaleslines SL on SL.saleId = S.SaleId'
      
        'inner join tblproctree PT on SL.saleLineId = PT.MasterId and PT.' +
        'MasterType <> '#39'mtProduct'#39
      'Left join tblProcessPart PP on PT.ProcTreeId = PP.ProctreeId '
      
        'Left join ( tblproctree CPT inner join tblProcessPart CPP on CPT' +
        '.ProcTreeId = CPP.ProctreeId ) on  CPT.parentId = PT.ProcTreeId'
      'Left join tblProcessStep PS on PP.ProcessStepId = PS.ID'
      
        'Left join tblProcesstime PCT on PCT.ProcessPartID = PP.ID and PC' +
        'T.timestart > '#39'1899-12-30 00:00:00'#39' '
      'Where   S.saleDate between :DateFrom and :DateTo'
      'and S.converted ="F"'
      'group by PT.ProcTreeId, PP.id'
      'having not(PPID is null) or not(ChildrenIds is null)'
      'Order by SaleId, SaleLineId , Sequencedown')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 113
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'DateTo'
      end>
    object qryMainPPID: TIntegerField
      FieldName = 'PPID'
    end
    object qryMainsaleId: TIntegerField
      FieldName = 'saleId'
    end
    object qryMainsaleLineId: TIntegerField
      FieldName = 'saleLineId'
    end
    object qryMainproductName: TWideStringField
      FieldName = 'productName'
      Size = 60
    end
    object qryMainUOM: TWideStringField
      FieldName = 'UOM'
      Size = 279
    end
    object qryMainUnitofMeasureQtySold: TFloatField
      FieldName = 'UnitofMeasureQtySold'
    end
    object qryMainUnitofMeasureShipped: TFloatField
      FieldName = 'UnitofMeasureShipped'
    end
    object qryMainUnitofMeasureBackorder: TFloatField
      FieldName = 'UnitofMeasureBackorder'
    end
    object qryMainSequenceDown: TIntegerField
      FieldName = 'SequenceDown'
    end
    object qryMainCaption: TWideStringField
      FieldName = 'Caption'
      Size = 255
    end
    object qryMainDuration: TFloatField
      FieldName = 'Duration'
    end
    object qryMainparentID: TIntegerField
      FieldName = 'parentID'
    end
    object qryMainproctreeId: TIntegerField
      FieldName = 'proctreeId'
    end
    object qryMainchildrenIDs: TBlobField
      FieldName = 'childrenIDs'
    end
    object qryMaindescription: TWideStringField
      FieldName = 'description'
      Size = 255
    end
    object qryMainKeyStr: TWideStringField
      FieldName = 'KeyStr'
      Size = 53
    end
    object qryMainCaptionIntend: TWideMemoField
      FieldName = 'CaptionIntend'
      BlobType = ftWideMemo
    end
    object qryMainTotalDuration: TFloatField
      FieldName = 'TotalDuration'
    end
    object qryMainTotalManQty: TFloatField
      FieldName = 'TotalManQty'
    end
    object qryMainTotalScheduled: TFloatField
      FieldName = 'TotalScheduled'
    end
    object qryMaintotalStarted: TFloatField
      FieldName = 'totalStarted'
    end
    object qryMainToBedone: TFloatField
      FieldName = 'ToBedone'
    end
    object qryMainAllocatedFrom: TDateTimeField
      FieldName = 'AllocatedFrom'
    end
    object qryMainAllocatedto: TDateTimeField
      FieldName = 'Allocatedto'
    end
    object qryMainCurrentStatus: TWideStringField
      FieldName = 'CurrentStatus'
    end
  end
end
