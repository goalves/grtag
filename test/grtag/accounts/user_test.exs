defmodule GRTag.Accounts.UserTest do
  use GRTag.DataCase, async: true

  import GRTag.Factory

  alias Ecto.Changeset
  alias GRTag.Accounts.User

  describe "changeset/2" do
    test "returns a valid changeset when parameters are valid" do
      attributes = params_for(:user)
      assert %Changeset{valid?: true} = User.changeset(%User{}, attributes)
    end

    test "returns an invalid changeset when parameters are invalid" do
      invalid_attributes = %{}
      changeset = User.changeset(%User{}, invalid_attributes)
      refute changeset.valid?
      assert errors_on(changeset) == %{username: ["can't be blank"]}
    end
  end
end
