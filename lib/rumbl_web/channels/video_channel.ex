defmodule RumblWeb.VideoChannel do
  use RumblWeb, :channel

  def join("videos:" <> video_id, _params, socket) do
    {:ok, socket}
    # sockets will hold all of the state for a given conversation
  end

  def handle_in("new_annotation", params, socket) do
    broadcast!(socket, "new_annotation", %{ #filter params to restrict unwanted messages from client
      user: %{username: "anon"},
      body: params["body"],
      at: params["at"]
    })

    {:reply, :ok, socket}
  end
end

# We extract the video ID using pattern matching: "videos:" <> video_id will match
# all topics starting with "videos:" and assign the rest of the topic to the video_id variable.

# Controllers process a request. Channels hold a conversation.
