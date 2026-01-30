inherited FormWeighing: TFormWeighing
  Caption = 'Okno wa'#380'enia'
  ClientHeight = 451
  ClientWidth = 520
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 536
  ExplicitHeight = 490
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    Width = 520
    Height = 451
    inherited btnOk: TcxButton
      Left = 351
      Top = 414
      TabOrder = 14
      ExplicitLeft = 351
      ExplicitTop = 414
    end
    inherited btnCancel: TcxButton
      Left = 433
      Top = 414
      TabOrder = 15
      ExplicitLeft = 433
      ExplicitTop = 414
    end
    object btnSelectProduct: TcxButton [2]
      Left = 351
      Top = 198
      Width = 75
      Height = 25
      Action = actSelectProduct
      TabOrder = 8
    end
    object btnSelectCustomer: TcxButton [3]
      Left = 351
      Top = 166
      Width = 75
      Height = 25
      Action = actSelectCutomer
      TabOrder = 5
    end
    object btnClearCustomer: TcxButton [4]
      Left = 433
      Top = 166
      Width = 75
      Height = 25
      Action = actClearCustomer
      TabOrder = 6
    end
    object btnClearProduct: TcxButton [5]
      Left = 433
      Top = 198
      Width = 75
      Height = 25
      Action = actClearProduct
      TabOrder = 9
    end
    object edtCustomer: TcxTextEdit [6]
      Left = 122
      Top = 166
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Width = 222
    end
    object edtProduct: TcxTextEdit [7]
      Left = 122
      Top = 198
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 7
      Width = 222
    end
    object pnlTop: TPanel [8]
      Left = 12
      Top = 12
      Width = 496
      Height = 61
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object imgTitle: TcxImage
        Left = 0
        Top = 0
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Picture.Data = {
          0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
          2220656E636F64696E673D225554462D38223F3E0D0A3C737667207665727369
          6F6E3D22312E31222069643D224C617965725F312220786D6C6E733D22687474
          703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A78
          6C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C69
          6E6B2220783D223070782220793D22307078222076696577426F783D22302030
          20333220333222207374796C653D22656E61626C652D6261636B67726F756E64
          3A6E6577203020302033322033323B2220786D6C3A73706163653D2270726573
          65727665223E262331333B262331303B3C7374796C6520747970653D22746578
          742F6373732220786D6C3A73706163653D227072657365727665223E2E477265
          656E7B66696C6C3A233033394332333B7D262331333B262331303B2623393B2E
          426C61636B7B66696C6C3A233732373237323B7D262331333B262331303B2623
          393B2E5265647B66696C6C3A234431314331433B7D262331333B262331303B26
          23393B2E59656C6C6F777B66696C6C3A234646423131353B7D262331333B2623
          31303B2623393B2E426C75657B66696C6C3A233131373744373B7D262331333B
          262331303B2623393B2E57686974657B66696C6C3A234646464646463B7D2623
          31333B262331303B2623393B2E7374307B6F7061636974793A302E353B7D2623
          31333B262331303B2623393B2E7374317B6F7061636974793A302E37353B7D3C
          2F7374796C653E0D0A3C672069643D22576569676874656450696573223E0D0A
          09093C7061746820636C6173733D22426C75652220643D224D32362C31306331
          2E312C302C322D302E392C322D3263302D312E312D302E392D322D322D32682D
          38563463302D312E312D302E392D322D322D32732D322C302E392D322C327632
          483643342E392C362C342C362E392C342C3820202623393B2623393B63302C31
          2E312C302E392C322C322C324C302C323263302E352C332E342C332E342C362C
          372C3673362E352D322E362C372D364C382C31306836683468366C2D362C3132
          63302E352C332E342C332E342C362C372C3673362E352D322E362C372D364C32
          362C31307A204D322E322C32324C372C31322E3520202623393B2623393B6C34
          2E382C392E3548322E327A204D32302E322C32326C342E382D392E356C342E38
          2C392E354832302E327A222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        Properties.FitMode = ifmFill
        TabOrder = 0
        Height = 61
        Width = 61
      end
      object lblTitle: TcxLabel
        Left = 96
        Top = 0
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        Caption = 'Wa'#380'enie'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -40
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Vert = taVCenter
        ExplicitWidth = 504
        Height = 61
        Width = 400
        AnchorY = 31
      end
    end
    object pnlScaleInfo: TPanel [9]
      Left = 165
      Top = 322
      Width = 261
      Height = 45
      BevelOuter = bvNone
      TabOrder = 11
    end
    object btnDoWeighing: TcxButton [10]
      Left = 433
      Top = 322
      Width = 75
      Height = 45
      Action = actDoWeighing
      TabOrder = 12
    end
    object pnlScaleStatus: TPanel [11]
      Left = 165
      Top = 374
      Width = 343
      Height = 20
      BevelOuter = bvNone
      TabOrder = 13
    end
    object edtCarNo: TcxTextEdit [12]
      Left = 122
      Top = 93
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 233
    end
    object edtTrailerNo: TcxTextEdit [13]
      Left = 122
      Top = 123
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Width = 233
    end
    object seTare: TcxSpinEdit [14]
      Left = 390
      Top = 93
      Properties.Alignment.Horz = taRightJustify
      Properties.SpinButtons.Visible = False
      Properties.ValueType = vtFloat
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 3
      Width = 118
    end
    object seNetto: TcxSpinEdit [15]
      Left = 48
      Top = 322
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Properties.SpinButtons.Visible = False
      Properties.ValueType = vtFloat
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 10
      Width = 110
    end
    inherited lgMain: TdxLayoutGroup
      ItemIndex = 6
    end
    inherited lgBottom: TdxLayoutGroup
      Index = 7
    end
    object lgCustomer: TdxLayoutGroup
      Parent = lgMain
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 4
    end
    object lgProduct: TdxLayoutGroup
      Parent = lgMain
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 5
    end
    object liCustomer: TdxLayoutItem
      Parent = lgCustomer
      AlignHorz = ahClient
      CaptionOptions.Text = 'Kontrahent'
      Control = edtCustomer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liProduct: TdxLayoutItem
      Parent = lgProduct
      AlignHorz = ahClient
      CaptionOptions.Text = 'Produkt'
      Control = edtProduct
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liSelectProduct: TdxLayoutItem
      Parent = lgProduct
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnSelectProduct
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liSelectCustomer: TdxLayoutItem
      Parent = lgCustomer
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnSelectCustomer
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liClearCustomer: TdxLayoutItem
      Parent = lgCustomer
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnClearCustomer
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liClearProduct: TdxLayoutItem
      Parent = lgProduct
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnClearProduct
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liTop: TdxLayoutItem
      Parent = lgMain
      AlignHorz = ahClient
      AlignVert = avTop
      SizeOptions.AssignedValues = [sovSizableVert]
      SizeOptions.SizableVert = True
      SizeOptions.Height = 61
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = pnlTop
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 41
      ControlOptions.OriginalWidth = 185
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object sprtrTop: TdxLayoutSeparatorItem
      Parent = lgMain
      CaptionOptions.Text = 'Separator'
      Index = 1
    end
    object lgWeighing: TdxLayoutGroup
      Parent = lgMain
      AlignHorz = ahClient
      AlignVert = avBottom
      CaptionOptions.Text = 'New Group'
      SizeOptions.AssignedValues = [sovSizableVert]
      SizeOptions.SizableVert = True
      SizeOptions.Height = 72
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 6
    end
    object lgWeighingData: TdxLayoutGroup
      Parent = lgWeighing
      AlignHorz = ahLeft
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      SizeOptions.Width = 146
      ShowBorder = False
      Index = 0
    end
    object liScaleValue: TdxLayoutItem
      Parent = lgScaleMass
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = pnlScaleInfo
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 41
      ControlOptions.OriginalWidth = 185
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liDoWeighing: TdxLayoutItem
      Parent = lgScaleMass
      AlignHorz = ahRight
      AlignVert = avClient
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnDoWeighing
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object lgScale: TdxLayoutGroup
      Parent = lgWeighing
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 1
    end
    object lgScaleMass: TdxLayoutGroup
      Parent = lgScale
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      SizeOptions.AssignedValues = [sovSizableVert]
      SizeOptions.SizableVert = False
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object liScaleStatus: TdxLayoutItem
      Parent = lgScale
      AlignVert = avBottom
      SizeOptions.AssignedValues = [sovSizableVert]
      SizeOptions.SizableVert = True
      SizeOptions.Height = 12
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = pnlScaleStatus
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 41
      ControlOptions.OriginalWidth = 185
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object sprtrTop2: TdxLayoutSeparatorItem
      Parent = lgMain
      CaptionOptions.Text = 'Separator'
      Index = 3
    end
    object lgTop: TdxLayoutGroup
      Parent = lgMain
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object lgRegNo: TdxLayoutGroup
      Parent = lgTop
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      ItemIndex = 1
      ShowBorder = False
      Index = 0
    end
    object liCarNo: TdxLayoutItem
      Parent = lgRegNo
      CaptionOptions.Text = 'NR REJESTRACYJNY'
      Control = edtCarNo
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liTrailerNo: TdxLayoutItem
      Parent = lgRegNo
      CaptionOptions.Text = 'NR NACZEPY'
      Control = edtTrailerNo
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object lgTopRight: TdxLayoutGroup
      Parent = lgTop
      CaptionOptions.Text = 'New Group'
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      SizeOptions.Width = 146
      ShowBorder = False
      Index = 1
    end
    object liTare: TdxLayoutItem
      Parent = lgTopRight
      CaptionOptions.Text = 'Tara'
      Control = seTare
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liNetto: TdxLayoutItem
      Parent = lgWeighingData
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Netto'
      Control = seNetto
      ControlOptions.AutoControlAreaAlignment = False
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
  end
  inherited actlstMain: TActionList
    Images = ModDispatcher.imgList16
    object actSelectProduct: TAction
      ImageIndex = 2
    end
    object actSelectCutomer: TAction
      ImageIndex = 1
    end
    object actClearProduct: TAction
      ImageIndex = 7
    end
    object actClearCustomer: TAction
      ImageIndex = 7
    end
    object actDoWeighing: TAction
      Caption = 'WA'#379'ENIE'
    end
  end
end
