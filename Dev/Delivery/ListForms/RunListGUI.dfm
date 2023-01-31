inherited RunAssignerGUI: TRunAssignerGUI
  Left = 83
  Top = 555
  Action = actAddToFilter
  Caption = 'Delivery Run List'
  OldCreateOrder = True
  OnClick = actAddToFilterExecute
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 15527129
    inherited Label3: TLabel
      Left = 5
    end
    inherited lblTotal: TLabel
      Left = 92
      Width = 53
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 716
      TabOrder = 7
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 146
      Top = -16
      TabOrder = 2
      Visible = False
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 404
      TabOrder = 3
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 300
      TabOrder = 1
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 197
      Hint = '"Customise the List"'
      TabOrder = 0
    end
    inherited pnlAdvPrinting: TDNMPanel
      TabOrder = 9
    end
    inherited chkAdvancedPrinting: TCheckBox
      Left = 6
      Top = 17
      TabOrder = 8
    end
    object btnAssign: TDNMSpeedButton
      Left = 508
      Top = 32
      Width = 87
      Height = 27
      Hint = '"Assign Selection to Run"'
      Anchors = [akBottom]
      Caption = '&Assign Run'
      DisableTransparent = False
      Enabled = False
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
      TabOrder = 4
      TabStop = False
      OnClick = btnAssignClick
    end
    object btnUnassign: TDNMSpeedButton
      Left = 612
      Top = 32
      Width = 87
      Height = 27
      Hint = '"Unassign Selection From Set Run"'
      Anchors = [akBottom]
      Caption = '&Unassign Run'
      DisableTransparent = False
      Enabled = False
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
      TabOrder = 5
      TabStop = False
      OnClick = btnUnassignClick
    end
  end
  inherited HeaderPanel: TPanel
    Color = 15527129
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Left = 225
      Caption = 'Delivery Run List'
      Color = 15527129
      ParentColor = False
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Assigned'
          'Not Assigned'
          'All')
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Color = 15527129
    object Label7: TLabel [0]
      Left = 0
      Top = 325
      Width = 998
      Height = 17
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = '"Hold Down Ctrl to Select Multiple Entries."'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited grdMain: TwwDBGrid
      Height = 325
      ControlType.Strings = (
        'RunName;CustomEdit;cboRuns;F')
      Selected.Strings = (
        'Company'#9'26'#9'Company'#9#9
        'Contact'#9'29'#9'Contact'#9#9
        'Type'#9'20'#9'Type'#9'F'
        'Address'#9'60'#9'Address'#9#9
        'RunName'#9'20'#9'Run Name'#9#9
        'Suburb'#9'20'#9'Suburb'#9'F'#9
        'Phone'#9'20'#9'Phone'#9'F'#9
        'Mobile'#9'20'#9'Mobile'#9'F'#9)
      TitleColor = 15527129
      MultiSelectOptions = [msoAutoUnselect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgRowResize]
      FooterColor = clWhite
    end
  end
  inherited dsMain: TDataSource
    Left = 836
    Top = 368
  end
  inherited dlgSave: TSaveDialog
    Left = 897
    Top = 368
  end
  inherited dlgPrint: TPdtPrintDAT
    Left = 793
    Top = 368
  end
  inherited actlstFilters: TActionList
    Left = 928
    Top = 368
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 835
    Top = 399
  end
  inherited wwLocateDialog1: TwwLocateDialog
    Left = 959
    Top = 368
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT * FROM tmp_newtable_runlistgui;')
    AutoCalcFields = False
    AfterOpen = qryMainAfterOpen
    Left = 867
    Top = 368
    object qryMainCompany: TStringField
      DisplayWidth = 26
      FieldName = 'Company'
      Origin = 'tmp_newtable_runlistgui.Company'
      Size = 255
    end
    object qryMainContact: TStringField
      DisplayWidth = 29
      FieldName = 'Contact'
      Origin = 'tmp_newtable_runlistgui.Contact'
      ReadOnly = True
      Size = 255
    end
    object qryMainType: TStringField
      DisplayWidth = 20
      FieldName = 'Type'
      Size = 255
    end
    object qryMainAddress: TStringField
      DisplayWidth = 60
      FieldName = 'Address'
      Origin = 'tmp_newtable_runlistgui.Address'
      Size = 255
    end
    object qryMainRunName: TStringField
      DisplayLabel = 'Run Name'
      DisplayWidth = 20
      FieldName = 'RunName'
      Origin = 'tmp_newtable_runlistgui.RunName'
      Size = 255
    end
    object qryMainSuburb: TStringField
      DisplayWidth = 20
      FieldName = 'Suburb'
      Origin = 'tmp_newtable_runlistgui.Suburb'
      Size = 255
    end
    object qryMainPhone: TStringField
      DisplayWidth = 20
      FieldName = 'Phone'
      Origin = 'tmp_newtable_runlistgui.Phone'
      Size = 255
    end
    object qryMainMobile: TStringField
      DisplayWidth = 20
      FieldName = 'Mobile'
      Origin = 'tmp_newtable_runlistgui.Mobile'
      Size = 255
    end
    object qryMainRunID: TIntegerField
      DisplayWidth = 15
      FieldName = 'RunID'
      Origin = 'tmp_newtable_runlistgui.RunID'
      Visible = False
    end
    object qryMainContactID: TIntegerField
      DisplayWidth = 15
      FieldName = 'ContactID'
      Origin = 'tmp_newtable_runlistgui.ContactID'
      Visible = False
    end
    object qryMainPostCode: TStringField
      DisplayWidth = 255
      FieldName = 'PostCode'
      Origin = 'tmp_newtable_runlistgui.PostCode'
      Visible = False
      Size = 32
    end
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tmp_newtable_runlistgui.ID'
      Visible = False
    end
    object qryMainClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tmp_newtable_runlistgui.ClientID'
      Visible = False
    end
    object qryMainDetails: TIntegerField
      DisplayWidth = 15
      FieldName = 'Details'
      Visible = False
    end
  end
  inherited qryPersonalPrefs: TMyQuery
    Left = 867
    Top = 399
  end
  inherited MyConnection1: TMyConnection
    Left = 9
    Top = 8
  end
  object CustomInputBox1: TCustomInputBox
    Caption = 'Enter Something'
    PasswordCharacter = #0
    EditBoxFont.Charset = DEFAULT_CHARSET
    EditBoxFont.Color = clWindowText
    EditBoxFont.Height = -11
    EditBoxFont.Name = 'MS Sans Serif'
    EditBoxFont.Style = []
    Message = 'Enter the Description of task here..'
    MessageFont.Charset = DEFAULT_CHARSET
    MessageFont.Color = clWindowText
    MessageFont.Height = -11
    MessageFont.Name = 'MS Sans Serif'
    MessageFont.Style = []
    Buttons = [sbOK, sbCancel]
    Width = 350
    Height = 150
    Color = clBtnFace
    Left = 400
    Top = 40
  end
end
