defmodule RumblWeb.VideoChannel do
  use RumblWeb, :channel

  def join("videos:" <> video_id, _params, socket) do
    :timer.send_interval(5_000, :ping)
    {:ok, socket}
    # sockets will hold all of the state for a given conversation
  end

  def handle_info(:ping, socket) do
    count = socket.assigns[:count] || 1
    push(socket, "ping", %{count: count})

    {:noreply, assign(socket, :count, count + 1)} #:noreply means we’re not sending a reply
  end
end

# We extract the video ID using pattern matching: "videos:" <> video_id will match
# all topics starting with "videos:" and assign the rest of the topic to the video_id variable.

# Controllers process a request. Channels hold a conversation.
