inherited fmTreeProductSepc: TfmTreeProductSepc
  Left = 976
  Top = 209
  HelpContext = 1405002
  Caption = 'Formula Entry'
  ClientHeight = 401
  ClientWidth = 476
  Position = poMainFormCenter
  ExplicitLeft = 976
  ExplicitTop = 209
  ExplicitWidth = 492
  ExplicitHeight = 440
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 361
    Width = 476
    HelpContext = 1405003
    ExplicitTop = 402
    ExplicitWidth = 476
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 361
    Width = 476
    Height = 40
    HelpContext = 1405041
    Align = alBottom
    Anchors = [akLeft, akRight]
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      476
      40)
    object btnok: TDNMSpeedButton
      Left = 135
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 1405042
      Anchors = []
      Caption = '&Ok'
      Default = True
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      Style = bsModern
      TabOrder = 0
      OnClick = btnokClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 254
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 1405043
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      Style = bsModern
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object chkHide: TCheckBox
      AlignWithMargins = True
      Left = 383
      Top = 3
      Width = 90
      Height = 34
      HelpContext = 1405047
      Align = alRight
      Alignment = taLeftJustify
      Caption = 'Don'#39't Show BOM Tree'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Visible = False
      WordWrap = True
      OnClick = chkHideClick
    end
  end
  object pnlHeader: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 476
    Height = 234
    HelpContext = 1405004
    Align = alTop
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      476
      234)
    object Label1: TLabel
      Left = 57
      Top = 72
      Width = 48
      Height = 15
      HelpContext = 1405005
      Alignment = taRightJustify
      Caption = 'Product '
      Transparent = True
    end
    object Label2: TLabel
      Left = 59
      Top = 130
      Width = 46
      Height = 15
      HelpContext = 1405006
      Alignment = taRightJustify
      Caption = 'Formula'
      Transparent = True
    end
    object lblformulaValue: TLabel
      AlignWithMargins = True
      Left = 112
      Top = 216
      Width = 361
      Height = 15
      HelpContext = 1405044
      Margins.Left = 112
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitWidth = 3
    end
    object Label3: TLabel
      Left = 72
      Top = 101
      Width = 33
      Height = 15
      HelpContext = 1405045
      Alignment = taRightJustify
      Caption = 'Name'
      Transparent = True
    end
    object lblLineNo: TLabel
      Left = 71
      Top = 188
      Width = 34
      Height = 15
      HelpContext = 1405048
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      Caption = 'Line #'
      Transparent = True
      ExplicitTop = 160
    end
    object Label4: TLabel
      Left = 44
      Top = 159
      Width = 62
      Height = 15
      HelpContext = 1405049
      Alignment = taRightJustify
      Caption = 'Comments'
      Transparent = True
    end
    object edtProductName: TEdit
      Left = 112
      Top = 68
      Width = 225
      Height = 23
      HelpContext = 1405007
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnEnter = SetfocusToEdit
    end
    object pnlTitle: TDNMPanel
      Left = 122
      Top = 8
      Width = 238
      Height = 45
      HelpContext = 1405008
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 234
        Height = 41
        HelpContext = 1405009
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
          Width = 234
          Height = 41
          HelpContext = 1405010
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Formula Entry'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
    object btnChooseformula: TDNMSpeedButton
      Left = 343
      Top = 124
      Width = 106
      Height = 27
      HelpContext = 1405011
      Caption = 'Choose Formula'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      Style = bsModern
      TabOrder = 3
      OnClick = btnChooseformulaClick
    end
    object edtFormulaName: TEdit
      Left = 112
      Top = 126
      Width = 225
      Height = 23
      HelpContext = 1405012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      OnEnter = SetfocusToEdit
    end
    object edtFormulaWithValue: TEdit
      Left = 112
      Top = 97
      Width = 225
      Height = 23
      HelpContext = 1405046
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object cboLineNos: TComboBox
      Left = 112
      Top = 184
      Width = 90
      Height = 23
      AutoDropDown = True
      AutoCloseUp = True
      Anchors = [akLeft, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = '1'
      OnKeyPress = cboLineNosKeyPress
      HelpContext = 1405050
    end
    object edtcomments: TEdit
      Left = 112
      Top = 155
      Width = 337
      Height = 23
      HelpContext = 1405051
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnDblClick = edtcommentsDblClick
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 234
    Width = 476
    Height = 127
    HelpContext = 1405013
    Align = alClient
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object lblMsg: TLabel
      Left = 0
      Top = 122
      Width = 476
      Height = 5
      HelpContext = 1405014
      Align = alClient
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitWidth = 3
      ExplicitHeight = 15
    end
    object DNMPanel2: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 470
      Height = 55
      HelpContext = 1405015
      Align = alTop
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = 15527129
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object pnl5: TDNMPanel
        Left = 368
        Top = 0
        Width = 90
        Height = 51
        HelpContext = 1405016
        Align = alLeft
        BevelOuter = bvNone
        Color = 15527129
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object lbl5: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 84
          Height = 15
          HelpContext = 1405017
          Align = alTop
          Caption = 'Field 1'
          Transparent = True
          ExplicitWidth = 36
        end
        object edt5: TEdit
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 90
          Height = 24
          HelpContext = 1405018
          Margins.Left = 0
          Margins.Right = 0
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = OnchangeValue
          OnKeyPress = ValidateInput
          ExplicitHeight = 23
        end
      end
      object pnl4: TDNMPanel
        Left = 278
        Top = 0
        Width = 90
        Height = 51
        HelpContext = 1405019
        Align = alLeft
        BevelOuter = bvNone
        Color = 15527129
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object lbl4: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 84
          Height = 15
          HelpContext = 1405020
          Align = alTop
          Caption = 'Field 1'
          Transparent = True
          ExplicitWidth = 36
        end
        object edt4: TEdit
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 90
          Height = 24
          HelpContext = 1405021
          Margins.Left = 0
          Margins.Right = 0
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = OnchangeValue
          OnKeyPress = ValidateInput
          ExplicitHeight = 23
        end
      end
      object pnl3: TDNMPanel
        Left = 188
        Top = 0
        Width = 90
        Height = 51
        HelpContext = 1405022
        Align = alLeft
        BevelOuter = bvNone
        Color = 15527129
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object lbl3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 84
          Height = 15
          HelpContext = 1405023
          Align = alTop
          Caption = 'Field 1'
          Transparent = True
          ExplicitWidth = 36
        end
        object edt3: TEdit
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 90
          Height = 24
          HelpContext = 1405024
          Margins.Left = 0
          Margins.Right = 0
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = OnchangeValue
          OnKeyPress = ValidateInput
          ExplicitHeight = 23
        end
      end
      object pnl2: TDNMPanel
        Left = 98
        Top = 0
        Width = 90
        Height = 51
        HelpContext = 1405025
        Align = alLeft
        BevelOuter = bvNone
        Color = 15527129
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lbl2: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 84
          Height = 15
          HelpContext = 1405026
          Align = alTop
          Caption = 'Field 1'
          Transparent = True
          ExplicitWidth = 36
        end
        object edt2: TEdit
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 90
          Height = 24
          HelpContext = 1405027
          Margins.Left = 0
          Margins.Right = 0
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = OnchangeValue
          OnKeyPress = ValidateInput
          ExplicitHeight = 23
        end
      end
      object pnl1: TDNMPanel
        AlignWithMargins = True
        Left = 8
        Top = 0
        Width = 90
        Height = 51
        HelpContext = 1405028
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = 15527129
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lbl1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 84
          Height = 15
          HelpContext = 1405029
          Align = alTop
          Caption = 'Field 1'
          Transparent = True
          ExplicitWidth = 36
        end
        object edt1: TEdit
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 90
          Height = 24
          HelpContext = 1405030
          Margins.Left = 0
          Margins.Right = 0
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = OnchangeValue
          OnKeyPress = ValidateInput
          ExplicitHeight = 23
        end
      end
    end
    object DNMPanel4: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 64
      Width = 470
      Height = 55
      HelpContext = 1405031
      Align = alTop
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = 15527129
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object DNMPanel7: TDNMPanel
        Left = 368
        Top = 0
        Width = 95
        Height = 51
        HelpContext = 1405032
        Align = alLeft
        BevelOuter = bvNone
        Color = 15527129
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object lblQty: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 89
          Height = 15
          HelpContext = 1405033
          Align = alTop
          Caption = 'Related Qty'
          Transparent = True
          ExplicitWidth = 65
        end
        object edtQty: TEdit
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 95
          Height = 24
          HelpContext = 1405034
          Margins.Left = 0
          Margins.Right = 0
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = SetfocusToEdit
          ExplicitHeight = 23
        end
      end
      object DNMPanel8: TDNMPanel
        Left = 188
        Top = 0
        Width = 180
        Height = 51
        HelpContext = 1405035
        Align = alLeft
        BevelOuter = bvNone
        Color = 15527129
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lblFormula: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 174
          Height = 15
          HelpContext = 1405036
          Align = alTop
          Caption = 'Formula'
          Transparent = True
          ExplicitWidth = 46
        end
        object edtFormula: TEdit
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 180
          Height = 24
          HelpContext = 1405037
          Margins.Left = 0
          Margins.Right = 0
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = SetfocusToEdit
          ExplicitHeight = 23
        end
      end
      object DNMPanel9: TDNMPanel
        AlignWithMargins = True
        Left = 8
        Top = 0
        Width = 180
        Height = 51
        HelpContext = 1405038
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = 15527129
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblProductName: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 174
          Height = 15
          HelpContext = 1405039
          Align = alTop
          Caption = 'Product name'
          Transparent = True
          ExplicitWidth = 80
        end
        object edtProduct: TEdit
          AlignWithMargins = True
          Left = 0
          Top = 24
          Width = 180
          Height = 24
          HelpContext = 1405040
          Margins.Left = 0
          Margins.Right = 0
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = SetfocusToEdit
          ExplicitHeight = 23
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 73
    Top = 200
  end
  inherited tmrdelay: TTimer
    Left = 111
    Top = 200
  end
  inherited popSpelling: TPopupMenu
    Left = 187
    Top = 200
  end
  inherited tmrdelayMsg: TTimer
    Left = 149
    Top = 200
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 225
    Top = 200
  end
end
