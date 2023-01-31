object EmployeeSkillsGUI: TEmployeeSkillsGUI
  Left = 1229
  Top = 152
  Width = 952
  Height = 648
  Caption = 'Employee Skills'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object DNMPanel1: TDNMPanel
    Left = 16
    Top = 24
    Width = 799
    Height = 393
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      799
      393)
    object Bevel1: TBevel
      Left = 8
      Top = 5
      Width = 782
      Height = 380
      Shape = bsFrame
    end
    object Label6: TLabel
      Left = 18
      Top = 14
      Width = 55
      Height = 15
      Caption = 'Skills List'
      Transparent = True
    end
    object Label11: TLabel
      Left = 17
      Top = 196
      Width = 108
      Height = 15
      Caption = 'Process Steps List'
      Transparent = True
    end
    object grdEmpSkills: TwwDBGrid
      Left = 16
      Top = 31
      Width = 764
      Height = 154
      ControlType.Strings = (
        'SkillName;CustomEdit;cboSkills;F')
      Selected.Strings = (
        'SkillName'#9'32'#9'~Description'#9'F'
        'SkillLevel'#9'8'#9'Level'#9'F'#9'Skill'
        'SkillExpDate'#9'15'#9'Expires'#9'F'#9'Skill'
        'SecurityLevel'#9'8'#9'Type'#9'F'#9'Induction'
        'SecurityExpDate'#9'15'#9'Expires'#9'F'#9'Induction')
      IniAttributes.Delimiter = ';;'
      TitleColor = 14155775
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsEmpSkills
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
      TitleButtons = False
      UseTFields = False
      object grdEmpSkillsIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 34
        AllowAllUp = True
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
        NumGlyphs = 2
        OnClick = grdEmpSkillsIButtonClick
      end
    end
    object grdEmployeeProcessSteps: TwwDBGrid
      Left = 16
      Top = 214
      Width = 764
      Height = 163
      ControlType.Strings = (
        'ProcessStep;CustomEdit;cboProcessSteps;F')
      Selected.Strings = (
        'ProcessStep'#9'32'#9'Description'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = 14155775
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsEmployeeProcessSteps
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      object grdEmployeeProcessStepsIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 22
        AllowAllUp = True
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
        NumGlyphs = 2
        OnClick = grdEmployeeProcessStepsIButtonClick
      end
    end
    object cboSkills: TwwDBLookupCombo
      Left = 40
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
        'Skill'#9'40'#9'Skill'#9'F'#9)
      DataField = 'SkillName'
      DataSource = dsEmpSkills
      LookupTable = qrySkills
      LookupField = 'Skill'
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
    end
    object cboProcessSteps: TwwDBLookupCombo
      Left = 80
      Top = 256
      Width = 121
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'30'#9'Description'#9'T')
      DataField = 'ProcessStep'
      DataSource = dsEmployeeProcessSteps
      LookupTable = qryProcessSteps
      LookupField = 'Description'
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
    end
  end
  object dsEmpSkills: TDataSource
    Left = 854
    Top = 98
  end
  object dsEmployeeProcessSteps: TDataSource
    DataSet = qryEmployeeProcessSteps
    Left = 821
    Top = 149
  end
  object qryEmployeeProcessSteps: TMyQuery
    Connection = MyConnectionSkills
    SQL.Strings = (
      'SELECT * '
      'FROM tblemployeeprocesssteps'
      'WHERE (EmployeeID = :EmployeeID) AND (Active = '#39'T'#39')')
    Left = 853
    Top = 151
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmployeeID'
      end>
    object qryEmployeeProcessStepsEmpProcessStepsID: TAutoIncField
      FieldName = 'EmpProcessStepsID'
      ReadOnly = True
      Visible = False
    end
    object qryEmployeeProcessStepsGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryEmployeeProcessStepsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryEmployeeProcessStepsEmployeeName: TStringField
      FieldName = 'EmployeeName'
      Visible = False
      Size = 255
    end
    object qryEmployeeProcessStepsProcessStepID: TIntegerField
      FieldName = 'ProcessStepID'
      Visible = False
    end
    object qryEmployeeProcessStepsProcessStep: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 32
      FieldName = 'ProcessStep'
      Size = 255
    end
    object qryEmployeeProcessStepsActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryEmployeeProcessStepsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object qrySkills: TMyQuery
    Connection = MyConnectionSkills
    SQL.Strings = (
      'SELECT SkillID, Skill FROM tblSkills'
      'ORDER BY Skill')
    Left = 840
    Top = 195
    object qrySkillsSkill: TStringField
      DisplayWidth = 40
      FieldName = 'Skill'
      Size = 255
    end
    object qrySkillsSkillID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'SkillID'
      ReadOnly = True
      Visible = False
    end
  end
  object MyConnectionSkills: TMyConnection
    Port = 3309
    Options.KeepDesignConnected = False
    LoginPrompt = False
    Left = 847
    Top = 32
  end
  object qryProcessSteps: TMyQuery
    Connection = MyConnectionSkills
    SQL.Strings = (
      'SELECT *'
      'FROM tblprocessstep'
      'WHERE IsPurchasing = '#39'F'#39
      'ORDER BY Description')
    Left = 840
    Top = 248
    object qryProcessStepsDescription: TStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Size = 255
    end
    object qryProcessStepsID: TIntegerField
      FieldName = 'ID'
    end
  end
end
