defmodule GRTag.Github.LinkTest do
  use GRTag.DataCase

  alias GRTag.Github.Link

  @max_random 999_999_999

  describe "parse_from_headers/1" do
    test "should return parsed link" do
      user_id = :random.uniform(@max_random)
      next_url = "https://api.github.com/user/#{user_id}/starred?page=2"
      last_url = "https://api.github.com/user/#{user_id}/starred?page=4"
      headers_with_link = [{"link", "<#{next_url}>; rel=\"next\", <#{last_url}>; rel=\"last\""}]
      assert %Link{next: next_url, last: last_url} == Link.parse_from_headers(headers_with_link)
    end

    test "should return nil when headers do not contain link",
      do: assert([] |> Link.parse_from_headers() |> is_nil())
  end
end
