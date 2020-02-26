defmodule GRTag.Contents.TagTest do
  use GRTag.DataCase

  import GRTag.Factory

  alias Ecto.Changeset
  alias GRTag.Contents.Tag

  describe "changeset/2" do
    @valid_attributes params_for(:tag)
    @invalid_attributes %{}

    test "should return a valid changeset when parameters are valid",
      do: assert(%Changeset{valid?: true} = Tag.changeset(%Tag{}, @valid_attributes))

    test "should return an invalid changeset when parameters are invalid" do
      changeset = Tag.changeset(%Tag{}, @invalid_attributes)
      refute changeset.valid?

      assert errors_on(changeset) == %{
               user_id: ["can't be blank"],
               repository_id: ["can't be blank"],
               name: ["can't be blank"]
             }
    end
  end
end
