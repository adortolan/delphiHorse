unit backend.Controller.Generic;

interface

uses
  backend.Controller.Interfaces, backend.Model.DAO;

type
  TControllerGeneric<T: Class, constructor> = class(TInterfacedObject, iControllerEntity<T>)
  private
    FModel: iDAOGeneric<T>;
    [weak]
    FParent: iController;
  public
    constructor Create(pParent: iController);
    destructor Destroy;override;
    function This : iDAOGeneric<T>;
    function &End : iController;
    class function New(pParent: iController):iControllerEntity<T>;
  end;

implementation

{ TControllerGeneric<T> }

constructor TControllerGeneric<T>.Create(pParent: iController);
begin
  FParent := pParent;
  FModel := TDAOGeneric<T>.New;
end;

destructor TControllerGeneric<T>.Destroy;
begin

  inherited;
end;

function TControllerGeneric<T>.&End: iController;
begin
  Result := FParent;
end;

class function TControllerGeneric<T>.New(
  pParent: iController): iControllerEntity<T>;
begin
  Result := Self.Create(pParent);
end;

function TControllerGeneric<T>.This: iDAOGeneric<T>;
begin
  Result := FModel;
end;

end.
