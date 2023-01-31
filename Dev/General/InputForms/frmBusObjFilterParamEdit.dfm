inherited fmBusObjFilterParamEdit: TfmBusObjFilterParamEdit
  Left = 298
  Caption = 'Filter Balameters'
  ClientHeight = 402
  ClientWidth = 781
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object pnlTop: TPanel [1]
    Left = 0
    Top = 0
    Width = 781
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      781
      57)
    object lblFilterName: TLabel
      Left = 24
      Top = 8
      Width = 738
      Height = 25
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblFilterName'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblFilterDescription: TLabel
      Left = 8
      Top = 32
      Width = 762
      Height = 25
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblFilterDescription'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 361
    Width = 781
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      781
      41)
    object btnOk: TDNMSpeedButton
      Left = 28
      Top = 6
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = 'Ok'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = btnOkClick
    end
  end
  object wwDBGrid1: TwwDBGrid [3]
    Left = 0
    Top = 57
    Width = 781
    Height = 304
    Selected.Strings = (
      'ParamName'#9'20'#9'ParamName'#9#9
      'Description'#9'80'#9'Description'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dsFilterParams
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    object wwDBGrid1IButton: TwwIButton
      Left = 0
      Top = 0
      Width = 18
      Height = 22
      AllowAllUp = True
      OnClick = wwDBGrid1IButtonClick
    end
  end
  inherited DataState: TDataState
    Top = 64
  end
  object qryFilterParams: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblBusObjFilterParam')
    BeforePost = qryFilterParamsBeforePost
    Left = 232
    Top = 64
    object qryFilterParamsParamName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ParamName'
      Size = 255
    end
    object qryFilterParamsDescription: TWideStringField
      DisplayWidth = 80
      FieldName = 'Description'
      Size = 255
    end
    object qryFilterParamsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryFilterParamsBusObjFilterParamID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BusObjFilterParamID'
      Visible = False
    end
    object qryFilterParamsBusObjFilterID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BusObjFilterID'
      Visible = False
    end
    object qryFilterParamsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
  end
  object dsFilterParams: TDataSource
    DataSet = qryFilterParams
    Left = 296
    Top = 80
  end
end
