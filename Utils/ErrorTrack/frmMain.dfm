object fmMain: TfmMain
  Left = 128
  Top = 213
  Caption = 'Error Tracker'
  ClientHeight = 586
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object wwDBGrid1: TwwDBGrid
    Left = 0
    Top = 21
    Width = 862
    Height = 565
    ControlType.Strings = (
      'IsFixed;CheckBox;T;F')
    Selected.Strings = (
      'DateTime'#9'18'#9'DateTime'#9'T'#9
      'VersionNo'#9'20'#9'VersionNo'#9'T'
      'Company'#9'20'#9'Company'#9'T'
      'User'#9'20'#9'User'#9'T'
      'PCName'#9'20'#9'PCName'#9'T'
      'FocusedForm'#9'20'#9'FocusedForm'#9'T'
      'FocusedControl'#9'20'#9'FocusedControl'#9'T'
      'ExceptionName'#9'20'#9'ExceptionName'#9'T'
      'ModuleName'#9'20'#9'ModuleName'#9'T'
      'ErrorText'#9'20'#9'ErrorText'#9'T'
      'Notes'#9'20'#9'Notes'#9'T'
      'IsFixed'#9'10'#9'IsFixed'#9'F'
      'ErrorType'#9'20'#9'ErrorType'#9'F')
    MemoAttributes = [mSizeable, mWordWrap, mDisableDialog]
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dsMain
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = True
    OnTitleButtonClick = wwDBGrid1TitleButtonClick
    OnDblClick = wwDBGrid1DblClick
    OnKeyDown = wwDBGrid1KeyDown
  end
  object Edit1: TEdit
    Left = 0
    Top = 0
    Width = 862
    Height = 21
    Align = alTop
    TabOrder = 1
    Text = 'Edit1'
    Visible = False
    OnKeyDown = Edit1KeyDown
  end
  object ActionList: TActionList
    Left = 104
    Top = 96
    object actClose: TAction
      Caption = 'Close'
      OnExecute = actCloseExecute
    end
    object actDownloadEmails: TAction
      Caption = 'Download Emails'
      OnExecute = actDownloadEmailsExecute
    end
    object actSelection: TAction
      Caption = 'Selection String'
      OnExecute = actSelectionExecute
    end
    object actRefresh: TAction
      Caption = 'Refresh'
      OnExecute = actRefreshExecute
    end
  end
  object MainMenu: TMainMenu
    Left = 56
    Top = 24
    object File1: TMenuItem
      Caption = 'File'
      object SelectionString1: TMenuItem
        Action = actSelection
      end
      object Refresh1: TMenuItem
        Action = actRefresh
      end
      object DownloadEmails1: TMenuItem
        Action = actDownloadEmails
      end
      object Purge1: TMenuItem
        Caption = 'Purge'
        OnClick = Purge1Click
      end
      object Close1: TMenuItem
        Action = actClose
      end
    end
  end
  object SharedConn: TMyConnection
    Database = 'ErrorTracker'
    Port = 3309
    Options.UseUnicode = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    LoginPrompt = False
    Left = 232
    Top = 40
  end
  object qryMain: TMyQuery
    Connection = SharedConn
    SQL.Strings = (
      'select * from exceptions')
    Left = 112
    Top = 24
    object qryMainDateTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DateTime'
    end
    object qryMainVersionNo: TWideStringField
      DisplayWidth = 20
      FieldName = 'VersionNo'
      Size = 255
    end
    object qryMainCompany: TWideStringField
      DisplayWidth = 20
      FieldName = 'Company'
      Size = 255
    end
    object qryMainUser: TWideStringField
      DisplayWidth = 20
      FieldName = 'User'
      Size = 255
    end
    object qryMainPCName: TWideStringField
      DisplayWidth = 20
      FieldName = 'PCName'
      Size = 255
    end
    object qryMainFocusedForm: TWideStringField
      DisplayWidth = 20
      FieldName = 'FocusedForm'
      Size = 255
    end
    object qryMainFocusedControl: TWideStringField
      DisplayWidth = 20
      FieldName = 'FocusedControl'
      Size = 255
    end
    object qryMainExceptionName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ExceptionName'
      Size = 255
    end
    object qryMainModuleName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ModuleName'
      Size = 255
    end
    object qryMainErrorText: TWideMemoField
      DisplayWidth = 20
      FieldName = 'ErrorText'
      BlobType = ftWideMemo
    end
    object qryMainNotes: TWideMemoField
      DisplayWidth = 20
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object qryMainIsFixed: TWideStringField
      DisplayWidth = 10
      FieldName = 'IsFixed'
      FixedChar = True
      Size = 1
    end
    object qryMainErrorType: TWideStringField
      DisplayWidth = 20
      FieldName = 'ErrorType'
      Size = 255
    end
    object qryMainId: TIntegerField
      DisplayWidth = 10
      FieldName = 'Id'
      Visible = False
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 160
    Top = 32
  end
  object wwMemoDialog1: TwwMemoDialog
    DataSource = dsMain
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    DlgLeft = 0
    DlgTop = 0
    DlgWidth = 561
    DlgHeight = 396
    OnCloseDialog = wwMemoDialog1CloseDialog
    Left = 424
    Top = 304
  end
  object PopupMenu1: TPopupMenu
    Left = 352
    Top = 272
    object Addfilter1: TMenuItem
      Caption = 'Add filter'
      OnClick = Addfilter1Click
    end
  end
  object ScriptMain: TERPScript
    IgnorenContinueOnError = False
    Left = 216
    Top = 160
  end
end
