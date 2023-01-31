inherited fmStateFreightEdit: TfmStateFreightEdit
  Caption = 'State Freight'
  ClientHeight = 258
  ClientWidth = 426
  ExplicitWidth = 442
  ExplicitHeight = 297
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1552002
  inherited lblSkingroupMsg: TLabel
    Top = 208
    Width = 426
    ExplicitTop = 258
    ExplicitWidth = 426
    HelpContext = 1552003
  end
  inherited shapehint: TShape
    Left = -5
    ExplicitLeft = -5
  end
  inherited imgGridWatermark: TImage
    Left = 369
    Top = -5
    ExplicitLeft = 369
    ExplicitTop = -5
  end
  inherited shapehintextra1: TShape
    Left = 15
    ExplicitLeft = 15
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 208
    Width = 426
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = 360
    ExplicitWidth = 150
    DesignSize = (
      426
      50)
    HelpContext = 1552004
    object cmdClose: TDNMSpeedButton
      Left = 86
      Top = 12
      Width = 87
      Height = 27
      Anchors = [akBottom]
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
      TabOrder = 0
      TabStop = False
      OnClick = cmdCloseClick
      HelpContext = 1552005
    end
    object cmdCancel: TDNMSpeedButton
      Left = 254
      Top = 12
      Width = 87
      Height = 27
      Anchors = [akBottom]
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnClick = cmdCancelClick
      HelpContext = 1552006
    end
  end
  object DNMPanel2: TDNMPanel [6]
    Left = 0
    Top = 58
    Width = 426
    Height = 150
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 61
    ExplicitHeight = 148
    DesignSize = (
      426
      150)
    HelpContext = 1552007
    object Label1: TLabel
      Left = 130
      Top = 21
      Width = 30
      Height = 15
      Alignment = taRightJustify
      Anchors = []
      Caption = 'State'
      ExplicitTop = 23
      HelpContext = 1552008
    end
    object Label2: TLabel
      Left = 112
      Top = 53
      Width = 48
      Height = 15
      Alignment = taRightJustify
      Anchors = []
      Caption = 'Percent '
      ExplicitTop = 56
      HelpContext = 1552009
    end
    object Label3: TLabel
      Left = 86
      Top = 84
      Width = 74
      Height = 15
      Alignment = taRightJustify
      Anchors = []
      Caption = 'Fixed Charge'
      ExplicitTop = 89
      HelpContext = 1552010
    end
    object Label4: TLabel
      Left = 125
      Top = 116
      Width = 35
      Height = 15
      Alignment = taRightJustify
      Anchors = []
      Caption = 'Active'
      ExplicitTop = 123
      HelpContext = 1552011
    end
    object cboState: TwwDBLookupCombo
      Left = 179
      Top = 17
      Width = 161
      Height = 23
      Anchors = []
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'State'
      DataSource = dsStateFreight
      LookupTable = qryStateLookup
      LookupField = 'State'
      DropDownWidth = 40
      ParentFont = False
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnNotInList = cboStateNotInList
      ExplicitTop = 19
      HelpContext = 1552012
    end
    object edtPercent: TDBEdit
      Left = 179
      Top = 50
      Width = 89
      Height = 23
      Anchors = []
      DataField = 'Percent'
      DataSource = dsStateFreight
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitTop = 53
      HelpContext = 1552013
    end
    object edtFixedAmount: TDBEdit
      Left = 179
      Top = 82
      Width = 89
      Height = 23
      Anchors = []
      DataField = 'FixedAmount'
      DataSource = dsStateFreight
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ExplicitTop = 87
      HelpContext = 1552014
    end
    object chkActive: TwwCheckBox
      Left = 179
      Top = 115
      Width = 17
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Anchors = []
      BiDiMode = bdLeftToRight
      Caption = 'Active'
      DataField = 'Active'
      DataSource = dsStateFreight
      ParentBiDiMode = False
      TabOrder = 3
      ExplicitTop = 122
      HelpContext = 1552015
    end
  end
  object DNMPanel3: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 426
    Height = 58
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      426
      58)
    HelpContext = 1552016
    object pnlTitle: TDNMPanel
      Left = 45
      Top = 7
      Width = 336
      Height = 45
      Anchors = []
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitTop = 3
      HelpContext = 1552017
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 332
        Height = 41
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
        HelpContext = 1552018
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 332
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'State Freight'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -2
          HelpContext = 1552019
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 404
    Top = 65528
  end
  inherited tmrdelay: TTimer
    Left = 440
    Top = 65528
  end
  inherited popSpelling: TPopupMenu
    Left = 88
    Top = 65528
  end
  inherited tmrdelayMsg: TTimer
    Left = 0
    Top = 104
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 193
    Top = 65528
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 229
    Top = 65528
  end
  inherited DataState: TDataState
    Left = 264
    Top = 65528
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 123
    Top = 65528
  end
  inherited imgsort: TImageList
    Left = 299
    Top = 65528
  end
  inherited QryCustomField: TERPQuery
    Left = 18
    Top = 65528
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 334
    Top = 65528
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 158
    Top = 65528
  end
  inherited qryMemTrans: TERPQuery
    Left = 53
    Top = 65528
  end
  object qryStateFreight: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblstatefreight')
    Left = 352
    Top = 88
    object qryStateFreightGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryStateFreightID: TIntegerField
      FieldName = 'ID'
    end
    object qryStateFreightState: TWideStringField
      FieldName = 'State'
      Size = 255
    end
    object qryStateFreightPercent: TFloatField
      FieldName = 'Percent'
    end
    object qryStateFreightFixedAmount: TFloatField
      FieldName = 'FixedAmount'
      currency = True
    end
    object qryStateFreightRegionID: TIntegerField
      FieldName = 'RegionID'
    end
    object qryStateFreightActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryStateFreightmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryStateFreightmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object dsStateFreight: TDataSource
    DataSet = qryStateFreight
    Left = 336
    Top = 144
  end
  object qryStateLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select Distinct State from tblclients where Customer = "T" and n' +
        'ot (State = "" or IsNull(State))'
      'union'
      'select distinct State from tblStateFreight'
      'order by State')
    Left = 376
    Top = 56
  end
end
