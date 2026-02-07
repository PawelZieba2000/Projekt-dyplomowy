unit cTypes;

interface

type
  TWeighingType = (wtNone, wtFirst, wtSecond, wtSingle);

  TMessageType = (mtInfo, mtWarning, mtError, mtQuestion);

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

implementation

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
