object Form1: TForm1
  Left = 531
  Top = 121
  Caption = 'Form1'
  ClientHeight = 578
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    445
    578)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 17
    Top = 375
    Width = 249
    Height = 146
  end
  object Bevel1: TBevel
    Left = 18
    Top = 8
    Width = 399
    Height = 185
  end
  object Bevel3: TBevel
    Left = 18
    Top = 200
    Width = 399
    Height = 161
  end
  object Label1: TLabel
    Left = 30
    Top = 377
    Width = 122
    Height = 16
    Caption = 'Select Busobj file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 31
    Top = 202
    Width = 169
    Height = 16
    Caption = 'Select Mandatory Fields'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Letter_Label: TLabel
    Left = 33
    Top = 13
    Width = 101
    Height = 18
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Select Table'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
    ExplicitWidth = 115
  end
  object Label3: TLabel
    Left = 29
    Top = 426
    Width = 104
    Height = 16
    Caption = 'Select form file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label4: TLabel
    Left = 29
    Top = 474
    Width = 85
    Height = 16
    Caption = 'Class Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 275
    Top = 376
    Width = 69
    Height = 16
    Caption = 'Database'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object txtFileName: TEdit
    Left = 30
    Top = 398
    Width = 186
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object SpeedButton1: TDNMSpeedButton
    Left = 233
    Top = 399
    Width = 33
    Height = 24
    DisableTransparent = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555555555555555555555555555555555555555555555555555555555555555
      555555555555555555555555555555555555555FFFFFFFFFF555550000000000
      55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
      B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
      000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
      555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
      55555575FFF75555555555700007555555555557777555555555555555555555
      5555555555555555555555555555555555555555555555555555}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    NumGlyphs = 2
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = SpeedButton1Click
  end
  object LstTables: TListBox
    Left = 31
    Top = 31
    Width = 370
    Height = 154
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 2
    OnClick = LstTablesClick
  end
  object btnCreate: TButton
    Left = 17
    Top = 527
    Width = 97
    Height = 25
    Caption = 'Create Busobj'
    Default = True
    TabOrder = 3
    OnClick = btnCreateClick
  end
  object wwDBGrid1: TwwDBGrid
    Left = 304
    Top = 448
    Width = 121
    Height = 69
    Selected.Strings = (
      'FirstName'#9'40'#9'FirstName')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = False
    DataSource = wwDataSource1
    Options = [dgEditing, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ReadOnly = True
    TabOrder = 4
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
  end
  object FieldList: TListBox
    Left = 31
    Top = 224
    Width = 370
    Height = 129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    MultiSelect = True
    ParentFont = False
    TabOrder = 5
  end
  object Button1: TButton
    Left = 328
    Top = 536
    Width = 97
    Height = 25
    Caption = 'find Largeint fields'
    Default = True
    TabOrder = 6
    OnClick = Button1Click
  end
  object txtFormname: TEdit
    Left = 29
    Top = 447
    Width = 186
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Visible = False
  end
  object DNMSpeedButton1: TDNMSpeedButton
    Left = 233
    Top = 446
    Width = 33
    Height = 24
    DisableTransparent = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555555555555555555555555555555555555555555555555555555555555555
      555555555555555555555555555555555555555FFFFFFFFFF555550000000000
      55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
      B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
      000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
      555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
      55555575FFF75555555555700007555555555557777555555555555555555555
      5555555555555555555555555555555555555555555555555555}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    NumGlyphs = 2
    TabOrder = 8
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = DNMSpeedButton1Click
  end
  object txtClassName: TEdit
    Left = 29
    Top = 495
    Width = 186
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object edtDatabase: TEdit
    Left = 275
    Top = 398
    Width = 150
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Text = 'sample_company'
    OnExit = edtDatabaseExit
  end
  object Button2: TButton
    Left = 172
    Top = 536
    Width = 97
    Height = 25
    Caption = 'Make ERP Fix'
    Default = True
    TabOrder = 11
    OnClick = Button2Click
  end
  object MyConnection: TMyConnection
    Database = 'aus_sample_company'
    Port = 3309
    Options.KeepDesignConnected = False
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 104
    Top = 71
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'tcd'
    Filter = '2Clix Import Data (*.tcd)|*.Pas|All Files (*.*)|*.*'
    Left = 418
    Top = 17
  end
  object dsTable: TMyQuery
    Connection = MyConnection
    Left = 192
    Top = 16
  end
  object tblUser: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`tblemployees`.`FirstName`,'
      '`tblemployees`.`MiddleName`,'
      '`tblemployees`.`LastName`'
      'FROM'
      '`tblemployees`'
      'where active = '#39'T'#39
      'order by FirstName')
    Left = 368
    Top = 24
    object tblUserFirstName: TStringField
      DisplayWidth = 40
      FieldName = 'FirstName'
      Origin = 'tblemployees.FirstName'
      Size = 40
    end
    object tblUserMiddleName: TStringField
      DisplayWidth = 40
      FieldName = 'MiddleName'
      Origin = 'tblemployees.MiddleName'
      Visible = False
      Size = 40
    end
    object tblUserLastName: TStringField
      DisplayWidth = 40
      FieldName = 'LastName'
      Origin = 'tblemployees.LastName'
      Visible = False
      Size = 40
    end
  end
  object wwDataSource1: TwwDataSource
    DataSet = tblUser
    Left = 416
    Top = 32
  end
end
