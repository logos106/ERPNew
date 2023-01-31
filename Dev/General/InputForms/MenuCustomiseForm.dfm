inherited frmCustomiseMenu: TfrmCustomiseMenu
  Left = 124
  Top = 145
  HelpContext = 259000
  BorderIcons = [biMinimize]
  Caption = 'Customise Main Menu'
  ClientHeight = 559
  ClientWidth = 776
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ExplicitLeft = 124
  ExplicitTop = 145
  ExplicitWidth = 792
  ExplicitHeight = 598
  DesignSize = (
    776
    559)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 545
    Width = 776
    HelpContext = 259028
    ExplicitTop = 559
    ExplicitWidth = 776
  end
  object lblMsg: TLabel [5]
    Left = 0
    Top = 545
    Width = 776
    Height = 14
    HelpContext = 259005
    Align = alBottom
    Caption = 'Email sent to ERP for changing the image'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
    Visible = False
    ExplicitWidth = 195
  end
  object btnCancel: TDNMSpeedButton [6]
    Left = 502
    Top = 525
    Width = 87
    Height = 27
    HelpContext = 259002
    Anchors = [akRight, akBottom]
    Caption = '&Close'
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
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
  end
  object btnOk: TDNMSpeedButton [7]
    Left = 188
    Top = 524
    Width = 87
    Height = 27
    HelpContext = 259024
    Anchors = [akRight, akBottom]
    Caption = 'O&K'
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = btnOkClick
  end
  object pnlTitle: TDNMPanel [8]
    Left = 204
    Top = 6
    Width = 365
    Height = 45
    HelpContext = 259025
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 361
      Height = 41
      HelpContext = 259026
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
        Width = 361
        Height = 41
        HelpContext = 259027
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Customise Main Menu'
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
  object mem_Note: TMemo [9]
    Left = 27
    Top = 199
    Width = 721
    Height = 112
    HelpContext = 259031
    Alignment = taCenter
    Color = clGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      'On the mainmenu , choose '
      'General -> Customise toolbar '
      'To customise the menu tool bar')
    ParentFont = False
    TabOrder = 4
    Visible = False
  end
  object PageControl1: TPageControl [10]
    Left = 23
    Top = 55
    Width = 745
    Height = 461
    HelpContext = 259003
    ActivePage = TabSheet1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabHeight = 25
    TabOrder = 1
    TabWidth = 247
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      HelpContext = 259004
      Caption = 'Categories'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        737
        426)
      object Label3: TLabel
        Left = 33
        Top = 410
        Width = 40
        Height = 15
        HelpContext = 259007
        Anchors = []
        Caption = 'Default'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 7
        Top = 6
        Width = 124
        Height = 15
        HelpContext = 259029
        Caption = 'Select menu category'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 356
        Top = 6
        Width = 144
        Height = 15
        HelpContext = 259006
        Caption = 'Select page to customise'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object cbCategories: TComboBox
        Left = 7
        Top = 22
        Width = 300
        Height = 23
        HelpContext = 259008
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnSelect = cbCategoriesSelect
        Items.Strings = (
          'All Categories')
      end
      object lvAvailableButtons: TListView
        Left = 6
        Top = 58
        Width = 300
        Height = 349
        HelpContext = 259009
        Columns = <
          item
            Caption = 'All Available Buttons'
            Width = 275
          end>
        DragMode = dmAutomatic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        SortType = stText
        TabOrder = 1
        ViewStyle = vsReport
        OnDblClick = lvAvailableButtonsDblClick
        OnDragDrop = lvAvailableButtonsDragDrop
        OnDragOver = lvAvailableButtonsDragOver
      end
      object btnAddButton: TDNMSpeedButton
        Left = 317
        Top = 96
        Width = 27
        Height = 25
        Hint = 'Add button'
        HelpContext = 259010
        Caption = '>'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnAddButtonClick
      end
      object btnAddAllButtons: TDNMSpeedButton
        Left = 317
        Top = 136
        Width = 27
        Height = 25
        Hint = 'Add all buttons'
        HelpContext = 259011
        Caption = '>>'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btnAddAllButtonsClick
      end
      object btnRemoveButton: TDNMSpeedButton
        Left = 317
        Top = 236
        Width = 27
        Height = 25
        Hint = 'Remove selected button'
        HelpContext = 259012
        Caption = '<'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = btnRemoveButtonClick
      end
      object btnRemoveAllButtons: TDNMSpeedButton
        Left = 317
        Top = 275
        Width = 27
        Height = 25
        Hint = 'Remove all selected buttons'
        HelpContext = 259013
        Caption = '<<'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = btnRemoveAllButtonsClick
      end
      object cbPages: TComboBox
        Left = 355
        Top = 22
        Width = 301
        Height = 23
        HelpContext = 259014
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnDropDown = cbPagesDropDown
        OnSelect = cbPagesSelect
      end
      object lvSelectedButtons: TListView
        Left = 355
        Top = 57
        Width = 300
        Height = 350
        HelpContext = 259015
        Columns = <
          item
            Caption = 'Selected Buttons'
            Width = 275
          end>
        DragMode = dmAutomatic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        TabOrder = 7
        ViewStyle = vsReport
        OnDragDrop = lvSelectedButtonsDragDrop
        OnDragOver = lvSelectedButtonsDragOver
        OnKeyDown = lvSelectedButtonsKeyDown
      end
      object btnMoveItemDown: TDNMSpeedButton
        Left = 703
        Top = 102
        Width = 25
        Height = 41
        HelpContext = 259016
        Anchors = []
        DisableTransparent = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
          33333333373F33333333333330B03333333333337F7F33333333333330F03333
          333333337F7FF3333333333330B00333333333337F773FF33333333330F0F003
          333333337F7F773F3333333330B0B0B0333333337F7F7F7F3333333300F0F0F0
          333333377F73737F33333330B0BFBFB03333337F7F33337F33333330F0FBFBF0
          3333337F7333337F33333330BFBFBFB033333373F3333373333333330BFBFB03
          33333337FFFFF7FF3333333300000000333333377777777F333333330EEEEEE0
          33333337FFFFFF7FF3333333000000000333333777777777F33333330000000B
          03333337777777F7F33333330000000003333337777777773333}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        TabOrder = 8
        OnClick = btnMoveItemDownClick
      end
      object btnMoveItemUp: TDNMSpeedButton
        Left = 703
        Top = 57
        Width = 25
        Height = 41
        HelpContext = 259017
        Anchors = []
        DisableTransparent = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
          333333777777777F33333330B00000003333337F7777777F3333333000000000
          333333777777777F333333330EEEEEE033333337FFFFFF7F3333333300000000
          333333377777777F3333333330BFBFB03333333373333373F33333330BFBFBFB
          03333337F33333F7F33333330FBFBF0F03333337F33337F7F33333330BFBFB0B
          03333337F3F3F7F7333333330F0F0F0033333337F7F7F773333333330B0B0B03
          3333333737F7F7F333333333300F0F03333333337737F7F33333333333300B03
          333333333377F7F33333333333330F03333333333337F7F33333333333330B03
          3333333333373733333333333333303333333333333373333333}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        TabOrder = 9
        OnClick = btnMoveItemUpClick
      end
      object btnDeletePage: TDNMSpeedButton
        Left = 661
        Top = 27
        Width = 65
        Height = 20
        HelpContext = 259018
        Anchors = []
        Caption = 'Delete'
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
        TabOrder = 10
        OnClick = btnDeletePageClick
      end
      object btnAddPage: TDNMSpeedButton
        Left = 661
        Top = 6
        Width = 66
        Height = 19
        HelpContext = 259019
        Anchors = []
        Caption = 'Add'
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
        TabOrder = 11
        OnClick = btnAddPageClick
      end
      object btnDefault: TDNMSpeedButton
        Left = 10
        Top = 409
        Width = 18
        Height = 17
        Hint = 'Set Categories back to Defaults'
        HelpContext = 259020
        Anchors = [akLeft, akBottom]
        Default = True
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 12
        OnClick = btnDefaultClick
      end
    end
    object TabSheet2: TTabSheet
      HelpContext = 259021
      Caption = 'Copy To...'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object CopyTolbl: TLabel
        Left = 30
        Top = 23
        Width = 203
        Height = 13
        HelpContext = 259022
        Caption = 'Copy Main Switch Customisation to:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lstEmployees: TCheckListBox
        Left = 30
        Top = 42
        Width = 379
        Height = 367
        HelpContext = 259030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object tsLayouts: TTabSheet
      HelpContext = 259032
      Caption = 'Layouts'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        737
        426)
      object Image1: TImage
        Left = 463
        Top = 16
        Width = 274
        Height = 236
        HelpContext = 259033
      end
      object grdPages: TwwDBGrid
        Left = -4
        Top = 16
        Width = 207
        Height = 407
        HelpContext = 259034
        ControlType.Strings = (
          'Active;CheckBox;T;F')
        Selected.Strings = (
          'PageName'#9'255'#9'Page Name')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        OnRowChanged = grdPagesRowChanged
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsLoads
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
      end
      object cbHistory: TCheckListBox
        Left = 209
        Top = 16
        Width = 248
        Height = 407
        HelpContext = 259035
        OnClickCheck = cbHistoryClickCheck
        PopupMenu = popLayout
        TabOrder = 1
        OnClick = cbHistoryClick
        OnKeyDown = cbHistoryKeyDown
      end
      object btnExport: TDNMSpeedButton
        Left = 475
        Top = 303
        Width = 87
        Height = 27
        HelpContext = 259036
        Anchors = [akRight, akBottom]
        Caption = 'E&xport'
        Default = True
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
        TabOrder = 2
        OnClick = btnExportClick
      end
      object btnImport: TDNMSpeedButton
        Left = 641
        Top = 303
        Width = 87
        Height = 27
        HelpContext = 259038
        Anchors = [akRight, akBottom]
        Caption = '&Import'
        Default = True
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
        TabOrder = 3
        OnClick = btnImportClick
      end
      object btnIndustry: TDNMSpeedButton
        Left = 475
        Top = 351
        Width = 87
        Height = 27
        HelpContext = 259039
        Anchors = [akRight, akBottom]
        Caption = '&Industry'
        Default = True
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
        TabOrder = 4
        OnClick = btnIndustryClick
      end
      object cbIndustry: TCheckBox
        Left = 475
        Top = 272
        Width = 174
        Height = 17
        Caption = 'Show For All Industries'
        TabOrder = 5
        OnClick = cbIndustryClick
        HelpContext = 259040
      end
    end
    object tabMainswitch: TTabSheet
      Caption = 'Main Switch'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      HelpContext = 259041
      object pnlMainswitch: TDNMPanel
        Left = 0
        Top = 0
        Width = 737
        Height = 426
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          737
          426)
        HelpContext = 259042
        object Shape1: TShape
          Left = 96
          Top = 93
          Width = 569
          Height = 236
          Brush.Style = bsClear
          Pen.Color = clMaroon
          HelpContext = 259043
        end
        object lblIncrease: TLabel
          Left = 140
          Top = 256
          Width = 87
          Height = 60
          Alignment = taCenter
          Caption = 'Increase the Height of the Mainswitch  by adding a Row'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
          HelpContext = 259044
        end
        object lblDecrease: TLabel
          Left = 315
          Top = 256
          Width = 94
          Height = 60
          Alignment = taCenter
          Caption = 'Decrease  the Height of the Mainswitch  by Removing a Row'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
          HelpContext = 259045
        end
        object lbldefault: TLabel
          Left = 500
          Top = 256
          Width = 96
          Height = 45
          Alignment = taCenter
          Caption = 'Set the Height of the Mainswitch  to ERP Default'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
          HelpContext = 259046
        end
        object DNMPanel1: TDNMPanel
          Left = 225
          Top = 35
          Width = 287
          Height = 45
          HelpContext = 259047
          Anchors = [akLeft, akTop, akRight]
          BevelInner = bvRaised
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Shader1: TShader
            Left = 2
            Top = 2
            Width = 283
            Height = 41
            HelpContext = 259048
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
            object Label4: TLabel
              Left = 0
              Top = 0
              Width = 283
              Height = 41
              HelpContext = 259049
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'Mainswitch Height'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -29
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              ExplicitWidth = 361
            end
          end
        end
      end
    end
  end
  object btnEditLayout: TDNMSpeedButton [11]
    Left = 345
    Top = 525
    Width = 87
    Height = 27
    HelpContext = 259050
    Anchors = [akRight, akBottom]
    Caption = '&Edit Layout'
    Default = True
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
    ModalResult = 4
    ParentFont = False
    TabOrder = 5
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102007000EC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryEmployeeCopyTo: TERPQuery
    SQL.Strings = (
      
        'Select EmployeeID, EmployeeName, Concat_WS('#39' '#39',FirstName,LastNam' +
        'e) AS '#39'Employee Names'#39
      'FROM tblEmployees'
      'WHERE Active = '#39'T'#39
      'ORDER BY FirstName, LastName')
    Left = 600
    Top = 9
  end
  object qryPreferences: TERPQuery
    Left = 630
    Top = 9
  end
  object qryPreferencesTo: TERPQuery
    Left = 658
    Top = 9
  end
  object ImageListAll: TImageList
    Height = 57
    Masked = False
    Width = 76
    Left = 688
    Top = 8
  end
  object qryTrainingButtons: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      '`tblcustomfields` AS `CF`')
    Options.LongStrings = False
    Left = 130
    Top = 16
  end
  object qryLayouts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select id, PageName, msTimeStamp, Active'
      'from tblPageLayout'
      'where UserId=1'
      'group by id'
      'order by msTimeStamp desc')
    BeforeEdit = qryLayoutsBeforeEdit
    Left = 582
    Top = 225
  end
  object dsLayouts: TDataSource
    DataSet = qryLayouts
    Left = 640
    Top = 240
  end
  object qryLoads: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select PageName'
      'from tblPageLayout'
      'where UserId=1'
      'group by PageName'
      'order by PageName')
    BeforeEdit = qryLayoutsBeforeEdit
    Left = 118
    Top = 305
  end
  object dsLoads: TDataSource
    DataSet = qryLoads
    Left = 192
    Top = 312
  end
  object scrLayouts: TERPScript
    Connection = MyConnection
    IgnorenContinueOnError = False
    Left = 704
    Top = 72
  end
  object popLayout: TPopupMenu
    Left = 512
    Top = 200
    object mnuDelete: TMenuItem
      Caption = 'Delete'
      HelpContext = 259037
      OnClick = mnuDeleteClick
    end
  end
  object qryMaxId: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select max(id) as id from tblPageLayout')
    BeforeEdit = qryLayoutsBeforeEdit
    Left = 694
    Top = 305
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.csv'
    Filter = 'CSV Files|*.csv|All Files|*.*'
    Left = 528
    Top = 448
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.csv'
    Filter = 'CSV Files|*.csv|All Files|*.*'
    Left = 656
    Top = 448
  end
end
