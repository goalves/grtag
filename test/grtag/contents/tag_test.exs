defmodule GRTag.Contents.TagTest do
  use GRTag.DataCase, async: true

  import GRTag.Factory

  alias Ecto.Changeset
  alias GRTag.Contents.Tag

  describe "changeset/2" do
    test "returns a valid changeset when parameters are valid" do
      attributes = params_for(:tag)
      assert %Changeset{valid?: true} = Tag.changeset(%Tag{}, attributes)
    end

    test "returns an invalid changeset when parameters are invalid" do
      invalid_attributes = %{}
      changeset = Tag.changeset(%Tag{}, invalid_attributes)
      refute changeset.valid?

      assert errors_on(changeset) == %{
               user_id: ["can't be blank"],
               repository_id: ["can't be blank"],
               name: ["can't be blank"]
             }
    end
  end
end
