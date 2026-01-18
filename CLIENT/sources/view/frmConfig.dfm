inherited FormConfig: TFormConfig
  Caption = 'Ustawienia'
  ClientHeight = 315
  ClientWidth = 384
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 400
  ExplicitHeight = 354
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    Width = 384
    Height = 315
    inherited btnOk: TcxButton
      Left = 215
      Top = 278
      TabOrder = 4
      ExplicitLeft = 215
      ExplicitTop = 278
    end
    inherited btnCancel: TcxButton
      Left = 297
      Top = 278
      TabOrder = 5
      ExplicitLeft = 297
      ExplicitTop = 278
    end
    object edtApiUrl: TcxTextEdit [2]
      Left = 129
      Top = 95
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 229
    end
    object edtScaleIp: TcxTextEdit [3]
      Left = 129
      Top = 190
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Width = 229
    end
    object seScalePort: TcxSpinEdit [4]
      Left = 129
      Top = 220
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      Properties.Alignment.Horz = taRightJustify
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 3
      Width = 229
    end
    object edtbtnApiLogPath: TcxButtonEdit [5]
      Left = 129
      Top = 125
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 1
      Width = 229
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
    object lgCenter: TdxLayoutGroup
      Parent = lgMain
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      AllowRemove = False
      ItemIndex = 1
      ShowBorder = False
      Index = 2
    end
    object imgTittle: TdxLayoutImageItem
      Parent = lgTop
      AlignHorz = ahLeft
      AlignVert = avClient
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
        423131353B7D262331333B262331303B2623393B2E426C61636B7B66696C6C3A
        233732373237323B7D262331333B262331303B2623393B2E477265656E7B6669
        6C6C3A233033394332333B7D262331333B262331303B2623393B2E5265647B66
        696C6C3A234431314331433B7D262331333B262331303B2623393B2E7374307B
        6F7061636974793A302E37353B7D262331333B262331303B2623393B2E737431
        7B6F7061636974793A302E353B7D3C2F7374796C653E0D0A3C672069643D2253
        657474696E6773223E0D0A09093C7061746820636C6173733D22426C75652220
        643D224D33302C3138762D346C2D342E342D302E37632D302E322D302E382D30
        2E352D312E352D302E392D322E316C322E362D332E366C2D322E382D322E386C
        2D332E362C322E36632D302E372D302E342D312E342D302E372D322E312D302E
        394C31382C32682D3420202623393B2623393B6C2D302E372C342E34632D302E
        382C302E322D312E352C302E352D322E312C302E394C372E352C342E374C342E
        372C372E356C322E362C332E36632D302E342C302E372D302E372C312E342D30
        2E392C322E314C322C313476346C342E342C302E3763302E322C302E382C302E
        352C312E352C302E392C322E3120202623393B2623393B6C2D322E362C332E36
        6C322E382C322E386C332E362D322E3663302E372C302E342C312E342C302E37
        2C322E312C302E394C31342C333068346C302E372D342E3463302E382D302E32
        2C312E352D302E352C322E312D302E396C332E362C322E366C322E382D322E38
        6C2D322E362D332E3620202623393B2623393B63302E342D302E372C302E372D
        312E342C302E392D322E314C33302C31387A204D31362C3230632D322E322C30
        2D342D312E382D342D3463302D322E322C312E382D342C342D3473342C312E38
        2C342C344332302C31382E322C31382E322C32302C31362C32307A222F3E0D0A
        093C2F673E0D0A3C2F7376673E0D0A}
      Index = 0
    end
    object liLblTitle: TdxLayoutLabeledItem
      Parent = lgTop
      AlignHorz = ahLeft
      AlignVert = avClient
      LayoutLookAndFeel = ModDispatcher.dxLayoutSkin_Title
      CaptionOptions.Text = 'Ustawienia'
      Index = 1
    end
    object sprtrTop: TdxLayoutSeparatorItem
      Parent = lgMain
      CaptionOptions.Text = 'Separator'
      Index = 1
    end
    object liApiUrl: TdxLayoutItem
      Parent = lgApiConfig
      CaptionOptions.Text = 'Adres URL serwera'
      Control = edtApiUrl
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object lgApiConfig: TdxLayoutGroup
      Parent = lgCenter
      CaptionOptions.Text = 'Po'#322#261'czenie do API'
      ItemIndex = 1
      Index = 0
    end
    object lgScaleConfig: TdxLayoutGroup
      Parent = lgCenter
      CaptionOptions.Text = 'Po'#322#261'czenie z miernikiem wagowym'
      ItemIndex = 1
      Index = 1
    end
    object liScaleIp: TdxLayoutItem
      Parent = lgScaleConfig
      CaptionOptions.Text = 'Adres IP miernika'
      Control = edtScaleIp
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liScalePort: TdxLayoutItem
      Parent = lgScaleConfig
      CaptionOptions.Text = 'Port miernika'
      Control = seScalePort
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liApiLogPath: TdxLayoutItem
      Parent = lgApiConfig
      CaptionOptions.Text = #346'cie'#380'ka do log'#243'w'
      Control = edtbtnApiLogPath
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
  end
  inherited actlstMain: TActionList
    inherited actOk: TAction
      Caption = 'Zapisz'
    end
  end
end
