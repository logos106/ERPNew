inherited fmStSChangePhase: TfmStSChangePhase
  Left = 500
  Top = 121
  Caption = 'Change of Phase'
  ClientHeight = 466
  ClientWidth = 1001
  Position = poMainFormCenter
  ExplicitWidth = 1007
  ExplicitHeight = 495
  DesignSize = (
    1001
    466)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 423
    Width = 1001
    ExplicitTop = 389
    ExplicitWidth = 767
  end
  inherited shapehint: TShape
    Left = 22
    ExplicitLeft = 13
  end
  inherited shapehintextra1: TShape
    Left = 91
    ExplicitLeft = 66
  end
  inherited pnlFooter: TDNMPanel
    Top = 423
    Width = 1001
    ExplicitTop = 423
    ExplicitWidth = 1001
    DesignSize = (
      1001
      43)
    inherited btnCompleted: TDNMSpeedButton
      Left = 395
      Top = 6
      Anchors = []
      OnClick = btnCompletedClick
      ExplicitLeft = 395
      ExplicitTop = 6
    end
    inherited btnClose: TDNMSpeedButton
      Left = 515
      Anchors = []
      OnClick = btnCloseClick
      ExplicitLeft = 515
    end
  end
  inherited pnlHeader: TDNMPanel
    Width = 1001
    ExplicitWidth = 1001
    DesignSize = (
      1001
      57)
    inherited pnlTitle: TDNMPanel
      Width = 737
      ExplicitWidth = 737
      inherited TitleShader: TShader
        Width = 735
        ExplicitWidth = 735
        inherited TitleLabel: TLabel
          Width = 735
          Caption = 'Change of Phase (Base)'
          ExplicitWidth = 501
        end
      end
    end
  end
  inherited pnlDetails: TDNMPanel
    Width = 1001
    Height = 366
    ExplicitWidth = 1001
    ExplicitHeight = 366
    object Shape4: TShape
      Left = 1
      Top = 231
      Width = 999
      Height = 2
      Align = alTop
      Brush.Style = bsClear
      ExplicitLeft = 0
      ExplicitTop = 82
    end
    object Shape6: TShape
      Left = 1
      Top = 1
      Width = 999
      Height = 2
      Align = alTop
      Brush.Style = bsClear
      ExplicitLeft = 0
      ExplicitTop = 2
      ExplicitWidth = 993
    end
    object Shape7: TShape
      Left = 1
      Top = 363
      Width = 999
      Height = 2
      Align = alBottom
      Brush.Style = bsClear
      ExplicitLeft = 4
      ExplicitTop = 555
      ExplicitWidth = 993
    end
    object pnlPlantPhaseOptions: TDNMPanel
      Left = 1
      Top = 3
      Width = 999
      Height = 91
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 772
        Height = 22
        Margins.Right = 222
        Align = alTop
        Caption = 'Change Phase To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        ExplicitWidth = 164
      end
      object btnImmature: TDNMSpeedButton
        Tag = 1
        AlignWithMargins = True
        Left = 4
        Top = 37
        Width = 160
        Height = 43
        HelpContext = 251008
        Margins.Left = 4
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Immature'
        Color = 10813348
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        LightColor = 10813348
        ParentColor = False
        ParentFont = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 0
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = ChoosePhase
      end
      object btnVegetative: TDNMSpeedButton
        Tag = 2
        AlignWithMargins = True
        Left = 169
        Top = 37
        Width = 160
        Height = 43
        HelpContext = 251008
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Vegetative'
        Color = 4652870
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        LightColor = 4652870
        ParentColor = False
        ParentFont = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 1
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = ChoosePhase
      end
      object btnFlowering: TDNMSpeedButton
        Tag = 3
        AlignWithMargins = True
        Left = 334
        Top = 37
        Width = 160
        Height = 43
        HelpContext = 251008
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Flowering'
        Color = clGreen
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        LightColor = clGreen
        ParentColor = False
        ParentFont = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 2
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = ChoosePhase
      end
      object btnHarvest: TDNMSpeedButton
        Tag = 4
        AlignWithMargins = True
        Left = 499
        Top = 37
        Width = 160
        Height = 43
        HelpContext = 251008
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Harvesting'
        Color = 11060735
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        LightColor = 11060735
        ParentColor = False
        ParentFont = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 3
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = ChoosePhase
      end
      object btnDestroy: TDNMSpeedButton
        Tag = 6
        AlignWithMargins = True
        Left = 664
        Top = 37
        Width = 160
        Height = 43
        HelpContext = 251008
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 4
        Margins.Bottom = 2
        Caption = 'Destroy'
        Color = clRed
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        LightColor = clRed
        ParentColor = False
        ParentFont = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 4
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = ChoosePhase
      end
      object btnPackage: TDNMSpeedButton
        Tag = 6
        AlignWithMargins = True
        Left = 828
        Top = 37
        Width = 160
        Height = 43
        HelpContext = 251008
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 4
        Margins.Bottom = 2
        Caption = 'Package'
        Color = clSkyBlue
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        LightColor = clSkyBlue
        ParentColor = False
        ParentFont = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 5
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = ChoosePhase
      end
    end
    object pnDetails: TDNMPanel
      Left = 1
      Top = 94
      Width = 999
      Height = 137
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object pnlDept: TDNMPanel
        Left = 32
        Top = 14
        Width = 320
        Height = 51
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label6: TLabel
          Left = 24
          Top = 8
          Width = 73
          Height = 15
          Alignment = taRightJustify
          Caption = 'Department :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtDept: TwwDBEdit
          Left = 111
          Top = 8
          Width = 145
          Height = 23
          TabStop = False
          Enabled = False
          ReadOnly = True
          TabOrder = 0
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object DNMSpeedButton1: TDNMSpeedButton
          AlignWithMargins = True
          Left = 275
          Top = 11
          Width = 34
          Height = 24
          Caption = '. . .'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton1Click
        end
      end
      object pnlUsedOn: TDNMPanel
        Left = 40
        Top = 68
        Width = 248
        Height = 54
        Margins.Left = 10
        Margins.Top = 20
        Margins.Right = 5
        Margins.Bottom = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label5: TLabel
          AlignWithMargins = True
          Left = 9
          Top = 4
          Width = 32
          Height = 46
          Margins.Left = 8
          Align = alLeft
          Caption = 'Date :'
          Layout = tlCenter
          ExplicitHeight = 15
        end
        object dtUsedOn: TwwDBDateTimePicker
          Left = 47
          Top = 14
          Width = 186
          Height = 23
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'Tahoma'
          CalendarAttributes.Font.Style = []
          DataField = 'PhaseCreatedOn'
          DataSource = dsStSTagPhases
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 0
        end
      end
      object pnlcbobin: TDNMPanel
        Left = 307
        Top = 71
        Width = 248
        Height = 54
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object lblbin: TLabel
          Left = 13
          Top = 16
          Width = 75
          Height = 15
          Alignment = taRightJustify
          Caption = 'Product Bin : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object cbobin: TwwDBLookupCombo
          Left = 94
          Top = 12
          Width = 151
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'bin'#9'61'#9'bin'#9'F')
          LookupTable = QryBin
          LookupField = 'binId'
          ParentFont = False
          TabOrder = 0
          Visible = False
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cbobinCloseUp
          OnEnter = cbobinEnter
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 652
    Top = 328
  end
  inherited tmrdelay: TTimer
    Left = 688
    Top = 328
  end
  inherited popSpelling: TPopupMenu
    Left = 336
    Top = 328
  end
  inherited tmrdelayMsg: TTimer
    Left = 624
    Top = 328
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 441
    Top = 328
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 477
    Top = 328
  end
  inherited MyConnection: TERPConnection
    Left = 266
    Top = 295
  end
  inherited DataState: TDataState
    Left = 512
    Top = 328
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 371
    Top = 328
  end
  inherited imgsort: TImageList
    Left = 547
    Top = 328
    Bitmap = {
      494C010102004801500310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 266
    Top = 328
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 582
    Top = 328
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 406
    Top = 328
  end
  inherited qryMemTrans: TERPQuery
    Left = 301
    Top = 328
  end
  inherited tmrOnshow: TTimer
    Left = 728
    Top = 328
  end
  object dsStSTagPhases: TDataSource
    Left = 233
    Top = 326
  end
  object QryBin: TERPQuery
    Connection = fmStSMain.MyConnection
    SQL.Strings = (
      
        'SELECT classId ,binId, concat(binlocation , '#39'-'#39',binnumber ) AS b' +
        'in FROM tblproductbin WHERE classId = :ClassId')
    BeforeOpen = QryBinBeforeOpen
    AfterOpen = QryBinAfterOpen
    Left = 760
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClassId'
      end>
    object QryBinbin: TWideStringField
      DisplayWidth = 61
      FieldName = 'bin'
      Size = 61
    end
    object QryBinbinId: TIntegerField
      FieldName = 'binId'
      Visible = False
    end
    object QryBinClassId: TIntegerField
      DisplayLabel = 'ClassId'
      FieldName = 'Classid'
      Visible = False
    end
  end
end
