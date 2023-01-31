inherited RAPSubmissionsGUI: TRAPSubmissionsGUI
  Left = 238
  Top = 153
  Caption = 'RAP Submissions'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 14144187
    inherited cmdClose: TDNMSpeedButton
      Left = 767
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 567
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 667
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 268
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 169
    end
    object btnresubmit: TDNMSpeedButton
      Left = 468
      Top = 32
      Width = 87
      Height = 27
      Hint = '"Export The List To An Excel Spreadsheet"'
      Anchors = [akBottom]
      Caption = '&Submit'
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
      TabOrder = 9
      TabStop = False
      OnClick = btnresubmitClick
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 368
      Top = 32
      Width = 87
      Height = 27
      Hint = '"Export The List To An Excel Spreadsheet"'
      Anchors = [akBottom]
      Caption = '&Re-Submit'
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
      TabOrder = 10
      TabStop = False
    end
  end
  inherited HeaderPanel: TPanel
    Color = 14144187
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'All')
      end
    end
    inherited cboDateRange: TComboBox
      Visible = True
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'HasParent;CheckBox;T;F'
        'ReceivedSubmissionReport;CheckBox;T;F'
        'foundErrors;CheckBox;T;F'
        'PaymentReceived;CheckBox;T;F'
        'Submitted;CheckBox;T;F'
        'Resubmitted;CheckBox;T;F'
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'SubmissionDate'#9'10'#9'Submission~Date'#9#9
        'HasParent'#9'1'#9'Resubmitting?'#9#9
        'ParentFile'#9'30'#9'Resubmitting~File Name'#9#9
        'XMLFileName'#9'30'#9'File Name'#9#9
        'ReceivedSubmissionReport'#9'1'#9'Received~Submission~Report'#9#9
        'foundErrors'#9'1'#9'Errors~Found?'#9#9
        'SubmissionErrorMessage'#9'30'#9'Error Message'#9#9
        'RequestedAmount'#9'10'#9'Requested~Amount'#9#9
        'PaymentReceived'#9'1'#9'Payment~Received?'#9#9
        'AmountReceived'#9'10'#9'Amount~Received'#9#9
        'Submitted'#9'1'#9'Submitted?'#9#9
        'TotalInvoices'#9'1'#9'Total~Invoices'#9#9
        'Resubmitted'#9'1'#9'Resubmitted?'#9#9
        'childFile'#9'30'#9'Resubmitted~File Name'#9#9
        'Active'#9'1'#9'Active'#9#9)
      TitleColor = 14144187
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgRowResize]
      TitleLines = 3
      UseTFields = False
      FooterColor = 14144187
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select CurrentSubmission.* ,  '
      
        'if (ifnull(CurrentSubmission.ReSubmittedID ,0) <> 0 , "T" , "F")' +
        ' as Resubmitted, '
      
        'if (ifnull(CurrentSubmission.ParentSubmissionId ,0) <> 0 , "T" ,' +
        ' "F") as HasParent, '
      'ParentSubmission.XMLfileName as ParentFile,'
      'ReSubmission.XMLfileName as childFile'
      'FROM tblrapsubmission as CurrentSubmission'
      
        'left join tblrapsubmission as  ParentSubmission on ParentSubmiss' +
        'ion.SubmissionId = CurrentSubmission.ParentSubmissionId'
      
        'left join tblrapsubmission as  ReSubmission on ReSubmission.Subm' +
        'issionId = CurrentSubmission.ReSubmittedID'
      
        'WHERE CurrentSubmission.SubmissionDate Between :txtfrom AND :txt' +
        'to')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'txtfrom'
      end
      item
        DataType = ftUnknown
        Name = 'txtto'
      end>
    object qryMainSubmissionDate: TDateField
      DisplayLabel = 'Submission~Date'
      DisplayWidth = 10
      FieldName = 'SubmissionDate'
      Origin = 'tblrapsubmission.SubmissionDate'
    end
    object qryMainHasParent: TStringField
      DisplayLabel = 'Resubmitting?'
      DisplayWidth = 1
      FieldName = 'HasParent'
      Origin = '.HasParent'
      Size = 1
    end
    object qryMainParentFile: TStringField
      DisplayLabel = 'Resubmitting~File Name'
      DisplayWidth = 30
      FieldName = 'ParentFile'
      Origin = 'ParentSubmission.ParentFile'
      Size = 255
    end
    object qryMainXMLFileName: TStringField
      DisplayLabel = 'File Name'
      DisplayWidth = 30
      FieldName = 'XMLFileName'
      Origin = 'tblrapsubmission.XMLFileName'
      Size = 255
    end
    object qryMainReceivedSubmissionReport: TStringField
      DisplayLabel = 'Received~Submission~Report'
      DisplayWidth = 1
      FieldName = 'ReceivedSubmissionReport'
      Origin = 'tblrapsubmission.ReceivedSubmissionReport'
      FixedChar = True
      Size = 1
    end
    object qryMainfoundErrors: TStringField
      DisplayLabel = 'Errors~Found?'
      DisplayWidth = 1
      FieldName = 'foundErrors'
      Origin = 'tblrapsubmission.foundErrors'
      FixedChar = True
      Size = 1
    end
    object qryMainSubmissionErrorMessage: TMemoField
      DisplayLabel = 'Error Message'
      DisplayWidth = 30
      FieldName = 'SubmissionErrorMessage'
      Origin = 'tblrapsubmission.SubmissionErrorMessage'
      BlobType = ftMemo
    end
    object qryMainRequestedAmount: TFloatField
      DisplayLabel = 'Requested~Amount'
      DisplayWidth = 10
      FieldName = 'RequestedAmount'
      Origin = 'tblrapsubmission.RequestedAmount'
    end
    object qryMainPaymentReceived: TStringField
      DisplayLabel = 'Payment~Received?'
      DisplayWidth = 1
      FieldName = 'PaymentReceived'
      Origin = 'tblrapsubmission.PaymentReceived'
      FixedChar = True
      Size = 1
    end
    object qryMainAmountReceived: TFloatField
      DisplayLabel = 'Amount~Received'
      DisplayWidth = 10
      FieldName = 'AmountReceived'
      Origin = 'tblrapsubmission.AmountReceived'
    end
    object qryMainSubmitted: TStringField
      DisplayLabel = 'Submitted?'
      DisplayWidth = 1
      FieldName = 'Submitted'
      Origin = 'tblrapsubmission.Submitted'
      FixedChar = True
      Size = 1
    end
    object qryMainTotalInvoices: TIntegerField
      DisplayLabel = 'Total~Invoices'
      DisplayWidth = 1
      FieldName = 'TotalInvoices'
      Origin = 'tblrapsubmission.TotalInvoices'
    end
    object qryMainResubmitted: TStringField
      DisplayLabel = 'Resubmitted?'
      DisplayWidth = 1
      FieldName = 'Resubmitted'
      Origin = '.Resubmitted'
      Size = 1
    end
    object qryMainchildFile: TStringField
      DisplayLabel = 'Resubmitted~File Name'
      DisplayWidth = 30
      FieldName = 'childFile'
      Origin = 'ReSubmission.childFile'
      Size = 255
    end
    object qryMainActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblrapsubmission.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainResubmittedID: TIntegerField
      DisplayWidth = 15
      FieldName = 'ResubmittedID'
      Origin = 'tblrapsubmission.ResubmittedID'
      Visible = False
    end
    object qryMainSubmissionID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'SubmissionID'
      Origin = 'tblrapsubmission.SubmissionID'
      Visible = False
    end
    object qryMainParentSubmissionId: TIntegerField
      DisplayWidth = 15
      FieldName = 'ParentSubmissionId'
      Origin = 'tblrapsubmission.ParentSubmissionId'
      Visible = False
    end
  end
  inherited ExportDialog: TProgressDialog
    Left = 267
  end
end
