unit cTypes;

interface

type
  TScaleConnType = (sctNone, sctSerialPort, sctTcpIp);

  TScaleProtocolType = (sptNone, sptRinstrumC520, sptRhewaDisplay);

  TWeighingType = (wtNone, wtFirst, wtSecond, wtSingle);

  TMessageType = (mtInfo, mtWarning, mtError, mtQuestion);

  TFormEditType = (fetNone, fetAddNew, fetEdit);

  TScaleConnTypeHelper = record helper for TScaleConnType
    function ToInteger() : Integer;
    function ToString() : String;
    class function FromInteger(AValue: Integer) : TScaleConnType; static;
  end;

  TScaleProtocolTypeHelper = record helper for TScaleProtocolType
    function ToInteger() : Integer;
    function ToString() : String;
    class function FromInteger(AValue: Integer) : TScaleProtocolType; static;
  end;

  TWeighingTypeHelper = record helper for TWeighingType
    function ToInteger() : Integer;
    function ToString() : String;
    class function FromInteger(AValue: Integer) : TWeighingType; static;
  end;

  TSearchFilters = record
    DateStart : TDateTime;
    DateStop : TDateTime;
    IsTranzit : Boolean;
  end;

  TApiResponse = record
    ResponseCode : Integer;
    ErrMsg : String;
  end;

implementation

{ TScaleConnTypeHelper }

class function TScaleConnTypeHelper.FromInteger(
  AValue: Integer): TScaleConnType;
begin
  Result := sctNone;
  for var item : TScaleConnType := Low(TScaleConnType) to High(TScaleConnType) do
  begin
    if item.ToInteger <> AValue then
      Continue;

    Result := item;
    Break;
  end;
end;

function TScaleConnTypeHelper.ToInteger: Integer;
begin
  Result := -1;
  case Self of
    sctSerialPort: Result := 0;
    sctTcpIp: Result := 1;
  end;
end;

function TScaleConnTypeHelper.ToString: String;
begin
  Result := '---';
  case Self of
    sctSerialPort: Result := 'COM';
    sctTcpIp: Result := 'TCP/IP';
  end;
end;

{ TScaleProtocolTypeHelper }

class function TScaleProtocolTypeHelper.FromInteger(
  AValue: Integer): TScaleProtocolType;
begin
  Result := sptNone;
  for var item : TScaleProtocolType := Low(TScaleProtocolType) to High(TScaleProtocolType) do
  begin
    if item.ToInteger <> AValue then
      Continue;

    Result := item;
    Break;
  end;
end;

function TScaleProtocolTypeHelper.ToInteger: Integer;
begin
  Result := 0;
  case Self of
    sptRinstrumC520: Result := 1;
    sptRhewaDisplay: Result := 2;
  end;
end;

function TScaleProtocolTypeHelper.ToString: String;
begin
  Result := '---';
  case Self of
    sptRinstrumC520: Result := 'Rinstrum C520';
    sptRhewaDisplay: Result := 'Rhewa Display';
  end;
end;

{ TWeighingTypeHelper }

class function TWeighingTypeHelper.FromInteger(AValue: Integer): TWeighingType;
begin
  Result := wtNone;
  for var item : TWeighingType := Low(TWeighingType) to High(TWeighingType) do
  begin
    if item.ToInteger <> AValue then
      Continue;

    Result := item;
    Break;
  end;
end;

function TWeighingTypeHelper.ToInteger: Integer;
begin
  Result := -1;
  case Self of
    wtFirst: Result := 0;
    wtSecond: Result := 1;
    wtSingle: Result := 2;
  end;
end;

function TWeighingTypeHelper.ToString: String;
begin
  Result := '---';
  case Self of
    wtFirst: Result := 'Pierwsze wa¿enie';
    wtSecond: Result := 'Drugie wa¿enie';
    wtSingle: Result := 'Pojedyncze wa¿enie';
  end;
end;

end.
