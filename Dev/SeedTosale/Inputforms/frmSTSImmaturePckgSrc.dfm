object fmImmaturePckgSrc: TfmImmaturePckgSrc
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  Align = alClient
  TabOrder = 0
  DesignSize = (
    451
    304)
  object lblStrain: TLabel
    Left = 80
    Top = 11
    Width = 40
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Strain'
  end
  object pnlMain: TPanel
    Left = 3
    Top = 41
    Width = 445
    Height = 259
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object pnlLeft: TPanel
      Left = 0
      Top = 0
      Width = 445
      Height = 259
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object pnlLTop: TPanel
        Left = 0
        Top = 0
        Width = 445
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        Caption = 
          'List of available  tags.  Check the tags to be placed in the pac' +
          'kage.'
        ParentColor = True
        TabOrder = 0
      end
      object wdbgrdAvailable: TwwDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 36
        Width = 439
        Height = 220
        DisableThemes = True
        DittoAttributes.Options = [wwdoSkipReadOnlyFields]
        ControlType.Strings = (
          'check;CheckBox;1;0'
          'Check;CheckBox;True;False')
        Selected.Strings = (
          'Check'#9'10'#9'Check'#9#9
          'Tag'#9'40'#9'Tag'#9#9
          'Qty'#9'10'#9'Qty'#9'F'#9
          'ActiveCount'#9'15'#9'ActiveCount'#9#9
          'PackageName'#9'60'#9'Package Name'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Align = alClient
        DataSource = dsAvailable
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = [dgEnterToTab]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize]
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
        FooterCellColor = clWhite
      end
    end
  end
  object cbbStrain: TComboBox
    Tag = -10
    Left = 126
    Top = 8
    Width = 256
    Height = 21
    Style = csDropDownList
    TabOrder = 1
    OnChange = cbbStrainChange
  end
  object dsAvailable: TDataSource
    DataSet = qry1
    Left = 128
    Top = 128
  end
  object qry1: TERPQuery
    SQL.Strings = (
      'select T.check, T.serialnumber as tag, '
      
        '(T.Plantcount - T.ChangedCount - T.WastedCount - T.Destroycount ' +
        '- T.TransferedCount - T.UsedCount) AS ActiveCount '
      'from tblststags;')
    Left = 232
    Top = 96
    object qry1Check: TBooleanField
      DisplayWidth = 10
      FieldName = 'Check'
    end
    object qry1Tag: TWideStringField
      DisplayWidth = 40
      FieldName = 'Tag'
      ReadOnly = True
    end
    object qry1Qty: TIntegerField
      DisplayWidth = 10
      FieldName = 'Qty'
    end
    object qry1ActiveCount: TLargeintField
      DisplayWidth = 15
      FieldName = 'ActiveCount'
      ReadOnly = True
    end
    object qry1PackageName: TWideStringField
      DisplayLabel = 'Package Name'
      DisplayWidth = 60
      FieldName = 'PackageName'
    end
  end
end
