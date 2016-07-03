# EasyBreadcrumbs

A super easy way to add bootstrap breadcrumbs to every page of your app.

## Installation

  1. Add easy_breadcrumbs to your list of dependencies in `mix.exs`:

        def deps do
          [{:easy_breadcrumbs, git: "https://github.com/nerboda/phoenix_easy_breadcrumbs"}]
        end

  2. Ensure easy_breadcrumbs is started before your application:

        def application do
          [applications: [:easy_breadcrumbs]]
        end
  3. Add the following function to your layout view:

        def easy_breadcrumbs(conn) do
          if conn do
            YourApp.Router.Helpers.url(conn) <> conn.request_path
            |> EasyBreadcrumbs.breadcrumbs
            |> raw
          end
        end

  Make sure you change the `YourApp` to the name of your app.

  4. Add the following code in your layout template:

        <%= easy_breadcrumbs(@conn) %>

  That's it!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nerboda/phoenix_easy_breadcrumbs.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

