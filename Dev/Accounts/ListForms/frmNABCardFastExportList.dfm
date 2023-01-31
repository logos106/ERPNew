inherited fmNABCardFastExportList: TfmNABCardFastExportList
  Left = 67
  Caption = 'NAB CardFast Payments'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 13296639
    inherited cmdNew: TDNMSpeedButton
      Caption = 'Export &File'
    end
  end
  inherited HeaderPanel: TPanel
    Color = 13296639
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Color = 13296639
      ParentColor = False
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Processed;CheckBox;T;F'
        'Apply;CustomEdit;chkApplyCardFast;F')
      Selected.Strings = (
        'Apply'#9'1'#9'Apply'#9#9
        'CardHolderName'#9'35'#9'Card Holder Name'#9'T'
        'TxReference'#9'10'#9'Reference'#9'T'
        'TxType'#9'10'#9'Tx Type'#9'T'
        'Amount'#9'15'#9'Amount'#9'T'
        'CardNumber'#9'33'#9'Card Number'#9'T'
        'ExpiryDate'#9'5'#9'Expiry Date'#9'T'
        'MerchantID'#9'15'#9'Merchant ID'#9'T')
      TitleColor = 13296639
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
      FooterColor = 13296639
    end
    object chkApplyCardFast: TwwCheckBox
      Left = 272
      Top = 80
      Width = 35
      Height = 18
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
      DataField = 'Apply'
      DataSource = dsMain
      TabOrder = 1
      OnClick = chkApplyCardFastClick
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT '
      '  Apply, CardHolderName, TxReference, MerchantID, '
      '  CASE'
      '    WHEN TxType = "P" THEN "Payment"'
      '    WHEN TxType = "R" THEN "Refund"'
      '    WHEN TxType = "C" THEN "Completion"'
      '  END AS TxType,'
      '  Amount, CardNumber, ExpiryDate, AuthID, Processed '
      'FROM tblCardFast'
      'ORDER BY CardHolderName')
    object qryMainApply: TStringField
      DisplayWidth = 1
      FieldName = 'Apply'
      Origin = 'tblCardFast.Apply'
      FixedChar = True
      Size = 1
    end
    object qryMainCardHolderName: TStringField
      DisplayLabel = 'Card Holder Name'
      DisplayWidth = 35
      FieldName = 'CardHolderName'
      Origin = 'tblCardFast.CardHolderName'
      Size = 40
    end
    object qryMainTxReference: TStringField
      DisplayLabel = 'Reference'
      DisplayWidth = 10
      FieldName = 'TxReference'
      Origin = 'tblCardFast.TxReference'
    end
    object qryMainTxType: TStringField
      DisplayLabel = 'Tx Type'
      DisplayWidth = 10
      FieldName = 'TxType'
      Origin = 'tblCardFast.TxType'
      FixedChar = True
      Size = 10
    end
    object qryMainAmount: TFloatField
      DisplayWidth = 15
      FieldName = 'Amount'
      Origin = 'tblCardFast.Amount'
    end
    object qryMainCardNumber: TStringField
      DisplayLabel = 'Card Number'
      DisplayWidth = 33
      FieldName = 'CardNumber'
      Origin = 'tblCardFast.CardNumber'
      Size = 255
    end
    object qryMainExpiryDate: TStringField
      DisplayLabel = 'Expiry Date'
      DisplayWidth = 5
      FieldName = 'ExpiryDate'
      Origin = 'tblCardFast.ExpiryDate'
      Size = 5
    end
    object qryMainMerchantID: TStringField
      DisplayLabel = 'Merchant ID'
      DisplayWidth = 15
      FieldName = 'MerchantID'
      Origin = 'tblCardFast.MerchantID'
      Size = 15
    end
    object qryMainAuthID: TStringField
      DisplayLabel = 'Auth ID'
      DisplayWidth = 6
      FieldName = 'AuthID'
      Origin = 'tblCardFast.AuthID'
      Visible = False
      Size = 6
    end
    object qryMainProcessed: TStringField
      DisplayWidth = 1
      FieldName = 'Processed'
      Origin = 'tblCardFast.Processed'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  inherited MyConnection1: TMyConnection
    Server = 'localhost'
  end
end
