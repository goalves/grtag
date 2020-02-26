defmodule GRTag do
  def schema_base do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @changes_for_removal_fields [
        :__meta__,
        :__struct__,
        :__cardinality__,
        :__field__,
        :__owner__
      ]

      def to_map(struct, extra \\ [])

      def to_map(struct = %{__struct__: _}, extra) do
        struct
        |> Map.drop(@changes_for_removal_fields ++ extra)
        |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, k, changes_for(v)) end)
      end

      def to_map(map, _) when is_nil(map), do: nil
      def to_map(map, _) when is_map(map), do: map
      def to_map(list, extra) when is_list(list), do: Enum.map(list, &to_map(&1, extra))
      def to_map(struct, extra), do: to_map(struct, extra)

      def changes_for(struct, extra \\ [])
      def changes_for(%Ecto.Association.NotLoaded{__cardinality__: :many}, _), do: []
      def changes_for(%Ecto.Association.NotLoaded{}, _), do: nil
      def changes_for(list, extra) when is_list(list), do: Enum.map(list, &changes_for(&1, extra))
      def changes_for(f = %Plug.Upload{}, _), do: f
      def changes_for(d = %DateTime{}, _), do: d
      def changes_for(d = %NaiveDateTime{}, _), do: d
      def changes_for(d = %Date{}, _), do: d
      def changes_for(d = %Time{}, _), do: d
      def changes_for(struct = %{__struct__: _}, extra), do: to_map(struct, extra)
      def changes_for(element, _), do: element

      defp remove_extras(map, _, false), do: map

      defp remove_extras(map, attributes, true) do
        Enum.reduce(map, %{}, fn {key, value}, acc ->
          string_key = Atom.to_string(key)
          has_atom_key? = Map.fetch(attributes, key)
          has_string_key? = Map.fetch(attributes, string_key)

          cond do
            has_atom_key? != :error -> Map.put(acc, key, value)
            has_string_key? != :error -> Map.put(acc, key, value)
            true -> acc
          end
        end)
      end
    end
  end

  def schema do
    quote do
      import Ecto.{Changeset, Query}
      use GRTag, :schema_base

      def params_for(attributes, opts \\ [])

      def params_for(attributes = %{__struct__: _}, opts),
        do: attributes |> changes_for() |> params_for_struct(attributes, opts)

      def params_for(attributes, opts), do: params_for_struct(attributes, __struct__(), opts)

      defp params_for_struct(attributes, struct, opts) do
        remove_extras? = Keyword.get(opts, :remove_extras) || false
        remove_fields = Keyword.get(opts, :remove_fields) || []

        embeds = struct.__meta__.schema.__schema__(:embeds)
        assocs = struct.__meta__.schema.__schema__(:associations)
        fields = struct |> to_map(remove_fields) |> Map.keys() |> Kernel.--(embeds ++ assocs)

        changeset = cast(struct, attributes, fields)
        changeset_with_assocs = Enum.reduce(assocs, changeset, fn assoc, acc -> cast_assoc(acc, assoc) end)
        changeset_with_embeds = Enum.reduce(embeds, changeset_with_assocs, fn embed, acc -> cast_embed(acc, embed) end)

        changeset_with_embeds
        |> apply_changes()
        |> changes_for()
        |> remove_extras(attributes, remove_extras?)
      end

      defoverridable params_for: 1
    end
  end

  defmacro __using__(which) when is_atom(which), do: apply(__MODULE__, which, [])
end
