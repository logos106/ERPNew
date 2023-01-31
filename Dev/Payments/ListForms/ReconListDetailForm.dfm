inherited ReconListDetailFormGUI: TReconListDetailFormGUI
  Left = 186
  Top = 284
  HelpContext = 732000
  Caption = 'Reconciliation List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TDnMPanel
    HelpContext = 732001
    inherited lblTimeLabel: TLabel
      Left = 892
      Top = 10
      HelpContext = 732002
    end
    inherited lblTime: TLabel
      Left = 972
      Top = 10
      HelpContext = 732003
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 732004
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 732005
    inherited lblFrom: TLabel
      HelpContext = 732006
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 732007
      Visible = False
    end
    object Label6: TLabel [2]
      Left = 8
      Top = 15
      Width = 115
      Height = 14
      HelpContext = 732025
      Caption = 'Account to Reconcile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblProgress: TLabel [3]
      Left = 176
      Top = 16
      Width = 19
      Height = 13
      HelpContext = 732026
      Alignment = taCenter
      AutoSize = False
      Caption = 'All'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited pnlHeader: TPanel
      HelpContext = 732008
      inherited TitleShader: TShader
        HelpContext = 732009
        inherited TitleLabel: TLabel
          HelpContext = 732010
          Caption = 'Reconciliation List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 732011
      DesignSize = (
        998
        37)
      inherited grpFilters: TwwRadioGroup
        Left = 520
        Width = 54
        HelpContext = 732012
        Align = alNone
        Visible = False
      end
      object btnHidetotals: TDNMSpeedButton
        Left = 891
        Top = 6
        Width = 87
        Height = 27
        HelpContext = 732013
        Anchors = [akBottom]
        Caption = 'Hide Totals'
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
        TabOrder = 2
        TabStop = False
        OnClick = btnHidetotalsClick
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 732014
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 732015
      Visible = False
    end
    object cboAccount: TwwDBLookupCombo
      Left = 6
      Top = 30
      Width = 165
      Height = 23
      HelpContext = 732027
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'25'#9'AccountName'#9'F'
        'AccountType'#9'15'#9'AccountType'#9'F')
      DataField = 'AccountID'
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      Style = csDropDownList
      ParentFont = False
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = cboAccountCloseUp
      OnEnter = cboAccountEnter
    end
    object chkAllAccounts: TwwCheckBox
      Left = 178
      Top = 35
      Width = 11
      Height = 13
      HelpContext = 732028
      AlwaysTransparent = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'All'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ShowText = False
      State = cbChecked
      TabOrder = 8
      OnClick = chkAllAccountsClick
    end
  end
  inherited Panel1: TPanel
    Height = 305
    HelpContext = 732016
    inherited grdMain: TwwDBGrid
      Height = 305
      HelpContext = 732017
      Selected.Strings = (
        'Category'#9'11'#9'Category'#9#9
        'company'#9'21'#9'Company'#9'F'#9
        'ReconciliationID'#9'10'#9'Reconciliation#'#9#9
        'PaymentID'#9'10'#9'Payment#'#9#9
        'DepositLineID'#9'10'#9'Deposit Line#'#9#9
        'Reference'#9'10'#9'Reference'#9#9
        'Payee'#9'10'#9'Payee'#9#9
        'DepositDate'#9'10'#9'Deposit Date'#9#9
        'Notes'#9'15'#9'Notes'#9#9
        'RAccountId'#9'10'#9'RAccountId'#9'F'#9
        'cAmount'#9'10'#9'Amount'#9'F'#9
        'AccountName'#9'50'#9'AccountName'#9'F'#9)
    end
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 434
    Width = 998
    Height = 37
    HelpContext = 732018
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 3
    Transparent = False
    object Label4: TLabel
      Left = 288
      Top = 12
      Width = 74
      Height = 15
      HelpContext = 732019
      Caption = 'Total Deposit'
      Transparent = True
    end
    object Label5: TLabel
      Left = 528
      Top = 12
      Width = 96
      Height = 15
      HelpContext = 732020
      Caption = 'Total Withdrawal'
      Transparent = True
    end
    object Label7: TLabel
      Left = 820
      Top = 12
      Width = 46
      Height = 15
      HelpContext = 732021
      Caption = 'Balance'
      Transparent = True
    end
    object edtTotd: TEdit
      Left = 376
      Top = 8
      Width = 121
      Height = 23
      HelpContext = 732022
      ReadOnly = True
      TabOrder = 0
      Text = 'edttotd'
    end
    object edtTotw: TEdit
      Left = 640
      Top = 8
      Width = 121
      Height = 23
      HelpContext = 732023
      ReadOnly = True
      TabOrder = 1
      Text = 'edtTotw'
    end
    object edtTotb: TEdit
      Left = 872
      Top = 6
      Width = 121
      Height = 23
      HelpContext = 732024
      ReadOnly = True
      TabOrder = 2
      Text = 'edtTotw'
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      
        'Select 2 details, '#39'Withdrawals'#39' as Category, ReconciliationLineI' +
        'D,'
      'RW.ReconciliationID,'
      'RW.PaymentID,'
      'RW.Reference,'
      'RW.Payee,'
      'RW.DepositDate,'
      'RW.AccountID,'
      'RW.Amount,'
      'RW.Notes,'
      'RW.Deposited,'
      'RW.Reconciled,'
      'RW.DepositLineID,'
      'RW.ClientID, c.company, R.AccountId RAccountId , '
      'COA.AccountName '
      'from tblreconciliation R'
      
        'Inner join  tblreconciliationwithdrawallines RW on R.Reconciliat' +
        'ionID = RW.ReconciliationID'
      'inner join tblchartofaccounts COA on COA.accountID= RW.AccountID'
      'Left join tblclients C on c.clientId = RW.clientID'
      'where R.Deleted <>'#39'T'#39
      'union '
      'Select 2, '#39'Deposits'#39' , '
      'RD.ReconciliationLineID,'
      'RD.ReconciliationID,'
      'RD.PaymentID,'
      'RD.Reference,'
      'RD.Payee,'
      'RD.DepositDate,'
      'RD.AccountID,'
      'RD.Amount,'
      'RD.Notes,'
      'RD.Deposited,'
      'RD.Reconciled,'
      'RD.DepositLineID,'
      'RD.ClientID,'
      ' c.company, R.AccountId RAccountId ,'
      'COA.AccountName '
      'from tblreconciliation R'
      
        'Inner join  tblreconciliationdepositlines Rd on R.Reconciliation' +
        'ID = Rd.ReconciliationID'
      'inner join tblchartofaccounts COA on COA.accountID= RD.AccountID'
      'Left join tblclients C on c.clientId = RD.clientID'
      'where R.Deleted <>'#39'T'#39
      'union '
      ''
      
        'Select 1 details, concat("Total Amount Reconciled in :" , REconc' +
        'iliationid) , '
      '0,REconciliationid,0,"","",ReconciliationDate,R.AccountID,'
      
        'ifnull((Select sum(ifnull(Amount,0)) from tblreconciliationwithd' +
        'rawallines RW where R.ReconciliationID = RW.ReconciliationID),0)' +
        '- ifnull((Select sum(ifnull(Amount,0)) from tblreconciliationdep' +
        'ositlines RD where R.ReconciliationID = RD.ReconciliationID),0) ' +
        ', '
      '"","F","F",0,0, "", R.AccountId,COA.Accountname'
      'from tblreconciliation R'
      'inner join tblchartofaccounts COA on COA.accountID =R.AccountID'
      'where R.Deleted <>'#39'T'#39
      'Order by REconciliationid DESC , details')
    AfterOpen = qryMainAfterOpen
    OnCalcFields = qryMainCalcFields
    object qryMainCategory: TWideStringField
      DisplayWidth = 11
      FieldName = 'Category'
      Origin = '.Category'
      Size = 39
    end
    object qryMaincompany: TWideStringField
      DisplayLabel = 'Company'
      DisplayWidth = 21
      FieldName = 'company'
      Origin = '.company'
      Size = 160
    end
    object qryMainReconciliationID: TIntegerField
      DisplayLabel = 'Reconciliation#'
      DisplayWidth = 10
      FieldName = 'ReconciliationID'
      Origin = '.ReconciliationID'
    end
    object qryMainPaymentID: TLargeintField
      DisplayLabel = 'Payment#'
      DisplayWidth = 10
      FieldName = 'PaymentID'
      Origin = '.PaymentID'
    end
    object qryMainDepositLineID: TLargeintField
      DisplayLabel = 'Deposit Line#'
      DisplayWidth = 10
      FieldName = 'DepositLineID'
      Origin = '.DepositLineID'
    end
    object qryMainReference: TWideStringField
      DisplayWidth = 10
      FieldName = 'Reference'
      Origin = '.Reference'
      Size = 30
    end
    object qryMainPayee: TWideStringField
      DisplayWidth = 10
      FieldName = 'Payee'
      Origin = '.Payee'
      Size = 255
    end
    object qryMainDepositDate: TDateField
      DisplayLabel = 'Deposit Date'
      DisplayWidth = 10
      FieldName = 'DepositDate'
      Origin = '.DepositDate'
    end
    object qryMainNotes: TWideStringField
      DisplayWidth = 15
      FieldName = 'Notes'
      Origin = '.Notes'
      Size = 255
    end
    object qryMainRAccountId: TIntegerField
      DisplayWidth = 10
      FieldName = 'RAccountId'
      Origin = '.RAccountId'
    end
    object qryMaincAmount: TFloatField
      DisplayLabel = 'Amount'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'cAmount'
      currency = True
      Calculated = True
    end
    object qryMainAccountName: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountName'
      Origin = '.AccountName'
      Size = 50
    end
    object qryMaindetails: TLargeintField
      FieldName = 'details'
      Origin = '.details'
      Visible = False
    end
    object qryMainAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Origin = '.Amount'
      Visible = False
      currency = True
    end
    object qryMainReconciliationLineID: TLargeintField
      FieldName = 'ReconciliationLineID'
      Origin = '.ReconciliationLineID'
      Visible = False
    end
    object qryMainDeposited: TWideStringField
      FieldName = 'Deposited'
      Origin = '.Deposited'
      Visible = False
      Size = 1
    end
    object qryMainReconciled: TWideStringField
      FieldName = 'Reconciled'
      Origin = '.Reconciled'
      Visible = False
      Size = 1
    end
    object qryMainClientID: TLargeintField
      FieldName = 'ClientID'
      Origin = '.ClientID'
      Visible = False
    end
    object qryMainAccountID: TIntegerField
      FieldName = 'AccountID'
      Origin = '.AccountID'
      Visible = False
    end
  end
  object qryAccount: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT AccountName, AccountID, AccountType FROM tblchartofaccoun' +
        'ts'
      'WHERE (AccountType = '#39'BANK'#39' or AccountType = '#39'CCARD'#39')'
      'And Active<>'#39'F'#39' AND IsHeader = '#39'F'#39
      'ORDER BY AccountName;')
    Left = 127
    Top = 10
    object qryAccountAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
    object qryAccountAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qryAccountAccountType: TWideStringField
      FieldName = 'AccountType'
      Size = 50
    end
  end
end
