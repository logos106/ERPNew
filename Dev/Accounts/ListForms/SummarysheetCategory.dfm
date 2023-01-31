inherited SummarysheetCategoryGUI: TSummarysheetCategoryGUI
  Left = 322
  Top = 109
  HelpContext = 1091002
  Caption = 'Combined Companies Category'
  ExplicitLeft = 322
  ExplicitTop = 109
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlGraph: TDNMPanel
    Left = 166
    Top = 62
    Width = 830
    Height = 406
    HelpContext = 1091003
    ExplicitLeft = 166
    ExplicitTop = 62
    ExplicitWidth = 830
    ExplicitHeight = 406
  end
  inherited HeaderPanel: TPanel
    Height = 62
    HelpContext = 1091004
    ExplicitHeight = 62
    DesignSize = (
      996
      62)
    inherited lblTo: TLabel
      Left = 870
      ExplicitLeft = 870
    end
    inherited imgReportTablesMsg: TImage
      Picture.Data = {
        0954474946496D6167654749463839611100120077000021F904010000FC002C
        0000000011001200870000000000330000660000990000CC0000FF002B00002B
        33002B66002B99002BCC002BFF0055000055330055660055990055CC0055FF00
        80000080330080660080990080CC0080FF00AA0000AA3300AA6600AA9900AACC
        00AAFF00D50000D53300D56600D59900D5CC00D5FF00FF0000FF3300FF6600FF
        9900FFCC00FFFF3300003300333300663300993300CC3300FF332B00332B3333
        2B66332B99332BCC332BFF3355003355333355663355993355CC3355FF338000
        3380333380663380993380CC3380FF33AA0033AA3333AA6633AA9933AACC33AA
        FF33D50033D53333D56633D59933D5CC33D5FF33FF0033FF3333FF6633FF9933
        FFCC33FFFF6600006600336600666600996600CC6600FF662B00662B33662B66
        662B99662BCC662BFF6655006655336655666655996655CC6655FF6680006680
        336680666680996680CC6680FF66AA0066AA3366AA6666AA9966AACC66AAFF66
        D50066D53366D56666D59966D5CC66D5FF66FF0066FF3366FF6666FF9966FFCC
        66FFFF9900009900339900669900999900CC9900FF992B00992B33992B66992B
        99992BCC992BFF9955009955339955669955999955CC9955FF99800099803399
        80669980999980CC9980FF99AA0099AA3399AA6699AA9999AACC99AAFF99D500
        99D53399D56699D59999D5CC99D5FF99FF0099FF3399FF6699FF9999FFCC99FF
        FFCC0000CC0033CC0066CC0099CC00CCCC00FFCC2B00CC2B33CC2B66CC2B99CC
        2BCCCC2BFFCC5500CC5533CC5566CC5599CC55CCCC55FFCC8000CC8033CC8066
        CC8099CC80CCCC80FFCCAA00CCAA33CCAA66CCAA99CCAACCCCAAFFCCD500CCD5
        33CCD566CCD599CCD5CCCCD5FFCCFF00CCFF33CCFF66CCFF99CCFFCCCCFFFFFF
        0000FF0033FF0066FF0099FF00CCFF00FFFF2B00FF2B33FF2B66FF2B99FF2BCC
        FF2BFFFF5500FF5533FF5566FF5599FF55CCFF55FFFF8000FF8033FF8066FF80
        99FF80CCFF80FFFFAA00FFAA33FFAA66FFAA99FFAACCFFAAFFFFD500FFD533FF
        D566FFD599FFD5CCFFD5FFFFFF00FFFF33FFFF66FFFF99FFFFCCFFFFFF000000
        000000000000000000084B0025081C48B0E0C07D08132A5C28709FC1870E2544
        7C4830E2448A0D33623CA851A144841C2576D43852E4C48B161B262429B265CA
        96255FA28CC9F2E54697374BDEB4B8B0E7CA9C050302003B}
    end
    inherited pnlHeader: TPanel
      HelpContext = 1091048
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          HelpContext = 1091005
          Caption = 'Combined Companies Category'
          Font.Height = -29
        end
      end
    end
    inherited Panel2: TPanel
      Top = 62
      Height = 0
      HelpContext = 1091006
      Visible = False
      ExplicitTop = 62
      ExplicitHeight = 0
      inherited lblcheck2: TLabel
        Height = 0
        HelpContext = 1091040
      end
      inherited grpFilters: TwwRadioGroup
        Height = 0
        HelpContext = 1091007
        Visible = False
        ExplicitHeight = 0
      end
      inherited pnlButtons: TPanel
        Height = 0
        HelpContext = 1091008
        ExplicitHeight = 0
      end
      inherited pnlIncludehistory: TDNMPanel
        Height = 0
        HelpContext = 1091009
        ExplicitHeight = 0
      end
    end
    inherited Panel3: TPanel
      Top = 62
      Height = 0
      HelpContext = 1091010
      Visible = False
      ExplicitTop = 62
      ExplicitHeight = 0
      DesignSize = (
        996
        0)
      inherited lblCheck1: TLabel
        Height = 18
        HelpContext = 1091041
      end
      inherited grpView: TwwRadioGroup
        Height = 6
        HelpContext = 1091011
        ExplicitHeight = 6
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 1091012
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 1091013
    end
  end
  inherited Panel1: TPanel
    Left = 166
    Top = 62
    Width = 830
    Height = 406
    HelpContext = 1091014
    ExplicitLeft = 166
    ExplicitTop = 62
    ExplicitWidth = 830
    ExplicitHeight = 406
    inherited lblDateComments: TLabel
      Top = 390
      Width = 830
      HelpContext = 1091015
      ExplicitTop = 390
    end
    object Splitter: TAdvSplitter [1]
      Left = 0
      Top = 227
      Width = 830
      Height = 6
      Cursor = crVSplit
      HelpContext = 1091016
      Align = alBottom
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitTop = 224
    end
    object lblcurrencyhint: TLabel [2]
      Left = 0
      Top = 196
      Width = 830
      Height = 15
      Align = alBottom
      Alignment = taCenter
      Caption = 'lblcurrencyhint'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 85
      HelpContext = 1091042
    end
    inherited lblTimerMsg: TLabel
      Top = 211
      Width = 830
      ExplicitTop = 211
      HelpContext = 1091043
    end
    inherited splMultiSelectList: TSplitter
      Left = 567
      Top = 30
      Height = 166
      ExplicitLeft = 567
      ExplicitTop = 30
      ExplicitHeight = 166
      HelpContext = 1091044
    end
    inherited grdMain: TwwDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 33
      Width = 561
      Height = 160
      HelpContext = 1091017
      Selected.Strings = (
        'DbName'#9'20'#9'Database'#9#9
        'Amt1'#9'10'#9'Cash in~Hand'#9#9'General'
        'Amt2'#9'10'#9'Accounts~Receivable'#9#9'General'
        'Amt3'#9'10'#9'Accounts~Payable'#9#9'General'
        'Amt4'#9'10'#9'Balance~Sheet'#9#9'General'
        'Amt5'#9'10'#9'Current'#9#9'Payables'
        'Amt5Percent'#9'4'#9'%'#9#9'Payables'
        'Amt6'#9'10'#9'1 - 30'#9#9'Payables'
        'Amt6Percent'#9'4'#9'%'#9#9'Payables'
        'Amt7'#9'10'#9'31 - 60'#9#9'Payables'
        'Amt7Percent'#9'4'#9'%'#9#9'Payables'
        'Amt8'#9'10'#9'61 - 90'#9#9'Payables'
        'Amt8Percent'#9'4'#9'%'#9#9'Payables'
        'Amt9'#9'10'#9'90 +'#9#9'Payables'
        'Amt9Percent'#9'4'#9'%'#9#9'Payables'
        'Amt10'#9'10'#9'Current'#9#9'Receivables'
        'Amt10Percent'#9'4'#9'%'#9#9'Receivables'
        'Amt11'#9'10'#9'1 - 30'#9#9'Receivables'
        'Amt11Percent'#9'4'#9'%'#9#9'Receivables'
        'Amt12'#9'10'#9'31 - 60'#9#9'Receivables'
        'Amt12Percent'#9'4'#9'%'#9#9'Receivables'
        'Amt13'#9'10'#9'61 - 90'#9#9'Receivables'
        'Amt13Percent'#9'4'#9'%'#9#9'Receivables'
        'Amt14'#9'10'#9'90 +'#9#9'Receivables'
        'Amt14Percent'#9'4'#9'%'#9#9'Receivables'
        'Amt15'#9'10'#9'Sales'#9#9'Last Week (ex)'
        'Amt16'#9'10'#9'Cost of Goods'#9#9'Last Week (ex)'
        'Amt17'#9'10'#9'Expenses'#9#9'Last Week (ex)'
        'Amt18'#9'10'#9'Profit & Loss'#9#9'Last Week (ex)'
        'Amt19'#9'10'#9'Sales'#9#9'Last Month (ex)'
        'Amt20'#9'10'#9'ACost of Goodsmt20'#9#9'Last Month (ex)'
        'Amt21'#9'10'#9'Expenses'#9#9'Last Month (ex)'
        'Amt22'#9'10'#9'Profit & Loss'#9#9'Last Month (ex)'
        'Amt23'#9'10'#9'Sales'#9#9'Last 3 Months (ex)'
        'Amt24'#9'10'#9'Cost of Goods'#9#9'Last 3 Months (ex)'
        'Amt25'#9'10'#9'Expenses'#9#9'Last 3 Months (ex)'
        'Amt26'#9'10'#9'Profit & Loss'#9#9'Last 3 Months (ex)'
        'Amt27'#9'10'#9'Sales'#9#9'Last 12 Months (Ex)'
        'Amt28'#9'10'#9'Cost of Goods'#9#9'Last 12 Months (Ex)'
        'Amt29'#9'10'#9'Expenses'#9#9'Last 12 Months (Ex)'
        'Amt30'#9'10'#9'Profit & loss'#9#9'Last 12 Months (Ex)'
        'Amt31'#9'10'#9'Sales'#9'F'#9
        'Amt32'#9'10'#9'Sales'#9'F'#9
        'Amt33'#9'10'#9'Sales'#9'F'#9
        'Amt34'#9'10'#9'Sales'#9'F'#9
        'APtotal'#9'10'#9'APtotal'#9#9'Payables'
        'ARTotal'#9'10'#9'ARTotal'#9'F'#9
        'ExchangeRate'#9'10'#9'ExchangeRate'#9'F'#9
        'closingdate'#9'18'#9'closingdate'#9'F'#9
        'LastBankRecDate'#9'18'#9'LastBankRecDate'#9'F'#9
        'Amt35'#9'10'#9'Sales'#9'F'#9
        'Amt36'#9'10'#9'Sales'#9'F'#9
        'Amt37'#9'10'#9'Sales'#9'F'#9
        'Amt38'#9'10'#9'Sales'#9'F'#9)
      BorderStyle = bsSingle
      ExplicitLeft = 6
      ExplicitTop = 30
      ExplicitWidth = 561
      ExplicitHeight = 160
    end
    inherited mem_Note: TMemo
      Top = 30
      Width = 830
      Height = 0
      HelpContext = 1091018
      Lines.Strings = (
        '1.  '
        'Proper'
        'ty to '
        'set for '
        'Fixed '
        'filter    '
        ': '
        'FilterS'
        'tring'
        '2.  For '
        'totals '
        'in the '
        'Grid '
        'Footer '
        '     : '
        '            '
        '            '
        '   In '
        'formcr'
        'eate '
        'after '
        'inherit'
        'ed : '
        'AddCal'
        'cColu'
        'mn'
        '(Fieldn'
        'ame,is'
        'curren'
        'cy);'
        '            '
        '            '
        '   '
        'Overri'
        'de '
        #39'Refre'
        'shTotal'
        's'#39'  and '
        'Call  '
        #39'Calcn'
        'ShowF'
        'ooter'#39
        '            '
        '            '
        '   for '
        'extra '
        'calcula'
        'tion -> '
        'CalcF'
        'ooter ( '
        'called '
        'inside '
        'the '
        'loop of '
        ' '
        'qrymai'
        'n)'
        ''
        '            '
        '            '
        '            '
        '            '
        '       ')
      ExplicitTop = 30
      ExplicitWidth = 830
      ExplicitHeight = 0
    end
    inherited pnlMultiSelectList: TDNMPanel
      Left = 569
      Top = 30
      Height = 166
      TabOrder = 4
      ExplicitLeft = 569
      ExplicitTop = 30
      ExplicitHeight = 166
      HelpContext = 1091045
      inherited chkhideMultiSelectSelectionList: TCheckBox
        Top = 147
        ExplicitTop = 147
      end
    end
    object Shader1: TShader
      Left = 0
      Top = 0
      Width = 830
      Height = 30
      HelpContext = 1091019
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.4.0.0'
      object lblActiveForm: TLabel
        Left = 0
        Top = 0
        Width = 830
        Height = 30
        HelpContext = 1091020
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitTop = -1
      end
    end
    object pnlFxTrading: TDNMPanel
      Left = 0
      Top = 233
      Width = 830
      Height = 157
      HelpContext = 1091021
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Shader2: TShader
        Left = 1
        Top = 1
        Width = 828
        Height = 30
        HelpContext = 1091022
        Align = alTop
        Anchors = []
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
          Width = 828
          Height = 30
          HelpContext = 1091023
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'FX Trading List'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -1
          ExplicitTop = -1
        end
      end
    end
  end
  object pnlCategories: TDNMPanel [8]
    Left = 0
    Top = 62
    Width = 166
    Height = 406
    HelpContext = 1091024
    Align = alLeft
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Transparent = False
    object btnGeneral: TDNMSpeedButton
      Tag = 1
      Left = 12
      Top = 102
      Width = 148
      Height = 29
      HelpContext = 1091025
      Caption = 'General'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = mainbuttonclick
    end
    object btnPayables: TDNMSpeedButton
      Tag = 2
      Left = 12
      Top = 136
      Width = 148
      Height = 29
      HelpContext = 1091026
      Caption = 'Payables'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = mainbuttonclick
    end
    object btnReceivables: TDNMSpeedButton
      Tag = 3
      Left = 12
      Top = 170
      Width = 148
      Height = 29
      HelpContext = 1091027
      Caption = 'Receivables'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = mainbuttonclick
    end
    object btnLastWeek: TDNMSpeedButton
      Tag = 4
      Left = 13
      Top = 203
      Width = 148
      Height = 29
      HelpContext = 1091028
      Caption = 'Last Week (Ex)'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 3
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = mainbuttonclick
    end
    object btnLastMonth: TDNMSpeedButton
      Tag = 5
      Left = 12
      Top = 238
      Width = 148
      Height = 29
      HelpContext = 1091029
      Caption = 'Last Month (Ex)'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 4
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = mainbuttonclick
    end
    object btnLast3Months: TDNMSpeedButton
      Tag = 6
      Left = 12
      Top = 272
      Width = 148
      Height = 29
      HelpContext = 1091030
      Caption = 'Last 3 Months (Ex)'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 5
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = mainbuttonclick
    end
    object btnLast12Months: TDNMSpeedButton
      Tag = 8
      Left = 12
      Top = 340
      Width = 148
      Height = 29
      HelpContext = 1091031
      Caption = 'Last 12 Months (Ex)'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 6
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = mainbuttonclick
    end
    object btnAll: TDNMSpeedButton
      Left = 12
      Top = 34
      Width = 148
      Height = 29
      HelpContext = 1091032
      Caption = 'All'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 7
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = mainbuttonclick
    end
    object btnOpenList: TDNMSpeedButton
      Tag = -1
      Left = 12
      Top = 68
      Width = 148
      Height = 29
      HelpContext = 1091033
      Caption = 'Open all in List'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 8
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnOpenListClick
    end
    object btnRefresh: TDNMSpeedButton
      Left = 12
      Top = 0
      Width = 148
      Height = 29
      HelpContext = 1091034
      Caption = 'Refresh'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 9
      TabStop = False
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = mainbuttonclick
    end
    object btnLast6Months: TDNMSpeedButton
      Tag = 7
      Left = 12
      Top = 306
      Width = 148
      Height = 29
      HelpContext = 1091035
      Caption = 'Last 6 Months (Ex)'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 10
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = mainbuttonclick
    end
    object pnlcustomDate: TPanel
      Left = 12
      Top = 375
      Width = 148
      Height = 32
      HelpContext = 1091036
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 11
      OnClick = DoCustomDate
      DesignSize = (
        148
        32)
      object shpcustmdate: TShape
        Left = 1
        Top = 1
        Width = 146
        Height = 30
        HelpContext = 1091037
        Align = alClient
        Brush.Style = bsClear
        Shape = stRoundRect
        OnMouseDown = shpcustmdateMouseDown
        ExplicitLeft = 2
        ExplicitTop = -3
        ExplicitHeight = 27
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 8
        Width = 38
        Height = 15
        HelpContext = 1091038
        Caption = 'From  :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        OnClick = DoCustomDate
      end
      object dtcustomFrom: TwwDBDateTimePicker
        Tag = 9
        Left = 52
        Top = 4
        Width = 86
        Height = 23
        HelpContext = 1091039
        TabStop = False
        Anchors = [akTop, akRight]
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        CalendarAttributes.PopupYearOptions.NumberColumns = 6
        CalendarAttributes.PopupYearOptions.StartYear = 1980
        Date = 37432.000000000000000000
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        ShowButton = True
        TabOrder = 0
        UnboundDataType = wwDTEdtDate
        OnCloseUp = DoCustomDatechange
        OnChange = DoCustomDatechange
      end
    end
  end
  inherited FooterPanel: TDNMPanel
    HelpContext = 1091049
    inherited btnCustomize: TDNMSpeedButton
      Left = 84
      ExplicitLeft = 84
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 185
      ExplicitLeft = 185
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 389
      ExplicitLeft = 389
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 694
      ExplicitLeft = 694
    end
    inherited chkShowEmailOptions: TCheckBox
      TabOrder = 10
    end
    inherited btnSelectDbs: TDNMSpeedButton
      Left = 490
      ExplicitLeft = 490
    end
    object btnHowTo: TDNMSpeedButton
      Left = 287
      Top = 30
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = 'How To'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnHowToClick
      HelpContext = 1091046
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 592
      Top = 30
      Width = 87
      Height = 27
      HelpContext = 1091047
      Anchors = [akBottom]
      Caption = 'Detail'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton1Click
    end
  end
  inherited imgPopup: TImageList
    Bitmap = {
      494C010108002402740210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000BFBFBF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF00000000000000000000FFFF000000
      00000000000000FFFF0000000000000000000000000000FFFF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000FFFFFF000000000000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000007F7F7F000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF007F7F7F0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000FFFF0000000000FFFFFF007F7F7F00FFFFFF000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000000000FFFFFF0000FFFF007F7F7F0000FFFF00FFFFFF000000000000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000FFFF00FFFFFF007F7F7F00FFFFFF0000FFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000000000000000FF000000
      FF000000FF000000FF000000000000FF000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF00000000000000000000FFFF0000FF
      FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000FF
      FF0000FFFF00000000000000000000000000000000007F7F7F000000FF000000
      FF000000FF000000000000FF000000FF000000FF000000000000FF000000FF00
      0000FF0000007F7F7F0000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000000000FFFFFF0000FFFF00FFFFFF000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      FF000000000000FF000000FF000000FF000000FF000000FF000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000FF000000FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00000000000000000000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000FFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      000000000000000000000000000000000000000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008080000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF0000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000080800000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000808000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000808000008080000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008080000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FDFF8000FEFFFFFFF8FF8000FC7FF83F
      F8FFC000FC7F1010F87FE000D837E00FF81FF000E00FC007F80FF800E00F8003
      F00FFC00C0078003E00F0600C0078003E00F070000018003E00F0180C0078003
      F01F0180C007C007F00F0060E00FE00FF00FC060E00F3018F007C060D837F83F
      F007F044FEFFFFFFF007F07EFEFFFFFFFFFDFFFF847FE00FFFF8FFFF00EFE00F
      FFF1F9FF31BFE00FFFE3F0FF39FFF00FFFC7F0FF993FF00FE08FE07FCA1FF80F
      C01FC07FF40FF007803F843F9C07F007001F1E3F9603F007001FFE1FCB01F00F
      001FFF1FFF80F01F001FFF8FF7C0F81F001FFFC7FFE0FE1F803FFFE3EFF0FF1F
      C07FFFF8FFF8FF1FE0FFFFFFFFFCFFBF00000000000000000000000000000000
      000000000000}
  end
  inherited qryMain: TERPQuery
    Left = 44
    object qryMainAmt35: TFloatField
      DisplayLabel = 'Sales'
      DisplayWidth = 10
      FieldName = 'Amt35'
      currency = True
    end
    object qryMainAmt36: TFloatField
      DisplayLabel = 'Sales'
      DisplayWidth = 10
      FieldName = 'Amt36'
      currency = True
    end
    object qryMainAmt37: TFloatField
      DisplayLabel = 'Sales'
      DisplayWidth = 10
      FieldName = 'Amt37'
      currency = True
    end
    object qryMainAmt38: TFloatField
      DisplayLabel = 'Sales'
      DisplayWidth = 10
      FieldName = 'Amt38'
      currency = True
    end
  end
end
