unit backend.Controller;

interface

uses
  backend.Controller.Interfaces,
  backend.Model.Entity.Categories,
  backend.Model.Entity.Genres;

type
  TController = class(TInterfacedObject, iController)
  private
    FCategories: iControllerEntity<TCategories>;
    FGenres: iControllerEntity<TGenres>;
  public
    constructor Create;
    destructor Destroy;
    function Categories : iControllerEntity<TCategories>;
    function Genres: iControllerEntity<TGenres>;
    class function New: iController;
  end;

implementation

{ TController }

uses backend.Controller.Generic;

function TController.Categories: iControllerEntity<TCategories>;
begin
  if not Assigned(FCategories) then
    FCategories := TControllerGeneric<TCategories>.New(Self);
  Result := FCategories;
end;

constructor TController.Create;
begin

end;

destructor TController.Destroy;
begin

end;

function TController.Genres: iControllerEntity<TGenres>;
begin
  if not Assigned(FGenres) then
    FGenres := TControllerGeneric<TGenres>.New(Self);
  Result := FGenres;
end;

class function TController.New: iController;
begin
  Result := Self.Create;
end;

end.
