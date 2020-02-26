defmodule GRTag.ValidatorTest do
  use GRTag.DataCase

  alias Ecto.UUID
  alias GRTag.Validator

  describe "validate_uuid/1" do
    test "should return that an UUID is valid" do
      uuid = UUID.generate()
      assert :ok == Validator.validate_uuid(uuid)
    end

    test "should return invalid if the passed element is a string but not an UUID" do
      string = "not_an_uuid"
      assert {:error, :invalid_uuid} == Validator.validate_uuid(string)
    end

    test "should return invalid for other kinds of elements" do
      invalid_elements = [:a, 1, 1.0, <<1, 0>>, []]
      assert Enum.all?(invalid_elements, fn element -> Validator.validate_uuid(element) == {:error, :invalid_uuid} end)
    end
  end
end
