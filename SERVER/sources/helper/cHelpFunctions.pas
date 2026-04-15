unit cHelpFunctions;

interface

uses
  System.Classes, cxGridTableView, cxDropDownEdit, Vcl.StdCtrls;

type
  THelpFunctions = class
    private
    public
      class procedure SetControlEnable(pControlsArray : Array of TComponent; const pEnabled : Boolean); overload;
      class procedure SetControlEnable(pControl : TComponent; const pEnabled : Boolean); overload;

      class function GetCurrentDirectory() : String;
      class function GetAppName() : String;

      class function GetActiveWindow() : TComponent;

      class procedure SetGridDefaultOptions(pGridTableView: TcxGridTableView);

      class procedure FillWeighingTypeCombo(pCombo : TcxComboBox);

      class procedure FillCustomersCombo(pCombo : TcxComboBox);
      class procedure FillProductsCombo(pCombo : TcxComboBox);

      class procedure SetComboItemIndex(pCombo : TCustomComboBox; const pText : String);

      class function GetStringFromComCombo(const pCombo : TCustomComboBox) : String;

      class function GetIPAddress(): String;
  end;

implementation

uses
  System.SysUtils, Vcl.Controls, Vcl.ActnList, System.IOUtils, Vcl.Forms,
  cxFilter, cTypes, cItemProduct, cManagerProducts, cItemCustomer,
  cManagerCustomers, IdStack;

{ THelpFunctions }

class function THelpFunctions.GetActiveWindow: TComponent;
begin
  Result := FindControl(Application.ActiveFormHandle);
end;

class function THelpFunctions.GetAppName: String;
begin
  Result := ExtractFileName(Application.ExeName);
end;

class function THelpFunctions.GetCurrentDirectory: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));
end;

class function THelpFunctions.GetIPAddress: String;
begin
  TIdStack.IncUsage;
  try
    Result := GStack.LocalAddress;
  finally
    TIdStack.DecUsage;
  end;
end;

class function THelpFunctions.GetStringFromComCombo(
  const pCombo: TCustomComboBox): String;
begin
  Result := '';
  if not (Assigned(pCombo) and (pCombo.ItemIndex > -1) and (pCombo.ItemIndex < pCombo.Items.Count)) then
    Exit;

  Result := pCombo.Items[pCombo.ItemIndex];
end;

class procedure THelpFunctions.FillCustomersCombo(pCombo: TcxComboBox);
begin
  if not Assigned(pCombo) then
    Exit;

  pCombo.Properties.Items.BeginUpdate;
  try
    pCombo.Properties.Items.Clear;
    for var tmpCustomer : TItemCustomer in TManagerCustomers.Instance.CustomerList do
      pCombo.Properties.Items.AddObject(tmpCustomer.FullName, tmpCustomer);

    pCombo.ItemIndex := -1;
  finally
    pCombo.Properties.Items.EndUpdate;
  end;
end;

class procedure THelpFunctions.FillProductsCombo(pCombo: TcxComboBox);
begin
  if not Assigned(pCombo) then
    Exit;

  pCombo.Properties.Items.BeginUpdate;
  try
    pCombo.Properties.Items.Clear;
    for var tmpProduct : TItemProduct in TManagerProducts.Instance.ProductList do
      pCombo.Properties.Items.AddObject(tmpProduct.FullName, tmpProduct);

    pCombo.ItemIndex := -1;
  finally
    pCombo.Properties.Items.EndUpdate;
  end;
end;

class procedure THelpFunctions.FillWeighingTypeCombo(pCombo: TcxComboBox);
begin
  if not Assigned(pCombo) then
    Exit;

  pCombo.Properties.Items.BeginUpdate;
  try
    pCombo.Properties.Items.Clear;
    for var item : TWeighingType := Low(TWeighingType) to High(TWeighingType) do
    begin
      if item = wtNone then
        Continue;

      pCombo.Properties.Items.Add(item.ToString);
    end;

    pCombo.ItemIndex := 0;
  finally
    pCombo.Properties.Items.EndUpdate;
  end;
end;

class procedure THelpFunctions.SetComboItemIndex(pCombo: TCustomComboBox;
  const pText: String);
begin
  if not Assigned(pCombo) then
    Exit;

  pCombo.ItemIndex := -1;
  for var I : Integer := 0 to pCombo.Items.Count - 1 do
  begin
    if pCombo.Items[I] <> pText then
      Continue;

    pCombo.ItemIndex := I;
    Break;
  end;
end;

class procedure THelpFunctions.SetControlEnable(pControl: TComponent;
  const pEnabled: Boolean);
begin
  if not Assigned(pControl) then
    Exit;

  if pControl is TWinControl then
    TWinControl(pControl).Enabled := pEnabled
  else if pControl is TAction then
    TAction(pControl).Enabled := pEnabled;
end;

class procedure THelpFunctions.SetGridDefaultOptions(
  pGridTableView: TcxGridTableView);
begin
  if not Assigned(pGridTableView) then
    Exit;

  with pGridTableView.DataController do
  begin
    Filter.Options := [fcoCaseInsensitive];
  end;

  with pGridTableView.FilterRow do
  begin
    Visible := True;
    ApplyChanges := fracImmediately;
    OperatorCustomization := True;
  end;

  with pGridTableView.OptionsData do
  begin
    CancelOnExit := False;
    Deleting := False;
    DeletingConfirmation := False;
    Editing := False;
    Inserting := False;
  end;

  with pGridTableView.OptionsView do
  begin
    NoDataToDisplayInfoText := '<Brak danych do wyœwietlenia>';
    CellAutoHeight := True;
    ColumnAutoWidth := True;
    GroupByBox := False;
    HeaderAutoHeight := True;
  end;

  for var I : Integer := 0 to pGridTableView.ColumnCount - 1 do
  begin
    var tmpColumn : TcxGridColumn := pGridTableView.Columns[I];

    tmpColumn.HeaderAlignmentHorz := taCenter;
    tmpColumn.Options.FilterRowOperator := foContains;
  end;
end;

class procedure THelpFunctions.SetControlEnable(
  pControlsArray: array of TComponent; const pEnabled: Boolean);
begin
  for var tmpComp : TComponent in pControlsArray do
    THelpFunctions.SetControlEnable(tmpComp, pEnabled);
end;

end.
