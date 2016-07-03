defmodule EasyBreadcrumbsTest do
  use ExUnit.Case
  doctest EasyBreadcrumbs

  # Testing public breadcrumbs/1 helper function
  test "breadcrumbs/1 returns bootstrap breadcrumbs html for current url" do
    string = "http://website.com/users/1/posts/6/comments/new"
    |> EasyBreadcrumbs.breadcrumbs

    expected_output = "<ul class='breadcrumb'>" <>
    "<li><a href='/'>Home</a></li>" <>
    "<li><a href='/users/1'>User</a></li>" <> 
    "<li><a href='/users/1/posts/6'>Post</a></li>" <>
    "<li><a href='/users/1/posts/6/comments/'>Comments</a></li>" <>
    "<li class='active'>New</li></ul>"

    assert string == expected_output
  end

  test "breadcrumbs/1 sanitizes url to protect against xss attacks" do
    string = "http://website.com/contact/<script>alert(1)</script>"
    |> EasyBreadcrumbs.breadcrumbs

    expected_output = "<ul class='breadcrumb'>" <>
    "<li><a href='/'>Home</a></li>" <>
    "<li class='active'>Contact</li></ul>"

    assert string == expected_output
  end

  ### Below are tests for private functions in EasyBreadcrumbs module
  ### All tests were passing prior to making functions private.

  # # Testing keyword_list/1 function
  # test "to_keyword_list/1 converts a basic list into a keyword list" do
  #   keyword_list = ["1","one","2","two"]
  #   |> EasyBreadcrumbs.to_keyword_list

  #   assert keyword_list == [{"1","one"},{"2","two"}]
  # end

  # # Testing get_relative_path/1
  # test "get_relative_path/1 takes url and returns relative path split into list" do
  #   list = "http://website.com/users/1/posts/3"
  #   |> EasyBreadcrumbs.get_relative_path

  #   assert list == ["users","1","posts","3"]
  # end

  # # Testing index/2 function
  # test "index/2 returns the index of an item in a list, nil if not found" do
  #   index = [1,2,3,4,5]
  #   |> EasyBreadcrumbs.index(4)

  #   not_found = [1,2,3,4,5]
  #   |> EasyBreadcrumbs.index(6)

  #   assert index == 3
  #   assert not_found == nil
  # end

  # # Testing directories/1 function
  # test "directories/1 converts list to list of resource name/id strings" do
  #   list = ["users","6","posts","10"]
  #   |> EasyBreadcrumbs.directories

  #   assert list == ["/","users/6","posts/10"]
  # end

  # # Testing format_name/2 function
  # test "format_name/2 properly formats link text" do
  #   nested = EasyBreadcrumbs.format_name("users","1")
  #   non_nested = EasyBreadcrumbs.format_name("users","")

  #   assert nested == "User"
  #   assert non_nested == "Users"
  # end

  # # Testing names/1 function
  # test "names/1 returns a list of formatted link text names from a path list" do
  #   list = ["users","1","posts","5","comments","","new",""]
  #   |> EasyBreadcrumbs.names

  #   assert list == ["Home","User","Post","Comments","New"]
  # end

  # # Testing set_missing_values/1 function
  # test "set_missing_values/1 adds empty string items to path list where necessary" do
  #   list = ["users","1","posts","5","comments","new"]
  #   |> EasyBreadcrumbs.set_missing_values

  #   assert list == ["users","1","posts","5","comments","","new",""]
  # end

  # # Testing link_item/2 function
  # test "link_item/2 builds a link list item with correct path and name" do
  #   string = ["users/1","posts/6"]
  #   |> EasyBreadcrumbs.link_item("Post")

  #   assert string == "<li><a href='/users/1/posts/6'>Post</a></li>"
  # end

  # # Testing active_item/1 function
  # test "active_item/1 builds an active bootstrap list item for current page" do
  #   string = EasyBreadcrumbs.active_item("User")

  #   assert string == "<li class='active'>User</li>"
  # end

  # # Testing build_items/2 function
  # test "build_items/2 takes names,directories lists and returns string of list items html" do
  #   directory_list = ["/","users/1","posts/6","comments","new"]
  #   name_list = ["Home","User","Post","Comments","New"]

  #   string = EasyBreadcrumbs.build_items(name_list, directory_list)
  #   expected_output = "<li><a href='/'>Home</a></li>" <>
  #   "<li><a href='/users/1'>User</a></li>" <> 
  #   "<li><a href='/users/1/posts/6'>Post</a></li>" <>
  #   "<li><a href='/users/1/posts/6/comments'>Comments</a></li>" <>
  #   "<li class='active'>New</li>"

  #   assert string == expected_output
  # end

  # # Testing list_items/1 function
  # test "list_items/1 builds string of list items html from path list" do
  #   string = ["users","1","posts","6","comments","","new",""]
  #   |> EasyBreadcrumbs.list_items

  #   expected_output = "<li><a href='/'>Home</a></li>" <>
  #   "<li><a href='/users/1'>User</a></li>" <> 
  #   "<li><a href='/users/1/posts/6'>Post</a></li>" <>
  #   "<li><a href='/users/1/posts/6/comments/'>Comments</a></li>" <>
  #   "<li class='active'>New</li>"

  #   assert string == expected_output
  # end

  # # Testing build_html/1 function
  # test "build_html/1 builds breadcrumbs html from current url" do
  #   string = "http://website.com/users/1/posts/6/comments/new"
  #   |> EasyBreadcrumbs.build_html

  #   expected_output = "<ul class='breadcrumb'>" <>
  #   "<li><a href='/'>Home</a></li>" <>
  #   "<li><a href='/users/1'>User</a></li>" <> 
  #   "<li><a href='/users/1/posts/6'>Post</a></li>" <>
  #   "<li><a href='/users/1/posts/6/comments/'>Comments</a></li>" <>
  #   "<li class='active'>New</li></ul>"

  #   assert string == expected_output
  # end
end
