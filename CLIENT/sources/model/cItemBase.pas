unit cItemBase;

interface

type
  TItemBase = class
    private
      FId : Integer;
      FIdErp : Integer;
      FModificationDate : TDateTime;
      FIsDeleted : Boolean;
      FIsModified : Boolean;

      function GetId: Integer;
      procedure SetId(const Value: Integer);
      function GetIdErp: Integer;
      procedure SetIdErp(const Value: Integer);
      function GetIsDeleted: Boolean;
      procedure SetIsDeleted(const Value: Boolean);
      function GetIsModified: Boolean;
      procedure SetIsModified(const Value: Boolean);
      function GetModificationDate: TDateTime;
      procedure SetModificationDate(const Value: TDateTime);
    public
      property Id: Integer read GetId write SetId;
      property IdErp: Integer read GetIdErp write SetIdErp;
      property ModificationDate: TDateTime read GetModificationDate write SetModificationDate;
      property IsDeleted: Boolean read GetIsDeleted write SetIsDeleted;
      property IsModified: Boolean read GetIsModified write SetIsModified;

      procedure SetDefaultValues(); virtual;

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

uses
  System.SysUtils;

{ TBaseItem }

constructor TItemBase.Create;
begin
  inherited;
  Self.SetDefaultValues;
end;

destructor TItemBase.Destroy;
begin
  inherited;
end;

function TItemBase.GetId: Integer;
begin
  Result := Self.FId;
end;

function TItemBase.GetIdErp: Integer;
begin
  Result := Self.FIdErp;
end;

function TItemBase.GetIsDeleted: Boolean;
begin
  Result := Self.FIsDeleted;
end;

function TItemBase.GetIsModified: Boolean;
begin
  Result := Self.FIsModified;
end;

function TItemBase.GetModificationDate: TDateTime;
begin
  Result := Self.FModificationDate;
end;

procedure TItemBase.SetDefaultValues;
begin
  Self.Id := 0;
  Self.IdErp := 0;
  Self.ModificationDate := MinDateTime;
  Self.IsDeleted := False;
  Self.IsModified := False;
end;

procedure TItemBase.SetId(const Value: Integer);
begin
  if Value <> Self.Id then
    Self.FId := Value;
end;

procedure TItemBase.SetIdErp(const Value: Integer);
begin
  if Value <> Self.IdErp then
    Self.FIdErp := Value;
end;

procedure TItemBase.SetIsDeleted(const Value: Boolean);
begin
  if Value <> Self.IsDeleted then
    Self.FIsDeleted := Value;
end;

procedure TItemBase.SetIsModified(const Value: Boolean);
begin
  if Value <> Self.IsModified then
    Self.FIsModified := Value;
end;

procedure TItemBase.SetModificationDate(const Value: TDateTime);
begin
  if Value <> Self.ModificationDate then
    Self.FModificationDate := Value;
end;

end.
