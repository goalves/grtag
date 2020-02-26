defmodule GRTag.HTTPFactory do
  @max_random 999_999_999
  @api_base "https://api.github.com"
  def success(response_body \\ %{}), do: {:ok, %Tesla.Env{status: 200, body: response_body}}
  def bad_request(response_body \\ %{}), do: {:ok, %Tesla.Env{status: 400, body: response_body}}

  def success_paginated(next_url, response_body \\ %{}) do
    headers = [{"link", "<#{next_url}>; rel=\"next\", <#{next_url}>; rel=\"last\""}]
    {:ok, %Tesla.Env{status: 200, body: response_body, headers: headers}}
  end

  def tesla_connection_error, do: {:error, :nxdomain}

  def user_starred_success do
    id = :random.uniform(@max_random)
    user_id = :random.uniform(@max_random)
    username = Faker.Internet.user_name()
    repository = Faker.Lorem.word()
    description = Faker.Lorem.paragraph()
    datetime = DateTime.utc_now()

    response_body = [
      %{
        "id" => id,
        "node_id" => "MDEwOlJlcG9zaXRvcnkyMDE4ODI1OQ==",
        "name" => "#{repository}",
        "full_name" => "#{username}/#{repository}",
        "private" => false,
        "owner" => %{
          "login" => "#{username}",
          "id" => user_id,
          "node_id" => user_id |> to_string() |> Base.encode64(),
          "avatar_url" => "https://avatars0.githubusercontent.com/u/#{user_id}?v=4",
          "gravatar_id" => "",
          "url" => "#{@api_base}/users/#{username}",
          "html_url" => "https://github.com/#{username}",
          "followers_url" => "#{@api_base}/users/#{username}/followers",
          "following_url" => "#{@api_base}/users/#{username}/following{/other_user}",
          "gists_url" => "#{@api_base}/users/#{username}/gists{/gist_id}",
          "starred_url" => "#{@api_base}/users/#{username}/starred{/owner}{/repo}",
          "subscriptions_url" => "#{@api_base}/users/#{username}/subscriptions",
          "organizations_url" => "#{@api_base}/users/#{username}/orgs",
          "repos_url" => "#{@api_base}/users/#{username}/repos",
          "events_url" => "#{@api_base}/users/#{username}/events{/privacy}",
          "received_events_url" => "#{@api_base}/users/#{username}/received_events",
          "type" => "User",
          "site_admin" => false
        },
        "html_url" => "https://github.com/#{username}/#{repository}",
        "description" => description,
        "fork" => false,
        "url" => "#{@api_base}/repos/#{username}/#{repository}",
        "forks_url" => "#{@api_base}/repos/#{username}/#{repository}/forks",
        "keys_url" => "#{@api_base}/repos/#{username}/#{repository}/keys{/key_id}",
        "collaborators_url" => "#{@api_base}/repos/#{username}/#{repository}/collaborators{/collaborator}",
        "teams_url" => "#{@api_base}/repos/#{username}/#{repository}/teams",
        "hooks_url" => "#{@api_base}/repos/#{username}/#{repository}/hooks",
        "issue_events_url" => "#{@api_base}/repos/#{username}/#{repository}/issues/events{/number}",
        "events_url" => "#{@api_base}/repos/#{username}/#{repository}/events",
        "assignees_url" => "#{@api_base}/repos/#{username}/#{repository}/assignees{/user}",
        "branches_url" => "#{@api_base}/repos/#{username}/#{repository}/branches{/branch}",
        "tags_url" => "#{@api_base}/repos/#{username}/#{repository}/tags",
        "blobs_url" => "#{@api_base}/repos/#{username}/#{repository}/git/blobs{/sha}",
        "git_tags_url" => "#{@api_base}/repos/#{username}/#{repository}/git/tags{/sha}",
        "git_refs_url" => "#{@api_base}/repos/#{username}/#{repository}/git/refs{/sha}",
        "trees_url" => "#{@api_base}/repos/#{username}/#{repository}/git/trees{/sha}",
        "statuses_url" => "#{@api_base}/repos/#{username}/#{repository}/statuses/{sha}",
        "languages_url" => "#{@api_base}/repos/#{username}/#{repository}/languages",
        "stargazers_url" => "#{@api_base}/repos/#{username}/#{repository}/stargazers",
        "contributors_url" => "#{@api_base}/repos/#{username}/#{repository}/contributors",
        "subscribers_url" => "#{@api_base}/repos/#{username}/#{repository}/subscribers",
        "subscription_url" => "#{@api_base}/repos/#{username}/#{repository}/subscription",
        "commits_url" => "#{@api_base}/repos/#{username}/#{repository}/commits{/sha}",
        "git_commits_url" => "#{@api_base}/repos/#{username}/#{repository}/git/commits{/sha}",
        "comments_url" => "#{@api_base}/repos/#{username}/#{repository}/comments{/number}",
        "issue_comment_url" => "#{@api_base}/repos/#{username}/#{repository}/issues/comments{/number}",
        "contents_url" => "#{@api_base}/repos/#{username}/#{repository}/contents/{+path}",
        "compare_url" => "#{@api_base}/repos/#{username}/#{repository}/compare/{base}...{head}",
        "merges_url" => "#{@api_base}/repos/#{username}/#{repository}/merges",
        "archive_url" => "#{@api_base}/repos/#{username}/#{repository}/{archive_format}{/ref}",
        "downloads_url" => "#{@api_base}/repos/#{username}/#{repository}/downloads",
        "issues_url" => "#{@api_base}/repos/#{username}/#{repository}/issues{/number}",
        "pulls_url" => "#{@api_base}/repos/#{username}/#{repository}/pulls{/number}",
        "milestones_url" => "#{@api_base}/repos/#{username}/#{repository}/milestones{/number}",
        "notifications_url" => "#{@api_base}/repos/#{username}/#{repository}/notifications{?since,all,participating}",
        "labels_url" => "#{@api_base}/repos/#{username}/#{repository}/labels{/name}",
        "releases_url" => "#{@api_base}/repos/#{username}/#{repository}/releases{/id}",
        "deployments_url" => "#{@api_base}/repos/#{username}/#{repository}/deployments",
        "created_at" => DateTime.to_iso8601(datetime),
        "updated_at" => DateTime.to_iso8601(datetime),
        "pushed_at" => DateTime.to_iso8601(datetime),
        "git_url" => "git://github.com/#{username}/#{repository}.git",
        "ssh_url" => "git@github.com:#{username}/#{repository}.git",
        "clone_url" => "https://github.com/#{username}/#{repository}.git",
        "svn_url" => "https://github.com/#{username}/#{repository}",
        "homepage" => "",
        "size" => :random.uniform(@max_random),
        "stargazers_count" => :random.uniform(@max_random),
        "watchers_count" => :random.uniform(@max_random),
        "language" => "Elixir",
        "has_issues" => true,
        "has_projects" => false,
        "has_downloads" => true,
        "has_wiki" => true,
        "has_pages" => true,
        "forks_count" => :random.uniform(@max_random),
        "mirror_url" => nil,
        "archived" => false,
        "disabled" => false,
        "open_issues_count" => :random.uniform(@max_random),
        "license" => %{
          "key" => "other",
          "name" => "Other",
          "spdx_id" => "NOASSERTION",
          "url" => nil,
          "node_id" => id |> to_string() |> Base.encode64()
        },
        "forks" => :random.uniform(@max_random),
        "open_issues" => :random.uniform(@max_random),
        "watchers" => :random.uniform(@max_random),
        "default_branch" => "master"
      }
    ]

    success(response_body)
  end
end
