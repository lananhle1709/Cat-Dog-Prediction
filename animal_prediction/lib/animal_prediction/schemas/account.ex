defmodule AnimalPrediction.Account do
  use Ecto.Schema

  schema "accounts" do
    field :user_name, :string
    field :password, :string

    has_many :predictions, AnimalPrediction.Prediction

    timestamps()
  end
end
