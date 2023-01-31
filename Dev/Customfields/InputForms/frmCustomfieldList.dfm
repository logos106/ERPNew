inherited fmCustomfieldList: TfmCustomfieldList
  HelpContext = 870001
  Caption = 'Custom Field List'
  ExplicitTop = 8
  ExplicitWidth = 955
  ExplicitHeight = 561
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 482
    ExplicitTop = 514
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 482
    Width = 949
    Height = 50
    HelpContext = 870011
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    Transparent = False
    DesignSize = (
      949
      50)
    object btnClose: TDNMSpeedButton
      Left = 516
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 870012
      Anchors = []
      Caption = 'Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnCompleted: TDNMSpeedButton
      Left = 336
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 870013
      Anchors = []
      Caption = '&Save'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnCompletedClick
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 949
    Height = 50
    HelpContext = 870014
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object pnlTitle: TDNMPanel
      Left = 200
      Top = 5
      Width = 538
      Height = 39
      HelpContext = 870015
      Caption = 'Invoice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 536
        Height = 37
        HelpContext = 870016
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 536
          Height = 37
          HelpContext = 870017
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Custom Field List'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 171
        end
      end
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 50
    Width = 949
    Height = 432
    HelpContext = 870002
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    Transparent = False
    object grdmain: TwwDBGrid
      Left = 1
      Top = 1
      Width = 704
      Height = 430
      HelpContext = 870003
      ControlType.Strings = (
        'isCombo;CheckBox;T;F'
        'IsCustomer;CheckBox;T;F'
        'Datatype;CustomEdit;cboDatatype;F')
      Selected.Strings = (
        'Description'#9'50'#9'Description'#9#9
        'Datatype'#9'15'#9'Data Type'#9#9
        'ListType'#9'12'#9'ListType'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alLeft
      DataSource = dsCustomFieldList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnExit = grdmainExit
      FooterColor = clWhite
      object grdmainIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 22
        HelpContext = 870004
        AllowAllUp = True
        Glyph.Data = {
          C6030000424DC603000000000000360000002800000010000000130000000100
          18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
          666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
          99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
          CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
          333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
          99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
          C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
          C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
          77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
          8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
          B2B2B2808080333366000080333366777777777777333366000080333399C0C0
          C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
          0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
          CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
          0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
          868686808080666699333399333399000080333366666666808080969696C0C0
          C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
          8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
          B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
          80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
          CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
          99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
          D7CCCCCCCCCCCCCCCCCC}
        OnClick = grdmainIButtonClick
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 705
      Top = 1
      Width = 243
      Height = 430
      HelpContext = 870005
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object grdDropDownText: TwwDBGrid
        Left = 9
        Top = 92
        Width = 206
        Height = 321
        HelpContext = 870006
        Selected.Strings = (
          'Text'#9'22'#9'Text'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alCustom
        DataSource = dsCustomfieldListdropdowns
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnExit = grdDropDownTextExit
        object grdDropDownTextIButton: TwwIButton
          Left = 0
          Top = 0
          Width = 22
          Height = 22
          HelpContext = 870007
          AllowAllUp = True
          Glyph.Data = {
            C6030000424DC603000000000000360000002800000010000000130000000100
            18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
            666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
            99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
            CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
            333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
            99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
            C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
            C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
            77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
            8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
            B2B2B2808080333366000080333366777777777777333366000080333399C0C0
            C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
            0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
            CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
            0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
            868686808080666699333399333399000080333366666666808080969696C0C0
            C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
            8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
            B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
            80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
            CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
            99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
            CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
            CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
            D7CCCCCCCCCCCCCCCCCC}
          OnClick = grdDropDownTextIButtonClick
        end
      end
      object DNMPanel5: TDNMPanel
        Left = 13
        Top = 8
        Width = 202
        Height = 41
        HelpContext = 870008
        Caption = 'DropDown Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object chkisCombo: TwwCheckBox
        Left = 16
        Top = 65
        Width = 169
        Height = 17
        HelpContext = 870009
        DisableThemes = False
        AlwaysTransparent = False
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Enable DropDown'
        DataField = 'isCombo'
        DataSource = dsCustomFieldList
        TabOrder = 2
        OnClick = chkisComboClick
      end
    end
    object cboDatatype: TwwDBComboBox
      Left = 438
      Top = 22
      Width = 113
      Height = 23
      HelpContext = 870010
      ShowButton = True
      Style = csDropDown
      MapList = True
      AllowClearKey = False
      AutoDropDown = True
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Text'#9'ftString'
        'True/False'#9'ftBoolean'
        'Number'#9'ftFloat'
        'Date Time'#9'ftDateTime')
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 24
    Top = 184
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 125
    Top = 184
  end
  inherited DataState: TDataState
    Left = 57
    Top = 184
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 159
    Top = 184
  end
  inherited imgsort: TImageList
    Left = 91
    Top = 184
    Bitmap = {
      494C010102001C004C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 194
    Top = 184
  end
  inherited qryMemTrans: TERPQuery
    Left = 21
    Top = 72
  end
  object QryCustomFieldList: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblcustomfieldlist')
    BeforeInsert = QryCustomFieldListBeforeInsert
    AfterInsert = QryCustomFieldListAfterInsert
    Left = 261
    Top = 184
    object QryCustomFieldListDescription: TWideStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Origin = 'tblcustomfieldlist.Description'
      Size = 255
    end
    object QryCustomFieldListDatatype: TWideStringField
      DisplayLabel = 'Data Type'
      DisplayWidth = 15
      FieldName = 'Datatype'
      Origin = 'tblcustomfieldlist.Datatype'
      FixedChar = True
      Size = 10
    end
    object QryCustomFieldListListType: TWideStringField
      DisplayWidth = 12
      FieldName = 'ListType'
      Origin = 'tblcustomfieldlist.ListType'
      FixedChar = True
      Size = 12
    end
    object QryCustomFieldListisCombo: TWideStringField
      DisplayWidth = 1
      FieldName = 'isCombo'
      Origin = 'tblcustomfieldlist.isCombo'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryCustomFieldListGlobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'Globalref'
      Origin = 'tblcustomfieldlist.Globalref'
      Visible = False
      Size = 255
    end
    object QryCustomFieldListCFID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'CFID'
      Origin = 'tblcustomfieldlist.CFID'
      Visible = False
    end
    object QryCustomFieldListmstimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimeStamp'
      Origin = 'tblcustomfieldlist.mstimeStamp'
      Visible = False
    end
  end
  object dsCustomFieldList: TDataSource
    DataSet = QryCustomFieldList
    Left = 296
    Top = 186
  end
  object QrycustomfieldListdropdowns: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblcustomfieldListdropdowns')
    Left = 261
    Top = 216
    object QrycustomfieldListdropdownsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QrycustomfieldListdropdownsDropDownID: TIntegerField
      FieldName = 'DropDownID'
    end
    object QrycustomfieldListdropdownsCustomFieldlistId: TLargeintField
      FieldName = 'CustomFieldlistId'
    end
    object QrycustomfieldListdropdownsText: TWideStringField
      FieldName = 'Text'
      Size = 255
    end
    object QrycustomfieldListdropdownsSeqno: TIntegerField
      FieldName = 'Seqno'
    end
    object QrycustomfieldListdropdownsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object dsCustomfieldListdropdowns: TDataSource
    DataSet = QrycustomfieldListdropdowns
    Left = 296
    Top = 218
  end
end
