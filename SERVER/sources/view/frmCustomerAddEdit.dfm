inherited FormCustomerAddEdit: TFormCustomerAddEdit
  ClientHeight = 393
  ClientWidth = 486
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 502
  ExplicitHeight = 432
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    Width = 486
    Height = 393
    ExplicitWidth = 486
    ExplicitHeight = 393
    inherited btnOk: TcxButton
      Left = 317
      Top = 356
      TabOrder = 10
      ExplicitLeft = 317
      ExplicitTop = 356
    end
    inherited btnCancel: TcxButton
      Left = 399
      Top = 356
      TabOrder = 11
      ExplicitLeft = 399
      ExplicitTop = 356
    end
    object edtName: TcxTextEdit [2]
      Left = 53
      Top = 74
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 421
    end
    object edtCode: TcxTextEdit [3]
      Left = 53
      Top = 104
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 421
    end
    object edtNIP: TcxTextEdit [4]
      Left = 53
      Top = 134
      AutoSize = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Height = 23
      Width = 274
    end
    object edtPhoneNo: TcxTextEdit [5]
      Left = 372
      Top = 134
      AutoSize = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Height = 23
      Width = 102
    end
    object edtStreet: TcxTextEdit [6]
      Left = 107
      Top = 185
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Width = 353
    end
    object edtHouseNo: TcxTextEdit [7]
      Left = 107
      Top = 215
      AutoSize = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 5
      Height = 23
      Width = 158
    end
    object edtLocalNo: TcxTextEdit [8]
      Left = 326
      Top = 215
      AutoSize = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 6
      Height = 23
      Width = 134
    end
    object edtPostCode: TcxTextEdit [9]
      Left = 107
      Top = 245
      AutoSize = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 7
      Height = 23
      Width = 165
    end
    object edtCity: TcxTextEdit [10]
      Left = 321
      Top = 245
      AutoSize = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 8
      Height = 23
      Width = 139
    end
    object edtCountry: TcxTextEdit [11]
      Left = 107
      Top = 275
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 9
      Width = 353
    end
    inherited lgMain: TdxLayoutGroup
      ItemIndex = 2
    end
    inherited lgBottom: TdxLayoutGroup
      Index = 3
    end
    inherited lgBottomButtons: TdxLayoutGroup
      AllowRemove = False
    end
    inherited liOk: TdxLayoutItem
      AllowRemove = False
    end
    inherited liCancel: TdxLayoutItem
      AllowRemove = False
    end
    object lgTop: TdxLayoutGroup
      Parent = lgMain
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      SizeOptions.AssignedValues = [sovSizableVert]
      SizeOptions.SizableVert = True
      SizeOptions.Height = 42
      AllowRemove = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object lgCenter: TdxLayoutGroup
      Parent = lgMain
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      AllowRemove = False
      ItemIndex = 3
      ShowBorder = False
      Index = 2
    end
    object imgTitle: TdxLayoutImageItem
      Parent = lgTop
      AlignHorz = ahLeft
      AlignVert = avClient
      AllowRemove = False
      CaptionOptions.Text = 'Image'
      CaptionOptions.Visible = False
      Image.SourceDPI = 96
      Image.SourceHeight = 64
      Image.SourceWidth = 64
      Image.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B3C7374796C6520747970653D22746578742F6373732220786D6C3A737061
        63653D227072657365727665223E2E426C75657B66696C6C3A23313137374437
        3B7D262331333B262331303B2623393B2E59656C6C6F777B66696C6C3A234646
        423131353B7D262331333B262331303B2623393B2E5265647B66696C6C3A2344
        31314331433B7D262331333B262331303B2623393B2E477265656E7B66696C6C
        3A233033394332333B7D262331333B262331303B2623393B2E426C61636B7B66
        696C6C3A233732373237323B7D262331333B262331303B2623393B2E57686974
        657B66696C6C3A234646464646463B7D262331333B262331303B2623393B2E73
        74307B6F7061636974793A302E353B7D262331333B262331303B2623393B2E73
        74317B6F7061636974793A302E37353B7D262331333B262331303B2623393B2E
        7374327B646973706C61793A6E6F6E653B7D262331333B262331303B2623393B
        2E7374337B646973706C61793A696E6C696E653B66696C6C3A23464642313135
        3B7D262331333B262331303B2623393B2E7374347B646973706C61793A696E6C
        696E653B7D262331333B262331303B2623393B2E7374357B646973706C61793A
        696E6C696E653B6F7061636974793A302E37353B7D262331333B262331303B26
        23393B2E7374367B646973706C61793A696E6C696E653B6F7061636974793A30
        2E353B7D262331333B262331303B2623393B2E7374377B646973706C61793A69
        6E6C696E653B66696C6C3A233033394332333B7D262331333B262331303B2623
        393B2E7374387B646973706C61793A696E6C696E653B66696C6C3A2344313143
        31433B7D262331333B262331303B2623393B2E7374397B646973706C61793A69
        6E6C696E653B66696C6C3A233131373744373B7D262331333B262331303B2623
        393B2E737431307B646973706C61793A696E6C696E653B66696C6C3A23464646
        4646463B7D3C2F7374796C653E0D0A3C672069643D22437573746F6D65725F31
        5F223E0D0A09093C7061746820636C6173733D22426C75652220643D224D3130
        2C392E39632D302E312C302E352C302E322C302E392C302E342C312E34732D30
        2E312C312E372C302E392C312E3663302C302C302C302E312C302C302E326330
        2E362C322E332C322C342E392C342E372C342E3973342E322D322E362C342E37
        2D342E3920202623393B2623393B56313363312C302E312C302E362D312E312C
        302E392D312E3663302E322D302E352C302E342D302E392C302E332D312E3463
        2D302E312D302E342D302E342D302E342D302E352D302E334332332E322C342E
        382C32302E332C352C32302E332C355332302C322C31342E382C322020262339
        3B2623393B4331302C322C392E342C362C31302E352C392E364331302E342C39
        2E362C31302E312C392E372C31302C392E397A204D32302C3138632D302E382C
        312E352D322E312C342D342C34732D332E322D322E352D342D34632D322E332C
        332E352D382C312D382C382E35563330683234762D332E3520202623393B2623
        393B4332382C31392E312C32322E332C32312E342C32302C31387A222F3E0D0A
        093C2F673E0D0A3C2F7376673E0D0A}
      Index = 0
    end
    object liLblTitle: TdxLayoutLabeledItem
      Parent = lgTop
      AlignHorz = ahLeft
      AlignVert = avClient
      LayoutLookAndFeel = ModDispatcher.dxLayoutSkin_Title
      AllowRemove = False
      CaptionOptions.Text = 'Label'
      Index = 1
    end
    object sprtr1: TdxLayoutSeparatorItem
      Parent = lgMain
      AllowRemove = False
      CaptionOptions.Text = 'Separator'
      Index = 1
    end
    object liName: TdxLayoutItem
      Parent = lgCenter
      AlignHorz = ahClient
      AlignVert = avTop
      AllowRemove = False
      CaptionOptions.Text = 'Nazwa'
      Control = edtName
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liCode: TdxLayoutItem
      Parent = lgCenter
      AlignHorz = ahClient
      AlignVert = avTop
      AllowRemove = False
      CaptionOptions.Text = 'Kod'
      Control = edtCode
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liNIP: TdxLayoutItem
      Parent = lgAddData
      AlignHorz = ahClient
      AlignVert = avClient
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      SizeOptions.Width = 357
      AllowRemove = False
      CaptionOptions.Text = 'NIP'
      Control = edtNIP
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 387
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liPhoneNo: TdxLayoutItem
      Parent = lgAddData
      AlignHorz = ahClient
      AlignVert = avClient
      AllowRemove = False
      CaptionOptions.Text = 'Nr tel.'
      Control = edtPhoneNo
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liStreet: TdxLayoutItem
      Parent = lgAddress
      AllowRemove = False
      CaptionOptions.Text = 'Ulica'
      Control = edtStreet
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liHouseNo: TdxLayoutItem
      Parent = lgAddress1
      AlignHorz = ahClient
      AlignVert = avClient
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      SizeOptions.Width = 222
      AllowRemove = False
      CaptionOptions.Text = 'Nr domu'
      Control = edtHouseNo
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liLocalNo: TdxLayoutItem
      Parent = lgAddress1
      AlignHorz = ahClient
      AlignVert = avClient
      AllowRemove = False
      CaptionOptions.Text = 'Nr lokalu'
      Control = edtLocalNo
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liPostCode: TdxLayoutItem
      Parent = lgAddress2
      AlignHorz = ahClient
      AlignVert = avClient
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      SizeOptions.Width = 221
      AllowRemove = False
      CaptionOptions.Text = 'Kod pocztowy'
      Control = edtPostCode
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liCity: TdxLayoutItem
      Parent = lgAddress2
      AlignHorz = ahClient
      AlignVert = avClient
      AllowRemove = False
      CaptionOptions.Text = 'Miasto'
      Control = edtCity
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liCountry: TdxLayoutItem
      Parent = lgAddress
      AllowRemove = False
      CaptionOptions.Text = 'Kraj'
      Control = edtCountry
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object lgAddress1: TdxLayoutGroup
      Parent = lgAddress
      CaptionOptions.Text = 'New Group'
      AllowRemove = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object lgAddress2: TdxLayoutGroup
      Parent = lgAddress
      CaptionOptions.Text = 'New Group'
      AllowRemove = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object lgAddress: TdxLayoutGroup
      Parent = lgCenter
      CaptionOptions.Text = 'Adres'
      AllowRemove = False
      ItemIndex = 1
      Index = 3
    end
    object lgAddData: TdxLayoutGroup
      Parent = lgCenter
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      AllowRemove = False
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
  end
end
