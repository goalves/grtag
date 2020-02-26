Bureaucrat.start(
  writer: Bureaucrat.ApiBlueprintWriter,
  default_path: "docs/API_README.md",
  paths: [],
  titles: [],
  title: "Github Repository Tag API",
  env_var: "API_DOCS",
  json_library: Jason
)

ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])
Faker.start()
{:ok, _} = Application.ensure_all_started(:ex_machina)
Ecto.Adapters.SQL.Sandbox.mode(GRTag.Repo, :manual)
