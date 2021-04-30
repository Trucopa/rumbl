defmodule Rumbl.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string
    has_many :videos, Rumbl.Videos.Video

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ :empty) do
    user
    |> cast(attrs, [:name, :username], [])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end

  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password], [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))
      _ ->
        changeset
    end
  end
end
