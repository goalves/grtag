defmodule GRTag.Contents.RepositoryTest do
  use GRTag.DataCase, async: true

  import GRTag.Factory

  alias Ecto.{Changeset, UUID}
  alias Faker.Lorem
  alias GRTag.Contents.Repository

  describe "changeset/2" do
    test "returns a valid changeset when parameters are valid" do
      attributes = params_for(:repository)
      assert %Changeset{valid?: true} = Repository.changeset(%Repository{}, attributes)
    end

    test "returns an invalid changeset when parameters are invalid" do
      invalid_attributes = %{}
      changeset = Repository.changeset(%Repository{}, invalid_attributes)
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

  describe "filters/2" do
    test "returns a Repository queriable when parameters map is empty",
      do: assert({:ok, Repository} == Repository.filters(Repository, %{}))

    test "returns a similar user tag queriable when parameters map contains tag_user_id and tag_name" do
      tag_user_id = UUID.generate()
      tag_name = Lorem.word()
      parameters = %{"tag_user_id" => tag_user_id, "tag_name" => tag_name}
      queriable = Repository
      queriable_expected = queriable |> Module.split() |> Enum.join(".")

      assert {:ok, query} = Repository.filters(queriable, parameters)

      assert inspect(query) ==
               ~s{#Ecto.Query<from r0 in #{queriable_expected}, left_join: t1 in assoc(r0, :tags), where: ilike(t1.name, ^\"%#{
                 tag_name
               }%\"), where: t1.user_id == ^\"#{tag_user_id}\">}
    end
  end

  describe "query_by_user_tag/3" do
    test "returns the correct query" do
      tag_user_id = UUID.generate()
      tag_name = Lorem.word()
      queriable = Repository
      queriable_expected = queriable |> Module.split() |> Enum.join(".")
      query = Repository.query_by_user_tag(queriable, tag_name, tag_user_id)

      assert inspect(query) ==
               ~s{#Ecto.Query<from r0 in #{queriable_expected}, left_join: t1 in assoc(r0, :tags), where: ilike(t1.name, ^\"%#{
                 tag_name
               }%\"), where: t1.user_id == ^\"#{tag_user_id}\">}
    end
  end
end
