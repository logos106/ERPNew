inherited PoolProfileTestListGUI: TPoolProfileTestListGUI
  Left = 163
  Top = 448
  Caption = 'Pool Tests List'
  ClientWidth = 811
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    Width = 811
  end
  inherited FooterPanel: TPanel
    Width = 811
    Color = 15527129
    inherited Label121: TLabel
      Left = 279
    end
    inherited Label3: TLabel
      Visible = False
    end
    inherited lblTotal: TLabel
      Visible = False
    end
    inherited lblTimeLabel: TLabel
      Left = 523
    end
    inherited lblTime: TLabel
      Left = 593
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 547
      Hint = ''
      Caption = '&Cancel'
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 423
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 454
      Visible = False
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 300
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 177
    end
    inherited barStatus: TStatusBar
      Width = 811
    end
    inherited pnlAdvPrinting: TDNMPanel
      Left = 275
    end
    inherited chkAdvancedPrinting: TCheckBox
      Left = 33
      Top = 35
    end
  end
  inherited HeaderPanel: TPanel
    Width = 811
    Height = 133
    Color = 15527129
    inherited lblFrom: TLabel
      Left = 586
    end
    inherited lblTo: TLabel
      Left = 709
    end
    inherited pnlHeader: TPanel
      Width = 360
      Height = 46
      inherited TitleShader: TShader
        Width = 358
        Height = 44
        inherited TitleLabel: TLabel
          Width = 358
          Height = 44
        end
      end
    end
    inherited Panel2: TPanel
      Top = 96
      Width = 811
      Color = 15527129
      ParentColor = False
      inherited grpFilters: TRadioGroup
        Width = 370
      end
    end
    inherited dtFrom: TwwDBDateTimePicker [4]
      Left = 622
    end
    inherited dtTo: TwwDBDateTimePicker [5]
      Left = 726
    end
    inherited cboDateRange: TComboBox [6]
      Left = 622
    end
    inherited Panel3: TPanel [7]
      Top = 63
      Width = 811
      Color = 15527129
      ParentColor = False
      inherited edtSearch: TEdit
        Width = 193
      end
    end
  end
  inherited Panel1: TPanel
    Top = 133
    Width = 811
    Height = 338
    inherited grdMain: TwwDBGrid
      Width = 811
      Height = 338
      ControlType.Strings = (
        'Active;CheckBox;T;F'
        'Turbidity;CheckBox;Yes;No')
      Selected.Strings = (
        'DateOfTest'#9'10'#9'Date of Test'#9'F'#9
        'Company'#9'30'#9'Client Name'#9#9
        'Street'#9'30'#9'Street'#9'F'#9
        'Street2'#9'30'#9'Street2'#9'F'#9
        'Suburb'#9'30'#9'Suburb'#9'F'#9
        'State'#9'30'#9'State'#9'F'#9
        'Country'#9'30'#9'Country'#9'F'#9
        'Postcode'#9'30'#9'Postcode'#9'F'#9
        'Phone'#9'10'#9'Phone'#9#9
        'FaxNumber'#9'10'#9'Fax number'#9#9
        'Mobile'#9'10'#9'Mobile'#9#9
        'Temperature'#9'10'#9'Temperature'#9#9
        'TDS'#9'15'#9'TDS'#9#9
        'StabilizerLevel'#9'10'#9'Stabilizer Level'#9#9
        'TotalSanitizer'#9'10'#9'Total Sanitizer'#9#9
        'FreeSanitizer'#9'10'#9'Free Sanitizer'#9#9
        'pH'#9'10'#9'pH'#9#9
        'AlkalineDemand'#9'10'#9'Alkaline Demand'#9#9
        'TotalAlkalinity'#9'10'#9'Total Alkalinity'#9#9
        'CalciumHardness'#9'10'#9'Calcium Hardness'#9#9
        'Metals'#9'10'#9'Metals'#9#9
        'Turbidity'#9'1'#9'Turbidity'#9'F'#9
        'AlgaeName'#9'10'#9'Algae Type'#9#9
        'Phosphate'#9'10'#9'Phosphate'#9#9
        'Salt'#9'10'#9'Salt'#9#9
        'Active'#9'1'#9'Active'#9#9
        'PoolTestsID'#9'15'#9'PoolTestsID'#9#9
        'Sanitizerlvl'#9'15'#9'Sanitizerlvl'#9'F'#9)
      TitleColor = 15527129
      OnDblClick = actdblClickGirdExecute
      FooterColor = 15527129
    end
  end
  inherited imgPopup: TImageList
    Left = 255
    Top = 284
  end
  inherited actlstFilters: TActionList
    object actNew: TAction
      Caption = '&New'
      OnExecute = actNewExecute
    end
    object actdblClickGird: TAction
      Caption = 'dblClickGrid'
      OnExecute = actdblClickGirdExecute
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT tblclients.Company , '
      
        'tblclients.Street, tblclients.Street2, tblclients.Suburb, tblcli' +
        'ents.State, tblclients.Country, tblclients.Postcode, '
      
        'Concat_ws('#39','#39' , tblclients.Street, tblclients.Street2, tblclient' +
        's.Suburb, tblclients.State, tblclients.Country, tblclients.Postc' +
        'ode) as Address,'
      'tblclients.Phone, tblclients.FaxNumber, tblclients.Mobile, '
      'tblpooltests.*, tblalgaedefaults.AlgaeName , tblpoolprofile.*'
      
        'FROM (tblclients INNER JOIN tblpoolprofile ON tblclients.ClientI' +
        'D = tblpoolprofile.ClientID) INNER JOIN (tblpooltests INNER JOIN' +
        ' tblalgaedefaults ON tblpooltests.AlgaeDefaultID = tblalgaedefau' +
        'lts.AlgaeDefaultID) ON tblpoolprofile.PoolProfileID = tblpooltes' +
        'ts.PoolProfileID'
      'WHERE tblpooltests.DateOfTest Between :txtfrom AND :txtto'
      'and tblpooltests.Active = '#39'T'#39)
    ParamData = <
      item
        DataType = ftString
        Name = 'txtfrom'
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'txtto'
      end>
    object qryMainDateOfTest: TDateField
      DisplayLabel = 'Date of Test'
      DisplayWidth = 10
      FieldName = 'DateOfTest'
      Origin = 'tblpooltests.DateOfTest'
    end
    object qryMainCompany: TStringField
      DisplayLabel = 'Client Name'
      DisplayWidth = 30
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object qryMainStreet: TStringField
      DisplayWidth = 30
      FieldName = 'Street'
      Origin = 'tblclients.Street'
      Size = 255
    end
    object qryMainStreet2: TStringField
      DisplayWidth = 30
      FieldName = 'Street2'
      Origin = 'tblclients.Street2'
      Size = 255
    end
    object qryMainSuburb: TStringField
      DisplayWidth = 30
      FieldName = 'Suburb'
      Origin = 'tblclients.Suburb'
      Size = 255
    end
    object qryMainState: TStringField
      DisplayWidth = 30
      FieldName = 'State'
      Origin = 'tblclients.State'
      Size = 255
    end
    object qryMainCountry: TStringField
      DisplayWidth = 30
      FieldName = 'Country'
      Origin = 'tblclients.Country'
      Size = 255
    end
    object qryMainPostcode: TStringField
      DisplayWidth = 30
      FieldName = 'Postcode'
      Origin = 'tblclients.Postcode'
      Size = 255
    end
    object qryMainPhone: TStringField
      DisplayWidth = 10
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
    end
    object qryMainFaxNumber: TStringField
      DisplayLabel = 'Fax number'
      DisplayWidth = 10
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
    end
    object qryMainMobile: TStringField
      DisplayWidth = 10
      FieldName = 'Mobile'
      Origin = 'tblclients.Mobile'
    end
    object qryMainTemperature: TFloatField
      DisplayWidth = 10
      FieldName = 'Temperature'
      Origin = 'tblpooltests.Temperature'
    end
    object qryMainTDS: TIntegerField
      DisplayWidth = 15
      FieldName = 'TDS'
      Origin = 'tblpooltests.TDS'
    end
    object qryMainStabilizerLevel: TFloatField
      DisplayLabel = 'Stabilizer Level'
      DisplayWidth = 10
      FieldName = 'StabilizerLevel'
      Origin = 'tblpooltests.StabilizerLevel'
    end
    object qryMainTotalSanitizer: TFloatField
      DisplayLabel = 'Total Sanitizer'
      DisplayWidth = 10
      FieldName = 'TotalSanitizer'
      Origin = 'tblpooltests.TotalSanitizer'
    end
    object qryMainFreeSanitizer: TFloatField
      DisplayLabel = 'Free Sanitizer'
      DisplayWidth = 10
      FieldName = 'FreeSanitizer'
      Origin = 'tblpooltests.FreeSanitizer'
    end
    object qryMainpH: TFloatField
      DisplayWidth = 10
      FieldName = 'pH'
      Origin = 'tblpooltests.pH'
    end
    object qryMainAlkalineDemand: TFloatField
      DisplayLabel = 'Alkaline Demand'
      DisplayWidth = 10
      FieldName = 'AlkalineDemand'
      Origin = 'tblpooltests.AlkalineDemand'
    end
    object qryMainTotalAlkalinity: TFloatField
      DisplayLabel = 'Total Alkalinity'
      DisplayWidth = 10
      FieldName = 'TotalAlkalinity'
      Origin = 'tblpooltests.TotalAlkalinity'
    end
    object qryMainCalciumHardness: TFloatField
      DisplayLabel = 'Calcium Hardness'
      DisplayWidth = 10
      FieldName = 'CalciumHardness'
      Origin = 'tblpooltests.CalciumHardness'
    end
    object qryMainMetals: TFloatField
      DisplayWidth = 10
      FieldName = 'Metals'
      Origin = 'tblpooltests.Metals'
    end
    object qryMainTurbidity: TStringField
      DisplayWidth = 1
      FieldName = 'Turbidity'
      Origin = 'tblpooltests.Turbidity'
      FixedChar = True
      Size = 1
    end
    object qryMainAlgaeName: TStringField
      DisplayLabel = 'Algae Type'
      DisplayWidth = 10
      FieldName = 'AlgaeName'
      Origin = 'tblalgaedefaults.AlgaeName'
      Size = 10
    end
    object qryMainPhosphate: TFloatField
      DisplayWidth = 10
      FieldName = 'Phosphate'
      Origin = 'tblpooltests.Phosphate'
    end
    object qryMainSalt: TFloatField
      DisplayWidth = 10
      FieldName = 'Salt'
      Origin = 'tblpooltests.Salt'
    end
    object qryMainActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblpooltests.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainPoolTestsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'PoolTestsID'
      Origin = 'tblpooltests.PoolTestsID'
    end
    object qryMainSanitizerlvl: TIntegerField
      DisplayWidth = 15
      FieldName = 'Sanitizerlvl'
      Origin = 'tblpoolprofile.Sanitizerlvl'
    end
    object qryMainVolume: TIntegerField
      FieldName = 'Volume'
      Origin = 'tblpoolprofile.Volume'
      Visible = False
    end
    object qryMainLocation: TStringField
      FieldName = 'Location'
      Origin = 'tblpoolprofile.Location'
      Visible = False
      Size = 10
    end
    object qryMainConstruction: TStringField
      DisplayWidth = 20
      FieldName = 'Construction'
      Origin = 'tblpoolprofile.Construction'
      Visible = False
    end
    object qryMainSanitizer: TStringField
      DisplayWidth = 20
      FieldName = 'Sanitizer'
      Origin = 'tblpoolprofile.Sanitizer'
      Visible = False
    end
    object qryMainUsesMSA: TStringField
      DisplayWidth = 1
      FieldName = 'UsesMSA'
      Origin = 'tblpoolprofile.UsesMSA'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainIsSpa: TStringField
      DisplayWidth = 1
      FieldName = 'IsSpa'
      Origin = 'tblpoolprofile.IsSpa'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainSaltRequired: TIntegerField
      DisplayWidth = 15
      FieldName = 'SaltRequired'
      Origin = 'tblpoolprofile.SaltRequired'
      Visible = False
    end
    object qryMainAlgaeDefaultID: TIntegerField
      DisplayWidth = 15
      FieldName = 'AlgaeDefaultID'
      Origin = 'tblpooltests.AlgaeDefaultID'
      Visible = False
    end
    object qryMainPoolProfileID: TIntegerField
      DisplayWidth = 15
      FieldName = 'PoolProfileID'
      Origin = 'tblpooltests.PoolProfileID'
      Visible = False
    end
    object qryMainAddress: TStringField
      DisplayWidth = 1535
      FieldName = 'Address'
      Visible = False
      Size = 1535
    end
  end
  inherited qryPersonalPrefs: TMyQuery
    Connection = MyConnection1
  end
  inherited mnuFilter: TAdvPopupMenu
    Top = 288
  end
  object qryProfile: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT tblclients.Company , '
      
        'Concat_ws('#39', '#39', tblclients.Street, tblclients.Street2, tblclient' +
        's.Suburb, tblclients.State, tblclients.Country, tblclients.Postc' +
        'ode) as Address , '
      'tblclients.Phone, tblclients.FaxNumber, tblclients.Mobile, '
      'tblpoolprofile.*,'
      'construction.Name as construct, '
      'Sanitizer.Name as Sanit'
      
        'FROM tblclients INNER JOIN tblpoolprofile ON tblclients.ClientID' +
        ' = tblpoolprofile.ClientID'
      
        'Left Outer Join tblPoolTestCategories construction on tblpoolpro' +
        'file.Construction = construction.TestCategoriesID'
      
        'Left Outer Join tblPoolTestCategories Sanitizer on tblpoolprofil' +
        'e.Sanitizer = Sanitizer.TestCategoriesID'
      'where tblpoolprofile.PoolProfileID = :PoolProfileID')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 225
    Top = 4
    ParamData = <
      item
        DataType = ftString
        Name = 'PoolProfileID'
        Value = ''
      end>
    object qryProfileCompany: TStringField
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object qryProfileAddress: TStringField
      FieldName = 'Address'
      Origin = 'tblclients.Address'
      Size = 1530
    end
    object qryProfilePhone: TStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
    end
    object qryProfileFaxNumber: TStringField
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
    end
    object qryProfileMobile: TStringField
      FieldName = 'Mobile'
      Origin = 'tblclients.Mobile'
    end
    object qryProfilePoolProfileID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PoolProfileID'
      Origin = 'tblpoolprofile.PoolProfileID'
    end
    object qryProfileClient: TStringField
      FieldName = 'Client'
      Origin = 'tblpoolprofile.Client'
      Size = 50
    end
    object qryProfileVolume: TIntegerField
      FieldName = 'Volume'
      Origin = 'tblpoolprofile.Volume'
    end
    object qryProfileLocation: TStringField
      FieldName = 'Location'
      Origin = 'tblpoolprofile.Location'
      Size = 10
    end
    object qryProfileConstruction: TStringField
      FieldName = 'Construction'
      Origin = 'tblpoolprofile.Construction'
    end
    object qryProfileSanitizer: TStringField
      FieldName = 'Sanitizer'
      Origin = 'tblpoolprofile.Sanitizer'
    end
    object qryProfileUsesMSA: TStringField
      FieldName = 'UsesMSA'
      Origin = 'tblpoolprofile.UsesMSA'
      FixedChar = True
      Size = 1
    end
    object qryProfileIsSpa: TStringField
      FieldName = 'IsSpa'
      Origin = 'tblpoolprofile.IsSpa'
      FixedChar = True
      Size = 1
    end
    object qryProfileSaltRequired: TIntegerField
      FieldName = 'SaltRequired'
      Origin = 'tblpoolprofile.SaltRequired'
    end
    object qryProfileDateEntered: TDateField
      FieldName = 'DateEntered'
      Origin = 'tblpoolprofile.DateEntered'
    end
    object qryProfileGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Origin = 'tblpoolprofile.GlobalRef'
      Size = 255
    end
    object qryProfileActive: TStringField
      FieldName = 'Active'
      Origin = 'tblpoolprofile.Active'
      FixedChar = True
      Size = 1
    end
    object qryProfileSanitizerlvl: TIntegerField
      FieldName = 'Sanitizerlvl'
      Origin = 'tblpoolprofile.Sanitizerlvl'
    end
    object qryProfileconstruct: TStringField
      FieldName = 'construct'
      Origin = 'construction.construct'
      Size = 30
    end
    object qryProfileSanit: TStringField
      FieldName = 'Sanit'
      Origin = 'Sanitizer.Sanit'
      Size = 30
    end
    object qryProfileClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblpoolprofile.ClientID'
    end
  end
end
