inherited fmFixedAsset: TfmFixedAsset
  Left = 99
  Top = 294
  HelpContext = 1363002
  Caption = 'Fixed Asset'
  ClientHeight = 555
  ClientWidth = 998
  ExplicitLeft = 99
  ExplicitTop = 294
  ExplicitWidth = 1014
  ExplicitHeight = 594
  DesignSize = (
    998
    555)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 505
    Width = 998
    HelpContext = 1363003
    ExplicitTop = 505
    ExplicitWidth = 998
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 998
    Height = 59
    HelpContext = 1363268
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      998
      59)
    object pnlTitle: TDNMPanel
      Left = 321
      Top = 9
      Width = 355
      Height = 39
      HelpContext = 1363269
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 353
        Height = 37
        HelpContext = 1363270
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
          Width = 353
          Height = 37
          HelpContext = 1363271
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Fixed Asset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 171
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 505
    Width = 998
    Height = 50
    HelpContext = 1363272
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      998
      50)
    object cmdClose: TDNMSpeedButton
      Left = 181
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 1363273
      Anchors = [akBottom]
      Caption = '&Save'
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      OnClick = cmdCloseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 730
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 1363274
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = cmdCancelClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 400
      Top = 11
      Width = 87
      Height = 27
      Hint = '"Add A Class"'
      HelpContext = 1363286
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = cmdNewClick
    end
    object btnClone: TDNMSpeedButton
      Left = 290
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 1363276
      Anchors = [akBottom]
      Caption = 'Clone'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnCloneClick
    end
    object cmdPrint: TDNMSpeedButton
      Left = 510
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 1363277
      Anchors = [akBottom]
      Caption = '&Print'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = cmdPrintClick
    end
    object cmdNewServiceLog: TDNMSpeedButton
      Left = 620
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 1363278
      Anchors = [akBottom]
      Caption = 'Ser&vice Log'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = cmdNewServiceLogClick
    end
  end
  object DNMPanel4: TDNMPanel [7]
    Left = 0
    Top = 59
    Width = 998
    Height = 53
    HelpContext = 1363279
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      998
      53)
    object Label7: TLabel
      Left = 14
      Top = 7
      Width = 65
      Height = 23
      HelpContext = 1363280
      AutoSize = False
      Caption = 'Asset Code'
      Transparent = True
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 172
      Top = 7
      Width = 69
      Height = 23
      HelpContext = 1363281
      AutoSize = False
      Caption = 'Asset Name'
      Transparent = True
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 820
      Top = 7
      Width = 63
      Height = 23
      HelpContext = 1363282
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Asset Type'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label42: TLabel
      Left = 397
      Top = 7
      Width = 140
      Height = 23
      HelpContext = 1363287
      AutoSize = False
      Caption = 'Asset Description'
      Transparent = True
      Layout = tlCenter
    end
    object AssetCode: TDBEdit
      Left = 13
      Top = 26
      Width = 121
      Height = 23
      HelpContext = 1363283
      DataField = 'AssetCode'
      DataSource = DSAsset
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object AssetName: TDBEdit
      Left = 172
      Top = 25
      Width = 205
      Height = 23
      HelpContext = 1363284
      DataField = 'AssetName'
      DataSource = DSAsset
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cboAssetType: TwwDBLookupCombo
      Left = 820
      Top = 26
      Width = 170
      Height = 23
      HelpContext = 1363285
      Anchors = [akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'AssetTypeName'#9'40'#9'AssetTypeName'#9'F')
      DataField = 'AssetType'
      DataSource = DSAsset
      LookupTable = qryfixedassettypes
      LookupField = 'AssetTypeCode'
      Style = csDropDownList
      DropDownWidth = 200
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboAssetTypeCloseUp
    end
    object edtAssetDescription: TDBEdit
      Left = 397
      Top = 25
      Width = 388
      Height = 23
      HelpContext = 1363288
      DataField = 'Description'
      DataSource = DSAsset
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object DNMPanel1: TDNMPanel [8]
    Left = 0
    Top = 112
    Width = 998
    Height = 393
    HelpContext = 1363004
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 996
      Height = 391
      HelpContext = 1363005
      ActivePage = tabAdditionalInfo
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MultiLine = True
      ParentFont = False
      TabHeight = 25
      TabOrder = 0
      TabWidth = 90
      OnChange = PageControl1Change
      object AssetInfo: TTabSheet
        HelpContext = 1363006
        Caption = 'Asset Info'
        ImageIndex = 4
        object DNMPanel6: TDNMPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363007
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            988
            356)
          object Bevel17: TBevel
            Left = 418
            Top = 208
            Width = 391
            Height = 144
            HelpContext = 1363008
            Shape = bsFrame
            Visible = False
          end
          object Bevel16: TBevel
            Left = 26
            Top = 16
            Width = 377
            Height = 186
            HelpContext = 1363009
            Shape = bsFrame
          end
          object Label1: TLabel
            Left = 70
            Top = 44
            Width = 104
            Height = 23
            HelpContext = 1363010
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Date of Purchase :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label2: TLabel
            Left = 75
            Top = 110
            Width = 99
            Height = 19
            HelpContext = 1363011
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Purchase Price :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label4: TLabel
            Left = 426
            Top = 276
            Width = 94
            Height = 16
            HelpContext = 1363012
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Serial Number'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            Visible = False
          end
          object Bevel2: TBevel
            Left = 418
            Top = 16
            Width = 391
            Height = 186
            HelpContext = 1363013
            Shape = bsFrame
          end
          object Label19: TLabel
            Left = 467
            Top = 28
            Width = 97
            Height = 16
            HelpContext = 1363014
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Room / Location :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label45: TLabel
            Left = 86
            Top = 139
            Width = 88
            Height = 21
            HelpContext = 1363015
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Bought From :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label227: TLabel
            Left = 35
            Top = 22
            Width = 85
            Height = 18
            HelpContext = 1363016
            AutoSize = False
            Caption = 'Purchase Info'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic, fsUnderline]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label85: TLabel
            Left = 426
            Top = 318
            Width = 94
            Height = 18
            HelpContext = 1363017
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Barcode'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Visible = False
            WordWrap = True
          end
          object Label43: TLabel
            Left = 420
            Top = 233
            Width = 100
            Height = 18
            HelpContext = 1363018
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Asset'#39's Product'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            Visible = False
          end
          object Label67: TLabel
            Left = 815
            Top = 85
            Width = 94
            Height = 18
            HelpContext = 1363019
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Parent Asset ID :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Visible = False
            WordWrap = True
          end
          object Label68: TLabel
            Left = 59
            Top = 169
            Width = 115
            Height = 23
            HelpContext = 1363020
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Total Asset Cost :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            Visible = False
          end
          object LblClass: TLabel
            Left = 489
            Top = 75
            Width = 75
            Height = 17
            HelpContext = 1363021
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Department :'
            Transparent = True
            Layout = tlCenter
          end
          object Label9: TLabel
            Left = 455
            Top = 122
            Width = 109
            Height = 23
            HelpContext = 1363022
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Last Test Date :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label10: TLabel
            Left = 455
            Top = 169
            Width = 109
            Height = 23
            HelpContext = 1363023
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Next Test Date'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label53: TLabel
            Left = 35
            Top = 80
            Width = 138
            Height = 18
            HelpContext = 1363024
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Depreciation Start Date :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object lblDayMatch: TLabel
            Left = 312
            Top = 75
            Width = 77
            Height = 50
            HelpContext = 1363025
            AutoSize = False
            Caption = 'lblDayMatch'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object cboPurchDate: TwwDBDateTimePicker
            Left = 185
            Top = 44
            Width = 121
            Height = 23
            HelpContext = 1363026
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'PurchDate'
            DataSource = DSAsset
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 0
            UnboundDataType = wwDTEdtDate
            OnExit = cboPurchDateExit
          end
          object PurchCost: TDBEdit
            Left = 185
            Top = 106
            Width = 121
            Height = 23
            HelpContext = 1363027
            DataField = 'PurchCost'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object Serial: TDBEdit
            Left = 526
            Top = 273
            Width = 179
            Height = 23
            HelpContext = 1363028
            DataField = 'Serial'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            Visible = False
          end
          object LocationDescription: TDBEdit
            Left = 570
            Top = 25
            Width = 185
            Height = 23
            HelpContext = 1363029
            DataField = 'LocationDescription'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object cboClient: TwwDBLookupCombo
            Left = 185
            Top = 137
            Width = 203
            Height = 23
            HelpContext = 1363030
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Company'#9'50'#9'Company'#9'F')
            DataField = 'SupplierName'
            DataSource = DSAsset
            LookupTable = cboClientLookup
            LookupField = 'Company'
            Options = [loSearchOnBackspace]
            ParentFont = False
            TabOrder = 3
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object txtBarcode: TDBEdit
            Left = 526
            Top = 316
            Width = 179
            Height = 23
            HelpContext = 1363031
            DataField = 'BARCODE'
            DataSource = DSAsset
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
            Visible = False
          end
          object cboProduct: TwwDBLookupCombo
            Left = 526
            Top = 230
            Width = 179
            Height = 23
            HelpContext = 1363032
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taRightJustify
            DataField = 'PARTNAME'
            DataSource = DSAsset
            LookupTable = qryParts
            LookupField = 'PARTNAME'
            DropDownWidth = 300
            ParentFont = False
            TabOrder = 15
            Visible = False
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object btnProductBarcode: TDNMSpeedButton
            Left = 707
            Top = 316
            Width = 85
            Height = 23
            HelpContext = 1363033
            Caption = 'From Product'
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
            TabOrder = 14
            Visible = False
            OnClick = btnProductBarcodeClick
          end
          object btnProductSerial: TDNMSpeedButton
            Left = 707
            Top = 273
            Width = 85
            Height = 23
            HelpContext = 1363034
            Caption = 'From Product'
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
            TabOrder = 12
            Visible = False
            OnClick = btnProductSerialClick
          end
          object wwDBLookupParentAssetID: TwwDBLookupCombo
            Left = 815
            Top = 110
            Width = 185
            Height = 23
            HelpContext = 1363035
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AssetName'#9'50'#9'AssetName'#9'F')
            DataSource = DSAsset
            LookupField = 'AssetID'
            Options = [loSearchOnBackspace]
            ParentFont = False
            TabOrder = 7
            Visible = False
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object TotalChildAssets: TDBEdit
            Left = 185
            Top = 169
            Width = 121
            Height = 23
            HelpContext = 1363036
            Color = 15724527
            DataField = 'TotalChildAsset'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Visible = False
          end
          object grdFAPercentage: TwwDBGrid
            Left = 24
            Top = 208
            Width = 377
            Height = 144
            HelpContext = 1363037
            ControlType.Strings = (
              'Active;CheckBox;T;F'
              'ClassID;CustomEdit;cboClass;F'
              'ClassName;CustomEdit;cboClass;F')
            Selected.Strings = (
              'ClassName'#9'13'#9'Class'
              'Cost'#9'9'#9'Cost %'
              'Depreciation'#9'13'#9'Depreciation %'
              'Description'#9'10'#9'Description')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = False
            Anchors = [akLeft, akTop, akBottom]
            DataSource = dsFAPercentages
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells, dgProportionalColResize, dgFixedProportionalResize]
            ParentFont = False
            TabOrder = 10
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            FooterColor = clWhite
            FooterCellColor = clWhite
            FooterHeight = 20
            PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
            object grdFAPercentageIButton: TwwIButton
              Left = 0
              Top = 0
              Width = 17
              Height = 22
              HelpContext = 1363038
              AllowAllUp = True
              Glyph.Data = {
                C6030000424DC603000000000000360000002800000010000000130000000100
                18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
                666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
                99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
                CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
                333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
                99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
                C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
                C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
                77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
                8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
                B2B2B2808080333366000080333366777777777777333366000080333399C0C0
                C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
                0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
                CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
                0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
                868686808080666699333399333399000080333366666666808080969696C0C0
                C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
                8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
                B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
                80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
                CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
                99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
                CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
                D7CCCCCCCCCCCCCCCCCC}
            end
          end
          object cboClass: TwwDBLookupCombo
            Left = 136
            Top = 270
            Width = 147
            Height = 23
            HelpContext = 1363039
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taRightJustify
            Selected.Strings = (
              'ClassName'#9'15'#9'ClassName'#9'F')
            DataField = 'ClassName'
            LookupTable = cboClassQry
            LookupField = 'ClassName'
            ParentFont = False
            TabOrder = 16
            Visible = False
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object cboAssetClass: TwwDBLookupCombo
            Left = 570
            Top = 73
            Width = 185
            Height = 23
            HelpContext = 1363040
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taRightJustify
            Selected.Strings = (
              'ClassName'#9'15'#9'ClassName'#9'F')
            DataField = 'ClassID'
            DataSource = DSAsset
            LookupTable = qryAssetClass
            LookupField = 'ClassID'
            ParentFont = False
            TabOrder = 6
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object wwDBDateTimePicker1: TwwDBDateTimePicker
            Left = 570
            Top = 121
            Width = 120
            Height = 23
            HelpContext = 1363041
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'LastTestDate'
            DataSource = DSAsset
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 8
          end
          object wwDBDateTimePicker2: TwwDBDateTimePicker
            Left = 570
            Top = 169
            Width = 120
            Height = 23
            HelpContext = 1363042
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'NextTestDate'
            DataSource = DSAsset
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 9
          end
          object cboDepreciationStartDate: TwwDBDateTimePicker
            Left = 184
            Top = 75
            Width = 121
            Height = 23
            HelpContext = 1363043
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'DepreciationStartDate'
            DataSource = DSAsset
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 1
            UnboundDataType = wwDTEdtDate
            OnExit = cboDepreciationStartDateExit
          end
        end
      end
      object tabAdditionalInfo: TTabSheet
        HelpContext = 1363044
        Caption = 'Add Info'
        ImageIndex = 6
        object DNMPanel5: TDNMPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363045
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            988
            356)
          object Bevel1: TBevel
            Left = 508
            Top = 8
            Width = 308
            Height = 231
            HelpContext = 1363046
            Shape = bsFrame
          end
          object Bevel4: TBevel
            Left = 314
            Top = 8
            Width = 185
            Height = 233
            HelpContext = 1363047
            Shape = bsFrame
          end
          object Bevel5: TBevel
            Left = 16
            Top = 8
            Width = 289
            Height = 113
            HelpContext = 1363048
            Shape = bsFrame
          end
          object Label17: TLabel
            Left = 32
            Top = 57
            Width = 81
            Height = 23
            HelpContext = 1363049
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Policy'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label18: TLabel
            Left = 34
            Top = 31
            Width = 79
            Height = 23
            HelpContext = 1363050
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Insured By'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label27: TLabel
            Left = 35
            Top = 83
            Width = 78
            Height = 23
            HelpContext = 1363051
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Insured Until'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label36: TLabel
            Left = 577
            Top = 142
            Width = 46
            Height = 23
            HelpContext = 1363052
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Colour :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label37: TLabel
            Left = 577
            Top = 171
            Width = 46
            Height = 23
            HelpContext = 1363053
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Size :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label38: TLabel
            Left = 577
            Top = 200
            Width = 46
            Height = 23
            HelpContext = 1363054
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Shape :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Bevel6: TBevel
            Left = 16
            Top = 129
            Width = 289
            Height = 112
            HelpContext = 1363055
            Shape = bsFrame
          end
          object Label15: TLabel
            Left = 22
            Top = 160
            Width = 110
            Height = 23
            HelpContext = 1363056
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Warranty Expires'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label16: TLabel
            Left = 44
            Top = 194
            Width = 88
            Height = 23
            HelpContext = 1363057
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Warranty Type'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label46: TLabel
            Left = 30
            Top = 10
            Width = 104
            Height = 18
            HelpContext = 1363058
            AutoSize = False
            Caption = 'Insurance Info'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic, fsUnderline]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label47: TLabel
            Left = 32
            Top = 131
            Width = 85
            Height = 18
            HelpContext = 1363059
            AutoSize = False
            Caption = 'Warranty Info'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic, fsUnderline]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label21: TLabel
            Left = 332
            Top = 189
            Width = 51
            Height = 14
            HelpContext = 1363060
            AutoSize = False
            Caption = 'Quantity'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            Visible = False
          end
          object Label23: TLabel
            Left = 332
            Top = 131
            Width = 37
            Height = 15
            HelpContext = 1363061
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Status'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label24: TLabel
            Left = 332
            Top = 75
            Width = 104
            Height = 15
            HelpContext = 1363062
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Replacement Cost'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label25: TLabel
            Left = 332
            Top = 19
            Width = 92
            Height = 15
            HelpContext = 1363063
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Estimated Value'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Bevel23: TBevel
            Left = 16
            Top = 248
            Width = 952
            Height = 99
            HelpContext = 1363064
            Anchors = [akLeft, akTop, akRight, akBottom]
            Shape = bsFrame
            Visible = False
            ExplicitWidth = 801
            ExplicitHeight = 121
          end
          object Label22: TLabel
            Left = 535
            Top = 114
            Width = 88
            Height = 23
            HelpContext = 1363065
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Condition :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label5: TLabel
            Left = 529
            Top = 85
            Width = 94
            Height = 23
            HelpContext = 1363066
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Model Number :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label20: TLabel
            Left = 546
            Top = 56
            Width = 77
            Height = 23
            HelpContext = 1363067
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Brand Name :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label3: TLabel
            Left = 537
            Top = 28
            Width = 86
            Height = 19
            HelpContext = 1363068
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Manufacture'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label40: TLabel
            Left = 663
            Top = 280
            Width = 299
            Height = 61
            HelpContext = 1363069
            Alignment = taCenter
            AutoSize = False
            Caption = 
              'This Will Create New Fixed Asset Records and Flag Them as the Ch' +
              'ild Assets. These will be visible on the Fixed Asset List to Cho' +
              'ose and edit the Details'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            Visible = False
            WordWrap = True
          end
          object Shape: TDBEdit
            Left = 628
            Top = 201
            Width = 170
            Height = 23
            HelpContext = 1363070
            DataField = 'Shape'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
          end
          object InsurancePolicy: TDBEdit
            Left = 117
            Top = 57
            Width = 170
            Height = 23
            HelpContext = 1363071
            DataField = 'InsurancePolicy'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object InsuredBy: TDBEdit
            Left = 117
            Top = 31
            Width = 170
            Height = 23
            HelpContext = 1363072
            DataField = 'InsuredBy'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object cboInsuredUntil: TwwDBDateTimePicker
            Left = 117
            Top = 83
            Width = 121
            Height = 23
            HelpContext = 1363073
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'InsuredUntil'
            DataSource = DSAsset
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 2
          end
          object Colour: TDBEdit
            Left = 628
            Top = 142
            Width = 170
            Height = 23
            HelpContext = 1363074
            DataField = 'Colour'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
          end
          object Size: TDBEdit
            Left = 628
            Top = 171
            Width = 170
            Height = 23
            HelpContext = 1363075
            DataField = 'Size'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
          end
          object WarrantyType: TDBEdit
            Left = 136
            Top = 194
            Width = 161
            Height = 23
            HelpContext = 1363076
            DataField = 'WarrantyType'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object cboWarrantyExpiresDate: TwwDBDateTimePicker
            Left = 136
            Top = 160
            Width = 121
            Height = 23
            HelpContext = 1363077
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'WarrantyExpiresDate'
            DataSource = DSAsset
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 3
          end
          object Status: TDBEdit
            Left = 332
            Top = 146
            Width = 150
            Height = 23
            HelpContext = 1363078
            DataField = 'Status'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object Qty: TwwDBSpinEdit
            Left = 332
            Top = 203
            Width = 150
            Height = 23
            HelpContext = 1363079
            Increment = 1.000000000000000000
            DataField = 'Qty'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            UnboundDataType = wwDefault
            Visible = False
          end
          object EstimatedValue: TDBEdit
            Left = 332
            Top = 34
            Width = 150
            Height = 23
            HelpContext = 1363080
            DataField = 'EstimatedValue'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object ReplacementCost: TDBEdit
            Left = 332
            Top = 90
            Width = 150
            Height = 23
            HelpContext = 1363081
            DataField = 'ReplacementCost'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object wwDBChildAssetGrid: TwwDBGrid
            Left = 24
            Top = 256
            Width = 633
            Height = 83
            HelpContext = 1363082
            ControlType.Strings = (
              'AssetType;CustomEdit;chochildAssetAssetType;F')
            Selected.Strings = (
              'AssetName'#9'30'#9'Child Asset Name'
              'PurchCost'#9'10'#9'Purchase Price'
              'AssetCode'#9'20'#9'Asset Code'
              'AssetType'#9'20'#9'Asset Type')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataSource = DSChildAssets
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            Visible = False
            FooterColor = clWhite
            FooterCellColor = clWhite
          end
          object Manufacture: TDBEdit
            Left = 628
            Top = 26
            Width = 170
            Height = 23
            HelpContext = 1363083
            DataField = 'Manufacture'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object BrandName: TDBEdit
            Left = 628
            Top = 55
            Width = 170
            Height = 23
            HelpContext = 1363084
            DataField = 'BrandName'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object Model: TDBEdit
            Left = 628
            Top = 84
            Width = 170
            Height = 23
            HelpContext = 1363085
            DataField = 'Model'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
          end
          object Condition: TDBEdit
            Left = 628
            Top = 113
            Width = 170
            Height = 23
            HelpContext = 1363086
            DataField = 'AssetCondition'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
        end
      end
      object Depreciation1: TTabSheet
        HelpContext = 1363087
        Caption = 'Deprec #1'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel7: TDNMPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363088
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            988
            356)
          object bvel1: TBevel
            Left = 539
            Top = 4
            Width = 271
            Height = 93
            HelpContext = 1363089
            Shape = bsFrame
          end
          object Bevel12: TBevel
            Left = 28
            Top = 4
            Width = 483
            Height = 55
            HelpContext = 1363090
            Shape = bsFrame
          end
          object Bevel3: TBevel
            Left = 539
            Top = 103
            Width = 271
            Height = 177
            HelpContext = 1363091
            Shape = bsFrame
          end
          object Bevel9: TBevel
            Left = 539
            Top = 284
            Width = 271
            Height = 69
            HelpContext = 1363092
          end
          object Label26: TLabel
            Left = 691
            Top = 210
            Width = 105
            Height = 23
            HelpContext = 1363093
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Business Use (%)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label31: TLabel
            Left = 571
            Top = 284
            Width = 105
            Height = 23
            HelpContext = 1363094
            AutoSize = False
            Caption = 'Enter Amount'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label32: TLabel
            Left = 552
            Top = 305
            Width = 150
            Height = 15
            HelpContext = 1363095
            Caption = 'Accumulated Depreciation'
            Enabled = False
            Transparent = True
            Layout = tlCenter
          end
          object Label33: TLabel
            Left = 716
            Top = 306
            Width = 87
            Height = 15
            HelpContext = 1363096
            Caption = 'For Year Ending'
            Enabled = False
            Transparent = True
            Layout = tlCenter
          end
          object Label11: TLabel
            Left = 551
            Top = 113
            Width = 112
            Height = 23
            HelpContext = 1363097
            AutoSize = False
            Caption = 'Depreciation Option'
            Transparent = True
            Layout = tlCenter
          end
          object lblSalvage: TLabel
            Left = 550
            Top = 161
            Width = 80
            Height = 23
            HelpContext = 1363098
            AutoSize = False
            Caption = 'Salvage Value'
            Transparent = True
            Layout = tlCenter
          end
          object Label13: TLabel
            Left = 551
            Top = 212
            Width = 57
            Height = 23
            HelpContext = 1363099
            AutoSize = False
            Caption = 'Asset Life'
            Transparent = True
            Layout = tlCenter
          end
          object Label14: TLabel
            Left = 621
            Top = 230
            Width = 37
            Height = 23
            HelpContext = 1363100
            AutoSize = False
            Caption = ' Years'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object lblFixedAssetsClearingAccount: TLabel
            Left = 283
            Top = 12
            Width = 177
            Height = 15
            HelpContext = 1363101
            AutoSize = False
            Caption = 'Fixed Assets Bank Account'
            Transparent = True
          end
          object lblFixedAssetsAccount: TLabel
            Left = 51
            Top = 12
            Width = 188
            Height = 15
            HelpContext = 1363102
            Caption = 'Fixed Assets Cost Asset Account'
            Transparent = True
          end
          object lblPercentInfo1: TLabel
            Left = 552
            Top = 258
            Width = 82
            Height = 15
            HelpContext = 1363103
            Caption = 'lblPercentInfo1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object lblFixedAssetsDepreciationAccount: TLabel
            Left = 552
            Top = 9
            Width = 234
            Height = 15
            HelpContext = 1363104
            Caption = 'Fixed Assets Depreciation Asset Account'
            Transparent = True
          end
          object lblFixedAssetDepreciationAccountName: TLabel
            Left = 552
            Top = 52
            Width = 250
            Height = 15
            HelpContext = 1363105
            Caption = 'Fixed Assets Depreciation Expense Account'
            Transparent = True
          end
          object grdDepreciationCalcs1: TwwDBGrid
            Left = 28
            Top = 68
            Width = 484
            Height = 253
            HelpContext = 1363106
            Selected.Strings = (
              'Year'#9'9'#9'Year'#9#9
              'Month'#9'12'#9'Month'#9#9
              'Depreciation'#9'13'#9'Depreciation'#9#9
              'TotalDepreciation'#9'13'#9'Acc Depreciation'#9#9
              'BookValue'#9'13'#9'BookValue'#9#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Anchors = [akLeft, akTop, akBottom]
            DataSource = dsDepreciationCalcs1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
            TitleAlignment = taCenter
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            FooterColor = clWhite
            FooterCellColor = clWhite
          end
          object btnCalculate: TDNMSpeedButton
            Left = 226
            Top = 326
            Width = 106
            Height = 27
            HelpContext = 1363107
            Anchors = [akLeft, akBottom]
            Caption = 'Calculate'
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
              33333333333F8888883F33330000324334222222443333388F3833333388F333
              000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
              F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
              223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
              3338888300003AAAAAAA33333333333888888833333333330000333333333333
              333333333333333333FFFFFF000033333333333344444433FFFF333333888888
              00003A444333333A22222438888F333338F3333800003A2243333333A2222438
              F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
              22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
              33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
              3333333333338888883333330000333333333333333333333333333333333333
              0000}
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 11
            OnClick = btnCalculateClick
          end
          object BusinessUsePercent: TDBEdit
            Left = 697
            Top = 229
            Width = 83
            Height = 23
            HelpContext = 1363108
            DataField = 'BusinessUsePercent'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object PriorAccumDeprec: TwwCheckBox
            Left = 552
            Top = 287
            Width = 13
            Height = 16
            HelpContext = 1363109
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
            Caption = 'PriorAccumDeprec'
            DataField = 'PriorAccumDeprec'
            DataSource = DSAsset
            TabOrder = 8
            OnClick = PriorAccumDeprecClick
          end
          object PriorAccumDeprecAmount: TDBEdit
            Left = 552
            Top = 326
            Width = 99
            Height = 23
            HelpContext = 1363110
            DataField = 'PriorAccumDeprecAmount'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object PriorAccumDeprecDate: TDBEdit
            Left = 727
            Top = 326
            Width = 66
            Height = 23
            HelpContext = 1363111
            DataField = 'PriorAccumDeprecDate'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object SalvageFactor: TDBEdit
            Left = 712
            Top = 132
            Width = 69
            Height = 23
            HelpContext = 1363112
            DataField = 'SalvageFactor'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object Salvage: TDBEdit
            Left = 550
            Top = 180
            Width = 132
            Height = 23
            HelpContext = 1363113
            DataField = 'Salvage'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object Life: TDBEdit
            Left = 550
            Top = 229
            Width = 70
            Height = 23
            HelpContext = 1363114
            DataField = 'Life'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object cboDepreciationOption: TwwDBComboBox
            Left = 550
            Top = 132
            Width = 157
            Height = 23
            HelpContext = 1363115
            ShowButton = True
            Style = csDropDownList
            MapList = True
            AllowClearKey = False
            AutoDropDown = True
            AutoFillDate = False
            AutoSize = False
            DataField = 'DepreciationOption'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            Items.Strings = (
              'No Depreciation'#9'1'
              'Straight Line Depreciation'#9'2'
              'Declining Balance'#9'3')
            ParentFont = False
            Sorted = False
            TabOrder = 2
            UnboundDataType = wwDefault
            OnChange = cboDepreciationOptionChange
            OnCloseUp = cboDepreciationOptionCloseUp
          end
          object cboSalvageType: TwwDBComboBox
            Left = 693
            Top = 180
            Width = 91
            Height = 23
            HelpContext = 1363116
            ShowButton = True
            Style = csDropDownList
            MapList = True
            AllowClearKey = False
            AutoDropDown = True
            AutoFillDate = False
            AutoSize = False
            DataField = 'SalvageType'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            Items.Strings = (
              'Amount'#9'1'
              'Percent'#9'2')
            ParentFont = False
            Sorted = False
            TabOrder = 5
            UnboundDataType = wwDefault
          end
          object cboFixedAssetsClearingAccount: TwwDBLookupCombo
            Left = 281
            Top = 26
            Width = 207
            Height = 23
            HelpContext = 1363117
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AccountName'#9'40'#9'AccountName'#9'F'
              'AccountType'#9'40'#9'AccountType'#9'F')
            DataField = 'ClearingAccountName'
            DataSource = DSAsset
            LookupTable = cboAccountQry
            LookupField = 'AccountName'
            DropDownWidth = 400
            ParentFont = False
            TabOrder = 1
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object cboFixedAssetsAccount: TwwDBLookupCombo
            Left = 49
            Top = 26
            Width = 207
            Height = 23
            HelpContext = 1363118
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AccountName'#9'40'#9'AccountName'#9'F'
              'AccountType'#9'40'#9'AccountType'#9'F')
            DataField = 'FixedAssetCostAccountName'
            DataSource = DSAsset
            LookupTable = cboAccountQry
            LookupField = 'AccountName'
            DropDownWidth = 400
            ParentFont = False
            TabOrder = 0
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object cboFixedAssetsDepreciationAccount: TwwDBLookupCombo
            Left = 552
            Top = 23
            Width = 251
            Height = 23
            HelpContext = 1363119
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AccountName'#9'40'#9'AccountName'#9'F'
              'AccountType'#9'40'#9'AccountType'#9'F')
            DataField = 'FixedAssetDepreciationAssetAccountName'
            DataSource = DSAsset
            LookupTable = cboAccountQry
            LookupField = 'AccountName'
            DropDownWidth = 400
            ParentFont = False
            TabOrder = 13
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object cboFixedAssetDepreciationAccountName: TwwDBLookupCombo
            Left = 550
            Top = 69
            Width = 251
            Height = 23
            HelpContext = 1363120
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AccountName'#9'40'#9'AccountName'#9'F'
              'AccountType'#9'40'#9'AccountType'#9'F')
            DataField = 'FixedAssetDepreciationAccountName'
            DataSource = DSAsset
            LookupTable = cboAccountQry
            LookupField = 'AccountName'
            DropDownWidth = 400
            ParentFont = False
            TabOrder = 14
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
        end
      end
      object Depreciation2: TTabSheet
        HelpContext = 1363121
        Caption = 'Deprec #2'
        ImageIndex = 7
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel8: TDNMPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363122
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            988
            356)
          object Bevel13: TBevel
            Left = 28
            Top = 4
            Width = 483
            Height = 55
            HelpContext = 1363123
            Shape = bsFrame
          end
          object Bevel19: TBevel
            Left = 539
            Top = 4
            Width = 271
            Height = 93
            HelpContext = 1363124
            Shape = bsFrame
          end
          object Bevel20: TBevel
            Left = 539
            Top = 284
            Width = 271
            Height = 90
            HelpContext = 1363125
          end
          object Bevel18: TBevel
            Left = 539
            Top = 105
            Width = 271
            Height = 177
            HelpContext = 1363126
            Shape = bsFrame
          end
          object Label48: TLabel
            Left = 691
            Top = 212
            Width = 105
            Height = 23
            HelpContext = 1363127
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Business Use (%)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label52: TLabel
            Left = 551
            Top = 115
            Width = 112
            Height = 23
            HelpContext = 1363128
            AutoSize = False
            Caption = 'Depreciation Option'
            Transparent = True
            Layout = tlCenter
          end
          object lblSalvage2: TLabel
            Left = 550
            Top = 161
            Width = 80
            Height = 23
            HelpContext = 1363129
            AutoSize = False
            Caption = 'Salvage Value'
            Transparent = True
            Layout = tlCenter
          end
          object Label54: TLabel
            Left = 551
            Top = 214
            Width = 57
            Height = 23
            HelpContext = 1363130
            AutoSize = False
            Caption = 'Asset Life'
            Transparent = True
            Layout = tlCenter
          end
          object Label55: TLabel
            Left = 621
            Top = 231
            Width = 37
            Height = 23
            HelpContext = 1363131
            AutoSize = False
            Caption = ' Years'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object lblFixedAssetAccountName2: TLabel
            Left = 51
            Top = 12
            Width = 188
            Height = 15
            HelpContext = 1363132
            Caption = 'Fixed Assets Cost Asset Account'
            Transparent = True
          end
          object lblClearingAccountName2: TLabel
            Left = 283
            Top = 12
            Width = 177
            Height = 15
            HelpContext = 1363133
            AutoSize = False
            Caption = 'Fixed Assets Clearing Account'
            Transparent = True
          end
          object Label57: TLabel
            Left = 571
            Top = 284
            Width = 105
            Height = 23
            HelpContext = 1363134
            AutoSize = False
            Caption = 'Enter Amount'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label58: TLabel
            Left = 563
            Top = 308
            Width = 78
            Height = 30
            HelpContext = 1363135
            Caption = 'Accumulated Depreciation'
            Enabled = False
            Transparent = True
            Layout = tlCenter
            WordWrap = True
          end
          object Label66: TLabel
            Left = 699
            Top = 320
            Width = 87
            Height = 15
            HelpContext = 1363136
            Caption = 'For Year Ending'
            Enabled = False
            Transparent = True
            Layout = tlCenter
            WordWrap = True
          end
          object lblPercentInfo2: TLabel
            Left = 552
            Top = 260
            Width = 82
            Height = 15
            HelpContext = 1363137
            Caption = 'lblPercentInfo2'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object lblFixedAssetDepreciationAssetAccountName2: TLabel
            Left = 552
            Top = 9
            Width = 234
            Height = 15
            HelpContext = 1363138
            Caption = 'Fixed Assets Depreciation Asset Account'
            Transparent = True
          end
          object lblFixedAssetDepreciationAccountName2: TLabel
            Left = 552
            Top = 52
            Width = 250
            Height = 15
            HelpContext = 1363139
            Caption = 'Fixed Assets Depreciation Expense Account'
            Transparent = True
          end
          object grdDepreciationCalcs2: TwwDBGrid
            Left = 28
            Top = 68
            Width = 484
            Height = 253
            HelpContext = 1363140
            Selected.Strings = (
              'Year'#9'9'#9'Year'
              'Month'#9'12'#9'Month'
              'Depreciation'#9'13'#9'Depreciation'
              'TotalDepreciation'#9'13'#9'Acc Depreciation'
              'BookValue'#9'13'#9'BookValue')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Anchors = [akLeft, akTop, akBottom]
            DataSource = dsDepreciationCalcs2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
            TitleAlignment = taCenter
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            FooterColor = clWhite
            FooterCellColor = clWhite
          end
          object btnCalculate2: TDNMSpeedButton
            Left = 231
            Top = 327
            Width = 106
            Height = 27
            HelpContext = 1363141
            Anchors = [akLeft, akBottom]
            Caption = 'Calculate'
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
              33333333333F8888883F33330000324334222222443333388F3833333388F333
              000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
              F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
              223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
              3338888300003AAAAAAA33333333333888888833333333330000333333333333
              333333333333333333FFFFFF000033333333333344444433FFFF333333888888
              00003A444333333A22222438888F333338F3333800003A2243333333A2222438
              F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
              22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
              33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
              3333333333338888883333330000333333333333333333333333333333333333
              0000}
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 11
            OnClick = btnCalculate2Click
          end
          object BusinessUsePercent2: TDBEdit
            Left = 697
            Top = 231
            Width = 83
            Height = 23
            HelpContext = 1363142
            DataField = 'BusinessUsePercent2'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object SalvageFactor2: TDBEdit
            Left = 712
            Top = 134
            Width = 69
            Height = 23
            HelpContext = 1363143
            DataField = 'SalvageFactor2'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object Salvage2: TDBEdit
            Left = 550
            Top = 182
            Width = 132
            Height = 23
            HelpContext = 1363144
            DataField = 'Salvage2'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object Life2: TDBEdit
            Left = 550
            Top = 231
            Width = 70
            Height = 23
            HelpContext = 1363145
            DataField = 'Life2'
            DataSource = DSAsset
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object cboDepreciationOption2: TwwDBComboBox
            Left = 550
            Top = 134
            Width = 157
            Height = 23
            HelpContext = 1363146
            ShowButton = True
            Style = csDropDownList
            MapList = True
            AllowClearKey = False
            AutoDropDown = True
            AutoFillDate = False
            AutoSize = False
            DataField = 'DepreciationOption2'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            Items.Strings = (
              'No Depreciation'#9'1'
              'Straight Line Depreciation'#9'2'
              'Declining Balance'#9'3')
            ParentFont = False
            Sorted = False
            TabOrder = 2
            UnboundDataType = wwDefault
            OnChange = cboDepreciationOption2Change
            OnCloseUp = cboDepreciationOption2CloseUp
          end
          object cboSalvageType2: TwwDBComboBox
            Left = 693
            Top = 182
            Width = 91
            Height = 23
            HelpContext = 1363147
            ShowButton = True
            Style = csDropDownList
            MapList = True
            AllowClearKey = False
            AutoDropDown = True
            AutoFillDate = False
            AutoSize = False
            DataField = 'SalvageType2'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            Items.Strings = (
              'Amount'#9'1'
              'Percent'#9'2')
            ParentFont = False
            Sorted = False
            TabOrder = 5
            UnboundDataType = wwDefault
          end
          object cboFixedAssetAccountName2: TwwDBLookupCombo
            Left = 49
            Top = 26
            Width = 207
            Height = 23
            HelpContext = 1363148
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AccountName'#9'40'#9'AccountName'#9'F'
              'AccountType'#9'40'#9'AccountType'#9'F')
            DataField = 'FixedAssetCostAccountName2'
            DataSource = DSAsset
            LookupField = 'AccountName'
            DropDownWidth = 400
            ParentFont = False
            TabOrder = 0
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object cboClearingAccountName2: TwwDBLookupCombo
            Left = 281
            Top = 26
            Width = 207
            Height = 23
            HelpContext = 1363149
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AccountName'#9'40'#9'AccountName'#9'F'
              'AccountType'#9'40'#9'AccountType'#9'F')
            DataField = 'ClearingAccountName2'
            DataSource = DSAsset
            LookupField = 'AccountName'
            DropDownWidth = 400
            ParentFont = False
            TabOrder = 1
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object PriorAccumDeprec2: TwwCheckBox
            Left = 552
            Top = 287
            Width = 13
            Height = 16
            HelpContext = 1363150
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
            Caption = 'PriorAccumDeprec2'
            DataField = 'PriorAccumDeprec2'
            DataSource = DSAsset
            TabOrder = 8
            OnClick = PriorAccumDeprec2Click
          end
          object PriorAccumDeprecDate2: TDBEdit
            Left = 710
            Top = 340
            Width = 66
            Height = 23
            HelpContext = 1363151
            DataField = 'PriorAccumDeprecDate2'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object PriorAccumDeprecAmount2: TDBEdit
            Left = 563
            Top = 340
            Width = 99
            Height = 23
            HelpContext = 1363152
            DataField = 'PriorAccumDeprecAmount2'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object cboFixedAssetDepreciationAssetAccountName2: TwwDBLookupCombo
            Left = 552
            Top = 23
            Width = 251
            Height = 23
            HelpContext = 1363153
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AccountName'#9'40'#9'AccountName'#9'F'
              'AccountType'#9'40'#9'AccountType'#9'F')
            DataField = 'FixedAssetDepreciationAssetAccountName2'
            DataSource = DSAsset
            LookupTable = cboAccountQry
            LookupField = 'AccountName'
            DropDownWidth = 400
            ParentFont = False
            TabOrder = 13
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object cboFixedAssetDepreciationAccountName2: TwwDBLookupCombo
            Left = 552
            Top = 66
            Width = 251
            Height = 23
            HelpContext = 1363154
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AccountName'#9'40'#9'AccountName'#9'F'
              'AccountType'#9'40'#9'AccountType'#9'F')
            DataField = 'FixedAssetDepreciationAccountName2'
            DataSource = DSAsset
            LookupTable = cboAccountQry
            LookupField = 'AccountName'
            DropDownWidth = 400
            ParentFont = False
            TabOrder = 14
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
        end
      end
      object Disposal: TTabSheet
        HelpContext = 1363155
        Caption = 'Disposa&l'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel9: TDNMPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363156
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Bevel8: TBevel
            Left = 69
            Top = 59
            Width = 333
            Height = 120
            HelpContext = 1363157
            Shape = bsFrame
          end
          object Bevel7: TBevel
            Left = 421
            Top = 59
            Width = 333
            Height = 120
            HelpContext = 1363158
            Shape = bsFrame
          end
          object Label28: TLabel
            Left = 103
            Top = 87
            Width = 109
            Height = 23
            HelpContext = 1363159
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Disposal Date'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label29: TLabel
            Left = 125
            Top = 132
            Width = 87
            Height = 23
            HelpContext = 1363160
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Sales Price'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label34: TLabel
            Left = 486
            Top = 138
            Width = 110
            Height = 23
            HelpContext = 1363161
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Book Value'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label35: TLabel
            Left = 441
            Top = 105
            Width = 155
            Height = 23
            HelpContext = 1363162
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Accumulated Depreciation'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label30: TLabel
            Left = 87
            Top = 10
            Width = 109
            Height = 23
            HelpContext = 1363163
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Disposal of Asset '
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Bevel21: TBevel
            Left = 69
            Top = 219
            Width = 333
            Height = 120
            HelpContext = 1363164
            Shape = bsFrame
          end
          object Bevel22: TBevel
            Left = 421
            Top = 219
            Width = 333
            Height = 120
            HelpContext = 1363165
            Shape = bsFrame
          end
          object Label59: TLabel
            Left = 103
            Top = 247
            Width = 109
            Height = 23
            HelpContext = 1363166
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Disposal Date'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label60: TLabel
            Left = 125
            Top = 292
            Width = 87
            Height = 23
            HelpContext = 1363167
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Sales Price'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label61: TLabel
            Left = 486
            Top = 298
            Width = 110
            Height = 23
            HelpContext = 1363168
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Book Value'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label62: TLabel
            Left = 441
            Top = 265
            Width = 155
            Height = 23
            HelpContext = 1363169
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Accumulated Depreciation'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label63: TLabel
            Left = 68
            Top = 41
            Width = 109
            Height = 23
            HelpContext = 1363170
            AutoSize = False
            Caption = 'Depreciation #1'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label65: TLabel
            Left = 69
            Top = 201
            Width = 109
            Height = 23
            HelpContext = 1363171
            AutoSize = False
            Caption = 'Depreciation #2'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object SalesPrice: TDBEdit
            Left = 217
            Top = 132
            Width = 102
            Height = 23
            HelpContext = 1363172
            DataField = 'SalesPrice'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object cboDisposalDate: TwwDBDateTimePicker
            Left = 217
            Top = 87
            Width = 120
            Height = 23
            HelpContext = 1363173
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'DisposalDate'
            DataSource = DSAsset
            Epoch = 1950
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 1
          end
          object DisposalAccumDeprec: TDBEdit
            Left = 600
            Top = 105
            Width = 103
            Height = 23
            HelpContext = 1363174
            DataField = 'DisposalAccumDeprec'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object DisposalBookValue: TDBEdit
            Left = 600
            Top = 138
            Width = 103
            Height = 23
            HelpContext = 1363175
            DataField = 'DisposalBookValue'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
          object DisposalCalculate: TDNMSpeedButton
            Left = 469
            Top = 69
            Width = 106
            Height = 27
            HelpContext = 1363176
            Caption = 'Calculate'
            DisableTransparent = False
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Glyph.Data = {
              DE010000424DDE01000000000000760000002800000024000000120000000100
              0400000000006801000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
              33333333333F8888883F33330000324334222222443333388F3833333388F333
              000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
              F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
              223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
              3338888300003AAAAAAA33333333333888888833333333330000333333333333
              333333333333333333FFFFFF000033333333333344444433FFFF333333888888
              00003A444333333A22222438888F333338F3333800003A2243333333A2222438
              F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
              22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
              33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
              3333333333338888883333330000333333333333333333333333333333333333
              0000}
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 3
            OnClick = btnCalculateClick
          end
          object DisposalofAsset: TwwCheckBox
            Left = 68
            Top = 13
            Width = 15
            Height = 17
            HelpContext = 1363177
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
            Caption = 'DisposalofAsset'
            DataField = 'Disposal'
            DataSource = DSAsset
            TabOrder = 0
            OnClick = DisposalofAssetClick
          end
          object SalesPrice2: TDBEdit
            Left = 217
            Top = 292
            Width = 102
            Height = 23
            HelpContext = 1363178
            DataField = 'SalesPrice2'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object cboDisposalDate2: TwwDBDateTimePicker
            Left = 217
            Top = 247
            Width = 120
            Height = 23
            HelpContext = 1363179
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'DisposalDate2'
            DataSource = DSAsset
            Epoch = 1950
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 6
          end
          object DisposalAccumDeprec2: TDBEdit
            Left = 600
            Top = 265
            Width = 103
            Height = 23
            HelpContext = 1363180
            DataField = 'DisposalAccumDeprec2'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object DisposalBookValue2: TDBEdit
            Left = 600
            Top = 298
            Width = 103
            Height = 23
            HelpContext = 1363181
            DataField = 'DisposalBookValue2'
            DataSource = DSAsset
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 9
          end
          object DisposalCalculate2: TDNMSpeedButton
            Left = 469
            Top = 229
            Width = 106
            Height = 27
            HelpContext = 1363182
            Caption = 'Calculate'
            DisableTransparent = False
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Glyph.Data = {
              DE010000424DDE01000000000000760000002800000024000000120000000100
              0400000000006801000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
              33333333333F8888883F33330000324334222222443333388F3833333388F333
              000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
              F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
              223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
              3338888300003AAAAAAA33333333333888888833333333330000333333333333
              333333333333333333FFFFFF000033333333333344444433FFFF333333888888
              00003A444333333A22222438888F333338F3333800003A2243333333A2222438
              F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
              22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
              33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
              3333333333338888883333330000333333333333333333333333333333333333
              0000}
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 10
            OnClick = btnCalculate2Click
          end
        end
      end
      object Custom_Fields: TTabSheet
        HelpContext = 1363183
        Caption = 'Custom Fields'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlCustFields: TDNMPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363184
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            988
            356)
          object Bevel14: TBevel
            Left = 333
            Top = 12
            Width = 321
            Height = 32
            HelpContext = 1363185
            Anchors = [akTop]
            Style = bsRaised
            ExplicitLeft = 329
          end
          object Box181: TBevel
            Left = 8
            Top = 64
            Width = 976
            Height = 225
            HelpContext = 1363186
            Anchors = [akLeft, akTop, akRight, akBottom]
          end
          object Label179: TLabel
            Left = 397
            Top = 16
            Width = 193
            Height = 26
            HelpContext = 1363187
            Anchors = [akTop]
            AutoSize = False
            Caption = 'Customisable Fields'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
            ExplicitLeft = 393
          end
          object CUSTLBL1: TLabel
            Left = 139
            Top = 78
            Width = 3
            Height = 15
            HelpContext = 1363188
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL2: TLabel
            Left = 139
            Top = 112
            Width = 3
            Height = 15
            HelpContext = 1363189
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL3: TLabel
            Left = 139
            Top = 147
            Width = 3
            Height = 15
            HelpContext = 1363190
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL4: TLabel
            Left = 139
            Top = 182
            Width = 3
            Height = 15
            HelpContext = 1363191
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL5: TLabel
            Left = 139
            Top = 215
            Width = 3
            Height = 15
            HelpContext = 1363192
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL6: TLabel
            Left = 136
            Top = 249
            Width = 3
            Height = 15
            HelpContext = 1363193
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL7: TLabel
            Left = 408
            Top = 79
            Width = 3
            Height = 15
            HelpContext = 1363194
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL8: TLabel
            Left = 408
            Top = 113
            Width = 3
            Height = 15
            HelpContext = 1363195
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL9: TLabel
            Left = 408
            Top = 147
            Width = 3
            Height = 15
            HelpContext = 1363196
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL10: TLabel
            Left = 408
            Top = 181
            Width = 3
            Height = 15
            HelpContext = 1363197
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL11: TLabel
            Left = 409
            Top = 214
            Width = 3
            Height = 15
            HelpContext = 1363198
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL12: TLabel
            Left = 409
            Top = 249
            Width = 3
            Height = 15
            HelpContext = 1363199
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL13: TLabel
            Left = 680
            Top = 78
            Width = 3
            Height = 15
            HelpContext = 1363200
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL14: TLabel
            Left = 681
            Top = 112
            Width = 3
            Height = 15
            HelpContext = 1363201
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL15: TLabel
            Left = 681
            Top = 147
            Width = 3
            Height = 15
            HelpContext = 1363202
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL16: TLabel
            Left = 681
            Top = 181
            Width = 3
            Height = 15
            HelpContext = 1363203
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL17: TLabel
            Left = 681
            Top = 215
            Width = 3
            Height = 15
            HelpContext = 1363204
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL18: TLabel
            Left = 681
            Top = 249
            Width = 3
            Height = 15
            HelpContext = 1363205
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object cmdCustomLabelsOld: TDNMSpeedButton
            Left = 446
            Top = 315
            Width = 87
            Height = 27
            Hint = '"Add A New Customised Field For All Employee'#39's"'
            HelpContext = 1363206
            Caption = '&Add Labels'
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
          object CUSTFLD1: TwwDBComboBox
            Left = 145
            Top = 75
            Width = 135
            Height = 23
            HelpContext = 1363207
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD1'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 1
            UnboundDataType = wwDefault
          end
          object CUSTFLD2: TwwDBComboBox
            Left = 145
            Top = 109
            Width = 135
            Height = 23
            HelpContext = 1363208
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD2'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 2
            UnboundDataType = wwDefault
          end
          object CUSTFLD3: TwwDBComboBox
            Left = 145
            Top = 144
            Width = 135
            Height = 23
            HelpContext = 1363209
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD3'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 3
            UnboundDataType = wwDefault
          end
          object CUSTFLD4: TwwDBComboBox
            Left = 145
            Top = 178
            Width = 135
            Height = 23
            HelpContext = 1363210
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD4'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 4
            UnboundDataType = wwDefault
          end
          object CUSTFLD5: TwwDBComboBox
            Left = 145
            Top = 212
            Width = 135
            Height = 23
            HelpContext = 1363211
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD5'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 5
            UnboundDataType = wwDefault
          end
          object CUSTFLD10: TwwDBComboBox
            Left = 414
            Top = 178
            Width = 135
            Height = 23
            HelpContext = 1363212
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD10'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 10
            UnboundDataType = wwDefault
          end
          object CUSTFLD9: TwwDBComboBox
            Left = 414
            Top = 144
            Width = 135
            Height = 23
            HelpContext = 1363213
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD9'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 9
            UnboundDataType = wwDefault
          end
          object CUSTFLD8: TwwDBComboBox
            Left = 414
            Top = 109
            Width = 135
            Height = 23
            HelpContext = 1363214
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD8'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 8
            UnboundDataType = wwDefault
          end
          object CUSTFLD7: TwwDBComboBox
            Left = 414
            Top = 75
            Width = 135
            Height = 23
            HelpContext = 1363215
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD7'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 7
            UnboundDataType = wwDefault
          end
          object CUSTFLD6: TwwDBComboBox
            Left = 145
            Top = 246
            Width = 135
            Height = 23
            HelpContext = 1363216
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD6'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 6
            UnboundDataType = wwDefault
          end
          object CUSTFLD11: TwwDBComboBox
            Left = 414
            Top = 212
            Width = 135
            Height = 23
            HelpContext = 1363217
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD11'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 11
            UnboundDataType = wwDefault
          end
          object CUSTFLD12: TwwDBComboBox
            Left = 414
            Top = 246
            Width = 135
            Height = 23
            HelpContext = 1363218
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD12'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 12
            UnboundDataType = wwDefault
          end
          object CUSTFLD13: TwwDBComboBox
            Left = 685
            Top = 75
            Width = 135
            Height = 23
            HelpContext = 1363219
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD13'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 13
            UnboundDataType = wwDefault
          end
          object CUSTFLD14: TwwDBComboBox
            Left = 685
            Top = 109
            Width = 135
            Height = 23
            HelpContext = 1363220
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD14'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 14
            UnboundDataType = wwDefault
          end
          object CUSTFLD15: TwwDBComboBox
            Left = 685
            Top = 144
            Width = 135
            Height = 23
            HelpContext = 1363221
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD15'
            DataSource = DSAsset
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 15
            UnboundDataType = wwDefault
          end
          object CUSTFLD16: TwwDBDateTimePicker
            Left = 685
            Top = 178
            Width = 135
            Height = 23
            HelpContext = 1363222
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'CUSTDATE1'
            DataSource = DSAsset
            Epoch = 1950
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ShowButton = True
            TabOrder = 16
          end
          object CUSTFLD17: TwwDBDateTimePicker
            Left = 685
            Top = 212
            Width = 135
            Height = 23
            HelpContext = 1363223
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'CUSTDATE2'
            DataSource = DSAsset
            Epoch = 1950
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ShowButton = True
            TabOrder = 17
          end
          object CUSTFLD18: TwwDBDateTimePicker
            Left = 685
            Top = 246
            Width = 135
            Height = 23
            HelpContext = 1363224
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'CUSTDATE3'
            DataSource = DSAsset
            Epoch = 1950
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ShowButton = True
            TabOrder = 18
          end
        end
      end
      object Notes: TTabSheet
        HelpContext = 1363225
        Caption = 'N&otes'
        ImageIndex = 2
        object DNMPanel10: TDNMPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363226
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            988
            356)
          object Bevel11: TBevel
            Left = 7
            Top = 13
            Width = 971
            Height = 332
            HelpContext = 1363227
            Anchors = [akLeft, akTop, akRight, akBottom]
            ExplicitWidth = 962
            ExplicitHeight = 354
          end
          object Label39: TLabel
            Left = 20
            Top = 25
            Width = 33
            Height = 15
            HelpContext = 1363228
            Caption = 'Notes'
            Transparent = True
          end
          object MemoNotes: TDBMemo
            Left = 19
            Top = 41
            Width = 948
            Height = 268
            HelpContext = 1363229
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataField = 'Notes'
            DataSource = DSAsset
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object btnAddDateTime: TDNMSpeedButton
            Left = 440
            Top = 313
            Width = 105
            Height = 27
            HelpContext = 1363230
            Anchors = [akBottom]
            Caption = 'Add Date && Time'
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
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
            OnClick = btnAddDateTimeClick
          end
        end
      end
      object tabPictures: TTabSheet
        HelpContext = 1363231
        Caption = 'Pictures'
        ImageIndex = 8
        object pnlImage: TDNMPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363232
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            988
            356)
          object ImgImages: TImage
            Left = 1
            Top = 76
            Width = 986
            Height = 279
            HelpContext = 1363233
            Align = alClient
            Picture.Data = {
              0954506E67496D61676589504E470D0A1A0A0000000D49484452000003AD0000
              013808020000003FF38251000000017352474200AECE1CE90000000467414D41
              0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000034
              124944415478DAEDDD3BBADCC6F1F771682FA2033F5A01BD02D18922A66F4687
              E402143A73428666F6A68C94985A81B8023D4AA8BDE8CF739973E6D297AAEAAA
              46A3FBFB896C6A00F46D1ABF836900DFFDF5D75F1B000000B098EFC8C1000000
              581039180000002B22070300006045E460000000AC881C0C0000801591830100
              00B022723000000056440E060000C08AC8C1000000581139180000002B220703
              00006045E460000000AC881C0C000080159183010000B022723000000056440E
              060000C08AC8C1000000581139180000002B22070300006045E460000000AC88
              1C0C000080159183010000B022723000000056440E060000C08AC8C100000058
              D1AA39F8D77F7DF7EAE3FDFF7AF9FEEB6F6FBFDFBB3C40CAE3389D7F90FEF9E1
              1F2FDE7DD9B6379FFFFAEF8F7B17661C47ECFF239619D399FF146F98339966D3
              96CCC1CFDF9007B37E4F705CA709EBC1CC23F4F2DBC804FDE088FD7FC432634A
              939FE20D7326D36CC95E39F87A9CEA997BF272B6BE37D9B7044796FA6A4C3940
              135F4426E863F67F4899DBCF11CF18562B99F7146F983399660546B81E9CEC28
              05E5109FF74B8263CB9FF8271BA08584B3F0045D980787EDFF5E65F6CCC4E3B6
              267CCC788A37CC994CB36223E4E03BE92E4B0DDEDCCCABE8D9C97F34C11115CF
              F4538DD0624D979DA08FD8FF7DCB9C3F5A7ED014AFB12C3BD6E637DB29DE3067
              32CD2A8C9283D57FC2257B59DEBBF32FA2C771DD7C19661DA4B7DF7A26E82D31
              B91DA0FF3B943931E78B0F920DC407685A58CC7A8A37CC994CB335C3E4E0C424
              571BBE2C7CC1A4AE87F65C3379A1A27C7FEF1DF172568732EBCF11D51D441515
              0862983399662BC6C9C1B7A9B63E3B2593F00127B5BB7A7C7A7DB8628FEFA80D
              BB4C0EBE49264CD0778ED8FF1DCADC9C83D33BB9C7C0C34118E64CA6D9B263E7
              E04992F07D25B68315FA088EDBB057F3D6D146B4B9A24CD0F7C8C1A243580F92
              5E2471844606C8C1FE8E9E839B170A0FE0A106CCC2EE0EDCB0E4E0A591834587
              683848FAAA30A30FE32307BB3B7E0E3E7A103ED5FB08A7BA433974C392839746
              0E161DA2E920E98BC28C3F8C8E1CEC6E821C7CE820FC5CEB239CEA0EE4E00D4B
              0E5E1A39587488C68390847144E4607733E4E0E3AE113E2FF9210A7C14876F58
              72F0D2C8C1A243341FE4B8A70EAC8B1CEC8E1CBC9FCBB17980021FC5040D4B0E
              5E1A39587488A897373308313072B03B72F04E8EF8A8FC4398A361C9C14B2307
              8B0EE1719064103E427B6355E460774BE7E0D386B641619F408F30F53E96F1BA
              69CE8BDE721F634C6DDD0FB5DB0396EA3938E09D737B8C4B97093AA89B42DF41
              96DAF9D37E9B33654C57C696D9727C87838C371B67E6DE6469AD81C67B6C97CA
              AC7F8B83DBE4B6D7295E5025FBFEC8C1EE66C8C1869FB62E37510E8AE28BBB2B
              452FBEEF3EB59BFFBFFDBFC206E9E3140BA87B4BDF59D3A85FDF276827BFAFA3
              BA61CB434B50F6D0C9A494838B5535CDD25D7BAA7C68DD7182BA4938983C1F5E
              7BB9DBEB6FBDFC48315D195BE68662781CA4967644832CDBAAF9A6BB2D7B76EE
              AD1443D3A3DE63DB5AE64CA18BC5D3D473B753BCAA4686FDC5E4E07E837C4813
              E460D5E5E0C6773117EEBFBA1948B77B958DB55C2D525B579A48B749EAD3A74A
              28FF9A3DFBF84533A476E390B0DA1AB6B4B3EABC1EF43DCFE560D1A4AA2953E7
              9EAA55547E8CA86EBADAF672CFB73B6EC9EDD506D7153FA82B43CBAC13938325
              17529A4FF4957B164A73EF2699E0441DEA3BB69BCB7C7D00C1E42668ED5D4FF1
              A10D9EDBD0EB7A70F4201FD8F173B0340637FF397D76A04CC954BFFF587E4634
              FC5C24D9A430FF3CD440F767FDD3A733D50F0E932DBFCF9E6F2BFFDB37201F26
              73B0E29AB7F21D34FBF454EA10A2B60CEB26C945A4EB129B966F65CA92EBE1FA
              3162BA32B6CC6A413958F8FCB4E2AA10C541A43FEE3C1640FAADAF0D6FBFB15D
              2FB3F8CAC47331A45B145A7CB0537CD86412B92E2264908FEFF03958F6D75F79
              2E917C49CE069278E817EB608A6B868D6A9BD49B66BBABD4E366D579E0E903C5
              A245DECC66CFC167A52A6F141F851339F86FFF49269D6CFFD58AB47F4FA5F6AF
              9BD37DBB497A39C3506649A0CC15BA5ACFA0AE8C2DB345500E16AF036DF9DE3F
              6D7BBE4931FCDD7DF0452658A8E38ADFD8AE96F9C7A74FD4CBFCF891ECD9B572
              CDB9D837DA7EF23DC5074E26B19BB80FF22338780E6E3A693CD12CDBD79E79C5
              D7ABF6CAC11712BFFC7CDE5EBDFA3DF3FB50FEE73D7108D3D55FC29883958F1C
              0ECE87D739F8CD9BEDE3C72FD966D5BF2576849E4A955C531CE76E2AFE8859FA
              64B51CF244992CB3F44BEBDA95B165B6891A8BF2D388F98FECFADB2D3373EF47
              F925FEFE63BBBDCCDF0EF0F9F5A757A5A6D14FB5039CE2E32693F8E81C38C847
              75E81C6CBC9D537BFBAAE457D87C91A42B9595BF64CB376A9BD8C425BBA852FD
              9BA9F88B41A9FD0F0C59414293B03E57A8EE161DA3A752C52EEF3AB29B143F51
              5E378973A18D79D5B32B63CB6CD53507CB7EC956FE952DBE31A15C884CB1B31F
              0E1BDBFA7BD4D37FB2179BD1E17913BD4FF1610D9EDAB9FF25E4B8413EA8C3E6
              E0CCCF2096DB05147F1CE9BF8007CBC12DA1277F99D8FB48AA1DABDB485A8CC8
              D511FA5B3234F7430DD253A98ACACFA1DEDD1474EA2ADE4F2F2DB2E02AA26757
              0697D96C841C6CC82DC284D07EDD33BB419FBFF164CD61B83D4C3FA5EF7D8A3F
              780E8E1BE4831A39076FCADB1AC5EDAF1914CD17465CD745F4CFC1E2C493BB5B
              5D7CA4A8939AF60702CB5D01BE35D85AFF203F93E88B617A2A5151F9C235FF6E
              52DCED2CEF9E8B4F9A9FB524F863DAB12B63CBDC60881C6CC808B28460C81EE2
              6F4FC8D8DE4C9DDE7C9DC23B07879CE2A31A5C5B39EB2651837C5083E760295D
              DB2B0685E994F0BC91E2CFC03173B02506DBDFAFE1729951DDB0F2A55CB54379
              55C1FE3E39C1C596717A2AB5EFFC8E3B7493788D81B47BAE8E6CF936950E10D2
              95C1656E31460E567F3B4F1F57FC38BFD53FAEDCC47D6C9B9A22B149488C1BE0
              141FD4E09D1A306A900F6AE41C2C785894CF93ECA5139E6B17CF95839BFE8A51
              B681B228D22FB0A50C615784CD85AAFEB83A504FA5CA2B5DE2B85F3729966E5F
              1DD77E095BFDFC2A85AB7D0797B9C9283958374D4A13426C0E1669BE2D212807
              ABEB39C4295EC0747F69A7F7C9850CF2418D9F833B1C4AF8303DDFF2CC9583D5
              6FB248DA2307B7BDD0ACD3939C5A1601285EF124D73D070FD04DF996133E6CD4
              F630FFFC0122BA32BACC4DF67F5E84A199C40961CF1CAC1EDB990D0F9783234F
              F19A46D03461AFF72A470CF2419183379F5555CD8538740EBED86CE70542BA86
              B52F887ED0FA8631D96E154D5AA9D0483D95A8A8F8650D3DBBE9761A787A96F3
              F33F551F21DAD289F567787975657099DB747D7EB0D3AFD9F284B04B0EB68E6D
              6D33145A7BD71CDCFD1568AD0D6E6B40E36504FF413E2872F026BE21821C2CAB
              CCA172B0E5C10CA5A33955DF310717AEF71D2707EFD44DB91F4D45DD637DF1DC
              B6630E8E2E739B9EEF93533FACA1784FB7FAE57D5B780E6E1ADB99BD1C2E0787
              9EE28BF5B636B8AD01AD3FA7B90FF241918337CF1B831B0A71E81C6CBBC33C86
              AA619B9F7D365C0EAE4499917A2A555AE9CBA2A2BBA9FCE83049F7B43C484C34
              8603BA32BCCCCEC50BF9B23D70B97EAB4A08DD7270FBD8B67E3AD9DC03E5E0A0
              0B9A9E0D6E6B40F3B232EF413E2872F0460E6EAFF2BE371B94ABA0CCC1DA5117
              F33A8D3E397880DFB1AC3938B29BEA01D39483BDD7DA0674657899BD8BE77110
              630CDEEAC3409710BAE4609FB16DFD74B2BDE7CEC1DE0D6E6BC086DB2B7C07F9
              A0C8C19BF7237E8D85982807EFFB8DD83B07EFBC3EB832E58DD453F5D29EF4EB
              26D945D6017370D00A81F973B03D06D7A6CBD37F75D999C3267E63DBFAE96483
              8F94837D076D4483DB1AB0E53663D7413E2872F026FF92B89668E21CBC6FBC6A
              5C1FDC7C07D69172F0FE41D8BA3E38A49BC457586D39D8F91964015D195EE6FD
              8A97D31283CBF3A5F6E6A1D81CEC3AB6AD9F4EB6F8483938EC0D416E0D6E6BC0
              A6C7ED780EF241918337C56BD93D7B7BAA1CDC6799954C6B0E560EBB863B8BE4
              7B6DC8C1575D31524F254A2BCFC1FEDDA4586760CBC1CEEFA408E8CAF0327B17
              AFF920A918ACDA697628A81342640E761EDBD64F279B7CA0E745C84A2311D6E0
              B6066C7BECA4E3201F143978133F5CD056A66F23E5979F046F873E740EF64883
              B986D26A7C6E9AF63B1D7381D5ED7911375B0ED453A9E2489F9BE6DE4DAAD7D5
              999E17E1FE8EE280AE0C2F7313F77344F249118DB7603E6EAE4F087139D87F6C
              1B3F9DDA64A4E7074BAB7053A1ABF930B0C16D0DD89883FD06F9A0C8C19BE205
              9AFA42DD1DEAD36BC9CBA08E9D839B6FE8BF2FE6EF3BBC47A33161053D78C79E
              836BAB4607EAA94445E53F603A7793EEADCDA2EE491459DA8FD6F7C935776578
              999B389F233C52F09699331F4788A67C613938606C1B3F9DDA64A8F7C949EB70
              75A8AB537C6483DB1AB03507BB0DF2419183B7D2A048CD94DA67346622C35C39
              B8753AB93FEE16F2ECA75A39DA1256D0FB889CDE2797DA6E9C9E4A954671E1C6
              B39B94E70959F7A47E73B73CD94A7180E6AE0C2F730BD77384530A4E34DACBF7
              9F5F7F7AA5BE873E2A07878C6DDBA72DE53135CDAEA7F8D006B73560730EF61A
              E48322076FAA17C9D73E9FD858F84BEFC17370C309F47454A7FE56376C53C20A
              7A1EAF3507979F5499DCB7AAC2AE3D952A8CEA84E5D74D31A72EF3E253E9180E
              E8CAF03237703C47B4DD1E27DA9BB674E460BFA6D9F5143F670EF619E4831A39
              0787AD3A517DAB92BD2F7F3D50FE93A6A8A39E10948FB76DB8F726399F2826B9
              1DAFA5DA9F4670B1A5E37835E660D92BC686E9A94D3741C77593768581B47B6C
              6F2A5364CA80AE0C2FB39D570E36CFE98A92E9F7189483A3C6B6E5D3A94DF6CE
              C1EEA7F8D806B735A0470E7619E4835A3207EB0645FA5423CC93D2A7F58B6BAB
              DA4A7FD1A3E96466F983F1691BBFCE769867A5E5393F94EB8460CBC1E2E20CD2
              539BB2B3E2BA4913B135AB11329347ADD4379B694A5329D256EBCAF8325B35AF
              E5CC3658C4F3D79CEE456ADE246A6CA736182507EF7A8A0F6D705B03BAE4608F
              413EA8717270627A8AFA53433B2832A79AF4A6F62C72BDAFE43D76E23F361F77
              FFE6F3E7ED95FCC9306D177532F3497A4F171FF6FC3A991AD674A9E9EC48CE63
              D5326F9D6FA30E2DA58A87F594BEA251DD245D2598990ACE3FFAE7870F5FDFBE
              FDB1B4E772B9953FD406746578998DDC9F9EE7594EF75B91BCAEC1C78D6DDBF9
              A2478CDBF5141FD9E0BD1A30783FA3192607F79948D387AA7F794BE79AACA607
              153C0C38D14FB8D70DF5FC89F39B3AAF37F8FAF77F27162F2B9751DC2A4C2879
              BEFD6C6C58F51FBB679FEF70C657AC32332D3597F1AEA8E1BB18D34DE96FF879
              699EF6F3ED1F7FFEE345F24FADE4E02A4C1ED7B52DF7C9E96FDA9B6AF877657C
              990D5A2E95982EF9E948D6E66BAA6759D0A5B8C0EF32B62D8FDF75A8A7FADEE7
              BEA7F8C00677AA9C79DCB70EF2418D92833BAEC1363E1A487BAEA90F91EA374F
              711B7AA100F98F4B7ED169FF79AFC6BF8FAD0DABF9DD3D32045FED5FD054B60B
              D343F694E12AD8E6D14DC2C678D84BE12B28BE24573CC8CD8F3895F609E8CAF0
              322B29A2F9997C4F057C6D9F0FA6AFB1E5B905D2BF96C3C6B6FECF75CB575EBD
              C9EEA7F8C8C9A44703CA5A698EA5C1F746C8C195E1E73A5FE507A86D15695B99
              8B3597BF89B1BCB134DB96761A765538E8AB646DD84D72D1E97C18844E05A285
              9A8DA5D9B1A79ABE8B01DDA4F9F329D76CCDA7C6C78358FE20F5EFCAF8324B99
              AE7837D6BEA198DA6318BE0AF94DA43FD5E736128E6D5D01B6E2AE657FE2CB36
              19E3141F3499B80E94C645C213C5E0DD72B0715EF37EB08DFE10E66B8DAA7259
              7E1DCED540FBC8A886C6D1ED37F47BD4F403836C36ECF4A390AC302D8DD9B9A7
              E4E71AFDCAA28486D76D148A62FA8DBE56E0DBF7950A775C2A96B690DDCB6CAE
              8B42A7EFAAF6C5028A6BEE8F35506C51F8BBB0F8C1DAD896F7CB692BC32946DF
              32C39DE23D2713C39CE936CD5E9BE7ED19CF46B81E7C449E77F5D95FC5205A36
              B5F3B08DBC4A54D1FC8E8BF4D43A524B463E67C377EFDD1BC6EDD1B2823517CD
              7FFC66D6E95BEBE0DF95F1659EC0F82D103EB6E7E1738A9FAFC1C71FE406E460
              0000DA9CFEEC3EC4DF8E80C5A4839C1C0C004093491302F06CD6414E0E0600A0
              C5AC09017832ED2027070300D060DA84009CCC3BC8C9C10000D84D79F310706E
              E2414E0E0600C0EA749D6CC68400DC9B7A9093830100303A3DF36ABE9F8B8147
              730F727230000045174F234FBCAD60CAEB6458CBAA839C1C0C004041ED6D65B3
              06042C64DD414E0E060020AFF292DA397F2CC65A161EE4E4600000F24A1161E6
              7C80852C3CC8C9C1000094A47F339EF797622C68D9414E0E0600A0E2F27AD9E4
              57C8B0A635073939180000002B22070300006045E460000000AC881C0C000080
              159183010000B022723000000056440E060000C08AC8C1000000581139180000
              002B22070300006045E460000000AC881C0C000080159183010000B022723000
              000056440E06E6F6EBBFBE7BF571DB5EBEFFFADBDBEFF72ECC001EDB63A3493C
              D1AA389CAE83967938E9CF0FFF78F1EECBB6BDF9FCD77F7F0CDBA4821C0C4CEA
              345D3C60FEBDF37CE67B40AB78A0557138DD062DF370DA65078842AD61139152
              0EBE1E27819E2AE479CCB656F22B8969E05F7E77E28E8319A5062FC323F9ADA2
              599AD1AA389C2E8396793829196ECA71CDB089C6683938ECF82DA3CF90493D4B
              516E07BFB180E32B0C55E65F125B0C5A1587133B689987D30A592617640C9BE8
              297270F1A0B785557D3CFBE17C23E4F75F8CADD6A6CBECB430A8F3C5D07F13F4
              47C7828A7F313158EEF00B7E045A15871337689987D38AED924E66864D2C6439
              B87E3C650EBE7716EEF26323D10EE281944DA25E976545FD902E85B608A9F1C0
              A56064DD0C9885E7DF4BDCD1158156C5E17418B4CCC349B7A9A89A660C9B8815
              72F0E9B0A27EB3E460D9316EF7AC1C4899BF28D4C3319167C5FD90CEC29A6EE4
              B747E8708D0E00F6C53C9C74136854174EA59B485573B0B0D78C39587094E61C
              9CDE89A11DCD753CABA8BD002EED80755C0F38860B0078B89B5D3FBD96CCA8CC
              C369E2B5B14D9B08D572F00FC223D933E2FD6136CD325BDB406A5F9ED09683B7
              C6B50DCD47C75A987F0120402DB55C7F9479F8C65172F0DD417F97F659434AAB
              E46DAF1CBCE5AE0A774CA2A92C2EAD0D39182ACCBF00E0EFE1642C9B519987D3
              8E9483B71E19B17C20C71CDCB84ED72389DA6FFB23074385F91700BCA9EE9C62
              1ECE384A0E6EAA945F195D73705312F6A8A3FD8A3039182ACCBF00E0EB795E25
              07B72007AB38E7E04C1296ECD3A58EE635C2E460A830FF0280A7F359951CDC82
              1CACE29E8333EB84639E912C3A363918FE987F01C0CFE549981CDC821CAC1290
              83D341B8BA5B72300E84F917009C18DF88C13C9C460E5689C8C1B6207CE8F5C1
              8F9B27B7D13F9FFA660B6B9FF8BEF24FB26BB769C8F6C7543FA2F9D76B6609EC
              C7D8D6D1DDCE9BFB06394FD0877D8DBABE55EBEFE9FCF6DFFFFD77EB3375CCBB
              EAC6711A3962F5072019B40DBDD4751EEED55637F423961CAC1292834DE3DAA1
              8E0D0F4EB31EFDF29057DB94DEDE9DDE7DF68BA06C8FE27ED48D63D8B57D7C16
              5F79DEBA733F95F9B7508BE6D7C3DCCAF5A3A02D8BDB970E9FD9E6F29082BA5A
              BF418641103D74E3A85B759377BE601630EEAADCDEE9C3160FA598AF3CA711C7
              96742519CFE79514D723D1328563C9669F4C6B0B67B8ECA1FACCC3D1FCCFD7E4
              6095981C6C59237CB4E707579660E8E761C177C1F212EECBA3B4B57269019774
              422BD4E16C1717A54AED7AEF59AC30FFD6BBDEB254C7DE8FF9F248BF1D97954D
              6FA57FA363F33768A0A11BC5F89ECCB3CDAE0BAD9DF15D7695EA4BF57511C325
              C2F669C4B1256364BF26D9AAE587BBFEE5BBB25F40739F1407F313550EF69D40
              C2C49CAFC9C12A41DF65C3F3D30EF33EB9C259F3B48DF4FBFD7C8CD62B77E97A
              A4EB607B25BB390B096BF054AA4CC30FF6E6EBCCFC2B8D54BABFB2DAFBD19E2A
              AEAA9BD8487DCDA5FE0DF26AC6D4F1FC876E88862B594F9BE60B7CBE77D1B869
              DE9561B197657D98EF34E2D89291128357FF5786F05C597CB059CBE557DB4ADF
              E079385AD8F99A1CAC12F537AD7E65445B1D8DD74DF4472F06D6FB6D327367E1
              817267FBACFD35A85967259BBB650D25FE61F6A6C8A24E28C5ACC2BE774CC2A9
              F9F79FFF4B9F22D417A222FAF1B61096CBA937DB944F38EA8B40771BBCF8206F
              464D32AA55DA367443E85B35518DF2C7240F6A75DC9529E76837719E465CAB1F
              4BFD2783F91E9453A3D42FCD5EEA9883DDE6E16871E76B72B04E540ED63F46D8
              5EC7A6D7D8B51C3D71E2FCBCBDCADEEE93BE18F1F9F5A757A5D7E728C25FF117
              96D227755799C5BFA34A5B5278BE19E597C864515EBE7FFFC3BB771FE5DD28EF
              1DAF7EB4FD0E70BE69650B7DD7B77F83761EBA1D284B25B88479B5E3EC071D77
              B575C8C1DED3886FF5A3A9538C2DF608EFD5347C95BC72B0DF3C1C2DEC7CBD91
              8395BAE660E53DA3EA6F72431D6C2DAC5F069D2E72B1BCE2E74D28728E689957
              6EC7867023BB9CA25F9E26DA2884FA0708F963437AF5A3FC6B527A9883AD8EB9
              223936636AFFCE43B70F55959F6B203E59D62343F3AEAEF627DDA96613F769C4
              BBFAD1BA04E1C79633AC69E99483ABC7D2172C4AD83C9FDA3939B868E41C6C62
              2CBEAD855BAE7DCA37914E1041DF2BFDFCA44A13F2AB2EE916DF691ED377BDB8
              1DE3E647E339401A831DCEC5F26B6F920D82876E2F8A5655BE90EBFEE35BFA73
              8EBB4A56C33707BB4F23EED50FD721088B63B061E75E39D86D1E8E460E6E6D31
              72708EB5F43E393860C95BA270C200E5756DC63C5B4A36C9DDDB2DDEF55EF398
              A11FC56D1ED38FC9E6933FD82CE6EE0CFD04AF3946E8D0EDC79883A5F5FDF4BA
              9A831B7795AC86E7CC17308DB8573F5E7310162E32EA331584BD47C3300E63C4
              CDF3E460A5917370A58E5E4F9AB41D3DB959C8DFC99A4DC43F0E86E660F9FC5A
              782A9170D7B202F973F813481467FCFA31DD7ED2EBAFB6D7D144E460C5269143
              B723730E96BDC633F3F607C75D25ABE1988323A611F7EA77A0FE36991660779A
              0AC272B061CE89D26F9E2707171D3807970FA5ACCAD039D8F98B9B38076872B0
              6191BEE53D0D72BB449501E65F653F66B6923D6049D8C6CD27E2D81CECDF3C5D
              681AC93628A27795DA9F5F0E8E9946BCABDF43EB3A29C989C0785A26075B9906
              2239586586E745648FA7D8C91239D8F64205873021BDB3CF66B91CDCF6620CCB
              6D57D647B71C3F078F70925435526E70182AE2B8ABC4EEFC7270D034E25CFD2E
              54D392EEA1E2BDA7027270CB3C4F0E56E9FAFCE0D8F768E4868D6935D35C39F8
              7621D2DFFE63B8115B7C78FDCF9907B8D6526E952EF36F533F66CB517F159DB8
              A483E5E0B8A1DB95AE91BCDECDEEBBAB2D2E07874D23BED5EF433E2F9D163CBD
              7CF9E58BE03BD27D2A5838073BCCF3E460959EEF93D33DDDD452C7CCC465B80C
              344B0ECEBD44405370759AB8DA40B23A7890C421D779FEF5E8C7DCDE6ABF372B
              7A66B01C1C3774BB523752ED0269D38231AF5D8D9F837DABDF8BB0999F73ED4F
              BFD4CF483B4C054BE660B7799E1CAC129483F597839DEA68783E6FCBD107CEC1
              E5FB9D7505D7FDBE7C55DCEAD54679DB0DA4DBFCEBD98FB9CDD2DBE9CF7DC3E5
              E0B0A1DB9565E008D60A486BE7B5ABA81C1C3C8D38B6641F9A46BB7C036AB63A
              7B4C058BE560E7799E1CAC1293830D31D8AB8EE94BC2929B7D27CAC1F53383B6
              E0218F6ECAFDF17B045DE65FFF7E5414FFF123AA6E192F07873E75AC13EB895B
              70FF9874C078ECAA4B0E8EE935C796ECA0DE6A57B9B6361B186230395821609E
              2707AB84E4604B0C76ABA3ED8AF03C39587675445F70E184A3392969DE793B9A
              F0F937AA1F3385C95D81685B503A420E0E19BA5D359DB8EB11CEBCE453B9AB3E
              39386E1A716CC960B566BBF96E97BF2196184C0E160A9AE7C9C12A1139D81483
              FDEA983CFC2239587C2AB7E5A74A78D29E9046BC27492A76FE0DEEC7D4A6E9BE
              547E07C7CCC1A9AD1A876E570E27EE72866BBAD027DE559F1C1CDD798E2D19A7
              3C6212DFEDD274B6D354B0420E8E9BE7C9C12A013958F73416FF3AA62F08C7AC
              CA182B072B2E6839E6A714DB1C36CAE51489C8F9B74F3F9696CE9AAE0069AA68
              DEC0F1AED1B441928C538DA5F557D7DAB0AB2EF7C9B534CF3E2D19A2D026E9EF
              76FEEF445B0C2607D745CEF3E46015F71C9CFC73D9766307D783336D9ADEE46A
              C7AADB8794CB04EF3EFECFFF69DF94526F0BC3D8FBB68B5F7E9AEA7D723DFAB1
              52076B0C1E39073B0FDD9E7C4FDC9908E77757B27060C73D3FB8D734E2D892EE
              B263261B6B332726630C2607D7C4CEF3E46015E71C6C4EC17E75D4BFC9AEE1E8
              03E560D5D7CA949F4EC5F0FB7EDCF695E599D1BF4FF51E8DF87ECC97E8F16896
              3BE434556CD9C0761AF31FBA3D299F98FCC7CFEA535E6AAF8EBB4A7E32F27D72
              0ED3887BF53BCB0C9A42AC4D9E99AC31981C5C113CCF9383555C7370430A0EBE
              4F6EFEE7452877AB2FF8690BD759E3B6D9F54B15B75D7E888C9A7FC3FBB17EB8
              CD7AEA1B3507870CDD8EB46F0EF9C13075A573B0D3AE921FF3CBC121D3887BF5
              7B4B8D9A17C51F7A1293C1C3B3852D99801C5C143DCF9383551C73B0EDF638EF
              3A1A4B410E2E16FCB904CE9346CBE5948742EDB41E6F921C9CF84DF9FD0FEFDE
              D94E7D43E6E0B0A1DB8FFA0D7AA65FE0D20FCB72D995E243B64D02A611F7EAF7
              7773C9F1F3F6AAF817AEFD3D54F57D91832F90831D1ACDEFABE695836D5761CB
              7B30F483B91847CFC1DA9F06CDEFD1F09E346CCB589E37DCEB9C1334FFC6F6A3
              600FF61D49ABD8B641C3E3E7D6C9C1A6A568C9EBC13EBB525723B5D34DF092E0
              2B2DD3887BF577A0BE65DCF01ED89CC6A7A54F9E83C3E7797270FF3DB787E0CD
              25073794C3D80EC3E46055F3692B1BFB50A9CCDD26C5C33C6DB3DB29A7D7F560
              CF7E9415CBBA9F548976CFC1433F0F4DCAF02610D582FF74DB38EE4A5F0FFD0F
              7BDED3887FF577906814D50B151BAAA33FCF9972D8417370F83C3F630E4E9DA9
              9C0AD97C2A353DA54C56C7B6670FA86A63FCFA5B7ECA091AA0D23122B8C7F9CF
              0F1FBEBE7DFB636D13B15A0D4B4FE4CC9E9DA56D17C561FE2DBDCCB8DA80867E
              9496CBF1C15C113F866A36891EBA7D98DE88A77C5465F682A8C7AE6EF658A9C9
              D3CD598F3FE42BAB7ECB308DF8577F0FFAB5CB5E69A83D07277FA1F8F43AF9AA
              BB27CE134898E8797EC61C6C7C22AF6DCFE657B3B6152C5192E6F71CC98B625C
              5F66B943C2F0901FD126F5174A3FEDE6DB3FFEFCC78B64C91F3E73590DC14B45
              EB34579C85760D2986AE976D12D78FE292991BF6A6ECEAFB532D0F1A376623B1
              BD838DA655357F269E37646DA955DBAEB235B9F9FCD56AEECC45E1AF7FFF7772
              EDAEE7341250FD3D5C35B9FA0465AD8E7E2AA85C0ACBCC6861F370B4D879DEA3
              F9FDE63D971C9C9BCBDB7BAF709690BF16C8A544C6C79217E63D4D275A13BD21
              BB1B2E3C4B37119EF31F4AA86A39973451A9A8F6183B871343D74B3789EB4759
              D9EC2DAB1EDC961FBA742DDF63E80653B56AF575D94FCEDA51F67A8A865D253F
              5A723A94FABCE0378D84547F07E7F5D0AF11748BC1C620BC557611380F478B9C
              E703638645730EAEB5554307B6FE6478A6ADBD9C4E55D64631BE2733BF59BE35
              DADFC154DE44338FE4762C7B06BE91FC76BCA6FD042B143337F4F23D235DE392
              ABBFB21F7354BF0257F6202C8A7A03DB97AECFD08DA26DA4FA55A6EB2651CE70
              A65D9DAB77C7CD454049C55547909437A8FAFDE91F98727E21D2E36ED967868C
              9ADF387C1E8E1634CFBB4EAC2EED62CAC1D65C68F91DBF41C84B8D7A15C7D0C6
              A731292FB97E8BA76A28CA275DC3509AC1331FB9E2D167ED27B1FDCE36FA4E31
              7763683F162BE77373AA6FA328B6103E19D5A2EB9952DDAA8F74139BE32F344E
              6F66BF6AE48B4FBABEFCBDBAB3B8EAF7A6FF6A1B9FC5631DB4827D9C17A5E73C
              1CCD739E97D7F2FAC5A19A4D2CBC9E1701284817BCEB7ED0D32D39CD1546B8FD
              B0AF69EA29A61F8B479BB38DBB0EDD5DDDDE4AD4F44431A75DA58856863F7EC8
              F599F6C2F20657BF2BF55B37777C41D176DDD023FF89E1A3EF3CBF037230E6F0
              F01574583A7AAC2F308E8FA10B00BB210763022EAFAC68BDB403E8317401604F
              E4601CDEE9D798C61F0055EF67021C307401605FE4601C9BFE66E31CE31A4DC0
              86A10B00BB2307E3C8CE6E5868FC51984B6AE88AA10B00032007E3C0CC4F2DBA
              E6B24A131063E802C008C8C1382EAFF7B0739B113A63E802C010C8C138AEE4F3
              327591C06F8D2620C7D005802190837160C5B7CD94D3C1E5A3C14912E88BA10B
              00232007E3D8AC2FF97EC66FCAD80543170076470EC6F1D903054102BB62E802
              C0AEC8C198C5F54BD0CB8811180643170076420EC6744AA9820C8181317401A0
              2F723000000056440E060000C08AC8C1000000581139180000002B2207030000
              6045E460000000AC881C0C000080159183010000B022723000000056440E0600
              00C08AC8C1000000581139180000002B22070300006045E460000000AC881C0C
              6029BFFEEBBB571FB7EDE5FBAFBFBDFD7EEFC2AC8C8E00B03F72308035FCF9E1
              1F2FDE7D39FD3FE2D76EE80800C320074FE2F2CC22C2E907AB78BCF27881F1BF
              033A02C060C8C1F3499D6A9EBDF9FCD77F7FDCBB88401F85BF0F895F3DD11100
              C6440E9E52E6A4C309074B29FE49C8B7A11F3A02C0A8C8C1934A9D78B8148C75
              DD7C23885FFBA023008C841C3CA9C415614E3758D975FEE2FBB0133A02C040C8
              C1B3BABD20CCE906F3B9FB83EFD36BC9C8BEFED390EF832B3A02C02191836775
              9B83591681E9DC67AA4D14A4885F91E80800C7440E9E153918F37B18E5B22045
              FC0A444700382872F0ACC8C198DD295011BF76464700382C72F0ACC8C198DB73
              9C227EED8A8E007060E4E059918331B3F33045FCDA111D01E0D0C8C1B3220763
              5E97A39BF8B51B3A02C0C1918367450EC6A48C2F62207E79A323001C1F397856
              8D39F871F3E43637EFE8A8EEF9660BEBA92FF3C2688F7369F4BBA893AF96B5ED
              3DB1AB8B2EF8F6DFFFFDF7E1B245BA81952DD0D08AA2F875BDFFC63F1EDD3A3D
              F37D3CDF7FDF3879948EF09E314A13A3F3E001D005397856D61C7C79DEB8DA26
              79F22BEE3E7B1A9297A8BE9F6796939B6CD7F6735AA9D1B43B17ECCBDE105144
              85AE37817008641BA012BF0AA534F4BD5BA767BF8FC9E6E892BC8ED111DE3386
              7562240C03832307CF4A9F835373F9D936FA33BBE04C243A0B5D1DF9F2286DD7
              BD4BCB1BA5A7FB421DCE767151AAD4AE3517D5AF0F79BBBF4172F045FB56B343
              A1D0E23F00F2FB2AC4AFFADE6D7FB235757AE9FB18F8BB48C5213AC277C6689E
              1889C2C0C8C8C1B352CCF685C077DA467AF67B3E86748BDA89FB723FE93A5C1F
              CBF2F36C7A1B4916CE1DEDA9549986D7BDF9FAE9D3F90FEDF72379D279DBE5C6
              DE6DFB4A32836D8169662BE99F3BB230E3D1E9D5EFA3FE679920437684DF8C51
              9F187D070F803D90836725CEC1C5C07ABF4D268225CF010F1F39DB67ED5A8CE6
              9A982C02D6F699DAA2F0F99B228BCE694F8D538C06E21B8D6AF1EAFAA8FBE7E0
              B3AA95CB6288C27EF1EB9FFF4B3798E982BD4BA79793D55D19B6BBED73D9B16F
              E01AB023FC668CEAC4F8E283BCCCBB7F1F01E4908367655A2F90C87C9FB757D9
              FB42D297B73EBFFEF4AAF47229C55DE6C5DF374B9FD45D65760F6AC2D82A5ED0
              20B8187CB5C37DCFBBCA67CA6A9F3BE015BFDEFFF0EEDD47F93895FE7CEED4E9
              5BF6FBF87B66416DF74E1FAF2382668CF68991200C8C8A1C3C2BDBBAD9E43510
              C5F59793E2AC2FBE88A558EF70BDCF7265E567CB741DA557654D377F95AE4C89
              43E59EA7DD8B3A2997139CA806902D7E558BA7BAD8EADEE9E97611D7B68BE13A
              A2D78CE1596600FB2207CFCA96835BAE7DCA37919E3E83CE6AFAB3B72A08EB2E
              CF093291F2EAEAFDC7B7FDC252E9DE38453314B6F48A5FDA0BB792FBF8BC3A5D
              F9C17D0CD711FD72B0F897195DDB00E88E1C3C2B9F1C2C8D5DCAF95EFA9BA462
              F982E2674EFD6262C5C59DDCD302C4BBAE3D0D4256DA4FAF773AEB4AEE3E94B5
              437E5BD7DBB34AA4832AA0D3331F1C29050FD8114133863635A7F63F58D70138
              2107CFCAF83C31E53ADBD4915C4F11E29F9B4373B0FC3A53E1E166C25DDF1648
              9D1B767C8F8672C549BAE56A5B778B5FC2F413D1E9AA02EC65B48EB8FCA8DF8C
              61EA88C1FB0EC02372F0AC86CEC1CEA78844AAD0E460C39D5CB94D74AF18C8B9
              DEBBB27E3B320C9F27F22BC283C5AF984E571460378375849CFA1B450E06A645
              0E9ED5123938FF68A3E01C2CBDB3CFE6A640B9DD8E766A6DFB29581C84078B5F
              419D2E2FC06E06EB0801DB8C410E0626460E9ED5DC39F87619E0DFFE232EB861
              D1A5B0592EF6EC79C9D6EBF5D4B15A57B34AC7EC58F12BACD3A505D8CF581D51
              D4346390838189918367356B0ECEBDFF425370755EBBDA40B23AD83D12D5AE3A
              0EB052C2F6CA9167D20BC263C52F72F0932173B0C78C410E06E6450E9ED57C39
              B8FCD8045DC1754B23AE8A9B2FEDC56EFD83A9E007F83D4FB6B6972417777084
              1C1CD9E98367A9B13AA2B255D38C410E06A6450E9ED55C39B89E35B40557945A
              FEDC32F1CB9AED043765ED756558F3E8B334E1535AC78A5F919D3E78961AAB23
              2E38CF18E460605AE4E059CD938365D7DBF405179E8E353147F3BAE616F530BC
              C7493720071F617D7064A70F9EA5C6EA88270133063918981639785693E46071
              0AB53DB1ABB252581B715A1E1BA6574EC33B5C15368EB9C20E8E97837DDB7DF0
              2C3556473C889931C8C1C0B4C8C1B39A22072BAEC536A411C973AF6C67F81EA7
              3EEB93A0BA14455904E1B2EDB1E25764A70F9EA5C6EA883B5133063918981639
              785613E460D5BBC98C39F8B124771FFFE7FF52975775672FC3A38913BBF8E5A7
              B6A742190BDF4CF14A3851350EF21E8DC04E1F3C4B0DD6118133063918981639
              7856C7CFC1BA57F45A72F0A9187E67A8E64726DCD7E3F7CBC2DFEDF48F9FD5EF
              7EB61CDDBDFAAA12981E4FB7ED1EBF423A5D5380DD0CD6118133063918981639
              785687CFC1CADDEA0B7EDAC2F5FCD4B834E0BE61B6AB2DEEFFF10743EFF53FF7
              B605E1CBADF30D3758FC0AE9745501F632564744CE18E460605AE4E05991838B
              057F2E81F3E9A9E5AAEC43A16E8AFEF0CFB29DF4BD532F570553EDE54FE21D2B
              7E6D219DAE2BC04EC6EA087230000372F0AC8E9E83B53F369BDFA3E17D7A4A3F
              C541DE28B7257FFC0F9620BCC3B9D7FED0888B2DFD6F8A8CBC3DCBBFD39505D8
              C9481D113A639083816991836765FCAD76981CACCA53DACAC63EE73773D35AF1
              304FDB14FE2450AD790EA99988F592F079B3295F0768781F61ECE3BA64072975
              BAB9CC5D0DD5119133063918981639785289302239875ACEBB8673A16493D425
              36595EBEF9E89F1F3E7C7DFBF6C7DA2662B51A961EEC9B59F550DAF3F32714AB
              9E851F0F617AA1C659C1D52F03BC69B7BB127C7A9D5866DD16BF4A9B3877BAB9
              CC5D0DD511813346F4E001B01F72F0A48C2B162D375A191E1B25DA241D2CCE3F
              FAB49B6FFFF8F31F2F92257FF8CC653504EF26AED35C7116CA34B634345D1F77
              CF0B50DAD511BA852AE54BCEA92EDF4C635BB98967A767F63858981AAB23E266
              0C8F498E0BC2C098C8C153CA043DFD7536D3B54FF93D6AE54D8471F5A184850C
              925D71DBAA5851ED31E48F4710BD4560F7C0A4581EA15FAD5D6DDCDBEA1BC6B6
              7E13BF4ECF1560B03435564744CD18D22BCD8DD504B00772F07C8CAFDBCD6F96
              3F591BDE65A6DA447396CDED58FCAC2B0B438ED1EFA77E99EBFA58BB87E07CFD
              AF8A765E3755A98B4D7BDDE7850FE7B2497EE81902509AFD178551FAB75ADDEE
              1D113063184682652E05B01372F0240C57384F53B23C11EAB7783A5728CA275D
              C3500A82998F5CF1C8C2D56B3CD583544F8DBABE1DED4C2B2BBDE15299E0CE34
              FDA8338F5351D9D2A5546EDAD66A0106EB08AF1923B4CCA37D4B818591837100
              D25BF174EB0232CB179585116EDFF013F7EDBD46E6C774ED289D961AF380F4CD
              1B03D579EC5EB21AAD2362660C00132207634D0F2740FBB9EFE9C4CFE9130080
              832207634195B717C83C5E4A220703007050E4602CE7F45B68E32FD4AAD7BC01
              0080E19083B196E7858CAD01D6B8BC1800000C821C8C959CDDCEE37387163118
              0080C322076321177791B704619705C600006057E460ACE3FA7163D618CB1D72
              0000CC801C8C75241FBBAB4BB37ECB8B0100C0CEC8C15848F1854FE5607BF960
              7E42300000C7470EC65A0C2FA0BEC272080000E6400EC67AEC59980C0C00C03C
              C8C158D5E54A871A12300000B321076379A5404CFC0500605AE460000000AC88
              1C0C000080159183010000B022723000000056440E060000C08AC8C100000058
              1139180000002B22070300006045E460000000AC881C0C000080159183010000
              B022723000000056440E060000C08AC8C1000000581139180000002B22070300
              006045E460603EBFFEEBBB571F5DF6F4F2FDD7DFDE7E1F70F4379FFFFAEF8FFB
              55FEF1F0ED0D15570F004038723030B53F3FFCE3C5BB2F1E7B3244E2D2C1A302
              643EDA562AD0DA52963F190000BB220703D3CB24BC4270CB674275DACBEE2A24
              37E68E263C583A44A736CE1D88EBC3007020E4606001897C270A6CE9B4A74CB0
              D924EC9F19731783C5474A94B558DBE401C9C2007010E46060018978D7120D35
              9B6F1D2F09E762B0E238B7BBA86D9CAC1D5118008E801C0CACE036DE350759C5
              0EB26B765D83707E3187A2A8B73BA997317960960B03C0F8C8C1C00ADA72F096
              8EB2E25D141ECBE077E1D4E720961C4C120680832207032B68CEC1C9A8274D7A
              A7A3BF7CF366FBF851B1FCD652C3376FDE7CFC68AEAB2D07B35018000E891C0C
              ACA03D0727A39EF2310CDF3EFEF31F2F4C77EC553CC5D7E4213AE4608230001C
              1039185881470EB65F113ECBC1BFFDED3FB64757C8AA973E428F1C4C100680E3
              2107032BF0C8C1F635C2E739F8EDA67C3459DD7376BD2F4D535DED399835C200
              7038E460600503E5E0EFCD4F33CE385F1391DE3D39180090420E065630540E6E
              58695C2AD5A928E46000800C391858C138EB83EF3FAD7D6D9BA4504F15220703
              0064C8C1C00A1C7270C383D36E72B0FD4DCFB9421577CD7D720080147230B082
              419E1F7CF679974BC2376B229AEB6ACEC15C0E0680E32107032B18E37D7217B1
              30151C75854AAC8968AEAB3507138301E080C8C1C00ADA727032E4297690CCC1
              CD6B23526B229AEB6ACCC1AD2D0400D803391858813D1B26139E32E2657270DB
              DA88E49A88B6BA6EC61CCCC5600038267230B00243364CDEF775C7BE8CF7664B
              FBDA88DCC5605B5D4B25AA5637D950A4600038007230B0826CA8D531A6BB6C0E
              363F4AF8E245CAD55DC6E5E0F4D572564400C03190838115F8E460EB45CE420E
              B6AD8DC8AE8948D7B52907E7B6CF4460AE0403C07190838115A8B36131386BA3
              5E29071B6E972BAC8930D535B96F0B2230001C0B39185881391BE673A122F495
              73B0766D44694D44535DD3F57D384A311F937F01E098C8C1C00A029E9BA6D849
              2507EB6E972BAE8968AEABFD7D720080C32107032B687F9F5C66A1842825D672
              B0626D44654D44735DC9C100B0107230B082F61C9CBD2A2CC889F51C2C5D1B51
              BD18DC5A577230002C841C0CACC02307E7AE09CB1FEF50FAA4686D8424069383
              010042E46060053E3938734958FCA689F207AB9784056B229AEB4A0E06808590
              83811538E560E31561590EAE3D4A587431B8B5AEE46000580839185881570EB6
              BD445898838B6B239EFF5BADE4E46000800C391858416C0E965EA155BC28EED9
              D5F37B2DFB2007030052C8C1C00A8E713D78CB5E12FEE917D99A88E6BA928301
              6021E46060055E39387DA39C74A5822452A68EF0F2E5CB2F5F6417835BEB4A0E
              0680859083811584DE27E7F4BC88E23164076AAF2B39180016420E0656E09483
              9311B5BE275D0ECEBEC659F91667535DC9C100B0107230B002971C6CBB18BCA9
              7370FA480D1B37E560EB4A6A00C0F0C8C1C00A1C72B03905CB9FFC5B3A983806
              B725597230002C841C0C2CA039DD59DFA87C7574F941AF4B6CDF525ECE4C4559
              180100B32207030B48A43B71B0CCADD695C7C3E7A36B22E5799915DB258BDB56
              592E0803C0A4C8C1C0F48C0F60C86FA6CAB397D1D2B44441B151A6D0C202B76D
              0D003818723030B5DCD55CB3F6F514EA95BED24356EA5A396E21F6EBEB0D0038
              027230309F4AA4D3538540CDD105D9F4F7E2478C39FFB142C686221303C01CC8
              C1000000581139180000002B22070300006045E460000000AC881C0C00008015
              9183010000B022723000000056440E060000C08AC8C100000058113918000000
              2B22070300006045E460000000AC881C0C000080159183010000B02272300000
              0056440E060000C08AC8C1000000581139180000002B22070300006045E46000
              0000AC881C0C000080159183010000B0A2FF03621589228D69B07D0000000049
              454E44AE426082}
            Stretch = True
            ExplicitLeft = 2
            ExplicitTop = 75
            ExplicitWidth = 954
            ExplicitHeight = 356
          end
          object pnlPicHeader: TDNMPanel
            Left = 1
            Top = 1
            Width = 986
            Height = 50
            HelpContext = 1363234
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object btnAddPic: TDNMSpeedButton
              Left = 13
              Top = 11
              Width = 100
              Height = 27
              HelpContext = 1363235
              Caption = 'Add Picture'
              DisableTransparent = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
                BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
                BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
                BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
                BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
                EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
                EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
                EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
                EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -12
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              NumGlyphs = 2
              ParentFont = False
              TabOrder = 1
              OnClick = btnAddPicClick
            end
            object btnStretch: TDNMSpeedButton
              Left = 137
              Top = 11
              Width = 100
              Height = 27
              HelpContext = 1363236
              AllowAllUp = True
              Caption = 'Stretch to Fit'
              Color = clBtnFace
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -12
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentColor = False
              ParentFont = False
              TabOrder = 0
              TabStop = False
              OnClick = btnStretchClick
            end
          end
          object navPartPic: TwwDBNavigator
            Left = 1
            Top = 51
            Width = 986
            Height = 25
            HelpContext = 1363237
            DataSource = dsPicture
            Layout = nlVertical
            RepeatInterval.InitialDelay = 500
            RepeatInterval.Interval = 100
            Align = alTop
            Transparent = True
            object navPartPicFirst: TwwNavButton
              Left = 0
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move to first record'
              HelpContext = 1363238
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'navPartPicFirst'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 0
              Style = nbsFirst
            end
            object navPartPicPriorPage: TwwNavButton
              Left = 25
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move backward 10 records'
              HelpContext = 1363239
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'navPartPicPriorPage'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 1
              Style = nbsPriorPage
            end
            object navPartPicPrior: TwwNavButton
              Left = 50
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move to prior record'
              HelpContext = 1363240
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'navPartPicPrior'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 2
              Style = nbsPrior
            end
            object navPartPicNext: TwwNavButton
              Left = 75
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move to next record'
              HelpContext = 1363241
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'navPartPicNext'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 3
              Style = nbsNext
            end
            object navPartPicLast: TwwNavButton
              Left = 100
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move to last record'
              HelpContext = 1363242
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'navPartPicLast'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 4
              Style = nbsLast
            end
            object navPartPicDelete: TwwNavButton
              Left = 125
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Delete current record'
              HelpContext = 1363243
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'navPartPicDelete'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 5
              Style = nbsDelete
            end
          end
          object pnlPicturetype: TDNMPanel
            Left = 170
            Top = 46
            Width = 167
            Height = 25
            HelpContext = 1363244
            Anchors = [akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object DBText1: TDBText
              Left = 89
              Top = 4
              Width = 65
              Height = 17
              HelpContext = 1363245
              DataField = 'Imagetype'
              DataSource = dsPicture
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label12: TLabel
              Left = 13
              Top = 5
              Width = 70
              Height = 15
              HelpContext = 1363246
              Caption = 'Picture Type'
            end
          end
        end
      end
      object tabAttachments: TTabSheet
        HelpContext = 1363247
        Caption = 'Attachments'
        ImageIndex = 9
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlAttachments: TPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363248
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 0
        end
      end
      object tabHistory: TTabSheet
        HelpContext = 1363249
        Caption = 'History'
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlHistory: TDNMPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363250
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object grpHistory: TRadioGroup
            Left = 0
            Top = 0
            Width = 988
            Height = 49
            HelpContext = 1363251
            Align = alTop
            Color = clBtnFace
            Columns = 5
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ItemIndex = 0
            Items.Strings = (
              'Service Log'
              'Repairs')
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            OnClick = grpHistoryClick
          end
        end
      end
      object tabHire: TTabSheet
        HelpContext = 1363252
        Caption = 'Hire'
        ImageIndex = 10
        object pnlHire: TDNMPanel
          Left = 0
          Top = 0
          Width = 988
          Height = 356
          HelpContext = 1363253
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object pnlHireTop: TDNMPanel
            Left = 0
            Top = 0
            Width = 988
            Height = 73
            HelpContext = 1363254
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              988
              73)
            object Label70: TLabel
              Left = 275
              Top = 14
              Width = 104
              Height = 15
              HelpContext = 1363255
              Alignment = taRightJustify
              Caption = 'Hire Income Accnt'
              Transparent = True
            end
            object Label41: TLabel
              Left = 272
              Top = 41
              Width = 107
              Height = 15
              HelpContext = 1363256
              Alignment = taRightJustify
              Caption = 'Hire Product Name'
              Transparent = True
            end
            object cboHireIncomeAccountName: TERPDbLookupCombo
              Left = 392
              Top = 10
              Width = 218
              Height = 23
              HelpContext = 1363257
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Accountname'#9'30'#9'Account Name'#9'F'
                'AccountType'#9'10'#9'Type'#9'F')
              DataField = 'HireIncomeAccountName'
              DataSource = dsAssetHire
              LookupTable = qryIncomeAccountLookup
              LookupField = 'Accountname'
              Options = [loTitles]
              ParentFont = False
              TabOrder = 0
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = True
              LookupFormClassName = 'TChartOfAccountsListLookupGUI'
              EditFormClassName = 'TfrmChartOfAccounts'
              LookupFormKeyStringFieldName = 'AccountName'
              LookupComboType = ctAccount
              AllowFullListSearchMode = False
              DisableNotInList = False
              AllowMultipleSelectFromList = False
              OpenListinF6WhenNotinList = False
              DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
              LookupIDField = 'AccountID'
            end
            object chkHireEnabled: TwwCheckBox
              Left = 24
              Top = 14
              Width = 129
              Height = 17
              HelpContext = 1363258
              DisableThemes = False
              AlwaysTransparent = False
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              DisplayValueChecked = 'True'
              DisplayValueUnchecked = 'False'
              NullAndBlankState = cbUnchecked
              Caption = 'Hire Enabled'
              DataField = 'Active'
              DataSource = dsAssetHire
              TabOrder = 1
              OnClick = chkHireEnabledClick
            end
            object cboHireProduct: TERPDbLookupCombo
              Left = 392
              Top = 39
              Width = 218
              Height = 23
              HelpContext = 1363259
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'PARTNAME'#9'60'#9'Product Name'#9'F')
              DataField = 'HireProductName'
              DataSource = dsAssetHire
              LookupTable = qryProductLookup
              LookupField = 'Partname'
              ParentFont = False
              TabOrder = 2
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              LookupFormClassName = 'TProductListExpressGUI'
              EditFormClassName = 'TfrmParts'
              LookupFormKeyStringFieldName = 'ProductName'
              LookupComboType = ctProduct
              AllowFullListSearchMode = False
              DisableNotInList = False
              AllowMultipleSelectFromList = False
              OpenListinF6WhenNotinList = False
              DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
              LookupIDField = 'PartsID'
              LookupFieldAlt = 'ProductPrintName'
            end
            object btnCopyHire: TDNMSpeedButton
              Left = 24
              Top = 39
              Width = 87
              Height = 27
              Hint = '"Add A Class"'
              HelpContext = 1363275
              Anchors = [akBottom]
              Caption = 'Copy'
              DisableTransparent = False
              Font.Charset = ANSI_CHARSET
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
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = btnCopyHireClick
            end
          end
          object pnlHirePricing: TDNMPanel
            Left = 0
            Top = 73
            Width = 282
            Height = 283
            HelpContext = 1363260
            Align = alLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object Label69: TLabel
              AlignWithMargins = True
              Left = 4
              Top = 16
              Width = 274
              Height = 15
              HelpContext = 1363261
              Margins.Top = 15
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Minimum Hire Period'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              ExplicitWidth = 118
            end
            object grdRates: TwwDBGrid
              AlignWithMargins = True
              Left = 4
              Top = 39
              Width = 274
              Height = 240
              HelpContext = 1363262
              ControlType.Strings = (
                'Active;CheckBox;T;F'
                'DurationName;CustomEdit;cboDuration;F')
              Selected.Strings = (
                'DurationName'#9'15'#9'Duration'#9'F'#9
                'Rate'#9'10'#9'Rate'#9'F'#9
                'Active'#9'1'#9'Active'#9#9)
              MemoAttributes = [mSizeable, mWordWrap, mGridShow]
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
              Align = alClient
              DataSource = dsHirePricingLine
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = [dgAllowInsert]
              Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgRowResize]
              ParentFont = False
              TabOrder = 3
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = True
              FooterColor = clWhite
              FooterCellColor = clWhite
              PaintOptions.BackgroundOptions = [coBlendFixedRow]
              object btnDelete: TwwIButton
                Left = -1
                Top = 0
                Width = 22
                Height = 22
                HelpContext = 1363263
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
                Layout = blGlyphBottom
                OnClick = btnDeleteClick
              end
            end
            object edtMinHirePeriod: TwwDBEdit
              Left = 128
              Top = 12
              Width = 53
              Height = 23
              HelpContext = 1363264
              DataField = 'MinHirePeriodQty'
              DataSource = dsAssetHire
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
            end
            object cboMinHirePeriodType: TwwDBComboBox
              Left = 187
              Top = 12
              Width = 93
              Height = 23
              HelpContext = 1363265
              ShowButton = True
              Style = csDropDown
              MapList = True
              AllowClearKey = False
              DataField = 'MinHirePeriodType'
              DataSource = dsAssetHire
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ItemHeight = 0
              Items.Strings = (
                'Hours'#9'H'
                'Days'#9'D'
                'Weeks'#9'W'
                'Months'#9'M'
                'Years'#9'Y')
              ParentFont = False
              Sorted = False
              TabOrder = 1
              UnboundDataType = wwDefault
            end
            object cboDuration: TwwDBLookupCombo
              Left = 87
              Top = 99
              Width = 88
              Height = 23
              HelpContext = 1363266
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Description'#9'20'#9'Description'#9'F'
                'Qty'#9'10'#9'Qty'#9'F'
                'DurationType'#9'1'#9'Type'#9'F')
              DataField = 'DurationName'
              DataSource = dsHirePricingLine
              LookupTable = qryDuration
              LookupField = 'Description'
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
            end
          end
          object pnlHireHistory: TDNMPanel
            Left = 282
            Top = 73
            Width = 706
            Height = 283
            HelpContext = 1363267
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Top = 24
  end
  inherited tmrdelay: TTimer
    Top = 24
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 24
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 229
    Top = 24
  end
  inherited MyConnection: TERPConnection
    
    Server = 'localhost'
  end
  inherited DataState: TDataState
    Top = 32
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 123
    Top = 16
  end
  inherited imgsort: TImageList
    Left = 299
    Top = 32
    Bitmap = {
      494C010102004801D40110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 334
    Top = 24
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 24
  end
  object qryAsset: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblfixedassets'
      'Where AssetID = :ID;')
    AfterOpen = qryAssetAfterOpen
    AfterPost = qryAssetAfterPost
    Left = 14
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryAssetAssetID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'AssetID'
      Origin = 'tblfixedassets.AssetID'
      ReadOnly = True
    end
    object qryAssetParentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ParentID'
      Origin = 'tblfixedassets.ParentID'
    end
    object qryAssetAssetCode: TWideStringField
      DisplayWidth = 50
      FieldName = 'AssetCode'
      Origin = 'tblfixedassets.AssetCode'
      Size = 50
    end
    object qryAssetAssetName: TWideStringField
      DisplayWidth = 40
      FieldName = 'AssetName'
      Origin = 'tblfixedassets.AssetName'
      Size = 255
    end
    object qryAssetPurchDate: TDateField
      DisplayWidth = 10
      FieldName = 'PurchDate'
      Origin = 'tblfixedassets.PurchDate'
    end
    object qryAssetPurchCost: TFloatField
      DisplayWidth = 16
      FieldName = 'PurchCost'
      Origin = 'tblfixedassets.PurchCost'
      currency = True
    end
    object qryAssetAssetType: TWideStringField
      DisplayWidth = 50
      FieldName = 'AssetType'
      Origin = 'tblfixedassets.AssetType'
      Size = 50
    end
    object qryAssetLocationDescription: TWideStringField
      DisplayWidth = 100
      FieldName = 'LocationDescription'
      Origin = 'tblfixedassets.LocationDescription'
      Size = 100
    end
    object qryAssetBrandName: TWideStringField
      DisplayWidth = 50
      FieldName = 'BrandName'
      Origin = 'tblfixedassets.BrandName'
      Size = 50
    end
    object qryAssetManufacture: TWideStringField
      DisplayWidth = 50
      FieldName = 'Manufacture'
      Origin = 'tblfixedassets.Manufacture'
      Size = 50
    end
    object qryAssetModel: TWideStringField
      DisplayWidth = 30
      FieldName = 'Model'
      Origin = 'tblfixedassets.Model'
      Size = 30
    end
    object qryAssetSerial: TWideStringField
      DisplayWidth = 30
      FieldName = 'Serial'
      Origin = 'tblfixedassets.Serial'
      Size = 30
    end
    object qryAssetNotes: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Notes'
      Origin = 'tblfixedassets.Notes'
      BlobType = ftWideMemo
    end
    object qryAssetQty: TIntegerField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblfixedassets.Qty'
    end
    object qryAssetStatus: TWideStringField
      DisplayWidth = 100
      FieldName = 'Status'
      Origin = 'tblfixedassets.Status'
      Size = 100
    end
    object qryAssetEstimatedValue: TFloatField
      DisplayWidth = 10
      FieldName = 'EstimatedValue'
      Origin = 'tblfixedassets.EstimatedValue'
      currency = True
    end
    object qryAssetReplacementCost: TFloatField
      DisplayWidth = 10
      FieldName = 'ReplacementCost'
      Origin = 'tblfixedassets.ReplacementCost'
      currency = True
    end
    object qryAssetWarrantyType: TWideStringField
      DisplayWidth = 100
      FieldName = 'WarrantyType'
      Origin = 'tblfixedassets.WarrantyType'
      Size = 100
    end
    object qryAssetWarrantyExpiresDate: TDateField
      DisplayWidth = 10
      FieldName = 'WarrantyExpiresDate'
      Origin = 'tblfixedassets.WarrantyExpiresDate'
    end
    object qryAssetInsuredBy: TWideStringField
      DisplayWidth = 100
      FieldName = 'InsuredBy'
      Origin = 'tblfixedassets.InsuredBy'
      Size = 100
    end
    object qryAssetInsurancePolicy: TWideStringField
      DisplayWidth = 100
      FieldName = 'InsurancePolicy'
      Origin = 'tblfixedassets.InsurancePolicy'
      Size = 100
    end
    object qryAssetInsuredUntil: TDateField
      DisplayWidth = 10
      FieldName = 'InsuredUntil'
      Origin = 'tblfixedassets.InsuredUntil'
    end
    object qryAssetBusinessUsePercent: TFloatField
      DisplayWidth = 10
      FieldName = 'BusinessUsePercent'
      Origin = 'tblfixedassets.BusinessUsePercent'
      DisplayFormat = '#.00%'
      EditFormat = '#.00'
    end
    object qryAssetCUSTFLD1: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD1'
      Origin = 'tblfixedassets.CUSTFLD1'
      Size = 50
    end
    object qryAssetCUSTFLD2: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD2'
      Origin = 'tblfixedassets.CUSTFLD2'
      Size = 50
    end
    object qryAssetCUSTFLD3: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD3'
      Origin = 'tblfixedassets.CUSTFLD3'
      Size = 50
    end
    object qryAssetCUSTFLD4: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD4'
      Origin = 'tblfixedassets.CUSTFLD4'
      Size = 50
    end
    object qryAssetCUSTFLD5: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD5'
      Origin = 'tblfixedassets.CUSTFLD5'
      Size = 50
    end
    object qryAssetCUSTFLD6: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD6'
      Origin = 'tblfixedassets.CUSTFLD6'
      Size = 50
    end
    object qryAssetCUSTFLD7: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD7'
      Origin = 'tblfixedassets.CUSTFLD7'
      Size = 50
    end
    object qryAssetCUSTFLD8: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD8'
      Origin = 'tblfixedassets.CUSTFLD8'
      Size = 50
    end
    object qryAssetCUSTFLD9: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD9'
      Origin = 'tblfixedassets.CUSTFLD9'
      Size = 50
    end
    object qryAssetCUSTFLD10: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD10'
      Origin = 'tblfixedassets.CUSTFLD10'
      Size = 50
    end
    object qryAssetCUSTFLD11: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD11'
      Origin = 'tblfixedassets.CUSTFLD11'
      Size = 50
    end
    object qryAssetCUSTFLD12: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD12'
      Origin = 'tblfixedassets.CUSTFLD12'
      Size = 50
    end
    object qryAssetCUSTFLD13: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD13'
      Origin = 'tblfixedassets.CUSTFLD13'
      Size = 50
    end
    object qryAssetCUSTFLD14: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD14'
      Origin = 'tblfixedassets.CUSTFLD14'
      Size = 50
    end
    object qryAssetCUSTFLD15: TWideStringField
      DisplayWidth = 50
      FieldName = 'CUSTFLD15'
      Origin = 'tblfixedassets.CUSTFLD15'
      Size = 50
    end
    object qryAssetDepreciationOption: TSmallintField
      DisplayWidth = 10
      FieldName = 'DepreciationOption'
      Origin = 'tblfixedassets.DepreciationOption'
    end
    object qryAssetLife: TFloatField
      DisplayWidth = 10
      FieldName = 'Life'
      Origin = 'tblfixedassets.Life'
    end
    object qryAssetSalvageType: TSmallintField
      DisplayWidth = 10
      FieldName = 'SalvageType'
      Origin = 'tblfixedassets.SalvageType'
    end
    object qryAssetSalvage: TFloatField
      DisplayWidth = 10
      FieldName = 'Salvage'
      Origin = 'tblfixedassets.Salvage'
      DisplayFormat = '#.00%'
      currency = True
    end
    object qryAssetSalvageFactor: TFloatField
      DisplayWidth = 10
      FieldName = 'SalvageFactor'
      Origin = 'tblfixedassets.SalvageFactor'
      DisplayFormat = '#.00%'
      EditFormat = '#.00'
    end
    object qryAssetDisposal: TWideStringField
      DisplayWidth = 1
      FieldName = 'Disposal'
      Origin = 'tblfixedassets.Disposal'
      FixedChar = True
      Size = 1
    end
    object qryAssetDisposalDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DisposalDate'
      Origin = 'tblfixedassets.DisposalDate'
    end
    object qryAssetDisposalBookValue: TFloatField
      DisplayWidth = 16
      FieldName = 'DisposalBookValue'
      Origin = 'tblfixedassets.DisposalBookValue'
      currency = True
    end
    object qryAssetDisposalAccumDeprec: TFloatField
      DisplayWidth = 16
      FieldName = 'DisposalAccumDeprec'
      Origin = 'tblfixedassets.DisposalAccumDeprec'
      currency = True
    end
    object qryAssetSalesPrice: TFloatField
      DisplayWidth = 16
      FieldName = 'SalesPrice'
      Origin = 'tblfixedassets.SalesPrice'
      currency = True
    end
    object qryAssetPriorAccumDeprec: TWideStringField
      DisplayWidth = 1
      FieldName = 'PriorAccumDeprec'
      Origin = 'tblfixedassets.PriorAccumDeprec'
      FixedChar = True
      Size = 1
    end
    object qryAssetPriorAccumDeprecDate: TWideStringField
      DisplayWidth = 4
      FieldName = 'PriorAccumDeprecDate'
      Origin = 'tblfixedassets.PriorAccumDeprecDate'
      EditMask = '####;1;#'
      Size = 4
    end
    object qryAssetPriorAccumDeprecAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'PriorAccumDeprecAmount'
      Origin = 'tblfixedassets.PriorAccumDeprecAmount'
      currency = True
    end
    object qryAssetColour: TWideStringField
      DisplayWidth = 100
      FieldName = 'Colour'
      Origin = 'tblfixedassets.Colour'
      Size = 100
    end
    object qryAssetSize: TWideStringField
      DisplayWidth = 100
      FieldName = 'Size'
      Origin = 'tblfixedassets.Size'
      Size = 100
    end
    object qryAssetShape: TWideStringField
      DisplayWidth = 100
      FieldName = 'Shape'
      Origin = 'tblfixedassets.Shape'
      Size = 100
    end
    object qryAssetFixedAssetDepreciationAccountName: TWideStringField
      DisplayWidth = 40
      FieldName = 'FixedAssetDepreciationAccountName'
      Origin = 'tblfixedassets.FixedAssetDepreciationAccountName'
      Size = 255
    end
    object qryAssetFixedAssetDepreciationAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FixedAssetDepreciationAccountID'
      Origin = 'tblfixedassets.FixedAssetDepreciationAccountID'
    end
    object qryAssetClearingAccountName: TWideStringField
      DisplayWidth = 40
      FieldName = 'ClearingAccountName'
      Origin = 'tblfixedassets.ClearingAccountName'
      Size = 255
    end
    object qryAssetClearingAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClearingAccountID'
      Origin = 'tblfixedassets.ClearingAccountID'
    end
    object qryAssetGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tblfixedassets.GlobalRef'
      Size = 255
    end
    object qryAssetActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblfixedassets.Active'
      FixedChar = True
      Size = 1
    end
    object qryAssetEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblfixedassets.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryAssetPARTNAME: TWideStringField
      DisplayWidth = 40
      FieldName = 'PARTNAME'
      Origin = 'tblfixedassets.PARTNAME'
      Size = 255
    end
    object qryAssetPARTSID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PARTSID'
      Origin = 'tblfixedassets.PARTSID'
    end
    object qryAssetSupplierName: TWideStringField
      DisplayWidth = 40
      FieldName = 'SupplierName'
      Origin = 'tblfixedassets.SupplierName'
      Size = 255
    end
    object qryAssetSupplierID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SupplierID'
      Origin = 'tblfixedassets.SupplierID'
    end
    object qryAssetBARCODE: TWideStringField
      DisplayWidth = 35
      FieldName = 'BARCODE'
      Origin = 'tblfixedassets.BARCODE'
      Size = 35
    end
    object qryAssetDepreciationOption2: TSmallintField
      DisplayWidth = 10
      FieldName = 'DepreciationOption2'
      Origin = 'tblfixedassets.DepreciationOption2'
    end
    object qryAssetLife2: TFloatField
      DisplayWidth = 10
      FieldName = 'Life2'
      Origin = 'tblfixedassets.Life2'
    end
    object qryAssetSalvageType2: TSmallintField
      DisplayWidth = 10
      FieldName = 'SalvageType2'
      Origin = 'tblfixedassets.SalvageType2'
    end
    object qryAssetSalvage2: TFloatField
      DisplayWidth = 10
      FieldName = 'Salvage2'
      Origin = 'tblfixedassets.Salvage2'
    end
    object qryAssetSalvageFactor2: TFloatField
      DisplayWidth = 10
      FieldName = 'SalvageFactor2'
      Origin = 'tblfixedassets.SalvageFactor2'
      DisplayFormat = '#.00%'
      EditFormat = '#.00%'
    end
    object qryAssetPriorAccumDeprec2: TWideStringField
      DisplayWidth = 1
      FieldName = 'PriorAccumDeprec2'
      Origin = 'tblfixedassets.PriorAccumDeprec2'
      FixedChar = True
      Size = 1
    end
    object qryAssetPriorAccumDeprecDate2: TWideStringField
      DisplayWidth = 4
      FieldName = 'PriorAccumDeprecDate2'
      Origin = 'tblfixedassets.PriorAccumDeprecDate2'
      EditMask = '####;1;#'
      Size = 4
    end
    object qryAssetPriorAccumDeprecAmount2: TFloatField
      DisplayWidth = 10
      FieldName = 'PriorAccumDeprecAmount2'
      Origin = 'tblfixedassets.PriorAccumDeprecAmount2'
      currency = True
    end
    object qryAssetDisposalDate2: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DisposalDate2'
      Origin = 'tblfixedassets.DisposalDate2'
    end
    object qryAssetDisposalBookValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'DisposalBookValue2'
      Origin = 'tblfixedassets.DisposalBookValue2'
      currency = True
    end
    object qryAssetDisposalAccumDeprec2: TFloatField
      DisplayWidth = 10
      FieldName = 'DisposalAccumDeprec2'
      Origin = 'tblfixedassets.DisposalAccumDeprec2'
      currency = True
    end
    object qryAssetSalesPrice2: TFloatField
      DisplayWidth = 10
      FieldName = 'SalesPrice2'
      Origin = 'tblfixedassets.SalesPrice2'
      currency = True
    end
    object qryAssetClearingAccountName2: TWideStringField
      DisplayWidth = 40
      FieldName = 'ClearingAccountName2'
      Origin = 'tblfixedassets.ClearingAccountName2'
      Size = 255
    end
    object qryAssetClearingAccountID2: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClearingAccountID2'
      Origin = 'tblfixedassets.ClearingAccountID2'
    end
    object qryAssetFixedAssetDepreciationAccountName2: TWideStringField
      DisplayWidth = 40
      FieldName = 'FixedAssetDepreciationAccountName2'
      Origin = 'tblfixedassets.FixedAssetDepreciationAccountName2'
      Size = 255
    end
    object qryAssetFixedAssetDepreciationAccountID2: TIntegerField
      DisplayWidth = 10
      FieldName = 'FixedAssetDepreciationAccountID2'
      Origin = 'tblfixedassets.FixedAssetDepreciationAccountID2'
    end
    object qryAssetBusinessUsePercent2: TFloatField
      DisplayWidth = 10
      FieldName = 'BusinessUsePercent2'
      Origin = 'tblfixedassets.BusinessUsePercent2'
      DisplayFormat = '#.00%'
      EditFormat = '#.00%'
    end
    object qryAssetFixedAssetCostAccountName: TWideStringField
      DisplayWidth = 40
      FieldName = 'FixedAssetCostAccountName'
      Origin = 'tblfixedassets.FixedAssetCostAccountName'
      Size = 255
    end
    object qryAssetFixedAssetCostAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FixedAssetCostAccountID'
      Origin = 'tblfixedassets.FixedAssetCostAccountID'
    end
    object qryAssetFixedAssetCostAccountName2: TWideStringField
      DisplayWidth = 40
      FieldName = 'FixedAssetCostAccountName2'
      Origin = 'tblfixedassets.FixedAssetCostAccountName2'
      Size = 255
    end
    object qryAssetFixedAssetCostAccountID2: TIntegerField
      DisplayWidth = 10
      FieldName = 'FixedAssetCostAccountID2'
      Origin = 'tblfixedassets.FixedAssetCostAccountID2'
    end
    object qryAssetFixedAssetDepreciationAssetAccountName: TWideStringField
      DisplayWidth = 40
      FieldName = 'FixedAssetDepreciationAssetAccountName'
      Origin = 'tblfixedassets.FixedAssetDepreciationAssetAccountName'
      Size = 255
    end
    object qryAssetFixedAssetDepreciationAssetAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FixedAssetDepreciationAssetAccountID'
      Origin = 'tblfixedassets.FixedAssetDepreciationAssetAccountID'
    end
    object qryAssetFixedAssetDepreciationAssetAccountName2: TWideStringField
      DisplayWidth = 40
      FieldName = 'FixedAssetDepreciationAssetAccountName2'
      Origin = 'tblfixedassets.FixedAssetDepreciationAssetAccountName2'
      Size = 255
    end
    object qryAssetFixedAssetDepreciationAssetAccountID2: TIntegerField
      DisplayWidth = 10
      FieldName = 'FixedAssetDepreciationAssetAccountID2'
      Origin = 'tblfixedassets.FixedAssetDepreciationAssetAccountID2'
    end
    object qryAssetCUSTDATE1: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CUSTDATE1'
      Origin = 'tblfixedassets.CUSTDATE1'
    end
    object qryAssetCUSTDATE2: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CUSTDATE2'
      Origin = 'tblfixedassets.CUSTDATE2'
    end
    object qryAssetCUSTDATE3: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CUSTDATE3'
      Origin = 'tblfixedassets.CUSTDATE3'
    end
    object qryAssetTotalChildAsset: TFloatField
      FieldName = 'TotalChildAsset'
      Origin = 'tblfixedassets.TotalChildAsset'
      currency = True
    end
    object qryAssetAssetCondition: TWideStringField
      FieldName = 'AssetCondition'
      Origin = 'tblfixedassets.AssetCondition'
      Size = 100
    end
    object qryAssetClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblfixedassets.ClassID'
    end
    object qryAssetLastTestDate: TDateField
      FieldName = 'LastTestDate'
      Origin = 'tblfixedassets.LastTestDate'
    end
    object qryAssetNextTestDate: TDateField
      FieldName = 'NextTestDate'
      Origin = 'tblfixedassets.NextTestDate'
    end
    object qryAssetmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblfixedassets.msTimeStamp'
    end
    object qryAssetmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblfixedassets.msUpdateSiteCode'
      Size = 3
    end
    object qryAssetDepreciationStartDate: TDateField
      FieldName = 'DepreciationStartDate'
      Origin = 'tblfixedassets.DepreciationStartDate'
    end
    object qryAssetDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
  end
  object DSAsset: TDataSource
    DataSet = qryAsset
    Left = 310
    Top = 65534
  end
  object qryfixedassettypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblfixedassettypes;')
    Left = 53
    Top = 2
    object qryfixedassettypesAssetTypeID: TAutoIncField
      FieldName = 'AssetTypeID'
      ReadOnly = True
    end
    object qryfixedassettypesAssetTypeCode: TWideStringField
      FieldName = 'AssetTypeCode'
      Size = 50
    end
    object qryfixedassettypesAssetTypeName: TWideStringField
      FieldName = 'AssetTypeName'
      Size = 255
    end
    object qryfixedassettypesNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object qryfixedassettypesDepreciationOption: TSmallintField
      FieldName = 'DepreciationOption'
    end
    object qryfixedassettypesLife: TFloatField
      FieldName = 'Life'
    end
    object qryfixedassettypesSalvageType: TSmallintField
      FieldName = 'SalvageType'
    end
    object qryfixedassettypesSalvage: TFloatField
      FieldName = 'Salvage'
    end
    object qryfixedassettypesSalvageFactor: TFloatField
      FieldName = 'SalvageFactor'
    end
    object qryfixedassettypesActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object ERPQuery1: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblfixedassettypes;')
    Left = 93
    Top = 2
    object AutoIncField1: TAutoIncField
      FieldName = 'AssetTypeID'
      ReadOnly = True
    end
    object WideStringField1: TWideStringField
      FieldName = 'AssetTypeCode'
      Size = 50
    end
    object WideStringField2: TWideStringField
      FieldName = 'AssetTypeName'
      Size = 255
    end
    object WideMemoField1: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object SmallintField1: TSmallintField
      FieldName = 'DepreciationOption'
    end
    object FloatField1: TFloatField
      FieldName = 'Life'
    end
    object SmallintField2: TSmallintField
      FieldName = 'SalvageType'
    end
    object FloatField2: TFloatField
      FieldName = 'Salvage'
    end
    object FloatField3: TFloatField
      FieldName = 'SalvageFactor'
    end
    object WideStringField3: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object cboAccountQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT AccountID, AccountName,AccDesc as AccountType, Descriptio' +
        'n, AccountNumber, Taxcode, BankNumber, Extra, '
      
        'Active, tblchartofaccounts.EditedFlag, Class, AllClasses, Openin' +
        'gBalance, Debits, Credits, ClosingBalance, AccountGroup  '
      'FROM tblchartofaccounts'
      'Inner Join tblacctypedesc On AccountType=AccType'
      'WHERE (AccountType <> '#39'AR'#39') And (AccountType <> '#39'AP'#39')'
      'And (AccountType <> '#39'INC'#39') And (AccountType <> '#39'EXINC'#39')'
      'And (AccountType <> '#39'NONPOSTING'#39') '
      '/* And (AccountType <> '#39'COGS'#39') */'
      'And Active='#39'T'#39' And IsHeader = '#39'F'#39
      'Order By AccountType,AccountName;')
    Left = 128
    Top = 2
  end
  object cboClassQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName,ClassPercent'
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Left = 177
    Top = 2
    object cboClassQryClassName: TWideStringField
      DisplayWidth = 15
      FieldName = 'ClassName'
      Size = 60
    end
    object cboClassQryClassID: TAutoIncField
      FieldName = 'ClassID'
      ReadOnly = True
      Visible = False
    end
    object cboClassQryClassPercent: TFloatField
      FieldName = 'ClassPercent'
      Visible = False
    end
  end
  object qryCustomFields: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *  FROM tblcustomfields;')
    Left = 210
    Top = 2
    object qryCustomFieldsCFLabel1: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel1'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust1: TWideStringField
      FieldName = 'CFCust1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl1: TWideStringField
      FieldName = 'CFEmpl1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp1: TWideStringField
      FieldName = 'CFSupp1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel2: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel2'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust2: TWideStringField
      FieldName = 'CFCust2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl2: TWideStringField
      FieldName = 'CFEmpl2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp2: TWideStringField
      FieldName = 'CFSupp2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel3: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel3'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust3: TWideStringField
      FieldName = 'CFCust3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl3: TWideStringField
      FieldName = 'CFEmpl3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp3: TWideStringField
      FieldName = 'CFSupp3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel4: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel4'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust4: TWideStringField
      FieldName = 'CFCust4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl4: TWideStringField
      FieldName = 'CFEmpl4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp4: TWideStringField
      FieldName = 'CFSupp4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel5: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel5'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust5: TWideStringField
      FieldName = 'CFCust5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl5: TWideStringField
      FieldName = 'CFEmpl5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp5: TWideStringField
      FieldName = 'CFSupp5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel6: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel6'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust6: TWideStringField
      FieldName = 'CFCust6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl6: TWideStringField
      FieldName = 'CFEmpl6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp6: TWideStringField
      FieldName = 'CFSupp6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel7: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel7'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust7: TWideStringField
      FieldName = 'CFCust7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl7: TWideStringField
      FieldName = 'CFEmpl7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp7: TWideStringField
      FieldName = 'CFSupp7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel8: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel8'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust8: TWideStringField
      FieldName = 'CFCust8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl8: TWideStringField
      FieldName = 'CFEmpl8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp8: TWideStringField
      FieldName = 'CFSupp8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel9: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel9'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust9: TWideStringField
      FieldName = 'CFCust9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl9: TWideStringField
      FieldName = 'CFEmpl9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp9: TWideStringField
      FieldName = 'CFSupp9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel10: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel10'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust10: TWideStringField
      FieldName = 'CFCust10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl10: TWideStringField
      FieldName = 'CFEmpl10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp10: TWideStringField
      FieldName = 'CFSupp10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel11: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel11'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust11: TWideStringField
      FieldName = 'CFCust11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl11: TWideStringField
      FieldName = 'CFEmpl11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp11: TWideStringField
      FieldName = 'CFSupp11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel12: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel12'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust12: TWideStringField
      FieldName = 'CFCust12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl12: TWideStringField
      FieldName = 'CFEmpl12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp12: TWideStringField
      FieldName = 'CFSupp12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel13: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel13'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust13: TWideStringField
      FieldName = 'CFCust13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl13: TWideStringField
      FieldName = 'CFEmpl13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp13: TWideStringField
      FieldName = 'CFSupp13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel14: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel14'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust14: TWideStringField
      FieldName = 'CFCust14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl14: TWideStringField
      FieldName = 'CFEmpl14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp14: TWideStringField
      FieldName = 'CFSupp14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel15: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel15'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust15: TWideStringField
      FieldName = 'CFCust15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl15: TWideStringField
      FieldName = 'CFEmpl15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp15: TWideStringField
      FieldName = 'CFSupp15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr1: TWideStringField
      FieldName = 'CFOthr1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr2: TWideStringField
      FieldName = 'CFOthr2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr3: TWideStringField
      FieldName = 'CFOthr3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr4: TWideStringField
      FieldName = 'CFOthr4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr5: TWideStringField
      FieldName = 'CFOthr5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr6: TWideStringField
      FieldName = 'CFOthr6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr7: TWideStringField
      FieldName = 'CFOthr7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr8: TWideStringField
      FieldName = 'CFOthr8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr9: TWideStringField
      FieldName = 'CFOthr9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr10: TWideStringField
      FieldName = 'CFOthr10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr11: TWideStringField
      FieldName = 'CFOthr11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr12: TWideStringField
      FieldName = 'CFOthr12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr13: TWideStringField
      FieldName = 'CFOthr13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr14: TWideStringField
      FieldName = 'CFOthr14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr15: TWideStringField
      FieldName = 'CFOthr15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel16: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel16'
      Size = 16
    end
    object qryCustomFieldsCFLabel17: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel17'
      Size = 16
    end
    object qryCustomFieldsCFLabel18: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel18'
      Size = 16
    end
    object qryCustomFieldsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryCustomFieldsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object qryCustomFieldsCFAssets1: TWideStringField
      FieldName = 'CFAssets1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets2: TWideStringField
      FieldName = 'CFAssets2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets3: TWideStringField
      FieldName = 'CFAssets3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets4: TWideStringField
      FieldName = 'CFAssets4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets5: TWideStringField
      FieldName = 'CFAssets5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets6: TWideStringField
      FieldName = 'CFAssets6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets7: TWideStringField
      FieldName = 'CFAssets7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets8: TWideStringField
      FieldName = 'CFAssets8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets9: TWideStringField
      FieldName = 'CFAssets9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets10: TWideStringField
      FieldName = 'CFAssets10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets11: TWideStringField
      FieldName = 'CFAssets11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets12: TWideStringField
      FieldName = 'CFAssets12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets13: TWideStringField
      FieldName = 'CFAssets13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets14: TWideStringField
      FieldName = 'CFAssets14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets15: TWideStringField
      FieldName = 'CFAssets15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets16: TWideStringField
      FieldName = 'CFAssets16'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets17: TWideStringField
      FieldName = 'CFAssets17'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFAssets18: TWideStringField
      FieldName = 'CFAssets18'
      FixedChar = True
      Size = 1
    end
  end
  object qryParts: TERPQuery
    SQL.Strings = (
      'Select PARTSID,PARTNAME '
      'From tblParts '
      'Where Active = '#39'T'#39' AND not IsNull(PARTNAME) AND PARTNAME<>""'
      'Order By PARTNAME;')
    Options.LongStrings = False
    Left = 243
    Top = 3
    object qryPartsPARTSID: TIntegerField
      FieldName = 'PARTSID'
    end
    object qryPartsPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Size = 60
    end
  end
  object cboClientLookup: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, '
      'Street, Street2, Suburb, State, Country, Postcode,'
      
        'BillStreet, BillStreet2, BillSuburb, BillState, BillPostcode,Bil' +
        'lCountry,'
      'TERMS, TermsID, ShippingMethod, ShippingID, ShipTime, RepID'
      'FROM tblclients'
      'WHERE Active = '#39'T'#39
      'And Supplier = '#39'T'#39' '
      'Order By Company;')
    Options.LongStrings = False
    Left = 275
    Top = 4
  end
  object qryPictures: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblAssetPicture where AssetId = :AssetId')
    AfterOpen = qryPicturesAfterOpen
    AfterPost = qryPicturesAfterPost
    AfterScroll = qryPicturesAfterScroll
    Left = 704
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AssetId'
      end>
    object qryPicturesAssetPictureId: TIntegerField
      FieldName = 'AssetPictureId'
    end
    object qryPicturesGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object qryPicturesAssetId: TIntegerField
      FieldName = 'AssetId'
    end
    object qryPicturesImage: TBlobField
      FieldName = 'Image'
    end
    object qryPicturesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryPicturesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryPicturesImagetype: TWideStringField
      FieldName = 'Imagetype'
      FixedChar = True
      Size = 4
    end
  end
  object dsPicture: TDataSource
    DataSet = qryPictures
    Left = 616
    Top = 32
  end
  object qryAssetClass: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName,ClassPercent'
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Left = 745
    Top = 2
    object StringField1: TWideStringField
      DisplayWidth = 15
      FieldName = 'ClassName'
      Size = 60
    end
    object AutoIncField2: TAutoIncField
      FieldName = 'ClassID'
      ReadOnly = True
      Visible = False
    end
    object FloatField4: TFloatField
      FieldName = 'ClassPercent'
      Visible = False
    end
  end
  object qryDepreciationCalcs1: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblfixedassetsdepreciationdetails'
      'Where AssetID =:ID;')
    AfterPost = qryDepreciationCalcs1AfterPost
    IndexFieldNames = 'Year;MonthNo'
    Left = 789
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryDepreciationCalcs1AssetDepreciationID: TAutoIncField
      FieldName = 'AssetDepreciationID'
      ReadOnly = True
    end
    object qryDepreciationCalcs1AssetID: TIntegerField
      FieldName = 'AssetID'
    end
    object qryDepreciationCalcs1Year: TWideStringField
      FieldName = 'Year'
      Size = 4
    end
    object qryDepreciationCalcs1Month: TWideStringField
      FieldName = 'Month'
      Size = 255
    end
    object qryDepreciationCalcs1MonthNo: TIntegerField
      FieldName = 'MonthNo'
    end
    object qryDepreciationCalcs1Depreciation: TFloatField
      FieldName = 'Depreciation'
      currency = True
    end
    object qryDepreciationCalcs1TotalDepreciation: TFloatField
      FieldName = 'TotalDepreciation'
      currency = True
    end
    object qryDepreciationCalcs1BookValue: TFloatField
      FieldName = 'BookValue'
      currency = True
    end
    object qryDepreciationCalcs1Date: TDateField
      FieldName = 'Date'
    end
  end
  object qryDepreciationCalcs2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblfixedassetsdepreciationdetails2'
      'Where AssetID =:ID;')
    AfterPost = qryDepreciationCalcs2AfterPost
    IndexFieldNames = 'Year;MonthNo'
    Left = 821
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryDepreciationCalcs2AssetDepreciationID: TAutoIncField
      FieldName = 'AssetDepreciationID'
      ReadOnly = True
    end
    object qryDepreciationCalcs2AssetID: TIntegerField
      FieldName = 'AssetID'
    end
    object qryDepreciationCalcs2Year: TWideStringField
      FieldName = 'Year'
      Size = 4
    end
    object qryDepreciationCalcs2Month: TWideStringField
      FieldName = 'Month'
      Size = 255
    end
    object qryDepreciationCalcs2MonthNo: TIntegerField
      FieldName = 'MonthNo'
    end
    object qryDepreciationCalcs2Depreciation: TFloatField
      FieldName = 'Depreciation'
      currency = True
    end
    object qryDepreciationCalcs2TotalDepreciation: TFloatField
      FieldName = 'TotalDepreciation'
      currency = True
    end
    object qryDepreciationCalcs2BookValue: TFloatField
      FieldName = 'BookValue'
      currency = True
    end
    object qryDepreciationCalcs2Date: TDateField
      FieldName = 'Date'
    end
  end
  object qryFAPercentages: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT FAP.*'
      'FROM tblFixedAssetPercentages FAP'
      'WHERE Active = "T" AND AssetID = :xAssetID')
    Left = 664
    ParamData = <
      item
        DataType = ftString
        Name = 'xAssetID'
        Value = ''
      end>
    object qryFAPercentagesClassName: TWideStringField
      DisplayLabel = 'Class'
      DisplayWidth = 13
      FieldName = 'ClassName'
      Origin = 'FAP.ClassName'
      Size = 60
    end
    object qryFAPercentagesCost: TFloatField
      DisplayLabel = 'Cost %'
      DisplayWidth = 9
      FieldName = 'Cost'
      Origin = 'FAP.Cost'
      DisplayFormat = '0.##%'
    end
    object qryFAPercentagesDepreciation: TFloatField
      DisplayLabel = 'Depreciation %'
      DisplayWidth = 13
      FieldName = 'Depreciation'
      Origin = 'FAP.Depreciation'
      DisplayFormat = '0.##%'
    end
    object qryFAPercentagesDescription: TWideStringField
      DisplayWidth = 10
      FieldName = 'Description'
      Origin = 'FAP.Description'
      Size = 255
    end
    object qryFAPercentagesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'FAP.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryFAPercentagesClassID: TIntegerField
      DisplayWidth = 15
      FieldName = 'ClassID'
      Origin = 'FAP.ClassID'
      Visible = False
    end
    object qryFAPercentagesAssetPercentagesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'AssetPercentagesID'
      Origin = 'FAP.AssetPercentagesID'
      Visible = False
    end
    object qryFAPercentagesAssetID: TIntegerField
      DisplayWidth = 15
      FieldName = 'AssetID'
      Origin = 'FAP.AssetID'
      Visible = False
    end
  end
  object dsFAPercentages: TDataSource
    DataSet = qryFAPercentages
    Left = 544
    Top = 24
  end
  object dsDepreciationCalcs2: TDataSource
    DataSet = qryDepreciationCalcs2
    Left = 824
    Top = 32
  end
  object dsDepreciationCalcs1: TDataSource
    DataSet = qryDepreciationCalcs1
    Left = 784
    Top = 32
  end
  object qryChildAssets: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblfixedassets'
      'WHERE ParentID =:ID'
      'ORDER BY AssetName;')
    Options.LongStrings = False
    Left = 867
    Top = 65532
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Value = ''
      end>
    object qryChildAssetsAssetName: TWideStringField
      DisplayLabel = 'Child Asset Name'
      DisplayWidth = 30
      FieldName = 'AssetName'
      Origin = 'tblfixedassets.AssetName'
      Size = 255
    end
    object qryChildAssetsPurchCost: TFloatField
      DisplayLabel = 'Purchase Price'
      DisplayWidth = 10
      FieldName = 'PurchCost'
      Origin = 'tblfixedassets.PurchCost'
      currency = True
    end
    object qryChildAssetsAssetCode: TWideStringField
      DisplayLabel = 'Asset Code'
      DisplayWidth = 20
      FieldName = 'AssetCode'
      Origin = 'tblfixedassets.AssetCode'
      Size = 50
    end
    object qryChildAssetsAssetType: TWideStringField
      DisplayLabel = 'Asset Type'
      DisplayWidth = 20
      FieldName = 'AssetType'
      Origin = 'tblfixedassets.AssetType'
      Size = 50
    end
    object qryChildAssetsParentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ParentID'
      Origin = 'tblfixedassets.ParentID'
      Visible = False
    end
  end
  object DSChildAssets: TDataSource
    DataSet = qryChildAssets
    Left = 867
    Top = 27
  end
  object dlgSerialSelect: TSelectionDialog
    Caption = 'Make Serial Selection'
    Message = 'Please make selection..'
    MessageFont.Charset = DEFAULT_CHARSET
    MessageFont.Color = clWindowText
    MessageFont.Height = -12
    MessageFont.Name = 'Arial'
    MessageFont.Style = []
    Buttons = [sbOK, sbCancel]
    MultiSelect = False
    Width = 370
    Height = 250
    Color = 14474424
    Left = 699
    Top = 20
  end
  object qryAssetHire: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblAssetHire'
      'Where AssetID = :ID;')
    Left = 447
    Top = 262
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryAssetHireAssetHireId: TIntegerField
      FieldName = 'AssetHireId'
    end
    object qryAssetHireGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object qryAssetHireAssetId: TIntegerField
      FieldName = 'AssetId'
    end
    object qryAssetHireMinHirePeriodQty: TIntegerField
      FieldName = 'MinHirePeriodQty'
    end
    object qryAssetHireMinHirePeriodType: TWideStringField
      FieldName = 'MinHirePeriodType'
      FixedChar = True
      Size = 1
    end
    object qryAssetHireHireIncomeAccountID: TIntegerField
      FieldName = 'HireIncomeAccountID'
    end
    object qryAssetHireHireIncomeAccountName: TWideStringField
      FieldName = 'HireIncomeAccountName'
      Size = 255
    end
    object qryAssetHireActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryAssetHiremstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object qryAssetHiremsUpdatesiteCode: TWideStringField
      FieldName = 'msUpdatesiteCode'
      Size = 3
    end
    object qryAssetHireHireProductName: TWideStringField
      FieldName = 'HireProductName'
      Size = 255
    end
  end
  object qryHirePricingLine: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblHirePricingLines'
      'Where AssetHireID = :ID;')
    IndexFieldNames = 'Rate'
    Left = 511
    Top = 262
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryHirePricingLineHirePriceLineId: TIntegerField
      FieldName = 'HirePriceLineId'
    end
    object qryHirePricingLineGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object qryHirePricingLineAssetHireId: TIntegerField
      FieldName = 'AssetHireId'
    end
    object qryHirePricingLineDurationID: TIntegerField
      FieldName = 'DurationID'
    end
    object qryHirePricingLineDurationName: TWideStringField
      FieldName = 'DurationName'
      Size = 100
    end
    object qryHirePricingLineRate: TFloatField
      FieldName = 'Rate'
    end
    object qryHirePricingLineActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryHirePricingLinemstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object qryHirePricingLinemsUpdatesiteCode: TWideStringField
      FieldName = 'msUpdatesiteCode'
      Size = 3
    end
  end
  object qryDuration: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblduration Where active ="T" order by Description')
    Left = 583
    Top = 262
  end
  object qryIncomeAccountLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select AccountId, Accountname, AccountType from tblchartofaccoun' +
        'ts'
      'WHERE Active = "T" and IsHeader = "F" and AccountType="INC"'
      '  and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        '  or ((:SearchMode=1) and (AccountName like Concat(:SearchValue,' +
        ' "%")))'
      
        '  or ((:SearchMode = 2) and ((AccountName LIKE Concat("%",:Searc' +
        'hValue,"%")))))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY AccountName')
    Left = 658
    Top = 146
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryIncomeAccountLookupAccountname: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 30
      FieldName = 'Accountname'
      Origin = 'tblchartofaccounts.AccountName'
      Size = 50
    end
    object qryIncomeAccountLookupAccountType: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'AccountType'
      Size = 50
    end
    object qryIncomeAccountLookupAccountId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'AccountId'
      Origin = 'tblchartofaccounts.AccountID'
      Visible = False
    end
  end
  object dsAssetHire: TDataSource
    DataSet = qryAssetHire
    Left = 451
    Top = 315
  end
  object dsHirePricingLine: TDataSource
    DataSet = qryHirePricingLine
    Left = 515
    Top = 315
  end
  object qryProductLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'if((LOCATE('#39'^'#39',p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')+1)) >0,'
      'MID(p.PRODUCTGROUP,LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1)+1,char_length(p.PRODUCTGROUP)-'
      
        'LOCATE('#39'^'#39',p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')+1)),  Null) ' +
        ' AS '#39'Manuf'#39'  ,'
      'MID(p.PRODUCTGROUP, InStr(p.PRODUCTGROUP,'#39'^'#39')+1 ,'
      'If(LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1) - InStr(p.PRODUCTGROUP,'#39'^'#39') >0,'
      'LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1)-1 - InStr(p.PRODUCTGROUP,'#39'^'#39'),'
      'IF(InStr(p.PRODUCTGROUP,'#39'^'#39')<>0,'
      
        'char_length(p.PRODUCTGROUP) - InStr(p.PRODUCTGROUP,'#39'^'#39'),0))) AS ' +
        #39'Type'#39' ,'
      'If(InStr(p.PRODUCTGROUP,'#39'^'#39') -1 >0,'
      'Left(p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')-1),'
      'p.PRODUCTGROUP)   AS '#39'Dept'#39','
      'SupplierProductCode,'
      'p.PARTSID,p.PARTTYPE, p.PRODUCTGROUP, p.PARTNAME,'
      'p.PARTSDESCRIPTION, p.INCOMEACCNT,'
      'p.ASSETACCNT, p.COGSACCNT, p.BARCODE, p.PRODUCTCODE,'
      'p.TAXCODE, p.Batch, p.AutoBatch, p.MultipleBins,'
      'p.SpecialDiscount, p.SNTracking,  p.BuyQTY1, p.BuyQTY2,'
      
        'p.BuyQTY3, p.COST1, p.COST2, p.COST3, p.SellQTY1, p.SellQTY2, p.' +
        'SellQTY3,'
      
        'p.PRICE1, p.PRICE2, p.PRICE3, p.WHOLESALEPRICE, p.Active, p.Edit' +
        'edFlag,AvgCost,'
      'p.Discontinued, p.LatestCost'
      'FROM tblparts p'
      'WHERE p.Active = '#39'T'#39
      'ORDER BY p.PARTNAME')
    Left = 664
    Top = 192
  end
end
