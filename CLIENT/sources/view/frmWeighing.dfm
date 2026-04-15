inherited FormWeighing: TFormWeighing
  Caption = 'Okno wa'#380'enia'
  ClientHeight = 451
  ClientWidth = 652
  StyleElements = [seFont, seClient, seBorder]
  OnActivate = FormActivate
  ExplicitWidth = 668
  ExplicitHeight = 490
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    Width = 652
    Height = 451
    ExplicitWidth = 652
    ExplicitHeight = 451
    inherited btnOk: TcxButton
      Left = 483
      Top = 414
      Enabled = False
      TabOrder = 18
      ExplicitLeft = 483
      ExplicitTop = 414
    end
    inherited btnCancel: TcxButton
      Left = 565
      Top = 414
      Enabled = False
      TabOrder = 19
      ExplicitLeft = 565
      ExplicitTop = 414
    end
    object btnSelectProduct: TcxButton [2]
      Left = 483
      Top = 200
      Width = 75
      Height = 25
      Action = actSelectProduct
      TabOrder = 11
    end
    object btnSelectCustomer: TcxButton [3]
      Left = 483
      Top = 168
      Width = 75
      Height = 25
      Action = actSelectCutomer
      TabOrder = 8
    end
    object btnClearCustomer: TcxButton [4]
      Left = 565
      Top = 168
      Width = 75
      Height = 25
      Action = actClearCustomer
      TabOrder = 9
    end
    object btnClearProduct: TcxButton [5]
      Left = 565
      Top = 200
      Width = 75
      Height = 25
      Action = actClearProduct
      TabOrder = 12
    end
    object pnlTop: TPanel [6]
      Left = 12
      Top = 12
      Width = 628
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
        Properties.FitMode = ifmProportionalStretch
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
        Height = 61
        Width = 532
        AnchorY = 31
      end
    end
    object pnlScaleInfo: TPanel [7]
      Left = 179
      Top = 271
      Width = 365
      Height = 47
      BevelOuter = bvNone
      TabOrder = 14
      object pnlScaleMass: TPanel
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 355
        Height = 37
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        BevelOuter = bvNone
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblScaleMass: TcxLabel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alClient
          Caption = '0'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clYellow
          Style.Font.Height = -20
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = [fsBold]
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          AnchorX = 318
          AnchorY = 19
        end
        object lblScaleUnit: TcxLabel
          AlignWithMargins = True
          Left = 323
          Top = 0
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alRight
          Caption = 'kg'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clYellow
          Style.Font.Height = -20
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = [fsBold]
          Style.IsFontAssigned = True
          Properties.Alignment.Vert = taVCenter
          AnchorY = 19
        end
      end
    end
    object btnDoWeighing: TcxButton [8]
      Left = 551
      Top = 271
      Width = 75
      Height = 47
      Action = actDoWeighing
      TabOrder = 15
    end
    object pnlScaleStatus: TPanel [9]
      Left = 179
      Top = 325
      Width = 447
      Height = 28
      BevelOuter = bvNone
      TabOrder = 16
      object pnlScaleStatusInfo: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 441
        Height = 22
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Brak po'#322#261'czenia z wag'#261
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
    end
    object edtCarNo: TcxTextEdit [10]
      Left = 122
      Top = 93
      AutoSize = False
      Properties.CharCase = ecUpperCase
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Height = 25
      Width = 187
    end
    object edtTrailerNo: TcxTextEdit [11]
      Left = 122
      Top = 125
      Properties.CharCase = ecUpperCase
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Width = 281
    end
    object seTare: TcxSpinEdit [12]
      Left = 496
      Top = 123
      Properties.Alignment.Horz = taRightJustify
      Properties.SpinButtons.Visible = False
      Properties.ValueType = vtFloat
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 6
      Width = 144
    end
    object seNetto: TcxSpinEdit [13]
      Left = 62
      Top = 271
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Properties.SpinButtons.Visible = False
      Properties.ValueType = vtFloat
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 13
      Width = 110
    end
    object cmbWeighingType: TcxComboBox [14]
      Left = 496
      Top = 93
      Properties.OnChange = cmbWeighingTypePropertiesChange
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 5
      Width = 144
    end
    object stsbrBottom: TdxStatusBar [15]
      Left = 12
      Top = 387
      Width = 628
      Height = 20
      Color = clHighlightText
      Panels = <
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        end>
    end
    object btnSearchCar: TcxButton [16]
      Left = 316
      Top = 93
      Width = 40
      Height = 25
      Action = actSearchCar
      TabOrder = 2
    end
    object cmbCustomer: TcxComboBox [17]
      Left = 122
      Top = 168
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 7
      Width = 354
    end
    object cmbProduct: TcxComboBox [18]
      Left = 122
      Top = 200
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 10
      Width = 354
    end
    object btnClearData: TcxButton [19]
      Left = 363
      Top = 93
      Width = 40
      Height = 25
      Action = actClearData
      TabOrder = 3
    end
    inherited lgMain: TdxLayoutGroup
      ItemIndex = 6
    end
    inherited lgBottom: TdxLayoutGroup
      Index = 7
    end
    inherited lgBottomButtons: TdxLayoutGroup
      Visible = False
      AllowRemove = False
      Enabled = False
      Index = 2
    end
    inherited liOk: TdxLayoutItem
      AllowRemove = False
      Enabled = False
    end
    inherited liCancel: TdxLayoutItem
      AllowRemove = False
      Enabled = False
    end
    object lgCustomer: TdxLayoutGroup
      Parent = lgMain
      CaptionOptions.Text = 'New Group'
      AllowRemove = False
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 4
    end
    object lgProduct: TdxLayoutGroup
      Parent = lgMain
      CaptionOptions.Text = 'New Group'
      AllowRemove = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 5
    end
    object liCustomer: TdxLayoutItem
      Parent = lgCustomer
      AlignHorz = ahClient
      AllowRemove = False
      CaptionOptions.Text = 'Kontrahent'
      Control = cmbCustomer
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liProduct: TdxLayoutItem
      Parent = lgProduct
      AlignHorz = ahClient
      AllowRemove = False
      CaptionOptions.Text = 'Produkt'
      Control = cmbProduct
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liSelectProduct: TdxLayoutItem
      Parent = lgProduct
      AlignHorz = ahRight
      AllowRemove = False
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
      AllowRemove = False
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
      AllowRemove = False
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
      AllowRemove = False
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
      AllowRemove = False
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = pnlTop
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 61
      ControlOptions.OriginalWidth = 185
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object sprtrTop: TdxLayoutSeparatorItem
      Parent = lgMain
      AllowRemove = False
      CaptionOptions.Text = 'Separator'
      Index = 1
    end
    object lgWeighing: TdxLayoutGroup
      Parent = lgMain
      AlignHorz = ahClient
      AlignVert = avBottom
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      SizeOptions.AssignedValues = [sovSizableVert]
      SizeOptions.SizableVert = True
      SizeOptions.Height = 117
      AllowRemove = False
      LayoutDirection = ldHorizontal
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
      AllowRemove = False
      ShowBorder = False
      Index = 0
    end
    object liScaleValue: TdxLayoutItem
      Parent = lgScaleMass
      AlignHorz = ahClient
      AlignVert = avClient
      AllowRemove = False
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
      AllowRemove = False
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
      AllowRemove = False
      ItemIndex = 1
      ShowBorder = False
      Index = 1
    end
    object lgScaleMass: TdxLayoutGroup
      Parent = lgScale
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      SizeOptions.AssignedValues = [sovSizableVert]
      SizeOptions.SizableVert = False
      AllowRemove = False
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
      SizeOptions.Height = 28
      AllowRemove = False
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = pnlScaleStatus
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 28
      ControlOptions.OriginalWidth = 185
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object sprtrTop2: TdxLayoutSeparatorItem
      Parent = lgMain
      AllowRemove = False
      CaptionOptions.Text = 'Separator'
      Index = 3
    end
    object lgTop: TdxLayoutGroup
      Parent = lgMain
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      AllowRemove = False
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
      AllowRemove = False
      ShowBorder = False
      Index = 0
    end
    object liCarNo: TdxLayoutItem
      Parent = lgCar
      AlignHorz = ahClient
      AlignVert = avClient
      AllowRemove = False
      CaptionOptions.Text = 'NR REJESTRACYJNY'
      Control = edtCarNo
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liTrailerNo: TdxLayoutItem
      Parent = lgRegNo
      AllowRemove = False
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
      SizeOptions.Width = 230
      AllowRemove = False
      ShowBorder = False
      Index = 1
    end
    object liTare: TdxLayoutItem
      Parent = lgTopRight
      AllowRemove = False
      CaptionOptions.Text = 'Tara'
      Control = seTare
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liNetto: TdxLayoutItem
      Parent = lgWeighingData
      AlignHorz = ahClient
      AlignVert = avTop
      AllowRemove = False
      CaptionOptions.Text = 'Netto'
      Control = seNetto
      ControlOptions.AutoControlAreaAlignment = False
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liWeighingType: TdxLayoutItem
      Parent = lgTopRight
      AllowRemove = False
      CaptionOptions.Text = 'Rodzaj wa'#380'enia'
      Control = cmbWeighingType
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liStatusBar: TdxLayoutItem
      Parent = lgBottom
      CaptionOptions.Visible = False
      Control = stsbrBottom
      ControlOptions.OriginalHeight = 20
      ControlOptions.OriginalWidth = 628
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object lgCar: TdxLayoutGroup
      Parent = lgRegNo
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object liSearchCars: TdxLayoutItem
      Parent = lgCar
      AlignHorz = ahRight
      AlignVert = avClient
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      SizeOptions.Width = 40
      CaptionOptions.Visible = False
      Control = btnSearchCar
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 40
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liClearData: TdxLayoutItem
      Parent = lgCar
      AlignHorz = ahRight
      AlignVert = avClient
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      SizeOptions.Width = 40
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnClearData
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 40
      ControlOptions.ShowBorder = False
      Index = 2
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
  end
  inherited actlstMain: TActionList
    Images = ModDispatcher.imgList16
    object actSelectProduct: TAction
      ImageIndex = 2
      OnExecute = actSelectProductExecute
    end
    object actSelectCutomer: TAction
      ImageIndex = 1
      OnExecute = actSelectCutomerExecute
    end
    object actClearProduct: TAction
      ImageIndex = 7
      OnExecute = actClearProductExecute
    end
    object actClearCustomer: TAction
      ImageIndex = 7
      OnExecute = actClearCustomerExecute
    end
    object actDoWeighing: TAction
      Caption = 'WA'#379'ENIE'
      OnExecute = actDoWeighingExecute
    end
    object actSearchCar: TAction
      ImageIndex = 12
      OnExecute = actSearchCarExecute
    end
    object actClearData: TAction
      ImageIndex = 7
      OnExecute = actClearDataExecute
    end
  end
end
