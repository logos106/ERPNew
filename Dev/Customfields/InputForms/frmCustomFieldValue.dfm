inherited fmCustomFieldValue: TfmCustomFieldValue
  Left = 159
  Top = 165
  HelpContext = 871001
  Caption = 'fmCustomFieldValue'
  ClientHeight = 455
  ClientWidth = 880
  ExplicitLeft = 159
  ExplicitTop = 165
  ExplicitWidth = 896
  ExplicitHeight = 494
  DesignSize = (
    880
    455)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 455
    Width = 880
    HelpContext = 871009
    ExplicitTop = 455
    ExplicitWidth = 880
  end
  object pnlMain: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 880
    Height = 455
    HelpContext = 871002
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object grdMain: TwwDBGrid
      Left = 1
      Top = 1
      Width = 878
      Height = 403
      HelpContext = 871003
      ControlType.Strings = (
        'Value;CustomEdit;CboDropDownValues;F')
      Selected.Strings = (
        'customfield'#9'20'#9'Description'#9#9
        'Value'#9'61'#9'Value'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsCustomfieldValues
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = grdMainCalcCellColors
      FooterColor = clWhite
    end
    object dtpicker: TwwDBDateTimePicker
      Left = 607
      Top = 138
      Width = 140
      Height = 24
      HelpContext = 871004
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      ShowButton = True
      TabOrder = 2
      Visible = False
      OnClick = dtpickerClick
      OnCloseUp = dtpickerCloseUp
      OnChange = dtpickerChange
    end
    object CboDropDownValues: TwwDBComboBox
      Left = 462
      Top = 138
      Width = 139
      Height = 24
      HelpContext = 871005
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      DropDownCount = 8
      ItemHeight = 0
      Sorted = False
      TabOrder = 1
      UnboundDataType = wwDefault
      Visible = False
      OnCloseUp = CboDropDownValuesCloseUp
    end
    object edtNumber: TwwDBEdit
      Left = 753
      Top = 138
      Width = 121
      Height = 24
      HelpContext = 871006
      Picture.PictureMask = 
        '{{{#[#][#]{{;,###*[;,###]},*#}[.*#]},.#*#}[E[[+,-]#[#][#]]],({{#' +
        '[#][#]{{;,###*[;,###]},*#}[.*#]},.#*#}[E[[+,-]#[#][#]]]),[-]{{#[' +
        '#][#]{{;,###*[;,###]},*#}[.*#]},.#*#}[E[[+,-]#[#][#]]]}'
      TabOrder = 3
      UnboundDataType = wwDefault
      Visible = False
      WantReturns = False
      WordWrap = False
    end
    object DNMPanel1: TDNMPanel
      Left = 1
      Top = 404
      Width = 878
      Height = 50
      HelpContext = 871007
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      DesignSize = (
        878
        50)
      object cmdCustomLabelsOld: TDNMSpeedButton
        Left = 396
        Top = 6
        Width = 87
        Height = 27
        Hint = '"Add A New Customised Field For All Employee'#39's"'
        HelpContext = 871008
        Anchors = [akBottom]
        Caption = '&Add Labels'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = cmdCustomLabelsOldClick
      end
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 120
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 82
    Top = 120
  end
  inherited MyConnection: TERPConnection
    Left = 194
    Top = 120
  end
  inherited DataState: TDataState
    Top = 120
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 157
    Top = 120
  end
  inherited imgsort: TImageList
    Left = 45
    Top = 120
    Bitmap = {
      494C010102001C003C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 120
    Top = 120
  end
  inherited qryMemTrans: TERPQuery
    Left = 21
    Top = 40
  end
  object QryCustomfieldValues: TERPQuery
    SQL.Strings = (
      'select * from  '
      'tblcustomfieldvaluesClients')
    BeforeInsert = QryCustomfieldValuesBeforeInsert
    Left = 248
    Top = 64
    object QryCustomfieldValuescustomfield: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'customfield'
      LookupDataSet = qryCustomFieldList
      LookupKeyFields = 'CFID'
      LookupResultField = 'Description'
      KeyFields = 'CustomFieldlistId'
      Size = 255
      Lookup = True
    end
    object QryCustomfieldValuesValue: TWideStringField
      DisplayWidth = 61
      FieldName = 'Value'
      Origin = 'tblcustomfieldvaluesClients.Value'
      Size = 255
    end
    object QryCustomfieldValuesglobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'globalref'
      Origin = 'tblcustomfieldvaluesClients.globalref'
      Visible = False
      Size = 255
    end
    object QryCustomfieldValuesId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'Id'
      Origin = 'tblcustomfieldvaluesClients.Id'
      Visible = False
    end
    object QryCustomfieldValuesMasterID: TIntegerField
      DisplayWidth = 10
      FieldName = 'MasterID'
      Origin = 'tblcustomfieldvaluesClients.MasterID'
      Visible = False
    end
    object QryCustomfieldValuesCustomFieldlistId: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomFieldlistId'
      Origin = 'tblcustomfieldvaluesClients.CustomFieldlistId'
      Visible = False
    end
    object QryCustomfieldValuesmstimestamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimestamp'
      Origin = 'tblcustomfieldvaluesClients.mstimestamp'
      Visible = False
    end
  end
  object dsCustomfieldValues: TDataSource
    DataSet = QryCustomfieldValues
    Left = 232
    Top = 152
  end
  object qryCustomFieldList: TERPQuery
    SQL.Strings = (
      'select * from  '
      'tblCustomFieldList')
    Left = 264
    Top = 120
    object qryCustomFieldListCFID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'CFID'
      Origin = 'tblcustomfieldlist.CFID'
    end
    object qryCustomFieldListDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tblcustomfieldlist.Description'
      Size = 50
    end
  end
end
