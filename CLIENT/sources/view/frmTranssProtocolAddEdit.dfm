inherited FormTranssProtocolAddEdit: TFormTranssProtocolAddEdit
  Caption = 'FormTranssProtocolAddEdit'
  ClientHeight = 417
  ClientWidth = 491
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 507
  ExplicitHeight = 456
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    Width = 491
    Height = 417
    ExplicitWidth = 491
    ExplicitHeight = 417
    inherited btnOk: TcxButton
      Left = 322
      Top = 380
      TabOrder = 9
      ExplicitLeft = 322
      ExplicitTop = 380
    end
    inherited btnCancel: TcxButton
      Left = 404
      Top = 380
      TabOrder = 10
      ExplicitLeft = 404
      ExplicitTop = 380
    end
    object edtName: TcxTextEdit [2]
      Left = 137
      Top = 74
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 342
    end
    object edtMsgToDevice: TcxTextEdit [3]
      Left = 137
      Top = 104
      Properties.CharCase = ecUpperCase
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 342
    end
    object edtFrameBeginning: TcxTextEdit [4]
      Left = 137
      Top = 134
      Properties.CharCase = ecUpperCase
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Width = 342
    end
    object edtFrameEnd: TcxTextEdit [5]
      Left = 137
      Top = 164
      Properties.CharCase = ecUpperCase
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Width = 342
    end
    object seFrameLength: TcxSpinEdit [6]
      Left = 137
      Top = 194
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 4
      OnExit = seSpinEditExit
      Width = 121
    end
    object seMassPosStart: TcxSpinEdit [7]
      Left = 120
      Top = 245
      AutoSize = False
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 5
      OnExit = seSpinEditExit
      Height = 23
      Width = 152
    end
    object seMassPosEnd: TcxSpinEdit [8]
      Left = 321
      Top = 245
      AutoSize = False
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 6
      OnExit = seSpinEditExit
      Height = 23
      Width = 144
    end
    object seStablePos: TcxSpinEdit [9]
      Left = 120
      Top = 310
      AutoSize = False
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 7
      OnExit = seSpinEditExit
      Height = 23
      Width = 130
    end
    object edtStableSymbol: TcxTextEdit [10]
      Left = 336
      Top = 310
      AutoSize = False
      Properties.CharCase = ecUpperCase
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 8
      Height = 23
      Width = 129
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
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
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
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D2254
        6F705F426F74746F6D5F52756C65732220786D6C6E733D22687474703A2F2F77
        77772E77332E6F72672F323030302F7376672220786D6C6E733A786C696E6B3D
        22687474703A2F2F7777772E77332E6F72672F313939392F786C696E6B222078
        3D223070782220793D22307078222076696577426F783D223020302033322033
        3222207374796C653D22656E61626C652D6261636B67726F756E643A6E657720
        3020302033322033323B2220786D6C3A73706163653D22707265736572766522
        3E262331333B262331303B3C7374796C6520747970653D22746578742F637373
        2220786D6C3A73706163653D227072657365727665223E2E477265656E7B6669
        6C6C3A233033394332333B7D262331333B262331303B2623393B2E426C75657B
        66696C6C3A233131373744373B7D3C2F7374796C653E0D0A3C7061746820636C
        6173733D22426C75652220643D224D32392C32483136763234682D3276326831
        3563302E352C302C312D302E352C312D3156334333302C322E352C32392E352C
        322C32392C327A204D32332C32346C2D342D3668335638683276313068334C32
        332C32347A222F3E0D0A3C7061746820636C6173733D22477265656E2220643D
        224D31342C3468325632483143302E352C322C302C322E352C302C3376323463
        302C302E352C302E352C312C312C3168313356347A204D382C32324836563132
        48336C342D366C342C3648385632327A222F3E0D0A3C2F7376673E0D0A}
      Index = 0
    end
    object sprtr1: TdxLayoutSeparatorItem
      Parent = lgMain
      AllowRemove = False
      CaptionOptions.Text = 'Separator'
      Index = 1
    end
    object lgCenter: TdxLayoutGroup
      Parent = lgMain
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      AllowRemove = False
      ItemIndex = 2
      ShowBorder = False
      Index = 2
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
    object liMsgToDevice: TdxLayoutItem
      Parent = lgCenter
      AlignHorz = ahClient
      AlignVert = avTop
      AllowRemove = False
      CaptionOptions.Text = 'Wysy'#322'ana ramka (HEX)'
      Control = edtMsgToDevice
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liFrameBeginning: TdxLayoutItem
      Parent = lgCenter
      AlignHorz = ahClient
      AlignVert = avTop
      AllowRemove = False
      CaptionOptions.Text = 'Pocz'#261'tek ramki (HEX)'
      Control = edtFrameBeginning
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liFrameEnding: TdxLayoutItem
      Parent = lgCenter
      AlignHorz = ahClient
      AlignVert = avTop
      AllowRemove = False
      CaptionOptions.Text = 'Koniec ramki (HEX)'
      Control = edtFrameEnd
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object liFrameLength: TdxLayoutItem
      Parent = lgCenter
      AlignHorz = ahLeft
      AlignVert = avTop
      AllowRemove = False
      CaptionOptions.Text = 'D'#322'ugo'#347#263' ramki'
      Control = seFrameLength
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object liMassPosStart: TdxLayoutItem
      Parent = lgMass
      AlignHorz = ahClient
      AlignVert = avClient
      AllowRemove = False
      CaptionOptions.Text = 'Pocz'#261'tek'
      Control = seMassPosStart
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liMassPosEnd: TdxLayoutItem
      Parent = lgMass
      AlignHorz = ahClient
      AlignVert = avClient
      AllowRemove = False
      CaptionOptions.Text = 'Koniec'
      Control = seMassPosEnd
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liStablePos: TdxLayoutItem
      Parent = lgStable
      AlignHorz = ahClient
      AlignVert = avClient
      AllowRemove = False
      CaptionOptions.Text = 'Pozycja w ramce'
      Control = seStablePos
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liStableSymbol: TdxLayoutItem
      Parent = lgStable
      AlignHorz = ahClient
      AlignVert = avClient
      AllowRemove = False
      CaptionOptions.Text = 'Symbol (HEX)'
      Control = edtStableSymbol
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object lgMass: TdxLayoutGroup
      Parent = lgCenter
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Pozycja masy'
      AllowRemove = False
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      Index = 5
    end
    object lgStable: TdxLayoutGroup
      Parent = lgCenter
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Znak stabilno'#347'ci'
      AllowRemove = False
      LayoutDirection = ldHorizontal
      Index = 6
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
  end
end
