defmodule GRTag.Contents.RepositoryTest do
  use GRTag.DataCase

  import GRTag.Factory

  alias Ecto.{Changeset, UUID}
  alias GRTag.Contents.Repository

  describe "changeset/2" do
    @valid_attributes params_for(:repository)
    @invalid_attributes %{}

    test "should return a valid changeset when parameters are valid",
      do: assert(%Changeset{valid?: true} = Repository.changeset(%Repository{}, @valid_attributes))

    test "should return an invalid changeset when parameters are invalid" do
      changeset = Repository.changeset(%Repository{}, @invalid_attributes)
      refute changeset.valid?

      assert errors_on(changeset) == %{
               github_id: ["can't be blank"],
               url: ["can't be blank"],
               name: ["can't be blank"]
             }
    end
  end

  describe "build_map/1" do
    test "should build a map from a starred structure" do
      starred = build(:starred)

      expected_map = %{
        description: starred.description,
        github_id: starred.id,
        url: starred.url,
        language: starred.language,
        name: starred.name
      }

      assert expected_map == Repository.build_map(starred)
    end
  end

  describe "query_by_user_tag/3" do
    test "should return the correct query" do
      user_id = UUID.generate()
      input_field = Faker.Lorem.word()
      queriable = Repository
      query = Repository.query_by_user_tag(queriable, input_field, user_id)

      assert inspect(query) ==
               ~s{#Ecto.Query<from r0 in #{queriable |> Module.split() |> Enum.join(".")}, left_join: t1 in assoc(r0, :tags), where: ilike(t1.name, ^\"%#{
                 input_field
               }%\"), where: t1.user_id == ^\"#{user_id}\">}
    end
  end
end
