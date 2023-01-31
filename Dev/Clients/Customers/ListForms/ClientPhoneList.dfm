inherited ClientPhoneListGUI: TClientPhoneListGUI
  Caption = 'Phone Numbers'
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 1004
  ExplicitHeight = 596
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 882001
  inherited HeaderPanel: TPanel
    HelpContext = 882004
    inherited pnlHeader: TPanel
      HelpContext = 882005
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Phone Numbers'
          ExplicitLeft = -1
          HelpContext = 882002
        end
      end
    end
  end
  inherited Panel1: TPanel
    HelpContext = 882006
    inherited lblDateComments: TLabel
      Width = 998
      HelpContext = 882003
    end
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'Company'#9'60'#9'Name'
        'Description'#9'40'#9'Description'#9'F'
        'Phone'#9'20'#9'Phone')
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select '#9#9
      '1 as seqno, '#9#9
      'C.Company  as Company, '#9#9
      #39'Customer Phone'#39'  '#9'Description, '#9
      'C.Phone  as phone'#9#9
      'from tblclients C  '
      'where (C.clientId = :CustomerId or :CustomerId =0)'
      'union all '#9#9
      'Select '#9#9
      '2 as seqno, '#9#9
      'C.Company  as Company, '#9#9
      #39'Customer Alt Phone'#39'  '#9'Description, '#9
      'C.AltPhone  as Phone'#9#9
      'from tblclients C  '#9#9
      'where (C.clientId = :CustomerId or :CustomerId =0)  '#9#9
      'union all '#9#9
      'Select '#9#9
      '3 as seqno, '#9#9
      'C.Company  as Company, '#9#9
      #39'Customer Fax'#39' '#9#9'Description, '
      'C.FaxNumber  as phone'#9#9
      'from tblclients C  '#9#9
      'where (C.clientId = :CustomerId or :CustomerId =0)  '#9#9
      'union all '#9#9
      'Select '#9#9
      '4 as seqno, '#9#9
      'C.Company  as Company, '#9#9
      #39'Customer Mob'#39' '#9#9'Description, '
      'C.Mobile  as phone'#9#9
      'from tblclients C  '#9#9
      'where (C.clientId = :CustomerId or :CustomerId =0)  '#9#9
      'union all '#9#9
      'Select '#9#9
      '5 as seqno, '#9#9
      
        'Concat_ws('#39' '#39' , C.contactFirstName , C.ContactSurName) company, ' +
        #9#9
      
        'concat(if(IsPrimarycontact='#39'T'#39' , '#39'Primary Contact'#39' , '#39'Contact'#39') ' +
        ', '#39' Phone'#39') '#9#9'Description, '
      'C.ContactPH  as phone'#9#9
      'from tblcontacts C '#9#9
      
        'where (C.ClientID = :CustomerId or :CustomerId =0) and ifnull(C.Con' +
        'tactPH ,'#39#39')'#9'<> '#39#39' '#9
      'union all '#9#9
      'Select '#9#9
      '6 as seqno, '#9#9
      
        'Concat_ws('#39' '#39' , C.contactFirstName , C.ContactSurName) company, ' +
        'concat(if(IsPrimarycontact='#39'T'#39' , '#39'Primary Contact'#39' , '#39'Contact'#39') ' +
        ', '#39' Alt Phone'#39') '#9'Description, '#9
      'C.ContactAltPH  as phone'#9#9
        'from tblcontacts C where (C.ClientID = :CustomerId or :CustomerId =' +
        '0) and ifnull(C.ContactAltPH,'#39#39')<> '#39#39' '#9#9
      'union all '#9#9
      'Select '#9#9
      '7 as seqno, '#9#9
      
        'Concat_ws('#39' '#39' , C.contactFirstName , C.ContactSurName) company, ' +
        'concat(if(IsPrimarycontact='#39'T'#39' , '#39'Primary Contact'#39' , '#39'Contact'#39') ' +
        ', '#39' Mob'#39' ) '#9#9'Description, '
      'C.ContactMOB  as phone'#9#9
      'from tblcontacts C '#9#9
      
        'where (C.ClientID = :CustomerId or :CustomerId =0) and ifnull(C.Con' +
        'tactMOB,'#39#39')'#9'<> '#39#39' '#9
      'union all '#9#9
      'Select '#9#9
      '8 as seqno, '#9#9
      
        'Concat_ws('#39' '#39' , C.contactFirstName , C.ContactSurName) company, ' +
        'concat(if(IsPrimarycontact='#39'T'#39' , '#39'Primary Contact'#39' , '#39'Contact'#39') ' +
        ', '#39' Fax'#39' ) '#9#9'Description, '
      'C.ContactFax  as phone'#9#9
      'from tblcontacts C '#9#9
      
        'where (C.ClientID = :CustomerId or :CustomerId =0) and ifnull( C.Co' +
        'ntactFax,'#39#39')'#9'<> '#39#39#9
      'Order by Company,Seqno')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end>
    object qryMainCompany: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 60
      FieldName = 'Company'
      Origin = 'Company'
      Size = 160
    end
    object qryMainDescription: TWideStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Origin = 'Description'
      Size = 25
    end
    object qryMainPhone: TWideStringField
      DisplayWidth = 20
      FieldName = 'Phone'
      Origin = 'phone'
      Size = 255
    end
    object qryMainseqno: TLargeintField
      DisplayWidth = 15
      FieldName = 'seqno'
      Origin = 'seqno'
      Visible = False
    end
  end
end
