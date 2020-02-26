defmodule GRTag.Workers.Importer do
  use Oban.Worker, queue: :importers, max_attempts: 5

  require Logger

  alias GRTag.Contents
  alias GRTag.Contents.Repository
  alias Oban.Job

  @impl Oban.Worker
  @spec perform(any(), Job.t()) :: {:ok, [%Repository{}]} | {:error, any}
  def perform(parameters = %{"github_username" => github_username}, job = %Job{}) when is_map(parameters) do
    Logger.info("Importing repositories for job #{inspect(job)}")
    Contents.import_user_repositories(github_username)
  end

  def perform(parameters, job = %Job{}) do
    Logger.error("Parameters did not match for importing repositories: #{inspect(parameters)} on Job: #{inspect(job)}")
    {:error, :invalid_parameters}
  end
end
