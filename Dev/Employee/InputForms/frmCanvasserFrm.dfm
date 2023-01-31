inherited frmCanvasser: TfrmCanvasser
  Left = 253
  Top = 161
  HelpContext = 240000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Canvasser'
  ClientHeight = 457
  ClientWidth = 749
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 240001
  end
  object Label36: TLabel [1]
    Left = 665
    Top = 285
    Width = 61
    Height = 31
    HelpContext = 240002
    Alignment = taCenter
    AutoSize = False
    Caption = 'Canvasser  is Active'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label133: TLabel [2]
    Left = 420
    Top = 62
    Width = 223
    Height = 16
    HelpContext = 240003
    AutoSize = False
    Caption = '"Edit Canvasser from the Employee Screen"'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object TabCtl20: TPageControl [3]
    Left = 10
    Top = 78
    Width = 630
    Height = 373
    HelpContext = 240004
    ActivePage = History
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    RaggedRight = True
    TabHeight = 25
    TabIndex = 2
    TabOrder = 1
    TabStop = False
    TabWidth = 209
    OnChange = TabCtl20Change
    object Rep_Info: TTabSheet
      HelpContext = 240005
      Caption = '&Rep Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 622
        Height = 338
        HelpContext = 240006
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        TabStop = True
        object Box72: TBevel
          Left = 51
          Top = 157
          Width = 518
          Height = 167
          HelpContext = 240007
        end
        object Box70: TBevel
          Left = 319
          Top = 32
          Width = 247
          Height = 109
          HelpContext = 240008
        end
        object Box69: TBevel
          Left = 51
          Top = 31
          Width = 251
          Height = 109
          HelpContext = 240009
        end
        object Label25: TLabel
          Left = 41
          Top = 296
          Width = 83
          Height = 16
          HelpContext = 240010
          AutoSize = False
          Caption = 'Company:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Visible = False
          WordWrap = True
        end
        object Label27: TLabel
          Left = 60
          Top = 42
          Width = 83
          Height = 16
          HelpContext = 240011
          AutoSize = False
          Caption = 'Mr./Mrs/...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label28: TLabel
          Left = 60
          Top = 78
          Width = 83
          Height = 16
          HelpContext = 240012
          AutoSize = False
          Caption = 'First Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label29: TLabel
          Left = 60
          Top = 116
          Width = 83
          Height = 16
          HelpContext = 240013
          AutoSize = False
          Caption = 'Last Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label31: TLabel
          Left = 330
          Top = 44
          Width = 94
          Height = 16
          HelpContext = 240014
          AutoSize = False
          Caption = 'Phone Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label33: TLabel
          Left = 331
          Top = 68
          Width = 94
          Height = 16
          HelpContext = 240015
          AutoSize = False
          Caption = 'Fax Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label34: TLabel
          Left = 330
          Top = 94
          Width = 94
          Height = 16
          HelpContext = 240016
          AutoSize = False
          Caption = 'Mobile'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label35: TLabel
          Left = 330
          Top = 117
          Width = 94
          Height = 16
          HelpContext = 240017
          AutoSize = False
          Caption = 'Alt Contact:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label59: TLabel
          Left = 76
          Top = 169
          Width = 36
          Height = 16
          HelpContext = 240018
          AutoSize = False
          Caption = 'Notes:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object edtNotes: TDBMemo
          Left = 124
          Top = 169
          Width = 431
          Height = 116
          HelpContext = 240019
          DataField = 'Notes'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object DBEdit1: TDBEdit
          Left = 128
          Top = 295
          Width = 145
          Height = 23
          HelpContext = 240020
          DataField = 'Company'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Visible = False
        end
        object DBEdit2: TDBEdit
          Left = 147
          Top = 39
          Width = 49
          Height = 23
          HelpContext = 240021
          DataField = 'Title'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object DBEdit3: TDBEdit
          Left = 147
          Top = 75
          Width = 145
          Height = 23
          HelpContext = 240022
          DataField = 'FirstName'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object DBEdit4: TDBEdit
          Left = 147
          Top = 112
          Width = 145
          Height = 23
          HelpContext = 240023
          DataField = 'LastName'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object DBEdit5: TDBEdit
          Left = 419
          Top = 39
          Width = 137
          Height = 23
          HelpContext = 240024
          DataField = 'Phone'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object DBEdit6: TDBEdit
          Left = 419
          Top = 65
          Width = 137
          Height = 23
          HelpContext = 240025
          DataField = 'FaxNumber'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object DBEdit7: TDBEdit
          Left = 419
          Top = 90
          Width = 137
          Height = 23
          HelpContext = 240026
          DataField = 'Mobile'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object DBEdit8: TDBEdit
          Left = 419
          Top = 115
          Width = 137
          Height = 23
          HelpContext = 240027
          DataField = 'AltContact'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object btnAddDateTime: TDNMSpeedButton
          Left = 287
          Top = 289
          Width = 105
          Height = 27
          HelpContext = 240028
          Caption = 'Add Date && Time'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = btnAddDateTimeClick
        end
      end
    end
    object Address_Info: TTabSheet
      HelpContext = 240029
      Caption = '&Address Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 622
        Height = 338
        HelpContext = 240030
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Box76: TBevel
          Left = 350
          Top = 33
          Width = 226
          Height = 70
          HelpContext = 240031
        end
        object Box71: TBevel
          Left = 47
          Top = 33
          Width = 293
          Height = 202
          HelpContext = 240032
        end
        object Label65: TLabel
          Left = 359
          Top = 45
          Width = 32
          Height = 18
          HelpContext = 240033
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'ABN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label77: TLabel
          Left = 356
          Top = 72
          Width = 35
          Height = 18
          HelpContext = 240034
          Alignment = taRightJustify
          AutoSize = False
          caption = 'E-mail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label78: TLabel
          Left = 70
          Top = 45
          Width = 56
          Height = 18
          HelpContext = 240035
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Address'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label79: TLabel
          Left = 97
          Top = 124
          Width = 29
          Height = 18
          HelpContext = 240036
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'City:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label80: TLabel
          Left = 64
          Top = 151
          Width = 62
          Height = 18
          HelpContext = 240037
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Postcode'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label81: TLabel
          Left = 88
          Top = 177
          Width = 38
          Height = 18
          HelpContext = 240038
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'State:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label135: TLabel
          Left = 60
          Top = 71
          Width = 66
          Height = 18
          HelpContext = 240039
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Address 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblAddress3: TLabel
          Left = 60
          Top = 98
          Width = 66
          Height = 18
          HelpContext = 240040
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Address 3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblCountry: TLabel
          Left = 79
          Top = 204
          Width = 47
          Height = 15
          HelpContext = 240041
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Country'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object DBEdit9: TDBEdit
          Left = 135
          Top = 43
          Width = 193
          Height = 23
          HelpContext = 240042
          DataField = 'Street'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object DBEdit10: TDBEdit
          Left = 135
          Top = 69
          Width = 193
          Height = 23
          HelpContext = 240043
          DataField = 'Street2'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object DBEdit11: TDBEdit
          Left = 135
          Top = 149
          Width = 89
          Height = 23
          HelpContext = 240044
          DataField = 'Postcode'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object DBEdit12: TDBEdit
          Left = 135
          Top = 175
          Width = 89
          Height = 23
          HelpContext = 240045
          DataField = 'State'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object DBEdit13: TDBEdit
          Left = 399
          Top = 43
          Width = 169
          Height = 23
          HelpContext = 240046
          DataField = 'ABN'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object DBEdit14: TDBEdit
          Left = 399
          Top = 70
          Width = 169
          Height = 23
          HelpContext = 240047
          DataField = 'Email'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
        end
        object DBEdit15: TDBEdit
          Left = 135
          Top = 122
          Width = 193
          Height = 23
          HelpContext = 240048
          DataField = 'Suburb'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object txtAddress3: TDBEdit
          Left = 135
          Top = 96
          Width = 193
          Height = 23
          HelpContext = 240049
          DataField = 'Street3'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object txtCountry: TDBEdit
          Left = 135
          Top = 202
          Width = 193
          Height = 23
          HelpContext = 240050
          DataField = 'Country'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
      end
    end
    object History: TTabSheet
      HelpContext = 240051
      Caption = '&History'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 622
        Height = 338
        HelpContext = 240052
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object pnlHistory: TDNMPanel
          Left = 0
          Top = 0
          Width = 622
          Height = 338
          HelpContext = 240053
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
          object grpHistory: TRadioGroup
            Left = 0
            Top = 0
            Width = 622
            Height = 41
            HelpContext = 240054
            Align = alTop
            Color = clBtnFace
            Columns = 5
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ItemIndex = 0
            Items.Strings = (
              'Appointments'
              'Source ')
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            OnClick = grpHistoryClick
          end
        end
      end
    end
  end
  object chkActive: TDBCheckBox [4]
    Left = 688
    Top = 317
    Width = 13
    Height = 14
    HelpContext = 240055
    Color = 13168109
    DataField = 'Canvasser'
    DataSource = EmployeeSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 4
    ValueChecked = 'True;T'
    ValueUnchecked = 'False;F'
  end
  object cmdNew: TDNMSpeedButton [5]
    Left = 653
    Top = 205
    Width = 87
    Height = 27
    Hint = '"Save This Rep And Open A New Canvasser"'
    HelpContext = 240056
    Caption = '&New'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
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
    TabOrder = 2
    OnClick = cmdNewClick
  end
  object cmdNotes: TDNMSpeedButton [6]
    Left = 653
    Top = 251
    Width = 87
    Height = 27
    Hint = '"Go To The Notes Field"'
    HelpContext = 240057
    Caption = 'N&otes'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
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
    TabOrder = 3
    OnClick = cmdNotesClick
  end
  object txtTrainerID: TDBEdit [7]
    Left = 505
    Top = 23
    Width = 25
    Height = 22
    HelpContext = 240058
    TabStop = False
    DataField = 'EmployeeID'
    DataSource = cboCanvasserNameSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Visible = False
  end
  object txtTrainercode: TDBEdit [8]
    Left = 540
    Top = 23
    Width = 25
    Height = 22
    HelpContext = 240059
    TabStop = False
    DataField = 'RepCode'
    DataSource = cboCanvasserNameSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Visible = False
  end
  object EmpID: TDBEdit [9]
    Left = 572
    Top = 23
    Width = 25
    Height = 22
    HelpContext = 240060
    TabStop = False
    DataField = 'EmployeeID'
    DataSource = cboCanvasserNameSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Visible = False
  end
  object cboCanvasserName: TwwDBLookupCombo [10]
    Left = 166
    Top = 48
    Width = 251
    Height = 27
    HelpContext = 240061
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    DropDownAlignment = taLeftJustify
    LookupTable = qryCanvasser
    LookupField = 'EmployeeName'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
    OnCloseUp = cboCanvasserNameCloseUp
  end
  object cmdOk: TDNMSpeedButton [11]
    Left = 653
    Top = 114
    Width = 87
    Height = 27
    HelpContext = 240062
    Caption = '&Save'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 8
    OnClick = cmdOkClick
  end
  object cmdCancel: TDNMSpeedButton [12]
    Left = 653
    Top = 159
    Width = 87
    Height = 27
    HelpContext = 240063
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 9
    OnClick = cmdCancelClick
  end
  object pnlTitle: TDNMPanel [13]
    Left = 275
    Top = 3
    Width = 216
    Height = 42
    HelpContext = 240064
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 212
      Height = 38
      HelpContext = 240065
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
        Width = 212
        Height = 38
        HelpContext = 240066
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Canvasser'
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
  object cboCanvasserNameSrc: TDataSource
    DataSet = qryCanvasser
    Left = 38
    Top = 56
  end
  object subfrmTrainerHistorySrc: TDataSource
    DataSet = qryTrainerHistory
    Left = 670
    Top = 34
  end
  object EmployeeSrc: TDataSource
    DataSet = qryEmployee
    Left = 709
    Top = 33
  end
  object qryTrainerHistory: TERPQuery
    SQL.Strings = (
      
        'SELECT tblAppointments.CusID, tblAppointments.AppDate, tblClient' +
        's.Company, tblAppointments.FeedbackNotes, tblAppointments.Traine' +
        'rID, tblAppointments.Cancellation, tblAppointments.AppointID'
      
        'FROM tblAppointments INNER JOIN tblClients ON tblAppointments.Cu' +
        'sID=tblClients.ClientID'
      'WHERE (((tblAppointments.TrainerID)=:RepID));')
    Left = 669
    Top = 4
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RepID'
      end>
  end
  object qryEmployee: TERPQuery
    SQL.Strings = (
      
        'SELECT Company, Title, FirstName, LastName, Phone, FaxNumber, Mo' +
        'bile,'
      
        '  AltContact, Notes, Street, Street2, Street3, Suburb, Postcode,' +
        ' State, Country, ABN, Email,'
      
        'Concat(FirstName, " ", LastName) as EmployeeName, Canvasser, Edi' +
        'tedFlag  FROM tblEmployees'
      'WHERE EmployeeID = :EmpID;')
    Left = 708
    Top = 3
    ParamData = <
      item
        DataType = ftString
        Name = 'EmpID'
        Size = 255
      end>
  end
  object qryCanvasser: TERPQuery
    SQL.Strings = (
      
        'SELECT EmployeeID, Canvasser,  RepCode, Concat(FirstName, " ", L' +
        'astName) as EmployeeName, EditedFlag  FROM tblEmployees'
      'WHERE Active = '#39'T'#39
      'ORDER BY EmployeeName')
    Left = 89
    Top = 40
  end
  object memQryCanvasser: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'EmployeeID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'Canvasser'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'RepCode'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'EmployeeName'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 46
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 472
    Top = 208
    object memQryCanvasserEmployeeID: TAutoIncField
      FieldName = 'EmployeeID'
    end
    object memQryCanvasserCanvasser: TWideStringField
      FieldName = 'Canvasser'
      FixedChar = True
      Size = 1
    end
    object memQryCanvasserRepCode: TWideStringField
      FieldName = 'RepCode'
      Size = 25
    end
    object memQryCanvasserEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 46
    end
    object memQryCanvasserEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
  object memQryEmployee: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Company'
        DataType = ftString
        Size = 35
      end
      item
        Name = 'Title'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'FirstName'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'LastName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'FaxNumber'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Mobile'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AltContact'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Notes'
        DataType = ftWideMemo
      end
      item
        Name = 'Street'
        DataType = ftString
        Size = 38
      end
      item
        Name = 'Street2'
        DataType = ftString
        Size = 38
      end
      item
        Name = 'Suburb'
        DataType = ftString
        Size = 27
      end
      item
        Name = 'Postcode'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'State'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 3
      end
      item
        Name = 'ABN'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Email'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'EmployeeName'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 46
      end
      item
        Name = 'Canvasser'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 592
    Top = 272
    object memQryEmployeeCompany: TWideStringField
      FieldName = 'Company'
      Size = 35
    end
    object memQryEmployeeTitle: TWideStringField
      FieldName = 'Title'
      Size = 5
    end
    object memQryEmployeeFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 15
    end
    object memQryEmployeeLastName: TWideStringField
      FieldName = 'LastName'
      Size = 30
    end
    object memQryEmployeePhone: TWideStringField
      FieldName = 'Phone'
    end
    object memQryEmployeeFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
    end
    object memQryEmployeeMobile: TWideStringField
      FieldName = 'Mobile'
    end
    object memQryEmployeeAltContact: TWideStringField
      FieldName = 'AltContact'
      Size = 50
    end
    object memQryEmployeeNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object memQryEmployeeStreet: TWideStringField
      FieldName = 'Street'
      Size = 38
    end
    object memQryEmployeeStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 38
    end
    object memQryEmployeeSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 27
    end
    object memQryEmployeePostcode: TWideStringField
      FieldName = 'Postcode'
      Size = 4
    end
    object memQryEmployeeState: TWideStringField
      FieldName = 'State'
      FixedChar = True
      Size = 3
    end
    object memQryEmployeeABN: TWideStringField
      FieldName = 'ABN'
      Size = 15
    end
    object memQryEmployeeEmail: TWideStringField
      FieldName = 'Email'
      Size = 80
    end
    object memQryEmployeeEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 46
    end
    object memQryEmployeeCanvasser: TWideStringField
      FieldName = 'Canvasser'
      FixedChar = True
      Size = 1
    end
    object memQryEmployeeEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
end
