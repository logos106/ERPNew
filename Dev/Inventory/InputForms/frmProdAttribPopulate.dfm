inherited fmProdAttribPopulate: TfmProdAttribPopulate
  Left = 494
  Top = 141
  HelpContext = 635000
  Caption = 'Product Attribute Populate Details'
  ClientHeight = 403
  ClientWidth = 830
  Color = 16769217
  ExplicitLeft = 494
  ExplicitTop = 141
  ExplicitWidth = 838
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 403
    Width = 830
    ExplicitTop = 403
    ExplicitWidth = 830
    HelpContext = 635007
  end
  object SubForm: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 830
    Height = 403
    HelpContext = 635008
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    DesignSize = (
      826
      399)
    object Label1: TLabel
      Left = 24
      Top = 22
      Width = 100
      Height = 15
      HelpContext = 635001
      Caption = 'Template Product'
    end
    object Label2: TLabel
      Left = 505
      Top = 54
      Width = 111
      Height = 15
      HelpContext = 635002
      Caption = 'Details to be copied'
    end
    object Label3: TLabel
      Left = 24
      Top = 54
      Width = 132
      Height = 15
      HelpContext = 635003
      Caption = 'Products to be updated'
    end
    object Label46: TLabel
      Left = 41
      Top = 358
      Width = 53
      Height = 15
      HelpContext = 635009
      Caption = 'Select All'
      Transparent = True
    end
    object Label4: TLabel
      Left = 521
      Top = 358
      Width = 53
      Height = 15
      HelpContext = 635010
      Caption = 'Select All'
      Transparent = True
    end
    object lblProgressBar: TLabel
      Left = 0
      Top = 363
      Width = 826
      Height = 15
      HelpContext = 635011
      Align = alBottom
      Alignment = taCenter
      Caption = 'Select All'
      Transparent = True
      Visible = False
      ExplicitWidth = 53
    end
    object cboTemplateProduct: TwwDBLookupCombo
      Left = 136
      Top = 18
      Width = 345
      Height = 23
      HelpContext = 635004
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PartName'#9'60'#9'PartName'#9'F')
      LookupTable = qtyTemplateProducts
      LookupField = 'PartsId'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboTemplateProductCloseUp
    end
    object grdGroupProducts: TwwDBGrid
      Left = 24
      Top = 70
      Width = 457
      Height = 286
      HelpContext = 635005
      Selected.Strings = (
        'PartName'#9'60'#9'Part Name'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnMultiSelectRecord = grdGroupProductsMultiSelectRecord
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = DSGroupProducts
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
      ParentFont = False
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnKeyUp = grdGroupProductsKeyUp
      OnMouseUp = grdGroupProductsMouseUp
      FooterColor = clWhite
    end
    object LstProperties: TListBox
      Left = 504
      Top = 70
      Width = 313
      Height = 286
      HelpContext = 635006
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      MultiSelect = True
      ParentFont = False
      TabOrder = 2
      OnKeyPress = LstPropertiesKeyPress
      OnKeyUp = LstPropertiesKeyUp
      OnMouseDown = LstPropertiesMouseDown
    end
    object btnCreate: TDNMSpeedButton
      Left = 348
      Top = 360
      Width = 131
      Height = 27
      HelpContext = 635012
      Caption = 'Copy Details'
      Color = clWhite
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      Style = bsModern
      TabOrder = 3
      OnClick = btnCreateClick
    end
    object btnShowDetails: TDNMSpeedButton
      Left = 499
      Top = 16
      Width = 113
      Height = 27
      HelpContext = 635013
      Anchors = [akBottom]
      Caption = 'Show Details'
      Color = clWhite
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 1
      ParentColor = False
      ParentFont = False
      Style = bsModern
      TabOrder = 4
      OnClick = btnShowDetailsClick
    end
    object ProgressBar: TProgressBar
      Left = 0
      Top = 378
      Width = 826
      Height = 21
      HelpContext = 635014
      Align = alBottom
      Smooth = True
      Step = 1
      TabOrder = 5
      Visible = False
    end
    object chkSelectAll: TCheckBox
      Left = 23
      Top = 357
      Width = 13
      Height = 17
      HelpContext = 635015
      TabOrder = 6
      OnClick = chkSelectAllClick
    end
    object chkSekectAllProperties: TCheckBox
      Left = 503
      Top = 357
      Width = 13
      Height = 17
      HelpContext = 635016
      TabOrder = 7
      OnClick = chkSekectAllPropertiesClick
    end
    object btncopyFromOther: TDNMSpeedButton
      Left = 643
      Top = 16
      Width = 174
      Height = 27
      HelpContext = 635017
      Anchors = [akBottom]
      Caption = 'Copy From Other Product'
      Color = clWhite
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 1
      ParentColor = False
      ParentFont = False
      Style = bsModern
      TabOrder = 8
      OnClick = btncopyFromOtherClick
    end
  end
  object qtyTemplateProducts: TERPQuery
    Connection = fmProdAttribMain.MyConnection
    SQL.Strings = (
      'SELECT distinct P.PartsId, P.PartName '
      
        'from tblproductattributeproducts pap inner join tblParts as P on' +
        ' P.PartsId = pap.ProductID and pap.PAG_ID =:GroupID'
      'Order by PartName')
    Left = 196
    Top = 26
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GroupID'
      end>
    object qtyTemplateProductsPartName: TWideStringField
      DisplayWidth = 60
      FieldName = 'PartName'
      Size = 60
    end
    object qtyTemplateProductsPartsId: TIntegerField
      FieldName = 'PartsId'
      Visible = False
    end
  end
  object DSGroupProducts: TDataSource
    DataSet = QryGroupProducts
    Left = 275
    Top = 207
  end
  object QryGroupProducts: TERPQuery
    Connection = fmProdAttribMain.MyConnection
    SQL.Strings = (
      'SELECT distinct P.PartsId, P.PartName '
      
        'from tblproductattributeproducts pap inner join tblParts as P on' +
        ' P.PartsId = pap.ProductID and pap.PAG_ID =:GroupID'
      'Order by PartName')
    Left = 260
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GroupID'
      end>
    object QryGroupProductsPArtName: TWideStringField
      DisplayLabel = 'Part Name'
      DisplayWidth = 60
      FieldName = 'PartName'
      Origin = 'P.PartName'
      Size = 60
    end
    object QryGroupProductsPartsId: TIntegerField
      FieldName = 'PartsId'
      Origin = 'P.PartsId'
      Visible = False
    end
  end
end
