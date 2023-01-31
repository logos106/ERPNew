inherited fmEmployeeSkills: TfmEmployeeSkills
  Left = 266
  Top = 76
  HelpContext = 972001
  Caption = 'Employee Skills'
  ClientHeight = 477
  ClientWidth = 857
  ExplicitLeft = 266
  ExplicitTop = 76
  ExplicitWidth = 873
  ExplicitHeight = 516
  DesignSize = (
    857
    477)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 477
    Width = 857
    HelpContext = 972002
    ExplicitTop = 839
    ExplicitWidth = 974
  end
  inherited shapehintextra1: TShape
    Left = 45
    ExplicitLeft = 45
  end
  object pnlMain: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 857
    Height = 477
    HelpContext = 972003
    Align = alClient
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnResize = pnlMainResize
    object Splitter1: TSplitter
      Left = 1
      Top = 316
      Width = 855
      Height = 4
      Cursor = crVSplit
      HelpContext = 972015
      Align = alBottom
      Beveled = True
      OnMoved = Splitter1Moved
      ExplicitTop = 317
    end
    object pnlBottom: TDNMPanel
      Left = 1
      Top = 320
      Width = 855
      Height = 156
      HelpContext = 972016
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        855
        156)
      object Bevel3: TBevel
        Left = 3
        Top = 6
        Width = 846
        Height = 145
        HelpContext = 972007
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
      end
      object Label1: TLabel
        Left = 11
        Top = 11
        Width = 31
        Height = 15
        HelpContext = 972005
        Caption = 'Skills'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object grdemployeeskills: TwwDBGrid
        Left = 11
        Top = 29
        Width = 830
        Height = 114
        HelpContext = 972009
        ControlType.Strings = (
          'Renewed;CheckBox;T;F'
          'SkillName;CustomEdit;cboskills;F'
          'TestMethod;CustomEdit;cboTestMethod;F'
          'RenewalOptions;CustomEdit;cboRenewalOptions;F'
          'ProviderName;CustomEdit;cbosupplier;F'
          'SkillLevelName;CustomEdit;cboSkilllevel;F')
        Selected.Strings = (
          'Certificate'#9'10'#9'Certificate'#9'F'
          'SkillName'#9'10'#9'Skill'#9'F'
          'ProviderName'#9'10'#9'Provider'#9'F'
          'ScheduledDate'#9'10'#9'Date~Scheduled'#9'F'
          'CompletedDate'#9'10'#9'Completed~On'#9'F'
          'TestMethod'#9'10'#9'Test~Method'#9'F'
          'SkillLevelName'#9'10'#9'Skill~Level'#9'F'
          'SkillExpDate'#9'10'#9'Skill~Expires on'#9'F'
          'ReminderDays'#9'10'#9'Skill~Reminder Days'#9'F'
          'RenewalDate'#9'10'#9'Renewal~Date'#9'F'
          'RenewalOptions'#9'10'#9'Renewal~Options'#9'F'
          'Renewed'#9'1'#9'Renewed?'#9'F'
          'Comments'#9'10'#9'Comments'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = 14155775
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dsemployeeskills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taCenter
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = True
      end
      object cboskills: TwwDBLookupCombo
        Left = 49
        Top = 97
        Width = 139
        Height = 23
        HelpContext = 972010
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Skill'#9'20'#9'Skill'#9'F')
        DataField = 'SkillName'
        DataSource = dsemployeeskills
        LookupTable = qryskills
        LookupField = 'Skill'
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnChange = cboskillsChange
        OnCloseUp = cboskillsCloseUp
        OnNotInList = cboskillsNotInList
      end
      object cbosupplier: TwwDBLookupCombo
        Left = 194
        Top = 97
        Width = 139
        Height = 23
        HelpContext = 972011
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Company'#9'45'#9'Company'#9'F')
        DataField = 'ProviderName'
        DataSource = dsemployeeskills
        LookupTable = qrySkillProvider
        LookupField = 'company'
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnBeforeDropDown = cbosupplierBeforeDropDown
        OnCloseUp = cbosupplierCloseUp
        OnNotInList = cbosupplierNotInList
      end
      object cboTestMethod: TwwDBComboBox
        Left = 339
        Top = 97
        Width = 139
        Height = 23
        HelpContext = 972012
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        DropDownCount = 8
        ItemHeight = 0
        Items.Strings = (
          'None'#9'N'
          'Written'#9'W'
          'Practical'#9'P')
        Sorted = False
        TabOrder = 3
        UnboundDataType = wwDefault
      end
      object cboSkilllevel: TwwDBLookupCombo
        Left = 494
        Top = 97
        Width = 140
        Height = 23
        HelpContext = 972014
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'30'#9'Name'#9'F')
        DataField = 'SkillLevelName'
        DataSource = dsemployeeskills
        LookupTable = QryEmployeeskillLevels
        LookupField = 'Name'
        Style = csDropDownList
        TabOrder = 4
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnDblClick = cboSkilllevelDblClick
        OnCloseUp = cboSkilllevelCloseUp
        OnNotInList = cboSkilllevelNotInList
      end
      object cboRenewalOptions: TwwDBComboBox
        Left = 640
        Top = 97
        Width = 139
        Height = 23
        HelpContext = 972013
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        DropDownCount = 8
        ItemHeight = 0
        Items.Strings = (
          'None'#9'0'
          '1 Year'#9'1'
          '2 Years'#9'2'
          '3 Years'#9'3'
          '4 Years'#9'4'
          '5 Years'#9'5')
        Sorted = False
        TabOrder = 5
        UnboundDataType = wwDefault
      end
    end
    object pnlTop: TDNMPanel
      Left = 1
      Top = 1
      Width = 855
      Height = 315
      HelpContext = 972017
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        855
        315)
      object Bevel2: TBevel
        Left = 3
        Top = 9
        Width = 846
        Height = 300
        HelpContext = 972004
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
      end
      object Label64: TLabel
        Left = 11
        Top = 17
        Width = 73
        Height = 15
        HelpContext = 972018
        Caption = 'Attachments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label66: TLabel
        Left = 629
        Top = 16
        Width = 212
        Height = 17
        HelpContext = 972006
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Drag and drop attachments into list'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object pnlAttachments: TPanel
        Left = 11
        Top = 41
        Width = 830
        Height = 260
        HelpContext = 972008
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = clWhite
        DragMode = dmAutomatic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnDragOver = pnlAttachmentsDragOver
      end
      object Emailbtn: TDNMSpeedButton
        Left = 101
        Top = 12
        Width = 101
        Height = 27
        Caption = '&Email Selected'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = EmailbtnClick
        HelpContext = 972019
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 361
    Top = 11
  end
  inherited tmrdelay: TTimer
    Left = 280
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 312
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 560
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 592
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 224
    Top = 72
  end
  inherited imgsort: TImageList
    Left = 628
    Top = 12
    Bitmap = {
      494C01010200F000F40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 312
    Top = 126
  end
  object dsemployeeskills: TDataSource
    Left = 263
    Top = 121
  end
  object qrySkillProvider: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select S.clientId, S.company'
      'from tblclients S '
      'inner join `tblSupplierskills` SS on SS.ProviderId = S.clientId'
      'Where SS.skillid = :SkillID'
      'AND S.Active = "T"'
      'AND S.Supplier = "T"')
    Left = 330
    Top = 25
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SkillID'
      end>
    object qrySkillProvidercompany: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 30
      FieldName = 'company'
      Size = 160
    end
    object qrySkillProviderclientId: TIntegerField
      FieldName = 'clientId'
      Visible = False
    end
  end
  object qryskills: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblskills')
    Left = 442
    Top = 25
    object qryskillsSkill: TWideStringField
      DisplayWidth = 20
      FieldName = 'Skill'
      Size = 255
    end
    object qryskillsSkillID: TIntegerField
      FieldName = 'SkillID'
      Visible = False
    end
    object qryskillsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryskillsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryskillsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryskillsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryskillsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object QryEmployeeskillLevels: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select * from tblsimpletypes where typecode = '#39'EmployeeSkillLeve' +
        'l'#39' and Active ="T"')
    Left = 490
    Top = 25
    object QryEmployeeskillLevelsName: TWideStringField
      DisplayWidth = 255
      FieldName = 'Name'
      Size = 255
    end
    object QryEmployeeskillLevelsId: TIntegerField
      FieldName = 'Id'
      Visible = False
    end
    object QryEmployeeskillLevelsDescription: TWideStringField
      FieldName = 'Description'
      Visible = False
      Size = 255
    end
    object QryEmployeeskillLevelsIsDefault: TWideStringField
      FieldName = 'IsDefault'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryEmployeeskillLevelsActive: TWideStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
end
