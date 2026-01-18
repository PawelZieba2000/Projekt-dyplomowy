unit cHelpFunctions;

interface

uses
  System.Classes;

type
  THelpFunctions = class
    private
    public
      class procedure SetControlEnable(pControlsArray : Array of TComponent; const pEnabled : Boolean); overload;
      class procedure SetControlEnable(pControl : TComponent; const pEnabled : Boolean); overload;
  end;

implementation

uses
  System.SysUtils, Vcl.Controls;

{ THelpFunctions }

class procedure THelpFunctions.SetControlEnable(pControl: TComponent;
  const pEnabled: Boolean);
begin
  if not Assigned(pControl) then
    Exit;

  if pControl is TWinControl then
    TWinControl(pControl).Enabled := pEnabled;
end;

class procedure THelpFunctions.SetControlEnable(
  pControlsArray: array of TComponent; const pEnabled: Boolean);
begin
  for var tmpComp : TComponent in pControlsArray do
    THelpFunctions.SetControlEnable(tmpComp, pEnabled);
end;

end.
