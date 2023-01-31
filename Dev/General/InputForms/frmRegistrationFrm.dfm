inherited frmRegistration: TfrmRegistration
  Left = 243
  Width = 781
  Height = 522
  HelpContext = 341000
  BorderIcons = [biSystemMenu]
  Caption = 'Registration'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Shape4: TShape
    Left = 15
    Top = 273
    Width = 17
    Height = 17
    HelpContext = 341001
    Shape = stCircle
  end
  object Label29: TLabel
    Left = 20
    Top = 274
    Width = 9
    Height = 13
    HelpContext = 341002
    Caption = '2.'
    Transparent = True
  end
  object DNMPanel2: TDNMPanel
    Left = 0
    Top = 0
    Width = 773
    Height = 488
    HelpContext = 341003
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
      773
      488)
    object btnContinue: TDNMSpeedButton
      Left = 339
      Top = 460
      Width = 87
      Height = 27
      HelpContext = 341004
      Caption = 'Continue'
      Default = True
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnContinueClick
    end
    object PageControl1: TPageControl
      Left = 8
      Top = 56
      Width = 755
      Height = 393
      HelpContext = 341005
      ActivePage = tsProcess
      TabHeight = 25
      TabIndex = 1
      TabOrder = 1
      TabWidth = 175
      OnDrawTab = PageControl1DrawTab
      object tsRequest: TTabSheet
        HelpContext = 341006
        Caption = '1. Request Renewed Licence'
        object DNMPanel1: TDNMPanel
          Left = 0
          Top = 0
          Width = 747
          Height = 358
          HelpContext = 341007
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 236
            Top = 168
            Width = 184
            Height = 60
            HelpContext = 341008
            Caption = 
              'Click the button below. (This will create an email text inside t' +
              'he clipboard). Then paste (Ctrl-V) into the body of a new email ' +
              'and '
            Transparent = True
            WordWrap = True
          end
          object Label2: TLabel
            Left = 236
            Top = 236
            Width = 45
            Height = 15
            HelpContext = 341009
            Caption = 'send to:'
            Transparent = True
            WordWrap = True
          end
          object Label3: TLabel
            Left = 288
            Top = 236
            Width = 192
            Height = 15
            HelpContext = 341010
            Caption = 'registration@erpaustralia.com.au'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label4: TLabel
            Left = 520
            Top = 167
            Width = 204
            Height = 30
            HelpContext = 341011
            Caption = 'You will receive  an email containing your new licence code. '
            Transparent = True
            WordWrap = True
          end
          object Label7: TLabel
            Left = 236
            Top = 251
            Width = 46
            Height = 15
            HelpContext = 341012
            Caption = 'Subject: '
            Transparent = True
            WordWrap = True
          end
          object Label8: TLabel
            Left = 289
            Top = 251
            Width = 117
            Height = 15
            HelpContext = 341013
            Caption = 'Licence Registration'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label9: TLabel
            Left = 36
            Top = 168
            Width = 114
            Height = 30
            HelpContext = 341014
            Caption = 'Complete the two fields above A and B '
            Transparent = True
            WordWrap = True
          end
          object Label10: TLabel
            Left = 176
            Top = 40
            Width = 262
            Height = 15
            HelpContext = 341015
            Caption = '(To help us issue your new licence code asap)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
            Transparent = True
          end
          object Label11: TLabel
            Left = 37
            Top = 56
            Width = 192
            Height = 15
            HelpContext = 341016
            Caption = 'Please fill in your payment details:'
            Transparent = True
          end
          object Label24: TLabel
            Left = 36
            Top = 202
            Width = 111
            Height = 45
            HelpContext = 341017
            Caption = 'Print and sign Licence Agreement Form'
            Transparent = True
            WordWrap = True
          end
          object Label25: TLabel
            Left = 36
            Top = 286
            Width = 120
            Height = 45
            HelpContext = 341018
            Caption = 'Fax Licence Agreement Form to ERP Software Pty Ltd'
            Transparent = True
            WordWrap = True
          end
          object Shape1: TShape
            Left = 14
            Top = 167
            Width = 17
            Height = 17
            HelpContext = 341019
            Shape = stCircle
          end
          object Label26: TLabel
            Left = 19
            Top = 168
            Width = 10
            Height = 15
            HelpContext = 341020
            Caption = '1.'
            Transparent = True
          end
          object Shape2: TShape
            Left = 15
            Top = 202
            Width = 17
            Height = 17
            HelpContext = 341021
            Shape = stCircle
          end
          object Label27: TLabel
            Left = 20
            Top = 203
            Width = 10
            Height = 15
            HelpContext = 341022
            Caption = '2.'
            Transparent = True
          end
          object Shape3: TShape
            Left = 14
            Top = 283
            Width = 17
            Height = 17
            HelpContext = 341023
            Shape = stCircle
          end
          object Label28: TLabel
            Left = 19
            Top = 284
            Width = 10
            Height = 15
            HelpContext = 341024
            Caption = '3.'
            Transparent = True
          end
          object Shape5: TShape
            Left = 214
            Top = 167
            Width = 17
            Height = 17
            HelpContext = 341025
            Shape = stCircle
          end
          object Label30: TLabel
            Left = 219
            Top = 168
            Width = 10
            Height = 15
            HelpContext = 341026
            Caption = '4.'
            Transparent = True
          end
          object Shape6: TShape
            Left = 499
            Top = 166
            Width = 17
            Height = 17
            HelpContext = 341027
            Shape = stCircle
          end
          object Label31: TLabel
            Left = 504
            Top = 167
            Width = 10
            Height = 15
            HelpContext = 341028
            Caption = '5.'
            Transparent = True
          end
          object Label32: TLabel
            Left = 37
            Top = 15
            Width = 264
            Height = 15
            HelpContext = 341029
            Caption = 'Required Number of Client Slots for this Server'
            Transparent = True
          end
          object Label33: TLabel
            Left = 520
            Top = 204
            Width = 194
            Height = 60
            HelpContext = 341030
            Caption = 
              'Once you have received it bring up this form again and click on ' +
              'tab  "2. Process Renewed Licence" and proceed'
            Transparent = True
            WordWrap = True
          end
          object Shape7: TShape
            Left = 15
            Top = 14
            Width = 17
            Height = 17
            HelpContext = 341031
            Shape = stCircle
          end
          object Label38: TLabel
            Left = 20
            Top = 15
            Width = 8
            Height = 15
            HelpContext = 341032
            Caption = 'A'
            Transparent = True
          end
          object Shape8: TShape
            Left = 16
            Top = 54
            Width = 17
            Height = 17
            HelpContext = 341033
            Shape = stCircle
          end
          object Label39: TLabel
            Left = 21
            Top = 55
            Width = 8
            Height = 15
            HelpContext = 341034
            Caption = 'B'
            Transparent = True
          end
          object memExistingCode: TMemo
            Left = 16
            Top = 340
            Width = 97
            Height = 73
            HelpContext = 341035
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Visible = False
            WordWrap = False
          end
          object Button1: TDNMSpeedButton
            Left = 234
            Top = 304
            Width = 121
            Height = 27
            HelpContext = 341036
            Caption = 'Email to Clipboard'
            DisableTransparent = False
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            TabOrder = 1
            OnClick = Button1Click
          end
          object memEmail: TMemo
            Left = 125
            Top = 333
            Width = 145
            Height = 65
            HelpContext = 341037
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Lines.Strings = (
              'To Licencing Officer at registration@erpaustralia.com.au  '
              ''
              '<&Date/>'
              ''
              'Please renew the Software Licence for <&CompanyName/>  '
              'This server has <&ClientSlots/> Client Slots'
              ''
              '<&PaymentDetails/>'
              ''
              ''
              '')
            ParentFont = False
            TabOrder = 2
            Visible = False
            WordWrap = False
          end
          object Memo1: TMemo
            Left = 16
            Top = 72
            Width = 713
            Height = 73
            HelpContext = 341038
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Lines.Strings = (
              'Our payment details for Software Licence / Maintenance are:'
              ''
              '')
            ParentFont = False
            TabOrder = 3
          end
          object btnPrintAgreementForm: TDNMSpeedButton
            Left = 35
            Top = 249
            Width = 121
            Height = 25
            HelpContext = 341039
            Caption = 'Print Form ...'
            DisableTransparent = False
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            TabOrder = 4
            OnClick = btnPrintAgreementFormClick
          end
          object memAgreementForm: TMemo
            Left = 296
            Top = 338
            Width = 161
            Height = 25
            HelpContext = 341040
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Courier New'
            Font.Style = []
            Lines.Strings = (
              'Company: <&CompanyName/>'
              'Address: <&Address1/>'
              '         <&Address2/>'
              '         <&City/>'
              '         <&StatePlc/>'
              '         <&Country/>'
              'Phone:   <&Phone/>'
              'Fax:     <&Fax/>'
              'ABN:     <&ABN/>'
              ''
              'Date: <&Date/>'
              ''
              'Server MID: <&ServerMid/> '
              '(This ID is unique for this Server)'
              ''
              
                'Number of Client Machines enabled at this server: <&NoClientSlot' +
                's/>'
              ''
              ''
              'I have Read and I do Accept the Terms and Conditions of'
              'the Licence Agreement.'
              ''
              ''
              ''
              '   Print Name  ________________________________'
              ''
              ''
              '   Position    ________________________________'
              ''
              ''
              ''
              ''
              ''
              '   Signature   ________________________________'
              ''
              ''
              ''
              ''
              'N.B. Please Fax to Support on (07) 5539 2701'
              '     (Licence Code cannot be issued without this)')
            ParentFont = False
            TabOrder = 5
            Visible = False
            WordWrap = False
          end
          object seNoClientSlots: TwwDBSpinEdit
            Left = 310
            Top = 12
            Width = 49
            Height = 23
            HelpContext = 341041
            Increment = 1
            MaxValue = 999
            MinValue = 1
            Value = 1
            TabOrder = 6
            UnboundDataType = wwDefault
          end
          object btnProcessEmail: TDNMSpeedButton
            Left = 519
            Top = 304
            Width = 121
            Height = 27
            HelpContext = 341042
            Caption = 'Process Email ...'
            DisableTransparent = False
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            TabOrder = 7
            OnClick = btnProcessEmailClick
          end
        end
      end
      object tsProcess: TTabSheet
        HelpContext = 341043
        Caption = '2. Process Renewed Licence'
        ImageIndex = 1
        object DNMPanel3: TDNMPanel
          Left = 0
          Top = 0
          Width = 747
          Height = 358
          HelpContext = 341044
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label5: TLabel
            Left = 16
            Top = 8
            Width = 423
            Height = 15
            HelpContext = 341045
            Caption = 
              'Copy the email text as you received it from ERP and paste it int' +
              'o field below'
            Transparent = True
          end
          object Label6: TLabel
            Left = 16
            Top = 24
            Width = 384
            Height = 15
            HelpContext = 341046
            Caption = 
              '(Modification of any character inside the marked block will inva' +
              'lidate it).'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object memRenewedCode: TMemo
            Left = 16
            Top = 56
            Width = 710
            Height = 223
            HelpContext = 341047
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = memRenewedCodeChange
          end
          object btnStoreLicence: TDNMSpeedButton
            Left = 328
            Top = 312
            Width = 87
            Height = 27
            HelpContext = 341048
            Caption = 'Store Licence'
            DisableTransparent = False
            Enabled = False
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            TabOrder = 1
            OnClick = btnStoreLicenceClick
          end
        end
      end
      object tsGenerateClient: TTabSheet
        HelpContext = 341049
        Caption = 'Generate Licence'
        ImageIndex = 2
        object DNMPanel4: TDNMPanel
          Left = 0
          Top = 0
          Width = 747
          Height = 358
          HelpContext = 341050
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label14: TLabel
            Tag = 1
            Left = 264
            Top = 232
            Width = 43
            Height = 15
            HelpContext = 341051
            Caption = 'Expires'
            Transparent = True
            Visible = False
            OnDblClick = Label14DblClick
          end
          object Label12: TLabel
            Left = 8
            Top = 3
            Width = 132
            Height = 15
            HelpContext = 341052
            Caption = 'Coded Existing Licence'
            Transparent = True
          end
          object Label13: TLabel
            Left = 153
            Top = 4
            Width = 178
            Height = 14
            HelpContext = 341053
            Caption = '(Paste received email into this memo)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object lbxml: TLabel
            Tag = 1
            Left = 16
            Top = 104
            Width = 718
            Height = 41
            HelpContext = 341054
            AutoSize = False
            Caption = '***'
            Transparent = True
            Visible = False
            WordWrap = True
          end
          object lbTblLicence: TLabel
            Left = 16
            Top = 152
            Width = 45
            Height = 15
            HelpContext = 341055
            Caption = 'Licence'
            Transparent = True
          end
          object lbxmlOut: TLabel
            Tag = 1
            Left = 16
            Top = 184
            Width = 716
            Height = 41
            HelpContext = 341056
            AutoSize = False
            Caption = '***'
            Transparent = True
            Visible = False
            WordWrap = True
          end
          object Label15: TLabel
            Tag = 1
            Left = 263
            Top = 273
            Width = 45
            Height = 15
            HelpContext = 341057
            Caption = 'Licence'
            Transparent = True
            Visible = False
          end
          object Label34: TLabel
            Left = 18
            Top = 274
            Width = 96
            Height = 15
            HelpContext = 341058
            Caption = 'Licence Selector'
            Transparent = True
          end
          object lbKey: TLabel
            Tag = 1
            Left = 439
            Top = 320
            Width = 9
            Height = 15
            HelpContext = 341059
            Caption = '...'
            Visible = False
          end
          object Label40: TLabel
            Left = 625
            Top = 339
            Width = 81
            Height = 15
            HelpContext = 341060
            Caption = 'View Internals'
            Transparent = True
          end
          object btnEncode: TDNMSpeedButton
            Left = 612
            Top = 152
            Width = 121
            Height = 27
            HelpContext = 341061
            Caption = 'Licence to Clipboard'
            DisableTransparent = False
            Enabled = False
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            TabOrder = 0
            OnClick = btnEncodeClick
          end
          object edClientID: TLabeledEdit
            Left = 16
            Top = 248
            Width = 177
            Height = 23
            HelpContext = 341062
            EditLabel.Width = 53
            EditLabel.Height = 15
            EditLabel.Caption = 'Company'
            EditLabel.Transparent = True
            LabelPosition = lpAbove
            LabelSpacing = 3
            TabOrder = 1
          end
          object luClientSystem: TwwDBLookupCombo
            Left = 16
            Top = 248
            Width = 193
            Height = 23
            HelpContext = 341064
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            LookupTable = qryClientsLookup
            LookupField = 'Company'
            Enabled = False
            ParentFont = False
            TabOrder = 2
            AutoDropDown = True
            ShowButton = True
            AllowClearKey = False
            OnChange = luClientChange
          end
          object cbInvoiceSelect: TwwDBComboBox
            Left = 16
            Top = 290
            Width = 193
            Height = 23
            HelpContext = 341065
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 400
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 3
            UnboundDataType = wwDefault
            OnChange = cbInvoiceSelectChange
            OnDropDown = cbInvoiceSelectDropDown
          end
          object memDecodedLicence: TMemo
            Left = 8
            Top = 24
            Width = 729
            Height = 76
            HelpContext = 341066
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 4
            OnChange = memDecodedLicenceChange
          end
          object edLicence: TEdit
            Tag = 1
            Left = 264
            Top = 290
            Width = 121
            Height = 23
            HelpContext = 341067
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            Text = 'edLicence'
            Visible = False
          end
          object dtExpires: TDateTimePicker
            Tag = 1
            Left = 264
            Top = 248
            Width = 97
            Height = 23
            HelpContext = 341068
            CalAlignment = dtaLeft
            Date = 38321.5464185995
            Time = 38321.5464185995
            DateFormat = dfShort
            DateMode = dmComboBox
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Kind = dtkDate
            ParseInput = False
            ParentFont = False
            TabOrder = 6
            Visible = False
          end
          object edCompanyName: TLabeledEdit
            Left = 16
            Top = 333
            Width = 177
            Height = 23
            HelpContext = 341069
            EditLabel.Width = 155
            EditLabel.Height = 15
            EditLabel.Caption = 'Company Name (on Server)'
            EditLabel.Transparent = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            LabelPosition = lpAbove
            LabelSpacing = 3
            ParentFont = False
            TabOrder = 7
          end
          object edMID: TLabeledEdit
            Tag = 1
            Left = 438
            Top = 290
            Width = 121
            Height = 23
            HelpContext = 341070
            EditLabel.Width = 62
            EditLabel.Height = 15
            EditLabel.Caption = 'Machine ID'
            EditLabel.Transparent = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            LabelPosition = lpAbove
            LabelSpacing = 3
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            Visible = False
          end
          object edLicenceID: TLabeledEdit
            Tag = 1
            Left = 438
            Top = 248
            Width = 121
            Height = 23
            HelpContext = 341071
            EditLabel.Width = 59
            EditLabel.Height = 15
            EditLabel.Caption = 'Licence ID'
            EditLabel.Transparent = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            LabelPosition = lpAbove
            LabelSpacing = 3
            ParentFont = False
            ReadOnly = True
            TabOrder = 9
            Visible = False
          end
          object edNoClientSlots: TLabeledEdit
            Tag = 1
            Left = 612
            Top = 248
            Width = 121
            Height = 23
            HelpContext = 341072
            EditLabel.Width = 82
            EditLabel.Height = 15
            EditLabel.Caption = 'No Client Slots'
            EditLabel.Transparent = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            LabelPosition = lpAbove
            LabelSpacing = 3
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
            Visible = False
          end
          object edNoMultiSites: TLabeledEdit
            Tag = 1
            Left = 612
            Top = 290
            Width = 121
            Height = 23
            HelpContext = 341073
            EditLabel.Width = 74
            EditLabel.Height = 15
            EditLabel.Caption = 'No MultiSites'
            EditLabel.Transparent = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            LabelPosition = lpAbove
            LabelSpacing = 3
            ParentFont = False
            ReadOnly = True
            TabOrder = 11
            Visible = False
          end
          object cbViewInternals: TCheckBox
            Left = 610
            Top = 339
            Width = 12
            Height = 15
            HelpContext = 341074
            Caption = 'View Internals'
            TabOrder = 12
            OnClick = cbViewInternalsClick
          end
        end
      end
      object tsAccounts: TTabSheet
        HelpContext = 341075
        Caption = 'Accounts'
        ImageIndex = 3
        object DNMPanel5: TDNMPanel
          Left = 0
          Top = 0
          Width = 747
          Height = 358
          HelpContext = 341076
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
            747
            358)
          object Label16: TLabel
            Left = 13
            Top = 11
            Width = 32
            Height = 15
            HelpContext = 341077
            Caption = 'Client'
            Transparent = True
          end
          object Label17: TLabel
            Left = 320
            Top = 11
            Width = 46
            Height = 15
            HelpContext = 341078
            Caption = 'Balance'
            Transparent = True
          end
          object Label18: TLabel
            Left = 8
            Top = 264
            Width = 322
            Height = 12
            HelpContext = 341079
            Caption = 
              'The system will issue an encoded licence when following conditio' +
              'ns are met: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label19: TLabel
            Left = 16
            Top = 278
            Width = 386
            Height = 12
            HelpContext = 341080
            Caption = 
              '1. A ERP Licence Agreement for the Server signed by the client (' +
              ' A date in "Terms signed") '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label21: TLabel
            Left = 16
            Top = 288
            Width = 142
            Height = 12
            HelpContext = 341081
            Caption = '2. The client account is in balance'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label20: TLabel
            Left = 9
            Top = 310
            Width = 311
            Height = 12
            HelpContext = 341082
            Caption = 
              '(System will issue 60day licence if date is within 32 days of Co' +
              'ntractStart'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label35: TLabel
            Left = 12
            Top = 321
            Width = 360
            Height = 12
            HelpContext = 341083
            Caption = 
              'System will issue 365day licence if date is between 33 and 344 d' +
              'ays of ContractStart'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label36: TLabel
            Left = 12
            Top = 331
            Width = 405
            Height = 12
            HelpContext = 341084
            Caption = 
              'After day 344 System will issue 365day+ licence if date is later' +
              ' than 21 days before Expiry date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label37: TLabel
            Left = 12
            Top = 341
            Width = 254
            Height = 12
            HelpContext = 341085
            Caption = 'Otherwise System will issue licence with current Expiry date)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label23: TLabel
            Left = 527
            Top = 9
            Width = 69
            Height = 15
            HelpContext = 341086
            Caption = 'Auto Invoice'
            Enabled = False
            Visible = False
          end
          object Label41: TLabel
            Left = 605
            Top = 260
            Width = 131
            Height = 45
            HelpContext = 341087
            Caption = 'Note: Number of active records must equal Server Licences'
            Transparent = True
            WordWrap = True
          end
          object Label42: TLabel
            Left = 605
            Top = 312
            Width = 119
            Height = 45
            HelpContext = 341088
            Caption = 'Deactivate when replacement licence is issued'
            Transparent = True
            WordWrap = True
          end
          object luClient: TwwDBLookupCombo
            Left = 48
            Top = 8
            Width = 241
            Height = 23
            HelpContext = 341089
            DropDownAlignment = taLeftJustify
            LookupTable = qryClientsLookup
            LookupField = 'Company'
            Style = csDropDownList
            TabOrder = 0
            AutoDropDown = True
            ShowButton = True
            AllowClearKey = False
            OnChange = luClientChange
          end
          object edBalance: TDBEdit
            Left = 368
            Top = 8
            Width = 121
            Height = 23
            HelpContext = 341090
            Color = clCream
            DataField = 'Balance'
            DataSource = dsClients
            ReadOnly = True
            TabOrder = 1
          end
          object grdLicences: TwwDBGrid
            Left = 6
            Top = 39
            Width = 731
            Height = 209
            HelpContext = 341091
            ControlType.Strings = (
              'AutoInvoice;CheckBox;T;F'
              'ServerPartsID;CustomEdit;luServer;F'
              'ClientsPartsID;CustomEdit;luClients;F'
              'ServerpartName;CustomEdit;luServer;F'
              'ClientPartName;CustomEdit;luClients;F'
              'Invoiced;CustomEdit;wwExpandButton1;F'
              'Active;CustomEdit;cbActive;T'
              'Notes;RichEdit;Notes;F')
            Selected.Strings = (
              'ID'#9'8'#9'Licence ID'#9'F'
              'ServerPrice'#9'10'#9'Server'#9'F'#9'Fee'
              'ClientPrice'#9'10'#9'Client'#9'F'#9'Fee'
              'NoClients'#9'8'#9'No Clients'#9'F'
              'YearlyMaintenancePercent'#9'10'#9'Percent'#9'F'#9'Yearly Fee'
              'AnnualFee'#9'10'#9'Annual Fee'#9'F'
              'ContractStart'#9'11'#9'Contract Start'#9'F'
              'TermsSigned'#9'11'#9'Terms Signed'#9'F'
              'Location'#9'10'#9'Location'#9'F'
              'Notes'#9'10'#9'Notes'#9'F'
              'Active'#9'5'#9'Active'#9'F'
              'NextReminderDate'#9'18'#9'NextReminderDate'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataSource = dsLicence
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = [dgAllowInsert]
            ParentFont = False
            TabOrder = 2
            TitleAlignment = taCenter
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 2
            TitleButtons = False
            UseTFields = False
            OnColExit = grdLicencesColExit
            OnExit = grdLicencesExit
          end
          object cbAutoInvoice: TwwCheckBox
            Left = 512
            Top = 8
            Width = 15
            Height = 17
            HelpContext = 341092
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
            Caption = 'AutoInvoice'
            Checked = True
            Enabled = False
            State = cbChecked
            TabOrder = 3
            Visible = False
            OnClick = cbAutoInvoiceClick
          end
          object wwDBGrid2: TwwDBGrid
            Left = 16
            Top = 104
            Width = 385
            Height = 121
            HelpContext = 341093
            ControlType.Strings = (
              'SaleID;CustomEdit;cbSaleID;F'
              'Licence;CustomEdit;cbLicence;F')
            Selected.Strings = (
              'SaleID'#9'15'#9'SaleID'#9'F'#9'Invoice Issued'
              'Expires'#9'12'#9'Expires'#9'F'#9'Invoice Issued'
              'Licence'#9'10'#9'Licence'#9'F'
              'AnnualFee'#9'10'#9'Annual Fee'#9'F'#9'Calculated')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Ctl3D = False
            DataSource = dsLicenceInvoiced
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 4
            TitleAlignment = taCenter
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 2
            TitleButtons = False
            UseTFields = False
            Visible = False
          end
          object cbSaleID: TwwDBComboBox
            Left = 40
            Top = 168
            Width = 121
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 200
            ItemHeight = 0
            Sorted = False
            TabOrder = 5
            UnboundDataType = wwDefault
            OnDropDown = cbSaleIDDropDown
            OnCloseUp = cbSaleIDCloseUp
          end
          object wwExpandButton1: TwwExpandButton
            Left = 126
            Top = 146
            Width = 97
            Height = 17
            Grid = wwDBGrid2
            AutoShrink = False
            OnBeforeExpand = wwExpandButton1BeforeExpand
            OnBeforeCollapse = wwExpandButton1BeforeCollapse
            Caption = 'wwExpandButton1'
            Color = clWhite
            DataField = 'Invoiced'
            DataSource = dsLicence
            Enabled = False
            ParentColor = False
            TabOrder = 6
          end
          object cbLicence: TwwDBComboBox
            Left = 200
            Top = 168
            Width = 121
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            ItemHeight = 0
            Items.Strings = (
              'Stage60'
              'Stage365'
              'Stage365+')
            ItemIndex = 0
            Sorted = False
            TabOrder = 7
            UnboundDataType = wwDefault
          end
          object cbActive: TwwCheckBox
            Left = 515
            Top = 102
            Width = 39
            Height = 18
            AlwaysTransparent = True
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'T'
            DisplayValueUnchecked = 'F'
            NullAndBlankState = cbUnchecked
            Indents.ButtonX = 11
            Color = clWhite
            DataField = 'Active'
            DataSource = dsLicence
            ParentColor = False
            TabOrder = 8
            OnClick = cbActiveClick
          end
          object btnAccountList: TDNMSpeedButton
            Left = 496
            Top = 295
            Width = 87
            Height = 27
            HelpContext = 341094
            Caption = 'Account List'
            DisableTransparent = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 9
            OnClick = btnAccountListClick
          end
          object Notes: TwwDBRichEdit
            Left = 437
            Top = 137
            Width = 169
            Height = 47
            AutoURLDetect = False
            DataField = 'Notes'
            DataSource = dsLicence
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            PrintJobName = 'Delphi 6'
            TabOrder = 10
            EditorCaption = 'Edit Rich Text'
            EditorPosition.Left = 0
            EditorPosition.Top = 0
            EditorPosition.Width = 0
            EditorPosition.Height = 0
            MeasurementUnits = muInches
            PrintMargins.Top = 1
            PrintMargins.Bottom = 1
            PrintMargins.Left = 1
            PrintMargins.Right = 1
            RichEditVersion = 2
            Data = {
              710000007B5C727466315C616E73695C616E7369637067313235325C64656666
              305C6465666C616E67333038317B5C666F6E7474626C7B5C66305C666E696C20
              417269616C3B7D7D0D0A5C766965776B696E64345C7563315C706172645C6630
              5C66733138204E6F7465735C7061720D0A7D0D0A00}
          end
        end
      end
    end
    object pnlTitle: TDNMPanel
      Left = 266
      Top = 6
      Width = 238
      Height = 41
      HelpContext = 341095
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 234
        Height = 37
        HelpContext = 341096
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
          Width = 234
          Height = 37
          HelpContext = 341097
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = ' Registration'
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
  object LbBlowfish: TLbBlowfish
    CipherMode = cmECB
    Left = 587
    Top = 32
  end
  object XMLDocument: TALXMLDocument
    Left = 555
    Top = 32
  end
  object qryClients: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Balance '
      'FROM tblClients '
      'WHERE tblClients.Active='#39'T'#39
      'AND tblClients.Customer='#39'T'#39' AND Length(tblClients.Company)>0'
      'AND (Company = :Company OR ClientID = :ClientID)')
    AfterOpen = qryClientsAfterOpen
    Left = 259
    Top = 32
    ParamData = <
      item
        DataType = ftString
        Name = 'Company'
      end
      item
        DataType = ftInteger
        Name = 'ClientID'
      end>
  end
  object qryClientsLookup: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company FROM tblClients'
      'WHERE tblClients.Active='#39'T'#39
      'AND tblClients.Customer='#39'T'#39' AND Length(tblClients.Company)>0'
      'ORDER BY Company;'
      '')
    Left = 51
    Top = 32
  end
  object dsClientLookup: TDataSource
    DataSet = qryClientsLookup
    Left = 83
    Top = 32
  end
  object dsClients: TDataSource
    DataSet = qryClients
    Left = 291
    Top = 32
  end
  object qryLicence: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tbllicence WHERE ClientID = :ClientID')
    AfterInsert = qryLicenceAfterInsert
    BeforePost = qryLicenceBeforePost
    AfterScroll = qryLicenceAfterScroll
    OnCalcFields = qryLicenceCalcFields
    MasterSource = dsClients
    MasterFields = 'ClientID'
    Left = 155
    Top = 32
    ParamData = <
      item
        DataType = ftString
        Name = 'ClientID'
        Value = ''
      end>
    object qryLicenceServerPrice: TFloatField
      DisplayWidth = 9
      FieldName = 'ServerPrice'
      Origin = 'tbllicence.ServerPrice'
      currency = True
    end
    object qryLicenceClientPrice: TFloatField
      DisplayWidth = 8
      FieldName = 'ClientPrice'
      Origin = 'tbllicence.ClientPrice'
      currency = True
    end
    object qryLicenceNoClients: TIntegerField
      DisplayWidth = 7
      FieldName = 'NoClients'
      Origin = 'tbllicence.NoClients'
    end
    object qryLicenceYearlyMaintenancePercent: TIntegerField
      DisplayWidth = 10
      FieldName = 'YearlyMaintenancePercent'
      Origin = 'tbllicence.YearlyMaintenancePercent'
    end
    object qryLicenceAnnualFee: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'AnnualFee'
      Calculated = True
    end
    object qryLicenceContractStart: TDateField
      DisplayWidth = 11
      FieldName = 'ContractStart'
      Origin = 'tbllicence.ContractStart'
    end
    object qryLicenceExpires: TDateField
      FieldName = 'Expires'
      Origin = 'tbllicence.Expires'
    end
    object qryLicenceTermsSigned: TDateField
      DisplayWidth = 10
      FieldName = 'TermsSigned'
      Origin = 'tbllicence.TermsSigned'
      OnValidate = qryLicenceTermsSignedValidate
    end
    object qryLicenceAutoInvoice: TStringField
      DisplayWidth = 9
      FieldName = 'AutoInvoice'
      Origin = 'tbllicence.AutoInvoice'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLicenceClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tbllicence.ClientID'
      Visible = False
    end
    object qryLicenceID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tbllicence.ID'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object qryLicenceInvoiced2: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Invoiced'
      Visible = False
      Calculated = True
    end
    object qryLicenceTodoIssued: TDateTimeField
      FieldName = 'TodoIssued'
      Origin = 'tbllicence.TodoIssued'
    end
    object qryLicenceActive: TStringField
      FieldName = 'Active'
      Origin = 'tbllicence.Active'
      FixedChar = True
      Size = 1
    end
    object qryLicenceLocation: TStringField
      FieldName = 'Location'
      Origin = 'tbllicence.Location'
      Size = 255
    end
    object qryLicenceNotes: TMemoField
      FieldName = 'Notes'
      Origin = 'tbllicence.Notes'
      BlobType = ftMemo
    end
    object qryLicenceNextReminderDate: TDateTimeField
      FieldName = 'NextReminderDate'
    end
  end
  object dsLicence: TDataSource
    DataSet = qryLicence
    Left = 187
    Top = 32
  end
  object qryLicenceInvoiced: TERPQuery
    SQL.Strings = (
      
        'SELECT Expires, SaleID, Licence, LicenceID FROM tbllicenceinvoic' +
        'ed WHERE LicenceID = :LicenceID'
      'ORDER BY Expires DESC')
    BeforePost = qryLicenceInvoicedBeforePost
    OnCalcFields = qryLicenceInvoicedCalcFields
    Left = 489
    Top = 88
    ParamData = <
      item
        DataType = ftString
        Name = 'LicenceID'
        Value = ''
      end>
    object qryLicenceInvoicedExpires: TDateField
      FieldName = 'Expires'
      Origin = 'tbllicenceinvoiced.Expires'
    end
    object qryLicenceInvoicedSaleID: TIntegerField
      FieldName = 'SaleID'
      Origin = 'tbllicenceinvoiced.SaleID'
    end
    object qryLicenceInvoicedLicenceID: TIntegerField
      FieldName = 'LicenceID'
      Origin = 'tbllicenceinvoiced.LicenceID'
    end
    object qryLicenceInvoicedAnnualFee: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'AnnualFee'
      Calculated = True
    end
    object qryLicenceInvoicedLicence: TStringField
      FieldName = 'Licence'
      Origin = 'tbllicenceinvoiced.Licence'
      Size = 50
    end
  end
  object dsLicenceInvoiced: TDataSource
    DataSet = qryLicenceInvoiced
    Left = 521
    Top = 88
  end
  object qrySaleIDLookup: TERPQuery
    SQL.Strings = (
      
        'SELECT SaleID, InvoiceDocNumber, SaleDate,TotalAmount FROM tblSa' +
        'les '
      'WHERE isInvoice = '#39'T'#39' AND ClientID = :ClientID')
    Left = 459
    Top = 32
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ClientID'
      end>
  end
  object PrintDialog1: TPrintDialog
    Left = 619
    Top = 32
  end
  object tblCompanyInformation: TMyTable
    TableName = 'tblcompanyinformation'
    FetchAll = True
    Left = 491
    Top = 32
  end
  object qryInvoiced: TERPQuery
    SQL.Strings = (
      'SELECT cl.Company, l.ID,  l.NoClients, l.Expires, l.Active'
      'FROM tbllicence AS l,  tblClients AS cl'
      'WHERE l.ClientID = :ClientID '
      '  AND cl.ClientID = l.ClientID ')
    Left = 656
    Top = 33
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ClientID'
      end>
  end
end
