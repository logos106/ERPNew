inherited fmStSChangePhaseSimple: TfmStSChangePhaseSimple
  Left = 462
  Top = 442
  Caption = 'fmStSChangePhaseSimple'
  ClientHeight = 566
  ClientWidth = 1007
  ExplicitWidth = 1013
  ExplicitHeight = 595
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 497
    Width = 1007
    ExplicitTop = 438
    ExplicitWidth = 838
  end
  inherited shapehint: TShape
    ExplicitLeft = 16
  end
  inherited shapehintextra1: TShape
    Left = 92
    ExplicitLeft = 74
  end
  inherited pnlFooter: TDNMPanel
    Top = 497
    Width = 1007
    Height = 69
    ExplicitTop = 497
    ExplicitWidth = 1007
    ExplicitHeight = 69
    object lblMsg: TLabel [0]
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 999
      Height = 15
      Align = alTop
      Alignment = taCenter
      Caption = 'Changing from Immature to Vegitative'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      Visible = False
      ExplicitWidth = 213
    end
    inherited btnCompleted: TDNMSpeedButton
      Left = 282
      Top = 23
      Width = 160
      Height = 34
      ExplicitLeft = 282
      ExplicitTop = 23
      ExplicitWidth = 160
      ExplicitHeight = 34
    end
    inherited btnClose: TDNMSpeedButton
      Left = 565
      Top = 23
      Width = 160
      Height = 34
      ExplicitLeft = 565
      ExplicitTop = 23
      ExplicitWidth = 160
      ExplicitHeight = 34
    end
  end
  inherited pnlHeader: TDNMPanel
    Width = 1007
    TabOrder = 0
    ExplicitWidth = 1007
    inherited pnlTitle: TDNMPanel
      Width = 743
      ExplicitWidth = 743
      inherited TitleShader: TShader
        Width = 741
        ExplicitWidth = 741
        inherited TitleLabel: TLabel
          Width = 741
          Caption = 'Change of Phase (Simple)'
          ExplicitWidth = 572
        end
      end
    end
  end
  inherited pnlDetails: TDNMPanel
    Width = 1007
    Height = 440
    TabOrder = 2
    ExplicitWidth = 1007
    ExplicitHeight = 440
    inherited Shape4: TShape
      Top = 94
      Width = 1005
      ExplicitLeft = 22
      ExplicitTop = 88
      ExplicitWidth = 836
    end
    inherited Shape6: TShape
      Width = 1005
      ExplicitWidth = 836
    end
    inherited Shape7: TShape
      Top = 437
      Width = 1005
      ExplicitTop = 378
      ExplicitWidth = 836
    end
    inherited pnlPlantPhaseOptions: TDNMPanel
      Width = 1005
      ExplicitWidth = 1005
      inherited Label1: TLabel
        Width = 778
      end
      inherited btnImmature: TDNMSpeedButton
        Left = 5
        OnEnter = btnImmatureEnter
        ExplicitLeft = 5
      end
      inherited btnVegetative: TDNMSpeedButton
        OnEnter = btnImmatureEnter
      end
      inherited btnFlowering: TDNMSpeedButton
        Left = 335
        OnEnter = btnImmatureEnter
        ExplicitLeft = 335
      end
      inherited btnHarvest: TDNMSpeedButton
        Left = 501
        Visible = False
        OnEnter = btnImmatureEnter
        ExplicitLeft = 501
      end
      inherited btnDestroy: TDNMSpeedButton
        Left = 666
        Visible = False
        OnEnter = btnImmatureEnter
        ExplicitLeft = 666
      end
    end
    inherited pnDetails: TDNMPanel
      Top = 96
      Width = 1005
      Height = 341
      Align = alClient
      ExplicitTop = 96
      ExplicitWidth = 1005
      ExplicitHeight = 341
      inherited pnlDept: TDNMPanel
        Left = 313
        Top = 6
        Width = 347
        Height = 53
        TabOrder = 1
        ExplicitLeft = 313
        ExplicitTop = 6
        ExplicitWidth = 347
        ExplicitHeight = 53
        inherited Label6: TLabel
          Left = 1
          Top = 1
          Width = 91
          Height = 51
          Align = alLeft
          AutoSize = False
          Layout = tlCenter
          ExplicitLeft = 0
          ExplicitTop = 1
          ExplicitWidth = 91
          ExplicitHeight = 51
        end
        inherited edtDept: TwwDBEdit
          Left = 94
          Top = 14
          Width = 198
          TabStop = True
          Anchors = [akLeft, akTop, akRight]
          ExplicitLeft = 94
          ExplicitTop = 14
          ExplicitWidth = 198
        end
        inherited DNMSpeedButton1: TDNMSpeedButton
          Left = 300
          Top = 14
          Anchors = [akTop, akRight]
          ExplicitLeft = 300
          ExplicitTop = 14
        end
      end
      inherited pnlUsedOn: TDNMPanel
        Left = 12
        Top = 7
        Width = 293
        TabOrder = 0
        ExplicitLeft = 12
        ExplicitTop = 7
        ExplicitWidth = 293
        inherited Label5: TLabel
          AlignWithMargins = False
          Left = 1
          Top = 1
          Width = 50
          Height = 52
          Alignment = taRightJustify
          AutoSize = False
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 50
          ExplicitHeight = 52
        end
        inherited dtUsedOn: TwwDBDateTimePicker
          Left = 57
          Top = 16
          Width = 224
          Anchors = [akLeft, akTop, akRight]
          ExplicitLeft = 57
          ExplicitTop = 16
          ExplicitWidth = 224
        end
      end
      inherited pnlcbobin: TDNMPanel
        Left = 666
        Top = 4
        Width = 322
        ExplicitLeft = 666
        ExplicitTop = 4
        ExplicitWidth = 322
        inherited lblbin: TLabel
          Left = 1
          Top = 1
          Width = 90
          Height = 52
          Align = alLeft
          AutoSize = False
          Caption = 'Product Room : '
          Layout = tlCenter
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 90
          ExplicitHeight = 52
        end
        inherited cbobin: TwwDBLookupCombo
          Top = 16
          Width = 215
          Anchors = [akLeft, akTop, akRight]
          ExplicitTop = 16
          ExplicitWidth = 215
        end
      end
      object DNMPanel1: TDNMPanel
        AlignWithMargins = True
        Left = 152
        Top = 63
        Width = 462
        Height = 71
        Margins.Right = 21
        Margins.Bottom = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object btnChooseTags: TDNMSpeedButton
          Tag = 1
          AlignWithMargins = True
          Left = 250
          Top = 12
          Width = 200
          Height = 48
          HelpContext = 251008
          Margins.Left = 11
          Margins.Top = 11
          Margins.Right = 11
          Margins.Bottom = 7
          Caption = 'Choose Tag(s)'
          Color = clWhite
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
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 0
          WordWrap = True
          AutoDisableParentOnclick = True
          OnClick = btnChooseTagsClick
        end
        object btnUseSameTag: TDNMSpeedButton
          Tag = 1
          AlignWithMargins = True
          Left = 12
          Top = 12
          Width = 200
          Height = 48
          HelpContext = 251008
          Margins.Left = 11
          Margins.Top = 11
          Margins.Right = 11
          Margins.Bottom = 13
          Caption = 'Use Same Tag'
          Color = clWhite
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
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 1
          WordWrap = True
          AutoDisableParentOnclick = True
          OnClick = btnUseSameTagClick
        end
      end
      object pnlSelectedTags: TDNMPanel
        AlignWithMargins = True
        Left = 4
        Top = 136
        Width = 979
        Height = 189
        Margins.Right = 21
        Margins.Bottom = 15
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object Label2: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 4
          Width = 963
          Height = 19
          Margins.Left = 11
          Align = alTop
          Caption = 'Selected Tag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 98
        end
        object grdSelectedTags: TwwDBGrid
          Left = 1
          Top = 26
          Width = 977
          Height = 162
          Selected.Strings = (
            'StsTag'#9'29'#9'Tag')
          MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
          IniAttributes.SaveToRegistry = True
          IniAttributes.Delimiter = ';;'
          IniAttributes.CheckNewFields = True
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          DataSource = dsSelectedTags
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = True
          LineColors.GroupingColor = clSilver
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          object btnGrid: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 22
            AllowAllUp = True
          end
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 644
    Top = 16
  end
  inherited tmrdelay: TTimer
    Left = 680
    Top = 16
  end
  inherited popSpelling: TPopupMenu
    Left = 328
    Top = 16
  end
  inherited tmrdelayMsg: TTimer
    Left = 616
    Top = 16
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 433
    Top = 16
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 469
    Top = 16
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 504
    Top = 16
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 363
    Top = 16
  end
  inherited imgsort: TImageList
    Left = 539
    Top = 16
    Bitmap = {
      494C010102004801580310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 258
    Top = 16
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 574
    Top = 16
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 398
    Top = 16
  end
  inherited qryMemTrans: TERPQuery
    Left = 293
    Top = 16
  end
  inherited tmrOnshow: TTimer
    Left = 720
    Top = 16
  end
  inherited dsStSTagPhases: TDataSource
    Left = 225
    Top = 14
  end
  inherited QryBin: TERPQuery
    Left = 752
    Top = 16
  end
  object dsSelectedTags: TDataSource
    DataSet = QrySelectedTags
    Left = 790
    Top = 15
  end
  object QrySelectedTags: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select "" as StsTag')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = QrySelectedTagsBeforeOpen
    Active = True
    Left = 787
    Top = 48
    object QrySelectedTagsStsTag: TWideStringField
      DisplayLabel = 'Tag'
      DisplayWidth = 29
      FieldName = 'StsTag'
      Origin = 'StsTag'
      Size = 65530
    end
  end
end
