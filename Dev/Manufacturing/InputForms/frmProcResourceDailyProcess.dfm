inherited fmProcResourceDailyProcess: TfmProcResourceDailyProcess
  Left = 337
  Top = 120
  Caption = 'Production Resource'
  ClientHeight = 537
  ClientWidth = 586
  ExplicitLeft = 337
  ExplicitTop = 120
  ExplicitWidth = 602
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 173
    Width = 586
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 68
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 151
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object Label5: TLabel [5]
    Left = 146
    Top = 121
    Width = 107
    Height = 15
    HelpContext = 189071
    Alignment = taRightJustify
    Caption = 'Resource Capacity'
    Transparent = True
  end
  object Label3: TLabel [6]
    Left = 6
    Top = 121
    Width = 94
    Height = 15
    HelpContext = 189071
    Alignment = taRightJustify
    Caption = 'No of Resources'
    Transparent = True
  end
  object Label6: TLabel [7]
    Left = 364
    Top = 121
    Width = 48
    Height = 15
    HelpContext = 189071
    Alignment = taRightJustify
    Caption = 'Process'
    Transparent = True
  end
  inherited pnltop: TDNMPanel
    Width = 586
    TabOrder = 7
    ExplicitWidth = 586
    inherited pnlTitle: TDNMPanel
      Left = 117
      Top = 8
      Width = 352
      Height = 43
      ExplicitLeft = 117
      ExplicitTop = 8
      ExplicitWidth = 352
      ExplicitHeight = 43
      inherited TitleShader: TShader
        Width = 350
        Height = 41
        ExplicitWidth = 350
        ExplicitHeight = 41
        inherited TitleLabel: TLabel
          Width = 350
          Height = 41
          ExplicitWidth = 365
          ExplicitHeight = 41
        end
      end
    end
  end
  inherited PnlRes: TDNMPanel
    Width = 586
    Height = 56
    TabOrder = 0
    ExplicitWidth = 586
    ExplicitHeight = 56
    inherited edtDescription: TwwDBEdit
      Width = 202
      Anchors = [akLeft, akTop, akRight]
      ExplicitWidth = 202
    end
    inherited chkUsedWithProductsInSeq: TDBCheckBox
      Left = 473
      Height = 48
      ExplicitLeft = 473
      ExplicitHeight = 48
    end
  end
  inherited pnlButtons: TDNMPanel
    Top = 487
    Width = 586
    TabOrder = 6
    ExplicitTop = 487
    ExplicitWidth = 586
    DesignSize = (
      586
      50)
    inherited btnSave: TDNMSpeedButton
      Left = 105
      Top = 12
      ExplicitLeft = 105
      ExplicitTop = 12
    end
    inherited btnNew: TDNMSpeedButton
      Left = 198
      Top = 12
      ExplicitLeft = 198
      ExplicitTop = 12
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 402
      Top = 12
      ExplicitLeft = 402
      ExplicitTop = 12
    end
    inherited chkActive: TwwCheckBox
      Left = 507
      Alignment = taRightJustify
      ExplicitLeft = 507
    end
    object btncleanup: TDNMSpeedButton
      Left = 300
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 189061
      Caption = 'Cleanup'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btncleanupClick
    end
  end
  inherited cboProcessStepDesc: TwwDBLookupCombo
    Left = 364
    Top = 141
    Width = 183
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    ExplicitLeft = 364
    ExplicitTop = 141
    ExplicitWidth = 183
  end
  object cboUnitOfMeasure: TwwDBLookupCombo [12]
    Left = 233
    Top = 141
    Width = 94
    Height = 23
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'UnitName'#9'15'#9'UnitName'#9'F')
    DataField = 'UOMDetails'
    DataSource = dsProcResourceDetails
    LookupTable = qryUnitOfMeasure
    LookupField = 'UnitID'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 3
    AutoDropDown = True
    ShowButton = True
    UseTFields = False
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboUnitOfMeasureCloseUp
  end
  object wwDBEdit1: TwwDBEdit [13]
    Left = 146
    Top = 141
    Width = 85
    Height = 23
    HelpContext = 189076
    DataField = 'UOMQty'
    DataSource = dsProcResourceDetails
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBSpinEdit1: TwwDBSpinEdit [14]
    Left = 6
    Top = 141
    Width = 85
    Height = 23
    Increment = 1.000000000000000000
    DataField = 'NoOfResources'
    DataSource = dsProcResourceDetails
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UnboundDataType = wwDefault
  end
  inherited pnlcolorDetails: TDNMPanel
    AlignWithMargins = True
    Left = 3
    Top = 232
    Width = 580
    Height = 252
    Align = alBottom
    TabOrder = 5
    ExplicitLeft = 3
    ExplicitTop = 232
    ExplicitWidth = 580
    ExplicitHeight = 252
    inherited lblNoOfResources: TLabel
      Top = 233
      Width = 542
      Margins.Right = 33
      ExplicitLeft = 543
      ExplicitTop = 233
    end
    object Label4: TLabel [1]
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 572
      Height = 15
      HelpContext = 189071
      Align = alTop
      Caption = 'Product Codes'
      Transparent = True
      ExplicitWidth = 84
    end
    object lblMsg: TLabel [2]
      AlignWithMargins = True
      Left = 4
      Top = 214
      Width = 542
      Height = 15
      HelpContext = 189071
      Margins.Top = 1
      Margins.Right = 33
      Align = alBottom
      Alignment = taRightJustify
      Transparent = True
      Visible = False
      ExplicitLeft = 543
      ExplicitWidth = 3
    end
    inherited cboProductName: TwwDBLookupCombo
      Left = 346
      Top = 112
      Selected.Strings = (
        'Productname'#9'30'#9'Name'#9'F')
      ExplicitLeft = 346
      ExplicitTop = 112
    end
    inherited pnlcolmove: TDNMPanel
      AlignWithMargins = True
      Left = 547
      Top = 25
      Height = 185
      Margins.Left = 1
      ExplicitLeft = 547
      ExplicitTop = 25
      ExplicitHeight = 247
      inherited btnup: TDNMSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 3
        Width = 27
        Margins.Left = 1
        Margins.Right = 1
        Align = alTop
        ExplicitLeft = 1
        ExplicitTop = 3
        ExplicitWidth = 27
      end
      inherited btndown: TDNMSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 37
        Width = 27
        Margins.Left = 1
        Margins.Right = 1
        Align = alTop
        ExplicitLeft = 1
        ExplicitTop = 37
        ExplicitWidth = 27
      end
      object btnChooseProducts: TDNMSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 157
        Width = 27
        Height = 25
        Hint = 'Choose Products'
        Margins.Left = 1
        Margins.Right = 1
        Align = alBottom
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
          333333333337FF3333333333330003333333333333777F333333333333080333
          3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
          33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
          B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
          BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
          B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
          3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
          333333333337F33333333333333B333333333333333733333333}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = btnChooseProductsClick
      end
    end
    inherited grdProcResourceProducts: TwwDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 30
      Width = 540
      Height = 175
      Margins.Right = 2
      Selected.Strings = (
        'cSeqno'#9'1'#9'Seq #'#9'F'
        'ProductName'#9'28'#9'Product'
        'NoOfResources'#9'10'#9'No of'
        'ResourceDate'#9'18'#9'Status Date'
        'Active'#9'1'#9'Active ?')
      OnEnter = grdProcResourceProductsEnter
      ExplicitLeft = 4
      ExplicitTop = 30
      ExplicitWidth = 540
      ExplicitHeight = 175
      inherited wwIButton11xx: TwwIButton
        OnClick = wwIButton11xxClick
      end
    end
  end
  object DNMPanel1: TDNMPanel [16]
    AlignWithMargins = True
    Left = 3
    Top = 176
    Width = 580
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    object Label8: TLabel
      Left = 297
      Top = 4
      Width = 131
      Height = 15
      HelpContext = 189071
      Alignment = taRightJustify
      Caption = 'No Of Clean Resources'
      Transparent = True
    end
    object Label9: TLabel
      Left = 452
      Top = 4
      Width = 66
      Height = 15
      HelpContext = 189071
      Caption = 'Status Date'
      Transparent = True
    end
    object Label7: TLabel
      Left = 6
      Top = 4
      Width = 80
      Height = 15
      HelpContext = 189071
      Alignment = taRightJustify
      Caption = 'Clean Product'
      Transparent = True
    end
    object wwDBEdit2: TwwDBEdit
      Left = 343
      Top = 22
      Width = 85
      Height = 23
      HelpContext = 189076
      DataField = 'NoOfResources'
      DataSource = dsProcResourceProductClean
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object dtResourceDate: TwwDBDateTimePicker
      Left = 452
      Top = 22
      Width = 120
      Height = 23
      HelpContext = 189076
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      DataField = 'ResourceDate'
      DataSource = dsProcResourceProductClean
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
    end
    object wwDBLookupCombo1: TwwDBLookupCombo
      Left = 6
      Top = 22
      Width = 259
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Productname'#9'30'#9'Name'#9'F')
      DataField = 'ProductName'
      DataSource = dsProcResourceProductClean
      LookupTable = QryProductName
      LookupField = 'ProductName'
      DropDownWidth = 300
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 151
    Top = 13
  end
  inherited tmrdelay: TTimer
    Left = 316
    Top = 13
  end
  inherited popSpelling: TPopupMenu
    Left = 118
    Top = 13
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 184
    Top = 13
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 349
    Top = 13
  end
  inherited DataState: TDataState
    Left = 250
    Top = 13
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 382
    Top = 13
  end
  inherited imgsort: TImageList
    Left = 283
    Top = 13
    Bitmap = {
      494C010102009400180110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited qryProcResourceProducts: TERPQuery
    OnCalcFields = qryProcResourceProductsCalcFields
    Active = True
    object qryProcResourceProductscSeqno: TIntegerField [0]
      DisplayLabel = 'Seq #'
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'cSeqno'
      Calculated = True
    end
    inherited qryProcResourceProductsProductName: TWideStringField
      DisplayWidth = 28
      Origin = 'tblprocresourceproducts.ProductName'
    end
    inherited qryProcResourceProductsNoOfResources: TIntegerField
      DisplayLabel = 'No of'
      Origin = 'tblprocresourceproducts.NoOfResources'
    end
    object qryProcResourceProductsResourceDate: TDateTimeField [3]
      DisplayLabel = 'Status Date'
      DisplayWidth = 18
      FieldName = 'ResourceDate'
      Origin = 'tblprocresourceproducts.ResourceDate'
    end
    inherited qryProcResourceProductsActive: TWideStringField
      Origin = 'tblprocresourceproducts.Active'
    end
    inherited qryProcResourceProductsSeqno: TIntegerField
      DisplayWidth = 5
      Origin = 'tblprocresourceproducts.Seqno'
    end
    inherited qryProcResourceProductsID: TIntegerField
      Origin = 'tblprocresourceproducts.ID'
    end
    inherited qryProcResourceProductsGlobalRef: TWideStringField
      Origin = 'tblprocresourceproducts.GlobalRef'
    end
    inherited qryProcResourceProductsProcresourcedetailID: TIntegerField
      Origin = 'tblprocresourceproducts.ProcresourcedetailID'
    end
    inherited qryProcResourceProductsProductId: TIntegerField
      Origin = 'tblprocresourceproducts.ProductId'
    end
    inherited qryProcResourceProductsmsTimeStamp: TDateTimeField
      Origin = 'tblprocresourceproducts.msTimeStamp'
    end
    inherited qryProcResourceProductsmsUpdateSiteCode: TWideStringField
      Origin = 'tblprocresourceproducts.msUpdateSiteCode'
    end
  end
  inherited QryProductName: TERPQuery
    SQL.Strings = (
      'SELECT P.PartsId as ProductId, P.Partname as Productname'
      'from tblparts P'
      
        'inner join tblproctree PT on P.partsId = PT.partsID and ifnull(P' +
        'T.parentID,0)=0 and PT.mastertype = '#39'mtProduct'#39
      'where parttype ="INV"'
      'ORDER BY Productname')
    object QryProductNameProductname: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 30
      FieldName = 'Productname'
      Size = 255
    end
    object QryProductNameProductId: TIntegerField
      FieldName = 'ProductId'
      Visible = False
    end
  end
  inherited ActionList: TActionList
    inherited actSave: TAction
      OnExecute = nil
    end
  end
  object qryProcResourceProductClean: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblProcResourceProducts')
    Active = True
    Left = 451
    Top = 443
    object qryProcResourceProductCleanID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblprocresourceproducts.ID'
    end
    object qryProcResourceProductCleanGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblprocresourceproducts.GlobalRef'
      Size = 255
    end
    object qryProcResourceProductCleanProcresourcedetailID: TIntegerField
      FieldName = 'ProcresourcedetailID'
      Origin = 'tblprocresourceproducts.ProcresourcedetailID'
    end
    object qryProcResourceProductCleanProductId: TIntegerField
      FieldName = 'ProductId'
      Origin = 'tblprocresourceproducts.ProductId'
    end
    object qryProcResourceProductCleanProductName: TWideStringField
      FieldName = 'ProductName'
      Origin = 'tblprocresourceproducts.ProductName'
      Size = 255
    end
    object qryProcResourceProductCleanSeqno: TIntegerField
      FieldName = 'Seqno'
      Origin = 'tblprocresourceproducts.Seqno'
    end
    object qryProcResourceProductCleanNoOfResources: TIntegerField
      FieldName = 'NoOfResources'
      Origin = 'tblprocresourceproducts.NoOfResources'
    end
    object qryProcResourceProductCleanActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblprocresourceproducts.Active'
      FixedChar = True
      Size = 1
    end
    object qryProcResourceProductCleanResourceDate: TDateTimeField
      FieldName = 'ResourceDate'
      Origin = 'tblprocresourceproducts.ResourceDate'
    end
    object qryProcResourceProductCleanmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblprocresourceproducts.msTimeStamp'
    end
    object qryProcResourceProductCleanmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblprocresourceproducts.msUpdateSiteCode'
      Size = 3
    end
  end
  object dsProcResourceProductClean: TDataSource
    DataSet = qryProcResourceProductClean
    Left = 451
    Top = 412
  end
end
