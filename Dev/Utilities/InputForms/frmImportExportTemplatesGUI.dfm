inherited frmImportExportTemplates: TfrmImportExportTemplates
  Left = 204
  Top = 142
  HelpContext = 294000
  Caption = 'File Template Editor'
  ClientHeight = 553
  ClientWidth = 821
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 294001
  end
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 821
    Height = 553
    HelpContext = 294002
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      821
      553)
    object lblDiscountCode: TLabel
      Left = 0
      Top = 375
      Width = 820
      Height = 29
      HelpContext = 294003
      Alignment = taCenter
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Caption = 'Purchase Discounts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 1
      Top = 240
      Width = 820
      Height = 29
      HelpContext = 294004
      Alignment = taCenter
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Caption = 'Discount / Markups'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object DNMPanel2: TDNMPanel
      Left = 1
      Top = 505
      Width = 819
      Height = 47
      HelpContext = 294005
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        819
        47)
      object cmdSave: TDNMSpeedButton
        Left = 193
        Top = 10
        Width = 87
        Height = 29
        HelpContext = 294006
        Anchors = [akBottom]
        Caption = '&Save'
        Default = True
        DisableTransparent = False
        Enabled = False
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
        TabOrder = 0
        OnClick = cmdSaveClick
      end
      object cmdCancel: TDNMSpeedButton
        Left = 513
        Top = 9
        Width = 87
        Height = 29
        HelpContext = 294007
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
        TabOrder = 2
        OnClick = cmdCancelClick
      end
      object btnClear: TDNMSpeedButton
        Left = 353
        Top = 10
        Width = 87
        Height = 29
        HelpContext = 294008
        Anchors = [akBottom]
        Cancel = True
        Caption = 'C&lear'
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
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        OnClick = btnClearClick
      end
    end
    object grdLines: TwwDBGrid
      Left = 6
      Top = 78
      Width = 808
      Height = 163
      HelpContext = 294009
      ControlType.Strings = (
        'FieldType;CustomEdit;cboFieldType;F'
        'IsDiscount;CheckBox;T;F')
      Selected.Strings = (
        'FieldName'#9'20'#9'Field Name'#9#9
        'FieldType'#9'12'#9'Type'#9#9
        'FieldSize'#9'10'#9'Size'#9#9
        'APrecision'#9'8'#9'Precision'#9#9
        'FieldStart'#9'10'#9'Start'#9#9
        'FieldEnd'#9'10'#9'End'#9#9
        'FieldDescription'#9'23'#9'Field Description'#9'F'
        'IsDiscount'#9'9'#9'Is Discount'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = 15724527
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsTemplateLines
      KeyOptions = [dgEnterToTab, dgAllowInsert]
      Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnExit = grdLinesExit
      FooterColor = clWhite
      FooterCellColor = clWhite
      object btnDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = btnDeleteClick
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 1
      Top = 1
      Width = 819
      Height = 73
      HelpContext = 294010
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Label2: TLabel
        Left = 8
        Top = 46
        Width = 95
        Height = 15
        HelpContext = 294011
        Alignment = taRightJustify
        Caption = 'Template Name :'
        Transparent = True
      end
      object Label4: TLabel
        Left = 336
        Top = 46
        Width = 95
        Height = 15
        HelpContext = 294012
        Alignment = taRightJustify
        Caption = 'Clone from Part :'
        Transparent = True
      end
      object cboTemplateName: TwwDBLookupCombo
        Left = 112
        Top = 43
        Width = 217
        Height = 23
        HelpContext = 294013
        DropDownAlignment = taLeftJustify
        LookupTable = qryTemplates
        LookupField = 'TemplateName'
        DropDownCount = 10
        DropDownWidth = 40
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboTemplateNameCloseUp
        OnNotInList = cboTemplateNameNotInList
      end
      object cboClonePart: TwwDBLookupCombo
        Left = 438
        Top = 43
        Width = 217
        Height = 23
        HelpContext = 294014
        DropDownAlignment = taLeftJustify
        LookupTable = qryPart
        LookupField = 'PARTNAME'
        DropDownCount = 10
        DropDownWidth = 40
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        AllowClearKey = True
        OnNotInList = cboClonePartNotInList
      end
      object pnlTitle: TDNMPanel
        Left = 232
        Top = 2
        Width = 307
        Height = 38
        HelpContext = 294015
        BevelInner = bvRaised
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object TitleShader: TShader
          Left = 2
          Top = 2
          Width = 303
          Height = 34
          HelpContext = 294016
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
            Width = 303
            Height = 34
            HelpContext = 294017
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'File Template Editor'
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
    object cboFieldType: TwwDBComboBox
      Left = 31
      Top = 103
      Width = 130
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      DataField = 'FieldType'
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'String'
        'Integer'
        'Decimal'
        'Byte')
      Sorted = False
      TabOrder = 5
      UnboundDataType = wwDefault
    end
    object grdDiscountLines: TwwDBGrid
      Left = 5
      Top = 400
      Width = 810
      Height = 101
      HelpContext = 294018
      Selected.Strings = (
        'DiscountCode'#9'10'#9'Discount~Code'#9'F'#9
        'BuyQty1'#9'10'#9'Buy~Qty 1'#9'F'#9
        'DiscPercent1'#9'10'#9'Discount %'#9'F'#9
        'BuyQty2'#9'10'#9'Buy~Qty 2'#9'F'#9
        'DiscPercent2'#9'10'#9'Discount %'#9'F'#9
        'BuyQty3'#9'10'#9'Buy~Qty 3'#9'F'#9
        'DiscPercent3'#9'10'#9'Discount %'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = 15724527
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akRight, akBottom]
      DataSource = dsTemplateDiscountLines
      KeyOptions = [dgAllowInsert]
      TabOrder = 3
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      object btnDeleteCode: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = btnDeleteCodeClick
      end
    end
    object grdSellMarkups: TwwDBGrid
      Left = 6
      Top = 267
      Width = 810
      Height = 110
      HelpContext = 294019
      ControlType.Strings = (
        'CustomerTypeName;CustomEdit;cboClientType;F')
      Selected.Strings = (
        'CustomerTypeName'#9'15'#9'Customer Type'#9'F'#9
        'PriceMarkup1'#9'10'#9'Price 1'#9'F'#9
        'PriceMarkup2'#9'10'#9'Price 2'#9'F'
        'PriceMarkup3'#9'10'#9'Price 3'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = 15724527
      FixedCols = 0
      ShowHorzScrollBar = False
      ShowVertScrollBar = False
      Anchors = [akLeft, akRight, akBottom]
      DataSource = dsSellMarkups
      KeyOptions = [dgAllowInsert]
      TabOrder = 2
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      object btnDeleteMarkup: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = btnDeleteMarkupClick
      end
    end
    object cboClientType: TwwDBLookupCombo
      Left = 32
      Top = 296
      Width = 121
      Height = 23
      DropDownAlignment = taLeftJustify
      DataField = 'CustomerTypeName'
      DataSource = dsSellMarkups
      LookupTable = qryClientType
      LookupField = 'TypeName'
      Style = csDropDownList
      DropDownWidth = 40
      TabOrder = 6
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      ShowMatchText = True
      OnCloseUp = cboClientTypeCloseUp
    end
  end
  object qryTemplates: TERPQuery [4]
    SQL.Strings = (
      'SELECT '
      'ID, TemplateName, ClonePartID'
      'FROM tblImportExportFileTemplates'
      'WHERE Active = "T"'
      'ORDER BY TemplateName;')
    Left = 792
    Top = 40
    object qryTemplatesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblImportExportFileTemplates.ID'
    end
    object qryTemplatesTemplateName: TStringField
      FieldName = 'TemplateName'
      Origin = 'tblImportExportFileTemplates.TemplateName'
      Size = 255
    end
    object qryTemplatesClonePartID: TIntegerField
      FieldName = 'ClonePartID'
    end
  end
  object qryTemplateLines: TERPQuery [5]
    SQL.Strings = (
      'SELECT * FROM tblImportExportFileTemplateLines'
      'WHERE TemplateID = :xTemplateID'
      '')
    AutoCalcFields = False
    AfterOpen = qryTemplateLinesAfterOpen
    Options.StrictUpdate = False
    Left = 760
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xTemplateID'
      end>
    object qryTemplateLinesFieldName: TStringField
      DisplayLabel = 'Field Name'
      DisplayWidth = 20
      FieldName = 'FieldName'
      Origin = 'tblImportExportFileTemplateLines.FieldName'
      Size = 255
    end
    object qryTemplateLinesFieldType: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 12
      FieldName = 'FieldType'
      Origin = 'tblImportExportFileTemplateLines.FieldType'
      Size = 255
    end
    object qryTemplateLinesFieldSize: TIntegerField
      DisplayLabel = 'Size'
      DisplayWidth = 10
      FieldName = 'FieldSize'
      Origin = 'tblImportExportFileTemplateLines.FieldSize'
    end
    object qryTemplateLinesAPrecision: TIntegerField
      DisplayLabel = 'Precision'
      DisplayWidth = 8
      FieldName = 'APrecision'
      Origin = 'tblImportExportFileTemplateLines.APrecision'
    end
    object qryTemplateLinesFieldStart: TIntegerField
      DisplayLabel = 'Start'
      DisplayWidth = 10
      FieldName = 'FieldStart'
      Origin = 'tblImportExportFileTemplateLines.FieldStart'
    end
    object qryTemplateLinesFieldEnd: TIntegerField
      DisplayLabel = 'End'
      DisplayWidth = 10
      FieldName = 'FieldEnd'
      Origin = 'tblImportExportFileTemplateLines.FieldEnd'
    end
    object qryTemplateLinesIsDiscount: TStringField
      DisplayLabel = 'Is Discount'
      DisplayWidth = 10
      FieldName = 'IsDiscount'
      Origin = 'tblImportExportFileTemplateLines.IsDiscount'
      FixedChar = True
      Size = 1
    end
    object qryTemplateLinesFieldDescription: TStringField
      DisplayLabel = 'Field Description'
      DisplayWidth = 25
      FieldName = 'FieldDescription'
      Origin = 'tblImportExportFileTemplateLines.FieldDescription'
      Size = 255
    end
    object qryTemplateLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblImportExportFileTemplateLines.ID'
      Visible = False
    end
    object qryTemplateLinesTemplateID: TIntegerField
      FieldName = 'TemplateID'
      Origin = 'tblImportExportFileTemplateLines.TemplateID'
      Visible = False
    end
    object qryTemplateLinesGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Origin = 'tblImportExportFileTemplateLines.GlobalRef'
      Visible = False
      Size = 255
    end
  end
  object dsTemplateLines: TDataSource [6]
    DataSet = memLines
    Left = 760
    Top = 8
  end
  object memLines: TkbmMemTable [7]
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    AutoAddIndexes = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = memLinesBeforePost
    Left = 760
    Top = 72
    object memLinesFieldName: TStringField
      DisplayLabel = 'Field Name'
      DisplayWidth = 20
      FieldName = 'FieldName'
      Size = 255
    end
    object memLinesFieldType: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 12
      FieldName = 'FieldType'
      OnChange = memLinesFieldTypeChange
      Size = 255
    end
    object memLinesFieldSize: TIntegerField
      DisplayLabel = 'Size'
      DisplayWidth = 10
      FieldName = 'FieldSize'
      OnChange = memLinesFieldSizeChange
    end
    object memLinesAPrecision: TIntegerField
      DisplayLabel = 'Precision'
      DisplayWidth = 8
      FieldName = 'APrecision'
    end
    object memLinesFieldStart: TIntegerField
      DisplayLabel = 'Start'
      DisplayWidth = 10
      FieldName = 'FieldStart'
    end
    object memLinesFieldEnd: TIntegerField
      DisplayLabel = 'End'
      DisplayWidth = 10
      FieldName = 'FieldEnd'
    end
    object memLinesFieldDescription: TStringField
      DisplayLabel = 'Field Description'
      DisplayWidth = 23
      FieldName = 'FieldDescription'
      Size = 255
    end
    object memLinesIsDiscount: TStringField
      DisplayLabel = 'Is Discount'
      DisplayWidth = 9
      FieldName = 'IsDiscount'
      Origin = 'tblImportExportFileTemplateLines.IsDiscount'
      OnChange = memLinesIsDiscountChange
      FixedChar = True
      Size = 1
    end
    object memLinesGlobalRef: TStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object memLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
    object memLinesTemplateID: TIntegerField
      DisplayWidth = 15
      FieldName = 'TemplateID'
      Visible = False
    end
  end
  object dsTemplates: TDataSource [8]
    DataSet = qryTemplates
    Left = 792
    Top = 8
  end
  object qryTemplateDiscountLines: TERPQuery [9]
    SQL.Strings = (
      'SELECT * '
      'FROM tblImportExportDiscountLines'
      'WHERE TemplateID = :xTemplateID'
      '')
    AutoCalcFields = False
    AfterOpen = qryTemplateDiscountLinesAfterOpen
    Options.StrictUpdate = False
    Left = 728
    Top = 40
    ParamData = <
      item
        DataType = ftString
        Name = 'xTemplateID'
        Value = ''
      end>
    object qryTemplateDiscountLinesDiscountCode: TStringField
      FieldName = 'DiscountCode'
      Origin = 'tblImportExportDiscountLines.DiscountCode'
      Size = 255
    end
    object qryTemplateDiscountLinesBuyQty1: TIntegerField
      FieldName = 'BuyQty1'
      Origin = 'tblImportExportDiscountLines.BuyQty1'
    end
    object qryTemplateDiscountLinesDiscPercent1: TFloatField
      FieldName = 'DiscPercent1'
      Origin = 'tblImportExportDiscountLines.DiscPercent1'
      EditFormat = '#.00%'
    end
    object qryTemplateDiscountLinesBuyQty2: TIntegerField
      FieldName = 'BuyQty2'
      Origin = 'tblImportExportDiscountLines.BuyQty2'
    end
    object qryTemplateDiscountLinesDiscPercent2: TFloatField
      FieldName = 'DiscPercent2'
      Origin = 'tblImportExportDiscountLines.DiscPercent2'
      EditFormat = '#.00%'
    end
    object qryTemplateDiscountLinesBuyQty3: TIntegerField
      FieldName = 'BuyQty3'
      Origin = 'tblImportExportDiscountLines.BuyQty3'
    end
    object qryTemplateDiscountLinesDiscPercent3: TFloatField
      FieldName = 'DiscPercent3'
      Origin = 'tblImportExportDiscountLines.DiscPercent3'
      EditFormat = '#.00%'
    end
    object qryTemplateDiscountLinesTemplateID: TIntegerField
      FieldName = 'TemplateID'
      Origin = 'tblImportExportDiscountLines.TemplateID'
    end
    object qryTemplateDiscountLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblImportExportDiscountLines.ID'
    end
    object qryTemplateDiscountLinesGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Origin = 'tblImportExportDiscountLines.GlobalRef'
      Size = 255
    end
  end
  object dsTemplateDiscountLines: TDataSource [10]
    DataSet = memDiscountLines
    Left = 728
    Top = 8
  end
  object memDiscountLines: TkbmMemTable [11]
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    AutoAddIndexes = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 728
    Top = 72
    object memDiscountLinesDiscountCode: TStringField
      DisplayLabel = 'Discount~Code'
      DisplayWidth = 10
      FieldName = 'DiscountCode'
      Origin = 'memDiscountLines.DiscountCode'
      Visible = False
      Size = 255
    end
    object memDiscountLinesBuyQty1: TIntegerField
      DisplayLabel = 'Buy~Qty 1'
      DisplayWidth = 10
      FieldName = 'BuyQty1'
      Origin = 'tblImportExportDiscountLines.BuyQty1'
      Visible = False
      OnChange = memDiscountLinesBuyQty1Change
    end
    object memDiscountLinesDiscPercent1: TFloatField
      DisplayLabel = 'Discount %'
      DisplayWidth = 10
      FieldName = 'DiscPercent1'
      Origin = 'memDiscountLines.DiscPercent1'
      Visible = False
      OnChange = memDiscountLinesDiscPercent1Change
      DisplayFormat = '#.00%'
    end
    object memDiscountLinesBuyQty2: TIntegerField
      DisplayLabel = 'Buy~Qty 2'
      DisplayWidth = 10
      FieldName = 'BuyQty2'
      Origin = 'tblImportExportDiscountLines.BuyQty2'
      Visible = False
      OnChange = memDiscountLinesBuyQty2Change
    end
    object memDiscountLinesDiscPercent2: TFloatField
      DisplayLabel = 'Discount %'
      DisplayWidth = 10
      FieldName = 'DiscPercent2'
      Origin = 'memDiscountLines.DiscPercent2'
      Visible = False
      OnChange = memDiscountLinesDiscPercent2Change
      DisplayFormat = '#.00%'
    end
    object memDiscountLinesBuyQty3: TIntegerField
      DisplayLabel = 'Buy~Qty 3'
      DisplayWidth = 10
      FieldName = 'BuyQty3'
      Origin = 'tblImportExportDiscountLines.BuyQty3'
      Visible = False
      OnChange = memDiscountLinesBuyQty3Change
    end
    object memDiscountLinesDiscPercent3: TFloatField
      DisplayWidth = 10
      FieldName = 'DiscPercent3'
      Origin = 'memDiscountLines.DiscPercent3'
      Visible = False
      OnChange = memDiscountLinesDiscPercent3Change
      DisplayFormat = '#.00%'
    end
    object memDiscountLinesTemplateID: TIntegerField
      DisplayWidth = 15
      FieldName = 'TemplateID'
      Origin = 'memDiscountLines.TemplateID'
      Visible = False
    end
    object memDiscountLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'memDiscountLines.ID'
      Visible = False
    end
    object memDiscountLinesGlobalRef: TStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'memDiscountLines.GlobalRef'
      Visible = False
      Size = 255
    end
  end
  object dsSellMarkups: TDataSource [12]
    DataSet = memSellMarkups
    Left = 696
    Top = 8
  end
  object qrySellPriceMarkups: TERPQuery [13]
    SQL.Strings = (
      'SELECT * '
      'FROM tblimportexportsellmarkups'
      'WHERE TemplateID = :xTemplateID;')
    Left = 696
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xTemplateID'
      end>
    object qrySellPriceMarkupsQty1: TIntegerField
      DisplayLabel = 'Qty 1'
      DisplayWidth = 10
      FieldName = 'Qty1'
      Origin = 'tblimportexportsellmarkups.Qty1'
    end
    object qrySellPriceMarkupsPriceMarkup1: TFloatField
      DisplayLabel = 'Sell Markup 1'
      DisplayWidth = 18
      FieldName = 'PriceMarkup1'
      Origin = 'tblimportexportsellmarkups.PriceMarkup1'
      DisplayFormat = '#.00%'
    end
    object qrySellPriceMarkupsQty2: TIntegerField
      DisplayLabel = 'Qty 2'
      DisplayWidth = 10
      FieldName = 'Qty2'
      Origin = 'tblimportexportsellmarkups.Qty2'
    end
    object qrySellPriceMarkupsPriceMarkup2: TFloatField
      DisplayLabel = 'Sell Markup 2'
      DisplayWidth = 18
      FieldName = 'PriceMarkup2'
      Origin = 'tblimportexportsellmarkups.PriceMarkup2'
      DisplayFormat = '#.00%'
    end
    object qrySellPriceMarkupsQty3: TIntegerField
      DisplayLabel = 'Qty 3'
      DisplayWidth = 10
      FieldName = 'Qty3'
      Origin = 'tblimportexportsellmarkups.Qty3'
    end
    object qrySellPriceMarkupsPriceMarkup3: TFloatField
      DisplayLabel = 'Sell Markup 3'
      DisplayWidth = 18
      FieldName = 'PriceMarkup3'
      Origin = 'tblimportexportsellmarkups.PriceMarkup3'
      DisplayFormat = '#.00%'
    end
    object qrySellPriceMarkupsWholesaleMarkup: TFloatField
      DisplayLabel = 'Wholesale Markup'
      DisplayWidth = 20
      FieldName = 'WholesaleMarkup'
      Origin = 'tblimportexportsellmarkups.WholesaleMarkup'
      DisplayFormat = '#.00%'
    end
    object qrySellPriceMarkupsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblimportexportsellmarkups.ID'
      Visible = False
    end
    object qrySellPriceMarkupsTemplateID: TIntegerField
      DisplayWidth = 15
      FieldName = 'TemplateID'
      Origin = 'tblimportexportsellmarkups.TemplateID'
      Visible = False
    end
    object qrySellPriceMarkupsGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qrySellPriceMarkupsCustomerTypeID: TIntegerField
      FieldName = 'CustomerTypeID'
    end
    object qrySellPriceMarkupsCustomerTypeName: TStringField
      FieldName = 'CustomerTypeName'
      Size = 255
    end
  end
  object memSellMarkups: TkbmMemTable [14]
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    AutoAddIndexes = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 696
    Top = 72
    object memSellMarkupsCustomerTypeName: TStringField
      DisplayLabel = 'Customer Type'
      DisplayWidth = 15
      FieldName = 'CustomerTypeName'
      Size = 255
    end
    object memSellMarkupsPriceMarkup1: TFloatField
      DisplayLabel = 'Price 1'
      DisplayWidth = 10
      FieldName = 'PriceMarkup1'
      OnChange = memSellMarkupsPriceMarkup1Change
      DisplayFormat = '#.00%'
    end
    object memSellMarkupsPriceMarkup2: TFloatField
      DisplayLabel = 'Price 2'
      DisplayWidth = 10
      FieldName = 'PriceMarkup2'
      OnChange = memSellMarkupsPriceMarkup2Change
      DisplayFormat = '#.00%'
    end
    object memSellMarkupsPriceMarkup3: TFloatField
      DisplayLabel = 'Price 3'
      DisplayWidth = 10
      FieldName = 'PriceMarkup3'
      OnChange = memSellMarkupsPriceMarkup3Change
      DisplayFormat = '#.00%'
    end
    object memSellMarkupsQty1: TIntegerField
      DisplayLabel = 'Qty 1'
      DisplayWidth = 7
      FieldName = 'Qty1'
      Visible = False
      OnChange = memSellMarkupsQty1Change
    end
    object memSellMarkupsQty2: TIntegerField
      DisplayLabel = 'Qty 2'
      DisplayWidth = 7
      FieldName = 'Qty2'
      Visible = False
      OnChange = memSellMarkupsQty2Change
    end
    object memSellMarkupsQty3: TIntegerField
      DisplayLabel = 'Qty 3'
      DisplayWidth = 7
      FieldName = 'Qty3'
      Visible = False
      OnChange = memSellMarkupsQty3Change
    end
    object memSellMarkupsWholesaleMarkup: TFloatField
      DisplayLabel = 'W/Sale Markup'
      DisplayWidth = 7
      FieldName = 'WholesaleMarkup'
      Visible = False
      DisplayFormat = '#.00%'
    end
    object memSellMarkupsCustomerTypeID: TIntegerField
      DisplayWidth = 15
      FieldName = 'CustomerTypeID'
      Visible = False
    end
    object memSellMarkupsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
    object memSellMarkupsTemplateID: TIntegerField
      DisplayWidth = 15
      FieldName = 'TemplateID'
      Visible = False
    end
    object memSellMarkupsGlobalRef: TStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
  end
  object qryClientType: TERPQuery [15]
    SQL.Strings = (
      'SELECT *'
      'FROM tblclienttype'
      'WHERE Active="T";')
    AfterOpen = qryClientTypeAfterOpen
    Left = 560
    Top = 8
    object qryClientTypeClientTypeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientTypeID'
      Origin = 'tblclienttype.ClientTypeID'
    end
    object qryClientTypeTypeName: TStringField
      FieldName = 'TypeName'
      Origin = 'tblclienttype.TypeName'
      Size = 50
    end
  end
  object qryPart: TERPQuery [17]
    SQL.Strings = (
      'SELECT '
      'PARTSID, PARTNAME'
      'FROM tblparts'
      'WHERE (Active="T" AND PARTTYPE="INV" OR PARTTYPE="NONINV")')
    AfterOpen = qryPartAfterOpen
    Left = 592
    Top = 8
  end
end
