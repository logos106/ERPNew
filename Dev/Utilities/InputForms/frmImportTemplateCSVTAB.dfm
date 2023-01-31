inherited ImportTemplateCSVTAB: TImportTemplateCSVTAB
  Left = 335
  Top = 128
  HelpContext = 368000
  Caption = 'Import Template'
  ClientHeight = 475
  ClientWidth = 730
  OldCreateOrder = True
  ExplicitWidth = 320
  ExplicitHeight = 240
  DesignSize = (
    730
    475)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [1]
    Left = 16
    Top = 64
    Width = 697
    Height = 34
    HelpContext = 368002
    Shape = bsFrame
  end
  object Label1: TLabel [2]
    Left = 32
    Top = 72
    Width = 56
    Height = 15
    HelpContext = 368003
    Caption = 'Template:'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 368001
  end
  object btnOK: TDNMSpeedButton [5]
    Left = 241
    Top = 438
    Width = 87
    Height = 29
    HelpContext = 368006
    Anchors = [akBottom]
    Caption = 'OK'
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = btnOKClick
  end
  object cboTemplate: TwwDBLookupCombo [6]
    Left = 96
    Top = 69
    Width = 225
    Height = 23
    HelpContext = 368007
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'TemplateName'#9'40'#9'Template Name'#9'F'#9)
    LookupTable = qryTemplate
    LookupField = 'TemplateName'
    ParentFont = False
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboTemplateCloseUp
    OnNotInList = cboTemplateNotInList
  end
  object cboFieldType: TwwDBComboBox [7]
    Left = 264
    Top = 136
    Width = 121
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = False
    AllowClearKey = False
    DataField = 'FieldType'
    DataSource = dsTemplateLines
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'Integer'
      'Float'
      'Boolean'
      'String')
    ParentFont = False
    Sorted = False
    TabOrder = 4
    UnboundDataType = wwDefault
    HelpContext = 368012
  end
  object btnGetFromFile: TDNMSpeedButton [8]
    Left = 528
    Top = 66
    Width = 181
    Height = 29
    HelpContext = 368008
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Get Fields From File'
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
    TabOrder = 5
    OnClick = btnGetFromFileClick
  end
  object pnlTitle: TDNMPanel [9]
    Left = 253
    Top = 6
    Width = 248
    Height = 45
    HelpContext = 368009
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 244
      Height = 41
      HelpContext = 368010
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
        Width = 244
        Height = 41
        HelpContext = 368011
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Import Template'
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
  object btnCancel: TDNMSpeedButton [10]
    Left = 425
    Top = 438
    Width = 87
    Height = 29
    HelpContext = 368005
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object grdTemplateLines: TwwDBGrid [11]
    Left = 16
    Top = 104
    Width = 697
    Height = 321
    HelpContext = 368004
    ControlType.Strings = (
      'FieldType;CustomEdit;cboFieldType;F')
    Selected.Strings = (
      'FieldName'#9'25'#9'Field Name'#9#9
      'FieldType'#9'25'#9'Field Type'#9#9
      'FieldDesc'#9'40'#9'Field Desc'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWindow
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsTemplateLines
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnExit = grdTemplateLinesExit
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
  end
  object qryTemplate: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tbladvimpcsvtabtempl'
      'WHERE TemplateType = :TemplateType'
      'AND Active = "T"')
    Left = 552
    Top = 16
    ParamData = <
      item
        DataType = ftString
        Name = 'TemplateType'
        Value = ''
      end>
    object qryTemplateTemplateName: TWideStringField
      DisplayLabel = 'Template Name'
      DisplayWidth = 40
      FieldName = 'TemplateName'
      Size = 255
    end
    object qryTemplateAdvImpCSVTABtemplID: TIntegerField
      DisplayWidth = 15
      FieldName = 'AdvImpCSVTABtemplID'
      Visible = False
    end
    object qryTemplateActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryTemplateGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryTemplatemsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object qryTemplateTemplateType: TIntegerField
      DisplayWidth = 10
      FieldName = 'TemplateType'
      Visible = False
    end
  end
  object qryTemplateLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tbladvimpcsvtabtempllines'
      'WHERE Active = "T"'
      'AND TemplateID = :TemplateID')
    OnNewRecord = qryTemplateLinesNewRecord
    Left = 584
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TemplateID'
      end>
    object qryTemplateLinesFieldName: TWideStringField
      DisplayLabel = 'Field Name'
      DisplayWidth = 25
      FieldName = 'FieldName'
      Origin = 'tbladvimpcsvtabtempllines.FieldName'
      Size = 255
    end
    object qryTemplateLinesFieldType: TWideStringField
      DisplayLabel = 'Field Type'
      DisplayWidth = 25
      FieldName = 'FieldType'
      Origin = 'tbladvimpcsvtabtempllines.FieldType'
      Size = 40
    end
    object qryTemplateLinesFieldDesc: TWideStringField
      DisplayLabel = 'Field Desc'
      DisplayWidth = 40
      FieldName = 'FieldDesc'
      Origin = 'tbladvimpcsvtabtempllines.FieldDesc'
      Size = 255
    end
    object qryTemplateLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tbladvimpcsvtabtempllines.ID'
      Visible = False
    end
    object qryTemplateLinesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tbladvimpcsvtabtempllines.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryTemplateLinesGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tbladvimpcsvtabtempllines.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryTemplateLinesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tbladvimpcsvtabtempllines.msTimeStamp'
      Visible = False
    end
    object qryTemplateLinesTemplateID: TIntegerField
      DisplayWidth = 15
      FieldName = 'TemplateID'
      Origin = 'tbladvimpcsvtabtempllines.TemplateID'
      Visible = False
    end
  end
  object dsTemplateLines: TDataSource
    DataSet = qryTemplateLines
    Left = 592
    Top = 48
  end
end
