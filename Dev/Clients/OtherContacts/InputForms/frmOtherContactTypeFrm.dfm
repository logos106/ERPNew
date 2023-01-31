inherited frmOtherContactType: TfrmOtherContactType
  Left = 508
  Top = 221
  HelpContext = 311000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Contact Type'
  ClientHeight = 161
  ClientWidth = 386
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object PaymentMethod_Label: TLabel [1]
    Left = 56
    Top = 73
    Width = 100
    Height = 18
    HelpContext = 311002
    AutoSize = False
    Caption = 'Contact Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object OtherType: TDBEdit [2]
    Left = 167
    Top = 70
    Width = 154
    Height = 23
    HelpContext = 311003
    Color = clWhite
    DataField = 'OtherType'
    DataSource = frmOtherContactTypeSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object cmdOk: TDNMSpeedButton [3]
    Left = 36
    Top = 118
    Width = 87
    Height = 27
    HelpContext = 311004
    Caption = 'O&K'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
    TabStop = False
    OnClick = cmdOkClick
  end
  object cmdNew: TDNMSpeedButton [4]
    Left = 147
    Top = 118
    Width = 87
    Height = 27
    HelpContext = 311005
    Caption = '&New'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
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
    TabOrder = 2
    TabStop = False
    OnClick = cmdNewClick
  end
  object cmdCancel: TDNMSpeedButton [5]
    Left = 260
    Top = 118
    Width = 87
    Height = 27
    HelpContext = 311006
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
    TabOrder = 3
    TabStop = False
    OnClick = cmdCancelClick
  end
  object pnlTitle: TDNMPanel [6]
    Left = 69
    Top = 6
    Width = 238
    Height = 41
    HelpContext = 311007
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 37
      HelpContext = 311008
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
        Width = 234
        Height = 37
        HelpContext = 311009
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Contact Type'
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
  object frmOtherContactTypeSrc: TDataSource
    DataSet = qryOtherContactType
    Left = 18
    Top = 73
  end
  object qryOtherContactType: TERPQuery
    SQL.Strings = (
      'SELECT OtherTypeID, OtherType, EditedFlag FROM tblOtherType'
      'WHERE OtherTypeID =:OTID;')
    Left = 18
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'OTID'
        Size = 255
      end>
  end
  object memQryOtherContactType: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'OtherTypeID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'OtherType'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 19
    Top = 40
  end
end
