inherited fmRepAbilityEdit: TfmRepAbilityEdit
  Left = 131
  Top = 251
  HelpContext = 708000
  Caption = 'Rep Ability'
  ClientHeight = 207
  ClientWidth = 481
  OldCreateOrder = True
  ExplicitWidth = 487
  ExplicitHeight = 232
  PixelsPerInch = 96
  TextHeight = 15
  object Label2: TLabel [1]
    Left = 32
    Top = 76
    Width = 102
    Height = 15
    HelpContext = 708017
    Caption = 'Ability Description'
    Transparent = True
  end
  object Label1: TLabel [2]
    Left = 32
    Top = 116
    Width = 69
    Height = 15
    HelpContext = 708018
    Caption = 'Ability Value'
    Transparent = True
  end
  object edtAbilityDesc: TwwDBEdit [5]
    Left = 144
    Top = 72
    Width = 297
    Height = 23
    HelpContext = 708019
    DataField = 'AbilityDesc'
    DataSource = dsAbility
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
    OnChange = edtAbilityDescChange
  end
  object edtAbilityValue: TwwDBEdit [6]
    Left = 144
    Top = 112
    Width = 57
    Height = 23
    HelpContext = 708020
    DataField = 'AbilityValue'
    DataSource = dsAbility
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnChange = edtAbilityValueChange
  end
  object pnlTitle: TDNMPanel [7]
    Left = 76
    Top = 6
    Width = 330
    Height = 41
    HelpContext = 708021
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 326
      Height = 37
      HelpContext = 708022
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
        Width = 326
        Height = 37
        HelpContext = 708023
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Rep Ability'
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
  object pnlBottom: TDNMPanel [8]
    Left = 0
    Top = 163
    Width = 481
    Height = 44
    HelpContext = 708024
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      481
      44)
    object btnSave: TDNMSpeedButton
      Left = 97
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 708001
      Action = actSave
      Anchors = [akBottom]
      Caption = 'Save'
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
    end
    object btnNew: TDNMSpeedButton
      Left = 197
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 708002
      Action = actNew
      Anchors = [akBottom]
      Caption = 'New'
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
      TabOrder = 1
    end
    object btnCancel: TDNMSpeedButton
      Left = 298
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 708003
      Action = actCancel
      Anchors = [akBottom]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
    end
    object chkActive: TwwCheckBox
      Left = 412
      Top = 9
      Width = 65
      Height = 17
      HelpContext = 708025
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akTop, akRight]
      Caption = 'Active'
      DataField = 'Active'
      DataSource = dsAbility
      TabOrder = 3
      OnClick = chkActiveClick
    end
  end
  inherited MyConnection: TERPConnection
    Username = ''
    Password = ''
  end
  object qryAbility: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblAbility where AbilityID = :ID')
    Left = 296
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryAbilityGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryAbilityAbilityID: TIntegerField
      FieldName = 'AbilityID'
    end
    object qryAbilityAbilityDesc: TWideStringField
      FieldName = 'AbilityDesc'
      Size = 50
    end
    object qryAbilityAbilityValue: TIntegerField
      FieldName = 'AbilityValue'
    end
    object qryAbilityActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryAbilityEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryAbilitymsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object ActionList: TActionList
    Left = 216
    Top = 40
    object actSave: TAction
      Caption = 'Save'
      HelpContext = 708014
      OnExecute = actSaveExecute
    end
    object actCancel: TAction
      Caption = 'Cancel'
      HelpContext = 708015
      OnExecute = actCancelExecute
    end
    object actNew: TAction
      Caption = 'New'
      HelpContext = 708016
      OnExecute = actNewExecute
    end
  end
  object dsAbility: TDataSource
    DataSet = qryAbility
    Left = 304
    Top = 48
  end
end
