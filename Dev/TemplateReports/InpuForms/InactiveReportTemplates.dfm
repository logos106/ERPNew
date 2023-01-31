inherited InactiveReportTemplatesGUI: TInactiveReportTemplatesGUI
  Left = 312
  Top = 336
  HelpContext = 712000
  Caption = 'Deleted Templates'
  ClientHeight = 348
  ClientWidth = 539
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 59
    Width = 539
    Height = 239
    HelpContext = 712001
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 4
      Top = 4
      Width = 530
      Height = 231
      HelpContext = 712002
    end
    object grdTemplates: TwwDBGrid
      Left = 6
      Top = 6
      Width = 526
      Height = 227
      HelpContext = 712005
      ControlType.Strings = (
        'DefaultTemplate;CheckBox;T;F')
      Selected.Strings = (
        'TemplName'#9'35'#9'Template Name'#9'T'
        'TypeName'#9'25'#9'Type'#9'T'
        'DefaultTemplate'#9'1'#9'Default'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alCustom
      DataSource = dsTemplates
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      UseTFields = False
      OnDblClick = grdTemplatesDblClick
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
  end
  object DNMPanel2: TDNMPanel [2]
    Left = 0
    Top = 0
    Width = 539
    Height = 59
    HelpContext = 712003
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object pnlTitle: TDNMPanel
      Left = 99
      Top = 5
      Width = 366
      Height = 45
      HelpContext = 712006
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 364
        Height = 43
        HelpContext = 712007
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
          Width = 364
          Height = 43
          HelpContext = 712008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Deleted Templates'
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
  object DNMPanel3: TDNMPanel [3]
    Left = 0
    Top = 298
    Width = 539
    Height = 50
    HelpContext = 712004
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      539
      50)
    object btnClose: TDNMSpeedButton
      Left = 239
      Top = 14
      Width = 87
      Height = 26
      HelpContext = 712009
      Anchors = [akTop, akRight]
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
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 113
    Top = 120
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 120
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 148
    Top = 120
  end
  inherited DataState: TDataState
    Left = 43
    Top = 120
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    HelpContext = 712009
    Top = 120
  end
  inherited imgsort: TImageList
    Left = 78
    Top = 120
  end
  object qryTemplates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT TemplName, TemplID,TypeName, TemplateClass, SQLString,Des' +
        'ignTimeSQLString, '
      
        'EmployeeID, Editable, DefaultTemplate, tbltemplates.TypeID, tblt' +
        'emplatetype.ReportOnFc, tbltemplates.Active, tbltemplates.Global' +
        'ref'
      'FROM tbltemplates'
      'Left Join tbltemplatetype using(TypeID)'
      'WHERE tbltemplates.Active = "F"'
      'ORDER BY TemplName, TypeID;')
    Options.FlatBuffers = True
    Left = 290
    Top = 142
    object qryTemplatesTemplName: TWideStringField
      FieldName = 'TemplName'
      Size = 30
    end
    object qryTemplatesTemplID: TIntegerField
      FieldName = 'TemplID'
    end
    object qryTemplatesTypeName: TWideStringField
      FieldName = 'TypeName'
      Size = 255
    end
    object qryTemplatesTemplateClass: TWideStringField
      FieldName = 'TemplateClass'
      Size = 255
    end
    object qryTemplatesSQLString: TWideMemoField
      FieldName = 'SQLString'
      BlobType = ftWideMemo
    end
    object qryTemplatesDesignTimeSQLString: TWideMemoField
      FieldName = 'DesignTimeSQLString'
      BlobType = ftWideMemo
    end
    object qryTemplatesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryTemplatesEditable: TWideStringField
      FieldName = 'Editable'
      FixedChar = True
      Size = 1
    end
    object qryTemplatesDefaultTemplate: TWideStringField
      FieldName = 'DefaultTemplate'
      FixedChar = True
      Size = 1
    end
    object qryTemplatesTypeID: TIntegerField
      FieldName = 'TypeID'
    end
    object qryTemplatesReportOnFc: TWideStringField
      FieldName = 'ReportOnFc'
      FixedChar = True
      Size = 1
    end
    object qryTemplatesGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object qryTemplatesActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object dsTemplates: TDataSource
    DataSet = qryTemplates
    Left = 292
    Top = 176
  end
end
