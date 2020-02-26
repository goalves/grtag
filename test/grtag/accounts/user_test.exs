defmodule GRTag.Accounts.UserTest do
  use GRTag.DataCase

  import GRTag.Factory

  alias Ecto.Changeset
  alias GRTag.Accounts.User

  describe "changeset/2" do
    @valid_attributes params_for(:user)
    @invalid_attributes %{}

    test "should return a valid changeset when parameters are valid",
      do: assert(%Changeset{valid?: true} = User.changeset(%User{}, @valid_attributes))

    test "should return an invalid changeset when parameters are invalid" do
      changeset = User.changeset(%User{}, @invalid_attributes)
      refute changeset.valid?
      assert errors_on(changeset) == %{username: ["can't be blank"]}
    end
  end
end
