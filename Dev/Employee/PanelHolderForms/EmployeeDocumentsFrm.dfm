inherited frmEmployeeDocuments: TfrmEmployeeDocuments
  Left = 83
  Top = 142
  HelpContext = 270000
  Caption = 'Employee Documents'
  ClientHeight = 477
  ClientWidth = 940
  OldCreateOrder = True
  ExplicitLeft = 83
  ExplicitTop = 142
  ExplicitWidth = 956
  ExplicitHeight = 516
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 477
    Width = 940
    HelpContext = 270011
    ExplicitTop = 766
    ExplicitWidth = 1122
  end
  inherited shapehint: TShape
    Left = 7
    ExplicitLeft = 7
  end
  inherited shapehintextra1: TShape
    Left = 42
    ExplicitLeft = 42
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 940
    Height = 477
    HelpContext = 270001
    Align = alClient
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      940
      477)
    object pnlDocumentsInner: TDNMPanel
      Left = 0
      Top = 5
      Width = 936
      Height = 469
      HelpContext = 270012
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Splitter1: TSplitter
        Left = 0
        Top = 228
        Width = 936
        Height = 4
        Cursor = crVSplit
        HelpContext = 270013
        Align = alTop
        ExplicitTop = 241
        ExplicitWidth = 918
      end
      object pnlDocumentsList: TDNMPanel
        Left = 0
        Top = 0
        Width = 936
        Height = 228
        HelpContext = 270014
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Constraints.MinHeight = 162
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          936
          228)
        object Label2: TLabel
          Left = 754
          Top = 13
          Width = 178
          Height = 13
          HelpContext = 270016
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Double click to open correspondence'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object grdCorrespondence: TwwDBGrid
          Left = 9
          Top = 37
          Width = 811
          Height = 188
          HelpContext = 270018
          ControlType.Strings = (
            'active;CheckBox;T;F'
            'Active;CheckBox;T;F')
          Selected.Strings = (
            'Ref_Date'#9'18'#9'Date'#9'F'
            'Ref_type'#9'6'#9'Type'#9'F'
            'Referencetxt'#9'23'#9'Reference'#9'F'
            'MessageFrom'#9'15'#9'From'#9'F'
            'MessageTo'#9'15'#9'To'#9'F'
            'Status'#9'7'#9'Status'#9'F'
            'active'#9'1'#9'Active'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          OnRowChanged = grdCorrespondenceRowChanged
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clWhite
          DataSource = DSReference
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnDblClick = grdCorrespondenceDblClick
          FooterColor = clWhite
          FooterCellColor = clWhite
          object btnDeleteCorrespondence: TwwIButton
            Left = 0
            Top = 0
            Width = 21
            Height = 25
            HelpContext = 270019
            AllowAllUp = True
            Glyph.Data = {
              26040000424D2604000000000000360000002800000012000000120000000100
              180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
              636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
              7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
              00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
              FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
              000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
              D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
              0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
              FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
              D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
              00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
              00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
              0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
              E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
              AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
              07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
              0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
              00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
              FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
              FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
              007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
              CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
              0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
              FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
              1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
              C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
              D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
              E0E3FFFFFFFFFFFF0000}
            OnClick = btnDeleteCorrespondenceClick
          end
        end
        object btnGetEmails: TDNMSpeedButton
          Left = 10
          Top = 5
          Width = 87
          Height = 28
          HelpContext = 270020
          Caption = 'Get Emails'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = btnGetEmailsClick
        end
        object chkShowInactiveCorrespondence: TCheckBox
          Left = 125
          Top = 11
          Width = 184
          Height = 17
          HelpContext = 270021
          Caption = 'Show Inactive Documents'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = chkShowInactiveCorrespondenceClick
        end
        object Letterbtn: TDNMSpeedButton
          Left = 831
          Top = 36
          Width = 101
          Height = 31
          HelpContext = 270008
          Anchors = [akTop, akRight]
          Caption = '&Letter'
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          AutoDisableParentOnclick = True
          OnClick = LetterbtnClick
        end
        object Emailbtn: TDNMSpeedButton
          Left = 831
          Top = 74
          Width = 101
          Height = 31
          HelpContext = 270009
          Anchors = [akTop, akRight]
          Caption = '&Email'
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          AutoDisableParentOnclick = True
          OnClick = EmailbtnClick
        end
        object btnFax: TDNMSpeedButton
          Left = 831
          Top = 150
          Width = 101
          Height = 31
          HelpContext = 270010
          Anchors = [akTop, akRight]
          Caption = '&Fax'
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 5
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = btnFaxClick
        end
        object chkShowAllCorrespondence: TCheckBox
          Left = 376
          Top = 11
          Width = 184
          Height = 17
          HelpContext = 270022
          Caption = 'Show All Documents'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = chkShowAllCorrespondenceClick
        end
        object btnSMS: TDNMSpeedButton
          Left = 831
          Top = 112
          Width = 101
          Height = 31
          HelpContext = 270026
          Anchors = [akTop, akRight]
          Caption = 'SMS'
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 7
          AutoDisableParentOnclick = True
          OnClick = btnSMSClick
        end
      end
      object pnlDocumentsMessage: TDNMPanel
        Left = 0
        Top = 232
        Width = 936
        Height = 237
        HelpContext = 270023
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          936
          237)
        object HtmlViewer: THtmlViewer
          Left = 8
          Top = 2
          Width = 919
          Height = 168
          HelpContext = 270024
          TabOrder = 0
          Anchors = [akLeft, akTop, akRight, akBottom]
          BorderStyle = htFocused
          CharSet = DEFAULT_CHARSET
          DefBackground = clWhite
          DefFontName = 'Arial'
          DefFontSize = 9
          DefPreFontName = 'Courier New'
          HistoryMaxCount = 0
          NoSelect = False
          PrintMarginBottom = 2.000000000000000000
          PrintMarginLeft = 2.000000000000000000
          PrintMarginRight = 2.000000000000000000
          PrintMarginTop = 2.000000000000000000
          PrintScale = 1.000000000000000000
          QuirksMode = qmDetect
          OnHotSpotClick = HtmlViewerHotSpotClick
          OnImageRequest = HtmlViewerImageRequest
        end
        object lvAttachments: TListView
          Left = 8
          Top = 177
          Width = 922
          Height = 56
          HelpContext = 270025
          Anchors = [akLeft, akRight, akBottom]
          Columns = <>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Items.ItemData = {
            051A0000000100000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000
            0000}
          ParentFont = False
          TabOrder = 1
          ViewStyle = vsSmallIcon
          ExplicitWidth = 904
        end
      end
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200A000B40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object DSReference: TDataSource
    DataSet = qryreference
    Left = 837
    Top = 94
  end
  object qryDocPath: TERPQuery
    SQL.Strings = (
      'Select DPID, DocumentPath FROM tblDocPath limit 0;')
    Left = 834
    Top = 52
  end
  object WordApplication1: TWordApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 833
    Top = 13
  end
  object qryreference: TERPQuery
    SQL.Strings = (
      'Select * '
      'From tblreference'
      'Where (EmployeeID = :xID)'
      'AND (IsNull(ContactID) or (ContactID < 1)) '
      'AND (IsNull(CusID) or (CusID < 1))'
      'AND (IsNull(SupID) or (SupID < 1))')
    Filtered = True
    Filter = 'Active ='#39'T'#39
    Left = 887
    Top = 181
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryreferenceRef_Date: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'Ref_Date'
    end
    object qryreferenceRef_type: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'Ref_type'
      FixedChar = True
      Size = 50
    end
    object qryreferenceReferencetxt: TWideStringField
      DisplayLabel = 'Reference'
      DisplayWidth = 30
      FieldName = 'Referencetxt'
      FixedChar = True
      Size = 50
    end
    object qryreferenceRefID: TAutoIncField
      FieldName = 'RefID'
      ReadOnly = True
      Visible = False
    end
    object qryreferenceContactID: TIntegerField
      FieldName = 'ContactID'
      Visible = False
    end
    object qryreferenceCusID: TIntegerField
      FieldName = 'CusID'
      Visible = False
    end
    object qryreferenceSupID: TIntegerField
      FieldName = 'SupID'
      Visible = False
    end
    object qryreferenceEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryreferenceEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryreferenceOtherContactID: TIntegerField
      FieldName = 'OtherContactID'
      Visible = False
    end
    object qryreferenceGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryreferenceLoyaltyProgram: TWideStringField
      FieldName = 'LoyaltyProgram'
      FixedChar = True
      Size = 1
    end
    object qryreferencemsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryreferencemsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryreferenceActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryreferenceReferenceData: TBlobField
      FieldName = 'ReferenceData'
    end
    object qryreferenceMessageId: TWideStringField
      FieldName = 'MessageId'
      Size = 255
    end
    object qryreferenceMessageFrom: TWideStringField
      FieldName = 'MessageFrom'
      Size = 255
    end
    object qryreferenceMessageTo: TWideStringField
      FieldName = 'MessageTo'
      Size = 255
    end
    object qryreferenceStatus: TWideStringField
      FieldName = 'Status'
    end
  end
end
