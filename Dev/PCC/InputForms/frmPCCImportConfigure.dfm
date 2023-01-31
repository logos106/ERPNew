inherited PCCImportConfigure: TPCCImportConfigure
  Left = 290
  Top = 176
  Caption = 'Import Configure'
  ClientHeight = 501
  ClientWidth = 695
  OldCreateOrder = True
  DesignSize = (
    695
    501)
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl: TPageControl [1]
    Left = 16
    Top = 56
    Width = 662
    Height = 406
    ActivePage = POS
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabIndex = 2
    TabOrder = 0
    TabWidth = 100
    object Common: TTabSheet
      Caption = 'Common'
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 654
        Height = 376
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
          654
          376)
        object Bevel1: TBevel
          Left = 8
          Top = 8
          Width = 638
          Height = 177
          Anchors = [akLeft, akTop, akRight]
          Shape = bsFrame
        end
        object Bevel2: TBevel
          Left = 8
          Top = 192
          Width = 638
          Height = 178
          Anchors = [akLeft, akTop, akRight, akBottom]
          Shape = bsFrame
        end
        object Label1: TLabel
          Left = 24
          Top = 16
          Width = 135
          Height = 15
          Caption = 'Two Clix Product Codes'
          Transparent = True
        end
        object Label2: TLabel
          Left = 24
          Top = 200
          Width = 138
          Height = 15
          Caption = 'Imported Product Codes'
          Transparent = True
        end
        object grdMaster: TwwDBGrid
          Left = 16
          Top = 32
          Width = 622
          Height = 145
          ControlType.Strings = (
            'ProductID;CustomEdit;cboProduct;T'
            'ProductCode;CustomEdit;cboProduct;F')
          Selected.Strings = (
            'ProductCode'#9'11'#9'Product Code'#9'F'#9
            'ProductName'#9'60'#9'Product Name'#9'T'#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWindow
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight]
          DataSource = dsMaster
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          OnExit = grdMasterExit
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
        end
        object grdDetail: TwwDBGrid
          Left = 16
          Top = 216
          Width = 622
          Height = 146
          Selected.Strings = (
            'ProductCode'#9'15'#9'Product Code'#9'F'
            'Description'#9'40'#9'Description'#9'F'#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWindow
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dsDetail
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
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
          OnExit = grdDetailExit
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
        end
        object cboProduct: TwwDBLookupCombo
          Left = 192
          Top = 80
          Width = 121
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ProductCode'#9'11'#9'ProductCode'#9#9
            'PartName'#9'60'#9'PartName'#9'F')
          DataField = 'ProductCode'
          DataSource = dsMaster
          LookupTable = qryProduct
          LookupField = 'ProductCode'
          ParentFont = False
          TabOrder = 2
          AutoDropDown = False
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = cboProductCloseUp
        end
      end
    end
    object StarCard: TTabSheet
      Caption = 'StarCard'
      ImageIndex = 1
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 654
        Height = 376
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
          654
          376)
        object Bevel3: TBevel
          Left = 8
          Top = 8
          Width = 225
          Height = 49
          Shape = bsFrame
        end
        object Label3: TLabel
          Left = 16
          Top = 24
          Width = 70
          Height = 15
          Caption = 'Department:'
          Transparent = True
        end
        object Bevel4: TBevel
          Left = 8
          Top = 64
          Width = 638
          Height = 297
          Anchors = [akLeft, akTop, akRight, akBottom]
          Shape = bsFrame
        end
        object Bevel5: TBevel
          Left = 240
          Top = 8
          Width = 405
          Height = 49
          Anchors = [akLeft, akTop, akRight]
          Shape = bsFrame
        end
        object Label4: TLabel
          Left = 248
          Top = 24
          Width = 135
          Height = 15
          Caption = 'Customer Custom Field:'
          Transparent = True
        end
        object Label5: TLabel
          Left = 500
          Top = 24
          Width = 48
          Height = 15
          Caption = 'Equal to:'
          Transparent = True
        end
        object cboDepartments: TwwDBLookupCombo
          Left = 96
          Top = 20
          Width = 129
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ClassName'#9'60'#9'ClassName'#9#9)
          DataField = 'DepartmentID'
          DataSource = dsImportConf
          LookupTable = qryDepartments
          LookupField = 'ClassID'
          ParentFont = False
          TabOrder = 0
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = cboDepartmentsCloseUp
        end
        object grdMatch: TwwDBGrid
          Left = 16
          Top = 72
          Width = 621
          Height = 281
          ControlType.Strings = (
            'FieldNameSource;CustomEdit;cboImportFieldNames;F'
            'FieldNameTarget;CustomEdit;cboTargetCustomFieldNames;F')
          Selected.Strings = (
            'FieldNameSource'#9'40'#9'Field Name Source'#9'F'
            'FieldNameTarget'#9'40'#9'Field Name Target'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWindow
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dsMatch
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
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
          OnExit = grdMatchExit
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
        end
        object cboImportFieldNames: TwwDBComboBox
          Left = 240
          Top = 144
          Width = 121
          Height = 23
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          AutoDropDown = True
          DataField = 'FieldNameSource'
          DataSource = dsMatch
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 2
          UnboundDataType = wwDefault
        end
        object cboTargetCustomFieldNames: TwwDBComboBox
          Left = 240
          Top = 176
          Width = 121
          Height = 23
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          AutoDropDown = True
          DataField = 'FieldNameSource'
          DataSource = dsMatch
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 3
          UnboundDataType = wwDefault
        end
        object wwDBLookupCombo1: TwwDBLookupCombo
          Left = 388
          Top = 20
          Width = 105
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Label'#9'16'#9'Label'#9#9)
          DataField = 'CustomerCustFieldNo'
          DataSource = dsImportConf
          LookupTable = qryCustomFields
          LookupField = 'FieldNo'
          ParentFont = False
          TabOrder = 4
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = cboDepartmentsCloseUp
        end
        object edtEqualTo: TwwDBEdit
          Left = 552
          Top = 20
          Width = 85
          Height = 23
          DataField = 'CustFieldEqualTo'
          DataSource = dsImportConf
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnExit = edtEqualToExit
        end
      end
    end
    object POS: TTabSheet
      Caption = 'OnQ && OPT'
      ImageIndex = 2
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 654
        Height = 376
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
          654
          376)
        object Bevel6: TBevel
          Left = 8
          Top = 8
          Width = 638
          Height = 177
          Anchors = [akLeft, akTop, akRight]
          Shape = bsFrame
        end
        object Bevel7: TBevel
          Left = 8
          Top = 192
          Width = 638
          Height = 177
          Anchors = [akLeft, akTop, akRight]
          Shape = bsFrame
        end
        object Label6: TLabel
          Left = 24
          Top = 16
          Width = 125
          Height = 15
          Caption = 'Two Clix Departments'
          Transparent = True
        end
        object Label7: TLabel
          Left = 24
          Top = 200
          Width = 142
          Height = 15
          Caption = 'Imported Location Codes'
          Transparent = True
        end
        object grdPOSMaster: TwwDBGrid
          Left = 16
          Top = 32
          Width = 621
          Height = 145
          ControlType.Strings = (
            'DepName;CustomEdit;cboPOSDepartment;F')
          Selected.Strings = (
            'DepName'#9'60'#9'Department Name'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWindow
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = dsPOSMaster
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          OnExit = grdPOSMasterExit
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
        end
        object grdPOSDetail: TwwDBGrid
          Left = 16
          Top = 216
          Width = 621
          Height = 145
          Selected.Strings = (
            'LocationCode'#9'10'#9'Location Code'
            'Description'#9'60'#9'Description'
            'Internal_DepID'#9'10'#9'Internal_DepID')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWindow
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = dsPOSDetail
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
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
          OnExit = grdPOSDetailExit
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
        end
        object cboPOSDepartment: TwwDBLookupCombo
          Left = 136
          Top = 80
          Width = 121
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          DataField = 'DepName'
          DataSource = dsPOSMaster
          LookupTable = qryPOSDepartment
          LookupField = 'ClassName'
          ParentFont = False
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = cboPOSDepartmentCloseUp
        end
      end
    end
  end
  object btnOK: TDNMSpeedButton [2]
    Left = 205
    Top = 470
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'OK'
    Default = True
    DisableTransparent = False
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
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TDNMSpeedButton [3]
    Left = 404
    Top = 470
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Cancel'
    DisableTransparent = False
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
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object pnlTitle: TDNMPanel [4]
    Left = 177
    Top = 6
    Width = 339
    Height = 45
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 335
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
      Version = '1.2.1.1'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 335
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Import Configure'
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
  object qryMaster: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PC.*, P.ProductCode'
      'FROM tblpccproductcode PC'
      'LEFT JOIN tblParts P ON PC.ProductID = P.PartsID'
      'WHERE PC.Active = "T"'
      'AND CHAR_LENGTH(TRIM(P.ProductCode)) > 0')
    Left = 545
    Top = 8
    object qryMasterProductCode: TStringField
      DisplayLabel = 'Product Code'
      DisplayWidth = 11
      FieldName = 'ProductCode'
      Origin = 'P.PRODUCTCODE'
      Size = 255
    end
    object qryMasterProductName: TStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 60
      FieldName = 'ProductName'
      Origin = 'tblpccproductcode.ProductName'
      Size = 60
    end
    object qryMasterProductID: TIntegerField
      DisplayWidth = 15
      FieldName = 'ProductID'
      Origin = 'tblpccproductcode.ProductID'
      Visible = False
    end
    object qryMasterActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblpccproductcode.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMasterGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblpccproductcode.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMastermsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblpccproductcode.msTimeStamp'
      Visible = False
    end
    object qryMasterPccProductCodeID: TIntegerField
      FieldName = 'PccProductCodeID'
      Origin = 'tblpccproductcode.PccProductCodeID'
      Visible = False
    end
  end
  object dsMaster: TDataSource
    DataSet = qryMaster
    Left = 576
    Top = 8
  end
  object qryDetail: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT IPC.*'
      'FROM tblPCCImportedProductCode IPC'
      'WHERE IPC.Active = "T"')
    OnNewRecord = qryDetailNewRecord
    MasterSource = dsMaster
    MasterFields = 'PccProductCodeID'
    DetailFields = 'PCC_ProductCode'
    Left = 545
    Top = 40
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PccProductCodeID'
        ParamType = ptInput
      end>
    object qryDetailProductCode: TStringField
      DisplayLabel = 'Product Code'
      DisplayWidth = 15
      FieldName = 'ProductCode'
      Origin = 'tblPCCImportedProductCode.ProductCode'
      Size = 255
    end
    object qryDetailDescription: TStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Origin = 'tblPCCImportedProductCode.Description'
      Size = 255
    end
    object qryDetailPCCImportedProductCodeID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'PCCImportedProductCodeID'
      Origin = 'tblPCCImportedProductCode.PCCImportedProductCodeID'
      Visible = False
    end
    object qryDetailActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblPCCImportedProductCode.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDetailPCC_ProductCode: TIntegerField
      FieldName = 'PCC_ProductCode'
      Origin = 'tblPCCImportedProductCode.PCC_ProductCode'
      Visible = False
    end
  end
  object dsDetail: TDataSource
    DataSet = qryDetail
    Left = 576
    Top = 40
  end
  object qryProduct: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PartsID, ProductCode, PartName'
      'FROM tblParts'
      'WHERE Active = "T"'
      'AND CHAR_LENGTH(TRIM(ProductCode)) > 0')
    Left = 608
    Top = 8
    object qryProductProductCode: TStringField
      DisplayWidth = 11
      FieldName = 'ProductCode'
      Size = 11
    end
    object qryProductPartName: TStringField
      DisplayWidth = 60
      FieldName = 'PartName'
      Size = 60
    end
    object qryProductPartsID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsID'
      Visible = False
    end
  end
  object qryImportConf: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblPCCImportConfigure'
      'WHERE Active = "T"')
    Left = 544
    Top = 160
    object qryImportConfDepartmentID: TIntegerField
      FieldName = 'DepartmentID'
    end
    object qryImportConfCustomerCustFieldNo: TWordField
      FieldName = 'CustomerCustFieldNo'
    end
    object qryImportConfCustFieldEqualTo: TStringField
      FieldName = 'CustFieldEqualTo'
      Size = 255
    end
  end
  object dsImportConf: TDataSource
    DataSet = qryImportConf
    Left = 576
    Top = 160
  end
  object qryDepartments: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassName, ClassID'
      'FROM tblClass'
      'WHERE Active = "T"')
    Left = 544
    Top = 192
    object qryDepartmentsClassName: TStringField
      DisplayWidth = 60
      FieldName = 'ClassName'
      Visible = False
      Size = 60
    end
    object qryDepartmentsClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
  end
  object qryMatchImportFields: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblPCCImportConfigureMatch'
      'WHERE Active = "T"')
    Left = 544
    Top = 232
    object qryMatchImportFieldsFieldNameSource: TStringField
      DisplayLabel = 'Field Name Source'
      DisplayWidth = 40
      FieldName = 'FieldNameSource'
      Size = 255
    end
    object qryMatchImportFieldsFieldNameTarget: TStringField
      DisplayLabel = 'Field Name Target'
      DisplayWidth = 40
      FieldName = 'FieldNameTarget'
      Size = 255
    end
  end
  object dsMatch: TDataSource
    DataSet = qryMatchImportFields
    Left = 576
    Top = 232
  end
  object qryCustomFields: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'CFLabel1 as Label, 1 as FieldNo'
      'FROM tblcustomfields'
      'WHERE CFCust1 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel2, 2'
      'FROM tblcustomfields'
      'WHERE CFCust2 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel3, 3'
      'FROM tblcustomfields'
      'WHERE CFCust3 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel4, 4'
      'FROM tblcustomfields'
      'WHERE CFCust4 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel5, 5'
      'FROM tblcustomfields'
      'WHERE CFCust5 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel6, 6'
      'FROM tblcustomfields'
      'WHERE CFCust6 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel7, 7'
      'FROM tblcustomfields'
      'WHERE CFCust7 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel8, 8'
      'FROM tblcustomfields'
      'WHERE CFCust8 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel9, 9'
      'FROM tblcustomfields'
      'WHERE CFCust9 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel10, 10'
      'FROM tblcustomfields'
      'WHERE CFCust10 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel11, 11'
      'FROM tblcustomfields'
      'WHERE CFCust11 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel12, 12'
      'FROM tblcustomfields'
      'WHERE CFCust12 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel13, 13'
      'FROM tblcustomfields'
      'WHERE CFCust13 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel14, 14'
      'FROM tblcustomfields'
      'WHERE CFCust14 = "T"'
      ''
      'UNION'
      ''
      'SELECT'
      'CFLabel15, 15'
      'FROM tblcustomfields'
      'WHERE CFCust15 = "T"')
    Left = 544
    Top = 272
    object qryCustomFieldsLabel: TStringField
      DisplayWidth = 16
      FieldName = 'Label'
      Size = 16
    end
    object qryCustomFieldsFieldNo: TLargeintField
      DisplayWidth = 15
      FieldName = 'FieldNo'
      Visible = False
    end
  end
  object qryPOSMaster: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ND.*, C.ClassName'
      'FROM tblPCCImpConfNativeDep ND'
      'LEFT JOIN tblClass C ON ND.DepID = C.ClassID'
      'WHERE ND.Active = "T"')
    Left = 336
    Top = 80
    object qryPOSMasterDepName: TStringField
      DisplayLabel = 'Department Name'
      DisplayWidth = 60
      FieldName = 'DepName'
      Size = 60
    end
    object qryPOSMasterPCCImpConfNativeDepID: TIntegerField
      DisplayWidth = 15
      FieldName = 'PCCImpConfNativeDepID'
      Visible = False
    end
    object qryPOSMasterDepID: TIntegerField
      DisplayWidth = 15
      FieldName = 'DepID'
      Visible = False
    end
    object qryPOSMasterActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsPOSMaster: TDataSource
    DataSet = qryPOSMaster
    Left = 368
    Top = 80
  end
  object qryPOSDetail: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DN.*'
      'FROM tblPCCImpConfImportedDepNo DN'
      'WHERE DN.Active = "T"')
    OnNewRecord = qryPOSDetailNewRecord
    MasterSource = dsPOSMaster
    MasterFields = 'PCCImpConfNativeDepID'
    DetailFields = 'Internal_DepID'
    Left = 336
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PCCImpConfNativeDepID'
      end>
    object qryPOSDetailLocationCode: TWordField
      DisplayLabel = 'Location Code'
      DisplayWidth = 10
      FieldName = 'LocationCode'
      Origin = 'tblPCCImpConfImportedDepNo.LocationCode'
    end
    object qryPOSDetailDescription: TStringField
      DisplayWidth = 60
      FieldName = 'Description'
      Origin = 'tblPCCImpConfImportedDepNo.Description'
      Size = 255
    end
    object qryPOSDetailInternal_DepID: TIntegerField
      DisplayWidth = 10
      FieldName = 'Internal_DepID'
      Origin = 'tblPCCImpConfImportedDepNo.Internal_DepID'
    end
    object qryPOSDetailPCCImpConfImportedDepNoID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'PCCImpConfImportedDepNoID'
      Origin = 'tblPCCImpConfImportedDepNo.PCCImpConfImportedDepNoID'
      Visible = False
    end
    object qryPOSDetailActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblPCCImpConfImportedDepNo.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsPOSDetail: TDataSource
    DataSet = qryPOSDetail
    Left = 368
    Top = 112
  end
  object qryPOSDepartment: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassID, ClassName'
      'FROM tblClass'
      'WHERE Active = "T"')
    Left = 400
    Top = 80
    object qryPOSDepartmentClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryPOSDepartmentClassName: TStringField
      FieldName = 'ClassName'
      Size = 60
    end
  end
end
