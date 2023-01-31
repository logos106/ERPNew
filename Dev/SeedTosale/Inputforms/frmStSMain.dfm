inherited fmStSMain: TfmStSMain
  Left = 269
  Top = 214
  Caption = 'Seed To Sale'
  ClientHeight = 533
  ClientWidth = 1234
  ExplicitWidth = 1240
  ExplicitHeight = 562
  DesignSize = (
    1234
    533)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 380
    Width = 1234
    ExplicitTop = 448
    ExplicitWidth = 1234
  end
  inherited shapehint: TShape
    Left = 15
    ExplicitLeft = 15
  end
  inherited shapehintextra1: TShape
    Left = 74
    ExplicitLeft = 74
  end
  object lblmsg: TLabel [5]
    Left = 0
    Top = 380
    Width = 1234
    Height = 15
    Align = alBottom
    Alignment = taCenter
    Visible = False
    WordWrap = True
    ExplicitWidth = 3
  end
  object pnlOptions: TDNMPanel [6]
    Left = 0
    Top = 395
    Width = 1234
    Height = 100
    HelpContext = 753114
    Align = alBottom
    BevelInner = bvLowered
    BevelKind = bkFlat
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  inherited pnlFooter: TDNMPanel
    Top = 495
    Width = 1234
    Height = 38
    ExplicitTop = 495
    ExplicitWidth = 1234
    ExplicitHeight = 38
    DesignSize = (
      1234
      38)
    inherited btnCompleted: TDNMSpeedButton
      Left = 229
      Top = 6
      Visible = False
      OnClick = btnCompletedClick
      ExplicitLeft = 229
      ExplicitTop = 6
    end
    inherited btnClose: TDNMSpeedButton
      Left = 574
      Top = 6
      OnClick = btnCloseClick
      ExplicitLeft = 574
      ExplicitTop = 6
    end
  end
  inherited pnlHeader: TDNMPanel
    Width = 1234
    Height = 131
    ExplicitWidth = 1234
    ExplicitHeight = 131
    inherited pnlTitle: TDNMPanel
      Left = 451
      Top = 5
      Width = 331
      Height = 53
      Caption = ''
      ExplicitLeft = 451
      ExplicitTop = 5
      ExplicitWidth = 331
      ExplicitHeight = 53
      inherited TitleShader: TShader
        Width = 329
        Height = 51
        ExplicitWidth = 329
        ExplicitHeight = 51
        inherited TitleLabel: TLabel
          Width = 329
          Height = 51
          Caption = 'Seed To Sale'
          Font.Height = -48
          ExplicitLeft = -1
          ExplicitWidth = 379
          ExplicitHeight = 41
        end
      end
    end
    object pnlLeftTop: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 28
      Width = 378
      Height = 100
      HelpContext = 753110
      Margins.Left = 2
      Margins.Top = 27
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      BevelInner = bvLowered
      BevelKind = bkFlat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object DNMPanel1: TDNMPanel
        Left = 2
        Top = 2
        Width = 126
        Height = 92
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Visible = False
        object grdDeptClasss: TwwDBGrid
          Left = 1
          Top = 1
          Width = 124
          Height = 45
          HelpContext = 753019
          Margins.Left = 2
          Margins.Top = 1
          Margins.Right = 123
          LineStyle = glsSingle
          ControlType.Strings = (
            'Complete;CheckBox;T;F')
          Selected.Strings = (
            'ClassName'#9'60'#9'Department'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = False
          ShowVertScrollBar = False
          Align = alBottom
          DataSource = dsDeptClass
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          FooterColor = clWhite
          object wwIButton2: TwwIButton
            Left = 0
            Top = 0
            Width = 0
            Height = 22
            HelpContext = 753020
            AllowAllUp = True
          end
        end
        object grdEmployees: TwwDBGrid
          Left = 1
          Top = 46
          Width = 124
          Height = 45
          HelpContext = 753019
          Margins.Left = 2
          Margins.Top = 1
          Margins.Right = 123
          LineStyle = glsSingle
          ControlType.Strings = (
            'Complete;CheckBox;T;F')
          Selected.Strings = (
            'EmployeeName'#9'34'#9'User'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = False
          ShowVertScrollBar = False
          Align = alBottom
          DataSource = dsEmployee
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
          ParentColor = True
          ParentFont = False
          TabOrder = 1
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          FooterColor = clWhite
          object wwIButton1: TwwIButton
            Left = 0
            Top = 0
            Width = 0
            Height = 22
            HelpContext = 753020
            AllowAllUp = True
          end
        end
      end
      object DNMPanel3: TDNMPanel
        Left = 128
        Top = 2
        Width = 126
        Height = 92
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object DNMPanel4: TDNMPanel
          AlignWithMargins = True
          Left = 4
          Top = 47
          Width = 118
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label3: TLabel
            Left = 0
            Top = 0
            Width = 118
            Height = 15
            HelpContext = 753107
            Align = alTop
            Caption = 'User'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            WordWrap = True
            ExplicitWidth = 27
          end
          object wwDBEdit2: TwwDBEdit
            Left = 1
            Top = 16
            Width = 114
            Height = 23
            DataField = 'EmployeeName'
            DataSource = dsEmployee
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
        end
        object DNMPanel5: TDNMPanel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 118
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label2: TLabel
            Left = 0
            Top = 0
            Width = 118
            Height = 15
            HelpContext = 753107
            Align = alTop
            Caption = 'Department'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            WordWrap = True
            ExplicitWidth = 67
          end
          object wwDBEdit1: TwwDBEdit
            Left = 1
            Top = 16
            Width = 114
            Height = 23
            DataField = 'ClassName'
            DataSource = dsDeptClass
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
        end
      end
    end
    object pnlRightTop: TDNMPanel
      AlignWithMargins = True
      Left = 853
      Top = 28
      Width = 378
      Height = 100
      HelpContext = 753114
      Margins.Left = 2
      Margins.Top = 27
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      BevelInner = bvLowered
      BevelKind = bkFlat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object DNMPanel2: TDNMPanel
      AlignWithMargins = True
      Left = 386
      Top = 62
      Width = 462
      Height = 65
      Margins.Top = 61
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 460
        Height = 15
        HelpContext = 753107
        Align = alTop
        Alignment = taCenter
        Caption = 'Scan the Tag'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 73
      end
      object edtBarcodeInput: TEdit
        AlignWithMargins = True
        Left = 4
        Top = 17
        Width = 454
        Height = 44
        HelpContext = 753108
        Align = alBottom
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnExit = edtBarcodeInputExit
        OnKeyDown = edtBarcodeInputKeyDown
        OnKeyPress = edtBarcodeInputKeyPress
      end
    end
  end
  inherited pnlDetails: TDNMPanel
    Top = 131
    Width = 1234
    Height = 249
    ExplicitTop = 131
    ExplicitWidth = 1234
    ExplicitHeight = 249
    object grdTags: TwwDBGrid
      Left = 1
      Top = 1
      Width = 1232
      Height = 247
      ControlType.Strings = (
        'PhaseChanged;CheckBox;T;F'
        'TagReplaced;CheckBox;T;F'
        'TagWasted;CheckBox;T;F')
      Selected.Strings = (
        'StsTag'#9'10'#9'Tag'#9#9
        'StSPhaseDesc'#9'12'#9'Phase'#9'F'#9
        'SourceTag'#9'10'#9'Resource'#9#9
        'Sourcetype'#9'10'#9'Type'#9'F'#9
        'Dept'#9'15'#9'Facility'#9#9
        'UsedOn'#9'12'#9'Used On'#9#9
        'StrainName'#9'18'#9'Strain'#9#9
        'TagReplaceto'#9'18'#9'Tag~Replace To'#9#9
        'Plantcount'#9'6'#9'Total'#9#9
        'WastedCount'#9'10'#9'Wasted'#9#9
        'ChangedCount'#9'10'#9'Changed'#9#9
        'Destroycount'#9'10'#9'Destroyed'#9#9
        'TransferedCount'#9'10'#9'Transfered'#9#9
        'UsedCount'#9'10'#9'Used'#9#9
        'HarvestCount'#9'10'#9'Harvest'#9'F'
        'Activecount'#9'10'#9'Active Count'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsMain
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      OnCalcCellColors = grdTagsCalcCellColors
      FooterColor = clWhite
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 316
    Top = 224
  end
  inherited tmrdelay: TTimer
    Left = 349
    Top = 224
  end
  inherited popSpelling: TPopupMenu
    Left = 450
    Top = 224
  end
  inherited tmrdelayMsg: TTimer
    Left = 416
    Top = 224
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 550
    Top = 224
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 617
    Top = 224
  end
  inherited MyConnection: TERPConnection
    Database = 'sts_1'
    Server = 'localhost'
    Left = 82
    Top = 224
  end
  inherited DataState: TDataState
    Left = 651
    Top = 224
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 483
    Top = 224
  end
  inherited imgsort: TImageList
    Left = 684
    Top = 224
    Bitmap = {
      494C010102004801E00310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 115
    Top = 224
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 718
    Top = 224
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 517
    Top = 224
  end
  inherited qryMemTrans: TERPQuery
    Left = 148
    Top = 224
  end
  inherited tmrOnshow: TTimer
    Left = 383
    Top = 224
  end
  object c: TActionList
    Left = 584
    Top = 224
    object act_ChangePhase: TDNMAction
      Tag = 501
      Category = 'StS'
      Caption = 'act_ChangePhase'
      ImageIndex = 793
      OnExecute = act_ChangePhaseExecute
      OnUpdate = act_ChangePhaseUpdate
      buttoncolor = clWhite
    end
    object act_CreatePlantings: TDNMAction
      Tag = 502
      Category = 'StS'
      Caption = 'act_CreatePlantings'
      ImageIndex = 794
      OnExecute = act_CreatePlantingsExecute
      OnUpdate = act_CreatePlantingsUpdate
      buttoncolor = clWhite
    end
    object act_DestroyPlant: TDNMAction
      Tag = 503
      Category = 'StS'
      Caption = 'Destroy Plantings'
      ImageIndex = 795
      OnExecute = act_DestroyPlantExecute
      OnUpdate = act_DestroyPlantUpdate
      buttoncolor = clWhite
    end
    object act_RECORD_ADDITIVES: TDNMAction
      Tag = 504
      Category = 'StS'
      Caption = 'act_RECORD_ADDITIVES'
      ImageIndex = 796
      OnExecute = act_RECORD_ADDITIVESExecute
      OnUpdate = act_RECORD_ADDITIVESUpdate
      buttoncolor = clWhite
    end
    object act_RECORD_WASTE: TDNMAction
      Tag = 505
      Category = 'StS'
      Caption = 'act_RECORD_WASTE'
      ImageIndex = 797
      OnExecute = act_RECORD_WASTEExecute
      OnUpdate = act_RECORD_WASTEUpdate
      buttoncolor = clWhite
    end
    object act_TRANSFER: TDNMAction
      Tag = 506
      Category = 'StS'
      Caption = 'act_TRANSFER'
      ImageIndex = 798
      OnExecute = act_TRANSFERExecute
      OnUpdate = act_TRANSFERUpdate
      buttoncolor = clWhite
    end
    object act_MANICURE_PLANTS: TDNMAction
      Tag = 507
      Category = 'StS'
      Caption = 'act_MANICURE_PLANTS'
      ImageIndex = 799
      OnExecute = act_MANICURE_PLANTSExecute
      OnUpdate = act_MANICURE_PLANTSUpdate
      buttoncolor = clWhite
    end
    object act_CREATE_PACKAGES_PRODUCT: TDNMAction
      Tag = 508
      Category = 'StS'
      Caption = 'act_CREATE_PACKAGES_PRODUCT'
      ImageIndex = 800
      OnExecute = act_CREATE_PACKAGES_PRODUCTExecute
      OnUpdate = act_CREATE_PACKAGES_PRODUCTUpdate
      buttoncolor = clWhite
    end
    object act_REPLACE_TAGS: TDNMAction
      Tag = 509
      Category = 'StS'
      Caption = 'act_REPLACE_TAGS'
      ImageIndex = 801
      OnExecute = act_REPLACE_TAGSExecute
      OnUpdate = act_REPLACE_TAGSUpdate
      buttoncolor = clWhite
    end
    object act_CHANGE_ROOMS: TDNMAction
      Tag = 510
      Category = 'StS'
      Caption = 'act_CHANGE_ROOMS'
      ImageIndex = 802
      OnExecute = act_CHANGE_ROOMSExecute
      OnUpdate = act_CHANGE_ROOMSUpdate
      buttoncolor = clWhite
    end
    object actSerialnumbers: TDNMAction
      Category = 'StS'
      Caption = 'Choose Tags'
      ImageIndex = 400
      OnExecute = actSerialnumbersExecute
      OnUpdate = actSerialnumbersUpdate
      buttoncolor = clWhite
    end
    object actTopAction1: TDNMAction
      Category = 'StS'
      Caption = '. . . . . .'
      ImageIndex = 766
      OnExecute = actTopAction1Execute
      OnUpdate = actTopAction1Update
      buttoncolor = clWhite
    end
    object actTopAction2: TDNMAction
      Category = 'StS'
      Caption = '. . . . . .'
      ImageIndex = 766
      OnExecute = actTopAction2Execute
      OnUpdate = actTopAction2Update
      buttoncolor = clWhite
    end
    object actEmployees: TDNMAction
      Category = 'StS'
      Caption = 'Choose Employee'
      ImageIndex = 39
      OnExecute = actEmployeesExecute
      buttoncolor = clWhite
    end
    object actClass: TDNMAction
      Category = 'StS'
      Caption = 'Choose Class'
      ImageIndex = 39
      OnExecute = actClassExecute
      buttoncolor = clWhite
    end
  end
  object QryEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblemployees')
    Left = 182
    Top = 224
    object QryEmployeeEmployeeNo: TIntegerField
      FieldName = 'EmployeeNo'
    end
    object QryEmployeeEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object QryEmployeeEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
  end
  object dsEmployee: TDataSource
    DataSet = QryEmployee
    Left = 182
    Top = 256
  end
  object qryststags: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * from tblststags limit 0')
    BeforeOpen = qryststagsBeforeOpen
    AfterPost = qryststagsAfterPost
    AfterScroll = qryststagsAfterScroll
    Left = 249
    Top = 224
    object qryststagsStsTag: TWideStringField
      DisplayLabel = 'Tag'
      DisplayWidth = 20
      FieldName = 'StsTag'
      Origin = 'tblststags.StsTag'
      Size = 255
    end
    object qryststagsStSPPhaseDesc: TWideStringField
      DisplayLabel = 'Phase'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'StSPPhaseDesc'
      Calculated = True
    end
    object qryststagsDept: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 20
      FieldName = 'Dept'
      Origin = 'tblststags.Dept'
      Size = 255
    end
    object qryststagsStrainName: TWideStringField
      DisplayLabel = 'Strain'
      DisplayWidth = 20
      FieldName = 'StrainName'
      Origin = 'tblststags.StrainName'
      Size = 255
    end
    object qryststagsPlantcount: TIntegerField
      DisplayLabel = 'Plant~Count'
      DisplayWidth = 10
      FieldName = 'Plantcount'
      Origin = 'tblststags.Plantcount'
    end
    object qryststagsChangedCount: TIntegerField
      DisplayLabel = 'Changed~Count'
      DisplayWidth = 10
      FieldName = 'ChangedCount'
      Origin = 'tblststags.ChangedCount'
    end
    object qryststagsWastedCount: TIntegerField
      DisplayLabel = 'Wasted~Count'
      DisplayWidth = 10
      FieldName = 'WastedCount'
      Origin = 'tblststags.WastedCount'
    end
    object qryststagsDestroycount: TIntegerField
      DisplayLabel = 'Destroyed~Count'
      DisplayWidth = 10
      FieldName = 'Destroycount'
      Origin = 'tblststags.Destroycount'
    end
    object qryststagsTransferedCount: TIntegerField
      DisplayLabel = 'Transferred~Count'
      DisplayWidth = 10
      FieldName = 'TransferedCount'
      Origin = 'tblststags.TransferedCount'
    end
    object qryststagsUsedCount: TIntegerField
      DisplayLabel = 'Used~Count'
      DisplayWidth = 10
      FieldName = 'UsedCount'
      Origin = 'tblststags.UsedCount'
    end
    object qryststagsStSPhase: TWideStringField
      DisplayWidth = 10
      FieldName = 'StSPhase'
      Origin = 'tblststags.StSPhase'
      Visible = False
      Size = 1
    end
    object qryststagsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblststags.ID'
      Visible = False
    end
    object qryststagsGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblststags.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryststagsTagProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TagProductID'
      Origin = 'tblststags.TagProductID'
      Visible = False
    end
    object qryststagsSourceTagID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SourceTagID'
      Origin = 'tblststags.SourceTagID'
      Visible = False
    end
    object qryststagsSourceTag: TWideStringField
      DisplayWidth = 255
      FieldName = 'SourceTag'
      Origin = 'tblststags.SourceTag'
      Visible = False
      Size = 255
    end
    object qryststagsSourcetype: TWideStringField
      DisplayWidth = 255
      FieldName = 'Sourcetype'
      Origin = 'tblststags.Sourcetype'
      Visible = False
      Size = 255
    end
    object qryststagsDeptID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DeptID'
      Origin = 'tblststags.DeptID'
      Visible = False
    end
    object qryststagsUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tblststags.UOMID'
      Visible = False
    end
    object qryststagsPlanttype: TWideStringField
      DisplayWidth = 12
      FieldName = 'Planttype'
      Origin = 'tblststags.Planttype'
      Visible = False
      FixedChar = True
      Size = 12
    end
    object qryststagsUsedOn: TDateTimeField
      DisplayWidth = 18
      FieldName = 'UsedOn'
      Origin = 'tblststags.UsedOn'
      Visible = False
    end
    object qryststagsStrainID: TIntegerField
      DisplayWidth = 10
      FieldName = 'StrainID'
      Origin = 'tblststags.StrainID'
      Visible = False
    end
    object qryststagsStSProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'StSProductID'
      Origin = 'tblststags.StSProductID'
      Visible = False
    end
    object qryststagsmstimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimeStamp'
      Origin = 'tblststags.mstimeStamp'
      Visible = False
    end
    object qryststagsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblststags.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryststagsEmployeeId: TIntegerField
      FieldName = 'EmployeeId'
    end
    object qryststagsReplacedByTagID: TIntegerField
      FieldName = 'ReplacedByTagID'
    end
    object qryststagsBinID: TIntegerField
      FieldName = 'BinID'
    end
  end
  object qryStSTag_Actions: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * from tblStSTag_Actions')
    BeforeOpen = qryststagsBeforeOpen
    Left = 282
    Top = 224
    object qryStSTag_ActionsStatusDate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 18
      FieldName = 'StatusDate'
      Origin = 'tblststag_actions.StatusDate'
    end
    object qryStSTag_ActionsStatusAction: TWideStringField
      DisplayLabel = 'Action'
      DisplayWidth = 20
      FieldName = 'StatusAction'
      Origin = 'tblststag_actions.StatusAction'
      Size = 255
    end
    object qryStSTag_ActionsDescription: TWideStringField
      DisplayWidth = 85
      FieldName = 'Description'
      Origin = 'tblststag_actions.Description'
      Size = 255
    end
    object qryStSTag_ActionsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblststag_actions.ID'
      Visible = False
    end
    object qryStSTag_ActionsGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblststag_actions.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryStSTag_ActionsTagID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TagID'
      Origin = 'tblststag_actions.TagID'
      Visible = False
    end
    object qryStSTag_ActionsStatusActionId: TIntegerField
      DisplayWidth = 10
      FieldName = 'StatusActionId'
      Origin = 'tblststag_actions.StatusActionId'
      Visible = False
    end
    object qryStSTag_ActionsChangeToRoomID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ChangeToRoomID'
      Origin = 'tblststag_actions.ChangeToRoomID'
      Visible = False
    end
    object qryStSTag_ActionsReplaceTagId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ReplaceTagId'
      Origin = 'tblststag_actions.ReplaceTagId'
      Visible = False
    end
    object qryStSTag_Actionsmstimestamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimestamp'
      Origin = 'tblststag_actions.mstimestamp'
      Visible = False
    end
    object qryStSTag_ActionsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblststag_actions.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryStSTag_ActionsSMLLineID: TIntegerField
      FieldName = 'SMLLineID'
    end
    object qryStSTag_ActionsActionQty: TIntegerField
      FieldName = 'ActionQty'
    end
    object qryStSTag_ActionsTagProductID: TIntegerField
      FieldName = 'TagProductID'
    end
    object qryStSTag_ActionsStSProductID: TIntegerField
      FieldName = 'StSProductID'
    end
  end
  object qryMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Tags.ID, '
      'Tags.StsTag,'
      'Tags.SourceTag,'
      'Tags.Sourcetype,'
      'Tags.Dept,'
      'Tags.UsedOn,'
      'Tags.StrainName,'
      'Tags.Plantcount,'
      'Tags.ChangedCount,'
      'Tags.WastedCount,'
      'Tags.Destroycount,'
      'Tags.TransferedCount,'
      'Tags.UsedCount,'
      'Tags.StSPhase,'
      'Acts.StatusDate,'
      'Acts.StatusAction,'
      'Acts.Description,'
      'ReplTags.StSTag TagReplaceto'
      'FROM '
      'tblststags Tags'
      'LEFT JOIN tblStSTag_Actions Acts ON TAgs.Id = Acts.tagID'
      
        'LEFT JOIN tblststags ReplTags ON Tags.REplacedByTagID = ReplTags' +
        '.ID')
    BeforeOpen = qryMainBeforeOpen
    OnCalcFields = qryMainCalcFields
    Left = 215
    Top = 224
    object qryMainStsTag: TWideStringField
      DisplayLabel = 'Tag'
      DisplayWidth = 10
      FieldName = 'StsTag'
      Origin = 'Tags.StsTag'
      Size = 255
    end
    object qryMainStSPhaseDesc: TWideStringField
      DisplayLabel = 'Phase'
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'StSPhaseDesc'
      Size = 50
      Calculated = True
    end
    object qryMainSourceTag: TWideStringField
      DisplayLabel = 'Resource'
      DisplayWidth = 10
      FieldName = 'SourceTag'
      Origin = 'Tags.SourceTag'
      Size = 255
    end
    object qryMainSourcetype: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'Sourcetype'
      Origin = 'Tags.Sourcetype'
      Size = 255
    end
    object qryMainDept: TWideStringField
      DisplayLabel = 'Facility'
      DisplayWidth = 15
      FieldName = 'Dept'
      Origin = 'Tags.Dept'
      Size = 255
    end
    object qryMainUsedOn: TDateTimeField
      DisplayLabel = 'Used On'
      DisplayWidth = 12
      FieldName = 'UsedOn'
      Origin = 'Tags.UsedOn'
    end
    object qryMainStrainName: TWideStringField
      DisplayLabel = 'Strain'
      DisplayWidth = 18
      FieldName = 'StrainName'
      Origin = 'Tags.StrainName'
      Size = 255
    end
    object qryMainTagReplaceto: TWideStringField
      DisplayLabel = 'Tag~Replace To'
      DisplayWidth = 18
      FieldName = 'TagReplaceto'
      Origin = 'ReplTags.StsTag'
      Size = 255
    end
    object qryMainPlantcount: TIntegerField
      DisplayLabel = 'Total'
      DisplayWidth = 6
      FieldName = 'Plantcount'
      Origin = 'Tags.Plantcount'
    end
    object QrymainWastedCount: TIntegerField
      DisplayLabel = 'Wasted'
      DisplayWidth = 10
      FieldName = 'WastedCount'
      Origin = 'Tags.WastedCount'
    end
    object QrymainChangedCount: TIntegerField
      DisplayLabel = 'Changed'
      DisplayWidth = 10
      FieldName = 'ChangedCount'
      Origin = 'Tags.ChangedCount'
    end
    object QrymainDestroycount: TIntegerField
      DisplayLabel = 'Destroyed'
      DisplayWidth = 10
      FieldName = 'Destroycount'
      Origin = 'Tags.Destroycount'
    end
    object QrymainTransferedCount: TIntegerField
      DisplayLabel = 'Transfered'
      DisplayWidth = 10
      FieldName = 'TransferedCount'
      Origin = 'Tags.TransferedCount'
    end
    object QrymainUsedCount: TIntegerField
      DisplayLabel = 'Used'
      DisplayWidth = 10
      FieldName = 'UsedCount'
      Origin = 'Tags.UsedCount'
    end
    object qryMainHarvestCount: TIntegerField
      DisplayLabel = 'Harvest'
      DisplayWidth = 10
      FieldName = 'HarvestCount'
      Origin = 'Tags.HarvestCount'
    end
    object qryMainActivecount: TIntegerField
      DisplayLabel = 'Active Count'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'Activecount'
      Calculated = True
    end
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'Tags.ID'
      Visible = False
    end
    object qryMainStSPhase: TWideStringField
      DisplayLabel = 'Phase'
      DisplayWidth = 1
      FieldName = 'StSPhase'
      Origin = 'Tags.StSPhase'
      Visible = False
      Size = 1
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 215
    Top = 256
  end
  object QryDeptClass: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblclass')
    Left = 750
    Top = 224
    object QryDeptClassClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object QryDeptClassClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 60
    end
  end
  object dsDeptClass: TDataSource
    DataSet = QryDeptClass
    Left = 750
    Top = 256
  end
end
