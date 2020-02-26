defmodule GRTag.Workers.ImporterTest do
  use GRTag.DataCase

  import ExUnit.CaptureLog
  import Mock
  import GRTag.HTTPFactory

  alias Faker.Internet
  alias GRTag.Contents.Repository
  alias GRTag.Workers.Importer
  alias Oban.Job
  alias Tesla.Client

  describe "perform/1" do
    @invalid_parameters %{"invalid" => "parameters"}

    test "should insert repositories when parameters are valid" do
      username = Internet.user_name()
      user_starred_success = user_starred_success()
      {:ok, %{body: [body]}} = user_starred_success

      with_mocks [
        {Tesla, [], get: fn _, _ -> user_starred_success end},
        {Tesla, [], client: fn _ -> %Client{} end}
      ] do
        assert {:ok, [repository = %Repository{}]} = Importer.perform(%{"github_username" => username}, %Job{})
        assert repository.github_id == body["id"]
        assert Repository |> Repo.all() |> Enum.count() == 1
      end
    end

    @tag :capture_log
    test "should return an error when parameters are invalid",
      do: assert({:error, :invalid_parameters} == Importer.perform(@invalid_parameters, %Job{}))

    test "should log errors when parameters do not match perform function" do
      function = fn -> Importer.perform(@invalid_parameters, %Job{}) end

      assert capture_log(function) =~
               "Parameters did not match for importing repositories: #{inspect(@invalid_parameters)}"
    end
  end
end
