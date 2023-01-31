inherited PCCGradeForm: TPCCGradeForm
  Left = 478
  Top = 241
  Caption = 'Grade'
  ClientHeight = 236
  ClientWidth = 342
  Constraints.MaxHeight = 263
  Constraints.MaxWidth = 350
  Constraints.MinHeight = 263
  Constraints.MinWidth = 350
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 342
    Height = 236
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
      342
      236)
    object Bevel1: TBevel
      Left = 45
      Top = 59
      Width = 249
      Height = 122
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 66
      Top = 112
      Width = 70
      Height = 15
      Caption = 'Grade Name'
      Transparent = True
    end
    object Label2: TLabel
      Left = 66
      Top = 148
      Width = 65
      Height = 15
      Caption = 'Description'
      Transparent = True
    end
    object Label3: TLabel
      Left = 66
      Top = 76
      Width = 52
      Height = 15
      Caption = 'Grade No'
      Transparent = True
    end
    object Label4: TLabel
      Left = 298
      Top = 199
      Width = 35
      Height = 15
      Caption = 'Active'
      Transparent = True
    end
    object btnOK: TDNMSpeedButton
      Left = 55
      Top = 198
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
      TabOrder = 3
      OnClick = btnOKClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 195
      Top = 198
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
      TabOrder = 4
      OnClick = btnCancelClick
    end
    object edtGradeName: TwwDBEdit
      Left = 148
      Top = 108
      Width = 121
      Height = 23
      DataField = 'GradeName'
      DataSource = dsGrade
      Font.Charset = DEFAULT_CHARSET
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
    object edtDesc: TwwDBEdit
      Left = 148
      Top = 144
      Width = 121
      Height = 23
      DataField = 'GradeDesc'
      DataSource = dsGrade
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBSpinEdit1: TwwDBSpinEdit
      Left = 148
      Top = 72
      Width = 121
      Height = 23
      Increment = 1
      DataField = 'GradeNo'
      DataSource = dsGrade
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      AfterDownClick = wwDBSpinEdit1AfterDownClick
    end
    object cbActive: TwwCheckBox
      Left = 308
      Top = 213
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
      DataSource = dsGrade
      TabOrder = 5
    end
    object pnlTitle: TDNMPanel
      Left = 68
      Top = 6
      Width = 204
      Height = 45
      Anchors = [akLeft, akTop, akRight]
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
        Width = 200
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
          Width = 200
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Grade'
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
  object qryGrade: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblPCCGrades'
      'WHERE GradeID = :GradeID')
    Left = 256
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GradeID'
      end>
    object qryGradeGradeNo: TIntegerField
      FieldName = 'GradeNo'
      Origin = 'tblPCCGrades.GradeNo'
    end
    object qryGradeGradeName: TStringField
      FieldName = 'GradeName'
      Origin = 'tblPCCGrades.GradeName'
      Size = 50
    end
    object qryGradeGradeDesc: TStringField
      FieldName = 'GradeDesc'
      Origin = 'tblPCCGrades.GradeDesc'
      Size = 255
    end
    object qryGradeGradeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'GradeID'
      Origin = 'tblPCCGrades.GradeID'
    end
    object qryGradeActive: TStringField
      FieldName = 'Active'
      Origin = 'tblPCCGrades.Active'
      FixedChar = True
      Size = 1
    end
  end
  object dsGrade: TDataSource
    DataSet = qryGrade
    Left = 296
    Top = 16
  end
end
