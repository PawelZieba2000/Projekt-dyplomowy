inherited FormProductAddEdit: TFormProductAddEdit
  ClientHeight = 257
  ClientWidth = 402
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 418
  ExplicitHeight = 296
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    Width = 402
    Height = 257
    ExplicitWidth = 402
    ExplicitHeight = 257
    inherited btnOk: TcxButton
      Left = 233
      Top = 220
      TabOrder = 3
      ExplicitLeft = 233
      ExplicitTop = 220
    end
    inherited btnCancel: TcxButton
      Left = 315
      Top = 220
      TabOrder = 4
      ExplicitLeft = 315
      ExplicitTop = 220
    end
    object edtName: TcxTextEdit [2]
      Left = 53
      Top = 74
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 337
    end
    object edtCode: TcxTextEdit [3]
      Left = 53
      Top = 104
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 337
    end
    object sePrice: TcxSpinEdit [4]
      Left = 53
      Top = 134
      Properties.Alignment.Horz = taRightJustify
      Properties.ValueType = vtFloat
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 2
      Width = 121
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
      ItemIndex = 2
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
        4646463B7D3C2F7374796C653E0D0A3C673E0D0A09093C6720636C6173733D22
        737431223E0D0A0909093C7265637420783D22322220793D2231322220636C61
        73733D2259656C6C6F77222077696474683D22313822206865696768743D2231
        38222F3E0D0A09093C2F673E0D0A09093C706F6C79676F6E20636C6173733D22
        59656C6C6F772220706F696E74733D2232322C31312E342032322C3330203330
        2C32322033302C332E34202623393B222F3E0D0A09093C6720636C6173733D22
        737430223E0D0A0909093C7061746820636C6173733D2259656C6C6F77222064
        3D224D392E392C313048326C382D3868372E394C392E392C31307A204D32302E
        372C326C2D382C3868372E396C382D384832302E377A222F3E0D0A09093C2F67
        3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
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
    object liPrice: TdxLayoutItem
      Parent = lgPrice
      AllowRemove = False
      CaptionOptions.Text = 'Cena'
      Control = sePrice
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object lgPrice: TdxLayoutGroup
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
    object liLblPrice: TdxLayoutLabeledItem
      Parent = lgPrice
      AlignHorz = ahLeft
      AlignVert = avClient
      AllowRemove = False
      CaptionOptions.Text = '[z'#322'/kg]'
      Index = 1
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
  end
end
