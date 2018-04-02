# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasks3.Repo.insert!(%Tasks3.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seeds do
  alias Tasks3.Repo
  alias Tasks3.Users.User
  alias Tasks3.Tasks.Task

  # Taken from Nat's lecture notes
  def run do
    p = Comeonin.Argon2.hashpwsalt("password1")

    Repo.delete_all(User)
    a = Repo.insert!(%User{
      email: "alice@test.com",
      name: "Alice",
      password_hash: p
    })
    b = Repo.insert!(%User{
      email: "bob@test.com",
      name: "Bob",
      password_hash: p
    })
    c = Repo.insert!(%User{
      email: "carol@test.com",
      name: "Carol",
      password_hash: p
    })
    d = Repo.insert!(%User{
      email: "dave@test.com",
      name: "Dave",
      password_hash: p
    })

    Repo.delete_all(Task)
    Repo.insert!(%Task{
      title: "Alice Example",
      description: "Make a task for Alice",
      completed: true,
      time_spent: 15,
      user_id: a.id
    })
    Repo.insert!(%Task{
      title: "Bob Example",
      description: "Make a task for Bob",
      completed: true,
      time_spent: 30,
      user_id: b.id
    })
    Repo.insert!(%Task{
      title: "Bob Example Again",
      description: "Make another task for Bob",
      completed: false,
      time_spent: 0,
      user_id: b.id
    })
    Repo.insert!(%Task{
      title: "Carol Example",
      description: "Make a task for Carol",
      completed: false,
      time_spent: 0,
      user_id: c.id
    })
    Repo.insert!(%Task{
      title: "Dave Example",
      description: "Make a task for Dave",
      completed: true,
      time_spent: 45,
      user_id: d.id
    })
  end
end

Seeds.run
