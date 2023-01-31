inherited PCCTank: TPCCTank
  Left = 410
  Top = 270
  Caption = 'Tank'
  ClientHeight = 262
  ClientWidth = 433
  OldCreateOrder = True
  DesignSize = (
    433
    262)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [1]
    Left = 56
    Top = 79
    Width = 49
    Height = 15
    Caption = 'Tank No.'
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 56
    Top = 111
    Width = 65
    Height = 15
    Caption = 'Description'
    Transparent = True
  end
  object Label3: TLabel [3]
    Left = 56
    Top = 143
    Width = 34
    Height = 15
    Caption = 'Grade'
    Transparent = True
  end
  object Label4: TLabel [4]
    Left = 56
    Top = 175
    Width = 45
    Height = 15
    Caption = 'Product'
    Transparent = True
  end
  object Bevel1: TBevel [5]
    Left = 40
    Top = 63
    Width = 353
    Height = 145
    Shape = bsFrame
  end
  object Label5: TLabel [6]
    Left = 387
    Top = 223
    Width = 35
    Height = 15
    Caption = 'Active'
    Transparent = True
  end
  object wwDBSpinEdit1: TwwDBSpinEdit [7]
    Left = 144
    Top = 75
    Width = 225
    Height = 23
    Increment = 1
    DataField = 'TankNo'
    DataSource = dsTank
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UnboundDataType = wwDefault
    AfterDownClick = wwDBSpinEdit1AfterDownClick
  end
  object wwDBEdit1: TwwDBEdit [8]
    Left = 144
    Top = 107
    Width = 225
    Height = 23
    DataField = 'TankDescription'
    DataSource = dsTank
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cboGrade: TwwDBLookupCombo [9]
    Left = 144
    Top = 139
    Width = 225
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'GradeName'#9'20'#9'GradeName'#9'F'
      'GradeDesc'#9'20'#9'GradeDesc'#9'F')
    DataField = 'GradeID'
    DataSource = dsTank
    LookupTable = qryGrades
    LookupField = 'GradeID'
    ParentFont = False
    TabOrder = 2
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
  end
  object cboProduct: TwwDBLookupCombo [10]
    Left = 144
    Top = 171
    Width = 225
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'PartName'#9'40'#9'PartName'#9'F')
    DataField = 'ProductID'
    DataSource = dsTank
    LookupTable = qryProducts
    LookupField = 'PartsID'
    ParentFont = False
    TabOrder = 3
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
  end
  object btnOK: TDNMSpeedButton [11]
    Left = 82
    Top = 225
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
    TabOrder = 4
    OnClick = btnOKClick
  end
  object btnCancel: TDNMSpeedButton [12]
    Left = 257
    Top = 225
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
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object cbActive: TwwCheckBox [13]
    Left = 398
    Top = 237
    Width = 15
    Height = 15
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
    DataField = 'Active'
    DataSource = dsTank
    TabOrder = 6
  end
  object pnlTitle: TDNMPanel [14]
    Left = 101
    Top = 6
    Width = 238
    Height = 45
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
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
        Width = 234
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Tank'
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
  inherited MyConnection: TMyConnection
    Left = 105
  end
  object qryTank: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblPCCTanks'
      'WHERE TankID = :TankID')
    Left = 328
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TankID'
      end>
    object qryTankTankNo: TIntegerField
      FieldName = 'TankNo'
      Origin = 'tblPCCTanks.TankNo'
    end
    object qryTankTankDescription: TStringField
      FieldName = 'TankDescription'
      Origin = 'tblPCCTanks.TankDescription'
      Size = 255
    end
    object qryTankGradeID: TIntegerField
      FieldName = 'GradeID'
      Origin = 'tblPCCTanks.GradeID'
    end
    object qryTankProductID: TIntegerField
      FieldName = 'ProductID'
      Origin = 'tblPCCTanks.ProductID'
    end
    object qryTankActive: TStringField
      FieldName = 'Active'
      Origin = 'tblPCCTanks.Active'
      FixedChar = True
      Size = 1
    end
    object qryTankTankID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TankID'
      Origin = 'tblPCCTanks.TankID'
    end
  end
  object dsTank: TDataSource
    DataSet = qryTank
    Left = 360
    Top = 8
  end
  object qryGrades: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblPCCGrades')
    Left = 389
    Top = 87
    object qryGradesGradeName: TStringField
      DisplayWidth = 20
      FieldName = 'GradeName'
      Size = 50
    end
    object qryGradesGradeDesc: TStringField
      DisplayWidth = 20
      FieldName = 'GradeDesc'
      Size = 255
    end
    object qryGradesGradeID: TIntegerField
      DisplayWidth = 15
      FieldName = 'GradeID'
      Visible = False
    end
  end
  object qryProducts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PartName, PartsID'
      'FROM tblParts')
    Left = 389
    Top = 119
    object qryProductsPartName: TStringField
      DisplayWidth = 40
      FieldName = 'PartName'
      Size = 60
    end
    object qryProductsPartsID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsID'
      Visible = False
    end
  end
end
