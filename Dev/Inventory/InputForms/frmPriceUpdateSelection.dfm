inherited fmPriceUpdateSelection: TfmPriceUpdateSelection
  Left = 366
  Top = 205
  HelpContext = 555000
  Caption = 'Selection Range'
  ClientHeight = 388
  ClientWidth = 722
  OldCreateOrder = True
  ExplicitLeft = 366
  ExplicitTop = 205
  ExplicitWidth = 730
  ExplicitHeight = 415
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 555001
  end
  inherited lblSkingroupMsg: TLabel
    Top = 346
    Width = 722
    ExplicitTop = 346
    ExplicitWidth = 722
    HelpContext = 555028
  end
  object dtpValue: TwwDBDateTimePicker [4]
    Left = 479
    Top = 320
    Width = 185
    Height = 23
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 3
    Visible = False
    OnCloseUp = dtpValueCloseUp
    HelpContext = 555029
  end
  inline QueryBuilder: TfrSQLSelectBuilder [5]
    Left = 0
    Top = 103
    Width = 722
    Height = 243
    HelpContext = 555008
    Align = alClient
    TabOrder = 2
    ExplicitTop = 103
    ExplicitWidth = 722
    ExplicitHeight = 243
    inherited pnlFrame: TDNMPanel
      Width = 722
      Height = 243
      HelpContext = 555009
      ExplicitWidth = 722
      ExplicitHeight = 243
      inherited lblSearchCriteria: TLabel
        Left = 33
        Top = 6
        HelpContext = 555010
        ExplicitLeft = 33
        ExplicitTop = 6
      end
      inherited Label3: TLabel
        Left = 31
        Top = 202
        HelpContext = 555011
        ExplicitLeft = 31
        ExplicitTop = 202
      end
      inherited Label5: TLabel
        Left = 105
        Top = 202
        HelpContext = 555012
        ExplicitLeft = 105
        ExplicitTop = 202
      end
      inherited Label6: TLabel
        Left = 335
        Top = 202
        HelpContext = 555013
        ExplicitLeft = 335
        ExplicitTop = 202
      end
      inherited Label7: TLabel
        Left = 479
        Top = 202
        HelpContext = 555014
        ExplicitLeft = 479
        ExplicitTop = 202
      end
      inherited lstLines: TListBox
        Left = 31
        Top = 19
        Width = 538
        HelpContext = 555015
        ExplicitLeft = 31
        ExplicitTop = 19
        ExplicitWidth = 538
      end
      inherited cboAndOr: TComboBox
        Left = 31
        Top = 217
        HelpContext = 555016
        ExplicitLeft = 31
        ExplicitTop = 217
      end
      inherited cboField: TComboBox
        Left = 103
        Top = 217
        Width = 225
        HelpContext = 555017
        OnCloseUp = QueryBuildercboFieldCloseUp
        ExplicitLeft = 103
        ExplicitTop = 217
        ExplicitWidth = 225
      end
      inherited cboOperator: TComboBox
        Left = 335
        Top = 217
        HelpContext = 555018
        Items.Strings = (
          'all'
          'equal to'
          'not equal to'
          'greater than'
          'less than'
          'like'
          'greater or equal to'
          'less or equal to'
          'is blank'
          'is not blank'
          'starts with')
        ExplicitLeft = 335
        ExplicitTop = 217
      end
      inherited edtConstValue: TEdit
        Left = 479
        Top = 217
        Width = 185
        HelpContext = 555019
        ExplicitLeft = 479
        ExplicitTop = 217
        ExplicitWidth = 185
      end
      inherited btnAddListItem: TDNMSpeedButton
        Left = 576
        Top = 19
        HelpContext = 555020
        Font.Height = -12
        OnClick = QueryBuilderbtnAddListItemClick
        ExplicitLeft = 576
        ExplicitTop = 19
      end
      inherited btnDeleteListItem: TDNMSpeedButton
        Left = 576
        Top = 50
        HelpContext = 555021
        Font.Height = -12
        ExplicitLeft = 576
        ExplicitTop = 50
      end
    end
  end
  object pnlTop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 722
    Height = 103
    HelpContext = 555002
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlTitle: TDNMPanel
      Left = 169
      Top = 6
      Width = 371
      Height = 45
      HelpContext = 555005
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 367
        Height = 41
        HelpContext = 555006
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
          Width = 367
          Height = 41
          HelpContext = 555007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Custom Fields Selection'
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
  end
  object pnlBottom: TDNMPanel [7]
    Left = 0
    Top = 346
    Width = 722
    Height = 42
    HelpContext = 555022
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      722
      42)
    object Label50: TLabel
      Left = 671
      Top = 7
      Width = 37
      Height = 16
      HelpContext = 555023
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Active'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object btnSave: TDNMSpeedButton
      Left = 90
      Top = 9
      Width = 87
      Height = 27
      HelpContext = 555024
      Action = actMainSave
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
    end
    object btnCancel: TDNMSpeedButton
      Left = 528
      Top = 9
      Width = 87
      Height = 27
      HelpContext = 555026
      Action = actMainCancel
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
    end
    object chkActive: TwwCheckBox
      Left = 682
      Top = 19
      Width = 16
      Height = 17
      HelpContext = 555027
      DisableThemes = False
      AlwaysTransparent = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akRight, akBottom]
      Caption = 'chkActive'
      DataField = 'Active'
      DataSource = dsMaster
      TabOrder = 2
    end
  end
  inherited DataState: TDataState [8]
  end
  inherited popCustomiseGrid: TAdvPopupMenu [9]
  end
  inherited ApplicationEvents1: TApplicationEvents [10]
  end
  inherited dlgReportSelect: TSelectionDialog [11]
  end
  inherited imgsort: TImageList [12]
    Bitmap = {
      494C010102009400940010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited tmrProcessMessage: TTimer [13]
  end
  inherited tmrdelay: TTimer [14]
  end
  inherited MyConnection: TERPConnection [15]
  end
  inherited QryCustomField: TERPQuery [16]
  end
  inherited ProgressDialogOBJ: TProgressDialog [17]
  end
  object alMain: TActionList
    Left = 400
    Top = 32
    object actMainSave: TAction
      Caption = '&Save'
      OnExecute = actMainSaveExecute
      HelpContext = 555030
    end
    object actMainNew: TAction
      Caption = '&New'
      HelpContext = 555031
    end
    object actMainCancel: TAction
      Caption = '&Cancel'
      OnExecute = actMainCancelExecute
      HelpContext = 555032
    end
    object actDeleteListItem: TAction
      Caption = 'Delete'
      HelpContext = 555033
    end
    object actAddListItem: TAction
      Caption = 'Add'
      HelpContext = 555034
    end
  end
  object qryMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblMarketingrangeselection')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforePost = qryMasterBeforePost
    Left = 73
    Top = 29
    object qryMasterRangeSelectionId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'RangeSelectionId'
      Origin = 'tblMarketingrangeselection.RangeSelectionId'
    end
    object qryMasterRangeDescription: TWideStringField
      FieldName = 'RangeDescription'
      Origin = 'tblMarketingrangeselection.RangeDescription'
      Size = 255
    end
    object qryMasterXMLData: TWideMemoField
      FieldName = 'XMLData'
      Origin = 'tblMarketingrangeselection.XMLData'
      BlobType = ftWideMemo
    end
    object qryMasterActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblMarketingrangeselection.Active'
      FixedChar = True
      Size = 1
    end
    object qryMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblMarketingrangeselection.GlobalRef'
      Size = 255
    end
    object qryMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblMarketingrangeselection.msTimeStamp'
    end
  end
  object dsMaster: TDataSource
    DataSet = qryMaster
    Left = 112
    Top = 40
  end
  object dlgMemo: TwwMemoDialog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Caption = 'Script'
    DlgLeft = 0
    DlgTop = 0
    DlgWidth = 561
    DlgHeight = 396
    Left = 41
    Top = 31
  end
  object qryDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblMarketingrangeselectionmessages')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 145
    Top = 37
    object qryDetailsMessageID: TIntegerField
      FieldName = 'MessageID'
    end
    object qryDetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryDetailsRangeSelectionID: TIntegerField
      FieldName = 'RangeSelectionID'
    end
    object qryDetailsMessage: TWideMemoField
      FieldName = 'Message'
      BlobType = ftWideMemo
    end
    object qryDetailsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryDetailsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object dsDetails: TDataSource
    DataSet = qryDetails
    Left = 176
    Top = 40
  end
  object qryCustomFields: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'CFLabel1,CFProduct1,CFLabel2,'
      'CFProduct2,  CFLabel3, CFProduct3, '
      ' CFLabel4, CFProduct4,  CFLabel5,'
      'CFProduct5, CFLabel6, CFProduct6, '
      ' CFLabel7, CFProduct7,  CFLabel8,'
      'CFProduct8,  CFLabel9, CFProduct9,'
      ' CFLabel10, CFProduct10, CFLabel11,'
      'CFProduct11, CFLabel12, CFProduct12,'
      ' CFLabel13, CFProduct13,  CFLabel14,'
      'CFProduct14,  CFLabel15, CFProduct15,'
      ' CFLabel16, CFlabel17,'
      'CFLabel18, CFProduct16, CFProduct17, CFProduct18,'
      'CFIsCombo1, CFIsCombo2, CFIsCombo3, CFIsCombo4, CFIsCombo5,'
      'CFIsCombo6, CFIsCombo7, CFIsCombo8, CFIsCombo9, CFIsCombo10,'
      'CFIsCombo11, CFIsCombo12, CFIsCombo13, CFIsCombo14, CFIsCombo15'
      'FROM tblcustomfields;')
    Options.LongStrings = False
    Left = 562
    Top = 14
    object qryCustomFieldsCFProduct1: TWideStringField
      FieldName = 'CFProduct1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct2: TWideStringField
      FieldName = 'CFProduct2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct3: TWideStringField
      FieldName = 'CFProduct3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct4: TWideStringField
      FieldName = 'CFProduct4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct5: TWideStringField
      FieldName = 'CFProduct5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct6: TWideStringField
      FieldName = 'CFProduct6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct7: TWideStringField
      FieldName = 'CFProduct7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct8: TWideStringField
      FieldName = 'CFProduct8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct9: TWideStringField
      FieldName = 'CFProduct9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct10: TWideStringField
      FieldName = 'CFProduct10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct11: TWideStringField
      FieldName = 'CFProduct11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct12: TWideStringField
      FieldName = 'CFProduct12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct13: TWideStringField
      FieldName = 'CFProduct13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct14: TWideStringField
      FieldName = 'CFProduct14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct15: TWideStringField
      FieldName = 'CFProduct15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct16: TWideStringField
      FieldName = 'CFProduct16'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct17: TWideStringField
      FieldName = 'CFProduct17'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFProduct18: TWideStringField
      FieldName = 'CFProduct18'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel1: TWideStringField
      FieldName = 'CFLabel1'
      Size = 16
    end
    object qryCustomFieldsCFLabel2: TWideStringField
      FieldName = 'CFLabel2'
      Size = 16
    end
    object qryCustomFieldsCFLabel3: TWideStringField
      FieldName = 'CFLabel3'
      Size = 16
    end
    object qryCustomFieldsCFLabel4: TWideStringField
      FieldName = 'CFLabel4'
      Size = 16
    end
    object qryCustomFieldsCFLabel5: TWideStringField
      FieldName = 'CFLabel5'
      Size = 16
    end
    object qryCustomFieldsCFLabel6: TWideStringField
      FieldName = 'CFLabel6'
      Size = 16
    end
    object qryCustomFieldsCFLabel7: TWideStringField
      FieldName = 'CFLabel7'
      Size = 16
    end
    object qryCustomFieldsCFLabel8: TWideStringField
      FieldName = 'CFLabel8'
      Size = 16
    end
    object qryCustomFieldsCFLabel9: TWideStringField
      FieldName = 'CFLabel9'
      Size = 16
    end
    object qryCustomFieldsCFLabel10: TWideStringField
      FieldName = 'CFLabel10'
      Size = 16
    end
    object qryCustomFieldsCFLabel11: TWideStringField
      FieldName = 'CFLabel11'
      Size = 16
    end
    object qryCustomFieldsCFLabel12: TWideStringField
      FieldName = 'CFLabel12'
      Size = 16
    end
    object qryCustomFieldsCFLabel13: TWideStringField
      FieldName = 'CFLabel13'
      Size = 16
    end
    object qryCustomFieldsCFLabel14: TWideStringField
      FieldName = 'CFLabel14'
      Size = 16
    end
    object qryCustomFieldsCFLabel15: TWideStringField
      FieldName = 'CFLabel15'
      Size = 16
    end
    object qryCustomFieldsCFLabel16: TWideStringField
      FieldName = 'CFLabel16'
      Size = 16
    end
    object qryCustomFieldsCFlabel17: TWideStringField
      FieldName = 'CFlabel17'
      Size = 16
    end
    object qryCustomFieldsCFLabel18: TWideStringField
      FieldName = 'CFLabel18'
      Size = 16
    end
  end
end
