object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'ERP Sales Order Export'
  ClientHeight = 331
  ClientWidth = 493
  Color = 11201781
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 70
    Width = 147
    Height = 15
    Caption = 'ERP Client Program Name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 14
    Width = 116
    Height = 15
    Caption = 'Sales Order Number'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 126
    Width = 76
    Height = 15
    Caption = 'Output Folder'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 24
    Top = 183
    Width = 62
    Height = 15
    Caption = 'FTP Server'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 24
    Top = 239
    Width = 59
    Height = 15
    Caption = 'FTP Folder'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 240
    Top = 239
    Width = 87
    Height = 15
    Caption = 'FTP User Name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 367
    Top = 239
    Width = 82
    Height = 15
    Caption = 'FTP Password'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 304
    Width = 493
    Height = 27
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Panels = <
      item
        Text = 'Server'
        Width = 200
      end
      item
        Text = 'Database'
        Width = 200
      end>
    UseSystemFont = False
  end
  object edtERPExecName: TEdit
    Left = 24
    Top = 88
    Width = 148
    Height = 23
    TabOrder = 2
    Text = 'ERP.exe'
    OnChange = edtERPExecNameChange
  end
  object edtDocNo: TEdit
    Left = 24
    Top = 32
    Width = 148
    Height = 23
    TabOrder = 0
  end
  object btnExport: TButton
    Left = 196
    Top = 29
    Width = 87
    Height = 27
    Caption = 'Export'
    TabOrder = 1
    OnClick = btnExportClick
  end
  object edtOutputPath: TEdit
    Left = 24
    Top = 144
    Width = 201
    Height = 23
    TabOrder = 3
    OnChange = edtOutputPathChange
  end
  object edtFTPServer: TEdit
    Left = 24
    Top = 200
    Width = 201
    Height = 23
    TabOrder = 5
    OnChange = edtFTPServerChange
  end
  object edtFTPFolder: TEdit
    Left = 24
    Top = 256
    Width = 201
    Height = 23
    TabOrder = 7
    OnChange = edtFTPFolderChange
  end
  object edtFTPUser: TEdit
    Left = 240
    Top = 256
    Width = 105
    Height = 23
    TabOrder = 8
    OnChange = edtFTPUserChange
  end
  object edtFTPPass: TEdit
    Left = 367
    Top = 256
    Width = 105
    Height = 23
    TabOrder = 9
    OnChange = edtFTPPassChange
  end
  object chkSaveToFolder: TCheckBox
    Left = 248
    Top = 147
    Width = 97
    Height = 17
    Caption = 'Save to Folder'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = chkSaveToFolderClick
  end
  object chkSaveToFTP: TCheckBox
    Left = 248
    Top = 203
    Width = 97
    Height = 17
    Caption = 'Save to FTP'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = chkSaveToFTPClick
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 376
    Top = 8
  end
end
