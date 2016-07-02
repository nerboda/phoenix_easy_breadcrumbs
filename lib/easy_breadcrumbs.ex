defmodule EasyBreadcrumbs do
  import Inflex

  ### Start Public API
  def breadcrumbs(url) do
    build_html(url)
  end
  ### End Public API

  ### Private methods
  defp build_html(url) do
    formatted_path = set_missing_values(url)
    items = list_items(formatted_path)
    "<ul class='breadcrumb'>" <> items <> "</ul>"
  end

  defp list_items(path) do
    name_list = names(path)
    directory_list = directories(path)

    build_items(name_list, directory_list)
  end

  defp build_items(names, directories) do
    items_list = Enum.map(directories, fn item ->
      current_index = index(directories, item)
      if item == List.last(directories) do
        Enum.at(names, current_index) |> active_item
      else
        Enum.slice(directories, 1, current_index)
        |> link_item(Enum.at(names, current_index))
      end
    end)

    Enum.join(items_list)
  end

  defp active_item(name) do
    "<li class='active'>#{name}</li>"
  end

  defp link_item(directories, name) do
    path = Enum.join(directories, "/")
    "<li><a href='/#{path}'>#{name}</a></li>"
  end

  defp set_missing_values(path) do
    list = Enum.chunk(path, 2)
    |> Enum.map(fn item ->
      if missing_value?(Enum.at(item,1)), do: [hd(item), "", tl(item)], else: item
    end)
    |> List.flatten

    if odd_length?(list), do: list ++ [""], else: list
  end

  defp names(path) do
    name_list = to_keyword_list(path)
    |> Enum.map(fn({key,val}) ->
      format_name(key, val)
    end)
    ["Home"] ++ name_list
  end

  defp format_name(name, val) do
    if is_not_number?(val), do: String.capitalize(name), else: singularize(name) |> String.capitalize
  end

  defp directories(path) do
    directory_list = to_keyword_list(path)
    |> Enum.map(fn({key,val}) ->
      "#{key}/#{val}"
    end)
    ["/"] ++ directory_list
  end

  
  ### Utility functions
  defp index(list, item) do
    Enum.find_index(list, fn x -> x == item end)
  end

  # defp get_relative_path(url) do
  #   split = String.split(url, "/")
  #   Enum.slice(split, 3, Enum.count(split) - 1)
  # end

  defp is_not_number?(string) do
    !Regex.match?(~r/[0-9]/, string)
  end

  defp missing_value?(val) do
    val && is_not_number?(val)
  end

  defp odd_length?(list) do
    rem(Enum.count(list), 2) != 0 
  end

  # defp sanitize(url) do
  #   ActionController::Base.helpers.sanitize(url)
  # end

  defp to_keyword_list(list) do
    key_list = List.delete_at(list, 0)
    |> Enum.take_every(2)
    value_list = Enum.take_every(list, 2)

    Enum.zip(value_list, key_list)
  end
end
