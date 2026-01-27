unit cTypes;

interface

type
  TScaleConnType = (sctNone, sctSerialPort, sctTcpIp);

  TScaleProtocolType = (sptNone, sptRinstrumC520, sptRhewaDisplay);

  TTransmisionWithDeviceEvent = procedure (pIsConnected : Boolean; pStatus : Integer = 0) of object;
  TReadMassFromDeviceEvent = procedure (pMassFromDevice : Double; pStatus : Integer = 0) of object;

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

  TWeihgingSearchFilters = record

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
  Result := '';
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

end.
