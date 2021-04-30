defmodule Rumbl.Videos.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :url, :string
    field :description, :string
    field :title, :string
    #field :user_id, :id
    belongs_to :user, Rumbl.Users.User

    timestamps()
  end

  @doc false
  def changeset(video, attrs \\ :empry) do
    video
    |> cast(attrs, [:url, :title, :description], [])
    |> validate_required([:url, :title, :description])
  end
end
