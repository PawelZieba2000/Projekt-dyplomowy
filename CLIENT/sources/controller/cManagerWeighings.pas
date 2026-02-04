unit cManagerWeighings;

interface

uses
  System.Generics.Collections, cDataSourceWeighings, cItemWeighing;

type
  TManagerWeighings = class
    private
      FWeighingList : TObjectList<TItemWeighing>;
      FWeighingsDS : TDataSourceWeighings;

      class var FInstance : TManagerWeighings;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property WeighingList : TObjectList<TItemWeighing> read FWeighingList;
      property WeighingDS : TDataSourceWeighings read FWeighingsDS;

      constructor Create(); overload;
      class function Instance : TManagerWeighings;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils;

{ TManagerWeighings }

constructor TManagerWeighings.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerWeighings.CreateInstance;
begin
  inherited Create;

  Self.FWeighingList := TObjectList<TItemWeighing>.Create();
  Self.FWeighingsDS := TDataSourceWeighings.Create(Self.FWeighingList);
end;

destructor TManagerWeighings.Destroy;
begin
  Self.FWeighingList.Free;
  Self.FWeighingsDS.Free;

  inherited;
end;

class function TManagerWeighings.Instance: TManagerWeighings;
begin
  if not Assigned(FInstance) then
    FInstance := TManagerWeighings.CreateInstance;

  Result := FInstance;
end;

class procedure TManagerWeighings.ReleaseInstance;
begin
  FInstance.Free;
end;

end.
