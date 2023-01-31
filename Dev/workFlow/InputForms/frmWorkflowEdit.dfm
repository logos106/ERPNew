inherited fmWorkflowEdit: TfmWorkflowEdit
  Left = 478
  Top = 160
  HelpContext = 1205002
  BorderStyle = bsSingle
  Caption = 'Workflow'
  ClientHeight = 268
  ClientWidth = 740
  Color = clWhite
  TransparentColor = True
  TransparentColorValue = clWhite
  KeyPreview = True
  OnResize = FormResize
  ExplicitLeft = 478
  ExplicitTop = 160
  ExplicitWidth = 756
  ExplicitHeight = 307
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 268
    Width = 740
    HelpContext = 1205003
    ExplicitTop = 107
    ExplicitWidth = 665
  end
  inherited shapehint: TShape
    Left = 167
    Top = 113
    ExplicitLeft = 167
    ExplicitTop = 113
  end
  inherited shapehintextra1: TShape
    Left = 255
    Top = 113
    ExplicitLeft = 255
    ExplicitTop = 113
  end
  object pnlDetails: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 740
    Height = 268
    HelpContext = 1205004
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnExit = PostLineOnExit
    ExplicitWidth = 934
    ExplicitHeight = 177
    object grdMain: TwwDBGrid
      Left = 1
      Top = 1
      Width = 712
      Height = 88
      HelpContext = 1205005
      Selected.Strings = (
        'EventName'#9'30'#9'EventName'#9'F'
        'ControlParent'#9'60'#9'Coding control Panel'#9'T'
        'MenuName'#9'60'#9'Menu'#9'T')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = False
      Align = alClient
      DataSource = dsworkflowLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      ParentFont = False
      ParentShowHint = False
      PopupMenu = mnuGrid
      ShowHint = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnDblClick = grdMainDblClick
      OnEnter = grdMainEnter
      OnKeyDown = edtEventNameKeyDown
      FooterCellColor = clWhite
      object grdMainIButton: TwwIButton
        Left = -2
        Top = 0
        Width = 17
        Height = 22
        HelpContext = 1205006
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
        OnClick = grdMainIButtonClick
      end
    end
    object pnlworkflowLineDetails: TDNMPanel
      Left = 1
      Top = 89
      Width = 738
      Height = 145
      HelpContext = 1205007
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnExit = pnlworkflowLineDetailsExit
      DesignSize = (
        738
        145)
      object Label1: TLabel
        Left = 21
        Top = 13
        Width = 34
        Height = 15
        HelpContext = 1205008
        Anchors = []
        AutoSize = False
        Caption = 'Form '
        ExplicitLeft = 17
      end
      object Label2: TLabel
        Left = 11
        Top = 47
        Width = 43
        Height = 15
        HelpContext = 1205009
        Anchors = []
        AutoSize = False
        Caption = 'Control'
        ExplicitLeft = 8
      end
      object Label3: TLabel
        Left = 17
        Top = 81
        Width = 38
        Height = 15
        HelpContext = 1205010
        Anchors = []
        AutoSize = False
        Caption = 'Action'
        ExplicitLeft = 13
      end
      object Label4: TLabel
        Left = 27
        Top = 116
        Width = 28
        Height = 15
        HelpContext = 1205011
        Anchors = []
        AutoSize = False
        Caption = 'Field'
        ExplicitLeft = 23
      end
      object Label5: TLabel
        Left = 384
        Top = 47
        Width = 42
        Height = 15
        HelpContext = 1205012
        Anchors = []
        AutoSize = False
        Caption = 'Combo'
        ExplicitLeft = 343
      end
      object Label6: TLabel
        Left = 371
        Top = 81
        Width = 54
        Height = 15
        HelpContext = 1205013
        Anchors = []
        AutoSize = False
        Caption = 'Property '
        ExplicitLeft = 331
      end
      object Label7: TLabel
        Left = 394
        Top = 116
        Width = 33
        Height = 15
        HelpContext = 1205014
        Anchors = []
        AutoSize = False
        Caption = 'Value'
        ExplicitLeft = 352
      end
      object edtFormClassName: TDBEdit
        Left = 82
        Top = 9
        Width = 322
        Height = 23
        HelpContext = 1205015
        Anchors = []
        AutoSize = False
        DataField = 'FormClassName'
        DataSource = dsworkflowLines
        ReadOnly = True
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 448
        Top = 9
        Width = 265
        Height = 23
        HelpContext = 1205016
        Anchors = []
        AutoSize = False
        DataField = 'formName'
        DataSource = dsworkflowLines
        ReadOnly = True
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 78
        Top = 43
        Width = 265
        Height = 23
        HelpContext = 1205017
        Anchors = []
        AutoSize = False
        DataField = 'Controlname'
        DataSource = dsworkflowLines
        ReadOnly = True
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 78
        Top = 77
        Width = 265
        Height = 23
        HelpContext = 1205018
        Anchors = []
        AutoSize = False
        DataField = 'buttonActionName'
        DataSource = dsworkflowLines
        ReadOnly = True
        TabOrder = 3
      end
      object DBEdit5: TDBEdit
        Left = 78
        Top = 112
        Width = 265
        Height = 23
        HelpContext = 1205019
        Anchors = []
        AutoSize = False
        DataField = 'fieldname'
        DataSource = dsworkflowLines
        ReadOnly = True
        TabOrder = 4
      end
      object DBEdit6: TDBEdit
        Left = 448
        Top = 43
        Width = 265
        Height = 23
        HelpContext = 1205020
        Anchors = []
        AutoSize = False
        DataField = 'Gridcomboname'
        DataSource = dsworkflowLines
        ReadOnly = True
        TabOrder = 5
      end
      object DBEdit7: TDBEdit
        Left = 448
        Top = 77
        Width = 265
        Height = 23
        HelpContext = 1205021
        Anchors = []
        AutoSize = False
        DataField = 'Propname'
        DataSource = dsworkflowLines
        ReadOnly = True
        TabOrder = 6
      end
      object DBEdit8: TDBEdit
        Left = 448
        Top = 112
        Width = 265
        Height = 23
        HelpContext = 1205022
        Anchors = []
        AutoSize = False
        DataField = 'value'
        DataSource = dsworkflowLines
        ReadOnly = True
        TabOrder = 7
      end
    end
    object pnlbtns: TDNMPanel
      Left = 1
      Top = 234
      Width = 738
      Height = 33
      HelpContext = 1205023
      Align = alBottom
      Anchors = [akLeft, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ExplicitLeft = -23
      ExplicitTop = 179
      ExplicitWidth = 932
      DesignSize = (
        738
        33)
      object btnSave: TDNMSpeedButton
        Left = 460
        Top = 3
        Width = 107
        Height = 25
        HelpContext = 1205024
        Anchors = [akTop, akBottom]
        Caption = 'Stop Recording'
        Color = 11075496
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        Layout = blGlyphTop
        ParentColor = False
        ParentFont = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 0
        OnClick = btnSaveClick
        ExplicitLeft = 443
      end
      object btnCancel: TDNMSpeedButton
        Left = 173
        Top = 6
        Width = 107
        Height = 25
        HelpContext = 1205025
        Anchors = [akTop, akBottom]
        Caption = 'Cancel Recording'
        Color = 9211135
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        Layout = blGlyphTop
        ParentColor = False
        ParentFont = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 1
        OnClick = btnCancelClick
        ExplicitLeft = 166
      end
    end
    object pnlbuttons: TDNMPanel
      Left = 713
      Top = 1
      Width = 26
      Height = 88
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      HelpContext = 1205027
      object btnup: TDNMSpeedButton
        Left = 0
        Top = 20
        Width = 25
        Height = 23
        Caption = #8593
        Color = 15519380
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        LightColor = 16574164
        ParentColor = False
        ParentFont = False
        Style = bsModern
        TabOrder = 0
        OnClick = btnupClick
        HelpContext = 1205028
      end
      object btndown: TDNMSpeedButton
        Left = 0
        Top = 44
        Width = 25
        Height = 23
        Caption = #8595
        Color = 15519380
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        LightColor = 16574164
        ParentColor = False
        ParentFont = False
        Style = bsModern
        TabOrder = 1
        OnClick = btndownClick
        HelpContext = 1205029
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 241
    Top = 15
  end
  inherited tmrdelay: TTimer
    Left = 192
    Top = 15
  end
  inherited popSpelling: TPopupMenu
    Left = 243
    Top = 47
  end
  object dsworkflowLines: TDataSource
    Left = 201
    Top = 46
  end
  object mnuGrid: TPopupMenu
    Left = 331
    Top = 55
    object DeleteAllEmpty1: TMenuItem
      Caption = 'Delete All Empty Events'
      HelpContext = 1205026
      OnClick = DeleteAllEmpty1Click
    end
  end
end
