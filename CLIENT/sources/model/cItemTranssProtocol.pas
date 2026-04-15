unit cItemTranssProtocol;

interface

type

  TItemTranssProtocol = class
    private
      FId : Integer;
      FName : String;

      FMessageToDevice : AnsiString;
      FFrameBeginning : AnsiString;
      FFrameEnding : AnsiString;
      FFrameLength : Integer;
      FMassPosStart : Integer;
      FMassPosEnd : Integer;
      FStablePos : Integer;
      FStableSymbol : AnsiString;
    public
      property Id : Integer read FId write FId;
      property Name : String read FName write FName;
      property MessageToDevice : AnsiString read FMessageToDevice write FMessageToDevice;
      property FrameBeginning : AnsiString read FFrameBeginning write FFrameBeginning;
      property FrameEnding : AnsiString read FFrameEnding write FFrameEnding;
      property FrameLength : Integer read FFrameLength write FFrameLength;
      property MassPosStart : Integer read FMassPosStart write FMassPosStart;
      property MassPosEnd : Integer read FMassPosEnd write FMassPosEnd;
      property StablePos : Integer read FStablePos write FStablePos;
      property StableSymbol : AnsiString read FStableSymbol write FStableSymbol;

      procedure SetDefaultValues();
      procedure AssignValues(const pSource : TItemTranssProtocol);

      constructor Create();
  end;

implementation

{ TItemTranssProtocol }

procedure TItemTranssProtocol.AssignValues(const pSource: TItemTranssProtocol);
begin
  Self.FId := pSource.Id;
  Self.FName := pSource.Name;

  Self.FMessageToDevice := pSource.MessageToDevice;
  Self.FFrameBeginning := pSource.FrameBeginning;
  Self.FFrameEnding := pSource.FrameEnding;
  Self.FFrameLength := pSource.FrameLength;
  Self.FMassPosStart := pSource.MassPosStart;
  Self.FMassPosEnd := pSource.MassPosEnd;
  Self.FStablePos := pSource.StablePos;
  Self.FStableSymbol := pSource.StableSymbol;
end;

constructor TItemTranssProtocol.Create;
begin
  inherited Create();
  Self.SetDefaultValues;
end;

procedure TItemTranssProtocol.SetDefaultValues;
begin
  Self.FId := 0;
  Self.FName := '';

  Self.FMessageToDevice := '';
  Self.FFrameBeginning := '';
  Self.FFrameEnding := '';
  Self.FFrameLength := 1;
  Self.FMassPosStart := 1;
  Self.FMassPosEnd := 1;
  Self.FStablePos := 1;
  Self.FStableSymbol := '';
end;

end.
