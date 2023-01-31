inherited SetupCustomerDisplayGUI: TSetupCustomerDisplayGUI
  Left = 403
  Top = 233
  HelpContext = 495000
  Caption = 'Setup Customer Display'
  ClientHeight = 371
  ClientWidth = 449
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object EnableCustDisplaylbl: TLabel [0]
    Left = 48
    Top = 68
    Width = 153
    Height = 17
    HelpContext = 495002
    AutoSize = False
    Caption = 'Enable Customer Display'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    WordWrap = True
  end
  object EnablePPlbl: TLabel [1]
    Left = 48
    Top = 94
    Width = 197
    Height = 17
    HelpContext = 495003
    AutoSize = False
    Caption = 'Enable Power Point Screen Saver'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    WordWrap = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 495001
  end
  object btnSave: TDNMSpeedButton [3]
    Left = 112
    Top = 333
    Width = 87
    Height = 27
    HelpContext = 495004
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [4]
    Left = 264
    Top = 333
    Width = 87
    Height = 27
    HelpContext = 495005
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
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object EnableCustDisplay: TwwCheckBox [5]
    Left = 27
    Top = 68
    Width = 15
    Height = 17
    HelpContext = 495006
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Action = DisplayRefresh
    DataField = 'EnableCustomerDisplay'
    DataSource = DSTills
    TabOrder = 2
  end
  object EnablePPSaver: TwwCheckBox [6]
    Left = 27
    Top = 94
    Width = 15
    Height = 17
    HelpContext = 495007
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'wwCheckBox1'
    DataField = 'EnablePPScreenSaver'
    DataSource = DSTills
    TabOrder = 3
  end
  object pnlPPSettings: TDNMPanel [7]
    Left = 26
    Top = 114
    Width = 396
    Height = 213
    HelpContext = 495008
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label1: TLabel
      Left = 21
      Top = 53
      Width = 93
      Height = 15
      HelpContext = 495009
      Caption = 'Transition Effect'
      Transparent = True
    end
    object Label3: TLabel
      Left = 183
      Top = 121
      Width = 50
      Height = 15
      HelpContext = 495010
      Caption = 'Seconds'
      Transparent = True
    end
    object Label4: TLabel
      Left = 21
      Top = 87
      Width = 96
      Height = 15
      HelpContext = 495011
      Caption = 'Transition Speed'
      Transparent = True
    end
    object Label69: TLabel
      Left = 21
      Top = 155
      Width = 252
      Height = 15
      HelpContext = 495012
      AutoSize = False
      Caption = 'Enter Path And Filename of Power Point File :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label6: TLabel
      Left = 21
      Top = 121
      Width = 117
      Height = 17
      HelpContext = 495013
      AutoSize = False
      Caption = 'Advance Slide Every'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label7: TLabel
      Left = 21
      Top = 19
      Width = 49
      Height = 15
      HelpContext = 495014
      Caption = 'Idle Wait'
      Transparent = True
    end
    object Label8: TLabel
      Left = 123
      Top = 19
      Width = 45
      Height = 15
      HelpContext = 495015
      Caption = 'Minutes'
      Transparent = True
    end
    object SpeedButton1: TDNMSpeedButton
      Left = 356
      Top = 169
      Width = 27
      Height = 26
      HelpContext = 495016
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        555555555555555555555555555555555555555FFFFFFFFFF555550000000000
        55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
        B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
        000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
        555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
        55555575FFF75555555555700007555555555557777555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 5
      OnClick = SpeedButton1Click
    end
    object txtPath: TDBEdit
      Left = 20
      Top = 171
      Width = 331
      Height = 23
      HelpContext = 495017
      DataField = 'PPPathFileName'
      DataSource = DSTills
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object cbxTransitionEffect: TwwDBComboBox
      Left = 121
      Top = 49
      Width = 145
      Height = 23
      HelpContext = 495018
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      DataField = 'PPTransitionEffect'
      DataSource = DSTills
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      Items.Strings = (
        'None'#9'0'
        'Cut'#9'1'
        'CutThroughBlack'#9'2'
        'Random'#9'3'
        'BlindsHorizontal'#9'4'
        'BlindsVertical'#9'5'
        'CheckerboardAcross'#9'6'
        'CheckerboardDown'#9'7'
        'CoverLeft'#9'8'
        'CoverUp'#9'9'
        'CoverRight'#9'10'
        'CoverDown'#9'11'
        'CoverLeftUp'#9'12'
        'CoverRightUp'#9'13'
        'CoverLeftDown'#9'14'
        'CoverRightDown'#9'15'
        'Dissolve'#9'16'
        'Fade'#9'17'
        'UncoverLeft'#9'18'
        'UncoverUp'#9'19'
        'UncoverRight'#9'20'
        'UncoverDown'#9'21'
        'UncoverLeftUp'#9'22'
        'UncoverRightUp'#9'23'
        'UncoverLeftDown'#9'24'
        'UncoverRightDown'#9'25'
        'RandomBarsHorizontal'#9'26'
        'RandomBarsVertical'#9'27'
        'StripsUpLeft'#9'28'
        'StripsUpRight'#9'29'
        'StripsDownLeft'#9'30'
        'StripsDownRight'#9'31'
        'StripsLeftUp'#9'32'
        'StripsRightUp'#9'33'
        'StripsLeftDown'#9'34'
        'StripsRightDown'#9'35'
        'WipeLeft'#9'36'
        'WipeUp'#9'37'
        'WipeRight'#9'38'
        'WipeDown'#9'39'
        'BoxOut'#9'40'
        'BoxIn'#9'41'
        'SplitHorizontalOut'#9'42'
        'SplitHorizontalIn'#9'43'
        'SplitVerticalOut'#9'44'
        'SplitVerticalIn'#9'45'
        'Appear'#9'46')
      ParentFont = False
      Sorted = False
      TabOrder = 1
      UnboundDataType = wwDefault
    end
    object cbxTransitionSpeed: TwwDBComboBox
      Left = 121
      Top = 83
      Width = 145
      Height = 23
      HelpContext = 495019
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      DataField = 'PPTransitionSpeed'
      DataSource = DSTills
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      Items.Strings = (
        'Mixed'#9'0'
        'Slow'#9'1'
        'Medium'#9'2'
        'Fast'#9'3')
      ParentFont = False
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
    end
    object edtAdvanceTime: TwwDBSpinEdit
      Left = 139
      Top = 117
      Width = 42
      Height = 23
      HelpContext = 495020
      Increment = 1
      DataField = 'PPSlideCycle'
      DataSource = DSTills
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
    end
    object IdleWait: TwwDBSpinEdit
      Left = 78
      Top = 14
      Width = 42
      Height = 23
      HelpContext = 495021
      Increment = 1
      DataField = 'IdleWait'
      DataSource = DSTills
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      UnboundDataType = wwDefault
    end
  end
  object pnlTitle: TDNMPanel [8]
    Left = 40
    Top = 6
    Width = 378
    Height = 45
    HelpContext = 495022
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 374
      Height = 41
      HelpContext = 495023
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.2.1.1'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 374
        Height = 41
        HelpContext = 495024
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Setup Customer Display'
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
  inherited ApplicationEvents1: TApplicationEvents
    Left = 71
    Top = 65531
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 7
    Top = 65531
  end
  inherited MyConnection: TERPConnection
    Left = 103
    Top = 65530
  end
  object qryTills: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select TillID,EnableCustomerDisplay,EnablePPScreenSaver,PPPathFi' +
        'leName,PPTransitionEffect,PPTransitionSpeed,PPSlideCycle,IdleWai' +
        't '
      'From tblpostills Where TillID = :xTillID;')
    Left = 410
    Top = 15
    ParamData = <
      item
        DataType = ftString
        Name = 'xTillID'
        Value = ''
      end>
  end
  object DSTills: TDataSource
    DataSet = qryTills
    Left = 413
    Top = 47
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'pdi'
    Filter = 'PowerPoint Presentations (*.ppt)|*.ppt'
    Left = 136
    Top = 65533
  end
  object ActionList1: TActionList
    Left = 6
    Top = 29
    object DisplayRefresh: TAction
      Caption = 'DisplayRefresh'
      OnUpdate = DisplayRefreshUpdate
      HelpContext = 495025
    end
  end
end
